def interval_value(min_value, max_value, value)
  if min_value - value < 0
    return max_value + min_value - value
  elsif min_value - value >= max_value
    return min_value - value - max_value
  else
    return min_value - value
  end
end

def decrypt(content, offset)
  content = content.dup

  if content.length == 0
    raise ArgumentError, 'String must not be empty'
  end

  if offset == 0
    raise ArgumentError, 'Offset must not be zero'
  end

  if content != content.upcase
  	content.upcase!
  end

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

def encrypt(content, offset)
  return decrypt(content, offset * -1).upcase
end


