# Script to summarize wetland restoration prioritization by user-selected polygons

## -----------------------
# PARAMETERS TO SET #
#   base_dir should be the path to the folder cv-wetland-restoration-summarization
#   this folder contains the code and data from GitHub.
base_dir <- getwd() #change if you are running this from a different location

# Specify the path and filename of the shapefile containing the polygons of the areas to analyze
poly_file <- file.path(data_dir, "test.shp") #Specify the path and filename of your shapefile. Consider moving to the data folder.

# Analysis parameters
#   Specify which analysis results you are interested in summarizing
#   set to TRUE or FALSE
current_wetlands <- TRUE
future_wetlands <- TRUE
simulated_wetlands <- TRUE
simulated_suitability <- TRUE

## ----------------------
# Define directories
code_dir <- file.path(base_dir, "code")
data_dir <- file.path(base_dir, "data")
out_dir <- file.path(base_dir, "outputs")

cur_wet_dir <- file.path(data_dir, "current_wetland_priority")
fut_wet_dir <- file.path(data_dir, "future_wetland_priority")
sim_wet_dir <- file.path(data_dir, "simulated_wetland_priority")
sim_suit_dir <- file.path(data_dir, "simulated_wetland_suitability")

# Load basic functions
fxn_file <- file.path(code_dir, "01_basic_functions.R")
if (!file.exists(fxn_file)) {
  stop("Cannot locate expected code. There should be a folder called 'code' located in the folder specified as base_dir above.")
}
source(fxn_file)

## -----------------------
# Check inputs
if (!file.exists(base_dir)) {
  stop(add_ts("Specified base_dir does not exist: ", base_dir, 
              "\n\tPlease check that it is defined correctly"))
}

# Check existence of polygon file specified
if (!file.exists(poly_file)) {
  stop(add_ts("Cannot find a shapefile at the specified path: ", as.character(poly_file)))
}

# Create directory for this summary based on name of shapefile
sum_dir <- file.path(out_dir, extract_subelement(strsplit(poly_file, ".", fixed = TRUE), 1))
if (!file.exists(sum_dir)) {
  message_ts("Creating directory for this analysis at ", sum_dir)
  dir.create(sum_dir)
}

## ------------------------
# Load other functions
source(file.path(code_dir, c("02_preparatory_functions.R")))

# Load required packages
if (!require(terra)) stop(add_ts("Please install the required package 'terra'"))
if (!require(dplyr)) stop(add_ts("Please install the required package 'dplyr'"))
if (!require(ggplot2)) stop(add_ts("Please install the required package 'ggplot2'"))

## -----------------------
# Prepare shapefile
guide_file <- file.path(sim_suit_dir, "suitability_2013-2022_fall_AMAV_inside.tif")
prep_file <- prepare_shaefile(poly_file,
                              sum_dir,
                              guide_raster = guide_file,
                              overwrite = overwrite)

## ----------------------
# Extract data
stat_file <- extract_data(data_files,
                          prep_file,
                          output_dir = sum_dir,
                          overwrite = overwrite)

# Create summaries
sum_file <- summarize_data(stat_file,
                           output_dir = sum_dir,
                           overwrite = overwrite)

# Create plots
plot_files <- plot_data(sum_file,
                        output_dir = sum_dir,
                        overwrite = overwrite)
