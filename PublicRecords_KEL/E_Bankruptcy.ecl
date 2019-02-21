//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Bankruptcy(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.nstr Source_Description_;
    KEL.typ.nstr Original_Chapter_;
    KEL.typ.nstr Filing_Type_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Corporate_Flag_;
    KEL.typ.nkdate Discharged_Date_;
    KEL.typ.nstr Disposition_;
    KEL.typ.nstr Debtor_Type_;
    KEL.typ.nint Debtor_Sequence_;
    KEL.typ.nint Disposition_Type_;
    KEL.typ.nint Disposition_Reason_;
    KEL.typ.nstr Disposition_Type_Description_;
    KEL.typ.nstr Name_Type_;
    KEL.typ.nstr Screen_Description_;
    KEL.typ.nstr Decoded_Description_;
    KEL.typ.nkdate Date_Filed_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nint Case_I_D_;
    KEL.typ.nint Defendant_I_D_;
    KEL.typ.nkdate Last_Status_Update_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),tmsid(T_M_S_I_D_),courtcode(Court_Code_),casenumber(Case_Number_),originalcasenumber(Original_Case_Number_:\'\'),sourcedescription(Source_Description_:\'\'),originalchapter(Original_Chapter_:\'\'),filingtype(Filing_Type_:\'\'),businessflag(Business_Flag_:\'\'),corporateflag(Corporate_Flag_:\'\'),dischargeddate(Discharged_Date_:DATE),disposition(Disposition_:\'\'),debtortype(Debtor_Type_:\'\'),debtorsequence(Debtor_Sequence_:0),dispositiontype(Disposition_Type_:0),dispositionreason(Disposition_Reason_:0),dispositiontypedescription(Disposition_Type_Description_:\'\'),nametype(Name_Type_:\'\'),screendescription(Screen_Description_:\'\'),decodeddescription(Decoded_Description_:\'\'),datefiled(Date_Filed_:DATE),recordtype(Record_Type_:\'\'),datevendorfirstreported(Date_Vendor_First_Reported_:DATE),datevendorlastreported(Date_Vendor_Last_Reported_:DATE),caseid(Case_I_D_:0),defendantid(Defendant_I_D_:0),laststatusupdate(Last_Status_Update_:DATE),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in.Dataset_Bankruptcy_Files__Key_Search,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.TMSID) + '|' + TRIM((STRING)LEFT.Court_Code) + '|' + TRIM((STRING)LEFT.Case_Number)));
  SHARED __d1_KELfiltered := __in.Dataset_Bankruptcy_Files__Key_Search(name_type = 'D');
  SHARED __d1_Trim := PROJECT(__d1_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.TMSID) + '|' + TRIM((STRING)LEFT.Court_Code) + '|' + TRIM((STRING)LEFT.Case_Number)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  SHARED __Table := TABLE(__All_Trim,__TabRec,KeyVal,MERGE);
  EXPORT Lookup := PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::PublicRecords_KEL::Bankruptcy::UidLookup',EXPIRE(7));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::PublicRecords_KEL::Bankruptcy');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::PublicRecords_KEL::Bankruptcy');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED __Mapping0 := 'UID(UID),tmsid(T_M_S_I_D_),court_code(Court_Code_),case_number(Case_Number_),orig_case_number(Original_Case_Number_:\'\'),srcdesc(Source_Description_:\'\'),chapter(Original_Chapter_:\'\'),filing_type(Filing_Type_:\'\'),business_flag(Business_Flag_:\'\'),corp_flag(Corporate_Flag_:\'\'),discharged(Discharged_Date_:DATE),disposition(Disposition_:\'\'),debtor_type(Debtor_Type_:\'\'),debtor_seq(Debtor_Sequence_:0),disptype(Disposition_Type_:0),dispreason(Disposition_Reason_:0),disptypedesc(Disposition_Type_Description_:\'\'),name_type(Name_Type_:\'\'),screendesc(Screen_Description_:\'\'),dcodedesc(Decoded_Description_:\'\'),date_filed(Date_Filed_:DATE),record_type(Record_Type_:\'\'),date_vendor_first_reported(Date_Vendor_First_Reported_:DATE),date_vendor_last_reported(Date_Vendor_Last_Reported_:DATE),caseid(Case_I_D_:0),defendantid(Defendant_I_D_:0),statusdate(Last_Status_Update_:DATE),date_first_seen(Date_First_Seen_:EPOCH),date_last_seen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Source_ := __CN('BA');
    SELF.__Permits := CFG_Compile.Permit_FCRA;
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Bankruptcy_Files__Key_Search,TRANSFORM(RECORDOF(__in.Dataset_Bankruptcy_Files__Key_Search),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Bankruptcy_Files__Key_Search);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_Norm,Lookup,TRIM((STRING)LEFT.TMSID) + '|' + TRIM((STRING)LEFT.Court_Code) + '|' + TRIM((STRING)LEFT.Case_Number) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Bankruptcy_Files__Key_Search_1_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0),__Mapping0_Transform(LEFT)));
  SHARED __Mapping1 := 'UID(UID),tmsid(T_M_S_I_D_),court_code(Court_Code_),case_number(Case_Number_),orig_case_number(Original_Case_Number_:\'\'),srcdesc(Source_Description_:\'\'),chapter(Original_Chapter_:\'\'),filing_type(Filing_Type_:\'\'),business_flag(Business_Flag_:\'\'),corp_flag(Corporate_Flag_:\'\'),discharged(Discharged_Date_:DATE),disposition(Disposition_:\'\'),debtor_type(Debtor_Type_:\'\'),debtor_seq(Debtor_Sequence_:0),disptype(Disposition_Type_:0),dispreason(Disposition_Reason_:0),disptypedesc(Disposition_Type_Description_:\'\'),name_type(Name_Type_:\'\'),screendesc(Screen_Description_:\'\'),dcodedesc(Decoded_Description_:\'\'),date_filed(Date_Filed_:DATE),record_type(Record_Type_:\'\'),date_vendor_first_reported(Date_Vendor_First_Reported_:DATE),date_vendor_last_reported(Date_Vendor_Last_Reported_:DATE),caseid(Case_I_D_:0),defendantid(Defendant_I_D_:0),statusdate(Last_Status_Update_:DATE),date_first_seen(Date_First_Seen_:EPOCH),date_last_seen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.Source_ := __CN('BA');
    SELF.__Permits := CFG_Compile.Permit_NonFCRA;
    SELF := __r;
  END;
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Bankruptcy_Files__Key_Search,TRANSFORM(RECORDOF(__in.Dataset_Bankruptcy_Files__Key_Search),SELF:=RIGHT));
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Bankruptcy_Files__Key_Search);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_KELfiltered,Lookup,TRIM((STRING)LEFT.TMSID) + '|' + TRIM((STRING)LEFT.Court_Code) + '|' + TRIM((STRING)LEFT.Case_Number) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Bankruptcy_Files__Key_Search_2_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1),__Mapping1_Transform(LEFT)));
  EXPORT InData := __d0 + __d1;
  EXPORT Records_Layout := RECORD
    KEL.typ.nstr Source_Description_;
    KEL.typ.nstr Original_Chapter_;
    KEL.typ.nstr Filing_Type_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Corporate_Flag_;
    KEL.typ.nkdate Discharged_Date_;
    KEL.typ.nstr Disposition_;
    KEL.typ.nstr Debtor_Type_;
    KEL.typ.nint Debtor_Sequence_;
    KEL.typ.nint Disposition_Type_;
    KEL.typ.nint Disposition_Reason_;
    KEL.typ.nstr Disposition_Type_Description_;
    KEL.typ.nstr Name_Type_;
    KEL.typ.nstr Screen_Description_;
    KEL.typ.nstr Decoded_Description_;
    KEL.typ.nkdate Date_Filed_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nkdate Last_Status_Update_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Deadlines_Layout := RECORD
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Case_Details_Layout := RECORD
    KEL.typ.nint Case_I_D_;
    KEL.typ.nint Defendant_I_D_;
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
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(Records_Layout) Records_;
    KEL.typ.ndataset(Deadlines_Layout) Deadlines_;
    KEL.typ.ndataset(Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Bankruptcy_Group := __PostFilter;
  Layout Bankruptcy__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.T_M_S_I_D_ := KEL.Intake.SingleValue(__recs,T_M_S_I_D_);
    SELF.Court_Code_ := KEL.Intake.SingleValue(__recs,Court_Code_);
    SELF.Case_Number_ := KEL.Intake.SingleValue(__recs,Case_Number_);
    SELF.Original_Case_Number_ := KEL.Intake.SingleValue(__recs,Original_Case_Number_);
    SELF.Records_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_Description_,Original_Chapter_,Filing_Type_,Business_Flag_,Corporate_Flag_,Discharged_Date_,Disposition_,Debtor_Type_,Debtor_Sequence_,Disposition_Type_,Disposition_Reason_,Disposition_Type_Description_,Name_Type_,Screen_Description_,Decoded_Description_,Date_Filed_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Record_Type_,Last_Status_Update_},Source_Description_,Original_Chapter_,Filing_Type_,Business_Flag_,Corporate_Flag_,Discharged_Date_,Disposition_,Debtor_Type_,Debtor_Sequence_,Disposition_Type_,Disposition_Reason_,Disposition_Type_Description_,Name_Type_,Screen_Description_,Decoded_Description_,Date_Filed_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Record_Type_,Last_Status_Update_),Records_Layout)(__NN(Source_Description_) OR __NN(Original_Chapter_) OR __NN(Filing_Type_) OR __NN(Business_Flag_) OR __NN(Corporate_Flag_) OR __NN(Discharged_Date_) OR __NN(Disposition_) OR __NN(Debtor_Type_) OR __NN(Debtor_Sequence_) OR __NN(Disposition_Type_) OR __NN(Disposition_Reason_) OR __NN(Disposition_Type_Description_) OR __NN(Name_Type_) OR __NN(Screen_Description_) OR __NN(Decoded_Description_) OR __NN(Date_Filed_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_) OR __NN(Record_Type_) OR __NN(Last_Status_Update_)));
    SELF.Deadlines_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_},Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_),Deadlines_Layout)(__NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Case_Details_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Case_I_D_,Defendant_I_D_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_},Case_I_D_,Defendant_I_D_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_),Case_Details_Layout)(__NN(Case_I_D_) OR __NN(Defendant_I_D_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Bankruptcy__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Records_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Records_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_Description_) OR __NN(Original_Chapter_) OR __NN(Filing_Type_) OR __NN(Business_Flag_) OR __NN(Corporate_Flag_) OR __NN(Discharged_Date_) OR __NN(Disposition_) OR __NN(Debtor_Type_) OR __NN(Debtor_Sequence_) OR __NN(Disposition_Type_) OR __NN(Disposition_Reason_) OR __NN(Disposition_Type_Description_) OR __NN(Name_Type_) OR __NN(Screen_Description_) OR __NN(Decoded_Description_) OR __NN(Date_Filed_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_) OR __NN(Record_Type_) OR __NN(Last_Status_Update_)));
    SELF.Deadlines_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Deadlines_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Case_Details_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Case_Details_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Case_I_D_) OR __NN(Defendant_I_D_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Bankruptcy_Group,COUNT(ROWS(LEFT))=1),GROUP,Bankruptcy__Single_Rollup(LEFT)) + ROLLUP(HAVING(Bankruptcy_Group,COUNT(ROWS(LEFT))>1),GROUP,Bankruptcy__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::PublicRecords_KEL::Bankruptcy::Result' + IF(__cfg.PersistId <> '','::' + __cfg.PersistId,''),EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT T_M_S_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,T_M_S_I_D_);
  EXPORT Court_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Court_Code_);
  EXPORT Case_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Case_Number_);
  EXPORT Original_Case_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Case_Number_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Bankruptcy_Files__Key_Search_1_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Bankruptcy_Files__Key_Search_2_Invalid),COUNT(T_M_S_I_D__SingleValue_Invalid),COUNT(Court_Code__SingleValue_Invalid),COUNT(Case_Number__SingleValue_Invalid),COUNT(Original_Case_Number__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Bankruptcy_Files__Key_Search_1_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Bankruptcy_Files__Key_Search_2_Invalid,KEL.typ.int T_M_S_I_D__SingleValue_Invalid,KEL.typ.int Court_Code__SingleValue_Invalid,KEL.typ.int Case_Number__SingleValue_Invalid,KEL.typ.int Original_Case_Number__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Bankruptcy_Files__Key_Search_1_Invalid),COUNT(__d0)},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TMSID',COUNT(__d0(__NL(T_M_S_I_D_))),COUNT(__d0(__NN(T_M_S_I_D_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Court_Code',COUNT(__d0(__NL(Court_Code_))),COUNT(__d0(__NN(Court_Code_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Case_Number',COUNT(__d0(__NL(Case_Number_))),COUNT(__d0(__NN(Case_Number_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_case_number',COUNT(__d0(__NL(Original_Case_Number_))),COUNT(__d0(__NN(Original_Case_Number_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','srcdesc',COUNT(__d0(__NL(Source_Description_))),COUNT(__d0(__NN(Source_Description_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','chapter',COUNT(__d0(__NL(Original_Chapter_))),COUNT(__d0(__NN(Original_Chapter_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','filing_type',COUNT(__d0(__NL(Filing_Type_))),COUNT(__d0(__NN(Filing_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','business_flag',COUNT(__d0(__NL(Business_Flag_))),COUNT(__d0(__NN(Business_Flag_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_flag',COUNT(__d0(__NL(Corporate_Flag_))),COUNT(__d0(__NN(Corporate_Flag_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','discharged',COUNT(__d0(__NL(Discharged_Date_))),COUNT(__d0(__NN(Discharged_Date_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','disposition',COUNT(__d0(__NL(Disposition_))),COUNT(__d0(__NN(Disposition_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','debtor_type',COUNT(__d0(__NL(Debtor_Type_))),COUNT(__d0(__NN(Debtor_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','debtor_seq',COUNT(__d0(__NL(Debtor_Sequence_))),COUNT(__d0(__NN(Debtor_Sequence_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','disptype',COUNT(__d0(__NL(Disposition_Type_))),COUNT(__d0(__NN(Disposition_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dispreason',COUNT(__d0(__NL(Disposition_Reason_))),COUNT(__d0(__NN(Disposition_Reason_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','disptypedesc',COUNT(__d0(__NL(Disposition_Type_Description_))),COUNT(__d0(__NN(Disposition_Type_Description_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_type',COUNT(__d0(__NL(Name_Type_))),COUNT(__d0(__NN(Name_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','screendesc',COUNT(__d0(__NL(Screen_Description_))),COUNT(__d0(__NN(Screen_Description_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dcodedesc',COUNT(__d0(__NL(Decoded_Description_))),COUNT(__d0(__NN(Decoded_Description_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_filed',COUNT(__d0(__NL(Date_Filed_))),COUNT(__d0(__NN(Date_Filed_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_type',COUNT(__d0(__NL(Record_Type_))),COUNT(__d0(__NN(Record_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_vendor_first_reported',COUNT(__d0(__NL(Date_Vendor_First_Reported_))),COUNT(__d0(__NN(Date_Vendor_First_Reported_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_vendor_last_reported',COUNT(__d0(__NL(Date_Vendor_Last_Reported_))),COUNT(__d0(__NN(Date_Vendor_Last_Reported_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','caseid',COUNT(__d0(__NL(Case_I_D_))),COUNT(__d0(__NN(Case_I_D_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','defendantid',COUNT(__d0(__NL(Defendant_I_D_))),COUNT(__d0(__NN(Defendant_I_D_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','statusdate',COUNT(__d0(__NL(Last_Status_Update_))),COUNT(__d0(__NN(Last_Status_Update_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Bankruptcy_Files__Key_Search_2_Invalid),COUNT(__d1)},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TMSID',COUNT(__d1(__NL(T_M_S_I_D_))),COUNT(__d1(__NN(T_M_S_I_D_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Court_Code',COUNT(__d1(__NL(Court_Code_))),COUNT(__d1(__NN(Court_Code_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Case_Number',COUNT(__d1(__NL(Case_Number_))),COUNT(__d1(__NN(Case_Number_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_case_number',COUNT(__d1(__NL(Original_Case_Number_))),COUNT(__d1(__NN(Original_Case_Number_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','srcdesc',COUNT(__d1(__NL(Source_Description_))),COUNT(__d1(__NN(Source_Description_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','chapter',COUNT(__d1(__NL(Original_Chapter_))),COUNT(__d1(__NN(Original_Chapter_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','filing_type',COUNT(__d1(__NL(Filing_Type_))),COUNT(__d1(__NN(Filing_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','business_flag',COUNT(__d1(__NL(Business_Flag_))),COUNT(__d1(__NN(Business_Flag_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_flag',COUNT(__d1(__NL(Corporate_Flag_))),COUNT(__d1(__NN(Corporate_Flag_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','discharged',COUNT(__d1(__NL(Discharged_Date_))),COUNT(__d1(__NN(Discharged_Date_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','disposition',COUNT(__d1(__NL(Disposition_))),COUNT(__d1(__NN(Disposition_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','debtor_type',COUNT(__d1(__NL(Debtor_Type_))),COUNT(__d1(__NN(Debtor_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','debtor_seq',COUNT(__d1(__NL(Debtor_Sequence_))),COUNT(__d1(__NN(Debtor_Sequence_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','disptype',COUNT(__d1(__NL(Disposition_Type_))),COUNT(__d1(__NN(Disposition_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dispreason',COUNT(__d1(__NL(Disposition_Reason_))),COUNT(__d1(__NN(Disposition_Reason_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','disptypedesc',COUNT(__d1(__NL(Disposition_Type_Description_))),COUNT(__d1(__NN(Disposition_Type_Description_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_type',COUNT(__d1(__NL(Name_Type_))),COUNT(__d1(__NN(Name_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','screendesc',COUNT(__d1(__NL(Screen_Description_))),COUNT(__d1(__NN(Screen_Description_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dcodedesc',COUNT(__d1(__NL(Decoded_Description_))),COUNT(__d1(__NN(Decoded_Description_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_filed',COUNT(__d1(__NL(Date_Filed_))),COUNT(__d1(__NN(Date_Filed_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_type',COUNT(__d1(__NL(Record_Type_))),COUNT(__d1(__NN(Record_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_vendor_first_reported',COUNT(__d1(__NL(Date_Vendor_First_Reported_))),COUNT(__d1(__NN(Date_Vendor_First_Reported_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_vendor_last_reported',COUNT(__d1(__NL(Date_Vendor_Last_Reported_))),COUNT(__d1(__NN(Date_Vendor_Last_Reported_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','caseid',COUNT(__d1(__NL(Case_I_D_))),COUNT(__d1(__NN(Case_I_D_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','defendantid',COUNT(__d1(__NL(Defendant_I_D_))),COUNT(__d1(__NN(Defendant_I_D_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','statusdate',COUNT(__d1(__NL(Last_Status_Update_))),COUNT(__d1(__NN(Last_Status_Update_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
