# Defines basic functions used by the summarization script

# Basic logging function to add a timestamp to strings
add_ts <- function(...) paste0("[", format(Sys.time(), format = "%Y-%m-%d %H:%M:%S"), "] - ", ...)

# Add as wrapper for base 'message' function
message_ts <- function(...) message(add_ts(...))

# Add as wrapper for base 'warning' function
warning_ts <- function(...) warning(add_ts(...))

# Add as wrapper for base 'stop' function
stop_ts <- function(...) stop_ts

# Function to get the nth subelement from each item in a list
extract_subelement <- function(x, element) sapply(x, `[[`, element) 

# Function to make a string filename safe
clean_string <- function(x, sub_char = "-", ...) {
  y <- gsub("[^a-zA-Z0-9_\\-]", sub_char, x, ...)
  
  # Condense multiple sub_chars
  y <- gsub(paste0(sub_char, "+"), sub_char, y, ...)
  
  # Drop terminal sub_char
  y <- gsub(paste0(sub_char, "$"), "", y, ...)
  
  return(y)
}
