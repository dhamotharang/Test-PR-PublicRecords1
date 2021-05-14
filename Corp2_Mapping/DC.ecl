Import _Control, Corp2, Corp2_Raw_DC, lib_stringlib, Scrubs, Scrubs_Corp2_Mapping_DC_Main, Tools, UT, VersionControl, std;

Export DC 	:= Module
	
   Export Update(String filedate, string version, boolean pShouldSpray = Corp2_mapping._Dataset().bShouldSpray, boolean pOverwrite = false,pUseProd = Tools._Constants.IsDataland) := Function
	  
		state_origin					:= 'DC' ;
		state_fips	 					:= '11';
		state_desc	 					:= 'DISTRICT OF COLUMBIA';
		MasterFile  					:= dedup(sort(distribute(corp2_raw_dc.files(filedate,pUseProd).Input.Corporation.Logical,hash(corp2.t2u(FileNumber))),record,local),record,local) : independent;
	
	  domestic_list					:= ['FOR-PROFIT BENEFIT CORPORATION DOMESTIC FOR-PROFIT','FOR-PROFIT CORPORATION DOMESTIC FOR-PROFIT',
															'FOR-PROFIT CORPORATION DOMESTIC FOR-PROFIT PROFESSIONAL','FOR-PROFIT CORPORATION DOMESTIC',
															'GENERAL COOPERATIVE ASSOCIATION DOMESTIC','GENERAL PARTNERSHIP DOMESTIC','LIABILITY COMPANY DOMESTIC',
															'LIMITED COOPERATIVE ASSOCIATION DOMESTIC','LIMITED LIABILITY COMPANY DOMESTIC',
															'LIMITED LIABILITY COMPANY DOMESTIC FOR-PROFIT','LIMITED LIABILITY PARTNERSHIP DOMESTIC',
															'LIMITED PARTNERSHIP DOMESTIC','NON-PROFIT CORPORATION DOMESTIC','NAME RESERVATION DOMESTIC',
															'NAME RESERVATION DOMESTIC NON-PROFIT','PROFESSIONAL LIMITED LIABILITY COMPANY DOMESTIC',
															'PROFESSIONAL LIMITED LIABILITY COMPANY DOMESTIC PROFESSIONAL','STATUTORY TRUST DOMESTIC',
															'TRADE NAME DOMESTIC'];
															
		foreign_list					:= ['ACT OF CONGRESS CORPORATION FOREIGN','ACT OF CONGRESS CORPORATION FOREIGN NON-PROFIT',
															'FOR-PROFIT CORPORATION FOREIGN','FOR-PROFIT CORPORATION FOREIGN FOR-PROFIT',
															'FOR-PROFIT CORPORATION FOREIGN FOR-PROFIT PROFESSIONAL',
															'GENERAL COOPERATIVE ASSOCIATION FOREIGN','LIMITED LIABILITY COMPANY FOREIGN',
															'LIMITED LIABILITY COMPANY FOREIGN FOR-PROFIT','LIMITED LIABILITY PARTNERSHIP FOREIGN',
															'LIMITED PARTNERSHIP FOREIGN','NON-PROFIT CORPORATION FOREIGN','NON-PROFIT CORPORATION FOREIGN NON-PROFIT',
															'NONREGISTERED NONFILING ENTITY NONE','NAME RESERVATION FOREIGN' ];
															
		profit_list 					:= ['ACT OF CONGRESS CORPORATION FOREIGN NON-PROFIT','FOR-PROFIT BENEFIT CORPORATION DOMESTIC FOR-PROFIT',
															'FOR-PROFIT CORPORATION DOMESTIC FOR-PROFIT','FOR-PROFIT CORPORATION DOMESTIC FOR-PROFIT PROFESSIONAL',
															'FOR-PROFIT CORPORATION DOMESTIC','FOR-PROFIT CORPORATION FOREIGN','FOR-PROFIT CORPORATION FOREIGN FOR-PROFIT',
															'FOR-PROFIT CORPORATION FOREIGN FOR-PROFIT PROFESSIONAL','LIMITED LIABILITY COMPANY DOMESTIC FOR-PROFIT',
															'LIMITED LIABILITY COMPANY FOREIGN FOR-PROFIT' ];
															
		Nonprofit_list				:= ['NON-PROFIT CORPORATION DOMESTIC', 'NON-PROFIT CORPORATION FOREIGN','NON-PROFIT CORPORATION FOREIGN NON-PROFIT',
		                          'NAME RESERVATION DOMESTIC NON-PROFIT'];	
															
		Reserv_list           := ['NAME RESERVATION DOMESTIC','NAME RESERVATION DOMESTIC NON-PROFIT','NAME RESERVATION FOREIGN'];
		
		Corp2_Mapping.LayoutsCommon.Main DC_corpTransform(Corp2_Raw_DC.Layouts.CorporationsLayoutIn L):= transform 
		
				st_code                           := Corp2_Raw_DC.Functions.fGetStateCode(L.StateOfFormation);// When we have invalid values or new values in raw data !this function will return '**',We can reject those records through Scrubs for further investigation
				state_upper												:= corp2.t2u(l.StateOfFormation);	
				Country_upper      								:= corp2.t2u(l.CountryofFormation);
				Country_desc 											:= Corp2_Mapping.fCleanCountry(state_origin,state_desc,'',Country_upper).Country; 	//Corp2_Mapping.fCleanCountry  return 'US' when we pass along with blank country name , state_origin and state_desc			
				EntityType_upper                  := corp2.t2u(L.EntityType);
				fix_Date             							:= Corp2_Mapping.fValidateDate(l.RegistrationDate, 'MM/DD/YY').PastDate;				
				self.dt_vendor_first_reported		 	:= (integer)fileDate;
				self.dt_vendor_last_reported		 	:= (integer)fileDate;
				self.dt_first_seen							 	:= (integer)fileDate;
				self.dt_last_seen								 	:= (integer)fileDate;
				self.corp_ra_dt_first_seen			 	:= (integer)fileDate;
				self.corp_ra_dt_last_seen				 	:= (integer)fileDate;					
				self.corp_process_date					  := fileDate;
				self.corp_key										  := state_fips+'-'+ corp2.t2u(L.FileNumber);
				self.corp_vendor								  := state_fips ;
				self.corp_state_origin					  := state_origin ;				
				self.corp_inc_state				 				:= state_origin ;
				self.corp_orig_sos_charter_nbr	  := corp2.t2u(L.FileNumber);
				self.corp_legal_name						  := Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,L.EntityName).BusinessName;					
				self.corp_ln_name_type_cd				  := map(EntityType_upper = 'TRADE NAME DOMESTIC'=>'04',
				                                         EntityType_upper in Reserv_list         =>'07',
																								 '01');													   
				self.corp_ln_name_type_desc		    := map(EntityType_upper = 'TRADE NAME DOMESTIC'=> 'TRADE NAME',
				                                         EntityType_upper in Reserv_list         => 'RESERVED',
																								 'LEGAL');																							
				self.corp_status_desc							:= corp2.t2u(L.EntityStatus);
				self.corp_orig_org_structure_desc := if(EntityType_upper = 'TRADE NAME DOMESTIC','',Corp2_Raw_DC.Functions.CorpOrigOrgStructDesc(L.EntityType));
				self.corp_foreign_domestic_ind    := map(EntityType_upper in domestic_list 		  																									 =>'D',
																								 EntityType_upper in foreign_list 						 																						 =>'F',
																								 EntityType_upper = 'NONREGISTERED NONFILING ENTITY NONE' and Country_desc not in['','US'] =>'F'
																								 ,''); 
				self.corp_for_profit_ind          := map(EntityType_upper in profit_list		=>'Y',
																								 EntityType_upper in Nonprofit_list	=>'N',
																								 '');				
				self.corp_inc_date								:= map(st_code in [state_origin ,''] and EntityType_upper not in foreign_list => fix_Date,
																								 EntityType_upper in domestic_list   									                  => fix_Date,
																								 '');
				self.corp_forgn_date							:= map(st_code not in[state_origin ,'','**']	 => fix_Date,
																								 EntityType_upper  in foreign_list       => fix_Date,
																								 Country_desc not in['','US']						 => fix_Date,
																								 '');
				Self.corp_forgn_state_CD 	 				:=if(st_code <> state_origin ,st_code,'');
				Self.corp_forgn_state_desc 	 			:=if(Self.corp_forgn_state_CD <>'',state_upper,If(Country_desc<>'US', Country_desc,'' ));
				//**** Parsing out business addresses!! We are receiving all address parts in one single field from vendor ex:12007 BERRYBROOK TERRACE, UPPER MARLBOR, Maryland 20772 
				Bus_Addr													:=Stringlib.Splitwords(Corp2_Raw_DC.Functions.fGetBusAddress(state_origin,state_desc,l.BusinessAddress),'|',false);
				Self.corp_address1_line1          :=Corp2_Mapping.fCleanAddress(state_origin,state_desc,Bus_Addr[1] ,'',Bus_Addr[2],Bus_Addr[3],Bus_Addr[4]).AddressLine1;
				Self.corp_address1_line2          :=Corp2_Mapping.fCleanAddress(state_origin,state_desc,Bus_Addr[1] ,'',Bus_Addr[2],Bus_Addr[3],Bus_Addr[4]).AddressLine2;
				Self.corp_address1_line3          :=Corp2_Mapping.fCleanAddress(state_origin,state_desc,Bus_Addr[1] ,'',Bus_Addr[2],Bus_Addr[3],Bus_Addr[4]).AddressLine3;
				self.corp_prep_addr1_line1				:=Corp2_Mapping.fCleanAddress(state_origin,state_desc,Bus_Addr[1] ,'',Bus_Addr[2],Bus_Addr[3],Bus_Addr[4]).PrepAddrLine1;
				self.corp_prep_addr1_last_line		:=Corp2_Mapping.fCleanAddress(state_origin,state_desc,Bus_Addr[1] ,'',Bus_Addr[2],Bus_Addr[3],Bus_Addr[4]).PrepAddrLastLine;
				self.corp_address1_type_cd        :=if(Corp2_Mapping.fAddressExists(state_origin,state_desc,Bus_Addr[1] ,'',Bus_Addr[2],Bus_Addr[3],Bus_Addr[4]).ifAddressExists,
																							 'B','');
				self.corp_address1_type_desc      := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,Bus_Addr[1] ,'',Bus_Addr[2],Bus_Addr[3],Bus_Addr[4]).ifAddressExists,
																								'BUSINESS','');
				//**** We are receiving ra_name & corresponding address info in one single "RegisteredAgent" field from vendor .RaName & corresponding address is separated by '|' Ex:GABRIELA MAGLIONE|2027 ALLEN PL NW, WASHINGTON, District of Columbia 20009
				RANameAddr												:= Stringlib.Splitwords(Corp2_Raw_DC.Functions.fGetNameAddress(state_origin,state_desc,l.RegisteredAgent),'|',false);
				self.corp_ra_full_name						:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,RANameaddr[1]).BusinessName;	
				self.corp_ra_address_line1        := Corp2_Mapping.fCleanAddress(state_origin,state_desc,RANameaddr[2] ,'',RANameaddr[3],RANameaddr[4],RANameaddr[5]).AddressLine1;
				self.corp_ra_address_line2				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,RANameaddr[2] ,'',RANameaddr[3],RANameaddr[4],RANameaddr[5]).AddressLine2;
				self.corp_ra_address_line3				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,RANameaddr[2] ,'',RANameaddr[3],RANameaddr[4],RANameaddr[5]).AddressLine3;
				self.ra_prep_addr_line1						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,RANameaddr[2] ,'',RANameaddr[3],RANameaddr[4],RANameaddr[5]).PrepAddrLine1;
				self.ra_prep_addr_last_line				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,RANameaddr[2] ,'',RANameaddr[3],RANameaddr[4],RANameaddr[5]).PrepAddrLastLine;
				self.corp_ra_address_type_cd		  := if(Corp2_Mapping.fAddressExists(state_origin,state_desc,RANameaddr[2] ,'',RANameaddr[3],RANameaddr[4],RANameaddr[5]).ifAddressExists ,'R','');
				self.corp_ra_address_type_desc		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,RANameaddr[2] ,'',RANameaddr[3],RANameaddr[4],RANameaddr[5]).ifAddressExists ,'REGISTERED OFFICE'	,'');									 
				self.corp_country_of_formation		:= Country_desc;
				self.recordorigin									:= 'C';
				Self 															:= [];
				
		End;
		
		mapCorp		:= project(MasterFile, DC_corpTransform(LEFT));
		mapMain   := dedup(sort(distribute(mapCorp,hash(corp_key)),record,local),record,local) : independent;
		//=============================================SCRUB LOGIC====================================================
		
    Main_F 										:= mapMain;
		Main_S 										:= Scrubs_Corp2_Mapping_DC_Main.Scrubs;					  // Scrubs module
		Main_N 										:= Main_S.FromNone(Main_F); 										 // Generate the error flags
		Main_T 										:= Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U 										:= Main_S.FromExpanded(Main_N.ExpandedInFile); // Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_DC_'+filedate));
		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_DC_'+filedate));
		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_DC_'+filedate));
		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();
		//Outputs files
		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_DC_main_scrubs_bits',overwrite,compressed);	//long term storage
		Main_TranslateBitMap			:= output(Main_T);
		
		
	  //Creates Profile's alert template for Orbit - can be copied and imported into Orbit; Only required if rules in Orbit change
		Main_AlertsCSVTemplate		:= Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').ProfileAlertsTemplate;
		//Submits Profile's stats to Orbit
		Main_SubmitStats 			  	:= Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').SubmitStats;
		Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStatsPost310('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').CompareToProfile_with_Examples;
		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.AttachedList
																																	 ,'Scrubs CorpMain_DC Report' //subject
																																	 ,'Scrubs CorpMain_DC Report' //body
																																	 ,(data)Main_ScrubsAttachment
																																	 ,'text/csv'
																																	 ,'CorpDCMainScrubsReport.csv'
																																);

			Main_BadRecords		  := Main_N.ExpandedInFile(	dt_vendor_first_reported_Invalid 			<> 0 or
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
																										corp_inc_state_Invalid 								<> 0 or
																										corp_foreign_domestic_ind_Invalid 		<> 0 or
																										corp_forgn_state_cd_Invalid         	<> 0 or 
																										corp_orig_org_structure_desc_Invalid  <> 0																										
																								 );
																										 																	
		Main_GoodRecords		:=Main_N.ExpandedInFile(  dt_vendor_first_reported_Invalid 			= 0 and
																									dt_vendor_last_reported_Invalid 			= 0 and
																									dt_first_seen_Invalid 								= 0 and
																									dt_last_seen_Invalid 									= 0 and
																									corp_ra_dt_first_seen_Invalid 				= 0 and
																									corp_ra_dt_last_seen_Invalid 					= 0 and
																									corp_key_Invalid 											= 0 and
																									corp_vendor_Invalid 									= 0 and
																									corp_state_origin_Invalid 					 	= 0 and
																									corp_process_date_Invalid						  = 0 and
																									corp_orig_sos_charter_nbr_Invalid 		= 0 and
																									corp_legal_name_Invalid 							= 0 and
																									corp_ln_name_type_cd_Invalid 					= 0 and
																									corp_ln_name_type_desc_Invalid 				= 0 and
																									corp_inc_state_Invalid 								= 0 and
																									corp_foreign_domestic_ind_Invalid 		= 0 and
																									corp_forgn_state_cd_Invalid         	= 0 and
																									corp_orig_org_structure_desc_Invalid  = 0
																						  );
		
		Main_FailBuild	:= map( Corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_dc_Main.Threshold_Percent.CORP_KEY										            => true,
														Corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_dc_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	            => true,
														Corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_ln_name_type_cd_invalid<>0)),count(Main_N.ExpandedInFile),false) 				> Scrubs_Corp2_Mapping_dc_Main.Threshold_Percent.CORP_LN_NAME_TYPE_CD		  	            => true,
														Corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_ln_name_type_desc_invalid<>0)),count(Main_N.ExpandedInFile),false) 			> Scrubs_Corp2_Mapping_dc_Main.Threshold_Percent.CORP_LN_NAME_TYPE_DESC 		            => true,
														Corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_dc_Main.Threshold_Percent.CORP_LEGAL_NAME 						            => true,
														Corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_foreign_domestic_ind_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_dc_Main.Threshold_Percent.CORP_FOREIGN_DOMESTIC_IND     					=> true,
														Corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_forgn_state_cd_invalid<>0)),count(Main_N.ExpandedInFile),false) 				> Scrubs_Corp2_Mapping_dc_Main.Threshold_Percent.corp_forgn_state_cd   			   				  => true,
														Corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_org_structure_desc_Invalid<>0)),count(Main_N.ExpandedInFile),false)> Scrubs_Corp2_Mapping_dc_Main.Threshold_Percent.corp_orig_org_structure_desc						=> true,																		
														count(Main_GoodRecords) = 0																																																																																											 						=> true,																		
														false
												  );

		Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
		
	  //==========================================VERSION CONTROL====================================================
		
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_dc',Main_ApprovedRecords,corp_out,,,pOverwrite);			
		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::Main_'+ state_origin	,Main_F	 ,write_fail_main  ,,,pOverwrite); 
   
	  Main_RejFile_Exists		:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);																											 
		
		run_Main := 	sequential(	IF( pshouldspray = TRUE,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
														  // ,corp2_raw_dc.Build_Bases(filedate,version,pUseProd).All  // Determined building of bases is not needed
															,corp_out
															,IF(Main_FailBuild <> true
																	,sequential(
																							fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_dc')
																							,IF ( count(Main_BadRecords) <> 0
																											 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,false,false,false,count(Main_BadRecords),,,,count(Main_ApprovedRecords),,,).RecordsRejected																				 
																											 ,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,false,false,false,count(Main_BadRecords),,,,count(Main_ApprovedRecords),,,).MappingSuccess																				
																										)
																							,IF(Main_IsScrubErrors
																									,Corp2_Mapping.Send_Email(state_origin ,version,Main_IsScrubErrors,false,false,false).FieldsInvalidPerScrubs																				 
																									)				
																						)   
																	 ,sequential( write_fail_main
																							 ,Corp2_Mapping.Send_Email(state_origin ,version).MappingFailed
																							 )
																	)				
																,IF(count(Main_BadRecords) <> 0
																		,IF ( poverwrite
																					,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,overwrite,__compressed__,named('Sample_Rejected_Recs_DC_'+filedate))
																					,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																												OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_Recs_DC_'+filedate))
																											)
																				)
																	 )
																,IF(COUNT(Main_ScrubsAlert) > 0, 	Main_SendEmailFile, OUTPUT('CORP2_MAPPING.DC - No Corp Scrubs Alerts_DC'))		
																,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainDCScrubsReportWithExamples'+filedate)) //Send Alerts if Scrubs exceeds thresholds
																,Main_ErrorSummary
																,Main_ScrubErrorReport																					
																,Main_SomeErrorValues
																//,Main_AlertsCSVTemplate
																,Main_SubmitStats
															);	
															
			//Validating the filedate entered is within 120 days	
			isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-120) and ut.date_math(filedate,120),true,false);												
  		result		 			:= if (isFileDateValid
   														,run_Main 
   														,sequential (Corp2_Mapping.Send_Email(state_origin ,filedate).InvalidFileDateParm
   																				 ,FAIL('Corp2_Mapping.DC failed .An invalid filedate was passed in as a parameter.')
   																				 )
         										  );



		return result;

 End;  // Update Function 

End; //  DC Module 