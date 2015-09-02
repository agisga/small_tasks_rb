# Transposes a file containing data values separated by white space characters,
# and saves the transposed data in a different file
#

input_file = "some_data.txt"
output_file = "transposed.txt"

f = File.new(input_file)
lines_array = Array.new
f.each_line do |line|
  lines_array.push(line)
end
f.close

# split each line at white space type characters
lines_array.each_index do |i|
  lines_array[i] = lines_array[i].split(%r{\s})
end

lines_array = lines_array.transpose

# join elements of each line with white spaces separating them, and then join the lines to one string
lines_array.each_index do |i|
  lines_array[i] = lines_array[i].join(" ")
end
lines_string = lines_array.join("\n")

File.open(output_file, "w") do |f|
  f.write(lines_string)
end
