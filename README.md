# Funerary perspectives of Iberian Neandertals. Temporal and paleoclimatic insights.
*Script for Mapping Neanderthal fossil Distribution in the Iberian Peninsula*

## Overview

This repository contains an **R script** and associated **datasets** developed as supplementary material for research publication "Funerary perspectives of Iberian Neanderthals. Temporal and paleoclimatic insights". The script plots Neanderthal fossil sites on an elevation model of the Iberian Peninsula. While originally designed to visualise the distribution of Neanderthal fossil remains, the script can be easily adapted to plot any dataset with spatial coordinates in the region.

<p align="center">
  <img src="https://github.com/AndionArteaga/Iberian-Neanderthal-fossils-map/blob/main/images/Neanderthals_Iberian_Peninsula_Map.png" alt="Neanderthals_Iberian_Peninsula_Map" width="450" height="350"/><br>
  <em>Figure. Map generated using the Rscript provided in this repository. Site names were added manually.</em>
</p>

#### 📁 Directory structure:

```markdown
├── Data/
│   ├── World_Countries/                          # Shapefiles for world political boundaries
│   │   ├── TM_WORLD_BORDERS-0.3.dbf
│   │   ├── TM_WORLD_BORDERS-0.3.prj
│   │   ├── TM_WORLD_BORDERS-0.3.shp
│   │   ├── TM_WORLD_BORDERS-0.3.shx
│   │   └── download_info.txt                     # Source and licensing info
│   └── IbP_Neanderthal_sites.csv                 # Database of Iberian Neanderthal fossil sites
├── Outputs/
│   └── Expected_outcome.pdf                      # Representation of the expected result (pdf)
├── images/
│   └── Neanderthals_Iberian_Peninsula_Map.png    # Figure (image)
├── Supplementary_Script_Map.R                    # R script for map generation
└── README.md
```


## 📊 Data Description

- **Neanderthal fossil sites**  
  The dataset `IbP_Neanderthal_sites.csv` includes all recognised Neanderthal fossil sites within the Iberian Peninsula as of January 2025.
  Coordinates are presented in the WGS 84 coordinate reference system.

- **Shapefiles**  
  The folder `Data/World_Countries/` contains vector data for modern country boundaries. The script uses these to define geopolitical context in the final map.

- **Automatically downloaded data**  
  Using the `geodata` package, the script downloads:
  - Level-1 administrative boundaries for Spain and Portugal  
  - Elevation data at 30 arc-seconds resolution for the Iberian Peninsula


## ⚙️ How to use it

Download ZIP or clone repository. 

Run the script `Supplementary_Script_Map` in Rstudio. 

The script will generate a **PDF map** file under the Outputs/ directory.

#### 📌 Note:
- This script uses **relative paths** and assumes **no modification** of the folder hierarchy.  
- Please ensure that the folders `Data/` and `Outputs/` remain in the **same directory** as the script.  
- Input data should be stored in the `Data/` folder.

### Requirements
- **Internet connection** is required to download elevation and administrative boundary data from `geodata`
```R
install.packages(c("terra", "car", "smoothr", "geodata"))
```

## Author
Andion Arteaga Brieba
