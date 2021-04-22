/*
	-- macf_LayoutTools macro
	Gives you the following in a module in the pOutput parameter
	pOutput.layout_record		      -- the layout of the passed record.  Useful if record is spread out over multiple attributes, this puts it in one.  
	pOutput.setAllFields		      -- A set of all of the fieldnames in the record.	
	pOutput.fGetFieldName		      -- function.  pass the field # and it gives you the fieldname.
	pOutput.fGetFieldValue	      -- function.  pass it the field # and the row(i.e. left in a transform) and it will give you the value for that field.
	pOutput.fGetFieldValueByName	-- function.  pass it the field name and the row(i.e. left in a transform) and it will give you the value for that field.
	pOutput.tablefields           -- functionmacro.  returns a cut down deduped table of only the fields that pass the pFieldFilter.  second boolean parameter can filter so that only records that have data in at least one of the fields are retained.

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
	,pTableExceptionFilter	  = '\'\''	// fields you don't want to be used in the filter for the tablefields, but do want them included.
	
) :=
functionmacro
	
	// #IF(pForUseInMacro	= false)
		LOADXML('<xml/>');
  // #END
  import std;
	#EXPORTXML(pRecord_MetaInfo, pRecord)
	#uniquename(name							          )
	#uniquename(name_lowercase		 					)
	#uniquename(named_layout			          )
	#uniquename(stringfiller			          )
	#uniquename(lenName						          )
	#uniquename(lenType						          )
	#uniquename(fillername				          )
	#uniquename(fillertype				          )
	#uniquename(moutput						          )
	#uniquename(loutput						          )
	#uniquename(layout_record						    )
	#uniquename(string_layout_record				)
	#uniquename(layout_record_xpath					)
	#uniquename(lsize							          )
	#uniquename(loutSetFields			          )
	#uniquename(loutSetTableExceptionFields )
	#uniquename(lnumFields				          )
	#uniquename(lnumExceptionFields         )
	#uniquename(lcomma						          )
	#uniquename(lcomma2						          )
	#uniquename(lnumSubstringFields				  )
	#uniquename(lsubstringfield				      )
	#uniquename(lfGetField				          )
	#uniquename(lfGetFieldValueByName				)
	#uniquename(lfGetFieldTable				      )
	#uniquename(lfGetFieldValueByNameTable  )
	#uniquename(lfGetFieldName				      )
	#uniquename(lType						            )
	#uniquename(mymodule						        )
	#uniquename(tablefunction						    )
	#uniquename(tablefields						      )
	#uniquename(fieldAndFilter						  )

	#uniquename(slimfunction						    )
	#uniquename(slimfields						      )

	#SET(stringfiller, '                                                                           ')
	#SET(moutput				,							'return\nmodule\n')
//	#SET(moutput				,							%'mymodule'% +  ' :=\nmodule\n')

	#SET(layout_record					,'\texport layout_record :=\n\trecord\n')
	#SET(string_layout_record   ,'\texport string_layout_record := \'{\\n\'\n')
	#SET(layout_record_xpath	  ,'\texport layout_record_xpath :=\n\trecord\n')
	#SET(loutSetFields					,'\texport setAllFields :=\n\t[\n')
	#SET(loutSetTableExceptionFields					,'\texport setExceptionFields :=\n\t[\n')
	#SET(lfGetFieldValueByName  ,'\texport fGetFieldValueByName(string pfieldname,' + trim(#TEXT(pRecord),all) + ' pRow) :=\n\tmap(\n') 
	#SET(lfGetField							,'\texport fGetFieldValue(unsigned2 pfield,' + trim(#TEXT(pRecord),all) + ' pRow) :=\n\tmap(\n') 

	#SET(lfGetFieldValueByNameTable  ,'\texport fGetFieldValueByNameTable(string pfieldname,layout_record pRow) :=\n\tmap(\n') 
	#SET(lfGetFieldTable						,'\texport fGetFieldValueTable(unsigned2 pfield,layout_record pRow) :=\n\tmap(\n') 

	#SET(lfGetFieldName					,'\texport fGetFieldName(unsigned2 pfield) := setAllFields[pfield];\n') 
	#SET(tablefunction  			  ,'\texport tablefields(pTableDataset,pFilterOutBlanks = false) := functionmacro\n\t\treturn if(pFilterOutBlanks = false\n\t\t\t,table(pTableDataset,{')
	#SET(slimfunction  			    ,'\texport slimfields(pTableDataset) := functionmacro\n\t\treturn table(pTableDataset,{')

	// #SET(fieldAndFilter	, 'export fieldAndFilter() := functionmacro\n\t return ')
  
	#SET(fieldAndFilter	, '')
	#SET(tablefields	, '')
	#SET(slimfields	  , '')
	#SET(named_layout	, '')
	#SET(name					, '')
	#SET(lnumFields		, 0)
	#SET(lnumExceptionFields		, 0)
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


				  	#APPEND(tablefields	          ,',' + %'name'% )
				  	#APPEND(slimfields	          ,',' + %'name'% )
            #IF(pTableExceptionFilter = '' or not regexfind(pTableExceptionFilter,%'name'%,nocase) = true) 
              #APPEND(fieldAndFilter	      ,' or ' + %'name'% + ' != (typeof(' + %'name'% + '))\'\'')
            #ELSE
              #SET(lnumExceptionFields	,%lnumExceptionFields% + 1)
              #IF(%lnumExceptionFields% = 1) #SET(lcomma,'\t\t ') #ELSE #SET(lcomma,'\n\t\t,') #END
              #APPEND(loutSetTableExceptionFields						,%'lcomma'% + '\'' + %'name'% + '\'')
            #END

						#SET(lnumFields	,%lnumFields% + 1)
						#IF(%lnumFields% = 1) #SET(lcomma,'\t\t ') #ELSE #SET(lcomma,'\n\t\t,') #END
						#APPEND(loutSetFields						,%'lcomma'% + '\'' + %'name'% + '\'')
            
						#IF(pConvertAllFields2String = false)
							#APPEND(lfGetField	          ,%'lcomma'% + 'pfield = ' + %'lnumFields'% + ' => pRow.' + %'name'% )
							#APPEND(lfGetFieldValueByName	,%'lcomma'% + 'pfieldname = \''  + trim(%'name'%) + '\' => pRow.' + %'name'% )
              
							#APPEND(lfGetFieldTable	          ,%'lcomma'% + 'pfield = ' + %'lnumFields'% + ' => pRow.' + %'name'% )
							#APPEND(lfGetFieldValueByNameTable	,%'lcomma'% + 'pfieldname = \''  + trim(%'name'%) + '\' => pRow.' + %'name'% )
						#ELSE
							#APPEND(lfGetField	          ,%'lcomma'% + 'pfield = ' + %'lnumFields'% + ' => ')
							#APPEND(lfGetFieldValueByName	,%'lcomma'% + 'pfieldname = \'' + trim(%'name'%) + '\' => ')

							#APPEND(lfGetFieldTable	          ,%'lcomma'% + 'pfield = ' + %'lnumFields'% + ' => ')
							#APPEND(lfGetFieldValueByNameTable	,%'lcomma'% + 'pfieldname = \'' + trim(%'name'%) + '\' => ')
              #IF(%'lType'% != 'boolean')
                #APPEND(lfGetField              ,'(string)pRow.' + %'name'% )
                #APPEND(lfGetFieldValueByName   ,'(string)pRow.' + %'name'% )
                #APPEND(lfGetFieldTable              ,'(string)pRow.' + %'name'% )
                #APPEND(lfGetFieldValueByNameTable   ,'(string)pRow.' + %'name'% )
              #ELSE
                #APPEND(lfGetField              ,'if(pRow.' + %'name'% + ' = true ,\'true\' ,\'false\')' )
                #APPEND(lfGetFieldValueByName   ,'if(pRow.' + %'name'% + ' = true ,\'true\' ,\'false\')' )
                #APPEND(lfGetFieldTable              ,'if(pRow.' + %'name'% + ' = true ,\'true\' ,\'false\')' )
                #APPEND(lfGetFieldValueByNameTable   ,'if(pRow.' + %'name'% + ' = true ,\'true\' ,\'false\')' )
//							#APPEND(lfGetField	,%'lcomma'% + 'pfield = ' + %'lnumFields'% + ' => (string)pRow.' + %'name'% )
              #END
						#END
					#END
				#END
			#END
		#END
	#END

	// #SET(tablefunction  			  ,'\texport tablefields(pTableDataset,pFilterOutBlanks = false) := functionmacro\n\t\treturn if(pFilterOutBlanks = false,table(pTableDataset,{')
	
	#APPEND(tablefunction	  ,trim(%'tablefields'%)[2..] + '}' + trim(%'tablefields'%) + ',merge)\n')
	#APPEND(tablefunction	  ,'\t\t\t,table(pTableDataset(' + %'fieldAndFilter'%[4..] + '),{' + trim(%'tablefields'%)[2..] + '}' + trim(%'tablefields'%) + ',merge));\n\tendmacro;')
	#APPEND(slimfunction	  ,trim(%'tablefields'%)[2..] + '});\n\tendmacro;\n')

	#APPEND(layout_record									, '\tend;\n')
	#APPEND(string_layout_record          , '+ \'\t}\';\n')
	#APPEND(layout_record_xpath									, '\tend;\n')
	#APPEND(loutSetFields						, '\n\t];\n')
	#APPEND(loutSetTableExceptionFields						, '\n\t];\n')
  
	#IF((%'lType'% = 'unsigned' or %'lType'% = 'integer' or %'lType'% = 'real' or %'lType'% = 'decimal') and pConvertAllFields2String = false)
		#APPEND(lfGetField						, '\n\t\t,0\n\t);\n')
		#APPEND(lfGetFieldValueByName , '\n\t\t,0\n\t);\n')
		#APPEND(lfGetFieldTable						, '\n\t\t,0\n\t);\n')
		#APPEND(lfGetFieldValueByNameTable , '\n\t\t,0\n\t);\n')
    
	#ELSE
		#APPEND(lfGetField						, '\n\t\t,\'\'\n\t);\n')
		#APPEND(lfGetFieldValueByName , '\n\t\t,\'\'\n\t);\n')
		#APPEND(lfGetFieldTable						, '\n\t\t,\'\'\n\t);\n')
		#APPEND(lfGetFieldValueByNameTable , '\n\t\t,\'\'\n\t);\n')
	#END
	
	#APPEND(moutput	,%'layout_record'% + %'layout_record_xpath'% + %'string_layout_record'% + %'loutSetFields'% + %'loutSetTableExceptionFields'% + %'lfGetField'% + %'lfGetFieldValueByName'% + %'lfGetFieldTable'% + %'lfGetFieldValueByNameTable'% + %'lfGetFieldName'% + %'tablefunction'% + %'slimfunction'% + '\nend;')
//	#SET(loutput  ,%'moutput'% + ' return ' + %'mymodule'% + ';\n'))
	#SET(loutput  ,%'moutput'% )
  
	#if(pOutputEcl = true)
		return %'moutput'%;
	#ELSE
		%loutput%
	#END

endmacro;
