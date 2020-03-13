//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT E_Inquiry(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.nkdate Date_Of_Inquiry_;
    KEL.typ.nstr Time_Of_Inquiry_;
    KEL.typ.nstr Inquiry_Source_;
    KEL.typ.nstr Method_;
    KEL.typ.nint Product_Code_;
    KEL.typ.nstr Function_Description_;
    KEL.typ.nint G_L_B_Purpose_;
    KEL.typ.nint D_P_P_A_Purpose_;
    KEL.typ.nint F_C_R_A_Purpose_;
    KEL.typ.nstr Sub_Market_;
    KEL.typ.nstr Vertical_;
    KEL.typ.nstr Use_;
    KEL.typ.nstr Industry_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(DEFAULT:UID),transactionid(DEFAULT:Transaction_I_D_:\'\'),sequencenumber(DEFAULT:Sequence_Number_:\'\'),dateofinquiry(DEFAULT:Date_Of_Inquiry_:DATE),timeofinquiry(DEFAULT:Time_Of_Inquiry_:\'\'),inquirysource(DEFAULT:Inquiry_Source_:\'\'),method(DEFAULT:Method_:\'\'),productcode(DEFAULT:Product_Code_:0),functiondescription(DEFAULT:Function_Description_:\'\'),glbpurpose(DEFAULT:G_L_B_Purpose_:0),dppapurpose(DEFAULT:D_P_P_A_Purpose_:0),fcrapurpose(DEFAULT:F_C_R_A_Purpose_:0),submarket(DEFAULT:Sub_Market_:\'\'),vertical(DEFAULT:Vertical_:\'\'),use(DEFAULT:Use_:\'\'),industry(DEFAULT:Industry_:\'\'),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in.Dataset_Inquiry_AccLogs__Key_FCRA_DID,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number)));
  EXPORT __All_Trim := __d0_Trim;
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
  SHARED __Mapping0 := 'UID(DEFAULT:UID),search_info.transaction_id(OVERRIDE:Transaction_I_D_:\'\'),search_info.sequence_number(OVERRIDE:Sequence_Number_:\'\'),dateofinquiry(OVERRIDE:Date_Of_Inquiry_:DATE|OVERRIDE:Date_First_Seen_:EPOCH|OVERRIDE:Date_Last_Seen_:EPOCH),timeofinquiry(OVERRIDE:Time_Of_Inquiry_:\'\'),inquirysource(DEFAULT:Inquiry_Source_:\'\'),search_info.method(OVERRIDE:Method_:\'\'),search_info.product_code(OVERRIDE:Product_Code_:0),search_info.function_description(OVERRIDE:Function_Description_:\'\'),permissions.glb_purpose(OVERRIDE:G_L_B_Purpose_:0),permissions.dppa_purpose(OVERRIDE:D_P_P_A_Purpose_:0),permissions.fcra_purpose(OVERRIDE:F_C_R_A_Purpose_:0),bus_intel.sub_market(OVERRIDE:Sub_Market_:\'\'),bus_intel.vertical(OVERRIDE:Vertical_:\'\'),bus_intel.use(OVERRIDE:Use_:\'\'),bus_intel.industry(OVERRIDE:Industry_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Key_FCRA_DID,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Key_FCRA_DID),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Inquiry_AccLogs__Key_FCRA_DID);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_Norm,Lookup,TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_DID_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.nkdate Date_Of_Inquiry_;
    KEL.typ.nstr Time_Of_Inquiry_;
    KEL.typ.nstr Inquiry_Source_;
    KEL.typ.nstr Method_;
    KEL.typ.nint Product_Code_;
    KEL.typ.nstr Function_Description_;
    KEL.typ.nint G_L_B_Purpose_;
    KEL.typ.nint D_P_P_A_Purpose_;
    KEL.typ.nint F_C_R_A_Purpose_;
    KEL.typ.nstr Sub_Market_;
    KEL.typ.nstr Vertical_;
    KEL.typ.nstr Use_;
    KEL.typ.nstr Industry_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Inquiry_Group := __PostFilter;
  Layout Inquiry__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Transaction_I_D_ := KEL.Intake.SingleValue(__recs,Transaction_I_D_);
    SELF.Sequence_Number_ := KEL.Intake.SingleValue(__recs,Sequence_Number_);
    SELF.Date_Of_Inquiry_ := KEL.Intake.SingleValue(__recs,Date_Of_Inquiry_);
    SELF.Time_Of_Inquiry_ := KEL.Intake.SingleValue(__recs,Time_Of_Inquiry_);
    SELF.Inquiry_Source_ := KEL.Intake.SingleValue(__recs,Inquiry_Source_);
    SELF.Method_ := KEL.Intake.SingleValue(__recs,Method_);
    SELF.Product_Code_ := KEL.Intake.SingleValue(__recs,Product_Code_);
    SELF.Function_Description_ := KEL.Intake.SingleValue(__recs,Function_Description_);
    SELF.G_L_B_Purpose_ := KEL.Intake.SingleValue(__recs,G_L_B_Purpose_);
    SELF.D_P_P_A_Purpose_ := KEL.Intake.SingleValue(__recs,D_P_P_A_Purpose_);
    SELF.F_C_R_A_Purpose_ := KEL.Intake.SingleValue(__recs,F_C_R_A_Purpose_);
    SELF.Sub_Market_ := KEL.Intake.SingleValue(__recs,Sub_Market_);
    SELF.Vertical_ := KEL.Intake.SingleValue(__recs,Vertical_);
    SELF.Use_ := KEL.Intake.SingleValue(__recs,Use_);
    SELF.Industry_ := KEL.Intake.SingleValue(__recs,Industry_);
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_First_Reported_,MIN,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_Last_Reported_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Inquiry__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_First_Reported_,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_Last_Reported_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Inquiry_Group,COUNT(ROWS(LEFT))=1),GROUP,Inquiry__Single_Rollup(LEFT)) + ROLLUP(HAVING(Inquiry_Group,COUNT(ROWS(LEFT))>1),GROUP,Inquiry__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Transaction_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Transaction_I_D_);
  EXPORT Sequence_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sequence_Number_);
  EXPORT Date_Of_Inquiry__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Date_Of_Inquiry_);
  EXPORT Time_Of_Inquiry__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Time_Of_Inquiry_);
  EXPORT Inquiry_Source__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Inquiry_Source_);
  EXPORT Method__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Method_);
  EXPORT Product_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Product_Code_);
  EXPORT Function_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Function_Description_);
  EXPORT G_L_B_Purpose__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,G_L_B_Purpose_);
  EXPORT D_P_P_A_Purpose__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,D_P_P_A_Purpose_);
  EXPORT F_C_R_A_Purpose__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,F_C_R_A_Purpose_);
  EXPORT Sub_Market__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sub_Market_);
  EXPORT Vertical__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vertical_);
  EXPORT Use__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Use_);
  EXPORT Industry__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Industry_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_DID_Invalid),COUNT(Transaction_I_D__SingleValue_Invalid),COUNT(Sequence_Number__SingleValue_Invalid),COUNT(Date_Of_Inquiry__SingleValue_Invalid),COUNT(Time_Of_Inquiry__SingleValue_Invalid),COUNT(Inquiry_Source__SingleValue_Invalid),COUNT(Method__SingleValue_Invalid),COUNT(Product_Code__SingleValue_Invalid),COUNT(Function_Description__SingleValue_Invalid),COUNT(G_L_B_Purpose__SingleValue_Invalid),COUNT(D_P_P_A_Purpose__SingleValue_Invalid),COUNT(F_C_R_A_Purpose__SingleValue_Invalid),COUNT(Sub_Market__SingleValue_Invalid),COUNT(Vertical__SingleValue_Invalid),COUNT(Use__SingleValue_Invalid),COUNT(Industry__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_DID_Invalid,KEL.typ.int Transaction_I_D__SingleValue_Invalid,KEL.typ.int Sequence_Number__SingleValue_Invalid,KEL.typ.int Date_Of_Inquiry__SingleValue_Invalid,KEL.typ.int Time_Of_Inquiry__SingleValue_Invalid,KEL.typ.int Inquiry_Source__SingleValue_Invalid,KEL.typ.int Method__SingleValue_Invalid,KEL.typ.int Product_Code__SingleValue_Invalid,KEL.typ.int Function_Description__SingleValue_Invalid,KEL.typ.int G_L_B_Purpose__SingleValue_Invalid,KEL.typ.int D_P_P_A_Purpose__SingleValue_Invalid,KEL.typ.int F_C_R_A_Purpose__SingleValue_Invalid,KEL.typ.int Sub_Market__SingleValue_Invalid,KEL.typ.int Vertical__SingleValue_Invalid,KEL.typ.int Use__SingleValue_Invalid,KEL.typ.int Industry__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_DID_Invalid),COUNT(__d0)},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.transaction_id',COUNT(__d0(__NL(Transaction_I_D_))),COUNT(__d0(__NN(Transaction_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.sequence_number',COUNT(__d0(__NL(Sequence_Number_))),COUNT(__d0(__NN(Sequence_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dateofinquiry',COUNT(__d0(__NL(Date_Of_Inquiry_))),COUNT(__d0(__NN(Date_Of_Inquiry_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','timeofinquiry',COUNT(__d0(__NL(Time_Of_Inquiry_))),COUNT(__d0(__NN(Time_Of_Inquiry_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InquirySource',COUNT(__d0(__NL(Inquiry_Source_))),COUNT(__d0(__NN(Inquiry_Source_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.method',COUNT(__d0(__NL(Method_))),COUNT(__d0(__NN(Method_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.product_code',COUNT(__d0(__NL(Product_Code_))),COUNT(__d0(__NN(Product_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.function_description',COUNT(__d0(__NL(Function_Description_))),COUNT(__d0(__NN(Function_Description_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.glb_purpose',COUNT(__d0(__NL(G_L_B_Purpose_))),COUNT(__d0(__NN(G_L_B_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.dppa_purpose',COUNT(__d0(__NL(D_P_P_A_Purpose_))),COUNT(__d0(__NN(D_P_P_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','permissions.fcra_purpose',COUNT(__d0(__NL(F_C_R_A_Purpose_))),COUNT(__d0(__NN(F_C_R_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.sub_market',COUNT(__d0(__NL(Sub_Market_))),COUNT(__d0(__NN(Sub_Market_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.vertical',COUNT(__d0(__NL(Vertical_))),COUNT(__d0(__NN(Vertical_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.use',COUNT(__d0(__NL(Use_))),COUNT(__d0(__NN(Use_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bus_intel.industry',COUNT(__d0(__NL(Industry_))),COUNT(__d0(__NN(Industry_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d0(Date_Vendor_First_Reported_=0)),COUNT(__d0(Date_Vendor_First_Reported_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d0(Date_Vendor_Last_Reported_=0)),COUNT(__d0(Date_Vendor_Last_Reported_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
