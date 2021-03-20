class ParticipantMailer < ApplicationMailer
    def new_task_email
        @user = params[:user]
        @task = params[:task]
        mail to: @user, subject: 'Tarea asignada'
    end
end
