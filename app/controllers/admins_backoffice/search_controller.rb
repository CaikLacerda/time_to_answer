class AdminsBackoffice::SearchController < AdminsBackofficeController
  def questions
    def questions
      @questions = Question.search(params[:page], params[:term])
    end
  end
end
