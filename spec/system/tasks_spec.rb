# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  let(:user) { create(:user) }

  before(:each) { sign_in user }

  describe 'GET /tasks' do
    it 'has a correct title' do
      visit '/tasks'
      expect(page).to have_content('Lista de Tareas')
    end
  end

  describe 'POST /tasks/new' do
    let!(:category) { create(:category) }
    let!(:participant) { create(:user) }

    it 'should have a form', js: true do
      visit '/tasks/new'

      fill_in('task[name]', with: 'Test')
      fill_in('task[description]', with: 'Test')
      fill_in('task[due_date]', with: Time.zone.today + 5.days)
      select(category.name, from: 'task_category_id')

      click_on 'Agregar un participante'

      xpath = '//*[@id="addParticipants"]/div/div[1]'
      within(:xpath, xpath) do
        select(participant.email, from: 'Usuario')
        select('responsible', from: 'Rol')
      end

      click_button 'Create Task'
      expect(page).to have_content('Task was successfully created.')
    end
  end
end
