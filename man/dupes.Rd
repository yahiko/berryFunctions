\name{dupes}
\alias{dupes}
\title{Duplicate lines in file}
\description{
Number of duplicates per line of (text) file.
Per default saved to file which can be loaded into excel / libreoffice.
With conditional formatting of the first column, colors show for each line how often it occurs in the file.
A LibreOffice file is included.
Note: OpenOffice does not provide color scales based on cell values.
}
\usage{dupes(file, ignore.empty=TRUE, ignore.space=TRUE, tofile=missing(n), n=length(d) )}
\arguments{
  \item{file}{File name (character string)}
  \item{ignore.empty}{Should empty lines be ignored? DEFAULT: TRUE}
  \item{ignore.space}{Should leading/trailing whitespace be ignored? DEFAULT: TRUE}
  \item{tofile}{Logical: should output be directed to a file? Otherwise, a dataframe with line numbers and number of duplicates of that line will be printed in the console. DEFAULT: missing(n)}
  \item{n}{Show only the first n values if \code{tofile=FALSE}. DEFAULT: length(d)}
}
\value{Either: a data.frame with line numbers of duplicate rows and the number of duplicates\cr
Or: a file is written with the number of duplicates and the original \code{file} content.}
\note{This has not been tested al that much - feedback is heavily welcome!}
\author{Berry Boessenkool, \email{berry-b@gmx.de}, 2015}
\seealso{\code{\link{compareFiles}} }
\examples{

file <- system.file("extdata/doublelines.txt", package="berryFunctions")
dupes(file, tofile=FALSE)
dupes(file, tofile=FALSE, ignore.empty=TRUE)  

## These are skipped by rcmd check (opening external places is not allowed):
\dontrun{dupes(file)}

# a template file (dupes.ods) for libreOffice Calc is available here:
system.file("extdata", package="berryFunctions")

\dontrun{system2("nautilus", system.file("extdata/dupes.ods", package="berryFunctions"))}

# To open folders with system2:
# "nautilus" on linux ubuntu
# "open" or "dolphin" on mac
# "explorer" or "start" on windows
}
\keyword{IO}
\keyword{file}
\keyword{character}
