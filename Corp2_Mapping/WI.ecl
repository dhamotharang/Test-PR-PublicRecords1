Import _Control, Corp2, Corp2_Raw_WI, Scrubs, Scrubs_Corp2_Mapping_WI_Main, Tools, UT, VersionControl, std;

Export WI 	:= Module

	Export Update(String filedate, string version, boolean pShouldSpray = Corp2_mapping._Dataset().bShouldSpray, boolean pOverwrite = false,pUseProd = Tools._Constants.IsDataland) := Function
		
		state_origin			:= 'WI'; 
		state_fips	 			:= '55';	
		state_desc	 			:= 'WISCONSIN';
		
		ds_raw_comfichex	:= dedup(sort(distribute(Corp2_Raw_WI.Files(filedate,pUseProd).input.ComfichexFixed,hash(org_id)),record,local),record,local) : independent;

		Corp2_Mapping.LayoutsCommon.Main corpTransform(Corp2_Raw_WI.Layouts.fullLine_Layout input) := transform
		
			setForgnTypes 												:= ['02','08','13','15','16','18','90'];
			self.dt_vendor_first_reported		 	  	:= (integer)fileDate;
			self.dt_vendor_last_reported		 	  	:= (integer)fileDate;
			self.dt_first_seen							 	  	:= (integer)fileDate;
			self.dt_last_seen								 	  	:= (integer)fileDate;
			self.corp_ra_dt_first_seen			 	 	 	:= (integer)fileDate;
			self.corp_ra_dt_last_seen				 	  	:= (integer)fileDate;	
			self.corp_process_date			  				:= fileDate;
			self.corp_key													:= state_fips + '-' + corp2.t2u(input.org_id);
			self.corp_vendor											:= state_fips ;
			self.corp_state_origin								:= state_origin ;
			self.corp_orig_sos_charter_nbr				:= corp2.t2u(input.org_id);
			self.corp_legal_name									:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,input.org_name).BusinessName; 														
			self.corp_ln_name_type_cd							:= map(corp2.t2u(input.current_status) in['CMC','CNF','TER']=>'I'	,
																									 corp2.t2u(input.current_status) in['PND','RES','RLT']=>'07',
																									 corp2.t2u(input.current_status) in['RGL','RGD']			=>'09',
																									 corp2.t2u(input.current_status)not in['CMC','CNF','PND','RES','RLT','RGL','RGD','TER']=>'01',
																									 corp2.t2u(input.current_status)
																									 );							   
			self.corp_ln_name_type_desc						:= map(corp2.t2u(input.current_status) in['CMC','CNF','TER']=>'OTHER'	,
																									 corp2.t2u(input.current_status) in['PND','RES','RLT']=>'RESERVED',
																									 corp2.t2u(input.current_status) in['RGL','RGD']			=>'REGISTRATION',
																									 corp2.t2u(input.current_status)not in['CMC','CNF','PND','RES','RLT','RGL','RGD','TER']=>'LEGAL',
																									 '');	
			self.corp_name_status_cd            	:= if(corp2.t2u(input.current_status) in['CMC','CNF','DNP','EXP','PND','RES','RGL','RLT','TER'],corp2.t2u(input.current_status),'');
 			self.Corp_Name_Status_Desc						:= Corp2_Raw_WI.Functions.fGetNameStatus_desc(input.current_status);
			self.corp_orig_org_structure_cd       := if(trim(input.org_type,left,right) not in ['90','98','96','L:','S:','TY'],trim(input.org_type,left,right),'');
			self.corp_orig_org_structure_desc     := Corp2_Raw_WI.Functions.fGetOrg_structure_desc(self.corp_orig_org_structure_cd);
			self.corp_status_cd									  := corp2.t2u(input.current_status);
			self.corp_status_desc								  := Corp2_Raw_WI.Functions.fGetStatus_desc(input.current_status);
			self.corp_status_date                 := Corp2_Mapping.fValidateDate(input.current_status_date, 'CCYYMMDD').PastDate;													  	
			self.corp_inc_state										:= state_origin ;		
			self.corp_inc_date                 		:= map(input.org_type not in setForgnTypes =>Corp2_Mapping.fValidateDate(input.inc_date, 'CCYYMMDD').PastDate,
			                                             '');														
			self.corp_forgn_date 									:= map(input.org_type in setForgnTypes =>Corp2_Mapping.fValidateDate(input.inc_date, 'CCYYMMDD').PastDate,
																									 '');	
			self.corp_foreign_domestic_ind			  := map(input.org_type not in setForgnTypes =>'D',
																									 input.org_type  in setForgnTypes		 =>'F',
																									 '');																					
			self.corp_forgn_state_cd           		:= Corp2_Raw_WI.Functions.Get_State_Code(input.Incorp_State);	//only org_type='02' records have mapped to raw field "Incorp_State"/Corp2_Raw_WI.Files
			self.corp_forgn_state_desc           	:= Corp2_Raw_WI.Functions.fGetStateDesc(input.Incorp_State);
			temp_paid_capitol                     := trim(input.paid_capitol_rep,left,right);
			self.corp_addl_info            				:= if(trim(input.org_type,left,right)='02' and (integer)temp_paid_capitol <> 0,
																									map(length(temp_paid_capitol)in [1,2,3] => 'PAID CAPITAL: $'+ temp_paid_capitol+ ',000', //$1,000 ,$23,000,$230,000
																											length(temp_paid_capitol)= 4 => 'PAID CAPITAL: $'+ temp_paid_capitol[1..1]+','+temp_paid_capitol[2..]+',000', //$4,234,000length(input.paid_capitol_rep)= 4 => 'PAID CAPITAL: $'+ temp_paid_capitol[1..1]+','+temp_paid_capitol[2..]+',000', //4,234,000
																											length(temp_paid_capitol)= 5 => 'PAID CAPITAL: $'+ temp_paid_capitol[1..2]+','+temp_paid_capitol[3..]+',000', //$45,234,000
   																										length(temp_paid_capitol)= 6 => 'PAID CAPITAL: $'+ temp_paid_capitol[1..3]+','+temp_paid_capitol[4..]+',000', //$450,234,000
   																										length(temp_paid_capitol)= 7 => 'PAID CAPITAL: $'+ temp_paid_capitol[1..1]+','+temp_paid_capitol[2..4]+','+temp_paid_capitol[5..]+',000', //1,450,234,000
																											length(temp_paid_capitol)= 8 => 'PAID CAPITAL: $'+ temp_paid_capitol[1..2]+','+temp_paid_capitol[3..5]+','+temp_paid_capitol[6..]+',000', //10,450,234,000
																											length(temp_paid_capitol)= 9 => 'PAID CAPITAL: $'+ temp_paid_capitol[1..3]+','+temp_paid_capitol[4..6]+','+temp_paid_capitol[7..]+',000', //100,450,234,000
																											'PAID CAPITAL: $'+ temp_paid_capitol+ '000' //Any other values than above ex: $1000450234000
																											),
																								'');
			self.corp_ra_full_name								:= Corp2_Raw_WI.Functions.fgetAgentName(input.reg_agent_name); 
			//overload
			self.corp_ra_addl_info            		:= if(corp2.t2u(input.reg_agent_name) = 'AGENT RESIGNED','AGENT RESIGNED', '');
			self.corp_ra_address_line1            := Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.reg_agent_addr1,input.reg_agent_addr2,input.reg_agent_city,input.reg_agent_state,input.reg_agent_zip).AddressLine1;
			self.corp_ra_address_line2						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.reg_agent_addr1,input.reg_agent_addr2,input.reg_agent_city,input.reg_agent_state,input.reg_agent_zip).AddressLine2;
			self.corp_ra_address_line3						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.reg_agent_addr1,input.reg_agent_addr2,input.reg_agent_city,input.reg_agent_state,input.reg_agent_zip).AddressLine3;;
			self.ra_prep_addr_line1								:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.reg_agent_addr1,input.reg_agent_addr2,input.reg_agent_city,input.reg_agent_state,input.reg_agent_zip).PrepAddrLine1;
			self.ra_prep_addr_last_line						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,input.reg_agent_addr1,input.reg_agent_addr2,input.reg_agent_city,input.reg_agent_state,input.reg_agent_zip).PrepAddrLastLine;
			self.corp_ra_address_type_cd		  		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.reg_agent_addr1,input.reg_agent_addr2,input.reg_agent_city,input.reg_agent_state,input.reg_agent_zip).ifAddressExists ,'R','');
			self.corp_ra_address_type_desc				:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,input.reg_agent_addr1,input.reg_agent_addr2,input.reg_agent_city,input.reg_agent_state,input.reg_agent_zip).ifAddressExists ,'REGISTERED OFFICE','');								 
			self.corp_certificate_nbr		     			:= trim(input.most_recent_form20,left,right);									   			
			self.recordorigin											:= 'C';
			Self 																	:= [];
			
		end;

 
		ds_Corp		  := project(ds_raw_comfichex,CorpTransform(left));
		MappedCorp  := dedup(sort(distribute(ds_Corp,hash(corp_key)),record,local),record,local);	 
		
   	corp2_Mapping.LayoutsCommon.AR ARTransform(Corp2_Raw_WI.Layouts.fullLine_Layout input):=transform
   													   
			self.corp_key					      	:= state_fips + '-' + corp2.t2u(input.org_id);
			self.corp_vendor				      := state_fips ;
			self.corp_state_origin			  := state_origin ;
			self.corp_process_date			  := fileDate;
			self.corp_sos_charter_nbr		  := corp2.t2u(input.org_id);
			//overload
			self.ar_microfilm_nbr         := if((integer) input.most_recent_locator_number<>0 ,trim(input.most_recent_locator_number, left, right),'');	
			self.ar_year         					:= if((integer) input.most_recent_locator_number[1..4]<>0 ,trim(input.most_recent_locator_number,left,right)[1..4],'');
			self.ar_roll         					:= Corp2_Raw_WI.Functions.fgetRoll_frame(input.most_recent_locator_number[5..7]);
			self.ar_frame     						:= Corp2_Raw_WI.Functions.fgetRoll_frame(input.most_recent_locator_number[8..]);
			self                          := [];
      			
    end; 
     
     ds_AR   	 := project(ds_raw_comfichex,ARTransform(left))(corp2.t2u(ar_annual_report_cap + ar_microfilm_nbr +  ar_year + ar_roll +ar_frame)<>'' ) ;
		 mappedAR  := dedup(sort(distribute(ds_AR,hash(corp_key)),record,local),record,local);	 
	
		 corp2_Mapping.LayoutsCommon.events eventTransform(Corp2_Raw_WI.Layouts.fullLine_Layout input):=transform
													 
			self.corp_key					      	:= state_fips + '-' + corp2.t2u(input.org_id);
			self.corp_vendor				      := state_fips ;
			self.corp_state_origin			  := state_origin ;
			self.corp_process_date			  := fileDate;
			self.corp_sos_charter_nbr		  := corp2.t2u(input.org_id);
			self.event_filing_date        := if((integer)input.most_recent_form20[1..4]<>0 ,trim(input.most_recent_form20,left,right)[1..4],'');	
			self.event_roll    						:= Corp2_Raw_WI.Functions.fgetRoll_frame(input.most_recent_form20[5..]);
			self.event_filing_desc        := if(trim(self.event_filing_date)<>'' or trim(self.event_roll)<>'' ,'CERTIFICATES OF NEWLY-ELECTED OFFICERS/DIRECTORS','');
			self                          := [];

		end; 
		
		ds_events  		:= project(ds_raw_comfichex,eventTransform(left))(corp2.t2u(event_filing_date + event_roll)<>'' );
		mappedevents  := dedup(sort(distribute(ds_events,hash(corp_key)),record,local),record,local);	 
		
		//***********		MainFile Scrub	Logic	
      Main_F := MappedCorp:independent;
   		Main_S := Scrubs_Corp2_Mapping_WI_Main.Scrubs;					  // Scrubs module
   		Main_N := Main_S.FromNone(Main_F); 										   // Generate the error flags
   		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
   		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile);  // Pass the expanded error flags into the Expanded module
   
   		//Outputs reports
   		Main_ErrorSummary					:= output(Main_U.SummaryStats, named('Main_ErrorSummary_WI'+filedate));
   		Main_ScrubErrorReport 		:= output(choosen(Main_U.AllErrors, 1000), named('Main_ScrubErrorReport_WI'+filedate));
   		Main_SomeErrorValues			:= output(choosen(Main_U.BadValues, 1000), named('Main_SomeErrorValues_WI'+filedate));
   		Main_IsScrubErrors		 		:= IF(count(Main_U.AllErrors)<> 0,true,false);
   
   		// Orbit Stats
   		Main_OrbitStats						:= Main_U.OrbitStats();
   		//Outputs files
   		Main_CreateBitMaps				:= output(Main_N.BitmapInfile,,'~thor_data::corp_WI_main_scrubs_bits',overwrite,compressed);	//long term storage
   		Main_TranslateBitMap			:= output(Main_T);
			//Creates Profile's alert template for Orbit - can be copied and imported into Orbit; Only required if rules in Orbit change
			Main_AlertsCSVTemplate		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').ProfileAlertsTemplate;
			//Submits Profile's stats to Orbit
			Main_SubmitStats 			  	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').SubmitStats;
			Main_ScrubsWithExamples		:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_'+state_origin+'_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp2_'+state_origin+'_Main').CompareToProfile_with_Examples;
		
   		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
   		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
   		Main_SendEmailFile				:= FileServices.SendEmailAttachData( corp2.Email_Notification_Lists.spray
   																																	 ,'Scrubs CorpMain_WI Report' 	//subject
   																																	 ,'Scrubs CorpMain_WI Report'  //body
   																																	 ,(data)Main_ScrubsAttachment
   																																	 ,'text/csv'
   																																	 ,'CorpWIMainScrubsReport.csv'
   																																	 ,
   																																	 ,
   																																	 ,corp2.Email_Notification_Lists.spray
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
   																										corp_inc_state_Invalid 								<> 0 or																											
																										  corp_status_cd_Invalid 							  <> 0 or
																											corp_orig_org_structure_cd_Invalid 	  <> 0 or
																											corp_forgn_state_cd_Invalid         	<> 0 or 
																											corp_ln_name_type_cd_Invalid        	<> 0 or
																											corp_inc_date_Invalid								  <> 0 or
																											corp_foreign_domestic_ind_Invalid			<> 0 or
																											corp_forgn_state_desc_Invalid					<> 0 or
																											corp_forgn_date_Invalid								<> 0 or
																											corp_orig_org_structure_cd_Invalid		<> 0 or
																											corp_for_profit_ind_Invalid						<> 0 or
																											recordorigin_Invalid									<> 0 
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
   																									corp_inc_state_Invalid 								= 0 and
																										corp_status_cd_Invalid 							  = 0 and
																										corp_orig_org_structure_cd_Invalid 	  = 0 and
																										corp_forgn_state_cd_Invalid         	= 0 and
																										corp_ln_name_type_cd_Invalid          = 0 and
																										corp_inc_date_Invalid								  = 0 and
																										corp_foreign_domestic_ind_Invalid			= 0 and
																										corp_forgn_state_desc_Invalid					= 0 and
																										corp_forgn_date_Invalid								= 0 and
																										corp_orig_org_structure_cd_Invalid		= 0 and
																										corp_for_profit_ind_Invalid						= 0 and
																										recordorigin_Invalid									= 0
   																						  );
   		
   		Main_FailBuild	:= map( Corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_key_invalid<>0)),count(Main_N.ExpandedInFile),false) 										> Scrubs_Corp2_Mapping_WI_Main.Threshold_Percent.CORP_KEY										   => true,
   														Corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),count(Main_N.ExpandedInFile),false) 	> Scrubs_Corp2_Mapping_WI_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	   => true,
   														Corp2_Mapping.fCalcPercent(count(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),count(Main_N.ExpandedInFile),false) 						> Scrubs_Corp2_Mapping_WI_Main.Threshold_Percent.CORP_LEGAL_NAME 						   => true,
   														count(Main_GoodRecords) = 0																																																																																											 	 => true,																		
															false
														);
   
   		Main_ApprovedRecords := project(Main_GoodRecords,transform(Corp2_Mapping.LayoutsCommon.Main,self := left));
   		
   	 //==========================================VERSION CONTROL====================================================
   		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_WI',Main_ApprovedRecords,corp_out,,,pOverwrite);
   		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_wi'		,mappedAR					  ,ar_out		,,,pOverwrite);
   		VersionControl.macBuildNewLogicalFile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_wi',mappedEvents				,event_out,,,pOverwrite);
						
			VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::'+version+'::Main_' + state_origin		,Main_F	,write_fail_main  ,,,pOverwrite); 
			Main_RejFile_Exists		:= IF(FileServices.FileExists(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_' + state_origin),true,false);			
	
   		run_Main := sequential( IF( pshouldspray = TRUE,Corp2_mapping.fSprayFiles(state_origin ,version,pOverwrite := pOverwrite))
															//,Corp2_Raw_WI.Build_Bases(filedate,version,pUseProd).All // Determined building of bases is not needed
															,corp_out
															,ar_out
															,event_out
															,IF( Main_FailBuild <> true
																	 ,sequential(	fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::main'  ,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_WI')
																								,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::ar'   ,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::ar_WI')
																								,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped+'::sprayed::event',Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_WI')
																							  ,IF (count(Main_BadRecords) <> 0
																										,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),count(mappedAR),count(mappedEvents),).RecordsRejected																				 
																										,Corp2_Mapping.Send_Email(state_origin ,version,count(Main_BadRecords)<>0,,,,count(Main_BadRecords),,,,count(Main_ApprovedRecords),count(mappedAR),count(mappedEvents),).MappingSuccess		
																										)
																							)   
																		,sequential(write_fail_main
																								,Corp2_Mapping.Send_Email(state_origin ,version).MappingFailed
																							 )
																	)
																,IF(count(Main_BadRecords) <> 0
																		 ,IF ( poverwrite
																					,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_WI',overwrite,__compressed__,named('Sample_Rejected_MainRecs_WI'+filedate))
																					,sequential (IF(Main_RejFile_Exists,fileservices.deletelogicalfile(Corp2_Mapping._dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin)),
																											 OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+ state_origin,__compressed__,named('Sample_Rejected_MainRecs_WI'+filedate))
																											)
																				 )
																	 )
															 ,IF(Main_IsScrubErrors
																	 ,Corp2_Mapping.Send_Email(state_origin ,version,Main_IsScrubErrors,false,false,false).FieldsInvalidPerScrubs																				 
																	 )	
																,IF(COUNT(Main_ScrubsAlert) > 0, 	Main_SendEmailFile, OUTPUT('CORP2_MAPPING.WI - No Corp Scrubs Alerts'))		
																,output(Main_ScrubsWithExamples, ALL, NAMED('CorpMainWIScrubsReportWithExamples_'+filedate)) //Send Alerts if Scrubs exceeds thresholds
																,Main_ErrorSummary
																,Main_ScrubErrorReport																					
																,Main_SomeErrorValues
																//,Main_AlertsCSVTemplate
																,Main_SubmitStats
   													);
														
				//Validating the filedate entered is within 30 days											
				isFileDateValid := if((string)Std.Date.Today() between ut.date_math(filedate,-30) and ut.date_math(filedate,30),true,false);										
     		result		 			:= if ( isFileDateValid
																,run_Main 
																,sequential (Corp2_Mapping.Send_Email(state_origin ,filedate).InvalidFileDateParm
																						 ,FAIL('Corp2_Mapping.WI failed. An invalid filedate was passed in as a parameter.')
																						)
            									 );

				return result;
				
	end;
	
end;	