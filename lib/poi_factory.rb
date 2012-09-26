class POIFactory
  def self.processable?(node)
    node.children?
  end

  attr_reader :poi_arr
  def initialize(poi_list=%w{amenity})
    @poi_list=poi_list
    @poi_arr=[]
  end

  def <<(node)
    hash={:lat=> node["lat"], :lon => node["lon"]}
    tags=[]
    node.each_element do |nd| 
      tags << nd if nd.name == "tag"
    end
    if tags_of_interest?(tags) 
      @poi_arr << hash.merge(processed_tags(tags))
    end
  end

private
  def tags_of_interest?(tags)
    tags.each do |tag|
      return(true) if %w{amenity leisure tourism shop}.include? tag["k"]
    end
    false
  end

  def processed_tags(tags)
    hash={}
    tags.each do |tag|
       hash.merge!({tag["k"].to_sym => tag["v"]})
    end
    hash
  end
end
