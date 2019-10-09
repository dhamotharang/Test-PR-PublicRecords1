//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Address,E_Business_Org,E_Business_Prox,E_Business_Sele,E_Business_Ult,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_Prox_Address(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Business_Prox().Typ) Site_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nstr S_I_C_Code_;
    KEL.typ.nstr N_A_I_C_S_Code_;
    KEL.typ.nstr Best_Primary_Range_;
    KEL.typ.nstr Best_Predirectional_;
    KEL.typ.nstr Best_Primary_Name_;
    KEL.typ.nstr Best_Suffix_;
    KEL.typ.nstr Best_Postdirectional_;
    KEL.typ.nstr Best_Unit_Designation_;
    KEL.typ.nstr Best_Secondary_Range_;
    KEL.typ.nstr Best_Postal_City_;
    KEL.typ.nstr Best_Vanity_City_;
    KEL.typ.nstr Best_State_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Best_Zip5_;
    KEL.typ.nint Best_Zip4_;
    KEL.typ.nstr Best_County_;
    KEL.typ.nint Best_Address_Rank_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_First_Seen_Company_Address_;
    KEL.typ.nkdate Date_Last_Seen_Company_Address_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'Site_(DEFAULT:Site_:0),Location_(DEFAULT:Location_:0),primaryrange(DEFAULT:Primary_Range_:\'\'),predirectional(DEFAULT:Predirectional_:\'\'),primaryname(DEFAULT:Primary_Name_:\'\'),suffix(DEFAULT:Suffix_:\'\'),postdirectional(DEFAULT:Postdirectional_:\'\'),secondaryrange(DEFAULT:Secondary_Range_:\'\'),zip5(DEFAULT:Z_I_P5_:0),siccode(DEFAULT:S_I_C_Code_:\'\'),naicscode(DEFAULT:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestcounty(DEFAULT:Best_County_:\'\'),bestaddressrank(DEFAULT:Best_Address_Rank_:0),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datefirstseencompanyaddress(DEFAULT:Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(DEFAULT:Date_Last_Seen_Company_Address_:DATE),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'Site_(DEFAULT:Site_:0),Location_(DEFAULT:Location_:0),prim_range_derived(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name_derived(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),company_sic_code1(OVERRIDE:S_I_C_Code_:\'\'),company_naics_code1(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestcounty(DEFAULT:Best_County_:\'\'),bestaddressrank(DEFAULT:Best_Address_Rank_:0),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),dt_first_seen_company_address(OVERRIDE:Date_First_Seen_Company_Address_:DATE),dt_last_seen_company_address(OVERRIDE:Date_Last_Seen_Company_Address_:DATE),source(OVERRIDE:Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_kfetch2,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_kfetch2),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((STRING10)prim_range_derived != '' AND (STRING28)prim_name_derived != '' AND (UNSIGNED3)zip != 0  AND (UNSIGNED)proxid<>0);
  SHARED __d0_Site__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d0_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d0_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d0_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Location__Layout := RECORD
    RECORDOF(__d0_Site__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d0_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d0_Site__Mapped,'prim_range_derived,predir,prim_name_derived,addr_suffix,postdir,zip,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range_derived) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name_derived) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d0_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Location__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping1 := 'Site_(DEFAULT:Site_:0),Location_(DEFAULT:Location_:0),prim_range_derived(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name_derived(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),company_sic_code2(OVERRIDE:S_I_C_Code_:\'\'),company_naics_code2(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestcounty(DEFAULT:Best_County_:\'\'),bestaddressrank(DEFAULT:Best_Address_Rank_:0),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),dt_first_seen_company_address(OVERRIDE:Date_First_Seen_Company_Address_:DATE),dt_last_seen_company_address(OVERRIDE:Date_Last_Seen_Company_Address_:DATE),source(OVERRIDE:Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_kfetch2,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_kfetch2),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((STRING10)prim_range_derived != '' AND (STRING28)prim_name_derived != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)proxid<>0 AND((UNSIGNED)company_sic_code2 > 0 OR (UNSIGNED)company_naics_code2 > 0));
  SHARED __d1_Site__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d1_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d1_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d1_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d1_Location__Layout := RECORD
    RECORDOF(__d1_Site__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d1_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d1_Site__Mapped,'prim_range_derived,predir,prim_name_derived,addr_suffix,postdir,zip,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range_derived) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name_derived) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d1_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d1_Prefiltered := __d1_Location__Mapped;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping2 := 'Site_(DEFAULT:Site_:0),Location_(DEFAULT:Location_:0),prim_range_derived(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name_derived(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),company_sic_code3(OVERRIDE:S_I_C_Code_:\'\'),company_naics_code3(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestcounty(DEFAULT:Best_County_:\'\'),bestaddressrank(DEFAULT:Best_Address_Rank_:0),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),dt_first_seen_company_address(OVERRIDE:Date_First_Seen_Company_Address_:DATE),dt_last_seen_company_address(OVERRIDE:Date_Last_Seen_Company_Address_:DATE),source(OVERRIDE:Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_kfetch2,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_kfetch2),SELF:=RIGHT));
  EXPORT __d2_KELfiltered := __d2_Norm((STRING10)prim_range_derived != '' AND (STRING28)prim_name_derived != '' AND (UNSIGNED3)zip != 0  AND (UNSIGNED)proxid<>0 AND((UNSIGNED)company_sic_code3 > 0 OR (UNSIGNED)company_naics_code3 > 0));
  SHARED __d2_Site__Layout := RECORD
    RECORDOF(__d2_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d2_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d2_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d2_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d2_Location__Layout := RECORD
    RECORDOF(__d2_Site__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d2_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d2_Site__Mapped,'prim_range_derived,predir,prim_name_derived,addr_suffix,postdir,zip,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range_derived) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name_derived) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d2_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d2_Prefiltered := __d2_Location__Mapped;
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping3 := 'Site_(DEFAULT:Site_:0),Location_(DEFAULT:Location_:0),prim_range_derived(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name_derived(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),company_sic_code4(OVERRIDE:S_I_C_Code_:\'\'),company_naics_code4(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestcounty(DEFAULT:Best_County_:\'\'),bestaddressrank(DEFAULT:Best_Address_Rank_:0),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),dt_first_seen_company_address(OVERRIDE:Date_First_Seen_Company_Address_:DATE),dt_last_seen_company_address(OVERRIDE:Date_Last_Seen_Company_Address_:DATE),source(OVERRIDE:Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_kfetch2,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_kfetch2),SELF:=RIGHT));
  EXPORT __d3_KELfiltered := __d3_Norm((STRING10)prim_range_derived != '' AND (STRING28)prim_name_derived != '' AND (UNSIGNED3)zip != 0  AND (UNSIGNED)proxid<>0 AND((UNSIGNED)company_sic_code4 > 0 OR (UNSIGNED)company_naics_code4 > 0));
  SHARED __d3_Site__Layout := RECORD
    RECORDOF(__d3_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d3_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d3_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d3_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d3_Location__Layout := RECORD
    RECORDOF(__d3_Site__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d3_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d3_Site__Mapped,'prim_range_derived,predir,prim_name_derived,addr_suffix,postdir,zip,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range_derived) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name_derived) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d3_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d3_Prefiltered := __d3_Location__Mapped;
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping4 := 'Site_(DEFAULT:Site_:0),Location_(DEFAULT:Location_:0),prim_range_derived(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name_derived(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),company_sic_code5(OVERRIDE:S_I_C_Code_:\'\'),company_naics_code5(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestcounty(DEFAULT:Best_County_:\'\'),bestaddressrank(DEFAULT:Best_Address_Rank_:0),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),dt_first_seen_company_address(OVERRIDE:Date_First_Seen_Company_Address_:DATE),dt_last_seen_company_address(OVERRIDE:Date_Last_Seen_Company_Address_:DATE),source(OVERRIDE:Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_kfetch2,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_kfetch2),SELF:=RIGHT));
  EXPORT __d4_KELfiltered := __d4_Norm((STRING10)prim_range_derived != '' AND (STRING28)prim_name_derived != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)proxid<>0 AND((UNSIGNED)company_sic_code5 > 0 OR (UNSIGNED)company_naics_code5 > 0));
  SHARED __d4_Site__Layout := RECORD
    RECORDOF(__d4_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d4_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d4_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d4_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d4_Location__Layout := RECORD
    RECORDOF(__d4_Site__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d4_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d4_Site__Mapped,'prim_range_derived,predir,prim_name_derived,addr_suffix,postdir,zip,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range_derived) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name_derived) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d4_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d4_Prefiltered := __d4_Location__Mapped;
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping5 := 'Site_(DEFAULT:Site_:0),Location_(DEFAULT:Location_:0),corp_addr1_prim_range(OVERRIDE:Primary_Range_:\'\'),corp_addr1_predir(OVERRIDE:Predirectional_:\'\'),corp_addr1_prim_name(OVERRIDE:Primary_Name_:\'\'),corp_addr1_addr_suffix(OVERRIDE:Suffix_:\'\'),corp_addr1_postdir(OVERRIDE:Postdirectional_:\'\'),corp_addr1_sec_range(OVERRIDE:Secondary_Range_:\'\'),corp_addr1_zip5(OVERRIDE:Z_I_P5_:0),corp_sic_code(OVERRIDE:S_I_C_Code_:\'\'),corp_naic_code(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestcounty(DEFAULT:Best_County_:\'\'),bestaddressrank(DEFAULT:Best_Address_Rank_:0),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:DATE),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:DATE),datefirstseencompanyaddress(DEFAULT:Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(DEFAULT:Date_Last_Seen_Company_Address_:DATE),src(OVERRIDE:Source_:\'\'),dt_last_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_first_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d5_Norm := NORMALIZE(__in,LEFT.Dataset_Corp2__Kfetch_LinkIDs_Corp,TRANSFORM(RECORDOF(__in.Dataset_Corp2__Kfetch_LinkIDs_Corp),SELF:=RIGHT));
  EXPORT __d5_KELfiltered := __d5_Norm((STRING10)corp_addr1_prim_range != '' AND (STRING28)corp_addr1_prim_name != '' AND (UNSIGNED3)corp_addr1_zip5 != 0 AND (UNSIGNED)proxid<>0);
  SHARED __d5_Site__Layout := RECORD
    RECORDOF(__d5_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d5_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d5_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d5_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d5_Location__Layout := RECORD
    RECORDOF(__d5_Site__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d5_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d5_Site__Mapped,'corp_addr1_prim_range,corp_addr1_predir,corp_addr1_prim_name,corp_addr1_addr_suffix,corp_addr1_postdir,corp_addr1_zip5,corp_addr1_sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.corp_addr1_prim_range) + '|' + TRIM((STRING)LEFT.corp_addr1_predir) + '|' + TRIM((STRING)LEFT.corp_addr1_prim_name) + '|' + TRIM((STRING)LEFT.corp_addr1_addr_suffix) + '|' + TRIM((STRING)LEFT.corp_addr1_postdir) + '|' + TRIM((STRING)LEFT.corp_addr1_zip5) + '|' + TRIM((STRING)LEFT.corp_addr1_sec_range) = RIGHT.KeyVal,TRANSFORM(__d5_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d5_Prefiltered := __d5_Location__Mapped;
  SHARED __d5 := __SourceFilter(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping6 := 'Site_(DEFAULT:Site_:0),Location_(DEFAULT:Location_:0),corp_addr2_prim_range(OVERRIDE:Primary_Range_:\'\'),corp_addr2_predir(OVERRIDE:Predirectional_:\'\'),corp_addr2_prim_name(OVERRIDE:Primary_Name_:\'\'),corp_addr2_addr_suffix(OVERRIDE:Suffix_:\'\'),corp_addr2_postdir(OVERRIDE:Postdirectional_:\'\'),corp_addr2_sec_range(OVERRIDE:Secondary_Range_:\'\'),corp_addr2_zip5(OVERRIDE:Z_I_P5_:0),corp_sic_code(OVERRIDE:S_I_C_Code_:\'\'),corp_naic_code(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestcounty(DEFAULT:Best_County_:\'\'),bestaddressrank(DEFAULT:Best_Address_Rank_:0),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:DATE),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:DATE),datefirstseencompanyaddress(DEFAULT:Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(DEFAULT:Date_Last_Seen_Company_Address_:DATE),src(OVERRIDE:Source_:\'\'),dt_last_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_first_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d6_Norm := NORMALIZE(__in,LEFT.Dataset_Corp2__Kfetch_LinkIDs_Corp,TRANSFORM(RECORDOF(__in.Dataset_Corp2__Kfetch_LinkIDs_Corp),SELF:=RIGHT));
  EXPORT __d6_KELfiltered := __d6_Norm((STRING10)corp_addr2_prim_range != '' AND (STRING28)corp_addr2_prim_name != '' AND (UNSIGNED3)corp_addr2_zip5 != 0 AND (UNSIGNED)proxid<>0);
  SHARED __d6_Site__Layout := RECORD
    RECORDOF(__d6_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d6_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d6_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d6_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d6_Location__Layout := RECORD
    RECORDOF(__d6_Site__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d6_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d6_Site__Mapped,'corp_addr2_prim_range,corp_addr2_predir,corp_addr2_prim_name,corp_addr2_addr_suffix,corp_addr2_postdir,corp_addr2_zip5,corp_addr2_sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.corp_addr2_prim_range) + '|' + TRIM((STRING)LEFT.corp_addr2_predir) + '|' + TRIM((STRING)LEFT.corp_addr2_prim_name) + '|' + TRIM((STRING)LEFT.corp_addr2_addr_suffix) + '|' + TRIM((STRING)LEFT.corp_addr2_postdir) + '|' + TRIM((STRING)LEFT.corp_addr2_zip5) + '|' + TRIM((STRING)LEFT.corp_addr2_sec_range) = RIGHT.KeyVal,TRANSFORM(__d6_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d6_Prefiltered := __d6_Location__Mapped;
  SHARED __d6 := __SourceFilter(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping7 := 'Site_(DEFAULT:Site_:0),Location_(DEFAULT:Location_:0),corp_ra_prim_range(OVERRIDE:Primary_Range_:\'\'),corp_ra_predir(OVERRIDE:Predirectional_:\'\'),corp_ra_prim_name(OVERRIDE:Primary_Name_:\'\'),corp_ra_addr_suffix(OVERRIDE:Suffix_:\'\'),corp_ra_postdir(OVERRIDE:Postdirectional_:\'\'),corp_ra_sec_range(OVERRIDE:Secondary_Range_:\'\'),corp_ra_zip5(OVERRIDE:Z_I_P5_:0),corp_sic_code(OVERRIDE:S_I_C_Code_:\'\'),corp_naic_code(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestcounty(DEFAULT:Best_County_:\'\'),bestaddressrank(DEFAULT:Best_Address_Rank_:0),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:DATE),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:DATE),datefirstseencompanyaddress(DEFAULT:Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(DEFAULT:Date_Last_Seen_Company_Address_:DATE),src(OVERRIDE:Source_:\'\'),dt_last_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_first_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d7_Norm := NORMALIZE(__in,LEFT.Dataset_Corp2__Kfetch_LinkIDs_Corp,TRANSFORM(RECORDOF(__in.Dataset_Corp2__Kfetch_LinkIDs_Corp),SELF:=RIGHT));
  EXPORT __d7_KELfiltered := __d7_Norm((STRING10)corp_ra_prim_range != '' AND (STRING28)corp_ra_prim_name != '' AND (UNSIGNED3)corp_ra_zip5 != 0  AND (UNSIGNED)proxid<>0);
  SHARED __d7_Site__Layout := RECORD
    RECORDOF(__d7_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d7_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d7_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d7_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d7_Location__Layout := RECORD
    RECORDOF(__d7_Site__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d7_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d7_Site__Mapped,'corp_ra_prim_range,corp_ra_predir,corp_ra_prim_name,corp_ra_addr_suffix,corp_ra_postdir,corp_ra_zip5,corp_ra_sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.corp_ra_prim_range) + '|' + TRIM((STRING)LEFT.corp_ra_predir) + '|' + TRIM((STRING)LEFT.corp_ra_prim_name) + '|' + TRIM((STRING)LEFT.corp_ra_addr_suffix) + '|' + TRIM((STRING)LEFT.corp_ra_postdir) + '|' + TRIM((STRING)LEFT.corp_ra_zip5) + '|' + TRIM((STRING)LEFT.corp_ra_sec_range) = RIGHT.KeyVal,TRANSFORM(__d7_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d7_Prefiltered := __d7_Location__Mapped;
  SHARED __d7 := __SourceFilter(KEL.FromFlat.Convert(__d7_Prefiltered,InLayout,__Mapping7,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping8 := 'Site_(DEFAULT:Site_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),siccode(DEFAULT:S_I_C_Code_:\'\'),naicscode(DEFAULT:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestcounty(DEFAULT:Best_County_:\'\'),bestaddressrank(DEFAULT:Best_Address_Rank_:0),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datefirstseencompanyaddress(DEFAULT:Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(DEFAULT:Date_Last_Seen_Company_Address_:DATE),src(OVERRIDE:Source_:\'\'),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d8_Norm := NORMALIZE(__in,LEFT.Dataset_UtilFile__Kfetch2_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_UtilFile__Kfetch2_LinkIds),SELF:=RIGHT));
  EXPORT __d8_KELfiltered := __d8_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED)zip != 0  AND (UNSIGNED)proxid<>0);
  SHARED __d8_Site__Layout := RECORD
    RECORDOF(__d8_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d8_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d8_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d8_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d8_Location__Layout := RECORD
    RECORDOF(__d8_Site__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d8_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d8_Site__Mapped,'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d8_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d8_Prefiltered := __d8_Location__Mapped;
  SHARED __d8 := __SourceFilter(KEL.FromFlat.Convert(__d8_Prefiltered,InLayout,__Mapping8,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping9 := 'Site_(DEFAULT:Site_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),sic_code(OVERRIDE:S_I_C_Code_:\'\'),naics_code(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestcounty(DEFAULT:Best_County_:\'\'),bestaddressrank(DEFAULT:Best_Address_Rank_:0),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datefirstseencompanyaddress(DEFAULT:Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(DEFAULT:Date_Last_Seen_Company_Address_:DATE),source(OVERRIDE:Source_:\'\'),pub_date(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d9_Norm := NORMALIZE(__in,LEFT.Dataset_YellowPages__kfetch_yellowpages_linkids,TRANSFORM(RECORDOF(__in.Dataset_YellowPages__kfetch_yellowpages_linkids),SELF:=RIGHT));
  EXPORT __d9_KELfiltered := __d9_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0  AND (UNSIGNED)proxid<>0);
  SHARED __d9_Site__Layout := RECORD
    RECORDOF(__d9_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d9_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d9_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d9_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d9_Location__Layout := RECORD
    RECORDOF(__d9_Site__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d9_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d9_Site__Mapped,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d9_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d9_Prefiltered := __d9_Location__Mapped;
  SHARED __d9 := __SourceFilter(KEL.FromFlat.Convert(__d9_Prefiltered,InLayout,__Mapping9,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping10 := 'Site_(DEFAULT:Site_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),efx_primsic(OVERRIDE:S_I_C_Code_:\'\'),efx_primnaicscode(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestcounty(DEFAULT:Best_County_:\'\'),bestaddressrank(DEFAULT:Best_Address_Rank_:0),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:DATE),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:DATE),datefirstseencompanyaddress(DEFAULT:Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(DEFAULT:Date_Last_Seen_Company_Address_:DATE),source(OVERRIDE:Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d10_Norm := NORMALIZE(__in,LEFT.Dataset_Equifax_Business__Data_kfetch_LinkIDs,TRANSFORM(RECORDOF(__in.Dataset_Equifax_Business__Data_kfetch_LinkIDs),SELF:=RIGHT));
  EXPORT __d10_KELfiltered := __d10_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0  AND (UNSIGNED)proxid<>0);
  SHARED __d10_Site__Layout := RECORD
    RECORDOF(__d10_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d10_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d10_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d10_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d10_Location__Layout := RECORD
    RECORDOF(__d10_Site__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d10_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d10_Site__Mapped,'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d10_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d10_Prefiltered := __d10_Location__Mapped;
  SHARED __d10 := __SourceFilter(KEL.FromFlat.Convert(__d10_Prefiltered,InLayout,__Mapping10,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping11 := 'Site_(DEFAULT:Site_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),efx_secsic1(OVERRIDE:S_I_C_Code_:\'\'),efx_secnaics1(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestcounty(DEFAULT:Best_County_:\'\'),bestaddressrank(DEFAULT:Best_Address_Rank_:0),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:DATE),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:DATE),datefirstseencompanyaddress(DEFAULT:Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(DEFAULT:Date_Last_Seen_Company_Address_:DATE),source(OVERRIDE:Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d11_Norm := NORMALIZE(__in,LEFT.Dataset_Equifax_Business__Data_kfetch_LinkIDs,TRANSFORM(RECORDOF(__in.Dataset_Equifax_Business__Data_kfetch_LinkIDs),SELF:=RIGHT));
  EXPORT __d11_KELfiltered := __d11_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)proxid<>0 AND ((UNSIGNED)efx_secsic1 > 0 OR (UNSIGNED)efx_secnaics1 > 0));
  SHARED __d11_Site__Layout := RECORD
    RECORDOF(__d11_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d11_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d11_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d11_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d11_Location__Layout := RECORD
    RECORDOF(__d11_Site__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d11_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d11_Site__Mapped,'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d11_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d11_Prefiltered := __d11_Location__Mapped;
  SHARED __d11 := __SourceFilter(KEL.FromFlat.Convert(__d11_Prefiltered,InLayout,__Mapping11,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping12 := 'Site_(DEFAULT:Site_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),efx_secsic2(OVERRIDE:S_I_C_Code_:\'\'),efx_secnaics2(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestcounty(DEFAULT:Best_County_:\'\'),bestaddressrank(DEFAULT:Best_Address_Rank_:0),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:DATE),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:DATE),datefirstseencompanyaddress(DEFAULT:Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(DEFAULT:Date_Last_Seen_Company_Address_:DATE),source(OVERRIDE:Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d12_Norm := NORMALIZE(__in,LEFT.Dataset_Equifax_Business__Data_kfetch_LinkIDs,TRANSFORM(RECORDOF(__in.Dataset_Equifax_Business__Data_kfetch_LinkIDs),SELF:=RIGHT));
  EXPORT __d12_KELfiltered := __d12_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)proxid<>0 AND ((UNSIGNED)efx_secsic2 > 0 OR (UNSIGNED)efx_secnaics2 > 0));
  SHARED __d12_Site__Layout := RECORD
    RECORDOF(__d12_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d12_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d12_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d12_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d12_Location__Layout := RECORD
    RECORDOF(__d12_Site__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d12_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d12_Site__Mapped,'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d12_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d12_Prefiltered := __d12_Location__Mapped;
  SHARED __d12 := __SourceFilter(KEL.FromFlat.Convert(__d12_Prefiltered,InLayout,__Mapping12,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping13 := 'Site_(DEFAULT:Site_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),efx_secsic3(OVERRIDE:S_I_C_Code_:\'\'),efx_secnaics3(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestcounty(DEFAULT:Best_County_:\'\'),bestaddressrank(DEFAULT:Best_Address_Rank_:0),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:DATE),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:DATE),datefirstseencompanyaddress(DEFAULT:Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(DEFAULT:Date_Last_Seen_Company_Address_:DATE),source(OVERRIDE:Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d13_Norm := NORMALIZE(__in,LEFT.Dataset_Equifax_Business__Data_kfetch_LinkIDs,TRANSFORM(RECORDOF(__in.Dataset_Equifax_Business__Data_kfetch_LinkIDs),SELF:=RIGHT));
  EXPORT __d13_KELfiltered := __d13_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)proxid<>0 AND ((UNSIGNED)efx_secsic3 > 0 OR (UNSIGNED)efx_secnaics3 > 0));
  SHARED __d13_Site__Layout := RECORD
    RECORDOF(__d13_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d13_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d13_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d13_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d13_Location__Layout := RECORD
    RECORDOF(__d13_Site__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d13_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d13_Site__Mapped,'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d13_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d13_Prefiltered := __d13_Location__Mapped;
  SHARED __d13 := __SourceFilter(KEL.FromFlat.Convert(__d13_Prefiltered,InLayout,__Mapping13,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping14 := 'Site_(DEFAULT:Site_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0),efx_secsic4(OVERRIDE:S_I_C_Code_:\'\'),efx_secnaics4(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestcounty(DEFAULT:Best_County_:\'\'),bestaddressrank(DEFAULT:Best_Address_Rank_:0),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:DATE),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:DATE),datefirstseencompanyaddress(DEFAULT:Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(DEFAULT:Date_Last_Seen_Company_Address_:DATE),source(OVERRIDE:Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d14_Norm := NORMALIZE(__in,LEFT.Dataset_Equifax_Business__Data_kfetch_LinkIDs,TRANSFORM(RECORDOF(__in.Dataset_Equifax_Business__Data_kfetch_LinkIDs),SELF:=RIGHT));
  EXPORT __d14_KELfiltered := __d14_Norm((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)proxid<>0 AND ((UNSIGNED)efx_secsic4 > 0 OR (UNSIGNED)efx_secnaics4 > 0));
  SHARED __d14_Site__Layout := RECORD
    RECORDOF(__d14_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d14_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d14_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d14_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d14_Location__Layout := RECORD
    RECORDOF(__d14_Site__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d14_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d14_Site__Mapped,'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d14_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d14_Prefiltered := __d14_Location__Mapped;
  SHARED __d14 := __SourceFilter(KEL.FromFlat.Convert(__d14_Prefiltered,InLayout,__Mapping14,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping15 := 'Site_(DEFAULT:Site_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'|OVERRIDE:Best_Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'|OVERRIDE:Best_Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'|OVERRIDE:Best_Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'|OVERRIDE:Best_Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'|OVERRIDE:Best_Postdirectional_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'|OVERRIDE:Best_Secondary_Range_:\'\'),zip(OVERRIDE:Z_I_P5_:0|OVERRIDE:Best_Zip5_:0),siccode(DEFAULT:S_I_C_Code_:\'\'),naicscode(DEFAULT:N_A_I_C_S_Code_:\'\'),unit_desig(OVERRIDE:Best_Unit_Designation_:\'\'),p_city_name(OVERRIDE:Best_Postal_City_:\'\'),v_city_name(OVERRIDE:Best_Vanity_City_:\'\'),st(OVERRIDE:Best_State_:\'\'),zip4(OVERRIDE:Best_Zip4_:0),bestcounty(DEFAULT:Best_County_:\'\'),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datefirstseencompanyaddress(DEFAULT:Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(DEFAULT:Date_Last_Seen_Company_Address_:DATE),src(OVERRIDE:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED InLayout __Mapping15_Transform(InLayout __r) := TRANSFORM
    SELF.Best_Address_Rank_ := __CN(1);
    SELF := __r;
  END;
  SHARED __d15_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2_Best__Key_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_BIPV2_Best__Key_LinkIds),SELF:=RIGHT));
  EXPORT __d15_KELfiltered := __d15_Norm(proxid != 0 AND seleid != 0 AND (STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0);
  SHARED __d15_Site__Layout := RECORD
    RECORDOF(__d15_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d15_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d15_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d15_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d15_Location__Layout := RECORD
    RECORDOF(__d15_Site__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d15_Location__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d15_Site__Mapped,'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range','__in'),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d15_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d15_Prefiltered := __d15_Location__Mapped;
  SHARED __d15 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d15_Prefiltered,InLayout,__Mapping15,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping15_Transform(LEFT)));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6 + __d7 + __d8 + __d9 + __d10 + __d11 + __d12 + __d13 + __d14 + __d15;
  EXPORT S_I_C_Codes_Layout := RECORD
    KEL.typ.nstr S_I_C_Code_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT N_A_I_C_S_Codes_Layout := RECORD
    KEL.typ.nstr N_A_I_C_S_Code_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Best_Addresses_Layout := RECORD
    KEL.typ.nstr Best_Primary_Range_;
    KEL.typ.nstr Best_Predirectional_;
    KEL.typ.nstr Best_Primary_Name_;
    KEL.typ.nstr Best_Suffix_;
    KEL.typ.nstr Best_Postdirectional_;
    KEL.typ.nstr Best_Unit_Designation_;
    KEL.typ.nstr Best_Secondary_Range_;
    KEL.typ.nstr Best_Postal_City_;
    KEL.typ.nstr Best_Vanity_City_;
    KEL.typ.nstr Best_State_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Best_Zip5_;
    KEL.typ.nint Best_Zip4_;
    KEL.typ.nstr Best_County_;
    KEL.typ.nint Best_Address_Rank_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Business_Prox().Typ) Site_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ndataset(S_I_C_Codes_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(N_A_I_C_S_Codes_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(Best_Addresses_Layout) Best_Addresses_;
    KEL.typ.nkdate Date_First_Seen_Company_Address_;
    KEL.typ.nkdate Date_Last_Seen_Company_Address_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Site_,Location_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Secondary_Range_,Z_I_P5_,Date_First_Seen_Company_Address_,Date_Last_Seen_Company_Address_,ALL));
  Prox_Address_Group := __PostFilter;
  Layout Prox_Address__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.S_I_C_Codes_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),S_I_C_Code_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Source_},S_I_C_Code_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Source_),S_I_C_Codes_Layout)(__NN(S_I_C_Code_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_) OR __NN(Source_)));
    SELF.N_A_I_C_S_Codes_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),N_A_I_C_S_Code_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Source_},N_A_I_C_S_Code_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Source_),N_A_I_C_S_Codes_Layout)(__NN(N_A_I_C_S_Code_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_) OR __NN(Source_)));
    SELF.Best_Addresses_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Best_Primary_Range_,Best_Predirectional_,Best_Primary_Name_,Best_Suffix_,Best_Postdirectional_,Best_Unit_Designation_,Best_Secondary_Range_,Best_Postal_City_,Best_Vanity_City_,Best_State_,Best_Zip5_,Best_Zip4_,Best_County_,Best_Address_Rank_},Best_Primary_Range_,Best_Predirectional_,Best_Primary_Name_,Best_Suffix_,Best_Postdirectional_,Best_Unit_Designation_,Best_Secondary_Range_,Best_Postal_City_,Best_Vanity_City_,Best_State_,Best_Zip5_,Best_Zip4_,Best_County_,Best_Address_Rank_),Best_Addresses_Layout)(__NN(Best_Primary_Range_) OR __NN(Best_Predirectional_) OR __NN(Best_Primary_Name_) OR __NN(Best_Suffix_) OR __NN(Best_Postdirectional_) OR __NN(Best_Unit_Designation_) OR __NN(Best_Secondary_Range_) OR __NN(Best_Postal_City_) OR __NN(Best_Vanity_City_) OR __NN(Best_State_) OR __NN(Best_Zip5_) OR __NN(Best_Zip4_) OR __NN(Best_County_) OR __NN(Best_Address_Rank_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_},Source_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_),Data_Sources_Layout)(__NN(Source_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Prox_Address__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.S_I_C_Codes_ := __CN(PROJECT(DATASET(__r),TRANSFORM(S_I_C_Codes_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(S_I_C_Code_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_) OR __NN(Source_)));
    SELF.N_A_I_C_S_Codes_ := __CN(PROJECT(DATASET(__r),TRANSFORM(N_A_I_C_S_Codes_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(N_A_I_C_S_Code_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_) OR __NN(Source_)));
    SELF.Best_Addresses_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Best_Addresses_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Best_Primary_Range_) OR __NN(Best_Predirectional_) OR __NN(Best_Primary_Name_) OR __NN(Best_Suffix_) OR __NN(Best_Postdirectional_) OR __NN(Best_Unit_Designation_) OR __NN(Best_Secondary_Range_) OR __NN(Best_Postal_City_) OR __NN(Best_Vanity_City_) OR __NN(Best_State_) OR __NN(Best_Zip5_) OR __NN(Best_Zip4_) OR __NN(Best_County_) OR __NN(Best_Address_Rank_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Source_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Prox_Address_Group,COUNT(ROWS(LEFT))=1),GROUP,Prox_Address__Single_Rollup(LEFT)) + ROLLUP(HAVING(Prox_Address_Group,COUNT(ROWS(LEFT))>1),GROUP,Prox_Address__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Site__Orphan := JOIN(InData(__NN(Site_)),E_Business_Prox(__in,__cfg).__Result,__EEQP(LEFT.Site_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Location__Orphan := JOIN(InData(__NN(Location_)),E_Address(__in,__cfg).__Result,__EEQP(LEFT.Location_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Z_I_P5__Orphan := JOIN(InData(__NN(Z_I_P5_)),E_Zip_Code(__in,__cfg).__Result,__EEQP(LEFT.Z_I_P5_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Best_Zip5__Orphan := JOIN(InData(__NN(Best_Zip5_)),E_Zip_Code(__in,__cfg).__Result,__EEQP(LEFT.Best_Zip5_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Site__Orphan),COUNT(Location__Orphan),COUNT(Z_I_P5__Orphan),COUNT(Best_Zip5__Orphan)}],{KEL.typ.int Site__Orphan,KEL.typ.int Location__Orphan,KEL.typ.int Z_I_P5__Orphan,KEL.typ.int Best_Zip5__Orphan});
  EXPORT NullCounts := DATASET([
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d0(__NL(Site_))),COUNT(__d0(__NN(Site_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d0(__NL(Location_))),COUNT(__d0(__NN(Location_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range_derived',COUNT(__d0(__NL(Primary_Range_))),COUNT(__d0(__NN(Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d0(__NL(Predirectional_))),COUNT(__d0(__NN(Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name_derived',COUNT(__d0(__NL(Primary_Name_))),COUNT(__d0(__NN(Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d0(__NL(Suffix_))),COUNT(__d0(__NN(Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d0(__NL(Postdirectional_))),COUNT(__d0(__NN(Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d0(__NL(Secondary_Range_))),COUNT(__d0(__NN(Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d0(__NL(Z_I_P5_))),COUNT(__d0(__NN(Z_I_P5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code1',COUNT(__d0(__NL(S_I_C_Code_))),COUNT(__d0(__NN(S_I_C_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code1',COUNT(__d0(__NL(N_A_I_C_S_Code_))),COUNT(__d0(__NN(N_A_I_C_S_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d0(__NL(Best_Primary_Range_))),COUNT(__d0(__NN(Best_Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d0(__NL(Best_Predirectional_))),COUNT(__d0(__NN(Best_Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d0(__NL(Best_Primary_Name_))),COUNT(__d0(__NN(Best_Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d0(__NL(Best_Suffix_))),COUNT(__d0(__NN(Best_Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d0(__NL(Best_Postdirectional_))),COUNT(__d0(__NN(Best_Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d0(__NL(Best_Unit_Designation_))),COUNT(__d0(__NN(Best_Unit_Designation_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d0(__NL(Best_Secondary_Range_))),COUNT(__d0(__NN(Best_Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d0(__NL(Best_Postal_City_))),COUNT(__d0(__NN(Best_Postal_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d0(__NL(Best_Vanity_City_))),COUNT(__d0(__NN(Best_Vanity_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d0(__NL(Best_State_))),COUNT(__d0(__NN(Best_State_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d0(__NL(Best_Zip5_))),COUNT(__d0(__NN(Best_Zip5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d0(__NL(Best_Zip4_))),COUNT(__d0(__NN(Best_Zip4_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCounty',COUNT(__d0(__NL(Best_County_))),COUNT(__d0(__NN(Best_County_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d0(__NL(Best_Address_Rank_))),COUNT(__d0(__NN(Best_Address_Rank_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d0(__NL(Date_Vendor_Last_Reported_))),COUNT(__d0(__NN(Date_Vendor_Last_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d0(__NL(Date_Vendor_First_Reported_))),COUNT(__d0(__NN(Date_Vendor_First_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_first_seen_company_address',COUNT(__d0(__NL(Date_First_Seen_Company_Address_))),COUNT(__d0(__NN(Date_First_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_last_seen_company_address',COUNT(__d0(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d0(__NN(Date_Last_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d1(__NL(Site_))),COUNT(__d1(__NN(Site_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d1(__NL(Location_))),COUNT(__d1(__NN(Location_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range_derived',COUNT(__d1(__NL(Primary_Range_))),COUNT(__d1(__NN(Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d1(__NL(Predirectional_))),COUNT(__d1(__NN(Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name_derived',COUNT(__d1(__NL(Primary_Name_))),COUNT(__d1(__NN(Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d1(__NL(Suffix_))),COUNT(__d1(__NN(Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d1(__NL(Postdirectional_))),COUNT(__d1(__NN(Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d1(__NL(Secondary_Range_))),COUNT(__d1(__NN(Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d1(__NL(Z_I_P5_))),COUNT(__d1(__NN(Z_I_P5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code2',COUNT(__d1(__NL(S_I_C_Code_))),COUNT(__d1(__NN(S_I_C_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code2',COUNT(__d1(__NL(N_A_I_C_S_Code_))),COUNT(__d1(__NN(N_A_I_C_S_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d1(__NL(Best_Primary_Range_))),COUNT(__d1(__NN(Best_Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d1(__NL(Best_Predirectional_))),COUNT(__d1(__NN(Best_Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d1(__NL(Best_Primary_Name_))),COUNT(__d1(__NN(Best_Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d1(__NL(Best_Suffix_))),COUNT(__d1(__NN(Best_Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d1(__NL(Best_Postdirectional_))),COUNT(__d1(__NN(Best_Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d1(__NL(Best_Unit_Designation_))),COUNT(__d1(__NN(Best_Unit_Designation_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d1(__NL(Best_Secondary_Range_))),COUNT(__d1(__NN(Best_Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d1(__NL(Best_Postal_City_))),COUNT(__d1(__NN(Best_Postal_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d1(__NL(Best_Vanity_City_))),COUNT(__d1(__NN(Best_Vanity_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d1(__NL(Best_State_))),COUNT(__d1(__NN(Best_State_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d1(__NL(Best_Zip5_))),COUNT(__d1(__NN(Best_Zip5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d1(__NL(Best_Zip4_))),COUNT(__d1(__NN(Best_Zip4_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCounty',COUNT(__d1(__NL(Best_County_))),COUNT(__d1(__NN(Best_County_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d1(__NL(Best_Address_Rank_))),COUNT(__d1(__NN(Best_Address_Rank_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d1(__NL(Date_Vendor_Last_Reported_))),COUNT(__d1(__NN(Date_Vendor_Last_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d1(__NL(Date_Vendor_First_Reported_))),COUNT(__d1(__NN(Date_Vendor_First_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_first_seen_company_address',COUNT(__d1(__NL(Date_First_Seen_Company_Address_))),COUNT(__d1(__NN(Date_First_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_last_seen_company_address',COUNT(__d1(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d1(__NN(Date_Last_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d2(__NL(Site_))),COUNT(__d2(__NN(Site_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d2(__NL(Location_))),COUNT(__d2(__NN(Location_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range_derived',COUNT(__d2(__NL(Primary_Range_))),COUNT(__d2(__NN(Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d2(__NL(Predirectional_))),COUNT(__d2(__NN(Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name_derived',COUNT(__d2(__NL(Primary_Name_))),COUNT(__d2(__NN(Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d2(__NL(Suffix_))),COUNT(__d2(__NN(Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d2(__NL(Postdirectional_))),COUNT(__d2(__NN(Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d2(__NL(Secondary_Range_))),COUNT(__d2(__NN(Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d2(__NL(Z_I_P5_))),COUNT(__d2(__NN(Z_I_P5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code3',COUNT(__d2(__NL(S_I_C_Code_))),COUNT(__d2(__NN(S_I_C_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code3',COUNT(__d2(__NL(N_A_I_C_S_Code_))),COUNT(__d2(__NN(N_A_I_C_S_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d2(__NL(Best_Primary_Range_))),COUNT(__d2(__NN(Best_Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d2(__NL(Best_Predirectional_))),COUNT(__d2(__NN(Best_Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d2(__NL(Best_Primary_Name_))),COUNT(__d2(__NN(Best_Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d2(__NL(Best_Suffix_))),COUNT(__d2(__NN(Best_Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d2(__NL(Best_Postdirectional_))),COUNT(__d2(__NN(Best_Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d2(__NL(Best_Unit_Designation_))),COUNT(__d2(__NN(Best_Unit_Designation_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d2(__NL(Best_Secondary_Range_))),COUNT(__d2(__NN(Best_Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d2(__NL(Best_Postal_City_))),COUNT(__d2(__NN(Best_Postal_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d2(__NL(Best_Vanity_City_))),COUNT(__d2(__NN(Best_Vanity_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d2(__NL(Best_State_))),COUNT(__d2(__NN(Best_State_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d2(__NL(Best_Zip5_))),COUNT(__d2(__NN(Best_Zip5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d2(__NL(Best_Zip4_))),COUNT(__d2(__NN(Best_Zip4_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCounty',COUNT(__d2(__NL(Best_County_))),COUNT(__d2(__NN(Best_County_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d2(__NL(Best_Address_Rank_))),COUNT(__d2(__NN(Best_Address_Rank_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d2(__NL(Date_Vendor_Last_Reported_))),COUNT(__d2(__NN(Date_Vendor_Last_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d2(__NL(Date_Vendor_First_Reported_))),COUNT(__d2(__NN(Date_Vendor_First_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_first_seen_company_address',COUNT(__d2(__NL(Date_First_Seen_Company_Address_))),COUNT(__d2(__NN(Date_First_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_last_seen_company_address',COUNT(__d2(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d2(__NN(Date_Last_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d3(__NL(Site_))),COUNT(__d3(__NN(Site_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d3(__NL(Location_))),COUNT(__d3(__NN(Location_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range_derived',COUNT(__d3(__NL(Primary_Range_))),COUNT(__d3(__NN(Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d3(__NL(Predirectional_))),COUNT(__d3(__NN(Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name_derived',COUNT(__d3(__NL(Primary_Name_))),COUNT(__d3(__NN(Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d3(__NL(Suffix_))),COUNT(__d3(__NN(Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d3(__NL(Postdirectional_))),COUNT(__d3(__NN(Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d3(__NL(Secondary_Range_))),COUNT(__d3(__NN(Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d3(__NL(Z_I_P5_))),COUNT(__d3(__NN(Z_I_P5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code4',COUNT(__d3(__NL(S_I_C_Code_))),COUNT(__d3(__NN(S_I_C_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code4',COUNT(__d3(__NL(N_A_I_C_S_Code_))),COUNT(__d3(__NN(N_A_I_C_S_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d3(__NL(Best_Primary_Range_))),COUNT(__d3(__NN(Best_Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d3(__NL(Best_Predirectional_))),COUNT(__d3(__NN(Best_Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d3(__NL(Best_Primary_Name_))),COUNT(__d3(__NN(Best_Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d3(__NL(Best_Suffix_))),COUNT(__d3(__NN(Best_Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d3(__NL(Best_Postdirectional_))),COUNT(__d3(__NN(Best_Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d3(__NL(Best_Unit_Designation_))),COUNT(__d3(__NN(Best_Unit_Designation_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d3(__NL(Best_Secondary_Range_))),COUNT(__d3(__NN(Best_Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d3(__NL(Best_Postal_City_))),COUNT(__d3(__NN(Best_Postal_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d3(__NL(Best_Vanity_City_))),COUNT(__d3(__NN(Best_Vanity_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d3(__NL(Best_State_))),COUNT(__d3(__NN(Best_State_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d3(__NL(Best_Zip5_))),COUNT(__d3(__NN(Best_Zip5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d3(__NL(Best_Zip4_))),COUNT(__d3(__NN(Best_Zip4_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCounty',COUNT(__d3(__NL(Best_County_))),COUNT(__d3(__NN(Best_County_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d3(__NL(Best_Address_Rank_))),COUNT(__d3(__NN(Best_Address_Rank_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d3(__NL(Date_Vendor_Last_Reported_))),COUNT(__d3(__NN(Date_Vendor_Last_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d3(__NL(Date_Vendor_First_Reported_))),COUNT(__d3(__NN(Date_Vendor_First_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_first_seen_company_address',COUNT(__d3(__NL(Date_First_Seen_Company_Address_))),COUNT(__d3(__NN(Date_First_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_last_seen_company_address',COUNT(__d3(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d3(__NN(Date_Last_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d4(__NL(Site_))),COUNT(__d4(__NN(Site_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d4(__NL(Location_))),COUNT(__d4(__NN(Location_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range_derived',COUNT(__d4(__NL(Primary_Range_))),COUNT(__d4(__NN(Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d4(__NL(Predirectional_))),COUNT(__d4(__NN(Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name_derived',COUNT(__d4(__NL(Primary_Name_))),COUNT(__d4(__NN(Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d4(__NL(Suffix_))),COUNT(__d4(__NN(Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d4(__NL(Postdirectional_))),COUNT(__d4(__NN(Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d4(__NL(Secondary_Range_))),COUNT(__d4(__NN(Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d4(__NL(Z_I_P5_))),COUNT(__d4(__NN(Z_I_P5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code5',COUNT(__d4(__NL(S_I_C_Code_))),COUNT(__d4(__NN(S_I_C_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code5',COUNT(__d4(__NL(N_A_I_C_S_Code_))),COUNT(__d4(__NN(N_A_I_C_S_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d4(__NL(Best_Primary_Range_))),COUNT(__d4(__NN(Best_Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d4(__NL(Best_Predirectional_))),COUNT(__d4(__NN(Best_Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d4(__NL(Best_Primary_Name_))),COUNT(__d4(__NN(Best_Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d4(__NL(Best_Suffix_))),COUNT(__d4(__NN(Best_Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d4(__NL(Best_Postdirectional_))),COUNT(__d4(__NN(Best_Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d4(__NL(Best_Unit_Designation_))),COUNT(__d4(__NN(Best_Unit_Designation_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d4(__NL(Best_Secondary_Range_))),COUNT(__d4(__NN(Best_Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d4(__NL(Best_Postal_City_))),COUNT(__d4(__NN(Best_Postal_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d4(__NL(Best_Vanity_City_))),COUNT(__d4(__NN(Best_Vanity_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d4(__NL(Best_State_))),COUNT(__d4(__NN(Best_State_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d4(__NL(Best_Zip5_))),COUNT(__d4(__NN(Best_Zip5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d4(__NL(Best_Zip4_))),COUNT(__d4(__NN(Best_Zip4_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCounty',COUNT(__d4(__NL(Best_County_))),COUNT(__d4(__NN(Best_County_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d4(__NL(Best_Address_Rank_))),COUNT(__d4(__NN(Best_Address_Rank_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d4(__NL(Date_Vendor_Last_Reported_))),COUNT(__d4(__NN(Date_Vendor_Last_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d4(__NL(Date_Vendor_First_Reported_))),COUNT(__d4(__NN(Date_Vendor_First_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_first_seen_company_address',COUNT(__d4(__NL(Date_First_Seen_Company_Address_))),COUNT(__d4(__NN(Date_First_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_last_seen_company_address',COUNT(__d4(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d4(__NN(Date_Last_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d5(__NL(Site_))),COUNT(__d5(__NN(Site_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d5(__NL(Location_))),COUNT(__d5(__NN(Location_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_prim_range',COUNT(__d5(__NL(Primary_Range_))),COUNT(__d5(__NN(Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_predir',COUNT(__d5(__NL(Predirectional_))),COUNT(__d5(__NN(Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_prim_name',COUNT(__d5(__NL(Primary_Name_))),COUNT(__d5(__NN(Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_addr_suffix',COUNT(__d5(__NL(Suffix_))),COUNT(__d5(__NN(Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_postdir',COUNT(__d5(__NL(Postdirectional_))),COUNT(__d5(__NN(Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_sec_range',COUNT(__d5(__NL(Secondary_Range_))),COUNT(__d5(__NN(Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_zip5',COUNT(__d5(__NL(Z_I_P5_))),COUNT(__d5(__NN(Z_I_P5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_sic_code',COUNT(__d5(__NL(S_I_C_Code_))),COUNT(__d5(__NN(S_I_C_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_naic_code',COUNT(__d5(__NL(N_A_I_C_S_Code_))),COUNT(__d5(__NN(N_A_I_C_S_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d5(__NL(Best_Primary_Range_))),COUNT(__d5(__NN(Best_Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d5(__NL(Best_Predirectional_))),COUNT(__d5(__NN(Best_Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d5(__NL(Best_Primary_Name_))),COUNT(__d5(__NN(Best_Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d5(__NL(Best_Suffix_))),COUNT(__d5(__NN(Best_Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d5(__NL(Best_Postdirectional_))),COUNT(__d5(__NN(Best_Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d5(__NL(Best_Unit_Designation_))),COUNT(__d5(__NN(Best_Unit_Designation_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d5(__NL(Best_Secondary_Range_))),COUNT(__d5(__NN(Best_Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d5(__NL(Best_Postal_City_))),COUNT(__d5(__NN(Best_Postal_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d5(__NL(Best_Vanity_City_))),COUNT(__d5(__NN(Best_Vanity_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d5(__NL(Best_State_))),COUNT(__d5(__NN(Best_State_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d5(__NL(Best_Zip5_))),COUNT(__d5(__NN(Best_Zip5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d5(__NL(Best_Zip4_))),COUNT(__d5(__NN(Best_Zip4_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCounty',COUNT(__d5(__NL(Best_County_))),COUNT(__d5(__NN(Best_County_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d5(__NL(Best_Address_Rank_))),COUNT(__d5(__NN(Best_Address_Rank_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_last_reported',COUNT(__d5(__NL(Date_Vendor_Last_Reported_))),COUNT(__d5(__NN(Date_Vendor_Last_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_first_reported',COUNT(__d5(__NL(Date_Vendor_First_Reported_))),COUNT(__d5(__NN(Date_Vendor_First_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeenCompanyAddress',COUNT(__d5(__NL(Date_First_Seen_Company_Address_))),COUNT(__d5(__NN(Date_First_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenCompanyAddress',COUNT(__d5(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d5(__NN(Date_Last_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d6(__NL(Site_))),COUNT(__d6(__NN(Site_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d6(__NL(Location_))),COUNT(__d6(__NN(Location_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_prim_range',COUNT(__d6(__NL(Primary_Range_))),COUNT(__d6(__NN(Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_predir',COUNT(__d6(__NL(Predirectional_))),COUNT(__d6(__NN(Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_prim_name',COUNT(__d6(__NL(Primary_Name_))),COUNT(__d6(__NN(Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_addr_suffix',COUNT(__d6(__NL(Suffix_))),COUNT(__d6(__NN(Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_postdir',COUNT(__d6(__NL(Postdirectional_))),COUNT(__d6(__NN(Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_sec_range',COUNT(__d6(__NL(Secondary_Range_))),COUNT(__d6(__NN(Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_zip5',COUNT(__d6(__NL(Z_I_P5_))),COUNT(__d6(__NN(Z_I_P5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_sic_code',COUNT(__d6(__NL(S_I_C_Code_))),COUNT(__d6(__NN(S_I_C_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_naic_code',COUNT(__d6(__NL(N_A_I_C_S_Code_))),COUNT(__d6(__NN(N_A_I_C_S_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d6(__NL(Best_Primary_Range_))),COUNT(__d6(__NN(Best_Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d6(__NL(Best_Predirectional_))),COUNT(__d6(__NN(Best_Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d6(__NL(Best_Primary_Name_))),COUNT(__d6(__NN(Best_Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d6(__NL(Best_Suffix_))),COUNT(__d6(__NN(Best_Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d6(__NL(Best_Postdirectional_))),COUNT(__d6(__NN(Best_Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d6(__NL(Best_Unit_Designation_))),COUNT(__d6(__NN(Best_Unit_Designation_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d6(__NL(Best_Secondary_Range_))),COUNT(__d6(__NN(Best_Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d6(__NL(Best_Postal_City_))),COUNT(__d6(__NN(Best_Postal_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d6(__NL(Best_Vanity_City_))),COUNT(__d6(__NN(Best_Vanity_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d6(__NL(Best_State_))),COUNT(__d6(__NN(Best_State_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d6(__NL(Best_Zip5_))),COUNT(__d6(__NN(Best_Zip5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d6(__NL(Best_Zip4_))),COUNT(__d6(__NN(Best_Zip4_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCounty',COUNT(__d6(__NL(Best_County_))),COUNT(__d6(__NN(Best_County_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d6(__NL(Best_Address_Rank_))),COUNT(__d6(__NN(Best_Address_Rank_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_last_reported',COUNT(__d6(__NL(Date_Vendor_Last_Reported_))),COUNT(__d6(__NN(Date_Vendor_Last_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_first_reported',COUNT(__d6(__NL(Date_Vendor_First_Reported_))),COUNT(__d6(__NN(Date_Vendor_First_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeenCompanyAddress',COUNT(__d6(__NL(Date_First_Seen_Company_Address_))),COUNT(__d6(__NN(Date_First_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenCompanyAddress',COUNT(__d6(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d6(__NN(Date_Last_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d6(__NL(Source_))),COUNT(__d6(__NN(Source_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d7(__NL(Site_))),COUNT(__d7(__NN(Site_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d7(__NL(Location_))),COUNT(__d7(__NN(Location_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_prim_range',COUNT(__d7(__NL(Primary_Range_))),COUNT(__d7(__NN(Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_predir',COUNT(__d7(__NL(Predirectional_))),COUNT(__d7(__NN(Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_prim_name',COUNT(__d7(__NL(Primary_Name_))),COUNT(__d7(__NN(Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_addr_suffix',COUNT(__d7(__NL(Suffix_))),COUNT(__d7(__NN(Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_postdir',COUNT(__d7(__NL(Postdirectional_))),COUNT(__d7(__NN(Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_sec_range',COUNT(__d7(__NL(Secondary_Range_))),COUNT(__d7(__NN(Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_zip5',COUNT(__d7(__NL(Z_I_P5_))),COUNT(__d7(__NN(Z_I_P5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_sic_code',COUNT(__d7(__NL(S_I_C_Code_))),COUNT(__d7(__NN(S_I_C_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_naic_code',COUNT(__d7(__NL(N_A_I_C_S_Code_))),COUNT(__d7(__NN(N_A_I_C_S_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d7(__NL(Best_Primary_Range_))),COUNT(__d7(__NN(Best_Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d7(__NL(Best_Predirectional_))),COUNT(__d7(__NN(Best_Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d7(__NL(Best_Primary_Name_))),COUNT(__d7(__NN(Best_Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d7(__NL(Best_Suffix_))),COUNT(__d7(__NN(Best_Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d7(__NL(Best_Postdirectional_))),COUNT(__d7(__NN(Best_Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d7(__NL(Best_Unit_Designation_))),COUNT(__d7(__NN(Best_Unit_Designation_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d7(__NL(Best_Secondary_Range_))),COUNT(__d7(__NN(Best_Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d7(__NL(Best_Postal_City_))),COUNT(__d7(__NN(Best_Postal_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d7(__NL(Best_Vanity_City_))),COUNT(__d7(__NN(Best_Vanity_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d7(__NL(Best_State_))),COUNT(__d7(__NN(Best_State_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d7(__NL(Best_Zip5_))),COUNT(__d7(__NN(Best_Zip5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d7(__NL(Best_Zip4_))),COUNT(__d7(__NN(Best_Zip4_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCounty',COUNT(__d7(__NL(Best_County_))),COUNT(__d7(__NN(Best_County_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d7(__NL(Best_Address_Rank_))),COUNT(__d7(__NN(Best_Address_Rank_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_last_reported',COUNT(__d7(__NL(Date_Vendor_Last_Reported_))),COUNT(__d7(__NN(Date_Vendor_Last_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_first_reported',COUNT(__d7(__NL(Date_Vendor_First_Reported_))),COUNT(__d7(__NN(Date_Vendor_First_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeenCompanyAddress',COUNT(__d7(__NL(Date_First_Seen_Company_Address_))),COUNT(__d7(__NN(Date_First_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenCompanyAddress',COUNT(__d7(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d7(__NN(Date_Last_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d7(__NL(Source_))),COUNT(__d7(__NN(Source_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d7(Date_First_Seen_=0)),COUNT(__d7(Date_First_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d7(Date_Last_Seen_=0)),COUNT(__d7(Date_Last_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d8(__NL(Site_))),COUNT(__d8(__NN(Site_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d8(__NL(Location_))),COUNT(__d8(__NN(Location_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d8(__NL(Primary_Range_))),COUNT(__d8(__NN(Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d8(__NL(Predirectional_))),COUNT(__d8(__NN(Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d8(__NL(Primary_Name_))),COUNT(__d8(__NN(Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d8(__NL(Suffix_))),COUNT(__d8(__NN(Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d8(__NL(Postdirectional_))),COUNT(__d8(__NN(Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d8(__NL(Secondary_Range_))),COUNT(__d8(__NN(Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d8(__NL(Z_I_P5_))),COUNT(__d8(__NN(Z_I_P5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SICCode',COUNT(__d8(__NL(S_I_C_Code_))),COUNT(__d8(__NN(S_I_C_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NAICSCode',COUNT(__d8(__NL(N_A_I_C_S_Code_))),COUNT(__d8(__NN(N_A_I_C_S_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d8(__NL(Best_Primary_Range_))),COUNT(__d8(__NN(Best_Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d8(__NL(Best_Predirectional_))),COUNT(__d8(__NN(Best_Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d8(__NL(Best_Primary_Name_))),COUNT(__d8(__NN(Best_Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d8(__NL(Best_Suffix_))),COUNT(__d8(__NN(Best_Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d8(__NL(Best_Postdirectional_))),COUNT(__d8(__NN(Best_Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d8(__NL(Best_Unit_Designation_))),COUNT(__d8(__NN(Best_Unit_Designation_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d8(__NL(Best_Secondary_Range_))),COUNT(__d8(__NN(Best_Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d8(__NL(Best_Postal_City_))),COUNT(__d8(__NN(Best_Postal_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d8(__NL(Best_Vanity_City_))),COUNT(__d8(__NN(Best_Vanity_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d8(__NL(Best_State_))),COUNT(__d8(__NN(Best_State_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d8(__NL(Best_Zip5_))),COUNT(__d8(__NN(Best_Zip5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d8(__NL(Best_Zip4_))),COUNT(__d8(__NN(Best_Zip4_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCounty',COUNT(__d8(__NL(Best_County_))),COUNT(__d8(__NN(Best_County_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d8(__NL(Best_Address_Rank_))),COUNT(__d8(__NN(Best_Address_Rank_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d8(__NL(Date_Vendor_Last_Reported_))),COUNT(__d8(__NN(Date_Vendor_Last_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d8(__NL(Date_Vendor_First_Reported_))),COUNT(__d8(__NN(Date_Vendor_First_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeenCompanyAddress',COUNT(__d8(__NL(Date_First_Seen_Company_Address_))),COUNT(__d8(__NN(Date_First_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenCompanyAddress',COUNT(__d8(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d8(__NN(Date_Last_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d8(__NL(Source_))),COUNT(__d8(__NN(Source_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d8(Date_First_Seen_=0)),COUNT(__d8(Date_First_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d8(Date_Last_Seen_=0)),COUNT(__d8(Date_Last_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d9(__NL(Site_))),COUNT(__d9(__NN(Site_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d9(__NL(Location_))),COUNT(__d9(__NN(Location_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d9(__NL(Primary_Range_))),COUNT(__d9(__NN(Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d9(__NL(Predirectional_))),COUNT(__d9(__NN(Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d9(__NL(Primary_Name_))),COUNT(__d9(__NN(Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d9(__NL(Suffix_))),COUNT(__d9(__NN(Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d9(__NL(Postdirectional_))),COUNT(__d9(__NN(Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d9(__NL(Secondary_Range_))),COUNT(__d9(__NN(Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d9(__NL(Z_I_P5_))),COUNT(__d9(__NN(Z_I_P5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sic_code',COUNT(__d9(__NL(S_I_C_Code_))),COUNT(__d9(__NN(S_I_C_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','naics_code',COUNT(__d9(__NL(N_A_I_C_S_Code_))),COUNT(__d9(__NN(N_A_I_C_S_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d9(__NL(Best_Primary_Range_))),COUNT(__d9(__NN(Best_Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d9(__NL(Best_Predirectional_))),COUNT(__d9(__NN(Best_Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d9(__NL(Best_Primary_Name_))),COUNT(__d9(__NN(Best_Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d9(__NL(Best_Suffix_))),COUNT(__d9(__NN(Best_Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d9(__NL(Best_Postdirectional_))),COUNT(__d9(__NN(Best_Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d9(__NL(Best_Unit_Designation_))),COUNT(__d9(__NN(Best_Unit_Designation_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d9(__NL(Best_Secondary_Range_))),COUNT(__d9(__NN(Best_Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d9(__NL(Best_Postal_City_))),COUNT(__d9(__NN(Best_Postal_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d9(__NL(Best_Vanity_City_))),COUNT(__d9(__NN(Best_Vanity_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d9(__NL(Best_State_))),COUNT(__d9(__NN(Best_State_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d9(__NL(Best_Zip5_))),COUNT(__d9(__NN(Best_Zip5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d9(__NL(Best_Zip4_))),COUNT(__d9(__NN(Best_Zip4_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCounty',COUNT(__d9(__NL(Best_County_))),COUNT(__d9(__NN(Best_County_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d9(__NL(Best_Address_Rank_))),COUNT(__d9(__NN(Best_Address_Rank_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d9(__NL(Date_Vendor_Last_Reported_))),COUNT(__d9(__NN(Date_Vendor_Last_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d9(__NL(Date_Vendor_First_Reported_))),COUNT(__d9(__NN(Date_Vendor_First_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeenCompanyAddress',COUNT(__d9(__NL(Date_First_Seen_Company_Address_))),COUNT(__d9(__NN(Date_First_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenCompanyAddress',COUNT(__d9(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d9(__NN(Date_Last_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d9(__NL(Source_))),COUNT(__d9(__NN(Source_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d9(Date_First_Seen_=0)),COUNT(__d9(Date_First_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d9(Date_Last_Seen_=0)),COUNT(__d9(Date_Last_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d10(__NL(Site_))),COUNT(__d10(__NN(Site_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d10(__NL(Location_))),COUNT(__d10(__NN(Location_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d10(__NL(Primary_Range_))),COUNT(__d10(__NN(Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d10(__NL(Predirectional_))),COUNT(__d10(__NN(Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d10(__NL(Primary_Name_))),COUNT(__d10(__NN(Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d10(__NL(Suffix_))),COUNT(__d10(__NN(Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d10(__NL(Postdirectional_))),COUNT(__d10(__NN(Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d10(__NL(Secondary_Range_))),COUNT(__d10(__NN(Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d10(__NL(Z_I_P5_))),COUNT(__d10(__NN(Z_I_P5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_primsic',COUNT(__d10(__NL(S_I_C_Code_))),COUNT(__d10(__NN(S_I_C_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_primnaicscode',COUNT(__d10(__NL(N_A_I_C_S_Code_))),COUNT(__d10(__NN(N_A_I_C_S_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d10(__NL(Best_Primary_Range_))),COUNT(__d10(__NN(Best_Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d10(__NL(Best_Predirectional_))),COUNT(__d10(__NN(Best_Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d10(__NL(Best_Primary_Name_))),COUNT(__d10(__NN(Best_Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d10(__NL(Best_Suffix_))),COUNT(__d10(__NN(Best_Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d10(__NL(Best_Postdirectional_))),COUNT(__d10(__NN(Best_Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d10(__NL(Best_Unit_Designation_))),COUNT(__d10(__NN(Best_Unit_Designation_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d10(__NL(Best_Secondary_Range_))),COUNT(__d10(__NN(Best_Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d10(__NL(Best_Postal_City_))),COUNT(__d10(__NN(Best_Postal_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d10(__NL(Best_Vanity_City_))),COUNT(__d10(__NN(Best_Vanity_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d10(__NL(Best_State_))),COUNT(__d10(__NN(Best_State_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d10(__NL(Best_Zip5_))),COUNT(__d10(__NN(Best_Zip5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d10(__NL(Best_Zip4_))),COUNT(__d10(__NN(Best_Zip4_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCounty',COUNT(__d10(__NL(Best_County_))),COUNT(__d10(__NN(Best_County_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d10(__NL(Best_Address_Rank_))),COUNT(__d10(__NN(Best_Address_Rank_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_last_reported',COUNT(__d10(__NL(Date_Vendor_Last_Reported_))),COUNT(__d10(__NN(Date_Vendor_Last_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_first_reported',COUNT(__d10(__NL(Date_Vendor_First_Reported_))),COUNT(__d10(__NN(Date_Vendor_First_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeenCompanyAddress',COUNT(__d10(__NL(Date_First_Seen_Company_Address_))),COUNT(__d10(__NN(Date_First_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenCompanyAddress',COUNT(__d10(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d10(__NN(Date_Last_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d10(__NL(Source_))),COUNT(__d10(__NN(Source_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d10(Date_First_Seen_=0)),COUNT(__d10(Date_First_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d10(Date_Last_Seen_=0)),COUNT(__d10(Date_Last_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d11(__NL(Site_))),COUNT(__d11(__NN(Site_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d11(__NL(Location_))),COUNT(__d11(__NN(Location_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d11(__NL(Primary_Range_))),COUNT(__d11(__NN(Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d11(__NL(Predirectional_))),COUNT(__d11(__NN(Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d11(__NL(Primary_Name_))),COUNT(__d11(__NN(Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d11(__NL(Suffix_))),COUNT(__d11(__NN(Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d11(__NL(Postdirectional_))),COUNT(__d11(__NN(Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d11(__NL(Secondary_Range_))),COUNT(__d11(__NN(Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d11(__NL(Z_I_P5_))),COUNT(__d11(__NN(Z_I_P5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_secsic1',COUNT(__d11(__NL(S_I_C_Code_))),COUNT(__d11(__NN(S_I_C_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_secnaics1',COUNT(__d11(__NL(N_A_I_C_S_Code_))),COUNT(__d11(__NN(N_A_I_C_S_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d11(__NL(Best_Primary_Range_))),COUNT(__d11(__NN(Best_Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d11(__NL(Best_Predirectional_))),COUNT(__d11(__NN(Best_Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d11(__NL(Best_Primary_Name_))),COUNT(__d11(__NN(Best_Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d11(__NL(Best_Suffix_))),COUNT(__d11(__NN(Best_Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d11(__NL(Best_Postdirectional_))),COUNT(__d11(__NN(Best_Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d11(__NL(Best_Unit_Designation_))),COUNT(__d11(__NN(Best_Unit_Designation_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d11(__NL(Best_Secondary_Range_))),COUNT(__d11(__NN(Best_Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d11(__NL(Best_Postal_City_))),COUNT(__d11(__NN(Best_Postal_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d11(__NL(Best_Vanity_City_))),COUNT(__d11(__NN(Best_Vanity_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d11(__NL(Best_State_))),COUNT(__d11(__NN(Best_State_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d11(__NL(Best_Zip5_))),COUNT(__d11(__NN(Best_Zip5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d11(__NL(Best_Zip4_))),COUNT(__d11(__NN(Best_Zip4_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCounty',COUNT(__d11(__NL(Best_County_))),COUNT(__d11(__NN(Best_County_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d11(__NL(Best_Address_Rank_))),COUNT(__d11(__NN(Best_Address_Rank_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_last_reported',COUNT(__d11(__NL(Date_Vendor_Last_Reported_))),COUNT(__d11(__NN(Date_Vendor_Last_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_first_reported',COUNT(__d11(__NL(Date_Vendor_First_Reported_))),COUNT(__d11(__NN(Date_Vendor_First_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeenCompanyAddress',COUNT(__d11(__NL(Date_First_Seen_Company_Address_))),COUNT(__d11(__NN(Date_First_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenCompanyAddress',COUNT(__d11(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d11(__NN(Date_Last_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d11(__NL(Source_))),COUNT(__d11(__NN(Source_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d11(Date_First_Seen_=0)),COUNT(__d11(Date_First_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d11(Date_Last_Seen_=0)),COUNT(__d11(Date_Last_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d12(__NL(Site_))),COUNT(__d12(__NN(Site_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d12(__NL(Location_))),COUNT(__d12(__NN(Location_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d12(__NL(Primary_Range_))),COUNT(__d12(__NN(Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d12(__NL(Predirectional_))),COUNT(__d12(__NN(Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d12(__NL(Primary_Name_))),COUNT(__d12(__NN(Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d12(__NL(Suffix_))),COUNT(__d12(__NN(Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d12(__NL(Postdirectional_))),COUNT(__d12(__NN(Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d12(__NL(Secondary_Range_))),COUNT(__d12(__NN(Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d12(__NL(Z_I_P5_))),COUNT(__d12(__NN(Z_I_P5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_secsic2',COUNT(__d12(__NL(S_I_C_Code_))),COUNT(__d12(__NN(S_I_C_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_secnaics2',COUNT(__d12(__NL(N_A_I_C_S_Code_))),COUNT(__d12(__NN(N_A_I_C_S_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d12(__NL(Best_Primary_Range_))),COUNT(__d12(__NN(Best_Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d12(__NL(Best_Predirectional_))),COUNT(__d12(__NN(Best_Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d12(__NL(Best_Primary_Name_))),COUNT(__d12(__NN(Best_Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d12(__NL(Best_Suffix_))),COUNT(__d12(__NN(Best_Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d12(__NL(Best_Postdirectional_))),COUNT(__d12(__NN(Best_Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d12(__NL(Best_Unit_Designation_))),COUNT(__d12(__NN(Best_Unit_Designation_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d12(__NL(Best_Secondary_Range_))),COUNT(__d12(__NN(Best_Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d12(__NL(Best_Postal_City_))),COUNT(__d12(__NN(Best_Postal_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d12(__NL(Best_Vanity_City_))),COUNT(__d12(__NN(Best_Vanity_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d12(__NL(Best_State_))),COUNT(__d12(__NN(Best_State_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d12(__NL(Best_Zip5_))),COUNT(__d12(__NN(Best_Zip5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d12(__NL(Best_Zip4_))),COUNT(__d12(__NN(Best_Zip4_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCounty',COUNT(__d12(__NL(Best_County_))),COUNT(__d12(__NN(Best_County_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d12(__NL(Best_Address_Rank_))),COUNT(__d12(__NN(Best_Address_Rank_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_last_reported',COUNT(__d12(__NL(Date_Vendor_Last_Reported_))),COUNT(__d12(__NN(Date_Vendor_Last_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_first_reported',COUNT(__d12(__NL(Date_Vendor_First_Reported_))),COUNT(__d12(__NN(Date_Vendor_First_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeenCompanyAddress',COUNT(__d12(__NL(Date_First_Seen_Company_Address_))),COUNT(__d12(__NN(Date_First_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenCompanyAddress',COUNT(__d12(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d12(__NN(Date_Last_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d12(__NL(Source_))),COUNT(__d12(__NN(Source_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d12(Date_First_Seen_=0)),COUNT(__d12(Date_First_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d12(Date_Last_Seen_=0)),COUNT(__d12(Date_Last_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d13(__NL(Site_))),COUNT(__d13(__NN(Site_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d13(__NL(Location_))),COUNT(__d13(__NN(Location_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d13(__NL(Primary_Range_))),COUNT(__d13(__NN(Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d13(__NL(Predirectional_))),COUNT(__d13(__NN(Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d13(__NL(Primary_Name_))),COUNT(__d13(__NN(Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d13(__NL(Suffix_))),COUNT(__d13(__NN(Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d13(__NL(Postdirectional_))),COUNT(__d13(__NN(Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d13(__NL(Secondary_Range_))),COUNT(__d13(__NN(Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d13(__NL(Z_I_P5_))),COUNT(__d13(__NN(Z_I_P5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_secsic3',COUNT(__d13(__NL(S_I_C_Code_))),COUNT(__d13(__NN(S_I_C_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_secnaics3',COUNT(__d13(__NL(N_A_I_C_S_Code_))),COUNT(__d13(__NN(N_A_I_C_S_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d13(__NL(Best_Primary_Range_))),COUNT(__d13(__NN(Best_Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d13(__NL(Best_Predirectional_))),COUNT(__d13(__NN(Best_Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d13(__NL(Best_Primary_Name_))),COUNT(__d13(__NN(Best_Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d13(__NL(Best_Suffix_))),COUNT(__d13(__NN(Best_Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d13(__NL(Best_Postdirectional_))),COUNT(__d13(__NN(Best_Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d13(__NL(Best_Unit_Designation_))),COUNT(__d13(__NN(Best_Unit_Designation_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d13(__NL(Best_Secondary_Range_))),COUNT(__d13(__NN(Best_Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d13(__NL(Best_Postal_City_))),COUNT(__d13(__NN(Best_Postal_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d13(__NL(Best_Vanity_City_))),COUNT(__d13(__NN(Best_Vanity_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d13(__NL(Best_State_))),COUNT(__d13(__NN(Best_State_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d13(__NL(Best_Zip5_))),COUNT(__d13(__NN(Best_Zip5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d13(__NL(Best_Zip4_))),COUNT(__d13(__NN(Best_Zip4_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCounty',COUNT(__d13(__NL(Best_County_))),COUNT(__d13(__NN(Best_County_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d13(__NL(Best_Address_Rank_))),COUNT(__d13(__NN(Best_Address_Rank_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_last_reported',COUNT(__d13(__NL(Date_Vendor_Last_Reported_))),COUNT(__d13(__NN(Date_Vendor_Last_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_first_reported',COUNT(__d13(__NL(Date_Vendor_First_Reported_))),COUNT(__d13(__NN(Date_Vendor_First_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeenCompanyAddress',COUNT(__d13(__NL(Date_First_Seen_Company_Address_))),COUNT(__d13(__NN(Date_First_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenCompanyAddress',COUNT(__d13(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d13(__NN(Date_Last_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d13(__NL(Source_))),COUNT(__d13(__NN(Source_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d13(Date_First_Seen_=0)),COUNT(__d13(Date_First_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d13(Date_Last_Seen_=0)),COUNT(__d13(Date_Last_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d14(__NL(Site_))),COUNT(__d14(__NN(Site_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d14(__NL(Location_))),COUNT(__d14(__NN(Location_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d14(__NL(Primary_Range_))),COUNT(__d14(__NN(Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d14(__NL(Predirectional_))),COUNT(__d14(__NN(Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d14(__NL(Primary_Name_))),COUNT(__d14(__NN(Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d14(__NL(Suffix_))),COUNT(__d14(__NN(Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d14(__NL(Postdirectional_))),COUNT(__d14(__NN(Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d14(__NL(Secondary_Range_))),COUNT(__d14(__NN(Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d14(__NL(Z_I_P5_))),COUNT(__d14(__NN(Z_I_P5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_secsic4',COUNT(__d14(__NL(S_I_C_Code_))),COUNT(__d14(__NN(S_I_C_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_secnaics4',COUNT(__d14(__NL(N_A_I_C_S_Code_))),COUNT(__d14(__NN(N_A_I_C_S_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d14(__NL(Best_Primary_Range_))),COUNT(__d14(__NN(Best_Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d14(__NL(Best_Predirectional_))),COUNT(__d14(__NN(Best_Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d14(__NL(Best_Primary_Name_))),COUNT(__d14(__NN(Best_Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d14(__NL(Best_Suffix_))),COUNT(__d14(__NN(Best_Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d14(__NL(Best_Postdirectional_))),COUNT(__d14(__NN(Best_Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d14(__NL(Best_Unit_Designation_))),COUNT(__d14(__NN(Best_Unit_Designation_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d14(__NL(Best_Secondary_Range_))),COUNT(__d14(__NN(Best_Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d14(__NL(Best_Postal_City_))),COUNT(__d14(__NN(Best_Postal_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d14(__NL(Best_Vanity_City_))),COUNT(__d14(__NN(Best_Vanity_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d14(__NL(Best_State_))),COUNT(__d14(__NN(Best_State_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d14(__NL(Best_Zip5_))),COUNT(__d14(__NN(Best_Zip5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d14(__NL(Best_Zip4_))),COUNT(__d14(__NN(Best_Zip4_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCounty',COUNT(__d14(__NL(Best_County_))),COUNT(__d14(__NN(Best_County_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d14(__NL(Best_Address_Rank_))),COUNT(__d14(__NN(Best_Address_Rank_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_last_reported',COUNT(__d14(__NL(Date_Vendor_Last_Reported_))),COUNT(__d14(__NN(Date_Vendor_Last_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_first_reported',COUNT(__d14(__NL(Date_Vendor_First_Reported_))),COUNT(__d14(__NN(Date_Vendor_First_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeenCompanyAddress',COUNT(__d14(__NL(Date_First_Seen_Company_Address_))),COUNT(__d14(__NN(Date_First_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenCompanyAddress',COUNT(__d14(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d14(__NN(Date_Last_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d14(__NL(Source_))),COUNT(__d14(__NN(Source_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d14(Date_First_Seen_=0)),COUNT(__d14(Date_First_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d14(Date_Last_Seen_=0)),COUNT(__d14(Date_Last_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d15(__NL(Site_))),COUNT(__d15(__NN(Site_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d15(__NL(Location_))),COUNT(__d15(__NN(Location_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d15(__NL(Primary_Range_))),COUNT(__d15(__NN(Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d15(__NL(Predirectional_))),COUNT(__d15(__NN(Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d15(__NL(Primary_Name_))),COUNT(__d15(__NN(Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d15(__NL(Suffix_))),COUNT(__d15(__NN(Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d15(__NL(Postdirectional_))),COUNT(__d15(__NN(Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d15(__NL(Secondary_Range_))),COUNT(__d15(__NN(Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d15(__NL(Z_I_P5_))),COUNT(__d15(__NN(Z_I_P5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SICCode',COUNT(__d15(__NL(S_I_C_Code_))),COUNT(__d15(__NN(S_I_C_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NAICSCode',COUNT(__d15(__NL(N_A_I_C_S_Code_))),COUNT(__d15(__NN(N_A_I_C_S_Code_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d15(__NL(Best_Primary_Range_))),COUNT(__d15(__NN(Best_Primary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d15(__NL(Best_Predirectional_))),COUNT(__d15(__NN(Best_Predirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d15(__NL(Best_Primary_Name_))),COUNT(__d15(__NN(Best_Primary_Name_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d15(__NL(Best_Suffix_))),COUNT(__d15(__NN(Best_Suffix_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d15(__NL(Best_Postdirectional_))),COUNT(__d15(__NN(Best_Postdirectional_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','unit_desig',COUNT(__d15(__NL(Best_Unit_Designation_))),COUNT(__d15(__NN(Best_Unit_Designation_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d15(__NL(Best_Secondary_Range_))),COUNT(__d15(__NN(Best_Secondary_Range_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','p_city_name',COUNT(__d15(__NL(Best_Postal_City_))),COUNT(__d15(__NN(Best_Postal_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','v_city_name',COUNT(__d15(__NL(Best_Vanity_City_))),COUNT(__d15(__NN(Best_Vanity_City_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d15(__NL(Best_State_))),COUNT(__d15(__NN(Best_State_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d15(__NL(Best_Zip5_))),COUNT(__d15(__NN(Best_Zip5_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip4',COUNT(__d15(__NL(Best_Zip4_))),COUNT(__d15(__NN(Best_Zip4_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestCounty',COUNT(__d15(__NL(Best_County_))),COUNT(__d15(__NN(Best_County_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d15(__NL(Date_Vendor_Last_Reported_))),COUNT(__d15(__NN(Date_Vendor_Last_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d15(__NL(Date_Vendor_First_Reported_))),COUNT(__d15(__NN(Date_Vendor_First_Reported_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeenCompanyAddress',COUNT(__d15(__NL(Date_First_Seen_Company_Address_))),COUNT(__d15(__NN(Date_First_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenCompanyAddress',COUNT(__d15(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d15(__NN(Date_Last_Seen_Company_Address_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d15(__NL(Source_))),COUNT(__d15(__NN(Source_)))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d15(Date_First_Seen_=0)),COUNT(__d15(Date_First_Seen_!=0))},
    {'ProxAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d15(Date_Last_Seen_=0)),COUNT(__d15(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
