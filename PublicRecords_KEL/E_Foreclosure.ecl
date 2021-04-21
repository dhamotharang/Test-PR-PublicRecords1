//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_Foreclosure(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Foreclosure_I_D_;
    KEL.typ.nkdate Recording_Date_;
    KEL.typ.nstr State_;
    KEL.typ.nstr County_;
    KEL.typ.nstr Batch_Date_And_Sequence_Number_;
    KEL.typ.nstr Deed_Catagory_;
    KEL.typ.nstr Deed_Descriptions_;
    KEL.typ.nstr Document_Type_;
    KEL.typ.nstr Document_Descriptions_;
    KEL.typ.nstr First_Defendant_Borrower_Owner_First_Name_;
    KEL.typ.nstr First_Defendant_Borrower_Owner_Last_Name_;
    KEL.typ.nstr First_Defendant_Borrower_Company_Name_;
    KEL.typ.nstr Second_Defendant_Borrower_Owner_First_Name_;
    KEL.typ.nstr Second_Defendant_Borrower_Owner_Last_Name_;
    KEL.typ.nstr Second_Defendant_Borrower_Company_Name_;
    KEL.typ.nkdate Default_Date_;
    KEL.typ.nkdate Filing_Date_;
    KEL.typ.nint Final_Judgement_Amount_;
    KEL.typ.nkdate Original_Loan_Date_;
    KEL.typ.nkdate Original_Loan_Recording_Date_;
    KEL.typ.nint Original_Loan_Amount_;
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
  SHARED __Mapping := 'UID(DEFAULT:UID),foreclosureid(DEFAULT:Foreclosure_I_D_:\'\'),recordingdate(DEFAULT:Recording_Date_:DATE),state(DEFAULT:State_:\'\'),county(DEFAULT:County_:\'\'),batchdateandsequencenumber(DEFAULT:Batch_Date_And_Sequence_Number_:\'\'),deedcatagory(DEFAULT:Deed_Catagory_:\'\'),deeddescriptions(DEFAULT:Deed_Descriptions_:\'\'),documenttype(DEFAULT:Document_Type_:\'\'),documentdescriptions(DEFAULT:Document_Descriptions_:\'\'),firstdefendantborrowerownerfirstname(DEFAULT:First_Defendant_Borrower_Owner_First_Name_:\'\'),firstdefendantborrowerownerlastname(DEFAULT:First_Defendant_Borrower_Owner_Last_Name_:\'\'),firstdefendantborrowercompanyname(DEFAULT:First_Defendant_Borrower_Company_Name_:\'\'),seconddefendantborrowerownerfirstname(DEFAULT:Second_Defendant_Borrower_Owner_First_Name_:\'\'),seconddefendantborrowerownerlastname(DEFAULT:Second_Defendant_Borrower_Owner_Last_Name_:\'\'),seconddefendantborrowercompanyname(DEFAULT:Second_Defendant_Borrower_Company_Name_:\'\'),defaultdate(DEFAULT:Default_Date_:DATE),filingdate(DEFAULT:Filing_Date_:DATE),finaljudgementamount(DEFAULT:Final_Judgement_Amount_:0),originalloandate(DEFAULT:Original_Loan_Date_:DATE),originalloanrecordingdate(DEFAULT:Original_Loan_Recording_Date_:DATE),originalloanamount(DEFAULT:Original_Loan_Amount_:0),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in.Dataset_DX_Property__Key_Foreclosures_FID_With_Did,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.fid)));
  EXPORT __All_Trim := __d0_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED __Mapping0 := 'UID(DEFAULT:UID),fid(OVERRIDE:Foreclosure_I_D_:\'\'),recording_date(OVERRIDE:Recording_Date_:DATE|OVERRIDE:Date_First_Seen_:EPOCH),state(OVERRIDE:State_:\'\'),county(OVERRIDE:County_:\'\'),batch_date_and_seq_nbr(OVERRIDE:Batch_Date_And_Sequence_Number_:\'\'),deed_category(OVERRIDE:Deed_Catagory_:\'\'),deed_desc(OVERRIDE:Deed_Descriptions_:\'\'),document_type(OVERRIDE:Document_Type_:\'\'),document_desc(OVERRIDE:Document_Descriptions_:\'\'),first_defendant_borrower_owner_first_name(OVERRIDE:First_Defendant_Borrower_Owner_First_Name_:\'\'),first_defendant_borrower_owner_last_name(OVERRIDE:First_Defendant_Borrower_Owner_Last_Name_:\'\'),first_defendant_borrower_company_name(OVERRIDE:First_Defendant_Borrower_Company_Name_:\'\'),second_defendant_borrower_owner_first_name(OVERRIDE:Second_Defendant_Borrower_Owner_First_Name_:\'\'),second_defendant_borrower_owner_last_name(OVERRIDE:Second_Defendant_Borrower_Owner_Last_Name_:\'\'),second_defendant_borrower_company_name(OVERRIDE:Second_Defendant_Borrower_Company_Name_:\'\'),date_of_default(OVERRIDE:Default_Date_:DATE),filing_date(OVERRIDE:Filing_Date_:DATE),final_judgment_amount(OVERRIDE:Final_Judgement_Amount_:0),original_loan_date(OVERRIDE:Original_Loan_Date_:DATE),original_loan_recording_date(OVERRIDE:Original_Loan_Recording_Date_:DATE),original_loan_amount(OVERRIDE:Original_Loan_Amount_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_DX_Property__Key_Foreclosures_FID_With_Did,TRANSFORM(RECORDOF(__in.Dataset_DX_Property__Key_Foreclosures_FID_With_Did),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_DX_Property__Key_Foreclosures_FID_With_Did);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_Norm,Lookup,TRIM((STRING)LEFT.fid) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DX_Property__Key_Foreclosures_FID_With_Did_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0;
  EXPORT Document_Information_Layout := RECORD
    KEL.typ.nkdate Recording_Date_;
    KEL.typ.nstr State_;
    KEL.typ.nstr County_;
    KEL.typ.nstr Batch_Date_And_Sequence_Number_;
    KEL.typ.nstr Deed_Catagory_;
    KEL.typ.nstr Deed_Descriptions_;
    KEL.typ.nstr Document_Type_;
    KEL.typ.nstr Document_Descriptions_;
    KEL.typ.nkdate Default_Date_;
    KEL.typ.nkdate Filing_Date_;
    KEL.typ.nint Final_Judgement_Amount_;
    KEL.typ.nkdate Original_Loan_Date_;
    KEL.typ.nkdate Original_Loan_Recording_Date_;
    KEL.typ.nint Original_Loan_Amount_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Defendant_Information_Layout := RECORD
    KEL.typ.nstr First_Defendant_Borrower_Owner_First_Name_;
    KEL.typ.nstr First_Defendant_Borrower_Owner_Last_Name_;
    KEL.typ.nstr First_Defendant_Borrower_Company_Name_;
    KEL.typ.nstr Second_Defendant_Borrower_Owner_First_Name_;
    KEL.typ.nstr Second_Defendant_Borrower_Owner_Last_Name_;
    KEL.typ.nstr Second_Defendant_Borrower_Company_Name_;
    KEL.typ.nstr Source_;
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
    KEL.typ.nstr Foreclosure_I_D_;
    KEL.typ.ndataset(Document_Information_Layout) Document_Information_;
    KEL.typ.ndataset(Defendant_Information_Layout) Defendant_Information_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Foreclosure_Group := __PostFilter;
  Layout Foreclosure__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Foreclosure_I_D_ := KEL.Intake.SingleValue(__recs,Foreclosure_I_D_);
    SELF.Document_Information_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Recording_Date_,State_,County_,Batch_Date_And_Sequence_Number_,Deed_Catagory_,Deed_Descriptions_,Document_Type_,Document_Descriptions_,Default_Date_,Filing_Date_,Final_Judgement_Amount_,Original_Loan_Date_,Original_Loan_Recording_Date_,Original_Loan_Amount_,Source_},Recording_Date_,State_,County_,Batch_Date_And_Sequence_Number_,Deed_Catagory_,Deed_Descriptions_,Document_Type_,Document_Descriptions_,Default_Date_,Filing_Date_,Final_Judgement_Amount_,Original_Loan_Date_,Original_Loan_Recording_Date_,Original_Loan_Amount_,Source_),Document_Information_Layout)(__NN(Recording_Date_) OR __NN(State_) OR __NN(County_) OR __NN(Batch_Date_And_Sequence_Number_) OR __NN(Deed_Catagory_) OR __NN(Deed_Descriptions_) OR __NN(Document_Type_) OR __NN(Document_Descriptions_) OR __NN(Default_Date_) OR __NN(Filing_Date_) OR __NN(Final_Judgement_Amount_) OR __NN(Original_Loan_Date_) OR __NN(Original_Loan_Recording_Date_) OR __NN(Original_Loan_Amount_) OR __NN(Source_)));
    SELF.Defendant_Information_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),First_Defendant_Borrower_Owner_First_Name_,First_Defendant_Borrower_Owner_Last_Name_,First_Defendant_Borrower_Company_Name_,Second_Defendant_Borrower_Owner_First_Name_,Second_Defendant_Borrower_Owner_Last_Name_,Second_Defendant_Borrower_Company_Name_,Source_},First_Defendant_Borrower_Owner_First_Name_,First_Defendant_Borrower_Owner_Last_Name_,First_Defendant_Borrower_Company_Name_,Second_Defendant_Borrower_Owner_First_Name_,Second_Defendant_Borrower_Owner_Last_Name_,Second_Defendant_Borrower_Company_Name_,Source_),Defendant_Information_Layout)(__NN(First_Defendant_Borrower_Owner_First_Name_) OR __NN(First_Defendant_Borrower_Owner_Last_Name_) OR __NN(First_Defendant_Borrower_Company_Name_) OR __NN(Second_Defendant_Borrower_Owner_First_Name_) OR __NN(Second_Defendant_Borrower_Owner_Last_Name_) OR __NN(Second_Defendant_Borrower_Company_Name_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Foreclosure__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Document_Information_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Document_Information_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Recording_Date_) OR __NN(State_) OR __NN(County_) OR __NN(Batch_Date_And_Sequence_Number_) OR __NN(Deed_Catagory_) OR __NN(Deed_Descriptions_) OR __NN(Document_Type_) OR __NN(Document_Descriptions_) OR __NN(Default_Date_) OR __NN(Filing_Date_) OR __NN(Final_Judgement_Amount_) OR __NN(Original_Loan_Date_) OR __NN(Original_Loan_Recording_Date_) OR __NN(Original_Loan_Amount_) OR __NN(Source_)));
    SELF.Defendant_Information_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Defendant_Information_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(First_Defendant_Borrower_Owner_First_Name_) OR __NN(First_Defendant_Borrower_Owner_Last_Name_) OR __NN(First_Defendant_Borrower_Company_Name_) OR __NN(Second_Defendant_Borrower_Owner_First_Name_) OR __NN(Second_Defendant_Borrower_Owner_Last_Name_) OR __NN(Second_Defendant_Borrower_Company_Name_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Foreclosure_Group,COUNT(ROWS(LEFT))=1),GROUP,Foreclosure__Single_Rollup(LEFT)) + ROLLUP(HAVING(Foreclosure_Group,COUNT(ROWS(LEFT))>1),GROUP,Foreclosure__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Foreclosure_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Foreclosure_I_D_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DX_Property__Key_Foreclosures_FID_With_Did_Invalid),COUNT(Foreclosure_I_D__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DX_Property__Key_Foreclosures_FID_With_Did_Invalid,KEL.typ.int Foreclosure_I_D__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DX_Property__Key_Foreclosures_FID_With_Did_Invalid),COUNT(__d0)},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fid',COUNT(__d0(__NL(Foreclosure_I_D_))),COUNT(__d0(__NN(Foreclosure_I_D_)))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','recording_date',COUNT(__d0(__NL(Recording_Date_))),COUNT(__d0(__NN(Recording_Date_)))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','state',COUNT(__d0(__NL(State_))),COUNT(__d0(__NN(State_)))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','county',COUNT(__d0(__NL(County_))),COUNT(__d0(__NN(County_)))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','batch_date_and_seq_nbr',COUNT(__d0(__NL(Batch_Date_And_Sequence_Number_))),COUNT(__d0(__NN(Batch_Date_And_Sequence_Number_)))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','deed_category',COUNT(__d0(__NL(Deed_Catagory_))),COUNT(__d0(__NN(Deed_Catagory_)))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','deed_desc',COUNT(__d0(__NL(Deed_Descriptions_))),COUNT(__d0(__NN(Deed_Descriptions_)))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','document_type',COUNT(__d0(__NL(Document_Type_))),COUNT(__d0(__NN(Document_Type_)))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','document_desc',COUNT(__d0(__NL(Document_Descriptions_))),COUNT(__d0(__NN(Document_Descriptions_)))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','first_defendant_borrower_owner_first_name',COUNT(__d0(__NL(First_Defendant_Borrower_Owner_First_Name_))),COUNT(__d0(__NN(First_Defendant_Borrower_Owner_First_Name_)))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','first_defendant_borrower_owner_last_name',COUNT(__d0(__NL(First_Defendant_Borrower_Owner_Last_Name_))),COUNT(__d0(__NN(First_Defendant_Borrower_Owner_Last_Name_)))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','first_defendant_borrower_company_name',COUNT(__d0(__NL(First_Defendant_Borrower_Company_Name_))),COUNT(__d0(__NN(First_Defendant_Borrower_Company_Name_)))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','second_defendant_borrower_owner_first_name',COUNT(__d0(__NL(Second_Defendant_Borrower_Owner_First_Name_))),COUNT(__d0(__NN(Second_Defendant_Borrower_Owner_First_Name_)))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','second_defendant_borrower_owner_last_name',COUNT(__d0(__NL(Second_Defendant_Borrower_Owner_Last_Name_))),COUNT(__d0(__NN(Second_Defendant_Borrower_Owner_Last_Name_)))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','second_defendant_borrower_company_name',COUNT(__d0(__NL(Second_Defendant_Borrower_Company_Name_))),COUNT(__d0(__NN(Second_Defendant_Borrower_Company_Name_)))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_of_default',COUNT(__d0(__NL(Default_Date_))),COUNT(__d0(__NN(Default_Date_)))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','filing_date',COUNT(__d0(__NL(Filing_Date_))),COUNT(__d0(__NN(Filing_Date_)))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','final_judgment_amount',COUNT(__d0(__NL(Final_Judgement_Amount_))),COUNT(__d0(__NN(Final_Judgement_Amount_)))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','original_loan_date',COUNT(__d0(__NL(Original_Loan_Date_))),COUNT(__d0(__NN(Original_Loan_Date_)))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','original_loan_recording_date',COUNT(__d0(__NL(Original_Loan_Recording_Date_))),COUNT(__d0(__NN(Original_Loan_Recording_Date_)))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','original_loan_amount',COUNT(__d0(__NL(Original_Loan_Amount_))),COUNT(__d0(__NN(Original_Loan_Amount_)))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'Foreclosure','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
