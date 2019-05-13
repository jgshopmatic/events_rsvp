namespace :import do

  desc 'Import Users!'
  task :users => :environment do
    file = file_path('users.csv')
    CSV.foreach(file, headers: true) do |row|
      hash = convert_row_to_hash(row)
      User.create!(hash) unless User.exists? email: hash['email']
    end
  end

  desc 'Import Event!'
  task :events => :environment do
    file = file_path('events.csv')
    CSV.foreach(file, headers: true) do |row|
      hash = convert_row_to_hash(row)
      event = if Event.exists? title: hash['title']
                Event.find_by_title(hash['title'])
              else
                event_status = 0 if hash['starttime'].to_datetime.future?
                event_status = 2 if hash['starttime'].to_datetime.past?
                event_status = 1 if Date.today.between?(hash['starttime'].to_datetime, hash['endtime'].to_datetime)
                event_hash = { title: hash['title'],
                               description: hash['description'],
                               start_time: hash['starttime'],
                               end_time: hash['endtime'],
                               all_day: hash['all_day'],
                               status: event_status }
                Event.create!(event_hash)
              end
      invitees = hash['users#rsvp'].present? ? hash['users#rsvp'].split(';') : []
      invitees.each do |users|
        user_rsvp = users.split('#') unless users.blank?
        next if user_rsvp.empty? || User.find_by_username(user_rsvp[0]).nil?

        invitation = { event_id: event.id,
                       user_id: User.find_by_username(user_rsvp[0]),
                       rsvp: user_rsvp[1] }
        Invitee.create!(invitation)
      end
    end
  end

  private

  def convert_row_to_hash(row)
    row.to_hash
  end

  def file_path(filename)
    File.join Rails.root, 'db', 'import', filename
  end

end
