//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT E_Inquiry(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.nstr Method_;
    KEL.typ.nint Product_Code_;
    KEL.typ.nstr Function_Description_;
    KEL.typ.nint G_L_B_Purpose_;
    KEL.typ.nint D_P_P_A_Purpose_;
    KEL.typ.nint F_C_R_A_Purpose_;
    KEL.typ.nstr Primary_Market_Code_;
    KEL.typ.nstr Secondary_Market_Code_;
    KEL.typ.nstr Industry_Code1_;
    KEL.typ.nstr Industry_Code2_;
    KEL.typ.nstr Sub_Market_;
    KEL.typ.nstr Vertical_;
    KEL.typ.nstr Industry_;
    KEL.typ.nint Fraudpoint_Score_;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Date_Of_Birth_Padded_;
    KEL.typ.nint Lex_I_D_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Z_I_P5_;
    KEL.typ.nstr S_S_N_;
    KEL.typ.nstr Appended_S_S_N_;
    KEL.typ.nint Personal_Phone_Number_;
    KEL.typ.nint Work_Phone_Number_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr Company_Name_;
    KEL.typ.nstr Company_Phone_;
    KEL.typ.nint T_I_N_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Source_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    DATA57 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(DEFAULT:UID),transactionid(DEFAULT:Transaction_I_D_:\'\'),sequencenumber(DEFAULT:Sequence_Number_:\'\'),method(DEFAULT:Method_:\'\'),productcode(DEFAULT:Product_Code_:0),functiondescription(DEFAULT:Function_Description_:\'\'),glbpurpose(DEFAULT:G_L_B_Purpose_:0),dppapurpose(DEFAULT:D_P_P_A_Purpose_:0),fcrapurpose(DEFAULT:F_C_R_A_Purpose_:0),primarymarketcode(DEFAULT:Primary_Market_Code_:\'\'),secondarymarketcode(DEFAULT:Secondary_Market_Code_:\'\'),industrycode1(DEFAULT:Industry_Code1_:\'\'),industrycode2(DEFAULT:Industry_Code2_:\'\'),submarket(DEFAULT:Sub_Market_:\'\'),vertical(DEFAULT:Vertical_:\'\'),industry(DEFAULT:Industry_:\'\'),fraudpointscore(DEFAULT:Fraudpoint_Score_:0),firstname(DEFAULT:First_Name_:\'\'),lastname(DEFAULT:Last_Name_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),lexid(DEFAULT:Lex_I_D_:0),primaryrange(DEFAULT:Primary_Range_:\'\'),predirectional(DEFAULT:Predirectional_:\'\'),primaryname(DEFAULT:Primary_Name_:\'\'),suffix(DEFAULT:Suffix_:\'\'),postdirectional(DEFAULT:Postdirectional_:\'\'),secondaryrange(DEFAULT:Secondary_Range_:\'\'),zip5(DEFAULT:Z_I_P5_:\'\'),ssn(DEFAULT:S_S_N_:\'\'),appendedssn(DEFAULT:Appended_S_S_N_:\'\'),personalphonenumber(DEFAULT:Personal_Phone_Number_:0),workphonenumber(DEFAULT:Work_Phone_Number_:0),emailaddress(DEFAULT:Email_Address_:\'\'),companyname(DEFAULT:Company_Name_:\'\'),companyphone(DEFAULT:Company_Phone_:\'\'),tin(DEFAULT:T_I_N_:0),ultid(DEFAULT:Ult_I_D_:0),orgid(DEFAULT:Org_I_D_:0),seleid(DEFAULT:Sele_I_D_:0),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCHTIMESTAMP),datelastseen(DEFAULT:Date_Last_Seen_:EPOCHTIMESTAMP),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCHTIMESTAMP),archive_date(DEFAULT:Archive___Date_:EPOCHTIMESTAMP),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in.Dataset_Inquiry_AccLogs__Key_FCRA_DID,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number)));
  SHARED __d1_Trim := PROJECT(__in.Dataset_Inquiry_AccLogs__Key_FCRA_Phone,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number)));
  SHARED __d2_Trim := PROJECT(__in.Dataset_Inquiry_AccLogs__Key_FCRA_Address,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number)));
  SHARED __d3_Trim := PROJECT(__in.Dataset_Inquiry_AccLogs__Key_FCRA_SSN,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number)));
  SHARED __d4_Trim := PROJECT(__in.Dataset_Inquiry_AccLogs__Inquiry_Table_SSN,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number)));
  SHARED __d5_Trim := PROJECT(__in.Dataset_Inquiry_AccLogs__Inquiry_Table_Address,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number)));
  SHARED __d6_Trim := PROJECT(__in.Dataset_Inquiry_AccLogs__Inquiry_Table_DID,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number)));
  SHARED __d7_Trim := PROJECT(__in.Dataset_Inquiry_AccLogs__Inquiry_Table_EMAIL,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number)));
  SHARED __d8_Trim := PROJECT(__in.Dataset_Inquiry_AccLogs__Inquiry_Table_Phone,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number)));
  SHARED __d9_Trim := PROJECT(__in.Dataset_Inquiry_AccLogs__Inquiry_Table_FEIN,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number)));
  SHARED __d10_Trim := PROJECT(__in.Dataset_Inquiry_AccLogs__Inquiry_Table_FEIN,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number)));
  SHARED __d11_Trim := PROJECT(__in.Dataset_Inquiry_AccLogs__Inquiry_Table_LinkIDs,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number)));
  SHARED __d12_Trim := PROJECT(__in.Dataset_Inquiry_AccLogs__Inquiry_Table_LinkIDs,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim + __d2_Trim + __d3_Trim + __d4_Trim + __d5_Trim + __d6_Trim + __d7_Trim + __d8_Trim + __d9_Trim + __d10_Trim + __d11_Trim + __d12_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'') + '|' + TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Archive___Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000','0');
  SHARED __Mapping0 := 'UID(DEFAULT:UID),search_info.transaction_id(OVERRIDE:Transaction_I_D_:\'\'),search_info.sequence_number(OVERRIDE:Sequence_Number_:\'\'),search_info.method(OVERRIDE:Method_:\'\'),search_info.product_code(OVERRIDE:Product_Code_:0),search_info.function_description(OVERRIDE:Function_Description_:\'\'),permissions.glb_purpose(OVERRIDE:G_L_B_Purpose_:0),permissions.dppa_purpose(OVERRIDE:D_P_P_A_Purpose_:0),permissions.fcra_purpose(OVERRIDE:F_C_R_A_Purpose_:0),bus_intel.primary_market_code(OVERRIDE:Primary_Market_Code_:\'\'),bus_intel.secondary_market_code(OVERRIDE:Secondary_Market_Code_:\'\'),bus_intel.industry_1_code(OVERRIDE:Industry_Code1_:\'\'),bus_intel.industry_2_code(OVERRIDE:Industry_Code2_:\'\'),bus_intel.sub_market(OVERRIDE:Sub_Market_:\'\'),bus_intel.vertical(OVERRIDE:Vertical_:\'\'),bus_intel.industry(OVERRIDE:Industry_:\'\'),fraudpointscore(DEFAULT:Fraudpoint_Score_:0),person_q.fname(OVERRIDE:First_Name_:\'\'),person_q.lname(OVERRIDE:Last_Name_:\'\'),person_q.dob(OVERRIDE:Date_Of_Birth_:DATE),dobpadded(OVERRIDE:Date_Of_Birth_Padded_:\'\'),person_q.appended_adl(OVERRIDE:Lex_I_D_:0),person_q.prim_range(OVERRIDE:Primary_Range_:\'\'),person_q.predir(OVERRIDE:Predirectional_:\'\'),person_q.prim_name(OVERRIDE:Primary_Name_:\'\'),person_q.addr_suffix(OVERRIDE:Suffix_:\'\'),person_q.postdir(OVERRIDE:Postdirectional_:\'\'),person_q.sec_range(OVERRIDE:Secondary_Range_:\'\'),person_q.zip5(OVERRIDE:Z_I_P5_:\'\'),person_q.ssn(OVERRIDE:S_S_N_:\'\'),person_q.appended_ssn(OVERRIDE:Appended_S_S_N_:\'\'),person_q.personal_phone(OVERRIDE:Personal_Phone_Number_:0),person_q.work_phone(OVERRIDE:Work_Phone_Number_:0),person_q.email_address(OVERRIDE:Email_Address_:\'\'),companyname(DEFAULT:Company_Name_:\'\'),companyphone(DEFAULT:Company_Phone_:\'\'),tin(DEFAULT:T_I_N_:0),ultid(DEFAULT:Ult_I_D_:0),orgid(DEFAULT:Org_I_D_:0),seleid(DEFAULT:Sele_I_D_:0),src(OVERRIDE:Source_:\'\'),dateofinquiry(OVERRIDE:Date_First_Seen_:EPOCHTIMESTAMP:Date_First_Seen_0Rule|OVERRIDE:Date_Last_Seen_:EPOCHTIMESTAMP:Date_Last_Seen_0Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCHTIMESTAMP),archive_date(OVERRIDE:Archive___Date_:EPOCHTIMESTAMP:Archive___Date_0Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Key_FCRA_DID,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Key_FCRA_DID),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Inquiry_AccLogs__Key_FCRA_DID);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_Norm,Lookup,TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_DID_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Archive___Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000','0');
  SHARED __Mapping1 := 'UID(DEFAULT:UID),search_info.transaction_id(OVERRIDE:Transaction_I_D_:\'\'),search_info.sequence_number(OVERRIDE:Sequence_Number_:\'\'),search_info.method(OVERRIDE:Method_:\'\'),search_info.product_code(OVERRIDE:Product_Code_:0),search_info.function_description(OVERRIDE:Function_Description_:\'\'),permissions.glb_purpose(OVERRIDE:G_L_B_Purpose_:0),permissions.dppa_purpose(OVERRIDE:D_P_P_A_Purpose_:0),permissions.fcra_purpose(OVERRIDE:F_C_R_A_Purpose_:0),bus_intel.primary_market_code(OVERRIDE:Primary_Market_Code_:\'\'),bus_intel.secondary_market_code(OVERRIDE:Secondary_Market_Code_:\'\'),bus_intel.industry_1_code(OVERRIDE:Industry_Code1_:\'\'),bus_intel.industry_2_code(OVERRIDE:Industry_Code2_:\'\'),bus_intel.sub_market(OVERRIDE:Sub_Market_:\'\'),bus_intel.vertical(OVERRIDE:Vertical_:\'\'),bus_intel.industry(OVERRIDE:Industry_:\'\'),fraudpointscore(DEFAULT:Fraudpoint_Score_:0),person_q.fname(OVERRIDE:First_Name_:\'\'),person_q.lname(OVERRIDE:Last_Name_:\'\'),person_q.dob(OVERRIDE:Date_Of_Birth_:DATE),dobpadded(OVERRIDE:Date_Of_Birth_Padded_:\'\'),person_q.appended_adl(OVERRIDE:Lex_I_D_:0),person_q.prim_range(OVERRIDE:Primary_Range_:\'\'),person_q.predir(OVERRIDE:Predirectional_:\'\'),person_q.prim_name(OVERRIDE:Primary_Name_:\'\'),person_q.addr_suffix(OVERRIDE:Suffix_:\'\'),person_q.postdir(OVERRIDE:Postdirectional_:\'\'),person_q.sec_range(OVERRIDE:Secondary_Range_:\'\'),person_q.zip5(OVERRIDE:Z_I_P5_:\'\'),person_q.ssn(OVERRIDE:S_S_N_:\'\'),person_q.appended_ssn(OVERRIDE:Appended_S_S_N_:\'\'),person_q.personal_phone(OVERRIDE:Personal_Phone_Number_:0),person_q.work_phone(OVERRIDE:Work_Phone_Number_:0),person_q.email_address(OVERRIDE:Email_Address_:\'\'),companyname(DEFAULT:Company_Name_:\'\'),companyphone(DEFAULT:Company_Phone_:\'\'),tin(DEFAULT:T_I_N_:0),ultid(DEFAULT:Ult_I_D_:0),orgid(DEFAULT:Org_I_D_:0),seleid(DEFAULT:Sele_I_D_:0),src(OVERRIDE:Source_:\'\'),dateofinquiry(OVERRIDE:Date_First_Seen_:EPOCHTIMESTAMP:Date_First_Seen_1Rule|OVERRIDE:Date_Last_Seen_:EPOCHTIMESTAMP:Date_Last_Seen_1Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCHTIMESTAMP),archive_date(OVERRIDE:Archive___Date_:EPOCHTIMESTAMP:Archive___Date_1Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Key_FCRA_Phone,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Key_FCRA_Phone),SELF:=RIGHT));
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Inquiry_AccLogs__Key_FCRA_Phone);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_Norm,Lookup,TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_Phone_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Date_Last_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Archive___Date_2Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000','0');
  SHARED __Mapping2 := 'UID(DEFAULT:UID),search_info.transaction_id(OVERRIDE:Transaction_I_D_:\'\'),search_info.sequence_number(OVERRIDE:Sequence_Number_:\'\'),search_info.method(OVERRIDE:Method_:\'\'),search_info.product_code(OVERRIDE:Product_Code_:0),search_info.function_description(OVERRIDE:Function_Description_:\'\'),permissions.glb_purpose(OVERRIDE:G_L_B_Purpose_:0),permissions.dppa_purpose(OVERRIDE:D_P_P_A_Purpose_:0),permissions.fcra_purpose(OVERRIDE:F_C_R_A_Purpose_:0),bus_intel.primary_market_code(OVERRIDE:Primary_Market_Code_:\'\'),bus_intel.secondary_market_code(OVERRIDE:Secondary_Market_Code_:\'\'),bus_intel.industry_1_code(OVERRIDE:Industry_Code1_:\'\'),bus_intel.industry_2_code(OVERRIDE:Industry_Code2_:\'\'),bus_intel.sub_market(OVERRIDE:Sub_Market_:\'\'),bus_intel.vertical(OVERRIDE:Vertical_:\'\'),bus_intel.industry(OVERRIDE:Industry_:\'\'),fraudpointscore(DEFAULT:Fraudpoint_Score_:0),person_q.fname(OVERRIDE:First_Name_:\'\'),person_q.lname(OVERRIDE:Last_Name_:\'\'),person_q.dob(OVERRIDE:Date_Of_Birth_:DATE),dobpadded(OVERRIDE:Date_Of_Birth_Padded_:\'\'),person_q.appended_adl(OVERRIDE:Lex_I_D_:0),person_q.prim_range(OVERRIDE:Primary_Range_:\'\'),person_q.predir(OVERRIDE:Predirectional_:\'\'),person_q.prim_name(OVERRIDE:Primary_Name_:\'\'),person_q.addr_suffix(OVERRIDE:Suffix_:\'\'),person_q.postdir(OVERRIDE:Postdirectional_:\'\'),person_q.sec_range(OVERRIDE:Secondary_Range_:\'\'),person_q.zip5(OVERRIDE:Z_I_P5_:\'\'),person_q.ssn(OVERRIDE:S_S_N_:\'\'),person_q.appended_ssn(OVERRIDE:Appended_S_S_N_:\'\'),person_q.personal_phone(OVERRIDE:Personal_Phone_Number_:0),person_q.work_phone(OVERRIDE:Work_Phone_Number_:0),person_q.email_address(OVERRIDE:Email_Address_:\'\'),companyname(DEFAULT:Company_Name_:\'\'),companyphone(DEFAULT:Company_Phone_:\'\'),tin(DEFAULT:T_I_N_:0),ultid(DEFAULT:Ult_I_D_:0),orgid(DEFAULT:Org_I_D_:0),seleid(DEFAULT:Sele_I_D_:0),src(OVERRIDE:Source_:\'\'),dateofinquiry(OVERRIDE:Date_First_Seen_:EPOCHTIMESTAMP:Date_First_Seen_2Rule|OVERRIDE:Date_Last_Seen_:EPOCHTIMESTAMP:Date_Last_Seen_2Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCHTIMESTAMP),archive_date(OVERRIDE:Archive___Date_:EPOCHTIMESTAMP:Archive___Date_2Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Key_FCRA_Address,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Key_FCRA_Address),SELF:=RIGHT));
  SHARED __d2_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Inquiry_AccLogs__Key_FCRA_Address);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d2_UID_Mapped := JOIN(__d2_Norm,Lookup,TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number) = RIGHT.KeyVal,TRANSFORM(__d2_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_Address_Invalid := __d2_UID_Mapped(UID = 0);
  SHARED __d2_Prefiltered := __d2_UID_Mapped(UID <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_3Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Date_Last_Seen_3Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Archive___Date_3Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000','0');
  SHARED __Mapping3 := 'UID(DEFAULT:UID),search_info.transaction_id(OVERRIDE:Transaction_I_D_:\'\'),search_info.sequence_number(OVERRIDE:Sequence_Number_:\'\'),search_info.method(OVERRIDE:Method_:\'\'),search_info.product_code(OVERRIDE:Product_Code_:0),search_info.function_description(OVERRIDE:Function_Description_:\'\'),permissions.glb_purpose(OVERRIDE:G_L_B_Purpose_:0),permissions.dppa_purpose(OVERRIDE:D_P_P_A_Purpose_:0),permissions.fcra_purpose(OVERRIDE:F_C_R_A_Purpose_:0),bus_intel.primary_market_code(OVERRIDE:Primary_Market_Code_:\'\'),bus_intel.secondary_market_code(OVERRIDE:Secondary_Market_Code_:\'\'),bus_intel.industry_1_code(OVERRIDE:Industry_Code1_:\'\'),bus_intel.industry_2_code(OVERRIDE:Industry_Code2_:\'\'),bus_intel.sub_market(OVERRIDE:Sub_Market_:\'\'),bus_intel.vertical(OVERRIDE:Vertical_:\'\'),bus_intel.industry(OVERRIDE:Industry_:\'\'),fraudpointscore(DEFAULT:Fraudpoint_Score_:0),person_q.fname(OVERRIDE:First_Name_:\'\'),person_q.lname(OVERRIDE:Last_Name_:\'\'),person_q.dob(OVERRIDE:Date_Of_Birth_:DATE),dobpadded(OVERRIDE:Date_Of_Birth_Padded_:\'\'),person_q.appended_adl(OVERRIDE:Lex_I_D_:0),person_q.prim_range(OVERRIDE:Primary_Range_:\'\'),person_q.predir(OVERRIDE:Predirectional_:\'\'),person_q.prim_name(OVERRIDE:Primary_Name_:\'\'),person_q.addr_suffix(OVERRIDE:Suffix_:\'\'),person_q.postdir(OVERRIDE:Postdirectional_:\'\'),person_q.sec_range(OVERRIDE:Secondary_Range_:\'\'),person_q.zip5(OVERRIDE:Z_I_P5_:\'\'),ssn(OVERRIDE:S_S_N_:\'\'),appendedssn(DEFAULT:Appended_S_S_N_:\'\'),person_q.personal_phone(OVERRIDE:Personal_Phone_Number_:0),person_q.work_phone(OVERRIDE:Work_Phone_Number_:0),person_q.email_address(OVERRIDE:Email_Address_:\'\'),companyname(DEFAULT:Company_Name_:\'\'),companyphone(DEFAULT:Company_Phone_:\'\'),tin(DEFAULT:T_I_N_:0),ultid(DEFAULT:Ult_I_D_:0),orgid(DEFAULT:Org_I_D_:0),seleid(DEFAULT:Sele_I_D_:0),src(OVERRIDE:Source_:\'\'),dateofinquiry(OVERRIDE:Date_First_Seen_:EPOCHTIMESTAMP:Date_First_Seen_3Rule|OVERRIDE:Date_Last_Seen_:EPOCHTIMESTAMP:Date_Last_Seen_3Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCHTIMESTAMP),archive_date(OVERRIDE:Archive___Date_:EPOCHTIMESTAMP:Archive___Date_3Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Key_FCRA_SSN,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Key_FCRA_SSN),SELF:=RIGHT));
  SHARED __d3_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Inquiry_AccLogs__Key_FCRA_SSN);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d3_UID_Mapped := JOIN(__d3_Norm,Lookup,TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number) = RIGHT.KeyVal,TRANSFORM(__d3_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_SSN_Invalid := __d3_UID_Mapped(UID = 0);
  SHARED __d3_Prefiltered := __d3_UID_Mapped(UID <> 0);
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_4Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Date_Last_Seen_4Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Archive___Date_4Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000','0');
  SHARED __Mapping4 := 'UID(DEFAULT:UID),search_info.transaction_id(OVERRIDE:Transaction_I_D_:\'\'),search_info.sequence_number(OVERRIDE:Sequence_Number_:\'\'),search_info.method(OVERRIDE:Method_:\'\'),search_info.product_code(OVERRIDE:Product_Code_:0),search_info.function_description(OVERRIDE:Function_Description_:\'\'),permissions.glb_purpose(OVERRIDE:G_L_B_Purpose_:0),permissions.dppa_purpose(OVERRIDE:D_P_P_A_Purpose_:0),permissions.fcra_purpose(OVERRIDE:F_C_R_A_Purpose_:0),bus_intel.primary_market_code(OVERRIDE:Primary_Market_Code_:\'\'),bus_intel.secondary_market_code(OVERRIDE:Secondary_Market_Code_:\'\'),bus_intel.industry_1_code(OVERRIDE:Industry_Code1_:\'\'),bus_intel.industry_2_code(OVERRIDE:Industry_Code2_:\'\'),bus_intel.sub_market(OVERRIDE:Sub_Market_:\'\'),bus_intel.vertical(OVERRIDE:Vertical_:\'\'),bus_intel.industry(OVERRIDE:Industry_:\'\'),fraudpointscore(DEFAULT:Fraudpoint_Score_:0),person_q.fname(OVERRIDE:First_Name_:\'\'),person_q.lname(OVERRIDE:Last_Name_:\'\'),person_q.dob(OVERRIDE:Date_Of_Birth_:DATE),dobpadded(OVERRIDE:Date_Of_Birth_Padded_:\'\'),person_q.appended_adl(OVERRIDE:Lex_I_D_:0),person_q.prim_range(OVERRIDE:Primary_Range_:\'\'),person_q.predir(OVERRIDE:Predirectional_:\'\'),person_q.prim_name(OVERRIDE:Primary_Name_:\'\'),person_q.addr_suffix(OVERRIDE:Suffix_:\'\'),person_q.postdir(OVERRIDE:Postdirectional_:\'\'),person_q.sec_range(OVERRIDE:Secondary_Range_:\'\'),person_q.zip5(OVERRIDE:Z_I_P5_:\'\'),ssn(OVERRIDE:S_S_N_:\'\'),appendedssn(DEFAULT:Appended_S_S_N_:\'\'),person_q.personal_phone(OVERRIDE:Personal_Phone_Number_:0),person_q.work_phone(OVERRIDE:Work_Phone_Number_:0),person_q.email_address(OVERRIDE:Email_Address_:\'\'),companyname(DEFAULT:Company_Name_:\'\'),companyphone(DEFAULT:Company_Phone_:\'\'),tin(DEFAULT:T_I_N_:0),ultid(DEFAULT:Ult_I_D_:0),orgid(DEFAULT:Org_I_D_:0),seleid(DEFAULT:Sele_I_D_:0),src(OVERRIDE:Source_:\'\'),dateofinquiry(OVERRIDE:Date_First_Seen_:EPOCHTIMESTAMP:Date_First_Seen_4Rule|OVERRIDE:Date_Last_Seen_:EPOCHTIMESTAMP:Date_Last_Seen_4Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCHTIMESTAMP),archive_date(OVERRIDE:Archive___Date_:EPOCHTIMESTAMP:Archive___Date_4Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Inquiry_Table_SSN,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Inquiry_Table_SSN),SELF:=RIGHT));
  SHARED __d4_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Inquiry_AccLogs__Inquiry_Table_SSN);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d4_UID_Mapped := JOIN(__d4_Norm,Lookup,TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number) = RIGHT.KeyVal,TRANSFORM(__d4_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_SSN_Invalid := __d4_UID_Mapped(UID = 0);
  SHARED __d4_Prefiltered := __d4_UID_Mapped(UID <> 0);
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_5Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Date_Last_Seen_5Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Archive___Date_5Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000','0');
  SHARED __Mapping5 := 'UID(DEFAULT:UID),search_info.transaction_id(OVERRIDE:Transaction_I_D_:\'\'),search_info.sequence_number(OVERRIDE:Sequence_Number_:\'\'),search_info.method(OVERRIDE:Method_:\'\'),search_info.product_code(OVERRIDE:Product_Code_:0),search_info.function_description(OVERRIDE:Function_Description_:\'\'),permissions.glb_purpose(OVERRIDE:G_L_B_Purpose_:0),permissions.dppa_purpose(OVERRIDE:D_P_P_A_Purpose_:0),permissions.fcra_purpose(OVERRIDE:F_C_R_A_Purpose_:0),bus_intel.primary_market_code(OVERRIDE:Primary_Market_Code_:\'\'),bus_intel.secondary_market_code(OVERRIDE:Secondary_Market_Code_:\'\'),bus_intel.industry_1_code(OVERRIDE:Industry_Code1_:\'\'),bus_intel.industry_2_code(OVERRIDE:Industry_Code2_:\'\'),bus_intel.sub_market(OVERRIDE:Sub_Market_:\'\'),bus_intel.vertical(OVERRIDE:Vertical_:\'\'),bus_intel.industry(OVERRIDE:Industry_:\'\'),fraudpointscore(DEFAULT:Fraudpoint_Score_:0),person_q.fname(OVERRIDE:First_Name_:\'\'),person_q.lname(OVERRIDE:Last_Name_:\'\'),person_q.dob(OVERRIDE:Date_Of_Birth_:DATE),dobpadded(OVERRIDE:Date_Of_Birth_Padded_:\'\'),person_q.appended_adl(OVERRIDE:Lex_I_D_:0),person_q.prim_range(OVERRIDE:Primary_Range_:\'\'),person_q.predir(OVERRIDE:Predirectional_:\'\'),person_q.prim_name(OVERRIDE:Primary_Name_:\'\'),person_q.addr_suffix(OVERRIDE:Suffix_:\'\'),person_q.postdir(OVERRIDE:Postdirectional_:\'\'),person_q.sec_range(OVERRIDE:Secondary_Range_:\'\'),person_q.zip5(OVERRIDE:Z_I_P5_:\'\'),person_q.ssn(OVERRIDE:S_S_N_:\'\'),person_q.appended_ssn(OVERRIDE:Appended_S_S_N_:\'\'),person_q.personal_phone(OVERRIDE:Personal_Phone_Number_:0),person_q.work_phone(OVERRIDE:Work_Phone_Number_:0),person_q.email_address(OVERRIDE:Email_Address_:\'\'),companyname(DEFAULT:Company_Name_:\'\'),companyphone(DEFAULT:Company_Phone_:\'\'),tin(DEFAULT:T_I_N_:0),ultid(DEFAULT:Ult_I_D_:0),orgid(DEFAULT:Org_I_D_:0),seleid(DEFAULT:Sele_I_D_:0),src(OVERRIDE:Source_:\'\'),dateofinquiry(OVERRIDE:Date_First_Seen_:EPOCHTIMESTAMP:Date_First_Seen_5Rule|OVERRIDE:Date_Last_Seen_:EPOCHTIMESTAMP:Date_Last_Seen_5Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCHTIMESTAMP),archive_date(OVERRIDE:Archive___Date_:EPOCHTIMESTAMP:Archive___Date_5Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d5_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Inquiry_Table_Address,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Inquiry_Table_Address),SELF:=RIGHT));
  SHARED __d5_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Inquiry_AccLogs__Inquiry_Table_Address);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d5_UID_Mapped := JOIN(__d5_Norm,Lookup,TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number) = RIGHT.KeyVal,TRANSFORM(__d5_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_Address_Invalid := __d5_UID_Mapped(UID = 0);
  SHARED __d5_Prefiltered := __d5_UID_Mapped(UID <> 0);
  SHARED __d5 := __SourceFilter(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_6Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Date_Last_Seen_6Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Archive___Date_6Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000','0');
  SHARED __Mapping6 := 'UID(DEFAULT:UID),search_info.transaction_id(OVERRIDE:Transaction_I_D_:\'\'),search_info.sequence_number(OVERRIDE:Sequence_Number_:\'\'),search_info.method(OVERRIDE:Method_:\'\'),search_info.product_code(OVERRIDE:Product_Code_:0),search_info.function_description(OVERRIDE:Function_Description_:\'\'),permissions.glb_purpose(OVERRIDE:G_L_B_Purpose_:0),permissions.dppa_purpose(OVERRIDE:D_P_P_A_Purpose_:0),permissions.fcra_purpose(OVERRIDE:F_C_R_A_Purpose_:0),bus_intel.primary_market_code(OVERRIDE:Primary_Market_Code_:\'\'),bus_intel.secondary_market_code(OVERRIDE:Secondary_Market_Code_:\'\'),bus_intel.industry_1_code(OVERRIDE:Industry_Code1_:\'\'),bus_intel.industry_2_code(OVERRIDE:Industry_Code2_:\'\'),bus_intel.sub_market(OVERRIDE:Sub_Market_:\'\'),bus_intel.vertical(OVERRIDE:Vertical_:\'\'),bus_intel.industry(OVERRIDE:Industry_:\'\'),fraudpointscore(DEFAULT:Fraudpoint_Score_:0),person_q.fname(OVERRIDE:First_Name_:\'\'),person_q.lname(OVERRIDE:Last_Name_:\'\'),person_q.dob(OVERRIDE:Date_Of_Birth_:DATE),dobpadded(OVERRIDE:Date_Of_Birth_Padded_:\'\'),person_q.appended_adl(OVERRIDE:Lex_I_D_:0),person_q.prim_range(OVERRIDE:Primary_Range_:\'\'),person_q.predir(OVERRIDE:Predirectional_:\'\'),person_q.prim_name(OVERRIDE:Primary_Name_:\'\'),person_q.addr_suffix(OVERRIDE:Suffix_:\'\'),person_q.postdir(OVERRIDE:Postdirectional_:\'\'),person_q.sec_range(OVERRIDE:Secondary_Range_:\'\'),person_q.zip5(OVERRIDE:Z_I_P5_:\'\'),person_q.ssn(OVERRIDE:S_S_N_:\'\'),person_q.appended_ssn(OVERRIDE:Appended_S_S_N_:\'\'),person_q.personal_phone(OVERRIDE:Personal_Phone_Number_:0),person_q.work_phone(OVERRIDE:Work_Phone_Number_:0),person_q.email_address(OVERRIDE:Email_Address_:\'\'),companyname(DEFAULT:Company_Name_:\'\'),companyphone(DEFAULT:Company_Phone_:\'\'),tin(DEFAULT:T_I_N_:0),ultid(DEFAULT:Ult_I_D_:0),orgid(DEFAULT:Org_I_D_:0),seleid(DEFAULT:Sele_I_D_:0),src(OVERRIDE:Source_:\'\'),dateofinquiry(OVERRIDE:Date_First_Seen_:EPOCHTIMESTAMP:Date_First_Seen_6Rule|OVERRIDE:Date_Last_Seen_:EPOCHTIMESTAMP:Date_Last_Seen_6Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCHTIMESTAMP),archive_date(OVERRIDE:Archive___Date_:EPOCHTIMESTAMP:Archive___Date_6Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d6_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Inquiry_Table_DID,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Inquiry_Table_DID),SELF:=RIGHT));
  SHARED __d6_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Inquiry_AccLogs__Inquiry_Table_DID);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d6_UID_Mapped := JOIN(__d6_Norm,Lookup,TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number) = RIGHT.KeyVal,TRANSFORM(__d6_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_DID_Invalid := __d6_UID_Mapped(UID = 0);
  SHARED __d6_Prefiltered := __d6_UID_Mapped(UID <> 0);
  SHARED __d6 := __SourceFilter(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_7Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Date_Last_Seen_7Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Archive___Date_7Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000','0');
  SHARED __Mapping7 := 'UID(DEFAULT:UID),search_info.transaction_id(OVERRIDE:Transaction_I_D_:\'\'),search_info.sequence_number(OVERRIDE:Sequence_Number_:\'\'),search_info.method(OVERRIDE:Method_:\'\'),search_info.product_code(OVERRIDE:Product_Code_:0),search_info.function_description(OVERRIDE:Function_Description_:\'\'),glbpurpose(DEFAULT:G_L_B_Purpose_:0),dppapurpose(DEFAULT:D_P_P_A_Purpose_:0),fcrapurpose(DEFAULT:F_C_R_A_Purpose_:0),bus_intel.primary_market_code(OVERRIDE:Primary_Market_Code_:\'\'),bus_intel.secondary_market_code(OVERRIDE:Secondary_Market_Code_:\'\'),bus_intel.industry_1_code(OVERRIDE:Industry_Code1_:\'\'),bus_intel.industry_2_code(OVERRIDE:Industry_Code2_:\'\'),bus_intel.sub_market(OVERRIDE:Sub_Market_:\'\'),bus_intel.vertical(OVERRIDE:Vertical_:\'\'),bus_intel.industry(OVERRIDE:Industry_:\'\'),fraudpointscore(DEFAULT:Fraudpoint_Score_:0),person_q.fname(OVERRIDE:First_Name_:\'\'),person_q.lname(OVERRIDE:Last_Name_:\'\'),person_q.dob(OVERRIDE:Date_Of_Birth_:DATE),dobpadded(OVERRIDE:Date_Of_Birth_Padded_:\'\'),person_q.appended_adl(OVERRIDE:Lex_I_D_:0),person_q.prim_range(OVERRIDE:Primary_Range_:\'\'),person_q.predir(OVERRIDE:Predirectional_:\'\'),person_q.prim_name(OVERRIDE:Primary_Name_:\'\'),person_q.addr_suffix(OVERRIDE:Suffix_:\'\'),person_q.postdir(OVERRIDE:Postdirectional_:\'\'),person_q.sec_range(OVERRIDE:Secondary_Range_:\'\'),person_q.zip5(OVERRIDE:Z_I_P5_:\'\'),person_q.ssn(OVERRIDE:S_S_N_:\'\'),person_q.appended_ssn(OVERRIDE:Appended_S_S_N_:\'\'),person_q.personal_phone(OVERRIDE:Personal_Phone_Number_:0),person_q.work_phone(OVERRIDE:Work_Phone_Number_:0),person_q.email_address(OVERRIDE:Email_Address_:\'\'),companyname(DEFAULT:Company_Name_:\'\'),companyphone(DEFAULT:Company_Phone_:\'\'),tin(DEFAULT:T_I_N_:0),ultid(DEFAULT:Ult_I_D_:0),orgid(DEFAULT:Org_I_D_:0),seleid(DEFAULT:Sele_I_D_:0),src(OVERRIDE:Source_:\'\'),dateofinquiry(OVERRIDE:Date_First_Seen_:EPOCHTIMESTAMP:Date_First_Seen_7Rule|OVERRIDE:Date_Last_Seen_:EPOCHTIMESTAMP:Date_Last_Seen_7Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCHTIMESTAMP),archive_date(OVERRIDE:Archive___Date_:EPOCHTIMESTAMP:Archive___Date_7Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d7_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Inquiry_Table_EMAIL,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Inquiry_Table_EMAIL),SELF:=RIGHT));
  SHARED __d7_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Inquiry_AccLogs__Inquiry_Table_EMAIL);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d7_UID_Mapped := JOIN(__d7_Norm,Lookup,TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number) = RIGHT.KeyVal,TRANSFORM(__d7_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_EMAIL_Invalid := __d7_UID_Mapped(UID = 0);
  SHARED __d7_Prefiltered := __d7_UID_Mapped(UID <> 0);
  SHARED __d7 := __SourceFilter(KEL.FromFlat.Convert(__d7_Prefiltered,InLayout,__Mapping7,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_8Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Date_Last_Seen_8Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Archive___Date_8Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000','0');
  SHARED __Mapping8 := 'UID(DEFAULT:UID),search_info.transaction_id(OVERRIDE:Transaction_I_D_:\'\'),search_info.sequence_number(OVERRIDE:Sequence_Number_:\'\'),search_info.method(OVERRIDE:Method_:\'\'),search_info.product_code(OVERRIDE:Product_Code_:0),search_info.function_description(OVERRIDE:Function_Description_:\'\'),permissions.glb_purpose(OVERRIDE:G_L_B_Purpose_:0),permissions.dppa_purpose(OVERRIDE:D_P_P_A_Purpose_:0),permissions.fcra_purpose(OVERRIDE:F_C_R_A_Purpose_:0),bus_intel.primary_market_code(OVERRIDE:Primary_Market_Code_:\'\'),bus_intel.secondary_market_code(OVERRIDE:Secondary_Market_Code_:\'\'),bus_intel.industry_1_code(OVERRIDE:Industry_Code1_:\'\'),bus_intel.industry_2_code(OVERRIDE:Industry_Code2_:\'\'),bus_intel.sub_market(OVERRIDE:Sub_Market_:\'\'),bus_intel.vertical(OVERRIDE:Vertical_:\'\'),bus_intel.industry(OVERRIDE:Industry_:\'\'),fraudpointscore(DEFAULT:Fraudpoint_Score_:0),person_q.fname(OVERRIDE:First_Name_:\'\'),person_q.lname(OVERRIDE:Last_Name_:\'\'),person_q.dob(OVERRIDE:Date_Of_Birth_:DATE),dobpadded(OVERRIDE:Date_Of_Birth_Padded_:\'\'),person_q.appended_adl(OVERRIDE:Lex_I_D_:0),person_q.prim_range(OVERRIDE:Primary_Range_:\'\'),person_q.predir(OVERRIDE:Predirectional_:\'\'),person_q.prim_name(OVERRIDE:Primary_Name_:\'\'),person_q.addr_suffix(OVERRIDE:Suffix_:\'\'),person_q.postdir(OVERRIDE:Postdirectional_:\'\'),person_q.sec_range(OVERRIDE:Secondary_Range_:\'\'),person_q.zip5(OVERRIDE:Z_I_P5_:\'\'),person_q.ssn(OVERRIDE:S_S_N_:\'\'),person_q.appended_ssn(OVERRIDE:Appended_S_S_N_:\'\'),person_q.personal_phone(OVERRIDE:Personal_Phone_Number_:0),person_q.work_phone(OVERRIDE:Work_Phone_Number_:0),person_q.email_address(OVERRIDE:Email_Address_:\'\'),companyname(DEFAULT:Company_Name_:\'\'),companyphone(DEFAULT:Company_Phone_:\'\'),tin(DEFAULT:T_I_N_:0),ultid(DEFAULT:Ult_I_D_:0),orgid(DEFAULT:Org_I_D_:0),seleid(DEFAULT:Sele_I_D_:0),src(OVERRIDE:Source_:\'\'),dateofinquiry(OVERRIDE:Date_First_Seen_:EPOCHTIMESTAMP:Date_First_Seen_8Rule|OVERRIDE:Date_Last_Seen_:EPOCHTIMESTAMP:Date_Last_Seen_8Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCHTIMESTAMP),archive_date(OVERRIDE:Archive___Date_:EPOCHTIMESTAMP:Archive___Date_8Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d8_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Inquiry_Table_Phone,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Inquiry_Table_Phone),SELF:=RIGHT));
  SHARED __d8_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Inquiry_AccLogs__Inquiry_Table_Phone);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d8_UID_Mapped := JOIN(__d8_Norm,Lookup,TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number) = RIGHT.KeyVal,TRANSFORM(__d8_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_Phone_Invalid := __d8_UID_Mapped(UID = 0);
  SHARED __d8_Prefiltered := __d8_UID_Mapped(UID <> 0);
  SHARED __d8 := __SourceFilter(KEL.FromFlat.Convert(__d8_Prefiltered,InLayout,__Mapping8,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_9Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Date_Last_Seen_9Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Archive___Date_9Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000','0');
  SHARED __Mapping9 := 'UID(DEFAULT:UID),search_info.transaction_id(OVERRIDE:Transaction_I_D_:\'\'),search_info.sequence_number(OVERRIDE:Sequence_Number_:\'\'),search_info.method(OVERRIDE:Method_:\'\'),search_info.product_code(OVERRIDE:Product_Code_:0),search_info.function_description(OVERRIDE:Function_Description_:\'\'),permissions.glb_purpose(OVERRIDE:G_L_B_Purpose_:0),permissions.dppa_purpose(OVERRIDE:D_P_P_A_Purpose_:0),permissions.fcra_purpose(OVERRIDE:F_C_R_A_Purpose_:0),bus_intel.primary_market_code(OVERRIDE:Primary_Market_Code_:\'\'),bus_intel.secondary_market_code(OVERRIDE:Secondary_Market_Code_:\'\'),bus_intel.industry_1_code(OVERRIDE:Industry_Code1_:\'\'),bus_intel.industry_2_code(OVERRIDE:Industry_Code2_:\'\'),bus_intel.sub_market(OVERRIDE:Sub_Market_:\'\'),bus_intel.vertical(OVERRIDE:Vertical_:\'\'),bus_intel.industry(OVERRIDE:Industry_:\'\'),fraudpointscore(DEFAULT:Fraudpoint_Score_:0),bususer_q.fname(OVERRIDE:First_Name_:\'\'),bususer_q.lname(OVERRIDE:Last_Name_:\'\'),bususer_q.dob(OVERRIDE:Date_Of_Birth_:DATE),dobpadded(OVERRIDE:Date_Of_Birth_Padded_:\'\'),bususer_q.appended_adl(OVERRIDE:Lex_I_D_:0),bus_q.prim_range(OVERRIDE:Primary_Range_:\'\'),bus_q.predir(OVERRIDE:Predirectional_:\'\'),bus_q.prim_name(OVERRIDE:Primary_Name_:\'\'),bus_q.addr_suffix(OVERRIDE:Suffix_:\'\'),bus_q.postdir(OVERRIDE:Postdirectional_:\'\'),bus_q.sec_range(OVERRIDE:Secondary_Range_:\'\'),bus_q.zip5(OVERRIDE:Z_I_P5_:\'\'),bususer_q.ssn(OVERRIDE:S_S_N_:\'\'),bususer_q.appended_ssn(OVERRIDE:Appended_S_S_N_:\'\'),bususer_q.personal_phone(OVERRIDE:Personal_Phone_Number_:0),workphonenumber(DEFAULT:Work_Phone_Number_:0),emailaddress(DEFAULT:Email_Address_:\'\'),bus_q.cname(OVERRIDE:Company_Name_:\'\'),bus_q.company_phone(OVERRIDE:Company_Phone_:\'\'),appended_ein(OVERRIDE:T_I_N_:0),ultid(DEFAULT:Ult_I_D_:0),orgid(DEFAULT:Org_I_D_:0),seleid(DEFAULT:Sele_I_D_:0),src(OVERRIDE:Source_:\'\'),dateofinquiry(OVERRIDE:Date_First_Seen_:EPOCHTIMESTAMP:Date_First_Seen_9Rule|OVERRIDE:Date_Last_Seen_:EPOCHTIMESTAMP:Date_Last_Seen_9Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCHTIMESTAMP),archive_date(OVERRIDE:Archive___Date_:EPOCHTIMESTAMP:Archive___Date_9Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d9_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Inquiry_Table_FEIN,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Inquiry_Table_FEIN),SELF:=RIGHT));
  SHARED __d9_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Inquiry_AccLogs__Inquiry_Table_FEIN);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d9_UID_Mapped := JOIN(__d9_Norm,Lookup,TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number) = RIGHT.KeyVal,TRANSFORM(__d9_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_FEIN_1_Invalid := __d9_UID_Mapped(UID = 0);
  SHARED __d9_Prefiltered := __d9_UID_Mapped(UID <> 0);
  SHARED __d9 := __SourceFilter(KEL.FromFlat.Convert(__d9_Prefiltered,InLayout,__Mapping9,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_10Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Date_Last_Seen_10Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Archive___Date_10Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000','0');
  SHARED __Mapping10 := 'UID(DEFAULT:UID),search_info.transaction_id(OVERRIDE:Transaction_I_D_:\'\'),search_info.sequence_number(OVERRIDE:Sequence_Number_:\'\'),method(DEFAULT:Method_:\'\'),productcode(DEFAULT:Product_Code_:0),functiondescription(DEFAULT:Function_Description_:\'\'),glbpurpose(DEFAULT:G_L_B_Purpose_:0),dppapurpose(DEFAULT:D_P_P_A_Purpose_:0),fcrapurpose(DEFAULT:F_C_R_A_Purpose_:0),primarymarketcode(DEFAULT:Primary_Market_Code_:\'\'),secondarymarketcode(DEFAULT:Secondary_Market_Code_:\'\'),industrycode1(DEFAULT:Industry_Code1_:\'\'),industrycode2(DEFAULT:Industry_Code2_:\'\'),submarket(DEFAULT:Sub_Market_:\'\'),vertical(DEFAULT:Vertical_:\'\'),industry(DEFAULT:Industry_:\'\'),fraudpointscore(DEFAULT:Fraudpoint_Score_:0),firstname(DEFAULT:First_Name_:\'\'),lastname(DEFAULT:Last_Name_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),lexid(DEFAULT:Lex_I_D_:0),bususer_q.prim_range(OVERRIDE:Primary_Range_:\'\'),bususer_q.predir(OVERRIDE:Predirectional_:\'\'),bususer_q.prim_name(OVERRIDE:Primary_Name_:\'\'),bususer_q.addr_suffix(OVERRIDE:Suffix_:\'\'),bususer_q.postdir(OVERRIDE:Postdirectional_:\'\'),bususer_q.sec_range(OVERRIDE:Secondary_Range_:\'\'),bususer_q.zip5(OVERRIDE:Z_I_P5_:\'\'),ssn(DEFAULT:S_S_N_:\'\'),appendedssn(DEFAULT:Appended_S_S_N_:\'\'),personalphonenumber(DEFAULT:Personal_Phone_Number_:0),workphonenumber(DEFAULT:Work_Phone_Number_:0),emailaddress(DEFAULT:Email_Address_:\'\'),companyname(DEFAULT:Company_Name_:\'\'),companyphone(DEFAULT:Company_Phone_:\'\'),tin(DEFAULT:T_I_N_:0),ultid(DEFAULT:Ult_I_D_:0),orgid(DEFAULT:Org_I_D_:0),seleid(DEFAULT:Sele_I_D_:0),source(DEFAULT:Source_:\'\'),dateofinquiry(OVERRIDE:Date_First_Seen_:EPOCHTIMESTAMP:Date_First_Seen_10Rule|OVERRIDE:Date_Last_Seen_:EPOCHTIMESTAMP:Date_Last_Seen_10Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCHTIMESTAMP),archive_date(OVERRIDE:Archive___Date_:EPOCHTIMESTAMP:Archive___Date_10Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d10_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Inquiry_Table_FEIN,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Inquiry_Table_FEIN),SELF:=RIGHT));
  SHARED __d10_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Inquiry_AccLogs__Inquiry_Table_FEIN);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d10_UID_Mapped := JOIN(__d10_Norm,Lookup,TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number) = RIGHT.KeyVal,TRANSFORM(__d10_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_FEIN_2_Invalid := __d10_UID_Mapped(UID = 0);
  SHARED __d10_Prefiltered := __d10_UID_Mapped(UID <> 0);
  SHARED __d10 := __SourceFilter(KEL.FromFlat.Convert(__d10_Prefiltered,InLayout,__Mapping10,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_11Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Date_Last_Seen_11Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Archive___Date_11Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000','0');
  SHARED __Mapping11 := 'UID(DEFAULT:UID),search_info.transaction_id(OVERRIDE:Transaction_I_D_:\'\'),search_info.sequence_number(OVERRIDE:Sequence_Number_:\'\'),search_info.method(OVERRIDE:Method_:\'\'),search_info.product_code(OVERRIDE:Product_Code_:0),search_info.function_description(OVERRIDE:Function_Description_:\'\'),permissions.glb_purpose(OVERRIDE:G_L_B_Purpose_:0),permissions.dppa_purpose(OVERRIDE:D_P_P_A_Purpose_:0),permissions.fcra_purpose(OVERRIDE:F_C_R_A_Purpose_:0),bus_intel.primary_market_code(OVERRIDE:Primary_Market_Code_:\'\'),bus_intel.secondary_market_code(OVERRIDE:Secondary_Market_Code_:\'\'),bus_intel.industry_1_code(OVERRIDE:Industry_Code1_:\'\'),bus_intel.industry_2_code(OVERRIDE:Industry_Code2_:\'\'),bus_intel.sub_market(OVERRIDE:Sub_Market_:\'\'),bus_intel.vertical(OVERRIDE:Vertical_:\'\'),bus_intel.industry(OVERRIDE:Industry_:\'\'),fraudpointscore(DEFAULT:Fraudpoint_Score_:0),bususer_q.fname(OVERRIDE:First_Name_:\'\'),bususer_q.lname(OVERRIDE:Last_Name_:\'\'),bususer_q.dob(OVERRIDE:Date_Of_Birth_:DATE),dobpadded(OVERRIDE:Date_Of_Birth_Padded_:\'\'),bususer_q.appended_adl(OVERRIDE:Lex_I_D_:0),bus_q.prim_range(OVERRIDE:Primary_Range_:\'\'),bus_q.predir(OVERRIDE:Predirectional_:\'\'),bus_q.prim_name(OVERRIDE:Primary_Name_:\'\'),bus_q.addr_suffix(OVERRIDE:Suffix_:\'\'),bus_q.postdir(OVERRIDE:Postdirectional_:\'\'),bus_q.sec_range(OVERRIDE:Secondary_Range_:\'\'),bus_q.zip5(OVERRIDE:Z_I_P5_:\'\'),bususer_q.ssn(OVERRIDE:S_S_N_:\'\'),bususer_q.appended_ssn(OVERRIDE:Appended_S_S_N_:\'\'),bususer_q.personal_phone(OVERRIDE:Personal_Phone_Number_:0),workphonenumber(DEFAULT:Work_Phone_Number_:0),emailaddress(DEFAULT:Email_Address_:\'\'),bus_q.cname(OVERRIDE:Company_Name_:\'\'),bus_q.company_phone(OVERRIDE:Company_Phone_:\'\'),bus_q.appended_ein(OVERRIDE:T_I_N_:0),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),src(OVERRIDE:Source_:\'\'),dateofinquiry(OVERRIDE:Date_First_Seen_:EPOCHTIMESTAMP:Date_First_Seen_11Rule|OVERRIDE:Date_Last_Seen_:EPOCHTIMESTAMP:Date_Last_Seen_11Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCHTIMESTAMP),archive_date(OVERRIDE:Archive___Date_:EPOCHTIMESTAMP:Archive___Date_11Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d11_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Inquiry_Table_LinkIDs,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Inquiry_Table_LinkIDs),SELF:=RIGHT));
  SHARED __d11_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Inquiry_AccLogs__Inquiry_Table_LinkIDs);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d11_UID_Mapped := JOIN(__d11_Norm,Lookup,TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number) = RIGHT.KeyVal,TRANSFORM(__d11_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_LinkIDs_1_Invalid := __d11_UID_Mapped(UID = 0);
  SHARED __d11_Prefiltered := __d11_UID_Mapped(UID <> 0);
  SHARED __d11 := __SourceFilter(KEL.FromFlat.Convert(__d11_Prefiltered,InLayout,__Mapping11,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_12Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Date_Last_Seen_12Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Archive___Date_12Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000','0');
  SHARED __Mapping12 := 'UID(DEFAULT:UID),search_info.transaction_id(OVERRIDE:Transaction_I_D_:\'\'),search_info.sequence_number(OVERRIDE:Sequence_Number_:\'\'),method(DEFAULT:Method_:\'\'),productcode(DEFAULT:Product_Code_:0),functiondescription(DEFAULT:Function_Description_:\'\'),glbpurpose(DEFAULT:G_L_B_Purpose_:0),dppapurpose(DEFAULT:D_P_P_A_Purpose_:0),fcrapurpose(DEFAULT:F_C_R_A_Purpose_:0),primarymarketcode(DEFAULT:Primary_Market_Code_:\'\'),secondarymarketcode(DEFAULT:Secondary_Market_Code_:\'\'),industrycode1(DEFAULT:Industry_Code1_:\'\'),industrycode2(DEFAULT:Industry_Code2_:\'\'),submarket(DEFAULT:Sub_Market_:\'\'),vertical(DEFAULT:Vertical_:\'\'),industry(DEFAULT:Industry_:\'\'),fraudpointscore(DEFAULT:Fraudpoint_Score_:0),firstname(DEFAULT:First_Name_:\'\'),lastname(DEFAULT:Last_Name_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),lexid(DEFAULT:Lex_I_D_:0),bususer_q.prim_range(OVERRIDE:Primary_Range_:\'\'),bususer_q.predir(OVERRIDE:Predirectional_:\'\'),bususer_q.prim_name(OVERRIDE:Primary_Name_:\'\'),bususer_q.addr_suffix(OVERRIDE:Suffix_:\'\'),bususer_q.postdir(OVERRIDE:Postdirectional_:\'\'),bususer_q.sec_range(OVERRIDE:Secondary_Range_:\'\'),bususer_q.zip5(OVERRIDE:Z_I_P5_:\'\'),ssn(DEFAULT:S_S_N_:\'\'),appendedssn(DEFAULT:Appended_S_S_N_:\'\'),personalphonenumber(DEFAULT:Personal_Phone_Number_:0),workphonenumber(DEFAULT:Work_Phone_Number_:0),emailaddress(DEFAULT:Email_Address_:\'\'),companyname(DEFAULT:Company_Name_:\'\'),companyphone(DEFAULT:Company_Phone_:\'\'),tin(DEFAULT:T_I_N_:0),ultid(DEFAULT:Ult_I_D_:0),orgid(DEFAULT:Org_I_D_:0),seleid(DEFAULT:Sele_I_D_:0),source(DEFAULT:Source_:\'\'),dateofinquiry(OVERRIDE:Date_First_Seen_:EPOCHTIMESTAMP:Date_First_Seen_12Rule|OVERRIDE:Date_Last_Seen_:EPOCHTIMESTAMP:Date_Last_Seen_12Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCHTIMESTAMP),archive_date(OVERRIDE:Archive___Date_:EPOCHTIMESTAMP:Archive___Date_12Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d12_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Inquiry_Table_LinkIDs,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Inquiry_Table_LinkIDs),SELF:=RIGHT));
  SHARED __d12_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Inquiry_AccLogs__Inquiry_Table_LinkIDs);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d12_UID_Mapped := JOIN(__d12_Norm,Lookup,TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number) = RIGHT.KeyVal,TRANSFORM(__d12_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_LinkIDs_2_Invalid := __d12_UID_Mapped(UID = 0);
  SHARED __d12_Prefiltered := __d12_UID_Mapped(UID <> 0);
  SHARED __d12 := __SourceFilter(KEL.FromFlat.Convert(__d12_Prefiltered,InLayout,__Mapping12,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6 + __d7 + __d8 + __d9 + __d10 + __d11 + __d12;
  EXPORT Search_Info_Layout := RECORD
    KEL.typ.nstr Method_;
    KEL.typ.nint Product_Code_;
    KEL.typ.nstr Function_Description_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Permissions_Layout := RECORD
    KEL.typ.nint G_L_B_Purpose_;
    KEL.typ.nint D_P_P_A_Purpose_;
    KEL.typ.nint F_C_R_A_Purpose_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Bus_Intel_Layout := RECORD
    KEL.typ.nstr Primary_Market_Code_;
    KEL.typ.nstr Secondary_Market_Code_;
    KEL.typ.nstr Industry_Code1_;
    KEL.typ.nstr Industry_Code2_;
    KEL.typ.nstr Sub_Market_;
    KEL.typ.nstr Vertical_;
    KEL.typ.nstr Industry_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Person_Info_Layout := RECORD
    KEL.typ.nint Lex_I_D_;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Date_Of_Birth_Padded_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Z_I_P5_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr S_S_N_;
    KEL.typ.nstr Appended_S_S_N_;
    KEL.typ.nint Personal_Phone_Number_;
    KEL.typ.nint Work_Phone_Number_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Business_Info_Layout := RECORD
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Company_Name_;
    KEL.typ.nstr Company_Phone_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Z_I_P5_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nint T_I_N_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.ndataset(Search_Info_Layout) Search_Info_;
    KEL.typ.ndataset(Permissions_Layout) Permissions_;
    KEL.typ.ndataset(Bus_Intel_Layout) Bus_Intel_;
    KEL.typ.ndataset(Person_Info_Layout) Person_Info_;
    KEL.typ.ndataset(Business_Info_Layout) Business_Info_;
    KEL.typ.nint Fraudpoint_Score_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Inquiry_Group := __PostFilter;
  Layout Inquiry__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Transaction_I_D_ := KEL.Intake.SingleValue(__recs,Transaction_I_D_);
    SELF.Sequence_Number_ := KEL.Intake.SingleValue(__recs,Sequence_Number_);
    SELF.Search_Info_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.timestamp Archive___Date_ := KEL.era.SimpleRollTimestamp(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.timestamp Date_First_Seen_ := KEL.era.SimpleRollTimestamp(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.timestamp Date_Last_Seen_ := KEL.era.SimpleRollTimestamp(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.timestamp Hybrid_Archive_Date_ := KEL.era.SimpleRollTimestamp(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Method_,Product_Code_,Function_Description_},Method_,Product_Code_,Function_Description_),Search_Info_Layout)(__NN(Method_) OR __NN(Product_Code_) OR __NN(Function_Description_)));
    SELF.Permissions_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.timestamp Archive___Date_ := KEL.era.SimpleRollTimestamp(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.timestamp Date_First_Seen_ := KEL.era.SimpleRollTimestamp(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.timestamp Date_Last_Seen_ := KEL.era.SimpleRollTimestamp(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.timestamp Hybrid_Archive_Date_ := KEL.era.SimpleRollTimestamp(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),G_L_B_Purpose_,D_P_P_A_Purpose_,F_C_R_A_Purpose_},G_L_B_Purpose_,D_P_P_A_Purpose_,F_C_R_A_Purpose_),Permissions_Layout)(__NN(G_L_B_Purpose_) OR __NN(D_P_P_A_Purpose_) OR __NN(F_C_R_A_Purpose_)));
    SELF.Bus_Intel_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.timestamp Archive___Date_ := KEL.era.SimpleRollTimestamp(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.timestamp Date_First_Seen_ := KEL.era.SimpleRollTimestamp(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.timestamp Date_Last_Seen_ := KEL.era.SimpleRollTimestamp(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.timestamp Hybrid_Archive_Date_ := KEL.era.SimpleRollTimestamp(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Primary_Market_Code_,Secondary_Market_Code_,Industry_Code1_,Industry_Code2_,Sub_Market_,Vertical_,Industry_},Primary_Market_Code_,Secondary_Market_Code_,Industry_Code1_,Industry_Code2_,Sub_Market_,Vertical_,Industry_),Bus_Intel_Layout)(__NN(Primary_Market_Code_) OR __NN(Secondary_Market_Code_) OR __NN(Industry_Code1_) OR __NN(Industry_Code2_) OR __NN(Sub_Market_) OR __NN(Vertical_) OR __NN(Industry_)));
    SELF.Person_Info_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.timestamp Archive___Date_ := KEL.era.SimpleRollTimestamp(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.timestamp Date_First_Seen_ := KEL.era.SimpleRollTimestamp(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.timestamp Date_Last_Seen_ := KEL.era.SimpleRollTimestamp(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.timestamp Hybrid_Archive_Date_ := KEL.era.SimpleRollTimestamp(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Lex_I_D_,First_Name_,Last_Name_,Date_Of_Birth_,Date_Of_Birth_Padded_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Z_I_P5_,Secondary_Range_,S_S_N_,Appended_S_S_N_,Personal_Phone_Number_,Work_Phone_Number_,Email_Address_},Lex_I_D_,First_Name_,Last_Name_,Date_Of_Birth_,Date_Of_Birth_Padded_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Z_I_P5_,Secondary_Range_,S_S_N_,Appended_S_S_N_,Personal_Phone_Number_,Work_Phone_Number_,Email_Address_),Person_Info_Layout)(__NN(Lex_I_D_) OR __NN(First_Name_) OR __NN(Last_Name_) OR __NN(Date_Of_Birth_) OR __NN(Date_Of_Birth_Padded_) OR __NN(Primary_Range_) OR __NN(Predirectional_) OR __NN(Primary_Name_) OR __NN(Suffix_) OR __NN(Postdirectional_) OR __NN(Z_I_P5_) OR __NN(Secondary_Range_) OR __NN(S_S_N_) OR __NN(Appended_S_S_N_) OR __NN(Personal_Phone_Number_) OR __NN(Work_Phone_Number_) OR __NN(Email_Address_)));
    SELF.Business_Info_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.timestamp Archive___Date_ := KEL.era.SimpleRollTimestamp(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.timestamp Date_First_Seen_ := KEL.era.SimpleRollTimestamp(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.timestamp Date_Last_Seen_ := KEL.era.SimpleRollTimestamp(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.timestamp Hybrid_Archive_Date_ := KEL.era.SimpleRollTimestamp(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Ult_I_D_,Org_I_D_,Sele_I_D_,Company_Name_,Company_Phone_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Z_I_P5_,Secondary_Range_,T_I_N_},Ult_I_D_,Org_I_D_,Sele_I_D_,Company_Name_,Company_Phone_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Z_I_P5_,Secondary_Range_,T_I_N_),Business_Info_Layout)(__NN(Ult_I_D_) OR __NN(Org_I_D_) OR __NN(Sele_I_D_) OR __NN(Company_Name_) OR __NN(Company_Phone_) OR __NN(Primary_Range_) OR __NN(Predirectional_) OR __NN(Primary_Name_) OR __NN(Suffix_) OR __NN(Postdirectional_) OR __NN(Z_I_P5_) OR __NN(Secondary_Range_) OR __NN(T_I_N_)));
    SELF.Fraudpoint_Score_ := KEL.Intake.SingleValue(__recs,Fraudpoint_Score_);
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.timestamp Archive___Date_ := KEL.era.SimpleRollTimestamp(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.timestamp Date_First_Seen_ := KEL.era.SimpleRollTimestamp(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.timestamp Date_Last_Seen_ := KEL.era.SimpleRollTimestamp(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.timestamp Hybrid_Archive_Date_ := KEL.era.SimpleRollTimestamp(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRollTimestamp(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollTimestamp(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollTimestamp(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollTimestamp(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Inquiry__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Search_Info_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Search_Info_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Method_) OR __NN(Product_Code_) OR __NN(Function_Description_)));
    SELF.Permissions_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Permissions_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(G_L_B_Purpose_) OR __NN(D_P_P_A_Purpose_) OR __NN(F_C_R_A_Purpose_)));
    SELF.Bus_Intel_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Bus_Intel_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Primary_Market_Code_) OR __NN(Secondary_Market_Code_) OR __NN(Industry_Code1_) OR __NN(Industry_Code2_) OR __NN(Sub_Market_) OR __NN(Vertical_) OR __NN(Industry_)));
    SELF.Person_Info_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Person_Info_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Lex_I_D_) OR __NN(First_Name_) OR __NN(Last_Name_) OR __NN(Date_Of_Birth_) OR __NN(Date_Of_Birth_Padded_) OR __NN(Primary_Range_) OR __NN(Predirectional_) OR __NN(Primary_Name_) OR __NN(Suffix_) OR __NN(Postdirectional_) OR __NN(Z_I_P5_) OR __NN(Secondary_Range_) OR __NN(S_S_N_) OR __NN(Appended_S_S_N_) OR __NN(Personal_Phone_Number_) OR __NN(Work_Phone_Number_) OR __NN(Email_Address_)));
    SELF.Business_Info_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Business_Info_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Ult_I_D_) OR __NN(Org_I_D_) OR __NN(Sele_I_D_) OR __NN(Company_Name_) OR __NN(Company_Phone_) OR __NN(Primary_Range_) OR __NN(Predirectional_) OR __NN(Primary_Name_) OR __NN(Suffix_) OR __NN(Postdirectional_) OR __NN(Z_I_P5_) OR __NN(Secondary_Range_) OR __NN(T_I_N_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRowTimestamp(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRowTimestamp(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRowTimestamp(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRowTimestamp(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Inquiry_Group,COUNT(ROWS(LEFT))=1),GROUP,Inquiry__Single_Rollup(LEFT)) + ROLLUP(HAVING(Inquiry_Group,COUNT(ROWS(LEFT))>1),GROUP,Inquiry__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Transaction_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Transaction_I_D_);
  EXPORT Sequence_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Sequence_Number_);
  EXPORT Fraudpoint_Score__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Fraudpoint_Score_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_DID_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_Phone_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_Address_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_SSN_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_SSN_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_Address_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_DID_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_EMAIL_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_Phone_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_FEIN_1_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_FEIN_2_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_LinkIDs_1_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_LinkIDs_2_Invalid),COUNT(Transaction_I_D__SingleValue_Invalid),COUNT(Sequence_Number__SingleValue_Invalid),COUNT(Fraudpoint_Score__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_DID_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_Phone_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_Address_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_SSN_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_SSN_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_Address_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_DID_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_EMAIL_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_Phone_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_FEIN_1_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_FEIN_2_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_LinkIDs_1_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_LinkIDs_2_Invalid,KEL.typ.int Transaction_I_D__SingleValue_Invalid,KEL.typ.int Sequence_Number__SingleValue_Invalid,KEL.typ.int Fraudpoint_Score__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_DID_Invalid),COUNT(__d0)},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.transaction_id',COUNT(__d0(__NL(Transaction_I_D_))),COUNT(__d0(__NN(Transaction_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.sequence_number',COUNT(__d0(__NL(Sequence_Number_))),COUNT(__d0(__NN(Sequence_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.method',COUNT(__d0(__NL(Method_))),COUNT(__d0(__NN(Method_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.product_code',COUNT(__d0(__NL(Product_Code_))),COUNT(__d0(__NN(Product_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.function_description',COUNT(__d0(__NL(Function_Description_))),COUNT(__d0(__NN(Function_Description_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.glb_purpose',COUNT(__d0(__NL(G_L_B_Purpose_))),COUNT(__d0(__NN(G_L_B_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.dppa_purpose',COUNT(__d0(__NL(D_P_P_A_Purpose_))),COUNT(__d0(__NN(D_P_P_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.fcra_purpose',COUNT(__d0(__NL(F_C_R_A_Purpose_))),COUNT(__d0(__NN(F_C_R_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.primary_market_code',COUNT(__d0(__NL(Primary_Market_Code_))),COUNT(__d0(__NN(Primary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.secondary_market_code',COUNT(__d0(__NL(Secondary_Market_Code_))),COUNT(__d0(__NN(Secondary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry_1_code',COUNT(__d0(__NL(Industry_Code1_))),COUNT(__d0(__NN(Industry_Code1_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry_2_code',COUNT(__d0(__NL(Industry_Code2_))),COUNT(__d0(__NN(Industry_Code2_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.sub_market',COUNT(__d0(__NL(Sub_Market_))),COUNT(__d0(__NN(Sub_Market_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.vertical',COUNT(__d0(__NL(Vertical_))),COUNT(__d0(__NN(Vertical_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry',COUNT(__d0(__NL(Industry_))),COUNT(__d0(__NN(Industry_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FraudpointScore',COUNT(__d0(__NL(Fraudpoint_Score_))),COUNT(__d0(__NN(Fraudpoint_Score_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.fname',COUNT(__d0(__NL(First_Name_))),COUNT(__d0(__NN(First_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.lname',COUNT(__d0(__NL(Last_Name_))),COUNT(__d0(__NN(Last_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.dob',COUNT(__d0(__NL(Date_Of_Birth_))),COUNT(__d0(__NN(Date_Of_Birth_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DOBPadded',COUNT(__d0(__NL(Date_Of_Birth_Padded_))),COUNT(__d0(__NN(Date_Of_Birth_Padded_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.appended_adl',COUNT(__d0(__NL(Lex_I_D_))),COUNT(__d0(__NN(Lex_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_range',COUNT(__d0(__NL(Primary_Range_))),COUNT(__d0(__NN(Primary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.predir',COUNT(__d0(__NL(Predirectional_))),COUNT(__d0(__NN(Predirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_name',COUNT(__d0(__NL(Primary_Name_))),COUNT(__d0(__NN(Primary_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.addr_suffix',COUNT(__d0(__NL(Suffix_))),COUNT(__d0(__NN(Suffix_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.postdir',COUNT(__d0(__NL(Postdirectional_))),COUNT(__d0(__NN(Postdirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.sec_range',COUNT(__d0(__NL(Secondary_Range_))),COUNT(__d0(__NN(Secondary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.zip5',COUNT(__d0(__NL(Z_I_P5_))),COUNT(__d0(__NN(Z_I_P5_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.ssn',COUNT(__d0(__NL(S_S_N_))),COUNT(__d0(__NN(S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.appended_ssn',COUNT(__d0(__NL(Appended_S_S_N_))),COUNT(__d0(__NN(Appended_S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.personal_phone',COUNT(__d0(__NL(Personal_Phone_Number_))),COUNT(__d0(__NN(Personal_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.work_phone',COUNT(__d0(__NL(Work_Phone_Number_))),COUNT(__d0(__NN(Work_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.email_address',COUNT(__d0(__NL(Email_Address_))),COUNT(__d0(__NN(Email_Address_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyName',COUNT(__d0(__NL(Company_Name_))),COUNT(__d0(__NN(Company_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyPhone',COUNT(__d0(__NL(Company_Phone_))),COUNT(__d0(__NN(Company_Phone_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TIN',COUNT(__d0(__NL(T_I_N_))),COUNT(__d0(__NN(T_I_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltID',COUNT(__d0(__NL(Ult_I_D_))),COUNT(__d0(__NN(Ult_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgID',COUNT(__d0(__NL(Org_I_D_))),COUNT(__d0(__NN(Org_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleID',COUNT(__d0(__NL(Sele_I_D_))),COUNT(__d0(__NN(Sele_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_Phone_Invalid),COUNT(__d1)},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.transaction_id',COUNT(__d1(__NL(Transaction_I_D_))),COUNT(__d1(__NN(Transaction_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.sequence_number',COUNT(__d1(__NL(Sequence_Number_))),COUNT(__d1(__NN(Sequence_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.method',COUNT(__d1(__NL(Method_))),COUNT(__d1(__NN(Method_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.product_code',COUNT(__d1(__NL(Product_Code_))),COUNT(__d1(__NN(Product_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.function_description',COUNT(__d1(__NL(Function_Description_))),COUNT(__d1(__NN(Function_Description_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.glb_purpose',COUNT(__d1(__NL(G_L_B_Purpose_))),COUNT(__d1(__NN(G_L_B_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.dppa_purpose',COUNT(__d1(__NL(D_P_P_A_Purpose_))),COUNT(__d1(__NN(D_P_P_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.fcra_purpose',COUNT(__d1(__NL(F_C_R_A_Purpose_))),COUNT(__d1(__NN(F_C_R_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.primary_market_code',COUNT(__d1(__NL(Primary_Market_Code_))),COUNT(__d1(__NN(Primary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.secondary_market_code',COUNT(__d1(__NL(Secondary_Market_Code_))),COUNT(__d1(__NN(Secondary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry_1_code',COUNT(__d1(__NL(Industry_Code1_))),COUNT(__d1(__NN(Industry_Code1_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry_2_code',COUNT(__d1(__NL(Industry_Code2_))),COUNT(__d1(__NN(Industry_Code2_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.sub_market',COUNT(__d1(__NL(Sub_Market_))),COUNT(__d1(__NN(Sub_Market_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.vertical',COUNT(__d1(__NL(Vertical_))),COUNT(__d1(__NN(Vertical_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry',COUNT(__d1(__NL(Industry_))),COUNT(__d1(__NN(Industry_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FraudpointScore',COUNT(__d1(__NL(Fraudpoint_Score_))),COUNT(__d1(__NN(Fraudpoint_Score_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.fname',COUNT(__d1(__NL(First_Name_))),COUNT(__d1(__NN(First_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.lname',COUNT(__d1(__NL(Last_Name_))),COUNT(__d1(__NN(Last_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.dob',COUNT(__d1(__NL(Date_Of_Birth_))),COUNT(__d1(__NN(Date_Of_Birth_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DOBPadded',COUNT(__d1(__NL(Date_Of_Birth_Padded_))),COUNT(__d1(__NN(Date_Of_Birth_Padded_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.appended_adl',COUNT(__d1(__NL(Lex_I_D_))),COUNT(__d1(__NN(Lex_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_range',COUNT(__d1(__NL(Primary_Range_))),COUNT(__d1(__NN(Primary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.predir',COUNT(__d1(__NL(Predirectional_))),COUNT(__d1(__NN(Predirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_name',COUNT(__d1(__NL(Primary_Name_))),COUNT(__d1(__NN(Primary_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.addr_suffix',COUNT(__d1(__NL(Suffix_))),COUNT(__d1(__NN(Suffix_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.postdir',COUNT(__d1(__NL(Postdirectional_))),COUNT(__d1(__NN(Postdirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.sec_range',COUNT(__d1(__NL(Secondary_Range_))),COUNT(__d1(__NN(Secondary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.zip5',COUNT(__d1(__NL(Z_I_P5_))),COUNT(__d1(__NN(Z_I_P5_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.ssn',COUNT(__d1(__NL(S_S_N_))),COUNT(__d1(__NN(S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.appended_ssn',COUNT(__d1(__NL(Appended_S_S_N_))),COUNT(__d1(__NN(Appended_S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.personal_phone',COUNT(__d1(__NL(Personal_Phone_Number_))),COUNT(__d1(__NN(Personal_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.work_phone',COUNT(__d1(__NL(Work_Phone_Number_))),COUNT(__d1(__NN(Work_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.email_address',COUNT(__d1(__NL(Email_Address_))),COUNT(__d1(__NN(Email_Address_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyName',COUNT(__d1(__NL(Company_Name_))),COUNT(__d1(__NN(Company_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyPhone',COUNT(__d1(__NL(Company_Phone_))),COUNT(__d1(__NN(Company_Phone_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TIN',COUNT(__d1(__NL(T_I_N_))),COUNT(__d1(__NN(T_I_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltID',COUNT(__d1(__NL(Ult_I_D_))),COUNT(__d1(__NN(Ult_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgID',COUNT(__d1(__NL(Org_I_D_))),COUNT(__d1(__NN(Org_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleID',COUNT(__d1(__NL(Sele_I_D_))),COUNT(__d1(__NN(Sele_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_Address_Invalid),COUNT(__d2)},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.transaction_id',COUNT(__d2(__NL(Transaction_I_D_))),COUNT(__d2(__NN(Transaction_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.sequence_number',COUNT(__d2(__NL(Sequence_Number_))),COUNT(__d2(__NN(Sequence_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.method',COUNT(__d2(__NL(Method_))),COUNT(__d2(__NN(Method_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.product_code',COUNT(__d2(__NL(Product_Code_))),COUNT(__d2(__NN(Product_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.function_description',COUNT(__d2(__NL(Function_Description_))),COUNT(__d2(__NN(Function_Description_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.glb_purpose',COUNT(__d2(__NL(G_L_B_Purpose_))),COUNT(__d2(__NN(G_L_B_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.dppa_purpose',COUNT(__d2(__NL(D_P_P_A_Purpose_))),COUNT(__d2(__NN(D_P_P_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.fcra_purpose',COUNT(__d2(__NL(F_C_R_A_Purpose_))),COUNT(__d2(__NN(F_C_R_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.primary_market_code',COUNT(__d2(__NL(Primary_Market_Code_))),COUNT(__d2(__NN(Primary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.secondary_market_code',COUNT(__d2(__NL(Secondary_Market_Code_))),COUNT(__d2(__NN(Secondary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry_1_code',COUNT(__d2(__NL(Industry_Code1_))),COUNT(__d2(__NN(Industry_Code1_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry_2_code',COUNT(__d2(__NL(Industry_Code2_))),COUNT(__d2(__NN(Industry_Code2_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.sub_market',COUNT(__d2(__NL(Sub_Market_))),COUNT(__d2(__NN(Sub_Market_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.vertical',COUNT(__d2(__NL(Vertical_))),COUNT(__d2(__NN(Vertical_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry',COUNT(__d2(__NL(Industry_))),COUNT(__d2(__NN(Industry_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FraudpointScore',COUNT(__d2(__NL(Fraudpoint_Score_))),COUNT(__d2(__NN(Fraudpoint_Score_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.fname',COUNT(__d2(__NL(First_Name_))),COUNT(__d2(__NN(First_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.lname',COUNT(__d2(__NL(Last_Name_))),COUNT(__d2(__NN(Last_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.dob',COUNT(__d2(__NL(Date_Of_Birth_))),COUNT(__d2(__NN(Date_Of_Birth_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DOBPadded',COUNT(__d2(__NL(Date_Of_Birth_Padded_))),COUNT(__d2(__NN(Date_Of_Birth_Padded_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.appended_adl',COUNT(__d2(__NL(Lex_I_D_))),COUNT(__d2(__NN(Lex_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_range',COUNT(__d2(__NL(Primary_Range_))),COUNT(__d2(__NN(Primary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.predir',COUNT(__d2(__NL(Predirectional_))),COUNT(__d2(__NN(Predirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_name',COUNT(__d2(__NL(Primary_Name_))),COUNT(__d2(__NN(Primary_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.addr_suffix',COUNT(__d2(__NL(Suffix_))),COUNT(__d2(__NN(Suffix_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.postdir',COUNT(__d2(__NL(Postdirectional_))),COUNT(__d2(__NN(Postdirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.sec_range',COUNT(__d2(__NL(Secondary_Range_))),COUNT(__d2(__NN(Secondary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.zip5',COUNT(__d2(__NL(Z_I_P5_))),COUNT(__d2(__NN(Z_I_P5_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.ssn',COUNT(__d2(__NL(S_S_N_))),COUNT(__d2(__NN(S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.appended_ssn',COUNT(__d2(__NL(Appended_S_S_N_))),COUNT(__d2(__NN(Appended_S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.personal_phone',COUNT(__d2(__NL(Personal_Phone_Number_))),COUNT(__d2(__NN(Personal_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.work_phone',COUNT(__d2(__NL(Work_Phone_Number_))),COUNT(__d2(__NN(Work_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.email_address',COUNT(__d2(__NL(Email_Address_))),COUNT(__d2(__NN(Email_Address_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyName',COUNT(__d2(__NL(Company_Name_))),COUNT(__d2(__NN(Company_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyPhone',COUNT(__d2(__NL(Company_Phone_))),COUNT(__d2(__NN(Company_Phone_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TIN',COUNT(__d2(__NL(T_I_N_))),COUNT(__d2(__NN(T_I_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltID',COUNT(__d2(__NL(Ult_I_D_))),COUNT(__d2(__NN(Ult_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgID',COUNT(__d2(__NL(Org_I_D_))),COUNT(__d2(__NN(Org_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleID',COUNT(__d2(__NL(Sele_I_D_))),COUNT(__d2(__NN(Sele_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_SSN_Invalid),COUNT(__d3)},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.transaction_id',COUNT(__d3(__NL(Transaction_I_D_))),COUNT(__d3(__NN(Transaction_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.sequence_number',COUNT(__d3(__NL(Sequence_Number_))),COUNT(__d3(__NN(Sequence_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.method',COUNT(__d3(__NL(Method_))),COUNT(__d3(__NN(Method_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.product_code',COUNT(__d3(__NL(Product_Code_))),COUNT(__d3(__NN(Product_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.function_description',COUNT(__d3(__NL(Function_Description_))),COUNT(__d3(__NN(Function_Description_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.glb_purpose',COUNT(__d3(__NL(G_L_B_Purpose_))),COUNT(__d3(__NN(G_L_B_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.dppa_purpose',COUNT(__d3(__NL(D_P_P_A_Purpose_))),COUNT(__d3(__NN(D_P_P_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.fcra_purpose',COUNT(__d3(__NL(F_C_R_A_Purpose_))),COUNT(__d3(__NN(F_C_R_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.primary_market_code',COUNT(__d3(__NL(Primary_Market_Code_))),COUNT(__d3(__NN(Primary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.secondary_market_code',COUNT(__d3(__NL(Secondary_Market_Code_))),COUNT(__d3(__NN(Secondary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry_1_code',COUNT(__d3(__NL(Industry_Code1_))),COUNT(__d3(__NN(Industry_Code1_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry_2_code',COUNT(__d3(__NL(Industry_Code2_))),COUNT(__d3(__NN(Industry_Code2_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.sub_market',COUNT(__d3(__NL(Sub_Market_))),COUNT(__d3(__NN(Sub_Market_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.vertical',COUNT(__d3(__NL(Vertical_))),COUNT(__d3(__NN(Vertical_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry',COUNT(__d3(__NL(Industry_))),COUNT(__d3(__NN(Industry_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FraudpointScore',COUNT(__d3(__NL(Fraudpoint_Score_))),COUNT(__d3(__NN(Fraudpoint_Score_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.fname',COUNT(__d3(__NL(First_Name_))),COUNT(__d3(__NN(First_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.lname',COUNT(__d3(__NL(Last_Name_))),COUNT(__d3(__NN(Last_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.dob',COUNT(__d3(__NL(Date_Of_Birth_))),COUNT(__d3(__NN(Date_Of_Birth_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DOBPadded',COUNT(__d3(__NL(Date_Of_Birth_Padded_))),COUNT(__d3(__NN(Date_Of_Birth_Padded_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.appended_adl',COUNT(__d3(__NL(Lex_I_D_))),COUNT(__d3(__NN(Lex_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_range',COUNT(__d3(__NL(Primary_Range_))),COUNT(__d3(__NN(Primary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.predir',COUNT(__d3(__NL(Predirectional_))),COUNT(__d3(__NN(Predirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_name',COUNT(__d3(__NL(Primary_Name_))),COUNT(__d3(__NN(Primary_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.addr_suffix',COUNT(__d3(__NL(Suffix_))),COUNT(__d3(__NN(Suffix_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.postdir',COUNT(__d3(__NL(Postdirectional_))),COUNT(__d3(__NN(Postdirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.sec_range',COUNT(__d3(__NL(Secondary_Range_))),COUNT(__d3(__NN(Secondary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.zip5',COUNT(__d3(__NL(Z_I_P5_))),COUNT(__d3(__NN(Z_I_P5_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SSN',COUNT(__d3(__NL(S_S_N_))),COUNT(__d3(__NN(S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AppendedSSN',COUNT(__d3(__NL(Appended_S_S_N_))),COUNT(__d3(__NN(Appended_S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.personal_phone',COUNT(__d3(__NL(Personal_Phone_Number_))),COUNT(__d3(__NN(Personal_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.work_phone',COUNT(__d3(__NL(Work_Phone_Number_))),COUNT(__d3(__NN(Work_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.email_address',COUNT(__d3(__NL(Email_Address_))),COUNT(__d3(__NN(Email_Address_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyName',COUNT(__d3(__NL(Company_Name_))),COUNT(__d3(__NN(Company_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyPhone',COUNT(__d3(__NL(Company_Phone_))),COUNT(__d3(__NN(Company_Phone_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TIN',COUNT(__d3(__NL(T_I_N_))),COUNT(__d3(__NN(T_I_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltID',COUNT(__d3(__NL(Ult_I_D_))),COUNT(__d3(__NN(Ult_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgID',COUNT(__d3(__NL(Org_I_D_))),COUNT(__d3(__NN(Org_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleID',COUNT(__d3(__NL(Sele_I_D_))),COUNT(__d3(__NN(Sele_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d3(Hybrid_Archive_Date_=0)),COUNT(__d3(Hybrid_Archive_Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d3(Vault_Date_Last_Seen_=0)),COUNT(__d3(Vault_Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_SSN_Invalid),COUNT(__d4)},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.transaction_id',COUNT(__d4(__NL(Transaction_I_D_))),COUNT(__d4(__NN(Transaction_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.sequence_number',COUNT(__d4(__NL(Sequence_Number_))),COUNT(__d4(__NN(Sequence_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.method',COUNT(__d4(__NL(Method_))),COUNT(__d4(__NN(Method_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.product_code',COUNT(__d4(__NL(Product_Code_))),COUNT(__d4(__NN(Product_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.function_description',COUNT(__d4(__NL(Function_Description_))),COUNT(__d4(__NN(Function_Description_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.glb_purpose',COUNT(__d4(__NL(G_L_B_Purpose_))),COUNT(__d4(__NN(G_L_B_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.dppa_purpose',COUNT(__d4(__NL(D_P_P_A_Purpose_))),COUNT(__d4(__NN(D_P_P_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.fcra_purpose',COUNT(__d4(__NL(F_C_R_A_Purpose_))),COUNT(__d4(__NN(F_C_R_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.primary_market_code',COUNT(__d4(__NL(Primary_Market_Code_))),COUNT(__d4(__NN(Primary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.secondary_market_code',COUNT(__d4(__NL(Secondary_Market_Code_))),COUNT(__d4(__NN(Secondary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry_1_code',COUNT(__d4(__NL(Industry_Code1_))),COUNT(__d4(__NN(Industry_Code1_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry_2_code',COUNT(__d4(__NL(Industry_Code2_))),COUNT(__d4(__NN(Industry_Code2_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.sub_market',COUNT(__d4(__NL(Sub_Market_))),COUNT(__d4(__NN(Sub_Market_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.vertical',COUNT(__d4(__NL(Vertical_))),COUNT(__d4(__NN(Vertical_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry',COUNT(__d4(__NL(Industry_))),COUNT(__d4(__NN(Industry_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FraudpointScore',COUNT(__d4(__NL(Fraudpoint_Score_))),COUNT(__d4(__NN(Fraudpoint_Score_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.fname',COUNT(__d4(__NL(First_Name_))),COUNT(__d4(__NN(First_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.lname',COUNT(__d4(__NL(Last_Name_))),COUNT(__d4(__NN(Last_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.dob',COUNT(__d4(__NL(Date_Of_Birth_))),COUNT(__d4(__NN(Date_Of_Birth_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DOBPadded',COUNT(__d4(__NL(Date_Of_Birth_Padded_))),COUNT(__d4(__NN(Date_Of_Birth_Padded_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.appended_adl',COUNT(__d4(__NL(Lex_I_D_))),COUNT(__d4(__NN(Lex_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_range',COUNT(__d4(__NL(Primary_Range_))),COUNT(__d4(__NN(Primary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.predir',COUNT(__d4(__NL(Predirectional_))),COUNT(__d4(__NN(Predirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_name',COUNT(__d4(__NL(Primary_Name_))),COUNT(__d4(__NN(Primary_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.addr_suffix',COUNT(__d4(__NL(Suffix_))),COUNT(__d4(__NN(Suffix_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.postdir',COUNT(__d4(__NL(Postdirectional_))),COUNT(__d4(__NN(Postdirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.sec_range',COUNT(__d4(__NL(Secondary_Range_))),COUNT(__d4(__NN(Secondary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.zip5',COUNT(__d4(__NL(Z_I_P5_))),COUNT(__d4(__NN(Z_I_P5_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SSN',COUNT(__d4(__NL(S_S_N_))),COUNT(__d4(__NN(S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AppendedSSN',COUNT(__d4(__NL(Appended_S_S_N_))),COUNT(__d4(__NN(Appended_S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.personal_phone',COUNT(__d4(__NL(Personal_Phone_Number_))),COUNT(__d4(__NN(Personal_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.work_phone',COUNT(__d4(__NL(Work_Phone_Number_))),COUNT(__d4(__NN(Work_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.email_address',COUNT(__d4(__NL(Email_Address_))),COUNT(__d4(__NN(Email_Address_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyName',COUNT(__d4(__NL(Company_Name_))),COUNT(__d4(__NN(Company_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyPhone',COUNT(__d4(__NL(Company_Phone_))),COUNT(__d4(__NN(Company_Phone_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TIN',COUNT(__d4(__NL(T_I_N_))),COUNT(__d4(__NN(T_I_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltID',COUNT(__d4(__NL(Ult_I_D_))),COUNT(__d4(__NN(Ult_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgID',COUNT(__d4(__NL(Org_I_D_))),COUNT(__d4(__NN(Org_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleID',COUNT(__d4(__NL(Sele_I_D_))),COUNT(__d4(__NN(Sele_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d4(Archive___Date_=0)),COUNT(__d4(Archive___Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d4(Hybrid_Archive_Date_=0)),COUNT(__d4(Hybrid_Archive_Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d4(Vault_Date_Last_Seen_=0)),COUNT(__d4(Vault_Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_Address_Invalid),COUNT(__d5)},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.transaction_id',COUNT(__d5(__NL(Transaction_I_D_))),COUNT(__d5(__NN(Transaction_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.sequence_number',COUNT(__d5(__NL(Sequence_Number_))),COUNT(__d5(__NN(Sequence_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.method',COUNT(__d5(__NL(Method_))),COUNT(__d5(__NN(Method_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.product_code',COUNT(__d5(__NL(Product_Code_))),COUNT(__d5(__NN(Product_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.function_description',COUNT(__d5(__NL(Function_Description_))),COUNT(__d5(__NN(Function_Description_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.glb_purpose',COUNT(__d5(__NL(G_L_B_Purpose_))),COUNT(__d5(__NN(G_L_B_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.dppa_purpose',COUNT(__d5(__NL(D_P_P_A_Purpose_))),COUNT(__d5(__NN(D_P_P_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.fcra_purpose',COUNT(__d5(__NL(F_C_R_A_Purpose_))),COUNT(__d5(__NN(F_C_R_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.primary_market_code',COUNT(__d5(__NL(Primary_Market_Code_))),COUNT(__d5(__NN(Primary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.secondary_market_code',COUNT(__d5(__NL(Secondary_Market_Code_))),COUNT(__d5(__NN(Secondary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry_1_code',COUNT(__d5(__NL(Industry_Code1_))),COUNT(__d5(__NN(Industry_Code1_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry_2_code',COUNT(__d5(__NL(Industry_Code2_))),COUNT(__d5(__NN(Industry_Code2_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.sub_market',COUNT(__d5(__NL(Sub_Market_))),COUNT(__d5(__NN(Sub_Market_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.vertical',COUNT(__d5(__NL(Vertical_))),COUNT(__d5(__NN(Vertical_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry',COUNT(__d5(__NL(Industry_))),COUNT(__d5(__NN(Industry_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FraudpointScore',COUNT(__d5(__NL(Fraudpoint_Score_))),COUNT(__d5(__NN(Fraudpoint_Score_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.fname',COUNT(__d5(__NL(First_Name_))),COUNT(__d5(__NN(First_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.lname',COUNT(__d5(__NL(Last_Name_))),COUNT(__d5(__NN(Last_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.dob',COUNT(__d5(__NL(Date_Of_Birth_))),COUNT(__d5(__NN(Date_Of_Birth_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DOBPadded',COUNT(__d5(__NL(Date_Of_Birth_Padded_))),COUNT(__d5(__NN(Date_Of_Birth_Padded_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.appended_adl',COUNT(__d5(__NL(Lex_I_D_))),COUNT(__d5(__NN(Lex_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_range',COUNT(__d5(__NL(Primary_Range_))),COUNT(__d5(__NN(Primary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.predir',COUNT(__d5(__NL(Predirectional_))),COUNT(__d5(__NN(Predirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_name',COUNT(__d5(__NL(Primary_Name_))),COUNT(__d5(__NN(Primary_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.addr_suffix',COUNT(__d5(__NL(Suffix_))),COUNT(__d5(__NN(Suffix_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.postdir',COUNT(__d5(__NL(Postdirectional_))),COUNT(__d5(__NN(Postdirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.sec_range',COUNT(__d5(__NL(Secondary_Range_))),COUNT(__d5(__NN(Secondary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.zip5',COUNT(__d5(__NL(Z_I_P5_))),COUNT(__d5(__NN(Z_I_P5_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.ssn',COUNT(__d5(__NL(S_S_N_))),COUNT(__d5(__NN(S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.appended_ssn',COUNT(__d5(__NL(Appended_S_S_N_))),COUNT(__d5(__NN(Appended_S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.personal_phone',COUNT(__d5(__NL(Personal_Phone_Number_))),COUNT(__d5(__NN(Personal_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.work_phone',COUNT(__d5(__NL(Work_Phone_Number_))),COUNT(__d5(__NN(Work_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.email_address',COUNT(__d5(__NL(Email_Address_))),COUNT(__d5(__NN(Email_Address_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyName',COUNT(__d5(__NL(Company_Name_))),COUNT(__d5(__NN(Company_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyPhone',COUNT(__d5(__NL(Company_Phone_))),COUNT(__d5(__NN(Company_Phone_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TIN',COUNT(__d5(__NL(T_I_N_))),COUNT(__d5(__NN(T_I_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltID',COUNT(__d5(__NL(Ult_I_D_))),COUNT(__d5(__NN(Ult_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgID',COUNT(__d5(__NL(Org_I_D_))),COUNT(__d5(__NN(Org_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleID',COUNT(__d5(__NL(Sele_I_D_))),COUNT(__d5(__NN(Sele_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d5(Archive___Date_=0)),COUNT(__d5(Archive___Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d5(Hybrid_Archive_Date_=0)),COUNT(__d5(Hybrid_Archive_Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d5(Vault_Date_Last_Seen_=0)),COUNT(__d5(Vault_Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_DID_Invalid),COUNT(__d6)},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.transaction_id',COUNT(__d6(__NL(Transaction_I_D_))),COUNT(__d6(__NN(Transaction_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.sequence_number',COUNT(__d6(__NL(Sequence_Number_))),COUNT(__d6(__NN(Sequence_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.method',COUNT(__d6(__NL(Method_))),COUNT(__d6(__NN(Method_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.product_code',COUNT(__d6(__NL(Product_Code_))),COUNT(__d6(__NN(Product_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.function_description',COUNT(__d6(__NL(Function_Description_))),COUNT(__d6(__NN(Function_Description_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.glb_purpose',COUNT(__d6(__NL(G_L_B_Purpose_))),COUNT(__d6(__NN(G_L_B_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.dppa_purpose',COUNT(__d6(__NL(D_P_P_A_Purpose_))),COUNT(__d6(__NN(D_P_P_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.fcra_purpose',COUNT(__d6(__NL(F_C_R_A_Purpose_))),COUNT(__d6(__NN(F_C_R_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.primary_market_code',COUNT(__d6(__NL(Primary_Market_Code_))),COUNT(__d6(__NN(Primary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.secondary_market_code',COUNT(__d6(__NL(Secondary_Market_Code_))),COUNT(__d6(__NN(Secondary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry_1_code',COUNT(__d6(__NL(Industry_Code1_))),COUNT(__d6(__NN(Industry_Code1_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry_2_code',COUNT(__d6(__NL(Industry_Code2_))),COUNT(__d6(__NN(Industry_Code2_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.sub_market',COUNT(__d6(__NL(Sub_Market_))),COUNT(__d6(__NN(Sub_Market_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.vertical',COUNT(__d6(__NL(Vertical_))),COUNT(__d6(__NN(Vertical_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry',COUNT(__d6(__NL(Industry_))),COUNT(__d6(__NN(Industry_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FraudpointScore',COUNT(__d6(__NL(Fraudpoint_Score_))),COUNT(__d6(__NN(Fraudpoint_Score_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.fname',COUNT(__d6(__NL(First_Name_))),COUNT(__d6(__NN(First_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.lname',COUNT(__d6(__NL(Last_Name_))),COUNT(__d6(__NN(Last_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.dob',COUNT(__d6(__NL(Date_Of_Birth_))),COUNT(__d6(__NN(Date_Of_Birth_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DOBPadded',COUNT(__d6(__NL(Date_Of_Birth_Padded_))),COUNT(__d6(__NN(Date_Of_Birth_Padded_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.appended_adl',COUNT(__d6(__NL(Lex_I_D_))),COUNT(__d6(__NN(Lex_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_range',COUNT(__d6(__NL(Primary_Range_))),COUNT(__d6(__NN(Primary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.predir',COUNT(__d6(__NL(Predirectional_))),COUNT(__d6(__NN(Predirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_name',COUNT(__d6(__NL(Primary_Name_))),COUNT(__d6(__NN(Primary_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.addr_suffix',COUNT(__d6(__NL(Suffix_))),COUNT(__d6(__NN(Suffix_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.postdir',COUNT(__d6(__NL(Postdirectional_))),COUNT(__d6(__NN(Postdirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.sec_range',COUNT(__d6(__NL(Secondary_Range_))),COUNT(__d6(__NN(Secondary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.zip5',COUNT(__d6(__NL(Z_I_P5_))),COUNT(__d6(__NN(Z_I_P5_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.ssn',COUNT(__d6(__NL(S_S_N_))),COUNT(__d6(__NN(S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.appended_ssn',COUNT(__d6(__NL(Appended_S_S_N_))),COUNT(__d6(__NN(Appended_S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.personal_phone',COUNT(__d6(__NL(Personal_Phone_Number_))),COUNT(__d6(__NN(Personal_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.work_phone',COUNT(__d6(__NL(Work_Phone_Number_))),COUNT(__d6(__NN(Work_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.email_address',COUNT(__d6(__NL(Email_Address_))),COUNT(__d6(__NN(Email_Address_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyName',COUNT(__d6(__NL(Company_Name_))),COUNT(__d6(__NN(Company_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyPhone',COUNT(__d6(__NL(Company_Phone_))),COUNT(__d6(__NN(Company_Phone_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TIN',COUNT(__d6(__NL(T_I_N_))),COUNT(__d6(__NN(T_I_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltID',COUNT(__d6(__NL(Ult_I_D_))),COUNT(__d6(__NN(Ult_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgID',COUNT(__d6(__NL(Org_I_D_))),COUNT(__d6(__NN(Org_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleID',COUNT(__d6(__NL(Sele_I_D_))),COUNT(__d6(__NN(Sele_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d6(__NL(Source_))),COUNT(__d6(__NN(Source_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d6(Archive___Date_=0)),COUNT(__d6(Archive___Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d6(Hybrid_Archive_Date_=0)),COUNT(__d6(Hybrid_Archive_Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d6(Vault_Date_Last_Seen_=0)),COUNT(__d6(Vault_Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_EMAIL_Invalid),COUNT(__d7)},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.transaction_id',COUNT(__d7(__NL(Transaction_I_D_))),COUNT(__d7(__NN(Transaction_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.sequence_number',COUNT(__d7(__NL(Sequence_Number_))),COUNT(__d7(__NN(Sequence_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.method',COUNT(__d7(__NL(Method_))),COUNT(__d7(__NN(Method_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.product_code',COUNT(__d7(__NL(Product_Code_))),COUNT(__d7(__NN(Product_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.function_description',COUNT(__d7(__NL(Function_Description_))),COUNT(__d7(__NN(Function_Description_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GLBPurpose',COUNT(__d7(__NL(G_L_B_Purpose_))),COUNT(__d7(__NN(G_L_B_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DPPAPurpose',COUNT(__d7(__NL(D_P_P_A_Purpose_))),COUNT(__d7(__NN(D_P_P_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FCRAPurpose',COUNT(__d7(__NL(F_C_R_A_Purpose_))),COUNT(__d7(__NN(F_C_R_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.primary_market_code',COUNT(__d7(__NL(Primary_Market_Code_))),COUNT(__d7(__NN(Primary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.secondary_market_code',COUNT(__d7(__NL(Secondary_Market_Code_))),COUNT(__d7(__NN(Secondary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry_1_code',COUNT(__d7(__NL(Industry_Code1_))),COUNT(__d7(__NN(Industry_Code1_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry_2_code',COUNT(__d7(__NL(Industry_Code2_))),COUNT(__d7(__NN(Industry_Code2_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.sub_market',COUNT(__d7(__NL(Sub_Market_))),COUNT(__d7(__NN(Sub_Market_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.vertical',COUNT(__d7(__NL(Vertical_))),COUNT(__d7(__NN(Vertical_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry',COUNT(__d7(__NL(Industry_))),COUNT(__d7(__NN(Industry_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FraudpointScore',COUNT(__d7(__NL(Fraudpoint_Score_))),COUNT(__d7(__NN(Fraudpoint_Score_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.fname',COUNT(__d7(__NL(First_Name_))),COUNT(__d7(__NN(First_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.lname',COUNT(__d7(__NL(Last_Name_))),COUNT(__d7(__NN(Last_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.dob',COUNT(__d7(__NL(Date_Of_Birth_))),COUNT(__d7(__NN(Date_Of_Birth_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DOBPadded',COUNT(__d7(__NL(Date_Of_Birth_Padded_))),COUNT(__d7(__NN(Date_Of_Birth_Padded_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.appended_adl',COUNT(__d7(__NL(Lex_I_D_))),COUNT(__d7(__NN(Lex_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_range',COUNT(__d7(__NL(Primary_Range_))),COUNT(__d7(__NN(Primary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.predir',COUNT(__d7(__NL(Predirectional_))),COUNT(__d7(__NN(Predirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_name',COUNT(__d7(__NL(Primary_Name_))),COUNT(__d7(__NN(Primary_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.addr_suffix',COUNT(__d7(__NL(Suffix_))),COUNT(__d7(__NN(Suffix_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.postdir',COUNT(__d7(__NL(Postdirectional_))),COUNT(__d7(__NN(Postdirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.sec_range',COUNT(__d7(__NL(Secondary_Range_))),COUNT(__d7(__NN(Secondary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.zip5',COUNT(__d7(__NL(Z_I_P5_))),COUNT(__d7(__NN(Z_I_P5_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.ssn',COUNT(__d7(__NL(S_S_N_))),COUNT(__d7(__NN(S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.appended_ssn',COUNT(__d7(__NL(Appended_S_S_N_))),COUNT(__d7(__NN(Appended_S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.personal_phone',COUNT(__d7(__NL(Personal_Phone_Number_))),COUNT(__d7(__NN(Personal_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.work_phone',COUNT(__d7(__NL(Work_Phone_Number_))),COUNT(__d7(__NN(Work_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.email_address',COUNT(__d7(__NL(Email_Address_))),COUNT(__d7(__NN(Email_Address_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyName',COUNT(__d7(__NL(Company_Name_))),COUNT(__d7(__NN(Company_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyPhone',COUNT(__d7(__NL(Company_Phone_))),COUNT(__d7(__NN(Company_Phone_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TIN',COUNT(__d7(__NL(T_I_N_))),COUNT(__d7(__NN(T_I_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltID',COUNT(__d7(__NL(Ult_I_D_))),COUNT(__d7(__NN(Ult_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgID',COUNT(__d7(__NL(Org_I_D_))),COUNT(__d7(__NN(Org_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleID',COUNT(__d7(__NL(Sele_I_D_))),COUNT(__d7(__NN(Sele_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d7(__NL(Source_))),COUNT(__d7(__NN(Source_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d7(Archive___Date_=0)),COUNT(__d7(Archive___Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d7(Date_First_Seen_=0)),COUNT(__d7(Date_First_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d7(Date_Last_Seen_=0)),COUNT(__d7(Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d7(Hybrid_Archive_Date_=0)),COUNT(__d7(Hybrid_Archive_Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d7(Vault_Date_Last_Seen_=0)),COUNT(__d7(Vault_Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_Phone_Invalid),COUNT(__d8)},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.transaction_id',COUNT(__d8(__NL(Transaction_I_D_))),COUNT(__d8(__NN(Transaction_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.sequence_number',COUNT(__d8(__NL(Sequence_Number_))),COUNT(__d8(__NN(Sequence_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.method',COUNT(__d8(__NL(Method_))),COUNT(__d8(__NN(Method_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.product_code',COUNT(__d8(__NL(Product_Code_))),COUNT(__d8(__NN(Product_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.function_description',COUNT(__d8(__NL(Function_Description_))),COUNT(__d8(__NN(Function_Description_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.glb_purpose',COUNT(__d8(__NL(G_L_B_Purpose_))),COUNT(__d8(__NN(G_L_B_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.dppa_purpose',COUNT(__d8(__NL(D_P_P_A_Purpose_))),COUNT(__d8(__NN(D_P_P_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.fcra_purpose',COUNT(__d8(__NL(F_C_R_A_Purpose_))),COUNT(__d8(__NN(F_C_R_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.primary_market_code',COUNT(__d8(__NL(Primary_Market_Code_))),COUNT(__d8(__NN(Primary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.secondary_market_code',COUNT(__d8(__NL(Secondary_Market_Code_))),COUNT(__d8(__NN(Secondary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry_1_code',COUNT(__d8(__NL(Industry_Code1_))),COUNT(__d8(__NN(Industry_Code1_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry_2_code',COUNT(__d8(__NL(Industry_Code2_))),COUNT(__d8(__NN(Industry_Code2_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.sub_market',COUNT(__d8(__NL(Sub_Market_))),COUNT(__d8(__NN(Sub_Market_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.vertical',COUNT(__d8(__NL(Vertical_))),COUNT(__d8(__NN(Vertical_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry',COUNT(__d8(__NL(Industry_))),COUNT(__d8(__NN(Industry_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FraudpointScore',COUNT(__d8(__NL(Fraudpoint_Score_))),COUNT(__d8(__NN(Fraudpoint_Score_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.fname',COUNT(__d8(__NL(First_Name_))),COUNT(__d8(__NN(First_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.lname',COUNT(__d8(__NL(Last_Name_))),COUNT(__d8(__NN(Last_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.dob',COUNT(__d8(__NL(Date_Of_Birth_))),COUNT(__d8(__NN(Date_Of_Birth_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DOBPadded',COUNT(__d8(__NL(Date_Of_Birth_Padded_))),COUNT(__d8(__NN(Date_Of_Birth_Padded_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.appended_adl',COUNT(__d8(__NL(Lex_I_D_))),COUNT(__d8(__NN(Lex_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_range',COUNT(__d8(__NL(Primary_Range_))),COUNT(__d8(__NN(Primary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.predir',COUNT(__d8(__NL(Predirectional_))),COUNT(__d8(__NN(Predirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_name',COUNT(__d8(__NL(Primary_Name_))),COUNT(__d8(__NN(Primary_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.addr_suffix',COUNT(__d8(__NL(Suffix_))),COUNT(__d8(__NN(Suffix_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.postdir',COUNT(__d8(__NL(Postdirectional_))),COUNT(__d8(__NN(Postdirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.sec_range',COUNT(__d8(__NL(Secondary_Range_))),COUNT(__d8(__NN(Secondary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.zip5',COUNT(__d8(__NL(Z_I_P5_))),COUNT(__d8(__NN(Z_I_P5_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.ssn',COUNT(__d8(__NL(S_S_N_))),COUNT(__d8(__NN(S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.appended_ssn',COUNT(__d8(__NL(Appended_S_S_N_))),COUNT(__d8(__NN(Appended_S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.personal_phone',COUNT(__d8(__NL(Personal_Phone_Number_))),COUNT(__d8(__NN(Personal_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.work_phone',COUNT(__d8(__NL(Work_Phone_Number_))),COUNT(__d8(__NN(Work_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.email_address',COUNT(__d8(__NL(Email_Address_))),COUNT(__d8(__NN(Email_Address_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyName',COUNT(__d8(__NL(Company_Name_))),COUNT(__d8(__NN(Company_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyPhone',COUNT(__d8(__NL(Company_Phone_))),COUNT(__d8(__NN(Company_Phone_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TIN',COUNT(__d8(__NL(T_I_N_))),COUNT(__d8(__NN(T_I_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltID',COUNT(__d8(__NL(Ult_I_D_))),COUNT(__d8(__NN(Ult_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgID',COUNT(__d8(__NL(Org_I_D_))),COUNT(__d8(__NN(Org_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleID',COUNT(__d8(__NL(Sele_I_D_))),COUNT(__d8(__NN(Sele_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d8(__NL(Source_))),COUNT(__d8(__NN(Source_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d8(Archive___Date_=0)),COUNT(__d8(Archive___Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d8(Date_First_Seen_=0)),COUNT(__d8(Date_First_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d8(Date_Last_Seen_=0)),COUNT(__d8(Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d8(Hybrid_Archive_Date_=0)),COUNT(__d8(Hybrid_Archive_Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d8(Vault_Date_Last_Seen_=0)),COUNT(__d8(Vault_Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_FEIN_1_Invalid),COUNT(__d9)},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.transaction_id',COUNT(__d9(__NL(Transaction_I_D_))),COUNT(__d9(__NN(Transaction_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.sequence_number',COUNT(__d9(__NL(Sequence_Number_))),COUNT(__d9(__NN(Sequence_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.method',COUNT(__d9(__NL(Method_))),COUNT(__d9(__NN(Method_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.product_code',COUNT(__d9(__NL(Product_Code_))),COUNT(__d9(__NN(Product_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.function_description',COUNT(__d9(__NL(Function_Description_))),COUNT(__d9(__NN(Function_Description_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.glb_purpose',COUNT(__d9(__NL(G_L_B_Purpose_))),COUNT(__d9(__NN(G_L_B_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.dppa_purpose',COUNT(__d9(__NL(D_P_P_A_Purpose_))),COUNT(__d9(__NN(D_P_P_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.fcra_purpose',COUNT(__d9(__NL(F_C_R_A_Purpose_))),COUNT(__d9(__NN(F_C_R_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.primary_market_code',COUNT(__d9(__NL(Primary_Market_Code_))),COUNT(__d9(__NN(Primary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.secondary_market_code',COUNT(__d9(__NL(Secondary_Market_Code_))),COUNT(__d9(__NN(Secondary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry_1_code',COUNT(__d9(__NL(Industry_Code1_))),COUNT(__d9(__NN(Industry_Code1_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry_2_code',COUNT(__d9(__NL(Industry_Code2_))),COUNT(__d9(__NN(Industry_Code2_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.sub_market',COUNT(__d9(__NL(Sub_Market_))),COUNT(__d9(__NN(Sub_Market_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.vertical',COUNT(__d9(__NL(Vertical_))),COUNT(__d9(__NN(Vertical_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry',COUNT(__d9(__NL(Industry_))),COUNT(__d9(__NN(Industry_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FraudpointScore',COUNT(__d9(__NL(Fraudpoint_Score_))),COUNT(__d9(__NN(Fraudpoint_Score_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.fname',COUNT(__d9(__NL(First_Name_))),COUNT(__d9(__NN(First_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.lname',COUNT(__d9(__NL(Last_Name_))),COUNT(__d9(__NN(Last_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.dob',COUNT(__d9(__NL(Date_Of_Birth_))),COUNT(__d9(__NN(Date_Of_Birth_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DOBPadded',COUNT(__d9(__NL(Date_Of_Birth_Padded_))),COUNT(__d9(__NN(Date_Of_Birth_Padded_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.appended_adl',COUNT(__d9(__NL(Lex_I_D_))),COUNT(__d9(__NN(Lex_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_q.prim_range',COUNT(__d9(__NL(Primary_Range_))),COUNT(__d9(__NN(Primary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_q.predir',COUNT(__d9(__NL(Predirectional_))),COUNT(__d9(__NN(Predirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_q.prim_name',COUNT(__d9(__NL(Primary_Name_))),COUNT(__d9(__NN(Primary_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_q.addr_suffix',COUNT(__d9(__NL(Suffix_))),COUNT(__d9(__NN(Suffix_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_q.postdir',COUNT(__d9(__NL(Postdirectional_))),COUNT(__d9(__NN(Postdirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_q.sec_range',COUNT(__d9(__NL(Secondary_Range_))),COUNT(__d9(__NN(Secondary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_q.zip5',COUNT(__d9(__NL(Z_I_P5_))),COUNT(__d9(__NN(Z_I_P5_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.ssn',COUNT(__d9(__NL(S_S_N_))),COUNT(__d9(__NN(S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.appended_ssn',COUNT(__d9(__NL(Appended_S_S_N_))),COUNT(__d9(__NN(Appended_S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.personal_phone',COUNT(__d9(__NL(Personal_Phone_Number_))),COUNT(__d9(__NN(Personal_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WorkPhoneNumber',COUNT(__d9(__NL(Work_Phone_Number_))),COUNT(__d9(__NN(Work_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmailAddress',COUNT(__d9(__NL(Email_Address_))),COUNT(__d9(__NN(Email_Address_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_q.cname',COUNT(__d9(__NL(Company_Name_))),COUNT(__d9(__NN(Company_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_q.company_phone',COUNT(__d9(__NL(Company_Phone_))),COUNT(__d9(__NN(Company_Phone_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','appended_ein',COUNT(__d9(__NL(T_I_N_))),COUNT(__d9(__NN(T_I_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltID',COUNT(__d9(__NL(Ult_I_D_))),COUNT(__d9(__NN(Ult_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgID',COUNT(__d9(__NL(Org_I_D_))),COUNT(__d9(__NN(Org_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleID',COUNT(__d9(__NL(Sele_I_D_))),COUNT(__d9(__NN(Sele_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d9(__NL(Source_))),COUNT(__d9(__NN(Source_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d9(Archive___Date_=0)),COUNT(__d9(Archive___Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d9(Date_First_Seen_=0)),COUNT(__d9(Date_First_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d9(Date_Last_Seen_=0)),COUNT(__d9(Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d9(Hybrid_Archive_Date_=0)),COUNT(__d9(Hybrid_Archive_Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d9(Vault_Date_Last_Seen_=0)),COUNT(__d9(Vault_Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_FEIN_2_Invalid),COUNT(__d10)},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.transaction_id',COUNT(__d10(__NL(Transaction_I_D_))),COUNT(__d10(__NN(Transaction_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.sequence_number',COUNT(__d10(__NL(Sequence_Number_))),COUNT(__d10(__NN(Sequence_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Method',COUNT(__d10(__NL(Method_))),COUNT(__d10(__NN(Method_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProductCode',COUNT(__d10(__NL(Product_Code_))),COUNT(__d10(__NN(Product_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FunctionDescription',COUNT(__d10(__NL(Function_Description_))),COUNT(__d10(__NN(Function_Description_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GLBPurpose',COUNT(__d10(__NL(G_L_B_Purpose_))),COUNT(__d10(__NN(G_L_B_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DPPAPurpose',COUNT(__d10(__NL(D_P_P_A_Purpose_))),COUNT(__d10(__NN(D_P_P_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FCRAPurpose',COUNT(__d10(__NL(F_C_R_A_Purpose_))),COUNT(__d10(__NN(F_C_R_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryMarketCode',COUNT(__d10(__NL(Primary_Market_Code_))),COUNT(__d10(__NN(Primary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondaryMarketCode',COUNT(__d10(__NL(Secondary_Market_Code_))),COUNT(__d10(__NN(Secondary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IndustryCode1',COUNT(__d10(__NL(Industry_Code1_))),COUNT(__d10(__NN(Industry_Code1_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IndustryCode2',COUNT(__d10(__NL(Industry_Code2_))),COUNT(__d10(__NN(Industry_Code2_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SubMarket',COUNT(__d10(__NL(Sub_Market_))),COUNT(__d10(__NN(Sub_Market_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Vertical',COUNT(__d10(__NL(Vertical_))),COUNT(__d10(__NN(Vertical_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Industry',COUNT(__d10(__NL(Industry_))),COUNT(__d10(__NN(Industry_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FraudpointScore',COUNT(__d10(__NL(Fraudpoint_Score_))),COUNT(__d10(__NN(Fraudpoint_Score_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FirstName',COUNT(__d10(__NL(First_Name_))),COUNT(__d10(__NN(First_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LastName',COUNT(__d10(__NL(Last_Name_))),COUNT(__d10(__NN(Last_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirth',COUNT(__d10(__NL(Date_Of_Birth_))),COUNT(__d10(__NN(Date_Of_Birth_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d10(__NL(Date_Of_Birth_Padded_))),COUNT(__d10(__NN(Date_Of_Birth_Padded_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexID',COUNT(__d10(__NL(Lex_I_D_))),COUNT(__d10(__NN(Lex_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.prim_range',COUNT(__d10(__NL(Primary_Range_))),COUNT(__d10(__NN(Primary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.predir',COUNT(__d10(__NL(Predirectional_))),COUNT(__d10(__NN(Predirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.prim_name',COUNT(__d10(__NL(Primary_Name_))),COUNT(__d10(__NN(Primary_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.addr_suffix',COUNT(__d10(__NL(Suffix_))),COUNT(__d10(__NN(Suffix_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.postdir',COUNT(__d10(__NL(Postdirectional_))),COUNT(__d10(__NN(Postdirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.sec_range',COUNT(__d10(__NL(Secondary_Range_))),COUNT(__d10(__NN(Secondary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.zip5',COUNT(__d10(__NL(Z_I_P5_))),COUNT(__d10(__NN(Z_I_P5_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SSN',COUNT(__d10(__NL(S_S_N_))),COUNT(__d10(__NN(S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AppendedSSN',COUNT(__d10(__NL(Appended_S_S_N_))),COUNT(__d10(__NN(Appended_S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PersonalPhoneNumber',COUNT(__d10(__NL(Personal_Phone_Number_))),COUNT(__d10(__NN(Personal_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WorkPhoneNumber',COUNT(__d10(__NL(Work_Phone_Number_))),COUNT(__d10(__NN(Work_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmailAddress',COUNT(__d10(__NL(Email_Address_))),COUNT(__d10(__NN(Email_Address_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyName',COUNT(__d10(__NL(Company_Name_))),COUNT(__d10(__NN(Company_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyPhone',COUNT(__d10(__NL(Company_Phone_))),COUNT(__d10(__NN(Company_Phone_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TIN',COUNT(__d10(__NL(T_I_N_))),COUNT(__d10(__NN(T_I_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltID',COUNT(__d10(__NL(Ult_I_D_))),COUNT(__d10(__NN(Ult_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgID',COUNT(__d10(__NL(Org_I_D_))),COUNT(__d10(__NN(Org_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleID',COUNT(__d10(__NL(Sele_I_D_))),COUNT(__d10(__NN(Sele_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d10(__NL(Source_))),COUNT(__d10(__NN(Source_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d10(Archive___Date_=0)),COUNT(__d10(Archive___Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d10(Date_First_Seen_=0)),COUNT(__d10(Date_First_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d10(Date_Last_Seen_=0)),COUNT(__d10(Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d10(Hybrid_Archive_Date_=0)),COUNT(__d10(Hybrid_Archive_Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d10(Vault_Date_Last_Seen_=0)),COUNT(__d10(Vault_Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_LinkIDs_1_Invalid),COUNT(__d11)},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.transaction_id',COUNT(__d11(__NL(Transaction_I_D_))),COUNT(__d11(__NN(Transaction_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.sequence_number',COUNT(__d11(__NL(Sequence_Number_))),COUNT(__d11(__NN(Sequence_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.method',COUNT(__d11(__NL(Method_))),COUNT(__d11(__NN(Method_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.product_code',COUNT(__d11(__NL(Product_Code_))),COUNT(__d11(__NN(Product_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.function_description',COUNT(__d11(__NL(Function_Description_))),COUNT(__d11(__NN(Function_Description_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.glb_purpose',COUNT(__d11(__NL(G_L_B_Purpose_))),COUNT(__d11(__NN(G_L_B_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.dppa_purpose',COUNT(__d11(__NL(D_P_P_A_Purpose_))),COUNT(__d11(__NN(D_P_P_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.fcra_purpose',COUNT(__d11(__NL(F_C_R_A_Purpose_))),COUNT(__d11(__NN(F_C_R_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.primary_market_code',COUNT(__d11(__NL(Primary_Market_Code_))),COUNT(__d11(__NN(Primary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.secondary_market_code',COUNT(__d11(__NL(Secondary_Market_Code_))),COUNT(__d11(__NN(Secondary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry_1_code',COUNT(__d11(__NL(Industry_Code1_))),COUNT(__d11(__NN(Industry_Code1_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry_2_code',COUNT(__d11(__NL(Industry_Code2_))),COUNT(__d11(__NN(Industry_Code2_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.sub_market',COUNT(__d11(__NL(Sub_Market_))),COUNT(__d11(__NN(Sub_Market_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.vertical',COUNT(__d11(__NL(Vertical_))),COUNT(__d11(__NN(Vertical_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry',COUNT(__d11(__NL(Industry_))),COUNT(__d11(__NN(Industry_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FraudpointScore',COUNT(__d11(__NL(Fraudpoint_Score_))),COUNT(__d11(__NN(Fraudpoint_Score_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.fname',COUNT(__d11(__NL(First_Name_))),COUNT(__d11(__NN(First_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.lname',COUNT(__d11(__NL(Last_Name_))),COUNT(__d11(__NN(Last_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.dob',COUNT(__d11(__NL(Date_Of_Birth_))),COUNT(__d11(__NN(Date_Of_Birth_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DOBPadded',COUNT(__d11(__NL(Date_Of_Birth_Padded_))),COUNT(__d11(__NN(Date_Of_Birth_Padded_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.appended_adl',COUNT(__d11(__NL(Lex_I_D_))),COUNT(__d11(__NN(Lex_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_q.prim_range',COUNT(__d11(__NL(Primary_Range_))),COUNT(__d11(__NN(Primary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_q.predir',COUNT(__d11(__NL(Predirectional_))),COUNT(__d11(__NN(Predirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_q.prim_name',COUNT(__d11(__NL(Primary_Name_))),COUNT(__d11(__NN(Primary_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_q.addr_suffix',COUNT(__d11(__NL(Suffix_))),COUNT(__d11(__NN(Suffix_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_q.postdir',COUNT(__d11(__NL(Postdirectional_))),COUNT(__d11(__NN(Postdirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_q.sec_range',COUNT(__d11(__NL(Secondary_Range_))),COUNT(__d11(__NN(Secondary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_q.zip5',COUNT(__d11(__NL(Z_I_P5_))),COUNT(__d11(__NN(Z_I_P5_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.ssn',COUNT(__d11(__NL(S_S_N_))),COUNT(__d11(__NN(S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.appended_ssn',COUNT(__d11(__NL(Appended_S_S_N_))),COUNT(__d11(__NN(Appended_S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.personal_phone',COUNT(__d11(__NL(Personal_Phone_Number_))),COUNT(__d11(__NN(Personal_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WorkPhoneNumber',COUNT(__d11(__NL(Work_Phone_Number_))),COUNT(__d11(__NN(Work_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmailAddress',COUNT(__d11(__NL(Email_Address_))),COUNT(__d11(__NN(Email_Address_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_q.cname',COUNT(__d11(__NL(Company_Name_))),COUNT(__d11(__NN(Company_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_q.company_phone',COUNT(__d11(__NL(Company_Phone_))),COUNT(__d11(__NN(Company_Phone_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_q.appended_ein',COUNT(__d11(__NL(T_I_N_))),COUNT(__d11(__NN(T_I_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltID',COUNT(__d11(__NL(Ult_I_D_))),COUNT(__d11(__NN(Ult_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgID',COUNT(__d11(__NL(Org_I_D_))),COUNT(__d11(__NN(Org_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleID',COUNT(__d11(__NL(Sele_I_D_))),COUNT(__d11(__NN(Sele_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d11(__NL(Source_))),COUNT(__d11(__NN(Source_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d11(Archive___Date_=0)),COUNT(__d11(Archive___Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d11(Date_First_Seen_=0)),COUNT(__d11(Date_First_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d11(Date_Last_Seen_=0)),COUNT(__d11(Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d11(Hybrid_Archive_Date_=0)),COUNT(__d11(Hybrid_Archive_Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d11(Vault_Date_Last_Seen_=0)),COUNT(__d11(Vault_Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Inquiry_Table_LinkIDs_2_Invalid),COUNT(__d12)},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.transaction_id',COUNT(__d12(__NL(Transaction_I_D_))),COUNT(__d12(__NN(Transaction_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.sequence_number',COUNT(__d12(__NL(Sequence_Number_))),COUNT(__d12(__NN(Sequence_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Method',COUNT(__d12(__NL(Method_))),COUNT(__d12(__NN(Method_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProductCode',COUNT(__d12(__NL(Product_Code_))),COUNT(__d12(__NN(Product_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FunctionDescription',COUNT(__d12(__NL(Function_Description_))),COUNT(__d12(__NN(Function_Description_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GLBPurpose',COUNT(__d12(__NL(G_L_B_Purpose_))),COUNT(__d12(__NN(G_L_B_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DPPAPurpose',COUNT(__d12(__NL(D_P_P_A_Purpose_))),COUNT(__d12(__NN(D_P_P_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FCRAPurpose',COUNT(__d12(__NL(F_C_R_A_Purpose_))),COUNT(__d12(__NN(F_C_R_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryMarketCode',COUNT(__d12(__NL(Primary_Market_Code_))),COUNT(__d12(__NN(Primary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondaryMarketCode',COUNT(__d12(__NL(Secondary_Market_Code_))),COUNT(__d12(__NN(Secondary_Market_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IndustryCode1',COUNT(__d12(__NL(Industry_Code1_))),COUNT(__d12(__NN(Industry_Code1_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IndustryCode2',COUNT(__d12(__NL(Industry_Code2_))),COUNT(__d12(__NN(Industry_Code2_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SubMarket',COUNT(__d12(__NL(Sub_Market_))),COUNT(__d12(__NN(Sub_Market_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Vertical',COUNT(__d12(__NL(Vertical_))),COUNT(__d12(__NN(Vertical_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Industry',COUNT(__d12(__NL(Industry_))),COUNT(__d12(__NN(Industry_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FraudpointScore',COUNT(__d12(__NL(Fraudpoint_Score_))),COUNT(__d12(__NN(Fraudpoint_Score_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FirstName',COUNT(__d12(__NL(First_Name_))),COUNT(__d12(__NN(First_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LastName',COUNT(__d12(__NL(Last_Name_))),COUNT(__d12(__NN(Last_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirth',COUNT(__d12(__NL(Date_Of_Birth_))),COUNT(__d12(__NN(Date_Of_Birth_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d12(__NL(Date_Of_Birth_Padded_))),COUNT(__d12(__NN(Date_Of_Birth_Padded_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexID',COUNT(__d12(__NL(Lex_I_D_))),COUNT(__d12(__NN(Lex_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.prim_range',COUNT(__d12(__NL(Primary_Range_))),COUNT(__d12(__NN(Primary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.predir',COUNT(__d12(__NL(Predirectional_))),COUNT(__d12(__NN(Predirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.prim_name',COUNT(__d12(__NL(Primary_Name_))),COUNT(__d12(__NN(Primary_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.addr_suffix',COUNT(__d12(__NL(Suffix_))),COUNT(__d12(__NN(Suffix_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.postdir',COUNT(__d12(__NL(Postdirectional_))),COUNT(__d12(__NN(Postdirectional_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.sec_range',COUNT(__d12(__NL(Secondary_Range_))),COUNT(__d12(__NN(Secondary_Range_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bususer_q.zip5',COUNT(__d12(__NL(Z_I_P5_))),COUNT(__d12(__NN(Z_I_P5_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SSN',COUNT(__d12(__NL(S_S_N_))),COUNT(__d12(__NN(S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AppendedSSN',COUNT(__d12(__NL(Appended_S_S_N_))),COUNT(__d12(__NN(Appended_S_S_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PersonalPhoneNumber',COUNT(__d12(__NL(Personal_Phone_Number_))),COUNT(__d12(__NN(Personal_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WorkPhoneNumber',COUNT(__d12(__NL(Work_Phone_Number_))),COUNT(__d12(__NN(Work_Phone_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EmailAddress',COUNT(__d12(__NL(Email_Address_))),COUNT(__d12(__NN(Email_Address_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyName',COUNT(__d12(__NL(Company_Name_))),COUNT(__d12(__NN(Company_Name_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyPhone',COUNT(__d12(__NL(Company_Phone_))),COUNT(__d12(__NN(Company_Phone_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TIN',COUNT(__d12(__NL(T_I_N_))),COUNT(__d12(__NN(T_I_N_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UltID',COUNT(__d12(__NL(Ult_I_D_))),COUNT(__d12(__NN(Ult_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrgID',COUNT(__d12(__NL(Org_I_D_))),COUNT(__d12(__NN(Org_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeleID',COUNT(__d12(__NL(Sele_I_D_))),COUNT(__d12(__NN(Sele_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d12(__NL(Source_))),COUNT(__d12(__NN(Source_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d12(Archive___Date_=0)),COUNT(__d12(Archive___Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d12(Date_First_Seen_=0)),COUNT(__d12(Date_First_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d12(Date_Last_Seen_=0)),COUNT(__d12(Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d12(Hybrid_Archive_Date_=0)),COUNT(__d12(Hybrid_Archive_Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d12(Vault_Date_Last_Seen_=0)),COUNT(__d12(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
