\name{nseVarTd}
\alias{nseVarTd}
\alias{adjVarTd}
\title{
  Time-delay corrected performance measure
}
\description{
  adjVarTd coalesces modelled flow peaks to
  observed flow peaks for each event separately. nseVarTd calculates
  Nash-Sutcliffe efficiency on the result using \code{\link{nseStat}}.
  Depending on the quality of the coalescing, this better indicate
  performance ignoring timing error.
}
\usage{
nseVarTd(obs, mod, event,...)
adjVarTd(obs,mod,event,...)
}
\arguments{
  \item{obs}{
    observed data vector
}
  \item{mod}{
    model-predicted data vector corresponding to \code{obs}.
}
  \item{event}{
    zoo object of events, as returned by \code{\link{eventseq}}
  }
  \item{\dots}{
    Additional arguments to \code{\link{nseStat}} and
    \code{\link{estimateDelay}}.
}
}
\details{
 The success of this method in minimising the effect of timing error depends on how well modelled and observed peaks can be coalesced. This depends on:
\itemize{
\item \code{event} - The separation into events - too short events result in spurious cross-correlations, too long events may not adequately capture the variability in lag. Other settings of \code{\link{eventseq}} may also have an effect.
\item \code{lag.max} - How long a lag is considered. Too long may result
in correlations between peaks, too short will fail to consider the true
peak. Instead of passing it as an argument, consider setting max.delay using \code{link{hydromad.options}}
\item Other settings of \code{\link{estimateDelay}} may also have an
effect.
\item The function currently considers both positive and negative lag up
to \code{lag.max}. This can not be overridden.
}
Also note that large numbers of events will run slower.
}
\value{
  For nseVarTd, a single numeric value.
  For adjVarTd, a zoo object with the original modelled and observed
  data, the adjusted model output and the lag estimated for each event.
}
\author{
  Joseph Guillaume
}
\seealso{
  \code{\link{hydromad.stats}},\code{\link{nseStat}},\code{\link{objFunVal}}
}
\examples{

data(Murrindindi)
x <- Murrindindi[1:100]
x <- merge(x,X=lag(x$Q,2))

event <- eventseq(x$P, thresh = 5, inthresh = 3.5, indur = 7, continue = TRUE)

nseStat(x$Q,x$X)
nseVarTd(x$Q,x$X,event,lag.max=3)

## Avoiding passing lag.max
hydromad.getOption("max.delay") ## Current setting - default is 10
hydromad.options(max.delay=3)

nseVarTd(x$Q,x$X,event)
hmadstat("r.sq.vartd")(x$Q,x$X,event=event)
}
\keyword{ts}
