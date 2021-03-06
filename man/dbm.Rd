\name{dbm}
\alias{dbm}
\alias{dbm.sim}
\alias{absorbScale.hydromad.dbm}
\title{ Typical initial model used in Data-Based Mechanistic modelling. }
\description{
  Typical initial model used in Data-Based Mechanistic modelling.
  Rainfall is scaled by corresponding streamflow values raised to a power.
  This SMA uses streamflow data, so can not be used for prediction.
}
\usage{
dbm.sim(DATA, power, qlag = 0, scale = 1, return_state = FALSE)
}
\arguments{
  \item{DATA}{
    time-series-like object with columns \code{P} (precipitation) and
    \code{Q} (streamflow).
  }
  \item{power}{
    power to apply to streamflow values.
  }
  \item{qlag}{
    number of time steps to lag the streamflow (relative to rainfall)
    before multiplication.
  }
  \item{scale}{
    constant multiplier of the result, for mass balance.
    If this parameter is set to \code{NA} (as it is by default)
    in \code{\link{hydromad}} it will be set by mass balance calculation. 
  }
  \item{return_state}{ignored.}
}
\value{
  the simulated effective rainfall, a time series of the same length as
  the input series.  
}
\author{ Felix Andrews \email{felix@nfrac.org} }
\seealso{
  \code{\link{hydromad}(sma = "dbm")} to work with models as objects (recommended).
}
\examples{
## view default parameter ranges:
str(hydromad.options("dbm"))

data(HydroTestData)
mod0 <- hydromad(HydroTestData, sma = "dbm", routing = "expuh")
mod0

## simulate with some arbitrary parameter values
mod1 <- update(mod0, power = 0.5, qlag = 0, tau_s = 10)

xyplot(cbind(HydroTestData, dbm.Q = predict(mod1)))

## show effect of increase/decrease in each parameter
parRanges <- list(power = c(0.01, 0.9), qlag = c(-1, 2))
parsims <- mapply(val = parRanges, nm = names(parRanges),
  FUN = function(val, nm) {
    lopar <- min(val)
    hipar <- max(val)
    names(lopar) <- names(hipar) <- nm
    fitted(runlist(decrease = update(mod1, newpars = lopar),
                   increase = update(mod1, newpars = hipar)))
  }, SIMPLIFY = FALSE)

xyplot.list(parsims, superpose = TRUE, layout = c(1,NA),
            main = "Simple parameter perturbation example") +
  layer(panel.lines(fitted(mod1), col = "grey", lwd = 2))
}
\keyword{models}
