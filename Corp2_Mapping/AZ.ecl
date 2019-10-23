import  tools, ut, std, versioncontrol, Corp2, Corp2_Raw_AZ, Scrubs_Corp2_Mapping_AZ_Main, Scrubs_Corp2_Mapping_AZ_Event, Scrubs;

Export AZ := MODULE; 
 
 Export Update(String fileDate, String version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) := function
 
  state_origin		 := 'AZ' ;
  state_fips	 		 := '04';
  state_desc	 		 := 'ARIZONA';
 
	// Vendor Input Files	 - Distribute on id field then sort and dedup on the whole record
	CorExt := dedup(sort(distribute(Corp2_Raw_AZ.Files(filedate,pUseProd).Input.COREXT.logical,hash(file_number)),record,local), record,local) : independent;		
	ChgExt := dedup(sort(distribute(Corp2_Raw_AZ.Files(filedate,pUseProd).Input.CHGEXT.logical,hash(file_number)),record,local), record,local) : independent;	
	FlmExt := dedup(sort(distribute(Corp2_Raw_AZ.Files(filedate,pUseProd).Input.FLMEXT.logical,hash(file_number)),record,local), record,local) : independent;	
	OffExt := dedup(sort(distribute(Corp2_Raw_AZ.Files(filedate,pUseProd).Input.OFFEXT.logical,hash(officer_file_number)),record,local), record,local) : independent;	
	
  //------------------	
	//Begin Corp Mapping
	//------------------
	
	// Normalize on the two RA Addresses:  STATUTORY_AGENT_ADDRESS & SECOND_ADDRESS											 
	Corp2_Raw_AZ.Layouts.normLayout normTrf(Corp2_Raw_AZ.Layouts.COREXT_LayoutIn l, unsigned1 cnt) := transform
	      ,skip (cnt=2 and l.Second_Address_Line1 + l.Second_Address_Line2 + l.Second_Address_Line3 + 
												 l.Second_Address_city + l.Second_Address_state + l.Second_Address_zip_code = '')
		self.Norm_Street1 := choose(cnt ,Corp2_Raw_AZ.Functions.FixStreet(l.Statutory_Agent_Address_Line_1)  ,Corp2_Raw_AZ.Functions.FixStreet(l.Second_Address_Line1));  
		self.Norm_Street2 := choose(cnt ,Corp2_Raw_AZ.Functions.FixStreet(l.Statutory_Agent_Address_Line_2) + ' ' + Corp2_Raw_AZ.Functions.FixStreet(l.Statutory_Agent_Address_Line_3)
															      ,Corp2_Raw_AZ.Functions.FixStreet(l.Second_Address_Line2)           + ' ' + Corp2_Raw_AZ.Functions.FixStreet(l.Second_Address_Line3));  															 
   	self.Norm_City	 := choose(cnt ,l.Statutory_Agent_Address_city     ,l.Second_Address_city);
		self.Norm_State  := choose(cnt ,l.Statutory_Agent_Address_state    ,l.Second_Address_state);
		self.Norm_Zip    := choose(cnt ,l.Statutory_Agent_Address_zip_code ,l.Second_Address_zip_code);
		self.Norm_Type   := choose(cnt ,'STAT' ,'SEC'); 
		self			       := l;
	end;
	normCOREXT	:= normalize(COREXT, 2, normTrf(left, counter));		
		

 	 //COREXT Transform
	 corp2_Mapping.LayoutsCommon.Main CorextTrf(Corp2_Raw_AZ.Layouts.normLayout  input):=transform
	    self.dt_first_seen					   := (integer)fileDate;
			self.dt_last_seen					     := (integer)fileDate;
			self.dt_vendor_first_reported	 := (integer)fileDate;
			self.dt_vendor_last_reported	 := (integer)fileDate;
			self.corp_ra_dt_first_seen		 := (integer)fileDate;
			self.corp_ra_dt_last_seen			 := (integer)fileDate;
			self.corp_key					         := state_fips + '-' + corp2.t2u(input.FILE_NUMBER);
			self.corp_vendor					     := state_fips;
		  self.corp_state_origin         := state_origin;
			self.corp_process_date				 := fileDate;    
			self.corp_orig_sos_charter_nbr := corp2.t2u(input.FILE_NUMBER);
			self.corp_inc_state            := state_origin;
			self.corp_legal_name           := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.CORPORATION_NAME).BusinessName;	
			self.corp_ln_name_type_cd      := '01';
			self.corp_ln_name_type_desc    := 'LEGAL';
			self.corp_inc_county           := corp2.t2u(input.COUNTY);
			self.corp_for_profit_ind       := map(corp2.t2u(input.CORPORATION_TYPE_CODE)='N' => 'N',
			                                      corp2.t2u(input.CORPORATION_TYPE_CODE)='P' => 'Y',
																			  		'');

      // Revocation_comment1 and Revocation_comment2 are now being mapped in the Event records, but those are
			// new fields in the layout, so retaining them in corp_addl_info until the new fields are customer-facing
		  concatFields := corp2.t2u(input.COMMENTS)+';'+ corp2.t2u(input.REVOCATION_COMMENT1)+';'+ corp2.t2u(input.REVOCATION_COMMENT2);
			Comments     := regexreplace('[;]+',regexreplace('^[;]*',regexreplace('[;]*$',concatFields,'',NOCASE),'',NOCASE),';',NOCASE);
			FiscalMo     := if(Corp2_Raw_AZ.Functions.GetMonth(input.FISCAL_MONTH) <> '' ,'FISCAL MONTH: ' + Corp2_Raw_AZ.Functions.GetMonth(input.FISCAL_MONTH) ,'');
			self.corp_addl_info            := map(Comments <> '' and FiscalMo <> '' => Comments + '; ' + FiscalMo,
			                                      Comments <> '' and FiscalMo =  '' => Comments,
																						Comments =  '' and FiscalMo <> '' => FiscalMo,
																						'');
	    self.corp_organizational_comments := corp2.t2u(input.COMMENTS);
			self.corp_foreign_domestic_ind := if(corp2.t2u(input.DOMICILE_STATE) in ['',state_origin],'D','F');
		  self.corp_status_cd            := Corp2_Raw_AZ.Functions.GetStatusCode(input.STATUS_CODE);
			self.corp_status_desc          := Corp2_Raw_AZ.Functions.GetStatusDesc(self.corp_status_cd );
		  self.corp_status_date          := Corp2_Mapping.fValidateDate(input.STATUS_DATE,'CCYYMMDD').PastDate;
			self.corp_term_exist_cd        := map(corp2.t2u(input.CORPORATION_LIFE) = 'PP'                       => 'P',
			                                     	Corp2_Mapping.fValidateDate(input.EXPIRATION_DATE,'CCYYMMDD').GeneralDate <> '' => 'D',
																						'');
			self.corp_term_exist_desc      := map(self.corp_term_exist_cd = 'P' => 'PERPETUAL',
			                                      self.corp_term_exist_cd = 'D' => 'EXPIRATION DATE',
																						'');
			self.corp_term_exist_exp       := if(self.corp_term_exist_cd = 'D', Corp2_Mapping.fValidateDate(input.EXPIRATION_DATE,'CCYYMMDD').GeneralDate, '');																			
      self.corp_renewal_date         := Corp2_Mapping.fValidateDate(input.RENEWAL_DATE,'CCYYMMDD').GeneralDate;
			self.corp_inc_date             := if(corp2.t2u(input.DOMICILE_STATE) in [state_origin,''],Corp2_Mapping.fValidateDate(input.DATE_OF_INCORPORATION,'CCYYMMDD').PastDate ,'');
   		self.corp_forgn_date           := if(corp2.t2u(input.DOMICILE_STATE) not in [state_origin,''],Corp2_Mapping.fValidateDate(input.DATE_OF_INCORPORATION,'CCYYMMDD').PastDate ,'');
      self.corp_merger_date          := Corp2_Mapping.fValidateDate(input.MERGER_DATE,'CCYYMMDD').PastDate;		
      
			self.corp_ra_effective_date    := if(corp2.t2u(input.Stat_Agent_Appointment_Resign_Code) ='A' 
																						,Corp2_Mapping.fValidateDate(input.Stat_Agent_Appointment_Resign_Date,'CCYYMMDD').PastDate ,'');			
			self.corp_ra_resign_date       := if(corp2.t2u(input.Stat_Agent_Appointment_Resign_Code) ='R' 
																					  ,Corp2_Mapping.fValidateDate(input.Stat_Agent_Appointment_Resign_Date,'CCYYMMDD').PastDate ,''); 										  
			self.corp_ra_full_name         := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.STATUTORY_AGENT_NAME).BusinessName; 
			self.corp_forgn_state_cd       := if(corp2.t2u(input.DOMICILE_STATE) not in [state_origin,''] ,corp2.t2u(input.DOMICILE_STATE) ,'');
			self.corp_forgn_state_desc     := Corp2_Raw_AZ.Functions.GetStateDesc(self.corp_forgn_state_cd);
			self.corp_orig_org_structure_cd := corp2.t2u(input.CORPORATION_TYPE_CODE);
			self.corp_orig_org_structure_desc := Corp2_Raw_AZ.Functions.GetOrgStrucDesc(self.corp_orig_org_structure_cd);
			
			self.corp_address1_type_cd     := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,Corp2_Raw_AZ.Functions.FixStreet(input.FIRST_ADDRESS_LINE1),Corp2_Raw_AZ.Functions.FixStreet(input.FIRST_ADDRESS_LINE2) + ' ' + Corp2_Raw_AZ.Functions.FixStreet(input.FIRST_ADDRESS_LINE3),input.FIRST_ADDRESS_CITY,input.FIRST_ADDRESS_STATE,input.FIRST_ADDRESS_ZIP_CODE).ifAddressExists,'B','');	
			self.corp_address1_type_desc   := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,Corp2_Raw_AZ.Functions.FixStreet(input.FIRST_ADDRESS_LINE1),Corp2_Raw_AZ.Functions.FixStreet(input.FIRST_ADDRESS_LINE2) + ' ' + Corp2_Raw_AZ.Functions.FixStreet(input.FIRST_ADDRESS_LINE3),input.FIRST_ADDRESS_CITY,input.FIRST_ADDRESS_STATE,input.FIRST_ADDRESS_ZIP_CODE).ifAddressExists,'BUSINESS','');
			self.corp_address1_line1			 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,Corp2_Raw_AZ.Functions.FixStreet(input.FIRST_ADDRESS_LINE1),Corp2_Raw_AZ.Functions.FixStreet(input.FIRST_ADDRESS_LINE2) + ' ' + Corp2_Raw_AZ.Functions.FixStreet(input.FIRST_ADDRESS_LINE3),input.FIRST_ADDRESS_CITY,input.FIRST_ADDRESS_STATE,input.FIRST_ADDRESS_ZIP_CODE).AddressLine1;
			self.corp_address1_line2			 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,Corp2_Raw_AZ.Functions.FixStreet(input.FIRST_ADDRESS_LINE1),Corp2_Raw_AZ.Functions.FixStreet(input.FIRST_ADDRESS_LINE2) + ' ' + Corp2_Raw_AZ.Functions.FixStreet(input.FIRST_ADDRESS_LINE3),input.FIRST_ADDRESS_CITY,input.FIRST_ADDRESS_STATE,input.FIRST_ADDRESS_ZIP_CODE).AddressLine2;
			self.corp_address1_line3			 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,Corp2_Raw_AZ.Functions.FixStreet(input.FIRST_ADDRESS_LINE1),Corp2_Raw_AZ.Functions.FixStreet(input.FIRST_ADDRESS_LINE2) + ' ' + Corp2_Raw_AZ.Functions.FixStreet(input.FIRST_ADDRESS_LINE3),input.FIRST_ADDRESS_CITY,input.FIRST_ADDRESS_STATE,input.FIRST_ADDRESS_ZIP_CODE).AddressLine3;			
			self.corp_prep_addr1_line1		 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,Corp2_Raw_AZ.Functions.FixStreet(input.FIRST_ADDRESS_LINE1),Corp2_Raw_AZ.Functions.FixStreet(input.FIRST_ADDRESS_LINE2) + ' ' + Corp2_Raw_AZ.Functions.FixStreet(input.FIRST_ADDRESS_LINE3),input.FIRST_ADDRESS_CITY,input.FIRST_ADDRESS_STATE,input.FIRST_ADDRESS_ZIP_CODE).PrepAddrLine1;			
			self.corp_prep_addr1_last_line := Corp2_Mapping.fCleanAddress(state_origin,state_desc,Corp2_Raw_AZ.Functions.FixStreet(input.FIRST_ADDRESS_LINE1),Corp2_Raw_AZ.Functions.FixStreet(input.FIRST_ADDRESS_LINE2) + ' ' + Corp2_Raw_AZ.Functions.FixStreet(input.FIRST_ADDRESS_LINE3),input.FIRST_ADDRESS_CITY,input.FIRST_ADDRESS_STATE,input.FIRST_ADDRESS_ZIP_CODE).PrepAddrLastLine;
	
	    RA_AddrExists                  := Corp2_Mapping.fAddressExists(state_origin,state_desc,input.Norm_Street1,input.Norm_Street2,input.Norm_City,input.Norm_State,input.Norm_Zip).ifAddressExists; 
			self.corp_ra_address_type_cd	 := if(RA_AddrExists ,map(input.Norm_type = 'STAT' =>'R', input.Norm_type = 'SEC' =>'M', '') ,'');
			self.corp_ra_address_type_desc := if(RA_AddrExists ,map(input.Norm_type = 'STAT' =>'REGISTERED OFFICE', input.Norm_type = 'SEC' =>'AGENT MAILING ADDRESS',	'')	,'');
			self.corp_ra_address_line1		 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Norm_Street1,input.Norm_Street2,input.Norm_City,input.Norm_State,input.Norm_Zip).AddressLine1;
			self.corp_ra_address_line2		 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Norm_Street1,input.Norm_Street2,input.Norm_City,input.Norm_State,input.Norm_Zip).AddressLine2;
			self.corp_ra_address_line3		 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Norm_Street1,input.Norm_Street2,input.Norm_City,input.Norm_State,input.Norm_Zip).AddressLine3;			
			self.RA_prep_addr_line1				 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Norm_Street1,input.Norm_Street2,input.Norm_City,input.Norm_State,input.Norm_Zip).PrepAddrLine1;			
			self.RA_prep_addr_last_line	   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Norm_Street1,input.Norm_Street2,input.Norm_City,input.Norm_State,input.Norm_Zip).PrepAddrLastLine;

			self.recordOrigin              := 'C';
			self                           := [];
  end;  
 
  MapCOREXT := project(normCOREXT, CorextTrf(left)) ;
	
  //CHGEXT Transform
		jCHGEXT	:= join(CHGEXT, normCOREXT, 
										corp2.t2u(left.FILE_NUMBER) = corp2.t2u(right.FILE_NUMBER),
										transform(Corp2_Raw_AZ.Layouts.CHGEXT_TempLay, 
															 self.DOMICILE_STATE          := right.DOMICILE_STATE;
															 self.DATE_OF_INCORPORATION 	:= right.DATE_OF_INCORPORATION;
															 self := left; self := right; self := [];),
										left outer,local) : independent;
											
     corp2_Mapping.LayoutsCommon.Main ChgextTrf(Corp2_Raw_AZ.Layouts.CHGEXT_TempLay  input):=transform 
			self.dt_first_seen					   := (integer)fileDate;
			self.dt_last_seen					     := (integer)fileDate;
			self.dt_vendor_first_reported	 := (integer)fileDate;
			self.dt_vendor_last_reported	 := (integer)fileDate;
			self.corp_ra_dt_first_seen		 := (integer)fileDate;
			self.corp_ra_dt_last_seen			 := (integer)fileDate;
			self.corp_key					         := state_fips + '-' + corp2.t2u(input.FILE_NUMBER);
			self.corp_vendor					     := state_fips;
		  self.corp_state_origin         := state_origin;
			self.corp_process_date				 := fileDate;    
			self.corp_orig_sos_charter_nbr := corp2.t2u(input.FILE_NUMBER);
			self.corp_inc_state            := state_origin;    
			self.corp_legal_name           := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.CHANGE_MERGE_FROM_NAME).BusinessName;
			self.corp_ln_name_type_cd      := map(corp2.t2u(input.CHANGE_MERGE_CODE) in ['C','N','O','V'] => 'P',
																						corp2.t2u(input.CHANGE_MERGE_CODE) in ['M','X']         => 'NS',
																						corp2.t2u(input.CHANGE_MERGE_CODE) in ['D']             => 'I',
			  																		corp2.t2u(input.CHANGE_MERGE_CODE));
			self.corp_ln_name_type_desc    := map(corp2.t2u(input.CHANGE_MERGE_CODE) in ['C','N','O','V'] => 'PRIOR',
																						corp2.t2u(input.CHANGE_MERGE_CODE) in ['M','X']         => 'NON-SURVIVOR',
																						corp2.t2u(input.CHANGE_MERGE_CODE) in ['D']         		=> 'OTHER',
			  																		'');   
  		self.corp_filing_date          := Corp2_Mapping.fValidateDate(input.CHANGE_MERGE_DATE,'CCYYMMDD').PastDate; // retained from old mapper
		  self.corp_inc_date             := if(corp2.t2u(input.DOMICILE_STATE) in [state_origin,''],Corp2_Mapping.fValidateDate(input.DATE_OF_INCORPORATION,'CCYYMMDD').PastDate ,'');
   		self.corp_forgn_date           := if(corp2.t2u(input.DOMICILE_STATE) not in [state_origin,''],Corp2_Mapping.fValidateDate(input.DATE_OF_INCORPORATION,'CCYYMMDD').PastDate ,'');
			self.recordOrigin              := 'C';
			self                           := [];
	 end; 
	 
	 MapCHGEXT := project(jCHGEXT , ChgextTrf(left)) ;
	
	 MapCorp := MapCOREXT + MapCHGEXT;
	  
  //End Corp Mapping


	//---------------------	
	//Begin Contact Mapping
	//---------------------
		
		// Join the COREXT and OFFEXT files
		joinCorextOffext 	:= join(COREXT, OFFEXT,
												 corp2.t2u(left.FILE_NUMBER) = corp2.t2u(right.Officer_FILE_NUMBER),											
												 transform(Corp2_Raw_AZ.Layouts.COREXT_OFFEXT,
												 self := left;	self := right; self := [];),
												 left outer, local) ;
		
	 // Denormalize above result to get all titles in one record  
   sortOffFile		:= sort(joinCorextOffext,Officer_File_Number,Officer_Name,Officer_Address_Line1,Officer_Address_Line2,Officer_Address_Line3,Officer_Address_State,Officer_Addr_Zip);
   distofficers 	:= distribute(sortOffFile,hash(Officer_File_Number,Officer_Name,Officer_Address_Line1,Officer_Address_Line2,Officer_Address_Line3,Officer_Address_State,Officer_Addr_Zip));
	 
	 Corp2_Raw_AZ.Layouts.FinalOfficerFile	newTransform(joinCorextOffext l) := transform
			self			:=l;
			self			:=[];
		end;
		
		newOfficerFile		  := project(distOfficers, newTransform(left));
		dedupNewOfficerFile := dedup(newOfficerFile,Officer_File_Number,Officer_Name,Title_Code, all);
		
		Corp2_Raw_AZ.Layouts.FinalOfficerFile DenormOfficers(Corp2_Raw_AZ.Layouts.FinalOfficerFile L, Corp2_Raw_AZ.Layouts.FinalOfficerFile R, INTEGER C) := TRANSFORM
			self.Title1 	:= if(C=1, R.Title_Code, L.TITLE1);                  
			self.title2		:= if(C=2, R.Title_Code, L.TITLE2);
			self.title3		:= if(C=3, R.Title_Code, L.TITLE3); 
			self.title4		:= if(C=4, R.Title_Code, L.TITLE4); 
			self.title5		:= if(C=5, R.Title_Code, L.TITLE5); 	
			self 			    := L;	
		END;
		
		DenormalizedFile := denormalize(dedupNewOfficerFile, dedupNewOfficerFile,
		                 	corp2.t2u(left.Officer_File_Number) = corp2.t2u(right.Officer_File_Number) and
											corp2.t2u(left.Officer_Name) = corp2.t2u(right.Officer_Name) and
											corp2.t2u(left.Officer_Address_Line1) = corp2.t2u(right.Officer_Address_Line1) and
											corp2.t2u(left.Officer_Address_Line2) = corp2.t2u(right.Officer_Address_Line2) and
									    corp2.t2u(left.Officer_Address_Line3) = corp2.t2u(right.Officer_Address_Line3) and
											corp2.t2u(left.Officer_Address_State) = corp2.t2u(right.Officer_Address_State) and
											corp2.t2u(left.Officer_Addr_Zip) = corp2.t2u(right.Officer_Addr_Zip) ,
											DenormOfficers(left,right,COUNTER));
											
		DedupDenormalized := dedup(DenormalizedFile, RECORD,all);
		
		corp2_Mapping.LayoutsCommon.Main ContactTrf(Corp2_Raw_AZ.Layouts.FinalOfficerFile  input):=transform
		  self.dt_first_seen					   := (integer)fileDate;
			self.dt_last_seen					     := (integer)fileDate;
			self.dt_vendor_first_reported	 := (integer)fileDate;
			self.dt_vendor_last_reported	 := (integer)fileDate;
			self.corp_ra_dt_first_seen		 := (integer)fileDate;
			self.corp_ra_dt_last_seen			 := (integer)fileDate;
		  self.corp_key					         := state_fips + '-' + corp2.t2u(input.FILE_NUMBER);
			self.corp_vendor				       := state_fips;
			self.corp_state_origin		     := state_origin;
			self.corp_inc_state            := state_origin;
			self.corp_process_date		     := fileDate;
			self.corp_orig_sos_charter_nbr := corp2.t2u(input.FILE_NUMBER);
			self.corp_legal_name           := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.Corporation_Name).BusinessName; 
			self.cont_title1_desc					 := Corp2_Raw_AZ.Functions.GetContTitleDesc(input.Title1);
			self.cont_title2_desc					 := Corp2_Raw_AZ.Functions.GetContTitleDesc(input.Title2);
			self.cont_title3_desc					 := Corp2_Raw_AZ.Functions.GetContTitleDesc(input.Title3);
			self.cont_title4_desc					 := Corp2_Raw_AZ.Functions.GetContTitleDesc(input.Title4);
			self.cont_title5_desc					 := Corp2_Raw_AZ.Functions.GetContTitleDesc(input.Title5);												
      self.cont_full_name            := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.Officer_Name).BusinessName;
			self.cont_type_cd              := 'F';
     	self.cont_type_desc            := 'OFFICER';
			self.cont_address_type_cd      := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,Corp2_Raw_AZ.Functions.FixStreet(input.Officer_Address_Line1),Corp2_Raw_AZ.Functions.FixStreet(input.Officer_Address_Line2) + ' ' + Corp2_Raw_AZ.Functions.FixStreet(input.Officer_Address_Line3),input.Officer_Address_CITY,input.Officer_Address_STATE,input.Officer_Addr_Zip).ifAddressExists,'T','');
			self.cont_address_type_desc    := if (Corp2_Mapping.fAddressExists(state_origin,state_desc,Corp2_Raw_AZ.Functions.FixStreet(input.Officer_Address_Line1),Corp2_Raw_AZ.Functions.FixStreet(input.Officer_Address_Line2) + ' ' + Corp2_Raw_AZ.Functions.FixStreet(input.Officer_Address_Line3),input.Officer_Address_CITY,input.Officer_Address_STATE,input.Officer_Addr_Zip).ifAddressExists,'CONTACT','');
			self.cont_address_line1			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,Corp2_Raw_AZ.Functions.FixStreet(input.Officer_Address_Line1),Corp2_Raw_AZ.Functions.FixStreet(input.Officer_Address_Line2) + ' ' + Corp2_Raw_AZ.Functions.FixStreet(input.Officer_Address_Line3),input.Officer_Address_CITY,input.Officer_Address_STATE,input.Officer_Addr_Zip).AddressLine1;
			self.cont_address_line2			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,Corp2_Raw_AZ.Functions.FixStreet(input.Officer_Address_Line1),Corp2_Raw_AZ.Functions.FixStreet(input.Officer_Address_Line2) + ' ' + Corp2_Raw_AZ.Functions.FixStreet(input.Officer_Address_Line3),input.Officer_Address_CITY,input.Officer_Address_STATE,input.Officer_Addr_Zip).AddressLine2;
			self.cont_address_line3			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,Corp2_Raw_AZ.Functions.FixStreet(input.Officer_Address_Line1),Corp2_Raw_AZ.Functions.FixStreet(input.Officer_Address_Line2) + ' ' + Corp2_Raw_AZ.Functions.FixStreet(input.Officer_Address_Line3),input.Officer_Address_CITY,input.Officer_Address_STATE,input.Officer_Addr_Zip).AddressLine3;
			self.cont_prep_addr_line1			 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,Corp2_Raw_AZ.Functions.FixStreet(input.Officer_Address_Line1),Corp2_Raw_AZ.Functions.FixStreet(input.Officer_Address_Line2) + ' ' + Corp2_Raw_AZ.Functions.FixStreet(input.Officer_Address_Line3),input.Officer_Address_CITY,input.Officer_Address_STATE,input.Officer_Addr_Zip).PrepAddrLine1;
			self.cont_prep_addr_last_line	 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,Corp2_Raw_AZ.Functions.FixStreet(input.Officer_Address_Line1),Corp2_Raw_AZ.Functions.FixStreet(input.Officer_Address_Line2) + ' ' + Corp2_Raw_AZ.Functions.FixStreet(input.Officer_Address_Line3),input.Officer_Address_CITY,input.Officer_Address_STATE,input.Officer_Addr_Zip).PrepAddrLastLine;
			self.recordOrigin              := 'T';
			self                           := [];
		end;  
		
		MapCont 	:= project(DedupDenormalized, ContactTrf(left));
  //End Contact Mapping

		
	//-------------------
	//Begin Event Mapping
	//-------------------
																			 
    //Build Event records from CHGEXT input file		
		corp2_Mapping.LayoutsCommon.Events EventTrfCHG(Corp2_Raw_AZ.Layouts.CHGEXT_LayoutIn input):=transform
		       ,skip(corp2.t2u(input.FILE_NUMBER) = '')
		  self.corp_key					    := state_fips + '-' + corp2.t2u(input.FILE_NUMBER);
			self.corp_vendor				  := state_fips;
			self.corp_state_origin		:= state_origin;
			self.corp_process_date		:= fileDate;
			self.corp_sos_charter_nbr	:= corp2.t2u(input.FILE_NUMBER);
			self.event_filing_date    := Corp2_Mapping.fValidateDate(input.change_merge_date,'CCYYMMDD').PastDate;
			self.event_date_type_cd		:= if(self.event_filing_date <> '',corp2.t2u(input.change_merge_code), '');
			self.event_date_type_desc := if(self.event_date_type_cd <> ''
																		,map(corp2.t2u(input.change_merge_code) = 'C' => 'NAME CHANGE',
																				 corp2.t2u(input.change_merge_code) = 'D' => 'DIVISION',
																				 corp2.t2u(input.change_merge_code) = 'M' => 'MERGER',
																				 corp2.t2u(input.change_merge_code) = 'N' => 'CONSOLIDATION',
																				 corp2.t2u(input.change_merge_code) = 'O' => 'DOMESTICATION',
																				 corp2.t2u(input.change_merge_code) = 'V' => 'CONVERSION',
																				 corp2.t2u(input.change_merge_code) = 'X' => 'MERGED','')
																		,'');
			self                      := [];
		end; 
			
		MapEvent_CHG 	:= project(CHGEXT, EventTrfCHG(left));
	
	  //Build Event records from FLMEXT input file		
		corp2_Mapping.LayoutsCommon.Events EventTrfFLM(Corp2_Raw_AZ.Layouts.FLMEXT_LayoutIn input):=transform
									,skip( StringLib.StringFind(corp2.t2u(input.DOCUMENT_DESCRIPTION),'ANNUAL'   , 1) <> 0  or
												 StringLib.StringFind(corp2.t2u(input.DOCUMENT_DESCRIPTION),'EXTENSION', 1) <> 0  or
												 StringLib.StringFind(corp2.t2u(input.DOCUMENT_DESCRIPTION),'FINANCIAL', 1) <> 0  or
												 StringLib.StringFind(corp2.t2u(input.DOCUMENT_DESCRIPTION),'STOCK', 1)     <> 0 )
			self.corp_key					    				:= state_fips + '-' + corp2.t2u(input.FILE_NUMBER);
			self.corp_vendor				  				:= state_fips;
			self.corp_state_origin						:= state_origin;
			self.corp_process_date						:= fileDate;
			self.corp_sos_charter_nbr					:= corp2.t2u(input.FILE_NUMBER);
			self.event_filing_reference_nbr  	:= corp2.t2u(input.MICROFILM_LOCATION);
			self.event_desc           				:= corp2.t2u(input.DOCUMENT_DESCRIPTION);
			self.event_filing_date    				:= Corp2_Mapping.fValidateDate(input.DATE_DOCUMENT_RECEIVED,'CCYYMMDD').PastDate;
			self.event_date_type_cd						:= 'FIL';
			self.event_date_type_desc 				:= 'FILING';
			self                      				:= [];
		end; 
			
		MapEvent_FLM 	:= project(FLMEXT(corp2.t2u(FILE_NUMBER) <> ''), EventTrfFLM(left));
	 
	 
	// Normalize on the two COREXT Event Filing Dates:  DATE_OF_APPROVAL_OF_ARTICLES_OF_INC & DATE_OF_PUB_OF_ART_OF_INC											 
	Corp2_Raw_AZ.Layouts.normEventLayout normEventTrf(Corp2_Raw_AZ.Layouts.COREXT_LayoutIn l, unsigned1 cnt) := transform
		,skip((cnt = 1 and Corp2_Mapping.fValidateDate(l.DATE_OF_APPROVAL_OF_ARTICLES_OF_INC,'CCYYMMDD').GeneralDate = '') or
	        (cnt = 2 and Corp2_Mapping.fValidateDate(l.DATE_OF_PUB_OF_ART_OF_INC,'CCYYMMDD').GeneralDate = ''))
		self.Norm_Event_Filing_Date := choose(cnt	,Corp2_Mapping.fValidateDate(l.DATE_OF_APPROVAL_OF_ARTICLES_OF_INC,'CCYYMMDD').GeneralDate
																					    ,Corp2_Mapping.fValidateDate(l.DATE_OF_PUB_OF_ART_OF_INC,'CCYYMMDD').GeneralDate);
		self.Norm_Event_Filing_Desc := choose(cnt ,'APPROVAL DATE' ,'PUBLICATION OF ARTICLES');
		self			                  := l;
	end;
	
	normEvent	:= normalize(COREXT, 2, normEventTrf(left, counter));		 
	 	
		//Build Event records from normalized COREXT input file		
		corp2_Mapping.LayoutsCommon.Events EventTrfCOR(Corp2_Raw_AZ.Layouts.normEventLayout input):=transform
						,skip(corp2.t2u(input.FILE_NUMBER) = '')
		  self.corp_key					    		 := state_fips + '-' + corp2.t2u(input.FILE_NUMBER);
			self.corp_vendor				  		 := state_fips;
			self.corp_state_origin				 := state_origin;
			self.corp_process_date				 := fileDate;
			self.corp_sos_charter_nbr			 := corp2.t2u(input.FILE_NUMBER);
			self.event_revocation_comment1 := corp2.t2u(input.REVOCATION_COMMENT1);
			self.event_revocation_comment2 := corp2.t2u(input.REVOCATION_COMMENT2);
			self.event_filing_date         := input.Norm_Event_Filing_Date;
			self.event_filing_desc		     := input.Norm_Event_Filing_Desc;
			self.event_desc 							 := map(corp2.t2u(input.AMENDMENT_PUBLICATION_EXCEPTION_COD) = 'Y' => 'PUBLISH EXCEPTION: YES',
																					  corp2.t2u(input.AMENDMENT_PUBLICATION_EXCEPTION_COD) = 'N' => 'PUBLISH EXCEPTION: NO',
																						'');	
  		self                           := [];
		end; 
			
	 MapEvent_COR 	:= project(normEvent, EventTrfCOR(left));
	//End of Event Mapping
	
	//----------------
	//Begin AR Mapping
	//----------------
	  corp2_Mapping.LayoutsCommon.AR ARTrf(Corp2_Raw_AZ.Layouts.FLMEXT_LayoutIn input):=transform
								,skip(StringLib.StringFind(corp2.t2u(input.DOCUMENT_DESCRIPTION),'ANNUAL'   , 1) = 0  and
									    StringLib.StringFind(corp2.t2u(input.DOCUMENT_DESCRIPTION),'EXTENSION', 1) = 0  and
										  StringLib.StringFind(corp2.t2u(input.DOCUMENT_DESCRIPTION),'FINANCIAL', 1) = 0  )
			self.corp_key					    := state_fips + '-' + corp2.t2u(input.FILE_NUMBER);
			self.corp_vendor				  := state_fips;
			self.corp_state_origin		:= state_origin;
			self.corp_process_date		:= fileDate;
			self.corp_sos_charter_nbr	:= corp2.t2u(input.FILE_NUMBER);
			self.ar_comment           := if(corp2.t2u(input.MICROFILM_LOCATION) <> '', 'MICROFILM NUMBER: ' + corp2.t2u(input.MICROFILM_LOCATION), '');
		  self.ar_filed_dt          := Corp2_Mapping.fValidateDate(input.DATE_DOCUMENT_RECEIVED,'CCYYMMDD').PastDate;
			self.ar_type              := corp2.t2u(input.DOCUMENT_DESCRIPTION);
			self                      := [] ;
  	end;  
	//End of AR Mapping
	
	
  //-------------------  
	//Begin Stock Mapping
	//-------------------
		corp2_Mapping.LayoutsCommon.Stock stockTrf(Corp2_Raw_AZ.Layouts.FLMEXT_LayoutIn input):=transform
						,skip(StringLib.StringFind(corp2.t2u(input.DOCUMENT_DESCRIPTION),'STOCK', 1) = 0 )
		  self.corp_key					       := state_fips + '-' + corp2.t2u(input.FILE_NUMBER);
			self.corp_vendor				     := state_fips;
			self.corp_state_origin		   := state_origin;
			self.corp_process_date		   := fileDate;
			self.corp_sos_charter_nbr	   := corp2.t2u(input.FILE_NUMBER);
      self.stock_stock_description := corp2.t2u(input.DOCUMENT_DESCRIPTION);	
			self.stock_addl_info         := map(corp2.t2u(input.MICROFILM_LOCATION) <> '' and corp2.t2u(input.DOCUMENT_DESCRIPTION) <> '' => 'MICROFILM NUMBER: ' + corp2.t2u(input.MICROFILM_LOCATION) + '; ' + corp2.t2u(input.DOCUMENT_DESCRIPTION),
																				  corp2.t2u(input.MICROFILM_LOCATION) =  '' and corp2.t2u(input.DOCUMENT_DESCRIPTION) <> '' => corp2.t2u(input.DOCUMENT_DESCRIPTION),
																					corp2.t2u(input.MICROFILM_LOCATION) <> '' and corp2.t2u(input.DOCUMENT_DESCRIPTION) =  '' => 'MICROFILM NUMBER: ' + corp2.t2u(input.MICROFILM_LOCATION),
																					'');
			self.stock_change_date       := Corp2_Mapping.fValidateDate(input.DATE_DOCUMENT_RECEIVED,'CCYYMMDD').PastDate;
			self                         := [];
		end; 
	//End of Stock Mapping 
	
	
	//-----------------------------------------------------------//
	// Build the Final Mapped Files
	//-----------------------------------------------------------//
		MapMain  := dedup(sort(distribute(MapCorp + MapCont,hash(corp_key)), record,local), record,local) : independent;
		MapEvent := dedup(sort(distribute(MapEvent_CHG + MapEvent_FLM + MapEvent_COR,hash(corp_key)), record,local), record,local) : independent;
	  MapAR    := dedup(sort(distribute(project(FLMEXT, ARTrf(left)),hash(corp_key)), record,local), record,local) : independent;
		MapStock := dedup(sort(distribute(project(FLMEXT, stockTrf(left)),hash(corp_key)), record,local), record,local) : independent;
	
	
	//--------------------------------------------------------------------	
  // Scrubs for MAIN
  //--------------------------------------------------------------------
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_AZ_Main.Scrubs;        // Scrubs module
		Main_N := Main_S.FromNone(Main_F); 										// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     	// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_AZ'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_AZ'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_AZ'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_AZ_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);
	
 	  //Submits Profile's stats to Orbit
		Main_SubmitStats 					:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_AZ_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_AZ_Main').SubmitStats;

	  Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_AZ_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_AZ_Main').CompareToProfile_with_Examples;
		
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.AttachedList
																																	 ,'Scrubs CorpMain_AZ Report' //subject
																																	 ,'Scrubs CorpMain_AZ Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpAZMainScrubsReport.csv'
																																	);		
																																 
		Main_BadRecords := Main_T.ExpandedInFile(	dt_vendor_first_reported_invalid 			 <> 0 or
																							dt_vendor_last_reported_invalid 			 <> 0 or
																							dt_first_seen_invalid 							 	 <> 0 or
																							dt_last_seen_invalid 									 <> 0 or
																							corp_ra_dt_first_seen_invalid 				 <> 0 or
																							corp_ra_dt_last_seen_invalid 					 <> 0 or
																							corp_key_invalid 							 				 <> 0 or
																							corp_vendor_invalid 									 <> 0 or
																							corp_state_origin_invalid 						 <> 0 or
																							corp_process_date_invalid 						 <> 0 or
																							corp_orig_sos_charter_nbr_invalid 		 <> 0 or
																							corp_legal_name_invalid 							 <> 0 or
																							corp_ln_name_type_cd_invalid 					 <> 0 or
																							corp_filing_date_invalid               <> 0 or
																							corp_status_cd_invalid                 <> 0 or
																							corp_status_date_invalid               <> 0 or
																							corp_inc_state_invalid 								 <> 0 or
																							corp_inc_date_invalid 								 <> 0 or
																							corp_foreign_domestic_ind_invalid 		 <> 0 or
																							corp_forgn_date_invalid 							 <> 0 or
																							corp_orig_org_structure_cd_invalid     <> 0 or
																							corp_for_profit_ind_invalid 					 <> 0 or
																							corp_ra_effective_date_invalid         <> 0 or
																							corp_ra_resign_date_invalid            <> 0 or
																							corp_merger_date_invalid               <> 0 or
																							corp_forgn_state_desc_invalid          <> 0 or
																							corp_renewal_date_invalid           	 <> 0 );

		Main_GoodRecords	:= Main_T.ExpandedInFile( dt_vendor_first_reported_invalid 			 = 0 and
																								dt_vendor_last_reported_invalid 			 = 0 and
																								dt_first_seen_invalid 							 	 = 0 and
																								dt_last_seen_invalid 									 = 0 and
																								corp_ra_dt_first_seen_invalid 				 = 0 and
																								corp_ra_dt_last_seen_invalid 					 = 0 and
																								corp_key_invalid 							 				 = 0 and
																								corp_vendor_invalid 									 = 0 and
																								corp_state_origin_invalid 						 = 0 and
																								corp_process_date_invalid 						 = 0 and
																								corp_orig_sos_charter_nbr_invalid 		 = 0 and
																								corp_legal_name_invalid 							 = 0 and
																								corp_ln_name_type_cd_invalid 					 = 0 and
																								corp_filing_date_invalid               = 0 and
																								corp_status_cd_invalid                 = 0 and
																								corp_status_date_invalid               = 0 and
																								corp_inc_state_invalid 								 = 0 and
																								corp_inc_date_invalid 								 = 0 and
																								corp_foreign_domestic_ind_invalid 		 = 0 and
																								corp_forgn_date_invalid 							 = 0 and
																								corp_orig_org_structure_cd_invalid     = 0 and
																								corp_for_profit_ind_invalid 					 = 0 and
																								corp_ra_effective_date_invalid         = 0 and
																								corp_ra_resign_date_invalid            = 0 and
																								corp_merger_date_invalid               = 0 and
																								corp_forgn_state_desc_invalid          = 0 and
																								corp_renewal_date_invalid           	 = 0 );																									 																	
		
		Main_FailBuild	:= map(corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_AZ_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),					 count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_AZ_Main.Threshold_Percent.CORP_LEGAL_NAME 					=> true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),						     count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_AZ_Main.Threshold_Percent.CORP_KEY      						=> true,
													 count(Main_GoodRecords) = 0																																																																																				          => true,
													 false );

		Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
	
		Main_RejFile_Exists		:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);			
	  Main_ALL		 					:= sequential(IF(count(Main_BadRecords) <> 0
																					,IF (poverwrite
																							,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_AZ',overwrite,__compressed__,named('Sample_Rejected_MainRecs_AZ'+filedate))
																							,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																													 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_AZ'+filedate)))))
																		,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainAZScrubsReportWithExamples'+filedate))																		
																		//Send Alerts if Scrubs exceeds thresholds
																		,IF(COUNT(Main_ScrubsAlert) > 0, Main_SendEmailFile, OUTPUT('CORP2_MAPPING.AZ - No "MAIN" Corp Scrubs Alerts'))
																		,Main_ErrorSummary
																		,Main_ScrubErrorReport
																		,Main_SomeErrorValues	
																		,Main_SubmitStats);
																		
	//--------------------------------------------------------------------	
  // Scrubs for Event
  //--------------------------------------------------------------------
		Event_F := MapEvent;
		Event_S := Scrubs_Corp2_Mapping_AZ_Event.Scrubs;        // AZ scrubs module
		Event_N := Event_S.FromNone(Event_F); 									// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     	// Use the FromBits module; mAZes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile);// Pass the expanded error flags into the Expanded module

	//Outputs reports
		Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_AZ'+filedate));
		Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_AZ'+filedate));
		Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_AZ'+filedate));
		Event_IsScrubErrors		 		:= IF(count(Event_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Event_OrbitStats						:= Event_U.OrbitStats();
		
		//Outputs files
		Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_AZ_Event_scrubs_bits',overwrite,compressed);	//long term storage
		Event_TranslateBitMap			:= output(Event_T);
 	
    //Submits Profile's stats to Orbit
		Event_SubmitStats 				:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_AZ_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_AZ_Event').SubmitStats;
			
		Event_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_AZ_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_AZ_Event').CompareToProfile_with_Examples;
		
		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpEvent_AZ Report' //subject
																																	 ,'Scrubs CorpEvent_AZ Report' //body
																																	 ,(data)Event_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpAZEventScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																																 );		
																																 
		Event_BadRecords := Event_T.ExpandedInFile(	corp_key_invalid  		         <> 0 or
																								corp_sos_charter_nbr_invalid   <> 0 or
																								event_date_type_cd_invalid 		 <> 0 );	

		Event_GoodRecords	:= Event_T.ExpandedInFile(corp_key_invalid  		         = 0 and
																								corp_sos_charter_nbr_invalid   = 0 and
																								event_date_type_cd_invalid		 = 0 );																					 																	
		
		Event_FailBuild	:= if(count(Event_GoodRecords) = 0,true,false);

		Event_ApprovedRecords := project(Event_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Events,self := left));		
		
		Event_RejFile_Exists			:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_' + state_origin),true,false);			
	  Event_ALL									:= sequential(IF(count(Event_BadRecords)<> 0
																						 ,if(poverwrite
																								,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_AZ',overwrite,__compressed__,named('Sample_Rejected_Event_Recs_AZ'+filedate))
																								,sequential (IF(Event_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin)),
																														 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin,__compressed__,named('Sample_Rejected_Event_Recs_AZ'+filedate)))))
																					 ,output(Event_ScrubsWithExamples, ALL, NAMED('CorpEventAZScrubsReportWithExamples'+filedate))
																					 //Send Alerts if Scrubs exceeds thresholds
																					 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_SendEmailFile, OUTPUT('CORP2_MAPPING.AZ - No "EVENT" Corp Scrubs Alerts'))
																					 ,Event_ErrorSummary
																					 ,Event_ScrubErrorReport
																					 ,Event_SomeErrorValues
																					 ,Event_SubmitStats);
																				 
	
 //-------------------- Version Control -----------------------------------------------------//	
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::main_az'			,Main_ApprovedRecords ,main_out		     ,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_az'			,MapStock	            ,stock_out	     ,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_az'			,Event_ApprovedRecords,event_out	     ,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_az'				,MapAR		            ,ar_out			     ,,,pOverwrite);
	
	VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::main_az'	,MapMain              ,write_fail_main ,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::event_az'	,MapEvent	            ,write_fail_event,,,pOverwrite);
		
	mapAZ:= sequential(   if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
											  // ,Corp2_Raw_AZ.Build_Bases(filedate,version,pUseProd).All  // Determined building of bases is not needed
												,main_out
												,event_out
												,ar_out
												,stock_out										
												,IF(Main_FailBuild <> true or Event_FailBuild <> true
														,sequential( fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::ar'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_AZ')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::event',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_AZ')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_AZ')																		 
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::stock',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_AZ')
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
												,if (Main_IsScrubErrors or Event_IsScrubErrors
														,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,,Event_IsScrubErrors).FieldsInvalidPerScrubs)
  											,Event_All
												,Main_All	
										);
															
 		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-31) and ut.date_math(filedate,31),true,false);
		return sequential (if (isFileDateValid
														,mapAZ
														,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('Corp2_Mapping.AZ failed.  An invalid filedate was passed in as a parameter.')))); 	

 End; //Update Function

End;//End AZ Module