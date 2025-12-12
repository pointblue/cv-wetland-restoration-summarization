# Script to download data

# Load definitions
def_file <- file.path(file.path(getwd(), "code/00_definitions.R"))
source(def_file)

# Source code
sapply(list.files(fxn_dir, pattern = ".R$", full.names = TRUE), FUN = source)

# Parameters
overwrite <- FALSE #whether or not to overwrite existing downloads

# Files to download if missing
file_df <- data.frame(Filename = c("Future_AllBirds_DecFeb.CAZ_E.rank.compressed.tif",
                                   "Future_AllBirdsGGS_SeptNov.CAZ_E.rank.compressed"),
                      URL = c("https://drive.google.com/file/d/14OvljnwytC6BdkghgFMDpNvXN6EQsGcI/view?usp=drive_link",
                              "https://drive.google.com/file/d/1TIJp_7-cauojvJko6EErbJ0EYpIHESyR/view?usp=drive_link"),
                      Directory = c(fut_dir, 
                                    fut_dir))

# Loop across files
for (n in 1:nrow(file_df)) {
  
  fn <- file_df$Filename[n]
  url <- file_df$URL[n]
  fdir <- file_df$Directory[n]
  message_ts("Checking file ", fn)  
  
  out_file <- file.path(fdir, fn)
  
  if (!file.exists(out_file) | overwrite == TRUE) {
    
    message_ts("Downloading file")
    download.file(url, file.path(fdir, "temp.zip"))
    message_ts("Download complete")
    
  } else {
    
    message_ts("File ", fn, " already downloaded.")
    
  }
  
  
}

# Current 
cur_df <- data.frame()

# Future
fut_df <- data.frame(Filename = c("Future_AllBirds_DecFeb.CAZ_E.rank.compressed.tif",
                                  "Future_AllBirdsGGS_SeptNov.CAZ_E.rank.compressed"),
                     Link = c("https://drive.google.com/file/d/14OvljnwytC6BdkghgFMDpNvXN6EQsGcI/view?usp=drive_link",
                              "https://drive.google.com/file/d/1TIJp_7-cauojvJko6EErbJ0EYpIHESyR/view?usp=drive_link"))

# Simulated suitability
sim_suit_df <- data.frame(Filename = c(),
                          Species = c(),
                          Months = c())

# Simulated zonation
sim_zon_df <- data.frame()

            