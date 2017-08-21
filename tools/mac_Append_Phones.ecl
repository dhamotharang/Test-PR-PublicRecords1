export mac_Append_Phones(

	 pDataset																									// Input Dataset for phoneing
	,psetRawPhoneFields			= '[]'														// Set of raw phone fields, i.e. ['phone1','phone2']
	,psetCleanedPhoneFields	= '[]'														// Set of cleaned phone fields, i.e. ['clean_phone1','clean_phone2']
	,pRidField							= '\'rid\''												// Unique Id Field in input dataset.  If it doesn't exist, it will be created
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
	#uniquename(lcountsetPhoneFields   )
	#uniquename(lcountsetPnameFields	  ) 
	#uniquename(lcountsetZipFields		  )
	#uniquename(lcountsetPhoneFields	  ) 
	#uniquename(lcountall						    )
	#uniquename(lcountallfields			    )
	#uniquename(lerror                  ) 
	#uniquename(lcounter			          )
	#uniquename(lPhoneField	          ) 
	#uniquename(lPnameField	            )
	#uniquename(lZipField		            ) 
	#uniquename(lPhoneField						  )
	#uniquename(dDataset                ) 
	#uniquename(layoutOrigFile          )
	#uniquename(layoutSeqFile           )
	#uniquename(phoneSlimLayout          ) 
	#uniquename(tSlimPrep         )
	#uniquename(dSlimForPhoneParse					)
	#uniquename(dPhoneMacroOut            ) 
	#uniquename(dphoneOut                )
	#uniquename(dphoneOut_dist           ) 
	#uniquename(dphoneOut_sort           )
	#uniquename(dphoneOut_dedup          ) 
	#uniquename(pDataset_dist           )
	#uniquename(tAssignPhones            ) 
	#uniquename(dAssignPhones		        )
	#uniquename(lMatchset				        )
	#uniquename(lcomma					        )
	#uniquename(lRidField					      )
	#uniquename(lClosingParen			      )
	#uniquename(dDedupSlim				      )
	#uniquename(dPhoneMacroOut_full				)
	#uniquename(lSetOfAllFields					)
	#uniquename(lsetRawPhoneFields				)
	#uniquename(lsetPnameFields					)
	#uniquename(lsetZipFields						)
	#uniquename(lsetRawPhoneFields					)
	#uniquename(lSourceisString					)
	#uniquename(lfeinfield							)
	#uniquename(lSourceDocidField				)
	#uniquename(lSourcePartyField				)
	#uniquename(tGetStandardizedPhones	)
	#uniquename(dprojout              	)

	// if you want the ecl as a string, de-mangle the var names to make it readable
	#IF(pOutputEcl = true)
		#SET(dDataset					,'dDataset'				)
		#SET(layoutOrigFile		,'layoutOrigFile'	)
		#SET(layoutSeqFile		,'layoutSeqFile'	)
		#SET(phoneSlimLayout		,'phoneSlimLayout'	)
		#SET(tSlimPrep		,'tSlimPrep')
		#SET(dSlimForPhoneParse		,'dSlimForPhoneParse')
		#SET(dPhoneMacroOut			,'dPhoneMacroOut'		)
		#SET(dphoneOut					,'dphoneOut'				)
		#SET(dphoneOut_dist			,'dphoneOut_dist'	)
		#SET(dphoneOut_sort			,'dphoneOut_sort'	)
		#SET(dphoneOut_dedup		,'dphoneOut_dedup'	)
		#SET(pDataset_dist		,'pDataset_dist'	)
		#SET(tAssignPhones			,'tAssignPhones'		)
		#SET(dAssignPhones			,'dAssignPhones'		)
		#SET(dDedupSlim				,'dDedupSlim'			)
		#SET(dPhoneMacroOut_full	,'dPhoneMacroOut_full'			)
		#SET(tGetStandardizedPhones	,'tGetStandardizedPhones'			)
		#SET(dprojout	,'dprojout'			)
	#END


	// -- Check if passed in RID field exists or not
	#IF(pRidField	!= '')
		tools.mac_GetFieldType(pDataset_MetaInfo		,pRidField,lRidFieldType	,true);
		#SET(lRidField	,pRidField)
		#IF(%'lRidFieldType'% = '') #ERROR('tools.mac_Append_Phones: ERROR-field doesn\'t exist, pRidField: ' + pRidField	 	) #END
	#ELSE
		#uniquename(lRidFieldType	      )
		#SET(lRidFieldType	,'unsigned8')
	#END

	#SET(moutput										,'moutput'										)
	
	// -- Count Sets 
	#SET(lcountsetPhoneFields		,count(psetRawPhoneFields	));

	#SET(lsetRawPhoneFields	,#TEXT(psetRawPhoneFields	))

	// -- Validate Parameters, give some feedback if they are wrong
	// -- Unfortunately can't add up all the incoming fields into a set, and then loop through that set to find ones that don't exist
	// -- have to go through each individually.  U can do a count on a constructed set, but can't access individual items i.e. %lsetall%[1]
	#IF(%lcountsetPhoneFields%	 = 0) #ERROR('tools.mac_Append_Phones: ERROR-No Phone fields specified in psetRawPhoneFields parameter') #END
//	#IF(%lcountsetPhoneFields%	!= 0) tools.mac_DoFieldsExist(pDataset_MetaInfo	,%lsetRawPhoneFields%	,lsetFieldDontExist	,true);	#IF(count(%lsetFieldDontExist%) != 0) #ERROR('tools.mac_Append_Phones: ERROR-fields don\'t exist: ' + %'lsetFieldDontExist'%) #END #END
	
	// -- Add RID field to dataset if it doesn't already exist
	#SET(ldataset			,trim(#TEXT(pDataset),all))
	#IF(pRidField	!= '')
		#SET		(loutput	,%'dDataset'% + ' := ' + %'ldataset'% + ';\n')
	#ELSE
		#SET		(loutput	,%'dDataset'% + ' := project(' + %'ldataset'% + '	,transform({recordof(' + %'ldataset'% + '), ' + %'lRidFieldType'% + ' ' + %'lRidField'% + '}, self.' + %'lRidField'% + ' := counter; self := left)) : global;\n')
	#END
	
	#APPEND	(loutput	,%'layoutOrigFile'% + '		:= recordof(' + %'ldataset'% + ');\n');
	#APPEND	(loutput	,%'layoutSeqFile'% + '		:= recordof(' + %'dDataset'% + ');\n');

	// -- Define Slim layout for passing into phone macro
	#APPEND	(loutput	,%'phoneSlimLayout'% + '	:=\nrecord\n' );
	#APPEND	(loutput	,'\t' + %'lRidFieldType'% + '		unique_id					;\n');
	#APPEND	(loutput	,'\tstring orig_phone				:= \'\';\n');
	#APPEND	(loutput	,'\tstring10 clean_phone				:= \'\';\n');
	#APPEND	(loutput	,'\tunsigned4 phone_type				:= 0;\n');
	#APPEND	(loutput	,'\tend;\n');


	// -- Set defaults for counters, fields, etc
	#SET(lcounter					,1);
	#IF(%lcountsetPhoneFields% != 0)
		#SET(lPhoneField			,'choose(cnt	');
	#ELSE
		#SET(lPhoneField			,'\'\'');
	#END
	#SET(lClosingParen	,'');

	// -- set up multiple phone fields for transform
	#LOOP
		#IF(%lcounter% > %lcountsetPhoneFields%)
			#BREAK
		#END
		#IF(%lcounter% = %lcountsetPhoneFields%)	#SET(lClosingParen	,')') #END
		#IF(%lcountsetPhoneFields% != 0)
			#APPEND(lPhoneField		,',l.' + psetRawPhoneFields		[%lcounter%] + %'lClosingParen'%);
		#END
		#SET(lcounter	,%lcounter% + 1)
	#END
	
	// -- normalize transform
	#APPEND	(loutput	,%'phoneSlimLayout'%  + ' ' + %'tSlimPrep'% + '(' + %'layoutSeqFile'% + ' l, unsigned4 cnt) :=\n')
	#APPEND	(loutput	,'transform\n')
	#APPEND	(loutput	,'\tself.unique_id		:= l.' + %'lRidField'% + '												;\n')
	#APPEND	(loutput	,'\tself.orig_phone		:= ' + %'lPhoneField'%	 	+ ';\n')
	#APPEND	(loutput	,'\tself.phone_type		:= cnt;\n')
	#APPEND	(loutput	,'end;\n')
	#APPEND	(loutput	,%'dSlimForPhoneParse'% + ' := normalize(' + %'dDataset'% + ',' + %'lcountsetPhoneFields'% + ',' + %'tSlimPrep'%  + '(left,counter));\n')

	// -- Dedup records before macro call to reduce possible skewing, and improve speed
	#APPEND	(loutput	,%'dDedupSlim'% + '	:= dedup(dedup(' + %'dSlimForPhoneParse'% + '	,except unique_id, local),except unique_id, all);\n')
	
	// -- call Phone Parse macro
	#APPEND	(loutput	,'tools.mac_AppendCleanPhone(\n')
	#APPEND	(loutput	,'\t ' + %'dDedupSlim'%	+ '\n' )					
	#APPEND	(loutput	,'\t,orig_phone				   \n')                   
	#APPEND	(loutput	,'\t,' + %'dPhoneMacroOut'% + '\n')	              
	#APPEND	(loutput	,'\t,clean_phone				   \n')                   
	#APPEND	(loutput	,'\t,string10				   \n')                   
	#APPEND	(loutput	,'\t,true				   \n')                   
	#APPEND	(loutput	,'\t);\n')   

	// Join back to before dedup to paste Phones onto full file(non deduped file)
	#APPEND	(loutput	,%'dPhoneMacroOut_full'% + ' := join(\n')
	#APPEND	(loutput	,'\t ' + %'dSlimForPhoneParse'%	+ '(trim(orig_phone) != \'\')\n')
	#APPEND	(loutput	,'\t,' + %'dPhoneMacroOut'% 		+ '((unsigned)clean_phone != 0)\n')
	#APPEND	(loutput	,'\t,\t\tleft.orig_phone	 	= right.orig_phone		\n')
	#APPEND	(loutput	,'\t,transform(\n')
	#APPEND	(loutput	,'\t\trecordof(' + %'dPhoneMacroOut'% + ')\n')
	#APPEND	(loutput	,'\t\t,self.clean_phone		:= right.clean_phone				;\n')
	#APPEND	(loutput	,'\t\t self							:= left							;\n')
	#APPEND	(loutput	,'\t)\n')
	#APPEND	(loutput	,');\n')

	// -- Prep Datasets for join back to orig dataset to Assign Phones
	#APPEND	(loutput	,%'dphoneOut'% + ' := ' + %'dPhoneMacroOut_full'% + ';\n')
	
	#APPEND	(loutput	,%'dphoneOut_dist'% + '		:= distribute	(' + %'dphoneOut'% + '							,unique_id										);\n')
	#APPEND	(loutput	,%'dphoneOut_sort'% + '		:= sort				(' + %'dphoneOut_dist'% + '				,unique_id	,local);\n')
	#APPEND	(loutput	,%'pDataset_dist'% + ' 		:= sort(distribute	(' + %'dDataset'% + '							,' + %'lRidField'%	+ '									),' + %'lRidField'%	+ ',local);\n');
		 
	#APPEND(loutput		,%'layoutSeqFile'% + ' ' + %'tGetStandardizedPhones'% + '(' + %'layoutSeqFile'% + ' l	,' + %'dphoneOut_sort'% + ' r) :=\n');
	#APPEND(loutput		,'transform\n');

	#SET(lcounter					,1);
	
	#LOOP
		#IF(%lcounter% > %lcountsetPhoneFields%)
			#BREAK
		#END
		#APPEND(loutput	,'\tself.' + psetCleanedPhoneFields[%lcounter%] + '				:= if(r.phone_type = ' + %'lcounter'% + '	,r.clean_phone			,l.' + psetCleanedPhoneFields[%lcounter%]	+ 		'	);\n');
		#SET(lcounter	,%lcounter% + 1)
	#END
	#APPEND(loutput	,'	self 										:= l;\n');
	#APPEND(loutput	,'end;\n\n');
	
	#APPEND(loutput	,%'dAssignPhones'% + '	:= denormalize(\n');
	#APPEND(loutput	,'\t ' + %'pDataset_dist'% + '\n');
	#APPEND(loutput	,'\t,' + %'dphoneOut_sort'% + '\n');
	#APPEND(loutput	,'\t,left.' + %'lRidField'% + ' = right.unique_id \n');
	#APPEND(loutput	,'\t,' + %'tGetStandardizedPhones'% + '(left,right)\n');
	#APPEND(loutput	,'\t,local);\n');
	#APPEND(loutput	,%'dprojout'% + ' := project(' + %'dAssignPhones'% + ',transform(' + %'layoutOrigFile'% + ',self := left))\n')
	#IF(pPersistname != '')
		#APPEND	(loutput	,' : persist(' + #TEXT(pPersistname) + ')')
	#END
	#APPEND	(loutput	,';\n')	
	
	#APPEND(loutput, %'moutput'% + ' := ' + %'dprojout'% + ';\n');

	#SET(moutput	,%'loutput'% + ' return ' + %'moutput'% + ';\n')
	
	#if(pOutputEcl = true)
		return %'loutput'%;
	#ELSE
		%moutput%		
	#END
	
endmacro;