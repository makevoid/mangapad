class Notifier < ActionMailer::Base
  RECIPIENTS_MAIN = "makevoid@gmail.com"
  
  default :from => "mangapadapp@gmail.com"
  
  def submission_notification(submission)
    mail(:to => RECIPIENTS_MAIN,
         :subject => "MangaPad: new submission by #{submission.email} for #{submission.name} ") do |format|
     format.html { render :text => "<h2>MangaPad - new submission</h2><h3>from: #{submission.email}, for the manga: #{submission.name}</h3>
     <p>chapters_url: #{submission.chapters_url}</p>
     <p>first_page_url: #{submission.first_page_url}</p>
      " }
    end
  end
end

