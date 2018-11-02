/*
	-- macf_LayoutTools macro
	Gives you the following in a module in the pOutput parameter
	pOutput.layout_record		-- the layout of the passed record.  Useful if record is spread out over multiple attributes, this puts it in one.  
	pOutput.setAllFields		-- A set of all of the fieldnames in the record.	
	pOutput.fGetFieldName		-- function.  pass the field # and it gives you the fieldname.
	pOutput.fGetFieldValue	-- function.  pass it the field # and the row(i.e. left in a transform) and it will give you the value for that field.

	The last three allow you to normalize a dataset into one record per field.
	This doesn't handle child datasets well yet(but you can filter those fields out using the pFieldFilter parameter.
	the functions depend on the fact that all of the fields are the same type.  Use the pFieldFilter parameter to achieve this if necessary.

	Future additions:
	could group fields by type, i.e. setboolean, setunsigned2, setqstring, etc
	
*/
export macf_LayoutTools(

	 pRecord														// input record layout
	,pOutputEcl								= 'false'	// Should output the ecl as a string(for testing) or actually run the ecl
	,pFieldFilter							= '\'\''	// Regex to filter for certain fields
	,pConvertAllFields2String	= false		// use this to get this to work when fields are different types
	// ,pForUseInMacro						= 'false'	// is output going to be used in a macro(then use set command), otherwise, just :=
	
) :=
functionmacro
	
	// #IF(pForUseInMacro	= false)
		LOADXML('<xml/>');
  // #END
  import std;
	#EXPORTXML(pRecord_MetaInfo, pRecord)
	#uniquename(name							)
	#uniquename(name_lowercase							)
	#uniquename(named_layout			)
	#uniquename(stringfiller			)
	#uniquename(lenName						)
	#uniquename(lenType						)
	#uniquename(fillername				)
	#uniquename(fillertype				)
	#uniquename(moutput						)
	#uniquename(loutput						)
	#uniquename(layout_record						)
	#uniquename(string_layout_record						)
	#uniquename(layout_record_xpath						)
	#uniquename(lsize							)
	#uniquename(loutSetFields			)
	#uniquename(lnumFields				)
	#uniquename(lcomma						)
	#uniquename(lcomma2						)
	#uniquename(lnumSubstringFields				)
	#uniquename(lsubstringfield				)
	#uniquename(lfGetField				)
	#uniquename(lfGetFieldName				)
	#uniquename(lType						)
	#uniquename(mymodule						)

	#SET(stringfiller, '                                                                           ')
	#SET(moutput				,							'return\nmodule\n')
//	#SET(moutput				,							%'mymodule'% +  ' :=\nmodule\n')

	#SET(layout_record					,'\texport layout_record :=\n\trecord\n')
	#SET(string_layout_record   ,'\texport string_layout_record := \'{\\n\'\n')
	#SET(layout_record_xpath	  ,'\texport layout_record_xpath :=\n\trecord\n')
	#SET(loutSetFields					,'\texport setAllFields :=\n\t[\n')
	#SET(lfGetField							,'\texport fGetFieldValue(unsigned2 pfield,' + trim(#TEXT(pRecord),all) + ' pRow) :=\n\tmap(\n') 
	#SET(lfGetFieldName					,'\texport fGetFieldName(unsigned2 pfield) := setAllFields[pfield];\n') 

	#SET(named_layout	, '')
	#SET(name					, '')
	#SET(lnumFields		, 0)
	#SET(lnumSubstringFields		, 0)
	#SET(lcomma				, '')
	#SET(lcomma2				, '')
	
	#FOR (pRecord_MetaInfo)
		#FOR (Field)
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
            #SET(name_lowercase ,STD.Str.ToLowerCase(%'name'%))
            
						#APPEND(layout_record	      ,'\t\t' + %'@type'% + %'lsize'% + %'fillertype'% + %'name'% + %'fillername'% + ';\n')
						#APPEND(layout_record_xpath	,'\t\t' + %'@type'% + %'lsize'% + %'fillertype'% + %'name'% + %'fillername'% + '{xpath(\'' + %'name_lowercase'% + '\')};\n')
						#APPEND(string_layout_record,'+ \'\t\t' + %'@type'% + %'lsize'% + %'fillertype'% + %'name'% + %'fillername'% + ';\\n\'\n')

						#SET(lnumFields	,%lnumFields% + 1)
						#IF(%lnumFields% = 1) #SET(lcomma,'\t\t ') #ELSE #SET(lcomma,'\n\t\t,') #END
						#APPEND(loutSetFields						,%'lcomma'% + '\'' + %'name'% + '\'')
						#IF(pConvertAllFields2String = false)
							#APPEND(lfGetField	,%'lcomma'% + 'pfield = ' + %'lnumFields'% + ' => pRow.' + %'name'% )
						#ELSE
							#APPEND(lfGetField	,%'lcomma'% + 'pfield = ' + %'lnumFields'% + ' => ')
              #IF(%'lType'% != 'boolean')
                #APPEND(lfGetField  ,'(string)pRow.' + %'name'% )
              #ELSE
                #APPEND(lfGetField  ,'if(pRow.' + %'name'% + ' = true ,\'true\' ,\'false\')' )
//							#APPEND(lfGetField	,%'lcomma'% + 'pfield = ' + %'lnumFields'% + ' => (string)pRow.' + %'name'% )
              #END
						#END
					#END
				#END
			#END
		#END
	#END
	
	#APPEND(layout_record									, '\tend;\n')
	#APPEND(string_layout_record          , '+ \'\t}\';\n')
	#APPEND(layout_record_xpath									, '\tend;\n')
	#APPEND(loutSetFields						, '\n\t];\n')
	#IF((%'lType'% = 'unsigned' or %'lType'% = 'integer' or %'lType'% = 'real' or %'lType'% = 'decimal') and pConvertAllFields2String = false)
		#APPEND(lfGetField						, '\n\t\t,0\n\t);\n')
	#ELSE
		#APPEND(lfGetField						, '\n\t\t,\'\'\n\t);\n')
	#END
	
	#APPEND(moutput	,%'layout_record'% + %'layout_record_xpath'% + %'string_layout_record'% + %'loutSetFields'% + %'lfGetField'% + %'lfGetFieldName'% + '\nend;')
//	#SET(loutput  ,%'moutput'% + ' return ' + %'mymodule'% + ';\n'))
	#SET(loutput  ,%'moutput'% )
  
	#if(pOutputEcl = true)
		return %'moutput'%;
	#ELSE
		%loutput%
	#END

endmacro;
