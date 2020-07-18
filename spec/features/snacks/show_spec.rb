require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I visit a snack show page' do
    before :each do
      @owner = Owner.create!(name: "Tim")
      @machine_1 = Machine.create!(location: "Mall", owner_id: @owner.id)
      @machine_2 = Machine.create!(location: "School", owner_id: @owner.id)
      @snack_1 = Snack.create!(name: "Snickers", cost: 1.50)
      @snack_2 = Snack.create!(name: "Chips", cost: 2.00)
      MachineSnack.create!(machine_id: @machine_1.id, snack_id: @snack_1.id)
      MachineSnack.create!(machine_id: @machine_2.id, snack_id: @snack_1.id)
      MachineSnack.create!(machine_id: @machine_2.id, snack_id: @snack_2.id)
    end

  it 'I see the name and list of locations for that snack, as well as btoh the average price and total count of all snacks in each vending machine' do
     visit "snacks/#{@snack_1.id}"
     expect(page).to have_content(@snack_1.name)
     expect(page).to have_content(@snack_1.cost)

     within ".vending_machines-#{@machine_1.id}" do
       expect(page).to have_content(@machine_1.location)
       expect(page).to have_content("$1.50")
       expect(page).to have_content("Quantity of Snacks: 1")
     end
     within ".vending_machines-#{@machine_2.id}" do
       expect(page).to have_content(@machine_2.location)
       expect(page).to have_content("Quantity of Snacks: 2")
       expect(page).to have_content("$1.75")
     end
  end

  end
end
