#!/bin/bash
#Ira Anjasmara 07/12/18
#Script untuk menggabungkan data DEMNAS
filegabung=Surabaya_demnas
echo "gdal_merge.py -o $filegabung.tif" > list1
ls DEMNAS_*.tif | tr -d ' \n ' | sed -e 's/.tif/.tif /g' > list2
paste list1 list2 > gabung.sh
chmod +x gabung.sh
./gabung.sh
rm list1 list2 gabung.sh
