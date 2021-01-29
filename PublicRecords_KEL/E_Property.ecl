//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_Property(CFG_Compile __cfg = CFG_Compile) := MODULE
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
  SHARED __d0_KELfiltered := PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0);
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  SHARED __d1_KELfiltered := PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND propertyaddress);
  SHARED __d1_Trim := PROJECT(__d1_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  SHARED __d2_KELfiltered := PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0);
  SHARED __d2_Trim := PROJECT(__d2_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  SHARED __d3_KELfiltered := PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND propertyaddress);
  SHARED __d3_Trim := PROJECT(__d3_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim + __d2_Trim + __d3_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'') + '|' + TRIM((STRING)'') + '|' + TRIM((STRING)'') + '|' + TRIM((STRING)'') + '|' + TRIM((STRING)'') + '|' + TRIM((STRING)0) + '|' + TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::PublicRecords_KEL::Property::UidLookup',EXPIRE(7));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::PublicRecords_KEL::Property');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::PublicRecords_KEL::Property');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED A_V_M_Assessed_Value_Year_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping0 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_:\'\'),vanitycity(DEFAULT:Vanity_City_:\'\'),st(OVERRIDE:State_:\'\'),zip(OVERRIDE:Z_I_P5_:0),unformatted_apn(OVERRIDE:A_V_M_Unformatted_A_P_N_:\'\'),land_use(OVERRIDE:A_V_M_Land_Use_Code_:0),recording_date(OVERRIDE:A_V_M_Recording_Date_:DATE),assessed_value_year(OVERRIDE:A_V_M_Assessed_Value_Year_:DATE:A_V_M_Assessed_Value_Year_0Rule),sales_price(OVERRIDE:A_V_M_Sales_Price_:0),assessed_total_value(OVERRIDE:A_V_M_Assessed_Total_Value_:0),market_total_value(OVERRIDE:A_V_M_Market_Total_Value_:0),tax_assessment_valuation(OVERRIDE:A_V_M_Tax_Assessment_Valuation_:0),price_index_valuation(OVERRIDE:A_V_M_Price_Index_Valuation_:0),hedonic_valuation(OVERRIDE:A_V_M_Hedonic_Valuation_:0),automated_valuation(OVERRIDE:A_V_M_Automated_Valuation_:0),confidence_score(OVERRIDE:A_V_M_Confidence_Score_:0),iscurrent(OVERRIDE:A_V_M_Current_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),history_date(OVERRIDE:Date_First_Seen_:EPOCH|OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_NonFCRA_AVM_V2__Key_AVM_Address_Vault_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault'));
  SHARED __Mapping1 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unit_desig(OVERRIDE:Unit_Designation_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),p_city_name(OVERRIDE:Postal_City_:\'\'),v_city_name(OVERRIDE:Vanity_City_:\'\'),st(OVERRIDE:State_:\'\'),zip(OVERRIDE:Z_I_P5_:0),avmunformattedapn(DEFAULT:A_V_M_Unformatted_A_P_N_:\'\'),avmlandusecode(DEFAULT:A_V_M_Land_Use_Code_:0),avmrecordingdate(DEFAULT:A_V_M_Recording_Date_:DATE),avmassessedvalueyear(DEFAULT:A_V_M_Assessed_Value_Year_:DATE),avmsalesprice(DEFAULT:A_V_M_Sales_Price_:0),avmassessedtotalvalue(DEFAULT:A_V_M_Assessed_Total_Value_:0),avmmarkettotalvalue(DEFAULT:A_V_M_Market_Total_Value_:0),avmtaxassessmentvaluation(DEFAULT:A_V_M_Tax_Assessment_Valuation_:0),avmpriceindexvaluation(DEFAULT:A_V_M_Price_Index_Valuation_:0),avmhedonicvaluation(DEFAULT:A_V_M_Hedonic_Valuation_:0),avmautomatedvaluation(DEFAULT:A_V_M_Automated_Valuation_:0),avmconfidencescore(DEFAULT:A_V_M_Confidence_Score_:0),avmcurrentflag(DEFAULT:A_V_M_Current_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_NonFCRA_LN_PropertyV2__key_search_fid_vault_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault'));
  SHARED A_V_M_Assessed_Value_Year_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Hybrid_Archive_Date_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping2 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_:\'\'),vanitycity(DEFAULT:Vanity_City_:\'\'),st(OVERRIDE:State_:\'\'),zip(OVERRIDE:Z_I_P5_:0),unformatted_apn(OVERRIDE:A_V_M_Unformatted_A_P_N_:\'\'),land_use(OVERRIDE:A_V_M_Land_Use_Code_:0),recording_date(OVERRIDE:A_V_M_Recording_Date_:DATE),assessed_value_year(OVERRIDE:A_V_M_Assessed_Value_Year_:DATE:A_V_M_Assessed_Value_Year_2Rule),sales_price(OVERRIDE:A_V_M_Sales_Price_:0),assessed_total_value(OVERRIDE:A_V_M_Assessed_Total_Value_:0),market_total_value(OVERRIDE:A_V_M_Market_Total_Value_:0),tax_assessment_valuation(OVERRIDE:A_V_M_Tax_Assessment_Valuation_:0),price_index_valuation(OVERRIDE:A_V_M_Price_Index_Valuation_:0),hedonic_valuation(OVERRIDE:A_V_M_Hedonic_Valuation_:0),automated_valuation(OVERRIDE:A_V_M_Automated_Valuation_:0),confidence_score(OVERRIDE:A_V_M_Confidence_Score_:0),iscurrent(OVERRIDE:A_V_M_Current_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),history_date(OVERRIDE:Date_First_Seen_:EPOCH|OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_2Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d2_UID_Mapped := JOIN(__d2_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d2_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_FCRA_AVM_V2__Key_AVM_Address_FCRA_Vault_Invalid := __d2_UID_Mapped(UID = 0);
  SHARED __d2_Prefiltered := __d2_UID_Mapped(UID <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault'));
  SHARED __Mapping3 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unit_desig(OVERRIDE:Unit_Designation_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),p_city_name(OVERRIDE:Postal_City_:\'\'),v_city_name(OVERRIDE:Vanity_City_:\'\'),st(OVERRIDE:State_:\'\'),zip(OVERRIDE:Z_I_P5_:0),avmunformattedapn(DEFAULT:A_V_M_Unformatted_A_P_N_:\'\'),avmlandusecode(DEFAULT:A_V_M_Land_Use_Code_:0),avmrecordingdate(DEFAULT:A_V_M_Recording_Date_:DATE),avmassessedvalueyear(DEFAULT:A_V_M_Assessed_Value_Year_:DATE),avmsalesprice(DEFAULT:A_V_M_Sales_Price_:0),avmassessedtotalvalue(DEFAULT:A_V_M_Assessed_Total_Value_:0),avmmarkettotalvalue(DEFAULT:A_V_M_Market_Total_Value_:0),avmtaxassessmentvaluation(DEFAULT:A_V_M_Tax_Assessment_Valuation_:0),avmpriceindexvaluation(DEFAULT:A_V_M_Price_Index_Valuation_:0),avmhedonicvaluation(DEFAULT:A_V_M_Hedonic_Valuation_:0),avmautomatedvaluation(DEFAULT:A_V_M_Automated_Valuation_:0),avmconfidencescore(DEFAULT:A_V_M_Confidence_Score_:0),avmcurrentflag(DEFAULT:A_V_M_Current_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d3_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d3_UID_Mapped := JOIN(__d3_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d3_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_FCRA_LN_PropertyV2__key_search_fid_vault_Invalid := __d3_UID_Mapped(UID = 0);
  SHARED __d3_Prefiltered := __d3_UID_Mapped(UID <> 0);
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3;
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
  EXPORT Z_I_P5__Orphan := JOIN(InData(__NN(Z_I_P5_)),E_Zip_Code(__cfg).__Result,__EEQP(LEFT.Z_I_P5_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Z_I_P5__Orphan),COUNT(PublicRecords_KEL_Files_NonFCRA_AVM_V2__Key_AVM_Address_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_LN_PropertyV2__key_search_fid_vault_Invalid),COUNT(PublicRecords_KEL_Files_FCRA_AVM_V2__Key_AVM_Address_FCRA_Vault_Invalid),COUNT(PublicRecords_KEL_Files_FCRA_LN_PropertyV2__key_search_fid_vault_Invalid),COUNT(Primary_Range__SingleValue_Invalid),COUNT(Predirectional__SingleValue_Invalid),COUNT(Primary_Name__SingleValue_Invalid),COUNT(Suffix__SingleValue_Invalid),COUNT(Postdirectional__SingleValue_Invalid),COUNT(Secondary_Range__SingleValue_Invalid),COUNT(Z_I_P5__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int Z_I_P5__Orphan,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_AVM_V2__Key_AVM_Address_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_LN_PropertyV2__key_search_fid_vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_FCRA_AVM_V2__Key_AVM_Address_FCRA_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_FCRA_LN_PropertyV2__key_search_fid_vault_Invalid,KEL.typ.int Primary_Range__SingleValue_Invalid,KEL.typ.int Predirectional__SingleValue_Invalid,KEL.typ.int Primary_Name__SingleValue_Invalid,KEL.typ.int Suffix__SingleValue_Invalid,KEL.typ.int Postdirectional__SingleValue_Invalid,KEL.typ.int Secondary_Range__SingleValue_Invalid,KEL.typ.int Z_I_P5__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_AVM_V2__Key_AVM_Address_Vault_Invalid),COUNT(__d0)},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','prim_range',COUNT(__d0(__NL(Primary_Range_))),COUNT(__d0(__NN(Primary_Range_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','predir',COUNT(__d0(__NL(Predirectional_))),COUNT(__d0(__NN(Predirectional_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','prim_name',COUNT(__d0(__NL(Primary_Name_))),COUNT(__d0(__NN(Primary_Name_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','suffix',COUNT(__d0(__NL(Suffix_))),COUNT(__d0(__NN(Suffix_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','postdir',COUNT(__d0(__NL(Postdirectional_))),COUNT(__d0(__NN(Postdirectional_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','UnitDesignation',COUNT(__d0(__NL(Unit_Designation_))),COUNT(__d0(__NN(Unit_Designation_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','sec_range',COUNT(__d0(__NL(Secondary_Range_))),COUNT(__d0(__NN(Secondary_Range_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','PostalCity',COUNT(__d0(__NL(Postal_City_))),COUNT(__d0(__NN(Postal_City_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','VanityCity',COUNT(__d0(__NL(Vanity_City_))),COUNT(__d0(__NN(Vanity_City_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','st',COUNT(__d0(__NL(State_))),COUNT(__d0(__NN(State_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','zip',COUNT(__d0(__NL(Z_I_P5_))),COUNT(__d0(__NN(Z_I_P5_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','unformatted_apn',COUNT(__d0(__NL(A_V_M_Unformatted_A_P_N_))),COUNT(__d0(__NN(A_V_M_Unformatted_A_P_N_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','land_use',COUNT(__d0(__NL(A_V_M_Land_Use_Code_))),COUNT(__d0(__NN(A_V_M_Land_Use_Code_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','recording_date',COUNT(__d0(__NL(A_V_M_Recording_Date_))),COUNT(__d0(__NN(A_V_M_Recording_Date_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','assessed_value_year',COUNT(__d0(__NL(A_V_M_Assessed_Value_Year_))),COUNT(__d0(__NN(A_V_M_Assessed_Value_Year_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','sales_price',COUNT(__d0(__NL(A_V_M_Sales_Price_))),COUNT(__d0(__NN(A_V_M_Sales_Price_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','assessed_total_value',COUNT(__d0(__NL(A_V_M_Assessed_Total_Value_))),COUNT(__d0(__NN(A_V_M_Assessed_Total_Value_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','market_total_value',COUNT(__d0(__NL(A_V_M_Market_Total_Value_))),COUNT(__d0(__NN(A_V_M_Market_Total_Value_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','tax_assessment_valuation',COUNT(__d0(__NL(A_V_M_Tax_Assessment_Valuation_))),COUNT(__d0(__NN(A_V_M_Tax_Assessment_Valuation_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','price_index_valuation',COUNT(__d0(__NL(A_V_M_Price_Index_Valuation_))),COUNT(__d0(__NN(A_V_M_Price_Index_Valuation_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','hedonic_valuation',COUNT(__d0(__NL(A_V_M_Hedonic_Valuation_))),COUNT(__d0(__NN(A_V_M_Hedonic_Valuation_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','automated_valuation',COUNT(__d0(__NL(A_V_M_Automated_Valuation_))),COUNT(__d0(__NN(A_V_M_Automated_Valuation_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','confidence_score',COUNT(__d0(__NL(A_V_M_Confidence_Score_))),COUNT(__d0(__NN(A_V_M_Confidence_Score_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','iscurrent',COUNT(__d0(__NL(A_V_M_Current_Flag_))),COUNT(__d0(__NN(A_V_M_Current_Flag_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.AVM_V2__Key_AVM_Address_Vault','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_LN_PropertyV2__key_search_fid_vault_Invalid),COUNT(__d1)},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','prim_range',COUNT(__d1(__NL(Primary_Range_))),COUNT(__d1(__NN(Primary_Range_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','predir',COUNT(__d1(__NL(Predirectional_))),COUNT(__d1(__NN(Predirectional_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','prim_name',COUNT(__d1(__NL(Primary_Name_))),COUNT(__d1(__NN(Primary_Name_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','suffix',COUNT(__d1(__NL(Suffix_))),COUNT(__d1(__NN(Suffix_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','postdir',COUNT(__d1(__NL(Postdirectional_))),COUNT(__d1(__NN(Postdirectional_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','unit_desig',COUNT(__d1(__NL(Unit_Designation_))),COUNT(__d1(__NN(Unit_Designation_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','sec_range',COUNT(__d1(__NL(Secondary_Range_))),COUNT(__d1(__NN(Secondary_Range_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','p_city_name',COUNT(__d1(__NL(Postal_City_))),COUNT(__d1(__NN(Postal_City_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','v_city_name',COUNT(__d1(__NL(Vanity_City_))),COUNT(__d1(__NN(Vanity_City_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','st',COUNT(__d1(__NL(State_))),COUNT(__d1(__NN(State_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','zip',COUNT(__d1(__NL(Z_I_P5_))),COUNT(__d1(__NN(Z_I_P5_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','AVMUnformattedAPN',COUNT(__d1(__NL(A_V_M_Unformatted_A_P_N_))),COUNT(__d1(__NN(A_V_M_Unformatted_A_P_N_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','AVMLandUseCode',COUNT(__d1(__NL(A_V_M_Land_Use_Code_))),COUNT(__d1(__NN(A_V_M_Land_Use_Code_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','AVMRecordingDate',COUNT(__d1(__NL(A_V_M_Recording_Date_))),COUNT(__d1(__NN(A_V_M_Recording_Date_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','AVMAssessedValueYear',COUNT(__d1(__NL(A_V_M_Assessed_Value_Year_))),COUNT(__d1(__NN(A_V_M_Assessed_Value_Year_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','AVMSalesPrice',COUNT(__d1(__NL(A_V_M_Sales_Price_))),COUNT(__d1(__NN(A_V_M_Sales_Price_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','AVMAssessedTotalValue',COUNT(__d1(__NL(A_V_M_Assessed_Total_Value_))),COUNT(__d1(__NN(A_V_M_Assessed_Total_Value_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','AVMMarketTotalValue',COUNT(__d1(__NL(A_V_M_Market_Total_Value_))),COUNT(__d1(__NN(A_V_M_Market_Total_Value_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','AVMTaxAssessmentValuation',COUNT(__d1(__NL(A_V_M_Tax_Assessment_Valuation_))),COUNT(__d1(__NN(A_V_M_Tax_Assessment_Valuation_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','AVMPriceIndexValuation',COUNT(__d1(__NL(A_V_M_Price_Index_Valuation_))),COUNT(__d1(__NN(A_V_M_Price_Index_Valuation_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','AVMHedonicValuation',COUNT(__d1(__NL(A_V_M_Hedonic_Valuation_))),COUNT(__d1(__NN(A_V_M_Hedonic_Valuation_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','AVMAutomatedValuation',COUNT(__d1(__NL(A_V_M_Automated_Valuation_))),COUNT(__d1(__NN(A_V_M_Automated_Valuation_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','AVMConfidenceScore',COUNT(__d1(__NL(A_V_M_Confidence_Score_))),COUNT(__d1(__NN(A_V_M_Confidence_Score_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','AVMCurrentFlag',COUNT(__d1(__NL(A_V_M_Current_Flag_))),COUNT(__d1(__NN(A_V_M_Current_Flag_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'Property','PublicRecords_KEL.Files.NonFCRA.LN_PropertyV2__key_search_fid_vault','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','UID',COUNT(PublicRecords_KEL_Files_FCRA_AVM_V2__Key_AVM_Address_FCRA_Vault_Invalid),COUNT(__d2)},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','prim_range',COUNT(__d2(__NL(Primary_Range_))),COUNT(__d2(__NN(Primary_Range_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','predir',COUNT(__d2(__NL(Predirectional_))),COUNT(__d2(__NN(Predirectional_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','prim_name',COUNT(__d2(__NL(Primary_Name_))),COUNT(__d2(__NN(Primary_Name_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','suffix',COUNT(__d2(__NL(Suffix_))),COUNT(__d2(__NN(Suffix_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','postdir',COUNT(__d2(__NL(Postdirectional_))),COUNT(__d2(__NN(Postdirectional_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','UnitDesignation',COUNT(__d2(__NL(Unit_Designation_))),COUNT(__d2(__NN(Unit_Designation_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','sec_range',COUNT(__d2(__NL(Secondary_Range_))),COUNT(__d2(__NN(Secondary_Range_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','PostalCity',COUNT(__d2(__NL(Postal_City_))),COUNT(__d2(__NN(Postal_City_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','VanityCity',COUNT(__d2(__NL(Vanity_City_))),COUNT(__d2(__NN(Vanity_City_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','st',COUNT(__d2(__NL(State_))),COUNT(__d2(__NN(State_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','zip',COUNT(__d2(__NL(Z_I_P5_))),COUNT(__d2(__NN(Z_I_P5_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','unformatted_apn',COUNT(__d2(__NL(A_V_M_Unformatted_A_P_N_))),COUNT(__d2(__NN(A_V_M_Unformatted_A_P_N_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','land_use',COUNT(__d2(__NL(A_V_M_Land_Use_Code_))),COUNT(__d2(__NN(A_V_M_Land_Use_Code_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','recording_date',COUNT(__d2(__NL(A_V_M_Recording_Date_))),COUNT(__d2(__NN(A_V_M_Recording_Date_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','assessed_value_year',COUNT(__d2(__NL(A_V_M_Assessed_Value_Year_))),COUNT(__d2(__NN(A_V_M_Assessed_Value_Year_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','sales_price',COUNT(__d2(__NL(A_V_M_Sales_Price_))),COUNT(__d2(__NN(A_V_M_Sales_Price_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','assessed_total_value',COUNT(__d2(__NL(A_V_M_Assessed_Total_Value_))),COUNT(__d2(__NN(A_V_M_Assessed_Total_Value_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','market_total_value',COUNT(__d2(__NL(A_V_M_Market_Total_Value_))),COUNT(__d2(__NN(A_V_M_Market_Total_Value_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','tax_assessment_valuation',COUNT(__d2(__NL(A_V_M_Tax_Assessment_Valuation_))),COUNT(__d2(__NN(A_V_M_Tax_Assessment_Valuation_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','price_index_valuation',COUNT(__d2(__NL(A_V_M_Price_Index_Valuation_))),COUNT(__d2(__NN(A_V_M_Price_Index_Valuation_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','hedonic_valuation',COUNT(__d2(__NL(A_V_M_Hedonic_Valuation_))),COUNT(__d2(__NN(A_V_M_Hedonic_Valuation_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','automated_valuation',COUNT(__d2(__NL(A_V_M_Automated_Valuation_))),COUNT(__d2(__NN(A_V_M_Automated_Valuation_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','confidence_score',COUNT(__d2(__NL(A_V_M_Confidence_Score_))),COUNT(__d2(__NN(A_V_M_Confidence_Score_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','iscurrent',COUNT(__d2(__NL(A_V_M_Current_Flag_))),COUNT(__d2(__NN(A_V_M_Current_Flag_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'Property','PublicRecords_KEL.Files.FCRA.AVM_V2__Key_AVM_Address_FCRA_Vault','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','UID',COUNT(PublicRecords_KEL_Files_FCRA_LN_PropertyV2__key_search_fid_vault_Invalid),COUNT(__d3)},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','prim_range',COUNT(__d3(__NL(Primary_Range_))),COUNT(__d3(__NN(Primary_Range_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','predir',COUNT(__d3(__NL(Predirectional_))),COUNT(__d3(__NN(Predirectional_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','prim_name',COUNT(__d3(__NL(Primary_Name_))),COUNT(__d3(__NN(Primary_Name_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','suffix',COUNT(__d3(__NL(Suffix_))),COUNT(__d3(__NN(Suffix_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','postdir',COUNT(__d3(__NL(Postdirectional_))),COUNT(__d3(__NN(Postdirectional_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','unit_desig',COUNT(__d3(__NL(Unit_Designation_))),COUNT(__d3(__NN(Unit_Designation_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','sec_range',COUNT(__d3(__NL(Secondary_Range_))),COUNT(__d3(__NN(Secondary_Range_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','p_city_name',COUNT(__d3(__NL(Postal_City_))),COUNT(__d3(__NN(Postal_City_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','v_city_name',COUNT(__d3(__NL(Vanity_City_))),COUNT(__d3(__NN(Vanity_City_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','st',COUNT(__d3(__NL(State_))),COUNT(__d3(__NN(State_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','zip',COUNT(__d3(__NL(Z_I_P5_))),COUNT(__d3(__NN(Z_I_P5_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','AVMUnformattedAPN',COUNT(__d3(__NL(A_V_M_Unformatted_A_P_N_))),COUNT(__d3(__NN(A_V_M_Unformatted_A_P_N_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','AVMLandUseCode',COUNT(__d3(__NL(A_V_M_Land_Use_Code_))),COUNT(__d3(__NN(A_V_M_Land_Use_Code_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','AVMRecordingDate',COUNT(__d3(__NL(A_V_M_Recording_Date_))),COUNT(__d3(__NN(A_V_M_Recording_Date_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','AVMAssessedValueYear',COUNT(__d3(__NL(A_V_M_Assessed_Value_Year_))),COUNT(__d3(__NN(A_V_M_Assessed_Value_Year_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','AVMSalesPrice',COUNT(__d3(__NL(A_V_M_Sales_Price_))),COUNT(__d3(__NN(A_V_M_Sales_Price_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','AVMAssessedTotalValue',COUNT(__d3(__NL(A_V_M_Assessed_Total_Value_))),COUNT(__d3(__NN(A_V_M_Assessed_Total_Value_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','AVMMarketTotalValue',COUNT(__d3(__NL(A_V_M_Market_Total_Value_))),COUNT(__d3(__NN(A_V_M_Market_Total_Value_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','AVMTaxAssessmentValuation',COUNT(__d3(__NL(A_V_M_Tax_Assessment_Valuation_))),COUNT(__d3(__NN(A_V_M_Tax_Assessment_Valuation_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','AVMPriceIndexValuation',COUNT(__d3(__NL(A_V_M_Price_Index_Valuation_))),COUNT(__d3(__NN(A_V_M_Price_Index_Valuation_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','AVMHedonicValuation',COUNT(__d3(__NL(A_V_M_Hedonic_Valuation_))),COUNT(__d3(__NN(A_V_M_Hedonic_Valuation_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','AVMAutomatedValuation',COUNT(__d3(__NL(A_V_M_Automated_Valuation_))),COUNT(__d3(__NN(A_V_M_Automated_Valuation_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','AVMConfidenceScore',COUNT(__d3(__NL(A_V_M_Confidence_Score_))),COUNT(__d3(__NN(A_V_M_Confidence_Score_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','AVMCurrentFlag',COUNT(__d3(__NL(A_V_M_Current_Flag_))),COUNT(__d3(__NN(A_V_M_Current_Flag_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','HybridArchiveDate',COUNT(__d3(Hybrid_Archive_Date_=0)),COUNT(__d3(Hybrid_Archive_Date_!=0))},
    {'Property','PublicRecords_KEL.Files.FCRA.LN_PropertyV2__key_search_fid_vault','VaultDateLastSeen',COUNT(__d3(Vault_Date_Last_Seen_=0)),COUNT(__d3(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
