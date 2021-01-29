//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_Professional_License(CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nkdate Date_Created_;
    KEL.typ.nstr License_State_;
    KEL.typ.nkdate Date_Processed_;
    KEL.typ.nstr Legacy_Result_Code_;
    KEL.typ.nstr Source_Description_;
    KEL.typ.nstr Source_Code_;
    KEL.typ.nkdate Date_First_Reported_;
    KEL.typ.nkdate Date_Last_Reported_;
    KEL.typ.nkdate Date_Last_Updated_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr License_Business_Flag_;
    KEL.typ.nstr License_Profession_Code_;
    KEL.typ.nstr License_Profession_Description_;
    KEL.typ.nstr License_Status_;
    KEL.typ.nstr License_Description_;
    KEL.typ.nkdate Original_Date_Of_Issuance_;
    KEL.typ.nkdate Current_Date_Of_Issuance_;
    KEL.typ.nkdate Date_Of_Expiration_;
    KEL.typ.nkdate Date_Of_License_Renewal_;
    KEL.typ.nstr Affiliated_Type_Code_;
    KEL.typ.nkdate Start_Date_;
    KEL.typ.nint License_Category_;
    KEL.typ.nstr Occupation_;
    KEL.typ.nint Lex_I_D_;
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
  SHARED __Mapping := 'UID(DEFAULT:UID),datecreated(DEFAULT:Date_Created_:DATE),licensestate(DEFAULT:License_State_:\'\'),dateprocessed(DEFAULT:Date_Processed_:DATE),legacyresultcode(DEFAULT:Legacy_Result_Code_:\'\'),sourcedescription(DEFAULT:Source_Description_:\'\'),sourcecode(DEFAULT:Source_Code_:\'\'),datefirstreported(DEFAULT:Date_First_Reported_:DATE),datelastreported(DEFAULT:Date_Last_Reported_:DATE),datelastupdated(DEFAULT:Date_Last_Updated_:DATE),licensenumber(DEFAULT:License_Number_:\'\'),licensebusinessflag(DEFAULT:License_Business_Flag_:\'\'),licenseprofessioncode(DEFAULT:License_Profession_Code_:\'\'),licenseprofessiondescription(DEFAULT:License_Profession_Description_:\'\'),licensestatus(DEFAULT:License_Status_:\'\'),licensedescription(DEFAULT:License_Description_:\'\'),originaldateofissuance(DEFAULT:Original_Date_Of_Issuance_:DATE),currentdateofissuance(DEFAULT:Current_Date_Of_Issuance_:DATE),dateofexpiration(DEFAULT:Date_Of_Expiration_:DATE),dateoflicenserenewal(DEFAULT:Date_Of_License_Renewal_:DATE),affiliatedtypecode(DEFAULT:Affiliated_Type_Code_:\'\'),startdate(DEFAULT:Start_Date_:DATE),licensecategory(DEFAULT:License_Category_:0),occupation(DEFAULT:Occupation_:\'\'),lexid(DEFAULT:Lex_I_D_:0),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault(TRIM(cleaned_license_number) != '' AND TRIM(license_state) != '');
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.cleaned_license_number) + '|' + TRIM((STRING)LEFT.license_state) + '|' + TRIM((STRING)LEFT.did)));
  SHARED __d1_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault(TRIM(cleaned_license_number) != '' AND TRIM(source_st) != '');
  SHARED __d1_Trim := PROJECT(__d1_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.cleaned_license_number) + '|' + TRIM((STRING)LEFT.source_st) + '|' + TRIM((STRING)LEFT.did)));
  SHARED __d2_KELfiltered := PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault(TRIM(cleaned_license_number) != '' AND TRIM(license_state) != '');
  SHARED __d2_Trim := PROJECT(__d2_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.cleaned_license_number) + '|' + TRIM((STRING)LEFT.license_state) + '|' + TRIM((STRING)LEFT.did)));
  SHARED __d3_KELfiltered := PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault(TRIM(cleaned_license_number) != '' AND TRIM(source_st) != '');
  SHARED __d3_Trim := PROJECT(__d3_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.cleaned_license_number) + '|' + TRIM((STRING)LEFT.source_st) + '|' + TRIM((STRING)LEFT.did)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim + __d2_Trim + __d3_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'') + '|' + TRIM((STRING)'') + '|' + TRIM((STRING)0);
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::PublicRecords_KEL::Professional_License::UidLookup',EXPIRE(7));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::PublicRecords_KEL::Professional_License');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::PublicRecords_KEL::Professional_License');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED Date_Of_License_Renewal_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Hybrid_Archive_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'UID(DEFAULT:UID),create_dte(OVERRIDE:Date_Created_:DATE),license_state(OVERRIDE:License_State_:\'\'),process_date(OVERRIDE:Date_Processed_:DATE),result_cd_1(OVERRIDE:Legacy_Result_Code_:\'\'),std_source_desc(OVERRIDE:Source_Description_:\'\'),std_source_upd(OVERRIDE:Source_Code_:\'\'),date_vendor_first_reported(OVERRIDE:Date_First_Reported_:DATE),date_vendor_last_reported(OVERRIDE:Date_Last_Reported_:DATE),last_upd_dte(OVERRIDE:Date_Last_Updated_:DATE),cleaned_license_number(OVERRIDE:License_Number_:\'\'),type_cd(OVERRIDE:License_Business_Flag_:\'\'),std_prof_cd(OVERRIDE:License_Profession_Code_:\'\'),std_prof_desc(OVERRIDE:License_Profession_Description_:\'\'),std_status_desc(OVERRIDE:License_Status_:\'\'),std_license_desc(OVERRIDE:License_Description_:\'\'),orig_issue_dte(OVERRIDE:Original_Date_Of_Issuance_:DATE),curr_issue_dte(OVERRIDE:Current_Date_Of_Issuance_:DATE),expire_dte(OVERRIDE:Date_Of_Expiration_:DATE),renewal_dte(OVERRIDE:Date_Of_License_Renewal_:DATE:Date_Of_License_Renewal_0Rule),affil_type_cd(OVERRIDE:Affiliated_Type_Code_:\'\'),start_dte(OVERRIDE:Start_Date_:DATE),category(OVERRIDE:License_Category_:0),occupation(OVERRIDE:Occupation_:\'\'),did(OVERRIDE:Lex_I_D_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_0Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.cleaned_license_number) + '|' + TRIM((STRING)LEFT.license_state) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_NonFCRA_Prof_License_Mari__Key_did_Vault_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault'));
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'UID(DEFAULT:UID),datecreated(DEFAULT:Date_Created_:DATE),source_st(OVERRIDE:License_State_:\'\'),dateprocessed(DEFAULT:Date_Processed_:DATE),legacyresultcode(DEFAULT:Legacy_Result_Code_:\'\'),vendor(OVERRIDE:Source_Description_:\'\'),sourcecode(DEFAULT:Source_Code_:\'\'),datefirstreported(DEFAULT:Date_First_Reported_:DATE),datelastreported(DEFAULT:Date_Last_Reported_:DATE),datelastupdated(DEFAULT:Date_Last_Updated_:DATE),cleaned_license_number(OVERRIDE:License_Number_:\'\'),business_flag(OVERRIDE:License_Business_Flag_:\'\'),licenseprofessioncode(DEFAULT:License_Profession_Code_:\'\'),profession_or_board(OVERRIDE:License_Profession_Description_:\'\'),status(OVERRIDE:License_Status_:\'\'),license_type(OVERRIDE:License_Description_:\'\'),issue_date(OVERRIDE:Original_Date_Of_Issuance_:DATE),currentdateofissuance(DEFAULT:Current_Date_Of_Issuance_:DATE),expiration_date(OVERRIDE:Date_Of_Expiration_:DATE),last_renewal_date(OVERRIDE:Date_Of_License_Renewal_:DATE),affiliatedtypecode(DEFAULT:Affiliated_Type_Code_:\'\'),startdate(DEFAULT:Start_Date_:DATE),category(OVERRIDE:License_Category_:0),occupation(OVERRIDE:Occupation_:\'\'),did(OVERRIDE:Lex_I_D_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_1Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_KELfiltered,Lookup,TRIM((STRING)LEFT.cleaned_license_number) + '|' + TRIM((STRING)LEFT.source_st) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_NonFCRA_Prof_LicenseV2__Key_Proflic_Did_Vault_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault'));
  SHARED Date_Of_License_Renewal_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Hybrid_Archive_Date_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping2 := 'UID(DEFAULT:UID),create_dte(OVERRIDE:Date_Created_:DATE),license_state(OVERRIDE:License_State_:\'\'),process_date(OVERRIDE:Date_Processed_:DATE),result_cd_1(OVERRIDE:Legacy_Result_Code_:\'\'),std_source_desc(OVERRIDE:Source_Description_:\'\'),std_source_upd(OVERRIDE:Source_Code_:\'\'),datefirstreported(DEFAULT:Date_First_Reported_:DATE),datelastreported(DEFAULT:Date_Last_Reported_:DATE),last_upd_dte(OVERRIDE:Date_Last_Updated_:DATE),cleaned_license_number(OVERRIDE:License_Number_:\'\'),type_cd(OVERRIDE:License_Business_Flag_:\'\'),std_prof_cd(OVERRIDE:License_Profession_Code_:\'\'),std_prof_desc(OVERRIDE:License_Profession_Description_:\'\'),std_status_desc(OVERRIDE:License_Status_:\'\'),std_license_desc(OVERRIDE:License_Description_:\'\'),orig_issue_dte(OVERRIDE:Original_Date_Of_Issuance_:DATE),curr_issue_dte(OVERRIDE:Current_Date_Of_Issuance_:DATE),expire_dte(OVERRIDE:Date_Of_Expiration_:DATE),renewal_dte(OVERRIDE:Date_Of_License_Renewal_:DATE:Date_Of_License_Renewal_2Rule),affil_type_cd(OVERRIDE:Affiliated_Type_Code_:\'\'),start_dte(OVERRIDE:Start_Date_:DATE),category(OVERRIDE:License_Category_:0),occupation(OVERRIDE:Occupation_:\'\'),did(OVERRIDE:Lex_I_D_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_2Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d2_UID_Mapped := JOIN(__d2_KELfiltered,Lookup,TRIM((STRING)LEFT.cleaned_license_number) + '|' + TRIM((STRING)LEFT.license_state) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d2_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_FCRA_Prof_License_Mari__Key_did_Vault_Invalid := __d2_UID_Mapped(UID = 0);
  SHARED __d2_Prefiltered := __d2_UID_Mapped(UID <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault'));
  SHARED Date_Last_Seen_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping3 := 'UID(DEFAULT:UID),datecreated(DEFAULT:Date_Created_:DATE),source_st(OVERRIDE:License_State_:\'\'),dateprocessed(DEFAULT:Date_Processed_:DATE),legacyresultcode(DEFAULT:Legacy_Result_Code_:\'\'),vendor(OVERRIDE:Source_Description_:\'\'),sourcecode(DEFAULT:Source_Code_:\'\'),datefirstreported(DEFAULT:Date_First_Reported_:DATE),datelastreported(DEFAULT:Date_Last_Reported_:DATE),datelastupdated(DEFAULT:Date_Last_Updated_:DATE),cleaned_license_number(OVERRIDE:License_Number_:\'\'),business_flag(OVERRIDE:License_Business_Flag_:\'\'),licenseprofessioncode(DEFAULT:License_Profession_Code_:\'\'),profession_or_board(OVERRIDE:License_Profession_Description_:\'\'),status(OVERRIDE:License_Status_:\'\'),license_type(OVERRIDE:License_Description_:\'\'),issue_date(OVERRIDE:Original_Date_Of_Issuance_:DATE),currentdateofissuance(DEFAULT:Current_Date_Of_Issuance_:DATE),expiration_date(OVERRIDE:Date_Of_Expiration_:DATE),last_renewal_date(OVERRIDE:Date_Of_License_Renewal_:DATE),affiliatedtypecode(DEFAULT:Affiliated_Type_Code_:\'\'),startdate(DEFAULT:Start_Date_:DATE),category(OVERRIDE:License_Category_:0),occupation(OVERRIDE:Occupation_:\'\'),did(OVERRIDE:Lex_I_D_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_3Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_3Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d3_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d3_UID_Mapped := JOIN(__d3_KELfiltered,Lookup,TRIM((STRING)LEFT.cleaned_license_number) + '|' + TRIM((STRING)LEFT.source_st) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d3_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_FCRA_Prof_LicenseV2__Key_Proflic_Did_Vault_Invalid := __d3_UID_Mapped(UID = 0);
  SHARED __d3_Prefiltered := __d3_UID_Mapped(UID <> 0);
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3;
  EXPORT Source_Details_Layout := RECORD
    KEL.typ.nstr Source_Code_;
    KEL.typ.nstr Source_Description_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT License_Dates_Layout := RECORD
    KEL.typ.nkdate Original_Date_Of_Issuance_;
    KEL.typ.nkdate Current_Date_Of_Issuance_;
    KEL.typ.nkdate Date_Of_Expiration_;
    KEL.typ.nkdate Date_Of_License_Renewal_;
    KEL.typ.nkdate Date_First_Reported_;
    KEL.typ.nkdate Date_Last_Reported_;
    KEL.typ.nkdate Date_Last_Updated_;
    KEL.typ.nkdate Start_Date_;
    KEL.typ.nstr License_Description_;
    KEL.typ.nstr Occupation_;
    KEL.typ.nint License_Category_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Status_Layout := RECORD
    KEL.typ.nstr License_Status_;
    KEL.typ.nkdate Date_Processed_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT License_Description_Layout := RECORD
    KEL.typ.nstr License_Profession_Code_;
    KEL.typ.nstr License_Profession_Description_;
    KEL.typ.nstr License_Description_;
    KEL.typ.nstr Affiliated_Type_Code_;
    KEL.typ.nstr License_Business_Flag_;
    KEL.typ.nint License_Category_;
    KEL.typ.nstr Occupation_;
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
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr License_State_;
    KEL.typ.nint Lex_I_D_;
    KEL.typ.nkdate Date_Created_;
    KEL.typ.nstr Legacy_Result_Code_;
    KEL.typ.ndataset(Source_Details_Layout) Source_Details_;
    KEL.typ.ndataset(License_Dates_Layout) License_Dates_;
    KEL.typ.ndataset(Status_Layout) Status_;
    KEL.typ.ndataset(License_Description_Layout) License_Description_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Professional_License_Group := __PostFilter;
  Layout Professional_License__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.License_Number_ := KEL.Intake.SingleValue(__recs,License_Number_);
    SELF.License_State_ := KEL.Intake.SingleValue(__recs,License_State_);
    SELF.Lex_I_D_ := KEL.Intake.SingleValue(__recs,Lex_I_D_);
    SELF.Date_Created_ := KEL.Intake.SingleValue(__recs,Date_Created_);
    SELF.Legacy_Result_Code_ := KEL.Intake.SingleValue(__recs,Legacy_Result_Code_);
    SELF.Source_Details_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_Code_,Source_Description_},Source_Code_,Source_Description_),Source_Details_Layout)(__NN(Source_Code_) OR __NN(Source_Description_)));
    SELF.License_Dates_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Original_Date_Of_Issuance_,Current_Date_Of_Issuance_,Date_Of_Expiration_,Date_Of_License_Renewal_,Date_First_Reported_,Date_Last_Reported_,Date_Last_Updated_,Start_Date_,License_Description_,Occupation_,License_Category_,Source_},Original_Date_Of_Issuance_,Current_Date_Of_Issuance_,Date_Of_Expiration_,Date_Of_License_Renewal_,Date_First_Reported_,Date_Last_Reported_,Date_Last_Updated_,Start_Date_,License_Description_,Occupation_,License_Category_,Source_),License_Dates_Layout)(__NN(Original_Date_Of_Issuance_) OR __NN(Current_Date_Of_Issuance_) OR __NN(Date_Of_Expiration_) OR __NN(Date_Of_License_Renewal_) OR __NN(Date_First_Reported_) OR __NN(Date_Last_Reported_) OR __NN(Date_Last_Updated_) OR __NN(Start_Date_) OR __NN(License_Description_) OR __NN(Occupation_) OR __NN(License_Category_) OR __NN(Source_)));
    SELF.Status_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),License_Status_,Date_Processed_},License_Status_,Date_Processed_),Status_Layout)(__NN(License_Status_) OR __NN(Date_Processed_)));
    SELF.License_Description_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),License_Profession_Code_,License_Profession_Description_,License_Description_,Affiliated_Type_Code_,License_Business_Flag_,License_Category_,Occupation_},License_Profession_Code_,License_Profession_Description_,License_Description_,Affiliated_Type_Code_,License_Business_Flag_,License_Category_,Occupation_),License_Description_Layout)(__NN(License_Profession_Code_) OR __NN(License_Profession_Description_) OR __NN(License_Description_) OR __NN(Affiliated_Type_Code_) OR __NN(License_Business_Flag_) OR __NN(License_Category_) OR __NN(Occupation_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Professional_License__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Source_Details_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Source_Details_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_Code_) OR __NN(Source_Description_)));
    SELF.License_Dates_ := __CN(PROJECT(DATASET(__r),TRANSFORM(License_Dates_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Original_Date_Of_Issuance_) OR __NN(Current_Date_Of_Issuance_) OR __NN(Date_Of_Expiration_) OR __NN(Date_Of_License_Renewal_) OR __NN(Date_First_Reported_) OR __NN(Date_Last_Reported_) OR __NN(Date_Last_Updated_) OR __NN(Start_Date_) OR __NN(License_Description_) OR __NN(Occupation_) OR __NN(License_Category_) OR __NN(Source_)));
    SELF.Status_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Status_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(License_Status_) OR __NN(Date_Processed_)));
    SELF.License_Description_ := __CN(PROJECT(DATASET(__r),TRANSFORM(License_Description_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(License_Profession_Code_) OR __NN(License_Profession_Description_) OR __NN(License_Description_) OR __NN(Affiliated_Type_Code_) OR __NN(License_Business_Flag_) OR __NN(License_Category_) OR __NN(Occupation_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Professional_License_Group,COUNT(ROWS(LEFT))=1),GROUP,Professional_License__Single_Rollup(LEFT)) + ROLLUP(HAVING(Professional_License_Group,COUNT(ROWS(LEFT))>1),GROUP,Professional_License__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT License_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,License_Number_);
  EXPORT License_State__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,License_State_);
  EXPORT Lex_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Lex_I_D_);
  EXPORT Date_Created__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Date_Created_);
  EXPORT Legacy_Result_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Legacy_Result_Code_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_Files_NonFCRA_Prof_License_Mari__Key_did_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_Prof_LicenseV2__Key_Proflic_Did_Vault_Invalid),COUNT(PublicRecords_KEL_Files_FCRA_Prof_License_Mari__Key_did_Vault_Invalid),COUNT(PublicRecords_KEL_Files_FCRA_Prof_LicenseV2__Key_Proflic_Did_Vault_Invalid),COUNT(License_Number__SingleValue_Invalid),COUNT(License_State__SingleValue_Invalid),COUNT(Lex_I_D__SingleValue_Invalid),COUNT(Date_Created__SingleValue_Invalid),COUNT(Legacy_Result_Code__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_Files_NonFCRA_Prof_License_Mari__Key_did_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_Prof_LicenseV2__Key_Proflic_Did_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_FCRA_Prof_License_Mari__Key_did_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_FCRA_Prof_LicenseV2__Key_Proflic_Did_Vault_Invalid,KEL.typ.int License_Number__SingleValue_Invalid,KEL.typ.int License_State__SingleValue_Invalid,KEL.typ.int Lex_I_D__SingleValue_Invalid,KEL.typ.int Date_Created__SingleValue_Invalid,KEL.typ.int Legacy_Result_Code__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_Prof_License_Mari__Key_did_Vault_Invalid),COUNT(__d0)},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','create_dte',COUNT(__d0(__NL(Date_Created_))),COUNT(__d0(__NN(Date_Created_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','license_state',COUNT(__d0(__NL(License_State_))),COUNT(__d0(__NN(License_State_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','process_date',COUNT(__d0(__NL(Date_Processed_))),COUNT(__d0(__NN(Date_Processed_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','result_cd_1',COUNT(__d0(__NL(Legacy_Result_Code_))),COUNT(__d0(__NN(Legacy_Result_Code_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','std_source_desc',COUNT(__d0(__NL(Source_Description_))),COUNT(__d0(__NN(Source_Description_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','std_source_upd',COUNT(__d0(__NL(Source_Code_))),COUNT(__d0(__NN(Source_Code_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','date_vendor_first_reported',COUNT(__d0(__NL(Date_First_Reported_))),COUNT(__d0(__NN(Date_First_Reported_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','date_vendor_last_reported',COUNT(__d0(__NL(Date_Last_Reported_))),COUNT(__d0(__NN(Date_Last_Reported_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','last_upd_dte',COUNT(__d0(__NL(Date_Last_Updated_))),COUNT(__d0(__NN(Date_Last_Updated_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','cleaned_license_number',COUNT(__d0(__NL(License_Number_))),COUNT(__d0(__NN(License_Number_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','type_cd',COUNT(__d0(__NL(License_Business_Flag_))),COUNT(__d0(__NN(License_Business_Flag_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','std_prof_cd',COUNT(__d0(__NL(License_Profession_Code_))),COUNT(__d0(__NN(License_Profession_Code_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','std_prof_desc',COUNT(__d0(__NL(License_Profession_Description_))),COUNT(__d0(__NN(License_Profession_Description_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','std_status_desc',COUNT(__d0(__NL(License_Status_))),COUNT(__d0(__NN(License_Status_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','std_license_desc',COUNT(__d0(__NL(License_Description_))),COUNT(__d0(__NN(License_Description_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','orig_issue_dte',COUNT(__d0(__NL(Original_Date_Of_Issuance_))),COUNT(__d0(__NN(Original_Date_Of_Issuance_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','curr_issue_dte',COUNT(__d0(__NL(Current_Date_Of_Issuance_))),COUNT(__d0(__NN(Current_Date_Of_Issuance_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','expire_dte',COUNT(__d0(__NL(Date_Of_Expiration_))),COUNT(__d0(__NN(Date_Of_Expiration_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','renewal_dte',COUNT(__d0(__NL(Date_Of_License_Renewal_))),COUNT(__d0(__NN(Date_Of_License_Renewal_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','affil_type_cd',COUNT(__d0(__NL(Affiliated_Type_Code_))),COUNT(__d0(__NN(Affiliated_Type_Code_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','start_dte',COUNT(__d0(__NL(Start_Date_))),COUNT(__d0(__NN(Start_Date_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','category',COUNT(__d0(__NL(License_Category_))),COUNT(__d0(__NN(License_Category_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','occupation',COUNT(__d0(__NL(Occupation_))),COUNT(__d0(__NN(Occupation_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','did',COUNT(__d0(__NL(Lex_I_D_))),COUNT(__d0(__NN(Lex_I_D_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_License_Mari__Key_did_Vault','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_Prof_LicenseV2__Key_Proflic_Did_Vault_Invalid),COUNT(__d1)},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','DateCreated',COUNT(__d1(__NL(Date_Created_))),COUNT(__d1(__NN(Date_Created_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','source_st',COUNT(__d1(__NL(License_State_))),COUNT(__d1(__NN(License_State_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','DateProcessed',COUNT(__d1(__NL(Date_Processed_))),COUNT(__d1(__NN(Date_Processed_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','LegacyResultCode',COUNT(__d1(__NL(Legacy_Result_Code_))),COUNT(__d1(__NN(Legacy_Result_Code_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','vendor',COUNT(__d1(__NL(Source_Description_))),COUNT(__d1(__NN(Source_Description_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','SourceCode',COUNT(__d1(__NL(Source_Code_))),COUNT(__d1(__NN(Source_Code_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','DateFirstReported',COUNT(__d1(__NL(Date_First_Reported_))),COUNT(__d1(__NN(Date_First_Reported_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','DateLastReported',COUNT(__d1(__NL(Date_Last_Reported_))),COUNT(__d1(__NN(Date_Last_Reported_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','DateLastUpdated',COUNT(__d1(__NL(Date_Last_Updated_))),COUNT(__d1(__NN(Date_Last_Updated_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','cleaned_license_number',COUNT(__d1(__NL(License_Number_))),COUNT(__d1(__NN(License_Number_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','business_flag',COUNT(__d1(__NL(License_Business_Flag_))),COUNT(__d1(__NN(License_Business_Flag_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','LicenseProfessionCode',COUNT(__d1(__NL(License_Profession_Code_))),COUNT(__d1(__NN(License_Profession_Code_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','profession_or_board',COUNT(__d1(__NL(License_Profession_Description_))),COUNT(__d1(__NN(License_Profession_Description_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','status',COUNT(__d1(__NL(License_Status_))),COUNT(__d1(__NN(License_Status_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','license_type',COUNT(__d1(__NL(License_Description_))),COUNT(__d1(__NN(License_Description_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','issue_date',COUNT(__d1(__NL(Original_Date_Of_Issuance_))),COUNT(__d1(__NN(Original_Date_Of_Issuance_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','CurrentDateOfIssuance',COUNT(__d1(__NL(Current_Date_Of_Issuance_))),COUNT(__d1(__NN(Current_Date_Of_Issuance_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','expiration_date',COUNT(__d1(__NL(Date_Of_Expiration_))),COUNT(__d1(__NN(Date_Of_Expiration_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','last_renewal_date',COUNT(__d1(__NL(Date_Of_License_Renewal_))),COUNT(__d1(__NN(Date_Of_License_Renewal_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','AffiliatedTypeCode',COUNT(__d1(__NL(Affiliated_Type_Code_))),COUNT(__d1(__NN(Affiliated_Type_Code_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','StartDate',COUNT(__d1(__NL(Start_Date_))),COUNT(__d1(__NN(Start_Date_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','category',COUNT(__d1(__NL(License_Category_))),COUNT(__d1(__NN(License_Category_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','occupation',COUNT(__d1(__NL(Occupation_))),COUNT(__d1(__NN(Occupation_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','did',COUNT(__d1(__NL(Lex_I_D_))),COUNT(__d1(__NN(Lex_I_D_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.NonFCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','UID',COUNT(PublicRecords_KEL_Files_FCRA_Prof_License_Mari__Key_did_Vault_Invalid),COUNT(__d2)},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','create_dte',COUNT(__d2(__NL(Date_Created_))),COUNT(__d2(__NN(Date_Created_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','license_state',COUNT(__d2(__NL(License_State_))),COUNT(__d2(__NN(License_State_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','process_date',COUNT(__d2(__NL(Date_Processed_))),COUNT(__d2(__NN(Date_Processed_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','result_cd_1',COUNT(__d2(__NL(Legacy_Result_Code_))),COUNT(__d2(__NN(Legacy_Result_Code_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','std_source_desc',COUNT(__d2(__NL(Source_Description_))),COUNT(__d2(__NN(Source_Description_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','std_source_upd',COUNT(__d2(__NL(Source_Code_))),COUNT(__d2(__NN(Source_Code_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','DateFirstReported',COUNT(__d2(__NL(Date_First_Reported_))),COUNT(__d2(__NN(Date_First_Reported_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','DateLastReported',COUNT(__d2(__NL(Date_Last_Reported_))),COUNT(__d2(__NN(Date_Last_Reported_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','last_upd_dte',COUNT(__d2(__NL(Date_Last_Updated_))),COUNT(__d2(__NN(Date_Last_Updated_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','cleaned_license_number',COUNT(__d2(__NL(License_Number_))),COUNT(__d2(__NN(License_Number_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','type_cd',COUNT(__d2(__NL(License_Business_Flag_))),COUNT(__d2(__NN(License_Business_Flag_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','std_prof_cd',COUNT(__d2(__NL(License_Profession_Code_))),COUNT(__d2(__NN(License_Profession_Code_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','std_prof_desc',COUNT(__d2(__NL(License_Profession_Description_))),COUNT(__d2(__NN(License_Profession_Description_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','std_status_desc',COUNT(__d2(__NL(License_Status_))),COUNT(__d2(__NN(License_Status_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','std_license_desc',COUNT(__d2(__NL(License_Description_))),COUNT(__d2(__NN(License_Description_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','orig_issue_dte',COUNT(__d2(__NL(Original_Date_Of_Issuance_))),COUNT(__d2(__NN(Original_Date_Of_Issuance_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','curr_issue_dte',COUNT(__d2(__NL(Current_Date_Of_Issuance_))),COUNT(__d2(__NN(Current_Date_Of_Issuance_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','expire_dte',COUNT(__d2(__NL(Date_Of_Expiration_))),COUNT(__d2(__NN(Date_Of_Expiration_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','renewal_dte',COUNT(__d2(__NL(Date_Of_License_Renewal_))),COUNT(__d2(__NN(Date_Of_License_Renewal_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','affil_type_cd',COUNT(__d2(__NL(Affiliated_Type_Code_))),COUNT(__d2(__NN(Affiliated_Type_Code_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','start_dte',COUNT(__d2(__NL(Start_Date_))),COUNT(__d2(__NN(Start_Date_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','category',COUNT(__d2(__NL(License_Category_))),COUNT(__d2(__NN(License_Category_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','occupation',COUNT(__d2(__NL(Occupation_))),COUNT(__d2(__NN(Occupation_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','did',COUNT(__d2(__NL(Lex_I_D_))),COUNT(__d2(__NN(Lex_I_D_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_License_Mari__Key_did_Vault','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','UID',COUNT(PublicRecords_KEL_Files_FCRA_Prof_LicenseV2__Key_Proflic_Did_Vault_Invalid),COUNT(__d3)},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','DateCreated',COUNT(__d3(__NL(Date_Created_))),COUNT(__d3(__NN(Date_Created_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','source_st',COUNT(__d3(__NL(License_State_))),COUNT(__d3(__NN(License_State_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','DateProcessed',COUNT(__d3(__NL(Date_Processed_))),COUNT(__d3(__NN(Date_Processed_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','LegacyResultCode',COUNT(__d3(__NL(Legacy_Result_Code_))),COUNT(__d3(__NN(Legacy_Result_Code_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','vendor',COUNT(__d3(__NL(Source_Description_))),COUNT(__d3(__NN(Source_Description_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','SourceCode',COUNT(__d3(__NL(Source_Code_))),COUNT(__d3(__NN(Source_Code_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','DateFirstReported',COUNT(__d3(__NL(Date_First_Reported_))),COUNT(__d3(__NN(Date_First_Reported_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','DateLastReported',COUNT(__d3(__NL(Date_Last_Reported_))),COUNT(__d3(__NN(Date_Last_Reported_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','DateLastUpdated',COUNT(__d3(__NL(Date_Last_Updated_))),COUNT(__d3(__NN(Date_Last_Updated_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','cleaned_license_number',COUNT(__d3(__NL(License_Number_))),COUNT(__d3(__NN(License_Number_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','business_flag',COUNT(__d3(__NL(License_Business_Flag_))),COUNT(__d3(__NN(License_Business_Flag_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','LicenseProfessionCode',COUNT(__d3(__NL(License_Profession_Code_))),COUNT(__d3(__NN(License_Profession_Code_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','profession_or_board',COUNT(__d3(__NL(License_Profession_Description_))),COUNT(__d3(__NN(License_Profession_Description_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','status',COUNT(__d3(__NL(License_Status_))),COUNT(__d3(__NN(License_Status_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','license_type',COUNT(__d3(__NL(License_Description_))),COUNT(__d3(__NN(License_Description_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','issue_date',COUNT(__d3(__NL(Original_Date_Of_Issuance_))),COUNT(__d3(__NN(Original_Date_Of_Issuance_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','CurrentDateOfIssuance',COUNT(__d3(__NL(Current_Date_Of_Issuance_))),COUNT(__d3(__NN(Current_Date_Of_Issuance_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','expiration_date',COUNT(__d3(__NL(Date_Of_Expiration_))),COUNT(__d3(__NN(Date_Of_Expiration_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','last_renewal_date',COUNT(__d3(__NL(Date_Of_License_Renewal_))),COUNT(__d3(__NN(Date_Of_License_Renewal_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','AffiliatedTypeCode',COUNT(__d3(__NL(Affiliated_Type_Code_))),COUNT(__d3(__NN(Affiliated_Type_Code_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','StartDate',COUNT(__d3(__NL(Start_Date_))),COUNT(__d3(__NN(Start_Date_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','category',COUNT(__d3(__NL(License_Category_))),COUNT(__d3(__NN(License_Category_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','occupation',COUNT(__d3(__NL(Occupation_))),COUNT(__d3(__NN(Occupation_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','did',COUNT(__d3(__NL(Lex_I_D_))),COUNT(__d3(__NN(Lex_I_D_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','HybridArchiveDate',COUNT(__d3(Hybrid_Archive_Date_=0)),COUNT(__d3(Hybrid_Archive_Date_!=0))},
    {'ProfessionalLicense','PublicRecords_KEL.Files.FCRA.Prof_LicenseV2__Key_Proflic_Did_Vault','VaultDateLastSeen',COUNT(__d3(Vault_Date_Last_Seen_=0)),COUNT(__d3(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
