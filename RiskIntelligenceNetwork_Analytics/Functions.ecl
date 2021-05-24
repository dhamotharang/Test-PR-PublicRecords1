IMPORT AppendBankDetails, AppendDisposableEmailDomainFlag, Data_Services;
IMPORT FraudgovKEL, FraudgovPlatform, FraudgovPlatform_Analytics, FraudShared;
IMPORT KEL12 AS KEL;
IMPORT RiskIntelligenceNetwork_Analytics, RiskIntelligenceNetwork_Services, Std, ut;

EXPORT Functions := MODULE

		EXPORT GetRealtimeAssessment(DATASET(RiskIntelligenceNetwork_Services.Layouts.realtime_appends_rec) ds_in,
																																														RiskIntelligenceNetwork_Services.IParam.Params in_mod) := FUNCTION
		
					_constants_EntityId := RiskIntelligenceNetwork_Services.Constants.KelEntityIdentifier;
					
					agencyStRec := RECORD
					STRING2 st;
					END;
					
					recids := CHOOSEN(FraudShared.Key_CustomerID('FraudGov')(customer_id = (STRING)in_mod.GlobalCompanyId),1);
					
					agency_state_ds := JOIN(recids, FraudShared.Key_Id(RiskIntelligenceNetwork_Services.Constants.FRAUD_PLATFORM),
																												KEYED(LEFT.RECORD_ID = RIGHT.RECORD_ID),
																												TRANSFORM(agencyStRec,
																																									SELF.st := RIGHT.classification_source.customer_state,
																																									SELF := []));
					
					j2 := PROJECT(ds_in, TRANSFORM(RiskIntelligenceNetwork_Analytics.Layouts.KelInputLayout,
                                                             
																																														 SELF.EmailLastDomain := Std.Str.ToUpperCase(Std.Str.SplitWords(LEFT.batchin_rec.email_Address, '.')[Std.Str.CountWords(LEFT.batchin_rec.email_address, '.')]),
																																															SELF.OttoAddressId := HASH64(stringlib.StringToUpperCase(trim(LEFT.batchin_rec.addr) + '|' + (trim(LEFT.batchin_rec.p_city_name) + 
																																																		if( LEFT.batchin_rec.p_city_name !='' and(LEFT.batchin_rec.st != '' or LEFT.batchin_rec.z5 !=''), ', ', '') + trim(LEFT.batchin_rec.st) +' '+ trim(LEFT.batchin_rec.z5))));
																																															SELF.OttoIpAddressId := HASH64(LEFT.batchin_rec.ip_address), 
																																														 SELF.OttoEmailId := HASH64(LEFT.batchin_rec.email_address),
																																															SELF.OttoSSNId := HASH64(LEFT.batchin_rec.ssn),
	
																																															SELF.OttoPhoneId := (INTEGER)LEFT.batchin_rec.phoneno,
																																															SELF.OttoBankAccountId := HASH64(TRIM(LEFT.batchin_rec.bank_routing_number, LEFT, RIGHT) + '|' + TRIM(LEFT.batchin_rec.bank_account_number, LEFT, RIGHT)),
																																													 //SELF.OttoBankAccountId2 := HASH64(TRIM(LEFT.bank_routing_number_2, LEFT, RIGHT) + '|' + TRIM(LEFT.bank_account_number_2, LEFT, RIGHT)),
																																													 SELF.OttoDriversLicenseId := HASH64(STD.Str.CleanSpaces(TRIM(LEFT.dl_appends[1].dl_number, LEFT, RIGHT)+ '|' + TRIM(LEFT.dl_appends[1].orig_state, LEFT, RIGHT))),                                                                                                                                                                                 
																																													 SELF.event_date := Std.Date.Today(),
																																														//SELF.Customer_State := LEFT.classification_source.Customer_State,
																																												 // fake bank account and dl risk stuff for testing JP
																																												 //self.diddeceased := true,
																																													//self.diddeceaseddate := 20190101;
																																													// end of test code.
																																													// Clean name to avoid blank labels
																																													SELF.batchin_rec.name_first := TRIM(ut.fn_RemoveSpecialChars(LEFT.batchin_rec.name_first)),
																																													SELF.batchin_rec.name_last := TRIM(ut.fn_RemoveSpecialChars(LEFT.batchin_rec.name_last)),
																																													SELF.boca_shell_appends := LEFT.boca_shell_appends[1],
																																													SELF.advo_appends := LEFT.advo_appends[1],
																																													SELF.crim_appends := LEFT.crim_appends[1],
																																													SELF.ip_meta_data := LEFT.ip_meta_data[1],
																																													SELF.pr_best_appends := LEFT.pr_best_appends[1],
																																													SELF.prepaid_phone_appends := LEFT.prepaid_phone_appends[1],
																																													SELF.dl_appends := LEFT.dl_appends[1],
																																													// SELF.BocaShellHit := (INTEGER1)(LEFT.Boca_shell_appends[1].seq > 0 and LEFT.Boca_shell_appends[1].did > 0),
																																													SELF.BocaShellHit := (INTEGER1)(LEFT.Boca_shell_appends[1].did > 0),
																																													SELF.rin_source := 1,
																																													SELF.gc_id := (STRING)in_mod.GlobalCompanyId,
																																													SELF.ind_type := (STRING)in_mod.IndustryType,
																																													SELF.record_id := LEFT.batchin_rec.did,
																																													SELF.agency_state := agency_state_ds[1].st,
																																													// SELF.curr_incar_flag := LEFT.crim_appends[1].curr_incar_flag,
																																													SELF.curr_incar_flag := IF(EXISTS(LEFT.crim_appends(curr_incar_flag='Y')),'Y',''),
																																													SELF.crim_match_type := (INTEGER)LEFT.crim_appends[1].match_type,
																																													SELF.crim_hit := IF(LEFT.crim_appends[1].did <> 0, TRUE, FALSE),
																																													SELF.dl_number := LEFT.dl_appends[1].dl_number,
																																													SELF.dl_state := LEFT.dl_appends[1].orig_state,
																																													SELF.phonesMetaHit := IF(LEFT.prepaid_phone_appends[1].phone <> '', TRUE, FALSE),
																																													SELF.prepaidPhone := LEFT.prepaid_phone_appends[1].prepaid,
																																													SELF.curr_st := LEFT.pr_best_appends[1].best_state,
																																													SELF := LEFT,
																																													SELF := []));
					
					CleanAttributes := KEL.Clean(RiskIntelligenceNetwork_Analytics.Q_Input_Rin(j2).Res0, TRUE /*Remove __Flags*/, TRUE /*Remove __recordcounts*/, TRUE /*Remove _ from Field Names*/);
					
					codesToIgnore := '-99999\', \'-99998\', \'-99997';
					AttrClean := FraudgovKEL.macCleanAnalyticUIOutput(CleanAttributes, RECORDOF(CleanAttributes), codesToIgnore);
											
										/* 
					 COMPUTE ENTITY STATS (RISK INDICATORS)
					*/
					inputrow := j2[1];
					elementEntityContextUids := [_constants_EntityId.PHYSICAL_ADDRESS + inputrow.OttoAddressId, _constants_EntityId.IPADDRESS + inputrow.OttoIpAddressId,
																																																	_constants_EntityId.EMAIL + inputrow.OttoEmailId, _constants_EntityId.SSN + inputrow.OttoSSNId,
																																																	_constants_EntityId.BANKACCOUNT + inputrow.OttoBankAccountId, _constants_EntityId.DLNUMBER + inputrow.OttoDriversLicenseId,
																																																	_constants_EntityId.PHONENO + inputrow.OttoPhoneId];
																																																		
						elementProfiles := FraudgovPlatform.Key_entityprofile(customerid = in_mod.GlobalCompanyId AND industrytype = in_mod.IndustryType AND entitycontextuid IN elementEntityContextUids);


					NicoleAttr := 't17_emaildomaindispflag,t18_ipaddrhostedflag,t18_ipaddrvpnflag,t18_ipaddrtornodeflag,t18_ipaddrlocnonusflag,t18_ipaddrlocmiamiflag,t19_bnkaccthrprepdrtgflag,t1l_dobnotverflag,' +
																						't1_stolidflag,t1_synthidflag,t1_manipidflag,t1_adultidnotseenflag,t1_addrnotverflag,t1l_ssnwaltnaverflag,t1_firstnmnotverflag,t1l_hiriskcviflag,t1l_medriskcviflag,t1_minorwlexidflag,t1_lastnmnotverflag,' +
																						't1_phnnotverflag,t1l_ssnwaddrnotverflag,t1_ssnpriordobflag,t1l_ssnnotverflag,t1l_curraddrnotinagcyjurstflag,t1l_bestdlnotinagcyjurstflag,t1l_hdrsrccatcntlwflag,t1l_iddeceasedflag,t1l_idcurrincarcflag,' +
																						't1l_iddtofdeathaftidactflagev,p1_aotidkrstolidactflagev,p1_aotidkrgenfrdactflagev,p1_aotidkrappfrdactflagev,p1_aotidkrothfrdactflagev,' +
																						't15_ssnpopflag, t1_lexidpopflag, p1_idriskunscrbleflag, p9_addrriskunscrbleflag, p15_ssnriskunscrbleflag, p16_phnriskunscrbleflag, p17_emailriskunscrbleflag, p18_ipaddrriskunscrbleflag,' +
																						'p19_bnkacctriskunscrbleflag, p20_dlriskunscrbleflag';

						EventStatsPrep := FraudGovPlatform_Analytics.macPivotOttoOutput(AttrClean, 'entitycontextuid,t_actuid',//,recordid', 
					NicoleAttr
						);
						
						KnownRiskProfileAttributes := PROJECT(elementProfiles,TRANSFORM(RECORDOF(EventStatsPrep),
																																																																SELF.field := MAP(
																																																																																						LEFT.entitytype = 9 => 'p9_aotaddrkractinagcyflagev',
																																																																																						LEFT.entitytype = 15 => 'p15_aotssnkractinagcyflagev',
																																																																																						LEFT.entitytype = 16 => 'p16_aotphnkractinagcyflagev',
																																																																																						LEFT.entitytype = 17 => 'p17_aotemailkractinagcyflagev',
																																																																																						LEFT.entitytype = 18 => 'p18_aotipaddrkractinagcyflagev',
																																																																																						LEFT.entitytype = 19 => 'p19_aotbnkacctkractinagcyflagev',
																																																																																						LEFT.entitytype = 20 => 'p20_aotdlkractinagcyflagev',''),
																																																																	SELF.value :=(STRING)LEFT.aotkractflagev,
																																																																	SELF.entitycontextuid := '_01' + inputrow.record_id,
																																																																	SELF := []));
																																																																	
								SafeListProfileAttributes := PROJECT(elementProfiles(entitytype IN [9, 16, 18]),TRANSFORM(RECORDOF(EventStatsPrep),
																																																																SELF.field := MAP(
																																																																																						LEFT.entitytype = 9 => 'p9_aotaddrsafeactflagev',
																																																																																						LEFT.entitytype = 16 => 'p16_aotphnsafeactflagev',
																																																																																						LEFT.entitytype = 18 => 'p18_aotipaddrsafeactflagev',''),
																																																																	SELF.value :=(STRING)LEFT.aotsafeactflagev,
																																																																	SELF.entitycontextuid := '_01' + inputrow.record_id,
																																																																	SELF := []));
																																																																	
							MultIdProfileAttributes := PROJECT(elementProfiles(entitytype IN [9,15,19,20]),TRANSFORM(RECORDOF(EventStatsPrep),
																																																																SELF.field := MAP(
																																																																																						LEFT.entitytype = 9 => 'T9_AddrPOBoxMultCurrIDFlagEv',
																																																																																						LEFT.entitytype = 15 => 'T15_SSNMultCurrIDFlagEv',
																																																																																						LEFT.entitytype = 19 => 'T19_BnkAcctMultCurrIDFlagEv',
																																																																																						LEFT.entitytype = 20 => 'T20_DLMultCurrIDFlagEv',''),
																																																																	SELF.value := MAP(
																																																																																						LEFT.entitytype = 9 => LEFT.NVP(name='T9_AddrPOBoxMultCurrIDFlagEv').value,
																																																																																						LEFT.entitytype = 15 => LEFT.NVP(name='T15_SSNMultCurrIDFlagEv').value,
																																																																																						LEFT.entitytype = 19 => LEFT.NVP(name='T19_BnkAcctMultCurrIDFlagEv').value,
																																																																																						LEFT.entitytype = 20 => LEFT.NVP(name='T20_DLMultCurrIDFlagEv').value,''),
																																																																	SELF.entitycontextuid := '_01' + inputrow.record_id,
																																																																	SELF := []));
																																																																		
						EventStatsPrepWithKr := EventStatsPrep + KnownRiskProfileAttributes + SafeListProfileAttributes;

					WeightedResultDefault := JOIN(EventStatsPrepWithKr(Value != ''), FraudGovPlatform.Key_ConfigAttributes, 
																	 LEFT.Field=RIGHT.Field AND ((INTEGER)LEFT.entitycontextuid[2..3] = RIGHT.EntityType OR (INTEGER)LEFT.entitycontextuid[2..3] = 1) AND
																	 (
																		 (
																			 RIGHT.Value NOT IN ['','0'] AND LEFT.Value = RIGHT.Value
																		 )
																		 OR
																		 (
																			 RIGHT.Value IN ['','0'] AND (RIGHT.Low = 0 AND RIGHT.High = 0)
																		 )                           
																		 OR
																		 (
																			 (RIGHT.Low > 0 OR RIGHT.High > 0) AND 
																				 (
																					 (RIGHT.Low > 0 AND (DECIMAL10_3)LEFT.Value >= RIGHT.Low OR RIGHT.Low = 0) AND
																					 (RIGHT.High > 0 AND (DECIMAL10_3)LEFT.Value <= RIGHT.High OR RIGHT.High = 0) 
																				 )
																		 )
																	 ), TRANSFORM({RECORDOF(LEFT), RIGHT.Weight, RIGHT.EntityType}, 
																			SELF.Weight := MAP(RIGHT.Field != '' => RIGHT.Weight, 0),
																			SELF.RiskLevel := MAP(RIGHT.Field != '' => RIGHT.RiskLevel, -1), // If there is no specific configuration for a field assign the risk level to -1 so it can be hidden.
																			SELF.Label := MAP(TRIM(RIGHT.UiDescription) != '' => Std.Str.FindReplace(RIGHT.UiDescription, '{value}', LEFT.Value), LEFT.Label);
																			SELF.field := LEFT.field,
																																								SELF.EntityType := RIGHT.EntityType,														
																																								SELF.IndicatorType := RIGHT.IndicatorType,
																																								SELF.IndicatorDescription := RIGHT.IndicatorDescription,
																			SELF := LEFT), KEYED, LEFT OUTER);

					WeightedResult := JOIN(WeightedResultDefault(Value != ''), FraudGovPlatform.Key_ConfigAttributes, 
																	 //(UNSIGNED)LEFT.customerid = (UNSIGNED)RIGHT.customerid AND (UNSIGNED)LEFT.industrytype= (UNSIGNED)RIGHT.industrytype AND
																	 LEFT.Field=RIGHT.Field AND ((INTEGER)LEFT.entitycontextuid[2..3] = RIGHT.EntityType OR (INTEGER)LEFT.entitycontextuid[2..3] = 1) AND
																	 (
																		 (
																			 RIGHT.Value NOT IN ['','0'] AND LEFT.Value = RIGHT.Value
																		 )
																		 OR
																		 (
																			 RIGHT.Value IN ['','0'] AND (RIGHT.Low = 0 AND RIGHT.High = 0)
																		 )                           
																		 OR
																		 (
																			 (RIGHT.Low > 0 OR RIGHT.High > 0) AND 
																				 (
																					 (RIGHT.Low > 0 AND (DECIMAL10_3)LEFT.Value >= RIGHT.Low OR RIGHT.Low = 0) AND
																					 (RIGHT.High > 0 AND (DECIMAL10_3)LEFT.Value <= RIGHT.High OR RIGHT.High = 0) 
																				 )
																		 )
																	 ), TRANSFORM(RECORDOF(LEFT),
																			SELF.Weight := MAP(RIGHT.Field != '' => RIGHT.Weight, LEFT.Weight),
																			SELF.RiskLevel := MAP(RIGHT.Field != '' => RIGHT.RiskLevel, LEFT.RiskLevel), // If there is no specific configuration for a field assign the risk level to -1 so it can be hidden.
																			SELF.Label := MAP(TRIM(RIGHT.UiDescription) != '' => Std.Str.FindReplace(RIGHT.UiDescription, '{value}', LEFT.Value), LEFT.Label);
																			SELF.field := LEFT.field,
																			SELF.EntityType := MAP(RIGHT.EntityType != 0 => RIGHT.EntityType, LEFT.EntityType),
																			SELF.IndicatorType := MAP(RIGHT.IndicatorType != '' => RIGHT.IndicatorType, LEFT.IndicatorType);
																			SELF.IndicatorDescription := MAP(RIGHT.IndicatorDescription != '' => RIGHT.IndicatorDescription, LEFT.IndicatorDescription);
																			SELF := LEFT), KEYED, LEFT OUTER);

					/* 
					RULES ASSESSMENT
					*/

					 MyRules := FraudGovPlatform.Key_ConfigRules;
					
					 MyRulesCnt := TABLE(MyRules, {RuleName, customerid, industrytype, entitytype, Reccount := COUNT(GROUP)}, RuleName, customerid, entitytype, industrytype, FEW);

						RulesResult := JOIN(EventStatsPrepWithKr(Value != ''), SORT(MyRules, field, -customerid), 
																	 LEFT.Field=RIGHT.Field AND 
																	 (
																		 (
																			 RIGHT.Value NOT IN ['','0'] AND LEFT.Value = RIGHT.Value
																		 )
																		 OR
																		 (
																			 RIGHT.Value IN ['','0'] AND (RIGHT.Low = 0 AND RIGHT.High = 0) AND LEFT.Value = '0'
																		 )                           
																		 OR
																		 (
																			 (RIGHT.Low > 0 OR RIGHT.High > 0) AND 
																				 (
																					 (RIGHT.Low > 0 AND (DECIMAL10_3)LEFT.Value >= RIGHT.Low OR RIGHT.Low = 0) AND
																					 (RIGHT.High > 0 AND (DECIMAL10_3)LEFT.Value <= RIGHT.High OR RIGHT.High = 0) 
																				 )
																		 )
																	 ), TRANSFORM({RECORDOF(LEFT), RIGHT.RuleName, RIGHT.EntityType, RIGHT.Description, INTEGER1 Default}, 
																			//SELF.Weight := MAP(RIGHT.Field != '' => RIGHT.Weight, 0),
																			SELF.RiskLevel := MAP(RIGHT.Field != '' => RIGHT.RiskLevel, -1), // If there is no specific configuration for a field assign the risk level to -1 so it can be hidden.
																			SELF.field := LEFT.field,
																																								SELF.RuleName := RIGHT.RuleName,
																																								SELF.EntityType := RIGHT.EntityType,
																																								SELF.Description := RIGHT.Description,
																																								SELF.Default := (INTEGER1)(RIGHT.customerid = 0),
																			SELF := LEFT), MANY LOOKUP, LEFT OUTER)(RiskLevel>0);
																		

					RulesResultAggPrep := TABLE(RulesResult, {entitycontextuid, entitytype, rulename, Default, Description, risklevel, reccount := COUNT(GROUP)}, 
																 entitycontextuid, entitytype, rulename, Default, Description, risklevel, MERGE);

					RulesResultAgg := DEDUP(SORT(DISTRIBUTE(RulesResultAggPrep, HASH64(entitycontextuid)), 
																 entitycontextuid, entitytype, rulename, default, local), 
																 entitycontextuid, entitytype, rulename, local); 

					// Add how many flags for each rule matched
					RulesFlagsMatched  := JOIN(RulesResultAgg, MyRulesCnt, 
																	LEFT.RuleName = RIGHT.RuleName AND LEFT.reccount = RIGHT.reccount, 
																	TRANSFORM({LEFT.entitycontextuid,
																	UNSIGNED entitytype, 
																	STRING100 rulename,
																	STRING250 description,
																	INTEGER1 risklevel}, SELF := LEFT),
																	LOOKUP, HASH);


					//need to turn this into 
					EntityEventAssessment := TABLE(RulesFlagsMatched, 
															{entitycontextuid,
															entitytype, INTEGER1 risklevel := MAX(GROUP, risklevel)}, 
															entitycontextuid, entitytype, MERGE);


					rAssessment := RECORD
						STRING entitycontextuid;
						INTEGER1 P1_IDRiskIndx;// 1
						INTEGER1 P15_SSNRiskIndx;// 15
						INTEGER1 P16_PhnRiskIndx;// 16
						INTEGER1 P17_EmailRiskIndx;// 17
						INTEGER1 P19_BnkAcctRiskIndx;// 19
						INTEGER1 P20_DLRiskIndx;// 20
						INTEGER1 P18_IPAddrRiskIndx;// 18
						INTEGER1 P9_AddrRiskIndx;// 9
					END;

					EntityAssessmentPrep := SORT(PROJECT(EntityEventAssessment, 
																			TRANSFORM(rAssessment, 
																				SELF.P1_IDRiskIndx := MAP(LEFT.EntityType = 1 => LEFT.RiskLevel, 0),
																				SELF.P15_SSNRiskIndx := MAP(LEFT.EntityType = 15 => LEFT.RiskLevel, 0),
																				SELF.P16_PhnRiskIndx := MAP(LEFT.EntityType = 16 => LEFT.RiskLevel, 0),
																				SELF.P17_EmailRiskIndx  := MAP(LEFT.EntityType = 17 => LEFT.RiskLevel, 0),
																				SELF.P19_BnkAcctRiskIndx := MAP(LEFT.EntityType = 19 => LEFT.RiskLevel, 0),
																				SELF.P20_DLRiskIndx := MAP(LEFT.EntityType = 20 => LEFT.RiskLevel, 0),
																				SELF.P18_IPAddrRiskIndx := MAP(LEFT.EntityType = 18 => LEFT.RiskLevel, 0),
																				SELF.P9_AddrRiskIndx := MAP(LEFT.EntityType = 9 => LEFT.RiskLevel, 0),
																				SELF := LEFT, SELF := [])),entitycontextuid, LOCAL);
																				

					EntityAssessment := PROJECT(TABLE(EntityAssessmentPrep, {
																 entitycontextuid, 
																 INTEGER1 P1_IDRiskIndx := MAX(GROUP, P1_IDRiskIndx),
																 INTEGER1 P15_SSNRiskIndx:= MAX(GROUP, P15_SSNRiskIndx),
																 INTEGER1 P16_PhnRiskIndx:= MAX(GROUP, P16_PhnRiskIndx),
																 INTEGER1 P17_EmailRiskIndx:= MAX(GROUP, P17_EmailRiskIndx),
																 INTEGER1 P19_BnkAcctRiskIndx:= MAX(GROUP, P19_BnkAcctRiskIndx),
																 INTEGER1 P20_DLRiskIndx:= MAX(GROUP, P20_DLRiskIndx),
																 INTEGER1 P18_IPAddrRiskIndx:= MAX(GROUP, P18_IPAddrRiskIndx),
																 INTEGER1 P9_AddrRiskIndx:= MAX(GROUP, P9_AddrRiskIndx)}, entitycontextuid, MERGE),
																	TRANSFORM(RECORDOF(LEFT), 
																		SELF.P1_IDRiskIndx := MAP(LEFT.P1_IDRiskIndx=0=>1, LEFT.P1_IDRiskIndx),
																		SELF.P15_SSNRiskIndx:= MAP(LEFT.P15_SSNRiskIndx=0=>1, LEFT.P15_SSNRiskIndx),
																		SELF.P16_PhnRiskIndx:= MAP(LEFT.P16_PhnRiskIndx=0=>1, LEFT.P16_PhnRiskIndx),
																		SELF.P17_EmailRiskIndx:= MAP(LEFT.P17_EmailRiskIndx=0=>1, LEFT.P17_EmailRiskIndx),
																		SELF.P19_BnkAcctRiskIndx:= MAP(LEFT.P19_BnkAcctRiskIndx=0=>1, LEFT.P19_BnkAcctRiskIndx), 
																		SELF.P20_DLRiskIndx:= MAP(LEFT.P20_DLRiskIndx=0=>1, LEFT.P20_DLRiskIndx), 
																		SELF.P18_IPAddrRiskIndx:= MAP(LEFT.P18_IPAddrRiskIndx=0=>1, LEFT.P18_IPAddrRiskIndx), 
																		SELF.P9_AddrRiskIndx:= MAP(LEFT.P9_AddrRiskIndx=0=>1, LEFT.P9_AddrRiskIndx),
																		SELF := LEFT)); // PROJECT to DEFAULT 1 for low risk for anything without any risk.						  
																
					
					rulesFlagsMatched_final := PROJECT(RulesFlagsMatched,TRANSFORM(RiskIntelligenceNetwork_Analytics.Layouts.LayoutRulesFlagsMatched,
																																																							SELF.acctno := '1',
																																																							SELF := LEFT));
					entityStats_final := PROJECT(WeightedResult(risklevel > -1),TRANSFORM(RiskIntelligenceNetwork_Analytics.Layouts.LayoutEntityStats,
																																																							SELF.acctno := '1',
																																																							SELF := LEFT,
																																																							SELF := []));

					results := PROJECT(EntityAssessment,TRANSFORM(RiskIntelligenceNetwork_analytics.Layouts.LayoutRiskScore,
																																																															SELF.record_id := 1,
																																																															SELF.RulesFlagsMatched := rulesFlagsMatched_final,
																																																															SELF.EntityStats := entityStats_final,
																																																															SELF := LEFT));
																																																															
						// output(ds_in,named('analytics_ds_in'));
						// output(j2,named('analytics_j2'));
						// output(CleanAttributes,named('analytics_CleanAttributes'));
						// output(AttrClean,named('analytics_AttrClean'));
						// output(EventStatsPrep,named('analytics_EventStatsPrep'));
						// output(elementEntityContextUids,named('analytics_elementEntityContextUids'));
						// output(elementProfiles,named('analytics_elementProfiles'));
						// output(EventStatsPrepWithKr,named('analytics_EventStatsPrepWithKr'));
						// output(WeightedResult,named('analytics_WeightedResult'));
						// output(RulesResult,named('analytics_RulesResult'));
						// output(RulesResultAggPrep,named('analytics_RulesResultAggPrep'));
						// output(RulesResultAgg,named('analytics_RulesResultAgg'));
						// output(RulesFlagsMatched,named('analytics_RulesFlagsMatched'));
						// output(entityStats_final,named('analytics_entityStats_final'));
						// output(rulesFlagsMatched_final,named('analytics_rulesFlagsMatched_final'));
						// output(results,named('analytics_results'));
						
					RETURN results;
		END;
		
	EXPORT GetAPILiveAssessment(DATASET(RiskIntelligenceNetwork_Services.Layouts.realtime_appends_rec) ds_in,
																																														RiskIntelligenceNetwork_Services.IParam.Params in_mod) := FUNCTION
		
					_constants_EntityId := RiskIntelligenceNetwork_Services.Constants.KelEntityIdentifier;
					
					agencyStRec := RECORD
					STRING2 st;
					END;
					
					recids := CHOOSEN(FraudShared.Key_CustomerID('FraudGov')(customer_id = (STRING)in_mod.GlobalCompanyId),1);
					
					//Get agency state
					agency_state_ds := JOIN(recids, FraudShared.Key_Id(RiskIntelligenceNetwork_Services.Constants.FRAUD_PLATFORM),
																												KEYED(LEFT.RECORD_ID = RIGHT.RECORD_ID),
																												TRANSFORM(agencyStRec,
																																									SELF.st := RIGHT.classification_source.customer_state,
																																									SELF := []));
																																									
						//append bank details
						// ds_in_w_bank := AppendBankDetails.macAppendBankDetails(ds_in,batchin_rec.bank_routing_number,'bankDetails_');
						ds_in_w_bank := ds_in;
						
						//append disposable email flag
						ds_in_w_disposable_email := AppendDisposableEmailDomainFlag.macAppendDisposableEmailDomainFlag(ds_in_w_bank,batchin_rec.email_address);
					
					//prepare KEL input layout
					j2 := PROJECT(ds_in_w_disposable_email, TRANSFORM(RiskIntelligenceNetwork_Analytics.Layouts.KelInputLayout,
                                                             
																																														 SELF.EmailLastDomain := Std.Str.ToUpperCase(Std.Str.SplitWords(LEFT.batchin_rec.email_Address, '.')[Std.Str.CountWords(LEFT.batchin_rec.email_address, '.')]),
																																															SELF.OttoAddressId := HASH64(stringlib.StringToUpperCase(trim(LEFT.batchin_rec.addr) + '|' + (trim(LEFT.batchin_rec.p_city_name) + 
																																																		if( LEFT.batchin_rec.p_city_name !='' and(LEFT.batchin_rec.st != '' or LEFT.batchin_rec.z5 !=''), ', ', '') + trim(LEFT.batchin_rec.st) +' '+ trim(LEFT.batchin_rec.z5))));
																																															SELF.OttoIpAddressId := HASH64(LEFT.batchin_rec.ip_address), 
																																														 SELF.OttoEmailId := HASH64(LEFT.batchin_rec.email_address),
																																															SELF.OttoSSNId := HASH64(LEFT.batchin_rec.ssn),
																																															// SELF.OttoSSNId := 7687709163006051155, //kr ssn
																																															SELF.OttoPhoneId := (INTEGER)LEFT.batchin_rec.phoneno,
																																															SELF.OttoBankAccountId := HASH64(TRIM(LEFT.batchin_rec.bank_routing_number, LEFT, RIGHT) + '|' + TRIM(LEFT.batchin_rec.bank_account_number, LEFT, RIGHT)),
																																													 //SELF.OttoBankAccountId2 := HASH64(TRIM(LEFT.bank_routing_number_2, LEFT, RIGHT) + '|' + TRIM(LEFT.bank_account_number_2, LEFT, RIGHT)),
																																													 SELF.OttoDriversLicenseId := HASH64(STD.Str.CleanSpaces(TRIM(LEFT.batchin_rec.dl_number, LEFT, RIGHT)+ '|' + TRIM(LEFT.batchin_rec.dl_state, LEFT, RIGHT))),                                                                                                                                                                                 
																																													 SELF.entity_context_uid := _constants_EntityId.LEXID + (STRING)LEFT.batchin_rec.did,
																																													 SELF.event_date := Std.Date.Today(),

																																													// Clean name to avoid blank labels
																																													SELF.batchin_rec.name_first := TRIM(ut.fn_RemoveSpecialChars(LEFT.batchin_rec.name_first)),
																																													SELF.batchin_rec.name_last := TRIM(ut.fn_RemoveSpecialChars(LEFT.batchin_rec.name_last)),
																																													SELF.boca_shell_appends := LEFT.boca_shell_appends[1],
																																													SELF.advo_appends := LEFT.advo_appends[1],
																																													SELF.crim_appends := LEFT.crim_appends[1],
																																													SELF.ip_meta_data := LEFT.ip_meta_data[1],
																																													SELF.pr_best_appends := LEFT.pr_best_appends[1],
																																													SELF.prepaid_phone_appends := LEFT.prepaid_phone_appends[1],
																																													SELF.dl_appends := LEFT.dl_appends[1],
																																													// SELF.BocaShellHit := (INTEGER1)(LEFT.Boca_shell_appends[1].seq > 0 and LEFT.Boca_shell_appends[1].did > 0),
																																													SELF.BocaShellHit := (INTEGER1)(LEFT.Boca_shell_appends[1].did > 0),
																																													SELF.rin_source := 1,
																																													SELF.gc_id := (STRING)in_mod.GlobalCompanyId,
																																													SELF.ind_type := (STRING)in_mod.IndustryType,
																																													SELF.record_id := LEFT.batchin_rec.did,
																																													SELF.agency_state := agency_state_ds[1].st,
																																													SELF.curr_incar_flag := IF(EXISTS(LEFT.crim_appends(curr_incar_flag='Y')),'Y',''),
																																													SELF.crim_match_type := (INTEGER)LEFT.crim_appends[1].match_type,
																																													SELF.crim_hit := IF(LEFT.crim_appends[1].did <> 0, TRUE, FALSE),
																																													//Note: This is different from the real-time scoring function..
																																													//live assessment uses input not the appends 
																																													SELF.dl_number := LEFT.batchin_rec.dl_number,
																																													SELF.dl_state := LEFT.batchin_rec.dl_state,
																																													SELF.phonesMetaHit := IF(LEFT.prepaid_phone_appends[1].phone <> '', TRUE, FALSE),
																																													SELF.prepaidPhone := LEFT.prepaid_phone_appends[1].prepaid,
																																													SELF.curr_st := LEFT.batchin_rec.st,
																																													SELF := LEFT,
																																													SELF := []));
						
						entityContextUidRow := RECORD
							STRING20 acctno;
							UNSIGNED6 gc_id;
							UNSIGNED2 ind_type;
							STRING entity_context_uid;
							STRING id_entity_context_uid;
						END;
						;
						
						entityContextUidRow NormIt(RiskIntelligenceNetwork_Analytics.Layouts.KelInputLayout L, INTEGER C) := TRANSFORM
							SELF.acctno := L.batchin_rec.acctno;
							SELF.gc_id := (UNSIGNED)L.gc_id;
							SELF.ind_type := (UNSIGNED)L.ind_type;
							SELF.entity_context_uid := CHOOSE(C,
																																																									_constants_EntityId.PHYSICAL_ADDRESS + L.OttoAddressId,
																																																									_constants_EntityId.IPADDRESS + L.OttoIpAddressId,
																																																									_constants_EntityId.EMAIL + L.OttoEmailId,
																																																									_constants_EntityId.SSN + L.OttoSSNId,
																																																									_constants_EntityId.BANKACCOUNT + L.OttoBankAccountId,
																																																									_constants_EntityId.DLNUMBER + L.OttoDriversLicenseId,
																																																									_constants_EntityId.PHONENO + L.OttoPhoneId, 
																																																									_constants_EntityId.LEXID + L.record_id);
							SELF.id_entity_context_uid := _constants_EntityId.LEXID + L.record_id;
						END;
						
						entityContextUids := NORMALIZE(j2,8,NormIt(LEFT,COUNTER));
						/*
					inputrow := j2[1];
					
					elementEntityContextUids := [_constants_EntityId.PHYSICAL_ADDRESS + inputrow.OttoAddressId, _constants_EntityId.IPADDRESS + inputrow.OttoIpAddressId,
																																																	_constants_EntityId.EMAIL + inputrow.OttoEmailId, _constants_EntityId.SSN + inputrow.OttoSSNId,
																																																	_constants_EntityId.BANKACCOUNT + inputrow.OttoBankAccountId, _constants_EntityId.DLNUMBER + inputrow.OttoDriversLicenseId,
																																																	_constants_EntityId.PHONENO + inputrow.OttoPhoneId, _constants_EntityId.LEXID + inputrow.record_id];				
					*/
					raw_Attributes := RiskIntelligenceNetwork_Analytics.Q_Input_Rin(j2).Res0;
					
					CleanAttributes := KEL.Clean(raw_Attributes, TRUE /*Remove __Flags*/, TRUE /*Remove __recordcounts*/, TRUE /*Remove _ from Field Names*/);
					
					codesToIgnore := '-99999\', \'-99998\', \'-99997';
					AttrClean := FraudgovKEL.macCleanAnalyticUIOutput(CleanAttributes, RECORDOF(CleanAttributes), codesToIgnore);
											
										/* 
					 COMPUTE ENTITY STATS (RISK INDICATORS)
					*/

					NicoleAttr := 't17_emaildomaindispflag,t18_ipaddrisispflag,t18_ipaddrhostedflag,t18_ipaddrvpnflag,t18_ipaddrtornodeflag,t18_ipaddrlocnonusflag,t18_ipaddrlocmiamiflag,t19_bnkaccthrprepdrtgflag,t1l_dobnotverflag,' +
																							't9_addrisvacantflag, t9_addrisinvalidflag, t9_addriscmraflag, t15_ssnisinvalidflag, t20_dlisinvalidflag, t16_phnprepdflag,' +
																							't1_stolidflag,t1_synthidflag,t1_manipidflag,t1_adultidnotseenflag,t1_addrnotverflag,t1l_ssnwaltnaverflag,t1_firstnmnotverflag,t1l_hiriskcviflag,t1l_medriskcviflag,t1_minorwlexidflag,t1_lastnmnotverflag,' +
																							't1_phnnotverflag,t1l_ssnwaddrnotverflag,t1_ssnpriordobflag,t1l_ssnnotverflag,t1l_curraddrnotinagcyjurstflag,t1l_bestdlnotinagcyjurstflag,t1l_hdrsrccatcntlwflag,t1l_iddeceasedflag,t1l_idcurrincarcflag,' +
																							't1l_iddtofdeathaftidactflagev,t16_phnisinvalidflag,p1_aotidkrstolidactflagev,p1_aotidkrgenfrdactflagev,p1_aotidkrappfrdactflagev,p1_aotidkrothfrdactflagev,' +
																							't15_ssnpopflag, t1_lexidpopflag, p1_idriskunscrbleflag, p9_addrriskunscrbleflag, p15_ssnriskunscrbleflag, p16_phnriskunscrbleflag, p17_emailriskunscrbleflag, p18_ipaddrriskunscrbleflag,' +
																							'p19_bnkacctriskunscrbleflag, p20_dlriskunscrbleflag';

						EventStatsPrep := FraudGovPlatform_Analytics.macPivotOttoOutput(AttrClean, 'entitycontextuid,t_actuid',//,recordid', 
					NicoleAttr
						);
						
							//Get profile rows for each element of input (and identity)
							//will be used later to get element KR attributes
						// elementProfiles := FraudgovPlatform.Key_entityprofile(customerid = in_mod.GlobalCompanyId AND industrytype = in_mod.IndustryType AND entitycontextuid IN elementEntityContextUids);
						elementProfiles := JOIN(entityContextUids,FraudgovPlatform.Key_entityprofile, KEYED(LEFT.gc_id = RIGHT.customerid AND LEFT.ind_type = RIGHT.industrytype AND LEFT.entity_context_uid = RIGHT.entitycontextuid));
						
						identityProfiles := elementProfiles(entitytype=1);
						
						RECORDOF(EventStatsPrep) NormIdAttrs(RECORDOF(identityProfiles) L, INTEGER C) := TRANSFORM
											kr_nvp := L.Nvp(Std.Str.Find(name,'p1_aotidkr')>0);
											SELF.field := kr_nvp[C].name;
											SELF.value := kr_nvp[C].value;
											SELF.entitycontextuid := L.entity_context_uid;
											SELF.t_actuid := L.acctno;
											SELF.entityhash := L.entity_context_uid + '|' + L.acctno;
											SELF := [];
						END;
						
						KnownRiskElementProfileAttributes := PROJECT(elementProfiles(entitytype<>1),TRANSFORM(RECORDOF(EventStatsPrep),
																																																																SELF.field := MAP(
																																																																																						LEFT.entitytype = 9 => 'p9_aotaddrkractinagcyflagev',
																																																																																						LEFT.entitytype = 15 => 'p15_aotssnkractinagcyflagev',
																																																																																						LEFT.entitytype = 16 => 'p16_aotphnkractinagcyflagev',
																																																																																						LEFT.entitytype = 17 => 'p17_aotemailkractinagcyflagev',
																																																																																						LEFT.entitytype = 18 => 'p18_aotipaddrkractinagcyflagev',
																																																																																						LEFT.entitytype = 19 => 'p19_aotbnkacctkractinagcyflagev',
																																																																																						LEFT.entitytype = 20 => 'p20_aotdlkractinagcyflagev',''),
																																																																	SELF.value :=(STRING)LEFT.aotkractflagev,
																																																																	SELF.entitycontextuid := LEFT.id_entity_context_uid,
																																																																	SELF.t_actuid := LEFT.acctno,
																																																																	SELF.entityhash := IF(LEFT.id_entity_context_uid = '_010','',LEFT.id_entity_context_uid) + '|' + LEFT.acctno,
																																																																	SELF := []));
																																																																	
								/*KnownRiskIDProfileAttributes := IF(EXISTS(identityProfiles),
																																																								PROJECT(identityProfiles[1].Nvp(Std.Str.Find(name,'p1_aotidkr')>0),
																																																													TRANSFORM(RECORDOF(EventStatsPrep),
																																																																										SELF.field := LEFT.name,
																																																																										SELF.value := LEFT.value,
																																																																										SELF.entitycontextuid := LEFT.personentitycontextuid,
																																																																										SELF.t_actuid := LEFT.acctno,
																																																																										SELF.entityhash := LEFT.id_entity_context_uid + '|' + LEFT.acctno,
																																																																											SELF := [])),
																																																				DATASET([], RECORDOF(EventStatsPrep)));*/
																																																				
								KnownRiskIDProfileAttributes := NORMALIZE(identityProfiles,COUNT(identityProfiles[1].Nvp(Std.Str.Find(name,'p1_aotidkr')>0)), NormIdAttrs(LEFT,COUNTER));
								KnownRiskIDSharingAgencyDesc := KnownRiskIDProfileAttributes(Std.Str.Find(field,'ShrdNewSrcAgencyDescEv')>0);
																																																																	
								SafeListProfileAttributes := PROJECT(elementProfiles(entitytype IN [9, 16, 18]),TRANSFORM(RECORDOF(EventStatsPrep),
																																																																SELF.field := MAP(
																																																																																						LEFT.entitytype = 9 => 'p9_aotaddrsafeactflagev',
																																																																																						LEFT.entitytype = 16 => 'p16_aotphnsafeactflagev',
																																																																																						LEFT.entitytype = 18 => 'p18_aotipaddrsafeactflagev',''),
																																																																	SELF.value :=(STRING)LEFT.aotsafeactflagev,
																																																																	SELF.entitycontextuid := LEFT.id_entity_context_uid,
																																																																	SELF.t_actuid := LEFT.acctno,
																																																																	SELF.entityhash := IF(LEFT.id_entity_context_uid = '_010','',LEFT.id_entity_context_uid) + '|' + LEFT.acctno,
																																																																	SELF := []));
																																																																	
									MultiIdProfileAttributes := PROJECT(elementProfiles(entitytype IN [9, 15, 19, 20]),TRANSFORM(RECORDOF(EventStatsPrep),
																																																																SELF.field := MAP(
																																																																																						LEFT.entitytype = 9 => 't9_addrpoboxmultcurridflagev',
																																																																																						LEFT.entitytype = 15 => 't15_ssnmultcurridflagev',
																																																																																						LEFT.entitytype = 19 => 't19_bnkacctmultcurridflagev',
																																																																																						LEFT.entitytype = 20 => 't20_dlmultcurridflagev',''),
																																																																	SELF.value :=MAP(
																																																																																						LEFT.entitytype = 9 => 		(STRING)LEFT.NVP(name='t9_addrpoboxmultcurridflagev')[1].value,
																																																																																						LEFT.entitytype = 15 => (STRING)LEFT.NVP(name='t15_ssnmultcurridflagev')[1].value,
																																																																																						LEFT.entitytype = 19 => (STRING)LEFT.NVP(name='t19_bnkacctmultcurridflagev')[1].value,
																																																																																						LEFT.entitytype = 20 => (STRING)LEFT.NVP(name='t20_dlmultcurridflagev')[1].value,''),
																																																																	SELF.entitycontextuid := LEFT.id_entity_context_uid,
																																																																	SELF.t_actuid := LEFT.acctno,
																																																																	SELF.entityhash := IF(LEFT.id_entity_context_uid = '_010','',LEFT.id_entity_context_uid) + '|' + LEFT.acctno,
																																																																	SELF := []));
																																																																		
						EventStatsPrepWithKr := DEDUP(SORT(EventStatsPrep + KnownRiskElementProfileAttributes + SafeListProfileAttributes + MultiIdProfileAttributes + KnownRiskIDProfileAttributes,entityhash,field),entityhash,field);

					WeightedResultDefault := JOIN(EventStatsPrepWithKr(Value != ''), FraudGovPlatform.Key_ConfigAttributes, 
																	 LEFT.Field=RIGHT.Field AND ((INTEGER)LEFT.entitycontextuid[2..3] = RIGHT.EntityType OR (INTEGER)LEFT.entitycontextuid[2..3] = 1) AND
																	 (
																		 (
																			 RIGHT.Value NOT IN ['','0'] AND LEFT.Value = RIGHT.Value
																		 )
																		 OR
																		 (
																			 RIGHT.Value IN ['','0'] AND (RIGHT.Low = 0 AND RIGHT.High = 0)
																		 )                           
																		 OR
																		 (
																			 (RIGHT.Low > 0 OR RIGHT.High > 0) AND 
																				 (
																					 (RIGHT.Low > 0 AND (DECIMAL10_3)LEFT.Value >= RIGHT.Low OR RIGHT.Low = 0) AND
																					 (RIGHT.High > 0 AND (DECIMAL10_3)LEFT.Value <= RIGHT.High OR RIGHT.High = 0) 
																				 )
																		 )
																	 ), TRANSFORM({RECORDOF(LEFT), RIGHT.Weight, RIGHT.EntityType}, 
																			SELF.Weight := MAP(RIGHT.Field != '' => RIGHT.Weight, 0),
																			SELF.RiskLevel := MAP(RIGHT.Field != '' => RIGHT.RiskLevel, -1), // If there is no specific configuration for a field assign the risk level to -1 so it can be hidden.
																			SELF.Label := MAP(TRIM(RIGHT.UiDescription) != '' => Std.Str.FindReplace(RIGHT.UiDescription, '{value}', LEFT.Value), LEFT.Label);
																			SELF.field := LEFT.field,
																			SELF.EntityType := RIGHT.EntityType,														
																			SELF.IndicatorType := RIGHT.IndicatorType,
																			SELF.IndicatorDescription := RIGHT.IndicatorDescription,
																			SELF.entitycontextuid := IF(LEFT.entitycontextuid = '_010','',LEFT.entitycontextuid),
																			SELF := LEFT), KEYED, LEFT OUTER);

					WeightedResult := JOIN(WeightedResultDefault(Value != ''), FraudGovPlatform.Key_ConfigAttributes, 
																	 //(UNSIGNED)LEFT.customerid = (UNSIGNED)RIGHT.customerid AND (UNSIGNED)LEFT.industrytype= (UNSIGNED)RIGHT.industrytype AND
																	 LEFT.Field=RIGHT.Field AND ((INTEGER)LEFT.entitycontextuid[2..3] = RIGHT.EntityType OR (INTEGER)LEFT.entitycontextuid[2..3] = 1) AND
																	 (
																		 (
																			 RIGHT.Value NOT IN ['','0'] AND LEFT.Value = RIGHT.Value
																		 )
																		 OR
																		 (
																			 RIGHT.Value IN ['','0'] AND (RIGHT.Low = 0 AND RIGHT.High = 0)
																		 )                           
																		 OR
																		 (
																			 (RIGHT.Low > 0 OR RIGHT.High > 0) AND 
																				 (
																					 (RIGHT.Low > 0 AND (DECIMAL10_3)LEFT.Value >= RIGHT.Low OR RIGHT.Low = 0) AND
																					 (RIGHT.High > 0 AND (DECIMAL10_3)LEFT.Value <= RIGHT.High OR RIGHT.High = 0) 
																				 )
																		 )
																	 ), TRANSFORM(RECORDOF(LEFT),
																			SELF.Weight := MAP(RIGHT.Field != '' => RIGHT.Weight, LEFT.Weight),
																			SELF.RiskLevel := MAP(RIGHT.Field != '' => RIGHT.RiskLevel, LEFT.RiskLevel), // If there is no specific configuration for a field assign the risk level to -1 so it can be hidden.
																			SELF.Label := MAP(TRIM(RIGHT.UiDescription) != '' => Std.Str.FindReplace(RIGHT.UiDescription, '{value}', LEFT.Value), LEFT.Label);
																			SELF.field := LEFT.field,
																			SELF.EntityType := MAP(RIGHT.EntityType != 0 => RIGHT.EntityType, LEFT.EntityType),
																			SELF.IndicatorType := MAP(RIGHT.IndicatorType != '' => RIGHT.IndicatorType, LEFT.IndicatorType);
																			SELF.IndicatorDescription := MAP(RIGHT.IndicatorDescription != '' => RIGHT.IndicatorDescription, LEFT.IndicatorDescription);
																			SELF.entitycontextuid := IF(LEFT.entitycontextuid = '_010','',LEFT.entitycontextuid);
																			SELF := LEFT), KEYED, LEFT OUTER);

					/* 
					RULES ASSESSMENT
					*/

					 MyRules := FraudGovPlatform.Key_ConfigRules;
					
					 MyRulesCnt := TABLE(MyRules, {RuleName, customerid, industrytype, entitytype, Reccount := COUNT(GROUP)}, RuleName, customerid, entitytype, industrytype, FEW);

						RulesResult := JOIN(EventStatsPrepWithKr(Value != ''), SORT(MyRules, field, -customerid), 
																	 LEFT.Field=RIGHT.Field AND 
																	 (
																		 (
																			 RIGHT.Value NOT IN ['','0'] AND LEFT.Value = RIGHT.Value
																		 )
																		 OR
																		 (
																			 RIGHT.Value IN ['','0'] AND (RIGHT.Low = 0 AND RIGHT.High = 0) AND LEFT.Value = '0'
																		 )                           
																		 OR
																		 (
																			 (RIGHT.Low > 0 OR RIGHT.High > 0) AND 
																				 (
																					 (RIGHT.Low > 0 AND (DECIMAL10_3)LEFT.Value >= RIGHT.Low OR RIGHT.Low = 0) AND
																					 (RIGHT.High > 0 AND (DECIMAL10_3)LEFT.Value <= RIGHT.High OR RIGHT.High = 0) 
																				 )
																		 )
																	 ), TRANSFORM({RECORDOF(LEFT), RIGHT.RuleName, RIGHT.EntityType, RIGHT.Description, INTEGER1 Default}, 
																			//SELF.Weight := MAP(RIGHT.Field != '' => RIGHT.Weight, 0),
																			SELF.RiskLevel := MAP(RIGHT.Field != '' => RIGHT.RiskLevel, -1), // If there is no specific configuration for a field assign the risk level to -1 so it can be hidden.
																			SELF.field := LEFT.field,
																			SELF.RuleName := RIGHT.RuleName,
																			SELF.EntityType := RIGHT.EntityType,
																			SELF.Description := RIGHT.Description,
																			SELF.Default := (INTEGER1)(RIGHT.customerid = 0),
																			SELF.entitycontextuid := IF(LEFT.entitycontextuid = '_010','',LEFT.entitycontextuid),
																			SELF := LEFT), MANY LOOKUP, LEFT OUTER)(RiskLevel>0);
																		

					RulesResultAggPrep := TABLE(RulesResult, {t_actuid, entitycontextuid, entitytype, rulename, Default, Description, risklevel, reccount := COUNT(GROUP)}, 
																 t_actuid, entitycontextuid, entitytype, rulename, Default, Description, risklevel, MERGE);

					RulesResultAgg := DEDUP(SORT(DISTRIBUTE(RulesResultAggPrep, HASH64(entitycontextuid)), 
																 t_actuid, entitycontextuid, entitytype, rulename, default, local), 
																 t_actuid, entitycontextuid, entitytype, rulename, local); 

					// Add how many flags for each rule matched
					RulesFlagsMatched  := JOIN(RulesResultAgg, MyRulesCnt, 
																	LEFT.RuleName = RIGHT.RuleName AND LEFT.reccount = RIGHT.reccount, 
																	TRANSFORM({LEFT.t_actuid,
																	LEFT.entitycontextuid,
																	UNSIGNED entitytype, 
																	STRING100 rulename,
																	STRING250 description,
																	INTEGER1 risklevel}, SELF := LEFT),
																	LOOKUP, HASH);


					//need to turn this into 
					EntityEventAssessment := TABLE(RulesFlagsMatched, 
															{t_actuid, entitycontextuid,
															entitytype, INTEGER1 risklevel := MAX(GROUP, risklevel)}, 
															t_actuid, entitycontextuid, entitytype, MERGE);


					rAssessment := RECORD
						STRING acctno;
						STRING entitycontextuid;
						INTEGER1 P1_IDRiskIndx;// 1
						INTEGER1 P15_SSNRiskIndx;// 15
						INTEGER1 P16_PhnRiskIndx;// 16
						INTEGER1 P17_EmailRiskIndx;// 17
						INTEGER1 P19_BnkAcctRiskIndx;// 19
						INTEGER1 P20_DLRiskIndx;// 20
						INTEGER1 P18_IPAddrRiskIndx;// 18
						INTEGER1 P9_AddrRiskIndx;// 9
					END;

					EntityAssessmentPrep := SORT(PROJECT(EntityEventAssessment, 
																			TRANSFORM(rAssessment, 
																				SELF.acctno := LEFT.t_actuid,
																				SELF.P1_IDRiskIndx := MAP(LEFT.EntityType = 1 => LEFT.RiskLevel, 0),
																				SELF.P15_SSNRiskIndx := MAP(LEFT.EntityType = 15 => LEFT.RiskLevel, 0),
																				SELF.P16_PhnRiskIndx := MAP(LEFT.EntityType = 16 => LEFT.RiskLevel, 0),
																				SELF.P17_EmailRiskIndx  := MAP(LEFT.EntityType = 17 => LEFT.RiskLevel, 0),
																				SELF.P19_BnkAcctRiskIndx := MAP(LEFT.EntityType = 19 => LEFT.RiskLevel, 0),
																				SELF.P20_DLRiskIndx := MAP(LEFT.EntityType = 20 => LEFT.RiskLevel, 0),
																				SELF.P18_IPAddrRiskIndx := MAP(LEFT.EntityType = 18 => LEFT.RiskLevel, 0),
																				SELF.P9_AddrRiskIndx := MAP(LEFT.EntityType = 9 => LEFT.RiskLevel, 0),
																				SELF := LEFT, SELF := [])),entitycontextuid, LOCAL);
																				

					EntityAssessment := PROJECT(TABLE(EntityAssessmentPrep, {
																	acctno,
																 entitycontextuid, 
																 INTEGER1 P1_IDRiskIndx := MAX(GROUP, P1_IDRiskIndx),
																 INTEGER1 P15_SSNRiskIndx:= MAX(GROUP, P15_SSNRiskIndx),
																 INTEGER1 P16_PhnRiskIndx:= MAX(GROUP, P16_PhnRiskIndx),
																 INTEGER1 P17_EmailRiskIndx:= MAX(GROUP, P17_EmailRiskIndx),
																 INTEGER1 P19_BnkAcctRiskIndx:= MAX(GROUP, P19_BnkAcctRiskIndx),
																 INTEGER1 P20_DLRiskIndx:= MAX(GROUP, P20_DLRiskIndx),
																 INTEGER1 P18_IPAddrRiskIndx:= MAX(GROUP, P18_IPAddrRiskIndx),
																 INTEGER1 P9_AddrRiskIndx:= MAX(GROUP, P9_AddrRiskIndx)},acctno, entitycontextuid, MERGE),
																	TRANSFORM(RECORDOF(LEFT), 
																		SELF.P1_IDRiskIndx := MAP(LEFT.P1_IDRiskIndx=0=>1, LEFT.P1_IDRiskIndx),
																		SELF.P15_SSNRiskIndx:= MAP(LEFT.P15_SSNRiskIndx=0=>1, LEFT.P15_SSNRiskIndx),
																		SELF.P16_PhnRiskIndx:= MAP(LEFT.P16_PhnRiskIndx=0=>1, LEFT.P16_PhnRiskIndx),
																		SELF.P17_EmailRiskIndx:= MAP(LEFT.P17_EmailRiskIndx=0=>1, LEFT.P17_EmailRiskIndx),
																		SELF.P19_BnkAcctRiskIndx:= MAP(LEFT.P19_BnkAcctRiskIndx=0=>1, LEFT.P19_BnkAcctRiskIndx), 
																		SELF.P20_DLRiskIndx:= MAP(LEFT.P20_DLRiskIndx=0=>1, LEFT.P20_DLRiskIndx), 
																		SELF.P18_IPAddrRiskIndx:= MAP(LEFT.P18_IPAddrRiskIndx=0=>1, LEFT.P18_IPAddrRiskIndx), 
																		SELF.P9_AddrRiskIndx:= MAP(LEFT.P9_AddrRiskIndx=0=>1, LEFT.P9_AddrRiskIndx),
																		SELF := LEFT)); // PROJECT to DEFAULT 1 for low risk for anything without any risk.						  
																
					
					rulesFlagsMatched_final := PROJECT(RulesFlagsMatched,TRANSFORM(RiskIntelligenceNetwork_Analytics.Layouts.LayoutRulesFlagsMatched,
																																																							SELF.acctno := LEFT.t_actuid,
																																																							SELF := LEFT));
					entityStats_final := PROJECT(WeightedResult(risklevel > -1),TRANSFORM(RiskIntelligenceNetwork_Analytics.Layouts.LayoutEntityStats,
																																																							SELF.acctno := LEFT.t_actuid,
																																																							SELF.agencydescription := KnownRiskIDSharingAgencyDesc(t_actuid=LEFT.t_actuid and Std.Str.Find(field,LEFT.field)>0)[1].value;
																																																							SELF := LEFT));

					results := PROJECT(EntityAssessment,TRANSFORM(RiskIntelligenceNetwork_analytics.Layouts.LiveAssessmentScores,
																																																															SELF.record_id := (INTEGER)LEFT.acctno,
																																																															SELF.RulesFlagsMatched := rulesFlagsMatched_final(acctno = LEFT.acctno),
																																																															SELF.EntityStats := entityStats_final(acctno = LEFT.acctno AND indicatortype NOT IN ['KR','SF']),
																																																															SELF.KrAttributes := entityStats_final(acctno = LEFT.acctno AND indicatortype='KR'),
																																																															SELF.MostRecentActivityDate := IF(EXISTS(identityProfiles(acctno = LEFT.acctno)),identityProfiles(acctno = LEFT.acctno)[1].eventdate,Std.Date.Today()),
																																																															SELF.TotalNumberOfIDActivities := IF(EXISTS(identityProfiles(acctno = LEFT.acctno)),(INTEGER)identityProfiles(acctno = LEFT.acctno)[1].NVP(name='aotidactcntev')[1].value,1),
																																																															SELF := LEFT));
																																																															
						// output(ds_in,named('analytics_ds_in'));
						// output(j2,named('analytics_j2'));
						// output(raw_Attributes,named('analytics_raw_Attributes'));
						// output(AttrClean,named('analytics_AttrClean'));
						// output(EventStatsPrep,named('analytics_EventStatsPrep'));
						// output(elementProfiles,named('analytics_elementProfiles'));
						// output(KnownRiskElementProfileAttributes,named('analytics_KnownRiskElementProfileAttributes'));
						// output(KnownRiskIDProfileAttributes,named('analytics_KnownRiskIDProfileAttributes'));
						// output(EventStatsPrepWithKr,named('analytics_EventStatsPrepWithKr'));
						// output(WeightedResult,named('analytics_WeightedResult'));
						// output(RulesResult,named('analytics_RulesResult'));
						// output(RulesResultAggPrep,named('analytics_RulesResultAggPrep'));
						// output(RulesResultAgg,named('analytics_RulesResultAgg'));
						// output(RulesFlagsMatched,named('analytics_RulesFlagsMatched'));
						// output(entityStats_final,named('analytics_entityStats_final'));
						// output(rulesFlagsMatched_final,named('analytics_rulesFlagsMatched_final'));
						// output(results,named('analytics_results'));
						
					RETURN results;
		END;
		
END;