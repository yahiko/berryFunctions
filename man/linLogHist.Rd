\name{linLogHist}
\alias{linLogHist}
\title{lin-log transition histogram}
\description{draw histograms that gradually transform from a linear to a logarithmic axis}
\usage{linLogHist(x, steps=100, breaks=20, col="blue", las=1,
xlab=deparse(substitute(x)), xlim=range(x, finite=TRUE), box=TRUE, 
parexpr, endexpr, sleep=0,
axisargs=NULL, axisargs2=NULL, firstplot=TRUE, lastplot=TRUE,
write_t=TRUE, values_t=NULL, ...)}
\arguments{
  \item{x}{x values to be plotted in animation}
  \item{steps}{Number of steps in transition. DEFAULT: 100}
  \item{breaks}{\code{\link{hist}} breaks. DEFAULT: 20}
  \item{col}{\code{\link{hist}} color. DEFAULT: "blue"}
  \item{las}{\code{\link{par}} LabelAxisStyle (numbers upright). DEFAULT: 1}
  \item{xlab}{Label for the x axis. DEFAULT: deparse(substitute(x))}
  \item{xlim}{xlim range in non-log units. DEFAULT: range(x, finite=TRUE)}
  \item{box}{Draw box at the end to overplot \code{\link{abline}s} crossing the box? DEFAULT: TRUE}
  \item{parexpr}{Characterized Expression to set \code{\link{par}}, eg. \code{parexpr='par(mar=c(2,0.5,1.5,0.5), mpg=c(1.8,1,0))'}}
  \item{endexpr}{Characterized Expression executed at the end of the plot, eg. \code{endexpr='mtext("Probability Density", line=-1, adj=0.03, outer=T)'}}
  \item{axisargs}{List of arguments passed to \code{\link{logVals}}, like base. DEFAULT: NULL}
  \item{sleep}{Pause time between frames, in seconds, passed to \code{\link{Sys.sleep}}. DEFAULT: 0}
  \item{axisargs2}{List of arguments passed to \code{\link{logAxis}}in the final plot. DEFAULT: NULL}
  \item{firstplot}{plot on linear scale first? DEFAULT: TRUE}
  \item{lastplot}{plot on logarithmic scale at the end? DEFAULT: TRUE}
  \item{write_t}{write transformation value in lower right corner? DEFAULT: TRUE}
  \item{values_t}{Supply vector with values for transformation (1/t). Overides steps. If you have a better algorithm than I do, please let me know! DEFAULT: NULL}
  \item{\dots}{further arguments passed to \code{\link{hist}}, like freq, main, xlim, ylab. Excluded: x, xaxt, possibly add}
}
\value{Returned invisibly: transformation values used. Plotted: \code{steps} number of images.}
\note{It's best to save the plots into a pdf or wrap it within\cr \code{png("Transition\%03d"); linLogHist(x); dev.off()}}
\author{Berry Boessenkool, \email{berry-b@gmx.de}, April 2015}
\seealso{\code{\link{linLogTrans}} }
\examples{
x <- rlnorm(700, m=3)
hist(x, col=4)
hist(log10(x), xaxt="n"); logAxis(1); hist(log10(x), col=4, add=TRUE)

op <- par()
linLogHist(x, steps=8, sleep=0.01) # 0.05 might be smoother

linLogHist(x, xlab="ddd", breaks=30, steps=3, write_t=FALSE, yaxt="n", freq=FALSE,
   main="", parexpr='par(mar=c(2,0.5,1.5,0.5), mgp=c(1.8,1,0))',
   endexpr='mtext("Probability Density", line=-1.2, adj=0.03, outer=T)')
par(op)

\dontrun{
## Rcmd check --as-cran doesn't like to open external devices such as pdf,
## so this example is excluded from running in the checks.
pdf("LinLogTransitionAnimation.pdf")
linLogHist(x, main="Example Transition", steps=20, freq=FALSE)
dev.off()

# if you have FFmpeg installed, you can use the animation package like this:
library2(animation)
saveVideo(linLogHist(x, steps=50), video.name="linlog_anim.mp4", interval=0.08,
ffmpeg="C:/ffmpeg-20150424-git-cd69c0e-win64-static/bin/ffmpeg.exe")
}
}
\keyword{dplot}
\keyword{hplot}
\keyword{dynamic}
