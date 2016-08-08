require "rails_helper"

RSpec.describe FullRegistrationsController do
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
        {
          email: "foo@bar.org",
          password: "pass",
          password_confirmation: "pass",
          terms_accepted: "1",
          date_of_birth: Date.yesterday.to_s
        }
      end

      it{ expect(User.find_by_email(attributes[:email])).to_not be_nil }
    end

    context 'the data is invalid' do
      let(:attributes) do
        {
          email: "foo@bar.org",
          password: "pass",
          password_confirmation: "ssap",
          terms_accepted: "0",
          date_of_birth: Date.tomorrow.to_s
        }
      end

      it{ expect(User.find_by_email(attributes[:email])).to be_nil }
      it{ expect(response.body).to include("doesn&#39;t match Password") }
      it{ expect(response.body).to include("must be accepted") }
      it{ expect(response.body).to include("have to be in the past") }
    end
  end
end
