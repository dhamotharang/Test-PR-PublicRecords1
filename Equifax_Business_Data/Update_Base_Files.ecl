import Equifax_Business_Data, DID_Add, tools;

export Update_Base_Files(

	 string																	 pversion
	,dataset(Layouts.Sprayed_Input				 ) pSprayedFile		       = Files().Input.Companies.using
	,dataset(Layouts.Base                  ) pBaseFile             = Files().base.Companies.qa																					
	,dataset(Layouts.Sprayed_Input_Contacts) pSprayedContactsFile  = Files().Input.Contacts.using  
	,dataset(Layouts.Base_Contacts				 ) pBaseContactsFile		 = Files().base.contacts.qa 
	,boolean																 pShouldUpdate		     = _Flags.UpdateExists	
	,boolean																 pShouldUpdateContacts = _Flags.UpdateContactsExists
) :=
function

  dStandardizedInputFile	:= Standardize_Input.fAll(pSprayedFile, pversion);	
		
	MyDelta :=  IF(pShouldUpdate
								 ,PROJECT(pBaseFile, TRANSFORM(Equifax_Business_Data.Layouts.Base, SELF.record_type := 'H'; SELF := LEFT))
								 ,DATASET([],Equifax_Business_Data.Layouts.Base));						 

	ingestMod := Equifax_Business_Data.IngestCompanies(FALSE,,MyDelta,dStandardizedInputFile);
	
	// Ingest Output File
	dIngest := ingestMod.AllRecords_Notag;	
	
	dStandardize_NameAddr		:= Standardize_NameAddr.fAll (dIngest);
	
	dAppendIds							:= Append_Ids.fAll					(dStandardize_NameAddr			);
	
	dRollup									:= Rollup_Base							(dAppendIds									);

	dStandardizedContactsFile	:= Standardize_Input_Contacts.fAll(pSprayedContactsFile, pversion); 
  
	MyDeltaContacts :=  IF(pShouldUpdateContacts
								 ,PROJECT(pBaseContactsFile, TRANSFORM(Equifax_Business_Data.Layouts.Base_Contacts, SELF.record_type := 'H'; SELF := LEFT))	
								 ,DATASET([],Equifax_Business_Data.Layouts.Base_Contacts));

	ingestModContacts := Equifax_Business_Data.IngestContacts(FALSE,,MyDeltaContacts,dStandardizedContactsFile);	
	
	// Ingest Output File
	dIngestContacts := ingestModContacts.AllRecords_Notag;	

  dStandardize_Name_Contacts		:= Standardize_Name_Contacts.fAll (dIngestContacts, pversion);
														
	companies_dist 	:= distribute(dRollup,hash64(efx_id));
	sortCompanies   := sort(companies_dist, efx_id, -process_date, local);
	contacts_dist 	:= distribute(dIngestContacts,hash64(efx_id));
	sortContacts    := sort(contacts_dist, efx_id, -process_date, local);
		
	Layouts.Base_Contacts AppendCompanyInfo(Layouts.Base_contacts l, Layouts.Base r) :=
	transform
		self.did											          := 0;  
		self.company_name 						          := r.efx_name;
		self.clean_company_phone 			          := r.clean_phone;
		self.company_record_type 			          := r.record_type;
		self.company_date_first_seen	          := r.dt_first_seen;
		self.company_date_last_seen		          := r.dt_last_seen;	
		self.clean_company_address.prim_range		:= r.prim_range	;
		self.clean_company_address.prim_name		:= r.prim_name	;
		self.clean_company_address.sec_range		:= r.sec_range	;
		self.clean_company_address.zip		 			:= r.zip				;
		self.clean_company_address.st   		    := r.st					;		    
		self.clean_company_address.p_city_name 	:= r.p_city_name;
		self.raw_aid                            := r.raw_aid;
		self.ace_aid                            := r.ace_aid;
		self.efx_email                          := l.efx_email; 	  				;	
		self := l;		
		self := [];
	end;

	// Get all company records that are in the valid date range window, then select best one after join
	contacts_getcompanyinfo := join( sortContacts
																	,sortCompanies
																	,trim(left.efx_id,left,right)  = trim(right.efx_id,left,right) and
																	 left.process_date             = right.process_date
																	,AppendCompanyInfo(left,right)
																	,left outer
																	,local
											          );
											
											
	distContacts	  := distribute	(contacts_getcompanyinfo, hash(rcid));
	contacts_sort	  := sort				(distContacts, rcid, -company_date_last_seen, local)
	: persist(Equifax_Business_Data.Persistnames().CompanyContactJoin,SINGLE)	
	;
	contacts_dedup	:= dedup			(contacts_sort, rcid, local)
  : persist(Equifax_Business_Data.Persistnames().CompanyContactDedup,SINGLE)
	;
	
	dAppendDIdsContacts  := Equifax_Business_Data.Append_DIds_Contacts.fAll(contacts_dedup);	
	dRollupContacts	     := Rollup_Contacts(dAppendDIdsContacts);
	
	tools.mac_WriteFile(Filenames(pversion).base.Companies.new	,dRollup		,Build_Companies_File	,pShouldExport := false);
	tools.mac_WriteFile(Filenames(pversion).base.Contacts.new		,dRollupContacts	,Build_Contacts_File	,pShouldExport := false);

return	sequential(
											Build_Companies_File,
											Build_Contacts_File
										);							
							
end;							