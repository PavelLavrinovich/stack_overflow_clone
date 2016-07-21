require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer) }

  describe 'POST #create' do
    sign_in_user { before { @user = answer.user } }
    context 'with valid attributes' do
      it 'saves the answer for the question' do
        expect { post :create, question_id: question, answer: attributes_for(:answer) }.
            to change(question.answers, :count).by(1)
      end

      it 'saves the answer for the user' do
        expect { post :create, question_id: question, answer: attributes_for(:answer) }.
            to change(@user.answers, :count).by(1)
      end

      it 'redirects to question show view' do
        post :create, question_id: question, answer: attributes_for(:answer)
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, question_id: question, answer: attributes_for(:invalid_answer) }.
            to_not change(Answer, :count)
      end

      it 'renders new view' do
        post :create, question_id: question, answer: attributes_for(:invalid_answer)
        expect(response).to render_template 'questions/show'
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'like an author' do
      sign_in_user { before { @user = answer.user } }

      it 'deletes the answer' do
        expect { delete :destroy, id: answer, question_id: answer.question }.to change(@user.answers, :count).
            by(-1)
      end

      it 'redirects to index view' do
        delete :destroy, id: answer, question_id: answer.question
        expect(response).to redirect_to question_path(answer.question)
      end
    end

    context 'like an another user' do
      sign_in_user
      before { answer }

      it 'does not delete the answer' do
        expect { delete :destroy, id: answer, question_id: answer.question }.to_not change(Answer, :count)
      end

      it 'render question show view' do
        delete :destroy, id: answer, question_id: answer.question
        expect(response).to render_template 'questions/show'
      end
    end
  end

end
