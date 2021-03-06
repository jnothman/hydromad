\name{evalPars}
\alias{evalPars}
\title{
Evaluate a model for a matrix of parameters
}
\description{
\code{evalPars} evaluates a model for a named matrix of parameters.
}
\usage{
evalPars(par.matrix, object, objective = hydromad.getOption("objective"),
  parallel=hydromad.getOption("parallel")[["evalPars"]]
)
}
\arguments{
  \item{par.matrix}{
	Named matrix or data.frame of parameter values, with each row corresponding to a model realisation to evaluate
}
  \item{object}{
    an object of class \code{hydromad}.
}
  \item{objective}{
    the objective function or expression, which can refer to Q and X.  See \code{\link{objFunVal.hydromad}}
}
  \item{parallel}{
    Which parallelisation method to use. Options are \code{"clusterApply"} and \code{"foreach"}. For any other value, parameters will be evaluated sequentially. Default is \code{"none"}. For more information see \code{\link{hydromad_parallelisation}}.
}
}
\details{
\code{evalPars} is used in conjunction with \code{\link{getFreeParsRanges}} and the \code{sensitivity} package to perform sensitivity analysis. See \code{demo(sensitivity)}. Note that the objective function may more generally return any scalar result, e.g. a scalar prediction calculated only using X.

Individual model evaluations are generally very fast, so parallelisation is only really worthwhile when large numbers of evaluations are needed. \code{"clusterApply"} has a slightly lower overhead. \code{"foreach"} allows a broader range of options.
}
\value{
evalPars returns a vector of objective function values, corresponding to the evaluation of each row of \code{par.matrix}.
}
\author{
Joseph Guillaume
}
\seealso{
\code{\link{objFunVal.hydromad}}, \code{\link{parameterSets}}, \code{\link{getFreeParsRanges}}
}
\examples{
data(Cotter)
obs<-Cotter[1:1000]
modx <- hydromad(obs, sma = "cmd", routing = "expuh",
tau_s = c(2,100), v_s = c(0,1))

## Sample 10 random parameter sets for parameters with defined ranges
pars <- parameterSets(getFreeParsRanges(modx),10,method="random")

## Return the default objective function value for each model realisation
evalPars(pars,object=modx)

## Calculate the 20%ile flow for each model realisation
evalPars(pars,object=modx,objective=~quantile(X,0.2))

## Alternatively, sample 10 random parameter sets from all parameters
##  This allows specifying discrete values of parameters
pars <- parameterSets(coef(modx,warn=FALSE),10,method="random")

}
\keyword{models}
