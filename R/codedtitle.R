#' @title Code Variable Names of Dataframe
#' @description Take a dataset and change column names to manageable
#' coded variables names based on a desired string-length. This function also
#' removes all spaces and makes all characters lower-case. A reference vector is
#' created (coderef) which display the transformed column names and the original
#' column name.
#' @param dataframe with named columns
#' @return dataframe with recoded column names
#' @author Mohsyn Imran Malik
#' @examples
#' codetitle(data, strlength = 3)
#' @export

codevar <- function(data, strlength, tag = NULL) {
  collength <- nchar(colnames(data))
  namescol <- colnames(data)
  coderef <- data.frame(matrix(ncol = length(collength), nrow = 2))
  for (i in 1:(length(collength))) {
    if (collength[i] > strlength) {
      namescol[i] <- paste0(gsub(" ", "",
                                 tolower(
                                   substr(namescol[i], 1, strlength))),tag)
    }
    else {
      namescol[i] <- paste0(gsub(" ", "",
                                 tolower(namescol[i])),tag)

    }
    if (namescol[i] %in% namescol[1:i-1] == TRUE) {
        namescol[i] <- gsub(" ","",paste0(namescol[i],'_',i))
    }
    coderef[1,i] <- namescol[i]
    coderef[2,i] <- colnames(data)[i]
  }
  names(coderef) <- as.character(unlist(coderef[1,]))
  coderef <- coderef[-1,]
  assign("coderef", coderef, .GlobalEnv)
print(namescol)

}


