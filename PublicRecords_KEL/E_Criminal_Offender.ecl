//HPCC Systems KEL Compiler Version 1.5.0
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_Criminal_Offender(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Offender_Key_;
    KEL.typ.nstr Source_File_;
    KEL.typ.nstr Source_State_;
    KEL.typ.nstr Citizenship_;
    KEL.typ.nstr Hair_Color_;
    KEL.typ.nstr Eye_Color_;
    KEL.typ.nstr Skin_Color_;
    KEL.typ.nint Height_;
    KEL.typ.nint Weight_;
    KEL.typ.nstr Status_;
    KEL.typ.nstr Current_Incarcerated_Flag_;
    KEL.typ.nstr Current_Parole_Flag_;
    KEL.typ.nstr Current_Probation_Flag_;
    KEL.typ.nint Data_Type_;
    KEL.typ.nstr Data_Source_;
    KEL.typ.nint Number_Of_Offense_Counts_;
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
  SHARED __Mapping := 'UID(DEFAULT:UID),offenderkey(DEFAULT:Offender_Key_:\'\'),sourcefile(DEFAULT:Source_File_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),citizenship(DEFAULT:Citizenship_:\'\'),haircolor(DEFAULT:Hair_Color_:\'\'),eyecolor(DEFAULT:Eye_Color_:\'\'),skincolor(DEFAULT:Skin_Color_:\'\'),height(DEFAULT:Height_:0),weight(DEFAULT:Weight_:0),status(DEFAULT:Status_:\'\'),currentincarceratedflag(DEFAULT:Current_Incarcerated_Flag_:\'\'),currentparoleflag(DEFAULT:Current_Parole_Flag_:\'\'),currentprobationflag(DEFAULT:Current_Probation_Flag_:\'\'),datatype(DEFAULT:Data_Type_:0),datasource(DEFAULT:Data_Source_:\'\'),numberofoffensecounts(DEFAULT:Number_Of_Offense_Counts_:0),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in.Dataset_Doxie_Files__Key_Offenses,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.offender_key)));
  SHARED __d1_Trim := PROJECT(__in.Dataset_Doxie_Files__Key_Court_Offenses,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.offender_key)));
  SHARED __d2_Trim := PROJECT(__in.Dataset_Doxie_Files__Key_Offenders,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.offender_key)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim + __d2_Trim;
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
  SHARED __Mapping0 := 'UID(DEFAULT:UID),offender_key(OVERRIDE:Offender_Key_:\'\'),sourcefile(DEFAULT:Source_File_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),citizenship(DEFAULT:Citizenship_:\'\'),haircolor(DEFAULT:Hair_Color_:\'\'),eyecolor(DEFAULT:Eye_Color_:\'\'),skincolor(DEFAULT:Skin_Color_:\'\'),height(DEFAULT:Height_:0),weight(DEFAULT:Weight_:0),status(DEFAULT:Status_:\'\'),currentincarceratedflag(DEFAULT:Current_Incarcerated_Flag_:\'\'),currentparoleflag(DEFAULT:Current_Parole_Flag_:\'\'),currentprobationflag(DEFAULT:Current_Probation_Flag_:\'\'),datatype(DEFAULT:Data_Type_:0),datasource(DEFAULT:Data_Source_:\'\'),num_of_counts(OVERRIDE:Number_Of_Offense_Counts_:0),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Source_ := __CN('DC');
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenses,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenses),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Doxie_Files__Key_Offenses);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_Norm,Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenses_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping0_Transform(LEFT)));
  SHARED __Mapping1 := 'UID(DEFAULT:UID),offender_key(OVERRIDE:Offender_Key_:\'\'),sourcefile(DEFAULT:Source_File_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),citizenship(DEFAULT:Citizenship_:\'\'),haircolor(DEFAULT:Hair_Color_:\'\'),eyecolor(DEFAULT:Eye_Color_:\'\'),skincolor(DEFAULT:Skin_Color_:\'\'),height(DEFAULT:Height_:0),weight(DEFAULT:Weight_:0),status(DEFAULT:Status_:\'\'),currentincarceratedflag(DEFAULT:Current_Incarcerated_Flag_:\'\'),currentparoleflag(DEFAULT:Current_Parole_Flag_:\'\'),currentprobationflag(DEFAULT:Current_Probation_Flag_:\'\'),datatype(DEFAULT:Data_Type_:0),datasource(DEFAULT:Data_Source_:\'\'),num_of_counts(OVERRIDE:Number_Of_Offense_Counts_:0),source(DEFAULT:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Court_Offenses,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Court_Offenses),SELF:=RIGHT));
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Doxie_Files__Key_Court_Offenses);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_Norm,Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Court_Offenses_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping2 := 'UID(DEFAULT:UID),offender_key(OVERRIDE:Offender_Key_:\'\'),source_file(OVERRIDE:Source_File_:\'\'),orig_state(OVERRIDE:Source_State_:\'\'),citizenship(OVERRIDE:Citizenship_:\'\'),hair_color_desc(OVERRIDE:Hair_Color_:\'\'),eye_color_desc(OVERRIDE:Eye_Color_:\'\'),skin_color_desc(OVERRIDE:Skin_Color_:\'\'),height(OVERRIDE:Height_:0),weight(OVERRIDE:Weight_:0),party_status_desc(OVERRIDE:Status_:\'\'),curr_incar_flag(OVERRIDE:Current_Incarcerated_Flag_:\'\'),curr_parole_flag(OVERRIDE:Current_Parole_Flag_:\'\'),curr_probation_flag(OVERRIDE:Current_Probation_Flag_:\'\'),data_type(OVERRIDE:Data_Type_:0),datasource(OVERRIDE:Data_Source_:\'\'),numberofoffensecounts(DEFAULT:Number_Of_Offense_Counts_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),fcra_date(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders),SELF:=RIGHT));
  SHARED __d2_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Doxie_Files__Key_Offenders);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d2_UID_Mapped := JOIN(__d2_Norm,Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d2_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_Invalid := __d2_UID_Mapped(UID = 0);
  SHARED __d2_Prefiltered := __d2_UID_Mapped(UID <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1 + __d2;
  EXPORT Sources_Layout := RECORD
    KEL.typ.nstr Source_File_;
    KEL.typ.nint Data_Type_;
    KEL.typ.nstr Data_Source_;
    KEL.typ.nstr Source_State_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Current_Status_Layout := RECORD
    KEL.typ.nstr Status_;
    KEL.typ.nstr Current_Incarcerated_Flag_;
    KEL.typ.nstr Current_Parole_Flag_;
    KEL.typ.nstr Current_Probation_Flag_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Number_Of_Offense_Counts_Layout := RECORD
    KEL.typ.nint Number_Of_Offense_Counts_;
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
    KEL.typ.nstr Offender_Key_;
    KEL.typ.ndataset(Sources_Layout) Sources_;
    KEL.typ.nstr Citizenship_;
    KEL.typ.nstr Hair_Color_;
    KEL.typ.nstr Eye_Color_;
    KEL.typ.nstr Skin_Color_;
    KEL.typ.nint Height_;
    KEL.typ.nint Weight_;
    KEL.typ.ndataset(Current_Status_Layout) Current_Status_;
    KEL.typ.ndataset(Number_Of_Offense_Counts_Layout) Number_Of_Offense_Counts_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Criminal_Offender_Group := __PostFilter;
  Layout Criminal_Offender__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Offender_Key_ := KEL.Intake.SingleValue(__recs,Offender_Key_);
    SELF.Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_File_,Data_Type_,Data_Source_,Source_State_},Source_File_,Data_Type_,Data_Source_,Source_State_),Sources_Layout)(__NN(Source_File_) OR __NN(Data_Type_) OR __NN(Data_Source_) OR __NN(Source_State_)));
    SELF.Citizenship_ := KEL.Intake.SingleValue(__recs,Citizenship_);
    SELF.Hair_Color_ := KEL.Intake.SingleValue(__recs,Hair_Color_);
    SELF.Eye_Color_ := KEL.Intake.SingleValue(__recs,Eye_Color_);
    SELF.Skin_Color_ := KEL.Intake.SingleValue(__recs,Skin_Color_);
    SELF.Height_ := KEL.Intake.SingleValue(__recs,Height_);
    SELF.Weight_ := KEL.Intake.SingleValue(__recs,Weight_);
    SELF.Current_Status_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Status_,Current_Incarcerated_Flag_,Current_Parole_Flag_,Current_Probation_Flag_},Status_,Current_Incarcerated_Flag_,Current_Parole_Flag_,Current_Probation_Flag_),Current_Status_Layout)(__NN(Status_) OR __NN(Current_Incarcerated_Flag_) OR __NN(Current_Parole_Flag_) OR __NN(Current_Probation_Flag_)));
    SELF.Number_Of_Offense_Counts_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Number_Of_Offense_Counts_},Number_Of_Offense_Counts_),Number_Of_Offense_Counts_Layout)(__NN(Number_Of_Offense_Counts_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Criminal_Offender__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_File_) OR __NN(Data_Type_) OR __NN(Data_Source_) OR __NN(Source_State_)));
    SELF.Current_Status_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Current_Status_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Status_) OR __NN(Current_Incarcerated_Flag_) OR __NN(Current_Parole_Flag_) OR __NN(Current_Probation_Flag_)));
    SELF.Number_Of_Offense_Counts_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Number_Of_Offense_Counts_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Number_Of_Offense_Counts_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Criminal_Offender_Group,COUNT(ROWS(LEFT))=1),GROUP,Criminal_Offender__Single_Rollup(LEFT)) + ROLLUP(HAVING(Criminal_Offender_Group,COUNT(ROWS(LEFT))>1),GROUP,Criminal_Offender__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Offender_Key__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Offender_Key_);
  EXPORT Citizenship__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Citizenship_);
  EXPORT Hair_Color__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Hair_Color_);
  EXPORT Eye_Color__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Eye_Color_);
  EXPORT Skin_Color__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Skin_Color_);
  EXPORT Height__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Height_);
  EXPORT Weight__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Weight_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenses_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Court_Offenses_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_Invalid),COUNT(Offender_Key__SingleValue_Invalid),COUNT(Citizenship__SingleValue_Invalid),COUNT(Hair_Color__SingleValue_Invalid),COUNT(Eye_Color__SingleValue_Invalid),COUNT(Skin_Color__SingleValue_Invalid),COUNT(Height__SingleValue_Invalid),COUNT(Weight__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenses_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Court_Offenses_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_Invalid,KEL.typ.int Offender_Key__SingleValue_Invalid,KEL.typ.int Citizenship__SingleValue_Invalid,KEL.typ.int Hair_Color__SingleValue_Invalid,KEL.typ.int Eye_Color__SingleValue_Invalid,KEL.typ.int Skin_Color__SingleValue_Invalid,KEL.typ.int Height__SingleValue_Invalid,KEL.typ.int Weight__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenses_Invalid),COUNT(__d0)},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','offender_key',COUNT(__d0(__NL(Offender_Key_))),COUNT(__d0(__NN(Offender_Key_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d0(__NL(Source_File_))),COUNT(__d0(__NN(Source_File_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceState',COUNT(__d0(__NL(Source_State_))),COUNT(__d0(__NN(Source_State_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Citizenship',COUNT(__d0(__NL(Citizenship_))),COUNT(__d0(__NN(Citizenship_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HairColor',COUNT(__d0(__NL(Hair_Color_))),COUNT(__d0(__NN(Hair_Color_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EyeColor',COUNT(__d0(__NL(Eye_Color_))),COUNT(__d0(__NN(Eye_Color_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SkinColor',COUNT(__d0(__NL(Skin_Color_))),COUNT(__d0(__NN(Skin_Color_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Height',COUNT(__d0(__NL(Height_))),COUNT(__d0(__NN(Height_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Weight',COUNT(__d0(__NL(Weight_))),COUNT(__d0(__NN(Weight_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Status',COUNT(__d0(__NL(Status_))),COUNT(__d0(__NN(Status_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentIncarceratedFlag',COUNT(__d0(__NL(Current_Incarcerated_Flag_))),COUNT(__d0(__NN(Current_Incarcerated_Flag_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentParoleFlag',COUNT(__d0(__NL(Current_Parole_Flag_))),COUNT(__d0(__NN(Current_Parole_Flag_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentProbationFlag',COUNT(__d0(__NL(Current_Probation_Flag_))),COUNT(__d0(__NN(Current_Probation_Flag_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataType',COUNT(__d0(__NL(Data_Type_))),COUNT(__d0(__NN(Data_Type_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataSource',COUNT(__d0(__NL(Data_Source_))),COUNT(__d0(__NN(Data_Source_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','num_of_counts',COUNT(__d0(__NL(Number_Of_Offense_Counts_))),COUNT(__d0(__NN(Number_Of_Offense_Counts_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Court_Offenses_Invalid),COUNT(__d1)},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','offender_key',COUNT(__d1(__NL(Offender_Key_))),COUNT(__d1(__NN(Offender_Key_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d1(__NL(Source_File_))),COUNT(__d1(__NN(Source_File_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceState',COUNT(__d1(__NL(Source_State_))),COUNT(__d1(__NN(Source_State_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Citizenship',COUNT(__d1(__NL(Citizenship_))),COUNT(__d1(__NN(Citizenship_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HairColor',COUNT(__d1(__NL(Hair_Color_))),COUNT(__d1(__NN(Hair_Color_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EyeColor',COUNT(__d1(__NL(Eye_Color_))),COUNT(__d1(__NN(Eye_Color_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SkinColor',COUNT(__d1(__NL(Skin_Color_))),COUNT(__d1(__NN(Skin_Color_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Height',COUNT(__d1(__NL(Height_))),COUNT(__d1(__NN(Height_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Weight',COUNT(__d1(__NL(Weight_))),COUNT(__d1(__NN(Weight_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Status',COUNT(__d1(__NL(Status_))),COUNT(__d1(__NN(Status_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentIncarceratedFlag',COUNT(__d1(__NL(Current_Incarcerated_Flag_))),COUNT(__d1(__NN(Current_Incarcerated_Flag_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentParoleFlag',COUNT(__d1(__NL(Current_Parole_Flag_))),COUNT(__d1(__NN(Current_Parole_Flag_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentProbationFlag',COUNT(__d1(__NL(Current_Probation_Flag_))),COUNT(__d1(__NN(Current_Probation_Flag_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataType',COUNT(__d1(__NL(Data_Type_))),COUNT(__d1(__NN(Data_Type_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataSource',COUNT(__d1(__NL(Data_Source_))),COUNT(__d1(__NN(Data_Source_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','num_of_counts',COUNT(__d1(__NL(Number_Of_Offense_Counts_))),COUNT(__d1(__NN(Number_Of_Offense_Counts_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_Invalid),COUNT(__d2)},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','offender_key',COUNT(__d2(__NL(Offender_Key_))),COUNT(__d2(__NN(Offender_Key_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source_file',COUNT(__d2(__NL(Source_File_))),COUNT(__d2(__NN(Source_File_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_state',COUNT(__d2(__NL(Source_State_))),COUNT(__d2(__NN(Source_State_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','citizenship',COUNT(__d2(__NL(Citizenship_))),COUNT(__d2(__NN(Citizenship_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','hair_color_desc',COUNT(__d2(__NL(Hair_Color_))),COUNT(__d2(__NN(Hair_Color_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','eye_color_desc',COUNT(__d2(__NL(Eye_Color_))),COUNT(__d2(__NN(Eye_Color_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','skin_color_desc',COUNT(__d2(__NL(Skin_Color_))),COUNT(__d2(__NN(Skin_Color_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','height',COUNT(__d2(__NL(Height_))),COUNT(__d2(__NN(Height_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','weight',COUNT(__d2(__NL(Weight_))),COUNT(__d2(__NN(Weight_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','party_status_desc',COUNT(__d2(__NL(Status_))),COUNT(__d2(__NN(Status_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','curr_incar_flag',COUNT(__d2(__NL(Current_Incarcerated_Flag_))),COUNT(__d2(__NN(Current_Incarcerated_Flag_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','curr_parole_flag',COUNT(__d2(__NL(Current_Parole_Flag_))),COUNT(__d2(__NN(Current_Parole_Flag_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','curr_probation_flag',COUNT(__d2(__NL(Current_Probation_Flag_))),COUNT(__d2(__NN(Current_Probation_Flag_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','data_type',COUNT(__d2(__NL(Data_Type_))),COUNT(__d2(__NN(Data_Type_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','datasource',COUNT(__d2(__NL(Data_Source_))),COUNT(__d2(__NN(Data_Source_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfOffenseCounts',COUNT(__d2(__NL(Number_Of_Offense_Counts_))),COUNT(__d2(__NN(Number_Of_Offense_Counts_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'CriminalOffender','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
