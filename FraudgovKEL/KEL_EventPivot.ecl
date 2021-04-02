IMPORT FraudgovKEL;
IMPORT FraudGovPlatform_Analytics;

EXPORT KEL_EventPivot := MODULE


//output(d1_1(person_entity_context_uid_ = '_0110165360'), all, named('d1_1_'));
//output(d1_1);

SHARED UIStats1 := FraudgovKEL.KEL_EventShell.UIStats;

// jp temp
dConfig := DATASET('~fraudgov::in::sprayed::configattributes', {INTEGER8 EntityType, STRING200 Field, STRING Value, DECIMAL Low, DECIMAL High, INTEGER RiskLevel, STRING IndicatorType, STRING IndicatorDescription, INTEGER Weight, STRING UiDescription, UNSIGNED customerid, UNSIGNED industrytype}, CSV(HEADING(1)));	

dictEvtType1 := DICTIONARY(dConfig(field = 't_evttype1statuscodeecho'),{value => uidescription});
dictEvtType2 := DICTIONARY(dConfig(field = 't_evttype2statuscodeecho'),{value => uidescription});
dictEvtType3 := DICTIONARY(dConfig(field = 't_evttype3statuscodeecho'),{value => uidescription});
dictIdStat  := DICTIONARY(dConfig(field = 't_idstatuscodeecho'),{value => uidescription});
dictNameStat  := DICTIONARY(dConfig(field = 't_namestatuscodeecho'),{value => uidescription});
dictAddrStat := DICTIONARY(dConfig(field = 't_addrstatuscodeecho'),{value => uidescription});
dictBankStat := DICTIONARY(dConfig(field = 't_bnkacctstatuscodeecho'),{value => uidescription});
dictDlStat := DICTIONARY(dConfig(field = 't_dlstatuscodeecho'),{value => uidescription});
dictEmailStat := DICTIONARY(dConfig(field = 't_emailstatuscodeecho'),{value => uidescription});
dictIpStat := DICTIONARY(dConfig(field = 't_ipaddrstatuscodeecho'),{value => uidescription});
dictPhnStat := DICTIONARY(dConfig(field = 't_phnstatuscodeecho'),{value => uidescription});
dictSsnStat := DICTIONARY(dConfig(field = 't_ssnstatuscodeecho'),{value => uidescription});
      
SHARED UIStats := PROJECT(UIStats1, 
  TRANSFORM({RECORDOF(LEFT),
  STRING t_addrstatusdesc,
  STRING t_bnkacctstatusdesc,
  STRING t_dlstatusdesc,
  STRING t_emailstatusdesc,
  STRING t_evttype1statusdesc,
  STRING t_evttype2statusdesc,
  STRING t_evttype3statusdesc,
  STRING t_idstatusdesc,
  STRING t_namestatusdesc,
  STRING t_ipaddrstatusdesc,
  STRING t_phnstatusdesc,
  STRING t_ssnstatusdesc,

	STRING t_inpdvciprovecho, // jp these have to come out when NN puts the actual attr in
	STRING t_inpclnbnkacct2rtg2echo // jp temp needs to come out 
	}, 
 
	SELF.t_inpdvciprovecho := '', // jp temp needs to come out 
	SELF.t_inpclnbnkacct2rtg2echo := '';//LEFT.routingnumber2, // jp temp needs to come out
	
  SELF.t_evttype1statusdesc := dictEvtType1[(STRING)LEFT.t_evttype1statuscodeecho].uidescription;
  SELF.t_evttype2statusdesc := dictEvtType2[(STRING)LEFT.t_evttype2statuscodeecho].uidescription;
  SELF.t_evttype3statusdesc := dictEvtType3[(STRING)LEFT.t_evttype3statuscodeecho].uidescription;
  SELF.t_idstatusdesc := dictIdStat[(STRING)LEFT.t_idstatuscodeecho].uidescription;
  SELF.t_namestatusdesc := dictNameStat[(STRING)LEFT.t_namestatuscodeecho].uidescription;
  SELF.t_addrstatusdesc := dictAddrStat[(STRING)LEFT.t_addrstatuscodeecho].uidescription;
  SELF.t_bnkacctstatusdesc := dictBankStat[(STRING)LEFT.t_bnkacctstatuscodeecho].uidescription;
  SELF.t_dlstatusdesc := dictDlStat[(STRING)LEFT.t_dlstatuscodeecho].uidescription;
  SELF.t_emailstatusdesc := dictEmailStat[(STRING)LEFT.t_emailstatuscodeecho].uidescription;
  SELF.t_ipaddrstatusdesc := dictIpStat[(STRING)LEFT.t_ipaddrstatuscodeecho].uidescription;
  SELF.t_phnstatusdesc := dictPhnStat[(STRING)LEFT.t_phnstatuscodeecho].uidescription;
  SELF.t_ssnstatusdesc := dictSsnStat[(STRING)LEFT.t_ssnstatuscodeecho].uidescription;
  SELF := LEFT,
  SELF := []));


/* 
  DO THE EVENT ASSESSMENT AND OUTPUT THE RULES DETAIL
*/ 

rulesoutrec := RECORD
   RECORDOF(UIStats);
	 STRING RuleName;
	 INTEGER1 RuleFlag;
END;

EXPORT MyRules := DATASET('~fraudgov::in::sprayed::configrules', {UNSIGNED Customerid, UNSIGNED industrytype, INTEGER1 entitytype, STRING RuleName, STRING Description, STRING200 Field, STRING Value, DECIMAL6_2 Low, DECIMAL6_2 High, INTEGER RiskLevel}, CSV);

// This is just to make sure there aren't duplicates. Should be moved into the build code for the index to check everything and validate.
SHARED MyRulesCnt := TABLE(MyRules, {RuleName, customerid, industrytype, entitytype, Reccount := COUNT(GROUP)}, RuleName, customerid, entitytype, industrytype, FEW);
//output(MyRulesCnt, named('MyRulesCnt'));

//Clean out from Modeling for UI
codesToIgnore := '-99999\', \'-99998\', \'-99997\', \'-99999.0\', \'-99998.0\', \'-99997.0';
EXPORT UIStatsClean := FraudgovKEL.macCleanAnalyticUIOutput(UIStats, RECORDOF(UIStats), codesToIgnore);

SHARED EventStatsPrep := FraudGovPlatform_Analytics.macPivotOttoOutput(UIStatsClean, 'industrytype,customerid,entitycontextuid,recordid', 
'eventdate,' +
// Need the list of the rules attributes here to limit the pivot to only attributes used in rules.
't1_adultidnotseenflag,t1_minorwlexidflag,t1l_iddeceasedflag,t1l_iddtofdeathaftidactflagev,t1l_idcurrincarcflag,t1_ssnpriordobflag,t1_firstnmnotverflag,t1_lastnmnotverflag,t1_addrnotverflag,' +
't1l_ssnnotverflag,t1l_ssnwaltnaverflag,t1l_ssnwaddrnotverflag,t1_phnnotverflag,t1l_dobnotverflag,t1_hiriskcviflag,t1_medriskcviflag,t1l_hdrsrccatcntlwflag,t1_stolidflag,t1_synthidflag,' +
't1_manipidflag,t1l_curraddrnotinagcyjurstflag,t1l_bestdlnotinagcyjurstflag,t9_addrisvacantflag,t9_addrisinvalidflag,t9_addriscmraflag,t9_addrnotinagcyjurstflag,t15_ssnisinvalidflag,t20_dlisinvalidflag,t16_phnisinvalidflag,t16_phnprepdflag,' +
't18_ipaddrhostedflag,t18_ipaddrvpnflag,t18_ipaddrtornodeflag,t18_ipaddrlocnonusflag,t18_ipaddrlocmiamiflag,t17_emaildomaindispflag,t19_bnkaccthrprepdrtgflag,t9_addrpoboxmultcurridflagev,t15_ssnmultcurridflagev,t20_dlmultcurridflagev,' +
't19_bnkacctmultcurridflagev,p1_aotidkrappfrdactflagev,p1_aotidkrgenfrdactflagev,p1_aotidkrothfrdactflagev,p1_aotidkrstolidactflagev,p9_aotaddrkractflagev,p15_aotssnkractflagev,p16_aotphnkractflagev,p17_aotemailkractflagev,p18_aotipaddrkractflagev,' +
'p19_aotbnkacctkractflagev,p20_aotdlkractflagev,p1_idriskunscrbleflag,p9_addrriskunscrbleflag,p15_ssnriskunscrbleflag,p16_phnriskunscrbleflag,p17_emailriskunscrbleflag,p18_ipaddrriskunscrbleflag,p19_bnkacctriskunscrbleflag,p20_dlriskunscrbleflag,' +
't_inpclnaddrgeomatchecho,p1_aotidkrstolidactinagcyflagev,p1_aotidkrgenfrdactinagcyflagev,p1_aotidkrappfrdactinagcyflagev,p1_aotidkrothfrdactinagcyflagev,p9_aotaddrkractinagcyflagev,p15_aotssnkractinagcyflagev,p16_aotphnkractinagcyflagev,p17_aotemailkractinagcyflagev,' +
'p18_aotipaddrkractinagcyflagev,p19_aotbnkacctkractinagcyflagev,p20_aotdlkractinagcyflagev'
);

RulesResult := JOIN(EventStatsPrep(Value != ''), SORT(MyRules, field, -customerid), 
                         LEFT.Field=RIGHT.Field AND ((LEFT.customerid=RIGHT.customerid AND LEFT.industrytype = RIGHT.industrytype) OR RIGHT.customerid = 0) AND 
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
                            SELF := LEFT), MANY LOOKUP, LEFT OUTER)(RiskLevel>0);// : PERSIST('~fraudgov::temp::deleteme41');

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
                        TRANSFORM({UNSIGNED customerid,UNSIGNED industrytype,STRING100 entitycontextuid,UNSIGNED entitytype, STRING100 rulename,STRING250 description,INTEGER1 risklevel}, SELF := LEFT),
                        LOOKUP, HASH);

//output(RulesFlagsMatched(entitycontextuid = '_1194033204'), named('RulesFlagsMatched'));


//need to turn this into 
EXPORT EntityEventAssessment := TABLE(RulesFlagsMatched, 
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

EXPORT EntityAssessment := PROJECT(TABLE(EntityAssessmentPrep, {
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
                          SELF.P1_IDRiskIndx := MAP(LEFT.P1_IDRiskIndx=0=>1, LEFT.P1_IDRiskIndx),
                          SELF.P15_SSNRiskIndx:= MAP(LEFT.P15_SSNRiskIndx=0=>1, LEFT.P15_SSNRiskIndx),
                          SELF.P16_PhnRiskIndx:= MAP(LEFT.P16_PhnRiskIndx=0=>1, LEFT.P16_PhnRiskIndx),
                          SELF.P17_EmailRiskIndx:= MAP(LEFT.P17_EmailRiskIndx=0=>1, LEFT.P17_EmailRiskIndx),
                          SELF.P19_BnkAcctRiskIndx:= MAP(LEFT.P19_BnkAcctRiskIndx=0=>1, LEFT.P19_BnkAcctRiskIndx), 
                          SELF.P20_DLRiskIndx:= MAP(LEFT.P20_DLRiskIndx=0=>1, LEFT.P20_DLRiskIndx), 
                          SELF.P18_IPAddrRiskIndx:= MAP(LEFT.P18_IPAddrRiskIndx=0=>1, LEFT.P18_IPAddrRiskIndx), 
                          SELF.P9_AddrRiskIndx:= MAP(LEFT.P9_AddrRiskIndx=0=>1, LEFT.P9_AddrRiskIndx),
                          SELF := LEFT)); // PROJECT to DEFAULT 1 for low risk for anything without any risk.						  
											
//output(EntityAssessment(entitycontextuid = '_1194033204'), named('EntityAssessment'));


/* 
END RULES ASSESSMENT
*/

EXPORT InputWithRules := JOIN(UIStatsClean, EntityAssessment, LEFT.customerid=RIGHT.customerid AND LEFT.industrytype = RIGHT.industrytype AND LEFT.entitycontextuid=RIGHT.entitycontextuid, LEFT OUTER, HASH);
//output(d1(entitycontextuid = '_1194033204'), all, named('d1_1_1'));

		
SHARED OutRec := RECORD
  INTEGER1 entitytype;
  STRING Label;
  INTEGER1 RiskIndx;        
  INTEGER1 AotCurrProfFlag;
  INTEGER1 aotkractflagev;
  INTEGER1 aotsafeactflagev;
  UNSIGNED aotkractnewdtev;
  UNSIGNED aotkractcntev;
  UNSIGNED aotnonstactcntev;
  UNSIGNED aotnewkraftidactcntev;
  UNSIGNED aotidactcnt30d;
  UNSIGNED aotnonstactcnt30d;
  UNSIGNED aotnewkraftnonstactcntev;
  INTEGER aothiidcurrprofusngcntev;
  UNSIGNED aotidusngcntev;
  UNSIGNED aotidactcntev;
  UNSIGNED aotidcurrprofusngcntev;
  UNSIGNED1 not_aotkractflagev;
  UNSIGNED1 not_aotsafeactflagev;
  STRING CustomerProgramDescription;  
  RECORDOF(InputWithRules);
END;
        
OutRec NormIt(InputWithRules L, INTEGER C) := TRANSFORM
    SELF.entitytype := CHOOSE(C, 1, 9, 15, 16, 17, 18, 19, 20);
    SELF.Label := CHOOSE(C, L.personlabel, L.addresslabel, L.ssnlabel, L.phonelabel, L.emaillabel,  L.iplabel, L.bankaccountlabel, L.driverslicenselabel);
    SELF.customerProgramDescription := L.T_SrcAgencyDesc;
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
							  
    SELF.aotidcurrprofusngcntev := CHOOSE(C, 
                              1,
                              L.p9_aotidcurrprofusngaddrcntev,
                              L.p15_aotidcurrprofusngssncntev,
                              L.p16_aotidcurrprofusngphncntev,
                              L.p17_aotidcurrprofusngemlcntev,
                              L.p18_aotidcurrprofusngipcntev,
                              L.p19_aotidcurrprofusngbkaccntev,
                              L.p20_aotidcurrprofusngdlcntev);

    aotkractflagev := CHOOSE(C, 
                              L.p1_aotidkractflagev,
                              L.p9_aotaddrkractflagev,
                              L.p15_aotssnkractflagev,
                              L.p16_aotphnkractflagev,
                              L.p17_aotemailkractflagev,
                              L.p18_aotipaddrkractflagev,
                              L.p19_aotbnkacctkractflagev,
                              L.p20_aotdlkractflagev);
    SELF.aotkractflagev := aotkractflagev;
    aotsafeactflagev := CHOOSE(C, 
                              0/*L.p1_aotidkractflagev*/,
                              L.p9_aotaddrsafeactflagev,
                              0/*L.p15_aotssnkractflagev*/,
                              L.p16_aotphnsafeactflagev,
                              0/*L.p17_aotemailkractflagev*/,
                              L.p18_aotipaddrsafeactflagev,
                              0/*L.p19_aotbnkacctkractflagev*/,
                              0/*L.p20_aotdlkractflagev*/);   							  
    SELF.aotsafeactflagev := aotsafeactflagev;                          
    SELF.not_aotkractflagev := (INTEGER)(aotkractflagev = 0);
    SELF.not_aotsafeactflagev := (INTEGER)(aotsafeactflagev = 0);

    SELF.aotkractnewdtev := CHOOSE(C, L.p1_aotidkractnewdtev,
                              L.p9_aotaddrkractnewdtev,
                              L.p15_aotssnkractnewdtev,
                              L.p16_aotphnkractnewdtev,
                              L.p17_aotemailkractnewdtev,
                              L.p18_aotipaddrkractnewdtev,
                              L.p19_aotbnkacctkractnewdtev,
                              L.p20_aotdlkractnewdtev);

    SELF.aotkractcntev := CHOOSE(C, L.P1_aotidkractcntev,
                              l.p9_aotaddrkractcntev,
                              l.p15_aotssnkractcntev,
                              l.p16_aotphnkractcntev,
                              l.p17_aotemailkractcntev,
                              l.p18_aotipaddrkractcntev,
                              l.p19_aotbnkacctkractcntev,
                              l.p20_aotdlkractcntev);

    SELF.aotnonstactcntev := CHOOSE(C, L.P1_AotNonStActCntEv,
                              l.p9_AotNonStActCntEv,
                              l.p15_AotNonStActCntEv,
                              l.p16_AotNonStActCntEv,
                              l.p17_AotNonStActCntEv,
                              l.p18_AotNonStActCntEv,
                              l.p19_AotNonStActCntEv,
                              l.p20_AotNonStActCntEv);
        
    SELF.aotnewkraftidactcntev := CHOOSE(C, L.P1_aotidnewkraftidactcntev,
                              l.p9_aotaddrnewkraftidactcntev,
                              l.p15_aotssnnewkraftidactcntev,
                              l.p16_aotphnnewkraftidactcntev,
                              l.p17_aotemlnewkraftidactcntev,
                              l.p18_aotipnewkraftidactcntev,
                              l.p19_aotbkacnewkraftidactcntev,
                              l.p20_aotdlnewkraftidactcntev);

    SELF.aotidactcnt30d := CHOOSE(C, L.P1_aotidactcnt30d,
                              l.p9_aotidactcnt30d,
                              l.p15_aotidactcnt30d,
                              l.p16_aotidactcnt30d,
                              l.p17_aotidactcnt30d,
                              l.p18_aotidactcnt30d,
                              l.p19_aotidactcnt30d,
                              l.p20_aotidactcnt30d);                                                                    

    SELF.aotnonstactcnt30d := CHOOSE(C, L.P1_aotnonstactcnt30d,
                              l.p9_aotnonstactcnt30d,
                              l.p15_aotnonstactcnt30d,
                              l.p16_aotnonstactcnt30d,
                              l.p17_aotnonstactcnt30d,
                              l.p18_aotnonstactcnt30d,
                              l.p19_aotnonstactcnt30d,
                              l.p20_aotnonstactcnt30d);        
    SELF.aotnewkraftnonstactcntev    := CHOOSE(C, L.p1_aotidnewkraftnonstactcntev,
                              l.p9_aotaddrnewkraftnonstactcntev,
                              l.p15_aotssnnewkraftnonstactcntev,
                              l.p16_aotphnnewkraftnonstactcntev,
                              l.p17_aotemlnewkraftnonstactcntev,
                              l.p18_aotipnewkraftnonstactcntev,
                              l.p19_aotbkacnewkraftnonstactcntev,
                              l.p20_aotdlnewkraftnonstactcntev);    
                              
    SELF.aothiidcurrprofusngcntev := 0; // jp todo set this based on the high risk count further down.    

    SELF.aotidusngcntev := CHOOSE(C, 1,
                              l.p9_aotidusngaddrcntev,
                              l.p15_aotidusngssncntev,
                              l.p16_aotidusngphncntev,
                              l.p17_aotidusngemailcntev,
                              l.p18_aotidusngipaddrcntev,
                              l.p19_aotidusngbnkacctcntev,
                              l.p20_aotidusngdlcntev);    

    SELF.aotidactcntev := CHOOSE(C, L.p1_aotidactcntev,
                              l.p9_aotidactcntev,
                              l.p15_aotidactcntev,
                              l.p16_aotidactcntev,
                              l.p17_aotidactcntev,
                              l.p18_aotidactcntev,
                              l.p19_aotidactcntev,
                              l.p20_aotidactcntev);
    SELF := L;
END;

NonEntities := ['12638153115695167395', '14695981039346656037','12638153115695167395','','0000000000','4233676119','4073047705','']; 

SHARED PivotToEntities :=
            NORMALIZE(InputWithRules,8,NormIt(LEFT,COUNTER))(label != '' AND entitycontextuid[4..] NOT IN NonEntities) : PERSIST('~fraudgov::temp::fraudgov::temp::eventpivot'); // exclude entities that didn't exist on the transaction.


SHARED ProfileRowsPrep := PROJECT(PivotToEntities,
                 TRANSFORM(
                   RECORDOF(LEFT),
                    SELF.aothiidcurrprofusngcntev := 
                      MAP(LEFT.EntityType = 9 => 
                        MAP(LEFT.T9_AddrPopFlag=0 => -99999,
                          MAP(LEFT.T_SrcClassType < 2 OR LEFT.P9_AotIDCurrProfUsngAddrCntEv < 1 => -99998, 0)
                           ),
                      MAP(LEFT.EntityType = 15 => 
                        MAP(LEFT.T15_SSNPopFlag=0 => -99999,
                          MAP(LEFT.T_SrcClassType < 2 OR LEFT.P15_AoTIDCurrProfUsngSSNCntEv < 1 => -99998, 0)
                           ),
                      MAP(LEFT.EntityType = 16 => 
                        MAP(LEFT.T16_PhnPopFlag=0 => -99999,
                          MAP(LEFT.T_SrcClassType < 2 OR LEFT.P16_AoTIDCurrProfUsngPhnCntEv < 1 => -99998, 0)
                           ),                      
                      MAP(LEFT.EntityType = 17 =>
                        MAP(LEFT.T17_EmailPopFlag=0 => -99999,
                          MAP(LEFT.T_SrcClassType < 2 OR LEFT.P17_AoTIDCurrProfUsngEmlCntEv < 1 => -99998, 0)
                           ),
                      MAP(LEFT.EntityType = 18 =>
                        MAP(LEFT.T18_IPAddrPopFlag=0 => -99999,
                          MAP(LEFT.T_SrcClassType < 2 OR LEFT.P18_AoTIDCurrProfUsngIPCntEv < 1 => -99998, 0)
                           ),                      
                      MAP(LEFT.EntityType = 19 =>
                        MAP(LEFT.T19_BnkAcctPopFlag=0 => -99999,
                          MAP(LEFT.T_SrcClassType < 2 OR LEFT.P19_AoTIDCurrProfUsngBkAcCntEv < 1 => -99998, 0)
                           ),                   
                      MAP(LEFT.EntityType = 20 =>
                        MAP(LEFT.T20_DLPopFlag=0 => -99999,
                          MAP(LEFT.T_SrcClassType < 2 OR LEFT.P20_AoTIDCurrProfUsngDLCntEv < 1 => -99998, 0)
                           ),
                      0
                      )))))));
                    SELF := LEFT));
                    
EXPORT ProfileRows := ProfileRowsPrep(entitytype != 1 AND AotCurrProfFlag=1);

HighRiskIdentitiesPrep := TABLE(JOIN(ProfileRows(aothiidcurrprofusngcntev=0), PivotToEntities, 
                            LEFT.customerid=RIGHT.customerid AND LEFT.industrytype=RIGHT.industrytype AND
                            LEFT.entitycontextuid=RIGHT.entitycontextuid AND LEFT.P1_AotIdCurrProfFlag = 1,
                            TRANSFORM({LEFT.customerid,LEFT.industrytype, LEFT.entitycontextuid, LEFT.entitytype, RIGHT.personentitycontextuid},
                              SELF.personentitycontextuid := RIGHT.personentitycontextuid,
                              SELF := LEFT), HASH), 
                              {customerid,industrytype,entitycontextuid,entitytype,personentitycontextuid}, 
                              customerid,industrytype,entitycontextuid,entitytype,personentitycontextuid, MERGE);

HighRiskIdentityProfileRows := TABLE(PivotToEntities(AotCurrProfFlag=1 AND EntityType = 1 AND p1_idriskindx=3), 
                                 {customerid, industrytype, entitycontextuid, personentitycontextuid, addressentitycontextuid, ssnentitycontextuid, phoneentitycontextuid, emailentitycontextuid, ipentitycontextuid, bankaccountentitycontextuid, driverslicenseentitycontextuid}, 
                                 customerid, industrytype, entitycontextuid, personentitycontextuid, addressentitycontextuid,ssnentitycontextuid,phoneentitycontextuid,emailentitycontextuid,ipentitycontextuid,bankaccountentitycontextuid,driverslicenseentitycontextuid, MERGE); 

HighRiskIdentities := JOIN(HighRiskIdentitiesPrep, HighRiskIdentityProfileRows, 
                          LEFT.customerid=RIGHT.customerid AND LEFT.industrytype=RIGHT.industrytype AND 
                          LEFT.personentitycontextuid=RIGHT.EntityContextUid AND
                          (
                            (LEFT.entitytype = 9 AND LEFT.entitycontextuid = RIGHT.addressentitycontextuid) OR
                            (LEFT.entitytype = 15 AND LEFT.entitycontextuid = RIGHT.ssnentitycontextuid) OR
                            (LEFT.entitytype = 16 AND LEFT.entitycontextuid = RIGHT.phoneentitycontextuid) OR
                            (LEFT.entitytype = 17 AND LEFT.entitycontextuid = RIGHT.emailentitycontextuid) OR
                            (LEFT.entitytype = 18 AND LEFT.entitycontextuid = RIGHT.ipentitycontextuid) OR
                            (LEFT.entitytype = 19 AND LEFT.entitycontextuid = RIGHT.bankaccountentitycontextuid) OR
                            (LEFT.entitytype = 20 AND LEFT.entitycontextuid = RIGHT.driverslicenseentitycontextuid)                          
                          ),
                          TRANSFORM(RECORDOF(LEFT), SELF.personentitycontextuid := RIGHT.personentitycontextuid, SELF := LEFT),
                          HASH) : PERSIST('~fraudgov::temp::deleteme42');

EXPORT HighRiskIdentityCount := TABLE(HighRiskIdentities, {customerid,industrytype,entitycontextuid, aothiidcurrprofusngcntev := COUNT(GROUP)}, customerid,industrytype,entitycontextuid, MERGE);

EXPORT PivotToEntitiesWithHRICounts := JOIN(ProfileRowsPrep, HighRiskIdentityCount, 
                                  LEFT.customerid=RIGHT.customerid AND LEFT.industrytype=RIGHT.industrytype AND LEFT.entitycontextuid=RIGHT.entitycontextuid, 
                                  TRANSFORM(RECORDOF(LEFT), 
                                  SELF.aothiidcurrprofusngcntev := MAP(LEFT.aothiidcurrprofusngcntev < 0 => LEFT.aothiidcurrprofusngcntev, RIGHT.aothiidcurrprofusngcntev),
                                  SELF := LEFT), LEFT OUTER, HASH);
    
//Clean out from Modeling for UI
//codesToIgnore := '-99999\', \'-99998\', \'-99997';
//SHARED PivotClean := FraudgovKEL.macCleanAnalyticUIOutput(PivotToEntities, RECORDOF(PivotToEntities), codesToIgnore);

// Add Flags for Dashboard to know current vs historical.
dDistribute := DISTRIBUTE(PivotToEntitiesWithHRICounts, HASH32(customerid,industrytype,personentitycontextuid));//,entitycontextuid,idislasteventid,t_actdtecho));
dSort := SORT(dDistribute, customerid,industrytype,personentitycontextuid,entitycontextuid,-idislasteventid,-t_actdtecho, LOCAL);
dDedup := DEDUP(dSort, customerid,industrytype,personentitycontextuid,entitycontextuid,LOCAL);

rNew := RECORD
  UNSIGNED isCurrent; 
  UNSIGNED isHistorical; 
END;
rOut := RECORD
  RECORDOF(PivotToEntitiesWithHRICounts);
  rNew;
END;

SHARED PivotWithHistoricalCurrentFlags := JOIN(PivotToEntitiesWithHRICounts, dDedup,
  LEFT.customerid = RIGHT.customerid
  AND LEFT.industrytype = RIGHT.industrytype
  AND LEFT.entitycontextuid = RIGHT.entitycontextuid
  AND LEFT.personentitycontextuid = RIGHT.personentitycontextuid
  AND LEFT.idislasteventid = RIGHT.idislasteventid
  AND LEFT.t_actdtecho = RIGHT.t_actdtecho
  AND LEFT.t_actuid = RIGHT.t_actuid,
  TRANSFORM(rOut,
  self.aothiidcurrprofusngcntev := MAP(LEFT.aothiidcurrprofusngcntev < 0 => 0, LEFT.aothiidcurrprofusngcntev), // Doing this here so that we can use the EXPORT with the special values for modeling validation.
  SELF.isCurrent := IF(RIGHT.entitycontextuid <> '', RIGHT.idislasteventid, 0),
  SELF.isHistorical := IF(RIGHT.entitycontextuid <> '', IF((BOOLEAN)RIGHT.idislasteventid, 0, 1), 0);
  SELF := LEFT), LEFT OUTER, HASH) : PERSIST('~fraudgov::temp::PivotWithHistoricalCurrentFlags', EXPIRE(2));

// Transform the rules so that we have identity/element entity context uid with the rules at the last transaction that triggered 
// So one per entity.

SHARED LastRulesForEntities := JOIN(PivotWithHistoricalCurrentFlags(AotCurrProfFlag=1), RulesFlagsMatched,
                          LEFT.customerid=RIGHT.customerid AND LEFT.industrytype=RIGHT.industrytype AND ('_11' + LEFT.recordid) = RIGHT.entitycontextuid AND LEFT.entitytype=RIGHT.entitytype, 
                          TRANSFORM(RECORDOF(RIGHT) AND NOT [entitytype], SELF.entitycontextuid := LEFT.entitycontextuid, SELF := RIGHT), HASH);
                                                    
EXPORT EventPivotShell := PivotWithHistoricalCurrentFlags;
                                 
EXPORT EntityProfileRules := LastRulesForEntities;

END;
