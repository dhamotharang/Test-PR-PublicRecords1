//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_Consumer;
IMPORT * FROM KEL16.Null;
EXPORT E_Property(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Unit_Designation_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Postal_City_;
    KEL.typ.nstr Vanity_City_;
    KEL.typ.nstr State_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nstr A_V_M_Unformatted_A_P_N_;
    KEL.typ.nint A_V_M_Land_Use_Code_;
    KEL.typ.nkdate A_V_M_Recording_Date_;
    KEL.typ.nkdate A_V_M_Assessed_Value_Year_;
    KEL.typ.nint A_V_M_Sales_Price_;
    KEL.typ.nint A_V_M_Assessed_Total_Value_;
    KEL.typ.nint A_V_M_Market_Total_Value_;
    KEL.typ.nint A_V_M_Tax_Assessment_Valuation_;
    KEL.typ.nint A_V_M_Price_Index_Valuation_;
    KEL.typ.nint A_V_M_Hedonic_Valuation_;
    KEL.typ.nint A_V_M_Automated_Valuation_;
    KEL.typ.nint A_V_M_Confidence_Score_;
    KEL.typ.nbool A_V_M_Current_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    DATA57 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(DEFAULT:UID),primaryrange(DEFAULT:Primary_Range_:\'\'),predirectional(DEFAULT:Predirectional_:\'\'),primaryname(DEFAULT:Primary_Name_:\'\'),suffix(DEFAULT:Suffix_:\'\'),postdirectional(DEFAULT:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_:\'\'),secondaryrange(DEFAULT:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_:\'\'),vanitycity(DEFAULT:Vanity_City_:\'\'),state(DEFAULT:State_:\'\'),zip5(DEFAULT:Z_I_P5_:0),avmunformattedapn(DEFAULT:A_V_M_Unformatted_A_P_N_:\'\'),avmlandusecode(DEFAULT:A_V_M_Land_Use_Code_:0),avmrecordingdate(DEFAULT:A_V_M_Recording_Date_:DATE),avmassessedvalueyear(DEFAULT:A_V_M_Assessed_Value_Year_:DATE),avmsalesprice(DEFAULT:A_V_M_Sales_Price_:0),avmassessedtotalvalue(DEFAULT:A_V_M_Assessed_Total_Value_:0),avmmarkettotalvalue(DEFAULT:A_V_M_Market_Total_Value_:0),avmtaxassessmentvaluation(DEFAULT:A_V_M_Tax_Assessment_Valuation_:0),avmpriceindexvaluation(DEFAULT:A_V_M_Price_Index_Valuation_:0),avmhedonicvaluation(DEFAULT:A_V_M_Hedonic_Valuation_:0),avmautomatedvaluation(DEFAULT:A_V_M_Automated_Valuation_:0),avmconfidencescore(DEFAULT:A_V_M_Confidence_Score_:0),avmcurrentflag(DEFAULT:A_V_M_Current_Flag_),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := __in.Dataset_AVM_V2__Key_AVM_Address((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0);
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  SHARED __d1_KELfiltered := __in.Dataset_PropertyV2__Key_Search_Fid((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND propertyaddress);
  SHARED __d1_Trim := PROJECT(__d1_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'') + '|' + TRIM((STRING)'') + '|' + TRIM((STRING)'') + '|' + TRIM((STRING)'') + '|' + TRIM((STRING)'') + '|' + TRIM((STRING)0) + '|' + TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED A_V_M_Assessed_Value_Year_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping0 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_:\'\'),vanitycity(DEFAULT:Vanity_City_:\'\'),st(OVERRIDE:State_:\'\'),zip(OVERRIDE:Z_I_P5_:0),unformatted_apn(OVERRIDE:A_V_M_Unformatted_A_P_N_:\'\'),land_use(OVERRIDE:A_V_M_Land_Use_Code_:0),recording_date(OVERRIDE:A_V_M_Recording_Date_:DATE),assessed_value_year(OVERRIDE:A_V_M_Assessed_Value_Year_:DATE:A_V_M_Assessed_Value_Year_0Rule),sales_price(OVERRIDE:A_V_M_Sales_Price_:0),assessed_total_value(OVERRIDE:A_V_M_Assessed_Total_Value_:0),market_total_value(OVERRIDE:A_V_M_Market_Total_Value_:0),tax_assessment_valuation(OVERRIDE:A_V_M_Tax_Assessment_Valuation_:0),price_index_valuation(OVERRIDE:A_V_M_Price_Index_Valuation_:0),hedonic_valuation(OVERRIDE:A_V_M_Hedonic_Valuation_:0),automated_valuation(OVERRIDE:A_V_M_Automated_Valuation_:0),confidence_score(OVERRIDE:A_V_M_Confidence_Score_:0),iscurrent(OVERRIDE:A_V_M_Current_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),history_date(OVERRIDE:Date_First_Seen_:EPOCH|OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_AVM_V2__Key_AVM_Address,TRANSFORM(RECORDOF(__in.Dataset_AVM_V2__Key_AVM_Address),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_AVM_V2__Key_AVM_Address);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_AVM_V2__Key_AVM_Address_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping1 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unit_desig(OVERRIDE:Unit_Designation_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),p_city_name(OVERRIDE:Postal_City_:\'\'),v_city_name(OVERRIDE:Vanity_City_:\'\'),st(OVERRIDE:State_:\'\'),zip(OVERRIDE:Z_I_P5_:0),avmunformattedapn(DEFAULT:A_V_M_Unformatted_A_P_N_:\'\'),avmlandusecode(DEFAULT:A_V_M_Land_Use_Code_:0),avmrecordingdate(DEFAULT:A_V_M_Recording_Date_:DATE),avmassessedvalueyear(DEFAULT:A_V_M_Assessed_Value_Year_:DATE),avmsalesprice(DEFAULT:A_V_M_Sales_Price_:0),avmassessedtotalvalue(DEFAULT:A_V_M_Assessed_Total_Value_:0),avmmarkettotalvalue(DEFAULT:A_V_M_Market_Total_Value_:0),avmtaxassessmentvaluation(DEFAULT:A_V_M_Tax_Assessment_Valuation_:0),avmpriceindexvaluation(DEFAULT:A_V_M_Price_Index_Valuation_:0),avmhedonicvaluation(DEFAULT:A_V_M_Hedonic_Valuation_:0),avmautomatedvaluation(DEFAULT:A_V_M_Automated_Valuation_:0),avmconfidencescore(DEFAULT:A_V_M_Confidence_Score_:0),avmcurrentflag(DEFAULT:A_V_M_Current_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_PropertyV2__Key_Search_Fid,TRANSFORM(RECORDOF(__in.Dataset_PropertyV2__Key_Search_Fid),SELF:=RIGHT));
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_PropertyV2__Key_Search_Fid);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Search_Fid_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1;
  EXPORT Address_Components_Layout := RECORD
    KEL.typ.nstr Unit_Designation_;
    KEL.typ.nstr Postal_City_;
    KEL.typ.nstr Vanity_City_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Automated_Valuation_Model_Layout := RECORD
    KEL.typ.nstr A_V_M_Unformatted_A_P_N_;
    KEL.typ.nint A_V_M_Land_Use_Code_;
    KEL.typ.nkdate A_V_M_Recording_Date_;
    KEL.typ.nkdate A_V_M_Assessed_Value_Year_;
    KEL.typ.nint A_V_M_Sales_Price_;
    KEL.typ.nint A_V_M_Assessed_Total_Value_;
    KEL.typ.nint A_V_M_Market_Total_Value_;
    KEL.typ.nint A_V_M_Tax_Assessment_Valuation_;
    KEL.typ.nint A_V_M_Price_Index_Valuation_;
    KEL.typ.nint A_V_M_Hedonic_Valuation_;
    KEL.typ.nint A_V_M_Automated_Valuation_;
    KEL.typ.nint A_V_M_Confidence_Score_;
    KEL.typ.nbool A_V_M_Current_Flag_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ndataset(Address_Components_Layout) Address_Components_;
    KEL.typ.ndataset(Automated_Valuation_Model_Layout) Automated_Valuation_Model_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Property_Group := __PostFilter;
  Layout Property__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Primary_Range_ := KEL.Intake.SingleValue(__recs,Primary_Range_);
    SELF.Predirectional_ := KEL.Intake.SingleValue(__recs,Predirectional_);
    SELF.Primary_Name_ := KEL.Intake.SingleValue(__recs,Primary_Name_);
    SELF.Suffix_ := KEL.Intake.SingleValue(__recs,Suffix_);
    SELF.Postdirectional_ := KEL.Intake.SingleValue(__recs,Postdirectional_);
    SELF.Secondary_Range_ := KEL.Intake.SingleValue(__recs,Secondary_Range_);
    SELF.Z_I_P5_ := KEL.Intake.SingleValue(__recs,Z_I_P5_);
    SELF.Address_Components_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Unit_Designation_,Postal_City_,Vanity_City_,State_,Source_},Unit_Designation_,Postal_City_,Vanity_City_,State_,Source_),Address_Components_Layout)(__NN(Unit_Designation_) OR __NN(Postal_City_) OR __NN(Vanity_City_) OR __NN(State_) OR __NN(Source_)));
    SELF.Automated_Valuation_Model_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),A_V_M_Unformatted_A_P_N_,A_V_M_Land_Use_Code_,A_V_M_Recording_Date_,A_V_M_Assessed_Value_Year_,A_V_M_Sales_Price_,A_V_M_Assessed_Total_Value_,A_V_M_Market_Total_Value_,A_V_M_Tax_Assessment_Valuation_,A_V_M_Price_Index_Valuation_,A_V_M_Hedonic_Valuation_,A_V_M_Automated_Valuation_,A_V_M_Confidence_Score_,A_V_M_Current_Flag_},A_V_M_Unformatted_A_P_N_,A_V_M_Land_Use_Code_,A_V_M_Recording_Date_,A_V_M_Assessed_Value_Year_,A_V_M_Sales_Price_,A_V_M_Assessed_Total_Value_,A_V_M_Market_Total_Value_,A_V_M_Tax_Assessment_Valuation_,A_V_M_Price_Index_Valuation_,A_V_M_Hedonic_Valuation_,A_V_M_Automated_Valuation_,A_V_M_Confidence_Score_,A_V_M_Current_Flag_),Automated_Valuation_Model_Layout)(__NN(A_V_M_Unformatted_A_P_N_) OR __NN(A_V_M_Land_Use_Code_) OR __NN(A_V_M_Recording_Date_) OR __NN(A_V_M_Assessed_Value_Year_) OR __NN(A_V_M_Sales_Price_) OR __NN(A_V_M_Assessed_Total_Value_) OR __NN(A_V_M_Market_Total_Value_) OR __NN(A_V_M_Tax_Assessment_Valuation_) OR __NN(A_V_M_Price_Index_Valuation_) OR __NN(A_V_M_Hedonic_Valuation_) OR __NN(A_V_M_Automated_Valuation_) OR __NN(A_V_M_Confidence_Score_) OR __NN(A_V_M_Current_Flag_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Property__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Address_Components_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Address_Components_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Unit_Designation_) OR __NN(Postal_City_) OR __NN(Vanity_City_) OR __NN(State_) OR __NN(Source_)));
    SELF.Automated_Valuation_Model_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Automated_Valuation_Model_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(A_V_M_Unformatted_A_P_N_) OR __NN(A_V_M_Land_Use_Code_) OR __NN(A_V_M_Recording_Date_) OR __NN(A_V_M_Assessed_Value_Year_) OR __NN(A_V_M_Sales_Price_) OR __NN(A_V_M_Assessed_Total_Value_) OR __NN(A_V_M_Market_Total_Value_) OR __NN(A_V_M_Tax_Assessment_Valuation_) OR __NN(A_V_M_Price_Index_Valuation_) OR __NN(A_V_M_Hedonic_Valuation_) OR __NN(A_V_M_Automated_Valuation_) OR __NN(A_V_M_Confidence_Score_) OR __NN(A_V_M_Current_Flag_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Property_Group,COUNT(ROWS(LEFT))=1),GROUP,Property__Single_Rollup(LEFT)) + ROLLUP(HAVING(Property_Group,COUNT(ROWS(LEFT))>1),GROUP,Property__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Primary_Range__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Primary_Range_);
  EXPORT Predirectional__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Predirectional_);
  EXPORT Primary_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Primary_Name_);
  EXPORT Suffix__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Suffix_);
  EXPORT Postdirectional__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Postdirectional_);
  EXPORT Secondary_Range__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Secondary_Range_);
  EXPORT Z_I_P5__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Z_I_P5_);
  EXPORT Z_I_P5__Orphan := JOIN(InData(__NN(Z_I_P5_)),E_Zip_Code(__in,__cfg).__Result,__EEQP(LEFT.Z_I_P5_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Z_I_P5__Orphan),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_AVM_V2__Key_AVM_Address_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Search_Fid_Invalid),COUNT(Primary_Range__SingleValue_Invalid),COUNT(Predirectional__SingleValue_Invalid),COUNT(Primary_Name__SingleValue_Invalid),COUNT(Suffix__SingleValue_Invalid),COUNT(Postdirectional__SingleValue_Invalid),COUNT(Secondary_Range__SingleValue_Invalid),COUNT(Z_I_P5__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int Z_I_P5__Orphan,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_AVM_V2__Key_AVM_Address_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Search_Fid_Invalid,KEL.typ.int Primary_Range__SingleValue_Invalid,KEL.typ.int Predirectional__SingleValue_Invalid,KEL.typ.int Primary_Name__SingleValue_Invalid,KEL.typ.int Suffix__SingleValue_Invalid,KEL.typ.int Postdirectional__SingleValue_Invalid,KEL.typ.int Secondary_Range__SingleValue_Invalid,KEL.typ.int Z_I_P5__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_AVM_V2__Key_AVM_Address_Invalid),COUNT(__d0)},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d0(__NL(Primary_Range_))),COUNT(__d0(__NN(Primary_Range_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d0(__NL(Predirectional_))),COUNT(__d0(__NN(Predirectional_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d0(__NL(Primary_Name_))),COUNT(__d0(__NN(Primary_Name_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d0(__NL(Suffix_))),COUNT(__d0(__NN(Suffix_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d0(__NL(Postdirectional_))),COUNT(__d0(__NN(Postdirectional_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UnitDesignation',COUNT(__d0(__NL(Unit_Designation_))),COUNT(__d0(__NN(Unit_Designation_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d0(__NL(Secondary_Range_))),COUNT(__d0(__NN(Secondary_Range_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PostalCity',COUNT(__d0(__NL(Postal_City_))),COUNT(__d0(__NN(Postal_City_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VanityCity',COUNT(__d0(__NL(Vanity_City_))),COUNT(__d0(__NN(Vanity_City_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d0(__NL(State_))),COUNT(__d0(__NN(State_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d0(__NL(Z_I_P5_))),COUNT(__d0(__NN(Z_I_P5_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','unformatted_apn',COUNT(__d0(__NL(A_V_M_Unformatted_A_P_N_))),COUNT(__d0(__NN(A_V_M_Unformatted_A_P_N_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','land_use',COUNT(__d0(__NL(A_V_M_Land_Use_Code_))),COUNT(__d0(__NN(A_V_M_Land_Use_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','recording_date',COUNT(__d0(__NL(A_V_M_Recording_Date_))),COUNT(__d0(__NN(A_V_M_Recording_Date_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','assessed_value_year',COUNT(__d0(__NL(A_V_M_Assessed_Value_Year_))),COUNT(__d0(__NN(A_V_M_Assessed_Value_Year_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sales_price',COUNT(__d0(__NL(A_V_M_Sales_Price_))),COUNT(__d0(__NN(A_V_M_Sales_Price_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','assessed_total_value',COUNT(__d0(__NL(A_V_M_Assessed_Total_Value_))),COUNT(__d0(__NN(A_V_M_Assessed_Total_Value_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','market_total_value',COUNT(__d0(__NL(A_V_M_Market_Total_Value_))),COUNT(__d0(__NN(A_V_M_Market_Total_Value_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tax_assessment_valuation',COUNT(__d0(__NL(A_V_M_Tax_Assessment_Valuation_))),COUNT(__d0(__NN(A_V_M_Tax_Assessment_Valuation_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','price_index_valuation',COUNT(__d0(__NL(A_V_M_Price_Index_Valuation_))),COUNT(__d0(__NN(A_V_M_Price_Index_Valuation_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','hedonic_valuation',COUNT(__d0(__NL(A_V_M_Hedonic_Valuation_))),COUNT(__d0(__NN(A_V_M_Hedonic_Valuation_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','automated_valuation',COUNT(__d0(__NL(A_V_M_Automated_Valuation_))),COUNT(__d0(__NN(A_V_M_Automated_Valuation_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','confidence_score',COUNT(__d0(__NL(A_V_M_Confidence_Score_))),COUNT(__d0(__NN(A_V_M_Confidence_Score_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','iscurrent',COUNT(__d0(__NL(A_V_M_Current_Flag_))),COUNT(__d0(__NN(A_V_M_Current_Flag_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PropertyV2__Key_Search_Fid_Invalid),COUNT(__d1)},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d1(__NL(Primary_Range_))),COUNT(__d1(__NN(Primary_Range_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d1(__NL(Predirectional_))),COUNT(__d1(__NN(Predirectional_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d1(__NL(Primary_Name_))),COUNT(__d1(__NN(Primary_Name_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d1(__NL(Suffix_))),COUNT(__d1(__NN(Suffix_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d1(__NL(Postdirectional_))),COUNT(__d1(__NN(Postdirectional_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','unit_desig',COUNT(__d1(__NL(Unit_Designation_))),COUNT(__d1(__NN(Unit_Designation_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d1(__NL(Secondary_Range_))),COUNT(__d1(__NN(Secondary_Range_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','p_city_name',COUNT(__d1(__NL(Postal_City_))),COUNT(__d1(__NN(Postal_City_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','v_city_name',COUNT(__d1(__NL(Vanity_City_))),COUNT(__d1(__NN(Vanity_City_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d1(__NL(State_))),COUNT(__d1(__NN(State_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d1(__NL(Z_I_P5_))),COUNT(__d1(__NN(Z_I_P5_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMUnformattedAPN',COUNT(__d1(__NL(A_V_M_Unformatted_A_P_N_))),COUNT(__d1(__NN(A_V_M_Unformatted_A_P_N_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMLandUseCode',COUNT(__d1(__NL(A_V_M_Land_Use_Code_))),COUNT(__d1(__NN(A_V_M_Land_Use_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMRecordingDate',COUNT(__d1(__NL(A_V_M_Recording_Date_))),COUNT(__d1(__NN(A_V_M_Recording_Date_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMAssessedValueYear',COUNT(__d1(__NL(A_V_M_Assessed_Value_Year_))),COUNT(__d1(__NN(A_V_M_Assessed_Value_Year_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMSalesPrice',COUNT(__d1(__NL(A_V_M_Sales_Price_))),COUNT(__d1(__NN(A_V_M_Sales_Price_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMAssessedTotalValue',COUNT(__d1(__NL(A_V_M_Assessed_Total_Value_))),COUNT(__d1(__NN(A_V_M_Assessed_Total_Value_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMMarketTotalValue',COUNT(__d1(__NL(A_V_M_Market_Total_Value_))),COUNT(__d1(__NN(A_V_M_Market_Total_Value_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMTaxAssessmentValuation',COUNT(__d1(__NL(A_V_M_Tax_Assessment_Valuation_))),COUNT(__d1(__NN(A_V_M_Tax_Assessment_Valuation_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMPriceIndexValuation',COUNT(__d1(__NL(A_V_M_Price_Index_Valuation_))),COUNT(__d1(__NN(A_V_M_Price_Index_Valuation_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMHedonicValuation',COUNT(__d1(__NL(A_V_M_Hedonic_Valuation_))),COUNT(__d1(__NN(A_V_M_Hedonic_Valuation_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMAutomatedValuation',COUNT(__d1(__NL(A_V_M_Automated_Valuation_))),COUNT(__d1(__NN(A_V_M_Automated_Valuation_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMConfidenceScore',COUNT(__d1(__NL(A_V_M_Confidence_Score_))),COUNT(__d1(__NN(A_V_M_Confidence_Score_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMCurrentFlag',COUNT(__d1(__NL(A_V_M_Current_Flag_))),COUNT(__d1(__NN(A_V_M_Current_Flag_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
