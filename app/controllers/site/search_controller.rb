class Site::SearchController < SiteController
  before_action :get_subjects, only: [:subject, :questions]

  def questions
    @questions = Question.search(params[:page], params[:term])
  end

  def subject
    @questions = Question.search_subject(params[:page], params[:question][:subject_id])
  end

  private
 
  def get_subjects
    @subjects = Subject.all
    if params[:question] && params[:question][:subject_id].present?
      @selected_subject = Subject.find_by(id: params[:question][:subject_id])
    end
  end
end
