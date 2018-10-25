EXPORT MAC_Pivot(d,l):=FUNCTIONMACRO
//---------------------------------------------------------------------------
// Macro pivots the first row of a dataset into labels and values
// takes two parameters:
// 1. The input dataset (if more than one row, the rest are disregarded)
// 2. The output layout
// The output layout should have the first field be "STRING label"
// Subsequent fields in the output layout are assumed to be suffixes of
// field names in the input dataset (with an additional underscore).
// e.g.  Input dataset might have a field "fname_cnt", and the output
//       layout would have an unsigned field "cnt"
// Fields in the input dataset without a suffix in the output layout
// are disregarded.
//---------------------------------------------------------------------------
  // Get the list of fields in the input dataset
  LOADXML('<sml/>');
  #DECLARE(f) #SET(f,'')
  #EXPORTXML(fields,RECORDOF(d))
  #FOR(fields)
    #FOR(Field)
      #APPEND(f,':'+%'{@label}'%+':')
    #END
  #END
  
  // Determine the number of fields in the output layout and tag each input
  // field with the intended output field
  #DECLARE(b) #SET(b,'')
  #EXPORTXML(fields,l)
  #FOR(fields)
    #FOR(Field)
      #APPEND(b,',0')
      #IF(%'{@label}'%<>'label')
        #SET(f,REGEXREPLACE(':([^:-]+_'+%'{@label}'%+'):',%'f'%,':$1-'+%'{@label}'%+':'))
        #SET(f,REGEXREPLACE(':([^:]+_'+%'{@label}'%+')-[^:]{0,'+(LENGTH(%'{@label}'%)-1)+'}:',%'f'%,':$1-'+%'{@label}'%+':'))
      #END
    #END
  #END
  #SET(b,%'b'%[3..])
  
  // Build a dataset where each field in the input dataset is a row
  #DECLARE(n) #SET(n,0)
  #DECLARE(r) #SET(r,'')
  #FOR(fields)
    #FOR(Field)
      #IF(%'{@label}'%<>'label')
        #SET(f,REGEXREPLACE(':([^:]+)_'+%'{@label}'%+'-('+%'{@label}'%+'):',%'f'%,':DATASET([{\'$1\''+%'b'%[..(%n%*2)+1]+#TEXT(d)+'[1].$1_$2'+%'b'%[(%n%*2)+3..]+'}],'+#TEXT(l)+'):'))
        #APPEND(r,',SELF.'+%'{@label}'%+':=LEFT.'+%'{@label}'%+'+RIGHT.'+%'{@label}'%)
        #SET(n,%n%+1)
      #END
    #END
  #END
  // Rollup the resulting dataset to have one row per label.
  #SET(f,'ROLLUP(SORT(\n  '+REGEXREPLACE('[+]$',REGEXREPLACE(':',REGEXREPLACE('[+]+',REGEXREPLACE('::',REGEXREPLACE(':[^:{]+:',%'f'%,''),'+'),'+'),''),'')+'\n,label),TRANSFORM(RECORDOF(LEFT)'+%'r'%+',SELF:=LEFT),label)')
  
  RETURN %f%;
ENDMACRO;
