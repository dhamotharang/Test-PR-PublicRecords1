 import Corp2, std, ut, versioncontrol, Corp2_Raw_TX, tools, Scrubs, Scrubs_Corp2_Mapping_TX_Main;
 
 export TX := MODULE; 

	export Update(String fileDate, String version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) := function
		
		state_origin	 := 'TX';
		state_fips	 	 := '48';	
		state_desc	 	 := 'TEXAS';
		
		// Vendor Input File
		Master_02 			 := dedup(sort(distribute(Corp2_Raw_TX.Files(filedate,pUseProd).input.f02, hash(filing_number)), record,local),record,local) : independent;
		MastAddr_03 		 := dedup(sort(distribute(Corp2_Raw_TX.Files(filedate,pUseProd).input.f03, hash(filing_number)), record,local),record,local) : independent;
		RegBusAgent_05 	 := dedup(sort(distribute(Corp2_Raw_TX.Files(filedate,pUseProd).input.f05, hash(filing_number)), record,local),record,local) : independent;
		RA_PersName_06 	 := dedup(sort(distribute(Corp2_Raw_TX.Files(filedate,pUseProd).input.f06, hash(filing_number)), record,local),record,local) : independent;
		Chart_BusOff_07  := dedup(sort(distribute(Corp2_Raw_TX.Files(filedate,pUseProd).input.f07, hash(filing_number)), record,local),record,local) : independent;
		ChartOff_Pers_08 := dedup(sort(distribute(Corp2_Raw_TX.Files(filedate,pUseProd).input.f08, hash(filing_number)), record,local),record,local) : independent;
		CharterNames_09  := dedup(sort(distribute(Corp2_Raw_TX.Files(filedate,pUseProd).input.f09, hash(filing_number)), record,local),record,local) : independent;
		AssocEnt_10 		 := dedup(sort(distribute(Corp2_Raw_TX.Files(filedate,pUseProd).input.f10, hash(entity_filing_number)), record,local),record,local) : independent;
		FilingHist_11 	 := dedup(sort(distribute(Corp2_Raw_TX.Files(filedate,pUseProd).input.f11, hash(filing_number)), record,local),record,local) : independent;
				  
		
		//*************************************
		// Begin CORP Mapping
		//*************************************  
		
		//----------------------------------------		
		// Map the Business CORP records
		//----------------------------------------
			jMaster_Addr03    := join(Master_02, MastAddr_03, 
																corp2.t2u(left.filing_number) = corp2.t2u(right.filing_number),
																transform(Corp2_Raw_TX.Layouts.Master_tempLay,
																self := left; self := right;),
																left outer, local);  
				
		pRegBusAgent_05			:= project(RegBusAgent_05, transform(Corp2_Raw_TX.Layouts.Master_tempLay,
																	 self.bus_or_pers := 'BUS'; self := left;)) : independent;
		
		pRA_PersName_06			:= project(RA_PersName_06, transform(Corp2_Raw_TX.Layouts.Master_tempLay,
																	 self.bus_or_pers := 'PERS'; self := left;)) : independent;
		
		jMaster 						:= join(jMaster_Addr03, pRegBusAgent_05 + pRA_PersName_06, 
																corp2.t2u(left.filing_number) = corp2.t2u(right.filing_number),
																transform(Corp2_Raw_TX.Layouts.Master_tempLay,
																self.BusiAgent_address1 			:= right.BusiAgent_address1;
																self.BusiAgent_address2 			:= right.BusiAgent_address2;
																self.BusiAgent_city 					:= right.BusiAgent_city; 
																self.BusiAgent_state 					:= right.BusiAgent_state;
																self.BusiAgent_zip 						:= right.BusiAgent_zip;
																self.BusiAgent_zip_extension 	:= right.BusiAgent_zip_extension;
																self.BusiAgent_country 				:= right.BusiAgent_country;
																self.BusiAgent_inactive_date 	:= right.BusiAgent_inactive_date;
																self.BusiAgent_business_name 	:= right.BusiAgent_business_name;
																self.RegAgent_address1 				:= right.RegAgent_address1;
																self.RegAgent_address2 				:= right.RegAgent_address2;
																self.RegAgent_city 						:= right.RegAgent_city;
																self.RegAgent_state 					:= right.RegAgent_state;
																self.RegAgent_zip 						:= right.RegAgent_zip;
																self.RegAgent_zip_extension 	:= right.RegAgent_zip_extension;
																self.RegAgent_country 				:= right.RegAgent_country;
																self.RegAgent_inactive_date 	:= right.RegAgent_inactive_date;
																self.Agent_last_name 					:= right.Agent_last_name;
																self.Agent_first_name 				:= right.Agent_first_name;
																self.Agent_middle_name 				:= right.Agent_middle_name;
																self.Agent_suffix 						:= right.Agent_suffix;
																self.Bus_or_Pers 							:= right.Bus_or_Pers;
																self := left; self := right;),
																left outer, local);		
		
		// Normalize jMaster on the two Legal names (Name and DBA Name)	
		Corp2_Raw_TX.Layouts.normMaster_Layout normMasterTrf(Corp2_Raw_TX.Layouts.Master_tempLay l, unsigned1 cnt) := transform
					,skip(cnt = 2 and corp2.t2u(l.dba_name) = '')
	  	self.norm_name  := choose(cnt, l.name, l.dba_name);	
			self.norm_type  := choose(cnt, ''    , 'DBA');
			self 						:= l;
		end;

		normjMaster	:= normalize(jMaster, 2, normMasterTrf(left, counter)) : independent;

		
		// Transform Businesses  
		corp2_Mapping.LayoutsCommon.Main CorpBusTrf(Corp2_Raw_TX.Layouts.normMaster_Layout input) := transform
				self.dt_first_seen					       := (integer)fileDate;
				self.dt_last_seen					         := (integer)fileDate;
				self.dt_vendor_first_reported		   := (integer)fileDate;
				self.dt_vendor_last_reported		   := (integer)fileDate;
				self.corp_ra_dt_first_seen			   := (integer)fileDate;
				self.corp_ra_dt_last_seen			     := (integer)fileDate;
				self.corp_key					             := if((integer)input.filing_number = 0, '', state_fips + '-' + corp2.t2u(input.filing_number));
				self.corp_vendor					         := state_fips;
				self.corp_state_origin             := state_origin;
				self.corp_process_date				     := fileDate;    
				self.corp_orig_sos_charter_nbr     := corp2.t2u(input.filing_number);
				self.corp_ln_name_type_cd          := map(input.norm_type = 'DBA'              => '06',
																								  corp2.t2u(input.corp_type_id) = '22' => '06',
																									corp2.t2u(input.corp_type_id) = '28' => '07',
																									'01');
				self.corp_ln_name_type_desc        := case(self.corp_ln_name_type_cd, '06'=>'ASSUMED', '07'=>'RESERVED', 'LEGAL');
				self.corp_legal_name               := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.norm_name).BusinessName;
				self.corp_status_cd                := corp2.t2u(input.status_id);
				self.corp_status_desc              := Corp2_Raw_TX.Functions.GetStatusDesc(input.status_id);
				self.corp_status_date              := Corp2_Mapping.fValidateDate(input.inactive_date,'CCYYMMDD').PastDate;													
				self.corp_term_exist_cd            := map(corp2.t2u(input.perpetual_flag) in ['0','00',''] and corp2.t2u(input.expiration_type) <> '' => 'N',
																									corp2.t2u(input.perpetual_flag) in ['1','01']                                               => 'P',
																									Corp2_Mapping.fValidateDate(input.expiration_date,'CCYYMMDD').GeneralDate <> ''             => 'D',
																									''); 
				self.corp_term_exist_desc          := case(self.corp_term_exist_cd, 'P'=> 'PERPETUAL', 'D'=>'EXPIRATION DATE', 'N'=>'NUMBER OF YEARS', '');
				self.corp_term_exist_exp           := if(corp2.t2u(input.perpetual_flag) in ['0','00',''] and corp2.t2u(input.expiration_type) <> ''
																								 ,corp2.t2u(input.expiration_type)
																								 ,Corp2_Mapping.fValidateDate(input.expiration_date,'CCYYMMDD').GeneralDate);  
				
        Dom_or_For := if(corp2.t2u(input.corp_type_id) in ['22','28']	,''	,if(corp2.t2u(input.corp_type_id) in ['02','04','07','09','11','13','17','20','23','24','25','26','27','30'] ,'F'	,'D'));				
				self.corp_foreign_domestic_ind     := Dom_or_For;
				self.corp_inc_date                 := if(Dom_or_For = 'D', Corp2_Mapping.fValidateDate(input.creation_date,'CCYYMMDD').PastDate ,''); 
        self.corp_forgn_date               := if(Dom_or_For = 'F'
																									,if(Corp2_Mapping.fValidateDate(input.foreign_formation_date,'CCYYMMDD').PastDate <> ''
																											,Corp2_Mapping.fValidateDate(input.foreign_formation_date,'CCYYMMDD').PastDate
																											,Corp2_Mapping.fValidateDate(input.creation_date,'CCYYMMDD').PastDate)
																									,''); 
			  self.corp_forgn_state_cd           := if(Dom_or_For = 'F', corp2.t2u(input.foreign_state), ''); 
  			self.corp_forgn_state_desc         := Corp2_Raw_TX.Functions.GetForgnDesc(self.corp_forgn_state_cd);																						

				self.corp_for_profit_ind           := map(corp2.t2u(input.corp_type_id) in ['01','02']      => 'Y',
				                                          corp2.t2u(input.corp_type_id) in ['08','09','14'] => 'N',
																									corp2.t2u(input.corp_type_id) = '23' and corp2.t2u(input.nonprofit_subtype_id) in ['49','50','51','52','53','54','55','56','57'] => 'N',
																									'');																									
				self.corp_state_tax_id             := if((integer)(input.tax_id) <> 0, corp2.t2u(input.tax_id), ''); 
				self.corp_forgn_fed_tax_id         := if((integer)(input.foreign_fein) <> 0, corp2.t2u(input.foreign_fein), '');
				self.corp_inc_state                := state_origin;
				self.corp_orig_bus_type_cd         := if((integer)input.nonprofit_subtype_id <> 0
																							   ,corp2.t2u(input.nonprofit_subtype_id) ,'');
				self.corp_orig_bus_type_desc       := Corp2_Raw_TX.Functions.GetBusTypeDesc(self.corp_orig_bus_type_cd);
				self.corp_orig_org_structure_cd    := if(corp2.t2u(input.corp_type_id) not in ['22','28'] ,corp2.t2u(input.corp_type_id) ,'');
				self.corp_orig_org_structure_desc  := Corp2_Raw_TX.Functions.GetOrgStrucDesc(input.corp_type_id);
				self.corp_filing_date              := Corp2_Mapping.fValidateDate(input.formation_date,'CCYYMMDD').PastDate;
				self.corp_filing_cd                := if(self.corp_filing_date <> '' ,'X' ,'');
				self.corp_filing_desc              := if(self.corp_filing_date <> '' ,'FORMATION' ,'');
				self.corp_address1_type_cd         := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.address1,input.address2,input.city,input.state,input.zip + input.zip_extension,input.country).ifAddressExists,'B','');	
				self.corp_address1_type_desc       := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.address1,input.address2,input.city,input.state,input.zip + input.zip_extension,input.country).ifAddressExists,'BUSINESS','');
				self.corp_address1_line1				   := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.address1,input.address2,input.city,input.state,input.zip + input.zip_extension,input.country).AddressLine1;
				self.corp_address1_line2				   := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.address1,input.address2,input.city,input.state,input.zip + input.zip_extension,input.country).AddressLine2;
				self.corp_address1_line3				   := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.address1,input.address2,input.city,input.state,input.zip + input.zip_extension,StringLib.StringFindReplace(Corp2_Raw_TX.Functions.Decode_Country(input.country),'**|','')).AddressLine3;			
				self.corp_prep_addr1_line1			   := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.address1,input.address2,input.city,input.state,input.zip + input.zip_extension,input.country).PrepAddrLine1;			
				self.corp_prep_addr1_last_line	   := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.address1,input.address2,input.city,input.state,input.zip + input.zip_extension,input.country).PrepAddrLastLine;
		    self.corp_ra_fname 				     		 := Corp2_Mapping.fCleanPersonName(state_origin,state_desc,input.agent_first_name,input.agent_middle_name,input.agent_last_name).FirstName;
				self.corp_ra_mname 				     		 := Corp2_Mapping.fCleanPersonName(state_origin,state_desc,input.agent_first_name,input.agent_middle_name,input.agent_last_name).MiddleName;
				self.corp_ra_lname 				    		 := Corp2_Mapping.fCleanPersonName(state_origin,state_desc,input.agent_first_name,input.agent_middle_name,input.agent_last_name).LastName;
				self.corp_ra_suffix           		 := corp2.t2u(input.agent_suffix);
				self.corp_ra_full_name             := map(input.bus_or_pers = 'BUS'  => 
																											Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.BusiAgent_business_name).BusinessName,
				                                          input.bus_or_pers = 'PERS' => 
																											corp2.t2u(self.corp_ra_fname + ' ' + self.corp_ra_mname + ' ' + self.corp_ra_lname + ' ' + self.corp_ra_suffix),
																									'');
				self.corp_ra_address_type_cd       := map(input.bus_or_pers = 'BUS'  and self.corp_ra_full_name <> '' => 
																											if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.BusiAgent_address1,input.BusiAgent_address2,input.BusiAgent_city,input.BusiAgent_state,input.BusiAgent_zip + input.BusiAgent_zip_extension,input.BusiAgent_country).ifAddressExists,'R',''),
				                                          input.bus_or_pers = 'PERS' and self.corp_ra_full_name <> '' => 
																											if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.RegAgent_address1,input.RegAgent_address2,input.RegAgent_city,input.RegAgent_state,input.RegAgent_zip + input.RegAgent_zip_extension,input.RegAgent_country).ifAddressExists,'R',''),
																									'');
				self.corp_ra_address_type_desc     := map(input.bus_or_pers = 'BUS'  and self.corp_ra_full_name <> '' =>
																											if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.BusiAgent_address1,input.BusiAgent_address2,input.BusiAgent_city,input.BusiAgent_state,input.BusiAgent_zip + input.BusiAgent_zip_extension,input.BusiAgent_country).ifAddressExists,'REGISTERED OFFICE',''),
																									input.bus_or_pers = 'PERS' and self.corp_ra_full_name <> '' => 
																											if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.RegAgent_address1,input.RegAgent_address2,input.RegAgent_city,input.RegAgent_state,input.RegAgent_zip + input.RegAgent_zip_extension,input.RegAgent_country).ifAddressExists,'REGISTERED OFFICE',''),
																									'');
				self.corp_ra_address_line1         := map(input.bus_or_pers = 'BUS'  and self.corp_ra_full_name <> '' =>
																											Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.BusiAgent_address1,input.BusiAgent_address2,input.BusiAgent_city,input.BusiAgent_state,input.BusiAgent_zip + input.BusiAgent_zip_extension,input.BusiAgent_country).AddressLine1,
																									input.bus_or_pers = 'PERS' and self.corp_ra_full_name <> '' => 
																											Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.RegAgent_address1,input.RegAgent_address2,input.RegAgent_city,input.RegAgent_state,input.RegAgent_zip + input.RegAgent_zip_extension,input.RegAgent_country).AddressLine1,
																									'');
				self.corp_ra_address_line2         := map(input.bus_or_pers = 'BUS'  and self.corp_ra_full_name <> '' =>
																											Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.BusiAgent_address1,input.BusiAgent_address2,input.BusiAgent_city,input.BusiAgent_state,input.BusiAgent_zip + input.BusiAgent_zip_extension,input.BusiAgent_country).AddressLine2,
																									input.bus_or_pers = 'PERS' and self.corp_ra_full_name <> '' => 
																											Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.RegAgent_address1,input.RegAgent_address2,input.RegAgent_city,input.RegAgent_state,input.RegAgent_zip + input.RegAgent_zip_extension,input.RegAgent_country).AddressLine2,
																									'');
				self.corp_ra_address_line3         := map(input.bus_or_pers = 'BUS'  and self.corp_ra_full_name <> '' =>
																											Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.BusiAgent_address1,input.BusiAgent_address2,input.BusiAgent_city,input.BusiAgent_state,input.BusiAgent_zip + input.BusiAgent_zip_extension,StringLib.StringFindReplace(Corp2_Raw_TX.Functions.Decode_Country(input.BusiAgent_country),'**|','')).AddressLine3,
																									input.bus_or_pers = 'PERS' and self.corp_ra_full_name <> '' => 
																											Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.RegAgent_address1,input.RegAgent_address2,input.RegAgent_city,input.RegAgent_state,input.RegAgent_zip + input.RegAgent_zip_extension,StringLib.StringFindReplace(Corp2_Raw_TX.Functions.Decode_Country(input.RegAgent_country),'**|','')).AddressLine3,
																									'');	
				self.ra_prep_addr_line1            := map(input.bus_or_pers = 'BUS'  and self.corp_ra_full_name <> '' =>
																											Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.BusiAgent_address1,input.BusiAgent_address2,input.BusiAgent_city,input.BusiAgent_state,input.BusiAgent_zip + input.BusiAgent_zip_extension,input.BusiAgent_country).PrepAddrLine1,
																									input.bus_or_pers = 'PERS' and self.corp_ra_full_name <> '' => 
																											Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.RegAgent_address1,input.RegAgent_address2,input.RegAgent_city,input.RegAgent_state,input.RegAgent_zip + input.RegAgent_zip_extension,input.RegAgent_country).PrepAddrLine1,
																									'');	
				self.ra_prep_addr_last_line        := map(input.bus_or_pers = 'BUS'  and self.corp_ra_full_name <> '' =>
																											Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.BusiAgent_address1,input.BusiAgent_address2,input.BusiAgent_city,input.BusiAgent_state,input.BusiAgent_zip + input.BusiAgent_zip_extension,input.BusiAgent_country).PrepAddrLastLine,
																									input.bus_or_pers = 'PERS' and self.corp_ra_full_name <> '' => 
																											Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.RegAgent_address1,input.RegAgent_address2,input.RegAgent_city,input.RegAgent_state,input.RegAgent_zip + input.RegAgent_zip_extension,input.RegAgent_country).PrepAddrLastLine,
																									'');	
				self.corp_ra_resign_date           := map(input.bus_or_pers = 'BUS'  => 
																											Corp2_Mapping.fValidateDate(input.BusiAgent_inactive_date,'CCYYMMDD').PastDate,
				                                          input.bus_or_pers = 'PERS' => 
																											Corp2_Mapping.fValidateDate(input.RegAgent_inactive_date,'CCYYMMDD').PastDate,
																									'');	
				self.corp_agent_status_desc        := if(self.corp_ra_resign_date <> '' ,'INACTIVE' ,'');																					
				self.corp_agent_country            := map(input.bus_or_pers = 'BUS'  => 
																											Corp2_Raw_TX.Functions.Decode_Country(input.BusiAgent_country),
				                                          input.bus_or_pers = 'PERS' => 
																											Corp2_Raw_TX.Functions.Decode_Country(input.RegAgent_country),
																									'');	
  			self.recordOrigin                  := 'C';				
				self                               := [];
		end; 
		
		
	
		// Transform fictitious names  
		jCharterNames_09	:= join(CharterNames_09, normjMaster, 
								corp2.t2u(left.filing_number) = corp2.t2u(right.filing_number),
								transform(Corp2_Raw_TX.Layouts.CharterNames_09_TempLay, 
													 self.corp_type_id           := right.corp_type_id;
													 self.mast_creation_date     := right.creation_date;
													 self.foreign_formation_date := right.foreign_formation_date;
													 self := left; self := right; self := [];),
								left outer,local) : independent;
										
		corp2_Mapping.LayoutsCommon.Main CorpFictTrf(Corp2_Raw_TX.Layouts.CharterNames_09_TempLay input):= transform
				self.dt_first_seen					   := (integer)fileDate;
				self.dt_last_seen					     := (integer)fileDate;
				self.dt_vendor_first_reported	 := (integer)fileDate;
				self.dt_vendor_last_reported	 := (integer)fileDate;
				self.corp_ra_dt_first_seen		 := (integer)fileDate;
				self.corp_ra_dt_last_seen			 := (integer)fileDate;
				self.corp_key					         := if((integer)input.filing_number = 0, '', state_fips + '-' + corp2.t2u(input.filing_number));
				self.corp_vendor					     := state_fips;
				self.corp_state_origin         := state_origin;
				self.corp_process_date				 := fileDate;  
				self.corp_inc_state            := state_origin;
				self.corp_orig_sos_charter_nbr := corp2.t2u(input.filing_number);
				self.corp_status_cd            := corp2.t2u(input.name_status_id); // Retaining since corp_name_status_cd is a new field and not displayable
				self.corp_status_desc          := Corp2_Raw_TX.Functions.GetFictStatusDesc(input.name_status_id); // Retaining since corp_name_status_desc is a new field and not displayable
				self.corp_name_status_cd       := corp2.t2u(input.name_status_id);
				self.corp_name_status_desc     := Corp2_Raw_TX.Functions.GetFictStatusDesc(input.name_status_id);
				self.corp_ln_name_type_cd      := case((integer)input.name_type_id,	1=>'01'   , 2=>'F'  , 3=>'06' , 198=>'F', 199=>'F', 200=>'F', 201=>'O', corp2.t2u(input.name_type_id)); 
				self.corp_ln_name_type_desc    := case((integer)input.name_type_id, 1=>'LEGAL', 2=>'FBN', 3=>'ASSUMED', 198=>'FBN', 199=>'FBN', 200=>'FBN', 201=>'OTHER', '');
				self.corp_legal_name           := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.Name).BusinessName;
				self.corp_name_reservation_expiration_date := Corp2_Mapping.fValidateDate(input.expire_date,'CCYYMMDD').GeneralDate;
				self.corp_term_exist_exp       := Corp2_Mapping.fValidateDate(input.expire_date,'CCYYMMDD').GeneralDate; // Retaining since corp_name_reservation_expiration_date is a new field and not displayable
				self.corp_term_exist_cd        := if(self.corp_term_exist_exp <> '' ,'D' ,''); // Retaining since corp_name_reservation_expiration_date is a new field and not displayable
				self.corp_term_exist_desc      := if(self.corp_term_exist_exp <> '' ,'EXPIRATION DATE' ,''); // Retaining since corp_name_reservation_expiration_date is a new field and not displayable
				self.corp_name_reservation_date:= Corp2_Mapping.fValidateDate(input.creation_date,'CCYYMMDD').PastDate;
				self.corp_filing_date          := Corp2_Mapping.fValidateDate(input.creation_date,'CCYYMMDD').PastDate; // Retaining since corp_name_reservation_date is a new field and not displayable
				self.corp_filing_cd            := if(self.corp_filing_date <> '', 'C',''); // Retaining since corp_name_reservation_date is a new field and not displayable
				self.corp_filing_desc          := if(self.corp_filing_date <> '', 'CREATION',''); // Retaining since corp_name_reservation_date is a new field and not displayable
				self.corp_name_status_date     := Corp2_Mapping.fValidateDate(input.inactive_date,'CCYYMMDD').PastDate;
				self.corp_name_comment         := if(Corp2_Mapping.fValidateDate(input.inactive_date,'CCYYMMDD').PastDate <> ''
																						 ,'DBA INACTIVE DATE: '+ Corp2_Mapping.fValidateDate(input.inactive_date,'CCYYMMDD').PastDate[5..6] + '/' + 
																																		 Corp2_Mapping.fValidateDate(input.inactive_date,'CCYYMMDD').PastDate[7..8] + '/' + 
																																		 Corp2_Mapping.fValidateDate(input.inactive_date,'CCYYMMDD').PastDate[1..4]  ,''); // Retaining since corp_name_status_date is a new field and not displayable
				self.corp_addl_info            := map(corp2.t2u(input.county_type) = ''     => '',
																							corp2.t2u(input.county_type) = 'ALL' => 'ASSUMED NAME LISTED IN ALL COUNTIES',
																							corp2.t2u(input.county_type) = 'LIST' and (integer)input.selected_county_array > 0 
																										=> 'NAME LISTED IN FOLLOWING: ' + Corp2_Raw_TX.Functions.CountyTable(input.selected_county_array),
																							'');
			  Dom_or_For := if(corp2.t2u(input.corp_type_id) in ['22','28']	,''	,if(corp2.t2u(input.corp_type_id) in ['02','04','07','09','11','13','17','20','23','24','25','26','27','30'] ,'F'	,'D'));				
				self.corp_inc_date                 := if(Dom_or_For = 'D', Corp2_Mapping.fValidateDate(input.mast_creation_date,'CCYYMMDD').PastDate ,''); 
        self.corp_forgn_date               := if(Dom_or_For = 'F'
																									,if(Corp2_Mapping.fValidateDate(input.foreign_formation_date,'CCYYMMDD').PastDate <> ''
																											,Corp2_Mapping.fValidateDate(input.foreign_formation_date,'CCYYMMDD').PastDate
																											,Corp2_Mapping.fValidateDate(input.mast_creation_date,'CCYYMMDD').PastDate)
																									,''); 
				self.recordOrigin              := 'C';				
				self                           := [];
		end; 
	
	
		//----------------------------------------		
		// Map the Merger CORP records
		//----------------------------------------
		jMergers := join(AssocEnt_10, Master_02, 
										(integer)left.entity_filing_number = (integer)right.filing_number,
										transform(Corp2_Raw_TX.Layouts.AssocEnt_10_TempLay,  
														 self.corp_type_id           := right.corp_type_id;
														 self.creation_date          := right.creation_date;
														 self.foreign_formation_date := right.foreign_formation_date;
														 self := left; self := right; self := [];),
										inner, local) : independent; 
	
		corp2_Mapping.LayoutsCommon.Main CorpMergerTrf(Corp2_Raw_TX.Layouts.AssocEnt_10_TempLay input):=transform
				self.dt_first_seen					    := (integer)fileDate;
				self.dt_last_seen					      := (integer)fileDate;
				self.dt_vendor_first_reported	  := (integer)fileDate;
				self.dt_vendor_last_reported	  := (integer)fileDate;
				self.corp_ra_dt_first_seen		  := (integer)fileDate;
				self.corp_ra_dt_last_seen			  := (integer)fileDate;
				self.corp_key					          := if((integer)input.filing_number = 0, '', state_fips + '-' + corp2.t2u(input.filing_number));
				self.corp_vendor					      := state_fips;
				self.corp_state_origin          := state_origin;
				self.corp_process_date				  := fileDate;    
				self.corp_inc_state             := state_origin;
				self.corp_orig_sos_charter_nbr  := corp2.t2u(input.filing_number);
				self.corp_legal_name            := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.associated_entity_name).BusinessName;
				self.corp_merger_indicator      := case(input.capacity_id, '0001'=>'S', '0002'=>'N', '');
				self.Corp_merged_corporation_id := if(input.capacity_id = '0001', corp2.t2u(input.filing_number), '');
				self.corp_survivor_corporation_id := if(input.capacity_id = '0002', corp2.t2u(input.filing_number), '');
				self.corp_merger_date           := if(input.capacity_id = '0001', Corp2_Mapping.fValidateDate(input.entity_filing_date,'CCYYMMDD').PastDate, '');
				self.corp_merger_effective_date := if(input.capacity_id in ['0001','0002'] ,Corp2_Mapping.fValidateDate(input.entity_filing_date,'CCYYMMDD').PastDate ,'');
				self.corp_merger_desc           := if(input.capacity_id in ['0001','0002'] and Corp2_Mapping.fValidateDate(input.inactive_date,'CCYYMMDD').PastDate <> ''
																							,'MERGER INACTIVE DATE ' + Corp2_Mapping.fValidateDate(input.inactive_date,'CCYYMMDD').PastDate
																							,'');
				self.corp_converted             := case(input.capacity_id, '0004'=>'Y', '0005'=>'N', '');
				self.corp_comment               := map(input.capacity_id = '0003' and corp2.t2u(input.entity_filing_number) <> '' => 'RESULTING ENTITY '          + corp2.t2u(input.entity_filing_number),
				                                       input.capacity_id = '0006' and corp2.t2u(input.filing_number)        <> '' => 'CORPORATION ACQUIRING '     + corp2.t2u(input.filing_number),
																							 input.capacity_id = '0007' and corp2.t2u(input.filing_number)        <> '' => 'CORPORATION ACQUIRED BY '   + corp2.t2u(input.filing_number),
																							 input.capacity_id = '0008' and corp2.t2u(input.entity_filing_number) <> '' => 'CORPORATION CONSOLIDATED '  + corp2.t2u(input.entity_filing_number),
																							 input.capacity_id = '0009' and corp2.t2u(input.entity_filing_number) <> '' => 'CORPORATION CONSOLIDATING ' + corp2.t2u(input.entity_filing_number),			 
																							 input.capacity_id = '0011' and corp2.t2u(input.entity_filing_number) <> '' => 'PREDECESSOR '               + corp2.t2u(input.entity_filing_number),
																							 input.capacity_id = '0012' and corp2.t2u(input.entity_filing_number) <> '' => 'UNDERLYING PARTNERSHIP '    + corp2.t2u(input.entity_filing_number),
																							 input.capacity_id = '0013' and corp2.t2u(input.entity_filing_number) <> '' => 'LLP REGISTRATION '          + corp2.t2u(input.entity_filing_number),
																							 '');
				slashedInactive := if(Corp2_Mapping.fValidateDate(input.inactive_date,'CCYYMMDD').PastDate <> ''
															,Corp2_Mapping.fValidateDate(input.inactive_date,'CCYYMMDD').PastDate[5..6] + '/' + 
															 Corp2_Mapping.fValidateDate(input.inactive_date,'CCYYMMDD').PastDate[7..8] + '/' + 
															 Corp2_Mapping.fValidateDate(input.inactive_date,'CCYYMMDD').PastDate[1..4]
															,'');
				self.corp_addl_info             := if(slashedInactive <> ''
				                                      ,corp2.t2u(map(input.capacity_id = '0003' => 'INACTIVE DATE FOR ENTITY '               ,
																									 input.capacity_id = '0004' => 'INACTIVE DATE OF CONVERSION '            ,
																									 input.capacity_id = '0005' => 'INACTIVE DATE OF CONVERSION '            ,
																									 input.capacity_id = '0006' => 'INACTIVE DATE OF ACQUISITION '           ,
																									 input.capacity_id = '0007' => 'INACTIVE DATE OF ACQUISITION '           ,
																									 input.capacity_id = '0008' => 'INACTIVE DATE OF CONSOLIDATION '         ,
																									 input.capacity_id = '0009' => 'INACTIVE DATE OF CONSOLIDATION '         ,
																									 input.capacity_id = '0011' => 'INACTIVE DATE OF PREDECESSOR '           ,
																									 input.capacity_id = '0012' => 'INACTIVE DATE OF UNDERLYING PARTNERSHIP ',
                                                   input.capacity_id = '0013' => 'LLP REGISTRATION INACTIVE DATE '         ,																									
																									 'INACTIVE DATE ') + slashedInactive)
																							,'');
				self.corp_filing_date           := if(input.capacity_id in ['0003','0004','0005','0006','0007','0008','0009','0011','0012','0013']
																							,Corp2_Mapping.fValidateDate(input.entity_filing_date,'CCYYMMDD').PastDate ,'');	 
				self.corp_filing_cd             := if(self.corp_filing_date <> '' ,'X' ,'');
				self.corp_filing_desc           := if(self.corp_filing_date <> '' 
																							,map(input.capacity_id = '0003' => 'DATE OF RESULTING ENTITY', 
																							     input.capacity_id = '0004' => 'DATE CONVERTED',
																									 input.capacity_id = '0005' => 'DATE CONVERTING',
																									 input.capacity_id = '0006' => 'DATE ACQUIRING',
																									 input.capacity_id = '0007' => 'DATE ACQUIRED',
																									 input.capacity_id = '0008' => 'DATE CONSOLIDATED',
																									 input.capacity_id = '0009' => 'DATE CONSOLIDATING',
																									 input.capacity_id = '0011' => 'PREDECESSOR DATE',
																									 input.capacity_id = '0012' => 'DATE OF UNDERLYING PARTNERSHIP',
																									 input.capacity_id = '0013' => 'LLP REGISTRATION DATE',
																									 '')
																							,'');
				self.corp_ln_name_type_cd       := input.capacity_id[3..4];
				self.corp_ln_name_type_desc     := Corp2_Raw_TX.Functions.GetNameTypeDesc(input.capacity_id[3..4]);
				self.corp_status_date           := Corp2_Mapping.fValidateDate(input.inactive_date,'CCYYMMDD').PastDate; // Retained from old mapper
				self.corp_status_desc           := if(self.corp_status_date <> '' ,'INACTIVE' ,''); // Retained from old mapper
				self.corp_filing_reference_nbr  := if((integer)input.entity_filing_number = 0, '', corp2.t2u(input.entity_filing_number)); // Retained from old mapper
		    Dom_or_For := if(corp2.t2u(input.corp_type_id) in ['22','28']	,''	,if(corp2.t2u(input.corp_type_id) in ['02','04','07','09','11','13','17','20','23','24','25','26','27','30'] ,'F'	,'D'));				
				self.corp_inc_date              := if(Dom_or_For = 'D', Corp2_Mapping.fValidateDate(input.creation_date,'CCYYMMDD').PastDate ,''); 
        self.corp_forgn_date            := if(Dom_or_For = 'F'
																						  ,if(Corp2_Mapping.fValidateDate(input.foreign_formation_date,'CCYYMMDD').PastDate <> ''
																									,Corp2_Mapping.fValidateDate(input.foreign_formation_date,'CCYYMMDD').PastDate
																									,Corp2_Mapping.fValidateDate(input.creation_date,'CCYYMMDD').PastDate)
																							,'');  
				self.recordOrigin               := 'C';				
				self                            := [];		
		end;
		
		
		MapCorp1 := project(normjMaster     , CorpBusTrf(left));
		MapCorp2 := project(jCharterNames_09, CorpFictTrf(left));
		MapCorp3 := project(jMergers         , CorpMergerTrf(left));
						
		MapCorp  := MapCorp1 + MapCorp2 + MapCorp3;
		// End CORP Mapping
	 
	 
		//*************************************
		// Begin CONT Mapping
		//*************************************		
		
		//--------------------------------------------------
    // Map CONTACTS from the Chart_BusOff_07 input file
		//--------------------------------------------------
		Contacts_07 := join(Chart_BusOff_07, Master_02,  
													corp2.t2u(left.filing_number) = corp2.t2u(right.filing_number),
													transform(Corp2_Raw_TX.Layouts.ContOfficers_07_tempLay,
													self.BusinessOffi_officer_title := Corp2_Raw_TX.Functions.GetOfficerDesc(left.BusinessOffi_officer_title);
													self := left; self := right; self := [];),
													left outer);
										
		// Transform Contacts that came from the Chart_BusOff_07 input file
		corp2_Mapping.LayoutsCommon.Main Contacts07Trf(Corp2_Raw_TX.Layouts.ContOfficers_07_tempLay input) := transform
									,skip((integer)input.filing_number = 0 or corp2.t2u(input.BusinessOffi_business_name) = '')
			self.dt_first_seen					   := (integer)fileDate;
			self.dt_last_seen					     := (integer)fileDate;
			self.dt_vendor_first_reported	 := (integer)fileDate;
			self.dt_vendor_last_reported	 := (integer)fileDate;
			self.corp_ra_dt_first_seen		 := (integer)fileDate;
			self.corp_ra_dt_last_seen			 := (integer)fileDate;
			self.corp_key					         := state_fips + '-' + corp2.t2u(input.filing_number);
			self.corp_vendor					     := state_fips;
			self.corp_state_origin         := state_origin;
			self.corp_inc_state            := state_origin;
			self.corp_process_date				 := fileDate;    
			self.corp_orig_sos_charter_nbr := corp2.t2u(input.filing_number);
			self.corp_legal_name           := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.Name).BusinessName;
			self.cont_full_name            := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.BusinessOffi_business_name).BusinessName;
			self.cont_title1_desc          := regexreplace('VICEPRESIDENT',corp2.t2u(input.BusinessOffi_officer_title),'VICE PRESIDENT');
			self.cont_address_type_cd      := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.BusinessOffi_address1,input.BusinessOffi_address2,input.BusinessOffi_city,input.BusinessOffi_state,input.BusinessOffi_zip + input.BusinessOffi_zip_extension,input.BusinessOffi_country).ifAddressExists,'T','');
			self.cont_address_type_desc    := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.BusinessOffi_address1,input.BusinessOffi_address2,input.BusinessOffi_city,input.BusinessOffi_state,input.BusinessOffi_zip + input.BusinessOffi_zip_extension,input.BusinessOffi_country).ifAddressExists,'CONTACT','');
			self.cont_address_line1			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.BusinessOffi_address1,input.BusinessOffi_address2,input.BusinessOffi_city,input.BusinessOffi_state,input.BusinessOffi_zip + input.BusinessOffi_zip_extension,input.BusinessOffi_country).AddressLine1;
			self.cont_address_line2			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.BusinessOffi_address1,input.BusinessOffi_address2,input.BusinessOffi_city,input.BusinessOffi_state,input.BusinessOffi_zip + input.BusinessOffi_zip_extension,input.BusinessOffi_country).AddressLine2;
			self.cont_address_line3			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.BusinessOffi_address1,input.BusinessOffi_address2,input.BusinessOffi_city,input.BusinessOffi_state,input.BusinessOffi_zip + input.BusinessOffi_zip_extension,StringLib.StringFindReplace(Corp2_Raw_TX.Functions.Decode_Country(input.BusinessOffi_country),'**|','')).AddressLine3;
			self.cont_prep_addr_line1			 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.BusinessOffi_address1,input.BusinessOffi_address2,input.BusinessOffi_city,input.BusinessOffi_state,input.BusinessOffi_zip + input.BusinessOffi_zip_extension,input.BusinessOffi_country).PrepAddrLine1;
			self.cont_prep_addr_last_line	 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.BusinessOffi_address1,input.BusinessOffi_address2,input.BusinessOffi_city,input.BusinessOffi_state,input.BusinessOffi_zip + input.BusinessOffi_zip_extension,input.BusinessOffi_country).PrepAddrLastLine;
      self.cont_country              := Corp2_Raw_TX.Functions.Decode_Country(input.BusinessOffi_country);
			self.recordOrigin              := 'T';
			self                           := [];			
		end;     
	
		
		//--------------------------------------------------
    // Map CONTACTS from the ChartOff_Pers_08 input file
		//--------------------------------------------------
		Contacts_08 := join(ChartOff_Pers_08, Master_02, 
													  corp2.t2u(left.filing_number) = corp2.t2u(right.filing_number),
													  transform(Corp2_Raw_TX.Layouts.ContOfficers_08_tempLay, 
														self.officer_title := Corp2_Raw_TX.Functions.GetOfficerDesc(left.officer_title);
													  self := left; self := right; self := []; ),
													  left outer);	  
		
		// Transform Contacts that came from the ChartOff_Pers_08 input file
		corp2_Mapping.LayoutsCommon.Main Contacts08Trf(Corp2_Raw_TX.Layouts.ContOfficers_08_tempLay input) := transform
										,skip(corp2.t2u(input.filing_number) = '' or (integer)input.filing_number = 0 or
										      corp2.t2u(input.first_name + input.middle_name + input.last_name) = '')
			self.dt_first_seen					   := (integer)fileDate;
			self.dt_last_seen					     := (integer)fileDate;
			self.dt_vendor_first_reported	 := (integer)fileDate;
			self.dt_vendor_last_reported	 := (integer)fileDate;
			self.corp_ra_dt_first_seen		 := (integer)fileDate;
			self.corp_ra_dt_last_seen			 := (integer)fileDate;
			self.corp_key					         := state_fips + '-' + corp2.t2u(input.filing_number);
			self.corp_vendor					     := state_fips;
			self.corp_state_origin         := state_origin;
			self.corp_inc_state            := state_origin;
			self.corp_process_date				 := fileDate;    
			self.corp_orig_sos_charter_nbr := corp2.t2u(input.filing_number);
			self.corp_legal_name           := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.Name).BusinessName;
			
			self.cont_fname 				       := Corp2_Mapping.fCleanPersonName(state_origin,state_desc,input.first_name,input.middle_name,input.last_name).FirstName;
			self.cont_mname 				       := Corp2_Mapping.fCleanPersonName(state_origin,state_desc,input.first_name,input.middle_name,input.last_name).MiddleName;
			self.cont_lname 				       := Corp2_Mapping.fCleanPersonName(state_origin,state_desc,input.first_name,input.middle_name,input.last_name).LastName;
			self.cont_suffix               := corp2.t2u(input.suffix);
			self.cont_full_name            := corp2.t2u(self.cont_fname + ' ' + self.cont_mname + ' ' + self.cont_lname + ' ' + self.cont_suffix);
	    self.cont_title1_desc          := regexreplace('VICEPRESIDENT',corp2.t2u(input.officer_title),'VICE PRESIDENT');
			self.cont_address_type_cd      := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.address1,input.address2,input.city,input.state,input.zip + input.zip_extension,input.country).ifAddressExists,'T','');
			self.cont_address_type_desc    := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.address1,input.address2,input.city,input.state,input.zip + input.zip_extension,input.country).ifAddressExists,'CONTACT','');
			self.cont_address_line1			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address1,input.address2,input.city,input.state,input.zip + input.zip_extension,input.country).AddressLine1;
			self.cont_address_line2			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address1,input.address2,input.city,input.state,input.zip + input.zip_extension,input.country).AddressLine2;
			self.cont_address_line3			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address1,input.address2,input.city,input.state,input.zip + input.zip_extension,StringLib.StringFindReplace(Corp2_Raw_TX.Functions.Decode_Country(input.country),'**|','')).AddressLine3;
			self.cont_prep_addr_line1			 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address1,input.address2,input.city,input.state,input.zip + input.zip_extension,input.country).PrepAddrLine1;
			self.cont_prep_addr_last_line	 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.address1,input.address2,input.city,input.state,input.zip + input.zip_extension,input.country).PrepAddrLastLine;
      self.cont_country              := Corp2_Raw_TX.Functions.Decode_Country(input.country); 
			self.recordOrigin              := 'T';
			self                           := [];
		end;  
		
				
		MapCont1 := project(Contacts_07, Contacts07Trf(left));
		MapCont2 := project(Contacts_08, Contacts08Trf(left));
		
		MapCont  := MapCont1 + MapCont2;
	  // End CONT Mapping

    
		
		//*************************************
		// Begin EVENTS Mapping
		//*************************************	
		
		// Normalize FilingHist_11 on the 3 Filing Dates	
		Corp2_Raw_TX.Layouts.normEvent_Layout normEventTrf(Corp2_Raw_TX.Layouts.FilingHist_11_layout l, unsigned1 cnt) := transform,
					skip(cnt = 1 and Corp2_Mapping.fValidateDate(l.entry_date,'CCYYMMDD').PastDate = '' or
							 cnt = 2 and Corp2_Mapping.fValidateDate(l.filing_date,'CCYYMMDD').PastDate = '' or
							 cnt = 3 and Corp2_Mapping.fValidateDate(l.effective_date,'CCYYMMDD').GeneralDate = ''	)
	  	self.norm_date  := choose(cnt, l.entry_date, l.filing_date, l.effective_date);	
			self.norm_type  := choose(cnt, 'ENT'           , 'FIL'            , 'EFF');
			self 						:= l;
		end;

		normFilingHist_11	:= normalize(FilingHist_11, 3, normEventTrf(left, counter)) : independent;
    
		// Map EVENTS from normFilingHist_11		
		corp2_Mapping.LayoutsCommon.Events EventFilHistTrf(Corp2_Raw_TX.Layouts.normEvent_Layout input) := transform
		              ,skip(corp2.t2u(input.filing_number) = '' or (integer)input.filing_number = 0)
				self.corp_key					           := if((integer)input.filing_number = 0, '', state_fips + '-' + corp2.t2u(input.filing_number));
			  self.corp_vendor					       := state_fips;
			  self.corp_state_origin           := state_origin;
				self.corp_process_date			     := fileDate;
				self.corp_sos_charter_nbr		     := corp2.t2u(input.filing_number);
				self.event_filing_cd             := corp2.t2u(input.filing_type_id);
				self.event_filing_desc           := corp2.t2u(input.filing_type);
				self.event_filing_reference_nbr  := corp2.t2u(input.document_no);
				self.event_filing_date           := Corp2_Mapping.fValidateDate(input.norm_date,'CCYYMMDD').GeneralDate;	
				self.event_date_type_cd          := input.norm_type;
				self.event_date_type_desc        := case(input.norm_type, 'ENT'=>'ENTRY', 'FIL'=>'FILING', 'EFF'=>'EFFECTIVE', '');
				self                             := [];
		end;  
	    
	
  	// Normalize CharterNames_09 on the 3 Filing Dates	
		Corp2_Raw_TX.Layouts.normEvent2_Layout normEvent2Trf(Corp2_Raw_TX.Layouts.CharterNames_09_layout l, unsigned1 cnt) := transform,
					skip(cnt = 1 and Corp2_Mapping.fValidateDate(l.creation_date,'CCYYMMDD').PastDate = '' or
							 cnt = 2 and Corp2_Mapping.fValidateDate(l.inactive_date,'CCYYMMDD').PastDate = '' or
							 cnt = 3 and Corp2_Mapping.fValidateDate(l.expire_date,'CCYYMMDD').GeneralDate = ''	)
	  	self.norm_date  := choose(cnt, l.creation_date, l.inactive_date, l.expire_date);	
			self.norm_type  := choose(cnt, 'CRE'           , 'INA'            , 'EXP');
			self 						:= l;
		end;

		normCharterNames_09	:= normalize(CharterNames_09, 3, normEvent2Trf(left, counter)) : independent;
		
		// Map EVENTS from normCharterNames_09
		corp2_Mapping.LayoutsCommon.Events EventChartNmTrf(Corp2_Raw_TX.Layouts.normEvent2_Layout input) := transform
		              ,skip(corp2.t2u(input.filing_number) = '' or (integer)input.filing_number = 0)
        self.corp_key					           := state_fips + '-' + corp2.t2u(input.filing_number);
			  self.corp_vendor					       := state_fips;
			  self.corp_state_origin           := state_origin;
				self.corp_process_date			     := fileDate;
				self.corp_sos_charter_nbr		     := corp2.t2u(input.filing_number);
				self.event_filing_desc           := corp2.t2u(input.name);
				self.event_filing_date           := Corp2_Mapping.fValidateDate(input.norm_date,'CCYYMMDD').GeneralDate;	
				self.event_date_type_cd          := input.norm_type;
				self.event_date_type_desc        := case(input.norm_type, 'CRE'=>'NAME RESERVATION CREATION DATE',
																																	'INA'=>'NAME INACTIVE DATE',
																																	'EXP'=>'NAME RESERVATION EXPIRATION DT', '');
				self.event_filing_reference_nbr  := corp2.t2u(input.consent_filing_number);	// retained from old mapper																												
				self                             := [];
		end;  	
		
		
		// Map EVENTS from AssocEnt_10
		
		// Normalize on the 2 Filing Numbers 	
		Corp2_Raw_TX.Layouts.normMerger_Layout normMrgTrf(Corp2_Raw_TX.Layouts.AssocEnt_10_TempLay l, unsigned1 cnt) := transform,
					skip( cnt = 1 and corp2.t2u(l.entity_filing_number) = '' or
							  cnt = 2 and corp2.t2u(l.filing_number) = '' or
								corp2.t2u(l.capacity_id) not in ['0001','0002'])
	  	self.norm_filing_nbr  := choose(cnt, l.entity_filing_number, l.filing_number);	
			self.norm_type        := choose(cnt, if(corp2.t2u(l.capacity_id) = '0001','SURV','MERG'), if(corp2.t2u(l.capacity_id) = '0001','MERG','SURV'));
			self 						      := l;
		end;

		normMergers	:= normalize(jMergers, 2, normMrgTrf(left, counter));	
		
		corp2_Mapping.LayoutsCommon.Events EventAssocEntTrf(Corp2_Raw_TX.Layouts.normMerger_Layout input) := transform
						,skip(corp2.t2u(input.filing_number) = '' or (integer)input.filing_number = 0)  
        self.corp_key					           := state_fips + '-' + corp2.t2u(input.filing_number);
			  self.corp_vendor					       := state_fips;
			  self.corp_state_origin           := state_origin;
				self.corp_process_date			     := fileDate;
				self.corp_sos_charter_nbr		     := corp2.t2u(input.filing_number);
				self.event_date_type_desc        := 'DATE OF MERGER';
				self.event_filing_date           := Corp2_Mapping.fValidateDate(input.entity_filing_date,'CCYYMMDD').PastDate;	
				self.event_filing_desc           := case(input.norm_type,
																								 'SURV' => 'SURVIVING CORPORATION ID ' + input.norm_filing_nbr, 
																								 'MERG' => 'MERGED ID CORPORATION ID ' + input.norm_filing_nbr,
																								 '');
				self                             := [];
		end;  

		MapEvent1 	:= project(normFilingHist_11,   EventFilHistTrf(left));
		MapEvent2 	:= project(normCharterNames_09, EventChartNmTrf(left));
		MapEvent3 	:= project(normMergers,         EventAssocEntTrf(left));
	  // End EVENTS Mapping

		
		//*************************************
		// Begin AR Mapping
		//*************************************	
		corp2_Mapping.LayoutsCommon.AR ARTrf(Corp2_Raw_TX.Layouts.Master_02_layout input) := transform
								,skip(corp2.t2u(input.filing_number) = '' or 
								  		(integer)input.filing_number = 0 or
								      Corp2_Mapping.fValidateDate(input.report_due_date,'CCYYMMDD').GeneralDate = '')
        self.corp_key					    := state_fips + '-' + corp2.t2u(input.filing_number);
			  self.corp_vendor					:= state_fips;
			  self.corp_state_origin    := state_origin;
				self.corp_process_date		:= fileDate;
				self.corp_sos_charter_nbr	:= corp2.t2u(input.filing_number);
				self.ar_due_dt            := Corp2_Mapping.fValidateDate(input.report_due_date,'CCYYMMDD').GeneralDate; 						 
				self                      := [];
		end;  
		// End AR Mapping
		
	//-----------------------------------------------------------//
	// Build the Final Mapped Files
	//-----------------------------------------------------------//
		MapMain  := dedup(sort(distribute(MapCorp + MapCont                ,hash(corp_key)), record,local), record,local) : independent;
		MapEvent := dedup(sort(distribute(MapEvent1 + MapEvent2 + MapEvent3,hash(corp_key)), record,local), record,local) : independent;
	  MapAR    := dedup(sort(distribute(project(Master_02, ARTrf(left))  ,hash(corp_key)), record,local), record,local) : independent;
				
	//--------------------------------------------------------------------	
  // Scrubs for MAIN
  //--------------------------------------------------------------------
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_TX_Main.Scrubs;        // Scrubs module
		Main_N := Main_S.FromNone(Main_F); 										// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     	// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	  //Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_TX'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_TX'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_TX'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_TX_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

    //Submits Profile's stats to Orbit
    Main_SubmitStats          := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_TX_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_TX_Main').SubmitStats;

		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_TX_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_TX_Main').CompareToProfile_with_Examples;
		
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.AttachedList
																																	 ,'Scrubs CorpMain_TX Report' //subject
																																	 ,'Scrubs CorpMain_TX Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpTXMainScrubsReport.csv'
																																	);		
																																 
		Main_BadRecords := Main_T.ExpandedInFile(	dt_vendor_first_reported_invalid 			 				<> 0 or
																							dt_vendor_last_reported_invalid 			 				<> 0 or
																							dt_first_seen_invalid 							 	 				<> 0 or
																							dt_last_seen_invalid 													<> 0 or
																							corp_ra_dt_first_seen_invalid 								<> 0 or
																							corp_ra_dt_last_seen_invalid 					 				<> 0 or
																							corp_key_invalid 							 				 				<> 0 or
																							corp_vendor_invalid 									 				<> 0 or
																							corp_state_origin_invalid 						 				<> 0 or
																							corp_process_date_invalid 						 				<> 0 or
																							corp_orig_sos_charter_nbr_invalid 		 				<> 0 or
																							corp_legal_name_invalid 							 				<> 0 or
																							corp_ln_name_type_cd_invalid 					 				<> 0 or
																							corp_filing_date_invalid               				<> 0 or
																							corp_status_cd_invalid                 				<> 0 or
																							corp_name_status_cd_invalid                   <> 0 or
																							corp_status_date_invalid               				<> 0 or
																							corp_inc_state_invalid 								 				<> 0 or
																							corp_inc_date_invalid 								 				<> 0 or
																							corp_orig_bus_type_cd_invalid 		     				<> 0 or
																							corp_forgn_date_invalid 							 				<> 0 or
																							corp_orig_org_structure_cd_invalid     				<> 0 or
																							corp_ra_resign_date_invalid            				<> 0 or
																							corp_forgn_state_desc_invalid          				<> 0 or
																							cont_country_invalid                   				<> 0 or
																							corp_agent_country_invalid                    <> 0 or
																							corp_merger_date_invalid                		  <> 0 or
																							corp_merger_effective_date_invalid            <> 0 or
																							corp_name_reservation_expiration_date_invalid <> 0 or
																							corp_name_reservation_date_invalid            <> 0 or
																							corp_name_status_date_invalid                 <> 0 );

		Main_GoodRecords	:= Main_T.ExpandedInFile( dt_vendor_first_reported_invalid 			 				= 0 and
																								dt_vendor_last_reported_invalid 			 				= 0 and
																								dt_first_seen_invalid 							 	 				= 0 and
																								dt_last_seen_invalid 									 				= 0 and
																								corp_ra_dt_first_seen_invalid 				 				= 0 and
																								corp_ra_dt_last_seen_invalid 					 				= 0 and
																								corp_key_invalid 							 				 				= 0 and
																								corp_vendor_invalid 									 				= 0 and
																								corp_state_origin_invalid 						 				= 0 and
																								corp_process_date_invalid 						 				= 0 and
																								corp_orig_sos_charter_nbr_invalid 		 				= 0 and
																								corp_legal_name_invalid 							 				= 0 and
																								corp_ln_name_type_cd_invalid 					 				= 0 and
																								corp_filing_date_invalid               				= 0 and
																								corp_status_cd_invalid                 				= 0 and
																								corp_name_status_cd_invalid                   = 0 and
																								corp_status_date_invalid               				= 0 and
																								corp_inc_state_invalid 								 				= 0 and
																								corp_inc_date_invalid 								 				= 0 and
																								corp_orig_bus_type_cd_invalid 		     				= 0 and
																								corp_forgn_date_invalid 							 				= 0 and
																								corp_orig_org_structure_cd_invalid     				= 0 and
																								corp_ra_resign_date_invalid            				= 0 and
																								corp_forgn_state_desc_invalid          				= 0 and
																								cont_country_invalid                   				= 0 and
																								corp_agent_country_invalid										= 0 and
																								corp_merger_date_invalid                		  = 0 and
																								corp_merger_effective_date_invalid            = 0 and
																								corp_name_reservation_expiration_date_invalid = 0 and
																								corp_name_reservation_date_invalid            = 0 and
																								corp_name_status_date_invalid                 = 0 );
																							 																	
		
		Main_FailBuild	:= map(corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_TX_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),					 count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_TX_Main.Threshold_Percent.CORP_LEGAL_NAME 					=> true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),						     count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_TX_Main.Threshold_Percent.CORP_KEY      						=> true,
													 count(Main_GoodRecords) = 0																																																																																				          => true,
													 false );

		Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
	
		Main_RejFile_Exists		:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);			
	  Main_ALL		 					:= sequential(IF(count(Main_BadRecords) <> 0
																					,IF (poverwrite
																							,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_TX',overwrite,__compressed__,named('Sample_Rejected_MainRecs_TX'+filedate))
																							,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																													 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_TX'+filedate)))))
																		,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainTXScrubsReportWithExamples'+filedate))																		
																		//Send Alerts if Scrubs exceeds thresholds
																		,IF(COUNT(Main_ScrubsAlert) > 0, Main_SendEmailFile, OUTPUT('CORP2_MAPPING.TX - No "MAIN" Corp Scrubs Alerts'))
																		,Main_ErrorSummary
																		,Main_ScrubErrorReport
																		,Main_SomeErrorValues
																		,Main_SubmitStats);
	 
	
 //-------------------- Version Control -----------------------------------------------------//	
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::main_tx'			,Main_ApprovedRecords ,main_out		     ,,,pOverwrite);		
  VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_tx'			,MapEvent             ,event_out	     ,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_tx'				,MapAR		            ,ar_out			     ,,,pOverwrite);
	
	VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::main_tx'	,MapMain              ,write_fail_main ,,,pOverwrite);		
		
	mapTX:= sequential(   if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
											 	,main_out
												,event_out
												,ar_out
												,IF(Main_FailBuild <> true
												  	 ,sequential( fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::ar'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_TX')
																				 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::event' ,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_TX')
																				 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_TX')																		 
																				 ,if (count(Main_BadRecords) <> 0  
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),count(mapAR),count(mapEvent)).RecordsRejected																				 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),count(mapAR),count(mapEvent)).MappingSuccess																				 
																						 )	 
																			)
														 ,sequential( write_fail_main//if it fails on  main file threshold ,still writing mapped files!
																				 ,Corp2_Mapping.Send_Email(state_origin ,version).MappingFailed
																				)
													)
												,if (Main_IsScrubErrors 
														,Corp2_Mapping.Send_Email(state_origin ,version,Main_IsScrubErrors,false).FieldsInvalidPerScrubs)
												,Main_All	
										);
															
 		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-35) and ut.date_math(filedate,35),true,false);
		return sequential (if (isFileDateValid
														,mapTX
														,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('Corp2_Mapping.TX failed.  An invalid filedate was passed in as a parameter.')))); 	

 End; //Update Function

End;//End TX Module