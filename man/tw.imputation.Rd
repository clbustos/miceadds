\name{tw.imputation}
\alias{tw.imputation}
\alias{tw.mcmc.imputation}

%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Two-Way Imputation
}
\description{
Two-way imputation using the simple method of Sijtsma and van der Ark (2003)
and the MCMC based imputation of van Ginkel et al. (2007).
}
\usage{
tw.imputation(data, integer = FALSE)

tw.mcmc.imputation(data, iter = 100, integer = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
\item{data}{
Matrix of item responses corresponding to a scale
}
\item{integer}{
A logical indicating whether imputed values should be integers.
The default is \code{FALSE}.
}
\item{iter}{Number of iterations}
}

\details{
For persons \eqn{p} and items \eqn{i}, the two-way imputation is conducted
by posing a linear model of tau-equivalent measurements:
\deqn{X_{pi} = \theta_p + b_i + \varepsilon_{ij} }
If the score \eqn{X_{pi}} is missing then it is imputed by
\deqn{\hat{X}_{pi} = \tilde{X}_p + b_i } where \eqn{\tilde{X}_p} is the
person mean of person \eqn{p} of the remaining items with observed responses.

The two-way imputation can also be seen as a scaling procedure to obtain
a scale score which takes different item means into account.
}


\value{
A matrix with original and imputed values
}


\references{
Sijtsma, K., & Van der Ark, L. A. (2003). 
Investigation and treatment of missing item scores in test and questionnaire
data. \emph{Multivariate Behavioral Research}, \bold{38}, 505-528.

Van Ginkel, J. R., Van der Ark, A., Sijtsma, K., & Vermunt, J. K. (2007). 
Two-way imputation: A Bayesian method for estimating missing scores in tests 
and questionnaires, and an accurate approximation. 
\emph{Computational Statistics & Data Analysis}, \bold{51}, 4013-4027.
}

\author{
Alexander Robitzsch
}

%\note{
%%  ~~further notes~~
%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

%\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
\examples{
#############################################################################
# EXAMPLE 1: Two-way imputation data.internet
#############################################################################

data(data.internet)
data <- data.internet

#***
# Model 1: Two-way imputation method of Sijtsma and van der Ark (2003)
set.seed(765)
dat.imp <- tw.imputation( data )
dat.imp[ 278:281,]
  ##       IN9     IN10    IN11     IN12
  ##   278   5 4.829006 5.00000 4.941611
  ##   279   5 4.000000 4.78979 4.000000
  ##   280   7 4.000000 7.00000 7.000000
  ##   281   4 3.000000 5.00000 5.000000

\dontrun{
#***
# Model 2: Two-way imputation method using MCMC
dat.imp <- tw.mcmc.imputation( data , iter=3)
dat.imp[ 278:281,]
  ##       IN9     IN10     IN11     IN12
  ##   278   5 6.089222 5.000000 3.017244
  ##   279   5 4.000000 5.063547 4.000000
  ##   280   7 4.000000 7.000000 7.000000
  ##   281   4 3.000000 5.000000 5.000000
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{Two-way imputation}
%% \keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
