#!/usr/bin/env bash



# just check
refCSS=css/creative.css



function skipSharp() {
    if [[ ${1:0:1} == "#" ]]; then
        color=${1:1}
    else
        color=$1
    fi
    echo $color
}

function hexToRgb() {
    color=$(skipSharp $1)
    if ! [[ $color =~ ^[0-9A-Fa-f]{6}$ ]]; then
        echo "Error: bad input"
        exit 1
    else
        a=${color:0:2}
        b=${color:2:2}
        c=${color:4:2}
        rgb=$(printf "rgb(%d, %d, %d, 0.9)" 0x${a} 0x${b} 0x${c})
        echo $rgb
    fi
}



#
# MAIN
#

# Dummy parse without any check !
new=$(skipSharp $1)



old=$(skipSharp $(grep CHARTE_GRAPH $refCSS | cut -d':' -f2))
oldrgb=$(hexToRgb $old)
echo "old: $old := $oldrgb"


newrgb=$(hexToRgb $new)
echo "new: $new := $newrgb"

find . -name "*.css" -print \
     -exec \
     sed -i s/$old/$new/g {} \;


echo ""
echo "old: $old := $oldrgb"
echo "new: $new := $newrgb"
