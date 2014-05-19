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

   character_hash = {"A" => 0, "B" => 1, "C" => 2, "D" => 3, "E" => 4, "F" => 5,
                   "G" => 6, "H" => 7, "I" => 8, "J" => 9, "K" => 10, "L" => 11,
                   "M" => 12, "N" => 13, "O" => 14, "P" => 15, "Q" => 16, "R" => 17,
                   "S" => 18, "T" => 19, "U" => 20, "V" => 21, "W" => 22, "X" => 23,
                   "Y" => 24, "Z" => 25}

  content.split("").each_with_index do |character, index|
    if character == " "
      next
    end

    character_hash_index = character_hash[character]

    character_hash_index = interval_value(character_hash_index, character_hash.size, offset)
    content[index] = character_hash.invert[character_hash_index]
  end

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
  return decrypt(content, offset * -1).upcase
end


