//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Address,E_Geo_Link,E_Person,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_Person_Address(CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Unit_Designation_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Postal_City_;
    KEL.typ.nstr Verified_City_;
    KEL.typ.nstr State_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nint Z_I_P4_;
    KEL.typ.nint Address_Rank_;
    KEL.typ.nint Insurance_Source_Count_;
    KEL.typ.nint Property_Source_Count_;
    KEL.typ.nint Utility_Source_Count_;
    KEL.typ.nint Vehicle_Source_Count_;
    KEL.typ.nint D_L_Source_Count_;
    KEL.typ.nint Voter_Source_Count_;
    KEL.typ.nstr Address_Type_;
    KEL.typ.nstr Address_Status_;
    KEL.typ.nstr State_Code_;
    KEL.typ.nstr County_Code_;
    KEL.typ.nstr Latitude_;
    KEL.typ.nstr Longitude_;
    KEL.typ.ntyp(E_Geo_Link().Typ) Geo_Link_I_D_;
    KEL.typ.nstr Geo_Blk_;
    KEL.typ.nstr Geo_Mmatch_;
    KEL.typ.nstr Cart_;
    KEL.typ.nstr C_R_Sort_Sz_;
    KEL.typ.nstr Lot_;
    KEL.typ.nstr Lot_Order_;
    KEL.typ.nstr D_P_B_C_;
    KEL.typ.nstr C_H_K_Digit_;
    KEL.typ.nstr Ace_Fips_St_;
    KEL.typ.nstr Ace_Fips_County_;
    KEL.typ.nstr M_S_A_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool F_D_N_Indicator_;
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
  SHARED __Mapping := 'subject(DEFAULT:Subject_:0),Location_(DEFAULT:Location_:0),primaryrange(DEFAULT:Primary_Range_:\'\'),predirectional(DEFAULT:Predirectional_:\'\'),primaryname(DEFAULT:Primary_Name_:\'\'),suffix(DEFAULT:Suffix_:\'\'),postdirectional(DEFAULT:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),secondaryrange(DEFAULT:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),verifiedcity(DEFAULT:Verified_City_:\'\'),state(DEFAULT:State_),zip5(DEFAULT:Z_I_P5_:0),zip4(DEFAULT:Z_I_P4_),addressrank(DEFAULT:Address_Rank_:0),insurancesourcecount(DEFAULT:Insurance_Source_Count_:0),propertysourcecount(DEFAULT:Property_Source_Count_:0),utilitysourcecount(DEFAULT:Utility_Source_Count_:0),vehiclesourcecount(DEFAULT:Vehicle_Source_Count_:0),dlsourcecount(DEFAULT:D_L_Source_Count_:0),votersourcecount(DEFAULT:Voter_Source_Count_:0),addresstype(DEFAULT:Address_Type_:\'\'),addressstatus(DEFAULT:Address_Status_:\'\'),statecode(DEFAULT:State_Code_:\'\'),countycode(DEFAULT:County_Code_:\'\'),latitude(DEFAULT:Latitude_:\'\'),longitude(DEFAULT:Longitude_:\'\'),Geo_Link_I_D_(DEFAULT:Geo_Link_I_D_:0),geoblk(DEFAULT:Geo_Blk_:\'\'),geommatch(DEFAULT:Geo_Mmatch_:\'\'),cart(DEFAULT:Cart_:\'\'),crsortsz(DEFAULT:C_R_Sort_Sz_:\'\'),lot(DEFAULT:Lot_:\'\'),lotorder(DEFAULT:Lot_Order_:\'\'),dpbc(DEFAULT:D_P_B_C_:\'\'),chkdigit(DEFAULT:C_H_K_Digit_:\'\'),acefipsst(DEFAULT:Ace_Fips_St_:\'\'),acefipscounty(DEFAULT:Ace_Fips_County_:\'\'),msa(DEFAULT:M_S_A_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),fdnindicator(DEFAULT:F_D_N_Indicator_),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'did(OVERRIDE:Subject_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),verifiedcity(DEFAULT:Verified_City_:\'\'),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(DEFAULT:Z_I_P4_),addressrank(DEFAULT:Address_Rank_:0),insurancesourcecount(DEFAULT:Insurance_Source_Count_:0),propertysourcecount(DEFAULT:Property_Source_Count_:0),utilitysourcecount(DEFAULT:Utility_Source_Count_:0),vehiclesourcecount(DEFAULT:Vehicle_Source_Count_:0),dlsourcecount(DEFAULT:D_L_Source_Count_:0),votersourcecount(DEFAULT:Voter_Source_Count_:0),addresstype(DEFAULT:Address_Type_:\'\'),addressstatus(DEFAULT:Address_Status_:\'\'),statecode(DEFAULT:State_Code_:\'\'),countycode(DEFAULT:County_Code_:\'\'),latitude(DEFAULT:Latitude_:\'\'),longitude(DEFAULT:Longitude_:\'\'),Geo_Link_I_D_(DEFAULT:Geo_Link_I_D_:0),geoblk(DEFAULT:Geo_Blk_:\'\'),geommatch(DEFAULT:Geo_Mmatch_:\'\'),cart(DEFAULT:Cart_:\'\'),crsortsz(DEFAULT:C_R_Sort_Sz_:\'\'),lot(DEFAULT:Lot_:\'\'),lotorder(DEFAULT:Lot_Order_:\'\'),dpbc(DEFAULT:D_P_B_C_:\'\'),chkdigit(DEFAULT:C_H_K_Digit_:\'\'),acefipsst(DEFAULT:Ace_Fips_St_:\'\'),acefipscounty(DEFAULT:Ace_Fips_County_:\'\'),msa(DEFAULT:M_S_A_:\'\'),fdnindicator(DEFAULT:F_D_N_Indicator_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_0Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d0_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault((STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)did != 0);
  SHARED __d0_Location__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d0_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault');
  SHARED __d0_Location__Mapped := IF(__d0_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,suffix,postdir,zip,sec_range',PROJECT(__d0_KELfiltered,TRANSFORM(__d0_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_KELfiltered,__d0_Missing_Location__UIDComponents),E_Address(__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d0_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Geo_Link_I_D__Layout := RECORD
    RECORDOF(__d0_Location__Mapped);
    KEL.typ.uid Geo_Link_I_D_;
  END;
  SHARED __d0_Missing_Geo_Link_I_D__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Location__Mapped,'GeoLinkID','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault');
  SHARED __d0_Geo_Link_I_D__Mapped := IF(__d0_Missing_Geo_Link_I_D__UIDComponents = 'GeoLinkID',PROJECT(__d0_Location__Mapped,TRANSFORM(__d0_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Location__Mapped,__d0_Missing_Geo_Link_I_D__UIDComponents),E_Geo_Link(__cfg).Lookup,TRIM((STRING)LEFT.GeoLinkID) = RIGHT.KeyVal,TRANSFORM(__d0_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Prefiltered := __d0_Geo_Link_I_D__Mapped;
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault'),__Mapping0_Transform(LEFT)));
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'did(OVERRIDE:Subject_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),verifiedcity(DEFAULT:Verified_City_:\'\'),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(DEFAULT:Z_I_P4_),addressrank(DEFAULT:Address_Rank_:0),insurancesourcecount(DEFAULT:Insurance_Source_Count_:0),propertysourcecount(DEFAULT:Property_Source_Count_:0),utilitysourcecount(DEFAULT:Utility_Source_Count_:0),vehiclesourcecount(DEFAULT:Vehicle_Source_Count_:0),dlsourcecount(DEFAULT:D_L_Source_Count_:0),votersourcecount(DEFAULT:Voter_Source_Count_:0),addresstype(DEFAULT:Address_Type_:\'\'),addressstatus(DEFAULT:Address_Status_:\'\'),statecode(DEFAULT:State_Code_:\'\'),countycode(DEFAULT:County_Code_:\'\'),latitude(DEFAULT:Latitude_:\'\'),longitude(DEFAULT:Longitude_:\'\'),Geo_Link_I_D_(DEFAULT:Geo_Link_I_D_:0),geoblk(DEFAULT:Geo_Blk_:\'\'),geommatch(DEFAULT:Geo_Mmatch_:\'\'),cart(DEFAULT:Cart_:\'\'),crsortsz(DEFAULT:C_R_Sort_Sz_:\'\'),lot(DEFAULT:Lot_:\'\'),lotorder(DEFAULT:Lot_Order_:\'\'),dpbc(DEFAULT:D_P_B_C_:\'\'),chkdigit(DEFAULT:C_H_K_Digit_:\'\'),acefipsst(DEFAULT:Ace_Fips_St_:\'\'),acefipscounty(DEFAULT:Ace_Fips_County_:\'\'),msa(DEFAULT:M_S_A_:\'\'),fdnindicator(DEFAULT:F_D_N_Indicator_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_1Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d1_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault((STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)did != 0);
  SHARED __d1_Location__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d1_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault');
  SHARED __d1_Location__Mapped := IF(__d1_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,suffix,postdir,zip,sec_range',PROJECT(__d1_KELfiltered,TRANSFORM(__d1_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_KELfiltered,__d1_Missing_Location__UIDComponents),E_Address(__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d1_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d1_Geo_Link_I_D__Layout := RECORD
    RECORDOF(__d1_Location__Mapped);
    KEL.typ.uid Geo_Link_I_D_;
  END;
  SHARED __d1_Missing_Geo_Link_I_D__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_Location__Mapped,'GeoLinkID','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault');
  SHARED __d1_Geo_Link_I_D__Mapped := IF(__d1_Missing_Geo_Link_I_D__UIDComponents = 'GeoLinkID',PROJECT(__d1_Location__Mapped,TRANSFORM(__d1_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_Location__Mapped,__d1_Missing_Geo_Link_I_D__UIDComponents),E_Geo_Link(__cfg).Lookup,TRIM((STRING)LEFT.GeoLinkID) = RIGHT.KeyVal,TRANSFORM(__d1_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d1_Prefiltered := __d1_Geo_Link_I_D__Mapped;
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault'),__Mapping1_Transform(LEFT)));
  SHARED Date_Last_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping2 := 'did(OVERRIDE:Subject_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),verifiedcity(DEFAULT:Verified_City_:\'\'),state(DEFAULT:State_),zip5(DEFAULT:Z_I_P5_:0),zip4(DEFAULT:Z_I_P4_),addressrank(DEFAULT:Address_Rank_:0),insurancesourcecount(DEFAULT:Insurance_Source_Count_:0),propertysourcecount(DEFAULT:Property_Source_Count_:0),utilitysourcecount(DEFAULT:Utility_Source_Count_:0),vehiclesourcecount(DEFAULT:Vehicle_Source_Count_:0),dlsourcecount(DEFAULT:D_L_Source_Count_:0),votersourcecount(DEFAULT:Voter_Source_Count_:0),addresstype(DEFAULT:Address_Type_:\'\'),addressstatus(DEFAULT:Address_Status_:\'\'),statecode(DEFAULT:State_Code_:\'\'),countycode(DEFAULT:County_Code_:\'\'),latitude(DEFAULT:Latitude_:\'\'),longitude(DEFAULT:Longitude_:\'\'),Geo_Link_I_D_(DEFAULT:Geo_Link_I_D_:0),geoblk(DEFAULT:Geo_Blk_:\'\'),geommatch(DEFAULT:Geo_Mmatch_:\'\'),cart(DEFAULT:Cart_:\'\'),crsortsz(DEFAULT:C_R_Sort_Sz_:\'\'),lot(DEFAULT:Lot_:\'\'),lotorder(DEFAULT:Lot_Order_:\'\'),dpbc(DEFAULT:D_P_B_C_:\'\'),chkdigit(DEFAULT:C_H_K_Digit_:\'\'),acefipsst(DEFAULT:Ace_Fips_St_:\'\'),acefipscounty(DEFAULT:Ace_Fips_County_:\'\'),msa(DEFAULT:M_S_A_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),fdnindicator(DEFAULT:F_D_N_Indicator_),source_code(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_2Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_2Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d2_KELfiltered := PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault((UNSIGNED6)did > 0);
  SHARED __d2_Location__Layout := RECORD
    RECORDOF(__d2_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d2_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d2_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,ZIP5,sec_range','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault');
  SHARED __d2_Location__Mapped := IF(__d2_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,suffix,postdir,ZIP5,sec_range',PROJECT(__d2_KELfiltered,TRANSFORM(__d2_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d2_KELfiltered,__d2_Missing_Location__UIDComponents),E_Address(__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.ZIP5) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d2_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d2_Geo_Link_I_D__Layout := RECORD
    RECORDOF(__d2_Location__Mapped);
    KEL.typ.uid Geo_Link_I_D_;
  END;
  SHARED __d2_Missing_Geo_Link_I_D__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d2_Location__Mapped,'GeoLinkID','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault');
  SHARED __d2_Geo_Link_I_D__Mapped := IF(__d2_Missing_Geo_Link_I_D__UIDComponents = 'GeoLinkID',PROJECT(__d2_Location__Mapped,TRANSFORM(__d2_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d2_Location__Mapped,__d2_Missing_Geo_Link_I_D__UIDComponents),E_Geo_Link(__cfg).Lookup,TRIM((STRING)LEFT.GeoLinkID) = RIGHT.KeyVal,TRANSFORM(__d2_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d2_Prefiltered := __d2_Geo_Link_I_D__Mapped;
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault'));
  SHARED Date_First_Seen_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Date_Last_Seen_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping3 := 'did(OVERRIDE:Subject_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),p_city_name(OVERRIDE:Postal_City_),v_city_name(OVERRIDE:Verified_City_:\'\'),state(OVERRIDE:State_),zip5(OVERRIDE:Z_I_P5_:0),zip4(OVERRIDE:Z_I_P4_),addressrank(DEFAULT:Address_Rank_:0),insurancesourcecount(DEFAULT:Insurance_Source_Count_:0),propertysourcecount(DEFAULT:Property_Source_Count_:0),utilitysourcecount(DEFAULT:Utility_Source_Count_:0),vehiclesourcecount(DEFAULT:Vehicle_Source_Count_:0),dlsourcecount(DEFAULT:D_L_Source_Count_:0),votersourcecount(DEFAULT:Voter_Source_Count_:0),addresstype(DEFAULT:Address_Type_:\'\'),addressstatus(DEFAULT:Address_Status_:\'\'),statecode(DEFAULT:State_Code_:\'\'),countycode(DEFAULT:County_Code_:\'\'),geo_lat(OVERRIDE:Latitude_:\'\'),geo_long(OVERRIDE:Longitude_:\'\'),Geo_Link_I_D_(DEFAULT:Geo_Link_I_D_:0),geo_blk(OVERRIDE:Geo_Blk_:\'\'),geo_match(OVERRIDE:Geo_Mmatch_:\'\'),cart(OVERRIDE:Cart_:\'\'),cr_sort_sz(OVERRIDE:C_R_Sort_Sz_:\'\'),lot(OVERRIDE:Lot_:\'\'),lot_order(OVERRIDE:Lot_Order_:\'\'),dpbc(OVERRIDE:D_P_B_C_:\'\'),chk_digit(OVERRIDE:C_H_K_Digit_:\'\'),ace_fips_st(OVERRIDE:Ace_Fips_St_:\'\'),ace_fips_county(OVERRIDE:Ace_Fips_County_:\'\'),msa(OVERRIDE:M_S_A_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),fdnindicator(DEFAULT:F_D_N_Indicator_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_3Rule),datelastseen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_3Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d3_KELfiltered := PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault((UNSIGNED)did != 0 AND (STRING28)prim_name != '' AND (UNSIGNED3)zip5 != 0);
  SHARED __d3_Location__Layout := RECORD
    RECORDOF(__d3_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d3_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d3_KELfiltered,'prim_range,predir,prim_name,addr_suffix,postdir,zip5,sec_range','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault');
  SHARED __d3_Location__Mapped := IF(__d3_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,addr_suffix,postdir,zip5,sec_range',PROJECT(__d3_KELfiltered,TRANSFORM(__d3_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d3_KELfiltered,__d3_Missing_Location__UIDComponents),E_Address(__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip5) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d3_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d3_Geo_Link_I_D__Layout := RECORD
    RECORDOF(__d3_Location__Mapped);
    KEL.typ.uid Geo_Link_I_D_;
  END;
  SHARED __d3_Missing_Geo_Link_I_D__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d3_Location__Mapped,'GeoLinkID','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault');
  SHARED __d3_Geo_Link_I_D__Mapped := IF(__d3_Missing_Geo_Link_I_D__UIDComponents = 'GeoLinkID',PROJECT(__d3_Location__Mapped,TRANSFORM(__d3_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d3_Location__Mapped,__d3_Missing_Geo_Link_I_D__UIDComponents),E_Geo_Link(__cfg).Lookup,TRIM((STRING)LEFT.GeoLinkID) = RIGHT.KeyVal,TRANSFORM(__d3_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d3_Prefiltered := __d3_Geo_Link_I_D__Mapped;
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault'));
  SHARED Date_Last_Seen_4Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_4Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping4 := 's_did(OVERRIDE:Subject_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unit_desig(OVERRIDE:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),v_city_name(OVERRIDE:Postal_City_),verifiedcity(DEFAULT:Verified_City_:\'\'),st(OVERRIDE:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(OVERRIDE:Z_I_P4_),address_history_seq(OVERRIDE:Address_Rank_:0),insurance_source_count(OVERRIDE:Insurance_Source_Count_:0),property_source_count(OVERRIDE:Property_Source_Count_:0),utility_source_count(OVERRIDE:Utility_Source_Count_:0),vehicle_source_count(OVERRIDE:Vehicle_Source_Count_:0),dl_source_count(OVERRIDE:D_L_Source_Count_:0),voter_source_count(OVERRIDE:Voter_Source_Count_:0),addresstype(OVERRIDE:Address_Type_:\'\'),err_stat(OVERRIDE:Address_Status_:\'\'),statecode(OVERRIDE:State_Code_:\'\'),county(OVERRIDE:County_Code_:\'\'),geo_lat(OVERRIDE:Latitude_:\'\'),geo_long(OVERRIDE:Longitude_:\'\'),Geo_Link_I_D_(OVERRIDE:Geo_Link_I_D_:0),geo_blk(OVERRIDE:Geo_Blk_:\'\'),geo_match(OVERRIDE:Geo_Mmatch_:\'\'),cart(DEFAULT:Cart_:\'\'),crsortsz(DEFAULT:C_R_Sort_Sz_:\'\'),lot(DEFAULT:Lot_:\'\'),lotorder(DEFAULT:Lot_Order_:\'\'),dpbc(DEFAULT:D_P_B_C_:\'\'),chkdigit(DEFAULT:C_H_K_Digit_:\'\'),acefipsst(DEFAULT:Ace_Fips_St_:\'\'),acefipscounty(DEFAULT:Ace_Fips_County_:\'\'),msa(DEFAULT:M_S_A_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),fdnindicator(DEFAULT:F_D_N_Indicator_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_4Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_4Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d4_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault((STRING28)prim_name != '' AND (UNSIGNED)zip != 0 AND (UNSIGNED)s_did != 0);
  SHARED __d4_Location__Layout := RECORD
    RECORDOF(__d4_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d4_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d4_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault');
  SHARED __d4_Location__Mapped := IF(__d4_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,suffix,postdir,zip,sec_range',PROJECT(__d4_KELfiltered,TRANSFORM(__d4_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d4_KELfiltered,__d4_Missing_Location__UIDComponents),E_Address(__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d4_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d4_Geo_Link_I_D__Layout := RECORD
    RECORDOF(__d4_Location__Mapped);
    KEL.typ.uid Geo_Link_I_D_;
  END;
  SHARED __d4_Missing_Geo_Link_I_D__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d4_Location__Mapped,'Geo_Link','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault');
  SHARED __d4_Geo_Link_I_D__Mapped := IF(__d4_Missing_Geo_Link_I_D__UIDComponents = 'Geo_Link',PROJECT(__d4_Location__Mapped,TRANSFORM(__d4_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d4_Location__Mapped,__d4_Missing_Geo_Link_I_D__UIDComponents),E_Geo_Link(__cfg).Lookup,TRIM((STRING)LEFT.Geo_Link) = RIGHT.KeyVal,TRANSFORM(__d4_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d4_Prefiltered := __d4_Geo_Link_I_D__Mapped;
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault'));
  SHARED Date_Last_Seen_5Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_5Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping5 := 'did(OVERRIDE:Subject_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),verifiedcity(DEFAULT:Verified_City_:\'\'),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(DEFAULT:Z_I_P4_),addressrank(DEFAULT:Address_Rank_:0),insurancesourcecount(DEFAULT:Insurance_Source_Count_:0),propertysourcecount(DEFAULT:Property_Source_Count_:0),utilitysourcecount(DEFAULT:Utility_Source_Count_:0),vehiclesourcecount(DEFAULT:Vehicle_Source_Count_:0),dlsourcecount(DEFAULT:D_L_Source_Count_:0),votersourcecount(DEFAULT:Voter_Source_Count_:0),addresstype(DEFAULT:Address_Type_:\'\'),addressstatus(DEFAULT:Address_Status_:\'\'),statecode(DEFAULT:State_Code_:\'\'),countycode(DEFAULT:County_Code_:\'\'),latitude(DEFAULT:Latitude_:\'\'),longitude(DEFAULT:Longitude_:\'\'),Geo_Link_I_D_(DEFAULT:Geo_Link_I_D_:0),geoblk(DEFAULT:Geo_Blk_:\'\'),geommatch(DEFAULT:Geo_Mmatch_:\'\'),cart(DEFAULT:Cart_:\'\'),crsortsz(DEFAULT:C_R_Sort_Sz_:\'\'),lot(DEFAULT:Lot_:\'\'),lotorder(DEFAULT:Lot_Order_:\'\'),dpbc(DEFAULT:D_P_B_C_:\'\'),chkdigit(DEFAULT:C_H_K_Digit_:\'\'),acefipsst(DEFAULT:Ace_Fips_St_:\'\'),acefipscounty(DEFAULT:Ace_Fips_County_:\'\'),msa(DEFAULT:M_S_A_:\'\'),fdnindicator(DEFAULT:F_D_N_Indicator_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_5Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_5Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping5_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d5_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault((STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)did != 0);
  SHARED __d5_Location__Layout := RECORD
    RECORDOF(__d5_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d5_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d5_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault');
  SHARED __d5_Location__Mapped := IF(__d5_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,suffix,postdir,zip,sec_range',PROJECT(__d5_KELfiltered,TRANSFORM(__d5_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d5_KELfiltered,__d5_Missing_Location__UIDComponents),E_Address(__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d5_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d5_Geo_Link_I_D__Layout := RECORD
    RECORDOF(__d5_Location__Mapped);
    KEL.typ.uid Geo_Link_I_D_;
  END;
  SHARED __d5_Missing_Geo_Link_I_D__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d5_Location__Mapped,'GeoLinkID','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault');
  SHARED __d5_Geo_Link_I_D__Mapped := IF(__d5_Missing_Geo_Link_I_D__UIDComponents = 'GeoLinkID',PROJECT(__d5_Location__Mapped,TRANSFORM(__d5_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d5_Location__Mapped,__d5_Missing_Geo_Link_I_D__UIDComponents),E_Geo_Link(__cfg).Lookup,TRIM((STRING)LEFT.GeoLinkID) = RIGHT.KeyVal,TRANSFORM(__d5_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d5_Prefiltered := __d5_Geo_Link_I_D__Mapped;
  SHARED __d5 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault'),__Mapping5_Transform(LEFT)));
  SHARED __Mapping6 := 'appended_lexid(OVERRIDE:Subject_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),secondaryrange(DEFAULT:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),verifiedcity(DEFAULT:Verified_City_:\'\'),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(DEFAULT:Z_I_P4_),addressrank(DEFAULT:Address_Rank_:0),insurancesourcecount(DEFAULT:Insurance_Source_Count_:0),propertysourcecount(DEFAULT:Property_Source_Count_:0),utilitysourcecount(DEFAULT:Utility_Source_Count_:0),vehiclesourcecount(DEFAULT:Vehicle_Source_Count_:0),dlsourcecount(DEFAULT:D_L_Source_Count_:0),votersourcecount(DEFAULT:Voter_Source_Count_:0),addresstype(DEFAULT:Address_Type_:\'\'),addressstatus(DEFAULT:Address_Status_:\'\'),statecode(DEFAULT:State_Code_:\'\'),countycode(DEFAULT:County_Code_:\'\'),latitude(DEFAULT:Latitude_:\'\'),longitude(DEFAULT:Longitude_:\'\'),Geo_Link_I_D_(DEFAULT:Geo_Link_I_D_:0),geoblk(DEFAULT:Geo_Blk_:\'\'),geommatch(DEFAULT:Geo_Mmatch_:\'\'),cart(DEFAULT:Cart_:\'\'),crsortsz(DEFAULT:C_R_Sort_Sz_:\'\'),lot(DEFAULT:Lot_:\'\'),lotorder(DEFAULT:Lot_Order_:\'\'),dpbc(DEFAULT:D_P_B_C_:\'\'),chkdigit(DEFAULT:C_H_K_Digit_:\'\'),acefipsst(DEFAULT:Ace_Fips_St_:\'\'),acefipscounty(DEFAULT:Ace_Fips_County_:\'\'),msa(DEFAULT:M_S_A_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping6_Transform(InLayout __r) := TRANSFORM
    SELF.F_D_N_Indicator_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d6_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault((STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)appended_lexid != 0);
  SHARED __d6_Location__Layout := RECORD
    RECORDOF(__d6_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d6_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d6_KELfiltered,'prim_range,predir,prim_name,addr_suffix,postdir,zip,SecondaryRange','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault');
  SHARED __d6_Location__Mapped := IF(__d6_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,addr_suffix,postdir,zip,SecondaryRange',PROJECT(__d6_KELfiltered,TRANSFORM(__d6_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d6_KELfiltered,__d6_Missing_Location__UIDComponents),E_Address(__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.SecondaryRange) = RIGHT.KeyVal,TRANSFORM(__d6_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d6_Geo_Link_I_D__Layout := RECORD
    RECORDOF(__d6_Location__Mapped);
    KEL.typ.uid Geo_Link_I_D_;
  END;
  SHARED __d6_Missing_Geo_Link_I_D__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d6_Location__Mapped,'GeoLinkID','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault');
  SHARED __d6_Geo_Link_I_D__Mapped := IF(__d6_Missing_Geo_Link_I_D__UIDComponents = 'GeoLinkID',PROJECT(__d6_Location__Mapped,TRANSFORM(__d6_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d6_Location__Mapped,__d6_Missing_Geo_Link_I_D__UIDComponents),E_Geo_Link(__cfg).Lookup,TRIM((STRING)LEFT.GeoLinkID) = RIGHT.KeyVal,TRANSFORM(__d6_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d6_Prefiltered := __d6_Geo_Link_I_D__Mapped;
  SHARED __d6 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6,'PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault'),__Mapping6_Transform(LEFT)));
  SHARED __Mapping7 := 'appended_lexid(OVERRIDE:Subject_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),secondaryrange(DEFAULT:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),verifiedcity(DEFAULT:Verified_City_:\'\'),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(DEFAULT:Z_I_P4_),addressrank(DEFAULT:Address_Rank_:0),insurancesourcecount(DEFAULT:Insurance_Source_Count_:0),propertysourcecount(DEFAULT:Property_Source_Count_:0),utilitysourcecount(DEFAULT:Utility_Source_Count_:0),vehiclesourcecount(DEFAULT:Vehicle_Source_Count_:0),dlsourcecount(DEFAULT:D_L_Source_Count_:0),votersourcecount(DEFAULT:Voter_Source_Count_:0),addresstype(DEFAULT:Address_Type_:\'\'),addressstatus(DEFAULT:Address_Status_:\'\'),statecode(DEFAULT:State_Code_:\'\'),countycode(DEFAULT:County_Code_:\'\'),latitude(DEFAULT:Latitude_:\'\'),longitude(DEFAULT:Longitude_:\'\'),Geo_Link_I_D_(DEFAULT:Geo_Link_I_D_:0),geoblk(DEFAULT:Geo_Blk_:\'\'),geommatch(DEFAULT:Geo_Mmatch_:\'\'),cart(DEFAULT:Cart_:\'\'),crsortsz(DEFAULT:C_R_Sort_Sz_:\'\'),lot(DEFAULT:Lot_:\'\'),lotorder(DEFAULT:Lot_Order_:\'\'),dpbc(DEFAULT:D_P_B_C_:\'\'),chkdigit(DEFAULT:C_H_K_Digit_:\'\'),acefipsst(DEFAULT:Ace_Fips_St_:\'\'),acefipscounty(DEFAULT:Ace_Fips_County_:\'\'),msa(DEFAULT:M_S_A_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping7_Transform(InLayout __r) := TRANSFORM
    SELF.F_D_N_Indicator_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d7_KELfiltered := PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault((STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)appended_lexid != 0);
  SHARED __d7_Location__Layout := RECORD
    RECORDOF(__d7_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d7_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d7_KELfiltered,'prim_range,predir,prim_name,addr_suffix,postdir,zip,SecondaryRange','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault');
  SHARED __d7_Location__Mapped := IF(__d7_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,addr_suffix,postdir,zip,SecondaryRange',PROJECT(__d7_KELfiltered,TRANSFORM(__d7_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d7_KELfiltered,__d7_Missing_Location__UIDComponents),E_Address(__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.SecondaryRange) = RIGHT.KeyVal,TRANSFORM(__d7_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d7_Geo_Link_I_D__Layout := RECORD
    RECORDOF(__d7_Location__Mapped);
    KEL.typ.uid Geo_Link_I_D_;
  END;
  SHARED __d7_Missing_Geo_Link_I_D__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d7_Location__Mapped,'GeoLinkID','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault');
  SHARED __d7_Geo_Link_I_D__Mapped := IF(__d7_Missing_Geo_Link_I_D__UIDComponents = 'GeoLinkID',PROJECT(__d7_Location__Mapped,TRANSFORM(__d7_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d7_Location__Mapped,__d7_Missing_Geo_Link_I_D__UIDComponents),E_Geo_Link(__cfg).Lookup,TRIM((STRING)LEFT.GeoLinkID) = RIGHT.KeyVal,TRANSFORM(__d7_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d7_Prefiltered := __d7_Geo_Link_I_D__Mapped;
  SHARED __d7 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d7_Prefiltered,InLayout,__Mapping7,'PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault'),__Mapping7_Transform(LEFT)));
  SHARED Date_Last_Seen_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping8 := 'did(OVERRIDE:Subject_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),verifiedcity(DEFAULT:Verified_City_:\'\'),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(DEFAULT:Z_I_P4_),addressrank(DEFAULT:Address_Rank_:0),insurancesourcecount(DEFAULT:Insurance_Source_Count_:0),propertysourcecount(DEFAULT:Property_Source_Count_:0),utilitysourcecount(DEFAULT:Utility_Source_Count_:0),vehiclesourcecount(DEFAULT:Vehicle_Source_Count_:0),dlsourcecount(DEFAULT:D_L_Source_Count_:0),votersourcecount(DEFAULT:Voter_Source_Count_:0),addresstype(DEFAULT:Address_Type_:\'\'),addressstatus(DEFAULT:Address_Status_:\'\'),statecode(DEFAULT:State_Code_:\'\'),countycode(DEFAULT:County_Code_:\'\'),latitude(DEFAULT:Latitude_:\'\'),longitude(DEFAULT:Longitude_:\'\'),Geo_Link_I_D_(DEFAULT:Geo_Link_I_D_:0),geoblk(DEFAULT:Geo_Blk_:\'\'),geommatch(DEFAULT:Geo_Mmatch_:\'\'),cart(DEFAULT:Cart_:\'\'),crsortsz(DEFAULT:C_R_Sort_Sz_:\'\'),lot(DEFAULT:Lot_:\'\'),lotorder(DEFAULT:Lot_Order_:\'\'),dpbc(DEFAULT:D_P_B_C_:\'\'),chkdigit(DEFAULT:C_H_K_Digit_:\'\'),acefipsst(DEFAULT:Ace_Fips_St_:\'\'),acefipscounty(DEFAULT:Ace_Fips_County_:\'\'),msa(DEFAULT:M_S_A_:\'\'),fdnindicator(DEFAULT:F_D_N_Indicator_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_8Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_8Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping8_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d8_KELfiltered := PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault((STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)did != 0);
  SHARED __d8_Location__Layout := RECORD
    RECORDOF(__d8_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d8_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d8_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault');
  SHARED __d8_Location__Mapped := IF(__d8_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,suffix,postdir,zip,sec_range',PROJECT(__d8_KELfiltered,TRANSFORM(__d8_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d8_KELfiltered,__d8_Missing_Location__UIDComponents),E_Address(__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d8_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d8_Geo_Link_I_D__Layout := RECORD
    RECORDOF(__d8_Location__Mapped);
    KEL.typ.uid Geo_Link_I_D_;
  END;
  SHARED __d8_Missing_Geo_Link_I_D__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d8_Location__Mapped,'GeoLinkID','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault');
  SHARED __d8_Geo_Link_I_D__Mapped := IF(__d8_Missing_Geo_Link_I_D__UIDComponents = 'GeoLinkID',PROJECT(__d8_Location__Mapped,TRANSFORM(__d8_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d8_Location__Mapped,__d8_Missing_Geo_Link_I_D__UIDComponents),E_Geo_Link(__cfg).Lookup,TRIM((STRING)LEFT.GeoLinkID) = RIGHT.KeyVal,TRANSFORM(__d8_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d8_Prefiltered := __d8_Geo_Link_I_D__Mapped;
  SHARED __d8 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d8_Prefiltered,InLayout,__Mapping8,'PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault'),__Mapping8_Transform(LEFT)));
  SHARED Date_Last_Seen_9Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_9Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping9 := 'did(OVERRIDE:Subject_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),verifiedcity(DEFAULT:Verified_City_:\'\'),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(DEFAULT:Z_I_P4_),addressrank(DEFAULT:Address_Rank_:0),insurancesourcecount(DEFAULT:Insurance_Source_Count_:0),propertysourcecount(DEFAULT:Property_Source_Count_:0),utilitysourcecount(DEFAULT:Utility_Source_Count_:0),vehiclesourcecount(DEFAULT:Vehicle_Source_Count_:0),dlsourcecount(DEFAULT:D_L_Source_Count_:0),votersourcecount(DEFAULT:Voter_Source_Count_:0),addresstype(DEFAULT:Address_Type_:\'\'),addressstatus(DEFAULT:Address_Status_:\'\'),statecode(DEFAULT:State_Code_:\'\'),countycode(DEFAULT:County_Code_:\'\'),latitude(DEFAULT:Latitude_:\'\'),longitude(DEFAULT:Longitude_:\'\'),Geo_Link_I_D_(DEFAULT:Geo_Link_I_D_:0),geoblk(DEFAULT:Geo_Blk_:\'\'),geommatch(DEFAULT:Geo_Mmatch_:\'\'),cart(DEFAULT:Cart_:\'\'),crsortsz(DEFAULT:C_R_Sort_Sz_:\'\'),lot(DEFAULT:Lot_:\'\'),lotorder(DEFAULT:Lot_Order_:\'\'),dpbc(DEFAULT:D_P_B_C_:\'\'),chkdigit(DEFAULT:C_H_K_Digit_:\'\'),acefipsst(DEFAULT:Ace_Fips_St_:\'\'),acefipscounty(DEFAULT:Ace_Fips_County_:\'\'),msa(DEFAULT:M_S_A_:\'\'),fdnindicator(DEFAULT:F_D_N_Indicator_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_9Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_9Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping9_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d9_KELfiltered := PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault((STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)did != 0);
  SHARED __d9_Location__Layout := RECORD
    RECORDOF(__d9_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d9_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d9_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault');
  SHARED __d9_Location__Mapped := IF(__d9_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,suffix,postdir,zip,sec_range',PROJECT(__d9_KELfiltered,TRANSFORM(__d9_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d9_KELfiltered,__d9_Missing_Location__UIDComponents),E_Address(__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d9_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d9_Geo_Link_I_D__Layout := RECORD
    RECORDOF(__d9_Location__Mapped);
    KEL.typ.uid Geo_Link_I_D_;
  END;
  SHARED __d9_Missing_Geo_Link_I_D__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d9_Location__Mapped,'GeoLinkID','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault');
  SHARED __d9_Geo_Link_I_D__Mapped := IF(__d9_Missing_Geo_Link_I_D__UIDComponents = 'GeoLinkID',PROJECT(__d9_Location__Mapped,TRANSFORM(__d9_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d9_Location__Mapped,__d9_Missing_Geo_Link_I_D__UIDComponents),E_Geo_Link(__cfg).Lookup,TRIM((STRING)LEFT.GeoLinkID) = RIGHT.KeyVal,TRANSFORM(__d9_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d9_Prefiltered := __d9_Geo_Link_I_D__Mapped;
  SHARED __d9 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d9_Prefiltered,InLayout,__Mapping9,'PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault'),__Mapping9_Transform(LEFT)));
  SHARED Date_Last_Seen_10Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_10Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping10 := 's_did(OVERRIDE:Subject_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unit_desig(OVERRIDE:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),v_city_name(OVERRIDE:Postal_City_),verifiedcity(DEFAULT:Verified_City_:\'\'),st(OVERRIDE:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(OVERRIDE:Z_I_P4_),address_history_seq(OVERRIDE:Address_Rank_:0),insurance_source_count(OVERRIDE:Insurance_Source_Count_:0),property_source_count(OVERRIDE:Property_Source_Count_:0),utility_source_count(OVERRIDE:Utility_Source_Count_:0),vehicle_source_count(OVERRIDE:Vehicle_Source_Count_:0),dl_source_count(OVERRIDE:D_L_Source_Count_:0),voter_source_count(OVERRIDE:Voter_Source_Count_:0),addresstype(OVERRIDE:Address_Type_:\'\'),err_stat(OVERRIDE:Address_Status_:\'\'),statecode(OVERRIDE:State_Code_:\'\'),county(OVERRIDE:County_Code_:\'\'),geo_lat(OVERRIDE:Latitude_:\'\'),geo_long(OVERRIDE:Longitude_:\'\'),Geo_Link_I_D_(OVERRIDE:Geo_Link_I_D_:0),geo_blk(OVERRIDE:Geo_Blk_:\'\'),geo_match(OVERRIDE:Geo_Mmatch_:\'\'),cart(DEFAULT:Cart_:\'\'),crsortsz(DEFAULT:C_R_Sort_Sz_:\'\'),lot(DEFAULT:Lot_:\'\'),lotorder(DEFAULT:Lot_Order_:\'\'),dpbc(DEFAULT:D_P_B_C_:\'\'),chkdigit(DEFAULT:C_H_K_Digit_:\'\'),acefipsst(DEFAULT:Ace_Fips_St_:\'\'),acefipscounty(DEFAULT:Ace_Fips_County_:\'\'),msa(DEFAULT:M_S_A_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),fdnindicator(DEFAULT:F_D_N_Indicator_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_10Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_10Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d10_KELfiltered := PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault((STRING28)prim_name != '' AND (UNSIGNED)zip != 0 AND (UNSIGNED)s_did != 0);
  SHARED __d10_Location__Layout := RECORD
    RECORDOF(__d10_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d10_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d10_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault');
  SHARED __d10_Location__Mapped := IF(__d10_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,suffix,postdir,zip,sec_range',PROJECT(__d10_KELfiltered,TRANSFORM(__d10_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d10_KELfiltered,__d10_Missing_Location__UIDComponents),E_Address(__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d10_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d10_Geo_Link_I_D__Layout := RECORD
    RECORDOF(__d10_Location__Mapped);
    KEL.typ.uid Geo_Link_I_D_;
  END;
  SHARED __d10_Missing_Geo_Link_I_D__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d10_Location__Mapped,'Geo_Link','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault');
  SHARED __d10_Geo_Link_I_D__Mapped := IF(__d10_Missing_Geo_Link_I_D__UIDComponents = 'Geo_Link',PROJECT(__d10_Location__Mapped,TRANSFORM(__d10_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d10_Location__Mapped,__d10_Missing_Geo_Link_I_D__UIDComponents),E_Geo_Link(__cfg).Lookup,TRIM((STRING)LEFT.Geo_Link) = RIGHT.KeyVal,TRANSFORM(__d10_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d10_Prefiltered := __d10_Geo_Link_I_D__Mapped;
  SHARED __d10 := __SourceFilter(KEL.FromFlat.Convert(__d10_Prefiltered,InLayout,__Mapping10,'PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault'));
  SHARED Date_Last_Seen_11Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_11Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping11 := 'did(OVERRIDE:Subject_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),verifiedcity(DEFAULT:Verified_City_:\'\'),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(DEFAULT:Z_I_P4_),addressrank(DEFAULT:Address_Rank_:0),insurancesourcecount(DEFAULT:Insurance_Source_Count_:0),propertysourcecount(DEFAULT:Property_Source_Count_:0),utilitysourcecount(DEFAULT:Utility_Source_Count_:0),vehiclesourcecount(DEFAULT:Vehicle_Source_Count_:0),dlsourcecount(DEFAULT:D_L_Source_Count_:0),votersourcecount(DEFAULT:Voter_Source_Count_:0),addresstype(DEFAULT:Address_Type_:\'\'),addressstatus(DEFAULT:Address_Status_:\'\'),statecode(DEFAULT:State_Code_:\'\'),countycode(DEFAULT:County_Code_:\'\'),latitude(DEFAULT:Latitude_:\'\'),longitude(DEFAULT:Longitude_:\'\'),Geo_Link_I_D_(DEFAULT:Geo_Link_I_D_:0),geoblk(DEFAULT:Geo_Blk_:\'\'),geommatch(DEFAULT:Geo_Mmatch_:\'\'),cart(DEFAULT:Cart_:\'\'),crsortsz(DEFAULT:C_R_Sort_Sz_:\'\'),lot(DEFAULT:Lot_:\'\'),lotorder(DEFAULT:Lot_Order_:\'\'),dpbc(DEFAULT:D_P_B_C_:\'\'),chkdigit(DEFAULT:C_H_K_Digit_:\'\'),acefipsst(DEFAULT:Ace_Fips_St_:\'\'),acefipscounty(DEFAULT:Ace_Fips_County_:\'\'),msa(DEFAULT:M_S_A_:\'\'),fdnindicator(DEFAULT:F_D_N_Indicator_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_11Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_11Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping11_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d11_KELfiltered := PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault((STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)did != 0);
  SHARED __d11_Location__Layout := RECORD
    RECORDOF(__d11_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d11_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d11_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault');
  SHARED __d11_Location__Mapped := IF(__d11_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,suffix,postdir,zip,sec_range',PROJECT(__d11_KELfiltered,TRANSFORM(__d11_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d11_KELfiltered,__d11_Missing_Location__UIDComponents),E_Address(__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d11_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d11_Geo_Link_I_D__Layout := RECORD
    RECORDOF(__d11_Location__Mapped);
    KEL.typ.uid Geo_Link_I_D_;
  END;
  SHARED __d11_Missing_Geo_Link_I_D__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d11_Location__Mapped,'GeoLinkID','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault');
  SHARED __d11_Geo_Link_I_D__Mapped := IF(__d11_Missing_Geo_Link_I_D__UIDComponents = 'GeoLinkID',PROJECT(__d11_Location__Mapped,TRANSFORM(__d11_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d11_Location__Mapped,__d11_Missing_Geo_Link_I_D__UIDComponents),E_Geo_Link(__cfg).Lookup,TRIM((STRING)LEFT.GeoLinkID) = RIGHT.KeyVal,TRANSFORM(__d11_Geo_Link_I_D__Layout,SELF.Geo_Link_I_D_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d11_Prefiltered := __d11_Geo_Link_I_D__Mapped;
  SHARED __d11 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d11_Prefiltered,InLayout,__Mapping11,'PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault'),__Mapping11_Transform(LEFT)));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6 + __d7 + __d8 + __d9 + __d10 + __d11;
  EXPORT Address_Rank_Details_Layout := RECORD
    KEL.typ.nint Address_Rank_;
    KEL.typ.nint Insurance_Source_Count_;
    KEL.typ.nint Property_Source_Count_;
    KEL.typ.nint Utility_Source_Count_;
    KEL.typ.nint Vehicle_Source_Count_;
    KEL.typ.nint D_L_Source_Count_;
    KEL.typ.nint Voter_Source_Count_;
    KEL.typ.nstr Address_Type_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Address_Hierarchy_Layout := RECORD
    KEL.typ.nint Address_Rank_;
    KEL.typ.nstr Address_Type_;
    KEL.typ.nstr Address_Status_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Unit_Designation_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Postal_City_;
    KEL.typ.nstr State_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nint Z_I_P4_;
    KEL.typ.nstr State_Code_;
    KEL.typ.nstr County_Code_;
    KEL.typ.nstr Latitude_;
    KEL.typ.nstr Longitude_;
    KEL.typ.nstr Geo_Blk_;
    KEL.typ.nstr Geo_Mmatch_;
    KEL.typ.ntyp(E_Geo_Link().Typ) Geo_Link_I_D_;
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
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Cart_;
    KEL.typ.nstr C_R_Sort_Sz_;
    KEL.typ.nstr Lot_;
    KEL.typ.nstr Lot_Order_;
    KEL.typ.nstr D_P_B_C_;
    KEL.typ.nstr C_H_K_Digit_;
    KEL.typ.nstr Ace_Fips_St_;
    KEL.typ.nstr Ace_Fips_County_;
    KEL.typ.nstr M_S_A_;
    KEL.typ.nstr Verified_City_;
    KEL.typ.ndataset(Address_Rank_Details_Layout) Address_Rank_Details_;
    KEL.typ.ndataset(Address_Hierarchy_Layout) Address_Hierarchy_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Subject_,Location_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Z_I_P5_,Secondary_Range_,Cart_,C_R_Sort_Sz_,Lot_,Lot_Order_,D_P_B_C_,C_H_K_Digit_,Ace_Fips_St_,Ace_Fips_County_,M_S_A_,Verified_City_,ALL));
  Person_Address_Group := __PostFilter;
  Layout Person_Address__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Address_Rank_Details_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Address_Rank_,Insurance_Source_Count_,Property_Source_Count_,Utility_Source_Count_,Vehicle_Source_Count_,D_L_Source_Count_,Voter_Source_Count_,Address_Type_},Address_Rank_,Insurance_Source_Count_,Property_Source_Count_,Utility_Source_Count_,Vehicle_Source_Count_,D_L_Source_Count_,Voter_Source_Count_,Address_Type_),Address_Rank_Details_Layout)(__NN(Address_Rank_) OR __NN(Insurance_Source_Count_) OR __NN(Property_Source_Count_) OR __NN(Utility_Source_Count_) OR __NN(Vehicle_Source_Count_) OR __NN(D_L_Source_Count_) OR __NN(Voter_Source_Count_) OR __NN(Address_Type_)));
    SELF.Address_Hierarchy_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Address_Rank_,Address_Type_,Address_Status_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Unit_Designation_,Secondary_Range_,Postal_City_,State_,Z_I_P5_,Z_I_P4_,State_Code_,County_Code_,Latitude_,Longitude_,Geo_Blk_,Geo_Mmatch_,Geo_Link_I_D_},Address_Rank_,Address_Type_,Address_Status_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Unit_Designation_,Secondary_Range_,Postal_City_,State_,Z_I_P5_,Z_I_P4_,State_Code_,County_Code_,Latitude_,Longitude_,Geo_Blk_,Geo_Mmatch_,Geo_Link_I_D_),Address_Hierarchy_Layout)(__NN(Address_Rank_) OR __NN(Address_Type_) OR __NN(Address_Status_) OR __NN(Primary_Range_) OR __NN(Predirectional_) OR __NN(Primary_Name_) OR __NN(Suffix_) OR __NN(Postdirectional_) OR __NN(Unit_Designation_) OR __NN(Secondary_Range_) OR __NN(Postal_City_) OR __NN(State_) OR __NN(Z_I_P5_) OR __NN(Z_I_P4_) OR __NN(State_Code_) OR __NN(County_Code_) OR __NN(Latitude_) OR __NN(Longitude_) OR __NN(Geo_Blk_) OR __NN(Geo_Mmatch_) OR __NN(Geo_Link_I_D_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_,Header_Hit_Flag_,F_D_N_Indicator_},Source_,Header_Hit_Flag_,F_D_N_Indicator_),Data_Sources_Layout)(__NN(Source_) OR __NN(Header_Hit_Flag_) OR __NN(F_D_N_Indicator_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Person_Address__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Address_Rank_Details_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Address_Rank_Details_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Address_Rank_) OR __NN(Insurance_Source_Count_) OR __NN(Property_Source_Count_) OR __NN(Utility_Source_Count_) OR __NN(Vehicle_Source_Count_) OR __NN(D_L_Source_Count_) OR __NN(Voter_Source_Count_) OR __NN(Address_Type_)));
    SELF.Address_Hierarchy_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Address_Hierarchy_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Address_Rank_) OR __NN(Address_Type_) OR __NN(Address_Status_) OR __NN(Primary_Range_) OR __NN(Predirectional_) OR __NN(Primary_Name_) OR __NN(Suffix_) OR __NN(Postdirectional_) OR __NN(Unit_Designation_) OR __NN(Secondary_Range_) OR __NN(Postal_City_) OR __NN(State_) OR __NN(Z_I_P5_) OR __NN(Z_I_P4_) OR __NN(State_Code_) OR __NN(County_Code_) OR __NN(Latitude_) OR __NN(Longitude_) OR __NN(Geo_Blk_) OR __NN(Geo_Mmatch_) OR __NN(Geo_Link_I_D_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_) OR __NN(Header_Hit_Flag_) OR __NN(F_D_N_Indicator_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_Address_Group,COUNT(ROWS(LEFT))=1),GROUP,Person_Address__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_Address_Group,COUNT(ROWS(LEFT))>1),GROUP,Person_Address__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person(__cfg).__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Location__Orphan := JOIN(InData(__NN(Location_)),E_Address(__cfg).__Result,__EEQP(LEFT.Location_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Z_I_P5__Orphan := JOIN(InData(__NN(Z_I_P5_)),E_Zip_Code(__cfg).__Result,__EEQP(LEFT.Z_I_P5_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Geo_Link_I_D__Orphan := JOIN(InData(__NN(Geo_Link_I_D_)),E_Geo_Link(__cfg).__Result,__EEQP(LEFT.Geo_Link_I_D_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Subject__Orphan),COUNT(Location__Orphan),COUNT(Z_I_P5__Orphan),COUNT(Geo_Link_I_D__Orphan)}],{KEL.typ.int Subject__Orphan,KEL.typ.int Location__Orphan,KEL.typ.int Z_I_P5__Orphan,KEL.typ.int Geo_Link_I_D__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','did',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','Location',COUNT(__d0(__NL(Location_))),COUNT(__d0(__NN(Location_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','prim_range',COUNT(__d0(__NL(Primary_Range_))),COUNT(__d0(__NN(Primary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','predir',COUNT(__d0(__NL(Predirectional_))),COUNT(__d0(__NN(Predirectional_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','prim_name',COUNT(__d0(__NL(Primary_Name_))),COUNT(__d0(__NN(Primary_Name_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','suffix',COUNT(__d0(__NL(Suffix_))),COUNT(__d0(__NN(Suffix_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','postdir',COUNT(__d0(__NL(Postdirectional_))),COUNT(__d0(__NN(Postdirectional_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','UnitDesignation',COUNT(__d0(__NL(Unit_Designation_))),COUNT(__d0(__NN(Unit_Designation_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','sec_range',COUNT(__d0(__NL(Secondary_Range_))),COUNT(__d0(__NN(Secondary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','PostalCity',COUNT(__d0(__NL(Postal_City_))),COUNT(__d0(__NN(Postal_City_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','VerifiedCity',COUNT(__d0(__NL(Verified_City_))),COUNT(__d0(__NN(Verified_City_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','State',COUNT(__d0(__NL(State_))),COUNT(__d0(__NN(State_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','zip',COUNT(__d0(__NL(Z_I_P5_))),COUNT(__d0(__NN(Z_I_P5_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','ZIP4',COUNT(__d0(__NL(Z_I_P4_))),COUNT(__d0(__NN(Z_I_P4_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','AddressRank',COUNT(__d0(__NL(Address_Rank_))),COUNT(__d0(__NN(Address_Rank_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','InsuranceSourceCount',COUNT(__d0(__NL(Insurance_Source_Count_))),COUNT(__d0(__NN(Insurance_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','PropertySourceCount',COUNT(__d0(__NL(Property_Source_Count_))),COUNT(__d0(__NN(Property_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','UtilitySourceCount',COUNT(__d0(__NL(Utility_Source_Count_))),COUNT(__d0(__NN(Utility_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','VehicleSourceCount',COUNT(__d0(__NL(Vehicle_Source_Count_))),COUNT(__d0(__NN(Vehicle_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','DLSourceCount',COUNT(__d0(__NL(D_L_Source_Count_))),COUNT(__d0(__NN(D_L_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','VoterSourceCount',COUNT(__d0(__NL(Voter_Source_Count_))),COUNT(__d0(__NN(Voter_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','AddressType',COUNT(__d0(__NL(Address_Type_))),COUNT(__d0(__NN(Address_Type_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','AddressStatus',COUNT(__d0(__NL(Address_Status_))),COUNT(__d0(__NN(Address_Status_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','StateCode',COUNT(__d0(__NL(State_Code_))),COUNT(__d0(__NN(State_Code_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','CountyCode',COUNT(__d0(__NL(County_Code_))),COUNT(__d0(__NN(County_Code_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','Latitude',COUNT(__d0(__NL(Latitude_))),COUNT(__d0(__NN(Latitude_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','Longitude',COUNT(__d0(__NL(Longitude_))),COUNT(__d0(__NN(Longitude_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','GeoLinkID',COUNT(__d0(__NL(Geo_Link_I_D_))),COUNT(__d0(__NN(Geo_Link_I_D_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','GeoBlk',COUNT(__d0(__NL(Geo_Blk_))),COUNT(__d0(__NN(Geo_Blk_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','GeoMmatch',COUNT(__d0(__NL(Geo_Mmatch_))),COUNT(__d0(__NN(Geo_Mmatch_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','Cart',COUNT(__d0(__NL(Cart_))),COUNT(__d0(__NN(Cart_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','CRSortSz',COUNT(__d0(__NL(C_R_Sort_Sz_))),COUNT(__d0(__NN(C_R_Sort_Sz_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','Lot',COUNT(__d0(__NL(Lot_))),COUNT(__d0(__NN(Lot_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','LotOrder',COUNT(__d0(__NL(Lot_Order_))),COUNT(__d0(__NN(Lot_Order_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','DPBC',COUNT(__d0(__NL(D_P_B_C_))),COUNT(__d0(__NN(D_P_B_C_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','CHKDigit',COUNT(__d0(__NL(C_H_K_Digit_))),COUNT(__d0(__NN(C_H_K_Digit_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','AceFipsSt',COUNT(__d0(__NL(Ace_Fips_St_))),COUNT(__d0(__NN(Ace_Fips_St_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','AceFipsCounty',COUNT(__d0(__NL(Ace_Fips_County_))),COUNT(__d0(__NN(Ace_Fips_County_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','MSA',COUNT(__d0(__NL(M_S_A_))),COUNT(__d0(__NN(M_S_A_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','FDNIndicator',COUNT(__d0(__NL(F_D_N_Indicator_))),COUNT(__d0(__NN(F_D_N_Indicator_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','did',COUNT(__d1(__NL(Subject_))),COUNT(__d1(__NN(Subject_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','Location',COUNT(__d1(__NL(Location_))),COUNT(__d1(__NN(Location_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','prim_range',COUNT(__d1(__NL(Primary_Range_))),COUNT(__d1(__NN(Primary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','predir',COUNT(__d1(__NL(Predirectional_))),COUNT(__d1(__NN(Predirectional_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','prim_name',COUNT(__d1(__NL(Primary_Name_))),COUNT(__d1(__NN(Primary_Name_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','suffix',COUNT(__d1(__NL(Suffix_))),COUNT(__d1(__NN(Suffix_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','postdir',COUNT(__d1(__NL(Postdirectional_))),COUNT(__d1(__NN(Postdirectional_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','UnitDesignation',COUNT(__d1(__NL(Unit_Designation_))),COUNT(__d1(__NN(Unit_Designation_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','sec_range',COUNT(__d1(__NL(Secondary_Range_))),COUNT(__d1(__NN(Secondary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','PostalCity',COUNT(__d1(__NL(Postal_City_))),COUNT(__d1(__NN(Postal_City_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','VerifiedCity',COUNT(__d1(__NL(Verified_City_))),COUNT(__d1(__NN(Verified_City_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','State',COUNT(__d1(__NL(State_))),COUNT(__d1(__NN(State_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','zip',COUNT(__d1(__NL(Z_I_P5_))),COUNT(__d1(__NN(Z_I_P5_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','ZIP4',COUNT(__d1(__NL(Z_I_P4_))),COUNT(__d1(__NN(Z_I_P4_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','AddressRank',COUNT(__d1(__NL(Address_Rank_))),COUNT(__d1(__NN(Address_Rank_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','InsuranceSourceCount',COUNT(__d1(__NL(Insurance_Source_Count_))),COUNT(__d1(__NN(Insurance_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','PropertySourceCount',COUNT(__d1(__NL(Property_Source_Count_))),COUNT(__d1(__NN(Property_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','UtilitySourceCount',COUNT(__d1(__NL(Utility_Source_Count_))),COUNT(__d1(__NN(Utility_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','VehicleSourceCount',COUNT(__d1(__NL(Vehicle_Source_Count_))),COUNT(__d1(__NN(Vehicle_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','DLSourceCount',COUNT(__d1(__NL(D_L_Source_Count_))),COUNT(__d1(__NN(D_L_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','VoterSourceCount',COUNT(__d1(__NL(Voter_Source_Count_))),COUNT(__d1(__NN(Voter_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','AddressType',COUNT(__d1(__NL(Address_Type_))),COUNT(__d1(__NN(Address_Type_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','AddressStatus',COUNT(__d1(__NL(Address_Status_))),COUNT(__d1(__NN(Address_Status_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','StateCode',COUNT(__d1(__NL(State_Code_))),COUNT(__d1(__NN(State_Code_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','CountyCode',COUNT(__d1(__NL(County_Code_))),COUNT(__d1(__NN(County_Code_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','Latitude',COUNT(__d1(__NL(Latitude_))),COUNT(__d1(__NN(Latitude_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','Longitude',COUNT(__d1(__NL(Longitude_))),COUNT(__d1(__NN(Longitude_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','GeoLinkID',COUNT(__d1(__NL(Geo_Link_I_D_))),COUNT(__d1(__NN(Geo_Link_I_D_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','GeoBlk',COUNT(__d1(__NL(Geo_Blk_))),COUNT(__d1(__NN(Geo_Blk_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','GeoMmatch',COUNT(__d1(__NL(Geo_Mmatch_))),COUNT(__d1(__NN(Geo_Mmatch_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','Cart',COUNT(__d1(__NL(Cart_))),COUNT(__d1(__NN(Cart_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','CRSortSz',COUNT(__d1(__NL(C_R_Sort_Sz_))),COUNT(__d1(__NN(C_R_Sort_Sz_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','Lot',COUNT(__d1(__NL(Lot_))),COUNT(__d1(__NN(Lot_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','LotOrder',COUNT(__d1(__NL(Lot_Order_))),COUNT(__d1(__NN(Lot_Order_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','DPBC',COUNT(__d1(__NL(D_P_B_C_))),COUNT(__d1(__NN(D_P_B_C_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','CHKDigit',COUNT(__d1(__NL(C_H_K_Digit_))),COUNT(__d1(__NN(C_H_K_Digit_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','AceFipsSt',COUNT(__d1(__NL(Ace_Fips_St_))),COUNT(__d1(__NN(Ace_Fips_St_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','AceFipsCounty',COUNT(__d1(__NL(Ace_Fips_County_))),COUNT(__d1(__NN(Ace_Fips_County_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','MSA',COUNT(__d1(__NL(M_S_A_))),COUNT(__d1(__NN(M_S_A_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','FDNIndicator',COUNT(__d1(__NL(F_D_N_Indicator_))),COUNT(__d1(__NN(F_D_N_Indicator_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','did',COUNT(__d2(__NL(Subject_))),COUNT(__d2(__NN(Subject_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','Location',COUNT(__d2(__NL(Location_))),COUNT(__d2(__NN(Location_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','prim_range',COUNT(__d2(__NL(Primary_Range_))),COUNT(__d2(__NN(Primary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','predir',COUNT(__d2(__NL(Predirectional_))),COUNT(__d2(__NN(Predirectional_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','prim_name',COUNT(__d2(__NL(Primary_Name_))),COUNT(__d2(__NN(Primary_Name_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','suffix',COUNT(__d2(__NL(Suffix_))),COUNT(__d2(__NN(Suffix_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','postdir',COUNT(__d2(__NL(Postdirectional_))),COUNT(__d2(__NN(Postdirectional_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','UnitDesignation',COUNT(__d2(__NL(Unit_Designation_))),COUNT(__d2(__NN(Unit_Designation_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','sec_range',COUNT(__d2(__NL(Secondary_Range_))),COUNT(__d2(__NN(Secondary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','PostalCity',COUNT(__d2(__NL(Postal_City_))),COUNT(__d2(__NN(Postal_City_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','VerifiedCity',COUNT(__d2(__NL(Verified_City_))),COUNT(__d2(__NN(Verified_City_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','State',COUNT(__d2(__NL(State_))),COUNT(__d2(__NN(State_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','ZIP5',COUNT(__d2(__NL(Z_I_P5_))),COUNT(__d2(__NN(Z_I_P5_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','ZIP4',COUNT(__d2(__NL(Z_I_P4_))),COUNT(__d2(__NN(Z_I_P4_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','AddressRank',COUNT(__d2(__NL(Address_Rank_))),COUNT(__d2(__NN(Address_Rank_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','InsuranceSourceCount',COUNT(__d2(__NL(Insurance_Source_Count_))),COUNT(__d2(__NN(Insurance_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','PropertySourceCount',COUNT(__d2(__NL(Property_Source_Count_))),COUNT(__d2(__NN(Property_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','UtilitySourceCount',COUNT(__d2(__NL(Utility_Source_Count_))),COUNT(__d2(__NN(Utility_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','VehicleSourceCount',COUNT(__d2(__NL(Vehicle_Source_Count_))),COUNT(__d2(__NN(Vehicle_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','DLSourceCount',COUNT(__d2(__NL(D_L_Source_Count_))),COUNT(__d2(__NN(D_L_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','VoterSourceCount',COUNT(__d2(__NL(Voter_Source_Count_))),COUNT(__d2(__NN(Voter_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','AddressType',COUNT(__d2(__NL(Address_Type_))),COUNT(__d2(__NN(Address_Type_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','AddressStatus',COUNT(__d2(__NL(Address_Status_))),COUNT(__d2(__NN(Address_Status_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','StateCode',COUNT(__d2(__NL(State_Code_))),COUNT(__d2(__NN(State_Code_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','CountyCode',COUNT(__d2(__NL(County_Code_))),COUNT(__d2(__NN(County_Code_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','Latitude',COUNT(__d2(__NL(Latitude_))),COUNT(__d2(__NN(Latitude_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','Longitude',COUNT(__d2(__NL(Longitude_))),COUNT(__d2(__NN(Longitude_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','GeoLinkID',COUNT(__d2(__NL(Geo_Link_I_D_))),COUNT(__d2(__NN(Geo_Link_I_D_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','GeoBlk',COUNT(__d2(__NL(Geo_Blk_))),COUNT(__d2(__NN(Geo_Blk_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','GeoMmatch',COUNT(__d2(__NL(Geo_Mmatch_))),COUNT(__d2(__NN(Geo_Mmatch_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','Cart',COUNT(__d2(__NL(Cart_))),COUNT(__d2(__NN(Cart_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','CRSortSz',COUNT(__d2(__NL(C_R_Sort_Sz_))),COUNT(__d2(__NN(C_R_Sort_Sz_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','Lot',COUNT(__d2(__NL(Lot_))),COUNT(__d2(__NN(Lot_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','LotOrder',COUNT(__d2(__NL(Lot_Order_))),COUNT(__d2(__NN(Lot_Order_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','DPBC',COUNT(__d2(__NL(D_P_B_C_))),COUNT(__d2(__NN(D_P_B_C_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','CHKDigit',COUNT(__d2(__NL(C_H_K_Digit_))),COUNT(__d2(__NN(C_H_K_Digit_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','AceFipsSt',COUNT(__d2(__NL(Ace_Fips_St_))),COUNT(__d2(__NN(Ace_Fips_St_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','AceFipsCounty',COUNT(__d2(__NL(Ace_Fips_County_))),COUNT(__d2(__NN(Ace_Fips_County_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','MSA',COUNT(__d2(__NL(M_S_A_))),COUNT(__d2(__NN(M_S_A_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','HeaderHitFlag',COUNT(__d2(__NL(Header_Hit_Flag_))),COUNT(__d2(__NN(Header_Hit_Flag_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','FDNIndicator',COUNT(__d2(__NL(F_D_N_Indicator_))),COUNT(__d2(__NN(F_D_N_Indicator_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','source_Code',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','did',COUNT(__d3(__NL(Subject_))),COUNT(__d3(__NN(Subject_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','Location',COUNT(__d3(__NL(Location_))),COUNT(__d3(__NN(Location_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','prim_range',COUNT(__d3(__NL(Primary_Range_))),COUNT(__d3(__NN(Primary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','predir',COUNT(__d3(__NL(Predirectional_))),COUNT(__d3(__NN(Predirectional_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','prim_name',COUNT(__d3(__NL(Primary_Name_))),COUNT(__d3(__NN(Primary_Name_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','addr_suffix',COUNT(__d3(__NL(Suffix_))),COUNT(__d3(__NN(Suffix_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','postdir',COUNT(__d3(__NL(Postdirectional_))),COUNT(__d3(__NN(Postdirectional_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','UnitDesignation',COUNT(__d3(__NL(Unit_Designation_))),COUNT(__d3(__NN(Unit_Designation_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','sec_range',COUNT(__d3(__NL(Secondary_Range_))),COUNT(__d3(__NN(Secondary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','p_city_name',COUNT(__d3(__NL(Postal_City_))),COUNT(__d3(__NN(Postal_City_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','v_city_name',COUNT(__d3(__NL(Verified_City_))),COUNT(__d3(__NN(Verified_City_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','state',COUNT(__d3(__NL(State_))),COUNT(__d3(__NN(State_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','zip5',COUNT(__d3(__NL(Z_I_P5_))),COUNT(__d3(__NN(Z_I_P5_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','zip4',COUNT(__d3(__NL(Z_I_P4_))),COUNT(__d3(__NN(Z_I_P4_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','AddressRank',COUNT(__d3(__NL(Address_Rank_))),COUNT(__d3(__NN(Address_Rank_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','InsuranceSourceCount',COUNT(__d3(__NL(Insurance_Source_Count_))),COUNT(__d3(__NN(Insurance_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','PropertySourceCount',COUNT(__d3(__NL(Property_Source_Count_))),COUNT(__d3(__NN(Property_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','UtilitySourceCount',COUNT(__d3(__NL(Utility_Source_Count_))),COUNT(__d3(__NN(Utility_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','VehicleSourceCount',COUNT(__d3(__NL(Vehicle_Source_Count_))),COUNT(__d3(__NN(Vehicle_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','DLSourceCount',COUNT(__d3(__NL(D_L_Source_Count_))),COUNT(__d3(__NN(D_L_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','VoterSourceCount',COUNT(__d3(__NL(Voter_Source_Count_))),COUNT(__d3(__NN(Voter_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','AddressType',COUNT(__d3(__NL(Address_Type_))),COUNT(__d3(__NN(Address_Type_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','AddressStatus',COUNT(__d3(__NL(Address_Status_))),COUNT(__d3(__NN(Address_Status_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','StateCode',COUNT(__d3(__NL(State_Code_))),COUNT(__d3(__NN(State_Code_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','CountyCode',COUNT(__d3(__NL(County_Code_))),COUNT(__d3(__NN(County_Code_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','geo_lat',COUNT(__d3(__NL(Latitude_))),COUNT(__d3(__NN(Latitude_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','geo_long',COUNT(__d3(__NL(Longitude_))),COUNT(__d3(__NN(Longitude_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','GeoLinkID',COUNT(__d3(__NL(Geo_Link_I_D_))),COUNT(__d3(__NN(Geo_Link_I_D_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','geo_blk',COUNT(__d3(__NL(Geo_Blk_))),COUNT(__d3(__NN(Geo_Blk_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','geo_match',COUNT(__d3(__NL(Geo_Mmatch_))),COUNT(__d3(__NN(Geo_Mmatch_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','cart',COUNT(__d3(__NL(Cart_))),COUNT(__d3(__NN(Cart_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','cr_sort_sz',COUNT(__d3(__NL(C_R_Sort_Sz_))),COUNT(__d3(__NN(C_R_Sort_Sz_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','lot',COUNT(__d3(__NL(Lot_))),COUNT(__d3(__NN(Lot_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','lot_order',COUNT(__d3(__NL(Lot_Order_))),COUNT(__d3(__NN(Lot_Order_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','dpbc',COUNT(__d3(__NL(D_P_B_C_))),COUNT(__d3(__NN(D_P_B_C_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','chk_digit',COUNT(__d3(__NL(C_H_K_Digit_))),COUNT(__d3(__NN(C_H_K_Digit_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','ace_fips_st',COUNT(__d3(__NL(Ace_Fips_St_))),COUNT(__d3(__NN(Ace_Fips_St_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','ace_fips_county',COUNT(__d3(__NL(Ace_Fips_County_))),COUNT(__d3(__NN(Ace_Fips_County_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','msa',COUNT(__d3(__NL(M_S_A_))),COUNT(__d3(__NN(M_S_A_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','HeaderHitFlag',COUNT(__d3(__NL(Header_Hit_Flag_))),COUNT(__d3(__NN(Header_Hit_Flag_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','FDNIndicator',COUNT(__d3(__NL(F_D_N_Indicator_))),COUNT(__d3(__NN(F_D_N_Indicator_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','Src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','HybridArchiveDate',COUNT(__d3(Hybrid_Archive_Date_=0)),COUNT(__d3(Hybrid_Archive_Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','VaultDateLastSeen',COUNT(__d3(Vault_Date_Last_Seen_=0)),COUNT(__d3(Vault_Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','s_did',COUNT(__d4(__NL(Subject_))),COUNT(__d4(__NN(Subject_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','Location',COUNT(__d4(__NL(Location_))),COUNT(__d4(__NN(Location_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','prim_range',COUNT(__d4(__NL(Primary_Range_))),COUNT(__d4(__NN(Primary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','predir',COUNT(__d4(__NL(Predirectional_))),COUNT(__d4(__NN(Predirectional_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','prim_name',COUNT(__d4(__NL(Primary_Name_))),COUNT(__d4(__NN(Primary_Name_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','suffix',COUNT(__d4(__NL(Suffix_))),COUNT(__d4(__NN(Suffix_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','postdir',COUNT(__d4(__NL(Postdirectional_))),COUNT(__d4(__NN(Postdirectional_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','unit_desig',COUNT(__d4(__NL(Unit_Designation_))),COUNT(__d4(__NN(Unit_Designation_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','sec_range',COUNT(__d4(__NL(Secondary_Range_))),COUNT(__d4(__NN(Secondary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','v_city_name',COUNT(__d4(__NL(Postal_City_))),COUNT(__d4(__NN(Postal_City_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','VerifiedCity',COUNT(__d4(__NL(Verified_City_))),COUNT(__d4(__NN(Verified_City_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','st',COUNT(__d4(__NL(State_))),COUNT(__d4(__NN(State_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','zip',COUNT(__d4(__NL(Z_I_P5_))),COUNT(__d4(__NN(Z_I_P5_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','zip4',COUNT(__d4(__NL(Z_I_P4_))),COUNT(__d4(__NN(Z_I_P4_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','address_history_seq',COUNT(__d4(__NL(Address_Rank_))),COUNT(__d4(__NN(Address_Rank_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','Insurance_Source_Count',COUNT(__d4(__NL(Insurance_Source_Count_))),COUNT(__d4(__NN(Insurance_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','Property_Source_Count',COUNT(__d4(__NL(Property_Source_Count_))),COUNT(__d4(__NN(Property_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','Utility_Source_Count',COUNT(__d4(__NL(Utility_Source_Count_))),COUNT(__d4(__NN(Utility_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','Vehicle_Source_Count',COUNT(__d4(__NL(Vehicle_Source_Count_))),COUNT(__d4(__NN(Vehicle_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','DL_Source_Count',COUNT(__d4(__NL(D_L_Source_Count_))),COUNT(__d4(__NN(D_L_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','Voter_Source_Count',COUNT(__d4(__NL(Voter_Source_Count_))),COUNT(__d4(__NN(Voter_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','AddressType',COUNT(__d4(__NL(Address_Type_))),COUNT(__d4(__NN(Address_Type_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','err_stat',COUNT(__d4(__NL(Address_Status_))),COUNT(__d4(__NN(Address_Status_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','StateCode',COUNT(__d4(__NL(State_Code_))),COUNT(__d4(__NN(State_Code_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','county',COUNT(__d4(__NL(County_Code_))),COUNT(__d4(__NN(County_Code_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','geo_lat',COUNT(__d4(__NL(Latitude_))),COUNT(__d4(__NN(Latitude_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','geo_long',COUNT(__d4(__NL(Longitude_))),COUNT(__d4(__NN(Longitude_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','GeoLinkID',COUNT(__d4(__NL(Geo_Link_I_D_))),COUNT(__d4(__NN(Geo_Link_I_D_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','geo_blk',COUNT(__d4(__NL(Geo_Blk_))),COUNT(__d4(__NN(Geo_Blk_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','geo_match',COUNT(__d4(__NL(Geo_Mmatch_))),COUNT(__d4(__NN(Geo_Mmatch_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','Cart',COUNT(__d4(__NL(Cart_))),COUNT(__d4(__NN(Cart_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','CRSortSz',COUNT(__d4(__NL(C_R_Sort_Sz_))),COUNT(__d4(__NN(C_R_Sort_Sz_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','Lot',COUNT(__d4(__NL(Lot_))),COUNT(__d4(__NN(Lot_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','LotOrder',COUNT(__d4(__NL(Lot_Order_))),COUNT(__d4(__NN(Lot_Order_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','DPBC',COUNT(__d4(__NL(D_P_B_C_))),COUNT(__d4(__NN(D_P_B_C_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','CHKDigit',COUNT(__d4(__NL(C_H_K_Digit_))),COUNT(__d4(__NN(C_H_K_Digit_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','AceFipsSt',COUNT(__d4(__NL(Ace_Fips_St_))),COUNT(__d4(__NN(Ace_Fips_St_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','AceFipsCounty',COUNT(__d4(__NL(Ace_Fips_County_))),COUNT(__d4(__NN(Ace_Fips_County_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','MSA',COUNT(__d4(__NL(M_S_A_))),COUNT(__d4(__NN(M_S_A_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','HeaderHitFlag',COUNT(__d4(__NL(Header_Hit_Flag_))),COUNT(__d4(__NN(Header_Hit_Flag_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','FDNIndicator',COUNT(__d4(__NL(F_D_N_Indicator_))),COUNT(__d4(__NN(F_D_N_Indicator_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','src',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','Archive_Date',COUNT(__d4(Archive___Date_=0)),COUNT(__d4(Archive___Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','HybridArchiveDate',COUNT(__d4(Hybrid_Archive_Date_=0)),COUNT(__d4(Hybrid_Archive_Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','VaultDateLastSeen',COUNT(__d4(Vault_Date_Last_Seen_=0)),COUNT(__d4(Vault_Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','did',COUNT(__d5(__NL(Subject_))),COUNT(__d5(__NN(Subject_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','Location',COUNT(__d5(__NL(Location_))),COUNT(__d5(__NN(Location_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','prim_range',COUNT(__d5(__NL(Primary_Range_))),COUNT(__d5(__NN(Primary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','predir',COUNT(__d5(__NL(Predirectional_))),COUNT(__d5(__NN(Predirectional_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','prim_name',COUNT(__d5(__NL(Primary_Name_))),COUNT(__d5(__NN(Primary_Name_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','suffix',COUNT(__d5(__NL(Suffix_))),COUNT(__d5(__NN(Suffix_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','postdir',COUNT(__d5(__NL(Postdirectional_))),COUNT(__d5(__NN(Postdirectional_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','UnitDesignation',COUNT(__d5(__NL(Unit_Designation_))),COUNT(__d5(__NN(Unit_Designation_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','sec_range',COUNT(__d5(__NL(Secondary_Range_))),COUNT(__d5(__NN(Secondary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','PostalCity',COUNT(__d5(__NL(Postal_City_))),COUNT(__d5(__NN(Postal_City_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','VerifiedCity',COUNT(__d5(__NL(Verified_City_))),COUNT(__d5(__NN(Verified_City_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','State',COUNT(__d5(__NL(State_))),COUNT(__d5(__NN(State_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','zip',COUNT(__d5(__NL(Z_I_P5_))),COUNT(__d5(__NN(Z_I_P5_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','ZIP4',COUNT(__d5(__NL(Z_I_P4_))),COUNT(__d5(__NN(Z_I_P4_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','AddressRank',COUNT(__d5(__NL(Address_Rank_))),COUNT(__d5(__NN(Address_Rank_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','InsuranceSourceCount',COUNT(__d5(__NL(Insurance_Source_Count_))),COUNT(__d5(__NN(Insurance_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','PropertySourceCount',COUNT(__d5(__NL(Property_Source_Count_))),COUNT(__d5(__NN(Property_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','UtilitySourceCount',COUNT(__d5(__NL(Utility_Source_Count_))),COUNT(__d5(__NN(Utility_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','VehicleSourceCount',COUNT(__d5(__NL(Vehicle_Source_Count_))),COUNT(__d5(__NN(Vehicle_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','DLSourceCount',COUNT(__d5(__NL(D_L_Source_Count_))),COUNT(__d5(__NN(D_L_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','VoterSourceCount',COUNT(__d5(__NL(Voter_Source_Count_))),COUNT(__d5(__NN(Voter_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','AddressType',COUNT(__d5(__NL(Address_Type_))),COUNT(__d5(__NN(Address_Type_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','AddressStatus',COUNT(__d5(__NL(Address_Status_))),COUNT(__d5(__NN(Address_Status_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','StateCode',COUNT(__d5(__NL(State_Code_))),COUNT(__d5(__NN(State_Code_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','CountyCode',COUNT(__d5(__NL(County_Code_))),COUNT(__d5(__NN(County_Code_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','Latitude',COUNT(__d5(__NL(Latitude_))),COUNT(__d5(__NN(Latitude_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','Longitude',COUNT(__d5(__NL(Longitude_))),COUNT(__d5(__NN(Longitude_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','GeoLinkID',COUNT(__d5(__NL(Geo_Link_I_D_))),COUNT(__d5(__NN(Geo_Link_I_D_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','GeoBlk',COUNT(__d5(__NL(Geo_Blk_))),COUNT(__d5(__NN(Geo_Blk_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','GeoMmatch',COUNT(__d5(__NL(Geo_Mmatch_))),COUNT(__d5(__NN(Geo_Mmatch_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','Cart',COUNT(__d5(__NL(Cart_))),COUNT(__d5(__NN(Cart_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','CRSortSz',COUNT(__d5(__NL(C_R_Sort_Sz_))),COUNT(__d5(__NN(C_R_Sort_Sz_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','Lot',COUNT(__d5(__NL(Lot_))),COUNT(__d5(__NN(Lot_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','LotOrder',COUNT(__d5(__NL(Lot_Order_))),COUNT(__d5(__NN(Lot_Order_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','DPBC',COUNT(__d5(__NL(D_P_B_C_))),COUNT(__d5(__NN(D_P_B_C_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','CHKDigit',COUNT(__d5(__NL(C_H_K_Digit_))),COUNT(__d5(__NN(C_H_K_Digit_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','AceFipsSt',COUNT(__d5(__NL(Ace_Fips_St_))),COUNT(__d5(__NN(Ace_Fips_St_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','AceFipsCounty',COUNT(__d5(__NL(Ace_Fips_County_))),COUNT(__d5(__NN(Ace_Fips_County_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','MSA',COUNT(__d5(__NL(M_S_A_))),COUNT(__d5(__NN(M_S_A_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','FDNIndicator',COUNT(__d5(__NL(F_D_N_Indicator_))),COUNT(__d5(__NN(F_D_N_Indicator_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','src',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','Archive_Date',COUNT(__d5(Archive___Date_=0)),COUNT(__d5(Archive___Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','HybridArchiveDate',COUNT(__d5(Hybrid_Archive_Date_=0)),COUNT(__d5(Hybrid_Archive_Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Address_Vault','VaultDateLastSeen',COUNT(__d5(Vault_Date_Last_Seen_=0)),COUNT(__d5(Vault_Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','appended_lexid',COUNT(__d6(__NL(Subject_))),COUNT(__d6(__NN(Subject_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','Location',COUNT(__d6(__NL(Location_))),COUNT(__d6(__NN(Location_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','prim_range',COUNT(__d6(__NL(Primary_Range_))),COUNT(__d6(__NN(Primary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','predir',COUNT(__d6(__NL(Predirectional_))),COUNT(__d6(__NN(Predirectional_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','prim_name',COUNT(__d6(__NL(Primary_Name_))),COUNT(__d6(__NN(Primary_Name_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','addr_suffix',COUNT(__d6(__NL(Suffix_))),COUNT(__d6(__NN(Suffix_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','postdir',COUNT(__d6(__NL(Postdirectional_))),COUNT(__d6(__NN(Postdirectional_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','UnitDesignation',COUNT(__d6(__NL(Unit_Designation_))),COUNT(__d6(__NN(Unit_Designation_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','SecondaryRange',COUNT(__d6(__NL(Secondary_Range_))),COUNT(__d6(__NN(Secondary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','PostalCity',COUNT(__d6(__NL(Postal_City_))),COUNT(__d6(__NN(Postal_City_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','VerifiedCity',COUNT(__d6(__NL(Verified_City_))),COUNT(__d6(__NN(Verified_City_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','State',COUNT(__d6(__NL(State_))),COUNT(__d6(__NN(State_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','zip',COUNT(__d6(__NL(Z_I_P5_))),COUNT(__d6(__NN(Z_I_P5_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','ZIP4',COUNT(__d6(__NL(Z_I_P4_))),COUNT(__d6(__NN(Z_I_P4_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','AddressRank',COUNT(__d6(__NL(Address_Rank_))),COUNT(__d6(__NN(Address_Rank_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','InsuranceSourceCount',COUNT(__d6(__NL(Insurance_Source_Count_))),COUNT(__d6(__NN(Insurance_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','PropertySourceCount',COUNT(__d6(__NL(Property_Source_Count_))),COUNT(__d6(__NN(Property_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','UtilitySourceCount',COUNT(__d6(__NL(Utility_Source_Count_))),COUNT(__d6(__NN(Utility_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','VehicleSourceCount',COUNT(__d6(__NL(Vehicle_Source_Count_))),COUNT(__d6(__NN(Vehicle_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','DLSourceCount',COUNT(__d6(__NL(D_L_Source_Count_))),COUNT(__d6(__NN(D_L_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','VoterSourceCount',COUNT(__d6(__NL(Voter_Source_Count_))),COUNT(__d6(__NN(Voter_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','AddressType',COUNT(__d6(__NL(Address_Type_))),COUNT(__d6(__NN(Address_Type_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','AddressStatus',COUNT(__d6(__NL(Address_Status_))),COUNT(__d6(__NN(Address_Status_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','StateCode',COUNT(__d6(__NL(State_Code_))),COUNT(__d6(__NN(State_Code_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','CountyCode',COUNT(__d6(__NL(County_Code_))),COUNT(__d6(__NN(County_Code_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','Latitude',COUNT(__d6(__NL(Latitude_))),COUNT(__d6(__NN(Latitude_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','Longitude',COUNT(__d6(__NL(Longitude_))),COUNT(__d6(__NN(Longitude_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','GeoLinkID',COUNT(__d6(__NL(Geo_Link_I_D_))),COUNT(__d6(__NN(Geo_Link_I_D_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','GeoBlk',COUNT(__d6(__NL(Geo_Blk_))),COUNT(__d6(__NN(Geo_Blk_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','GeoMmatch',COUNT(__d6(__NL(Geo_Mmatch_))),COUNT(__d6(__NN(Geo_Mmatch_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','Cart',COUNT(__d6(__NL(Cart_))),COUNT(__d6(__NN(Cart_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','CRSortSz',COUNT(__d6(__NL(C_R_Sort_Sz_))),COUNT(__d6(__NN(C_R_Sort_Sz_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','Lot',COUNT(__d6(__NL(Lot_))),COUNT(__d6(__NN(Lot_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','LotOrder',COUNT(__d6(__NL(Lot_Order_))),COUNT(__d6(__NN(Lot_Order_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','DPBC',COUNT(__d6(__NL(D_P_B_C_))),COUNT(__d6(__NN(D_P_B_C_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','CHKDigit',COUNT(__d6(__NL(C_H_K_Digit_))),COUNT(__d6(__NN(C_H_K_Digit_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','AceFipsSt',COUNT(__d6(__NL(Ace_Fips_St_))),COUNT(__d6(__NN(Ace_Fips_St_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','AceFipsCounty',COUNT(__d6(__NL(Ace_Fips_County_))),COUNT(__d6(__NN(Ace_Fips_County_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','MSA',COUNT(__d6(__NL(M_S_A_))),COUNT(__d6(__NN(M_S_A_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','HeaderHitFlag',COUNT(__d6(__NL(Header_Hit_Flag_))),COUNT(__d6(__NN(Header_Hit_Flag_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','Src',COUNT(__d6(__NL(Source_))),COUNT(__d6(__NN(Source_)))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','Archive_Date',COUNT(__d6(Archive___Date_=0)),COUNT(__d6(Archive___Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','HybridArchiveDate',COUNT(__d6(Hybrid_Archive_Date_=0)),COUNT(__d6(Hybrid_Archive_Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.NonFCRA.Fraudpoint3__Key_Address_Vault','VaultDateLastSeen',COUNT(__d6(Vault_Date_Last_Seen_=0)),COUNT(__d6(Vault_Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','appended_lexid',COUNT(__d7(__NL(Subject_))),COUNT(__d7(__NN(Subject_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','Location',COUNT(__d7(__NL(Location_))),COUNT(__d7(__NN(Location_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','prim_range',COUNT(__d7(__NL(Primary_Range_))),COUNT(__d7(__NN(Primary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','predir',COUNT(__d7(__NL(Predirectional_))),COUNT(__d7(__NN(Predirectional_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','prim_name',COUNT(__d7(__NL(Primary_Name_))),COUNT(__d7(__NN(Primary_Name_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','addr_suffix',COUNT(__d7(__NL(Suffix_))),COUNT(__d7(__NN(Suffix_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','postdir',COUNT(__d7(__NL(Postdirectional_))),COUNT(__d7(__NN(Postdirectional_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','UnitDesignation',COUNT(__d7(__NL(Unit_Designation_))),COUNT(__d7(__NN(Unit_Designation_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','SecondaryRange',COUNT(__d7(__NL(Secondary_Range_))),COUNT(__d7(__NN(Secondary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','PostalCity',COUNT(__d7(__NL(Postal_City_))),COUNT(__d7(__NN(Postal_City_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','VerifiedCity',COUNT(__d7(__NL(Verified_City_))),COUNT(__d7(__NN(Verified_City_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','State',COUNT(__d7(__NL(State_))),COUNT(__d7(__NN(State_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','zip',COUNT(__d7(__NL(Z_I_P5_))),COUNT(__d7(__NN(Z_I_P5_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','ZIP4',COUNT(__d7(__NL(Z_I_P4_))),COUNT(__d7(__NN(Z_I_P4_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','AddressRank',COUNT(__d7(__NL(Address_Rank_))),COUNT(__d7(__NN(Address_Rank_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','InsuranceSourceCount',COUNT(__d7(__NL(Insurance_Source_Count_))),COUNT(__d7(__NN(Insurance_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','PropertySourceCount',COUNT(__d7(__NL(Property_Source_Count_))),COUNT(__d7(__NN(Property_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','UtilitySourceCount',COUNT(__d7(__NL(Utility_Source_Count_))),COUNT(__d7(__NN(Utility_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','VehicleSourceCount',COUNT(__d7(__NL(Vehicle_Source_Count_))),COUNT(__d7(__NN(Vehicle_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','DLSourceCount',COUNT(__d7(__NL(D_L_Source_Count_))),COUNT(__d7(__NN(D_L_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','VoterSourceCount',COUNT(__d7(__NL(Voter_Source_Count_))),COUNT(__d7(__NN(Voter_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','AddressType',COUNT(__d7(__NL(Address_Type_))),COUNT(__d7(__NN(Address_Type_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','AddressStatus',COUNT(__d7(__NL(Address_Status_))),COUNT(__d7(__NN(Address_Status_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','StateCode',COUNT(__d7(__NL(State_Code_))),COUNT(__d7(__NN(State_Code_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','CountyCode',COUNT(__d7(__NL(County_Code_))),COUNT(__d7(__NN(County_Code_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','Latitude',COUNT(__d7(__NL(Latitude_))),COUNT(__d7(__NN(Latitude_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','Longitude',COUNT(__d7(__NL(Longitude_))),COUNT(__d7(__NN(Longitude_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','GeoLinkID',COUNT(__d7(__NL(Geo_Link_I_D_))),COUNT(__d7(__NN(Geo_Link_I_D_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','GeoBlk',COUNT(__d7(__NL(Geo_Blk_))),COUNT(__d7(__NN(Geo_Blk_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','GeoMmatch',COUNT(__d7(__NL(Geo_Mmatch_))),COUNT(__d7(__NN(Geo_Mmatch_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','Cart',COUNT(__d7(__NL(Cart_))),COUNT(__d7(__NN(Cart_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','CRSortSz',COUNT(__d7(__NL(C_R_Sort_Sz_))),COUNT(__d7(__NN(C_R_Sort_Sz_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','Lot',COUNT(__d7(__NL(Lot_))),COUNT(__d7(__NN(Lot_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','LotOrder',COUNT(__d7(__NL(Lot_Order_))),COUNT(__d7(__NN(Lot_Order_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','DPBC',COUNT(__d7(__NL(D_P_B_C_))),COUNT(__d7(__NN(D_P_B_C_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','CHKDigit',COUNT(__d7(__NL(C_H_K_Digit_))),COUNT(__d7(__NN(C_H_K_Digit_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','AceFipsSt',COUNT(__d7(__NL(Ace_Fips_St_))),COUNT(__d7(__NN(Ace_Fips_St_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','AceFipsCounty',COUNT(__d7(__NL(Ace_Fips_County_))),COUNT(__d7(__NN(Ace_Fips_County_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','MSA',COUNT(__d7(__NL(M_S_A_))),COUNT(__d7(__NN(M_S_A_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','HeaderHitFlag',COUNT(__d7(__NL(Header_Hit_Flag_))),COUNT(__d7(__NN(Header_Hit_Flag_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','Src',COUNT(__d7(__NL(Source_))),COUNT(__d7(__NN(Source_)))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','Archive_Date',COUNT(__d7(Archive___Date_=0)),COUNT(__d7(Archive___Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','DateFirstSeen',COUNT(__d7(Date_First_Seen_=0)),COUNT(__d7(Date_First_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','DateLastSeen',COUNT(__d7(Date_Last_Seen_=0)),COUNT(__d7(Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','HybridArchiveDate',COUNT(__d7(Hybrid_Archive_Date_=0)),COUNT(__d7(Hybrid_Archive_Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','VaultDateLastSeen',COUNT(__d7(Vault_Date_Last_Seen_=0)),COUNT(__d7(Vault_Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','did',COUNT(__d8(__NL(Subject_))),COUNT(__d8(__NN(Subject_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','Location',COUNT(__d8(__NL(Location_))),COUNT(__d8(__NN(Location_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','prim_range',COUNT(__d8(__NL(Primary_Range_))),COUNT(__d8(__NN(Primary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','predir',COUNT(__d8(__NL(Predirectional_))),COUNT(__d8(__NN(Predirectional_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','prim_name',COUNT(__d8(__NL(Primary_Name_))),COUNT(__d8(__NN(Primary_Name_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','suffix',COUNT(__d8(__NL(Suffix_))),COUNT(__d8(__NN(Suffix_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','postdir',COUNT(__d8(__NL(Postdirectional_))),COUNT(__d8(__NN(Postdirectional_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','UnitDesignation',COUNT(__d8(__NL(Unit_Designation_))),COUNT(__d8(__NN(Unit_Designation_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','sec_range',COUNT(__d8(__NL(Secondary_Range_))),COUNT(__d8(__NN(Secondary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','PostalCity',COUNT(__d8(__NL(Postal_City_))),COUNT(__d8(__NN(Postal_City_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','VerifiedCity',COUNT(__d8(__NL(Verified_City_))),COUNT(__d8(__NN(Verified_City_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','State',COUNT(__d8(__NL(State_))),COUNT(__d8(__NN(State_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','zip',COUNT(__d8(__NL(Z_I_P5_))),COUNT(__d8(__NN(Z_I_P5_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','ZIP4',COUNT(__d8(__NL(Z_I_P4_))),COUNT(__d8(__NN(Z_I_P4_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','AddressRank',COUNT(__d8(__NL(Address_Rank_))),COUNT(__d8(__NN(Address_Rank_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','InsuranceSourceCount',COUNT(__d8(__NL(Insurance_Source_Count_))),COUNT(__d8(__NN(Insurance_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','PropertySourceCount',COUNT(__d8(__NL(Property_Source_Count_))),COUNT(__d8(__NN(Property_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','UtilitySourceCount',COUNT(__d8(__NL(Utility_Source_Count_))),COUNT(__d8(__NN(Utility_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','VehicleSourceCount',COUNT(__d8(__NL(Vehicle_Source_Count_))),COUNT(__d8(__NN(Vehicle_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','DLSourceCount',COUNT(__d8(__NL(D_L_Source_Count_))),COUNT(__d8(__NN(D_L_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','VoterSourceCount',COUNT(__d8(__NL(Voter_Source_Count_))),COUNT(__d8(__NN(Voter_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','AddressType',COUNT(__d8(__NL(Address_Type_))),COUNT(__d8(__NN(Address_Type_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','AddressStatus',COUNT(__d8(__NL(Address_Status_))),COUNT(__d8(__NN(Address_Status_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','StateCode',COUNT(__d8(__NL(State_Code_))),COUNT(__d8(__NN(State_Code_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','CountyCode',COUNT(__d8(__NL(County_Code_))),COUNT(__d8(__NN(County_Code_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','Latitude',COUNT(__d8(__NL(Latitude_))),COUNT(__d8(__NN(Latitude_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','Longitude',COUNT(__d8(__NL(Longitude_))),COUNT(__d8(__NN(Longitude_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','GeoLinkID',COUNT(__d8(__NL(Geo_Link_I_D_))),COUNT(__d8(__NN(Geo_Link_I_D_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','GeoBlk',COUNT(__d8(__NL(Geo_Blk_))),COUNT(__d8(__NN(Geo_Blk_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','GeoMmatch',COUNT(__d8(__NL(Geo_Mmatch_))),COUNT(__d8(__NN(Geo_Mmatch_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','Cart',COUNT(__d8(__NL(Cart_))),COUNT(__d8(__NN(Cart_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','CRSortSz',COUNT(__d8(__NL(C_R_Sort_Sz_))),COUNT(__d8(__NN(C_R_Sort_Sz_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','Lot',COUNT(__d8(__NL(Lot_))),COUNT(__d8(__NN(Lot_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','LotOrder',COUNT(__d8(__NL(Lot_Order_))),COUNT(__d8(__NN(Lot_Order_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','DPBC',COUNT(__d8(__NL(D_P_B_C_))),COUNT(__d8(__NN(D_P_B_C_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','CHKDigit',COUNT(__d8(__NL(C_H_K_Digit_))),COUNT(__d8(__NN(C_H_K_Digit_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','AceFipsSt',COUNT(__d8(__NL(Ace_Fips_St_))),COUNT(__d8(__NN(Ace_Fips_St_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','AceFipsCounty',COUNT(__d8(__NL(Ace_Fips_County_))),COUNT(__d8(__NN(Ace_Fips_County_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','MSA',COUNT(__d8(__NL(M_S_A_))),COUNT(__d8(__NN(M_S_A_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','FDNIndicator',COUNT(__d8(__NL(F_D_N_Indicator_))),COUNT(__d8(__NN(F_D_N_Indicator_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','src',COUNT(__d8(__NL(Source_))),COUNT(__d8(__NN(Source_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','Archive_Date',COUNT(__d8(Archive___Date_=0)),COUNT(__d8(Archive___Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','DateFirstSeen',COUNT(__d8(Date_First_Seen_=0)),COUNT(__d8(Date_First_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','DateLastSeen',COUNT(__d8(Date_Last_Seen_=0)),COUNT(__d8(Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','HybridArchiveDate',COUNT(__d8(Hybrid_Archive_Date_=0)),COUNT(__d8(Hybrid_Archive_Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','VaultDateLastSeen',COUNT(__d8(Vault_Date_Last_Seen_=0)),COUNT(__d8(Vault_Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','did',COUNT(__d9(__NL(Subject_))),COUNT(__d9(__NN(Subject_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','Location',COUNT(__d9(__NL(Location_))),COUNT(__d9(__NN(Location_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','prim_range',COUNT(__d9(__NL(Primary_Range_))),COUNT(__d9(__NN(Primary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','predir',COUNT(__d9(__NL(Predirectional_))),COUNT(__d9(__NN(Predirectional_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','prim_name',COUNT(__d9(__NL(Primary_Name_))),COUNT(__d9(__NN(Primary_Name_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','suffix',COUNT(__d9(__NL(Suffix_))),COUNT(__d9(__NN(Suffix_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','postdir',COUNT(__d9(__NL(Postdirectional_))),COUNT(__d9(__NN(Postdirectional_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','UnitDesignation',COUNT(__d9(__NL(Unit_Designation_))),COUNT(__d9(__NN(Unit_Designation_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','sec_range',COUNT(__d9(__NL(Secondary_Range_))),COUNT(__d9(__NN(Secondary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','PostalCity',COUNT(__d9(__NL(Postal_City_))),COUNT(__d9(__NN(Postal_City_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','VerifiedCity',COUNT(__d9(__NL(Verified_City_))),COUNT(__d9(__NN(Verified_City_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','State',COUNT(__d9(__NL(State_))),COUNT(__d9(__NN(State_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','zip',COUNT(__d9(__NL(Z_I_P5_))),COUNT(__d9(__NN(Z_I_P5_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','ZIP4',COUNT(__d9(__NL(Z_I_P4_))),COUNT(__d9(__NN(Z_I_P4_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','AddressRank',COUNT(__d9(__NL(Address_Rank_))),COUNT(__d9(__NN(Address_Rank_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','InsuranceSourceCount',COUNT(__d9(__NL(Insurance_Source_Count_))),COUNT(__d9(__NN(Insurance_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','PropertySourceCount',COUNT(__d9(__NL(Property_Source_Count_))),COUNT(__d9(__NN(Property_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','UtilitySourceCount',COUNT(__d9(__NL(Utility_Source_Count_))),COUNT(__d9(__NN(Utility_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','VehicleSourceCount',COUNT(__d9(__NL(Vehicle_Source_Count_))),COUNT(__d9(__NN(Vehicle_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','DLSourceCount',COUNT(__d9(__NL(D_L_Source_Count_))),COUNT(__d9(__NN(D_L_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','VoterSourceCount',COUNT(__d9(__NL(Voter_Source_Count_))),COUNT(__d9(__NN(Voter_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','AddressType',COUNT(__d9(__NL(Address_Type_))),COUNT(__d9(__NN(Address_Type_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','AddressStatus',COUNT(__d9(__NL(Address_Status_))),COUNT(__d9(__NN(Address_Status_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','StateCode',COUNT(__d9(__NL(State_Code_))),COUNT(__d9(__NN(State_Code_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','CountyCode',COUNT(__d9(__NL(County_Code_))),COUNT(__d9(__NN(County_Code_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','Latitude',COUNT(__d9(__NL(Latitude_))),COUNT(__d9(__NN(Latitude_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','Longitude',COUNT(__d9(__NL(Longitude_))),COUNT(__d9(__NN(Longitude_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','GeoLinkID',COUNT(__d9(__NL(Geo_Link_I_D_))),COUNT(__d9(__NN(Geo_Link_I_D_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','GeoBlk',COUNT(__d9(__NL(Geo_Blk_))),COUNT(__d9(__NN(Geo_Blk_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','GeoMmatch',COUNT(__d9(__NL(Geo_Mmatch_))),COUNT(__d9(__NN(Geo_Mmatch_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','Cart',COUNT(__d9(__NL(Cart_))),COUNT(__d9(__NN(Cart_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','CRSortSz',COUNT(__d9(__NL(C_R_Sort_Sz_))),COUNT(__d9(__NN(C_R_Sort_Sz_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','Lot',COUNT(__d9(__NL(Lot_))),COUNT(__d9(__NN(Lot_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','LotOrder',COUNT(__d9(__NL(Lot_Order_))),COUNT(__d9(__NN(Lot_Order_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','DPBC',COUNT(__d9(__NL(D_P_B_C_))),COUNT(__d9(__NN(D_P_B_C_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','CHKDigit',COUNT(__d9(__NL(C_H_K_Digit_))),COUNT(__d9(__NN(C_H_K_Digit_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','AceFipsSt',COUNT(__d9(__NL(Ace_Fips_St_))),COUNT(__d9(__NN(Ace_Fips_St_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','AceFipsCounty',COUNT(__d9(__NL(Ace_Fips_County_))),COUNT(__d9(__NN(Ace_Fips_County_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','MSA',COUNT(__d9(__NL(M_S_A_))),COUNT(__d9(__NN(M_S_A_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','FDNIndicator',COUNT(__d9(__NL(F_D_N_Indicator_))),COUNT(__d9(__NN(F_D_N_Indicator_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','src',COUNT(__d9(__NL(Source_))),COUNT(__d9(__NN(Source_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','Archive_Date',COUNT(__d9(Archive___Date_=0)),COUNT(__d9(Archive___Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','DateFirstSeen',COUNT(__d9(Date_First_Seen_=0)),COUNT(__d9(Date_First_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','DateLastSeen',COUNT(__d9(Date_Last_Seen_=0)),COUNT(__d9(Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','HybridArchiveDate',COUNT(__d9(Hybrid_Archive_Date_=0)),COUNT(__d9(Hybrid_Archive_Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','VaultDateLastSeen',COUNT(__d9(Vault_Date_Last_Seen_=0)),COUNT(__d9(Vault_Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','s_did',COUNT(__d10(__NL(Subject_))),COUNT(__d10(__NN(Subject_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','Location',COUNT(__d10(__NL(Location_))),COUNT(__d10(__NN(Location_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','prim_range',COUNT(__d10(__NL(Primary_Range_))),COUNT(__d10(__NN(Primary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','predir',COUNT(__d10(__NL(Predirectional_))),COUNT(__d10(__NN(Predirectional_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','prim_name',COUNT(__d10(__NL(Primary_Name_))),COUNT(__d10(__NN(Primary_Name_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','suffix',COUNT(__d10(__NL(Suffix_))),COUNT(__d10(__NN(Suffix_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','postdir',COUNT(__d10(__NL(Postdirectional_))),COUNT(__d10(__NN(Postdirectional_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','unit_desig',COUNT(__d10(__NL(Unit_Designation_))),COUNT(__d10(__NN(Unit_Designation_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','sec_range',COUNT(__d10(__NL(Secondary_Range_))),COUNT(__d10(__NN(Secondary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','v_city_name',COUNT(__d10(__NL(Postal_City_))),COUNT(__d10(__NN(Postal_City_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','VerifiedCity',COUNT(__d10(__NL(Verified_City_))),COUNT(__d10(__NN(Verified_City_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','st',COUNT(__d10(__NL(State_))),COUNT(__d10(__NN(State_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','zip',COUNT(__d10(__NL(Z_I_P5_))),COUNT(__d10(__NN(Z_I_P5_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','zip4',COUNT(__d10(__NL(Z_I_P4_))),COUNT(__d10(__NN(Z_I_P4_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','address_history_seq',COUNT(__d10(__NL(Address_Rank_))),COUNT(__d10(__NN(Address_Rank_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','Insurance_Source_Count',COUNT(__d10(__NL(Insurance_Source_Count_))),COUNT(__d10(__NN(Insurance_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','Property_Source_Count',COUNT(__d10(__NL(Property_Source_Count_))),COUNT(__d10(__NN(Property_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','Utility_Source_Count',COUNT(__d10(__NL(Utility_Source_Count_))),COUNT(__d10(__NN(Utility_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','Vehicle_Source_Count',COUNT(__d10(__NL(Vehicle_Source_Count_))),COUNT(__d10(__NN(Vehicle_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','DL_Source_Count',COUNT(__d10(__NL(D_L_Source_Count_))),COUNT(__d10(__NN(D_L_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','Voter_Source_Count',COUNT(__d10(__NL(Voter_Source_Count_))),COUNT(__d10(__NN(Voter_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','AddressType',COUNT(__d10(__NL(Address_Type_))),COUNT(__d10(__NN(Address_Type_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','err_stat',COUNT(__d10(__NL(Address_Status_))),COUNT(__d10(__NN(Address_Status_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','StateCode',COUNT(__d10(__NL(State_Code_))),COUNT(__d10(__NN(State_Code_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','county',COUNT(__d10(__NL(County_Code_))),COUNT(__d10(__NN(County_Code_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','geo_lat',COUNT(__d10(__NL(Latitude_))),COUNT(__d10(__NN(Latitude_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','geo_long',COUNT(__d10(__NL(Longitude_))),COUNT(__d10(__NN(Longitude_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','GeoLinkID',COUNT(__d10(__NL(Geo_Link_I_D_))),COUNT(__d10(__NN(Geo_Link_I_D_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','geo_blk',COUNT(__d10(__NL(Geo_Blk_))),COUNT(__d10(__NN(Geo_Blk_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','geo_match',COUNT(__d10(__NL(Geo_Mmatch_))),COUNT(__d10(__NN(Geo_Mmatch_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','Cart',COUNT(__d10(__NL(Cart_))),COUNT(__d10(__NN(Cart_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','CRSortSz',COUNT(__d10(__NL(C_R_Sort_Sz_))),COUNT(__d10(__NN(C_R_Sort_Sz_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','Lot',COUNT(__d10(__NL(Lot_))),COUNT(__d10(__NN(Lot_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','LotOrder',COUNT(__d10(__NL(Lot_Order_))),COUNT(__d10(__NN(Lot_Order_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','DPBC',COUNT(__d10(__NL(D_P_B_C_))),COUNT(__d10(__NN(D_P_B_C_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','CHKDigit',COUNT(__d10(__NL(C_H_K_Digit_))),COUNT(__d10(__NN(C_H_K_Digit_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','AceFipsSt',COUNT(__d10(__NL(Ace_Fips_St_))),COUNT(__d10(__NN(Ace_Fips_St_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','AceFipsCounty',COUNT(__d10(__NL(Ace_Fips_County_))),COUNT(__d10(__NN(Ace_Fips_County_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','MSA',COUNT(__d10(__NL(M_S_A_))),COUNT(__d10(__NN(M_S_A_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','HeaderHitFlag',COUNT(__d10(__NL(Header_Hit_Flag_))),COUNT(__d10(__NN(Header_Hit_Flag_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','FDNIndicator',COUNT(__d10(__NL(F_D_N_Indicator_))),COUNT(__d10(__NN(F_D_N_Indicator_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','src',COUNT(__d10(__NL(Source_))),COUNT(__d10(__NN(Source_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','Archive_Date',COUNT(__d10(Archive___Date_=0)),COUNT(__d10(Archive___Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','DateFirstSeen',COUNT(__d10(Date_First_Seen_=0)),COUNT(__d10(Date_First_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','DateLastSeen',COUNT(__d10(Date_Last_Seen_=0)),COUNT(__d10(Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','HybridArchiveDate',COUNT(__d10(Hybrid_Archive_Date_=0)),COUNT(__d10(Hybrid_Archive_Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','VaultDateLastSeen',COUNT(__d10(Vault_Date_Last_Seen_=0)),COUNT(__d10(Vault_Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','did',COUNT(__d11(__NL(Subject_))),COUNT(__d11(__NN(Subject_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','Location',COUNT(__d11(__NL(Location_))),COUNT(__d11(__NN(Location_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','prim_range',COUNT(__d11(__NL(Primary_Range_))),COUNT(__d11(__NN(Primary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','predir',COUNT(__d11(__NL(Predirectional_))),COUNT(__d11(__NN(Predirectional_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','prim_name',COUNT(__d11(__NL(Primary_Name_))),COUNT(__d11(__NN(Primary_Name_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','suffix',COUNT(__d11(__NL(Suffix_))),COUNT(__d11(__NN(Suffix_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','postdir',COUNT(__d11(__NL(Postdirectional_))),COUNT(__d11(__NN(Postdirectional_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','UnitDesignation',COUNT(__d11(__NL(Unit_Designation_))),COUNT(__d11(__NN(Unit_Designation_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','sec_range',COUNT(__d11(__NL(Secondary_Range_))),COUNT(__d11(__NN(Secondary_Range_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','PostalCity',COUNT(__d11(__NL(Postal_City_))),COUNT(__d11(__NN(Postal_City_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','VerifiedCity',COUNT(__d11(__NL(Verified_City_))),COUNT(__d11(__NN(Verified_City_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','State',COUNT(__d11(__NL(State_))),COUNT(__d11(__NN(State_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','zip',COUNT(__d11(__NL(Z_I_P5_))),COUNT(__d11(__NN(Z_I_P5_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','ZIP4',COUNT(__d11(__NL(Z_I_P4_))),COUNT(__d11(__NN(Z_I_P4_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','AddressRank',COUNT(__d11(__NL(Address_Rank_))),COUNT(__d11(__NN(Address_Rank_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','InsuranceSourceCount',COUNT(__d11(__NL(Insurance_Source_Count_))),COUNT(__d11(__NN(Insurance_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','PropertySourceCount',COUNT(__d11(__NL(Property_Source_Count_))),COUNT(__d11(__NN(Property_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','UtilitySourceCount',COUNT(__d11(__NL(Utility_Source_Count_))),COUNT(__d11(__NN(Utility_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','VehicleSourceCount',COUNT(__d11(__NL(Vehicle_Source_Count_))),COUNT(__d11(__NN(Vehicle_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','DLSourceCount',COUNT(__d11(__NL(D_L_Source_Count_))),COUNT(__d11(__NN(D_L_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','VoterSourceCount',COUNT(__d11(__NL(Voter_Source_Count_))),COUNT(__d11(__NN(Voter_Source_Count_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','AddressType',COUNT(__d11(__NL(Address_Type_))),COUNT(__d11(__NN(Address_Type_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','AddressStatus',COUNT(__d11(__NL(Address_Status_))),COUNT(__d11(__NN(Address_Status_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','StateCode',COUNT(__d11(__NL(State_Code_))),COUNT(__d11(__NN(State_Code_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','CountyCode',COUNT(__d11(__NL(County_Code_))),COUNT(__d11(__NN(County_Code_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','Latitude',COUNT(__d11(__NL(Latitude_))),COUNT(__d11(__NN(Latitude_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','Longitude',COUNT(__d11(__NL(Longitude_))),COUNT(__d11(__NN(Longitude_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','GeoLinkID',COUNT(__d11(__NL(Geo_Link_I_D_))),COUNT(__d11(__NN(Geo_Link_I_D_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','GeoBlk',COUNT(__d11(__NL(Geo_Blk_))),COUNT(__d11(__NN(Geo_Blk_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','GeoMmatch',COUNT(__d11(__NL(Geo_Mmatch_))),COUNT(__d11(__NN(Geo_Mmatch_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','Cart',COUNT(__d11(__NL(Cart_))),COUNT(__d11(__NN(Cart_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','CRSortSz',COUNT(__d11(__NL(C_R_Sort_Sz_))),COUNT(__d11(__NN(C_R_Sort_Sz_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','Lot',COUNT(__d11(__NL(Lot_))),COUNT(__d11(__NN(Lot_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','LotOrder',COUNT(__d11(__NL(Lot_Order_))),COUNT(__d11(__NN(Lot_Order_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','DPBC',COUNT(__d11(__NL(D_P_B_C_))),COUNT(__d11(__NN(D_P_B_C_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','CHKDigit',COUNT(__d11(__NL(C_H_K_Digit_))),COUNT(__d11(__NN(C_H_K_Digit_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','AceFipsSt',COUNT(__d11(__NL(Ace_Fips_St_))),COUNT(__d11(__NN(Ace_Fips_St_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','AceFipsCounty',COUNT(__d11(__NL(Ace_Fips_County_))),COUNT(__d11(__NN(Ace_Fips_County_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','MSA',COUNT(__d11(__NL(M_S_A_))),COUNT(__d11(__NN(M_S_A_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','FDNIndicator',COUNT(__d11(__NL(F_D_N_Indicator_))),COUNT(__d11(__NN(F_D_N_Indicator_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','src',COUNT(__d11(__NL(Source_))),COUNT(__d11(__NN(Source_)))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','Archive_Date',COUNT(__d11(Archive___Date_=0)),COUNT(__d11(Archive___Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','DateFirstSeen',COUNT(__d11(Date_First_Seen_=0)),COUNT(__d11(Date_First_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','DateLastSeen',COUNT(__d11(Date_Last_Seen_=0)),COUNT(__d11(Date_Last_Seen_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','HybridArchiveDate',COUNT(__d11(Hybrid_Archive_Date_=0)),COUNT(__d11(Hybrid_Archive_Date_!=0))},
    {'PersonAddress','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Address_Vault','VaultDateLastSeen',COUNT(__d11(Vault_Date_Last_Seen_=0)),COUNT(__d11(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
