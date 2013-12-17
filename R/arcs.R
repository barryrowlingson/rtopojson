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

decodeFeature <- function(topology,object,n){
    print(n)
    if(object$geometries[[n]]$type=="Polygon"){
        print(object$geometries[[n]]$arc)
        return(decodeArcs(topology, object$geometries[[n]]$arc[[1]]))
    }
    return(NULL)
}
decodeObject <- function(topology, object){
    stopifnot(is.character(object$type))
    llply(seq_along(object$geometries), function(n){decodeFeature(topology,object,n)})
}
