#!/bin/bash


for file in *.md;
do 
  if [[ "$file" =~ ^([0-9]{1}-[0-9]{1,2}) ]]; then
      chapter=${BASH_REMATCH[1]}
      chapterEsc=`echo $chapter | sed "s/\-/\\\-/g"`
      numFig=`grep -Eo "\!\[\]\(RackMultipart[0-9]{8}-[0-9]{1}-.{6,7}_html_.{16}\.(jpeg|gif|jpg|png|bmp){1}\)" "${file}" | wc -l | xargs`
      suffixes=`grep -Eo "\!\[\]\(RackMultipart[0-9]{8}-[0-9]{1}-.{6,7}_html_.{16}\.(jpeg|gif|jpg|png|bmp){1}\)" "${file}" | sed -nr 's/.*\.(jpeg|gif|jpg|png|bmp){1}\)/\1/p'`
      #suffixes=`sed -nr 's/\!\[\]\(RackMultipart[0-9]{8}-[0-9]{1}-.{7}_html_.{16}\.(jpeg|gif|jpg|png|bmp){1}\)/\1/p' "${file}" | sed $'s/[^[:print:]\t]//g' | sed -e 's/^[ \t]*//'`
      suffixArr=($suffixes)
      echo "Processing $file"
      echo "  Matched:  $chapter"
      echo "  Figures:  $numFig"
      for ((i = 1 ; i <= $numFig ; i++));
      do
          figNum=($i-1)
          fig="\!\[\]\(figure-$chapter-$i.${suffixArr[$figNum]}\)"
          echo "    $fig"
          sed -r -i.bak -e "1 s/\!\[\]\(RackMultipart[0-9]{8}-[0-9]{1}-.{6,7}_html_.{16}\.(jpeg|gif|jpg|png|bmp){1}\)/${fig}/; t" -e "1,// s//${fig}/" "${file}"
          sed -r -i.bak "s/\!\[\]\(figure/\!\[Figura ${i}\]\(\/assets\/figures\/figure/g" "${file}"
          rm "${file}.bak"
          #sed -i.bak -r -e '1s/\!\[\]\(RackMultipart[0-9]{8}-[0-9]{1}-.{6,7}_html_.{16}\.(jpeg|gif|jpg|png|bmp){1}\)/${fig//\//\\/}/;t' -e '1,/\!\[\]\(RackMultipart[0-9]{8}-[0-9]{1}-.{6,7}_html_.{16}\.(jpeg|gif|jpg|png|bmp){1}\)/s//${fig//\//\\/}/'
          #sed -i.bak -r -e ':a' -e '$!{N;ba' -e '}; s/\!\[\]\(RackMultipart[0-9]{8}-[0-9]{1}-.{6,7}_html_.{16}\.(jpeg|gif|jpg|png|bmp){1}\)/${fig//\//\\/}/'
          #sed -r -i.bak "/\!\[\]\(RackMultipart[0-9]{8}-[0-9]{1}-.{6,7}_html_.{16}\.(jpeg|gif|jpg|png|bmp){1}\)/s/\!\[\]\(RackMultipart[0-9]{8}-[0-9]{1}-.{6,7}_html_.{16}\.(jpeg|gif|jpg|png|bmp){1}\)/${fig//\//\\/}/;q" "${file}"
      done
      
  fi
done;

exit 0