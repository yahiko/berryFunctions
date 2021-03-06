\name{classify}
\alias{classify}
\title{classification into groups}
\description{classify continuous values into categories with different methods:\cr
- linearly or logarithmically spaced equal intervals,\cr
- intervals based on quantiles (equally filled bins),\cr
- intervals based on  distance from the mean in normal distributions,\cr
- user specified class borders (e.g. for legal or critical limits).}
\usage{classify(x, method="equalinterval", breaks, Range=range(x, finite=TRUE),
sdlab=1, quiet=FALSE)}
\arguments{
  \item{x}{Vector with numeric values}
  \item{method}{Character string (partial matching is performed). Classification method or type of binning to compute the class breakpoints. See section Details. DEFAULT: "equalinterval")}
  \item{breaks}{Specification for method, see Details. DEFAULT: different defaults for each method}
  \item{Range}{Ends of color bar for method=equalinterval. DEFAULT: range(x, finite=TRUE)}
  \item{sdlab}{Type of label and breakpoints if \code{method=standarddeviation}. 1 means \code{-0.5 sd, 0.5 sd}, 2 means \code{-1 sd, mean, 1 sd}, 3 means actual numbers for type 1, 4 means numbers for type 2.}
  \item{quiet}{Suppress warnings, eg for values outside Range? DEFAULT: FALSE}
}
\details{
Binning methods are explained very nicely in the link in the section References.\cr
\emph{nbins} indicates the number of classes (and thus, colors).\cr \cr

\tabular{llll}{
\bold{\code{method}}     \tab |  explanation                         \tab |  meaning of \code{breaks}                             \tab |  default   \cr
----------               \tab |  -----------                         \tab |  -----------                                          \tab |  -------   \cr
\bold{equalinterval}     \tab |  \emph{nbins} equally spaced classes \tab |  nbins                                                \tab |  100       \cr
\bold{quantile}          \tab |  classes have equal number of values \tab |  the quantiles (or number of them)                    \tab |  0:4/4     \cr
\bold{standarddeviation} \tab |  normal distributions                \tab |  the number of sd in one direction from the mean      \tab |  3         \cr
\bold{logspaced}         \tab |  \emph{nbins} logarithmically spaced \tab |  c(nbins, base),  see \code{\link{logSpaced}}         \tab |  c(100,1.2)\cr
\bold{usergiven}         \tab |  custom breakpoints                  \tab |  personal breakpoint values (including ends of Range) \tab |  none      \cr
}
The default is set to equalinterval which makes sense for my original intent
of plotting lake depth (bathymetry measured at irregularly distributed points) on a linear color scale.\cr
This is the workhorse for \code{\link{colPoints}}.\cr
}
\value{list with class numbers (index) and other elements for \code{\link{colPoints}}}
\author{Berry Boessenkool, \email{berry-b@gmx.de}, 2014}
\references{See this page on the effect of classification (binning) methods: \cr
     \url{http://uxblog.idvsolutions.com/2011/10/telling-truth.html}}
\seealso{\code{\link{colPoints}} }
\examples{
classify( c(1:10, 20), breaks=12)
classify( c(1:10, 20), "q", breaks=0:10/10)
classify( c(1:10, 20), "s", sdlab=2 )
classify( c(1:10, 20), "s", sdlab=1, breaks=2 )
classify( c(1:10, 20), "u", breaks=c(5,27) )
classify( c(1:10, 20), "l")

}
\keyword{classif}
