import FraudgovKEL;
//import FraudGovPlatform_Analytics;
//IMPORT KEL12 AS KEL;
IMPORT Std;

//#option('multiplePersistInstances', false);
#option('defaultSkewError', 1);
//#option('freezepersists', true);
#option('resourceMaxHeavy', 2);
//#option('freezepersists', true);
#OPTION('expandSelectCreateRow', TRUE);

EntityAssessment := FraudgovKEL.KEL_EventPivot.EntityAssessment;
MyRules := FraudgovKEL.KEL_EventPivot.MyRules(rulename != 'rulename');
RulesFlagsMatched := FraudgovKEL.KEL_EventPivot.RulesFlagsMatched;

ModelingOutput := EntityAssessment;

RulesList := TABLE(MyRules, {customerid, industrytype, entitytype, rulename, description}, customerid, industrytype, entitytype, rulename, description, MERGE);

RulesFlagsMatchedPlusPrep := JOIN(ModelingOutput, RulesList, (LEFT.customerid=RIGHT.customerid AND LEFT.industrytype=RIGHT.industrytype) OR (RIGHT.customerid = 0),
                             TRANSFORM({LEFT.customerid, LEFT.industrytype, LEFT.entitycontextuid, RIGHT.entitytype, RIGHT.rulename, RIGHT.description}, SELF := LEFT, SELF := RIGHT), ALL);
                             
RulesFlagsMatchedPlus := JOIN(RulesFlagsMatchedPlusPrep, RulesFlagsMatched, 
                           LEFT.customerid=RIGHT.customerid AND LEFT.industrytype=RIGHT.industrytype AND LEFT.entitycontextuid=RIGHT.entitycontextuid AND 
                           LEFT.entitytype=RIGHT.entitytype AND LEFT.rulename=RIGHT.rulename,
                           TRANSFORM({RECORDOF(LEFT), RIGHT.RiskLevel}, SELF := LEFT, SELF := RIGHT), LEFT OUTER, HASH);

FinalRec := RECORD
  RECORDOF(RulesFlagsMatchedPlus);
  
  BOOLEAN FirstRowSet := FALSE;
  
  string p1_idriskrulenmlist;
  string p1_idriskruledesclist;
  string p1_idriskruleflaglist;
  string p1_idriskrulelvllist;

  string p9_addrriskrulenmlist;
  string p9_addrriskruledesclist;
  string p9_addrriskruleflaglist;
  string p9_addrriskrulelvllist;

  string p15_ssnriskrulenmlist;
  string p15_ssnriskruledesclist;
  string p15_ssnriskruleflaglist;
  string p15_ssnriskrulelvllist;

  string p16_phnriskrulenmlist;
  string p16_phnriskruledesclist;
  string p16_phnriskruleflaglist;
  string p16_phnriskrulelvllist;

  string p17_emailriskrulenmlist;
  string p17_emailriskruledesclist;
  string p17_emailriskruleflaglist;
  string p17_emailriskrulelvllist;

  string p18_ipriskrulenmlist;
  string p18_ipriskruledesclist;
  string p18_ipriskruleflaglist;
  string p18_ipriskrulelvllist;

  string p19_bnkriskrulenmlist;
  string p19_bnkriskruledesclist;
  string p19_bnkriskruleflaglist;
  string p19_bnkriskrulelvllist;

  string p20_dlriskrulenmlist;
  string p20_dlriskruledesclist;
  string p20_dlriskruleflaglist;
  string p20_dlriskrulelvllist;
  
END;

RulesFlagsFinal1 := PROJECT(RulesFlagsMatchedPlus,TRANSFORM(FinalRec, SELF := LEFT, SELF := [])); //create dataset to work with
RulesFlagsFinal1Sorted := SORT(RulesFlagsFinal1, customerid, industrytype, entitycontextuid, entitytype, rulename); //sort it first

FinalRec tFinal(FinalRec L,FinalRec R) := TRANSFORM
  SELF.P1_IDRiskRuleNmList :=MAP(L.entitytype = 1 AND NOT L.FirstRowSet => TRIM(L.rulename) + '|' + TRIM(R.rulename), 
                               MAP(R.entitytype = 1 => 
                                   TRIM(L.P1_IDRiskRuleNmList) + '|' + (R.rulename),
                                   TRIM(L.P1_IDRiskRuleNmList)));
  SELF.P1_IDRiskRuleDescList := MAP(L.entitytype = 1 AND NOT L.FirstRowSet => TRIM(L.description) + '|' + TRIM(R.description), 
                               MAP(R.entitytype = 1 => 
                                   TRIM(L.P1_IDRiskRuleDescList) + '|' + (R.description),
                                   TRIM(L.P1_IDRiskRuleDescList)));
  SELF.P1_IDRiskRuleFlagList := MAP(L.entitytype = 1 AND NOT L.FirstRowSet => MAP(L.RiskLevel=0 => '0','1') + '|' + MAP(R.RiskLevel=0 => '0','1'), 
                               MAP(R.entitytype = 1 => 
                                   TRIM(L.P1_IDRiskRuleFlagList) + '|' + MAP(R.RiskLevel=0 => '0','1'),
                                   TRIM(L.P1_IDRiskRuleFlagList)));
  SELF.P1_IDRiskRuleLvlList := MAP(L.entitytype = 1 AND NOT L.FirstRowSet => (STRING)L.RiskLevel + '|' + R.RiskLevel, 
                               MAP(R.entitytype = 1 => 
                                   TRIM(L.P1_IDRiskRuleLvlList) + '|' + R.RiskLevel,
                                   TRIM(L.P1_IDRiskRuleLvlList)));


  SELF.P9_addrRiskRuleNmList :=MAP(L.entitytype = 9 AND NOT L.FirstRowSet => TRIM(L.rulename) + '|' + TRIM(R.rulename), 
                               MAP(R.entitytype = 9 => 
                                   TRIM(L.P9_addrRiskRuleNmList) + '|' + (R.rulename),
                                   TRIM(L.P9_addrRiskRuleNmList)));
  SELF.P9_addrRiskRuleDescList := MAP(L.entitytype = 9 AND NOT L.FirstRowSet => TRIM(L.description) + '|' + TRIM(R.description), 
                               MAP(R.entitytype = 9 => 
                                   TRIM(L.P9_addrRiskRuleDescList) + '|' + (R.description),
                                   TRIM(L.P9_addrRiskRuleDescList)));
  SELF.P9_addrRiskRuleFlagList := MAP(L.entitytype = 9 AND NOT L.FirstRowSet => MAP(L.RiskLevel=0 => '0','1') + '|' + MAP(R.RiskLevel=0 => '0','1'), 
                               MAP(R.entitytype = 9 => 
                                   TRIM(L.P9_addrRiskRuleFlagList) + '|' + MAP(R.RiskLevel=0 => '0','1'),
                                   TRIM(L.P9_addrRiskRuleFlagList)));
  SELF.P9_addrRiskRuleLvlList := MAP(L.entitytype = 9 AND NOT L.FirstRowSet => (STRING)L.RiskLevel + '|' + R.RiskLevel, 
                               MAP(R.entitytype = 9 => 
                                   TRIM(L.P9_addrRiskRuleLvlList) + '|' + R.RiskLevel,
                                   TRIM(L.P9_addrRiskRuleLvlList)));
                                   
  SELF.p15_ssnRiskRuleNmList :=MAP(L.entitytype = 15 AND NOT L.FirstRowSet => TRIM(L.rulename) + '|' + TRIM(R.rulename), 
                               MAP(R.entitytype = 15 => 
                                   TRIM(L.p15_ssnRiskRuleNmList) + '|' + (R.rulename),
                                   TRIM(L.p15_ssnRiskRuleNmList)));
  SELF.p15_ssnRiskRuleDescList := MAP(L.entitytype = 15 AND NOT L.FirstRowSet => TRIM(L.description) + '|' + TRIM(R.description), 
                               MAP(R.entitytype = 15 => 
                                   TRIM(L.p15_ssnRiskRuleDescList) + '|' + (R.description),
                                   TRIM(L.p15_ssnRiskRuleDescList)));
  SELF.p15_ssnRiskRuleFlagList := MAP(L.entitytype = 15 AND NOT L.FirstRowSet => MAP(L.RiskLevel=0 => '0','1') + '|' + MAP(R.RiskLevel=0 => '0','1'), 
                               MAP(R.entitytype = 15 => 
                                   TRIM(L.p15_ssnRiskRuleFlagList) + '|' + MAP(R.RiskLevel=0 => '0','1'),
                                   TRIM(L.p15_ssnRiskRuleFlagList)));
  SELF.p15_ssnRiskRuleLvlList := MAP(L.entitytype = 15 AND NOT L.FirstRowSet => (STRING)L.RiskLevel + '|' + R.RiskLevel, 
                               MAP(R.entitytype = 15 => 
                                   TRIM(L.p15_ssnRiskRuleLvlList) + '|' + R.RiskLevel,
                                   TRIM(L.p15_ssnRiskRuleLvlList)));

  SELF.p16_phnRiskRuleNmList :=MAP(L.entitytype = 16 AND NOT L.FirstRowSet => TRIM(L.rulename) + '|' + TRIM(R.rulename), 
                               MAP(R.entitytype = 16 => 
                                   TRIM(L.p16_phnRiskRuleNmList) + '|' + (R.rulename),
                                   TRIM(L.p16_phnRiskRuleNmList)));
  SELF.p16_phnRiskRuleDescList := MAP(L.entitytype = 16 AND NOT L.FirstRowSet => TRIM(L.description) + '|' + TRIM(R.description), 
                               MAP(R.entitytype = 16 => 
                                   TRIM(L.p16_phnRiskRuleDescList) + '|' + (R.description),
                                   TRIM(L.p16_phnRiskRuleDescList)));
  SELF.p16_phnRiskRuleFlagList := MAP(L.entitytype = 16 AND NOT L.FirstRowSet => MAP(L.RiskLevel=0 => '0','1') + '|' + MAP(R.RiskLevel=0 => '0','1'), 
                               MAP(R.entitytype = 16 => 
                                   TRIM(L.p16_phnRiskRuleFlagList) + '|' + MAP(R.RiskLevel=0 => '0','1'),
                                   TRIM(L.p16_phnRiskRuleFlagList)));
  SELF.p16_phnRiskRuleLvlList := MAP(L.entitytype = 16 AND NOT L.FirstRowSet => (STRING)L.RiskLevel + '|' + R.RiskLevel, 
                               MAP(R.entitytype = 16 => 
                                   TRIM(L.p16_phnRiskRuleLvlList) + '|' + R.RiskLevel,
                                   TRIM(L.p16_phnRiskRuleLvlList)));

  SELF.p17_emailRiskRuleNmList :=MAP(L.entitytype = 17 AND NOT L.FirstRowSet => TRIM(L.rulename) + '|' + TRIM(R.rulename), 
                               MAP(R.entitytype = 17 => 
                                   TRIM(L.p17_emailRiskRuleNmList) + '|' + (R.rulename),
                                   TRIM(L.p17_emailRiskRuleNmList)));
  SELF.p17_emailRiskRuleDescList := MAP(L.entitytype = 17 AND NOT L.FirstRowSet => TRIM(L.description) + '|' + TRIM(R.description), 
                               MAP(R.entitytype = 17 => 
                                   TRIM(L.p17_emailRiskRuleDescList) + '|' + (R.description),
                                   TRIM(L.p17_emailRiskRuleDescList)));
  SELF.p17_emailRiskRuleFlagList := MAP(L.entitytype = 17 AND NOT L.FirstRowSet => MAP(L.RiskLevel=0 => '0','1') + '|' + MAP(R.RiskLevel=0 => '0','1'), 
                               MAP(R.entitytype = 17 => 
                                   TRIM(L.p17_emailRiskRuleFlagList) + '|' + MAP(R.RiskLevel=0 => '0','1'),
                                   TRIM(L.p17_emailRiskRuleFlagList)));
  SELF.p17_emailRiskRuleLvlList := MAP(L.entitytype = 17 AND NOT L.FirstRowSet => (STRING)L.RiskLevel + '|' + R.RiskLevel, 
                               MAP(R.entitytype = 17 => 
                                   TRIM(L.p17_emailRiskRuleLvlList) + '|' + R.RiskLevel,
                                   TRIM(L.p17_emailRiskRuleLvlList)));

  SELF.p18_ipRiskRuleNmList :=MAP(L.entitytype = 18 AND NOT L.FirstRowSet => TRIM(L.rulename) + '|' + TRIM(R.rulename), 
                               MAP(R.entitytype = 18 => 
                                   TRIM(L.p18_ipRiskRuleNmList) + '|' + (R.rulename),
                                   TRIM(L.p18_ipRiskRuleNmList)));
  SELF.p18_ipRiskRuleDescList := MAP(L.entitytype = 18 AND NOT L.FirstRowSet => TRIM(L.description) + '|' + TRIM(R.description), 
                               MAP(R.entitytype = 18 => 
                                   TRIM(L.p18_ipRiskRuleDescList) + '|' + (R.description),
                                   TRIM(L.p18_ipRiskRuleDescList)));
  SELF.p18_ipRiskRuleFlagList := MAP(L.entitytype = 18 AND NOT L.FirstRowSet => MAP(L.RiskLevel=0 => '0','1') + '|' + MAP(R.RiskLevel=0 => '0','1'), 
                               MAP(R.entitytype = 18 => 
                                   TRIM(L.p18_ipRiskRuleFlagList) + '|' + MAP(R.RiskLevel=0 => '0','1'),
                                   TRIM(L.p18_ipRiskRuleFlagList)));
  SELF.p18_ipRiskRuleLvlList := MAP(L.entitytype = 18 AND NOT L.FirstRowSet => (STRING)L.RiskLevel + '|' + R.RiskLevel, 
                               MAP(R.entitytype = 18 => 
                                   TRIM(L.p18_ipRiskRuleLvlList) + '|' + R.RiskLevel,
                                   TRIM(L.p18_ipRiskRuleLvlList)));

  SELF.p19_bnkRiskRuleNmList :=MAP(L.entitytype = 19 AND NOT L.FirstRowSet => TRIM(L.rulename) + '|' + TRIM(R.rulename), 
                               MAP(R.entitytype = 19 => 
                                   TRIM(L.p19_bnkRiskRuleNmList) + '|' + (R.rulename),
                                   TRIM(L.p19_bnkRiskRuleNmList)));
  SELF.p19_bnkRiskRuleDescList := MAP(L.entitytype = 19 AND NOT L.FirstRowSet => TRIM(L.description) + '|' + TRIM(R.description), 
                               MAP(R.entitytype = 19 => 
                                   TRIM(L.p19_bnkRiskRuleDescList) + '|' + (R.description),
                                   TRIM(L.p19_bnkRiskRuleDescList)));
  SELF.p19_bnkRiskRuleFlagList := MAP(L.entitytype = 19 AND NOT L.FirstRowSet => MAP(L.RiskLevel=0 => '0','1') + '|' + MAP(R.RiskLevel=0 => '0','1'), 
                               MAP(R.entitytype = 19 => 
                                   TRIM(L.p19_bnkRiskRuleFlagList) + '|' + MAP(R.RiskLevel=0 => '0','1'),
                                   TRIM(L.p19_bnkRiskRuleFlagList)));
  SELF.p19_bnkRiskRuleLvlList := MAP(L.entitytype = 19 AND NOT L.FirstRowSet => (STRING)L.RiskLevel + '|' + R.RiskLevel, 
                               MAP(R.entitytype = 19 => 
                                   TRIM(L.p19_bnkRiskRuleLvlList) + '|' + R.RiskLevel,
                                   TRIM(L.p19_bnkRiskRuleLvlList)));

  SELF.p20_dlRiskRuleNmList :=MAP(L.entitytype = 20 AND NOT L.FirstRowSet => TRIM(L.rulename) + '|' + TRIM(R.rulename), 
                               MAP(R.entitytype = 20 => 
                                   TRIM(L.p20_dlRiskRuleNmList) + '|' + (R.rulename),
                                   TRIM(L.p20_dlRiskRuleNmList)));
  SELF.p20_dlRiskRuleDescList := MAP(L.entitytype = 20 AND NOT L.FirstRowSet => TRIM(L.description) + '|' + TRIM(R.description), 
                               MAP(R.entitytype = 20 => 
                                   TRIM(L.p20_dlRiskRuleDescList) + '|' + (R.description),
                                   TRIM(L.p20_dlRiskRuleDescList)));
  SELF.p20_dlRiskRuleFlagList := MAP(L.entitytype = 20 AND NOT L.FirstRowSet => MAP(L.RiskLevel=0 => '0','1') + '|' + MAP(R.RiskLevel=0 => '0','1'), 
                               MAP(R.entitytype = 20 => 
                                   TRIM(L.p20_dlRiskRuleFlagList) + '|' + MAP(R.RiskLevel=0 => '0','1'),
                                   TRIM(L.p20_dlRiskRuleFlagList)));
  SELF.p20_dlRiskRuleLvlList := MAP(L.entitytype = 20 AND NOT L.FirstRowSet => (STRING)L.RiskLevel + '|' + R.RiskLevel, 
                               MAP(R.entitytype = 20 => 
                                   TRIM(L.p20_dlRiskRuleLvlList) + '|' + R.RiskLevel,
                                   TRIM(L.p20_dlRiskRuleLvlList)));
                                   
  SELF.FirstRowSet := TRUE;
  SELF := L; //keeping the L rec makes it KEEP(1),LEFT
// SELF := R; //keeping the R rec would make it KEEP(1),RIGHT
END;
RulesFlagFinal1 := ROLLUP(RulesFlagsFinal1Sorted,
                  LEFT.customerid=RIGHT.customerid AND LEFT.industrytype=RIGHT.industrytype AND LEFT.entitycontextuid=RIGHT.entitycontextuid,
                  tFinal(LEFT,RIGHT));
                  
RulesFlagFinal := JOIN(RulesFlagFinal1, ModelingOutput, LEFT.customerid=RIGHT.customerid AND LEFT.industrytype=RIGHT.industrytype AND LEFT.entitycontextuid=RIGHT.entitycontextuid,
       TRANSFORM({LEFT.customerid, LEFT.industrytype, STRING t_actuid, 
                  LEFT.p1_idriskrulenmlist, 
                  LEFT.p1_idriskruledesclist, 
                  LEFT.p1_idriskruleflaglist, 
                  LEFT.p1_idriskrulelvllist, 
                  
                  LEFT.p15_ssnriskrulenmlist, 
                  LEFT.p15_ssnriskruledesclist, 
                  LEFT.p15_ssnriskruleflaglist, 
                  LEFT.p15_ssnriskrulelvllist, 

                  LEFT.p16_phnriskrulenmlist, 
                  LEFT.p16_phnriskruledesclist, 
                  LEFT.p16_phnriskruleflaglist, 
                  LEFT.p16_phnriskrulelvllist, 

                  LEFT.p17_emailriskrulenmlist, 
                  LEFT.p17_emailriskruledesclist, 
                  LEFT.p17_emailriskruleflaglist, 
                  LEFT.p17_emailriskrulelvllist, 

                  LEFT.p18_ipriskrulenmlist, 
                  LEFT.p18_ipriskruledesclist, 
                  LEFT.p18_ipriskruleflaglist, 
                  LEFT.p18_ipriskrulelvllist, 

                  LEFT.p19_bnkriskrulenmlist, 
                  LEFT.p19_bnkriskruledesclist, 
                  LEFT.p19_bnkriskruleflaglist, 
                  LEFT.p19_bnkriskrulelvllist, 

                  LEFT.p20_dlriskrulenmlist, 
                  LEFT.p20_dlriskruledesclist, 
                  LEFT.p20_dlriskruleflaglist, 
                  LEFT.p20_dlriskrulelvllist, 

                  LEFT.P9_addrriskrulenmlist, 
                  LEFT.P9_addrriskruledesclist, 
                  LEFT.P9_addrriskruleflaglist, 
                  LEFT.P9_addrriskrulelvllist, 
                  
                  RIGHT.p1_idriskindx, RIGHT.p15_ssnriskindx, RIGHT.p16_phnriskindx, RIGHT.p17_emailriskindx, 
                  RIGHT.p19_bnkacctriskindx, RIGHT.p20_dlriskindx, RIGHT.p18_ipaddrriskindx, RIGHT.p9_addrriskindx}, SELF.t_actuid := LEFT.entitycontextuid[4..], SELF := LEFT, SELF := RIGHT), HASH);

//output(RulesFlagFinal,, '~fraudgov::temp::scoringoutput', CSV(SEPARATOR(','), QUOTE('"')), overwrite);             

HighRiskCountsPrep := TABLE(FraudgovKEL.KEL_EventPivot.PivotToEntitiesWithHRICounts, 
                    {customerid, industrytype, t_actuid, entitycontextuid,  
                     INTEGER P15_AoTHiIDCurrProfUsngSSNCntEv := MAP(entitytype = 15 => aothiidcurrprofusngcntev, -99999),
                     INTEGER P16_AoTHiIDCurrProfUsngPhnCntEv := MAP(entitytype = 16 => aothiidcurrprofusngcntev, -99999),
                     INTEGER P17_AoTHiIDCurrProfUsngEmlCntEv := MAP(entitytype = 17 => aothiidcurrprofusngcntev, -99999),
                     INTEGER P18_AoTHiIDCurrProfUsngIPCntEv := MAP(entitytype = 18 => aothiidcurrprofusngcntev, -99999),
                     INTEGER P19_AoTHiIDCurrProfUsngBkAcCntEv := MAP(entitytype = 19 => aothiidcurrprofusngcntev, -99999),
                     INTEGER P20_AoTHiIDCurrProfUsngDLCntEv := MAP(entitytype = 20 => aothiidcurrprofusngcntev, -99999),
                     INTEGER P9_AoTHiIDCurrProfUsngAddrCntEv := MAP(entitytype = 9 => aothiidcurrprofusngcntev, -99999)}, 
                     customerid, industrytype, t_actuid, entitycontextuid, MERGE);
								
HighRiskCounts := TABLE(HighRiskCountsPrep, 
                    {customerid, industrytype, t_actuid,
                     INTEGER P15_AoTHiIDCurrProfUsngSSNCntEv := MAX(GROUP, P15_AoTHiIDCurrProfUsngSSNCntEv),
                     INTEGER P16_AoTHiIDCurrProfUsngPhnCntEv := MAX(GROUP, P16_AoTHiIDCurrProfUsngPhnCntEv),
                     INTEGER P17_AoTHiIDCurrProfUsngEmlCntEv := MAX(GROUP, P17_AoTHiIDCurrProfUsngEmlCntEv),
                     INTEGER P18_AoTHiIDCurrProfUsngIPCntEv := MAX(GROUP, P18_AoTHiIDCurrProfUsngIPCntEv),
                     INTEGER P19_AoTHiIDCurrProfUsngBkAcCntEv := MAX(GROUP, P19_AoTHiIDCurrProfUsngBkAcCntEv),
                     INTEGER P20_AoTHiIDCurrProfUsngDLCntEv := MAX(GROUP, P20_AoTHiIDCurrProfUsngDLCntEv),
                     INTEGER P9_AoTHiIDCurrProfUsngAddrCntEv := MAX(GROUP, P9_AoTHiIDCurrProfUsngAddrCntEv),
                     }, 
                     customerid, industrytype, t_actuid, MERGE);        

// JOIN High Risk Counts to Modeling Output
//ModelingAttributeOutput := FraudgovKEL.KEL_EventShell.ModelingStats;//((AgencyProgType = 1029 and AgencyUID = 20995239) AND (P1_AoTIDCurrProfFlag = 1 OR P9_AoTAddrCurrProfFlag = 1 OR P15_AoTSSNCurrProfFlag = 1 OR P16_AoTPhnCurrProfFlag = 1 OR P17_AoTEmailCurrProfFlag = 1 OR P18_AoTIPAddrCurrProfFlag = 1 OR P19_AoTBnkAcctCurrProfFlag = 1 OR P20_AoTDLCurrProfFlag = 1));

ModelingAttributeOutput := JOIN(FraudgovKEL.KEL_EventShell.ModelingStats, FraudgovKEL.KEL_ModelingValidationSample,
                       LEFT.personentitycontextuid=RIGHT.personentitycontextuid, 
                       TRANSFORM(RECORDOF(LEFT), SELF := LEFT), LOOKUP, HASH);

ModelingWithHRICounts := JOIN(ModelingAttributeOutput, HighRiskCounts, LEFT.agencyuid = RIGHT.customerid AND LEFT.agencyprogtype=RIGHT.industrytype AND LEFT.t_actuid=RIGHT.t_actuid, HASH);
                    
// JOIN Scoring Debug to Modeling Output

ModelingWithScoringDebug := PROJECT(JOIN(ModelingWithHRICounts, RulesFlagFinal, LEFT.agencyuid = RIGHT.customerid AND LEFT.agencyprogtype=RIGHT.industrytype AND (UNSIGNED8)LEFT.t_actuid=(UNSIGNED8)RIGHT.t_actuid, HASH), 
                              TRANSFORM({RECORDOF(LEFT) AND NOT [customerid, industrytype]}, SELF := LEFT));
                              
                          
ModelingValidationLayout := RECORD
  string entitycontextuid;
  integer8 t_actuid;
  string personentitycontextuid;
  string addressentitycontextuid;
  string ssnentitycontextuid;
  string phoneentitycontextuid;
  string emailentitycontextuid;
  string ipentitycontextuid;
  string bankaccountentitycontextuid;
  string driverslicenseentitycontextuid;
  integer8 agencyuid;
  integer8 agencyprogtype;
  string agencyprogdesc;
  string agencyprogjurst;
  string agencydesc;
  unsigned4 t_actdtecho;
  string t_acttmecho;
  integer8 t_srcagencyuid;
  integer8 t_srcagencyprogtype;
  string t_srcagencyprogdesc;
  string t_srcagencyprogjurst;
  string t_srcagencydesc;
  integer8 t_inagencyflag;
  integer8 t_srctype;
  string t_srcdesc;
  integer8 t_srcclasstype;
  integer8 t_personuidecho;
  string t_inpclntitleecho;
  string t_inpclnfirstnmecho;
  string t_inpclnmiddlenmecho;
  string t_inpclnlastnmecho;
  string t_inpclnnmsuffixecho;
  string t_inpclnfullnmecho;
  string t_inpaddrtypeecho;
  string t_inpclnaddrstreetecho;
  string t_inpclnaddrprimrangeecho;
  string t_inpclnaddrpredirecho;
  string t_inpclnaddrprimnmecho;
  string t_inpclnaddrsuffixecho;
  string t_inpclnaddrpostdirecho;
  string t_inpclnaddrunitdesigecho;
  string t_inpclnaddrsecrangeecho;
  string t_inpclnaddrcityecho;
  string t_inpclnaddrstecho;
  string t_inpclnaddrzip5echo;
  string t_inpclnaddrzip4echo;
  real8 t_inpclnaddrlatecho;
  real8 t_inpclnaddrlongecho;
  string t_inpclnaddrgeomatchecho;
  string t_inpclnaddrcountyecho;
  integer8 t_inpclnaddrgeoblkecho;
  string t_inpclnssnecho;
  integer8 t_inpclndobecho;
  string t_inpclndlecho;
  string t_inpclndlstecho;
  string t_inpphncontacttypeecho;
  string t_inpclnphnecho;
  string t_inpclnemailecho;
  string t_inpclnipaddrecho;
  string t_inpclnbnkacctecho;
  string t_inpclnbnkacctrtgecho;
  string t_inpclnmailingaddrstreetecho;
  string t_inpclnmailingaddrcityecho;
  string t_inpclnmailingaddrstecho;
  string t_inpclnmailingaddrzipecho;
  string t_inpclncellphnecho;
  string t_inpclnworkphnecho;
  string t_inpclnbnkacct2echo;
  string t_inpclnbnkacctrtg2echo;
  string t_inpdvcidecho;
  string t_inpdvcuniquenumecho;
  string t_inpdvcmacaddrecho;
  string t_inpdvcserialnumecho;
  string t_inpdvctypeecho;
  string t_inpdvcidprovecho;
  real8 t_inpdvclatecho;
  real8 t_inpdvclongecho;
  string t_inpethnicityecho;
  string t_inpraceecho;
  string t_inpheadofhhecho;
  string t_inprelationshipecho;
  string t_inpcaseidecho;
  string t_inpclientidecho;
  string t_inpreasondescecho;
  string t_agencyusernm;
  string t_inpinvestigatoridecho;
  string t_inpreferralcaseidecho;
  string t_inpreferraltypedescecho;
  string t_inpreferralreasondescecho;
  string t_inpreferraldispositionecho;
  string t_inpclearedfraudecho;
  string t_inpclearedreasonecho;
  integer8 t1_lexidpopflag;
  integer8 t1_rinidpopflag;
  integer8 t_firstnmpopflag;
  integer8 t_lastnmpopflag;
 integer8 t9_addrpopflag;
  integer8 t15_ssnpopflag;
  integer8 t_dobpopflag;
  integer8 t20_dlpopflag;
  integer8 t16_phnpopflag;
  integer8 t18_ipaddrpopflag;
  integer8 t17_emailpopflag;
  integer8 t19_bnkacctpopflag;
  integer8 t_isbcshllhitflag;
  integer8 t_bcshlllexidecho;
  integer8 t1l_lexidseenflag;
  integer8 t1l_bcshlllexidmatchesinpflag;
  integer8 t1l_idisbcshllhitflag;
  string t_bcshllarchdtecho;
  integer8 t1l_idcrimhitflag;
  integer8 t1l_idcrimflsdmatchflag;
  integer8 t18_isipmetahitflag;
  integer8 t19_isbnkapphitflag;
  integer8 t16_isphnmetahitflag;
  integer8 t16_phnmetanewvenddt;
  integer8 t16_phnmetaoldvenddt;
  integer8 t1_idage;
  integer8 t1_minoridflag;
  integer8 t1_adultidnotseenflag;
  integer8 t1_minorwlexidflag;
  integer8 t1l_iddeceasedflag;
  integer8 t1l_iddtofdeath;
  integer8 t1l_iddtofdeathaftidactcntev;
  integer8 t1l_iddtofdeathaftidactflagev;
  integer8 t1l_idcurrincarcflag;
  integer8 t1l_dobverindx;
  integer8 t1_napsummary;
  integer8 t1l_nassummary;
  integer8 t1_cvi;
  integer8 t1l_fp_sourcerisklevel;
  string t1_ssnpriordobflag;
  integer8 t1_firstnmnotverflag;
  integer8 t1_lastnmnotverflag;
  integer8 t1_addrnotverflag;
  integer8 t1l_ssnnotverflag;
  integer8 t1l_ssnwaltnaverflag;
  integer8 t1l_ssnwaddrnotverflag;
  integer8 t1_phnnotverflag;
  integer8 t1l_dobnotverflag;
  integer8 t1_hiriskcviflag;
  integer8 t1_medriskcviflag;
  integer8 t1l_hdrsrccatcntlwflag;
  string t1_fp3;
  integer8 t1_fp3_stolenidentityindex;
  integer8 t1_fp3_syntheticidentityindex;
  integer8 t1_fp3_manipidentityindex;
  integer8 t1_stolidflag;
  integer8 t1_synthidflag;
  integer8 t1_manipidflag;
  string t1l_bestfirstnmecho;
  string t1l_bestlastnmecho;
  integer8 t1l_bestfirstnmpopflag;
  integer8 t1l_bestlastnmpopflag;
  string t1l_bestfullnmecho;
  string t1l_curraddrprimrangeecho;
  string t1l_curraddrpredirecho;
  string t1l_curraddrprimnmecho;
  string t1l_curraddrsuffixecho;
  string t1l_curraddrpostdirecho;
  string t1l_curraddrunitdesigecho;
  string t1l_curraddrsecrangeecho;
  string t1l_curraddrcityecho;
  string t1l_curraddrstecho;
  string t1l_curraddrzip5echo;
  integer8 t1l_curraddrpopflag;
  string t1l_curraddrfullecho;
  integer8 t1l_curraddrolddt;
  integer8 t1l_curraddrnewdt;
  string t1l_bestssnecho;
  integer8 t1l_bestssnpopflag;
  integer8 t1l_bestdobecho;
  integer8 t1l_bestdobpopflag;
  string t1l_bestphnecho;
  integer8 t1l_bestphnpopflag;
  string t1l_bestdlecho;
  string t1l_bestdlstecho;
  integer8 t1l_bestdlpopflag;
  string t1l_bestdlexpdt;
  integer8 t1l_curraddrnotinagcyjurstflag;
  integer8 t1l_bestdlnotinagcyjurstflag;
  string t1l_bestfirstnmmatchesinpflag;
  string t1l_bestlastnmmatchesinpflag;
  integer8 t1l_bestfullnmmatchesinpflag;
  integer8 t1l_curraddrmatchesinpflag;
  string t1l_bestssnmatchesinpflag;
  integer8 t1l_bestdobmatchesinpflag;
  integer8 t1l_bestphnmatchesinpflag;
  integer8 t1l_bestdlmatchesinpflag;
  string t9_addrstatus;
  string t9_addrtype;
  string t9_addrvaltype;
  string t9_addrmaildroptype;
  integer8 t9_addrisvacantflag;
  integer8 t9_addrisinvalidflag;
  integer8 t9_addriscmraflag;
  integer8 t9_addrnotinagcyjurstflag;
  string t15_ssnvaltype;
  integer8 t15_ssnisinvalidflag;
  string t20_dlvaltype;
  integer8 t20_dlisinvalidflag;
  string t16_phnvaltype;
  integer8 t16_phnisinvalidflag;
  string t16_phnprepdflag;
  string t18_ipaddrcity;
  string t18_ipaddrcountry;
  string t18_ipaddrregion;
  string t18_ipaddrgeoloclat;
  string t18_ipaddrgeoloclong;
  string t18_ipaddrdomain;
  string t18_ipaddrispnm;
  string t18_ipaddrloctype;
  string t18_ipaddrproxytype;
  string t18_ipaddrproxydesc;
  integer8 t18_ipaddrisispflag;
  string t18_ipaddrasncompnm;
  string t18_ipaddrasn;
  string t18_ipaddrcompnm;
  string t18_ipaddrorgnm;
  integer8 t18_ipaddrhostedflag;
  integer8 t18_ipaddrvpnflag;
  integer8 t18_ipaddrtornodeflag;
  integer8 t18_ipaddrlocnonusflag;
  integer8 t18_ipaddrlocmiamiflag;
  string t17_emaildomain;
  integer8 t17_emaildomaindispflag;
  string t19_bnkacctbnknm;
  integer8 t19_bnkaccthrprepdrtgflag;
  integer8 t9_idcurrprofusngaddrcntev;
  integer8 t9_addrpoboxmultcurridflagev;
  integer8 t15_idcurrprofusngssncntev;
  integer8 t15_ssnmultcurridflagev;
  integer8 t20_idcurrprofusngdlcntev;
  integer8 t20_dlmultcurridflagev;
  integer8 t19_idcurrprofusngbnkacctcntev;
  integer8 t19_bnkacctmultcurridflagev;
  string t_statusactiondesc;
  integer8 t_evttype1statuscodeecho;
  integer8 t_evttype2statuscodeecho;
  integer8 t_evttype3statuscodeecho;
  integer8 t_namestatuscodeecho;
  integer8 t_idstatuscodeecho;
  integer8 t_ssnstatuscodeecho;
  integer8 t_dlstatuscodeecho;
  integer8 t_addrstatuscodeecho;
  integer8 t_phnstatuscodeecho;
  integer8 t_emailstatuscodeecho;
  integer8 t_ipaddrstatuscodeecho;
  integer8 t_bnkacctstatuscodeecho;
  integer8 t1_idiskrappfrdflag;
  integer8 t1_idiskrgenfrdflag;
  integer8 t1_idiskrstolidflag;
  integer8 t1_idiskrothfrdflag;
  integer8 t1_idiskrflag;
  integer8 t9_addriskrflag;
  integer8 t15_ssniskrflag;
  integer8 t16_phniskrflag;
  integer8 t17_emailiskrflag;
  integer8 t18_ipaddriskrflag;
  integer8 t19_bnkacctiskrflag;
  integer8 t20_dliskrflag;
  integer8 t9_addrissafeflag;
  integer8 t16_phnissafeflag;
  integer8 t18_ipaddrissafeflag;
  integer8 t1_idinvupdflag;
  integer8 p1_aotidcurrprofflag;
  integer8 p9_aotaddrcurrprofflag;
  integer8 p15_aotssncurrprofflag;
  integer8 p16_aotphncurrprofflag;
  integer8 p17_aotemailcurrprofflag;
  integer8 p18_aotipaddrcurrprofflag;
  integer8 p19_aotbnkacctcurrprofflag;
  integer8 p20_aotdlcurrprofflag;
  integer8 p1_aotidkractcntev;
  integer8 p1_aotidkractflagev;
  integer8 p1_aotidkractolddtev;
  integer8 p1_aotidkractnewdtev;
  integer8 p1_aotidkrappfrdactcntev;
  integer8 p1_aotidkrappfrdactflagev;
  integer8 p1_aotidkrappfrdactolddtev;
  integer8 p1_aotidkrappfrdactnewdtev;
  integer8 p1_aotidkrgenfrdactcntev;
  integer8 p1_aotidkrgenfrdactflagev;
  integer8 p1_aotidkrgenfrdactolddtev;
  integer8 p1_aotidkrgenfrdactnewdtev;
  integer8 p1_aotidkrothfrdactcntev;
  integer8 p1_aotidkrothfrdactflagev;
  integer8 p1_aotidkrothfrdactolddtev;
 integer8 p1_aotidkrothfrdactnewdtev;
  integer8 p1_aotidkrstolidactcntev;
  integer8 p1_aotidkrstolidactflagev;
  integer8 p1_aotidkrstolidactolddtev;
  integer8 p1_aotidkrstolidactnewdtev;
  integer8 p9_aotaddrkractcntev;
  integer8 p9_aotaddrkractflagev;
  integer8 p9_aotaddrkractolddtev;
  integer8 p9_aotaddrkractnewdtev;
  integer8 p15_aotssnkractcntev;
  integer8 p15_aotssnkractflagev;
  integer8 p15_aotssnkractolddtev;
  integer8 p15_aotssnkractnewdtev;
  integer8 p16_aotphnkractcntev;
  integer8 p16_aotphnkractflagev;
  integer8 p16_aotphnkractolddtev;
  integer8 p16_aotphnkractnewdtev;
  integer8 p17_aotemailkractcntev;
  integer8 p17_aotemailkractflagev;
  integer8 p17_aotemailkractolddtev;
  integer8 p17_aotemailkractnewdtev;
  integer8 p18_aotipaddrkractcntev;
  integer8 p18_aotipaddrkractflagev;
  integer8 p18_aotipaddrkractolddtev;
  integer8 p18_aotipaddrkractnewdtev;
  integer8 p19_aotbnkacctkractcntev;
  integer8 p19_aotbnkacctkractflagev;
  integer8 p19_aotbnkacctkractolddtev;
  integer8 p19_aotbnkacctkractnewdtev;
  integer8 p20_aotdlkractcntev;
  integer8 p20_aotdlkractflagev;
  integer8 p20_aotdlkractolddtev;
  integer8 p20_aotdlkractnewdtev;
  integer8 p9_aotaddrsafeactcntev;
  integer8 p9_aotaddrsafeactflagev;
  integer8 p9_aotaddrsafeactolddtev;
  integer8 p9_aotaddrsafeactnewdtev;
  integer8 p16_aotphnsafeactcntev;
  integer8 p16_aotphnsafeactflagev;
  integer8 p16_aotphnsafeactolddtev;
  integer8 p16_aotphnsafeactnewdtev;
  integer8 p18_aotipaddrsafeactcntev;
  integer8 p18_aotipaddrsafeactflagev;
  integer8 p18_aotipaddrsafeactolddtev;
  integer8 p18_aotipaddrsafeactnewdtev;
  integer8 p1_aotidkractinagcycntev;
  integer8 p1_aotidkractinagcyflagev;
  integer8 p1_aotidkractinagcyolddtev;
  integer8 p1_aotidkractinagcynewdtev;
  integer8 p1_aotidkrappfrdactinagcycntev;
  integer8 p1_aotidkrappfrdactinagcyflagev;
  integer8 p1_aotidkrappfrdactinagcyolddtev;
  integer8 p1_aotidkrappfrdactinagcynewdtev;
  integer8 p1_aotidkrgenfrdactinagcycntev;
  integer8 p1_aotidkrgenfrdactinagcyflagev;
  integer8 p1_aotidkrgenfrdactinagcyolddtev;
  integer8 p1_aotidkrgenfrdactinagcynewdtev;
  integer8 p1_aotidkrothfrdactinagcycntev;
  integer8 p1_aotidkrothfrdactinagcyflagev;
  integer8 p1_aotidkrothfrdactinagcyolddtev;
  integer8 p1_aotidkrothfrdactinagcynewdtev;
  integer8 p1_aotidkrstolidactinagcycntev;
  integer8 p1_aotidkrstolidactinagcyflagev;
  integer8 p1_aotidkrstolidactinagcyolddtev;
  integer8 p1_aotidkrstolidactinagcynewdtev;
  integer8 p9_aotaddrkractinagcycntev;
  integer8 p9_aotaddrkractinagcyflagev;
  integer8 p9_aotaddrkractinagcyolddtev;
  integer8 p9_aotaddrkractinagcynewdtev;
  integer8 p15_aotssnkractinagcycntev;
  integer8 p15_aotssnkractinagcyflagev;
  integer8 p15_aotssnkractinagcyolddtev;
  integer8 p15_aotssnkractinagcynewdtev;
  integer8 p16_aotphnkractinagcycntev;
  integer8 p16_aotphnkractinagcyflagev;
  integer8 p16_aotphnkractinagcyolddtev;
  integer8 p16_aotphnkractinagcynewdtev;
  integer8 p17_aotemailkractinagcycntev;
  integer8 p17_aotemailkractinagcyflagev;
  integer8 p17_aotemailkractinagcyolddtev;
  integer8 p17_aotemailkractinagcynewdtev;
  integer8 p18_aotipaddrkractinagcycntev;
  integer8 p18_aotipaddrkractinagcyflagev;
  integer8 p18_aotipaddrkractinagcyolddtev;
  integer8 p18_aotipaddrkractinagcynewdtev;
  integer8 p19_aotbnkacctkractinagcycntev;
  integer8 p19_aotbnkacctkractinagcyflagev;
  integer8 p19_aotbnkacctkractinagcyolddtev;
  integer8 p19_aotbnkacctkractinagcynewdtev;
  integer8 p20_aotdlkractinagcycntev;
  integer8 p20_aotdlkractinagcyflagev;
  integer8 p20_aotdlkractinagcyolddtev;
  integer8 p20_aotdlkractinagcynewdtev;
  integer8 p1_aotidkractshrdcntev;
  integer8 p1_aotidkractshrdflagev;
  integer8 p1_aotidkractshrdolddtev;
  integer8 p1_aotidkractshrdnewdtev;
  integer8 p1_aotidkractshrdsrcagencycntev;
  string p1_aotidkractshrdnewsrcagencydescev;
  integer8 p1_aotidkrappfrdactshrdcntev;
  integer8 p1_aotidkrappfrdactshrdflagev;
  integer8 p1_aotidkrappfrdactshrdolddtev;
  integer8 p1_aotidkrappfrdactshrdnewdtev;
  integer8 p1_aotidkrappfrdactshrdsrcagencycntev;
  string p1_aotidkrappfrdactshrdnewsrcagencydescev;
  integer8 p1_aotidkrgenfrdactshrdcntev;
  integer8 p1_aotidkrgenfrdactshrdflagev;
  integer8 p1_aotidkrgenfrdactshrdolddtev;
  integer8 p1_aotidkrgenfrdactshrdnewdtev;
  integer8 p1_aotidkrgenfrdactshrdsrcagencycntev;
  string p1_aotidkrgenfrdactshrdnewsrcagencydescev;
  integer8 p1_aotidkrothfrdactshrdcntev;
  integer8 p1_aotidkrothfrdactshrdflagev;
  integer8 p1_aotidkrothfrdactshrdolddtev;
  integer8 p1_aotidkrothfrdactshrdnewdtev;
  integer8 p1_aotidkrothfrdactshrdsrcagencycntev;
  string p1_aotidkrothfrdactshrdnewsrcagencydescev;
  integer8 p1_aotidkrstolidactshrdcntev;
  integer8 p1_aotidkrstolidactshrdflagev;
  integer8 p1_aotidkrstolidactshrdolddtev;
  integer8 p1_aotidkrstolidactshrdnewdtev;
  integer8 p1_aotidkrstolidactshrdsrcagencycntev;
  string p1_aotidkrstolidactshrdnewsrcagencydescev;
  integer8 p9_aotaddrkractshrdcntev;
  integer8 p9_aotaddrkractshrdflagev;
  integer8 p9_aotaddrkractshrdolddtev;
  integer8 p9_aotaddrkractshrdnewdtev;
  integer8 p9_aotaddrkractshrdsrcagencycntev;
  string p9_aotaddrkractshrdnewsrcagencydescev;
  integer8 p15_aotssnkractshrdcntev;
  integer8 p15_aotssnkractshrdflagev;
  integer8 p15_aotssnkractshrdolddtev;
  integer8 p15_aotssnkractshrdnewdtev;
  integer8 p15_aotssnkractshrdsrcagencycntev;
  string p15_aotssnkractshrdnewsrcagencydescev;
  integer8 p16_aotphnkractshrdcntev;
  integer8 p16_aotphnkractshrdflagev;
  integer8 p16_aotphnkractshrdolddtev;
  integer8 p16_aotphnkractshrdnewdtev;
  integer8 p16_aotphnkractshrdsrcagencycntev;
  string p16_aotphnkractshrdnewsrcagencydescev;
  integer8 p17_aotemailkractshrdcntev;
  integer8 p17_aotemailkractshrdflagev;
  integer8 p17_aotemailkractshrdolddtev;
  integer8 p17_aotemailkractshrdnewdtev;
  integer8 p17_aotemailkractshrdsrcagencycntev;
  string p17_aotemailkractshrdnewsrcagencydescev;
  integer8 p18_aotipaddrkractshrdcntev;
  integer8 p18_aotipaddrkractshrdflagev;
  integer8 p18_aotipaddrkractshrdolddtev;
  integer8 p18_aotipaddrkractshrdnewdtev;
  integer8 p18_aotipaddrkractshrdsrcagencycntev;
  string p18_aotipaddrkractshrdnewsrcagencydescev;
  integer8 p19_aotbnkacctkractshrdcntev;
  integer8 p19_aotbnkacctkractshrdflagev;
  integer8 p19_aotbnkacctkractshrdolddtev;
  integer8 p19_aotbnkacctkractshrdnewdtev;
  integer8 p19_aotbnkacctkractshrdsrcagencycntev;
  string p19_aotbnkacctkractshrdnewsrcagencydescev;
  integer8 p20_aotdlkractshrdcntev;
  integer8 p20_aotdlkractshrdflagev;
  integer8 p20_aotdlkractshrdolddtev;
  integer8 p20_aotdlkractshrdnewdtev;
  integer8 p20_aotdlkractshrdsrcagencycntev;
  string p20_aotdlkractshrdnewsrcagencydescev;
  integer8 p1_aotidnaccollactcntev;
  integer8 p1_aotidnaccollflagev;
  integer8 p1_aotidnaccollnewdt;
  integer8 p1_aotidnaccollnewtype;
  integer8 p1_aotactcntev;
  integer8 p1_aotidactcntev;
  integer8 p1_aotidactcnt30d;
  integer8 p1_idactolddt;
  integer8 p1_aotaddactcntev;
  integer8 p1_aotaddactcnt30d;
  integer8 p1_aotnonstactcntev;
  integer8 p1_aotnonstactcnt30d;
  integer8 p1_aotidnewkraftidactcntev;
  integer8 p1_aotidnewkraftaddactcntev;
  integer8 p1_aotidnewkraftnonstactcntev;
  integer8 p9_aotactcntev;
  integer8 p9_aotidactcntev;
  integer8 p9_aotidactcnt30d;
  integer8 p9_idactolddt;
  integer8 p9_aotaddactcntev;
  integer8 p9_aotaddactcnt30d;
  integer8 p9_aotnonstactcntev;
  integer8 p9_aotnonstactcnt30d;
  integer8 p9_aotaddrnewkraftidactcntev;
  integer8 p9_aotaddrnewkraftaddactcntev;
  integer8 p9_aotaddrnewkraftnonstactcntev;
  integer8 p15_aotactcntev;
  integer8 p15_aotidactcntev;
  integer8 p15_aotidactcnt30d;
  integer8 p15_idactolddt;
  integer8 p15_aotaddactcntev;
  integer8 p15_aotaddactcnt30d;
  integer8 p15_aotnonstactcntev;
  integer8 p15_aotnonstactcnt30d;
  integer8 p15_aotssnnewkraftidactcntev;
  integer8 p15_aotssnnewkraftaddactcntev;
  integer8 p15_aotssnnewkraftnonstactcntev;
  integer8 p16_aotactcntev;
  integer8 p16_aotidactcntev;
  integer8 p16_aotidactcnt30d;
  integer8 p16_idactolddt;
  integer8 p16_aotaddactcntev;
  integer8 p16_aotaddactcnt30d;
  integer8 p16_aotnonstactcntev;
  integer8 p16_aotnonstactcnt30d;
  integer8 p16_aotphnnewkraftidactcntev;
  integer8 p16_aotphnnewkraftaddactcntev;
  integer8 p16_aotphnnewkraftnonstactcntev;
  integer8 p17_aotactcntev;
  integer8 p17_aotidactcntev;
  integer8 p17_aotidactcnt30d;
  integer8 p17_idactolddt;
  integer8 p17_aotaddactcntev;
  integer8 p17_aotaddactcnt30d;
  integer8 p17_aotnonstactcntev;
  integer8 p17_aotnonstactcnt30d;
  integer8 p17_aotemlnewkraftidactcntev;
  integer8 p17_aotemlnewkraftaddactcntev;
  integer8 p17_aotemlnewkraftnonstactcntev;
  integer8 p18_aotactcntev;
  integer8 p18_aotidactcntev;
  integer8 p18_aotidactcnt30d;
  integer8 p18_idactolddt;
  integer8 p18_aotaddactcntev;
  integer8 p18_aotaddactcnt30d;
  integer8 p18_aotnonstactcntev;
  integer8 p18_aotnonstactcnt30d;
  integer8 p18_aotipnewkraftidactcntev;
  integer8 p18_aotipnewkraftaddactcntev;
  integer8 p18_aotipnewkraftnonstactcntev;
  integer8 p19_aotactcntev;
  integer8 p19_aotidactcntev;
  integer8 p19_aotidactcnt30d;
  integer8 p19_idactolddt;
  integer8 p19_aotaddactcntev;
  integer8 p19_aotaddactcnt30d;
  integer8 p19_aotnonstactcntev;
  integer8 p19_aotnonstactcnt30d;
  integer8 p19_aotbkacnewkraftidactcntev;
  integer8 p19_aotbkacnewkraftaddactcntev;
  integer8 p19_aotbkacnewkraftnonstactcntev;
  integer8 p20_aotactcntev;
  integer8 p20_aotidactcntev;
  integer8 p20_aotidactcnt30d;
  integer8 p20_idactolddt;
  integer8 p20_aotaddactcntev;
  integer8 p20_aotaddactcnt30d;
  integer8 p20_aotnonstactcntev;
  integer8 p20_aotnonstactcnt30d;
  integer8 p20_aotdlnewkraftidactcntev;
  integer8 p20_aotdlnewkraftaddactcntev;
  integer8 p20_aotdlnewkraftnonstactcntev;
  integer8 p9_aotidcurrprofusngaddrcntev;
  integer8 p15_aotidcurrprofusngssncntev;
  integer8 p16_aotidcurrprofusngphncntev;
  integer8 p17_aotidcurrprofusngemlcntev;
  integer8 p18_aotidcurrprofusngipcntev;
  integer8 p19_aotidcurrprofusngbkaccntev;
  integer8 p20_aotidcurrprofusngdlcntev;
  integer8 p9_aotidhistprofusngaddrcntev;
  integer8 p15_aotidhistprofusngssncntev;
  integer8 p16_aotidhistprofusngphncntev;
  integer8 p17_aotidhistprofusngemlcntev;
  integer8 p18_aotidhistprofusngipcntev;
  integer8 p19_aotidhistprofusngbkaccntev;
  integer8 p20_aotidhistprofusngdlcntev;
  integer8 p9_aotidusngaddrcntev;
  integer8 p15_aotidusngssncntev;
  integer8 p16_aotidusngphncntev;
  integer8 p17_aotidusngemailcntev;
  integer8 p18_aotidusngipaddrcntev;
  integer8 p19_aotidusngbnkacctcntev;
  integer8 p20_aotidusngdlcntev;
  integer8 p1_idriskunscrbleflag;
  integer8 p9_addrriskunscrbleflag;
  integer8 p15_ssnriskunscrbleflag;
  integer8 p16_phnriskunscrbleflag;
  integer8 p17_emailriskunscrbleflag;
  integer8 p18_ipaddrriskunscrbleflag;
  integer8 p19_bnkacctriskunscrbleflag;
  integer8 p20_dlriskunscrbleflag;
  integer8 p15_aothiidcurrprofusngssncntev;
  integer8 p16_aothiidcurrprofusngphncntev;
  integer8 p17_aothiidcurrprofusngemlcntev;
  integer8 p18_aothiidcurrprofusngipcntev;
  integer8 p19_aothiidcurrprofusngbkaccntev;
  integer8 p20_aothiidcurrprofusngdlcntev;
  integer8 p9_aothiidcurrprofusngaddrcntev;
  
  string p1_idriskrulenmlist;
  string p1_idriskruledesclist;
  string p1_idriskruleflaglist;
  string p1_idriskrulelvllist;

  string p9_addrriskrulenmlist;
  string p9_addrriskruledesclist;
  string p9_addrriskruleflaglist;
  string p9_addrriskrulelvllist;

  string p15_ssnriskrulenmlist;
  string p15_ssnriskruledesclist;
  string p15_ssnriskruleflaglist;
  string p15_ssnriskrulelvllist;

  string p16_phnriskrulenmlist;
  string p16_phnriskruledesclist;
  string p16_phnriskruleflaglist;
  string p16_phnriskrulelvllist;

  string p17_emailriskrulenmlist;
  string p17_emailriskruledesclist;
  string p17_emailriskruleflaglist;
  string p17_emailriskrulelvllist;

  string p18_ipriskrulenmlist;
  string p18_ipriskruledesclist;
  string p18_ipriskruleflaglist;
  string p18_ipriskrulelvllist;

  string p19_bnkriskrulenmlist;
  string p19_bnkriskruledesclist;
  string p19_bnkriskruleflaglist;
  string p19_bnkriskrulelvllist;

  string p20_dlriskrulenmlist;
  string p20_dlriskruledesclist;
  string p20_dlriskruleflaglist;
  string p20_dlriskrulelvllist;

  integer1 p1_idriskindx;
  integer1 p15_ssnriskindx;
  integer1 p16_phnriskindx;
  integer1 p17_emailriskindx;
  integer1 p19_bnkacctriskindx;
  integer1 p20_dlriskindx;
  integer1 p18_ipaddrriskindx;
  integer1 p9_addrriskindx;
END;

ModelingValidation := PROJECT(ModelingWithScoringDebug, TRANSFORM(ModelingValidationLayout, SELF := LEFT));
output(ModelingValidation,,'~fraudgov::deleteme_nd_small_' + Std.Date.CurrentDate(), overwrite);	
output(ModelingValidation,,'~fraudgov::RIN2_ScoringOutput_small_' + Std.Date.CurrentDate() + '_csv', CSV(QUOTE('"')), overwrite);

/*
output(ModelingValidation,,'~fraudgov::deleteme_nd_TN_profiles_full_' + Std.Date.CurrentDate(), overwrite);	
output(ModelingValidation,,'~fraudgov::RIN2_ScoringOutput_TN_profiles_full_' + Std.Date.CurrentDate() + '_csv', CSV(QUOTE('"')), overwrite);
*/