class XML::Reader
  # Returns true if this stream points to start of a tag
  def start_of?(tag)
    (node_type == XML::Reader::TYPE_ELEMENT) && (name == tag)
  end

  # Returns if this stream points to an end of a tag
  def end_of?(tag)
    (node_type == XML::Reader::TYPE_END_ELEMENT) && (name == tag)
  end
end

 
 
