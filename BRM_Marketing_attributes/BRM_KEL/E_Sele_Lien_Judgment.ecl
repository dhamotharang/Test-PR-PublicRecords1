//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Lien_Judgment FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL16.Null;
EXPORT E_Sele_Lien_Judgment(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.nstr Debtors_Full_Name_;
    KEL.typ.nstr Debtor_Plaintiff_;
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
  SHARED __Mapping := 'Sele_(DEFAULT:Sele_:0),Lien_(DEFAULT:Lien_:0),ultid(DEFAULT:Ult_I_D_:0),orgid(DEFAULT:Org_I_D_:0),seleid(DEFAULT:Sele_I_D_:0),tmsid(DEFAULT:T_M_S_I_D_:\'\'),rmsid(DEFAULT:R_M_S_I_D_:\'\'),debtorsfullname(DEFAULT:Debtors_Full_Name_:\'\'),debtorplaintiff(DEFAULT:Debtor_Plaintiff_:\'\'),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'Sele_(DEFAULT:Sele_:0),Lien_(DEFAULT:Lien_:0),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),tmsid(OVERRIDE:T_M_S_I_D_:\'\'),rmsid(OVERRIDE:R_M_S_I_D_:\'\'),orig_full_debtorname(OVERRIDE:Debtors_Full_Name_:\'\'),name_type(OVERRIDE:Debtor_Plaintiff_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_LiensV2__Key_party_Linkids_Records,TRANSFORM(RECORDOF(__in.Dataset_LiensV2__Key_party_Linkids_Records),SELF:=RIGHT));
  SHARED __d0_Sele__Layout := RECORD
    RECORDOF(__d0_Norm);
    KEL.typ.uid Sele_;
  END;
  SHARED __d0_Missing_Sele__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Norm,'ultid,orgid,seleid','__in');
  SHARED __d0_Sele__Mapped := IF(__d0_Missing_Sele__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d0_Norm,TRANSFORM(__d0_Sele__Layout,SELF.Sele_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Norm,__d0_Missing_Sele__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d0_Sele__Layout,SELF.Sele_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Lien__Layout := RECORD
    RECORDOF(__d0_Sele__Mapped);
    KEL.typ.uid Lien_;
  END;
  SHARED __d0_Missing_Lien__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Sele__Mapped,'tmsid,rmsid','__in');
  SHARED __d0_Lien__Mapped := IF(__d0_Missing_Lien__UIDComponents = 'tmsid,rmsid',PROJECT(__d0_Sele__Mapped,TRANSFORM(__d0_Lien__Layout,SELF.Lien_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Sele__Mapped,__d0_Missing_Lien__UIDComponents),E_Lien_Judgment(__in,__cfg).Lookup,TRIM((STRING)LEFT.tmsid) + '|' + TRIM((STRING)LEFT.rmsid) = RIGHT.KeyVal,TRANSFORM(__d0_Lien__Layout,SELF.Lien_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Prefiltered := __d0_Lien__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0;
  EXPORT Details_Layout := RECORD
    KEL.typ.nstr Debtor_Plaintiff_;
    KEL.typ.nstr Debtors_Full_Name_;
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
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(Details_Layout) Details_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Sele_,Lien_,Ult_I_D_,Org_I_D_,Sele_I_D_,T_M_S_I_D_,R_M_S_I_D_,ALL));
  Sele_Lien_Judgment_Group := __PostFilter;
  Layout Sele_Lien_Judgment__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Details_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Debtor_Plaintiff_,Debtors_Full_Name_},Debtor_Plaintiff_,Debtors_Full_Name_),Details_Layout)(__NN(Debtor_Plaintiff_) OR __NN(Debtors_Full_Name_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Sele_Lien_Judgment__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Details_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Details_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Debtor_Plaintiff_) OR __NN(Debtors_Full_Name_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
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
    {'SeleLienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d0(__NL(Ult_I_D_))),COUNT(__d0(__NN(Ult_I_D_)))},
    {'SeleLienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d0(__NL(Org_I_D_))),COUNT(__d0(__NN(Org_I_D_)))},
    {'SeleLienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d0(__NL(Sele_I_D_))),COUNT(__d0(__NN(Sele_I_D_)))},
    {'SeleLienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tmsid',COUNT(__d0(__NL(T_M_S_I_D_))),COUNT(__d0(__NN(T_M_S_I_D_)))},
    {'SeleLienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rmsid',COUNT(__d0(__NL(R_M_S_I_D_))),COUNT(__d0(__NN(R_M_S_I_D_)))},
    {'SeleLienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_full_debtorname',COUNT(__d0(__NL(Debtors_Full_Name_))),COUNT(__d0(__NN(Debtors_Full_Name_)))},
    {'SeleLienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_type',COUNT(__d0(__NL(Debtor_Plaintiff_))),COUNT(__d0(__NN(Debtor_Plaintiff_)))},
    {'SeleLienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'SeleLienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'SeleLienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'SeleLienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'SeleLienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'SeleLienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
