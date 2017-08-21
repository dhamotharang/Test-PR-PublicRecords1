EXPORT ToField(dIn,dOut,idfield='',datafields=''):=MACRO
  LOADXML('<xml/>');
  #DECLARE(foundidfield)    #SET(foundidfield   ,#TEXT(idfield))
  #DECLARE(normlist)        #SET(normlist       ,'COUNTER')
  #DECLARE(iNumberOfFields) #SET(iNumberOfFields,0)
  #DECLARE(iPivotLoop)      #SET(iPivotLoop     ,0)
  #EXPORTXML(fields,RECORDOF(dIn))
  #FOR(fields)
    #FOR(Field)
      #IF(%'foundidfield'%='' AND %iPivotLoop%=0)
        #SET(foundidfield,%'{@label}'%);
      #ELSE
        #IF(%'{@label}'%!=#TEXT(idfield) #IF(#TEXT(datafields)!='') AND REGEXFIND('\\s*,\\s*'+%'{@label}'%+',',','+datafields+',',NOCASE) #END)
					#APPEND(normlist,',(BAIR.Types.t_FieldStr)LEFT.'+%'{@label}'%)
					#SET(iNumberOfFields,%iNumberOfFields%+1)
        #END
      #END
      #SET(iPivotLoop,%iPivotLoop%+1)
    #END
  #END
	// output(#text(%'normlist'%));
  dOut:=NORMALIZE(dIn,%iNumberOfFields%,
									TRANSFORM(BAIR.Types.NumericField
										,SELF.id:=LEFT.#EXPAND(%'foundidfield'%)
										,SELF.number:=COUNTER
										,SELF.value:=CHOOSE(#EXPAND(%'normlist'%))
										));
ENDMACRO;