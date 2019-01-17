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
    KEL.typ.nstr Bankruptcy_Source_;
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
    KEL.typ.nkdate Date_Created_;
    KEL.typ.nkdate Case_Closing_Date_;
    KEL.typ.nkdate Reopen_Date_;
    KEL.typ.nint Case_I_D_;
    KEL.typ.nint Defendant_I_D_;
    KEL.typ.nstr Court_Name_;
    KEL.typ.nstr Court_Location_;
    KEL.typ.nstr Judge_Name_;
    KEL.typ.nstr Judge_Identification_;
    KEL.typ.nstr Filing_Jurisdiction_;
    KEL.typ.nfloat Assets_Value_;
    KEL.typ.nfloat Liabilities_Value_;
    KEL.typ.nkdate Meeting_Date_;
    KEL.typ.nint Meeting_Time_;
    KEL.typ.nkdate Claims_Deadline_;
    KEL.typ.nkdate Complaint_Deadline_;
    KEL.typ.nstr Case_Type_;
    KEL.typ.nbool Split_Case_;
    KEL.typ.nbool Filed_In_Error_;
    KEL.typ.nkdate Status_Date_;
    KEL.typ.nstr Status_Type_;
    KEL.typ.nkdate Comments_Filing_Date_;
    KEL.typ.nstr Comments_Description_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED1 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),tmsid(T_M_S_I_D_),courtcode(Court_Code_),casenumber(Case_Number_),originalcasenumber(Original_Case_Number_:\'\'),bankruptcysource(Bankruptcy_Source_:\'\'),sourcedescription(Source_Description_:\'\'),originalchapter(Original_Chapter_:\'\'),filingtype(Filing_Type_:\'\'),businessflag(Business_Flag_:\'\'),corporateflag(Corporate_Flag_:\'\'),dischargeddate(Discharged_Date_:DATE),disposition(Disposition_:\'\'),debtortype(Debtor_Type_:\'\'),debtorsequence(Debtor_Sequence_:0),dispositiontype(Disposition_Type_:0),dispositionreason(Disposition_Reason_:0),dispositiontypedescription(Disposition_Type_Description_:\'\'),nametype(Name_Type_:\'\'),screendescription(Screen_Description_:\'\'),decodeddescription(Decoded_Description_:\'\'),datefiled(Date_Filed_:DATE),recordtype(Record_Type_:\'\'),datevendorfirstreported(Date_Vendor_First_Reported_:DATE),datevendorlastreported(Date_Vendor_Last_Reported_:DATE),datecreated(Date_Created_:DATE),caseclosingdate(Case_Closing_Date_:DATE),reopendate(Reopen_Date_:DATE),caseid(Case_I_D_:0),defendantid(Defendant_I_D_:0),courtname(Court_Name_:\'\'),courtlocation(Court_Location_:\'\'),judgename(Judge_Name_:\'\'),judgeidentification(Judge_Identification_:\'\'),filingjurisdiction(Filing_Jurisdiction_:\'\'),assetsvalue(Assets_Value_:0.0),liabilitiesvalue(Liabilities_Value_:0.0),meetingdate(Meeting_Date_:DATE),meetingtime(Meeting_Time_:0),claimsdeadline(Claims_Deadline_:DATE),complaintdeadline(Complaint_Deadline_:DATE),casetype(Case_Type_:\'\'),splitcase(Split_Case_),filedinerror(Filed_In_Error_),statusdate(Status_Date_:DATE),statustype(Status_Type_:\'\'),commentsfilingdate(Comments_Filing_Date_:DATE),commentsdescription(Comments_Description_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.TMSID) + '|' + TRIM((STRING)LEFT.Court_Code) + '|' + TRIM((STRING)LEFT.Case_Number)));
  EXPORT __All_Trim := __d0_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  SHARED __Table := TABLE(__All_Trim,__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  EXPORT Lookup := PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__in,Lookup,TRIM((STRING)LEFT.TMSID) + '|' + TRIM((STRING)LEFT.Court_Code) + '|' + TRIM((STRING)LEFT.Case_Number) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping));
  EXPORT InData := __d0;
  EXPORT Records_Layout := RECORD
    KEL.typ.nstr Bankruptcy_Source_;
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
    KEL.typ.nkdate Date_Created_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Deadlines_Layout := RECORD
    KEL.typ.nkdate Claims_Deadline_;
    KEL.typ.nkdate Complaint_Deadline_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Case_Details_Layout := RECORD
    KEL.typ.nint Case_I_D_;
    KEL.typ.nint Defendant_I_D_;
    KEL.typ.nstr Case_Type_;
    KEL.typ.nkdate Case_Closing_Date_;
    KEL.typ.nkdate Reopen_Date_;
    KEL.typ.nbool Split_Case_;
    KEL.typ.nbool Filed_In_Error_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Court_Information_Layout := RECORD
    KEL.typ.nstr Court_Name_;
    KEL.typ.nstr Court_Location_;
    KEL.typ.nstr Judge_Name_;
    KEL.typ.nstr Judge_Identification_;
    KEL.typ.nstr Filing_Jurisdiction_;
    KEL.typ.nkdate Meeting_Date_;
    KEL.typ.nint Meeting_Time_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Monetary_Value_Layout := RECORD
    KEL.typ.nfloat Assets_Value_;
    KEL.typ.nfloat Liabilities_Value_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Status_Layout := RECORD
    KEL.typ.nkdate Status_Date_;
    KEL.typ.nstr Status_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Comments_Layout := RECORD
    KEL.typ.nkdate Comments_Filing_Date_;
    KEL.typ.nstr Comments_Description_;
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
    KEL.typ.ndataset(Court_Information_Layout) Court_Information_;
    KEL.typ.ndataset(Monetary_Value_Layout) Monetary_Value_;
    KEL.typ.ndataset(Status_Layout) Status_;
    KEL.typ.ndataset(Comments_Layout) Comments_;
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
    SELF.Records_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Bankruptcy_Source_,Source_Description_,Original_Chapter_,Filing_Type_,Business_Flag_,Corporate_Flag_,Discharged_Date_,Disposition_,Debtor_Type_,Debtor_Sequence_,Disposition_Type_,Disposition_Reason_,Disposition_Type_Description_,Name_Type_,Screen_Description_,Decoded_Description_,Date_Filed_,Date_Created_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Record_Type_},Bankruptcy_Source_,Source_Description_,Original_Chapter_,Filing_Type_,Business_Flag_,Corporate_Flag_,Discharged_Date_,Disposition_,Debtor_Type_,Debtor_Sequence_,Disposition_Type_,Disposition_Reason_,Disposition_Type_Description_,Name_Type_,Screen_Description_,Decoded_Description_,Date_Filed_,Date_Created_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Record_Type_),Records_Layout)(__NN(Bankruptcy_Source_) OR __NN(Source_Description_) OR __NN(Original_Chapter_) OR __NN(Filing_Type_) OR __NN(Business_Flag_) OR __NN(Corporate_Flag_) OR __NN(Discharged_Date_) OR __NN(Disposition_) OR __NN(Debtor_Type_) OR __NN(Debtor_Sequence_) OR __NN(Disposition_Type_) OR __NN(Disposition_Reason_) OR __NN(Disposition_Type_Description_) OR __NN(Name_Type_) OR __NN(Screen_Description_) OR __NN(Decoded_Description_) OR __NN(Date_Filed_) OR __NN(Date_Created_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_) OR __NN(Record_Type_)));
    SELF.Deadlines_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Claims_Deadline_,Complaint_Deadline_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_},Claims_Deadline_,Complaint_Deadline_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_),Deadlines_Layout)(__NN(Claims_Deadline_) OR __NN(Complaint_Deadline_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Case_Details_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Case_I_D_,Defendant_I_D_,Case_Type_,Case_Closing_Date_,Reopen_Date_,Split_Case_,Filed_In_Error_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_},Case_I_D_,Defendant_I_D_,Case_Type_,Case_Closing_Date_,Reopen_Date_,Split_Case_,Filed_In_Error_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_),Case_Details_Layout)(__NN(Case_I_D_) OR __NN(Defendant_I_D_) OR __NN(Case_Type_) OR __NN(Case_Closing_Date_) OR __NN(Reopen_Date_) OR __NN(Split_Case_) OR __NN(Filed_In_Error_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Court_Information_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Court_Name_,Court_Location_,Judge_Name_,Judge_Identification_,Filing_Jurisdiction_,Meeting_Date_,Meeting_Time_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_},Court_Name_,Court_Location_,Judge_Name_,Judge_Identification_,Filing_Jurisdiction_,Meeting_Date_,Meeting_Time_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_),Court_Information_Layout)(__NN(Court_Name_) OR __NN(Court_Location_) OR __NN(Judge_Name_) OR __NN(Judge_Identification_) OR __NN(Filing_Jurisdiction_) OR __NN(Meeting_Date_) OR __NN(Meeting_Time_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Monetary_Value_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Assets_Value_,Liabilities_Value_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_},Assets_Value_,Liabilities_Value_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_),Monetary_Value_Layout)(__NN(Assets_Value_) OR __NN(Liabilities_Value_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Status_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Status_Date_,Status_Type_},Status_Date_,Status_Type_),Status_Layout)(__NN(Status_Date_) OR __NN(Status_Type_)));
    SELF.Comments_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Comments_Filing_Date_,Comments_Description_},Comments_Filing_Date_,Comments_Description_),Comments_Layout)(__NN(Comments_Filing_Date_) OR __NN(Comments_Description_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Bankruptcy__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Records_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Records_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Bankruptcy_Source_) OR __NN(Source_Description_) OR __NN(Original_Chapter_) OR __NN(Filing_Type_) OR __NN(Business_Flag_) OR __NN(Corporate_Flag_) OR __NN(Discharged_Date_) OR __NN(Disposition_) OR __NN(Debtor_Type_) OR __NN(Debtor_Sequence_) OR __NN(Disposition_Type_) OR __NN(Disposition_Reason_) OR __NN(Disposition_Type_Description_) OR __NN(Name_Type_) OR __NN(Screen_Description_) OR __NN(Decoded_Description_) OR __NN(Date_Filed_) OR __NN(Date_Created_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_) OR __NN(Record_Type_)));
    SELF.Deadlines_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Deadlines_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Claims_Deadline_) OR __NN(Complaint_Deadline_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Case_Details_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Case_Details_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Case_I_D_) OR __NN(Defendant_I_D_) OR __NN(Case_Type_) OR __NN(Case_Closing_Date_) OR __NN(Reopen_Date_) OR __NN(Split_Case_) OR __NN(Filed_In_Error_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Court_Information_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Court_Information_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Court_Name_) OR __NN(Court_Location_) OR __NN(Judge_Name_) OR __NN(Judge_Identification_) OR __NN(Filing_Jurisdiction_) OR __NN(Meeting_Date_) OR __NN(Meeting_Time_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Monetary_Value_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Monetary_Value_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Assets_Value_) OR __NN(Liabilities_Value_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Status_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Status_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Status_Date_) OR __NN(Status_Type_)));
    SELF.Comments_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Comments_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Comments_Filing_Date_) OR __NN(Comments_Description_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Bankruptcy_Group,COUNT(ROWS(LEFT))=1),GROUP,Bankruptcy__Single_Rollup(LEFT)) + ROLLUP(HAVING(Bankruptcy_Group,COUNT(ROWS(LEFT))>1),GROUP,Bankruptcy__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT T_M_S_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,T_M_S_I_D_);
  EXPORT Court_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Court_Code_);
  EXPORT Case_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Case_Number_);
  EXPORT Original_Case_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Case_Number_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(T_M_S_I_D__SingleValue_Invalid),COUNT(Court_Code__SingleValue_Invalid),COUNT(Case_Number__SingleValue_Invalid),COUNT(Original_Case_Number__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid,KEL.typ.int T_M_S_I_D__SingleValue_Invalid,KEL.typ.int Court_Code__SingleValue_Invalid,KEL.typ.int Case_Number__SingleValue_Invalid,KEL.typ.int Original_Case_Number__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(__d0)},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TMSID',COUNT(__d0(__NL(T_M_S_I_D_))),COUNT(__d0(__NN(T_M_S_I_D_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtCode',COUNT(__d0(__NL(Court_Code_))),COUNT(__d0(__NN(Court_Code_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CaseNumber',COUNT(__d0(__NL(Case_Number_))),COUNT(__d0(__NN(Case_Number_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalCaseNumber',COUNT(__d0(__NL(Original_Case_Number_))),COUNT(__d0(__NN(Original_Case_Number_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BankruptcySource',COUNT(__d0(__NL(Bankruptcy_Source_))),COUNT(__d0(__NN(Bankruptcy_Source_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceDescription',COUNT(__d0(__NL(Source_Description_))),COUNT(__d0(__NN(Source_Description_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalChapter',COUNT(__d0(__NL(Original_Chapter_))),COUNT(__d0(__NN(Original_Chapter_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FilingType',COUNT(__d0(__NL(Filing_Type_))),COUNT(__d0(__NN(Filing_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d0(__NL(Business_Flag_))),COUNT(__d0(__NN(Business_Flag_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorporateFlag',COUNT(__d0(__NL(Corporate_Flag_))),COUNT(__d0(__NN(Corporate_Flag_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DischargedDate',COUNT(__d0(__NL(Discharged_Date_))),COUNT(__d0(__NN(Discharged_Date_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Disposition',COUNT(__d0(__NL(Disposition_))),COUNT(__d0(__NN(Disposition_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DebtorType',COUNT(__d0(__NL(Debtor_Type_))),COUNT(__d0(__NN(Debtor_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DebtorSequence',COUNT(__d0(__NL(Debtor_Sequence_))),COUNT(__d0(__NN(Debtor_Sequence_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DispositionType',COUNT(__d0(__NL(Disposition_Type_))),COUNT(__d0(__NN(Disposition_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DispositionReason',COUNT(__d0(__NL(Disposition_Reason_))),COUNT(__d0(__NN(Disposition_Reason_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DispositionTypeDescription',COUNT(__d0(__NL(Disposition_Type_Description_))),COUNT(__d0(__NN(Disposition_Type_Description_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameType',COUNT(__d0(__NL(Name_Type_))),COUNT(__d0(__NN(Name_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ScreenDescription',COUNT(__d0(__NL(Screen_Description_))),COUNT(__d0(__NN(Screen_Description_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DecodedDescription',COUNT(__d0(__NL(Decoded_Description_))),COUNT(__d0(__NN(Decoded_Description_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFiled',COUNT(__d0(__NL(Date_Filed_))),COUNT(__d0(__NN(Date_Filed_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d0(__NL(Record_Type_))),COUNT(__d0(__NN(Record_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d0(__NL(Date_Vendor_First_Reported_))),COUNT(__d0(__NN(Date_Vendor_First_Reported_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d0(__NL(Date_Vendor_Last_Reported_))),COUNT(__d0(__NN(Date_Vendor_Last_Reported_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateCreated',COUNT(__d0(__NL(Date_Created_))),COUNT(__d0(__NN(Date_Created_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CaseClosingDate',COUNT(__d0(__NL(Case_Closing_Date_))),COUNT(__d0(__NN(Case_Closing_Date_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ReopenDate',COUNT(__d0(__NL(Reopen_Date_))),COUNT(__d0(__NN(Reopen_Date_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CaseID',COUNT(__d0(__NL(Case_I_D_))),COUNT(__d0(__NN(Case_I_D_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DefendantID',COUNT(__d0(__NL(Defendant_I_D_))),COUNT(__d0(__NN(Defendant_I_D_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtName',COUNT(__d0(__NL(Court_Name_))),COUNT(__d0(__NN(Court_Name_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CourtLocation',COUNT(__d0(__NL(Court_Location_))),COUNT(__d0(__NN(Court_Location_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','JudgeName',COUNT(__d0(__NL(Judge_Name_))),COUNT(__d0(__NN(Judge_Name_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','JudgeIdentification',COUNT(__d0(__NL(Judge_Identification_))),COUNT(__d0(__NN(Judge_Identification_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FilingJurisdiction',COUNT(__d0(__NL(Filing_Jurisdiction_))),COUNT(__d0(__NN(Filing_Jurisdiction_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AssetsValue',COUNT(__d0(__NL(Assets_Value_))),COUNT(__d0(__NN(Assets_Value_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LiabilitiesValue',COUNT(__d0(__NL(Liabilities_Value_))),COUNT(__d0(__NN(Liabilities_Value_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MeetingDate',COUNT(__d0(__NL(Meeting_Date_))),COUNT(__d0(__NN(Meeting_Date_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MeetingTime',COUNT(__d0(__NL(Meeting_Time_))),COUNT(__d0(__NN(Meeting_Time_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ClaimsDeadline',COUNT(__d0(__NL(Claims_Deadline_))),COUNT(__d0(__NN(Claims_Deadline_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ComplaintDeadline',COUNT(__d0(__NL(Complaint_Deadline_))),COUNT(__d0(__NN(Complaint_Deadline_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CaseType',COUNT(__d0(__NL(Case_Type_))),COUNT(__d0(__NN(Case_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SplitCase',COUNT(__d0(__NL(Split_Case_))),COUNT(__d0(__NN(Split_Case_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FiledInError',COUNT(__d0(__NL(Filed_In_Error_))),COUNT(__d0(__NN(Filed_In_Error_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatusDate',COUNT(__d0(__NL(Status_Date_))),COUNT(__d0(__NN(Status_Date_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatusType',COUNT(__d0(__NL(Status_Type_))),COUNT(__d0(__NN(Status_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CommentsFilingDate',COUNT(__d0(__NL(Comments_Filing_Date_))),COUNT(__d0(__NN(Comments_Filing_Date_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CommentsDescription',COUNT(__d0(__NL(Comments_Description_))),COUNT(__d0(__NN(Comments_Description_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
