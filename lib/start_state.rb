require_relative 'window_state'
require_relative 'multiverse_state'

class StartState < WindowState

  def initialize window
    super

    @title = Gosu::Image.from_text @window, "No Hawking", Gosu::default_font_name, 50
    @title_x = @window.width/2-@title.width/2
    @title_y = 150

    @previous_menu = []
    @menu = [
      ["Start Game", -> {
        start_game
        # @window.change_state(:ingame)
      }],
      ["Options", -> {
        change_menu(
        [
          ["Gameplay", -> { puts "Gameplay!" }],
          ["Controls", -> { puts "Controls!" }],
          ["Audio", -> { puts "Audio!" }],
          ["Video", -> { puts "Video!" }],
          ["Back", -> { go_back }]
        ])
      }],
      ["Quit", -> {
        puts "Bye bye!"
        @window.close
      }]
    ]
    @selected = 0

    @menu_images = generate_menu_images @menu
    @selector_image = Gosu::Image.from_text @window, ">", Gosu::default_font_name, 30

    @menu_x = 50
    @menu_y = @title_y+100
    @menu_dy = 50
  end

  def change_menu new_menu
    @selected = 0
    @previous_menu.push @menu
    @menu = new_menu
    @menu_images = generate_menu_images @menu
  end

  def go_back
    @selected = 0
    @menu = @previous_menu.pop
    @menu_images = generate_menu_images @menu
  end

  def start_game
    @window.add_state(:worlds,MultiverseState.new(@window))
           .change_state(:worlds)
  end

  def generate_menu_images menu
    menu.map do |s|
      Gosu::Image.from_text @window, s.first, Gosu::default_font_name, 30
    end
  end

  def button_down id
    case id
    when Gosu::KbUp
      @selected = (@selected-1) % @menu.size
    when Gosu::KbDown
      @selected = (@selected+1) % @menu.size
    when Gosu::KbEscape
      @menu.last.last.()
    when Gosu::KbEnter, Gosu::KbReturn
      @menu[@selected].last.()
    end
  end

  def update
  end

  def draw
    @title.draw @title_x, @title_y, 0

    offset = 0
    @menu_images.each do |i|
      i.draw @menu_x, @menu_y+offset, 0
      offset += @menu_dy
    end

    @selector_image.draw @menu_x-@selector_image.width, @menu_y+@selected*@menu_dy, 0
  end

end