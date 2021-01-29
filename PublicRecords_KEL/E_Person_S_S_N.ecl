//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Person,E_Social_Security_Number FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_Person_S_S_N(CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool F_D_N_Indicator_;
    KEL.typ.nbool Death_Master_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.nstr Valid_S_S_N_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    DATA57 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'subject(DEFAULT:Subject_:0),social(DEFAULT:Social_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),source(DEFAULT:Source_:\'\'),validssn(DEFAULT:Valid_S_S_N_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'did(OVERRIDE:Subject_:0),ssn(OVERRIDE:Social_:0),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),valid_ssn(OVERRIDE:Valid_S_S_N_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_0Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d0_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault((UNSIGNED)did != 0 AND (UNSIGNED)ssn != 0);
  SHARED __d0_Prefiltered := __d0_KELfiltered;
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault'),__Mapping0_Transform(LEFT)));
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'did(OVERRIDE:Subject_:0),ssn(OVERRIDE:Social_:0),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),validssn(DEFAULT:Valid_S_S_N_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_1Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d1_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault((UNSIGNED)ssn != 0 AND (UNSIGNED)did != 0);
  SHARED __d1_Prefiltered := __d1_KELfiltered;
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault'),__Mapping1_Transform(LEFT)));
  SHARED __Mapping2 := 'did(OVERRIDE:Subject_:0),ssn(OVERRIDE:Social_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),fdnindicator(DEFAULT:F_D_N_Indicator_),src(OVERRIDE:Source_:\'\'),validssn(DEFAULT:Valid_S_S_N_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping2_Transform(InLayout __r) := TRANSFORM
    SELF.Death_Master_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d2_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault((UNSIGNED)did != 0 AND (UNSIGNED)ssn != 0);
  SHARED __d2_Prefiltered := __d2_KELfiltered;
  SHARED __d2 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault'),__Mapping2_Transform(LEFT)));
  SHARED __Mapping3 := 'did(OVERRIDE:Subject_:0),ssn(OVERRIDE:Social_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),fdnindicator(DEFAULT:F_D_N_Indicator_),src(OVERRIDE:Source_:\'\'),validssn(DEFAULT:Valid_S_S_N_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping3_Transform(InLayout __r) := TRANSFORM
    SELF.Death_Master_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d3_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault((UNSIGNED)did != 0 AND (UNSIGNED)ssn != 0);
  SHARED __d3_Prefiltered := __d3_KELfiltered;
  SHARED __d3 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault'),__Mapping3_Transform(LEFT)));
  SHARED Date_Last_Seen_4Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_4Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping4 := 'did(OVERRIDE:Subject_:0),ssn(OVERRIDE:Social_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),source_code(OVERRIDE:Source_:\'\'),validssn(DEFAULT:Valid_S_S_N_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_4Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_4Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d4_KELfiltered := PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault((UNSIGNED6)did > 0);
  SHARED __d4_Prefiltered := __d4_KELfiltered;
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault'));
  SHARED __Mapping5 := 'appended_lexid(OVERRIDE:Subject_:0),ssn(OVERRIDE:Social_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),validssn(DEFAULT:Valid_S_S_N_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping5_Transform(InLayout __r) := TRANSFORM
    SELF.F_D_N_Indicator_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d5_KELfiltered := PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_SSN_Vault((unsigned)appended_lexid!=0 AND (unsigned) ssn != 0);
  SHARED __d5_Prefiltered := __d5_KELfiltered;
  SHARED __d5 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_SSN_Vault'),__Mapping5_Transform(LEFT)));
  SHARED __Mapping6 := 'appended_lexid(OVERRIDE:Subject_:0),ssn(OVERRIDE:Social_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),validssn(DEFAULT:Valid_S_S_N_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping6_Transform(InLayout __r) := TRANSFORM
    SELF.F_D_N_Indicator_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d6_KELfiltered := PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault((unsigned)appended_lexid!=0 AND (unsigned) ssn != 0);
  SHARED __d6_Prefiltered := __d6_KELfiltered;
  SHARED __d6 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6,'PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault'),__Mapping6_Transform(LEFT)));
  SHARED __Mapping7 := 'did(OVERRIDE:Subject_:0),ssn(OVERRIDE:Social_:0),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),validssn(DEFAULT:Valid_S_S_N_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping7_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(FALSE);
    SELF := __r;
  END;
  EXPORT __d7_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault((UNSIGNED)did != 0 AND (UNSIGNED)ssn != 0);
  SHARED __d7_Prefiltered := __d7_KELfiltered;
  SHARED __d7 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d7_Prefiltered,InLayout,__Mapping7,'PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault'),__Mapping7_Transform(LEFT)));
  SHARED Date_Last_Seen_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping8 := 'did(OVERRIDE:Subject_:0),ssn(OVERRIDE:Social_:0),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),valid_ssn(OVERRIDE:Valid_S_S_N_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_8Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_8Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping8_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d8_KELfiltered := PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault((UNSIGNED)did != 0 AND (UNSIGNED)ssn != 0);
  SHARED __d8_Prefiltered := __d8_KELfiltered;
  SHARED __d8 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d8_Prefiltered,InLayout,__Mapping8,'PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault'),__Mapping8_Transform(LEFT)));
  SHARED Date_Last_Seen_9Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_9Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping9 := 'did(OVERRIDE:Subject_:0),ssn(OVERRIDE:Social_:0),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),validssn(DEFAULT:Valid_S_S_N_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_9Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_9Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping9_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d9_KELfiltered := PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault((UNSIGNED)ssn != 0 AND (UNSIGNED)did != 0);
  SHARED __d9_Prefiltered := __d9_KELfiltered;
  SHARED __d9 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d9_Prefiltered,InLayout,__Mapping9,'PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault'),__Mapping9_Transform(LEFT)));
  SHARED __Mapping10 := 'did(OVERRIDE:Subject_:0),ssn(OVERRIDE:Social_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),fdnindicator(DEFAULT:F_D_N_Indicator_),source(DEFAULT:Source_:\'\'),validssn(DEFAULT:Valid_S_S_N_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping10_Transform(InLayout __r) := TRANSFORM
    SELF.Death_Master_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d10_KELfiltered := PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault((UNSIGNED)did != 0 AND (UNSIGNED)ssn != 0);
  SHARED __d10_Prefiltered := __d10_KELfiltered;
  SHARED __d10 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d10_Prefiltered,InLayout,__Mapping10,'PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault'),__Mapping10_Transform(LEFT)));
  SHARED __Mapping11 := 'did(OVERRIDE:Subject_:0),ssn(OVERRIDE:Social_:0),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),validssn(DEFAULT:Valid_S_S_N_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping11_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(FALSE);
    SELF := __r;
  END;
  EXPORT __d11_KELfiltered := PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault((UNSIGNED)did != 0 AND (UNSIGNED)ssn != 0);
  SHARED __d11_Prefiltered := __d11_KELfiltered;
  SHARED __d11 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d11_Prefiltered,InLayout,__Mapping11,'PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault'),__Mapping11_Transform(LEFT)));
  SHARED __Mapping12 := 'did(OVERRIDE:Subject_:0),ssn(OVERRIDE:Social_:0),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),validssn(DEFAULT:Valid_S_S_N_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping12_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(FALSE);
    SELF := __r;
  END;
  EXPORT __d12_KELfiltered := PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault((UNSIGNED)did != 0 AND (UNSIGNED)ssn != 0);
  SHARED __d12_Prefiltered := __d12_KELfiltered;
  SHARED __d12 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d12_Prefiltered,InLayout,__Mapping12,'PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault'),__Mapping12_Transform(LEFT)));
  SHARED __Mapping13 := 'l_did(OVERRIDE:Subject_:0),ssn(OVERRIDE:Social_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),fdnindicator(DEFAULT:F_D_N_Indicator_),src(OVERRIDE:Source_:\'\'),validssn(DEFAULT:Valid_S_S_N_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping13_Transform(InLayout __r) := TRANSFORM
    SELF.Death_Master_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d13_KELfiltered := PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault((unsigned) ssn != 0 AND (unsigned) l_did != 0);
  SHARED __d13_Prefiltered := __d13_KELfiltered;
  SHARED __d13 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d13_Prefiltered,InLayout,__Mapping13,'PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault'),__Mapping13_Transform(LEFT)));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6 + __d7 + __d8 + __d9 + __d10 + __d11 + __d12 + __d13;
  EXPORT Valid_S_S_N_Layout := RECORD
    KEL.typ.nstr Valid_S_S_N_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool F_D_N_Indicator_;
    KEL.typ.nbool Death_Master_Flag_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ndataset(Valid_S_S_N_Layout) Valid_S_S_N_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Subject_,Social_,ALL));
  Person_S_S_N_Group := __PostFilter;
  Layout Person_S_S_N__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Valid_S_S_N_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Valid_S_S_N_},Valid_S_S_N_),Valid_S_S_N_Layout)(__NN(Valid_S_S_N_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_,Header_Hit_Flag_,F_D_N_Indicator_,Death_Master_Flag_},Source_,Header_Hit_Flag_,F_D_N_Indicator_,Death_Master_Flag_),Data_Sources_Layout)(__NN(Source_) OR __NN(Header_Hit_Flag_) OR __NN(F_D_N_Indicator_) OR __NN(Death_Master_Flag_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Person_S_S_N__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Valid_S_S_N_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Valid_S_S_N_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Valid_S_S_N_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_) OR __NN(Header_Hit_Flag_) OR __NN(F_D_N_Indicator_) OR __NN(Death_Master_Flag_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_S_S_N_Group,COUNT(ROWS(LEFT))=1),GROUP,Person_S_S_N__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_S_S_N_Group,COUNT(ROWS(LEFT))>1),GROUP,Person_S_S_N__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person(__cfg).__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Social__Orphan := JOIN(InData(__NN(Social_)),E_Social_Security_Number(__cfg).__Result,__EEQP(LEFT.Social_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Subject__Orphan),COUNT(Social__Orphan)}],{KEL.typ.int Subject__Orphan,KEL.typ.int Social__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','did',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','ssn',COUNT(__d0(__NL(Social_))),COUNT(__d0(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','FDNIndicator',COUNT(__d0(__NL(F_D_N_Indicator_))),COUNT(__d0(__NN(F_D_N_Indicator_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','DeathMasterFlag',COUNT(__d0(__NL(Death_Master_Flag_))),COUNT(__d0(__NN(Death_Master_Flag_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','valid_ssn',COUNT(__d0(__NL(Valid_S_S_N_))),COUNT(__d0(__NN(Valid_S_S_N_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','did',COUNT(__d1(__NL(Subject_))),COUNT(__d1(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','ssn',COUNT(__d1(__NL(Social_))),COUNT(__d1(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','FDNIndicator',COUNT(__d1(__NL(F_D_N_Indicator_))),COUNT(__d1(__NN(F_D_N_Indicator_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','DeathMasterFlag',COUNT(__d1(__NL(Death_Master_Flag_))),COUNT(__d1(__NN(Death_Master_Flag_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','ValidSSN',COUNT(__d1(__NL(Valid_S_S_N_))),COUNT(__d1(__NN(Valid_S_S_N_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault','did',COUNT(__d2(__NL(Subject_))),COUNT(__d2(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault','ssn',COUNT(__d2(__NL(Social_))),COUNT(__d2(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault','HeaderHitFlag',COUNT(__d2(__NL(Header_Hit_Flag_))),COUNT(__d2(__NN(Header_Hit_Flag_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault','FDNIndicator',COUNT(__d2(__NL(F_D_N_Indicator_))),COUNT(__d2(__NN(F_D_N_Indicator_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault','ValidSSN',COUNT(__d2(__NL(Valid_S_S_N_))),COUNT(__d2(__NN(Valid_S_S_N_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Death_Master__Key_ssn_ssa_Vault','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','did',COUNT(__d3(__NL(Subject_))),COUNT(__d3(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','ssn',COUNT(__d3(__NL(Social_))),COUNT(__d3(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','HeaderHitFlag',COUNT(__d3(__NL(Header_Hit_Flag_))),COUNT(__d3(__NN(Header_Hit_Flag_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','FDNIndicator',COUNT(__d3(__NL(F_D_N_Indicator_))),COUNT(__d3(__NN(F_D_N_Indicator_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','ValidSSN',COUNT(__d3(__NL(Valid_S_S_N_))),COUNT(__d3(__NN(Valid_S_S_N_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','HybridArchiveDate',COUNT(__d3(Hybrid_Archive_Date_=0)),COUNT(__d3(Hybrid_Archive_Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','VaultDateLastSeen',COUNT(__d3(Vault_Date_Last_Seen_=0)),COUNT(__d3(Vault_Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','did',COUNT(__d4(__NL(Subject_))),COUNT(__d4(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','ssn',COUNT(__d4(__NL(Social_))),COUNT(__d4(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','HeaderHitFlag',COUNT(__d4(__NL(Header_Hit_Flag_))),COUNT(__d4(__NN(Header_Hit_Flag_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','FDNIndicator',COUNT(__d4(__NL(F_D_N_Indicator_))),COUNT(__d4(__NN(F_D_N_Indicator_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','DeathMasterFlag',COUNT(__d4(__NL(Death_Master_Flag_))),COUNT(__d4(__NN(Death_Master_Flag_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','source_Code',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','ValidSSN',COUNT(__d4(__NL(Valid_S_S_N_))),COUNT(__d4(__NN(Valid_S_S_N_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','Archive_Date',COUNT(__d4(Archive___Date_=0)),COUNT(__d4(Archive___Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','HybridArchiveDate',COUNT(__d4(Hybrid_Archive_Date_=0)),COUNT(__d4(Hybrid_Archive_Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','VaultDateLastSeen',COUNT(__d4(Vault_Date_Last_Seen_=0)),COUNT(__d4(Vault_Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_SSN_Vault','appended_lexid',COUNT(__d5(__NL(Subject_))),COUNT(__d5(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_SSN_Vault','ssn',COUNT(__d5(__NL(Social_))),COUNT(__d5(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_SSN_Vault','HeaderHitFlag',COUNT(__d5(__NL(Header_Hit_Flag_))),COUNT(__d5(__NN(Header_Hit_Flag_)))},
    {'PersonSSN','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_SSN_Vault','DeathMasterFlag',COUNT(__d5(__NL(Death_Master_Flag_))),COUNT(__d5(__NN(Death_Master_Flag_)))},
    {'PersonSSN','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_SSN_Vault','Src',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_SSN_Vault','ValidSSN',COUNT(__d5(__NL(Valid_S_S_N_))),COUNT(__d5(__NN(Valid_S_S_N_)))},
    {'PersonSSN','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_SSN_Vault','Archive_Date',COUNT(__d5(Archive___Date_=0)),COUNT(__d5(Archive___Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_SSN_Vault','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_SSN_Vault','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_SSN_Vault','HybridArchiveDate',COUNT(__d5(Hybrid_Archive_Date_=0)),COUNT(__d5(Hybrid_Archive_Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_SSN_Vault','VaultDateLastSeen',COUNT(__d5(Vault_Date_Last_Seen_=0)),COUNT(__d5(Vault_Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','appended_lexid',COUNT(__d6(__NL(Subject_))),COUNT(__d6(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','ssn',COUNT(__d6(__NL(Social_))),COUNT(__d6(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','HeaderHitFlag',COUNT(__d6(__NL(Header_Hit_Flag_))),COUNT(__d6(__NN(Header_Hit_Flag_)))},
    {'PersonSSN','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','DeathMasterFlag',COUNT(__d6(__NL(Death_Master_Flag_))),COUNT(__d6(__NN(Death_Master_Flag_)))},
    {'PersonSSN','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','Src',COUNT(__d6(__NL(Source_))),COUNT(__d6(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','ValidSSN',COUNT(__d6(__NL(Valid_S_S_N_))),COUNT(__d6(__NN(Valid_S_S_N_)))},
    {'PersonSSN','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','Archive_Date',COUNT(__d6(Archive___Date_=0)),COUNT(__d6(Archive___Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','HybridArchiveDate',COUNT(__d6(Hybrid_Archive_Date_=0)),COUNT(__d6(Hybrid_Archive_Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','VaultDateLastSeen',COUNT(__d6(Vault_Date_Last_Seen_=0)),COUNT(__d6(Vault_Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','did',COUNT(__d7(__NL(Subject_))),COUNT(__d7(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','ssn',COUNT(__d7(__NL(Social_))),COUNT(__d7(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','FDNIndicator',COUNT(__d7(__NL(F_D_N_Indicator_))),COUNT(__d7(__NN(F_D_N_Indicator_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','DeathMasterFlag',COUNT(__d7(__NL(Death_Master_Flag_))),COUNT(__d7(__NN(Death_Master_Flag_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','src',COUNT(__d7(__NL(Source_))),COUNT(__d7(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','ValidSSN',COUNT(__d7(__NL(Valid_S_S_N_))),COUNT(__d7(__NN(Valid_S_S_N_)))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','Archive_Date',COUNT(__d7(Archive___Date_=0)),COUNT(__d7(Archive___Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','DateFirstSeen',COUNT(__d7(Date_First_Seen_=0)),COUNT(__d7(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','DateLastSeen',COUNT(__d7(Date_Last_Seen_=0)),COUNT(__d7(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','HybridArchiveDate',COUNT(__d7(Hybrid_Archive_Date_=0)),COUNT(__d7(Hybrid_Archive_Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','VaultDateLastSeen',COUNT(__d7(Vault_Date_Last_Seen_=0)),COUNT(__d7(Vault_Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','did',COUNT(__d8(__NL(Subject_))),COUNT(__d8(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','ssn',COUNT(__d8(__NL(Social_))),COUNT(__d8(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','FDNIndicator',COUNT(__d8(__NL(F_D_N_Indicator_))),COUNT(__d8(__NN(F_D_N_Indicator_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','DeathMasterFlag',COUNT(__d8(__NL(Death_Master_Flag_))),COUNT(__d8(__NN(Death_Master_Flag_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','src',COUNT(__d8(__NL(Source_))),COUNT(__d8(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','valid_ssn',COUNT(__d8(__NL(Valid_S_S_N_))),COUNT(__d8(__NN(Valid_S_S_N_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','Archive_Date',COUNT(__d8(Archive___Date_=0)),COUNT(__d8(Archive___Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','DateFirstSeen',COUNT(__d8(Date_First_Seen_=0)),COUNT(__d8(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','DateLastSeen',COUNT(__d8(Date_Last_Seen_=0)),COUNT(__d8(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','HybridArchiveDate',COUNT(__d8(Hybrid_Archive_Date_=0)),COUNT(__d8(Hybrid_Archive_Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','VaultDateLastSeen',COUNT(__d8(Vault_Date_Last_Seen_=0)),COUNT(__d8(Vault_Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','did',COUNT(__d9(__NL(Subject_))),COUNT(__d9(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','ssn',COUNT(__d9(__NL(Social_))),COUNT(__d9(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','FDNIndicator',COUNT(__d9(__NL(F_D_N_Indicator_))),COUNT(__d9(__NN(F_D_N_Indicator_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','DeathMasterFlag',COUNT(__d9(__NL(Death_Master_Flag_))),COUNT(__d9(__NN(Death_Master_Flag_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','src',COUNT(__d9(__NL(Source_))),COUNT(__d9(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','ValidSSN',COUNT(__d9(__NL(Valid_S_S_N_))),COUNT(__d9(__NN(Valid_S_S_N_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','Archive_Date',COUNT(__d9(Archive___Date_=0)),COUNT(__d9(Archive___Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','DateFirstSeen',COUNT(__d9(Date_First_Seen_=0)),COUNT(__d9(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','DateLastSeen',COUNT(__d9(Date_Last_Seen_=0)),COUNT(__d9(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','HybridArchiveDate',COUNT(__d9(Hybrid_Archive_Date_=0)),COUNT(__d9(Hybrid_Archive_Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','VaultDateLastSeen',COUNT(__d9(Vault_Date_Last_Seen_=0)),COUNT(__d9(Vault_Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault','did',COUNT(__d10(__NL(Subject_))),COUNT(__d10(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault','ssn',COUNT(__d10(__NL(Social_))),COUNT(__d10(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault','HeaderHitFlag',COUNT(__d10(__NL(Header_Hit_Flag_))),COUNT(__d10(__NN(Header_Hit_Flag_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault','FDNIndicator',COUNT(__d10(__NL(F_D_N_Indicator_))),COUNT(__d10(__NN(F_D_N_Indicator_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault','Source',COUNT(__d10(__NL(Source_))),COUNT(__d10(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault','ValidSSN',COUNT(__d10(__NL(Valid_S_S_N_))),COUNT(__d10(__NN(Valid_S_S_N_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault','Archive_Date',COUNT(__d10(Archive___Date_=0)),COUNT(__d10(Archive___Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault','DateFirstSeen',COUNT(__d10(Date_First_Seen_=0)),COUNT(__d10(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault','DateLastSeen',COUNT(__d10(Date_Last_Seen_=0)),COUNT(__d10(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault','HybridArchiveDate',COUNT(__d10(Hybrid_Archive_Date_=0)),COUNT(__d10(Hybrid_Archive_Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Death_Master__Key_ssn_ssa_Vault','VaultDateLastSeen',COUNT(__d10(Vault_Date_Last_Seen_=0)),COUNT(__d10(Vault_Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','did',COUNT(__d11(__NL(Subject_))),COUNT(__d11(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','ssn',COUNT(__d11(__NL(Social_))),COUNT(__d11(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','FDNIndicator',COUNT(__d11(__NL(F_D_N_Indicator_))),COUNT(__d11(__NN(F_D_N_Indicator_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','DeathMasterFlag',COUNT(__d11(__NL(Death_Master_Flag_))),COUNT(__d11(__NN(Death_Master_Flag_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','src',COUNT(__d11(__NL(Source_))),COUNT(__d11(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','ValidSSN',COUNT(__d11(__NL(Valid_S_S_N_))),COUNT(__d11(__NN(Valid_S_S_N_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','Archive_Date',COUNT(__d11(Archive___Date_=0)),COUNT(__d11(Archive___Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','DateFirstSeen',COUNT(__d11(Date_First_Seen_=0)),COUNT(__d11(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','DateLastSeen',COUNT(__d11(Date_Last_Seen_=0)),COUNT(__d11(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','HybridArchiveDate',COUNT(__d11(Hybrid_Archive_Date_=0)),COUNT(__d11(Hybrid_Archive_Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','VaultDateLastSeen',COUNT(__d11(Vault_Date_Last_Seen_=0)),COUNT(__d11(Vault_Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','did',COUNT(__d12(__NL(Subject_))),COUNT(__d12(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','ssn',COUNT(__d12(__NL(Social_))),COUNT(__d12(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','FDNIndicator',COUNT(__d12(__NL(F_D_N_Indicator_))),COUNT(__d12(__NN(F_D_N_Indicator_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','DeathMasterFlag',COUNT(__d12(__NL(Death_Master_Flag_))),COUNT(__d12(__NN(Death_Master_Flag_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','src',COUNT(__d12(__NL(Source_))),COUNT(__d12(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','ValidSSN',COUNT(__d12(__NL(Valid_S_S_N_))),COUNT(__d12(__NN(Valid_S_S_N_)))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','Archive_Date',COUNT(__d12(Archive___Date_=0)),COUNT(__d12(Archive___Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','DateFirstSeen',COUNT(__d12(Date_First_Seen_=0)),COUNT(__d12(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','DateLastSeen',COUNT(__d12(Date_Last_Seen_=0)),COUNT(__d12(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','HybridArchiveDate',COUNT(__d12(Hybrid_Archive_Date_=0)),COUNT(__d12(Hybrid_Archive_Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','VaultDateLastSeen',COUNT(__d12(Vault_Date_Last_Seen_=0)),COUNT(__d12(Vault_Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','l_did',COUNT(__d13(__NL(Subject_))),COUNT(__d13(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','ssn',COUNT(__d13(__NL(Social_))),COUNT(__d13(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','HeaderHitFlag',COUNT(__d13(__NL(Header_Hit_Flag_))),COUNT(__d13(__NN(Header_Hit_Flag_)))},
    {'PersonSSN','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','FDNIndicator',COUNT(__d13(__NL(F_D_N_Indicator_))),COUNT(__d13(__NN(F_D_N_Indicator_)))},
    {'PersonSSN','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','src',COUNT(__d13(__NL(Source_))),COUNT(__d13(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','ValidSSN',COUNT(__d13(__NL(Valid_S_S_N_))),COUNT(__d13(__NN(Valid_S_S_N_)))},
    {'PersonSSN','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','Archive_Date',COUNT(__d13(Archive___Date_=0)),COUNT(__d13(Archive___Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','DateFirstSeen',COUNT(__d13(Date_First_Seen_=0)),COUNT(__d13(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','DateLastSeen',COUNT(__d13(Date_Last_Seen_=0)),COUNT(__d13(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','HybridArchiveDate',COUNT(__d13(Hybrid_Archive_Date_=0)),COUNT(__d13(Hybrid_Archive_Date_!=0))},
    {'PersonSSN','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','VaultDateLastSeen',COUNT(__d13(Vault_Date_Last_Seen_=0)),COUNT(__d13(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
