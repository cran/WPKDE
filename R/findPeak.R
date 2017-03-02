#using the estimation values to find peaks
#parameters
#estimate - matrix returned by the kdeC function
#filter - a num value, filter the result less than argument value 'filter'
#Returns
#markMat - a matrix corresponding to argument 'estimate', the value in the matrix larger than 0 means it is a peak
findPeak<-function(estimate,filter){
  if(missing(filter)){
    filter<-0
  }
  if(missing(estimate)){
    stop("can not miss the first argument 'estimate'.\n")
  }
  if(length(estimate[,1])<3 || length(estimate[1,])<3){
    stop("first argument 'estimate' should not be smaller than 3*3 matrix.\n")
  }
  markMat<-matrix(0,nrow = length(estimate[,1]),ncol = length(estimate[1,]))
  for(r in 2:(length(estimate[,1])-1))
  {
    for(c in 2:(length(estimate[1,])-1))
    {
      if(estimate[r,c]>estimate[r-1,c-1]&&estimate[r,c]>estimate[r-1,c]
         &&estimate[r,c]>estimate[r-1,c+1]&&estimate[r,c]>estimate[r,c-1]
         &&estimate[r,c]>estimate[r,c+1]&&estimate[r,c]>estimate[r+1,c-1]
         &&estimate[r,c]>estimate[r+1,c]&&estimate[r,c]>estimate[r+1,c+1]
         &&estimate[r,c]>=filter)
      {
        markMat[r,c]<-estimate[r,c]
      }
    }
  }
  return(markMat)
}
