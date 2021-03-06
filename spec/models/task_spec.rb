require 'rails_helper'

describe Task do
  it { should have_many(:volunteers).class_name(User) }
  it { should have_many(:organizers).class_name(User) }
  it { should belong_to(:working_group).class_name(WorkingGroup) }
  it { should validate_presence_of(:working_group) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:due_date) }
  it { should validate_presence_of(:description) }
end