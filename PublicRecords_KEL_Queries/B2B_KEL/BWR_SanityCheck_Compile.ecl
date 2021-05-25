//HPCC Systems KEL Compiler Version 1.6.0
#OPTION('expandSelectCreateRow',true);
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Sele_Tradeline,E_Tradeline FROM PublicRecords_KEL_Queries.B2B_KEL;
IMPORT * FROM KEL16.Null;
 
RunAll := TRUE;
RunFast := FALSE;
RunSanityCheckSummary := FALSE;
RunInvalidSingleValues := FALSE;
RunUidSourceCounts := FALSE;
RunNullCounts := FALSE;
TopNUids := 10;
 
//BusinessUlt sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Business_Ult().SanityCheck,NAMED('E_Business_Ult_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Ult().Ult_Segment__SingleValue_Invalid,NAMED('E_Business_Ult_Ult_Segment__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Business_Ult().UIDSourceCounts,NAMED('E_Business_Ult_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Business_Ult().TopSourcedUIDs(TopNUids),NAMED('E_Business_Ult_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Business_Ult().UIDSourceDistribution,NAMED('E_Business_Ult_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Business_Ult().NullCounts,NAMED('E_Business_Ult_NullCounts')));
 
//BusinessOrg sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Business_Org().SanityCheck,NAMED('E_Business_Org_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Org().Ult_I_D__SingleValue_Invalid,NAMED('E_Business_Org_Ult_I_D__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Org().Org_I_D__SingleValue_Invalid,NAMED('E_Business_Org_Org_I_D__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Org().Org_Ult__SingleValue_Invalid,NAMED('E_Business_Org_Org_Ult__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Org().Nodes_Total__SingleValue_Invalid,NAMED('E_Business_Org_Nodes_Total__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Org().Source_Group_I_D__SingleValue_Invalid,NAMED('E_Business_Org_Source_Group_I_D__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Org().Org_Segment__SingleValue_Invalid,NAMED('E_Business_Org_Org_Segment__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Business_Org().UIDSourceCounts,NAMED('E_Business_Org_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Business_Org().TopSourcedUIDs(TopNUids),NAMED('E_Business_Org_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Business_Org().UIDSourceDistribution,NAMED('E_Business_Org_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Business_Org().NullCounts,NAMED('E_Business_Org_NullCounts')));
 
//BusinessSele sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Business_Sele().SanityCheck,NAMED('E_Business_Sele_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Sele().Ult_I_D__SingleValue_Invalid,NAMED('E_Business_Sele_Ult_I_D__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Sele().Org_I_D__SingleValue_Invalid,NAMED('E_Business_Sele_Org_I_D__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Sele().Sele_I_D__SingleValue_Invalid,NAMED('E_Business_Sele_Sele_I_D__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Sele().Sele_Org__SingleValue_Invalid,NAMED('E_Business_Sele_Sele_Org__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Sele().Sele_Overflow__SingleValue_Invalid,NAMED('E_Business_Sele_Sele_Overflow__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Sele().Sele_Gold__SingleValue_Invalid,NAMED('E_Business_Sele_Sele_Gold__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Sele().Is_Sele_Level__SingleValue_Invalid,NAMED('E_Business_Sele_Is_Sele_Level__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Sele().Is_Org_Level__SingleValue_Invalid,NAMED('E_Business_Sele_Is_Org_Level__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Sele().Is_Ult_Level__SingleValue_Invalid,NAMED('E_Business_Sele_Is_Ult_Level__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Sele().Sele_Segment__SingleValue_Invalid,NAMED('E_Business_Sele_Sele_Segment__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Sele().Is_Corporation__SingleValue_Invalid,NAMED('E_Business_Sele_Is_Corporation__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Sele().B_B_B_Member_Since__SingleValue_Invalid,NAMED('E_Business_Sele_B_B_B_Member_Since__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Sele().For_Profit_Indicator__SingleValue_Invalid,NAMED('E_Business_Sele_For_Profit_Indicator__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Sele().Public_Or_Private_Indicator__SingleValue_Invalid,NAMED('E_Business_Sele_Public_Or_Private_Indicator__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Business_Sele().UIDSourceCounts,NAMED('E_Business_Sele_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Business_Sele().TopSourcedUIDs(TopNUids),NAMED('E_Business_Sele_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Business_Sele().UIDSourceDistribution,NAMED('E_Business_Sele_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Business_Sele().NullCounts,NAMED('E_Business_Sele_NullCounts')));
 
//BusinessSeleOverflow sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Business_Sele_Overflow().SanityCheck,NAMED('E_Business_Sele_Overflow_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Sele_Overflow().Ult_I_D__SingleValue_Invalid,NAMED('E_Business_Sele_Overflow_Ult_I_D__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Sele_Overflow().Org_I_D__SingleValue_Invalid,NAMED('E_Business_Sele_Overflow_Org_I_D__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Business_Sele_Overflow().Sele_I_D__SingleValue_Invalid,NAMED('E_Business_Sele_Overflow_Sele_I_D__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Business_Sele_Overflow().UIDSourceCounts,NAMED('E_Business_Sele_Overflow_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Business_Sele_Overflow().TopSourcedUIDs(TopNUids),NAMED('E_Business_Sele_Overflow_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Business_Sele_Overflow().UIDSourceDistribution,NAMED('E_Business_Sele_Overflow_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Business_Sele_Overflow().NullCounts,NAMED('E_Business_Sele_Overflow_NullCounts')));
 
//Tradeline sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Tradeline().SanityCheck,NAMED('E_Tradeline_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline().Ult_I_D__SingleValue_Invalid,NAMED('E_Tradeline_Ult_I_D__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline().Org_I_D__SingleValue_Invalid,NAMED('E_Tradeline_Org_I_D__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline().Sele_I_D__SingleValue_Invalid,NAMED('E_Tradeline_Sele_I_D__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Tradeline().Account_Key__SingleValue_Invalid,NAMED('E_Tradeline_Account_Key__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Tradeline().UIDSourceCounts,NAMED('E_Tradeline_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Tradeline().TopSourcedUIDs(TopNUids),NAMED('E_Tradeline_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Tradeline().UIDSourceDistribution,NAMED('E_Tradeline_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Tradeline().NullCounts,NAMED('E_Tradeline_NullCounts')));
 
//SeleTradeline sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Sele_Tradeline().SanityCheck,NAMED('E_Sele_Tradeline_SanityCheck')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Sele_Tradeline().NullCounts,NAMED('E_Sele_Tradeline_NullCounts')));
