# Select .csv files from in_dir, if there is a .RData file with the same
# name. Copy selected files to out_dir.

path = "/lustre/project/wyp/agossman/FDRcorrectedSCCA/hybrid_simulation"
in_dir = path + "/alpha_90"
out_dir = path + "/alpha_90_selected"

raise "out_dir must be different from in_dir" if in_dir == out_dir

csv_files = Dir.glob(in_dir + "/*.csv")
csv_files = csv_files.map { |f| File.basename(f, ".csv") }

rdata_files = Dir.glob(in_dir + "/*.RData")
rdata_files = rdata_files.map { |f| File.basename(f, ".RData") }

files_to_keep = csv_files.select { |f| rdata_files.include? f }

# copy files to out_dir
require 'fileutils'
files_to_keep.each do |f|
  FileUtils.cp(in_dir + "/" + f + ".csv", out_dir)
end
