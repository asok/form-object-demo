require "rails_helper"

RSpec.describe QuickRegistrationsController do
  render_views

  describe '#new' do
    it 'renders the new page' do
      get :new
      expect(response.body).to include('form')
    end
  end

  describe '#create' do
    before { post :create, user: attributes }

    context 'the data is valid' do
      let(:attributes) do
        {email: "foo@bar.org", password: "pass", password_confirmation: "pass"}
      end

      it{ expect(User.find_by_email(attributes[:email])).to_not be_nil }
    end

    context 'the data is invalid' do
      let(:attributes) do
        {email: "foo@bar.org", password: "pass", password_confirmation: "ssap"}
      end

      it{ expect(User.find_by_email(attributes[:email])).to be_nil }
      it{ expect(response.body).to include("doesn&#39;t match Password") }
    end
  end
end
