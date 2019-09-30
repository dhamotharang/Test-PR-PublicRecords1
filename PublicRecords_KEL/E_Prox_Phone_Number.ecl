//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Prox,E_Business_Sele,E_Business_Ult,E_Phone FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_Prox_Phone_Number(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Business_Prox().Typ) Site_;
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.nstr S_I_C_Code_;
    KEL.typ.nstr N_A_I_C_S_Code_;
    KEL.typ.nstr Best_Phone_;
    KEL.typ.nint Best_Phone_Rank_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'Site_(DEFAULT:Site_:0),phonenumber(DEFAULT:Phone_Number_:0),siccode(DEFAULT:S_I_C_Code_:\'\'),naicscode(DEFAULT:N_A_I_C_S_Code_:\'\'),bestphone(DEFAULT:Best_Phone_:\'\'),bestphonerank(DEFAULT:Best_Phone_Rank_:0),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'Site_(DEFAULT:Site_:0),company_phone(OVERRIDE:Phone_Number_:0),company_sic_code1(OVERRIDE:S_I_C_Code_:\'\'),company_naics_code1(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestphone(DEFAULT:Best_Phone_:\'\'),bestphonerank(DEFAULT:Best_Phone_Rank_:0),source(OVERRIDE:Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_kfetch2,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_kfetch2),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((UNSIGNED)company_phone != 0 AND (UNSIGNED)proxid<>0);
  SHARED __d0_Site__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d0_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d0_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d0_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Site__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping1 := 'Site_(DEFAULT:Site_:0),company_phone(OVERRIDE:Phone_Number_:0),company_sic_code2(OVERRIDE:S_I_C_Code_:\'\'),company_naics_code2(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestphone(DEFAULT:Best_Phone_:\'\'),bestphonerank(DEFAULT:Best_Phone_Rank_:0),source(OVERRIDE:Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_kfetch2,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_kfetch2),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((UNSIGNED)company_phone != 0 AND (UNSIGNED)proxid<>0 AND ((UNSIGNED)company_sic_code2 > 0 OR (UNSIGNED)company_naics_code2 > 0 ));
  SHARED __d1_Site__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d1_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d1_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d1_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d1_Prefiltered := __d1_Site__Mapped;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping2 := 'Site_(DEFAULT:Site_:0),company_phone(OVERRIDE:Phone_Number_:0),company_sic_code3(OVERRIDE:S_I_C_Code_:\'\'),company_naics_code3(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestphone(DEFAULT:Best_Phone_:\'\'),bestphonerank(DEFAULT:Best_Phone_Rank_:0),source(OVERRIDE:Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_kfetch2,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_kfetch2),SELF:=RIGHT));
  EXPORT __d2_KELfiltered := __d2_Norm((UNSIGNED)company_phone != 0 AND (UNSIGNED)proxid<>0 AND ((UNSIGNED)company_sic_code3 > 0 OR (UNSIGNED)company_naics_code3 > 0));
  SHARED __d2_Site__Layout := RECORD
    RECORDOF(__d2_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d2_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d2_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d2_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d2_Prefiltered := __d2_Site__Mapped;
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping3 := 'Site_(DEFAULT:Site_:0),company_phone(OVERRIDE:Phone_Number_:0),company_sic_code4(OVERRIDE:S_I_C_Code_:\'\'),company_naics_code4(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestphone(DEFAULT:Best_Phone_:\'\'),bestphonerank(DEFAULT:Best_Phone_Rank_:0),source(OVERRIDE:Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_kfetch2,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_kfetch2),SELF:=RIGHT));
  EXPORT __d3_KELfiltered := __d3_Norm((UNSIGNED)company_phone != 0 AND (UNSIGNED)proxid<>0 AND ((UNSIGNED)company_sic_code4 > 0 OR (UNSIGNED)company_naics_code4 > 0));
  SHARED __d3_Site__Layout := RECORD
    RECORDOF(__d3_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d3_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d3_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d3_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d3_Prefiltered := __d3_Site__Mapped;
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping4 := 'Site_(DEFAULT:Site_:0),company_phone(OVERRIDE:Phone_Number_:0),company_sic_code5(OVERRIDE:S_I_C_Code_:\'\'),company_naics_code5(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestphone(DEFAULT:Best_Phone_:\'\'),bestphonerank(DEFAULT:Best_Phone_Rank_:0),source(OVERRIDE:Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_kfetch2,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_kfetch2),SELF:=RIGHT));
  EXPORT __d4_KELfiltered := __d4_Norm((UNSIGNED)company_phone != 0 AND (UNSIGNED)proxid<>0 AND ((UNSIGNED)company_sic_code5 > 0 OR (UNSIGNED)company_naics_code5 > 0));
  SHARED __d4_Site__Layout := RECORD
    RECORDOF(__d4_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d4_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d4_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d4_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d4_Prefiltered := __d4_Site__Mapped;
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping5 := 'Site_(DEFAULT:Site_:0),phone(OVERRIDE:Phone_Number_:0),siccode(DEFAULT:S_I_C_Code_:\'\'),naicscode(DEFAULT:N_A_I_C_S_Code_:\'\'),bestphone(DEFAULT:Best_Phone_:\'\'),bestphonerank(DEFAULT:Best_Phone_Rank_:0),src(OVERRIDE:Source_:\'\'),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d5_Norm := NORMALIZE(__in,LEFT.Dataset_UtilFile__Kfetch2_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_UtilFile__Kfetch2_LinkIds),SELF:=RIGHT));
  EXPORT __d5_KELfiltered := __d5_Norm((UNSIGNED)phone != 0 AND (UNSIGNED)proxid<>0);
  SHARED __d5_Site__Layout := RECORD
    RECORDOF(__d5_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d5_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d5_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d5_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d5_Prefiltered := __d5_Site__Mapped;
  SHARED __d5 := __SourceFilter(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping6 := 'Site_(DEFAULT:Site_:0),phone10(OVERRIDE:Phone_Number_:0),sic_code(OVERRIDE:S_I_C_Code_:\'\'),naics_code(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestphone(DEFAULT:Best_Phone_:\'\'),bestphonerank(DEFAULT:Best_Phone_Rank_:0),source(OVERRIDE:Source_:\'\'),pub_date(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d6_Norm := NORMALIZE(__in,LEFT.Dataset_YellowPages__kfetch_yellowpages_linkids,TRANSFORM(RECORDOF(__in.Dataset_YellowPages__kfetch_yellowpages_linkids),SELF:=RIGHT));
  EXPORT __d6_KELfiltered := __d6_Norm((UNSIGNED)phone10 <> 0  AND (UNSIGNED)proxid<>0);
  SHARED __d6_Site__Layout := RECORD
    RECORDOF(__d6_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d6_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d6_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d6_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d6_Prefiltered := __d6_Site__Mapped;
  SHARED __d6 := __SourceFilter(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping7 := 'Site_(DEFAULT:Site_:0),company_phone(OVERRIDE:Phone_Number_:0|OVERRIDE:Best_Phone_:\'\'),siccode(DEFAULT:S_I_C_Code_:\'\'),naicscode(DEFAULT:N_A_I_C_S_Code_:\'\'),src(OVERRIDE:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED InLayout __Mapping7_Transform(InLayout __r) := TRANSFORM
    SELF.Best_Phone_Rank_ := __CN(1);
    SELF := __r;
  END;
  SHARED __d7_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2_Best__Key_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_BIPV2_Best__Key_LinkIds),SELF:=RIGHT));
  EXPORT __d7_KELfiltered := __d7_Norm(proxid != 0 AND seleid != 0 AND company_phone <> '');
  SHARED __d7_Site__Layout := RECORD
    RECORDOF(__d7_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d7_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d7_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d7_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d7_Prefiltered := __d7_Site__Mapped;
  SHARED __d7 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d7_Prefiltered,InLayout,__Mapping7,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping7_Transform(LEFT)));
  SHARED __Mapping8 := 'Site_(DEFAULT:Site_:0),phone10(OVERRIDE:Phone_Number_:0),siccode(DEFAULT:S_I_C_Code_:\'\'),naicscode(DEFAULT:N_A_I_C_S_Code_:\'\'),bestphone(DEFAULT:Best_Phone_:\'\'),bestphonerank(DEFAULT:Best_Phone_Rank_:0),src(OVERRIDE:Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d8_Norm := NORMALIZE(__in,LEFT.Dataset_Gong__Key_History_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_Gong__Key_History_LinkIds),SELF:=RIGHT));
  EXPORT __d8_KELfiltered := __d8_Norm((UNSIGNED)phone10 != 0 AND (UNSIGNED)proxid<>0);
  SHARED __d8_Site__Layout := RECORD
    RECORDOF(__d8_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d8_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d8_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d8_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d8_Prefiltered := __d8_Site__Mapped;
  SHARED __d8 := __SourceFilter(KEL.FromFlat.Convert(__d8_Prefiltered,InLayout,__Mapping8,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6 + __d7 + __d8;
  EXPORT S_I_C_Codes_Layout := RECORD
    KEL.typ.nstr S_I_C_Code_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT N_A_I_C_S_Codes_Layout := RECORD
    KEL.typ.nstr N_A_I_C_S_Code_;
    KEL.typ.nstr Source_;
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
    KEL.typ.ntyp(E_Business_Prox().Typ) Site_;
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.nstr Best_Phone_;
    KEL.typ.nint Best_Phone_Rank_;
    KEL.typ.ndataset(S_I_C_Codes_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(N_A_I_C_S_Codes_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Site_,Phone_Number_,Best_Phone_,Best_Phone_Rank_,ALL));
  Prox_Phone_Number_Group := __PostFilter;
  Layout Prox_Phone_Number__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.S_I_C_Codes_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),S_I_C_Code_,Source_},S_I_C_Code_,Source_),S_I_C_Codes_Layout)(__NN(S_I_C_Code_) OR __NN(Source_)));
    SELF.N_A_I_C_S_Codes_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),N_A_I_C_S_Code_,Source_},N_A_I_C_S_Code_,Source_),N_A_I_C_S_Codes_Layout)(__NN(N_A_I_C_S_Code_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Prox_Phone_Number__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.S_I_C_Codes_ := __CN(PROJECT(DATASET(__r),TRANSFORM(S_I_C_Codes_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(S_I_C_Code_) OR __NN(Source_)));
    SELF.N_A_I_C_S_Codes_ := __CN(PROJECT(DATASET(__r),TRANSFORM(N_A_I_C_S_Codes_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(N_A_I_C_S_Code_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Prox_Phone_Number_Group,COUNT(ROWS(LEFT))=1),GROUP,Prox_Phone_Number__Single_Rollup(LEFT)) + ROLLUP(HAVING(Prox_Phone_Number_Group,COUNT(ROWS(LEFT))>1),GROUP,Prox_Phone_Number__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Site__Orphan := JOIN(InData(__NN(Site_)),E_Business_Prox(__in,__cfg).__Result,__EEQP(LEFT.Site_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Phone_Number__Orphan := JOIN(InData(__NN(Phone_Number_)),E_Phone(__in,__cfg).__Result,__EEQP(LEFT.Phone_Number_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Site__Orphan),COUNT(Phone_Number__Orphan)}],{KEL.typ.int Site__Orphan,KEL.typ.int Phone_Number__Orphan});
  EXPORT NullCounts := DATASET([
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d0(__NL(Site_))),COUNT(__d0(__NN(Site_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_phone',COUNT(__d0(__NL(Phone_Number_))),COUNT(__d0(__NN(Phone_Number_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code1',COUNT(__d0(__NL(S_I_C_Code_))),COUNT(__d0(__NN(S_I_C_Code_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code1',COUNT(__d0(__NL(N_A_I_C_S_Code_))),COUNT(__d0(__NN(N_A_I_C_S_Code_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhone',COUNT(__d0(__NL(Best_Phone_))),COUNT(__d0(__NN(Best_Phone_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhoneRank',COUNT(__d0(__NL(Best_Phone_Rank_))),COUNT(__d0(__NN(Best_Phone_Rank_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d1(__NL(Site_))),COUNT(__d1(__NN(Site_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_phone',COUNT(__d1(__NL(Phone_Number_))),COUNT(__d1(__NN(Phone_Number_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code2',COUNT(__d1(__NL(S_I_C_Code_))),COUNT(__d1(__NN(S_I_C_Code_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code2',COUNT(__d1(__NL(N_A_I_C_S_Code_))),COUNT(__d1(__NN(N_A_I_C_S_Code_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhone',COUNT(__d1(__NL(Best_Phone_))),COUNT(__d1(__NN(Best_Phone_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhoneRank',COUNT(__d1(__NL(Best_Phone_Rank_))),COUNT(__d1(__NN(Best_Phone_Rank_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d2(__NL(Site_))),COUNT(__d2(__NN(Site_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_phone',COUNT(__d2(__NL(Phone_Number_))),COUNT(__d2(__NN(Phone_Number_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code3',COUNT(__d2(__NL(S_I_C_Code_))),COUNT(__d2(__NN(S_I_C_Code_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code3',COUNT(__d2(__NL(N_A_I_C_S_Code_))),COUNT(__d2(__NN(N_A_I_C_S_Code_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhone',COUNT(__d2(__NL(Best_Phone_))),COUNT(__d2(__NN(Best_Phone_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhoneRank',COUNT(__d2(__NL(Best_Phone_Rank_))),COUNT(__d2(__NN(Best_Phone_Rank_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d3(__NL(Site_))),COUNT(__d3(__NN(Site_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_phone',COUNT(__d3(__NL(Phone_Number_))),COUNT(__d3(__NN(Phone_Number_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code4',COUNT(__d3(__NL(S_I_C_Code_))),COUNT(__d3(__NN(S_I_C_Code_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code4',COUNT(__d3(__NL(N_A_I_C_S_Code_))),COUNT(__d3(__NN(N_A_I_C_S_Code_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhone',COUNT(__d3(__NL(Best_Phone_))),COUNT(__d3(__NN(Best_Phone_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhoneRank',COUNT(__d3(__NL(Best_Phone_Rank_))),COUNT(__d3(__NN(Best_Phone_Rank_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d4(__NL(Site_))),COUNT(__d4(__NN(Site_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_phone',COUNT(__d4(__NL(Phone_Number_))),COUNT(__d4(__NN(Phone_Number_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code5',COUNT(__d4(__NL(S_I_C_Code_))),COUNT(__d4(__NN(S_I_C_Code_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code5',COUNT(__d4(__NL(N_A_I_C_S_Code_))),COUNT(__d4(__NN(N_A_I_C_S_Code_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhone',COUNT(__d4(__NL(Best_Phone_))),COUNT(__d4(__NN(Best_Phone_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhoneRank',COUNT(__d4(__NL(Best_Phone_Rank_))),COUNT(__d4(__NN(Best_Phone_Rank_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d5(__NL(Site_))),COUNT(__d5(__NN(Site_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d5(__NL(Phone_Number_))),COUNT(__d5(__NN(Phone_Number_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SICCode',COUNT(__d5(__NL(S_I_C_Code_))),COUNT(__d5(__NN(S_I_C_Code_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NAICSCode',COUNT(__d5(__NL(N_A_I_C_S_Code_))),COUNT(__d5(__NN(N_A_I_C_S_Code_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhone',COUNT(__d5(__NL(Best_Phone_))),COUNT(__d5(__NN(Best_Phone_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhoneRank',COUNT(__d5(__NL(Best_Phone_Rank_))),COUNT(__d5(__NN(Best_Phone_Rank_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d6(__NL(Site_))),COUNT(__d6(__NN(Site_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone10',COUNT(__d6(__NL(Phone_Number_))),COUNT(__d6(__NN(Phone_Number_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sic_code',COUNT(__d6(__NL(S_I_C_Code_))),COUNT(__d6(__NN(S_I_C_Code_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','naics_code',COUNT(__d6(__NL(N_A_I_C_S_Code_))),COUNT(__d6(__NN(N_A_I_C_S_Code_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhone',COUNT(__d6(__NL(Best_Phone_))),COUNT(__d6(__NN(Best_Phone_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhoneRank',COUNT(__d6(__NL(Best_Phone_Rank_))),COUNT(__d6(__NN(Best_Phone_Rank_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d6(__NL(Source_))),COUNT(__d6(__NN(Source_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d7(__NL(Site_))),COUNT(__d7(__NN(Site_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_phone',COUNT(__d7(__NL(Phone_Number_))),COUNT(__d7(__NN(Phone_Number_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SICCode',COUNT(__d7(__NL(S_I_C_Code_))),COUNT(__d7(__NN(S_I_C_Code_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NAICSCode',COUNT(__d7(__NL(N_A_I_C_S_Code_))),COUNT(__d7(__NN(N_A_I_C_S_Code_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_phone',COUNT(__d7(__NL(Best_Phone_))),COUNT(__d7(__NN(Best_Phone_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d7(__NL(Source_))),COUNT(__d7(__NN(Source_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d7(Date_First_Seen_=0)),COUNT(__d7(Date_First_Seen_!=0))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d7(Date_Last_Seen_=0)),COUNT(__d7(Date_Last_Seen_!=0))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d8(__NL(Site_))),COUNT(__d8(__NN(Site_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone10',COUNT(__d8(__NL(Phone_Number_))),COUNT(__d8(__NN(Phone_Number_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SICCode',COUNT(__d8(__NL(S_I_C_Code_))),COUNT(__d8(__NN(S_I_C_Code_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NAICSCode',COUNT(__d8(__NL(N_A_I_C_S_Code_))),COUNT(__d8(__NN(N_A_I_C_S_Code_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhone',COUNT(__d8(__NL(Best_Phone_))),COUNT(__d8(__NN(Best_Phone_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhoneRank',COUNT(__d8(__NL(Best_Phone_Rank_))),COUNT(__d8(__NN(Best_Phone_Rank_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d8(__NL(Source_))),COUNT(__d8(__NN(Source_)))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d8(Date_First_Seen_=0)),COUNT(__d8(Date_First_Seen_!=0))},
    {'ProxPhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d8(Date_Last_Seen_=0)),COUNT(__d8(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
