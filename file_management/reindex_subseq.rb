# This script 
# (1) sorts .png files (e.g. "foo001.png", "foo002.png", ..., "foo99999.png") 
# according to their index, 
# (2) copies every n'th file into an output directory,
# and (3) renames the output files in a successive order (such as "bar001.png",
# "bar002.png", ..., "bar099.png").
# 

# Change these four lines:
# step determines the subset of files, e.g. step=2 means every second file
step = 3
file_name_without_index = "mypng"
input_dir = "/home/alexej/Desktop"
output_dir = "/home/alexej/Desktop/out"

raise "output_dir must be different from input_dir" if input_dir == output_dir

puts "Selecting and renaming every #{step}th (or nd/rd/st) file from #{input_dir}. The results are saved in #{output_dir}."

# sort input files and select every step'th file
sorted_files = Dir.glob(input_dir + "/*.png").sort_by! do |s| 
  s.scan(/\d/).join.to_i
end
to_keep = sorted_files.select.each_with_index do |f, i| 
  i % step == 0
end 

# uncomment next line if you want to check that it kept all the right files
# puts to_keep

# copy files to output_dir
require 'fileutils'
to_keep.each_with_index do |f|
  FileUtils.cp(f, output_dir)
end

# rename files in output_dir
sorted_files = Dir.glob(output_dir + "/*.png").sort_by! do |s| 
  s.scan(/\d/).join.to_i
end
sorted_files.each_with_index do |f, i| 
  newname = file_name_without_index + sprintf("%03d", i) + ".png"
  File.rename(f, "#{output_dir}/#{newname}") 
end 

