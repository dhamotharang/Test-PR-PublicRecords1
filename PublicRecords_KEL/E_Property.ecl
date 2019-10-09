//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
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
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(DEFAULT:UID),primaryrange(DEFAULT:Primary_Range_:\'\'),predirectional(DEFAULT:Predirectional_:\'\'),primaryname(DEFAULT:Primary_Name_:\'\'),suffix(DEFAULT:Suffix_:\'\'),postdirectional(DEFAULT:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_:\'\'),secondaryrange(DEFAULT:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_:\'\'),vanitycity(DEFAULT:Vanity_City_:\'\'),state(DEFAULT:State_:\'\'),zip5(DEFAULT:Z_I_P5_:0),avmunformattedapn(DEFAULT:A_V_M_Unformatted_A_P_N_:\'\'),avmlandusecode(DEFAULT:A_V_M_Land_Use_Code_:0),avmrecordingdate(DEFAULT:A_V_M_Recording_Date_:DATE),avmassessedvalueyear(DEFAULT:A_V_M_Assessed_Value_Year_:DATE),avmsalesprice(DEFAULT:A_V_M_Sales_Price_:0),avmassessedtotalvalue(DEFAULT:A_V_M_Assessed_Total_Value_:0),avmmarkettotalvalue(DEFAULT:A_V_M_Market_Total_Value_:0),avmtaxassessmentvaluation(DEFAULT:A_V_M_Tax_Assessment_Valuation_:0),avmpriceindexvaluation(DEFAULT:A_V_M_Price_Index_Valuation_:0),avmhedonicvaluation(DEFAULT:A_V_M_Hedonic_Valuation_:0),avmautomatedvaluation(DEFAULT:A_V_M_Automated_Valuation_:0),avmconfidencescore(DEFAULT:A_V_M_Confidence_Score_:0),avmcurrentflag(DEFAULT:A_V_M_Current_Flag_),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.PrimaryRange) + '|' + TRIM((STRING)LEFT.Predirectional) + '|' + TRIM((STRING)LEFT.PrimaryName) + '|' + TRIM((STRING)LEFT.Suffix) + '|' + TRIM((STRING)LEFT.Postdirectional) + '|' + TRIM((STRING)LEFT.ZIP5) + '|' + TRIM((STRING)LEFT.SecondaryRange)));
  EXPORT __All_Trim := __d0_Trim;
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
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__in,Lookup,TRIM((STRING)LEFT.PrimaryRange) + '|' + TRIM((STRING)LEFT.Predirectional) + '|' + TRIM((STRING)LEFT.PrimaryName) + '|' + TRIM((STRING)LEFT.Suffix) + '|' + TRIM((STRING)LEFT.Postdirectional) + '|' + TRIM((STRING)LEFT.ZIP5) + '|' + TRIM((STRING)LEFT.SecondaryRange) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0;
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Vendor_Dates_Layout := RECORD
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
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
    KEL.typ.ndataset(Automated_Valuation_Model_Layout) Automated_Valuation_Model_;
    KEL.typ.ndataset(Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
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
    SELF.Unit_Designation_ := KEL.Intake.SingleValue(__recs,Unit_Designation_);
    SELF.Secondary_Range_ := KEL.Intake.SingleValue(__recs,Secondary_Range_);
    SELF.Postal_City_ := KEL.Intake.SingleValue(__recs,Postal_City_);
    SELF.Vanity_City_ := KEL.Intake.SingleValue(__recs,Vanity_City_);
    SELF.State_ := KEL.Intake.SingleValue(__recs,State_);
    SELF.Z_I_P5_ := KEL.Intake.SingleValue(__recs,Z_I_P5_);
    SELF.Automated_Valuation_Model_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),A_V_M_Unformatted_A_P_N_,A_V_M_Land_Use_Code_,A_V_M_Recording_Date_,A_V_M_Assessed_Value_Year_,A_V_M_Sales_Price_,A_V_M_Assessed_Total_Value_,A_V_M_Market_Total_Value_,A_V_M_Tax_Assessment_Valuation_,A_V_M_Price_Index_Valuation_,A_V_M_Hedonic_Valuation_,A_V_M_Automated_Valuation_,A_V_M_Confidence_Score_,A_V_M_Current_Flag_},A_V_M_Unformatted_A_P_N_,A_V_M_Land_Use_Code_,A_V_M_Recording_Date_,A_V_M_Assessed_Value_Year_,A_V_M_Sales_Price_,A_V_M_Assessed_Total_Value_,A_V_M_Market_Total_Value_,A_V_M_Tax_Assessment_Valuation_,A_V_M_Price_Index_Valuation_,A_V_M_Hedonic_Valuation_,A_V_M_Automated_Valuation_,A_V_M_Confidence_Score_,A_V_M_Current_Flag_),Automated_Valuation_Model_Layout)(__NN(A_V_M_Unformatted_A_P_N_) OR __NN(A_V_M_Land_Use_Code_) OR __NN(A_V_M_Recording_Date_) OR __NN(A_V_M_Assessed_Value_Year_) OR __NN(A_V_M_Sales_Price_) OR __NN(A_V_M_Assessed_Total_Value_) OR __NN(A_V_M_Market_Total_Value_) OR __NN(A_V_M_Tax_Assessment_Valuation_) OR __NN(A_V_M_Price_Index_Valuation_) OR __NN(A_V_M_Hedonic_Valuation_) OR __NN(A_V_M_Automated_Valuation_) OR __NN(A_V_M_Confidence_Score_) OR __NN(A_V_M_Current_Flag_)));
    SELF.Vendor_Dates_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_},Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_),Vendor_Dates_Layout)(__NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Property__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Automated_Valuation_Model_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Automated_Valuation_Model_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(A_V_M_Unformatted_A_P_N_) OR __NN(A_V_M_Land_Use_Code_) OR __NN(A_V_M_Recording_Date_) OR __NN(A_V_M_Assessed_Value_Year_) OR __NN(A_V_M_Sales_Price_) OR __NN(A_V_M_Assessed_Total_Value_) OR __NN(A_V_M_Market_Total_Value_) OR __NN(A_V_M_Tax_Assessment_Valuation_) OR __NN(A_V_M_Price_Index_Valuation_) OR __NN(A_V_M_Hedonic_Valuation_) OR __NN(A_V_M_Automated_Valuation_) OR __NN(A_V_M_Confidence_Score_) OR __NN(A_V_M_Current_Flag_)));
    SELF.Vendor_Dates_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Vendor_Dates_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Property_Group,COUNT(ROWS(LEFT))=1),GROUP,Property__Single_Rollup(LEFT)) + ROLLUP(HAVING(Property_Group,COUNT(ROWS(LEFT))>1),GROUP,Property__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Primary_Range__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Primary_Range_);
  EXPORT Predirectional__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Predirectional_);
  EXPORT Primary_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Primary_Name_);
  EXPORT Suffix__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Suffix_);
  EXPORT Postdirectional__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Postdirectional_);
  EXPORT Unit_Designation__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Unit_Designation_);
  EXPORT Secondary_Range__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Secondary_Range_);
  EXPORT Postal_City__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Postal_City_);
  EXPORT Vanity_City__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vanity_City_);
  EXPORT State__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,State_);
  EXPORT Z_I_P5__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Z_I_P5_);
  EXPORT Z_I_P5__Orphan := JOIN(InData(__NN(Z_I_P5_)),E_Zip_Code(__in,__cfg).__Result,__EEQP(LEFT.Z_I_P5_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Z_I_P5__Orphan),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(Primary_Range__SingleValue_Invalid),COUNT(Predirectional__SingleValue_Invalid),COUNT(Primary_Name__SingleValue_Invalid),COUNT(Suffix__SingleValue_Invalid),COUNT(Postdirectional__SingleValue_Invalid),COUNT(Unit_Designation__SingleValue_Invalid),COUNT(Secondary_Range__SingleValue_Invalid),COUNT(Postal_City__SingleValue_Invalid),COUNT(Vanity_City__SingleValue_Invalid),COUNT(State__SingleValue_Invalid),COUNT(Z_I_P5__SingleValue_Invalid)}],{KEL.typ.int Z_I_P5__Orphan,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid,KEL.typ.int Primary_Range__SingleValue_Invalid,KEL.typ.int Predirectional__SingleValue_Invalid,KEL.typ.int Primary_Name__SingleValue_Invalid,KEL.typ.int Suffix__SingleValue_Invalid,KEL.typ.int Postdirectional__SingleValue_Invalid,KEL.typ.int Unit_Designation__SingleValue_Invalid,KEL.typ.int Secondary_Range__SingleValue_Invalid,KEL.typ.int Postal_City__SingleValue_Invalid,KEL.typ.int Vanity_City__SingleValue_Invalid,KEL.typ.int State__SingleValue_Invalid,KEL.typ.int Z_I_P5__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(__d0)},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryRange',COUNT(__d0(__NL(Primary_Range_))),COUNT(__d0(__NN(Primary_Range_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Predirectional',COUNT(__d0(__NL(Predirectional_))),COUNT(__d0(__NN(Predirectional_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryName',COUNT(__d0(__NL(Primary_Name_))),COUNT(__d0(__NN(Primary_Name_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Suffix',COUNT(__d0(__NL(Suffix_))),COUNT(__d0(__NN(Suffix_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Postdirectional',COUNT(__d0(__NL(Postdirectional_))),COUNT(__d0(__NN(Postdirectional_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UnitDesignation',COUNT(__d0(__NL(Unit_Designation_))),COUNT(__d0(__NN(Unit_Designation_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondaryRange',COUNT(__d0(__NL(Secondary_Range_))),COUNT(__d0(__NN(Secondary_Range_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PostalCity',COUNT(__d0(__NL(Postal_City_))),COUNT(__d0(__NN(Postal_City_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VanityCity',COUNT(__d0(__NL(Vanity_City_))),COUNT(__d0(__NN(Vanity_City_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','State',COUNT(__d0(__NL(State_))),COUNT(__d0(__NN(State_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZIP5',COUNT(__d0(__NL(Z_I_P5_))),COUNT(__d0(__NN(Z_I_P5_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMUnformattedAPN',COUNT(__d0(__NL(A_V_M_Unformatted_A_P_N_))),COUNT(__d0(__NN(A_V_M_Unformatted_A_P_N_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMLandUseCode',COUNT(__d0(__NL(A_V_M_Land_Use_Code_))),COUNT(__d0(__NN(A_V_M_Land_Use_Code_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMRecordingDate',COUNT(__d0(__NL(A_V_M_Recording_Date_))),COUNT(__d0(__NN(A_V_M_Recording_Date_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMAssessedValueYear',COUNT(__d0(__NL(A_V_M_Assessed_Value_Year_))),COUNT(__d0(__NN(A_V_M_Assessed_Value_Year_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMSalesPrice',COUNT(__d0(__NL(A_V_M_Sales_Price_))),COUNT(__d0(__NN(A_V_M_Sales_Price_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMAssessedTotalValue',COUNT(__d0(__NL(A_V_M_Assessed_Total_Value_))),COUNT(__d0(__NN(A_V_M_Assessed_Total_Value_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMMarketTotalValue',COUNT(__d0(__NL(A_V_M_Market_Total_Value_))),COUNT(__d0(__NN(A_V_M_Market_Total_Value_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMTaxAssessmentValuation',COUNT(__d0(__NL(A_V_M_Tax_Assessment_Valuation_))),COUNT(__d0(__NN(A_V_M_Tax_Assessment_Valuation_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMPriceIndexValuation',COUNT(__d0(__NL(A_V_M_Price_Index_Valuation_))),COUNT(__d0(__NN(A_V_M_Price_Index_Valuation_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMHedonicValuation',COUNT(__d0(__NL(A_V_M_Hedonic_Valuation_))),COUNT(__d0(__NN(A_V_M_Hedonic_Valuation_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMAutomatedValuation',COUNT(__d0(__NL(A_V_M_Automated_Valuation_))),COUNT(__d0(__NN(A_V_M_Automated_Valuation_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMConfidenceScore',COUNT(__d0(__NL(A_V_M_Confidence_Score_))),COUNT(__d0(__NN(A_V_M_Confidence_Score_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AVMCurrentFlag',COUNT(__d0(__NL(A_V_M_Current_Flag_))),COUNT(__d0(__NN(A_V_M_Current_Flag_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d0(__NL(Date_Vendor_First_Reported_))),COUNT(__d0(__NN(Date_Vendor_First_Reported_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d0(__NL(Date_Vendor_Last_Reported_))),COUNT(__d0(__NN(Date_Vendor_Last_Reported_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Property','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
