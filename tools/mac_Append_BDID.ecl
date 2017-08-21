import aid,bipv2;
// could add a source match parameter so it could do a source match first
export mac_Append_BDID(

	 pDataset																									        // Input Dataset for bdiding
	,pCompanyNameField																				        // Company Name Field
	,psetPrangeFields				= '[]'														        // Set of Prim range fields, for two addresses, ['mailing_prim_range','physical_prim_range']
	,psetPnameFields				= '[]'														        // Set of Prim name fields
	,psetZipFields					= '[]'														        // Set of Zip fields
	,psetSrangeFields				= '[]'														        // Set of Secondary Range Fields
	,psetStateFields				= '[]'														        // Set of State Fields
	,psetPhoneFields				= '[]'														        // Set of phone fields
	,pRidField							= '\'rid\''												        // Unique Id Field in input dataset.  If it doesn't exist, it will be created
	,pBdidField							= '\'bdid\''											        // Bdid Field
	,pFeinField							= '\'\''													        // Fein Field
	,pMatchset							= '[]'														        // Matchset for Bdid macro.  If blank, will figure this out by what fields you pass in																		
	,pBdidScoreField				= '\'bdid_score\''								        // Bdid score field
	,pPersistname						= '\'\''													        // set this if you would like to persist the output
	,pScoreThreshold				= '\'75\''												        // bdid score threshold
	,pFileVersion						= '\'prod\''											        // default to use prod version of superfiles
	,pUseOtherEnvironment		= tools._Constants.IsDataland			        // default is to hit prod from dataland, and on prod hit prod.
  ,pSetLinkingVersions    = 'BIPV2.IDconstants.xlink_versions_default'
  ,pURL										=	'\'\''
	,pEmail									=	'\'\''
	,psetCityFields				  = '[]'														        // Set of City Fields	
	,pContact_fname					= '\'\''
	,pContact_mname					= '\'\''
	,pContact_lname					= '\'\''
	,pContact_SSN					  = '\'\''
	,pSource      					= '\'\''
	,pSource_rec_id					= '\'\''
	,pOutputEcl							= 'false'													        // Should output the ecl as a string(for testing) or actually run the ecl
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
	#uniquename(lcountsetCityFields	    )
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
	#uniquename(lCityField	            )
	#uniquename(lPhoneField						  )
	#uniquename(dDataset                ) 
	#uniquename(layoutOrigFile          )
	#uniquename(layoutSeqFile           )
	#uniquename(bdidSlimLayout          ) 
	#uniquename(tSlimForBdiding         )
	#uniquename(dSlimForBdiding					)
	#uniquename(dBdidFlexOut            ) 
	#uniquename(dBDidOut                )
	#uniquename(dBDidOut_dist           ) 
	#uniquename(dBDidOut_sort           )
	#uniquename(dBDidOut_dedup          ) 
	#uniquename(pDataset_dist           )
	#uniquename(tAssignBdids            ) 
	#uniquename(dAssignBdids		        )
	#uniquename(lMatchset				        )
	#uniquename(lcomma					        )
	#uniquename(lRidField					      )
	#uniquename(lClosingParen			      )
	#uniquename(dDedupSlim				      )
	#uniquename(dBdidFlexOut_full				)
	#uniquename(lSetOfAllFields					)
	#uniquename(lsetPrangeFields				)
	#uniquename(lsetPnameFields					)
	#uniquename(lsetZipFields						)
	#uniquename(lsetSrangeFields				)
	#uniquename(lsetStateFields					)
	#uniquename(lsetCityFields					)
	#uniquename(lsetPhoneFields					)
	#uniquename(lproxidexists 					)
	#uniquename(lseleidexists 					)
	#uniquename(lidsexists 					    )
	#uniquename(lproxidtype 					)
	#uniquename(lseleidtype 					)
	#uniquename(lultidexists 					)
	#uniquename(lorgidexists 					)
	#uniquename(lempidexists 					)
	#uniquename(lpowidexists 					)
	#uniquename(ldotidexists 					)

	// if you want the ecl as a string, de-mangle the var names to make it readable
	#IF(pOutputEcl = true)
		#SET(dDataset					,'dDataset'				)
		#SET(layoutOrigFile		,'layoutOrigFile'	)
		#SET(layoutSeqFile		,'layoutSeqFile'	)
		#SET(bdidSlimLayout		,'bdidSlimLayout'	)
		#SET(tSlimForBdiding	,'tSlimForBdiding')
		#SET(dSlimForBdiding	,'dSlimForBdiding')
		#SET(dBdidFlexOut			,'dBdidFlexOut'		)
		#SET(dBDidOut					,'dBDidOut'				)
		#SET(dBDidOut_dist		,'dBDidOut_dist'	)
		#SET(dBDidOut_sort		,'dBDidOut_sort'	)
		#SET(dBDidOut_dedup		,'dBDidOut_dedup'	)
		#SET(pDataset_dist		,'pDataset_dist'	)
		#SET(tAssignBdids			,'tAssignBdids'		)
		#SET(dAssignBdids			,'dAssignBdids'		)
		#SET(dDedupSlim				,'dDedupSlim'			)
		#SET(dBdidFlexOut_full,'dBdidFlexOut_full'			)
	#END

	// -- Check if passed in RID field exists or not
	#IF(pRidField	!= '')
		tools.mac_GetFieldType(pDataset_MetaInfo		,pRidField,lRidFieldType	,true);
		#SET(lRidField	,pRidField)
		#IF(%'lRidFieldType'% = '') #ERROR('tools.mac_Append_BDID: ERROR-field doesn\'t exist, pRidField: ' + pRidField	 	) #END
	#ELSE
		#uniquename(lRidFieldType	      )
		#SET(lRidFieldType	,'unsigned8')
	#END
	
  tools.mac_DoFieldsExist(pDataset_MetaInfo	,['proxid','seleid','ultid','orgid','empid','powid','dotid'],lidsexists,true);
  #IF('proxid' not in %lidsexists% )  #SET(lproxidexists ,true) #ELSE #SET(lproxidexists  ,false) #END
	#IF('seleid' not in %lidsexists% )  #SET(lseleidexists ,true) #ELSE #SET(lseleidexists  ,false) #END
  #IF('ultid'  not in %lidsexists% )  #SET(lultidexists  ,true) #ELSE #SET(lultidexists   ,false) #END
  #IF('orgid'  not in %lidsexists% )  #SET(lorgidexists  ,true) #ELSE #SET(lorgidexists   ,false) #END
  #IF('empid'  not in %lidsexists% )  #SET(lempidexists  ,true) #ELSE #SET(lempidexists   ,false) #END
  #IF('powid'  not in %lidsexists% )  #SET(lpowidexists  ,true) #ELSE #SET(lpowidexists   ,false) #END
  #IF('dotid'  not in %lidsexists% )  #SET(ldotidexists  ,true) #ELSE #SET(ldotidexists   ,false) #END

	// -- Count Sets 
	#SET(lcountsetPrangeFields		,count(psetPrangeFields	));
	#SET(lcountsetPnameFields			,count(psetPnameFields	));
	#SET(lcountsetZipFields				,count(psetZipFields		));
	#SET(lcountsetSrangeFields		,count(psetSrangeFields	));
	#SET(lcountsetStateFields			,count(psetStateFields	));
	#SET(lcountsetCityFields			,count(psetCityFields	  ));
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
	#SET(lsetCityFields 	,#TEXT(psetCityFields	  ))
	#SET(lsetPhoneFields	,#TEXT(psetPhoneFields	))
	
	// -- Validate Parameters, give some feedback if they are wrong
	// -- Unfortunately can't add up all the incoming fields into a set, and then loop through that set to find ones that don't exist
	// -- have to go through each individually.  U can do a count on a constructed set, but can't access individual items i.e. %lsetall%[1]
	#IF(%lcountsetPrangeFields%	!= 0) tools.mac_DoFieldsExist(pDataset_MetaInfo	,%lsetPrangeFields%	,lsetFieldDontExist	,true);	#IF(count(%lsetFieldDontExist%) != 0) #ERROR('tools.mac_Append_BDID: ERROR-fields don\'t exist: ' + %'lsetFieldDontExist'%) #END #END
	#IF(%lcountsetPnameFields%	!= 0) tools.mac_DoFieldsExist(pDataset_MetaInfo	,%lsetPnameFields%	,lsetFieldDontExist	,true);	#IF(count(%lsetFieldDontExist%) != 0) #ERROR('tools.mac_Append_BDID: ERROR-fields don\'t exist: ' + %'lsetFieldDontExist'%) #END #END
	#IF(%lcountsetZipFields%		!= 0) tools.mac_DoFieldsExist(pDataset_MetaInfo	,%lsetZipFields%		,lsetFieldDontExist	,true);	#IF(count(%lsetFieldDontExist%) != 0) #ERROR('tools.mac_Append_BDID: ERROR-fields don\'t exist: ' + %'lsetFieldDontExist'%) #END #END
	#IF(%lcountsetSrangeFields%	!= 0) tools.mac_DoFieldsExist(pDataset_MetaInfo	,%lsetSrangeFields%	,lsetFieldDontExist	,true);	#IF(count(%lsetFieldDontExist%) != 0) #ERROR('tools.mac_Append_BDID: ERROR-fields don\'t exist: ' + %'lsetFieldDontExist'%) #END #END
	#IF(%lcountsetStateFields%	!= 0) tools.mac_DoFieldsExist(pDataset_MetaInfo	,%lsetStateFields%	,lsetFieldDontExist	,true);	#IF(count(%lsetFieldDontExist%) != 0) #ERROR('tools.mac_Append_BDID: ERROR-fields don\'t exist: ' + %'lsetFieldDontExist'%) #END #END
	#IF(%lcountsetCityFields%	  != 0) tools.mac_DoFieldsExist(pDataset_MetaInfo	,%lsetCityFields%	  ,lsetFieldDontExist	,true);	#IF(count(%lsetFieldDontExist%) != 0) #ERROR('tools.mac_Append_BDID: ERROR-fields don\'t exist: ' + %'lsetFieldDontExist'%) #END #END
	#IF(%lcountsetPhoneFields%	!= 0) tools.mac_DoFieldsExist(pDataset_MetaInfo	,%lsetPhoneFields%	,lsetFieldDontExist	,true);	#IF(count(%lsetFieldDontExist%) != 0) #ERROR('tools.mac_Append_BDID: ERROR-fields don\'t exist: ' + %'lsetFieldDontExist'%) #END #END
	#IF(pBdidField				!= '')	tools.mac_GetFieldType(pDataset_MetaInfo	,pBdidField 				,lsetFieldDontExist	,true);	#IF(%'lsetFieldDontExist'% = '') #ERROR('tools.mac_Append_BDID: ERROR-fields don\'t exist: ' + pBdidField 			) #END #END
	#IF(pFeinField				!= '')	tools.mac_GetFieldType(pDataset_MetaInfo	,pFeinField					,lsetFieldDontExist	,true);	#IF(%'lsetFieldDontExist'% = '') #ERROR('tools.mac_Append_BDID: ERROR-fields don\'t exist: ' + pFeinField				) #END #END
	#IF(pCompanyNameField	!= '')	tools.mac_GetFieldType(pDataset_MetaInfo	,pCompanyNameField	,lsetFieldDontExist	,true);	#IF(%'lsetFieldDontExist'% = '') #ERROR('tools.mac_Append_BDID: ERROR-fields don\'t exist: ' + pCompanyNameField) #END #END
	#IF(pBdidScoreField		!= '')	tools.mac_GetFieldType(pDataset_MetaInfo	,pBdidScoreField 		,lsetFieldDontExist	,true);	#IF(%'lsetFieldDontExist'% = '') #ERROR('tools.mac_Append_BDID: ERROR-fields don\'t exist: ' + pBdidScoreField 	) #END #END

	#IF(not(		%lcountsetPrangeFields% = %lcountsetPnameFields% 
					and %lcountsetPnameFields%	= %lcountsetZipFields% 
					and %lcountsetZipFields% 		= %lcountsetSrangeFields%
					and %lcountsetSrangeFields% = %lcountsetStateFields%	
					and %lcountsetStateFields%  = %lcountsetCityFields%	)
		  or pCompanyNameField	= ''
			or pBdidField					= ''
			or (		pFeinField							= ''			
					and %lcountsetPhoneFields%	= 0
					and %lcountsetPrangeFields%	= 0
					and 'N' not in pMatchset
			)
		)
		#SET(lerror	,'')
//		#IF(count(%lsetFieldDontExist%)	!= 0	) #ERROR('The following fields do not exist in the layout: ' + %'lsetFieldDontExist'%) #END
		#IF(%lcountsetPrangeFields% != %lcountsetPnameFields%	) #ERROR('Count of Prange Fields does not equal count of Pname fields. ') #END
		#IF(%lcountsetPnameFields%	!= %lcountsetZipFields% 	) #ERROR('Count of Pname Fields does not equal count of Zip fields. '		) #END
		#IF(%lcountsetZipFields% 		!= %lcountsetSrangeFields%) #ERROR('Count of Zip Fields does not equal count of Srange fields. '	) #END
		#IF(%lcountsetSrangeFields% != %lcountsetStateFields%	) #ERROR('Count of sRange Fields does not equal count of State fields. ') #END
		#IF(%lcountsetStateFields%  != %lcountsetCityFields%	) #ERROR('Count of State Fields does not equal count of City fields. ') #END
		
		#IF(pCompanyNameField = ''	) #ERROR('Please specify a companyname in the parameter pCompanyNameField.  It is currently blank. ') #END
		#IF(pBdidField				= ''	) #ERROR('Please specify a bdid fieldname in the parameter pBdidField.  It is currently blank. ') #END
		#IF(pFeinField = '' and %lcountsetPhoneFields%	= 0 and %lcountsetPrangeFields%	= 0 and 'N' not in pMatchset) 
			#ERROR('Company name is the only field specified for the match.  Please pass in an [\'N\'] into the pMatchset parameter to enable this type of Companyname only matching. ')
		#END
	#END

	// -- Add RID field to dataset if it doesn't already exist
	#SET(ldataset			,trim(#TEXT(pDataset),all))
	#IF(pRidField	!= '')
		#SET		(loutput	,%'dDataset'% + ' := ' + %'ldataset'% + ';\n')
	#ELSE
		#SET		(loutput	,%'dDataset'% + ' := project(' + %'ldataset'% + '	,transform({recordof(' + %'ldataset'% + '), ' + %'lRidFieldType'% + ' ' + %'lRidField'% + '}, self.' + %'lRidField'% + ' := counter; self := left)) : global;\n')
	#END
	
	#APPEND	(loutput	,%'layoutOrigFile'% + '		:= recordof(' + %'ldataset'% + ');\n');
	#APPEND	(loutput	,%'layoutSeqFile'% + '		:= recordof(' + %'dDataset'% + ');\n');

	#SET(moutput										,'moutput'										)

	// -- Construct Matchset from Fields passed in only if matchset passed in is null.
	#IF(count(pMatchset) = 0)
		#SET(lMatchset	,'[')
		#SET(lcomma	,'')
		#IF(count(psetPrangeFields) != 0	)	#APPEND(lMatchset	,%'lcomma'% + '\'A\'') #SET(lcomma	,',') #END
		#IF(count(psetPhoneFields	) != 0	)	#APPEND(lMatchset	,%'lcomma'% + '\'P\'') #SET(lcomma	,',') #END
		#IF(pFeinField 							!= ''	)	#APPEND(lMatchset	,%'lcomma'% + '\'F\'') #SET(lcomma	,',') #END
		#APPEND(lMatchset	,']')
	#ELSE
		#SET(lMatchset	,trim(#TEXT(pMatchset),all))
	#END

	// -- Define Slim layout for passing into Bdid macro
	#APPEND	(loutput	,%'bdidSlimLayout'% + '	:=\nrecord\n' );
	#APPEND	(loutput	,'\t' + %'lRidFieldType'% + '		unique_id					;\n');
	#APPEND	(loutput	,'\tstring100 	company_name			;\n');
	#APPEND	(loutput	,'\tstring10  	prim_range				;\n');
	#APPEND	(loutput	,'\tstring28		prim_name					;\n');
	#APPEND	(loutput	,'\tstring5			zip5							;\n');
	#APPEND	(loutput	,'\tstring8			sec_range					;\n');
	#APPEND	(loutput	,'\tstring2			state		 					;\n');
	#APPEND	(loutput	,'\tstring10		phone		  		    ;\n');
	#APPEND	(loutput	,'\tstring9			fein		  		    ;\n');
	#APPEND	(loutput	,'\tstring34		source_group	    ;\n');
	#APPEND	(loutput	,'\tunsigned6		bdid					:= 0;\n');
	#APPEND	(loutput	,'\tunsigned1		bdid_score		:= 0;\n');
	#APPEND	(loutput	,'\tstring50		URL					      ;\n');
	#APPEND	(loutput	,'\tstring50		Email				      ;\n');
	#APPEND	(loutput	,'\tstring25		City					    ;\n');
	#APPEND	(loutput	,'\tstring20		Contact_fname     ;\n');
	#APPEND	(loutput	,'\tstring20		Contact_mname     ;\n');
	#APPEND	(loutput	,'\tstring20		Contact_lname     ;\n');
	#APPEND	(loutput	,'\tstring9 		Contact_SSN       ;\n');
	#APPEND	(loutput	,'\tstring2 		Source            ;\n');
	#APPEND	(loutput	,'\tunsigned6		Source_rec_id     ;\n');
	#APPEND	(loutput	,'\tunsigned6		proxid				:= 0;\n');
	#APPEND	(loutput	,'\tunsigned2		proxweight		:= 0;\n');
	#APPEND	(loutput	,'\tunsigned2		proxscore 		:= 0;\n');
	#APPEND	(loutput	,'\tunsigned6		seleid				:= 0;\n');
	#APPEND	(loutput	,'\tunsigned2		seleweight		:= 0;\n');
	#APPEND	(loutput	,'\tunsigned2		selescore 		:= 0;\n');
	#APPEND	(loutput	,'\tunsigned6		empid					:= 0;\n');
	#APPEND	(loutput	,'\tunsigned2		empweight			:= 0;\n');
	#APPEND	(loutput	,'\tunsigned2		empscore 			:= 0;\n');
	#APPEND	(loutput	,'\tunsigned6		orgid					:= 0;\n');
	#APPEND	(loutput	,'\tunsigned2		orgweight			:= 0;\n');
	#APPEND	(loutput	,'\tunsigned2		orgscore 			:= 0;\n');
	#APPEND	(loutput	,'\tunsigned6		powid					:= 0;\n');
	#APPEND	(loutput	,'\tunsigned2		powweight			:= 0;\n');
	#APPEND	(loutput	,'\tunsigned2		powscore 			:= 0;\n');
	#APPEND	(loutput	,'\tunsigned6		ultid					:= 0;\n');
	#APPEND	(loutput	,'\tunsigned2		ultweight			:= 0;\n');
	#APPEND	(loutput	,'\tunsigned2		ultscore 			:= 0;\n');
	#APPEND	(loutput	,'\tunsigned6		dotid					:= 0;\n');
	#APPEND	(loutput	,'\tunsigned2		dotweight			:= 0;\n');
	#APPEND	(loutput	,'\tunsigned2		dotscore 			:= 0;\n');


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
	#SET(lCityField		  	,%'lPrangeField'%);
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
		  #APPEND(lCityField			,',l.' + psetCityFields	  	[((%lcounter% -  1) % %lcountsetPrangeFields%) + 1] + %'lClosingParen'%);		
		#END
		#IF(%lcountsetPhoneFields% != 0)
			#APPEND(lPhoneField			,',l.' + psetPhoneFields		[((%lcounter% -  1) / %lcountsetPrangeFields%) + 1] + %'lClosingParen'%);
		#END
		#SET(lcounter	,%lcounter% + 1)
	#END
	
	// -- normalize transform
	#APPEND	(loutput	,%'bdidSlimLayout'%  + ' ' + %'tSlimForBdiding'% + '(' + %'layoutSeqFile'% + ' l, unsigned4 cnt) :=\n')
	#APPEND	(loutput	,'transform\n')
	#APPEND	(loutput	,'\tself.unique_id		:= l.' + %'lRidField'% + '												;\n')
	#APPEND	(loutput	,'\tself.company_name	:= l.' + pCompanyNameField	+ '					;\n')
	#APPEND	(loutput	,'\tself.prim_range		:= ' + %'lPrangeField'% 	+ ';\n')
	#APPEND	(loutput	,'\tself.prim_name		:= ' + %'lPnameField'%	 	+ ';\n')
	#APPEND	(loutput	,'\tself.zip5					:= ' + %'lZipField'%		 	+ ';\n')
	#APPEND	(loutput	,'\tself.sec_range		:= ' + %'lSrangeField'% 	+ ';\n')
	#APPEND	(loutput	,'\tself.state				:= ' + %'lStateField'%	 	+ ';\n')
	#APPEND	(loutput	,'\tself.city			  	:= ' + %'lCityField'%	  	+ ';\n')
	#APPEND	(loutput	,'\tself.phone				:= ' + %'lPhoneField'%	 	+ ';\n')
	#APPEND	(loutput	,'\tself.bdid					:= 0																		;\n')
	#APPEND	(loutput	,'\tself.bdid_score		:= 0																		;\n')
	#APPEND	(loutput	,'\tself.source_group := \'\';\n')
	#IF(pFeinField = '')
		#APPEND	(loutput	,'\tself.fein					:= \'\';\n')
	#ELSE
		#APPEND	(loutput	,'\tself.fein					:= l.' +  pFeinField + ';\n')
	#END
	#IF(pURL = '')
		#APPEND	(loutput	,'\tself.URL				:= \'\';\n')
	#ELSE
		#APPEND	(loutput	,'\tself.URL				:= l.' +  pURL + ';\n')
	#END
	#IF(pEmail = '')
		#APPEND	(loutput	,'\tself.Email			:= \'\';\n')
	#ELSE
		#APPEND	(loutput	,'\tself.Email				:= l.' +  pEmail + ';\n')
	#END
	#IF(pContact_fname = '')
		#APPEND	(loutput	,'\tself.Contact_fname	:= \'\';\n')
	#ELSE
		#APPEND	(loutput	,'\tself.Contact_fname	:= l.' +  pContact_fname + ';\n')
	#END
	#IF(pContact_mname = '')
		#APPEND	(loutput	,'\tself.Contact_mname	:= \'\';\n')
	#ELSE
		#APPEND	(loutput	,'\tself.Contact_mname	:= l.' +  pContact_mname + ';\n')
	#END
	#IF(pContact_lname = '')
		#APPEND	(loutput	,'\tself.Contact_lname	:= \'\';\n')
	#ELSE
		#APPEND	(loutput	,'\tself.Contact_lname	:= l.' +  pContact_lname + ';\n')
	#END
	#IF(pContact_SSN = '')
		#APPEND	(loutput	,'\tself.Contact_SSN	:= \'\';\n')
	#ELSE
		#APPEND	(loutput	,'\tself.Contact_SSN	:= l.' +  pContact_SSN + ';\n')
	#END
	#IF(pSource = '')
		#APPEND	(loutput	,'\tself.Source	:= \'\';\n')
	#ELSE
		#APPEND	(loutput	,'\tself.Source	:= l.' +  pSource + ';\n')
	#END
	#IF(pSource_rec_id = '')
		#APPEND	(loutput	,'\tself.Source_rec_id	:= 0;\n')
	#ELSE
		#APPEND	(loutput	,'\tself.Source_rec_id	:= l.' +  pSource_rec_id + ';\n')
	#END
	#APPEND	(loutput	,'end;\n')
	#APPEND	(loutput	,%'dSlimForBdiding'% + ' := normalize(' + %'dDataset'% + ',' + %'lcountall'% + ',' + %'tSlimForBdiding'%  + '(left,counter));\n')

	// -- Dedup records before macro call to reduce possible skewing, and improve speed
	#APPEND	(loutput	,%'dDedupSlim'% + '	:= dedup(dedup(' + %'dSlimForBdiding'% + '	,except unique_id, bdid, bdid_score, local),except unique_id, bdid, bdid_score,all);\n')
	
	// -- call bdid macro
	#APPEND	(loutput	,'Business_Header_SS.MAC_Add_BDID_Flex(\n')
	#APPEND	(loutput	,'\t ' + %'dDedupSlim'%	+ '\n' )					
	#APPEND	(loutput	,'\t,' + %'lMatchset'%   	+ '\n' )                      
	#APPEND	(loutput	,'\t,company_name\n')	              
	#APPEND	(loutput	,'\t,prim_range		   \n')                   
	#APPEND	(loutput	,'\t,prim_name		   \n')               
	#APPEND	(loutput	,'\t,zip5					   \n')                   
	#APPEND	(loutput	,'\t,sec_range		   \n')                   
	#APPEND	(loutput	,'\t,state				   \n')                   
	#APPEND	(loutput	,'\t,phone				   \n')                   
	#APPEND	(loutput	,'\t,fein   				 \n')                   
	#APPEND	(loutput	,'\t,bdid						 \n')							      
	#APPEND	(loutput	,'\t,' + %'bdidSlimLayout'% + '\n')
	#IF(pBdidScoreField	!= '')
		#APPEND	(loutput	,'\t,true    \n')                                                  
	#ELSE
		#APPEND	(loutput	,'\t,false    \n')                                                  
	#END
	#APPEND	(loutput	,'\t,bdid_score    \n')                     
	#APPEND	(loutput	,'\t,' + %'dBdidFlexOut'% + ' \n')    

	#APPEND	(loutput	,'\t,' + pScoreThreshold + ' \n')    
	#APPEND	(loutput	,'\t,\'' + pFileVersion + '\' \n')    
	#APPEND	(loutput	,'\t,' + trim(#TEXT(pUseOtherEnvironment),all) + ' \n')    
	#APPEND	(loutput	,'\t,' + pSetLinkingVersions + ' \n')    
	#APPEND	(loutput	,'\t,URL							\n')    
	#APPEND	(loutput	,'\t,Email						\n')    
	#APPEND	(loutput	,'\t,City							\n')  
  #APPEND	(loutput	,'\t,Contact_fname		\n')    
	#APPEND	(loutput	,'\t,Contact_mname		\n')    
	#APPEND	(loutput	,'\t,Contact_lname		\n')
	#APPEND	(loutput	,'\t,Contact_SSN      \n')
	#APPEND	(loutput	,'\t,Source       		\n')
	#APPEND	(loutput	,'\t,Source_rec_id		\n')
	#APPEND	(loutput	,'\t);\n')   

	// Join back to before dedup to paste bdids onto full file(non deduped file)
	#APPEND	(loutput	,%'dBdidFlexOut_full'% + ' := join(\n')
	#APPEND	(loutput	,'\t ' + %'dSlimForBdiding'%	+ '\n')
	#APPEND	(loutput	,'\t,' + %'dBdidFlexOut'% 		+ '\n')
	#APPEND	(loutput	,'\t,\t\tleft.company_name = right.company_name		  \n')
	#APPEND	(loutput	,'\tand\tleft.prim_range	 = right.prim_range			  \n')
	#APPEND	(loutput	,'\tand\tleft.prim_name		 = right.prim_name			  \n')
	#APPEND	(loutput	,'\tand\tleft.zip5				 = right.zip5						  \n')
	#APPEND	(loutput	,'\tand\tleft.sec_range		 = right.sec_range			  \n')
	#APPEND	(loutput	,'\tand\tleft.state				 = right.state					  \n')
	#APPEND	(loutput	,'\tand\tleft.phone				 = right.phone					  \n')
	#APPEND	(loutput	,'\tand\tleft.source_group = right.source_group 	  \n')
	#APPEND	(loutput	,'\tand\tleft.fein				 = right.fein						  \n')
	#APPEND	(loutput	,'\tand\tleft.URL					 = right.URL							\n')
	#APPEND	(loutput	,'\tand\tleft.Email				 = right.Email						\n')
	#APPEND	(loutput	,'\tand\tleft.City				 = right.City						  \n')
	#APPEND	(loutput	,'\tand\tleft.Contact_fname = right.Contact_fname		\n')
	#APPEND	(loutput	,'\tand\tleft.Contact_mname = right.Contact_mname		\n')
	#APPEND	(loutput	,'\tand\tleft.Contact_lname = right.Contact_lname		\n')
	#APPEND	(loutput	,'\tand\tleft.Contact_SSN   = right.Contact_SSN 		\n')
	#APPEND	(loutput	,'\tand\tleft.Source = right.Source             		\n')
	#APPEND	(loutput	,'\tand\tleft.Source_rec_id = right.Source_rec_id		\n')
	#APPEND	(loutput	,'\t,transform(\n')
	#APPEND	(loutput	,'\t\trecordof(' + %'dBdidFlexOut'% + ')\n')
	#APPEND	(loutput	,'\t\t,self.bdid				:= right.bdid				;\n')
	#APPEND	(loutput	,'\t\t self.bdid_score	:= right.bdid_score	;\n')
	#APPEND	(loutput	,'\t\t,self.proxid			:= right.proxid		  ;\n')
	#APPEND	(loutput	,'\t\t,self.seleid			:= right.seleid		  ;\n')
	#APPEND	(loutput	,'\t\t,self.empid				:= right.empid			;\n')
	#APPEND	(loutput	,'\t\t,self.orgid				:= right.orgid			;\n')
	#APPEND	(loutput	,'\t\t,self.powid				:= right.powid			;\n')
	#APPEND	(loutput	,'\t\t,self.ultid				:= right.ultid			;\n')
	#APPEND	(loutput	,'\t\t,self.dotid				:= right.dotid			;\n')
	#APPEND	(loutput	,'\t\t self							:= left							;\n')
	#APPEND	(loutput	,'\t)\n')
	#APPEND	(loutput	,');\n')

	// -- Prep Datasets for join back to orig dataset to Assign Bdids
	#APPEND	(loutput	,%'dBDidOut'% + ' := ' + %'dBdidFlexOut_full'% + ';\n')
	
	#APPEND	(loutput	,%'dBDidOut_dist'% + '		:= distribute	(' + %'dBDidOut'% + '							,unique_id										);\n')
	#APPEND	(loutput	,%'dBDidOut_sort'% + '		:= sort				(' + %'dBDidOut_dist'% + '				,unique_id, -bdid_score	,local);\n')
	#APPEND	(loutput	,%'dBDidOut_dedup'% + '		:= dedup			(' + %'dBDidOut_sort'% + '				,unique_id							,local);\n')
	#APPEND	(loutput	,%'pDataset_dist'% + ' 		:= distribute	(' + %'dDataset'% + '							,' + %'lRidField'%	+ '									);\n')
		 
	#APPEND	(loutput	,%'layoutOrigFile'%  + ' ' + %'tAssignBdids'% + '(' + %'layoutSeqFile'% + ' l, ' + %'bdidSlimLayout'% + ' r) :=\n')
	#APPEND	(loutput	,'transform\n')
	#APPEND	(loutput	,'\tself.' + pBdidField			 + '				:= if(r.bdid 				<> 0, r.bdid				, 0);\n')
	#IF(pBdidScoreField	!= '')
		#APPEND	(loutput	,'\tself.' + pBdidScoreField + '	:= if(r.bdid_score	<> 0, r.bdid_score	, 0);\n')
	#END
	#IF(%lproxidexists% = true) #APPEND	(loutput	,'\tself.proxid	:= if(r.proxid  <> 0, r.proxid	, 0);\n') #END
	#IF(%lseleidexists% = true) #APPEND	(loutput	,'\tself.seleid	:= if(r.seleid  <> 0, r.seleid	, 0);\n') #END
	#IF(%lultidexists%  = true) #APPEND	(loutput	,'\tself.ultid	:= if(r.ultid	  <> 0, r.ultid	  , 0);\n') #END
	#IF(%lorgidexists%  = true) #APPEND	(loutput	,'\tself.orgid	:= if(r.orgid	  <> 0, r.orgid	  , 0);\n') #END
	#IF(%lempidexists%  = true) #APPEND	(loutput	,'\tself.empid	:= if(r.empid	  <> 0, r.empid	  , 0);\n') #END
	#IF(%lpowidexists%  = true) #APPEND	(loutput	,'\tself.powid	:= if(r.powid	  <> 0, r.powid	  , 0);\n') #END
	#IF(%ldotidexists%  = true) #APPEND	(loutput	,'\tself.dotid	:= if(r.dotid	  <> 0, r.dotid	  , 0);\n') #END
  
	#APPEND	(loutput	,'\tself 						:= l;\n')
	#APPEND	(loutput	,'end;\n')
	
	// -- Join back to original dataset to assign Bdids
	#APPEND	(loutput	,%'dAssignBdids'% + ' := join(\n')
	#APPEND	(loutput	,'\t ' + %'pDataset_dist'% + '\n')
	#APPEND	(loutput	,'\t,' + %'dBDidOut_dedup'% + '\n')
	#APPEND	(loutput	,'\t,left.' + %'lRidField'% + ' = right.unique_id\n')
	#APPEND	(loutput	,'\t,' + %'tAssignBdids'% + '(left, right)\n')
	#APPEND	(loutput	,'\t,left outer\n')
	#APPEND	(loutput	,'\t,local)\n')
	#IF(pPersistname != '')
		#APPEND	(loutput	,' : persist(' + trim(#TEXT(pPersistname),all) + ')')
	#END
	#APPEND	(loutput	,';\n')	
	
	#APPEND(loutput, %'moutput'% + ' := ' + %'dAssignBdids'% + ';\n');
	
	#SET(moutput	,%'loutput'% + ' return ' + %'moutput'% + ';\n')
	
	#if(pOutputEcl = true)
		return %'loutput'%;
	#ELSE
		%moutput%		
	#END
	
endmacro;