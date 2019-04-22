import Corp2, Corp2_Raw_CA, corp2_mapping, Scrubs,Scrubs_Corp2_Mapping_CA_Main, Scrubs_Corp2_Mapping_CA_Event, versioncontrol, std, ut, Tools;

export CA := MODULE; 

	export Update(String filedate, string version, boolean pShouldSpray = Corp2_mapping._Dataset().bShouldSpray, boolean pOverwrite = false, boolean pUseProd = Tools._Constants.IsDataland) := Function

		state_origin	 := 'CA';
		state_fips	 	 := '06';	
		state_desc	 	 := 'CALIFORNIA';	 
	
		dMast := dedup(sort(distribute(Corp2_Raw_CA.Files(filedate,pUseProd).Input.Mast.logical,hash(Corp_Number)),record,local),record,local) : independent;	
		dHist := dedup(sort(distribute(Corp2_Raw_CA.Files(filedate,pUseProd).Input.Hist.logical,hash(Corp_Number)),record,local),record,local) : independent;	
		dLP   := dedup(sort(distribute(Corp2_Raw_CA.Files(filedate,pUseProd).Input.LP.logical,hash(file_number)),record,local),record,local) : independent;	
	
  //------- Begin MAIN CORP Mapping -----------------------------------------------------------------//	
	
	// Map Corp from dMast file 	
	Corp2_Mapping.LayoutsCommon.Main CorpMastTrf(Corp2_Raw_CA.Layouts.MastLayoutIn input) := transform 
    self.dt_vendor_first_reported	      := (integer)fileDate;
		self.dt_vendor_last_reported	      := (integer)fileDate;
		self.dt_first_seen				          := (integer)fileDate;
		self.dt_last_seen				            := (integer)fileDate;
		self.corp_ra_dt_first_seen		      := (integer)fileDate;
		self.corp_ra_dt_last_seen		        := (integer)fileDate;
		self.corp_key 					            := state_fips + '-' + corp2.t2u(input.Corp_Number);
		self.corp_vendor 					          := state_fips;
		self.corp_state_origin 			        := state_origin;
		self.corp_inc_state				          := state_origin;
		self.corp_process_date 			        := filedate;
		self.corp_orig_sos_charter_nbr 	    := 'C' + if(input.Corp_Number[1] = '0' ,corp2.t2u(input.Corp_Number[2..8]) ,corp2.t2u(input.Corp_Number));
		self.corp_legal_name 				        := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.Corp_Name).BusinessName;
		self.corp_ln_name_type_cd           := if (corp2.t2u(input.Corp_Type) = 'FNRE' ,'09' ,'01');
		self.corp_ln_name_type_desc 		    := if (corp2.t2u(input.Corp_Type) = 'FNRE' ,'REGISTRATION' ,'LEGAL');
	  self.corp_foreign_domestic_ind    	:= map ((corp2.t2u(input.State_Foreign_Country) in [state_origin,state_desc,''] or
																							     (corp2.t2u(input.State_Foreign_Country) = '' and corp2.t2u(input.corp_type) = 'ARTS')) => 'D',
		    																				(corp2.t2u(input.State_Foreign_Country) not in [state_origin,state_desc,''] or
																							     (corp2.t2u(input.State_Foreign_Country) = '' and corp2.t2u(input.corp_type) in ['S&DC','S&DA','FNRE'])) => 'F',
																								'');
		self.corp_inc_date 				          := if (self.corp_foreign_domestic_ind = 'D' ,Corp2_Mapping.fValidateDate(input.Incorp_Date,'CCYYMMDD').PastDate,'');
		self.corp_forgn_date                := if (self.corp_foreign_domestic_ind = 'F' ,Corp2_Mapping.fValidateDate(input.Incorp_Date,'CCYYMMDD').PastDate,'');
		
		state_cd                            := Corp2_Raw_CA.Functions.GetStateCD(input.State_Foreign_Country);
		self.corp_forgn_state_cd            := if (corp2.t2u(input.State_Foreign_Country) not in ['',state_origin,state_desc]	
																							,Corp2_Raw_CA.Functions.ValidStateCD(state_cd) ,'');	
		self.corp_forgn_state_desc          := Corp2_Raw_CA.Functions.GetStateDesc(state_cd);
		self.corp_status_cd 				        := corp2.t2u(input.Corp_Status);
		self.corp_status_desc 			        := Corp2_Raw_CA.Functions.GetStatusDesc(input.Corp_Status);
		self.corp_filing_cd									:= corp2.t2u(input.Corp_type);
		self.corp_filing_desc								:= case(corp2.t2u(input.Corp_type),
																								'ARTS' => 'ARTICLES OF INCORPORATION',
		                                            'S&DC' => 'STATEMENT & DESIGNATION BY FOREIGN CORPORATION',
																								'S&DA' => 'STATEMENT & DESIGNATION BY FOREIGN ASSOCIATION',
																								'FNRE' => 'FOREIGN NAME REGISTRATION',
																								'');
    self.corp_orig_org_structure_cd     := corp2.t2u(input.Corp_type);
		self.corp_orig_org_structure_desc   := case(corp2.t2u(input.Corp_type),
																								'ARTS' => 'CORPORATION',
		                                            'S&DC' => 'FOREIGN CORPORATION',
																								'S&DA' => 'FOREIGN BUSINESS TRUST',
																								'FNRE' => 'FOREIGN CORPORATION',
																								'');
    self.corp_tax_base                  := if (corp2.t2u(input.Corp_Tax_Base) in ['S','N'] ,corp2.t2u(input.Corp_Tax_Base) ,'');
		self.corp_for_profit_ind            := if (corp2.t2u(input.Corp_Tax_Base) = 'N', 'N', '');
		self.corp_orig_bus_type_cd 	      	:= corp2.t2u(input.Corp_Classification);
		self.corp_orig_bus_type_desc 	     	:= Corp2_Raw_CA.Functions.GetBusTypDesc(input.Corp_Classification);
		self.corp_term_exist_exp            := Corp2_Mapping.fValidateDate(input.Term_Expiration_Date,'CCYYMMDD').GeneralDate;
		self.corp_term_exist_cd             := if (self.corp_term_exist_exp <> '', 'D', 'P');
		self.corp_term_exist_desc           := case(self.corp_term_exist_cd, 'D'=>'EXPIRATION DATE', 'P'=>'PERPETUAL', '');
		self.corp_tax_program_cd            := corp2.t2u(input.FTB_Suspen_Status_Code);
		self.corp_tax_program_desc	        := case (corp2.t2u(input.FTB_Suspen_Status_Code),
																								 ''  => 'NOT SUSPENDED-IN GOOD STANDING',
																			        	 'F' => 'FORFEITED- FRANCHISE TAX BOARD',
																				         'S' => 'SUSPENDED- FRANCHISE TAX BOARD',
																				         '');
		self.corp_status_date				        := Corp2_Mapping.fValidateDate(input.FTB_Suspen_Date,'CCYYMMDD').PastDate;
		mail_state                          := if (length(corp2.t2u(input.Mail_address_state)) > 2, '', corp2.t2u(input.Mail_address_state));
		mail_country                        := if (length(corp2.t2u(input.Mail_address_state)) < 3, '', corp2.t2u(input.Mail_address_state));
		self.corp_address1_type_cd          := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.Care_of_Name + ' ' + input.Mail_Address1,input.Mail_Address2,input.Mail_Address_City,mail_state,input.Mail_Address_Zipcode,mail_country).ifAddressExists, 'M', '');			
		self.corp_address1_type_desc        := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.Care_of_Name + ' ' + input.Mail_Address1,input.Mail_Address2,input.Mail_Address_City,mail_state,input.Mail_Address_Zipcode,mail_country).ifAddressExists, 'MAILING', '');
		self.corp_address1_line1					  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Care_of_Name + ' ' + input.Mail_Address1,input.Mail_Address2,input.Mail_Address_City,mail_state,input.Mail_Address_Zipcode,mail_country).AddressLine1;
		self.corp_address1_line2					  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Care_of_Name + ' ' + input.Mail_Address1,input.Mail_Address2,input.Mail_Address_City,mail_state,input.Mail_Address_Zipcode,mail_country).AddressLine2;
		self.corp_address1_line3					  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Care_of_Name + ' ' + input.Mail_Address1,input.Mail_Address2,input.Mail_Address_City,mail_state,input.Mail_Address_Zipcode,mail_country).AddressLine3;			
		self.corp_prep_addr1_line1				  := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Care_of_Name + ' ' + input.Mail_Address1,input.Mail_Address2,input.Mail_Address_City,mail_state,input.Mail_Address_Zipcode,mail_country).PrepAddrLine1;			
		self.corp_prep_addr1_last_line	    := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Care_of_Name + ' ' + input.Mail_Address1,input.Mail_Address2,input.Mail_Address_City,mail_state,input.Mail_Address_Zipcode,mail_country).PrepAddrLastLine;
		
		self.corp_ra_full_name				      := if (stringLib.stringFind(corp2.t2u(input.Agent_Name),'RESIGNED',1) = 0 ,Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.Agent_Name).BusinessName ,'');
		ra_dt                               := if (stringLib.stringFind(corp2.t2u(input.Agent_Name),'RESIGNED',1) <> 0 
																							,stringlib.stringfilter(input.Agent_Name,'/-0123456789') ,'');
		self.corp_ra_resign_date            := map (stringLib.stringFind(ra_dt,'/',1) <> 0 => Corp2_Mapping.fValidateDate(ra_dt,'MM/DD/CCYY').PastDate,
		                                            stringLib.stringFind(ra_dt,'-',1) <> 0 => Corp2_Mapping.fValidateDate(ra_dt,'MM-DD-CCYY').PastDate,
																								'');

		Agent_state                         := if (length(corp2.t2u(input.Agent_address_state)) > 2, '', corp2.t2u(input.Agent_address_state));
		Agent_country                       := if (length(corp2.t2u(input.Agent_address_state)) < 3, '', corp2.t2u(input.Agent_address_state));
		self.corp_ra_address_type_cd        := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.Agent_Address1,input.Agent_Address2,input.Agent_Address_City,Agent_state,input.Agent_Address_Zipcode,Agent_country).ifAddressExists, 'R', '');			
		self.corp_ra_address_type_desc      := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.Agent_Address1,input.Agent_Address2,input.Agent_Address_City,Agent_state,input.Agent_Address_Zipcode,Agent_country).ifAddressExists, 'REGISTERED OFFICE', '');
		self.corp_ra_address_line1					:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Agent_Address1,input.Agent_Address2,input.Agent_Address_City,Agent_state,input.Agent_Address_Zipcode,Agent_country).AddressLine1;
		self.corp_ra_address_line2					:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Agent_Address1,input.Agent_Address2,input.Agent_Address_City,Agent_state,input.Agent_Address_Zipcode,Agent_country).AddressLine2;
		self.corp_ra_address_line3					:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Agent_Address1,input.Agent_Address2,input.Agent_Address_City,Agent_state,input.Agent_Address_Zipcode,Agent_country).AddressLine3;			
		self.ra_prep_addr_line1				      := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Agent_Address1,input.Agent_Address2,input.Agent_Address_City,Agent_state,input.Agent_Address_Zipcode,Agent_country).PrepAddrLine1;			
		self.ra_prep_addr_last_line	        := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.Agent_Address1,input.Agent_Address2,input.Agent_Address_City,Agent_state,input.Agent_Address_Zipcode,Agent_country).PrepAddrLastLine;
		
  	self.recordOrigin                   := 'C';		
		self 							                  := input; 
		self						                    := [];
	end;
  
	// Map Corp from dLP file 	(dLP file contains both LP & LLC data)
	Corp2_Mapping.LayoutsCommon.Main CorpLPTrf(Corp2_Raw_CA.Layouts.LPLayoutIn input) := transform 
				,skip(corp2.t2u(input.name) = '')
	  self.dt_vendor_first_reported	      := (integer)fileDate;
		self.dt_vendor_last_reported	      := (integer)fileDate;
		self.dt_first_seen				          := (integer)fileDate;
		self.dt_last_seen				            := (integer)fileDate;
		self.corp_ra_dt_first_seen		      := (integer)fileDate;
		self.corp_ra_dt_last_seen		        := (integer)fileDate;
		self.corp_key 					            := state_fips + '-' + corp2.t2u(input.file_number);
		self.corp_vendor 					          := state_fips;
		self.corp_state_origin 			        := state_origin;
		self.corp_inc_state				          := state_origin;
		self.corp_process_date 			        := filedate;
		self.corp_orig_sos_charter_nbr 	    := corp2.t2u(input.file_number);
		self.corp_legal_name 				        := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.name).BusinessName;
		self.corp_ln_name_type_cd 		      := '01';
		self.corp_ln_name_type_desc 		    := 'LEGAL';
		self.corp_orig_org_structure_desc   := case(input.file_number[8],	'1'=>'LIMITED LIABILITY COMPANY', '0'=>'LIMITED PARTNERSHIP', '');
		self.corp_orig_bus_type_desc 		    := corp2.t2u(input.llc_business_type);
		self.corp_inc_date 			          	:= if (corp2.t2u(input.filing_type) = 'D' ,Corp2_Mapping.fValidateDate(input.file_date,'CCYYMMDD').PastDate ,'');
		self.corp_forgn_date 			          := if (corp2.t2u(input.filing_type) = 'F' ,Corp2_Mapping.fValidateDate(input.file_date,'CCYYMMDD').PastDate ,'');
		self.corp_foreign_domestic_ind 	    := corp2.t2u(input.filing_type);
		self.corp_forgn_state_cd            := if (corp2.t2u(input.file_number[8]) in ['0','1'] and corp2.t2u(input.original_jurisdiction) not in ['',state_origin,state_desc]
																							 ,corp2.t2u(input.original_jurisdiction),'');
		self.corp_forgn_state_desc					:= Corp2_Raw_CA.Functions.GetStateDesc(self.corp_forgn_state_cd);
    self.corp_status_cd 				        := corp2.t2u(input.status);
		self.corp_status_desc 			        := Corp2_Raw_CA.Functions.GetDLPStatusDesc(input.status);
		self.corp_management_desc           := if (stringlib.stringfilter(input.number_gp_amend,'0123456789') <> ''
		                                           ,'REQUIRED NUMBER OF GP SIGNATURES FOR AMENDMENT ' + input.number_gp_amend ,'');
	  self.corp_llc_managed_desc          := case(corp2.t2u(input.llc_mgmt_code),
																							  '1' => 'ONE MANAGER',
																								'M' => 'MORE THAN ONE MANAGER',
																								'A' => 'ALL MEMBERS ARE MANAGERS',
																								'S' => 'ONE MEMBER',
																								'');
		self.corp_nbr_of_amendments         := if(input.number_amendments <> '000' ,REGEXREPLACE('^0+',corp2.t2u(input.number_amendments),'') ,'');
		self.corp_amendments_filed 		      := if(input.number_amendments <> '000' ,REGEXREPLACE('^0+',corp2.t2u(input.number_amendments),'') ,''); // retaining since corp_nbr_of_amendments is a new field
		self.corp_ra_full_name 				      := if (stringLib.stringFind(corp2.t2u(input.Agent_Name),'RESIGNED',1) = 0
																							,Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.Agent_Name).BusinessName ,'');
	  ra_dt                               := if (stringLib.stringFind(corp2.t2u(input.Agent_Name),'RESIGNED',1) <> 0 
																							,stringlib.stringfilter(input.Agent_Name,'/-0123456789') ,'');
		self.corp_ra_resign_date            := map (stringLib.stringFind(ra_dt,'/',1) <> 0 => Corp2_Mapping.fValidateDate(ra_dt,'MM/DD/CCYY').PastDate,
		                                            stringLib.stringFind(ra_dt,'-',1) <> 0 => Corp2_Mapping.fValidateDate(ra_dt,'MM-DD-CCYY').PastDate,
																								'');
		self.corp_addl_info 								:= if(stringlib.stringfilter(input.number_gp_amend,'0123456789') <> '' and (integer)input.addl_gp <> 0,'NUMBER OF GPs REQUIRED TO AMEND: '+ input.number_gp_amend,'') +
																					 if(stringlib.stringfilter(input.number_gp_amend,'0123456789') <> '' and (integer)input.addl_gp <> 0 and regexfind('1|M|A|S',Input.llc_mgmt_code),'; ','') +
																					 case(input.llc_mgmt_code,'1'=> 'ONE MANAGER','M' => 'MORE THAN 1 MANAGER' ,'A'=>'ALL MEMBERS ARE MANAGERS','S' => 'ONE MEMBER' , '');

    // For the corp_addresses, if the "calif" address is valid, it gets mapped to corp_address1.  
		//   If the "calif" address is not valid, then the "mailing" address goes into corp_address1.
		//   If both addresses are valid, "calif" goes into corp_address1 and "mailing" goes into corp_address2.
	  calif_st := Corp2_Raw_CA.Functions.GetStateFromZip((integer)corp2.t2u(input.calif_zip[1..5]));
    add1     := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.calif_address,'',input.calif_city,calif_st,input.calif_zip,'').ifAddressExists, true, false);		
    add2     := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.mailing_address,'',input.mailing_city,input.mailing_state,input.mailing_zip,'').ifAddressExists, true, false);		

    self.corp_address1_type_cd          := map (add1 = true => 'B', add2 = true => 'M', '');			
		self.corp_address1_type_desc        := map (add1 = true => 'BUSINESS', add2 = true => 'MAILING', '');
 		self.corp_address1_line1					  := map (add1 = true => Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.calif_address,'',input.calif_city,calif_st,input.calif_zip,'').AddressLine1,
																								add2 = true => Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.mailing_address,'',input.mailing_city,input.mailing_state,input.mailing_zip,'').AddressLine1,
																								'');	
		self.corp_address1_line2					  := map (add1 = true => Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.calif_address,'',input.calif_city,calif_st,input.calif_zip,'').AddressLine2,
																								add2 = true => Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.mailing_address,'',input.mailing_city,input.mailing_state,input.mailing_zip,'').AddressLine2,
																								'');
		self.corp_address1_line3					  := map (add1 = true => Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.calif_address,'',input.calif_city,calif_st,input.calif_zip,'').AddressLine3,
																								add2 = true => Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.mailing_address,'',input.mailing_city,input.mailing_state,input.mailing_zip,'').AddressLine3,
																								'');	
		self.corp_prep_addr1_line1				  := map (add1 = true => Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.calif_address,'',input.calif_city,calif_st,input.calif_zip,'').PrepAddrLine1,
																								add2 = true => Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.mailing_address,'',input.mailing_city,input.mailing_state,input.mailing_zip,'').PrepAddrLine1,
																								'');			
		self.corp_prep_addr1_last_line	    := map (add1 = true => Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.calif_address,'',input.calif_city,calif_st,input.calif_zip,'').PrepAddrLastLine,
																								add2 = true => Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.mailing_address,'',input.mailing_city,input.mailing_state,input.mailing_zip,'').PrepAddrLastLine,
																								'');

		self.corp_address2_type_cd          := if (add1 = true and add2 = true, 'M', '');			
		self.corp_address2_type_desc        := if (add1 = true and add2 = true, 'MAILING', '');
		self.corp_address2_line1					  := if (add1 = true ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.mailing_address,'',input.mailing_city,input.mailing_state,input.mailing_zip,'').AddressLine1 ,'');
		self.corp_address2_line2					  := if (add1 = true ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.mailing_address,'',input.mailing_city,input.mailing_state,input.mailing_zip,'').AddressLine2 ,'');
		self.corp_address2_line3					  := if (add1 = true ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.mailing_address,'',input.mailing_city,input.mailing_state,input.mailing_zip,'').AddressLine3 ,'');			
		self.corp_prep_addr2_line1				  := if (add1 = true ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.mailing_address,'',input.mailing_city,input.mailing_state,input.mailing_zip,'').PrepAddrLine1 ,'');			
		self.corp_prep_addr2_last_line	    := if (add1 = true ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.mailing_address,'',input.mailing_city,input.mailing_state,input.mailing_zip,'').PrepAddrLastLine ,'');
    
    self.corp_ra_address_type_cd        := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.agent_address1,input.agent_address2,input.agent_city,input.agent_state,input.agent_zip,'').ifAddressExists, 'R', '');			
		self.corp_ra_address_type_desc      := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.agent_address1,input.agent_address2,input.agent_city,input.agent_state,input.agent_zip,'').ifAddressExists, 'REGISTERED OFFICE', '');
		self.corp_ra_address_line1					:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.agent_address1,input.agent_address2,input.agent_city,input.agent_state,input.agent_zip,'').AddressLine1;
		self.corp_ra_address_line2					:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.agent_address1,input.agent_address2,input.agent_city,input.agent_state,input.agent_zip,'').AddressLine2;
		self.corp_ra_address_line3					:= Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.agent_address1,input.agent_address2,input.agent_city,input.agent_state,input.agent_zip,'').AddressLine3;			
		self.ra_prep_addr_line1				      := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.agent_address1,input.agent_address2,input.agent_city,input.agent_state,input.agent_zip,'').PrepAddrLine1;			
		self.ra_prep_addr_last_line	        := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.agent_address1,input.agent_address2,input.agent_city,input.agent_state,input.agent_zip,'').PrepAddrLastLine;
																	 													
		self.recordOrigin                   := 'C';	
		self                       		      := [];
	end;
	
	MapCorp   := project(dMast,CorpMastTrf(left)) + project(dLP,CorpLPTrf(left));
  //---------- End MAIN CORP Mapping --------------------------------------------------------------//


  //------- Begin MAIN CONT Mapping ----------------------------------------------------------------//	

  // Normalize on the 2 sets of LP Contact data	

		Corp2_Raw_CA.Layouts.normContactLayout normContactTrf(Corp2_Raw_CA.Layouts.LPLayoutIn input, unsigned1 cnt) := transform
					,skip((cnt=1 and corp2.t2u(input.gpmm1_name) = '') or
					      (cnt=2 and corp2.t2u(input.gpmm2_name) = ''))
			self.norm_name    := choose(cnt, input.gpmm1_name   , input.gpmm2_name);
			self.norm_address := choose(cnt, input.gpmm1_address, input.gpmm2_address);
			self.norm_city    := choose(cnt, input.gpmm1_city   , input.gpmm2_city);
			self.norm_state   := choose(cnt, input.gpmm1_state  , input.gpmm2_state);
			self.norm_zip     := choose(cnt, input.gpmm1_zip    , input.gpmm2_zip);
		  self              := input;
			self 					    := [];
		end;
	
	normLPContacts	:= normalize(dLP, 2, normContactTrf(left, counter));	
  
	// Map Cont from normalize of dLP file 
  Corp2_Mapping.LayoutsCommon.Main ContLPTrf(Corp2_Raw_CA.Layouts.normContactLayout input) := transform
	  self.dt_vendor_first_reported	      := (integer)fileDate;
		self.dt_vendor_last_reported	      := (integer)fileDate;
		self.dt_first_seen				          := (integer)fileDate;
		self.dt_last_seen				            := (integer)fileDate;
		self.corp_ra_dt_first_seen		      := (integer)fileDate;
		self.corp_ra_dt_last_seen		        := (integer)fileDate;		
		self.corp_process_date 			        := filedate;
		self.corp_key 					            := state_fips + '-' + corp2.t2u(input.file_number);
		self.corp_vendor 					          := state_fips;
		self.corp_state_origin 			        := state_origin;
		self.corp_inc_state                 := state_origin;
		self.corp_orig_sos_charter_nbr 	    := corp2.t2u(input.file_number);
		self.corp_legal_name 				        := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.name).BusinessName;
		self.cont_type_cd 				          := 'M';
		self.cont_type_desc 				        := 'MEMBER/MANAGER/PARTNER';	
		self.cont_full_name			            := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.norm_name).BusinessName;
		self.cont_address_type_cd           := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.norm_address,'',input.norm_city,input.norm_state,input.norm_zip).ifAddressExists, 'T', '');			
		self.cont_address_type_desc         := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.norm_address,'',input.norm_city,input.norm_state,input.norm_zip).ifAddressExists, 'CONTACT', '');
		self.cont_address_line1					    := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.norm_address,'',input.norm_city,input.norm_state,input.norm_zip).AddressLine1;
		self.cont_address_line2					    := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.norm_address,'',input.norm_city,input.norm_state,input.norm_zip).AddressLine2;
		self.cont_address_line3					    := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.norm_address,'',input.norm_city,input.norm_state,input.norm_zip).AddressLine3;			
		self.cont_prep_addr_line1				    := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.norm_address,'',input.norm_city,input.norm_state,input.norm_zip).PrepAddrLine1;			
		self.cont_prep_addr_last_line	      := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.norm_address,'',input.norm_city,input.norm_state,input.norm_zip).PrepAddrLastLine;
 		self.recordOrigin                   := 'T';			
		self                       		      :=[];
	end;
	
	// Map Cont from dMast file 
	Corp2_Mapping.LayoutsCommon.Main ContMastTrf(Corp2_Raw_CA.Layouts.MastLayoutIn input) := transform
				,skip(corp2.t2u(input.President_Name) = '')
		self.dt_vendor_first_reported	      := (integer)fileDate;
		self.dt_vendor_last_reported	      := (integer)fileDate;
		self.dt_first_seen				          := (integer)fileDate;
		self.dt_last_seen				            := (integer)fileDate;
		self.corp_ra_dt_first_seen		      := (integer)fileDate;
		self.corp_ra_dt_last_seen		        := (integer)fileDate;
		self.corp_key 					            := state_fips + '-' + corp2.t2u(input.Corp_Number);
		self.corp_vendor 					          := state_fips;
		self.corp_state_origin 			        := state_origin;
		self.corp_inc_state                 := state_origin;
		self.corp_process_date 			        := filedate;
		self.corp_orig_sos_charter_nbr     	:= 'C' + if(input.Corp_Number[1] = '0' ,corp2.t2u(input.Corp_Number[2..8]) ,corp2.t2u(input.Corp_Number));
		self.corp_legal_name 				        := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.Corp_Name).BusinessName;
		self.cont_type_cd 				          := 'F';
		self.cont_type_desc 				        := 'CHIEF EXECUTIVE OFFICER';	
		self.cont_full_name 					      := if (corp2.t2u(input.President_Name) IN ['','VACANCY','VACANCY NONE','VACANCY VACANCY','NOT APPLICABLE']
																							 ,'' ,Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.President_Name).BusinessName);
    pres_state                          := if (length(corp2.t2u(input.President_address_state)) > 2, '', corp2.t2u(input.President_address_state));
		pres_country                        := if (length(corp2.t2u(input.President_address_state)) < 3, '', corp2.t2u(input.President_address_state));
		self.cont_address_type_cd           := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.President_Address1,input.President_Address2,input.President_Address_City,pres_state,input.President_Address_Zipcode,pres_country).ifAddressExists, 'T', '');			
		self.cont_address_type_desc         := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.President_Address1,input.President_Address2,input.President_Address_City,pres_state,input.President_Address_Zipcode,pres_country).ifAddressExists, 'CONTACT', '');
		self.cont_address_line1					    := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.President_Address1,input.President_Address2,input.President_Address_City,pres_state,input.President_Address_Zipcode,pres_country).AddressLine1;
		self.cont_address_line2					    := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.President_Address1,input.President_Address2,input.President_Address_City,pres_state,input.President_Address_Zipcode,pres_country).AddressLine2;
		self.cont_address_line3					    := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.President_Address1,input.President_Address2,input.President_Address_City,pres_state,input.President_Address_Zipcode,pres_country).AddressLine3;			
		self.cont_prep_addr_line1				    := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.President_Address1,input.President_Address2,input.President_Address_City,pres_state,input.President_Address_Zipcode,pres_country).PrepAddrLine1;			
		self.cont_prep_addr_last_line	      := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.President_Address1,input.President_Address2,input.President_Address_City,pres_state,input.President_Address_Zipcode,pres_country).PrepAddrLastLine;
		self.recordOrigin                   := 'T';		
		self         				                := [];
	end;
	
	MapCont   := project(dMast,ContMastTrf(left)) + project(normLPContacts,ContLPTrf(left));
  //---------- End MAIN CONT Mapping --------------------------------------------------------------//

  
	//------- Begin STOCK Mapping -------------------------------------------------------------------//	
 
  // Map Stock from dMast file
	Corp2_Mapping.LayoutsCommon.Stock StockTrf(Corp2_Raw_CA.Layouts.MastLayoutIn input) := transform
				,skip(corp2.t2u(input.corp_tax_base) not in ['S','N'] or corp2.t2u(input.Corp_Number) = '')
		self.corp_key 					  := state_fips + '-' + corp2.t2u(input.Corp_Number);
		self.corp_vendor 				  := state_fips;
		self.corp_state_origin 	  := state_origin;
		self.corp_process_date 	  := filedate;
		self.corp_sos_charter_nbr := 'C' + if(input.Corp_Number[1] = '0' ,corp2.t2u(input.Corp_Number[2..8]) ,corp2.t2u(input.Corp_Number));
		self.stock_addl_info			:= case(corp2.t2u(input.corp_tax_base),	'S'=>'STOCK', 'N'=>'NON-STOCK (NONPROFIT)', '');
		self							        := [];
	end;
	
	mapStock1	:= project(dMast, StockTrf(left));

	//---------- End Stock Mapping --------------------------------------------------------------//
 
 
 //------- Begin EVENTS Mapping -------------------------------------------------------------------//	
 
 // Normalize on the 2 sets of Event data	
		Corp2_Raw_CA.Layouts.normEventLayout normEventTrf(Corp2_Raw_CA.Layouts.MastLayoutIn input, unsigned1 cnt) := transform
				 ,skip((cnt=1 and input.FTB_Suspen_Date = '' and input.Statement_of_File_Date <> '') or
				   		 (cnt=2 and input.Statement_of_File_Date = ''))
			self.norm_type  		 := choose(cnt ,if(input.FTB_Suspen_Date        <> '','SUS','')
																  			 ,if(input.Statement_of_File_Date <> '','SO',''));
			self.norm_event_cd   := choose(cnt, corp2.t2u(input.FTB_Suspen_Status_Code), '');
			self.norm_event_date := choose(cnt, if(corp2.t2u(input.FTB_Suspen_Status_Code) in ['F','S'] ,corp2.t2u(input.FTB_Suspen_Date), '')       
																				, corp2.t2u(map(input.Statement_of_File_Date[1] in ['0','1']     => '20' + corp2.t2u(input.Statement_of_File_Date),
																				  	            input.Statement_of_File_Date[1] in ['7','8','9'] => '19' + corp2.t2u(input.Statement_of_File_Date),
																										    ''))); 	
			self.norm_event_ref  := choose(cnt, '', corp2.t2u(input.Statement_of_Officers_File_Num)); 	
			self                 := input;
			self 					       := [];
		end;
	
		normEvents	:= normalize(dMast, 2, normEventTrf(left, counter));	
  
 // Map Events from normalize of dMast file	
	Corp2_Mapping.LayoutsCommon.Events EventsMastTrf(Corp2_Raw_CA.Layouts.normEventLayout input) := transform 
		self.corp_key 					        := state_fips + '-' + corp2.t2u(input.Corp_Number);
		self.corp_sos_charter_nbr       := 'C' + if(input.Corp_Number[1] = '0' ,corp2.t2u(input.Corp_Number[2..8]) ,corp2.t2u(input.Corp_Number));
		self.corp_vendor 					      := state_fips;
		self.corp_state_origin 		      := state_origin;
		self.corp_process_date 		      := filedate;
		self.event_filing_date          := Corp2_Mapping.fValidateDate(input.norm_event_date,'CCYYMMDD').PastDate;	
		self.event_date_type_cd         := map (corp2.t2u(input.norm_type) = 'SO'                                           => 'FIL',
																					  corp2.t2u(input.norm_type) = 'SUS' and corp2.t2u(input.norm_event_cd) = 'F' => 'FOR',
																					  corp2.t2u(input.norm_type) = 'SUS' and corp2.t2u(input.norm_event_cd) = 'S' => 'SUS',
																					  '');
		self.event_date_type_desc       := case(self.event_date_type_cd, 'FIL'=>'FILING', 'FOR'=>'FORFEITURE', 'SUS'=>'SUSPENDED',	'');
		self.event_filing_desc          := map (self.event_date_type_cd = 'FIL' => 'STATEMENT OF OFFICERS INFORMATION',
		                                        self.event_date_type_cd = 'FOR' => 'FORFEITED BY FRANCHISE TAX BOARD',
																			      self.event_date_type_cd = 'SUS' => 'SUSPENDED BY FRANCHISE TAX BOARD',
																				    '');
		self.event_filing_reference_nbr := corp2.t2u(input.norm_event_ref);
		self                            := [];
	end; 

  // Map Events from dHist file	
	Corp2_Mapping.LayoutsCommon.Events EventsHistTrf(Corp2_Raw_CA.Layouts.HistLayoutIn  input) := transform
		self.corp_key 					        := state_fips + '-' + corp2.t2u(input.Corp_Number);
    self.corp_sos_charter_nbr       := 'C' + if(input.Corp_Number[1] = '0' ,corp2.t2u(input.Corp_Number[2..8]) ,corp2.t2u(input.Corp_Number));
		self.corp_vendor 				        := state_fips;
		self.corp_state_origin 		      := state_origin;
		self.corp_process_date 		      := filedate;
		self.event_filing_date          := Corp2_Mapping.fValidateDate(input.Transaction_Date,'CCYYMMDD').PastDate;	
		self.event_filing_reference_nbr	:= corp2.t2u(input.Document_Number);
		self.event_filing_cd 			      := corp2.t2u(input.Transaction_Code);
		self.event_filing_desc          := Corp2_Raw_CA.Functions.GetTransDesc(input.Transaction_Code);
		self.event_desc                 := if (corp2.t2u(input.Comment) <> '' and corp2.t2u(input.Old_Corp_Name) <> '' 
																					,corp2.t2u(input.Comment) + ', OLD NAME: ' + corp2.t2u(input.Old_Corp_Name)
																					,'');
		self.event_date_type_cd 		    := 'FIL';		
		self.event_date_type_desc 		  := 'FILING TRANSACTION DATE';
		self.event_corp_nbr 						:= map (corp2.t2u(input.name_corp_number) in ['Q','NQ',''] => '',
		                                        input.Name_Corp_Number[1] = '6' => corp2.t2u(input.Name_Corp_Number),
																						'C'+ REGEXREPLACE('^0',input.Name_Corp_Number,''));
	  self.event_corp_nbr_desc        := if (self.event_corp_nbr <> '', 'NUMBER OF CORPORATION INVOLVED', '');
		self                            :=[];                                             
	END;
	
	MapEvent1 := project(normEvents,EventsMastTrf(left)) + project(dHist,EventsHistTrf(left));
	//---------- End EVENTS Mapping --------------------------------------------------------------//
			 
	//-----------------------------------------------------------//
	// Build the Final Mapped Files
	//-----------------------------------------------------------//
	mapMain   := dedup(sort(distribute(mapCorp + mapCont,hash(corp_key)), record,local), record,local) : independent;	
	mapStock	:= dedup(sort(distribute(mapStock1,hash(corp_key)), record,local), record,local) : independent;
  mapEvent	:= dedup(sort(distribute(mapEvent1,hash(corp_key)), record,local), record,local) : independent;	
		

	//--------------------------------------------------------------------	
  // Scrubs for MAIN
  //--------------------------------------------------------------------
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_CA_Main.Scrubs;        // Scrubs module
		Main_N := Main_S.FromNone(Main_F); 										// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     	// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_CA'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_CA'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_CA'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_CA_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

	  //Submits Profile's stats to Orbit
		Main_SubmitStats 					:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_CA_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_CA_Main').SubmitStats;

		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_CA_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_CA_Main').CompareToProfile_with_Examples;
		
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.AttachedList
																																	 ,'Scrubs CorpMain_CA Report' //subject
																																	 ,'Scrubs CorpMain_CA Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpCAMainScrubsReport.csv'
																																	);		
																																 
		Main_BadRecords := Main_T.ExpandedInFile(	dt_vendor_first_reported_invalid 	  <> 0 or
																							dt_vendor_last_reported_invalid 	  <> 0 or
																							dt_first_seen_invalid 			        <> 0 or
																							dt_last_seen_invalid 			          <> 0 or
																							corp_ra_dt_first_seen_invalid 		  <> 0 or
																							corp_ra_dt_last_seen_invalid 			  <> 0 or
																							corp_key_invalid 			              <> 0 or
																							corp_vendor_invalid 			          <> 0 or
																							corp_state_origin_invalid 			    <> 0 or
																							corp_process_date_invalid 			    <> 0 or
																							corp_orig_sos_charter_nbr_invalid   <> 0 or
																							corp_legal_name_invalid 			      <> 0 or
																							corp_status_cd_invalid 						  <> 0 or
																							corp_status_date_invalid            <> 0 or
																							corp_inc_state_invalid 			        <> 0 or
																							corp_inc_date_invalid               <> 0 or
																							corp_foreign_domestic_ind_invalid   <> 0 or
																							corp_forgn_date_invalid             <> 0 or
																							corp_orig_org_structure_cd_invalid  <> 0 or
																							corp_for_profit_ind_invalid 			  <> 0 or
																							corp_ln_name_type_cd_invalid        <> 0 or
																							corp_ra_resign_date_invalid         <> 0 or
																							corp_name_status_date_invalid       <> 0 or
																							corp_orig_bus_type_cd_invalid       <> 0 or
																							corp_term_exist_cd_invalid          <> 0 or
																							corp_ln_name_type_desc_invalid      <> 0 or
																							corp_forgn_state_desc_invalid       <> 0 or
																							corp_tax_program_cd_invalid         <> 0 );


		Main_GoodRecords	:= Main_T.ExpandedInFile( dt_vendor_first_reported_invalid 	  = 0 and
																								dt_vendor_last_reported_invalid 	  = 0 and
																								dt_first_seen_invalid 			        = 0 and
																								dt_last_seen_invalid 			          = 0 and
																								corp_ra_dt_first_seen_invalid 		  = 0 and
																								corp_ra_dt_last_seen_invalid 			  = 0 and
																								corp_key_invalid 			              = 0 and
																								corp_vendor_invalid 			          = 0 and
																								corp_state_origin_invalid 			    = 0 and
																								corp_process_date_invalid 			    = 0 and
																								corp_orig_sos_charter_nbr_invalid   = 0 and
																								corp_legal_name_invalid 			      = 0 and
																								corp_status_cd_invalid 						  = 0 and
																								corp_status_date_invalid            = 0 and
																								corp_inc_state_invalid 			        = 0 and
																								corp_inc_date_invalid               = 0 and
																								corp_foreign_domestic_ind_invalid   = 0 and
																								corp_forgn_date_invalid             = 0 and
																								corp_orig_org_structure_cd_invalid  = 0 and
																								corp_for_profit_ind_invalid 			  = 0 and
																								corp_ln_name_type_cd_invalid        = 0 and
																								corp_ra_resign_date_invalid         = 0 and
																								corp_name_status_date_invalid       = 0 and
																								corp_orig_bus_type_cd_invalid       = 0 and
																								corp_term_exist_cd_invalid          = 0 and
																								corp_ln_name_type_desc_invalid      = 0 and
																								corp_forgn_state_desc_invalid       = 0 and
																							  corp_tax_program_cd_invalid         = 0 );																										 																	
		
		Main_FailBuild	:= map(corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_CA_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),					 count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_CA_Main.Threshold_Percent.CORP_LEGAL_NAME 					=> true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),						     count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_CA_Main.Threshold_Percent.CORP_KEY      						=> true,
													 count(Main_GoodRecords) = 0																																																																																				          => true,
													 false );

		Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
	
		Main_RejFile_Exists		:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);			
	  Main_ALL		 					:= sequential(IF(count(Main_BadRecords) <> 0
																					,IF (poverwrite
																							,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_CA',overwrite,__compressed__,named('Sample_Rejected_MainRecs_CA'+filedate))
																							,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																													 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_CA'+filedate)))))
																		,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainCAScrubsReportWithExamples'+filedate))																		
																		//Send Alerts if Scrubs exceeds thresholds
																		,IF(COUNT(Main_ScrubsAlert) > 0, Main_SendEmailFile, OUTPUT('CORP2_MAPPING.CA - No "MAIN" Corp Scrubs Alerts'))
																		,Main_ErrorSummary
																		,Main_ScrubErrorReport
																		,Main_SomeErrorValues
																		,Main_SubmitStats);
																		
	//--------------------------------------------------------------------	
  // Scrubs for Event
  //--------------------------------------------------------------------
		Event_F := MapEvent;
		Event_S := Scrubs_Corp2_Mapping_CA_Event.Scrubs;        // CA scrubs module
		Event_N := Event_S.FromNone(Event_F); 									// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     	// Use the FromBits module; mCAes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile);// Pass the expanded error flags into the Expanded module

	//Outputs reports
		Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_CA'+filedate));
		Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_CA'+filedate));
		Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_CA'+filedate));
		Event_IsScrubErrors		 		:= IF(count(Event_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Event_OrbitStats						:= Event_U.OrbitStats();
		
		//Outputs files
		Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_CA_Event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap			:= output(Event_T);
	  
		//Submits Profile's stats to Orbit
		Event_SubmitStats 				:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_CA_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_CA_Event').SubmitStats;
		
	  Event_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_CA_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_CA_Event').CompareToProfile_with_Examples;
		
		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpEvent_CA Report' //subject
																																	 ,'Scrubs CorpEvent_CA Report' //body
																																	 ,(data)Event_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpCAEventScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																																 );		
																																 
		Event_BadRecords := Event_T.ExpandedInFile(	corp_key_invalid  		         <> 0 or
																								corp_sos_charter_nbr_invalid   <> 0 or
																								event_filing_cd_invalid 		   <> 0 );	

		Event_GoodRecords	:= Event_T.ExpandedInFile(corp_key_invalid  		         = 0 and
																								corp_sos_charter_nbr_invalid   = 0 and
																								event_filing_cd_invalid		     = 0 );																					 																	
		
		Event_FailBuild	:= if(count(Event_GoodRecords) = 0,true,false);

		Event_ApprovedRecords := project(Event_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Events,self := left));		
		
		Event_RejFile_Exists			:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_' + state_origin),true,false);			
	  Event_ALL									:= sequential(IF(count(Event_BadRecords)<> 0
																						 ,if(poverwrite
																								,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_CA',overwrite,__compressed__,named('Sample_Rejected_Event_Recs_CA'+filedate))
																								,sequential (IF(Event_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin)),
																														 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin,__compressed__,named('Sample_Rejected_Event_Recs_CA'+filedate)))))
																					 ,output(Event_ScrubsWithExamples, ALL, NAMED('CorpEventCAScrubsReportWithExamples'+filedate))
																					 //Send Alerts if Scrubs exceeds thresholds
																					 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_SendEmailFile, OUTPUT('CORP2_MAPPING.CA - No "EVENT" Corp Scrubs Alerts'))
																					 ,Event_ErrorSummary
																					 ,Event_ScrubErrorReport
																					 ,Event_SomeErrorValues
																					 ,Event_SubmitStats);
																				 
	
 //-------------------- Version Control -----------------------------------------------------//	
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::main_ca'			,Main_ApprovedRecords ,main_out		     ,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_ca'			,MapStock	            ,stock_out	     ,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_ca'			,Event_ApprovedRecords,event_out	     ,,,pOverwrite);
		
	VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::main_ca'	,MapMain              ,write_fail_main ,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::event_ca'	,MapEvent	            ,write_fail_event,,,pOverwrite);
		
	mapCA:= sequential(   if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
											  // ,Corp2_Raw_CA.Build_Bases(filedate,version,pUseProd).All  // Determined building of bases is not needed
												,main_out
												,event_out
												,stock_out										
												,IF(Main_FailBuild <> true or Event_FailBuild <> true
														,sequential( fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::event',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_CA')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_CA')																		 
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::stock',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_CA')
																				,if (count(Main_BadRecords) <> 0 or  count(Event_BadRecords) <> 0 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,,count(Main_BadRecords),,count(Event_BadRecords),,count(Main_ApprovedRecords),,count(Event_ApprovedRecords),count(mapStock)).RecordsRejected																				 
																						 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,count(Event_BadRecords)<>0,,count(Main_BadRecords),,count(Event_BadRecords),,count(Main_ApprovedRecords),,count(Event_ApprovedRecords),count(mapStock)).MappingSuccess																				 
																						 )	 
																			)
														 ,sequential( write_fail_main//if it fails on  main file threshold ,still writing mapped files!
																				 ,write_fail_event
																				 ,Corp2_Mapping.Send_Email(state_origin ,version).MappingFailed
																				)
													)
												,if (Main_IsScrubErrors or Event_IsScrubErrors
														 ,Corp2_Mapping.Send_Email(state_origin ,version,Main_IsScrubErrors,false,Event_IsScrubErrors).FieldsInvalidPerScrubs)
												,Event_All
												,Main_All	
										);
															
 		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-31) and ut.date_math(filedate,31),true,false);
		return sequential (if (isFileDateValid
														,mapCA
														,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('Corp2_Mapping.CA failed.  An invalid filedate was passed in as a parameter.')))); 	

	end;	// end of Update function

end;  // end of Module