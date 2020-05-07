import tools,aid,address,mdr,TopBusiness_External,Business_Header_SS,business_header,DID_Add,business_headerv2,bipv2;

export Update_Contacts(

	 string																					pversion
	,dataset(layouts.temporary.big								)	pPrepFile		= Prep_Input(pversion)
	,dataset(Layouts.Base.Contacts								)	pBaseFile		= Files().base.contacts.qa			
	,dataset(layouts.temporary.contacts_aid_prep	)	pSplitInput	= Split_Input(pversion	,pPrepFile).Contacts	

) :=
function

	dBaseFile := if(_Flags.KeepHistory ,Prep_Base(,pBaseFile).Contacts	,dataset([],layouts.temporary.contacts_aid_prep));
  maxfiledate := max(pSplitInput,filedate);

//	dIngest									:= Ingest_Contacts	(pSplitInput	,dBaseFile		).AllRecords_NoTag;
	dIngest									:= project(pSplitInput(filedate  = maxfiledate)	,transform(layouts.temporary.contacts_aid_prep,self.record_type := utilities.RecordType.New,self := left))
                          +  project(pSplitInput(filedate != maxfiledate)	,transform(layouts.temporary.contacts_aid_prep,self.record_type := utilities.RecordType.Old,self := left))
													+	 project(dBaseFile		                        ,transform(layouts.temporary.contacts_aid_prep,self.record_type := utilities.RecordType.Old,self := left))
													;
	dAppendAid		:= tools.mac_Append_AID		(dIngest				,'rid'	,['physical_address1','mailing_address1'],['physical_address2','mailing_address2'],['physical_RawAID','mailing_RawAID'],['physical_AceAID','mailing_AceAID'],['physical_address','mailing_address'],Persistnames().AppendAidContacts);
	dAppendPhones	:= tools.mac_Append_Phones(dAppendAid			,['rawfields.phone','rawfields.telex','rawfields.fax'],['clean_phones.phone','clean_phones.telex','clean_phones.fax'],'rid',Persistnames().AppendPhonesContacts);
	dAppendDid		:= tools.mac_Append_DID		(dAppendPhones	,'clean_name.fname','clean_name.mname','clean_name.lname','clean_name.name_suffix',['physical_address.prim_range','mailing_address.prim_range'	],['physical_address.prim_name','mailing_address.prim_name'],['physical_address.zip','mailing_address.zip'],['physical_address.sec_range'		,'mailing_address.sec_range'	],['physical_address.st'						,'mailing_address.st'					],['clean_phones.phone','clean_phones.telex'],,,,,,,Persistnames().AppendDIDContacts);
	dAppendBdid		:= tools.mac_Append_BDID	(dAppendDid
															,'rawfields.Name'
															,['physical_address.prim_range','mailing_address.prim_range'	]
															,['physical_address.prim_name' ,'mailing_address.prim_name']
															,['physical_address.zip'       ,'mailing_address.zip']
															,['physical_address.sec_range' ,'mailing_address.sec_range']
															,['physical_address.st'        ,'mailing_address.st']
															,['clean_phones.phone'         ,'clean_phones.telex']
															,'rid','bdid',,,,Persistnames().AppendBdidContacts,,,	
															,'BIPV2.IDconstants.xlink_versions_BDID_BIP',, 
															,['physical_address.p_city_name','mailing_address.p_city_name']
															,'clean_Name.fname'				 
															,'clean_Name.mname'				 
															,'clean_Name.lname'   );
	dAppendBdid_proj := project(dAppendBdid	,layouts.base.contacts);
	
	// Jira# CCPA-1029 - Populate Global_SID's
	addGlobalSID		:= MDR.macGetGlobalSid(dAppendBdid_proj, 'DCA', 'file_type', 'global_sid') : persist(persistnames().UpdateContacts); 
	
 	return addGlobalSID;	
end;
