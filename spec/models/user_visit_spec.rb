require 'spec_helper'

describe UserVisit do
  it 'can ensure consistency' do
    u = Fabricate(:user)
    u.update_visit_record!(2.weeks.ago.to_date)
    u.last_seen_at = 2.weeks.ago
    u.save
    u.update_visit_record!(1.day.ago.to_date)

    u.reload
    u.days_visited.should == 2

    u.days_visited = 1
    UserVisit.ensure_consistency!

    u.reload
    u.days_visited.should == 2
  end
end
