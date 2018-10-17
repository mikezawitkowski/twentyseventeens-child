#!/bin/sh
# ------------------------------------------------------------------
# mikezawitkowski
#	   refresh_child_theme.sh.sh
#          Refreshes the child theme using directory 'source' for 
#          wordpress instance installed in directory 'destination'
#          Zips the specified directory of a wordpress child theme
#          and updates the production theme located in the directory
#
# Dependencies:
#     https://wp-cli.org/
# ------------------------------------------------------------------
VERSION=0.1.0
SUBJECT=refresh_child_theme.sh
USAGE="Usage: refresh_child_theme.sh -hv source destination args"


# --- Option processing --------------------------------------------
if [ "$#" -lt 2 ]; then
    echo "You did not pass enough parameters"
    echo $USAGE
    exit 1;
fi

while getopts ":vh" optname
  do
    case "$optname" in
      "v")
        echo "Version $VERSION"
        exit 0;
        ;;
      "h")
        echo $USAGE
        exit 0;
        ;;
      "?")
        echo "Unknown option $OPTARG"
        exit 0;
        ;;
      ":")
        echo "No argument value for option $OPTARG"
        exit 0;
        ;;
      *)
        echo "Unknown error while processing options"
        exit 0;
        ;;
    esac
  done

shift $(($OPTIND - 1))

param1=$1
param2=$2
# -----------------------------------------------------------------

#LOCK_FILE=/tmp/${SUBJECT}.lock

#if [ -f "$LOCK_FILE" ]; then
#echo "Script is already running"
#exit
#fi

# -----------------------------------------------------------------
#trap "rm -f $LOCK_FILE" EXIT
#touch $LOCK_FILE 


# --Body------------------------------------------------------------
# if HereIsAKey is unique in the file use it for getting the name of parent theme
# parenttheme=$(grep -Po "(?<=^HereIsAKey ).*" file) 
zip /tmp/$param1.zip $param1/*.*
wp theme activate twentyseventeen --path=$param2
sudo wp theme delete $param1 --allow-root --path=$param2 
sudo wp theme install /tmp/$param1.zip --allow-root --path=$param2
wp theme activate $param1 --path=$param2
echo "That's a wrap!"
