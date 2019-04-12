//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Business(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Company_Name_;
    KEL.typ.nint Tax_I_D_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),ultid(Ult_I_D_:0),orgid(Org_I_D_:0),seleid(Sele_I_D_:0),companyname(Company_Name_:\'\'),taxid(Tax_I_D_:0),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in.Dataset_BIPV2__Key_BH_Linking_Ids,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid)));
  EXPORT __All_Trim := __d0_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)0) + '|' + TRIM((STRING)0) + '|' + TRIM((STRING)0);
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED __Mapping0 := 'UID(UID),ultid(Ult_I_D_:0),orgid(Org_I_D_:0),seleid(Sele_I_D_:0),company_name(Company_Name_:\'\'),company_fein(Tax_I_D_:0),source(Source_:\'\'),dt_first_seen(Date_First_Seen_:EPOCH),dt_last_seen(Date_Last_Seen_:EPOCH),DPMBitmap(__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_Ids,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_Ids),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_BIPV2__Key_BH_Linking_Ids);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_Norm,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2__Key_BH_Linking_Ids_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  EXPORT InData := __d0;
  EXPORT Company_Names_Layout := RECORD
    KEL.typ.nstr Company_Name_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Tax_I_Ds_Layout := RECORD
    KEL.typ.nint Tax_I_D_;
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
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(Company_Names_Layout) Company_Names_;
    KEL.typ.ndataset(Tax_I_Ds_Layout) Tax_I_Ds_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Business_Group := __PostFilter;
  Layout Business__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Ult_I_D_ := KEL.Intake.SingleValue(__recs,Ult_I_D_);
    SELF.Org_I_D_ := KEL.Intake.SingleValue(__recs,Org_I_D_);
    SELF.Sele_I_D_ := KEL.Intake.SingleValue(__recs,Sele_I_D_);
    SELF.Company_Names_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Company_Name_},Company_Name_),Company_Names_Layout)(__NN(Company_Name_)));
    SELF.Tax_I_Ds_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Tax_I_D_},Tax_I_D_),Tax_I_Ds_Layout)(__NN(Tax_I_D_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Business__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Company_Names_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Company_Names_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Company_Name_)));
    SELF.Tax_I_Ds_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Tax_I_Ds_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Tax_I_D_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Business_Group,COUNT(ROWS(LEFT))=1),GROUP,Business__Single_Rollup(LEFT)) + ROLLUP(HAVING(Business_Group,COUNT(ROWS(LEFT))>1),GROUP,Business__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Ult_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ult_I_D_);
  EXPORT Org_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Org_I_D_);
  EXPORT Sele_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sele_I_D_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2__Key_BH_Linking_Ids_Invalid),COUNT(Ult_I_D__SingleValue_Invalid),COUNT(Org_I_D__SingleValue_Invalid),COUNT(Sele_I_D__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2__Key_BH_Linking_Ids_Invalid,KEL.typ.int Ult_I_D__SingleValue_Invalid,KEL.typ.int Org_I_D__SingleValue_Invalid,KEL.typ.int Sele_I_D__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Business','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2__Key_BH_Linking_Ids_Invalid),COUNT(__d0)},
    {'Business','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d0(__NL(Ult_I_D_))),COUNT(__d0(__NN(Ult_I_D_)))},
    {'Business','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d0(__NL(Org_I_D_))),COUNT(__d0(__NN(Org_I_D_)))},
    {'Business','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d0(__NL(Sele_I_D_))),COUNT(__d0(__NN(Sele_I_D_)))},
    {'Business','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_name',COUNT(__d0(__NL(Company_Name_))),COUNT(__d0(__NN(Company_Name_)))},
    {'Business','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_fein',COUNT(__d0(__NL(Tax_I_D_))),COUNT(__d0(__NN(Tax_I_D_)))},
    {'Business','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Business','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Business','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
