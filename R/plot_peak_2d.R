#' Plot of the 2D data points with peaks highlighted in green
#'
#' @param dat Data points used for kernel density estimation.
#' @param peaks A matrix of detected peaks with x- and y-coordinates.
#' @param x.range (optional) A numeric 2D vector specifying the x-axis range for filtering.
#' @param y.range (optional) A numeric 2D vector specifying the y-axis range for filtering.
#'
#' @return A scatter plot of the data points with the detected peaks highlighted in green.
#' @importFrom graphics points
#' @export
#'
#' @examples
#' data(r)
#' k <- kdeC(r$dat, H = c(0.014, 0.014), gridsize = c(330, 330), cutNum = c(1, 1), w = r$z)
#' m <- findPeak(k, filter = 0, select = 100)
#' plot_peak_2d(r$dat, m)
plot_peak_2d <- function(dat, peaks,x.range=NA, y.range=NA){
  dx.range <- range(dat[,1])
  dy.range <- range(dat[,2])
  if(!any(is.na(x.range))){
    peaks <- peaks[peaks[,1]<x.range[2]&peaks[,1]>x.range[1],]
    dat <- dat[dat[,1]>x.range[1] & dat[,1]<x.range[2],]
  }else{
    x.range <- dx.range
  }

  if(!any(is.na(y.range)) & nrow(dat) != 0){
    peaks <- peaks[peaks[,2]<y.range[2]&peaks[,2]>y.range[1],]
    dat <- dat[dat[,2]>y.range[1] & dat[,2]<y.range[2],]
  }else{
    y.range <- dy.range
  }

  plot(dat[,1],dat[,2],cex=.1,xlim=x.range,ylim=y.range,axes = T)
  points(peaks[,1],peaks[,2],pch=4,col="green")
}
