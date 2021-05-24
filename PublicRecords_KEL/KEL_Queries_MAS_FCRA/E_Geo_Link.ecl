//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL16.Null;
EXPORT E_Geo_Link(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Geo_Link_;
    KEL.typ.nbool Is_Latest_;
    KEL.typ.nfloat Geo_Percent_White_;
    KEL.typ.nfloat Geo_Percent_Black_;
    KEL.typ.nfloat Geo_Percent_American_Indian_Alaska_Native_;
    KEL.typ.nfloat Geo_Percent_Asian_Pacific_Islander_;
    KEL.typ.nfloat Geo_Percent_Multiracial_;
    KEL.typ.nfloat Geo_Percent_Hispanic_;
    KEL.typ.nfloat Here_;
    KEL.typ.nfloat Here_Given_White_;
    KEL.typ.nfloat Here_Given_Black_;
    KEL.typ.nfloat Here_Given_American_Indian_Alaska_Native_;
    KEL.typ.nfloat Here_Given_Asian_Pacific_Islander_;
    KEL.typ.nfloat Here_Given_Multiracial_;
    KEL.typ.nfloat Here_Given_Hispanic_;
    KEL.typ.nstr State_Fips10_;
    KEL.typ.nstr County_Fips10_;
    KEL.typ.nstr Tract_Fips10_;
    KEL.typ.nint Block_Group_Fips10_;
    KEL.typ.nint Total_Population_;
    KEL.typ.nint Hispanic_Total_;
    KEL.typ.nint Non_Hispanic_Total_;
    KEL.typ.nint Non_Hispanic_White_Alone_;
    KEL.typ.nint Non_Hispanic_Black_Alone_;
    KEL.typ.nint Non_Hispanic_American_Indian_Alaska_Native_Alone_;
    KEL.typ.nint Non_Hispanic_Asian_Pacific_Islander_Alone_;
    KEL.typ.nint Non_Hispanic_Other_Alone_;
    KEL.typ.nint Non_Hispanic_Multiracial_Alone_;
    KEL.typ.nint Non_Hispanic_White_Other_;
    KEL.typ.nint Non_Hispanic_Black_Other_;
    KEL.typ.nint Non_Hispanic_American_Indian_Alaska_Native_Other_;
    KEL.typ.nint Non_Hispanic_Asian_Other_;
    KEL.typ.nint Non_Hispanic_Asian_Pacific_Islander_Other_;
    KEL.typ.nint Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_;
    KEL.typ.nint Median_Valuation_;
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
  SHARED __Mapping := 'UID(DEFAULT:UID),geolink(DEFAULT:Geo_Link_:\'\'),islatest(DEFAULT:Is_Latest_),geopercentwhite(DEFAULT:Geo_Percent_White_:0.0),geopercentblack(DEFAULT:Geo_Percent_Black_:0.0),geopercentamericanindianalaskanative(DEFAULT:Geo_Percent_American_Indian_Alaska_Native_:0.0),geopercentasianpacificislander(DEFAULT:Geo_Percent_Asian_Pacific_Islander_:0.0),geopercentmultiracial(DEFAULT:Geo_Percent_Multiracial_:0.0),geopercenthispanic(DEFAULT:Geo_Percent_Hispanic_:0.0),here(DEFAULT:Here_:0.0),heregivenwhite(DEFAULT:Here_Given_White_),heregivenblack(DEFAULT:Here_Given_Black_),heregivenamericanindianalaskanative(DEFAULT:Here_Given_American_Indian_Alaska_Native_),heregivenasianpacificislander(DEFAULT:Here_Given_Asian_Pacific_Islander_),heregivenmultiracial(DEFAULT:Here_Given_Multiracial_),heregivenhispanic(DEFAULT:Here_Given_Hispanic_),statefips10(DEFAULT:State_Fips10_:\'\'),countyfips10(DEFAULT:County_Fips10_:\'\'),tractfips10(DEFAULT:Tract_Fips10_:\'\'),blockgroupfips10(DEFAULT:Block_Group_Fips10_:0),totalpopulation(DEFAULT:Total_Population_:0),hispanictotal(DEFAULT:Hispanic_Total_:0),nonhispanictotal(DEFAULT:Non_Hispanic_Total_:0),nonhispanicwhitealone(DEFAULT:Non_Hispanic_White_Alone_:0),nonhispanicblackalone(DEFAULT:Non_Hispanic_Black_Alone_:0),nonhispanicamericanindianalaskanativealone(DEFAULT:Non_Hispanic_American_Indian_Alaska_Native_Alone_:0),nonhispanicasianpacificislanderalone(DEFAULT:Non_Hispanic_Asian_Pacific_Islander_Alone_:0),nonhispanicotheralone(DEFAULT:Non_Hispanic_Other_Alone_:0),nonhispanicmultiracialalone(DEFAULT:Non_Hispanic_Multiracial_Alone_:0),nonhispanicwhiteother(DEFAULT:Non_Hispanic_White_Other_:0),nonhispanicblackother(DEFAULT:Non_Hispanic_Black_Other_:0),nonhispanicamericanindianalaskanativeother(DEFAULT:Non_Hispanic_American_Indian_Alaska_Native_Other_:0),nonhispanicasianother(DEFAULT:Non_Hispanic_Asian_Other_:0),nonhispanicasianpacificislanderother(DEFAULT:Non_Hispanic_Asian_Pacific_Islander_Other_:0),nonhispanicasianhawaiianpacificislanderother(DEFAULT:Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_:0),medianvaluation(DEFAULT:Median_Valuation_:0),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in.Dataset_dx_ConsumerFinancialProtectionBureau__Key_BLKGRP,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.geoid10_blkgrp)));
  SHARED __d1_Trim := PROJECT(__in.Dataset_dx_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.geoind)));
  SHARED __d2_KELfiltered := __in.Dataset_AVM_V2__Key_AVM_Medians((unsigned)fips_geo_12 > 0);
  SHARED __d2_Trim := PROJECT(__d2_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.fips_geo_12)));
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
  SHARED __Mapping0 := 'UID(DEFAULT:UID),geoid10_blkgrp(OVERRIDE:Geo_Link_:\'\'),is_latest(OVERRIDE:Is_Latest_),geopercentwhite(DEFAULT:Geo_Percent_White_:0.0),geopercentblack(DEFAULT:Geo_Percent_Black_:0.0),geopercentamericanindianalaskanative(DEFAULT:Geo_Percent_American_Indian_Alaska_Native_:0.0),geopercentasianpacificislander(DEFAULT:Geo_Percent_Asian_Pacific_Islander_:0.0),geopercentmultiracial(DEFAULT:Geo_Percent_Multiracial_:0.0),geopercenthispanic(DEFAULT:Geo_Percent_Hispanic_:0.0),here(DEFAULT:Here_:0.0),heregivenwhite(DEFAULT:Here_Given_White_),heregivenblack(DEFAULT:Here_Given_Black_),heregivenamericanindianalaskanative(DEFAULT:Here_Given_American_Indian_Alaska_Native_),heregivenasianpacificislander(DEFAULT:Here_Given_Asian_Pacific_Islander_),heregivenmultiracial(DEFAULT:Here_Given_Multiracial_),heregivenhispanic(DEFAULT:Here_Given_Hispanic_),state_fips10(OVERRIDE:State_Fips10_:\'\'),county_fips10(OVERRIDE:County_Fips10_:\'\'),tract_fips10(OVERRIDE:Tract_Fips10_:\'\'),blkgrp_fips10(OVERRIDE:Block_Group_Fips10_:0),total_pop(OVERRIDE:Total_Population_:0),hispanic_total(OVERRIDE:Hispanic_Total_:0),non_hispanic_total(OVERRIDE:Non_Hispanic_Total_:0),nh_white_alone(OVERRIDE:Non_Hispanic_White_Alone_:0),nh_black_alone(OVERRIDE:Non_Hispanic_Black_Alone_:0),nh_aian_alone(OVERRIDE:Non_Hispanic_American_Indian_Alaska_Native_Alone_:0),nh_api_alone(OVERRIDE:Non_Hispanic_Asian_Pacific_Islander_Alone_:0),nh_other_alone(OVERRIDE:Non_Hispanic_Other_Alone_:0),nh_mult_total(OVERRIDE:Non_Hispanic_Multiracial_Alone_:0),nh_white_other(OVERRIDE:Non_Hispanic_White_Other_:0),nh_black_other(OVERRIDE:Non_Hispanic_Black_Other_:0),nh_aian_other(OVERRIDE:Non_Hispanic_American_Indian_Alaska_Native_Other_:0),nh_asian_hpi(OVERRIDE:Non_Hispanic_Asian_Other_:0),nh_api_other(OVERRIDE:Non_Hispanic_Asian_Pacific_Islander_Other_:0),nh_asian_hpi_other(OVERRIDE:Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_:0),medianvaluation(DEFAULT:Median_Valuation_:0),src(OVERRIDE:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),dt_vendor_first_reported(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_dx_ConsumerFinancialProtectionBureau__Key_BLKGRP,TRANSFORM(RECORDOF(__in.Dataset_dx_ConsumerFinancialProtectionBureau__Key_BLKGRP),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_dx_ConsumerFinancialProtectionBureau__Key_BLKGRP);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_Norm,Lookup,TRIM((STRING)LEFT.geoid10_blkgrp) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_dx_ConsumerFinancialProtectionBureau__Key_BLKGRP_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping1 := 'UID(DEFAULT:UID),geoind(OVERRIDE:Geo_Link_:\'\'),is_latest(OVERRIDE:Is_Latest_),geo_pr_white(OVERRIDE:Geo_Percent_White_:0.0),geo_pr_black(OVERRIDE:Geo_Percent_Black_:0.0),geo_pr_aian(OVERRIDE:Geo_Percent_American_Indian_Alaska_Native_:0.0),geo_pr_api(OVERRIDE:Geo_Percent_Asian_Pacific_Islander_:0.0),geo_pr_mult_other(OVERRIDE:Geo_Percent_Multiracial_:0.0),geo_pr_hispanic(OVERRIDE:Geo_Percent_Hispanic_:0.0),here(OVERRIDE:Here_:0.0),here_given_white(OVERRIDE:Here_Given_White_),here_given_black(OVERRIDE:Here_Given_Black_),here_given_aian(OVERRIDE:Here_Given_American_Indian_Alaska_Native_),here_given_api(OVERRIDE:Here_Given_Asian_Pacific_Islander_),here_given_mult_other(OVERRIDE:Here_Given_Multiracial_),here_given_hispanic(OVERRIDE:Here_Given_Hispanic_),statefips10(DEFAULT:State_Fips10_:\'\'),countyfips10(DEFAULT:County_Fips10_:\'\'),tractfips10(DEFAULT:Tract_Fips10_:\'\'),blockgroupfips10(DEFAULT:Block_Group_Fips10_:0),totalpopulation(DEFAULT:Total_Population_:0),hispanictotal(DEFAULT:Hispanic_Total_:0),nonhispanictotal(DEFAULT:Non_Hispanic_Total_:0),nonhispanicwhitealone(DEFAULT:Non_Hispanic_White_Alone_:0),nonhispanicblackalone(DEFAULT:Non_Hispanic_Black_Alone_:0),nonhispanicamericanindianalaskanativealone(DEFAULT:Non_Hispanic_American_Indian_Alaska_Native_Alone_:0),nonhispanicasianpacificislanderalone(DEFAULT:Non_Hispanic_Asian_Pacific_Islander_Alone_:0),nonhispanicotheralone(DEFAULT:Non_Hispanic_Other_Alone_:0),nonhispanicmultiracialalone(DEFAULT:Non_Hispanic_Multiracial_Alone_:0),nonhispanicwhiteother(DEFAULT:Non_Hispanic_White_Other_:0),nonhispanicblackother(DEFAULT:Non_Hispanic_Black_Other_:0),nonhispanicamericanindianalaskanativeother(DEFAULT:Non_Hispanic_American_Indian_Alaska_Native_Other_:0),nonhispanicasianother(DEFAULT:Non_Hispanic_Asian_Other_:0),nonhispanicasianpacificislanderother(DEFAULT:Non_Hispanic_Asian_Pacific_Islander_Other_:0),nonhispanicasianhawaiianpacificislanderother(DEFAULT:Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_:0),medianvaluation(DEFAULT:Median_Valuation_:0),src(OVERRIDE:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),dt_vendor_first_reported(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_dx_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18,TRANSFORM(RECORDOF(__in.Dataset_dx_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18),SELF:=RIGHT));
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_dx_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_Norm,Lookup,TRIM((STRING)LEFT.geoind) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_dx_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping2 := 'UID(DEFAULT:UID),fips_geo_12(OVERRIDE:Geo_Link_:\'\'),islatest(DEFAULT:Is_Latest_),geopercentwhite(DEFAULT:Geo_Percent_White_:0.0),geopercentblack(DEFAULT:Geo_Percent_Black_:0.0),geopercentamericanindianalaskanative(DEFAULT:Geo_Percent_American_Indian_Alaska_Native_:0.0),geopercentasianpacificislander(DEFAULT:Geo_Percent_Asian_Pacific_Islander_:0.0),geopercentmultiracial(DEFAULT:Geo_Percent_Multiracial_:0.0),geopercenthispanic(DEFAULT:Geo_Percent_Hispanic_:0.0),here(DEFAULT:Here_:0.0),heregivenwhite(DEFAULT:Here_Given_White_),heregivenblack(DEFAULT:Here_Given_Black_),heregivenamericanindianalaskanative(DEFAULT:Here_Given_American_Indian_Alaska_Native_),heregivenasianpacificislander(DEFAULT:Here_Given_Asian_Pacific_Islander_),heregivenmultiracial(DEFAULT:Here_Given_Multiracial_),heregivenhispanic(DEFAULT:Here_Given_Hispanic_),statefips10(DEFAULT:State_Fips10_:\'\'),countyfips10(DEFAULT:County_Fips10_:\'\'),tractfips10(DEFAULT:Tract_Fips10_:\'\'),blockgroupfips10(DEFAULT:Block_Group_Fips10_:0),totalpopulation(DEFAULT:Total_Population_:0),hispanictotal(DEFAULT:Hispanic_Total_:0),nonhispanictotal(DEFAULT:Non_Hispanic_Total_:0),nonhispanicwhitealone(DEFAULT:Non_Hispanic_White_Alone_:0),nonhispanicblackalone(DEFAULT:Non_Hispanic_Black_Alone_:0),nonhispanicamericanindianalaskanativealone(DEFAULT:Non_Hispanic_American_Indian_Alaska_Native_Alone_:0),nonhispanicasianpacificislanderalone(DEFAULT:Non_Hispanic_Asian_Pacific_Islander_Alone_:0),nonhispanicotheralone(DEFAULT:Non_Hispanic_Other_Alone_:0),nonhispanicmultiracialalone(DEFAULT:Non_Hispanic_Multiracial_Alone_:0),nonhispanicwhiteother(DEFAULT:Non_Hispanic_White_Other_:0),nonhispanicblackother(DEFAULT:Non_Hispanic_Black_Other_:0),nonhispanicamericanindianalaskanativeother(DEFAULT:Non_Hispanic_American_Indian_Alaska_Native_Other_:0),nonhispanicasianother(DEFAULT:Non_Hispanic_Asian_Other_:0),nonhispanicasianpacificislanderother(DEFAULT:Non_Hispanic_Asian_Pacific_Islander_Other_:0),nonhispanicasianhawaiianpacificislanderother(DEFAULT:Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_:0),median_valuation(OVERRIDE:Median_Valuation_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),history_date(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_2Rule),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_AVM_V2__Key_AVM_Medians,TRANSFORM(RECORDOF(__in.Dataset_AVM_V2__Key_AVM_Medians),SELF:=RIGHT));
  SHARED __d2_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_AVM_V2__Key_AVM_Medians);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d2_UID_Mapped := JOIN(__d2_KELfiltered,Lookup,TRIM((STRING)LEFT.fips_geo_12) = RIGHT.KeyVal,TRANSFORM(__d2_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_AVM_V2__Key_AVM_Medians_Invalid := __d2_UID_Mapped(UID = 0);
  SHARED __d2_Prefiltered := __d2_UID_Mapped(UID <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1 + __d2;
  EXPORT A_V_M_Layout := RECORD
    KEL.typ.nint Median_Valuation_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Block_Group_Layout := RECORD
    KEL.typ.nbool Is_Latest_;
    KEL.typ.nfloat Geo_Percent_White_;
    KEL.typ.nfloat Geo_Percent_Black_;
    KEL.typ.nfloat Geo_Percent_American_Indian_Alaska_Native_;
    KEL.typ.nfloat Geo_Percent_Asian_Pacific_Islander_;
    KEL.typ.nfloat Geo_Percent_Multiracial_;
    KEL.typ.nfloat Geo_Percent_Hispanic_;
    KEL.typ.nfloat Here_;
    KEL.typ.nfloat Here_Given_White_;
    KEL.typ.nfloat Here_Given_Black_;
    KEL.typ.nfloat Here_Given_American_Indian_Alaska_Native_;
    KEL.typ.nfloat Here_Given_Asian_Pacific_Islander_;
    KEL.typ.nfloat Here_Given_Multiracial_;
    KEL.typ.nfloat Here_Given_Hispanic_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Block_Group_Over18_Layout := RECORD
    KEL.typ.nbool Is_Latest_;
    KEL.typ.nstr State_Fips10_;
    KEL.typ.nstr County_Fips10_;
    KEL.typ.nstr Tract_Fips10_;
    KEL.typ.nint Block_Group_Fips10_;
    KEL.typ.nint Total_Population_;
    KEL.typ.nint Hispanic_Total_;
    KEL.typ.nint Non_Hispanic_Total_;
    KEL.typ.nint Non_Hispanic_White_Alone_;
    KEL.typ.nint Non_Hispanic_Black_Alone_;
    KEL.typ.nint Non_Hispanic_American_Indian_Alaska_Native_Alone_;
    KEL.typ.nint Non_Hispanic_Asian_Pacific_Islander_Alone_;
    KEL.typ.nint Non_Hispanic_Other_Alone_;
    KEL.typ.nint Non_Hispanic_Multiracial_Alone_;
    KEL.typ.nint Non_Hispanic_White_Other_;
    KEL.typ.nint Non_Hispanic_Black_Other_;
    KEL.typ.nint Non_Hispanic_American_Indian_Alaska_Native_Other_;
    KEL.typ.nint Non_Hispanic_Asian_Other_;
    KEL.typ.nint Non_Hispanic_Asian_Pacific_Islander_Other_;
    KEL.typ.nint Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_;
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
    KEL.typ.nstr Geo_Link_;
    KEL.typ.ndataset(A_V_M_Layout) A_V_M_;
    KEL.typ.ndataset(Block_Group_Layout) Block_Group_;
    KEL.typ.ndataset(Block_Group_Over18_Layout) Block_Group_Over18_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Geo_Link_Group := __PostFilter;
  Layout Geo_Link__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Geo_Link_ := KEL.Intake.SingleValue(__recs,Geo_Link_);
    SELF.A_V_M_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Median_Valuation_,Source_},Median_Valuation_,Source_),A_V_M_Layout)(__NN(Median_Valuation_) OR __NN(Source_)));
    SELF.Block_Group_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Is_Latest_,Geo_Percent_White_,Geo_Percent_Black_,Geo_Percent_American_Indian_Alaska_Native_,Geo_Percent_Asian_Pacific_Islander_,Geo_Percent_Multiracial_,Geo_Percent_Hispanic_,Here_,Here_Given_White_,Here_Given_Black_,Here_Given_American_Indian_Alaska_Native_,Here_Given_Asian_Pacific_Islander_,Here_Given_Multiracial_,Here_Given_Hispanic_},Is_Latest_,Geo_Percent_White_,Geo_Percent_Black_,Geo_Percent_American_Indian_Alaska_Native_,Geo_Percent_Asian_Pacific_Islander_,Geo_Percent_Multiracial_,Geo_Percent_Hispanic_,Here_,Here_Given_White_,Here_Given_Black_,Here_Given_American_Indian_Alaska_Native_,Here_Given_Asian_Pacific_Islander_,Here_Given_Multiracial_,Here_Given_Hispanic_),Block_Group_Layout)(__NN(Is_Latest_) OR __NN(Geo_Percent_White_) OR __NN(Geo_Percent_Black_) OR __NN(Geo_Percent_American_Indian_Alaska_Native_) OR __NN(Geo_Percent_Asian_Pacific_Islander_) OR __NN(Geo_Percent_Multiracial_) OR __NN(Geo_Percent_Hispanic_) OR __NN(Here_) OR __NN(Here_Given_White_) OR __NN(Here_Given_Black_) OR __NN(Here_Given_American_Indian_Alaska_Native_) OR __NN(Here_Given_Asian_Pacific_Islander_) OR __NN(Here_Given_Multiracial_) OR __NN(Here_Given_Hispanic_)));
    SELF.Block_Group_Over18_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Is_Latest_,State_Fips10_,County_Fips10_,Tract_Fips10_,Block_Group_Fips10_,Total_Population_,Hispanic_Total_,Non_Hispanic_Total_,Non_Hispanic_White_Alone_,Non_Hispanic_Black_Alone_,Non_Hispanic_American_Indian_Alaska_Native_Alone_,Non_Hispanic_Asian_Pacific_Islander_Alone_,Non_Hispanic_Other_Alone_,Non_Hispanic_Multiracial_Alone_,Non_Hispanic_White_Other_,Non_Hispanic_Black_Other_,Non_Hispanic_American_Indian_Alaska_Native_Other_,Non_Hispanic_Asian_Other_,Non_Hispanic_Asian_Pacific_Islander_Other_,Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_},Is_Latest_,State_Fips10_,County_Fips10_,Tract_Fips10_,Block_Group_Fips10_,Total_Population_,Hispanic_Total_,Non_Hispanic_Total_,Non_Hispanic_White_Alone_,Non_Hispanic_Black_Alone_,Non_Hispanic_American_Indian_Alaska_Native_Alone_,Non_Hispanic_Asian_Pacific_Islander_Alone_,Non_Hispanic_Other_Alone_,Non_Hispanic_Multiracial_Alone_,Non_Hispanic_White_Other_,Non_Hispanic_Black_Other_,Non_Hispanic_American_Indian_Alaska_Native_Other_,Non_Hispanic_Asian_Other_,Non_Hispanic_Asian_Pacific_Islander_Other_,Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_),Block_Group_Over18_Layout)(__NN(Is_Latest_) OR __NN(State_Fips10_) OR __NN(County_Fips10_) OR __NN(Tract_Fips10_) OR __NN(Block_Group_Fips10_) OR __NN(Total_Population_) OR __NN(Hispanic_Total_) OR __NN(Non_Hispanic_Total_) OR __NN(Non_Hispanic_White_Alone_) OR __NN(Non_Hispanic_Black_Alone_) OR __NN(Non_Hispanic_American_Indian_Alaska_Native_Alone_) OR __NN(Non_Hispanic_Asian_Pacific_Islander_Alone_) OR __NN(Non_Hispanic_Other_Alone_) OR __NN(Non_Hispanic_Multiracial_Alone_) OR __NN(Non_Hispanic_White_Other_) OR __NN(Non_Hispanic_Black_Other_) OR __NN(Non_Hispanic_American_Indian_Alaska_Native_Other_) OR __NN(Non_Hispanic_Asian_Other_) OR __NN(Non_Hispanic_Asian_Pacific_Islander_Other_) OR __NN(Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Geo_Link__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.A_V_M_ := __CN(PROJECT(DATASET(__r),TRANSFORM(A_V_M_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Median_Valuation_) OR __NN(Source_)));
    SELF.Block_Group_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Block_Group_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Is_Latest_) OR __NN(Geo_Percent_White_) OR __NN(Geo_Percent_Black_) OR __NN(Geo_Percent_American_Indian_Alaska_Native_) OR __NN(Geo_Percent_Asian_Pacific_Islander_) OR __NN(Geo_Percent_Multiracial_) OR __NN(Geo_Percent_Hispanic_) OR __NN(Here_) OR __NN(Here_Given_White_) OR __NN(Here_Given_Black_) OR __NN(Here_Given_American_Indian_Alaska_Native_) OR __NN(Here_Given_Asian_Pacific_Islander_) OR __NN(Here_Given_Multiracial_) OR __NN(Here_Given_Hispanic_)));
    SELF.Block_Group_Over18_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Block_Group_Over18_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Is_Latest_) OR __NN(State_Fips10_) OR __NN(County_Fips10_) OR __NN(Tract_Fips10_) OR __NN(Block_Group_Fips10_) OR __NN(Total_Population_) OR __NN(Hispanic_Total_) OR __NN(Non_Hispanic_Total_) OR __NN(Non_Hispanic_White_Alone_) OR __NN(Non_Hispanic_Black_Alone_) OR __NN(Non_Hispanic_American_Indian_Alaska_Native_Alone_) OR __NN(Non_Hispanic_Asian_Pacific_Islander_Alone_) OR __NN(Non_Hispanic_Other_Alone_) OR __NN(Non_Hispanic_Multiracial_Alone_) OR __NN(Non_Hispanic_White_Other_) OR __NN(Non_Hispanic_Black_Other_) OR __NN(Non_Hispanic_American_Indian_Alaska_Native_Other_) OR __NN(Non_Hispanic_Asian_Other_) OR __NN(Non_Hispanic_Asian_Pacific_Islander_Other_) OR __NN(Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Geo_Link_Group,COUNT(ROWS(LEFT))=1),GROUP,Geo_Link__Single_Rollup(LEFT)) + ROLLUP(HAVING(Geo_Link_Group,COUNT(ROWS(LEFT))>1),GROUP,Geo_Link__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Geo_Link__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Geo_Link_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_dx_ConsumerFinancialProtectionBureau__Key_BLKGRP_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_dx_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_AVM_V2__Key_AVM_Medians_Invalid),COUNT(Geo_Link__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_dx_ConsumerFinancialProtectionBureau__Key_BLKGRP_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_dx_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_AVM_V2__Key_AVM_Medians_Invalid,KEL.typ.int Geo_Link__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_dx_ConsumerFinancialProtectionBureau__Key_BLKGRP_Invalid),COUNT(__d0)},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geoid10_blkgrp',COUNT(__d0(__NL(Geo_Link_))),COUNT(__d0(__NN(Geo_Link_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','is_latest',COUNT(__d0(__NL(Is_Latest_))),COUNT(__d0(__NN(Is_Latest_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoPercentWhite',COUNT(__d0(__NL(Geo_Percent_White_))),COUNT(__d0(__NN(Geo_Percent_White_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoPercentBlack',COUNT(__d0(__NL(Geo_Percent_Black_))),COUNT(__d0(__NN(Geo_Percent_Black_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoPercentAmericanIndianAlaskaNative',COUNT(__d0(__NL(Geo_Percent_American_Indian_Alaska_Native_))),COUNT(__d0(__NN(Geo_Percent_American_Indian_Alaska_Native_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoPercentAsianPacificIslander',COUNT(__d0(__NL(Geo_Percent_Asian_Pacific_Islander_))),COUNT(__d0(__NN(Geo_Percent_Asian_Pacific_Islander_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoPercentMultiracial',COUNT(__d0(__NL(Geo_Percent_Multiracial_))),COUNT(__d0(__NN(Geo_Percent_Multiracial_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoPercentHispanic',COUNT(__d0(__NL(Geo_Percent_Hispanic_))),COUNT(__d0(__NN(Geo_Percent_Hispanic_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Here',COUNT(__d0(__NL(Here_))),COUNT(__d0(__NN(Here_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HereGivenWhite',COUNT(__d0(__NL(Here_Given_White_))),COUNT(__d0(__NN(Here_Given_White_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HereGivenBlack',COUNT(__d0(__NL(Here_Given_Black_))),COUNT(__d0(__NN(Here_Given_Black_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HereGivenAmericanIndianAlaskaNative',COUNT(__d0(__NL(Here_Given_American_Indian_Alaska_Native_))),COUNT(__d0(__NN(Here_Given_American_Indian_Alaska_Native_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HereGivenAsianPacificIslander',COUNT(__d0(__NL(Here_Given_Asian_Pacific_Islander_))),COUNT(__d0(__NN(Here_Given_Asian_Pacific_Islander_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HereGivenMultiracial',COUNT(__d0(__NL(Here_Given_Multiracial_))),COUNT(__d0(__NN(Here_Given_Multiracial_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HereGivenHispanic',COUNT(__d0(__NL(Here_Given_Hispanic_))),COUNT(__d0(__NN(Here_Given_Hispanic_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','state_fips10',COUNT(__d0(__NL(State_Fips10_))),COUNT(__d0(__NN(State_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','county_fips10',COUNT(__d0(__NL(County_Fips10_))),COUNT(__d0(__NN(County_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tract_fips10',COUNT(__d0(__NL(Tract_Fips10_))),COUNT(__d0(__NN(Tract_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','blkgrp_fips10',COUNT(__d0(__NL(Block_Group_Fips10_))),COUNT(__d0(__NN(Block_Group_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','total_pop',COUNT(__d0(__NL(Total_Population_))),COUNT(__d0(__NN(Total_Population_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','hispanic_total',COUNT(__d0(__NL(Hispanic_Total_))),COUNT(__d0(__NN(Hispanic_Total_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','non_hispanic_total',COUNT(__d0(__NL(Non_Hispanic_Total_))),COUNT(__d0(__NN(Non_Hispanic_Total_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','nh_white_alone',COUNT(__d0(__NL(Non_Hispanic_White_Alone_))),COUNT(__d0(__NN(Non_Hispanic_White_Alone_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','nh_black_alone',COUNT(__d0(__NL(Non_Hispanic_Black_Alone_))),COUNT(__d0(__NN(Non_Hispanic_Black_Alone_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','nh_aian_alone',COUNT(__d0(__NL(Non_Hispanic_American_Indian_Alaska_Native_Alone_))),COUNT(__d0(__NN(Non_Hispanic_American_Indian_Alaska_Native_Alone_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','nh_api_alone',COUNT(__d0(__NL(Non_Hispanic_Asian_Pacific_Islander_Alone_))),COUNT(__d0(__NN(Non_Hispanic_Asian_Pacific_Islander_Alone_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','nh_other_alone',COUNT(__d0(__NL(Non_Hispanic_Other_Alone_))),COUNT(__d0(__NN(Non_Hispanic_Other_Alone_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','nh_mult_total',COUNT(__d0(__NL(Non_Hispanic_Multiracial_Alone_))),COUNT(__d0(__NN(Non_Hispanic_Multiracial_Alone_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','nh_white_other',COUNT(__d0(__NL(Non_Hispanic_White_Other_))),COUNT(__d0(__NN(Non_Hispanic_White_Other_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','nh_black_other',COUNT(__d0(__NL(Non_Hispanic_Black_Other_))),COUNT(__d0(__NN(Non_Hispanic_Black_Other_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','nh_aian_other',COUNT(__d0(__NL(Non_Hispanic_American_Indian_Alaska_Native_Other_))),COUNT(__d0(__NN(Non_Hispanic_American_Indian_Alaska_Native_Other_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','nh_asian_hpi',COUNT(__d0(__NL(Non_Hispanic_Asian_Other_))),COUNT(__d0(__NN(Non_Hispanic_Asian_Other_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','nh_api_other',COUNT(__d0(__NL(Non_Hispanic_Asian_Pacific_Islander_Other_))),COUNT(__d0(__NN(Non_Hispanic_Asian_Pacific_Islander_Other_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','nh_asian_hpi_other',COUNT(__d0(__NL(Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_))),COUNT(__d0(__NN(Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MedianValuation',COUNT(__d0(__NL(Median_Valuation_))),COUNT(__d0(__NN(Median_Valuation_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_dx_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Invalid),COUNT(__d1)},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geoind',COUNT(__d1(__NL(Geo_Link_))),COUNT(__d1(__NN(Geo_Link_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','is_latest',COUNT(__d1(__NL(Is_Latest_))),COUNT(__d1(__NN(Is_Latest_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_pr_white',COUNT(__d1(__NL(Geo_Percent_White_))),COUNT(__d1(__NN(Geo_Percent_White_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_pr_black',COUNT(__d1(__NL(Geo_Percent_Black_))),COUNT(__d1(__NN(Geo_Percent_Black_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_pr_aian',COUNT(__d1(__NL(Geo_Percent_American_Indian_Alaska_Native_))),COUNT(__d1(__NN(Geo_Percent_American_Indian_Alaska_Native_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_pr_api',COUNT(__d1(__NL(Geo_Percent_Asian_Pacific_Islander_))),COUNT(__d1(__NN(Geo_Percent_Asian_Pacific_Islander_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_pr_mult_other',COUNT(__d1(__NL(Geo_Percent_Multiracial_))),COUNT(__d1(__NN(Geo_Percent_Multiracial_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_pr_hispanic',COUNT(__d1(__NL(Geo_Percent_Hispanic_))),COUNT(__d1(__NN(Geo_Percent_Hispanic_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','here',COUNT(__d1(__NL(Here_))),COUNT(__d1(__NN(Here_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','here_given_white',COUNT(__d1(__NL(Here_Given_White_))),COUNT(__d1(__NN(Here_Given_White_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','here_given_black',COUNT(__d1(__NL(Here_Given_Black_))),COUNT(__d1(__NN(Here_Given_Black_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','here_given_aian',COUNT(__d1(__NL(Here_Given_American_Indian_Alaska_Native_))),COUNT(__d1(__NN(Here_Given_American_Indian_Alaska_Native_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','here_given_api',COUNT(__d1(__NL(Here_Given_Asian_Pacific_Islander_))),COUNT(__d1(__NN(Here_Given_Asian_Pacific_Islander_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','here_given_mult_other',COUNT(__d1(__NL(Here_Given_Multiracial_))),COUNT(__d1(__NN(Here_Given_Multiracial_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','here_given_hispanic',COUNT(__d1(__NL(Here_Given_Hispanic_))),COUNT(__d1(__NN(Here_Given_Hispanic_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StateFips10',COUNT(__d1(__NL(State_Fips10_))),COUNT(__d1(__NN(State_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyFips10',COUNT(__d1(__NL(County_Fips10_))),COUNT(__d1(__NN(County_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TractFips10',COUNT(__d1(__NL(Tract_Fips10_))),COUNT(__d1(__NN(Tract_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BlockGroupFips10',COUNT(__d1(__NL(Block_Group_Fips10_))),COUNT(__d1(__NN(Block_Group_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TotalPopulation',COUNT(__d1(__NL(Total_Population_))),COUNT(__d1(__NN(Total_Population_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HispanicTotal',COUNT(__d1(__NL(Hispanic_Total_))),COUNT(__d1(__NN(Hispanic_Total_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicTotal',COUNT(__d1(__NL(Non_Hispanic_Total_))),COUNT(__d1(__NN(Non_Hispanic_Total_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicWhiteAlone',COUNT(__d1(__NL(Non_Hispanic_White_Alone_))),COUNT(__d1(__NN(Non_Hispanic_White_Alone_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicBlackAlone',COUNT(__d1(__NL(Non_Hispanic_Black_Alone_))),COUNT(__d1(__NN(Non_Hispanic_Black_Alone_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicAmericanIndianAlaskaNativeAlone',COUNT(__d1(__NL(Non_Hispanic_American_Indian_Alaska_Native_Alone_))),COUNT(__d1(__NN(Non_Hispanic_American_Indian_Alaska_Native_Alone_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicAsianPacificIslanderAlone',COUNT(__d1(__NL(Non_Hispanic_Asian_Pacific_Islander_Alone_))),COUNT(__d1(__NN(Non_Hispanic_Asian_Pacific_Islander_Alone_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicOtherAlone',COUNT(__d1(__NL(Non_Hispanic_Other_Alone_))),COUNT(__d1(__NN(Non_Hispanic_Other_Alone_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicMultiracialAlone',COUNT(__d1(__NL(Non_Hispanic_Multiracial_Alone_))),COUNT(__d1(__NN(Non_Hispanic_Multiracial_Alone_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicWhiteOther',COUNT(__d1(__NL(Non_Hispanic_White_Other_))),COUNT(__d1(__NN(Non_Hispanic_White_Other_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicBlackOther',COUNT(__d1(__NL(Non_Hispanic_Black_Other_))),COUNT(__d1(__NN(Non_Hispanic_Black_Other_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicAmericanIndianAlaskaNativeOther',COUNT(__d1(__NL(Non_Hispanic_American_Indian_Alaska_Native_Other_))),COUNT(__d1(__NN(Non_Hispanic_American_Indian_Alaska_Native_Other_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicAsianOther',COUNT(__d1(__NL(Non_Hispanic_Asian_Other_))),COUNT(__d1(__NN(Non_Hispanic_Asian_Other_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicAsianPacificIslanderOther',COUNT(__d1(__NL(Non_Hispanic_Asian_Pacific_Islander_Other_))),COUNT(__d1(__NN(Non_Hispanic_Asian_Pacific_Islander_Other_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicAsianHawaiianPacificIslanderOther',COUNT(__d1(__NL(Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_))),COUNT(__d1(__NN(Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MedianValuation',COUNT(__d1(__NL(Median_Valuation_))),COUNT(__d1(__NN(Median_Valuation_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_AVM_V2__Key_AVM_Medians_Invalid),COUNT(__d2)},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fips_geo_12',COUNT(__d2(__NL(Geo_Link_))),COUNT(__d2(__NN(Geo_Link_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsLatest',COUNT(__d2(__NL(Is_Latest_))),COUNT(__d2(__NN(Is_Latest_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoPercentWhite',COUNT(__d2(__NL(Geo_Percent_White_))),COUNT(__d2(__NN(Geo_Percent_White_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoPercentBlack',COUNT(__d2(__NL(Geo_Percent_Black_))),COUNT(__d2(__NN(Geo_Percent_Black_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoPercentAmericanIndianAlaskaNative',COUNT(__d2(__NL(Geo_Percent_American_Indian_Alaska_Native_))),COUNT(__d2(__NN(Geo_Percent_American_Indian_Alaska_Native_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoPercentAsianPacificIslander',COUNT(__d2(__NL(Geo_Percent_Asian_Pacific_Islander_))),COUNT(__d2(__NN(Geo_Percent_Asian_Pacific_Islander_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoPercentMultiracial',COUNT(__d2(__NL(Geo_Percent_Multiracial_))),COUNT(__d2(__NN(Geo_Percent_Multiracial_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoPercentHispanic',COUNT(__d2(__NL(Geo_Percent_Hispanic_))),COUNT(__d2(__NN(Geo_Percent_Hispanic_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Here',COUNT(__d2(__NL(Here_))),COUNT(__d2(__NN(Here_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HereGivenWhite',COUNT(__d2(__NL(Here_Given_White_))),COUNT(__d2(__NN(Here_Given_White_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HereGivenBlack',COUNT(__d2(__NL(Here_Given_Black_))),COUNT(__d2(__NN(Here_Given_Black_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HereGivenAmericanIndianAlaskaNative',COUNT(__d2(__NL(Here_Given_American_Indian_Alaska_Native_))),COUNT(__d2(__NN(Here_Given_American_Indian_Alaska_Native_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HereGivenAsianPacificIslander',COUNT(__d2(__NL(Here_Given_Asian_Pacific_Islander_))),COUNT(__d2(__NN(Here_Given_Asian_Pacific_Islander_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HereGivenMultiracial',COUNT(__d2(__NL(Here_Given_Multiracial_))),COUNT(__d2(__NN(Here_Given_Multiracial_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HereGivenHispanic',COUNT(__d2(__NL(Here_Given_Hispanic_))),COUNT(__d2(__NN(Here_Given_Hispanic_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StateFips10',COUNT(__d2(__NL(State_Fips10_))),COUNT(__d2(__NN(State_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CountyFips10',COUNT(__d2(__NL(County_Fips10_))),COUNT(__d2(__NN(County_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TractFips10',COUNT(__d2(__NL(Tract_Fips10_))),COUNT(__d2(__NN(Tract_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BlockGroupFips10',COUNT(__d2(__NL(Block_Group_Fips10_))),COUNT(__d2(__NN(Block_Group_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TotalPopulation',COUNT(__d2(__NL(Total_Population_))),COUNT(__d2(__NN(Total_Population_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HispanicTotal',COUNT(__d2(__NL(Hispanic_Total_))),COUNT(__d2(__NN(Hispanic_Total_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicTotal',COUNT(__d2(__NL(Non_Hispanic_Total_))),COUNT(__d2(__NN(Non_Hispanic_Total_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicWhiteAlone',COUNT(__d2(__NL(Non_Hispanic_White_Alone_))),COUNT(__d2(__NN(Non_Hispanic_White_Alone_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicBlackAlone',COUNT(__d2(__NL(Non_Hispanic_Black_Alone_))),COUNT(__d2(__NN(Non_Hispanic_Black_Alone_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicAmericanIndianAlaskaNativeAlone',COUNT(__d2(__NL(Non_Hispanic_American_Indian_Alaska_Native_Alone_))),COUNT(__d2(__NN(Non_Hispanic_American_Indian_Alaska_Native_Alone_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicAsianPacificIslanderAlone',COUNT(__d2(__NL(Non_Hispanic_Asian_Pacific_Islander_Alone_))),COUNT(__d2(__NN(Non_Hispanic_Asian_Pacific_Islander_Alone_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicOtherAlone',COUNT(__d2(__NL(Non_Hispanic_Other_Alone_))),COUNT(__d2(__NN(Non_Hispanic_Other_Alone_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicMultiracialAlone',COUNT(__d2(__NL(Non_Hispanic_Multiracial_Alone_))),COUNT(__d2(__NN(Non_Hispanic_Multiracial_Alone_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicWhiteOther',COUNT(__d2(__NL(Non_Hispanic_White_Other_))),COUNT(__d2(__NN(Non_Hispanic_White_Other_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicBlackOther',COUNT(__d2(__NL(Non_Hispanic_Black_Other_))),COUNT(__d2(__NN(Non_Hispanic_Black_Other_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicAmericanIndianAlaskaNativeOther',COUNT(__d2(__NL(Non_Hispanic_American_Indian_Alaska_Native_Other_))),COUNT(__d2(__NN(Non_Hispanic_American_Indian_Alaska_Native_Other_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicAsianOther',COUNT(__d2(__NL(Non_Hispanic_Asian_Other_))),COUNT(__d2(__NN(Non_Hispanic_Asian_Other_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicAsianPacificIslanderOther',COUNT(__d2(__NL(Non_Hispanic_Asian_Pacific_Islander_Other_))),COUNT(__d2(__NN(Non_Hispanic_Asian_Pacific_Islander_Other_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NonHispanicAsianHawaiianPacificIslanderOther',COUNT(__d2(__NL(Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_))),COUNT(__d2(__NN(Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','median_valuation',COUNT(__d2(__NL(Median_Valuation_))),COUNT(__d2(__NN(Median_Valuation_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'GeoLink','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
