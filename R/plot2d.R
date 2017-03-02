#plot function, plot all the data points and peaks in one coordinate system
#parameters
#x - data points
#matPeaks - matrix returned by the findPeak function
#evalpointsX - points at which the estimate is evaluated at x-axis direction
#evalpointsY - points at which the estimate is evaluated at y-axis direction
plot2d<-function(x,matPeaks,evalpointsX,evalpointsY){
  xmin<-min(x[,1])
  xmax<-max(x[,1])
  ymin<-min(x[,2])
  ymax<-max(x[,2])
  plot(x[,1],x[,2],cex=.1,xlim=c(xmin,xmax),ylim=c(ymin,ymax))
  for(r in 2:(length(evalpointsX)-1))
  {
    for(c in 2:(length(evalpointsY)-1))
    {
      if(matPeaks[r,c]>0)
      {
        xi<-evalpointsX[r];
        yi<-evalpointsY[c];
        par(new=TRUE)
        plot(x=xi,y=yi,pch=4,xlim=c(xmin,xmax),ylim=c(ymin,ymax),axes = FALSE,xlab = "", ylab = "",col="red")
      }
    }
  }
}
