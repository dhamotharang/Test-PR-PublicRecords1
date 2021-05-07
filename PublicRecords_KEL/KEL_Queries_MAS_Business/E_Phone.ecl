//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT E_Phone(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.nstr Listing_Type_;
    KEL.typ.nstr Publish_Code_;
    KEL.typ.nstr Prior_Area_Code_;
    KEL.typ.nstr Is_Active_;
    KEL.typ.nstr Carrier_Name_;
    KEL.typ.nstr Omit_Indicator_;
    KEL.typ.nstr Current_Flag_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nint Source_File_;
    KEL.typ.nint Iver_Indicator_;
    KEL.typ.nstr Validation_Flag_;
    KEL.typ.nint High_Risk_S_I_C_;
    KEL.typ.nint High_Risk_N_A_I_C_S_;
    KEL.typ.nbool Household_Flag_;
    KEL.typ.nkdate Phone_Date_Vendor_First_Reported_;
    KEL.typ.nkdate Phone_Date_Vendor_Last_Reported_;
    KEL.typ.nstr Orig_Phone_;
    KEL.typ.nstr Orig_Carrier_Name_;
    KEL.typ.nstr Rec_Type_;
    KEL.typ.nbool Current_Rec_;
    KEL.typ.nint Ingest_T_P_E_;
    KEL.typ.nstr Verified_;
    KEL.typ.nstr Cord_Cutter_;
    KEL.typ.nstr Activity_Status_;
    KEL.typ.nstr Prepaid_;
    KEL.typ.nstr Serv_;
    KEL.typ.nstr Line_;
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
  SHARED __Mapping := 'phone10(DEFAULT:UID|DEFAULT:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),validationflag(DEFAULT:Validation_Flag_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),householdflag(DEFAULT:Household_Flag_),phonedatevendorfirstreported(DEFAULT:Phone_Date_Vendor_First_Reported_:DATE),phonedatevendorlastreported(DEFAULT:Phone_Date_Vendor_Last_Reported_:DATE),origphone(DEFAULT:Orig_Phone_:\'\'),origcarriername(DEFAULT:Orig_Carrier_Name_:\'\'),rectype(DEFAULT:Rec_Type_:\'\'),currentrec(DEFAULT:Current_Rec_),ingesttpe(DEFAULT:Ingest_T_P_E_:0),verified(DEFAULT:Verified_:\'\'),cordcutter(DEFAULT:Cord_Cutter_:\'\'),activitystatus(DEFAULT:Activity_Status_:\'\'),prepaid(DEFAULT:Prepaid_:\'\'),serv(DEFAULT:Serv_:\'\'),line(DEFAULT:Line_:\'\'),source(DEFAULT:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'phone10(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listing_type(OVERRIDE:Listing_Type_:\'\'),publish_code(OVERRIDE:Publish_Code_:\'\'),prior_area_code(OVERRIDE:Prior_Area_Code_:\'\'),current_record_flag(OVERRIDE:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),omit_phone(OVERRIDE:Omit_Indicator_:\'\'),current_flag(OVERRIDE:Current_Flag_:\'\'),business_flag(OVERRIDE:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),validationflag(DEFAULT:Validation_Flag_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),householdflag(DEFAULT:Household_Flag_),phonedatevendorfirstreported(DEFAULT:Phone_Date_Vendor_First_Reported_:DATE),phonedatevendorlastreported(DEFAULT:Phone_Date_Vendor_Last_Reported_:DATE),origphone(DEFAULT:Orig_Phone_:\'\'),origcarriername(DEFAULT:Orig_Carrier_Name_:\'\'),rectype(DEFAULT:Rec_Type_:\'\'),currentrec(DEFAULT:Current_Rec_),ingesttpe(DEFAULT:Ingest_T_P_E_:0),verified(DEFAULT:Verified_:\'\'),cordcutter(DEFAULT:Cord_Cutter_:\'\'),activitystatus(DEFAULT:Activity_Status_:\'\'),prepaid(DEFAULT:Prepaid_:\'\'),serv(DEFAULT:Serv_:\'\'),line(DEFAULT:Line_:\'\'),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Gong__Key_History_Phone,TRANSFORM(RECORDOF(__in.Dataset_Gong__Key_History_Phone),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((UNSIGNED)phone10 != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_Phone_Invalid := __d0_KELfiltered((KEL.typ.uid)phone10 = 0);
  SHARED __d0_Prefiltered := __d0_KELfiltered((KEL.typ.uid)phone10 <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'phone_number(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),validation_flag(OVERRIDE:Validation_Flag_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),householdflag(DEFAULT:Household_Flag_),phonedatevendorfirstreported(DEFAULT:Phone_Date_Vendor_First_Reported_:DATE),phonedatevendorlastreported(DEFAULT:Phone_Date_Vendor_Last_Reported_:DATE),origphone(DEFAULT:Orig_Phone_:\'\'),origcarriername(DEFAULT:Orig_Carrier_Name_:\'\'),rectype(DEFAULT:Rec_Type_:\'\'),currentrec(DEFAULT:Current_Rec_),ingesttpe(DEFAULT:Ingest_T_P_E_:0),verified(DEFAULT:Verified_:\'\'),cordcutter(DEFAULT:Cord_Cutter_:\'\'),activitystatus(DEFAULT:Activity_Status_:\'\'),prepaid(DEFAULT:Prepaid_:\'\'),serv(DEFAULT:Serv_:\'\'),line(DEFAULT:Line_:\'\'),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Targus__Key_Phone,TRANSFORM(RECORDOF(__in.Dataset_Targus__Key_Phone),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((UNSIGNED)phone_number != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Targus__Key_Phone_Invalid := __d1_KELfiltered((KEL.typ.uid)phone_number = 0);
  SHARED __d1_Prefiltered := __d1_KELfiltered((KEL.typ.uid)phone_number <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_Last_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping2 := 'phone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),rec_type(OVERRIDE:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),validationflag(DEFAULT:Validation_Flag_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),householdflag(DEFAULT:Household_Flag_),phonedatevendorfirstreported(DEFAULT:Phone_Date_Vendor_First_Reported_:DATE),phonedatevendorlastreported(DEFAULT:Phone_Date_Vendor_Last_Reported_:DATE),origphone(DEFAULT:Orig_Phone_:\'\'),origcarriername(DEFAULT:Orig_Carrier_Name_:\'\'),rectype(DEFAULT:Rec_Type_:\'\'),currentrec(DEFAULT:Current_Rec_),ingesttpe(DEFAULT:Ingest_T_P_E_:0),verified(DEFAULT:Verified_:\'\'),cordcutter(DEFAULT:Cord_Cutter_:\'\'),activitystatus(DEFAULT:Activity_Status_:\'\'),prepaid(DEFAULT:Prepaid_:\'\'),serv(DEFAULT:Serv_:\'\'),line(DEFAULT:Line_:\'\'),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_2Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_InfutorCID__Key_Phone,TRANSFORM(RECORDOF(__in.Dataset_InfutorCID__Key_Phone),SELF:=RIGHT));
  EXPORT __d2_KELfiltered := __d2_Norm((UNSIGNED)phone <> 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_InfutorCID__Key_Phone_Invalid := __d2_KELfiltered((KEL.typ.uid)phone = 0);
  SHARED __d2_Prefiltered := __d2_KELfiltered((KEL.typ.uid)phone <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_Last_Seen_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping3 := 'phone(OVERRIDE:UID),phone_iver(OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),current_rec(OVERRIDE:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),rec_type(OVERRIDE:Record_Type_:\'\'),file_source(OVERRIDE:Source_File_:0),iver_indicator(OVERRIDE:Iver_Indicator_:0),validationflag(DEFAULT:Validation_Flag_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),householdflag(DEFAULT:Household_Flag_),phonedatevendorfirstreported(DEFAULT:Phone_Date_Vendor_First_Reported_:DATE),phonedatevendorlastreported(DEFAULT:Phone_Date_Vendor_Last_Reported_:DATE),origphone(DEFAULT:Orig_Phone_:\'\'),origcarriername(DEFAULT:Orig_Carrier_Name_:\'\'),rectype(DEFAULT:Rec_Type_:\'\'),currentrec(DEFAULT:Current_Rec_),ingesttpe(DEFAULT:Ingest_T_P_E_:0),verified(DEFAULT:Verified_:\'\'),cordcutter(DEFAULT:Cord_Cutter_:\'\'),activitystatus(DEFAULT:Activity_Status_:\'\'),prepaid(DEFAULT:Prepaid_:\'\'),serv(DEFAULT:Serv_:\'\'),line(DEFAULT:Line_:\'\'),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_3Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_Key_Iverification__Keys_Iverification_Phone,TRANSFORM(RECORDOF(__in.Dataset_Key_Iverification__Keys_Iverification_Phone),SELF:=RIGHT));
  EXPORT __d3_KELfiltered := __d3_Norm((UNSIGNED)Phone_Iver != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_Iverification__Keys_Iverification_Phone_Invalid := __d3_KELfiltered((KEL.typ.uid)phone = 0);
  SHARED __d3_Prefiltered := __d3_KELfiltered((KEL.typ.uid)phone <> 0);
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping4 := 'cellphone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),validationflag(DEFAULT:Validation_Flag_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),householdflag(DEFAULT:Household_Flag_),phonedatevendorfirstreported(DEFAULT:Phone_Date_Vendor_First_Reported_:DATE),phonedatevendorlastreported(DEFAULT:Phone_Date_Vendor_Last_Reported_:DATE),origphone(DEFAULT:Orig_Phone_:\'\'),origcarriername(DEFAULT:Orig_Carrier_Name_:\'\'),rectype(DEFAULT:Rec_Type_:\'\'),currentrec(DEFAULT:Current_Rec_),ingesttpe(DEFAULT:Ingest_T_P_E_:0),verified(DEFAULT:Verified_:\'\'),cordcutter(DEFAULT:Cord_Cutter_:\'\'),activitystatus(DEFAULT:Activity_Status_:\'\'),prepaid(DEFAULT:Prepaid_:\'\'),serv(DEFAULT:Serv_:\'\'),line(DEFAULT:Line_:\'\'),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_Key_CellPhone__Key_Neustar_Phone,TRANSFORM(RECORDOF(__in.Dataset_Key_CellPhone__Key_Neustar_Phone),SELF:=RIGHT));
  EXPORT __d4_KELfiltered := __d4_Norm((UNSIGNED)cellphone <> 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_CellPhone__Key_Neustar_Phone_Invalid := __d4_KELfiltered((KEL.typ.uid)cellphone = 0);
  SHARED __d4_Prefiltered := __d4_KELfiltered((KEL.typ.uid)cellphone <> 0);
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping5 := 'phone_number(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),validationflag(DEFAULT:Validation_Flag_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),householdflag(DEFAULT:Household_Flag_),phonedatevendorfirstreported(DEFAULT:Phone_Date_Vendor_First_Reported_:DATE),phonedatevendorlastreported(DEFAULT:Phone_Date_Vendor_Last_Reported_:DATE),origphone(DEFAULT:Orig_Phone_:\'\'),origcarriername(DEFAULT:Orig_Carrier_Name_:\'\'),rec_type(OVERRIDE:Rec_Type_:\'\'),currentrec(DEFAULT:Current_Rec_),ingesttpe(DEFAULT:Ingest_T_P_E_:0),verified(DEFAULT:Verified_:\'\'),cordcutter(DEFAULT:Cord_Cutter_:\'\'),activitystatus(DEFAULT:Activity_Status_:\'\'),prepaid(DEFAULT:Prepaid_:\'\'),serv(DEFAULT:Serv_:\'\'),line(DEFAULT:Line_:\'\'),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d5_Norm := NORMALIZE(__in,LEFT.Dataset_FraudPoint3__Key_Phone,TRANSFORM(RECORDOF(__in.Dataset_FraudPoint3__Key_Phone),SELF:=RIGHT));
  EXPORT __d5_KELfiltered := __d5_Norm((UNSIGNED)phone_number <> 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_FraudPoint3__Key_Phone_Invalid := __d5_KELfiltered((KEL.typ.uid)phone_number = 0);
  SHARED __d5_Prefiltered := __d5_KELfiltered((KEL.typ.uid)phone_number <> 0);
  SHARED __d5 := __SourceFilter(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Phone_Date_Vendor_First_Reported_6Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Phone_Date_Vendor_Last_Reported_6Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping6 := 'phone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),validationflag(DEFAULT:Validation_Flag_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),householdflag(DEFAULT:Household_Flag_),vendor_first_reported_dt(OVERRIDE:Phone_Date_Vendor_First_Reported_:DATE:Phone_Date_Vendor_First_Reported_6Rule),vendor_last_reported_dt(OVERRIDE:Phone_Date_Vendor_Last_Reported_:DATE:Phone_Date_Vendor_Last_Reported_6Rule),origphone(DEFAULT:Orig_Phone_:\'\'),origcarriername(DEFAULT:Orig_Carrier_Name_:\'\'),rectype(DEFAULT:Rec_Type_:\'\'),currentrec(DEFAULT:Current_Rec_),ingesttpe(DEFAULT:Ingest_T_P_E_:0),verified(DEFAULT:Verified_:\'\'),cordcutter(DEFAULT:Cord_Cutter_:\'\'),activitystatus(DEFAULT:Activity_Status_:\'\'),prepaid(OVERRIDE:Prepaid_:\'\'),serv(OVERRIDE:Serv_:\'\'),line(OVERRIDE:Line_:\'\'),src(OVERRIDE:Source_:\'\'),source(OVERRIDE:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d6_Norm := NORMALIZE(__in,LEFT.Dataset_dx_PhonesInfo__Key_Phones_Type,TRANSFORM(RECORDOF(__in.Dataset_dx_PhonesInfo__Key_Phones_Type),SELF:=RIGHT));
  EXPORT __d6_KELfiltered := __d6_Norm((UNSIGNED)phone <> 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_dx_PhonesInfo__Key_Phones_Type_Invalid := __d6_KELfiltered((KEL.typ.uid)phone = 0);
  SHARED __d6_Prefiltered := __d6_KELfiltered((KEL.typ.uid)phone <> 0);
  SHARED __d6 := __SourceFilter(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Phone_Date_Vendor_First_Reported_7Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Phone_Date_Vendor_Last_Reported_7Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping7 := 'phone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carrier_name(OVERRIDE:Carrier_Name_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),validationflag(DEFAULT:Validation_Flag_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),householdflag(DEFAULT:Household_Flag_),vendor_first_reported_dt(OVERRIDE:Phone_Date_Vendor_First_Reported_:DATE:Phone_Date_Vendor_First_Reported_7Rule),vendor_last_reported_dt(OVERRIDE:Phone_Date_Vendor_Last_Reported_:DATE:Phone_Date_Vendor_Last_Reported_7Rule),origphone(DEFAULT:Orig_Phone_:\'\'),origcarriername(DEFAULT:Orig_Carrier_Name_:\'\'),rectype(DEFAULT:Rec_Type_:\'\'),currentrec(DEFAULT:Current_Rec_),ingesttpe(DEFAULT:Ingest_T_P_E_:0),verified(DEFAULT:Verified_:\'\'),cordcutter(DEFAULT:Cord_Cutter_:\'\'),activitystatus(DEFAULT:Activity_Status_:\'\'),prepaid(DEFAULT:Prepaid_:\'\'),serv(DEFAULT:Serv_:\'\'),line(DEFAULT:Line_:\'\'),src(OVERRIDE:Source_:\'\'),source(OVERRIDE:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d7_Norm := NORMALIZE(__in,LEFT.Dataset_dx_PhonesInfo__Key_Phones_Transaction,TRANSFORM(RECORDOF(__in.Dataset_dx_PhonesInfo__Key_Phones_Transaction),SELF:=RIGHT));
  EXPORT __d7_KELfiltered := __d7_Norm((UNSIGNED)phone <> 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_dx_PhonesInfo__Key_Phones_Transaction_Invalid := __d7_KELfiltered((KEL.typ.uid)phone = 0);
  SHARED __d7_Prefiltered := __d7_KELfiltered((KEL.typ.uid)phone <> 0);
  SHARED __d7 := __SourceFilter(KEL.FromFlat.Convert(__d7_Prefiltered,InLayout,__Mapping7,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Phone_Date_Vendor_First_Reported_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Phone_Date_Vendor_Last_Reported_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Date_First_Seen_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Date_Last_Seen_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping8 := 'cellphone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),validationflag(DEFAULT:Validation_Flag_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),household_flag(OVERRIDE:Household_Flag_),datevendorfirstreported(OVERRIDE:Phone_Date_Vendor_First_Reported_:DATE:Phone_Date_Vendor_First_Reported_8Rule),datevendorlastreported(OVERRIDE:Phone_Date_Vendor_Last_Reported_:DATE:Phone_Date_Vendor_Last_Reported_8Rule),orig_phone(OVERRIDE:Orig_Phone_:\'\'),orig_carrier_name(OVERRIDE:Orig_Carrier_Name_:\'\'),rec_type(OVERRIDE:Rec_Type_:\'\'),current_rec(OVERRIDE:Current_Rec_),ingest_tpe(OVERRIDE:Ingest_T_P_E_:0),verified(OVERRIDE:Verified_:\'\'),cord_cutter(OVERRIDE:Cord_Cutter_:\'\'),activity_status(OVERRIDE:Activity_Status_:\'\'),prepaid(OVERRIDE:Prepaid_:\'\'),serv(DEFAULT:Serv_:\'\'),line(DEFAULT:Line_:\'\'),src(OVERRIDE:Source_:\'\'),source(OVERRIDE:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_8Rule),datelastseen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_8Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d8_Norm := NORMALIZE(__in,LEFT.Dataset_PhonesPlus_v2__Key_Source_Level_Payload,TRANSFORM(RECORDOF(__in.Dataset_PhonesPlus_v2__Key_Source_Level_Payload),SELF:=RIGHT));
  EXPORT __d8_KELfiltered := __d8_Norm((UNSIGNED)cellphone <> 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PhonesPlus_v2__Key_Source_Level_Payload_Invalid := __d8_KELfiltered((KEL.typ.uid)cellphone = 0);
  SHARED __d8_Prefiltered := __d8_KELfiltered((KEL.typ.uid)cellphone <> 0);
  SHARED __d8 := __SourceFilter(KEL.FromFlat.Convert(__d8_Prefiltered,InLayout,__Mapping8,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping9 := 'company_phone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),validationflag(DEFAULT:Validation_Flag_:\'\'),sic_code(OVERRIDE:High_Risk_S_I_C_:0),naics_code(OVERRIDE:High_Risk_N_A_I_C_S_:0),householdflag(DEFAULT:Household_Flag_),phonedatevendorfirstreported(DEFAULT:Phone_Date_Vendor_First_Reported_:DATE),phonedatevendorlastreported(DEFAULT:Phone_Date_Vendor_Last_Reported_:DATE),origphone(DEFAULT:Orig_Phone_:\'\'),origcarriername(DEFAULT:Orig_Carrier_Name_:\'\'),rectype(DEFAULT:Rec_Type_:\'\'),currentrec(DEFAULT:Current_Rec_),ingesttpe(DEFAULT:Ingest_T_P_E_:0),verified(DEFAULT:Verified_:\'\'),cordcutter(DEFAULT:Cord_Cutter_:\'\'),activitystatus(DEFAULT:Activity_Status_:\'\'),prepaid(DEFAULT:Prepaid_:\'\'),serv(DEFAULT:Serv_:\'\'),line(DEFAULT:Line_:\'\'),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d9_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2_Build__key_high_risk_industries_phone,TRANSFORM(RECORDOF(__in.Dataset_BIPV2_Build__key_high_risk_industries_phone),SELF:=RIGHT));
  EXPORT __d9_KELfiltered := __d9_Norm((UNSIGNED)company_phone <> 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Build__key_high_risk_industries_phone_Invalid := __d9_KELfiltered((KEL.typ.uid)company_phone = 0);
  SHARED __d9_Prefiltered := __d9_KELfiltered((KEL.typ.uid)company_phone <> 0);
  SHARED __d9 := __SourceFilter(KEL.FromFlat.Convert(__d9_Prefiltered,InLayout,__Mapping9,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6 + __d7 + __d8 + __d9;
  EXPORT Listing_Types_Layout := RECORD
    KEL.typ.nstr Listing_Type_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Phone_Type_Information_Layout := RECORD
    KEL.typ.nkdate Phone_Date_Vendor_First_Reported_;
    KEL.typ.nkdate Phone_Date_Vendor_Last_Reported_;
    KEL.typ.nstr Prepaid_;
    KEL.typ.nstr Serv_;
    KEL.typ.nstr Line_;
    KEL.typ.nstr Source_;
    KEL.typ.nstr Original_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Targus_Information_Layout := RECORD
    KEL.typ.nstr Validation_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT I_Verification_Information_Layout := RECORD
    KEL.typ.nstr Record_Type_;
    KEL.typ.nstr Current_Flag_;
    KEL.typ.nint Source_File_;
    KEL.typ.nint Iver_Indicator_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Phones_Plus_Information_Layout := RECORD
    KEL.typ.nbool Household_Flag_;
    KEL.typ.nkdate Phone_Date_Vendor_First_Reported_;
    KEL.typ.nkdate Phone_Date_Vendor_Last_Reported_;
    KEL.typ.nstr Orig_Phone_;
    KEL.typ.nstr Orig_Carrier_Name_;
    KEL.typ.nstr Rec_Type_;
    KEL.typ.nbool Current_Rec_;
    KEL.typ.nint Ingest_T_P_E_;
    KEL.typ.nstr Verified_;
    KEL.typ.nstr Cord_Cutter_;
    KEL.typ.nstr Activity_Status_;
    KEL.typ.nstr Prepaid_;
    KEL.typ.nstr Source_;
    KEL.typ.nstr Original_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Phone_Transaction_Information_Layout := RECORD
    KEL.typ.nstr Carrier_Name_;
    KEL.typ.nstr Source_;
    KEL.typ.nstr Original_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Gong_Phone_Information_Layout := RECORD
    KEL.typ.nstr Current_Flag_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Publish_Code_;
    KEL.typ.nstr Listing_Type_;
    KEL.typ.nstr Is_Active_;
    KEL.typ.nstr Omit_Indicator_;
    KEL.typ.nstr Prior_Area_Code_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT High_Risk_Phone_Layout := RECORD
    KEL.typ.nint High_Risk_S_I_C_;
    KEL.typ.nint High_Risk_N_A_I_C_S_;
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
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.nstr Serv_;
    KEL.typ.nstr Line_;
    KEL.typ.ndataset(Listing_Types_Layout) Listing_Types_;
    KEL.typ.ndataset(Phone_Type_Information_Layout) Phone_Type_Information_;
    KEL.typ.ndataset(Targus_Information_Layout) Targus_Information_;
    KEL.typ.ndataset(I_Verification_Information_Layout) I_Verification_Information_;
    KEL.typ.ndataset(Phones_Plus_Information_Layout) Phones_Plus_Information_;
    KEL.typ.ndataset(Phone_Transaction_Information_Layout) Phone_Transaction_Information_;
    KEL.typ.ndataset(Gong_Phone_Information_Layout) Gong_Phone_Information_;
    KEL.typ.ndataset(High_Risk_Phone_Layout) High_Risk_Phone_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Phone_Group := __PostFilter;
  Layout Phone__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Phone10_ := KEL.Intake.SingleValue(__recs,Phone10_);
    SELF.Serv_ := KEL.Intake.SingleValue(__recs,Serv_);
    SELF.Line_ := KEL.Intake.SingleValue(__recs,Line_);
    SELF.Listing_Types_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Listing_Type_,Source_},Listing_Type_,Source_),Listing_Types_Layout)(__NN(Listing_Type_) OR __NN(Source_)));
    SELF.Phone_Type_Information_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Phone_Date_Vendor_First_Reported_,Phone_Date_Vendor_Last_Reported_,Prepaid_,Serv_,Line_,Source_,Original_Source_},Phone_Date_Vendor_First_Reported_,Phone_Date_Vendor_Last_Reported_,Prepaid_,Serv_,Line_,Source_,Original_Source_),Phone_Type_Information_Layout)(__NN(Phone_Date_Vendor_First_Reported_) OR __NN(Phone_Date_Vendor_Last_Reported_) OR __NN(Prepaid_) OR __NN(Serv_) OR __NN(Line_) OR __NN(Source_) OR __NN(Original_Source_)));
    SELF.Targus_Information_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Validation_Flag_,Source_},Validation_Flag_,Source_),Targus_Information_Layout)(__NN(Validation_Flag_) OR __NN(Source_)));
    SELF.I_Verification_Information_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Record_Type_,Current_Flag_,Source_File_,Iver_Indicator_,Source_},Record_Type_,Current_Flag_,Source_File_,Iver_Indicator_,Source_),I_Verification_Information_Layout)(__NN(Record_Type_) OR __NN(Current_Flag_) OR __NN(Source_File_) OR __NN(Iver_Indicator_) OR __NN(Source_)));
    SELF.Phones_Plus_Information_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Household_Flag_,Phone_Date_Vendor_First_Reported_,Phone_Date_Vendor_Last_Reported_,Orig_Phone_,Orig_Carrier_Name_,Rec_Type_,Current_Rec_,Ingest_T_P_E_,Verified_,Cord_Cutter_,Activity_Status_,Prepaid_,Source_,Original_Source_},Household_Flag_,Phone_Date_Vendor_First_Reported_,Phone_Date_Vendor_Last_Reported_,Orig_Phone_,Orig_Carrier_Name_,Rec_Type_,Current_Rec_,Ingest_T_P_E_,Verified_,Cord_Cutter_,Activity_Status_,Prepaid_,Source_,Original_Source_),Phones_Plus_Information_Layout)(__NN(Household_Flag_) OR __NN(Phone_Date_Vendor_First_Reported_) OR __NN(Phone_Date_Vendor_Last_Reported_) OR __NN(Orig_Phone_) OR __NN(Orig_Carrier_Name_) OR __NN(Rec_Type_) OR __NN(Current_Rec_) OR __NN(Ingest_T_P_E_) OR __NN(Verified_) OR __NN(Cord_Cutter_) OR __NN(Activity_Status_) OR __NN(Prepaid_) OR __NN(Source_) OR __NN(Original_Source_)));
    SELF.Phone_Transaction_Information_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Carrier_Name_,Source_,Original_Source_},Carrier_Name_,Source_,Original_Source_),Phone_Transaction_Information_Layout)(__NN(Carrier_Name_) OR __NN(Source_) OR __NN(Original_Source_)));
    SELF.Gong_Phone_Information_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Current_Flag_,Business_Flag_,Publish_Code_,Listing_Type_,Is_Active_,Omit_Indicator_,Prior_Area_Code_,Source_},Current_Flag_,Business_Flag_,Publish_Code_,Listing_Type_,Is_Active_,Omit_Indicator_,Prior_Area_Code_,Source_),Gong_Phone_Information_Layout)(__NN(Current_Flag_) OR __NN(Business_Flag_) OR __NN(Publish_Code_) OR __NN(Listing_Type_) OR __NN(Is_Active_) OR __NN(Omit_Indicator_) OR __NN(Prior_Area_Code_) OR __NN(Source_)));
    SELF.High_Risk_Phone_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),High_Risk_S_I_C_,High_Risk_N_A_I_C_S_,Source_},High_Risk_S_I_C_,High_Risk_N_A_I_C_S_,Source_),High_Risk_Phone_Layout)(__NN(High_Risk_S_I_C_) OR __NN(High_Risk_N_A_I_C_S_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_,Original_Source_},Source_,Original_Source_),Data_Sources_Layout)(__NN(Source_) OR __NN(Original_Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Phone__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Listing_Types_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Listing_Types_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Listing_Type_) OR __NN(Source_)));
    SELF.Phone_Type_Information_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Phone_Type_Information_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Phone_Date_Vendor_First_Reported_) OR __NN(Phone_Date_Vendor_Last_Reported_) OR __NN(Prepaid_) OR __NN(Serv_) OR __NN(Line_) OR __NN(Source_) OR __NN(Original_Source_)));
    SELF.Targus_Information_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Targus_Information_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Validation_Flag_) OR __NN(Source_)));
    SELF.I_Verification_Information_ := __CN(PROJECT(DATASET(__r),TRANSFORM(I_Verification_Information_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Record_Type_) OR __NN(Current_Flag_) OR __NN(Source_File_) OR __NN(Iver_Indicator_) OR __NN(Source_)));
    SELF.Phones_Plus_Information_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Phones_Plus_Information_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Household_Flag_) OR __NN(Phone_Date_Vendor_First_Reported_) OR __NN(Phone_Date_Vendor_Last_Reported_) OR __NN(Orig_Phone_) OR __NN(Orig_Carrier_Name_) OR __NN(Rec_Type_) OR __NN(Current_Rec_) OR __NN(Ingest_T_P_E_) OR __NN(Verified_) OR __NN(Cord_Cutter_) OR __NN(Activity_Status_) OR __NN(Prepaid_) OR __NN(Source_) OR __NN(Original_Source_)));
    SELF.Phone_Transaction_Information_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Phone_Transaction_Information_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Carrier_Name_) OR __NN(Source_) OR __NN(Original_Source_)));
    SELF.Gong_Phone_Information_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Gong_Phone_Information_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Current_Flag_) OR __NN(Business_Flag_) OR __NN(Publish_Code_) OR __NN(Listing_Type_) OR __NN(Is_Active_) OR __NN(Omit_Indicator_) OR __NN(Prior_Area_Code_) OR __NN(Source_)));
    SELF.High_Risk_Phone_ := __CN(PROJECT(DATASET(__r),TRANSFORM(High_Risk_Phone_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(High_Risk_S_I_C_) OR __NN(High_Risk_N_A_I_C_S_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_) OR __NN(Original_Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Phone_Group,COUNT(ROWS(LEFT))=1),GROUP,Phone__Single_Rollup(LEFT)) + ROLLUP(HAVING(Phone_Group,COUNT(ROWS(LEFT))>1),GROUP,Phone__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := TABLE(InData,{KEL.typ.uid UID := MIN(GROUP,__T(UID)),KEL.typ.int Cnt := COUNT(GROUP)},UID);
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Phone10__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Phone10_);
  EXPORT Serv__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Serv_);
  EXPORT Line__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Line_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_Phone_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Targus__Key_Phone_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_InfutorCID__Key_Phone_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_Iverification__Keys_Iverification_Phone_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_CellPhone__Key_Neustar_Phone_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_FraudPoint3__Key_Phone_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_dx_PhonesInfo__Key_Phones_Type_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_dx_PhonesInfo__Key_Phones_Transaction_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PhonesPlus_v2__Key_Source_Level_Payload_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Build__key_high_risk_industries_phone_Invalid),COUNT(Phone10__SingleValue_Invalid),COUNT(Serv__SingleValue_Invalid),COUNT(Line__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_Phone_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Targus__Key_Phone_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_InfutorCID__Key_Phone_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_Iverification__Keys_Iverification_Phone_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_CellPhone__Key_Neustar_Phone_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_FraudPoint3__Key_Phone_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_dx_PhonesInfo__Key_Phones_Type_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_dx_PhonesInfo__Key_Phones_Transaction_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PhonesPlus_v2__Key_Source_Level_Payload_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Build__key_high_risk_industries_phone_Invalid,KEL.typ.int Phone10__SingleValue_Invalid,KEL.typ.int Serv__SingleValue_Invalid,KEL.typ.int Line__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Gong__Key_History_Phone_Invalid),COUNT(__d0)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone10',COUNT(__d0(__NL(Phone10_))),COUNT(__d0(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','listing_type',COUNT(__d0(__NL(Listing_Type_))),COUNT(__d0(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','publish_code',COUNT(__d0(__NL(Publish_Code_))),COUNT(__d0(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prior_area_code',COUNT(__d0(__NL(Prior_Area_Code_))),COUNT(__d0(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_record_flag',COUNT(__d0(__NL(Is_Active_))),COUNT(__d0(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d0(__NL(Carrier_Name_))),COUNT(__d0(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','omit_phone',COUNT(__d0(__NL(Omit_Indicator_))),COUNT(__d0(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_flag',COUNT(__d0(__NL(Current_Flag_))),COUNT(__d0(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','business_flag',COUNT(__d0(__NL(Business_Flag_))),COUNT(__d0(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d0(__NL(Record_Type_))),COUNT(__d0(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d0(__NL(Source_File_))),COUNT(__d0(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d0(__NL(Iver_Indicator_))),COUNT(__d0(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d0(__NL(Validation_Flag_))),COUNT(__d0(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskSIC',COUNT(__d0(__NL(High_Risk_S_I_C_))),COUNT(__d0(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskNAICS',COUNT(__d0(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d0(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HouseholdFlag',COUNT(__d0(__NL(Household_Flag_))),COUNT(__d0(__NN(Household_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneDateVendorFirstReported',COUNT(__d0(__NL(Phone_Date_Vendor_First_Reported_))),COUNT(__d0(__NN(Phone_Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneDateVendorLastReported',COUNT(__d0(__NL(Phone_Date_Vendor_Last_Reported_))),COUNT(__d0(__NN(Phone_Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrigPhone',COUNT(__d0(__NL(Orig_Phone_))),COUNT(__d0(__NN(Orig_Phone_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrigCarrierName',COUNT(__d0(__NL(Orig_Carrier_Name_))),COUNT(__d0(__NN(Orig_Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecType',COUNT(__d0(__NL(Rec_Type_))),COUNT(__d0(__NN(Rec_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentRec',COUNT(__d0(__NL(Current_Rec_))),COUNT(__d0(__NN(Current_Rec_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IngestTPE',COUNT(__d0(__NL(Ingest_T_P_E_))),COUNT(__d0(__NN(Ingest_T_P_E_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Verified',COUNT(__d0(__NL(Verified_))),COUNT(__d0(__NN(Verified_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CordCutter',COUNT(__d0(__NL(Cord_Cutter_))),COUNT(__d0(__NN(Cord_Cutter_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActivityStatus',COUNT(__d0(__NL(Activity_Status_))),COUNT(__d0(__NN(Activity_Status_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Prepaid',COUNT(__d0(__NL(Prepaid_))),COUNT(__d0(__NN(Prepaid_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Serv',COUNT(__d0(__NL(Serv_))),COUNT(__d0(__NN(Serv_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Line',COUNT(__d0(__NL(Line_))),COUNT(__d0(__NN(Line_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d0(__NL(Original_Source_))),COUNT(__d0(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Targus__Key_Phone_Invalid),COUNT(__d1)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone_number',COUNT(__d1(__NL(Phone10_))),COUNT(__d1(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d1(__NL(Listing_Type_))),COUNT(__d1(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d1(__NL(Publish_Code_))),COUNT(__d1(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d1(__NL(Prior_Area_Code_))),COUNT(__d1(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d1(__NL(Is_Active_))),COUNT(__d1(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d1(__NL(Carrier_Name_))),COUNT(__d1(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d1(__NL(Omit_Indicator_))),COUNT(__d1(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d1(__NL(Current_Flag_))),COUNT(__d1(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d1(__NL(Business_Flag_))),COUNT(__d1(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d1(__NL(Record_Type_))),COUNT(__d1(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d1(__NL(Source_File_))),COUNT(__d1(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d1(__NL(Iver_Indicator_))),COUNT(__d1(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','validation_flag',COUNT(__d1(__NL(Validation_Flag_))),COUNT(__d1(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskSIC',COUNT(__d1(__NL(High_Risk_S_I_C_))),COUNT(__d1(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskNAICS',COUNT(__d1(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d1(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HouseholdFlag',COUNT(__d1(__NL(Household_Flag_))),COUNT(__d1(__NN(Household_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneDateVendorFirstReported',COUNT(__d1(__NL(Phone_Date_Vendor_First_Reported_))),COUNT(__d1(__NN(Phone_Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneDateVendorLastReported',COUNT(__d1(__NL(Phone_Date_Vendor_Last_Reported_))),COUNT(__d1(__NN(Phone_Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrigPhone',COUNT(__d1(__NL(Orig_Phone_))),COUNT(__d1(__NN(Orig_Phone_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrigCarrierName',COUNT(__d1(__NL(Orig_Carrier_Name_))),COUNT(__d1(__NN(Orig_Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecType',COUNT(__d1(__NL(Rec_Type_))),COUNT(__d1(__NN(Rec_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentRec',COUNT(__d1(__NL(Current_Rec_))),COUNT(__d1(__NN(Current_Rec_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IngestTPE',COUNT(__d1(__NL(Ingest_T_P_E_))),COUNT(__d1(__NN(Ingest_T_P_E_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Verified',COUNT(__d1(__NL(Verified_))),COUNT(__d1(__NN(Verified_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CordCutter',COUNT(__d1(__NL(Cord_Cutter_))),COUNT(__d1(__NN(Cord_Cutter_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActivityStatus',COUNT(__d1(__NL(Activity_Status_))),COUNT(__d1(__NN(Activity_Status_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Prepaid',COUNT(__d1(__NL(Prepaid_))),COUNT(__d1(__NN(Prepaid_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Serv',COUNT(__d1(__NL(Serv_))),COUNT(__d1(__NN(Serv_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Line',COUNT(__d1(__NL(Line_))),COUNT(__d1(__NN(Line_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d1(__NL(Original_Source_))),COUNT(__d1(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_InfutorCID__Key_Phone_Invalid),COUNT(__d2)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d2(__NL(Phone10_))),COUNT(__d2(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d2(__NL(Listing_Type_))),COUNT(__d2(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d2(__NL(Publish_Code_))),COUNT(__d2(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d2(__NL(Prior_Area_Code_))),COUNT(__d2(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d2(__NL(Is_Active_))),COUNT(__d2(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d2(__NL(Carrier_Name_))),COUNT(__d2(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d2(__NL(Omit_Indicator_))),COUNT(__d2(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d2(__NL(Current_Flag_))),COUNT(__d2(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d2(__NL(Business_Flag_))),COUNT(__d2(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec_type',COUNT(__d2(__NL(Record_Type_))),COUNT(__d2(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d2(__NL(Source_File_))),COUNT(__d2(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d2(__NL(Iver_Indicator_))),COUNT(__d2(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d2(__NL(Validation_Flag_))),COUNT(__d2(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskSIC',COUNT(__d2(__NL(High_Risk_S_I_C_))),COUNT(__d2(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskNAICS',COUNT(__d2(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d2(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HouseholdFlag',COUNT(__d2(__NL(Household_Flag_))),COUNT(__d2(__NN(Household_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneDateVendorFirstReported',COUNT(__d2(__NL(Phone_Date_Vendor_First_Reported_))),COUNT(__d2(__NN(Phone_Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneDateVendorLastReported',COUNT(__d2(__NL(Phone_Date_Vendor_Last_Reported_))),COUNT(__d2(__NN(Phone_Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrigPhone',COUNT(__d2(__NL(Orig_Phone_))),COUNT(__d2(__NN(Orig_Phone_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrigCarrierName',COUNT(__d2(__NL(Orig_Carrier_Name_))),COUNT(__d2(__NN(Orig_Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecType',COUNT(__d2(__NL(Rec_Type_))),COUNT(__d2(__NN(Rec_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentRec',COUNT(__d2(__NL(Current_Rec_))),COUNT(__d2(__NN(Current_Rec_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IngestTPE',COUNT(__d2(__NL(Ingest_T_P_E_))),COUNT(__d2(__NN(Ingest_T_P_E_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Verified',COUNT(__d2(__NL(Verified_))),COUNT(__d2(__NN(Verified_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CordCutter',COUNT(__d2(__NL(Cord_Cutter_))),COUNT(__d2(__NN(Cord_Cutter_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActivityStatus',COUNT(__d2(__NL(Activity_Status_))),COUNT(__d2(__NN(Activity_Status_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Prepaid',COUNT(__d2(__NL(Prepaid_))),COUNT(__d2(__NN(Prepaid_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Serv',COUNT(__d2(__NL(Serv_))),COUNT(__d2(__NN(Serv_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Line',COUNT(__d2(__NL(Line_))),COUNT(__d2(__NN(Line_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d2(__NL(Original_Source_))),COUNT(__d2(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_Iverification__Keys_Iverification_Phone_Invalid),COUNT(__d3)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Phone_Iver',COUNT(__d3(__NL(Phone10_))),COUNT(__d3(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d3(__NL(Listing_Type_))),COUNT(__d3(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d3(__NL(Publish_Code_))),COUNT(__d3(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d3(__NL(Prior_Area_Code_))),COUNT(__d3(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d3(__NL(Is_Active_))),COUNT(__d3(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d3(__NL(Carrier_Name_))),COUNT(__d3(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d3(__NL(Omit_Indicator_))),COUNT(__d3(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_rec',COUNT(__d3(__NL(Current_Flag_))),COUNT(__d3(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d3(__NL(Business_Flag_))),COUNT(__d3(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec_type',COUNT(__d3(__NL(Record_Type_))),COUNT(__d3(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','file_source',COUNT(__d3(__NL(Source_File_))),COUNT(__d3(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','iver_indicator',COUNT(__d3(__NL(Iver_Indicator_))),COUNT(__d3(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d3(__NL(Validation_Flag_))),COUNT(__d3(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskSIC',COUNT(__d3(__NL(High_Risk_S_I_C_))),COUNT(__d3(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskNAICS',COUNT(__d3(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d3(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HouseholdFlag',COUNT(__d3(__NL(Household_Flag_))),COUNT(__d3(__NN(Household_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneDateVendorFirstReported',COUNT(__d3(__NL(Phone_Date_Vendor_First_Reported_))),COUNT(__d3(__NN(Phone_Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneDateVendorLastReported',COUNT(__d3(__NL(Phone_Date_Vendor_Last_Reported_))),COUNT(__d3(__NN(Phone_Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrigPhone',COUNT(__d3(__NL(Orig_Phone_))),COUNT(__d3(__NN(Orig_Phone_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrigCarrierName',COUNT(__d3(__NL(Orig_Carrier_Name_))),COUNT(__d3(__NN(Orig_Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecType',COUNT(__d3(__NL(Rec_Type_))),COUNT(__d3(__NN(Rec_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentRec',COUNT(__d3(__NL(Current_Rec_))),COUNT(__d3(__NN(Current_Rec_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IngestTPE',COUNT(__d3(__NL(Ingest_T_P_E_))),COUNT(__d3(__NN(Ingest_T_P_E_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Verified',COUNT(__d3(__NL(Verified_))),COUNT(__d3(__NN(Verified_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CordCutter',COUNT(__d3(__NL(Cord_Cutter_))),COUNT(__d3(__NN(Cord_Cutter_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActivityStatus',COUNT(__d3(__NL(Activity_Status_))),COUNT(__d3(__NN(Activity_Status_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Prepaid',COUNT(__d3(__NL(Prepaid_))),COUNT(__d3(__NN(Prepaid_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Serv',COUNT(__d3(__NL(Serv_))),COUNT(__d3(__NN(Serv_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Line',COUNT(__d3(__NL(Line_))),COUNT(__d3(__NN(Line_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d3(__NL(Original_Source_))),COUNT(__d3(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d3(Hybrid_Archive_Date_=0)),COUNT(__d3(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d3(Vault_Date_Last_Seen_=0)),COUNT(__d3(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Key_CellPhone__Key_Neustar_Phone_Invalid),COUNT(__d4)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cellphone',COUNT(__d4(__NL(Phone10_))),COUNT(__d4(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d4(__NL(Listing_Type_))),COUNT(__d4(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d4(__NL(Publish_Code_))),COUNT(__d4(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d4(__NL(Prior_Area_Code_))),COUNT(__d4(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d4(__NL(Is_Active_))),COUNT(__d4(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d4(__NL(Carrier_Name_))),COUNT(__d4(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d4(__NL(Omit_Indicator_))),COUNT(__d4(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d4(__NL(Current_Flag_))),COUNT(__d4(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d4(__NL(Business_Flag_))),COUNT(__d4(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d4(__NL(Record_Type_))),COUNT(__d4(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d4(__NL(Source_File_))),COUNT(__d4(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d4(__NL(Iver_Indicator_))),COUNT(__d4(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d4(__NL(Validation_Flag_))),COUNT(__d4(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskSIC',COUNT(__d4(__NL(High_Risk_S_I_C_))),COUNT(__d4(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskNAICS',COUNT(__d4(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d4(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HouseholdFlag',COUNT(__d4(__NL(Household_Flag_))),COUNT(__d4(__NN(Household_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneDateVendorFirstReported',COUNT(__d4(__NL(Phone_Date_Vendor_First_Reported_))),COUNT(__d4(__NN(Phone_Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneDateVendorLastReported',COUNT(__d4(__NL(Phone_Date_Vendor_Last_Reported_))),COUNT(__d4(__NN(Phone_Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrigPhone',COUNT(__d4(__NL(Orig_Phone_))),COUNT(__d4(__NN(Orig_Phone_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrigCarrierName',COUNT(__d4(__NL(Orig_Carrier_Name_))),COUNT(__d4(__NN(Orig_Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecType',COUNT(__d4(__NL(Rec_Type_))),COUNT(__d4(__NN(Rec_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentRec',COUNT(__d4(__NL(Current_Rec_))),COUNT(__d4(__NN(Current_Rec_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IngestTPE',COUNT(__d4(__NL(Ingest_T_P_E_))),COUNT(__d4(__NN(Ingest_T_P_E_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Verified',COUNT(__d4(__NL(Verified_))),COUNT(__d4(__NN(Verified_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CordCutter',COUNT(__d4(__NL(Cord_Cutter_))),COUNT(__d4(__NN(Cord_Cutter_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActivityStatus',COUNT(__d4(__NL(Activity_Status_))),COUNT(__d4(__NN(Activity_Status_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Prepaid',COUNT(__d4(__NL(Prepaid_))),COUNT(__d4(__NN(Prepaid_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Serv',COUNT(__d4(__NL(Serv_))),COUNT(__d4(__NN(Serv_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Line',COUNT(__d4(__NL(Line_))),COUNT(__d4(__NN(Line_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d4(__NL(Original_Source_))),COUNT(__d4(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d4(Archive___Date_=0)),COUNT(__d4(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d4(Hybrid_Archive_Date_=0)),COUNT(__d4(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d4(Vault_Date_Last_Seen_=0)),COUNT(__d4(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_FraudPoint3__Key_Phone_Invalid),COUNT(__d5)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone_number',COUNT(__d5(__NL(Phone10_))),COUNT(__d5(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d5(__NL(Listing_Type_))),COUNT(__d5(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d5(__NL(Publish_Code_))),COUNT(__d5(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d5(__NL(Prior_Area_Code_))),COUNT(__d5(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d5(__NL(Is_Active_))),COUNT(__d5(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d5(__NL(Carrier_Name_))),COUNT(__d5(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d5(__NL(Omit_Indicator_))),COUNT(__d5(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d5(__NL(Current_Flag_))),COUNT(__d5(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d5(__NL(Business_Flag_))),COUNT(__d5(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d5(__NL(Record_Type_))),COUNT(__d5(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d5(__NL(Source_File_))),COUNT(__d5(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d5(__NL(Iver_Indicator_))),COUNT(__d5(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d5(__NL(Validation_Flag_))),COUNT(__d5(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskSIC',COUNT(__d5(__NL(High_Risk_S_I_C_))),COUNT(__d5(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskNAICS',COUNT(__d5(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d5(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HouseholdFlag',COUNT(__d5(__NL(Household_Flag_))),COUNT(__d5(__NN(Household_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneDateVendorFirstReported',COUNT(__d5(__NL(Phone_Date_Vendor_First_Reported_))),COUNT(__d5(__NN(Phone_Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneDateVendorLastReported',COUNT(__d5(__NL(Phone_Date_Vendor_Last_Reported_))),COUNT(__d5(__NN(Phone_Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrigPhone',COUNT(__d5(__NL(Orig_Phone_))),COUNT(__d5(__NN(Orig_Phone_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrigCarrierName',COUNT(__d5(__NL(Orig_Carrier_Name_))),COUNT(__d5(__NN(Orig_Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec_type',COUNT(__d5(__NL(Rec_Type_))),COUNT(__d5(__NN(Rec_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentRec',COUNT(__d5(__NL(Current_Rec_))),COUNT(__d5(__NN(Current_Rec_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IngestTPE',COUNT(__d5(__NL(Ingest_T_P_E_))),COUNT(__d5(__NN(Ingest_T_P_E_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Verified',COUNT(__d5(__NL(Verified_))),COUNT(__d5(__NN(Verified_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CordCutter',COUNT(__d5(__NL(Cord_Cutter_))),COUNT(__d5(__NN(Cord_Cutter_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActivityStatus',COUNT(__d5(__NL(Activity_Status_))),COUNT(__d5(__NN(Activity_Status_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Prepaid',COUNT(__d5(__NL(Prepaid_))),COUNT(__d5(__NN(Prepaid_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Serv',COUNT(__d5(__NL(Serv_))),COUNT(__d5(__NN(Serv_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Line',COUNT(__d5(__NL(Line_))),COUNT(__d5(__NN(Line_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d5(__NL(Original_Source_))),COUNT(__d5(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d5(Archive___Date_=0)),COUNT(__d5(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d5(Hybrid_Archive_Date_=0)),COUNT(__d5(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d5(Vault_Date_Last_Seen_=0)),COUNT(__d5(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_dx_PhonesInfo__Key_Phones_Type_Invalid),COUNT(__d6)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d6(__NL(Phone10_))),COUNT(__d6(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d6(__NL(Listing_Type_))),COUNT(__d6(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d6(__NL(Publish_Code_))),COUNT(__d6(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d6(__NL(Prior_Area_Code_))),COUNT(__d6(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d6(__NL(Is_Active_))),COUNT(__d6(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d6(__NL(Carrier_Name_))),COUNT(__d6(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d6(__NL(Omit_Indicator_))),COUNT(__d6(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d6(__NL(Current_Flag_))),COUNT(__d6(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d6(__NL(Business_Flag_))),COUNT(__d6(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d6(__NL(Record_Type_))),COUNT(__d6(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d6(__NL(Source_File_))),COUNT(__d6(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d6(__NL(Iver_Indicator_))),COUNT(__d6(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d6(__NL(Validation_Flag_))),COUNT(__d6(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskSIC',COUNT(__d6(__NL(High_Risk_S_I_C_))),COUNT(__d6(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskNAICS',COUNT(__d6(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d6(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HouseholdFlag',COUNT(__d6(__NL(Household_Flag_))),COUNT(__d6(__NN(Household_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vendor_first_reported_dt',COUNT(__d6(__NL(Phone_Date_Vendor_First_Reported_))),COUNT(__d6(__NN(Phone_Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vendor_last_reported_dt',COUNT(__d6(__NL(Phone_Date_Vendor_Last_Reported_))),COUNT(__d6(__NN(Phone_Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrigPhone',COUNT(__d6(__NL(Orig_Phone_))),COUNT(__d6(__NN(Orig_Phone_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrigCarrierName',COUNT(__d6(__NL(Orig_Carrier_Name_))),COUNT(__d6(__NN(Orig_Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecType',COUNT(__d6(__NL(Rec_Type_))),COUNT(__d6(__NN(Rec_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentRec',COUNT(__d6(__NL(Current_Rec_))),COUNT(__d6(__NN(Current_Rec_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IngestTPE',COUNT(__d6(__NL(Ingest_T_P_E_))),COUNT(__d6(__NN(Ingest_T_P_E_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Verified',COUNT(__d6(__NL(Verified_))),COUNT(__d6(__NN(Verified_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CordCutter',COUNT(__d6(__NL(Cord_Cutter_))),COUNT(__d6(__NN(Cord_Cutter_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActivityStatus',COUNT(__d6(__NL(Activity_Status_))),COUNT(__d6(__NN(Activity_Status_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prepaid',COUNT(__d6(__NL(Prepaid_))),COUNT(__d6(__NN(Prepaid_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','serv',COUNT(__d6(__NL(Serv_))),COUNT(__d6(__NN(Serv_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','line',COUNT(__d6(__NL(Line_))),COUNT(__d6(__NN(Line_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d6(__NL(Source_))),COUNT(__d6(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d6(__NL(Original_Source_))),COUNT(__d6(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d6(Archive___Date_=0)),COUNT(__d6(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d6(Hybrid_Archive_Date_=0)),COUNT(__d6(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d6(Vault_Date_Last_Seen_=0)),COUNT(__d6(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_dx_PhonesInfo__Key_Phones_Transaction_Invalid),COUNT(__d7)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d7(__NL(Phone10_))),COUNT(__d7(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d7(__NL(Listing_Type_))),COUNT(__d7(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d7(__NL(Publish_Code_))),COUNT(__d7(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d7(__NL(Prior_Area_Code_))),COUNT(__d7(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d7(__NL(Is_Active_))),COUNT(__d7(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','carrier_name',COUNT(__d7(__NL(Carrier_Name_))),COUNT(__d7(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d7(__NL(Omit_Indicator_))),COUNT(__d7(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d7(__NL(Current_Flag_))),COUNT(__d7(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d7(__NL(Business_Flag_))),COUNT(__d7(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d7(__NL(Record_Type_))),COUNT(__d7(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d7(__NL(Source_File_))),COUNT(__d7(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d7(__NL(Iver_Indicator_))),COUNT(__d7(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d7(__NL(Validation_Flag_))),COUNT(__d7(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskSIC',COUNT(__d7(__NL(High_Risk_S_I_C_))),COUNT(__d7(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskNAICS',COUNT(__d7(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d7(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HouseholdFlag',COUNT(__d7(__NL(Household_Flag_))),COUNT(__d7(__NN(Household_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vendor_first_reported_dt',COUNT(__d7(__NL(Phone_Date_Vendor_First_Reported_))),COUNT(__d7(__NN(Phone_Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vendor_last_reported_dt',COUNT(__d7(__NL(Phone_Date_Vendor_Last_Reported_))),COUNT(__d7(__NN(Phone_Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrigPhone',COUNT(__d7(__NL(Orig_Phone_))),COUNT(__d7(__NN(Orig_Phone_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrigCarrierName',COUNT(__d7(__NL(Orig_Carrier_Name_))),COUNT(__d7(__NN(Orig_Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecType',COUNT(__d7(__NL(Rec_Type_))),COUNT(__d7(__NN(Rec_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentRec',COUNT(__d7(__NL(Current_Rec_))),COUNT(__d7(__NN(Current_Rec_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IngestTPE',COUNT(__d7(__NL(Ingest_T_P_E_))),COUNT(__d7(__NN(Ingest_T_P_E_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Verified',COUNT(__d7(__NL(Verified_))),COUNT(__d7(__NN(Verified_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CordCutter',COUNT(__d7(__NL(Cord_Cutter_))),COUNT(__d7(__NN(Cord_Cutter_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActivityStatus',COUNT(__d7(__NL(Activity_Status_))),COUNT(__d7(__NN(Activity_Status_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Prepaid',COUNT(__d7(__NL(Prepaid_))),COUNT(__d7(__NN(Prepaid_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Serv',COUNT(__d7(__NL(Serv_))),COUNT(__d7(__NN(Serv_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Line',COUNT(__d7(__NL(Line_))),COUNT(__d7(__NN(Line_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d7(__NL(Source_))),COUNT(__d7(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d7(__NL(Original_Source_))),COUNT(__d7(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d7(Archive___Date_=0)),COUNT(__d7(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d7(Date_First_Seen_=0)),COUNT(__d7(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d7(Date_Last_Seen_=0)),COUNT(__d7(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d7(Hybrid_Archive_Date_=0)),COUNT(__d7(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d7(Vault_Date_Last_Seen_=0)),COUNT(__d7(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PhonesPlus_v2__Key_Source_Level_Payload_Invalid),COUNT(__d8)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cellphone',COUNT(__d8(__NL(Phone10_))),COUNT(__d8(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d8(__NL(Listing_Type_))),COUNT(__d8(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d8(__NL(Publish_Code_))),COUNT(__d8(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d8(__NL(Prior_Area_Code_))),COUNT(__d8(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d8(__NL(Is_Active_))),COUNT(__d8(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d8(__NL(Carrier_Name_))),COUNT(__d8(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d8(__NL(Omit_Indicator_))),COUNT(__d8(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d8(__NL(Current_Flag_))),COUNT(__d8(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d8(__NL(Business_Flag_))),COUNT(__d8(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d8(__NL(Record_Type_))),COUNT(__d8(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d8(__NL(Source_File_))),COUNT(__d8(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d8(__NL(Iver_Indicator_))),COUNT(__d8(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d8(__NL(Validation_Flag_))),COUNT(__d8(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskSIC',COUNT(__d8(__NL(High_Risk_S_I_C_))),COUNT(__d8(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskNAICS',COUNT(__d8(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d8(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','household_flag',COUNT(__d8(__NL(Household_Flag_))),COUNT(__d8(__NN(Household_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','datevendorfirstreported',COUNT(__d8(__NL(Phone_Date_Vendor_First_Reported_))),COUNT(__d8(__NN(Phone_Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','datevendorlastreported',COUNT(__d8(__NL(Phone_Date_Vendor_Last_Reported_))),COUNT(__d8(__NN(Phone_Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_phone',COUNT(__d8(__NL(Orig_Phone_))),COUNT(__d8(__NN(Orig_Phone_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_carrier_name',COUNT(__d8(__NL(Orig_Carrier_Name_))),COUNT(__d8(__NN(Orig_Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec_type',COUNT(__d8(__NL(Rec_Type_))),COUNT(__d8(__NN(Rec_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_rec',COUNT(__d8(__NL(Current_Rec_))),COUNT(__d8(__NN(Current_Rec_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ingest_tpe',COUNT(__d8(__NL(Ingest_T_P_E_))),COUNT(__d8(__NN(Ingest_T_P_E_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','verified',COUNT(__d8(__NL(Verified_))),COUNT(__d8(__NN(Verified_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cord_cutter',COUNT(__d8(__NL(Cord_Cutter_))),COUNT(__d8(__NN(Cord_Cutter_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','activity_status',COUNT(__d8(__NL(Activity_Status_))),COUNT(__d8(__NN(Activity_Status_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prepaid',COUNT(__d8(__NL(Prepaid_))),COUNT(__d8(__NN(Prepaid_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Serv',COUNT(__d8(__NL(Serv_))),COUNT(__d8(__NN(Serv_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Line',COUNT(__d8(__NL(Line_))),COUNT(__d8(__NN(Line_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d8(__NL(Source_))),COUNT(__d8(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d8(__NL(Original_Source_))),COUNT(__d8(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d8(Archive___Date_=0)),COUNT(__d8(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d8(Date_First_Seen_=0)),COUNT(__d8(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d8(Date_Last_Seen_=0)),COUNT(__d8(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d8(Hybrid_Archive_Date_=0)),COUNT(__d8(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d8(Vault_Date_Last_Seen_=0)),COUNT(__d8(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2_Build__key_high_risk_industries_phone_Invalid),COUNT(__d9)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_phone',COUNT(__d9(__NL(Phone10_))),COUNT(__d9(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d9(__NL(Listing_Type_))),COUNT(__d9(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d9(__NL(Publish_Code_))),COUNT(__d9(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d9(__NL(Prior_Area_Code_))),COUNT(__d9(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d9(__NL(Is_Active_))),COUNT(__d9(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d9(__NL(Carrier_Name_))),COUNT(__d9(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d9(__NL(Omit_Indicator_))),COUNT(__d9(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d9(__NL(Current_Flag_))),COUNT(__d9(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d9(__NL(Business_Flag_))),COUNT(__d9(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d9(__NL(Record_Type_))),COUNT(__d9(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d9(__NL(Source_File_))),COUNT(__d9(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d9(__NL(Iver_Indicator_))),COUNT(__d9(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d9(__NL(Validation_Flag_))),COUNT(__d9(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SIC_Code',COUNT(__d9(__NL(High_Risk_S_I_C_))),COUNT(__d9(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NAICS_Code',COUNT(__d9(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d9(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HouseholdFlag',COUNT(__d9(__NL(Household_Flag_))),COUNT(__d9(__NN(Household_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneDateVendorFirstReported',COUNT(__d9(__NL(Phone_Date_Vendor_First_Reported_))),COUNT(__d9(__NN(Phone_Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneDateVendorLastReported',COUNT(__d9(__NL(Phone_Date_Vendor_Last_Reported_))),COUNT(__d9(__NN(Phone_Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrigPhone',COUNT(__d9(__NL(Orig_Phone_))),COUNT(__d9(__NN(Orig_Phone_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OrigCarrierName',COUNT(__d9(__NL(Orig_Carrier_Name_))),COUNT(__d9(__NN(Orig_Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecType',COUNT(__d9(__NL(Rec_Type_))),COUNT(__d9(__NN(Rec_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentRec',COUNT(__d9(__NL(Current_Rec_))),COUNT(__d9(__NN(Current_Rec_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IngestTPE',COUNT(__d9(__NL(Ingest_T_P_E_))),COUNT(__d9(__NN(Ingest_T_P_E_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Verified',COUNT(__d9(__NL(Verified_))),COUNT(__d9(__NN(Verified_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CordCutter',COUNT(__d9(__NL(Cord_Cutter_))),COUNT(__d9(__NN(Cord_Cutter_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActivityStatus',COUNT(__d9(__NL(Activity_Status_))),COUNT(__d9(__NN(Activity_Status_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Prepaid',COUNT(__d9(__NL(Prepaid_))),COUNT(__d9(__NN(Prepaid_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Serv',COUNT(__d9(__NL(Serv_))),COUNT(__d9(__NN(Serv_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Line',COUNT(__d9(__NL(Line_))),COUNT(__d9(__NN(Line_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d9(__NL(Source_))),COUNT(__d9(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d9(__NL(Original_Source_))),COUNT(__d9(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d9(Archive___Date_=0)),COUNT(__d9(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d9(Date_First_Seen_=0)),COUNT(__d9(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d9(Date_Last_Seen_=0)),COUNT(__d9(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d9(Hybrid_Archive_Date_=0)),COUNT(__d9(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d9(Vault_Date_Last_Seen_=0)),COUNT(__d9(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
