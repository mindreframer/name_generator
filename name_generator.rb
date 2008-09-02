# Taken from xl-suite (xlsuite.org) and slightly modified

require "rubygems"
require "active_record"
require 'ostruct'
last_names = File.open("dist.all.last.de", "rb") {|f| f.read}
male_names = File.open("dist.male.first", "rb") {|f| f.read}
female_names = File.open("dist.female.first", "rb") {|f| f.read}



def extractor(list)
  list.scan(/^\w+/)
end

last_names = extractor(last_names).map(&:capitalize)
male_names = extractor(male_names).map(&:capitalize)
female_names = extractor(female_names).map(&:capitalize)
middle_initials = ("A".."Z").to_a


count = 100 # how many names should be generated
puts "Generating #{count} names"
Name = Struct.new(:last, :first, :middle, :main_email)
Name.class_eval do 
  def to_s
    "#{first} #{last}, #{main_email}"
  end
end

count.times do
  n = Name.new
  n.last = last_names[rand(last_names.size)]
  if rand() < 0.46 then
    n.first = male_names[rand(male_names.size)]
  else
    n.first = female_names[rand(female_names.size)]
  end 

  n.middle = middle_initials[rand(26)] if rand() < 0.45

  # add other user-related fields and generate dummy-data for them
  n.main_email =  "#{n.first}.#{n.last}@hotmail.com".downcase
  # n.main_phone =  sprintf("%03d.%03d.%04d", rand(1000), rand(1000), rand(10000))

  puts n.to_s
end
