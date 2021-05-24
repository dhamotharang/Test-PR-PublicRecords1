//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL16.Null;
EXPORT E_Surname(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Surname_;
    KEL.typ.nbool Is_Latest_;
    KEL.typ.nint Name_Rank_;
    KEL.typ.nint Name_Count_;
    KEL.typ.nfloat Prop100_K_;
    KEL.typ.nfloat Cumulative_Prop100_K_;
    KEL.typ.nfloat Percent_White_;
    KEL.typ.nfloat Percent_Black_;
    KEL.typ.nfloat Percent_Asian_Pacific_Islander_;
    KEL.typ.nfloat Percent_American_Indian_Alaska_Native_;
    KEL.typ.nfloat Percent_Multiracial_;
    KEL.typ.nfloat Percent_Hispanic_;
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
  SHARED __Mapping := 'UID(DEFAULT:UID),surname(DEFAULT:Surname_:\'\'),islatest(DEFAULT:Is_Latest_),namerank(DEFAULT:Name_Rank_:0),namecount(DEFAULT:Name_Count_:0),prop100k(DEFAULT:Prop100_K_:0.0),cumulativeprop100k(DEFAULT:Cumulative_Prop100_K_:0.0),percentwhite(DEFAULT:Percent_White_),percentblack(DEFAULT:Percent_Black_),percentasianpacificislander(DEFAULT:Percent_Asian_Pacific_Islander_),percentamericanindianalaskanative(DEFAULT:Percent_American_Indian_Alaska_Native_),percentmultiracial(DEFAULT:Percent_Multiracial_),percenthispanic(DEFAULT:Percent_Hispanic_),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in.Dataset_dx_CFPB_key_Census_Surnames,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.name)));
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
  SHARED __Mapping0 := 'UID(DEFAULT:UID),name(OVERRIDE:Surname_:\'\'),is_latest(OVERRIDE:Is_Latest_),name_rank(OVERRIDE:Name_Rank_:0),name_count(OVERRIDE:Name_Count_:0),prop100k(OVERRIDE:Prop100_K_:0.0),cum_prop100k(OVERRIDE:Cumulative_Prop100_K_:0.0),pctwhite(OVERRIDE:Percent_White_),pctblack(OVERRIDE:Percent_Black_),pctapi(OVERRIDE:Percent_Asian_Pacific_Islander_),pctaian(OVERRIDE:Percent_American_Indian_Alaska_Native_),pct2prace(OVERRIDE:Percent_Multiracial_),pcthispanic(OVERRIDE:Percent_Hispanic_),src(OVERRIDE:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),dt_vendor_first_reported(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_dx_CFPB_key_Census_Surnames,TRANSFORM(RECORDOF(__in.Dataset_dx_CFPB_key_Census_Surnames),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_dx_CFPB_key_Census_Surnames);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_Norm,Lookup,TRIM((STRING)LEFT.name) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_dx_CFPB_key_Census_Surnames_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0;
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
    KEL.typ.nstr Surname_;
    KEL.typ.nbool Is_Latest_;
    KEL.typ.nint Name_Rank_;
    KEL.typ.nint Name_Count_;
    KEL.typ.nfloat Prop100_K_;
    KEL.typ.nfloat Cumulative_Prop100_K_;
    KEL.typ.nfloat Percent_White_;
    KEL.typ.nfloat Percent_Black_;
    KEL.typ.nfloat Percent_Asian_Pacific_Islander_;
    KEL.typ.nfloat Percent_American_Indian_Alaska_Native_;
    KEL.typ.nfloat Percent_Multiracial_;
    KEL.typ.nfloat Percent_Hispanic_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Surname_Group := __PostFilter;
  Layout Surname__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Surname_ := KEL.Intake.SingleValue(__recs,Surname_);
    SELF.Is_Latest_ := KEL.Intake.SingleValue(__recs,Is_Latest_);
    SELF.Name_Rank_ := KEL.Intake.SingleValue(__recs,Name_Rank_);
    SELF.Name_Count_ := KEL.Intake.SingleValue(__recs,Name_Count_);
    SELF.Prop100_K_ := KEL.Intake.SingleValue(__recs,Prop100_K_);
    SELF.Cumulative_Prop100_K_ := KEL.Intake.SingleValue(__recs,Cumulative_Prop100_K_);
    SELF.Percent_White_ := KEL.Intake.SingleValue(__recs,Percent_White_);
    SELF.Percent_Black_ := KEL.Intake.SingleValue(__recs,Percent_Black_);
    SELF.Percent_Asian_Pacific_Islander_ := KEL.Intake.SingleValue(__recs,Percent_Asian_Pacific_Islander_);
    SELF.Percent_American_Indian_Alaska_Native_ := KEL.Intake.SingleValue(__recs,Percent_American_Indian_Alaska_Native_);
    SELF.Percent_Multiracial_ := KEL.Intake.SingleValue(__recs,Percent_Multiracial_);
    SELF.Percent_Hispanic_ := KEL.Intake.SingleValue(__recs,Percent_Hispanic_);
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Surname__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Surname_Group,COUNT(ROWS(LEFT))=1),GROUP,Surname__Single_Rollup(LEFT)) + ROLLUP(HAVING(Surname_Group,COUNT(ROWS(LEFT))>1),GROUP,Surname__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Surname__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Surname_);
  EXPORT Is_Latest__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Is_Latest_);
  EXPORT Name_Rank__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Name_Rank_);
  EXPORT Name_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Name_Count_);
  EXPORT Prop100_K__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Prop100_K_);
  EXPORT Cumulative_Prop100_K__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Cumulative_Prop100_K_);
  EXPORT Percent_White__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Percent_White_);
  EXPORT Percent_Black__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Percent_Black_);
  EXPORT Percent_Asian_Pacific_Islander__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Percent_Asian_Pacific_Islander_);
  EXPORT Percent_American_Indian_Alaska_Native__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Percent_American_Indian_Alaska_Native_);
  EXPORT Percent_Multiracial__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Percent_Multiracial_);
  EXPORT Percent_Hispanic__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Percent_Hispanic_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_dx_CFPB_key_Census_Surnames_Invalid),COUNT(Surname__SingleValue_Invalid),COUNT(Is_Latest__SingleValue_Invalid),COUNT(Name_Rank__SingleValue_Invalid),COUNT(Name_Count__SingleValue_Invalid),COUNT(Prop100_K__SingleValue_Invalid),COUNT(Cumulative_Prop100_K__SingleValue_Invalid),COUNT(Percent_White__SingleValue_Invalid),COUNT(Percent_Black__SingleValue_Invalid),COUNT(Percent_Asian_Pacific_Islander__SingleValue_Invalid),COUNT(Percent_American_Indian_Alaska_Native__SingleValue_Invalid),COUNT(Percent_Multiracial__SingleValue_Invalid),COUNT(Percent_Hispanic__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_dx_CFPB_key_Census_Surnames_Invalid,KEL.typ.int Surname__SingleValue_Invalid,KEL.typ.int Is_Latest__SingleValue_Invalid,KEL.typ.int Name_Rank__SingleValue_Invalid,KEL.typ.int Name_Count__SingleValue_Invalid,KEL.typ.int Prop100_K__SingleValue_Invalid,KEL.typ.int Cumulative_Prop100_K__SingleValue_Invalid,KEL.typ.int Percent_White__SingleValue_Invalid,KEL.typ.int Percent_Black__SingleValue_Invalid,KEL.typ.int Percent_Asian_Pacific_Islander__SingleValue_Invalid,KEL.typ.int Percent_American_Indian_Alaska_Native__SingleValue_Invalid,KEL.typ.int Percent_Multiracial__SingleValue_Invalid,KEL.typ.int Percent_Hispanic__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Surname','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_dx_CFPB_key_Census_Surnames_Invalid),COUNT(__d0)},
    {'Surname','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name',COUNT(__d0(__NL(Surname_))),COUNT(__d0(__NN(Surname_)))},
    {'Surname','PublicRecords_KEL.ECL_Functions.Dataset_FDC','is_latest',COUNT(__d0(__NL(Is_Latest_))),COUNT(__d0(__NN(Is_Latest_)))},
    {'Surname','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_rank',COUNT(__d0(__NL(Name_Rank_))),COUNT(__d0(__NN(Name_Rank_)))},
    {'Surname','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_count',COUNT(__d0(__NL(Name_Count_))),COUNT(__d0(__NN(Name_Count_)))},
    {'Surname','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prop100k',COUNT(__d0(__NL(Prop100_K_))),COUNT(__d0(__NN(Prop100_K_)))},
    {'Surname','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cum_prop100k',COUNT(__d0(__NL(Cumulative_Prop100_K_))),COUNT(__d0(__NN(Cumulative_Prop100_K_)))},
    {'Surname','PublicRecords_KEL.ECL_Functions.Dataset_FDC','pctwhite',COUNT(__d0(__NL(Percent_White_))),COUNT(__d0(__NN(Percent_White_)))},
    {'Surname','PublicRecords_KEL.ECL_Functions.Dataset_FDC','pctblack',COUNT(__d0(__NL(Percent_Black_))),COUNT(__d0(__NN(Percent_Black_)))},
    {'Surname','PublicRecords_KEL.ECL_Functions.Dataset_FDC','pctapi',COUNT(__d0(__NL(Percent_Asian_Pacific_Islander_))),COUNT(__d0(__NN(Percent_Asian_Pacific_Islander_)))},
    {'Surname','PublicRecords_KEL.ECL_Functions.Dataset_FDC','pctaian',COUNT(__d0(__NL(Percent_American_Indian_Alaska_Native_))),COUNT(__d0(__NN(Percent_American_Indian_Alaska_Native_)))},
    {'Surname','PublicRecords_KEL.ECL_Functions.Dataset_FDC','pct2prace',COUNT(__d0(__NL(Percent_Multiracial_))),COUNT(__d0(__NN(Percent_Multiracial_)))},
    {'Surname','PublicRecords_KEL.ECL_Functions.Dataset_FDC','pcthispanic',COUNT(__d0(__NL(Percent_Hispanic_))),COUNT(__d0(__NN(Percent_Hispanic_)))},
    {'Surname','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Surname','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'Surname','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Surname','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Surname','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'Surname','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
