# require 'csv'


# namespace :csvload do
#   desc "emotions"
#   task :emotions => :environment do
#     CSV.foreach('db/data/Emotions.csv', headers: true) do |row|
#       Emotion.create!({ term: row[0] })
#     end
#   end
# end