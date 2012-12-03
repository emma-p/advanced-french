require_relative '../spec_helper'

describe Bouncer do
  let(:email) { "foo@bar.com" }
  let(:user)  { Connection.db["users"].find_one("email" => email) }

  before do
    create_user_foo
  end

  after do
    remove_user_foo
  end

  describe '.user_can_authenticate?' do
    context 'when the user provides valid creds' do
      let(:password) { "testpass" }

      it 'returns true' do
        Bouncer.user_can_authenticate?(email, password).should be_true
      end
    end

    context 'when the user provides invalid creds' do
      let(:password) { "wrongpass" }

      it 'returns false' do
        Bouncer.user_can_authenticate?(email, password).should be_false
      end
    end
  end
end
