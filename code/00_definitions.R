# Defines folder structure and shared data definitions

#################
## Directories ##
base_dir <- getwd()

code_dir <- file.path(base_dir, "code")
fxn_dir <- file.path(code_dir, "functions")

data_dir <- file.path(base_dir, "data")
cur_dir <- file.path(data_dir, "current_wetland_priority")
fut_dir <- file.path(data_dir, "future_wetland_priority")
sim_suit_dir <- file.path(data_dir, "simulated_wetland_suitability")
sim_pri_dir <- file.path(data_dir, "simulated_wetland_suitability")


in_dir <- file.path(base_dir, "inputs")

out_dir <- file.path(base_dir, "outputs")

######################
## Data Definitions ##

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

# Bird names
bird_df <- data.frame(CommonName = c("American Avocet", "Black-necked Stilt", "Dowitcher", "Dunlin", 
                                     "Northern Pintail", "Northern Shoveler", "Green-winged Teal"),
                      SpeciesGroup = c(rep("shorebirds", 4),
                                       rep("ducks", 3)),
                      CommonCode = c("AMAV", "BNST", "DOWI", "DUNL", "NOPI", "NSHO", "GWTE"),
                      ScientificCode =c("REAM", "HIME", "LISPP", "CALA", "ANAC", "ANCL", "ANCR"),
                      FilenameCode = c("AMAV", "BNST", "DOWI", "DUNL", 
                                       "ANAC", "ANCL", "ANCR"))
