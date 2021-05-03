//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Address,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Geo_Link,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT E_Sele_Address(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Unit_Designation_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Postal_City_;
    KEL.typ.nstr Vanity_City_;
    KEL.typ.nstr State_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nstr Rec_Type_;
    KEL.typ.nint Z_I_P4_;
    KEL.typ.nint Metropolitan_Statistical_Area_;
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
    KEL.typ.nint Best_Address_Rank_;
    KEL.typ.nstr Company_Address_Type_Raw_;
    KEL.typ.nstr Company_Address_Type_Derived_;
    KEL.typ.nstr Address_Type_Derived_;
    KEL.typ.nkdate Date_First_Seen_Company_Address_;
    KEL.typ.nkdate Date_Last_Seen_Company_Address_;
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
  SHARED __Mapping := 'Legal_(DEFAULT:Legal_:0),Location_(DEFAULT:Location_:0),primaryrange(DEFAULT:Primary_Range_:\'\'),predirectional(DEFAULT:Predirectional_:\'\'),primaryname(DEFAULT:Primary_Name_:\'\'),suffix(DEFAULT:Suffix_:\'\'),postdirectional(DEFAULT:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),secondaryrange(DEFAULT:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),vanitycity(DEFAULT:Vanity_City_),state(DEFAULT:State_),zip5(DEFAULT:Z_I_P5_:0),rectype(DEFAULT:Rec_Type_:\'\'),zip4(DEFAULT:Z_I_P4_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),siccode(DEFAULT:S_I_C_Code_:\'\'),naicscode(DEFAULT:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestaddressrank(DEFAULT:Best_Address_Rank_:0),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),datefirstseencompanyaddress(DEFAULT:Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(DEFAULT:Date_Last_Seen_Company_Address_:DATE),headerhitflag(DEFAULT:Header_Hit_Flag_),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping0 := 'Legal_(DEFAULT:Legal_:0),Location_(DEFAULT:Location_:0),prim_range_derived(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name_derived(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unit_desig(OVERRIDE:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),p_city_name(OVERRIDE:Postal_City_),v_city_name(OVERRIDE:Vanity_City_),st(OVERRIDE:State_),zip(OVERRIDE:Z_I_P5_:0),rec_type(OVERRIDE:Rec_Type_:\'\'),zip4(OVERRIDE:Z_I_P4_),msa(OVERRIDE:Metropolitan_Statistical_Area_),company_sic_code1(OVERRIDE:S_I_C_Code_:\'\'),company_naics_code1(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestaddressrank(DEFAULT:Best_Address_Rank_:0),company_address_type_raw(OVERRIDE:Company_Address_Type_Raw_:\'\'),company_address_type_derived(OVERRIDE:Company_Address_Type_Derived_:\'\'),address_type_derived(OVERRIDE:Address_Type_Derived_:\'\'),dt_first_seen_company_address(OVERRIDE:Date_First_Seen_Company_Address_:DATE),dt_last_seen_company_address(OVERRIDE:Date_Last_Seen_Company_Address_:DATE),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_kfetch2,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_kfetch2),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((STRING28)prim_name_derived != '' AND (UNSIGNED3)zip != 0  AND (UNSIGNED)seleid<>0);
  SHARED __d0_Legal__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d0_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d0_Legal__Mapped := IF(__d0_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d0_KELfiltered,TRANSFORM(__d0_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_KELfiltered,__d0_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d0_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Location__Layout := RECORD
    RECORDOF(__d0_Legal__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d0_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Legal__Mapped,'prim_range_derived,predir,prim_name_derived,addr_suffix,postdir,zip,sec_range','__in');
  SHARED __d0_Location__Mapped := IF(__d0_Missing_Location__UIDComponents = 'prim_range_derived,predir,prim_name_derived,addr_suffix,postdir,zip,sec_range',PROJECT(__d0_Legal__Mapped,TRANSFORM(__d0_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Legal__Mapped,__d0_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range_derived) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name_derived) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d0_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Prefiltered := __d0_Location__Mapped;
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping0_Transform(LEFT)));
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping1 := 'Legal_(DEFAULT:Legal_:0),Location_(DEFAULT:Location_:0),prim_range_derived(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name_derived(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),vanitycity(DEFAULT:Vanity_City_),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),rectype(DEFAULT:Rec_Type_:\'\'),zip4(DEFAULT:Z_I_P4_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),company_sic_code2(OVERRIDE:S_I_C_Code_:\'\'),company_naics_code2(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestaddressrank(DEFAULT:Best_Address_Rank_:0),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),dt_first_seen_company_address(OVERRIDE:Date_First_Seen_Company_Address_:DATE),dt_last_seen_company_address(OVERRIDE:Date_Last_Seen_Company_Address_:DATE),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_kfetch2,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_kfetch2),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((STRING28)prim_name_derived != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)seleid<>0 AND((UNSIGNED)company_sic_code2 > 0 OR (UNSIGNED)company_naics_code2 > 0));
  SHARED __d1_Legal__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d1_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d1_Legal__Mapped := IF(__d1_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d1_KELfiltered,TRANSFORM(__d1_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_KELfiltered,__d1_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d1_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d1_Location__Layout := RECORD
    RECORDOF(__d1_Legal__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d1_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_Legal__Mapped,'prim_range_derived,predir,prim_name_derived,addr_suffix,postdir,zip,sec_range','__in');
  SHARED __d1_Location__Mapped := IF(__d1_Missing_Location__UIDComponents = 'prim_range_derived,predir,prim_name_derived,addr_suffix,postdir,zip,sec_range',PROJECT(__d1_Legal__Mapped,TRANSFORM(__d1_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_Legal__Mapped,__d1_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range_derived) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name_derived) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d1_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d1_Prefiltered := __d1_Location__Mapped;
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping1_Transform(LEFT)));
  SHARED Date_Last_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping2 := 'Legal_(DEFAULT:Legal_:0),Location_(DEFAULT:Location_:0),prim_range_derived(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name_derived(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),vanitycity(DEFAULT:Vanity_City_),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),rectype(DEFAULT:Rec_Type_:\'\'),zip4(DEFAULT:Z_I_P4_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),company_sic_code3(OVERRIDE:S_I_C_Code_:\'\'),company_naics_code3(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestaddressrank(DEFAULT:Best_Address_Rank_:0),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),dt_first_seen_company_address(OVERRIDE:Date_First_Seen_Company_Address_:DATE),dt_last_seen_company_address(OVERRIDE:Date_Last_Seen_Company_Address_:DATE),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_2Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping2_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_kfetch2,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_kfetch2),SELF:=RIGHT));
  EXPORT __d2_KELfiltered := __d2_Norm((STRING28)prim_name_derived != '' AND (UNSIGNED3)zip != 0  AND (UNSIGNED)seleid<>0 AND((UNSIGNED)company_sic_code3 > 0 OR (UNSIGNED)company_naics_code3 > 0));
  SHARED __d2_Legal__Layout := RECORD
    RECORDOF(__d2_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d2_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d2_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d2_Legal__Mapped := IF(__d2_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d2_KELfiltered,TRANSFORM(__d2_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d2_KELfiltered,__d2_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d2_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d2_Location__Layout := RECORD
    RECORDOF(__d2_Legal__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d2_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d2_Legal__Mapped,'prim_range_derived,predir,prim_name_derived,addr_suffix,postdir,zip,sec_range','__in');
  SHARED __d2_Location__Mapped := IF(__d2_Missing_Location__UIDComponents = 'prim_range_derived,predir,prim_name_derived,addr_suffix,postdir,zip,sec_range',PROJECT(__d2_Legal__Mapped,TRANSFORM(__d2_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d2_Legal__Mapped,__d2_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range_derived) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name_derived) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d2_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d2_Prefiltered := __d2_Location__Mapped;
  SHARED __d2 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping2_Transform(LEFT)));
  SHARED Date_Last_Seen_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping3 := 'Legal_(DEFAULT:Legal_:0),Location_(DEFAULT:Location_:0),prim_range_derived(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name_derived(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),vanitycity(DEFAULT:Vanity_City_),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),rectype(DEFAULT:Rec_Type_:\'\'),zip4(DEFAULT:Z_I_P4_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),company_sic_code4(OVERRIDE:S_I_C_Code_:\'\'),company_naics_code4(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestaddressrank(DEFAULT:Best_Address_Rank_:0),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),dt_first_seen_company_address(OVERRIDE:Date_First_Seen_Company_Address_:DATE),dt_last_seen_company_address(OVERRIDE:Date_Last_Seen_Company_Address_:DATE),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_3Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping3_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_kfetch2,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_kfetch2),SELF:=RIGHT));
  EXPORT __d3_KELfiltered := __d3_Norm((STRING28)prim_name_derived != '' AND (UNSIGNED3)zip != 0  AND (UNSIGNED)seleid<>0 AND((UNSIGNED)company_sic_code4 > 0 OR (UNSIGNED)company_naics_code4 > 0));
  SHARED __d3_Legal__Layout := RECORD
    RECORDOF(__d3_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d3_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d3_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d3_Legal__Mapped := IF(__d3_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d3_KELfiltered,TRANSFORM(__d3_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d3_KELfiltered,__d3_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d3_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d3_Location__Layout := RECORD
    RECORDOF(__d3_Legal__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d3_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d3_Legal__Mapped,'prim_range_derived,predir,prim_name_derived,addr_suffix,postdir,zip,sec_range','__in');
  SHARED __d3_Location__Mapped := IF(__d3_Missing_Location__UIDComponents = 'prim_range_derived,predir,prim_name_derived,addr_suffix,postdir,zip,sec_range',PROJECT(__d3_Legal__Mapped,TRANSFORM(__d3_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d3_Legal__Mapped,__d3_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range_derived) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name_derived) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d3_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d3_Prefiltered := __d3_Location__Mapped;
  SHARED __d3 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping3_Transform(LEFT)));
  SHARED Date_Last_Seen_4Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping4 := 'Legal_(DEFAULT:Legal_:0),Location_(DEFAULT:Location_:0),prim_range_derived(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name_derived(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),vanitycity(DEFAULT:Vanity_City_),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),rectype(DEFAULT:Rec_Type_:\'\'),zip4(DEFAULT:Z_I_P4_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),company_sic_code5(OVERRIDE:S_I_C_Code_:\'\'),company_naics_code5(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestaddressrank(DEFAULT:Best_Address_Rank_:0),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),dt_first_seen_company_address(OVERRIDE:Date_First_Seen_Company_Address_:DATE),dt_last_seen_company_address(OVERRIDE:Date_Last_Seen_Company_Address_:DATE),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_4Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping4_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_kfetch2,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_kfetch2),SELF:=RIGHT));
  EXPORT __d4_KELfiltered := __d4_Norm((STRING28)prim_name_derived != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)seleid<>0 AND((UNSIGNED)company_sic_code5 > 0 OR (UNSIGNED)company_naics_code5 > 0));
  SHARED __d4_Legal__Layout := RECORD
    RECORDOF(__d4_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d4_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d4_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d4_Legal__Mapped := IF(__d4_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d4_KELfiltered,TRANSFORM(__d4_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d4_KELfiltered,__d4_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d4_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d4_Location__Layout := RECORD
    RECORDOF(__d4_Legal__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d4_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d4_Legal__Mapped,'prim_range_derived,predir,prim_name_derived,addr_suffix,postdir,zip,sec_range','__in');
  SHARED __d4_Location__Mapped := IF(__d4_Missing_Location__UIDComponents = 'prim_range_derived,predir,prim_name_derived,addr_suffix,postdir,zip,sec_range',PROJECT(__d4_Legal__Mapped,TRANSFORM(__d4_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d4_Legal__Mapped,__d4_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range_derived) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name_derived) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d4_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d4_Prefiltered := __d4_Location__Mapped;
  SHARED __d4 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping4_Transform(LEFT)));
  SHARED __Mapping5 := 'Legal_(DEFAULT:Legal_:0),Location_(DEFAULT:Location_:0),corp_addr1_prim_range(OVERRIDE:Primary_Range_:\'\'),corp_addr1_predir(OVERRIDE:Predirectional_:\'\'),corp_addr1_prim_name(OVERRIDE:Primary_Name_:\'\'),corp_addr1_addr_suffix(OVERRIDE:Suffix_:\'\'),corp_addr1_postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),corp_addr1_sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),vanitycity(DEFAULT:Vanity_City_),state(DEFAULT:State_),corp_addr1_zip5(OVERRIDE:Z_I_P5_:0),rectype(DEFAULT:Rec_Type_:\'\'),zip4(DEFAULT:Z_I_P4_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),corp_sic_code(OVERRIDE:S_I_C_Code_:\'\'),corp_naic_code(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestaddressrank(DEFAULT:Best_Address_Rank_:0),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),datefirstseencompanyaddress(DEFAULT:Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(DEFAULT:Date_Last_Seen_Company_Address_:DATE),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d5_Norm := NORMALIZE(__in,LEFT.Dataset_Corp2__Kfetch_LinkIDs_Corp,TRANSFORM(RECORDOF(__in.Dataset_Corp2__Kfetch_LinkIDs_Corp),SELF:=RIGHT));
  EXPORT __d5_KELfiltered := __d5_Norm((STRING28)corp_addr1_prim_name != '' AND (UNSIGNED3)corp_addr1_zip5 != 0 AND (UNSIGNED)seleid<>0);
  SHARED __d5_Legal__Layout := RECORD
    RECORDOF(__d5_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d5_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d5_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d5_Legal__Mapped := IF(__d5_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d5_KELfiltered,TRANSFORM(__d5_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d5_KELfiltered,__d5_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d5_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d5_Location__Layout := RECORD
    RECORDOF(__d5_Legal__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d5_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d5_Legal__Mapped,'corp_addr1_prim_range,corp_addr1_predir,corp_addr1_prim_name,corp_addr1_addr_suffix,corp_addr1_postdir,corp_addr1_zip5,corp_addr1_sec_range','__in');
  SHARED __d5_Location__Mapped := IF(__d5_Missing_Location__UIDComponents = 'corp_addr1_prim_range,corp_addr1_predir,corp_addr1_prim_name,corp_addr1_addr_suffix,corp_addr1_postdir,corp_addr1_zip5,corp_addr1_sec_range',PROJECT(__d5_Legal__Mapped,TRANSFORM(__d5_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d5_Legal__Mapped,__d5_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.corp_addr1_prim_range) + '|' + TRIM((STRING)LEFT.corp_addr1_predir) + '|' + TRIM((STRING)LEFT.corp_addr1_prim_name) + '|' + TRIM((STRING)LEFT.corp_addr1_addr_suffix) + '|' + TRIM((STRING)LEFT.corp_addr1_postdir) + '|' + TRIM((STRING)LEFT.corp_addr1_zip5) + '|' + TRIM((STRING)LEFT.corp_addr1_sec_range) = RIGHT.KeyVal,TRANSFORM(__d5_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d5_Prefiltered := __d5_Location__Mapped;
  SHARED __d5 := __SourceFilter(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping6 := 'Legal_(DEFAULT:Legal_:0),Location_(DEFAULT:Location_:0),corp_addr2_prim_range(OVERRIDE:Primary_Range_:\'\'),corp_addr2_predir(OVERRIDE:Predirectional_:\'\'),corp_addr2_prim_name(OVERRIDE:Primary_Name_:\'\'),corp_addr2_addr_suffix(OVERRIDE:Suffix_:\'\'),corp_addr2_postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),corp_addr2_sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),vanitycity(DEFAULT:Vanity_City_),state(DEFAULT:State_),corp_addr2_zip5(OVERRIDE:Z_I_P5_:0),rectype(DEFAULT:Rec_Type_:\'\'),zip4(DEFAULT:Z_I_P4_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),corp_sic_code(OVERRIDE:S_I_C_Code_:\'\'),corp_naic_code(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestaddressrank(DEFAULT:Best_Address_Rank_:0),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),datefirstseencompanyaddress(DEFAULT:Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(DEFAULT:Date_Last_Seen_Company_Address_:DATE),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d6_Norm := NORMALIZE(__in,LEFT.Dataset_Corp2__Kfetch_LinkIDs_Corp,TRANSFORM(RECORDOF(__in.Dataset_Corp2__Kfetch_LinkIDs_Corp),SELF:=RIGHT));
  EXPORT __d6_KELfiltered := __d6_Norm((STRING28)corp_addr2_prim_name != '' AND (UNSIGNED3)corp_addr2_zip5 != 0 AND (UNSIGNED)seleid<>0);
  SHARED __d6_Legal__Layout := RECORD
    RECORDOF(__d6_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d6_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d6_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d6_Legal__Mapped := IF(__d6_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d6_KELfiltered,TRANSFORM(__d6_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d6_KELfiltered,__d6_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d6_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d6_Location__Layout := RECORD
    RECORDOF(__d6_Legal__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d6_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d6_Legal__Mapped,'corp_addr2_prim_range,corp_addr2_predir,corp_addr2_prim_name,corp_addr2_addr_suffix,corp_addr2_postdir,corp_addr2_zip5,corp_addr2_sec_range','__in');
  SHARED __d6_Location__Mapped := IF(__d6_Missing_Location__UIDComponents = 'corp_addr2_prim_range,corp_addr2_predir,corp_addr2_prim_name,corp_addr2_addr_suffix,corp_addr2_postdir,corp_addr2_zip5,corp_addr2_sec_range',PROJECT(__d6_Legal__Mapped,TRANSFORM(__d6_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d6_Legal__Mapped,__d6_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.corp_addr2_prim_range) + '|' + TRIM((STRING)LEFT.corp_addr2_predir) + '|' + TRIM((STRING)LEFT.corp_addr2_prim_name) + '|' + TRIM((STRING)LEFT.corp_addr2_addr_suffix) + '|' + TRIM((STRING)LEFT.corp_addr2_postdir) + '|' + TRIM((STRING)LEFT.corp_addr2_zip5) + '|' + TRIM((STRING)LEFT.corp_addr2_sec_range) = RIGHT.KeyVal,TRANSFORM(__d6_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d6_Prefiltered := __d6_Location__Mapped;
  SHARED __d6 := __SourceFilter(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping7 := 'Legal_(DEFAULT:Legal_:0),Location_(DEFAULT:Location_:0),corp_ra_prim_range(OVERRIDE:Primary_Range_:\'\'),corp_ra_predir(OVERRIDE:Predirectional_:\'\'),corp_ra_prim_name(OVERRIDE:Primary_Name_:\'\'),corp_ra_addr_suffix(OVERRIDE:Suffix_:\'\'),corp_ra_postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),corp_ra_sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),vanitycity(DEFAULT:Vanity_City_),state(DEFAULT:State_),corp_ra_zip5(OVERRIDE:Z_I_P5_:0),rectype(DEFAULT:Rec_Type_:\'\'),zip4(DEFAULT:Z_I_P4_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),corp_sic_code(OVERRIDE:S_I_C_Code_:\'\'),corp_naic_code(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestaddressrank(DEFAULT:Best_Address_Rank_:0),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),datefirstseencompanyaddress(DEFAULT:Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(DEFAULT:Date_Last_Seen_Company_Address_:DATE),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d7_Norm := NORMALIZE(__in,LEFT.Dataset_Corp2__Kfetch_LinkIDs_Corp,TRANSFORM(RECORDOF(__in.Dataset_Corp2__Kfetch_LinkIDs_Corp),SELF:=RIGHT));
  EXPORT __d7_KELfiltered := __d7_Norm((STRING28)corp_ra_prim_name != '' AND (UNSIGNED3)corp_ra_zip5 != 0  AND (UNSIGNED)seleid<>0);
  SHARED __d7_Legal__Layout := RECORD
    RECORDOF(__d7_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d7_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d7_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d7_Legal__Mapped := IF(__d7_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d7_KELfiltered,TRANSFORM(__d7_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d7_KELfiltered,__d7_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d7_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d7_Location__Layout := RECORD
    RECORDOF(__d7_Legal__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d7_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d7_Legal__Mapped,'corp_ra_prim_range,corp_ra_predir,corp_ra_prim_name,corp_ra_addr_suffix,corp_ra_postdir,corp_ra_zip5,corp_ra_sec_range','__in');
  SHARED __d7_Location__Mapped := IF(__d7_Missing_Location__UIDComponents = 'corp_ra_prim_range,corp_ra_predir,corp_ra_prim_name,corp_ra_addr_suffix,corp_ra_postdir,corp_ra_zip5,corp_ra_sec_range',PROJECT(__d7_Legal__Mapped,TRANSFORM(__d7_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d7_Legal__Mapped,__d7_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.corp_ra_prim_range) + '|' + TRIM((STRING)LEFT.corp_ra_predir) + '|' + TRIM((STRING)LEFT.corp_ra_prim_name) + '|' + TRIM((STRING)LEFT.corp_ra_addr_suffix) + '|' + TRIM((STRING)LEFT.corp_ra_postdir) + '|' + TRIM((STRING)LEFT.corp_ra_zip5) + '|' + TRIM((STRING)LEFT.corp_ra_sec_range) = RIGHT.KeyVal,TRANSFORM(__d7_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d7_Prefiltered := __d7_Location__Mapped;
  SHARED __d7 := __SourceFilter(KEL.FromFlat.Convert(__d7_Prefiltered,InLayout,__Mapping7,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping8 := 'Legal_(DEFAULT:Legal_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),vanitycity(DEFAULT:Vanity_City_),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),rectype(DEFAULT:Rec_Type_:\'\'),zip4(DEFAULT:Z_I_P4_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),sic_code(OVERRIDE:S_I_C_Code_:\'\'),naics_code(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestaddressrank(DEFAULT:Best_Address_Rank_:0),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),datefirstseencompanyaddress(DEFAULT:Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(DEFAULT:Date_Last_Seen_Company_Address_:DATE),headerhitflag(DEFAULT:Header_Hit_Flag_),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),pub_date(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d8_Norm := NORMALIZE(__in,LEFT.Dataset_YellowPages__kfetch_yellowpages_linkids,TRANSFORM(RECORDOF(__in.Dataset_YellowPages__kfetch_yellowpages_linkids),SELF:=RIGHT));
  EXPORT __d8_KELfiltered := __d8_Norm((STRING28)prim_name != '' AND (UNSIGNED3)zip != 0  AND (UNSIGNED)seleid<>0);
  SHARED __d8_Legal__Layout := RECORD
    RECORDOF(__d8_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d8_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d8_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d8_Legal__Mapped := IF(__d8_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d8_KELfiltered,TRANSFORM(__d8_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d8_KELfiltered,__d8_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d8_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d8_Location__Layout := RECORD
    RECORDOF(__d8_Legal__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d8_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d8_Legal__Mapped,'prim_range,predir,prim_name,suffix,postdir,zip,sec_range','__in');
  SHARED __d8_Location__Mapped := IF(__d8_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,suffix,postdir,zip,sec_range',PROJECT(__d8_Legal__Mapped,TRANSFORM(__d8_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d8_Legal__Mapped,__d8_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d8_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d8_Prefiltered := __d8_Location__Mapped;
  SHARED __d8 := __SourceFilter(KEL.FromFlat.Convert(__d8_Prefiltered,InLayout,__Mapping8,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping9 := 'Legal_(DEFAULT:Legal_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),vanitycity(DEFAULT:Vanity_City_),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),rectype(DEFAULT:Rec_Type_:\'\'),zip4(DEFAULT:Z_I_P4_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),efx_primsic(OVERRIDE:S_I_C_Code_:\'\'),efx_primnaicscode(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestaddressrank(DEFAULT:Best_Address_Rank_:0),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),datefirstseencompanyaddress(DEFAULT:Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(DEFAULT:Date_Last_Seen_Company_Address_:DATE),headerhitflag(DEFAULT:Header_Hit_Flag_),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d9_Norm := NORMALIZE(__in,LEFT.Dataset_Equifax_Business__Data_kfetch_LinkIDs,TRANSFORM(RECORDOF(__in.Dataset_Equifax_Business__Data_kfetch_LinkIDs),SELF:=RIGHT));
  EXPORT __d9_KELfiltered := __d9_Norm((STRING28)prim_name != '' AND (UNSIGNED3)zip != 0  AND (UNSIGNED)seleid<>0);
  SHARED __d9_Legal__Layout := RECORD
    RECORDOF(__d9_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d9_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d9_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d9_Legal__Mapped := IF(__d9_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d9_KELfiltered,TRANSFORM(__d9_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d9_KELfiltered,__d9_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d9_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d9_Location__Layout := RECORD
    RECORDOF(__d9_Legal__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d9_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d9_Legal__Mapped,'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range','__in');
  SHARED __d9_Location__Mapped := IF(__d9_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range',PROJECT(__d9_Legal__Mapped,TRANSFORM(__d9_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d9_Legal__Mapped,__d9_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d9_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d9_Prefiltered := __d9_Location__Mapped;
  SHARED __d9 := __SourceFilter(KEL.FromFlat.Convert(__d9_Prefiltered,InLayout,__Mapping9,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping10 := 'Legal_(DEFAULT:Legal_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),vanitycity(DEFAULT:Vanity_City_),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),rectype(DEFAULT:Rec_Type_:\'\'),zip4(DEFAULT:Z_I_P4_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),efx_secsic1(OVERRIDE:S_I_C_Code_:\'\'),efx_secnaics1(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestaddressrank(DEFAULT:Best_Address_Rank_:0),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),datefirstseencompanyaddress(DEFAULT:Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(DEFAULT:Date_Last_Seen_Company_Address_:DATE),headerhitflag(DEFAULT:Header_Hit_Flag_),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d10_Norm := NORMALIZE(__in,LEFT.Dataset_Equifax_Business__Data_kfetch_LinkIDs,TRANSFORM(RECORDOF(__in.Dataset_Equifax_Business__Data_kfetch_LinkIDs),SELF:=RIGHT));
  EXPORT __d10_KELfiltered := __d10_Norm((STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)seleid<>0 AND ((UNSIGNED)efx_secsic1 > 0 OR (UNSIGNED)efx_secnaics1 > 0));
  SHARED __d10_Legal__Layout := RECORD
    RECORDOF(__d10_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d10_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d10_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d10_Legal__Mapped := IF(__d10_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d10_KELfiltered,TRANSFORM(__d10_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d10_KELfiltered,__d10_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d10_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d10_Location__Layout := RECORD
    RECORDOF(__d10_Legal__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d10_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d10_Legal__Mapped,'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range','__in');
  SHARED __d10_Location__Mapped := IF(__d10_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range',PROJECT(__d10_Legal__Mapped,TRANSFORM(__d10_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d10_Legal__Mapped,__d10_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d10_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d10_Prefiltered := __d10_Location__Mapped;
  SHARED __d10 := __SourceFilter(KEL.FromFlat.Convert(__d10_Prefiltered,InLayout,__Mapping10,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping11 := 'Legal_(DEFAULT:Legal_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),vanitycity(DEFAULT:Vanity_City_),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),rectype(DEFAULT:Rec_Type_:\'\'),zip4(DEFAULT:Z_I_P4_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),efx_secsic2(OVERRIDE:S_I_C_Code_:\'\'),efx_secnaics2(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestaddressrank(DEFAULT:Best_Address_Rank_:0),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),datefirstseencompanyaddress(DEFAULT:Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(DEFAULT:Date_Last_Seen_Company_Address_:DATE),headerhitflag(DEFAULT:Header_Hit_Flag_),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d11_Norm := NORMALIZE(__in,LEFT.Dataset_Equifax_Business__Data_kfetch_LinkIDs,TRANSFORM(RECORDOF(__in.Dataset_Equifax_Business__Data_kfetch_LinkIDs),SELF:=RIGHT));
  EXPORT __d11_KELfiltered := __d11_Norm((STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)seleid<>0 AND ((UNSIGNED)efx_secsic2 > 0 OR (UNSIGNED)efx_secnaics2 > 0));
  SHARED __d11_Legal__Layout := RECORD
    RECORDOF(__d11_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d11_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d11_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d11_Legal__Mapped := IF(__d11_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d11_KELfiltered,TRANSFORM(__d11_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d11_KELfiltered,__d11_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d11_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d11_Location__Layout := RECORD
    RECORDOF(__d11_Legal__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d11_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d11_Legal__Mapped,'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range','__in');
  SHARED __d11_Location__Mapped := IF(__d11_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range',PROJECT(__d11_Legal__Mapped,TRANSFORM(__d11_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d11_Legal__Mapped,__d11_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d11_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d11_Prefiltered := __d11_Location__Mapped;
  SHARED __d11 := __SourceFilter(KEL.FromFlat.Convert(__d11_Prefiltered,InLayout,__Mapping11,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping12 := 'Legal_(DEFAULT:Legal_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),vanitycity(DEFAULT:Vanity_City_),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),rectype(DEFAULT:Rec_Type_:\'\'),zip4(DEFAULT:Z_I_P4_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),efx_secsic3(OVERRIDE:S_I_C_Code_:\'\'),efx_secnaics3(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestaddressrank(DEFAULT:Best_Address_Rank_:0),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),datefirstseencompanyaddress(DEFAULT:Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(DEFAULT:Date_Last_Seen_Company_Address_:DATE),headerhitflag(DEFAULT:Header_Hit_Flag_),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d12_Norm := NORMALIZE(__in,LEFT.Dataset_Equifax_Business__Data_kfetch_LinkIDs,TRANSFORM(RECORDOF(__in.Dataset_Equifax_Business__Data_kfetch_LinkIDs),SELF:=RIGHT));
  EXPORT __d12_KELfiltered := __d12_Norm((STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)seleid<>0 AND ((UNSIGNED)efx_secsic3 > 0 OR (UNSIGNED)efx_secnaics3 > 0));
  SHARED __d12_Legal__Layout := RECORD
    RECORDOF(__d12_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d12_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d12_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d12_Legal__Mapped := IF(__d12_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d12_KELfiltered,TRANSFORM(__d12_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d12_KELfiltered,__d12_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d12_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d12_Location__Layout := RECORD
    RECORDOF(__d12_Legal__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d12_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d12_Legal__Mapped,'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range','__in');
  SHARED __d12_Location__Mapped := IF(__d12_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range',PROJECT(__d12_Legal__Mapped,TRANSFORM(__d12_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d12_Legal__Mapped,__d12_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d12_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d12_Prefiltered := __d12_Location__Mapped;
  SHARED __d12 := __SourceFilter(KEL.FromFlat.Convert(__d12_Prefiltered,InLayout,__Mapping12,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping13 := 'Legal_(DEFAULT:Legal_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),vanitycity(DEFAULT:Vanity_City_),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),rectype(DEFAULT:Rec_Type_:\'\'),zip4(DEFAULT:Z_I_P4_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),efx_secsic4(OVERRIDE:S_I_C_Code_:\'\'),efx_secnaics4(OVERRIDE:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestaddressrank(DEFAULT:Best_Address_Rank_:0),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),datefirstseencompanyaddress(DEFAULT:Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(DEFAULT:Date_Last_Seen_Company_Address_:DATE),headerhitflag(DEFAULT:Header_Hit_Flag_),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d13_Norm := NORMALIZE(__in,LEFT.Dataset_Equifax_Business__Data_kfetch_LinkIDs,TRANSFORM(RECORDOF(__in.Dataset_Equifax_Business__Data_kfetch_LinkIDs),SELF:=RIGHT));
  EXPORT __d13_KELfiltered := __d13_Norm((STRING28)prim_name != '' AND (UNSIGNED3)zip != 0 AND (UNSIGNED)seleid<>0 AND ((UNSIGNED)efx_secsic4 > 0 OR (UNSIGNED)efx_secnaics4 > 0));
  SHARED __d13_Legal__Layout := RECORD
    RECORDOF(__d13_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d13_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d13_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d13_Legal__Mapped := IF(__d13_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d13_KELfiltered,TRANSFORM(__d13_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d13_KELfiltered,__d13_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d13_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d13_Location__Layout := RECORD
    RECORDOF(__d13_Legal__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d13_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d13_Legal__Mapped,'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range','__in');
  SHARED __d13_Location__Mapped := IF(__d13_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range',PROJECT(__d13_Legal__Mapped,TRANSFORM(__d13_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d13_Legal__Mapped,__d13_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d13_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d13_Prefiltered := __d13_Location__Mapped;
  SHARED __d13 := __SourceFilter(KEL.FromFlat.Convert(__d13_Prefiltered,InLayout,__Mapping13,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping14 := 'Legal_(DEFAULT:Legal_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'|OVERRIDE:Best_Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'|OVERRIDE:Best_Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'|OVERRIDE:Best_Primary_Name_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'|OVERRIDE:Best_Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'|OVERRIDE:Best_Postdirectional_:\'\'),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'|OVERRIDE:Best_Secondary_Range_:\'\'),postalcity(DEFAULT:Postal_City_),vanitycity(DEFAULT:Vanity_City_),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0|OVERRIDE:Best_Zip5_:0),rectype(DEFAULT:Rec_Type_:\'\'),zip4(DEFAULT:Z_I_P4_|OVERRIDE:Best_Zip4_:0),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),siccode(DEFAULT:S_I_C_Code_:\'\'),naicscode(DEFAULT:N_A_I_C_S_Code_:\'\'),unit_desig(OVERRIDE:Best_Unit_Designation_:\'\'),p_city_name(OVERRIDE:Best_Postal_City_:\'\'),v_city_name(OVERRIDE:Best_Vanity_City_:\'\'),st(OVERRIDE:Best_State_:\'\'),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),datefirstseencompanyaddress(DEFAULT:Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(DEFAULT:Date_Last_Seen_Company_Address_:DATE),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping14_Transform(InLayout __r) := TRANSFORM
    SELF.Best_Address_Rank_ := __CN(1);
    SELF := __r;
  END;
  SHARED __d14_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2_Best__Key_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_BIPV2_Best__Key_LinkIds),SELF:=RIGHT));
  EXPORT __d14_KELfiltered := __d14_Norm(proxid = 0 AND seleid != 0 AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0);
  SHARED __d14_Legal__Layout := RECORD
    RECORDOF(__d14_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d14_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d14_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d14_Legal__Mapped := IF(__d14_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d14_KELfiltered,TRANSFORM(__d14_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d14_KELfiltered,__d14_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d14_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d14_Location__Layout := RECORD
    RECORDOF(__d14_Legal__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d14_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d14_Legal__Mapped,'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range','__in');
  SHARED __d14_Location__Mapped := IF(__d14_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,addr_suffix,postdir,zip,sec_range',PROJECT(__d14_Legal__Mapped,TRANSFORM(__d14_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d14_Legal__Mapped,__d14_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d14_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d14_Prefiltered := __d14_Location__Mapped;
  SHARED __d14 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d14_Prefiltered,InLayout,__Mapping14,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping14_Transform(LEFT)));
  SHARED __Mapping15 := 'Legal_(DEFAULT:Legal_:0),Location_(DEFAULT:Location_:0),prim_range(OVERRIDE:Primary_Range_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),suffix(OVERRIDE:Suffix_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),unit_desig(OVERRIDE:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_:\'\'),p_city_name(OVERRIDE:Postal_City_),v_city_name(OVERRIDE:Vanity_City_),st(OVERRIDE:State_),z5(OVERRIDE:Z_I_P5_:0),rectype(DEFAULT:Rec_Type_:\'\'),z4(OVERRIDE:Z_I_P4_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),siccode(DEFAULT:S_I_C_Code_:\'\'),naicscode(DEFAULT:N_A_I_C_S_Code_:\'\'),bestprimaryrange(DEFAULT:Best_Primary_Range_:\'\'),bestpredirectional(DEFAULT:Best_Predirectional_:\'\'),bestprimaryname(DEFAULT:Best_Primary_Name_:\'\'),bestsuffix(DEFAULT:Best_Suffix_:\'\'),bestpostdirectional(DEFAULT:Best_Postdirectional_:\'\'),bestunitdesignation(DEFAULT:Best_Unit_Designation_:\'\'),bestsecondaryrange(DEFAULT:Best_Secondary_Range_:\'\'),bestpostalcity(DEFAULT:Best_Postal_City_:\'\'),bestvanitycity(DEFAULT:Best_Vanity_City_:\'\'),beststate(DEFAULT:Best_State_:\'\'),bestzip5(DEFAULT:Best_Zip5_:0),bestzip4(DEFAULT:Best_Zip4_:0),bestaddressrank(DEFAULT:Best_Address_Rank_:0),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),datefirstseencompanyaddress(DEFAULT:Date_First_Seen_Company_Address_:DATE),datelastseencompanyaddress(DEFAULT:Date_Last_Seen_Company_Address_:DATE),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d15_Norm := NORMALIZE(__in,LEFT.Dataset_Gong__Key_History_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_Gong__Key_History_LinkIds),SELF:=RIGHT));
  EXPORT __d15_KELfiltered := __d15_Norm((STRING28)prim_name != '' AND (UNSIGNED3)z5 != 0 AND (UNSIGNED)seleid<>0);
  SHARED __d15_Legal__Layout := RECORD
    RECORDOF(__d15_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d15_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d15_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d15_Legal__Mapped := IF(__d15_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d15_KELfiltered,TRANSFORM(__d15_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d15_KELfiltered,__d15_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d15_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d15_Location__Layout := RECORD
    RECORDOF(__d15_Legal__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d15_Missing_Location__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d15_Legal__Mapped,'prim_range,predir,prim_name,suffix,postdir,z5,sec_range','__in');
  SHARED __d15_Location__Mapped := IF(__d15_Missing_Location__UIDComponents = 'prim_range,predir,prim_name,suffix,postdir,z5,sec_range',PROJECT(__d15_Legal__Mapped,TRANSFORM(__d15_Location__Layout,SELF.Location_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d15_Legal__Mapped,__d15_Missing_Location__UIDComponents),E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.z5) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d15_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d15_Prefiltered := __d15_Location__Mapped;
  SHARED __d15 := __SourceFilter(KEL.FromFlat.Convert(__d15_Prefiltered,InLayout,__Mapping15,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6 + __d7 + __d8 + __d9 + __d10 + __d11 + __d12 + __d13 + __d14 + __d15;
  EXPORT Address_Record_Type_Layout := RECORD
    KEL.typ.nstr Rec_Type_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Other_Location_Details_Layout := RECORD
    KEL.typ.nstr Unit_Designation_;
    KEL.typ.nstr Postal_City_;
    KEL.typ.nstr Vanity_City_;
    KEL.typ.nstr State_;
    KEL.typ.nint Z_I_P4_;
    KEL.typ.nint Metropolitan_Statistical_Area_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Address_Types_Layout := RECORD
    KEL.typ.nstr Company_Address_Type_Raw_;
    KEL.typ.nstr Company_Address_Type_Derived_;
    KEL.typ.nstr Address_Type_Derived_;
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
    KEL.typ.nint Best_Address_Rank_;
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
    KEL.typ.nkdate Date_First_Seen_Company_Address_;
    KEL.typ.nkdate Date_Last_Seen_Company_Address_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ndataset(Address_Record_Type_Layout) Address_Record_Type_;
    KEL.typ.ndataset(Other_Location_Details_Layout) Other_Location_Details_;
    KEL.typ.ndataset(Address_Types_Layout) Address_Types_;
    KEL.typ.ndataset(S_I_C_Codes_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(N_A_I_C_S_Codes_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(Best_Addresses_Layout) Best_Addresses_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Legal_,Location_,Primary_Range_,Predirectional_,Primary_Name_,Suffix_,Postdirectional_,Secondary_Range_,Z_I_P5_,ALL));
  Sele_Address_Group := __PostFilter;
  Layout Sele_Address__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Address_Record_Type_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Rec_Type_},Rec_Type_),Address_Record_Type_Layout)(__NN(Rec_Type_)));
    SELF.Other_Location_Details_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Unit_Designation_,Postal_City_,Vanity_City_,State_,Z_I_P4_,Metropolitan_Statistical_Area_},Unit_Designation_,Postal_City_,Vanity_City_,State_,Z_I_P4_,Metropolitan_Statistical_Area_),Other_Location_Details_Layout)(__NN(Unit_Designation_) OR __NN(Postal_City_) OR __NN(Vanity_City_) OR __NN(State_) OR __NN(Z_I_P4_) OR __NN(Metropolitan_Statistical_Area_)));
    SELF.Address_Types_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Company_Address_Type_Raw_,Company_Address_Type_Derived_,Address_Type_Derived_},Company_Address_Type_Raw_,Company_Address_Type_Derived_,Address_Type_Derived_),Address_Types_Layout)(__NN(Company_Address_Type_Raw_) OR __NN(Company_Address_Type_Derived_) OR __NN(Address_Type_Derived_)));
    SELF.S_I_C_Codes_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),S_I_C_Code_,Source_},S_I_C_Code_,Source_),S_I_C_Codes_Layout)(__NN(S_I_C_Code_) OR __NN(Source_)));
    SELF.N_A_I_C_S_Codes_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),N_A_I_C_S_Code_,Source_},N_A_I_C_S_Code_,Source_),N_A_I_C_S_Codes_Layout)(__NN(N_A_I_C_S_Code_) OR __NN(Source_)));
    SELF.Best_Addresses_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Best_Primary_Range_,Best_Predirectional_,Best_Primary_Name_,Best_Suffix_,Best_Postdirectional_,Best_Unit_Designation_,Best_Secondary_Range_,Best_Postal_City_,Best_Vanity_City_,Best_State_,Best_Zip5_,Best_Zip4_,Best_Address_Rank_},Best_Primary_Range_,Best_Predirectional_,Best_Primary_Name_,Best_Suffix_,Best_Postdirectional_,Best_Unit_Designation_,Best_Secondary_Range_,Best_Postal_City_,Best_Vanity_City_,Best_State_,Best_Zip5_,Best_Zip4_,Best_Address_Rank_),Best_Addresses_Layout)(__NN(Best_Primary_Range_) OR __NN(Best_Predirectional_) OR __NN(Best_Primary_Name_) OR __NN(Best_Suffix_) OR __NN(Best_Postdirectional_) OR __NN(Best_Unit_Designation_) OR __NN(Best_Secondary_Range_) OR __NN(Best_Postal_City_) OR __NN(Best_Vanity_City_) OR __NN(Best_State_) OR __NN(Best_Zip5_) OR __NN(Best_Zip4_) OR __NN(Best_Address_Rank_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Header_Hit_Flag_,Source_,Date_First_Seen_Company_Address_,Date_Last_Seen_Company_Address_},Header_Hit_Flag_,Source_,Date_First_Seen_Company_Address_,Date_Last_Seen_Company_Address_),Data_Sources_Layout)(__NN(Header_Hit_Flag_) OR __NN(Source_) OR __NN(Date_First_Seen_Company_Address_) OR __NN(Date_Last_Seen_Company_Address_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Sele_Address__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Address_Record_Type_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Address_Record_Type_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Rec_Type_)));
    SELF.Other_Location_Details_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Other_Location_Details_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Unit_Designation_) OR __NN(Postal_City_) OR __NN(Vanity_City_) OR __NN(State_) OR __NN(Z_I_P4_) OR __NN(Metropolitan_Statistical_Area_)));
    SELF.Address_Types_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Address_Types_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Company_Address_Type_Raw_) OR __NN(Company_Address_Type_Derived_) OR __NN(Address_Type_Derived_)));
    SELF.S_I_C_Codes_ := __CN(PROJECT(DATASET(__r),TRANSFORM(S_I_C_Codes_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(S_I_C_Code_) OR __NN(Source_)));
    SELF.N_A_I_C_S_Codes_ := __CN(PROJECT(DATASET(__r),TRANSFORM(N_A_I_C_S_Codes_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(N_A_I_C_S_Code_) OR __NN(Source_)));
    SELF.Best_Addresses_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Best_Addresses_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Best_Primary_Range_) OR __NN(Best_Predirectional_) OR __NN(Best_Primary_Name_) OR __NN(Best_Suffix_) OR __NN(Best_Postdirectional_) OR __NN(Best_Unit_Designation_) OR __NN(Best_Secondary_Range_) OR __NN(Best_Postal_City_) OR __NN(Best_Vanity_City_) OR __NN(Best_State_) OR __NN(Best_Zip5_) OR __NN(Best_Zip4_) OR __NN(Best_Address_Rank_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Header_Hit_Flag_) OR __NN(Source_) OR __NN(Date_First_Seen_Company_Address_) OR __NN(Date_Last_Seen_Company_Address_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Sele_Address_Group,COUNT(ROWS(LEFT))=1),GROUP,Sele_Address__Single_Rollup(LEFT)) + ROLLUP(HAVING(Sele_Address_Group,COUNT(ROWS(LEFT))>1),GROUP,Sele_Address__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Legal__Orphan := JOIN(InData(__NN(Legal_)),E_Business_Sele(__in,__cfg).__Result,__EEQP(LEFT.Legal_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Location__Orphan := JOIN(InData(__NN(Location_)),E_Address(__in,__cfg).__Result,__EEQP(LEFT.Location_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Z_I_P5__Orphan := JOIN(InData(__NN(Z_I_P5_)),E_Zip_Code(__in,__cfg).__Result,__EEQP(LEFT.Z_I_P5_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Best_Zip5__Orphan := JOIN(InData(__NN(Best_Zip5_)),E_Zip_Code(__in,__cfg).__Result,__EEQP(LEFT.Best_Zip5_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Legal__Orphan),COUNT(Location__Orphan),COUNT(Z_I_P5__Orphan),COUNT(Best_Zip5__Orphan)}],{KEL.typ.int Legal__Orphan,KEL.typ.int Location__Orphan,KEL.typ.int Z_I_P5__Orphan,KEL.typ.int Best_Zip5__Orphan});
  EXPORT NullCounts := DATASET([
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d0(__NL(Legal_))),COUNT(__d0(__NN(Legal_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d0(__NL(Location_))),COUNT(__d0(__NN(Location_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range_derived',COUNT(__d0(__NL(Primary_Range_))),COUNT(__d0(__NN(Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d0(__NL(Predirectional_))),COUNT(__d0(__NN(Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name_derived',COUNT(__d0(__NL(Primary_Name_))),COUNT(__d0(__NN(Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d0(__NL(Suffix_))),COUNT(__d0(__NN(Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d0(__NL(Postdirectional_))),COUNT(__d0(__NN(Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','unit_desig',COUNT(__d0(__NL(Unit_Designation_))),COUNT(__d0(__NN(Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d0(__NL(Secondary_Range_))),COUNT(__d0(__NN(Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','p_city_name',COUNT(__d0(__NL(Postal_City_))),COUNT(__d0(__NN(Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','v_city_name',COUNT(__d0(__NL(Vanity_City_))),COUNT(__d0(__NN(Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d0(__NL(State_))),COUNT(__d0(__NN(State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d0(__NL(Z_I_P5_))),COUNT(__d0(__NN(Z_I_P5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec_type',COUNT(__d0(__NL(Rec_Type_))),COUNT(__d0(__NN(Rec_Type_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip4',COUNT(__d0(__NL(Z_I_P4_))),COUNT(__d0(__NN(Z_I_P4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','msa',COUNT(__d0(__NL(Metropolitan_Statistical_Area_))),COUNT(__d0(__NN(Metropolitan_Statistical_Area_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code1',COUNT(__d0(__NL(S_I_C_Code_))),COUNT(__d0(__NN(S_I_C_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code1',COUNT(__d0(__NL(N_A_I_C_S_Code_))),COUNT(__d0(__NN(N_A_I_C_S_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d0(__NL(Best_Primary_Range_))),COUNT(__d0(__NN(Best_Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d0(__NL(Best_Predirectional_))),COUNT(__d0(__NN(Best_Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d0(__NL(Best_Primary_Name_))),COUNT(__d0(__NN(Best_Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d0(__NL(Best_Suffix_))),COUNT(__d0(__NN(Best_Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d0(__NL(Best_Postdirectional_))),COUNT(__d0(__NN(Best_Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d0(__NL(Best_Unit_Designation_))),COUNT(__d0(__NN(Best_Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d0(__NL(Best_Secondary_Range_))),COUNT(__d0(__NN(Best_Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d0(__NL(Best_Postal_City_))),COUNT(__d0(__NN(Best_Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d0(__NL(Best_Vanity_City_))),COUNT(__d0(__NN(Best_Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d0(__NL(Best_State_))),COUNT(__d0(__NN(Best_State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d0(__NL(Best_Zip5_))),COUNT(__d0(__NN(Best_Zip5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d0(__NL(Best_Zip4_))),COUNT(__d0(__NN(Best_Zip4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d0(__NL(Best_Address_Rank_))),COUNT(__d0(__NN(Best_Address_Rank_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_address_type_raw',COUNT(__d0(__NL(Company_Address_Type_Raw_))),COUNT(__d0(__NN(Company_Address_Type_Raw_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_address_type_derived',COUNT(__d0(__NL(Company_Address_Type_Derived_))),COUNT(__d0(__NN(Company_Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','address_type_derived',COUNT(__d0(__NL(Address_Type_Derived_))),COUNT(__d0(__NN(Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_first_seen_company_address',COUNT(__d0(__NL(Date_First_Seen_Company_Address_))),COUNT(__d0(__NN(Date_First_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_last_seen_company_address',COUNT(__d0(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d0(__NN(Date_Last_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d1(__NL(Legal_))),COUNT(__d1(__NN(Legal_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d1(__NL(Location_))),COUNT(__d1(__NN(Location_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range_derived',COUNT(__d1(__NL(Primary_Range_))),COUNT(__d1(__NN(Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d1(__NL(Predirectional_))),COUNT(__d1(__NN(Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name_derived',COUNT(__d1(__NL(Primary_Name_))),COUNT(__d1(__NN(Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d1(__NL(Suffix_))),COUNT(__d1(__NN(Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d1(__NL(Postdirectional_))),COUNT(__d1(__NN(Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UnitDesignation',COUNT(__d1(__NL(Unit_Designation_))),COUNT(__d1(__NN(Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d1(__NL(Secondary_Range_))),COUNT(__d1(__NN(Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PostalCity',COUNT(__d1(__NL(Postal_City_))),COUNT(__d1(__NN(Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VanityCity',COUNT(__d1(__NL(Vanity_City_))),COUNT(__d1(__NN(Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','State',COUNT(__d1(__NL(State_))),COUNT(__d1(__NN(State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d1(__NL(Z_I_P5_))),COUNT(__d1(__NN(Z_I_P5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecType',COUNT(__d1(__NL(Rec_Type_))),COUNT(__d1(__NN(Rec_Type_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZIP4',COUNT(__d1(__NL(Z_I_P4_))),COUNT(__d1(__NN(Z_I_P4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d1(__NL(Metropolitan_Statistical_Area_))),COUNT(__d1(__NN(Metropolitan_Statistical_Area_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code2',COUNT(__d1(__NL(S_I_C_Code_))),COUNT(__d1(__NN(S_I_C_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code2',COUNT(__d1(__NL(N_A_I_C_S_Code_))),COUNT(__d1(__NN(N_A_I_C_S_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d1(__NL(Best_Primary_Range_))),COUNT(__d1(__NN(Best_Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d1(__NL(Best_Predirectional_))),COUNT(__d1(__NN(Best_Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d1(__NL(Best_Primary_Name_))),COUNT(__d1(__NN(Best_Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d1(__NL(Best_Suffix_))),COUNT(__d1(__NN(Best_Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d1(__NL(Best_Postdirectional_))),COUNT(__d1(__NN(Best_Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d1(__NL(Best_Unit_Designation_))),COUNT(__d1(__NN(Best_Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d1(__NL(Best_Secondary_Range_))),COUNT(__d1(__NN(Best_Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d1(__NL(Best_Postal_City_))),COUNT(__d1(__NN(Best_Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d1(__NL(Best_Vanity_City_))),COUNT(__d1(__NN(Best_Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d1(__NL(Best_State_))),COUNT(__d1(__NN(Best_State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d1(__NL(Best_Zip5_))),COUNT(__d1(__NN(Best_Zip5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d1(__NL(Best_Zip4_))),COUNT(__d1(__NN(Best_Zip4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d1(__NL(Best_Address_Rank_))),COUNT(__d1(__NN(Best_Address_Rank_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d1(__NL(Company_Address_Type_Raw_))),COUNT(__d1(__NN(Company_Address_Type_Raw_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d1(__NL(Company_Address_Type_Derived_))),COUNT(__d1(__NN(Company_Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d1(__NL(Address_Type_Derived_))),COUNT(__d1(__NN(Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_first_seen_company_address',COUNT(__d1(__NL(Date_First_Seen_Company_Address_))),COUNT(__d1(__NN(Date_First_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_last_seen_company_address',COUNT(__d1(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d1(__NN(Date_Last_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d2(__NL(Legal_))),COUNT(__d2(__NN(Legal_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d2(__NL(Location_))),COUNT(__d2(__NN(Location_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range_derived',COUNT(__d2(__NL(Primary_Range_))),COUNT(__d2(__NN(Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d2(__NL(Predirectional_))),COUNT(__d2(__NN(Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name_derived',COUNT(__d2(__NL(Primary_Name_))),COUNT(__d2(__NN(Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d2(__NL(Suffix_))),COUNT(__d2(__NN(Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d2(__NL(Postdirectional_))),COUNT(__d2(__NN(Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UnitDesignation',COUNT(__d2(__NL(Unit_Designation_))),COUNT(__d2(__NN(Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d2(__NL(Secondary_Range_))),COUNT(__d2(__NN(Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PostalCity',COUNT(__d2(__NL(Postal_City_))),COUNT(__d2(__NN(Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VanityCity',COUNT(__d2(__NL(Vanity_City_))),COUNT(__d2(__NN(Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','State',COUNT(__d2(__NL(State_))),COUNT(__d2(__NN(State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d2(__NL(Z_I_P5_))),COUNT(__d2(__NN(Z_I_P5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecType',COUNT(__d2(__NL(Rec_Type_))),COUNT(__d2(__NN(Rec_Type_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZIP4',COUNT(__d2(__NL(Z_I_P4_))),COUNT(__d2(__NN(Z_I_P4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d2(__NL(Metropolitan_Statistical_Area_))),COUNT(__d2(__NN(Metropolitan_Statistical_Area_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code3',COUNT(__d2(__NL(S_I_C_Code_))),COUNT(__d2(__NN(S_I_C_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code3',COUNT(__d2(__NL(N_A_I_C_S_Code_))),COUNT(__d2(__NN(N_A_I_C_S_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d2(__NL(Best_Primary_Range_))),COUNT(__d2(__NN(Best_Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d2(__NL(Best_Predirectional_))),COUNT(__d2(__NN(Best_Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d2(__NL(Best_Primary_Name_))),COUNT(__d2(__NN(Best_Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d2(__NL(Best_Suffix_))),COUNT(__d2(__NN(Best_Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d2(__NL(Best_Postdirectional_))),COUNT(__d2(__NN(Best_Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d2(__NL(Best_Unit_Designation_))),COUNT(__d2(__NN(Best_Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d2(__NL(Best_Secondary_Range_))),COUNT(__d2(__NN(Best_Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d2(__NL(Best_Postal_City_))),COUNT(__d2(__NN(Best_Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d2(__NL(Best_Vanity_City_))),COUNT(__d2(__NN(Best_Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d2(__NL(Best_State_))),COUNT(__d2(__NN(Best_State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d2(__NL(Best_Zip5_))),COUNT(__d2(__NN(Best_Zip5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d2(__NL(Best_Zip4_))),COUNT(__d2(__NN(Best_Zip4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d2(__NL(Best_Address_Rank_))),COUNT(__d2(__NN(Best_Address_Rank_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d2(__NL(Company_Address_Type_Raw_))),COUNT(__d2(__NN(Company_Address_Type_Raw_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d2(__NL(Company_Address_Type_Derived_))),COUNT(__d2(__NN(Company_Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d2(__NL(Address_Type_Derived_))),COUNT(__d2(__NN(Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_first_seen_company_address',COUNT(__d2(__NL(Date_First_Seen_Company_Address_))),COUNT(__d2(__NN(Date_First_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_last_seen_company_address',COUNT(__d2(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d2(__NN(Date_Last_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d3(__NL(Legal_))),COUNT(__d3(__NN(Legal_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d3(__NL(Location_))),COUNT(__d3(__NN(Location_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range_derived',COUNT(__d3(__NL(Primary_Range_))),COUNT(__d3(__NN(Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d3(__NL(Predirectional_))),COUNT(__d3(__NN(Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name_derived',COUNT(__d3(__NL(Primary_Name_))),COUNT(__d3(__NN(Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d3(__NL(Suffix_))),COUNT(__d3(__NN(Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d3(__NL(Postdirectional_))),COUNT(__d3(__NN(Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UnitDesignation',COUNT(__d3(__NL(Unit_Designation_))),COUNT(__d3(__NN(Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d3(__NL(Secondary_Range_))),COUNT(__d3(__NN(Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PostalCity',COUNT(__d3(__NL(Postal_City_))),COUNT(__d3(__NN(Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VanityCity',COUNT(__d3(__NL(Vanity_City_))),COUNT(__d3(__NN(Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','State',COUNT(__d3(__NL(State_))),COUNT(__d3(__NN(State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d3(__NL(Z_I_P5_))),COUNT(__d3(__NN(Z_I_P5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecType',COUNT(__d3(__NL(Rec_Type_))),COUNT(__d3(__NN(Rec_Type_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZIP4',COUNT(__d3(__NL(Z_I_P4_))),COUNT(__d3(__NN(Z_I_P4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d3(__NL(Metropolitan_Statistical_Area_))),COUNT(__d3(__NN(Metropolitan_Statistical_Area_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code4',COUNT(__d3(__NL(S_I_C_Code_))),COUNT(__d3(__NN(S_I_C_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code4',COUNT(__d3(__NL(N_A_I_C_S_Code_))),COUNT(__d3(__NN(N_A_I_C_S_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d3(__NL(Best_Primary_Range_))),COUNT(__d3(__NN(Best_Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d3(__NL(Best_Predirectional_))),COUNT(__d3(__NN(Best_Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d3(__NL(Best_Primary_Name_))),COUNT(__d3(__NN(Best_Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d3(__NL(Best_Suffix_))),COUNT(__d3(__NN(Best_Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d3(__NL(Best_Postdirectional_))),COUNT(__d3(__NN(Best_Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d3(__NL(Best_Unit_Designation_))),COUNT(__d3(__NN(Best_Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d3(__NL(Best_Secondary_Range_))),COUNT(__d3(__NN(Best_Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d3(__NL(Best_Postal_City_))),COUNT(__d3(__NN(Best_Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d3(__NL(Best_Vanity_City_))),COUNT(__d3(__NN(Best_Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d3(__NL(Best_State_))),COUNT(__d3(__NN(Best_State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d3(__NL(Best_Zip5_))),COUNT(__d3(__NN(Best_Zip5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d3(__NL(Best_Zip4_))),COUNT(__d3(__NN(Best_Zip4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d3(__NL(Best_Address_Rank_))),COUNT(__d3(__NN(Best_Address_Rank_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d3(__NL(Company_Address_Type_Raw_))),COUNT(__d3(__NN(Company_Address_Type_Raw_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d3(__NL(Company_Address_Type_Derived_))),COUNT(__d3(__NN(Company_Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d3(__NL(Address_Type_Derived_))),COUNT(__d3(__NN(Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_first_seen_company_address',COUNT(__d3(__NL(Date_First_Seen_Company_Address_))),COUNT(__d3(__NN(Date_First_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_last_seen_company_address',COUNT(__d3(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d3(__NN(Date_Last_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d3(Hybrid_Archive_Date_=0)),COUNT(__d3(Hybrid_Archive_Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d3(Vault_Date_Last_Seen_=0)),COUNT(__d3(Vault_Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d4(__NL(Legal_))),COUNT(__d4(__NN(Legal_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d4(__NL(Location_))),COUNT(__d4(__NN(Location_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range_derived',COUNT(__d4(__NL(Primary_Range_))),COUNT(__d4(__NN(Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d4(__NL(Predirectional_))),COUNT(__d4(__NN(Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name_derived',COUNT(__d4(__NL(Primary_Name_))),COUNT(__d4(__NN(Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d4(__NL(Suffix_))),COUNT(__d4(__NN(Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d4(__NL(Postdirectional_))),COUNT(__d4(__NN(Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UnitDesignation',COUNT(__d4(__NL(Unit_Designation_))),COUNT(__d4(__NN(Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d4(__NL(Secondary_Range_))),COUNT(__d4(__NN(Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PostalCity',COUNT(__d4(__NL(Postal_City_))),COUNT(__d4(__NN(Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VanityCity',COUNT(__d4(__NL(Vanity_City_))),COUNT(__d4(__NN(Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','State',COUNT(__d4(__NL(State_))),COUNT(__d4(__NN(State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d4(__NL(Z_I_P5_))),COUNT(__d4(__NN(Z_I_P5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecType',COUNT(__d4(__NL(Rec_Type_))),COUNT(__d4(__NN(Rec_Type_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZIP4',COUNT(__d4(__NL(Z_I_P4_))),COUNT(__d4(__NN(Z_I_P4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d4(__NL(Metropolitan_Statistical_Area_))),COUNT(__d4(__NN(Metropolitan_Statistical_Area_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_sic_code5',COUNT(__d4(__NL(S_I_C_Code_))),COUNT(__d4(__NN(S_I_C_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_naics_code5',COUNT(__d4(__NL(N_A_I_C_S_Code_))),COUNT(__d4(__NN(N_A_I_C_S_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d4(__NL(Best_Primary_Range_))),COUNT(__d4(__NN(Best_Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d4(__NL(Best_Predirectional_))),COUNT(__d4(__NN(Best_Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d4(__NL(Best_Primary_Name_))),COUNT(__d4(__NN(Best_Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d4(__NL(Best_Suffix_))),COUNT(__d4(__NN(Best_Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d4(__NL(Best_Postdirectional_))),COUNT(__d4(__NN(Best_Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d4(__NL(Best_Unit_Designation_))),COUNT(__d4(__NN(Best_Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d4(__NL(Best_Secondary_Range_))),COUNT(__d4(__NN(Best_Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d4(__NL(Best_Postal_City_))),COUNT(__d4(__NN(Best_Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d4(__NL(Best_Vanity_City_))),COUNT(__d4(__NN(Best_Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d4(__NL(Best_State_))),COUNT(__d4(__NN(Best_State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d4(__NL(Best_Zip5_))),COUNT(__d4(__NN(Best_Zip5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d4(__NL(Best_Zip4_))),COUNT(__d4(__NN(Best_Zip4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d4(__NL(Best_Address_Rank_))),COUNT(__d4(__NN(Best_Address_Rank_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d4(__NL(Company_Address_Type_Raw_))),COUNT(__d4(__NN(Company_Address_Type_Raw_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d4(__NL(Company_Address_Type_Derived_))),COUNT(__d4(__NN(Company_Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d4(__NL(Address_Type_Derived_))),COUNT(__d4(__NN(Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_first_seen_company_address',COUNT(__d4(__NL(Date_First_Seen_Company_Address_))),COUNT(__d4(__NN(Date_First_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_last_seen_company_address',COUNT(__d4(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d4(__NN(Date_Last_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d4(Archive___Date_=0)),COUNT(__d4(Archive___Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d4(Hybrid_Archive_Date_=0)),COUNT(__d4(Hybrid_Archive_Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d4(Vault_Date_Last_Seen_=0)),COUNT(__d4(Vault_Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d5(__NL(Legal_))),COUNT(__d5(__NN(Legal_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d5(__NL(Location_))),COUNT(__d5(__NN(Location_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_prim_range',COUNT(__d5(__NL(Primary_Range_))),COUNT(__d5(__NN(Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_predir',COUNT(__d5(__NL(Predirectional_))),COUNT(__d5(__NN(Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_prim_name',COUNT(__d5(__NL(Primary_Name_))),COUNT(__d5(__NN(Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_addr_suffix',COUNT(__d5(__NL(Suffix_))),COUNT(__d5(__NN(Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_postdir',COUNT(__d5(__NL(Postdirectional_))),COUNT(__d5(__NN(Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UnitDesignation',COUNT(__d5(__NL(Unit_Designation_))),COUNT(__d5(__NN(Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_sec_range',COUNT(__d5(__NL(Secondary_Range_))),COUNT(__d5(__NN(Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PostalCity',COUNT(__d5(__NL(Postal_City_))),COUNT(__d5(__NN(Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VanityCity',COUNT(__d5(__NL(Vanity_City_))),COUNT(__d5(__NN(Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','State',COUNT(__d5(__NL(State_))),COUNT(__d5(__NN(State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_zip5',COUNT(__d5(__NL(Z_I_P5_))),COUNT(__d5(__NN(Z_I_P5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecType',COUNT(__d5(__NL(Rec_Type_))),COUNT(__d5(__NN(Rec_Type_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZIP4',COUNT(__d5(__NL(Z_I_P4_))),COUNT(__d5(__NN(Z_I_P4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d5(__NL(Metropolitan_Statistical_Area_))),COUNT(__d5(__NN(Metropolitan_Statistical_Area_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_sic_code',COUNT(__d5(__NL(S_I_C_Code_))),COUNT(__d5(__NN(S_I_C_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_naic_code',COUNT(__d5(__NL(N_A_I_C_S_Code_))),COUNT(__d5(__NN(N_A_I_C_S_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d5(__NL(Best_Primary_Range_))),COUNT(__d5(__NN(Best_Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d5(__NL(Best_Predirectional_))),COUNT(__d5(__NN(Best_Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d5(__NL(Best_Primary_Name_))),COUNT(__d5(__NN(Best_Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d5(__NL(Best_Suffix_))),COUNT(__d5(__NN(Best_Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d5(__NL(Best_Postdirectional_))),COUNT(__d5(__NN(Best_Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d5(__NL(Best_Unit_Designation_))),COUNT(__d5(__NN(Best_Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d5(__NL(Best_Secondary_Range_))),COUNT(__d5(__NN(Best_Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d5(__NL(Best_Postal_City_))),COUNT(__d5(__NN(Best_Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d5(__NL(Best_Vanity_City_))),COUNT(__d5(__NN(Best_Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d5(__NL(Best_State_))),COUNT(__d5(__NN(Best_State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d5(__NL(Best_Zip5_))),COUNT(__d5(__NN(Best_Zip5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d5(__NL(Best_Zip4_))),COUNT(__d5(__NN(Best_Zip4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d5(__NL(Best_Address_Rank_))),COUNT(__d5(__NN(Best_Address_Rank_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d5(__NL(Company_Address_Type_Raw_))),COUNT(__d5(__NN(Company_Address_Type_Raw_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d5(__NL(Company_Address_Type_Derived_))),COUNT(__d5(__NN(Company_Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d5(__NL(Address_Type_Derived_))),COUNT(__d5(__NN(Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeenCompanyAddress',COUNT(__d5(__NL(Date_First_Seen_Company_Address_))),COUNT(__d5(__NN(Date_First_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenCompanyAddress',COUNT(__d5(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d5(__NN(Date_Last_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d5(__NL(Header_Hit_Flag_))),COUNT(__d5(__NN(Header_Hit_Flag_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d5(Archive___Date_=0)),COUNT(__d5(Archive___Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d5(Hybrid_Archive_Date_=0)),COUNT(__d5(Hybrid_Archive_Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d5(Vault_Date_Last_Seen_=0)),COUNT(__d5(Vault_Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d6(__NL(Legal_))),COUNT(__d6(__NN(Legal_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d6(__NL(Location_))),COUNT(__d6(__NN(Location_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_prim_range',COUNT(__d6(__NL(Primary_Range_))),COUNT(__d6(__NN(Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_predir',COUNT(__d6(__NL(Predirectional_))),COUNT(__d6(__NN(Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_prim_name',COUNT(__d6(__NL(Primary_Name_))),COUNT(__d6(__NN(Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_addr_suffix',COUNT(__d6(__NL(Suffix_))),COUNT(__d6(__NN(Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_postdir',COUNT(__d6(__NL(Postdirectional_))),COUNT(__d6(__NN(Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UnitDesignation',COUNT(__d6(__NL(Unit_Designation_))),COUNT(__d6(__NN(Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_sec_range',COUNT(__d6(__NL(Secondary_Range_))),COUNT(__d6(__NN(Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PostalCity',COUNT(__d6(__NL(Postal_City_))),COUNT(__d6(__NN(Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VanityCity',COUNT(__d6(__NL(Vanity_City_))),COUNT(__d6(__NN(Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','State',COUNT(__d6(__NL(State_))),COUNT(__d6(__NN(State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_zip5',COUNT(__d6(__NL(Z_I_P5_))),COUNT(__d6(__NN(Z_I_P5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecType',COUNT(__d6(__NL(Rec_Type_))),COUNT(__d6(__NN(Rec_Type_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZIP4',COUNT(__d6(__NL(Z_I_P4_))),COUNT(__d6(__NN(Z_I_P4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d6(__NL(Metropolitan_Statistical_Area_))),COUNT(__d6(__NN(Metropolitan_Statistical_Area_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_sic_code',COUNT(__d6(__NL(S_I_C_Code_))),COUNT(__d6(__NN(S_I_C_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_naic_code',COUNT(__d6(__NL(N_A_I_C_S_Code_))),COUNT(__d6(__NN(N_A_I_C_S_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d6(__NL(Best_Primary_Range_))),COUNT(__d6(__NN(Best_Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d6(__NL(Best_Predirectional_))),COUNT(__d6(__NN(Best_Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d6(__NL(Best_Primary_Name_))),COUNT(__d6(__NN(Best_Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d6(__NL(Best_Suffix_))),COUNT(__d6(__NN(Best_Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d6(__NL(Best_Postdirectional_))),COUNT(__d6(__NN(Best_Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d6(__NL(Best_Unit_Designation_))),COUNT(__d6(__NN(Best_Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d6(__NL(Best_Secondary_Range_))),COUNT(__d6(__NN(Best_Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d6(__NL(Best_Postal_City_))),COUNT(__d6(__NN(Best_Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d6(__NL(Best_Vanity_City_))),COUNT(__d6(__NN(Best_Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d6(__NL(Best_State_))),COUNT(__d6(__NN(Best_State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d6(__NL(Best_Zip5_))),COUNT(__d6(__NN(Best_Zip5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d6(__NL(Best_Zip4_))),COUNT(__d6(__NN(Best_Zip4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d6(__NL(Best_Address_Rank_))),COUNT(__d6(__NN(Best_Address_Rank_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d6(__NL(Company_Address_Type_Raw_))),COUNT(__d6(__NN(Company_Address_Type_Raw_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d6(__NL(Company_Address_Type_Derived_))),COUNT(__d6(__NN(Company_Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d6(__NL(Address_Type_Derived_))),COUNT(__d6(__NN(Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeenCompanyAddress',COUNT(__d6(__NL(Date_First_Seen_Company_Address_))),COUNT(__d6(__NN(Date_First_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenCompanyAddress',COUNT(__d6(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d6(__NN(Date_Last_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d6(__NL(Header_Hit_Flag_))),COUNT(__d6(__NN(Header_Hit_Flag_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d6(__NL(Source_))),COUNT(__d6(__NN(Source_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d6(Archive___Date_=0)),COUNT(__d6(Archive___Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d6(Hybrid_Archive_Date_=0)),COUNT(__d6(Hybrid_Archive_Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d6(Vault_Date_Last_Seen_=0)),COUNT(__d6(Vault_Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d7(__NL(Legal_))),COUNT(__d7(__NN(Legal_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d7(__NL(Location_))),COUNT(__d7(__NN(Location_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_prim_range',COUNT(__d7(__NL(Primary_Range_))),COUNT(__d7(__NN(Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_predir',COUNT(__d7(__NL(Predirectional_))),COUNT(__d7(__NN(Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_prim_name',COUNT(__d7(__NL(Primary_Name_))),COUNT(__d7(__NN(Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_addr_suffix',COUNT(__d7(__NL(Suffix_))),COUNT(__d7(__NN(Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_postdir',COUNT(__d7(__NL(Postdirectional_))),COUNT(__d7(__NN(Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UnitDesignation',COUNT(__d7(__NL(Unit_Designation_))),COUNT(__d7(__NN(Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_sec_range',COUNT(__d7(__NL(Secondary_Range_))),COUNT(__d7(__NN(Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PostalCity',COUNT(__d7(__NL(Postal_City_))),COUNT(__d7(__NN(Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VanityCity',COUNT(__d7(__NL(Vanity_City_))),COUNT(__d7(__NN(Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','State',COUNT(__d7(__NL(State_))),COUNT(__d7(__NN(State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_zip5',COUNT(__d7(__NL(Z_I_P5_))),COUNT(__d7(__NN(Z_I_P5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecType',COUNT(__d7(__NL(Rec_Type_))),COUNT(__d7(__NN(Rec_Type_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZIP4',COUNT(__d7(__NL(Z_I_P4_))),COUNT(__d7(__NN(Z_I_P4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d7(__NL(Metropolitan_Statistical_Area_))),COUNT(__d7(__NN(Metropolitan_Statistical_Area_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_sic_code',COUNT(__d7(__NL(S_I_C_Code_))),COUNT(__d7(__NN(S_I_C_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_naic_code',COUNT(__d7(__NL(N_A_I_C_S_Code_))),COUNT(__d7(__NN(N_A_I_C_S_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d7(__NL(Best_Primary_Range_))),COUNT(__d7(__NN(Best_Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d7(__NL(Best_Predirectional_))),COUNT(__d7(__NN(Best_Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d7(__NL(Best_Primary_Name_))),COUNT(__d7(__NN(Best_Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d7(__NL(Best_Suffix_))),COUNT(__d7(__NN(Best_Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d7(__NL(Best_Postdirectional_))),COUNT(__d7(__NN(Best_Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d7(__NL(Best_Unit_Designation_))),COUNT(__d7(__NN(Best_Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d7(__NL(Best_Secondary_Range_))),COUNT(__d7(__NN(Best_Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d7(__NL(Best_Postal_City_))),COUNT(__d7(__NN(Best_Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d7(__NL(Best_Vanity_City_))),COUNT(__d7(__NN(Best_Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d7(__NL(Best_State_))),COUNT(__d7(__NN(Best_State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d7(__NL(Best_Zip5_))),COUNT(__d7(__NN(Best_Zip5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d7(__NL(Best_Zip4_))),COUNT(__d7(__NN(Best_Zip4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d7(__NL(Best_Address_Rank_))),COUNT(__d7(__NN(Best_Address_Rank_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d7(__NL(Company_Address_Type_Raw_))),COUNT(__d7(__NN(Company_Address_Type_Raw_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d7(__NL(Company_Address_Type_Derived_))),COUNT(__d7(__NN(Company_Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d7(__NL(Address_Type_Derived_))),COUNT(__d7(__NN(Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeenCompanyAddress',COUNT(__d7(__NL(Date_First_Seen_Company_Address_))),COUNT(__d7(__NN(Date_First_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenCompanyAddress',COUNT(__d7(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d7(__NN(Date_Last_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d7(__NL(Header_Hit_Flag_))),COUNT(__d7(__NN(Header_Hit_Flag_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d7(__NL(Source_))),COUNT(__d7(__NN(Source_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d7(Archive___Date_=0)),COUNT(__d7(Archive___Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d7(Date_First_Seen_=0)),COUNT(__d7(Date_First_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d7(Date_Last_Seen_=0)),COUNT(__d7(Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d7(Hybrid_Archive_Date_=0)),COUNT(__d7(Hybrid_Archive_Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d7(Vault_Date_Last_Seen_=0)),COUNT(__d7(Vault_Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d8(__NL(Legal_))),COUNT(__d8(__NN(Legal_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d8(__NL(Location_))),COUNT(__d8(__NN(Location_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d8(__NL(Primary_Range_))),COUNT(__d8(__NN(Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d8(__NL(Predirectional_))),COUNT(__d8(__NN(Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d8(__NL(Primary_Name_))),COUNT(__d8(__NN(Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d8(__NL(Suffix_))),COUNT(__d8(__NN(Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d8(__NL(Postdirectional_))),COUNT(__d8(__NN(Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UnitDesignation',COUNT(__d8(__NL(Unit_Designation_))),COUNT(__d8(__NN(Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d8(__NL(Secondary_Range_))),COUNT(__d8(__NN(Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PostalCity',COUNT(__d8(__NL(Postal_City_))),COUNT(__d8(__NN(Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VanityCity',COUNT(__d8(__NL(Vanity_City_))),COUNT(__d8(__NN(Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','State',COUNT(__d8(__NL(State_))),COUNT(__d8(__NN(State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d8(__NL(Z_I_P5_))),COUNT(__d8(__NN(Z_I_P5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecType',COUNT(__d8(__NL(Rec_Type_))),COUNT(__d8(__NN(Rec_Type_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZIP4',COUNT(__d8(__NL(Z_I_P4_))),COUNT(__d8(__NN(Z_I_P4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d8(__NL(Metropolitan_Statistical_Area_))),COUNT(__d8(__NN(Metropolitan_Statistical_Area_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sic_code',COUNT(__d8(__NL(S_I_C_Code_))),COUNT(__d8(__NN(S_I_C_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','naics_code',COUNT(__d8(__NL(N_A_I_C_S_Code_))),COUNT(__d8(__NN(N_A_I_C_S_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d8(__NL(Best_Primary_Range_))),COUNT(__d8(__NN(Best_Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d8(__NL(Best_Predirectional_))),COUNT(__d8(__NN(Best_Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d8(__NL(Best_Primary_Name_))),COUNT(__d8(__NN(Best_Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d8(__NL(Best_Suffix_))),COUNT(__d8(__NN(Best_Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d8(__NL(Best_Postdirectional_))),COUNT(__d8(__NN(Best_Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d8(__NL(Best_Unit_Designation_))),COUNT(__d8(__NN(Best_Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d8(__NL(Best_Secondary_Range_))),COUNT(__d8(__NN(Best_Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d8(__NL(Best_Postal_City_))),COUNT(__d8(__NN(Best_Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d8(__NL(Best_Vanity_City_))),COUNT(__d8(__NN(Best_Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d8(__NL(Best_State_))),COUNT(__d8(__NN(Best_State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d8(__NL(Best_Zip5_))),COUNT(__d8(__NN(Best_Zip5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d8(__NL(Best_Zip4_))),COUNT(__d8(__NN(Best_Zip4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d8(__NL(Best_Address_Rank_))),COUNT(__d8(__NN(Best_Address_Rank_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d8(__NL(Company_Address_Type_Raw_))),COUNT(__d8(__NN(Company_Address_Type_Raw_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d8(__NL(Company_Address_Type_Derived_))),COUNT(__d8(__NN(Company_Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d8(__NL(Address_Type_Derived_))),COUNT(__d8(__NN(Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeenCompanyAddress',COUNT(__d8(__NL(Date_First_Seen_Company_Address_))),COUNT(__d8(__NN(Date_First_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenCompanyAddress',COUNT(__d8(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d8(__NN(Date_Last_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d8(__NL(Header_Hit_Flag_))),COUNT(__d8(__NN(Header_Hit_Flag_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d8(__NL(Source_))),COUNT(__d8(__NN(Source_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d8(Archive___Date_=0)),COUNT(__d8(Archive___Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d8(Date_First_Seen_=0)),COUNT(__d8(Date_First_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d8(Date_Last_Seen_=0)),COUNT(__d8(Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d8(Hybrid_Archive_Date_=0)),COUNT(__d8(Hybrid_Archive_Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d8(Vault_Date_Last_Seen_=0)),COUNT(__d8(Vault_Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d9(__NL(Legal_))),COUNT(__d9(__NN(Legal_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d9(__NL(Location_))),COUNT(__d9(__NN(Location_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d9(__NL(Primary_Range_))),COUNT(__d9(__NN(Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d9(__NL(Predirectional_))),COUNT(__d9(__NN(Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d9(__NL(Primary_Name_))),COUNT(__d9(__NN(Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d9(__NL(Suffix_))),COUNT(__d9(__NN(Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d9(__NL(Postdirectional_))),COUNT(__d9(__NN(Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UnitDesignation',COUNT(__d9(__NL(Unit_Designation_))),COUNT(__d9(__NN(Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d9(__NL(Secondary_Range_))),COUNT(__d9(__NN(Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PostalCity',COUNT(__d9(__NL(Postal_City_))),COUNT(__d9(__NN(Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VanityCity',COUNT(__d9(__NL(Vanity_City_))),COUNT(__d9(__NN(Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','State',COUNT(__d9(__NL(State_))),COUNT(__d9(__NN(State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d9(__NL(Z_I_P5_))),COUNT(__d9(__NN(Z_I_P5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecType',COUNT(__d9(__NL(Rec_Type_))),COUNT(__d9(__NN(Rec_Type_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZIP4',COUNT(__d9(__NL(Z_I_P4_))),COUNT(__d9(__NN(Z_I_P4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d9(__NL(Metropolitan_Statistical_Area_))),COUNT(__d9(__NN(Metropolitan_Statistical_Area_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_primsic',COUNT(__d9(__NL(S_I_C_Code_))),COUNT(__d9(__NN(S_I_C_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_primnaicscode',COUNT(__d9(__NL(N_A_I_C_S_Code_))),COUNT(__d9(__NN(N_A_I_C_S_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d9(__NL(Best_Primary_Range_))),COUNT(__d9(__NN(Best_Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d9(__NL(Best_Predirectional_))),COUNT(__d9(__NN(Best_Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d9(__NL(Best_Primary_Name_))),COUNT(__d9(__NN(Best_Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d9(__NL(Best_Suffix_))),COUNT(__d9(__NN(Best_Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d9(__NL(Best_Postdirectional_))),COUNT(__d9(__NN(Best_Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d9(__NL(Best_Unit_Designation_))),COUNT(__d9(__NN(Best_Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d9(__NL(Best_Secondary_Range_))),COUNT(__d9(__NN(Best_Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d9(__NL(Best_Postal_City_))),COUNT(__d9(__NN(Best_Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d9(__NL(Best_Vanity_City_))),COUNT(__d9(__NN(Best_Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d9(__NL(Best_State_))),COUNT(__d9(__NN(Best_State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d9(__NL(Best_Zip5_))),COUNT(__d9(__NN(Best_Zip5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d9(__NL(Best_Zip4_))),COUNT(__d9(__NN(Best_Zip4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d9(__NL(Best_Address_Rank_))),COUNT(__d9(__NN(Best_Address_Rank_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d9(__NL(Company_Address_Type_Raw_))),COUNT(__d9(__NN(Company_Address_Type_Raw_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d9(__NL(Company_Address_Type_Derived_))),COUNT(__d9(__NN(Company_Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d9(__NL(Address_Type_Derived_))),COUNT(__d9(__NN(Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeenCompanyAddress',COUNT(__d9(__NL(Date_First_Seen_Company_Address_))),COUNT(__d9(__NN(Date_First_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenCompanyAddress',COUNT(__d9(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d9(__NN(Date_Last_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d9(__NL(Header_Hit_Flag_))),COUNT(__d9(__NN(Header_Hit_Flag_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d9(__NL(Source_))),COUNT(__d9(__NN(Source_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d9(Archive___Date_=0)),COUNT(__d9(Archive___Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d9(Date_First_Seen_=0)),COUNT(__d9(Date_First_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d9(Date_Last_Seen_=0)),COUNT(__d9(Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d9(Hybrid_Archive_Date_=0)),COUNT(__d9(Hybrid_Archive_Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d9(Vault_Date_Last_Seen_=0)),COUNT(__d9(Vault_Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d10(__NL(Legal_))),COUNT(__d10(__NN(Legal_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d10(__NL(Location_))),COUNT(__d10(__NN(Location_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d10(__NL(Primary_Range_))),COUNT(__d10(__NN(Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d10(__NL(Predirectional_))),COUNT(__d10(__NN(Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d10(__NL(Primary_Name_))),COUNT(__d10(__NN(Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d10(__NL(Suffix_))),COUNT(__d10(__NN(Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d10(__NL(Postdirectional_))),COUNT(__d10(__NN(Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UnitDesignation',COUNT(__d10(__NL(Unit_Designation_))),COUNT(__d10(__NN(Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d10(__NL(Secondary_Range_))),COUNT(__d10(__NN(Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PostalCity',COUNT(__d10(__NL(Postal_City_))),COUNT(__d10(__NN(Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VanityCity',COUNT(__d10(__NL(Vanity_City_))),COUNT(__d10(__NN(Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','State',COUNT(__d10(__NL(State_))),COUNT(__d10(__NN(State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d10(__NL(Z_I_P5_))),COUNT(__d10(__NN(Z_I_P5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecType',COUNT(__d10(__NL(Rec_Type_))),COUNT(__d10(__NN(Rec_Type_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZIP4',COUNT(__d10(__NL(Z_I_P4_))),COUNT(__d10(__NN(Z_I_P4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d10(__NL(Metropolitan_Statistical_Area_))),COUNT(__d10(__NN(Metropolitan_Statistical_Area_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_secsic1',COUNT(__d10(__NL(S_I_C_Code_))),COUNT(__d10(__NN(S_I_C_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_secnaics1',COUNT(__d10(__NL(N_A_I_C_S_Code_))),COUNT(__d10(__NN(N_A_I_C_S_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d10(__NL(Best_Primary_Range_))),COUNT(__d10(__NN(Best_Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d10(__NL(Best_Predirectional_))),COUNT(__d10(__NN(Best_Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d10(__NL(Best_Primary_Name_))),COUNT(__d10(__NN(Best_Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d10(__NL(Best_Suffix_))),COUNT(__d10(__NN(Best_Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d10(__NL(Best_Postdirectional_))),COUNT(__d10(__NN(Best_Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d10(__NL(Best_Unit_Designation_))),COUNT(__d10(__NN(Best_Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d10(__NL(Best_Secondary_Range_))),COUNT(__d10(__NN(Best_Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d10(__NL(Best_Postal_City_))),COUNT(__d10(__NN(Best_Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d10(__NL(Best_Vanity_City_))),COUNT(__d10(__NN(Best_Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d10(__NL(Best_State_))),COUNT(__d10(__NN(Best_State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d10(__NL(Best_Zip5_))),COUNT(__d10(__NN(Best_Zip5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d10(__NL(Best_Zip4_))),COUNT(__d10(__NN(Best_Zip4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d10(__NL(Best_Address_Rank_))),COUNT(__d10(__NN(Best_Address_Rank_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d10(__NL(Company_Address_Type_Raw_))),COUNT(__d10(__NN(Company_Address_Type_Raw_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d10(__NL(Company_Address_Type_Derived_))),COUNT(__d10(__NN(Company_Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d10(__NL(Address_Type_Derived_))),COUNT(__d10(__NN(Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeenCompanyAddress',COUNT(__d10(__NL(Date_First_Seen_Company_Address_))),COUNT(__d10(__NN(Date_First_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenCompanyAddress',COUNT(__d10(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d10(__NN(Date_Last_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d10(__NL(Header_Hit_Flag_))),COUNT(__d10(__NN(Header_Hit_Flag_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d10(__NL(Source_))),COUNT(__d10(__NN(Source_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d10(Archive___Date_=0)),COUNT(__d10(Archive___Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d10(Date_First_Seen_=0)),COUNT(__d10(Date_First_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d10(Date_Last_Seen_=0)),COUNT(__d10(Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d10(Hybrid_Archive_Date_=0)),COUNT(__d10(Hybrid_Archive_Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d10(Vault_Date_Last_Seen_=0)),COUNT(__d10(Vault_Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d11(__NL(Legal_))),COUNT(__d11(__NN(Legal_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d11(__NL(Location_))),COUNT(__d11(__NN(Location_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d11(__NL(Primary_Range_))),COUNT(__d11(__NN(Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d11(__NL(Predirectional_))),COUNT(__d11(__NN(Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d11(__NL(Primary_Name_))),COUNT(__d11(__NN(Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d11(__NL(Suffix_))),COUNT(__d11(__NN(Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d11(__NL(Postdirectional_))),COUNT(__d11(__NN(Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UnitDesignation',COUNT(__d11(__NL(Unit_Designation_))),COUNT(__d11(__NN(Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d11(__NL(Secondary_Range_))),COUNT(__d11(__NN(Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PostalCity',COUNT(__d11(__NL(Postal_City_))),COUNT(__d11(__NN(Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VanityCity',COUNT(__d11(__NL(Vanity_City_))),COUNT(__d11(__NN(Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','State',COUNT(__d11(__NL(State_))),COUNT(__d11(__NN(State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d11(__NL(Z_I_P5_))),COUNT(__d11(__NN(Z_I_P5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecType',COUNT(__d11(__NL(Rec_Type_))),COUNT(__d11(__NN(Rec_Type_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZIP4',COUNT(__d11(__NL(Z_I_P4_))),COUNT(__d11(__NN(Z_I_P4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d11(__NL(Metropolitan_Statistical_Area_))),COUNT(__d11(__NN(Metropolitan_Statistical_Area_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_secsic2',COUNT(__d11(__NL(S_I_C_Code_))),COUNT(__d11(__NN(S_I_C_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_secnaics2',COUNT(__d11(__NL(N_A_I_C_S_Code_))),COUNT(__d11(__NN(N_A_I_C_S_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d11(__NL(Best_Primary_Range_))),COUNT(__d11(__NN(Best_Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d11(__NL(Best_Predirectional_))),COUNT(__d11(__NN(Best_Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d11(__NL(Best_Primary_Name_))),COUNT(__d11(__NN(Best_Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d11(__NL(Best_Suffix_))),COUNT(__d11(__NN(Best_Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d11(__NL(Best_Postdirectional_))),COUNT(__d11(__NN(Best_Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d11(__NL(Best_Unit_Designation_))),COUNT(__d11(__NN(Best_Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d11(__NL(Best_Secondary_Range_))),COUNT(__d11(__NN(Best_Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d11(__NL(Best_Postal_City_))),COUNT(__d11(__NN(Best_Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d11(__NL(Best_Vanity_City_))),COUNT(__d11(__NN(Best_Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d11(__NL(Best_State_))),COUNT(__d11(__NN(Best_State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d11(__NL(Best_Zip5_))),COUNT(__d11(__NN(Best_Zip5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d11(__NL(Best_Zip4_))),COUNT(__d11(__NN(Best_Zip4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d11(__NL(Best_Address_Rank_))),COUNT(__d11(__NN(Best_Address_Rank_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d11(__NL(Company_Address_Type_Raw_))),COUNT(__d11(__NN(Company_Address_Type_Raw_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d11(__NL(Company_Address_Type_Derived_))),COUNT(__d11(__NN(Company_Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d11(__NL(Address_Type_Derived_))),COUNT(__d11(__NN(Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeenCompanyAddress',COUNT(__d11(__NL(Date_First_Seen_Company_Address_))),COUNT(__d11(__NN(Date_First_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenCompanyAddress',COUNT(__d11(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d11(__NN(Date_Last_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d11(__NL(Header_Hit_Flag_))),COUNT(__d11(__NN(Header_Hit_Flag_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d11(__NL(Source_))),COUNT(__d11(__NN(Source_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d11(Archive___Date_=0)),COUNT(__d11(Archive___Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d11(Date_First_Seen_=0)),COUNT(__d11(Date_First_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d11(Date_Last_Seen_=0)),COUNT(__d11(Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d11(Hybrid_Archive_Date_=0)),COUNT(__d11(Hybrid_Archive_Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d11(Vault_Date_Last_Seen_=0)),COUNT(__d11(Vault_Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d12(__NL(Legal_))),COUNT(__d12(__NN(Legal_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d12(__NL(Location_))),COUNT(__d12(__NN(Location_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d12(__NL(Primary_Range_))),COUNT(__d12(__NN(Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d12(__NL(Predirectional_))),COUNT(__d12(__NN(Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d12(__NL(Primary_Name_))),COUNT(__d12(__NN(Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d12(__NL(Suffix_))),COUNT(__d12(__NN(Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d12(__NL(Postdirectional_))),COUNT(__d12(__NN(Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UnitDesignation',COUNT(__d12(__NL(Unit_Designation_))),COUNT(__d12(__NN(Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d12(__NL(Secondary_Range_))),COUNT(__d12(__NN(Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PostalCity',COUNT(__d12(__NL(Postal_City_))),COUNT(__d12(__NN(Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VanityCity',COUNT(__d12(__NL(Vanity_City_))),COUNT(__d12(__NN(Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','State',COUNT(__d12(__NL(State_))),COUNT(__d12(__NN(State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d12(__NL(Z_I_P5_))),COUNT(__d12(__NN(Z_I_P5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecType',COUNT(__d12(__NL(Rec_Type_))),COUNT(__d12(__NN(Rec_Type_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZIP4',COUNT(__d12(__NL(Z_I_P4_))),COUNT(__d12(__NN(Z_I_P4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d12(__NL(Metropolitan_Statistical_Area_))),COUNT(__d12(__NN(Metropolitan_Statistical_Area_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_secsic3',COUNT(__d12(__NL(S_I_C_Code_))),COUNT(__d12(__NN(S_I_C_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_secnaics3',COUNT(__d12(__NL(N_A_I_C_S_Code_))),COUNT(__d12(__NN(N_A_I_C_S_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d12(__NL(Best_Primary_Range_))),COUNT(__d12(__NN(Best_Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d12(__NL(Best_Predirectional_))),COUNT(__d12(__NN(Best_Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d12(__NL(Best_Primary_Name_))),COUNT(__d12(__NN(Best_Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d12(__NL(Best_Suffix_))),COUNT(__d12(__NN(Best_Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d12(__NL(Best_Postdirectional_))),COUNT(__d12(__NN(Best_Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d12(__NL(Best_Unit_Designation_))),COUNT(__d12(__NN(Best_Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d12(__NL(Best_Secondary_Range_))),COUNT(__d12(__NN(Best_Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d12(__NL(Best_Postal_City_))),COUNT(__d12(__NN(Best_Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d12(__NL(Best_Vanity_City_))),COUNT(__d12(__NN(Best_Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d12(__NL(Best_State_))),COUNT(__d12(__NN(Best_State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d12(__NL(Best_Zip5_))),COUNT(__d12(__NN(Best_Zip5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d12(__NL(Best_Zip4_))),COUNT(__d12(__NN(Best_Zip4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d12(__NL(Best_Address_Rank_))),COUNT(__d12(__NN(Best_Address_Rank_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d12(__NL(Company_Address_Type_Raw_))),COUNT(__d12(__NN(Company_Address_Type_Raw_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d12(__NL(Company_Address_Type_Derived_))),COUNT(__d12(__NN(Company_Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d12(__NL(Address_Type_Derived_))),COUNT(__d12(__NN(Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeenCompanyAddress',COUNT(__d12(__NL(Date_First_Seen_Company_Address_))),COUNT(__d12(__NN(Date_First_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenCompanyAddress',COUNT(__d12(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d12(__NN(Date_Last_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d12(__NL(Header_Hit_Flag_))),COUNT(__d12(__NN(Header_Hit_Flag_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d12(__NL(Source_))),COUNT(__d12(__NN(Source_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d12(Archive___Date_=0)),COUNT(__d12(Archive___Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d12(Date_First_Seen_=0)),COUNT(__d12(Date_First_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d12(Date_Last_Seen_=0)),COUNT(__d12(Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d12(Hybrid_Archive_Date_=0)),COUNT(__d12(Hybrid_Archive_Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d12(Vault_Date_Last_Seen_=0)),COUNT(__d12(Vault_Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d13(__NL(Legal_))),COUNT(__d13(__NN(Legal_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d13(__NL(Location_))),COUNT(__d13(__NN(Location_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d13(__NL(Primary_Range_))),COUNT(__d13(__NN(Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d13(__NL(Predirectional_))),COUNT(__d13(__NN(Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d13(__NL(Primary_Name_))),COUNT(__d13(__NN(Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d13(__NL(Suffix_))),COUNT(__d13(__NN(Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d13(__NL(Postdirectional_))),COUNT(__d13(__NN(Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UnitDesignation',COUNT(__d13(__NL(Unit_Designation_))),COUNT(__d13(__NN(Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d13(__NL(Secondary_Range_))),COUNT(__d13(__NN(Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PostalCity',COUNT(__d13(__NL(Postal_City_))),COUNT(__d13(__NN(Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VanityCity',COUNT(__d13(__NL(Vanity_City_))),COUNT(__d13(__NN(Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','State',COUNT(__d13(__NL(State_))),COUNT(__d13(__NN(State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d13(__NL(Z_I_P5_))),COUNT(__d13(__NN(Z_I_P5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecType',COUNT(__d13(__NL(Rec_Type_))),COUNT(__d13(__NN(Rec_Type_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZIP4',COUNT(__d13(__NL(Z_I_P4_))),COUNT(__d13(__NN(Z_I_P4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d13(__NL(Metropolitan_Statistical_Area_))),COUNT(__d13(__NN(Metropolitan_Statistical_Area_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_secsic4',COUNT(__d13(__NL(S_I_C_Code_))),COUNT(__d13(__NN(S_I_C_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','efx_secnaics4',COUNT(__d13(__NL(N_A_I_C_S_Code_))),COUNT(__d13(__NN(N_A_I_C_S_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d13(__NL(Best_Primary_Range_))),COUNT(__d13(__NN(Best_Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d13(__NL(Best_Predirectional_))),COUNT(__d13(__NN(Best_Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d13(__NL(Best_Primary_Name_))),COUNT(__d13(__NN(Best_Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d13(__NL(Best_Suffix_))),COUNT(__d13(__NN(Best_Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d13(__NL(Best_Postdirectional_))),COUNT(__d13(__NN(Best_Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d13(__NL(Best_Unit_Designation_))),COUNT(__d13(__NN(Best_Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d13(__NL(Best_Secondary_Range_))),COUNT(__d13(__NN(Best_Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d13(__NL(Best_Postal_City_))),COUNT(__d13(__NN(Best_Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d13(__NL(Best_Vanity_City_))),COUNT(__d13(__NN(Best_Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d13(__NL(Best_State_))),COUNT(__d13(__NN(Best_State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d13(__NL(Best_Zip5_))),COUNT(__d13(__NN(Best_Zip5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d13(__NL(Best_Zip4_))),COUNT(__d13(__NN(Best_Zip4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d13(__NL(Best_Address_Rank_))),COUNT(__d13(__NN(Best_Address_Rank_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d13(__NL(Company_Address_Type_Raw_))),COUNT(__d13(__NN(Company_Address_Type_Raw_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d13(__NL(Company_Address_Type_Derived_))),COUNT(__d13(__NN(Company_Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d13(__NL(Address_Type_Derived_))),COUNT(__d13(__NN(Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeenCompanyAddress',COUNT(__d13(__NL(Date_First_Seen_Company_Address_))),COUNT(__d13(__NN(Date_First_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenCompanyAddress',COUNT(__d13(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d13(__NN(Date_Last_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d13(__NL(Header_Hit_Flag_))),COUNT(__d13(__NN(Header_Hit_Flag_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d13(__NL(Source_))),COUNT(__d13(__NN(Source_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d13(Archive___Date_=0)),COUNT(__d13(Archive___Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d13(Date_First_Seen_=0)),COUNT(__d13(Date_First_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d13(Date_Last_Seen_=0)),COUNT(__d13(Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d13(Hybrid_Archive_Date_=0)),COUNT(__d13(Hybrid_Archive_Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d13(Vault_Date_Last_Seen_=0)),COUNT(__d13(Vault_Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d14(__NL(Legal_))),COUNT(__d14(__NN(Legal_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d14(__NL(Location_))),COUNT(__d14(__NN(Location_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d14(__NL(Primary_Range_))),COUNT(__d14(__NN(Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d14(__NL(Predirectional_))),COUNT(__d14(__NN(Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d14(__NL(Primary_Name_))),COUNT(__d14(__NN(Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d14(__NL(Suffix_))),COUNT(__d14(__NN(Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d14(__NL(Postdirectional_))),COUNT(__d14(__NN(Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UnitDesignation',COUNT(__d14(__NL(Unit_Designation_))),COUNT(__d14(__NN(Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d14(__NL(Secondary_Range_))),COUNT(__d14(__NN(Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PostalCity',COUNT(__d14(__NL(Postal_City_))),COUNT(__d14(__NN(Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VanityCity',COUNT(__d14(__NL(Vanity_City_))),COUNT(__d14(__NN(Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','State',COUNT(__d14(__NL(State_))),COUNT(__d14(__NN(State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d14(__NL(Z_I_P5_))),COUNT(__d14(__NN(Z_I_P5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecType',COUNT(__d14(__NL(Rec_Type_))),COUNT(__d14(__NN(Rec_Type_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZIP4',COUNT(__d14(__NL(Z_I_P4_))),COUNT(__d14(__NN(Z_I_P4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d14(__NL(Metropolitan_Statistical_Area_))),COUNT(__d14(__NN(Metropolitan_Statistical_Area_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SICCode',COUNT(__d14(__NL(S_I_C_Code_))),COUNT(__d14(__NN(S_I_C_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NAICSCode',COUNT(__d14(__NL(N_A_I_C_S_Code_))),COUNT(__d14(__NN(N_A_I_C_S_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d14(__NL(Best_Primary_Range_))),COUNT(__d14(__NN(Best_Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d14(__NL(Best_Predirectional_))),COUNT(__d14(__NN(Best_Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d14(__NL(Best_Primary_Name_))),COUNT(__d14(__NN(Best_Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d14(__NL(Best_Suffix_))),COUNT(__d14(__NN(Best_Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d14(__NL(Best_Postdirectional_))),COUNT(__d14(__NN(Best_Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','unit_desig',COUNT(__d14(__NL(Best_Unit_Designation_))),COUNT(__d14(__NN(Best_Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d14(__NL(Best_Secondary_Range_))),COUNT(__d14(__NN(Best_Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','p_city_name',COUNT(__d14(__NL(Best_Postal_City_))),COUNT(__d14(__NN(Best_Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','v_city_name',COUNT(__d14(__NL(Best_Vanity_City_))),COUNT(__d14(__NN(Best_Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d14(__NL(Best_State_))),COUNT(__d14(__NN(Best_State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d14(__NL(Best_Zip5_))),COUNT(__d14(__NN(Best_Zip5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip4',COUNT(__d14(__NL(Best_Zip4_))),COUNT(__d14(__NN(Best_Zip4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d14(__NL(Company_Address_Type_Raw_))),COUNT(__d14(__NN(Company_Address_Type_Raw_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d14(__NL(Company_Address_Type_Derived_))),COUNT(__d14(__NN(Company_Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d14(__NL(Address_Type_Derived_))),COUNT(__d14(__NN(Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeenCompanyAddress',COUNT(__d14(__NL(Date_First_Seen_Company_Address_))),COUNT(__d14(__NN(Date_First_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenCompanyAddress',COUNT(__d14(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d14(__NN(Date_Last_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d14(__NL(Header_Hit_Flag_))),COUNT(__d14(__NN(Header_Hit_Flag_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d14(__NL(Source_))),COUNT(__d14(__NN(Source_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d14(Archive___Date_=0)),COUNT(__d14(Archive___Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d14(Date_First_Seen_=0)),COUNT(__d14(Date_First_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d14(Date_Last_Seen_=0)),COUNT(__d14(Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d14(Hybrid_Archive_Date_=0)),COUNT(__d14(Hybrid_Archive_Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d14(Vault_Date_Last_Seen_=0)),COUNT(__d14(Vault_Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d15(__NL(Legal_))),COUNT(__d15(__NN(Legal_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d15(__NL(Location_))),COUNT(__d15(__NN(Location_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d15(__NL(Primary_Range_))),COUNT(__d15(__NN(Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d15(__NL(Predirectional_))),COUNT(__d15(__NN(Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d15(__NL(Primary_Name_))),COUNT(__d15(__NN(Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d15(__NL(Suffix_))),COUNT(__d15(__NN(Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d15(__NL(Postdirectional_))),COUNT(__d15(__NN(Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','unit_desig',COUNT(__d15(__NL(Unit_Designation_))),COUNT(__d15(__NN(Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d15(__NL(Secondary_Range_))),COUNT(__d15(__NN(Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','p_city_name',COUNT(__d15(__NL(Postal_City_))),COUNT(__d15(__NN(Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','v_city_name',COUNT(__d15(__NL(Vanity_City_))),COUNT(__d15(__NN(Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d15(__NL(State_))),COUNT(__d15(__NN(State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','z5',COUNT(__d15(__NL(Z_I_P5_))),COUNT(__d15(__NN(Z_I_P5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecType',COUNT(__d15(__NL(Rec_Type_))),COUNT(__d15(__NN(Rec_Type_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','z4',COUNT(__d15(__NL(Z_I_P4_))),COUNT(__d15(__NN(Z_I_P4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d15(__NL(Metropolitan_Statistical_Area_))),COUNT(__d15(__NN(Metropolitan_Statistical_Area_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SICCode',COUNT(__d15(__NL(S_I_C_Code_))),COUNT(__d15(__NN(S_I_C_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NAICSCode',COUNT(__d15(__NL(N_A_I_C_S_Code_))),COUNT(__d15(__NN(N_A_I_C_S_Code_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryRange',COUNT(__d15(__NL(Best_Primary_Range_))),COUNT(__d15(__NN(Best_Primary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPredirectional',COUNT(__d15(__NL(Best_Predirectional_))),COUNT(__d15(__NN(Best_Predirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPrimaryName',COUNT(__d15(__NL(Best_Primary_Name_))),COUNT(__d15(__NN(Best_Primary_Name_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSuffix',COUNT(__d15(__NL(Best_Suffix_))),COUNT(__d15(__NN(Best_Suffix_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostdirectional',COUNT(__d15(__NL(Best_Postdirectional_))),COUNT(__d15(__NN(Best_Postdirectional_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestUnitDesignation',COUNT(__d15(__NL(Best_Unit_Designation_))),COUNT(__d15(__NN(Best_Unit_Designation_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestSecondaryRange',COUNT(__d15(__NL(Best_Secondary_Range_))),COUNT(__d15(__NN(Best_Secondary_Range_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestPostalCity',COUNT(__d15(__NL(Best_Postal_City_))),COUNT(__d15(__NN(Best_Postal_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestVanityCity',COUNT(__d15(__NL(Best_Vanity_City_))),COUNT(__d15(__NN(Best_Vanity_City_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestState',COUNT(__d15(__NL(Best_State_))),COUNT(__d15(__NN(Best_State_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip5',COUNT(__d15(__NL(Best_Zip5_))),COUNT(__d15(__NN(Best_Zip5_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestZip4',COUNT(__d15(__NL(Best_Zip4_))),COUNT(__d15(__NN(Best_Zip4_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BestAddressRank',COUNT(__d15(__NL(Best_Address_Rank_))),COUNT(__d15(__NN(Best_Address_Rank_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d15(__NL(Company_Address_Type_Raw_))),COUNT(__d15(__NN(Company_Address_Type_Raw_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d15(__NL(Company_Address_Type_Derived_))),COUNT(__d15(__NN(Company_Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d15(__NL(Address_Type_Derived_))),COUNT(__d15(__NN(Address_Type_Derived_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeenCompanyAddress',COUNT(__d15(__NL(Date_First_Seen_Company_Address_))),COUNT(__d15(__NN(Date_First_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeenCompanyAddress',COUNT(__d15(__NL(Date_Last_Seen_Company_Address_))),COUNT(__d15(__NN(Date_Last_Seen_Company_Address_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d15(__NL(Header_Hit_Flag_))),COUNT(__d15(__NN(Header_Hit_Flag_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d15(__NL(Source_))),COUNT(__d15(__NN(Source_)))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d15(Archive___Date_=0)),COUNT(__d15(Archive___Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d15(Date_First_Seen_=0)),COUNT(__d15(Date_First_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d15(Date_Last_Seen_=0)),COUNT(__d15(Date_Last_Seen_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d15(Hybrid_Archive_Date_=0)),COUNT(__d15(Hybrid_Archive_Date_!=0))},
    {'SeleAddress','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d15(Vault_Date_Last_Seen_=0)),COUNT(__d15(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
