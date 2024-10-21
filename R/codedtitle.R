#' @title Code Variable Names of Dataframe
#' @description Take a dataset and change column names to manageable
#' coded variables names based on a desired string-length. This function also
#' removes all spaces and makes all characters lower-case.
#' @param dataframe with named columns
#' @return dataframe with recoded column names
#' @author Mohsyn Imran Malik
#' @examples
#' codetitle(data, strlength = 3)
#' @export

codevar <- function(data, strlength) {
  collength <- nchar(colnames(data))
  namescol <- colnames(data)
  for (i in 1:(length(collength))) {
    if (collength[i] > strlength) {
      namescol[i] <- gsub(" ", "",
                                 tolower(
                                   substr(namescol[i], 1, strlength)))
    }
    else {
      namescol[i] <- gsub(" ", "",
                                 tolower(namescol[i]))

    }
    if (namescol[i] %in% namescol[length(collength)-i] == TRUE) {
        namescol[i] <- gsub(" ","",paste(namescol[i],i))
       }
  }
colnames(data) <- namescol
print(colnames(data))

}


