require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'SampleDataGrouped.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  rs = RawStat.new
  rs.height = row['height']
  rs.weight = row['weight']
  rs.dog_count = row['dog_count']
  rs.cat_count = row['cat_count']  
  rs.save
  puts "#{rs.height}, #{rs.weight} saved"
end

puts "There are now #{RawStat.count} rows in the rawstats table"