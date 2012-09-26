require 'pp'
require 'xml'
require File.join(File.dirname(__FILE__),'../lib/ext/xml')
require File.join(File.dirname(__FILE__),'../lib/poi_factory')


path="./aizu.osm" # XML data from openstreetmap.org for Aizuwakamatsu
docstream = XML::Reader.file(path)

# the list of POI types we are interested in.
poi_list=%w{amenity shop leisure tourism}
poi_factory=POIFactory.new(poi_list)

while (docstream.read) do
  next unless docstream.start_of?('node')
  node=docstream.expand
  # further process the node 
  # if processable (i.e. has child tag elements)
  poi_factory << node if POIFactory.processable?(node)
  docstream.next
end

fout = File.open("aizu_poi.csv","w")
fout.print '"longitude", "latitude", "category", "name"',"\n"
poi_arr=poi_factory.poi_arr
poi_list.map! {|typ| typ.to_sym}
poi_arr.each do |poi_hash|
  poi_typ = poi_hash.values_at(*poi_list).join
  fout.print %Q("#{poi_hash[:lon]}", "#{poi_hash[:lat]}", )
  fout.print %Q("#{poi_typ}", )
  fout.puts  %Q("#{poi_hash[:name]}")
end
