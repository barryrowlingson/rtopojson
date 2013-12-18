decodeArc <- function(topology,arc,fwd=TRUE){
    am = do.call(rbind,arc)
    xy = cbind(cumsum(am[,1]) * topology$transform$scale[1],
          cumsum(am[,2]) * topology$transform$scale[2]
          )
    if(!fwd){
        return(xy[nrow(xy):1,])
    }else{
        return(xy)
    }
}

decodeArcNumber <- function(topology,arcnumber){
    fwd = TRUE
    if(arcnumber < 0 ){
        arcnumber = abs(arcnumber)-1 # ones complement
        fwd=FALSE
    }
    decodeArc(topology,topology$arcs[[abs(arcnumber+1)]],fwd) # +1 for R's index
}

decodeArcs <- function(topology, arclist){
    require(plyr)
    pts = ldply(arclist,function(n){decodeArcNumber(topology,n)})
    pts
}

makePolygons <- function(g,ID){
    require(sp)
    Polygons(g,ID)
}

decodeFeatureSP <- function(topology,object,n,ID){
    require(sp)
    require(plyr)
    gtype = object$geometries[[n]]$type

    if(gtype=="Polygon"){
        return(makePolygons(list(Polygon(decodeArcs(topology, object$geometries[[n]]$arc[[1]]))),ID))
    }
    if(gtype=="MultiPolygon"){
        arcs = object$geometries[[n]]$arcs
        ## create makePolygons(list(Polygon, Polygon,...),ID)
        ## list of Polygons
        pl = llply(seq_along(arcs),function(n){Polygon(decodeArcs(topology,arcs[[n]][[1]]))})
        return(makePolygons(pl,ID))
    }
    return(gtype)
}
decodeObjectSP <- function(topology, object){
    require(sp)
    require(plyr)
    stopifnot(is.character(object$type))
    ID = 0
    SpatialPolygons(llply(seq_along(object$geometries), function(n){ID<<-ID+1;decodeFeatureSP(topology,object,n,ID)}))
}


