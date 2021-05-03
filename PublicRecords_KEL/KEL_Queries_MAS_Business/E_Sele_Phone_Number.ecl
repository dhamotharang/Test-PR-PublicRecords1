//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Phone FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT E_Sele_Phone_Number(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.nstr Best_Phone_;
    KEL.typ.nint Best_Phone_Rank_;
    KEL.typ.nstr S_I_C_Code_;
    KEL.typ.nstr N_A_I_C_S_Code_;
    KEL.typ.nstr Prior_Area_Code_;
    KEL.typ.nstr Current_Flag_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Publish_Code_;
    KEL.typ.nstr Listing_Type_;
    KEL.typ.nstr Is_Active_;
    KEL.typ.nstr No_Solicit_Code_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nstr Omit_Indicator_;
    KEL.typ.nbool Is_Phone_Marketable_;
    KEL.typ.nint Phone_Marketability_Score_;
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
  SHARED __Mapping := 'Legal_(DEFAULT:Legal_:0),phonenumber(DEFAULT:Phone_Number_:0),bestphone(DEFAULT:Best_Phone_:\'\'),bestphonerank(DEFAULT:Best_Phone_Rank_:0),siccode(DEFAULT:S_I_C_Code_:\'\'),naicscode(DEFAULT:N_A_I_C_S_Code_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping0 := 'Legal_(DEFAULT:Legal_:0),company_phone(OVERRIDE:Phone_Number_:0),bestphone(DEFAULT:Best_Phone_:\'\'),bestphonerank(DEFAULT:Best_Phone_Rank_:0),company_sic_code1(OVERRIDE:S_I_C_Code_:\'\'),company_naics_code1(OVERRIDE:N_A_I_C_S_Code_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_kfetch2,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_kfetch2),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((UNSIGNED)company_phone != 0 AND (UNSIGNED)seleid<>0);
  SHARED __d0_Legal__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d0_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d0_Legal__Mapped := IF(__d0_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d0_KELfiltered,TRANSFORM(__d0_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_KELfiltered,__d0_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d0_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Prefiltered := __d0_Legal__Mapped;
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping0_Transform(LEFT)));
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping1 := 'Legal_(DEFAULT:Legal_:0),company_phone(OVERRIDE:Phone_Number_:0),bestphone(DEFAULT:Best_Phone_:\'\'),bestphonerank(DEFAULT:Best_Phone_Rank_:0),company_sic_code2(OVERRIDE:S_I_C_Code_:\'\'),company_naics_code2(OVERRIDE:N_A_I_C_S_Code_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_kfetch2,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_kfetch2),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((UNSIGNED)company_phone != 0 AND (UNSIGNED)seleid<>0 AND ((UNSIGNED)company_sic_code2 > 0 OR (UNSIGNED)company_naics_code2 > 0 ));
  SHARED __d1_Legal__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d1_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d1_Legal__Mapped := IF(__d1_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d1_KELfiltered,TRANSFORM(__d1_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_KELfiltered,__d1_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d1_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d1_Prefiltered := __d1_Legal__Mapped;
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping1_Transform(LEFT)));
  SHARED Date_Last_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping2 := 'Legal_(DEFAULT:Legal_:0),company_phone(OVERRIDE:Phone_Number_:0),bestphone(DEFAULT:Best_Phone_:\'\'),bestphonerank(DEFAULT:Best_Phone_Rank_:0),company_sic_code3(OVERRIDE:S_I_C_Code_:\'\'),company_naics_code3(OVERRIDE:N_A_I_C_S_Code_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_2Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping2_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_kfetch2,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_kfetch2),SELF:=RIGHT));
  EXPORT __d2_KELfiltered := __d2_Norm((UNSIGNED)company_phone != 0 AND (UNSIGNED)seleid<>0 AND ((UNSIGNED)company_sic_code3 > 0 OR (UNSIGNED)company_naics_code3 > 0));
  SHARED __d2_Legal__Layout := RECORD
    RECORDOF(__d2_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d2_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d2_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d2_Legal__Mapped := IF(__d2_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d2_KELfiltered,TRANSFORM(__d2_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d2_KELfiltered,__d2_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d2_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d2_Prefiltered := __d2_Legal__Mapped;
  SHARED __d2 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping2_Transform(LEFT)));
  SHARED Date_Last_Seen_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping3 := 'Legal_(DEFAULT:Legal_:0),company_phone(OVERRIDE:Phone_Number_:0),bestphone(DEFAULT:Best_Phone_:\'\'),bestphonerank(DEFAULT:Best_Phone_Rank_:0),company_sic_code4(OVERRIDE:S_I_C_Code_:\'\'),company_naics_code4(OVERRIDE:N_A_I_C_S_Code_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_3Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping3_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_kfetch2,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_kfetch2),SELF:=RIGHT));
  EXPORT __d3_KELfiltered := __d3_Norm((UNSIGNED)company_phone != 0 AND (UNSIGNED)seleid<>0 AND ((UNSIGNED)company_sic_code4 > 0 OR (UNSIGNED)company_naics_code4 > 0));
  SHARED __d3_Legal__Layout := RECORD
    RECORDOF(__d3_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d3_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d3_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d3_Legal__Mapped := IF(__d3_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d3_KELfiltered,TRANSFORM(__d3_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d3_KELfiltered,__d3_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d3_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d3_Prefiltered := __d3_Legal__Mapped;
  SHARED __d3 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping3_Transform(LEFT)));
  SHARED Date_Last_Seen_4Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping4 := 'Legal_(DEFAULT:Legal_:0),company_phone(OVERRIDE:Phone_Number_:0),bestphone(DEFAULT:Best_Phone_:\'\'),bestphonerank(DEFAULT:Best_Phone_Rank_:0),company_sic_code5(OVERRIDE:S_I_C_Code_:\'\'),company_naics_code5(OVERRIDE:N_A_I_C_S_Code_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_4Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping4_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_kfetch2,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_kfetch2),SELF:=RIGHT));
  EXPORT __d4_KELfiltered := __d4_Norm((UNSIGNED)company_phone != 0 AND (UNSIGNED)seleid<>0 AND ((UNSIGNED)company_sic_code5 > 0 OR (UNSIGNED)company_naics_code5 > 0));
  SHARED __d4_Legal__Layout := RECORD
    RECORDOF(__d4_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d4_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d4_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d4_Legal__Mapped := IF(__d4_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d4_KELfiltered,TRANSFORM(__d4_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d4_KELfiltered,__d4_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d4_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d4_Prefiltered := __d4_Legal__Mapped;
  SHARED __d4 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping4_Transform(LEFT)));
  SHARED __Mapping5 := 'Legal_(DEFAULT:Legal_:0),phone10(OVERRIDE:Phone_Number_:0),bestphone(DEFAULT:Best_Phone_:\'\'),bestphonerank(DEFAULT:Best_Phone_Rank_:0),sic_code(OVERRIDE:S_I_C_Code_:\'\'),naics_code(OVERRIDE:N_A_I_C_S_Code_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),nosolicitcode(OVERRIDE:No_Solicit_Code_:\'\'),record_type(OVERRIDE:Record_Type_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),pub_date(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d5_Norm := NORMALIZE(__in,LEFT.Dataset_YellowPages__kfetch_yellowpages_linkids,TRANSFORM(RECORDOF(__in.Dataset_YellowPages__kfetch_yellowpages_linkids),SELF:=RIGHT));
  EXPORT __d5_KELfiltered := __d5_Norm((UNSIGNED)phone10 <> 0  AND (UNSIGNED)seleid<>0);
  SHARED __d5_Legal__Layout := RECORD
    RECORDOF(__d5_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d5_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d5_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d5_Legal__Mapped := IF(__d5_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d5_KELfiltered,TRANSFORM(__d5_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d5_KELfiltered,__d5_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d5_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d5_Prefiltered := __d5_Legal__Mapped;
  SHARED __d5 := __SourceFilter(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping6 := 'Legal_(DEFAULT:Legal_:0),efx_phone(OVERRIDE:Phone_Number_:0),bestphone(DEFAULT:Best_Phone_:\'\'),bestphonerank(DEFAULT:Best_Phone_Rank_:0),siccode(DEFAULT:S_I_C_Code_:\'\'),naicscode(DEFAULT:N_A_I_C_S_Code_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),efx_mrkt_telever(OVERRIDE:Is_Phone_Marketable_),efx_mrkt_telescore(OVERRIDE:Phone_Marketability_Score_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d6_Norm := NORMALIZE(__in,LEFT.Dataset_Equifax_Business__Data_kfetch_LinkIDs,TRANSFORM(RECORDOF(__in.Dataset_Equifax_Business__Data_kfetch_LinkIDs),SELF:=RIGHT));
  EXPORT __d6_KELfiltered := __d6_Norm((UNSIGNED)seleid<>0 AND (UNSIGNED)efx_phone != 0);
  SHARED __d6_Legal__Layout := RECORD
    RECORDOF(__d6_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d6_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d6_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d6_Legal__Mapped := IF(__d6_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d6_KELfiltered,TRANSFORM(__d6_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d6_KELfiltered,__d6_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d6_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d6_Prefiltered := __d6_Legal__Mapped;
  SHARED __d6 := __SourceFilter(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping7 := 'Legal_(DEFAULT:Legal_:0),company_phone(OVERRIDE:Phone_Number_:0|OVERRIDE:Best_Phone_:\'\'),siccode(DEFAULT:S_I_C_Code_:\'\'),naicscode(DEFAULT:N_A_I_C_S_Code_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping7_Transform(InLayout __r) := TRANSFORM
    SELF.Best_Phone_Rank_ := __CN(1);
    SELF := __r;
  END;
  SHARED __d7_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2_Best__Key_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_BIPV2_Best__Key_LinkIds),SELF:=RIGHT));
  EXPORT __d7_KELfiltered := __d7_Norm(proxid = 0 AND seleid != 0 AND company_phone <> '');
  SHARED __d7_Legal__Layout := RECORD
    RECORDOF(__d7_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d7_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d7_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d7_Legal__Mapped := IF(__d7_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d7_KELfiltered,TRANSFORM(__d7_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d7_KELfiltered,__d7_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d7_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d7_Prefiltered := __d7_Legal__Mapped;
  SHARED __d7 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d7_Prefiltered,InLayout,__Mapping7,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping7_Transform(LEFT)));
  SHARED __Mapping8 := 'Legal_(DEFAULT:Legal_:0),phone10(OVERRIDE:Phone_Number_:0),bestphone(DEFAULT:Best_Phone_:\'\'),bestphonerank(DEFAULT:Best_Phone_Rank_:0),siccode(DEFAULT:S_I_C_Code_:\'\'),naicscode(DEFAULT:N_A_I_C_S_Code_:\'\'),prior_area_code(OVERRIDE:Prior_Area_Code_:\'\'),current_record_flag(OVERRIDE:Current_Flag_:\'\'|OVERRIDE:Is_Active_:\'\'),listing_type_bus(OVERRIDE:Business_Flag_:\'\'),publish_code(OVERRIDE:Publish_Code_:\'\'),listing_type(OVERRIDE:Listing_Type_:\'\'),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),omit_phone(OVERRIDE:Omit_Indicator_:\'\'),isphonemarketable(DEFAULT:Is_Phone_Marketable_),phonemarketabilityscore(DEFAULT:Phone_Marketability_Score_:0),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d8_Norm := NORMALIZE(__in,LEFT.Dataset_Gong__Key_History_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_Gong__Key_History_LinkIds),SELF:=RIGHT));
  EXPORT __d8_KELfiltered := __d8_Norm((UNSIGNED)phone10 != 0 AND (UNSIGNED)seleid<>0);
  SHARED __d8_Legal__Layout := RECORD
    RECORDOF(__d8_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d8_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d8_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d8_Legal__Mapped := IF(__d8_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d8_KELfiltered,TRANSFORM(__d8_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d8_KELfiltered,__d8_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d8_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d8_Prefiltered := __d8_Legal__Mapped;
  SHARED __d8 := __SourceFilter(KEL.FromFlat.Convert(__d8_Prefiltered,InLayout,__Mapping8,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6 + __d7 + __d8;
  EXPORT Best_Phone_Details_Layout := RECORD
    KEL.typ.nstr Best_Phone_;
    KEL.typ.nint Best_Phone_Rank_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Phone_Details_Layout := RECORD
    KEL.typ.nstr Prior_Area_Code_;
    KEL.typ.nstr Current_Flag_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Publish_Code_;
    KEL.typ.nstr Listing_Type_;
    KEL.typ.nstr Is_Active_;
    KEL.typ.nstr Omit_Indicator_;
    KEL.typ.nstr No_Solicit_Code_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Marketability_Layout := RECORD
    KEL.typ.nbool Is_Phone_Marketable_;
    KEL.typ.nint Phone_Marketability_Score_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT S_I_C_Codes_Layout := RECORD
    KEL.typ.nstr S_I_C_Code_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT N_A_I_C_S_Codes_Layout := RECORD
    KEL.typ.nstr N_A_I_C_S_Code_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
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
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.ndataset(Best_Phone_Details_Layout) Best_Phone_Details_;
    KEL.typ.ndataset(Phone_Details_Layout) Phone_Details_;
    KEL.typ.ndataset(Marketability_Layout) Marketability_;
    KEL.typ.ndataset(S_I_C_Codes_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(N_A_I_C_S_Codes_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Legal_,Phone_Number_,ALL));
  Sele_Phone_Number_Group := __PostFilter;
  Layout Sele_Phone_Number__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Best_Phone_Details_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Best_Phone_,Best_Phone_Rank_},Best_Phone_,Best_Phone_Rank_),Best_Phone_Details_Layout)(__NN(Best_Phone_) OR __NN(Best_Phone_Rank_)));
    SELF.Phone_Details_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Prior_Area_Code_,Current_Flag_,Business_Flag_,Publish_Code_,Listing_Type_,Is_Active_,Omit_Indicator_,No_Solicit_Code_,Record_Type_,Source_},Prior_Area_Code_,Current_Flag_,Business_Flag_,Publish_Code_,Listing_Type_,Is_Active_,Omit_Indicator_,No_Solicit_Code_,Record_Type_,Source_),Phone_Details_Layout)(__NN(Prior_Area_Code_) OR __NN(Current_Flag_) OR __NN(Business_Flag_) OR __NN(Publish_Code_) OR __NN(Listing_Type_) OR __NN(Is_Active_) OR __NN(Omit_Indicator_) OR __NN(No_Solicit_Code_) OR __NN(Record_Type_) OR __NN(Source_)));
    SELF.Marketability_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Is_Phone_Marketable_,Phone_Marketability_Score_,Source_},Is_Phone_Marketable_,Phone_Marketability_Score_,Source_),Marketability_Layout)(__NN(Is_Phone_Marketable_) OR __NN(Phone_Marketability_Score_) OR __NN(Source_)));
    SELF.S_I_C_Codes_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),S_I_C_Code_,Source_},S_I_C_Code_,Source_),S_I_C_Codes_Layout)(__NN(S_I_C_Code_) OR __NN(Source_)));
    SELF.N_A_I_C_S_Codes_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),N_A_I_C_S_Code_,Source_},N_A_I_C_S_Code_,Source_),N_A_I_C_S_Codes_Layout)(__NN(N_A_I_C_S_Code_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Header_Hit_Flag_,Source_},Header_Hit_Flag_,Source_),Data_Sources_Layout)(__NN(Header_Hit_Flag_) OR __NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Sele_Phone_Number__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Best_Phone_Details_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Best_Phone_Details_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Best_Phone_) OR __NN(Best_Phone_Rank_)));
    SELF.Phone_Details_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Phone_Details_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Prior_Area_Code_) OR __NN(Current_Flag_) OR __NN(Business_Flag_) OR __NN(Publish_Code_) OR __NN(Listing_Type_) OR __NN(Is_Active_) OR __NN(Omit_Indicator_) OR __NN(No_Solicit_Code_) OR __NN(Record_Type_) OR __NN(Source_)));
    SELF.Marketability_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Marketability_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Is_Phone_Marketable_) OR __NN(Phone_Marketability_Score_) OR __NN(Source_)));
    SELF.S_I_C_Codes_ := __CN(PROJECT(DATASET(__r),TRANSFORM(S_I_C_Codes_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(S_I_C_Code_) OR __NN(Source_)));
    SELF.N_A_I_C_S_Codes_ := __CN(PROJECT(DATASET(__r),TRANSFORM(N_A_I_C_S_Codes_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(N_A_I_C_S_Code_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Header_Hit_Flag_) OR __NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Sele_Phone_Number_Group,COUNT(ROWS(LEFT))=1),GROUP,Sele_Phone_Number__Single_Rollup(LEFT)) + ROLLUP(HAVING(Sele_Phone_Number_Group,COUNT(ROWS(LEFT))>1),GROUP,Sele_Phone_Number__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Legal__Orphan := JOIN(InData(__NN(Legal_)),E_Business_Sele(__in,__cfg).__Result,__EEQP(LEFT.Legal_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Phone_Number__Orphan := JOIN(InData(__NN(Phone_Number_)),E_Phone(__in,__cfg).__Result,__EEQP(LEFT.Phone_Number_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Legal__Orphan),COUNT(Phone_Number__Orphan)}],{KEL.typ.int Legal__Orphan,KEL.typ.int Phone_Number__Orphan});
  EXPORT NullCounts := DATASET([
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d0(__NL(Legal_))),COUNT(__d0(__NN(Legal_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_phone',COUNT(__d0(__NL(Phone_Number_))),COUNT(__d0(__NN(Phone_Number_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhone',COUNT(__d0(__NL(Best_Phone_))),COUNT(__d0(__NN(Best_Phone_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhoneRank',COUNT(__d0(__NL(Best_Phone_Rank_))),COUNT(__d0(__NN(Best_Phone_Rank_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code1',COUNT(__d0(__NL(S_I_C_Code_))),COUNT(__d0(__NN(S_I_C_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code1',COUNT(__d0(__NL(N_A_I_C_S_Code_))),COUNT(__d0(__NN(N_A_I_C_S_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d0(__NL(Prior_Area_Code_))),COUNT(__d0(__NN(Prior_Area_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d0(__NL(Current_Flag_))),COUNT(__d0(__NN(Current_Flag_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d0(__NL(Business_Flag_))),COUNT(__d0(__NN(Business_Flag_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d0(__NL(Publish_Code_))),COUNT(__d0(__NN(Publish_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d0(__NL(Listing_Type_))),COUNT(__d0(__NN(Listing_Type_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d0(__NL(Is_Active_))),COUNT(__d0(__NN(Is_Active_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d0(__NL(No_Solicit_Code_))),COUNT(__d0(__NN(No_Solicit_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d0(__NL(Record_Type_))),COUNT(__d0(__NN(Record_Type_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d0(__NL(Omit_Indicator_))),COUNT(__d0(__NN(Omit_Indicator_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d0(__NL(Is_Phone_Marketable_))),COUNT(__d0(__NN(Is_Phone_Marketable_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d0(__NL(Phone_Marketability_Score_))),COUNT(__d0(__NN(Phone_Marketability_Score_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d1(__NL(Legal_))),COUNT(__d1(__NN(Legal_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_phone',COUNT(__d1(__NL(Phone_Number_))),COUNT(__d1(__NN(Phone_Number_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhone',COUNT(__d1(__NL(Best_Phone_))),COUNT(__d1(__NN(Best_Phone_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhoneRank',COUNT(__d1(__NL(Best_Phone_Rank_))),COUNT(__d1(__NN(Best_Phone_Rank_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code2',COUNT(__d1(__NL(S_I_C_Code_))),COUNT(__d1(__NN(S_I_C_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code2',COUNT(__d1(__NL(N_A_I_C_S_Code_))),COUNT(__d1(__NN(N_A_I_C_S_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d1(__NL(Prior_Area_Code_))),COUNT(__d1(__NN(Prior_Area_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d1(__NL(Current_Flag_))),COUNT(__d1(__NN(Current_Flag_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d1(__NL(Business_Flag_))),COUNT(__d1(__NN(Business_Flag_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d1(__NL(Publish_Code_))),COUNT(__d1(__NN(Publish_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d1(__NL(Listing_Type_))),COUNT(__d1(__NN(Listing_Type_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d1(__NL(Is_Active_))),COUNT(__d1(__NN(Is_Active_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d1(__NL(No_Solicit_Code_))),COUNT(__d1(__NN(No_Solicit_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d1(__NL(Record_Type_))),COUNT(__d1(__NN(Record_Type_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d1(__NL(Omit_Indicator_))),COUNT(__d1(__NN(Omit_Indicator_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d1(__NL(Is_Phone_Marketable_))),COUNT(__d1(__NN(Is_Phone_Marketable_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d1(__NL(Phone_Marketability_Score_))),COUNT(__d1(__NN(Phone_Marketability_Score_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d2(__NL(Legal_))),COUNT(__d2(__NN(Legal_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_phone',COUNT(__d2(__NL(Phone_Number_))),COUNT(__d2(__NN(Phone_Number_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhone',COUNT(__d2(__NL(Best_Phone_))),COUNT(__d2(__NN(Best_Phone_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhoneRank',COUNT(__d2(__NL(Best_Phone_Rank_))),COUNT(__d2(__NN(Best_Phone_Rank_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code3',COUNT(__d2(__NL(S_I_C_Code_))),COUNT(__d2(__NN(S_I_C_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code3',COUNT(__d2(__NL(N_A_I_C_S_Code_))),COUNT(__d2(__NN(N_A_I_C_S_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d2(__NL(Prior_Area_Code_))),COUNT(__d2(__NN(Prior_Area_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d2(__NL(Current_Flag_))),COUNT(__d2(__NN(Current_Flag_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d2(__NL(Business_Flag_))),COUNT(__d2(__NN(Business_Flag_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d2(__NL(Publish_Code_))),COUNT(__d2(__NN(Publish_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d2(__NL(Listing_Type_))),COUNT(__d2(__NN(Listing_Type_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d2(__NL(Is_Active_))),COUNT(__d2(__NN(Is_Active_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d2(__NL(No_Solicit_Code_))),COUNT(__d2(__NN(No_Solicit_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d2(__NL(Record_Type_))),COUNT(__d2(__NN(Record_Type_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d2(__NL(Omit_Indicator_))),COUNT(__d2(__NN(Omit_Indicator_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d2(__NL(Is_Phone_Marketable_))),COUNT(__d2(__NN(Is_Phone_Marketable_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d2(__NL(Phone_Marketability_Score_))),COUNT(__d2(__NN(Phone_Marketability_Score_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d3(__NL(Legal_))),COUNT(__d3(__NN(Legal_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_phone',COUNT(__d3(__NL(Phone_Number_))),COUNT(__d3(__NN(Phone_Number_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhone',COUNT(__d3(__NL(Best_Phone_))),COUNT(__d3(__NN(Best_Phone_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhoneRank',COUNT(__d3(__NL(Best_Phone_Rank_))),COUNT(__d3(__NN(Best_Phone_Rank_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code4',COUNT(__d3(__NL(S_I_C_Code_))),COUNT(__d3(__NN(S_I_C_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code4',COUNT(__d3(__NL(N_A_I_C_S_Code_))),COUNT(__d3(__NN(N_A_I_C_S_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d3(__NL(Prior_Area_Code_))),COUNT(__d3(__NN(Prior_Area_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d3(__NL(Current_Flag_))),COUNT(__d3(__NN(Current_Flag_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d3(__NL(Business_Flag_))),COUNT(__d3(__NN(Business_Flag_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d3(__NL(Publish_Code_))),COUNT(__d3(__NN(Publish_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d3(__NL(Listing_Type_))),COUNT(__d3(__NN(Listing_Type_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d3(__NL(Is_Active_))),COUNT(__d3(__NN(Is_Active_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d3(__NL(No_Solicit_Code_))),COUNT(__d3(__NN(No_Solicit_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d3(__NL(Record_Type_))),COUNT(__d3(__NN(Record_Type_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d3(__NL(Omit_Indicator_))),COUNT(__d3(__NN(Omit_Indicator_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d3(__NL(Is_Phone_Marketable_))),COUNT(__d3(__NN(Is_Phone_Marketable_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d3(__NL(Phone_Marketability_Score_))),COUNT(__d3(__NN(Phone_Marketability_Score_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d3(Hybrid_Archive_Date_=0)),COUNT(__d3(Hybrid_Archive_Date_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d3(Vault_Date_Last_Seen_=0)),COUNT(__d3(Vault_Date_Last_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d4(__NL(Legal_))),COUNT(__d4(__NN(Legal_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_phone',COUNT(__d4(__NL(Phone_Number_))),COUNT(__d4(__NN(Phone_Number_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhone',COUNT(__d4(__NL(Best_Phone_))),COUNT(__d4(__NN(Best_Phone_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhoneRank',COUNT(__d4(__NL(Best_Phone_Rank_))),COUNT(__d4(__NN(Best_Phone_Rank_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code5',COUNT(__d4(__NL(S_I_C_Code_))),COUNT(__d4(__NN(S_I_C_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code5',COUNT(__d4(__NL(N_A_I_C_S_Code_))),COUNT(__d4(__NN(N_A_I_C_S_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d4(__NL(Prior_Area_Code_))),COUNT(__d4(__NN(Prior_Area_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d4(__NL(Current_Flag_))),COUNT(__d4(__NN(Current_Flag_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d4(__NL(Business_Flag_))),COUNT(__d4(__NN(Business_Flag_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d4(__NL(Publish_Code_))),COUNT(__d4(__NN(Publish_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d4(__NL(Listing_Type_))),COUNT(__d4(__NN(Listing_Type_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d4(__NL(Is_Active_))),COUNT(__d4(__NN(Is_Active_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d4(__NL(No_Solicit_Code_))),COUNT(__d4(__NN(No_Solicit_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d4(__NL(Record_Type_))),COUNT(__d4(__NN(Record_Type_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d4(__NL(Omit_Indicator_))),COUNT(__d4(__NN(Omit_Indicator_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d4(__NL(Is_Phone_Marketable_))),COUNT(__d4(__NN(Is_Phone_Marketable_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d4(__NL(Phone_Marketability_Score_))),COUNT(__d4(__NN(Phone_Marketability_Score_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d4(Archive___Date_=0)),COUNT(__d4(Archive___Date_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d4(Hybrid_Archive_Date_=0)),COUNT(__d4(Hybrid_Archive_Date_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d4(Vault_Date_Last_Seen_=0)),COUNT(__d4(Vault_Date_Last_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d5(__NL(Legal_))),COUNT(__d5(__NN(Legal_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone10',COUNT(__d5(__NL(Phone_Number_))),COUNT(__d5(__NN(Phone_Number_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhone',COUNT(__d5(__NL(Best_Phone_))),COUNT(__d5(__NN(Best_Phone_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhoneRank',COUNT(__d5(__NL(Best_Phone_Rank_))),COUNT(__d5(__NN(Best_Phone_Rank_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sic_code',COUNT(__d5(__NL(S_I_C_Code_))),COUNT(__d5(__NN(S_I_C_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','naics_code',COUNT(__d5(__NL(N_A_I_C_S_Code_))),COUNT(__d5(__NN(N_A_I_C_S_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d5(__NL(Prior_Area_Code_))),COUNT(__d5(__NN(Prior_Area_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d5(__NL(Current_Flag_))),COUNT(__d5(__NN(Current_Flag_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d5(__NL(Business_Flag_))),COUNT(__d5(__NN(Business_Flag_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d5(__NL(Publish_Code_))),COUNT(__d5(__NN(Publish_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d5(__NL(Listing_Type_))),COUNT(__d5(__NN(Listing_Type_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d5(__NL(Is_Active_))),COUNT(__d5(__NN(Is_Active_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','nosolicitcode',COUNT(__d5(__NL(No_Solicit_Code_))),COUNT(__d5(__NN(No_Solicit_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_type',COUNT(__d5(__NL(Record_Type_))),COUNT(__d5(__NN(Record_Type_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d5(__NL(Omit_Indicator_))),COUNT(__d5(__NN(Omit_Indicator_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d5(__NL(Is_Phone_Marketable_))),COUNT(__d5(__NN(Is_Phone_Marketable_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d5(__NL(Phone_Marketability_Score_))),COUNT(__d5(__NN(Phone_Marketability_Score_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d5(__NL(Header_Hit_Flag_))),COUNT(__d5(__NN(Header_Hit_Flag_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d5(Archive___Date_=0)),COUNT(__d5(Archive___Date_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d5(Hybrid_Archive_Date_=0)),COUNT(__d5(Hybrid_Archive_Date_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d5(Vault_Date_Last_Seen_=0)),COUNT(__d5(Vault_Date_Last_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d6(__NL(Legal_))),COUNT(__d6(__NN(Legal_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_phone',COUNT(__d6(__NL(Phone_Number_))),COUNT(__d6(__NN(Phone_Number_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhone',COUNT(__d6(__NL(Best_Phone_))),COUNT(__d6(__NN(Best_Phone_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhoneRank',COUNT(__d6(__NL(Best_Phone_Rank_))),COUNT(__d6(__NN(Best_Phone_Rank_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SICCode',COUNT(__d6(__NL(S_I_C_Code_))),COUNT(__d6(__NN(S_I_C_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NAICSCode',COUNT(__d6(__NL(N_A_I_C_S_Code_))),COUNT(__d6(__NN(N_A_I_C_S_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d6(__NL(Prior_Area_Code_))),COUNT(__d6(__NN(Prior_Area_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d6(__NL(Current_Flag_))),COUNT(__d6(__NN(Current_Flag_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d6(__NL(Business_Flag_))),COUNT(__d6(__NN(Business_Flag_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d6(__NL(Publish_Code_))),COUNT(__d6(__NN(Publish_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d6(__NL(Listing_Type_))),COUNT(__d6(__NN(Listing_Type_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d6(__NL(Is_Active_))),COUNT(__d6(__NN(Is_Active_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d6(__NL(No_Solicit_Code_))),COUNT(__d6(__NN(No_Solicit_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d6(__NL(Record_Type_))),COUNT(__d6(__NN(Record_Type_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d6(__NL(Omit_Indicator_))),COUNT(__d6(__NN(Omit_Indicator_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_mrkt_telever',COUNT(__d6(__NL(Is_Phone_Marketable_))),COUNT(__d6(__NN(Is_Phone_Marketable_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_mrkt_telescore',COUNT(__d6(__NL(Phone_Marketability_Score_))),COUNT(__d6(__NN(Phone_Marketability_Score_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d6(__NL(Header_Hit_Flag_))),COUNT(__d6(__NN(Header_Hit_Flag_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d6(__NL(Source_))),COUNT(__d6(__NN(Source_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d6(Archive___Date_=0)),COUNT(__d6(Archive___Date_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d6(Hybrid_Archive_Date_=0)),COUNT(__d6(Hybrid_Archive_Date_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d6(Vault_Date_Last_Seen_=0)),COUNT(__d6(Vault_Date_Last_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d7(__NL(Legal_))),COUNT(__d7(__NN(Legal_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_phone',COUNT(__d7(__NL(Phone_Number_))),COUNT(__d7(__NN(Phone_Number_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_phone',COUNT(__d7(__NL(Best_Phone_))),COUNT(__d7(__NN(Best_Phone_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SICCode',COUNT(__d7(__NL(S_I_C_Code_))),COUNT(__d7(__NN(S_I_C_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NAICSCode',COUNT(__d7(__NL(N_A_I_C_S_Code_))),COUNT(__d7(__NN(N_A_I_C_S_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d7(__NL(Prior_Area_Code_))),COUNT(__d7(__NN(Prior_Area_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d7(__NL(Current_Flag_))),COUNT(__d7(__NN(Current_Flag_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d7(__NL(Business_Flag_))),COUNT(__d7(__NN(Business_Flag_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d7(__NL(Publish_Code_))),COUNT(__d7(__NN(Publish_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d7(__NL(Listing_Type_))),COUNT(__d7(__NN(Listing_Type_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d7(__NL(Is_Active_))),COUNT(__d7(__NN(Is_Active_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d7(__NL(No_Solicit_Code_))),COUNT(__d7(__NN(No_Solicit_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d7(__NL(Record_Type_))),COUNT(__d7(__NN(Record_Type_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d7(__NL(Omit_Indicator_))),COUNT(__d7(__NN(Omit_Indicator_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d7(__NL(Is_Phone_Marketable_))),COUNT(__d7(__NN(Is_Phone_Marketable_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d7(__NL(Phone_Marketability_Score_))),COUNT(__d7(__NN(Phone_Marketability_Score_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d7(__NL(Header_Hit_Flag_))),COUNT(__d7(__NN(Header_Hit_Flag_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d7(__NL(Source_))),COUNT(__d7(__NN(Source_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d7(Archive___Date_=0)),COUNT(__d7(Archive___Date_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d7(Date_First_Seen_=0)),COUNT(__d7(Date_First_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d7(Date_Last_Seen_=0)),COUNT(__d7(Date_Last_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d7(Hybrid_Archive_Date_=0)),COUNT(__d7(Hybrid_Archive_Date_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d7(Vault_Date_Last_Seen_=0)),COUNT(__d7(Vault_Date_Last_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d8(__NL(Legal_))),COUNT(__d8(__NN(Legal_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone10',COUNT(__d8(__NL(Phone_Number_))),COUNT(__d8(__NN(Phone_Number_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhone',COUNT(__d8(__NL(Best_Phone_))),COUNT(__d8(__NN(Best_Phone_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPhoneRank',COUNT(__d8(__NL(Best_Phone_Rank_))),COUNT(__d8(__NN(Best_Phone_Rank_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SICCode',COUNT(__d8(__NL(S_I_C_Code_))),COUNT(__d8(__NN(S_I_C_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NAICSCode',COUNT(__d8(__NL(N_A_I_C_S_Code_))),COUNT(__d8(__NN(N_A_I_C_S_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prior_area_code',COUNT(__d8(__NL(Prior_Area_Code_))),COUNT(__d8(__NN(Prior_Area_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_record_flag',COUNT(__d8(__NL(Current_Flag_))),COUNT(__d8(__NN(Current_Flag_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','listing_type_bus',COUNT(__d8(__NL(Business_Flag_))),COUNT(__d8(__NN(Business_Flag_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','publish_code',COUNT(__d8(__NL(Publish_Code_))),COUNT(__d8(__NN(Publish_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','listing_type',COUNT(__d8(__NL(Listing_Type_))),COUNT(__d8(__NN(Listing_Type_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_record_flag',COUNT(__d8(__NL(Is_Active_))),COUNT(__d8(__NN(Is_Active_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d8(__NL(No_Solicit_Code_))),COUNT(__d8(__NN(No_Solicit_Code_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d8(__NL(Record_Type_))),COUNT(__d8(__NN(Record_Type_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','omit_phone',COUNT(__d8(__NL(Omit_Indicator_))),COUNT(__d8(__NN(Omit_Indicator_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsPhoneMarketable',COUNT(__d8(__NL(Is_Phone_Marketable_))),COUNT(__d8(__NN(Is_Phone_Marketable_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneMarketabilityScore',COUNT(__d8(__NL(Phone_Marketability_Score_))),COUNT(__d8(__NN(Phone_Marketability_Score_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d8(__NL(Header_Hit_Flag_))),COUNT(__d8(__NN(Header_Hit_Flag_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d8(__NL(Source_))),COUNT(__d8(__NN(Source_)))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d8(Archive___Date_=0)),COUNT(__d8(Archive___Date_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d8(Date_First_Seen_=0)),COUNT(__d8(Date_First_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d8(Date_Last_Seen_=0)),COUNT(__d8(Date_Last_Seen_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d8(Hybrid_Archive_Date_=0)),COUNT(__d8(Hybrid_Archive_Date_!=0))},
    {'SelePhoneNumber','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d8(Vault_Date_Last_Seen_=0)),COUNT(__d8(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
