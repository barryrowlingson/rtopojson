
readthefile <- function(f){
    require(RJSONIO)
    return(fromJSON(f))
}

##' Read an object from a topojson file
##'
##' Reads topojson files
##' @title read an object from a topojson file
##' @param f topojson file name
##' @param objectname object name
##' @return SpatialPolygons object
##' @author Barry S Rowlingson
##' @export
readObject <- function(f,objectname){
    j = readthefile(f)
    object = j$objects[[objectname]]
    decodeObjectSP(j,object)
}

##' Get the names of objects in a topojson file
##'
##' Get the names of objects
##' @title Get topojson object names
##' @param f topojson format file name
##' @return vector of names
##' @author Barry S Rowlingson
##' @export
objectNames <- function(f){
    j = readthefile(f)
    names(j$objects)
}
