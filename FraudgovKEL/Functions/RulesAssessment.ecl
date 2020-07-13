import FraudgovKEL;
import FraudGovPlatform_Analytics;
IMPORT KEL12 AS KEL;
IMPORT HIPIE_ECL;


EXPORT RulesAssessment( := MODULE
/*
rulesoutrec := RECORD
   RECORDOF(UIStats);
	 STRING RuleName;
	 INTEGER1 RuleFlag;
END;
*/

MyRules := DATASET([
  {0, 0, 1, 'Rule1', 'Address City is Miami and is out of state and IP Address is hosted.', 't18_ipaddrlocmiamiflag', '1', 0, 0, 3},
  {0, 0, 1, 'Rule1', 'Address City is Miami and is out of state and IP Address is hosted.', 't18_ipaddrlocnonusflag', '1', 0, 0, 3},
	{0, 0, 1, 'Rule2', 'Identity deceased prior to transaction.', 'deceased_prior_to_event_', '1', 0, 0, 3},
  {0, 0, 1, 'Rule3', 'Address is out of state and IP Address is NOT in the US.', 'address_out_of_state_', '1', 0, 0, 3},
  {0, 0, 1, 'Rule3', 'Address is out of state and IP Address is NOT in the US.', 't18_ipaddrlocnonusflag', '1', 0, 0, 3},
	{0, 0, 1, 'Rule1-1', 'Identity Deceased prior to Transaction', 'deceased_prior_to_event_', '1', 0, 0, 3},
	{0, 0, 1, 'Rule1-2', 'Identity is currently incarcerated', 'currently_incarcerated_flag_', '1', 0, 0, 3},
  {8342784, 1014, 1, 'Rule3', 'Address is out of state and IP Address NOT is in the US.', 'address_out_of_state_', '1', 0, 0, 1},
  {8342784, 1014, 1, 'Rule3', 'Address is out of state and IP Address NOT is in the US.', 't18_ipaddrlocnonusflag', '1', 0, 0, 1},
  {0, 0, 18, 'Rule4', 'Address is a PO Box and IP Address is NOT in the US.', 't18_ipaddrlocnonusflag', '1', 0, 0, 3},
  {0, 0, 18, 'Rule4', 'Address is a PO Box and IP Address is NOT in the US.', 'address_is_po_box_', '1', 0, 0, 3},
  {0, 0, 9, 'Rule5', 'Address is vacant.', 'address_is_vacant_', '1', 0, 0, 1},
  {0, 0, 9, 'Rule6', 'Address is Commercial Receiving Agency', 'address_is_cmra_', '1', 0, 0, 1},
  {0, 0, 9, 'Rule7', 'Address is out of state.', 'address_out_of_state_', '1', 0, 0, 3},
  {20995369, 1014, 9, 'Rule5', 'Address is vacant.', 'address_is_vacant_', '1', 0, 0, 3}
  ],
  {UNSIGNED Customer_id, UNSIGNED industry_type, INTEGER1 entitytype, STRING RuleName, STRING Description, STRING200 Field, STRING Value, DECIMAL6_2 Low, DECIMAL6_2 High, INTEGER RiskLevel});

// This is just to make sure there aren't duplicates. Should be moved into the build code for the index to check everything and validate.
MyRulesCnt := TABLE(MyRules, {RuleName, customer_id, industry_type, entitytype, Reccount := COUNT(GROUP)}, RuleName, customer_id, entitytype, industry_type, FEW);
//output(MyRulesCnt, named('MyRulesCnt'));


RulesResult := JOIN(EventStatsFieldPivot(Value != ''), SORT(MyRules, field, -customer_id), 
                         LEFT.Field=RIGHT.Field AND ((LEFT.customerid=RIGHT.customer_id AND LEFT.industrytype = RIGHT.industry_type) OR RIGHT.customer_id = 0) AND 
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
                            SELF.field := LEFT.field;
														SELF.RuleName := RIGHT.RuleName;
														SELF.EntityType := RIGHT.EntityType;
														SELF.Description := RIGHT.Description;
														SELF.Default := (INTEGER1)(RIGHT.customer_id = 0);
                            SELF := LEFT), MANY LOOKUP, LEFT OUTER)(RiskLevel>0);// : PERSIST('~fraudgov::tempdeleteme41');
														
//output(RulesResult(entitycontextuid = '_1194033204'), all, named('RulesResult'));

RulesResultAggPrep := TABLE(RulesResult, {customerid, industrytype, entitycontextuid, entitytype, rulename, Default, Description, risklevel, reccount := COUNT(GROUP)}, 
                       customerid, industrytype, entitycontextuid, entitytype, rulename, Default, Description, risklevel, MERGE);

RulesResultAgg := DEDUP(SORT(DISTRIBUTE(RulesResultAggPrep, HASH64(customerid, industrytype, entitycontextuid)), 
                       customerid, industrytype, entitycontextuid, entitytype, rulename, default, local), 
                       customerid, industrytype, entitycontextuid, entitytype, rulename, local); 
										 
//output(RulesResultAgg(entitycontextuid = '_1194033204'), named('RulesResultAgg'));

// Add how many flags for each rule matched
EXPORT RulesFlagsMatched  := JOIN(RulesResultAgg, MyRulesCnt, 
                        ((LEFT.customerid=RIGHT.customer_id AND LEFT.industrytype = RIGHT.industry_type AND LEFT.RuleName = RIGHT.RuleName) OR
												  (RIGHT.customer_id = 0 AND RIGHT.industry_type = 0 AND LEFT.RuleName = RIGHT.RuleName)) AND LEFT.reccount = RIGHT.reccount, 
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


EntityAssessment := TABLE(EntityAssessmentPrep, {
											 industrytype, customerid, entitycontextuid, 
											 INTEGER1 P1_IDRiskIndx := MAX(GROUP, P1_IDRiskIndx),
											 INTEGER1 P15_SSNRiskIndx:= MAX(GROUP, P15_SSNRiskIndx),
											 INTEGER1 P16_PhnRiskIndx:= MAX(GROUP, P16_PhnRiskIndx),
											 INTEGER1 P17_EmailRiskIndx:= MAX(GROUP, P17_EmailRiskIndx),
											 INTEGER1 P19_BnkAcctRiskIndx:= MAX(GROUP, P19_BnkAcctRiskIndx),
											 INTEGER1 P20_DLRiskIndx:= MAX(GROUP, P20_DLRiskIndx),
											 INTEGER1 P18_IPAddrRiskIndx:= MAX(GROUP, P18_IPAddrRiskIndx),
											 INTEGER1 P9_AddrRiskIndx:= MAX(GROUP, P9_AddrRiskIndx)}, industrytype, customerid, entitycontextuid, MERGE);
											
//output(EntityAssessment(entitycontextuid = '_1194033204'), named('EntityAssessment'));

// return Entity Assessment to be joined outside this function.


END;