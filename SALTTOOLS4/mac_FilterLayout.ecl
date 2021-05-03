/*
	-- mac_LayoutSALTTOOLS4 macro
	Gives you the layout passed in with the fields from pFieldFilter removed
	
*/
export mac_FilterLayout(
	 pRecord														// input record layout
	,pOutputEcl								= 'false'	// Should output the ecl as a string(for testing) or actually run the ecl
	,pFieldFilter							= '\'\''	// Regex to filter for certain fields
	,pConvertAllFields2String	= false		// use this to get this to work when fields are different types
	
) :=
functionmacro
	
	LOADXML('<xml/>');
	#EXPORTXML(pRecord_MetaInfo, pRecord)
	#uniquename(name							)
	#uniquename(named_layout			)
	#uniquename(stringfiller			)
	#uniquename(lenName						)
	#uniquename(lenType						)
	#uniquename(fillername				)
	#uniquename(fillertype				)
	#uniquename(moutput						)
	#uniquename(layout_record						)
	#uniquename(lsize							)
	#uniquename(loutSetFields			)
	#uniquename(lnumFields				)
	#uniquename(lcomma						)
	#uniquename(lcomma2						)
	#uniquename(inchild						)
	#uniquename(lnumSubstringFields				)
	#uniquename(lsubstringfield				)
	#uniquename(lfGetField				)
	#uniquename(lfGetFieldName				)
	#uniquename(lType						)
	#SET(stringfiller, '                                                                           ')
  #SET(moutput				,							  'laymod := \nmodule\n')
	#SET(layout_record					,' {\t')
	#SET(loutSetFields					,'\texport setAllFields :=\n\t[\n')
	#SET(lfGetField							,'\texport fGetFieldValue(unsigned2 pfield,' + trim(#TEXT(pRecord),all) + ' pRow) :=\n\tmap(\n') 
	#SET(lfGetFieldName					,'\texport fGetFieldName(unsigned2 pfield) := setAllFields[pfield];\n') 
	#SET(named_layout	, '')
	#SET(name					, '')
	#SET(lnumFields		, 0)
	#SET(lnumSubstringFields		, 0)
	#SET(lcomma				, '')
	#SET(lcomma2				, '')
	#SET(inchild				, 0)
	
	#FOR (pRecord_MetaInfo)
		#FOR (Field)
		
			// Skip over compound fields
			#IF(%'@isDataset'%='1' OR %'@isRecord'%='1')
				#SET(inchild,%inchild%+1)
			#ELSIF(%'@isEnd'%='1')
				#SET(inchild,%inchild%-1)
			#ELSIF(%inchild%=0)
			
				#IF(%'@isRecord'% = '1')
					#SET(named_layout, %'@name'%)
				#ELSE
					#IF(%'named_layout'% = %'@name'% and %'@type'% = '')
						#SET(named_layout, '')
					#ELSE
						#IF(%'named_layout'% != '')
							#SET(name, %'named_layout'% + '.' + %'@name'%)
						#ELSE
							#SET(name			, %'@name'%)
						#END
						#IF(%'@type'% = 'qstring' and %@size% > 0)
							#SET(lsize	, (unsigned)(%@size% * 8 / 6))
						#ELSE
							#SET(lsize	,if(%@size% > 0 and %'@type'% != 'boolean', %'@size'%, ''))
						#END
						
						#SET(lenName				,length(trim(%'name'%							,left,right)))
						#SET(lenType				,length(trim(%'@type'% + %'lsize'%,left,right)))
						#SET(fillername			,%'stringfiller'%[1..(75 - (%lenName% - 1	))])
						#SET(fillertype			,%'stringfiller'%[1..(20 - (%lenType% - 1	))])
						#IF(pFieldFilter = '' or regexfind(pFieldFilter,%'name'%,nocase) = true)
							#SET(lType	,%'@type'%)
							#IF(%lnumFields% = 0)
								#APPEND(layout_record ,'\t ')
							#ELSE
								#APPEND(layout_record ,'\t,')
							#END
							#APPEND(layout_record	,%'@type'% + %'lsize'% + ' ' + %'name'% + ' ')
	//						#APPEND(layout_record	,'\t\t' + %'@type'% + %'lsize'% + %'fillertype'% + %'name'% + %'fillername'% + ';\n')
							#SET(lnumFields	,%lnumFields% + 1)
							#IF(%lnumFields% = 1) #SET(lcomma,'\t\t ') #ELSE #SET(lcomma,'\n\t\t,') #END
							#APPEND(loutSetFields						,%'lcomma'% + '\'' + %'name'% + '\'')
							#IF(pConvertAllFields2String = false)
								#APPEND(lfGetField	,%'lcomma'% + 'pfield = ' + %'lnumFields'% + ' => pRow.' + %'name'% )
							#ELSE
								#APPEND(lfGetField	,%'lcomma'% + 'pfield = ' + %'lnumFields'% + ' => (string)pRow.' + %'name'% )
							#END
						#END
					#END
				#END
			
			#END
		#END
	#END
	
	#APPEND(layout_record									, '}')
	#APPEND(loutSetFields						, '\n\t];\n')
	#IF((%'lType'% = 'unsigned' or %'lType'% = 'integer' or %'lType'% = 'real' or %'lType'% = 'decimal') and pConvertAllFields2String = false)
		#APPEND(lfGetField						, '\n\t\t,0\n\t);\n')
	#ELSE
		#APPEND(lfGetField						, '\n\t\t,\'\'\n\t);\n')
	#END
	
	#SET(moutput	,%'moutput'% + %'layout_record'% + %'loutSetFields'% + %'lfGetField'% + %'lfGetFieldName'% + '\nend;\n return laymod;\n')
	
	#if(pOutputEcl = true)
		return %'layout_record'%;
	#ELSE
		%layout_record%
	#END
  
endmacro;
