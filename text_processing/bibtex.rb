require 'bibtex'

b = BibTeX.open('/path/to/file.bib')

# remove all url entries from the bibliography
b.each { |bibitem| bibitem.delete('url') }

# also get rid of howpublished
b.each { |bibitem| bibitem.delete('howpublished') }

# fix or remove all the weird page number entries
b.each do |bibitem|
  if (bibitem['pages'] =~ / - /) then
    bibitem['pages'].gsub!(/ - /, "--")
  end

  if (bibitem['pages'] =~ /[a-zA-Z]/) then
    bibitem.delete('pages')
  end

  puts bibitem['pages']
end

# save to the original file
b.save
# or save to a new file
# b.save_to('/path/to/new/file.bib')
