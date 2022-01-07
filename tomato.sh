#!/bin/sh

##################################################
#                                                #
#  auTOMATic alignment of cOntents (TOMATO)      #
#                                                #
#     written by Seongin Na (Jan 07 2022)        #
#                                                #
##################################################

##################################################
#                                                #
#  Description:                                  #
#    This bash script automatically organises    #
#    description file in every subdirectories    #
#    and make a list of contents of the project. #
#                                                #
##################################################

##################################################
#                                                #
#  Usage:                                        #
#   (1) locate this file in the root directory.  #
#   (2) make tomato.txt file in subdirectories.  #
#   (3) write any description of it.             #
#   (4) once tomato.txt files are ready,         #
#       run command "bash tomato.sh"             #
#   (5) everything will be ready for you in      #
#       "contents.txt" in the root dir           #
#                                                #
##################################################

> contents.txt
touch contents.txt
touch tomatos.txt
find . | grep "tomato.txt" >> tomatos.txt
nofile=$(find . | grep "tomato.txt" | wc -l)

echo "Finding all the ripen tomatoes..."
echo "# # # # # # # # # # # # # # # # #"
echo " o o o o o o o o o o o o o o o o "
for i in $(seq 1 1 $nofile)
do
    touch tmp.txt
    linestring=$(sed -n $i'p' tomatos.txt)
    echo $linestring >> tmp.txt
    cat tmp.txt
    if [ $i -eq 1 ]
    then
        pwd  >> contents.txt
    else
        echo $linestring| sed -e 's/\/tomato.txt//' -e 's/[^-][^\/]*\//--/g' \
        -e 's/-/|/' >> contents.txt
    fi
    nostage=$(tr -d -c '/' < tmp.txt | awk '{ print length; }')
    prefix=$(seq -f "--" -s '' $(( $nostage - 1 )))
    cat $(sed -n $i'p' tomatos.txt) | sed -e "s/^/$prefix *  /" >> contents.txt -e 's/-/|/'
    rm tmp.txt
done
rm tomatos.txt
echo " o o o o o o o o o o o o o o o o o "
echo "# # # # # # # # # # # # # # # # # #"
echo "Found all the tomatoes and arranged in contents.txt..."
exit
