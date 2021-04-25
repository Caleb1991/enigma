require './enigma'

enigma = Enigma.new

phrase = File.open(ARGV[0], 'r')

enigma.decrypt(phrase.read, ARGV[2], ARGV[3])

phrase.close

writer = File.open(ARGV[1], 'w')

writer.write(enigma.decoded_phrase)

writer.close

puts "Created #{ARGV[1]} with the key #{enigma.key} and date #{enigma.date}"
