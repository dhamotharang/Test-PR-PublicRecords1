//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Prox,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_T_I_N FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT E_Prox_T_I_N(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Business_Prox().Typ) Business_Location_;
    KEL.typ.ntyp(E_T_I_N().Typ) Tax_I_D_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nint Prox_I_D_;
    KEL.typ.nint Best_T_I_N_;
    KEL.typ.nint Best_T_I_N_Rank_;
    KEL.typ.nbool Header_Hit_Flag_;
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
  SHARED __Mapping := 'Business_Location_(DEFAULT:Business_Location_:0),taxid(DEFAULT:Tax_I_D_:0),ultid(DEFAULT:Ult_I_D_:0),orgid(DEFAULT:Org_I_D_:0),seleid(DEFAULT:Sele_I_D_:0),proxid(DEFAULT:Prox_I_D_:0),besttin(DEFAULT:Best_T_I_N_:0),besttinrank(DEFAULT:Best_T_I_N_Rank_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'Business_Location_(DEFAULT:Business_Location_:0),company_fein(OVERRIDE:Tax_I_D_:0|OVERRIDE:Best_T_I_N_:0),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),proxid(OVERRIDE:Prox_I_D_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Best_T_I_N_Rank_ := __CN(1);
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2_Best__Key_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_BIPV2_Best__Key_LinkIds),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm(proxid != 0 AND seleid != 0 AND company_fein <> '');
  SHARED __d0_Business_Location__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Business_Location_;
  END;
  SHARED __d0_Missing_Business_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_KELfiltered,'ultid,orgid,seleid,proxid','__in');
  SHARED __d0_Business_Location__Mapped := IF(__d0_Missing_Business_Location__UIDComponents = 'ultid,orgid,seleid,proxid',PROJECT(__d0_KELfiltered,TRANSFORM(__d0_Business_Location__Layout,SELF.Business_Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_KELfiltered,__d0_Missing_Business_Location__UIDComponents),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d0_Business_Location__Layout,SELF.Business_Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Prefiltered := __d0_Business_Location__Mapped;
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping0_Transform(LEFT)));
  EXPORT InData := __d0;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Business_Prox().Typ) Business_Location_;
    KEL.typ.ntyp(E_T_I_N().Typ) Tax_I_D_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nint Prox_I_D_;
    KEL.typ.nint Best_T_I_N_;
    KEL.typ.nint Best_T_I_N_Rank_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Business_Location_,Tax_I_D_,Ult_I_D_,Org_I_D_,Sele_I_D_,Prox_I_D_,Best_T_I_N_,Best_T_I_N_Rank_,ALL));
  Prox_T_I_N_Group := __PostFilter;
  Layout Prox_T_I_N__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Header_Hit_Flag_,Source_},Header_Hit_Flag_,Source_),Data_Sources_Layout)(__NN(Header_Hit_Flag_) OR __NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Prox_T_I_N__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Header_Hit_Flag_) OR __NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Prox_T_I_N_Group,COUNT(ROWS(LEFT))=1),GROUP,Prox_T_I_N__Single_Rollup(LEFT)) + ROLLUP(HAVING(Prox_T_I_N_Group,COUNT(ROWS(LEFT))>1),GROUP,Prox_T_I_N__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Business_Location__Orphan := JOIN(InData(__NN(Business_Location_)),E_Business_Prox(__in,__cfg).__Result,__EEQP(LEFT.Business_Location_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Tax_I_D__Orphan := JOIN(InData(__NN(Tax_I_D_)),E_T_I_N(__in,__cfg).__Result,__EEQP(LEFT.Tax_I_D_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Business_Location__Orphan),COUNT(Tax_I_D__Orphan)}],{KEL.typ.int Business_Location__Orphan,KEL.typ.int Tax_I_D__Orphan});
  EXPORT NullCounts := DATASET([
    {'ProxTIN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessLocation',COUNT(__d0(__NL(Business_Location_))),COUNT(__d0(__NN(Business_Location_)))},
    {'ProxTIN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_fein',COUNT(__d0(__NL(Tax_I_D_))),COUNT(__d0(__NN(Tax_I_D_)))},
    {'ProxTIN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d0(__NL(Ult_I_D_))),COUNT(__d0(__NN(Ult_I_D_)))},
    {'ProxTIN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d0(__NL(Org_I_D_))),COUNT(__d0(__NN(Org_I_D_)))},
    {'ProxTIN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d0(__NL(Sele_I_D_))),COUNT(__d0(__NN(Sele_I_D_)))},
    {'ProxTIN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','proxid',COUNT(__d0(__NL(Prox_I_D_))),COUNT(__d0(__NN(Prox_I_D_)))},
    {'ProxTIN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_fein',COUNT(__d0(__NL(Best_T_I_N_))),COUNT(__d0(__NN(Best_T_I_N_)))},
    {'ProxTIN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d0(__NL(Header_Hit_Flag_))),COUNT(__d0(__NN(Header_Hit_Flag_)))},
    {'ProxTIN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'ProxTIN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'ProxTIN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'ProxTIN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'ProxTIN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'ProxTIN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
