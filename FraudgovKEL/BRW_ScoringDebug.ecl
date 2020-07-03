import FraudgovKEL;
//import FraudGovPlatform_Analytics;
//IMPORT KEL12 AS KEL;
IMPORT Std;

#option('multiplePersistInstances', false);
#option('defaultSkewError', 1);
//#option('freezepersists', true);

EntityAssessment := FraudgovKEL.KEL_EventPivot.EntityAssessment;
MyRules := FraudgovKEL.KEL_EventPivot.MyRules;
RulesFlagsMatched := FraudgovKEL.KEL_EventPivot.RulesFlagsMatched;

ModelingOutput := EntityAssessment(industrytype = 1029 and customerid = 20995239);

RulesList := TABLE(MyRules, {customerid, industrytype, entitytype, rulename, description}, customerid, industrytype, entitytype, rulename, description, MERGE);

RulesFlagsMatchedPlusPrep := JOIN(ModelingOutput, RulesList, (LEFT.customerid=RIGHT.customerid AND LEFT.industrytype=RIGHT.industrytype) OR (RIGHT.customerid = 0),
                             TRANSFORM({LEFT.customerid, LEFT.industrytype, LEFT.entitycontextuid, RIGHT.entitytype, RIGHT.rulename, RIGHT.description}, SELF := LEFT, SELF := RIGHT), LOOKUP, ALL);
                             
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

output(RulesFlagFinal,, '~fraudgov::temp::scoringoutput', CSV(SEPARATOR(','), QUOTE('"')), overwrite);             

