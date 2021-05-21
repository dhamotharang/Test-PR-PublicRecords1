//HPCC Systems KEL Compiler Version 1.6.0
#OPTION('expandSelectCreateRow',true);
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_Address,E_Geo_Link,E_Person,E_Person_Address,E_Person_S_S_N,E_Social_Security_Number,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_Shared;
IMPORT * FROM KEL16.Null;
 
RunAll := TRUE;
RunFast := FALSE;
RunSanityCheckSummary := FALSE;
RunInvalidSingleValues := FALSE;
RunUidSourceCounts := FALSE;
RunNullCounts := FALSE;
TopNUids := 10;
 
//Person sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Person().SanityCheck,NAMED('E_Person_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Person().Lex_I_D_Segment__SingleValue_Invalid,NAMED('E_Person_Lex_I_D_Segment__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Person().Lex_I_D_Segment2__SingleValue_Invalid,NAMED('E_Person_Lex_I_D_Segment2__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Person().UIDSourceCounts,NAMED('E_Person_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Person().TopSourcedUIDs(TopNUids),NAMED('E_Person_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Person().UIDSourceDistribution,NAMED('E_Person_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Person().NullCounts,NAMED('E_Person_NullCounts')));
 
//SocialSecurityNumber sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Social_Security_Number().SanityCheck,NAMED('E_Social_Security_Number_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Social_Security_Number().S_S_N__SingleValue_Invalid,NAMED('E_Social_Security_Number_S_S_N__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Social_Security_Number().Official_First_Seen__SingleValue_Invalid,NAMED('E_Social_Security_Number_Official_First_Seen__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Social_Security_Number().Official_Last_Seen__SingleValue_Invalid,NAMED('E_Social_Security_Number_Official_Last_Seen__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Social_Security_Number().Issue_State__SingleValue_Invalid,NAMED('E_Social_Security_Number_Issue_State__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Social_Security_Number().Header_First_Seen__SingleValue_Invalid,NAMED('E_Social_Security_Number_Header_First_Seen__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Social_Security_Number().UIDSourceCounts,NAMED('E_Social_Security_Number_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Social_Security_Number().TopSourcedUIDs(TopNUids),NAMED('E_Social_Security_Number_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Social_Security_Number().UIDSourceDistribution,NAMED('E_Social_Security_Number_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Social_Security_Number().NullCounts,NAMED('E_Social_Security_Number_NullCounts')));
 
//Address sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Address().SanityCheck,NAMED('E_Address_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Address().Primary_Range__SingleValue_Invalid,NAMED('E_Address_Primary_Range__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Address().Predirectional__SingleValue_Invalid,NAMED('E_Address_Predirectional__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Address().Primary_Name__SingleValue_Invalid,NAMED('E_Address_Primary_Name__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Address().Suffix__SingleValue_Invalid,NAMED('E_Address_Suffix__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Address().Postdirectional__SingleValue_Invalid,NAMED('E_Address_Postdirectional__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Address().Z_I_P5__SingleValue_Invalid,NAMED('E_Address_Z_I_P5__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Address().Secondary_Range__SingleValue_Invalid,NAMED('E_Address_Secondary_Range__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Address().UIDSourceCounts,NAMED('E_Address_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Address().TopSourcedUIDs(TopNUids),NAMED('E_Address_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Address().UIDSourceDistribution,NAMED('E_Address_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Address().NullCounts,NAMED('E_Address_NullCounts')));
 
//ZipCode sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Zip_Code().SanityCheck,NAMED('E_Zip_Code_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Zip_Code().Zip_Class__SingleValue_Invalid,NAMED('E_Zip_Code_Zip_Class__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Zip_Code().City__SingleValue_Invalid,NAMED('E_Zip_Code_City__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Zip_Code().State__SingleValue_Invalid,NAMED('E_Zip_Code_State__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Zip_Code().County__SingleValue_Invalid,NAMED('E_Zip_Code_County__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Zip_Code().City_Name__SingleValue_Invalid,NAMED('E_Zip_Code_City_Name__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Zip_Code().UIDSourceCounts,NAMED('E_Zip_Code_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Zip_Code().TopSourcedUIDs(TopNUids),NAMED('E_Zip_Code_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Zip_Code().UIDSourceDistribution,NAMED('E_Zip_Code_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Zip_Code().NullCounts,NAMED('E_Zip_Code_NullCounts')));
 
//GeoLink sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Geo_Link().SanityCheck,NAMED('E_Geo_Link_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Geo_Link().Geo_Link__SingleValue_Invalid,NAMED('E_Geo_Link_Geo_Link__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Geo_Link().UIDSourceCounts,NAMED('E_Geo_Link_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Geo_Link().TopSourcedUIDs(TopNUids),NAMED('E_Geo_Link_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Geo_Link().UIDSourceDistribution,NAMED('E_Geo_Link_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Geo_Link().NullCounts,NAMED('E_Geo_Link_NullCounts')));
 
//PersonAddress sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Person_Address().SanityCheck,NAMED('E_Person_Address_SanityCheck')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Person_Address().NullCounts,NAMED('E_Person_Address_NullCounts')));
 
//PersonSSN sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Person_S_S_N().SanityCheck,NAMED('E_Person_S_S_N_SanityCheck')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Person_S_S_N().NullCounts,NAMED('E_Person_S_S_N_NullCounts')));
