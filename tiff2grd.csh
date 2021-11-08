#!/bin/bash
#Raudlah 2018
#script convert from tiff to grd
gdal_translate -of "NetCDF" Surabaya_demnas.tif dem.grd
