# La clase Router recible la acción que quiere el usuario y en base a la elección del usuario se ejecuta el juego elegido

class Router
  def initialize(controller)
    @controller = controller
    @running    = true
  end

  def run
    puts "Welcome to the Chipax-Recruiting Test!"
    puts "           --           "

    while @running
      display_tasks
      action = gets.chomp.to_i
      print `clear`
      route_action(action)
    end
  end

  private

  def route_action(action)
    case action
    when 1 then @controller.char_counter
    when 2 then @controller.episode_counter
    when 3 then stop
    else
      puts "Please press 1, 2 or 3"
    end
  end

  def stop
    @running = false
  end

  def display_tasks
    puts ""
    puts "What exercice you want to do next?"
    puts "1 - Char Counter"
    puts "2 - Episode locations"
    puts "3 - Exit"
  end
end
