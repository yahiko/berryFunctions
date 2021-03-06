\name{pointZoom}
\alias{pointZoom}
\title{zoom in originally static x11 graphics}
\description{zoom in x11 graphics - uses locator to define region to zoom into}
\usage{pointZoom(x, y=NA, z=NA, Time=1, steps=30, las=1, usecolp=FALSE,
xlab=substitute(x), ylab=substitute(y), quiet=FALSE, expr, ...)}
\arguments{
  \item{x}{same x coordinates as in current plot. x can be a matrix, then the y (and z) coordinates are taken from the second (and third) column.}
  \item{y}{ditto}
  \item{z}{if using colpoints, z-value }
  \item{Time}{Duration of zooming (speed) in seconds. DEFAULT: 1}
  \item{steps}{number of single zoomlevels. DEFAULT: 30}
  \item{las}{label axis style, see \code{\link{par}}. DEFAULT: 1}
  \item{usecolp}{logical: use \code{\link{colPoints}} when zooming? DEFAULT: FALSE}
  \item{xlab}{xlabel See \code{\link{plot}}. DEFAULT: substitute(x)}
  \item{ylab}{dito}
  \item{quiet}{logical. Should notifications (instructions) be written to the console? DEFAULT: FALSE}
  \item{expr}{Characterized Expression to be executed after each plot, eg. \code{expr='abline(h=3)'}}
  \item{\dots}{further arguments passed to \code{\link{plot}} or \code{\link{colPoints}}.}
}
\value{none, works in existing graphics}
\author{Berry Boessenkool, \email{berry-b@gmx.de}, ca 2012}
\note{Extensive testing is yet to be done!}

\seealso{shapeZoom in \url{https://github.com/brry/shapeInteractive}, \code{\link{colPoints}}, \code{\link{locator}} }
\examples{
## Examples rely on locator, so can't be checked in non-interactive R use.
\dontrun{
## Rcmd check --as-cran doesn't like to open external devices,
## so this example is excluded from running in the checks.
a <- rnorm(90); b <- rexp(90)
windows(record=TRUE) # turn recording on
plot(a,b, las=1)
pointZoom(a,b, col=2, expr="abline(v=0)")
# now scroll through the plots (Pg Up and Pg Dn) to unzoom again.

d <- data.frame(a,b)
class(d)
plot(d)
pointZoom(d)
}
}
\keyword{aplot}
\keyword{iplot}
\keyword{dynamic}
