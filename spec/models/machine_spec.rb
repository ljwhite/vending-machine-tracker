require 'rails_helper'

RSpec.describe Machine, type: :model do
  describe 'validations' do
    it { should validate_presence_of :location }
    it { should belong_to :owner }
  end

  describe 'relationships' do
    it { should have_many(:snacks).through(:machine_snacks)}
  end

  describe 'models' do
    it 'calculates .average_snack_price' do
      owner = Owner.create!(name: "Tim")
      machine_1 = Machine.create!(location: "Mall", owner_id: owner.id)
      snack_1 = Snack.create!(name: "Snickers", cost: 1.50)
      snack_2 = Snack.create!(name: "Chips", cost: 2.00)
      MachineSnack.create!(machine_id: machine_1.id, snack_id: snack_1.id)
      MachineSnack.create!(machine_id: machine_1.id, snack_id: snack_2.id)
      expect(machine_1.average_snack_price).to eq("1.75")
    end

    it 'calculates .total_snack_count' do
      owner = Owner.create!(name: "Tim")
      machine_1 = Machine.create!(location: "Mall", owner_id: owner.id)
      snack_1 = Snack.create!(name: "Snickers", cost: 1.50)
      snack_2 = Snack.create!(name: "Chips", cost: 2.00)
      MachineSnack.create!(machine_id: machine_1.id, snack_id: snack_1.id)
      MachineSnack.create!(machine_id: machine_1.id, snack_id: snack_2.id)
      expect(machine_1.total_snack_count).to eq(2)
    end
  end
end
