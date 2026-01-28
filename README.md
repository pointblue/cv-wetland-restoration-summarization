# Tools to Summarize the Value of Wetland Restorations
## Overview
This repository provides tools for analyzing the prioritization of wetland restorations in California's Central Valley.  The included scripts summarize species distribution models, wetland restoration simulations, and Zonation prioritizations developed by Point Blue Conservation Science for the Partners for Fish and Wildlife Program.  See final report (included in repository; PointBlue_USFWSPartners_2025_FinalReport_Final.pdf) for details.

The summarization tool is code written in the R programming environment (R Core Team, 2025).  This tool is best used by someone with a working familiarity with R because there is no standalone app or graphical interface.  The scripts must be run via an IDE such as RStudio (recommended), command line, or copy/pasted from a text editor.  Summarization parameters must be edited using RStudio, Notepad++, or similar.  Additionally, some basic troubleshooting issues may arise (e.g., the need to download any missing packages, occasional updates if the version of R is updated, etc.).  

Please contact Nathan Elliott or Matt Reiter at Point Blue Conservation Science with any questions.

### Data Citation
Reiter, M.E., N. Elliott, and E. Conlisk. 2025. Informing Strategic Wetland Restoration on Private Lands to Enhance Habitat Resilience in the Central Valley of California. Final Report to the Partners for Fish and Wildlife Program, United State Fish and Wildlife Service. Point Blue Conservation Science, Petaluma, California. 

## This Tool

### Software Requirements
R version 4 or later  
* Recommended: > 4.2 
* Download R for your operating system from https://cran.rstudio.com/ 

R packages
* terra 
* dplyr 
* ggplot2 

Program to read and edit .R code files
* Recommended: RStudio Desktop 
* Download from https://posit.co/download/rstudio-desktop/ 

### Downloading
The code is accessed via a public GitHub repository here: https://github.com/pointblue/cv-wetland-restoration-summarization. 

Data are in a Google drive folder here: https://drive.google.com/drive/folders/1D7Nt-MfsbY6vKwraz94I0gHp32F_-aqH?usp=drive_link 

### File Structure
The default name of the root folder is that of the GitHub repository: cv-wetland-restoration-summarization. You can rename this if desired. Within this folder are the following folders and files: 

#### Subfolders

##### Code
Folder containing the .R code files used to summarize the data 
* functions: folder containing the custom functions called by the R scripts. You shouldn’t need to modify these for most uses. 
* 00_definitions.R: script file containing the basic directory and data definitions.  You probably won’t need to open this unless you have a non-standard file path setup. 
* 01_download_data.R: script file that will download the required prioritization data. Only needs to be run once. 
* 02_summarize_by_polygons.R: script file that will summarize your polygon file. You will edit this file to specify the shapefile to summarize and change any of the default summary parameters.   

##### Data
* current_wetland_priority: layers of prioritization ranking using current landcover (Objectives 1 – 3). GeoTiffs, floating point, INT4S, range 0 – 1. 
* future_wetland_priority: layers of prioritization ranking using future flooding scenarios (Objectives 1 – 3). GeoTiffs, floating point, INT4S, range 0 – 1. 
* simulated_wetland_priority: layers of prioritization ranking using simulated wetland restorations. GeoTiffs, floating point, INT4S, range 0 – 1. 
* simulated_wetland_suitability: layers of bird suitability using simulated wetland restorations.  GeoTiffs, floating point, INT4S, range 0 – 9. 

##### Input
Folder in which you will place the shapefile(s) to summarize 
* clean: folder that contains the cleaned versions of the shapefiles being summarized (possible changes: fixing geometry, reprojecting, renaming columns) 

##### Output
Folder to which the summaries will be written. Each shapefile that is summarized will generate a sub-folder named after the shapefile.

#### Root Files
* .gitignore.txt: text file specifying files to exclude from the GitHub repository
* cv-wetland-restoration-summarization.Rproj: an R Project file for ease of editing and running the script files 
* LICENSE: file containing the code license (MIT)
* README.md: text file containing more detailed information about the project. It contains the information in this appendix and will be updated with any changes made after the publication of this report.
* PointBlue_USFWSPartners_2025_FinalReport_Final.pdf: Final report for USFWS.  Contains full methods, results, and references for the data layers summarized by this tool.
  
### How to Run
1. Ensure you have the required software installed (see software requirements above)
2. Download the code from https://github.com/pointblue/cv-wetland-restoration-summarization. 
   * Clone the repository using Git, GitHub Desktop, or another tool 
   * *OR* download the source code manually from the latest release. The zip file that is downloaded will have the code and Objective 4 spatial data. 
3. Download the data for Objectives 1 – 3. Layers from Objective 4 are included in the repository; layers from 1 – 3 are too large for GitHub and must be downloaded separately. 
   * Run the script 01_download_data.R (easiest) 
   * *OR* download manually from the Google drive link above 
     * Navigate to Recent Historic Landscape (Conlisk) / GeoTiff
     * Download the seven layers that begin with AllBirds to cv-wetland-restoration-summarization\data\current_wetland_priority
     * Download the two layers that begin with Future to cv-wetland-restoration-summarization\data\future_wetland_priority
     * Place the shapefile you want to generate summaries for in cv-wetland-restoration-summarization/inputs.
       * Shapefile should have a projection of UTM Zone 10N using the WGS 84 datum
       * Shapefile should have a unique ID column
       * These parameters will be checked during the summary, corrected automatically if possible, and notify you of an error if there’s a problem  
4. Prepare the summarization
   * Open the file 02_summarize_by_polygons.R
   * Change any of the parameters that control what data are summarized and how the output is presented.  The default is to generate everything.  These parameters include:
     * the name of the shapefile you are summarizing
     * name of the column that contains the name of the polygon unit
     * names of columns that you want in the final summary files
     * what scenarios and layers are summarized: prioritization using current landcover, prioritization using future flooding, suitability of restored wetlands , and prioritization using restored wetlands
     * what summary stats are generated (mean, standard deviation, median, minimum, maximum)
     * whether to produce graphs
     * whether to produce maps
     * the format of the output table (’wide’ or ‘long’)
     * whether to overwrite existing outputs 

5. Save the file after you’ve made the changes you want 

6. Run the summarization script 02_summarize_by_polygons.R 



