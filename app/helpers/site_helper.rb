module SiteHelper
  def msg_jumbotron
    case params[:action]
    when 'index'
      "Seja bem-vindo, abaixo você pode consultar todas as perguntas cadastradas em nosso site."
    when 'questions'
      "Resultados para a pesquisa do termo: \"#{params[:term]}\""
    when 'subject'
      "Filtrando as questões do assunto: \"#{ @selected_subject.description }\""
    end
  end
end