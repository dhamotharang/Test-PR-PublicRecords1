IMPORT FraudgovKEL;
IMPORT FraudGovPlatform_Analytics;

EXPORT KEL_EventPivot := MODULE


//output(d1_1(person_entity_context_uid_ = '_0110165360'), all, named('d1_1_'));
//output(d1_1);

// JP debug this is to force a link chart that has 2 degrees even if we use the sample dataset needs to come out for PROD
Set_entity_context_uid_:=['_011288247490','_011565616510','_01191436849360','_01900002842380','_011599706980','_0131464757620','_01238528759680','_012601547200','_011774479870','_01237628984950','_01187859961720','_01900001576080','_01169473326670','_01900002892420','_01900002892510','_011985235570','_01900001596510','_011039698450','_0195869363320','_013181789260','_014389096870','_0158670530380','_01193865000580','_011214890110','_01190949021280','_01141059383650','_01182614587030','_01900002980440','_01900002988270','_01165072987270','_011548552240','_011613908620','_01900002995650','_01164190937410','_012462366430','_01236826239310','_01900002120760','_01900003014460','_01237694830480','_012331850230','_01146058766560','_01900002818530','_01900002097990','_012136562290','_01900003050910','_0165744435430','_01160028460','_01148798099170','_01720186030','_01900003056670'];
SHARED UIStats := PROJECT(FraudgovKEL.KEL_EventShell.UIStats, TRANSFORM(RECORDOF(LEFT), 
  self.addressentitycontextuid := MAP(LEFT.personentitycontextuid in Set_entity_context_uid_ => '_092247340211570905463', LEFT.addressentitycontextuid), 
	SELF := LEFT));


/* 
  DO THE EVENT ASSESSMENT AND OUTPUT THE RULES DETAIL
*/ 

rulesoutrec := RECORD
   RECORDOF(UIStats);
	 STRING RuleName;
	 INTEGER1 RuleFlag;
END;

/*
MyRules := DATASET([
  {0, 0, 1, 'Rule1', 'IP Address City is Miami and Address out of state.', 't18_ipaddrlocmiamiflag', '1', 0, 0, 3},
  {0, 0, 1, 'Rule1', 'IP Address City is Miami and Address out of state.', 'addressoutofstate', '1', 0, 0, 3},
	{0, 0, 1, 'Rule2', 'Identity deceased.', 'deceased', '1', 0, 0, 3},
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
  {UNSIGNED Customer_id, UNSIGNED industry_type, INTEGER1 entitytype, STRING RuleName, STRING Description, STRING200 Field, STRING Value, DECIMAL6_2 Low, DECIMAL6_2 High, INTEGER RiskLevel});
*/


EXPORT MyRules := DATASET('~fraudgov::in::sprayed::configrules', {UNSIGNED Customerid, UNSIGNED industrytype, INTEGER1 entitytype, STRING RuleName, STRING Description, STRING200 Field, STRING Value, DECIMAL6_2 Low, DECIMAL6_2 High, INTEGER RiskLevel}, CSV);

// This is just to make sure there aren't duplicates. Should be moved into the build code for the index to check everything and validate.
SHARED MyRulesCnt := TABLE(MyRules, {RuleName, customerid, industrytype, entitytype, Reccount := COUNT(GROUP)}, RuleName, customerid, entitytype, industrytype, FEW);
//output(MyRulesCnt, named('MyRulesCnt'));

SHARED EventStatsPrep := FraudGovPlatform_Analytics.macPivotOttoOutput(UIStats, 'industrytype,customerid,entitycontextuid,recordid', 
'eventdate,' +
// Need the list of the rules attributes here to limit the pivot to only attributes used in rules.
'deceased,currentlyincarceratedflag,addressisvacant,addressiscmra,addressispobox,invalidaddress,addressoutofstate,' +
't18_ipaddrlocmiamiflag,t18_ipaddrlocnonusflag,p1_aotidkrgenfrdactflagev,p9_aotaddrkractflagev,p15_aotssnkractflagev'
/*
FraudgovKEL.KEL_EventShell.OriginalAttr + ',' +
FraudgovKEL.KEL_EventShell.StructuralAttr + ',' +
FraudgovKEL.KEL_EventShell.NicoleAttr
*/
);

RulesResult := JOIN(EventStatsPrep(Value != ''), SORT(MyRules, field, -customerid), 
                         LEFT.Field=RIGHT.Field AND ((LEFT.customerid=RIGHT.customerid AND LEFT.industrytype = RIGHT.industrytype) OR RIGHT.customerid = 0) AND 
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
                            /*
                            SELF.Label := MAP(TRIM(RIGHT.UiDescription) != '' => 
														               MAP(RIGHT.HasValue => Std.Str.FindReplace(RIGHT.UiDescription, '{value}', LEFT.Value), RIGHT.UiDescription), 
																					 LEFT.Label);
                            */
                            SELF.field := LEFT.field,
														SELF.RuleName := RIGHT.RuleName,
														SELF.EntityType := RIGHT.EntityType,
														SELF.Description := RIGHT.Description,
														SELF.Default := (INTEGER1)(RIGHT.customerid = 0),
                            SELF := LEFT), MANY LOOKUP, LEFT OUTER)(RiskLevel>0);// : PERSIST('~temp::deleteme41');
														
//output(RulesResult(entitycontextuid = '_1194033204'), all, named('RulesResult'));

RulesResultAggPrep := TABLE(RulesResult, {customerid, industrytype, entitycontextuid, entitytype, rulename, Default, Description, risklevel, reccount := COUNT(GROUP)}, 
                       customerid, industrytype, entitycontextuid, entitytype, rulename, Default, Description, risklevel, MERGE);

RulesResultAgg := DEDUP(SORT(DISTRIBUTE(RulesResultAggPrep, HASH64(customerid, industrytype, entitycontextuid)), 
                       customerid, industrytype, entitycontextuid, entitytype, rulename, default, local), 
                       customerid, industrytype, entitycontextuid, entitytype, rulename, local); 
										 
//output(RulesResultAgg(entitycontextuid = '_1194033204'), named('RulesResultAgg'));

// Add how many flags for each rule matched
EXPORT RulesFlagsMatched  := JOIN(RulesResultAgg, MyRulesCnt, 
                        ((LEFT.customerid=RIGHT.customerid AND LEFT.industrytype = RIGHT.industrytype AND LEFT.RuleName = RIGHT.RuleName) OR
												  (RIGHT.customerid = 0 AND RIGHT.industrytype = 0 AND LEFT.RuleName = RIGHT.RuleName)) AND LEFT.reccount = RIGHT.reccount, 
                        TRANSFORM({LEFT.customerid,LEFT.industrytype,LEFT.entitycontextuid,LEFT.entitytype, LEFT.rulename,LEFT.description,LEFT.risklevel}, SELF := LEFT),
                        LOOKUP, HASH);

//output(RulesFlagsMatched(entitycontextuid = '_1194033204'), named('RulesFlagsMatched'));


//need to turn this into 
EntityEventAssessment := TABLE(RulesFlagsMatched, 
                    {industrytype,customerid,entitycontextuid,
										entitytype, INTEGER1 risklevel := MAX(GROUP, risklevel)}, 
										industrytype,customerid,entitycontextuid, entitytype, MERGE);

//output(EntityEventAssessment(entitycontextuid = '_1194033204'), all, named('EventAssessment'));

rAssessment := RECORD
	UNSIGNED8 industrytype;
	UNSIGNED8 customerid;
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
  														SELF := LEFT, SELF := [])),industrytype,customerid,entitycontextuid, LOCAL);
//output(EntityAssessmentPrep(entitycontextuid = '_1194033204'), all, named('EntityAssessmentPrep'));


EntityAssessment := PROJECT(TABLE(EntityAssessmentPrep, {
											 industrytype, customerid, entitycontextuid, 
											 INTEGER1 P1_IDRiskIndx := MAX(GROUP, P1_IDRiskIndx),
											 INTEGER1 P15_SSNRiskIndx:= MAX(GROUP, P15_SSNRiskIndx),
											 INTEGER1 P16_PhnRiskIndx:= MAX(GROUP, P16_PhnRiskIndx),
											 INTEGER1 P17_EmailRiskIndx:= MAX(GROUP, P17_EmailRiskIndx),
											 INTEGER1 P19_BnkAcctRiskIndx:= MAX(GROUP, P19_BnkAcctRiskIndx),
											 INTEGER1 P20_DLRiskIndx:= MAX(GROUP, P20_DLRiskIndx),
											 INTEGER1 P18_IPAddrRiskIndx:= MAX(GROUP, P18_IPAddrRiskIndx),
											 INTEGER1 P9_AddrRiskIndx:= MAX(GROUP, P9_AddrRiskIndx)}, industrytype, customerid, entitycontextuid, MERGE),
                        TRANSFORM(RECORDOF(LEFT), 
                          SELF.P1_IDRiskIndx := MAP(P1_IDRiskIndx=0=>1, P1_IDRiskIndx),
                          SELF.P15_SSNRiskIndx:= MAP(P15_SSNRiskIndx=0=>1, 0),
                          SELF.P16_PhnRiskIndx:= MAP(P16_PhnRiskIndx=0=>1, 0),
                          SELF.P17_EmailRiskIndx:= MAP(P17_EmailRiskIndx=0=>1, 0),
                          SELF.P19_BnkAcctRiskIndx:= MAP(P19_BnkAcctRiskIndx=0=>1, 0), 
                          SELF.P20_DLRiskIndx:= MAP(P20_DLRiskIndx=0=>1, 0), 
                          SELF.P18_IPAddrRiskIndx:= MAP(P18_IPAddrRiskIndx=0=>1, 0), 
                          SELF.P9_AddrRiskIndx:= MAP(P9_AddrRiskIndx=0=>1, 0),
                          SELF := LEFT)); // PROJECT to DEFAULT 1 for low risk for anything without any risk.						  
											
//output(EntityAssessment(entitycontextuid = '_1194033204'), named('EntityAssessment'));


/* 
END RULES ASSESSMENT
*/

d1 := JOIN(UIStats, EntityAssessment, LEFT.customerid=RIGHT.customerid AND LEFT.industrytype = RIGHT.industrytype AND LEFT.entitycontextuid=RIGHT.entitycontextuid, LEFT OUTER, HASH);
//output(d1(entitycontextuid = '_1194033204'), all, named('d1_1_1'));

OutRec := RECORD
	INTEGER1 entitytype;
	STRING Label;
	INTEGER1 RiskIndx;		
	INTEGER1 AotCurrProfFlag;
	INTEGER1 aotkractflagev;
	INTEGER1 aotsafeactflagev;
	UNSIGNED eventcount;
	UNSIGNED event30count;
	UNSIGNED event365count;
	INTEGER1 eventafterkrflag;
	UNSIGNED eventafterkrcount;	
  RECORDOF(d1);
END;
	
OutRec NormIt(d1 L, INTEGER C) := TRANSFORM
	SELF.entitytype := CHOOSE(C, 1, 9, 15, 16, 17, 18, 19, 20);
	SELF.Label := CHOOSE(C, L.personlabel, L.addresslabel, L.ssnlabel, L.phonelabel, L.emaillabel,  L.iplabel, L.bankaccountlabel, L.driverslicenselabel);
// jp add all these entity context uids to event output
	SELF.EntityContextUID := CHOOSE(C, 
																			L.personentitycontextuid,
																			L.addressentitycontextuid,
																			L.ssnentitycontextuid,
																			L.phoneentitycontextuid,
																			L.emailentitycontextuid,
																			L.ipentitycontextuid,
																			L.bankaccountentitycontextuid,
																			L.driverslicenseentitycontextuid);

	SELF.RiskIndx := CHOOSE(C, 
																			L.P1_IDRiskIndx,
																			L.P9_AddrRiskIndx,
																			L.P15_SSNRiskIndx,
																			L.P16_PhnRiskIndx,
																			L.P17_EmailRiskIndx,
																			L.P18_IPAddrRiskIndx,
																			L.P19_BnkAcctRiskIndx,
																			L.P20_DLRiskIndx);
																																																																																																	
  SELF.AotCurrProfFlag := CHOOSE(C, 
																			L.P1_AotIdCurrProfFlag,
																			L.P9_AotAddrCurrProfFlag,
																			L.P15_AotSsnCurrProfFlag,
																			L.P16_AotPhnCurrProfFlag,
																			L.P17_AotEmailCurrProfFlag,
																			L.P18_AotIpAddrCurrProfFlag,
																			L.P19_AotBnkAcctCurrProfFlag,
																			L.P20_AotDlCurrProfFlag);
																													
	SELF.aotkractflagev := CHOOSE(C, 
																			L.p1_aotidkractflagev,
																			L.p9_aotaddrkractflagev,
																			L.p15_aotssnkractflagev,
																			L.p16_aotphnkractflagev,
																			L.p17_aotemailkractflagev,
																			L.p18_aotipaddrkractflagev,
																			L.p19_aotbnkacctkractflagev,
																			L.p20_aotdlkractflagev);	

	SELF.aotsafeactflagev := CHOOSE(C, 
																			0/*L.p1_aotidkractflagev*/,
																			L.p9_aotaddrsafeactflagev,
																			0/*L.p15_aotssnkractflagev*/,
																			L.p16_aotphnsafeactflagev,
																			0/*L.p17_aotemailkractflagev*/,
																			L.p18_aotipaddrsafeactflagev,
																			0/*L.p19_aotbnkacctkractflagev*/,
																			0/*L.p20_aotdlkractflagev*/);	
																			
																			
	SELF.eventcount := CHOOSE(C, 
																			L.personeventcount,
																			L.addreventcount,
																			L.ssneventcount,
																			L.phoneeventcount,
																			L.emaileventcount,
																			L.ipeventcount,
																			L.bankaccounteventcount,
																			L.driverslicenseeventcount);		
																			
	SELF.event30count := CHOOSE(C, 
																			L.personevent30count,
																			L.addrevent30count,
																			L.ssnevent30count,
																			L.phoneevent30count,
																			L.emailevent30count,
																			L.ipevent30count,
																			L.bankaccountevent30count,
																			L.driverslicenseevent30count);		
																			
	SELF.event365count := CHOOSE(C, 
																			L.personevent365count,
																			L.addrevent365count,
																			L.ssnevent365count,
																			L.phoneevent365count,
																			L.emailevent365count,
																			L.ipevent365count,
																			L.bankaccountevent365count,
																			L.driverslicenseevent365count);		

	SELF.eventafterkrflag := CHOOSE(C, 
																			L.personeventafterkrflag,
																			L.addreventafterkrflag,
																			L.ssneventafterkrflag,
																			L.phoneeventafterkrflag,
																			L.emaileventafterkrflag,
																			L.ipeventafterkrflag,
																			L.bankaccounteventafterkrflag,
																			L.driverslicenseeventafterkrflag);		

	SELF.eventafterkrcount := CHOOSE(C, 
																			L.personeventafterkrcount,
																			L.addreventafterkrcount,
																			L.ssneventafterkrcount,
																			L.phoneeventafterkrcount,
																			L.emaileventafterkrcount,
																			L.ipeventafterkrcount,
																			L.bankaccounteventafterkrcount,
																			L.driverslicenseeventafterkrcount);	
						
	SELF := L;
END;

NonEntities := ['12638153115695167395', '14695981039346656037','12638153115695167395','','0000000000','4233676119','4073047705','']; 

SHARED PivotToEntities :=
            NORMALIZE(d1,8,NormIt(LEFT,COUNTER))(label != '' AND entitycontextuid[4..] NOT IN NonEntities) : PERSIST('~fraudgov::temp::eventpivot'); // exclude entities that didn't exist on the transaction.
						

//Clean out from Modeling for UI
codesToIgnore := '-99999\', \'-99998\', \'-99997';
SHARED PivotClean := FraudgovKEL.macCleanAnalyticUIOutput(PivotToEntities, RECORDOF(PivotToEntities), codesToIgnore);

// Transform the rules so that we have identity/element entity context uid with the rules at the last transaction that triggered 
// So one per entity.

SHARED LastRulesForEntities := JOIN(PivotToEntities(AotCurrProfFlag=1), RulesFlagsMatched,
                          LEFT.customerid=RIGHT.customerid AND LEFT.industrytype=RIGHT.industrytype AND ('_11' + LEFT.recordid) = RIGHT.entitycontextuid AND LEFT.entitytype=RIGHT.entitytype, 
                          TRANSFORM(RECORDOF(RIGHT) AND NOT [entitytype], SELF.entitycontextuid := LEFT.entitycontextuid, SELF := RIGHT), HASH);
													
//output(PivotClean,,'~gov::otto::eventpivot', overwrite, compressed);	
EXPORT EventPivotShell := PivotClean;
								 
//output(LastRulesForEntities,,'~gov::otto::entityrules', overwrite, compressed);
EXPORT EntityProfileRules := LastRulesForEntities;

END;
