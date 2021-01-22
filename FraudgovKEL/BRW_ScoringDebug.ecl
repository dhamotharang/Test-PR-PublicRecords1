import FraudgovKEL;
//import FraudGovPlatform_Analytics;
//IMPORT KEL12 AS KEL;
IMPORT Std;

#option('multiplePersistInstances', false);
#option('defaultSkewError', 1);
//#option('freezepersists', true);
#option('resourceMaxHeavy', 2);
//#option('freezepersists', true);
#OPTION('expandSelectCreateRow', TRUE);

EntityAssessment := FraudgovKEL.KEL_EventPivot.EntityAssessment;
MyRules := FraudgovKEL.KEL_EventPivot.MyRules(rulename != 'rulename');
RulesFlagsMatched := FraudgovKEL.KEL_EventPivot.RulesFlagsMatched;

ModelingOutput := EntityAssessment;//(industrytype = 1029 and customerid = 20995239);

RulesList := TABLE(MyRules, {customerid, industrytype, entitytype, rulename, description}, customerid, industrytype, entitytype, rulename, description, MERGE);

RulesFlagsMatchedPlusPrep := JOIN(ModelingOutput, RulesList, (LEFT.customerid=RIGHT.customerid AND LEFT.industrytype=RIGHT.industrytype) OR (RIGHT.customerid = 0),
                             TRANSFORM({LEFT.customerid, LEFT.industrytype, LEFT.entitycontextuid, RIGHT.entitytype, RIGHT.rulename, RIGHT.description}, SELF := LEFT, SELF := RIGHT), ALL);
                             
RulesFlagsMatchedPlus := JOIN(RulesFlagsMatchedPlusPrep, RulesFlagsMatched, 
                           LEFT.customerid=RIGHT.customerid AND LEFT.industrytype=RIGHT.industrytype AND LEFT.entitycontextuid=RIGHT.entitycontextuid AND 
                           LEFT.entitytype=RIGHT.entitytype AND LEFT.rulename=RIGHT.rulename,
                           TRANSFORM({RECORDOF(LEFT), RIGHT.RiskLevel}, SELF := LEFT, SELF := RIGHT), LEFT OUTER, HASH);
                           
FinalRec := RECORD
  RECORDOF(RulesFlagsMatchedPlus);
  STRING P1_IDRiskRuleNmList := '';
  STRING P1_IDRiskRuleDescList := '';
  STRING P1_IDRiskRuleFlagList := '';
  STRING P1_IDRiskRuleLvlList := '';
END;

RulesFlagsFinal1 := PROJECT(RulesFlagsMatchedPlus,TRANSFORM(FinalRec, SELF := LEFT, SELF := [])); //create dataset to work with
RulesFlagsFinal1Sorted := SORT(RulesFlagsFinal1, customerid, industrytype, entitycontextuid, rulename); //sort it first

FinalRec tFinal(FinalRec L,FinalRec R) := TRANSFORM
  SELF.P1_IDRiskRuleNmList :=MAP(L.P1_IDRiskRuleNmList = '' => TRIM(L.rulename) + '|' + TRIM(R.rulename), TRIM(L.P1_IDRiskRuleNmList) + '|' + (R.rulename));
  SELF.P1_IDRiskRuleDescList := MAP(L.P1_IDRiskRuleDescList = '' => TRIM(L.description) + '|' + TRIM(R.description), TRIM(L.P1_IDRiskRuleDescList) + '|' + (R.description));
  SELF.P1_IDRiskRuleFlagList := MAP(L.P1_IDRiskRuleFlagList = '' => MAP(L.RiskLevel=0 => '0','1') + '|' + MAP(R.RiskLevel=0 => '0','1'), TRIM(L.P1_IDRiskRuleFlagList) + '|' + MAP(R.RiskLevel=0 => '0','1'));
  SELF.P1_IDRiskRuleLvlList := MAP(L.P1_IDRiskRuleLvlList = '' => (STRING)L.RiskLevel + '|' + R.RiskLevel, TRIM(L.P1_IDRiskRuleLvlList) + '|' + R.RiskLevel);
  SELF := L; //keeping the L rec makes it KEEP(1),LEFT
// SELF := R; //keeping the R rec would make it KEEP(1),RIGHT
END;
RulesFlagFinal1 := ROLLUP(RulesFlagsFinal1Sorted,
                  LEFT.customerid=RIGHT.customerid AND LEFT.industrytype=RIGHT.industrytype AND LEFT.entitycontextuid=RIGHT.entitycontextuid,
                  tFinal(LEFT,RIGHT));
                  
RulesFlagFinal1;

RulesFlagFinal := JOIN(RulesFlagFinal1, ModelingOutput, LEFT.customerid=RIGHT.customerid AND LEFT.industrytype=RIGHT.industrytype AND LEFT.entitycontextuid=RIGHT.entitycontextuid,
       TRANSFORM({LEFT.customerid, LEFT.industrytype, STRING t_actuid, LEFT.p1_idriskrulenmlist, LEFT.p1_idriskruledesclist, LEFT.p1_idriskruleflaglist, 
                  LEFT.p1_idriskrulelvllist, RIGHT.p1_idriskindx, RIGHT.p15_ssnriskindx, RIGHT.p16_phnriskindx, RIGHT.p17_emailriskindx, 
                  RIGHT.p19_bnkacctriskindx, RIGHT.p20_dlriskindx, RIGHT.p18_ipaddrriskindx, RIGHT.p9_addrriskindx}, SELF.t_actuid := LEFT.entitycontextuid[4..], SELF := LEFT, SELF := RIGHT), HASH);

//output(RulesFlagFinal,, '~fraudgov::temp::scoringoutput', CSV(SEPARATOR(','), QUOTE('"')), overwrite);             

HighRiskCountsPrep := TABLE(FraudgovKEL.KEL_EventPivot.PivotToEntitiesWithHRICounts, 
                    {customerid, industrytype, t_actuid, entitycontextuid,  
                     INTEGER p15_aothiidcurrprofusngcntev := MAP(entitytype = 15 => aothiidcurrprofusngcntev, -99999),
                     INTEGER p16_aothiidcurrprofusngcntev := MAP(entitytype = 16 => aothiidcurrprofusngcntev, -99999),
                     INTEGER p18_aothiidcurrprofusngcntev := MAP(entitytype = 18 => aothiidcurrprofusngcntev, -99999),
                     INTEGER p17_aothiidcurrprofusngcntev := MAP(entitytype = 17 => aothiidcurrprofusngcntev, -99999),
                     INTEGER p19_aothiidcurrprofusngcntev := MAP(entitytype = 19 => aothiidcurrprofusngcntev, -99999),
                     INTEGER p20_aothiidcurrprofusngcntev := MAP(entitytype = 20 => aothiidcurrprofusngcntev, -99999),
                     INTEGER p9_aothiidcurrprofusngcntev := MAP(entitytype = 9 => aothiidcurrprofusngcntev, -99999)}, 
                     customerid, industrytype, t_actuid, entitycontextuid, MERGE);
										 
HighRiskCounts := TABLE(HighRiskCountsPrep, 
                    {customerid, industrytype, t_actuid,
                     INTEGER p15_aothiidcurrprofusngcntev := MAX(GROUP, p15_aothiidcurrprofusngcntev),
                     INTEGER p16_aothiidcurrprofusngcntev := MAX(GROUP, p16_aothiidcurrprofusngcntev),
                     INTEGER p17_aothiidcurrprofusngcntev := MAX(GROUP, p17_aothiidcurrprofusngcntev),
                     INTEGER p18_aothiidcurrprofusngcntev := MAX(GROUP, p18_aothiidcurrprofusngcntev),
                     INTEGER p19_aothiidcurrprofusngcntev := MAX(GROUP, p19_aothiidcurrprofusngcntev),
                     INTEGER p20_aothiidcurrprofusngcntev := MAX(GROUP, p20_aothiidcurrprofusngcntev),
                     INTEGER p9_aothiidcurrprofusngcntev := MAX(GROUP, p9_aothiidcurrprofusngcntev),
                     }, 
                     customerid, industrytype, t_actuid, MERGE);        

// JOIN High Risk Counts to Modeling Output
//ModelingAttributeOutput := FraudgovKEL.KEL_EventShell.ModelingStats;

ModelingAttributeOutput := JOIN(FraudgovKEL.KEL_EventShell.ModelingStats, FraudgovKEL.KEL_ModelingValidationSample,
                       LEFT.personentitycontextuid=RIGHT.personentitycontextuid, 
                       TRANSFORM(RECORDOF(LEFT), SELF := LEFT), LOOKUP, HASH);

ModelingWithHRICounts := JOIN(ModelingAttributeOutput, HighRiskCounts, LEFT.agencyuid = RIGHT.customerid AND LEFT.agencyprogtype=RIGHT.industrytype AND LEFT.t_actuid=RIGHT.t_actuid, HASH);
                    
// JOIN Scoring Debug to Modeling Output

ModelingWithScoringDebug := PROJECT(JOIN(ModelingWithHRICounts, RulesFlagFinal, LEFT.agencyuid = RIGHT.customerid AND LEFT.agencyprogtype=RIGHT.industrytype AND (UNSIGNED8)LEFT.t_actuid=(UNSIGNED8)RIGHT.t_actuid, HASH), 
                              TRANSFORM({RECORDOF(LEFT) AND NOT [customerid, industrytype]}, SELF := LEFT));

output(ModelingWithScoringDebug,,'~fraudgov::deleteme_nd_small_' + Std.Date.CurrentDate(), overwrite);	
output(ModelingWithScoringDebug,,'~fraudgov::RIN2_ScoringOutput_small_' + Std.Date.CurrentDate() + '_csv', CSV(QUOTE('"')), overwrite);