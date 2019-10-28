//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Lien_Judgment FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_Sele_Lien_Judgment(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nstr Debtors_Full_Name_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'Sele_(DEFAULT:Sele_:0),Lien_(DEFAULT:Lien_:0),debtorsfullname(DEFAULT:Debtors_Full_Name_:\'\'),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED __d0_Sele__Layout := RECORD
    RECORDOF(__in);
    KEL.typ.uid Sele_;
  END;
  SHARED __d0_Sele__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__in,'UltID,OrgID,SeleID','__in'),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.UltID) + '|' + TRIM((STRING)LEFT.OrgID) + '|' + TRIM((STRING)LEFT.SeleID) = RIGHT.KeyVal,TRANSFORM(__d0_Sele__Layout,SELF.Sele_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Lien__Layout := RECORD
    RECORDOF(__d0_Sele__Mapped);
    KEL.typ.uid Lien_;
  END;
  SHARED __d0_Lien__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d0_Sele__Mapped,'TMSID,RMSID','__in'),E_Lien_Judgment(__in,__cfg).Lookup,TRIM((STRING)LEFT.TMSID) + '|' + TRIM((STRING)LEFT.RMSID) = RIGHT.KeyVal,TRANSFORM(__d0_Lien__Layout,SELF.Lien_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Lien__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0;
  EXPORT Details_Layout := RECORD
    KEL.typ.nstr Debtors_Full_Name_;
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
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.ndataset(Details_Layout) Details_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Sele_,Lien_,ALL));
  Sele_Lien_Judgment_Group := __PostFilter;
  Layout Sele_Lien_Judgment__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Details_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Debtors_Full_Name_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_},Debtors_Full_Name_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_),Details_Layout)(__NN(Debtors_Full_Name_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Sele_Lien_Judgment__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Details_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Details_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Debtors_Full_Name_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Sele_Lien_Judgment_Group,COUNT(ROWS(LEFT))=1),GROUP,Sele_Lien_Judgment__Single_Rollup(LEFT)) + ROLLUP(HAVING(Sele_Lien_Judgment_Group,COUNT(ROWS(LEFT))>1),GROUP,Sele_Lien_Judgment__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Sele__Orphan := JOIN(InData(__NN(Sele_)),E_Business_Sele(__in,__cfg).__Result,__EEQP(LEFT.Sele_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Lien__Orphan := JOIN(InData(__NN(Lien_)),E_Lien_Judgment(__in,__cfg).__Result,__EEQP(LEFT.Lien_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Sele__Orphan),COUNT(Lien__Orphan)}],{KEL.typ.int Sele__Orphan,KEL.typ.int Lien__Orphan});
  EXPORT NullCounts := DATASET([
    {'SeleLienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Sele',COUNT(__d0(__NL(Sele_))),COUNT(__d0(__NN(Sele_)))},
    {'SeleLienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Lien',COUNT(__d0(__NL(Lien_))),COUNT(__d0(__NN(Lien_)))},
    {'SeleLienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DebtorsFullName',COUNT(__d0(__NL(Debtors_Full_Name_))),COUNT(__d0(__NN(Debtors_Full_Name_)))},
    {'SeleLienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d0(__NL(Date_Vendor_First_Reported_))),COUNT(__d0(__NN(Date_Vendor_First_Reported_)))},
    {'SeleLienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d0(__NL(Date_Vendor_Last_Reported_))),COUNT(__d0(__NN(Date_Vendor_Last_Reported_)))},
    {'SeleLienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'SeleLienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'SeleLienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
