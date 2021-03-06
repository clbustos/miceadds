\name{write.mice.imputation}
\alias{write.mice.imputation}
%- Also NEED an '\alias' for EACH other topic documented here.

\title{
Export Multiply Imputed Datasets from a \code{mids} Object
}


\description{
Exports multiply imputed datasets and information about the imputation.
Objects of class \code{mids} (generated by \code{\link[mice:mice]{mice::mice}})
and \code{mids.1chain} (generated by \code{\link{mice.1chain}}) are supported.
}

% \code{\link[mice:mice]{mice}}

\usage{
write.mice.imputation(mi.res, name, include.varnames = TRUE,
      long = TRUE, mids2spss = TRUE, spss.dec = ",", dattype = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{mi.res}{
Object of class \code{mids} or \code{mids.1chain}
}
  \item{name}{
Name of created folder and datasets
}
  \item{include.varnames}{
An optional logical indicating whether variable names should be included
in the imputed dataset. The default is \code{TRUE}. 
}
  \item{long}{
An optional logical indicating whether the dataset should also
be saved in a long format?
}
\item{mids2spss}{
An optional logical indicating whether a syntax for reading imputed datasets 
in SPSS should be included
}
  \item{spss.dec}{
SPSS decimal separator (can be \code{","} or \code{"."})
}
\item{dattype}{
Format of the saved dataset: \code{csv} or \code{csv2}
}
}

%\details{
%%  ~~ If necessary, more details than the description above ~~
%}
\value{
Several files are saved using \code{impxxx} (the \code{name})
as the prefix:

 \item{impxxx.Rdata}{Saved object of class \code{mids}}
 \item{impxxx__DATALIST.Rdata}{Saved object of a list containing multiply
 imputed datasets}
 \item{impxxx__IMP_LIST}{File with list of multiply imputed datasets}
 \item{impxxx__IMP_SUMMARY}{Summary file of the imputation} 
 \item{impxxx__IMPDATA_nn}{Imputed datasets \code{nn}}
 \item{impxxx__IMPMETHOD}{File containing imputation methods}
 \item{impxxx__LEGENDE}{File with variable names of the dataset}
 \item{impxxx__LONG}{Imputed datasets in long format}
 \item{impxxx__PREDICTORMATRIX}{File containing the predictor matrix}
\item{impxxx__SPSS.sps}{SPSS syntax for reading the corresponding
\code{txt} file into SPSS format.} 
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
See also \code{\link[mice:mids2mplus]{mice::mids2mplus}} and 
\code{\link[mice:mids2spss]{mice::mids2spss}}
}


\examples{
\dontrun{
#############################################################################
# EXAMPLE 1: Imputation of nhanes data and write imputed datasets on disk
#############################################################################

data(nhanes,package="mice")

#**********
# Model 1: Imputation using mice
imp1 <- mice( nhanes , m=3 , maxit=5 )
# write results
write.mice.imputation(mi.res=imp1 , name="mice_imp1" )

#**********
# Model 2: Imputation using mice.1chain
imp2 <- mice.1chain( nhanes , burnin=10 , iter=20 , Nimp=4 )
# write results
write.mice.imputation(mi.res=imp2 , name="mice_imp2" )
}
}



% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{mice utility function}
\keyword{mids}
% \keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
