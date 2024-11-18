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

codevar <- function(data, max_length = 15, tag = NULL, split = TRUE) {

  ### Argument checks before running the function
  if (!is.data.frame(data)) {
    stop("Input data must be a dataframe.")
  }
  if (max_length < 1) {
    stop("max_length must be at least 1.")
  }

  # Ensure required packages are available
  if (!requireNamespace("tm", quietly = TRUE)) stop("Package 'tm' is required.")
  if (!requireNamespace("SnowballC", quietly = TRUE)) stop("Package 'SnowballC' is required.")

  library(tm)
  library(SnowballC)

  # Initialize a reference dataframe
  coderef <- data.frame(New = character(), Original = character(), Class = character(), stringsAsFactors = FALSE)
  namescol <- colnames(data)

  for (i in seq_along(namescol)) {
    name <- namescol[i]

    # Remove special characters
    name <- gsub('[^[:alnum:] ]'," ", name)

    # Convert to lowercase
    name <- tolower(name)

    # Split into words
    if (split == TRUE) {
      name <- unlist(strsplit(name, "\\s+"))
      if (length(words) == 0 || all(words == "")) {
      name <- substr(gsub("\\s+", "", name), 1, max_length)
    }}

    # Create and clean text corpus
    corpus <- VCorpus(VectorSource(name))
    corpus <- tm_map(corpus, content_transformer(tolower))
    corpus <- tm_map(corpus, removePunctuation)
    corpus <- tm_map(corpus, removeWords, stopwords("english"))
    corpus <- tm_map(corpus, stripWhitespace)
    corpus <- tm_map(corpus, stemDocument, language = "english")
    processed_name <- sapply(corpus, content)


    # Equal truncation of words
    total_words <- length(processed_name)
    if (total_words > 0) {
      char_per_word <- floor(max_length / total_words)
      leftover_chars <- max_length %% total_words

      # Truncate each word to char_per_word and distribute leftover characters
      truncated_words <- mapply(function(word, idx) {
        extra_char <- ifelse(idx <= leftover_chars, 1, 0) # Distribute leftover chars
        substr(word, 1, char_per_word + extra_char)
      }, processed_name, seq_along(processed_name))

      # Combine truncated words with underscores
      new_name <- paste(truncated_words, collapse = "_")
    } else {
      new_name <- substr(processed_name, 1, max_length)
    }

    # Ensure syntactic validity
    new_name <- make.names(new_name)

    # Handle duplicate names
    suffix <- 1
    base_name <- new_name
    while (new_name %in% coderef$New) {
      new_name <- paste0(base_name, "_", suffix)
      suffix <- suffix + 1
    }

    # Add the tag to the end of the new name if tag is not NULL
    if (!is.null(tag)) {
      new_name <- paste0(new_name, tag)
    }

    # Store in coderef
    coderef <- rbind(
      coderef,
      data.frame(
        New = new_name,
        Original = colnames(data)[i],
        Class = class(data[[i]]),
        stringsAsFactors = FALSE
      )
    )
  }
  assign("coderef", coderef, .GlobalEnv)
  print(coderef[,1])
}


