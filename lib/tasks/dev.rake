namespace :dev do

  DEFAULT_PASSWORD = 123456
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Dropando o BD") { %x(rails db:drop) }
      show_spinner("Criando o BD") { %x(rails db:create) }
      show_spinner("Migrando o BD") { %x(rails db:migrate) }
      show_spinner("Adicionando o administrador padrão") { %x(rails dev:add_default_admin) }
      show_spinner("Adicionando os administradores extras") { %x(rails dev:add_extra_admin) }
      show_spinner("Adicionando o usuário padrão") { %x(rails dev:add_default_user) }
      show_spinner("Adicionando assuntos padrões") { %x(rails dev:add_subjects) }
      show_spinner("Adicionando as questões padrões") { %x(rails dev:add_questions) }
    else
      puts "Você não está em ambiente de desenvolvimento."
    end
  end

  desc "Adiciona o administrador padrão..."
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adiciona administradores extras..."
  task add_extra_admin: :environment do
    10.times do |i|
      Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
    end
  end

  desc "Adiciona o usuário padrão..."
  task add_default_user: :environment do
    User.create!(
      email: 'user@user.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adiciona assuntos padrões"
  task add_subjects: :environment do
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)

    File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip)
    end
  end

  desc "Adiciona questões"
  task add_questions: :environment do
    Subject.all.each do |subject|
      rand(1..2).times do |i|

        # Criando o parametro da question
        params = create_questions_params(subject)
        answers_array = params[:question][:answers_attributes]

        # Criando as respostas dinamicamente
        add_answers(answers_array)

        # Selecionando a resposta correta
        elect_true_answer(answers_array)
        
        #Criando a questão
        Question.create!(params[:question])
      end
    end
  end

  private

  def create_questions_params(subject = Subject.all.sample)
    { question: {
          description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
          subject: subject,
          answers_attributes: []
      }
    }
  end

  def create_answers_params(correct = false)
    { description: Faker::Lorem.sentence, correct: correct }
  end

  def add_answers(answers_array = [])
    rand(3..5).times do |j|
      answers_array.push(
        create_answers_params
      )
    end
  end

  def elect_true_answer(answers_array)
    selected_index = rand(answers_array.size)
    answers_array[selected_index] = create_answers_params(true)
  end

  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
