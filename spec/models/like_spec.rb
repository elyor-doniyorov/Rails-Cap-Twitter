require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it 'should belong to user' do
      expect { should belong_to(:user) }
    end
  end
  describe 'associations' do
    it 'should belong to opinion' do
      expect { should belong_to(:opinion) }
    end
  end
end
