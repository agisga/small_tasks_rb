require "rsync"

source_root_folder = "/home/alexej/"
dest_root_folder = "/media/alexej/corsair/"

items_to_sync = []
File.open("sources_list.txt", "r") do |f|
  items_to_sync = f.read.split /\s/
end

items_to_sync.each do |name|
  source = source_root_folder + name
  destination = dest_root_folder + name

  sync_task = "Syncing #{source} to #{destination}"
  puts "-" * sync_task.length + "\n#{sync_task}\n" + "-" * sync_task.length + "\n\n"

  Rsync.run(source, destination, ['-a', '-v', '-P', '--delete']) do |result|
    if result.success?
      result.changes.each do |change|
        puts "#{change.filename} (#{change.summary})"
      end
    else
      puts result.error
    end
  end
end
