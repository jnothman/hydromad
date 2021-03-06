\name{panel.ribbon}
\alias{panel.ribbon}
\alias{panel.ribbon.default}
\alias{panel.ribbon.ts}
\alias{panel.ribbon.zoo}
\title{
  Plot the area between two series as a filled polygon.
}
\description{
  Plot the area between two series as a filled polygon.
}
\usage{
panel.ribbon(...)

\method{panel.ribbon}{default}(x, y, y2, groups,
             col, border, lty, lwd, alpha, ...,
             col.line, fill, panel.groups = panel.ribbon)

\method{panel.ribbon}{ts}(y, y2 = NULL, ...)
\method{panel.ribbon}{zoo}(y, y2 = NULL, ...)
}
\arguments{
  \item{x, y, y2}{
    data vectors, where y and y2 give lower and upper bounds.
    For the \code{ts} and \code{zoo} methods, \code{y,y2}
    are time series objects; if \code{y2} is missing then \code{y} can
    be a time series with 2 or more columns.
  }
  \item{groups}{
    a factor defining groups.
  }
  \item{col, border, lty, lwd, alpha, col.line}{
    graphical parameters taken from
    \code{trellis.par.get("plot.polygon")} or
    \code{trellis.par.get("superpose.polygon")} (when groups defined).
    \code{col.line} overrides \code{border}.
  }
  \item{\dots}{
    further arguments passed on to \code{\link{panel.polygon}}.
  }
  \item{fill}{
    ignored; use \code{col} instead.
  }
  \item{panel.groups}{
    used in \code{\link{panel.superpose}}.
  }
}
\details{
  none yet.
}
\author{
  Felix Andrews \email{felix@nfrac.org}
}
\seealso{
  \code{\link{panel.xyplot}},
  \code{\link{panel.polygon}}
}
\examples{
xyplot(sunspot.year, aspect = "xy", cut = 3) +
  layer_(panel.ribbon(x, y = y * 0.9, y2 = y * 1.1, ..., col = "grey"))

## missing values are handled by splitting the series
tmp <- window(sunspot.year, start = 1900)
tmp[c(1:2, 50:60)] <- NA
xyplot(tmp, panel = panel.ribbon, y2 = 0)

}
\keyword{ dplot }
