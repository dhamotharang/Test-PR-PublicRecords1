//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Inquiry(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nkdate Date_Of_Inquiry_;
    KEL.typ.nstr Time_Of_Inquiry_;
    KEL.typ.nstr Inquiry_Source_;
    KEL.typ.nstr Sequence_Number_;
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),transactionid(Transaction_I_D_:\'\'),dateofinquiry(Date_Of_Inquiry_:DATE),timeofinquiry(Time_Of_Inquiry_:\'\'),inquirysource(Inquiry_Source_:\'\'),sequencenumber(Sequence_Number_:\'\'),method(Method_:\'\'),productcode(Product_Code_:0),functiondescription(Function_Description_:\'\'),glbpurpose(G_L_B_Purpose_:0),dppapurpose(D_P_P_A_Purpose_:0),fcrapurpose(F_C_R_A_Purpose_:0),submarket(Sub_Market_:\'\'),vertical(Vertical_:\'\'),use(Use_:\'\'),industry(Industry_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.TransactionID)));
  EXPORT __All_Trim := __d0_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::PublicRecords_KEL::Inquiry::UidLookup',EXPIRE(7));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::PublicRecords_KEL::Inquiry');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::PublicRecords_KEL::Inquiry');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__in,Lookup,TRIM((STRING)LEFT.TransactionID) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping));
  EXPORT InData := __d0;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nkdate Date_Of_Inquiry_;
    KEL.typ.nstr Time_Of_Inquiry_;
    KEL.typ.nstr Inquiry_Source_;
    KEL.typ.nstr Sequence_Number_;
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Inquiry_Group := __PostFilter;
  Layout Inquiry__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Transaction_I_D_ := KEL.Intake.SingleValue(__recs,Transaction_I_D_);
    SELF.Date_Of_Inquiry_ := KEL.Intake.SingleValue(__recs,Date_Of_Inquiry_);
    SELF.Time_Of_Inquiry_ := KEL.Intake.SingleValue(__recs,Time_Of_Inquiry_);
    SELF.Inquiry_Source_ := KEL.Intake.SingleValue(__recs,Inquiry_Source_);
    SELF.Sequence_Number_ := KEL.Intake.SingleValue(__recs,Sequence_Number_);
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
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Inquiry__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Inquiry_Group,COUNT(ROWS(LEFT))=1),GROUP,Inquiry__Single_Rollup(LEFT)) + ROLLUP(HAVING(Inquiry_Group,COUNT(ROWS(LEFT))>1),GROUP,Inquiry__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::PublicRecords_KEL::Inquiry::Result' + IF(__cfg.PersistId <> '','::' + __cfg.PersistId,''),EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Transaction_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Transaction_I_D_);
  EXPORT Date_Of_Inquiry__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Date_Of_Inquiry_);
  EXPORT Time_Of_Inquiry__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Time_Of_Inquiry_);
  EXPORT Inquiry_Source__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Inquiry_Source_);
  EXPORT Sequence_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sequence_Number_);
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
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(Transaction_I_D__SingleValue_Invalid),COUNT(Date_Of_Inquiry__SingleValue_Invalid),COUNT(Time_Of_Inquiry__SingleValue_Invalid),COUNT(Inquiry_Source__SingleValue_Invalid),COUNT(Sequence_Number__SingleValue_Invalid),COUNT(Method__SingleValue_Invalid),COUNT(Product_Code__SingleValue_Invalid),COUNT(Function_Description__SingleValue_Invalid),COUNT(G_L_B_Purpose__SingleValue_Invalid),COUNT(D_P_P_A_Purpose__SingleValue_Invalid),COUNT(F_C_R_A_Purpose__SingleValue_Invalid),COUNT(Sub_Market__SingleValue_Invalid),COUNT(Vertical__SingleValue_Invalid),COUNT(Use__SingleValue_Invalid),COUNT(Industry__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid,KEL.typ.int Transaction_I_D__SingleValue_Invalid,KEL.typ.int Date_Of_Inquiry__SingleValue_Invalid,KEL.typ.int Time_Of_Inquiry__SingleValue_Invalid,KEL.typ.int Inquiry_Source__SingleValue_Invalid,KEL.typ.int Sequence_Number__SingleValue_Invalid,KEL.typ.int Method__SingleValue_Invalid,KEL.typ.int Product_Code__SingleValue_Invalid,KEL.typ.int Function_Description__SingleValue_Invalid,KEL.typ.int G_L_B_Purpose__SingleValue_Invalid,KEL.typ.int D_P_P_A_Purpose__SingleValue_Invalid,KEL.typ.int F_C_R_A_Purpose__SingleValue_Invalid,KEL.typ.int Sub_Market__SingleValue_Invalid,KEL.typ.int Vertical__SingleValue_Invalid,KEL.typ.int Use__SingleValue_Invalid,KEL.typ.int Industry__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(__d0)},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TransactionID',COUNT(__d0(__NL(Transaction_I_D_))),COUNT(__d0(__NN(Transaction_I_D_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfInquiry',COUNT(__d0(__NL(Date_Of_Inquiry_))),COUNT(__d0(__NN(Date_Of_Inquiry_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TimeOfInquiry',COUNT(__d0(__NL(Time_Of_Inquiry_))),COUNT(__d0(__NN(Time_Of_Inquiry_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InquirySource',COUNT(__d0(__NL(Inquiry_Source_))),COUNT(__d0(__NN(Inquiry_Source_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SequenceNumber',COUNT(__d0(__NL(Sequence_Number_))),COUNT(__d0(__NN(Sequence_Number_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Method',COUNT(__d0(__NL(Method_))),COUNT(__d0(__NN(Method_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProductCode',COUNT(__d0(__NL(Product_Code_))),COUNT(__d0(__NN(Product_Code_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FunctionDescription',COUNT(__d0(__NL(Function_Description_))),COUNT(__d0(__NN(Function_Description_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GLBPurpose',COUNT(__d0(__NL(G_L_B_Purpose_))),COUNT(__d0(__NN(G_L_B_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DPPAPurpose',COUNT(__d0(__NL(D_P_P_A_Purpose_))),COUNT(__d0(__NN(D_P_P_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FCRAPurpose',COUNT(__d0(__NL(F_C_R_A_Purpose_))),COUNT(__d0(__NN(F_C_R_A_Purpose_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SubMarket',COUNT(__d0(__NL(Sub_Market_))),COUNT(__d0(__NN(Sub_Market_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Vertical',COUNT(__d0(__NL(Vertical_))),COUNT(__d0(__NN(Vertical_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Use',COUNT(__d0(__NL(Use_))),COUNT(__d0(__NN(Use_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Industry',COUNT(__d0(__NL(Industry_))),COUNT(__d0(__NN(Industry_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Inquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
