EXPORT MAC_CLEAR_FIELDS(infile,outfile,fieldList='') := MACRO  
		
		LOADXML('<xml/>');
  #DECLARE(deprecateList)   #SET(deprecateList, '')
		#DECLARE(fieldtype)   			 #SET(fieldtype, 'string')
		#DECLARE(fieldname) 						#SET(fieldname, '')
		
  #EXPORTXML(fields, RECORDOF(infile))
  #FOR(fields)
    #FOR(Field)
				#SET(fieldtype, %'{@type}'%)
							#IF(#TEXT(fieldList)!='' AND REGEXFIND('\\s*,\\s*'+%'{@label}'%+',',','+fieldList+',',NOCASE))
										#IF(regexfind('string', %'fieldtype'%, NOCASE))
												#APPEND(deprecateList, 'self.' + %'{@label}'%+':=\'\',')
										#ELSE
												#APPEND(deprecateList, 'self.' + %'{@label}'%+':=0,')
									 #END
							#END
    #END
  #END
	
		#APPEND(deprecateList, 'self := left;');
		// output(#TEXT(%'deprecateList'%), named('deprecateList'));
		
		outfile := project(infile, transform({infile}, #EXPAND(%'deprecateList'%)));
	
ENDMACRO;