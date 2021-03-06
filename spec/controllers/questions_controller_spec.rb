require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, id: question }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns a new Answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'builds a new attachment for the answer' do
      expect(assigns(:answer).attachments.first).to be_a_new(Attachment)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in_user
    before { get :new }

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'builds a new attachment for the question' do
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end


  describe 'POST #create' do
    sign_in_user { before { @user = question.user } }
    context 'with valid attributes' do
      it 'saves the question' do
        expect { post :create, question: attributes_for(:question) }.to change(question.user.questions, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
      end

      it 'renders new view' do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'like an author' do
      sign_in_user { before { @user = question.user } }
      context 'with valid attributes' do
        it 'assigns the requested question to @question' do
          patch :update, id: question, question: attributes_for(:question), format: :js
          expect(assigns(:question)).to eq question
        end

        it 'changes question attributes' do
          patch :update, id: question, question: { title: 'new title', body: 'new body'}, format: :js
          question.reload
          expect(question.title).to eq 'new title'
          expect(question.body).to eq 'new body'
        end

        it 'renders update view' do
          patch :update, id: question, question: attributes_for(:question), format: :js
          expect(response).to render_template :update
        end
      end

      context 'with invalid attributes' do
        before { patch :update, id: question, question: attributes_for(:invalid_question), format: :js }

        it 'does not change question attributes' do
          question.reload
          expect(question.title).to_not eq nil
          expect(question.body).to_not eq nil
        end

        it 'renders edit view' do
          expect(response).to render_template :update
        end
      end
    end

    context 'like an another user' do
      sign_in_user
      before { patch :update, id: question, question: { title: 'new title', body: 'new_body'}, format: :js }

      it 'does not change question attributes' do
        question.reload
        expect(question.title).to_not eq 'new title'
        expect(question.body).to_not eq 'new body'
      end

      it 'renders update view' do
        expect(response).to render_template :update
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'like an author' do
      sign_in_user { before { @user = question.user } }

      it 'deletes the question' do
        expect { delete :destroy, id: question }.to change(question.user.questions, :count).by(-1)
      end

      it 'redirects to index view' do
        delete :destroy, id: question
        expect(response).to redirect_to questions_path
      end
    end

    context 'like an another user' do
      sign_in_user
      before { question }

      it 'does not delete the question' do
        expect { delete :destroy, id: question }.to_not change(Question, :count)
      end

      it 'renders show view' do
        delete :destroy, id: question
        expect(response).to render_template :show
      end
    end
  end

end
