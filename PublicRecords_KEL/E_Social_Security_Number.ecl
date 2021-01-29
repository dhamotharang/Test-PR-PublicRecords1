//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_Social_Security_Number(CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.nkdate Official_First_Seen_;
    KEL.typ.nkdate Official_Last_Seen_;
    KEL.typ.nkdate Date_Of_Death_;
    KEL.typ.nbool Death_Master_Flag_;
    KEL.typ.nstr Issue_State_;
    KEL.typ.nkdate Header_First_Seen_;
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
  SHARED __Mapping := 'ssn(DEFAULT:UID|DEFAULT:S_S_N_:\'\'),officialfirstseen(DEFAULT:Official_First_Seen_:DATE),officiallastseen(DEFAULT:Official_Last_Seen_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),deathmasterflag(DEFAULT:Death_Master_Flag_),issuestate(DEFAULT:Issue_State_:\'\'),headerfirstseen(DEFAULT:Header_First_Seen_:DATE),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED Hybrid_Archive_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'ssn(OVERRIDE:UID|DEFAULT:S_S_N_:\'\'),officialfirstseen(DEFAULT:Official_First_Seen_:DATE),officiallastseen(DEFAULT:Official_Last_Seen_:DATE),dod(OVERRIDE:Date_Of_Death_:DATE),deathmasterflag(DEFAULT:Death_Master_Flag_),st(OVERRIDE:Issue_State_:\'\'),dt_first_seen(OVERRIDE:Header_First_Seen_:DATE|OVERRIDE:Date_First_Seen_:EPOCH|OVERRIDE:Date_Last_Seen_:EPOCH),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_0Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d0_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault((UNSIGNED)ssn != 0);
  EXPORT PublicRecords_KEL_Files_NonFCRA_Doxie__Key_Header_Vault_Invalid := __d0_KELfiltered((KEL.typ.uid)ssn = 0);
  SHARED __d0_Prefiltered := __d0_KELfiltered((KEL.typ.uid)ssn <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault'));
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'ssn(OVERRIDE:UID|DEFAULT:S_S_N_:\'\'),officialfirstseen(DEFAULT:Official_First_Seen_:DATE),officiallastseen(DEFAULT:Official_Last_Seen_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),deathmasterflag(DEFAULT:Death_Master_Flag_),st(OVERRIDE:Issue_State_:\'\'),dt_first_seen(OVERRIDE:Header_First_Seen_:DATE|OVERRIDE:Date_First_Seen_:EPOCH),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_1Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d1_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault((UNSIGNED)ssn != 0);
  EXPORT PublicRecords_KEL_Files_NonFCRA_Header_Quick__Key_Did_Vault_Invalid := __d1_KELfiltered((KEL.typ.uid)ssn = 0);
  SHARED __d1_Prefiltered := __d1_KELfiltered((KEL.typ.uid)ssn <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault'));
  SHARED __Mapping2 := 'ssn(OVERRIDE:UID|DEFAULT:S_S_N_:\'\'),officialfirstseen(DEFAULT:Official_First_Seen_:DATE),officiallastseen(DEFAULT:Official_Last_Seen_:DATE),dod8(OVERRIDE:Date_Of_Death_:DATE),state(OVERRIDE:Issue_State_:\'\'),headerfirstseen(DEFAULT:Header_First_Seen_:DATE),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping2_Transform(InLayout __r) := TRANSFORM
    SELF.Death_Master_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d2_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault((UNSIGNED)ssn != 0);
  EXPORT PublicRecords_KEL_Files_NonFCRA_Death_Master__Key_ssn_ssa_Vault_Invalid := __d2_KELfiltered((KEL.typ.uid)ssn = 0);
  SHARED __d2_Prefiltered := __d2_KELfiltered((KEL.typ.uid)ssn <> 0);
  SHARED __d2 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault'),__Mapping2_Transform(LEFT)));
  SHARED Date_Last_Seen_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping3 := 'ssn(OVERRIDE:UID|DEFAULT:S_S_N_:\'\'),officialfirstseen(DEFAULT:Official_First_Seen_:DATE),officiallastseen(DEFAULT:Official_Last_Seen_:DATE),dod(OVERRIDE:Date_Of_Death_:DATE),deathmasterflag(DEFAULT:Death_Master_Flag_),st(OVERRIDE:Issue_State_:\'\'),dt_first_seen(OVERRIDE:Header_First_Seen_:DATE|OVERRIDE:Date_First_Seen_:EPOCH),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_3Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_3Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d3_KELfiltered := PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault((UNSIGNED)ssn != 0);
  EXPORT PublicRecords_KEL_Files_FCRA_Doxie__Key_FCRA_Header_Vault_Invalid := __d3_KELfiltered((KEL.typ.uid)ssn = 0);
  SHARED __d3_Prefiltered := __d3_KELfiltered((KEL.typ.uid)ssn <> 0);
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault'));
  SHARED Date_Last_Seen_4Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_4Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping4 := 'ssn(OVERRIDE:UID|DEFAULT:S_S_N_:\'\'),officialfirstseen(DEFAULT:Official_First_Seen_:DATE),officiallastseen(DEFAULT:Official_Last_Seen_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),deathmasterflag(DEFAULT:Death_Master_Flag_),st(OVERRIDE:Issue_State_:\'\'),dt_first_seen(OVERRIDE:Header_First_Seen_:DATE|OVERRIDE:Date_First_Seen_:EPOCH),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_4Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_4Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d4_KELfiltered := PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault((UNSIGNED)ssn != 0);
  EXPORT PublicRecords_KEL_Files_FCRA_Header_Quick__Key_Did_FCRA_Vault_Invalid := __d4_KELfiltered((KEL.typ.uid)ssn = 0);
  SHARED __d4_Prefiltered := __d4_KELfiltered((KEL.typ.uid)ssn <> 0);
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault'));
  SHARED __Mapping5 := 'ssn(OVERRIDE:UID|DEFAULT:S_S_N_:\'\'),officialfirstseen(DEFAULT:Official_First_Seen_:DATE),officiallastseen(DEFAULT:Official_Last_Seen_:DATE),dod8(OVERRIDE:Date_Of_Death_:DATE),state(OVERRIDE:Issue_State_:\'\'),headerfirstseen(DEFAULT:Header_First_Seen_:DATE),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping5_Transform(InLayout __r) := TRANSFORM
    SELF.Death_Master_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d5_KELfiltered := PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault((UNSIGNED)ssn != 0);
  EXPORT PublicRecords_KEL_Files_FCRA_Death_Master__Key_ssn_ssa_Vault_Invalid := __d5_KELfiltered((KEL.typ.uid)ssn = 0);
  SHARED __d5_Prefiltered := __d5_KELfiltered((KEL.typ.uid)ssn <> 0);
  SHARED __d5 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault'),__Mapping5_Transform(LEFT)));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5;
  EXPORT Dates_Of_Death_Layout := RECORD
    KEL.typ.nkdate Date_Of_Death_;
    KEL.typ.nbool Death_Master_Flag_;
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
    KEL.typ.nstr S_S_N_;
    KEL.typ.nkdate Official_First_Seen_;
    KEL.typ.nkdate Official_Last_Seen_;
    KEL.typ.nstr Issue_State_;
    KEL.typ.nkdate Header_First_Seen_;
    KEL.typ.ndataset(Dates_Of_Death_Layout) Dates_Of_Death_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Social_Security_Number_Group := __PostFilter;
  Layout Social_Security_Number__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.S_S_N_ := KEL.Intake.SingleValue(__recs,S_S_N_);
    SELF.Official_First_Seen_ := KEL.Intake.SingleValue(__recs,Official_First_Seen_);
    SELF.Official_Last_Seen_ := KEL.Intake.SingleValue(__recs,Official_Last_Seen_);
    SELF.Issue_State_ := KEL.Intake.SingleValue(__recs,Issue_State_);
    SELF.Header_First_Seen_ := KEL.Intake.SingleValue(__recs,Header_First_Seen_);
    SELF.Dates_Of_Death_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Date_Of_Death_,Death_Master_Flag_},Date_Of_Death_,Death_Master_Flag_),Dates_Of_Death_Layout)(__NN(Date_Of_Death_) OR __NN(Death_Master_Flag_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Social_Security_Number__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Dates_Of_Death_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Dates_Of_Death_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Date_Of_Death_) OR __NN(Death_Master_Flag_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Social_Security_Number_Group,COUNT(ROWS(LEFT))=1),GROUP,Social_Security_Number__Single_Rollup(LEFT)) + ROLLUP(HAVING(Social_Security_Number_Group,COUNT(ROWS(LEFT))>1),GROUP,Social_Security_Number__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := TABLE(InData,{KEL.typ.uid UID := MIN(GROUP,__T(UID)),KEL.typ.int Cnt := COUNT(GROUP)},UID);
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT S_S_N__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,S_S_N_);
  EXPORT Official_First_Seen__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Official_First_Seen_);
  EXPORT Official_Last_Seen__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Official_Last_Seen_);
  EXPORT Issue_State__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Issue_State_);
  EXPORT Header_First_Seen__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Header_First_Seen_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_Files_NonFCRA_Doxie__Key_Header_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_Header_Quick__Key_Did_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_Death_Master__Key_ssn_ssa_Vault_Invalid),COUNT(PublicRecords_KEL_Files_FCRA_Doxie__Key_FCRA_Header_Vault_Invalid),COUNT(PublicRecords_KEL_Files_FCRA_Header_Quick__Key_Did_FCRA_Vault_Invalid),COUNT(PublicRecords_KEL_Files_FCRA_Death_Master__Key_ssn_ssa_Vault_Invalid),COUNT(S_S_N__SingleValue_Invalid),COUNT(Official_First_Seen__SingleValue_Invalid),COUNT(Official_Last_Seen__SingleValue_Invalid),COUNT(Issue_State__SingleValue_Invalid),COUNT(Header_First_Seen__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_Files_NonFCRA_Doxie__Key_Header_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_Header_Quick__Key_Did_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_Death_Master__Key_ssn_ssa_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_FCRA_Doxie__Key_FCRA_Header_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_FCRA_Header_Quick__Key_Did_FCRA_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_FCRA_Death_Master__Key_ssn_ssa_Vault_Invalid,KEL.typ.int S_S_N__SingleValue_Invalid,KEL.typ.int Official_First_Seen__SingleValue_Invalid,KEL.typ.int Official_Last_Seen__SingleValue_Invalid,KEL.typ.int Issue_State__SingleValue_Invalid,KEL.typ.int Header_First_Seen__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_Doxie__Key_Header_Vault_Invalid),COUNT(__d0)},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','SSN',COUNT(__d0(__NL(S_S_N_))),COUNT(__d0(__NN(S_S_N_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','OfficialFirstSeen',COUNT(__d0(__NL(Official_First_Seen_))),COUNT(__d0(__NN(Official_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','OfficialLastSeen',COUNT(__d0(__NL(Official_Last_Seen_))),COUNT(__d0(__NN(Official_Last_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','dod',COUNT(__d0(__NL(Date_Of_Death_))),COUNT(__d0(__NN(Date_Of_Death_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','DeathMasterFlag',COUNT(__d0(__NL(Death_Master_Flag_))),COUNT(__d0(__NN(Death_Master_Flag_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','st',COUNT(__d0(__NL(Issue_State_))),COUNT(__d0(__NN(Issue_State_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','dt_first_seen',COUNT(__d0(__NL(Header_First_Seen_))),COUNT(__d0(__NN(Header_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_Header_Quick__Key_Did_Vault_Invalid),COUNT(__d1)},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','SSN',COUNT(__d1(__NL(S_S_N_))),COUNT(__d1(__NN(S_S_N_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','OfficialFirstSeen',COUNT(__d1(__NL(Official_First_Seen_))),COUNT(__d1(__NN(Official_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','OfficialLastSeen',COUNT(__d1(__NL(Official_Last_Seen_))),COUNT(__d1(__NN(Official_Last_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','DateOfDeath',COUNT(__d1(__NL(Date_Of_Death_))),COUNT(__d1(__NN(Date_Of_Death_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','DeathMasterFlag',COUNT(__d1(__NL(Death_Master_Flag_))),COUNT(__d1(__NN(Death_Master_Flag_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','st',COUNT(__d1(__NL(Issue_State_))),COUNT(__d1(__NN(Issue_State_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','dt_first_seen',COUNT(__d1(__NL(Header_First_Seen_))),COUNT(__d1(__NN(Header_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_Death_Master__Key_ssn_ssa_Vault_Invalid),COUNT(__d2)},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault','SSN',COUNT(__d2(__NL(S_S_N_))),COUNT(__d2(__NN(S_S_N_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault','OfficialFirstSeen',COUNT(__d2(__NL(Official_First_Seen_))),COUNT(__d2(__NN(Official_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault','OfficialLastSeen',COUNT(__d2(__NL(Official_Last_Seen_))),COUNT(__d2(__NN(Official_Last_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault','dod8',COUNT(__d2(__NL(Date_Of_Death_))),COUNT(__d2(__NN(Date_Of_Death_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault','state',COUNT(__d2(__NL(Issue_State_))),COUNT(__d2(__NN(Issue_State_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault','HeaderFirstSeen',COUNT(__d2(__NL(Header_First_Seen_))),COUNT(__d2(__NN(Header_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','UID',COUNT(PublicRecords_KEL_Files_FCRA_Doxie__Key_FCRA_Header_Vault_Invalid),COUNT(__d3)},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','SSN',COUNT(__d3(__NL(S_S_N_))),COUNT(__d3(__NN(S_S_N_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','OfficialFirstSeen',COUNT(__d3(__NL(Official_First_Seen_))),COUNT(__d3(__NN(Official_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','OfficialLastSeen',COUNT(__d3(__NL(Official_Last_Seen_))),COUNT(__d3(__NN(Official_Last_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','dod',COUNT(__d3(__NL(Date_Of_Death_))),COUNT(__d3(__NN(Date_Of_Death_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','DeathMasterFlag',COUNT(__d3(__NL(Death_Master_Flag_))),COUNT(__d3(__NN(Death_Master_Flag_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','st',COUNT(__d3(__NL(Issue_State_))),COUNT(__d3(__NN(Issue_State_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','dt_first_seen',COUNT(__d3(__NL(Header_First_Seen_))),COUNT(__d3(__NN(Header_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','HybridArchiveDate',COUNT(__d3(Hybrid_Archive_Date_=0)),COUNT(__d3(Hybrid_Archive_Date_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','VaultDateLastSeen',COUNT(__d3(Vault_Date_Last_Seen_=0)),COUNT(__d3(Vault_Date_Last_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','UID',COUNT(PublicRecords_KEL_Files_FCRA_Header_Quick__Key_Did_FCRA_Vault_Invalid),COUNT(__d4)},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','SSN',COUNT(__d4(__NL(S_S_N_))),COUNT(__d4(__NN(S_S_N_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','OfficialFirstSeen',COUNT(__d4(__NL(Official_First_Seen_))),COUNT(__d4(__NN(Official_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','OfficialLastSeen',COUNT(__d4(__NL(Official_Last_Seen_))),COUNT(__d4(__NN(Official_Last_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','DateOfDeath',COUNT(__d4(__NL(Date_Of_Death_))),COUNT(__d4(__NN(Date_Of_Death_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','DeathMasterFlag',COUNT(__d4(__NL(Death_Master_Flag_))),COUNT(__d4(__NN(Death_Master_Flag_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','st',COUNT(__d4(__NL(Issue_State_))),COUNT(__d4(__NN(Issue_State_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','dt_first_seen',COUNT(__d4(__NL(Header_First_Seen_))),COUNT(__d4(__NN(Header_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','src',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','Archive_Date',COUNT(__d4(Archive___Date_=0)),COUNT(__d4(Archive___Date_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','HybridArchiveDate',COUNT(__d4(Hybrid_Archive_Date_=0)),COUNT(__d4(Hybrid_Archive_Date_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','VaultDateLastSeen',COUNT(__d4(Vault_Date_Last_Seen_=0)),COUNT(__d4(Vault_Date_Last_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault','UID',COUNT(PublicRecords_KEL_Files_FCRA_Death_Master__Key_ssn_ssa_Vault_Invalid),COUNT(__d5)},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault','SSN',COUNT(__d5(__NL(S_S_N_))),COUNT(__d5(__NN(S_S_N_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault','OfficialFirstSeen',COUNT(__d5(__NL(Official_First_Seen_))),COUNT(__d5(__NN(Official_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault','OfficialLastSeen',COUNT(__d5(__NL(Official_Last_Seen_))),COUNT(__d5(__NN(Official_Last_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault','dod8',COUNT(__d5(__NL(Date_Of_Death_))),COUNT(__d5(__NN(Date_Of_Death_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault','state',COUNT(__d5(__NL(Issue_State_))),COUNT(__d5(__NN(Issue_State_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault','HeaderFirstSeen',COUNT(__d5(__NL(Header_First_Seen_))),COUNT(__d5(__NN(Header_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault','src',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault','Archive_Date',COUNT(__d5(Archive___Date_=0)),COUNT(__d5(Archive___Date_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault','HybridArchiveDate',COUNT(__d5(Hybrid_Archive_Date_=0)),COUNT(__d5(Hybrid_Archive_Date_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault','VaultDateLastSeen',COUNT(__d5(Vault_Date_Last_Seen_=0)),COUNT(__d5(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
