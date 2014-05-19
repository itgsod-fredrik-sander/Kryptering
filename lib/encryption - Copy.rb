def decrypt(content, offset)
  content = content.dup
  if content.length == 0
    raise ArgumentError, 'String must not be empty'
  end

  if offset == 0
    raise ArgumentError, 'Offset must not be zero'
  end

  if offset < 0
    offset *= -1
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

    print "ch_hash: #{character_hash_index} offset: #{offset} ch_hash.size : #{character_hash.size}" + "\n"
    puts "------------"
    puts character
    puts offset
    puts character_hash_index - offset
    puts "-----------"
    if character_hash_index - offset >= character_hash.size
      puts "first"
      content[index] = character_hash.invert[character_hash_index - offset - character_hash.size]
      puts "no error"
    elsif character_hash_index - offset < 0
      puts "second"
      # We subtract one from character_hash_index if the value is greater than 0. That is because in our
      # decryption system element 0 in our associative array is just as much worth as any other number,
      # and would without this calculation be 'skipped'.

      #character_hash_index > 0 ? offset -= character_hash_index - 1 : offset -= character_hash_index
      content[index] = character_hash.invert[character_hash.size + character_hash_index - offset]
      puts content[index]
      puts "no error"
    else
      puts "third"
      content[index] = character_hash.invert[character_hash_index - offset]
      puts "no error"
    end
  end

  puts content.downcase
  return content.downcase
end

# encrypt(content, offset)
#
#
#

def encrypt(content, offset)
  content = content.dup
  if content.length == 0
    raise ArgumentError, 'String must not be empty'
  end

  if offset == 0
    raise ArgumentError, 'Offset must not be zero'
  end

  character_hash = {"A" => 0, "B" => 1, "C" => 2, "D" => 3, "E" => 4, "F" => 5,
                   "G" => 6, "H" => 7, "I" => 8, "J" => 9, "K" => 10, "L" => 11,
                   "M" => 12, "N" => 13, "O" => 14, "P" => 15, "Q" => 16, "R" => 17,
                   "S" => 18, "T" => 19, "U" => 20, "V" => 21, "W" => 22, "X" => 23,
                   "Y" => 24, "Z" => 25}
  
  if content != content.upcase
    content.upcase!
  end

  content.split("").each_with_index do |character, index|
    if character == " "
      next
    end

    character_hash_index = character_hash[character]

    if character_hash_index + offset >= character_hash.size
      content[index] = character_hash.invert[character_hash_index + offset - character_hash.size]
    elsif character_hash_index + offset < 0
      content[index] = character_hash.invert[character_hash.size + character_hash_index + offset]
    else
      content[index] = character_hash.invert[character_hash_index + offset]
    end
  end
  
  return content
end


