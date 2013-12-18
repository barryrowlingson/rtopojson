rtopojson
=========

read topojson files into R

Installation
===============

* install devtools - install.packages("devtools")
* use devtools - require(devtools)
* install dependencies - install.packages(c("RJSONIO","sp","plyr")) if you don't have them already
* install this - install_github("rtopojson","barryrowlingson")


Usage
=======

There are two exported functions. The objectNames function gets you the names of objects in the topojson file:

> objectNames("../samples/states1.json")
[1] "states"

and readObject reads that object from that file into a SpatialPolygons object which you can plot:

> sp = readObject("../samples/states1.json","states")
> plot(sp)


Notes
=========

It currently only handles objects with just Polygons and MultiPolygons geometries - not lines, or points, or mixtures of geometries. It will just fail.

It doesn't handle attributes of features - things like names or area population or stuff like that. My test file didn't have those and I figure the geometry is the hard part. 

