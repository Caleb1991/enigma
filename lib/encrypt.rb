require './enigma'

enigma = Enigma.new

phrase = File.open(ARGV[0], 'r')

encryption = enigma.encrypt(phrase.read)

phrase.close

writer = File.open(ARGV[1], 'w')

writer.write(enigma.encoded_phrase)

writer.close

puts "Created '#{ARGV[1]}'' with the key #{encryption[:key]} and date #{encryption[:date]}"
