SWISS GLACIER INVENTORY 2016
----------------------------
The Swiss Glacier Inventory 2016 provides glacier outlines (areas), debris cover, ice divides and location points of all glaciers in Switzerland 
referring to the years 2013-2018. The data is based on aerial imagery and stereophotogramatic analysis of the Federal 
office of Topography, Switzerland (swisstopo) within the framework of the Topographic landscape Model of Switzerland (swissTLM3D).
Furthermore the dataset has been revised by Glaciologists of VAW-ETH Zurich, University of Zurich and University of Fribourg (Switzerland). 
Please find more details about this dataset in the publications listet below.

Publication:
------------
  - Linsbauer, A., Bauder, A., Fischer, M., Hodel, E., Huss, M.(2020) in prep.
  - Weidmann, Y., Bärtschi, H., Zingg, Stefan., Schmassmann, E. (2019) Das Schweizerische Gletscherinventar als Produkt des 
    swissTLM3D. Geomatik Schweiz 5/2019, 114–119 (german only)
	
Content: Swiss Glacier Inventory 2016: 
--------------------------------------
  --------------------------------------------------
  - Outlines: SGI_2016_glaciers.shp -
  --------------------------------------------------
    ATTRIBUTES:
	-----------
	 - [gid]: geometry-ID
	 - [pk_glacier]: uuid for internal use
	 - [sgi-id]: Swiss Glacier Inventory ID: [rl_0,rl_1,rl_2,rl_3]-[i_code] (f.e. A54e-24) 
	 - [name]: name of glacier (if available, f.e. 'Triftgletscher')
	 - [rl_0]: Riverlevel_0: Subdivision of the inventory area on the basis of catchment areas of major rivers (f.e. A)
	 - [rl_1]: Riverlevel_1: Subdivision of the inventory area on the basis of catchment areas of major tributaries (f.e. 5)
	 - [rl_2]: Riverlevel_2: Subdivision of the inventory area on the basis of catchment areas of medium-sized tributaries (f.e. 4)
	 - [rl_3]: Riverlevel_3: Subdivision of the inventory area on the basis of catchment areas of small tributaries (f.e. e)
	 - [i_code]: Inventory Code: Sequential number for glacier within a specific inventory region (f.e. 24)
	 - [year_acq]: Year of acquisition of the aerial image
	 - [year_rel]: Year of release of Swiss Glacier Inventory
	 - [area_km2]: Area in square kilometers
	 - [length_km]: Length of glacier according to ...
	 - [masl_min]: Minimum of meter above sea level based on swissALTI3D release 2019
	 - [masl_mean]: Mean of meter above sea level based on swissALTI3D release 2019
	 - [masl_med]: Median of meter above sea level based on swissALTI3D release 2019
	 - [masl_max]: Mximum of meter above sea level based on swissALTI3D release 2019
	 - [slope_deg]: Average of slope in degree based on swissALTI3D release 2019
	 - [aspect_deg]: Average of aspect in degree based on swissALTI3D release 2019
	 
  --------------------------------------------------
  - Locations: SGI_2016_glaciers_locations.shp -
  --------------------------------------------------
    ATTRIBUTES:
	-----------
	 - [gid]: geometry-ID
	 - [pk_glacier]: uuid for internal use
	 - [sgi-id]: Swiss Glacier Inventory ID: [rl_0,rl_1,rl_2,rl_3]-[i_code] (f.e. A54e-24)
	 - [name]: name of glacier (if available, f.e. 'Triftgletscher')
	 - [xcoor]: x coordinate of location point
	 - [ycoor]: y coordinate of location point
	 
	(Please note, that this points have been choosen manually, mainly for labeling purposes.)
	 
  ------------------------------------------
  - Debris cover: SGI_2016_debriscover.shp -
  ------------------------------------------
    ATTRIBUTES:
	-----------
     - [gid]: geometry-ID
	 - [name]: name of glacier (if available)
	 - [sgi-id]: Swiss Glacier Inventory ID of underlying glacier
	 - [year_acq]: Year of acquisition of the aerial image
	 - [year_rel]: Year of release of Swiss Glacier Inventory
	 - [area_km2]: Area in square kilometers
	 
  ----------------------------------------
  - Ice divides: SGI_2016_icedivides.shp -
  ----------------------------------------
    ATTRIBUTES:
	-----------
     - [gid]: geometry-ID
	 - [sgi-id_a]: Swiss Glacier Inventory ID of glacier a
	 - [name_a]: Name of glacier a
	 - [sgi-id_b]: Swiss Glacier Inventory ID of glacier b
	 - [name_b]: Name of glacier b
	 - [year_acq]: Year of acquisition of the aerial image
	 - [year_rel]: Year of release of Swiss Glacier Inventory
	 - [length_km]: lenght of ice divides im kilometers
	 
  ------------------------------------------
  - Center lines: SGI_2016_centerlines.shp -
  ------------------------------------------
    ATTRIBUTES:
	-----------
     - [gid]: geometry-ID
	 - [sgi-id]: Swiss Glacier Inventory ID of glacier
	 - [name]: Name of glacier
	 - [year_acq]: Year of acquisition of the aerial image
	 - [year_rel]: Year of release of Swiss Glacier Inventory
	 - [length_km]: lenght of flow divides im kilometers
	 
	 according to Machguth, H. and Huss, M. (2014). The length of the world's glaciers - a new approach for the global calculation of center lines. The Cryosphere, 8, 1741-1755. doi:10.5194/tc-8-1741-2014
	 
  ------------------------------------------------
  - Surfacetype Raster: SGI_2016_surfacetype.tif -
  ------------------------------------------------
	 10m Raster aligned with swissALTI3D raster cells (2m)
	 0: no ice
	 1: ice/glacier
	 2: debris-covered ice/glacier

Additional Information:
-----------------------
CRS: CH1903+ / LV95 (EPSG 2056)
Encoding: UTF-8

When using these data, please cite as:
--------------------------------------
GLAMOS (2020). Swiss Glacier Inventory 2016, release 2020, Glacier Monitoring Switzerland, doi:10.18750/inventory.2016.r2020

-------------------------------------
DOI: 10.18750/inventory.sgi2016.r2020
-------------------------------------