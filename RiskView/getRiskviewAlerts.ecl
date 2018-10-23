import risk_indicators, ut, models;

// *******************************************************************************************************************************************
// the main code for this logic exists in Riskview.Search_Function
// if you change logic in this attribute, you will probably also want to update the main branch in Riskview.Search_Function as well.
// *******************************************************************************************************************************************


EXPORT getRiskviewAlerts(dataset(risk_indicators.Layout_Boca_Shell) clam, boolean isCalifornia_in_person, string intended_purpose ) := function

// check to see if the DID was the only thing input
// For batch, assuming that if 1 record is LexID only on input that all records are LexID only on input to greatly simplify this calculation/requirement
LexIDOnlyOnInput := clam[1].DID > 0 AND clam[1].shell_input.SSN = '' AND clam[1].shell_input.dob = '' AND clam[1].shell_input.phone10 = '' AND clam[1].shell_input.wphone10 = '' AND 
										clam[1].shell_input.fname = '' AND clam[1].shell_input.lname = '' AND clam[1].shell_input.in_streetAddress = '' AND clam[1].shell_input.z5 = '' AND clam[1].shell_input.dl_number = '';

boolean   isPreScreenPurpose := StringLib.StringToUpperCase(intended_purpose) = 'PRESCREENING';
boolean   isCollectionsPurpose := StringLib.StringToUpperCase(intended_purpose) = 'COLLECTIONS';
										
risk_indicators.Layout_Boca_Shell add_alerts(risk_indicators.Layout_Boca_Shell le) := transform

	attr := models.Attributes_Master(le, true);
	ConfirmationSubjectFound	:= attr.ConfirmationSubjectFound;
	
	//security freeze, return alert code 100A
	boolean hasSecurityFreeze := le.consumerFlags.security_freeze;
	
	//security fraud alert, return alert code 100B
	boolean hasSecurityFraudAlert := le.consumerFlags.security_alert or le.consumerFlags.id_theft_flag ;

	//consumer statement alert, return alert code 100C
	boolean hasConsumerStatement := le.consumerFlags.consumer_statement_flag;

	//California or Rhodes Island state exceptions, return alert code 100D
	boolean isCaliforniaException := isCalifornia_in_person and 
																	StringLib.StringToUpperCase(intended_purpose) = 'APPLICATION' and
																	((integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
																	+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
																	+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
	boolean isRhodeIslandException := le.rhode_island_insufficient_verification;
	boolean isStateException := (isCaliforniaException or isRhodeIslandException) OR 
															// Also fail California In-Person Retail and Rhode Island Verification minimum input requirements for LexID Only input
															(isCalifornia_in_person AND LexIDOnlyOnInput) OR 
															(le.shell_input.in_state = 'RI' AND LexIDOnlyOnInput);
	
	// Regulatory Condition 100E, too young for prescreening
	ageDate := Risk_Indicators.iid_constants.myGetDate(le.historydate);
	BestReportedAge := ut.Age(le.reported_dob, (unsigned)ageDate);
	boolean tooYoungForPrescreen :=  isPreScreenPurpose and BestReportedAge between 1 and 20;
	
	// Regulatory Condition 100F, on the FCRA Prescreen OptOut File
	boolean PrescreenOptOut :=  isPreScreenPurpose and risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.IsPreScreen, le.iid.iid_flags );
																						
	hasScore (STRING score) := le.rv_scores.autov5 = score OR le.rv_scores.bankcardv5 = score OR 
														 le.rv_scores.msbv5 = score OR le.rv_scores.telecomv5 = score ;
														 // OR le.Custom_score = score;  // in the shell we don't have custom score field to check, so we'll comment out this line
														 
	boolean has200Score := hasScore('200');
	boolean has222Score := hasScore('222');
	
	boolean chapter7bankruptcy := trim(le.bjl.bk_chapter)='7' AND NOT isPreScreenPurpose;	
	boolean chapter9bankruptcy := trim(le.bjl.bk_chapter)='9' AND NOT isPreScreenPurpose;	
	boolean chapter11bankruptcy := trim(le.bjl.bk_chapter)='11' AND NOT isPreScreenPurpose;	
	boolean chapter12bankruptcy := trim(le.bjl.bk_chapter)='12' AND NOT isPreScreenPurpose;	
	boolean chapter13bankruptcy := trim(le.bjl.bk_chapter)='13' AND NOT isPreScreenPurpose;	
	boolean chapter15bankruptcy := trim(le.bjl.bk_chapter) in ['15', '304'] AND NOT isPreScreenPurpose;	
	
	hasBankruptcyAlert := chapter7bankruptcy or chapter9bankruptcy or chapter11bankruptcy or chapter12bankruptcy or chapter13bankruptcy or chapter15bankruptcy;
	
	// currently there are only 6 conditions to trigger an alert, but leaving room in the batch layout for up to 10 alerts to be returned.
	ds_alerts_temp1 := dataset([
		{if(hasSecurityFreeze and isCollectionsPurpose, '100A', '')},  // only include securityFreeze alert in this dataset if the purpose is collections
		{if(hasSecurityFraudAlert, '100B', '')},
		{if(hasConsumerStatement, '100C', '')},
		{if(has200Score, '200A', '')},
		{if(chapter7bankruptcy, '300A', '')},
		{if(chapter9bankruptcy, '300B', '')},
		{if(chapter11bankruptcy, '300C', '')},
		{if(chapter12bankruptcy, '300D', '')},
		{if(chapter13bankruptcy, '300E', '')},
		{if(chapter15bankruptcy, '300F', '')}
	], {string4 alert_code})(alert_code<>'');
	
	// when confirmationSubjectFound = 0, the only alert to come back should be the 222A.  all other alert conditions are ignored
	// when state exeption, just return a 100D and no other alerts
	ds_alert_subject_not_found := dataset([{'222A'}],{string4 alert_code});
	ds_alert_state_exception := dataset([{'100D'}],{string4 alert_code});
	ds_alert_tooYoungForPrescreen := dataset([{'100E'}],{string4 alert_code});
	ds_alert_PrescreenOptOut := dataset([{'100F'}],{string4 alert_code});
	ds_alert_SecurityFreeze := dataset([{'100A'}],{string4 alert_code});  // comes back by itself if purpose is not collections
					
	ds_alerts_temp := map(isStateException 																=> ds_alert_state_exception,  // because the state exceptions are also coming through as 222, Brad wants to put this first in map so allert of 100D
												ConfirmationSubjectFound='0' or has222score 		=> ds_alert_subject_not_found,
												TooYoungForPrescreen														=> ds_alert_tooYoungForPrescreen,
												PrescreenOptOut																	=> ds_alert_PrescreenOptOut,
												hasSecurityFreeze and ~isCollectionsPurpose			=> ds_alert_SecurityFreeze,
																																					 ds_alerts_temp1);
	
	// Only 100B, 100C, 200A, 222A alert codes allow for valid RiskView Scores to return, if it's the others override the score to a 100.  100A allows for a score to return if this is a collections purpose.
	score_override_alert_returned := UT.Exists2(ds_alerts_temp (alert_code IN ['100D', '100E', '100F'])) OR (UT.Exists2(ds_alerts_temp (alert_code = '100A')) AND ~isCollectionsPurpose);
	
	// If the score is being overridden to a 100, don't return a 200 or 222 score alert code.
	ds_alerts := IF(score_override_alert_returned, ds_alerts_temp (alert_code NOT IN ['200A', '222A']), ds_alerts_temp);
	ReportSuppressAlerts := (UT.Exists2(ds_alerts (alert_code = '222A')) or UT.Exists2(ds_alerts (alert_code = '200A')));
	
	
	self.riskview_alerts.alert1 := ds_alerts[1].alert_code;
	self.riskview_alerts.alert2 := ds_alerts[2].alert_code;
	self.riskview_alerts.alert3 := ds_alerts[3].alert_code;
	self.riskview_alerts.alert4 := ds_alerts[4].alert_code;
	self.riskview_alerts.alert5 := ds_alerts[5].alert_code;
	self.riskview_alerts.alert6 := ds_alerts[6].alert_code;
	self.riskview_alerts.alert7 := ds_alerts[7].alert_code;
	self.riskview_alerts.alert8 := ds_alerts[8].alert_code;
	self.riskview_alerts.alert9 := ds_alerts[9].alert_code;
	self.riskview_alerts.alert10 := ds_alerts[10].alert_code;
	
	self.rv_scores.autov5 := if(le.rv_scores.autov5<>'' and score_override_alert_returned, '100', le.rv_scores.autov5);
	self.rv_scores.bankcardv5 := if(le.rv_scores.bankcardv5<>'' and score_override_alert_returned, '100', le.rv_scores.bankcardv5);
	self.rv_scores.msbv5 := if(le.rv_scores.msbv5<>'' and score_override_alert_returned, '100', le.rv_scores.msbv5);
	self.rv_scores.telecomv5 := if(le.rv_scores.telecomv5<>'' and score_override_alert_returned, '100', le.rv_scores.telecomv5);					 
	self.rv_scores.crossindv5 := if(le.rv_scores.crossindv5<>'' and score_override_alert_returned, '100', le.rv_scores.crossindv5);					 
														 
	self := le;
end;

	clam_with_alerts := project(clam, add_alerts(left));
	
	return clam_with_alerts;
	
end;	
	