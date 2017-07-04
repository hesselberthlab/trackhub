#! /usr/bin/env bash

# these are common among several tracks
poscolor="228,26,28" # red
negcolor="55,126,184" # blue

strains=(WT xrn1 trl1 tpt1 tpt1_ski2)
treatments=(NT TM)
strands=(pos neg)

mainstanza="
\ttrack RNA-repair\n
\tparent mRNA\n
\tcompositeTrack on\n
\tshortLabel RNArepair\n
\tlongLabel RNA-seq of RNA repair mutants Coverage tracks\n
\tsubGroup1 view Views COV=Repair-Coverage END=Repair-Ends\n
\tsubGroup2 strain Strain WT=wild-type xrn1=xrn1 trl1=trl1 tpt1=tpt1 tpt1_ski2=tpt1_ski2\n
\tsubGroup3 treatment Treatment NT=None TM=tunicamycin\n
\tsubGroup4 strand Strand pos=pos neg=neg\n
\tdimensions dimX=treatment dimY=strain dimA=strand\n
\tfilterComposite dimA\n
\tsortOrder view=- strand=+\n
\ttype bigwig\n"

echo -e $mainstanza

cov_stanza="
\t\ttrack Repair-Coverage\n
\t\tview COV\n
\t\tparent RNA-repair\n
\t\tshortLabel Coverage\n
\t\tvisibility full\n
\t\ttype bigWig\n
\t\tautoScale on\n"

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
                    \t\tparent Repair-Coverage\n
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
\t\ttrack Repair-Ends\n
\t\tview END\n
\t\tparent RNA-repair\n
\t\tshortLabel Ends\n
\t\tvisibility full\n
\t\ttype bigWig\n
\t\tautoScale on\n"

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
                    \t\tparent Repair-Ends\n
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
