class UserStatistic < ApplicationRecord
  belongs_to :user

  #Virtual Attributes
  def total_questions
    self.right_questions + self.wrong_questions
  end

  #Class Methods
  def self.set_statistic(answer, current_user)
    if !!current_user
      user_statistic = UserStatistic.find_or_create_by(user: current_user)
      answer.correct? ? user_statistic.increment!(:right_questions) : user_statistic.increment!(:wrong_questions)
      user_statistic.save
    end
  end
end
