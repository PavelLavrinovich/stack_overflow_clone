require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  describe 'POST #create' do
    sign_in_user { before { @user = answer.user } }
    context 'with valid attributes' do
      it 'saves the answer for the question' do
        expect { post :create, question_id: question, answer: attributes_for(:answer), format: :js }.
            to change(question.answers, :count).by(1)
      end

      it 'saves the answer for the user' do
        expect { post :create, question_id: question, answer: attributes_for(:answer), format: :js }.
            to change(@user.answers, :count).by(1)
      end

      it 'redirects to question show view' do
        post :create, question_id: question, answer: attributes_for(:answer), format: :js
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js }.
            to_not change(Answer, :count)
      end

      it 'renders create view' do
        post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do
    context 'like an author' do
      sign_in_user { before { @user = answer.user } }

      context 'with valid attributes' do
        it 'assigns the requested answer to @answer' do
          patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
          expect(assigns(:answer)).to eq answer
        end

        it 'changes answer attributes' do
          patch :update, id: answer, question_id: question, answer: { body: 'new body' }, format: :js
          answer.reload
          expect(answer.body).to eq 'new body'
        end

        it 'renders update view' do
          patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
          expect(response).to render_template :update
        end
      end

      context 'with invalid attributes' do
        before do
          patch :update, id: answer, question_id: question, answer: attributes_for(:invalid_answer), format: :js
        end

        it 'does not change question attributes' do
          answer.reload
          expect(answer.body).to_not eq nil
        end

        it 'renders update view' do
          expect(response).to render_template :update
        end
      end
    end

    context 'like an another user' do
      before { patch :update, id: answer, question_id: question, answer: { body: 'new body' }, format: :js }

      it 'does not change answer attributes' do
        answer.reload
        expect(answer.body).to_not eq 'new body'
      end

      it 'renders update view' do
        expect(response).to_not render_template :update
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'like an author' do
      sign_in_user { before { @user = answer.user } }

      it 'deletes the answer' do
        expect { delete :destroy, id: answer, question_id: answer.question, format: :js }.
            to change(@user.answers, :count).by(-1)
      end

      it 'renders delete view' do
        delete :destroy, id: answer, question_id: answer.question, format: :js
        expect(response).to render_template :destroy
      end
    end

    context 'like an another user' do
      sign_in_user
      before { answer }

      it 'does not delete the answer' do
        expect { delete :destroy, id: answer, question_id: answer.question, format: :js }.to_not change(Answer, :count)
      end

      it 'render question show view' do
        delete :destroy, id: answer, question_id: answer.question, format: :js
        expect(response).to render_template :destroy
      end
    end
  end

end
