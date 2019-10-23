import ut,  std, corp2, corp2_raw_fl, corp2_mapping,  versioncontrol,scrubs,scrubs_corp2_mapping_fltm_main, Tools;

export FLTM := MODULE;  
	  		
	 export Update(string fileDate,string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, boolean pUseProd = Tools._Constants.IsDataland) := function			
		
		state_origin			 := 'FL'; 
		state_fips	 			 := '12';	
		state_desc	 			 := 'FLORIDA';		
		
		// Vendor Input File
	  TMFile := dedup(sort(distribute(Corp2_Raw_FL.Files(filedate,pUseProd).Input.TMFile.logical,hash(tm_number)),record,local),record,local) : independent;
		
 
		//--------- Begin CORPS Mapping --------------------------------------------------------------//	
		
		// Normalize on the two legal name fields:  tm_name and tm_x_name
		Corp2_Raw_FL.Layouts.normTMLayout1 normalizeTM1(Corp2_Raw_FL.Layouts.TMFileLayoutIN l, unsigned1 cnt) := transform	
		          ,skip(cnt=2 and corp2.t2u(l.TM_X_NAME) = '')
			self.normLegalName	:= choose(cnt, l.TM_NAME, l.TM_X_NAME);			
			self.normType       := choose(cnt, '03', 'I');
			self 						  	:= l;
		end;
		
		normTMFile1	:= normalize(tmFile, 2, normalizeTM1(left, counter));
		
		// Normalize on the three corp_filing_date fields:  tm_date_filed, tm_1st_date, tm_1st_fla_date
		// In Phase 2 of the Re-Corp Project, we can remove this normalize and only use tm_date_filed for
		// corp_filing_date.  We need to leave this in place for now until new fields are visible to customers.
		Corp2_Raw_FL.Layouts.normTMLayout1 normDates(Corp2_Raw_FL.Layouts.normTMLayout1 l, unsigned1 cnt) := transform	
		          ,skip((cnt=2 and Corp2_Mapping.fValidateDate(l.tm_1st_date,'MMDDCCYY').PastDate = '') or
							      (cnt=3 and Corp2_Mapping.fValidateDate(l.tm_1st_fla_date,'MMDDCCYY').PastDate = ''))
			self.normFilDt	    := choose(cnt, l.tm_date_filed, l.tm_1st_date, l.tm_1st_fla_date);			
			self.normFilTyp     := choose(cnt, '','FIRST USED ANYWHERE', 'FIRST USED IN FLORIDA');
			self 						  	:= l;
		end;
		
		normTMFile2	:= normalize(normTMFile1, 3, normDates(left, counter));
		
		Corp2_Mapping.LayoutsCommon.Main corpTrf(Corp2_Raw_FL.Layouts.normTMLayout1 input) := transform
			self.corp_key						                    := state_fips + '-' + corp2.t2u(input.tm_number);		
			self.corp_vendor					                  := state_fips;		
			self.corp_state_origin			                := state_origin;
			self.corp_inc_state				                  := state_origin;
			self.dt_vendor_first_reported	              := (integer)fileDate;
			self.dt_vendor_last_reported	              := (integer)fileDate;
			self.dt_first_seen				                  := (integer)fileDate;
			self.dt_last_seen				                    := (integer)fileDate;
			self.corp_ra_dt_first_seen		              := (integer)fileDate;
			self.corp_ra_dt_last_seen		                := (integer)fileDate;
			self.corp_process_date			                := fileDate;
			self.corp_orig_sos_charter_nbr              := corp2.t2u(input.tm_number);				
			self.corp_legal_name				                := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.normLegalName).BusinessName;	
			self.corp_ln_name_type_cd			              := corp2.t2u(input.normType);
			self.corp_ln_name_type_desc		              := if (corp2.t2u(input.normType) = '03', 'TRADEMARK', 'OTHER');
			self.corp_trademark_status                  := corp2.t2u(input.tm_status);
			self.corp_status_cd                         := if (corp2.t2u(input.tm_status) in ['A','I']
																												,corp2.t2u(input.tm_status) ,''); // now mapped in new field, corp_trademark_status 
			self.corp_status_desc                       := case (self.corp_trademark_status,'I' => 'INACTIVE', 'A' => 'ACTIVE', '');
			self.corp_entity_desc                       := corp2.t2u(input.tm_used_1) + ' ' + corp2.t2u(input.tm_used_2) + ' ' +	
																										 corp2.t2u(input.tm_used_3); // now mapped in new fields but retaining in new mapper	
			self.corp_trademark_disclaimer1             := corp2.t2u(input.tm_disclaimer_1);
			self.corp_trademark_disclaimer2             := corp2.t2u(input.tm_disclaimer_2);
			self.corp_trademark_used_1                  := corp2.t2u(input.tm_used_1);
			self.corp_trademark_used_2                  := corp2.t2u(input.tm_used_2);
		  // corp_term_exist_cd, _desc, _exp now being mapped in new fields but retaining in new mapper
			self.corp_term_exist_cd											:= if(Corp2_Mapping.fValidateDate(input.tm_ep_date,'MMDDCCYY').GeneralDate <> ''
																												,'D', '');	
			self.corp_term_exist_desc     							:= if (self.corp_term_exist_cd = 'D' ,'EXPIRATION DATE' ,'');																	 
			self.corp_term_exist_exp										:= Corp2_Mapping.fValidateDate(input.tm_ep_date,'MMDDCCYY').GeneralDate;													   														 						
			self.corp_trademark_expiration_date         := Corp2_Mapping.fValidateDate(input.tm_ep_date,'MMDDCCYY').GeneralDate;													   														 						
			self.corp_filing_date												:= Corp2_Mapping.fValidateDate(input.normFilDt,'MMDDCCYY').PastDate; 	
			self.corp_filing_desc                       := input.normFilTyp;
			self.corp_trademark_filing_date             := Corp2_Mapping.fValidateDate(input.tm_date_filed,'MMDDCCYY').PastDate;
		  self.corp_trademark_first_use_date          := Corp2_Mapping.fValidateDate(input.tm_1st_date,'MMDDCCYY').PastDate;
  		self.corp_trademark_first_use_date_in_state := Corp2_Mapping.fValidateDate(input.tm_1st_fla_date,'MMDDCCYY').PastDate;
			self.corp_trademark_class_desc1 						:= 'TYPE/CLASS'                                 
																											+ Corp2_Raw_FL.Functions.getTypeClass(input.tm_class_type_01, input.tm_class_01)
																											+ Corp2_Raw_FL.Functions.getTypeClass(input.tm_class_type_02, input.tm_class_02)
																											+ Corp2_Raw_FL.Functions.getTypeClass(input.tm_class_type_03, input.tm_class_03)
																											+ Corp2_Raw_FL.Functions.getTypeClass(input.tm_class_type_04, input.tm_class_04)
																											+ Corp2_Raw_FL.Functions.getTypeClass(input.tm_class_type_05, input.tm_class_05)
																											+ Corp2_Raw_FL.Functions.getTypeClass(input.tm_class_type_06, input.tm_class_06)
																											+ Corp2_Raw_FL.Functions.getTypeClass(input.tm_class_type_07, input.tm_class_07)
																											+ Corp2_Raw_FL.Functions.getTypeClass(input.tm_class_type_08, input.tm_class_08)
																											+ Corp2_Raw_FL.Functions.getTypeClass(input.tm_class_type_09, input.tm_class_09)
																											+ Corp2_Raw_FL.Functions.getTypeClass(input.tm_class_type_10, input.tm_class_10)
																											+ Corp2_Raw_FL.Functions.getTypeClass(input.tm_class_type_11, input.tm_class_11)
																											+ Corp2_Raw_FL.Functions.getTypeClass(input.tm_class_type_12, input.tm_class_12)
																											+ Corp2_Raw_FL.Functions.getTypeClass(input.tm_class_type_13, input.tm_class_13)
																											+ Corp2_Raw_FL.Functions.getTypeClass(input.tm_class_type_14, input.tm_class_14)
																											+ Corp2_Raw_FL.Functions.getTypeClass(input.tm_class_type_15, input.tm_class_15)
																											+ Corp2_Raw_FL.Functions.getTypeClass(input.tm_class_type_16, input.tm_class_16)
																											+ Corp2_Raw_FL.Functions.getTypeClass(input.tm_class_type_17, input.tm_class_17)
																											+ Corp2_Raw_FL.Functions.getTypeClass(input.tm_class_type_18, input.tm_class_18)
																											+ Corp2_Raw_FL.Functions.getTypeClass(input.tm_class_type_19, input.tm_class_19)
																											+ Corp2_Raw_FL.Functions.getTypeClass(input.tm_class_type_20, input.tm_class_20);
							
	    //corp_addl_info is now being mapped in new fields, but retaining in new mapper                                     
			disclaim   := if(corp2.t2u(input.tm_disclaimer_1 +input.tm_disclaimer_2) <> ''
											,'; DISCLAIMER FOR: ' + corp2.t2u(input.tm_disclaimer_1 +	input.tm_disclaimer_2)
											,'');													  
			self.corp_addl_info					               := self.corp_trademark_class_desc1 + disclaim;																									
			self.recordOrigin                          := 'C';
			self 								                       := [];					
		end; 	
		
		mapCorp		  := project(normTMFile2, corpTrf(left));
		
		mapAllCorp  := sort(distribute(mapCorp,hash(corp_key)),corp_key,local) : independent;
	//----------End CORPS Mapping -------------------------------------------------------------------//	
		
		
	//--------- Begin CONTACTS Mapping --------------------------------------------------------------//	
	// Normalize on fields from the TM File
	
		Corp2_Raw_FL.Layouts.normTMLayout normalizeTM(Corp2_Raw_FL.Layouts.TMFileLayoutIN l, unsigned1 cnt) := transform
		     ,skip((cnt=1 and corp2.t2u(l.TM_PRINCE_DOC_NUMBER_01 + l.TM_PRINCE_NAME_01 + l.TM_PRINCE_MAIL_ADD1_01 + 
																		l.TM_PRINCE_MAIL_ADD2_01 + l.TM_PRINCE_MAIL_CITY_01 + l.TM_PRINCE_MAIL_STATE_01 + 
																		l.TM_PRINCE_MAIL_ZIP_01) = '') or
							 (cnt=2 and corp2.t2u(l.TM_PRINCE_DOC_NUMBER_02 + l.TM_PRINCE_NAME_02 + l.TM_PRINCE_MAIL_ADD1_02 + 
																		l.TM_PRINCE_MAIL_ADD2_02 + l.TM_PRINCE_MAIL_CITY_02 + l.TM_PRINCE_MAIL_STATE_02 + 
																		l.TM_PRINCE_MAIL_ZIP_02) = '') or										
							 (cnt=3 and corp2.t2u(l.TM_PRINCE_DOC_NUMBER_03 + l.TM_PRINCE_NAME_03 + l.TM_PRINCE_MAIL_ADD1_03 + 
																		l.TM_PRINCE_MAIL_ADD2_03 + l.TM_PRINCE_MAIL_CITY_03 + l.TM_PRINCE_MAIL_STATE_03 + 
																		l.TM_PRINCE_MAIL_ZIP_03) = '') or		
							 (cnt=4 and corp2.t2u(l.TM_PRINCE_DOC_NUMBER_04 + l.TM_PRINCE_NAME_04 + l.TM_PRINCE_MAIL_ADD1_04 + 
																		l.TM_PRINCE_MAIL_ADD2_04 + l.TM_PRINCE_MAIL_CITY_04 + l.TM_PRINCE_MAIL_STATE_04 + 
																		l.TM_PRINCE_MAIL_ZIP_04) = '') or
							 (cnt=5 and corp2.t2u(l.TM_PRINCE_DOC_NUMBER_05 + l.TM_PRINCE_NAME_05 + l.TM_PRINCE_MAIL_ADD1_05 + 
																		l.TM_PRINCE_MAIL_ADD2_05 + l.TM_PRINCE_MAIL_CITY_05 + l.TM_PRINCE_MAIL_STATE_05 + 
																		l.TM_PRINCE_MAIL_ZIP_05) = '') or	
							 (cnt=6 and corp2.t2u(l.TM_PRINCE_DOC_NUMBER_06 + l.TM_PRINCE_NAME_06 + l.TM_PRINCE_MAIL_ADD1_06 + 
																		l.TM_PRINCE_MAIL_ADD2_06 + l.TM_PRINCE_MAIL_CITY_06 + l.TM_PRINCE_MAIL_STATE_06 + 
																		l.TM_PRINCE_MAIL_ZIP_06) = '') )														
		 self.normDOC_NUMBER	:= choose(cnt, l.TM_PRINCE_DOC_NUMBER_01, l.TM_PRINCE_DOC_NUMBER_02,
												                 l.TM_PRINCE_DOC_NUMBER_03, l.TM_PRINCE_DOC_NUMBER_04,
												                 l.TM_PRINCE_DOC_NUMBER_05, l.TM_PRINCE_DOC_NUMBER_06);			
			self.normNAME	    	:= choose(cnt, l.TM_PRINCE_NAME_01,       l.TM_PRINCE_NAME_02,
												                 l.TM_PRINCE_NAME_03,       l.TM_PRINCE_NAME_04,
												                 l.TM_PRINCE_NAME_05,       l.TM_PRINCE_NAME_06);
			self.normADD1   		:= choose(cnt, l.TM_PRINCE_MAIL_ADD1_01,  l.TM_PRINCE_MAIL_ADD1_02,
												                 l.TM_PRINCE_MAIL_ADD1_03,  l.TM_PRINCE_MAIL_ADD1_04,
												                 l.TM_PRINCE_MAIL_ADD1_05,  l.TM_PRINCE_MAIL_ADD1_06);
			self.normADD2		    := choose(cnt, l.TM_PRINCE_MAIL_ADD2_01,  l.TM_PRINCE_MAIL_ADD2_02,
												                 l.TM_PRINCE_MAIL_ADD2_03,  l.TM_PRINCE_MAIL_ADD2_04,
												                 l.TM_PRINCE_MAIL_ADD2_05,  l.TM_PRINCE_MAIL_ADD2_06);
			self.normCITY		    := choose(cnt, l.TM_PRINCE_MAIL_CITY_01,  l.TM_PRINCE_MAIL_CITY_02,
												                 l.TM_PRINCE_MAIL_CITY_03,  l.TM_PRINCE_MAIL_CITY_04,
												                 l.TM_PRINCE_MAIL_CITY_05,  l.TM_PRINCE_MAIL_CITY_06);
			self.normSTATE		  := choose(cnt, l.TM_PRINCE_MAIL_STATE_01, l.TM_PRINCE_MAIL_STATE_02,
												                 l.TM_PRINCE_MAIL_STATE_03, l.TM_PRINCE_MAIL_STATE_04,
												                 l.TM_PRINCE_MAIL_STATE_05, l.TM_PRINCE_MAIL_STATE_06);	
			self.normZIP		  	:= choose(cnt, l.TM_PRINCE_MAIL_ZIP_01,   l.TM_PRINCE_MAIL_ZIP_02,
												                 l.TM_PRINCE_MAIL_ZIP_03,   l.TM_PRINCE_MAIL_ZIP_04,
												                 l.TM_PRINCE_MAIL_ZIP_05,   l.TM_PRINCE_MAIL_ZIP_06);
			self 						  	:= l;
		end;
		
		normTMFile	:= normalize(tmFile, 6, normalizeTM(left, counter));
	       			
		Corp2_Mapping.LayoutsCommon.Main contTransform(normTMFile input) := transform
								,SKIP(corp2.t2u(input.normNAME)='')
			self.corp_key						       := state_fips + '-' + corp2.t2u(input.tm_number);		
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
			self.corp_orig_sos_charter_nbr := corp2.t2u(input.tm_number);				
			self.corp_legal_name				   := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.tm_name).BusinessName;			
			self.cont_type_cd					     := 'O';
      self.cont_type_desc					   := 'OWNER';																		
			self.cont_full_name					   := corp2.t2u(input.normNAME);		
			self.cont_addl_info            := if(corp2.t2u(input.normDOC_NUMBER) <> ''
																					 ,'CORPORATION OWNS TRADEMARK ' + corp2.t2u(input.normDOC_NUMBER)
																					 ,'');
			self.cont_address_type_cd      := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.normADD1,input.normADD2,input.normCITY,input.normSTATE,input.normZIP).ifAddressExists, 'M', '');			
			self.cont_address_type_desc    := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.normADD1,input.normADD2,input.normCITY,input.normSTATE,input.normZIP).ifAddressExists, 'MAILING', '');
			self.cont_address_line1			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.normADD1,input.normADD2,input.normCITY,input.normSTATE,input.normZIP).AddressLine1;
			self.cont_address_line2			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.normADD1,input.normADD2,input.normCITY,input.normSTATE,input.normZIP).AddressLine2;
			self.cont_address_line3			   := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.normADD1,input.normADD2,input.normCITY,input.normSTATE,input.normZIP).AddressLine3;
			self.cont_prep_addr_line1			 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.normADD1,input.normADD2,input.normCITY,input.normSTATE,input.normZIP).PrepAddrLine1;
			self.cont_prep_addr_last_line	 := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.normADD1,input.normADD2,input.normCITY,input.normSTATE,input.normZIP).PrepAddrLastLine;
			self.recordOrigin              := 'T';
			self 								           := [];						
		end;	
			
		mapCont		:= project(normTMFile, contTransform(left));		
		//--------------------- End CONTACTS Mapping --------------------------------------------------//
		
		//--------- Begin EVENTS Mapping --------------------------------------------------------------//			
		Corp2_Mapping.LayoutsCommon.Events EventTransform(Corp2_Raw_FL.Layouts.TMFileLayoutIN input):=transform
							,SKIP(corp2.t2u(input.tm_last_event_code) not in ['CORAMEXP','CORAMCANNP','CORAPAMND','CORAPCANTM','CORAPTMASG','CORAPTMONC','CORAPTMREN'] AND
							      Corp2_Mapping.fValidateDate(input.tm_last_event_filed_date,'MMDDCCYY').PastDate = '')
			self.corp_key						  := state_fips + '-' + corp2.t2u(input.tm_number);		
			self.corp_vendor					:= state_fips;		
			self.corp_state_origin		:= state_origin;
			self.corp_process_date		:= fileDate;
			self.corp_sos_charter_nbr := corp2.t2u(input.tm_number);		
			self.event_filing_cd      := corp2.t2u(input.tm_last_event_code);
			self.event_filing_desc		:= case(corp2.t2u(input.tm_last_event_code),
																				'CORAMEXP'   => 'TRADEMARK EXPIRATION',								
																		    'CORAMCANNP' => 'TRADEMARK CANCELLATION NON PAYMENT',									
																		    'CORAPAMND'  => 'TRADEMARK AMENDMENT',									
																		    'CORAPCANTM' => 'TRADEMARK CANCELLATION',									
																		    'CORAPTMASG' => 'TRADEMARK ASSIGNMENT',	
																		    'CORAPTMONC' => 'TRADEMARK OWNER NAME CHANGE',
																		    'CORAPTMREN' => 'TRADEMARK RENEWAL',								
																			  '');	
   		self.event_filing_date		:= Corp2_Mapping.fValidateDate(input.tm_last_event_filed_date,'MMDDCCYY').PastDate;	
			self.event_date_type_cd   := if (self.event_filing_date <> '', 'FIL', '');
			self.event_date_type_desc := if (self.event_filing_date <> '', 'FILING', '');
     	self								      := [];
		end;
	  //--------------------- End EVENTS Mapping --------------------------------------------------//

		
	//-----------------------------------------------------------//
	// Build the Final Mapped Files
	//-----------------------------------------------------------//
		mapMain  := dedup(sort(distribute(mapAllCorp + mapCont,hash(corp_key)), record,local), record,local) : independent;
		mapEvent := dedup(sort(distribute(project(tmFile, EventTransform(left)),hash(corp_key)), record,local), record,local) : independent;	

 		
	//--------------------------------------------------------------------	
  // Scrubs for MAIN
  //--------------------------------------------------------------------
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_FLTM_Main.Scrubs;      // Scrubs module
		Main_N := Main_S.FromNone(Main_F); 										// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     	// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_FLTM'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_FLTM'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_FLTM'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_FLTM_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);

    //Submits Profile's stats to Orbit
    Main_SubmitStats          := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_FLTM_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_FLTM_Main').SubmitStats;

		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_FLTM_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_FLTM_Main').CompareToProfile_with_Examples;
		
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.AttachedList
																																	 ,'Scrubs CorpMain_FLTM Report' //subject
																																	 ,'Scrubs CorpMain_FLTM Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpFLTMMainScrubsReport.csv'
																																	);		
																																 
		Main_BadRecords := Main_T.ExpandedInFile(	corp_key_invalid 			             						 <> 0 or
																							corp_orig_sos_charter_nbr_invalid  						 <> 0 or
																							corp_legal_name_invalid 			     						 <> 0 or
																							dt_first_seen_invalid 			       						 <> 0 or
																							dt_last_seen_invalid 			         						 <> 0 or
																							corp_process_date_invalid 			   						 <> 0 or
																							corp_ra_dt_first_seen_invalid 		 						 <> 0 or
																							corp_ra_dt_last_seen_invalid 			 						 <> 0 or
																							dt_vendor_first_reported_invalid 	 						 <> 0 or
																							dt_vendor_last_reported_invalid 	 						 <> 0 or
																							corp_trademark_expiration_date_invalid 				 <> 0 or
																							corp_trademark_filing_date_invalid     				 <> 0 or
																							corp_trademark_first_use_date_invalid          <> 0 or
																							corp_trademark_first_use_date_in_state_invalid <> 0 or
																							corp_vendor_invalid 			         						 <> 0 or
																							corp_state_origin_invalid 			   						 <> 0 or
																							corp_inc_state_invalid 			       						 <> 0 or
																							corp_trademark_status_invalid     						 <> 0 );

		Main_GoodRecords	:= Main_T.ExpandedInFile( corp_key_invalid 			             						 = 0 and
																								corp_orig_sos_charter_nbr_invalid  						 = 0 and
																								corp_legal_name_invalid 			     						 = 0 and
																								dt_first_seen_invalid 			       						 = 0 and
																								dt_last_seen_invalid 			         						 = 0 and
																								corp_process_date_invalid 			   						 = 0 and
																								corp_ra_dt_first_seen_invalid 		 						 = 0 and
																								corp_ra_dt_last_seen_invalid 			 						 = 0 and
																								dt_vendor_first_reported_invalid 	 						 = 0 and
																								dt_vendor_last_reported_invalid 	 						 = 0 and
																								corp_trademark_expiration_date_invalid 				 = 0 and
																								corp_trademark_filing_date_invalid     				 = 0 and
																								corp_trademark_first_use_date_invalid          = 0 and
																								corp_trademark_first_use_date_in_state_invalid = 0 and
																								corp_vendor_invalid 			         						 = 0 and
																								corp_state_origin_invalid 			   						 = 0 and
																								corp_inc_state_invalid 			       						 = 0 and
																								corp_trademark_status_invalid     						 = 0 );																												 																	
		
		Main_FailBuild	:= map(corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_FLTM_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),					 count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_FLTM_Main.Threshold_Percent.CORP_LEGAL_NAME 					=> true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),						     count(Main_N.ExpandedInFile),false) > Scrubs_Corp2_Mapping_FLTM_Main.Threshold_Percent.CORP_KEY      						=> true,
													 count(Main_GoodRecords) = 0																																																																																				            => true,
													 false );

		Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
	
		Main_RejFile_Exists		:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);			
	  Main_ALL		 					:= sequential(IF(count(Main_BadRecords) <> 0
																					,IF (poverwrite
																							,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_FLTM',overwrite,__compressed__,named('Sample_Rejected_MainRecs_FLTM'+filedate))
																							,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																													 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_FLTM'+filedate)))))
																		,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainFLTMScrubsReportWithExamples'+filedate))																		
																		//Send Alerts if Scrubs exceeds thresholds
																		,IF(COUNT(Main_ScrubsAlert) > 0, Main_SendEmailFile, OUTPUT('CORP2_MAPPING.FLTM - No "MAIN" Corp Scrubs Alerts'))
																		,Main_ErrorSummary
																		,Main_ScrubErrorReport
																		,Main_SomeErrorValues
																		,Main_SubmitStats);
							 
	
 //-------------------- Version Control -----------------------------------------------------//	
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::main_fltm'			,Main_ApprovedRecords ,main_out		     ,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event_fltm'			,MapEvent             ,event_out	     ,,,pOverwrite);
	
	VersionControl.macBuildNewLogicalFile('~thor_data400::failed::corp2::'+version+'::main_fltm'	,MapMain              ,write_fail_main ,,,pOverwrite);		
		
	mapFLTM:= sequential(   if(pshouldspray = true,Corp2_mapping.fSprayFiles('FLTM',version,pOverwrite := pOverwrite))
											  // ,Corp2_Raw_FL.Build_Bases_FLTM(filedate,version,pUseProd).All
												,main_out
												,event_out
												,IF(Main_FailBuild <> true 
														,sequential( fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::event',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_FLTM')
																				,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_FLTM')																		 
																				,if (count(Main_BadRecords) <> 0  
																						 ,Corp2_Mapping.Send_Email('FLTM',version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),,count(mapEvent)).RecordsRejected																				 
																						 ,Corp2_Mapping.Send_Email('FLTM',version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),,count(mapEvent)).MappingSuccess																				 
																						 )	 
																			)
														 ,sequential( write_fail_main//if it fails on  main file threshold ,still writing mapped files!
																				 ,Corp2_Mapping.Send_Email('FLTM',version).MappingFailed
																				)
													)
												,if (Main_IsScrubErrors
													  ,Corp2_Mapping.Send_Email('FLTM' ,version,Main_IsScrubErrors).FieldsInvalidPerScrubs)
												,Main_All	
										);
		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-180) and ut.date_math(filedate,180),true,false);
		return sequential (if (isFileDateValid
														,mapFLTM
														,sequential (Corp2_Mapping.Send_Email('FLTM',filedate).InvalidFileDateParm
																		     ,FAIL('Corp2_Mapping.FLTM failed.  An invalid filedate was passed in as a parameter.')))); 														
																								
 End; //Update Function

End;//End FLTM Module	