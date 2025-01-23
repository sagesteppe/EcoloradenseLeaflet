setwd('/home/sagesteppe/Documents/assoRted/EcoloradenseLeaflet/scripts')

library(terra)
r <- rast('../../../Ecoloradense/results/suitability_maps/1arc-Iteration1-PA1_2.7DO_2-Pr.tif')
v <- vect('../data/vector/FocalArea.gpkg') |>
  project(crs(r))

msk <- ifel(r < 0.45, NA, r)
r <- mask(r, msk)

r_cb <- crop(r, v[1])
r_cd <- crop(r, v[2])
plot(r_cd)

r_cb <- project(r_cb, "epsg:4326")
r_cd <- project(r_cd, "epsg:4326")

writeRaster(r_cb, '../data/raster/cb.tif', overwrite = TRUE)
writeRaster(r_cd, '../data/raster/cd.tif', overwrite = TRUE)

rm(msk, r, v)
