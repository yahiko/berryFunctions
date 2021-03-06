\name{movAv}
\alias{movAv}
\title{moving average}
\description{weighted moving average with overlapping windows}
\usage{movAv(dat, width=7, weights=rep(1,width) )}
\arguments{
  \item{dat}{Vector with regularly spaced data}
  \item{width}{Odd integer specifying window width. DEFAULT: 7}
  \item{weights}{Vector with weights. Sum is normalized to 1. DEFAULT: rep(1,width)}
}
\details{Width has to be odd, so there is a defined middle point of each window.
Even inputs will be changed with a warning.\cr
Weights doesn't have to be symmetrical, but is always mapped to the middle of each window!\cr
If there are NAs in the window, the corresponding weight is distributed evenly to the other weights.
}
\note{You can specify just one of weights or width.}
\value{Vector of the same length as the original input. padded with NAs at width/2 margin elements}
\author{Berry Boessenkool, \email{berry-b@gmx.de}, ca 2012}
\seealso{ \code{\link{decompose}}, \code{\link{smooth}}, \code{\link{loess}}, \code{\link[zoo]{rollapply}} (no overlapping!)}
\examples{

set.seed(29); a <- runif(40, 5,50)
data.frame(a, movAv(a))

# final and commencing NAs are kept, middle ones are filled:
a[c(1:10, 18:26, 32:40)] <- NA
data.frame(a, movAv(a))

set.seed(29); a <- runif(60, 5,50)
plot(a, type="o", pch=16, las=1)
lines(movAv(a), col=2, lwd=3) # shows trends, signal in the noise
lines(movAv(a,3), col=4, lwd=3)
lines(movAv(a,15), col=3, lwd=3) # degree of smoothing depends on window width


plot(a, type="o", pch=16, las=1)
lines(movAv(a), col=2, lwd=3) # uniform weight within running window
# Triangular weights react stronger to extrema:
lines(movAv(a, weights=c(1,2,4,6,4,2,1)), col=4, lwd=3)


plot(c(Nile), type="l")
lines(movAv(c(Nile),20), col=4, lwd=4)
lines(movAv(c(Nile),21), col=3) # even widths are changed to a higher value


# smoothing intenstiy:
plot(1871:1970, c(Nile), type="l", col=8)
movAvLines(1871:1970, c(Nile), lwd=3)

\dontrun{
## Rcmd check --as-cran doesn't like to open external devices,
## so this piece of the example is excluded from running in the checks.
graphics.off(); windows(record=TRUE)}
for(i in 1:30*2-1) {
 plot(a, type="o", pch=16, las=1, main=paste("moving average, width =", i))
 lines(movAv(a, i), col=2, lwd=4)
}
# "Scroll" with PgUp und PgDn
# How to lie with moving averages: compare width 29 with 49 - the "trend"
# appears to be in opposite direction! (OK, this is random data anyways).

b <- rep(a, each=10)+runif(600, -10, 20)
plot(b, type="l")
lines(movAv(b), col=2, lwd=4)
lines(movAv(b, 35), col=4, lwd=4)
lines(movAv(b, 101), col=5, lwd=4)  # choose width according to scale!




# Deviance from running mean can identify outlier:
nile <- c(Nile)
par(mfrow=c(3,1), mar=c(1,3,2.5,0), cex.main=1, las=1)
plot(nile, type="l", main=c("original Nile data",""), xlab="", xaxt="n")
lines(movAv(nile,5), lwd=2, col=2)
title(main=c("", "5-element running mean (moving average)"), col.main=2)
box("figure")
plot(nile-movAv(nile,5), type="o", pch=16, col=4,
      main="difference  ( original data - moving average )", xlab="", xaxt="n")
abline(h=0)
box("figure")
par(mar=c(3,3,1,0))
hist(nile-movAv(nile,5), breaks=25, xlim=c(-500,500), col=4, main="Deviances")
abline(v=0, lwd=5) # the deviances are pretty symmetric.
# If this were shifted more strongly to the left, we could say:
# movav(5) overestimates minima more than it underestimates maxima
# This would happen if low values peak away further and more shortly


# Filling NA's with moving average is possible as well, but look at
# time series analysis for advanced methods to do so.
nileNA <- replace(nile, c(10,12,20), NA)
nile_ma <- movAv(nile, 5)
nileNA_ma <- movAv(nileNA, 5)
\dontrun{graphics.off()}
plot(nile, type="l", xlim=c(1,25), las=1, col=8)
points(nileNA, pch="+", col=8)
points(c(10,12,20), nile[c(10,12,20)])
lines(nile_ma, col=4)
lines(nileNA_ma, col=2)


}
\keyword{ts}
\keyword{manip}
\keyword{smooth}

