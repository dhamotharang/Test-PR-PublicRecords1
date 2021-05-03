//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_U_C_C FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT E_Sele_U_C_C(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.nstr Party_Type_;
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
  SHARED __Mapping := 'Legal_(DEFAULT:Legal_:0),Filing_(DEFAULT:Filing_:0),ultid(DEFAULT:Ult_I_D_:0),orgid(DEFAULT:Org_I_D_:0),seleid(DEFAULT:Sele_I_D_:0),tmsid(DEFAULT:T_M_S_I_D_:\'\'),rmsid(DEFAULT:R_M_S_I_D_:\'\'),partytype(DEFAULT:Party_Type_:\'\'),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping0 := 'Legal_(DEFAULT:Legal_:0),Filing_(DEFAULT:Filing_:0),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),tmsid(OVERRIDE:T_M_S_I_D_:\'\'),rmsid(OVERRIDE:R_M_S_I_D_:\'\'),party_type(OVERRIDE:Party_Type_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_UCC__Key_LinkIds_key,TRANSFORM(RECORDOF(__in.Dataset_UCC__Key_LinkIds_key),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((UNSIGNED)ultid<>0 AND (UNSIGNED)orgid<>0 AND (UNSIGNED)seleid<>0);
  SHARED __d0_Legal__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d0_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d0_Legal__Mapped := IF(__d0_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d0_KELfiltered,TRANSFORM(__d0_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_KELfiltered,__d0_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d0_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Filing__Layout := RECORD
    RECORDOF(__d0_Legal__Mapped);
    KEL.typ.uid Filing_;
  END;
  SHARED __d0_Missing_Filing__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Legal__Mapped,'tmsid','__in');
  SHARED __d0_Filing__Mapped := IF(__d0_Missing_Filing__UIDComponents = 'tmsid',PROJECT(__d0_Legal__Mapped,TRANSFORM(__d0_Filing__Layout,SELF.Filing_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Legal__Mapped,__d0_Missing_Filing__UIDComponents),E_U_C_C(__in,__cfg).Lookup,TRIM((STRING)LEFT.tmsid) = RIGHT.KeyVal,TRANSFORM(__d0_Filing__Layout,SELF.Filing_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Prefiltered := __d0_Filing__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping1 := 'Legal_(DEFAULT:Legal_:0),Filing_(DEFAULT:Filing_:0),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),tmsid(OVERRIDE:T_M_S_I_D_:\'\'),rmsid(OVERRIDE:R_M_S_I_D_:\'\'),party_type(OVERRIDE:Party_Type_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_UCC__Key_RMSID_Party,TRANSFORM(RECORDOF(__in.Dataset_UCC__Key_RMSID_Party),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((UNSIGNED)ultid<>0 AND (UNSIGNED)orgid<>0 AND (UNSIGNED)seleid<>0);
  SHARED __d1_Legal__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d1_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d1_Legal__Mapped := IF(__d1_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d1_KELfiltered,TRANSFORM(__d1_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_KELfiltered,__d1_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d1_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d1_Filing__Layout := RECORD
    RECORDOF(__d1_Legal__Mapped);
    KEL.typ.uid Filing_;
  END;
  SHARED __d1_Missing_Filing__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_Legal__Mapped,'tmsid','__in');
  SHARED __d1_Filing__Mapped := IF(__d1_Missing_Filing__UIDComponents = 'tmsid',PROJECT(__d1_Legal__Mapped,TRANSFORM(__d1_Filing__Layout,SELF.Filing_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_Legal__Mapped,__d1_Missing_Filing__UIDComponents),E_U_C_C(__in,__cfg).Lookup,TRIM((STRING)LEFT.tmsid) = RIGHT.KeyVal,TRANSFORM(__d1_Filing__Layout,SELF.Filing_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d1_Prefiltered := __d1_Filing__Mapped;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1;
  EXPORT Sub_Filing_Layout := RECORD
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.nstr Party_Type_;
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
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(Sub_Filing_Layout) Sub_Filing_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Legal_,T_M_S_I_D_,Filing_,Ult_I_D_,Org_I_D_,Sele_I_D_,ALL));
  Sele_U_C_C_Group := __PostFilter;
  Layout Sele_U_C_C__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Sub_Filing_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),R_M_S_I_D_,Party_Type_},R_M_S_I_D_,Party_Type_),Sub_Filing_Layout)(__NN(R_M_S_I_D_) OR __NN(Party_Type_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Sele_U_C_C__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Sub_Filing_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Sub_Filing_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(R_M_S_I_D_) OR __NN(Party_Type_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Sele_U_C_C_Group,COUNT(ROWS(LEFT))=1),GROUP,Sele_U_C_C__Single_Rollup(LEFT)) + ROLLUP(HAVING(Sele_U_C_C_Group,COUNT(ROWS(LEFT))>1),GROUP,Sele_U_C_C__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Legal__Orphan := JOIN(InData(__NN(Legal_)),E_Business_Sele(__in,__cfg).__Result,__EEQP(LEFT.Legal_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Filing__Orphan := JOIN(InData(__NN(Filing_)),E_U_C_C(__in,__cfg).__Result,__EEQP(LEFT.Filing_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Legal__Orphan),COUNT(Filing__Orphan)}],{KEL.typ.int Legal__Orphan,KEL.typ.int Filing__Orphan});
  EXPORT NullCounts := DATASET([
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d0(__NL(Legal_))),COUNT(__d0(__NN(Legal_)))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Filing',COUNT(__d0(__NL(Filing_))),COUNT(__d0(__NN(Filing_)))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d0(__NL(Ult_I_D_))),COUNT(__d0(__NN(Ult_I_D_)))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d0(__NL(Org_I_D_))),COUNT(__d0(__NN(Org_I_D_)))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d0(__NL(Sele_I_D_))),COUNT(__d0(__NN(Sele_I_D_)))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tmsid',COUNT(__d0(__NL(T_M_S_I_D_))),COUNT(__d0(__NN(T_M_S_I_D_)))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rmsid',COUNT(__d0(__NL(R_M_S_I_D_))),COUNT(__d0(__NN(R_M_S_I_D_)))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','party_type',COUNT(__d0(__NL(Party_Type_))),COUNT(__d0(__NN(Party_Type_)))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d1(__NL(Legal_))),COUNT(__d1(__NN(Legal_)))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Filing',COUNT(__d1(__NL(Filing_))),COUNT(__d1(__NN(Filing_)))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d1(__NL(Ult_I_D_))),COUNT(__d1(__NN(Ult_I_D_)))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d1(__NL(Org_I_D_))),COUNT(__d1(__NN(Org_I_D_)))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d1(__NL(Sele_I_D_))),COUNT(__d1(__NN(Sele_I_D_)))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tmsid',COUNT(__d1(__NL(T_M_S_I_D_))),COUNT(__d1(__NN(T_M_S_I_D_)))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rmsid',COUNT(__d1(__NL(R_M_S_I_D_))),COUNT(__d1(__NN(R_M_S_I_D_)))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','party_type',COUNT(__d1(__NL(Party_Type_))),COUNT(__d1(__NN(Party_Type_)))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'SeleUCC','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
