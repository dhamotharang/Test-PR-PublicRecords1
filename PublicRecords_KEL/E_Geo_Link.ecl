//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_Geo_Link(CFG_Compile __cfg = CFG_Compile) := MODULE
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
  SHARED __Mapping := 'UID(DEFAULT:UID),geolink(DEFAULT:Geo_Link_:\'\'),islatest(DEFAULT:Is_Latest_),geopercentwhite(DEFAULT:Geo_Percent_White_:0.0),geopercentblack(DEFAULT:Geo_Percent_Black_:0.0),geopercentamericanindianalaskanative(DEFAULT:Geo_Percent_American_Indian_Alaska_Native_:0.0),geopercentasianpacificislander(DEFAULT:Geo_Percent_Asian_Pacific_Islander_:0.0),geopercentmultiracial(DEFAULT:Geo_Percent_Multiracial_:0.0),geopercenthispanic(DEFAULT:Geo_Percent_Hispanic_:0.0),here(DEFAULT:Here_:0.0),heregivenwhite(DEFAULT:Here_Given_White_:0.0),heregivenblack(DEFAULT:Here_Given_Black_:0.0),heregivenamericanindianalaskanative(DEFAULT:Here_Given_American_Indian_Alaska_Native_:0.0),heregivenasianpacificislander(DEFAULT:Here_Given_Asian_Pacific_Islander_:0.0),heregivenmultiracial(DEFAULT:Here_Given_Multiracial_:0.0),heregivenhispanic(DEFAULT:Here_Given_Hispanic_:0.0),statefips10(DEFAULT:State_Fips10_:\'\'),countyfips10(DEFAULT:County_Fips10_:\'\'),tractfips10(DEFAULT:Tract_Fips10_:\'\'),blockgroupfips10(DEFAULT:Block_Group_Fips10_:0),totalpopulation(DEFAULT:Total_Population_:0),hispanictotal(DEFAULT:Hispanic_Total_:0),nonhispanictotal(DEFAULT:Non_Hispanic_Total_:0),nonhispanicwhitealone(DEFAULT:Non_Hispanic_White_Alone_:0),nonhispanicblackalone(DEFAULT:Non_Hispanic_Black_Alone_:0),nonhispanicamericanindianalaskanativealone(DEFAULT:Non_Hispanic_American_Indian_Alaska_Native_Alone_:0),nonhispanicasianpacificislanderalone(DEFAULT:Non_Hispanic_Asian_Pacific_Islander_Alone_:0),nonhispanicotheralone(DEFAULT:Non_Hispanic_Other_Alone_:0),nonhispanicmultiracialalone(DEFAULT:Non_Hispanic_Multiracial_Alone_:0),nonhispanicwhiteother(DEFAULT:Non_Hispanic_White_Other_:0),nonhispanicblackother(DEFAULT:Non_Hispanic_Black_Other_:0),nonhispanicamericanindianalaskanativeother(DEFAULT:Non_Hispanic_American_Indian_Alaska_Native_Other_:0),nonhispanicasianother(DEFAULT:Non_Hispanic_Asian_Other_:0),nonhispanicasianpacificislanderother(DEFAULT:Non_Hispanic_Asian_Pacific_Islander_Other_:0),nonhispanicasianhawaiianpacificislanderother(DEFAULT:Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_:0),medianvaluation(DEFAULT:Median_Valuation_:0),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.geoind)));
  SHARED __d1_Trim := PROJECT(PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.geoid10_blkgrp)));
  SHARED __d2_KELfiltered := PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault((unsigned)fips_geo_12 > 0);
  SHARED __d2_Trim := PROJECT(__d2_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.fips_geo_12)));
  SHARED __d3_Trim := PROJECT(PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.geoind)));
  SHARED __d4_Trim := PROJECT(PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.geoid10_blkgrp)));
  SHARED __d5_KELfiltered := PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault((unsigned)fips_geo_12 > 0);
  SHARED __d5_Trim := PROJECT(__d5_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.fips_geo_12)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim + __d2_Trim + __d3_Trim + __d4_Trim + __d5_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::PublicRecords_KEL::Geo_Link::UidLookup',EXPIRE(7));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::PublicRecords_KEL::Geo_Link');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::PublicRecords_KEL::Geo_Link');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED __Mapping0 := 'UID(DEFAULT:UID),geoind(OVERRIDE:Geo_Link_:\'\'),is_latest(OVERRIDE:Is_Latest_),geo_pr_white(OVERRIDE:Geo_Percent_White_:0.0),geo_pr_black(OVERRIDE:Geo_Percent_Black_:0.0),geo_pr_aian(OVERRIDE:Geo_Percent_American_Indian_Alaska_Native_:0.0),geo_pr_api(OVERRIDE:Geo_Percent_Asian_Pacific_Islander_:0.0),geo_pr_mult_other(OVERRIDE:Geo_Percent_Multiracial_:0.0),geo_pr_hispanic(OVERRIDE:Geo_Percent_Hispanic_:0.0),here(OVERRIDE:Here_:0.0),here_given_white(OVERRIDE:Here_Given_White_:0.0),here_given_black(OVERRIDE:Here_Given_Black_:0.0),here_given_aian(OVERRIDE:Here_Given_American_Indian_Alaska_Native_:0.0),here_given_api(OVERRIDE:Here_Given_Asian_Pacific_Islander_:0.0),here_given_mult_other(OVERRIDE:Here_Given_Multiracial_:0.0),here_given_hispanic(OVERRIDE:Here_Given_Hispanic_:0.0),statefips10(DEFAULT:State_Fips10_:\'\'),countyfips10(DEFAULT:County_Fips10_:\'\'),tractfips10(DEFAULT:Tract_Fips10_:\'\'),blockgroupfips10(DEFAULT:Block_Group_Fips10_:0),totalpopulation(DEFAULT:Total_Population_:0),hispanictotal(DEFAULT:Hispanic_Total_:0),nonhispanictotal(DEFAULT:Non_Hispanic_Total_:0),nonhispanicwhitealone(DEFAULT:Non_Hispanic_White_Alone_:0),nonhispanicblackalone(DEFAULT:Non_Hispanic_Black_Alone_:0),nonhispanicamericanindianalaskanativealone(DEFAULT:Non_Hispanic_American_Indian_Alaska_Native_Alone_:0),nonhispanicasianpacificislanderalone(DEFAULT:Non_Hispanic_Asian_Pacific_Islander_Alone_:0),nonhispanicotheralone(DEFAULT:Non_Hispanic_Other_Alone_:0),nonhispanicmultiracialalone(DEFAULT:Non_Hispanic_Multiracial_Alone_:0),nonhispanicwhiteother(DEFAULT:Non_Hispanic_White_Other_:0),nonhispanicblackother(DEFAULT:Non_Hispanic_Black_Other_:0),nonhispanicamericanindianalaskanativeother(DEFAULT:Non_Hispanic_American_Indian_Alaska_Native_Other_:0),nonhispanicasianother(DEFAULT:Non_Hispanic_Asian_Other_:0),nonhispanicasianpacificislanderother(DEFAULT:Non_Hispanic_Asian_Pacific_Islander_Other_:0),nonhispanicasianhawaiianpacificislanderother(DEFAULT:Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_:0),medianvaluation(DEFAULT:Median_Valuation_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault,Lookup,TRIM((STRING)LEFT.geoind) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_files_NonFCRA_DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault'));
  SHARED __Mapping1 := 'UID(DEFAULT:UID),geoid10_blkgrp(OVERRIDE:Geo_Link_:\'\'),is_latest(OVERRIDE:Is_Latest_),geopercentwhite(DEFAULT:Geo_Percent_White_:0.0),geopercentblack(DEFAULT:Geo_Percent_Black_:0.0),geopercentamericanindianalaskanative(DEFAULT:Geo_Percent_American_Indian_Alaska_Native_:0.0),geopercentasianpacificislander(DEFAULT:Geo_Percent_Asian_Pacific_Islander_:0.0),geopercentmultiracial(DEFAULT:Geo_Percent_Multiracial_:0.0),geopercenthispanic(DEFAULT:Geo_Percent_Hispanic_:0.0),here(DEFAULT:Here_:0.0),heregivenwhite(DEFAULT:Here_Given_White_:0.0),heregivenblack(DEFAULT:Here_Given_Black_:0.0),heregivenamericanindianalaskanative(DEFAULT:Here_Given_American_Indian_Alaska_Native_:0.0),heregivenasianpacificislander(DEFAULT:Here_Given_Asian_Pacific_Islander_:0.0),heregivenmultiracial(DEFAULT:Here_Given_Multiracial_:0.0),heregivenhispanic(DEFAULT:Here_Given_Hispanic_:0.0),state_fips10(OVERRIDE:State_Fips10_:\'\'),county_fips10(OVERRIDE:County_Fips10_:\'\'),tract_fips10(OVERRIDE:Tract_Fips10_:\'\'),blkgrp_fips10(OVERRIDE:Block_Group_Fips10_:0),total_pop(OVERRIDE:Total_Population_:0),hispanic_total(OVERRIDE:Hispanic_Total_:0),non_hispanic_total(OVERRIDE:Non_Hispanic_Total_:0),nh_white_alone(OVERRIDE:Non_Hispanic_White_Alone_:0),nh_black_alone(OVERRIDE:Non_Hispanic_Black_Alone_:0),nh_aian_alone(OVERRIDE:Non_Hispanic_American_Indian_Alaska_Native_Alone_:0),nh_api_alone(OVERRIDE:Non_Hispanic_Asian_Pacific_Islander_Alone_:0),nh_other_alone(OVERRIDE:Non_Hispanic_Other_Alone_:0),nh_mult_total(OVERRIDE:Non_Hispanic_Multiracial_Alone_:0),nh_white_other(OVERRIDE:Non_Hispanic_White_Other_:0),nh_black_other(OVERRIDE:Non_Hispanic_Black_Other_:0),nh_aian_other(OVERRIDE:Non_Hispanic_American_Indian_Alaska_Native_Other_:0),nh_asian_hpi(OVERRIDE:Non_Hispanic_Asian_Other_:0),nh_api_other(OVERRIDE:Non_Hispanic_Asian_Pacific_Islander_Other_:0),nh_asian_hpi_other(OVERRIDE:Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_:0),medianvaluation(DEFAULT:Median_Valuation_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault,Lookup,TRIM((STRING)LEFT.geoid10_blkgrp) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_files_NonFCRA_DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault'));
  SHARED Date_First_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping2 := 'UID(DEFAULT:UID),fips_geo_12(OVERRIDE:Geo_Link_:\'\'),islatest(DEFAULT:Is_Latest_),geopercentwhite(DEFAULT:Geo_Percent_White_:0.0),geopercentblack(DEFAULT:Geo_Percent_Black_:0.0),geopercentamericanindianalaskanative(DEFAULT:Geo_Percent_American_Indian_Alaska_Native_:0.0),geopercentasianpacificislander(DEFAULT:Geo_Percent_Asian_Pacific_Islander_:0.0),geopercentmultiracial(DEFAULT:Geo_Percent_Multiracial_:0.0),geopercenthispanic(DEFAULT:Geo_Percent_Hispanic_:0.0),here(DEFAULT:Here_:0.0),heregivenwhite(DEFAULT:Here_Given_White_:0.0),heregivenblack(DEFAULT:Here_Given_Black_:0.0),heregivenamericanindianalaskanative(DEFAULT:Here_Given_American_Indian_Alaska_Native_:0.0),heregivenasianpacificislander(DEFAULT:Here_Given_Asian_Pacific_Islander_:0.0),heregivenmultiracial(DEFAULT:Here_Given_Multiracial_:0.0),heregivenhispanic(DEFAULT:Here_Given_Hispanic_:0.0),statefips10(DEFAULT:State_Fips10_:\'\'),countyfips10(DEFAULT:County_Fips10_:\'\'),tractfips10(DEFAULT:Tract_Fips10_:\'\'),blockgroupfips10(DEFAULT:Block_Group_Fips10_:0),totalpopulation(DEFAULT:Total_Population_:0),hispanictotal(DEFAULT:Hispanic_Total_:0),nonhispanictotal(DEFAULT:Non_Hispanic_Total_:0),nonhispanicwhitealone(DEFAULT:Non_Hispanic_White_Alone_:0),nonhispanicblackalone(DEFAULT:Non_Hispanic_Black_Alone_:0),nonhispanicamericanindianalaskanativealone(DEFAULT:Non_Hispanic_American_Indian_Alaska_Native_Alone_:0),nonhispanicasianpacificislanderalone(DEFAULT:Non_Hispanic_Asian_Pacific_Islander_Alone_:0),nonhispanicotheralone(DEFAULT:Non_Hispanic_Other_Alone_:0),nonhispanicmultiracialalone(DEFAULT:Non_Hispanic_Multiracial_Alone_:0),nonhispanicwhiteother(DEFAULT:Non_Hispanic_White_Other_:0),nonhispanicblackother(DEFAULT:Non_Hispanic_Black_Other_:0),nonhispanicamericanindianalaskanativeother(DEFAULT:Non_Hispanic_American_Indian_Alaska_Native_Other_:0),nonhispanicasianother(DEFAULT:Non_Hispanic_Asian_Other_:0),nonhispanicasianpacificislanderother(DEFAULT:Non_Hispanic_Asian_Pacific_Islander_Other_:0),nonhispanicasianhawaiianpacificislanderother(DEFAULT:Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_:0),median_valuation(OVERRIDE:Median_Valuation_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),history_date(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_2Rule),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Out := RECORD
    RECORDOF(PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d2_UID_Mapped := JOIN(__d2_KELfiltered,Lookup,TRIM((STRING)LEFT.fips_geo_12) = RIGHT.KeyVal,TRANSFORM(__d2_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_files_NonFCRA_AVM_V2__Key_AVM_Medians_Vault_Invalid := __d2_UID_Mapped(UID = 0);
  SHARED __d2_Prefiltered := __d2_UID_Mapped(UID <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault'));
  SHARED __Mapping3 := 'UID(DEFAULT:UID),geoind(OVERRIDE:Geo_Link_:\'\'),is_latest(OVERRIDE:Is_Latest_),geo_pr_white(OVERRIDE:Geo_Percent_White_:0.0),geo_pr_black(OVERRIDE:Geo_Percent_Black_:0.0),geo_pr_aian(OVERRIDE:Geo_Percent_American_Indian_Alaska_Native_:0.0),geo_pr_api(OVERRIDE:Geo_Percent_Asian_Pacific_Islander_:0.0),geo_pr_mult_other(OVERRIDE:Geo_Percent_Multiracial_:0.0),geo_pr_hispanic(OVERRIDE:Geo_Percent_Hispanic_:0.0),here(OVERRIDE:Here_:0.0),here_given_white(OVERRIDE:Here_Given_White_:0.0),here_given_black(OVERRIDE:Here_Given_Black_:0.0),here_given_aian(OVERRIDE:Here_Given_American_Indian_Alaska_Native_:0.0),here_given_api(OVERRIDE:Here_Given_Asian_Pacific_Islander_:0.0),here_given_mult_other(OVERRIDE:Here_Given_Multiracial_:0.0),here_given_hispanic(OVERRIDE:Here_Given_Hispanic_:0.0),statefips10(DEFAULT:State_Fips10_:\'\'),countyfips10(DEFAULT:County_Fips10_:\'\'),tractfips10(DEFAULT:Tract_Fips10_:\'\'),blockgroupfips10(DEFAULT:Block_Group_Fips10_:0),totalpopulation(DEFAULT:Total_Population_:0),hispanictotal(DEFAULT:Hispanic_Total_:0),nonhispanictotal(DEFAULT:Non_Hispanic_Total_:0),nonhispanicwhitealone(DEFAULT:Non_Hispanic_White_Alone_:0),nonhispanicblackalone(DEFAULT:Non_Hispanic_Black_Alone_:0),nonhispanicamericanindianalaskanativealone(DEFAULT:Non_Hispanic_American_Indian_Alaska_Native_Alone_:0),nonhispanicasianpacificislanderalone(DEFAULT:Non_Hispanic_Asian_Pacific_Islander_Alone_:0),nonhispanicotheralone(DEFAULT:Non_Hispanic_Other_Alone_:0),nonhispanicmultiracialalone(DEFAULT:Non_Hispanic_Multiracial_Alone_:0),nonhispanicwhiteother(DEFAULT:Non_Hispanic_White_Other_:0),nonhispanicblackother(DEFAULT:Non_Hispanic_Black_Other_:0),nonhispanicamericanindianalaskanativeother(DEFAULT:Non_Hispanic_American_Indian_Alaska_Native_Other_:0),nonhispanicasianother(DEFAULT:Non_Hispanic_Asian_Other_:0),nonhispanicasianpacificislanderother(DEFAULT:Non_Hispanic_Asian_Pacific_Islander_Other_:0),nonhispanicasianhawaiianpacificislanderother(DEFAULT:Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_:0),medianvaluation(DEFAULT:Median_Valuation_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d3_Out := RECORD
    RECORDOF(PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d3_UID_Mapped := JOIN(PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault,Lookup,TRIM((STRING)LEFT.geoind) = RIGHT.KeyVal,TRANSFORM(__d3_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_files_FCRA_DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault_Invalid := __d3_UID_Mapped(UID = 0);
  SHARED __d3_Prefiltered := __d3_UID_Mapped(UID <> 0);
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault'));
  SHARED __Mapping4 := 'UID(DEFAULT:UID),geoid10_blkgrp(OVERRIDE:Geo_Link_:\'\'),is_latest(OVERRIDE:Is_Latest_),geopercentwhite(DEFAULT:Geo_Percent_White_:0.0),geopercentblack(DEFAULT:Geo_Percent_Black_:0.0),geopercentamericanindianalaskanative(DEFAULT:Geo_Percent_American_Indian_Alaska_Native_:0.0),geopercentasianpacificislander(DEFAULT:Geo_Percent_Asian_Pacific_Islander_:0.0),geopercentmultiracial(DEFAULT:Geo_Percent_Multiracial_:0.0),geopercenthispanic(DEFAULT:Geo_Percent_Hispanic_:0.0),here(DEFAULT:Here_:0.0),heregivenwhite(DEFAULT:Here_Given_White_:0.0),heregivenblack(DEFAULT:Here_Given_Black_:0.0),heregivenamericanindianalaskanative(DEFAULT:Here_Given_American_Indian_Alaska_Native_:0.0),heregivenasianpacificislander(DEFAULT:Here_Given_Asian_Pacific_Islander_:0.0),heregivenmultiracial(DEFAULT:Here_Given_Multiracial_:0.0),heregivenhispanic(DEFAULT:Here_Given_Hispanic_:0.0),state_fips10(OVERRIDE:State_Fips10_:\'\'),county_fips10(OVERRIDE:County_Fips10_:\'\'),tract_fips10(OVERRIDE:Tract_Fips10_:\'\'),blkgrp_fips10(OVERRIDE:Block_Group_Fips10_:0),total_pop(OVERRIDE:Total_Population_:0),hispanic_total(OVERRIDE:Hispanic_Total_:0),non_hispanic_total(OVERRIDE:Non_Hispanic_Total_:0),nh_white_alone(OVERRIDE:Non_Hispanic_White_Alone_:0),nh_black_alone(OVERRIDE:Non_Hispanic_Black_Alone_:0),nh_aian_alone(OVERRIDE:Non_Hispanic_American_Indian_Alaska_Native_Alone_:0),nh_api_alone(OVERRIDE:Non_Hispanic_Asian_Pacific_Islander_Alone_:0),nh_other_alone(OVERRIDE:Non_Hispanic_Other_Alone_:0),nh_mult_total(OVERRIDE:Non_Hispanic_Multiracial_Alone_:0),nh_white_other(OVERRIDE:Non_Hispanic_White_Other_:0),nh_black_other(OVERRIDE:Non_Hispanic_Black_Other_:0),nh_aian_other(OVERRIDE:Non_Hispanic_American_Indian_Alaska_Native_Other_:0),nh_asian_hpi(OVERRIDE:Non_Hispanic_Asian_Other_:0),nh_api_other(OVERRIDE:Non_Hispanic_Asian_Pacific_Islander_Other_:0),nh_asian_hpi_other(OVERRIDE:Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_:0),medianvaluation(DEFAULT:Median_Valuation_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d4_Out := RECORD
    RECORDOF(PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d4_UID_Mapped := JOIN(PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault,Lookup,TRIM((STRING)LEFT.geoid10_blkgrp) = RIGHT.KeyVal,TRANSFORM(__d4_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_files_FCRA_DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault_Invalid := __d4_UID_Mapped(UID = 0);
  SHARED __d4_Prefiltered := __d4_UID_Mapped(UID <> 0);
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault'));
  SHARED Date_First_Seen_5Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping5 := 'UID(DEFAULT:UID),fips_geo_12(OVERRIDE:Geo_Link_:\'\'),islatest(DEFAULT:Is_Latest_),geopercentwhite(DEFAULT:Geo_Percent_White_:0.0),geopercentblack(DEFAULT:Geo_Percent_Black_:0.0),geopercentamericanindianalaskanative(DEFAULT:Geo_Percent_American_Indian_Alaska_Native_:0.0),geopercentasianpacificislander(DEFAULT:Geo_Percent_Asian_Pacific_Islander_:0.0),geopercentmultiracial(DEFAULT:Geo_Percent_Multiracial_:0.0),geopercenthispanic(DEFAULT:Geo_Percent_Hispanic_:0.0),here(DEFAULT:Here_:0.0),heregivenwhite(DEFAULT:Here_Given_White_:0.0),heregivenblack(DEFAULT:Here_Given_Black_:0.0),heregivenamericanindianalaskanative(DEFAULT:Here_Given_American_Indian_Alaska_Native_:0.0),heregivenasianpacificislander(DEFAULT:Here_Given_Asian_Pacific_Islander_:0.0),heregivenmultiracial(DEFAULT:Here_Given_Multiracial_:0.0),heregivenhispanic(DEFAULT:Here_Given_Hispanic_:0.0),statefips10(DEFAULT:State_Fips10_:\'\'),countyfips10(DEFAULT:County_Fips10_:\'\'),tractfips10(DEFAULT:Tract_Fips10_:\'\'),blockgroupfips10(DEFAULT:Block_Group_Fips10_:0),totalpopulation(DEFAULT:Total_Population_:0),hispanictotal(DEFAULT:Hispanic_Total_:0),nonhispanictotal(DEFAULT:Non_Hispanic_Total_:0),nonhispanicwhitealone(DEFAULT:Non_Hispanic_White_Alone_:0),nonhispanicblackalone(DEFAULT:Non_Hispanic_Black_Alone_:0),nonhispanicamericanindianalaskanativealone(DEFAULT:Non_Hispanic_American_Indian_Alaska_Native_Alone_:0),nonhispanicasianpacificislanderalone(DEFAULT:Non_Hispanic_Asian_Pacific_Islander_Alone_:0),nonhispanicotheralone(DEFAULT:Non_Hispanic_Other_Alone_:0),nonhispanicmultiracialalone(DEFAULT:Non_Hispanic_Multiracial_Alone_:0),nonhispanicwhiteother(DEFAULT:Non_Hispanic_White_Other_:0),nonhispanicblackother(DEFAULT:Non_Hispanic_Black_Other_:0),nonhispanicamericanindianalaskanativeother(DEFAULT:Non_Hispanic_American_Indian_Alaska_Native_Other_:0),nonhispanicasianother(DEFAULT:Non_Hispanic_Asian_Other_:0),nonhispanicasianpacificislanderother(DEFAULT:Non_Hispanic_Asian_Pacific_Islander_Other_:0),nonhispanicasianhawaiianpacificislanderother(DEFAULT:Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_:0),median_valuation(OVERRIDE:Median_Valuation_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),history_date(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_5Rule),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d5_Out := RECORD
    RECORDOF(PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d5_UID_Mapped := JOIN(__d5_KELfiltered,Lookup,TRIM((STRING)LEFT.fips_geo_12) = RIGHT.KeyVal,TRANSFORM(__d5_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_files_FCRA_AVM_V2__Key_AVM_Medians_FCRA_Vault_Invalid := __d5_UID_Mapped(UID = 0);
  SHARED __d5_Prefiltered := __d5_UID_Mapped(UID <> 0);
  SHARED __d5 := __SourceFilter(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5;
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
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_files_NonFCRA_DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault_Invalid),COUNT(PublicRecords_KEL_files_NonFCRA_DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault_Invalid),COUNT(PublicRecords_KEL_files_NonFCRA_AVM_V2__Key_AVM_Medians_Vault_Invalid),COUNT(PublicRecords_KEL_files_FCRA_DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault_Invalid),COUNT(PublicRecords_KEL_files_FCRA_DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault_Invalid),COUNT(PublicRecords_KEL_files_FCRA_AVM_V2__Key_AVM_Medians_FCRA_Vault_Invalid),COUNT(Geo_Link__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_files_NonFCRA_DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault_Invalid,KEL.typ.int PublicRecords_KEL_files_NonFCRA_DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault_Invalid,KEL.typ.int PublicRecords_KEL_files_NonFCRA_AVM_V2__Key_AVM_Medians_Vault_Invalid,KEL.typ.int PublicRecords_KEL_files_FCRA_DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault_Invalid,KEL.typ.int PublicRecords_KEL_files_FCRA_DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault_Invalid,KEL.typ.int PublicRecords_KEL_files_FCRA_AVM_V2__Key_AVM_Medians_FCRA_Vault_Invalid,KEL.typ.int Geo_Link__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','UID',COUNT(PublicRecords_KEL_files_NonFCRA_DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault_Invalid),COUNT(__d0)},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','geoind',COUNT(__d0(__NL(Geo_Link_))),COUNT(__d0(__NN(Geo_Link_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','is_latest',COUNT(__d0(__NL(Is_Latest_))),COUNT(__d0(__NN(Is_Latest_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','geo_pr_white',COUNT(__d0(__NL(Geo_Percent_White_))),COUNT(__d0(__NN(Geo_Percent_White_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','geo_pr_black',COUNT(__d0(__NL(Geo_Percent_Black_))),COUNT(__d0(__NN(Geo_Percent_Black_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','geo_pr_aian',COUNT(__d0(__NL(Geo_Percent_American_Indian_Alaska_Native_))),COUNT(__d0(__NN(Geo_Percent_American_Indian_Alaska_Native_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','geo_pr_api',COUNT(__d0(__NL(Geo_Percent_Asian_Pacific_Islander_))),COUNT(__d0(__NN(Geo_Percent_Asian_Pacific_Islander_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','geo_pr_mult_other',COUNT(__d0(__NL(Geo_Percent_Multiracial_))),COUNT(__d0(__NN(Geo_Percent_Multiracial_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','geo_pr_hispanic',COUNT(__d0(__NL(Geo_Percent_Hispanic_))),COUNT(__d0(__NN(Geo_Percent_Hispanic_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','here',COUNT(__d0(__NL(Here_))),COUNT(__d0(__NN(Here_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','here_given_white',COUNT(__d0(__NL(Here_Given_White_))),COUNT(__d0(__NN(Here_Given_White_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','here_given_black',COUNT(__d0(__NL(Here_Given_Black_))),COUNT(__d0(__NN(Here_Given_Black_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','here_given_aian',COUNT(__d0(__NL(Here_Given_American_Indian_Alaska_Native_))),COUNT(__d0(__NN(Here_Given_American_Indian_Alaska_Native_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','here_given_api',COUNT(__d0(__NL(Here_Given_Asian_Pacific_Islander_))),COUNT(__d0(__NN(Here_Given_Asian_Pacific_Islander_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','here_given_mult_other',COUNT(__d0(__NL(Here_Given_Multiracial_))),COUNT(__d0(__NN(Here_Given_Multiracial_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','here_given_hispanic',COUNT(__d0(__NL(Here_Given_Hispanic_))),COUNT(__d0(__NN(Here_Given_Hispanic_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','StateFips10',COUNT(__d0(__NL(State_Fips10_))),COUNT(__d0(__NN(State_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','CountyFips10',COUNT(__d0(__NL(County_Fips10_))),COUNT(__d0(__NN(County_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','TractFips10',COUNT(__d0(__NL(Tract_Fips10_))),COUNT(__d0(__NN(Tract_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','BlockGroupFips10',COUNT(__d0(__NL(Block_Group_Fips10_))),COUNT(__d0(__NN(Block_Group_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','TotalPopulation',COUNT(__d0(__NL(Total_Population_))),COUNT(__d0(__NN(Total_Population_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','HispanicTotal',COUNT(__d0(__NL(Hispanic_Total_))),COUNT(__d0(__NN(Hispanic_Total_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicTotal',COUNT(__d0(__NL(Non_Hispanic_Total_))),COUNT(__d0(__NN(Non_Hispanic_Total_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicWhiteAlone',COUNT(__d0(__NL(Non_Hispanic_White_Alone_))),COUNT(__d0(__NN(Non_Hispanic_White_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicBlackAlone',COUNT(__d0(__NL(Non_Hispanic_Black_Alone_))),COUNT(__d0(__NN(Non_Hispanic_Black_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicAmericanIndianAlaskaNativeAlone',COUNT(__d0(__NL(Non_Hispanic_American_Indian_Alaska_Native_Alone_))),COUNT(__d0(__NN(Non_Hispanic_American_Indian_Alaska_Native_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicAsianPacificIslanderAlone',COUNT(__d0(__NL(Non_Hispanic_Asian_Pacific_Islander_Alone_))),COUNT(__d0(__NN(Non_Hispanic_Asian_Pacific_Islander_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicOtherAlone',COUNT(__d0(__NL(Non_Hispanic_Other_Alone_))),COUNT(__d0(__NN(Non_Hispanic_Other_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicMultiracialAlone',COUNT(__d0(__NL(Non_Hispanic_Multiracial_Alone_))),COUNT(__d0(__NN(Non_Hispanic_Multiracial_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicWhiteOther',COUNT(__d0(__NL(Non_Hispanic_White_Other_))),COUNT(__d0(__NN(Non_Hispanic_White_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicBlackOther',COUNT(__d0(__NL(Non_Hispanic_Black_Other_))),COUNT(__d0(__NN(Non_Hispanic_Black_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicAmericanIndianAlaskaNativeOther',COUNT(__d0(__NL(Non_Hispanic_American_Indian_Alaska_Native_Other_))),COUNT(__d0(__NN(Non_Hispanic_American_Indian_Alaska_Native_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicAsianOther',COUNT(__d0(__NL(Non_Hispanic_Asian_Other_))),COUNT(__d0(__NN(Non_Hispanic_Asian_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicAsianPacificIslanderOther',COUNT(__d0(__NL(Non_Hispanic_Asian_Pacific_Islander_Other_))),COUNT(__d0(__NN(Non_Hispanic_Asian_Pacific_Islander_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicAsianHawaiianPacificIslanderOther',COUNT(__d0(__NL(Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_))),COUNT(__d0(__NN(Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','MedianValuation',COUNT(__d0(__NL(Median_Valuation_))),COUNT(__d0(__NN(Median_Valuation_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','UID',COUNT(PublicRecords_KEL_files_NonFCRA_DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault_Invalid),COUNT(__d1)},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','geoid10_blkgrp',COUNT(__d1(__NL(Geo_Link_))),COUNT(__d1(__NN(Geo_Link_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','is_latest',COUNT(__d1(__NL(Is_Latest_))),COUNT(__d1(__NN(Is_Latest_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','GeoPercentWhite',COUNT(__d1(__NL(Geo_Percent_White_))),COUNT(__d1(__NN(Geo_Percent_White_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','GeoPercentBlack',COUNT(__d1(__NL(Geo_Percent_Black_))),COUNT(__d1(__NN(Geo_Percent_Black_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','GeoPercentAmericanIndianAlaskaNative',COUNT(__d1(__NL(Geo_Percent_American_Indian_Alaska_Native_))),COUNT(__d1(__NN(Geo_Percent_American_Indian_Alaska_Native_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','GeoPercentAsianPacificIslander',COUNT(__d1(__NL(Geo_Percent_Asian_Pacific_Islander_))),COUNT(__d1(__NN(Geo_Percent_Asian_Pacific_Islander_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','GeoPercentMultiracial',COUNT(__d1(__NL(Geo_Percent_Multiracial_))),COUNT(__d1(__NN(Geo_Percent_Multiracial_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','GeoPercentHispanic',COUNT(__d1(__NL(Geo_Percent_Hispanic_))),COUNT(__d1(__NN(Geo_Percent_Hispanic_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','Here',COUNT(__d1(__NL(Here_))),COUNT(__d1(__NN(Here_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','HereGivenWhite',COUNT(__d1(__NL(Here_Given_White_))),COUNT(__d1(__NN(Here_Given_White_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','HereGivenBlack',COUNT(__d1(__NL(Here_Given_Black_))),COUNT(__d1(__NN(Here_Given_Black_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','HereGivenAmericanIndianAlaskaNative',COUNT(__d1(__NL(Here_Given_American_Indian_Alaska_Native_))),COUNT(__d1(__NN(Here_Given_American_Indian_Alaska_Native_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','HereGivenAsianPacificIslander',COUNT(__d1(__NL(Here_Given_Asian_Pacific_Islander_))),COUNT(__d1(__NN(Here_Given_Asian_Pacific_Islander_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','HereGivenMultiracial',COUNT(__d1(__NL(Here_Given_Multiracial_))),COUNT(__d1(__NN(Here_Given_Multiracial_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','HereGivenHispanic',COUNT(__d1(__NL(Here_Given_Hispanic_))),COUNT(__d1(__NN(Here_Given_Hispanic_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','state_fips10',COUNT(__d1(__NL(State_Fips10_))),COUNT(__d1(__NN(State_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','county_fips10',COUNT(__d1(__NL(County_Fips10_))),COUNT(__d1(__NN(County_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','tract_fips10',COUNT(__d1(__NL(Tract_Fips10_))),COUNT(__d1(__NN(Tract_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','blkgrp_fips10',COUNT(__d1(__NL(Block_Group_Fips10_))),COUNT(__d1(__NN(Block_Group_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','total_pop',COUNT(__d1(__NL(Total_Population_))),COUNT(__d1(__NN(Total_Population_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','hispanic_total',COUNT(__d1(__NL(Hispanic_Total_))),COUNT(__d1(__NN(Hispanic_Total_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','non_hispanic_total',COUNT(__d1(__NL(Non_Hispanic_Total_))),COUNT(__d1(__NN(Non_Hispanic_Total_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','nh_white_alone',COUNT(__d1(__NL(Non_Hispanic_White_Alone_))),COUNT(__d1(__NN(Non_Hispanic_White_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','nh_black_alone',COUNT(__d1(__NL(Non_Hispanic_Black_Alone_))),COUNT(__d1(__NN(Non_Hispanic_Black_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','nh_aian_alone',COUNT(__d1(__NL(Non_Hispanic_American_Indian_Alaska_Native_Alone_))),COUNT(__d1(__NN(Non_Hispanic_American_Indian_Alaska_Native_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','nh_api_alone',COUNT(__d1(__NL(Non_Hispanic_Asian_Pacific_Islander_Alone_))),COUNT(__d1(__NN(Non_Hispanic_Asian_Pacific_Islander_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','nh_other_alone',COUNT(__d1(__NL(Non_Hispanic_Other_Alone_))),COUNT(__d1(__NN(Non_Hispanic_Other_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','nh_mult_total',COUNT(__d1(__NL(Non_Hispanic_Multiracial_Alone_))),COUNT(__d1(__NN(Non_Hispanic_Multiracial_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','nh_white_other',COUNT(__d1(__NL(Non_Hispanic_White_Other_))),COUNT(__d1(__NN(Non_Hispanic_White_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','nh_black_other',COUNT(__d1(__NL(Non_Hispanic_Black_Other_))),COUNT(__d1(__NN(Non_Hispanic_Black_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','nh_aian_other',COUNT(__d1(__NL(Non_Hispanic_American_Indian_Alaska_Native_Other_))),COUNT(__d1(__NN(Non_Hispanic_American_Indian_Alaska_Native_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','nh_asian_hpi',COUNT(__d1(__NL(Non_Hispanic_Asian_Other_))),COUNT(__d1(__NN(Non_Hispanic_Asian_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','nh_api_other',COUNT(__d1(__NL(Non_Hispanic_Asian_Pacific_Islander_Other_))),COUNT(__d1(__NN(Non_Hispanic_Asian_Pacific_Islander_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','nh_asian_hpi_other',COUNT(__d1(__NL(Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_))),COUNT(__d1(__NN(Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','MedianValuation',COUNT(__d1(__NL(Median_Valuation_))),COUNT(__d1(__NN(Median_Valuation_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','UID',COUNT(PublicRecords_KEL_files_NonFCRA_AVM_V2__Key_AVM_Medians_Vault_Invalid),COUNT(__d2)},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','fips_geo_12',COUNT(__d2(__NL(Geo_Link_))),COUNT(__d2(__NN(Geo_Link_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','IsLatest',COUNT(__d2(__NL(Is_Latest_))),COUNT(__d2(__NN(Is_Latest_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','GeoPercentWhite',COUNT(__d2(__NL(Geo_Percent_White_))),COUNT(__d2(__NN(Geo_Percent_White_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','GeoPercentBlack',COUNT(__d2(__NL(Geo_Percent_Black_))),COUNT(__d2(__NN(Geo_Percent_Black_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','GeoPercentAmericanIndianAlaskaNative',COUNT(__d2(__NL(Geo_Percent_American_Indian_Alaska_Native_))),COUNT(__d2(__NN(Geo_Percent_American_Indian_Alaska_Native_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','GeoPercentAsianPacificIslander',COUNT(__d2(__NL(Geo_Percent_Asian_Pacific_Islander_))),COUNT(__d2(__NN(Geo_Percent_Asian_Pacific_Islander_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','GeoPercentMultiracial',COUNT(__d2(__NL(Geo_Percent_Multiracial_))),COUNT(__d2(__NN(Geo_Percent_Multiracial_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','GeoPercentHispanic',COUNT(__d2(__NL(Geo_Percent_Hispanic_))),COUNT(__d2(__NN(Geo_Percent_Hispanic_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','Here',COUNT(__d2(__NL(Here_))),COUNT(__d2(__NN(Here_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','HereGivenWhite',COUNT(__d2(__NL(Here_Given_White_))),COUNT(__d2(__NN(Here_Given_White_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','HereGivenBlack',COUNT(__d2(__NL(Here_Given_Black_))),COUNT(__d2(__NN(Here_Given_Black_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','HereGivenAmericanIndianAlaskaNative',COUNT(__d2(__NL(Here_Given_American_Indian_Alaska_Native_))),COUNT(__d2(__NN(Here_Given_American_Indian_Alaska_Native_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','HereGivenAsianPacificIslander',COUNT(__d2(__NL(Here_Given_Asian_Pacific_Islander_))),COUNT(__d2(__NN(Here_Given_Asian_Pacific_Islander_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','HereGivenMultiracial',COUNT(__d2(__NL(Here_Given_Multiracial_))),COUNT(__d2(__NN(Here_Given_Multiracial_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','HereGivenHispanic',COUNT(__d2(__NL(Here_Given_Hispanic_))),COUNT(__d2(__NN(Here_Given_Hispanic_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','StateFips10',COUNT(__d2(__NL(State_Fips10_))),COUNT(__d2(__NN(State_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','CountyFips10',COUNT(__d2(__NL(County_Fips10_))),COUNT(__d2(__NN(County_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','TractFips10',COUNT(__d2(__NL(Tract_Fips10_))),COUNT(__d2(__NN(Tract_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','BlockGroupFips10',COUNT(__d2(__NL(Block_Group_Fips10_))),COUNT(__d2(__NN(Block_Group_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','TotalPopulation',COUNT(__d2(__NL(Total_Population_))),COUNT(__d2(__NN(Total_Population_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','HispanicTotal',COUNT(__d2(__NL(Hispanic_Total_))),COUNT(__d2(__NN(Hispanic_Total_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','NonHispanicTotal',COUNT(__d2(__NL(Non_Hispanic_Total_))),COUNT(__d2(__NN(Non_Hispanic_Total_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','NonHispanicWhiteAlone',COUNT(__d2(__NL(Non_Hispanic_White_Alone_))),COUNT(__d2(__NN(Non_Hispanic_White_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','NonHispanicBlackAlone',COUNT(__d2(__NL(Non_Hispanic_Black_Alone_))),COUNT(__d2(__NN(Non_Hispanic_Black_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','NonHispanicAmericanIndianAlaskaNativeAlone',COUNT(__d2(__NL(Non_Hispanic_American_Indian_Alaska_Native_Alone_))),COUNT(__d2(__NN(Non_Hispanic_American_Indian_Alaska_Native_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','NonHispanicAsianPacificIslanderAlone',COUNT(__d2(__NL(Non_Hispanic_Asian_Pacific_Islander_Alone_))),COUNT(__d2(__NN(Non_Hispanic_Asian_Pacific_Islander_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','NonHispanicOtherAlone',COUNT(__d2(__NL(Non_Hispanic_Other_Alone_))),COUNT(__d2(__NN(Non_Hispanic_Other_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','NonHispanicMultiracialAlone',COUNT(__d2(__NL(Non_Hispanic_Multiracial_Alone_))),COUNT(__d2(__NN(Non_Hispanic_Multiracial_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','NonHispanicWhiteOther',COUNT(__d2(__NL(Non_Hispanic_White_Other_))),COUNT(__d2(__NN(Non_Hispanic_White_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','NonHispanicBlackOther',COUNT(__d2(__NL(Non_Hispanic_Black_Other_))),COUNT(__d2(__NN(Non_Hispanic_Black_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','NonHispanicAmericanIndianAlaskaNativeOther',COUNT(__d2(__NL(Non_Hispanic_American_Indian_Alaska_Native_Other_))),COUNT(__d2(__NN(Non_Hispanic_American_Indian_Alaska_Native_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','NonHispanicAsianOther',COUNT(__d2(__NL(Non_Hispanic_Asian_Other_))),COUNT(__d2(__NN(Non_Hispanic_Asian_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','NonHispanicAsianPacificIslanderOther',COUNT(__d2(__NL(Non_Hispanic_Asian_Pacific_Islander_Other_))),COUNT(__d2(__NN(Non_Hispanic_Asian_Pacific_Islander_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','NonHispanicAsianHawaiianPacificIslanderOther',COUNT(__d2(__NL(Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_))),COUNT(__d2(__NN(Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','median_valuation',COUNT(__d2(__NL(Median_Valuation_))),COUNT(__d2(__NN(Median_Valuation_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'GeoLink','PublicRecords_KEL.files.NonFCRA.AVM_V2__Key_AVM_Medians_Vault','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','UID',COUNT(PublicRecords_KEL_files_FCRA_DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault_Invalid),COUNT(__d3)},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','geoind',COUNT(__d3(__NL(Geo_Link_))),COUNT(__d3(__NN(Geo_Link_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','is_latest',COUNT(__d3(__NL(Is_Latest_))),COUNT(__d3(__NN(Is_Latest_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','geo_pr_white',COUNT(__d3(__NL(Geo_Percent_White_))),COUNT(__d3(__NN(Geo_Percent_White_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','geo_pr_black',COUNT(__d3(__NL(Geo_Percent_Black_))),COUNT(__d3(__NN(Geo_Percent_Black_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','geo_pr_aian',COUNT(__d3(__NL(Geo_Percent_American_Indian_Alaska_Native_))),COUNT(__d3(__NN(Geo_Percent_American_Indian_Alaska_Native_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','geo_pr_api',COUNT(__d3(__NL(Geo_Percent_Asian_Pacific_Islander_))),COUNT(__d3(__NN(Geo_Percent_Asian_Pacific_Islander_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','geo_pr_mult_other',COUNT(__d3(__NL(Geo_Percent_Multiracial_))),COUNT(__d3(__NN(Geo_Percent_Multiracial_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','geo_pr_hispanic',COUNT(__d3(__NL(Geo_Percent_Hispanic_))),COUNT(__d3(__NN(Geo_Percent_Hispanic_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','here',COUNT(__d3(__NL(Here_))),COUNT(__d3(__NN(Here_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','here_given_white',COUNT(__d3(__NL(Here_Given_White_))),COUNT(__d3(__NN(Here_Given_White_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','here_given_black',COUNT(__d3(__NL(Here_Given_Black_))),COUNT(__d3(__NN(Here_Given_Black_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','here_given_aian',COUNT(__d3(__NL(Here_Given_American_Indian_Alaska_Native_))),COUNT(__d3(__NN(Here_Given_American_Indian_Alaska_Native_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','here_given_api',COUNT(__d3(__NL(Here_Given_Asian_Pacific_Islander_))),COUNT(__d3(__NN(Here_Given_Asian_Pacific_Islander_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','here_given_mult_other',COUNT(__d3(__NL(Here_Given_Multiracial_))),COUNT(__d3(__NN(Here_Given_Multiracial_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','here_given_hispanic',COUNT(__d3(__NL(Here_Given_Hispanic_))),COUNT(__d3(__NN(Here_Given_Hispanic_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','StateFips10',COUNT(__d3(__NL(State_Fips10_))),COUNT(__d3(__NN(State_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','CountyFips10',COUNT(__d3(__NL(County_Fips10_))),COUNT(__d3(__NN(County_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','TractFips10',COUNT(__d3(__NL(Tract_Fips10_))),COUNT(__d3(__NN(Tract_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','BlockGroupFips10',COUNT(__d3(__NL(Block_Group_Fips10_))),COUNT(__d3(__NN(Block_Group_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','TotalPopulation',COUNT(__d3(__NL(Total_Population_))),COUNT(__d3(__NN(Total_Population_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','HispanicTotal',COUNT(__d3(__NL(Hispanic_Total_))),COUNT(__d3(__NN(Hispanic_Total_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicTotal',COUNT(__d3(__NL(Non_Hispanic_Total_))),COUNT(__d3(__NN(Non_Hispanic_Total_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicWhiteAlone',COUNT(__d3(__NL(Non_Hispanic_White_Alone_))),COUNT(__d3(__NN(Non_Hispanic_White_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicBlackAlone',COUNT(__d3(__NL(Non_Hispanic_Black_Alone_))),COUNT(__d3(__NN(Non_Hispanic_Black_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicAmericanIndianAlaskaNativeAlone',COUNT(__d3(__NL(Non_Hispanic_American_Indian_Alaska_Native_Alone_))),COUNT(__d3(__NN(Non_Hispanic_American_Indian_Alaska_Native_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicAsianPacificIslanderAlone',COUNT(__d3(__NL(Non_Hispanic_Asian_Pacific_Islander_Alone_))),COUNT(__d3(__NN(Non_Hispanic_Asian_Pacific_Islander_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicOtherAlone',COUNT(__d3(__NL(Non_Hispanic_Other_Alone_))),COUNT(__d3(__NN(Non_Hispanic_Other_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicMultiracialAlone',COUNT(__d3(__NL(Non_Hispanic_Multiracial_Alone_))),COUNT(__d3(__NN(Non_Hispanic_Multiracial_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicWhiteOther',COUNT(__d3(__NL(Non_Hispanic_White_Other_))),COUNT(__d3(__NN(Non_Hispanic_White_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicBlackOther',COUNT(__d3(__NL(Non_Hispanic_Black_Other_))),COUNT(__d3(__NN(Non_Hispanic_Black_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicAmericanIndianAlaskaNativeOther',COUNT(__d3(__NL(Non_Hispanic_American_Indian_Alaska_Native_Other_))),COUNT(__d3(__NN(Non_Hispanic_American_Indian_Alaska_Native_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicAsianOther',COUNT(__d3(__NL(Non_Hispanic_Asian_Other_))),COUNT(__d3(__NN(Non_Hispanic_Asian_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicAsianPacificIslanderOther',COUNT(__d3(__NL(Non_Hispanic_Asian_Pacific_Islander_Other_))),COUNT(__d3(__NN(Non_Hispanic_Asian_Pacific_Islander_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','NonHispanicAsianHawaiianPacificIslanderOther',COUNT(__d3(__NL(Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_))),COUNT(__d3(__NN(Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','MedianValuation',COUNT(__d3(__NL(Median_Valuation_))),COUNT(__d3(__NN(Median_Valuation_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','HybridArchiveDate',COUNT(__d3(Hybrid_Archive_Date_=0)),COUNT(__d3(Hybrid_Archive_Date_!=0))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18_Vault','VaultDateLastSeen',COUNT(__d3(Vault_Date_Last_Seen_=0)),COUNT(__d3(Vault_Date_Last_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','UID',COUNT(PublicRecords_KEL_files_FCRA_DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault_Invalid),COUNT(__d4)},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','geoid10_blkgrp',COUNT(__d4(__NL(Geo_Link_))),COUNT(__d4(__NN(Geo_Link_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','is_latest',COUNT(__d4(__NL(Is_Latest_))),COUNT(__d4(__NN(Is_Latest_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','GeoPercentWhite',COUNT(__d4(__NL(Geo_Percent_White_))),COUNT(__d4(__NN(Geo_Percent_White_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','GeoPercentBlack',COUNT(__d4(__NL(Geo_Percent_Black_))),COUNT(__d4(__NN(Geo_Percent_Black_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','GeoPercentAmericanIndianAlaskaNative',COUNT(__d4(__NL(Geo_Percent_American_Indian_Alaska_Native_))),COUNT(__d4(__NN(Geo_Percent_American_Indian_Alaska_Native_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','GeoPercentAsianPacificIslander',COUNT(__d4(__NL(Geo_Percent_Asian_Pacific_Islander_))),COUNT(__d4(__NN(Geo_Percent_Asian_Pacific_Islander_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','GeoPercentMultiracial',COUNT(__d4(__NL(Geo_Percent_Multiracial_))),COUNT(__d4(__NN(Geo_Percent_Multiracial_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','GeoPercentHispanic',COUNT(__d4(__NL(Geo_Percent_Hispanic_))),COUNT(__d4(__NN(Geo_Percent_Hispanic_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','Here',COUNT(__d4(__NL(Here_))),COUNT(__d4(__NN(Here_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','HereGivenWhite',COUNT(__d4(__NL(Here_Given_White_))),COUNT(__d4(__NN(Here_Given_White_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','HereGivenBlack',COUNT(__d4(__NL(Here_Given_Black_))),COUNT(__d4(__NN(Here_Given_Black_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','HereGivenAmericanIndianAlaskaNative',COUNT(__d4(__NL(Here_Given_American_Indian_Alaska_Native_))),COUNT(__d4(__NN(Here_Given_American_Indian_Alaska_Native_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','HereGivenAsianPacificIslander',COUNT(__d4(__NL(Here_Given_Asian_Pacific_Islander_))),COUNT(__d4(__NN(Here_Given_Asian_Pacific_Islander_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','HereGivenMultiracial',COUNT(__d4(__NL(Here_Given_Multiracial_))),COUNT(__d4(__NN(Here_Given_Multiracial_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','HereGivenHispanic',COUNT(__d4(__NL(Here_Given_Hispanic_))),COUNT(__d4(__NN(Here_Given_Hispanic_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','state_fips10',COUNT(__d4(__NL(State_Fips10_))),COUNT(__d4(__NN(State_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','county_fips10',COUNT(__d4(__NL(County_Fips10_))),COUNT(__d4(__NN(County_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','tract_fips10',COUNT(__d4(__NL(Tract_Fips10_))),COUNT(__d4(__NN(Tract_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','blkgrp_fips10',COUNT(__d4(__NL(Block_Group_Fips10_))),COUNT(__d4(__NN(Block_Group_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','total_pop',COUNT(__d4(__NL(Total_Population_))),COUNT(__d4(__NN(Total_Population_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','hispanic_total',COUNT(__d4(__NL(Hispanic_Total_))),COUNT(__d4(__NN(Hispanic_Total_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','non_hispanic_total',COUNT(__d4(__NL(Non_Hispanic_Total_))),COUNT(__d4(__NN(Non_Hispanic_Total_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','nh_white_alone',COUNT(__d4(__NL(Non_Hispanic_White_Alone_))),COUNT(__d4(__NN(Non_Hispanic_White_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','nh_black_alone',COUNT(__d4(__NL(Non_Hispanic_Black_Alone_))),COUNT(__d4(__NN(Non_Hispanic_Black_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','nh_aian_alone',COUNT(__d4(__NL(Non_Hispanic_American_Indian_Alaska_Native_Alone_))),COUNT(__d4(__NN(Non_Hispanic_American_Indian_Alaska_Native_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','nh_api_alone',COUNT(__d4(__NL(Non_Hispanic_Asian_Pacific_Islander_Alone_))),COUNT(__d4(__NN(Non_Hispanic_Asian_Pacific_Islander_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','nh_other_alone',COUNT(__d4(__NL(Non_Hispanic_Other_Alone_))),COUNT(__d4(__NN(Non_Hispanic_Other_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','nh_mult_total',COUNT(__d4(__NL(Non_Hispanic_Multiracial_Alone_))),COUNT(__d4(__NN(Non_Hispanic_Multiracial_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','nh_white_other',COUNT(__d4(__NL(Non_Hispanic_White_Other_))),COUNT(__d4(__NN(Non_Hispanic_White_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','nh_black_other',COUNT(__d4(__NL(Non_Hispanic_Black_Other_))),COUNT(__d4(__NN(Non_Hispanic_Black_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','nh_aian_other',COUNT(__d4(__NL(Non_Hispanic_American_Indian_Alaska_Native_Other_))),COUNT(__d4(__NN(Non_Hispanic_American_Indian_Alaska_Native_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','nh_asian_hpi',COUNT(__d4(__NL(Non_Hispanic_Asian_Other_))),COUNT(__d4(__NN(Non_Hispanic_Asian_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','nh_api_other',COUNT(__d4(__NL(Non_Hispanic_Asian_Pacific_Islander_Other_))),COUNT(__d4(__NN(Non_Hispanic_Asian_Pacific_Islander_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','nh_asian_hpi_other',COUNT(__d4(__NL(Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_))),COUNT(__d4(__NN(Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','MedianValuation',COUNT(__d4(__NL(Median_Valuation_))),COUNT(__d4(__NN(Median_Valuation_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','src',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','Archive_Date',COUNT(__d4(Archive___Date_=0)),COUNT(__d4(Archive___Date_!=0))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','HybridArchiveDate',COUNT(__d4(Hybrid_Archive_Date_=0)),COUNT(__d4(Hybrid_Archive_Date_!=0))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.DX_ConsumerFinancialProtectionBureau__Key_BLKGRP_Vault','VaultDateLastSeen',COUNT(__d4(Vault_Date_Last_Seen_=0)),COUNT(__d4(Vault_Date_Last_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','UID',COUNT(PublicRecords_KEL_files_FCRA_AVM_V2__Key_AVM_Medians_FCRA_Vault_Invalid),COUNT(__d5)},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','fips_geo_12',COUNT(__d5(__NL(Geo_Link_))),COUNT(__d5(__NN(Geo_Link_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','IsLatest',COUNT(__d5(__NL(Is_Latest_))),COUNT(__d5(__NN(Is_Latest_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','GeoPercentWhite',COUNT(__d5(__NL(Geo_Percent_White_))),COUNT(__d5(__NN(Geo_Percent_White_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','GeoPercentBlack',COUNT(__d5(__NL(Geo_Percent_Black_))),COUNT(__d5(__NN(Geo_Percent_Black_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','GeoPercentAmericanIndianAlaskaNative',COUNT(__d5(__NL(Geo_Percent_American_Indian_Alaska_Native_))),COUNT(__d5(__NN(Geo_Percent_American_Indian_Alaska_Native_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','GeoPercentAsianPacificIslander',COUNT(__d5(__NL(Geo_Percent_Asian_Pacific_Islander_))),COUNT(__d5(__NN(Geo_Percent_Asian_Pacific_Islander_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','GeoPercentMultiracial',COUNT(__d5(__NL(Geo_Percent_Multiracial_))),COUNT(__d5(__NN(Geo_Percent_Multiracial_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','GeoPercentHispanic',COUNT(__d5(__NL(Geo_Percent_Hispanic_))),COUNT(__d5(__NN(Geo_Percent_Hispanic_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','Here',COUNT(__d5(__NL(Here_))),COUNT(__d5(__NN(Here_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','HereGivenWhite',COUNT(__d5(__NL(Here_Given_White_))),COUNT(__d5(__NN(Here_Given_White_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','HereGivenBlack',COUNT(__d5(__NL(Here_Given_Black_))),COUNT(__d5(__NN(Here_Given_Black_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','HereGivenAmericanIndianAlaskaNative',COUNT(__d5(__NL(Here_Given_American_Indian_Alaska_Native_))),COUNT(__d5(__NN(Here_Given_American_Indian_Alaska_Native_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','HereGivenAsianPacificIslander',COUNT(__d5(__NL(Here_Given_Asian_Pacific_Islander_))),COUNT(__d5(__NN(Here_Given_Asian_Pacific_Islander_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','HereGivenMultiracial',COUNT(__d5(__NL(Here_Given_Multiracial_))),COUNT(__d5(__NN(Here_Given_Multiracial_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','HereGivenHispanic',COUNT(__d5(__NL(Here_Given_Hispanic_))),COUNT(__d5(__NN(Here_Given_Hispanic_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','StateFips10',COUNT(__d5(__NL(State_Fips10_))),COUNT(__d5(__NN(State_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','CountyFips10',COUNT(__d5(__NL(County_Fips10_))),COUNT(__d5(__NN(County_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','TractFips10',COUNT(__d5(__NL(Tract_Fips10_))),COUNT(__d5(__NN(Tract_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','BlockGroupFips10',COUNT(__d5(__NL(Block_Group_Fips10_))),COUNT(__d5(__NN(Block_Group_Fips10_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','TotalPopulation',COUNT(__d5(__NL(Total_Population_))),COUNT(__d5(__NN(Total_Population_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','HispanicTotal',COUNT(__d5(__NL(Hispanic_Total_))),COUNT(__d5(__NN(Hispanic_Total_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','NonHispanicTotal',COUNT(__d5(__NL(Non_Hispanic_Total_))),COUNT(__d5(__NN(Non_Hispanic_Total_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','NonHispanicWhiteAlone',COUNT(__d5(__NL(Non_Hispanic_White_Alone_))),COUNT(__d5(__NN(Non_Hispanic_White_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','NonHispanicBlackAlone',COUNT(__d5(__NL(Non_Hispanic_Black_Alone_))),COUNT(__d5(__NN(Non_Hispanic_Black_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','NonHispanicAmericanIndianAlaskaNativeAlone',COUNT(__d5(__NL(Non_Hispanic_American_Indian_Alaska_Native_Alone_))),COUNT(__d5(__NN(Non_Hispanic_American_Indian_Alaska_Native_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','NonHispanicAsianPacificIslanderAlone',COUNT(__d5(__NL(Non_Hispanic_Asian_Pacific_Islander_Alone_))),COUNT(__d5(__NN(Non_Hispanic_Asian_Pacific_Islander_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','NonHispanicOtherAlone',COUNT(__d5(__NL(Non_Hispanic_Other_Alone_))),COUNT(__d5(__NN(Non_Hispanic_Other_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','NonHispanicMultiracialAlone',COUNT(__d5(__NL(Non_Hispanic_Multiracial_Alone_))),COUNT(__d5(__NN(Non_Hispanic_Multiracial_Alone_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','NonHispanicWhiteOther',COUNT(__d5(__NL(Non_Hispanic_White_Other_))),COUNT(__d5(__NN(Non_Hispanic_White_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','NonHispanicBlackOther',COUNT(__d5(__NL(Non_Hispanic_Black_Other_))),COUNT(__d5(__NN(Non_Hispanic_Black_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','NonHispanicAmericanIndianAlaskaNativeOther',COUNT(__d5(__NL(Non_Hispanic_American_Indian_Alaska_Native_Other_))),COUNT(__d5(__NN(Non_Hispanic_American_Indian_Alaska_Native_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','NonHispanicAsianOther',COUNT(__d5(__NL(Non_Hispanic_Asian_Other_))),COUNT(__d5(__NN(Non_Hispanic_Asian_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','NonHispanicAsianPacificIslanderOther',COUNT(__d5(__NL(Non_Hispanic_Asian_Pacific_Islander_Other_))),COUNT(__d5(__NN(Non_Hispanic_Asian_Pacific_Islander_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','NonHispanicAsianHawaiianPacificIslanderOther',COUNT(__d5(__NL(Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_))),COUNT(__d5(__NN(Non_Hispanic_Asian_Hawaiian_Pacific_Islander_Other_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','median_valuation',COUNT(__d5(__NL(Median_Valuation_))),COUNT(__d5(__NN(Median_Valuation_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','src',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','Archive_Date',COUNT(__d5(Archive___Date_=0)),COUNT(__d5(Archive___Date_!=0))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','HybridArchiveDate',COUNT(__d5(Hybrid_Archive_Date_=0)),COUNT(__d5(Hybrid_Archive_Date_!=0))},
    {'GeoLink','PublicRecords_KEL.files.FCRA.AVM_V2__Key_AVM_Medians_FCRA_Vault','VaultDateLastSeen',COUNT(__d5(Vault_Date_Last_Seen_=0)),COUNT(__d5(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
