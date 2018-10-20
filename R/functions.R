# Set functions

###### Function 1 - ibm_sent

#' Analyze some text for sentiment using IBM Watson.
#' @description This returns the result of the sentiment analysis on the provided text.
#' @param s_username Username.
#' @param s_password Password.
#' @param s_text Text to be analysed.
#' @keywords ibm watson sentiment tone analysis api
#' @export
#' @examples
#' ibm_sent("s_username", "s_password", "s_text")
#' ibm_sent("xxx-xxx-xxx", "abcdeabcde", "this is some text to analyse for sentiment")


ibm_sent <- function(s_username, s_password, s_text){
  # Set variables
  s_URL <- "https://gateway.watsonplatform.net/natural-language-understanding/api/v1/analyze"
  features <- "sentiment,keywords"
  #version <- Sys.Date()
  version <- "2018-10-15"
  
  # Set main function
  result <- content(GET(s_URL,
                        authenticate(s_username, s_password),
                        query = list(version=version,
                                     text=s_text,
                                     features=features),
                        add_headers(Accept="application/json"),
                        verbose()))
  
  # Extract consistent first and second level list items
  result_df <- cbind(as.tibble(flatten(result$usage)),
                     as.tibble(flatten(result$sentiment$document))) %>%
    mutate(language = result$language)
  
  # Extract items of unknown quantity and add into tibble from above
  for(i in seq_along(result$keywords)){
    result_df <- result_df %>% 
      mutate(!!paste0("keywd_text_",i) := result$keywords[[i]]$text) %>% 
      mutate(!!paste0("keywd_relevance_",i) := result$keywords[[i]]$relevance)
  }
  
  result_df <- result_df
}
