import ut, std, corp2, _validate, VersionControl, corp2_raw_AL, scrubs, scrubs_corp2_mapping_AL_main, scrubs_corp2_mapping_AL_event, Tools;

export AL := MODULE; 
		
 export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray,boolean pOverwrite = false,boolean pUseProd = Tools._Constants.IsDataland) := function    
		
		state_origin			 := 'AL';
		state_fips	 			 := '01';	
		state_desc	 			 := 'ALABAMA';	 
    
		// Vendor Input Files
	  IncorpIn       := dedup(sort(distribute(Corp2_Raw_AL.Files(filedate,pUseProd).Input.fIncorp    ,hash(CRIACC)),record,local),record,local) : independent;
		OffAddrIn 	   := dedup(sort(distribute(Corp2_Raw_AL.Files(filedate,pUseProd).Input.fOffAddr   ,hash(CROACC)),record,local),record,local) : independent;
    NameIn         := dedup(sort(distribute(Corp2_Raw_AL.Files(filedate,pUseProd).Input.fName      ,hash(CRNACC)),record,local),record,local) : independent;
	  ServiceIn 	   := dedup(sort(distribute(Corp2_Raw_AL.Files(filedate,pUseProd).Input.fService   ,hash(CRSACC)),record,local),record,local) : independent;
	  BusinessIn     := dedup(sort(distribute(Corp2_Raw_AL.Files(filedate,pUseProd).Input.fBusiness  ,hash(CRBACC)),record,local),record,local) : independent;
	  HistoryIn 	   := dedup(sort(distribute(Corp2_Raw_AL.Files(filedate,pUseProd).Input.fHistory   ,hash(CRHACC)),record,local),record,local) : independent;
	  AnnualReportIn := dedup(sort(distribute(Corp2_Raw_AL.Files(filedate,pUseProd).Input.fAR        ,hash(CRAACC)),record,local),record,local) : independent;
 	  CorpMasterIn   := dedup(sort(distribute(Corp2_Raw_AL.Files(filedate,pUseProd).Input.fCorpMaster,hash(CRMACC)),record,local),record,local) : independent;
		 	
		county_list := ['00','01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20',
												 '21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40',
												 '41','42','43','44','45','46','47','48','49','50','51','52','53','54','55','56','57','58','59','60',
												 '61','62','63','64','65','66','67'];
    
		
		//*Note:  Every field of the vendor input files gets corp2.t2u applied in the Corp2_Raw_AL.Files
		//        attribute, so it isn't necessary to apply it to each field within this mapper.
									 
									 
	 //-------------------- CORP Mapping ---------------------------------------------------------------//
  
			//-------------------- CorpMaster file -- CORPORATION Mapping -------------------------------------//
 		
		jCorpMaster_OffAddr := join(CorpMasterIn, OffAddrIn, 
																left.CRMACC = right.CROACC,
																transform(Corp2_Raw_AL.Layouts.CorpMastOffAddr_TempLay, 
																self := left; self := right; self := [];),
																left outer,local) : independent;
				
		Corp2_Mapping.LayoutsCommon.Main corpMainTrf(Corp2_Raw_AL.Layouts.CorpMastOffAddr_TempLay input):= transform
			self.corp_key						          := state_fips + '-' + input.CRMACC;		
			self.corp_vendor					        := state_fips;		
			self.corp_state_origin			      := state_origin;
			self.corp_inc_state				        := state_origin;
			self.dt_vendor_first_reported	    := (integer)fileDate;
			self.dt_vendor_last_reported	    := (integer)fileDate;
			self.dt_first_seen				        := (integer)fileDate;
			self.dt_last_seen				          := (integer)fileDate;
			self.corp_ra_dt_first_seen		    := (integer)fileDate;
			self.corp_ra_dt_last_seen		      := (integer)fileDate;
			self.corp_process_date			      := fileDate;
			self.corp_orig_sos_charter_nbr    := input.CRMACC;
			self.corp_legal_name				      := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,corp2.t2u(input.CRMLN1 + ' ' + input.CRMLN2)).BusinessName;
			self.corp_ln_name_type_cd			    := '01';
			self.corp_ln_name_type_desc		    := 'LEGAL';
			self.corp_orig_org_structure_cd	  := input.CRMTYP;
			self.corp_orig_org_structure_desc	:= Corp2_Raw_AL.functions.Decode_CRMTYP(input.CRMTYP);	
			self.corp_for_profit_ind          := if (input.CRMTYP in ['DNP','DPN','FNP','FPN','DNL'],'N','');		
			self.corp_foreign_domestic_ind    := if (input.CRMPLC in [state_origin,county_list]
																								,'D'
																								,if (input.CRMPLC <> '','F',''));
      
			isForeign   := if (input.CRMPLC in [state_origin,county_list,''] ,'N','Y');
			fixCRMIMO   := if (input.CRMIMO = '00' ,'01' ,input.CRMIMO);
			fixCRMIDY   := if (input.CRMIDY = '00' ,'01' ,input.CRMIDY); 
			self.corp_inc_date                := if (isForeign = 'N' ,Corp2_Mapping.fValidateDate(input.CRMIYR + fixCRMIMO + fixCRMIDY,'CCYYMMDD').PastDate,'');	
		  self.corp_forgn_date              := if (isForeign = 'Y' ,Corp2_Mapping.fValidateDate(input.CRMIYR + fixCRMIMO + fixCRMIDY,'CCYYMMDD').PastDate,'');	
		  self.corp_forgn_state_cd				  := if (isForeign = 'Y', input.CRMPLC, '');	
			self.corp_forgn_state_desc        := Corp2_Raw_AL.functions.GetStateDesc(self.corp_forgn_state_cd);	
			
			cd1 := ['C','D','M','P','R','W'];
			cd2 := ['V','A','J','S'];
		  self.corp_status_cd				        := map(input.CRMDCD in     cd1 and input.CRMDSC in     cd2 => input.CRMDCD + input.CRMDSC,
			                                         input.CRMDCD in     cd1 and input.CRMDSC not in cd2 => input.CRMDCD,
																							 input.CRMDCD not in cd1 and input.CRMDSC in     cd2 => input.CRMDSC,
																							 '');
		  self.corp_status_desc			        := corp2.t2u(if (self.corp_status_cd = ''
			                                      ,'EXISTS'
																						,case(input.CRMDCD,
																									'C' => 'CONSOLIDATED', 
																									'D' => 'DISSOLVED',
																									'M' => 'MERGED',
																									'P' => 'CANCELLED',
																									'R' => 'REVOKED',
																									'W' => 'WITHDRAWN',
																									'') + ' ' +
																							case(input.CRMDSC,
																									'V' => 'VOLUNTARY DISSOLUTION',
																									'A' => 'ADMINISTRATIVE DISSOLUTION',
																									'J' => 'JUDICIAL DISSOLUTION',
																									'S' => 'SIMULTANEOUS WITH SURVIVOR NAME CHANGE',
																									'') ) );
			self.corp_status_comment          := case(input.CRMDSC,'J'=>'JUDICIALLY','A'=>'ADMINISTRATIVELY','V'=>'VOLUNTARILY','');	// Retained from old mapper																															
      self.corp_ra_full_name						:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.CRMANM).BusinessName;
			self.corp_ra_resign_date				  := Corp2_Mapping.fValidateDate(corp2.t2u(input.CRMAYR) + corp2.t2u(input.CRMAMO) + corp2.t2u(input.CRMADY),'CCYYMMDD').PastDate;
			self.corp_status_date             := Corp2_Mapping.fValidateDate(corp2.t2u(input.CRMDYR) + corp2.t2u(input.CRMDMO) + corp2.t2u(input.CRMDDY),'CCYYMMDD').PastDate; // now populated in new field corp_dissolved_date, but retaining here from old mapper
			self.corp_dissolved_date          := Corp2_Mapping.fValidateDate(corp2.t2u(input.CRMDYR) + corp2.t2u(input.CRMDMO) + corp2.t2u(input.CRMDDY),'CCYYMMDD').PastDate;	
			self.corp_orig_bus_type_desc	    := REGEXREPLACE('NOT PROVIDED',StringLib.StringFilterOut(input.CRMBUS, '-'),'');
			self.corp_filing_date				      := Corp2_Mapping.fValidateDate(input.CRMFYR + input.CRMFMO + input.CRMFDY,'CCYYMMDD').PastDate;	
			self.corp_filing_cd               := if (self.corp_filing_date <> '','X','');
			self.corp_filing_desc             := if (self.corp_filing_date <> '','FORMATION','');
			self.corp_merged_corporation_id   := if (input.CRMMRG <> input.CRMACC, input.CRMMRG, '');
			self.corp_merger_indicator        := if (input.CRMMRG <> '', 'N', '');
      self.corp_organizational_comments := input.CRMCOM;			
      self.corp_inc_county              := Corp2_Raw_AL.Functions.Decode_County(input.CRMPLC);
			
			self.corp_address1_type_cd        := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRMPAD,input.CRMPMC,input.CRMPCT,input.CRMPST,input.CRMPZP + input.CRMPPL).ifAddressExists, 'B', '');			
			self.corp_address1_type_desc      := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRMPAD,input.CRMPMC,input.CRMPCT,input.CRMPST,input.CRMPZP + input.CRMPPL).ifAddressExists, 'BUSINESS', '');
			self.corp_address1_line1			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRMPAD,input.CRMPMC,input.CRMPCT,input.CRMPST,input.CRMPZP + input.CRMPPL).AddressLine1;
			self.corp_address1_line2			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRMPAD,input.CRMPMC,input.CRMPCT,input.CRMPST,input.CRMPZP + input.CRMPPL).AddressLine2;
			self.corp_address1_line3			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRMPAD,input.CRMPMC,input.CRMPCT,input.CRMPST,input.CRMPZP + input.CRMPPL).AddressLine3;
			self.corp_prep_addr1_line1			  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRMPAD,input.CRMPMC,input.CRMPCT,input.CRMPST,input.CRMPZP).PrepAddrLine1;
			self.corp_prep_addr1_last_line	  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRMPAD,input.CRMPMC,input.CRMPCT,input.CRMPST,input.CRMPZP).PrepAddrLastLine;
			
			self.corp_address2_type_cd        := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRORAD,input.CRORMC,input.CRORCT,input.CRORST,input.CRORZP + input.CRORPL).ifAddressExists, 'R', '');			
			self.corp_address2_type_desc      := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRORAD,input.CRORMC,input.CRORCT,input.CRORST,input.CRORZP + input.CRORPL).ifAddressExists, 'OFFICE ADDRESS', '');
			self.corp_address2_line1			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRORAD,input.CRORMC,input.CRORCT,input.CRORST,input.CRORZP + input.CRORPL).AddressLine1;
			self.corp_address2_line2			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRORAD,input.CRORMC,input.CRORCT,input.CRORST,input.CRORZP + input.CRORPL).AddressLine2;
			self.corp_address2_line3			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRORAD,input.CRORMC,input.CRORCT,input.CRORST,input.CRORZP + input.CRORPL).AddressLine3;
	   	self.corp_prep_addr2_line1			  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRORAD,input.CRORMC,input.CRORCT,input.CRORST,input.CRORZP).PrepAddrLine1;
			self.corp_prep_addr2_last_line	  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRORAD,input.CRORMC,input.CRORCT,input.CRORST,input.CRORZP).PrepAddrLastLine;

			self.corp_ra_address_type_cd      := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRMAAD,input.CRMAMC,input.CRMACT,input.CRMAST,input.CRMAZP + input.CRMAPL).ifAddressExists, 'R', '');			
			self.corp_ra_address_type_desc    := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRMAAD,input.CRMAMC,input.CRMACT,input.CRMAST,input.CRMAZP + input.CRMAPL).ifAddressExists, 'REGISTERED OFFICE', '');
			self.corp_ra_address_line1			  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRMAAD,input.CRMAMC,input.CRMACT,input.CRMAST,input.CRMAZP + input.CRMAPL).AddressLine1;
			self.corp_ra_address_line2			  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRMAAD,input.CRMAMC,input.CRMACT,input.CRMAST,input.CRMAZP + input.CRMAPL).AddressLine2;
			self.corp_ra_address_line3			  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRMAAD,input.CRMAMC,input.CRMACT,input.CRMAST,input.CRMAZP + input.CRMAPL).AddressLine3;
			self.ra_prep_addr_line1			      := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRMAAD,input.CRMAMC,input.CRMACT,input.CRMAST,input.CRMAZP).PrepAddrLine1;
			self.ra_prep_addr_last_line	      := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRMAAD,input.CRMAMC,input.CRMACT,input.CRMAST,input.CRMAZP).PrepAddrLastLine;
			
			self.recordOrigin 						    := 'C';
			self									            := [];
		end;
		
		mapCorp1  := project(jCorpMaster_OffAddr, corpMainTrf(LEFT)) : independent;
		
		//---------------- Merger Recs - Joined CorpMaster & Name file -- CORPORATION Mapping -------------//
   
		jCorpMaster_OffAddr_srt := sort(distribute(jCorpMaster_OffAddr,hash(CRMACC)),CRMACC,local) : independent;

	  // Create Merger Recs -- Join name file and jCorpMaster_OffAddr
		// Pick up corp master rec using name file acct # in simultaneous_merge(CRNMRG) field and
		// create new record using info from corp master file and name file.
		// If CRNACC = CRNMRG or CRNMRG = CRMMRG , don't create new rec
		jCorpMaster_Name 	:= join(jCorpMaster_OffAddr_srt, NameIn,	
															left.CRMACC = right.CRNMRG, //simultaneous_merge acct #
															transform(Corp2_Raw_AL.Layouts.CorpMastName_TempLay,
													    self := left; self := right; self := [];),
															left outer,local) : independent;
														 
    Merger_CorpMaster := jCorpMaster_Name(CRNMRG not in ['',CRNACC,CRMMRG]) : independent;				
 				
		Corp2_Mapping.LayoutsCommon.Main corpMainMrgTrf(Corp2_Raw_AL.Layouts.CorpMastName_TempLay input):= transform
		  self.corp_key						          := state_fips + '-' + input.CRMACC;		
			self.corp_vendor					        := state_fips;		
			self.corp_state_origin			      := state_origin;
			self.corp_inc_state				        := state_origin;
			self.dt_vendor_first_reported	    := (integer)fileDate;
			self.dt_vendor_last_reported	    := (integer)fileDate;
			self.dt_first_seen				        := (integer)fileDate;
			self.dt_last_seen				          := (integer)fileDate;
			self.corp_ra_dt_first_seen		    := (integer)fileDate;
			self.corp_ra_dt_last_seen		      := (integer)fileDate;
			self.corp_process_date			      := fileDate;
			self.corp_orig_sos_charter_nbr    := input.CRMACC;
			self.corp_legal_name				      := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,corp2.t2u(input.CRMLN1 + ' ' + input.CRMLN2)).BusinessName;
			self.corp_ln_name_type_cd			    := '01';
			self.corp_ln_name_type_desc		    := 'LEGAL';
			self.corp_orig_org_structure_cd	  := input.CRMTYP;
			self.corp_orig_org_structure_desc	:= Corp2_Raw_AL.functions.Decode_CRMTYP(input.CRMTYP);
			self.corp_for_profit_ind          := if (input.CRMTYP in ['DNP','DPN','FNP','FPN','DNL'],'N','');		
			self.corp_foreign_domestic_ind    := if (input.CRMPLC in [state_origin,county_list]
																								,'D'
																								,if (input.CRMPLC <> '','F',''));
      
			isForeign   := if (input.CRMPLC in [state_origin,county_list,''] ,'N','Y');
			fixCRMIMO   := if (input.CRMIMO = '00' ,'01' ,input.CRMIMO);
			fixCRMIDY   := if (input.CRMIDY = '00' ,'01' ,input.CRMIDY); 
			self.corp_inc_date                := if (isForeign = 'N' ,Corp2_Mapping.fValidateDate(input.CRMIYR + fixCRMIMO + fixCRMIDY,'CCYYMMDD').PastDate,'');	
		  self.corp_forgn_date              := if (isForeign = 'Y' ,Corp2_Mapping.fValidateDate(input.CRMIYR + fixCRMIMO + fixCRMIDY,'CCYYMMDD').PastDate,'');	
		  self.corp_forgn_state_cd				  := if (isForeign = 'Y', input.CRMPLC, '');	
			self.corp_forgn_state_desc        := Corp2_Raw_AL.functions.GetStateDesc(self.corp_forgn_state_cd);															
		  self.corp_status_cd				        := 'M';
		  self.corp_status_desc			        := 'MERGED';
			self.corp_status_comment          := case(input.CRMDSC,'J'=>'JUDICIALLY','A'=>'ADMINISTRATIVELY','V'=>'VOLUNTARILY',''); // Retained from old mapper							
			self.corp_ra_full_name						:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.CRMANM).BusinessName;
		  self.corp_ra_resign_date				  := Corp2_Mapping.fValidateDate(corp2.t2u(input.CRMAYR) + corp2.t2u(input.CRMAMO) + corp2.t2u(input.CRMADY),'CCYYMMDD').PastDate;
			self.corp_status_date             := Corp2_Mapping.fValidateDate(corp2.t2u(input.CRMDYR) + corp2.t2u(input.CRMDMO) + corp2.t2u(input.CRMDDY),'CCYYMMDD').PastDate; // now populated in new field corp_dissolved_date, but retaining here from old mapper
			self.corp_dissolved_date          := Corp2_Mapping.fValidateDate(corp2.t2u(input.CRMDYR) + corp2.t2u(input.CRMDMO) + corp2.t2u(input.CRMDDY),'CCYYMMDD').PastDate;	
			self.corp_orig_bus_type_desc	    := REGEXREPLACE('NOT PROVIDED',StringLib.StringFilterOut(input.CRMBUS, '-'),'');
			self.corp_filing_date				      := Corp2_Mapping.fValidateDate(input.CRMFYR + input.CRMFMO + input.CRMFDY,'CCYYMMDD').PastDate;	
			self.corp_filing_cd               := if (self.corp_filing_date <> '','X','');
			self.corp_filing_desc             := if (self.corp_filing_date <> '','FORMATION','');
			self.corp_merger_indicator        := 'N';
	    self.corp_inc_county              := Corp2_Raw_AL.Functions.Decode_County(input.CRMPLC);

			self.corp_address1_type_cd        := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRMPAD,'',input.CRMPCT,input.CRMPST,input.CRMPZP + input.CRMPPL).ifAddressExists, 'B', '');			
			self.corp_address1_type_desc      := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRMPAD,'',input.CRMPCT,input.CRMPST,input.CRMPZP + input.CRMPPL).ifAddressExists, 'BUSINESS', '');
			self.corp_address1_line1			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRMPAD,input.CRMPMC,input.CRMPCT,input.CRMPST,input.CRMPZP + input.CRMPPL).AddressLine1;
			self.corp_address1_line2			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRMPAD,input.CRMPMC,input.CRMPCT,input.CRMPST,input.CRMPZP + input.CRMPPL).AddressLine2;
			self.corp_address1_line3			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRMPAD,input.CRMPMC,input.CRMPCT,input.CRMPST,input.CRMPZP + input.CRMPPL).AddressLine3;
			self.corp_prep_addr1_line1			  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRMPAD,input.CRMPMC,input.CRMPCT,input.CRMPST,input.CRMPZP).PrepAddrLine1;
			self.corp_prep_addr1_last_line	  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRMPAD,input.CRMPMC,input.CRMPCT,input.CRMPST,input.CRMPZP).PrepAddrLastLine;
			
			self.corp_address2_type_cd        := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRORAD,input.CRORMC,input.CRORCT,input.CRORST,input.CRORZP + input.CRORPL).ifAddressExists, 'R', '');			
			self.corp_address2_type_desc      := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRORAD,input.CRORMC,input.CRORCT,input.CRORST,input.CRORZP + input.CRORPL).ifAddressExists, 'OFFICE ADDRESS', '');
			self.corp_address2_line1			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRORAD,input.CRORMC,input.CRORCT,input.CRORST,input.CRORZP + input.CRORPL).AddressLine1;
			self.corp_address2_line2			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRORAD,input.CRORMC,input.CRORCT,input.CRORST,input.CRORZP + input.CRORPL).AddressLine2;
			self.corp_address2_line3			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRORAD,input.CRORMC,input.CRORCT,input.CRORST,input.CRORZP + input.CRORPL).AddressLine3;
			self.corp_prep_addr2_line1			  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRORAD,input.CRORMC,input.CRORCT,input.CRORST,input.CRORZP).PrepAddrLine1;
			self.corp_prep_addr2_last_line	  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRORAD,input.CRORMC,input.CRORCT,input.CRORST,input.CRORZP).PrepAddrLastLine;
			
			self.corp_ra_address_type_cd      := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRMAAD,input.CRMAMC,input.CRMACT,input.CRMAST,input.CRMAZP + input.CRMAPL).ifAddressExists, 'R', '');			
			self.corp_ra_address_type_desc    := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRMAAD,input.CRMAMC,input.CRMACT,input.CRMAST,input.CRMAZP + input.CRMAPL).ifAddressExists, 'REGISTERED OFFICE', '');
			self.corp_ra_address_line1			  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRMAAD,input.CRMAMC,input.CRMACT,input.CRMAST,input.CRMAZP + input.CRMAPL).AddressLine1;
			self.corp_ra_address_line2			  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRMAAD,input.CRMAMC,input.CRMACT,input.CRMAST,input.CRMAZP + input.CRMAPL).AddressLine2;
			self.corp_ra_address_line3			  := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRMAAD,input.CRMAMC,input.CRMACT,input.CRMAST,input.CRMAZP + input.CRMAPL).AddressLine3;
			self.ra_prep_addr_line1			      := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRMAAD,input.CRMAMC,input.CRMACT,input.CRMAST,input.CRMAZP).PrepAddrLine1;
			self.ra_prep_addr_last_line	      := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRMAAD,input.CRMAMC,input.CRMACT,input.CRMAST,input.CRMAZP).PrepAddrLastLine;
			
			self.recordOrigin 						    := 'C';
			self									            := [];
		end;
		
		mapCorp2  := project(Merger_CorpMaster, corpMainMrgTrf(LEFT)) : independent;
		
					
		//-------------------- Business file -- CORPORATION Mapping ---------------------------------------//
		jBusiness	:= join(BusinessIn, CorpMasterIn, 
											left.CRBACC = right.CRMACC,
											transform(Corp2_Raw_AL.Layouts.Business_TempLay, 
																 self.CRMPLC  := right.CRMPLC;
																 self.CRMIMO 	:= right.CRMIMO;
																 self.CRMIDY  := right.CRMIDY;
																 self.CRMIYR  := right.CRMIYR;
																 self := left; self := right; self := [];),
											left outer,local) : independent;
		
		Corp2_Mapping.LayoutsCommon.Main corpBusinessTrf(Corp2_Raw_AL.Layouts.Business_TempLay input) := transform, 
											skip (corp2.t2u(input.CRBLN1 + input.CRBLN2) = '')
			self.corp_key						       := state_fips + '-' + input.CRBACC;		
			self.corp_vendor					     := state_fips;		
			self.corp_state_origin			   := state_origin;
			self.corp_inc_state				     := state_origin;
			self.dt_vendor_first_reported	 := (integer)fileDate;
			self.dt_vendor_last_reported	 := (integer)fileDate;
			self.dt_first_seen				     := (integer)fileDate;
			self.dt_last_seen				       := (integer)fileDate;
			self.corp_ra_dt_first_seen		 := (integer)fileDate;
			self.corp_ra_dt_last_seen		   := (integer)fileDate;
			self.corp_process_date			   := fileDate;
			self.corp_orig_sos_charter_nbr := input.CRBACC;
			self.corp_legal_name			     := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,corp2.t2u(input.CRBLN1 + ' ' + input.CRBLN2)).BusinessName;
			self.corp_ln_name_type_cd		   := '09';
			self.corp_ln_name_type_desc	   := 'REGISTRATION';
			
			isForeign   := if (input.CRMPLC in [state_origin,county_list,''] ,'N','Y');
			fixCRMIMO   := if (input.CRMIMO = '00' ,'01' ,input.CRMIMO);
			fixCRMIDY   := if (input.CRMIDY = '00' ,'01' ,input.CRMIDY); 
			self.corp_inc_date             := if (isForeign = 'N' ,Corp2_Mapping.fValidateDate(input.CRMIYR + fixCRMIMO + fixCRMIDY,'CCYYMMDD').PastDate,'');	
		  self.corp_forgn_date           := if (isForeign = 'Y' ,Corp2_Mapping.fValidateDate(input.CRMIYR + fixCRMIMO + fixCRMIDY,'CCYYMMDD').PastDate,'');	
			self.recordOrigin 						 := 'C';
			self							             := [];
		end;
		
		mapBusCorp	:= project(jBusiness, corpBusinessTrf(LEFT));
		
		
		//-------------------- Annual Report file -- CORPORATION Mapping -----------------------------------//
		// Normalize on the two Business Reporting Addresses										 
		Corp2_Raw_AL.Layouts.normLayout normTrf(Corp2_Raw_AL.Layouts.AnnualLayout l, unsigned1 cnt) := transform
			self.Norm_AD   := choose(cnt, l.CRABAD, l.CRAFAD);
			self.Norm_MC   := choose(cnt, l.CRABMC, l.CRAFMC);
			self.Norm_CT   := choose(cnt, l.CRABCT, l.CRAFCT);
			self.Norm_ST   := choose(cnt, l.CRABST, l.CRAFST);
			self.Norm_ZP   := choose(cnt, l.CRABZP, l.CRAFZP);
			self.Norm_PL   := choose(cnt, l.CRABPL, l.CRAFPL);
			self.Norm_Type := map(cnt = 1 => 'BR',
			                      cnt = 2 and Corp2_Mapping.fAddressExists(state_origin,state_desc,self.Norm_AD,self.Norm_MC,self.Norm_CT,self.Norm_ST,self.Norm_ZP).ifAddressExists => 'BRF',
														''); 
			self			     := l;
		end;
		
		normAR	:= normalize(AnnualReportIn, 2, normTrf(left, counter))(Norm_Type <> '');	
		
		jAnnualReport	:= join(normAR, CorpMasterIn, 
											left.CRAACC = right.CRMACC,
											transform(Corp2_Raw_AL.Layouts.AnnualReport_TempLay, 
																 self.CRMPLC  := right.CRMPLC;
																 self.CRMIMO 	:= right.CRMIMO;
																 self.CRMIDY  := right.CRMIDY;
																 self.CRMIYR  := right.CRMIYR;
																 self := left; self := right; self := [];),
											left outer,local) : independent;
											
		Corp2_Mapping.LayoutsCommon.Main corpARTrf(Corp2_Raw_AL.Layouts.AnnualReport_TempLay input) := transform 
											,skip (input.CRAACC = '')
			self.corp_key						          := state_fips + '-' + input.CRAACC;		
			self.corp_vendor					        := state_fips;		
			self.corp_state_origin			      := state_origin;
			self.corp_inc_state				        := state_origin;
			self.dt_vendor_first_reported	    := (integer)fileDate;
			self.dt_vendor_last_reported	    := (integer)fileDate;
			self.dt_first_seen				        := (integer)fileDate;
			self.dt_last_seen				          := (integer)fileDate;
			self.corp_ra_dt_first_seen		    := (integer)fileDate;
			self.corp_ra_dt_last_seen		      := (integer)fileDate;
			self.corp_process_date			      := fileDate;
			self.corp_orig_sos_charter_nbr    := input.CRAACC;
			self.corp_legal_name			        := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.CRACNM).BusinessName;
			self.corp_ln_name_type_cd		      := 'I';
			self.corp_ln_name_type_desc	      := 'REPORTING';
			self.corp_orig_bus_type_desc      := map(input.Norm_type = 'BR' => REGEXREPLACE('NOT PROVIDED',input.CRABNM,''),
			                                         input.Norm_type = 'BRF'=> REGEXREPLACE('NOT PROVIDED',input.CRAFNM,''),
																						   '');
			self.corp_ra_full_name				    := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.CRAANM).BusinessName;																				 
		  self.corp_phone_number		        := if ((integer)(input.CRATL1 + input.CRATL2 + input.CRATL3) <> 0
																			    	  ,input.CRATL1 + input.CRATL2 + input.CRATL3, '');
			validCRARYR := if (_validate.support.fIntegerInRange((integer)input.CRARYR,1600,(unsigned4)fileDate[1..4]) 
			                 	,input.CRARYR,'');																		
			self.corp_phone_number_type_desc  := if (validCRARYR <> '' and (integer)(input.CRATL1 + input.CRATL2 + input.CRATL3) <> 0, 'PHONE IN ANNUAL REPORT AS OF ' + validCRARYR, '');
			self.corp_name_comment            := if (validCRARYR <> '', 'NAME AS APPEARS IN ANNUAL REPORT AS OF ' + validCRARYR, '');
			self.corp_ra_addl_info            := if (validCRARYR <> '', 'REGISTERED AGENT AS APPEARS IN ANNUAL REPORT AS OF ' + validCRARYR, '');
      self.corp_organizational_comments := 'CORPORATION INFORMATION FROM ANNUAL REPORT';
			
			self.corp_address1_type_cd        := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRACAD,input.CRACMC,input.CRACCT,input.CRACST,input.CRACZP + input.CRACPL).ifAddressExists, 'Z', '');
			self.corp_address1_type_desc      := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRACAD,input.CRACMC,input.CRACCT,input.CRACST,input.CRACZP + input.CRACPL).ifAddressExists, 'REPORTING', '');
		  self.corp_address1_line1			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRACAD,input.CRACMC,input.CRACCT,input.CRACST,input.CRACZP + input.CRACPL).AddressLine1;
			self.corp_address1_line2			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRACAD,input.CRACMC,input.CRACCT,input.CRACST,input.CRACZP + input.CRACPL).AddressLine2;
			self.corp_address1_line3			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRACAD,input.CRACMC,input.CRACCT,input.CRACST,input.CRACZP + input.CRACPL).AddressLine3;
			self.corp_prep_addr1_line1		    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRACAD,input.CRACMC,input.CRACCT,input.CRACST,input.CRACZP).PrepAddrLine1;
			self.corp_prep_addr1_last_line    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRACAD,input.CRACMC,input.CRACCT,input.CRACST,input.CRACZP).PrepAddrLastLine;

			self.corp_address2_type_cd        := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.Norm_AD,input.Norm_MC,input.Norm_CT,input.Norm_ST,input.Norm_ZP + input.Norm_PL).ifAddressExists, 'B', '');
			self.corp_address2_type_desc	    := map(self.corp_address2_type_cd = 'B' and input.Norm_type = 'BR' => 'BUSINESS REPORTING',
																							 self.corp_address2_type_cd = 'B' and input.Norm_type = 'BRF'=> 'BUSINESS REPORTING FOREIGN', '');	
			self.corp_address2_line1			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Norm_AD,input.Norm_MC,input.Norm_CT,input.Norm_ST,input.Norm_ZP + input.Norm_PL).AddressLine1;
			self.corp_address2_line2			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Norm_AD,input.Norm_MC,input.Norm_CT,input.Norm_ST,input.Norm_ZP + input.Norm_PL).AddressLine2;
			self.corp_address2_line3			    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Norm_AD,input.Norm_MC,input.Norm_CT,input.Norm_ST,input.Norm_ZP + input.Norm_PL).AddressLine3;
			self.corp_prep_addr2_line1		    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Norm_AD,input.Norm_MC,input.Norm_CT,input.Norm_ST,input.Norm_ZP).PrepAddrLine1;
			self.corp_prep_addr2_last_line    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.Norm_AD,input.Norm_MC,input.Norm_CT,input.Norm_ST,input.Norm_ZP).PrepAddrLastLine;
	  	
			self.corp_ra_address_type_cd      := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRAAAD,input.CRAAMC,input.CRAACT,input.CRAAST,input.CRAAZP + input.CRAAPL).ifAddressExists, 'R', '');
			self.corp_ra_address_type_desc    := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRAAAD,input.CRAAMC,input.CRAACT,input.CRAAST,input.CRAAZP + input.CRAAPL).ifAddressExists, 'REGISTERED OFFICE', '');
			self.corp_ra_address_line1		    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRAAAD,input.CRAAMC,input.CRAACT,input.CRAAST,input.CRAAZP + input.CRAAPL).AddressLine1;
			self.corp_ra_address_line2		    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRAAAD,input.CRAAMC,input.CRAACT,input.CRAAST,input.CRAAZP + input.CRAAPL).AddressLine2;
			self.corp_ra_address_line3		    := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRAAAD,input.CRAAMC,input.CRAACT,input.CRAAST,input.CRAAZP + input.CRAAPL).AddressLine3;
			self.ra_prep_addr_line1			      := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRAAAD,input.CRAAMC,input.CRAACT,input.CRAAST,input.CRAAZP).PrepAddrLine1;
			self.ra_prep_addr_last_line	      := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRAAAD,input.CRAAMC,input.CRAACT,input.CRAAST,input.CRAAZP).PrepAddrLastLine;
						
			isForeign   := if (input.CRMPLC in [state_origin,county_list,''] ,'N','Y');
			fixCRMIMO   := if (input.CRMIMO = '00' ,'01' ,input.CRMIMO);
			fixCRMIDY   := if (input.CRMIDY = '00' ,'01' ,input.CRMIDY); 
			self.corp_inc_date                := if (isForeign = 'N' ,Corp2_Mapping.fValidateDate(input.CRMIYR + fixCRMIMO + fixCRMIDY,'CCYYMMDD').PastDate,'');	
		  self.corp_forgn_date              := if (isForeign = 'Y' ,Corp2_Mapping.fValidateDate(input.CRMIYR + fixCRMIMO + fixCRMIDY,'CCYYMMDD').PastDate,'');	
			self.recordOrigin 						    := 'C';
			self							                := [];
		end;
		
		mapARCorp	:= project(jAnnualReport, corpARTrf(LEFT));
		
		
		//-------------------- History file -- CORPORATION Mapping ---------------------------------------//
		jHistory 	:= join(HistoryIn, CorpMasterIn, 
											left.CRHACC = right.CRMACC,
											transform(Corp2_Raw_AL.Layouts.History_TempLay, 
																 self.CRMPLC  := right.CRMPLC;
																 self.CRMIMO 	:= right.CRMIMO;
																 self.CRMIDY  := right.CRMIDY;
																 self.CRMIYR  := right.CRMIYR;
																 self := left; self := right; self := [];),
											left outer,local) : independent;
											
		Corp2_Mapping.LayoutsCommon.Main corpHistoryTrf(Corp2_Raw_AL.Layouts.History_TempLay input) := transform, 
						skip (input.CRHLIN = '' or input.CRHTYP not in ['1','2','3','4','5'] or input.CRHACC = '')
			self.corp_key						       := state_fips + '-' + input.CRHACC;		
			self.corp_vendor					     := state_fips;		
			self.corp_state_origin			   := state_origin;
			self.corp_inc_state				     := state_origin;
			self.dt_vendor_first_reported	 := (integer)fileDate;
			self.dt_vendor_last_reported	 := (integer)fileDate;
			self.dt_first_seen				     := (integer)fileDate;
			self.dt_last_seen				       := (integer)fileDate;
			self.corp_ra_dt_first_seen		 := (integer)fileDate;
			self.corp_ra_dt_last_seen		   := (integer)fileDate;
			self.corp_process_date			   := fileDate;
			self.corp_orig_sos_charter_nbr := input.CRHACC;
			self.corp_legal_name			     := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.CRHLIN).BusinessName;
			self.corp_ln_name_type_cd		   := map(input.CRHTYP in ['1','2','3'] => 'P',
			                                      input.CRHTYP in ['4','5']     => 'N',
																						'');
			self.corp_ln_name_type_desc	   := map(input.CRHTYP in ['1','2','3'] => 'PRIOR',
			                                      input.CRHTYP in ['4','5']     => 'NON-SURVIVOR',
																						'');
								
			isForeign   := if (input.CRMPLC in [state_origin,county_list,''] ,'N','Y');
			fixCRMIMO   := if (input.CRMIMO = '00' ,'01' ,input.CRMIMO);
			fixCRMIDY   := if (input.CRMIDY = '00' ,'01' ,input.CRMIDY); 
			self.corp_inc_date             := if (isForeign = 'N' ,Corp2_Mapping.fValidateDate(input.CRMIYR + fixCRMIMO + fixCRMIDY,'CCYYMMDD').PastDate,'');	
		  self.corp_forgn_date           := if (isForeign = 'Y' ,Corp2_Mapping.fValidateDate(input.CRMIYR + fixCRMIMO + fixCRMIDY,'CCYYMMDD').PastDate,'');	
			self.recordOrigin 						 := 'C';
			self							             := [];
		end;
		
		mapHisCorp	:= project(jHistory, corpHistoryTrf(LEFT));
		
		//-------------------- Name file -- CORPORATION Mapping ---------------------------------------//
		jName 	:= join(NameIn, CorpMasterIn, 
											left.CRNACC = right.CRMACC,
											transform(Corp2_Raw_AL.Layouts.NameChanges_TempLay, 
																 self.CRMPLC  := right.CRMPLC;
																 self.CRMIMO 	:= right.CRMIMO;
																 self.CRMIDY  := right.CRMIDY;
																 self.CRMIYR  := right.CRMIYR;
																 self := left; self := right; self := [];),
											left outer,local) : independent;
		
		Corp2_Mapping.LayoutsCommon.Main corpNameTrf(Corp2_Raw_AL.Layouts.NameChanges_TempLay input) := transform, 
						skip (corp2.t2u(input.CRNLN1 + ' ' + input.CRNLN2) in ['','* ADDED','*ADDED'] or input.CRNTYP not in ['1','2','3','4','5'] or input.CRNACC = '')
			self.corp_key						       := state_fips + '-' + input.CRNACC;		
			self.corp_vendor					     := state_fips;		
			self.corp_state_origin			   := state_origin;
			self.corp_inc_state				     := state_origin;
			self.dt_vendor_first_reported	 := (integer)fileDate;
			self.dt_vendor_last_reported	 := (integer)fileDate;
			self.dt_first_seen				     := (integer)fileDate;
			self.dt_last_seen				       := (integer)fileDate;
			self.corp_ra_dt_first_seen		 := (integer)fileDate;
			self.corp_ra_dt_last_seen		   := (integer)fileDate;
			self.corp_process_date			   := fileDate;
			self.corp_orig_sos_charter_nbr := input.CRNACC;
			self.corp_legal_name			     := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,corp2.t2u(input.CRNLN1 + ' ' + input.CRNLN2)).BusinessName;
			self.corp_ln_name_type_cd		   := map(input.CRNTYP in ['1','2','3'] => 'P',
			                                      input.CRNTYP in ['4','5']     => 'N',
																						'');
			self.corp_ln_name_type_desc	   := map(input.CRNTYP in ['1','2','3'] => 'PRIOR',
			                                      input.CRNTYP in ['4','5']     => 'NON-SURVIVOR',
																						'');
											
			isForeign   := if (input.CRMPLC in [state_origin,county_list,''] ,'N','Y');
			fixCRMIMO   := if (input.CRMIMO = '00' ,'01' ,input.CRMIMO);
			fixCRMIDY   := if (input.CRMIDY = '00' ,'01' ,input.CRMIDY); 
			self.corp_inc_date             := if (isForeign = 'N' ,Corp2_Mapping.fValidateDate(input.CRMIYR + fixCRMIMO + fixCRMIDY,'CCYYMMDD').PastDate,'');	
		  self.corp_forgn_date           := if (isForeign = 'Y' ,Corp2_Mapping.fValidateDate(input.CRMIYR + fixCRMIMO + fixCRMIDY,'CCYYMMDD').PastDate,'');	
			self.recordOrigin 						 := 'C';
			self							             := [];
		end;
		
		mapNameCorp	:= project(jName, corpNameTrf(LEFT));
		
		
		mapAllCorp	:= mapCorp1 + mapCorp2 + mapBusCorp + mapARCorp + mapHisCorp + mapNameCorp: independent;
		
		
    //-------------------- End of CORPORATION Mapping ----------------------------------------------------//


		//-------------------- CONTACT Mapping ---------------------------------------------------------------//
		
		// mapCont1 - Annual Report - President
		Corp2_Mapping.LayoutsCommon.Main contARPresTrf(Corp2_Raw_AL.Layouts.AnnualLayout input) := transform, 
										    skip (Corp2_Mapping.fCleanPersonName(state_origin,state_desc,'','',input.CRAPNM).LastName in ['',' ','NOT PROVIDED','NOT PROVDED','NOT PROVIDE'] )
			self.corp_key						         := state_fips + '-' + input.CRAACC;		
			self.corp_orig_sos_charter_nbr   := input.CRAACC;
			self.corp_vendor					       := state_fips;		
			self.corp_state_origin			     := state_origin;
			self.corp_inc_state				       := state_origin;
			self.dt_vendor_first_reported	   := (integer)fileDate;
			self.dt_vendor_last_reported	   := (integer)fileDate;
			self.dt_first_seen				       := (integer)fileDate;
			self.dt_last_seen				         := (integer)fileDate;
			self.corp_ra_dt_first_seen	     := (integer)fileDate;
			self.corp_ra_dt_last_seen		     := (integer)fileDate;
			self.corp_process_date			     := fileDate;
			self.corp_legal_name       		   := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.CRACNM).BusinessName;
			self.cont_full_name			         := Corp2_Mapping.fCleanPersonName(state_origin,state_desc,'','',input.CRAPNM).LastName;
			self.cont_type_cd				         := 'F';
			self.cont_type_desc			         := 'OFFICER';
			self.cont_title1_desc		         := 'PRESIDENT';
			self.cont_filing_date            := if (_validate.support.fIntegerInRange((integer)input.CRARYR,1600,(unsigned4)fileDate[1..4])
																			 	     ,input.CRARYR,'');  
			self.cont_filing_cd              := 'B';
			self.cont_filing_desc            := 'AS OF ANNUAL REPORT';
			self.cont_address_effective_date := if (_validate.support.fIntegerInRange((integer)input.CRARYR,1600,(unsigned4)fileDate[1..4]) and 
			                                        Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRAPAD,input.CRAPMC,input.CRAPCT,input.CRAPST,input.CRAPZP).ifAddressExists 
																						 ,input.CRARYR,'');  
			self.cont_address_type_cd        := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRAPAD,input.CRAPMC,input.CRAPCT,input.CRAPST,input.CRAPZP + input.CRAPPL).ifAddressExists, 'T', '');			
			self.cont_address_type_desc      := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRAPAD,input.CRAPMC,input.CRAPCT,input.CRAPST,input.CRAPZP + input.CRAPPL).ifAddressExists, 'CONTACT', '');
			self.cont_address_line1			     := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRAPAD,input.CRAPMC,input.CRAPCT,input.CRAPST,input.CRAPZP + input.CRAPPL).AddressLine1;
			self.cont_address_line2			     := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRAPAD,input.CRAPMC,input.CRAPCT,input.CRAPST,input.CRAPZP + input.CRAPPL).AddressLine2;
			self.cont_address_line3			     := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRAPAD,input.CRAPMC,input.CRAPCT,input.CRAPST,input.CRAPZP + input.CRAPPL).AddressLine3;
			self.cont_prep_addr_line1			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRAPAD,input.CRAPMC,input.CRAPCT,input.CRAPST,input.CRAPZP).PrepAddrLine1;
			self.cont_prep_addr_last_line	   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRAPAD,input.CRAPMC,input.CRAPCT,input.CRAPST,input.CRAPZP).PrepAddrLastLine;
			self.recordOrigin 						   := 'T';	
			self							               := [];
		end; 	
		
		mapCont1 := project(AnnualReportIn, contARPresTrf(LEFT));
		
		// mapCont2 - Annual Report - Secretary
		Corp2_Mapping.LayoutsCommon.Main contARSecrTrf(Corp2_Raw_AL.Layouts.AnnualLayout input):= transform, 
											skip (Corp2_Mapping.fCleanPersonName(state_origin,state_desc,'','',input.CRASNM).LastName in ['',' ','NOT PROVIDED','NOT PROVDED','NOT PROVIDE'] )
			self.corp_key						         := state_fips + '-' + input.CRAACC;
			self.corp_orig_sos_charter_nbr   := input.CRAACC;
			self.corp_vendor					       := state_fips;		
			self.corp_state_origin			     := state_origin;
			self.corp_inc_state				       := state_origin;
			self.dt_vendor_first_reported    := (integer)fileDate;
			self.dt_vendor_last_reported	   := (integer)fileDate;
			self.dt_first_seen				       := (integer)fileDate;
			self.dt_last_seen				         := (integer)fileDate;
			self.corp_ra_dt_first_seen	     := (integer)fileDate;
			self.corp_ra_dt_last_seen		     := (integer)fileDate;
			self.corp_process_date			     := fileDate;
			self.corp_legal_name       		   := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.CRACNM).BusinessName;
			self.cont_full_name			         := Corp2_Mapping.fCleanPersonName(state_origin,state_desc,'','',input.CRASNM).LastName;
			self.cont_type_cd				         := 'F';
			self.cont_type_desc			         := 'OFFICER';
			self.cont_title1_desc		         := 'SECRETARY';
			self.cont_filing_date            := if (_validate.support.fIntegerInRange((integer)input.CRARYR,1600,(unsigned4)fileDate[1..4])
																					   ,input.CRARYR,'');  
			self.cont_filing_cd              := 'B';
			self.cont_filing_desc            := 'AS OF ANNUAL REPORT';
			self.cont_address_effective_date := if (_validate.support.fIntegerInRange((integer)input.CRARYR,1600,(unsigned4)fileDate[1..4]) and 
			                                        Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRASAD,input.CRASMC,input.CRASCT,input.CRASST,input.CRASZP).ifAddressExists 
																						 ,input.CRARYR,'');  
			self.cont_address_type_cd        := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRASAD,input.CRASMC,input.CRASCT,input.CRASST,input.CRASZP + input.CRASPL).ifAddressExists, 'T', '');			
			self.cont_address_type_desc      := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRASAD,input.CRASMC,input.CRASCT,input.CRASST,input.CRASZP + input.CRASPL).ifAddressExists, 'CONTACT', '');
			self.cont_address_line1			     := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRASAD,input.CRASMC,input.CRASCT,input.CRASST,input.CRASZP + input.CRASPL).AddressLine1;
			self.cont_address_line2			     := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRASAD,input.CRASMC,input.CRASCT,input.CRASST,input.CRASZP + input.CRASPL).AddressLine2;
			self.cont_address_line3			     := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRASAD,input.CRASMC,input.CRASCT,input.CRASST,input.CRASZP + input.CRASPL).AddressLine3;
			self.cont_prep_addr_line1			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRASAD,input.CRASMC,input.CRASCT,input.CRASST,input.CRASZP).PrepAddrLine1;
			self.cont_prep_addr_last_line	   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRASAD,input.CRASMC,input.CRASCT,input.CRASST,input.CRASZP).PrepAddrLastLine;
  		self.recordOrigin 							 := 'T';
			self							               := [];
		end; 	

		mapCont2 := project(AnnualReportIn, contARSecrTrf(LEFT));

		// mapCont3 - Incorporator file
		
		jIncorp_CorpMaster := join(CorpMasterIn, IncorpIn,
															 left.CRMACC = right.CRIACC,
															 transform(Corp2_Raw_AL.Layouts.CorpMastIncorp_TempLay,
															 self := left; self := right; self := [];),
															 left outer,local) : independent;	
		
		Corp2_Mapping.LayoutsCommon.Main contIncorpTrf(Corp2_Raw_AL.Layouts.CorpMastIncorp_TempLay input):= transform, 
											skip (Corp2_Mapping.fCleanPersonName(state_origin,state_desc,'','',input.CRIINM).LastName in ['',' ','NOT PROVIDED','NOT PROVDED','NOT PROVIDE'] )
			self.corp_key						       := state_fips + '-' + input.CRIACC;		
			self.corp_orig_sos_charter_nbr := input.CRIACC;
			self.corp_vendor  					   := state_fips;		
			self.corp_state_origin			   := state_origin;
			self.corp_inc_state				     := state_origin;
			self.dt_vendor_first_reported	 := (integer)fileDate;
			self.dt_vendor_last_reported	 := (integer)fileDate;
			self.dt_first_seen				     := (integer)fileDate;
			self.dt_last_seen				       := (integer)fileDate;
			self.corp_ra_dt_first_seen		 := (integer)fileDate;
			self.corp_ra_dt_last_seen		   := (integer)fileDate;
			self.corp_process_date			   := fileDate;
			self.corp_legal_name				   := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,corp2.t2u(input.CRMLN1 + ' ' + input.CRMLN2)).BusinessName;
			self.cont_full_name			       := Corp2_Mapping.fCleanPersonName(state_origin,state_desc,'','',input.CRIINM).LastName;
			self.cont_type_cd				       := 'F';
			self.cont_type_desc			       := 'OFFICER';
			self.cont_title1_desc		       := 'INCORPORATOR';
			self.cont_address_type_cd      := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRIIAD,input.CRIIMC,input.CRIICT,input.CRIIST,input.CRIIZP + input.CRIIPL).ifAddressExists, 'T', '');			
			self.cont_address_type_desc    := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRIIAD,input.CRIIMC,input.CRIICT,input.CRIIST,input.CRIIZP + input.CRIIPL).ifAddressExists, 'CONTACT', '');
			self.cont_address_line1			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRIIAD,input.CRIIMC,input.CRIICT,input.CRIIST,input.CRIIZP + input.CRIIPL).AddressLine1;
			self.cont_address_line2			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRIIAD,input.CRIIMC,input.CRIICT,input.CRIIST,input.CRIIZP + input.CRIIPL).AddressLine2;
			self.cont_address_line3			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRIIAD,input.CRIIMC,input.CRIICT,input.CRIIST,input.CRIIZP + input.CRIIPL).AddressLine3;
			self.cont_prep_addr_line1			 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRIIAD,input.CRIIMC,input.CRIICT,input.CRIIST,input.CRIIZP).PrepAddrLine1;
			self.cont_prep_addr_last_line	 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRIIAD,input.CRIIMC,input.CRIICT,input.CRIIST,input.CRIIZP).PrepAddrLastLine;

			self.recordOrigin 						 := 'T';
			self							             := [];
		end; 	

		mapCont3 := project(jIncorp_CorpMaster, contIncorpTrf(LEFT));
		
		// mapCont4 - Service of Process file

	  jService_CorpMaster := join(CorpMasterIn, ServiceIn,  
																left.CRMACC = right.CRSACC,
								                transform(Corp2_Raw_AL.Layouts.CorpMastService_TempLay,
																self := left; self := right; self := [];),
								                left outer,local) : independent;		
		
		Corp2_Mapping.LayoutsCommon.Main contServTrf(Corp2_Raw_AL.Layouts.CorpMastService_TempLay input):= transform 
									,skip (Corp2_Mapping.fCleanPersonName(state_origin,state_desc,'','',input.CRSPNM).LastName in ['',' ','NOT PROVIDED','NOT PROVDED','NOT PROVIDE'] )
			self.corp_key						       := state_fips + '-' + input.CRSACC;	
			self.corp_orig_sos_charter_nbr := input.CRSACC;
			self.corp_vendor					     := state_fips;		
			self.corp_state_origin			   := state_origin;
			self.corp_inc_state				     := state_origin;
			self.dt_vendor_first_reported	 := (integer)fileDate;
			self.dt_vendor_last_reported	 := (integer)fileDate;
			self.dt_first_seen				     := (integer)fileDate;
			self.dt_last_seen				       := (integer)fileDate;
			self.corp_ra_dt_first_seen	   := (integer)fileDate;
			self.corp_ra_dt_last_seen		   := (integer)fileDate;
			self.corp_process_date			   := fileDate;
			self.corp_legal_name				   := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,corp2.t2u(input.CRMLN1 + input.CRMLN2)).Businessname;
			self.cont_full_name			       := Corp2_Mapping.fCleanPersonName(state_origin,state_desc,'','',input.CRSPNM).LastName;
			self.cont_type_cd				       := 'T';
			self.cont_type_desc			       := 'CONTACT';
			self.cont_title1_desc		       := 'SERVICE OF PROCESS';
			self.cont_address_type_cd      := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRSPAD,input.CRSPMC,input.CRSPCT,input.CRSPST,input.CRSPZP + input.CRSPPL).ifAddressExists, 'P', '');			
			self.cont_address_type_desc    := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRSPAD,input.CRSPMC,input.CRSPCT,input.CRSPST,input.CRSPZP + input.CRSPPL).ifAddressExists, 'PROCESS', '');
			self.cont_address_line1			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRSPAD,input.CRSPMC,input.CRSPCT,input.CRSPST,input.CRSPZP + input.CRSPPL).AddressLine1;
			self.cont_address_line2			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRSPAD,input.CRSPMC,input.CRSPCT,input.CRSPST,input.CRSPZP + input.CRSPPL).AddressLine2;
			self.cont_address_line3			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRSPAD,input.CRSPMC,input.CRSPCT,input.CRSPST,input.CRSPZP + input.CRSPPL).AddressLine3;
			self.cont_prep_addr_line1			 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRSPAD,input.CRSPMC,input.CRSPCT,input.CRSPST,input.CRSPZP).PrepAddrLine1;
			self.cont_prep_addr_last_line	 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRSPAD,input.CRSPMC,input.CRSPCT,input.CRSPST,input.CRSPZP).PrepAddrLastLine;
			self.recordOrigin 						 := 'T';
			self							             := [];
		end; 	

		mapCont4 := project(jService_CorpMaster, contServTrf(LEFT));
		
		// mapCont5 - History/Office Address joined file
		
		jHist_OffAddr := join(HistoryIn, OffAddrIn,  
													left.CRHACC = right.CROACC,
													transform(Corp2_Raw_AL.Layouts.HistOffAddr_TempLay,
													self := left; self := right; self := [];),
													left outer,local) : independent;
		
		jHist_OffAddr_srt := sort(distribute(jHist_OffAddr,hash(CROACC)),CROACC,local) : independent;							 

		jHistOffAddr_Corp := join(CorpMasterIn, jHist_OffAddr_srt,  
															left.CRMACC = right.CROACC,
															transform(Corp2_Raw_AL.Layouts.HistOffAddrCorpMast_TempLay,
													    self := left; self := right; self := [];),
															left outer,local) : independent;				
				
		Corp2_Mapping.LayoutsCommon.Main contHistTrf(Corp2_Raw_AL.Layouts.HistOffAddrCorpMast_TempLay input):= transform 
						,skip (StringLib.StringFilterOut(input.CRHLIN, '0123456789') in ['',' ','NOT PROVIDED','NOT PROVDED','NOT PROVIDE'] )
			self.corp_key						       := state_fips + '-' + input.CRHACC;		
			self.corp_orig_sos_charter_nbr := input.CRHACC;
			self.corp_vendor					     := state_fips;		
			self.corp_state_origin			   := state_origin;
			self.corp_inc_state				     := state_origin;
			self.dt_vendor_first_reported	 := (integer)fileDate;
			self.dt_vendor_last_reported	 := (integer)fileDate;
			self.dt_first_seen				     := (integer)fileDate;
			self.dt_last_seen				       := (integer)fileDate;
			self.corp_ra_dt_first_seen		 := (integer)fileDate;
			self.corp_ra_dt_last_seen		   := (integer)fileDate;
			self.corp_process_date			   := fileDate;
			self.corp_legal_name				   := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,corp2.t2u(input.CRMLN1 + ' ' + input.CRMLN2)).BusinessName;
			self.cont_full_name			       := StringLib.StringFilterOut(input.CRHLIN, '0123456789');
			self.cont_type_cd				       := 'F';
			self.cont_type_desc			       := 'OFFICER';
			self.cont_title1_desc		       := map(input.CRHTYP = '12' => 'MEMBER',
                                            input.CRHTYP = '48' => 'DIRECTOR',
																						'');
			self.cont_filing_date          := Corp2_Mapping.fValidateDate(input.CRHHYR + input.CRHHMO + input.CRHHDY,'CCYYMMDD').PastDate;
			self.cont_filing_cd            := 'X';
			self.cont_filing_desc          := 'OTHER';
			self.cont_address_type_cd      := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRORAD,input.CRORMC,input.CRORCT,input.CRORST,input.CRORZP + input.CRORPL).ifAddressExists, 'T', '');			
			self.cont_address_type_desc    := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.CRORAD,input.CRORMC,input.CRORCT,input.CRORST,input.CRORZP + input.CRORPL).ifAddressExists, 'CONTACT', '');
			self.cont_address_line1			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRORAD,input.CRORMC,input.CRORCT,input.CRORST,input.CRORZP + input.CRORPL).AddressLine1;
			self.cont_address_line2			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRORAD,input.CRORMC,input.CRORCT,input.CRORST,input.CRORZP + input.CRORPL).AddressLine2;
			self.cont_address_line3			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRORAD,input.CRORMC,input.CRORCT,input.CRORST,input.CRORZP + input.CRORPL).AddressLine3;
			self.cont_prep_addr_line1			 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRORAD,input.CRORMC,input.CRORCT,input.CRORST,input.CRORZP).PrepAddrLine1;
			self.cont_prep_addr_last_line	 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.CRORAD,input.CRORMC,input.CRORCT,input.CRORST,input.CRORZP).PrepAddrLastLine;
			self.recordOrigin 						 := 'T';
			self							             := [];
		end; 	

		mapCont5 := project(jHistOffAddr_Corp(CRHTYP in ['12','48']), contHistTrf(LEFT));		
			
		
		mapCont	:=	mapCont1 + mapCont2 + mapCont3 + mapCont4 + mapCont5;
				
		
		//--------------------EVENT Mapping ----------------------------------------------------------//
    
		// History file transform		
		Corp2_Mapping.LayoutsCommon.Events EventHistTrf(Corp2_Raw_AL.Layouts.HistoryFileLayout input) := transform
			self.corp_key						      := state_fips + '-' + input.CRHACC;		
			self.corp_vendor					    := state_fips;		
			self.corp_state_origin			  := state_origin;
			self.corp_process_date			  := fileDate;	
			self.corp_sos_charter_nbr	    := input.CRHACC;
			self.event_filing_date	    	:= Corp2_Mapping.fValidateDate(input.CRHHYR + input.CRHHMO + input.CRHHDY,'CCYYMMDD').GeneralDate;
			self.event_date_type_cd	    	:= if (self.event_filing_date <> '','FIL','');    // Retaining from old mapper
			self.event_date_type_desc    	:= if (self.event_filing_date <> '','FILING',''); // Retaining from old mapper 
			self.event_filing_cd		      := input.CRHTYP;
			self.event_filing_desc        := Corp2_Raw_AL.functions.Decode_EventFilingDesc(input.CRHTYP);
			self.event_desc	              := corp2.t2u(regexreplace(' 0*$',regexreplace('---',corp2.t2u(input.CRHLIN),''),' '));
			self							            := [];
		end;
		
		mapEvent1 := project(HistoryIn, EventHistTrf(LEFT));
		
    // Name file transform    
		Corp2_Mapping.LayoutsCommon.Events EventNameTrf(Corp2_Raw_AL.Layouts.NameChangesFileLayout input) := transform
			self.corp_key						      := state_fips + '-' + input.CRNACC;		
			self.corp_vendor					    := state_fips;		
			self.corp_state_origin			  := state_origin;
			self.corp_process_date			  := fileDate;
			self.corp_sos_charter_nbr    	:= input.CRNACC;
			self.event_filing_date		    := Corp2_Mapping.fValidateDate(corp2.t2u(input.CRNHYR) + corp2.t2u(input.CRNHMO) + corp2.t2u(input.CRNHDY),'CCYYMMDD').GeneralDate;
			self.event_date_type_cd		    := if (self.event_filing_date <> '','FIL','');    // Retaining from old mapper
			self.event_date_type_desc	    := if (self.event_filing_date <> '','FILING',''); // Retaining from old mapper
			self.event_filing_cd		      := map(input.CRNMRG =  ''  => input.CRNTYP,
			                                     input.CRNMRG <> ''  => '04',
																		    	 '');
			self.event_filing_desc	    	:= if (input.CRNMRG <> ''
			                                    ,'LEGAL NAME MERGED'
																			    ,Corp2_Raw_AL.functions.Decode_EventFilingDesc(input.CRNTYP));
      self.event_desc					      := corp2.t2u(input.CRNLN1 + ' ' + input.CRNLN2);
			self							            := [];
		end;
		
		mapEvent2 := project(NameIn, EventNameTrf(LEFT));
		
		
		
		
		//--------------------AR Mapping------------------------------------------------------------------//
		Corp2_Mapping.LayoutsCommon.AR  ARMainTrf(Corp2_Raw_AL.Layouts.AnnualLayout input) := transform
			self.corp_key						      := state_fips + '-' + input.CRAACC;		
			self.corp_vendor					    := state_fips;		
			self.corp_state_origin			  := state_origin;
			self.corp_process_date			  := fileDate;	
			self.corp_sos_charter_nbr    	:= input.CRAACC;
			self.ar_year 					        := if (_validate.support.fIntegerInRange((integer)input.CRARYR,1600,(unsigned4)fileDate[1..4])
																			 	     ,input.CRARYR,'');
			self.ar_comment					      := if (self.ar_year <> '', 'ANNUAL REPORT', '');
			self							            := [];
		end; 
		
		
		
		//--------------------STOCK Mapping ----------------------------------------------------------//	
		Corp2_Mapping.LayoutsCommon.Stock StockMainTrf(Corp2_Raw_AL.Layouts.CorpMasterLayout input) := transform, 
												skip (input.CRMAUT = '' and input.CRMPIN = '')
			self.corp_key						   := state_fips + '-' + input.CRMACC;		
			self.corp_vendor					 := state_fips;		
			self.corp_state_origin		 := state_origin;
			self.corp_process_date		 := fileDate;				
			self.corp_sos_charter_nbr	 := input.CRMACC;
			
			cleanAUT := StringLib.StringFilterOut(input.CRMAUT, '-=');
			cleanPIN := StringLib.StringFilterOut(input.CRMPIN, '-=');
			self.stock_authorized_capital    := (integer)cleanAut;
			self.stock_stock_paid_in_capital := (integer)cleanPIN;
			self.stock_addl_info   		 := map(cleanAUT not in ['$','`',''] and cleanPIN not in ['$','`',''] => 'AUTHORIZED CAPITAL: ' + cleanAUT + ' - PAID IN CAPITAL: ' + cleanPIN,
																				cleanAUT not in ['$','`',''] => 'AUTHORIZED CAPITAL: ' + cleanAUT,
																				cleanPIN not in ['$','`',''] => 'PAID IN CAPITAL: ' + cleanPIN,
																				'');  // Retaining stock_addl_info from old mapper
			self							         := [];
		end;

		mapStock1 := project(CorpMasterIn, StockMainTrf(LEFT));
		
		Corp2_Mapping.LayoutsCommon.Stock StockMergTrf(Corp2_Raw_AL.Layouts.CorpMastName_TempLay input) := transform 
												,skip (input.CRMAUT = '' and input.CRMPIN = '')
			self.corp_key						   := state_fips + '-' + input.CRNACC;		
			self.corp_vendor					 := state_fips;		
			self.corp_state_origin		 := state_origin;
			self.corp_process_date		 := fileDate;			
			self.corp_sos_charter_nbr	 := input.CRNACC;
			
			cleanAUT := StringLib.StringFilterOut(input.CRMAUT, '-=');
			cleanPIN := StringLib.StringFilterOut(input.CRMPIN, '-=');
			self.stock_authorized_capital    := (integer)cleanAut;
			self.stock_stock_paid_in_capital := (integer)cleanPIN;
			self.stock_addl_info   		 := map(cleanAUT not in ['$','`',''] and cleanPIN not in ['$','`',''] => 'AUTHORIZED CAPITAL: ' + cleanAUT + ' - PAID IN CAPITAL: ' + cleanPIN,
																				cleanAUT not in ['$','`',''] => 'AUTHORIZED CAPITAL: ' + cleanAUT,
																				cleanPIN not in ['$','`',''] => 'PAID IN CAPITAL: ' + cleanPIN,
																				'');  // Retaining stock_addl_info from old mapper
			self							         := [];
		end;

		mapStock2 := project(Merger_CorpMaster, StockMergTrf(LEFT));
		
		
	//-----------------------------------------------------------//
	// Build the Final Mapped Files
	//-----------------------------------------------------------//
		mapMain  := dedup(sort(distribute(mapAllCorp + mapCont,hash(corp_key)), record,local), record,local) : independent;	
		mapEvent := dedup(sort(distribute(mapEvent1 + mapEvent2,hash(corp_key)), record,local), record,local) : independent;	
		mapAr    := dedup(sort(distribute(project(AnnualReportIn, ARMainTrf(left)),hash(corp_key)), record,local), record,local) : independent;
		mapStock := dedup(sort(distribute(mapStock1 + mapStock2,hash(corp_key)), record,local), record,local) : independent;	

	  	
	//--------------------------------------------------------------------	
  // Scrubs for MAIN
  //--------------------------------------------------------------------
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_AL_Main.Scrubs;        // Scrubs module
		Main_N := Main_S.FromNone(Main_F); 										// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     	// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_AL'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_AL'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_AL'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_AL_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);
	
 	  //Submits Profile's stats to Orbit
		Main_SubmitStats 					:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_AL_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_AL_Main').SubmitStats;
	
	  Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_AL_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_AL_Main').CompareToProfile_with_Examples;
		
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.AttachedList
																																	 ,'Scrubs CorpMain_AL Report' //subject
																																	 ,'Scrubs CorpMain_AL Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpALMainScrubsReport.csv'
																																	);		
																																 
		Main_BadRecords := Main_T.ExpandedInFile(	dt_vendor_first_reported_invalid 	 <> 0 or
																							dt_vendor_last_reported_invalid 	 <> 0 or
																							dt_first_seen_invalid 			       <> 0 or
																							dt_last_seen_invalid 			         <> 0 or
																							corp_ra_dt_first_seen_invalid 		 <> 0 or
																							corp_ra_dt_last_seen_invalid 			 <> 0 or
																							corp_process_date_invalid 			   <> 0 or
																							corp_filing_date_invalid           <> 0 or
																							corp_merger_date_invalid           <> 0 or
																							corp_dissolved_date_invalid        <> 0 or
																							corp_forgn_date_invalid            <> 0 or
																							corp_inc_date_invalid              <> 0 or
																							corp_ra_resign_date_invalid        <> 0 or
																							corp_vendor_invalid 			         <> 0 or
																							corp_state_origin_invalid 			   <> 0 or
																							corp_legal_name_invalid 			     <> 0 or
																							corp_merged_corporation_id_invalid <> 0 or
																							corp_key_invalid 			             <> 0 or
																							corp_orig_sos_charter_nbr_invalid  <> 0 or
																							corp_foreign_domestic_ind_invalid  <> 0 or
																							corp_for_profit_ind_invalid 			 <> 0 or
																							corp_inc_state_invalid 			       <> 0 or
																							corp_ln_name_type_cd_invalid 			 <> 0 or
																							corp_forgn_state_desc_invalid      <> 0 or
																							corp_orig_org_structure_cd_invalid <> 0 );

		Main_GoodRecords	:= Main_T.ExpandedInFile( dt_vendor_first_reported_invalid 	 = 0 and
																								dt_vendor_last_reported_invalid 	 = 0 and
																								dt_first_seen_invalid 			       = 0 and
																								dt_last_seen_invalid 			         = 0 and
																								corp_ra_dt_first_seen_invalid 		 = 0 and
																								corp_ra_dt_last_seen_invalid 			 = 0 and
																								corp_process_date_invalid 			   = 0 and
																								corp_filing_date_invalid           = 0 and
																								corp_merger_date_invalid           = 0 and
																								corp_dissolved_date_invalid        = 0 and
																								corp_forgn_date_invalid            = 0 and
																								corp_inc_date_invalid              = 0 and
																								corp_ra_resign_date_invalid        = 0 and
																								corp_vendor_invalid 			         = 0 and
																								corp_state_origin_invalid 			   = 0 and
																								corp_legal_name_invalid 			     = 0 and
																								corp_merged_corporation_id_invalid = 0 and
																								corp_key_invalid 			             = 0 and
																								corp_orig_sos_charter_nbr_invalid  = 0 and
																								corp_foreign_domestic_ind_invalid  = 0 and
																								corp_for_profit_ind_invalid 			 = 0 and
																								corp_inc_state_invalid 			       = 0 and
																								corp_ln_name_type_cd_invalid 			 = 0 and
																								corp_forgn_state_desc_invalid      = 0 and
																								corp_orig_org_structure_cd_invalid = 0 );																												 																	
		
		Main_FailBuild	:= map(corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_AL_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),					 count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_AL_Main.Threshold_Percent.CORP_LEGAL_NAME 					=> true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),						     count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_AL_Main.Threshold_Percent.CORP_KEY      						=> true,
													 count(Main_GoodRecords) = 0																																																																																				          => true,
													 false );

		Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
	
		Main_RejFile_Exists		:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);			
	  Main_ALL		 					:= sequential(IF(count(Main_BadRecords) <> 0
																					,IF (poverwrite
																							,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_AL',overwrite,__compressed__,named('Sample_Rejected_MainRecs_AL'+filedate))
																							,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																													 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_AL'+filedate)))))
																		,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainALScrubsReportWithExamples'+filedate))																		
																		//Send Alerts if Scrubs exceeds thresholds
																		,IF(COUNT(Main_ScrubsAlert) > 0, Main_SendEmailFile, OUTPUT('CORP2_MAPPING.AL - No "MAIN" Corp Scrubs Alerts'))
																		,Main_ErrorSummary
																		,Main_ScrubErrorReport
																		,Main_SomeErrorValues
																		,Main_SubmitStats);
																		
	//--------------------------------------------------------------------	
  // Scrubs for Event
  //--------------------------------------------------------------------
		Event_F := MapEvent;
		Event_S := Scrubs_Corp2_Mapping_AL_Event.Scrubs;        // AL scrubs module
		Event_N := Event_S.FromNone(Event_F); 									// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     	// Use the FromBits module; mALes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile);// Pass the expanded error flags into the Expanded module

	//Outputs reports
		Event_ErrorSummary				:= output(Event_U.SummaryStats, named('Event_ErrorSummary_AL'+filedate));
		Event_ScrubErrorReport 		:= output(choosen(Event_U.AllErrors, 1000), named('Event_ScrubErrorReport_AL'+filedate));
		Event_SomeErrorValues			:= output(choosen(Event_U.BadValues, 1000), named('Event_SomeErrorValues_AL'+filedate));
		Event_IsScrubErrors		 		:= IF(count(Event_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Event_OrbitStats						:= Event_U.OrbitStats();
		
		//Outputs files
		Event_CreateBitMaps				:= output(Event_N.BitmapInfile,,'~thor_data::corp_AL_Event_scrubs_bits',overwrite,compressed);	//long term storage
	  
		//Submits Profile's stats to Orbit
		Event_SubmitStats 				:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_AL_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_AL_Event').SubmitStats;
	
	  Event_TranslateBitMap			:= output(Event_T);
		Event_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_AL_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_AL_Event').CompareToProfile_with_Examples;
		
		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
																																	 ,'Scrubs CorpEvent_AL Report' //subject
																																	 ,'Scrubs CorpEvent_AL Report' //body
																																	 ,(data)Event_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpALEventScrubsReport.csv'
																																	 ,
																																	 ,
																																	 ,corp2.Email_Notification_Lists.spray
																																 );		
																																 
		Event_BadRecords := Event_T.ExpandedInFile ( event_filing_cd_invalid 	<> 0 );	

		Event_GoodRecords	:= Event_T.ExpandedInFile( event_filing_cd_invalid	 = 0 );																					 																	
		
		Event_FailBuild	:= if(count(Event_GoodRecords) = 0,true,false);

		Event_ApprovedRecords := project(Event_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Events,self := left));		
		
		Event_RejFile_Exists			:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_' + state_origin),true,false);			
	  Event_ALL									:= sequential(IF(count(Event_BadRecords)<> 0
																						 ,if(poverwrite
																								,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_AL',overwrite,__compressed__,named('Sample_Rejected_Event_Recs_AL'+filedate))
																								,sequential (IF(Event_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin)),
																														 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+ state_origin,__compressed__,named('Sample_Rejected_Event_Recs_AL'+filedate)))))
																					 ,output(Event_ScrubsWithExamples, ALL, NAMED('CorpEventALScrubsReportWithExamples'+filedate))
																					 //Send Alerts if Scrubs exceeds thresholds
																					 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_SendEmailFile, OUTPUT('CORP2_MAPPING.AL - No "EVENT" Corp Scrubs Alerts'))
																					 ,Event_ErrorSummary
																					 ,Event_ScrubErrorReport
																					 ,Event_SomeErrorValues
																					 ,Event_SubmitStats);
																				 
	
 //-------------------- Version Control -----------------------------------------------------//	
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::main_al'			,Main_ApprovedRecords ,main_out		     ,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock_al'			,MapStock	            ,stock_out	     ,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_al'			,Event_ApprovedRecords,event_out	     ,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::ar_al'				,MapAR		            ,ar_out			     ,,,pOverwrite);
	
	VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::main_al'	,MapMain              ,write_fail_main ,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::event_al'	,MapEvent	            ,write_fail_event,,,pOverwrite);
		
	mapAL:= sequential(   if(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
											  // ,Corp2_Raw_AL.Build_Bases(filedate,version,pUseProd).All // Determined that Build Bases is not needed 
												,main_out
												,event_out
												,ar_out
												,stock_out										
												,IF(Main_FailBuild <> true or Event_FailBuild <> true
												  	,sequential( fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::ar'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_AL')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::event',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_AL')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_AL')																		 
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::stock',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_AL')
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
														,mapAL
														,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('Corp2_Mapping.AL failed.  An invalid filedate was passed in as a parameter.')))); 	

 End; //Update Function

End;//End AL Module