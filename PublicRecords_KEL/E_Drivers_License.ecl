//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_Drivers_License(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Drivers_License_Number_;
    KEL.typ.nstr Issuing_State_;
    KEL.typ.nint Drivers_License_Sequence_;
    KEL.typ.nstr License_Class_;
    KEL.typ.nstr License_Type_;
    KEL.typ.nstr Moxie_License_Type_;
    KEL.typ.nstr Attention_;
    KEL.typ.nstr Attention_Code_;
    KEL.typ.nstr Restrictions_;
    KEL.typ.nstr Restrictions_Delimited_;
    KEL.typ.nkdate Original_Expiration_Date_;
    KEL.typ.nkdate Original_Issue_Date_;
    KEL.typ.nkdate Issue_Date_;
    KEL.typ.nkdate Expiration_Date_;
    KEL.typ.nkdate Active_Date_;
    KEL.typ.nkdate Inactive_Date_;
    KEL.typ.nstr Endorsement_;
    KEL.typ.nstr Motorcycle_Code_;
    KEL.typ.nint Driver_Education_Code_;
    KEL.typ.nint Duplicate_Count_;
    KEL.typ.nstr R_C_D_Stat_;
    KEL.typ.nstr O_O_S_Previous_Drivers_License_Number_;
    KEL.typ.nstr Previous_State_;
    KEL.typ.nstr Previous_Drivers_License_Number_;
    KEL.typ.nint Drivers_License_Key_Number_;
    KEL.typ.nstr Issuance_;
    KEL.typ.nstr C_D_L_Status_;
    KEL.typ.nstr County_;
    KEL.typ.nstr Address_Change_;
    KEL.typ.nstr Name_Change_;
    KEL.typ.nstr Date_Of_Birth_Change_;
    KEL.typ.nstr Sex_Change_;
    KEL.typ.nstr Height_;
    KEL.typ.nint Weight_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Code_;
    KEL.typ.nstr Sex_;
    KEL.typ.nstr Sex_Code_;
    KEL.typ.nstr Hair_Color_;
    KEL.typ.nstr Hair_Color_Code_;
    KEL.typ.nstr Eye_Color_;
    KEL.typ.nstr Eye_Color_Code_;
    KEL.typ.nstr State_Name_;
    KEL.typ.nstr History_Name_;
    KEL.typ.nstr History_;
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
  SHARED Active_Date_Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Inactive_Date_Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping := 'UID(DEFAULT:UID),driverslicensenumber(DEFAULT:Drivers_License_Number_:\'\'),issuingstate(DEFAULT:Issuing_State_:\'\'),dl_seq(DEFAULT:Drivers_License_Sequence_:0),licenseclass(DEFAULT:License_Class_:\'\'),licensetype(DEFAULT:License_Type_:\'\'),moxielicensetype(DEFAULT:Moxie_License_Type_:\'\'),attention(DEFAULT:Attention_:\'\'),attentioncode(DEFAULT:Attention_Code_:\'\'),restrictions(DEFAULT:Restrictions_:\'\'),restrictionsdelimited(DEFAULT:Restrictions_Delimited_:\'\'),originalexpirationdate(DEFAULT:Original_Expiration_Date_:DATE),originalissuedate(DEFAULT:Original_Issue_Date_:DATE),issuedate(DEFAULT:Issue_Date_:DATE),expirationdate(DEFAULT:Expiration_Date_:DATE),activedate(DEFAULT:Active_Date_:DATE:Active_Date_Rule),inactivedate(DEFAULT:Inactive_Date_:DATE:Inactive_Date_Rule),endorsement(DEFAULT:Endorsement_:\'\'),motorcyclecode(DEFAULT:Motorcycle_Code_:\'\'),drivereducationcode(DEFAULT:Driver_Education_Code_:0),duplicatecount(DEFAULT:Duplicate_Count_:0),rcdstat(DEFAULT:R_C_D_Stat_:\'\'),oospreviousdriverslicensenumber(DEFAULT:O_O_S_Previous_Drivers_License_Number_:\'\'),previousstate(DEFAULT:Previous_State_:\'\'),previousdriverslicensenumber(DEFAULT:Previous_Drivers_License_Number_:\'\'),driverslicensekeynumber(DEFAULT:Drivers_License_Key_Number_:0),issuance(DEFAULT:Issuance_:\'\'),cdlstatus(DEFAULT:C_D_L_Status_:\'\'),county(DEFAULT:County_:\'\'),addresschange(DEFAULT:Address_Change_:\'\'),namechange(DEFAULT:Name_Change_:\'\'),dateofbirthchange(DEFAULT:Date_Of_Birth_Change_:\'\'),sexchange(DEFAULT:Sex_Change_:\'\'),height(DEFAULT:Height_:\'\'),weight(DEFAULT:Weight_:0),race(DEFAULT:Race_:\'\'),racecode(DEFAULT:Race_Code_:\'\'),sex(DEFAULT:Sex_:\'\'),sexcode(DEFAULT:Sex_Code_:\'\'),haircolor(DEFAULT:Hair_Color_:\'\'),haircolorcode(DEFAULT:Hair_Color_Code_:\'\'),eyecolor(DEFAULT:Eye_Color_:\'\'),eyecolorcode(DEFAULT:Eye_Color_Code_:\'\'),statename(DEFAULT:State_Name_:\'\'),historyname(DEFAULT:History_Name_:\'\'),history(DEFAULT:History_:\'\'),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := __in.Dataset_DriversV2__Key_DL_DID(orig_state != '');
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.dl_number) + '|' + TRIM((STRING)LEFT.orig_state)));
  SHARED __d1_KELfiltered := __in.Dataset_DriversV2__Key_DL_Number(orig_state != '');
  SHARED __d1_Trim := PROJECT(__d1_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.dl_number) + '|' + TRIM((STRING)LEFT.orig_state)));
  SHARED __d2_KELfiltered := __in.Dataset_DriversV2__Key_DL_Number(orig_state != '');
  SHARED __d2_Trim := PROJECT(__d2_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.dl_number) + '|' + TRIM((STRING)LEFT.orig_state)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim + __d2_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'') + '|' + TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED Active_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Inactive_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'UID(DEFAULT:UID),dl_number(OVERRIDE:Drivers_License_Number_:\'\'),orig_state(OVERRIDE:Issuing_State_:\'\'),dl_seq(OVERRIDE:Drivers_License_Sequence_:0),license_class(OVERRIDE:License_Class_:\'\'),license_type(OVERRIDE:License_Type_:\'\'),moxie_license_type(OVERRIDE:Moxie_License_Type_:\'\'),attention_name(OVERRIDE:Attention_:\'\'),attention_flag(OVERRIDE:Attention_Code_:\'\'),restrictions(OVERRIDE:Restrictions_:\'\'),restrictions_delimited(OVERRIDE:Restrictions_Delimited_:\'\'),orig_expiration_date(OVERRIDE:Original_Expiration_Date_:DATE),orig_issue_date(OVERRIDE:Original_Issue_Date_:DATE),lic_issue_date(OVERRIDE:Issue_Date_:DATE),expiration_date(OVERRIDE:Expiration_Date_:DATE),active_date(OVERRIDE:Active_Date_:DATE:Active_Date_0Rule),inactive_date(OVERRIDE:Inactive_Date_:DATE:Inactive_Date_0Rule),lic_endorsement(OVERRIDE:Endorsement_:\'\'),motorcycle_code(OVERRIDE:Motorcycle_Code_:\'\'),driver_edu_code(OVERRIDE:Driver_Education_Code_:0),dup_lic_count(OVERRIDE:Duplicate_Count_:0),rcd_stat_flag(OVERRIDE:R_C_D_Stat_:\'\'),oos_previous_dl_number(OVERRIDE:O_O_S_Previous_Drivers_License_Number_:\'\'),oos_previous_st(OVERRIDE:Previous_State_:\'\'),old_dl_number(OVERRIDE:Previous_Drivers_License_Number_:\'\'),dl_key_number(OVERRIDE:Drivers_License_Key_Number_:0),issuance(OVERRIDE:Issuance_:\'\'),cdl_status(OVERRIDE:C_D_L_Status_:\'\'),county_name(OVERRIDE:County_:\'\'),address_change(OVERRIDE:Address_Change_:\'\'),name_change(OVERRIDE:Name_Change_:\'\'),dob_change(OVERRIDE:Date_Of_Birth_Change_:\'\'),sex_change(OVERRIDE:Sex_Change_:\'\'),height(OVERRIDE:Height_:\'\'),weight(OVERRIDE:Weight_:0),race_name(OVERRIDE:Race_:\'\'),race(OVERRIDE:Race_Code_:\'\'),sex_name(OVERRIDE:Sex_:\'\'),sex_flag(OVERRIDE:Sex_Code_:\'\'),hair_color_name(OVERRIDE:Hair_Color_:\'\'),haircolorcode(DEFAULT:Hair_Color_Code_:\'\'),eye_color_name(OVERRIDE:Eye_Color_:\'\'),eyecolorcode(DEFAULT:Eye_Color_Code_:\'\'),orig_state_name(OVERRIDE:State_Name_:\'\'),history_name(OVERRIDE:History_Name_:\'\'),history(OVERRIDE:History_:\'\'),source_code(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_DriversV2__Key_DL_DID,TRANSFORM(RECORDOF(__in.Dataset_DriversV2__Key_DL_DID),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_DriversV2__Key_DL_DID);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.dl_number) + '|' + TRIM((STRING)LEFT.orig_state) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_DID_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Active_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Inactive_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'UID(DEFAULT:UID),dl_number(OVERRIDE:Drivers_License_Number_:\'\'),orig_state(OVERRIDE:Issuing_State_:\'\'),dl_seq(OVERRIDE:Drivers_License_Sequence_:0),license_class(OVERRIDE:License_Class_:\'\'),license_type(OVERRIDE:License_Type_:\'\'),moxie_license_type(OVERRIDE:Moxie_License_Type_:\'\'),attention_name(OVERRIDE:Attention_:\'\'),attention_flag(OVERRIDE:Attention_Code_:\'\'),restrictions(OVERRIDE:Restrictions_:\'\'),restrictions_delimited(OVERRIDE:Restrictions_Delimited_:\'\'),orig_expiration_date(OVERRIDE:Original_Expiration_Date_:DATE),orig_issue_date(OVERRIDE:Original_Issue_Date_:DATE),lic_issue_date(OVERRIDE:Issue_Date_:DATE),expiration_date(OVERRIDE:Expiration_Date_:DATE),active_date(OVERRIDE:Active_Date_:DATE:Active_Date_1Rule),inactive_date(OVERRIDE:Inactive_Date_:DATE:Inactive_Date_1Rule),lic_endorsement(OVERRIDE:Endorsement_:\'\'),motorcycle_code(OVERRIDE:Motorcycle_Code_:\'\'),driver_edu_code(OVERRIDE:Driver_Education_Code_:0),dup_lic_count(OVERRIDE:Duplicate_Count_:0),rcd_stat_flag(OVERRIDE:R_C_D_Stat_:\'\'),oos_previous_dl_number(OVERRIDE:O_O_S_Previous_Drivers_License_Number_:\'\'),oos_previous_st(OVERRIDE:Previous_State_:\'\'),old_dl_number(OVERRIDE:Previous_Drivers_License_Number_:\'\'),dl_key_number(OVERRIDE:Drivers_License_Key_Number_:0),issuance(OVERRIDE:Issuance_:\'\'),cdl_status(OVERRIDE:C_D_L_Status_:\'\'),county_name(OVERRIDE:County_:\'\'),address_change(OVERRIDE:Address_Change_:\'\'),name_change(OVERRIDE:Name_Change_:\'\'),dob_change(OVERRIDE:Date_Of_Birth_Change_:\'\'),sex_change(OVERRIDE:Sex_Change_:\'\'),height(OVERRIDE:Height_:\'\'),weight(OVERRIDE:Weight_:0),race_name(OVERRIDE:Race_:\'\'),race(OVERRIDE:Race_Code_:\'\'),sex_name(OVERRIDE:Sex_:\'\'),sex_flag(OVERRIDE:Sex_Code_:\'\'),hair_color(OVERRIDE:Hair_Color_:\'\'),haircolorcode(DEFAULT:Hair_Color_Code_:\'\'),eye_color(OVERRIDE:Eye_Color_:\'\'),eyecolorcode(DEFAULT:Eye_Color_Code_:\'\'),orig_state_name(OVERRIDE:State_Name_:\'\'),history_name(OVERRIDE:History_Name_:\'\'),history(OVERRIDE:History_:\'\'),source_code(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_DriversV2__Key_DL_Number,TRANSFORM(RECORDOF(__in.Dataset_DriversV2__Key_DL_Number),SELF:=RIGHT));
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_DriversV2__Key_DL_Number);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_KELfiltered,Lookup,TRIM((STRING)LEFT.dl_number) + '|' + TRIM((STRING)LEFT.orig_state) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_Number_1_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Active_Date_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Inactive_Date_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping2 := 'UID(DEFAULT:UID),dl_number(OVERRIDE:Drivers_License_Number_:\'\'),orig_state(OVERRIDE:Issuing_State_:\'\'),dl_seq(DEFAULT:Drivers_License_Sequence_:0),licenseclass(DEFAULT:License_Class_:\'\'),licensetype(DEFAULT:License_Type_:\'\'),moxielicensetype(DEFAULT:Moxie_License_Type_:\'\'),attention(DEFAULT:Attention_:\'\'),attentioncode(DEFAULT:Attention_Code_:\'\'),restrictions(DEFAULT:Restrictions_:\'\'),restrictionsdelimited(DEFAULT:Restrictions_Delimited_:\'\'),originalexpirationdate(DEFAULT:Original_Expiration_Date_:DATE),originalissuedate(DEFAULT:Original_Issue_Date_:DATE),issuedate(DEFAULT:Issue_Date_:DATE),expirationdate(DEFAULT:Expiration_Date_:DATE),activedate(DEFAULT:Active_Date_:DATE:Active_Date_2Rule),inactivedate(DEFAULT:Inactive_Date_:DATE:Inactive_Date_2Rule),endorsement(DEFAULT:Endorsement_:\'\'),motorcyclecode(DEFAULT:Motorcycle_Code_:\'\'),drivereducationcode(DEFAULT:Driver_Education_Code_:0),duplicatecount(DEFAULT:Duplicate_Count_:0),rcdstat(DEFAULT:R_C_D_Stat_:\'\'),oospreviousdriverslicensenumber(DEFAULT:O_O_S_Previous_Drivers_License_Number_:\'\'),previousstate(DEFAULT:Previous_State_:\'\'),previousdriverslicensenumber(DEFAULT:Previous_Drivers_License_Number_:\'\'),driverslicensekeynumber(DEFAULT:Drivers_License_Key_Number_:0),issuance(DEFAULT:Issuance_:\'\'),cdlstatus(DEFAULT:C_D_L_Status_:\'\'),county(DEFAULT:County_:\'\'),addresschange(DEFAULT:Address_Change_:\'\'),namechange(DEFAULT:Name_Change_:\'\'),dateofbirthchange(DEFAULT:Date_Of_Birth_Change_:\'\'),sexchange(DEFAULT:Sex_Change_:\'\'),height(DEFAULT:Height_:\'\'),weight(DEFAULT:Weight_:0),race(DEFAULT:Race_:\'\'),racecode(DEFAULT:Race_Code_:\'\'),sex(DEFAULT:Sex_:\'\'),sexcode(DEFAULT:Sex_Code_:\'\'),hair_color_name(OVERRIDE:Hair_Color_:\'\'),haircolorcode(DEFAULT:Hair_Color_Code_:\'\'),eye_color_name(OVERRIDE:Eye_Color_:\'\'),eyecolorcode(DEFAULT:Eye_Color_Code_:\'\'),statename(DEFAULT:State_Name_:\'\'),historyname(DEFAULT:History_Name_:\'\'),history(DEFAULT:History_:\'\'),source(DEFAULT:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_2Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_DriversV2__Key_DL_Number,TRANSFORM(RECORDOF(__in.Dataset_DriversV2__Key_DL_Number),SELF:=RIGHT));
  SHARED __d2_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_DriversV2__Key_DL_Number);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d2_UID_Mapped := JOIN(__d2_KELfiltered,Lookup,TRIM((STRING)LEFT.dl_number) + '|' + TRIM((STRING)LEFT.orig_state) = RIGHT.KeyVal,TRANSFORM(__d2_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_Number_2_Invalid := __d2_UID_Mapped(UID = 0);
  SHARED __d2_Prefiltered := __d2_UID_Mapped(UID <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1 + __d2;
  EXPORT Previous_Layout := RECORD
    KEL.typ.nstr O_O_S_Previous_Drivers_License_Number_;
    KEL.typ.nstr Previous_State_;
    KEL.typ.nint Drivers_License_Key_Number_;
    KEL.typ.nstr Previous_Drivers_License_Number_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Change_Layout := RECORD
    KEL.typ.nstr Address_Change_;
    KEL.typ.nstr Name_Change_;
    KEL.typ.nstr Date_Of_Birth_Change_;
    KEL.typ.nstr Sex_Change_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Person_Info_Layout := RECORD
    KEL.typ.nstr Height_;
    KEL.typ.nint Weight_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Code_;
    KEL.typ.nstr Sex_;
    KEL.typ.nstr Sex_Code_;
    KEL.typ.nstr Hair_Color_;
    KEL.typ.nstr Hair_Color_Code_;
    KEL.typ.nstr Eye_Color_;
    KEL.typ.nstr Eye_Color_Code_;
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
    KEL.typ.nstr Drivers_License_Number_;
    KEL.typ.nstr Issuing_State_;
    KEL.typ.nstr State_Name_;
    KEL.typ.nint Drivers_License_Sequence_;
    KEL.typ.nstr License_Class_;
    KEL.typ.nstr License_Type_;
    KEL.typ.nstr Moxie_License_Type_;
    KEL.typ.nstr Attention_;
    KEL.typ.nstr Attention_Code_;
    KEL.typ.nstr Restrictions_;
    KEL.typ.nstr Restrictions_Delimited_;
    KEL.typ.nkdate Original_Expiration_Date_;
    KEL.typ.nkdate Original_Issue_Date_;
    KEL.typ.nkdate Issue_Date_;
    KEL.typ.nkdate Expiration_Date_;
    KEL.typ.nkdate Active_Date_;
    KEL.typ.nkdate Inactive_Date_;
    KEL.typ.nstr Endorsement_;
    KEL.typ.nstr Motorcycle_Code_;
    KEL.typ.nint Driver_Education_Code_;
    KEL.typ.nint Duplicate_Count_;
    KEL.typ.nstr R_C_D_Stat_;
    KEL.typ.nstr Issuance_;
    KEL.typ.nstr C_D_L_Status_;
    KEL.typ.nstr County_;
    KEL.typ.ndataset(Previous_Layout) Previous_;
    KEL.typ.ndataset(Change_Layout) Change_;
    KEL.typ.ndataset(Person_Info_Layout) Person_Info_;
    KEL.typ.nstr History_Name_;
    KEL.typ.nstr History_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Drivers_License_Group := __PostFilter;
  Layout Drivers_License__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Drivers_License_Number_ := KEL.Intake.SingleValue(__recs,Drivers_License_Number_);
    SELF.Issuing_State_ := KEL.Intake.SingleValue(__recs,Issuing_State_);
    SELF.State_Name_ := KEL.Intake.SingleValue(__recs,State_Name_);
    SELF.Drivers_License_Sequence_ := KEL.Intake.SingleValue(__recs,Drivers_License_Sequence_);
    SELF.License_Class_ := KEL.Intake.SingleValue(__recs,License_Class_);
    SELF.License_Type_ := KEL.Intake.SingleValue(__recs,License_Type_);
    SELF.Moxie_License_Type_ := KEL.Intake.SingleValue(__recs,Moxie_License_Type_);
    SELF.Attention_ := KEL.Intake.SingleValue(__recs,Attention_);
    SELF.Attention_Code_ := KEL.Intake.SingleValue(__recs,Attention_Code_);
    SELF.Restrictions_ := KEL.Intake.SingleValue(__recs,Restrictions_);
    SELF.Restrictions_Delimited_ := KEL.Intake.SingleValue(__recs,Restrictions_Delimited_);
    SELF.Original_Expiration_Date_ := KEL.Intake.SingleValue(__recs,Original_Expiration_Date_);
    SELF.Original_Issue_Date_ := KEL.Intake.SingleValue(__recs,Original_Issue_Date_);
    SELF.Issue_Date_ := KEL.Intake.SingleValue(__recs,Issue_Date_);
    SELF.Expiration_Date_ := KEL.Intake.SingleValue(__recs,Expiration_Date_);
    SELF.Active_Date_ := KEL.Intake.SingleValue(__recs,Active_Date_);
    SELF.Inactive_Date_ := KEL.Intake.SingleValue(__recs,Inactive_Date_);
    SELF.Endorsement_ := KEL.Intake.SingleValue(__recs,Endorsement_);
    SELF.Motorcycle_Code_ := KEL.Intake.SingleValue(__recs,Motorcycle_Code_);
    SELF.Driver_Education_Code_ := KEL.Intake.SingleValue(__recs,Driver_Education_Code_);
    SELF.Duplicate_Count_ := KEL.Intake.SingleValue(__recs,Duplicate_Count_);
    SELF.R_C_D_Stat_ := KEL.Intake.SingleValue(__recs,R_C_D_Stat_);
    SELF.Issuance_ := KEL.Intake.SingleValue(__recs,Issuance_);
    SELF.C_D_L_Status_ := KEL.Intake.SingleValue(__recs,C_D_L_Status_);
    SELF.County_ := KEL.Intake.SingleValue(__recs,County_);
    SELF.Previous_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),O_O_S_Previous_Drivers_License_Number_,Previous_State_,Drivers_License_Key_Number_,Previous_Drivers_License_Number_},O_O_S_Previous_Drivers_License_Number_,Previous_State_,Drivers_License_Key_Number_,Previous_Drivers_License_Number_),Previous_Layout)(__NN(O_O_S_Previous_Drivers_License_Number_) OR __NN(Previous_State_) OR __NN(Drivers_License_Key_Number_) OR __NN(Previous_Drivers_License_Number_)));
    SELF.Change_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Address_Change_,Name_Change_,Date_Of_Birth_Change_,Sex_Change_},Address_Change_,Name_Change_,Date_Of_Birth_Change_,Sex_Change_),Change_Layout)(__NN(Address_Change_) OR __NN(Name_Change_) OR __NN(Date_Of_Birth_Change_) OR __NN(Sex_Change_)));
    SELF.Person_Info_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Height_,Weight_,Race_,Race_Code_,Sex_,Sex_Code_,Hair_Color_,Hair_Color_Code_,Eye_Color_,Eye_Color_Code_},Height_,Weight_,Race_,Race_Code_,Sex_,Sex_Code_,Hair_Color_,Hair_Color_Code_,Eye_Color_,Eye_Color_Code_),Person_Info_Layout)(__NN(Height_) OR __NN(Weight_) OR __NN(Race_) OR __NN(Race_Code_) OR __NN(Sex_) OR __NN(Sex_Code_) OR __NN(Hair_Color_) OR __NN(Hair_Color_Code_) OR __NN(Eye_Color_) OR __NN(Eye_Color_Code_)));
    SELF.History_Name_ := KEL.Intake.SingleValue(__recs,History_Name_);
    SELF.History_ := KEL.Intake.SingleValue(__recs,History_);
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Drivers_License__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Previous_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Previous_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(O_O_S_Previous_Drivers_License_Number_) OR __NN(Previous_State_) OR __NN(Drivers_License_Key_Number_) OR __NN(Previous_Drivers_License_Number_)));
    SELF.Change_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Change_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Address_Change_) OR __NN(Name_Change_) OR __NN(Date_Of_Birth_Change_) OR __NN(Sex_Change_)));
    SELF.Person_Info_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Person_Info_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Height_) OR __NN(Weight_) OR __NN(Race_) OR __NN(Race_Code_) OR __NN(Sex_) OR __NN(Sex_Code_) OR __NN(Hair_Color_) OR __NN(Hair_Color_Code_) OR __NN(Eye_Color_) OR __NN(Eye_Color_Code_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Drivers_License_Group,COUNT(ROWS(LEFT))=1),GROUP,Drivers_License__Single_Rollup(LEFT)) + ROLLUP(HAVING(Drivers_License_Group,COUNT(ROWS(LEFT))>1),GROUP,Drivers_License__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Drivers_License_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Drivers_License_Number_);
  EXPORT Issuing_State__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Issuing_State_);
  EXPORT State_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,State_Name_);
  EXPORT Drivers_License_Sequence__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Drivers_License_Sequence_);
  EXPORT License_Class__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,License_Class_);
  EXPORT License_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,License_Type_);
  EXPORT Moxie_License_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Moxie_License_Type_);
  EXPORT Attention__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Attention_);
  EXPORT Attention_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Attention_Code_);
  EXPORT Restrictions__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Restrictions_);
  EXPORT Restrictions_Delimited__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Restrictions_Delimited_);
  EXPORT Original_Expiration_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Original_Expiration_Date_);
  EXPORT Original_Issue_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Original_Issue_Date_);
  EXPORT Issue_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Issue_Date_);
  EXPORT Expiration_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Expiration_Date_);
  EXPORT Active_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Active_Date_);
  EXPORT Inactive_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Inactive_Date_);
  EXPORT Endorsement__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Endorsement_);
  EXPORT Motorcycle_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Motorcycle_Code_);
  EXPORT Driver_Education_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Driver_Education_Code_);
  EXPORT Duplicate_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Duplicate_Count_);
  EXPORT R_C_D_Stat__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,R_C_D_Stat_);
  EXPORT Issuance__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Issuance_);
  EXPORT C_D_L_Status__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,C_D_L_Status_);
  EXPORT County__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,County_);
  EXPORT History_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,History_Name_);
  EXPORT History__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,History_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_DID_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_Number_1_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_Number_2_Invalid),COUNT(Drivers_License_Number__SingleValue_Invalid),COUNT(Issuing_State__SingleValue_Invalid),COUNT(State_Name__SingleValue_Invalid),COUNT(Drivers_License_Sequence__SingleValue_Invalid),COUNT(License_Class__SingleValue_Invalid),COUNT(License_Type__SingleValue_Invalid),COUNT(Moxie_License_Type__SingleValue_Invalid),COUNT(Attention__SingleValue_Invalid),COUNT(Attention_Code__SingleValue_Invalid),COUNT(Restrictions__SingleValue_Invalid),COUNT(Restrictions_Delimited__SingleValue_Invalid),COUNT(Original_Expiration_Date__SingleValue_Invalid),COUNT(Original_Issue_Date__SingleValue_Invalid),COUNT(Issue_Date__SingleValue_Invalid),COUNT(Expiration_Date__SingleValue_Invalid),COUNT(Active_Date__SingleValue_Invalid),COUNT(Inactive_Date__SingleValue_Invalid),COUNT(Endorsement__SingleValue_Invalid),COUNT(Motorcycle_Code__SingleValue_Invalid),COUNT(Driver_Education_Code__SingleValue_Invalid),COUNT(Duplicate_Count__SingleValue_Invalid),COUNT(R_C_D_Stat__SingleValue_Invalid),COUNT(Issuance__SingleValue_Invalid),COUNT(C_D_L_Status__SingleValue_Invalid),COUNT(County__SingleValue_Invalid),COUNT(History_Name__SingleValue_Invalid),COUNT(History__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_DID_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_Number_1_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_Number_2_Invalid,KEL.typ.int Drivers_License_Number__SingleValue_Invalid,KEL.typ.int Issuing_State__SingleValue_Invalid,KEL.typ.int State_Name__SingleValue_Invalid,KEL.typ.int Drivers_License_Sequence__SingleValue_Invalid,KEL.typ.int License_Class__SingleValue_Invalid,KEL.typ.int License_Type__SingleValue_Invalid,KEL.typ.int Moxie_License_Type__SingleValue_Invalid,KEL.typ.int Attention__SingleValue_Invalid,KEL.typ.int Attention_Code__SingleValue_Invalid,KEL.typ.int Restrictions__SingleValue_Invalid,KEL.typ.int Restrictions_Delimited__SingleValue_Invalid,KEL.typ.int Original_Expiration_Date__SingleValue_Invalid,KEL.typ.int Original_Issue_Date__SingleValue_Invalid,KEL.typ.int Issue_Date__SingleValue_Invalid,KEL.typ.int Expiration_Date__SingleValue_Invalid,KEL.typ.int Active_Date__SingleValue_Invalid,KEL.typ.int Inactive_Date__SingleValue_Invalid,KEL.typ.int Endorsement__SingleValue_Invalid,KEL.typ.int Motorcycle_Code__SingleValue_Invalid,KEL.typ.int Driver_Education_Code__SingleValue_Invalid,KEL.typ.int Duplicate_Count__SingleValue_Invalid,KEL.typ.int R_C_D_Stat__SingleValue_Invalid,KEL.typ.int Issuance__SingleValue_Invalid,KEL.typ.int C_D_L_Status__SingleValue_Invalid,KEL.typ.int County__SingleValue_Invalid,KEL.typ.int History_Name__SingleValue_Invalid,KEL.typ.int History__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_DID_Invalid),COUNT(__d0)},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dl_number',COUNT(__d0(__NL(Drivers_License_Number_))),COUNT(__d0(__NN(Drivers_License_Number_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_state',COUNT(__d0(__NL(Issuing_State_))),COUNT(__d0(__NN(Issuing_State_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dl_seq',COUNT(__d0(__NL(Drivers_License_Sequence_))),COUNT(__d0(__NN(Drivers_License_Sequence_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','license_class',COUNT(__d0(__NL(License_Class_))),COUNT(__d0(__NN(License_Class_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','license_type',COUNT(__d0(__NL(License_Type_))),COUNT(__d0(__NN(License_Type_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','moxie_license_type',COUNT(__d0(__NL(Moxie_License_Type_))),COUNT(__d0(__NN(Moxie_License_Type_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','attention_name',COUNT(__d0(__NL(Attention_))),COUNT(__d0(__NN(Attention_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','attention_flag',COUNT(__d0(__NL(Attention_Code_))),COUNT(__d0(__NN(Attention_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','restrictions',COUNT(__d0(__NL(Restrictions_))),COUNT(__d0(__NN(Restrictions_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','restrictions_delimited',COUNT(__d0(__NL(Restrictions_Delimited_))),COUNT(__d0(__NN(Restrictions_Delimited_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_expiration_date',COUNT(__d0(__NL(Original_Expiration_Date_))),COUNT(__d0(__NN(Original_Expiration_Date_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_issue_date',COUNT(__d0(__NL(Original_Issue_Date_))),COUNT(__d0(__NN(Original_Issue_Date_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lic_issue_date',COUNT(__d0(__NL(Issue_Date_))),COUNT(__d0(__NN(Issue_Date_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','expiration_date',COUNT(__d0(__NL(Expiration_Date_))),COUNT(__d0(__NN(Expiration_Date_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','active_date',COUNT(__d0(__NL(Active_Date_))),COUNT(__d0(__NN(Active_Date_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','inactive_date',COUNT(__d0(__NL(Inactive_Date_))),COUNT(__d0(__NN(Inactive_Date_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lic_endorsement',COUNT(__d0(__NL(Endorsement_))),COUNT(__d0(__NN(Endorsement_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','motorcycle_code',COUNT(__d0(__NL(Motorcycle_Code_))),COUNT(__d0(__NN(Motorcycle_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','driver_edu_code',COUNT(__d0(__NL(Driver_Education_Code_))),COUNT(__d0(__NN(Driver_Education_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dup_lic_count',COUNT(__d0(__NL(Duplicate_Count_))),COUNT(__d0(__NN(Duplicate_Count_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rcd_stat_flag',COUNT(__d0(__NL(R_C_D_Stat_))),COUNT(__d0(__NN(R_C_D_Stat_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','oos_previous_dl_number',COUNT(__d0(__NL(O_O_S_Previous_Drivers_License_Number_))),COUNT(__d0(__NN(O_O_S_Previous_Drivers_License_Number_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','oos_previous_st',COUNT(__d0(__NL(Previous_State_))),COUNT(__d0(__NN(Previous_State_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','old_dl_number',COUNT(__d0(__NL(Previous_Drivers_License_Number_))),COUNT(__d0(__NN(Previous_Drivers_License_Number_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dl_key_number',COUNT(__d0(__NL(Drivers_License_Key_Number_))),COUNT(__d0(__NN(Drivers_License_Key_Number_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','issuance',COUNT(__d0(__NL(Issuance_))),COUNT(__d0(__NN(Issuance_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cdl_status',COUNT(__d0(__NL(C_D_L_Status_))),COUNT(__d0(__NN(C_D_L_Status_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','county_name',COUNT(__d0(__NL(County_))),COUNT(__d0(__NN(County_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','address_change',COUNT(__d0(__NL(Address_Change_))),COUNT(__d0(__NN(Address_Change_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_change',COUNT(__d0(__NL(Name_Change_))),COUNT(__d0(__NN(Name_Change_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob_change',COUNT(__d0(__NL(Date_Of_Birth_Change_))),COUNT(__d0(__NN(Date_Of_Birth_Change_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sex_change',COUNT(__d0(__NL(Sex_Change_))),COUNT(__d0(__NN(Sex_Change_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','height',COUNT(__d0(__NL(Height_))),COUNT(__d0(__NN(Height_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','weight',COUNT(__d0(__NL(Weight_))),COUNT(__d0(__NN(Weight_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','race_name',COUNT(__d0(__NL(Race_))),COUNT(__d0(__NN(Race_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','race',COUNT(__d0(__NL(Race_Code_))),COUNT(__d0(__NN(Race_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sex_name',COUNT(__d0(__NL(Sex_))),COUNT(__d0(__NN(Sex_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sex_flag',COUNT(__d0(__NL(Sex_Code_))),COUNT(__d0(__NN(Sex_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','hair_color_name',COUNT(__d0(__NL(Hair_Color_))),COUNT(__d0(__NN(Hair_Color_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HairColorCode',COUNT(__d0(__NL(Hair_Color_Code_))),COUNT(__d0(__NN(Hair_Color_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','eye_color_name',COUNT(__d0(__NL(Eye_Color_))),COUNT(__d0(__NN(Eye_Color_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EyeColorCode',COUNT(__d0(__NL(Eye_Color_Code_))),COUNT(__d0(__NN(Eye_Color_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_state_name',COUNT(__d0(__NL(State_Name_))),COUNT(__d0(__NN(State_Name_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','history_name',COUNT(__d0(__NL(History_Name_))),COUNT(__d0(__NN(History_Name_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','history',COUNT(__d0(__NL(History_))),COUNT(__d0(__NN(History_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source_code',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_Number_1_Invalid),COUNT(__d1)},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dl_number',COUNT(__d1(__NL(Drivers_License_Number_))),COUNT(__d1(__NN(Drivers_License_Number_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_state',COUNT(__d1(__NL(Issuing_State_))),COUNT(__d1(__NN(Issuing_State_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dl_seq',COUNT(__d1(__NL(Drivers_License_Sequence_))),COUNT(__d1(__NN(Drivers_License_Sequence_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','license_class',COUNT(__d1(__NL(License_Class_))),COUNT(__d1(__NN(License_Class_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','license_type',COUNT(__d1(__NL(License_Type_))),COUNT(__d1(__NN(License_Type_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','moxie_license_type',COUNT(__d1(__NL(Moxie_License_Type_))),COUNT(__d1(__NN(Moxie_License_Type_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','attention_name',COUNT(__d1(__NL(Attention_))),COUNT(__d1(__NN(Attention_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','attention_flag',COUNT(__d1(__NL(Attention_Code_))),COUNT(__d1(__NN(Attention_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','restrictions',COUNT(__d1(__NL(Restrictions_))),COUNT(__d1(__NN(Restrictions_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','restrictions_delimited',COUNT(__d1(__NL(Restrictions_Delimited_))),COUNT(__d1(__NN(Restrictions_Delimited_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_expiration_date',COUNT(__d1(__NL(Original_Expiration_Date_))),COUNT(__d1(__NN(Original_Expiration_Date_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_issue_date',COUNT(__d1(__NL(Original_Issue_Date_))),COUNT(__d1(__NN(Original_Issue_Date_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lic_issue_date',COUNT(__d1(__NL(Issue_Date_))),COUNT(__d1(__NN(Issue_Date_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','expiration_date',COUNT(__d1(__NL(Expiration_Date_))),COUNT(__d1(__NN(Expiration_Date_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','active_date',COUNT(__d1(__NL(Active_Date_))),COUNT(__d1(__NN(Active_Date_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','inactive_date',COUNT(__d1(__NL(Inactive_Date_))),COUNT(__d1(__NN(Inactive_Date_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lic_endorsement',COUNT(__d1(__NL(Endorsement_))),COUNT(__d1(__NN(Endorsement_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','motorcycle_code',COUNT(__d1(__NL(Motorcycle_Code_))),COUNT(__d1(__NN(Motorcycle_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','driver_edu_code',COUNT(__d1(__NL(Driver_Education_Code_))),COUNT(__d1(__NN(Driver_Education_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dup_lic_count',COUNT(__d1(__NL(Duplicate_Count_))),COUNT(__d1(__NN(Duplicate_Count_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rcd_stat_flag',COUNT(__d1(__NL(R_C_D_Stat_))),COUNT(__d1(__NN(R_C_D_Stat_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','oos_previous_dl_number',COUNT(__d1(__NL(O_O_S_Previous_Drivers_License_Number_))),COUNT(__d1(__NN(O_O_S_Previous_Drivers_License_Number_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','oos_previous_st',COUNT(__d1(__NL(Previous_State_))),COUNT(__d1(__NN(Previous_State_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','old_dl_number',COUNT(__d1(__NL(Previous_Drivers_License_Number_))),COUNT(__d1(__NN(Previous_Drivers_License_Number_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dl_key_number',COUNT(__d1(__NL(Drivers_License_Key_Number_))),COUNT(__d1(__NN(Drivers_License_Key_Number_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','issuance',COUNT(__d1(__NL(Issuance_))),COUNT(__d1(__NN(Issuance_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cdl_status',COUNT(__d1(__NL(C_D_L_Status_))),COUNT(__d1(__NN(C_D_L_Status_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','county_name',COUNT(__d1(__NL(County_))),COUNT(__d1(__NN(County_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','address_change',COUNT(__d1(__NL(Address_Change_))),COUNT(__d1(__NN(Address_Change_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_change',COUNT(__d1(__NL(Name_Change_))),COUNT(__d1(__NN(Name_Change_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob_change',COUNT(__d1(__NL(Date_Of_Birth_Change_))),COUNT(__d1(__NN(Date_Of_Birth_Change_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sex_change',COUNT(__d1(__NL(Sex_Change_))),COUNT(__d1(__NN(Sex_Change_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','height',COUNT(__d1(__NL(Height_))),COUNT(__d1(__NN(Height_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','weight',COUNT(__d1(__NL(Weight_))),COUNT(__d1(__NN(Weight_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','race_name',COUNT(__d1(__NL(Race_))),COUNT(__d1(__NN(Race_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','race',COUNT(__d1(__NL(Race_Code_))),COUNT(__d1(__NN(Race_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sex_name',COUNT(__d1(__NL(Sex_))),COUNT(__d1(__NN(Sex_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sex_flag',COUNT(__d1(__NL(Sex_Code_))),COUNT(__d1(__NN(Sex_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','hair_color',COUNT(__d1(__NL(Hair_Color_))),COUNT(__d1(__NN(Hair_Color_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HairColorCode',COUNT(__d1(__NL(Hair_Color_Code_))),COUNT(__d1(__NN(Hair_Color_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','eye_color',COUNT(__d1(__NL(Eye_Color_))),COUNT(__d1(__NN(Eye_Color_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EyeColorCode',COUNT(__d1(__NL(Eye_Color_Code_))),COUNT(__d1(__NN(Eye_Color_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_state_name',COUNT(__d1(__NL(State_Name_))),COUNT(__d1(__NN(State_Name_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','history_name',COUNT(__d1(__NL(History_Name_))),COUNT(__d1(__NN(History_Name_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','history',COUNT(__d1(__NL(History_))),COUNT(__d1(__NN(History_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source_code',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_Number_2_Invalid),COUNT(__d2)},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dl_number',COUNT(__d2(__NL(Drivers_License_Number_))),COUNT(__d2(__NN(Drivers_License_Number_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_state',COUNT(__d2(__NL(Issuing_State_))),COUNT(__d2(__NN(Issuing_State_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dl_seq',COUNT(__d2(__NL(Drivers_License_Sequence_))),COUNT(__d2(__NN(Drivers_License_Sequence_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseClass',COUNT(__d2(__NL(License_Class_))),COUNT(__d2(__NN(License_Class_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseType',COUNT(__d2(__NL(License_Type_))),COUNT(__d2(__NN(License_Type_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MoxieLicenseType',COUNT(__d2(__NL(Moxie_License_Type_))),COUNT(__d2(__NN(Moxie_License_Type_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Attention',COUNT(__d2(__NL(Attention_))),COUNT(__d2(__NN(Attention_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AttentionCode',COUNT(__d2(__NL(Attention_Code_))),COUNT(__d2(__NN(Attention_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Restrictions',COUNT(__d2(__NL(Restrictions_))),COUNT(__d2(__NN(Restrictions_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RestrictionsDelimited',COUNT(__d2(__NL(Restrictions_Delimited_))),COUNT(__d2(__NN(Restrictions_Delimited_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalExpirationDate',COUNT(__d2(__NL(Original_Expiration_Date_))),COUNT(__d2(__NN(Original_Expiration_Date_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalIssueDate',COUNT(__d2(__NL(Original_Issue_Date_))),COUNT(__d2(__NN(Original_Issue_Date_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IssueDate',COUNT(__d2(__NL(Issue_Date_))),COUNT(__d2(__NN(Issue_Date_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExpirationDate',COUNT(__d2(__NL(Expiration_Date_))),COUNT(__d2(__NN(Expiration_Date_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActiveDate',COUNT(__d2(__NL(Active_Date_))),COUNT(__d2(__NN(Active_Date_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InactiveDate',COUNT(__d2(__NL(Inactive_Date_))),COUNT(__d2(__NN(Inactive_Date_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Endorsement',COUNT(__d2(__NL(Endorsement_))),COUNT(__d2(__NN(Endorsement_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MotorcycleCode',COUNT(__d2(__NL(Motorcycle_Code_))),COUNT(__d2(__NN(Motorcycle_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DriverEducationCode',COUNT(__d2(__NL(Driver_Education_Code_))),COUNT(__d2(__NN(Driver_Education_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DuplicateCount',COUNT(__d2(__NL(Duplicate_Count_))),COUNT(__d2(__NN(Duplicate_Count_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RCDStat',COUNT(__d2(__NL(R_C_D_Stat_))),COUNT(__d2(__NN(R_C_D_Stat_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OOSPreviousDriversLicenseNumber',COUNT(__d2(__NL(O_O_S_Previous_Drivers_License_Number_))),COUNT(__d2(__NN(O_O_S_Previous_Drivers_License_Number_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PreviousState',COUNT(__d2(__NL(Previous_State_))),COUNT(__d2(__NN(Previous_State_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PreviousDriversLicenseNumber',COUNT(__d2(__NL(Previous_Drivers_License_Number_))),COUNT(__d2(__NN(Previous_Drivers_License_Number_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DriversLicenseKeyNumber',COUNT(__d2(__NL(Drivers_License_Key_Number_))),COUNT(__d2(__NN(Drivers_License_Key_Number_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Issuance',COUNT(__d2(__NL(Issuance_))),COUNT(__d2(__NN(Issuance_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CDLStatus',COUNT(__d2(__NL(C_D_L_Status_))),COUNT(__d2(__NN(C_D_L_Status_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','County',COUNT(__d2(__NL(County_))),COUNT(__d2(__NN(County_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressChange',COUNT(__d2(__NL(Address_Change_))),COUNT(__d2(__NN(Address_Change_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameChange',COUNT(__d2(__NL(Name_Change_))),COUNT(__d2(__NN(Name_Change_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthChange',COUNT(__d2(__NL(Date_Of_Birth_Change_))),COUNT(__d2(__NN(Date_Of_Birth_Change_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SexChange',COUNT(__d2(__NL(Sex_Change_))),COUNT(__d2(__NN(Sex_Change_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Height',COUNT(__d2(__NL(Height_))),COUNT(__d2(__NN(Height_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Weight',COUNT(__d2(__NL(Weight_))),COUNT(__d2(__NN(Weight_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d2(__NL(Race_))),COUNT(__d2(__NN(Race_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceCode',COUNT(__d2(__NL(Race_Code_))),COUNT(__d2(__NN(Race_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Sex',COUNT(__d2(__NL(Sex_))),COUNT(__d2(__NN(Sex_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SexCode',COUNT(__d2(__NL(Sex_Code_))),COUNT(__d2(__NN(Sex_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','hair_color_name',COUNT(__d2(__NL(Hair_Color_))),COUNT(__d2(__NN(Hair_Color_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HairColorCode',COUNT(__d2(__NL(Hair_Color_Code_))),COUNT(__d2(__NN(Hair_Color_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','eye_color_name',COUNT(__d2(__NL(Eye_Color_))),COUNT(__d2(__NN(Eye_Color_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EyeColorCode',COUNT(__d2(__NL(Eye_Color_Code_))),COUNT(__d2(__NN(Eye_Color_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StateName',COUNT(__d2(__NL(State_Name_))),COUNT(__d2(__NN(State_Name_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HistoryName',COUNT(__d2(__NL(History_Name_))),COUNT(__d2(__NN(History_Name_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','History',COUNT(__d2(__NL(History_))),COUNT(__d2(__NN(History_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
