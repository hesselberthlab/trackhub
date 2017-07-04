#! /usr/bin/env bash

# these are common among several tracks
poscolor="228,26,28" # red
negcolor="55,126,184" # blue

strains=(WT trl1 tpt1 tpt1_ski2)
treatments=(NT TM)
strands=(pos neg)

mainstanza="track RNA-repair\n
compositeTrack on\n
shortLabel RNArepair\n
longLabel RNA-seq of RNA repair mutants Coverage tracks\n
subGroup1 view Views COV=Coverage END=Ends\n
subGroup2 strain Strain WT=wild-type trl1=trl1 tpt1=tpt1 tpt1_ski2=tpt1_ski2\n
subGroup3 treatment Treatment NT=None TM=tunicamycin\n
subGroup4 strand Strand pos=pos neg=neg\n
dimensions dimX=treatment dimY=strain dimA=strand\n
filterComposite dimA\n
sortOrder view=- strand=+\n
type bigwig\n"

echo -e $mainstanza

cov_stanza="
\ttrack Coverage\n
\tview COV\n
\tparent RNA-repair\n
\tshortLabel Coverage\n
\tvisibility full\n
\ttype bigWig\n
\tautoScale on\n"

echo -e $cov_stanza

for strain in ${strains[@]}; do
    for treatment in ${treatments[@]}; do
        for strand in ${strands[@]}; do

            if [[ $strand == "pos" ]]; then
                color=$poscolor
            else
                color=$negcolor
            fi

            stanza="
                    \t\ttrack $strain.$treatment.$strand.coverage\n
                    \t\tparent Coverage\n
                    \t\tsubGroups view=COV strain=$strain strand=$strand treatment=$treatment\n
                    \t\tbigDataUrl rna/rna-repair/$strain""_$treatment.$strand.bw\n
                    \t\tshortLabel $strain.$treatment\n
                    \t\tlongLabel $strain $treatment $strand\n
                    \t\tmaxHeightPixels 30:30:10\n
                    \t\tcolor $color\n
                    \t\ttype bigWig\n
            "
            echo -e $stanza
        done
    done
done

end_stanza="
\ttrack Ends\n
\tview END\n
\tparent RNA-repair\n
\tshortLabel Ends\n
\tvisibility full\n
\ttype bigWig\n
\tautoScale on\n"

echo -e $end_stanza

for strain in ${strains[@]}; do
    for treatment in ${treatments[@]}; do
        for strand in ${strands[@]}; do

            if [[ $strand == "pos" ]]; then
                color=$poscolor
            else
                color=$negcolor
            fi

            stanza="
                    \t\ttrack $strain.$treatment.$strand.ends\n
                    \t\tparent Ends\n
                    \t\tsubGroups view=END strain=$strain strand=$strand treatment=$treatment\n
                    \t\tbigDataUrl rna/rna-repair/$strain""_$treatment.ends.$strand.bw\n
                    \t\tshortLabel $strain.$treatment.ends\n
                    \t\tlongLabel $strain $treatment $strand\n
                    \t\tmaxHeightPixels 30:30:10\n
                    \t\tcolor $color\n
                    \t\ttype bigWig\n
            "
            echo -e $stanza
        done
    done
done
