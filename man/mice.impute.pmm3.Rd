\name{mice.impute.pmm3}
\alias{mice.impute.pmm3}
\alias{mice.impute.pmm4}
\alias{mice.impute.pmm5}
\alias{mice.impute.pmm6}

%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Imputation by Predictive Mean Matching (in \pkg{miceadds})
}
\description{
This function imputes values by predictive mean matching like
the \code{\link[mice:mice.impute.pmm]{mice::mice.impute.pmm}}  
method in the \pkg{mice} package.
}

\usage{
mice.impute.pmm3(y, ry, x, donors = 3, noise = 10^5, ridge = 10^(-5), ...)
mice.impute.pmm4(y, ry, x, donors = 3, noise = 10^5, ridge = 10^(-5), ...)
mice.impute.pmm5(y, ry, x, donors = 3, noise = 10^5, ridge = 10^(-5), ...)
mice.impute.pmm6(y, ry, x, donors = 3, noise = 10^5, ridge = 10^(-5), ...)
}


%- maybe also 'usage' for other objects documented here.
\arguments{
    \item{y}{Incomplete data vector of length \code{n}}
    
  \item{ry}{
Vector of missing data pattern (\code{FALSE} -- missing,
\code{TRUE} -- observed)
}

  
  \item{x}{Matrix (\code{n} x \code{p}) of complete
  covariates.}
  
    \item{donors}{
Number of donors used for imputation
}

  \item{noise}{
Numerical value to break ties
}
  \item{ridge}{
Ridge parameter in the diagonal of \eqn{ \bold{X}'\bold{X}}
}
  \item{\dots}{
Further arguments to be passed
}
}


\details{
The imputation method \code{pmm3} imitates 
\code{\link[mice:mice.impute.pmm]{mice::mice.impute.pmm}} imputation method
in \pkg{mice}. 

The imputation method \code{pmm4} ignores ties in predicted \eqn{y} values.
With many predictors, this does not probably implies any substantial problem. 

The imputation method \code{pmm5} suffers from the same problem. Contrary to
the other PMM methods, it searches \eqn{D} donors (specified by \code{donors})
smaller than the predicted value and \eqn{D} donors larger than the
predicted value and randomly samples a value from this set of \eqn{2 \cdot D}
donors.

The imputation method \code{pmm6} is just the \pkg{Rcpp} implementation
of \code{pmm5}.
}


\value{
A vector of length \code{nmis=sum(!ry)} with imputed values.
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
See \code{\link{data.largescale}} and \code{\link{data.smallscale}}
for speed comparisons of different functions for predictive mean
matching.
}


\examples{
\dontrun{
#############################################################################
# SIMULATED EXAMPLE 1: Two variables x and y with missing y
#############################################################################	
set.seed(1413)

rho <- .6   # correlation between x and y
N <- 6800    # number of cases
x <- rnorm(N)
My <- .35   # mean of y
y.com <- y <- My + rho * x + rnorm(N , sd = sqrt( 1 - rho^2 ) )

# create missingness on y depending on rho.MAR parameter
rho.mar <- .4    # correlation response tendency z and x
missrate <- .25  # missing response rate
# simulate response tendency z and missings on y
z <- rho.mar * x + rnorm(N , sd = sqrt( 1 - rho.mar^2 ) )
y[ z < qnorm( missrate ) ] <- NA
dat <- data.frame(x , y )

# mice imputation
impmethod <- rep("pmm" , 2 )
names(impmethod) <- colnames(dat)

# pmm (in mice)
imp1 <- mice( as.matrix(dat) , m=1 , maxit=1 , imputationMethod=impmethod) 
# pmm3 (in miceadds)
imp3 <- mice( as.matrix(dat) , m=1 , maxit=1 , 
        imputationMethod=gsub("pmm","pmm3" ,impmethod)  )
# pmm4 (in miceadds)
imp4 <- mice( as.matrix(dat) , m=1 , maxit=1 , 
        imputationMethod=gsub("pmm","pmm4" ,impmethod)  )
# pmm5 (in miceadds)
imp5 <- mice( as.matrix(dat) , m=1 , maxit=1 , 
        imputationMethod=gsub("pmm","pmm5" ,impmethod)  )
# pmm6 (in miceadds)
imp6 <- mice( as.matrix(dat) , m=1 , maxit=1 , 
        imputationMethod=gsub("pmm","pmm6" ,impmethod)  )

dat.imp1 <- complete( imp1 , 1 )
dat.imp3 <- complete( imp3 , 1 )
dat.imp4 <- complete( imp4 , 1 )
dat.imp5 <- complete( imp5 , 1 )
dat.imp6 <- complete( imp6 , 1 )

dfr <- NULL
# means
dfr <- rbind( dfr , c( mean( y.com ) , mean( y , na.rm=TRUE ) , mean( dat.imp1$y)  ,
    mean( dat.imp3$y) , mean( dat.imp4$y)  , mean( dat.imp5$y)  ,  mean( dat.imp6$y)  ) )
# SD
dfr <- rbind( dfr , c( sd( y.com ) , sd( y , na.rm=TRUE ) , sd( dat.imp1$y)  ,
    sd( dat.imp3$y) , sd( dat.imp4$y)  , sd( dat.imp5$y)  , sd( dat.imp6$y) ) )
# correlations
dfr <- rbind( dfr , c( cor( x,y.com ) , cor( x[ ! is.na(y) ] , y[ ! is.na(y) ] ) , 
    cor( dat.imp1$x , dat.imp1$y) , cor( dat.imp3$x , dat.imp3$y) , 
    cor( dat.imp4$x , dat.imp4$y) , cor( dat.imp5$x , dat.imp5$y)  , 
    cor( dat.imp6$x , dat.imp6$y)
        ) )
rownames(dfr) <- c("M_y" , "SD_y" , "cor_xy" )
colnames(dfr) <- c("compl" , "ld" , "pmm" , "pmm3" , "pmm4" , "pmm5","pmm6")
##           compl     ld    pmm   pmm3   pmm4   pmm5   pmm6
##   M_y    0.3306 0.4282 0.3314 0.3228 0.3223 0.3264 0.3310
##   SD_y   0.9910 0.9801 0.9873 0.9887 0.9891 0.9882 0.9877
##   cor_xy 0.6057 0.5950 0.6072 0.6021 0.6100 0.6057 0.6069
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{Predictive mean matching}
\keyword{mice imputation method}
%% \keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
