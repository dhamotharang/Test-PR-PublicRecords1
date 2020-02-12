﻿//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_Address(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
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
    KEL.typ.nint Z_I_P4_;
    KEL.typ.nint Append_Raw_A_I_D_;
    KEL.typ.nstr Carrier_Route_Number_;
    KEL.typ.nstr Carrier_Route_Sortation_At_Z_I_P_;
    KEL.typ.nint Line_Of_Travel_;
    KEL.typ.nstr Line_Of_Travel_Order_;
    KEL.typ.nint Delivery_Point_Barcode_;
    KEL.typ.nint Delivery_Point_Barcode_Check_Digit_;
    KEL.typ.nstr Type_Code_;
    KEL.typ.nint County_;
    KEL.typ.nfloat Latitude_;
    KEL.typ.nfloat Longitude_;
    KEL.typ.nint Metropolitan_Statistical_Area_;
    KEL.typ.nint Geo_Block_;
    KEL.typ.nstr Geo_Match_;
    KEL.typ.nstr A_C_E_Cleaner_Error_Code_;
    KEL.typ.nkdate A_D_V_O_Date_First_Seen_;
    KEL.typ.nkdate A_D_V_O_Date_Last_Seen_;
    KEL.typ.nkdate A_D_V_O_Date_Vendor_First_Reported_;
    KEL.typ.nkdate A_D_V_O_Date_Vendor_Last_Reported_;
    KEL.typ.nstr Vacancy_Indicator_;
    KEL.typ.nstr Throw_Back_Indicator_;
    KEL.typ.nstr Seasonal_Delivery_Indicator_;
    KEL.typ.nstr Seasonal_Start_Suppression_Date_;
    KEL.typ.nstr Seasonal_End_Suppression_Date_;
    KEL.typ.nstr Do_Not_Deliver_Indicator_;
    KEL.typ.nstr Do_Not_Mail_Indicator_;
    KEL.typ.nstr Dead_C_O_Indicator_;
    KEL.typ.nstr Hot_List_Indicator_;
    KEL.typ.nstr College_Indicator_;
    KEL.typ.nstr College_Start_Suppression_Date_;
    KEL.typ.nstr College_End_Suppression_Date_;
    KEL.typ.nstr Style_Code_;
    KEL.typ.nint Simplify_Count_;
    KEL.typ.nstr Drop_Indicator_;
    KEL.typ.nstr Residential_Or_Business_Indicator_;
    KEL.typ.nstr Only_Way_To_Get_Mail_Indicator_;
    KEL.typ.nstr Record_Type_Code_;
    KEL.typ.nstr Address_Type_Code_;
    KEL.typ.nstr Mixed_Usage_Code_;
    KEL.typ.nkdate Vacation_Begin_Date_;
    KEL.typ.nkdate Vacation_End_Date_;
    KEL.typ.nint Number_Of_Current_Vacation_Months_;
    KEL.typ.nint Max_Vacation_Months_;
    KEL.typ.nint Vacation_Periods_Count_;
    KEL.typ.nstr Company_Address_Type_Raw_;
    KEL.typ.nstr Company_Address_Type_Derived_;
    KEL.typ.nstr Address_Type_Derived_;
    KEL.typ.nstr Address_Method_;
    KEL.typ.nstr Is_Active_;
    KEL.typ.nstr Is_Defunct_;
    KEL.typ.nstr Address___Type_;
    KEL.typ.nstr Address___Desc_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool F_D_N_Indicator_;
    KEL.typ.nint High_Risk_S_I_C_;
    KEL.typ.nint High_Risk_N_A_I_C_S_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(DEFAULT:UID),primaryrange(DEFAULT:Primary_Range_),predirectional(DEFAULT:Predirectional_),primaryname(DEFAULT:Primary_Name_),suffix(DEFAULT:Suffix_),postdirectional(DEFAULT:Postdirectional_),unitdesignation(DEFAULT:Unit_Designation_),secondaryrange(DEFAULT:Secondary_Range_),postalcity(DEFAULT:Postal_City_),vanitycity(DEFAULT:Vanity_City_),state(DEFAULT:State_),zip5(DEFAULT:Z_I_P5_:0),zip4(DEFAULT:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),carrierroutenumber(DEFAULT:Carrier_Route_Number_),carrierroutesortationatzip(DEFAULT:Carrier_Route_Sortation_At_Z_I_P_),lineoftravel(DEFAULT:Line_Of_Travel_),lineoftravelorder(DEFAULT:Line_Of_Travel_Order_),deliverypointbarcode(DEFAULT:Delivery_Point_Barcode_),deliverypointbarcodecheckdigit(DEFAULT:Delivery_Point_Barcode_Check_Digit_),typecode(DEFAULT:Type_Code_),county(DEFAULT:County_),latitude(DEFAULT:Latitude_),longitude(DEFAULT:Longitude_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),geoblock(DEFAULT:Geo_Block_),geomatch(DEFAULT:Geo_Match_),acecleanererrorcode(DEFAULT:A_C_E_Cleaner_Error_Code_),advodatefirstseen(DEFAULT:A_D_V_O_Date_First_Seen_:DATE),advodatelastseen(DEFAULT:A_D_V_O_Date_Last_Seen_:DATE),advodatevendorfirstreported(DEFAULT:A_D_V_O_Date_Vendor_First_Reported_:DATE),advodatevendorlastreported(DEFAULT:A_D_V_O_Date_Vendor_Last_Reported_:DATE),vacancyindicator(DEFAULT:Vacancy_Indicator_),throwbackindicator(DEFAULT:Throw_Back_Indicator_),seasonaldeliveryindicator(DEFAULT:Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(DEFAULT:Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(DEFAULT:Seasonal_End_Suppression_Date_),donotdeliverindicator(DEFAULT:Do_Not_Deliver_Indicator_),donotmailindicator(DEFAULT:Do_Not_Mail_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),hotlistindicator(DEFAULT:Hot_List_Indicator_),collegeindicator(DEFAULT:College_Indicator_),collegestartsuppressiondate(DEFAULT:College_Start_Suppression_Date_),collegeendsuppressiondate(DEFAULT:College_End_Suppression_Date_),stylecode(DEFAULT:Style_Code_),simplifycount(DEFAULT:Simplify_Count_),dropindicator(DEFAULT:Drop_Indicator_),residentialorbusinessindicator(DEFAULT:Residential_Or_Business_Indicator_),onlywaytogetmailindicator(DEFAULT:Only_Way_To_Get_Mail_Indicator_),recordtypecode(DEFAULT:Record_Type_Code_),addresstypecode(DEFAULT:Address_Type_Code_),mixedusagecode(DEFAULT:Mixed_Usage_Code_),vacationbegindate(DEFAULT:Vacation_Begin_Date_:DATE),vacationenddate(DEFAULT:Vacation_End_Date_:DATE),numberofcurrentvacationmonths(DEFAULT:Number_Of_Current_Vacation_Months_),maxvacationmonths(DEFAULT:Max_Vacation_Months_),vacationperiodscount(DEFAULT:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),address_type(DEFAULT:Address___Type_:\'\'),address_desc(DEFAULT:Address___Desc_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),fdnindicator(DEFAULT:F_D_N_Indicator_),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := __in.Dataset_ADVO__Key_Addr1((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0);
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  SHARED __d1_KELfiltered := __in.Dataset_ADVO__Key_Addr1_History((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0);
  SHARED __d1_Trim := PROJECT(__d1_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  SHARED __d2_KELfiltered := __in.Dataset_DMA__Key_DNM_Name_Address((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0);
  SHARED __d2_Trim := PROJECT(__d2_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  SHARED __d3_KELfiltered := __in.Dataset_Fraudpoint3__Key_Address((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0);
  SHARED __d3_Trim := PROJECT(__d3_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  SHARED __d4_KELfiltered := __in.Dataset_USPIS_HotList__key_addr_search_zip((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0);
  SHARED __d4_Trim := PROJECT(__d4_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  SHARED __d5_KELfiltered := __in.Dataset_Doxie__Key_Header_Address((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0);
  SHARED __d5_Trim := PROJECT(__d5_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim + __d2_Trim + __d3_Trim + __d4_Trim + __d5_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  SHARED __Table := TABLE(__All_Trim,__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  EXPORT Lookup := PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED __Mapping0 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_),predir(OVERRIDE:Predirectional_),prim_name(OVERRIDE:Primary_Name_),addr_suffix(OVERRIDE:Suffix_),postdir(OVERRIDE:Postdirectional_),unit_desig(OVERRIDE:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_),p_city_name(OVERRIDE:Postal_City_),v_city_name(OVERRIDE:Vanity_City_),st(OVERRIDE:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(OVERRIDE:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),cart(OVERRIDE:Carrier_Route_Number_),cr_sort_sz(OVERRIDE:Carrier_Route_Sortation_At_Z_I_P_),lot(OVERRIDE:Line_Of_Travel_),lot_order(OVERRIDE:Line_Of_Travel_Order_),dbpc(OVERRIDE:Delivery_Point_Barcode_),chk_digit(OVERRIDE:Delivery_Point_Barcode_Check_Digit_),rec_type(OVERRIDE:Type_Code_),county(OVERRIDE:County_),geo_lat(OVERRIDE:Latitude_),geo_long(OVERRIDE:Longitude_),msa(OVERRIDE:Metropolitan_Statistical_Area_),geo_blk(OVERRIDE:Geo_Block_),geo_match(OVERRIDE:Geo_Match_),err_stat(OVERRIDE:A_C_E_Cleaner_Error_Code_),date_first_seen(OVERRIDE:A_D_V_O_Date_First_Seen_:DATE|OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:A_D_V_O_Date_Last_Seen_:DATE|OVERRIDE:Date_Last_Seen_:EPOCH),date_vendor_first_reported(OVERRIDE:A_D_V_O_Date_Vendor_First_Reported_:DATE|OVERRIDE:Date_Vendor_First_Reported_:EPOCH),date_vendor_last_reported(OVERRIDE:A_D_V_O_Date_Vendor_Last_Reported_:DATE|OVERRIDE:Date_Vendor_Last_Reported_:EPOCH),address_vacancy_indicator(OVERRIDE:Vacancy_Indicator_),throw_back_indicator(OVERRIDE:Throw_Back_Indicator_),seasonal_delivery_indicator(OVERRIDE:Seasonal_Delivery_Indicator_),seasonal_start_suppression_date(OVERRIDE:Seasonal_Start_Suppression_Date_),seasonal_end_suppression_date(OVERRIDE:Seasonal_End_Suppression_Date_),dnd_indicator(OVERRIDE:Do_Not_Deliver_Indicator_),donotmailindicator(DEFAULT:Do_Not_Mail_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),hotlistindicator(DEFAULT:Hot_List_Indicator_),college_indicator(OVERRIDE:College_Indicator_),college_start_suppression_date(OVERRIDE:College_Start_Suppression_Date_),college_end_suppression_date(OVERRIDE:College_End_Suppression_Date_),address_style_flag(OVERRIDE:Style_Code_),simplify_address_count(OVERRIDE:Simplify_Count_),drop_indicator(OVERRIDE:Drop_Indicator_),residential_or_business_ind(OVERRIDE:Residential_Or_Business_Indicator_),owgm_indicator(OVERRIDE:Only_Way_To_Get_Mail_Indicator_),record_type_code(OVERRIDE:Record_Type_Code_),address_type(OVERRIDE:Address_Type_Code_|DEFAULT:Address___Type_:\'\'),mixed_address_usage(OVERRIDE:Mixed_Usage_Code_),vac_begdt(OVERRIDE:Vacation_Begin_Date_:DATE),vac_enddt(OVERRIDE:Vacation_End_Date_:DATE),months_vac_curr(OVERRIDE:Number_Of_Current_Vacation_Months_),months_vac_max(OVERRIDE:Max_Vacation_Months_),vac_count(OVERRIDE:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),address_desc(DEFAULT:Address___Desc_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),fdnindicator(DEFAULT:F_D_N_Indicator_),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),src(OVERRIDE:Source_:\'\'),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_ADVO__Key_Addr1,TRANSFORM(RECORDOF(__in.Dataset_ADVO__Key_Addr1),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_ADVO__Key_Addr1);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_ADVO__Key_Addr1_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping1 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_),predir(OVERRIDE:Predirectional_),prim_name(OVERRIDE:Primary_Name_),addr_suffix(OVERRIDE:Suffix_),postdir(OVERRIDE:Postdirectional_),unit_desig(OVERRIDE:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_),p_city_name(OVERRIDE:Postal_City_),v_city_name(OVERRIDE:Vanity_City_),st(OVERRIDE:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(OVERRIDE:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),cart(OVERRIDE:Carrier_Route_Number_),cr_sort_sz(OVERRIDE:Carrier_Route_Sortation_At_Z_I_P_),lot(OVERRIDE:Line_Of_Travel_),lot_order(OVERRIDE:Line_Of_Travel_Order_),dbpc(OVERRIDE:Delivery_Point_Barcode_),chk_digit(OVERRIDE:Delivery_Point_Barcode_Check_Digit_),rec_type(OVERRIDE:Type_Code_),county(OVERRIDE:County_),geo_lat(OVERRIDE:Latitude_),geo_long(OVERRIDE:Longitude_),msa(OVERRIDE:Metropolitan_Statistical_Area_),geo_blk(OVERRIDE:Geo_Block_),geo_match(OVERRIDE:Geo_Match_),err_stat(OVERRIDE:A_C_E_Cleaner_Error_Code_),date_first_seen(OVERRIDE:A_D_V_O_Date_First_Seen_:DATE|OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:A_D_V_O_Date_Last_Seen_:DATE|OVERRIDE:Date_Last_Seen_:EPOCH),date_vendor_first_reported(OVERRIDE:A_D_V_O_Date_Vendor_First_Reported_:DATE|OVERRIDE:Date_Vendor_First_Reported_:EPOCH),date_vendor_last_reported(OVERRIDE:A_D_V_O_Date_Vendor_Last_Reported_:DATE|OVERRIDE:Date_Vendor_Last_Reported_:EPOCH),address_vacancy_indicator(OVERRIDE:Vacancy_Indicator_),throw_back_indicator(OVERRIDE:Throw_Back_Indicator_),seasonal_delivery_indicator(OVERRIDE:Seasonal_Delivery_Indicator_),seasonal_start_suppression_date(OVERRIDE:Seasonal_Start_Suppression_Date_),seasonal_end_suppression_date(OVERRIDE:Seasonal_End_Suppression_Date_),dnd_indicator(OVERRIDE:Do_Not_Deliver_Indicator_),donotmailindicator(DEFAULT:Do_Not_Mail_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),hotlistindicator(DEFAULT:Hot_List_Indicator_),college_indicator(OVERRIDE:College_Indicator_),college_start_suppression_date(OVERRIDE:College_Start_Suppression_Date_),college_end_suppression_date(OVERRIDE:College_End_Suppression_Date_),address_style_flag(OVERRIDE:Style_Code_),simplify_address_count(OVERRIDE:Simplify_Count_),drop_indicator(OVERRIDE:Drop_Indicator_),residential_or_business_ind(OVERRIDE:Residential_Or_Business_Indicator_),owgm_indicator(OVERRIDE:Only_Way_To_Get_Mail_Indicator_),record_type_code(OVERRIDE:Record_Type_Code_),address_type(OVERRIDE:Address_Type_Code_|DEFAULT:Address___Type_:\'\'),mixed_address_usage(OVERRIDE:Mixed_Usage_Code_),vac_begdt(OVERRIDE:Vacation_Begin_Date_:DATE),vac_enddt(OVERRIDE:Vacation_End_Date_:DATE),months_vac_curr(OVERRIDE:Number_Of_Current_Vacation_Months_),months_vac_max(OVERRIDE:Max_Vacation_Months_),vac_count(OVERRIDE:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),address_desc(DEFAULT:Address___Desc_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),fdnindicator(DEFAULT:F_D_N_Indicator_),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),src(OVERRIDE:Source_:\'\'),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_ADVO__Key_Addr1_History,TRANSFORM(RECORDOF(__in.Dataset_ADVO__Key_Addr1_History),SELF:=RIGHT));
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_ADVO__Key_Addr1_History);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_ADVO__Key_Addr1_History_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping2 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_),predir(OVERRIDE:Predirectional_),prim_name(OVERRIDE:Primary_Name_),addr_suffix(OVERRIDE:Suffix_),postdir(OVERRIDE:Postdirectional_),unit_desig(OVERRIDE:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_),p_city_name(OVERRIDE:Postal_City_),v_city_name(OVERRIDE:Vanity_City_),st(OVERRIDE:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(OVERRIDE:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),carrierroutenumber(DEFAULT:Carrier_Route_Number_),carrierroutesortationatzip(DEFAULT:Carrier_Route_Sortation_At_Z_I_P_),lineoftravel(DEFAULT:Line_Of_Travel_),lineoftravelorder(DEFAULT:Line_Of_Travel_Order_),deliverypointbarcode(DEFAULT:Delivery_Point_Barcode_),deliverypointbarcodecheckdigit(DEFAULT:Delivery_Point_Barcode_Check_Digit_),typecode(DEFAULT:Type_Code_),county(DEFAULT:County_),latitude(DEFAULT:Latitude_),longitude(DEFAULT:Longitude_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),geoblock(DEFAULT:Geo_Block_),geomatch(DEFAULT:Geo_Match_),acecleanererrorcode(DEFAULT:A_C_E_Cleaner_Error_Code_),advodatefirstseen(DEFAULT:A_D_V_O_Date_First_Seen_:DATE),advodatelastseen(DEFAULT:A_D_V_O_Date_Last_Seen_:DATE),advodatevendorfirstreported(DEFAULT:A_D_V_O_Date_Vendor_First_Reported_:DATE),advodatevendorlastreported(DEFAULT:A_D_V_O_Date_Vendor_Last_Reported_:DATE),vacancyindicator(DEFAULT:Vacancy_Indicator_),throwbackindicator(DEFAULT:Throw_Back_Indicator_),seasonaldeliveryindicator(DEFAULT:Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(DEFAULT:Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(DEFAULT:Seasonal_End_Suppression_Date_),donotdeliverindicator(DEFAULT:Do_Not_Deliver_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),hotlistindicator(DEFAULT:Hot_List_Indicator_),collegeindicator(DEFAULT:College_Indicator_),collegestartsuppressiondate(DEFAULT:College_Start_Suppression_Date_),collegeendsuppressiondate(DEFAULT:College_End_Suppression_Date_),stylecode(DEFAULT:Style_Code_),simplifycount(DEFAULT:Simplify_Count_),dropindicator(DEFAULT:Drop_Indicator_),residentialorbusinessindicator(DEFAULT:Residential_Or_Business_Indicator_),onlywaytogetmailindicator(DEFAULT:Only_Way_To_Get_Mail_Indicator_),recordtypecode(DEFAULT:Record_Type_Code_),addresstypecode(DEFAULT:Address_Type_Code_),mixedusagecode(DEFAULT:Mixed_Usage_Code_),vacationbegindate(DEFAULT:Vacation_Begin_Date_:DATE),vacationenddate(DEFAULT:Vacation_End_Date_:DATE),numberofcurrentvacationmonths(DEFAULT:Number_Of_Current_Vacation_Months_),maxvacationmonths(DEFAULT:Max_Vacation_Months_),vacationperiodscount(DEFAULT:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),address_type(DEFAULT:Address___Type_:\'\'),address_desc(DEFAULT:Address___Desc_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),fdnindicator(DEFAULT:F_D_N_Indicator_),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping2_Transform(InLayout __r) := TRANSFORM
    SELF.Do_Not_Mail_Indicator_ := __CN('Y');
    SELF := __r;
  END;
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_DMA__Key_DNM_Name_Address,TRANSFORM(RECORDOF(__in.Dataset_DMA__Key_DNM_Name_Address),SELF:=RIGHT));
  SHARED __d2_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_DMA__Key_DNM_Name_Address);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d2_UID_Mapped := JOIN(__d2_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d2_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DMA__Key_DNM_Name_Address_Invalid := __d2_UID_Mapped(UID = 0);
  SHARED __d2_Prefiltered := __d2_UID_Mapped(UID <> 0);
  SHARED __d2 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping2_Transform(LEFT)));
  SHARED __Mapping3 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_),predir(OVERRIDE:Predirectional_),prim_name(OVERRIDE:Primary_Name_),addr_suffix(OVERRIDE:Suffix_),postdir(OVERRIDE:Postdirectional_),unit_desig(OVERRIDE:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_),p_city_name(OVERRIDE:Postal_City_),v_city_name(OVERRIDE:Vanity_City_),st(OVERRIDE:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(OVERRIDE:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),carrierroutenumber(DEFAULT:Carrier_Route_Number_),carrierroutesortationatzip(DEFAULT:Carrier_Route_Sortation_At_Z_I_P_),lineoftravel(DEFAULT:Line_Of_Travel_),lineoftravelorder(DEFAULT:Line_Of_Travel_Order_),deliverypointbarcode(DEFAULT:Delivery_Point_Barcode_),deliverypointbarcodecheckdigit(DEFAULT:Delivery_Point_Barcode_Check_Digit_),typecode(DEFAULT:Type_Code_),county(DEFAULT:County_),geo_lat(OVERRIDE:Latitude_),geo_long(OVERRIDE:Longitude_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),geo_blk(OVERRIDE:Geo_Block_),geomatch(DEFAULT:Geo_Match_),acecleanererrorcode(DEFAULT:A_C_E_Cleaner_Error_Code_),advodatefirstseen(DEFAULT:A_D_V_O_Date_First_Seen_:DATE),advodatelastseen(DEFAULT:A_D_V_O_Date_Last_Seen_:DATE),advodatevendorfirstreported(DEFAULT:A_D_V_O_Date_Vendor_First_Reported_:DATE),advodatevendorlastreported(DEFAULT:A_D_V_O_Date_Vendor_Last_Reported_:DATE),vacancyindicator(DEFAULT:Vacancy_Indicator_),throwbackindicator(DEFAULT:Throw_Back_Indicator_),seasonaldeliveryindicator(DEFAULT:Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(DEFAULT:Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(DEFAULT:Seasonal_End_Suppression_Date_),donotdeliverindicator(DEFAULT:Do_Not_Deliver_Indicator_),donotmailindicator(DEFAULT:Do_Not_Mail_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),hotlistindicator(DEFAULT:Hot_List_Indicator_),collegeindicator(DEFAULT:College_Indicator_),collegestartsuppressiondate(DEFAULT:College_Start_Suppression_Date_),collegeendsuppressiondate(DEFAULT:College_End_Suppression_Date_),stylecode(DEFAULT:Style_Code_),simplifycount(DEFAULT:Simplify_Count_),dropindicator(DEFAULT:Drop_Indicator_),residentialorbusinessindicator(DEFAULT:Residential_Or_Business_Indicator_),onlywaytogetmailindicator(DEFAULT:Only_Way_To_Get_Mail_Indicator_),recordtypecode(DEFAULT:Record_Type_Code_),addresstypecode(DEFAULT:Address_Type_Code_),mixedusagecode(DEFAULT:Mixed_Usage_Code_),vacationbegindate(DEFAULT:Vacation_Begin_Date_:DATE),vacationenddate(DEFAULT:Vacation_End_Date_:DATE),numberofcurrentvacationmonths(DEFAULT:Number_Of_Current_Vacation_Months_),maxvacationmonths(DEFAULT:Max_Vacation_Months_),vacationperiodscount(DEFAULT:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),address_type(DEFAULT:Address___Type_:\'\'),address_desc(DEFAULT:Address___Desc_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping3_Transform(InLayout __r) := TRANSFORM
    SELF.F_D_N_Indicator_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_Fraudpoint3__Key_Address,TRANSFORM(RECORDOF(__in.Dataset_Fraudpoint3__Key_Address),SELF:=RIGHT));
  SHARED __d3_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Fraudpoint3__Key_Address);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d3_UID_Mapped := JOIN(__d3_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d3_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Fraudpoint3__Key_Address_Invalid := __d3_UID_Mapped(UID = 0);
  SHARED __d3_Prefiltered := __d3_UID_Mapped(UID <> 0);
  SHARED __d3 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping3_Transform(LEFT)));
  SHARED __Mapping4 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_),predir(OVERRIDE:Predirectional_),prim_name(OVERRIDE:Primary_Name_),addr_suffix(OVERRIDE:Suffix_),postdir(OVERRIDE:Postdirectional_),unit_desig(OVERRIDE:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_),p_city_name(OVERRIDE:Postal_City_),v_city_name(OVERRIDE:Vanity_City_),st(OVERRIDE:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(OVERRIDE:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),carrierroutenumber(DEFAULT:Carrier_Route_Number_),carrierroutesortationatzip(DEFAULT:Carrier_Route_Sortation_At_Z_I_P_),lineoftravel(DEFAULT:Line_Of_Travel_),lineoftravelorder(DEFAULT:Line_Of_Travel_Order_),deliverypointbarcode(DEFAULT:Delivery_Point_Barcode_),deliverypointbarcodecheckdigit(DEFAULT:Delivery_Point_Barcode_Check_Digit_),typecode(DEFAULT:Type_Code_),county(DEFAULT:County_),latitude(DEFAULT:Latitude_),longitude(DEFAULT:Longitude_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),geoblock(DEFAULT:Geo_Block_),geomatch(DEFAULT:Geo_Match_),acecleanererrorcode(DEFAULT:A_C_E_Cleaner_Error_Code_),advodatefirstseen(DEFAULT:A_D_V_O_Date_First_Seen_:DATE),advodatelastseen(DEFAULT:A_D_V_O_Date_Last_Seen_:DATE),advodatevendorfirstreported(DEFAULT:A_D_V_O_Date_Vendor_First_Reported_:DATE),advodatevendorlastreported(DEFAULT:A_D_V_O_Date_Vendor_Last_Reported_:DATE),vacancyindicator(DEFAULT:Vacancy_Indicator_),throwbackindicator(DEFAULT:Throw_Back_Indicator_),seasonaldeliveryindicator(DEFAULT:Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(DEFAULT:Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(DEFAULT:Seasonal_End_Suppression_Date_),donotdeliverindicator(DEFAULT:Do_Not_Deliver_Indicator_),donotmailindicator(DEFAULT:Do_Not_Mail_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),collegeindicator(DEFAULT:College_Indicator_),collegestartsuppressiondate(DEFAULT:College_Start_Suppression_Date_),collegeendsuppressiondate(DEFAULT:College_End_Suppression_Date_),stylecode(DEFAULT:Style_Code_),simplifycount(DEFAULT:Simplify_Count_),dropindicator(DEFAULT:Drop_Indicator_),residentialorbusinessindicator(DEFAULT:Residential_Or_Business_Indicator_),onlywaytogetmailindicator(DEFAULT:Only_Way_To_Get_Mail_Indicator_),recordtypecode(DEFAULT:Record_Type_Code_),addresstypecode(DEFAULT:Address_Type_Code_),mixedusagecode(DEFAULT:Mixed_Usage_Code_),vacationbegindate(DEFAULT:Vacation_Begin_Date_:DATE),vacationenddate(DEFAULT:Vacation_End_Date_:DATE),numberofcurrentvacationmonths(DEFAULT:Number_Of_Current_Vacation_Months_),maxvacationmonths(DEFAULT:Max_Vacation_Months_),vacationperiodscount(DEFAULT:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),address_type(DEFAULT:Address___Type_:\'\'),address_desc(DEFAULT:Address___Desc_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),fdnindicator(DEFAULT:F_D_N_Indicator_),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),dt_first_reported(OVERRIDE:Date_Vendor_First_Reported_:EPOCH),dt_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping4_Transform(InLayout __r) := TRANSFORM
    SELF.Hot_List_Indicator_ := __CN('Y');
    SELF := __r;
  END;
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_USPIS_HotList__key_addr_search_zip,TRANSFORM(RECORDOF(__in.Dataset_USPIS_HotList__key_addr_search_zip),SELF:=RIGHT));
  SHARED __d4_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_USPIS_HotList__key_addr_search_zip);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d4_UID_Mapped := JOIN(__d4_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d4_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_USPIS_HotList__key_addr_search_zip_Invalid := __d4_UID_Mapped(UID = 0);
  SHARED __d4_Prefiltered := __d4_UID_Mapped(UID <> 0);
  SHARED __d4 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping4_Transform(LEFT)));
  SHARED Date_First_Seen_5Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_5Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping5 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_),predir(OVERRIDE:Predirectional_),prim_name(OVERRIDE:Primary_Name_),suffix(OVERRIDE:Suffix_),postdir(OVERRIDE:Postdirectional_),unit_desig(OVERRIDE:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_),city_name(OVERRIDE:Postal_City_),vanitycity(DEFAULT:Vanity_City_),st(OVERRIDE:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(DEFAULT:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),carrierroutenumber(DEFAULT:Carrier_Route_Number_),carrierroutesortationatzip(DEFAULT:Carrier_Route_Sortation_At_Z_I_P_),lineoftravel(DEFAULT:Line_Of_Travel_),lineoftravelorder(DEFAULT:Line_Of_Travel_Order_),deliverypointbarcode(DEFAULT:Delivery_Point_Barcode_),deliverypointbarcodecheckdigit(DEFAULT:Delivery_Point_Barcode_Check_Digit_),typecode(DEFAULT:Type_Code_),county(OVERRIDE:County_),latitude(DEFAULT:Latitude_),longitude(DEFAULT:Longitude_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),geo_blk(OVERRIDE:Geo_Block_),geomatch(DEFAULT:Geo_Match_),acecleanererrorcode(DEFAULT:A_C_E_Cleaner_Error_Code_),advodatefirstseen(DEFAULT:A_D_V_O_Date_First_Seen_:DATE),advodatelastseen(DEFAULT:A_D_V_O_Date_Last_Seen_:DATE),advodatevendorfirstreported(DEFAULT:A_D_V_O_Date_Vendor_First_Reported_:DATE),advodatevendorlastreported(DEFAULT:A_D_V_O_Date_Vendor_Last_Reported_:DATE),vacancyindicator(DEFAULT:Vacancy_Indicator_),throwbackindicator(DEFAULT:Throw_Back_Indicator_),seasonaldeliveryindicator(DEFAULT:Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(DEFAULT:Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(DEFAULT:Seasonal_End_Suppression_Date_),donotdeliverindicator(DEFAULT:Do_Not_Deliver_Indicator_),donotmailindicator(DEFAULT:Do_Not_Mail_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),hotlistindicator(DEFAULT:Hot_List_Indicator_),collegeindicator(DEFAULT:College_Indicator_),collegestartsuppressiondate(DEFAULT:College_Start_Suppression_Date_),collegeendsuppressiondate(DEFAULT:College_End_Suppression_Date_),stylecode(DEFAULT:Style_Code_),simplifycount(DEFAULT:Simplify_Count_),dropindicator(DEFAULT:Drop_Indicator_),residentialorbusinessindicator(DEFAULT:Residential_Or_Business_Indicator_),onlywaytogetmailindicator(DEFAULT:Only_Way_To_Get_Mail_Indicator_),recordtypecode(DEFAULT:Record_Type_Code_),addresstypecode(DEFAULT:Address_Type_Code_),mixedusagecode(DEFAULT:Mixed_Usage_Code_),vacationbegindate(DEFAULT:Vacation_Begin_Date_:DATE),vacationenddate(DEFAULT:Vacation_End_Date_:DATE),numberofcurrentvacationmonths(DEFAULT:Number_Of_Current_Vacation_Months_),maxvacationmonths(DEFAULT:Max_Vacation_Months_),vacationperiodscount(DEFAULT:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),address_type(DEFAULT:Address___Type_:\'\'),address_desc(DEFAULT:Address___Desc_:\'\'),fdnindicator(DEFAULT:F_D_N_Indicator_),highrisksic(DEFAULT:High_Risk_S_I_C_:0),highrisknaics(DEFAULT:High_Risk_N_A_I_C_S_:0),src(OVERRIDE:Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_5Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_5Rule),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping5_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d5_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Header_Address,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Header_Address),SELF:=RIGHT));
  SHARED __d5_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Doxie__Key_Header_Address);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d5_UID_Mapped := JOIN(__d5_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d5_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Address_Invalid := __d5_UID_Mapped(UID = 0);
  SHARED __d5_Prefiltered := __d5_UID_Mapped(UID <> 0);
  SHARED __d5 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping5_Transform(LEFT)));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5;
  EXPORT Address_Components_Layout := RECORD
    KEL.typ.nstr Unit_Designation_;
    KEL.typ.nstr Postal_City_;
    KEL.typ.nstr Vanity_City_;
    KEL.typ.nstr State_;
    KEL.typ.nint Z_I_P4_;
    KEL.typ.nint Append_Raw_A_I_D_;
    KEL.typ.nstr Carrier_Route_Number_;
    KEL.typ.nstr Carrier_Route_Sortation_At_Z_I_P_;
    KEL.typ.nint Line_Of_Travel_;
    KEL.typ.nstr Line_Of_Travel_Order_;
    KEL.typ.nint Delivery_Point_Barcode_;
    KEL.typ.nint Delivery_Point_Barcode_Check_Digit_;
    KEL.typ.nstr Type_Code_;
    KEL.typ.nint County_;
    KEL.typ.nfloat Latitude_;
    KEL.typ.nfloat Longitude_;
    KEL.typ.nint Metropolitan_Statistical_Area_;
    KEL.typ.nint Geo_Block_;
    KEL.typ.nstr Geo_Match_;
    KEL.typ.nstr A_C_E_Cleaner_Error_Code_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT College_Layout := RECORD
    KEL.typ.nstr College_Indicator_;
    KEL.typ.nstr College_Start_Suppression_Date_;
    KEL.typ.nstr College_End_Suppression_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT A_D_V_O_Date_Summary_Layout := RECORD
    KEL.typ.nkdate A_D_V_O_Date_First_Seen_;
    KEL.typ.nkdate A_D_V_O_Date_Last_Seen_;
    KEL.typ.nkdate A_D_V_O_Date_Vendor_First_Reported_;
    KEL.typ.nkdate A_D_V_O_Date_Vendor_Last_Reported_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Business_Characteristics_Layout := RECORD
    KEL.typ.nstr Company_Address_Type_Raw_;
    KEL.typ.nstr Company_Address_Type_Derived_;
    KEL.typ.nstr Address_Type_Derived_;
    KEL.typ.nstr Address___Type_;
    KEL.typ.nstr Address___Desc_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT B_I_P_V2_Best_Layout := RECORD
    KEL.typ.nstr Address_Method_;
    KEL.typ.nstr Is_Active_;
    KEL.typ.nstr Is_Defunct_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Do_Not_Deliver_Layout := RECORD
    KEL.typ.nstr Do_Not_Deliver_Indicator_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Do_Not_Mail_Layout := RECORD
    KEL.typ.nstr Do_Not_Mail_Indicator_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Dead_C_O_Layout := RECORD
    KEL.typ.nstr Dead_C_O_Indicator_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Hot_List_Layout := RECORD
    KEL.typ.nstr Hot_List_Indicator_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Mail_Drop_Layout := RECORD
    KEL.typ.nstr Drop_Indicator_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Mixed_Usage_Layout := RECORD
    KEL.typ.nstr Mixed_Usage_Code_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Only_Way_To_Get_Mail_Layout := RECORD
    KEL.typ.nstr Only_Way_To_Get_Mail_Indicator_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Record_Type_Layout := RECORD
    KEL.typ.nstr Record_Type_Code_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Address_Type_Layout := RECORD
    KEL.typ.nstr Address_Type_Code_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Residential_Or_Business_Layout := RECORD
    KEL.typ.nstr Residential_Or_Business_Indicator_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Seasonal_Delivery_Layout := RECORD
    KEL.typ.nstr Seasonal_Delivery_Indicator_;
    KEL.typ.nstr Seasonal_Start_Suppression_Date_;
    KEL.typ.nstr Seasonal_End_Suppression_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Simplify_Layout := RECORD
    KEL.typ.nint Simplify_Count_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Style_Layout := RECORD
    KEL.typ.nstr Style_Code_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Throw_Back_Layout := RECORD
    KEL.typ.nstr Throw_Back_Indicator_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Vacancy_Layout := RECORD
    KEL.typ.nstr Vacancy_Indicator_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Vacation_Layout := RECORD
    KEL.typ.nint Number_Of_Current_Vacation_Months_;
    KEL.typ.nint Max_Vacation_Months_;
    KEL.typ.nint Vacation_Periods_Count_;
    KEL.typ.nkdate Vacation_Begin_Date_;
    KEL.typ.nkdate Vacation_End_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT High_Risk_Address_Layout := RECORD
    KEL.typ.nint High_Risk_S_I_C_;
    KEL.typ.nint High_Risk_N_A_I_C_S_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool F_D_N_Indicator_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ndataset(Address_Components_Layout) Address_Components_;
    KEL.typ.ndataset(College_Layout) College_;
    KEL.typ.ndataset(A_D_V_O_Date_Summary_Layout) A_D_V_O_Date_Summary_;
    KEL.typ.ndataset(Business_Characteristics_Layout) Business_Characteristics_;
    KEL.typ.ndataset(B_I_P_V2_Best_Layout) B_I_P_V2_Best_;
    KEL.typ.ndataset(Do_Not_Deliver_Layout) Do_Not_Deliver_;
    KEL.typ.ndataset(Do_Not_Mail_Layout) Do_Not_Mail_;
    KEL.typ.ndataset(Dead_C_O_Layout) Dead_C_O_;
    KEL.typ.ndataset(Hot_List_Layout) Hot_List_;
    KEL.typ.ndataset(Mail_Drop_Layout) Mail_Drop_;
    KEL.typ.ndataset(Mixed_Usage_Layout) Mixed_Usage_;
    KEL.typ.ndataset(Only_Way_To_Get_Mail_Layout) Only_Way_To_Get_Mail_;
    KEL.typ.ndataset(Record_Type_Layout) Record_Type_;
    KEL.typ.ndataset(Address_Type_Layout) Address_Type_;
    KEL.typ.ndataset(Residential_Or_Business_Layout) Residential_Or_Business_;
    KEL.typ.ndataset(Seasonal_Delivery_Layout) Seasonal_Delivery_;
    KEL.typ.ndataset(Simplify_Layout) Simplify_;
    KEL.typ.ndataset(Style_Layout) Style_;
    KEL.typ.ndataset(Throw_Back_Layout) Throw_Back_;
    KEL.typ.ndataset(Vacancy_Layout) Vacancy_;
    KEL.typ.ndataset(Vacation_Layout) Vacation_;
    KEL.typ.ndataset(High_Risk_Address_Layout) High_Risk_Address_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Address_Group := __PostFilter;
  Layout Address__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Primary_Range_ := KEL.Intake.SingleValue(__recs,Primary_Range_);
    SELF.Predirectional_ := KEL.Intake.SingleValue(__recs,Predirectional_);
    SELF.Primary_Name_ := KEL.Intake.SingleValue(__recs,Primary_Name_);
    SELF.Suffix_ := KEL.Intake.SingleValue(__recs,Suffix_);
    SELF.Postdirectional_ := KEL.Intake.SingleValue(__recs,Postdirectional_);
    SELF.Z_I_P5_ := KEL.Intake.SingleValue(__recs,Z_I_P5_);
    SELF.Secondary_Range_ := KEL.Intake.SingleValue(__recs,Secondary_Range_);
    SELF.Address_Components_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Unit_Designation_,Postal_City_,Vanity_City_,State_,Z_I_P4_,Append_Raw_A_I_D_,Carrier_Route_Number_,Carrier_Route_Sortation_At_Z_I_P_,Line_Of_Travel_,Line_Of_Travel_Order_,Delivery_Point_Barcode_,Delivery_Point_Barcode_Check_Digit_,Type_Code_,County_,Latitude_,Longitude_,Metropolitan_Statistical_Area_,Geo_Block_,Geo_Match_,A_C_E_Cleaner_Error_Code_},Unit_Designation_,Postal_City_,Vanity_City_,State_,Z_I_P4_,Append_Raw_A_I_D_,Carrier_Route_Number_,Carrier_Route_Sortation_At_Z_I_P_,Line_Of_Travel_,Line_Of_Travel_Order_,Delivery_Point_Barcode_,Delivery_Point_Barcode_Check_Digit_,Type_Code_,County_,Latitude_,Longitude_,Metropolitan_Statistical_Area_,Geo_Block_,Geo_Match_,A_C_E_Cleaner_Error_Code_),Address_Components_Layout)(__NN(Unit_Designation_) OR __NN(Postal_City_) OR __NN(Vanity_City_) OR __NN(State_) OR __NN(Z_I_P4_) OR __NN(Append_Raw_A_I_D_) OR __NN(Carrier_Route_Number_) OR __NN(Carrier_Route_Sortation_At_Z_I_P_) OR __NN(Line_Of_Travel_) OR __NN(Line_Of_Travel_Order_) OR __NN(Delivery_Point_Barcode_) OR __NN(Delivery_Point_Barcode_Check_Digit_) OR __NN(Type_Code_) OR __NN(County_) OR __NN(Latitude_) OR __NN(Longitude_) OR __NN(Metropolitan_Statistical_Area_) OR __NN(Geo_Block_) OR __NN(Geo_Match_) OR __NN(A_C_E_Cleaner_Error_Code_)));
    SELF.College_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),College_Indicator_,College_Start_Suppression_Date_,College_End_Suppression_Date_},College_Indicator_,College_Start_Suppression_Date_,College_End_Suppression_Date_),College_Layout)(__NN(College_Indicator_) OR __NN(College_Start_Suppression_Date_) OR __NN(College_End_Suppression_Date_)));
    SELF.A_D_V_O_Date_Summary_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),A_D_V_O_Date_First_Seen_,A_D_V_O_Date_Last_Seen_,A_D_V_O_Date_Vendor_First_Reported_,A_D_V_O_Date_Vendor_Last_Reported_},A_D_V_O_Date_First_Seen_,A_D_V_O_Date_Last_Seen_,A_D_V_O_Date_Vendor_First_Reported_,A_D_V_O_Date_Vendor_Last_Reported_),A_D_V_O_Date_Summary_Layout)(__NN(A_D_V_O_Date_First_Seen_) OR __NN(A_D_V_O_Date_Last_Seen_) OR __NN(A_D_V_O_Date_Vendor_First_Reported_) OR __NN(A_D_V_O_Date_Vendor_Last_Reported_)));
    SELF.Business_Characteristics_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Company_Address_Type_Raw_,Company_Address_Type_Derived_,Address_Type_Derived_,Address___Type_,Address___Desc_},Company_Address_Type_Raw_,Company_Address_Type_Derived_,Address_Type_Derived_,Address___Type_,Address___Desc_),Business_Characteristics_Layout)(__NN(Company_Address_Type_Raw_) OR __NN(Company_Address_Type_Derived_) OR __NN(Address_Type_Derived_) OR __NN(Address___Type_) OR __NN(Address___Desc_)));
    SELF.B_I_P_V2_Best_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Address_Method_,Is_Active_,Is_Defunct_},Address_Method_,Is_Active_,Is_Defunct_),B_I_P_V2_Best_Layout)(__NN(Address_Method_) OR __NN(Is_Active_) OR __NN(Is_Defunct_)));
    SELF.Do_Not_Deliver_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Do_Not_Deliver_Indicator_},Do_Not_Deliver_Indicator_),Do_Not_Deliver_Layout)(__NN(Do_Not_Deliver_Indicator_)));
    SELF.Do_Not_Mail_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Do_Not_Mail_Indicator_},Do_Not_Mail_Indicator_),Do_Not_Mail_Layout)(__NN(Do_Not_Mail_Indicator_)));
    SELF.Dead_C_O_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Dead_C_O_Indicator_},Dead_C_O_Indicator_),Dead_C_O_Layout)(__NN(Dead_C_O_Indicator_)));
    SELF.Hot_List_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Hot_List_Indicator_},Hot_List_Indicator_),Hot_List_Layout)(__NN(Hot_List_Indicator_)));
    SELF.Mail_Drop_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Drop_Indicator_},Drop_Indicator_),Mail_Drop_Layout)(__NN(Drop_Indicator_)));
    SELF.Mixed_Usage_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Mixed_Usage_Code_},Mixed_Usage_Code_),Mixed_Usage_Layout)(__NN(Mixed_Usage_Code_)));
    SELF.Only_Way_To_Get_Mail_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Only_Way_To_Get_Mail_Indicator_},Only_Way_To_Get_Mail_Indicator_),Only_Way_To_Get_Mail_Layout)(__NN(Only_Way_To_Get_Mail_Indicator_)));
    SELF.Record_Type_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Record_Type_Code_},Record_Type_Code_),Record_Type_Layout)(__NN(Record_Type_Code_)));
    SELF.Address_Type_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Address_Type_Code_},Address_Type_Code_),Address_Type_Layout)(__NN(Address_Type_Code_)));
    SELF.Residential_Or_Business_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Residential_Or_Business_Indicator_},Residential_Or_Business_Indicator_),Residential_Or_Business_Layout)(__NN(Residential_Or_Business_Indicator_)));
    SELF.Seasonal_Delivery_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Seasonal_Delivery_Indicator_,Seasonal_Start_Suppression_Date_,Seasonal_End_Suppression_Date_},Seasonal_Delivery_Indicator_,Seasonal_Start_Suppression_Date_,Seasonal_End_Suppression_Date_),Seasonal_Delivery_Layout)(__NN(Seasonal_Delivery_Indicator_) OR __NN(Seasonal_Start_Suppression_Date_) OR __NN(Seasonal_End_Suppression_Date_)));
    SELF.Simplify_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Simplify_Count_},Simplify_Count_),Simplify_Layout)(__NN(Simplify_Count_)));
    SELF.Style_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Style_Code_},Style_Code_),Style_Layout)(__NN(Style_Code_)));
    SELF.Throw_Back_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Throw_Back_Indicator_},Throw_Back_Indicator_),Throw_Back_Layout)(__NN(Throw_Back_Indicator_)));
    SELF.Vacancy_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Vacancy_Indicator_},Vacancy_Indicator_),Vacancy_Layout)(__NN(Vacancy_Indicator_)));
    SELF.Vacation_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Number_Of_Current_Vacation_Months_,Max_Vacation_Months_,Vacation_Periods_Count_,Vacation_Begin_Date_,Vacation_End_Date_},Number_Of_Current_Vacation_Months_,Max_Vacation_Months_,Vacation_Periods_Count_,Vacation_Begin_Date_,Vacation_End_Date_),Vacation_Layout)(__NN(Number_Of_Current_Vacation_Months_) OR __NN(Max_Vacation_Months_) OR __NN(Vacation_Periods_Count_) OR __NN(Vacation_Begin_Date_) OR __NN(Vacation_End_Date_)));
    SELF.High_Risk_Address_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),High_Risk_S_I_C_,High_Risk_N_A_I_C_S_},High_Risk_S_I_C_,High_Risk_N_A_I_C_S_),High_Risk_Address_Layout)(__NN(High_Risk_S_I_C_) OR __NN(High_Risk_N_A_I_C_S_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Source_,Header_Hit_Flag_,F_D_N_Indicator_},Source_,Header_Hit_Flag_,F_D_N_Indicator_),Data_Sources_Layout)(__NN(Source_) OR __NN(Header_Hit_Flag_) OR __NN(F_D_N_Indicator_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_First_Reported_,MIN,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_Last_Reported_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Address__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Address_Components_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Address_Components_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Unit_Designation_) OR __NN(Postal_City_) OR __NN(Vanity_City_) OR __NN(State_) OR __NN(Z_I_P4_) OR __NN(Append_Raw_A_I_D_) OR __NN(Carrier_Route_Number_) OR __NN(Carrier_Route_Sortation_At_Z_I_P_) OR __NN(Line_Of_Travel_) OR __NN(Line_Of_Travel_Order_) OR __NN(Delivery_Point_Barcode_) OR __NN(Delivery_Point_Barcode_Check_Digit_) OR __NN(Type_Code_) OR __NN(County_) OR __NN(Latitude_) OR __NN(Longitude_) OR __NN(Metropolitan_Statistical_Area_) OR __NN(Geo_Block_) OR __NN(Geo_Match_) OR __NN(A_C_E_Cleaner_Error_Code_)));
    SELF.College_ := __CN(PROJECT(DATASET(__r),TRANSFORM(College_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(College_Indicator_) OR __NN(College_Start_Suppression_Date_) OR __NN(College_End_Suppression_Date_)));
    SELF.A_D_V_O_Date_Summary_ := __CN(PROJECT(DATASET(__r),TRANSFORM(A_D_V_O_Date_Summary_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(A_D_V_O_Date_First_Seen_) OR __NN(A_D_V_O_Date_Last_Seen_) OR __NN(A_D_V_O_Date_Vendor_First_Reported_) OR __NN(A_D_V_O_Date_Vendor_Last_Reported_)));
    SELF.Business_Characteristics_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Business_Characteristics_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Company_Address_Type_Raw_) OR __NN(Company_Address_Type_Derived_) OR __NN(Address_Type_Derived_) OR __NN(Address___Type_) OR __NN(Address___Desc_)));
    SELF.B_I_P_V2_Best_ := __CN(PROJECT(DATASET(__r),TRANSFORM(B_I_P_V2_Best_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Address_Method_) OR __NN(Is_Active_) OR __NN(Is_Defunct_)));
    SELF.Do_Not_Deliver_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Do_Not_Deliver_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Do_Not_Deliver_Indicator_)));
    SELF.Do_Not_Mail_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Do_Not_Mail_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Do_Not_Mail_Indicator_)));
    SELF.Dead_C_O_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Dead_C_O_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Dead_C_O_Indicator_)));
    SELF.Hot_List_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Hot_List_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Hot_List_Indicator_)));
    SELF.Mail_Drop_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Mail_Drop_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Drop_Indicator_)));
    SELF.Mixed_Usage_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Mixed_Usage_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Mixed_Usage_Code_)));
    SELF.Only_Way_To_Get_Mail_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Only_Way_To_Get_Mail_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Only_Way_To_Get_Mail_Indicator_)));
    SELF.Record_Type_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Record_Type_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Record_Type_Code_)));
    SELF.Address_Type_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Address_Type_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Address_Type_Code_)));
    SELF.Residential_Or_Business_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Residential_Or_Business_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Residential_Or_Business_Indicator_)));
    SELF.Seasonal_Delivery_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Seasonal_Delivery_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Seasonal_Delivery_Indicator_) OR __NN(Seasonal_Start_Suppression_Date_) OR __NN(Seasonal_End_Suppression_Date_)));
    SELF.Simplify_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Simplify_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Simplify_Count_)));
    SELF.Style_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Style_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Style_Code_)));
    SELF.Throw_Back_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Throw_Back_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Throw_Back_Indicator_)));
    SELF.Vacancy_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Vacancy_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Vacancy_Indicator_)));
    SELF.Vacation_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Vacation_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Number_Of_Current_Vacation_Months_) OR __NN(Max_Vacation_Months_) OR __NN(Vacation_Periods_Count_) OR __NN(Vacation_Begin_Date_) OR __NN(Vacation_End_Date_)));
    SELF.High_Risk_Address_ := __CN(PROJECT(DATASET(__r),TRANSFORM(High_Risk_Address_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(High_Risk_S_I_C_) OR __NN(High_Risk_N_A_I_C_S_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Source_) OR __NN(Header_Hit_Flag_) OR __NN(F_D_N_Indicator_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_First_Reported_,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_Last_Reported_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Address_Group,COUNT(ROWS(LEFT))=1),GROUP,Address__Single_Rollup(LEFT)) + ROLLUP(HAVING(Address_Group,COUNT(ROWS(LEFT))>1),GROUP,Address__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Primary_Range__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Primary_Range_);
  EXPORT Predirectional__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Predirectional_);
  EXPORT Primary_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Primary_Name_);
  EXPORT Suffix__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Suffix_);
  EXPORT Postdirectional__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Postdirectional_);
  EXPORT Z_I_P5__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Z_I_P5_);
  EXPORT Secondary_Range__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Secondary_Range_);
  EXPORT Z_I_P5__Orphan := JOIN(InData(__NN(Z_I_P5_)),E_Zip_Code(__in,__cfg).__Result,__EEQP(LEFT.Z_I_P5_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Z_I_P5__Orphan),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_ADVO__Key_Addr1_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_ADVO__Key_Addr1_History_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DMA__Key_DNM_Name_Address_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Fraudpoint3__Key_Address_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_USPIS_HotList__key_addr_search_zip_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Address_Invalid),COUNT(Primary_Range__SingleValue_Invalid),COUNT(Predirectional__SingleValue_Invalid),COUNT(Primary_Name__SingleValue_Invalid),COUNT(Suffix__SingleValue_Invalid),COUNT(Postdirectional__SingleValue_Invalid),COUNT(Z_I_P5__SingleValue_Invalid),COUNT(Secondary_Range__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int Z_I_P5__Orphan,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_ADVO__Key_Addr1_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_ADVO__Key_Addr1_History_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DMA__Key_DNM_Name_Address_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Fraudpoint3__Key_Address_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_USPIS_HotList__key_addr_search_zip_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Address_Invalid,KEL.typ.int Primary_Range__SingleValue_Invalid,KEL.typ.int Predirectional__SingleValue_Invalid,KEL.typ.int Primary_Name__SingleValue_Invalid,KEL.typ.int Suffix__SingleValue_Invalid,KEL.typ.int Postdirectional__SingleValue_Invalid,KEL.typ.int Z_I_P5__SingleValue_Invalid,KEL.typ.int Secondary_Range__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_ADVO__Key_Addr1_Invalid),COUNT(__d0)},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d0(__NL(Primary_Range_))),COUNT(__d0(__NN(Primary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d0(__NL(Predirectional_))),COUNT(__d0(__NN(Predirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d0(__NL(Primary_Name_))),COUNT(__d0(__NN(Primary_Name_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d0(__NL(Suffix_))),COUNT(__d0(__NN(Suffix_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d0(__NL(Postdirectional_))),COUNT(__d0(__NN(Postdirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','unit_desig',COUNT(__d0(__NL(Unit_Designation_))),COUNT(__d0(__NN(Unit_Designation_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d0(__NL(Secondary_Range_))),COUNT(__d0(__NN(Secondary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','p_city_name',COUNT(__d0(__NL(Postal_City_))),COUNT(__d0(__NN(Postal_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','v_city_name',COUNT(__d0(__NL(Vanity_City_))),COUNT(__d0(__NN(Vanity_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d0(__NL(State_))),COUNT(__d0(__NN(State_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d0(__NL(Z_I_P5_))),COUNT(__d0(__NN(Z_I_P5_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip4',COUNT(__d0(__NL(Z_I_P4_))),COUNT(__d0(__NN(Z_I_P4_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AppendRawAID',COUNT(__d0(__NL(Append_Raw_A_I_D_))),COUNT(__d0(__NN(Append_Raw_A_I_D_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cart',COUNT(__d0(__NL(Carrier_Route_Number_))),COUNT(__d0(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cr_sort_sz',COUNT(__d0(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d0(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lot',COUNT(__d0(__NL(Line_Of_Travel_))),COUNT(__d0(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lot_order',COUNT(__d0(__NL(Line_Of_Travel_Order_))),COUNT(__d0(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dbpc',COUNT(__d0(__NL(Delivery_Point_Barcode_))),COUNT(__d0(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','chk_digit',COUNT(__d0(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d0(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec_type',COUNT(__d0(__NL(Type_Code_))),COUNT(__d0(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','county',COUNT(__d0(__NL(County_))),COUNT(__d0(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_lat',COUNT(__d0(__NL(Latitude_))),COUNT(__d0(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_long',COUNT(__d0(__NL(Longitude_))),COUNT(__d0(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','msa',COUNT(__d0(__NL(Metropolitan_Statistical_Area_))),COUNT(__d0(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_blk',COUNT(__d0(__NL(Geo_Block_))),COUNT(__d0(__NN(Geo_Block_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_match',COUNT(__d0(__NL(Geo_Match_))),COUNT(__d0(__NN(Geo_Match_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','err_stat',COUNT(__d0(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d0(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_first_seen',COUNT(__d0(__NL(A_D_V_O_Date_First_Seen_))),COUNT(__d0(__NN(A_D_V_O_Date_First_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_last_seen',COUNT(__d0(__NL(A_D_V_O_Date_Last_Seen_))),COUNT(__d0(__NN(A_D_V_O_Date_Last_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_vendor_first_reported',COUNT(__d0(__NL(A_D_V_O_Date_Vendor_First_Reported_))),COUNT(__d0(__NN(A_D_V_O_Date_Vendor_First_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_vendor_last_reported',COUNT(__d0(__NL(A_D_V_O_Date_Vendor_Last_Reported_))),COUNT(__d0(__NN(A_D_V_O_Date_Vendor_Last_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','address_vacancy_indicator',COUNT(__d0(__NL(Vacancy_Indicator_))),COUNT(__d0(__NN(Vacancy_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','throw_back_indicator',COUNT(__d0(__NL(Throw_Back_Indicator_))),COUNT(__d0(__NN(Throw_Back_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seasonal_delivery_indicator',COUNT(__d0(__NL(Seasonal_Delivery_Indicator_))),COUNT(__d0(__NN(Seasonal_Delivery_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seasonal_start_suppression_date',COUNT(__d0(__NL(Seasonal_Start_Suppression_Date_))),COUNT(__d0(__NN(Seasonal_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seasonal_end_suppression_date',COUNT(__d0(__NL(Seasonal_End_Suppression_Date_))),COUNT(__d0(__NN(Seasonal_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dnd_indicator',COUNT(__d0(__NL(Do_Not_Deliver_Indicator_))),COUNT(__d0(__NN(Do_Not_Deliver_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotMailIndicator',COUNT(__d0(__NL(Do_Not_Mail_Indicator_))),COUNT(__d0(__NN(Do_Not_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeadCOIndicator',COUNT(__d0(__NL(Dead_C_O_Indicator_))),COUNT(__d0(__NN(Dead_C_O_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HotListIndicator',COUNT(__d0(__NL(Hot_List_Indicator_))),COUNT(__d0(__NN(Hot_List_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','college_indicator',COUNT(__d0(__NL(College_Indicator_))),COUNT(__d0(__NN(College_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','college_start_suppression_date',COUNT(__d0(__NL(College_Start_Suppression_Date_))),COUNT(__d0(__NN(College_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','college_end_suppression_date',COUNT(__d0(__NL(College_End_Suppression_Date_))),COUNT(__d0(__NN(College_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','address_style_flag',COUNT(__d0(__NL(Style_Code_))),COUNT(__d0(__NN(Style_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','simplify_address_count',COUNT(__d0(__NL(Simplify_Count_))),COUNT(__d0(__NN(Simplify_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','drop_indicator',COUNT(__d0(__NL(Drop_Indicator_))),COUNT(__d0(__NN(Drop_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','residential_or_business_ind',COUNT(__d0(__NL(Residential_Or_Business_Indicator_))),COUNT(__d0(__NN(Residential_Or_Business_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','owgm_indicator',COUNT(__d0(__NL(Only_Way_To_Get_Mail_Indicator_))),COUNT(__d0(__NN(Only_Way_To_Get_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_type_code',COUNT(__d0(__NL(Record_Type_Code_))),COUNT(__d0(__NN(Record_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','address_type',COUNT(__d0(__NL(Address_Type_Code_))),COUNT(__d0(__NN(Address_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mixed_address_usage',COUNT(__d0(__NL(Mixed_Usage_Code_))),COUNT(__d0(__NN(Mixed_Usage_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vac_begdt',COUNT(__d0(__NL(Vacation_Begin_Date_))),COUNT(__d0(__NN(Vacation_Begin_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vac_enddt',COUNT(__d0(__NL(Vacation_End_Date_))),COUNT(__d0(__NN(Vacation_End_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','months_vac_curr',COUNT(__d0(__NL(Number_Of_Current_Vacation_Months_))),COUNT(__d0(__NN(Number_Of_Current_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','months_vac_max',COUNT(__d0(__NL(Max_Vacation_Months_))),COUNT(__d0(__NN(Max_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vac_count',COUNT(__d0(__NL(Vacation_Periods_Count_))),COUNT(__d0(__NN(Vacation_Periods_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d0(__NL(Company_Address_Type_Raw_))),COUNT(__d0(__NN(Company_Address_Type_Raw_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d0(__NL(Company_Address_Type_Derived_))),COUNT(__d0(__NN(Company_Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d0(__NL(Address_Type_Derived_))),COUNT(__d0(__NN(Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressMethod',COUNT(__d0(__NL(Address_Method_))),COUNT(__d0(__NN(Address_Method_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d0(__NL(Is_Active_))),COUNT(__d0(__NN(Is_Active_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDefunct',COUNT(__d0(__NL(Is_Defunct_))),COUNT(__d0(__NN(Is_Defunct_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Type',COUNT(__d0(__NL(Address___Type_))),COUNT(__d0(__NN(Address___Type_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Desc',COUNT(__d0(__NL(Address___Desc_))),COUNT(__d0(__NN(Address___Desc_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d0(__NL(Header_Hit_Flag_))),COUNT(__d0(__NN(Header_Hit_Flag_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FDNIndicator',COUNT(__d0(__NL(F_D_N_Indicator_))),COUNT(__d0(__NN(F_D_N_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskSIC',COUNT(__d0(__NL(High_Risk_S_I_C_))),COUNT(__d0(__NN(High_Risk_S_I_C_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskNAICS',COUNT(__d0(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d0(__NN(High_Risk_N_A_I_C_S_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d0(Date_Vendor_First_Reported_=0)),COUNT(__d0(Date_Vendor_First_Reported_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d0(Date_Vendor_Last_Reported_=0)),COUNT(__d0(Date_Vendor_Last_Reported_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_ADVO__Key_Addr1_History_Invalid),COUNT(__d1)},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d1(__NL(Primary_Range_))),COUNT(__d1(__NN(Primary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d1(__NL(Predirectional_))),COUNT(__d1(__NN(Predirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d1(__NL(Primary_Name_))),COUNT(__d1(__NN(Primary_Name_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d1(__NL(Suffix_))),COUNT(__d1(__NN(Suffix_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d1(__NL(Postdirectional_))),COUNT(__d1(__NN(Postdirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','unit_desig',COUNT(__d1(__NL(Unit_Designation_))),COUNT(__d1(__NN(Unit_Designation_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d1(__NL(Secondary_Range_))),COUNT(__d1(__NN(Secondary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','p_city_name',COUNT(__d1(__NL(Postal_City_))),COUNT(__d1(__NN(Postal_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','v_city_name',COUNT(__d1(__NL(Vanity_City_))),COUNT(__d1(__NN(Vanity_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d1(__NL(State_))),COUNT(__d1(__NN(State_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d1(__NL(Z_I_P5_))),COUNT(__d1(__NN(Z_I_P5_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip4',COUNT(__d1(__NL(Z_I_P4_))),COUNT(__d1(__NN(Z_I_P4_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AppendRawAID',COUNT(__d1(__NL(Append_Raw_A_I_D_))),COUNT(__d1(__NN(Append_Raw_A_I_D_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cart',COUNT(__d1(__NL(Carrier_Route_Number_))),COUNT(__d1(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cr_sort_sz',COUNT(__d1(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d1(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lot',COUNT(__d1(__NL(Line_Of_Travel_))),COUNT(__d1(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lot_order',COUNT(__d1(__NL(Line_Of_Travel_Order_))),COUNT(__d1(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dbpc',COUNT(__d1(__NL(Delivery_Point_Barcode_))),COUNT(__d1(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','chk_digit',COUNT(__d1(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d1(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec_type',COUNT(__d1(__NL(Type_Code_))),COUNT(__d1(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','county',COUNT(__d1(__NL(County_))),COUNT(__d1(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_lat',COUNT(__d1(__NL(Latitude_))),COUNT(__d1(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_long',COUNT(__d1(__NL(Longitude_))),COUNT(__d1(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','msa',COUNT(__d1(__NL(Metropolitan_Statistical_Area_))),COUNT(__d1(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_blk',COUNT(__d1(__NL(Geo_Block_))),COUNT(__d1(__NN(Geo_Block_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_match',COUNT(__d1(__NL(Geo_Match_))),COUNT(__d1(__NN(Geo_Match_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','err_stat',COUNT(__d1(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d1(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_first_seen',COUNT(__d1(__NL(A_D_V_O_Date_First_Seen_))),COUNT(__d1(__NN(A_D_V_O_Date_First_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_last_seen',COUNT(__d1(__NL(A_D_V_O_Date_Last_Seen_))),COUNT(__d1(__NN(A_D_V_O_Date_Last_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_vendor_first_reported',COUNT(__d1(__NL(A_D_V_O_Date_Vendor_First_Reported_))),COUNT(__d1(__NN(A_D_V_O_Date_Vendor_First_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_vendor_last_reported',COUNT(__d1(__NL(A_D_V_O_Date_Vendor_Last_Reported_))),COUNT(__d1(__NN(A_D_V_O_Date_Vendor_Last_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','address_vacancy_indicator',COUNT(__d1(__NL(Vacancy_Indicator_))),COUNT(__d1(__NN(Vacancy_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','throw_back_indicator',COUNT(__d1(__NL(Throw_Back_Indicator_))),COUNT(__d1(__NN(Throw_Back_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seasonal_delivery_indicator',COUNT(__d1(__NL(Seasonal_Delivery_Indicator_))),COUNT(__d1(__NN(Seasonal_Delivery_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seasonal_start_suppression_date',COUNT(__d1(__NL(Seasonal_Start_Suppression_Date_))),COUNT(__d1(__NN(Seasonal_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seasonal_end_suppression_date',COUNT(__d1(__NL(Seasonal_End_Suppression_Date_))),COUNT(__d1(__NN(Seasonal_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dnd_indicator',COUNT(__d1(__NL(Do_Not_Deliver_Indicator_))),COUNT(__d1(__NN(Do_Not_Deliver_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotMailIndicator',COUNT(__d1(__NL(Do_Not_Mail_Indicator_))),COUNT(__d1(__NN(Do_Not_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeadCOIndicator',COUNT(__d1(__NL(Dead_C_O_Indicator_))),COUNT(__d1(__NN(Dead_C_O_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HotListIndicator',COUNT(__d1(__NL(Hot_List_Indicator_))),COUNT(__d1(__NN(Hot_List_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','college_indicator',COUNT(__d1(__NL(College_Indicator_))),COUNT(__d1(__NN(College_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','college_start_suppression_date',COUNT(__d1(__NL(College_Start_Suppression_Date_))),COUNT(__d1(__NN(College_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','college_end_suppression_date',COUNT(__d1(__NL(College_End_Suppression_Date_))),COUNT(__d1(__NN(College_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','address_style_flag',COUNT(__d1(__NL(Style_Code_))),COUNT(__d1(__NN(Style_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','simplify_address_count',COUNT(__d1(__NL(Simplify_Count_))),COUNT(__d1(__NN(Simplify_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','drop_indicator',COUNT(__d1(__NL(Drop_Indicator_))),COUNT(__d1(__NN(Drop_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','residential_or_business_ind',COUNT(__d1(__NL(Residential_Or_Business_Indicator_))),COUNT(__d1(__NN(Residential_Or_Business_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','owgm_indicator',COUNT(__d1(__NL(Only_Way_To_Get_Mail_Indicator_))),COUNT(__d1(__NN(Only_Way_To_Get_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_type_code',COUNT(__d1(__NL(Record_Type_Code_))),COUNT(__d1(__NN(Record_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','address_type',COUNT(__d1(__NL(Address_Type_Code_))),COUNT(__d1(__NN(Address_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mixed_address_usage',COUNT(__d1(__NL(Mixed_Usage_Code_))),COUNT(__d1(__NN(Mixed_Usage_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vac_begdt',COUNT(__d1(__NL(Vacation_Begin_Date_))),COUNT(__d1(__NN(Vacation_Begin_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vac_enddt',COUNT(__d1(__NL(Vacation_End_Date_))),COUNT(__d1(__NN(Vacation_End_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','months_vac_curr',COUNT(__d1(__NL(Number_Of_Current_Vacation_Months_))),COUNT(__d1(__NN(Number_Of_Current_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','months_vac_max',COUNT(__d1(__NL(Max_Vacation_Months_))),COUNT(__d1(__NN(Max_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vac_count',COUNT(__d1(__NL(Vacation_Periods_Count_))),COUNT(__d1(__NN(Vacation_Periods_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d1(__NL(Company_Address_Type_Raw_))),COUNT(__d1(__NN(Company_Address_Type_Raw_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d1(__NL(Company_Address_Type_Derived_))),COUNT(__d1(__NN(Company_Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d1(__NL(Address_Type_Derived_))),COUNT(__d1(__NN(Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressMethod',COUNT(__d1(__NL(Address_Method_))),COUNT(__d1(__NN(Address_Method_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d1(__NL(Is_Active_))),COUNT(__d1(__NN(Is_Active_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDefunct',COUNT(__d1(__NL(Is_Defunct_))),COUNT(__d1(__NN(Is_Defunct_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Type',COUNT(__d1(__NL(Address___Type_))),COUNT(__d1(__NN(Address___Type_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Desc',COUNT(__d1(__NL(Address___Desc_))),COUNT(__d1(__NN(Address___Desc_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d1(__NL(Header_Hit_Flag_))),COUNT(__d1(__NN(Header_Hit_Flag_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FDNIndicator',COUNT(__d1(__NL(F_D_N_Indicator_))),COUNT(__d1(__NN(F_D_N_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskSIC',COUNT(__d1(__NL(High_Risk_S_I_C_))),COUNT(__d1(__NN(High_Risk_S_I_C_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskNAICS',COUNT(__d1(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d1(__NN(High_Risk_N_A_I_C_S_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d1(Date_Vendor_First_Reported_=0)),COUNT(__d1(Date_Vendor_First_Reported_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d1(Date_Vendor_Last_Reported_=0)),COUNT(__d1(Date_Vendor_Last_Reported_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DMA__Key_DNM_Name_Address_Invalid),COUNT(__d2)},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d2(__NL(Primary_Range_))),COUNT(__d2(__NN(Primary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d2(__NL(Predirectional_))),COUNT(__d2(__NN(Predirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d2(__NL(Primary_Name_))),COUNT(__d2(__NN(Primary_Name_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d2(__NL(Suffix_))),COUNT(__d2(__NN(Suffix_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d2(__NL(Postdirectional_))),COUNT(__d2(__NN(Postdirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','unit_desig',COUNT(__d2(__NL(Unit_Designation_))),COUNT(__d2(__NN(Unit_Designation_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d2(__NL(Secondary_Range_))),COUNT(__d2(__NN(Secondary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','p_city_name',COUNT(__d2(__NL(Postal_City_))),COUNT(__d2(__NN(Postal_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','v_city_name',COUNT(__d2(__NL(Vanity_City_))),COUNT(__d2(__NN(Vanity_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d2(__NL(State_))),COUNT(__d2(__NN(State_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d2(__NL(Z_I_P5_))),COUNT(__d2(__NN(Z_I_P5_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip4',COUNT(__d2(__NL(Z_I_P4_))),COUNT(__d2(__NN(Z_I_P4_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AppendRawAID',COUNT(__d2(__NL(Append_Raw_A_I_D_))),COUNT(__d2(__NN(Append_Raw_A_I_D_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteNumber',COUNT(__d2(__NL(Carrier_Route_Number_))),COUNT(__d2(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteSortationAtZIP',COUNT(__d2(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d2(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravel',COUNT(__d2(__NL(Line_Of_Travel_))),COUNT(__d2(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravelOrder',COUNT(__d2(__NL(Line_Of_Travel_Order_))),COUNT(__d2(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcode',COUNT(__d2(__NL(Delivery_Point_Barcode_))),COUNT(__d2(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcodeCheckDigit',COUNT(__d2(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d2(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeCode',COUNT(__d2(__NL(Type_Code_))),COUNT(__d2(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','County',COUNT(__d2(__NL(County_))),COUNT(__d2(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Latitude',COUNT(__d2(__NL(Latitude_))),COUNT(__d2(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Longitude',COUNT(__d2(__NL(Longitude_))),COUNT(__d2(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d2(__NL(Metropolitan_Statistical_Area_))),COUNT(__d2(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoBlock',COUNT(__d2(__NL(Geo_Block_))),COUNT(__d2(__NN(Geo_Block_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoMatch',COUNT(__d2(__NL(Geo_Match_))),COUNT(__d2(__NN(Geo_Match_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ACECleanerErrorCode',COUNT(__d2(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d2(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateFirstSeen',COUNT(__d2(__NL(A_D_V_O_Date_First_Seen_))),COUNT(__d2(__NN(A_D_V_O_Date_First_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateLastSeen',COUNT(__d2(__NL(A_D_V_O_Date_Last_Seen_))),COUNT(__d2(__NN(A_D_V_O_Date_Last_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorFirstReported',COUNT(__d2(__NL(A_D_V_O_Date_Vendor_First_Reported_))),COUNT(__d2(__NN(A_D_V_O_Date_Vendor_First_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorLastReported',COUNT(__d2(__NL(A_D_V_O_Date_Vendor_Last_Reported_))),COUNT(__d2(__NN(A_D_V_O_Date_Vendor_Last_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacancyIndicator',COUNT(__d2(__NL(Vacancy_Indicator_))),COUNT(__d2(__NN(Vacancy_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThrowBackIndicator',COUNT(__d2(__NL(Throw_Back_Indicator_))),COUNT(__d2(__NN(Throw_Back_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalDeliveryIndicator',COUNT(__d2(__NL(Seasonal_Delivery_Indicator_))),COUNT(__d2(__NN(Seasonal_Delivery_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalStartSuppressionDate',COUNT(__d2(__NL(Seasonal_Start_Suppression_Date_))),COUNT(__d2(__NN(Seasonal_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalEndSuppressionDate',COUNT(__d2(__NL(Seasonal_End_Suppression_Date_))),COUNT(__d2(__NN(Seasonal_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotDeliverIndicator',COUNT(__d2(__NL(Do_Not_Deliver_Indicator_))),COUNT(__d2(__NN(Do_Not_Deliver_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeadCOIndicator',COUNT(__d2(__NL(Dead_C_O_Indicator_))),COUNT(__d2(__NN(Dead_C_O_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HotListIndicator',COUNT(__d2(__NL(Hot_List_Indicator_))),COUNT(__d2(__NN(Hot_List_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeIndicator',COUNT(__d2(__NL(College_Indicator_))),COUNT(__d2(__NN(College_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeStartSuppressionDate',COUNT(__d2(__NL(College_Start_Suppression_Date_))),COUNT(__d2(__NN(College_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeEndSuppressionDate',COUNT(__d2(__NL(College_End_Suppression_Date_))),COUNT(__d2(__NN(College_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StyleCode',COUNT(__d2(__NL(Style_Code_))),COUNT(__d2(__NN(Style_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SimplifyCount',COUNT(__d2(__NL(Simplify_Count_))),COUNT(__d2(__NN(Simplify_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DropIndicator',COUNT(__d2(__NL(Drop_Indicator_))),COUNT(__d2(__NN(Drop_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ResidentialOrBusinessIndicator',COUNT(__d2(__NL(Residential_Or_Business_Indicator_))),COUNT(__d2(__NN(Residential_Or_Business_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OnlyWayToGetMailIndicator',COUNT(__d2(__NL(Only_Way_To_Get_Mail_Indicator_))),COUNT(__d2(__NN(Only_Way_To_Get_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordTypeCode',COUNT(__d2(__NL(Record_Type_Code_))),COUNT(__d2(__NN(Record_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeCode',COUNT(__d2(__NL(Address_Type_Code_))),COUNT(__d2(__NN(Address_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MixedUsageCode',COUNT(__d2(__NL(Mixed_Usage_Code_))),COUNT(__d2(__NN(Mixed_Usage_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationBeginDate',COUNT(__d2(__NL(Vacation_Begin_Date_))),COUNT(__d2(__NN(Vacation_Begin_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationEndDate',COUNT(__d2(__NL(Vacation_End_Date_))),COUNT(__d2(__NN(Vacation_End_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfCurrentVacationMonths',COUNT(__d2(__NL(Number_Of_Current_Vacation_Months_))),COUNT(__d2(__NN(Number_Of_Current_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaxVacationMonths',COUNT(__d2(__NL(Max_Vacation_Months_))),COUNT(__d2(__NN(Max_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationPeriodsCount',COUNT(__d2(__NL(Vacation_Periods_Count_))),COUNT(__d2(__NN(Vacation_Periods_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d2(__NL(Company_Address_Type_Raw_))),COUNT(__d2(__NN(Company_Address_Type_Raw_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d2(__NL(Company_Address_Type_Derived_))),COUNT(__d2(__NN(Company_Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d2(__NL(Address_Type_Derived_))),COUNT(__d2(__NN(Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressMethod',COUNT(__d2(__NL(Address_Method_))),COUNT(__d2(__NN(Address_Method_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d2(__NL(Is_Active_))),COUNT(__d2(__NN(Is_Active_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDefunct',COUNT(__d2(__NL(Is_Defunct_))),COUNT(__d2(__NN(Is_Defunct_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Type',COUNT(__d2(__NL(Address___Type_))),COUNT(__d2(__NN(Address___Type_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Desc',COUNT(__d2(__NL(Address___Desc_))),COUNT(__d2(__NN(Address___Desc_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d2(__NL(Header_Hit_Flag_))),COUNT(__d2(__NN(Header_Hit_Flag_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FDNIndicator',COUNT(__d2(__NL(F_D_N_Indicator_))),COUNT(__d2(__NN(F_D_N_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskSIC',COUNT(__d2(__NL(High_Risk_S_I_C_))),COUNT(__d2(__NN(High_Risk_S_I_C_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskNAICS',COUNT(__d2(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d2(__NN(High_Risk_N_A_I_C_S_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d2(Date_Vendor_First_Reported_=0)),COUNT(__d2(Date_Vendor_First_Reported_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d2(Date_Vendor_Last_Reported_=0)),COUNT(__d2(Date_Vendor_Last_Reported_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Fraudpoint3__Key_Address_Invalid),COUNT(__d3)},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d3(__NL(Primary_Range_))),COUNT(__d3(__NN(Primary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d3(__NL(Predirectional_))),COUNT(__d3(__NN(Predirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d3(__NL(Primary_Name_))),COUNT(__d3(__NN(Primary_Name_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d3(__NL(Suffix_))),COUNT(__d3(__NN(Suffix_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d3(__NL(Postdirectional_))),COUNT(__d3(__NN(Postdirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','unit_desig',COUNT(__d3(__NL(Unit_Designation_))),COUNT(__d3(__NN(Unit_Designation_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d3(__NL(Secondary_Range_))),COUNT(__d3(__NN(Secondary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','p_city_name',COUNT(__d3(__NL(Postal_City_))),COUNT(__d3(__NN(Postal_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','v_city_name',COUNT(__d3(__NL(Vanity_City_))),COUNT(__d3(__NN(Vanity_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d3(__NL(State_))),COUNT(__d3(__NN(State_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d3(__NL(Z_I_P5_))),COUNT(__d3(__NN(Z_I_P5_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip4',COUNT(__d3(__NL(Z_I_P4_))),COUNT(__d3(__NN(Z_I_P4_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AppendRawAID',COUNT(__d3(__NL(Append_Raw_A_I_D_))),COUNT(__d3(__NN(Append_Raw_A_I_D_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteNumber',COUNT(__d3(__NL(Carrier_Route_Number_))),COUNT(__d3(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteSortationAtZIP',COUNT(__d3(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d3(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravel',COUNT(__d3(__NL(Line_Of_Travel_))),COUNT(__d3(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravelOrder',COUNT(__d3(__NL(Line_Of_Travel_Order_))),COUNT(__d3(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcode',COUNT(__d3(__NL(Delivery_Point_Barcode_))),COUNT(__d3(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcodeCheckDigit',COUNT(__d3(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d3(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeCode',COUNT(__d3(__NL(Type_Code_))),COUNT(__d3(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','County',COUNT(__d3(__NL(County_))),COUNT(__d3(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_lat',COUNT(__d3(__NL(Latitude_))),COUNT(__d3(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_long',COUNT(__d3(__NL(Longitude_))),COUNT(__d3(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d3(__NL(Metropolitan_Statistical_Area_))),COUNT(__d3(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_blk',COUNT(__d3(__NL(Geo_Block_))),COUNT(__d3(__NN(Geo_Block_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoMatch',COUNT(__d3(__NL(Geo_Match_))),COUNT(__d3(__NN(Geo_Match_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ACECleanerErrorCode',COUNT(__d3(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d3(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateFirstSeen',COUNT(__d3(__NL(A_D_V_O_Date_First_Seen_))),COUNT(__d3(__NN(A_D_V_O_Date_First_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateLastSeen',COUNT(__d3(__NL(A_D_V_O_Date_Last_Seen_))),COUNT(__d3(__NN(A_D_V_O_Date_Last_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorFirstReported',COUNT(__d3(__NL(A_D_V_O_Date_Vendor_First_Reported_))),COUNT(__d3(__NN(A_D_V_O_Date_Vendor_First_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorLastReported',COUNT(__d3(__NL(A_D_V_O_Date_Vendor_Last_Reported_))),COUNT(__d3(__NN(A_D_V_O_Date_Vendor_Last_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacancyIndicator',COUNT(__d3(__NL(Vacancy_Indicator_))),COUNT(__d3(__NN(Vacancy_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThrowBackIndicator',COUNT(__d3(__NL(Throw_Back_Indicator_))),COUNT(__d3(__NN(Throw_Back_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalDeliveryIndicator',COUNT(__d3(__NL(Seasonal_Delivery_Indicator_))),COUNT(__d3(__NN(Seasonal_Delivery_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalStartSuppressionDate',COUNT(__d3(__NL(Seasonal_Start_Suppression_Date_))),COUNT(__d3(__NN(Seasonal_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalEndSuppressionDate',COUNT(__d3(__NL(Seasonal_End_Suppression_Date_))),COUNT(__d3(__NN(Seasonal_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotDeliverIndicator',COUNT(__d3(__NL(Do_Not_Deliver_Indicator_))),COUNT(__d3(__NN(Do_Not_Deliver_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotMailIndicator',COUNT(__d3(__NL(Do_Not_Mail_Indicator_))),COUNT(__d3(__NN(Do_Not_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeadCOIndicator',COUNT(__d3(__NL(Dead_C_O_Indicator_))),COUNT(__d3(__NN(Dead_C_O_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HotListIndicator',COUNT(__d3(__NL(Hot_List_Indicator_))),COUNT(__d3(__NN(Hot_List_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeIndicator',COUNT(__d3(__NL(College_Indicator_))),COUNT(__d3(__NN(College_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeStartSuppressionDate',COUNT(__d3(__NL(College_Start_Suppression_Date_))),COUNT(__d3(__NN(College_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeEndSuppressionDate',COUNT(__d3(__NL(College_End_Suppression_Date_))),COUNT(__d3(__NN(College_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StyleCode',COUNT(__d3(__NL(Style_Code_))),COUNT(__d3(__NN(Style_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SimplifyCount',COUNT(__d3(__NL(Simplify_Count_))),COUNT(__d3(__NN(Simplify_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DropIndicator',COUNT(__d3(__NL(Drop_Indicator_))),COUNT(__d3(__NN(Drop_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ResidentialOrBusinessIndicator',COUNT(__d3(__NL(Residential_Or_Business_Indicator_))),COUNT(__d3(__NN(Residential_Or_Business_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OnlyWayToGetMailIndicator',COUNT(__d3(__NL(Only_Way_To_Get_Mail_Indicator_))),COUNT(__d3(__NN(Only_Way_To_Get_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordTypeCode',COUNT(__d3(__NL(Record_Type_Code_))),COUNT(__d3(__NN(Record_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeCode',COUNT(__d3(__NL(Address_Type_Code_))),COUNT(__d3(__NN(Address_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MixedUsageCode',COUNT(__d3(__NL(Mixed_Usage_Code_))),COUNT(__d3(__NN(Mixed_Usage_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationBeginDate',COUNT(__d3(__NL(Vacation_Begin_Date_))),COUNT(__d3(__NN(Vacation_Begin_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationEndDate',COUNT(__d3(__NL(Vacation_End_Date_))),COUNT(__d3(__NN(Vacation_End_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfCurrentVacationMonths',COUNT(__d3(__NL(Number_Of_Current_Vacation_Months_))),COUNT(__d3(__NN(Number_Of_Current_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaxVacationMonths',COUNT(__d3(__NL(Max_Vacation_Months_))),COUNT(__d3(__NN(Max_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationPeriodsCount',COUNT(__d3(__NL(Vacation_Periods_Count_))),COUNT(__d3(__NN(Vacation_Periods_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d3(__NL(Company_Address_Type_Raw_))),COUNT(__d3(__NN(Company_Address_Type_Raw_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d3(__NL(Company_Address_Type_Derived_))),COUNT(__d3(__NN(Company_Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d3(__NL(Address_Type_Derived_))),COUNT(__d3(__NN(Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressMethod',COUNT(__d3(__NL(Address_Method_))),COUNT(__d3(__NN(Address_Method_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d3(__NL(Is_Active_))),COUNT(__d3(__NN(Is_Active_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDefunct',COUNT(__d3(__NL(Is_Defunct_))),COUNT(__d3(__NN(Is_Defunct_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Type',COUNT(__d3(__NL(Address___Type_))),COUNT(__d3(__NN(Address___Type_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Desc',COUNT(__d3(__NL(Address___Desc_))),COUNT(__d3(__NN(Address___Desc_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d3(__NL(Header_Hit_Flag_))),COUNT(__d3(__NN(Header_Hit_Flag_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskSIC',COUNT(__d3(__NL(High_Risk_S_I_C_))),COUNT(__d3(__NN(High_Risk_S_I_C_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskNAICS',COUNT(__d3(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d3(__NN(High_Risk_N_A_I_C_S_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d3(Date_Vendor_First_Reported_=0)),COUNT(__d3(Date_Vendor_First_Reported_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d3(Date_Vendor_Last_Reported_=0)),COUNT(__d3(Date_Vendor_Last_Reported_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_USPIS_HotList__key_addr_search_zip_Invalid),COUNT(__d4)},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d4(__NL(Primary_Range_))),COUNT(__d4(__NN(Primary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d4(__NL(Predirectional_))),COUNT(__d4(__NN(Predirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d4(__NL(Primary_Name_))),COUNT(__d4(__NN(Primary_Name_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d4(__NL(Suffix_))),COUNT(__d4(__NN(Suffix_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d4(__NL(Postdirectional_))),COUNT(__d4(__NN(Postdirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','unit_desig',COUNT(__d4(__NL(Unit_Designation_))),COUNT(__d4(__NN(Unit_Designation_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d4(__NL(Secondary_Range_))),COUNT(__d4(__NN(Secondary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','p_city_name',COUNT(__d4(__NL(Postal_City_))),COUNT(__d4(__NN(Postal_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','v_city_name',COUNT(__d4(__NL(Vanity_City_))),COUNT(__d4(__NN(Vanity_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d4(__NL(State_))),COUNT(__d4(__NN(State_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d4(__NL(Z_I_P5_))),COUNT(__d4(__NN(Z_I_P5_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip4',COUNT(__d4(__NL(Z_I_P4_))),COUNT(__d4(__NN(Z_I_P4_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AppendRawAID',COUNT(__d4(__NL(Append_Raw_A_I_D_))),COUNT(__d4(__NN(Append_Raw_A_I_D_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteNumber',COUNT(__d4(__NL(Carrier_Route_Number_))),COUNT(__d4(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteSortationAtZIP',COUNT(__d4(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d4(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravel',COUNT(__d4(__NL(Line_Of_Travel_))),COUNT(__d4(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravelOrder',COUNT(__d4(__NL(Line_Of_Travel_Order_))),COUNT(__d4(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcode',COUNT(__d4(__NL(Delivery_Point_Barcode_))),COUNT(__d4(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcodeCheckDigit',COUNT(__d4(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d4(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeCode',COUNT(__d4(__NL(Type_Code_))),COUNT(__d4(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','County',COUNT(__d4(__NL(County_))),COUNT(__d4(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Latitude',COUNT(__d4(__NL(Latitude_))),COUNT(__d4(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Longitude',COUNT(__d4(__NL(Longitude_))),COUNT(__d4(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d4(__NL(Metropolitan_Statistical_Area_))),COUNT(__d4(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoBlock',COUNT(__d4(__NL(Geo_Block_))),COUNT(__d4(__NN(Geo_Block_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoMatch',COUNT(__d4(__NL(Geo_Match_))),COUNT(__d4(__NN(Geo_Match_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ACECleanerErrorCode',COUNT(__d4(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d4(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateFirstSeen',COUNT(__d4(__NL(A_D_V_O_Date_First_Seen_))),COUNT(__d4(__NN(A_D_V_O_Date_First_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateLastSeen',COUNT(__d4(__NL(A_D_V_O_Date_Last_Seen_))),COUNT(__d4(__NN(A_D_V_O_Date_Last_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorFirstReported',COUNT(__d4(__NL(A_D_V_O_Date_Vendor_First_Reported_))),COUNT(__d4(__NN(A_D_V_O_Date_Vendor_First_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorLastReported',COUNT(__d4(__NL(A_D_V_O_Date_Vendor_Last_Reported_))),COUNT(__d4(__NN(A_D_V_O_Date_Vendor_Last_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacancyIndicator',COUNT(__d4(__NL(Vacancy_Indicator_))),COUNT(__d4(__NN(Vacancy_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThrowBackIndicator',COUNT(__d4(__NL(Throw_Back_Indicator_))),COUNT(__d4(__NN(Throw_Back_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalDeliveryIndicator',COUNT(__d4(__NL(Seasonal_Delivery_Indicator_))),COUNT(__d4(__NN(Seasonal_Delivery_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalStartSuppressionDate',COUNT(__d4(__NL(Seasonal_Start_Suppression_Date_))),COUNT(__d4(__NN(Seasonal_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalEndSuppressionDate',COUNT(__d4(__NL(Seasonal_End_Suppression_Date_))),COUNT(__d4(__NN(Seasonal_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotDeliverIndicator',COUNT(__d4(__NL(Do_Not_Deliver_Indicator_))),COUNT(__d4(__NN(Do_Not_Deliver_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotMailIndicator',COUNT(__d4(__NL(Do_Not_Mail_Indicator_))),COUNT(__d4(__NN(Do_Not_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeadCOIndicator',COUNT(__d4(__NL(Dead_C_O_Indicator_))),COUNT(__d4(__NN(Dead_C_O_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeIndicator',COUNT(__d4(__NL(College_Indicator_))),COUNT(__d4(__NN(College_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeStartSuppressionDate',COUNT(__d4(__NL(College_Start_Suppression_Date_))),COUNT(__d4(__NN(College_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeEndSuppressionDate',COUNT(__d4(__NL(College_End_Suppression_Date_))),COUNT(__d4(__NN(College_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StyleCode',COUNT(__d4(__NL(Style_Code_))),COUNT(__d4(__NN(Style_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SimplifyCount',COUNT(__d4(__NL(Simplify_Count_))),COUNT(__d4(__NN(Simplify_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DropIndicator',COUNT(__d4(__NL(Drop_Indicator_))),COUNT(__d4(__NN(Drop_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ResidentialOrBusinessIndicator',COUNT(__d4(__NL(Residential_Or_Business_Indicator_))),COUNT(__d4(__NN(Residential_Or_Business_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OnlyWayToGetMailIndicator',COUNT(__d4(__NL(Only_Way_To_Get_Mail_Indicator_))),COUNT(__d4(__NN(Only_Way_To_Get_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordTypeCode',COUNT(__d4(__NL(Record_Type_Code_))),COUNT(__d4(__NN(Record_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeCode',COUNT(__d4(__NL(Address_Type_Code_))),COUNT(__d4(__NN(Address_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MixedUsageCode',COUNT(__d4(__NL(Mixed_Usage_Code_))),COUNT(__d4(__NN(Mixed_Usage_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationBeginDate',COUNT(__d4(__NL(Vacation_Begin_Date_))),COUNT(__d4(__NN(Vacation_Begin_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationEndDate',COUNT(__d4(__NL(Vacation_End_Date_))),COUNT(__d4(__NN(Vacation_End_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfCurrentVacationMonths',COUNT(__d4(__NL(Number_Of_Current_Vacation_Months_))),COUNT(__d4(__NN(Number_Of_Current_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaxVacationMonths',COUNT(__d4(__NL(Max_Vacation_Months_))),COUNT(__d4(__NN(Max_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationPeriodsCount',COUNT(__d4(__NL(Vacation_Periods_Count_))),COUNT(__d4(__NN(Vacation_Periods_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d4(__NL(Company_Address_Type_Raw_))),COUNT(__d4(__NN(Company_Address_Type_Raw_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d4(__NL(Company_Address_Type_Derived_))),COUNT(__d4(__NN(Company_Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d4(__NL(Address_Type_Derived_))),COUNT(__d4(__NN(Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressMethod',COUNT(__d4(__NL(Address_Method_))),COUNT(__d4(__NN(Address_Method_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d4(__NL(Is_Active_))),COUNT(__d4(__NN(Is_Active_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDefunct',COUNT(__d4(__NL(Is_Defunct_))),COUNT(__d4(__NN(Is_Defunct_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Type',COUNT(__d4(__NL(Address___Type_))),COUNT(__d4(__NN(Address___Type_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Desc',COUNT(__d4(__NL(Address___Desc_))),COUNT(__d4(__NN(Address___Desc_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d4(__NL(Header_Hit_Flag_))),COUNT(__d4(__NN(Header_Hit_Flag_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FDNIndicator',COUNT(__d4(__NL(F_D_N_Indicator_))),COUNT(__d4(__NN(F_D_N_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskSIC',COUNT(__d4(__NL(High_Risk_S_I_C_))),COUNT(__d4(__NN(High_Risk_S_I_C_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskNAICS',COUNT(__d4(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d4(__NN(High_Risk_N_A_I_C_S_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d4(Date_Vendor_First_Reported_=0)),COUNT(__d4(Date_Vendor_First_Reported_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d4(Date_Vendor_Last_Reported_=0)),COUNT(__d4(Date_Vendor_Last_Reported_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Address_Invalid),COUNT(__d5)},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d5(__NL(Primary_Range_))),COUNT(__d5(__NN(Primary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d5(__NL(Predirectional_))),COUNT(__d5(__NN(Predirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d5(__NL(Primary_Name_))),COUNT(__d5(__NN(Primary_Name_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d5(__NL(Suffix_))),COUNT(__d5(__NN(Suffix_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d5(__NL(Postdirectional_))),COUNT(__d5(__NN(Postdirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','unit_desig',COUNT(__d5(__NL(Unit_Designation_))),COUNT(__d5(__NN(Unit_Designation_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d5(__NL(Secondary_Range_))),COUNT(__d5(__NN(Secondary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','city_name',COUNT(__d5(__NL(Postal_City_))),COUNT(__d5(__NN(Postal_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VanityCity',COUNT(__d5(__NL(Vanity_City_))),COUNT(__d5(__NN(Vanity_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d5(__NL(State_))),COUNT(__d5(__NN(State_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d5(__NL(Z_I_P5_))),COUNT(__d5(__NN(Z_I_P5_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZIP4',COUNT(__d5(__NL(Z_I_P4_))),COUNT(__d5(__NN(Z_I_P4_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AppendRawAID',COUNT(__d5(__NL(Append_Raw_A_I_D_))),COUNT(__d5(__NN(Append_Raw_A_I_D_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteNumber',COUNT(__d5(__NL(Carrier_Route_Number_))),COUNT(__d5(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteSortationAtZIP',COUNT(__d5(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d5(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravel',COUNT(__d5(__NL(Line_Of_Travel_))),COUNT(__d5(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravelOrder',COUNT(__d5(__NL(Line_Of_Travel_Order_))),COUNT(__d5(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcode',COUNT(__d5(__NL(Delivery_Point_Barcode_))),COUNT(__d5(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcodeCheckDigit',COUNT(__d5(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d5(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeCode',COUNT(__d5(__NL(Type_Code_))),COUNT(__d5(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','county',COUNT(__d5(__NL(County_))),COUNT(__d5(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Latitude',COUNT(__d5(__NL(Latitude_))),COUNT(__d5(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Longitude',COUNT(__d5(__NL(Longitude_))),COUNT(__d5(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d5(__NL(Metropolitan_Statistical_Area_))),COUNT(__d5(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_blk',COUNT(__d5(__NL(Geo_Block_))),COUNT(__d5(__NN(Geo_Block_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoMatch',COUNT(__d5(__NL(Geo_Match_))),COUNT(__d5(__NN(Geo_Match_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ACECleanerErrorCode',COUNT(__d5(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d5(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateFirstSeen',COUNT(__d5(__NL(A_D_V_O_Date_First_Seen_))),COUNT(__d5(__NN(A_D_V_O_Date_First_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateLastSeen',COUNT(__d5(__NL(A_D_V_O_Date_Last_Seen_))),COUNT(__d5(__NN(A_D_V_O_Date_Last_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorFirstReported',COUNT(__d5(__NL(A_D_V_O_Date_Vendor_First_Reported_))),COUNT(__d5(__NN(A_D_V_O_Date_Vendor_First_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorLastReported',COUNT(__d5(__NL(A_D_V_O_Date_Vendor_Last_Reported_))),COUNT(__d5(__NN(A_D_V_O_Date_Vendor_Last_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacancyIndicator',COUNT(__d5(__NL(Vacancy_Indicator_))),COUNT(__d5(__NN(Vacancy_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThrowBackIndicator',COUNT(__d5(__NL(Throw_Back_Indicator_))),COUNT(__d5(__NN(Throw_Back_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalDeliveryIndicator',COUNT(__d5(__NL(Seasonal_Delivery_Indicator_))),COUNT(__d5(__NN(Seasonal_Delivery_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalStartSuppressionDate',COUNT(__d5(__NL(Seasonal_Start_Suppression_Date_))),COUNT(__d5(__NN(Seasonal_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalEndSuppressionDate',COUNT(__d5(__NL(Seasonal_End_Suppression_Date_))),COUNT(__d5(__NN(Seasonal_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotDeliverIndicator',COUNT(__d5(__NL(Do_Not_Deliver_Indicator_))),COUNT(__d5(__NN(Do_Not_Deliver_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotMailIndicator',COUNT(__d5(__NL(Do_Not_Mail_Indicator_))),COUNT(__d5(__NN(Do_Not_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeadCOIndicator',COUNT(__d5(__NL(Dead_C_O_Indicator_))),COUNT(__d5(__NN(Dead_C_O_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HotListIndicator',COUNT(__d5(__NL(Hot_List_Indicator_))),COUNT(__d5(__NN(Hot_List_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeIndicator',COUNT(__d5(__NL(College_Indicator_))),COUNT(__d5(__NN(College_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeStartSuppressionDate',COUNT(__d5(__NL(College_Start_Suppression_Date_))),COUNT(__d5(__NN(College_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeEndSuppressionDate',COUNT(__d5(__NL(College_End_Suppression_Date_))),COUNT(__d5(__NN(College_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StyleCode',COUNT(__d5(__NL(Style_Code_))),COUNT(__d5(__NN(Style_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SimplifyCount',COUNT(__d5(__NL(Simplify_Count_))),COUNT(__d5(__NN(Simplify_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DropIndicator',COUNT(__d5(__NL(Drop_Indicator_))),COUNT(__d5(__NN(Drop_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ResidentialOrBusinessIndicator',COUNT(__d5(__NL(Residential_Or_Business_Indicator_))),COUNT(__d5(__NN(Residential_Or_Business_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OnlyWayToGetMailIndicator',COUNT(__d5(__NL(Only_Way_To_Get_Mail_Indicator_))),COUNT(__d5(__NN(Only_Way_To_Get_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordTypeCode',COUNT(__d5(__NL(Record_Type_Code_))),COUNT(__d5(__NN(Record_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeCode',COUNT(__d5(__NL(Address_Type_Code_))),COUNT(__d5(__NN(Address_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MixedUsageCode',COUNT(__d5(__NL(Mixed_Usage_Code_))),COUNT(__d5(__NN(Mixed_Usage_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationBeginDate',COUNT(__d5(__NL(Vacation_Begin_Date_))),COUNT(__d5(__NN(Vacation_Begin_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationEndDate',COUNT(__d5(__NL(Vacation_End_Date_))),COUNT(__d5(__NN(Vacation_End_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfCurrentVacationMonths',COUNT(__d5(__NL(Number_Of_Current_Vacation_Months_))),COUNT(__d5(__NN(Number_Of_Current_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaxVacationMonths',COUNT(__d5(__NL(Max_Vacation_Months_))),COUNT(__d5(__NN(Max_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationPeriodsCount',COUNT(__d5(__NL(Vacation_Periods_Count_))),COUNT(__d5(__NN(Vacation_Periods_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d5(__NL(Company_Address_Type_Raw_))),COUNT(__d5(__NN(Company_Address_Type_Raw_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d5(__NL(Company_Address_Type_Derived_))),COUNT(__d5(__NN(Company_Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d5(__NL(Address_Type_Derived_))),COUNT(__d5(__NN(Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressMethod',COUNT(__d5(__NL(Address_Method_))),COUNT(__d5(__NN(Address_Method_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d5(__NL(Is_Active_))),COUNT(__d5(__NN(Is_Active_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDefunct',COUNT(__d5(__NL(Is_Defunct_))),COUNT(__d5(__NN(Is_Defunct_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Type',COUNT(__d5(__NL(Address___Type_))),COUNT(__d5(__NN(Address___Type_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Desc',COUNT(__d5(__NL(Address___Desc_))),COUNT(__d5(__NN(Address___Desc_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FDNIndicator',COUNT(__d5(__NL(F_D_N_Indicator_))),COUNT(__d5(__NN(F_D_N_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskSIC',COUNT(__d5(__NL(High_Risk_S_I_C_))),COUNT(__d5(__NN(High_Risk_S_I_C_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HighRiskNAICS',COUNT(__d5(__NL(High_Risk_N_A_I_C_S_))),COUNT(__d5(__NN(High_Risk_N_A_I_C_S_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d5(Date_Vendor_First_Reported_=0)),COUNT(__d5(Date_Vendor_First_Reported_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d5(Date_Vendor_Last_Reported_=0)),COUNT(__d5(Date_Vendor_Last_Reported_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
