# Funerary perspectives of Iberian Neandertals. Temporal and paleoclimatic insights.
*Script for Mapping Neanderthal Fossil Distribution in the Iberian Peninsula*

---
## Overview

This repository contains the R script and associated data used to generate a distribution map of Neanderthal fossil sites across the Iberian Peninsula.


![Mapa Iberica](https://github.com/Andion.../Iber funer.../images/mapa.png)

Here's a markdown directory tree for your GitHub project "Data":

```markdown
├── Data/
│   ├── World_Countries/                      # Shapefiles for world political boundaries
│   │   ├── TM_WORLD_BORDERS-0.3.dbf
│   │   ├── TM_WORLD_BORDERS-0.3.prj
│   │   ├── TM_WORLD_BORDERS-0.3.shp
│   │   ├── TM_WORLD_BORDERS-0.3.shx
│   │   └── download_info.txt                 # Source and licensing info
│   └── IbP_Neanderthal_sites.csv             # Database of Iberian Neanderthal fossil sites
├── Outputs/
│   └── Neanderthal_sites_Map_resultAAB.pdf   # Final output map (PDF)
├── Supplementary_Script_Map.R                # R script for map generation
└── README.md
```

### How to use it
Download folder 
Run the script from Rstudio terminal or Systen cibsike
```R
Rscript Supplementary_Script_Map.R
```
The script will generate a PDF map file under the Outputs/ directory.

### Requirements
- **Internet connection** is required to download elevation and administrative boundary data from `geodata`
```R
install.packages(c("terra", "car", "smoothr", "geodata"))
```

## Data Description

- **Neanderthal fossil sites**  
  The dataset `IbP_Neanderthal_sites.csv` includes coordinates, chronological attributions, and unique identifiers for each site.

- **Shapefiles**  
  The folder `Data/World_Countries/` contains vector data for modern country boundaries. The script uses these to define geopolitical context in the final map.

- **Automatically downloaded data**  
  Using the `geodata` package, the script downloads:
  - Level-1 administrative boundaries for Spain and Portugal  
  - Elevation data at 30 arc-seconds resolution for the Iberian Peninsula

## Author
Andion Arteaga Brieba
