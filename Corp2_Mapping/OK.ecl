Import ut, std, Tools, corp2, versioncontrol, Scrubs, Corp2_Raw_OK, Scrubs_Corp2_Mapping_OK_Main, Scrubs_Corp2_Mapping_OK_Event;

export OK := MODULE; 
		
	 Export Update(String fileDate, String version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) := function
	
	  // Vendor Input Files - Distribute on id then sort and dedup on the whole record
    f01_Entity     := dedup(sort(distribute(Corp2_Raw_OK.Files(filedate,pUseProd).input.f01_Entity,    hash(f01_Filing_Number)),record,local), record,local) : independent;	
	  f02_Address    := dedup(sort(distribute(Corp2_Raw_OK.Files(filedate,pUseProd).input.f02_Address,   hash(f02_Address_ID)),   record,local), record,local) : independent;	
		f03_Agent      := dedup(sort(distribute(Corp2_Raw_OK.Files(filedate,pUseProd).input.f03_Agent,     hash(f03_Filing_Number)),record,local), record,local) : independent;	
		f04_Officer    := dedup(sort(distribute(Corp2_Raw_OK.Files(filedate,pUseProd).input.f04_Officer,   hash(f04_Filing_Number)),record,local), record,local) : independent;	
		f05_Names      := dedup(sort(distribute(Corp2_Raw_OK.Files(filedate,pUseProd).input.f05_Names,     hash(f05_Filing_Number)),record,local), record,local) : independent;	
		f06_AssocEnt   := dedup(sort(distribute(Corp2_Raw_OK.Files(filedate,pUseProd).input.f06_AssocEnt,  hash(f06_Filing_Number)),record,local), record,local) : independent;	
		f07_StockData  := dedup(sort(distribute(Corp2_Raw_OK.Files(filedate,pUseProd).input.f07_StockData, hash(f07_Filing_Number)),record,local), record,local) : independent;	
		f08_StockInfo  := dedup(sort(distribute(Corp2_Raw_OK.Files(filedate,pUseProd).input.f08_StockInfo, hash(f08_Filing_Number)),record,local), record,local) : independent;	
		f12_CorpType   := dedup(sort(distribute(Corp2_Raw_OK.Files(filedate,pUseProd).input.f12_CorpType,  hash(f12_Corp_Type_ID)), record,local), record,local) : independent;	
		f17_CorpFiling := dedup(sort(distribute(Corp2_Raw_OK.Files(filedate,pUseProd).input.f17_CorpFiling,hash(f17_Filing_Number)),record,local), record,local) : independent;	

		state_origin	 := 'OK';
		state_fips	 	 := '40';	
		state_desc	 	 := 'OKLAHOMA';	

		//---------- Begin CORP Mapping --------------------------------------------------------------//
											
		// Lookup Corp Type Description from f12_CorpType and add it to f01_Entity File
    f01_EntitySort := sort(distribute(f01_Entity, hash(f01_Corp_Type_ID)),f01_Corp_Type_ID,local);		
				
		Corp2_Raw_OK.Layouts.EntityLookups findCorpType(Corp2_Raw_OK.Layouts.Entity_01_Layout input, Corp2_Raw_OK.Layouts.CorpType_12_Layout r ) := transform
			self.Corp_Type_Desc	:= r.f12_Corp_Type_Desc;
			self         		  	:= input;
			self                := [];
		end; 
	
		addCorpType := join(	f01_EntitySort, f12_CorpType,  // Both are sorted on Corp_Type_ID
													trim(left.f01_Corp_Type_ID,left,right) = trim(right.f12_Corp_Type_ID,left,right),
													findCorpType(left,right),
													left outer, lookup);	
		
		// Lookup Corp Address fields from f02_Address file
    addCorpTypeSort := sort(distribute(addCorpType, hash(f01_Address_ID)),f01_Address_ID,local);	
		
		Corp2_Raw_OK.Layouts.EntityLookups findCorpAddr(Corp2_Raw_OK.Layouts.EntityLookups input, Corp2_Raw_OK.Layouts.Address_02_Layout r ) := transform
			self.corp_Address1	    := r.f02_Address1;
			self.corp_Address2	    := r.f02_Address2;
			self.corp_City	        := Corp2_Raw_OK.Functions.FixCity(r.f02_City);
			self.corp_State	        := if (corp2.t2u(r.f02_State) in ['OKLA','OKL'], 'OK', r.f02_State);
			self.corp_Zip_Code	    := r.f02_Zip_Code;
			self.corp_Zip_Extension	:= r.f02_Zip_Extension;
			self.corp_Country 	    := r.f02_Country;
			self         		  	    := input;
			self                    := [];
		end; 
	
		addCorpAddr := join( addCorpTypeSort, f02_Address,  // Both are sorted on Address_ID
												 trim(left.f01_Address_ID,left,right) = trim(right.f02_Address_ID,left,right),
												 findCorpAddr(left,right),
												 left outer, lookup);	
				
		// Join Corp (Entity) and Agent file
    addCorpAddrSort := sort(distribute(addCorpAddr, hash(f01_Filing_Number)),f01_Filing_Number,local);			
		
		Corp2_Raw_OK.Layouts.EntityLookups MergeCorpAgent(Corp2_Raw_OK.Layouts.EntityLookups l, Corp2_Raw_OK.Layouts.Agent_03_Layout r ) := transform
			self.Agent_Filing_Number := r.f03_Filing_Number;
			self.Agent_Address_ID    := r.f03_Address_ID;
			self.Agent_Business_Name := r.f03_Business_Name;
			self.Agent_Last_Name     := r.f03_Agent_Last_Name;
		  self.Agent_First_Name    := r.f03_Agent_First_Name;
			self.Agent_Middle_Name   := r.f03_Agent_Middle_Name;
			self.Agent_Suffix_Id     := r.f03_Agent_Suffix_Id;
			self.Agent_Creation_Date := r.f03_Creation_Date;
			self.Agent_Inactive_Date := r.f03_Inactive_Date;
			self.Agent_SOS_RA_Flag   := r.f03_SOS_RA_Flag;
			self										 := l;
			self                     := [];
		end; 
		
		jCorpAgent := join(addCorpAddrSort, f03_Agent,    // Both are sorted on Filing_Number
											 trim(left.f01_Filing_Number,left,right) = trim(right.f03_Filing_Number,left,right),
											 MergeCorpAgent(left,right),
											 left outer);		
		
		// Lookup Agent Address fields from f02_Address file
		jCorpAgentSort := sort(distribute(jCorpAgent, hash(Agent_Address_ID)),Agent_Address_ID,local);
		
		Corp2_Raw_OK.Layouts.EntityLookups findAgentAddr(Corp2_Raw_OK.Layouts.EntityLookups input, Corp2_Raw_OK.Layouts.Address_02_Layout r ) := transform
			self.Agent_Address1	     := r.f02_Address1;
			self.Agent_Address2	     := r.f02_Address2;
			self.Agent_City	         := Corp2_Raw_OK.Functions.FixCity(r.f02_City);
			self.Agent_State	       := if (corp2.t2u(r.f02_State) in ['OKLA','OKL'], 'OK', r.f02_State);
			self.Agent_Zip_Code	     := r.f02_Zip_Code;
			self.Agent_Zip_Extension := r.f02_Zip_Extension;
			self.Agent_Country 	     := r.f02_Country;
			self         		  	     := input;
			self                     := [];
		end; 
	
		addAgentAddr := join( jCorpAgentSort, f02_Address,     // Both are sorted on Address_ID
												 trim(left.Agent_Address_ID,left,right) = trim(right.f02_Address_ID,left,right),
												 findAgentAddr(left,right),
												 left outer, lookup);	
	
		// Join Entity file to f05_Names 
		addAgentAddrSort := sort(distribute(addAgentAddr, hash(f01_Filing_Number)),f01_Filing_Number,local);
		
		Corp2_Raw_OK.Layouts.EntityLookups MergeNames(Corp2_Raw_OK.Layouts.EntityLookups l, Corp2_Raw_OK.Layouts.Names_05_Layout r ) := transform
	    self   := r;
			self   := l;
			self   := [];
		end; 
		
		addNames := join(addAgentAddrSort, f05_Names,     // Both are sorted on Filing_Number
										 trim(left.f01_Filing_Number,left,right) = trim(right.f05_Filing_Number,left,right),
										 MergeNames(left,right),
										 left outer);
														
		// Join Entity file to f06_AssocEnt
		Corp2_Raw_OK.Layouts.EntityLookups MergeAssocEnt(Corp2_Raw_OK.Layouts.EntityLookups l, Corp2_Raw_OK.Layouts.AssocEnt_06_Layout r ) := transform
			self   := r;
			self   := l;
			self   := [];
		end; 
		
		jCorpRecs := join(addNames, f06_AssocEnt,     // Both are sorted on Filing_Number     
											trim(left.f01_Filing_Number,left,right) = trim(right.f06_Filing_Number,left,right),
											MergeAssocEnt(left,right),
											left outer);
		
		// Transform for mapping Corp Legal records to Common Main
		Corp2_Mapping.LayoutsCommon.Main CorpTrf(Corp2_Raw_OK.Layouts.EntityLookups input) := transform
			self.dt_first_seen							:= (integer)fileDate;
			self.dt_last_seen								:= (integer)fileDate;
			self.dt_vendor_first_reported		:= (integer)fileDate;
			self.dt_vendor_last_reported		:= (integer)fileDate;
			self.corp_ra_dt_first_seen			:= (integer)fileDate;
			self.corp_ra_dt_last_seen				:= (integer)fileDate;			
			self.corp_key										:= state_fips + '-' + corp2.t2u(input.f01_Filing_Number);
			self.corp_vendor								:= state_fips;
			self.corp_state_origin					:= state_origin;
			self.corp_process_date					:= fileDate;
			self.corp_orig_sos_charter_nbr	:= corp2.t2u(input.f01_Filing_Number);
			self.corp_inc_state							:= state_origin;
			self.corp_legal_name						:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.f05_Name).BusinessName;
			self.corp_status_cd							:= corp2.t2u(input.f01_Status_ID);
			self.corp_status_desc						:= Corp2_Raw_OK.functions.GetCorpStatusDesc(corp2.t2u(input.f01_Status_ID));
			self.corp_orig_org_structure_cd	:= if (corp2.t2u(input.f01_Corp_Type_ID) not in ['1','2','3','4','5','6'] and corp2.t2u(input.Corp_Type_Desc) <> ''
																						,corp2.t2u(input.f01_Corp_Type_ID), '');	
	    self.corp_orig_org_structure_desc := if (self.corp_orig_org_structure_cd <> '' ,corp2.t2u(input.Corp_Type_Desc), '');
			self.corp_ln_name_type_cd				:= map (corp2.t2u(input.f05_Name_Type_ID) in ['1','19'] => '01',
																							corp2.t2u(input.f05_Name_Type_ID) = '2' 				=> 'F',
																							corp2.t2u(input.f05_Name_Type_ID) = '3' 				=> '04',
																							corp2.t2u(input.f05_Name_Type_ID) = '4' 				=> '10',
																							corp2.t2u(input.f05_Name_Type_ID) = '5' 				=> '07',
																							corp2.t2u(input.f05_Name_Type_ID));
			self.corp_ln_name_type_desc			:= map (corp2.t2u(input.f05_Name_Type_ID) in ['1','19'] => 'LEGAL',
																							corp2.t2u(input.f05_Name_Type_ID) = '2' 				=> 'FBN',
																							corp2.t2u(input.f05_Name_Type_ID) = '3'				 	=> 'TRADENAME',
																							corp2.t2u(input.f05_Name_Type_ID) = '4'			 		=> 'SOLICITOR',
																							corp2.t2u(input.f05_Name_Type_ID) = '5' 				=> 'RESERVED',
																							'');
			self.corp_foreign_domestic_ind  := map (corp2.t2u(input.f01_Corp_Type_ID) in ['3','5','7','8','9','10','12','16',
																																													'17','19','20','21','22','26','27',
																																													'28','29','33','35','36','37','38',
																																													'39','40','41','42','49']           => 'D',
																							corp2.t2u(input.f01_Corp_Type_ID) in ['4','6','13','14','15','18','23',
																																													'24','25','30','31','32','34','43'] => 'F',
																							'');	
			self.corp_for_profit_ind        := map (corp2.t2u(input.f01_Corp_Type_ID) in ['16','17','18','42','43']                  => 'N',
																							corp2.t2u(input.f01_Corp_Type_ID) in ['7','8','9','10','12','13','14','15','41'] => 'Y',
																							'');	
				
			ExpirationDate									:= Corp2_Mapping.fValidateDate(input.f01_Expiration_Date).GeneralDate;	
			NumberYears											:= if (corp2.t2u(input.f01_Expiration_Type) not in ['','P']
			                                        ,corp2.t2u(input.f01_Expiration_Type), '');
			
			self.corp_term_exist_cd					:= map(corp2.t2u(input.f01_Perpetual_Flag) = '1' => 'P',
																						 ExpirationDate <> ''                            => 'D',
																						 NumberYears <> ''                               => 'N',
																						 '');
			self.corp_term_exist_desc       := map (self.corp_term_exist_cd = 'P' => 'PERPETUAL',
			                                        self.corp_term_exist_cd = 'D' => 'EXPIRATION DATE',
																							self.corp_term_exist_cd = 'N' => 'NUMBER OF YEARS',
																							'');
			self.corp_term_exist_exp				:= map (self.corp_term_exist_cd = 'D' => ExpirationDate,
			                                        self.corp_term_exist_cd = 'N' => NumberYears,
																							'');
			self.corp_inc_date              := if (corp2.t2u(input.f01_Foreign_State) in ['',state_origin] 
																						,Corp2_Mapping.fValidateDate(input.f01_Creation_Date).PastDate, '');
			self.corp_forgn_date            := if (corp2.t2u(input.f01_Foreign_State) not in ['',state_origin] 
																						,Corp2_Mapping.fValidateDate(input.f01_Creation_Date).PastDate, '');	
			self.corp_status_date						:= Corp2_Mapping.fValidateDate(input.f01_Inactive_Date).PastDate;
			self.corp_filing_date						:= Corp2_Mapping.fValidateDate(input.f01_Foreign_Formation_Date).PastDate;
			self.corp_filing_cd							:= if(self.corp_filing_date <> '' ,'C' ,''); // from old mapper
			self.corp_filing_desc						:= if (self.corp_filing_date <> '', 'HOME STATE INCORPORATION DATE', '');
			self.corp_forgn_state_cd        := if (corp2.t2u(input.f01_Foreign_State) not in ['',state_origin]
																						,corp2.t2u(input.f01_Foreign_State) ,'');
			self.corp_forgn_state_desc      := if(self.corp_forgn_state_cd <> ''
																						,Corp2_Raw_OK.functions.decode_state(self.corp_forgn_state_cd)
																						,'');
			self.corp_country_of_formation  := Corp2_Raw_OK.functions.GetCountry(input.f01_Foreign_Country);
										    
 			pn := (string)(integer)ut.CleanPhone(input.f01_Telephone_Number);
			self.corp_phone_number 	       		 := if (trim(pn) not in ['','0']
			                                         ,map(length(pn)=10 => pn[1..3]+'-'+pn[4..6]+'-'+pn[7..10], 
																							      length(pn)=7	=> pn[1..3]+'-'+pn[4..7],
																							      pn)
																								,''); //only 10 & 7 digit will be hypnenated	
			
      self.corp_address1_type_cd          := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.corp_address1,input.corp_address2,input.corp_city,input.corp_state,input.corp_zip_code + input.corp_zip_extension,input.corp_country).ifAddressExists,'M','');	
			self.corp_address1_type_desc        := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.corp_address1,input.corp_address2,input.corp_city,input.corp_state,input.corp_zip_code + input.corp_zip_extension,input.corp_country).ifAddressExists,'MAILING','');
			self.corp_address1_line1						:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.corp_address1,input.corp_address2,input.corp_city,input.corp_state,input.corp_zip_code + input.corp_zip_extension,input.corp_country).AddressLine1;
			self.corp_address1_line2						:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.corp_address1,input.corp_address2,input.corp_city,input.corp_state,input.corp_zip_code + input.corp_zip_extension,input.corp_country).AddressLine2;
			self.corp_address1_line3						:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.corp_address1,input.corp_address2,input.corp_city,input.corp_state,input.corp_zip_code + input.corp_zip_extension,input.corp_country).AddressLine3;			
			self.corp_prep_addr1_line1					:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.corp_address1,input.corp_address2,input.corp_city,input.corp_state,input.corp_zip_code,input.corp_country).PrepAddrLine1;			
			self.corp_prep_addr1_last_line	    := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.corp_address1,input.corp_address2,input.corp_city,input.corp_state,input.corp_zip_code,input.corp_country).PrepAddrLastLine;
			
			self.corp_ra_address_type_cd        := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.agent_address1,input.agent_address2,input.agent_city,input.agent_state,input.agent_zip_code + input.agent_zip_extension,input.agent_country).ifAddressExists,'R','');
			self.corp_ra_address_type_desc      := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.agent_address1,input.agent_address2,input.agent_city,input.agent_state,input.agent_zip_code + input.agent_zip_extension,input.agent_country).ifAddressExists,'REGISTERED OFFICE','');
			self.corp_ra_address_line1				  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.agent_address1,input.agent_address2,input.agent_city,input.agent_state,input.agent_zip_code + input.agent_zip_extension,input.agent_country).AddressLine1;
			self.corp_ra_address_line2				  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.agent_address1,input.agent_address2,input.agent_city,input.agent_state,input.agent_zip_code + input.agent_zip_extension,input.agent_country).AddressLine2;
			self.corp_ra_address_line3				  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.agent_address1,input.agent_address2,input.agent_city,input.agent_state,input.agent_zip_code + input.agent_zip_extension,input.agent_country).AddressLine3;			
			self.ra_prep_addr_line1							:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.agent_address1,input.agent_address2,input.agent_city,input.agent_state,input.agent_zip_code,input.agent_country).PrepAddrLine1;			
			self.ra_prep_addr_last_line 				:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.agent_address1,input.agent_address2,input.agent_city,input.agent_state,input.agent_zip_code,input.agent_country).PrepAddrLastLine;

			self.corp_ra_full_name							:= if (corp2.t2u(input.Agent_Business_Name) <> ''
																								,Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.Agent_Business_Name).BusinessName
																								,Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.Agent_First_Name +' '+ input.Agent_Middle_Name +' '+ input.Agent_Last_Name
																								     +' '+ Corp2_Raw_OK.functions.GetSuffix(input.Agent_Suffix_ID)).BusinessName);
			self.corp_ra_effective_date					:= Corp2_Mapping.fValidateDate(input.Agent_Creation_Date).GeneralDate;
			self.corp_ra_resign_date  					:= Corp2_Mapping.fValidateDate(input.Agent_Inactive_Date).GeneralDate;
			self.corp_ra_addl_info              := if (self.corp_ra_resign_date <> '', 'INACTIVE DATE: ' + self.corp_ra_resign_date, '');
			self.corp_merger_indicator          := corp2.t2u(input.f06_Primary_Capacity_ID);
			self.corp_merger_desc           		:= Corp2_Raw_OK.functions.GetCapacityDesc(corp2.t2u(input.f06_Capacity_ID));
			self.corp_merger_name               := corp2.t2u(input.f06_Associated_Entity_Name);
			self.corp_survivor_corporation_id   := if (corp2.t2u(input.f06_Primary_Capacity_ID) = '1' and
																								 corp2.t2u(input.f06_Entity_Filing_Number) <> '999999999'
																							  ,corp2.t2u(input.f06_Entity_Filing_Number), '');
			self.corp_merged_corporation_id     := if (corp2.t2u(input.f06_Primary_Capacity_ID) = '2' and
			                                           corp2.t2u(input.f06_Entity_Filing_Number) <> '999999999'
			                                          ,corp2.t2u(input.f06_Entity_Filing_Number), '');																					
			self.corp_merger_id                 := if (corp2.t2u(input.f06_Primary_Capacity_ID) in ['3','4','5','6','7','8','9'] and
																								 corp2.t2u(input.f06_Entity_Filing_Number) <> '999999999'
																							  ,corp2.t2u(input.f06_Entity_Filing_Number), '');
			self.corp_merger_date     					:= Corp2_Mapping.fValidateDate(input.f06_Entity_Filing_Date).PastDate;
			self.corp_merger_effective_date     := Corp2_Mapping.fValidateDate(input.f06_Inactive_Date).PastDate;
			self.corp_consent_flag_for_protected_name := map (corp2.t2u(input.f05_Consent_Filing_Number) = '1' => 'Y',
			                                                  corp2.t2u(input.f05_Consent_Filing_Number) = '0' => 'N',
																												'');																								
			self.corp_name_reservation_expiration_date := Corp2_Mapping.fValidateDate(input.f05_Expire_Date).GeneralDate;
			self.corp_name_effective_date		 		:= Corp2_Mapping.fValidateDate(input.f05_Creation_Date).GeneralDate;
			self.corp_name_status_date		 		  := Corp2_Mapping.fValidateDate(input.f05_Inactive_Date).GeneralDate;
			self.corp_name_status_cd            := corp2.t2u(input.f05_Name_Status_ID);
			self.corp_name_status_desc          := Corp2_Raw_OK.functions.GetNameStatusDesc(input.f05_Name_Status_ID);
			self.corp_name_comment					    := if (corp2.t2u(input.f06_Entity_Filing_Number) <> ''
			                                       ,'ASSOCIATED ENTITY FILING NUMBER: ' + corp2.t2u(input.f06_Entity_Filing_Number) ,''); // from old mapper
			self.recordOrigin                   := 'C';
			self 																:= [];
		end; 
		
		MapCorp				:= project(jCorpRecs, CorpTrf(left));	
	  //---------- End CORP Mapping --------------------------------------------------------------//


		//---------- Begin CONTACTS Mapping --------------------------------------------------------------//
 
    // Lookup Officer Addresses	
    f04_OfficerSort := sort(distribute(f04_Officer, hash(f04_Address_ID)),f04_Address_ID,local);			
		
		Corp2_Raw_OK.Layouts.OfficerLookups findOfficerAddr(Corp2_Raw_OK.Layouts.Officer_04_Layout l, Corp2_Raw_OK.Layouts.Address_02_Layout r ) := transform
			self	:= l;
			self	:= r;
			self  := [];
		end; 
		
		jOfficerAddress := join(f04_OfficerSort, f02_Address,     // Both are sorted on Address_ID
														trim(left.f04_Address_ID,left,right) = trim(right.f02_Address_ID,left,right),
														findOfficerAddr(left,right),
														left outer);	
																	
    // Lookup the Corp Legal Name 
		jOfficerAddressSort := sort(distribute(jOfficerAddress, hash(f04_Filing_Number)),f04_Filing_Number,local);			
		
		Corp2_Raw_OK.Layouts.OfficerLookups MergeOffAddrEnt(Corp2_Raw_OK.Layouts.OfficerLookups l, Corp2_Raw_OK.Layouts.Entity_01_Layout r ) := transform
			self.f01_name	:= r.f01_name;
			self					:= l;
			self  				:= [];
		end; 
		
		jOfficerAddrEnt := join( jOfficerAddressSort, f01_Entity,     // Both are sorted on Filing_Number
																		trim(left.f04_Filing_Number,left,right) = trim(right.f01_Filing_Number,left,right),
																		MergeOffAddrEnt(left,right),
																		left outer, lookup);	
																		
		// Normalize on the 2 Contact Effective Dates	
   	Corp2_Raw_OK.Layouts.normContLayout normContTrf(Corp2_Raw_OK.Layouts.OfficerLookups l, unsigned1 cnt) := transform,
			        skip(cnt=2 and l.f04_Inactive_Date in ['','00/00/0000'])
			self.norm_ContEff_Date	:= choose(cnt, l.f04_Creation_Date, l.f04_Inactive_Date);
			self.norm_type  				:= choose(cnt, 'A', 'I');	
			self 						   			:= l;
		end;
		
		normContacts	:= normalize(jOfficerAddrEnt, 2, normContTrf(left, counter));		
																
		// Transform for mapping Contacts records to Common Main														
		Corp2_Mapping.LayoutsCommon.Main ContTrf(Corp2_Raw_OK.Layouts.normContLayout input) := transform
			self.dt_first_seen							:= (integer)fileDate;
			self.dt_last_seen								:= (integer)fileDate;
			self.dt_vendor_first_reported		:= (integer)fileDate;
			self.dt_vendor_last_reported		:= (integer)fileDate;
			self.corp_ra_dt_first_seen			:= (integer)fileDate;
			self.corp_ra_dt_last_seen				:= (integer)fileDate;	
			self.corp_key										:= state_fips + '-' + corp2.t2u(input.f04_Filing_Number);
			self.corp_vendor								:= state_fips;
			self.corp_state_origin					:= state_origin;
			self.corp_process_date					:= fileDate;
			self.corp_inc_state							:= state_origin;
			self.corp_orig_sos_charter_nbr	:= corp2.t2u(input.f04_Filing_Number);
			self.corp_legal_name						:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.f01_Name).BusinessName;
			self.cont_full_name							:= if (corp2.t2u(input.f04_Business_Name) <> ''
																						 ,Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.f04_Business_Name).BusinessName
																						 ,corp2.t2u(input.f04_Officer_First_Name +' '+ input.f04_Officer_Middle_Name +' '+ input.f04_Officer_Last_Name 
																						    +' '+	Corp2_Raw_OK.functions.GetSuffix(input.f04_Officer_Suffix_ID)));
			self.cont_effective_date				:= Corp2_Mapping.fValidateDate(input.norm_ContEff_Date).GeneralDate;
			self.cont_effective_cd          := if (self.cont_effective_date <> '', input.norm_type, '');
			self.cont_effective_desc        := map (self.cont_effective_date <> '' and input.norm_type = 'A' => 'ASSIGNED', 
																						  self.cont_effective_date <> '' and input.norm_type = 'I' => 'INACTIVE',
																						  ''); 																								
			self.cont_title1_desc						:= corp2.t2u(input.f04_Officer_Title);
			
			fixCity := Corp2_Raw_OK.Functions.FixCity(input.f02_City);
			fixState:= if (corp2.t2u(input.f02_State) in ['OKLA','OKL'], 'OK', input.f02_State);
			self.cont_address_type_cd       := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.f02_Address1,input.f02_Address2,fixCity,fixState,input.f02_Zip_Code + input.f02_Zip_Extension).ifAddressExists,'T','');
			self.cont_address_type_desc     := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.f02_Address1,input.f02_Address2,fixCity,fixState,input.f02_Zip_Code + input.f02_Zip_Extension).ifAddressExists,'CONTACT','');
			self.cont_address_line1			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.f02_Address1,input.f02_Address2,fixCity,fixState,input.f02_Zip_Code + input.f02_Zip_Extension).AddressLine1;
			self.cont_address_line2			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.f02_Address1,input.f02_Address2,fixCity,fixState,input.f02_Zip_Code + input.f02_Zip_Extension).AddressLine2;
			self.cont_address_line3			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.f02_Address1,input.f02_Address2,fixCity,fixState,input.f02_Zip_Code + input.f02_Zip_Extension).AddressLine3;
			self.cont_prep_addr_line1			  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.f02_Address1,input.f02_Address2,fixCity,fixState,input.f02_Zip_Code).PrepAddrLine1;
			self.cont_prep_addr_last_line	  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.f02_Address1,input.f02_Address2,fixCity,fixState,input.f02_Zip_Code).PrepAddrLastLine;
      self.cont_addl_info             := if (Corp2_Mapping.fValidateDate(input.f04_inactive_date).GeneralDate <> ''
			                                       ,'INACTIVE DATE: ' + Corp2_Mapping.fValidateDate(input.f04_inactive_date).GeneralDate ,''); // from old mapper		
			self.recordOrigin               := 'T';
			self 													  := [];	
  	end;

		MapCont	:= project(normContacts, ContTrf(left));
		//---------- End CONTACTS Mapping --------------------------------------------------------------//
		
	 
	 //---------- Begin STOCKS Mapping --------------------------------------------------------------//
	
	 // Join StockData and StockInfo files
  	Corp2_Raw_OK.Layouts.StockLookups joinStock(Corp2_Raw_OK.Layouts.StockData_07_Layout l, Corp2_Raw_OK.Layouts.StockInfo_08_Layout r ) := transform
			self	:= l;
			self	:= r;
			self  := [];
		end; 
		
		sortf07_StockData  := sort(f07_StockData ,f07_Filing_Number,local) : independent;	
		
		jStockFiles := join(sortf07_StockData, f08_StockInfo,     // Both are sorted on Filing_Number
															corp2.t2u(left.f07_Filing_Number) = corp2.t2u(right.f08_Filing_Number),
															joinStock(left,right),
															left outer);	
		 
		// Transform for mapping Stock records to Common Stock											
		Corp2_Mapping.LayoutsCommon.Stock StockTrf(Corp2_Raw_OK.Layouts.StockLookups input):=transform
			self.corp_key										:= state_fips + '-' + corp2.t2u(input.f07_Filing_Number);	
			self.corp_vendor								:= state_fips;		
			self.corp_state_origin					:= state_origin;
			self.corp_process_date					:= fileDate;
  		self.corp_sos_charter_nbr				:= corp2.t2u(input.f07_Filing_Number);	
			self.stock_type									:= Corp2_Raw_OK.functions.GetStockType(input.f07_Stock_Type_ID);
			self.stock_stock_series         := corp2.t2u(input.f07_Stock_Series);
			self.stock_class								:= if (corp2.t2u(input.f07_Stock_Series) <> 'NONE'
																						,corp2.t2u(input.f07_Stock_Series) ,''); // from old mapper
			self.stock_authorized_nbr       := corp2.t2u(input.f07_Share_Volume);
			self.stock_par_value						:= regexreplace('^[.]',input.f07_Par_Value,'0.',NOCASE);
			self.stock_addl_info            := if (corp2.t2u(input.f08_Qualify_Flag) = '1'
			                                       ,'ENTITY IS QUALIFIED AND NO MORE OWING ANNUAL CERTIFICATE', '');
			self.stock_actual_amt_invested_in_state := (integer)input.f08_Actual_Amt_Invested;
			self.stock_stock_description    := if (corp2.t2u(input.f08_pd_on_credit) <> '', 'AMOUNT PAID ON CREDIT', '');
			self.stock_total_capital        := corp2.t2u(input.f08_Tot_Auth_Capital);
			self														:=[];
		end;
		//---------- End STOCKS Mapping --------------------------------------------------------------//
		
		
		//---------- Begin EVENTS Mapping --------------------------------------------------------------//
					
		// Normalize on the 3 Event Filing Dates 	
		Corp2_Raw_OK.Layouts.normEventLayout normTrf(Corp2_Raw_OK.Layouts.CorpFiling_17_Layout l, unsigned1 cnt) := transform,
		     skip((cnt=1 and Corp2_Mapping.fValidateDate(l.f17_Effective_Date).PastDate = '') or
				      (cnt=2 and Corp2_Mapping.fValidateDate(l.f17_Filing_Date).PastDate    = '') or
							(cnt=3 and Corp2_Mapping.fValidateDate(l.f17_Inactive_Date).PastDate  = ''))
			self.norm_Event_Filing_Date	:= choose(cnt, l.f17_Effective_Date, l.f17_Filing_Date, l.f17_Inactive_Date);
			self.norm_type  						:= choose(cnt, 'E', 'F', 'I');											  		
			self 						   					:= l;
		end;
		
		normEvents	:= normalize(f17_CorpFiling, 3, normTrf(left, counter));												
														
		// Transform for mapping EVENTS records to Common Events
		Corp2_Mapping.LayoutsCommon.Events EventTrf(Corp2_Raw_OK.Layouts.normEventLayout input):=transform,
			 skip(input.f17_Filing_Type_ID in ['13032','131','13110','14032','141','14110','15032','151','15110',
				/* skipping AR types*/	         '19040','19145','19149','19150','20040','20149','21040','21149','22040',
																				 '22149','23040','23145','23149','24040','24149','25040','25149','26040',
																				 '26149','27040','27149','28040','29040','30040','30145','30149','31040',
																				 '32040','33040','34040','31149','52040'])
			self.corp_key										:= state_fips + '-' + corp2.t2u(input.f17_Filing_Number);	
			self.corp_vendor								:= state_fips;		
			self.corp_state_origin					:= state_origin;
			self.corp_process_date					:= fileDate;
			self.corp_sos_charter_nbr				:= corp2.t2u(input.f17_Filing_Number);
			self.event_filing_reference_nbr := corp2.t2u(input.f17_Document_Number);
			self.event_filing_cd						:= corp2.t2u(input.f17_Filing_Type_ID);
			self.event_filing_desc					:= Corp2_Raw_OK.Functions.GetEventDesc(input.f17_Filing_Type_ID);
			self.event_filing_date					:= Corp2_Mapping.fValidateDate(input.norm_Event_Filing_Date).PastDate;
			self.event_date_type_cd					:= map (self.event_filing_date <> '' and input.norm_type = 'E' => 'EFF', 
																						  self.event_filing_date <> '' and input.norm_type = 'F' => 'FIL',
																						  self.event_filing_date <> '' and input.norm_type = 'I' => 'INA',
																						  ''); 
  		self.event_date_type_desc				:= map (self.event_filing_date <> '' and input.norm_type = 'E' => 'EFFECTIVE', 
																						  self.event_filing_date <> '' and input.norm_type = 'F' => 'FILING',
																						  self.event_filing_date <> '' and input.norm_type = 'I' => 'INACTIVE',
																						  '');
  		self														:=[];
		end;	
		//---------- End EVENT Mapping --------------------------------------------------------------//
		 
		
		//---------- Begin AR Mapping --------------------------------------------------------------//	
			
    // Join f01_Entity file with f17_CorpFiling file for mapping AR records
 		Corp2_Raw_OK.Layouts.ARLookups joinEntWithFiling(Corp2_Raw_OK.Layouts.CorpFiling_17_Layout l, Corp2_Raw_OK.Layouts.Entity_01_Layout r ) := transform
				self	:= l;
				self 	:= r;
				self  := [];
		end; 
	
		jEntFiling := join(	f17_CorpFiling, f01_Entity,  // Both are sorted on Filing_Number
												trim(left.f17_Filing_Number,left,right) = trim(right.f01_Filing_Number,left,right),
												joinEntWithFiling(left,right),
												left outer);				
			
		// Transform for mapping AR records to Common AR
		Corp2_Mapping.LayoutsCommon.AR ARTrf(Corp2_Raw_OK.Layouts.ARLookups  input):=transform,
			skip(input.f17_Filing_Type_ID not in ['13032','131','13110','14032','141','14110','15032','151','15110',
				/* only transforming AR types*/	    '19040','19145','19149','19150','20040','20149','21040','21149','22040',
																				    '22149','23040','23145','23149','24040','25040','26040','26149',
																						'27040','27149','28040','29040','30040','30145','30149','31040','32040',
																						'33040','34040','31149','52040'])																			 
			self.corp_key							:= state_fips + '-' + corp2.t2u(input.f01_Filing_Number);	
			self.corp_vendor					:= state_fips;		
		 	self.corp_state_origin		:= state_origin;
			self.corp_process_date		:= fileDate;
			self.corp_sos_charter_nbr	:= corp2.t2u(input.f01_Filing_Number);
			self.ar_report_dt   			:= Corp2_Mapping.fValidateDate(input.f01_Last_Report_Filed_Date).GeneralDate;
			self.ar_due_dt						:= Corp2_Mapping.fValidateDate(input.f01_Report_Due_Date).GeneralDate;
			self.ar_report_nbr				:= corp2.t2u(input.f17_Document_number);
			self.ar_type              := corp2.t2u(input.f17_Filing_Type);
			self.ar_filed_dt   			  := Corp2_Mapping.fValidateDate(input.f17_Filing_date).GeneralDate; 
			self											:=[];
		end;
		//---------- End AR Mapping -----------------------------------------------------------------//
		
	 																
		//-----------------------------------------------------------//
		// Build the Final Mapped Files
		//-----------------------------------------------------------//
		MapMain   := dedup(sort(distribute(MapCorp + MapCont,hash(corp_key)), record,local), record,local) : independent;
		MapStock	:= dedup(sort(distribute(project(jStockFiles, StockTrf(left)),hash(corp_key)), record,local), record,local);
		MapEvent	:= dedup(sort(distribute(project(normEvents, EventTrf(left)),hash(corp_key)), record,local), record,local);
		MapAR			:= dedup(sort(distribute(project(jEntFiling, ARTrf(left)),hash(corp_key)), record,local), record,local);
		
	//--------------------------------------------------------------------	
  // Scrubs for MAIN
  //--------------------------------------------------------------------
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_OK_Main.Scrubs;        // OK scrubs module
		Main_N := Main_S.FromNone(Main_F); 										// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     	// Use the FromBits module; mOKes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_OK'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_OK'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_OK'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_OK_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

    //Submits Profile's stats to Orbit
    Main_SubmitStats          := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_OK_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_OK_Main').SubmitStats;

		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_OK_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_OK_Main').CompareToProfile_with_Examples;
		
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.AttachedList
																																	 ,'Scrubs CorpMain_OK Report' //subject
																																	 ,'Scrubs CorpMain_OK Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpOKMainScrubsReport.csv'
																																	 ,
																																	 );		
																																 
		Main_BadRecords := Main_T.ExpandedInFile(	dt_vendor_first_reported_invalid 	 <> 0 or
																							dt_vendor_last_reported_invalid 	 <> 0 or
																							dt_first_seen_invalid 			       <> 0 or
																							dt_last_seen_invalid 			         <> 0 or
																							corp_ra_dt_first_seen_invalid 		 <> 0 or
																							corp_ra_dt_last_seen_invalid 			 <> 0 or
																							corp_key_invalid 			             <> 0 or
																							corp_vendor_invalid 			         <> 0 or
																							corp_state_origin_invalid 			   <> 0 or
																							corp_process_date_invalid 			   <> 0 or
																							corp_orig_sos_charter_nbr_invalid  <> 0 or
																							corp_legal_name_invalid 			     <> 0 or
																							corp_filing_date_invalid           <> 0 or
																							corp_status_cd_invalid 						 <> 0 or
																							corp_status_date_invalid           <> 0 or
																							corp_inc_state_invalid 			       <> 0 or
																							corp_inc_date_invalid              <> 0 or
																							corp_foreign_domestic_ind_invalid  <> 0 or
																							corp_forgn_date_invalid            <> 0 or
																							corp_orig_org_structure_cd_invalid <> 0 or
																							corp_for_profit_ind_invalid 			 <> 0 or
																							corp_ra_effective_date_invalid     <> 0 or
																							corp_ra_resign_date_invalid        <> 0 or
																							cont_effective_date_invalid        <> 0 or
																							corp_merger_date_invalid           <> 0 or
																							corp_merger_id_invalid						 <> 0 or	
																							corp_merger_indicator_invalid			 <> 0 or
																							corp_name_effective_date_invalid	 <> 0 or
																							corp_name_reservation_expiration_date_invalid <> 0 or
																							corp_name_status_cd_invalid				 <> 0 or	
																							corp_name_status_date_invalid			 <> 0 or
																							corp_forgn_state_desc_invalid      <> 0 or
																							corp_ln_name_type_cd_invalid       <> 0);

		Main_GoodRecords	:= Main_T.ExpandedInFile( dt_vendor_first_reported_invalid 	 = 0 and
																								dt_vendor_last_reported_invalid 	 = 0 and
																								dt_first_seen_invalid 			       = 0 and
																								dt_last_seen_invalid 			         = 0 and
																								corp_ra_dt_first_seen_invalid 		 = 0 and
																								corp_ra_dt_last_seen_invalid 			 = 0 and
																								corp_key_invalid 			             = 0 and
																								corp_vendor_invalid 			         = 0 and
																								corp_state_origin_invalid 			   = 0 and
																								corp_process_date_invalid 			   = 0 and
																								corp_orig_sos_charter_nbr_invalid  = 0 and
																								corp_legal_name_invalid 			     = 0 and
																								corp_filing_date_invalid           = 0 and
																								corp_status_cd_invalid 						 = 0 and
																								corp_status_date_invalid           = 0 and
																								corp_inc_state_invalid 			       = 0 and
																								corp_inc_date_invalid              = 0 and
																								corp_foreign_domestic_ind_invalid  = 0 and
																								corp_forgn_date_invalid            = 0 and
																								corp_orig_org_structure_cd_invalid = 0 and
																								corp_for_profit_ind_invalid 			 = 0 and
																								corp_ra_effective_date_invalid     = 0 and
																								corp_ra_resign_date_invalid        = 0 and
																								cont_effective_date_invalid        = 0 and
																								corp_merger_date_invalid           = 0 and
																								corp_merger_id_invalid						 = 0 and	
																								corp_merger_indicator_invalid			 = 0 and
																								corp_name_effective_date_invalid	 = 0 and
																								corp_name_reservation_expiration_date_invalid = 0 and
																								corp_name_status_cd_invalid				 = 0 and
																								corp_name_status_date_invalid			 = 0 and
																								corp_forgn_state_desc_invalid      = 0 and
																								corp_ln_name_type_cd_invalid       = 0);																					 																	
		
		Main_FailBuild	:= map(corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_OK_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),					 count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_OK_Main.Threshold_Percent.CORP_LEGAL_NAME 					=> true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),						     count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_OK_Main.Threshold_Percent.CORP_KEY      						=> true,
													 count(Main_GoodRecords) = 0																																																																																				          => true,
													 false );

		Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
	
		Main_RejFile_Exists		:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);			
	  Main_ALL		 					:= sequential(IF(count(Main_BadRecords) <> 0
																					,IF (poverwrite
																							,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_ok',overwrite,__compressed__,named('Sample_Rejected_MainRecs_OK'+filedate))
																							,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																													 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_OK'+filedate)))))
																		,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainOKScrubsReportWithExamples'+filedate))																		
																		//Send Alerts if Scrubs exceeds thresholds
																		,IF(COUNT(Main_ScrubsAlert) > 0, Main_SendEmailFile, OUTPUT('CORP2_MAPPING.OK - No "MAIN" Corp Scrubs Alerts'))
																		,Main_ErrorSummary
																		,Main_ScrubErrorReport
																		,Main_SomeErrorValues
																		,Main_SubmitStats );
																	
	//--------------------------------------------------------------------	
  // Scrubs for Event
  //--------------------------------------------------------------------
		Event_F := MapEvent;
		Event_S := Scrubs_Corp2_Mapping_OK_Event.Scrubs;        // OK scrubs module
		Event_N := Event_S.FromNone(Event_F); 									// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     	// Use the FromBits module; mOKes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile);// Pass the expanded error flags into the Expanded module

	//Outputs reports
		Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_OK'+filedate));
		Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_OK'+filedate));
		Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_OK'+filedate));
		Event_IsScrubErrors		 		:= IF(count(Event_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Event_OrbitStats						:= Event_U.OrbitStats();
		
		//Outputs files
		Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_OK_Event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap			:= output(Event_T);

    //Submits Profile's stats to Orbit
    Event_SubmitStats         := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_OK_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_OK_Event').SubmitStats;

		Event_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_OK_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_OK_Event').CompareToProfile_with_Examples;
		
		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpEvent_OK Report' //subject
																																	 ,'Scrubs CorpEvent_OK Report' //body
																																	 ,(data)Event_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpOKEventScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																																 );		
																																 
		Event_BadRecords := Event_T.ExpandedInFile(	corp_key_invalid  		         <> 0 or
																								corp_sos_charter_nbr_invalid   <> 0 or
																								event_filing_cd_invalid		     <> 0 or
																								event_filing_date_invalid 		 <> 0 );	

		Event_GoodRecords	:= Event_T.ExpandedInFile(corp_key_invalid  		         = 0 and
																								corp_sos_charter_nbr_invalid   = 0 and
																								event_filing_cd_invalid		     = 0 and
																								event_filing_date_invalid 		 = 0 );																					 																	
		
		Event_FailBuild	:= map(corp2_mapping.fCalcPercent(count(Event_N.ExpandedInFile(corp_sos_charter_nbr_invalid<>0)),count(Event_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_OK_Event.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR => true,
													 corp2_mapping.fCalcPercent(count(Event_N.ExpandedInFile(corp_key_invalid<>0)),					   count(Event_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_OK_Event.Threshold_Percent.CORP_KEY      						=> true,
													 count(Event_GoodRecords) = 0																																																																																				        => true,
													 false );

		Event_ApprovedRecords := project(Event_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Events,self := left));		
		
		Event_RejFile_Exists			:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_' + state_origin),true,false);			
	  Event_ALL									:= sequential(IF(count(Event_BadRecords)<> 0
																						 ,if(poverwrite
																								,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_ok',overwrite,__compressed__,named('Sample_Rejected_Event_Recs_OK'+filedate))
																								,sequential (IF(Event_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin)),
																														 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin,__compressed__,named('Sample_Rejected_Event_Recs_OK'+filedate)))))
																					 ,output(Event_ScrubsWithExamples, ALL, NAMED('CorpEventOKScrubsReportWithExamples'+filedate))
																					 //Send Alerts if Scrubs exceeds thresholds
																					 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_SendEmailFile, OUTPUT('CORP2_MAPPING.OK - No "EVENT" Corp Scrubs Alerts'))
																					 ,Event_ErrorSummary
																					 ,Event_ScrubErrorReport
																					 ,Event_SomeErrorValues
																					 ,Event_SubmitStats);
																					 
	//-------------------- Version Control -----------------------------------------------------//	
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::main_ok'			,Main_ApprovedRecords ,main_out		     ,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_ok'			,MapStock	            ,stock_out	     ,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_ok'			,Event_ApprovedRecords,event_out	     ,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_ok'				,MapAR		            ,ar_out			     ,,,pOverwrite);
	
	VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::main_ok'	,MapMain              ,write_fail_main ,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::event_ok'	,MapEvent	            ,write_fail_event,,,pOverwrite);
		
	mapOK:= sequential(   if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
											 	// ,Corp2_Raw_OK.Build_Bases(filedate,version,puseprod).All  // Determined building of bases is not needed
												,main_out
												,event_out
												,ar_out
												,stock_out										
												,IF(Main_FailBuild <> true or Event_FailBuild <> true
														,sequential( fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::ar'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_OK')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::event'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_OK')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_OK')																		 
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::stock'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_OK')
																				,if (count(Main_BadRecords) <> 0 or  count(Event_BadRecords) <> 0 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,,count(Main_BadRecords),,count(Event_BadRecords),,count(Main_ApprovedRecords),count(mapAR),count(Event_ApprovedRecords),count(mapStock)).RecordsRejected																				 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,,count(Main_BadRecords),,count(Event_BadRecords),,count(Main_ApprovedRecords),count(mapAR),count(Event_ApprovedRecords),count(mapStock)).MappingSuccess																				 
																						 )	 
																			)
														 ,sequential( write_fail_main//if it fails on  main file threshold ,still writing mapped files!
																				 ,write_fail_event
																				 ,Corp2_Mapping.Send_Email(state_origin ,version).MappingFailed
																				)
													)
											  ,if (Main_IsScrubErrors
														 ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,,Event_IsScrubErrors).FieldsInvalidPerScrubs)
												,Event_All
												,Main_All	
										);
															                          
 		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-35) and ut.date_math(filedate,35),true,false);
		return sequential (if (isFileDateValid
														,mapOK
														,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('Corp2_Mapping.OK failed.  An invalid filedate was passed in as a parameter.')))); 	

 End; //Update Function

End;//End OK Module