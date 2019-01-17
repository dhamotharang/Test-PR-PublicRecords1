EXPORT FromFlat(d,l,m):=FUNCTIONMACRO
  LOADXML('<xml/>');
  #DECLARE(dest_field_list) #SET(dest_field_list,'')
  #EXPORTXML(dest_fields,l)
  #FOR(dest_fields)
		#DECLARE(thisChild) #SET(thisChild,'')
		#FOR(Field)
			#IF(%'@isDataset'%='1')
				#SET(thisChild,%'{@label}'%)
			#ELSEIF(%'@isEnd'%='1')
				#SET(thisChild,'')
			#ELSEIF(%'thisChild'%<>'' AND %'{@label}'%<>'weight' AND REGEXFIND('(^|,)'+%'thisChild'%+':',m,NOCASE))
				#APPEND(dest_field_list, ',' + REGEXFIND('(^|,)('+%'thisChild'%+':[^,]+)($|,)',m,2,NOCASE))
				#APPEND(dest_field_list, ';' + '+' + %'{@type}'% + ',')
			#ELSEIF(%'thisChild'%='')
				#IF(REGEXFIND('(^|,)'+%'{@label}'%+':',m,NOCASE))
					#APPEND(dest_field_list,','+REGEXFIND('(^|,)('+%'{@label}'%+':[^,]+)($|,)',m,2,NOCASE))
				#ELSE
					#APPEND(dest_field_list,','+%'{@label}'%+':'+%'{@label}'%)
				#END
				#APPEND(dest_field_list,';'+IF(%'{@type}'%[..3]='set','~'+%'{@type}'%[8..],%'{@type}'%)+',')
			
			#END
		#END
  #END
  
  #DECLARE(r) #SET(r,'')
  #DECLARE(transformation) #SET(transformation,'PROJECT('+#TEXT(d)+',TRANSFORM('+#TEXT(l)+',\n')
  #EXPORTXML(orig_fields,RECORDOF(d))
  #FOR(orig_fields)
    #FOR(Field)
      #IF(%'{@isRecord}'%='1')
        #SET(r,%'{@name}'%+'.')
      #ELSE
        #IF(%'{@isend}'%='1')
          #SET(r,'')
        #ELSE
          #IF(REGEXFIND(':'+%'r'%+%'{@label}'%+';',%'dest_field_list'%,NOCASE))
						#DECLARE(isSet)    #SET(isSet, REGEXFIND(%'r'%+%'{@label}'%+';~',%'dest_field_list'%,NOCASE))
						#DECLARE(isChild)  #SET(isChild, REGEXFIND(%'r'%+%'{@label}'%+';\\+',%'dest_field_list'%,NOCASE))
						#DECLARE(recChild) #SET(recChild, IF(%isChild%, REGEXREPLACE('\\.([^.]+)$', #TEXT(l), 'layout_'+%'{@label}'%+'_cases'), ''))
						#DECLARE(fldSelf)  #SET(fldSelf, REGEXFIND(',([^,:]+)(:'+%'r'%+%'{@label}'%+';)',%'dest_field_list'%,1,NOCASE))
						#DECLARE(fldType)  #SET(fldType, REGEXFIND(',([^,:]+)(:'+%'r'%+%'{@label}'%+';)([~+]*)([^,:]+)',%'dest_field_list'%,4,NOCASE))
						#DECLARE(fldPfx)   #SET(fldPfx, IF(%isSet%,'[',IF(%isChild%,'DATASET([{','')))
						#DECLARE(fldSfx)   #SET(fldSfx, IF(%isSet%,']',IF(%isChild%,',100}],'+'RECORDOF(SELF.'+%'fldSelf'%+'))','')))
						
            #APPEND(transformation, '  SELF.' + %'fldSelf'% + ':=' + %'fldPfx'% + '(' + %'fldType'% + ')LEFT.' + %'r'% + %'{@label}'% + %'fldSfx'% + ';\n')
          #END
        #END
      #END
    #END
  #END
  #APPEND(transformation,'  SELF:=[];\n))')
	
	// Debugging outputs
	// #DECLARE(out_dest_fields);
	// #EXPORT(out_dest_fields, l);
	// OUTPUT(%'out_dest_fields'%, NAMED('out_dest_fields'));
	// OUTPUT(%'dest_field_list'%, NAMED('dest_field_list'));
	// #DECLARE(out_orig_fields);
	// #EXPORT(out_orig_fields,RECORDOF(d));
	// OUTPUT(%'out_orig_fields'%, NAMED('out_orig_fields'));
	// OUTPUT(%'transformation'%, NAMED('transformation'));
	
  // RETURN %'transformation'%; // Display generated ECL (debugging)
  RETURN #EXPAND(%'transformation'%); // Run generated ECL
ENDMACRO;
