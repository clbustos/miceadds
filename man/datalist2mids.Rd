\name{datalist2mids}
\alias{datalist2mids}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Converting a List of Multiply Imputed Data Sets into a \code{mids} Object
}
\description{
This function converts a list of multiply imputed data sets
to a \code{\link[mice:mids]{mice::mids}} object.
}
%% mids-class {mice}

\usage{
datalist2mids(dat.list, progress = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dat.list}{
List of multiply imputed data sets
}
  \item{progress}{
An optional logical indicating whether conversion process be displayed
}
}

%\details{
%%  ~~ If necessary, more details than the description above ~~
%}


\value{
An object of class \code{mids}
}

%\references{
%% ~put references to the literature/web site here ~
%}


\author{
Alexander Robitzsch
}


%\note{
%%  ~~further notes~~
%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
See \code{\link[mice:as.mids]{mice::as.mids}} for converting
a multiply imputed dataset in long format into a \code{mids} object.
}

\examples{
#############################################################################
# EXAMPLE 1: Imputation of NHANES data using Amelia package
#############################################################################

library(mice)
library(Amelia)

data(nhanes,package="mice")
set.seed(566)  # fix random seed

# impute 10 datasets using Amelia
a.out <- Amelia::amelia(x =  nhanes , m=10)
# plot of observed and imputed data
plot(a.out)

# convert list of multiply imputed datasets into a mids object
a.mids <- datalist2mids( a.out$imputations )

# linear regression: apply mice functionality lm.mids
mod <- with( a.mids , lm( bmi ~ age ) )
summary( pool( mod ) )
  ##                     est      se         t       df     Pr(>|t|)    lo 95
  ##   (Intercept) 30.718881 2.22960 13.777753 12.58135 5.830925e-09 25.88578
  ##   age         -2.435746 1.08551 -2.243872 14.93153 4.043506e-02 -4.75038
  ##                    hi 95 nmis       fmi    lambda
  ##   (Intercept) 35.5519834   NA 0.4013689 0.3132139
  ##   age         -0.1211117    0 0.3153636 0.2294162

\dontrun{
# fit linear regression model in Zelig
library(Zelig)
mod2 <- Zelig::zelig( bmi ~ age , model="ls" , data=a.out$imputations , cite=FALSE)
summary(mod2)
  ##   > summary(mod2)
  ##   
  ##     Model: ls
  ##     Number of multiply imputed data sets: 10 
  ##   
  ##   Combined results:
  ##   
  ##   Call:
  ##   lm(formula = formula, weights = weights, model = F, data = data)
  ##   
  ##   Coefficients:
  ##                   Value Std. Error    t-stat      p-value
  ##   (Intercept) 30.718881    2.22960 13.777753 4.603995e-24
  ##   age         -2.435746    1.08551 -2.243872 2.612377e-02
  ##   
  ##   For combined results from datasets i to j, use summary(x, subset = i:j).
  ##   For separate results, use print(summary(x), subset = i:j).

# fit linear regression using mitools package
library(mitools)
datimp <- mitools::imputationList(a.out$imputations)
mod3 <- with( datimp, lm( bmi ~ age ) )
summary( mitools::MIcombine( mod3 ) )
  ##  Multiple imputation results:
  ##        with(datimp, lm(bmi ~ age))
  ##        MIcombine.default(mod3)
  ##                results      se    (lower     upper) missInfo
  ##  (Intercept) 30.718881 2.22960 26.290536 35.1472266     33 %
  ##  age         -2.435746 1.08551 -4.578471 -0.2930208     24 %  
}
}


\keyword{mids}
\keyword{mice utility function}
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
