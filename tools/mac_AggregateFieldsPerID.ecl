/*
	-----------------------------------------------------------------------------------------
	-- mac_AggregateFieldsPerID
	-- This macro aggregates fields per id to give you a representation of what data comprises each id.  
	-- It also tells you how many times each value occurs within the id, useful for identifying outliers.
	-- the result will be sorted by the ids that have the most unique values of all fields combined.
	-- Example of its use:

	output(tools.mac_AggregateFieldsPerID(BIPV2_PROX_SALT_int_micro_lowlevel.In_DOT_Base,dotid));
	This call will aggregate all of the fields in the BIPV2_PROX_SALT_int_micro_lowlevel.In_DOT_Base dataset grouped on dotid.

	-----------------------------------------------------------------------------------------	
*/
EXPORT mac_AggregateFieldsPerID(

	 pDataset								      // Passed in Dataset
	,pIdField								      // Aggregate fields within this ID field
	,pSetFields		      = '[]'		// Fields to Aggregate.  By default it will do all of them.
  ,pShouldSort        = 'true'  // Should sort dataset by descending number of unique values in all fields?
	,pOutputEcl		      = 'false'	// Should output the ecl as a string(for testing) or actually run the ecl
	,pRemoveCntFields		= 'false'	// Should Remove the cnt fields on the child datasets?
	,pFew		            = 'false'	// Are the results going to be very few rows?(helps with optimization of the tables)
	,pLimitChildDatasts = '0'	    // Limit on number of records in child datasets.  Default is zero which means unlimited.  anything else will do a choosen per dataset.

) :=
functionmacro

	LOADXML('<xml/>');
	#EXPORTXML(pRecord_MetaInfo, recordof(pDataset))

	#uniquename(stringfiller		)
	#uniquename(lsetFields			)
	#uniquename(lcountsetFields	)
	#uniquename(lcounter				)
	#uniquename(lfields					)
	#uniquename(lfield					)
	#uniquename(loutput					)
	#uniquename(moutput					)
	#uniquename(dtable					)
	#uniquename(dtableField			)
	#uniquename(layrollup				)
	#uniquename(layrollup2				)
	#uniquename(dPrep						)
	#uniquename(dPrepField			)
	#uniquename(dmerge					)
	#uniquename(drollupsort			)
	#uniquename(drolluptrans		)
	#uniquename(dsort						)
	#uniquename(sortfields			)
	#uniquename(tablecnt			  )
	#uniquename(tablesumcnt			)
	#uniquename(laycnt    			)
	#uniquename(dprepselfcnt		)
	#uniquename(dpreptotalcnt		)
	#uniquename(childdatasetcntfield		)
	#uniquename(sortcntfields		)

	// -- Validate that pIdField exists in the layout
	tools.mac_GetFieldType(pRecord_MetaInfo,#TEXT(pIdField),lDoesIDExist,true);
	#IF(%'lDoesIDExist'% = '') #ERROR('BIPV2_Tools.mac_AggregateFieldsPerID: ERROR-The following field doesn\'t exist: ' + #TEXT(pIdField)) #END

	// -- Validate that the fields in psetFields exist in the layout
	#SET(lcountsetFields		,count(psetFields	));
	#IF(%lcountsetFields%	!= 0)
		#SET(lsetFields	,#TEXT(pSetFields	))
		tools.mac_DoFieldsExist(pRecord_MetaInfo	,%lsetFields%	,lsetFieldDontExist	,true);	
		#IF(count(%lsetFieldDontExist%) != 0) #ERROR('BIPV2_Tools.mac_AggregateFieldsPerID: ERROR-The following fields don\'t exist: ' + %'lsetFieldDontExist'%) #END
	#ELSE	// -- if no fields in psetFields, use all fields in layout minus the pIdField
		#SET(lsetFields	,tools.mac_SetFields(pRecord_MetaInfo,'^(?!' + #TEXT(pIdField) + ').*$',true))
		#SET(lcountsetFields		,count(%lsetFields%	));
	#END
	
	// -- Set defaults
	#SET(lcounter							,1	)

	#SET(stringfiller, '                                                                           ')
  #IF(pRemoveCntFields = true)
    #SET(tablecnt ,'')
    #SET(tablesumcnt ,'')
    #SET(laycnt ,'')
    #SET(dprepselfcnt ,'')
    #SET(dpreptotalcnt ,'')
    #SET(childdatasetcntfield ,'')
    #SET(sortcntfields ,'')
  #ELSE
    #SET(tablecnt ,',unsigned8 cnt := count(group)')
    #SET(tablesumcnt ,',unsigned8 cnt := sum(group,cnt)')
    #SET(laycnt ,',unsigned8 cnt')
    #SET(dprepselfcnt ,',self.cnt := left.cnt')
    #SET(dpreptotalcnt ,',-cnt')
    #SET(childdatasetcntfield ,',left.cnt')
    #SET(sortcntfields ,',left.cnt')

  #END
  
  #IF(pFew = false)
    #SET(dtable			,'dtable 							:= table(' + #TEXT(pDataset) + ',{' + #TEXT(pIdField) + '	' + %'tablecnt'% + '},' + #TEXT(pIdField) + ',merge);\n')
  #ELSE
    #SET(dtable			,'dtable 							:= table(' + #TEXT(pDataset) + ',{' + #TEXT(pIdField) + '	' + %'tablecnt'% + '},' + #TEXT(pIdField) + ',few);\n')
  #END
	#SET(layrollup	,'layrollup := {' + #TEXT(pDataset) + '.' + #TEXT(pIdField) + %'laycnt'% + '\n')
  #SET(layrollup2 ,'')
	#SET(dPrep			,'dPrep						  	:= sort(distribute(project(dtable 							,transform(layrollup' + %'dprepselfcnt'% + ',self := left,self := [];)),hash64(' + #TEXT(pIdField) + ')),' + #TEXT(pIdField) + ',-cnt')
	#SET(dmerge		,'dmerge := Merge(\n\tdPrep\n')
	#SET(drollupsort,'drollup := group(rollup(dmerge,left.' + #TEXT(pIdField) + ' = right.' + #TEXT(pIdField) + '\n')
	#SET(drolluptrans,',transform(recordof(left)\n')

	#SET(dsort			,'dsort := sort(drollup	,-(')
	#SET(sortfields	,'')
	
	#LOOP
		#IF(%lcounter% > %lcountSetFields%)
			#BREAK
		#END

		#SET(lfield		,%lsetFields%[%lcounter%])
		#SET(lfields	,%lsetFields%[%lcounter%] + 's')

		#IF(%lcounter% = 1)
			#APPEND(dsort, 'count_' + %'lfields'% + '')
		#ELSE
			#APPEND(dsort, '+ count_' + %'lfields'% + '')
		#END
		
		#SET(dtableField	,'dtable' + %'lfields'%)
		#SET(dPrepField		,'dPrep' 	+ %'lfields'%)

    #IF(pFew = false)
      // #APPEND(dtable		,%'dtableField'% + ' := project(group(sort(table(' + #TEXT(pDataset) + '(' + %'lfield'% + '	!= (typeof(' + %'lfield'% + '))\'\'),{' + #TEXT(pIdField) + '	,' + %'lfield'% + '	' + %'tablecnt'% + '},' + #TEXT(pIdField) + ',' + %'lfield'% + ',merge),' + #TEXT(pIdField) + %'dpreptotalcnt'% + '),' + #TEXT(pIdField) + '),transform({recordof(left),unsigned sortcnt},self := left,self.sortcnt := counter))(sortcnt <= ' + #TEXT(pLimitChildDatasts) + ');\n')
      #APPEND(dtable		,%'dtableField'% + '_raw := project(group(sort(table(' + #TEXT(pDataset) + '(' + %'lfield'% + '	!= (typeof(' + %'lfield'% + '))\'\'),{' + #TEXT(pIdField) + '	,' + %'lfield'% + '	' + %'tablecnt'% + '},' + #TEXT(pIdField) + ',' + %'lfield'% + ',merge),' + #TEXT(pIdField) + %'dpreptotalcnt'% + ',skew(0.3)),' + #TEXT(pIdField) + '),transform({recordof(left),unsigned sortcnt},self := left,self.sortcnt := counter));\n')
      #APPEND(dtable		,%'dtableField'% + '_max := table(group(' + %'dtableField'% + '_raw) ,{' + #TEXT(pIdField) + ',unsigned8 max_cnt := count(group)} ,' + #TEXT(pIdField) + ' ,merge);\n')
      #APPEND(dtable		,%'dtableField'% + ':= join(group(' + %'dtableField'% + '_raw) ,' + %'dtableField'% + '_max ,left.' + #TEXT(pIdField) + ' = right.' + #TEXT(pIdField) + '  ,transform({recordof(left),unsigned8 count_' + %'lfields'% + '}\n')
      #APPEND(dtable		,'  ,self.count_' + %'lfields'% + ' := right.max_cnt,self := left),hash)\n')      
      #IF(pLimitChildDatasts > 0)
        #APPEND(dtable		,'(sortcnt <= ' + #TEXT(pLimitChildDatasts) + ');\n')
      #ELSE
        #APPEND(dtable		,';\n')
      #END

    #ELSE
      #APPEND(dtable		,%'dtableField'% + ' := table(' + #TEXT(pDataset) + '(' + %'lfield'% + '	!= (typeof(' + %'lfield'% + '))\'\'),{' + #TEXT(pIdField) + '	,' + %'lfield'% + '	' + %'tablecnt'% + '},' + #TEXT(pIdField) + ',' + %'lfield'% + ',few);\n')
    #END
		#APPEND(layrollup	,', dataset({typeof(' + #TEXT(pDataset) + '.' + %'lfield'% + ') ' + %'lfield'% + %'laycnt'% + '}) ' + %'lfields'% + '\n')
    #APPEND(layrollup2  ,' ,unsigned8 count_' + %'lfields'%)
		#APPEND(dPrep			,%'dPrepField'% + ' := sort(distribute(project(' + %'dtableField'% + '	,transform(layrollup,self.' + %'lfields'% + ' := dataset([{left.' + %'lfield'% + %'childdatasetcntfield'% + '}],{typeof(' + #TEXT(pDataset) + '.' + %'lfield'% + ') ' + %'lfield'% + %'laycnt'% + '}),self := left,self := [];)),hash64(' + #TEXT(pIdField) + ')),' + #TEXT(pIdField) + ',-cnt')
		#APPEND(dmerge		,', ' + %'dPrepField'% + '\n')
    #IF(pRemoveCntFields = true)
      #APPEND(sortfields	,',' + %'lfields'% + '[1].' + %'lfield'%)
    #ELSE
      #APPEND(sortfields	,',-' + %'lfields'% + '[1].cnt' + ',' + %'lfields'% + '[1].' + %'lfield'%)
    #END
    
		#APPEND(drolluptrans,',self.' + %'lfields'% + ' 	:= left.' + %'lfields'% + ' + right.' + %'lfields'% + '\n')
		#APPEND(drolluptrans,',self.count_' + %'lfields'% + ' 	:= max(left.count_' + %'lfields'% + ' ,right.count_' + %'lfields'% + ')\n')

		#SET(lcounter	,%lcounter% + 1)		
	#END

	#APPEND(layrollup	,%'layrollup2'% + '};\n')
	#APPEND(dmerge	,',sorted(' + #TEXT(pIdField) + %'dpreptotalcnt'% + %'sortfields'% + '),local);\n')
	#APPEND(sortfields	,',local)')
//	#APPEND(drollupsort	,%'sortfields'% + ',true\n')
	#APPEND(drolluptrans	,',self := left\n),local));\n')
	#APPEND(dsort	,'));\n')
	
	#SET(dPrep 	,regexreplace(',-cnt' ,%'dPrep'%,%'dpreptotalcnt'% + %'sortfields'% + ';\n',nocase))
	
	#SET(moutput	,%'dtable'% + %'layrollup'% + %'dPrep'% + %'dmerge'% + %'drollupsort'% + %'drolluptrans'% + %'dsort'% + '\n')
  #IF(pShouldSort = true)
    #SET(loutput	,%'moutput'% + 'return dsort;\n')
	#ELSE
    #SET(loutput	,%'moutput'% + 'return drollup;\n')
  #END
	#if(pOutputEcl = true)
		return %'moutput'%;
	#ELSE
		%loutput%		
	#END
	
endmacro;