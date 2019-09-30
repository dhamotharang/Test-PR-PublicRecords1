import _control, MDR, tools,aid,address,mdr,TopBusiness_External,Business_Header_SS,business_header,DID_Add,bipv2, Std;

export Update_Companies(
	 string																					pversion
	,dataset(layouts.temporary.big								)	pPrepFile		= Prep_Input(pversion)
	,dataset(Layouts.Base.Companies								)	pBaseFile		= Files().base.companies.qa		
	,dataset(Layouts.Base.Contacts								)	pContacts		= Files().base.Contacts.new
	,dataset(layouts.temporary.companies_aid_prep	)	pSplitInput	= Split_Input(pversion	,pPrepFile).Companies	
) :=
function

	dBaseFile := if(_Flags.KeepHistory ,Prep_Base(pBaseFile).Companies	,dataset([],layouts.temporary.companies_aid_prep));
  maxfiledate := max(pSplitInput,filedate);
  
	dIngest									:= project(pSplitInput(filedate  = maxfiledate)	,transform(layouts.temporary.companies_aid_prep,self.record_type := utilities.RecordType.New,self := left))
                          +  project(pSplitInput(filedate != maxfiledate)	,transform(layouts.temporary.companies_aid_prep,self.record_type := utilities.RecordType.Old,self := left))
													+	 project(dBaseFile		                        ,transform(layouts.temporary.companies_aid_prep,self.record_type := utilities.RecordType.Old,self := left))
													;
	dAppendAid 			:= tools.mac_Append_AID			(dIngest				,'rid'	,['physical_address1','mailing_address1'],['physical_address2','mailing_address2'],['physical_RawAID','mailing_RawAID'],['physical_AceAID','mailing_AceAID'],['physical_address','mailing_address'],Persistnames().AppendAidCompanies);
	dAppendPhones 	:= tools.mac_Append_Phones	(dAppendAid			,['rawfields.phone','rawfields.telex','rawfields.fax'],['clean_phones.phone','clean_phones.telex','clean_phones.fax'],'rid',Persistnames().AppendPhonesCompanies);
	
	//Join Companies and Contacts file to get the first,middle,last names
	Layout_CompAndCont := record
				layouts.temporary.companies_aid_prep;
				layouts.Base.Contacts.clean_name.fname;
				layouts.Base.Contacts.clean_name.mname;
				layouts.Base.Contacts.clean_name.lname;
				string2 source;
		end;
	Layout_CompAndCont JoinRecs( layouts.temporary.companies_aid_prep L, layouts.Base.Contacts R) := transform
				self.fname	:=r.clean_name.fname;
				self.mname	:=r.clean_name.mname;
				self.lname	:=r.clean_name.lname;
				self.source :=MDR.sourceTools.src_DCA;
				self :=	l;
	 end;
  dJoinCompAndCont:= join( dAppendPhones, pContacts
														,left.rid=right.rid 
														,JoinRecs(left,right)
														,left outer, local   );	
	
	
	dJoinAppendBdid	:= tools.mac_Append_BDID (dJoinCompAndCont  // Input Dataset for bdiding
											,'rawfields.Name'  																							// Company Name Field
											,['physical_address.prim_range','mailing_address.prim_range'	] // Set of Prim range fields
											,['physical_address.prim_name' ,'mailing_address.prim_name']    // Set of Prim name fields
											,['physical_address.zip'       ,'mailing_address.zip']          // Set of Zip fields
											,['physical_address.sec_range' ,'mailing_address.sec_range']    // Set of Secondary Range Fields
											,['physical_address.st'        ,'mailing_address.st']           // Set of State Fields
											,['clean_phones.phone'         ,'clean_phones.telex']						// Set of phone fields
											,'rid'																													// Unique Id Field in input dataset. 
											,'bdid'  																												// Bdid Field
											,  																															// Fein Field
											,  																															// Matchset for Bdid macro.
											,  																															// Bdid score field
											,Persistnames().AppendBdidCompanies  														// set this if you would like to persist the output
											,  																															// bdid score threshold
											,  																															// default to use prod version of superfiles
											,	   																														// default is to hit prod from dataland, and on prod hit prod.
											,'BIPV2.IDconstants.xlink_versions_BDID_BIP'   									//
											,'rawfields.url'					 																			// URL
											,'rawfields.e_mail'				 																			// Email
											,['physical_address.p_city_name','mailing_address.p_city_name'] // Set of city names
											,'fname'																												// Contact First Name 
											,'mname'				 																								// Contact Middle Name
											,'lname' 																												// Contact Last Name
											,																																// Contact SSN
											,'source'																												// source from MDR.sourceTools
											,'src_rid' );																										// source_rec_id field
	
	//Project back to layouts.temporary.companies_aid_prep to strip off first,middle,last names
  dAppendBdidDups := project(dJoinAppendBdid,	layouts.temporary.companies_aid_prep);
	dAppendBdid		  := dedup(dAppendBdidDups, whole record, local );

	dAppendSrcRid		:= DCAV2.Append_Source_Rid (project(dAppendBdid,	layouts.base.companies));
	
	//Add Global_SID
	addGlobalSID		:= MDR.macGetGlobalSid(dAppendSrcRid, 'DCA', 'file_type', 'global_sid'); //DF-26145: Populate Global_SID

	return addGlobalSID;
	
end;
