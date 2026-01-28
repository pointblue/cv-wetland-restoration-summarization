# Functions for prepraring the shapefile for analysis

# Define function prepare shapefile for analysis
# Returns a vector of created files
prepare_shapefile <- function(in_shapefile, 
                              output_dir, 
                              guide_raster, 
                              overwrite = FALSE) {
  
  # Load required packages
  if (!require(terra)) stop(add_ts("Library terra is required"))
  
  # Check simple parameters
  if (!is.logical(overwrite)) stop(add_ts("Argument 'overwrite' must be TRUE or FALSE"))

  # Check output dir
  if (!(file.exists(output_dir))) stop(add_ts("output_dir does not exist"))
  
  # Check if file already exists
  if (file.exists(out_file) & overwrite != TRUE) {
    
    message_ts("Shapefile already prepared and overwrite != TRUE")
    return(out_file)
    
  } else {
    
    # Check and load shapefile
    if (!is.character(poly_shapefile)) {
      
      stop(add_ts("poly_shapefile must be the filename of an ESRI shapefile"))
      
    } else {
      
      if (length(poly_shapefile) != 1) {
        stop(add_ts("poly_shapefile must be a single shapefile or filename"))
      }
      if (!file.exists(poly_shapefile)) {
        stop(add_ts("poly_shapefile does not exist: ", poly_shapefile, " not found."))
      }
      
      # Load
      poly_shp <- vect(poly_shapefile)
      
    }
    
    # Check it is a valid shapefile; attemptto repair if not
    if (!is.valid(poly_shp)) {
      
      message_ts("Error detected in geometry of in_shapefile. Attempting to fix...")
      
      poly_shp <- makeValid(poly_shp)
      
      if (is.valid(poly_shp)) {
        message_ts("Geometry repaired.")
      } else {
        stop(add_ts("Unable to repair geometry. Try fixing in ArcGIS using the 'Repair Geometry' tool."))
      }
      
    } 
    
    # Check and load guide raster
    if (class(guide_raster) == "SpatRaster") {
      
      guide_rst <- guide_raster
      
    } else if (is.character(guide_raster)) {
      
      if (length(guide_raster) != 1) stop(add_ts("guide_raster must be a single SpatRaster or filename"))
      if (!file.exists(guide_raster)) stop(add_ts("guide_raster does not exist: ", guide_raster, " not found."))
      
      guide_rst <- rast(guide_raster)
      
    } else {
      
      stop(add_ts("guide_raster must be a SpatRaster or filename of a raster"))
      
    }
    
    # Reproject shapefile if needed
    if (!identical(crs(poly_shp, proj = TRUE), crs(guide_rst, proj = TRUE))) {
      
      if (verbose) message_ts("Reprojecting shapefile to match guide_rst...")
      poly_shp <- project(poly_shp, crs(guide_rst))
      
    }
    
    # Export
    writeVector(poly_shp, 
                out_file, 
                filetype = "ESRI Shapefile", 
                overwrite = TRUE)
    
  }
  
  return(out_file)
  
}
