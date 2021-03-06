\name{normPlot}
\alias{normPlot}
\title{normal density plot}
\description{nice plot of normal density distribution}
\usage{normPlot(mean=0, sd=1, width=3, lines=TRUE,
quant=TRUE, fill=addAlpha("blue",c(2:6,7:2)/10), cumulative=TRUE, las=1,
main=paste("Normal density with\\nmean =", signif(mean,2), "and sd =", signif(sd,2)),
ylim=lim0(dnorm(mean, mean, sd)), ylab="", xlab="", type="n", lty=1, col=par("fg"),
mar=c(2,3,3,3), keeppar=FALSE, ... )}
\arguments{
  \item{mean}{average value as in \code{\link{dnorm}}. DEFAULT: 0}
  \item{sd}{standard deviation. DEFAULT: 1}
  \item{width}{distance (in sd) from plot ends to mean. DEFAULT: 3}
  \item{lines}{Should vertical lines be plotted at mean +- n*sd? DEFAULT: TRUE}
  \item{quant}{should quantile regions be drawn with \code{fill} colors? DEFAULT: TRUE}
  \item{fill}{color(s) passed to \code{\link{polygon}}. DEFAULT: addAlpha("blue",c(2:6,7:2)/10)}
  \item{cumulative}{Should cumulative density distribution be added? DEFAULT: TRUE}
  \item{las}{arguments passed to \code{\link{plot}}. DEFAULT: 1}
  \item{main}{main as in \code{\link{plot}}. DEFAULT: paste("Normal density with\\nmean =", mean, "and sd =", sd)}
  \item{ylim}{limit for the y axis. DEFAULT: lim0(y)}
  \item{ylab, xlab}{labels for the axes. DEFAULT: ""}
  \item{type, lty, col}{arguments passed to \code{\link{lines}}. type="l" to add pdf line}
  \item{mar}{margins for plot passed to \code{\link{par}}. DEFAULT: c(2,3,3,3)}
  \item{keeppar}{should margin parameters be kept instead of being restored to previous value? DEFAULT: FALSE}
  \item{\dots}{further arguments passed to \code{\link{plot}} like lwd, xaxs, cex.axis, etc.}
}
\details{This function finds some nice defaults for very quickly plotting a normal distribution by just specifying mean and sd.}
\value{None. Used for plotting.}
\author{Berry Boessenkool, \email{berry-b@gmx.de}, July 2014}
\seealso{\code{\link{betaPlot}}, \code{\link{dnorm}}, \url{http://cran.r-project.org/package=denstrip}, \url{http://cran.r-project.org/web/views/Distributions.html} }
\examples{
normPlot()
normPlot(81.7, 11.45)
normPlot(180, 11, quant=FALSE, width=2)
}
\keyword{hplot}
\keyword{distribution}
