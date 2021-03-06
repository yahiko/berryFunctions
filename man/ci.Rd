\name{ci}
\alias{ci}
\title{calculate confidence interval around mean}
\description{calculate the ends of the confidence interval around mean using \code{\link{t.test}}}
\usage{ci(dat, lev = 0.95, digits = 3)}
\arguments{
  \item{dat}{vector with the data to use.}
  \item{lev}{numeric. confidence level. DEFAULT: 0.95}
  \item{digits}{integer. Number of digits rounded to in output. DEFAULT: 3}
}
\value{A dataframe with the lower and upper confidence interval, as well as the level used.}
\details{Remember that CIs are used when insecurities about the inference from a sample to a general population need quantification, not for hypothesis testing. If two confidence intervals overlap, the difference between the two means still may be significantly different. }
\author{Berry Boessenkool, \email{berry-b@gmx.de}, 2010}
\references{For newbies: Charles Wheelan: naked statistics - stripping the dread from the data, 2013, Norton, ISBN 978-0-393-07195-5.\cr
For statisticians: any of your favorite statistics books should cover confidence intervalls ;-)\cr
\url{http://en.wikipedia.org/wiki/Confidence_interval}\cr
Wolfe R, Hanley J (Jan 2002). "If we're so different, why do we keep overlapping? When 1 plus 1 doesn't make 2"\cr
\url{http://www.ecmaj.ca/content/166/1/65.full.pdf}\cr
Goldstein, H.; Healey, M.J.R. (1995). "The graphical presentation of a collection of means". Journal of the Royal Statistical Society\cr
\url{http://www.jstor.org/stable/2983411}
}
\seealso{\code{\link{t.test}} , \code{\link{cie}}}
\examples{
yourdata <- c(5:8,3,14)
ci(yourdata)          # confidence interval with the default confidence level (95%)
ci(yourdata, 0.99)    # specified with a different confidence level 
ci(yourdata, 0.99, 4) # returns 4 decimal places
ci(yourdata,,2)       # rounds to 2 decimal places with default level
ci(yourdata)[1,1]     # returns lower boundary of the interval as a numeric
ci(yourdata)[1,2]     # returns upper boundary of the interval as a numeric
ci                    # shows the function itself
}                        
\keyword{htest}

