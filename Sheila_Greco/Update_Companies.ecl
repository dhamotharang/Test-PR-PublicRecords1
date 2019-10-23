import _control, MDR, Std, ut;

export Update_Companies(

	 dataset(layouts.Input.Sprayed	)	pUpdateFile
	,dataset(layouts.Input.Sprayed	)	pUpdateContactsFile
	,dataset(Layouts.Base.Contacts	)	pBaseContactsFile
	,dataset(Layouts.Base.Companies	)	pBaseFile
	,string														pversion

) :=
function
  
  //Pre-Process the Contacts Input File because we need clean name info for BIP ID stamping
  Contacts_Updt := Prep_Contacts(pUpdateContactsFile, pversion);
		
	SlimContactsBase := project(pBaseContactsFile ,transform(layouts.temporary.Slim_Contacts,
												self.maincompanyid	:= left.rawfields.maincompanyid  ; 
												self.fname	:= left.clean_contact_name.fname ;
												self.mname  := left.clean_contact_name.mname ;
												self.lname  := left.clean_contact_name.lname ;
												self.email  := left.rawfields.OfficeEmail    ; ));
  
	SlimContactsUpdt := project(Contacts_Updt ,transform(layouts.temporary.Slim_Contacts,
												self.maincompanyid	:= left.rawfields.maincompanyid    ; 
												self.fname	:= left.clean_contact_name.fname ;
												self.mname  := left.clean_contact_name.mname ;
												self.lname  := left.clean_contact_name.lname ;
												self.email  := left.rawfields.OfficeEmail    ; ));
  
	Contacts := SlimContactsUpdt + SlimContactsBase;

  //Pre-Process/Parse the Companies Input File
	preprocess							:= Parse_Input.PreProcess.Companies	(pUpdateFile															);
	Companies								:= Parse_Input.Companies						(preprocess																);
		
	dStandardizedInputFile	:= Standardize_Companies.fAll(Companies, pversion);
	base_file 							:= project(pBaseFile, transform(Layouts.Base.Companies, self.record_type := 'H'; self := left));
	update_combined					:= map(_Flags.Update.Companies =>	 dStandardizedInputFile + base_file
																														,dStandardizedInputFile );
																														
	addGlobalSID						:= MDR.macGetGlobalSid(update_combined, 'SheilaGrecoCompany', '', 'global_sid'); //DF : Populate Global_SID;	
	
	dStandardizedAddr				:= Standardize_Addr_Companies	(addGlobalSID		);
	 
	dAppendIds	:= Append_Ids.fAppendBdid	(dStandardizedAddr, Contacts);
	 
	dAppendIds_Dist  := sort(distribute(dAppendIds),record, local); 
  dAppendBdid	     := dedup(dAppendIds_Dist, whole record, local );
	
	dRollup			:= Rollup_Companies	(dAppendBdid);
		
	//Add source_rec_id 
	UT.MAC_Append_Rcid(dRollup, source_rec_id, dBaseOut);

	return dBaseOut;
 
end;