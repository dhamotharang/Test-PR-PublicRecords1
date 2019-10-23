Import ut, std, corp2, tools, versioncontrol, Scrubs, Corp2_Raw_NJ, Scrubs_Corp2_Mapping_NJ_Main;

export NJ := MODULE 

export Update(string fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray, boolean pOverwrite = false, boolean pUseProd = Tools._Constants.IsDataland) := function
	  
	// Vendor Input Data File	
	MainInFile    := dedup(sort(distribute(Corp2_Raw_NJ.Files(filedate,pUseProd).Input.PipeDelim,hash(business_id)),record,local), record,local) : independent;
																						 
	state_origin  := 'NJ';
	state_fips	  := '34';	 
	state_desc	  := 'NEW JERSEY';		
	
	corp2_Mapping.LayoutsCommon.Main trfMain(Corp2_Raw_NJ.Layouts.BusinessLayoutIn  input):= transform
			self.dt_vendor_first_reported		 := (integer)fileDate;
			self.dt_vendor_last_reported		 := (integer)fileDate;
			self.dt_first_seen							 := (integer)fileDate;
			self.dt_last_seen								 := (integer)fileDate;
			self.corp_ra_dt_first_seen			 := (integer)fileDate;
			self.corp_ra_dt_last_seen				 := (integer)fileDate;
			self.corp_key										 := state_fips + '-' + (string) intformat((integer)input.business_id,10,1);
			self.corp_vendor								 := state_fips;
			self.corp_state_origin					 := state_origin;
			self.corp_process_date					 := fileDate;
			self.corp_orig_sos_charter_nbr	 := (string) intformat((integer)input.business_id,10,1);
			self.corp_legal_name						 := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,input.business_name).BusinessName;
			self.corp_ln_name_type_cd				 := '01';
			self.corp_ln_name_type_desc			 := 'LEGAL';
			self.corp_status_cd				    	 := corp2.t2u(input.status);
			self.corp_status_desc						 := Corp2_Raw_NJ.Functions.GetStatusDesc(input.status);
			self.corp_inc_state 						 := state_origin;
			self.corp_inc_date							 := if (corp2.t2u(input.statedomicile) in [state_origin,'']
																							,Corp2_Mapping.fValidateDate(input.filing_date).PastDate ,'');  
			self.corp_forgn_date						 := if (corp2.t2u(input.statedomicile) not in [state_origin,''] 
																							,Corp2_Mapping.fValidateDate(input.filing_date).PastDate ,'');																				
			self.corp_foreign_domestic_ind   := map(corp2.t2u(input.typecode) in ['AUT','DP','GP','LLC','LLP','LP','NJR','NP','PA'] => 'D',
																					    corp2.t2u(input.typecode) in ['DB','FGP','FLC','FLP','FR','LF','NF']            => 'F',
																					    '');
			self.corp_forgn_state_cd 				 := if (corp2.t2u(input.statedomicile) <> state_origin
																						 ,Corp2_Raw_NJ.Functions.Get_State(input.statedomicile),'');
			self.corp_forgn_state_desc       := Corp2_Raw_NJ.Functions.decode_state(self.corp_forgn_state_cd);
		
			self.corp_orig_org_structure_cd  := corp2.t2u(input.typecode);
			self.corp_orig_org_structure_desc := Corp2_Raw_NJ.Functions.GetStructureDesc(input.typecode);
			self.corp_for_profit_ind         := map(corp2.t2u(input.typecode) in ['DP','FR'] => 'Y',
																					    corp2.t2u(input.typecode) in ['NF','NP'] => 'N',
																					    '');
			self.corp_ra_full_name					 := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,corp2.t2u(input.registered_agent)).BusinessName;
																	
			self.corp_address1_type_cd       := if (Corp2_Mapping.fAddressExists (state_origin,state_desc,input.main_business_address,input.main_business_address2,input.main_business_city,input.main_business_state,input.main_business_zip + input.main_business_zip_ext).ifAddressExists,'B','');	
			self.corp_address1_type_desc     := if (Corp2_Mapping.fAddressExists (state_origin,state_desc,input.main_business_address,input.main_business_address2,input.main_business_city,input.main_business_state,input.main_business_zip + input.main_business_zip_ext).ifAddressExists,'BUSINESS','');
			self.corp_address1_line1				 := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.main_business_address,input.main_business_address2,input.main_business_city,input.main_business_state,input.main_business_zip + input.main_business_zip_ext).AddressLine1;
			self.corp_address1_line2				 := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.main_business_address,input.main_business_address2,input.main_business_city,input.main_business_state,input.main_business_zip + input.main_business_zip_ext).AddressLine2;
			self.corp_address1_line3				 := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.main_business_address,input.main_business_address2,input.main_business_city,input.main_business_state,input.main_business_zip + input.main_business_zip_ext).AddressLine3;			
			self.corp_prep_addr1_line1			 := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.main_business_address,input.main_business_address2,input.main_business_city,input.main_business_state,input.main_business_zip).PrepAddrLine1;			
			self.corp_prep_addr1_last_line	 := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.main_business_address,input.main_business_address2,input.main_business_city,input.main_business_state,input.main_business_zip).PrepAddrLastLine;
		
		  self.corp_ra_address_type_cd     := if (Corp2_Mapping.fAddressExists (state_origin,state_desc,input.registered_office_address,input.registered_office_address2,input.registered_office_city,input.registered_office_state,input.registered_office_zip + input.registered_office_zip_ext).ifAddressExists,'R','');			
		  self.corp_ra_address_type_desc   := if (Corp2_Mapping.fAddressExists (state_origin,state_desc,input.registered_office_address,input.registered_office_address2,input.registered_office_city,input.registered_office_state,input.registered_office_zip + input.registered_office_zip_ext).ifAddressExists,'REGISTERED OFFICE','');			
			self.corp_ra_address_line1			 := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.registered_office_address,input.registered_office_address2,input.registered_office_city,input.registered_office_state,input.registered_office_zip + input.registered_office_zip_ext).AddressLine1;
			self.corp_ra_address_line2			 := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.registered_office_address,input.registered_office_address2,input.registered_office_city,input.registered_office_state,input.registered_office_zip + input.registered_office_zip_ext).AddressLine2;
			self.corp_ra_address_line3			 := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.registered_office_address,input.registered_office_address2,input.registered_office_city,input.registered_office_state,input.registered_office_zip + input.registered_office_zip_ext).AddressLine3;			
			self.RA_prep_addr_line1				   := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.registered_office_address,input.registered_office_address2,input.registered_office_city,input.registered_office_state,input.registered_office_zip).PrepAddrLine1;			
			self.RA_prep_addr_last_line	     := Corp2_Mapping.fCleanAddress (state_origin,state_desc,input.registered_office_address,input.registered_office_address2,input.registered_office_city,input.registered_office_state,input.registered_office_zip).PrepAddrLastLine;
																		
		  self.recordOrigin                := 'C';  
			self														 := [];

	end;//end of NJ corp transform

	//-----------------------------------------------------------//
	// Build the Final Mapped File
	//-----------------------------------------------------------//
  MapCorp := project(MainInFile, trfMain(left));	
	MapMain := dedup(sort(distribute(MapCorp,hash(corp_key)),record,local),record,local) : independent;

	//======================SCRUBS LOGIC=====================================
		Main_F := MapMain;
		Main_S := Scrubs_Corp2_Mapping_NJ_Main.Scrubs;        // NJ scrubs module
		Main_N := Main_S.FromNone(Main_F); 									  // Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     	// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

	//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_NJ'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_NJ'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_NJ'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_NJ_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);
	
    //Submits Profile's stats to Orbit
    Main_SubmitStats          := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NJ_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_NJ_Main').SubmitStats;
	
	  Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NJ_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_NJ_Main').CompareToProfile_with_Examples;
		
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.AttachedList
																																	 ,'Scrubs CorpMain_NJ Report' //subject
																																	 ,'Scrubs CorpMain_NJ Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpNJMainScrubsReport.csv'
																																);
																															
		Main_BadRecords := Main_N.ExpandedInFile(	dt_vendor_first_reported_invalid	   <> 0 or
																							dt_vendor_last_reported_invalid		   <> 0 or
																							dt_first_seen_invalid							   <> 0 or
																							dt_last_seen_invalid							   <> 0 or
																							corp_ra_dt_first_seen_invalid			   <> 0 or
																							corp_ra_dt_last_seen_invalid			   <> 0 or
																							corp_key_invalid									   <> 0 or
																							corp_vendor_invalid								   <> 0 or
																							corp_state_origin_invalid					   <> 0 or
																							corp_process_date_invalid					   <> 0 or
																							corp_orig_sos_charter_nbr_invalid	   <> 0 or
																							corp_legal_name_invalid						   <> 0 or
																							corp_ln_name_type_cd_invalid			   <> 0 or
																							corp_ln_name_type_desc_invalid		   <> 0 or
																							corp_address1_line3_invalid          <> 0 or
																							corp_status_cd_invalid						   <> 0 or
																							corp_status_desc_invalid             <> 0 or
																							corp_inc_state_invalid						   <> 0 or
																							corp_inc_date_invalid							   <> 0 or
																							corp_foreign_domestic_ind_invalid	   <> 0 or
																							corp_forgn_date_invalid              <> 0 or
																							corp_forgn_state_cd_invalid          <> 0 or
																							corp_orig_org_structure_cd_invalid   <> 0 or
																							corp_orig_org_structure_desc_invalid <> 0 or
																							corp_for_profit_ind_invalid				   <> 0 or
																							corp_ra_full_name_invalid					   <> 0 or
																							corp_ra_address_line3_invalid        <> 0 );

		Main_GoodRecords	:= Main_N.ExpandedInFile( dt_vendor_first_reported_invalid     = 0 and
																								dt_vendor_last_reported_invalid	     = 0 and
																								dt_first_seen_invalid						     = 0 and
																								dt_last_seen_invalid						     = 0 and
																								corp_ra_dt_first_seen_invalid		     = 0 and
																								corp_ra_dt_last_seen_invalid			   = 0 and
																								corp_key_invalid									   = 0 and
																								corp_vendor_invalid								   = 0 and
																								corp_state_origin_invalid					   = 0 and
																								corp_process_date_invalid					   = 0 and
																								corp_orig_sos_charter_nbr_invalid	   = 0 and
																								corp_legal_name_invalid						   = 0 and
																								corp_ln_name_type_cd_invalid			   = 0 and
																								corp_ln_name_type_desc_invalid		   = 0 and
																								corp_address1_line3_invalid          = 0 and
																								corp_status_cd_invalid						   = 0 and
																								corp_status_desc_invalid             = 0 and
																								corp_inc_state_invalid						   = 0 and
																								corp_inc_date_invalid							   = 0 and
																								corp_foreign_domestic_ind_invalid	   = 0 and
																								corp_forgn_date_invalid              = 0 and
																								corp_forgn_state_cd_invalid          = 0 and
																								corp_orig_org_structure_cd_invalid   = 0 and
																								corp_orig_org_structure_desc_invalid = 0 and
																								corp_for_profit_ind_invalid				   = 0 and
																								corp_ra_full_name_invalid					   = 0 and
																								corp_ra_address_line3_invalid        = 0 );																											 																	
                       
		Main_FailBuild	:= map(corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 									 > Scrubs_Corp2_Mapping_NJ_Main.Threshold_Percent.CORP_KEY										 => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false)   > Scrubs_Corp2_Mapping_NJ_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_ln_name_type_cd_invalid<>0)),count(Main_N.ExpandedInFile),false) 			 > Scrubs_Corp2_Mapping_NJ_Main.Threshold_Percent.CORP_LN_NAME_TYPE_CD		  	 => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_ln_name_type_desc_invalid<>0)),count(Main_N.ExpandedInFile),false) 		 > Scrubs_Corp2_Mapping_NJ_Main.Threshold_Percent.CORP_LN_NAME_TYPE_DESC 		   => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 					   > Scrubs_Corp2_Mapping_NJ_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_status_cd_invalid<>0)),count(Main_N.ExpandedInFile),false) 						 > Scrubs_Corp2_Mapping_NJ_Main.Threshold_Percent.CORP_STATUS_CD 						   => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_inc_date_invalid<>0)),count(Main_N.ExpandedInFile),false) 						   > Scrubs_Corp2_Mapping_NJ_Main.Threshold_Percent.CORP_INC_DATE					 	 	   => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_forgn_date_invalid<>0)),count(Main_N.ExpandedInFile),false) 						 > Scrubs_Corp2_Mapping_NJ_Main.Threshold_Percent.CORP_FORGN_DATE 					 	 => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_org_structure_cd_invalid<>0)),count(Main_N.ExpandedInFile),false)  > Scrubs_Corp2_Mapping_NJ_Main.Threshold_Percent.CORP_ORIG_ORG_STRUCTURE_CD   => true,
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_org_structure_desc_invalid<>0)),count(Main_N.ExpandedInFile),false)> Scrubs_Corp2_Mapping_NJ_Main.Threshold_Percent.CORP_ORIG_ORG_STRUCTURE_DESC => true,	
													 corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_ra_full_name_invalid<>0)),count(Main_N.ExpandedInFile),false)		       > Scrubs_Corp2_Mapping_NJ_Main.Threshold_Percent.CORP_RA_FULL_NAME 					 => true,
													 count(Main_GoodRecords) = 0																																																																																									     => true,										 
													 false );

		Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
		
  //==========================================VERSION CONTROL====================================================
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_nj',Main_ApprovedRecords,corp_out,,,pOverwrite);			
  	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._Dataset().thor_cluster_Files + 'failed::corp2::'+version+'::main_nj',MapMain,write_fail_main,,,pOverwrite);
	
	  Main_RejFile_Exists		:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_nj'),true,false);																											 
		
		mapNJ := sequential(	IF( pshouldspray = TRUE,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
														 	// When testing on dataland, comment out Build_Bases due to it needing to read in
												      // the pipe-delimited version of the input files.
															// ,Corp2_Raw_NJ.Build_Bases(filedate,version).All // Determined build bases is not needed
															,corp_out
															,IF(Main_FailBuild <> true
																	,sequential( fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_nj')
																							 ,IF (count(Main_BadRecords) <> 0
																									 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,false,false,false,count(Main_BadRecords),,,,count(Main_ApprovedRecords),,,).RecordsRejected																				 
																									 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,false,false,false,count(Main_BadRecords),,,,count(Main_ApprovedRecords),,,).MappingSuccess	))   
									 								 ,sequential( write_fail_main
																							 ,Corp2_Mapping.Send_Email(state_origin ,version).MappingFailed )	)			
																,IF(count(Main_BadRecords) <> 0
																		,IF ( poverwrite
																					,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,overwrite,__compressed__,named('Sample_Rejected_Recs_NJ'+filedate))
																					,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																												OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_Recs_NJ'+filedate))))
																	 )
															 ,IF(Main_IsScrubErrors
																	 ,Corp2_Mapping.Send_Email(state_origin ,version,Main_IsScrubErrors,false,false,false).FieldsInvalidPerScrubs	)	
																,IF(COUNT(Main_ScrubsAlert) > 0, 	Main_SendEmailFile, OUTPUT('CORP2_MAPPING.NJ - No Corp Scrubs Alerts_NJ'))		
																,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainNJScrubsReportWithExamples'+filedate)) //Send Alerts if Scrubs exceeds thresholds
																,Main_ErrorSummary
																,Main_ScrubErrorReport																					
																,Main_SomeErrorValues		
																,Main_SubmitStats
															);
				
		isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-35) and ut.date_math(filedate,35),true,false);
		return sequential (	 if (isFileDateValid
														,mapNJ
														,sequential (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('Corp2_Mapping.NJ failed.  An invalid filedate was passed in as a parameter.')
																				)
														)
											);
 End;  // Update Function 

End; // NJ Module 		
