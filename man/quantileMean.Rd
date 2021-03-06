\name{quantileMean}
\alias{quantileMean}
\title{Average of R's quantile methods}
\description{weighted average of \R's quantile methods}
\usage{quantileMean(x, probs = seq(0, 1, 0.25), weights=rep(1,9),
names=TRUE, truncate=0, ... )}
\arguments{
  \item{x}{Numeric vector whose sample quantiles are wanted}
  \item{probs }{Numeric vector of probabilities with values in [0,1]. DEFAULT:  seq(0, 1, 0.25)}
  \item{weights}{Numeric vetor of length 9 with weight for each \code{\link{quantile} method}. Recycled if shorter. DEFAULT: unweighted mean. DEFAULT: rep(1,9)}
  \item{names}{If TRUE, the resulting vector has a names attribute. DEFAULT: TRUE}
  \item{truncate}{Number between 0 and 1. Censored quantile: fit to highest values only (truncate lower proportion of x). Probabilities are adjusted accordingly. DEFAULT: 0}
  \item{\dots}{further arguments passed to \code{\link{quantile}}, except for type}
}
\details{weights are internally normalized to sum 1}
\value{numeric named vector, as returned by \code{\link{apply}}}
\author{Berry Boessenkool, \email{berry-b@gmx.de}, Sept 2014}
\seealso{\code{\link{quantile}} }
\examples{
exDat <- rnorm(30,sd=5)
quantile(exDat, probs=c(0.9, 0.99), type=1)
quantile(exDat, probs=c(0.9, 0.99), type=2)
round( sapply(1:9, function(m) quantile(exDat, probs=0.9, type=m)) , 3)
# and now the unweighted average:
quantileMean(exDat, probs=c(0.9, 0.99))
quantileMean(exDat, probs=0.9)
# say I trust type 2 and 3 especially and want to add a touch of 7:
quantileMean(exDat, probs=c(0.9, 0.99), weights=c(1,5,5,0,1,1,3,1,1))

# quantile sample size dependency simulation:
qbeta(p=0.999, 2, 9) # dist with Q99.9% = 0.62
betaPlot(2, 9, cumulative=FALSE)
abline(v=qbeta(p=0.999, 2, 9), col=6, lwd=3)
qm <- function(size) quantileMean(rbeta(size, 2,9), probs=0.999, names=FALSE)
n30  <- replicate(n=500, expr=qm(30))
n1000 <- replicate(n=500, expr=qm(1000))
lines(density(n30)) # with small sample size, high quantiles are systematically
lines(density(n1000), col=3) # underestimated. for Q0.999, n must be > 1000


\dontrun{
# #Excluded from CRAN Checks because of the long computing time
# median of 500 simulations:
qmm <- function(size, truncate=0) median(replicate(n=500,
       expr=quantileMean(rbeta(size, 2,9), probs=0.999, names=FALSE, truncate=truncate)))

n <- seq(10, 1000, length=30)
medians <- sapply(n, qmm)  # medians of regular quantile average
plot(n, medians, type="l", las=1)
abline(h=qbeta(p=0.999, 2, 9), col=6) # real value
# with truncation:
medians_trunc <- sapply(n, qmm, truncate=0.8) # only top 20% used for quantile estimation
lines(n, medians_trunc, col=2) # censored quantiles don't help!
# In small samples, rare high values do not occur on average

# Parametrical quantiles can avoid sample size dependency!
if(!require(devtools)) install.packages("devtools")
devtools::install_github("brry/extremeStat")
library("extremeStat")
library2("pbapply")

distLquantile(rbeta(1000, 2,9), probs=0.999, plot=TRUE, nbest=10) # 10 distribution functions
distLquantile(rbeta(1000, 2,9), probs=0.999, plot=TRUE, nbest=10) # that seem to work well
select <- c("wei","wak","pe3","ln3","kap","gno","gev","gum","gpa","gam")

pqmm <- function(size, truncate=0, plot=FALSE) median(replicate(n=50,
       expr=mean(distLquantile(rbeta(size, 2,9), probs=0.999, type=select,
          plot=plot, nbest=10, progbars=FALSE, time=FALSE, truncate=truncate))))

#dev.new(record=TRUE)
#pqmm(30, plot=TRUE)

# medians of parametrical quantile estimation
###suppressMessages(pmedians <- pbsapply(n, pqmm) )  # takes several minutes
write.table(pmedians, file="../inst/extdata/pmedians.txt", row.names=FALSE, col.names=FALSE)
pmedians <- read.table("../inst/extdata/pmedians.txt")[,1]

plot(n, medians, type="l", ylim=c(0.4, 0.7), las=1)
abline(h=qbeta(p=0.999, 2, 9), col=6) # real value
lines(n, medians_trunc, col=2) # censored quantiles don't help!
lines(n, pmedians, col=4) # overestimated, but not dependent on n
# with truncation, only top 20% used for quantile estimation
suppressMessages(pmedians_trunc <- pbsapply(n[-1], pqmm, truncate=0.8))
lines(n[-1], pmedians_trunc, col=6) # much better!
# Good for this beta distribution. I don't know how it scales to other dists.
}
}
\keyword{univar}
