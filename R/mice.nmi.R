
###############################################
# nested multiple imputation
mice.nmi <- function( datlist , type="mice" , ... ){

	ND <- length(datlist)
	imp <- list()
    
	cat("------ NESTED MULTIPLE IMPUTATION ------\n")
	for (dd in 1:ND){		
		data <- datlist[[dd]]
		cat("\n**************************************************\n")
		cat("***** Imputation Between Dataset" , dd , "******\n\n" )
		if ( type == "mice" ){
			imp[[dd]] <- mice::mice( data , ... )										
							}
		if ( type == "mice.1chain" ){
			imp[[dd]] <- mice.1chain( data , ... )										
							}							
			    }
	res <- list("imp" = imp , "type" = type )	
	if ( type=="mice"){
		NW <- imp[[1]]$m
					}
	if ( type=="mice.1chain"){
		NW <- imp[[1]]$Nimp
					}					
	res$Nimp <- c ("between"=ND , "within" = NW )	
    class(res) <- "mids.nmi"	
	return(res)
		}
##################################################		
# summary method
summary.mids.nmi <- function( object , ... ){
	cat("Nested Multiple Imputation\n\n")
	Nimp <- object$Nimp
	cat( paste0("Number of between datasets = " , Nimp["between"] , "\n") )
	cat( paste0("Number of within datasets = " , Nimp["within"] , "\n\n") )
	imp0 <- object$imp[[1]]
	summary(imp0)
			}
####################################################			