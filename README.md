osm_to_poi
==========

Extracts Points of Interest (POI) as an array of hashes from an OSM XML file
This library uses libxml, which can be installed as a gem 

       (sudo) gem install libxml-ruby 

More details on LibXml Ruby may be found at http://xml4r.github.com/libxml-ruby/
We use the XML stream parsing method discussed nicely in 
http://coldattic.info/shvedsky/s/blogs/a-foo-walks-into-a-bar/posts/56

How to use
===========

Currently there is no gem file. So, clone the repository or download a 
tarball. The example 'examples/aizu_to_poi.rb' demonstrates the usage 
of this library to extract the POIs of interest (amenity, shop, leisure and tourism) from an OSM XML file extracted over Aizuwakamatsu from openstreetmap.org.

In this example, we start off by streaming through the XML elements one by one.
Once an element by the name 'node' is reached, we check if it is processable
by POIFactory. If so, it is dispatched to POIFactory for further processing. The
POIFactory extracts POIs that we specified and stores all attributes in a hash. If not, we skip to the next element and so on. Once the whole XML file is processed, we retrieve an array of hashes from the POIFactory instance.  In the example,
this is further processed to write a CSV file with only the attributes of interest.

What does it contain?
=====================

1. It adds some helpers to libxml-ruby (see lib/ext/xml.rb).
2. It adds a POIFactory Class that has two instance methods, new and <<(node)
   and a class method processable?(node)
    1. We can pass a list of POI keys that we are interested in while initializing
   POI factory
    2. The <<(node) method passes in an XML node to the POI factory instance
        for further processing. The results are stored in memory till needed.
    3. The class method processable?(node) simply checks if the 'node' element
        has children. 
