import corp2, corp2_mapping, corp2_raw_mi, scrubs, scrubs_corp2_mapping_mi_ar,
			 scrubs_corp2_mapping_mi_event, scrubs_corp2_mapping_mi_main, scrubs_corp2_mapping_mi_stock,
			 std, tools, ut, versioncontrol;
			 
export MI := module 

	export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, boolean pUseProd = Tools._Constants.IsDataland) := function

		state_origin				:= 'MI';
		state_fips	 				:= '26';
		state_desc	 			 	:= 'MICHIGAN';

    //********************************************************************
		// Vendor Input Files 
		//********************************************************************
		ds_CorpMaster	      := dedup(sort(distribute(Corp2_Raw_MI.Files(fileDate,puseprod).Input.CorpMaster.Logical,hash(EntityID)),record,local),record,local) : independent;
	  ds_AssumedName	    := dedup(sort(distribute(Corp2_Raw_MI.Files(fileDate,puseprod).Input.AssumedName.Logical,hash(EntityID)),record,local),record,local) : independent;
	  ds_GeneralPartner  	:= dedup(sort(distribute(Corp2_Raw_MI.Files(fileDate,puseprod).Input.GeneralPartner.Logical,hash(EntityID)),record,local),record,local) : independent;
	  ds_History	    		:= dedup(sort(distribute(Corp2_Raw_MI.Files(fileDate,puseprod).Input.History.Logical,hash(EntityID)),record,local),record,local) : independent;
    ds_LLC            	:= dedup(sort(distribute(Corp2_Raw_MI.Files(fileDate,puseprod).Input.LLC.Logical,hash(EntityID)),record,local),record,local) : independent;  
	  ds_LP             	:= dedup(sort(distribute(Corp2_Raw_MI.Files(fileDate,puseprod).Input.LP.Logical,hash(EntityID)),record,local),record,local) : independent;
	  ds_NameRegistration	:= dedup(sort(distribute(Corp2_Raw_MI.Files(fileDate,puseprod).Input.NameRegistration.Logical,hash(EntityID)),record,local),record,local) : independent;


		Bad_Addrs           := ['TEST ADDR','ASDFASDFASDFASDF'];
	  Bad_Names           := ['','TEST RECORD','TESTING RECORD','TESTING NAME','TESTING 190','TESTING 195','USA','MA','MI','DSTE','CRCC'];
	  Bad_RA_Names        := '^THIS RECORD|THIS RECORD|^NONE|^BUSINESS FILINGS INCORPORATED';
    //The following patterns of 'RESG OF AGENT EFF 9/1/12', 'RES OF AGENT EFF 3/7/12', 'RESG OF AG EF 10/18/13', 'RESIGN OF AGENT EF 10/18/13'
	  //have been included at the end of the RA name.  When this pattern is found it will be removed.
		RApattern           := '(\\sRES[G OF| OF|IGN].*$)';
	  history_event_codes	:= ['2','3','4','5','02','03','04','05','14','27','41'];
		ent_types           := ['200','0200','201','0201','300','0300','400','0400','402','0402','500','0500','502','0502',
		                        '503','0503','504','0504','505','0505','506','0506','601','0601','602','0602','801','0801'];
		Acts_pattern        := '\\d{3}-\\d{4}';
	

		//******************************************************************
		// PROCESS CORPORATE (CORP) DATA
		//******************************************************************
		Corp2_Mapping.LayoutsCommon.Main CorpMasterTransform(Corp2_Raw_MI.Layouts.CorporationLayoutIn l):= transform,
	    skip(corp2.t2u(l.EntityName) in Bad_Names)
				self.dt_vendor_first_reported			 := (integer)fileDate;
				self.dt_vendor_last_reported			 := (integer)fileDate;
				self.dt_first_seen								 := (integer)fileDate;
				self.dt_last_seen									 := (integer)fileDate;
				self.corp_ra_dt_first_seen				 := (integer)fileDate;
				self.corp_ra_dt_last_seen					 := (integer)fileDate;			
				self.corp_key											 := state_fips + '-' + corp2.t2u(l.EntityID);
				self.corp_vendor									 := state_fips;
				self.corp_state_origin						 := state_origin;			
				self.corp_process_date						 := fileDate;		
				self.corp_orig_sos_charter_nbr   	 := corp2.t2u(l.EntityID);
				self.corp_legal_name             	 := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.EntityName).BusinessName;				
				self.corp_ln_name_type_cd   			 := '01';
				self.corp_ln_name_type_desc 			 := 'LEGAL';
				mailingcountry_str                 := Corp2_Raw_MI.Functions.Country_Description(l.MailingCountry);
				self.corp_address1_type_cd       	 := if(corp2.t2u(l.MailingAddr1) not in Bad_Addrs and corp2_mapping.faddressexists(state_origin,state_desc,l.MailingAddr1,l.MailingAddr2,l.MailingCity,l.MailingState,l.MailingPostalCode,mailingcountry_str).ifaddressexists,'M','');
				self.corp_address1_type_desc     	 := if(corp2.t2u(l.MailingAddr1) not in Bad_Addrs and corp2_mapping.faddressexists(state_origin,state_desc,l.MailingAddr1,l.MailingAddr2,l.MailingCity,l.MailingState,l.MailingPostalCode,mailingcountry_str).ifaddressexists,'MAILING','');
				self.corp_address1_line1         	 := if(corp2.t2u(l.MailingAddr1) not in Bad_Addrs,corp2_mapping.fcleanaddress(state_origin,state_desc,l.MailingAddr1,l.MailingAddr2,l.MailingCity,l.MailingState,l.MailingPostalCode,mailingcountry_str).AddressLine1,'');
				self.corp_address1_line2         	 := if(corp2.t2u(l.MailingAddr1) not in Bad_Addrs,corp2_mapping.fcleanaddress(state_origin,state_desc,l.MailingAddr1,l.MailingAddr2,l.MailingCity,l.MailingState,l.MailingPostalCode,mailingcountry_str).AddressLine2,'');
				self.corp_address1_line3           := if(corp2.t2u(l.MailingAddr1) not in Bad_Addrs,corp2_mapping.fcleanaddress(state_origin,state_desc,l.MailingAddr1,l.MailingAddr2,l.MailingCity,l.MailingState,l.MailingPostalCode,mailingcountry_str).AddressLine3,'');
				self.corp_prep_addr1_line1       	 := if(corp2.t2u(l.MailingAddr1) not in Bad_Addrs,corp2_mapping.fcleanaddress(state_origin,state_desc,l.MailingAddr1,l.MailingAddr2,l.MailingCity,l.MailingState,l.MailingPostalCode,mailingcountry_str).PrepAddrLine1,'');
				self.corp_prep_addr1_last_line     := if(corp2.t2u(l.MailingAddr1) not in Bad_Addrs,corp2_mapping.fcleanaddress(state_origin,state_desc,l.MailingAddr1,l.MailingAddr2,l.MailingCity,l.MailingState,l.MailingPostalCode,mailingcountry_str).PrepAddrLastLine,'');
				self.corp_status_cd 							 := corp2.t2u(l.Active);
				self.corp_status_desc 						 := map(corp2.t2u(l.Active) = 'Y' => 'ACTIVE',
																								  corp2.t2u(l.Active) = 'N' => 'INACTIVE',
																								  ''
																								 );
				self.corp_status_date 	           := Corp2_Mapping.fValidateDate(l.InactiveDate,'CCYYMMDD').PastDate;
				self.corp_status_comment					 := if(corp2.t2u(l.Active) = 'N',Corp2_Raw_MI.Functions.CorpStatusComment(l.InactiveType),'');
				self.corp_inc_state 							 := state_origin;
				self.corp_inc_date 								 := if(corp2.t2u(l.IncorporatedInState) in [state_origin,''],Corp2_Mapping.fValidateDate(l.IncDate,'CCYYMMDD').PastDate,'');
				self.corp_term_exist_cd 					 := map(corp2.t2u(l.Perpetual) = 'Y'																			        => 'P',
				                                          Corp2_Mapping.fValidateDate(l.DateDissolved,'CCYYMMDD').GeneralDate <> '' => 'D',
																								  ''
																								  );
				self.corp_term_exist_exp 					 := Corp2_Mapping.fValidateDate(l.DateDissolved,'CCYYMMDD').GeneralDate;
				self.corp_term_exist_desc 			   := map(self.corp_term_exist_cd = 'D' => 'EXPIRATION DATE',
																									self.corp_term_exist_cd = 'P' => 'PERPETUAL',
																									''
																								 );			
				self.corp_orig_org_structure_cd 	 := if(corp2.t2u(l.EntityType) in ent_types, corp2.t2u(l.EntityType),'');				
				self.corp_orig_org_structure_desc	 := Corp2_Raw_MI.Functions.CorpOrigOrgStructureCD(l.EntityType);
				self.corp_foreign_domestic_ind		 := Corp2_Raw_MI.Functions.ForeignDomesticInd(self.corp_orig_org_structure_desc);				
				self.corp_forgn_state_cd 					 := if(corp2.t2u(l.IncorporatedInState) not in [state_origin,''],Corp2_Raw_MI.Functions.CorpForgnStateCD(l.IncorporatedInState),'');
				self.corp_forgn_state_desc 				 := if(corp2.t2u(l.IncorporatedInState) not in [state_origin,''],Corp2_Raw_MI.Functions.CorpForgnStateDesc(l.IncorporatedInState),'');
				self.corp_forgn_date 							 := if(corp2.t2u(l.IncorporatedInState) not in [state_origin,''],Corp2_Mapping.fValidateDate(l.IncDate,'CCYYMMDD').PastDate,'');
     		self.corp_for_profit_ind					 := map(corp2.t2u(self.corp_orig_org_structure_desc) in ['DOMESTIC PROFIT CORPORATION','FOREIGN PROFIT CORPORATION']       => 'Y',
																									corp2.t2u(self.corp_orig_org_structure_desc) in ['DOMESTIC NONPROFIT CORPORATION','FOREIGN NONPROFIT CORPORATION'] => 'N',
																									''
																								 );
				self.corp_entity_desc			         := if(corp2.t2u(l.Purpose) = 'APC','ALL PURPOSE CLAUSE',corp2.t2u(l.Purpose));
				self.corp_acts 										 := if(regexfind(Acts_pattern,l.Act1) and l.Act1 <> '999-9999',corp2.t2u(l.Act1),'');
				RAName                             := if(regexfind(Bad_RA_Names,corp2.t2u(l.AgentName)),'',regexreplace(RApattern,corp2.t2u(l.AgentName),''));
				self.corp_ra_full_name 						 := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,RAName).BusinessName;		
				RAcountry_str                      := Corp2_Raw_MI.Functions.Country_Description(l.AgentCountry);
				self.corp_ra_address_line1				 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.AgentAddr1,l.AgentAddr2,l.AgentCity,l.AgentState,l.AgentPostalCode,RAcountry_str).AddressLine1;
				self.corp_ra_address_line2			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.AgentAddr1,l.AgentAddr2,l.AgentCity,l.AgentState,l.AgentPostalCode,RAcountry_str).AddressLine2;
				self.corp_ra_address_line3				 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.AgentAddr1,l.AgentAddr2,l.AgentCity,l.AgentState,l.AgentPostalCode,RAcountry_str).AddressLine3;
				self.corp_ra_address_type_cd			 := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.AgentAddr1,l.AgentAddr2,l.AgentCity,l.AgentState,l.AgentPostalCode).ifAddressExists,'R','');
				self.corp_ra_address_type_desc 		 := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.AgentAddr1,l.AgentAddr2,l.AgentCity,l.AgentState,l.AgentPostalCode).ifAddressExists,'REGISTERED OFFICE','');		
				self.ra_prep_addr_line1        		 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.AgentAddr1,l.AgentAddr2,l.AgentCity,l.AgentState,l.AgentPostalCode).PrepAddrLine1;
				self.ra_prep_addr_last_line    		 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.AgentAddr1,l.AgentAddr2,l.AgentCity,l.AgentState,l.AgentPostalCode).PrepAddrLastLine;
				self.corp_acts2										 := if(regexfind(Acts_pattern,l.Act2) and l.Act2 <> '999-9999',corp2.t2u(l.Act2),'');
				self.corp_acts3										 := if(regexfind(Acts_pattern,l.Act3) and l.Act3 <> '999-9999',corp2.t2u(l.Act3),'');
				self.corp_purpose									 := if(corp2.t2u(l.Purpose) = 'APC','ALL PURPOSE CLAUSE',corp2.t2u(l.Purpose));
				self.corp_addl_info                := if(corp2.t2u(l.LegacyID) <> '', 'OLD CHARTER NUMBER: ' + corp2.t2u(l.LegacyID),'');
        self.corp_country_of_formation     := if(corp2.t2u(l.IncorporatedInCountry) not in [state_origin,''], Corp2_Raw_MI.Functions.Country_Description(l.IncorporatedInCountry), '');
				self.recordorigin									 := 'C';
				self 															 := [];
		end;

		MapCorp := project(ds_CorpMaster, CorpMasterTransform(LEFT)) : independent;
		
		//******************************************************************
		// PROCESS LIMITED PARTNERSHIP (LP) DATA
		//******************************************************************
		Corp2_Mapping.LayoutsCommon.Main LPMasterTransform(Corp2_Raw_MI.Layouts.LPLayoutIn l):= transform,
			skip(corp2.t2u(l.EntityName) in Bad_Names)
				self.dt_vendor_first_reported			 := (integer)fileDate;
				self.dt_vendor_last_reported			 := (integer)fileDate;
				self.dt_first_seen								 := (integer)fileDate;
				self.dt_last_seen									 := (integer)fileDate;
				self.corp_ra_dt_first_seen				 := (integer)fileDate;
				self.corp_ra_dt_last_seen					 := (integer)fileDate;			
				self.corp_key											 := state_fips + '-' + corp2.t2u(l.EntityID);
				self.corp_vendor									 := state_fips;
				self.corp_state_origin						 := state_origin;			
				self.corp_process_date						 := fileDate;		
				self.corp_orig_sos_charter_nbr   	 := corp2.t2u(l.EntityID);
				self.corp_legal_name             	 := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.EntityName).BusinessName;				
				self.corp_ln_name_type_cd   			 := '01';
				self.corp_ln_name_type_desc 			 := 'LEGAL';
				OffcCountry_str                    := Corp2_Raw_MI.Functions.Country_Description(l.OfficeCountry);
				self.corp_address1_type_cd       	 := if(corp2.t2u(l.OfficeAddr1) not in Bad_Addrs and corp2_mapping.faddressexists(state_origin,state_desc,l.OfficeAddr1,l.OfficeAddr2,l.OfficeCity,l.OfficeState,l.OfficePostalCode,OffcCountry_str).ifaddressexists,'B','');
				self.corp_address1_type_desc     	 := if(corp2.t2u(l.OfficeAddr1) not in Bad_Addrs and corp2_mapping.faddressexists(state_origin,state_desc,l.OfficeAddr1,l.OfficeAddr2,l.OfficeCity,l.OfficeState,l.OfficePostalCode,OffcCountry_str).ifaddressexists,'BUSINESS','');
				self.corp_address1_line1         	 := if(corp2.t2u(l.OfficeAddr1) not in Bad_Addrs,corp2_mapping.fcleanaddress(state_origin,state_desc,l.OfficeAddr1,l.OfficeAddr2,l.OfficeCity,l.OfficeState,l.OfficePostalCode,OffcCountry_str).AddressLine1,'');
				self.corp_address1_line2         	 := if(corp2.t2u(l.OfficeAddr1) not in Bad_Addrs,corp2_mapping.fcleanaddress(state_origin,state_desc,l.OfficeAddr1,l.OfficeAddr2,l.OfficeCity,l.OfficeState,l.OfficePostalCode,OffcCountry_str).AddressLine2,'');
				self.corp_address1_line3           := if(corp2.t2u(l.OfficeAddr1) not in Bad_Addrs,corp2_mapping.fcleanaddress(state_origin,state_desc,l.OfficeAddr1,l.OfficeAddr2,l.OfficeCity,l.OfficeState,l.OfficePostalCode,OffcCountry_str).AddressLine3,'');
				self.corp_prep_addr1_line1       	 := if(corp2.t2u(l.OfficeAddr1) not in Bad_Addrs,corp2_mapping.fcleanaddress(state_origin,state_desc,l.OfficeAddr1,l.OfficeAddr2,l.OfficeCity,l.OfficeState,l.OfficePostalCode,OffcCountry_str).PrepAddrLine1,'');
				self.corp_prep_addr1_last_line     := if(corp2.t2u(l.OfficeAddr1) not in Bad_Addrs,corp2_mapping.fcleanaddress(state_origin,state_desc,l.OfficeAddr1,l.OfficeAddr2,l.OfficeCity,l.OfficeState,l.OfficePostalCode,OffcCountry_str).PrepAddrLastLine,'');
				self.corp_status_cd 							 := corp2.t2u(l.Active);
				self.corp_status_desc 						 := map(corp2.t2u(l.Active) = 'Y' => 'ACTIVE',
																								  corp2.t2u(l.Active) = 'N' => 'INACTIVE',
																								  ''
																								 );
				self.corp_status_date 	           := Corp2_Mapping.fValidateDate(l.InactiveDate,'CCYYMMDD').PastDate;
				self.corp_status_comment					 := if(corp2.t2u(l.Active) = 'N',Corp2_Raw_MI.Functions.CorpStatusComment(l.InactiveType),'');
				self.corp_inc_state 							 := state_origin;
				self.corp_inc_date 								 := if(corp2.t2u(l.FormedInState) in [state_origin,''],Corp2_Mapping.fValidateDate(l.FormedOn,'CCYYMMDD').PastDate,'');
				self.corp_term_exist_cd 					 := map(corp2.t2u(l.Perpetual) = 'Y'																			         => 'P',
				                                          Corp2_Mapping.fValidateDate(l.TermExpiration,'CCYYMMDD').GeneralDate <> '' => 'D',
																								  ''
																								 );
				self.corp_term_exist_exp 					 := Corp2_Mapping.fValidateDate(l.TermExpiration,'CCYYMMDD').GeneralDate;
				self.corp_term_exist_desc 			   := map(self.corp_term_exist_cd = 'D' => 'EXPIRATION DATE',
																								  self.corp_term_exist_cd = 'P' => 'PERPETUAL',
																									''
																								 );
				self.corp_orig_org_structure_cd 	 := if(corp2.t2u(l.EntityType) in ent_types, corp2.t2u(l.EntityType),'');				
				self.corp_orig_org_structure_desc	 := Corp2_Raw_MI.Functions.CorpOrigOrgStructureCD(l.EntityType);
				self.corp_forgn_state_cd 					 := if(corp2.t2u(l.FormedInState) not in [state_origin,''],Corp2_Raw_MI.Functions.CorpForgnStateCD(l.FormedInState),'');
				self.corp_forgn_state_desc 				 := if(corp2.t2u(l.FormedInState) not in [state_origin,''],Corp2_Raw_MI.Functions.CorpForgnStateDesc(l.FormedInState),'');
				self.corp_forgn_date 							 := if(corp2.t2u(l.FormedInState) not in [state_origin,''],Corp2_Mapping.fValidateDate(l.FormedOn,'CCYYMMDD').PastDate,'');
        self.corp_foreign_domestic_ind		 := Corp2_Raw_MI.Functions.ForeignDomesticInd(self.corp_orig_org_structure_desc);	
				self.corp_for_profit_ind					 := map(corp2.t2u(self.corp_orig_org_structure_desc) in ['DOMESTIC PROFIT CORPORATION','FOREIGN PROFIT CORPORATION']       => 'Y',
																									corp2.t2u(self.corp_orig_org_structure_desc) in ['DOMESTIC NONPROFIT CORPORATION','FOREIGN NONPROFIT CORPORATION'] => 'N',
																									''
																								 );
        RAName                             := if(regexfind(Bad_RA_Names,corp2.t2u(l.AgentName)),'',regexreplace(RApattern,corp2.t2u(l.AgentName),''));
				self.corp_ra_full_name 						 := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,RAName).BusinessName;	
				RACountry_str                      := Corp2_Raw_MI.Functions.Country_Description(l.AgentCountry);
				self.corp_ra_address_line1				 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.AgentAddr1,l.AgentAddr2,l.AgentCity,l.AgentState,l.AgentPostalCode,RACountry_str).AddressLine1;
				self.corp_ra_address_line2			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.AgentAddr1,l.AgentAddr2,l.AgentCity,l.AgentState,l.AgentPostalCode,RACountry_str).AddressLine2;
				self.corp_ra_address_line3				 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.AgentAddr1,l.AgentAddr2,l.AgentCity,l.AgentState,l.AgentPostalCode,RACountry_str).AddressLine3;
				self.corp_ra_address_type_cd			 := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.AgentAddr1,l.AgentAddr2,l.AgentCity,l.AgentState,l.AgentPostalCode).ifAddressExists,'R','');
				self.corp_ra_address_type_desc 		 := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.AgentAddr1,l.AgentAddr2,l.AgentCity,l.AgentState,l.AgentPostalCode).ifAddressExists,'REGISTERED OFFICE','');		
				self.ra_prep_addr_line1        		 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.AgentAddr1,l.AgentAddr2,l.AgentCity,l.AgentState,l.AgentPostalCode).PrepAddrLine1;
				self.ra_prep_addr_last_line    		 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.AgentAddr1,l.AgentAddr2,l.AgentCity,l.AgentState,l.AgentPostalCode).PrepAddrLastLine;
				self.corp_addl_info                := if(corp2.t2u(l.LegacyID) <> '', 'OLD CHARTER NUMBER: ' + corp2.t2u(l.LegacyID),'');
        self.corp_country_of_formation     := if(corp2.t2u(l.FormedInCountry) not in [state_origin,''], Corp2_Raw_MI.Functions.Country_Description(l.FormedInCountry), '');
				self.corp_inc_county 							 := Corp2_Raw_MI.Functions.CorpAgentCountyStr(l.County1,l.County2,l.County3);
				self.recordorigin									 := 'C';
				self 															 := [];
		end;

		MapLP := project(ds_LP, LPMasterTransform(LEFT)) : independent;
		
		//******************************************************************
		// LIMITED LIABILITY CORPORATION (LLC) DATA
		//******************************************************************
		Corp2_Mapping.LayoutsCommon.Main LLCMasterTransform(Corp2_Raw_MI.Layouts.LLCLayoutIn l):= transform,
	    skip(corp2.t2u(l.EntityName) in Bad_Names)
				self.dt_vendor_first_reported			 := (integer)fileDate;
				self.dt_vendor_last_reported			 := (integer)fileDate;
				self.dt_first_seen								 := (integer)fileDate;
				self.dt_last_seen									 := (integer)fileDate;
				self.corp_ra_dt_first_seen				 := (integer)fileDate;
				self.corp_ra_dt_last_seen					 := (integer)fileDate;			
				self.corp_key											 := state_fips + '-' + corp2.t2u(l.EntityID);
				self.corp_vendor									 := state_fips;
				self.corp_state_origin						 := state_origin;			
				self.corp_process_date						 := fileDate;		
				self.corp_orig_sos_charter_nbr   	 := corp2.t2u(l.EntityID);
				self.corp_legal_name             	 := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.EntityName).BusinessName;				
				self.corp_ln_name_type_cd   			 := '01';
				self.corp_ln_name_type_desc 			 := 'LEGAL';
				MailingCountry_str                 := Corp2_Raw_MI.Functions.Country_Description(l.MailingCountry);
				self.corp_address1_type_cd       	 := if(corp2.t2u(l.MailingAddr1) not in Bad_Addrs and corp2_mapping.faddressexists(state_origin,state_desc,l.MailingAddr1,l.MailingAddr2,l.MailingCity,l.MailingState,l.MailingPostalCode,MailingCountry_str).ifaddressexists,'RM','');
				self.corp_address1_type_desc     	 := if(corp2.t2u(l.MailingAddr1) not in Bad_Addrs and corp2_mapping.faddressexists(state_origin,state_desc,l.MailingAddr1,l.MailingAddr2,l.MailingCity,l.MailingState,l.MailingPostalCode,MailingCountry_str).ifaddressexists,'REGISTERED OFFICE MAILING','');
				self.corp_address1_line1         	 := if(corp2.t2u(l.MailingAddr1) not in Bad_Addrs,corp2_mapping.fcleanaddress(state_origin,state_desc,l.MailingAddr1,l.MailingAddr2,l.MailingCity,l.MailingState,l.MailingPostalCode,MailingCountry_str).AddressLine1,'');
				self.corp_address1_line2         	 := if(corp2.t2u(l.MailingAddr1) not in Bad_Addrs,corp2_mapping.fcleanaddress(state_origin,state_desc,l.MailingAddr1,l.MailingAddr2,l.MailingCity,l.MailingState,l.MailingPostalCode,MailingCountry_str).AddressLine2,'');
				self.corp_address1_line3           := if(corp2.t2u(l.MailingAddr1) not in Bad_Addrs,corp2_mapping.fcleanaddress(state_origin,state_desc,l.MailingAddr1,l.MailingAddr2,l.MailingCity,l.MailingState,l.MailingPostalCode,MailingCountry_str).AddressLine3,'');
				self.corp_prep_addr1_line1       	 := if(corp2.t2u(l.MailingAddr1) not in Bad_Addrs,corp2_mapping.fcleanaddress(state_origin,state_desc,l.MailingAddr1,l.MailingAddr2,l.MailingCity,l.MailingState,l.MailingPostalCode,MailingCountry_str).PrepAddrLine1,'');
				self.corp_prep_addr1_last_line     := if(corp2.t2u(l.MailingAddr1) not in Bad_Addrs,corp2_mapping.fcleanaddress(state_origin,state_desc,l.MailingAddr1,l.MailingAddr2,l.MailingCity,l.MailingState,l.MailingPostalCode,MailingCountry_str).PrepAddrLastLine,'');
				self.corp_status_cd 							 := corp2.t2u(l.Active);
				self.corp_status_desc 						 := map(corp2.t2u(l.Active) = 'Y' => 'ACTIVE',
																								  corp2.t2u(l.Active) = 'N' => 'INACTIVE',
																								  ''
																								 );
				self.corp_status_date 	           := Corp2_Mapping.fValidateDate(l.InactiveDate,'CCYYMMDD').PastDate;
				self.corp_status_comment					 := if(corp2.t2u(l.Active) = 'N',Corp2_Raw_MI.Functions.CorpStatusComment(l.InactiveType),'');
				self.corp_inc_state 							 := state_origin;
				self.corp_inc_date 								 := if(corp2.t2u(l.OrganizedInState) in [state_origin,''],Corp2_Mapping.fValidateDate(l.FormationDate,'CCYYMMDD').PastDate,'');
				self.corp_term_exist_cd 					 := map(corp2.t2u(l.Perpetual) = 'Y'																			         => 'P',
				                                          Corp2_Mapping.fValidateDate(l.TermExpiration,'CCYYMMDD').GeneralDate <> '' => 'D',
																								  ''
																								 );
				self.corp_term_exist_exp 					 := Corp2_Mapping.fValidateDate(l.TermExpiration,'CCYYMMDD').GeneralDate;
				self.corp_term_exist_desc 			   := map(self.corp_term_exist_cd = 'D' => 'EXPIRATION DATE',
																									self.corp_term_exist_cd = 'P' => 'PERPETUAL',
																									''
																								 );		
				self.corp_orig_org_structure_cd 	 := if(corp2.t2u(l.EntityType) in ent_types, corp2.t2u(l.EntityType),'');			
				self.corp_orig_org_structure_desc	 := Corp2_Raw_MI.Functions.CorpOrigOrgStructureCD(l.EntityType);
				self.corp_foreign_domestic_ind		 := Corp2_Raw_MI.Functions.ForeignDomesticInd(self.corp_orig_org_structure_desc);				
				self.corp_forgn_state_cd 					 := if(corp2.t2u(l.OrganizedInState) not in [state_origin,''],Corp2_Raw_MI.Functions.CorpForgnStateCD(l.OrganizedInState),'');
				self.corp_forgn_state_desc 				 := if(corp2.t2u(l.OrganizedInState) not in [state_origin,''],Corp2_Raw_MI.Functions.CorpForgnStateDesc(l.OrganizedInState),'');
				self.corp_forgn_date 							 := if(corp2.t2u(l.OrganizedInState) not in [state_origin,''],Corp2_Mapping.fValidateDate(l.FormationDate,'CCYYMMDD').PastDate,'');
				self.corp_for_profit_ind					 := map(corp2.t2u(self.corp_orig_org_structure_desc) in ['DOMESTIC PROFIT CORPORATION','FOREIGN PROFIT CORPORATION']       => 'Y',
																									corp2.t2u(self.corp_orig_org_structure_desc) in ['DOMESTIC NONPROFIT CORPORATION','FOREIGN NONPROFIT CORPORATION'] => 'N',
																									''
																								 );
				//Purpose being mapped in this field because Corp_Purpose does not display yet																				 
				self.corp_entity_desc			         := if(corp2.t2u(l.Purpose) = 'APC','ALL PURPOSE CLAUSE',corp2.t2u(l.Purpose));
				self.corp_acts 										 := if(regexfind(Acts_pattern,l.Act1) and l.Act1 <> '999-9999',corp2.t2u(l.Act1),'');
				RAName                             := if(regexfind(Bad_RA_Names,corp2.t2u(l.AgentName)),'',regexreplace(RApattern,corp2.t2u(l.AgentName),''));
				self.corp_ra_full_name 						 := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,RAName).BusinessName;	
				RACountry_str                      := Corp2_Raw_MI.Functions.Country_Description(l.AgentCountry);
				self.corp_ra_address_line1				 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.AgentAddr1,l.AgentAddr2,l.AgentCity,l.AgentState,l.AgentPostalCode,RACountry_str).AddressLine1;
				self.corp_ra_address_line2			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.AgentAddr1,l.AgentAddr2,l.AgentCity,l.AgentState,l.AgentPostalCode,RACountry_str).AddressLine2;
				self.corp_ra_address_line3				 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.AgentAddr1,l.AgentAddr2,l.AgentCity,l.AgentState,l.AgentPostalCode,RACountry_str).AddressLine3;
				self.corp_ra_address_type_cd			 := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.AgentAddr1,l.AgentAddr2,l.AgentCity,l.AgentState,l.AgentPostalCode).ifAddressExists,'R','');
				self.corp_ra_address_type_desc 		 := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.AgentAddr1,l.AgentAddr2,l.AgentCity,l.AgentState,l.AgentPostalCode).ifAddressExists,'REGISTERED OFFICE','');		
				self.ra_prep_addr_line1        		 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.AgentAddr1,l.AgentAddr2,l.AgentCity,l.AgentState,l.AgentPostalCode).PrepAddrLine1;
				self.ra_prep_addr_last_line    		 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.AgentAddr1,l.AgentAddr2,l.AgentCity,l.AgentState,l.AgentPostalCode).PrepAddrLastLine;
				self.corp_acts2										 := if(regexfind(Acts_pattern,l.Act2) and l.Act2 <> '999-9999',corp2.t2u(l.Act2),'');
				self.corp_acts3										 := if(regexfind(Acts_pattern,l.Act3) and l.Act3 <> '999-9999',corp2.t2u(l.Act3),'');
				self.corp_purpose									 := if(corp2.t2u(l.Purpose) = 'APC','ALL PURPOSE CLAUSE',corp2.t2u(l.Purpose));
				self.corp_addl_info                := if(corp2.t2u(l.LegacyID) <> '', 'OLD CHARTER NUMBER: ' + corp2.t2u(l.LegacyID),'');
        self.corp_country_of_formation     := if(corp2.t2u(l.OrganizedInCountry) not in [state_origin,''], Corp2_Raw_MI.Functions.Country_Description(l.OrganizedInCountry), '');
        self.corp_management_desc          := map(corp2.t2u(l.ManagedBy) = 'M'  => 'MANAGER',
																									corp2.t2u(l.ManagedBy) = 'B'  => 'MEMBERS',
																									''
																								 );				
				self.recordorigin									 := 'C';
				self 															 := [];
		end;

		MapLLC := project(ds_LLC, LLCMasterTransform(LEFT)) : independent;
		
		//******************************************************************
		// PROCESS NAME REGISTRATION DATA
		//******************************************************************
		Corp2_Mapping.LayoutsCommon.Main NameRegMasterTransform(Corp2_Raw_MI.Layouts.NameRegLayoutIn l, integer cnt):= transform,
	    skip(corp2.t2u(l.Name) in Bad_Names)
				self.dt_vendor_first_reported			         := (integer)fileDate;
				self.dt_vendor_last_reported			         := (integer)fileDate;
				self.dt_first_seen								         := (integer)fileDate;
				self.dt_last_seen									         := (integer)fileDate;
				self.corp_ra_dt_first_seen				         := (integer)fileDate;
				self.corp_ra_dt_last_seen					         := (integer)fileDate;			
				self.corp_key											         := state_fips + '-' + corp2.t2u(l.EntityID);
				self.corp_vendor									         := state_fips;
				self.corp_state_origin						         := state_origin;			
				self.corp_process_date						         := fileDate;		
				self.corp_orig_sos_charter_nbr   	         := corp2.t2u(l.EntityID);
				self.corp_legal_name             	         := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.Name).BusinessName;				
				self.corp_ln_name_type_cd   			         := '09';
				self.corp_ln_name_type_desc 			         := 'REGISTRATION';
				Country_str                                := Corp2_Raw_MI.Functions.Country_Description(l.Country);
				self.corp_address1_type_cd       	         := if(corp2.t2u(l.Addr1) not in Bad_Addrs and corp2_mapping.faddressexists(state_origin,state_desc,l.Addr1,l.Addr2,l.City,l.State,l.PostalCode,Country_str).ifaddressexists,'M','');
				self.corp_address1_type_desc     	         := if(corp2.t2u(l.Addr1) not in Bad_Addrs and corp2_mapping.faddressexists(state_origin,state_desc,l.Addr1,l.Addr2,l.City,l.State,l.PostalCode,Country_str).ifaddressexists,'MAILING','');
				self.corp_address1_line1         	         := if(corp2.t2u(l.Addr1) not in Bad_Addrs,corp2_mapping.fcleanaddress(state_origin,state_desc,l.Addr1,l.Addr2,l.City,l.State,l.PostalCode,Country_str).AddressLine1,'');
				self.corp_address1_line2         	         := if(corp2.t2u(l.Addr1) not in Bad_Addrs,corp2_mapping.fcleanaddress(state_origin,state_desc,l.Addr1,l.Addr2,l.City,l.State,l.PostalCode,Country_str).AddressLine2,'');
				self.corp_address1_line3                   := if(corp2.t2u(l.Addr1) not in Bad_Addrs,corp2_mapping.fcleanaddress(state_origin,state_desc,l.Addr1,l.Addr2,l.City,l.State,l.PostalCode,Country_str).AddressLine3,'');
				self.corp_prep_addr1_line1                 := if(corp2.t2u(l.Addr1) not in Bad_Addrs,corp2_mapping.fcleanaddress(state_origin,state_desc,l.Addr1,l.Addr2,l.City,l.State,l.PostalCode,Country_str).PrepAddrLine1,'');
				self.corp_prep_addr1_last_line             := if(corp2.t2u(l.Addr1) not in Bad_Addrs,corp2_mapping.fcleanaddress(state_origin,state_desc,l.Addr1,l.Addr2,l.City,l.State,l.PostalCode,Country_str).PrepAddrLastLine,'');
				self.corp_status_cd 							         := corp2.t2u(l.Active);
				self.corp_status_desc 					           := map(corp2.t2u(l.Active) = 'Y' => 'ACTIVE',
																												  corp2.t2u(l.Active) = 'N' => 'INACTIVE',
																													'');
				self.corp_inc_state 							         := state_origin;
				self.corp_inc_date 								         := if(corp2.t2u(l.IncorporatedInState) in [state_origin,''],Corp2_Mapping.fValidateDate(l.FiledOn,'CCYYMMDD').PastDate,'');
        self.corp_term_exist_exp 					         := Corp2_Mapping.fValidateDate(l.ExpiresOn,'CCYYMMDD').GeneralDate;				
				self.corp_term_exist_cd 					         := if(self.corp_term_exist_exp = '','','D');
				self.corp_term_exist_desc 			           := if(self.corp_term_exist_exp = '','','EXPIRATION DATE');
				self.corp_filing_date                      := choose(cnt,Corp2_Mapping.fValidateDate(l.IncDate,'CCYYMMDD').PastDate,Corp2_Mapping.fValidateDate(l.RenewedOn,'CCYYMMDD').PastDate) ;
				self.corp_filing_desc                      := choose(cnt,'HOME STATE REGISTRATION','RENEWED DATE');
				self.corp_forgn_state_cd 					         := if(corp2.t2u(l.IncorporatedInState) not in [state_origin,''],Corp2_Raw_MI.Functions.CorpForgnStateCD(l.IncorporatedInState),'');
				self.corp_forgn_state_desc 				         := if(corp2.t2u(l.IncorporatedInState) not in [state_origin,''],Corp2_Raw_MI.Functions.CorpForgnStateDesc(l.IncorporatedInState),'');
				self.corp_forgn_date 							         := if(corp2.t2u(l.IncorporatedInState) not in [state_origin,''],Corp2_Mapping.fValidateDate(l.FiledOn,'CCYYMMDD').PastDate,'');
				self.corp_country_of_formation             := if(corp2.t2u(l.IncorporatedInCountry) not in [state_origin,''], Corp2_Raw_MI.Functions.Country_Description(l.IncorporatedInCountry), '');
        self.corp_name_reservation_expiration_date := Corp2_Mapping.fValidateDate(l.ExpiresOn,'CCYYMMDD').GeneralDate;					
        self.corp_name_status_desc                 := map(corp2.t2u(l.Active) = 'Y' => 'ACTIVE',
																													corp2.t2u(l.Active) = 'N' => 'INACTIVE',
																												  '');				
				self.recordorigin									         := 'C';
				self 															         := [];
		end;

		MapNameRegistration  := normalize(ds_NameRegistration, if(Corp2_Mapping.fValidateDate(left.RenewedOn,'CCYYMMDD').GeneralDate<>'',2,1),NameRegMasterTransform(left,counter),local);
		
		//******************************************************************
		// PROCESSS ASSUMED NAME DATA
		//******************************************************************
		Corp2_Mapping.LayoutsCommon.Main AssumedNameTransform(Corp2_Raw_MI.Layouts.AssumedNamedLayoutIn l, integer cnt):= transform,
	    skip(corp2.t2u(l.AssumedName) in Bad_Names)
				self.dt_vendor_first_reported			:= (integer)fileDate;
				self.dt_vendor_last_reported			:= (integer)fileDate;
				self.dt_first_seen								:= (integer)fileDate;
				self.dt_last_seen									:= (integer)fileDate;
				self.corp_ra_dt_first_seen				:= (integer)fileDate;
				self.corp_ra_dt_last_seen					:= (integer)fileDate;			
				self.corp_key											:= state_fips + '-' + corp2.t2u(l.EntityID);
				self.corp_vendor									:= state_fips;
				self.corp_state_origin						:= state_origin;			
				self.corp_process_date						:= fileDate;		
				self.corp_orig_sos_charter_nbr   	:= corp2.t2u(l.EntityID);
				self.corp_legal_name             	:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.AssumedName).BusinessName;		
				self.corp_inc_state 							:= state_origin;
				self.corp_ln_name_type_cd   			:= '06';
				self.corp_ln_name_type_desc 			:= 'ASSUMED';
				self.corp_name_status_date        := Corp2_Mapping.fValidateDate(l.RenewedOn,'CCYYMMDD').PastDate;
				self.corp_name_effective_date     := Corp2_Mapping.fValidateDate(l.FiledOn,'CCYYMMDD').PastDate;
				self.corp_filing_date             := choose(cnt,Corp2_Mapping.fValidateDate(l.FiledOn,'CCYYMMDD').PastDate,Corp2_Mapping.fValidateDate(l.RenewedOn,'CCYYMMDD').PastDate) ;
				self.corp_filing_desc             := choose(cnt,'ASSUMED NAME FILING DATE','RENEWED DATE');
				self.corp_status_cd 							:= corp2.t2u(l.Active);
				self.corp_status_desc 						:= map(corp2.t2u(l.Active) = 'Y' => 'ACTIVE',
																								 corp2.t2u(l.Active) = 'N' => 'INACTIVE',
																								 ''
																								);
 				self.corp_term_exist_exp 					:= Corp2_Mapping.fValidateDate(l.ExpiresOn,'CCYYMMDD').GeneralDate;
			
				self.corp_term_exist_cd 					:= if(self.corp_term_exist_exp = '','','D');
				self.corp_term_exist_desc 			  := if(self.corp_term_exist_exp = '','','EXPIRATION DATE');
        self.corp_name_status_desc        := map(corp2.t2u(l.Active) = 'Y' => 'ACTIVE',
																					 		   corp2.t2u(l.Active) = 'N' => 'INACTIVE',
																								 '');								
				self.recordorigin									:= 'C';
				self 															:= [];
		end;

		MapAssumedName  := normalize(ds_AssumedName, if(Corp2_Mapping.fValidateDate(left.RenewedOn,'CCYYMMDD').GeneralDate<>'',2,1),AssumedNameTransform(left,counter),local);
		 
		All_Corp := MapCorp + MapLLC + MapLP + MapNameRegistration + MapAssumedName : independent;
		
		//********************************************************************
		// PROCESS CORPORATE/LLC/LP/NAME REGISTRATION CONTACT (CONT) DATA
		//*******************************************************************
		Corp_NoAssumedName		:= MapCorp + MapLLC + MapLP + MapNameRegistration : independent;
		d_Corp_NoAssumedName 	:= distribute(Corp_NoAssumedName,hash(corp_orig_sos_charter_nbr));

		//The following join is done to pick up the corp_legal_name that doesn't
		//exist in the GeneralPartnerFile.
		//Note: MapAssumedName is not to be used to extract the legal name.
		CorpGeneralPartner		:= join(d_Corp_NoAssumedName, ds_GeneralPartner,
																	corp2.t2u(left.corp_orig_sos_charter_nbr)  = corp2.t2u(right.entityid),
																	transform(Corp2_Raw_MI.Layouts.Temp_CorpGeneralPartner,
																						self.corp_legal_name 					:= left.corp_legal_name;
																						self								 					:= right;
																					 ),
																	right outer,
																	local
																 );
	
		Corp2_Mapping.LayoutsCommon.Main GeneralPartnerTransform(Corp2_Raw_MI.Layouts.Temp_CorpGeneralPartner L) := transform,
		  skip(corp2.t2u(l.Name) in Bad_Names)
				self.dt_vendor_first_reported		 := (integer)fileDate;
				self.dt_vendor_last_reported		 := (integer)fileDate;
				self.dt_first_seen							 := (integer)fileDate;
				self.dt_last_seen								 := (integer)fileDate;
				self.corp_ra_dt_first_seen			 := (integer)fileDate;
				self.corp_ra_dt_last_seen				 := (integer)fileDate;			
				self.corp_key										 := state_fips + '-' + corp2.t2u(l.EntityId);
				self.corp_vendor								 := state_fips;
				self.corp_state_origin					 := state_origin;
				self.corp_process_date					 := fileDate;
				self.corp_orig_sos_charter_nbr   := corp2.t2u(l.EntityId);
				self.corp_legal_name             := corp2.t2u(l.corp_legal_name);
				self.corp_inc_state 						 := state_origin;				
				self.cont_full_name              := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.Name).BusinessName;
			  self.cont_title1_desc						 := 'GENERAL PARTNER';
			  self.cont_country                := Corp2_Raw_MI.Functions.Country_Description(l.country);
				self.cont_address_type_cd        := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.addr1,l.addr2,l.city,l.state,l.postalcode,self.cont_country ).ifAddressExists,'T','');
        self.cont_address_type_desc      := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.addr1,l.addr2,l.city,l.state,l.postalcode,self.cont_country ).ifAddressExists,'CONTACT','');
			  self.cont_address_line1					 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.state,l.postalcode,self.cont_country ).AddressLine1;
			  self.cont_address_line2					 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.state,l.postalcode,self.cont_country ).AddressLine2;
			  self.cont_address_line3					 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.state,l.postalcode,self.cont_country ).AddressLine3;
			  self.cont_prep_addr_line1				 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.state,l.postalcode,self.cont_country ).PrepAddrLine1;
			  self.cont_prep_addr_last_line		 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.addr1,l.addr2,l.city,l.state,l.postalcode,self.cont_country ).PrepAddrLastLine;
				self.recordorigin								 := 'T';																													 
			  self 														 := [];
		end;

		MapContacts := project(CorpGeneralPartner,GeneralPartnerTransform(LEFT));
		MapMain     := dedup(sort(distribute(All_Corp + MapContacts,hash(corp_orig_sos_charter_nbr)),record,local),record,local) : independent;
				
		//********************************************************************	
		//	PROCESS HISTORY AR DATA
		//********************************************************************
																		 
		Corp2_Mapping.LayoutsCommon.AR ARYearTransform(Corp2_Raw_MI.Layouts.CorporationLayoutIn L) := transform,
		  skip(not ut.isnumeric(l.LastAnnRptYear) or length(corp2.t2u(l.LastAnnRptYear)) <> 4 or regexfind('-',l.LastAnnRptYear))
				self.corp_key															:= state_fips + '-' + corp2.t2u(l.EntityId);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;		
				self.corp_sos_charter_nbr        					:= corp2.t2u(l.EntityId);
				self.ar_year                              := corp2.t2u(l.LastAnnRptYear);
			  self.ar_comment                           := 'ANNUAL REPORT FILED';
				self 																			:= [];
		end;		
		
		MapARYear	:= project(ds_CorpMaster,ARYearTransform(LEFT));
		
		Corp2_Mapping.LayoutsCommon.AR ARTransform(Corp2_Raw_MI.Layouts.HistoryLayoutIn L) := transform,
		  skip(corp2.t2u(l.HistoryCode) <> '18')
				self.corp_key															:= state_fips + '-' + corp2.t2u(l.EntityId);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;		
				self.corp_sos_charter_nbr        					:= corp2.t2u(l.EntityId);
			  self.ar_type 															:= corp2.t2u(l.ChangeDesc);
			  self.ar_filed_dt 													:= Corp2_Mapping.fValidateDate(l.FiledOn,'CCYYMMDD').PastDate;
			  self.ar_comment                           := 'ANNUAL REPORT FILED';
				self 																			:= [];
		end;
		
		MapARDates	:= project(ds_History,ARTransform(LEFT));
		
		All_AR := MapARYear + MapARDates;
		MapAR  := dedup(sort(distribute(All_AR,hash(corp_key)),record,local),record,local) : independent;
		
		//********************************************************************
		// PROCESS HISTORY EVENT DATA
		//******************************************************************
		Corp2_Mapping.LayoutsCommon.Events EventTransform(Corp2_Raw_MI.Layouts.HistoryLayoutIn L) := transform,
	    skip(corp2.t2u(l.HistoryCode) not in history_event_codes)
				self.corp_key															:= state_fips + '-' + corp2.t2u(l.EntityId);
				self.corp_vendor													:= state_fips;
				self.corp_state_origin										:= state_origin;			
				self.corp_process_date										:= fileDate;		
				self.corp_sos_charter_nbr        					:= corp2.t2u(l.EntityId);
			  self.event_filing_date 										:= Corp2_Mapping.fValidateDate(l.FiledOn,'CCYYMMDD').PastDate;
			  self.event_date_type_cd 									:= 'FIL';
			  self.event_date_type_desc 								:= 'FILING';
			  self.event_filing_cd 											:= corp2.t2u(l.HistoryCode);
			  self.event_filing_desc 										:= Corp2_Raw_MI.Functions.FilingDesc(l.HistoryCode);
				self.event_desc 													:= corp2.t2u(l.ChangeDesc);
			  self 																			:= [];
		end;

		pEvent   := project(ds_History,EventTransform(LEFT));
		MapEvent := dedup(sort(pEvent,record),record) : independent;
		
		//********************************************************************
		// PROCESS HISTORY STOCK DATA
		//********************************************************************
		CorpStockHistory		:= join(ds_CorpMaster, ds_History,
																	corp2.t2u(left.entityid)  = corp2.t2u(right.entityid),
																	transform(Corp2_Raw_MI.Layouts.Temp_CorpStkHistory,
																						self.totalshares 	:= left.TotalShares;
																						self				    	:= right;
																					 ),
																	right outer,
																	local
																 );
																 
		Corp2_Mapping.LayoutsCommon.Stock StockTransform(Corp2_Raw_MI.Layouts.Temp_CorpStkHistory L) := transform,
		  skip(corp2.t2u(l.HistoryCode) not in ['9','23'] or (integer)l.totalshares = 0)
				self.corp_key									:= state_fips + '-' + corp2.t2u(l.EntityId);
				self.corp_vendor							:= state_fips;
				self.corp_state_origin				:= state_origin;			
				self.corp_process_date				:= fileDate;		
				self.corp_sos_charter_nbr     := corp2.t2u(l.EntityId);
				self.stock_authorized_nbr 		:= (string)(integer)l.totalshares;
			  self.stock_addl_info 					:= Corp2_Raw_MI.Functions.FilingDesc(l.HistoryCode);
			  self 													:= [];
		end;

		pStock	 := project(CorpStockHistory, StockTransform(LEFT));	
		MapStock := dedup(sort(pStock,record),record) : independent;
														 
	//********************************************************************
  // SCRUB AR 
  //********************************************************************	
		AR_F := MapAR;
		AR_S := Scrubs_Corp2_Mapping_MI_AR.Scrubs;				// Scrubs module
		AR_N := AR_S.FromNone(AR_F); 											// Generate the error flags
		AR_T := AR_S.FromBits(AR_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		AR_U := AR_S.FromExpanded(AR_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		AR_ErrorSummary			 	 := output(AR_U.SummaryStats, named('AR_ErrorSummary_MI'+filedate));
		AR_ScrubErrorReport 	 := output(choosen(AR_U.AllErrors, 1000), named('AR_ScrubErrorReport_MI'+filedate));
		AR_SomeErrorValues		 := output(choosen(AR_U.BadValues, 1000), named('AR_SomeErrorValues_MI'+filedate));
		AR_IsScrubErrors		 	 := IF(count(AR_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		AR_OrbitStats				 	 := AR_U.OrbitStats();
		
		//Outputs files
		AR_CreateBitMaps			 := output(AR_N.BitmapInfile,,'~thor_data::corp_mi_ar_scrubs_bits',overwrite,compressed);	//long term storage
		AR_TranslateBitMap		 := output(AR_T);

		//Submits Profile's stats to Orbit
		AR_SubmitStats 			   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MI_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_MI_AR').SubmitStats;
		AR_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MI_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_MI_AR').CompareToProfile_with_Examples;

		AR_ScrubsAlert				 := AR_ScrubsWithExamples(RejectWarning = 'Y');
		AR_ScrubsAttachment	   := Scrubs.fn_email_attachment(AR_ScrubsAlert);
		AR_MailFile					   := FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																															,'Scrubs CorpAR_MI Report' //subject
																															,'Scrubs CorpAR_MI Report' //body
																															,(data)AR_ScrubsAttachment
																															,'text/csv'
																															,'CorpMIARScrubsReport.csv'
																															,
																															,
																															,corp2.Email_Notification_Lists.spray);

		AR_BadRecords				 := AR_N.ExpandedInFile(	
																								corp_key_Invalid							  			<> 0 or
																								corp_vendor_Invalid							  		<> 0 or
																								corp_state_origin_Invalid							<> 0 or
																								corp_process_date_Invalid							<> 0 or
																								corp_sos_charter_nbr_Invalid					<> 0 or
																								ar_year_Invalid							  				<> 0 or
																								ar_filed_dt_Invalid							  		<> 0  
																							 );

		AR_GoodRecords			 := AR_N.ExpandedInFile(
																								corp_key_Invalid							  			= 0 and
																								corp_vendor_Invalid							  		= 0 and
																								corp_state_origin_Invalid							= 0 and
																								corp_process_date_Invalid							= 0 and
																								corp_sos_charter_nbr_Invalid					= 0 and
																								ar_year_Invalid							  				= 0 and
																								ar_filed_dt_Invalid							  		= 0  
																								);

		AR_FailBuild					 := if(count(AR_GoodRecords) = 0,true,false);

		AR_ApprovedRecords		 := project(AR_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.AR,self := left;));


		AR_ALL								 := sequential(IF(count(AR_BadRecords) <> 0
																								 ,IF (poverwrite
																										 ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,overwrite,__compressed__)
																										 ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,__compressed__)
																										 )
																								 )
																						  ,output(AR_ScrubsWithExamples, ALL, NAMED('CorpARMIScrubsReportWithExamples'+filedate))
																							//Send Alerts if Scrubs exceeds thresholds
																							,IF(COUNT(AR_ScrubsAlert) > 0, AR_MailFile, OUTPUT('CORP2_MAPPING.MI - No "AR" Corp Scrubs Alerts'))
																							,AR_ErrorSummary
																							,AR_ScrubErrorReport
																							,AR_SomeErrorValues			
																							,AR_SubmitStats
																					);

	//********************************************************************
  // SCRUB EVENT
  //********************************************************************	
		Event_F := MapEvent;
		Event_S := Scrubs_Corp2_Mapping_MI_Event.Scrubs;						// Scrubs module
		Event_N := Event_S.FromNone(Event_F); 											// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module
		
		//Outputs reports
		Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_MI'+filedate));
		Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_MI'+filedate));
		Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_MI'+filedate));
		Event_IsScrubErrors		 		:= IF(count(Event_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Event_OrbitStats					:= Event_U.OrbitStats();
		
		//Outputs files
		Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_mi_event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap			:= output(Event_T);

		//Submits Profile's stats to Orbit
		Event_SubmitStats 			  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MI_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_MI_Event').SubmitStats;
		Event_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MI_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_MI_Event').CompareToProfile_with_Examples;

		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpEvent_MI Report' //subject
																																 ,'Scrubs CorpEvent_MI Report' //body
																																 ,(data)Event_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpMIEventScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray);

		Event_BadRecords				 	:= Event_N.ExpandedInFile(	
																												corp_key_Invalid							  			<> 0 or
																												corp_vendor_Invalid							  		<> 0 or
																												corp_state_origin_Invalid							<> 0 or
																												corp_process_date_Invalid							<> 0 or
																												corp_sos_charter_nbr_Invalid					<> 0 or
																												event_filing_date_Invalid							<> 0 or
																												event_date_type_cd_Invalid						<> 0 or
																												event_date_type_desc_Invalid					<> 0
																											 );
																										 																	
		Event_GoodRecords					:= Event_N.ExpandedInFile(	
																												corp_key_Invalid							  			= 0 and
																												corp_vendor_Invalid							  		= 0 and
																												corp_state_origin_Invalid							= 0 and
																												corp_process_date_Invalid							= 0 and
																												corp_sos_charter_nbr_Invalid					= 0 and
																												event_filing_date_Invalid							= 0 and
																												event_date_type_cd_Invalid						= 0 and
																												event_date_type_desc_Invalid					= 0																												
																											);

		Event_FailBuild					  := if(count(Event_GoodRecords) = 0,true,false);

		Event_ApprovedRecords			:= project(Event_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Events,self := left));
		

		Event_ALL									:= sequential(IF(count(Event_BadRecords) <> 0
																											,IF (poverwrite
																													,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+state_origin,overwrite,__compressed__)
																													,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+state_origin,__compressed__)
																													)
																											)
																									 ,output(Event_ScrubsWithExamples, ALL, NAMED('CorpEventMIScrubsReportWithExamples'+filedate))
																									 //Send Alerts if Scrubs exceeds thresholds
																									 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_MailFile, OUTPUT('CORP2_MAPPING.MI - No "EVENT" Corp Scrubs Alerts'))
																									 ,Event_ErrorSummary
																									 ,Event_ScrubErrorReport
																									 ,Event_SomeErrorValues		
																									 ,Event_SubmitStats
																								);

	//********************************************************************
  // SCRUB MAIN
  //********************************************************************	
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_MI_Main.Scrubs;					// Scrubs module
		Main_N := Main_S.FromNone(Main_F); 											// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_MI'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_MI'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_MI'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_mi_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

		//Submits Profile's stats to Orbit
		Main_SubmitStats 			    := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MI_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_MI_Main').SubmitStats;
		Main_ScrubsWithExamples   := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MI_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_MI_Main').CompareToProfile_with_Examples;

		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile							:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpMain_MI Report' //subject
																																 ,'Scrubs CorpMain_MI Report' //body
																																 ,(data)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpMIMainScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray);

		Main_BadRecords						:= Main_N.ExpandedInFile(	
																											 dt_vendor_first_reported_Invalid 			<> 0 or
																											 dt_vendor_last_reported_Invalid 				<> 0 or
																											 dt_first_seen_Invalid 									<> 0 or
																											 dt_last_seen_Invalid 									<> 0 or
																											 corp_ra_dt_first_seen_Invalid 					<> 0 or
																											 corp_ra_dt_last_seen_Invalid 					<> 0 or
																											 corp_key_Invalid 											<> 0 or
																											 corp_vendor_Invalid 										<> 0 or
																											 corp_state_origin_Invalid 							<> 0 or
																											 corp_process_date_Invalid 							<> 0 or
																											 corp_orig_sos_charter_nbr_Invalid 			<> 0 or
																											 corp_legal_name_Invalid 								<> 0 or
																											 corp_ln_name_type_cd_Invalid 					<> 0 or
																											 corp_ln_name_type_desc_invalid 				<> 0 or																											 
																											 corp_address1_line3_Invalid 						<> 0 or
																											 corp_status_comment_Invalid 						<> 0 or
																											 corp_inc_state_Invalid 								<> 0 or
																											 corp_inc_date_Invalid 									<> 0 or
																											 corp_forgn_state_cd_Invalid 						<> 0 or
																											 corp_forgn_state_desc_Invalid 					<> 0 or
																											 corp_forgn_date_Invalid 								<> 0 or
																											 corp_orig_org_structure_desc_Invalid 	<> 0 or
																											 cont_address_line3_Invalid 						<> 0 or
																											 corp_dissolved_date_Invalid 						<> 0 or
																											 recordorigin_Invalid					 					<> 0
																										);

		Main_GoodRecords					:= Main_N.ExpandedInFile(	
																										 	 dt_vendor_first_reported_Invalid 			= 0 and
																											 dt_vendor_last_reported_Invalid 				= 0 and
																											 dt_first_seen_Invalid 									= 0 and
																											 dt_last_seen_Invalid 									= 0 and
																											 corp_ra_dt_first_seen_Invalid 					= 0 and
																											 corp_ra_dt_last_seen_Invalid 					= 0 and
																											 corp_key_Invalid 											= 0 and
																											 corp_vendor_Invalid 										= 0 and
																											 corp_state_origin_Invalid 							= 0 and
																											 corp_process_date_Invalid 							= 0 and
																											 corp_orig_sos_charter_nbr_Invalid 			= 0 and
																											 corp_legal_name_Invalid 								= 0 and
																											 corp_ln_name_type_cd_Invalid 					= 0 and
																											 corp_ln_name_type_desc_invalid					= 0 and																											 
																											 corp_address1_line3_Invalid 						= 0 and
																											 corp_status_comment_Invalid 						= 0 and
																											 corp_inc_state_Invalid 								= 0 and
																											 corp_inc_date_Invalid 									= 0 and
																											 corp_forgn_state_cd_Invalid 						= 0 and
																											 corp_forgn_state_desc_Invalid 					= 0 and
																											 corp_forgn_date_Invalid 								= 0 and
																											 corp_orig_org_structure_desc_Invalid 	= 0 and
																											 cont_address_line3_Invalid 						= 0 and
																											 corp_dissolved_date_Invalid 						= 0 and
																											 recordorigin_Invalid					 					= 0																										 
																								  );

		Main_FailBuild					:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_MI_Main.Threshold_Percent.CORP_KEY										 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_MI_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_MI_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_ln_name_type_cd_invalid<>0)),count(Main_N.ExpandedInFile),false) 				> Scrubs_Corp2_Mapping_MI_Main.Threshold_Percent.CORP_LN_NAME_TYPE_CD		  	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_inc_date_invalid<>0)),count(Main_N.ExpandedInFile),false) 							> Scrubs_Corp2_Mapping_MI_Main.Threshold_Percent.CORP_INC_DATE 						 	 => true,
																	  count(Main_GoodRecords) = 0																																																																																											 => true,																		
																		false
																	);

		Main_ApprovedRecords		:= project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));


		Main_ALL		 			:= sequential( IF(count(Main_BadRecords) <> 0
																							,IF (poverwrite
																									,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,overwrite,__compressed__)
																									,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,__compressed__)
																									)
																							)
																					,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainMIScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Main_ScrubsAlert) > 0, Main_MailFile, OUTPUT('CORP2_MAPPING.MI - No "MAIN" Corp Scrubs Alerts'))
																					,Main_ErrorSummary
																					,Main_ScrubErrorReport
																					,Main_SomeErrorValues	
																					,Main_SubmitStats
																			);

	//********************************************************************
  // SCRUB STOCK
  //********************************************************************	
		Stock_F := MapStock;
		Stock_S := Scrubs_Corp2_Mapping_MI_Stock.Scrubs;						// Scrubs module
		Stock_N := Stock_S.FromNone(Stock_F); 											// Generate the error flags
		Stock_T := Stock_S.FromBits(Stock_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Stock_U := Stock_S.FromExpanded(Stock_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Stock_ErrorSummary			 	:= output(Stock_U.SummaryStats, named('Stock_ErrorSummary_MI'+filedate));
		Stock_ScrubErrorReport 	 	:= output(choosen(Stock_U.AllErrors, 1000), named('Stock_ScrubErrorReport_MI'+filedate));
		Stock_SomeErrorValues		 	:= output(choosen(Stock_U.BadValues, 1000), named('Stock_SomeErrorValues_MI'+filedate));
		Stock_IsScrubErrors		 	 	:= IF(count(Stock_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Stock_OrbitStats				 	:= Stock_U.OrbitStats();
		
		//Outputs files
		Stock_CreateBitMaps				:= output(Stock_N.BitmapInfile,,'~thor_data::corp_mi_scrubs_bits',overwrite,compressed);	//long term storage
		Stock_TranslateBitMap			:= output(Stock_T);

		//Submits Profile's stats to Orbit
		Stock_SubmitStats 			  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MI_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_MI_Stock').SubmitStats;
		Stock_ScrubsWithExamples  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_MI_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_MI_Stock').CompareToProfile_with_Examples;

		Stock_ScrubsAlert					:= Stock_ScrubsWithExamples(RejectWarning = 'Y');
		Stock_ScrubsAttachment		:= Scrubs.fn_email_attachment(Stock_ScrubsAlert);
		Stock_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.spray
																																 ,'Scrubs CorpStock_MI Report' //subject
																																 ,'Scrubs CorpStock_MI Report' //body
																																 ,(data)Stock_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpMIEventScrubsReport.csv'
																																 ,
																																 ,
																																 ,corp2.Email_Notification_Lists.spray);

		Stock_BadRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  			<> 0 or
																												corp_vendor_Invalid 									<> 0 or
																												corp_state_origin_Invalid 					 	<> 0 or
																												corp_process_date_Invalid						  <> 0 or
																												corp_sos_charter_nbr_Invalid					<> 0 or
																												stock_authorized_nbr_Invalid	 				<> 0 
																											 );
																																														
		Stock_GoodRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  			= 0 and
																												corp_vendor_Invalid 									= 0 and
																												corp_state_origin_Invalid 					 	= 0 and
																												corp_process_date_Invalid						  = 0 and
																												corp_sos_charter_nbr_Invalid					= 0 and
																												stock_authorized_nbr_Invalid	 				= 0 
																											 );
																														
		Stock_FailBuild						:= if(count(Stock_GoodRecords) = 0,true,false);

		Stock_ApprovedRecords			:= project(Stock_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Stock,self := left));

		Stock_ALL									:= sequential( IF(count(Stock_BadRecords) <> 0
																							,IF (poverwrite
																									,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+state_origin,overwrite,__compressed__)
																									,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+state_origin,__compressed__)
																									)
																							)
																					,output(Stock_ScrubsWithExamples, ALL, NAMED('CorpStockMIScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Stock_ScrubsAlert) > 0, Stock_MailFile, OUTPUT('CORP2_MAPPING.MI - No "Stock" Corp Scrubs Alerts'))
																					,Stock_ErrorSummary
																					,Stock_ScrubErrorReport
																					,Stock_SomeErrorValues		
																					,Stock_SubmitStats
																					);	

	//********************************************************************
  // UPDATE
  //********************************************************************

	Fail_Build						:= IF(AR_FailBuild = true or Event_FailBuild = true or Main_FailBuild = true or Stock_FailBuild = true,true,false);
	IsScrubErrors					:= IF(AR_IsScrubErrors = true or Event_IsScrubErrors = true or Main_IsScrubErrors = true or Stock_IsScrubErrors = true,true,false);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::AR_' 		+ state_origin, AR_ApprovedRecords	 , write_ar,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Event_' 	+ state_origin, Event_ApprovedRecords, write_event,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Main_' 	+ state_origin, Main_ApprovedRecords , write_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Stock_' 	+ state_origin, Stock_ApprovedRecords, write_stock,,,pOverwrite);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::AR_' 		+ state_origin, AR_F		, write_fail_ar,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Event_' 	+ state_origin, Event_F	, write_fail_event,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Main_' 	+ state_origin, Main_F	, write_fail_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Stock_' 	+ state_origin, Stock_F	, write_fail_stock,,,pOverwrite);

	MapMI := sequential (if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
											// ,Corp2_Raw_MI.Build_Bases(filedate,version,puseprod).All											
											,AR_All
											,Event_All
											,Main_All
											,Stock_All
											,if(Fail_Build <> true	 
												 ,sequential (write_ar
																		 ,write_event
																		 ,write_main
																		 ,write_stock
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::ar'			,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_'		+state_origin)
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::event'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_'	+state_origin)
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::main'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_'	+state_origin)																		 
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::stock'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_'	+state_origin)
																		 ,if (count(Main_BadRecords) <> 0 or count(AR_BadRecords) <> 0 or count(Event_BadRecords) <> 0 or count(Stock_BadRecords)<>0
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,count(Event_BadRecords)<>0,count(Stock_BadRecords)<>0,count(Main_BadRecords),count(AR_BadRecords),count(Event_BadRecords),count(Stock_BadRecords),count(Main_ApprovedRecords),count(AR_ApprovedRecords),count(Event_ApprovedRecords),count(Stock_ApprovedRecords)).RecordsRejected																				 
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,count(Event_BadRecords)<>0,count(Stock_BadRecords)<>0,count(Main_BadRecords),count(AR_BadRecords),count(Event_BadRecords),count(Stock_BadRecords),count(Main_ApprovedRecords),count(AR_ApprovedRecords),count(Event_ApprovedRecords),count(Stock_ApprovedRecords)).MappingSuccess																				 
																				 )
																		 ,if (IsScrubErrors
																				 ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,AR_IsScrubErrors,Event_IsScrubErrors,Stock_IsScrubErrors).FieldsInvalidPerScrubs
																				 )
																		 ) //if Fail_Build <> true																			
												 ,sequential (write_fail_ar
																		 ,write_fail_event
																		 ,write_fail_main
																		 ,write_fail_stock												 
																		 ,Corp2_Mapping.Send_Email(state_origin,version).MappingFailed
																		 ) //if Fail_Build = true
												 )
										);
										
		isFileDateValid := if((string)std.date.today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);

		return sequential (if(isFileDateValid
												 ,MapMI
												 ,sequential(Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																		,FAIL('Corp2_Mapping.'+state_origin+' failed.  An invalid filedate was passed in as a parameter.')
																		)
												 )
											);

	end;	// end of Update function
	
end; //end MI module