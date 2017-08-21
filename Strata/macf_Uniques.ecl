/*
	Automatically generate standard STRATA uniques stats based on the layout of the passed in dataset
	makes it easier to generate and/or run these types of stats
	If pOutputEcl is set to 'true', it will output the ecl generated by the macro as a string, so it can 
		be copy-pasted into an attribute or builder window and run(useful for generating static population stats)
	Else, it will generate the ecl and then run it, generating the stats themselves.
*/
export macf_Uniques(

	 pDataset														// input dataset
	,pGroupByField						= '\'\''	// Field that the table should be grouped on
	,pOutputEcl								= 'false'	// Should output the ecl as a string(for testing) or actually run the ecl
	,pShouldRemoveFieldsInSet	= 'true'	// Should the fields in the following parameter(pSetFields) be removed from the stats, or should they be the only ones kept?
	,pSetFields								= '[]'		// remove/keep these fields from population stats(based on whether pShouldRemoveFieldsInSet is true or not)
	,pKeepGroupByField				= 'false'	// keep group by field in layout
	
) :=
functionmacro
	
	//need to unmangle attributes used in code when outputing the ecl

	LOADXML('<xml/>');
	#EXPORTXML(pDataset_MetaInfo, recordof(pDataset))

	#uniquename(ldataset					)
	#uniquename(preoutput					)
	#uniquename(ltables_output		)
	#uniquename(projectoutput			)
	#uniquename(layout_part1			)
	#uniquename(layout_part2			)
	#uniquename(fieldname					)
	#uniquename(lgroupbyfield			)
	#uniquename(groupbyfield			)
	#uniquename(groupbytype				)
	#uniquename(name							)
	#uniquename(named_layout			)
	#uniquename(stringfiller			)
	#uniquename(lenName						)
	#uniquename(fillerunique			)
	#uniquename(fillertype				)
	#uniquename(fillertrue				)
	#uniquename(moutput						)
	#uniquename(dDataset					)
	#uniquename(Layout_Uniques		)
	#uniquename(pInput_stat				)
	#uniquename(pInput_prep				)
	#uniquename(CountUnique				)
	#uniquename(lfilter						)
	#uniquename(lsticky						)
	#uniquename(theoutput					)
	#uniquename(pgroupbyfield2		)
	#uniquename(lSetFields				)
	#uniquename(last_layout				)
/*
	loop through fields
		do a unique table on each field, populating the inline dataset as you go
		also write the layout for the dataset in a separate attribute
	concatenate the two string attributes created above
	return dataset
*/
	#SET(lSetFields	,stringlib.stringtouppercase(#TEXT(pSetFields)))
	#SET(stringfiller, '                                                                           ')
	#SET(ldataset	,trim(#TEXT(pDataset),all))

	#SET(moutput	,trim(#TEXT(pOutput),all))

	//need to unmangle attributes used in code when outputing the ecl
	#if(pOutputEcl = true)
		#SET(dDataset						,'pDataset')
		#SET(Layout_Uniques			,'Layout_Uniques')
		#SET(pInput_stat				,'pInput_stat')
		#SET(pInput_prep				,'pInput_prep')
		#SET(fieldname					, '')
	#END

	#SET(ltables_output					, '')
	#SET(layout_part2					, '')
	#IF(pgroupbyfield = '')
		#SET(lgroupbyfield	, 'nogrouping')
		#SET(pgroupbyfield2	, 'nogrouping')
	#ELSE
		#SET(lgroupbyfield	, pgroupbyfield)
		#SET(pgroupbyfield2	, if(regexfind('[.]',pgroupbyfield), stringlib.stringreverse(regexfind('^([^.]*).*?$',stringlib.stringreverse(pgroupbyfield),1)),pgroupbyfield))
	#END
	
	#SET(lsticky, '0')
	
	#SET(layout_part1					, %'Layout_Uniques'% + ' :=\nrecord, maxlength(32796)\n')
	#APPEND(layout_part1			,'  unsigned8 CountGroup;\n')
	#IF(pgroupbyfield != '')
		#APPEND(layout_part1			,'  ' + %'dDataset'% + '.' + %'lgroupbyfield'% + ';\n')
	#ELSE
		#APPEND(layout_part1			,'  unsigned8 nogrouping;\n')
	#END
	#IF(pgroupbyfield = '')
		#SET(preoutput	,%'dDataset'% + ' := project(' + %'ldataset'% + ',transform({unsigned1 nogrouping := 0, recordof(' + %'ldataset'% + ')}, self := left));\n')
	#ELSE
		#SET(preoutput	,%'dDataset'% + ' := ' + %'ldataset'% + ';\n')
	#END
	
	#SET(projectoutput	,%'dDataset'% + '_proj' + ' := project(' + %'ddataset'% + '_table\n')
	#APPEND(projectoutput	,',transform(' + %'Layout_Uniques'% + ',\n')
	#APPEND(projectoutput	,'self.CountGroup := left.CountGroup;\n')
	#IF(pgroupbyfield = '')
		#APPEND(projectoutput	,'self.' + %'lgroupbyfield'% + ' := 0;\n')
	#ELSE
		#APPEND(projectoutput	,'self.' + %'pgroupbyfield2'% + ' := left.' + %'pgroupbyfield2'% + ';\n')
	#END
	
	#SET(named_layout	, '')
	#SET(name					, '')
	#FOR (pDataset_MetaInfo)
		#FOR (Field)
			#IF(%'@isRecord'% = '1' and %'named_layout'% = '')
				#SET(named_layout	,%'@name'%)
				#SET(last_layout	,%'@name'%)
			#ELSEIF(%'@isRecord'% = '1' and %'named_layout'% != '')
				#SET(named_layout	, %'named_layout'% + '.' + %'@name'%)
				#SET(fieldname		, regexreplace('[.]',%'named_layout'%,'_'))
				#SET(last_layout	, %'@name'%)
			#ELSE	// not start of named layout
				#IF(%'@type'% = '')
					#IF(%'@name'% = %'named_layout'%)	//end of named layout
						#SET(named_layout	, '')
					#ELSE															//end of named layout, move back one name
						#SET(named_layout	, regexreplace('[.]' + %'last_layout'%,%'named_layout'%,''))
						#SET(fieldname		, regexreplace('[_]' + %'last_layout'%,%'named_layout'%,''))
					#END
				#ELSE	// type != ''
					#IF(%'named_layout'% != '')
						#SET(name, %'named_layout'% + '.' + %'@name'%)
						#SET(fieldname, regexreplace('[.]',%'named_layout'%,'_') + '_' + %'@name'%)
					#ELSE
						#SET(name, %'@name'%)
						#SET(fieldname, %'@name'%)
					#END
					
					#SET(lenName				,length(trim(%'fieldname'%,left,right)))
					#SET(fillerunique		,%'stringfiller'%[1..(75 - (%lenName% - 1	))])
					#SET(CountUnique		, '_Unique'	)

					#IF(%'@type'% = 'integer' or %'@type'% = 'unsigned')
						#SET(lfilter, %'name'% + %'fillerunique'%	+ ' != 0   ')
						#SET(groupbyfield, %'fieldname'%)
						#IF(%@size% > 0)
							#SET(groupbytype, %'@type'% + %'@size'%)
						#ELSE
							#SET(groupbytype, %'@type'% + '8')
						#END
					#ELSEIF(%'@type'% = 'real')
						#SET(lfilter, %'name'% + %'fillerunique'%	+ ' != 0.0 ')
						#SET(groupbyfield, %'fieldname'%)
						#IF(%@size% > 0)
							#SET(groupbytype, %'@type'% + %'@size'%)
						#ELSE
							#SET(groupbytype, %'@type'%)
						#END
					#ELSEIF(%'@type'% = 'string' or %'@type'% = 'qstring')                                                                                                         
						#SET(lfilter, %'name'% + %'fillerunique'%	+ ' != \'\'  ')
						#SET(groupbyfield, %'fieldname'%)
						#IF(%@size% > 0)
							#SET(groupbytype, %'@type'% + %'@size'%)
						#ELSE
							#SET(groupbytype, %'@type'%)
						#END
					#ELSEIF(%'@type'% = 'data')                                                                                                         
						#SET(lfilter, %'name'% + %'fillerunique'%	+ ' != x\'\' ')
						#SET(groupbyfield, %'fieldname'%)
						#IF(%@size% > 0)
							#SET(groupbytype, %'@type'% + %'@size'%)
						#ELSE
							#SET(groupbytype, %'@type'%)
						#END
					#ELSEIF(%'@type'% = 'boolean')                                                                                                        
						#SET(lfilter, %'name'% + %'fillerunique'%	+ '  = true')
						#SET(groupbyfield, %'fieldname'%)
						#SET(groupbytype, 'boolean')
					#END
					
					#SET(fillertype		,%'stringfiller'%[1..(15 - (length(%'groupbytype'%) - 1	))])
					#APPEND(groupbytype, %'fillertype'%)
					
					#IF(StringLib.StringCompareIgnoreCase(%'name'%,%'lgroupbyfield'%) = 0)
						#APPEND(preoutput	, %'dDataset'% + '_table := table(' + %'dDataset'% + ',{' + %'lgroupbyfield'% + ',unsigned8 CountGroup := count(group)},' + %'lgroupbyfield'% + ',few);\n')
					#ELSE
						#IF(pgroupbyfield = '' and %'lsticky'% = '0')
							#APPEND(preoutput	, %'dDataset'% + '_table := dataset([{0,count(' + %'dDataset'% + ')}],{unsigned8 nogrouping, unsigned8 countgroup});\n')
							#SET(lsticky, '1')
						#END
					#END

					#IF((pKeepGroupByField = true or (pKeepGroupByField = false and (StringLib.StringCompareIgnoreCase(%'name'%,%'lgroupbyfield'%) != 0 ))) 
													and (			(pShouldRemoveFieldsInSet = true  and stringlib.stringtouppercase(trim(%'name'%,left,right)) not in %lSetFields%)
																or  (pShouldRemoveFieldsInSet = false and stringlib.stringtouppercase(trim(%'name'%,left,right))	   in %lSetFields%))
					)
						#APPEND(layout_part2, '\tunsigned8 ' + %'fieldname'% + %'CountUnique'% + %'fillerunique'%	+ ';\n')
						#APPEND(ltables_output, %'fieldname'% + %'CountUnique'% + %'fillerunique'%	+ ' := table(                 table(           table('  + %'dDataset'% + '(' + %'lfilter'% + '),{' + %'lgroupbyfield'% + ',' + %'groupbytype'% + %'groupbyfield'% + %'fillerunique'% + ' := ' + %'name'% + %'fillerunique'%	+ '}),           {' + %'pgroupbyfield2'% + ',' + %'groupbyfield'% + %'fillerunique'%	+ '},' + %'pgroupbyfield2'% + ',' + %'groupbyfield'% + %'fillerunique'%	+ ',merge)                                                                                                                                                            ,{' + %'pgroupbyfield2'% + ',unsigned8 cnt := count(group)},' + %'pgroupbyfield2'% + ',few);\n')
						#APPEND(projectoutput	,'self.' + %'fieldname'% + %'CountUnique'% + %'fillerunique'% + ':= ' +  %'fieldname'% + %'CountUnique'% + %'fillerunique'% + '(' + %'pgroupbyfield2'% + ' = left.' + %'pgroupbyfield2'% + ')[1].cnt;\n')
					#END
				#END
			#END
		#END
	#END

	#APPEND(projectoutput, '));\n');
	#SET(theoutput,  %'preoutput'%)
	#APPEND(layout_part1, %'layout_part2'%);
	#APPEND(layout_part1, 'end;\n');
	#APPEND(theoutput, %'layout_part1'%);
	#APPEND(theoutput, %'ltables_output'%)
	#APPEND(theoutput, %'projectoutput'%)
	#APPEND(theoutput, %'moutput'% + ' := ' + %'dDataset'% + '_proj;\n');


	#SET(moutput	,%'theoutput'% + ' return ' + %'moutput'% + ';\n')

	#if(pOutputEcl = true)
		return %'moutput'%;
	#ELSE
		%moutput%		
	#END


endmacro;