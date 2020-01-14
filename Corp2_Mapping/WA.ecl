import Corp2, Corp2_Raw_WA, Corp2_Mapping, Scrubs_Corp2_Mapping_WA_Main, Scrubs_Corp2_Mapping_WA_AR, Scrubs_Corp2_Mapping_WA_Event, Scrubs, std, ut, _control, versioncontrol, tools,data_services;

export WA := MODULE;  

	export Update(String fileDate, String version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) := function
		
	state_origin	 := 'WA';
	state_fips	 	 := '53';	
	state_desc	 	 := 'WASHINGTON';
  
	// Vendor Input Files
	CorpsIn	   := dedup(sort(distribute(Corp2_Raw_WA.Files(filedate,pUseProd).input.Corporations.logical,     hash(corp2.t2u(UBI))), record,local),record,local) : independent;
  GovPersIn	 := dedup(sort(distribute(Corp2_Raw_WA.Files(filedate,pUseProd).input.GoverningPersons.logical, hash(corp2.t2u(UBI))), record,local),record,local) : independent;
  DocTypesIn := dedup(sort(distribute(Corp2_Raw_WA.Files(filedate,pUseProd).input.DocumentTypes.logical,    hash(corp2.t2u(UBI))), record,local),record,local) : independent;
	BusInfoIn  := dedup(sort(distribute(Corp2_Raw_WA.Files(filedate,pUseProd).input.BusinessInfo.logical,     hash(corp2.t2u(UBI))), record,local),record,local) : independent;
										
	//-----------------------------------------		  
	// Map CORPORATION recs
	//-----------------------------------------
	
	//Join the Document Types file to the Corporations file to get merger information
	Corporations := join(CorpsIn, DocTypesIn(corp2.t2u(Document) in ['MERGER','MERGER NON-SURVIVOR']),
												corp2.t2u(left.UBI) = corp2.t2u(right.UBI),
												transform(Corp2_Raw_WA.Layouts.TempCorporationsLayout, self := left; self := right;),
												LEFT OUTER, local) : independent;
	
	//Join the Corporations to BusinessInfo to get mailing and physical address information
	 CorpBusInfo := join(Corporations, BusInfoIn,
												corp2.t2u(left.UBI) = corp2.t2u(right.UBI),
												transform(Corp2_Raw_WA.Layouts.TempCorpBusInfoLayout, self := left; self := right;),
												LEFT OUTER, local) : independent;
										
	// Leaving this coding in since the CI says to.  The vendor is supposed to start sending Alternate Addresses soon.
	//Normalize on both RA Addresses
	// Corp2_Raw_WA.Layouts.normCorpLayout normalizeCorps(Corp2_Raw_WA.Layouts.CorpsLayoutIN l, unsigned1 cnt) := transform
					// ,skip(cnt=2 and corp2.t2u(l.AlternateAddress + l.AlternateCity + l.AlternateState + l.AlternateZip) = '')				
				// self.normAddr  := choose(cnt ,l.RegisteredAgentAddress ,l.AlternateAddress );
				// self.normCity	 := choose(cnt ,l.RegisteredAgentCity    ,l.AlternateCity );
				// self.normState := choose(cnt ,l.RegisteredAgentState   ,l.AlternateState);		
				// self.normZip	 := choose(cnt ,l.RegisteredAgentZip     ,l.AlternateZip );
				// self.normCd  	 := choose(cnt ,'R'                      ,'M');
				// self.normDesc	 := choose(cnt ,'REGISTERED OFFICE'      ,'REGISTERED MAILING ADDRESS');
				// self 					 := l;
			// end;

	// NormCorps	:= normalize(CorpsIn, 2, normalizeCorps(left, counter));	
		
	Corp2_Mapping.LayoutsCommon.Main CorpTrf(Corp2_Raw_WA.Layouts.TempCorpBusInfoLayout input):=transform
					,skip(corp2.t2u(input.BusinessName) in ['','UNKNOWN','NOT KNOWN']) // Exclude these per CI
		self.corp_key                     := state_fips + '-' + corp2.t2u(input.UBI);
		self.corp_orig_sos_charter_nbr		:= corp2.t2u(input.UBI);
		self.dt_first_seen							  := (integer)fileDate;
		self.dt_last_seen								  := (integer)fileDate;
		self.dt_vendor_first_reported		  := (integer)fileDate;
		self.dt_vendor_last_reported		  := (integer)fileDate;
		self.corp_ra_dt_first_seen			  := (integer)fileDate;
		self.corp_ra_dt_last_seen				  := (integer)fileDate;	
		self.corp_vendor								  := state_fips;
		self.corp_state_origin					  := state_origin;
		self.corp_inc_state               := state_origin;
		self.corp_process_date					  := fileDate;
		self.corp_legal_name							:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.BusinessName).BusinessName;
		self.corp_ln_name_type_cd					:= map (corp2.t2u(input.Category) = 'RES' => '07',
		                                          corp2.t2u(input.Category) = ''    => 'I',
																							'01');
		self.corp_ln_name_type_desc				:= map (corp2.t2u(input.Category) = 'RES' => 'RESERVATION',
		                                          corp2.t2u(input.Category) = ''    => 'OTHER',
																							'LEGAL');
		self.corp_address1_type_cd	    	:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.MailingAddressLine1,input.MailingAddressLine2 + ' ' + input.MailingAddressLine3,input.MailingCity,input.MailingState,input.MailingZip5+input.MailingZip4,input.MailingCountry).ifAddressExists, 'M', '');
		self.corp_address1_type_desc    	:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.MailingAddressLine1,input.MailingAddressLine2 + ' ' + input.MailingAddressLine3,input.MailingCity,input.MailingState,input.MailingZip5+input.MailingZip4,input.MailingCountry).ifAddressExists, 'MAILING', '');
		self.corp_address1_line1					:= if(self.corp_address1_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.MailingAddressLine1,input.MailingAddressLine2 + ' ' + input.MailingAddressLine3,input.MailingCity,input.MailingState,input.MailingZip5+input.MailingZip4,input.MailingCountry).AddressLine1,'');
		self.corp_address1_line2					:= if(self.corp_address1_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.MailingAddressLine1,input.MailingAddressLine2 + ' ' + input.MailingAddressLine3,input.MailingCity,input.MailingState,input.MailingZip5+input.MailingZip4,input.MailingCountry).AddressLine2,'');
		self.corp_address1_line3					:= if(self.corp_address1_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.MailingAddressLine1,input.MailingAddressLine2 + ' ' + input.MailingAddressLine3,input.MailingCity,input.MailingState,input.MailingZip5+input.MailingZip4,input.MailingCountry).AddressLine3,'');
		self.corp_prep_addr1_line1				:= if(self.corp_address1_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.MailingAddressLine1,input.MailingAddressLine2 + ' ' + input.MailingAddressLine3,input.MailingCity,input.MailingState,input.MailingZip5+input.MailingZip4,input.MailingCountry).PrepAddrLine1,'');
		self.corp_prep_addr1_last_line		:= if(self.corp_address1_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.MailingAddressLine1,input.MailingAddressLine2 + ' ' + input.MailingAddressLine3,input.MailingCity,input.MailingState,input.MailingZip5+input.MailingZip4,input.MailingCountry).PrepAddrLastLine,'');

    self.corp_address2_type_cd	    	:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.PhysicalAddressLine1,input.PhysicalAddressLine2 + ' ' + input.PhysicalAddressLine3,input.PhysicalCity,input.PhysicalState,input.PhysicalZip5+input.PhysicalZip4,input.PhysicalCountry).ifAddressExists, 'B', '');
		self.corp_address2_type_desc    	:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.PhysicalAddressLine1,input.PhysicalAddressLine2 + ' ' + input.PhysicalAddressLine3,input.PhysicalCity,input.PhysicalState,input.PhysicalZip5+input.PhysicalZip4,input.PhysicalCountry).ifAddressExists, 'BUSINESS', '');
		self.corp_address2_line1					:= if(self.corp_address2_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.PhysicalAddressLine1,input.PhysicalAddressLine2 + ' ' + input.PhysicalAddressLine3,input.PhysicalCity,input.PhysicalState,input.PhysicalZip5+input.PhysicalZip4,input.PhysicalCountry).AddressLine1,'');
		self.corp_address2_line2					:= if(self.corp_address2_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.PhysicalAddressLine1,input.PhysicalAddressLine2 + ' ' + input.PhysicalAddressLine3,input.PhysicalCity,input.PhysicalState,input.PhysicalZip5+input.PhysicalZip4,input.PhysicalCountry).AddressLine2,'');
		self.corp_address2_line3					:= if(self.corp_address2_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.PhysicalAddressLine1,input.PhysicalAddressLine2 + ' ' + input.PhysicalAddressLine3,input.PhysicalCity,input.PhysicalState,input.PhysicalZip5+input.PhysicalZip4,input.PhysicalCountry).AddressLine3,'');
		self.corp_prep_addr2_line1				:= if(self.corp_address2_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.PhysicalAddressLine1,input.PhysicalAddressLine2 + ' ' + input.PhysicalAddressLine3,input.PhysicalCity,input.PhysicalState,input.PhysicalZip5+input.PhysicalZip4,input.PhysicalCountry).PrepAddrLine1,'');
		self.corp_prep_addr2_last_line		:= if(self.corp_address2_type_cd <> '',Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.PhysicalAddressLine1,input.PhysicalAddressLine2 + ' ' + input.PhysicalAddressLine3,input.PhysicalCity,input.PhysicalState,input.PhysicalZip5+input.PhysicalZip4,input.PhysicalCountry).PrepAddrLastLine,'');
		self.corp_phone_number            := Corp2_Raw_WA.Functions.PhoneNo(input.PhoneNumber);
		self.corp_email_address           := corp2.t2u(input.Email);
		self.corp_addl_info               := if(corp2.t2u(input.Email) <> '', 'EMAIL: ' + corp2.t2u(input.Email),'');  //mapped here also since corp_email_address is not displayed yet
		
		self.corp_for_profit_ind					:= case(corp2.t2u(input.TYPE),'PROFIT' => 'Y', 'NONPROFIT' => 'N', '');
		self.corp_orig_org_structure_cd		:= corp2.t2u(input.Category);
		self.corp_orig_org_structure_desc	:= Corp2_Raw_WA.Functions.GetOrgStrucDesc(input.Category,input.Type);
		self.corp_orig_bus_type_desc      := corp2.t2u(input.TypeDescription); 
		self.corp_status_desc							:= Corp2_Raw_WA.Functions.GetStatus(input.RecordStatus);
		self.corp_dissolved_date         	:= Corp2_Mapping.fValidateDate(input.DissolutionDate[1..10],'CCYY-MM-DD').PastDate;
		// Corp_dissolved_date is a new field, so leaving corp_status_comment in place
		self.corp_status_comment          := if (self.corp_dissolved_date <> '' 
																						 ,'DISSOLUTION DATE: ' + self.corp_dissolved_date[5..6] +'/'+ self.corp_dissolved_date[7..8] +'/'+ self.corp_dissolved_date[1..4]
																						 ,'');
		
		N_or_P  := map(stringLib.stringFind(corp2.t2u(input.Duration),'YEAR',1) <> 0 and 
									 stringLib.stringFind(corp2.t2u(input.Duration),'-',1) <> 1 and
									 stringlib.stringfilter(corp2.t2u(input.Duration),'0123456789') <> '' => 'N',
									 corp2.t2u(input.Duration) = 'PERPETUAL'                              => 'P',
									 '');
		self.corp_term_exist_cd   				:= N_or_P;
		self.corp_term_exist_desc 				:= case(N_or_P, 'N'=>'NUMBER OF YEARS', 'P'=>'PERPETUAL', '');
		self.corp_term_exist_exp  				:= if (N_or_P = 'N' ,stringlib.stringfilter(corp2.t2u(input.Duration),'0123456789') ,'');
		
		self.corp_inc_date                := if (corp2.t2u(input.StateOfIncorporation) in [state_origin,state_desc,''] 
																						,Corp2_Mapping.fValidateDate(input.DateOfIncorporation[1..10],'CCYY-MM-DD').PastDate ,'');
		self.corp_forgn_date							:= if (corp2.t2u(input.StateOfIncorporation) not in [state_origin,state_desc,''] 
																						,Corp2_Mapping.fValidateDate(input.DateOfIncorporation[1..10],'CCYY-MM-DD').PastDate ,'');
		self.corp_forgn_state_cd          := if (corp2.t2u(input.StateOfIncorporation) not in [state_origin,state_desc,'']
																						,Corp2_Raw_WA.Functions.GetStateCode(input.StateOfIncorporation),'');
	  self.corp_forgn_state_desc        := if (corp2.t2u(input.StateOfIncorporation) not in [state_origin,state_desc,'','OTHER COUNTRY']
																						,Corp2_Raw_WA.Functions.GetStateDesc(input.StateOfIncorporation),'');
		self.corp_foreign_domestic_ind    := if (corp2.t2u(input.StateOfIncorporation) in [state_desc,state_origin,''] ,'D' ,'F');
		self.corp_ra_full_name            :=	Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.RegisteredAgentName).BusinessName;
		self.corp_ra_address_type_cd      := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.RegisteredAgentAddress,'',input.RegisteredAgentCity,input.RegisteredAgentState,input.RegisteredAgentZip).ifAddressExists,'R','');
		self.corp_ra_address_type_desc    := if (self.corp_ra_address_type_cd = 'R' ,'REGISTERED OFFICE','');
		self.corp_ra_address_line1		    := if (self.corp_ra_address_type_cd = 'R' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.RegisteredAgentAddress,'',input.RegisteredAgentCity,input.RegisteredAgentState,input.RegisteredAgentZip).AddressLine1 ,'');
		self.corp_ra_address_line2		    := if (self.corp_ra_address_type_cd = 'R' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.RegisteredAgentAddress,'',input.RegisteredAgentCity,input.RegisteredAgentState,input.RegisteredAgentZip).AddressLine2 ,'');
		self.corp_ra_address_line3		    := if (self.corp_ra_address_type_cd = 'R' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.RegisteredAgentAddress,'',input.RegisteredAgentCity,input.RegisteredAgentState,input.RegisteredAgentZip).AddressLine3 ,'');			
		self.ra_prep_addr_line1					  := if (self.corp_ra_address_type_cd = 'R' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.RegisteredAgentAddress,'',input.RegisteredAgentCity,input.RegisteredAgentState,input.RegisteredAgentZip).PrepAddrLine1 ,'');			
		self.ra_prep_addr_last_line 		  := if (self.corp_ra_address_type_cd = 'R' ,Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.RegisteredAgentAddress,'',input.RegisteredAgentCity,input.RegisteredAgentState,input.RegisteredAgentZip).PrepAddrLastLine ,'');
    self.corp_merger_date             := Corp2_Mapping.fValidateDate(input.CompletedDate[1..10],'CCYY-MM-DD').PastDate;
		self.corp_merger_desc             := corp2.t2u(input.Document);
		self.recordOrigin                 := 'C';		
		self                              := 	[];
	end;  
	
  MapCorp	:= project(CorpBusInfo, CorpTrf(left)) : independent; 

	//-----------------------------------------		  
	// Map CONTACT recs
	//-----------------------------------------
		
	//Keep only Contacts that have an associated Corporation record
	Contacts := join(CorpsIn, GovPersIn,
										corp2.t2u(left.UBI) = corp2.t2u(right.UBI),
										transform(Corp2_Raw_WA.Layouts.TempContactsLayout, self := left; self := right;),
										inner, local) : independent;
		  
	Corp2_Mapping.LayoutsCommon.Main ContTrf(Corp2_Raw_WA.Layouts.TempContactsLayout input):= transform
			      ,skip(corp2.t2u(input.BusinessName) in ['','NOT KNOWN','UNKNOWN']) // Exclude these per CI
		self.corp_key                     := state_fips + '-' + corp2.t2u(input.UBI);		
		self.corp_orig_sos_charter_nbr		:= corp2.t2u(input.UBI);
		self.dt_first_seen							  := (integer)fileDate;
		self.dt_last_seen								  := (integer)fileDate;
		self.dt_vendor_first_reported		  := (integer)fileDate;
		self.dt_vendor_last_reported		  := (integer)fileDate;
		self.corp_ra_dt_first_seen			  := (integer)fileDate;
		self.corp_ra_dt_last_seen				  := (integer)fileDate;	
		self.corp_vendor								  := state_fips;
		self.corp_state_origin					  := state_origin;
		self.corp_inc_state               := state_origin;
		self.corp_process_date					  := fileDate;
		self.corp_legal_name							:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.BusinessName).BusinessName;
		self.cont_type_cd									:= 'T';
		self.cont_type_desc								:= 'CONTACT';  
		self.cont_title1_desc							:= if (corp2.t2u(input.Title) in ['EXECUTOR','GOVERNOR','INCORPORATOR','']
																						,corp2.t2u(input.Title) ,'**|' + corp2.t2u(input.Title));
		
		CleanFirstName  := Corp2_Raw_WA.Functions.CleanFirstName(input.FirstName,input.LastName);
		CleanMiddleName := Corp2_Raw_WA.Functions.CleanMiddleName(input.MiddleName,input.LastName);
		CleanLastName   := Corp2_Raw_WA.Functions.CleanLastName(input.LastName);
		
		self.cont_full_name								:= corp2.t2u(CleanFirstName + ' ' + CleanMiddleName + ' ' + CleanLastName);
  	self.cont_address_type_cd         := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,input.Address,'',input.City,input.State,input.Zip).ifAddressExists,'T','');
		self.cont_address_type_desc       := if (self.cont_address_type_cd = 'T' ,'CONTACT','');
		self.cont_address_line1			      := if (self.cont_address_type_cd = 'T' ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Address,'',input.City,input.State,input.Zip).AddressLine1 ,'');;
		self.cont_address_line2			      := if (self.cont_address_type_cd = 'T' ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Address,'',input.City,input.State,input.Zip).AddressLine2 ,'');;
		self.cont_address_line3			      := if (self.cont_address_type_cd = 'T' ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Address,'',input.City,input.State,input.Zip).AddressLine3 ,'');;
		self.cont_prep_addr_line1			    := if (self.cont_address_type_cd = 'T' ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Address,'',input.City,input.State,input.Zip).PrepAddrLine1 ,'');;
		self.cont_prep_addr_last_line	    := if (self.cont_address_type_cd = 'T' ,Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Address,'',input.City,input.State,input.Zip).PrepAddrLastLine ,'');;
		self.recordOrigin                 := 'T';
		self															:= [];
	end; 	
		
	MapCont	:= project(Contacts, ContTrf(left))(cont_full_name <> '') : independent;	
					 
		
	//-----------------------------------------		  
	// Map AR 
	//-----------------------------------------
	// Keep only records that have valid annual report document types in the Document field and that have an associated Corporation record
	ValidARDocTypes := ['AMENDED ANNUAL REPORT','AMENDED REPORT','ANNUAL REPORT','ANNUAL REPORT-WAIVER GRANTED','ARDQ'];
											
	AR_recs := join(CorpsIn, DocTypesIn(corp2.t2u(Document) in ValidARDocTypes),
										corp2.t2u(left.UBI) = corp2.t2u(right.UBI),
										transform(Corp2_Raw_WA.Layouts.TempARLayout, self := right; self := left;),
										inner, local) : independent;
		
	// First map AR records from the DocTypes info in the joined file 
	Corp2_Mapping.LayoutsCommon.AR ARtrf1(Corp2_Raw_WA.Layouts.TempARLayout input):=transform
				,skip(corp2.t2u(input.BusinessName) in ['','UNKNOWN','NOT KNOWN'] or 
							Corp2_Mapping.fValidateDate(input.CompletedDate[1..10],'CCYY-MM-DD').PastDate = '' or
							corp2.t2u(input.UBI) = '')
		self.corp_key					      			:= state_fips + '-' + corp2.t2u(input.UBI);
		self.corp_vendor				      		:= state_fips;
		self.corp_state_origin						:= state_origin;
		self.corp_process_date						:= fileDate;
		self.corp_sos_charter_nbr					:= corp2.t2u(input.UBI);
	  self.ar_report_dt                 := Corp2_Mapping.fValidateDate(input.CompletedDate[1..10],'CCYY-MM-DD').PastDate;
    self.ar_comment                   := Corp2_Raw_WA.Functions.GetARType(input.Document);
		self															:= [];
  end; 		
	
	mapAR1	 := project(AR_recs, ARtrf1(left));
			
  // Second map AR records from the Corporations info in the joined file
	Corp2_Mapping.LayoutsCommon.AR ARtrf2(Corp2_Raw_WA.Layouts.TempARLayout input):=transform
				,skip(corp2.t2u(input.BusinessName) in ['','UNKNOWN','NOT KNOWN'] or 
							Corp2_Mapping.fValidateDate(input.ExpirationDate[1..10],'CCYY-MM-DD').GeneralDate = '' or
							corp2.t2u(input.UBI) = '')
		self.corp_key					      			:= state_fips + '-' + corp2.t2u(input.UBI);
		self.corp_vendor				      		:= state_fips;
		self.corp_state_origin						:= state_origin;
		self.corp_process_date						:= fileDate;
		self.corp_sos_charter_nbr					:= corp2.t2u(input.UBI);
		self.ar_due_dt                    := Corp2_Mapping.fValidateDate(input.ExpirationDate[1..10],'CCYY-MM-DD').GeneralDate;
		self															:= [];
  end; 		
		
	mapAR2	 := project(AR_recs, ARtrf2(left));	
		
	//-----------------------------------------		  
	// Map Events 
	//-----------------------------------------
	// Keep only Event records (from the Document Type file) that DO NOT have 'ANNUAL REPORT', 'AMENDED REPORT', 'ARDUEDATE', and 'ARDQ'
	// in the Document field and that have an associated Corporation record
	Event_recs := join(CorpsIn, DocTypesIn(not regexfind('(ANNUAL REPORT|AMENDED REPORT|ARDUEDATE|ARDQ)', corp2.t2u(Document))),
										corp2.t2u(left.UBI) = corp2.t2u(right.UBI),
										transform(Corp2_Raw_WA.Layouts.TempEventLayout, self := right; self := left;),
										inner, local) : independent;
										
	Corp2_Mapping.LayoutsCommon.Events Eventtrf(Corp2_Raw_WA.Layouts.TempEventLayout input):=transform
				,skip(corp2.t2u(input.BusinessName) in ['','UNKNOWN','NOT KNOWN'] or 
							Corp2_Mapping.fValidateDate(input.CompletedDate[1..10],'CCYY-MM-DD').PastDate = '' or
							corp2.t2u(input.UBI) = '')
		self.corp_key					      			:= state_fips + '-' + corp2.t2u(input.UBI);
		self.corp_vendor				      		:= state_fips;
		self.corp_state_origin						:= state_origin;
		self.corp_process_date						:= fileDate;
		self.corp_sos_charter_nbr					:= corp2.t2u(input.UBI);
	  self.event_filing_date            := Corp2_Mapping.fValidateDate(input.CompletedDate[1..10],'CCYY-MM-DD').PastDate;
    self.event_desc                   := Corp2_Raw_WA.Functions.GetEventType(input.Document);
		self															:= [];
  end; 
	
	//------------------------------------------------------------------------------//
	// Build the Final Mapped Files
	//------------------------------------------------------------------------------//
	mapMain   := dedup(sort(distribute(mapCorp + mapCont,hash(corp_key)), record,local), record,local) : independent;
	mapAR     := dedup(sort(distribute(mapAR1  + mapAR2 ,hash(corp_key)), record,local), record,local) : independent;
  mapEvents := dedup(sort(distribute(project(Event_recs, Eventtrf(left)),hash(corp_key)), record,local), record,local) : independent;
  
	//********************************************************************
	// SCRUB AR 
	//********************************************************************	
	  AR_F := MapAR;
	  AR_S := Scrubs_Corp2_Mapping_WA_AR.Scrubs;				// Scrubs module
	  AR_N := AR_S.FromNone(AR_F); 											// Generate the error flags
	  AR_T := AR_S.FromBits(AR_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
	  AR_U := AR_S.FromExpanded(AR_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

	//Outputs reports
	  AR_ErrorSummary			 	 := output(AR_U.SummaryStats, named('AR_ErrorSummary_WA'+filedate));
	  AR_ScrubErrorReport 	 := output(choosen(AR_U.AllErrors, 1000), named('AR_ScrubErrorReport_WA'+filedate));
	  AR_SomeErrorValues		 := output(choosen(AR_U.BadValues, 1000), named('AR_SomeErrorValues_WA'+filedate));
	  AR_IsScrubErrors		 	 := IF(count(AR_U.AllErrors)<> 0,true,false);
	// Orbit Stats
		AR_OrbitStats				 	 := AR_U.OrbitStats();

	//Outputs files
		AR_CreateBitMaps			 := output(AR_N.BitmapInfile,,'~thor_data::Corp_WA_AR_scrubs_bits',overwrite,compressed);	//long term storage
		AR_TranslateBitMap		 := output(AR_T);

	//Submits Profile's stats to Orbit
		AR_SubmitStats 			   := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_WA_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_WY_AR').SubmitStats;
		AR_ScrubsWithExamples  := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_WA_AR','ScrubsAlerts', AR_OrbitStats, version,'Corp_WY_AR').CompareToProfile_with_Examples;

		AR_ScrubsAlert				 := AR_ScrubsWithExamples(RejectWarning = 'Y');
		AR_ScrubsAttachment	   := Scrubs.fn_email_attachment(AR_ScrubsAlert);
		AR_MailFile					   := FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																															,'Scrubs CorpAR_WA Report' //subject
																															,'Scrubs CorpAR_WA Report' //body
																															,(data)AR_ScrubsAttachment
																															,'text/csv'
																															,'CorpWYARScrubsReport.csv'
																												);

		AR_BadRecords				 := AR_N.ExpandedInFile(																					
																								corp_key_Invalid							  			<> 0 or
																								corp_vendor_Invalid 									<> 0 or
																								corp_state_origin_Invalid 					 	<> 0 or
																								corp_process_date_Invalid						  <> 0 or
																								corp_sos_charter_nbr_Invalid 					<> 0 or
																								ar_due_dt_Invalid                     <> 0 or
																								ar_report_dt_Invalid                  <> 0 or 
																								ar_comment_Invalid 										<> 0 
																							 );
																									 																	
		AR_GoodRecords				:= AR_N.ExpandedInFile(
																								corp_key_Invalid							  			= 0 and
																								corp_vendor_Invalid 									= 0 and
																								corp_state_origin_Invalid 					 	= 0 and
																								corp_process_date_Invalid						  = 0 and
																								corp_sos_charter_nbr_Invalid 					= 0 and
																								ar_due_dt_Invalid                     = 0 and
																								ar_report_dt_Invalid                  = 0 and 
																								ar_comment_Invalid 										= 0 
																								);

		AR_FailBuild					 := if(count(AR_GoodRecords) = 0,true,false);

		AR_ApprovedRecords		 := project(AR_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.AR,self := left;));

		AR_ALL								 := sequential(IF(count(AR_BadRecords) <> 0
																								 ,IF (poverwrite
																										 ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,overwrite,__compressed__)
																										 ,OUTPUT(AR_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::ar_'+state_origin,__compressed__)
																										 )
																								 )
																						  ,output(AR_ScrubsWithExamples, ALL, NAMED('CorpARWAScrubsReportWithExamples'+filedate))
																							//Send Alerts if Scrubs exceeds thresholds
																							,IF(COUNT(AR_ScrubsAlert) > 0, AR_MailFile, OUTPUT('CORP2_MAPPING.WA - No "AR" Corp Scrubs Alerts'))
																							,AR_ErrorSummary
																							,AR_ScrubErrorReport
																							,AR_SomeErrorValues	
																							,AR_SubmitStats
																					);

  //********************************************************************
  // SCRUB EVENT
  //********************************************************************	
		Event_F := mapEvents;
		Event_S := Scrubs_Corp2_Mapping_WA_Event.Scrubs;						// Scrubs module
		Event_N := Event_S.FromNone(Event_F); 											// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module
		
		//Outputs reports
		Event_ErrorSummary				:= OUTPUT(Event_U.SummaryStats, NAMED('Event_ErrorSummary_WA'+filedate));
		Event_ScrubErrorReport 		:= OUTPUT(CHOOSEN(Event_U.AllErrors, 1000), NAMED('Event_ScrubErrorReport_WA'+filedate));
		Event_SomeErrorValues			:= OUTPUT(CHOOSEN(Event_U.BadValues, 1000), NAMED('Event_SomeErrorValues_WA'+filedate));
		Event_IsScrubErrors		 		:= IF(COUNT(Event_U.AllErrors)<> 0,TRUE,FALSE);

		// Orbit Stats
		Event_OrbitStats					:= Event_U.OrbitStats();
		
		//Outputs files
		Event_CreateBitMaps				:= OUTPUT(Event_N.BitmapInfile,,'~thor_data::corp_wa_event_scrubs_bits',OVERWRITE,COMPRESSED);	//long term storage
		Event_TranslateBitMap			:= OUTPUT(Event_T);

		//Submits Profile's stats to Orbit
		Event_SubmitStats 			 := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_WA_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_WA_Event').SubmitStats;
		Event_ScrubsWithExamples := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_WA_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_WA_Event').CompareToProfile_with_Examples;

		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																																 ,'Scrubs CorpEvent_WA Report' //subject
																																 ,'Scrubs CorpEvent_WA Report' //body
																																 ,(DATA)Event_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpWAEventScrubsReport.csv'
																																 );

		Event_BadRecords				 	:= Event_N.ExpandedInFile(	
																												corp_key_Invalid							  			<> 0 OR
																												corp_vendor_Invalid 									<> 0 OR																						
																												corp_state_origin_Invalid 					 	<> 0 OR
																												corp_process_date_Invalid							<> 0 OR
																												corp_sos_charter_nbr_Invalid 					<> 0 OR
																												event_filing_date_Invalid             <> 0 OR
																												event_desc_Invalid 						        <> 0
																												
																											 );																									 

		Event_GoodRecords					:= Event_N.ExpandedInFile(	
																												corp_key_Invalid							  			= 0 AND
																												corp_vendor_Invalid 									= 0 AND																				
																												corp_state_origin_Invalid 					 	= 0 AND
																												corp_process_date_Invalid						  = 0 AND
																												corp_sos_charter_nbr_Invalid 					= 0 AND
																												event_filing_date_Invalid             = 0 AND
																												event_desc_Invalid							      = 0 
																												
																											);

		Event_FailBuild						:= IF(COUNT(Event_GoodRecords) = 0,TRUE,FALSE);

		Event_ApprovedRecords			:= PROJECT(Event_GoodRecords,TRANSFORM(Corp2_Mapping.LayoutsCommon.Events,SELF := LEFT));
		

		Event_ALL									:= SEQUENTIAL(IF(COUNT(Event_BadRecords) <> 0
																											,IF (poverwrite
																													,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+state_origin,OVERWRITE,__COMPRESSED__)
																													,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+state_origin,__COMPRESSED__)
																													)
																											)
																									 ,OUTPUT(Event_ScrubsWithExamples, ALL, NAMED('CorpEventWAScrubsReportWithExamples'+filedate))
																									 //Send Alerts if Scrubs exceeds thresholds
																									 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_MailFile, OUTPUT('CORP2_MAPPING.WA - No "EVENT" Corp Scrubs Alerts'))
																									 ,Event_ErrorSummary
																									 ,Event_ScrubErrorReport
																									 ,Event_SomeErrorValues			
																									 ,Event_SubmitStats
																								);
	//--------------------------------------------------------------------	
  // Scrubs for MAIN
  //--------------------------------------------------------------------
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_WA_Main.Scrubs;        // WA scrubs module
		Main_N := Main_S.FromNone(Main_F); 										// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     	// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_WA'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_WA'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_WA'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_WA_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

    //Submits Profile's stats to Orbit
    Main_SubmitStats          := Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_WA_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_WA_Main').SubmitStats;

		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_WA_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_WA_Main').CompareToProfile_with_Examples;
		
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.AttachedList
																																	 ,'Scrubs CorpMain_WA Report' //subject
																																	 ,'Scrubs CorpMain_WA Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpWAMainScrubsReport.csv'
																																	);
																															
		Main_BadRecords := Main_T.ExpandedInFile(	dt_vendor_first_reported_invalid 	   <> 0 or
																							dt_vendor_last_reported_invalid 	   <> 0 or
																							dt_first_seen_invalid 			         <> 0 or
																							dt_last_seen_invalid 			           <> 0 or
																							corp_ra_dt_first_seen_invalid 		   <> 0 or
																							corp_ra_dt_last_seen_invalid 			   <> 0 or
																							corp_key_invalid 			               <> 0 or
																							corp_vendor_invalid 			           <> 0 or
																							corp_state_origin_invalid 			     <> 0 or
																							corp_process_date_invalid 			     <> 0 or
																							corp_inc_state_invalid 			         <> 0 or
																							corp_forgn_date_invalid 			       <> 0 or
																							corp_inc_date_invalid 			         <> 0 or
																							corp_dissolved_date_invalid          <> 0 or
																							corp_merger_date_invalid             <> 0 or
																							corp_orig_sos_charter_nbr_invalid    <> 0 or
																							corp_legal_name_invalid 			       <> 0 or
																							corp_foreign_domestic_ind_invalid    <> 0 or
																							corp_for_profit_ind_invalid 			   <> 0 or
																							corp_ln_name_type_cd_invalid 			   <> 0 or
																							corp_ln_name_type_desc_invalid       <> 0 or
																							corp_forgn_state_desc_invalid        <> 0 or
																							corp_orig_org_structure_cd_invalid   <> 0 or
																							corp_orig_org_structure_desc_invalid <> 0 or
																							recordOrigin_invalid                 <> 0 or
																							corp_status_desc_invalid             <> 0 or
																							corp_merger_desc_invalid             <> 0 or
																							cont_title1_desc_invalid             <> 0);

		Main_GoodRecords	:= Main_T.ExpandedInFile( dt_vendor_first_reported_invalid 	   = 0 and
																								dt_vendor_last_reported_invalid 	   = 0 and
																								dt_first_seen_invalid 			         = 0 and
																								dt_last_seen_invalid 			           = 0 and
																								corp_ra_dt_first_seen_invalid 		   = 0 and
																								corp_ra_dt_last_seen_invalid 			   = 0 and
																								corp_key_invalid 			               = 0 and
																								corp_vendor_invalid 			           = 0 and
																								corp_state_origin_invalid 			     = 0 and
																								corp_process_date_invalid 			     = 0 and
																								corp_inc_state_invalid 			         = 0 and
																								corp_forgn_date_invalid 			       = 0 and
																								corp_inc_date_invalid 			         = 0 and
																								corp_dissolved_date_invalid          = 0 and
																								corp_merger_date_invalid             = 0 and
																								corp_orig_sos_charter_nbr_invalid    = 0 and
																								corp_legal_name_invalid 			       = 0 and
																								corp_foreign_domestic_ind_invalid    = 0 and
																								corp_for_profit_ind_invalid 			   = 0 and
																								corp_ln_name_type_cd_invalid 			   = 0 and
																								corp_ln_name_type_desc_invalid       = 0 and
																								corp_forgn_state_desc_invalid        = 0 and
																								corp_orig_org_structure_cd_invalid   = 0 and
																								corp_orig_org_structure_desc_invalid = 0 and
																								recordOrigin_invalid                 = 0 and
																								corp_status_desc_invalid             = 0 and
																								corp_merger_desc_invalid             = 0 and
																								cont_title1_desc_invalid             = 0);																										 																	

		Main_FailBuild	:= map(corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 								 > Scrubs_Corp2_Mapping_WA_Main.Threshold_Percent.CORP_KEY									=> true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_WA_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 					 > Scrubs_Corp2_Mapping_WA_Main.Threshold_Percent.CORP_LEGAL_NAME 					=> true,
													 count(Main_GoodRecords) = 0																																																																																				          => true,										 
													 false );

		Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
		
		Main_ALL	:= sequential( if(count(Main_BadRecords) <> 0
																,if(poverwrite
																		,output(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,overwrite,__compressed__)
																		,output(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,__compressed__)
																		)
																)
														,output(Main_ScrubsWithExamples, all, named('CorpMainWAScrubsReportWithExamples'+filedate))
														//Send Alerts if Scrubs exceeds thresholds
														,if(count(Main_ScrubsAlert) > 0, Main_SendEmailFile, output('CORP2_MAPPING.WA - No "MAIN" Corp Scrubs Alerts'))
														,Main_ErrorSummary
														,Main_ScrubErrorReport
														,Main_SomeErrorValues
														,Main_SubmitStats
												);
							
	
 //-------------------- UPDATE -----------------------------------------------------//	
 
  Fail_Build						:= if(AR_FailBuild = true or Main_FailBuild = true or Event_FailBuild = true,true,false);
	IsScrubErrors					:= if(AR_IsScrubErrors = true or Main_IsScrubErrors = true or Event_IsScrubErrors = true,true,false);
	
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::ar_' 		+ state_origin, AR_ApprovedRecords	 , write_ar,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::main_' 	+ state_origin, Main_ApprovedRecords , write_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::event_' 	+ state_origin, Event_ApprovedRecords, write_event,,,pOverwrite);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::ar_' 		+ state_origin, AR_F		, write_fail_ar,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::main_' 	+ state_origin, Main_F	, write_fail_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::event_' 	+ state_origin, Event_F	, write_fail_event,,,pOverwrite);
		
	mapWA:= sequential(if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
	                   ,AR_All
										 ,Event_All
										 ,Main_All
										 ,IF(Fail_Build <> true
												,sequential(write_ar
																	 ,write_event
														       ,write_main
																	 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::ar'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_WA')
																	 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::event',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_WA')
																	 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_WA')																		 
																	 ,if (count(Main_BadRecords) <> 0 or count(AR_BadRecords) <> 0 or count(Event_BadRecords) <> 0
																			 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,count(Event_BadRecords)<>0,,count(Main_BadRecords),count(AR_BadRecords),count(Event_BadRecords),,count(Main_ApprovedRecords),count(AR_ApprovedRecords),count(Event_ApprovedRecords)).RecordsRejected																				 
																			 ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,count(AR_BadRecords)<>0,count(Event_BadRecords)<>0,,count(Main_BadRecords),count(AR_BadRecords),count(Event_BadRecords),,count(Main_ApprovedRecords),count(AR_ApprovedRecords),count(Event_ApprovedRecords)).MappingSuccess																				 
																			 )	 
																	 ,if(IsScrubErrors
																		  ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,AR_IsScrubErrors,Event_IsScrubErrors).FieldsInvalidPerScrubs
																			)
																	 ) //if Fail_Build <> true																	
														 ,sequential (write_fail_ar
																				 ,write_fail_event												 
																				 ,write_fail_main
																				 ,Corp2_Mapping.Send_Email(state_origin,version).MappingFailed
																				 ) //if Fail_Build = true
														 )
											);

 	isFileDateValid 	:= true;
	isTMFileDateValid := true;
	
	return sequential (if( isFileDateValid and isTMFileDateValid
												,mapWA
												,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																		,FAIL('Corp2_Mapping.WA failed.  An invalid filedate was passed in as a parameter.')))); 	

 End; //Update Function

End;//End WA Module