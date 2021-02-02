/*
  mac_dataset_diff
    if you have a rid
      need to compare all fields for each record.
      can join on rid, and then generate code in the transform to compare each field left and right.
      put the differences of those fields into a child dataset.  record number,fieldname, left field value, right field value.
      then, normalize out the child dataset.
      then i have the record number, the fieldname, left field value, right field value
      dedup on record number to get number of records affected.
      then, dedup on record number, and then count to get number of fields per record changed.
      dedup on fieldname to get number of records changed per field
      
      
*/

// -- datasets should be the same layout
// -- scouts honor on this one

EXPORT mac_Dataset_Diff(

	 pDataset_orig							  // Passed in Dataset, original
	,pDataset_new								  // Passed in Dataset, changed
	,pRidField								    // unique id field
	,pOutputEcl		      = 'false'	// Should output the ecl as a string(for testing) or actually run the ecl

) :=
functionmacro

	LOADXML('<xml/>');
	#EXPORTXML(pRecord_MetaInfo, recordof(pDataset_orig))

	#uniquename(stringfiller		)
	#uniquename(lsetFields			)
	#uniquename(lcountsetFields	)
	#uniquename(lcounter				)
	#uniquename(lfield   				)
	#uniquename(moutput   			)
	#uniquename(loutput   			)
	#uniquename(ljoin      			)

	// -- Validate that pRidField exists in the layout
	tools.mac_GetFieldType(pRecord_MetaInfo,#TEXT(pRidField),lDoesRIDExist,true);
	#IF(%'lDoesRIDExist'% = '') #ERROR('tools.mac_Diff_Dataset: ERROR-The following field doesn\'t exist: ' + #TEXT(pRidField)) #END

	#SET(lsetFields	,tools.mac_SetFields(pRecord_MetaInfo,'^(?!' + #TEXT(pRidField) + ').*$',true))
	#SET(lcountSetFields  ,count(%lsetFields%))
	// -- Set defaults
	#SET(lcounter							,1	)

  lay_diff_child := {unsigned rid ,string fieldname ,string left_field_value  ,string right_field_value};

  ds_join := join(pDataset_orig ,pDataset_new ,left.pRidField = right.pRidField ,transform({dataset(lay_diff_child) diff_info ,recordof(left)},
  
	#SET(ljoin			,'diff_info_child := \n')
	
	#LOOP
		#IF(%lcounter% > %lcountSetFields%)
			#BREAK
		#END

		#IF(%lcounter% > 1)
      #APPEND(ljoin ,'+ ')
    #ELSE
      #APPEND(ljoin ,'  ')
    #END

		#SET(lfield		,%lsetFields%[%lcounter%])

    #APPEND(ljoin ,'if(left.' + %'lfield'% + ' != right.' + %'lfield'% + ',dataset([{left.' + #TEXT(pRidField) + ',\'' + %'lfield'% + '\' ,(string)left.' + %'lfield'% + ' ,(string)right.' + %'lfield'% + '}],lay_diff_child) ,dataset([],lay_diff_child))' + '\n')

		#SET(lcounter	,%lcounter% + 1)		

	#END

  #APPEND(ljoin ,';\n')
  #APPEND(ljoin ,'self.diff_info := diff_info_child;\n')
  #APPEND(ljoin ,'self           := left;\n')
  #APPEND(ljoin ,'));\n')
  
  %ljoin%
  
	#SET(moutput	,%'ljoin'%)

  // #SET(loutput	,%'moutput'% + 'return dsort;\n')

  // then, normalize out the child dataset.
  // then i have the record number, the fieldname, left field value, right field value
  // dedup on record number to get number of records affected.
  // then, dedup on record number, and then count to get number of fields per record changed.
  // dedup on fieldname to get number of records changed per field
  ds_norm := normalize(ds_join  ,left.diff_info ,transform(recordof(right)  ,self := right));
  ds_records_affected           := table(ds_norm  ,{rid       ,unsigned cnt_fields_changed_per_record := count(group)} ,rid       ,merge);
  ds_records_changed_per_field  := table(ds_norm  ,{fieldname ,unsigned cnt_records_changed           := count(group)} ,fieldname ,merge);
  
  ds_stats := dataset([
    {'pDataset_orig'        ,ut.fIntWithCommas(count(pDataset_orig                ))}
   ,{'pDataset_new'         ,ut.fIntWithCommas(count(pDataset_new                 ))}
   ,{'ds_join'              ,ut.fIntWithCommas(count(ds_join                      ))}
   ,{'ds_norm'              ,ut.fIntWithCommas(count(ds_norm                      ))}
   ,{'ds_records_affected'  ,ut.fIntWithCommas(count(ds_records_affected          ))}
   ,{'ds_fields_affected'   ,ut.fIntWithCommas(count(ds_records_changed_per_field ))}
  
  ]  ,{string statname  ,string statvalue});
  
  debug_output := parallel(
     output(     ds_stats                                                    ,named('tools_mac_dataset_diff__ds_stats'                      )      )
    ,output(topn(ds_join                      ,300  ,pRidField            )  ,named('tools_mac_dataset_diff__ds_join'                       )  ,all)
    ,output(topn(ds_norm                      ,300  ,rid                  )  ,named('tools_mac_dataset_diff__ds_norm'                       )  ,all)
    ,output(topn(ds_records_affected          ,300  ,rid                  )  ,named('tools_mac_dataset_diff__ds_records_affected'           )  ,all)
    ,output(topn(ds_records_changed_per_field ,300  ,-cnt_records_changed )  ,named('tools_mac_dataset_diff__ds_records_changed_per_field'  )  ,all)
  
  );
	#if(pOutputEcl = true)
		return %'ljoin'%;
	#ELSE
		return when(ds_join ,debug_output);	
	#END
	
endmacro;