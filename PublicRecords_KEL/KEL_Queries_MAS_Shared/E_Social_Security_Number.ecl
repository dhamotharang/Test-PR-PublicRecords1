//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Shared;
IMPORT * FROM KEL16.Null;
EXPORT E_Social_Security_Number(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
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
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping0 := 'ssn(OVERRIDE:UID|DEFAULT:S_S_N_:\'\'),officialfirstseen(DEFAULT:Official_First_Seen_:DATE),officiallastseen(DEFAULT:Official_Last_Seen_:DATE),dod(OVERRIDE:Date_Of_Death_:DATE),deathmasterflag(DEFAULT:Death_Master_Flag_),st(OVERRIDE:Issue_State_:\'\'),dt_first_seen(OVERRIDE:Header_First_Seen_:DATE|OVERRIDE:Date_First_Seen_:EPOCH),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Header,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Header),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((UNSIGNED)ssn != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid := __d0_KELfiltered((KEL.typ.uid)ssn = 0);
  SHARED __d0_Prefiltered := __d0_KELfiltered((KEL.typ.uid)ssn <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping1 := 'ssn(OVERRIDE:UID|DEFAULT:S_S_N_:\'\'),officialfirstseen(DEFAULT:Official_First_Seen_:DATE),officiallastseen(DEFAULT:Official_Last_Seen_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),deathmasterflag(DEFAULT:Death_Master_Flag_),st(OVERRIDE:Issue_State_:\'\'),dt_first_seen(OVERRIDE:Header_First_Seen_:DATE|OVERRIDE:Date_First_Seen_:EPOCH),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Header_Quick__Key_Did,TRANSFORM(RECORDOF(__in.Dataset_Header_Quick__Key_Did),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((UNSIGNED)ssn != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid := __d1_KELfiltered((KEL.typ.uid)ssn = 0);
  SHARED __d1_Prefiltered := __d1_KELfiltered((KEL.typ.uid)ssn <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping2 := 'ssn(OVERRIDE:UID|DEFAULT:S_S_N_:\'\'),officialfirstseen(DEFAULT:Official_First_Seen_:DATE),officiallastseen(DEFAULT:Official_Last_Seen_:DATE),dod8(OVERRIDE:Date_Of_Death_:DATE),state(OVERRIDE:Issue_State_:\'\'),headerfirstseen(DEFAULT:Header_First_Seen_:DATE),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping2_Transform(InLayout __r) := TRANSFORM
    SELF.Death_Master_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_Death_MasterV2__key_ssn_ssa,TRANSFORM(RECORDOF(__in.Dataset_Death_MasterV2__key_ssn_ssa),SELF:=RIGHT));
  EXPORT __d2_KELfiltered := __d2_Norm((UNSIGNED)ssn != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Death_MasterV2__key_ssn_ssa_Invalid := __d2_KELfiltered((KEL.typ.uid)ssn = 0);
  SHARED __d2_Prefiltered := __d2_KELfiltered((KEL.typ.uid)ssn <> 0);
  SHARED __d2 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping2_Transform(LEFT)));
  EXPORT InData := __d0 + __d1 + __d2;
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
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Death_MasterV2__key_ssn_ssa_Invalid),COUNT(S_S_N__SingleValue_Invalid),COUNT(Official_First_Seen__SingleValue_Invalid),COUNT(Official_Last_Seen__SingleValue_Invalid),COUNT(Issue_State__SingleValue_Invalid),COUNT(Header_First_Seen__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Death_MasterV2__key_ssn_ssa_Invalid,KEL.typ.int S_S_N__SingleValue_Invalid,KEL.typ.int Official_First_Seen__SingleValue_Invalid,KEL.typ.int Official_Last_Seen__SingleValue_Invalid,KEL.typ.int Issue_State__SingleValue_Invalid,KEL.typ.int Header_First_Seen__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid),COUNT(__d0)},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SSN',COUNT(__d0(__NL(S_S_N_))),COUNT(__d0(__NN(S_S_N_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OfficialFirstSeen',COUNT(__d0(__NL(Official_First_Seen_))),COUNT(__d0(__NN(Official_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OfficialLastSeen',COUNT(__d0(__NL(Official_Last_Seen_))),COUNT(__d0(__NN(Official_Last_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dod',COUNT(__d0(__NL(Date_Of_Death_))),COUNT(__d0(__NN(Date_Of_Death_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeathMasterFlag',COUNT(__d0(__NL(Death_Master_Flag_))),COUNT(__d0(__NN(Death_Master_Flag_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d0(__NL(Issue_State_))),COUNT(__d0(__NN(Issue_State_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_first_seen',COUNT(__d0(__NL(Header_First_Seen_))),COUNT(__d0(__NN(Header_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid),COUNT(__d1)},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SSN',COUNT(__d1(__NL(S_S_N_))),COUNT(__d1(__NN(S_S_N_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OfficialFirstSeen',COUNT(__d1(__NL(Official_First_Seen_))),COUNT(__d1(__NN(Official_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OfficialLastSeen',COUNT(__d1(__NL(Official_Last_Seen_))),COUNT(__d1(__NN(Official_Last_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDeath',COUNT(__d1(__NL(Date_Of_Death_))),COUNT(__d1(__NN(Date_Of_Death_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeathMasterFlag',COUNT(__d1(__NL(Death_Master_Flag_))),COUNT(__d1(__NN(Death_Master_Flag_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d1(__NL(Issue_State_))),COUNT(__d1(__NN(Issue_State_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_first_seen',COUNT(__d1(__NL(Header_First_Seen_))),COUNT(__d1(__NN(Header_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Death_MasterV2__key_ssn_ssa_Invalid),COUNT(__d2)},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SSN',COUNT(__d2(__NL(S_S_N_))),COUNT(__d2(__NN(S_S_N_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OfficialFirstSeen',COUNT(__d2(__NL(Official_First_Seen_))),COUNT(__d2(__NN(Official_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OfficialLastSeen',COUNT(__d2(__NL(Official_Last_Seen_))),COUNT(__d2(__NN(Official_Last_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dod8',COUNT(__d2(__NL(Date_Of_Death_))),COUNT(__d2(__NN(Date_Of_Death_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','state',COUNT(__d2(__NL(Issue_State_))),COUNT(__d2(__NN(Issue_State_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderFirstSeen',COUNT(__d2(__NL(Header_First_Seen_))),COUNT(__d2(__NN(Header_First_Seen_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'SocialSecurityNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
