//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Inquiry,E_Phone FROM PublicRecords_KEL.KEL_Queries_MAS_Consumer;
IMPORT * FROM KEL16.Null;
EXPORT E_Phone_Inquiry(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.ntyp(E_Inquiry().Typ) Transaction_;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
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
  SHARED __Mapping := 'phonenumber(DEFAULT:Phone_Number_:0),Transaction_(DEFAULT:Transaction_:0),transactionid(DEFAULT:Transaction_I_D_:\'\'),sequencenumber(DEFAULT:Sequence_Number_:\'\'),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCHTIMESTAMP),datelastseen(DEFAULT:Date_Last_Seen_:EPOCHTIMESTAMP),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCHTIMESTAMP),archive_date(DEFAULT:Archive___Date_:EPOCHTIMESTAMP),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Archive___Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000','0');
  SHARED __Mapping0 := 'person_q.personal_phone(OVERRIDE:Phone_Number_:0),Transaction_(DEFAULT:Transaction_:0),search_info.transaction_id(OVERRIDE:Transaction_I_D_:\'\'),search_info.sequence_number(OVERRIDE:Sequence_Number_:\'\'),src(OVERRIDE:Source_:\'\'),dateofinquiry(OVERRIDE:Date_First_Seen_:EPOCHTIMESTAMP:Date_First_Seen_0Rule|OVERRIDE:Date_Last_Seen_:EPOCHTIMESTAMP:Date_Last_Seen_0Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCHTIMESTAMP),archive_date(OVERRIDE:Archive___Date_:EPOCHTIMESTAMP:Archive___Date_0Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Key_FCRA_Phone,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Key_FCRA_Phone),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((STRING)person_q.personal_phone <> '');
  SHARED __d0_Transaction__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Transaction_;
  END;
  SHARED __d0_Missing_Transaction__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_KELfiltered,'search_info.transaction_id,search_info.sequence_number','__in');
  SHARED __d0_Transaction__Mapped := IF(__d0_Missing_Transaction__UIDComponents = 'search_info.transaction_id,search_info.sequence_number',PROJECT(__d0_KELfiltered,TRANSFORM(__d0_Transaction__Layout,SELF.Transaction_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_KELfiltered,__d0_Missing_Transaction__UIDComponents),E_Inquiry(__in,__cfg).Lookup,TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number) = RIGHT.KeyVal,TRANSFORM(__d0_Transaction__Layout,SELF.Transaction_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Prefiltered := __d0_Transaction__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Archive___Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000','0');
  SHARED __Mapping1 := 'person_q.work_phone(OVERRIDE:Phone_Number_:0),Transaction_(DEFAULT:Transaction_:0),search_info.transaction_id(OVERRIDE:Transaction_I_D_:\'\'),search_info.sequence_number(OVERRIDE:Sequence_Number_:\'\'),src(OVERRIDE:Source_:\'\'),dateofinquiry(OVERRIDE:Date_First_Seen_:EPOCHTIMESTAMP:Date_First_Seen_1Rule|OVERRIDE:Date_Last_Seen_:EPOCHTIMESTAMP:Date_Last_Seen_1Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCHTIMESTAMP),archive_date(OVERRIDE:Archive___Date_:EPOCHTIMESTAMP:Archive___Date_1Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Key_FCRA_Phone,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Key_FCRA_Phone),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((STRING)person_q.work_phone <> '');
  SHARED __d1_Transaction__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid Transaction_;
  END;
  SHARED __d1_Missing_Transaction__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_KELfiltered,'search_info.transaction_id,search_info.sequence_number','__in');
  SHARED __d1_Transaction__Mapped := IF(__d1_Missing_Transaction__UIDComponents = 'search_info.transaction_id,search_info.sequence_number',PROJECT(__d1_KELfiltered,TRANSFORM(__d1_Transaction__Layout,SELF.Transaction_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_KELfiltered,__d1_Missing_Transaction__UIDComponents),E_Inquiry(__in,__cfg).Lookup,TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number) = RIGHT.KeyVal,TRANSFORM(__d1_Transaction__Layout,SELF.Transaction_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d1_Prefiltered := __d1_Transaction__Mapped;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Date_Last_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Archive___Date_2Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000','0');
  SHARED __Mapping2 := 'person_q.personal_phone(OVERRIDE:Phone_Number_:0),Transaction_(DEFAULT:Transaction_:0),search_info.transaction_id(OVERRIDE:Transaction_I_D_:\'\'),search_info.sequence_number(OVERRIDE:Sequence_Number_:\'\'),src(OVERRIDE:Source_:\'\'),dateofinquiry(OVERRIDE:Date_First_Seen_:EPOCHTIMESTAMP:Date_First_Seen_2Rule|OVERRIDE:Date_Last_Seen_:EPOCHTIMESTAMP:Date_Last_Seen_2Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCHTIMESTAMP),archive_date(OVERRIDE:Archive___Date_:EPOCHTIMESTAMP:Archive___Date_2Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Inquiry_Table_Phone,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Inquiry_Table_Phone),SELF:=RIGHT));
  EXPORT __d2_KELfiltered := __d2_Norm((STRING)person_q.personal_phone <> '');
  SHARED __d2_Transaction__Layout := RECORD
    RECORDOF(__d2_KELfiltered);
    KEL.typ.uid Transaction_;
  END;
  SHARED __d2_Missing_Transaction__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d2_KELfiltered,'search_info.transaction_id,search_info.sequence_number','__in');
  SHARED __d2_Transaction__Mapped := IF(__d2_Missing_Transaction__UIDComponents = 'search_info.transaction_id,search_info.sequence_number',PROJECT(__d2_KELfiltered,TRANSFORM(__d2_Transaction__Layout,SELF.Transaction_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d2_KELfiltered,__d2_Missing_Transaction__UIDComponents),E_Inquiry(__in,__cfg).Lookup,TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number) = RIGHT.KeyVal,TRANSFORM(__d2_Transaction__Layout,SELF.Transaction_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d2_Prefiltered := __d2_Transaction__Mapped;
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_3Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Date_Last_Seen_3Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Archive___Date_3Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000','0');
  SHARED __Mapping3 := 'person_q.work_phone(OVERRIDE:Phone_Number_:0),Transaction_(DEFAULT:Transaction_:0),search_info.transaction_id(OVERRIDE:Transaction_I_D_:\'\'),search_info.sequence_number(OVERRIDE:Sequence_Number_:\'\'),src(OVERRIDE:Source_:\'\'),dateofinquiry(OVERRIDE:Date_First_Seen_:EPOCHTIMESTAMP:Date_First_Seen_3Rule|OVERRIDE:Date_Last_Seen_:EPOCHTIMESTAMP:Date_Last_Seen_3Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCHTIMESTAMP),archive_date(OVERRIDE:Archive___Date_:EPOCHTIMESTAMP:Archive___Date_3Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Inquiry_Table_Phone,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Inquiry_Table_Phone),SELF:=RIGHT));
  EXPORT __d3_KELfiltered := __d3_Norm((STRING)person_q.work_phone <> '');
  SHARED __d3_Transaction__Layout := RECORD
    RECORDOF(__d3_KELfiltered);
    KEL.typ.uid Transaction_;
  END;
  SHARED __d3_Missing_Transaction__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d3_KELfiltered,'search_info.transaction_id,search_info.sequence_number','__in');
  SHARED __d3_Transaction__Mapped := IF(__d3_Missing_Transaction__UIDComponents = 'search_info.transaction_id,search_info.sequence_number',PROJECT(__d3_KELfiltered,TRANSFORM(__d3_Transaction__Layout,SELF.Transaction_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d3_KELfiltered,__d3_Missing_Transaction__UIDComponents),E_Inquiry(__in,__cfg).Lookup,TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number) = RIGHT.KeyVal,TRANSFORM(__d3_Transaction__Layout,SELF.Transaction_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d3_Prefiltered := __d3_Transaction__Mapped;
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3;
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
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.ntyp(E_Inquiry().Typ) Transaction_;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Phone_Number_,Transaction_,Transaction_I_D_,Sequence_Number_,ALL));
  Phone_Inquiry_Group := __PostFilter;
  Layout Phone_Inquiry__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.timestamp Archive___Date_ := KEL.era.SimpleRollTimestamp(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.timestamp Date_First_Seen_ := KEL.era.SimpleRollTimestamp(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.timestamp Date_Last_Seen_ := KEL.era.SimpleRollTimestamp(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.timestamp Hybrid_Archive_Date_ := KEL.era.SimpleRollTimestamp(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRollTimestamp(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollTimestamp(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollTimestamp(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollTimestamp(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Phone_Inquiry__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRowTimestamp(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRowTimestamp(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRowTimestamp(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRowTimestamp(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Phone_Inquiry_Group,COUNT(ROWS(LEFT))=1),GROUP,Phone_Inquiry__Single_Rollup(LEFT)) + ROLLUP(HAVING(Phone_Inquiry_Group,COUNT(ROWS(LEFT))>1),GROUP,Phone_Inquiry__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Phone_Number__Orphan := JOIN(InData(__NN(Phone_Number_)),E_Phone(__in,__cfg).__Result,__EEQP(LEFT.Phone_Number_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Transaction__Orphan := JOIN(InData(__NN(Transaction_)),E_Inquiry(__in,__cfg).__Result,__EEQP(LEFT.Transaction_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Phone_Number__Orphan),COUNT(Transaction__Orphan)}],{KEL.typ.int Phone_Number__Orphan,KEL.typ.int Transaction__Orphan});
  EXPORT NullCounts := DATASET([
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.personal_phone',COUNT(__d0(__NL(Phone_Number_))),COUNT(__d0(__NN(Phone_Number_)))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Transaction',COUNT(__d0(__NL(Transaction_))),COUNT(__d0(__NN(Transaction_)))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.transaction_id',COUNT(__d0(__NL(Transaction_I_D_))),COUNT(__d0(__NN(Transaction_I_D_)))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.sequence_number',COUNT(__d0(__NL(Sequence_Number_))),COUNT(__d0(__NN(Sequence_Number_)))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.work_phone',COUNT(__d1(__NL(Phone_Number_))),COUNT(__d1(__NN(Phone_Number_)))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Transaction',COUNT(__d1(__NL(Transaction_))),COUNT(__d1(__NN(Transaction_)))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.transaction_id',COUNT(__d1(__NL(Transaction_I_D_))),COUNT(__d1(__NN(Transaction_I_D_)))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.sequence_number',COUNT(__d1(__NL(Sequence_Number_))),COUNT(__d1(__NN(Sequence_Number_)))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.personal_phone',COUNT(__d2(__NL(Phone_Number_))),COUNT(__d2(__NN(Phone_Number_)))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Transaction',COUNT(__d2(__NL(Transaction_))),COUNT(__d2(__NN(Transaction_)))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.transaction_id',COUNT(__d2(__NL(Transaction_I_D_))),COUNT(__d2(__NN(Transaction_I_D_)))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.sequence_number',COUNT(__d2(__NL(Sequence_Number_))),COUNT(__d2(__NN(Sequence_Number_)))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.work_phone',COUNT(__d3(__NL(Phone_Number_))),COUNT(__d3(__NN(Phone_Number_)))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Transaction',COUNT(__d3(__NL(Transaction_))),COUNT(__d3(__NN(Transaction_)))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.transaction_id',COUNT(__d3(__NL(Transaction_I_D_))),COUNT(__d3(__NN(Transaction_I_D_)))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','search_info.sequence_number',COUNT(__d3(__NL(Sequence_Number_))),COUNT(__d3(__NN(Sequence_Number_)))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d3(Hybrid_Archive_Date_=0)),COUNT(__d3(Hybrid_Archive_Date_!=0))},
    {'PhoneInquiry','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d3(Vault_Date_Last_Seen_=0)),COUNT(__d3(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
