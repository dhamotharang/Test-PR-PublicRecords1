//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Bankruptcy,E_Business_Org,E_Business_Sele,E_Business_Ult FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_Sele_Bankruptcy(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Company_;
    KEL.typ.ntyp(E_Bankruptcy().Typ) Bankrupt_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'Company_(DEFAULT:Company_:0),Bankrupt_(DEFAULT:Bankrupt_:0),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'Company_(DEFAULT:Company_:0),Bankrupt_(DEFAULT:Bankrupt_:0),src(OVERRIDE:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Bankruptcy_Files__Linkids_Key_Search,TRANSFORM(RECORDOF(__in.Dataset_Bankruptcy_Files__Linkids_Key_Search),SELF:=RIGHT));
  SHARED __d0_Company__Layout := RECORD
    RECORDOF(__d0_Norm);
    KEL.typ.uid Company_;
  END;
  SHARED __d0_Company__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d0_Norm,'ultid,orgid,seleid','__in'),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d0_Company__Layout,SELF.Company_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Bankrupt__Layout := RECORD
    RECORDOF(__d0_Company__Mapped);
    KEL.typ.uid Bankrupt_;
  END;
  SHARED __d0_Bankrupt__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d0_Company__Mapped,'TMSID,Court_Code,Case_Number,DID','__in'),E_Bankruptcy(__in,__cfg).Lookup,TRIM((STRING)LEFT.TMSID) + '|' + TRIM((STRING)LEFT.Court_Code) + '|' + TRIM((STRING)LEFT.Case_Number) + '|' + TRIM((STRING)LEFT.DID) = RIGHT.KeyVal,TRANSFORM(__d0_Bankrupt__Layout,SELF.Bankrupt_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Bankrupt__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Company_;
    KEL.typ.ntyp(E_Bankruptcy().Typ) Bankrupt_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Company_,Bankrupt_,ALL));
  Sele_Bankruptcy_Group := __PostFilter;
  Layout Sele_Bankruptcy__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Sele_Bankruptcy__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Sele_Bankruptcy_Group,COUNT(ROWS(LEFT))=1),GROUP,Sele_Bankruptcy__Single_Rollup(LEFT)) + ROLLUP(HAVING(Sele_Bankruptcy_Group,COUNT(ROWS(LEFT))>1),GROUP,Sele_Bankruptcy__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Company__Orphan := JOIN(InData(__NN(Company_)),E_Business_Sele(__in,__cfg).__Result,__EEQP(LEFT.Company_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Bankrupt__Orphan := JOIN(InData(__NN(Bankrupt_)),E_Bankruptcy(__in,__cfg).__Result,__EEQP(LEFT.Bankrupt_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Company__Orphan),COUNT(Bankrupt__Orphan)}],{KEL.typ.int Company__Orphan,KEL.typ.int Bankrupt__Orphan});
  EXPORT NullCounts := DATASET([
    {'SeleBankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Company',COUNT(__d0(__NL(Company_))),COUNT(__d0(__NN(Company_)))},
    {'SeleBankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Bankrupt',COUNT(__d0(__NL(Bankrupt_))),COUNT(__d0(__NN(Bankrupt_)))},
    {'SeleBankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'SeleBankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'SeleBankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
