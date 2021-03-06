\name{plot2d}
\alias{plot2d}

\title{
plot function
}
\description{
plot all the data points(black spots in the plot) and peaks(red spots in the plot) in one coordinate system
}
\usage{
plot2d(x,matPeaks,evalpointsX,evalpointsY)
}

\arguments{
  \item{x}{data points in the format n*2 matrix}
  \item{matPeaks}{matrix returned by the \code{findPeak} function}
  \item{evalpointsX}{points at which the \code{matPeaks} is evaluated at x-axis direction}
  \item{evalpointsY}{points at which the \code{matPeaks} is evaluated at y-axis direction}
}
\details{
The function \code{plot2d} is mainly designed to make the result of functions \code{kdeC} and \code{findPeak} visual
}

\author{
Kunyu Ye
}

\examples{
data.gen<-function(n.peaks=100, N=1e5, max.var=0.001, max.corr=0.5)
{
  library(mvtnorm)

  dat<-matrix(0, nrow=N, ncol=2)
  all.m<-c(NA,NA)

  for(i in 1:n.peaks)
  {
    this.m<-runif(2)
    this.var<-runif(2, min=0.1*max.var, max=max.var)
    this.cov<-runif(1, min=-1*max.corr, max=max.corr) * sqrt(this.var[1])* sqrt(this.var[2])
    this.s<-matrix(c(this.var[1], this.cov, this.cov, this.var[2]),ncol=2)

    dat[((i-1)*N/n.peaks+1):(i*N/n.peaks),]<-rmvnorm(N/n.peaks, mean=this.m, sigma=this.s)
    all.m<-rbind(all.m, this.m)
  }

  all.m[,1]<-(all.m[,1]-min(dat[,1]))/diff(range(dat[,1]))
  all.m[,2]<-(all.m[,2]-min(dat[,2]))/diff(range(dat[,2]))
  dat[,1]<-(dat[,1]-min(dat[,1]))/diff(range(dat[,1]))
  dat[,2]<-(dat[,2]-min(dat[,2]))/diff(range(dat[,2]))

  all.m<-all.m[-1,]
  return(list(dat=dat,m=all.m))
}

r<-data.gen(n.peaks=100, N=1e5, max.var=0.001, max.corr=0.5)

k1<-kdeC(r$dat, H=c(0.005,0.005),  gridsize = c(501,501), cutNum=c(1,1))

matPeaks<-findPeak(estimate=k1$estimate,filter=0)

plot2d(x=r$dat,matPeaks=matPeaks,evalpointsX=k1$evalpointsX,evalpointsY=k1$evalpointsY)
}
\keyword{plot}
