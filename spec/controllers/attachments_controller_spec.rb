require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let(:question) { create(:question) }
  let(:attachment) { create(:attachment, attachable: question) }

  describe 'DELETE #destroy' do
    context 'like an author' do
      sign_in_user { before { @user = question.user } }
      before { attachment }

      it 'deletes the attachment' do
        expect { delete :destroy, id: attachment, format: :js }.to change(question.attachments, :count).by(-1)
      end

      it 'renders delete view' do
        delete :destroy, id: attachment, format: :js
        expect(response).to render_template :destroy
      end
    end

    context 'like an another user' do
      sign_in_user
      before { attachment }

      it 'does not delete the attachment' do
        expect { delete :destroy, id: attachment, format: :js }.to_not change(Attachment, :count)
      end

      it 'renders a delete view' do
        delete :destroy, id: attachment, format: :js
        expect(response).to render_template :destroy
      end
    end
  end
end