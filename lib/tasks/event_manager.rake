namespace :event_manager do
  desc 'Toggles active tag on appropriate events'
  task check_activity: :environment do
    Event.all.each do |event|
      event.check_if_active
    end
  end
end
