# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:normal_user) { FactoryBot.create(:user, :normal_user) }
  let(:moderator_user) { FactoryBot.create(:user, :moderator) }
  let(:admin_user) { FactoryBot.create(:user, :admin) }
  let(:article) { FactoryBot.create(:article, user_id: normal_user.id) }
  let!(:comment) { FactoryBot.create(:comment, article_id: article.id) }

  describe 'POST#create' do
    context 'when logged in' do
      context 'Normal user' do
        it 'should creates a comment' do
          sign_in normal_user
          expect do
            post :create,
                 params: { comment: { comment_body: 'Test comment body' }, article_id: article.id,
                           user_id: normal_user.id }
          end.to change { Comment.count }.by(1)
          expect(flash[:notice]).to match('Commented successfully')
        end
      end
      context 'moderator' do
        it 'should creates a comment' do
          sign_in moderator_user
          expect do
            post :create,
                 params: { comment: { comment_body: 'Test comment body' }, article_id: article.id,
                           user_id: moderator_user.id }
          end.to change { Comment.count }.by(1)
          expect(flash[:notice]).to match('Commented successfully')
        end
      end
      context 'admin' do
        it 'should creates a comment' do
          sign_in admin_user
          expect do
            post :create,
                 params: { comment: { comment_body: 'Test comment body' }, article_id: article.id,
                           user_id: admin_user.id }
          end.to change { Comment.count }.by(1)
          expect(flash[:notice]).to match('Commented successfully')
        end
      end
      context 'Normal user' do
        it 'cant create a comment with invalid params' do
          sign_in normal_user
          post :create, params: { comment: { comment_body: '' }, article_id: article.id, user_id: normal_user.id }
          expect(flash[:notice]).to match('Comment not created')
        end
      end
      context 'admin' do
        it 'cant create a comment with invalid params' do
          sign_in admin_user
          post :create, params: { comment: { comment_body: '' }, article_id: article.id, user_id: moderator_user.id }
          expect(flash[:notice]).to match('Comment not created')
        end
      end
      context 'moderator' do
        it 'cant create a comment with invalid params' do
          sign_in moderator_user
          post :create, params: { comment: { comment_body: '' }, article_id: article.id, user_id: admin_user.id }
          expect(flash[:notice]).to match('Comment not created')
        end
      end
    end
    context 'when logged out' do
      context 'normal user' do
        it 'should be logged in to create comment' do
          sign_out normal_user
          post :create, params: { comment: { comment_body: 'Test comment body' }, article_id: article.id }
          expect(flash[:alert]).to match('Please login to perform this action.')
          expect(response).to redirect_to(new_user_session_path)
        end
      end
      context 'moderator' do
        it 'should be logged in to create comment' do
          sign_out moderator_user
          post :create, params: { comment: { comment_body: 'Test comment body' }, article_id: article.id }
          expect(flash[:alert]).to match('Please login to perform this action.')
          expect(response).to redirect_to(new_user_session_path)
        end
      end
      context 'admin' do
        it 'should be logged in to create comment' do
          sign_out admin_user
          post :create, params: { comment: { comment_body: 'Test comment body' }, article_id: article.id }
          expect(flash[:alert]).to match('Please login to perform this action.')
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end
  end
end
