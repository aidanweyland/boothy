
# Mock tattoo parlor booths for Boothy

vendors = {
  1 => "Alex",
  2 => "Jordan",
  3 => "Taylor",
  4 => "Morgan",
  5 => nil,
  6 => nil
}

vendors.each do |number, vendor_name|
  booth = Booth.find_or_initialize_by(number: number)

  booth.vendor_name = vendor_name
  booth.monthly_fee = 800
  booth.occupied = vendor_name.present?

  booth.save!
end

puts "Created #{Booth.count} booths for Ink House Tattoo Studio!"
