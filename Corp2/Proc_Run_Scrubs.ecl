import Scrubs_Corp2_Build_Corp_Base,Scrubs_Corp2_Build_Cont_Base,Scrubs_Corp2_Build_AR_Base,Scrubs_Corp2_Build_Event_Base,Scrubs_Corp2_Build_Stock_Base,scrubs;

EXPORT Proc_Run_Scrubs(string VersionDate) := function
	
//--------------------------- Beginning of Corp Scrubs ---------------------------------------//		

			CORP_F	:=	Corp2.Files().AID.Corp.Built;								//	Records to scrub
			// CORP_F	:=	Scrubs_Corp2_Build_Corp_Base.in_file;
			CORP_S	:=	Scrubs_Corp2_Build_Corp_Base.Scrubs;				//	My scrubs module
			CORP_N	:=	CORP_S.FromNone(CORP_F);										//	Generate the error flags
			CORP_T	:=	CORP_S.FromBits(CORP_N.BitmapInfile);     	// 	Use the FromBits module; makes my bitmap datafile easier to get to			
			CORP_U 	:=	CORP_S.FromExpanded(CORP_N.ExpandedInFile);	//	Pass the expanded error flags into the Expanded module
			
			//Outputs reports
			CORP_ErrorSummary			:=	OUTPUT(CORP_U.SummaryStats, NAMED('CORP_ErrorSummary'));										//	Show errors by field and type
			CORP_ScrubErrorReport	:=	OUTPUT(CHOOSEN(CORP_U.AllErrors, 1000), NAMED('CORP_ScrubErrorReport'));		//	Just eyeball some errors
			CORP_SomeErrorValues	:=	OUTPUT(CHOOSEN(CORP_U.BadValues, 1000), NAMED('CORP_SomeErrorValues'));			//	See my error field values
			CORP_IsScrubErrors		:= 	IF(count(CORP_U.AllErrors)<> 0,true,false);
			
			// Orbit Stats
			CORP_OrbitStats					:= CORP_U.OrbitStats(): persist('~persist::Corp_CorpBase_OrbitStats');
			CORP_OrbitReport 				:= output(CORP_OrbitStats,all,named('Corp_CorpBase_OrbitReport'));
			CORP_OrbitReportSummary := output(Scrubs.OrbitProfileStats(,,CORP_OrbitStats).SummaryStats,all,named('Corp_CorpBase_OrbitReportSummary'));
			
			//Outputs files
			CORP_CreateBitMaps			:= output(CORP_N.BitmapInfile,,'~thor_data::Corp_CorpBase_scrubs_bits',overwrite,compressed);	//long term storage
			CORP_TranslateBitMap		:= output(CORP_T);

			//Submits Profile's stats to Orbit
			CORP_SubmitStats 				:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Build_Corp_Base','ScrubsAlerts', CORP_OrbitStats, VersionDate,'CorpBase').SubmitStats;
			
			CORP_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Build_Corp_Base','ScrubsAlerts', CORP_OrbitStats, VersionDate,'CorpBase').CompareToProfile_with_Examples;
			CORP_ScrubsAlert				:= CORP_ScrubsWithExamples(RejectWarning = 'Y');
			CORP_ScrubsAttachment		:= Scrubs.fn_email_attachment(CORP_ScrubsAlert);
			CORP_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.scrubs
																													 ,'Scrubs CorpBase Report' //subject
																													 ,'Scrubs CorpBase Report' //body
																													 ,(data)CORP_ScrubsAttachment
																													 ,'text/csv'
																													 ,'CorpCorpBaseScrubsReport.csv'
																													 ,
																													 ,
																													 ,corp2.Email_Notification_Lists.scrubs);
																									 
														
			corpScrubs							:=	sequential(
																							output(CORP_ScrubsWithExamples, ALL, NAMED('CorpBaseScrubsReportWithExamples'))
																							//Send Alerts if Scrubs exceeds thresholds
																							,IF(COUNT(CORP_ScrubsAlert) > 0, CORP_MailFile, OUTPUT('Corp Base Build - No Scrub Alerts'))
																							,CORP_ErrorSummary
																							,CORP_ScrubErrorReport
																							,CORP_SomeErrorValues																				 
																							,CORP_SubmitStats	
																						 );
																						 
//--------------------------- End of Corps Scrubs --------------------------------------------//	

//--------------------------- Beginning of Cont Scrubs ---------------------------------------//	

			CONT_F 	:= 	Files().AID.Cont.Built;
			// CONT_F	:=	Scrubs_Corp2_Build_Cont_Base.in_file;
			CONT_S	:=	Scrubs_Corp2_Build_Cont_Base.Scrubs;				//	My scrubs module
			CONT_N	:=	CONT_S.FromNone(CONT_F);										//	Generate the error flags
			CONT_T	:=	CONT_S.FromBits(CONT_N.BitmapInfile);     	// 	Use the FromBits module; makes my bitmap datafile easier to get to			
			CONT_U 	:=	CONT_S.FromExpanded(CONT_N.ExpandedInFile);	//	Pass the expanded error flags into the Expanded module
			
			//Outputs reports
			CONT_ErrorSummary			:=	OUTPUT(CONT_U.SummaryStats, NAMED('CONT_ErrorSummary'));										//	Show errors by field and type
			CONT_ScrubErrorReport	:=	OUTPUT(CHOOSEN(CONT_U.AllErrors, 1000), NAMED('CONT_ScrubErrorReport'));		//	Just eyeball some errors
			CONT_SomeErrorValues	:=	OUTPUT(CHOOSEN(CONT_U.BadValues, 1000), NAMED('CONT_SomeErrorValues'));			//	See my error field values
			CONT_IsScrubErrors		:= 	IF(count(CONT_U.AllErrors)<> 0,true,false);
			
			// Orbit Stats
			CONT_OrbitStats					:= CONT_U.OrbitStats(): persist('~persist::Corp_CONTBase_OrbitStats');
			CONT_OrbitReport 				:= output(CONT_OrbitStats,all,named('Corp_CONTBase_OrbitReport'));
			CONT_OrbitReportSummary := output(Scrubs.OrbitProfileStats(,,CONT_OrbitStats).SummaryStats,all,named('Corp_CONTBase_OrbitReportSummary'));
			
			//Outputs files
			CONT_CreateBitMaps			:= output(CONT_N.BitmapInfile,,'~thor_data::Corp_CONTBase_scrubs_bits',overwrite,compressed);	//long term storage
			CONT_TranslateBitMap		:= output(CONT_T);

			//Submits Profile's stats to Orbit
			CONT_SubmitStats 				:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Build_Cont_Base','ScrubsAlerts', CONT_OrbitStats, VersionDate,'CONTBase').SubmitStats;
			
			CONT_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Build_Cont_Base','ScrubsAlerts', CONT_OrbitStats, VersionDate,'CONTBase').CompareToProfile_with_Examples;
			CONT_ScrubsAlert				:= CONT_ScrubsWithExamples(RejectWarning = 'Y');
			CONT_ScrubsAttachment		:= Scrubs.fn_email_attachment(CONT_ScrubsAlert);
			CONT_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.scrubs
																													 ,'Scrubs CONTBase Report' //subject
																													 ,'Scrubs CONTBase Report' //body
																													 ,(data)CONT_ScrubsAttachment
																													 ,'text/csv'
																													 ,'CorpCONTBaseScrubsReport.csv'
																													 ,
																													 ,
																													 ,corp2.Email_Notification_Lists.scrubs);
																									 
														
			CONTScrubs							:=	sequential(
																							output(CONT_ScrubsWithExamples, ALL, NAMED('CONTBaseScrubsReportWithExamples'))
																							//Send Alerts if Scrubs exceeds thresholds
																							,IF(COUNT(CONT_ScrubsAlert) > 0, CONT_MailFile, OUTPUT('CONT Base Build - No Scrub Alerts'))
																							,CONT_ErrorSummary
																							,CONT_ScrubErrorReport
																							,CONT_SomeErrorValues																				 
																							,CONT_SubmitStats	
																						 );
																						 
//--------------------------- End of CONT Scrubs ---------------------------------------------//	

//--------------------------- Beginning of AR Scrubs ---------------------------------------//	

			AR_F 	:= 	Files().BASE.AR.Built;
			// AR_F	:=	Scrubs_Corp2_Build_AR_Base.in_file;
			AR_S	:=	Scrubs_Corp2_Build_AR_Base.Scrubs;			//	My scrubs module
			AR_N	:=	AR_S.FromNone(AR_F);										//	Generate the error flags
			AR_T	:=	AR_S.FromBits(AR_N.BitmapInfile);     	// 	Use the FromBits module; makes my bitmap datafile easier to get to			
			AR_U 	:=	AR_S.FromExpanded(AR_N.ExpandedInFile);	//	Pass the expanded error flags into the Expanded module
			
			//Outputs reports
			AR_ErrorSummary			:=	OUTPUT(AR_U.SummaryStats, NAMED('AR_ErrorSummary'));										//	Show errors by field and type
			AR_ScrubErrorReport	:=	OUTPUT(CHOOSEN(AR_U.AllErrors, 1000), NAMED('AR_ScrubErrorReport'));		//	Just eyeball some errors
			AR_SomeErrorValues	:=	OUTPUT(CHOOSEN(AR_U.BadValues, 1000), NAMED('AR_SomeErrorValues'));			//	See my error field values
			AR_IsScrubErrors		:= 	IF(count(AR_U.AllErrors)<> 0,true,false);
			
			// Orbit Stats
			AR_OrbitStats					:= AR_U.OrbitStats(): persist('~persist::Corp_ARBase_OrbitStats');
			AR_OrbitReport 				:= output(AR_OrbitStats,all,named('Corp_ARBase_OrbitReport'));
			AR_OrbitReportSummary := output(Scrubs.OrbitProfileStats(,,AR_OrbitStats).SummaryStats,all,named('Corp_ARBase_OrbitReportSummary'));
			
			//Outputs files
			AR_CreateBitMaps			:= output(AR_N.BitmapInfile,,'~thor_data::Corp_ARBase_scrubs_bits',overwrite,compressed);	//long term storage
			AR_TranslateBitMap		:= output(AR_T);

			//Submits Profile's stats to Orbit
			AR_SubmitStats 				:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Build_AR_Base','ScrubsAlerts', AR_OrbitStats, VersionDate,'ARBase').SubmitStats;
			
			AR_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Build_AR_Base','ScrubsAlerts', AR_OrbitStats, VersionDate,'ARBase').CompareToProfile_with_Examples;
			AR_ScrubsAlert				:= AR_ScrubsWithExamples(RejectWarning = 'Y');
			AR_ScrubsAttachment		:= Scrubs.fn_email_attachment(AR_ScrubsAlert);
			AR_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.scrubs
																													 ,'Scrubs ARBase Report' //subject
																													 ,'Scrubs ARBase Report' //body
																													 ,(data)AR_ScrubsAttachment
																													 ,'text/csv'
																													 ,'CorpARBaseScrubsReport.csv'
																													 ,
																													 ,
																													 ,corp2.Email_Notification_Lists.scrubs);
																									 
														
			ARScrubs							:=	sequential(
																							output(AR_ScrubsWithExamples, ALL, NAMED('ARBaseScrubsReportWithExamples'))
																							//Send Alerts if Scrubs exceeds thresholds
																							,IF(COUNT(AR_ScrubsAlert) > 0, AR_MailFile, OUTPUT('AR Base Build - No Scrub Alerts'))
																							,AR_ErrorSummary
																							,AR_ScrubErrorReport
																							,AR_SomeErrorValues																				 
																							,AR_SubmitStats	
																						 );
																						 
//--------------------------- End of AR Scrubs ---------------------------------------------//	

//--------------------------- Beginning of Event Scrubs ---------------------------------------//	

			Event_F 	:= 	Files().BASE.Events.Built;
			// Event_F	:=	Scrubs_Corp2_Build_Event_Base.in_file;
			Event_S	:=	Scrubs_Corp2_Build_Event_Base.Scrubs;					//	My scrubs module
			Event_N	:=	Event_S.FromNone(Event_F);										//	Generate the error flags
			Event_T	:=	Event_S.FromBits(Event_N.BitmapInfile);     	// 	Use the FromBits module; makes my bitmap datafile easier to get to			
			Event_U :=	Event_S.FromExpanded(Event_N.ExpandedInFile);	//	Pass the expanded error flags into the Expanded module
			
			//Outputs reports
			Event_ErrorSummary			:=	OUTPUT(Event_U.SummaryStats, NAMED('Event_ErrorSummary'));										//	Show errors by field and type
			Event_ScrubErrorReport	:=	OUTPUT(CHOOSEN(Event_U.AllErrors, 1000), NAMED('Event_ScrubErrorReport'));		//	Just eyeball some errors
			Event_SomeErrorValues		:=	OUTPUT(CHOOSEN(Event_U.BadValues, 1000), NAMED('Event_SomeErrorValues'));			//	See my error field values
			Event_IsScrubErrors			:= 	IF(count(Event_U.AllErrors)<> 0,true,false);
			
			// Orbit Stats
			Event_OrbitStats					:= Event_U.OrbitStats(): persist('~persist::Corp_EventBase_OrbitStats');
			Event_OrbitReport					:= output(Event_OrbitStats,all,named('Corp_EventBase_OrbitReport'));
			Event_OrbitReportSummary	:= output(Scrubs.OrbitProfileStats(,,Event_OrbitStats).SummaryStats,all,named('Corp_EventBase_OrbitReportSummary'));
			
			//Outputs files
			Event_CreateBitMaps			:= output(Event_N.BitmapInfile,,'~thor_data::Corp_EventBase_scrubs_bits',overwrite,compressed);	//long term storage
			Event_TranslateBitMap		:= output(Event_T);

			//Submits Profile's stats to Orbit
			Event_SubmitStats 				:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Build_Event_Base','ScrubsAlerts', Event_OrbitStats, VersionDate,'EventBase').SubmitStats;
			
			Event_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Build_Event_Base','ScrubsAlerts', Event_OrbitStats, VersionDate,'EventBase').CompareToProfile_with_Examples;
			Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
			Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
			Event_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.scrubs
																													 ,'Scrubs EventBase Report' //subject
																													 ,'Scrubs EventBase Report' //body
																													 ,(data)Event_ScrubsAttachment
																													 ,'text/csv'
																													 ,'CorpEventBaseScrubsReport.csv'
																													 ,
																													 ,
																													 ,corp2.Email_Notification_Lists.scrubs);
																									 
														
			EventScrubs							:=	sequential(
																							output(Event_ScrubsWithExamples, ALL, NAMED('EventBaseScrubsReportWithExamples'))
																							//Send Alerts if Scrubs exceeds thresholds
																							,IF(COUNT(Event_ScrubsAlert) > 0, Event_MailFile, OUTPUT('Event Base Build - No Scrub Alerts'))
																							,Event_ErrorSummary
																							,Event_ScrubErrorReport
																							,Event_SomeErrorValues																				 
																							,Event_SubmitStats	
																						 );
																						 
//--------------------------- End of Event Scrubs ---------------------------------------------//		

//--------------------------- Beginning of Stock Scrubs ---------------------------------------//	

			Stock_F 	:= 	Files().BASE.Stock.Built;
			// Stock_F	:=	Scrubs_Corp2_Build_Stock_Base.in_file;
			Stock_S	:=	Scrubs_Corp2_Build_Stock_Base.Scrubs;					//	My scrubs module
			Stock_N	:=	Stock_S.FromNone(Stock_F);										//	Generate the error flags
			Stock_T	:=	Stock_S.FromBits(Stock_N.BitmapInfile);     	// 	Use the FromBits module; makes my bitmap datafile easier to get to			
			Stock_U :=	Stock_S.FromExpanded(Stock_N.ExpandedInFile);	//	Pass the expanded error flags into the Expanded module
			
			//Outputs reports
			Stock_ErrorSummary			:=	OUTPUT(Stock_U.SummaryStats, NAMED('Stock_ErrorSummary'));										//	Show errors by field and type
			Stock_ScrubErrorReport	:=	OUTPUT(CHOOSEN(Stock_U.AllErrors, 1000), NAMED('Stock_ScrubErrorReport'));		//	Just eyeball some errors
			Stock_SomeErrorValues		:=	OUTPUT(CHOOSEN(Stock_U.BadValues, 1000), NAMED('Stock_SomeErrorValues'));			//	See my error field values
			Stock_IsScrubErrors			:= 	IF(count(Stock_U.AllErrors)<> 0,true,false);
			
			// Orbit Stats
			Stock_OrbitStats				:= Stock_U.OrbitStats(): persist('~persist::Corp_StockBase_OrbitStats');
			Stock_OrbitReport				:= output(Stock_OrbitStats,all,named('Corp_StockBase_OrbitReport'));
			Stock_OrbitReportSummary:= output(Scrubs.OrbitProfileStats(,,Stock_OrbitStats).SummaryStats,all,named('Corp_StockBase_OrbitReportSummary'));
			
			//Outputs files
			Stock_CreateBitMaps			:= output(Stock_N.BitmapInfile,,'~thor_data::Corp_StockBase_scrubs_bits',overwrite,compressed);	//long term storage
			Stock_TranslateBitMap		:= output(Stock_T);

			//Submits Profile's stats to Orbit
			Stock_SubmitStats 				:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Build_Stock_Base','ScrubsAlerts', Stock_OrbitStats, VersionDate,'StockBase').SubmitStats;
			
			Stock_ScrubsWithExamples	:= Scrubs.OrbitProfileStats('Scrubs_Corp2_Build_Stock_Base','ScrubsAlerts', Stock_OrbitStats, VersionDate,'StockBase').CompareToProfile_with_Examples;
			Stock_ScrubsAlert					:= Stock_ScrubsWithExamples(RejectWarning = 'Y');
			Stock_ScrubsAttachment		:= Scrubs.fn_email_attachment(Stock_ScrubsAlert);
			Stock_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.scrubs
																													 ,'Scrubs StockBase Report' //subject
																													 ,'Scrubs StockBase Report' //body
																													 ,(data)Stock_ScrubsAttachment
																													 ,'text/csv'
																													 ,'CorpStockBaseScrubsReport.csv'
																													 ,
																													 ,
																													 ,corp2.Email_Notification_Lists.scrubs);
																									 
														
			StockScrubs							:=	sequential(
																							output(Stock_ScrubsWithExamples, ALL, NAMED('StockBaseScrubsReportWithExamples'))
																							//Send Alerts if Scrubs exceeds thresholds
																							,IF(COUNT(Stock_ScrubsAlert) > 0, Stock_MailFile, OUTPUT('Stock Base Build - No Scrub Alerts'))
																							,Stock_ErrorSummary
																							,Stock_ScrubErrorReport
																							,Stock_SomeErrorValues																				 
																							,Stock_SubmitStats	
																						 );
																						 
//--------------------------- End of Stock Scrubs ---------------------------------------------//																					 
																						 
//--------------------------- Check condition of overall build -------------------------------//																						 
																						 
			CorpBuildFailure				:= map( count(CORP_N.ExpandedInFile(corp_key_invalid<>0))											> Scrubs_Corp2_Build_Corp_Base.Threshold_Counts.CORP_KEY										 	=> true,
																			count(CORP_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0))		> Scrubs_Corp2_Build_Corp_Base.Threshold_Counts.CORP_ORIG_SOS_CHARTER_NBR 	 	=> true,
																			count(CORP_N.ExpandedInFile(corp_legal_name_invalid<>0))							> Scrubs_Corp2_Build_Corp_Base.Threshold_Counts.CORP_LEGAL_NAME 						 	=> true,
																			count(CORP_N.ExpandedInFile(corp_process_date_invalid<>0))						>	Scrubs_Corp2_Build_Corp_Base.Threshold_Counts.corp_process_date							=> true,
																			count(CORP_N.ExpandedInFile(corp_inc_date_invalid<>0))								> Scrubs_Corp2_Build_Corp_Base.Threshold_Counts.CORP_INC_DATE 						 	 	=> true,
																			count(CORP_N.ExpandedInFile(corp_inc_state_invalid<>0))								>	Scrubs_Corp2_Build_Corp_Base.Threshold_Counts.CORP_INC_STATE 						 	 	=> true,
																			count(CORP_N.ExpandedInFile(corp_status_date_invalid<>0))							> Scrubs_Corp2_Build_Corp_Base.Threshold_Counts.CORP_STATUS_DATE 					 	 	=> true,
																			false
																		);	
																		
			ContBuildFailure				:= map( count(CONT_N.ExpandedInFile(corp_key_invalid<>0))											> Scrubs_Corp2_Build_CONT_Base.Threshold_Counts.CORP_KEY										 	=> true,
																			count(CONT_N.ExpandedInFile(corp_state_origin_invalid<>0))						> Scrubs_Corp2_Build_CONT_Base.Threshold_Counts.corp_state_origin 	 					=> true,
																			count(CONT_N.ExpandedInFile(corp_legal_name_invalid<>0))							> Scrubs_Corp2_Build_CONT_Base.Threshold_Counts.CORP_LEGAL_NAME 						 	=> true,
																			count(CONT_N.ExpandedInFile(corp_vendor_invalid<>0))									> Scrubs_Corp2_Build_CONT_Base.Threshold_Counts.corp_vendor 						 		 	=> true,
																			count(CONT_N.ExpandedInFile(corp_process_date_invalid<>0))						>	Scrubs_Corp2_Build_CONT_Base.Threshold_Counts.corp_process_date							=> true,
																			count(CONT_N.ExpandedInFile(cont_filing_date_invalid<>0))							> Scrubs_Corp2_Build_CONT_Base.Threshold_Counts.cont_filing_date 					 	 	=> true,
																			count(CONT_N.ExpandedInFile(cont_dob_invalid<>0))											> Scrubs_Corp2_Build_CONT_Base.Threshold_Counts.cont_dob 										 	=> true,
																			count(CONT_N.ExpandedInFile(cont_effective_date_invalid<>0))					> Scrubs_Corp2_Build_CONT_Base.Threshold_Counts.cont_effective_date 			 	 	=> true,
																			count(CONT_N.ExpandedInFile(cont_address_effective_date_invalid<>0))	> Scrubs_Corp2_Build_CONT_Base.Threshold_Counts.cont_address_effective_date  	=> true,
																			false
																		);	
																		
			ARBuildFailure					:= map( count(AR_N.ExpandedInFile(corp_key_invalid<>0))												> Scrubs_Corp2_Build_AR_Base.Threshold_Counts.CORP_KEY											 	=> true,
																			count(AR_N.ExpandedInFile(corp_state_origin_invalid<>0))							> Scrubs_Corp2_Build_AR_Base.Threshold_Counts.corp_state_origin 	 						=> true,
																			count(AR_N.ExpandedInFile(corp_vendor_invalid<>0))										> Scrubs_Corp2_Build_AR_Base.Threshold_Counts.corp_vendor 						 		 		=> true,
																			count(AR_N.ExpandedInFile(corp_process_date_invalid<>0))							>	Scrubs_Corp2_Build_AR_Base.Threshold_Counts.corp_process_date								=> true,
																			count(AR_N.ExpandedInFile(ar_mailed_dt_invalid<>0))										> Scrubs_Corp2_Build_AR_Base.Threshold_Counts.ar_mailed_dt		 					 		 	=> true,
																			count(AR_N.ExpandedInFile(ar_due_dt_invalid<>0))											> Scrubs_Corp2_Build_AR_Base.Threshold_Counts.ar_due_dt 										 	=> true,
																			count(AR_N.ExpandedInFile(ar_report_dt_invalid<>0))										> Scrubs_Corp2_Build_AR_Base.Threshold_Counts.ar_report_dt 			 	 						=> true,
																			count(AR_N.ExpandedInFile(ar_franchise_tax_paid_dt_invalid<>0))				> Scrubs_Corp2_Build_AR_Base.Threshold_Counts.ar_franchise_tax_paid_dt  			=> true,
																			count(AR_N.ExpandedInFile(ar_delinquent_dt_invalid<>0))								> Scrubs_Corp2_Build_AR_Base.Threshold_Counts.ar_delinquent_dt  							=> true,
																			false
																		);	
																		
			EventBuildFailure				:= map( count(Event_N.ExpandedInFile(corp_key_invalid<>0))										> Scrubs_Corp2_Build_Event_Base.Threshold_Counts.CORP_KEY										 	=> true,
																			count(Event_N.ExpandedInFile(corp_state_origin_invalid<>0))						> Scrubs_Corp2_Build_Event_Base.Threshold_Counts.corp_state_origin 	 					=> true,
																			count(Event_N.ExpandedInFile(corp_vendor_invalid<>0))									> Scrubs_Corp2_Build_Event_Base.Threshold_Counts.corp_vendor 						 		 	=> true,
																			count(Event_N.ExpandedInFile(corp_process_date_invalid<>0))						>	Scrubs_Corp2_Build_Event_Base.Threshold_Counts.corp_process_date							=> true,
																			false
																		);
																		
			StockBuildFailure				:= map( count(Stock_N.ExpandedInFile(corp_key_invalid<>0))										> Scrubs_Corp2_Build_Stock_Base.Threshold_Counts.CORP_KEY										 	=> true,
																			count(Stock_N.ExpandedInFile(corp_state_origin_invalid<>0))						> Scrubs_Corp2_Build_Stock_Base.Threshold_Counts.corp_state_origin 	 					=> true,
																			count(Stock_N.ExpandedInFile(corp_vendor_invalid<>0))									> Scrubs_Corp2_Build_Stock_Base.Threshold_Counts.corp_vendor 						 		 	=> true,
																			count(Stock_N.ExpandedInFile(corp_process_date_invalid<>0))						>	Scrubs_Corp2_Build_Stock_Base.Threshold_Counts.corp_process_date							=> true,
																			false
																		);																				
																		
			BuildFailure						:= If(CorpBuildFailure or ContBuildFailure or ARBuildFailure or EventBuildFailure or StockBuildFailure,
																			true,
																			false
																		);																			
																		
			FailBuild								:=	sequential (
																							Corp2.Send_Email(VersionDate,,,,corp2.Email_Notification_Lists.scrubs,,,'Build Failed - Scrub Thresholds Exceeded').BuildNote
																							,OUTPUT('Corp2 Build Failed. Scrub Thresholds were exceeded.')
																							,FAIL('Corp2 Build Failed.  Scrub Thresholds were exceeded.')
																							);
																		
			whattodo	:=	sequential(
												parallel(
																	corpScrubs
																	,contScrubs
																	,ARScrubs
																	,EventScrubs
																	,StockScrubs
																)
												,if (BuildFailure, FailBuild, OUTPUT('Corp2 Build - No Scrub Failures'))
															);	
														
			return whattodo;

	end;