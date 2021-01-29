//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Address,E_Geo_Link,E_Phone,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_Address_Phone(CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nint Best_Address_Match_Flag_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Postal_City_;
    KEL.typ.nstr Verified_City_;
    KEL.typ.nstr State_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nint Z_I_P4_;
    KEL.typ.nstr Latitude_;
    KEL.typ.nstr Longitude_;
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
    KEL.typ.nstr Prior_Area_Code_;
    KEL.typ.nstr Current_Flag_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Publish_Code_;
    KEL.typ.nstr Listing_Type_;
    KEL.typ.nstr Is_Active_;
    KEL.typ.nstr Omit_Indicator_;
    KEL.typ.nstr Source_;
    KEL.typ.nstr Original_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    DATA57 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'phonenumber(DEFAULT:Phone_Number_:0),Location_(DEFAULT:Location_:0),bestaddressmatchflag(DEFAULT:Best_Address_Match_Flag_:0),primaryrange(DEFAULT:Primary_Range_:\'\'),predirectional(DEFAULT:Predirectional_:\'\'),primaryname(DEFAULT:Primary_Name_:\'\'),suffix(DEFAULT:Suffix_:\'\'),postdirectional(DEFAULT:Postdirectional_:\'\'),secondaryrange(DEFAULT:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),verifiedcity(DEFAULT:Verified_City_:\'\'),state(DEFAULT:State_),zip5(DEFAULT:Z_I_P5_:0),zip4(DEFAULT:Z_I_P4_),latitude(DEFAULT:Latitude_:\'\'),longitude(DEFAULT:Longitude_:\'\'),geoblk(DEFAULT:Geo_Blk_:\'\'),geommatch(DEFAULT:Geo_Mmatch_:\'\'),cart(DEFAULT:Cart_:\'\'),crsortsz(DEFAULT:C_R_Sort_Sz_:\'\'),lot(DEFAULT:Lot_:\'\'),lotorder(DEFAULT:Lot_Order_:\'\'),dpbc(DEFAULT:D_P_B_C_:\'\'),chkdigit(DEFAULT:C_H_K_Digit_:\'\'),acefipsst(DEFAULT:Ace_Fips_St_:\'\'),acefipscounty(DEFAULT:Ace_Fips_County_:\'\'),msa(DEFAULT:M_S_A_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),source(DEFAULT:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED Hybrid_Archive_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'phone(OVERRIDE:Phone_Number_:0),Location_(DEFAULT:Location_:0),bestaddressmatchflag(DEFAULT:Best_Address_Match_Flag_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),verifiedcity(DEFAULT:Verified_City_:\'\'),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(DEFAULT:Z_I_P4_),latitude(DEFAULT:Latitude_:\'\'),longitude(DEFAULT:Longitude_:\'\'),geoblk(DEFAULT:Geo_Blk_:\'\'),geommatch(DEFAULT:Geo_Mmatch_:\'\'),cart(DEFAULT:Cart_:\'\'),crsortsz(DEFAULT:C_R_Sort_Sz_:\'\'),lot(DEFAULT:Lot_:\'\'),lotorder(DEFAULT:Lot_Order_:\'\'),dpbc(DEFAULT:D_P_B_C_:\'\'),chkdigit(DEFAULT:C_H_K_Digit_:\'\'),acefipsst(DEFAULT:Ace_Fips_St_:\'\'),acefipscounty(DEFAULT:Ace_Fips_County_:\'\'),msa(DEFAULT:M_S_A_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_0Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d0_KELfiltered := PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault((STRING28)prim_name != '' AND (UNSIGNED)zip != 0);
  SHARED __d0_Location__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d0_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_KELfiltered,'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault');
  SHARED __d0_Location__Mapped := IF(__d0_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range',PROJECT(__d0_KELfiltered,TRANSFORM(__d0_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_KELfiltered,__d0_Missing_Location__UIDComponents),E_Address(__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d0_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Prefiltered := __d0_Location__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault'));
  SHARED Hybrid_Archive_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'phone10(OVERRIDE:Phone_Number_:0),Location_(DEFAULT:Location_:0),bestaddressmatchflag(DEFAULT:Best_Address_Match_Flag_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),verifiedcity(DEFAULT:Verified_City_:\'\'),state(DEFAULT:State_),z5(OVERRIDE:Z_I_P5_:0),zip4(DEFAULT:Z_I_P4_),latitude(DEFAULT:Latitude_:\'\'),longitude(DEFAULT:Longitude_:\'\'),geoblk(DEFAULT:Geo_Blk_:\'\'),geommatch(DEFAULT:Geo_Mmatch_:\'\'),cart(DEFAULT:Cart_:\'\'),crsortsz(DEFAULT:C_R_Sort_Sz_:\'\'),lot(DEFAULT:Lot_:\'\'),lotorder(DEFAULT:Lot_Order_:\'\'),dpbc(DEFAULT:D_P_B_C_:\'\'),chkdigit(DEFAULT:C_H_K_Digit_:\'\'),acefipsst(DEFAULT:Ace_Fips_St_:\'\'),acefipscounty(DEFAULT:Ace_Fips_County_:\'\'),msa(DEFAULT:M_S_A_:\'\'),prior_area_code(OVERRIDE:Prior_Area_Code_:\'\'),current_flag(OVERRIDE:Current_Flag_:\'\'),business_flag(OVERRIDE:Business_Flag_:\'\'),publish_code(OVERRIDE:Publish_Code_:\'\'),listing_type(OVERRIDE:Listing_Type_:\'\'),current_record_flag(OVERRIDE:Is_Active_:\'\'),omit_phone(OVERRIDE:Omit_Indicator_:\'\'),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_1Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d1_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault((STRING28)prim_name != '' AND (UNSIGNED3)z5 != 0 AND (UNSIGNED)phone10 != 0);
  SHARED __d1_Location__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d1_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,z5,sec_range','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault');
  SHARED __d1_Location__Mapped := IF(__d1_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,suffix,postdir,z5,sec_range',PROJECT(__d1_KELfiltered,TRANSFORM(__d1_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_KELfiltered,__d1_Missing_Location__UIDComponents),E_Address(__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.z5) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d1_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d1_Prefiltered := __d1_Location__Mapped;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault'));
  SHARED Date_First_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Date_Last_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping2 := 'phonenumber(DEFAULT:Phone_Number_:0),Location_(DEFAULT:Location_:0),bestaddressmatchflag(DEFAULT:Best_Address_Match_Flag_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),p_city_name(OVERRIDE:Postal_City_),v_city_name(OVERRIDE:Verified_City_:\'\'),state(OVERRIDE:State_),zip5(OVERRIDE:Z_I_P5_:0),zip4(OVERRIDE:Z_I_P4_),geo_lat(OVERRIDE:Latitude_:\'\'),geo_long(OVERRIDE:Longitude_:\'\'),geo_blk(OVERRIDE:Geo_Blk_:\'\'),geo_match(OVERRIDE:Geo_Mmatch_:\'\'),cart(OVERRIDE:Cart_:\'\'),cr_sort_sz(OVERRIDE:C_R_Sort_Sz_:\'\'),lot(OVERRIDE:Lot_:\'\'),lot_order(OVERRIDE:Lot_Order_:\'\'),dpbc(OVERRIDE:D_P_B_C_:\'\'),chk_digit(OVERRIDE:C_H_K_Digit_:\'\'),ace_fips_st(OVERRIDE:Ace_Fips_St_:\'\'),ace_fips_county(OVERRIDE:Ace_Fips_County_:\'\'),msa(OVERRIDE:M_S_A_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),current_rec(OVERRIDE:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),src(OVERRIDE:Source_:\'\'),source(OVERRIDE:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_2Rule),datelastseen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_2Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d2_KELfiltered := PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault((STRING28)prim_name != '' AND (UNSIGNED3)zip5 != 0 AND (UNSIGNED)cellphone != 0);
  SHARED __d2_Location__Layout := RECORD
    RECORDOF(__d2_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d2_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d2_KELfiltered,'prim_range,predir,prim_name,addr_suffix,postdir,zip5,sec_range','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault');
  SHARED __d2_Location__Mapped := IF(__d2_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,addr_suffix,postdir,zip5,sec_range',PROJECT(__d2_KELfiltered,TRANSFORM(__d2_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d2_KELfiltered,__d2_Missing_Location__UIDComponents),E_Address(__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip5) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d2_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d2_Prefiltered := __d2_Location__Mapped;
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault'));
  SHARED Hybrid_Archive_Date_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping3 := 'phone10(OVERRIDE:Phone_Number_:0),Location_(DEFAULT:Location_:0),bestaddressmatchflag(DEFAULT:Best_Address_Match_Flag_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),verifiedcity(DEFAULT:Verified_City_:\'\'),state(DEFAULT:State_),z5(OVERRIDE:Z_I_P5_:0),zip4(DEFAULT:Z_I_P4_),latitude(DEFAULT:Latitude_:\'\'),longitude(DEFAULT:Longitude_:\'\'),geoblk(DEFAULT:Geo_Blk_:\'\'),geommatch(DEFAULT:Geo_Mmatch_:\'\'),cart(DEFAULT:Cart_:\'\'),crsortsz(DEFAULT:C_R_Sort_Sz_:\'\'),lot(DEFAULT:Lot_:\'\'),lotorder(DEFAULT:Lot_Order_:\'\'),dpbc(DEFAULT:D_P_B_C_:\'\'),chkdigit(DEFAULT:C_H_K_Digit_:\'\'),acefipsst(DEFAULT:Ace_Fips_St_:\'\'),acefipscounty(DEFAULT:Ace_Fips_County_:\'\'),msa(DEFAULT:M_S_A_:\'\'),prior_area_code(OVERRIDE:Prior_Area_Code_:\'\'),current_flag(OVERRIDE:Current_Flag_:\'\'),business_flag(OVERRIDE:Business_Flag_:\'\'),publish_code(OVERRIDE:Publish_Code_:\'\'),listing_type(OVERRIDE:Listing_Type_:\'\'),current_record_flag(OVERRIDE:Is_Active_:\'\'),omit_phone(OVERRIDE:Omit_Indicator_:\'\'),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_3Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d3_KELfiltered := PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault((STRING28)prim_name != '' AND (UNSIGNED3)z5 != 0 AND (UNSIGNED)phone10 != 0);
  SHARED __d3_Location__Layout := RECORD
    RECORDOF(__d3_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d3_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d3_KELfiltered,'prim_range,predir,prim_name,suffix,postdir,z5,sec_range','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault');
  SHARED __d3_Location__Mapped := IF(__d3_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,suffix,postdir,z5,sec_range',PROJECT(__d3_KELfiltered,TRANSFORM(__d3_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d3_KELfiltered,__d3_Missing_Location__UIDComponents),E_Address(__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.z5) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d3_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d3_Prefiltered := __d3_Location__Mapped;
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3;
  EXPORT Best_Address_Match_Flags_Layout := RECORD
    KEL.typ.nint Best_Address_Match_Flag_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Gong_Phone_Details_Layout := RECORD
    KEL.typ.nstr Prior_Area_Code_;
    KEL.typ.nstr Current_Flag_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Publish_Code_;
    KEL.typ.nstr Listing_Type_;
    KEL.typ.nstr Is_Active_;
    KEL.typ.nstr Omit_Indicator_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nstr Original_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nint Z_I_P4_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Postal_City_;
    KEL.typ.nstr Verified_City_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Latitude_;
    KEL.typ.nstr Longitude_;
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
    KEL.typ.ndataset(Best_Address_Match_Flags_Layout) Best_Address_Match_Flags_;
    KEL.typ.ndataset(Gong_Phone_Details_Layout) Gong_Phone_Details_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Phone_Number_,Location_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Z_I_P5_,Z_I_P4_,Secondary_Range_,Postal_City_,Verified_City_,State_,Latitude_,Longitude_,Geo_Blk_,Geo_Mmatch_,Cart_,C_R_Sort_Sz_,Lot_,Lot_Order_,D_P_B_C_,C_H_K_Digit_,Ace_Fips_St_,Ace_Fips_County_,M_S_A_,ALL));
  Address_Phone_Group := __PostFilter;
  Layout Address_Phone__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Best_Address_Match_Flags_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Best_Address_Match_Flag_},Best_Address_Match_Flag_),Best_Address_Match_Flags_Layout)(__NN(Best_Address_Match_Flag_)));
    SELF.Gong_Phone_Details_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Prior_Area_Code_,Current_Flag_,Business_Flag_,Publish_Code_,Listing_Type_,Is_Active_,Omit_Indicator_,Source_},Prior_Area_Code_,Current_Flag_,Business_Flag_,Publish_Code_,Listing_Type_,Is_Active_,Omit_Indicator_,Source_),Gong_Phone_Details_Layout)(__NN(Prior_Area_Code_) OR __NN(Current_Flag_) OR __NN(Business_Flag_) OR __NN(Publish_Code_) OR __NN(Listing_Type_) OR __NN(Is_Active_) OR __NN(Omit_Indicator_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_,Original_Source_},Source_,Original_Source_),Data_Sources_Layout)(__NN(Source_) OR __NN(Original_Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Address_Phone__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Best_Address_Match_Flags_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Best_Address_Match_Flags_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Best_Address_Match_Flag_)));
    SELF.Gong_Phone_Details_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Gong_Phone_Details_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Prior_Area_Code_) OR __NN(Current_Flag_) OR __NN(Business_Flag_) OR __NN(Publish_Code_) OR __NN(Listing_Type_) OR __NN(Is_Active_) OR __NN(Omit_Indicator_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_) OR __NN(Original_Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Address_Phone_Group,COUNT(ROWS(LEFT))=1),GROUP,Address_Phone__Single_Rollup(LEFT)) + ROLLUP(HAVING(Address_Phone_Group,COUNT(ROWS(LEFT))>1),GROUP,Address_Phone__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Phone_Number__Orphan := JOIN(InData(__NN(Phone_Number_)),E_Phone(__cfg).__Result,__EEQP(LEFT.Phone_Number_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Location__Orphan := JOIN(InData(__NN(Location_)),E_Address(__cfg).__Result,__EEQP(LEFT.Location_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Z_I_P5__Orphan := JOIN(InData(__NN(Z_I_P5_)),E_Zip_Code(__cfg).__Result,__EEQP(LEFT.Z_I_P5_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Phone_Number__Orphan),COUNT(Location__Orphan),COUNT(Z_I_P5__Orphan)}],{KEL.typ.int Phone_Number__Orphan,KEL.typ.int Location__Orphan,KEL.typ.int Z_I_P5__Orphan});
  EXPORT NullCounts := DATASET([
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','phone',COUNT(__d0(__NL(Phone_Number_))),COUNT(__d0(__NN(Phone_Number_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','Location',COUNT(__d0(__NL(Location_))),COUNT(__d0(__NN(Location_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','BestAddressMatchFlag',COUNT(__d0(__NL(Best_Address_Match_Flag_))),COUNT(__d0(__NN(Best_Address_Match_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','prim_range',COUNT(__d0(__NL(Primary_Range_))),COUNT(__d0(__NN(Primary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','predir',COUNT(__d0(__NL(Predirectional_))),COUNT(__d0(__NN(Predirectional_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','prim_name',COUNT(__d0(__NL(Primary_Name_))),COUNT(__d0(__NN(Primary_Name_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','addr_suffix',COUNT(__d0(__NL(Suffix_))),COUNT(__d0(__NN(Suffix_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','postdir',COUNT(__d0(__NL(Postdirectional_))),COUNT(__d0(__NN(Postdirectional_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','sec_range',COUNT(__d0(__NL(Secondary_Range_))),COUNT(__d0(__NN(Secondary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','PostalCity',COUNT(__d0(__NL(Postal_City_))),COUNT(__d0(__NN(Postal_City_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','VerifiedCity',COUNT(__d0(__NL(Verified_City_))),COUNT(__d0(__NN(Verified_City_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','State',COUNT(__d0(__NL(State_))),COUNT(__d0(__NN(State_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','zip',COUNT(__d0(__NL(Z_I_P5_))),COUNT(__d0(__NN(Z_I_P5_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','ZIP4',COUNT(__d0(__NL(Z_I_P4_))),COUNT(__d0(__NN(Z_I_P4_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','Latitude',COUNT(__d0(__NL(Latitude_))),COUNT(__d0(__NN(Latitude_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','Longitude',COUNT(__d0(__NL(Longitude_))),COUNT(__d0(__NN(Longitude_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','GeoBlk',COUNT(__d0(__NL(Geo_Blk_))),COUNT(__d0(__NN(Geo_Blk_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','GeoMmatch',COUNT(__d0(__NL(Geo_Mmatch_))),COUNT(__d0(__NN(Geo_Mmatch_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','Cart',COUNT(__d0(__NL(Cart_))),COUNT(__d0(__NN(Cart_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','CRSortSz',COUNT(__d0(__NL(C_R_Sort_Sz_))),COUNT(__d0(__NN(C_R_Sort_Sz_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','Lot',COUNT(__d0(__NL(Lot_))),COUNT(__d0(__NN(Lot_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','LotOrder',COUNT(__d0(__NL(Lot_Order_))),COUNT(__d0(__NN(Lot_Order_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','DPBC',COUNT(__d0(__NL(D_P_B_C_))),COUNT(__d0(__NN(D_P_B_C_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','CHKDigit',COUNT(__d0(__NL(C_H_K_Digit_))),COUNT(__d0(__NN(C_H_K_Digit_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','AceFipsSt',COUNT(__d0(__NL(Ace_Fips_St_))),COUNT(__d0(__NN(Ace_Fips_St_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','AceFipsCounty',COUNT(__d0(__NL(Ace_Fips_County_))),COUNT(__d0(__NN(Ace_Fips_County_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','MSA',COUNT(__d0(__NL(M_S_A_))),COUNT(__d0(__NN(M_S_A_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','PriorAreaCode',COUNT(__d0(__NL(Prior_Area_Code_))),COUNT(__d0(__NN(Prior_Area_Code_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','CurrentFlag',COUNT(__d0(__NL(Current_Flag_))),COUNT(__d0(__NN(Current_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','BusinessFlag',COUNT(__d0(__NL(Business_Flag_))),COUNT(__d0(__NN(Business_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','PublishCode',COUNT(__d0(__NL(Publish_Code_))),COUNT(__d0(__NN(Publish_Code_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','ListingType',COUNT(__d0(__NL(Listing_Type_))),COUNT(__d0(__NN(Listing_Type_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','IsActive',COUNT(__d0(__NL(Is_Active_))),COUNT(__d0(__NN(Is_Active_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','OmitIndicator',COUNT(__d0(__NL(Omit_Indicator_))),COUNT(__d0(__NN(Omit_Indicator_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','OriginalSource',COUNT(__d0(__NL(Original_Source_))),COUNT(__d0(__NN(Original_Source_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','phone10',COUNT(__d1(__NL(Phone_Number_))),COUNT(__d1(__NN(Phone_Number_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','Location',COUNT(__d1(__NL(Location_))),COUNT(__d1(__NN(Location_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','BestAddressMatchFlag',COUNT(__d1(__NL(Best_Address_Match_Flag_))),COUNT(__d1(__NN(Best_Address_Match_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','prim_range',COUNT(__d1(__NL(Primary_Range_))),COUNT(__d1(__NN(Primary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','predir',COUNT(__d1(__NL(Predirectional_))),COUNT(__d1(__NN(Predirectional_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','prim_name',COUNT(__d1(__NL(Primary_Name_))),COUNT(__d1(__NN(Primary_Name_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','suffix',COUNT(__d1(__NL(Suffix_))),COUNT(__d1(__NN(Suffix_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','postdir',COUNT(__d1(__NL(Postdirectional_))),COUNT(__d1(__NN(Postdirectional_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','sec_range',COUNT(__d1(__NL(Secondary_Range_))),COUNT(__d1(__NN(Secondary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','PostalCity',COUNT(__d1(__NL(Postal_City_))),COUNT(__d1(__NN(Postal_City_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','VerifiedCity',COUNT(__d1(__NL(Verified_City_))),COUNT(__d1(__NN(Verified_City_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','State',COUNT(__d1(__NL(State_))),COUNT(__d1(__NN(State_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','z5',COUNT(__d1(__NL(Z_I_P5_))),COUNT(__d1(__NN(Z_I_P5_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','ZIP4',COUNT(__d1(__NL(Z_I_P4_))),COUNT(__d1(__NN(Z_I_P4_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','Latitude',COUNT(__d1(__NL(Latitude_))),COUNT(__d1(__NN(Latitude_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','Longitude',COUNT(__d1(__NL(Longitude_))),COUNT(__d1(__NN(Longitude_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','GeoBlk',COUNT(__d1(__NL(Geo_Blk_))),COUNT(__d1(__NN(Geo_Blk_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','GeoMmatch',COUNT(__d1(__NL(Geo_Mmatch_))),COUNT(__d1(__NN(Geo_Mmatch_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','Cart',COUNT(__d1(__NL(Cart_))),COUNT(__d1(__NN(Cart_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','CRSortSz',COUNT(__d1(__NL(C_R_Sort_Sz_))),COUNT(__d1(__NN(C_R_Sort_Sz_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','Lot',COUNT(__d1(__NL(Lot_))),COUNT(__d1(__NN(Lot_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','LotOrder',COUNT(__d1(__NL(Lot_Order_))),COUNT(__d1(__NN(Lot_Order_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','DPBC',COUNT(__d1(__NL(D_P_B_C_))),COUNT(__d1(__NN(D_P_B_C_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','CHKDigit',COUNT(__d1(__NL(C_H_K_Digit_))),COUNT(__d1(__NN(C_H_K_Digit_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','AceFipsSt',COUNT(__d1(__NL(Ace_Fips_St_))),COUNT(__d1(__NN(Ace_Fips_St_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','AceFipsCounty',COUNT(__d1(__NL(Ace_Fips_County_))),COUNT(__d1(__NN(Ace_Fips_County_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','MSA',COUNT(__d1(__NL(M_S_A_))),COUNT(__d1(__NN(M_S_A_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','prior_area_code',COUNT(__d1(__NL(Prior_Area_Code_))),COUNT(__d1(__NN(Prior_Area_Code_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','current_flag',COUNT(__d1(__NL(Current_Flag_))),COUNT(__d1(__NN(Current_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','business_flag',COUNT(__d1(__NL(Business_Flag_))),COUNT(__d1(__NN(Business_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','publish_code',COUNT(__d1(__NL(Publish_Code_))),COUNT(__d1(__NN(Publish_Code_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','listing_type',COUNT(__d1(__NL(Listing_Type_))),COUNT(__d1(__NN(Listing_Type_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','current_record_flag',COUNT(__d1(__NL(Is_Active_))),COUNT(__d1(__NN(Is_Active_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','omit_phone',COUNT(__d1(__NL(Omit_Indicator_))),COUNT(__d1(__NN(Omit_Indicator_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','OriginalSource',COUNT(__d1(__NL(Original_Source_))),COUNT(__d1(__NN(Original_Source_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Address_Vault','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','PhoneNumber',COUNT(__d2(__NL(Phone_Number_))),COUNT(__d2(__NN(Phone_Number_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','Location',COUNT(__d2(__NL(Location_))),COUNT(__d2(__NN(Location_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','BestAddressMatchFlag',COUNT(__d2(__NL(Best_Address_Match_Flag_))),COUNT(__d2(__NN(Best_Address_Match_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','prim_range',COUNT(__d2(__NL(Primary_Range_))),COUNT(__d2(__NN(Primary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','predir',COUNT(__d2(__NL(Predirectional_))),COUNT(__d2(__NN(Predirectional_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','prim_name',COUNT(__d2(__NL(Primary_Name_))),COUNT(__d2(__NN(Primary_Name_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','addr_suffix',COUNT(__d2(__NL(Suffix_))),COUNT(__d2(__NN(Suffix_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','postdir',COUNT(__d2(__NL(Postdirectional_))),COUNT(__d2(__NN(Postdirectional_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','sec_range',COUNT(__d2(__NL(Secondary_Range_))),COUNT(__d2(__NN(Secondary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','p_city_name',COUNT(__d2(__NL(Postal_City_))),COUNT(__d2(__NN(Postal_City_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','v_city_name',COUNT(__d2(__NL(Verified_City_))),COUNT(__d2(__NN(Verified_City_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','state',COUNT(__d2(__NL(State_))),COUNT(__d2(__NN(State_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','zip5',COUNT(__d2(__NL(Z_I_P5_))),COUNT(__d2(__NN(Z_I_P5_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','zip4',COUNT(__d2(__NL(Z_I_P4_))),COUNT(__d2(__NN(Z_I_P4_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','geo_lat',COUNT(__d2(__NL(Latitude_))),COUNT(__d2(__NN(Latitude_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','geo_long',COUNT(__d2(__NL(Longitude_))),COUNT(__d2(__NN(Longitude_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','geo_blk',COUNT(__d2(__NL(Geo_Blk_))),COUNT(__d2(__NN(Geo_Blk_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','geo_match',COUNT(__d2(__NL(Geo_Mmatch_))),COUNT(__d2(__NN(Geo_Mmatch_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','cart',COUNT(__d2(__NL(Cart_))),COUNT(__d2(__NN(Cart_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','cr_sort_sz',COUNT(__d2(__NL(C_R_Sort_Sz_))),COUNT(__d2(__NN(C_R_Sort_Sz_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','lot',COUNT(__d2(__NL(Lot_))),COUNT(__d2(__NN(Lot_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','lot_order',COUNT(__d2(__NL(Lot_Order_))),COUNT(__d2(__NN(Lot_Order_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','dpbc',COUNT(__d2(__NL(D_P_B_C_))),COUNT(__d2(__NN(D_P_B_C_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','chk_digit',COUNT(__d2(__NL(C_H_K_Digit_))),COUNT(__d2(__NN(C_H_K_Digit_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','ace_fips_st',COUNT(__d2(__NL(Ace_Fips_St_))),COUNT(__d2(__NN(Ace_Fips_St_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','ace_fips_county',COUNT(__d2(__NL(Ace_Fips_County_))),COUNT(__d2(__NN(Ace_Fips_County_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','msa',COUNT(__d2(__NL(M_S_A_))),COUNT(__d2(__NN(M_S_A_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','PriorAreaCode',COUNT(__d2(__NL(Prior_Area_Code_))),COUNT(__d2(__NN(Prior_Area_Code_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','current_rec',COUNT(__d2(__NL(Current_Flag_))),COUNT(__d2(__NN(Current_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','BusinessFlag',COUNT(__d2(__NL(Business_Flag_))),COUNT(__d2(__NN(Business_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','PublishCode',COUNT(__d2(__NL(Publish_Code_))),COUNT(__d2(__NN(Publish_Code_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','ListingType',COUNT(__d2(__NL(Listing_Type_))),COUNT(__d2(__NN(Listing_Type_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','IsActive',COUNT(__d2(__NL(Is_Active_))),COUNT(__d2(__NN(Is_Active_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','OmitIndicator',COUNT(__d2(__NL(Omit_Indicator_))),COUNT(__d2(__NN(Omit_Indicator_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','Src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','source',COUNT(__d2(__NL(Original_Source_))),COUNT(__d2(__NN(Original_Source_)))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'AddressPhone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','phone10',COUNT(__d3(__NL(Phone_Number_))),COUNT(__d3(__NN(Phone_Number_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','Location',COUNT(__d3(__NL(Location_))),COUNT(__d3(__NN(Location_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','BestAddressMatchFlag',COUNT(__d3(__NL(Best_Address_Match_Flag_))),COUNT(__d3(__NN(Best_Address_Match_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','prim_range',COUNT(__d3(__NL(Primary_Range_))),COUNT(__d3(__NN(Primary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','predir',COUNT(__d3(__NL(Predirectional_))),COUNT(__d3(__NN(Predirectional_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','prim_name',COUNT(__d3(__NL(Primary_Name_))),COUNT(__d3(__NN(Primary_Name_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','suffix',COUNT(__d3(__NL(Suffix_))),COUNT(__d3(__NN(Suffix_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','postdir',COUNT(__d3(__NL(Postdirectional_))),COUNT(__d3(__NN(Postdirectional_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','sec_range',COUNT(__d3(__NL(Secondary_Range_))),COUNT(__d3(__NN(Secondary_Range_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','PostalCity',COUNT(__d3(__NL(Postal_City_))),COUNT(__d3(__NN(Postal_City_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','VerifiedCity',COUNT(__d3(__NL(Verified_City_))),COUNT(__d3(__NN(Verified_City_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','State',COUNT(__d3(__NL(State_))),COUNT(__d3(__NN(State_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','z5',COUNT(__d3(__NL(Z_I_P5_))),COUNT(__d3(__NN(Z_I_P5_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','ZIP4',COUNT(__d3(__NL(Z_I_P4_))),COUNT(__d3(__NN(Z_I_P4_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','Latitude',COUNT(__d3(__NL(Latitude_))),COUNT(__d3(__NN(Latitude_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','Longitude',COUNT(__d3(__NL(Longitude_))),COUNT(__d3(__NN(Longitude_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','GeoBlk',COUNT(__d3(__NL(Geo_Blk_))),COUNT(__d3(__NN(Geo_Blk_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','GeoMmatch',COUNT(__d3(__NL(Geo_Mmatch_))),COUNT(__d3(__NN(Geo_Mmatch_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','Cart',COUNT(__d3(__NL(Cart_))),COUNT(__d3(__NN(Cart_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','CRSortSz',COUNT(__d3(__NL(C_R_Sort_Sz_))),COUNT(__d3(__NN(C_R_Sort_Sz_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','Lot',COUNT(__d3(__NL(Lot_))),COUNT(__d3(__NN(Lot_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','LotOrder',COUNT(__d3(__NL(Lot_Order_))),COUNT(__d3(__NN(Lot_Order_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','DPBC',COUNT(__d3(__NL(D_P_B_C_))),COUNT(__d3(__NN(D_P_B_C_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','CHKDigit',COUNT(__d3(__NL(C_H_K_Digit_))),COUNT(__d3(__NN(C_H_K_Digit_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','AceFipsSt',COUNT(__d3(__NL(Ace_Fips_St_))),COUNT(__d3(__NN(Ace_Fips_St_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','AceFipsCounty',COUNT(__d3(__NL(Ace_Fips_County_))),COUNT(__d3(__NN(Ace_Fips_County_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','MSA',COUNT(__d3(__NL(M_S_A_))),COUNT(__d3(__NN(M_S_A_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','prior_area_code',COUNT(__d3(__NL(Prior_Area_Code_))),COUNT(__d3(__NN(Prior_Area_Code_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','current_flag',COUNT(__d3(__NL(Current_Flag_))),COUNT(__d3(__NN(Current_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','business_flag',COUNT(__d3(__NL(Business_Flag_))),COUNT(__d3(__NN(Business_Flag_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','publish_code',COUNT(__d3(__NL(Publish_Code_))),COUNT(__d3(__NN(Publish_Code_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','listing_type',COUNT(__d3(__NL(Listing_Type_))),COUNT(__d3(__NN(Listing_Type_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','current_record_flag',COUNT(__d3(__NL(Is_Active_))),COUNT(__d3(__NN(Is_Active_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','omit_phone',COUNT(__d3(__NL(Omit_Indicator_))),COUNT(__d3(__NN(Omit_Indicator_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','OriginalSource',COUNT(__d3(__NL(Original_Source_))),COUNT(__d3(__NN(Original_Source_)))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','HybridArchiveDate',COUNT(__d3(Hybrid_Archive_Date_=0)),COUNT(__d3(Hybrid_Archive_Date_!=0))},
    {'AddressPhone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Address_Vault','VaultDateLastSeen',COUNT(__d3(Vault_Date_Last_Seen_=0)),COUNT(__d3(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
