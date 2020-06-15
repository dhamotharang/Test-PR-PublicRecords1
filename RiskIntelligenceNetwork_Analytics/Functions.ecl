﻿IMPORT RiskIntelligenceNetwork_Services;
IMPORT FraudgovKEL;
IMPORT KEL12 AS KEL;
IMPORT Std;
IMPORT FraudgovPlatform, RiskIntelligenceNetwork_Analytics,FraudgovPlatform_Analytics;
IMPORT Data_Services;
IMPORT ut;

EXPORT Functions := MODULE

		EXPORT GetRealtimeAssessment(DATASET(RiskIntelligenceNetwork_Services.Layouts.realtime_appends_rec) ds_in) := FUNCTION
					j2 := PROJECT(ds_in, TRANSFORM(RiskIntelligenceNetwork_Analytics.Layouts.LayoutInputPII_2,
                                                             
																																														 SELF.EmailLastDomain := Std.Str.ToUpperCase(Std.Str.SplitWords(LEFT.batchin_rec.email_Address, '.')[Std.Str.CountWords(LEFT.batchin_rec.email_address, '.')]),
																																															SELF.OttoAddressId := HASH64(LEFT.batchin_rec.addr);//(TRIM(LEFT.address_1)+ '|' + TRIM(LEFT.address_2)), cp this needs to match the roxie context uid code.
																																															SELF.OttoIpAddressId := HASH64(LEFT.batchin_rec.ip_address), 
																																														 SELF.OttoEmailId := HASH64(LEFT.batchin_rec.email_address),
																																															SELF.OttoSSNId := HASH64(LEFT.batchin_rec.ssn),
																																															SELF.OttoBankAccountId := HASH64(TRIM(LEFT.batchin_rec.bank_routing_number, LEFT, RIGHT) + '|' + TRIM(LEFT.batchin_rec.bank_account_number, LEFT, RIGHT)),
																																													 //SELF.OttoBankAccountId2 := HASH64(TRIM(LEFT.bank_routing_number_2, LEFT, RIGHT) + '|' + TRIM(LEFT.bank_account_number_2, LEFT, RIGHT)),
																																													 SELF.OttoDriversLicenseId := HASH64(STD.Str.CleanSpaces(TRIM(LEFT.batchin_rec.dl_number, LEFT, RIGHT)+ '|' + TRIM(LEFT.batchin_rec.dl_state, LEFT, RIGHT))),                                                                                                                                                                                 
																																													 SELF.event_date := Std.Date.Today(),
																																														//SELF.Customer_State := LEFT.classification_source.Customer_State,
																																												 // fake bank account and dl risk stuff for testing JP
																																												 //self.diddeceased := true,
																																													//self.diddeceaseddate := 20190101;
																																													// end of test code.
																																													// Clean name to avoid blank labels
																																													SELF.batchin_rec.name_first := TRIM(ut.fn_RemoveSpecialChars(LEFT.batchin_rec.name_first)),
																																													SELF.batchin_rec.name_last := TRIM(ut.fn_RemoveSpecialChars(LEFT.batchin_rec.name_last)),
																																													SELF.boca_shell_appends := LEFT.boca_shell_appends[0],
																																													SELF.BocaShellHit := (INTEGER1)(LEFT.Boca_shell_appends[0].seq > 0 and LEFT.Boca_shell_appends[0].did > 0),
																																													SELF.rin_source := 1,
																																													SELF.gc_id := '234',
																																													SELF := LEFT,
																																													SELF := []));
																																													
					CleanAttributes := KEL.Clean(RiskIntelligenceNetwork_Analytics.Q_Input_Rin(j2).Res0, TRUE /*Remove __Flags*/, TRUE /*Remove __recordcounts*/, TRUE /*Remove _ from Field Names*/);
					
					codesToIgnore := '-99999\', \'-99998\', \'-99997';
					AttrClean := FraudgovKEL.macCleanAnalyticUIOutput(CleanAttributes, RECORDOF(CleanAttributes), codesToIgnore);
											
										/* 
					 COMPUTE ENTITY STATS (RISK INDICATORS)
					*/

					NicoleAttr := 'agencyuid,agencyprogtype,agencyprogjurst,t_srcagencyuid,t_srcagencyprogtype,t_actdtecho,t_srctype,t_srcclasstype,t_personuidecho,t_inpclntitleecho,'+
					't_inpclnfullnmecho,t_inpclnfirstnmecho,t_inpclnmiddlenmecho,t_inpclnlastnmecho,t_inpclnnmsuffixecho,t_inpclnaddrprimrangeecho,t_inpclnaddrpredirecho,t_inpclnaddrprimnmecho,t_inpclnaddrsuffixecho,t_inpclnaddrpostdirecho,t_inpclnaddrunitdesigecho,'+
					't_inpclnaddrsecrangeecho,t_inpclnaddrcityecho,t_inpclnaddrstecho,t_inpclnaddrzip5echo,t_inpclnaddrzip4echo,t_inpclnaddrlatecho,t_inpclnaddrlongecho,t_inpclnaddrcountyecho,t_inpclnaddrgeoblkecho,t_inpclnssnecho,t_inpclndobecho,'+
					't_inpclndlstecho,t_inpclnemailecho,t_inpclnbnkacctecho,t_inpclnbnkacctrtgecho,t_inpclnipaddrecho,t_inpclnphnecho,t1_lexidpopflag,t1_rinidpopflag,t18_isipmetahitflag,t18_ipaddrcity,t18_ipaddrcountry ,'+
					't18_ipaddrregion,t18_ipaddrdomain,t18_ipaddrispnm,t18_ipaddrloctype,t18_ipaddrproxytype,t18_ipaddrproxydesc,t18_ipaddrisispflag,t18_ipaddrasncompnm,t18_ipaddrasn,t18_ipaddrcompnm,t18_ipaddrorgnm,'+
					't18_ipaddrhostedflag,t18_ipaddrvpnflag,t18_ipaddrtornodeflag,t18_ipaddrlocnonusflag,t18_ipaddrlocmiamiflag,t19_bnkacctpopflag,t19_isbnkapphitflag,t19_bnkacctbnknm,t19_bnkaccthrprepdrtgflag,t17_emailpopflag,t17_emaildomain,'+
					't17_emaildomaindispflag,t9_addrpopflag,t9_addrtype,t9_addrstatus,t16_phnpopflag,t15_ssnpopflag,t18_ipaddrpopflag,' +
					'p1_idriskunscrbleflag,p9_addrriskunscrbleflag,p15_ssnriskunscrbleflag,p16_phnriskunscrbleflag,p17_emailriskunscrbleflag,p18_ipaddrriskunscrbleflag,p19_bnkacctriskunscrbleflag,p20_dlriskunscrbleflag';



						EventStatsPrep := FraudGovPlatform_Analytics.macPivotOttoOutput(AttrClean, 'entitycontextuid,t_actuid',//,recordid', 
					NicoleAttr

						);

					WeightedResultDefault := JOIN(EventStatsPrep(Value != ''), FraudGovPlatform.Key_ConfigAttributes, 
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
																	 LEFT.Field=RIGHT.Field AND ((INTEGER)LEFT.entitycontextuid[2..3] = RIGHT.EntityType OR (INTEGER)LEFT.entitycontextuid[2..3] = 1 AND RIGHT.EntityType = 11) AND
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
																			SELF.EntityType := RIGHT.EntityType,
																			SELF.IndicatorType := MAP(RIGHT.IndicatorType != '' => RIGHT.IndicatorType, LEFT.IndicatorType);
																			SELF.IndicatorDescription := MAP(RIGHT.IndicatorDescription != '' => RIGHT.IndicatorDescription, LEFT.IndicatorDescription);
																			SELF := LEFT), KEYED, LEFT OUTER);

					/* 
					RULES ASSESSMENT
					*/

					//MyRules := FraudGovPlatform.Key_ConfigRules;
					MyRules := DATASET([
						{0, 0, 1, 'Rule1', 'IP Address City is Miami and Address out of state.', 't15_ssnpopflag', '1', 0, 0, 3},
						{0, 0, 1, 'Rule1', 'IP Address City is Miami and Address out of state.', 't1_lexidpopflag', '1', 0, 0, 3},
						{0, 0, 1, 'Rule99_1', 'Unscorable', 'p1_idriskunscrbleflag', '1', 0, 0, 99},
						{0, 0, 9, 'Rule99_9', 'Unscorable', 'p9_addrriskunscrbleflag', '1', 0, 0, 99},
						{0, 0, 15, 'Rule99_15', 'Unscorable', 'p15_ssnriskunscrbleflag', '1', 0, 0, 99},
						{0, 0, 16, 'Rule99_16', 'Unscorable', 'p16_phnriskunscrbleflag', '1', 0, 0, 99},
						{0, 0, 17, 'Rule99_17', 'Unscorable', 'p17_emailriskunscrbleflag', '1', 0, 0, 99},
						{0, 0, 18, 'Rule99_18', 'Unscorable', 'p18_ipaddrriskunscrbleflag', '1', 0, 0, 99},
						{0, 0, 19, 'Rule99_19', 'Unscorable', 'p19_bnkacctriskunscrbleflag', '1', 0, 0, 99},
						{0, 0, 20, 'Rule99_20', 'Unscorable', 'p20_dlriskunscrbleflag', '1', 0, 0, 99},
						{0, 0, 1, 'Rule3', 'Address is out of state and IP Address is NOT in the US.', 'addressoutofstate', '1', 0, 0, 3},
						{0, 0, 1, 'Rule3', 'Address is out of state and IP Address is NOT in the US.', 't18_ipaddrlocnonusflag', '1', 0, 0, 3},
						{0, 0, 1, 'Rule1-1', 'Identity Deceased', 'deceased', '1', 0, 0, 3},
						{0, 0, 1, 'Rule1-2', 'Identity is currently incarcerated', 'currentlyincarceratedflag', '1', 0, 0, 3},
						{8342784, 1014, 1, 'Rule3', 'Address is out of state and IP Address NOT is in the US.', 'addressoutofstate', '1', 0, 0, 1},
						{8342784, 1014, 1, 'Rule3', 'Address is out of state and IP Address NOT is in the US.', 't18_ipaddrlocnonusflag', '1', 0, 0, 1},
						{0, 0, 18, 'Rule4', 'Address is a PO Box and IP Address is NOT in the US.', 't18_ipaddrlocnonusflag', '1', 0, 0, 3},
						{0, 0, 18, 'Rule4', 'Address is a PO Box and IP Address is NOT in the US.', 'addressispobox', '1', 0, 0, 3},
						{0, 0, 9, 'Rule5', 'Address is vacant.', 'address_is_vacant_', '1', 0, 0, 1},
						{0, 0, 9, 'Rule6', 'Address is Commercial Receiving Agency', 'addressiscmra', '1', 0, 0, 1},
						{0, 0, 9, 'Rule7', 'Address is out of state.', 'addressoutofstate', '1', 0, 0, 3},
						{0, 0, 1, 'Rule9', 'p1_aotidkrgenfrdactflagev.', 'p1_aotidkrgenfrdactflagev', '1', 0, 0, 3},
						{0, 0, 9, 'Rule11', 'Address is known risk.', 'p9_aotaddrkractflagev', '1', 0, 0, 3},
						{0, 0, 15, 'Rule11', 'SSN is known risk.', 'p15_aotssnkractflagev', '1', 0, 0, 3},
						{20995369, 1014, 9, 'Rule5', 'Address is vacant.', 'addressisvacant', '1', 0, 0, 3}
						],
						{UNSIGNED Customerid, UNSIGNED industrytype, INTEGER1 entitytype, STRING RuleName, STRING Description, STRING200 Field, STRING Value, DECIMAL6_2 Low, DECIMAL6_2 High, INTEGER RiskLevel});
						
					 MyRulesCnt := TABLE(MyRules, {RuleName, customerid, industrytype, entitytype, Reccount := COUNT(GROUP)}, RuleName, customerid, entitytype, industrytype, FEW);

						RulesResult := JOIN(EventStatsPrep(Value != ''), SORT(MyRules, field, -customerid), 
																	 LEFT.Field=RIGHT.Field AND 
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
																																																							SELF := LEFT));
					entityStats_final := PROJECT(WeightedResult,TRANSFORM(RiskIntelligenceNetwork_Analytics.Layouts.LayoutEntityStats,
																																																							SELF := LEFT));

					results := PROJECT(EntityAssessment,TRANSFORM(RiskIntelligenceNetwork_analytics.Layouts.LayoutRiskScore,
																																																															SELF.record_id := 1,
																																																															SELF.RulesFlagsMatched := rulesFlagsMatched_final,
																																																															SELF.EntityStats := entityStats_final,
																																																															SELF := LEFT));
					RETURN results;
		END;
		
END;