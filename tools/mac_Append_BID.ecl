export mac_Append_BID(

	 pDataset																									// Input Dataset for biding
	,pOutput																									// Output name
	,pCompanyNameField																				// Company Name Field
	,psetPrangeFields				= '[]'														// Set of Prim range fields, for two addresses, ['mailing_prim_range','physical_prim_range']
	,psetPnameFields				= '[]'														// Set of Prim name fields
	,psetZipFields					= '[]'														// Set of Zip fields
	,psetPhoneFields				= '[]'														// Set of phone fields
	,pSourceField						= '\'\''													// The field in which the source value is populated
	,pSourceDocidField			= '\'\''													// The field(s) in which the source_docid value is populated
	,pSourcePartyField			= '\'\''													// The field(s) in which the source_party value is populated
	,pRidField							= '\'rid\''												// Unique Id Field in input dataset.  If it doesn't exist, it will be created
	,pBidField							= '\'bid\''												// bid Field
	,pFeinField							= '\'\''													// Fein Field
	,pBidScoreField					= '\'bid_score\''									// bid score field
	,pPersistname						= '\'\''													// set this if you would like to persist the output
	,pOutputEcl							= 'false'													// Should output the ecl as a string(for testing) or actually run the ecl
	,pShouldExport					= 'true'													// should export output parameter(so can access outside of a module)															

) :=
macro
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
	#uniquename(lcountsetPhoneFields	  ) 
	#uniquename(lcountall						    )
	#uniquename(lcountallfields			    )
	#uniquename(lerror                  ) 
	#uniquename(lcounter			          )
	#uniquename(lPrangeField	          ) 
	#uniquename(lPnameField	            )
	#uniquename(lZipField		            ) 
	#uniquename(lPhoneField						  )
	#uniquename(dDataset                ) 
	#uniquename(layoutOrigFile          )
	#uniquename(layoutSeqFile           )
	#uniquename(bidSlimLayout          ) 
	#uniquename(tSlimForbiding         )
	#uniquename(dSlimForbiding					)
	#uniquename(dbidFlexOut            ) 
	#uniquename(dbidOut                )
	#uniquename(dbidOut_dist           ) 
	#uniquename(dbidOut_sort           )
	#uniquename(dbidOut_dedup          ) 
	#uniquename(pDataset_dist           )
	#uniquename(tAssignbids            ) 
	#uniquename(dAssignbids		        )
	#uniquename(lMatchset				        )
	#uniquename(lcomma					        )
	#uniquename(lRidField					      )
	#uniquename(lClosingParen			      )
	#uniquename(dDedupSlim				      )
	#uniquename(dbidFlexOut_full				)
	#uniquename(lSetOfAllFields					)
	#uniquename(lsetPrangeFields				)
	#uniquename(lsetPnameFields					)
	#uniquename(lsetZipFields						)
	#uniquename(lsetPhoneFields					)
	#uniquename(lSourceisString					)
	#uniquename(lfeinfield							)
	#uniquename(lSourceDocidField				)
	#uniquename(lSourcePartyField				)

	// if you want the ecl as a string, de-mangle the var names to make it readable
	#IF(pOutputEcl = true)
		#SET(dDataset					,'dDataset'				)
		#SET(layoutOrigFile		,'layoutOrigFile'	)
		#SET(layoutSeqFile		,'layoutSeqFile'	)
		#SET(bidSlimLayout		,'bidSlimLayout'	)
		#SET(tSlimForbiding		,'tSlimForbiding')
		#SET(dSlimForbiding		,'dSlimForbiding')
		#SET(dbidFlexOut			,'dbidFlexOut'		)
		#SET(dbidOut					,'dbidOut'				)
		#SET(dbidOut_dist			,'dbidOut_dist'	)
		#SET(dbidOut_sort			,'dbidOut_sort'	)
		#SET(dbidOut_dedup		,'dbidOut_dedup'	)
		#SET(pDataset_dist		,'pDataset_dist'	)
		#SET(tAssignbids			,'tAssignbids'		)
		#SET(dAssignbids			,'dAssignbids'		)
		#SET(dDedupSlim				,'dDedupSlim'			)
		#SET(dbidFlexOut_full	,'dbidFlexOut_full'			)
	#END


	// -- Check if passed in RID field exists or not
	#IF(pRidField	!= '')
		tools.mac_GetFieldType(pDataset_MetaInfo		,pRidField,lRidFieldType	,true);
		#SET(lRidField	,pRidField)
		#IF(%'lRidFieldType'% = '') #ERROR('tools.mac_Append_bid: ERROR-field doesn\'t exist, pRidField: ' + pRidField	 	) #END
	#ELSE
		#uniquename(lRidFieldType	      )
		#SET(lRidFieldType	,'unsigned8')
	#END
	
	// -- Count Sets 
	#SET(lcountsetPrangeFields		,count(psetPrangeFields	));
	#SET(lcountsetPnameFields			,count(psetPnameFields	));
	#SET(lcountsetZipFields				,count(psetZipFields		));
	#SET(lcountsetPhoneFields			,count(psetPhoneFields	));
	#IF(%lcountsetPhoneFields% = 0 or %lcountsetPrangeFields% = 0)
		#SET(lcountall								,1)
	#ELSE
		#SET(lcountall								,%lcountsetPhoneFields% * %lcountsetPrangeFields%)
	#END

	#SET(lsetPrangeFields	,#TEXT(psetPrangeFields	))
	#SET(lsetPnameFields	,#TEXT(psetPnameFields	))
	#SET(lsetZipFields		,#TEXT(psetZipFields		))
	#SET(lsetPhoneFields	,#TEXT(psetPhoneFields	))
	#SET(lSourceisString	,false)
	// -- Validate Parameters, give some feedback if they are wrong
	// -- Unfortunately can't add up all the incoming fields into a set, and then loop through that set to find ones that don't exist
	// -- have to go through each individually.  U can do a count on a constructed set, but can't access individual items i.e. %lsetall%[1]
	#IF(%lcountsetPrangeFields%	!= 0) tools.mac_DoFieldsExist(pDataset_MetaInfo	,%lsetPrangeFields%	,lsetFieldDontExist	,true);	#IF(count(%lsetFieldDontExist%) != 0) #ERROR('tools.mac_Append_bid: ERROR-fields don\'t exist: ' + %'lsetFieldDontExist'%) #END #END
	#IF(%lcountsetPnameFields%	!= 0) tools.mac_DoFieldsExist(pDataset_MetaInfo	,%lsetPnameFields%	,lsetFieldDontExist	,true);	#IF(count(%lsetFieldDontExist%) != 0) #ERROR('tools.mac_Append_bid: ERROR-fields don\'t exist: ' + %'lsetFieldDontExist'%) #END #END
	#IF(%lcountsetZipFields%		!= 0) tools.mac_DoFieldsExist(pDataset_MetaInfo	,%lsetZipFields%		,lsetFieldDontExist	,true);	#IF(count(%lsetFieldDontExist%) != 0) #ERROR('tools.mac_Append_bid: ERROR-fields don\'t exist: ' + %'lsetFieldDontExist'%) #END #END
	#IF(%lcountsetPhoneFields%	!= 0) tools.mac_DoFieldsExist(pDataset_MetaInfo	,%lsetPhoneFields%	,lsetFieldDontExist	,true);	#IF(count(%lsetFieldDontExist%) != 0) #ERROR('tools.mac_Append_bid: ERROR-fields don\'t exist: ' + %'lsetFieldDontExist'%) #END #END
	#IF(pBidField				!= '')	tools.mac_GetFieldType(pDataset_MetaInfo	,pBidField 				,lsetFieldDontExist	,true);	#IF(%'lsetFieldDontExist'% = '') #ERROR('tools.mac_Append_bid: ERROR-fields don\'t exist: ' + pBidField 			) #END #END
	#IF(pFeinField				!= '')	tools.mac_GetFieldType(pDataset_MetaInfo	,pFeinField					,lsetFieldDontExist	,true);	#IF(%'lsetFieldDontExist'% = '') #ERROR('tools.mac_Append_bid: ERROR-fields don\'t exist: ' + pFeinField				) #END #END
	#IF(pCompanyNameField	!= '')	tools.mac_GetFieldType(pDataset_MetaInfo	,pCompanyNameField	,lsetFieldDontExist	,true);	#IF(%'lsetFieldDontExist'% = '') #ERROR('tools.mac_Append_bid: ERROR-fields don\'t exist: ' + pCompanyNameField) #END #END
	#IF(pBidScoreField		!= '')	tools.mac_GetFieldType(pDataset_MetaInfo	,pBidScoreField 		,lsetFieldDontExist	,true);	#IF(%'lsetFieldDontExist'% = '') #ERROR('tools.mac_Append_bid: ERROR-fields don\'t exist: ' + pBidScoreField 	) #END #END
	#IF(pSourceField			!= '')	tools.mac_GetFieldType(pDataset_MetaInfo	,pSourceField			 	,lsetFieldDontExist	,true);	#IF(%'lsetFieldDontExist'% = '') #SET(lSourceisString	,true) #END #END
	#IF(pSourceDocidField	!= '')	tools.mac_GetFieldType(pDataset_MetaInfo	,pSourceDocidField 	,lsetFieldDontExist	,true);	#IF(%'lsetFieldDontExist'% = '') #ERROR('tools.mac_Append_bid: ERROR-fields don\'t exist: ' + pSourceDocidField 	) #END #END
//	#IF(pSourcePartyField	!= '')	tools.mac_GetFieldType(pDataset_MetaInfo	,pSourcePartyField 	,lsetFieldDontExist	,true);	#IF(%'lsetFieldDontExist'% = '') #ERROR('tools.mac_Append_bid: ERROR-fields don\'t exist: ' + pSourcePartyField 	) #END #END

	#IF(not(		%lcountsetPrangeFields% = %lcountsetPnameFields% 
					and %lcountsetPnameFields%	= %lcountsetZipFields% 
					)
		  or pCompanyNameField	= ''
			or pBidField					= ''
			or (		pFeinField							= ''			
					and %lcountsetPhoneFields%	= 0
					and %lcountsetPrangeFields%	= 0
			)
		)
		#IF(%lcountsetPrangeFields% != %lcountsetPnameFields%	) #ERROR('Count of Prange Fields does not equal count of Pname fields. ') #END
		#IF(%lcountsetPnameFields%	!= %lcountsetZipFields% 	) #ERROR('Count of Pname Fields does not equal count of Zip fields. '		) #END

		#IF(pCompanyNameField = ''	) #ERROR('Please specify a companyname in the parameter pCompanyNameField.  It is currently blank. ') #END
		#IF(pBidField				= ''	) #ERROR('Please specify a bid fieldname in the parameter pBidField.  It is currently blank. ') #END
		#IF(pFeinField = '' and %lcountsetPhoneFields%	= 0 and %lcountsetPrangeFields%	= 0) 
			#ERROR('Company name is the only field specified for the match.  This macro does not do company name only matching. ')
		#END
	#END
	
	#IF(pfeinfield				!= '') #SET(lfeinfield				,pFeinfield				)	#ELSE	#SET(lfeinfield					,'\'\'') #END
	#IF(pSourceDocidField	!= '') #SET(lSourceDocidField	,pSourceDocidField)	#ELSE	#SET(lSourceDocidField	,'\'\'') #END
	#IF(pSourcePartyField	!= '') #SET(lSourcePartyField	,pSourcePartyField)	#ELSE	#SET(lSourcePartyField	,'\'\'') #END

	// -- Add RID field to dataset if it doesn't already exist
	#SET(ldataset			,trim(#TEXT(pDataset),all))
	#IF(%'lRidFieldType'%	!= '')
		#SET		(loutput	,%'dDataset'% + ' := ' + %'ldataset'% + ';\n')
	#ELSE
		#SET		(loutput	,%'dDataset'% + ' := project(' + %'ldataset'% + '	,transform({recordof(' + %'ldataset'% + '), ' + %'lRidFieldType'% + ' ' + %'lRidField'% + '}, self.' + %'lRidField'% + ' := counter; self := left)) : global;\n')
	#END
	
	#APPEND	(loutput	,%'layoutOrigFile'% + '		:= recordof(' + %'ldataset'% + ');\n');
	#APPEND	(loutput	,%'layoutSeqFile'% + '		:= recordof(' + %'dDataset'% + ');\n');

	#if(pShouldExport = true)
		#SET(moutput	,'export ' + trim(#TEXT(pOutput),all))
	#ELSE
		#SET(moutput	,trim(#TEXT(pOutput),all))
	#END


	// -- Define Slim layout for passing into bid macro
	#APPEND	(loutput	,%'bidSlimLayout'% + '	:=\nrecord\n' );
	#APPEND	(loutput	,'\t' + %'lRidFieldType'% + '		unique_id					;\n');
	#APPEND	(loutput	,'\tTopBusiness_External.Layouts.Source.source;\n');
	#APPEND	(loutput	,'\tTopBusiness_External.Layouts.Source.source_docid;\n');
	#APPEND	(loutput	,'\tTopBusiness_External.Layouts.Source.source_party;\n');
	#APPEND	(loutput	,'\tTopBusiness_External.Layouts.Address.company_name;\n');
	#APPEND	(loutput	,'\tTopBusiness_External.Layouts.Address.zip;\n');
	#APPEND	(loutput	,'\tTopBusiness_External.Layouts.Address.prim_name;\n');
	#APPEND	(loutput	,'\tTopBusiness_External.Layouts.Address.prim_range;\n');
	#APPEND	(loutput	,'\tTopBusiness_External.Layouts.Address.fein;\n');
	#APPEND	(loutput	,'\tTopBusiness_External.Layouts.Address.phone;				\n');
	#APPEND	(loutput	,'\tunsigned6		bid					:= 0;\n');
	#APPEND	(loutput	,'\tunsigned1		bid_score		:= 0;\n');
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
		#END
		#IF(%lcountsetPhoneFields% != 0)
			#APPEND(lPhoneField			,',l.' + psetPhoneFields		[((%lcounter% -  1) / %lcountsetPrangeFields%) + 1] + %'lClosingParen'%);
		#END
		#SET(lcounter	,%lcounter% + 1)
	#END
	
	// -- normalize transform
	#APPEND	(loutput	,%'bidSlimLayout'%  + ' ' + %'tSlimForbiding'% + '(' + %'layoutSeqFile'% + ' l, unsigned4 cnt) :=\n')
	#APPEND	(loutput	,'transform\n')
	#APPEND	(loutput	,'\tself.unique_id		:= l.' + %'lRidField'% + '												;\n')
	#APPEND	(loutput	,'\tself.company_name	:= l.' + pCompanyNameField	+ '					;\n')
	#APPEND	(loutput	,'\tself.prim_range		:= ' + %'lPrangeField'% 	+ ';\n')
	#APPEND	(loutput	,'\tself.prim_name		:= ' + %'lPnameField'%	 	+ ';\n')
	#APPEND	(loutput	,'\tself.zip					:= ' + %'lZipField'%		 	+ ';\n')
	#APPEND	(loutput	,'\tself.phone				:= ' + %'lPhoneField'%	 	+ ';\n')
	#IF(%lSourceisString%	= true)
		#APPEND	(loutput	,'\tself.source				:= evaluate(l,\'' + pSourceField			 	+ '\');\n')
	#ELSE
		#APPEND	(loutput	,'\tself.source				:= evaluate(l,' + pSourceField			 	+ ');\n')
	#END
	#APPEND	(loutput	,'\tself.source_docid	:= evaluate(l,' + %'lSourceDocidField'%	+ ');\n')
	#APPEND	(loutput	,'\tself.source_party	:= evaluate(l,' + %'lSourcePartyField'%	+ ');\n')
	#APPEND	(loutput	,'\tself.fein					:= evaluate(l,' + %'lfeinfield'% + ');\n')
	#APPEND	(loutput	,'\tself.bid					:= 0																		;\n')
	#APPEND	(loutput	,'\tself.bid_score		:= 0																		;\n')
	#APPEND	(loutput	,'end;\n')
	#APPEND	(loutput	,%'dSlimForbiding'% + ' := normalize(' + %'dDataset'% + ',' + %'lcountall'% + ',' + %'tSlimForbiding'%  + '(left,counter));\n')

	// -- Dedup records before macro call to reduce possible skewing, and improve speed
	#APPEND	(loutput	,%'dDedupSlim'% + '	:= dedup(dedup(' + %'dSlimForbiding'% + '	,except unique_id, bid, bid_score, local),except unique_id, bid, bid_score,all);\n')
	
	// -- call bid macro
	#APPEND	(loutput	,'TopBusiness_External.MAC_External_BID(\n')
	#APPEND	(loutput	,'\t ' + %'dDedupSlim'%	+ '\n' )					
	#APPEND	(loutput	,'\t,' + %'dbidFlexOut'% + '\n')	              
	#APPEND	(loutput	,'\t,bid						 \n')							      
	#APPEND	(loutput	,'\t,bid_score    \n')                     
	#APPEND	(loutput	,'\t,source				 \n')                     
	#APPEND	(loutput	,'\t,source_docid	 \n')                     
	#APPEND	(loutput	,'\t,source_party	 \n')                     
	#APPEND	(loutput	,'\t,company_name\n')	              
	#APPEND	(loutput	,'\t,zip					   \n')                   
	#APPEND	(loutput	,'\t,prim_name		   \n')               
	#APPEND	(loutput	,'\t,prim_range		   \n')                   
	#APPEND	(loutput	,'\t,fein   				 \n')                   
	#APPEND	(loutput	,'\t,phone				   \n')                   
	#IF(pBidScoreField	!= '')
		#APPEND	(loutput	,'\t,true    \n')                                                  
	#ELSE
		#APPEND	(loutput	,'\t,false    \n')                                                  
	#END
	#APPEND	(loutput	,'\t);\n')   

	// Join back to before dedup to paste bids onto full file(non deduped file)
	#APPEND	(loutput	,%'dbidFlexOut_full'% + ' := join(\n')
	#APPEND	(loutput	,'\t ' + %'dSlimForbiding'%	+ '\n')
	#APPEND	(loutput	,'\t,' + %'dbidFlexOut'% 		+ '(bid != 0)\n')
	#APPEND	(loutput	,'\t,\t\tleft.company_name	 	= right.company_name		\n')
	#APPEND	(loutput	,'\tand\tleft.prim_range		 	= right.prim_range			\n')
	#APPEND	(loutput	,'\tand\tleft.prim_name		 		= right.prim_name			\n')
	#APPEND	(loutput	,'\tand\tleft.zip						 	= right.zip						\n')
	#APPEND	(loutput	,'\tand\tleft.phone				 		= right.phone					\n')
	#APPEND	(loutput	,'\tand\tleft.source				 	= right.source				 	\n')
	#APPEND	(loutput	,'\tand\tleft.source_docid	 	= right.source_docid	 	\n')
	#APPEND	(loutput	,'\tand\tleft.source_party	 	= right.source_party	 	\n')
	#APPEND	(loutput	,'\tand\tleft.fein				 		= right.fein						\n')
	#APPEND	(loutput	,'\t,transform(\n')
	#APPEND	(loutput	,'\t\trecordof(' + %'dbidFlexOut'% + ')\n')
	#APPEND	(loutput	,'\t\t,self.bid				:= right.bid				;\n')
	#APPEND	(loutput	,'\t\t self.bid_score	:= right.bid_score	;\n')
	#APPEND	(loutput	,'\t\t self							:= left							;\n')
	#APPEND	(loutput	,'\t)\n')
	#APPEND	(loutput	,');\n')

	// -- Prep Datasets for join back to orig dataset to Assign bids
	#APPEND	(loutput	,%'dbidOut'% + ' := ' + %'dbidFlexOut_full'% + ';\n')
	
	#APPEND	(loutput	,%'dbidOut_dist'% + '		:= distribute	(' + %'dbidOut'% + '							,unique_id										);\n')
	#APPEND	(loutput	,%'dbidOut_sort'% + '		:= sort				(' + %'dbidOut_dist'% + '				,unique_id, -bid_score	,local);\n')
	#APPEND	(loutput	,%'dbidOut_dedup'% + '		:= dedup			(' + %'dbidOut_sort'% + '				,unique_id							,local);\n')
	#APPEND	(loutput	,%'pDataset_dist'% + ' 		:= distribute	(' + %'dDataset'% + '							,' + %'lRidField'%	+ '									);\n')
		 
	#APPEND	(loutput	,%'layoutOrigFile'%  + ' ' + %'tAssignbids'% + '(' + %'layoutSeqFile'% + ' l, ' + %'bidSlimLayout'% + ' r) :=\n')
	#APPEND	(loutput	,'transform\n')
	#APPEND	(loutput	,'\tself.' + pBidField			 + '				:= if(r.bid 				<> 0, r.bid				, 0);\n')
	#IF(pBidScoreField	!= '')
		#APPEND	(loutput	,'\tself.' + pBidScoreField + '	:= if(r.bid_score	<> 0, r.bid_score	, 0);\n')
	#END
	#APPEND	(loutput	,'\tself 						:= l;\n')
	#APPEND	(loutput	,'end;\n')
	
	// -- Join back to original dataset to assign bids
	#APPEND	(loutput	,%'dAssignbids'% + ' := join(\n')
	#APPEND	(loutput	,'\t ' + %'pDataset_dist'% + '\n')
	#APPEND	(loutput	,'\t,' + %'dbidOut_dedup'% + '\n')
	#APPEND	(loutput	,'\t,left.' + %'lRidField'% + ' = right.unique_id\n')
	#APPEND	(loutput	,'\t,' + %'tAssignbids'% + '(left, right)\n')
	#APPEND	(loutput	,'\t,left outer\n')
	#APPEND	(loutput	,'\t,local)\n')
	#IF(pPersistname != '')
		#APPEND	(loutput	,' : persist(' + #TEXT(pPersistname) + ')')
	#END
	#APPEND	(loutput	,';\n')	
	
	#APPEND(loutput, %'moutput'% + ' := ' + %'dAssignbids'% + ';\n');
	
	#if(pOutputEcl = true)
		#if(pShouldExport = true)
			export pOutput := %'loutput'%;
		#ELSE
			pOutput := %'loutput'%;
		#END
	#ELSE
		%loutput%;
	#END
	
endmacro;