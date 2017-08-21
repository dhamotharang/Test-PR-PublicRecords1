export mac_Append_Dates(

	 pDataset																									// Input Dataset for Dateing
	,psetRawDateFields			= '[]'														// Set of raw Date fields, i.e. ['Date1','Date2']
	,psetCleanedDateFields	= '[]'														// Set of cleaned Date fields, i.e. ['clean_Date1','clean_Date2']
	,pRidField							= '\'\''													// Unique Id Field(rid) in input dataset.  If it doesn't exist, it will be created
	,pPersistname						= '\'\''													// set this if you would like to persist the output
	,pOutputEcl							= 'false'													// Should output the ecl as a string(for testing) or actually run the ecl

) :=
functionmacro

	/////////////////////////////////////////////
	// -- Start XML
	/////////////////////////////////////////////
	LOADXML('<xml/>');
	#EXPORTXML(pDataset_MetaInfo						,recordof(pDataset))

	
	#uniquename(ldataset								)
	#uniquename(loutput									)
	#uniquename(moutput									) 
	#uniquename(lcountsetDateFields   )
	#uniquename(lcountsetPnameFields	  ) 
	#uniquename(lcountsetZipFields		  )
	#uniquename(lcountsetDateFields	  ) 
	#uniquename(lcountall						    )
	#uniquename(lcountallfields			    )
	#uniquename(lerror                  ) 
	#uniquename(lcounter			          )
	#uniquename(lDateField	          ) 
	#uniquename(lPnameField	            )
	#uniquename(lZipField		            ) 
	#uniquename(lDateField						  )
	#uniquename(dDataset                ) 
	#uniquename(layoutOrigFile          )
	#uniquename(layoutSeqFile           )
	#uniquename(DateSlimLayout          ) 
	#uniquename(tSlimPrep         )
	#uniquename(dSlimForDateParse					)
	#uniquename(dDateMacroOut            ) 
	#uniquename(dDateOut                )
	#uniquename(dDateOut_dist           ) 
	#uniquename(dDateOut_sort           )
	#uniquename(dDateOut_dedup          ) 
	#uniquename(pDataset_dist           )
	#uniquename(tAssignDates            ) 
	#uniquename(dAssignDates		        )
	#uniquename(lMatchset				        )
	#uniquename(lcomma					        )
	#uniquename(lRidField					      )
	#uniquename(lClosingParen			      )
	#uniquename(dDedupSlim				      )
	#uniquename(dDateMacroOut_full				)
	#uniquename(lSetOfAllFields					)
	#uniquename(lsetRawDateFields				)
	#uniquename(lsetPnameFields					)
	#uniquename(lsetZipFields						)
	#uniquename(lsetRawDateFields					)
	#uniquename(lSourceisString					)
	#uniquename(lfeinfield							)
	#uniquename(lSourceDocidField				)
	#uniquename(lSourcePartyField				)
	#uniquename(tGetStandardizedDates	)
	#uniquename(dReformatOutput				)

	// if you want the ecl as a string, de-mangle the var names to make it readable
	#IF(pOutputEcl = true)
		#SET(dDataset					,'dDataset'				)
		#SET(layoutOrigFile		,'layoutOrigFile'	)
		#SET(layoutSeqFile		,'layoutSeqFile'	)
		#SET(DateSlimLayout		,'DateSlimLayout'	)
		#SET(tSlimPrep		,'tSlimPrep')
		#SET(dSlimForDateParse		,'dSlimForDateParse')
		#SET(dDateMacroOut			,'dDateMacroOut'		)
		#SET(dDateOut					,'dDateOut'				)
		#SET(dDateOut_dist			,'dDateOut_dist'	)
		#SET(dDateOut_sort			,'dDateOut_sort'	)
		#SET(dDateOut_dedup		,'dDateOut_dedup'	)
		#SET(pDataset_dist		,'pDataset_dist'	)
		#SET(tAssignDates			,'tAssignDates'		)
		#SET(dAssignDates			,'dAssignDates'		)
		#SET(dDedupSlim				,'dDedupSlim'			)
		#SET(dDateMacroOut_full	,'dDateMacroOut_full'			)
		#SET(tGetStandardizedDates	,'tGetStandardizedDates'			)
		#SET(dReformatOutput	,'dReformatOutput'			)
		#SET(lRidField				,'lRidField'			)
		#SET(moutput					,'moutput')
	#END


	// -- Check if passed in RID field exists or not
	#IF(pRidField	!= '')
		tools.mac_GetFieldType(pDataset_MetaInfo		,pRidField,lRidFieldType	,true);
		#SET(lRidField	,pRidField)
		#IF(%'lRidFieldType'% = '') #ERROR('tools.mac_Append_Dates: ERROR-field doesn\'t exist, pRidField: ' + pRidField	 	) #END
	#ELSE
		#uniquename(lRidFieldType	      )
		#SET(lRidFieldType	,'unsigned8')
	#END
	
	// -- Count Sets 
	#SET(lcountsetDateFields		,count(psetRawDateFields	));

	#SET(lsetRawDateFields	,#TEXT(psetRawDateFields	))

	// -- Validate Parameters, give some feedback if they are wrong
	// -- Unfortunately can't add up all the incoming fields into a set, and then loop through that set to find ones that don't exist
	// -- have to go through each individually.  U can do a count on a constructed set, but can't access individual items i.e. %lsetall%[1]
	#IF(%lcountsetDateFields%	 = 0) #ERROR('tools.mac_Append_Dates: ERROR-No Date fields specified in psetRawDateFields parameter') #END
//	#IF(%lcountsetDateFields%	!= 0) tools.mac_DoFieldsExist(pDataset_MetaInfo	,%lsetRawDateFields%	,lsetFieldDontExist	,true);	#IF(count(%lsetFieldDontExist%) != 0) #ERROR('tools.mac_Append_Dates: ERROR-fields don\'t exist: ' + %'lsetFieldDontExist'%) #END #END
	
	// -- Add RID field to dataset if it doesn't already exist
	#SET(ldataset			,trim(#TEXT(pDataset),all))
	#IF(pRidField	!= '')
		#SET		(loutput	,%'dDataset'% + ' := ' + %'ldataset'% + ';\n')
	#ELSE
		#SET		(loutput	,%'dDataset'% + ' := project(' + %'ldataset'% + '	,transform({recordof(' + %'ldataset'% + '), ' + %'lRidFieldType'% + ' ' + %'lRidField'% + '}, self.' + %'lRidField'% + ' := counter; self := left)) : global;\n')
	#END
	
	#APPEND	(loutput	,%'layoutOrigFile'% + '		:= recordof(' + %'ldataset'% + ');\n');
	#APPEND	(loutput	,%'layoutSeqFile'% + '		:= recordof(' + %'dDataset'% + ');\n');

	// -- Define Slim layout for passing into Date macro
	#APPEND	(loutput	,%'DateSlimLayout'% + '	:=\nrecord\n' );
	#APPEND	(loutput	,'\t' + %'lRidFieldType'% + '		unique_id					;\n');
	#APPEND	(loutput	,'\tstring orig_Date				:= \'\';\n');
	#APPEND	(loutput	,'\tstring8 clean_Date				:= \'\';\n');
	#APPEND	(loutput	,'\tunsigned4 Date_type				:= 0;\n');
	#APPEND	(loutput	,'\tend;\n');


	// -- Set defaults for counters, fields, etc
	#SET(lcounter					,1);
	#IF(%lcountsetDateFields% != 0)
		#SET(lDateField			,'choose(cnt	');
	#ELSE
		#SET(lDateField			,'\'\'');
	#END
	#SET(lClosingParen	,'');

	// -- set up multiple Date fields for transform
	#LOOP
		#IF(%lcounter% > %lcountsetDateFields%)
			#BREAK
		#END
		#IF(%lcounter% = %lcountsetDateFields%)	#SET(lClosingParen	,')') #END
		#IF(%lcountsetDateFields% != 0)
			#APPEND(lDateField		,',l.' + psetRawDateFields		[%lcounter%] + %'lClosingParen'%);
		#END
		#SET(lcounter	,%lcounter% + 1)
	#END
	
	// -- normalize transform
	#APPEND	(loutput	,%'DateSlimLayout'%  + ' ' + %'tSlimPrep'% + '(' + %'layoutSeqFile'% + ' l, unsigned4 cnt) :=\n')
	#APPEND	(loutput	,'transform\n')
	#APPEND	(loutput	,'\tself.unique_id		:= l.' + %'lRidField'% + '												;\n')
	#APPEND	(loutput	,'\tself.orig_Date		:= ' + %'lDateField'%	 	+ ';\n')
	#APPEND	(loutput	,'\tself.Date_type		:= cnt;\n')
	#APPEND	(loutput	,'end;\n')
	#APPEND	(loutput	,%'dSlimForDateParse'% + ' := normalize(' + %'dDataset'% + ',' + %'lcountsetDateFields'% + ',' + %'tSlimPrep'%  + '(left,counter));\n')

	// -- Dedup records before macro call to reduce possible skewing, and improve speed
	#APPEND	(loutput	,%'dDedupSlim'% + '	:= dedup(dedup(' + %'dSlimForDateParse'% + '	,except unique_id, local),except unique_id, all);\n')
	
	// -- call Date Parse macro
	#APPEND	(loutput	,'tools.mac_AppendStandardizedDate(\n')
	#APPEND	(loutput	,'\t ' + %'dDedupSlim'%	+ '\n' )					
	#APPEND	(loutput	,'\t,orig_Date				   \n')                   
	#APPEND	(loutput	,'\t,' + %'dDateMacroOut'% + '\n')	              
	#APPEND	(loutput	,'\t);\n')   

	// Join back to before dedup to paste Dates onto full file(non deduped file)
	#APPEND	(loutput	,%'dDateMacroOut_full'% + ' := join(\n')
	#APPEND	(loutput	,'\t ' + %'dSlimForDateParse'%	+ '\n')
	#APPEND	(loutput	,'\t,' + %'dDateMacroOut'% 		+ '((unsigned)(yyyy + mm + dd) != 0)\n')
	#APPEND	(loutput	,'\t,\t\tleft.orig_Date	 	= right.orig_Date		\n')
	#APPEND	(loutput	,'\t,transform(\n')
	#APPEND	(loutput	,'\t\trecordof(' + %'dDateMacroOut'% + ')\n')
	#APPEND	(loutput	,'\t\t,self.clean_Date		:= right.yyyy + right.mm + right.dd	;\n')
	#APPEND	(loutput	,'\t\t self							:= left							;\n')
	#APPEND	(loutput	,'\t\t self							:= right							;\n')
	#APPEND	(loutput	,'\t)\n')
	#APPEND	(loutput	,');\n')

	// -- Prep Datasets for join back to orig dataset to Assign Dates
	#APPEND	(loutput	,%'dDateOut'% + ' := ' + %'dDateMacroOut_full'% + ';\n')
	
	#APPEND	(loutput	,%'dDateOut_dist'% + '		:= distribute	(' + %'dDateOut'% + '							,unique_id										);\n')
	#APPEND	(loutput	,%'dDateOut_sort'% + '		:= sort				(' + %'dDateOut_dist'% + '				,unique_id	,local);\n')
	#APPEND	(loutput	,%'pDataset_dist'% + ' 		:= sort(distribute	(' + %'dDataset'% + '							,' + %'lRidField'%	+ '									),' + %'lRidField'%	+ ',local);\n');
		 
	#APPEND(loutput		,%'layoutSeqFile'% + ' ' + %'tGetStandardizedDates'% + '(' + %'layoutSeqFile'% + ' l	,' + %'dDateOut_sort'% + ' r) :=\n');
	#APPEND(loutput		,'transform\n');

	#SET(lcounter					,1);
	
	#LOOP
		#IF(%lcounter% > %lcountsetDateFields%)
			#BREAK
		#END
		#APPEND(loutput	,'\tself.' + psetCleanedDateFields[%lcounter%] + '				:= if(r.Date_type = ' + %'lcounter'% + '	,r.clean_Date			,l.' + psetCleanedDateFields[%lcounter%]	+ 		'	);\n');
		#SET(lcounter	,%lcounter% + 1)
	#END
	#APPEND(loutput	,'	self 										:= l;\n');
	#APPEND(loutput	,'end;\n\n');
	
	#APPEND(loutput	,%'dAssignDates'% + '	:= denormalize(\n');
	#APPEND(loutput	,'\t ' + %'pDataset_dist'% + '\n');
	#APPEND(loutput	,'\t,' + %'dDateOut_sort'% + '\n');
	#APPEND(loutput	,'\t,left.' + %'lRidField'% + ' = right.unique_id \n');
	#APPEND(loutput	,'\t,' + %'tGetStandardizedDates'% + '(left,right)\n');
	#APPEND(loutput	,'\t,local)\n');
	#IF(pPersistname != '')
		#APPEND	(loutput	,' : persist(' + #TEXT(pPersistname) + ')')
	#END
	#APPEND	(loutput	,';\n')	
	#APPEND	(loutput	,%'dReformatOutput'% + ' := project(' + %'dAssignDates'% + ',' + %'layoutOrigFile'% + ');\n' )	
	
	#APPEND(loutput, %'moutput'% + ' := ' + %'dReformatOutput'% + ';\n');

	#SET(moutput	,%'loutput'% + ' return ' + %'moutput'% + ';\n')
	
	#if(pOutputEcl = true)
		return %'loutput'%;
	#ELSE
		%moutput%		
	#END
	
endmacro;