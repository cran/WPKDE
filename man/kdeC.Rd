\name{kdeC}
\alias{kdeC}

\title{
weighted kernel density estimation
}
\description{
fast weighted kernel density estimation for 2-dimension and calling C function to implement the calculation procedure
}
\usage{
kdeC(x,H,gridsize,cutNum,w)
}

\arguments{
  \item{x}{data points in the format n*2 matrix}
  \item{H}{bandwidth, a vector containing 2 num values and set c(0.01,0.01) as default}
  \item{gridsize}{number of points for each direction, a vector containing 2 int values and set c(200,50) as default}
  \item{cutNum}{number of pieces to be cutted for each direction, a vector containing 2 int values and set c(1,1) as default}
  \item{w}{weight, a vector corresponding to parameter \code{x} and set rep(1,length(x)/2) as default}
}
\details{
The function \code{kdeC} is only suitable for 2-dimension data. The advantage of \code{kdeC} is that it can get the result quickly because the calculation procedure is implemented in C code.
}
\value{
  the returned value is a list
  \item{estimate}{density estimate at points \code{evalpointsX} and \code{evalpointsY}}
  \item{evalpointsX}{points at which the \code{estimate} is evaluated at x-axis direction}
  \item{evalpointsY}{points at which the \code{estimate} is evaluated at y-axis direction}
}
\references{
R package 'ks'
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
k2<-kdeC(r$dat, H=c(0.005,0.005),  gridsize = c(101,101), cutNum=c(5,5))
}

\keyword{kernel}
\keyword{smooth}
