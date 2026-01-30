require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'associations' do
    it 'belongs to section' do
      association = described_class.reflect_on_association(:section)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe '#move_up' do
    it 'swaps position with the course above' do
      section = create(:section)
      top = create(:course, section: section, position: 1)
      lower = create(:course, section: section, position: 2)

      lower.move_up

      expect(lower.reload.position).to eq(1)
      expect(top.reload.position).to eq(2)
    end

    it 'does nothing when already at the top' do
      section = create(:section)
      course = create(:course, section: section, position: 1)

      expect { course.move_up }.not_to change(course, :position)
    end
  end

  describe '#move_down' do
    it 'swaps position with the course below' do
      section = create(:section)
      top = create(:course, section: section, position: 1)
      lower = create(:course, section: section, position: 2)

      top.move_down

      expect(top.reload.position).to eq(2)
      expect(lower.reload.position).to eq(1)
    end

    it 'does nothing when already at the bottom' do
      section = create(:section)
      course = create(:course, section: section, position: 1)

      expect { course.move_down }.not_to change(course, :position)
    end
  end
end
