require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I visit a vending machine show page' do
    before :each do
      @owner = Owner.create!(name: "Tim")
      @machine_1 = Machine.create!(location: "Mall", owner_id: @owner.id)
      @snack_1 = Snack.create!(name: "Snickers", cost: "1.50")
      @snack_2 = Snack.create!(name: "Chips", cost: "2.00")
      MachineSnack.create!(machine_id: @machine_1.id, snack_id: @snack_1.id)
      MachineSnack.create!(machine_id: @machine_1.id, snack_id: @snack_2.id)

      visit "/machines/#{@machine_1.id}"
    end

    it 'I see the names and price of all snacks' do

      expect(page).to have_content(@machine_1.location)
      expect(page).to have_content(@snack_1.name)
      expect(page).to have_content(@snack_1.cost)
      expect(page).to have_content(@snack_2.name)
      expect(page).to have_content("$#{@snack_2.cost}")
    end

    it "I also see the average price of all snacks" do
      expect(page).to have_content("Average Snack Price: $1.75")
    end
  end
end
