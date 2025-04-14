# ------------------------------------------------------------------------------
# Script for Mapping Neanderthal fossils distribution in the Iberian Peninsula
# Author: Andion Arteaga Brieba
# Data: 20/12/2024
#
# Instructions: 
# - This scripts uses relative paths and assumes no modification of the folder hierarchy
# - Ensure that the folders Data and Outputs remain in the same directory as the script
# ------------------------------------------------------------------------------



# 1. Load required packages 
# -------------------------
library(terra) # For raster and vector handling
library(car) # For pointlabel function
library(smoothr) # For smoothing polygons

# 2. Set the  WORKING DIRECTORY to the folder containing this script
# ------------------------------------------------------------------
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

# 3. IMPORT MAPS AND DATASETS 
# ---------------------------
# 3.1. Administrative boundaries 
Spain_pol <-geodata::gadm(country="ESP", level=1, path="../outputs")
Portugal_pol <-geodata::gadm(country="PRT", level=1, path="../outputs")

# 3.2. Elevation data 
Spain_elev <-geodata::elevation_30s(country="ESP", path="../outputs")
Port_elev <-geodata::elevation_30s(country="PRT", path="../outputs")

# 3.3. World country boundaries (Source: https://larmarange.github.io/prevR/reference/TMWorldBorders.html)
countries <- terra::vect("Data/World_Countries/TM_WORLD_BORDERS-0.3.shp") 

# 3.4. Neandertal sites database 
Neand_db <- read.csv("Data/IbP_Neanderthal_sites.csv", sep=";", header=TRUE, encoding="UTF-8") #Upload csv file. Note: If an error occurs, try using ',' as the separator instead of ';'.

# 4. Create a SPATIAL VECTOR OBJECT 
# ---------------------------------
Neand_sites <- terra::vect(Neand_db, geom = c("Long", "Lat"), crs = "EPSG:4326") #Create a SpatVector from Longitude and Latitude columns, specifying EPSG:4326 as the coordinate reference system

# 5. BASE MAP PREPARATION
# -----------------------
# 5.1. Merge Spain and Portugal elevation data to create the Iberian Peninsula elevation
IbP_elevation <- terra::merge(Spain_elev, Port_elev)

# 5.2. Create a hillshade for enhanced visualisation of terrain
slope_IbP <- terra::terrain(IbP_elevation, v = "slope", unit = "radians")
aspect_IbP <- terra::terrain(IbP_elevation, v = "slope", unit = "radians")
Hill_IbP <- terra::shade(slope_IbP, aspect_IbP, angle=20, direction=0)

# 5.2. Define Iberian Peninsula perimeter
IbP_per <- as.polygons (IbP_elevation*0)
IbP_per_smooth <-smooth(IbP_per, method="chaikin")

# 5.3. Crop countries around Iberian Peninsula
sort(unique(countries$name)) # Check list of country names
Selected_countries <-subset(countries, countries$name %in% c("Morocco", "France", "Andorra"))
Countries_sel_dissolve <-terra::aggregate(Selected_countries) # Merge selected countries into one feature
Countries_sel_dissolve <- fillHoles(Countries_sel_dissolve) # Fill any holes in the polygons

# 6. CREATE MAP
# -------------
# The resulted map is saved as a PDF file in the Outputs Folder.

pdf("Outputs/Neanderthal_sites_Map.pdf", width = 13, height = 10)

plot(Countries_sel_dissolve, border="darkgrey", lwd=0.5, col = "white", background= "ghostwhite", alpha=0.5, ext = terra::ext(IbP_elevation)) #http://127.0.0.1:11083/graphics/plot_zoom_png?width=1708&height=844evation)) 
plot(IbP_per_smooth, border="black", lwd=1, add=TRUE)
plot(IbP_elevation, alpha=0.9, col=hcl.colors(100, palette="Terrain2"), legend= TRUE, add=TRUE); plot(Hill_IbP, col=grey(0:100/100), alpha=0.30, legend = FALSE, add=TRUE)
plot(Neand_sites, y= "Chronology", col= c("midnightblue","darkred","darkorange","gainsboro" ), pch=18, cex=2.2,  add=TRUE, plg = list(x=1.2, y=36.7, bty = "o",y.intersp=1.2,  cex= 1.2, title="Chronology",title.cex=1.3, lwd=0.1, bg="white"))

# Add title and labels
par(cex.main = 1.7, family="sans", lwd=0.4) 
title(main="Neanderthal fossil remains in the Iberian Peninsula", line=2.4, col.main="black") 
coords <- as.matrix(Neand_db[, c("Long", "Lat")])
pointLabel(x = coords[, 1], y = coords[, 2], labels = as.character(Neand_db$Id), col="black", cex = 1, allowSmallOverlap = FALSE)

dev.off()
