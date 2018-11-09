Import _Control, Corp2, Corp2_Raw_NM, Scrubs, Scrubs_Corp2_Mapping_NM_Main, STD, Tools, UT, VersionControl;

Export NM 	:= Module 

	Export Update(String filedate, string version, boolean pShouldSpray = Corp2_mapping._Dataset().bShouldSpray, boolean pOverwrite = false, pUseProd = Tools._Constants.IsDataland) := FUNCTION

		state_origin 	:= 'NM';
		state_fips	 	:= '35';	
		state_desc	 	:= 'NEW MEXICO';

		MasterFile		:= sort(distribute(Corp2_Raw_NM.Files(filedate,puseprod).Input.ImportMaster.Logical,hash(BusinessNumber)),BusinessNumber,local) : independent;

		Corp2_Mapping.LayoutsCommon.Main corpTransform(Corp2_Raw_NM.Layouts.ImportMasterLayoutIn l):= transform
			self.dt_vendor_first_reported		 	:= (integer)fileDate;
			self.dt_vendor_last_reported		 	:= (integer)fileDate;
			self.dt_first_seen							 	:= (integer)fileDate;
			self.dt_last_seen								 	:= (integer)fileDate;
			self.corp_ra_dt_first_seen			 	:= (integer)fileDate;
			self.corp_ra_dt_last_seen				 	:= (integer)fileDate;		
			self.corp_key										 	:= state_fips + '-' + Corp2.t2u(l.BusinessNumber);
			self.corp_vendor								 	:= state_fips;
			self.corp_state_origin						:= state_origin;
			self.corp_process_date					 	:= fileDate;
			self.corp_orig_sos_charter_nbr	 	:= Corp2.t2u(l.BusinessNumber);
			self.corp_inc_state								:= state_origin;
			self.corp_orig_org_structure_desc	:= Corp2_Raw_NM.Functions.CorpOrigOrgStructureDesc(l.BusinessType);
			self.corp_foreign_domestic_ind  	:= Corp2_Raw_NM.Functions.CorpForeignDomesticInd(l.BusinessType);
			self.corp_for_profit_ind					:= Corp2_Raw_NM.Functions.CorpForProfitInd(l.BusinessType);
			self.corp_status_desc						 	:= Corp2.t2u(l.BusinessStatus);
			self.corp_legal_name              := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.Corp_Name).BusinessName;		
			self.corp_ln_name_type_cd				 	:= '01';
			self.corp_ln_name_type_desc			 	:= 'LEGAL';
			self.corp_inc_date							  := if(Corp2_Raw_NM.Functions.CorpForeignDomesticInd(l.BusinessType) not in ['F'],
																							Corp2_Mapping.fValidateDate(l.DateOfIncorporation,'MM/DD/CCYY').PastDate,
																							'');
			self.corp_forgn_date							:= if(Corp2_Raw_NM.Functions.CorpForeignDomesticInd(l.BusinessType) in ['F'],
																							Corp2_Mapping.fValidateDate(l.DateOfIncorporation,'MM/DD/CCYY').PastDate,
																							'');				
			self.corp_ra_full_name            := Corp2_Raw_NM.Functions.CorpRAFullName(state_origin,state_desc,l.BusinessAgentName);
			self.corp_ra_address_type_cd			:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.AddressLine1,l.AddressLine2,l.City,l.StateCode,l.Zip).ifAddressExists,'R','');				
			self.corp_ra_address_type_desc		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.AddressLine1,l.AddressLine2,l.City,l.StateCode,l.Zip).ifAddressExists,'REGISTERED OFFICE','');
			self.corp_ra_address_line1			 	:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.AddressLine1,l.AddressLine2,l.City,l.StateCode,l.Zip,l.Country).AddressLine1;
			self.corp_ra_address_line2			 	:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.AddressLine1,l.AddressLine2,l.City,l.StateCode,l.Zip,l.Country).AddressLine2;
			self.corp_ra_address_line3				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.AddressLine1,l.AddressLine2,l.City,l.StateCode,l.Zip,l.Country).AddressLine3;
			self.ra_prep_addr_line1						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.AddressLine1,l.AddressLine2,l.City,l.StateCode,l.Zip,l.Country).PrepAddrLine1;
			self.ra_prep_addr_last_line				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.AddressLine1,l.AddressLine2,l.City,l.StateCode,l.Zip,l.Country).PrepAddrLastLine;
			self.corp_agent_country           := Corp2.t2u(l.Country);
			self.recordorigin									:= 'C';
			self													  	:= [];
		End;

		mapCorp									:= project(MasterFile, corpTransform(LEFT));
		mapMain   							:= dedup(sort(distribute(mapCorp,hash(corp_key)),record,local),record,local) : independent;

		//=============================================SCRUB LOGIC====================================================

		Main_F 									:= mapMain;
		Main_S 									:= Scrubs_Corp2_Mapping_NM_Main.Scrubs;						  // NM scrubs module
		Main_N 									:= Main_S.FromNone(Main_F); 											 // Generate the error flags
		Main_T 									:= Main_S.FromBits(Main_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U 									:= Main_S.FromExpanded(Main_N.ExpandedInFile); 	 // Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary				:= output(Main_U.SummaryStats, named('Main_ErrorSummary_NM'+filedate));
		Main_ScrubErrorReport 	:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_NM'+filedate));
		Main_SomeErrorValues		:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_NM'+filedate));
		Main_IsScrubErrors		 	:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats					:= Main_U.OrbitStats();
		//Outputs files
		Main_CreateBitMaps			:= output(Main_N.BitmapInfile,,'~thor_data::corp_nm_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap		:= output(Main_T);
		//Creates Profile's alert template for Orbit - can be copied and imported into Orbit; Only required if rules in Orbit change
		Main_AlertsCSVTemplate		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NM_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_NM_Main').ProfileAlertsTemplate;
		//Submits Profile's stats to Orbit
		Main_SubmitStats 			  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NM_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_NM_Main').SubmitStats;
		Main_ScrubsWithExamples := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_NM_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_NM_Main').CompareToProfile_with_Examples;

		Main_ScrubsAlert				:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment		:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile						:= FileServices.SendEmailAttachData( Corp2.Email_Notification_Lists.spray
																																 ,'Scrubs Corp_NM Report'  //subject
																																 ,'Scrubs Corp_NM Report' //body
																																 ,(data)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpNMMainScrubsReport.csv'
																																 ,
																																 ,
																																 ,Corp2.Email_Notification_Lists.spray
																															);

		Main_BadRecords					:= Main_N.ExpandedInFile(	dt_vendor_first_reported_Invalid 			<> 0 or
																											dt_vendor_last_reported_Invalid 			<> 0 or
																											dt_first_seen_Invalid 								<> 0 or
																											dt_last_seen_Invalid 									<> 0 or
																											corp_ra_dt_first_seen_Invalid 				<> 0 or
																											corp_ra_dt_last_seen_Invalid 					<> 0 or
																											corp_key_Invalid 											<> 0 or
																											corp_vendor_Invalid 									<> 0 or
																											corp_state_origin_Invalid 					 	<> 0 or
																											corp_process_date_Invalid						  <> 0 or
																											corp_orig_sos_charter_nbr_Invalid 		<> 0 or
																											corp_legal_name_Invalid 							<> 0 or
																											corp_ln_name_type_cd_Invalid 					<> 0 or
																											corp_ln_name_type_desc_Invalid 				<> 0 or
																											corp_status_desc_invalid							<> 0 or
																											corp_inc_state_Invalid 								<> 0 or
																											corp_inc_date_Invalid 								<> 0 or
																											corp_forgn_date_Invalid 							<> 0 or
																											corp_foreign_domestic_ind_Invalid 		<> 0 or
																											corp_orig_org_structure_desc_Invalid 	<> 0 or
																											corp_for_profit_ind_Invalid						<> 0 or 
																											recordorigin_Invalid 								  <> 0 
																								 );
																																									
		Main_GoodRecords				:= Main_N.ExpandedInFile(	dt_vendor_first_reported_Invalid 			= 0 and
																											dt_vendor_last_reported_Invalid 			= 0 and
																											dt_first_seen_Invalid 								= 0 and
																											dt_last_seen_Invalid 									= 0 and
																											corp_ra_dt_first_seen_Invalid 				= 0 and
																											corp_ra_dt_last_seen_Invalid 					= 0 and
																											corp_key_Invalid 											= 0 and
																											corp_vendor_Invalid 									= 0 and
																											corp_state_origin_Invalid 						= 0 and
																											corp_process_date_Invalid						  = 0 and
																											corp_orig_sos_charter_nbr_Invalid 		= 0 and
																											corp_legal_name_Invalid 							= 0 and
																											corp_ln_name_type_cd_Invalid 					= 0 and
																											corp_ln_name_type_desc_Invalid 				= 0 and
																											corp_status_desc_invalid							= 0 and
																											corp_inc_state_Invalid 								= 0 and
																											corp_inc_date_Invalid 								= 0 and
																											corp_forgn_date_Invalid 							= 0 and
																											corp_foreign_domestic_ind_Invalid 		= 0 and
																											corp_orig_org_structure_desc_Invalid 	= 0	and
																											corp_for_profit_ind_Invalid						= 0 and 
																											recordorigin_Invalid 								  = 0 
																									);

		Main_FailBuild					:= map( Corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 											> Scrubs_Corp2_Mapping_NM_Main.Threshold_Percent.CORP_KEY										 	=> true,
																		Corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 		> Scrubs_Corp2_Mapping_NM_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 	=> true,
																		Corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_ln_name_type_cd_invalid<>0)),count(Main_N.ExpandedInFile),false) 					> Scrubs_Corp2_Mapping_NM_Main.Threshold_Percent.CORP_LN_NAME_TYPE_CD		  	 	=> true,
																		Corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_ln_name_type_desc_invalid<>0)),count(Main_N.ExpandedInFile),false) 				> Scrubs_Corp2_Mapping_NM_Main.Threshold_Percent.CORP_LN_NAME_TYPE_DESC 		 	=> true,
																		Corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 							> Scrubs_Corp2_Mapping_NM_Main.Threshold_Percent.CORP_LEGAL_NAME 						 	=> true,
																		Corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_inc_date_invalid<>0)),count(Main_N.ExpandedInFile),false) 								> Scrubs_Corp2_Mapping_NM_Main.Threshold_Percent.CORP_INC_DATE 						 	 	=> true,
																		Corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_org_structure_desc_invalid<>0)),count(Main_N.ExpandedInFile),false)	> Scrubs_Corp2_Mapping_NM_Main.Threshold_Percent.CORP_ORIG_ORG_STRUCTURE_DESC	=> true,
																		Corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_for_profit_ind_Invalid<>0)),count(Main_N.ExpandedInFile),false)						> Scrubs_Corp2_Mapping_NM_Main.Threshold_Percent.CORP_FOR_PROFIT_IND					=> true,
																		Corp2_mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_foreign_domestic_ind_invalid<>0)),count(Main_N.ExpandedInFile),false) 		> Scrubs_Corp2_Mapping_NM_Main.Threshold_Percent.CORP_FOREIGN_DOMESTIC_IND   	=> true,
																		count(Main_GoodRecords) = 0																																																																																											 		=> true,																		
																		false
																);

		Main_ApprovedRecords		:= project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));

		Main_ALL		 						:= sequential( IF(count(Main_BadRecords) <> 0
																							,IF (poverwrite
																									 ,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::Corp2::'+version+'::rejected::main_'+state_origin,overwrite,__compressed__)
																									 ,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::Corp2::'+version+'::rejected::main_'+state_origin,__compressed__)
																									)
																						 )
																				,output(Main_ScrubsWithExamples, all, named('CorpMainNMScrubsReportWithExamples'+filedate))
																				//Send Alerts if Scrubs exceeds thresholds
																				,IF(COUNT(Main_ScrubsAlert) > 0, Main_MailFile, OUTPUT('Corp2_MAPPING.NM - No "MAIN" Corp Scrubs Alerts'))
																				,Main_ErrorSummary
																				,Main_ScrubErrorReport
																				,Main_SomeErrorValues		
																				//,Main_AlertsCSVTemplate
																				,Main_SubmitStats
																			);
																		
		//==========================================VERSION CONTROL====================================================
		Fail_Build						:= Main_FailBuild;
		IsScrubErrors					:= Main_IsScrubErrors;

		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::Corp2::'+version+'::main_'+state_origin,Main_ApprovedRecords,write_main,,,pOverwrite);			
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._Dataset().thor_cluster_Files + 'fail::Corp2::'+version+'::main_'+state_origin,Main_F,write_fail,,,pOverwrite);			
													
		mapNM									:= sequential ( IF(pshouldspray = true,Corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
																				 // ,Corp2_Raw_NM.Build_Bases(filedate,version,puseprod).All
																				 ,Main_All
																				 ,IF(Fail_Build <> true	 
																						,sequential (	write_main
																												 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::main',Corp2_Mapping._Dataset().thor_cluster_Files 	+ 'in::Corp2::'+version+'::main_' + state_origin)																		 
																												 ,IF (count(Main_BadRecords) <> 0
																														  ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,false,false,false,count(Main_BadRecords),,,,count(Main_ApprovedRecords),,,).RecordsRejected																				 
																														  ,Corp2_Mapping.Send_Email(state_origin,version,count(Main_BadRecords)<>0,false,false,false,count(Main_BadRecords),,,,count(Main_ApprovedRecords),,,).MappingSuccess																				 
																														 )
																												 ,IF (IsScrubErrors
																														  ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,false,false,false).FieldsInvalidPerScrubs
																														 )
																												 )																				
																						,sequential ( write_fail
																												 ,Corp2_Mapping.Send_Email(state_origin,version).MappingFailed
																												)
																						)
																				);																

		isFileDateValid := if((string)std.date.today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);
		
		return sequential ( if (isFileDateValid
														,mapNM
														,sequential(Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																				,FAIL('Corp2_Mapping.'+state_origin+' failed.  An invalid filedate was passed in as a parameter.')
																			 )
   													)
   										 );

	End;  //  Update Function 

End; // NM Module