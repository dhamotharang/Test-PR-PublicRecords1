﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Inquiry FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_Sele_Inquiry(CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Inquiry().Typ) Transaction_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
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
  SHARED __Mapping := 'Legal_(DEFAULT:Legal_:0),Transaction_(DEFAULT:Transaction_:0),ultid(DEFAULT:Ult_I_D_:0),orgid(DEFAULT:Org_I_D_:0),seleid(DEFAULT:Sele_I_D_:0),transactionid(DEFAULT:Transaction_I_D_:\'\'),sequencenumber(DEFAULT:Sequence_Number_:\'\'),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCHTIMESTAMP),datelastseen(DEFAULT:Date_Last_Seen_:EPOCHTIMESTAMP),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCHTIMESTAMP),archive_date(DEFAULT:Archive___Date_:EPOCHTIMESTAMP),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Hybrid_Archive_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000',KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..6]+'01000000000'))=>a[1..6]+'01000000000','0');
  SHARED Archive___Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..17]))=>a[1..17],KEL.Routines.IsValidTimestamp((KEL.typ.timestamp)(a[1..8]+'000000000'))=>a[1..8]+'000000000','0');
  SHARED __Mapping0 := 'Legal_(DEFAULT:Legal_:0),Transaction_(DEFAULT:Transaction_:0),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),search_info.transaction_id(OVERRIDE:Transaction_I_D_:\'\'),search_info.sequence_number(OVERRIDE:Sequence_Number_:\'\'),src(OVERRIDE:Source_:\'\'),dateofinquiry(OVERRIDE:Date_First_Seen_:EPOCHTIMESTAMP:Date_First_Seen_0Rule|OVERRIDE:Date_Last_Seen_:EPOCHTIMESTAMP:Date_Last_Seen_0Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCHTIMESTAMP:Hybrid_Archive_Date_0Rule),archive_date(OVERRIDE:Archive___Date_:EPOCHTIMESTAMP:Archive___Date_0Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d0_KELfiltered := PublicRecords_KEL.files.NonFCRA.Inquiry_AccLogs__Inquiry_ALL_LinkIds_Vault((UNSIGNED)Ultid <> 0 AND (UNSIGNED)OrgID <> 0 AND (UNSIGNED)SeleID <> 0);
  SHARED __d0_Legal__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d0_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_KELfiltered,'UltID,OrgID,SeleID','PublicRecords_KEL.files.NonFCRA.Inquiry_AccLogs__Inquiry_ALL_LinkIds_Vault');
  SHARED __d0_Legal__Mapped := IF(__d0_Missing_Legal__UIDComponents = 'UltID,OrgID,SeleID',PROJECT(__d0_KELfiltered,TRANSFORM(__d0_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_KELfiltered,__d0_Missing_Legal__UIDComponents),E_Business_Sele(__cfg).Lookup,TRIM((STRING)LEFT.UltID) + '|' + TRIM((STRING)LEFT.OrgID) + '|' + TRIM((STRING)LEFT.SeleID) = RIGHT.KeyVal,TRANSFORM(__d0_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Transaction__Layout := RECORD
    RECORDOF(__d0_Legal__Mapped);
    KEL.typ.uid Transaction_;
  END;
  SHARED __d0_Missing_Transaction__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Legal__Mapped,'search_info.transaction_id,search_info.sequence_number','PublicRecords_KEL.files.NonFCRA.Inquiry_AccLogs__Inquiry_ALL_LinkIds_Vault');
  SHARED __d0_Transaction__Mapped := IF(__d0_Missing_Transaction__UIDComponents = 'search_info.transaction_id,search_info.sequence_number',PROJECT(__d0_Legal__Mapped,TRANSFORM(__d0_Transaction__Layout,SELF.Transaction_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Legal__Mapped,__d0_Missing_Transaction__UIDComponents),E_Inquiry(__cfg).Lookup,TRIM((STRING)LEFT.search_info.transaction_id) + '|' + TRIM((STRING)LEFT.search_info.sequence_number) = RIGHT.KeyVal,TRANSFORM(__d0_Transaction__Layout,SELF.Transaction_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Prefiltered := __d0_Transaction__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.files.NonFCRA.Inquiry_AccLogs__Inquiry_ALL_LinkIds_Vault'));
  EXPORT InData := __d0;
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
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Inquiry().Typ) Transaction_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
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
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Legal_,Transaction_,Ult_I_D_,Org_I_D_,Sele_I_D_,Transaction_I_D_,Sequence_Number_,ALL));
  Sele_Inquiry_Group := __PostFilter;
  Layout Sele_Inquiry__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.timestamp Archive___Date_ := KEL.era.SimpleRollTimestamp(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.timestamp Date_First_Seen_ := KEL.era.SimpleRollTimestamp(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.timestamp Date_Last_Seen_ := KEL.era.SimpleRollTimestamp(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.timestamp Hybrid_Archive_Date_ := KEL.era.SimpleRollTimestamp(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRollTimestamp(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollTimestamp(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollTimestamp(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollTimestamp(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Sele_Inquiry__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRowTimestamp(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRowTimestamp(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRowTimestamp(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRowTimestamp(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRowTimestamp(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Sele_Inquiry_Group,COUNT(ROWS(LEFT))=1),GROUP,Sele_Inquiry__Single_Rollup(LEFT)) + ROLLUP(HAVING(Sele_Inquiry_Group,COUNT(ROWS(LEFT))>1),GROUP,Sele_Inquiry__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Legal__Orphan := JOIN(InData(__NN(Legal_)),E_Business_Sele(__cfg).__Result,__EEQP(LEFT.Legal_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Transaction__Orphan := JOIN(InData(__NN(Transaction_)),E_Inquiry(__cfg).__Result,__EEQP(LEFT.Transaction_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Legal__Orphan),COUNT(Transaction__Orphan)}],{KEL.typ.int Legal__Orphan,KEL.typ.int Transaction__Orphan});
  EXPORT NullCounts := DATASET([
    {'SeleInquiry','PublicRecords_KEL.files.NonFCRA.Inquiry_AccLogs__Inquiry_ALL_LinkIds_Vault','Legal',COUNT(__d0(__NL(Legal_))),COUNT(__d0(__NN(Legal_)))},
    {'SeleInquiry','PublicRecords_KEL.files.NonFCRA.Inquiry_AccLogs__Inquiry_ALL_LinkIds_Vault','Transaction',COUNT(__d0(__NL(Transaction_))),COUNT(__d0(__NN(Transaction_)))},
    {'SeleInquiry','PublicRecords_KEL.files.NonFCRA.Inquiry_AccLogs__Inquiry_ALL_LinkIds_Vault','UltID',COUNT(__d0(__NL(Ult_I_D_))),COUNT(__d0(__NN(Ult_I_D_)))},
    {'SeleInquiry','PublicRecords_KEL.files.NonFCRA.Inquiry_AccLogs__Inquiry_ALL_LinkIds_Vault','OrgID',COUNT(__d0(__NL(Org_I_D_))),COUNT(__d0(__NN(Org_I_D_)))},
    {'SeleInquiry','PublicRecords_KEL.files.NonFCRA.Inquiry_AccLogs__Inquiry_ALL_LinkIds_Vault','SeleID',COUNT(__d0(__NL(Sele_I_D_))),COUNT(__d0(__NN(Sele_I_D_)))},
    {'SeleInquiry','PublicRecords_KEL.files.NonFCRA.Inquiry_AccLogs__Inquiry_ALL_LinkIds_Vault','search_info.transaction_id',COUNT(__d0(__NL(Transaction_I_D_))),COUNT(__d0(__NN(Transaction_I_D_)))},
    {'SeleInquiry','PublicRecords_KEL.files.NonFCRA.Inquiry_AccLogs__Inquiry_ALL_LinkIds_Vault','search_info.sequence_number',COUNT(__d0(__NL(Sequence_Number_))),COUNT(__d0(__NN(Sequence_Number_)))},
    {'SeleInquiry','PublicRecords_KEL.files.NonFCRA.Inquiry_AccLogs__Inquiry_ALL_LinkIds_Vault','Src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'SeleInquiry','PublicRecords_KEL.files.NonFCRA.Inquiry_AccLogs__Inquiry_ALL_LinkIds_Vault','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'SeleInquiry','PublicRecords_KEL.files.NonFCRA.Inquiry_AccLogs__Inquiry_ALL_LinkIds_Vault','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'SeleInquiry','PublicRecords_KEL.files.NonFCRA.Inquiry_AccLogs__Inquiry_ALL_LinkIds_Vault','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'SeleInquiry','PublicRecords_KEL.files.NonFCRA.Inquiry_AccLogs__Inquiry_ALL_LinkIds_Vault','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'SeleInquiry','PublicRecords_KEL.files.NonFCRA.Inquiry_AccLogs__Inquiry_ALL_LinkIds_Vault','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
