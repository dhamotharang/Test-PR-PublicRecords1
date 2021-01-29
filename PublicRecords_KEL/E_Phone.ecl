//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_Phone(CFG_Compile __cfg = CFG_Compile) := MODULE
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
    KEL.typ.nint Record_S_I_D_;
    KEL.typ.nbool Household_Flag_;
    KEL.typ.nstr Cell_Phone_;
    KEL.typ.nstr N_P_A_;
    KEL.typ.nstr Phone7_;
    KEL.typ.nint D_I_D_;
    KEL.typ.nstr D_I_D_Score_;
    KEL.typ.nkdate Phone_Date_First_Seen_;
    KEL.typ.nkdate Phone_Date_Last_Seen_;
    KEL.typ.nkdate Phone_Date_Vendor_First_Reported_;
    KEL.typ.nkdate Phone_Date_Vendor_Last_Reported_;
    KEL.typ.nint D_T_Non_G_L_B_Last_Seen_;
    KEL.typ.nstr G_L_B_D_P_P_A_Flag_;
    KEL.typ.nstr D_I_D_Type_;
    KEL.typ.nstr Orig_Phone_;
    KEL.typ.nstr Orig_Carrier_Name_;
    KEL.typ.nstr Rec_Type_;
    KEL.typ.nstr Err_Stat_;
    KEL.typ.nint Rawaid_;
    KEL.typ.nint Cleanaid_;
    KEL.typ.nbool Current_Rec_;
    KEL.typ.nkdate First_Build_Date_;
    KEL.typ.nkdate Last_Build_Date_;
    KEL.typ.nint Ingest_T_P_E_;
    KEL.typ.nstr Verified_;
    KEL.typ.nstr Cord_Cutter_;
    KEL.typ.nstr Activity_Status_;
    KEL.typ.nstr Prepaid_;
    KEL.typ.nint Global_S_I_D_;
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
  SHARED __Mapping := 'phone10(DEFAULT:UID|DEFAULT:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),recordsid(DEFAULT:Record_S_I_D_:0),householdflag(DEFAULT:Household_Flag_),cellphone(DEFAULT:Cell_Phone_:\'\'),npa(DEFAULT:N_P_A_:\'\'),phone7(DEFAULT:Phone7_:\'\'),did(DEFAULT:D_I_D_:0),didscore(DEFAULT:D_I_D_Score_:\'\'),phonedatefirstseen(DEFAULT:Phone_Date_First_Seen_:DATE),phonedatelastseen(DEFAULT:Phone_Date_Last_Seen_:DATE),phonedatevendorfirstreported(DEFAULT:Phone_Date_Vendor_First_Reported_:DATE),phonedatevendorlastreported(DEFAULT:Phone_Date_Vendor_Last_Reported_:DATE),dtnonglblastseen(DEFAULT:D_T_Non_G_L_B_Last_Seen_:0),glbdppaflag(DEFAULT:G_L_B_D_P_P_A_Flag_:\'\'),didtype(DEFAULT:D_I_D_Type_:\'\'),origphone(DEFAULT:Orig_Phone_:\'\'),origcarriername(DEFAULT:Orig_Carrier_Name_:\'\'),rectype(DEFAULT:Rec_Type_:\'\'),errstat(DEFAULT:Err_Stat_:\'\'),rawaid(DEFAULT:Rawaid_:0),cleanaid(DEFAULT:Cleanaid_:0),currentrec(DEFAULT:Current_Rec_),firstbuilddate(DEFAULT:First_Build_Date_:DATE),lastbuilddate(DEFAULT:Last_Build_Date_:DATE),ingesttpe(DEFAULT:Ingest_T_P_E_:0),verified(DEFAULT:Verified_:\'\'),cordcutter(DEFAULT:Cord_Cutter_:\'\'),activitystatus(DEFAULT:Activity_Status_:\'\'),prepaid(DEFAULT:Prepaid_:\'\'),globalsid(DEFAULT:Global_S_I_D_:0),source(DEFAULT:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED Hybrid_Archive_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'phone10(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listing_type(OVERRIDE:Listing_Type_:\'\'),publish_code(OVERRIDE:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),prior_area_code(OVERRIDE:Prior_Area_Code_:\'\'),current_record_flag(OVERRIDE:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omit_phone(OVERRIDE:Omit_Indicator_:\'\'),current_flag(OVERRIDE:Current_Flag_:\'\'),business_flag(OVERRIDE:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),recordsid(DEFAULT:Record_S_I_D_:0),householdflag(DEFAULT:Household_Flag_),cellphone(DEFAULT:Cell_Phone_:\'\'),npa(DEFAULT:N_P_A_:\'\'),phone7(DEFAULT:Phone7_:\'\'),did(DEFAULT:D_I_D_:0),didscore(DEFAULT:D_I_D_Score_:\'\'),phonedatefirstseen(DEFAULT:Phone_Date_First_Seen_:DATE),phonedatelastseen(DEFAULT:Phone_Date_Last_Seen_:DATE),phonedatevendorfirstreported(DEFAULT:Phone_Date_Vendor_First_Reported_:DATE),phonedatevendorlastreported(DEFAULT:Phone_Date_Vendor_Last_Reported_:DATE),dtnonglblastseen(DEFAULT:D_T_Non_G_L_B_Last_Seen_:0),glbdppaflag(DEFAULT:G_L_B_D_P_P_A_Flag_:\'\'),didtype(DEFAULT:D_I_D_Type_:\'\'),origphone(DEFAULT:Orig_Phone_:\'\'),origcarriername(DEFAULT:Orig_Carrier_Name_:\'\'),rectype(DEFAULT:Rec_Type_:\'\'),errstat(DEFAULT:Err_Stat_:\'\'),rawaid(DEFAULT:Rawaid_:0),cleanaid(DEFAULT:Cleanaid_:0),currentrec(DEFAULT:Current_Rec_),firstbuilddate(DEFAULT:First_Build_Date_:DATE),lastbuilddate(DEFAULT:Last_Build_Date_:DATE),ingesttpe(DEFAULT:Ingest_T_P_E_:0),verified(DEFAULT:Verified_:\'\'),cordcutter(DEFAULT:Cord_Cutter_:\'\'),activitystatus(DEFAULT:Activity_Status_:\'\'),prepaid(DEFAULT:Prepaid_:\'\'),globalsid(DEFAULT:Global_S_I_D_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_0Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d0_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault((UNSIGNED)phone10 != 0);
  EXPORT PublicRecords_KEL_Files_NonFCRA_Gong__Key_History_Phone_Vault_Invalid := __d0_KELfiltered((KEL.typ.uid)phone10 = 0);
  SHARED __d0_Prefiltered := __d0_KELfiltered((KEL.typ.uid)phone10 <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault'));
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'phone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),current_rec(OVERRIDE:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),rec_type(OVERRIDE:Record_Type_:\'\'),file_source(OVERRIDE:Source_File_:0),iver_indicator(OVERRIDE:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),recordsid(DEFAULT:Record_S_I_D_:0),householdflag(DEFAULT:Household_Flag_),cellphone(DEFAULT:Cell_Phone_:\'\'),npa(DEFAULT:N_P_A_:\'\'),phone7(DEFAULT:Phone7_:\'\'),did(DEFAULT:D_I_D_:0),didscore(DEFAULT:D_I_D_Score_:\'\'),phonedatefirstseen(DEFAULT:Phone_Date_First_Seen_:DATE),phonedatelastseen(DEFAULT:Phone_Date_Last_Seen_:DATE),phonedatevendorfirstreported(DEFAULT:Phone_Date_Vendor_First_Reported_:DATE),phonedatevendorlastreported(DEFAULT:Phone_Date_Vendor_Last_Reported_:DATE),dtnonglblastseen(DEFAULT:D_T_Non_G_L_B_Last_Seen_:0),glbdppaflag(DEFAULT:G_L_B_D_P_P_A_Flag_:\'\'),didtype(DEFAULT:D_I_D_Type_:\'\'),origphone(DEFAULT:Orig_Phone_:\'\'),origcarriername(DEFAULT:Orig_Carrier_Name_:\'\'),rectype(DEFAULT:Rec_Type_:\'\'),errstat(DEFAULT:Err_Stat_:\'\'),rawaid(DEFAULT:Rawaid_:0),cleanaid(DEFAULT:Cleanaid_:0),currentrec(DEFAULT:Current_Rec_),firstbuilddate(DEFAULT:First_Build_Date_:DATE),lastbuilddate(DEFAULT:Last_Build_Date_:DATE),ingesttpe(DEFAULT:Ingest_T_P_E_:0),verified(DEFAULT:Verified_:\'\'),cordcutter(DEFAULT:Cord_Cutter_:\'\'),activitystatus(DEFAULT:Activity_Status_:\'\'),prepaid(DEFAULT:Prepaid_:\'\'),globalsid(DEFAULT:Global_S_I_D_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_1Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d1_KELfiltered := PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA((UNSIGNED)phone != 0);
  EXPORT PublicRecords_KEL_Files_NonFCRA_PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA_Invalid := __d1_KELfiltered((KEL.typ.uid)phone = 0);
  SHARED __d1_Prefiltered := __d1_KELfiltered((KEL.typ.uid)phone <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA'));
  SHARED __Mapping2 := 'cellphone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'|DEFAULT:Cell_Phone_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),recordsid(DEFAULT:Record_S_I_D_:0),householdflag(DEFAULT:Household_Flag_),npa(DEFAULT:N_P_A_:\'\'),phone7(DEFAULT:Phone7_:\'\'),did(DEFAULT:D_I_D_:0),didscore(DEFAULT:D_I_D_Score_:\'\'),phonedatefirstseen(DEFAULT:Phone_Date_First_Seen_:DATE),phonedatelastseen(DEFAULT:Phone_Date_Last_Seen_:DATE),phonedatevendorfirstreported(DEFAULT:Phone_Date_Vendor_First_Reported_:DATE),phonedatevendorlastreported(DEFAULT:Phone_Date_Vendor_Last_Reported_:DATE),dtnonglblastseen(DEFAULT:D_T_Non_G_L_B_Last_Seen_:0),glbdppaflag(DEFAULT:G_L_B_D_P_P_A_Flag_:\'\'),didtype(DEFAULT:D_I_D_Type_:\'\'),origphone(DEFAULT:Orig_Phone_:\'\'),origcarriername(DEFAULT:Orig_Carrier_Name_:\'\'),rectype(DEFAULT:Rec_Type_:\'\'),errstat(DEFAULT:Err_Stat_:\'\'),rawaid(DEFAULT:Rawaid_:0),cleanaid(DEFAULT:Cleanaid_:0),currentrec(DEFAULT:Current_Rec_),firstbuilddate(DEFAULT:First_Build_Date_:DATE),lastbuilddate(DEFAULT:Last_Build_Date_:DATE),ingesttpe(DEFAULT:Ingest_T_P_E_:0),verified(DEFAULT:Verified_:\'\'),cordcutter(DEFAULT:Cord_Cutter_:\'\'),activitystatus(DEFAULT:Activity_Status_:\'\'),prepaid(DEFAULT:Prepaid_:\'\'),globalsid(DEFAULT:Global_S_I_D_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d2_KELfiltered := PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone((UNSIGNED)cellphone <> 0);
  EXPORT PublicRecords_KEL_Files_NonFCRA_CellPhone__Key_Nustar_Phone_Invalid := __d2_KELfiltered((KEL.typ.uid)cellphone = 0);
  SHARED __d2_Prefiltered := __d2_KELfiltered((KEL.typ.uid)cellphone <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone'));
  SHARED Phone_Date_Vendor_First_Reported_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Phone_Date_Vendor_Last_Reported_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping3 := 'phone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),record_sid(OVERRIDE:Record_S_I_D_:0),householdflag(DEFAULT:Household_Flag_),cellphone(DEFAULT:Cell_Phone_:\'\'),npa(DEFAULT:N_P_A_:\'\'),phone7(DEFAULT:Phone7_:\'\'),did(DEFAULT:D_I_D_:0),didscore(DEFAULT:D_I_D_Score_:\'\'),phonedatefirstseen(DEFAULT:Phone_Date_First_Seen_:DATE),phonedatelastseen(DEFAULT:Phone_Date_Last_Seen_:DATE),vendor_first_reported_dt(OVERRIDE:Phone_Date_Vendor_First_Reported_:DATE:Phone_Date_Vendor_First_Reported_3Rule),vendor_last_reported_dt(OVERRIDE:Phone_Date_Vendor_Last_Reported_:DATE:Phone_Date_Vendor_Last_Reported_3Rule),dtnonglblastseen(DEFAULT:D_T_Non_G_L_B_Last_Seen_:0),glbdppaflag(DEFAULT:G_L_B_D_P_P_A_Flag_:\'\'),didtype(DEFAULT:D_I_D_Type_:\'\'),origphone(DEFAULT:Orig_Phone_:\'\'),origcarriername(DEFAULT:Orig_Carrier_Name_:\'\'),rectype(DEFAULT:Rec_Type_:\'\'),errstat(DEFAULT:Err_Stat_:\'\'),rawaid(DEFAULT:Rawaid_:0),cleanaid(DEFAULT:Cleanaid_:0),currentrec(DEFAULT:Current_Rec_),firstbuilddate(DEFAULT:First_Build_Date_:DATE),lastbuilddate(DEFAULT:Last_Build_Date_:DATE),ingesttpe(DEFAULT:Ingest_T_P_E_:0),verified(DEFAULT:Verified_:\'\'),cordcutter(DEFAULT:Cord_Cutter_:\'\'),activitystatus(DEFAULT:Activity_Status_:\'\'),prepaid(OVERRIDE:Prepaid_:\'\'),global_sid(OVERRIDE:Global_S_I_D_:0),src(OVERRIDE:Source_:\'\'),source(OVERRIDE:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d3_KELfiltered := PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault((UNSIGNED)phone <> 0);
  EXPORT PublicRecords_KEL_Files_NonFCRA_PhonesInfo__Keys_Phones_Type_Vault_Invalid := __d3_KELfiltered((KEL.typ.uid)phone = 0);
  SHARED __d3_Prefiltered := __d3_KELfiltered((KEL.typ.uid)phone <> 0);
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault'));
  SHARED Phone_Date_Vendor_First_Reported_4Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Phone_Date_Vendor_Last_Reported_4Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping4 := 'phone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carrier_name(OVERRIDE:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),record_sid(OVERRIDE:Record_S_I_D_:0),householdflag(DEFAULT:Household_Flag_),cellphone(DEFAULT:Cell_Phone_:\'\'),npa(DEFAULT:N_P_A_:\'\'),phone7(DEFAULT:Phone7_:\'\'),did(DEFAULT:D_I_D_:0),didscore(DEFAULT:D_I_D_Score_:\'\'),phonedatefirstseen(DEFAULT:Phone_Date_First_Seen_:DATE),phonedatelastseen(DEFAULT:Phone_Date_Last_Seen_:DATE),vendor_first_reported_dt(OVERRIDE:Phone_Date_Vendor_First_Reported_:DATE:Phone_Date_Vendor_First_Reported_4Rule),vendor_last_reported_dt(OVERRIDE:Phone_Date_Vendor_Last_Reported_:DATE:Phone_Date_Vendor_Last_Reported_4Rule),dtnonglblastseen(DEFAULT:D_T_Non_G_L_B_Last_Seen_:0),glbdppaflag(DEFAULT:G_L_B_D_P_P_A_Flag_:\'\'),didtype(DEFAULT:D_I_D_Type_:\'\'),origphone(DEFAULT:Orig_Phone_:\'\'),origcarriername(DEFAULT:Orig_Carrier_Name_:\'\'),rectype(DEFAULT:Rec_Type_:\'\'),errstat(DEFAULT:Err_Stat_:\'\'),rawaid(DEFAULT:Rawaid_:0),cleanaid(DEFAULT:Cleanaid_:0),currentrec(DEFAULT:Current_Rec_),firstbuilddate(DEFAULT:First_Build_Date_:DATE),lastbuilddate(DEFAULT:Last_Build_Date_:DATE),ingesttpe(DEFAULT:Ingest_T_P_E_:0),verified(DEFAULT:Verified_:\'\'),cordcutter(DEFAULT:Cord_Cutter_:\'\'),activitystatus(DEFAULT:Activity_Status_:\'\'),prepaid(DEFAULT:Prepaid_:\'\'),global_sid(OVERRIDE:Global_S_I_D_:0),src(OVERRIDE:Source_:\'\'),source(OVERRIDE:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d4_KELfiltered := PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault((UNSIGNED)phone <> 0);
  EXPORT PublicRecords_KEL_Files_NonFCRA_PhonesInfo__Keys_Phones_Transaction_Vault_Invalid := __d4_KELfiltered((KEL.typ.uid)phone = 0);
  SHARED __d4_Prefiltered := __d4_KELfiltered((KEL.typ.uid)phone <> 0);
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault'));
  SHARED Phone_Date_Vendor_First_Reported_5Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Phone_Date_Vendor_Last_Reported_5Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED First_Build_Date_5Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Last_Build_Date_5Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Date_First_Seen_5Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Date_Last_Seen_5Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping5 := 'cellphone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'|OVERRIDE:Cell_Phone_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),record_sid(OVERRIDE:Record_S_I_D_:0),household_flag(OVERRIDE:Household_Flag_),npa(OVERRIDE:N_P_A_:\'\'),phone7(OVERRIDE:Phone7_:\'\'),did(OVERRIDE:D_I_D_:0),did_score(OVERRIDE:D_I_D_Score_:\'\'),phonedatefirstseen(DEFAULT:Phone_Date_First_Seen_:DATE),phonedatelastseen(DEFAULT:Phone_Date_Last_Seen_:DATE),datevendorfirstreported(OVERRIDE:Phone_Date_Vendor_First_Reported_:DATE:Phone_Date_Vendor_First_Reported_5Rule),datevendorlastreported(OVERRIDE:Phone_Date_Vendor_Last_Reported_:DATE:Phone_Date_Vendor_Last_Reported_5Rule),dt_nonglb_last_seen(OVERRIDE:D_T_Non_G_L_B_Last_Seen_:0),glb_dppa_flag(OVERRIDE:G_L_B_D_P_P_A_Flag_:\'\'),did_type(OVERRIDE:D_I_D_Type_:\'\'),orig_phone(OVERRIDE:Orig_Phone_:\'\'),orig_carrier_name(OVERRIDE:Orig_Carrier_Name_:\'\'),rec_type(OVERRIDE:Rec_Type_:\'\'),err_stat(OVERRIDE:Err_Stat_:\'\'),rawaid(OVERRIDE:Rawaid_:0),cleanaid(OVERRIDE:Cleanaid_:0),current_rec(OVERRIDE:Current_Rec_),first_build_date(OVERRIDE:First_Build_Date_:DATE:First_Build_Date_5Rule),last_build_date(OVERRIDE:Last_Build_Date_:DATE:Last_Build_Date_5Rule),ingest_tpe(OVERRIDE:Ingest_T_P_E_:0),verified(OVERRIDE:Verified_:\'\'),cord_cutter(OVERRIDE:Cord_Cutter_:\'\'),activity_status(OVERRIDE:Activity_Status_:\'\'),prepaid(OVERRIDE:Prepaid_:\'\'),global_sid(OVERRIDE:Global_S_I_D_:0),src(OVERRIDE:Source_:\'\'),source(OVERRIDE:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_5Rule),datelastseen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_5Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d5_KELfiltered := PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault((UNSIGNED)cellphone <> 0);
  EXPORT PublicRecords_KEL_Files_NonFCRA_PhonesPlus_v2_Keys__Source_Level_Payload_Vault_Invalid := __d5_KELfiltered((KEL.typ.uid)cellphone = 0);
  SHARED __d5_Prefiltered := __d5_KELfiltered((KEL.typ.uid)cellphone <> 0);
  SHARED __d5 := __SourceFilter(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault'));
  SHARED __Mapping6 := 'phone_number(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),recordsid(DEFAULT:Record_S_I_D_:0),householdflag(DEFAULT:Household_Flag_),cellphone(DEFAULT:Cell_Phone_:\'\'),npa(DEFAULT:N_P_A_:\'\'),phone7(DEFAULT:Phone7_:\'\'),appended_lexid(OVERRIDE:D_I_D_:0),didscore(DEFAULT:D_I_D_Score_:\'\'),phonedatefirstseen(DEFAULT:Phone_Date_First_Seen_:DATE),phonedatelastseen(DEFAULT:Phone_Date_Last_Seen_:DATE),phonedatevendorfirstreported(DEFAULT:Phone_Date_Vendor_First_Reported_:DATE),phonedatevendorlastreported(DEFAULT:Phone_Date_Vendor_Last_Reported_:DATE),dtnonglblastseen(DEFAULT:D_T_Non_G_L_B_Last_Seen_:0),glbdppaflag(DEFAULT:G_L_B_D_P_P_A_Flag_:\'\'),didtype(DEFAULT:D_I_D_Type_:\'\'),origphone(DEFAULT:Orig_Phone_:\'\'),origcarriername(DEFAULT:Orig_Carrier_Name_:\'\'),rec_type(OVERRIDE:Rec_Type_:\'\'),err_stat(OVERRIDE:Err_Stat_:\'\'),rawaid(DEFAULT:Rawaid_:0),cleanaid(DEFAULT:Cleanaid_:0),currentrec(DEFAULT:Current_Rec_),firstbuilddate(DEFAULT:First_Build_Date_:DATE),lastbuilddate(DEFAULT:Last_Build_Date_:DATE),ingesttpe(DEFAULT:Ingest_T_P_E_:0),verified(DEFAULT:Verified_:\'\'),cordcutter(DEFAULT:Cord_Cutter_:\'\'),activitystatus(DEFAULT:Activity_Status_:\'\'),prepaid(DEFAULT:Prepaid_:\'\'),globalsid(DEFAULT:Global_S_I_D_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d6_KELfiltered := PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault((UNSIGNED)phone_number <> 0);
  EXPORT PublicRecords_KEL_files_NonFCRA_Fraudpoint3__Key_Phone_Vault_Invalid := __d6_KELfiltered((KEL.typ.uid)phone_number = 0);
  SHARED __d6_Prefiltered := __d6_KELfiltered((KEL.typ.uid)phone_number <> 0);
  SHARED __d6 := __SourceFilter(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6,'PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault'));
  SHARED Date_Last_Seen_7Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_7Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping7 := 'phone_number(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validation_flag(OVERRIDE:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),recordsid(DEFAULT:Record_S_I_D_:0),householdflag(DEFAULT:Household_Flag_),cellphone(DEFAULT:Cell_Phone_:\'\'),npa(DEFAULT:N_P_A_:\'\'),phone7(DEFAULT:Phone7_:\'\'),did(DEFAULT:D_I_D_:0),didscore(DEFAULT:D_I_D_Score_:\'\'),phonedatefirstseen(DEFAULT:Phone_Date_First_Seen_:DATE),phonedatelastseen(DEFAULT:Phone_Date_Last_Seen_:DATE),phonedatevendorfirstreported(DEFAULT:Phone_Date_Vendor_First_Reported_:DATE),phonedatevendorlastreported(DEFAULT:Phone_Date_Vendor_Last_Reported_:DATE),dtnonglblastseen(DEFAULT:D_T_Non_G_L_B_Last_Seen_:0),glbdppaflag(DEFAULT:G_L_B_D_P_P_A_Flag_:\'\'),didtype(DEFAULT:D_I_D_Type_:\'\'),origphone(DEFAULT:Orig_Phone_:\'\'),origcarriername(DEFAULT:Orig_Carrier_Name_:\'\'),rectype(DEFAULT:Rec_Type_:\'\'),errstat(DEFAULT:Err_Stat_:\'\'),rawaid(DEFAULT:Rawaid_:0),cleanaid(DEFAULT:Cleanaid_:0),currentrec(DEFAULT:Current_Rec_),firstbuilddate(DEFAULT:First_Build_Date_:DATE),lastbuilddate(DEFAULT:Last_Build_Date_:DATE),ingesttpe(DEFAULT:Ingest_T_P_E_:0),verified(DEFAULT:Verified_:\'\'),cordcutter(DEFAULT:Cord_Cutter_:\'\'),activitystatus(DEFAULT:Activity_Status_:\'\'),prepaid(DEFAULT:Prepaid_:\'\'),globalsid(DEFAULT:Global_S_I_D_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_7Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_7Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d7_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault((UNSIGNED)phone_number != 0);
  EXPORT PublicRecords_KEL_Files_NonFCRA_Targus__Key_Targus_Phone_Vault_Invalid := __d7_KELfiltered((KEL.typ.uid)phone_number = 0);
  SHARED __d7_Prefiltered := __d7_KELfiltered((KEL.typ.uid)phone_number <> 0);
  SHARED __d7 := __SourceFilter(KEL.FromFlat.Convert(__d7_Prefiltered,InLayout,__Mapping7,'PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault'));
  SHARED Date_Last_Seen_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping8 := 'phone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),rec_type(OVERRIDE:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),recordsid(DEFAULT:Record_S_I_D_:0),householdflag(DEFAULT:Household_Flag_),cellphone(DEFAULT:Cell_Phone_:\'\'),npa(DEFAULT:N_P_A_:\'\'),phone7(DEFAULT:Phone7_:\'\'),did(DEFAULT:D_I_D_:0),didscore(DEFAULT:D_I_D_Score_:\'\'),phonedatefirstseen(DEFAULT:Phone_Date_First_Seen_:DATE),phonedatelastseen(DEFAULT:Phone_Date_Last_Seen_:DATE),phonedatevendorfirstreported(DEFAULT:Phone_Date_Vendor_First_Reported_:DATE),phonedatevendorlastreported(DEFAULT:Phone_Date_Vendor_Last_Reported_:DATE),dtnonglblastseen(DEFAULT:D_T_Non_G_L_B_Last_Seen_:0),glbdppaflag(DEFAULT:G_L_B_D_P_P_A_Flag_:\'\'),didtype(DEFAULT:D_I_D_Type_:\'\'),origphone(DEFAULT:Orig_Phone_:\'\'),origcarriername(DEFAULT:Orig_Carrier_Name_:\'\'),rectype(DEFAULT:Rec_Type_:\'\'),errstat(DEFAULT:Err_Stat_:\'\'),rawaid(DEFAULT:Rawaid_:0),cleanaid(DEFAULT:Cleanaid_:0),currentrec(DEFAULT:Current_Rec_),firstbuilddate(DEFAULT:First_Build_Date_:DATE),lastbuilddate(DEFAULT:Last_Build_Date_:DATE),ingesttpe(DEFAULT:Ingest_T_P_E_:0),verified(DEFAULT:Verified_:\'\'),cordcutter(DEFAULT:Cord_Cutter_:\'\'),activitystatus(DEFAULT:Activity_Status_:\'\'),prepaid(DEFAULT:Prepaid_:\'\'),globalsid(DEFAULT:Global_S_I_D_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_8Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_8Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d8_KELfiltered := PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault((UNSIGNED)phone <> 0);
  EXPORT PublicRecords_KEL_Files_NonFCRA_InfutorCID__Key_Infutor_Phone_Vault_Invalid := __d8_KELfiltered((KEL.typ.uid)phone = 0);
  SHARED __d8_Prefiltered := __d8_KELfiltered((KEL.typ.uid)phone <> 0);
  SHARED __d8 := __SourceFilter(KEL.FromFlat.Convert(__d8_Prefiltered,InLayout,__Mapping8,'PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault'));
  SHARED Hybrid_Archive_Date_9Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping9 := 'company_phone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),sic_code(OVERRIDE:High_Risk_S_I_C_:0),naics_code(OVERRIDE:High_Risk_N_A_I_C_S_:0),recordsid(DEFAULT:Record_S_I_D_:0),householdflag(DEFAULT:Household_Flag_),cellphone(DEFAULT:Cell_Phone_:\'\'),npa(DEFAULT:N_P_A_:\'\'),phone7(DEFAULT:Phone7_:\'\'),did(DEFAULT:D_I_D_:0),didscore(DEFAULT:D_I_D_Score_:\'\'),phonedatefirstseen(DEFAULT:Phone_Date_First_Seen_:DATE),phonedatelastseen(DEFAULT:Phone_Date_Last_Seen_:DATE),phonedatevendorfirstreported(DEFAULT:Phone_Date_Vendor_First_Reported_:DATE),phonedatevendorlastreported(DEFAULT:Phone_Date_Vendor_Last_Reported_:DATE),dtnonglblastseen(DEFAULT:D_T_Non_G_L_B_Last_Seen_:0),glbdppaflag(DEFAULT:G_L_B_D_P_P_A_Flag_:\'\'),didtype(DEFAULT:D_I_D_Type_:\'\'),origphone(DEFAULT:Orig_Phone_:\'\'),origcarriername(DEFAULT:Orig_Carrier_Name_:\'\'),rectype(DEFAULT:Rec_Type_:\'\'),errstat(DEFAULT:Err_Stat_:\'\'),rawaid(DEFAULT:Rawaid_:0),cleanaid(DEFAULT:Cleanaid_:0),currentrec(DEFAULT:Current_Rec_),firstbuilddate(DEFAULT:First_Build_Date_:DATE),lastbuilddate(DEFAULT:Last_Build_Date_:DATE),ingesttpe(DEFAULT:Ingest_T_P_E_:0),verified(DEFAULT:Verified_:\'\'),cordcutter(DEFAULT:Cord_Cutter_:\'\'),activitystatus(DEFAULT:Activity_Status_:\'\'),prepaid(DEFAULT:Prepaid_:\'\'),globalsid(DEFAULT:Global_S_I_D_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_9Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d9_KELfiltered := PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault((UNSIGNED)company_phone <> 0);
  EXPORT PublicRecords_KEL_files_NonFCRA_BIPV2_Build__HighRiskPhone_vault_Invalid := __d9_KELfiltered((KEL.typ.uid)company_phone = 0);
  SHARED __d9_Prefiltered := __d9_KELfiltered((KEL.typ.uid)company_phone <> 0);
  SHARED __d9 := __SourceFilter(KEL.FromFlat.Convert(__d9_Prefiltered,InLayout,__Mapping9,'PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault'));
  SHARED Hybrid_Archive_Date_10Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping10 := 'phone10(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listing_type(OVERRIDE:Listing_Type_:\'\'),publish_code(OVERRIDE:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),prior_area_code(OVERRIDE:Prior_Area_Code_:\'\'),current_record_flag(OVERRIDE:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omit_phone(OVERRIDE:Omit_Indicator_:\'\'),current_flag(OVERRIDE:Current_Flag_:\'\'),business_flag(OVERRIDE:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),recordsid(DEFAULT:Record_S_I_D_:0),householdflag(DEFAULT:Household_Flag_),cellphone(DEFAULT:Cell_Phone_:\'\'),npa(DEFAULT:N_P_A_:\'\'),phone7(DEFAULT:Phone7_:\'\'),did(DEFAULT:D_I_D_:0),didscore(DEFAULT:D_I_D_Score_:\'\'),phonedatefirstseen(DEFAULT:Phone_Date_First_Seen_:DATE),phonedatelastseen(DEFAULT:Phone_Date_Last_Seen_:DATE),phonedatevendorfirstreported(DEFAULT:Phone_Date_Vendor_First_Reported_:DATE),phonedatevendorlastreported(DEFAULT:Phone_Date_Vendor_Last_Reported_:DATE),dtnonglblastseen(DEFAULT:D_T_Non_G_L_B_Last_Seen_:0),glbdppaflag(DEFAULT:G_L_B_D_P_P_A_Flag_:\'\'),didtype(DEFAULT:D_I_D_Type_:\'\'),origphone(DEFAULT:Orig_Phone_:\'\'),origcarriername(DEFAULT:Orig_Carrier_Name_:\'\'),rectype(DEFAULT:Rec_Type_:\'\'),errstat(DEFAULT:Err_Stat_:\'\'),rawaid(DEFAULT:Rawaid_:0),cleanaid(DEFAULT:Cleanaid_:0),currentrec(DEFAULT:Current_Rec_),firstbuilddate(DEFAULT:First_Build_Date_:DATE),lastbuilddate(DEFAULT:Last_Build_Date_:DATE),ingesttpe(DEFAULT:Ingest_T_P_E_:0),verified(DEFAULT:Verified_:\'\'),cordcutter(DEFAULT:Cord_Cutter_:\'\'),activitystatus(DEFAULT:Activity_Status_:\'\'),prepaid(DEFAULT:Prepaid_:\'\'),globalsid(DEFAULT:Global_S_I_D_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_10Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d10_KELfiltered := PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault((UNSIGNED)phone10 != 0);
  EXPORT PublicRecords_KEL_Files_FCRA_Gong__Key_History_Phone_Vault_Invalid := __d10_KELfiltered((KEL.typ.uid)phone10 = 0);
  SHARED __d10_Prefiltered := __d10_KELfiltered((KEL.typ.uid)phone10 <> 0);
  SHARED __d10 := __SourceFilter(KEL.FromFlat.Convert(__d10_Prefiltered,InLayout,__Mapping10,'PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault'));
  SHARED Date_Last_Seen_11Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_11Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping11 := 'phone_number(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validation_flag(OVERRIDE:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),recordsid(DEFAULT:Record_S_I_D_:0),householdflag(DEFAULT:Household_Flag_),cellphone(DEFAULT:Cell_Phone_:\'\'),npa(DEFAULT:N_P_A_:\'\'),phone7(DEFAULT:Phone7_:\'\'),did(DEFAULT:D_I_D_:0),didscore(DEFAULT:D_I_D_Score_:\'\'),phonedatefirstseen(DEFAULT:Phone_Date_First_Seen_:DATE),phonedatelastseen(DEFAULT:Phone_Date_Last_Seen_:DATE),phonedatevendorfirstreported(DEFAULT:Phone_Date_Vendor_First_Reported_:DATE),phonedatevendorlastreported(DEFAULT:Phone_Date_Vendor_Last_Reported_:DATE),dtnonglblastseen(DEFAULT:D_T_Non_G_L_B_Last_Seen_:0),glbdppaflag(DEFAULT:G_L_B_D_P_P_A_Flag_:\'\'),didtype(DEFAULT:D_I_D_Type_:\'\'),origphone(DEFAULT:Orig_Phone_:\'\'),origcarriername(DEFAULT:Orig_Carrier_Name_:\'\'),rectype(DEFAULT:Rec_Type_:\'\'),errstat(DEFAULT:Err_Stat_:\'\'),rawaid(DEFAULT:Rawaid_:0),cleanaid(DEFAULT:Cleanaid_:0),currentrec(DEFAULT:Current_Rec_),firstbuilddate(DEFAULT:First_Build_Date_:DATE),lastbuilddate(DEFAULT:Last_Build_Date_:DATE),ingesttpe(DEFAULT:Ingest_T_P_E_:0),verified(DEFAULT:Verified_:\'\'),cordcutter(DEFAULT:Cord_Cutter_:\'\'),activitystatus(DEFAULT:Activity_Status_:\'\'),prepaid(DEFAULT:Prepaid_:\'\'),globalsid(DEFAULT:Global_S_I_D_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_11Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_11Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d11_KELfiltered := PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault((UNSIGNED)phone_number != 0);
  EXPORT PublicRecords_KEL_Files_FCRA_Targus__Key_Targus_Phone_Vault_Invalid := __d11_KELfiltered((KEL.typ.uid)phone_number = 0);
  SHARED __d11_Prefiltered := __d11_KELfiltered((KEL.typ.uid)phone_number <> 0);
  SHARED __d11 := __SourceFilter(KEL.FromFlat.Convert(__d11_Prefiltered,InLayout,__Mapping11,'PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault'));
  SHARED Date_Last_Seen_12Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_12Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping12 := 'phone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),listingtype(DEFAULT:Listing_Type_:\'\'),publishcode(DEFAULT:Publish_Code_:\'\'),portabilityindicator(DEFAULT:Portability_Indicator_:0),nxxtype(DEFAULT:N_X_X_Type_:0),coctype(DEFAULT:C_O_C_Type_:\'\'),scc(DEFAULT:S_C_C_:\'\'),portedmatch(DEFAULT:Ported_Match_:0),phoneuse(DEFAULT:Phone_Use_:\'\'),phonenumbercompanytype(DEFAULT:Phone_Number_Company_Type_:0),priorareacode(DEFAULT:Prior_Area_Code_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),carriername(DEFAULT:Carrier_Name_:\'\'),confidencescore(DEFAULT:Confidence_Score_:0),nosolicitcode(DEFAULT:No_Solicit_Code_:\'\'),maximumconfidencescore(DEFAULT:Maximum_Confidence_Score_:0),minimumconfidencescore(DEFAULT:Minimum_Confidence_Score_:0),omitindicator(DEFAULT:Omit_Indicator_:\'\'),currentflag(DEFAULT:Current_Flag_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),rec_type(OVERRIDE:Record_Type_:\'\'),sourcefile(DEFAULT:Source_File_:0),iverindicator(DEFAULT:Iver_Indicator_:0),phonetype(DEFAULT:Phone_Type_:\'\'),validationflag(DEFAULT:Validation_Flag_:\'\'),validationdate(DEFAULT:Validation_Date_:\'\'),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),recordsid(DEFAULT:Record_S_I_D_:0),householdflag(DEFAULT:Household_Flag_),cellphone(DEFAULT:Cell_Phone_:\'\'),npa(DEFAULT:N_P_A_:\'\'),phone7(DEFAULT:Phone7_:\'\'),did(DEFAULT:D_I_D_:0),didscore(DEFAULT:D_I_D_Score_:\'\'),phonedatefirstseen(DEFAULT:Phone_Date_First_Seen_:DATE),phonedatelastseen(DEFAULT:Phone_Date_Last_Seen_:DATE),phonedatevendorfirstreported(DEFAULT:Phone_Date_Vendor_First_Reported_:DATE),phonedatevendorlastreported(DEFAULT:Phone_Date_Vendor_Last_Reported_:DATE),dtnonglblastseen(DEFAULT:D_T_Non_G_L_B_Last_Seen_:0),glbdppaflag(DEFAULT:G_L_B_D_P_P_A_Flag_:\'\'),didtype(DEFAULT:D_I_D_Type_:\'\'),origphone(DEFAULT:Orig_Phone_:\'\'),origcarriername(DEFAULT:Orig_Carrier_Name_:\'\'),rectype(DEFAULT:Rec_Type_:\'\'),errstat(DEFAULT:Err_Stat_:\'\'),rawaid(DEFAULT:Rawaid_:0),cleanaid(DEFAULT:Cleanaid_:0),currentrec(DEFAULT:Current_Rec_),firstbuilddate(DEFAULT:First_Build_Date_:DATE),lastbuilddate(DEFAULT:Last_Build_Date_:DATE),ingesttpe(DEFAULT:Ingest_T_P_E_:0),verified(DEFAULT:Verified_:\'\'),cordcutter(DEFAULT:Cord_Cutter_:\'\'),activitystatus(DEFAULT:Activity_Status_:\'\'),prepaid(DEFAULT:Prepaid_:\'\'),globalsid(DEFAULT:Global_S_I_D_:0),src(OVERRIDE:Source_:\'\'),originalsource(DEFAULT:Original_Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_12Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_12Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d12_KELfiltered := PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault((UNSIGNED)phone <> 0);
  EXPORT PublicRecords_KEL_Files_FCRA_InfutorCID__Key_Infutor_Phone_Vault_Invalid := __d12_KELfiltered((KEL.typ.uid)phone = 0);
  SHARED __d12_Prefiltered := __d12_KELfiltered((KEL.typ.uid)phone <> 0);
  SHARED __d12 := __SourceFilter(KEL.FromFlat.Convert(__d12_Prefiltered,InLayout,__Mapping12,'PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6 + __d7 + __d8 + __d9 + __d10 + __d11 + __d12;
  EXPORT Prior_Area_Codes_Layout := RECORD
    KEL.typ.nstr Prior_Area_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Active_Layout := RECORD
    KEL.typ.nstr Is_Active_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
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
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
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
  EXPORT Phone_Types_Layout := RECORD
    KEL.typ.nstr Phone_Type_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Record_Types_Layout := RECORD
    KEL.typ.nstr Record_Type_;
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
    KEL.typ.nint Record_S_I_D_;
    KEL.typ.nbool Household_Flag_;
    KEL.typ.nstr Cell_Phone_;
    KEL.typ.nstr N_P_A_;
    KEL.typ.nstr Phone7_;
    KEL.typ.nint D_I_D_;
    KEL.typ.nstr D_I_D_Score_;
    KEL.typ.nkdate Phone_Date_First_Seen_;
    KEL.typ.nkdate Phone_Date_Last_Seen_;
    KEL.typ.nkdate Phone_Date_Vendor_First_Reported_;
    KEL.typ.nkdate Phone_Date_Vendor_Last_Reported_;
    KEL.typ.nint D_T_Non_G_L_B_Last_Seen_;
    KEL.typ.nstr G_L_B_D_P_P_A_Flag_;
    KEL.typ.nstr D_I_D_Type_;
    KEL.typ.nstr Orig_Phone_;
    KEL.typ.nstr Orig_Carrier_Name_;
    KEL.typ.nstr Rec_Type_;
    KEL.typ.nstr Err_Stat_;
    KEL.typ.nint Rawaid_;
    KEL.typ.nint Cleanaid_;
    KEL.typ.nbool Current_Rec_;
    KEL.typ.nkdate First_Build_Date_;
    KEL.typ.nkdate Last_Build_Date_;
    KEL.typ.nint Ingest_T_P_E_;
    KEL.typ.nstr Verified_;
    KEL.typ.nstr Cord_Cutter_;
    KEL.typ.nstr Activity_Status_;
    KEL.typ.nstr Prepaid_;
    KEL.typ.nint Global_S_I_D_;
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
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
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
    SELF.Record_S_I_D_ := KEL.Intake.SingleValue(__recs,Record_S_I_D_);
    SELF.Household_Flag_ := KEL.Intake.SingleValue(__recs,Household_Flag_);
    SELF.Cell_Phone_ := KEL.Intake.SingleValue(__recs,Cell_Phone_);
    SELF.N_P_A_ := KEL.Intake.SingleValue(__recs,N_P_A_);
    SELF.Phone7_ := KEL.Intake.SingleValue(__recs,Phone7_);
    SELF.D_I_D_ := KEL.Intake.SingleValue(__recs,D_I_D_);
    SELF.D_I_D_Score_ := KEL.Intake.SingleValue(__recs,D_I_D_Score_);
    SELF.Phone_Date_First_Seen_ := KEL.Intake.SingleValue(__recs,Phone_Date_First_Seen_);
    SELF.Phone_Date_Last_Seen_ := KEL.Intake.SingleValue(__recs,Phone_Date_Last_Seen_);
    SELF.Phone_Date_Vendor_First_Reported_ := KEL.Intake.SingleValue(__recs,Phone_Date_Vendor_First_Reported_);
    SELF.Phone_Date_Vendor_Last_Reported_ := KEL.Intake.SingleValue(__recs,Phone_Date_Vendor_Last_Reported_);
    SELF.D_T_Non_G_L_B_Last_Seen_ := KEL.Intake.SingleValue(__recs,D_T_Non_G_L_B_Last_Seen_);
    SELF.G_L_B_D_P_P_A_Flag_ := KEL.Intake.SingleValue(__recs,G_L_B_D_P_P_A_Flag_);
    SELF.D_I_D_Type_ := KEL.Intake.SingleValue(__recs,D_I_D_Type_);
    SELF.Orig_Phone_ := KEL.Intake.SingleValue(__recs,Orig_Phone_);
    SELF.Orig_Carrier_Name_ := KEL.Intake.SingleValue(__recs,Orig_Carrier_Name_);
    SELF.Rec_Type_ := KEL.Intake.SingleValue(__recs,Rec_Type_);
    SELF.Err_Stat_ := KEL.Intake.SingleValue(__recs,Err_Stat_);
    SELF.Rawaid_ := KEL.Intake.SingleValue(__recs,Rawaid_);
    SELF.Cleanaid_ := KEL.Intake.SingleValue(__recs,Cleanaid_);
    SELF.Current_Rec_ := KEL.Intake.SingleValue(__recs,Current_Rec_);
    SELF.First_Build_Date_ := KEL.Intake.SingleValue(__recs,First_Build_Date_);
    SELF.Last_Build_Date_ := KEL.Intake.SingleValue(__recs,Last_Build_Date_);
    SELF.Ingest_T_P_E_ := KEL.Intake.SingleValue(__recs,Ingest_T_P_E_);
    SELF.Verified_ := KEL.Intake.SingleValue(__recs,Verified_);
    SELF.Cord_Cutter_ := KEL.Intake.SingleValue(__recs,Cord_Cutter_);
    SELF.Activity_Status_ := KEL.Intake.SingleValue(__recs,Activity_Status_);
    SELF.Prepaid_ := KEL.Intake.SingleValue(__recs,Prepaid_);
    SELF.Global_S_I_D_ := KEL.Intake.SingleValue(__recs,Global_S_I_D_);
    SELF.Prior_Area_Codes_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Prior_Area_Code_},Prior_Area_Code_),Prior_Area_Codes_Layout)(__NN(Prior_Area_Code_)));
    SELF.Active_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Is_Active_,Source_},Is_Active_,Source_),Active_Layout)(__NN(Is_Active_) OR __NN(Source_)));
    SELF.Confidence_Scores_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Confidence_Score_,Maximum_Confidence_Score_,Minimum_Confidence_Score_},Confidence_Score_,Maximum_Confidence_Score_,Minimum_Confidence_Score_),Confidence_Scores_Layout)(__NN(Confidence_Score_) OR __NN(Maximum_Confidence_Score_) OR __NN(Minimum_Confidence_Score_)));
    SELF.Listing_Types_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Listing_Type_,Source_},Listing_Type_,Source_),Listing_Types_Layout)(__NN(Listing_Type_) OR __NN(Source_)));
    SELF.Phone_Types_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Phone_Type_,Source_},Phone_Type_,Source_),Phone_Types_Layout)(__NN(Phone_Type_) OR __NN(Source_)));
    SELF.Record_Types_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Record_Type_,Source_},Record_Type_,Source_),Record_Types_Layout)(__NN(Record_Type_) OR __NN(Source_)));
    SELF.High_Risk_Phone_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),High_Risk_S_I_C_,High_Risk_N_A_I_C_S_},High_Risk_S_I_C_,High_Risk_N_A_I_C_S_),High_Risk_Phone_Layout)(__NN(High_Risk_S_I_C_) OR __NN(High_Risk_N_A_I_C_S_)));
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
    SELF.Prior_Area_Codes_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Prior_Area_Codes_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Prior_Area_Code_)));
    SELF.Active_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Active_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Is_Active_) OR __NN(Source_)));
    SELF.Confidence_Scores_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Confidence_Scores_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Confidence_Score_) OR __NN(Maximum_Confidence_Score_) OR __NN(Minimum_Confidence_Score_)));
    SELF.Listing_Types_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Listing_Types_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Listing_Type_) OR __NN(Source_)));
    SELF.Phone_Types_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Phone_Types_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Phone_Type_) OR __NN(Source_)));
    SELF.Record_Types_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Record_Types_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Record_Type_) OR __NN(Source_)));
    SELF.High_Risk_Phone_ := __CN(PROJECT(DATASET(__r),TRANSFORM(High_Risk_Phone_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(High_Risk_S_I_C_) OR __NN(High_Risk_N_A_I_C_S_)));
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
  EXPORT Record_S_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Record_S_I_D_);
  EXPORT Household_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Household_Flag_);
  EXPORT Cell_Phone__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Cell_Phone_);
  EXPORT N_P_A__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,N_P_A_);
  EXPORT Phone7__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Phone7_);
  EXPORT D_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,D_I_D_);
  EXPORT D_I_D_Score__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,D_I_D_Score_);
  EXPORT Phone_Date_First_Seen__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Phone_Date_First_Seen_);
  EXPORT Phone_Date_Last_Seen__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Phone_Date_Last_Seen_);
  EXPORT Phone_Date_Vendor_First_Reported__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Phone_Date_Vendor_First_Reported_);
  EXPORT Phone_Date_Vendor_Last_Reported__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Phone_Date_Vendor_Last_Reported_);
  EXPORT D_T_Non_G_L_B_Last_Seen__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,D_T_Non_G_L_B_Last_Seen_);
  EXPORT G_L_B_D_P_P_A_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,G_L_B_D_P_P_A_Flag_);
  EXPORT D_I_D_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,D_I_D_Type_);
  EXPORT Orig_Phone__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Orig_Phone_);
  EXPORT Orig_Carrier_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Orig_Carrier_Name_);
  EXPORT Rec_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Rec_Type_);
  EXPORT Err_Stat__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Err_Stat_);
  EXPORT Rawaid__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Rawaid_);
  EXPORT Cleanaid__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Cleanaid_);
  EXPORT Current_Rec__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Current_Rec_);
  EXPORT First_Build_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,First_Build_Date_);
  EXPORT Last_Build_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Last_Build_Date_);
  EXPORT Ingest_T_P_E__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Ingest_T_P_E_);
  EXPORT Verified__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Verified_);
  EXPORT Cord_Cutter__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Cord_Cutter_);
  EXPORT Activity_Status__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Activity_Status_);
  EXPORT Prepaid__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Prepaid_);
  EXPORT Global_S_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Global_S_I_D_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_Files_NonFCRA_Gong__Key_History_Phone_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_CellPhone__Key_Nustar_Phone_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_PhonesInfo__Keys_Phones_Type_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_PhonesInfo__Keys_Phones_Transaction_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_PhonesPlus_v2_Keys__Source_Level_Payload_Vault_Invalid),COUNT(PublicRecords_KEL_files_NonFCRA_Fraudpoint3__Key_Phone_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_Targus__Key_Targus_Phone_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_InfutorCID__Key_Infutor_Phone_Vault_Invalid),COUNT(PublicRecords_KEL_files_NonFCRA_BIPV2_Build__HighRiskPhone_vault_Invalid),COUNT(PublicRecords_KEL_Files_FCRA_Gong__Key_History_Phone_Vault_Invalid),COUNT(PublicRecords_KEL_Files_FCRA_Targus__Key_Targus_Phone_Vault_Invalid),COUNT(PublicRecords_KEL_Files_FCRA_InfutorCID__Key_Infutor_Phone_Vault_Invalid),COUNT(Phone10__SingleValue_Invalid),COUNT(Portability_Indicator__SingleValue_Invalid),COUNT(Current_Flag__SingleValue_Invalid),COUNT(Business_Flag__SingleValue_Invalid),COUNT(N_X_X_Type__SingleValue_Invalid),COUNT(Publish_Code__SingleValue_Invalid),COUNT(C_O_C_Type__SingleValue_Invalid),COUNT(S_C_C__SingleValue_Invalid),COUNT(Phone_Number_Company_Type__SingleValue_Invalid),COUNT(Ported_Match__SingleValue_Invalid),COUNT(Phone_Use__SingleValue_Invalid),COUNT(No_Solicit_Code__SingleValue_Invalid),COUNT(Omit_Indicator__SingleValue_Invalid),COUNT(Source_File__SingleValue_Invalid),COUNT(Iver_Indicator__SingleValue_Invalid),COUNT(Validation_Flag__SingleValue_Invalid),COUNT(Validation_Date__SingleValue_Invalid),COUNT(Carrier_Name__SingleValue_Invalid),COUNT(Record_S_I_D__SingleValue_Invalid),COUNT(Household_Flag__SingleValue_Invalid),COUNT(Cell_Phone__SingleValue_Invalid),COUNT(N_P_A__SingleValue_Invalid),COUNT(Phone7__SingleValue_Invalid),COUNT(D_I_D__SingleValue_Invalid),COUNT(D_I_D_Score__SingleValue_Invalid),COUNT(Phone_Date_First_Seen__SingleValue_Invalid),COUNT(Phone_Date_Last_Seen__SingleValue_Invalid),COUNT(Phone_Date_Vendor_First_Reported__SingleValue_Invalid),COUNT(Phone_Date_Vendor_Last_Reported__SingleValue_Invalid),COUNT(D_T_Non_G_L_B_Last_Seen__SingleValue_Invalid),COUNT(G_L_B_D_P_P_A_Flag__SingleValue_Invalid),COUNT(D_I_D_Type__SingleValue_Invalid),COUNT(Orig_Phone__SingleValue_Invalid),COUNT(Orig_Carrier_Name__SingleValue_Invalid),COUNT(Rec_Type__SingleValue_Invalid),COUNT(Err_Stat__SingleValue_Invalid),COUNT(Rawaid__SingleValue_Invalid),COUNT(Cleanaid__SingleValue_Invalid),COUNT(Current_Rec__SingleValue_Invalid),COUNT(First_Build_Date__SingleValue_Invalid),COUNT(Last_Build_Date__SingleValue_Invalid),COUNT(Ingest_T_P_E__SingleValue_Invalid),COUNT(Verified__SingleValue_Invalid),COUNT(Cord_Cutter__SingleValue_Invalid),COUNT(Activity_Status__SingleValue_Invalid),COUNT(Prepaid__SingleValue_Invalid),COUNT(Global_S_I_D__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_Files_NonFCRA_Gong__Key_History_Phone_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_CellPhone__Key_Nustar_Phone_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_PhonesInfo__Keys_Phones_Type_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_PhonesInfo__Keys_Phones_Transaction_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_PhonesPlus_v2_Keys__Source_Level_Payload_Vault_Invalid,KEL.typ.int PublicRecords_KEL_files_NonFCRA_Fraudpoint3__Key_Phone_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_Targus__Key_Targus_Phone_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_InfutorCID__Key_Infutor_Phone_Vault_Invalid,KEL.typ.int PublicRecords_KEL_files_NonFCRA_BIPV2_Build__HighRiskPhone_vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_FCRA_Gong__Key_History_Phone_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_FCRA_Targus__Key_Targus_Phone_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_FCRA_InfutorCID__Key_Infutor_Phone_Vault_Invalid,KEL.typ.int Phone10__SingleValue_Invalid,KEL.typ.int Portability_Indicator__SingleValue_Invalid,KEL.typ.int Current_Flag__SingleValue_Invalid,KEL.typ.int Business_Flag__SingleValue_Invalid,KEL.typ.int N_X_X_Type__SingleValue_Invalid,KEL.typ.int Publish_Code__SingleValue_Invalid,KEL.typ.int C_O_C_Type__SingleValue_Invalid,KEL.typ.int S_C_C__SingleValue_Invalid,KEL.typ.int Phone_Number_Company_Type__SingleValue_Invalid,KEL.typ.int Ported_Match__SingleValue_Invalid,KEL.typ.int Phone_Use__SingleValue_Invalid,KEL.typ.int No_Solicit_Code__SingleValue_Invalid,KEL.typ.int Omit_Indicator__SingleValue_Invalid,KEL.typ.int Source_File__SingleValue_Invalid,KEL.typ.int Iver_Indicator__SingleValue_Invalid,KEL.typ.int Validation_Flag__SingleValue_Invalid,KEL.typ.int Validation_Date__SingleValue_Invalid,KEL.typ.int Carrier_Name__SingleValue_Invalid,KEL.typ.int Record_S_I_D__SingleValue_Invalid,KEL.typ.int Household_Flag__SingleValue_Invalid,KEL.typ.int Cell_Phone__SingleValue_Invalid,KEL.typ.int N_P_A__SingleValue_Invalid,KEL.typ.int Phone7__SingleValue_Invalid,KEL.typ.int D_I_D__SingleValue_Invalid,KEL.typ.int D_I_D_Score__SingleValue_Invalid,KEL.typ.int Phone_Date_First_Seen__SingleValue_Invalid,KEL.typ.int Phone_Date_Last_Seen__SingleValue_Invalid,KEL.typ.int Phone_Date_Vendor_First_Reported__SingleValue_Invalid,KEL.typ.int Phone_Date_Vendor_Last_Reported__SingleValue_Invalid,KEL.typ.int D_T_Non_G_L_B_Last_Seen__SingleValue_Invalid,KEL.typ.int G_L_B_D_P_P_A_Flag__SingleValue_Invalid,KEL.typ.int D_I_D_Type__SingleValue_Invalid,KEL.typ.int Orig_Phone__SingleValue_Invalid,KEL.typ.int Orig_Carrier_Name__SingleValue_Invalid,KEL.typ.int Rec_Type__SingleValue_Invalid,KEL.typ.int Err_Stat__SingleValue_Invalid,KEL.typ.int Rawaid__SingleValue_Invalid,KEL.typ.int Cleanaid__SingleValue_Invalid,KEL.typ.int Current_Rec__SingleValue_Invalid,KEL.typ.int First_Build_Date__SingleValue_Invalid,KEL.typ.int Last_Build_Date__SingleValue_Invalid,KEL.typ.int Ingest_T_P_E__SingleValue_Invalid,KEL.typ.int Verified__SingleValue_Invalid,KEL.typ.int Cord_Cutter__SingleValue_Invalid,KEL.typ.int Activity_Status__SingleValue_Invalid,KEL.typ.int Prepaid__SingleValue_Invalid,KEL.typ.int Global_S_I_D__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_Gong__Key_History_Phone_Vault_Invalid),COUNT(__d0)},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','phone10',COUNT(__d0(__NL(Phone10_))),COUNT(__d0(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','listing_type',COUNT(__d0(__NL(Listing_Type_))),COUNT(__d0(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','publish_code',COUNT(__d0(__NL(Publish_Code_))),COUNT(__d0(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','PortabilityIndicator',COUNT(__d0(__NL(Portability_Indicator_))),COUNT(__d0(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','NXXType',COUNT(__d0(__NL(N_X_X_Type_))),COUNT(__d0(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','COCType',COUNT(__d0(__NL(C_O_C_Type_))),COUNT(__d0(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','SCC',COUNT(__d0(__NL(S_C_C_))),COUNT(__d0(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','PortedMatch',COUNT(__d0(__NL(Ported_Match_))),COUNT(__d0(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','PhoneUse',COUNT(__d0(__NL(Phone_Use_))),COUNT(__d0(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','PhoneNumberCompanyType',COUNT(__d0(__NL(Phone_Number_Company_Type_))),COUNT(__d0(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','prior_area_code',COUNT(__d0(__NL(Prior_Area_Code_))),COUNT(__d0(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','current_record_flag',COUNT(__d0(__NL(Is_Active_))),COUNT(__d0(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','CarrierName',COUNT(__d0(__NL(Carrier_Name_))),COUNT(__d0(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','ConfidenceScore',COUNT(__d0(__NL(Confidence_Score_))),COUNT(__d0(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','NoSolicitCode',COUNT(__d0(__NL(No_Solicit_Code_))),COUNT(__d0(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','MaximumConfidenceScore',COUNT(__d0(__NL(Maximum_Confidence_Score_))),COUNT(__d0(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','MinimumConfidenceScore',COUNT(__d0(__NL(Minimum_Confidence_Score_))),COUNT(__d0(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','omit_phone',COUNT(__d0(__NL(Omit_Indicator_))),COUNT(__d0(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','current_flag',COUNT(__d0(__NL(Current_Flag_))),COUNT(__d0(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','business_flag',COUNT(__d0(__NL(Business_Flag_))),COUNT(__d0(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','RecordType',COUNT(__d0(__NL(Record_Type_))),COUNT(__d0(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','SourceFile',COUNT(__d0(__NL(Source_File_))),COUNT(__d0(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','IverIndicator',COUNT(__d0(__NL(Iver_Indicator_))),COUNT(__d0(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','PhoneType',COUNT(__d0(__NL(Phone_Type_))),COUNT(__d0(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','ValidationFlag',COUNT(__d0(__NL(Validation_Flag_))),COUNT(__d0(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','ValidationDate',COUNT(__d0(__NL(Validation_Date_))),COUNT(__d0(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','HighRiskSIC',COUNT(__d0(__NL(High_Risk_S_I_C_))),COUNT(__d0(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','HighRiskNAICS',COUNT(__d0(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d0(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','RecordSID',COUNT(__d0(__NL(Record_S_I_D_))),COUNT(__d0(__NN(Record_S_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','HouseholdFlag',COUNT(__d0(__NL(Household_Flag_))),COUNT(__d0(__NN(Household_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','CellPhone',COUNT(__d0(__NL(Cell_Phone_))),COUNT(__d0(__NN(Cell_Phone_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','NPA',COUNT(__d0(__NL(N_P_A_))),COUNT(__d0(__NN(N_P_A_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','Phone7',COUNT(__d0(__NL(Phone7_))),COUNT(__d0(__NN(Phone7_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','DID',COUNT(__d0(__NL(D_I_D_))),COUNT(__d0(__NN(D_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','DIDScore',COUNT(__d0(__NL(D_I_D_Score_))),COUNT(__d0(__NN(D_I_D_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','PhoneDateFirstSeen',COUNT(__d0(__NL(Phone_Date_First_Seen_))),COUNT(__d0(__NN(Phone_Date_First_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','PhoneDateLastSeen',COUNT(__d0(__NL(Phone_Date_Last_Seen_))),COUNT(__d0(__NN(Phone_Date_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','PhoneDateVendorFirstReported',COUNT(__d0(__NL(Phone_Date_Vendor_First_Reported_))),COUNT(__d0(__NN(Phone_Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','PhoneDateVendorLastReported',COUNT(__d0(__NL(Phone_Date_Vendor_Last_Reported_))),COUNT(__d0(__NN(Phone_Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','DTNonGLBLastSeen',COUNT(__d0(__NL(D_T_Non_G_L_B_Last_Seen_))),COUNT(__d0(__NN(D_T_Non_G_L_B_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','GLBDPPAFlag',COUNT(__d0(__NL(G_L_B_D_P_P_A_Flag_))),COUNT(__d0(__NN(G_L_B_D_P_P_A_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','DIDType',COUNT(__d0(__NL(D_I_D_Type_))),COUNT(__d0(__NN(D_I_D_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','OrigPhone',COUNT(__d0(__NL(Orig_Phone_))),COUNT(__d0(__NN(Orig_Phone_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','OrigCarrierName',COUNT(__d0(__NL(Orig_Carrier_Name_))),COUNT(__d0(__NN(Orig_Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','RecType',COUNT(__d0(__NL(Rec_Type_))),COUNT(__d0(__NN(Rec_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','ErrStat',COUNT(__d0(__NL(Err_Stat_))),COUNT(__d0(__NN(Err_Stat_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','Rawaid',COUNT(__d0(__NL(Rawaid_))),COUNT(__d0(__NN(Rawaid_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','Cleanaid',COUNT(__d0(__NL(Cleanaid_))),COUNT(__d0(__NN(Cleanaid_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','CurrentRec',COUNT(__d0(__NL(Current_Rec_))),COUNT(__d0(__NN(Current_Rec_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','FirstBuildDate',COUNT(__d0(__NL(First_Build_Date_))),COUNT(__d0(__NN(First_Build_Date_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','LastBuildDate',COUNT(__d0(__NL(Last_Build_Date_))),COUNT(__d0(__NN(Last_Build_Date_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','IngestTPE',COUNT(__d0(__NL(Ingest_T_P_E_))),COUNT(__d0(__NN(Ingest_T_P_E_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','Verified',COUNT(__d0(__NL(Verified_))),COUNT(__d0(__NN(Verified_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','CordCutter',COUNT(__d0(__NL(Cord_Cutter_))),COUNT(__d0(__NN(Cord_Cutter_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','ActivityStatus',COUNT(__d0(__NL(Activity_Status_))),COUNT(__d0(__NN(Activity_Status_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','Prepaid',COUNT(__d0(__NL(Prepaid_))),COUNT(__d0(__NN(Prepaid_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','GlobalSID',COUNT(__d0(__NL(Global_S_I_D_))),COUNT(__d0(__NN(Global_S_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','OriginalSource',COUNT(__d0(__NL(Original_Source_))),COUNT(__d0(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Gong__Key_History_Phone_Vault','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA_Invalid),COUNT(__d1)},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','phone',COUNT(__d1(__NL(Phone10_))),COUNT(__d1(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','ListingType',COUNT(__d1(__NL(Listing_Type_))),COUNT(__d1(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','PublishCode',COUNT(__d1(__NL(Publish_Code_))),COUNT(__d1(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','PortabilityIndicator',COUNT(__d1(__NL(Portability_Indicator_))),COUNT(__d1(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','NXXType',COUNT(__d1(__NL(N_X_X_Type_))),COUNT(__d1(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','COCType',COUNT(__d1(__NL(C_O_C_Type_))),COUNT(__d1(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','SCC',COUNT(__d1(__NL(S_C_C_))),COUNT(__d1(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','PortedMatch',COUNT(__d1(__NL(Ported_Match_))),COUNT(__d1(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','PhoneUse',COUNT(__d1(__NL(Phone_Use_))),COUNT(__d1(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','PhoneNumberCompanyType',COUNT(__d1(__NL(Phone_Number_Company_Type_))),COUNT(__d1(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','PriorAreaCode',COUNT(__d1(__NL(Prior_Area_Code_))),COUNT(__d1(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','IsActive',COUNT(__d1(__NL(Is_Active_))),COUNT(__d1(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','CarrierName',COUNT(__d1(__NL(Carrier_Name_))),COUNT(__d1(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','ConfidenceScore',COUNT(__d1(__NL(Confidence_Score_))),COUNT(__d1(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','NoSolicitCode',COUNT(__d1(__NL(No_Solicit_Code_))),COUNT(__d1(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','MaximumConfidenceScore',COUNT(__d1(__NL(Maximum_Confidence_Score_))),COUNT(__d1(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','MinimumConfidenceScore',COUNT(__d1(__NL(Minimum_Confidence_Score_))),COUNT(__d1(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','OmitIndicator',COUNT(__d1(__NL(Omit_Indicator_))),COUNT(__d1(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','current_rec',COUNT(__d1(__NL(Current_Flag_))),COUNT(__d1(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','BusinessFlag',COUNT(__d1(__NL(Business_Flag_))),COUNT(__d1(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','rec_type',COUNT(__d1(__NL(Record_Type_))),COUNT(__d1(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','file_source',COUNT(__d1(__NL(Source_File_))),COUNT(__d1(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','iver_indicator',COUNT(__d1(__NL(Iver_Indicator_))),COUNT(__d1(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','PhoneType',COUNT(__d1(__NL(Phone_Type_))),COUNT(__d1(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','ValidationFlag',COUNT(__d1(__NL(Validation_Flag_))),COUNT(__d1(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','ValidationDate',COUNT(__d1(__NL(Validation_Date_))),COUNT(__d1(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','HighRiskSIC',COUNT(__d1(__NL(High_Risk_S_I_C_))),COUNT(__d1(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','HighRiskNAICS',COUNT(__d1(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d1(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','RecordSID',COUNT(__d1(__NL(Record_S_I_D_))),COUNT(__d1(__NN(Record_S_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','HouseholdFlag',COUNT(__d1(__NL(Household_Flag_))),COUNT(__d1(__NN(Household_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','CellPhone',COUNT(__d1(__NL(Cell_Phone_))),COUNT(__d1(__NN(Cell_Phone_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','NPA',COUNT(__d1(__NL(N_P_A_))),COUNT(__d1(__NN(N_P_A_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','Phone7',COUNT(__d1(__NL(Phone7_))),COUNT(__d1(__NN(Phone7_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','DID',COUNT(__d1(__NL(D_I_D_))),COUNT(__d1(__NN(D_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','DIDScore',COUNT(__d1(__NL(D_I_D_Score_))),COUNT(__d1(__NN(D_I_D_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','PhoneDateFirstSeen',COUNT(__d1(__NL(Phone_Date_First_Seen_))),COUNT(__d1(__NN(Phone_Date_First_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','PhoneDateLastSeen',COUNT(__d1(__NL(Phone_Date_Last_Seen_))),COUNT(__d1(__NN(Phone_Date_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','PhoneDateVendorFirstReported',COUNT(__d1(__NL(Phone_Date_Vendor_First_Reported_))),COUNT(__d1(__NN(Phone_Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','PhoneDateVendorLastReported',COUNT(__d1(__NL(Phone_Date_Vendor_Last_Reported_))),COUNT(__d1(__NN(Phone_Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','DTNonGLBLastSeen',COUNT(__d1(__NL(D_T_Non_G_L_B_Last_Seen_))),COUNT(__d1(__NN(D_T_Non_G_L_B_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','GLBDPPAFlag',COUNT(__d1(__NL(G_L_B_D_P_P_A_Flag_))),COUNT(__d1(__NN(G_L_B_D_P_P_A_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','DIDType',COUNT(__d1(__NL(D_I_D_Type_))),COUNT(__d1(__NN(D_I_D_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','OrigPhone',COUNT(__d1(__NL(Orig_Phone_))),COUNT(__d1(__NN(Orig_Phone_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','OrigCarrierName',COUNT(__d1(__NL(Orig_Carrier_Name_))),COUNT(__d1(__NN(Orig_Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','RecType',COUNT(__d1(__NL(Rec_Type_))),COUNT(__d1(__NN(Rec_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','ErrStat',COUNT(__d1(__NL(Err_Stat_))),COUNT(__d1(__NN(Err_Stat_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','Rawaid',COUNT(__d1(__NL(Rawaid_))),COUNT(__d1(__NN(Rawaid_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','Cleanaid',COUNT(__d1(__NL(Cleanaid_))),COUNT(__d1(__NN(Cleanaid_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','CurrentRec',COUNT(__d1(__NL(Current_Rec_))),COUNT(__d1(__NN(Current_Rec_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','FirstBuildDate',COUNT(__d1(__NL(First_Build_Date_))),COUNT(__d1(__NN(First_Build_Date_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','LastBuildDate',COUNT(__d1(__NL(Last_Build_Date_))),COUNT(__d1(__NN(Last_Build_Date_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','IngestTPE',COUNT(__d1(__NL(Ingest_T_P_E_))),COUNT(__d1(__NN(Ingest_T_P_E_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','Verified',COUNT(__d1(__NL(Verified_))),COUNT(__d1(__NN(Verified_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','CordCutter',COUNT(__d1(__NL(Cord_Cutter_))),COUNT(__d1(__NN(Cord_Cutter_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','ActivityStatus',COUNT(__d1(__NL(Activity_Status_))),COUNT(__d1(__NN(Activity_Status_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','Prepaid',COUNT(__d1(__NL(Prepaid_))),COUNT(__d1(__NN(Prepaid_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','GlobalSID',COUNT(__d1(__NL(Global_S_I_D_))),COUNT(__d1(__NN(Global_S_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','OriginalSource',COUNT(__d1(__NL(Original_Source_))),COUNT(__d1(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2__Keys_Iverification_Vault__Phone__QA','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_CellPhone__Key_Nustar_Phone_Invalid),COUNT(__d2)},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','cellphone',COUNT(__d2(__NL(Phone10_))),COUNT(__d2(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','ListingType',COUNT(__d2(__NL(Listing_Type_))),COUNT(__d2(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','PublishCode',COUNT(__d2(__NL(Publish_Code_))),COUNT(__d2(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','PortabilityIndicator',COUNT(__d2(__NL(Portability_Indicator_))),COUNT(__d2(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','NXXType',COUNT(__d2(__NL(N_X_X_Type_))),COUNT(__d2(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','COCType',COUNT(__d2(__NL(C_O_C_Type_))),COUNT(__d2(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','SCC',COUNT(__d2(__NL(S_C_C_))),COUNT(__d2(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','PortedMatch',COUNT(__d2(__NL(Ported_Match_))),COUNT(__d2(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','PhoneUse',COUNT(__d2(__NL(Phone_Use_))),COUNT(__d2(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','PhoneNumberCompanyType',COUNT(__d2(__NL(Phone_Number_Company_Type_))),COUNT(__d2(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','PriorAreaCode',COUNT(__d2(__NL(Prior_Area_Code_))),COUNT(__d2(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','IsActive',COUNT(__d2(__NL(Is_Active_))),COUNT(__d2(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','CarrierName',COUNT(__d2(__NL(Carrier_Name_))),COUNT(__d2(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','ConfidenceScore',COUNT(__d2(__NL(Confidence_Score_))),COUNT(__d2(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','NoSolicitCode',COUNT(__d2(__NL(No_Solicit_Code_))),COUNT(__d2(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','MaximumConfidenceScore',COUNT(__d2(__NL(Maximum_Confidence_Score_))),COUNT(__d2(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','MinimumConfidenceScore',COUNT(__d2(__NL(Minimum_Confidence_Score_))),COUNT(__d2(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','OmitIndicator',COUNT(__d2(__NL(Omit_Indicator_))),COUNT(__d2(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','CurrentFlag',COUNT(__d2(__NL(Current_Flag_))),COUNT(__d2(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','BusinessFlag',COUNT(__d2(__NL(Business_Flag_))),COUNT(__d2(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','RecordType',COUNT(__d2(__NL(Record_Type_))),COUNT(__d2(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','SourceFile',COUNT(__d2(__NL(Source_File_))),COUNT(__d2(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','IverIndicator',COUNT(__d2(__NL(Iver_Indicator_))),COUNT(__d2(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','PhoneType',COUNT(__d2(__NL(Phone_Type_))),COUNT(__d2(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','ValidationFlag',COUNT(__d2(__NL(Validation_Flag_))),COUNT(__d2(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','ValidationDate',COUNT(__d2(__NL(Validation_Date_))),COUNT(__d2(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','HighRiskSIC',COUNT(__d2(__NL(High_Risk_S_I_C_))),COUNT(__d2(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','HighRiskNAICS',COUNT(__d2(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d2(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','RecordSID',COUNT(__d2(__NL(Record_S_I_D_))),COUNT(__d2(__NN(Record_S_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','HouseholdFlag',COUNT(__d2(__NL(Household_Flag_))),COUNT(__d2(__NN(Household_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','CellPhone',COUNT(__d2(__NL(Cell_Phone_))),COUNT(__d2(__NN(Cell_Phone_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','NPA',COUNT(__d2(__NL(N_P_A_))),COUNT(__d2(__NN(N_P_A_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','Phone7',COUNT(__d2(__NL(Phone7_))),COUNT(__d2(__NN(Phone7_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','DID',COUNT(__d2(__NL(D_I_D_))),COUNT(__d2(__NN(D_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','DIDScore',COUNT(__d2(__NL(D_I_D_Score_))),COUNT(__d2(__NN(D_I_D_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','PhoneDateFirstSeen',COUNT(__d2(__NL(Phone_Date_First_Seen_))),COUNT(__d2(__NN(Phone_Date_First_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','PhoneDateLastSeen',COUNT(__d2(__NL(Phone_Date_Last_Seen_))),COUNT(__d2(__NN(Phone_Date_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','PhoneDateVendorFirstReported',COUNT(__d2(__NL(Phone_Date_Vendor_First_Reported_))),COUNT(__d2(__NN(Phone_Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','PhoneDateVendorLastReported',COUNT(__d2(__NL(Phone_Date_Vendor_Last_Reported_))),COUNT(__d2(__NN(Phone_Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','DTNonGLBLastSeen',COUNT(__d2(__NL(D_T_Non_G_L_B_Last_Seen_))),COUNT(__d2(__NN(D_T_Non_G_L_B_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','GLBDPPAFlag',COUNT(__d2(__NL(G_L_B_D_P_P_A_Flag_))),COUNT(__d2(__NN(G_L_B_D_P_P_A_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','DIDType',COUNT(__d2(__NL(D_I_D_Type_))),COUNT(__d2(__NN(D_I_D_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','OrigPhone',COUNT(__d2(__NL(Orig_Phone_))),COUNT(__d2(__NN(Orig_Phone_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','OrigCarrierName',COUNT(__d2(__NL(Orig_Carrier_Name_))),COUNT(__d2(__NN(Orig_Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','RecType',COUNT(__d2(__NL(Rec_Type_))),COUNT(__d2(__NN(Rec_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','ErrStat',COUNT(__d2(__NL(Err_Stat_))),COUNT(__d2(__NN(Err_Stat_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','Rawaid',COUNT(__d2(__NL(Rawaid_))),COUNT(__d2(__NN(Rawaid_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','Cleanaid',COUNT(__d2(__NL(Cleanaid_))),COUNT(__d2(__NN(Cleanaid_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','CurrentRec',COUNT(__d2(__NL(Current_Rec_))),COUNT(__d2(__NN(Current_Rec_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','FirstBuildDate',COUNT(__d2(__NL(First_Build_Date_))),COUNT(__d2(__NN(First_Build_Date_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','LastBuildDate',COUNT(__d2(__NL(Last_Build_Date_))),COUNT(__d2(__NN(Last_Build_Date_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','IngestTPE',COUNT(__d2(__NL(Ingest_T_P_E_))),COUNT(__d2(__NN(Ingest_T_P_E_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','Verified',COUNT(__d2(__NL(Verified_))),COUNT(__d2(__NN(Verified_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','CordCutter',COUNT(__d2(__NL(Cord_Cutter_))),COUNT(__d2(__NN(Cord_Cutter_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','ActivityStatus',COUNT(__d2(__NL(Activity_Status_))),COUNT(__d2(__NN(Activity_Status_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','Prepaid',COUNT(__d2(__NL(Prepaid_))),COUNT(__d2(__NN(Prepaid_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','GlobalSID',COUNT(__d2(__NL(Global_S_I_D_))),COUNT(__d2(__NN(Global_S_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','Src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','OriginalSource',COUNT(__d2(__NL(Original_Source_))),COUNT(__d2(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.CellPhone__Key_Nustar_Phone','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_PhonesInfo__Keys_Phones_Type_Vault_Invalid),COUNT(__d3)},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','phone',COUNT(__d3(__NL(Phone10_))),COUNT(__d3(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','ListingType',COUNT(__d3(__NL(Listing_Type_))),COUNT(__d3(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','PublishCode',COUNT(__d3(__NL(Publish_Code_))),COUNT(__d3(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','PortabilityIndicator',COUNT(__d3(__NL(Portability_Indicator_))),COUNT(__d3(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','NXXType',COUNT(__d3(__NL(N_X_X_Type_))),COUNT(__d3(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','COCType',COUNT(__d3(__NL(C_O_C_Type_))),COUNT(__d3(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','SCC',COUNT(__d3(__NL(S_C_C_))),COUNT(__d3(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','PortedMatch',COUNT(__d3(__NL(Ported_Match_))),COUNT(__d3(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','PhoneUse',COUNT(__d3(__NL(Phone_Use_))),COUNT(__d3(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','PhoneNumberCompanyType',COUNT(__d3(__NL(Phone_Number_Company_Type_))),COUNT(__d3(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','PriorAreaCode',COUNT(__d3(__NL(Prior_Area_Code_))),COUNT(__d3(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','IsActive',COUNT(__d3(__NL(Is_Active_))),COUNT(__d3(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','CarrierName',COUNT(__d3(__NL(Carrier_Name_))),COUNT(__d3(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','ConfidenceScore',COUNT(__d3(__NL(Confidence_Score_))),COUNT(__d3(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','NoSolicitCode',COUNT(__d3(__NL(No_Solicit_Code_))),COUNT(__d3(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','MaximumConfidenceScore',COUNT(__d3(__NL(Maximum_Confidence_Score_))),COUNT(__d3(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','MinimumConfidenceScore',COUNT(__d3(__NL(Minimum_Confidence_Score_))),COUNT(__d3(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','OmitIndicator',COUNT(__d3(__NL(Omit_Indicator_))),COUNT(__d3(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','CurrentFlag',COUNT(__d3(__NL(Current_Flag_))),COUNT(__d3(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','BusinessFlag',COUNT(__d3(__NL(Business_Flag_))),COUNT(__d3(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','RecordType',COUNT(__d3(__NL(Record_Type_))),COUNT(__d3(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','SourceFile',COUNT(__d3(__NL(Source_File_))),COUNT(__d3(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','IverIndicator',COUNT(__d3(__NL(Iver_Indicator_))),COUNT(__d3(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','PhoneType',COUNT(__d3(__NL(Phone_Type_))),COUNT(__d3(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','ValidationFlag',COUNT(__d3(__NL(Validation_Flag_))),COUNT(__d3(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','ValidationDate',COUNT(__d3(__NL(Validation_Date_))),COUNT(__d3(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','HighRiskSIC',COUNT(__d3(__NL(High_Risk_S_I_C_))),COUNT(__d3(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','HighRiskNAICS',COUNT(__d3(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d3(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','record_sid',COUNT(__d3(__NL(Record_S_I_D_))),COUNT(__d3(__NN(Record_S_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','HouseholdFlag',COUNT(__d3(__NL(Household_Flag_))),COUNT(__d3(__NN(Household_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','CellPhone',COUNT(__d3(__NL(Cell_Phone_))),COUNT(__d3(__NN(Cell_Phone_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','NPA',COUNT(__d3(__NL(N_P_A_))),COUNT(__d3(__NN(N_P_A_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','Phone7',COUNT(__d3(__NL(Phone7_))),COUNT(__d3(__NN(Phone7_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','DID',COUNT(__d3(__NL(D_I_D_))),COUNT(__d3(__NN(D_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','DIDScore',COUNT(__d3(__NL(D_I_D_Score_))),COUNT(__d3(__NN(D_I_D_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','PhoneDateFirstSeen',COUNT(__d3(__NL(Phone_Date_First_Seen_))),COUNT(__d3(__NN(Phone_Date_First_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','PhoneDateLastSeen',COUNT(__d3(__NL(Phone_Date_Last_Seen_))),COUNT(__d3(__NN(Phone_Date_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','vendor_first_reported_dt',COUNT(__d3(__NL(Phone_Date_Vendor_First_Reported_))),COUNT(__d3(__NN(Phone_Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','vendor_last_reported_dt',COUNT(__d3(__NL(Phone_Date_Vendor_Last_Reported_))),COUNT(__d3(__NN(Phone_Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','DTNonGLBLastSeen',COUNT(__d3(__NL(D_T_Non_G_L_B_Last_Seen_))),COUNT(__d3(__NN(D_T_Non_G_L_B_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','GLBDPPAFlag',COUNT(__d3(__NL(G_L_B_D_P_P_A_Flag_))),COUNT(__d3(__NN(G_L_B_D_P_P_A_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','DIDType',COUNT(__d3(__NL(D_I_D_Type_))),COUNT(__d3(__NN(D_I_D_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','OrigPhone',COUNT(__d3(__NL(Orig_Phone_))),COUNT(__d3(__NN(Orig_Phone_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','OrigCarrierName',COUNT(__d3(__NL(Orig_Carrier_Name_))),COUNT(__d3(__NN(Orig_Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','RecType',COUNT(__d3(__NL(Rec_Type_))),COUNT(__d3(__NN(Rec_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','ErrStat',COUNT(__d3(__NL(Err_Stat_))),COUNT(__d3(__NN(Err_Stat_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','Rawaid',COUNT(__d3(__NL(Rawaid_))),COUNT(__d3(__NN(Rawaid_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','Cleanaid',COUNT(__d3(__NL(Cleanaid_))),COUNT(__d3(__NN(Cleanaid_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','CurrentRec',COUNT(__d3(__NL(Current_Rec_))),COUNT(__d3(__NN(Current_Rec_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','FirstBuildDate',COUNT(__d3(__NL(First_Build_Date_))),COUNT(__d3(__NN(First_Build_Date_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','LastBuildDate',COUNT(__d3(__NL(Last_Build_Date_))),COUNT(__d3(__NN(Last_Build_Date_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','IngestTPE',COUNT(__d3(__NL(Ingest_T_P_E_))),COUNT(__d3(__NN(Ingest_T_P_E_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','Verified',COUNT(__d3(__NL(Verified_))),COUNT(__d3(__NN(Verified_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','CordCutter',COUNT(__d3(__NL(Cord_Cutter_))),COUNT(__d3(__NN(Cord_Cutter_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','ActivityStatus',COUNT(__d3(__NL(Activity_Status_))),COUNT(__d3(__NN(Activity_Status_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','prepaid',COUNT(__d3(__NL(Prepaid_))),COUNT(__d3(__NN(Prepaid_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','global_sid',COUNT(__d3(__NL(Global_S_I_D_))),COUNT(__d3(__NN(Global_S_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','Src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','source',COUNT(__d3(__NL(Original_Source_))),COUNT(__d3(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','HybridArchiveDate',COUNT(__d3(Hybrid_Archive_Date_=0)),COUNT(__d3(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Type_Vault','VaultDateLastSeen',COUNT(__d3(Vault_Date_Last_Seen_=0)),COUNT(__d3(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_PhonesInfo__Keys_Phones_Transaction_Vault_Invalid),COUNT(__d4)},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','phone',COUNT(__d4(__NL(Phone10_))),COUNT(__d4(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','ListingType',COUNT(__d4(__NL(Listing_Type_))),COUNT(__d4(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','PublishCode',COUNT(__d4(__NL(Publish_Code_))),COUNT(__d4(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','PortabilityIndicator',COUNT(__d4(__NL(Portability_Indicator_))),COUNT(__d4(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','NXXType',COUNT(__d4(__NL(N_X_X_Type_))),COUNT(__d4(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','COCType',COUNT(__d4(__NL(C_O_C_Type_))),COUNT(__d4(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','SCC',COUNT(__d4(__NL(S_C_C_))),COUNT(__d4(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','PortedMatch',COUNT(__d4(__NL(Ported_Match_))),COUNT(__d4(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','PhoneUse',COUNT(__d4(__NL(Phone_Use_))),COUNT(__d4(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','PhoneNumberCompanyType',COUNT(__d4(__NL(Phone_Number_Company_Type_))),COUNT(__d4(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','PriorAreaCode',COUNT(__d4(__NL(Prior_Area_Code_))),COUNT(__d4(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','IsActive',COUNT(__d4(__NL(Is_Active_))),COUNT(__d4(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','carrier_name',COUNT(__d4(__NL(Carrier_Name_))),COUNT(__d4(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','ConfidenceScore',COUNT(__d4(__NL(Confidence_Score_))),COUNT(__d4(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','NoSolicitCode',COUNT(__d4(__NL(No_Solicit_Code_))),COUNT(__d4(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','MaximumConfidenceScore',COUNT(__d4(__NL(Maximum_Confidence_Score_))),COUNT(__d4(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','MinimumConfidenceScore',COUNT(__d4(__NL(Minimum_Confidence_Score_))),COUNT(__d4(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','OmitIndicator',COUNT(__d4(__NL(Omit_Indicator_))),COUNT(__d4(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','CurrentFlag',COUNT(__d4(__NL(Current_Flag_))),COUNT(__d4(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','BusinessFlag',COUNT(__d4(__NL(Business_Flag_))),COUNT(__d4(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','RecordType',COUNT(__d4(__NL(Record_Type_))),COUNT(__d4(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','SourceFile',COUNT(__d4(__NL(Source_File_))),COUNT(__d4(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','IverIndicator',COUNT(__d4(__NL(Iver_Indicator_))),COUNT(__d4(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','PhoneType',COUNT(__d4(__NL(Phone_Type_))),COUNT(__d4(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','ValidationFlag',COUNT(__d4(__NL(Validation_Flag_))),COUNT(__d4(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','ValidationDate',COUNT(__d4(__NL(Validation_Date_))),COUNT(__d4(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','HighRiskSIC',COUNT(__d4(__NL(High_Risk_S_I_C_))),COUNT(__d4(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','HighRiskNAICS',COUNT(__d4(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d4(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','record_sid',COUNT(__d4(__NL(Record_S_I_D_))),COUNT(__d4(__NN(Record_S_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','HouseholdFlag',COUNT(__d4(__NL(Household_Flag_))),COUNT(__d4(__NN(Household_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','CellPhone',COUNT(__d4(__NL(Cell_Phone_))),COUNT(__d4(__NN(Cell_Phone_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','NPA',COUNT(__d4(__NL(N_P_A_))),COUNT(__d4(__NN(N_P_A_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','Phone7',COUNT(__d4(__NL(Phone7_))),COUNT(__d4(__NN(Phone7_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','DID',COUNT(__d4(__NL(D_I_D_))),COUNT(__d4(__NN(D_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','DIDScore',COUNT(__d4(__NL(D_I_D_Score_))),COUNT(__d4(__NN(D_I_D_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','PhoneDateFirstSeen',COUNT(__d4(__NL(Phone_Date_First_Seen_))),COUNT(__d4(__NN(Phone_Date_First_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','PhoneDateLastSeen',COUNT(__d4(__NL(Phone_Date_Last_Seen_))),COUNT(__d4(__NN(Phone_Date_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','vendor_first_reported_dt',COUNT(__d4(__NL(Phone_Date_Vendor_First_Reported_))),COUNT(__d4(__NN(Phone_Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','vendor_last_reported_dt',COUNT(__d4(__NL(Phone_Date_Vendor_Last_Reported_))),COUNT(__d4(__NN(Phone_Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','DTNonGLBLastSeen',COUNT(__d4(__NL(D_T_Non_G_L_B_Last_Seen_))),COUNT(__d4(__NN(D_T_Non_G_L_B_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','GLBDPPAFlag',COUNT(__d4(__NL(G_L_B_D_P_P_A_Flag_))),COUNT(__d4(__NN(G_L_B_D_P_P_A_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','DIDType',COUNT(__d4(__NL(D_I_D_Type_))),COUNT(__d4(__NN(D_I_D_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','OrigPhone',COUNT(__d4(__NL(Orig_Phone_))),COUNT(__d4(__NN(Orig_Phone_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','OrigCarrierName',COUNT(__d4(__NL(Orig_Carrier_Name_))),COUNT(__d4(__NN(Orig_Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','RecType',COUNT(__d4(__NL(Rec_Type_))),COUNT(__d4(__NN(Rec_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','ErrStat',COUNT(__d4(__NL(Err_Stat_))),COUNT(__d4(__NN(Err_Stat_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','Rawaid',COUNT(__d4(__NL(Rawaid_))),COUNT(__d4(__NN(Rawaid_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','Cleanaid',COUNT(__d4(__NL(Cleanaid_))),COUNT(__d4(__NN(Cleanaid_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','CurrentRec',COUNT(__d4(__NL(Current_Rec_))),COUNT(__d4(__NN(Current_Rec_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','FirstBuildDate',COUNT(__d4(__NL(First_Build_Date_))),COUNT(__d4(__NN(First_Build_Date_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','LastBuildDate',COUNT(__d4(__NL(Last_Build_Date_))),COUNT(__d4(__NN(Last_Build_Date_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','IngestTPE',COUNT(__d4(__NL(Ingest_T_P_E_))),COUNT(__d4(__NN(Ingest_T_P_E_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','Verified',COUNT(__d4(__NL(Verified_))),COUNT(__d4(__NN(Verified_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','CordCutter',COUNT(__d4(__NL(Cord_Cutter_))),COUNT(__d4(__NN(Cord_Cutter_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','ActivityStatus',COUNT(__d4(__NL(Activity_Status_))),COUNT(__d4(__NN(Activity_Status_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','Prepaid',COUNT(__d4(__NL(Prepaid_))),COUNT(__d4(__NN(Prepaid_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','global_sid',COUNT(__d4(__NL(Global_S_I_D_))),COUNT(__d4(__NN(Global_S_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','Src',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','source',COUNT(__d4(__NL(Original_Source_))),COUNT(__d4(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','Archive_Date',COUNT(__d4(Archive___Date_=0)),COUNT(__d4(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','HybridArchiveDate',COUNT(__d4(Hybrid_Archive_Date_=0)),COUNT(__d4(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesInfo__Keys_Phones_Transaction_Vault','VaultDateLastSeen',COUNT(__d4(Vault_Date_Last_Seen_=0)),COUNT(__d4(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_PhonesPlus_v2_Keys__Source_Level_Payload_Vault_Invalid),COUNT(__d5)},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','cellphone',COUNT(__d5(__NL(Phone10_))),COUNT(__d5(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','ListingType',COUNT(__d5(__NL(Listing_Type_))),COUNT(__d5(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','PublishCode',COUNT(__d5(__NL(Publish_Code_))),COUNT(__d5(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','PortabilityIndicator',COUNT(__d5(__NL(Portability_Indicator_))),COUNT(__d5(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','NXXType',COUNT(__d5(__NL(N_X_X_Type_))),COUNT(__d5(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','COCType',COUNT(__d5(__NL(C_O_C_Type_))),COUNT(__d5(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','SCC',COUNT(__d5(__NL(S_C_C_))),COUNT(__d5(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','PortedMatch',COUNT(__d5(__NL(Ported_Match_))),COUNT(__d5(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','PhoneUse',COUNT(__d5(__NL(Phone_Use_))),COUNT(__d5(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','PhoneNumberCompanyType',COUNT(__d5(__NL(Phone_Number_Company_Type_))),COUNT(__d5(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','PriorAreaCode',COUNT(__d5(__NL(Prior_Area_Code_))),COUNT(__d5(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','IsActive',COUNT(__d5(__NL(Is_Active_))),COUNT(__d5(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','CarrierName',COUNT(__d5(__NL(Carrier_Name_))),COUNT(__d5(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','ConfidenceScore',COUNT(__d5(__NL(Confidence_Score_))),COUNT(__d5(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','NoSolicitCode',COUNT(__d5(__NL(No_Solicit_Code_))),COUNT(__d5(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','MaximumConfidenceScore',COUNT(__d5(__NL(Maximum_Confidence_Score_))),COUNT(__d5(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','MinimumConfidenceScore',COUNT(__d5(__NL(Minimum_Confidence_Score_))),COUNT(__d5(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','OmitIndicator',COUNT(__d5(__NL(Omit_Indicator_))),COUNT(__d5(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','CurrentFlag',COUNT(__d5(__NL(Current_Flag_))),COUNT(__d5(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','BusinessFlag',COUNT(__d5(__NL(Business_Flag_))),COUNT(__d5(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','RecordType',COUNT(__d5(__NL(Record_Type_))),COUNT(__d5(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','SourceFile',COUNT(__d5(__NL(Source_File_))),COUNT(__d5(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','IverIndicator',COUNT(__d5(__NL(Iver_Indicator_))),COUNT(__d5(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','PhoneType',COUNT(__d5(__NL(Phone_Type_))),COUNT(__d5(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','ValidationFlag',COUNT(__d5(__NL(Validation_Flag_))),COUNT(__d5(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','ValidationDate',COUNT(__d5(__NL(Validation_Date_))),COUNT(__d5(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','HighRiskSIC',COUNT(__d5(__NL(High_Risk_S_I_C_))),COUNT(__d5(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','HighRiskNAICS',COUNT(__d5(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d5(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','record_sid',COUNT(__d5(__NL(Record_S_I_D_))),COUNT(__d5(__NN(Record_S_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','household_flag',COUNT(__d5(__NL(Household_Flag_))),COUNT(__d5(__NN(Household_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','cellphone',COUNT(__d5(__NL(Cell_Phone_))),COUNT(__d5(__NN(Cell_Phone_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','npa',COUNT(__d5(__NL(N_P_A_))),COUNT(__d5(__NN(N_P_A_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','phone7',COUNT(__d5(__NL(Phone7_))),COUNT(__d5(__NN(Phone7_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','did',COUNT(__d5(__NL(D_I_D_))),COUNT(__d5(__NN(D_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','did_score',COUNT(__d5(__NL(D_I_D_Score_))),COUNT(__d5(__NN(D_I_D_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','PhoneDateFirstSeen',COUNT(__d5(__NL(Phone_Date_First_Seen_))),COUNT(__d5(__NN(Phone_Date_First_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','PhoneDateLastSeen',COUNT(__d5(__NL(Phone_Date_Last_Seen_))),COUNT(__d5(__NN(Phone_Date_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','datevendorfirstreported',COUNT(__d5(__NL(Phone_Date_Vendor_First_Reported_))),COUNT(__d5(__NN(Phone_Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','datevendorlastreported',COUNT(__d5(__NL(Phone_Date_Vendor_Last_Reported_))),COUNT(__d5(__NN(Phone_Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','dt_nonglb_last_seen',COUNT(__d5(__NL(D_T_Non_G_L_B_Last_Seen_))),COUNT(__d5(__NN(D_T_Non_G_L_B_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','glb_dppa_flag',COUNT(__d5(__NL(G_L_B_D_P_P_A_Flag_))),COUNT(__d5(__NN(G_L_B_D_P_P_A_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','did_type',COUNT(__d5(__NL(D_I_D_Type_))),COUNT(__d5(__NN(D_I_D_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','orig_phone',COUNT(__d5(__NL(Orig_Phone_))),COUNT(__d5(__NN(Orig_Phone_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','orig_carrier_name',COUNT(__d5(__NL(Orig_Carrier_Name_))),COUNT(__d5(__NN(Orig_Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','rec_type',COUNT(__d5(__NL(Rec_Type_))),COUNT(__d5(__NN(Rec_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','err_stat',COUNT(__d5(__NL(Err_Stat_))),COUNT(__d5(__NN(Err_Stat_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','rawaid',COUNT(__d5(__NL(Rawaid_))),COUNT(__d5(__NN(Rawaid_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','cleanaid',COUNT(__d5(__NL(Cleanaid_))),COUNT(__d5(__NN(Cleanaid_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','current_rec',COUNT(__d5(__NL(Current_Rec_))),COUNT(__d5(__NN(Current_Rec_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','first_build_date',COUNT(__d5(__NL(First_Build_Date_))),COUNT(__d5(__NN(First_Build_Date_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','last_build_date',COUNT(__d5(__NL(Last_Build_Date_))),COUNT(__d5(__NN(Last_Build_Date_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','ingest_tpe',COUNT(__d5(__NL(Ingest_T_P_E_))),COUNT(__d5(__NN(Ingest_T_P_E_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','verified',COUNT(__d5(__NL(Verified_))),COUNT(__d5(__NN(Verified_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','cord_cutter',COUNT(__d5(__NL(Cord_Cutter_))),COUNT(__d5(__NN(Cord_Cutter_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','activity_status',COUNT(__d5(__NL(Activity_Status_))),COUNT(__d5(__NN(Activity_Status_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','prepaid',COUNT(__d5(__NL(Prepaid_))),COUNT(__d5(__NN(Prepaid_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','global_sid',COUNT(__d5(__NL(Global_S_I_D_))),COUNT(__d5(__NN(Global_S_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','Src',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','source',COUNT(__d5(__NL(Original_Source_))),COUNT(__d5(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','Archive_Date',COUNT(__d5(Archive___Date_=0)),COUNT(__d5(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','HybridArchiveDate',COUNT(__d5(Hybrid_Archive_Date_=0)),COUNT(__d5(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','VaultDateLastSeen',COUNT(__d5(Vault_Date_Last_Seen_=0)),COUNT(__d5(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','UID',COUNT(PublicRecords_KEL_files_NonFCRA_Fraudpoint3__Key_Phone_Vault_Invalid),COUNT(__d6)},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','phone_number',COUNT(__d6(__NL(Phone10_))),COUNT(__d6(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','ListingType',COUNT(__d6(__NL(Listing_Type_))),COUNT(__d6(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','PublishCode',COUNT(__d6(__NL(Publish_Code_))),COUNT(__d6(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','PortabilityIndicator',COUNT(__d6(__NL(Portability_Indicator_))),COUNT(__d6(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','NXXType',COUNT(__d6(__NL(N_X_X_Type_))),COUNT(__d6(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','COCType',COUNT(__d6(__NL(C_O_C_Type_))),COUNT(__d6(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','SCC',COUNT(__d6(__NL(S_C_C_))),COUNT(__d6(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','PortedMatch',COUNT(__d6(__NL(Ported_Match_))),COUNT(__d6(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','PhoneUse',COUNT(__d6(__NL(Phone_Use_))),COUNT(__d6(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','PhoneNumberCompanyType',COUNT(__d6(__NL(Phone_Number_Company_Type_))),COUNT(__d6(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','PriorAreaCode',COUNT(__d6(__NL(Prior_Area_Code_))),COUNT(__d6(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','IsActive',COUNT(__d6(__NL(Is_Active_))),COUNT(__d6(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','CarrierName',COUNT(__d6(__NL(Carrier_Name_))),COUNT(__d6(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','ConfidenceScore',COUNT(__d6(__NL(Confidence_Score_))),COUNT(__d6(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','NoSolicitCode',COUNT(__d6(__NL(No_Solicit_Code_))),COUNT(__d6(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','MaximumConfidenceScore',COUNT(__d6(__NL(Maximum_Confidence_Score_))),COUNT(__d6(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','MinimumConfidenceScore',COUNT(__d6(__NL(Minimum_Confidence_Score_))),COUNT(__d6(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','OmitIndicator',COUNT(__d6(__NL(Omit_Indicator_))),COUNT(__d6(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','CurrentFlag',COUNT(__d6(__NL(Current_Flag_))),COUNT(__d6(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','BusinessFlag',COUNT(__d6(__NL(Business_Flag_))),COUNT(__d6(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','RecordType',COUNT(__d6(__NL(Record_Type_))),COUNT(__d6(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','SourceFile',COUNT(__d6(__NL(Source_File_))),COUNT(__d6(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','IverIndicator',COUNT(__d6(__NL(Iver_Indicator_))),COUNT(__d6(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','PhoneType',COUNT(__d6(__NL(Phone_Type_))),COUNT(__d6(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','ValidationFlag',COUNT(__d6(__NL(Validation_Flag_))),COUNT(__d6(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','ValidationDate',COUNT(__d6(__NL(Validation_Date_))),COUNT(__d6(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','HighRiskSIC',COUNT(__d6(__NL(High_Risk_S_I_C_))),COUNT(__d6(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','HighRiskNAICS',COUNT(__d6(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d6(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','RecordSID',COUNT(__d6(__NL(Record_S_I_D_))),COUNT(__d6(__NN(Record_S_I_D_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','HouseholdFlag',COUNT(__d6(__NL(Household_Flag_))),COUNT(__d6(__NN(Household_Flag_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','CellPhone',COUNT(__d6(__NL(Cell_Phone_))),COUNT(__d6(__NN(Cell_Phone_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','NPA',COUNT(__d6(__NL(N_P_A_))),COUNT(__d6(__NN(N_P_A_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','Phone7',COUNT(__d6(__NL(Phone7_))),COUNT(__d6(__NN(Phone7_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','appended_lexid',COUNT(__d6(__NL(D_I_D_))),COUNT(__d6(__NN(D_I_D_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','DIDScore',COUNT(__d6(__NL(D_I_D_Score_))),COUNT(__d6(__NN(D_I_D_Score_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','PhoneDateFirstSeen',COUNT(__d6(__NL(Phone_Date_First_Seen_))),COUNT(__d6(__NN(Phone_Date_First_Seen_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','PhoneDateLastSeen',COUNT(__d6(__NL(Phone_Date_Last_Seen_))),COUNT(__d6(__NN(Phone_Date_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','PhoneDateVendorFirstReported',COUNT(__d6(__NL(Phone_Date_Vendor_First_Reported_))),COUNT(__d6(__NN(Phone_Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','PhoneDateVendorLastReported',COUNT(__d6(__NL(Phone_Date_Vendor_Last_Reported_))),COUNT(__d6(__NN(Phone_Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','DTNonGLBLastSeen',COUNT(__d6(__NL(D_T_Non_G_L_B_Last_Seen_))),COUNT(__d6(__NN(D_T_Non_G_L_B_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','GLBDPPAFlag',COUNT(__d6(__NL(G_L_B_D_P_P_A_Flag_))),COUNT(__d6(__NN(G_L_B_D_P_P_A_Flag_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','DIDType',COUNT(__d6(__NL(D_I_D_Type_))),COUNT(__d6(__NN(D_I_D_Type_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','OrigPhone',COUNT(__d6(__NL(Orig_Phone_))),COUNT(__d6(__NN(Orig_Phone_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','OrigCarrierName',COUNT(__d6(__NL(Orig_Carrier_Name_))),COUNT(__d6(__NN(Orig_Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','rec_type',COUNT(__d6(__NL(Rec_Type_))),COUNT(__d6(__NN(Rec_Type_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','err_stat',COUNT(__d6(__NL(Err_Stat_))),COUNT(__d6(__NN(Err_Stat_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','Rawaid',COUNT(__d6(__NL(Rawaid_))),COUNT(__d6(__NN(Rawaid_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','Cleanaid',COUNT(__d6(__NL(Cleanaid_))),COUNT(__d6(__NN(Cleanaid_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','CurrentRec',COUNT(__d6(__NL(Current_Rec_))),COUNT(__d6(__NN(Current_Rec_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','FirstBuildDate',COUNT(__d6(__NL(First_Build_Date_))),COUNT(__d6(__NN(First_Build_Date_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','LastBuildDate',COUNT(__d6(__NL(Last_Build_Date_))),COUNT(__d6(__NN(Last_Build_Date_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','IngestTPE',COUNT(__d6(__NL(Ingest_T_P_E_))),COUNT(__d6(__NN(Ingest_T_P_E_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','Verified',COUNT(__d6(__NL(Verified_))),COUNT(__d6(__NN(Verified_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','CordCutter',COUNT(__d6(__NL(Cord_Cutter_))),COUNT(__d6(__NN(Cord_Cutter_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','ActivityStatus',COUNT(__d6(__NL(Activity_Status_))),COUNT(__d6(__NN(Activity_Status_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','Prepaid',COUNT(__d6(__NL(Prepaid_))),COUNT(__d6(__NN(Prepaid_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','GlobalSID',COUNT(__d6(__NL(Global_S_I_D_))),COUNT(__d6(__NN(Global_S_I_D_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','Src',COUNT(__d6(__NL(Source_))),COUNT(__d6(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','OriginalSource',COUNT(__d6(__NL(Original_Source_))),COUNT(__d6(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','Archive_Date',COUNT(__d6(Archive___Date_=0)),COUNT(__d6(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','HybridArchiveDate',COUNT(__d6(Hybrid_Archive_Date_=0)),COUNT(__d6(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_Phone_Vault','VaultDateLastSeen',COUNT(__d6(Vault_Date_Last_Seen_=0)),COUNT(__d6(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_Targus__Key_Targus_Phone_Vault_Invalid),COUNT(__d7)},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','phone_number',COUNT(__d7(__NL(Phone10_))),COUNT(__d7(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','ListingType',COUNT(__d7(__NL(Listing_Type_))),COUNT(__d7(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','PublishCode',COUNT(__d7(__NL(Publish_Code_))),COUNT(__d7(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','PortabilityIndicator',COUNT(__d7(__NL(Portability_Indicator_))),COUNT(__d7(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','NXXType',COUNT(__d7(__NL(N_X_X_Type_))),COUNT(__d7(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','COCType',COUNT(__d7(__NL(C_O_C_Type_))),COUNT(__d7(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','SCC',COUNT(__d7(__NL(S_C_C_))),COUNT(__d7(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','PortedMatch',COUNT(__d7(__NL(Ported_Match_))),COUNT(__d7(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','PhoneUse',COUNT(__d7(__NL(Phone_Use_))),COUNT(__d7(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','PhoneNumberCompanyType',COUNT(__d7(__NL(Phone_Number_Company_Type_))),COUNT(__d7(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','PriorAreaCode',COUNT(__d7(__NL(Prior_Area_Code_))),COUNT(__d7(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','IsActive',COUNT(__d7(__NL(Is_Active_))),COUNT(__d7(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','CarrierName',COUNT(__d7(__NL(Carrier_Name_))),COUNT(__d7(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','ConfidenceScore',COUNT(__d7(__NL(Confidence_Score_))),COUNT(__d7(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','NoSolicitCode',COUNT(__d7(__NL(No_Solicit_Code_))),COUNT(__d7(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','MaximumConfidenceScore',COUNT(__d7(__NL(Maximum_Confidence_Score_))),COUNT(__d7(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','MinimumConfidenceScore',COUNT(__d7(__NL(Minimum_Confidence_Score_))),COUNT(__d7(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','OmitIndicator',COUNT(__d7(__NL(Omit_Indicator_))),COUNT(__d7(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','CurrentFlag',COUNT(__d7(__NL(Current_Flag_))),COUNT(__d7(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','BusinessFlag',COUNT(__d7(__NL(Business_Flag_))),COUNT(__d7(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','RecordType',COUNT(__d7(__NL(Record_Type_))),COUNT(__d7(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','SourceFile',COUNT(__d7(__NL(Source_File_))),COUNT(__d7(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','IverIndicator',COUNT(__d7(__NL(Iver_Indicator_))),COUNT(__d7(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','PhoneType',COUNT(__d7(__NL(Phone_Type_))),COUNT(__d7(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','validation_flag',COUNT(__d7(__NL(Validation_Flag_))),COUNT(__d7(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','ValidationDate',COUNT(__d7(__NL(Validation_Date_))),COUNT(__d7(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','HighRiskSIC',COUNT(__d7(__NL(High_Risk_S_I_C_))),COUNT(__d7(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','HighRiskNAICS',COUNT(__d7(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d7(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','RecordSID',COUNT(__d7(__NL(Record_S_I_D_))),COUNT(__d7(__NN(Record_S_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','HouseholdFlag',COUNT(__d7(__NL(Household_Flag_))),COUNT(__d7(__NN(Household_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','CellPhone',COUNT(__d7(__NL(Cell_Phone_))),COUNT(__d7(__NN(Cell_Phone_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','NPA',COUNT(__d7(__NL(N_P_A_))),COUNT(__d7(__NN(N_P_A_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','Phone7',COUNT(__d7(__NL(Phone7_))),COUNT(__d7(__NN(Phone7_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','DID',COUNT(__d7(__NL(D_I_D_))),COUNT(__d7(__NN(D_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','DIDScore',COUNT(__d7(__NL(D_I_D_Score_))),COUNT(__d7(__NN(D_I_D_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','PhoneDateFirstSeen',COUNT(__d7(__NL(Phone_Date_First_Seen_))),COUNT(__d7(__NN(Phone_Date_First_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','PhoneDateLastSeen',COUNT(__d7(__NL(Phone_Date_Last_Seen_))),COUNT(__d7(__NN(Phone_Date_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','PhoneDateVendorFirstReported',COUNT(__d7(__NL(Phone_Date_Vendor_First_Reported_))),COUNT(__d7(__NN(Phone_Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','PhoneDateVendorLastReported',COUNT(__d7(__NL(Phone_Date_Vendor_Last_Reported_))),COUNT(__d7(__NN(Phone_Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','DTNonGLBLastSeen',COUNT(__d7(__NL(D_T_Non_G_L_B_Last_Seen_))),COUNT(__d7(__NN(D_T_Non_G_L_B_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','GLBDPPAFlag',COUNT(__d7(__NL(G_L_B_D_P_P_A_Flag_))),COUNT(__d7(__NN(G_L_B_D_P_P_A_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','DIDType',COUNT(__d7(__NL(D_I_D_Type_))),COUNT(__d7(__NN(D_I_D_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','OrigPhone',COUNT(__d7(__NL(Orig_Phone_))),COUNT(__d7(__NN(Orig_Phone_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','OrigCarrierName',COUNT(__d7(__NL(Orig_Carrier_Name_))),COUNT(__d7(__NN(Orig_Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','RecType',COUNT(__d7(__NL(Rec_Type_))),COUNT(__d7(__NN(Rec_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','ErrStat',COUNT(__d7(__NL(Err_Stat_))),COUNT(__d7(__NN(Err_Stat_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','Rawaid',COUNT(__d7(__NL(Rawaid_))),COUNT(__d7(__NN(Rawaid_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','Cleanaid',COUNT(__d7(__NL(Cleanaid_))),COUNT(__d7(__NN(Cleanaid_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','CurrentRec',COUNT(__d7(__NL(Current_Rec_))),COUNT(__d7(__NN(Current_Rec_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','FirstBuildDate',COUNT(__d7(__NL(First_Build_Date_))),COUNT(__d7(__NN(First_Build_Date_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','LastBuildDate',COUNT(__d7(__NL(Last_Build_Date_))),COUNT(__d7(__NN(Last_Build_Date_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','IngestTPE',COUNT(__d7(__NL(Ingest_T_P_E_))),COUNT(__d7(__NN(Ingest_T_P_E_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','Verified',COUNT(__d7(__NL(Verified_))),COUNT(__d7(__NN(Verified_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','CordCutter',COUNT(__d7(__NL(Cord_Cutter_))),COUNT(__d7(__NN(Cord_Cutter_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','ActivityStatus',COUNT(__d7(__NL(Activity_Status_))),COUNT(__d7(__NN(Activity_Status_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','Prepaid',COUNT(__d7(__NL(Prepaid_))),COUNT(__d7(__NN(Prepaid_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','GlobalSID',COUNT(__d7(__NL(Global_S_I_D_))),COUNT(__d7(__NN(Global_S_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','src',COUNT(__d7(__NL(Source_))),COUNT(__d7(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','OriginalSource',COUNT(__d7(__NL(Original_Source_))),COUNT(__d7(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','Archive_Date',COUNT(__d7(Archive___Date_=0)),COUNT(__d7(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','DateFirstSeen',COUNT(__d7(Date_First_Seen_=0)),COUNT(__d7(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','DateLastSeen',COUNT(__d7(Date_Last_Seen_=0)),COUNT(__d7(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','HybridArchiveDate',COUNT(__d7(Hybrid_Archive_Date_=0)),COUNT(__d7(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.Targus__Key_Targus_Phone_Vault','VaultDateLastSeen',COUNT(__d7(Vault_Date_Last_Seen_=0)),COUNT(__d7(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_InfutorCID__Key_Infutor_Phone_Vault_Invalid),COUNT(__d8)},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','phone',COUNT(__d8(__NL(Phone10_))),COUNT(__d8(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','ListingType',COUNT(__d8(__NL(Listing_Type_))),COUNT(__d8(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','PublishCode',COUNT(__d8(__NL(Publish_Code_))),COUNT(__d8(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','PortabilityIndicator',COUNT(__d8(__NL(Portability_Indicator_))),COUNT(__d8(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','NXXType',COUNT(__d8(__NL(N_X_X_Type_))),COUNT(__d8(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','COCType',COUNT(__d8(__NL(C_O_C_Type_))),COUNT(__d8(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','SCC',COUNT(__d8(__NL(S_C_C_))),COUNT(__d8(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','PortedMatch',COUNT(__d8(__NL(Ported_Match_))),COUNT(__d8(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','PhoneUse',COUNT(__d8(__NL(Phone_Use_))),COUNT(__d8(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','PhoneNumberCompanyType',COUNT(__d8(__NL(Phone_Number_Company_Type_))),COUNT(__d8(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','PriorAreaCode',COUNT(__d8(__NL(Prior_Area_Code_))),COUNT(__d8(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','IsActive',COUNT(__d8(__NL(Is_Active_))),COUNT(__d8(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','CarrierName',COUNT(__d8(__NL(Carrier_Name_))),COUNT(__d8(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','ConfidenceScore',COUNT(__d8(__NL(Confidence_Score_))),COUNT(__d8(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','NoSolicitCode',COUNT(__d8(__NL(No_Solicit_Code_))),COUNT(__d8(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','MaximumConfidenceScore',COUNT(__d8(__NL(Maximum_Confidence_Score_))),COUNT(__d8(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','MinimumConfidenceScore',COUNT(__d8(__NL(Minimum_Confidence_Score_))),COUNT(__d8(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','OmitIndicator',COUNT(__d8(__NL(Omit_Indicator_))),COUNT(__d8(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','CurrentFlag',COUNT(__d8(__NL(Current_Flag_))),COUNT(__d8(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','BusinessFlag',COUNT(__d8(__NL(Business_Flag_))),COUNT(__d8(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','rec_type',COUNT(__d8(__NL(Record_Type_))),COUNT(__d8(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','SourceFile',COUNT(__d8(__NL(Source_File_))),COUNT(__d8(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','IverIndicator',COUNT(__d8(__NL(Iver_Indicator_))),COUNT(__d8(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','PhoneType',COUNT(__d8(__NL(Phone_Type_))),COUNT(__d8(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','ValidationFlag',COUNT(__d8(__NL(Validation_Flag_))),COUNT(__d8(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','ValidationDate',COUNT(__d8(__NL(Validation_Date_))),COUNT(__d8(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','HighRiskSIC',COUNT(__d8(__NL(High_Risk_S_I_C_))),COUNT(__d8(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','HighRiskNAICS',COUNT(__d8(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d8(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','RecordSID',COUNT(__d8(__NL(Record_S_I_D_))),COUNT(__d8(__NN(Record_S_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','HouseholdFlag',COUNT(__d8(__NL(Household_Flag_))),COUNT(__d8(__NN(Household_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','CellPhone',COUNT(__d8(__NL(Cell_Phone_))),COUNT(__d8(__NN(Cell_Phone_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','NPA',COUNT(__d8(__NL(N_P_A_))),COUNT(__d8(__NN(N_P_A_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','Phone7',COUNT(__d8(__NL(Phone7_))),COUNT(__d8(__NN(Phone7_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','DID',COUNT(__d8(__NL(D_I_D_))),COUNT(__d8(__NN(D_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','DIDScore',COUNT(__d8(__NL(D_I_D_Score_))),COUNT(__d8(__NN(D_I_D_Score_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','PhoneDateFirstSeen',COUNT(__d8(__NL(Phone_Date_First_Seen_))),COUNT(__d8(__NN(Phone_Date_First_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','PhoneDateLastSeen',COUNT(__d8(__NL(Phone_Date_Last_Seen_))),COUNT(__d8(__NN(Phone_Date_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','PhoneDateVendorFirstReported',COUNT(__d8(__NL(Phone_Date_Vendor_First_Reported_))),COUNT(__d8(__NN(Phone_Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','PhoneDateVendorLastReported',COUNT(__d8(__NL(Phone_Date_Vendor_Last_Reported_))),COUNT(__d8(__NN(Phone_Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','DTNonGLBLastSeen',COUNT(__d8(__NL(D_T_Non_G_L_B_Last_Seen_))),COUNT(__d8(__NN(D_T_Non_G_L_B_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','GLBDPPAFlag',COUNT(__d8(__NL(G_L_B_D_P_P_A_Flag_))),COUNT(__d8(__NN(G_L_B_D_P_P_A_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','DIDType',COUNT(__d8(__NL(D_I_D_Type_))),COUNT(__d8(__NN(D_I_D_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','OrigPhone',COUNT(__d8(__NL(Orig_Phone_))),COUNT(__d8(__NN(Orig_Phone_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','OrigCarrierName',COUNT(__d8(__NL(Orig_Carrier_Name_))),COUNT(__d8(__NN(Orig_Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','RecType',COUNT(__d8(__NL(Rec_Type_))),COUNT(__d8(__NN(Rec_Type_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','ErrStat',COUNT(__d8(__NL(Err_Stat_))),COUNT(__d8(__NN(Err_Stat_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','Rawaid',COUNT(__d8(__NL(Rawaid_))),COUNT(__d8(__NN(Rawaid_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','Cleanaid',COUNT(__d8(__NL(Cleanaid_))),COUNT(__d8(__NN(Cleanaid_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','CurrentRec',COUNT(__d8(__NL(Current_Rec_))),COUNT(__d8(__NN(Current_Rec_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','FirstBuildDate',COUNT(__d8(__NL(First_Build_Date_))),COUNT(__d8(__NN(First_Build_Date_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','LastBuildDate',COUNT(__d8(__NL(Last_Build_Date_))),COUNT(__d8(__NN(Last_Build_Date_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','IngestTPE',COUNT(__d8(__NL(Ingest_T_P_E_))),COUNT(__d8(__NN(Ingest_T_P_E_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','Verified',COUNT(__d8(__NL(Verified_))),COUNT(__d8(__NN(Verified_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','CordCutter',COUNT(__d8(__NL(Cord_Cutter_))),COUNT(__d8(__NN(Cord_Cutter_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','ActivityStatus',COUNT(__d8(__NL(Activity_Status_))),COUNT(__d8(__NN(Activity_Status_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','Prepaid',COUNT(__d8(__NL(Prepaid_))),COUNT(__d8(__NN(Prepaid_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','GlobalSID',COUNT(__d8(__NL(Global_S_I_D_))),COUNT(__d8(__NN(Global_S_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','src',COUNT(__d8(__NL(Source_))),COUNT(__d8(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','OriginalSource',COUNT(__d8(__NL(Original_Source_))),COUNT(__d8(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','Archive_Date',COUNT(__d8(Archive___Date_=0)),COUNT(__d8(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','DateFirstSeen',COUNT(__d8(Date_First_Seen_=0)),COUNT(__d8(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','DateLastSeen',COUNT(__d8(Date_Last_Seen_=0)),COUNT(__d8(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','HybridArchiveDate',COUNT(__d8(Hybrid_Archive_Date_=0)),COUNT(__d8(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.Files.NonFCRA.InfutorCID__Key_Infutor_Phone_Vault','VaultDateLastSeen',COUNT(__d8(Vault_Date_Last_Seen_=0)),COUNT(__d8(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','UID',COUNT(PublicRecords_KEL_files_NonFCRA_BIPV2_Build__HighRiskPhone_vault_Invalid),COUNT(__d9)},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','company_phone',COUNT(__d9(__NL(Phone10_))),COUNT(__d9(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','ListingType',COUNT(__d9(__NL(Listing_Type_))),COUNT(__d9(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','PublishCode',COUNT(__d9(__NL(Publish_Code_))),COUNT(__d9(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','PortabilityIndicator',COUNT(__d9(__NL(Portability_Indicator_))),COUNT(__d9(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','NXXType',COUNT(__d9(__NL(N_X_X_Type_))),COUNT(__d9(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','COCType',COUNT(__d9(__NL(C_O_C_Type_))),COUNT(__d9(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','SCC',COUNT(__d9(__NL(S_C_C_))),COUNT(__d9(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','PortedMatch',COUNT(__d9(__NL(Ported_Match_))),COUNT(__d9(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','PhoneUse',COUNT(__d9(__NL(Phone_Use_))),COUNT(__d9(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','PhoneNumberCompanyType',COUNT(__d9(__NL(Phone_Number_Company_Type_))),COUNT(__d9(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','PriorAreaCode',COUNT(__d9(__NL(Prior_Area_Code_))),COUNT(__d9(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','IsActive',COUNT(__d9(__NL(Is_Active_))),COUNT(__d9(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','CarrierName',COUNT(__d9(__NL(Carrier_Name_))),COUNT(__d9(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','ConfidenceScore',COUNT(__d9(__NL(Confidence_Score_))),COUNT(__d9(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','NoSolicitCode',COUNT(__d9(__NL(No_Solicit_Code_))),COUNT(__d9(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','MaximumConfidenceScore',COUNT(__d9(__NL(Maximum_Confidence_Score_))),COUNT(__d9(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','MinimumConfidenceScore',COUNT(__d9(__NL(Minimum_Confidence_Score_))),COUNT(__d9(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','OmitIndicator',COUNT(__d9(__NL(Omit_Indicator_))),COUNT(__d9(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','CurrentFlag',COUNT(__d9(__NL(Current_Flag_))),COUNT(__d9(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','BusinessFlag',COUNT(__d9(__NL(Business_Flag_))),COUNT(__d9(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','RecordType',COUNT(__d9(__NL(Record_Type_))),COUNT(__d9(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','SourceFile',COUNT(__d9(__NL(Source_File_))),COUNT(__d9(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','IverIndicator',COUNT(__d9(__NL(Iver_Indicator_))),COUNT(__d9(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','PhoneType',COUNT(__d9(__NL(Phone_Type_))),COUNT(__d9(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','ValidationFlag',COUNT(__d9(__NL(Validation_Flag_))),COUNT(__d9(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','ValidationDate',COUNT(__d9(__NL(Validation_Date_))),COUNT(__d9(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','SIC_Code',COUNT(__d9(__NL(High_Risk_S_I_C_))),COUNT(__d9(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','NAICS_Code',COUNT(__d9(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d9(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','RecordSID',COUNT(__d9(__NL(Record_S_I_D_))),COUNT(__d9(__NN(Record_S_I_D_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','HouseholdFlag',COUNT(__d9(__NL(Household_Flag_))),COUNT(__d9(__NN(Household_Flag_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','CellPhone',COUNT(__d9(__NL(Cell_Phone_))),COUNT(__d9(__NN(Cell_Phone_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','NPA',COUNT(__d9(__NL(N_P_A_))),COUNT(__d9(__NN(N_P_A_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','Phone7',COUNT(__d9(__NL(Phone7_))),COUNT(__d9(__NN(Phone7_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','DID',COUNT(__d9(__NL(D_I_D_))),COUNT(__d9(__NN(D_I_D_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','DIDScore',COUNT(__d9(__NL(D_I_D_Score_))),COUNT(__d9(__NN(D_I_D_Score_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','PhoneDateFirstSeen',COUNT(__d9(__NL(Phone_Date_First_Seen_))),COUNT(__d9(__NN(Phone_Date_First_Seen_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','PhoneDateLastSeen',COUNT(__d9(__NL(Phone_Date_Last_Seen_))),COUNT(__d9(__NN(Phone_Date_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','PhoneDateVendorFirstReported',COUNT(__d9(__NL(Phone_Date_Vendor_First_Reported_))),COUNT(__d9(__NN(Phone_Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','PhoneDateVendorLastReported',COUNT(__d9(__NL(Phone_Date_Vendor_Last_Reported_))),COUNT(__d9(__NN(Phone_Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','DTNonGLBLastSeen',COUNT(__d9(__NL(D_T_Non_G_L_B_Last_Seen_))),COUNT(__d9(__NN(D_T_Non_G_L_B_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','GLBDPPAFlag',COUNT(__d9(__NL(G_L_B_D_P_P_A_Flag_))),COUNT(__d9(__NN(G_L_B_D_P_P_A_Flag_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','DIDType',COUNT(__d9(__NL(D_I_D_Type_))),COUNT(__d9(__NN(D_I_D_Type_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','OrigPhone',COUNT(__d9(__NL(Orig_Phone_))),COUNT(__d9(__NN(Orig_Phone_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','OrigCarrierName',COUNT(__d9(__NL(Orig_Carrier_Name_))),COUNT(__d9(__NN(Orig_Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','RecType',COUNT(__d9(__NL(Rec_Type_))),COUNT(__d9(__NN(Rec_Type_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','ErrStat',COUNT(__d9(__NL(Err_Stat_))),COUNT(__d9(__NN(Err_Stat_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','Rawaid',COUNT(__d9(__NL(Rawaid_))),COUNT(__d9(__NN(Rawaid_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','Cleanaid',COUNT(__d9(__NL(Cleanaid_))),COUNT(__d9(__NN(Cleanaid_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','CurrentRec',COUNT(__d9(__NL(Current_Rec_))),COUNT(__d9(__NN(Current_Rec_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','FirstBuildDate',COUNT(__d9(__NL(First_Build_Date_))),COUNT(__d9(__NN(First_Build_Date_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','LastBuildDate',COUNT(__d9(__NL(Last_Build_Date_))),COUNT(__d9(__NN(Last_Build_Date_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','IngestTPE',COUNT(__d9(__NL(Ingest_T_P_E_))),COUNT(__d9(__NN(Ingest_T_P_E_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','Verified',COUNT(__d9(__NL(Verified_))),COUNT(__d9(__NN(Verified_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','CordCutter',COUNT(__d9(__NL(Cord_Cutter_))),COUNT(__d9(__NN(Cord_Cutter_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','ActivityStatus',COUNT(__d9(__NL(Activity_Status_))),COUNT(__d9(__NN(Activity_Status_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','Prepaid',COUNT(__d9(__NL(Prepaid_))),COUNT(__d9(__NN(Prepaid_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','GlobalSID',COUNT(__d9(__NL(Global_S_I_D_))),COUNT(__d9(__NN(Global_S_I_D_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','src',COUNT(__d9(__NL(Source_))),COUNT(__d9(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','OriginalSource',COUNT(__d9(__NL(Original_Source_))),COUNT(__d9(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','Archive_Date',COUNT(__d9(Archive___Date_=0)),COUNT(__d9(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','DateFirstSeen',COUNT(__d9(Date_First_Seen_=0)),COUNT(__d9(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','DateLastSeen',COUNT(__d9(Date_Last_Seen_=0)),COUNT(__d9(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','HybridArchiveDate',COUNT(__d9(Hybrid_Archive_Date_=0)),COUNT(__d9(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.files.NonFCRA.BIPV2_Build__HighRiskPhone_vault','VaultDateLastSeen',COUNT(__d9(Vault_Date_Last_Seen_=0)),COUNT(__d9(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','UID',COUNT(PublicRecords_KEL_Files_FCRA_Gong__Key_History_Phone_Vault_Invalid),COUNT(__d10)},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','phone10',COUNT(__d10(__NL(Phone10_))),COUNT(__d10(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','listing_type',COUNT(__d10(__NL(Listing_Type_))),COUNT(__d10(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','publish_code',COUNT(__d10(__NL(Publish_Code_))),COUNT(__d10(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','PortabilityIndicator',COUNT(__d10(__NL(Portability_Indicator_))),COUNT(__d10(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','NXXType',COUNT(__d10(__NL(N_X_X_Type_))),COUNT(__d10(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','COCType',COUNT(__d10(__NL(C_O_C_Type_))),COUNT(__d10(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','SCC',COUNT(__d10(__NL(S_C_C_))),COUNT(__d10(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','PortedMatch',COUNT(__d10(__NL(Ported_Match_))),COUNT(__d10(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','PhoneUse',COUNT(__d10(__NL(Phone_Use_))),COUNT(__d10(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','PhoneNumberCompanyType',COUNT(__d10(__NL(Phone_Number_Company_Type_))),COUNT(__d10(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','prior_area_code',COUNT(__d10(__NL(Prior_Area_Code_))),COUNT(__d10(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','current_record_flag',COUNT(__d10(__NL(Is_Active_))),COUNT(__d10(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','CarrierName',COUNT(__d10(__NL(Carrier_Name_))),COUNT(__d10(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','ConfidenceScore',COUNT(__d10(__NL(Confidence_Score_))),COUNT(__d10(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','NoSolicitCode',COUNT(__d10(__NL(No_Solicit_Code_))),COUNT(__d10(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','MaximumConfidenceScore',COUNT(__d10(__NL(Maximum_Confidence_Score_))),COUNT(__d10(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','MinimumConfidenceScore',COUNT(__d10(__NL(Minimum_Confidence_Score_))),COUNT(__d10(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','omit_phone',COUNT(__d10(__NL(Omit_Indicator_))),COUNT(__d10(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','current_flag',COUNT(__d10(__NL(Current_Flag_))),COUNT(__d10(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','business_flag',COUNT(__d10(__NL(Business_Flag_))),COUNT(__d10(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','RecordType',COUNT(__d10(__NL(Record_Type_))),COUNT(__d10(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','SourceFile',COUNT(__d10(__NL(Source_File_))),COUNT(__d10(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','IverIndicator',COUNT(__d10(__NL(Iver_Indicator_))),COUNT(__d10(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','PhoneType',COUNT(__d10(__NL(Phone_Type_))),COUNT(__d10(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','ValidationFlag',COUNT(__d10(__NL(Validation_Flag_))),COUNT(__d10(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','ValidationDate',COUNT(__d10(__NL(Validation_Date_))),COUNT(__d10(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','HighRiskSIC',COUNT(__d10(__NL(High_Risk_S_I_C_))),COUNT(__d10(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','HighRiskNAICS',COUNT(__d10(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d10(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','RecordSID',COUNT(__d10(__NL(Record_S_I_D_))),COUNT(__d10(__NN(Record_S_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','HouseholdFlag',COUNT(__d10(__NL(Household_Flag_))),COUNT(__d10(__NN(Household_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','CellPhone',COUNT(__d10(__NL(Cell_Phone_))),COUNT(__d10(__NN(Cell_Phone_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','NPA',COUNT(__d10(__NL(N_P_A_))),COUNT(__d10(__NN(N_P_A_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','Phone7',COUNT(__d10(__NL(Phone7_))),COUNT(__d10(__NN(Phone7_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','DID',COUNT(__d10(__NL(D_I_D_))),COUNT(__d10(__NN(D_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','DIDScore',COUNT(__d10(__NL(D_I_D_Score_))),COUNT(__d10(__NN(D_I_D_Score_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','PhoneDateFirstSeen',COUNT(__d10(__NL(Phone_Date_First_Seen_))),COUNT(__d10(__NN(Phone_Date_First_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','PhoneDateLastSeen',COUNT(__d10(__NL(Phone_Date_Last_Seen_))),COUNT(__d10(__NN(Phone_Date_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','PhoneDateVendorFirstReported',COUNT(__d10(__NL(Phone_Date_Vendor_First_Reported_))),COUNT(__d10(__NN(Phone_Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','PhoneDateVendorLastReported',COUNT(__d10(__NL(Phone_Date_Vendor_Last_Reported_))),COUNT(__d10(__NN(Phone_Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','DTNonGLBLastSeen',COUNT(__d10(__NL(D_T_Non_G_L_B_Last_Seen_))),COUNT(__d10(__NN(D_T_Non_G_L_B_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','GLBDPPAFlag',COUNT(__d10(__NL(G_L_B_D_P_P_A_Flag_))),COUNT(__d10(__NN(G_L_B_D_P_P_A_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','DIDType',COUNT(__d10(__NL(D_I_D_Type_))),COUNT(__d10(__NN(D_I_D_Type_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','OrigPhone',COUNT(__d10(__NL(Orig_Phone_))),COUNT(__d10(__NN(Orig_Phone_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','OrigCarrierName',COUNT(__d10(__NL(Orig_Carrier_Name_))),COUNT(__d10(__NN(Orig_Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','RecType',COUNT(__d10(__NL(Rec_Type_))),COUNT(__d10(__NN(Rec_Type_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','ErrStat',COUNT(__d10(__NL(Err_Stat_))),COUNT(__d10(__NN(Err_Stat_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','Rawaid',COUNT(__d10(__NL(Rawaid_))),COUNT(__d10(__NN(Rawaid_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','Cleanaid',COUNT(__d10(__NL(Cleanaid_))),COUNT(__d10(__NN(Cleanaid_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','CurrentRec',COUNT(__d10(__NL(Current_Rec_))),COUNT(__d10(__NN(Current_Rec_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','FirstBuildDate',COUNT(__d10(__NL(First_Build_Date_))),COUNT(__d10(__NN(First_Build_Date_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','LastBuildDate',COUNT(__d10(__NL(Last_Build_Date_))),COUNT(__d10(__NN(Last_Build_Date_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','IngestTPE',COUNT(__d10(__NL(Ingest_T_P_E_))),COUNT(__d10(__NN(Ingest_T_P_E_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','Verified',COUNT(__d10(__NL(Verified_))),COUNT(__d10(__NN(Verified_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','CordCutter',COUNT(__d10(__NL(Cord_Cutter_))),COUNT(__d10(__NN(Cord_Cutter_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','ActivityStatus',COUNT(__d10(__NL(Activity_Status_))),COUNT(__d10(__NN(Activity_Status_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','Prepaid',COUNT(__d10(__NL(Prepaid_))),COUNT(__d10(__NN(Prepaid_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','GlobalSID',COUNT(__d10(__NL(Global_S_I_D_))),COUNT(__d10(__NN(Global_S_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','src',COUNT(__d10(__NL(Source_))),COUNT(__d10(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','OriginalSource',COUNT(__d10(__NL(Original_Source_))),COUNT(__d10(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','Archive_Date',COUNT(__d10(Archive___Date_=0)),COUNT(__d10(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','DateFirstSeen',COUNT(__d10(Date_First_Seen_=0)),COUNT(__d10(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','DateLastSeen',COUNT(__d10(Date_Last_Seen_=0)),COUNT(__d10(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','HybridArchiveDate',COUNT(__d10(Hybrid_Archive_Date_=0)),COUNT(__d10(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Gong__Key_History_Phone_Vault','VaultDateLastSeen',COUNT(__d10(Vault_Date_Last_Seen_=0)),COUNT(__d10(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','UID',COUNT(PublicRecords_KEL_Files_FCRA_Targus__Key_Targus_Phone_Vault_Invalid),COUNT(__d11)},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','phone_number',COUNT(__d11(__NL(Phone10_))),COUNT(__d11(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','ListingType',COUNT(__d11(__NL(Listing_Type_))),COUNT(__d11(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','PublishCode',COUNT(__d11(__NL(Publish_Code_))),COUNT(__d11(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','PortabilityIndicator',COUNT(__d11(__NL(Portability_Indicator_))),COUNT(__d11(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','NXXType',COUNT(__d11(__NL(N_X_X_Type_))),COUNT(__d11(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','COCType',COUNT(__d11(__NL(C_O_C_Type_))),COUNT(__d11(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','SCC',COUNT(__d11(__NL(S_C_C_))),COUNT(__d11(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','PortedMatch',COUNT(__d11(__NL(Ported_Match_))),COUNT(__d11(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','PhoneUse',COUNT(__d11(__NL(Phone_Use_))),COUNT(__d11(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','PhoneNumberCompanyType',COUNT(__d11(__NL(Phone_Number_Company_Type_))),COUNT(__d11(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','PriorAreaCode',COUNT(__d11(__NL(Prior_Area_Code_))),COUNT(__d11(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','IsActive',COUNT(__d11(__NL(Is_Active_))),COUNT(__d11(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','CarrierName',COUNT(__d11(__NL(Carrier_Name_))),COUNT(__d11(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','ConfidenceScore',COUNT(__d11(__NL(Confidence_Score_))),COUNT(__d11(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','NoSolicitCode',COUNT(__d11(__NL(No_Solicit_Code_))),COUNT(__d11(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','MaximumConfidenceScore',COUNT(__d11(__NL(Maximum_Confidence_Score_))),COUNT(__d11(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','MinimumConfidenceScore',COUNT(__d11(__NL(Minimum_Confidence_Score_))),COUNT(__d11(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','OmitIndicator',COUNT(__d11(__NL(Omit_Indicator_))),COUNT(__d11(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','CurrentFlag',COUNT(__d11(__NL(Current_Flag_))),COUNT(__d11(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','BusinessFlag',COUNT(__d11(__NL(Business_Flag_))),COUNT(__d11(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','RecordType',COUNT(__d11(__NL(Record_Type_))),COUNT(__d11(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','SourceFile',COUNT(__d11(__NL(Source_File_))),COUNT(__d11(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','IverIndicator',COUNT(__d11(__NL(Iver_Indicator_))),COUNT(__d11(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','PhoneType',COUNT(__d11(__NL(Phone_Type_))),COUNT(__d11(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','validation_flag',COUNT(__d11(__NL(Validation_Flag_))),COUNT(__d11(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','ValidationDate',COUNT(__d11(__NL(Validation_Date_))),COUNT(__d11(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','HighRiskSIC',COUNT(__d11(__NL(High_Risk_S_I_C_))),COUNT(__d11(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','HighRiskNAICS',COUNT(__d11(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d11(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','RecordSID',COUNT(__d11(__NL(Record_S_I_D_))),COUNT(__d11(__NN(Record_S_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','HouseholdFlag',COUNT(__d11(__NL(Household_Flag_))),COUNT(__d11(__NN(Household_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','CellPhone',COUNT(__d11(__NL(Cell_Phone_))),COUNT(__d11(__NN(Cell_Phone_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','NPA',COUNT(__d11(__NL(N_P_A_))),COUNT(__d11(__NN(N_P_A_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','Phone7',COUNT(__d11(__NL(Phone7_))),COUNT(__d11(__NN(Phone7_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','DID',COUNT(__d11(__NL(D_I_D_))),COUNT(__d11(__NN(D_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','DIDScore',COUNT(__d11(__NL(D_I_D_Score_))),COUNT(__d11(__NN(D_I_D_Score_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','PhoneDateFirstSeen',COUNT(__d11(__NL(Phone_Date_First_Seen_))),COUNT(__d11(__NN(Phone_Date_First_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','PhoneDateLastSeen',COUNT(__d11(__NL(Phone_Date_Last_Seen_))),COUNT(__d11(__NN(Phone_Date_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','PhoneDateVendorFirstReported',COUNT(__d11(__NL(Phone_Date_Vendor_First_Reported_))),COUNT(__d11(__NN(Phone_Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','PhoneDateVendorLastReported',COUNT(__d11(__NL(Phone_Date_Vendor_Last_Reported_))),COUNT(__d11(__NN(Phone_Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','DTNonGLBLastSeen',COUNT(__d11(__NL(D_T_Non_G_L_B_Last_Seen_))),COUNT(__d11(__NN(D_T_Non_G_L_B_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','GLBDPPAFlag',COUNT(__d11(__NL(G_L_B_D_P_P_A_Flag_))),COUNT(__d11(__NN(G_L_B_D_P_P_A_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','DIDType',COUNT(__d11(__NL(D_I_D_Type_))),COUNT(__d11(__NN(D_I_D_Type_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','OrigPhone',COUNT(__d11(__NL(Orig_Phone_))),COUNT(__d11(__NN(Orig_Phone_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','OrigCarrierName',COUNT(__d11(__NL(Orig_Carrier_Name_))),COUNT(__d11(__NN(Orig_Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','RecType',COUNT(__d11(__NL(Rec_Type_))),COUNT(__d11(__NN(Rec_Type_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','ErrStat',COUNT(__d11(__NL(Err_Stat_))),COUNT(__d11(__NN(Err_Stat_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','Rawaid',COUNT(__d11(__NL(Rawaid_))),COUNT(__d11(__NN(Rawaid_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','Cleanaid',COUNT(__d11(__NL(Cleanaid_))),COUNT(__d11(__NN(Cleanaid_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','CurrentRec',COUNT(__d11(__NL(Current_Rec_))),COUNT(__d11(__NN(Current_Rec_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','FirstBuildDate',COUNT(__d11(__NL(First_Build_Date_))),COUNT(__d11(__NN(First_Build_Date_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','LastBuildDate',COUNT(__d11(__NL(Last_Build_Date_))),COUNT(__d11(__NN(Last_Build_Date_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','IngestTPE',COUNT(__d11(__NL(Ingest_T_P_E_))),COUNT(__d11(__NN(Ingest_T_P_E_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','Verified',COUNT(__d11(__NL(Verified_))),COUNT(__d11(__NN(Verified_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','CordCutter',COUNT(__d11(__NL(Cord_Cutter_))),COUNT(__d11(__NN(Cord_Cutter_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','ActivityStatus',COUNT(__d11(__NL(Activity_Status_))),COUNT(__d11(__NN(Activity_Status_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','Prepaid',COUNT(__d11(__NL(Prepaid_))),COUNT(__d11(__NN(Prepaid_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','GlobalSID',COUNT(__d11(__NL(Global_S_I_D_))),COUNT(__d11(__NN(Global_S_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','src',COUNT(__d11(__NL(Source_))),COUNT(__d11(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','OriginalSource',COUNT(__d11(__NL(Original_Source_))),COUNT(__d11(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','Archive_Date',COUNT(__d11(Archive___Date_=0)),COUNT(__d11(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','DateFirstSeen',COUNT(__d11(Date_First_Seen_=0)),COUNT(__d11(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','DateLastSeen',COUNT(__d11(Date_Last_Seen_=0)),COUNT(__d11(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','HybridArchiveDate',COUNT(__d11(Hybrid_Archive_Date_=0)),COUNT(__d11(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.Files.FCRA.Targus__Key_Targus_Phone_Vault','VaultDateLastSeen',COUNT(__d11(Vault_Date_Last_Seen_=0)),COUNT(__d11(Vault_Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','UID',COUNT(PublicRecords_KEL_Files_FCRA_InfutorCID__Key_Infutor_Phone_Vault_Invalid),COUNT(__d12)},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','phone',COUNT(__d12(__NL(Phone10_))),COUNT(__d12(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','ListingType',COUNT(__d12(__NL(Listing_Type_))),COUNT(__d12(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','PublishCode',COUNT(__d12(__NL(Publish_Code_))),COUNT(__d12(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','PortabilityIndicator',COUNT(__d12(__NL(Portability_Indicator_))),COUNT(__d12(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','NXXType',COUNT(__d12(__NL(N_X_X_Type_))),COUNT(__d12(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','COCType',COUNT(__d12(__NL(C_O_C_Type_))),COUNT(__d12(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','SCC',COUNT(__d12(__NL(S_C_C_))),COUNT(__d12(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','PortedMatch',COUNT(__d12(__NL(Ported_Match_))),COUNT(__d12(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','PhoneUse',COUNT(__d12(__NL(Phone_Use_))),COUNT(__d12(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','PhoneNumberCompanyType',COUNT(__d12(__NL(Phone_Number_Company_Type_))),COUNT(__d12(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','PriorAreaCode',COUNT(__d12(__NL(Prior_Area_Code_))),COUNT(__d12(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','IsActive',COUNT(__d12(__NL(Is_Active_))),COUNT(__d12(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','CarrierName',COUNT(__d12(__NL(Carrier_Name_))),COUNT(__d12(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','ConfidenceScore',COUNT(__d12(__NL(Confidence_Score_))),COUNT(__d12(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','NoSolicitCode',COUNT(__d12(__NL(No_Solicit_Code_))),COUNT(__d12(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','MaximumConfidenceScore',COUNT(__d12(__NL(Maximum_Confidence_Score_))),COUNT(__d12(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','MinimumConfidenceScore',COUNT(__d12(__NL(Minimum_Confidence_Score_))),COUNT(__d12(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','OmitIndicator',COUNT(__d12(__NL(Omit_Indicator_))),COUNT(__d12(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','CurrentFlag',COUNT(__d12(__NL(Current_Flag_))),COUNT(__d12(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','BusinessFlag',COUNT(__d12(__NL(Business_Flag_))),COUNT(__d12(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','rec_type',COUNT(__d12(__NL(Record_Type_))),COUNT(__d12(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','SourceFile',COUNT(__d12(__NL(Source_File_))),COUNT(__d12(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','IverIndicator',COUNT(__d12(__NL(Iver_Indicator_))),COUNT(__d12(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','PhoneType',COUNT(__d12(__NL(Phone_Type_))),COUNT(__d12(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','ValidationFlag',COUNT(__d12(__NL(Validation_Flag_))),COUNT(__d12(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','ValidationDate',COUNT(__d12(__NL(Validation_Date_))),COUNT(__d12(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','HighRiskSIC',COUNT(__d12(__NL(High_Risk_S_I_C_))),COUNT(__d12(__NN(High_Risk_S_I_C_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','HighRiskNAICS',COUNT(__d12(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d12(__NN(High_Risk_N_A_I_C_S_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','RecordSID',COUNT(__d12(__NL(Record_S_I_D_))),COUNT(__d12(__NN(Record_S_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','HouseholdFlag',COUNT(__d12(__NL(Household_Flag_))),COUNT(__d12(__NN(Household_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','CellPhone',COUNT(__d12(__NL(Cell_Phone_))),COUNT(__d12(__NN(Cell_Phone_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','NPA',COUNT(__d12(__NL(N_P_A_))),COUNT(__d12(__NN(N_P_A_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','Phone7',COUNT(__d12(__NL(Phone7_))),COUNT(__d12(__NN(Phone7_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','DID',COUNT(__d12(__NL(D_I_D_))),COUNT(__d12(__NN(D_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','DIDScore',COUNT(__d12(__NL(D_I_D_Score_))),COUNT(__d12(__NN(D_I_D_Score_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','PhoneDateFirstSeen',COUNT(__d12(__NL(Phone_Date_First_Seen_))),COUNT(__d12(__NN(Phone_Date_First_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','PhoneDateLastSeen',COUNT(__d12(__NL(Phone_Date_Last_Seen_))),COUNT(__d12(__NN(Phone_Date_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','PhoneDateVendorFirstReported',COUNT(__d12(__NL(Phone_Date_Vendor_First_Reported_))),COUNT(__d12(__NN(Phone_Date_Vendor_First_Reported_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','PhoneDateVendorLastReported',COUNT(__d12(__NL(Phone_Date_Vendor_Last_Reported_))),COUNT(__d12(__NN(Phone_Date_Vendor_Last_Reported_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','DTNonGLBLastSeen',COUNT(__d12(__NL(D_T_Non_G_L_B_Last_Seen_))),COUNT(__d12(__NN(D_T_Non_G_L_B_Last_Seen_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','GLBDPPAFlag',COUNT(__d12(__NL(G_L_B_D_P_P_A_Flag_))),COUNT(__d12(__NN(G_L_B_D_P_P_A_Flag_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','DIDType',COUNT(__d12(__NL(D_I_D_Type_))),COUNT(__d12(__NN(D_I_D_Type_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','OrigPhone',COUNT(__d12(__NL(Orig_Phone_))),COUNT(__d12(__NN(Orig_Phone_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','OrigCarrierName',COUNT(__d12(__NL(Orig_Carrier_Name_))),COUNT(__d12(__NN(Orig_Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','RecType',COUNT(__d12(__NL(Rec_Type_))),COUNT(__d12(__NN(Rec_Type_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','ErrStat',COUNT(__d12(__NL(Err_Stat_))),COUNT(__d12(__NN(Err_Stat_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','Rawaid',COUNT(__d12(__NL(Rawaid_))),COUNT(__d12(__NN(Rawaid_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','Cleanaid',COUNT(__d12(__NL(Cleanaid_))),COUNT(__d12(__NN(Cleanaid_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','CurrentRec',COUNT(__d12(__NL(Current_Rec_))),COUNT(__d12(__NN(Current_Rec_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','FirstBuildDate',COUNT(__d12(__NL(First_Build_Date_))),COUNT(__d12(__NN(First_Build_Date_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','LastBuildDate',COUNT(__d12(__NL(Last_Build_Date_))),COUNT(__d12(__NN(Last_Build_Date_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','IngestTPE',COUNT(__d12(__NL(Ingest_T_P_E_))),COUNT(__d12(__NN(Ingest_T_P_E_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','Verified',COUNT(__d12(__NL(Verified_))),COUNT(__d12(__NN(Verified_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','CordCutter',COUNT(__d12(__NL(Cord_Cutter_))),COUNT(__d12(__NN(Cord_Cutter_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','ActivityStatus',COUNT(__d12(__NL(Activity_Status_))),COUNT(__d12(__NN(Activity_Status_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','Prepaid',COUNT(__d12(__NL(Prepaid_))),COUNT(__d12(__NN(Prepaid_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','GlobalSID',COUNT(__d12(__NL(Global_S_I_D_))),COUNT(__d12(__NN(Global_S_I_D_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','src',COUNT(__d12(__NL(Source_))),COUNT(__d12(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','OriginalSource',COUNT(__d12(__NL(Original_Source_))),COUNT(__d12(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','Archive_Date',COUNT(__d12(Archive___Date_=0)),COUNT(__d12(Archive___Date_!=0))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','DateFirstSeen',COUNT(__d12(Date_First_Seen_=0)),COUNT(__d12(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','DateLastSeen',COUNT(__d12(Date_Last_Seen_=0)),COUNT(__d12(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','HybridArchiveDate',COUNT(__d12(Hybrid_Archive_Date_=0)),COUNT(__d12(Hybrid_Archive_Date_!=0))},
    {'Phone','PublicRecords_KEL.Files.FCRA.InfutorCID__Key_Infutor_Phone_Vault','VaultDateLastSeen',COUNT(__d12(Vault_Date_Last_Seen_=0)),COUNT(__d12(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
