#!/bin/bash
# Kebo Gerang 25/07/2018
#
# Plot data DEMNAS dengan menggunakan GMT (Generic Mapping Tool)
#
# cek jumlah argumen
#
if [ "$#" -ne 3 ]; then
echo " penggunaan: bash plot_demnas.bash file_input.tif file_output.eps max_elev(meters)"
echo " contoh: bash plot_demnas.bash DEMNAS_0718-54_v1.0.tif DEMNAS_0718-54_v1.0.eps 200"
exit
fi
#
# Ekstrak batas data DEMNAS
#
lon0=`gdalinfo "$1" | grep "Upper Left" | awk -F"," '{print $1}' | sed -e 's/Upper Left ( //g' | sed -e 's/ //g'`
latf=`gdalinfo "$1" | grep "Upper Left" | awk -F"," '{print $2}' | sed -e 's/)//g' | sed -e 's/ //g'`
lonf=`gdalinfo "$1" | grep "Lower Right" | awk -F"," '{print $1}' | sed -e 's/Lower Right ( //g'| sed -e 's/ //g'`
lat0=`gdalinfo "$1" | grep "Lower Right" | awk -F"," '{print $2}' | sed -e 's/)//g'| sed -e 's/ //g'`
#
# convert dari .tif menjadi GMT-NetCDF
#
gdal_translate -of "NetCDF" $1 temp.grd
#
# membuat color palette
#
interval=`echo "$3/20" | bc`
gmt grd2cpt temp.grd -V > /dev/null
gmt grd2cpt temp.grd -Crainbow > mydata.cpt
#makecpt -T0/$3/$interval -Fr -Cearth > mydata.cpt
#
#
grdgradient temp.grd -Gtemp2.grd -A345 -Ne0.6 -V
grdhisteq temp2.grd -Gtemp3.grd -N -V
grdmath temp3.grd 5 DIV = temp4.grd
#
#
bound=`echo ${lon0}/${lonf}/${lat0}/${latf}`
interval=`echo "$3/4" | bc`
grdimage temp.grd -JM16 -B0.05WESN -R$bound -Cmydata.cpt -Xc -Yc -Itemp4.grd -K > $2
#psscale -D8.5/-1.0/10/0.25h -Ba${interval}:"Elevasi (meter)": -Cmydata.cpt -O >> $2
rm temp* mydata*
