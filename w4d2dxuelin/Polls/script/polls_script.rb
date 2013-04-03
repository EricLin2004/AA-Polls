
class ConsoleInterface
  def initialize
  end

  def play
    set_user
    menu
  end
  def set_user
    puts "Please enter your username"
    username = gets.chomp
    @user = User.find_by_name(username)
    @user = User.create(:name => username, :team_id => nil) if @user.nil?
  end

  def menu
    puts "Please select one of the following options"
    puts "1. Create a new poll"
    puts "2. Take an existing poll"
    puts "3. Switch users"
    puts "4. Poll results"
    puts "5. User history"
    puts "6. Quit"
    case gets.chomp.to_i
    when 1 then create_poll
    when 2 then take_poll
    when 3 then set_user
    when 4 then print_poll_results
    when 5 then user_history
    when 6 then return nil
    end
    menu
  end

  def user_history
    puts "Choose one of the options:"
    puts "1. View created polls"
    puts "2. View polling history"
    puts "3. Quit"
    case gets.chomp.to_i
    when 1 then user_polls
    when 2 then user_poll_history
    when 3 then return nil
    end
    user_history
  end

  def user_poll_history
    history = @user.history
    print_stats(history)
  end

  def print_stats(results)
    questions = Question.all
    choices = Choice.all
    previous_text = ""
    results.each do |key, freq|
      current_text = questions[key[1]-1].body
      puts "Question: #{current_text}" unless previous_text == current_text
      previous_text = questions[key[1]-1].body
      puts choices[key[0]-1].answer
      puts "Frequency: #{freq}\n\n"
    end
  end

  def user_polls
    Poll.where(:creator_id => @user.id).map { |poll| puts poll.title }
  end

  def print_poll_results
    puts "Choose a poll"
    polls = Poll.all#where(:creator_id => @user.id)
    polls.each_with_index do |poll, ind|
      puts "#{ind + 1}. #{poll.title}"
    end

    user_input = gets.chomp.to_i - 1
    poll = polls[user_input]
    results = poll.results
    print_stats(results)
  end

  def create_poll
    puts "Please select a title for your poll"
    @current_poll = @user.create_poll(gets.chomp)
    modify_poll
  end

  def modify_poll
    puts "Please continue modifying this poll:"
    puts "1. Add a new question"
    puts "2. Modify an existing question"
    puts "3. Quit."
    case gets.chomp.to_i
    when 1 then add_question
    when 2 then puts #Stuff
    when 3
      @current_poll = nil
      return nil
    end
    modify_poll
  end

  def take_poll
    puts "Choose an existing poll from list:"
    polls = Poll.all
    polls.each_with_index do |poll, ind|
      puts "#{ind + 1}. #{poll.title}"
    end
    poll_id = polls[gets.chomp.to_i-1].id

    begin
      response = PollHistory.new(:poll_id => poll_id, :voter_id => @user.id)
      response.save!
    rescue
      puts "Invalid choice"#errors.full_messages
      return nil
    end

    questions = Question.includes(:poll).where(:poll_id => poll_id)

    questions.each do |question|
      answer(question)
    end
  end
  def answer(question)
    puts question.body
    puts "Choose one of the following responses:"
    choices = question.choices
    choices.each_with_index do |choice, ind|
      puts "#{ind + 1}. #{choice.answer}"
    end
    choice_id = gets.chomp.to_i - 1
    until (0...choices.count).include?(choice_id)
      puts "Please put a valid choice."
      choice_id = gets.chomp.to_i - 1
    end

    Response.create(:choice_id => choices[choice_id].id, :voter_id => @user.id)
  end

  def add_question
    puts "Please add a question to this poll:"
    @current_question = @current_poll.
                          add_question(gets.chomp)
    add_choice
  end

  def add_choice
    puts "Please add choices for this question:"
    puts "Or enter 'QUIT' to quit out of this selection"
    input = gets.chomp
    case input
    when 'QUIT'
      @current_question = nil
      return nil
    else
      @current_question.add_choice(input)
    end
    add_choice
  end
end

interface = ConsoleInterface.new
interface.play
