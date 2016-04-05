require 'optparse'

# Recursive method to form words
# @param [String] phone number to convert.
# @param [Integer] index set to itrate through phone number.
# @param [String] complete new word generated.
# @param [String] sub-word between dashes.
# @param [Integer] index set to itrate through temp_word.
def add_chars_recursive(phone_number, phone_index, new_word, temp_word, temp_word_index)
  
  # If the end of the phone number is reached
  if(phone_index == phone_number.length)
    if temp_word_index == 1 
      if phone_number[phone_index - 1] == '2' or phone_number[phone_index - 1] == '4'
        new_word += phone_number[phone_index - 1]
        puts new_word
      end
    else
      valid_word = get_word_from_dictionary temp_word
      if valid_word 
        new_word += temp_word
        puts new_word
      end
    end
    
    return
  end

  if phone_number[phone_index] =~ /[[:digit:]]/
    $num_encoding[phone_number[phone_index]].each do |letter|
      temp_word[temp_word_index] = letter
      add_chars_recursive(phone_number, phone_index+1, new_word, temp_word, temp_word_index+1)
      if temp_word_index == 0 and not(phone_number[phone_index+1] =~ /[[:digit:]]/)
        if phone_number[phone_index] == '2' or phone_number[phone_index] == '4'
          puts phone_number[phone_index]
          break
        end
      end
    end
  else
    if temp_word_index == 1
      if phone_number[phone_index - 1] == '2' or phone_number[phone_index - 1] == '4'
        new_word += phone_number[phone_index - 1] + '-'
        add_chars_recursive(phone_number, phone_index+1, new_word, '', 0)
      end
    else
      valid_word = get_word_from_dictionary temp_word
      if valid_word
        new_word += temp_word + '-'
        add_chars_recursive(phone_number, phone_index+1, new_word, '', 0)
      end
    end 
    
    return
  end
end

# Check if word exists in dictionary
# @param [String] word to be checked against dictionary.
# @return [String] The string found in the dictionary.
def get_word_from_dictionary(possible_word)
  if possible_word == 'A' or possible_word == 'B' or possible_word == 'I' or possible_word == 'N' or possible_word == 'R' or possible_word == 'U'
    return possible_word
  else
    $dict.each_line do |line|
      if line.gsub(/\n/, '').upcase == possible_word
        return possible_word
      end
    end
  end
  return nil
end

options = {}
OptionParser.new do |opts|
  opts.on("-d", "--require DICTIONARY", "Specify directory of dictionary") do |d|
    options[:dictionary] = d
  end
end.parse!

if options[:dictionary]
  $dict =  File.read(options[:dictionary])
else 
  $dict = File.read('/usr/share/dict/words')
end

$num_encoding = {
  '2' => ['A','B','C'],
  '3' => ['D','E','F'],
  '4' => ['G','H','I'],
  '5' => ['J','K','L'],
  '6' => ['M','N','O'],
  '7' => ['P','Q','R','S'],
  '8' => ['T','U','V'],
  '9' => ['W','X','Y','Z']
}

ARGF.each do |line|
  add_chars_recursive(line.gsub(/\n/, ''), 0, '', '', 0)
end