//HPCC Systems KEL Compiler Version 1.3.0
IMPORT KEL13 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT E_Phone(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.nstr Listing_Type_;
    KEL.typ.nstr Publish_Code_;
    KEL.typ.nint Portability_Indicator_;
    KEL.typ.nint N_X_X_Type_;
    KEL.typ.nstr C_O_C_Type_;
    KEL.typ.nstr S_C_C_;
    KEL.typ.nint Ported_Match_;
    KEL.typ.nstr Phone_Use_;
    KEL.typ.nint Phone_Number_Company_Type_;
    KEL.typ.nstr Prior_Area_Code_;
    KEL.typ.nstr Is_Active_;
    KEL.typ.nstr Carrier_Name_;
    KEL.typ.nint Confidence_Score_;
    KEL.typ.nstr No_Solicit_Code_;
    KEL.typ.nint Maximum_Confidence_Score_;
    KEL.typ.nint Minimum_Confidence_Score_;
    KEL.typ.nstr Omit_Indicator_;
    KEL.typ.nstr Current_Flag_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nint Source_File_;
    KEL.typ.nint Iver_Indicator_;
    KEL.typ.nstr Phone_Type_;
    KEL.typ.nstr Validation_Flag_;
    KEL.typ.nstr Validation_Date_;
    KEL.typ.nint High_Risk_S_I_C_;
    KEL.typ.nint High_Risk_N_A_I_C_S_;
    KEL.typ.nstr Source_;
    KEL.typ.nstr Original_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    DATA57 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'phone10(DEFAULT:UID|DEFAULT:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),source(DEFAULT:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatefirstseen(DEFAULT:Vault_Date_First_Seen_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'phone10(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listing_type(OVERRIDE:Listing_Type_:\'\'),publish_code(OVERRIDE:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),prior_area_code(OVERRIDE:Prior_Area_Code_:\'\'),current_record_flag(OVERRIDE:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omit_phone(OVERRIDE:Omit_Indicator_:\'\'),current_flag(OVERRIDE:Current_Flag_:\'\'),business_flag(OVERRIDE:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatefirstseen(DEFAULT:Vault_Date_First_Seen_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Gong__Key_History_Phone,TRANSFORM(RECORDOF(__in.Dataset_Gong__Key_History_Phone),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((UNSIGNED)phone10 != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_Phone_Invalid := __d0_KELfiltered((KEL.typ.uid)phone10 = 0);
  SHARED __d0_Prefiltered := __d0_KELfiltered((KEL.typ.uid)phone10 <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'phone_number(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validation_flag(OVERRIDE:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_1Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatefirstseen(DEFAULT:Vault_Date_First_Seen_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Targus__Key_Phone,TRANSFORM(RECORDOF(__in.Dataset_Targus__Key_Phone),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((UNSIGNED)phone_number != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Targus__Key_Phone_Invalid := __d1_KELfiltered((KEL.typ.uid)phone_number = 0);
  SHARED __d1_Prefiltered := __d1_KELfiltered((KEL.typ.uid)phone_number <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping2 := 'phone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),rec_type(OVERRIDE:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_2Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_2Rule),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatefirstseen(DEFAULT:Vault_Date_First_Seen_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_InfutorCID__Key_Phone,TRANSFORM(RECORDOF(__in.Dataset_InfutorCID__Key_Phone),SELF:=RIGHT));
  EXPORT __d2_KELfiltered := __d2_Norm((UNSIGNED)phone <> 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_InfutorCID__Key_Phone_Invalid := __d2_KELfiltered((KEL.typ.uid)phone = 0);
  SHARED __d2_Prefiltered := __d2_KELfiltered((KEL.typ.uid)phone <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping3 := 'cellphone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(OVERRIDE:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(OVERRIDE:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_3Rule),datelastseen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_3Rule),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatefirstseen(DEFAULT:Vault_Date_First_Seen_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Phone,TRANSFORM(RECORDOF(__in.Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Phone),SELF:=RIGHT));
  EXPORT __d3_KELfiltered := __d3_Norm((UNSIGNED)cellphone != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Phone_Invalid := __d3_KELfiltered((KEL.typ.uid)cellphone = 0);
  SHARED __d3_Prefiltered := __d3_KELfiltered((KEL.typ.uid)cellphone <> 0);
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_4Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_4Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping4 := 'phone(OVERRIDE:UID),phone_iver(OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),current_rec(OVERRIDE:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),rec_type(OVERRIDE:Record_Type_:\'\'),file_source(OVERRIDE:Source_File_:0),iver_indicator(OVERRIDE:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_4Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_4Rule),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatefirstseen(DEFAULT:Vault_Date_First_Seen_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_Key_Iverification__Keys_Iverification_Phone,TRANSFORM(RECORDOF(__in.Dataset_Key_Iverification__Keys_Iverification_Phone),SELF:=RIGHT));
  EXPORT __d4_KELfiltered := __d4_Norm((UNSIGNED)Phone_Iver != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_Iverification__Keys_Iverification_Phone_Invalid := __d4_KELfiltered((KEL.typ.uid)phone = 0);
  SHARED __d4_Prefiltered := __d4_KELfiltered((KEL.typ.uid)phone <> 0);
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping5 := 'cellphone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatefirstseen(DEFAULT:Vault_Date_First_Seen_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d5_Norm := NORMALIZE(__in,LEFT.Dataset_Key_CellPhone__Key_Neustar_Phone,TRANSFORM(RECORDOF(__in.Dataset_Key_CellPhone__Key_Neustar_Phone),SELF:=RIGHT));
  EXPORT __d5_KELfiltered := __d5_Norm((UNSIGNED)cellphone <> 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_CellPhone__Key_Neustar_Phone_Invalid := __d5_KELfiltered((KEL.typ.uid)cellphone = 0);
  SHARED __d5_Prefiltered := __d5_KELfiltered((KEL.typ.uid)cellphone <> 0);
  SHARED __d5 := __SourceFilter(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_6Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_6Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping6 := 'cellphone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(OVERRIDE:Listing_Type_:\'\'),orig_publish_code(OVERRIDE:Publish_Code_:\'\'),append_portability_indicator(OVERRIDE:Portability_Indicator_:0),append_nxx_type(OVERRIDE:N_X_X_Type_:0),append_coctype(OVERRIDE:C_O_C_Type_:\'\'),append_scc(OVERRIDE:S_C_C_:\'\'),append_ported_match(OVERRIDE:Ported_Match_:0),append_phone_use(OVERRIDE:Phone_Use_:\'\'),append_company_type(OVERRIDE:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),append_ocn(OVERRIDE:Carrier_Name_:\'\'),confidencescore(OVERRIDE:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),max_orig_conf_score(OVERRIDE:Maximum_Confidence_Score_:0),min_orig_conf_score(OVERRIDE:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),orig_rec_type(OVERRIDE:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),append_phone_type(OVERRIDE:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),source(OVERRIDE:Source_:\'\'),src(OVERRIDE:Original_Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_6Rule),datelastseen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_6Rule),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatefirstseen(DEFAULT:Vault_Date_First_Seen_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d6_Norm := NORMALIZE(__in,LEFT.Dataset_PhonesPlus_v2_Key_PhonePlus_Fdid_Records,TRANSFORM(RECORDOF(__in.Dataset_PhonesPlus_v2_Key_PhonePlus_Fdid_Records),SELF:=RIGHT));
  EXPORT __d6_KELfiltered := __d6_Norm((UNSIGNED)cellphone <> 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PhonesPlus_v2_Key_PhonePlus_Fdid_Records_Invalid := __d6_KELfiltered((KEL.typ.uid)cellphone = 0);
  SHARED __d6_Prefiltered := __d6_KELfiltered((KEL.typ.uid)cellphone <> 0);
  SHARED __d6 := __SourceFilter(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6;
  EXPORT Prior_Area_Codes_Layout := RECORD
    KEL.typ.nstr Prior_Area_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Active_Layout := RECORD
    KEL.typ.nstr Is_Active_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Confidence_Scores_Layout := RECORD
    KEL.typ.nint Confidence_Score_;
    KEL.typ.nint Maximum_Confidence_Score_;
    KEL.typ.nint Minimum_Confidence_Score_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Listing_Types_Layout := RECORD
    KEL.typ.nstr Listing_Type_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Phone_Types_Layout := RECORD
    KEL.typ.nstr Phone_Type_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Record_Types_Layout := RECORD
    KEL.typ.nstr Record_Type_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT High_Risk_Phone_Layout := RECORD
    KEL.typ.nint High_Risk_S_I_C_;
    KEL.typ.nint High_Risk_N_A_I_C_S_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nstr Original_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.nint Portability_Indicator_;
    KEL.typ.nstr Current_Flag_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nint N_X_X_Type_;
    KEL.typ.nstr Publish_Code_;
    KEL.typ.nstr C_O_C_Type_;
    KEL.typ.nstr S_C_C_;
    KEL.typ.nint Phone_Number_Company_Type_;
    KEL.typ.nint Ported_Match_;
    KEL.typ.nstr Phone_Use_;
    KEL.typ.nstr No_Solicit_Code_;
    KEL.typ.nstr Omit_Indicator_;
    KEL.typ.nint Source_File_;
    KEL.typ.nint Iver_Indicator_;
    KEL.typ.nstr Validation_Flag_;
    KEL.typ.nstr Validation_Date_;
    KEL.typ.nstr Carrier_Name_;
    KEL.typ.ndataset(Prior_Area_Codes_Layout) Prior_Area_Codes_;
    KEL.typ.ndataset(Active_Layout) Active_;
    KEL.typ.ndataset(Confidence_Scores_Layout) Confidence_Scores_;
    KEL.typ.ndataset(Listing_Types_Layout) Listing_Types_;
    KEL.typ.ndataset(Phone_Types_Layout) Phone_Types_;
    KEL.typ.ndataset(Record_Types_Layout) Record_Types_;
    KEL.typ.ndataset(High_Risk_Phone_Layout) High_Risk_Phone_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Phone_Group := __PostFilter;
  Layout Phone__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Phone10_ := KEL.Intake.SingleValue(__recs,Phone10_);
    SELF.Portability_Indicator_ := KEL.Intake.SingleValue(__recs,Portability_Indicator_);
    SELF.Current_Flag_ := KEL.Intake.SingleValue(__recs,Current_Flag_);
    SELF.Business_Flag_ := KEL.Intake.SingleValue(__recs,Business_Flag_);
    SELF.N_X_X_Type_ := KEL.Intake.SingleValue(__recs,N_X_X_Type_);
    SELF.Publish_Code_ := KEL.Intake.SingleValue(__recs,Publish_Code_);
    SELF.C_O_C_Type_ := KEL.Intake.SingleValue(__recs,C_O_C_Type_);
    SELF.S_C_C_ := KEL.Intake.SingleValue(__recs,S_C_C_);
    SELF.Phone_Number_Company_Type_ := KEL.Intake.SingleValue(__recs,Phone_Number_Company_Type_);
    SELF.Ported_Match_ := KEL.Intake.SingleValue(__recs,Ported_Match_);
    SELF.Phone_Use_ := KEL.Intake.SingleValue(__recs,Phone_Use_);
    SELF.No_Solicit_Code_ := KEL.Intake.SingleValue(__recs,No_Solicit_Code_);
    SELF.Omit_Indicator_ := KEL.Intake.SingleValue(__recs,Omit_Indicator_);
    SELF.Source_File_ := KEL.Intake.SingleValue(__recs,Source_File_);
    SELF.Iver_Indicator_ := KEL.Intake.SingleValue(__recs,Iver_Indicator_);
    SELF.Validation_Flag_ := KEL.Intake.SingleValue(__recs,Validation_Flag_);
    SELF.Validation_Date_ := KEL.Intake.SingleValue(__recs,Validation_Date_);
    SELF.Carrier_Name_ := KEL.Intake.SingleValue(__recs,Carrier_Name_);
    SELF.Prior_Area_Codes_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,FALSE),Prior_Area_Code_},Prior_Area_Code_),Prior_Area_Codes_Layout)(__NN(Prior_Area_Code_)));
    SELF.Active_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,FALSE),Is_Active_,Source_},Is_Active_,Source_),Active_Layout)(__NN(Is_Active_) OR __NN(Source_)));
    SELF.Confidence_Scores_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,FALSE),Confidence_Score_,Maximum_Confidence_Score_,Minimum_Confidence_Score_},Confidence_Score_,Maximum_Confidence_Score_,Minimum_Confidence_Score_),Confidence_Scores_Layout)(__NN(Confidence_Score_) OR __NN(Maximum_Confidence_Score_) OR __NN(Minimum_Confidence_Score_)));
    SELF.Listing_Types_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,FALSE),Listing_Type_,Source_},Listing_Type_,Source_),Listing_Types_Layout)(__NN(Listing_Type_) OR __NN(Source_)));
    SELF.Phone_Types_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,FALSE),Phone_Type_,Source_},Phone_Type_,Source_),Phone_Types_Layout)(__NN(Phone_Type_) OR __NN(Source_)));
    SELF.Record_Types_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,FALSE),Record_Type_,Source_},Record_Type_,Source_),Record_Types_Layout)(__NN(Record_Type_) OR __NN(Source_)));
    SELF.High_Risk_Phone_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,FALSE),High_Risk_S_I_C_,High_Risk_N_A_I_C_S_},High_Risk_S_I_C_,High_Risk_N_A_I_C_S_),High_Risk_Phone_Layout)(__NN(High_Risk_S_I_C_) OR __NN(High_Risk_N_A_I_C_S_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,FALSE),Source_,Original_Source_},Source_,Original_Source_),Data_Sources_Layout)(__NN(Source_) OR __NN(Original_Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_First_Reported_,MIN,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_Last_Reported_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_First_Seen_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Phone__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Prior_Area_Codes_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Prior_Area_Codes_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_First_Seen_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Prior_Area_Code_)));
    SELF.Active_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Active_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_First_Seen_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Is_Active_) OR __NN(Source_)));
    SELF.Confidence_Scores_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Confidence_Scores_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_First_Seen_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Confidence_Score_) OR __NN(Maximum_Confidence_Score_) OR __NN(Minimum_Confidence_Score_)));
    SELF.Listing_Types_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Listing_Types_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_First_Seen_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Listing_Type_) OR __NN(Source_)));
    SELF.Phone_Types_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Phone_Types_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_First_Seen_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Phone_Type_) OR __NN(Source_)));
    SELF.Record_Types_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Record_Types_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_First_Seen_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Record_Type_) OR __NN(Source_)));
    SELF.High_Risk_Phone_ := __CN(PROJECT(DATASET(__r),TRANSFORM(High_Risk_Phone_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_First_Seen_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(High_Risk_S_I_C_) OR __NN(High_Risk_N_A_I_C_S_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_First_Seen_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Source_) OR __NN(Original_Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_First_Reported_,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_Last_Reported_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_First_Seen_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Phone_Group,COUNT(ROWS(LEFT))=1),GROUP,Phone__Single_Rollup(LEFT)) + ROLLUP(HAVING(Phone_Group,COUNT(ROWS(LEFT))>1),GROUP,Phone__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := TABLE(InData,{KEL.typ.uid UID := MIN(GROUP,__T(UID)),KEL.typ.int Cnt := COUNT(GROUP)},UID);
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Phone10__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Phone10_);
  EXPORT Portability_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Portability_Indicator_);
  EXPORT Current_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Current_Flag_);
  EXPORT Business_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Business_Flag_);
  EXPORT N_X_X_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,N_X_X_Type_);
  EXPORT Publish_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Publish_Code_);
  EXPORT C_O_C_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,C_O_C_Type_);
  EXPORT S_C_C__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,S_C_C_);
  EXPORT Phone_Number_Company_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Phone_Number_Company_Type_);
  EXPORT Ported_Match__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Ported_Match_);
  EXPORT Phone_Use__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Phone_Use_);
  EXPORT No_Solicit_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,No_Solicit_Code_);
  EXPORT Omit_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Omit_Indicator_);
  EXPORT Source_File__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Source_File_);
  EXPORT Iver_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Iver_Indicator_);
  EXPORT Validation_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Validation_Flag_);
  EXPORT Validation_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Validation_Date_);
  EXPORT Carrier_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Carrier_Name_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_Phone_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Targus__Key_Phone_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_InfutorCID__Key_Phone_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Phone_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_Iverification__Keys_Iverification_Phone_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_CellPhone__Key_Neustar_Phone_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PhonesPlus_v2_Key_PhonePlus_Fdid_Records_Invalid),COUNT(Phone10__SingleValue_Invalid),COUNT(Portability_Indicator__SingleValue_Invalid),COUNT(Current_Flag__SingleValue_Invalid),COUNT(Business_Flag__SingleValue_Invalid),COUNT(N_X_X_Type__SingleValue_Invalid),COUNT(Publish_Code__SingleValue_Invalid),COUNT(C_O_C_Type__SingleValue_Invalid),COUNT(S_C_C__SingleValue_Invalid),COUNT(Phone_Number_Company_Type__SingleValue_Invalid),COUNT(Ported_Match__SingleValue_Invalid),COUNT(Phone_Use__SingleValue_Invalid),COUNT(No_Solicit_Code__SingleValue_Invalid),COUNT(Omit_Indicator__SingleValue_Invalid),COUNT(Source_File__SingleValue_Invalid),COUNT(Iver_Indicator__SingleValue_Invalid),COUNT(Validation_Flag__SingleValue_Invalid),COUNT(Validation_Date__SingleValue_Invalid),COUNT(Carrier_Name__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_Phone_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Targus__Key_Phone_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_InfutorCID__Key_Phone_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Phone_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_Iverification__Keys_Iverification_Phone_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_CellPhone__Key_Neustar_Phone_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PhonesPlus_v2_Key_PhonePlus_Fdid_Records_Invalid,KEL.typ.int Phone10__SingleValue_Invalid,KEL.typ.int Portability_Indicator__SingleValue_Invalid,KEL.typ.int Current_Flag__SingleValue_Invalid,KEL.typ.int Business_Flag__SingleValue_Invalid,KEL.typ.int N_X_X_Type__SingleValue_Invalid,KEL.typ.int Publish_Code__SingleValue_Invalid,KEL.typ.int C_O_C_Type__SingleValue_Invalid,KEL.typ.int S_C_C__SingleValue_Invalid,KEL.typ.int Phone_Number_Company_Type__SingleValue_Invalid,KEL.typ.int Ported_Match__SingleValue_Invalid,KEL.typ.int Phone_Use__SingleValue_Invalid,KEL.typ.int No_Solicit_Code__SingleValue_Invalid,KEL.typ.int Omit_Indicator__SingleValue_Invalid,KEL.typ.int Source_File__SingleValue_Invalid,KEL.typ.int Iver_Indicator__SingleValue_Invalid,KEL.typ.int Validation_Flag__SingleValue_Invalid,KEL.typ.int Validation_Date__SingleValue_Invalid,KEL.typ.int Carrier_Name__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_Phone_Invalid),COUNT(__d0)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone10',COUNT(__d0(__NL(Phone10_))),COUNT(__d0(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','listing_type',COUNT(__d0(__NL(Listing_Type_))),COUNT(__d0(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','publish_code',COUNT(__d0(__NL(Publish_Code_))),COUNT(__d0(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d0(__NL(Portability_Indicator_))),COUNT(__d0(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d0(__NL(N_X_X_Type_))),COUNT(__d0(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d0(__NL(C_O_C_Type_))),COUNT(__d0(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d0(__NL(S_C_C_))),COUNT(__d0(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d0(__NL(Ported_Match_))),COUNT(__d0(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d0(__NL(Phone_Use_))),COUNT(__d0(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d0(__NL(Phone_Number_Company_Type_))),COUNT(__d0(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prior_area_code',COUNT(__d0(__NL(Prior_Area_Code_))),COUNT(__d0(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_record_flag',COUNT(__d0(__NL(Is_Active_))),COUNT(__d0(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d0(__NL(Carrier_Name_))),COUNT(__d0(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d0(__NL(Confidence_Score_))),COUNT(__d0(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d0(__NL(No_Solicit_Code_))),COUNT(__d0(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d0(__NL(Maximum_Confidence_Score_))),COUNT(__d0(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d0(__NL(Minimum_Confidence_Score_))),COUNT(__d0(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','omit_phone',COUNT(__d0(__NL(Omit_Indicator_))),COUNT(__d0(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_flag',COUNT(__d0(__NL(Current_Flag_))),COUNT(__d0(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','business_flag',COUNT(__d0(__NL(Business_Flag_))),COUNT(__d0(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d0(__NL(Record_Type_))),COUNT(__d0(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d0(__NL(Source_File_))),COUNT(__d0(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d0(__NL(Iver_Indicator_))),COUNT(__d0(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d0(__NL(Phone_Type_))),COUNT(__d0(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d0(__NL(Validation_Flag_))),COUNT(__d0(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d0(__NL(Validation_Date_))),COUNT(__d0(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskSIC',COUNT(__d0(__NL(High_Risk_S_I_C_))),COUNT(__d0(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskNAICS',COUNT(__d0(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d0(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d0(__NL(Original_Source_))),COUNT(__d0(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d0(Date_Vendor_First_Reported_=0)),COUNT(__d0(Date_Vendor_First_Reported_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d0(Date_Vendor_Last_Reported_=0)),COUNT(__d0(Date_Vendor_Last_Reported_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateFirstSeen',COUNT(__d0(Vault_Date_First_Seen_=0)),COUNT(__d0(Vault_Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Targus__Key_Phone_Invalid),COUNT(__d1)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone_number',COUNT(__d1(__NL(Phone10_))),COUNT(__d1(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d1(__NL(Listing_Type_))),COUNT(__d1(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d1(__NL(Publish_Code_))),COUNT(__d1(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d1(__NL(Portability_Indicator_))),COUNT(__d1(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d1(__NL(N_X_X_Type_))),COUNT(__d1(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d1(__NL(C_O_C_Type_))),COUNT(__d1(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d1(__NL(S_C_C_))),COUNT(__d1(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d1(__NL(Ported_Match_))),COUNT(__d1(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d1(__NL(Phone_Use_))),COUNT(__d1(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d1(__NL(Phone_Number_Company_Type_))),COUNT(__d1(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d1(__NL(Prior_Area_Code_))),COUNT(__d1(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d1(__NL(Is_Active_))),COUNT(__d1(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d1(__NL(Carrier_Name_))),COUNT(__d1(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d1(__NL(Confidence_Score_))),COUNT(__d1(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d1(__NL(No_Solicit_Code_))),COUNT(__d1(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d1(__NL(Maximum_Confidence_Score_))),COUNT(__d1(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d1(__NL(Minimum_Confidence_Score_))),COUNT(__d1(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d1(__NL(Omit_Indicator_))),COUNT(__d1(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d1(__NL(Current_Flag_))),COUNT(__d1(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d1(__NL(Business_Flag_))),COUNT(__d1(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d1(__NL(Record_Type_))),COUNT(__d1(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d1(__NL(Source_File_))),COUNT(__d1(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d1(__NL(Iver_Indicator_))),COUNT(__d1(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d1(__NL(Phone_Type_))),COUNT(__d1(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','validation_flag',COUNT(__d1(__NL(Validation_Flag_))),COUNT(__d1(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d1(__NL(Validation_Date_))),COUNT(__d1(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskSIC',COUNT(__d1(__NL(High_Risk_S_I_C_))),COUNT(__d1(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskNAICS',COUNT(__d1(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d1(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d1(__NL(Original_Source_))),COUNT(__d1(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d1(Date_Vendor_First_Reported_=0)),COUNT(__d1(Date_Vendor_First_Reported_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d1(Date_Vendor_Last_Reported_=0)),COUNT(__d1(Date_Vendor_Last_Reported_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateFirstSeen',COUNT(__d1(Vault_Date_First_Seen_=0)),COUNT(__d1(Vault_Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_InfutorCID__Key_Phone_Invalid),COUNT(__d2)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d2(__NL(Phone10_))),COUNT(__d2(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d2(__NL(Listing_Type_))),COUNT(__d2(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d2(__NL(Publish_Code_))),COUNT(__d2(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d2(__NL(Portability_Indicator_))),COUNT(__d2(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d2(__NL(N_X_X_Type_))),COUNT(__d2(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d2(__NL(C_O_C_Type_))),COUNT(__d2(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d2(__NL(S_C_C_))),COUNT(__d2(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d2(__NL(Ported_Match_))),COUNT(__d2(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d2(__NL(Phone_Use_))),COUNT(__d2(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d2(__NL(Phone_Number_Company_Type_))),COUNT(__d2(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d2(__NL(Prior_Area_Code_))),COUNT(__d2(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d2(__NL(Is_Active_))),COUNT(__d2(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d2(__NL(Carrier_Name_))),COUNT(__d2(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d2(__NL(Confidence_Score_))),COUNT(__d2(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d2(__NL(No_Solicit_Code_))),COUNT(__d2(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d2(__NL(Maximum_Confidence_Score_))),COUNT(__d2(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d2(__NL(Minimum_Confidence_Score_))),COUNT(__d2(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d2(__NL(Omit_Indicator_))),COUNT(__d2(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d2(__NL(Current_Flag_))),COUNT(__d2(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d2(__NL(Business_Flag_))),COUNT(__d2(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec_type',COUNT(__d2(__NL(Record_Type_))),COUNT(__d2(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d2(__NL(Source_File_))),COUNT(__d2(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d2(__NL(Iver_Indicator_))),COUNT(__d2(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d2(__NL(Phone_Type_))),COUNT(__d2(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d2(__NL(Validation_Flag_))),COUNT(__d2(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d2(__NL(Validation_Date_))),COUNT(__d2(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskSIC',COUNT(__d2(__NL(High_Risk_S_I_C_))),COUNT(__d2(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskNAICS',COUNT(__d2(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d2(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d2(__NL(Original_Source_))),COUNT(__d2(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d2(Date_Vendor_First_Reported_=0)),COUNT(__d2(Date_Vendor_First_Reported_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d2(Date_Vendor_Last_Reported_=0)),COUNT(__d2(Date_Vendor_Last_Reported_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateFirstSeen',COUNT(__d2(Vault_Date_First_Seen_=0)),COUNT(__d2(Vault_Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Phone_Invalid),COUNT(__d3)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cellphone',COUNT(__d3(__NL(Phone10_))),COUNT(__d3(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','listingtype',COUNT(__d3(__NL(Listing_Type_))),COUNT(__d3(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d3(__NL(Publish_Code_))),COUNT(__d3(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d3(__NL(Portability_Indicator_))),COUNT(__d3(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d3(__NL(N_X_X_Type_))),COUNT(__d3(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d3(__NL(C_O_C_Type_))),COUNT(__d3(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d3(__NL(S_C_C_))),COUNT(__d3(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d3(__NL(Ported_Match_))),COUNT(__d3(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d3(__NL(Phone_Use_))),COUNT(__d3(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d3(__NL(Phone_Number_Company_Type_))),COUNT(__d3(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d3(__NL(Prior_Area_Code_))),COUNT(__d3(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d3(__NL(Is_Active_))),COUNT(__d3(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d3(__NL(Carrier_Name_))),COUNT(__d3(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','confidencescore',COUNT(__d3(__NL(Confidence_Score_))),COUNT(__d3(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d3(__NL(No_Solicit_Code_))),COUNT(__d3(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d3(__NL(Maximum_Confidence_Score_))),COUNT(__d3(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d3(__NL(Minimum_Confidence_Score_))),COUNT(__d3(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d3(__NL(Omit_Indicator_))),COUNT(__d3(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d3(__NL(Current_Flag_))),COUNT(__d3(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d3(__NL(Business_Flag_))),COUNT(__d3(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d3(__NL(Record_Type_))),COUNT(__d3(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d3(__NL(Source_File_))),COUNT(__d3(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d3(__NL(Iver_Indicator_))),COUNT(__d3(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d3(__NL(Phone_Type_))),COUNT(__d3(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d3(__NL(Validation_Flag_))),COUNT(__d3(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d3(__NL(Validation_Date_))),COUNT(__d3(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskSIC',COUNT(__d3(__NL(High_Risk_S_I_C_))),COUNT(__d3(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskNAICS',COUNT(__d3(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d3(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d3(__NL(Original_Source_))),COUNT(__d3(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d3(Date_Vendor_First_Reported_=0)),COUNT(__d3(Date_Vendor_First_Reported_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d3(Date_Vendor_Last_Reported_=0)),COUNT(__d3(Date_Vendor_Last_Reported_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d3(Hybrid_Archive_Date_=0)),COUNT(__d3(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateFirstSeen',COUNT(__d3(Vault_Date_First_Seen_=0)),COUNT(__d3(Vault_Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d3(Vault_Date_Last_Seen_=0)),COUNT(__d3(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_Iverification__Keys_Iverification_Phone_Invalid),COUNT(__d4)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Phone_Iver',COUNT(__d4(__NL(Phone10_))),COUNT(__d4(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d4(__NL(Listing_Type_))),COUNT(__d4(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d4(__NL(Publish_Code_))),COUNT(__d4(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d4(__NL(Portability_Indicator_))),COUNT(__d4(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d4(__NL(N_X_X_Type_))),COUNT(__d4(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d4(__NL(C_O_C_Type_))),COUNT(__d4(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d4(__NL(S_C_C_))),COUNT(__d4(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d4(__NL(Ported_Match_))),COUNT(__d4(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d4(__NL(Phone_Use_))),COUNT(__d4(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d4(__NL(Phone_Number_Company_Type_))),COUNT(__d4(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d4(__NL(Prior_Area_Code_))),COUNT(__d4(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d4(__NL(Is_Active_))),COUNT(__d4(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d4(__NL(Carrier_Name_))),COUNT(__d4(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d4(__NL(Confidence_Score_))),COUNT(__d4(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d4(__NL(No_Solicit_Code_))),COUNT(__d4(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d4(__NL(Maximum_Confidence_Score_))),COUNT(__d4(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d4(__NL(Minimum_Confidence_Score_))),COUNT(__d4(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d4(__NL(Omit_Indicator_))),COUNT(__d4(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_rec',COUNT(__d4(__NL(Current_Flag_))),COUNT(__d4(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d4(__NL(Business_Flag_))),COUNT(__d4(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec_type',COUNT(__d4(__NL(Record_Type_))),COUNT(__d4(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','file_source',COUNT(__d4(__NL(Source_File_))),COUNT(__d4(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','iver_indicator',COUNT(__d4(__NL(Iver_Indicator_))),COUNT(__d4(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d4(__NL(Phone_Type_))),COUNT(__d4(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d4(__NL(Validation_Flag_))),COUNT(__d4(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d4(__NL(Validation_Date_))),COUNT(__d4(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskSIC',COUNT(__d4(__NL(High_Risk_S_I_C_))),COUNT(__d4(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskNAICS',COUNT(__d4(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d4(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d4(__NL(Original_Source_))),COUNT(__d4(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d4(Archive___Date_=0)),COUNT(__d4(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d4(Date_Vendor_First_Reported_=0)),COUNT(__d4(Date_Vendor_First_Reported_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d4(Date_Vendor_Last_Reported_=0)),COUNT(__d4(Date_Vendor_Last_Reported_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d4(Hybrid_Archive_Date_=0)),COUNT(__d4(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateFirstSeen',COUNT(__d4(Vault_Date_First_Seen_=0)),COUNT(__d4(Vault_Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d4(Vault_Date_Last_Seen_=0)),COUNT(__d4(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_CellPhone__Key_Neustar_Phone_Invalid),COUNT(__d5)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cellphone',COUNT(__d5(__NL(Phone10_))),COUNT(__d5(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d5(__NL(Listing_Type_))),COUNT(__d5(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d5(__NL(Publish_Code_))),COUNT(__d5(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d5(__NL(Portability_Indicator_))),COUNT(__d5(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d5(__NL(N_X_X_Type_))),COUNT(__d5(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d5(__NL(C_O_C_Type_))),COUNT(__d5(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d5(__NL(S_C_C_))),COUNT(__d5(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d5(__NL(Ported_Match_))),COUNT(__d5(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d5(__NL(Phone_Use_))),COUNT(__d5(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d5(__NL(Phone_Number_Company_Type_))),COUNT(__d5(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d5(__NL(Prior_Area_Code_))),COUNT(__d5(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d5(__NL(Is_Active_))),COUNT(__d5(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d5(__NL(Carrier_Name_))),COUNT(__d5(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d5(__NL(Confidence_Score_))),COUNT(__d5(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d5(__NL(No_Solicit_Code_))),COUNT(__d5(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d5(__NL(Maximum_Confidence_Score_))),COUNT(__d5(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d5(__NL(Minimum_Confidence_Score_))),COUNT(__d5(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d5(__NL(Omit_Indicator_))),COUNT(__d5(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d5(__NL(Current_Flag_))),COUNT(__d5(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d5(__NL(Business_Flag_))),COUNT(__d5(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d5(__NL(Record_Type_))),COUNT(__d5(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d5(__NL(Source_File_))),COUNT(__d5(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d5(__NL(Iver_Indicator_))),COUNT(__d5(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d5(__NL(Phone_Type_))),COUNT(__d5(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d5(__NL(Validation_Flag_))),COUNT(__d5(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d5(__NL(Validation_Date_))),COUNT(__d5(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskSIC',COUNT(__d5(__NL(High_Risk_S_I_C_))),COUNT(__d5(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskNAICS',COUNT(__d5(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d5(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d5(__NL(Original_Source_))),COUNT(__d5(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d5(Archive___Date_=0)),COUNT(__d5(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d5(Date_Vendor_First_Reported_=0)),COUNT(__d5(Date_Vendor_First_Reported_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d5(Date_Vendor_Last_Reported_=0)),COUNT(__d5(Date_Vendor_Last_Reported_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d5(Hybrid_Archive_Date_=0)),COUNT(__d5(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateFirstSeen',COUNT(__d5(Vault_Date_First_Seen_=0)),COUNT(__d5(Vault_Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d5(Vault_Date_Last_Seen_=0)),COUNT(__d5(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PhonesPlus_v2_Key_PhonePlus_Fdid_Records_Invalid),COUNT(__d6)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cellphone',COUNT(__d6(__NL(Phone10_))),COUNT(__d6(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','listingtype',COUNT(__d6(__NL(Listing_Type_))),COUNT(__d6(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_publish_code',COUNT(__d6(__NL(Publish_Code_))),COUNT(__d6(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_portability_indicator',COUNT(__d6(__NL(Portability_Indicator_))),COUNT(__d6(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_nxx_type',COUNT(__d6(__NL(N_X_X_Type_))),COUNT(__d6(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_coctype',COUNT(__d6(__NL(C_O_C_Type_))),COUNT(__d6(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_scc',COUNT(__d6(__NL(S_C_C_))),COUNT(__d6(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_ported_match',COUNT(__d6(__NL(Ported_Match_))),COUNT(__d6(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_phone_use',COUNT(__d6(__NL(Phone_Use_))),COUNT(__d6(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_company_type',COUNT(__d6(__NL(Phone_Number_Company_Type_))),COUNT(__d6(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d6(__NL(Prior_Area_Code_))),COUNT(__d6(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d6(__NL(Is_Active_))),COUNT(__d6(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_ocn',COUNT(__d6(__NL(Carrier_Name_))),COUNT(__d6(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','confidencescore',COUNT(__d6(__NL(Confidence_Score_))),COUNT(__d6(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d6(__NL(No_Solicit_Code_))),COUNT(__d6(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','max_orig_conf_score',COUNT(__d6(__NL(Maximum_Confidence_Score_))),COUNT(__d6(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','min_orig_conf_score',COUNT(__d6(__NL(Minimum_Confidence_Score_))),COUNT(__d6(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d6(__NL(Omit_Indicator_))),COUNT(__d6(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d6(__NL(Current_Flag_))),COUNT(__d6(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d6(__NL(Business_Flag_))),COUNT(__d6(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_rec_type',COUNT(__d6(__NL(Record_Type_))),COUNT(__d6(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d6(__NL(Source_File_))),COUNT(__d6(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d6(__NL(Iver_Indicator_))),COUNT(__d6(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_phone_type',COUNT(__d6(__NL(Phone_Type_))),COUNT(__d6(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d6(__NL(Validation_Flag_))),COUNT(__d6(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d6(__NL(Validation_Date_))),COUNT(__d6(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskSIC',COUNT(__d6(__NL(High_Risk_S_I_C_))),COUNT(__d6(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskNAICS',COUNT(__d6(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d6(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d6(__NL(Source_))),COUNT(__d6(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d6(__NL(Original_Source_))),COUNT(__d6(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d6(Archive___Date_=0)),COUNT(__d6(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d6(Date_Vendor_First_Reported_=0)),COUNT(__d6(Date_Vendor_First_Reported_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d6(Date_Vendor_Last_Reported_=0)),COUNT(__d6(Date_Vendor_Last_Reported_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d6(Hybrid_Archive_Date_=0)),COUNT(__d6(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateFirstSeen',COUNT(__d6(Vault_Date_First_Seen_=0)),COUNT(__d6(Vault_Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d6(Vault_Date_Last_Seen_=0)),COUNT(__d6(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
