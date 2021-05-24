//HPCC Systems KEL Compiler Version 1.6.0
#OPTION('expandSelectCreateRow',true);
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_Address,E_Address_Inquiry,E_Address_Slim,E_Address_Summary,E_Email,E_Email_Inquiry,E_Geo_Link,E_Input_P_I_I,E_Inquiry,E_Name_Summary,E_Person,E_Phone,E_Phone_Inquiry,E_Phone_Summary,E_Property,E_S_S_N_Inquiry,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_Consumer;
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
 
//Phone sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Phone().SanityCheck,NAMED('E_Phone_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Phone10__SingleValue_Invalid,NAMED('E_Phone_Phone10__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Portability_Indicator__SingleValue_Invalid,NAMED('E_Phone_Portability_Indicator__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Current_Flag__SingleValue_Invalid,NAMED('E_Phone_Current_Flag__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Business_Flag__SingleValue_Invalid,NAMED('E_Phone_Business_Flag__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().N_X_X_Type__SingleValue_Invalid,NAMED('E_Phone_N_X_X_Type__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Publish_Code__SingleValue_Invalid,NAMED('E_Phone_Publish_Code__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().C_O_C_Type__SingleValue_Invalid,NAMED('E_Phone_C_O_C_Type__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().S_C_C__SingleValue_Invalid,NAMED('E_Phone_S_C_C__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Phone_Number_Company_Type__SingleValue_Invalid,NAMED('E_Phone_Phone_Number_Company_Type__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Ported_Match__SingleValue_Invalid,NAMED('E_Phone_Ported_Match__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Phone_Use__SingleValue_Invalid,NAMED('E_Phone_Phone_Use__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().No_Solicit_Code__SingleValue_Invalid,NAMED('E_Phone_No_Solicit_Code__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Omit_Indicator__SingleValue_Invalid,NAMED('E_Phone_Omit_Indicator__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Source_File__SingleValue_Invalid,NAMED('E_Phone_Source_File__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Iver_Indicator__SingleValue_Invalid,NAMED('E_Phone_Iver_Indicator__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Validation_Flag__SingleValue_Invalid,NAMED('E_Phone_Validation_Flag__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Validation_Date__SingleValue_Invalid,NAMED('E_Phone_Validation_Date__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Carrier_Name__SingleValue_Invalid,NAMED('E_Phone_Carrier_Name__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Record_S_I_D__SingleValue_Invalid,NAMED('E_Phone_Record_S_I_D__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Household_Flag__SingleValue_Invalid,NAMED('E_Phone_Household_Flag__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Cell_Phone__SingleValue_Invalid,NAMED('E_Phone_Cell_Phone__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().N_P_A__SingleValue_Invalid,NAMED('E_Phone_N_P_A__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Phone7__SingleValue_Invalid,NAMED('E_Phone_Phone7__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().D_I_D__SingleValue_Invalid,NAMED('E_Phone_D_I_D__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().D_I_D_Score__SingleValue_Invalid,NAMED('E_Phone_D_I_D_Score__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Phone_Date_First_Seen__SingleValue_Invalid,NAMED('E_Phone_Phone_Date_First_Seen__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Phone_Date_Last_Seen__SingleValue_Invalid,NAMED('E_Phone_Phone_Date_Last_Seen__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Phone_Date_Vendor_First_Reported__SingleValue_Invalid,NAMED('E_Phone_Phone_Date_Vendor_First_Reported__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Phone_Date_Vendor_Last_Reported__SingleValue_Invalid,NAMED('E_Phone_Phone_Date_Vendor_Last_Reported__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().D_T_Non_G_L_B_Last_Seen__SingleValue_Invalid,NAMED('E_Phone_D_T_Non_G_L_B_Last_Seen__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().G_L_B_D_P_P_A_Flag__SingleValue_Invalid,NAMED('E_Phone_G_L_B_D_P_P_A_Flag__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().D_I_D_Type__SingleValue_Invalid,NAMED('E_Phone_D_I_D_Type__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Orig_Phone__SingleValue_Invalid,NAMED('E_Phone_Orig_Phone__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Orig_Carrier_Name__SingleValue_Invalid,NAMED('E_Phone_Orig_Carrier_Name__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Rec_Type__SingleValue_Invalid,NAMED('E_Phone_Rec_Type__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Err_Stat__SingleValue_Invalid,NAMED('E_Phone_Err_Stat__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Rawaid__SingleValue_Invalid,NAMED('E_Phone_Rawaid__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Cleanaid__SingleValue_Invalid,NAMED('E_Phone_Cleanaid__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Current_Rec__SingleValue_Invalid,NAMED('E_Phone_Current_Rec__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().First_Build_Date__SingleValue_Invalid,NAMED('E_Phone_First_Build_Date__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Last_Build_Date__SingleValue_Invalid,NAMED('E_Phone_Last_Build_Date__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Ingest_T_P_E__SingleValue_Invalid,NAMED('E_Phone_Ingest_T_P_E__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Verified__SingleValue_Invalid,NAMED('E_Phone_Verified__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Cord_Cutter__SingleValue_Invalid,NAMED('E_Phone_Cord_Cutter__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Activity_Status__SingleValue_Invalid,NAMED('E_Phone_Activity_Status__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Prepaid__SingleValue_Invalid,NAMED('E_Phone_Prepaid__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Global_S_I_D__SingleValue_Invalid,NAMED('E_Phone_Global_S_I_D__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Serv__SingleValue_Invalid,NAMED('E_Phone_Serv__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone().Line__SingleValue_Invalid,NAMED('E_Phone_Line__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Phone().UIDSourceCounts,NAMED('E_Phone_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Phone().TopSourcedUIDs(TopNUids),NAMED('E_Phone_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Phone().UIDSourceDistribution,NAMED('E_Phone_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Phone().NullCounts,NAMED('E_Phone_NullCounts')));
 
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
 
//AddressSlim sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Address_Slim().SanityCheck,NAMED('E_Address_Slim_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Address_Slim().Primary_Range__SingleValue_Invalid,NAMED('E_Address_Slim_Primary_Range__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Address_Slim().Predirectional__SingleValue_Invalid,NAMED('E_Address_Slim_Predirectional__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Address_Slim().Primary_Name__SingleValue_Invalid,NAMED('E_Address_Slim_Primary_Name__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Address_Slim().Suffix__SingleValue_Invalid,NAMED('E_Address_Slim_Suffix__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Address_Slim().Postdirectional__SingleValue_Invalid,NAMED('E_Address_Slim_Postdirectional__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Address_Slim().Z_I_P5__SingleValue_Invalid,NAMED('E_Address_Slim_Z_I_P5__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Address_Slim().Source__SingleValue_Invalid,NAMED('E_Address_Slim_Source__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Address_Slim().UIDSourceCounts,NAMED('E_Address_Slim_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Address_Slim().TopSourcedUIDs(TopNUids),NAMED('E_Address_Slim_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Address_Slim().UIDSourceDistribution,NAMED('E_Address_Slim_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Address_Slim().NullCounts,NAMED('E_Address_Slim_NullCounts')));
 
//Property sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Property().SanityCheck,NAMED('E_Property_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Property().Primary_Range__SingleValue_Invalid,NAMED('E_Property_Primary_Range__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Property().Predirectional__SingleValue_Invalid,NAMED('E_Property_Predirectional__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Property().Primary_Name__SingleValue_Invalid,NAMED('E_Property_Primary_Name__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Property().Suffix__SingleValue_Invalid,NAMED('E_Property_Suffix__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Property().Postdirectional__SingleValue_Invalid,NAMED('E_Property_Postdirectional__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Property().Secondary_Range__SingleValue_Invalid,NAMED('E_Property_Secondary_Range__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Property().Z_I_P5__SingleValue_Invalid,NAMED('E_Property_Z_I_P5__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Property().UIDSourceCounts,NAMED('E_Property_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Property().TopSourcedUIDs(TopNUids),NAMED('E_Property_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Property().UIDSourceDistribution,NAMED('E_Property_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Property().NullCounts,NAMED('E_Property_NullCounts')));
 
//Inquiry sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Inquiry().SanityCheck,NAMED('E_Inquiry_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Inquiry().Transaction_I_D__SingleValue_Invalid,NAMED('E_Inquiry_Transaction_I_D__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Inquiry().Sequence_Number__SingleValue_Invalid,NAMED('E_Inquiry_Sequence_Number__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Inquiry().Fraudpoint_Score__SingleValue_Invalid,NAMED('E_Inquiry_Fraudpoint_Score__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Inquiry().UIDSourceCounts,NAMED('E_Inquiry_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Inquiry().TopSourcedUIDs(TopNUids),NAMED('E_Inquiry_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Inquiry().UIDSourceDistribution,NAMED('E_Inquiry_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Inquiry().NullCounts,NAMED('E_Inquiry_NullCounts')));
 
//Email sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Email().SanityCheck,NAMED('E_Email_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Email().Email_Address__SingleValue_Invalid,NAMED('E_Email_Email_Address__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Email().Rules__SingleValue_Invalid,NAMED('E_Email_Rules__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Email().User_Name__SingleValue_Invalid,NAMED('E_Email_User_Name__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Email().Domain_Name__SingleValue_Invalid,NAMED('E_Email_Domain_Name__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Email().Domain_Type__SingleValue_Invalid,NAMED('E_Email_Domain_Type__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Email().Domain_Root__SingleValue_Invalid,NAMED('E_Email_Domain_Root__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Email().Domain_Extension__SingleValue_Invalid,NAMED('E_Email_Domain_Extension__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Email().Is_Top_Level_Domain_State__SingleValue_Invalid,NAMED('E_Email_Is_Top_Level_Domain_State__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Email().Is_Top_Level_Domain_Generic__SingleValue_Invalid,NAMED('E_Email_Is_Top_Level_Domain_Generic__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Email().Is_Top_Level_Domain_Country__SingleValue_Invalid,NAMED('E_Email_Is_Top_Level_Domain_Country__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Email().E360_I_D__SingleValue_Invalid,NAMED('E_Email_E360_I_D__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Email().Teramedia_I_D__SingleValue_Invalid,NAMED('E_Email_Teramedia_I_D__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Email().UIDSourceCounts,NAMED('E_Email_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Email().TopSourcedUIDs(TopNUids),NAMED('E_Email_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Email().UIDSourceDistribution,NAMED('E_Email_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Email().NullCounts,NAMED('E_Email_NullCounts')));
 
//InputPII sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Input_P_I_I().SanityCheck,NAMED('E_Input_P_I_I_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Subject__SingleValue_Invalid,NAMED('E_Input_P_I_I_Subject__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Acct__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Acct__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Lex_I_D__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Lex_I_D__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Name_First__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Name_First__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Name_Mid__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Name_Mid__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Name_Last__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Name_Last__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Surname1__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Surname1__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Surname2__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Surname2__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Last_Name1__SingleValue_Invalid,NAMED('E_Input_P_I_I_Last_Name1__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Last_Name2__SingleValue_Invalid,NAMED('E_Input_P_I_I_Last_Name2__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Address_Geo_Link__SingleValue_Invalid,NAMED('E_Input_P_I_I_Address_Geo_Link__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Addr_Line1__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Addr_Line1__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Addr_Line2__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Addr_Line2__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Addr_City__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Addr_City__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Addr_State__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Addr_State__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Addr_Zip__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Addr_Zip__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Phone_Home__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Phone_Home__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_S_S_N__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_S_S_N__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_D_O_B__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_D_O_B__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Phone_Work__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Phone_Work__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Input_Income_Echo__SingleValue_Invalid,NAMED('E_Input_P_I_I_Input_Income_Echo__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_D_L__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_D_L__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_D_L_State__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_D_L_State__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Input_Balance_Echo__SingleValue_Invalid,NAMED('E_Input_P_I_I_Input_Balance_Echo__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Input_Charge_Offd_Echo__SingleValue_Invalid,NAMED('E_Input_P_I_I_Input_Charge_Offd_Echo__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Input_Former_Name_Echo__SingleValue_Invalid,NAMED('E_Input_P_I_I_Input_Former_Name_Echo__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Email__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Email__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_I_P_Addr__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_I_P_Addr__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Input_Employment_Echo__SingleValue_Invalid,NAMED('E_Input_P_I_I_Input_Employment_Echo__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Arch_Dt__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Arch_Dt__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Lex_I_D__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Lex_I_D__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Lex_I_D_Score__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Lex_I_D_Score__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Name_Prfx__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Name_Prfx__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Name_First__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Name_First__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Name_Mid__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Name_Mid__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Name_Last__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Name_Last__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Name_Sffx__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Name_Sffx__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Prop__SingleValue_Invalid,NAMED('E_Input_P_I_I_Prop__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Location__SingleValue_Invalid,NAMED('E_Input_P_I_I_Location__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Addr_Prim_Rng__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Addr_Prim_Rng__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Addr_Pre_Dir__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Addr_Pre_Dir__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Addr_Prim_Name__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Addr_Prim_Name__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Addr_Sffx__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Addr_Sffx__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Addr_Post_Dir__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Addr_Post_Dir__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Addr_Unit_Desig__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Addr_Unit_Desig__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Addr_Sec_Rng__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Addr_Sec_Rng__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Addr_City__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Addr_City__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Addr_City_Post__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Addr_City_Post__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Addr_State__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Addr_State__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Addr_Zip5__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Addr_Zip5__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Addr_Zip4__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Addr_Zip4__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Addr_Lat__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Addr_Lat__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Addr_Lng__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Addr_Lng__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Addr_State_Code__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Addr_State_Code__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Addr_Cnty__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Addr_Cnty__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Addr_Geo__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Addr_Geo__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Geo_Link_I_D__SingleValue_Invalid,NAMED('E_Input_P_I_I_Geo_Link_I_D__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Addr_Type__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Addr_Type__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Addr_Status__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Addr_Status__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Email__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Email__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Input_Clean_Email__SingleValue_Invalid,NAMED('E_Input_P_I_I_Input_Clean_Email__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Phone_Home__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Phone_Home__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Input_Clean_Phone__SingleValue_Invalid,NAMED('E_Input_P_I_I_Input_Clean_Phone__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Phone_Work__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Phone_Work__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_D_L__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_D_L__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_D_L_State__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_D_L_State__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_D_O_B__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_D_O_B__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_S_S_N__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_S_S_N__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Input_Clean_S_S_N__SingleValue_Invalid,NAMED('E_Input_P_I_I_Input_Clean_S_S_N__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().P___Inp_Cln_Arch_Dt__SingleValue_Invalid,NAMED('E_Input_P_I_I_P___Inp_Cln_Arch_Dt__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().G___Proc_Bus_U_I_D__SingleValue_Invalid,NAMED('E_Input_P_I_I_G___Proc_Bus_U_I_D__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Phone_Verification_Bureau__SingleValue_Invalid,NAMED('E_Input_P_I_I_Phone_Verification_Bureau__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Dial_Indicator__SingleValue_Invalid,NAMED('E_Input_P_I_I_Dial_Indicator__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Point_I_D__SingleValue_Invalid,NAMED('E_Input_P_I_I_Point_I_D__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().N_X_X_Type__SingleValue_Invalid,NAMED('E_Input_P_I_I_N_X_X_Type__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Z_I_P_Match__SingleValue_Invalid,NAMED('E_Input_P_I_I_Z_I_P_Match__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().C_O_C_Type__SingleValue_Invalid,NAMED('E_Input_P_I_I_C_O_C_Type__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().S_S_C__SingleValue_Invalid,NAMED('E_Input_P_I_I_S_S_C__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Wireless_Indicator__SingleValue_Invalid,NAMED('E_Input_P_I_I_Wireless_Indicator__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Rep_Number__SingleValue_Invalid,NAMED('E_Input_P_I_I_Rep_Number__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Slim_Location__SingleValue_Invalid,NAMED('E_Input_P_I_I_Slim_Location__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Z_I_P5__SingleValue_Invalid,NAMED('E_Input_P_I_I_Z_I_P5__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Social_Summary__SingleValue_Invalid,NAMED('E_Input_P_I_I_Social_Summary__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Name_Summ__SingleValue_Invalid,NAMED('E_Input_P_I_I_Name_Summ__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Telephone_Summary__SingleValue_Invalid,NAMED('E_Input_P_I_I_Telephone_Summary__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Location_Summary__SingleValue_Invalid,NAMED('E_Input_P_I_I_Location_Summary__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Current_Addr_Prim_Rng__SingleValue_Invalid,NAMED('E_Input_P_I_I_Current_Addr_Prim_Rng__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Current_Addr_Pre_Dir__SingleValue_Invalid,NAMED('E_Input_P_I_I_Current_Addr_Pre_Dir__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Current_Addr_Prim_Name__SingleValue_Invalid,NAMED('E_Input_P_I_I_Current_Addr_Prim_Name__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Current_Addr_Sffx__SingleValue_Invalid,NAMED('E_Input_P_I_I_Current_Addr_Sffx__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Current_Addr_Sec_Rng__SingleValue_Invalid,NAMED('E_Input_P_I_I_Current_Addr_Sec_Rng__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Current_Addr_State__SingleValue_Invalid,NAMED('E_Input_P_I_I_Current_Addr_State__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Current_Addr_Zip5__SingleValue_Invalid,NAMED('E_Input_P_I_I_Current_Addr_Zip5__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Current_Addr_Zip4__SingleValue_Invalid,NAMED('E_Input_P_I_I_Current_Addr_Zip4__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Current_Addr_State_Code__SingleValue_Invalid,NAMED('E_Input_P_I_I_Current_Addr_State_Code__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Current_Addr_Cnty__SingleValue_Invalid,NAMED('E_Input_P_I_I_Current_Addr_Cnty__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Current_Addr_Geo__SingleValue_Invalid,NAMED('E_Input_P_I_I_Current_Addr_Geo__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Current_Addr_City__SingleValue_Invalid,NAMED('E_Input_P_I_I_Current_Addr_City__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Current_Addr_Post_Dir__SingleValue_Invalid,NAMED('E_Input_P_I_I_Current_Addr_Post_Dir__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Current_Addr_Lat__SingleValue_Invalid,NAMED('E_Input_P_I_I_Current_Addr_Lat__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Current_Addr_Lng__SingleValue_Invalid,NAMED('E_Input_P_I_I_Current_Addr_Lng__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Current_Addr_Unit_Designation__SingleValue_Invalid,NAMED('E_Input_P_I_I_Current_Addr_Unit_Designation__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Current_Addr_Type__SingleValue_Invalid,NAMED('E_Input_P_I_I_Current_Addr_Type__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Current_Addr_Status__SingleValue_Invalid,NAMED('E_Input_P_I_I_Current_Addr_Status__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Current_Addr_Date_First_Seen__SingleValue_Invalid,NAMED('E_Input_P_I_I_Current_Addr_Date_First_Seen__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Current_Addr_Date_Last_Seen__SingleValue_Invalid,NAMED('E_Input_P_I_I_Current_Addr_Date_Last_Seen__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Current_Addr_Full__SingleValue_Invalid,NAMED('E_Input_P_I_I_Current_Addr_Full__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Current_Address__SingleValue_Invalid,NAMED('E_Input_P_I_I_Current_Address__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Previous_Addr_Prim_Rng__SingleValue_Invalid,NAMED('E_Input_P_I_I_Previous_Addr_Prim_Rng__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Previous_Addr_Pre_Dir__SingleValue_Invalid,NAMED('E_Input_P_I_I_Previous_Addr_Pre_Dir__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Previous_Addr_Prim_Name__SingleValue_Invalid,NAMED('E_Input_P_I_I_Previous_Addr_Prim_Name__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Previous_Addr_Sffx__SingleValue_Invalid,NAMED('E_Input_P_I_I_Previous_Addr_Sffx__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Previous_Addr_Sec_Rng__SingleValue_Invalid,NAMED('E_Input_P_I_I_Previous_Addr_Sec_Rng__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Previous_Addr_State__SingleValue_Invalid,NAMED('E_Input_P_I_I_Previous_Addr_State__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Previous_Addr_Zip5__SingleValue_Invalid,NAMED('E_Input_P_I_I_Previous_Addr_Zip5__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Previous_Addr_Zip4__SingleValue_Invalid,NAMED('E_Input_P_I_I_Previous_Addr_Zip4__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Previous_Addr_State_Code__SingleValue_Invalid,NAMED('E_Input_P_I_I_Previous_Addr_State_Code__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Previous_Addr_Cnty__SingleValue_Invalid,NAMED('E_Input_P_I_I_Previous_Addr_Cnty__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Previous_Addr_Geo__SingleValue_Invalid,NAMED('E_Input_P_I_I_Previous_Addr_Geo__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Previous_Addr_City__SingleValue_Invalid,NAMED('E_Input_P_I_I_Previous_Addr_City__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Previous_Addr_Post_Dir__SingleValue_Invalid,NAMED('E_Input_P_I_I_Previous_Addr_Post_Dir__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Previous_Addr_Lat__SingleValue_Invalid,NAMED('E_Input_P_I_I_Previous_Addr_Lat__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Previous_Addr_Lng__SingleValue_Invalid,NAMED('E_Input_P_I_I_Previous_Addr_Lng__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Previous_Addr_Unit_Designation__SingleValue_Invalid,NAMED('E_Input_P_I_I_Previous_Addr_Unit_Designation__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Previous_Addr_Type__SingleValue_Invalid,NAMED('E_Input_P_I_I_Previous_Addr_Type__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Previous_Addr_Status__SingleValue_Invalid,NAMED('E_Input_P_I_I_Previous_Addr_Status__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Previous_Addr_Date_First_Seen__SingleValue_Invalid,NAMED('E_Input_P_I_I_Previous_Addr_Date_First_Seen__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Previous_Addr_Date_Last_Seen__SingleValue_Invalid,NAMED('E_Input_P_I_I_Previous_Addr_Date_Last_Seen__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Previous_Addr_Full__SingleValue_Invalid,NAMED('E_Input_P_I_I_Previous_Addr_Full__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Input_P_I_I().Previous_Address__SingleValue_Invalid,NAMED('E_Input_P_I_I_Previous_Address__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Input_P_I_I().UIDSourceCounts,NAMED('E_Input_P_I_I_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Input_P_I_I().TopSourcedUIDs(TopNUids),NAMED('E_Input_P_I_I_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Input_P_I_I().UIDSourceDistribution,NAMED('E_Input_P_I_I_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Input_P_I_I().NullCounts,NAMED('E_Input_P_I_I_NullCounts')));
 
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
 
//Surname sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Surname().SanityCheck,NAMED('E_Surname_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Surname().Surname__SingleValue_Invalid,NAMED('E_Surname_Surname__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Surname().Is_Latest__SingleValue_Invalid,NAMED('E_Surname_Is_Latest__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Surname().Name_Rank__SingleValue_Invalid,NAMED('E_Surname_Name_Rank__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Surname().Name_Count__SingleValue_Invalid,NAMED('E_Surname_Name_Count__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Surname().Prop100_K__SingleValue_Invalid,NAMED('E_Surname_Prop100_K__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Surname().Cumulative_Prop100_K__SingleValue_Invalid,NAMED('E_Surname_Cumulative_Prop100_K__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Surname().Percent_White__SingleValue_Invalid,NAMED('E_Surname_Percent_White__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Surname().Percent_Black__SingleValue_Invalid,NAMED('E_Surname_Percent_Black__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Surname().Percent_Asian_Pacific_Islander__SingleValue_Invalid,NAMED('E_Surname_Percent_Asian_Pacific_Islander__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Surname().Percent_American_Indian_Alaska_Native__SingleValue_Invalid,NAMED('E_Surname_Percent_American_Indian_Alaska_Native__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Surname().Percent_Multiracial__SingleValue_Invalid,NAMED('E_Surname_Percent_Multiracial__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Surname().Percent_Hispanic__SingleValue_Invalid,NAMED('E_Surname_Percent_Hispanic__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Surname().UIDSourceCounts,NAMED('E_Surname_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Surname().TopSourcedUIDs(TopNUids),NAMED('E_Surname_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Surname().UIDSourceDistribution,NAMED('E_Surname_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Surname().NullCounts,NAMED('E_Surname_NullCounts')));
 
//SSNSummary sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_S_S_N_Summary().SanityCheck,NAMED('E_S_S_N_Summary_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_S_S_N_Summary().S_S_N__SingleValue_Invalid,NAMED('E_S_S_N_Summary_S_S_N__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_S_S_N_Summary().UIDSourceCounts,NAMED('E_S_S_N_Summary_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_S_S_N_Summary().TopSourcedUIDs(TopNUids),NAMED('E_S_S_N_Summary_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_S_S_N_Summary().UIDSourceDistribution,NAMED('E_S_S_N_Summary_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_S_S_N_Summary().NullCounts,NAMED('E_S_S_N_Summary_NullCounts')));
 
//NameSummary sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Name_Summary().SanityCheck,NAMED('E_Name_Summary_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Name_Summary().First_Name__SingleValue_Invalid,NAMED('E_Name_Summary_First_Name__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Name_Summary().Last_Name__SingleValue_Invalid,NAMED('E_Name_Summary_Last_Name__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Name_Summary().Date_Of_Birth__SingleValue_Invalid,NAMED('E_Name_Summary_Date_Of_Birth__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Name_Summary().Date_Of_Birth_Padded__SingleValue_Invalid,NAMED('E_Name_Summary_Date_Of_Birth_Padded__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Name_Summary().Record_Count__SingleValue_Invalid,NAMED('E_Name_Summary_Record_Count__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Name_Summary().UIDSourceCounts,NAMED('E_Name_Summary_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Name_Summary().TopSourcedUIDs(TopNUids),NAMED('E_Name_Summary_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Name_Summary().UIDSourceDistribution,NAMED('E_Name_Summary_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Name_Summary().NullCounts,NAMED('E_Name_Summary_NullCounts')));
 
//PhoneSummary sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Phone_Summary().SanityCheck,NAMED('E_Phone_Summary_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Phone_Summary().Phone10__SingleValue_Invalid,NAMED('E_Phone_Summary_Phone10__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Phone_Summary().UIDSourceCounts,NAMED('E_Phone_Summary_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Phone_Summary().TopSourcedUIDs(TopNUids),NAMED('E_Phone_Summary_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Phone_Summary().UIDSourceDistribution,NAMED('E_Phone_Summary_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Phone_Summary().NullCounts,NAMED('E_Phone_Summary_NullCounts')));
 
//AddressSummary sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Address_Summary().SanityCheck,NAMED('E_Address_Summary_SanityCheck')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Address_Summary().Primary_Name__SingleValue_Invalid,NAMED('E_Address_Summary_Primary_Name__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Address_Summary().Primary_Range__SingleValue_Invalid,NAMED('E_Address_Summary_Primary_Range__SingleValue_Invalid')));
IF(RunAll OR RunInvalidSingleValues,OUTPUT(E_Address_Summary().Zip__SingleValue_Invalid,NAMED('E_Address_Summary_Zip__SingleValue_Invalid')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Address_Summary().UIDSourceCounts,NAMED('E_Address_Summary_UIDSourceCounts')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Address_Summary().TopSourcedUIDs(TopNUids),NAMED('E_Address_Summary_TopSourcedUIDs')));
IF(RunAll OR RunFast OR RunUidSourceCounts,OUTPUT(E_Address_Summary().UIDSourceDistribution,NAMED('E_Address_Summary_UIDSourceDistribution')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Address_Summary().NullCounts,NAMED('E_Address_Summary_NullCounts')));
 
//AddressInquiry sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Address_Inquiry().SanityCheck,NAMED('E_Address_Inquiry_SanityCheck')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Address_Inquiry().NullCounts,NAMED('E_Address_Inquiry_NullCounts')));
 
//SSNInquiry sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_S_S_N_Inquiry().SanityCheck,NAMED('E_S_S_N_Inquiry_SanityCheck')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_S_S_N_Inquiry().NullCounts,NAMED('E_S_S_N_Inquiry_NullCounts')));
 
//EmailInquiry sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Email_Inquiry().SanityCheck,NAMED('E_Email_Inquiry_SanityCheck')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Email_Inquiry().NullCounts,NAMED('E_Email_Inquiry_NullCounts')));
 
//PhoneInquiry sanity checks
IF(RunAll OR RunSanityCheckSummary,OUTPUT(E_Phone_Inquiry().SanityCheck,NAMED('E_Phone_Inquiry_SanityCheck')));
IF(RunAll OR RunFast OR RunNullCounts,OUTPUT(E_Phone_Inquiry().NullCounts,NAMED('E_Phone_Inquiry_NullCounts')));
