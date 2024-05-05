# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let(:normal_user) { FactoryBot.create(:user, :normal_user) }
  let(:moderator_user) { FactoryBot.create(:user, :moderator) }
  let(:admin_user) { FactoryBot.create(:user, :admin) }
  let!(:user_article) { FactoryBot.create(:article, user_id: normal_user.id) }
  let!(:moderator_article) { FactoryBot.create(:article, user_id: moderator_user.id) }
  let!(:admin_article) { FactoryBot.create(:article, user_id: admin_user.id) }

  describe 'GET#index' do
    context 'when logged in' do
      context 'Normal user' do
        it 'should show articles index page' do
          sign_in normal_user
          get :index
          expect(assigns(:user_articles)).to eq(normal_user.articles)
          expect(response).to have_http_status(:ok)
        end
      end
      context 'Moderator' do
        it 'should show articles index page' do
          sign_in moderator_user
          get :index
          expect(assigns(:user_articles)).to eq(moderator_user.articles)
          expect(response).to have_http_status(:ok)
        end
      end
      context 'admin' do
        it 'should show articles index page' do
          sign_in admin_user
          get :index
          expect(assigns(:user_articles)).to eq(admin_user.articles)
          expect(response).to have_http_status(:ok)
        end
      end
    end

    context 'when logged out' do
      context 'Normal user' do
        it 'should be login to access index page' do
          sign_out normal_user
          get :index
          expect(flash[:alert]).to match('Please login to perform this action.') # flash message
          expect(response).to redirect_to(new_user_session_path)
        end
      end
      context 'moderator' do
        it 'should be login to access index page' do
          sign_out moderator_user
          get :index
          expect(flash[:alert]).to match('Please login to perform this action.')
          expect(response).to redirect_to(new_user_session_path)
        end
      end
      context 'admin' do
        it 'should be login to access index page' do
          sign_out admin_user
          get :index
          expect(flash[:alert]).to match('Please login to perform this action.')
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end
  end

  describe 'GET#new' do
    context 'when logged in' do
      context 'Normal user' do
        it 'renders the new template' do
          sign_in normal_user
          get :new
          expect(response).to have_http_status(:ok)
        end
      end
      context 'moderator' do
        it 'renders the new template' do
          sign_in moderator_user
          get :new
          expect(response).to have_http_status(:ok)
        end
      end
      context 'admin user' do
        it 'renders the new template' do
          sign_in admin_user
          get :new
          expect(response).to have_http_status(:ok)
        end
      end
    end

    context 'when logged out' do
      context 'Normal user' do
        it 'should login to create article' do
          sign_out normal_user
          get :new
          expect(flash[:alert]).to match('Please login to perform this action.')
          expect(response).to redirect_to(new_user_session_path)
        end
      end
      context 'moderator' do
        it 'should login to create article' do
          sign_out moderator_user
          get :new
          expect(flash[:alert]).to match('Please login to perform this action.')
          expect(response).to redirect_to(new_user_session_path)
        end
      end
      context 'admin' do
        it 'should login to create article' do
          sign_out admin_user
          get :new
          expect(flash[:alert]).to match('Please login to perform this action.')
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end
  end

  describe 'GET#show' do
    context 'when logged in' do
      context 'Normal user' do
        it 'render article show page' do
          sign_in normal_user
          get :show, params: { id: user_article.id }
          expect(response).to have_http_status('200')
          expect(response).to render_template(:show)
        end
      end
      context 'moderator' do
        it 'render article show page' do
          sign_in moderator_user
          get :show, params: { id: moderator_article.id }
          expect(response).to have_http_status('200')
          expect(response).to render_template(:show)
        end
      end
      context 'admin' do
        it 'render article show page' do
          sign_in admin_user
          get :show, params: { id: admin_article.id }
          expect(response).to have_http_status('200')
          expect(response).to render_template(:show)
        end
      end
      context 'Normal user' do
        it 'responds with 404 for show article' do
          sign_in normal_user
          get :show, params: { id: -1 }
          expect(flash[:alert]).to match('Record not found')
          expect(response).to render_template(file: '404.html')
        end
      end
      context 'moderator' do
        it 'responds with 404 for show article' do
          sign_in moderator_user
          get :show, params: { id: -1 }
          expect(flash[:alert]).to match('Record not found')
          expect(response).to render_template(file: '404.html')
        end
      end
      context 'admin' do
        it 'responds with 404 for show article' do
          sign_in admin_user
          get :show, params: { id: -1 }
          expect(flash[:alert]).to match('Record not found')
          expect(response).to render_template(file: '404.html')
        end
      end
    end
    context 'when logged out' do
      context 'normal user' do
        it 'Article found' do
          sign_out normal_user
          get :show, params: { id: user_article.id }
          expect(response).to have_http_status('200')
          expect(response).to render_template(:show)
        end
      end
      context 'moderator' do
        it 'article found' do
          sign_out moderator_user
          get :show, params: { id: moderator_article.id }
          expect(response).to have_http_status('200')
          expect(response).to render_template(:show)
        end
      end
      context 'admin' do
        it 'article found' do
          sign_out admin_user
          get :show, params: { id: admin_article.id }
          expect(response).to have_http_status('200')
          expect(response).to render_template(:show)
        end
      end
      context 'normal user' do
        it 'responds with 404 with invalid params' do # msg
          sign_out normal_user
          get :show, params: { id: -1 }
          expect(flash[:alert]).to match('Record not found')
          expect(response).to render_template(file: '404.html')
        end
      end
      context 'moderator' do
        it 'responds with 404 with invalid params' do
          sign_out moderator_user
          get :show, params: { id: -1 }
          expect(flash[:alert]).to match('Record not found')
          expect(response).to render_template(file: '404.html')
        end
      end
      context 'admin' do
        it 'responds with 404 with invalid params' do
          sign_out admin_user
          get :show, params: { id: -1 }
          expect(flash[:alert]).to match('Record not found')
          expect(response).to render_template(file: '404.html')
        end
      end
    end
  end

  describe 'POST#create' do
    context 'when logged in' do
      context 'Normal user' do
        it 'create article with valid params' do
          sign_in normal_user
          expect do
            post :create,
                 params: { article: { title: 'Lorem ipsum dolor.', description: 'Eos amet internos id alias.' } }
          end.to change { Article.count }.by(1)
          expect(flash[:notice]).to match('Article Uploaded Successfully.')
        end
      end
      context 'moderator' do
        it 'create article with valid params' do
          sign_in moderator_user
          expect do
            post :create,
                 params: { article: { title: 'Lorem ipsum dolor.', description: 'Eos amet internos id alias.' } }
          end.to change { Article.count }.by(1)
          expect(flash[:notice]).to match('Article Uploaded Successfully.')
        end
      end
      context 'admin' do
        it 'create article with valid params' do
          sign_in admin_user
          expect do
            post :create,
                 params: { article: { title: 'Lorem ipsum dolor.', description: 'Eos amet internos id alias.' } }
          end.to change { Article.count }.by(1)
          expect(flash[:notice]).to match('Article Uploaded Successfully.')
        end
      end
      context 'Normal user' do
        it 'Article cannot create due to invalid params' do
          sign_in normal_user
          post :create, params: { article: { title: 'a' } }
          expect(response).to render_template(:new)
        end
      end
      context 'moderator' do
        it 'Article cannot create due to invalid params' do
          sign_in moderator_user
          post :create, params: { article: { title: 'a' } }
          expect(response).to render_template(:new)
        end
      end
      context 'admin' do
        it 'Article cannot create due to invalid params' do
          sign_in admin_user
          post :create, params: { article: { title: 'a' } }
          expect(response).to render_template(:new)
        end
      end
    end
    context 'when logged out' do
      context 'Normal user' do
        it 'should be login to create article' do
          sign_out normal_user
          post :create,
               params: { article: { title: 'Lorem ipsum dolor.', description: 'Eos amet internos id alias.' } }
          expect(flash[:alert]).to match('Please login to perform this action.')
          expect(response).to redirect_to(new_user_session_path)
        end
      end
      context 'moderator' do
        it 'should be login to create article' do
          sign_out moderator_user
          post :create,
               params: { article: { title: 'Lorem ipsum dolor.', description: 'Eos amet internos id alias.' } }
          expect(flash[:alert]).to match('Please login to perform this action.')
          expect(response).to redirect_to(new_user_session_path)
        end
      end
      context 'admin' do
        it 'should be login to create article' do # it block message
          sign_out admin_user
          post :create,
               params: { article: { title: 'Lorem ipsum dolor.', description: 'Eos amet internos id alias.' } }
          expect(flash[:alert]).to match('Please login to perform this action.')
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end
  end

  describe 'PATCH#update' do
    context 'when logged in' do
      context 'Normal user' do
        it 'article update with valid params' do
          sign_in normal_user
          patch :update,
                params: { id: user_article.id,
                          article: { title: 'Lorem Ipsum is simply dummy',
                                     description: 'Lorem ipsum dolor sit amet.' } }
          expect(flash[:alert]).to match('Article is Updated successfully.')
        end
        it 'normal user cannot update other user article' do
          sign_in normal_user
          patch :update,
                params: { id: admin_article.id,
                          article: { title: 'Lorem Ipsum is simply dummy',
                                     description: 'Lorem ipsum dolor sit amet.' } }
          expect(flash[:alert]).to match('You are not authorized to perform this action.')
          expect(response).to redirect_to(root_path)
        end
      end
      context 'moderator' do
        it 'article update with valid params' do
          sign_in moderator_user
          patch :update,
                params: { id: moderator_article.id,
                          article: { title: 'Lorem Ipsum is simply dummy',
                                     description: 'Lorem ipsum dolor sit amet.' } }
          expect(flash[:alert]).to match('Article is Updated successfully.')
        end
      end
      context 'admin' do
        it 'article update with valid params' do
          sign_in admin_user
          patch :update,
                params: { id: admin_article.id,
                          article: { title: 'Lorem Ipsum is simply dummy',
                                     description: 'Lorem ipsum dolor sit amet.' } }
          expect(flash[:alert]).to match('Article is Updated successfully.')
        end
      end
      context 'Normal user' do
        it 'article not update with invalid params' do
          sign_in normal_user
          patch :update, params: { id: user_article.id, article: { title: 'Te', description: 'Eos amet internos.' } }
          expect(response).to redirect_to(root_path(user_article.id))
        end
      end
      context 'when moderator' do
        it 'article not update with invalid params' do
          sign_in moderator_user
          patch :update,
                params: { id: moderator_article.id, article: { title: 'Te', description: 'Eos amet internos.' } }
          expect(response).to redirect_to(root_path(moderator_article.id))
        end
      end
      context 'admin' do
        it 'article not update with invalid params' do
          sign_in admin_user
          patch :update, params: { id: admin_article.id, article: { title: 'Te', description: 'Eos amet internos.' } }
          expect(response).to redirect_to(root_path(admin_article.id))
        end
      end
      context 'Normal user' do
        it 'responds with 404 not found' do
          sign_in normal_user
          patch :update, params: { id: -1, article: { title: 'Te', description: 'Eos amet internos.' } }
          expect(response).to have_http_status('404')
          expect(response).to render_template(file: '404.html')
        end
      end
      context 'moderator' do
        it 'responds with 404 not found' do
          sign_in moderator_user
          patch :update, params: { id: -1, article: { title: 'Te', description: 'Eos amet internos.' } }
          expect(response).to have_http_status('404')
          expect(response).to render_template(file: '404.html')
        end
      end
      context 'admin' do
        it 'responds with 404 not found' do
          sign_in admin_user
          patch :update, params: { id: -1, article: { title: 'Te', description: 'Eos amet internos.' } }
          expect(response).to have_http_status('404')
          expect(response).to render_template(file: '404.html')
        end
      end
    end
    context 'when logged out' do
      context 'Normal user' do
        it 'should be login to update article' do
          sign_out normal_user
          patch :update,
                params: { id: user_article.id,
                          article: { title: 'Lorem Ipsum is simply dummy',
                                     description: 'Lorem ipsum dolor sit amet.' } }
          expect(flash[:alert]).to match('Please login to perform this action.')
          expect(response).to redirect_to(new_user_session_path)
        end
      end
      context 'moderator' do
        it 'should be login to update article' do
          sign_out moderator_user
          patch :update,
                params: { id: moderator_article.id,
                          article: { title: 'Lorem Ipsum is simply dummy',
                                     description: 'Lorem ipsum dolor sit amet.' } }
          expect(flash[:alert]).to match('Please login to perform this action.')
          expect(response).to redirect_to(new_user_session_path)
        end
      end
      context 'admin' do
        it 'should be login to update article' do
          sign_out admin_user
          patch :update,
                params: { id: admin_article.id,
                          article: { title: 'Lorem Ipsum is simply dummy',
                                     description: 'Lorem ipsum dolor sit amet.' } }
          expect(flash[:alert]).to match('Please login to perform this action.')
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when logged in' do
      context 'Normal user' do
        it 'delete your own the article' do
          sign_in normal_user
          expect { delete :destroy, params: { id: user_article.id } }.to change { Article.count }.by(-1)
          expect(flash[:notice]).to match('Article is deleted successfully.')
        end
        it 'normal user cant delete other user article' do
          sign_in normal_user
          delete :destroy, params: { id: admin_article.id }
          expect(flash[:alert]).to match('You are not authorized to perform this action.')
          expect(response).to redirect_to(root_path)
        end
      end
      context 'moderator' do
        it 'delete the article' do
          sign_in moderator_user
          expect { delete :destroy, params: { id: moderator_article.id } }.to change { Article.count }.by(-1)
          expect(flash[:notice]).to match('Article is deleted successfully.')
        end
      end
      context 'admin' do
        it 'delete the article' do
          sign_in admin_user
          expect { delete :destroy, params: { id: admin_article.id } }.to change { Article.count }.by(-1)
          expect(flash[:notice]).to match('Article is deleted successfully.')
        end
      end
      context 'Normal user' do
        it 'responds with 404' do
          sign_in normal_user
          delete :destroy, params: { id: -1 }
          expect(flash[:alert]).to match('Record not found')
          expect(response).to render_template(file: '404.html')
        end
      end
      context 'moderator' do
        it 'responds with 404' do
          sign_in moderator_user
          delete :destroy, params: { id: -1 }
          expect(flash[:alert]).to match('Record not found')
          expect(response).to render_template(file: '404.html')
        end
      end
      context 'admin' do
        it 'responds with 404' do
          sign_in admin_user
          delete :destroy, params: { id: -1 }
          expect(flash[:alert]).to match('Record not found')
          expect(response).to render_template(file: '404.html')
        end
      end
    end
    context 'when logged out' do
      context 'normal user' do
        it 'should be login to delete the article' do
          sign_out normal_user
          delete :destroy, params: { id: user_article.id }
          expect(flash[:alert]).to match('Please login to perform this action.')
          expect(response).to redirect_to(new_user_session_path)
        end
      end
      context 'moderator' do
        it 'should be login to delete the article' do
          sign_out moderator_user
          delete :destroy, params: { id: moderator_article.id }
          expect(flash[:alert]).to match('Please login to perform this action.')
          expect(response).to redirect_to(new_user_session_path)
        end
      end
      context 'admin' do
        it 'should be login to delete the article' do
          sign_out admin_user
          delete :destroy, params: { id: admin_article.id }
          expect(flash[:alert]).to match('Please login to perform this action.')
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end
  end
end
