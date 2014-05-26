# Private: Calculate value within interval 0 to max_value
#
# current_value - The current value.
# max_value     - The maximum value in the interval.
# value         - The value to be calculated in the equation.
#
# Examples
#
#   interval_value(4, 9, 2)
#   # =>  2
#   interval_value(1, 9, 2)
#   # => 8
#
# Returns the new calculated value

def interval_value(current_value, max_value, value)
  if current_value - value < 0
    return max_value + current_value - value
  elsif current_value - value >= max_value
    return current_value - value - max_value
  else
    return current_value - value
  end
end

# Public: Decrypts a alphabetical string (A-Z) with a offset
#
# content - The content to be decrypted.
# offset  - The decryption offset.
#
# Examples
#
#   decrypt('WKH TXLFN EURZQ IRA MXPSV RYHU WKH ODCB GRJ', 3)
#   # =>  'the quick brown fox jumps over the lazy dog'
#   decrypt('IWT FJXRZ QGDLC UDM YJBEH DKTG IWT APON SDV', -11)
#   # =>  'the quick brown fox jumps over the lazy dog'
#
# Returns the decrypted string


def decrypt(content, offset)
  content = content.dup

  raise ArgumentError, 'String must not be empty' if content.empty?

  raise ArgumentError, 'Offset must not be zero' if offset == 0

  content.upcase!

  # We create an instance of a Hash to eazily access values and keys in our algorithm.
  # The reason to why I decided to go with a Hash over an array was simple, it makes us able to go
  # from character => index, index => character instead of an array where its index => character. 

  character_hash = {"A" => 0, "B" => 1, "C" => 2, "D" => 3, "E" => 4, "F" => 5,
                   "G" => 6, "H" => 7, "I" => 8, "J" => 9, "K" => 10, "L" => 11,
                   "M" => 12, "N" => 13, "O" => 14, "P" => 15, "Q" => 16, "R" => 17,
                   "S" => 18, "T" => 19, "U" => 20, "V" => 21, "W" => 22, "X" => 23,
                   "Y" => 24, "Z" => 25}

  # We iterate over each character in the content variable.
  # For each character we move it by the offset variable's value within the character_hash interval.
  # Then we replace the character with the new character.

  content.split("").each_with_index do |character, index|
    if character == " "
      next
    end
    
    # Get the character's value in character_hash
    character_hash_index = character_hash[character]
    
    # Calculate new value for the character within the character_hash interval relative to offset.
    character_hash_index = interval_value(character_hash_index, character_hash.size, offset)
    # Replace the character with the character we calculated in the character_hash interval.
    content[index] = character_hash.invert[character_hash_index]
  end

  # Return the decrypted variable content in small characters.
  return content.downcase
end

# Public: Encrypts a alphabetical string (A-Z) with a offset
#
# content - The content to be encrypted.
# offset  - The encryption offset.
#
# Examples
#
#   encrypt('the quick brown fox jumps over the lazy dog', 3)
#   # =>  'WKH TXLFN EURZQ IRA MXPSV RYHU WKH ODCB GRJ'
#   encrypt('IWT FJXRZ QGDLC UDM YJBEH DKTG IWT APON SDV', -11)
#   # =>  'IWT FJXRZ QGDLC UDM YJBEH DKTG IWT APON SDV'
#
# Returns the encrypted string

def encrypt(content, offset)
  # Decrypting and crypting contains more or less the exact same code.
  # The difference between those two methods is that decrypting by default takes a positive offset
  # as negative in its calculations. That is why we, when calling the decrypting method, turn our offset
  # around. With that being said, we go from + to - or - to + before executing our method call.
  # As our encrypting method is supposed to return the encrypted content uppercase, 
  # and decrypt returns the decrypted content lowercase, we call string's member method upcase.

  return decrypt(content, offset * -1).upcase
end


