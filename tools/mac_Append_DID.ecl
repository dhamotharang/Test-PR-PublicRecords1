/* pMatchset - should be set of char1's indicating the indicatives in infile
								If no matchset is passed in, it will figure it out for you based on the fields you pass in.  Keep in mind, though,
								that it will only pick from the first four(address, dob, ssn, & phone).  If you need the specialized ones(the last four), override the default
								by passing in your own matchset.
	'A' = Address
	'D' = DOB
	'S' = ssn
	'P' = phone
	'Q' = Address match excluding the fuzzy logic.  Equivalent to setting use_fuzzy = false in previous versions.  Acts the same regardless of whether matchset contains 'A'.
	'4' = ssn4 matching (last 4 digits of ssn)
	'G' = age matching
	'Z' = zip code matching
*/
export mac_Append_DID(

	 pDataset																									// Input Dataset for Diding
	,pFnameField																							// First Name Field
	,pMnameField																							// Middle Name Field
	,pLnameField																							// Last Name Field
	,pSuffixField																							// Name Suffix Field
	,psetPrangeFields				= '[]'														// Set of Prim range fields, for two addresses, ['mailing_prim_range','physical_prim_range']
	,psetPnameFields				= '[]'														// Set of Prim name fields
	,psetZipFields					= '[]'														// Set of Zip fields
	,psetSrangeFields				= '[]'														// Set of Secondary Range Fields
	,psetStateFields				= '[]'														// Set of State Fields
	,psetPhoneFields				= '[]'														// Set of phone fields
	,pDIDField							= '\'did\''												// DID Field
	,pDID_ScoreField				= '\'did_score\''									// DID Score field
	,pRidField							= '\'rid\''												// Unique Id Field in input dataset.  If it doesn't exist, it will be created
	,pSsnField							= '\'\''													// SSN Field
	,pDobField							= '\'\''													// Date of Birth Field
	,pMatchset							= '[]'														// Matchset for Did macro.  If blank, will figure this out by what fields you pass in																		
	,pPersistname						= '\'\''													// set this if you would like to persist the output
	,pLowScoreThreshold			= '\'75\''												// low score threshold
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
	#uniquename(lcountsetPrangeFields   )
	#uniquename(lcountsetPnameFields	  ) 
	#uniquename(lcountsetZipFields		  )
	#uniquename(lcountsetSrangeFields   ) 
	#uniquename(lcountsetStateFields	  )
	#uniquename(lcountsetPhoneFields	  ) 
	#uniquename(lcountall						    )
	#uniquename(lcountallfields			    )
	#uniquename(lerror                  ) 
	#uniquename(lcounter			          )
	#uniquename(lPrangeField	          ) 
	#uniquename(lPnameField	            )
	#uniquename(lZipField		            ) 
	#uniquename(lSrangeField	          )
	#uniquename(lStateField	            ) 
	#uniquename(lPhoneField						  )
	#uniquename(dDataset                ) 
	#uniquename(layoutOrigFile          )
	#uniquename(layoutSeqFile           )
	#uniquename(DidSlimLayout          	) 
	#uniquename(tSlimFordiding         	)
	#uniquename(dSlimFordiding					)
	#uniquename(dDidFlexOut            	) 
	#uniquename(dDidFlexOut_Patched     ) 
	#uniquename(ddidOut                	)
	#uniquename(ddidOut_dist           	) 
	#uniquename(ddidOut_sort           	)
	#uniquename(ddidOut_dedup          	) 
	#uniquename(pDataset_dist           )
	#uniquename(tAssigndids            	) 
	#uniquename(dAssigndids		        	)
	#uniquename(lMatchset				        )
	#uniquename(lcomma					        )
	#uniquename(lRidField					      )
	#uniquename(lClosingParen			      )
	#uniquename(dDedupSlim				      )
	#uniquename(dDidFlexOut_full				)
	#uniquename(lSetOfAllFields					)
	#uniquename(lsetPrangeFields				)
	#uniquename(lsetPnameFields					)
	#uniquename(lsetZipFields						)
	#uniquename(lsetSrangeFields				)
	#uniquename(lsetStateFields					)
	#uniquename(lsetPhoneFields					)

	// if you want the ecl as a string, de-mangle the var names to make it readable
	#IF(pOutputEcl = true)
		#SET(dDataset						,'dDataset'						)
		#SET(layoutOrigFile			,'layoutOrigFile'			)
		#SET(layoutSeqFile			,'layoutSeqFile'			)
		#SET(DidSlimLayout			,'DidSlimLayout'			)
		#SET(tSlimFordiding			,'tSlimFordiding'			)
		#SET(dSlimFordiding			,'dSlimFordiding'			)
		#SET(dDidFlexOut				,'dDidFlexOut'				)
		#SET(ddidOut						,'ddidOut'						)
		#SET(ddidOut_dist				,'ddidOut_dist'				)
		#SET(ddidOut_sort				,'ddidOut_sort'				)
		#SET(ddidOut_dedup			,'ddidOut_dedup'			)
		#SET(pDataset_dist			,'pDataset_dist'			)
		#SET(tAssigndids				,'tAssigndids'				)
		#SET(dAssigndids				,'dAssigndids'				)
		#SET(dDedupSlim					,'dDedupSlim'					)
		#SET(dDidFlexOut_full		,'dDidFlexOut_full'		)
		#SET(dDidFlexOut_Patched,'dDidFlexOut_Patched')
	#END


	// -- Check if passed in RID field exists or not
	#IF(pRidField	!= '')
		tools.mac_GetFieldType(pDataset_MetaInfo		,pRidField,lRidFieldType	,true);
		#SET(lRidField	,pRidField)
		#IF(%'lRidFieldType'% = '') #ERROR('tools.mac_Append_did: ERROR-field doesn\'t exist, pRidField: ' + pRidField	 	) #END
	#ELSE
		#uniquename(lRidFieldType	      )
		#SET(lRidFieldType	,'unsigned8')
	#END
	
	// -- Count Sets 
	#SET(lcountsetPrangeFields		,count(psetPrangeFields	));
	#SET(lcountsetPnameFields			,count(psetPnameFields	));
	#SET(lcountsetZipFields				,count(psetZipFields		));
	#SET(lcountsetSrangeFields		,count(psetSrangeFields	));
	#SET(lcountsetStateFields			,count(psetStateFields	));
	#SET(lcountsetPhoneFields			,count(psetPhoneFields	));
	#IF(%lcountsetPhoneFields% = 0 or %lcountsetPrangeFields% = 0)
		#SET(lcountall								,1)
	#ELSE
		#SET(lcountall								,%lcountsetPhoneFields% * %lcountsetPrangeFields%)
	#END

	#SET(lsetPrangeFields	,#TEXT(psetPrangeFields	))
	#SET(lsetPnameFields	,#TEXT(psetPnameFields	))
	#SET(lsetZipFields		,#TEXT(psetZipFields		))
	#SET(lsetSrangeFields	,#TEXT(psetSrangeFields	))
	#SET(lsetStateFields	,#TEXT(psetStateFields	))
	#SET(lsetPhoneFields	,#TEXT(psetPhoneFields	))
	
	// -- Construct Matchset from Fields passed in only if matchset passed in is null.
	#IF(count(pMatchset) = 0)
		#SET(lMatchset	,'[')
		#SET(lcomma	,'')
		#IF(count(psetPrangeFields) != 0	)	#APPEND(lMatchset	,%'lcomma'% + '\'A\'') #SET(lcomma	,',') #END
		#IF(count(psetPhoneFields	) != 0	)	#APPEND(lMatchset	,%'lcomma'% + '\'P\'') #SET(lcomma	,',') #END
		#IF(pSsnField 							!= ''	)	#APPEND(lMatchset	,%'lcomma'% + '\'S\'') #SET(lcomma	,',') #END
		#IF(pDobField 							!= ''	)	#APPEND(lMatchset	,%'lcomma'% + '\'D\'') #SET(lcomma	,',') #END
		#APPEND(lMatchset	,']')
	#ELSE
		#SET(lMatchset	,trim(#TEXT(pMatchset),all))
	#END

	// -- Validate Parameters, give some feedback if they are wrong
	// -- Unfortunately can't add up all the incoming fields into a set, and then loop through that set to find ones that don't exist
	// -- have to go through each individually.  U can do a count on a constructed set, but can't access individual items i.e. %lsetall%[1]
	#IF(%lcountsetPrangeFields%	!= 0) tools.mac_DoFieldsExist(pDataset_MetaInfo	,%lsetPrangeFields%	,lsetFieldDontExist	,true);	#IF(count(%lsetFieldDontExist%) != 0) #ERROR('tools.mac_Append_did: ERROR-fields don\'t exist: ' + %'lsetFieldDontExist'%) #END #END
	#IF(%lcountsetPnameFields%	!= 0) tools.mac_DoFieldsExist(pDataset_MetaInfo	,%lsetPnameFields%	,lsetFieldDontExist	,true);	#IF(count(%lsetFieldDontExist%) != 0) #ERROR('tools.mac_Append_did: ERROR-fields don\'t exist: ' + %'lsetFieldDontExist'%) #END #END
	#IF(%lcountsetZipFields%		!= 0) tools.mac_DoFieldsExist(pDataset_MetaInfo	,%lsetZipFields%		,lsetFieldDontExist	,true);	#IF(count(%lsetFieldDontExist%) != 0) #ERROR('tools.mac_Append_did: ERROR-fields don\'t exist: ' + %'lsetFieldDontExist'%) #END #END
	#IF(%lcountsetSrangeFields%	!= 0) tools.mac_DoFieldsExist(pDataset_MetaInfo	,%lsetSrangeFields%	,lsetFieldDontExist	,true);	#IF(count(%lsetFieldDontExist%) != 0) #ERROR('tools.mac_Append_did: ERROR-fields don\'t exist: ' + %'lsetFieldDontExist'%) #END #END
	#IF(%lcountsetStateFields%	!= 0) tools.mac_DoFieldsExist(pDataset_MetaInfo	,%lsetStateFields%	,lsetFieldDontExist	,true);	#IF(count(%lsetFieldDontExist%) != 0) #ERROR('tools.mac_Append_did: ERROR-fields don\'t exist: ' + %'lsetFieldDontExist'%) #END #END
	#IF(%lcountsetPhoneFields%	!= 0) tools.mac_DoFieldsExist(pDataset_MetaInfo	,%lsetPhoneFields%	,lsetFieldDontExist	,true);	#IF(count(%lsetFieldDontExist%) != 0) #ERROR('tools.mac_Append_did: ERROR-fields don\'t exist: ' + %'lsetFieldDontExist'%) #END #END
	#IF(pDIDField				!= '')	tools.mac_GetFieldType(pDataset_MetaInfo	,pDIDField 				,lsetFieldDontExist	,true);	#IF(%'lsetFieldDontExist'% = '') #ERROR('tools.mac_Append_did: ERROR-fields don\'t exist: ' + pDIDField 			) #END #END
	#IF(pSsnField				!= '')	tools.mac_GetFieldType(pDataset_MetaInfo	,pSsnField				,lsetFieldDontExist	,true);	#IF(%'lsetFieldDontExist'% = '') #ERROR('tools.mac_Append_did: ERROR-fields don\'t exist: ' + pSsnField				) #END #END
	#IF(pDobField				!= '')	tools.mac_GetFieldType(pDataset_MetaInfo	,pDobField				,lsetFieldDontExist	,true);	#IF(%'lsetFieldDontExist'% = '') #ERROR('tools.mac_Append_did: ERROR-fields don\'t exist: ' + pDobField				) #END #END
	#IF(pDID_ScoreField	!= '')	tools.mac_GetFieldType(pDataset_MetaInfo	,pDID_ScoreField 	,lsetFieldDontExist	,true);	#IF(%'lsetFieldDontExist'% = '') #ERROR('tools.mac_Append_did: ERROR-fields don\'t exist: ' + pDID_ScoreField ) #END #END
	#IF(pFnameField			!= '')	tools.mac_GetFieldType(pDataset_MetaInfo	,pFnameField	 		,lsetFieldDontExist	,true);	#IF(%'lsetFieldDontExist'% = '') #ERROR('tools.mac_Append_did: ERROR-fields don\'t exist: ' + pFnameField	 		) #END #END
	#IF(pMnameField			!= '')	tools.mac_GetFieldType(pDataset_MetaInfo	,pMnameField	 		,lsetFieldDontExist	,true);	#IF(%'lsetFieldDontExist'% = '') #ERROR('tools.mac_Append_did: ERROR-fields don\'t exist: ' + pMnameField	 		) #END #END
	#IF(pLnameField			!= '')	tools.mac_GetFieldType(pDataset_MetaInfo	,pLnameField	 		,lsetFieldDontExist	,true);	#IF(%'lsetFieldDontExist'% = '') #ERROR('tools.mac_Append_did: ERROR-fields don\'t exist: ' + pLnameField	 		) #END #END
	#IF(pSuffixField		!= '')	tools.mac_GetFieldType(pDataset_MetaInfo	,pSuffixField	 		,lsetFieldDontExist	,true);	#IF(%'lsetFieldDontExist'% = '') #ERROR('tools.mac_Append_did: ERROR-fields don\'t exist: ' + pSuffixField	 	) #END #END

	#IF(('A' in %lMatchset%
			and not(%lcountsetPrangeFields% = %lcountsetPnameFields% 
					and %lcountsetPnameFields%	= %lcountsetZipFields% 
					and %lcountsetZipFields% 		= %lcountsetSrangeFields%
					and %lcountsetSrangeFields% = %lcountsetStateFields%	))
			or (%lcountsetPrangeFields% = 0 	and ('A' in %lMatchset% or 'Q' in %lMatchset%))
			or (%lcountsetZipFields%		= 0 	and 'Z' in %lMatchset%)
			or (%lcountsetPhoneFields%	= 0 	and 'P' in %lMatchset%)
		  or (pDobField								= '' 	and ('D' in %lMatchset% or 'G' in %lMatchset%))
		  or (pSsnField								= '' 	and ('S' in %lMatchset% or '4' in %lMatchset%))
			or pDIDField	= ''
			or (%lcountsetZipFields%	= 0 and %lcountsetPhoneFields% = 0 and pDobField = '' and pSsnField = '')
		)
		#IF('A' in %lMatchset% and %lcountsetPrangeFields% 	!= %lcountsetPnameFields%	) #ERROR	('Count of Prange Fields does not equal count of Pname fields. ') #END
		#IF('A' in %lMatchset% and %lcountsetPnameFields%		!= %lcountsetZipFields% 	) #ERROR	('Count of Pname Fields does not equal count of Zip fields. '		) #END
		#IF('A' in %lMatchset% and %lcountsetZipFields% 		!= %lcountsetSrangeFields%) #ERROR	('Count of Zip Fields does not equal count of Srange fields. '	) #END
		#IF('A' in %lMatchset% and %lcountsetSrangeFields% 	!= %lcountsetStateFields%	) #ERROR	('Count of sRange Fields does not equal count of State fields. ') #END

		#IF(%lcountsetPrangeFields% = 0 	and 'A' in %lMatchset%) #ERROR	('tools.mac_Append_DID: Specifying \'A\' in the matchset requires at least one valid address spread across the 5 address fields'	) #END
		#IF(%lcountsetPhoneFields%	= 0 	and 'P' in %lMatchset%) #ERROR	('tools.mac_Append_DID: Specifying \'P\' in the matchset requires at least one valid phone in the parameter psetPhoneFields'	) #END
		#IF(pDobField = ''	and 'D' in %lMatchset%) #ERROR	('tools.mac_Append_DID: Specifying \'D\' in the matchset requires a valid date of birth fieldname in the parameter pDobField'	) #END
		#IF(pSsnField = ''	and 'S' in %lMatchset%) #ERROR	('tools.mac_Append_DID: Specifying \'S\' in the matchset requires a valid SSN fieldname in the parameter pSsnField'						) #END
		#IF(pDIDField	= ''	) #ERROR	('tools.mac_Append_DID: Please specify a did fieldname in the parameter pDIDField.  It is currently blank. ') #END
		#IF(%lcountsetZipFields%	= 0 and %lcountsetPhoneFields% = 0 and pDobField = '' and pSsnField = ''	) #ERROR	('tools.mac_Append_DID: Please specify more fields for matching.  This macro can not match by name alone.') #END

	#END

	#SET(moutput										,'moutput'										)

	// -- Add RID field to dataset if it doesn't already exist
	#SET(ldataset			,trim(#TEXT(pDataset),all))
	#IF(pRidField	!= '')
		#SET		(loutput	,%'dDataset'% + ' := ' + %'ldataset'% + ';\n')
	#ELSE
		#SET		(loutput	,%'dDataset'% + ' := project(' + %'ldataset'% + '	,transform({recordof(' + %'ldataset'% + '), ' + %'lRidFieldType'% + ' ' + %'lRidField'% + '}, self.' + %'lRidField'% + ' := counter; self := left)) : global;\n')
	#END
	
	#APPEND	(loutput	,%'layoutOrigFile'% + '		:= recordof(' + %'ldataset'% + ');\n');
	#APPEND	(loutput	,%'layoutSeqFile'% + '		:= recordof(' + %'dDataset'% + ');\n');

	// -- Define Slim layout for passing into did macro
	#APPEND	(loutput	,%'DidSlimLayout'% + '	:=\nrecord\n' );
	#APPEND	(loutput	,'\t' + %'lRidFieldType'% + '		unique_id					;\n');
	#APPEND	(loutput	,'\tstring20 		fname							;\n');
	#APPEND	(loutput	,'\tstring20 		mname							;\n');
	#APPEND	(loutput	,'\tstring20 		lname							;\n');
	#APPEND	(loutput	,'\tstring5 		name_suffix				;\n');
	#APPEND	(loutput	,'\tstring10  	prim_range				;\n');
	#APPEND	(loutput	,'\tstring28		prim_name					;\n');
	#APPEND	(loutput	,'\tstring5			zip5							;\n');
	#APPEND	(loutput	,'\tstring8			sec_range					;\n');
	#APPEND	(loutput	,'\tstring2			state		 					;\n');
	#APPEND	(loutput	,'\tstring10		phone		  		    ;\n');
	#APPEND	(loutput	,'\tstring8			dob		  		    ;\n');
	#APPEND	(loutput	,'\tstring9			ssn					    ;\n');
	#APPEND	(loutput	,'\tunsigned6		did					:= 0;\n');
	#APPEND	(loutput	,'\tunsigned1		did_score		:= 0;\n');
	#APPEND	(loutput	,'\tend;\n');


	// -- Set defaults for counters, fields, etc
	#SET(lcounter					,1);
	#IF(%lcountsetPrangeFields% != 0)
		#SET(lPrangeField			,'choose(cnt	');
	#ELSE
		#SET(lPrangeField			,'\'\'');
	#END
	#SET(lPnameField			,%'lPrangeField'%);
	#SET(lZipField				,%'lPrangeField'%);
	#SET(lSrangeField			,%'lPrangeField'%);
	#SET(lStateField			,%'lPrangeField'%);
	#IF(%lcountsetPhoneFields% != 0)
		#SET(lPhoneField			,'choose(cnt	');
	#ELSE
		#SET(lPhoneField			,'\'\'');
	#END
	#SET(lClosingParen	,'');

	// -- set up multiple address, phone fields for transform
	#LOOP
		#IF(%lcounter% > %lcountall%)
			#BREAK
		#END
		#IF(%lcounter% = %lcountall%)	#SET(lClosingParen	,')') #END
		#IF(%lcountsetPrangeFields% != 0)
			#APPEND(lPrangeField		,',l.' + psetPrangeFields		[((%lcounter% -  1) % %lcountsetPrangeFields%) + 1] + %'lClosingParen'%);
			#APPEND(lPnameField			,',l.' + psetPnameFields		[((%lcounter% -  1) % %lcountsetPrangeFields%) + 1] + %'lClosingParen'%);
			#APPEND(lZipField				,',l.' + psetZipFields			[((%lcounter% -  1) % %lcountsetPrangeFields%) + 1] + %'lClosingParen'%);
			#APPEND(lSrangeField		,',l.' + psetSrangeFields		[((%lcounter% -  1) % %lcountsetPrangeFields%) + 1] + %'lClosingParen'%);
			#APPEND(lStateField			,',l.' + psetStateFields		[((%lcounter% -  1) % %lcountsetPrangeFields%) + 1] + %'lClosingParen'%);
		#END
		#IF(%lcountsetPhoneFields% != 0)
			#APPEND(lPhoneField			,',l.' + psetPhoneFields		[((%lcounter% -  1) / %lcountsetPrangeFields%) + 1] + %'lClosingParen'%);
		#END
		#SET(lcounter	,%lcounter% + 1)
	#END
	
	// -- normalize transform
	#APPEND	(loutput	,%'DidSlimLayout'%  + ' ' + %'tSlimFordiding'% + '(' + %'layoutSeqFile'% + ' l, unsigned4 cnt) :=\n')
	#APPEND	(loutput	,'transform\n')
	#APPEND	(loutput	,'\tself.unique_id		:= l.' + %'lRidField'% + '												;\n')
	#APPEND	(loutput	,'\tself.fname					:= l.' + pFnameField		+ '					;\n')
	#APPEND	(loutput	,'\tself.mname					:= l.' + pMnameField		+ '					;\n')
	#APPEND	(loutput	,'\tself.lname					:= l.' + pLnameField		+ '					;\n')
	#APPEND	(loutput	,'\tself.name_suffix		:= l.' + pSuffixField		+ '					;\n')
	#APPEND	(loutput	,'\tself.prim_range		:= ' + %'lPrangeField'% 	+ ';\n')
	#APPEND	(loutput	,'\tself.prim_name		:= ' + %'lPnameField'%	 	+ ';\n')
	#APPEND	(loutput	,'\tself.zip5					:= ' + %'lZipField'%		 	+ ';\n')
	#APPEND	(loutput	,'\tself.sec_range		:= ' + %'lSrangeField'% 	+ ';\n')
	#APPEND	(loutput	,'\tself.state				:= ' + %'lStateField'%	 	+ ';\n')
	#APPEND	(loutput	,'\tself.phone				:= ' + %'lPhoneField'%	 	+ ';\n')
	#APPEND	(loutput	,'\tself.did					:= 0																		;\n')
	#APPEND	(loutput	,'\tself.did_score		:= 0																		;\n')
	#IF(pSsnField = '')
		#APPEND	(loutput	,'\tself.ssn					:= \'\';\n')
	#ELSE
		#APPEND	(loutput	,'\tself.ssn					:= l.' +  pSsnField + ';\n')
	#END
	#IF(pDobField = '')
		#APPEND	(loutput	,'\tself.dob					:= \'\';\n')
	#ELSE
		#APPEND	(loutput	,'\tself.dob					:= l.' +  pDobField + ';\n')
	#END
	#APPEND	(loutput	,'end;\n')
	#APPEND	(loutput	,%'dSlimFordiding'% + ' := normalize(' + %'dDataset'% + ',' + %'lcountall'% + ',' + %'tSlimFordiding'%  + '(left,counter));\n')

	// -- Dedup records before macro call to reduce possible skewing, and improve speed
	#APPEND	(loutput	,%'dDedupSlim'% + '	:= dedup(dedup(' + %'dSlimFordiding'% + '	,except unique_id, did, did_score, local),except unique_id, did, did_score,all);\n')
	
	// -- call did macro
	#APPEND	(loutput	,'DID_Add.MAC_Match_Flex(\n')
	#APPEND	(loutput	,'\t ' + %'dDedupSlim'%	+ '\n' )					
	#APPEND	(loutput	,'\t,' + %'lMatchset'%   	+ '\n' )                      
	#APPEND	(loutput	,'\t,ssn        \n')	              
	#APPEND	(loutput	,'\t,dob           \n')                   
	#APPEND	(loutput	,'\t,fname			   \n')               
	#APPEND	(loutput	,'\t,mname			   \n')                   
	#APPEND	(loutput	,'\t,lname			   \n')                   
	#APPEND	(loutput	,'\t,name_suffix   \n')                   
	#APPEND	(loutput	,'\t,prim_range	   \n')                   
	#APPEND	(loutput	,'\t,prim_name		 \n')                   
	#APPEND	(loutput	,'\t,sec_range		 \n')							      
	#APPEND	(loutput	,'\t,zip5					 \n')							      
	#APPEND	(loutput	,'\t,state				 \n')							      
	#APPEND	(loutput	,'\t,phone				 \n')							      
	#APPEND	(loutput	,'\t,did        	 \n')							      
	#APPEND	(loutput	,'\t,' + %'DidSlimLayout'% + '\n')
	#IF(pDID_ScoreField	!= '')
		#APPEND	(loutput	,'\t,true    \n')                                                  
	#ELSE
		#APPEND	(loutput	,'\t,false    \n')                                                  
	#END
	#APPEND	(loutput	,'\t,did_score    \n')                     
	#APPEND	(loutput	,'\t,' + pLowScoreThreshold + ' \n')    
	#APPEND	(loutput	,'\t,' + %'dDidFlexOut'% + ' \n')    
	#APPEND	(loutput	,'\t);\n')  
	
	#APPEND	(loutput	,'Business_HeaderV2.macFix_Contact_DIDs(\n')
	#APPEND	(loutput	,'\t' + %'dDidFlexOut'% + ' \n')   
	#APPEND	(loutput	,'\t,did					\n')
	#APPEND	(loutput	,'\t,lname					\n')
	#IF(pDID_ScoreField	!= '')
		#APPEND	(loutput	,'\t,true    \n')                                                  
	#ELSE
		#APPEND	(loutput	,'\t,false    \n')                                                  
	#END
	#APPEND	(loutput	,'\t,did_score					\n')
	#IF(pSsnField	!= '')
		#APPEND	(loutput	,'\t,true    \n')                                                  
	#ELSE
		#APPEND	(loutput	,'\t,false    \n')                                                  
	#END
	#APPEND	(loutput	,'\t,true					\n')
	#APPEND	(loutput	,'\t,ssn					\n')
	#APPEND	(loutput	,'\t,' + %'dDidFlexOut_Patched'% + '					\n')
	#APPEND	(loutput	,');\n')


	// Join back to before dedup to paste dids onto full file(non deduped file)
	#APPEND	(loutput	,%'dDidFlexOut_full'% + ' := join(\n')
	#APPEND	(loutput	,'\t ' + %'dSlimFordiding'%	+ '\n')
	#APPEND	(loutput	,'\t,' + %'dDidFlexOut_Patched'% 		+ '(did != 0)\n')
	#APPEND	(loutput	,'\t,\t\tleft.fname				 = right.fname					\n')
	#APPEND	(loutput	,'\t and\t\tleft.mname				 = right.mname					\n')
	#APPEND	(loutput	,'\t and\t\tleft.lname				 = right.lname					\n')
	#APPEND	(loutput	,'\t and\t\tleft.name_suffix	 = right.name_suffix		\n')
	#APPEND	(loutput	,'\t and\t\tleft.prim_range	 = right.prim_range		\n')
	#APPEND	(loutput	,'\t and\t\tleft.prim_name		 = right.prim_name			\n')
	#APPEND	(loutput	,'\t and\t\tleft.zip5				 = right.zip5					\n')
	#APPEND	(loutput	,'\t and\t\tleft.sec_range		 = right.sec_range			\n')
	#APPEND	(loutput	,'\t and\t\tleft.state		 		 = right.state		 			\n')
	#APPEND	(loutput	,'\t and\tleft.phone		  	 = right.phone		  		\n')
	#APPEND	(loutput	,'\t and\tleft.dob		  		 = right.dob		  			\n')
	#APPEND	(loutput	,'\t and\tleft.ssn					 = right.ssn						\n')
	#APPEND	(loutput	,'\t,transform(\n')
	#APPEND	(loutput	,'\t\trecordof(' + %'dDidFlexOut_Patched'% + ')\n')
	#APPEND	(loutput	,'\t\t,self.did				:= right.did				;\n')
	#APPEND	(loutput	,'\t\t self.did_score	:= right.did_score	;\n')
	#APPEND	(loutput	,'\t\t self							:= left							;\n')
	#APPEND	(loutput	,'\t)\n')
	#APPEND	(loutput	,');\n')

	// -- Prep Datasets for join back to orig dataset to Assign dids
	#APPEND	(loutput	,%'ddidOut'% + ' := ' + %'dDidFlexOut_full'% + ';\n')
	
	#APPEND	(loutput	,%'ddidOut_dist'% + '		:= distribute	(' + %'ddidOut'% + '							,unique_id										);\n')
	#APPEND	(loutput	,%'ddidOut_sort'% + '		:= sort				(' + %'ddidOut_dist'% + '				,unique_id, -did_score	,local);\n')
	#APPEND	(loutput	,%'ddidOut_dedup'% + '		:= dedup			(' + %'ddidOut_sort'% + '				,unique_id							,local);\n')
	#APPEND	(loutput	,%'pDataset_dist'% + ' 		:= distribute	(' + %'dDataset'% + '							,' + %'lRidField'%	+ '									);\n')
		 
	#APPEND	(loutput	,%'layoutOrigFile'%  + ' ' + %'tAssigndids'% + '(' + %'layoutSeqFile'% + ' l, ' + %'DidSlimLayout'% + ' r) :=\n')
	#APPEND	(loutput	,'transform\n')
	#APPEND	(loutput	,'\tself.' + pDIDField			 + '				:= if(r.did 				<> 0, r.did				, 0);\n')
	#IF(pDID_ScoreField	!= '')
		#APPEND	(loutput	,'\tself.' + pDID_ScoreField + '	:= if(r.did_score	<> 0, r.did_score	, 0);\n')
	#END
	#APPEND	(loutput	,'\tself 						:= l;\n')
	#APPEND	(loutput	,'end;\n')
	
	// -- Join back to original dataset to assign dids
	#APPEND	(loutput	,%'dAssigndids'% + ' := join(\n')
	#APPEND	(loutput	,'\t ' + %'pDataset_dist'% + '\n')
	#APPEND	(loutput	,'\t,' + %'ddidOut_dedup'% + '\n')
	#APPEND	(loutput	,'\t,left.' + %'lRidField'% + ' = right.unique_id\n')
	#APPEND	(loutput	,'\t,' + %'tAssigndids'% + '(left, right)\n')
	#APPEND	(loutput	,'\t,left outer\n')
	#APPEND	(loutput	,'\t,local)\n')
	#IF(pPersistname != '')
		#APPEND	(loutput	,' : persist(' + #TEXT(pPersistname) + ')')
	#END
	#APPEND	(loutput	,';\n')	
	
	#APPEND(loutput, %'moutput'% + ' := ' + %'dAssigndids'% + ';\n');
	
	#SET(moutput	,%'loutput'% + ' return ' + %'moutput'% + ';\n')
	
	#if(pOutputEcl = true)
		return %'loutput'%;
	#ELSE
		%moutput%		
	#END

endmacro;