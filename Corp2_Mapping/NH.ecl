import corp2,corp2_raw_nh,scrubs,scrubs_corp2_mapping_nh_ar,scrubs_corp2_mapping_nh_event,
			 scrubs_corp2_mapping_nh_main,scrubs_corp2_mapping_nh_stock,std,tools,ut,versioncontrol;

export NH := MODULE; 

	export Update(string fileDate, string version, boolean pShouldSpray = Corp2_Mapping._Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) := Function
	
		state_origin			 		:= 'NH';
		state_fips	 				 	:= '33';
		state_desc	 			 		:= 'NEW HAMPSHIRE';
		
		export Corporation		:= dedup(sort(distribute(Corp2_Raw_NH.Files(fileDate,puseprod).Input.Corporation.Logical,hash(BusinessID)),record,local),record,local) : independent;
		export Address				:= dedup(sort(distribute(Corp2_Raw_NH.Files(fileDate,puseprod).Input.Address.Logical,hash(BusinessID)),record,local),record,local) : independent;
		export Filing				  := dedup(sort(distribute(Corp2_Raw_NH.Files(fileDate,puseprod).Input.Filing.Logical,hash(BusinessID)),record,local),record,local) : independent;
		export RegAgent				:= dedup(sort(distribute(Corp2_Raw_NH.Files(fileDate,puseprod).Input.RegAgent.Logical,hash(BusinessID)),record,local),record,local) : independent;
		export PrevNames			:= dedup(sort(distribute(Corp2_Raw_NH.Files(fileDate,puseprod).Input.PrevNames.Logical,hash(BusinessID)),record,local),record,local) : independent;
		export Principals			:= dedup(sort(distribute(Corp2_Raw_NH.Files(fileDate,puseprod).Input.Principals.Logical,hash(BusinessID)),record,local),record,local) : independent;
		export PrinPurp      	:= dedup(sort(distribute(Corp2_Raw_NH.Files(fileDate,puseprod).Input.PrinPurp.Logical,hash(BusinessID)),record,local),record,local) : independent;
		export Stock					:= dedup(sort(distribute(Corp2_Raw_NH.Files(fileDate,puseprod).Input.Stock.Logical,hash(BusinessID)),record,local),record,local) : independent;
		
		//Normalize Business Name
	  Corp2_Raw_NH.Layouts.TempCorporationLayoutIn NormBusName(Corp2_Raw_NH.Layouts.CorporationLayoutIn l, unsigned1 cnt) := transform,
		  skip(cnt = 2 and corp2.t2u(l.HomeStateName) = '')
		    self.NormBusinessName       := choose(cnt,l.BusinessName,l.HomeStateName);
			  self.NormBusinessTypeCode   := choose(cnt,Corp2_Raw_NH.Functions.CorpLNNameTypeCD(l.BusinessType),'10');
				self.NormFilingCode         := choose(cnt,'','H');
				self.NormDateInJurisdiction := choose(cnt,'',l.DateInJurisdiction);
			  self 							          := l;
			  self                        := [];
		end;
		
	  NormBusinessName := normalize(Corporation, 2, NormBusName(left, counter));
		
		//Normalize Registered Agent
		Corp2_Raw_NH.Layouts.TempRALayoutIn NormalizeRA(Corp2_Raw_NH.Layouts.RegAgentLayoutIn l, unsigned1 cnt) := transform,
			skip(cnt = 2 and corp2.t2u(l.RAMailingAddress + l.RAMailingAddress2 + l.RAMailingCity) = '' or
					 corp2.t2u(l.RegAgentName) = 'NO REGISTERED AGENT ON FILE')
				self.NormRAName         := l.RegAgentName;	 
				self.NormRAType         := l.RegAgentType;
				self.NormRAAddressType  := choose(cnt,'R','M');		
				self.NormRAAddress      := choose(cnt,l.RAPrinOfficeAddress,l.RAMailingAddress);              
				self.NormRAAddress2     := choose(cnt,l.RAPrinOfficeAddress2,l.RAMailingAddress2);                     
				self.NormRACity         := choose(cnt,l.RAPrinOfficeCity,l.RAMailingCity);                         
				self.NormRAState        := choose(cnt,l.RAPrinOfficeState,l.RAMailingState);                        
				self.NormRAZip          := choose(cnt,l.RAPrinOfficeZip,l.RAMailingZip); 
				self.NormRACounty       := choose(cnt,l.RAPrinOfficeCounty,l.RAMailingCounty); 
				self.NormRACountry      := choose(cnt,l.RAPrinOfficeCountry,l.RAMailingCountry);
				self.NormRAPrinCounty   := l.RAPrinOfficeCounty;
				self.NormRAPrinCountry  := l.RAPrinOfficeCountry;
				self 							      := l;
				self                    := [];
			end;
		
	  NormRA   := normalize(RegAgent, 2, NormalizeRA(left, counter));
		dNormRA  := dedup(sort(distribute(NormRA, hash(BusinessID)),record,local),record,local) : independent;
					 
		// Corporation & Address
	  Corp_Addr_File			:= join(NormBusinessName,Address,
																corp2.t2u(left.BusinessID) = corp2.t2u(right.BusinessID),
																transform(Corp2_Raw_NH.Layouts.TempCorporationLayoutIn,
																					self.BusinessID         := left.BusinessID;
																					self										:= right;																				
																					self										:= left;
																					self										:= [];
																					),
																left outer,
																local
																) : independent;	

		// Corporation, Address, Principals															
		Add_Prin_Corp_Addr_File	:= join(Corp_Addr_File,Principals,
																corp2.t2u(left.BusinessID) = corp2.t2u(right.BusinessID),
																transform(Corp2_Raw_NH.Layouts.TempCorporationLayoutIn,
																					self.BusinessID         := left.BusinessID;
																					self										:= right;																				
																					self										:= left;
																					self										:= [];
																					),
																left outer,
																local
																) : independent;	
	
		// Corporation, Address, Principals, Prin Purpose														
		Add_Corp_PrinPurp_File	:= join(Add_Prin_Corp_Addr_File,PrinPurp,
																corp2.t2u(left.BusinessID) = corp2.t2u(right.BusinessID),
																transform(Corp2_Raw_NH.Layouts.TempCorporationLayoutIn,
																					self.BusinessID         := left.BusinessID;
																					self										:= right;																				
																					self										:= left;
																					self										:= [];
																					),
																left outer,
																local
																) : independent;	

		// Corporation, Address, Principals, Prin Purpose, RA															
		Add_Corp_RA_File	:= join(Add_Corp_PrinPurp_File,dNormRA,
																corp2.t2u(left.BusinessID) = corp2.t2u(right.BusinessID),
																transform(Corp2_Raw_NH.Layouts.TempCorporationLayoutIn,
																					self.BusinessID         := left.BusinessID;
																					self										:= right;																				
																					self										:= left;
																					self										:= [];
																					),
																left outer,
																local
																) : independent;	
																
		// Corporation and Filing			
		 Corp_Filings			:= join(Corporation,Filing,
																corp2.t2u(left.BusinessID) = corp2.t2u(right.BusinessID),
																transform(Corp2_Raw_NH.Layouts.TempFilingWithCorpLayoutIn,
																					self.BusinessID         := left.BusinessID;
																					self.FilingDate         := right.FilingDateTime[1..10];
																					self										:= right;																				
																					self										:= left;
																					self										:= [];
																					),
																left outer,
																local
																) : independent;
																
		//********************************************************************
		//This begins the MAIN mapping.
		//Note: The Corporation and RA data is mapped here.
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Main CorporationTransform(Corp2_Raw_NH.Layouts.TempCorporationLayoutIn l) := transform
				self.dt_vendor_first_reported						:= (unsigned4)fileDate;
				self.dt_vendor_last_reported						:= (unsigned4)fileDate;
				self.dt_first_seen											:= (unsigned4)fileDate;
				self.dt_last_seen												:= (unsigned4)fileDate;
				self.corp_ra_dt_first_seen							:= (unsigned4)fileDate;
				self.corp_ra_dt_last_seen								:= (unsigned4)fileDate;			
				self.corp_key														:= state_fips + '-' + corp2.t2u(l.businessid);
				self.corp_vendor												:= state_fips;
				self.corp_state_origin									:= state_origin;			
				self.corp_process_date									:= fileDate;
				self.corp_orig_sos_charter_nbr					:= corp2.t2u(l.businessid);
				self.corp_ln_name_type_cd								:= corp2.t2u(l.NormBusinessTypeCode);
				self.corp_ln_name_type_desc							:= map(self.corp_ln_name_type_cd = '01' => 'LEGAL',
				                                               self.corp_ln_name_type_cd = '03' => 'DBA',
																											 self.corp_ln_name_type_cd = '05' => 'TRADENAME',
																											 self.corp_ln_name_type_cd = '10' => 'HOME STATE',
																											 self.corp_ln_name_type_cd = '11' => 'FOREIGN REGISTERED NAME',
																											 ''
																											 );
				self.corp_legal_name 									 	:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.NormBusinessName).BusinessName;
				self.corp_address1_type_cd	      			:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.PrinOfficeAddress,l.PrinOfficeAddress2,l.PrinOfficeCity,l.PrinOfficeState,l.PrinOfficeZip,l.PrinOfficeCountry).ifAddressExists, 'B', '');
				self.corp_address1_type_desc      			:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.PrinOfficeAddress,l.PrinOfficeAddress2,l.PrinOfficeCity,l.PrinOfficeState,l.PrinOfficeZip,l.PrinOfficeCountry).ifAddressExists, 'BUSINESS', '');
				self.corp_address1_line1								:= if(self.corp_address1_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.PrinOfficeAddress,l.PrinOfficeAddress2,l.PrinOfficeCity,l.PrinOfficeState,l.PrinOfficeZip,l.PrinOfficeCountry).AddressLine1,'');
				self.corp_address1_line2								:= if(self.corp_address1_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.PrinOfficeAddress,l.PrinOfficeAddress2,l.PrinOfficeCity,l.PrinOfficeState,l.PrinOfficeZip,l.PrinOfficeCountry).AddressLine2,'');
				self.corp_address1_line3								:= if(self.corp_address1_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.PrinOfficeAddress,l.PrinOfficeAddress2,l.PrinOfficeCity,l.PrinOfficeState,l.PrinOfficeZip,l.PrinOfficeCountry).AddressLine3,'');
				self.corp_prep_addr1_line1							:= if(self.corp_address1_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.PrinOfficeAddress,l.PrinOfficeAddress2,l.PrinOfficeCity,l.PrinOfficeState,l.PrinOfficeZip,l.PrinOfficeCountry).PrepAddrLine1,'');
				self.corp_prep_addr1_last_line					:= if(self.corp_address1_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.PrinOfficeAddress,l.PrinOfficeAddress2,l.PrinOfficeCity,l.PrinOfficeState,l.PrinOfficeZip,l.PrinOfficeCountry).PrepAddrLastLine,'');
        self.corp_address2_type_cd	      			:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.MailingAddress,l.MailingAddress2,l.MailingCity,l.MailingState,l.MailingZip,l.MailingCountry).ifAddressExists, 'M', '');
				self.corp_address2_type_desc      			:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.MailingAddress,l.MailingAddress2,l.MailingCity,l.MailingState,l.MailingZip,l.MailingCountry).ifAddressExists, 'MAILING', '');
				self.corp_address2_line1								:= if(self.corp_address2_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.MailingAddress,l.MailingAddress2,l.MailingCity,l.MailingState,l.MailingZip,l.MailingCountry).AddressLine1,'');
				self.corp_address2_line2								:= if(self.corp_address2_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.MailingAddress,l.MailingAddress2,l.MailingCity,l.MailingState,l.MailingZip,l.MailingCountry).AddressLine2,'');
				self.corp_address2_line3								:= if(self.corp_address2_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.MailingAddress,l.MailingAddress2,l.MailingCity,l.MailingState,l.MailingZip,l.MailingCountry).AddressLine3,'');
				self.corp_prep_addr2_line1							:= if(self.corp_address2_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.MailingAddress,l.MailingAddress2,l.MailingCity,l.MailingState,l.MailingZip,l.MailingCountry).PrepAddrLine1,'');
				self.corp_prep_addr2_last_line					:= if(self.corp_address2_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.MailingAddress,l.MailingAddress2,l.MailingCity,l.MailingState,l.MailingZip,l.MailingCountry).PrepAddrLastLine,'');
				self.corp_phone_number                  := Corp2_Raw_NH.Functions.PhoneNo(l.PhoneNumber);
				self.corp_email_address                 := corp2.t2u(l.BusinessEmail);
				self.corp_filing_date                   := if(l.NormDateInJurisdiction <> '',Corp2_Mapping.fValidateDate(l.NormDateInJurisdiction,'CCYY-MM-DD').PastDate,'');
				self.corp_filing_cd                     := corp2.t2u(l.NormFilingCode);
				self.corp_filing_desc                   := if(self.corp_filing_cd <> '','HOME STATE','');
				self.corp_orig_org_structure_desc				:= corp2.t2u(l.BusinessType);
				self.corp_for_profit_ind								:= map(corp2.t2u(l.BusinessType) in ['FOREIGN PROFIT CORPORATION','DOMESTIC PROFIT CORPORATION',
				                                                                             'DOMESTIC PROFESSIONAL PROFIT CORPORATION',
																																										 'FOREIGN PROFESSIONAL PROFIT CORPORATION']                         => 'Y',
				                                               corp2.t2u(l.BusinessType) in ['DOMESTIC NONPROFIT CORPORATION','FOREIGN NONPROFIT CORPORATION']  => 'N',
																											 '');
				self.corp_status_desc										:= corp2.t2u(l.BusinessStatus);
				self.corp_standing											:= map(corp2.t2u(l.BusinessStatus) = 'GOOD STANDING'        => 'Y',
				                                               corp2.t2u(l.BusinessStatus) = 'NOT IN GOOD STANDING' => 'N',
																											 '');
				self.corp_foreign_domestic_ind					:= Corp2_Raw_NH.Functions.CorpForeignDomesticInd(l.BusinessType);
				self.corp_inc_date											:= if(self.corp_foreign_domestic_ind = 'D', Corp2_Mapping.fValidateDate(l.CreationDate,'CCYY-MM-DD').PastDate, '');
				self.corp_term_exist_cd									:= map(corp2.t2u(l.duration) = '9999-01-01' 																	=> 'P',
				                                               corp2.t2u(l.duration) = '9999-09-09' 																	=> '',
																											 Corp2_Mapping.fValidateDate(l.duration,'CCYY-MM-DD').GeneralDate<>''   => 'D',
																											 ''
																											);
				self.corp_term_exist_exp								:= if(self.corp_term_exist_cd = 'D',Corp2_Mapping.fValidateDate(l.duration,'CCYY-MM-DD').GeneralDate,'');																							
				self.corp_term_exist_desc								:= map(self.corp_term_exist_cd = 'P'	=> 'PERPETUAL',
																											 self.corp_term_exist_cd = 'D'	=> 'EXPIRATION DATE',
																											 ''
																											);
				
				self.corp_inc_state											:= state_origin;
				self.corp_inc_county										:= corp2.t2u(l.PrinOfficeCounty);
				self.corp_forgn_state_cd								:= if(corp2.t2u(l.CitizenStateOfInc) not in [state_origin,'','NEW HAMPSHIRE','DATA NOT FOUND'],Corp2_Raw_NH.Functions.State_Description(l.CitizenStateOfInc),'');
				self.corp_forgn_state_desc							:= if(self.corp_forgn_state_cd <> '',corp2.t2u(l.CitizenStateOfInc),'');
				self.corp_forgn_date										:= if(self.corp_foreign_domestic_ind = 'F', Corp2_Mapping.fValidateDate(l.CreationDate[1..10],'CCYY-MM-DD').PastDate,'');
        self.corp_entity_desc				            := corp2.t2u(l.NAICSCode);
				NEmail                                  := corp2.t2u(l.NotificationEmail);
				BEmail                                  := corp2.t2u(l.BusinessEmail);
				self.corp_addl_info                     := if(NEmail <> '' and BEmail <> '', 'NOTIFICATION EMAIL: ' + NEmail + '; BUSINESS EMAIL: ' +  BEmail, 
				                                              if(NEmail <> '','NOTIFICATION EMAIL: ' + NEmail, if(BEmail <> '', 'BUSINESS EMAIL: ' +  BEmail, ''))); 
				self.corp_ra_full_name							 		:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.NormRAName).BusinessName;
				self.corp_ra_addl_info                  := corp2.t2u(l.NormRAType);
				self.corp_ra_address_type_cd	      		:= corp2.t2u(l.NormRAAddressType);
				self.corp_ra_address_type_desc      		:= map(self.corp_ra_address_type_cd = 'R'  => 'REGISTERED OFFICE',
				                                               self.corp_ra_address_type_cd = 'M'  => 'MAILING ADDRESS',
																											 '');
				self.corp_ra_address_line1							:= if(self.corp_ra_address_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.NormRAAddress,l.NormRAAddress2,l.NormRACity,l.NormRAState,l.NormRAZip,l.NormRACountry).AddressLine1,'');
				self.corp_ra_address_line2							:= if(self.corp_ra_address_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.NormRAAddress,l.NormRAAddress2,l.NormRACity,l.NormRAState,l.NormRAZip,l.NormRACountry).AddressLine2,'');
				self.corp_ra_address_line3							:= if(self.corp_ra_address_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.NormRAAddress,l.NormRAAddress2,l.NormRACity,l.NormRAState,l.NormRAZip,l.NormRACountry).AddressLine3,'');
				self.ra_prep_addr_line1									:= if(self.corp_ra_address_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.NormRAAddress,l.NormRAAddress2,l.NormRACity,l.NormRAState,l.NormRAZip,l.NormRACountry).PrepAddrLine1,'');
				self.ra_prep_addr_last_line							:= if(self.corp_ra_address_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.NormRAAddress,l.NormRAAddress2,l.NormRACity,l.NormRAState,l.NormRAZip,l.NormRACountry).PrepAddrLastLine,'');
				self.corp_agent_county									:= corp2.t2u(l.NormRAPrinCounty);
				self.corp_agent_country									:= Corp2_Mapping.fCleanCountry(state_origin,state_desc,,l.NormRAPrinCountry).Country;
				self.corp_country_of_formation					:= Corp2_Mapping.fCleanCountry(state_origin,state_desc,,l.PrinOfficeCountry).Country;
				self.corp_home_state_name								:= corp2.t2u(l.HomeStateName);
				self.corp_management_desc               := corp2.t2u(l.ManagementStyle);
				self.corp_naics_desc                    := corp2.t2u(l.NAICSSubCode);
				self.corp_profession                    := corp2.t2u(l.Profession);
				self.recordorigin												:= 'C';
				self 																		:= [];
		end; 

 		MapCorporation	 	 				:= project(Add_Corp_RA_File,CorporationTransform(left));

    //********************************************************************
		//Continue the MAIN mapping.
		//Note: Previous Business Name data is mapped here.
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Main PrevNamesTransform(Corp2_Raw_NH.Layouts.PrevNamesLayoutIn l) := transform
		    self.dt_vendor_first_reported						:= (unsigned4)fileDate;
				self.dt_vendor_last_reported						:= (unsigned4)fileDate;
				self.dt_first_seen											:= (unsigned4)fileDate;
				self.dt_last_seen												:= (unsigned4)fileDate;
				self.corp_ra_dt_first_seen							:= (unsigned4)fileDate;
				self.corp_ra_dt_last_seen								:= (unsigned4)fileDate;			
				self.corp_key														:= state_fips + '-' + corp2.t2u(l.businessid);
				self.corp_vendor												:= state_fips;
				self.corp_state_origin									:= state_origin;			
				self.corp_process_date									:= fileDate;
				self.corp_orig_sos_charter_nbr					:= corp2.t2u(l.businessid);
				self.corp_inc_state											:= state_origin;
				self.corp_legal_name 									 	:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.PreviousName).BusinessName;
				self.corp_ln_name_type_cd								:= 'P';
				self.corp_ln_name_type_desc							:= 'PRIOR';
				self.recordorigin												:= 'C';
				self 																		:= [];
		end; 
		
		MapPrevNames			:= project(PrevNames,PrevNamesTransform(left));
		
		//********************************************************************
		//Continue the MAIN mapping.
		//Note: The Contact data is mapped here.
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Main ContactTransform(Corp2_Raw_NH.Layouts.TempCorporationLayoutIn l) := transform
				self.dt_vendor_first_reported						:= (unsigned4)fileDate;
				self.dt_vendor_last_reported						:= (unsigned4)fileDate;
				self.dt_first_seen											:= (unsigned4)fileDate;
				self.dt_last_seen												:= (unsigned4)fileDate;
				self.corp_ra_dt_first_seen							:= (unsigned4)fileDate;
				self.corp_ra_dt_last_seen								:= (unsigned4)fileDate;			
				self.corp_key														:= state_fips + '-' + corp2.t2u(l.businessid);
				self.corp_vendor												:= state_fips;
				self.corp_state_origin									:= state_origin;			
				self.corp_process_date									:= fileDate;
				self.corp_orig_sos_charter_nbr					:= corp2.t2u(l.businessid);
				self.corp_legal_name 									 	:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.NormBusinessName).BusinessName;
				self.corp_inc_state											:= state_origin;				
				self.cont_full_name 									 	:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.PrincipalName).BusinessName;
				self.cont_title1_desc               		:= corp2.t2u(l.PrincipalTitle);
				self.cont_address_type_cd	      				:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.PrincipalAddress,l.PrincipalAddress2,l.PrincipalCity,l.PrincipalState,l.PrincipalZip).ifaddressexists,'T','');
				self.cont_address_type_desc    	  			:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.PrincipalAddress,l.PrincipalAddress2,l.PrincipalCity,l.PrincipalState,l.PrincipalZip).ifaddressexists,'CONTACT','');
				self.cont_address_line1									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.PrincipalAddress,l.PrincipalAddress2,l.PrincipalCity,l.PrincipalState,l.PrincipalZip,l.PrincipalCountry).AddressLine1;
				self.cont_address_line2									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.PrincipalAddress,l.PrincipalAddress2,l.PrincipalCity,l.PrincipalState,l.PrincipalZip,l.PrincipalCountry).AddressLine2;
				self.cont_address_line3									:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.PrincipalAddress,l.PrincipalAddress2,l.PrincipalCity,l.PrincipalState,l.PrincipalZip,l.PrincipalCountry).AddressLine3;
        self.cont_address_county		            := corp2.t2u(l.PrincipalCounty);
				self.cont_country                       := corp2.t2u(l.PrincipalCountry);  
				self.recordorigin												:= 'T';
				self 																		:= [];
		end;
		
		MapContacts			:= project(Add_Corp_RA_File,ContactTransform(left));
		
		MapMain		 			:= dedup(sort(distribute(MapCorporation + MapPrevNames + MapContacts,hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		//This begins the AR mapping.
		//Note: The Corporation and Filing data is mapped here.
		//********************************************************************
		Corp2_mapping.LayoutsCommon.AR ARTransform1(Corp2_Raw_NH.Layouts.TempFilingWithCorpLayoutIn l):= transform,
		  skip(corp2.t2u(l.FilingType) not in ['ANNUAL REPORT','NONPROFIT REPORT','ANNUAL REPORT REMINDER'])
				self.corp_key														:= state_fips + '-' + corp2.t2u(l.BusinessID);
				self.corp_vendor												:= state_fips;
				self.corp_state_origin									:= state_origin;			
				self.corp_process_date									:= fileDate;
				self.corp_sos_charter_nbr								:= corp2.t2u(l.BusinessID);		
				self.ar_due_dt													:= if(LENGTH(l.NextAnnRptYear) = 4 and TRIM(l.NextAnnRptYear) NOT IN ['0',''], l.NextAnnRptYear,'');
				self 																		:= [];
		end;
				
		AR1						:= project(Corp_Filings, ARTransform1(left));
		
		//********************************************************************
		Corp2_mapping.LayoutsCommon.AR ARTransform2(Corp2_Raw_NH.Layouts.TempFilingWithCorpLayoutIn l):= transform,
		  skip(corp2.t2u(l.FilingType) not in ['ANNUAL REPORT','NONPROFIT REPORT','ANNUAL REPORT REMINDER'])
				self.corp_key														:= state_fips + '-' + corp2.t2u(l.BusinessID);
				self.corp_vendor												:= state_fips;
				self.corp_state_origin									:= state_origin;			
				self.corp_process_date									:= fileDate;
				self.corp_sos_charter_nbr								:= corp2.t2u(l.BusinessID);		
				self.ar_report_nbr	                    := corp2.t2u(l.FilingNumber);	
				self.ar_report_dt												:= Corp2_Mapping.fValidateDate(l.FilingDate,'CCYY-MM-DD').PastDate;
				self.ar_filed_dt												:= if(LENGTH(l.LastAnnRptYear) = 4 and TRIM(l.LastAnnRptYear) NOT IN ['0',''], l.LastAnnRptYear,'');
        self.ar_type                            := corp2.t2u(l.FilingType);				
				self 																		:= [];
		end;
		
		AR2 						:= project(Corp_Filings, ARTransform2(left));
		
		MapAR						:= dedup(sort(distribute(AR1 + AR2,hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		//This begins the Event mapping.
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Events EventFilingTransform(Corp2_Raw_NH.Layouts.FilingLayoutIn l, integer c) := transform,
		skip(corp2.t2u(l.FilingType) in ['ANNUAL REPORT','NONPROFIT REPORT'])
				self.corp_key														:= state_fips + '-' + corp2.t2u(l.BusinessID);
				self.corp_vendor												:= state_fips;
				self.corp_state_origin									:= state_origin;			
				self.corp_process_date									:= fileDate;
				self.corp_sos_charter_nbr								:= corp2.t2u(l.BusinessID);
				self.event_filing_reference_nbr 				:= corp2.t2u(l.FilingNumber);
				self.event_filing_date									:= choose(c,Corp2_Mapping.fValidateDate(l.filingdatetime[1..10],'CCYY-MM-DD').PastDate,
																														Corp2_Mapping.fValidateDate(l.effectivedatetime[1..10],'CCYY-MM-DD').GeneralDate
																												 );
				self.event_date_type_cd									:= choose(c,if(Corp2_Mapping.fValidateDate(l.filingdatetime[1..10],'CCYY-MM-DD').PastDate<>'','FIL',''),
																														if(Corp2_Mapping.fValidateDate(l.effectivedatetime[1..10],'CCYY-MM-DD').GeneralDate<>'','EFF','')
																												 );				
				self.event_date_type_desc								:= choose(c,if(Corp2_Mapping.fValidateDate(l.filingdatetime[1..10],'CCYY-MM-DD').PastDate<>'','FILING',''),
																														if(Corp2_Mapping.fValidateDate(l.effectivedatetime[1..10],'CCYY-MM-DD').GeneralDate<>'','EFFECTIVE','')
																												 );
				self.event_filing_desc                  := corp2.t2u(l.FilingType);
				self 																		:= [];	
		end;
		
		AllEvent 				:= normalize(Filing, if(Corp2_Mapping.fValidateDate(left.effectivedatetime[1..10],'CCYY-MM-DD').GeneralDate<>'' and
		                                        left.effectivedatetime[1..10] <> left.filingdatetime[1..10],2,1),EventFilingTransform(left,counter));
		MapEvent				:= dedup(sort(distribute(AllEvent,hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		//This begins the Stock mapping.
		//********************************************************************
		Corp2_mapping.LayoutsCommon.Stock StockTransform(Corp2_Raw_NH.Layouts.StockLayoutIn l) := transform	
				self.corp_key														:= state_fips + '-' + corp2.t2u(l.BusinessID);
				self.corp_vendor												:= state_fips;
				self.corp_state_origin									:= state_origin;			
				self.corp_process_date									:= fileDate;
				self.corp_sos_charter_nbr								:= corp2.t2u(l.BusinessID);
				self.stock_class												:= Corp2_Raw_NH.Functions.StockClass(l.ShareClass);
				self.stock_authorized_nbr								:= if((integer)l.numberofshares <> 0,stringlib.stringfilterout((string)(integer)l.numberofshares,'-'),''); //remove negative, if exists
		    self.stock_par_value										:= if((integer)l.parvalue <> 0,stringlib.stringfilterout((string)(integer)l.parvalue,'-$'),''); 							 //remove negative & $, if exists
				self.stock_addl_info                    := corp2.t2u(l.Note);
				self																		:= [];
		end;

		AllStock				:= project(Stock, StockTransform(left));
		MapStock				:= dedup(sort(distribute(AllStock,hash(corp_key)),record,local),record,local) : independent;

		//********************************************************************
		// SCRUB AR 
		//********************************************************************	
		AR_F := MapAR;
		AR_S := Scrubs_Corp2_Mapping_NH_AR.Scrubs;				// Scrubs module
		AR_N := AR_S.FromNone(AR_F); 											// Generate the error flags
		AR_T := AR_S.FromBits(AR_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		AR_U := AR_S.FromExpanded(AR_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		AR_ErrorSummary			 	 := output(AR_U.SummaryStats, named('AR_ErrorSummary_NH'+fileDate));
		AR_ScrubErrorReport 	 := output(choosen(AR_U.AllErrors, 1000), named('AR_ScrubErrorReport_NH'+fileDate));
		AR_SomeErrorValues		 := output(choosen(AR_U.BadValues, 1000), named('AR_SomeErrorValues_NH'+fileDate));
		AR_IsScrubErrors		 	 := IF(count(AR_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		AR_OrbitStats				 	 := AR_U.OrbitStats();

		//Outputs files
		AR_CreateBitMaps			 := output(AR_N.BitmapInfile,,'~thor_data::corp_NH_ar_scrubs_bits',overwrite,compressed);	//long term storage
		AR_TranslateBitMap		 := output(AR_T);

		//Submits Profile's stats to Orbit
		AR_SubmitStats 			   := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_NH_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_NH_AR').SubmitStats;
		AR_ScrubsWithExamples  := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_NH_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_NH_AR').CompareToProfile_with_Examples;

		AR_ScrubsAlert				 := AR_ScrubsWithExamples(RejectWarning = 'Y');
		AR_ScrubsAttachment	   := Scrubs.fn_email_attachment(AR_ScrubsAlert);
		AR_MailFile					   := FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																															,'Scrubs CorpAR_NH Report' //subject
																															,'Scrubs CorpAR_NH Report' //body
																															,(data)AR_ScrubsAttachment
																															,'text/csv'
																															,'CorpNHARScrubsReport.csv'
																														);

		AR_BadRecords				 		:= AR_N.ExpandedInFile(	
																										corp_key_Invalid							  			<> 0 or
																										corp_vendor_Invalid 									<> 0 or
																										corp_state_origin_Invalid 					 	<> 0 or
																										corp_process_date_Invalid						  <> 0 or
																										corp_sos_charter_nbr_Invalid 					<> 0 or
																										ar_year_Invalid 											<> 0 or
																										ar_filed_dt_Invalid 									<> 0 or
																										ar_report_dt_Invalid 									<> 0 or
																										ar_report_nbr_Invalid 								<> 0
																									 );

		AR_GoodRecords						:= AR_N.ExpandedInFile(
																										corp_key_Invalid							  			= 0 and
																										corp_vendor_Invalid 									= 0 and
																										corp_state_origin_Invalid 					 	= 0 and
																										corp_process_date_Invalid						  = 0 and
																										corp_sos_charter_nbr_Invalid 					= 0 and
																										ar_year_Invalid 											= 0 and
																										ar_filed_dt_Invalid 									= 0 and
																										ar_report_dt_Invalid 									= 0 and
																										ar_report_nbr_Invalid 								= 0
																									 );

		AR_FailBuild					 		:= if(count(AR_GoodRecords) = 0,true,false);

		AR_ApprovedRecords		 		:= project(AR_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.AR,self := left;));


		AR_ALL								 		:= sequential(IF(count(AR_BadRecords) <> 0
																						  ,IF (poverwrite
																								  ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,overwrite,__compressed__)
																								  ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,__compressed__)
																								  )
																						  )
																					 ,output(AR_ScrubsWithExamples, all, named('CorpARNHScrubsReportWithExamples'+fileDate))
																					 //Send Alerts if Scrubs exceeds thresholds
																					 ,IF(COUNT(AR_ScrubsAlert) > 0, AR_MailFile, OUTPUT('CORP2_MAPPING.NH - No "AR" Corp Scrubs Alerts'))
																					 ,AR_ErrorSummary
																					 ,AR_ScrubErrorReport
																					 ,AR_SomeErrorValues		
																					 ,AR_SubmitStats
																					);

		//********************************************************************
		// SCRUB EVENT 
		//********************************************************************	
		Event_F := MapEvent;
		Event_S := Scrubs_Corp2_Mapping_NH_Event.Scrubs;					// Scrubs module
		Event_N := Event_S.FromNone(Event_F); 										// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Event_ErrorSummary			 	:= output(Event_U.SummaryStats, named('Event_ErrorSummary_NH'+fileDate));
		Event_ScrubErrorReport 	 	:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_NH'+fileDate));
		Event_SomeErrorValues		 	:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_NH'+fileDate));
		Event_IsScrubErrors		 	 	:= IF(count(Event_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Event_OrbitStats				 	:= Event_U.OrbitStats();

		//Outputs files
		Event_CreateBitMaps			 	:= output(Event_N.BitmapInfile,,'~thor_data::corp_NH_Event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap		 	:= output(Event_T);

		//Submits Profile's stats to Orbit
		Event_SubmitStats 			 := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_NH_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_NH_Event').SubmitStats;
		Event_ScrubsWithExamples := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_NH_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_NH_Event').CompareToProfile_with_Examples;

		Event_ScrubsAlert				 	:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment	  := Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_MailFile					  := FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																															,'Scrubs CorpEvent_NH Report' //subject
																															,'Scrubs CorpEvent_NH Report' //body
																															,(data)Event_ScrubsAttachment
																															,'text/csv'
																															,'CorpNHEventScrubsReport.csv'
																														);

		Event_BadRecords				 	:= Event_N.ExpandedInFile(	
																											corp_key_Invalid							  			<> 0 or
																											corp_vendor_Invalid 									<> 0 or
																											corp_state_origin_Invalid 					 	<> 0 or
																											corp_process_date_Invalid						  <> 0 or
																											corp_sos_charter_nbr_Invalid 					<> 0 or
																											Event_filing_reference_nbr_Invalid 		<> 0 or
																											Event_filing_date_Invalid 						<> 0 or
																											Event_date_type_cd_Invalid 						<> 0 or
																											Event_date_type_desc_Invalid 					<> 0 
																										 );

		Event_GoodRecords					:= Event_N.ExpandedInFile(
																											corp_key_Invalid							  			= 0 and
																											corp_vendor_Invalid 									= 0 and
																											corp_state_origin_Invalid 					 	= 0 and
																											corp_process_date_Invalid						  = 0 and
																											corp_sos_charter_nbr_Invalid 					= 0 and
																											Event_filing_reference_nbr_Invalid 		= 0 and
																											Event_filing_date_Invalid 						= 0 and
																											Event_date_type_cd_Invalid 						= 0 and
																											Event_date_type_desc_Invalid 					= 0 																								 
																										 );

		Event_FailBuild					 	:= if(count(Event_GoodRecords) = 0,true,false);

		Event_ApprovedRecords		 	:= project(Event_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Events,self := left;));


		Event_ALL								 	:= sequential(IF(count(Event_BadRecords) <> 0
																						,IF (poverwrite
																								,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::Event_'+state_origin,overwrite,__compressed__)
																								,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::Event_'+state_origin,__compressed__)
																								)
																						)
																				 ,output(Event_ScrubsWithExamples, all, named('CorpEventNHScrubsReportWithExamples'+fileDate))
																				 //Send Alerts if Scrubs exceeds thresholds
																				 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_MailFile, OUTPUT('CORP2_MAPPING.NH - No "Event" Corp Scrubs Alerts'))
																				 ,Event_ErrorSummary
																				 ,Event_ScrubErrorReport
																				 ,Event_SomeErrorValues			
																				 ,Event_SubmitStats
																				);

	//********************************************************************
  // SCRUB MAIN
  //********************************************************************	
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_NH_Main.Scrubs;					// Scrubs module
		Main_N := Main_S.FromNone(Main_F); 											// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_NH'+fileDate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_NH'+fileDate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_NH'+fileDate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();

		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_NH_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

		//Submits Profile's stats to Orbit
		Main_SubmitStats 			    := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_NH_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_NH_Main').SubmitStats;
		Main_ScrubsWithExamples   := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_NH_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_NH_Main').CompareToProfile_with_Examples;

		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile							:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																																 ,'Scrubs CorpMain_NH Report' //subject
																																 ,'Scrubs CorpMain_NH Report' //body
																																 ,(data)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpNHMainScrubsReport.csv'
																																);

		Main_BadRecords						:= Main_N.ExpandedInFile(	
																											 dt_vendor_first_reported_Invalid 			<> 0 or
																											 dt_vendor_last_reported_Invalid 				<> 0 or
																											 dt_first_seen_Invalid 									<> 0 or
																											 dt_last_seen_Invalid 									<> 0 or
																											 corp_ra_dt_first_seen_Invalid 					<> 0 or
																											 corp_ra_dt_last_seen_Invalid 					<> 0 or
																											 corp_key_Invalid 											<> 0 or
																											 corp_vendor_Invalid 										<> 0 or
																											 corp_state_origin_Invalid 					 		<> 0 or
																											 corp_process_date_Invalid						  <> 0 or
																											 corp_orig_sos_charter_nbr_Invalid 			<> 0 or
																											 corp_legal_name_Invalid 								<> 0 or
																											 corp_ln_name_type_cd_Invalid 					<> 0 or
																											 corp_ln_name_type_desc_Invalid 				<> 0 or
																											 corp_address1_type_cd_Invalid 					<> 0 or
																											 corp_address1_type_desc_Invalid 				<> 0 or
																											 corp_status_desc_Invalid 							<> 0 or
																											 corp_standing_Invalid 									<> 0 or
																											 corp_inc_state_Invalid 								<> 0 or
																											 corp_inc_date_Invalid 									<> 0 or
																											 corp_term_exist_cd_Invalid 						<> 0 or
																											 corp_term_exist_exp_Invalid 						<> 0 or
																											 corp_term_exist_desc_Invalid 					<> 0 or
																											 corp_foreign_domestic_ind_Invalid 			<> 0 or
																											 corp_forgn_state_cd_Invalid  					<> 0 or
																											 corp_forgn_state_desc_Invalid 					<> 0 or
																											 corp_forgn_date_Invalid 								<> 0 or
																											 corp_orig_org_structure_desc_Invalid 	<> 0 or
																											 corp_for_profit_ind_Invalid 						<> 0 or
																											 corp_ra_address_type_desc_Invalid 			<> 0 or
																											 cont_address_type_cd_Invalid 					<> 0 or
																											 recordorigin_Invalid 									<> 0 																							 
																											 
																										);
																								 																	
		Main_GoodRecords				:= Main_N.ExpandedInFile(	
																											 dt_vendor_first_reported_Invalid 			= 0 and
																											 dt_vendor_last_reported_Invalid 				= 0 and
																											 dt_first_seen_Invalid 									= 0 and
																											 dt_last_seen_Invalid 									= 0 and
																											 corp_ra_dt_first_seen_Invalid 					= 0 and
																											 corp_ra_dt_last_seen_Invalid 					= 0 and
																											 corp_key_Invalid 											= 0 and
																											 corp_vendor_Invalid 										= 0 and
																											 corp_state_origin_Invalid 					 		= 0 and
																											 corp_process_date_Invalid						  = 0 and
																											 corp_orig_sos_charter_nbr_Invalid 			= 0 and
																											 corp_legal_name_Invalid 								= 0 and
																											 corp_ln_name_type_cd_Invalid 					= 0 and
																											 corp_ln_name_type_desc_Invalid 				= 0 and
																											 corp_address1_type_cd_Invalid 					= 0 and
																											 corp_address1_type_desc_Invalid 				= 0 and
																											 corp_status_desc_Invalid 							= 0 and
																											 corp_standing_Invalid 									= 0 and
																											 corp_inc_state_Invalid 								= 0 and
																											 corp_inc_date_Invalid 									= 0 and
																											 corp_term_exist_cd_Invalid 						= 0 and
																											 corp_term_exist_exp_Invalid 						= 0 and
																											 corp_term_exist_desc_Invalid 					= 0 and
																											 corp_foreign_domestic_ind_Invalid 			= 0 and
																											 corp_forgn_state_cd_Invalid  					= 0 and
																											 corp_forgn_state_desc_Invalid 					= 0 and
																											 corp_forgn_date_Invalid 								= 0 and
																											 corp_orig_org_structure_desc_Invalid 	= 0 and
																											 corp_for_profit_ind_Invalid 						= 0 and
																											 corp_ra_address_type_desc_Invalid 			= 0 and
																											 cont_address_type_cd_Invalid 					= 0 and
																											 recordorigin_Invalid 									= 0 																						 
																								  );

		Main_FailBuild					:= map( corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_NH_Main.Threshold_Percent.CORP_KEY										 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_NH_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => true,
																		corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_NH_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => true,
																	  count(Main_GoodRecords) = 0																																																																																											 => true,																		
																		false
																	);

		Main_ApprovedRecords		:= project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));


		Main_ALL		 						:= sequential( IF(count(Main_BadRecords) <> 0
																						 ,IF (poverwrite
																								 ,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,overwrite,__compressed__)
																								 ,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,__compressed__)
																								 )
																						 )
																					,output(Main_ScrubsWithExamples, all, named('CorpMainNHScrubsReportWithExamples'+fileDate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Main_ScrubsAlert) > 0, Main_MailFile, OUTPUT('CORP2_MAPPING.NH - No "MAIN" Corp Scrubs Alerts'))
																					,Main_ErrorSummary
																					,Main_ScrubErrorReport
																					,Main_SomeErrorValues		
																					,Main_SubmitStats
																				 );

	//********************************************************************
  // SCRUB STOCK
  //********************************************************************	
		Stock_F := mapStock;
		Stock_S := Scrubs_Corp2_Mapping_NH_Stock.Scrubs;						// Scrubs module
		Stock_N := Stock_S.FromNone(Stock_F); 											// Generate the error flags
		Stock_T := Stock_S.FromBits(Stock_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Stock_U := Stock_S.FromExpanded(Stock_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Stock_ErrorSummary			 	:= output(Stock_U.SummaryStats, named('Stock_ErrorSummary_NH'+fileDate));
		Stock_ScrubErrorReport 	 	:= output(choosen(Stock_U.AllErrors, 1000), named('Stock_ScrubErrorReport_NH'+fileDate));
		Stock_SomeErrorValues		 	:= output(choosen(Stock_U.BadValues, 1000), named('Stock_SomeErrorValues_NH'+fileDate));
		Stock_IsScrubErrors		 	 	:= IF(count(Stock_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Stock_OrbitStats				 	:= Stock_U.OrbitStats();

		//Outputs files
		Stock_CreateBitMaps				:= output(Stock_N.BitmapInfile,,'~thor_data::corp_NH_scrubs_bits',overwrite,compressed);	//long term storage
		Stock_TranslateBitMap			:= output(Stock_T);

		//Submits Profile's stats to Orbit
		Stock_SubmitStats 			  := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_NH_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_NH_Stock').SubmitStats;
		Stock_ScrubsWithExamples  := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_NH_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_NH_Stock').CompareToProfile_with_Examples;

		Stock_ScrubsAlert					:= Stock_ScrubsWithExamples(RejectWarning = 'Y');
		Stock_ScrubsAttachment		:= Scrubs.fn_email_attachment(Stock_ScrubsAlert);
		Stock_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																																 ,'Scrubs CorpStock_NH Report' //subject
																																 ,'Scrubs CorpStock_NH Report' //body
																																 ,(data)Stock_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpNHStockScrubsReport.csv'
																																);

		Stock_BadRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  			<> 0 or
																												corp_vendor_Invalid 									<> 0 or
																												corp_state_origin_Invalid 					 	<> 0 or
																												corp_process_date_Invalid						  <> 0 or
																												corp_sos_charter_nbr_Invalid					<> 0 or
																												stock_class_Invalid	 									<> 0 or 
																												stock_shares_issued_Invalid	 					<> 0 or
																												stock_authorized_nbr_Invalid	 				<> 0 or
																												stock_par_value_Invalid	 							<> 0 
																											 );

		Stock_GoodRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  			= 0 and
																												corp_vendor_Invalid 									= 0 and
																												corp_state_origin_Invalid 					 	= 0 and
																												corp_process_date_Invalid						  = 0 and
																												corp_sos_charter_nbr_Invalid					= 0 and
																												stock_class_Invalid		 								= 0 and
																												stock_shares_issued_Invalid		 				= 0 and 
																												stock_authorized_nbr_Invalid		 			= 0 and 
																												stock_par_value_Invalid		 						= 0 
																											 );
																														
		Stock_FailBuild						:= if(count(Stock_GoodRecords) = 0,true,false);

		Stock_ApprovedRecords			:= project(Stock_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Stock,self := left));

		Stock_ALL									:= sequential( IF(count(Stock_BadRecords) <> 0
																							 ,IF (poverwrite
																									 ,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+state_origin,overwrite,__compressed__)
																									 ,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+state_origin,__compressed__)
																									 )
																							)
																						,output(Stock_ScrubsWithExamples, all, named('CorpStockNHScrubsReportWithExamples'+fileDate))
																						//Send Alerts if Scrubs exceeds thresholds
																						,IF(COUNT(Stock_ScrubsAlert) > 0, Stock_MailFile, OUTPUT('CORP2_MAPPING.NH - No "Stock" Corp Scrubs Alerts'))
																						,Stock_ErrorSummary
																						,Stock_ScrubErrorReport
																						,Stock_SomeErrorValues	
																						,Stock_SubmitStats
																					 );	

	//********************************************************************
  // UPDATE
  //********************************************************************
	Fail_Build						:= IF(AR_FailBuild = true or Event_FailBuild = true or Main_FailBuild = true or Stock_FailBuild = true,true,false);
	IsScrubErrors					:= IF(AR_IsScrubErrors = true or Event_IsScrubErrors = true  or Main_IsScrubErrors = true or Stock_IsScrubErrors = true,true,false);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::AR_' 		+ state_origin, AR_ApprovedRecords	 , write_ar,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Event_' 	+ state_origin, Event_ApprovedRecords, write_event,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Main_' 	+ state_origin, Main_ApprovedRecords , write_main,,,pOverwrite);	
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Stock_' 	+ state_origin, Stock_ApprovedRecords, write_stock,,,pOverwrite);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::AR_' 		+ state_origin, AR_F		, write_fail_ar,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Event_' 	+ state_origin, Event_F	, write_fail_event,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Main_' 	+ state_origin, Main_F	, write_fail_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Stock_' 	+ state_origin, Stock_F	, write_fail_stock,,,pOverwrite);

	mapNH := sequential (if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
											// ,Corp2_Raw_NH.Build_Bases(filedate,version,puseprod).All									
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
																		 ,if(count(Main_BadRecords) <> 0 or count(AR_BadRecords) <> 0 or count(Event_BadRecords)<>0 or count(Stock_BadRecords)<>0
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,count(Event_BadRecords)<>0,count(Stock_BadRecords)<>0,count(Main_BadRecords),count(AR_BadRecords),count(Event_BadRecords),count(Stock_BadRecords),count(Main_ApprovedRecords),count(AR_ApprovedRecords),count(Event_ApprovedRecords),count(Stock_ApprovedRecords)).RecordsRejected																				 
																				 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,count(Event_BadRecords)<>0,count(Stock_BadRecords)<>0,count(Main_BadRecords),count(AR_BadRecords),count(Event_BadRecords),count(Stock_BadRecords),count(Main_ApprovedRecords),count(AR_ApprovedRecords),count(Event_ApprovedRecords),count(Stock_ApprovedRecords)).MappingSuccess																				 
																				 )
																		 ,if(IsScrubErrors
																				 ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,AR_IsScrubErrors,Event_IsScrubErrors,Stock_IsScrubErrors).FieldsInvalidPerScrubs
																				 )
																		 ) //if Fail_Build <> true																			
												 ,SEQUENTIAL (write_fail_ar
																		 ,write_fail_event
																		 ,write_fail_main
																		 ,write_fail_stock												 
																		 ,Corp2_Mapping.Send_Email(state_origin,version).MappingFailed
																		 ) //if Fail_Build = true
												 )
										);
										
	isFileDateValid := if((string)std.date.today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
	return sequential (	 if(isFileDateValid
													,mapNH
													,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																			,FAIL('Corp2_Mapping.'+state_origin+' failed.  An invalid filedate was passed in as a parameter.')
																			)
													)
										);

	end;	// end of Update function		 
	
end; // end of NH module