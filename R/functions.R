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
  version <- Sys.Date()
  
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

###### Function 2 - ibm_tone

#' Analyze some text for tone using IBM Watson.
#' @description This returns the result of the tone analysis on the provided text.
#' @param t_username Username.
#' @param t_password Password.
#' @param t_text Text to be analysed.
#' @keywords ibm watson sentiment tone analysis api
#' @export
#' @examples
#' ibm_sent("t_username", "t_password", "t_text")
#' ibm_sent("xxx-xxx-xxx", "abcdeabcde", "this is some text to analyse for tone")


ibm_tone <- function(t_username, t_password, t_text){
  # Set variables
  t_URL <- "https://watson-api-explorer.mybluemix.net/tone-analyzer/api/v3/tone"
  t_sentences <- "true"
  t_tones <- "emotion,language,social"
  version <- Sys.Date()
  
  # Set main function
  result <- content(GET(t_URL,
                        authenticate(t_username, t_password),
                        query = list(version=version,
                                     text = t_text,
                                     sentences=t_sentences,
                                     tones=t_tones),
                        add_headers(Accept="application/json"),
                        verbose()))
  # Create tibble with one column - number of tones
  result_df <- as.tibble(length(result$document_tone$tones)) %>%
    rename(tones = 1)
  
  # Loop through and extract items
  for(i in seq_along(result$document_tone$tones)){
    result_df <- result_df %>% 
      mutate(!!paste0("score_",i) := result$document_tone$tones[[i]]$score) %>% 
      mutate(!!paste0("tone_id_",i) := result$document_tone$tones[[i]]$tone_id) %>% 
      mutate(!!paste0("tone_name_",i) := result$document_tone$tones[[i]]$tone_name)
  }
  
  result_df <- result_df
}
