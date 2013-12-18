readthefile <- function(f){
    require(RJSONIO)
    return(fromJSON(f))
}


readObject <- function(f,objectname){
    j = readthefile(f)
    object = j$objects[[objectname]]
    decodeObjectSP(j,object)
}

objectNames <- function(f){
    j = readthefile(f)
    names(j$objects)
}
