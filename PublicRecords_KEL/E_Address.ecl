//HPCC Systems KEL Compiler Version 1.1.0beta2
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
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(DEFAULT:UID),primaryrange(DEFAULT:Primary_Range_),predirectional(DEFAULT:Predirectional_),primaryname(DEFAULT:Primary_Name_),suffix(DEFAULT:Suffix_),postdirectional(DEFAULT:Postdirectional_),unitdesignation(DEFAULT:Unit_Designation_),secondaryrange(DEFAULT:Secondary_Range_),postalcity(DEFAULT:Postal_City_),vanitycity(DEFAULT:Vanity_City_),state(DEFAULT:State_),zip5(DEFAULT:Z_I_P5_:0),zip4(DEFAULT:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),carrierroutenumber(DEFAULT:Carrier_Route_Number_),carrierroutesortationatzip(DEFAULT:Carrier_Route_Sortation_At_Z_I_P_),lineoftravel(DEFAULT:Line_Of_Travel_),lineoftravelorder(DEFAULT:Line_Of_Travel_Order_),deliverypointbarcode(DEFAULT:Delivery_Point_Barcode_),deliverypointbarcodecheckdigit(DEFAULT:Delivery_Point_Barcode_Check_Digit_),typecode(DEFAULT:Type_Code_),county(DEFAULT:County_),latitude(DEFAULT:Latitude_),longitude(DEFAULT:Longitude_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),geoblock(DEFAULT:Geo_Block_),geomatch(DEFAULT:Geo_Match_),acecleanererrorcode(DEFAULT:A_C_E_Cleaner_Error_Code_),advodatefirstseen(DEFAULT:A_D_V_O_Date_First_Seen_:DATE),advodatelastseen(DEFAULT:A_D_V_O_Date_Last_Seen_:DATE),advodatevendorfirstreported(DEFAULT:A_D_V_O_Date_Vendor_First_Reported_:DATE),advodatevendorlastreported(DEFAULT:A_D_V_O_Date_Vendor_Last_Reported_:DATE),vacancyindicator(DEFAULT:Vacancy_Indicator_),throwbackindicator(DEFAULT:Throw_Back_Indicator_),seasonaldeliveryindicator(DEFAULT:Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(DEFAULT:Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(DEFAULT:Seasonal_End_Suppression_Date_),donotdeliverindicator(DEFAULT:Do_Not_Deliver_Indicator_),donotmailindicator(DEFAULT:Do_Not_Mail_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),hotlistindicator(DEFAULT:Hot_List_Indicator_),collegeindicator(DEFAULT:College_Indicator_),collegestartsuppressiondate(DEFAULT:College_Start_Suppression_Date_),collegeendsuppressiondate(DEFAULT:College_End_Suppression_Date_),stylecode(DEFAULT:Style_Code_),simplifycount(DEFAULT:Simplify_Count_),dropindicator(DEFAULT:Drop_Indicator_),residentialorbusinessindicator(DEFAULT:Residential_Or_Business_Indicator_),onlywaytogetmailindicator(DEFAULT:Only_Way_To_Get_Mail_Indicator_),recordtypecode(DEFAULT:Record_Type_Code_),addresstypecode(DEFAULT:Address_Type_Code_),mixedusagecode(DEFAULT:Mixed_Usage_Code_),vacationbegindate(DEFAULT:Vacation_Begin_Date_:DATE),vacationenddate(DEFAULT:Vacation_End_Date_:DATE),numberofcurrentvacationmonths(DEFAULT:Number_Of_Current_Vacation_Months_),maxvacationmonths(DEFAULT:Max_Vacation_Months_),vacationperiodscount(DEFAULT:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),address_type(DEFAULT:Address___Type_:\'\'),address_desc(DEFAULT:Address___Desc_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := __in.Dataset_Doxie__Key_Header((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0);
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  SHARED __d1_KELfiltered := __in.Dataset_Header_Quick__Key_Did((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0);
  SHARED __d1_Trim := PROJECT(__d1_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  SHARED __d2_KELfiltered := __in.Dataset_BIPV2__Key_BH_Linking_kfetch2((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0);
  SHARED __d2_Trim := PROJECT(__d2_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  SHARED __d3_KELfiltered := __in.Dataset_ADVO__Key_Addr1((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0);
  SHARED __d3_Trim := PROJECT(__d3_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  SHARED __d4_KELfiltered := __in.Dataset_ADVO__Key_Addr1_History((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0);
  SHARED __d4_Trim := PROJECT(__d4_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  SHARED __d5_KELfiltered := __in.Dataset_DMA__Key_DNM_Name_Address((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0);
  SHARED __d5_Trim := PROJECT(__d5_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  SHARED __d6_KELfiltered := __in.Dataset_Fraudpoint3__Key_Address((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0);
  SHARED __d6_Trim := PROJECT(__d6_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  SHARED __d7_KELfiltered := __in.Dataset_Inquiry_AccLogs__Key_FCRA_DID(person_q.prim_range <> '' OR person_q.predir <> '' OR person_q.prim_name <> '' OR person_q.addr_suffix <> '' OR person_q.postdir <> '' OR person_q.sec_range <> '' OR person_q.zip5 <> '');
  SHARED __d7_Trim := PROJECT(__d7_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.person_q.prim_range) + '|' + TRIM((STRING)LEFT.person_q.predir) + '|' + TRIM((STRING)LEFT.person_q.prim_name) + '|' + TRIM((STRING)LEFT.person_q.addr_suffix) + '|' + TRIM((STRING)LEFT.person_q.postdir) + '|' + TRIM((STRING)LEFT.person_q.zip5) + '|' + TRIM((STRING)LEFT.person_q.sec_range)));
  SHARED __d8_KELfiltered := __in.Dataset_USPIS_HotList__key_addr_search_zip((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0);
  SHARED __d8_Trim := PROJECT(__d8_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  SHARED __d9_KELfiltered := __in.Dataset_UtilFile__Key_Address((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED)address_zip != 0);
  SHARED __d9_Trim := PROJECT(__d9_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  SHARED __d10_KELfiltered := __in.Dataset_UtilFile__Key_DID((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED)address_zip != 0);
  SHARED __d10_Trim := PROJECT(__d10_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  SHARED __d11_KELfiltered := __in.Dataset_DX_Email__Key_Email_Payload(clean_address.prim_range <> '' OR clean_address.predir <> '' OR clean_address.prim_name <> '' OR clean_address.addr_suffix <> '' OR
									 clean_address.postdir <> '' OR clean_address.sec_range <> '' OR clean_address.zip <> '');
  SHARED __d11_Trim := PROJECT(__d11_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.clean_address.prim_range) + '|' + TRIM((STRING)LEFT.clean_address.predir) + '|' + TRIM((STRING)LEFT.clean_address.prim_name) + '|' + TRIM((STRING)LEFT.clean_address.addr_suffix) + '|' + TRIM((STRING)LEFT.clean_address.postdir) + '|' + TRIM((STRING)LEFT.clean_address.zip) + '|' + TRIM((STRING)LEFT.clean_address.sec_range)));
  SHARED __d12_KELfiltered := __in.Dataset_Corp2__Kfetch_LinkIDs_Corp((STRING10)corp_addr1_prim_range != '' AND (STRING28)corp_addr1_prim_name != '' AND (UNSIGNED3)corp_addr1_zip5 != 0);
  SHARED __d12_Trim := PROJECT(__d12_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.corp_addr1_prim_range) + '|' + TRIM((STRING)LEFT.corp_addr1_predir) + '|' + TRIM((STRING)LEFT.corp_addr1_prim_name) + '|' + TRIM((STRING)LEFT.corp_addr1_addr_suffix) + '|' + TRIM((STRING)LEFT.corp_addr1_postdir) + '|' + TRIM((STRING)LEFT.corp_addr1_zip5) + '|' + TRIM((STRING)LEFT.corp_addr1_sec_range)));
  SHARED __d13_KELfiltered := __in.Dataset_Corp2__Kfetch_LinkIDs_Corp((STRING10)corp_addr2_prim_range != '' AND (STRING28)corp_addr2_prim_name != '' AND (UNSIGNED3)corp_addr2_zip5 != 0);
  SHARED __d13_Trim := PROJECT(__d13_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.corp_addr2_prim_range) + '|' + TRIM((STRING)LEFT.corp_addr2_predir) + '|' + TRIM((STRING)LEFT.corp_addr2_prim_name) + '|' + TRIM((STRING)LEFT.corp_addr2_addr_suffix) + '|' + TRIM((STRING)LEFT.corp_addr2_postdir) + '|' + TRIM((STRING)LEFT.corp_addr2_zip5) + '|' + TRIM((STRING)LEFT.corp_addr2_sec_range)));
  SHARED __d14_KELfiltered := __in.Dataset_Corp2__Kfetch_LinkIDs_Corp((STRING10)corp_ra_prim_range != '' AND (STRING28)corp_ra_prim_name != '' AND (UNSIGNED3)corp_ra_zip5 != 0);
  SHARED __d14_Trim := PROJECT(__d14_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.corp_ra_prim_range) + '|' + TRIM((STRING)LEFT.corp_ra_predir) + '|' + TRIM((STRING)LEFT.corp_ra_prim_name) + '|' + TRIM((STRING)LEFT.corp_ra_addr_suffix) + '|' + TRIM((STRING)LEFT.corp_ra_postdir) + '|' + TRIM((STRING)LEFT.corp_ra_zip5) + '|' + TRIM((STRING)LEFT.corp_ra_sec_range)));
  SHARED __d15_KELfiltered := __in.Dataset_InfoUSA__Key_DEADCO_LinkIds((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip5 != 0);
  SHARED __d15_Trim := PROJECT(__d15_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip5) + '|' + TRIM((STRING)LEFT.sec_range)));
  SHARED __d16_KELfiltered := __in.Dataset_UtilFile__Kfetch2_LinkIds((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0);
  SHARED __d16_Trim := PROJECT(__d16_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  SHARED __d17_KELfiltered := __in.Dataset_Doxie__Key_Header_Address((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0);
  SHARED __d17_Trim := PROJECT(__d17_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim + __d2_Trim + __d3_Trim + __d4_Trim + __d5_Trim + __d6_Trim + __d7_Trim + __d8_Trim + __d9_Trim + __d10_Trim + __d11_Trim + __d12_Trim + __d13_Trim + __d14_Trim + __d15_Trim + __d16_Trim + __d17_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  SHARED __Table := TABLE(__All_Trim,__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  EXPORT Lookup := PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED A_D_V_O_Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED A_D_V_O_Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED A_D_V_O_Date_Vendor_First_Reported_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED A_D_V_O_Date_Vendor_Last_Reported_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_),predir(OVERRIDE:Predirectional_),prim_name(OVERRIDE:Primary_Name_),suffix(OVERRIDE:Suffix_),postdir(OVERRIDE:Postdirectional_),unit_desig(OVERRIDE:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_),postalcity(DEFAULT:Postal_City_),vanitycity(DEFAULT:Vanity_City_),st(OVERRIDE:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(OVERRIDE:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),carrierroutenumber(DEFAULT:Carrier_Route_Number_),carrierroutesortationatzip(DEFAULT:Carrier_Route_Sortation_At_Z_I_P_),lineoftravel(DEFAULT:Line_Of_Travel_),lineoftravelorder(DEFAULT:Line_Of_Travel_Order_),deliverypointbarcode(DEFAULT:Delivery_Point_Barcode_),deliverypointbarcodecheckdigit(DEFAULT:Delivery_Point_Barcode_Check_Digit_),typecode(DEFAULT:Type_Code_),county(OVERRIDE:County_),latitude(DEFAULT:Latitude_),longitude(DEFAULT:Longitude_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),geo_blk(OVERRIDE:Geo_Block_),geomatch(DEFAULT:Geo_Match_),acecleanererrorcode(DEFAULT:A_C_E_Cleaner_Error_Code_),dt_first_seen(OVERRIDE:A_D_V_O_Date_First_Seen_:DATE:A_D_V_O_Date_First_Seen_0Rule|OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_0Rule),dt_last_seen(OVERRIDE:A_D_V_O_Date_Last_Seen_:DATE:A_D_V_O_Date_Last_Seen_0Rule|OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),dt_vendor_first_reported(OVERRIDE:A_D_V_O_Date_Vendor_First_Reported_:DATE:A_D_V_O_Date_Vendor_First_Reported_0Rule),dt_vendor_last_reported(OVERRIDE:A_D_V_O_Date_Vendor_Last_Reported_:DATE:A_D_V_O_Date_Vendor_Last_Reported_0Rule),vacancyindicator(DEFAULT:Vacancy_Indicator_),throwbackindicator(DEFAULT:Throw_Back_Indicator_),seasonaldeliveryindicator(DEFAULT:Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(DEFAULT:Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(DEFAULT:Seasonal_End_Suppression_Date_),donotdeliverindicator(DEFAULT:Do_Not_Deliver_Indicator_),donotmailindicator(DEFAULT:Do_Not_Mail_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),hotlistindicator(DEFAULT:Hot_List_Indicator_),collegeindicator(DEFAULT:College_Indicator_),collegestartsuppressiondate(DEFAULT:College_Start_Suppression_Date_),collegeendsuppressiondate(DEFAULT:College_End_Suppression_Date_),stylecode(DEFAULT:Style_Code_),simplifycount(DEFAULT:Simplify_Count_),dropindicator(DEFAULT:Drop_Indicator_),residentialorbusinessindicator(DEFAULT:Residential_Or_Business_Indicator_),onlywaytogetmailindicator(DEFAULT:Only_Way_To_Get_Mail_Indicator_),rec_type(OVERRIDE:Record_Type_Code_),addresstypecode(DEFAULT:Address_Type_Code_),mixedusagecode(DEFAULT:Mixed_Usage_Code_),vacationbegindate(DEFAULT:Vacation_Begin_Date_:DATE),vacationenddate(DEFAULT:Vacation_End_Date_:DATE),numberofcurrentvacationmonths(DEFAULT:Number_Of_Current_Vacation_Months_),maxvacationmonths(DEFAULT:Max_Vacation_Months_),vacationperiodscount(DEFAULT:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),address_type(DEFAULT:Address___Type_:\'\'),address_desc(DEFAULT:Address___Desc_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Header,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Header),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Doxie__Key_Header);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED A_D_V_O_Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED A_D_V_O_Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED A_D_V_O_Date_Vendor_First_Reported_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED A_D_V_O_Date_Vendor_Last_Reported_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_),predir(OVERRIDE:Predirectional_),prim_name(OVERRIDE:Primary_Name_),suffix(OVERRIDE:Suffix_),postdir(OVERRIDE:Postdirectional_),unit_desig(OVERRIDE:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_),postalcity(DEFAULT:Postal_City_),vanitycity(DEFAULT:Vanity_City_),st(OVERRIDE:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(OVERRIDE:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),carrierroutenumber(DEFAULT:Carrier_Route_Number_),carrierroutesortationatzip(DEFAULT:Carrier_Route_Sortation_At_Z_I_P_),lineoftravel(DEFAULT:Line_Of_Travel_),lineoftravelorder(DEFAULT:Line_Of_Travel_Order_),deliverypointbarcode(DEFAULT:Delivery_Point_Barcode_),deliverypointbarcodecheckdigit(DEFAULT:Delivery_Point_Barcode_Check_Digit_),typecode(DEFAULT:Type_Code_),county(OVERRIDE:County_),latitude(DEFAULT:Latitude_),longitude(DEFAULT:Longitude_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),geo_blk(OVERRIDE:Geo_Block_),geomatch(DEFAULT:Geo_Match_),acecleanererrorcode(DEFAULT:A_C_E_Cleaner_Error_Code_),dt_first_seen(OVERRIDE:A_D_V_O_Date_First_Seen_:DATE:A_D_V_O_Date_First_Seen_1Rule|OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_1Rule),dt_last_seen(OVERRIDE:A_D_V_O_Date_Last_Seen_:DATE:A_D_V_O_Date_Last_Seen_1Rule|OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),dt_vendor_first_reported(OVERRIDE:A_D_V_O_Date_Vendor_First_Reported_:DATE:A_D_V_O_Date_Vendor_First_Reported_1Rule),dt_vendor_last_reported(OVERRIDE:A_D_V_O_Date_Vendor_Last_Reported_:DATE:A_D_V_O_Date_Vendor_Last_Reported_1Rule),vacancyindicator(DEFAULT:Vacancy_Indicator_),throwbackindicator(DEFAULT:Throw_Back_Indicator_),seasonaldeliveryindicator(DEFAULT:Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(DEFAULT:Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(DEFAULT:Seasonal_End_Suppression_Date_),donotdeliverindicator(DEFAULT:Do_Not_Deliver_Indicator_),donotmailindicator(DEFAULT:Do_Not_Mail_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),hotlistindicator(DEFAULT:Hot_List_Indicator_),collegeindicator(DEFAULT:College_Indicator_),collegestartsuppressiondate(DEFAULT:College_Start_Suppression_Date_),collegeendsuppressiondate(DEFAULT:College_End_Suppression_Date_),stylecode(DEFAULT:Style_Code_),simplifycount(DEFAULT:Simplify_Count_),dropindicator(DEFAULT:Drop_Indicator_),residentialorbusinessindicator(DEFAULT:Residential_Or_Business_Indicator_),onlywaytogetmailindicator(DEFAULT:Only_Way_To_Get_Mail_Indicator_),rec_type(OVERRIDE:Record_Type_Code_),addresstypecode(DEFAULT:Address_Type_Code_),mixedusagecode(DEFAULT:Mixed_Usage_Code_),vacationbegindate(DEFAULT:Vacation_Begin_Date_:DATE),vacationenddate(DEFAULT:Vacation_End_Date_:DATE),numberofcurrentvacationmonths(DEFAULT:Number_Of_Current_Vacation_Months_),maxvacationmonths(DEFAULT:Max_Vacation_Months_),vacationperiodscount(DEFAULT:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),address_type(DEFAULT:Address___Type_:\'\'),address_desc(DEFAULT:Address___Desc_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Header_Quick__Key_Did,TRANSFORM(RECORDOF(__in.Dataset_Header_Quick__Key_Did),SELF:=RIGHT));
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Header_Quick__Key_Did);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping2 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_),predir(OVERRIDE:Predirectional_),prim_name(OVERRIDE:Primary_Name_),addr_suffix(OVERRIDE:Suffix_),postdir(OVERRIDE:Postdirectional_),unit_desig(OVERRIDE:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_),p_city_name(OVERRIDE:Postal_City_),v_city_name(OVERRIDE:Vanity_City_),st(OVERRIDE:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(OVERRIDE:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),carrierroutenumber(DEFAULT:Carrier_Route_Number_),carrierroutesortationatzip(DEFAULT:Carrier_Route_Sortation_At_Z_I_P_),lineoftravel(DEFAULT:Line_Of_Travel_),lineoftravelorder(DEFAULT:Line_Of_Travel_Order_),deliverypointbarcode(DEFAULT:Delivery_Point_Barcode_),deliverypointbarcodecheckdigit(DEFAULT:Delivery_Point_Barcode_Check_Digit_),typecode(DEFAULT:Type_Code_),county(DEFAULT:County_),latitude(DEFAULT:Latitude_),longitude(DEFAULT:Longitude_),msa(OVERRIDE:Metropolitan_Statistical_Area_),geoblock(DEFAULT:Geo_Block_),geomatch(DEFAULT:Geo_Match_),acecleanererrorcode(DEFAULT:A_C_E_Cleaner_Error_Code_),advodatefirstseen(DEFAULT:A_D_V_O_Date_First_Seen_:DATE),advodatelastseen(DEFAULT:A_D_V_O_Date_Last_Seen_:DATE),advodatevendorfirstreported(DEFAULT:A_D_V_O_Date_Vendor_First_Reported_:DATE),advodatevendorlastreported(DEFAULT:A_D_V_O_Date_Vendor_Last_Reported_:DATE),vacancyindicator(DEFAULT:Vacancy_Indicator_),throwbackindicator(DEFAULT:Throw_Back_Indicator_),seasonaldeliveryindicator(DEFAULT:Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(DEFAULT:Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(DEFAULT:Seasonal_End_Suppression_Date_),donotdeliverindicator(DEFAULT:Do_Not_Deliver_Indicator_),donotmailindicator(DEFAULT:Do_Not_Mail_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),hotlistindicator(DEFAULT:Hot_List_Indicator_),collegeindicator(DEFAULT:College_Indicator_),collegestartsuppressiondate(DEFAULT:College_Start_Suppression_Date_),collegeendsuppressiondate(DEFAULT:College_End_Suppression_Date_),stylecode(DEFAULT:Style_Code_),simplifycount(DEFAULT:Simplify_Count_),dropindicator(DEFAULT:Drop_Indicator_),residentialorbusinessindicator(DEFAULT:Residential_Or_Business_Indicator_),onlywaytogetmailindicator(DEFAULT:Only_Way_To_Get_Mail_Indicator_),recordtypecode(DEFAULT:Record_Type_Code_),addresstypecode(DEFAULT:Address_Type_Code_),mixedusagecode(DEFAULT:Mixed_Usage_Code_),vacationbegindate(DEFAULT:Vacation_Begin_Date_:DATE),vacationenddate(DEFAULT:Vacation_End_Date_:DATE),numberofcurrentvacationmonths(DEFAULT:Number_Of_Current_Vacation_Months_),maxvacationmonths(DEFAULT:Max_Vacation_Months_),vacationperiodscount(DEFAULT:Vacation_Periods_Count_),company_address_type_raw(OVERRIDE:Company_Address_Type_Raw_:\'\'),company_address_type_derived(OVERRIDE:Company_Address_Type_Derived_:\'\'),address_type_derived(OVERRIDE:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),address_type(DEFAULT:Address___Type_:\'\'),address_desc(DEFAULT:Address___Desc_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),source(OVERRIDE:Source_:\'\'),dt_last_seen_company_address(OVERRIDE:Date_First_Seen_:EPOCH),dt_first_seen_company_address(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_kfetch2,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_kfetch2),SELF:=RIGHT));
  SHARED __d2_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_BIPV2__Key_BH_Linking_kfetch2);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d2_UID_Mapped := JOIN(__d2_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d2_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2__Key_BH_Linking_kfetch2_Invalid := __d2_UID_Mapped(UID = 0);
  SHARED __d2_Prefiltered := __d2_UID_Mapped(UID <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping3 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_),predir(OVERRIDE:Predirectional_),prim_name(OVERRIDE:Primary_Name_),addr_suffix(OVERRIDE:Suffix_),postdir(OVERRIDE:Postdirectional_),unit_desig(OVERRIDE:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_),p_city_name(OVERRIDE:Postal_City_),v_city_name(OVERRIDE:Vanity_City_),st(OVERRIDE:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(OVERRIDE:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),cart(OVERRIDE:Carrier_Route_Number_),cr_sort_sz(OVERRIDE:Carrier_Route_Sortation_At_Z_I_P_),lot(OVERRIDE:Line_Of_Travel_),lot_order(OVERRIDE:Line_Of_Travel_Order_),dbpc(OVERRIDE:Delivery_Point_Barcode_),chk_digit(OVERRIDE:Delivery_Point_Barcode_Check_Digit_),rec_type(OVERRIDE:Type_Code_),county(OVERRIDE:County_),geo_lat(OVERRIDE:Latitude_),geo_long(OVERRIDE:Longitude_),msa(OVERRIDE:Metropolitan_Statistical_Area_),geo_blk(OVERRIDE:Geo_Block_),geo_match(OVERRIDE:Geo_Match_),err_stat(OVERRIDE:A_C_E_Cleaner_Error_Code_),date_first_seen(OVERRIDE:A_D_V_O_Date_First_Seen_:DATE|OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:A_D_V_O_Date_Last_Seen_:DATE|OVERRIDE:Date_Last_Seen_:EPOCH),date_vendor_first_reported(OVERRIDE:A_D_V_O_Date_Vendor_First_Reported_:DATE),date_vendor_last_reported(OVERRIDE:A_D_V_O_Date_Vendor_Last_Reported_:DATE),address_vacancy_indicator(OVERRIDE:Vacancy_Indicator_),throw_back_indicator(OVERRIDE:Throw_Back_Indicator_),seasonal_delivery_indicator(OVERRIDE:Seasonal_Delivery_Indicator_),seasonal_start_suppression_date(OVERRIDE:Seasonal_Start_Suppression_Date_),seasonal_end_suppression_date(OVERRIDE:Seasonal_End_Suppression_Date_),dnd_indicator(OVERRIDE:Do_Not_Deliver_Indicator_),donotmailindicator(DEFAULT:Do_Not_Mail_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),hotlistindicator(DEFAULT:Hot_List_Indicator_),college_indicator(OVERRIDE:College_Indicator_),college_start_suppression_date(OVERRIDE:College_Start_Suppression_Date_),college_end_suppression_date(OVERRIDE:College_End_Suppression_Date_),address_style_flag(OVERRIDE:Style_Code_),simplify_address_count(OVERRIDE:Simplify_Count_),drop_indicator(OVERRIDE:Drop_Indicator_),residential_or_business_ind(OVERRIDE:Residential_Or_Business_Indicator_),owgm_indicator(OVERRIDE:Only_Way_To_Get_Mail_Indicator_),record_type_code(OVERRIDE:Record_Type_Code_),address_type(OVERRIDE:Address_Type_Code_|DEFAULT:Address___Type_:\'\'),mixed_address_usage(OVERRIDE:Mixed_Usage_Code_),vac_begdt(OVERRIDE:Vacation_Begin_Date_:DATE),vac_enddt(OVERRIDE:Vacation_End_Date_:DATE),months_vac_curr(OVERRIDE:Number_Of_Current_Vacation_Months_),months_vac_max(OVERRIDE:Max_Vacation_Months_),vac_count(OVERRIDE:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),address_desc(DEFAULT:Address___Desc_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_ADVO__Key_Addr1,TRANSFORM(RECORDOF(__in.Dataset_ADVO__Key_Addr1),SELF:=RIGHT));
  SHARED __d3_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_ADVO__Key_Addr1);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d3_UID_Mapped := JOIN(__d3_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d3_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_ADVO__Key_Addr1_Invalid := __d3_UID_Mapped(UID = 0);
  SHARED __d3_Prefiltered := __d3_UID_Mapped(UID <> 0);
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping4 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_),predir(OVERRIDE:Predirectional_),prim_name(OVERRIDE:Primary_Name_),addr_suffix(OVERRIDE:Suffix_),postdir(OVERRIDE:Postdirectional_),unit_desig(OVERRIDE:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_),p_city_name(OVERRIDE:Postal_City_),v_city_name(OVERRIDE:Vanity_City_),st(OVERRIDE:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(OVERRIDE:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),cart(OVERRIDE:Carrier_Route_Number_),cr_sort_sz(OVERRIDE:Carrier_Route_Sortation_At_Z_I_P_),lot(OVERRIDE:Line_Of_Travel_),lot_order(OVERRIDE:Line_Of_Travel_Order_),dbpc(OVERRIDE:Delivery_Point_Barcode_),chk_digit(OVERRIDE:Delivery_Point_Barcode_Check_Digit_),rec_type(OVERRIDE:Type_Code_),county(OVERRIDE:County_),geo_lat(OVERRIDE:Latitude_),geo_long(OVERRIDE:Longitude_),msa(OVERRIDE:Metropolitan_Statistical_Area_),geo_blk(OVERRIDE:Geo_Block_),geo_match(OVERRIDE:Geo_Match_),err_stat(OVERRIDE:A_C_E_Cleaner_Error_Code_),date_first_seen(OVERRIDE:A_D_V_O_Date_First_Seen_:DATE|OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:A_D_V_O_Date_Last_Seen_:DATE|OVERRIDE:Date_Last_Seen_:EPOCH),date_vendor_first_reported(OVERRIDE:A_D_V_O_Date_Vendor_First_Reported_:DATE),date_vendor_last_reported(OVERRIDE:A_D_V_O_Date_Vendor_Last_Reported_:DATE),address_vacancy_indicator(OVERRIDE:Vacancy_Indicator_),throw_back_indicator(OVERRIDE:Throw_Back_Indicator_),seasonal_delivery_indicator(OVERRIDE:Seasonal_Delivery_Indicator_),seasonal_start_suppression_date(OVERRIDE:Seasonal_Start_Suppression_Date_),seasonal_end_suppression_date(OVERRIDE:Seasonal_End_Suppression_Date_),dnd_indicator(OVERRIDE:Do_Not_Deliver_Indicator_),donotmailindicator(DEFAULT:Do_Not_Mail_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),hotlistindicator(DEFAULT:Hot_List_Indicator_),college_indicator(OVERRIDE:College_Indicator_),college_start_suppression_date(OVERRIDE:College_Start_Suppression_Date_),college_end_suppression_date(OVERRIDE:College_End_Suppression_Date_),address_style_flag(OVERRIDE:Style_Code_),simplify_address_count(OVERRIDE:Simplify_Count_),drop_indicator(OVERRIDE:Drop_Indicator_),residential_or_business_ind(OVERRIDE:Residential_Or_Business_Indicator_),owgm_indicator(OVERRIDE:Only_Way_To_Get_Mail_Indicator_),record_type_code(OVERRIDE:Record_Type_Code_),address_type(OVERRIDE:Address_Type_Code_|DEFAULT:Address___Type_:\'\'),mixed_address_usage(OVERRIDE:Mixed_Usage_Code_),vac_begdt(OVERRIDE:Vacation_Begin_Date_:DATE),vac_enddt(OVERRIDE:Vacation_End_Date_:DATE),months_vac_curr(OVERRIDE:Number_Of_Current_Vacation_Months_),months_vac_max(OVERRIDE:Max_Vacation_Months_),vac_count(OVERRIDE:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),address_desc(DEFAULT:Address___Desc_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),source(DEFAULT:Source_:\'\'),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_ADVO__Key_Addr1_History,TRANSFORM(RECORDOF(__in.Dataset_ADVO__Key_Addr1_History),SELF:=RIGHT));
  SHARED __d4_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_ADVO__Key_Addr1_History);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d4_UID_Mapped := JOIN(__d4_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d4_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_ADVO__Key_Addr1_History_Invalid := __d4_UID_Mapped(UID = 0);
  SHARED __d4_Prefiltered := __d4_UID_Mapped(UID <> 0);
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping5 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_),predir(OVERRIDE:Predirectional_),prim_name(OVERRIDE:Primary_Name_),addr_suffix(OVERRIDE:Suffix_),postdir(OVERRIDE:Postdirectional_),unit_desig(OVERRIDE:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_),p_city_name(OVERRIDE:Postal_City_),v_city_name(OVERRIDE:Vanity_City_),st(OVERRIDE:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(OVERRIDE:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),carrierroutenumber(DEFAULT:Carrier_Route_Number_),carrierroutesortationatzip(DEFAULT:Carrier_Route_Sortation_At_Z_I_P_),lineoftravel(DEFAULT:Line_Of_Travel_),lineoftravelorder(DEFAULT:Line_Of_Travel_Order_),deliverypointbarcode(DEFAULT:Delivery_Point_Barcode_),deliverypointbarcodecheckdigit(DEFAULT:Delivery_Point_Barcode_Check_Digit_),typecode(DEFAULT:Type_Code_),county(DEFAULT:County_),latitude(DEFAULT:Latitude_),longitude(DEFAULT:Longitude_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),geoblock(DEFAULT:Geo_Block_),geomatch(DEFAULT:Geo_Match_),acecleanererrorcode(DEFAULT:A_C_E_Cleaner_Error_Code_),advodatefirstseen(DEFAULT:A_D_V_O_Date_First_Seen_:DATE),advodatelastseen(DEFAULT:A_D_V_O_Date_Last_Seen_:DATE),advodatevendorfirstreported(DEFAULT:A_D_V_O_Date_Vendor_First_Reported_:DATE),advodatevendorlastreported(DEFAULT:A_D_V_O_Date_Vendor_Last_Reported_:DATE),vacancyindicator(DEFAULT:Vacancy_Indicator_),throwbackindicator(DEFAULT:Throw_Back_Indicator_),seasonaldeliveryindicator(DEFAULT:Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(DEFAULT:Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(DEFAULT:Seasonal_End_Suppression_Date_),donotdeliverindicator(DEFAULT:Do_Not_Deliver_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),hotlistindicator(DEFAULT:Hot_List_Indicator_),collegeindicator(DEFAULT:College_Indicator_),collegestartsuppressiondate(DEFAULT:College_Start_Suppression_Date_),collegeendsuppressiondate(DEFAULT:College_End_Suppression_Date_),stylecode(DEFAULT:Style_Code_),simplifycount(DEFAULT:Simplify_Count_),dropindicator(DEFAULT:Drop_Indicator_),residentialorbusinessindicator(DEFAULT:Residential_Or_Business_Indicator_),onlywaytogetmailindicator(DEFAULT:Only_Way_To_Get_Mail_Indicator_),recordtypecode(DEFAULT:Record_Type_Code_),addresstypecode(DEFAULT:Address_Type_Code_),mixedusagecode(DEFAULT:Mixed_Usage_Code_),vacationbegindate(DEFAULT:Vacation_Begin_Date_:DATE),vacationenddate(DEFAULT:Vacation_End_Date_:DATE),numberofcurrentvacationmonths(DEFAULT:Number_Of_Current_Vacation_Months_),maxvacationmonths(DEFAULT:Max_Vacation_Months_),vacationperiodscount(DEFAULT:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),address_type(DEFAULT:Address___Type_:\'\'),address_desc(DEFAULT:Address___Desc_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED InLayout __Mapping5_Transform(InLayout __r) := TRANSFORM
    SELF.Do_Not_Mail_Indicator_ := __CN('Y');
    SELF := __r;
  END;
  SHARED __d5_Norm := NORMALIZE(__in,LEFT.Dataset_DMA__Key_DNM_Name_Address,TRANSFORM(RECORDOF(__in.Dataset_DMA__Key_DNM_Name_Address),SELF:=RIGHT));
  SHARED __d5_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_DMA__Key_DNM_Name_Address);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d5_UID_Mapped := JOIN(__d5_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d5_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DMA__Key_DNM_Name_Address_Invalid := __d5_UID_Mapped(UID = 0);
  SHARED __d5_Prefiltered := __d5_UID_Mapped(UID <> 0);
  SHARED __d5 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping5_Transform(LEFT)));
  SHARED __Mapping6 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_),predir(OVERRIDE:Predirectional_),prim_name(OVERRIDE:Primary_Name_),addr_suffix(OVERRIDE:Suffix_),postdir(OVERRIDE:Postdirectional_),unit_desig(OVERRIDE:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_),p_city_name(OVERRIDE:Postal_City_),v_city_name(OVERRIDE:Vanity_City_),st(OVERRIDE:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(OVERRIDE:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),carrierroutenumber(DEFAULT:Carrier_Route_Number_),carrierroutesortationatzip(DEFAULT:Carrier_Route_Sortation_At_Z_I_P_),lineoftravel(DEFAULT:Line_Of_Travel_),lineoftravelorder(DEFAULT:Line_Of_Travel_Order_),deliverypointbarcode(DEFAULT:Delivery_Point_Barcode_),deliverypointbarcodecheckdigit(DEFAULT:Delivery_Point_Barcode_Check_Digit_),typecode(DEFAULT:Type_Code_),county(DEFAULT:County_),geo_lat(OVERRIDE:Latitude_),geo_long(OVERRIDE:Longitude_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),geo_blk(OVERRIDE:Geo_Block_),geomatch(DEFAULT:Geo_Match_),acecleanererrorcode(DEFAULT:A_C_E_Cleaner_Error_Code_),advodatefirstseen(DEFAULT:A_D_V_O_Date_First_Seen_:DATE),advodatelastseen(DEFAULT:A_D_V_O_Date_Last_Seen_:DATE),advodatevendorfirstreported(DEFAULT:A_D_V_O_Date_Vendor_First_Reported_:DATE),advodatevendorlastreported(DEFAULT:A_D_V_O_Date_Vendor_Last_Reported_:DATE),vacancyindicator(DEFAULT:Vacancy_Indicator_),throwbackindicator(DEFAULT:Throw_Back_Indicator_),seasonaldeliveryindicator(DEFAULT:Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(DEFAULT:Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(DEFAULT:Seasonal_End_Suppression_Date_),donotdeliverindicator(DEFAULT:Do_Not_Deliver_Indicator_),donotmailindicator(DEFAULT:Do_Not_Mail_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),hotlistindicator(DEFAULT:Hot_List_Indicator_),collegeindicator(DEFAULT:College_Indicator_),collegestartsuppressiondate(DEFAULT:College_Start_Suppression_Date_),collegeendsuppressiondate(DEFAULT:College_End_Suppression_Date_),stylecode(DEFAULT:Style_Code_),simplifycount(DEFAULT:Simplify_Count_),dropindicator(DEFAULT:Drop_Indicator_),residentialorbusinessindicator(DEFAULT:Residential_Or_Business_Indicator_),onlywaytogetmailindicator(DEFAULT:Only_Way_To_Get_Mail_Indicator_),recordtypecode(DEFAULT:Record_Type_Code_),addresstypecode(DEFAULT:Address_Type_Code_),mixedusagecode(DEFAULT:Mixed_Usage_Code_),vacationbegindate(DEFAULT:Vacation_Begin_Date_:DATE),vacationenddate(DEFAULT:Vacation_End_Date_:DATE),numberofcurrentvacationmonths(DEFAULT:Number_Of_Current_Vacation_Months_),maxvacationmonths(DEFAULT:Max_Vacation_Months_),vacationperiodscount(DEFAULT:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),address_type(DEFAULT:Address___Type_:\'\'),address_desc(DEFAULT:Address___Desc_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d6_Norm := NORMALIZE(__in,LEFT.Dataset_Fraudpoint3__Key_Address,TRANSFORM(RECORDOF(__in.Dataset_Fraudpoint3__Key_Address),SELF:=RIGHT));
  SHARED __d6_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Fraudpoint3__Key_Address);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d6_UID_Mapped := JOIN(__d6_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d6_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Fraudpoint3__Key_Address_Invalid := __d6_UID_Mapped(UID = 0);
  SHARED __d6_Prefiltered := __d6_UID_Mapped(UID <> 0);
  SHARED __d6 := __SourceFilter(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping7 := 'UID(DEFAULT:UID),person_q.prim_range(OVERRIDE:Primary_Range_),person_q.predir(OVERRIDE:Predirectional_),person_q.prim_name(OVERRIDE:Primary_Name_),person_q.addr_suffix(OVERRIDE:Suffix_),person_q.postdir(OVERRIDE:Postdirectional_),person_q.unit_desig(OVERRIDE:Unit_Designation_),person_q.sec_range(OVERRIDE:Secondary_Range_),postalcity(DEFAULT:Postal_City_),person_q.v_city_name(OVERRIDE:Vanity_City_),person_q.st(OVERRIDE:State_),person_q.zip5(OVERRIDE:Z_I_P5_:0),person_q.zip4(OVERRIDE:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),carrierroutenumber(DEFAULT:Carrier_Route_Number_),carrierroutesortationatzip(DEFAULT:Carrier_Route_Sortation_At_Z_I_P_),lineoftravel(DEFAULT:Line_Of_Travel_),lineoftravelorder(DEFAULT:Line_Of_Travel_Order_),deliverypointbarcode(DEFAULT:Delivery_Point_Barcode_),deliverypointbarcodecheckdigit(DEFAULT:Delivery_Point_Barcode_Check_Digit_),person_q.addr_rec_type(OVERRIDE:Type_Code_),person_q.fips_county(OVERRIDE:County_),person_q.geo_lat(OVERRIDE:Latitude_),person_q.geo_long(OVERRIDE:Longitude_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),person_q.geo_blk(OVERRIDE:Geo_Block_),person_q.geo_match(OVERRIDE:Geo_Match_),person_q.err_stat(OVERRIDE:A_C_E_Cleaner_Error_Code_),advodatefirstseen(DEFAULT:A_D_V_O_Date_First_Seen_:DATE),advodatelastseen(DEFAULT:A_D_V_O_Date_Last_Seen_:DATE),advodatevendorfirstreported(DEFAULT:A_D_V_O_Date_Vendor_First_Reported_:DATE),advodatevendorlastreported(DEFAULT:A_D_V_O_Date_Vendor_Last_Reported_:DATE),vacancyindicator(DEFAULT:Vacancy_Indicator_),throwbackindicator(DEFAULT:Throw_Back_Indicator_),seasonaldeliveryindicator(DEFAULT:Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(DEFAULT:Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(DEFAULT:Seasonal_End_Suppression_Date_),donotdeliverindicator(DEFAULT:Do_Not_Deliver_Indicator_),donotmailindicator(DEFAULT:Do_Not_Mail_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),hotlistindicator(DEFAULT:Hot_List_Indicator_),collegeindicator(DEFAULT:College_Indicator_),collegestartsuppressiondate(DEFAULT:College_Start_Suppression_Date_),collegeendsuppressiondate(DEFAULT:College_End_Suppression_Date_),stylecode(DEFAULT:Style_Code_),simplifycount(DEFAULT:Simplify_Count_),dropindicator(DEFAULT:Drop_Indicator_),residentialorbusinessindicator(DEFAULT:Residential_Or_Business_Indicator_),onlywaytogetmailindicator(DEFAULT:Only_Way_To_Get_Mail_Indicator_),recordtypecode(DEFAULT:Record_Type_Code_),addresstypecode(DEFAULT:Address_Type_Code_),mixedusagecode(DEFAULT:Mixed_Usage_Code_),vacationbegindate(DEFAULT:Vacation_Begin_Date_:DATE),vacationenddate(DEFAULT:Vacation_End_Date_:DATE),numberofcurrentvacationmonths(DEFAULT:Number_Of_Current_Vacation_Months_),maxvacationmonths(DEFAULT:Max_Vacation_Months_),vacationperiodscount(DEFAULT:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),address_type(DEFAULT:Address___Type_:\'\'),address_desc(DEFAULT:Address___Desc_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),dateofinquiry(OVERRIDE:Date_First_Seen_:EPOCH|OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d7_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Key_FCRA_DID,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Key_FCRA_DID),SELF:=RIGHT));
  SHARED __d7_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Inquiry_AccLogs__Key_FCRA_DID);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d7_UID_Mapped := JOIN(__d7_KELfiltered,Lookup,TRIM((STRING)LEFT.person_q.prim_range) + '|' + TRIM((STRING)LEFT.person_q.predir) + '|' + TRIM((STRING)LEFT.person_q.prim_name) + '|' + TRIM((STRING)LEFT.person_q.addr_suffix) + '|' + TRIM((STRING)LEFT.person_q.postdir) + '|' + TRIM((STRING)LEFT.person_q.zip5) + '|' + TRIM((STRING)LEFT.person_q.sec_range) = RIGHT.KeyVal,TRANSFORM(__d7_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_DID_Invalid := __d7_UID_Mapped(UID = 0);
  SHARED __d7_Prefiltered := __d7_UID_Mapped(UID <> 0);
  SHARED __d7 := __SourceFilter(KEL.FromFlat.Convert(__d7_Prefiltered,InLayout,__Mapping7,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping8 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_),predir(OVERRIDE:Predirectional_),prim_name(OVERRIDE:Primary_Name_),addr_suffix(OVERRIDE:Suffix_),postdir(OVERRIDE:Postdirectional_),unit_desig(OVERRIDE:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_),p_city_name(OVERRIDE:Postal_City_),v_city_name(OVERRIDE:Vanity_City_),st(OVERRIDE:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(OVERRIDE:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),carrierroutenumber(DEFAULT:Carrier_Route_Number_),carrierroutesortationatzip(DEFAULT:Carrier_Route_Sortation_At_Z_I_P_),lineoftravel(DEFAULT:Line_Of_Travel_),lineoftravelorder(DEFAULT:Line_Of_Travel_Order_),deliverypointbarcode(DEFAULT:Delivery_Point_Barcode_),deliverypointbarcodecheckdigit(DEFAULT:Delivery_Point_Barcode_Check_Digit_),typecode(DEFAULT:Type_Code_),county(DEFAULT:County_),latitude(DEFAULT:Latitude_),longitude(DEFAULT:Longitude_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),geoblock(DEFAULT:Geo_Block_),geomatch(DEFAULT:Geo_Match_),acecleanererrorcode(DEFAULT:A_C_E_Cleaner_Error_Code_),advodatefirstseen(DEFAULT:A_D_V_O_Date_First_Seen_:DATE),advodatelastseen(DEFAULT:A_D_V_O_Date_Last_Seen_:DATE),advodatevendorfirstreported(DEFAULT:A_D_V_O_Date_Vendor_First_Reported_:DATE),advodatevendorlastreported(DEFAULT:A_D_V_O_Date_Vendor_Last_Reported_:DATE),vacancyindicator(DEFAULT:Vacancy_Indicator_),throwbackindicator(DEFAULT:Throw_Back_Indicator_),seasonaldeliveryindicator(DEFAULT:Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(DEFAULT:Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(DEFAULT:Seasonal_End_Suppression_Date_),donotdeliverindicator(DEFAULT:Do_Not_Deliver_Indicator_),donotmailindicator(DEFAULT:Do_Not_Mail_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),collegeindicator(DEFAULT:College_Indicator_),collegestartsuppressiondate(DEFAULT:College_Start_Suppression_Date_),collegeendsuppressiondate(DEFAULT:College_End_Suppression_Date_),stylecode(DEFAULT:Style_Code_),simplifycount(DEFAULT:Simplify_Count_),dropindicator(DEFAULT:Drop_Indicator_),residentialorbusinessindicator(DEFAULT:Residential_Or_Business_Indicator_),onlywaytogetmailindicator(DEFAULT:Only_Way_To_Get_Mail_Indicator_),recordtypecode(DEFAULT:Record_Type_Code_),addresstypecode(DEFAULT:Address_Type_Code_),mixedusagecode(DEFAULT:Mixed_Usage_Code_),vacationbegindate(DEFAULT:Vacation_Begin_Date_:DATE),vacationenddate(DEFAULT:Vacation_End_Date_:DATE),numberofcurrentvacationmonths(DEFAULT:Number_Of_Current_Vacation_Months_),maxvacationmonths(DEFAULT:Max_Vacation_Months_),vacationperiodscount(DEFAULT:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),address_type(DEFAULT:Address___Type_:\'\'),address_desc(DEFAULT:Address___Desc_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED InLayout __Mapping8_Transform(InLayout __r) := TRANSFORM
    SELF.Hot_List_Indicator_ := __CN('Y');
    SELF := __r;
  END;
  SHARED __d8_Norm := NORMALIZE(__in,LEFT.Dataset_USPIS_HotList__key_addr_search_zip,TRANSFORM(RECORDOF(__in.Dataset_USPIS_HotList__key_addr_search_zip),SELF:=RIGHT));
  SHARED __d8_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_USPIS_HotList__key_addr_search_zip);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d8_UID_Mapped := JOIN(__d8_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d8_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_USPIS_HotList__key_addr_search_zip_Invalid := __d8_UID_Mapped(UID = 0);
  SHARED __d8_Prefiltered := __d8_UID_Mapped(UID <> 0);
  SHARED __d8 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d8_Prefiltered,InLayout,__Mapping8,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping8_Transform(LEFT)));
  SHARED __Mapping9 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_),predir(OVERRIDE:Predirectional_),prim_name(OVERRIDE:Primary_Name_),addr_suffix(OVERRIDE:Suffix_),postdir(OVERRIDE:Postdirectional_),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_),p_city_name(OVERRIDE:Postal_City_),v_city_name(OVERRIDE:Vanity_City_),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(OVERRIDE:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),cart(OVERRIDE:Carrier_Route_Number_),cr_sort_sz(OVERRIDE:Carrier_Route_Sortation_At_Z_I_P_),lot(OVERRIDE:Line_Of_Travel_),lot_order(OVERRIDE:Line_Of_Travel_Order_),dbpc(OVERRIDE:Delivery_Point_Barcode_),chk_digit(OVERRIDE:Delivery_Point_Barcode_Check_Digit_),rec_type(OVERRIDE:Type_Code_),county(OVERRIDE:County_),geo_lat(OVERRIDE:Latitude_),geo_long(OVERRIDE:Longitude_),msa(OVERRIDE:Metropolitan_Statistical_Area_),geo_blk(OVERRIDE:Geo_Block_),geo_match(OVERRIDE:Geo_Match_),err_stat(OVERRIDE:A_C_E_Cleaner_Error_Code_),advodatefirstseen(DEFAULT:A_D_V_O_Date_First_Seen_:DATE),advodatelastseen(DEFAULT:A_D_V_O_Date_Last_Seen_:DATE),advodatevendorfirstreported(DEFAULT:A_D_V_O_Date_Vendor_First_Reported_:DATE),advodatevendorlastreported(DEFAULT:A_D_V_O_Date_Vendor_Last_Reported_:DATE),vacancyindicator(DEFAULT:Vacancy_Indicator_),throwbackindicator(DEFAULT:Throw_Back_Indicator_),seasonaldeliveryindicator(DEFAULT:Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(DEFAULT:Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(DEFAULT:Seasonal_End_Suppression_Date_),donotdeliverindicator(DEFAULT:Do_Not_Deliver_Indicator_),donotmailindicator(DEFAULT:Do_Not_Mail_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),hotlistindicator(DEFAULT:Hot_List_Indicator_),collegeindicator(DEFAULT:College_Indicator_),collegestartsuppressiondate(DEFAULT:College_Start_Suppression_Date_),collegeendsuppressiondate(DEFAULT:College_End_Suppression_Date_),stylecode(DEFAULT:Style_Code_),simplifycount(DEFAULT:Simplify_Count_),dropindicator(DEFAULT:Drop_Indicator_),residentialorbusinessindicator(DEFAULT:Residential_Or_Business_Indicator_),onlywaytogetmailindicator(DEFAULT:Only_Way_To_Get_Mail_Indicator_),recordtypecode(DEFAULT:Record_Type_Code_),addresstypecode(DEFAULT:Address_Type_Code_),mixedusagecode(DEFAULT:Mixed_Usage_Code_),vacationbegindate(DEFAULT:Vacation_Begin_Date_:DATE),vacationenddate(DEFAULT:Vacation_End_Date_:DATE),numberofcurrentvacationmonths(DEFAULT:Number_Of_Current_Vacation_Months_),maxvacationmonths(DEFAULT:Max_Vacation_Months_),vacationperiodscount(DEFAULT:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),address_type(DEFAULT:Address___Type_:\'\'),address_desc(DEFAULT:Address___Desc_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d9_Norm := NORMALIZE(__in,LEFT.Dataset_UtilFile__Key_Address,TRANSFORM(RECORDOF(__in.Dataset_UtilFile__Key_Address),SELF:=RIGHT));
  SHARED __d9_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_UtilFile__Key_Address);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d9_UID_Mapped := JOIN(__d9_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d9_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Key_Address_Invalid := __d9_UID_Mapped(UID = 0);
  SHARED __d9_Prefiltered := __d9_UID_Mapped(UID <> 0);
  SHARED __d9 := __SourceFilter(KEL.FromFlat.Convert(__d9_Prefiltered,InLayout,__Mapping9,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping10 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_),predir(OVERRIDE:Predirectional_),prim_name(OVERRIDE:Primary_Name_),addr_suffix(OVERRIDE:Suffix_),postdir(OVERRIDE:Postdirectional_),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_),p_city_name(OVERRIDE:Postal_City_),v_city_name(OVERRIDE:Vanity_City_),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(OVERRIDE:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),cart(OVERRIDE:Carrier_Route_Number_),cr_sort_sz(OVERRIDE:Carrier_Route_Sortation_At_Z_I_P_),lot(OVERRIDE:Line_Of_Travel_),lot_order(OVERRIDE:Line_Of_Travel_Order_),dbpc(OVERRIDE:Delivery_Point_Barcode_),chk_digit(OVERRIDE:Delivery_Point_Barcode_Check_Digit_),rec_type(OVERRIDE:Type_Code_),county(OVERRIDE:County_),geo_lat(OVERRIDE:Latitude_),geo_long(OVERRIDE:Longitude_),msa(OVERRIDE:Metropolitan_Statistical_Area_),geo_blk(OVERRIDE:Geo_Block_),geo_match(OVERRIDE:Geo_Match_),err_stat(OVERRIDE:A_C_E_Cleaner_Error_Code_),advodatefirstseen(DEFAULT:A_D_V_O_Date_First_Seen_:DATE),advodatelastseen(DEFAULT:A_D_V_O_Date_Last_Seen_:DATE),advodatevendorfirstreported(DEFAULT:A_D_V_O_Date_Vendor_First_Reported_:DATE),advodatevendorlastreported(DEFAULT:A_D_V_O_Date_Vendor_Last_Reported_:DATE),vacancyindicator(DEFAULT:Vacancy_Indicator_),throwbackindicator(DEFAULT:Throw_Back_Indicator_),seasonaldeliveryindicator(DEFAULT:Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(DEFAULT:Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(DEFAULT:Seasonal_End_Suppression_Date_),donotdeliverindicator(DEFAULT:Do_Not_Deliver_Indicator_),donotmailindicator(DEFAULT:Do_Not_Mail_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),hotlistindicator(DEFAULT:Hot_List_Indicator_),collegeindicator(DEFAULT:College_Indicator_),collegestartsuppressiondate(DEFAULT:College_Start_Suppression_Date_),collegeendsuppressiondate(DEFAULT:College_End_Suppression_Date_),stylecode(DEFAULT:Style_Code_),simplifycount(DEFAULT:Simplify_Count_),dropindicator(DEFAULT:Drop_Indicator_),residentialorbusinessindicator(DEFAULT:Residential_Or_Business_Indicator_),onlywaytogetmailindicator(DEFAULT:Only_Way_To_Get_Mail_Indicator_),recordtypecode(DEFAULT:Record_Type_Code_),addresstypecode(DEFAULT:Address_Type_Code_),mixedusagecode(DEFAULT:Mixed_Usage_Code_),vacationbegindate(DEFAULT:Vacation_Begin_Date_:DATE),vacationenddate(DEFAULT:Vacation_End_Date_:DATE),numberofcurrentvacationmonths(DEFAULT:Number_Of_Current_Vacation_Months_),maxvacationmonths(DEFAULT:Max_Vacation_Months_),vacationperiodscount(DEFAULT:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),address_type(DEFAULT:Address___Type_:\'\'),address_desc(DEFAULT:Address___Desc_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d10_Norm := NORMALIZE(__in,LEFT.Dataset_UtilFile__Key_DID,TRANSFORM(RECORDOF(__in.Dataset_UtilFile__Key_DID),SELF:=RIGHT));
  SHARED __d10_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_UtilFile__Key_DID);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d10_UID_Mapped := JOIN(__d10_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d10_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Key_DID_Invalid := __d10_UID_Mapped(UID = 0);
  SHARED __d10_Prefiltered := __d10_UID_Mapped(UID <> 0);
  SHARED __d10 := __SourceFilter(KEL.FromFlat.Convert(__d10_Prefiltered,InLayout,__Mapping10,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping11 := 'UID(DEFAULT:UID),clean_address.prim_range(OVERRIDE:Primary_Range_),clean_address.predir(OVERRIDE:Predirectional_),clean_address.prim_name(OVERRIDE:Primary_Name_),clean_address.addr_suffix(OVERRIDE:Suffix_),clean_address.postdir(OVERRIDE:Postdirectional_),clean_address.unit_desig(OVERRIDE:Unit_Designation_),clean_address.sec_range(OVERRIDE:Secondary_Range_),clean_address.p_city_name(OVERRIDE:Postal_City_),clean_address.v_city_name(OVERRIDE:Vanity_City_),clean_address.st(OVERRIDE:State_),clean_address.zip(OVERRIDE:Z_I_P5_:0),clean_address.zip4(OVERRIDE:Z_I_P4_),append_rawaid(OVERRIDE:Append_Raw_A_I_D_:0),clean_address.cart(OVERRIDE:Carrier_Route_Number_),clean_address.cr_sort_sz(OVERRIDE:Carrier_Route_Sortation_At_Z_I_P_),clean_address.lot(OVERRIDE:Line_Of_Travel_),clean_address.lot_order(OVERRIDE:Line_Of_Travel_Order_),clean_address.dbpc(OVERRIDE:Delivery_Point_Barcode_),clean_address.chk_digit(OVERRIDE:Delivery_Point_Barcode_Check_Digit_),clean_address.rec_type(OVERRIDE:Type_Code_),clean_address.county(OVERRIDE:County_),clean_address.geo_lat(OVERRIDE:Latitude_),clean_address.geo_long(OVERRIDE:Longitude_),clean_address.msa(OVERRIDE:Metropolitan_Statistical_Area_),clean_address.geo_blk(OVERRIDE:Geo_Block_),clean_address.geo_match(OVERRIDE:Geo_Match_),clean_address.err_stat(OVERRIDE:A_C_E_Cleaner_Error_Code_),advodatefirstseen(DEFAULT:A_D_V_O_Date_First_Seen_:DATE),advodatelastseen(DEFAULT:A_D_V_O_Date_Last_Seen_:DATE),advodatevendorfirstreported(DEFAULT:A_D_V_O_Date_Vendor_First_Reported_:DATE),advodatevendorlastreported(DEFAULT:A_D_V_O_Date_Vendor_Last_Reported_:DATE),vacancyindicator(DEFAULT:Vacancy_Indicator_),throwbackindicator(DEFAULT:Throw_Back_Indicator_),seasonaldeliveryindicator(DEFAULT:Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(DEFAULT:Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(DEFAULT:Seasonal_End_Suppression_Date_),donotdeliverindicator(DEFAULT:Do_Not_Deliver_Indicator_),donotmailindicator(DEFAULT:Do_Not_Mail_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),hotlistindicator(DEFAULT:Hot_List_Indicator_),collegeindicator(DEFAULT:College_Indicator_),collegestartsuppressiondate(DEFAULT:College_Start_Suppression_Date_),collegeendsuppressiondate(DEFAULT:College_End_Suppression_Date_),stylecode(DEFAULT:Style_Code_),simplifycount(DEFAULT:Simplify_Count_),dropindicator(DEFAULT:Drop_Indicator_),residentialorbusinessindicator(DEFAULT:Residential_Or_Business_Indicator_),onlywaytogetmailindicator(DEFAULT:Only_Way_To_Get_Mail_Indicator_),recordtypecode(DEFAULT:Record_Type_Code_),addresstypecode(DEFAULT:Address_Type_Code_),mixedusagecode(DEFAULT:Mixed_Usage_Code_),vacationbegindate(DEFAULT:Vacation_Begin_Date_:DATE),vacationenddate(DEFAULT:Vacation_End_Date_:DATE),numberofcurrentvacationmonths(DEFAULT:Number_Of_Current_Vacation_Months_),maxvacationmonths(DEFAULT:Max_Vacation_Months_),vacationperiodscount(DEFAULT:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),address_type(DEFAULT:Address___Type_:\'\'),address_desc(DEFAULT:Address___Desc_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),email_src(OVERRIDE:Source_:\'\'),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d11_Norm := NORMALIZE(__in,LEFT.Dataset_DX_Email__Key_Email_Payload,TRANSFORM(RECORDOF(__in.Dataset_DX_Email__Key_Email_Payload),SELF:=RIGHT));
  SHARED __d11_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_DX_Email__Key_Email_Payload);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d11_UID_Mapped := JOIN(__d11_KELfiltered,Lookup,TRIM((STRING)LEFT.clean_address.prim_range) + '|' + TRIM((STRING)LEFT.clean_address.predir) + '|' + TRIM((STRING)LEFT.clean_address.prim_name) + '|' + TRIM((STRING)LEFT.clean_address.addr_suffix) + '|' + TRIM((STRING)LEFT.clean_address.postdir) + '|' + TRIM((STRING)LEFT.clean_address.zip) + '|' + TRIM((STRING)LEFT.clean_address.sec_range) = RIGHT.KeyVal,TRANSFORM(__d11_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DX_Email__Key_Email_Payload_Invalid := __d11_UID_Mapped(UID = 0);
  SHARED __d11_Prefiltered := __d11_UID_Mapped(UID <> 0);
  SHARED __d11 := __SourceFilter(KEL.FromFlat.Convert(__d11_Prefiltered,InLayout,__Mapping11,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping12 := 'UID(DEFAULT:UID),corp_addr1_prim_range(OVERRIDE:Primary_Range_),corp_addr1_predir(OVERRIDE:Predirectional_),corp_addr1_prim_name(OVERRIDE:Primary_Name_),corp_addr1_addr_suffix(OVERRIDE:Suffix_),corp_addr1_postdir(OVERRIDE:Postdirectional_),corp_addr1_unit_desig(OVERRIDE:Unit_Designation_),corp_addr1_sec_range(OVERRIDE:Secondary_Range_),corp_addr1_p_city_name(OVERRIDE:Postal_City_),corp_addr1_v_city_name(OVERRIDE:Vanity_City_),corp_addr1_state(OVERRIDE:State_),corp_addr1_zip5(OVERRIDE:Z_I_P5_:0),corp_addr1_zip4(OVERRIDE:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),carrierroutenumber(DEFAULT:Carrier_Route_Number_),carrierroutesortationatzip(DEFAULT:Carrier_Route_Sortation_At_Z_I_P_),lineoftravel(DEFAULT:Line_Of_Travel_),lineoftravelorder(DEFAULT:Line_Of_Travel_Order_),deliverypointbarcode(DEFAULT:Delivery_Point_Barcode_),deliverypointbarcodecheckdigit(DEFAULT:Delivery_Point_Barcode_Check_Digit_),typecode(DEFAULT:Type_Code_),county(DEFAULT:County_),corp_addr1_geo_lat(OVERRIDE:Latitude_|OVERRIDE:Longitude_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),corp_addr1_geo_blk(OVERRIDE:Geo_Block_),geomatch(DEFAULT:Geo_Match_),acecleanererrorcode(DEFAULT:A_C_E_Cleaner_Error_Code_),advodatefirstseen(DEFAULT:A_D_V_O_Date_First_Seen_:DATE),advodatelastseen(DEFAULT:A_D_V_O_Date_Last_Seen_:DATE),advodatevendorfirstreported(DEFAULT:A_D_V_O_Date_Vendor_First_Reported_:DATE),advodatevendorlastreported(DEFAULT:A_D_V_O_Date_Vendor_Last_Reported_:DATE),vacancyindicator(DEFAULT:Vacancy_Indicator_),throwbackindicator(DEFAULT:Throw_Back_Indicator_),seasonaldeliveryindicator(DEFAULT:Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(DEFAULT:Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(DEFAULT:Seasonal_End_Suppression_Date_),donotdeliverindicator(DEFAULT:Do_Not_Deliver_Indicator_),donotmailindicator(DEFAULT:Do_Not_Mail_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),hotlistindicator(DEFAULT:Hot_List_Indicator_),collegeindicator(DEFAULT:College_Indicator_),collegestartsuppressiondate(DEFAULT:College_Start_Suppression_Date_),collegeendsuppressiondate(DEFAULT:College_End_Suppression_Date_),stylecode(DEFAULT:Style_Code_),simplifycount(DEFAULT:Simplify_Count_),dropindicator(DEFAULT:Drop_Indicator_),residentialorbusinessindicator(DEFAULT:Residential_Or_Business_Indicator_),onlywaytogetmailindicator(DEFAULT:Only_Way_To_Get_Mail_Indicator_),recordtypecode(DEFAULT:Record_Type_Code_),addresstypecode(DEFAULT:Address_Type_Code_),mixedusagecode(DEFAULT:Mixed_Usage_Code_),vacationbegindate(DEFAULT:Vacation_Begin_Date_:DATE),vacationenddate(DEFAULT:Vacation_End_Date_:DATE),numberofcurrentvacationmonths(DEFAULT:Number_Of_Current_Vacation_Months_),maxvacationmonths(DEFAULT:Max_Vacation_Months_),vacationperiodscount(DEFAULT:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),corp_address1_type_cd(OVERRIDE:Address___Type_:\'\'),corp_address1_type_desc(OVERRIDE:Address___Desc_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),dt_last_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_first_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d12_Norm := NORMALIZE(__in,LEFT.Dataset_Corp2__Kfetch_LinkIDs_Corp,TRANSFORM(RECORDOF(__in.Dataset_Corp2__Kfetch_LinkIDs_Corp),SELF:=RIGHT));
  SHARED __d12_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Corp2__Kfetch_LinkIDs_Corp);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d12_UID_Mapped := JOIN(__d12_KELfiltered,Lookup,TRIM((STRING)LEFT.corp_addr1_prim_range) + '|' + TRIM((STRING)LEFT.corp_addr1_predir) + '|' + TRIM((STRING)LEFT.corp_addr1_prim_name) + '|' + TRIM((STRING)LEFT.corp_addr1_addr_suffix) + '|' + TRIM((STRING)LEFT.corp_addr1_postdir) + '|' + TRIM((STRING)LEFT.corp_addr1_zip5) + '|' + TRIM((STRING)LEFT.corp_addr1_sec_range) = RIGHT.KeyVal,TRANSFORM(__d12_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Corp2__Kfetch_LinkIDs_Corp_1_Invalid := __d12_UID_Mapped(UID = 0);
  SHARED __d12_Prefiltered := __d12_UID_Mapped(UID <> 0);
  SHARED __d12 := __SourceFilter(KEL.FromFlat.Convert(__d12_Prefiltered,InLayout,__Mapping12,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping13 := 'UID(DEFAULT:UID),corp_addr2_prim_range(OVERRIDE:Primary_Range_),corp_addr2_predir(OVERRIDE:Predirectional_),corp_addr2_prim_name(OVERRIDE:Primary_Name_),corp_addr2_addr_suffix(OVERRIDE:Suffix_),corp_addr2_postdir(OVERRIDE:Postdirectional_),corp_addr2_unit_desig(OVERRIDE:Unit_Designation_),corp_addr2_sec_range(OVERRIDE:Secondary_Range_),corp_addr2_p_city_name(OVERRIDE:Postal_City_),corp_addr2_v_city_name(OVERRIDE:Vanity_City_),corp_addr2_state(OVERRIDE:State_),corp_addr2_zip5(OVERRIDE:Z_I_P5_:0),corp_addr2_zip4(OVERRIDE:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),carrierroutenumber(DEFAULT:Carrier_Route_Number_),carrierroutesortationatzip(DEFAULT:Carrier_Route_Sortation_At_Z_I_P_),lineoftravel(DEFAULT:Line_Of_Travel_),lineoftravelorder(DEFAULT:Line_Of_Travel_Order_),deliverypointbarcode(DEFAULT:Delivery_Point_Barcode_),deliverypointbarcodecheckdigit(DEFAULT:Delivery_Point_Barcode_Check_Digit_),typecode(DEFAULT:Type_Code_),county(DEFAULT:County_),corp_addr2_geo_lat(OVERRIDE:Latitude_|OVERRIDE:Longitude_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),corp_addr2_geo_blk(OVERRIDE:Geo_Block_),geomatch(DEFAULT:Geo_Match_),acecleanererrorcode(DEFAULT:A_C_E_Cleaner_Error_Code_),advodatefirstseen(DEFAULT:A_D_V_O_Date_First_Seen_:DATE),advodatelastseen(DEFAULT:A_D_V_O_Date_Last_Seen_:DATE),advodatevendorfirstreported(DEFAULT:A_D_V_O_Date_Vendor_First_Reported_:DATE),advodatevendorlastreported(DEFAULT:A_D_V_O_Date_Vendor_Last_Reported_:DATE),vacancyindicator(DEFAULT:Vacancy_Indicator_),throwbackindicator(DEFAULT:Throw_Back_Indicator_),seasonaldeliveryindicator(DEFAULT:Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(DEFAULT:Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(DEFAULT:Seasonal_End_Suppression_Date_),donotdeliverindicator(DEFAULT:Do_Not_Deliver_Indicator_),donotmailindicator(DEFAULT:Do_Not_Mail_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),hotlistindicator(DEFAULT:Hot_List_Indicator_),collegeindicator(DEFAULT:College_Indicator_),collegestartsuppressiondate(DEFAULT:College_Start_Suppression_Date_),collegeendsuppressiondate(DEFAULT:College_End_Suppression_Date_),stylecode(DEFAULT:Style_Code_),simplifycount(DEFAULT:Simplify_Count_),dropindicator(DEFAULT:Drop_Indicator_),residentialorbusinessindicator(DEFAULT:Residential_Or_Business_Indicator_),onlywaytogetmailindicator(DEFAULT:Only_Way_To_Get_Mail_Indicator_),recordtypecode(DEFAULT:Record_Type_Code_),addresstypecode(DEFAULT:Address_Type_Code_),mixedusagecode(DEFAULT:Mixed_Usage_Code_),vacationbegindate(DEFAULT:Vacation_Begin_Date_:DATE),vacationenddate(DEFAULT:Vacation_End_Date_:DATE),numberofcurrentvacationmonths(DEFAULT:Number_Of_Current_Vacation_Months_),maxvacationmonths(DEFAULT:Max_Vacation_Months_),vacationperiodscount(DEFAULT:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),corp_address2_type_cd(OVERRIDE:Address___Type_:\'\'),corp_address2_type_desc(OVERRIDE:Address___Desc_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),dt_last_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_first_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d13_Norm := NORMALIZE(__in,LEFT.Dataset_Corp2__Kfetch_LinkIDs_Corp,TRANSFORM(RECORDOF(__in.Dataset_Corp2__Kfetch_LinkIDs_Corp),SELF:=RIGHT));
  SHARED __d13_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Corp2__Kfetch_LinkIDs_Corp);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d13_UID_Mapped := JOIN(__d13_KELfiltered,Lookup,TRIM((STRING)LEFT.corp_addr2_prim_range) + '|' + TRIM((STRING)LEFT.corp_addr2_predir) + '|' + TRIM((STRING)LEFT.corp_addr2_prim_name) + '|' + TRIM((STRING)LEFT.corp_addr2_addr_suffix) + '|' + TRIM((STRING)LEFT.corp_addr2_postdir) + '|' + TRIM((STRING)LEFT.corp_addr2_zip5) + '|' + TRIM((STRING)LEFT.corp_addr2_sec_range) = RIGHT.KeyVal,TRANSFORM(__d13_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Corp2__Kfetch_LinkIDs_Corp_2_Invalid := __d13_UID_Mapped(UID = 0);
  SHARED __d13_Prefiltered := __d13_UID_Mapped(UID <> 0);
  SHARED __d13 := __SourceFilter(KEL.FromFlat.Convert(__d13_Prefiltered,InLayout,__Mapping13,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping14 := 'UID(DEFAULT:UID),corp_ra_prim_range(OVERRIDE:Primary_Range_),corp_ra_predir(OVERRIDE:Predirectional_),corp_ra_prim_name(OVERRIDE:Primary_Name_),corp_ra_addr_suffix(OVERRIDE:Suffix_),corp_ra_postdir(OVERRIDE:Postdirectional_),corp_ra_unit_desig(OVERRIDE:Unit_Designation_),corp_ra_sec_range(OVERRIDE:Secondary_Range_),corp_ra_p_city_name(OVERRIDE:Postal_City_),corp_ra_v_city_name(OVERRIDE:Vanity_City_),corp_ra_state(OVERRIDE:State_),corp_ra_zip5(OVERRIDE:Z_I_P5_:0),corp_ra_zip4(OVERRIDE:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),carrierroutenumber(DEFAULT:Carrier_Route_Number_),carrierroutesortationatzip(DEFAULT:Carrier_Route_Sortation_At_Z_I_P_),lineoftravel(DEFAULT:Line_Of_Travel_),lineoftravelorder(DEFAULT:Line_Of_Travel_Order_),deliverypointbarcode(DEFAULT:Delivery_Point_Barcode_),deliverypointbarcodecheckdigit(DEFAULT:Delivery_Point_Barcode_Check_Digit_),typecode(DEFAULT:Type_Code_),county(DEFAULT:County_),corp_ra_geo_lat(OVERRIDE:Latitude_|OVERRIDE:Longitude_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),corp_ra_geo_blk(OVERRIDE:Geo_Block_),geomatch(DEFAULT:Geo_Match_),acecleanererrorcode(DEFAULT:A_C_E_Cleaner_Error_Code_),advodatefirstseen(DEFAULT:A_D_V_O_Date_First_Seen_:DATE),advodatelastseen(DEFAULT:A_D_V_O_Date_Last_Seen_:DATE),advodatevendorfirstreported(DEFAULT:A_D_V_O_Date_Vendor_First_Reported_:DATE),advodatevendorlastreported(DEFAULT:A_D_V_O_Date_Vendor_Last_Reported_:DATE),vacancyindicator(DEFAULT:Vacancy_Indicator_),throwbackindicator(DEFAULT:Throw_Back_Indicator_),seasonaldeliveryindicator(DEFAULT:Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(DEFAULT:Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(DEFAULT:Seasonal_End_Suppression_Date_),donotdeliverindicator(DEFAULT:Do_Not_Deliver_Indicator_),donotmailindicator(DEFAULT:Do_Not_Mail_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),hotlistindicator(DEFAULT:Hot_List_Indicator_),collegeindicator(DEFAULT:College_Indicator_),collegestartsuppressiondate(DEFAULT:College_Start_Suppression_Date_),collegeendsuppressiondate(DEFAULT:College_End_Suppression_Date_),stylecode(DEFAULT:Style_Code_),simplifycount(DEFAULT:Simplify_Count_),dropindicator(DEFAULT:Drop_Indicator_),residentialorbusinessindicator(DEFAULT:Residential_Or_Business_Indicator_),onlywaytogetmailindicator(DEFAULT:Only_Way_To_Get_Mail_Indicator_),recordtypecode(DEFAULT:Record_Type_Code_),addresstypecode(DEFAULT:Address_Type_Code_),mixedusagecode(DEFAULT:Mixed_Usage_Code_),vacationbegindate(DEFAULT:Vacation_Begin_Date_:DATE),vacationenddate(DEFAULT:Vacation_End_Date_:DATE),numberofcurrentvacationmonths(DEFAULT:Number_Of_Current_Vacation_Months_),maxvacationmonths(DEFAULT:Max_Vacation_Months_),vacationperiodscount(DEFAULT:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),corp_ra_address_type_cd(OVERRIDE:Address___Type_:\'\'),corp_ra_address_type_desc(OVERRIDE:Address___Desc_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),dt_last_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_first_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d14_Norm := NORMALIZE(__in,LEFT.Dataset_Corp2__Kfetch_LinkIDs_Corp,TRANSFORM(RECORDOF(__in.Dataset_Corp2__Kfetch_LinkIDs_Corp),SELF:=RIGHT));
  SHARED __d14_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Corp2__Kfetch_LinkIDs_Corp);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d14_UID_Mapped := JOIN(__d14_KELfiltered,Lookup,TRIM((STRING)LEFT.corp_ra_prim_range) + '|' + TRIM((STRING)LEFT.corp_ra_predir) + '|' + TRIM((STRING)LEFT.corp_ra_prim_name) + '|' + TRIM((STRING)LEFT.corp_ra_addr_suffix) + '|' + TRIM((STRING)LEFT.corp_ra_postdir) + '|' + TRIM((STRING)LEFT.corp_ra_zip5) + '|' + TRIM((STRING)LEFT.corp_ra_sec_range) = RIGHT.KeyVal,TRANSFORM(__d14_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Corp2__Kfetch_LinkIDs_Corp_3_Invalid := __d14_UID_Mapped(UID = 0);
  SHARED __d14_Prefiltered := __d14_UID_Mapped(UID <> 0);
  SHARED __d14 := __SourceFilter(KEL.FromFlat.Convert(__d14_Prefiltered,InLayout,__Mapping14,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping15 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_),predir(OVERRIDE:Predirectional_),prim_name(OVERRIDE:Primary_Name_),addr_suffix(OVERRIDE:Suffix_),postdir(OVERRIDE:Postdirectional_),unit_desig(OVERRIDE:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_),p_city_name(OVERRIDE:Postal_City_),v_city_name(OVERRIDE:Vanity_City_),st(OVERRIDE:State_),zip5(OVERRIDE:Z_I_P5_:0),zip4(OVERRIDE:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),carrierroutenumber(DEFAULT:Carrier_Route_Number_),carrierroutesortationatzip(DEFAULT:Carrier_Route_Sortation_At_Z_I_P_),lineoftravel(DEFAULT:Line_Of_Travel_),lineoftravelorder(DEFAULT:Line_Of_Travel_Order_),deliverypointbarcode(DEFAULT:Delivery_Point_Barcode_),deliverypointbarcodecheckdigit(DEFAULT:Delivery_Point_Barcode_Check_Digit_),typecode(DEFAULT:Type_Code_),county(DEFAULT:County_),geo_lat(OVERRIDE:Latitude_),geo_long(OVERRIDE:Longitude_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),geo_blk(OVERRIDE:Geo_Block_),geomatch(DEFAULT:Geo_Match_),acecleanererrorcode(DEFAULT:A_C_E_Cleaner_Error_Code_),advodatefirstseen(DEFAULT:A_D_V_O_Date_First_Seen_:DATE),advodatelastseen(DEFAULT:A_D_V_O_Date_Last_Seen_:DATE),advodatevendorfirstreported(DEFAULT:A_D_V_O_Date_Vendor_First_Reported_:DATE),advodatevendorlastreported(DEFAULT:A_D_V_O_Date_Vendor_Last_Reported_:DATE),vacancyindicator(DEFAULT:Vacancy_Indicator_),throwbackindicator(DEFAULT:Throw_Back_Indicator_),seasonaldeliveryindicator(DEFAULT:Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(DEFAULT:Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(DEFAULT:Seasonal_End_Suppression_Date_),donotdeliverindicator(DEFAULT:Do_Not_Deliver_Indicator_),donotmailindicator(DEFAULT:Do_Not_Mail_Indicator_),hotlistindicator(DEFAULT:Hot_List_Indicator_),collegeindicator(DEFAULT:College_Indicator_),collegestartsuppressiondate(DEFAULT:College_Start_Suppression_Date_),collegeendsuppressiondate(DEFAULT:College_End_Suppression_Date_),stylecode(DEFAULT:Style_Code_),simplifycount(DEFAULT:Simplify_Count_),dropindicator(DEFAULT:Drop_Indicator_),residentialorbusinessindicator(DEFAULT:Residential_Or_Business_Indicator_),onlywaytogetmailindicator(DEFAULT:Only_Way_To_Get_Mail_Indicator_),recordtypecode(DEFAULT:Record_Type_Code_),addresstypecode(DEFAULT:Address_Type_Code_),mixedusagecode(DEFAULT:Mixed_Usage_Code_),vacationbegindate(DEFAULT:Vacation_Begin_Date_:DATE),vacationenddate(DEFAULT:Vacation_End_Date_:DATE),numberofcurrentvacationmonths(DEFAULT:Number_Of_Current_Vacation_Months_),maxvacationmonths(DEFAULT:Max_Vacation_Months_),vacationperiodscount(DEFAULT:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),address_type(DEFAULT:Address___Type_:\'\'),address_desc(DEFAULT:Address___Desc_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED InLayout __Mapping15_Transform(InLayout __r) := TRANSFORM
    SELF.Dead_C_O_Indicator_ := __CN('Y');
    SELF := __r;
  END;
  SHARED __d15_Norm := NORMALIZE(__in,LEFT.Dataset_InfoUSA__Key_DEADCO_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_InfoUSA__Key_DEADCO_LinkIds),SELF:=RIGHT));
  SHARED __d15_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_InfoUSA__Key_DEADCO_LinkIds);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d15_UID_Mapped := JOIN(__d15_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip5) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d15_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_InfoUSA__Key_DEADCO_LinkIds_Invalid := __d15_UID_Mapped(UID = 0);
  SHARED __d15_Prefiltered := __d15_UID_Mapped(UID <> 0);
  SHARED __d15 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d15_Prefiltered,InLayout,__Mapping15,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping15_Transform(LEFT)));
  SHARED __Mapping16 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_),predir(OVERRIDE:Predirectional_),prim_name(OVERRIDE:Primary_Name_),addr_suffix(OVERRIDE:Suffix_),postdir(OVERRIDE:Postdirectional_),unitdesignation(DEFAULT:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_),p_city_name(OVERRIDE:Postal_City_),v_city_name(OVERRIDE:Vanity_City_),state(DEFAULT:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(OVERRIDE:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),cart(OVERRIDE:Carrier_Route_Number_),cr_sort_sz(OVERRIDE:Carrier_Route_Sortation_At_Z_I_P_),lot(OVERRIDE:Line_Of_Travel_),lot_order(OVERRIDE:Line_Of_Travel_Order_),dbpc(OVERRIDE:Delivery_Point_Barcode_),chk_digit(OVERRIDE:Delivery_Point_Barcode_Check_Digit_),rec_type(OVERRIDE:Type_Code_),county(OVERRIDE:County_),geo_lat(OVERRIDE:Latitude_),geo_long(OVERRIDE:Longitude_),msa(OVERRIDE:Metropolitan_Statistical_Area_),geo_blk(OVERRIDE:Geo_Block_),geo_match(OVERRIDE:Geo_Match_),err_stat(OVERRIDE:A_C_E_Cleaner_Error_Code_),advodatefirstseen(DEFAULT:A_D_V_O_Date_First_Seen_:DATE),advodatelastseen(DEFAULT:A_D_V_O_Date_Last_Seen_:DATE),advodatevendorfirstreported(DEFAULT:A_D_V_O_Date_Vendor_First_Reported_:DATE),advodatevendorlastreported(DEFAULT:A_D_V_O_Date_Vendor_Last_Reported_:DATE),vacancyindicator(DEFAULT:Vacancy_Indicator_),throwbackindicator(DEFAULT:Throw_Back_Indicator_),seasonaldeliveryindicator(DEFAULT:Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(DEFAULT:Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(DEFAULT:Seasonal_End_Suppression_Date_),donotdeliverindicator(DEFAULT:Do_Not_Deliver_Indicator_),donotmailindicator(DEFAULT:Do_Not_Mail_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),hotlistindicator(DEFAULT:Hot_List_Indicator_),collegeindicator(DEFAULT:College_Indicator_),collegestartsuppressiondate(DEFAULT:College_Start_Suppression_Date_),collegeendsuppressiondate(DEFAULT:College_End_Suppression_Date_),stylecode(DEFAULT:Style_Code_),simplifycount(DEFAULT:Simplify_Count_),dropindicator(DEFAULT:Drop_Indicator_),residentialorbusinessindicator(DEFAULT:Residential_Or_Business_Indicator_),onlywaytogetmailindicator(DEFAULT:Only_Way_To_Get_Mail_Indicator_),recordtypecode(DEFAULT:Record_Type_Code_),addresstypecode(DEFAULT:Address_Type_Code_),mixedusagecode(DEFAULT:Mixed_Usage_Code_),vacationbegindate(DEFAULT:Vacation_Begin_Date_:DATE),vacationenddate(DEFAULT:Vacation_End_Date_:DATE),numberofcurrentvacationmonths(DEFAULT:Number_Of_Current_Vacation_Months_),maxvacationmonths(DEFAULT:Max_Vacation_Months_),vacationperiodscount(DEFAULT:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),address_type(DEFAULT:Address___Type_:\'\'),address_desc(DEFAULT:Address___Desc_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d16_Norm := NORMALIZE(__in,LEFT.Dataset_UtilFile__Kfetch2_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_UtilFile__Kfetch2_LinkIds),SELF:=RIGHT));
  SHARED __d16_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_UtilFile__Kfetch2_LinkIds);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d16_UID_Mapped := JOIN(__d16_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d16_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Kfetch2_LinkIds_Invalid := __d16_UID_Mapped(UID = 0);
  SHARED __d16_Prefiltered := __d16_UID_Mapped(UID <> 0);
  SHARED __d16 := __SourceFilter(KEL.FromFlat.Convert(__d16_Prefiltered,InLayout,__Mapping16,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_17Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_17Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping17 := 'UID(DEFAULT:UID),prim_range(OVERRIDE:Primary_Range_),predir(OVERRIDE:Predirectional_),prim_name(OVERRIDE:Primary_Name_),suffix(OVERRIDE:Suffix_),postdir(OVERRIDE:Postdirectional_),unit_desig(OVERRIDE:Unit_Designation_),sec_range(OVERRIDE:Secondary_Range_),city_name(OVERRIDE:Postal_City_),vanitycity(DEFAULT:Vanity_City_),st(OVERRIDE:State_),zip(OVERRIDE:Z_I_P5_:0),zip4(DEFAULT:Z_I_P4_),appendrawaid(DEFAULT:Append_Raw_A_I_D_:0),carrierroutenumber(DEFAULT:Carrier_Route_Number_),carrierroutesortationatzip(DEFAULT:Carrier_Route_Sortation_At_Z_I_P_),lineoftravel(DEFAULT:Line_Of_Travel_),lineoftravelorder(DEFAULT:Line_Of_Travel_Order_),deliverypointbarcode(DEFAULT:Delivery_Point_Barcode_),deliverypointbarcodecheckdigit(DEFAULT:Delivery_Point_Barcode_Check_Digit_),typecode(DEFAULT:Type_Code_),county(OVERRIDE:County_),latitude(DEFAULT:Latitude_),longitude(DEFAULT:Longitude_),metropolitanstatisticalarea(DEFAULT:Metropolitan_Statistical_Area_),geo_blk(OVERRIDE:Geo_Block_),geomatch(DEFAULT:Geo_Match_),acecleanererrorcode(DEFAULT:A_C_E_Cleaner_Error_Code_),advodatefirstseen(DEFAULT:A_D_V_O_Date_First_Seen_:DATE),advodatelastseen(DEFAULT:A_D_V_O_Date_Last_Seen_:DATE),advodatevendorfirstreported(DEFAULT:A_D_V_O_Date_Vendor_First_Reported_:DATE),advodatevendorlastreported(DEFAULT:A_D_V_O_Date_Vendor_Last_Reported_:DATE),vacancyindicator(DEFAULT:Vacancy_Indicator_),throwbackindicator(DEFAULT:Throw_Back_Indicator_),seasonaldeliveryindicator(DEFAULT:Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(DEFAULT:Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(DEFAULT:Seasonal_End_Suppression_Date_),donotdeliverindicator(DEFAULT:Do_Not_Deliver_Indicator_),donotmailindicator(DEFAULT:Do_Not_Mail_Indicator_),deadcoindicator(DEFAULT:Dead_C_O_Indicator_),hotlistindicator(DEFAULT:Hot_List_Indicator_),collegeindicator(DEFAULT:College_Indicator_),collegestartsuppressiondate(DEFAULT:College_Start_Suppression_Date_),collegeendsuppressiondate(DEFAULT:College_End_Suppression_Date_),stylecode(DEFAULT:Style_Code_),simplifycount(DEFAULT:Simplify_Count_),dropindicator(DEFAULT:Drop_Indicator_),residentialorbusinessindicator(DEFAULT:Residential_Or_Business_Indicator_),onlywaytogetmailindicator(DEFAULT:Only_Way_To_Get_Mail_Indicator_),recordtypecode(DEFAULT:Record_Type_Code_),addresstypecode(DEFAULT:Address_Type_Code_),mixedusagecode(DEFAULT:Mixed_Usage_Code_),vacationbegindate(DEFAULT:Vacation_Begin_Date_:DATE),vacationenddate(DEFAULT:Vacation_End_Date_:DATE),numberofcurrentvacationmonths(DEFAULT:Number_Of_Current_Vacation_Months_),maxvacationmonths(DEFAULT:Max_Vacation_Months_),vacationperiodscount(DEFAULT:Vacation_Periods_Count_),companyaddresstyperaw(DEFAULT:Company_Address_Type_Raw_:\'\'),companyaddresstypederived(DEFAULT:Company_Address_Type_Derived_:\'\'),addresstypederived(DEFAULT:Address_Type_Derived_:\'\'),addressmethod(DEFAULT:Address_Method_:\'\'),isactive(DEFAULT:Is_Active_:\'\'),isdefunct(DEFAULT:Is_Defunct_:\'\'),address_type(DEFAULT:Address___Type_:\'\'),address_desc(DEFAULT:Address___Desc_:\'\'),src(OVERRIDE:Source_:\'\'),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_17Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_17Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED InLayout __Mapping17_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d17_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Header_Address,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Header_Address),SELF:=RIGHT));
  SHARED __d17_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Doxie__Key_Header_Address);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d17_UID_Mapped := JOIN(__d17_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d17_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Address_Invalid := __d17_UID_Mapped(UID = 0);
  SHARED __d17_Prefiltered := __d17_UID_Mapped(UID <> 0);
  SHARED __d17 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d17_Prefiltered,InLayout,__Mapping17,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping17_Transform(LEFT)));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6 + __d7 + __d8 + __d9 + __d10 + __d11 + __d12 + __d13 + __d14 + __d15 + __d16 + __d17;
  EXPORT College_Layout := RECORD
    KEL.typ.nstr College_Indicator_;
    KEL.typ.nstr College_Start_Suppression_Date_;
    KEL.typ.nstr College_End_Suppression_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT A_D_V_O_Date_Summary_Layout := RECORD
    KEL.typ.nkdate A_D_V_O_Date_First_Seen_;
    KEL.typ.nkdate A_D_V_O_Date_Last_Seen_;
    KEL.typ.nkdate A_D_V_O_Date_Vendor_First_Reported_;
    KEL.typ.nkdate A_D_V_O_Date_Vendor_Last_Reported_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
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
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT B_I_P_V2_Best_Layout := RECORD
    KEL.typ.nstr Address_Method_;
    KEL.typ.nstr Is_Active_;
    KEL.typ.nstr Is_Defunct_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Do_Not_Deliver_Layout := RECORD
    KEL.typ.nstr Do_Not_Deliver_Indicator_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Do_Not_Mail_Layout := RECORD
    KEL.typ.nstr Do_Not_Mail_Indicator_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Dead_C_O_Layout := RECORD
    KEL.typ.nstr Dead_C_O_Indicator_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Hot_List_Layout := RECORD
    KEL.typ.nstr Hot_List_Indicator_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Mail_Drop_Layout := RECORD
    KEL.typ.nstr Drop_Indicator_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Mixed_Usage_Layout := RECORD
    KEL.typ.nstr Mixed_Usage_Code_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Only_Way_To_Get_Mail_Layout := RECORD
    KEL.typ.nstr Only_Way_To_Get_Mail_Indicator_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Record_Type_Layout := RECORD
    KEL.typ.nstr Record_Type_Code_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Address_Type_Layout := RECORD
    KEL.typ.nstr Address_Type_Code_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Residential_Or_Business_Layout := RECORD
    KEL.typ.nstr Residential_Or_Business_Indicator_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Seasonal_Delivery_Layout := RECORD
    KEL.typ.nstr Seasonal_Delivery_Indicator_;
    KEL.typ.nstr Seasonal_Start_Suppression_Date_;
    KEL.typ.nstr Seasonal_End_Suppression_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Simplify_Layout := RECORD
    KEL.typ.nint Simplify_Count_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Style_Layout := RECORD
    KEL.typ.nstr Style_Code_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Throw_Back_Layout := RECORD
    KEL.typ.nstr Throw_Back_Indicator_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Vacancy_Layout := RECORD
    KEL.typ.nstr Vacancy_Indicator_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
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
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
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
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
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
    SELF.Unit_Designation_ := KEL.Intake.SingleValue(__recs,Unit_Designation_);
    SELF.Secondary_Range_ := KEL.Intake.SingleValue(__recs,Secondary_Range_);
    SELF.Postal_City_ := KEL.Intake.SingleValue(__recs,Postal_City_);
    SELF.Vanity_City_ := KEL.Intake.SingleValue(__recs,Vanity_City_);
    SELF.State_ := KEL.Intake.SingleValue(__recs,State_);
    SELF.Z_I_P5_ := KEL.Intake.SingleValue(__recs,Z_I_P5_);
    SELF.Z_I_P4_ := KEL.Intake.SingleValue(__recs,Z_I_P4_);
    SELF.Append_Raw_A_I_D_ := KEL.Intake.SingleValue(__recs,Append_Raw_A_I_D_);
    SELF.Carrier_Route_Number_ := KEL.Intake.SingleValue(__recs,Carrier_Route_Number_);
    SELF.Carrier_Route_Sortation_At_Z_I_P_ := KEL.Intake.SingleValue(__recs,Carrier_Route_Sortation_At_Z_I_P_);
    SELF.Line_Of_Travel_ := KEL.Intake.SingleValue(__recs,Line_Of_Travel_);
    SELF.Line_Of_Travel_Order_ := KEL.Intake.SingleValue(__recs,Line_Of_Travel_Order_);
    SELF.Delivery_Point_Barcode_ := KEL.Intake.SingleValue(__recs,Delivery_Point_Barcode_);
    SELF.Delivery_Point_Barcode_Check_Digit_ := KEL.Intake.SingleValue(__recs,Delivery_Point_Barcode_Check_Digit_);
    SELF.Type_Code_ := KEL.Intake.SingleValue(__recs,Type_Code_);
    SELF.County_ := KEL.Intake.SingleValue(__recs,County_);
    SELF.Latitude_ := KEL.Intake.SingleValue(__recs,Latitude_);
    SELF.Longitude_ := KEL.Intake.SingleValue(__recs,Longitude_);
    SELF.Metropolitan_Statistical_Area_ := KEL.Intake.SingleValue(__recs,Metropolitan_Statistical_Area_);
    SELF.Geo_Block_ := KEL.Intake.SingleValue(__recs,Geo_Block_);
    SELF.Geo_Match_ := KEL.Intake.SingleValue(__recs,Geo_Match_);
    SELF.A_C_E_Cleaner_Error_Code_ := KEL.Intake.SingleValue(__recs,A_C_E_Cleaner_Error_Code_);
    SELF.College_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),College_Indicator_,College_Start_Suppression_Date_,College_End_Suppression_Date_},College_Indicator_,College_Start_Suppression_Date_,College_End_Suppression_Date_),College_Layout)(__NN(College_Indicator_) OR __NN(College_Start_Suppression_Date_) OR __NN(College_End_Suppression_Date_)));
    SELF.A_D_V_O_Date_Summary_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),A_D_V_O_Date_First_Seen_,A_D_V_O_Date_Last_Seen_,A_D_V_O_Date_Vendor_First_Reported_,A_D_V_O_Date_Vendor_Last_Reported_},A_D_V_O_Date_First_Seen_,A_D_V_O_Date_Last_Seen_,A_D_V_O_Date_Vendor_First_Reported_,A_D_V_O_Date_Vendor_Last_Reported_),A_D_V_O_Date_Summary_Layout)(__NN(A_D_V_O_Date_First_Seen_) OR __NN(A_D_V_O_Date_Last_Seen_) OR __NN(A_D_V_O_Date_Vendor_First_Reported_) OR __NN(A_D_V_O_Date_Vendor_Last_Reported_)));
    SELF.Business_Characteristics_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Company_Address_Type_Raw_,Company_Address_Type_Derived_,Address_Type_Derived_,Address___Type_,Address___Desc_},Company_Address_Type_Raw_,Company_Address_Type_Derived_,Address_Type_Derived_,Address___Type_,Address___Desc_),Business_Characteristics_Layout)(__NN(Company_Address_Type_Raw_) OR __NN(Company_Address_Type_Derived_) OR __NN(Address_Type_Derived_) OR __NN(Address___Type_) OR __NN(Address___Desc_)));
    SELF.B_I_P_V2_Best_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Address_Method_,Is_Active_,Is_Defunct_},Address_Method_,Is_Active_,Is_Defunct_),B_I_P_V2_Best_Layout)(__NN(Address_Method_) OR __NN(Is_Active_) OR __NN(Is_Defunct_)));
    SELF.Do_Not_Deliver_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Do_Not_Deliver_Indicator_},Do_Not_Deliver_Indicator_),Do_Not_Deliver_Layout)(__NN(Do_Not_Deliver_Indicator_)));
    SELF.Do_Not_Mail_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Do_Not_Mail_Indicator_},Do_Not_Mail_Indicator_),Do_Not_Mail_Layout)(__NN(Do_Not_Mail_Indicator_)));
    SELF.Dead_C_O_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Dead_C_O_Indicator_},Dead_C_O_Indicator_),Dead_C_O_Layout)(__NN(Dead_C_O_Indicator_)));
    SELF.Hot_List_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Hot_List_Indicator_},Hot_List_Indicator_),Hot_List_Layout)(__NN(Hot_List_Indicator_)));
    SELF.Mail_Drop_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Drop_Indicator_},Drop_Indicator_),Mail_Drop_Layout)(__NN(Drop_Indicator_)));
    SELF.Mixed_Usage_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Mixed_Usage_Code_},Mixed_Usage_Code_),Mixed_Usage_Layout)(__NN(Mixed_Usage_Code_)));
    SELF.Only_Way_To_Get_Mail_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Only_Way_To_Get_Mail_Indicator_},Only_Way_To_Get_Mail_Indicator_),Only_Way_To_Get_Mail_Layout)(__NN(Only_Way_To_Get_Mail_Indicator_)));
    SELF.Record_Type_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Record_Type_Code_},Record_Type_Code_),Record_Type_Layout)(__NN(Record_Type_Code_)));
    SELF.Address_Type_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Address_Type_Code_},Address_Type_Code_),Address_Type_Layout)(__NN(Address_Type_Code_)));
    SELF.Residential_Or_Business_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Residential_Or_Business_Indicator_},Residential_Or_Business_Indicator_),Residential_Or_Business_Layout)(__NN(Residential_Or_Business_Indicator_)));
    SELF.Seasonal_Delivery_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Seasonal_Delivery_Indicator_,Seasonal_Start_Suppression_Date_,Seasonal_End_Suppression_Date_},Seasonal_Delivery_Indicator_,Seasonal_Start_Suppression_Date_,Seasonal_End_Suppression_Date_),Seasonal_Delivery_Layout)(__NN(Seasonal_Delivery_Indicator_) OR __NN(Seasonal_Start_Suppression_Date_) OR __NN(Seasonal_End_Suppression_Date_)));
    SELF.Simplify_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Simplify_Count_},Simplify_Count_),Simplify_Layout)(__NN(Simplify_Count_)));
    SELF.Style_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Style_Code_},Style_Code_),Style_Layout)(__NN(Style_Code_)));
    SELF.Throw_Back_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Throw_Back_Indicator_},Throw_Back_Indicator_),Throw_Back_Layout)(__NN(Throw_Back_Indicator_)));
    SELF.Vacancy_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Vacancy_Indicator_},Vacancy_Indicator_),Vacancy_Layout)(__NN(Vacancy_Indicator_)));
    SELF.Vacation_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Number_Of_Current_Vacation_Months_,Max_Vacation_Months_,Vacation_Periods_Count_,Vacation_Begin_Date_,Vacation_End_Date_},Number_Of_Current_Vacation_Months_,Max_Vacation_Months_,Vacation_Periods_Count_,Vacation_Begin_Date_,Vacation_End_Date_),Vacation_Layout)(__NN(Number_Of_Current_Vacation_Months_) OR __NN(Max_Vacation_Months_) OR __NN(Vacation_Periods_Count_) OR __NN(Vacation_Begin_Date_) OR __NN(Vacation_End_Date_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_,Header_Hit_Flag_},Source_,Header_Hit_Flag_),Data_Sources_Layout)(__NN(Source_) OR __NN(Header_Hit_Flag_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Address__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.College_ := __CN(PROJECT(DATASET(__r),TRANSFORM(College_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(College_Indicator_) OR __NN(College_Start_Suppression_Date_) OR __NN(College_End_Suppression_Date_)));
    SELF.A_D_V_O_Date_Summary_ := __CN(PROJECT(DATASET(__r),TRANSFORM(A_D_V_O_Date_Summary_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(A_D_V_O_Date_First_Seen_) OR __NN(A_D_V_O_Date_Last_Seen_) OR __NN(A_D_V_O_Date_Vendor_First_Reported_) OR __NN(A_D_V_O_Date_Vendor_Last_Reported_)));
    SELF.Business_Characteristics_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Business_Characteristics_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Company_Address_Type_Raw_) OR __NN(Company_Address_Type_Derived_) OR __NN(Address_Type_Derived_) OR __NN(Address___Type_) OR __NN(Address___Desc_)));
    SELF.B_I_P_V2_Best_ := __CN(PROJECT(DATASET(__r),TRANSFORM(B_I_P_V2_Best_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Address_Method_) OR __NN(Is_Active_) OR __NN(Is_Defunct_)));
    SELF.Do_Not_Deliver_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Do_Not_Deliver_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Do_Not_Deliver_Indicator_)));
    SELF.Do_Not_Mail_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Do_Not_Mail_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Do_Not_Mail_Indicator_)));
    SELF.Dead_C_O_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Dead_C_O_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Dead_C_O_Indicator_)));
    SELF.Hot_List_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Hot_List_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Hot_List_Indicator_)));
    SELF.Mail_Drop_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Mail_Drop_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Drop_Indicator_)));
    SELF.Mixed_Usage_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Mixed_Usage_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Mixed_Usage_Code_)));
    SELF.Only_Way_To_Get_Mail_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Only_Way_To_Get_Mail_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Only_Way_To_Get_Mail_Indicator_)));
    SELF.Record_Type_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Record_Type_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Record_Type_Code_)));
    SELF.Address_Type_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Address_Type_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Address_Type_Code_)));
    SELF.Residential_Or_Business_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Residential_Or_Business_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Residential_Or_Business_Indicator_)));
    SELF.Seasonal_Delivery_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Seasonal_Delivery_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Seasonal_Delivery_Indicator_) OR __NN(Seasonal_Start_Suppression_Date_) OR __NN(Seasonal_End_Suppression_Date_)));
    SELF.Simplify_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Simplify_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Simplify_Count_)));
    SELF.Style_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Style_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Style_Code_)));
    SELF.Throw_Back_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Throw_Back_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Throw_Back_Indicator_)));
    SELF.Vacancy_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Vacancy_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Vacancy_Indicator_)));
    SELF.Vacation_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Vacation_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Number_Of_Current_Vacation_Months_) OR __NN(Max_Vacation_Months_) OR __NN(Vacation_Periods_Count_) OR __NN(Vacation_Begin_Date_) OR __NN(Vacation_End_Date_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Source_) OR __NN(Header_Hit_Flag_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Address_Group,COUNT(ROWS(LEFT))=1),GROUP,Address__Single_Rollup(LEFT)) + ROLLUP(HAVING(Address_Group,COUNT(ROWS(LEFT))>1),GROUP,Address__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Primary_Range__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Primary_Range_);
  EXPORT Predirectional__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Predirectional_);
  EXPORT Primary_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Primary_Name_);
  EXPORT Suffix__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Suffix_);
  EXPORT Postdirectional__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Postdirectional_);
  EXPORT Unit_Designation__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Unit_Designation_);
  EXPORT Secondary_Range__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Secondary_Range_);
  EXPORT Postal_City__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Postal_City_);
  EXPORT Vanity_City__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Vanity_City_);
  EXPORT State__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,State_);
  EXPORT Z_I_P5__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Z_I_P5_);
  EXPORT Z_I_P4__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Z_I_P4_);
  EXPORT Append_Raw_A_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Append_Raw_A_I_D_);
  EXPORT Carrier_Route_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Carrier_Route_Number_);
  EXPORT Carrier_Route_Sortation_At_Z_I_P__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Carrier_Route_Sortation_At_Z_I_P_);
  EXPORT Line_Of_Travel__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Line_Of_Travel_);
  EXPORT Line_Of_Travel_Order__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Line_Of_Travel_Order_);
  EXPORT Delivery_Point_Barcode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Delivery_Point_Barcode_);
  EXPORT Delivery_Point_Barcode_Check_Digit__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Delivery_Point_Barcode_Check_Digit_);
  EXPORT Type_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Type_Code_);
  EXPORT County__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,County_);
  EXPORT Latitude__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Latitude_);
  EXPORT Longitude__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Longitude_);
  EXPORT Metropolitan_Statistical_Area__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Metropolitan_Statistical_Area_);
  EXPORT Geo_Block__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Geo_Block_);
  EXPORT Geo_Match__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Geo_Match_);
  EXPORT A_C_E_Cleaner_Error_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,A_C_E_Cleaner_Error_Code_);
  EXPORT Z_I_P5__Orphan := JOIN(InData(__NN(Z_I_P5_)),E_Zip_Code(__in,__cfg).__Result,__EEQP(LEFT.Z_I_P5_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Z_I_P5__Orphan),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2__Key_BH_Linking_kfetch2_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_ADVO__Key_Addr1_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_ADVO__Key_Addr1_History_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DMA__Key_DNM_Name_Address_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Fraudpoint3__Key_Address_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_DID_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_USPIS_HotList__key_addr_search_zip_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Key_Address_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Key_DID_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DX_Email__Key_Email_Payload_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Corp2__Kfetch_LinkIDs_Corp_1_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Corp2__Kfetch_LinkIDs_Corp_2_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Corp2__Kfetch_LinkIDs_Corp_3_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_InfoUSA__Key_DEADCO_LinkIds_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Kfetch2_LinkIds_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Address_Invalid),COUNT(Primary_Range__SingleValue_Invalid),COUNT(Predirectional__SingleValue_Invalid),COUNT(Primary_Name__SingleValue_Invalid),COUNT(Suffix__SingleValue_Invalid),COUNT(Postdirectional__SingleValue_Invalid),COUNT(Unit_Designation__SingleValue_Invalid),COUNT(Secondary_Range__SingleValue_Invalid),COUNT(Postal_City__SingleValue_Invalid),COUNT(Vanity_City__SingleValue_Invalid),COUNT(State__SingleValue_Invalid),COUNT(Z_I_P5__SingleValue_Invalid),COUNT(Z_I_P4__SingleValue_Invalid),COUNT(Append_Raw_A_I_D__SingleValue_Invalid),COUNT(Carrier_Route_Number__SingleValue_Invalid),COUNT(Carrier_Route_Sortation_At_Z_I_P__SingleValue_Invalid),COUNT(Line_Of_Travel__SingleValue_Invalid),COUNT(Line_Of_Travel_Order__SingleValue_Invalid),COUNT(Delivery_Point_Barcode__SingleValue_Invalid),COUNT(Delivery_Point_Barcode_Check_Digit__SingleValue_Invalid),COUNT(Type_Code__SingleValue_Invalid),COUNT(County__SingleValue_Invalid),COUNT(Latitude__SingleValue_Invalid),COUNT(Longitude__SingleValue_Invalid),COUNT(Metropolitan_Statistical_Area__SingleValue_Invalid),COUNT(Geo_Block__SingleValue_Invalid),COUNT(Geo_Match__SingleValue_Invalid),COUNT(A_C_E_Cleaner_Error_Code__SingleValue_Invalid)}],{KEL.typ.int Z_I_P5__Orphan,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2__Key_BH_Linking_kfetch2_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_ADVO__Key_Addr1_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_ADVO__Key_Addr1_History_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DMA__Key_DNM_Name_Address_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Fraudpoint3__Key_Address_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_DID_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_USPIS_HotList__key_addr_search_zip_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Key_Address_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Key_DID_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DX_Email__Key_Email_Payload_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Corp2__Kfetch_LinkIDs_Corp_1_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Corp2__Kfetch_LinkIDs_Corp_2_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Corp2__Kfetch_LinkIDs_Corp_3_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_InfoUSA__Key_DEADCO_LinkIds_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Kfetch2_LinkIds_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Address_Invalid,KEL.typ.int Primary_Range__SingleValue_Invalid,KEL.typ.int Predirectional__SingleValue_Invalid,KEL.typ.int Primary_Name__SingleValue_Invalid,KEL.typ.int Suffix__SingleValue_Invalid,KEL.typ.int Postdirectional__SingleValue_Invalid,KEL.typ.int Unit_Designation__SingleValue_Invalid,KEL.typ.int Secondary_Range__SingleValue_Invalid,KEL.typ.int Postal_City__SingleValue_Invalid,KEL.typ.int Vanity_City__SingleValue_Invalid,KEL.typ.int State__SingleValue_Invalid,KEL.typ.int Z_I_P5__SingleValue_Invalid,KEL.typ.int Z_I_P4__SingleValue_Invalid,KEL.typ.int Append_Raw_A_I_D__SingleValue_Invalid,KEL.typ.int Carrier_Route_Number__SingleValue_Invalid,KEL.typ.int Carrier_Route_Sortation_At_Z_I_P__SingleValue_Invalid,KEL.typ.int Line_Of_Travel__SingleValue_Invalid,KEL.typ.int Line_Of_Travel_Order__SingleValue_Invalid,KEL.typ.int Delivery_Point_Barcode__SingleValue_Invalid,KEL.typ.int Delivery_Point_Barcode_Check_Digit__SingleValue_Invalid,KEL.typ.int Type_Code__SingleValue_Invalid,KEL.typ.int County__SingleValue_Invalid,KEL.typ.int Latitude__SingleValue_Invalid,KEL.typ.int Longitude__SingleValue_Invalid,KEL.typ.int Metropolitan_Statistical_Area__SingleValue_Invalid,KEL.typ.int Geo_Block__SingleValue_Invalid,KEL.typ.int Geo_Match__SingleValue_Invalid,KEL.typ.int A_C_E_Cleaner_Error_Code__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid),COUNT(__d0)},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d0(__NL(Primary_Range_))),COUNT(__d0(__NN(Primary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d0(__NL(Predirectional_))),COUNT(__d0(__NN(Predirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d0(__NL(Primary_Name_))),COUNT(__d0(__NN(Primary_Name_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d0(__NL(Suffix_))),COUNT(__d0(__NN(Suffix_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d0(__NL(Postdirectional_))),COUNT(__d0(__NN(Postdirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','unit_desig',COUNT(__d0(__NL(Unit_Designation_))),COUNT(__d0(__NN(Unit_Designation_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d0(__NL(Secondary_Range_))),COUNT(__d0(__NN(Secondary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PostalCity',COUNT(__d0(__NL(Postal_City_))),COUNT(__d0(__NN(Postal_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VanityCity',COUNT(__d0(__NL(Vanity_City_))),COUNT(__d0(__NN(Vanity_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d0(__NL(State_))),COUNT(__d0(__NN(State_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d0(__NL(Z_I_P5_))),COUNT(__d0(__NN(Z_I_P5_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip4',COUNT(__d0(__NL(Z_I_P4_))),COUNT(__d0(__NN(Z_I_P4_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AppendRawAID',COUNT(__d0(__NL(Append_Raw_A_I_D_))),COUNT(__d0(__NN(Append_Raw_A_I_D_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteNumber',COUNT(__d0(__NL(Carrier_Route_Number_))),COUNT(__d0(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteSortationAtZIP',COUNT(__d0(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d0(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravel',COUNT(__d0(__NL(Line_Of_Travel_))),COUNT(__d0(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravelOrder',COUNT(__d0(__NL(Line_Of_Travel_Order_))),COUNT(__d0(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcode',COUNT(__d0(__NL(Delivery_Point_Barcode_))),COUNT(__d0(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcodeCheckDigit',COUNT(__d0(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d0(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeCode',COUNT(__d0(__NL(Type_Code_))),COUNT(__d0(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','county',COUNT(__d0(__NL(County_))),COUNT(__d0(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Latitude',COUNT(__d0(__NL(Latitude_))),COUNT(__d0(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Longitude',COUNT(__d0(__NL(Longitude_))),COUNT(__d0(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d0(__NL(Metropolitan_Statistical_Area_))),COUNT(__d0(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_blk',COUNT(__d0(__NL(Geo_Block_))),COUNT(__d0(__NN(Geo_Block_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoMatch',COUNT(__d0(__NL(Geo_Match_))),COUNT(__d0(__NN(Geo_Match_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ACECleanerErrorCode',COUNT(__d0(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d0(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_first_seen',COUNT(__d0(__NL(A_D_V_O_Date_First_Seen_))),COUNT(__d0(__NN(A_D_V_O_Date_First_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_last_seen',COUNT(__d0(__NL(A_D_V_O_Date_Last_Seen_))),COUNT(__d0(__NN(A_D_V_O_Date_Last_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_first_reported',COUNT(__d0(__NL(A_D_V_O_Date_Vendor_First_Reported_))),COUNT(__d0(__NN(A_D_V_O_Date_Vendor_First_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_last_reported',COUNT(__d0(__NL(A_D_V_O_Date_Vendor_Last_Reported_))),COUNT(__d0(__NN(A_D_V_O_Date_Vendor_Last_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacancyIndicator',COUNT(__d0(__NL(Vacancy_Indicator_))),COUNT(__d0(__NN(Vacancy_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThrowBackIndicator',COUNT(__d0(__NL(Throw_Back_Indicator_))),COUNT(__d0(__NN(Throw_Back_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalDeliveryIndicator',COUNT(__d0(__NL(Seasonal_Delivery_Indicator_))),COUNT(__d0(__NN(Seasonal_Delivery_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalStartSuppressionDate',COUNT(__d0(__NL(Seasonal_Start_Suppression_Date_))),COUNT(__d0(__NN(Seasonal_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalEndSuppressionDate',COUNT(__d0(__NL(Seasonal_End_Suppression_Date_))),COUNT(__d0(__NN(Seasonal_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotDeliverIndicator',COUNT(__d0(__NL(Do_Not_Deliver_Indicator_))),COUNT(__d0(__NN(Do_Not_Deliver_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotMailIndicator',COUNT(__d0(__NL(Do_Not_Mail_Indicator_))),COUNT(__d0(__NN(Do_Not_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeadCOIndicator',COUNT(__d0(__NL(Dead_C_O_Indicator_))),COUNT(__d0(__NN(Dead_C_O_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HotListIndicator',COUNT(__d0(__NL(Hot_List_Indicator_))),COUNT(__d0(__NN(Hot_List_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeIndicator',COUNT(__d0(__NL(College_Indicator_))),COUNT(__d0(__NN(College_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeStartSuppressionDate',COUNT(__d0(__NL(College_Start_Suppression_Date_))),COUNT(__d0(__NN(College_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeEndSuppressionDate',COUNT(__d0(__NL(College_End_Suppression_Date_))),COUNT(__d0(__NN(College_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StyleCode',COUNT(__d0(__NL(Style_Code_))),COUNT(__d0(__NN(Style_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SimplifyCount',COUNT(__d0(__NL(Simplify_Count_))),COUNT(__d0(__NN(Simplify_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DropIndicator',COUNT(__d0(__NL(Drop_Indicator_))),COUNT(__d0(__NN(Drop_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ResidentialOrBusinessIndicator',COUNT(__d0(__NL(Residential_Or_Business_Indicator_))),COUNT(__d0(__NN(Residential_Or_Business_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OnlyWayToGetMailIndicator',COUNT(__d0(__NL(Only_Way_To_Get_Mail_Indicator_))),COUNT(__d0(__NN(Only_Way_To_Get_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec_type',COUNT(__d0(__NL(Record_Type_Code_))),COUNT(__d0(__NN(Record_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeCode',COUNT(__d0(__NL(Address_Type_Code_))),COUNT(__d0(__NN(Address_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MixedUsageCode',COUNT(__d0(__NL(Mixed_Usage_Code_))),COUNT(__d0(__NN(Mixed_Usage_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationBeginDate',COUNT(__d0(__NL(Vacation_Begin_Date_))),COUNT(__d0(__NN(Vacation_Begin_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationEndDate',COUNT(__d0(__NL(Vacation_End_Date_))),COUNT(__d0(__NN(Vacation_End_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfCurrentVacationMonths',COUNT(__d0(__NL(Number_Of_Current_Vacation_Months_))),COUNT(__d0(__NN(Number_Of_Current_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaxVacationMonths',COUNT(__d0(__NL(Max_Vacation_Months_))),COUNT(__d0(__NN(Max_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationPeriodsCount',COUNT(__d0(__NL(Vacation_Periods_Count_))),COUNT(__d0(__NN(Vacation_Periods_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d0(__NL(Company_Address_Type_Raw_))),COUNT(__d0(__NN(Company_Address_Type_Raw_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d0(__NL(Company_Address_Type_Derived_))),COUNT(__d0(__NN(Company_Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d0(__NL(Address_Type_Derived_))),COUNT(__d0(__NN(Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressMethod',COUNT(__d0(__NL(Address_Method_))),COUNT(__d0(__NN(Address_Method_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d0(__NL(Is_Active_))),COUNT(__d0(__NN(Is_Active_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDefunct',COUNT(__d0(__NL(Is_Defunct_))),COUNT(__d0(__NN(Is_Defunct_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Type',COUNT(__d0(__NL(Address___Type_))),COUNT(__d0(__NN(Address___Type_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Desc',COUNT(__d0(__NL(Address___Desc_))),COUNT(__d0(__NN(Address___Desc_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d0(__NL(Header_Hit_Flag_))),COUNT(__d0(__NN(Header_Hit_Flag_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid),COUNT(__d1)},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d1(__NL(Primary_Range_))),COUNT(__d1(__NN(Primary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d1(__NL(Predirectional_))),COUNT(__d1(__NN(Predirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d1(__NL(Primary_Name_))),COUNT(__d1(__NN(Primary_Name_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d1(__NL(Suffix_))),COUNT(__d1(__NN(Suffix_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d1(__NL(Postdirectional_))),COUNT(__d1(__NN(Postdirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','unit_desig',COUNT(__d1(__NL(Unit_Designation_))),COUNT(__d1(__NN(Unit_Designation_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d1(__NL(Secondary_Range_))),COUNT(__d1(__NN(Secondary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PostalCity',COUNT(__d1(__NL(Postal_City_))),COUNT(__d1(__NN(Postal_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VanityCity',COUNT(__d1(__NL(Vanity_City_))),COUNT(__d1(__NN(Vanity_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d1(__NL(State_))),COUNT(__d1(__NN(State_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d1(__NL(Z_I_P5_))),COUNT(__d1(__NN(Z_I_P5_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip4',COUNT(__d1(__NL(Z_I_P4_))),COUNT(__d1(__NN(Z_I_P4_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AppendRawAID',COUNT(__d1(__NL(Append_Raw_A_I_D_))),COUNT(__d1(__NN(Append_Raw_A_I_D_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteNumber',COUNT(__d1(__NL(Carrier_Route_Number_))),COUNT(__d1(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteSortationAtZIP',COUNT(__d1(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d1(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravel',COUNT(__d1(__NL(Line_Of_Travel_))),COUNT(__d1(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravelOrder',COUNT(__d1(__NL(Line_Of_Travel_Order_))),COUNT(__d1(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcode',COUNT(__d1(__NL(Delivery_Point_Barcode_))),COUNT(__d1(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcodeCheckDigit',COUNT(__d1(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d1(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeCode',COUNT(__d1(__NL(Type_Code_))),COUNT(__d1(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','county',COUNT(__d1(__NL(County_))),COUNT(__d1(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Latitude',COUNT(__d1(__NL(Latitude_))),COUNT(__d1(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Longitude',COUNT(__d1(__NL(Longitude_))),COUNT(__d1(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d1(__NL(Metropolitan_Statistical_Area_))),COUNT(__d1(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_blk',COUNT(__d1(__NL(Geo_Block_))),COUNT(__d1(__NN(Geo_Block_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoMatch',COUNT(__d1(__NL(Geo_Match_))),COUNT(__d1(__NN(Geo_Match_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ACECleanerErrorCode',COUNT(__d1(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d1(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_first_seen',COUNT(__d1(__NL(A_D_V_O_Date_First_Seen_))),COUNT(__d1(__NN(A_D_V_O_Date_First_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_last_seen',COUNT(__d1(__NL(A_D_V_O_Date_Last_Seen_))),COUNT(__d1(__NN(A_D_V_O_Date_Last_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_first_reported',COUNT(__d1(__NL(A_D_V_O_Date_Vendor_First_Reported_))),COUNT(__d1(__NN(A_D_V_O_Date_Vendor_First_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_last_reported',COUNT(__d1(__NL(A_D_V_O_Date_Vendor_Last_Reported_))),COUNT(__d1(__NN(A_D_V_O_Date_Vendor_Last_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacancyIndicator',COUNT(__d1(__NL(Vacancy_Indicator_))),COUNT(__d1(__NN(Vacancy_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThrowBackIndicator',COUNT(__d1(__NL(Throw_Back_Indicator_))),COUNT(__d1(__NN(Throw_Back_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalDeliveryIndicator',COUNT(__d1(__NL(Seasonal_Delivery_Indicator_))),COUNT(__d1(__NN(Seasonal_Delivery_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalStartSuppressionDate',COUNT(__d1(__NL(Seasonal_Start_Suppression_Date_))),COUNT(__d1(__NN(Seasonal_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalEndSuppressionDate',COUNT(__d1(__NL(Seasonal_End_Suppression_Date_))),COUNT(__d1(__NN(Seasonal_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotDeliverIndicator',COUNT(__d1(__NL(Do_Not_Deliver_Indicator_))),COUNT(__d1(__NN(Do_Not_Deliver_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotMailIndicator',COUNT(__d1(__NL(Do_Not_Mail_Indicator_))),COUNT(__d1(__NN(Do_Not_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeadCOIndicator',COUNT(__d1(__NL(Dead_C_O_Indicator_))),COUNT(__d1(__NN(Dead_C_O_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HotListIndicator',COUNT(__d1(__NL(Hot_List_Indicator_))),COUNT(__d1(__NN(Hot_List_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeIndicator',COUNT(__d1(__NL(College_Indicator_))),COUNT(__d1(__NN(College_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeStartSuppressionDate',COUNT(__d1(__NL(College_Start_Suppression_Date_))),COUNT(__d1(__NN(College_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeEndSuppressionDate',COUNT(__d1(__NL(College_End_Suppression_Date_))),COUNT(__d1(__NN(College_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StyleCode',COUNT(__d1(__NL(Style_Code_))),COUNT(__d1(__NN(Style_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SimplifyCount',COUNT(__d1(__NL(Simplify_Count_))),COUNT(__d1(__NN(Simplify_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DropIndicator',COUNT(__d1(__NL(Drop_Indicator_))),COUNT(__d1(__NN(Drop_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ResidentialOrBusinessIndicator',COUNT(__d1(__NL(Residential_Or_Business_Indicator_))),COUNT(__d1(__NN(Residential_Or_Business_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OnlyWayToGetMailIndicator',COUNT(__d1(__NL(Only_Way_To_Get_Mail_Indicator_))),COUNT(__d1(__NN(Only_Way_To_Get_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec_type',COUNT(__d1(__NL(Record_Type_Code_))),COUNT(__d1(__NN(Record_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeCode',COUNT(__d1(__NL(Address_Type_Code_))),COUNT(__d1(__NN(Address_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MixedUsageCode',COUNT(__d1(__NL(Mixed_Usage_Code_))),COUNT(__d1(__NN(Mixed_Usage_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationBeginDate',COUNT(__d1(__NL(Vacation_Begin_Date_))),COUNT(__d1(__NN(Vacation_Begin_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationEndDate',COUNT(__d1(__NL(Vacation_End_Date_))),COUNT(__d1(__NN(Vacation_End_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfCurrentVacationMonths',COUNT(__d1(__NL(Number_Of_Current_Vacation_Months_))),COUNT(__d1(__NN(Number_Of_Current_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaxVacationMonths',COUNT(__d1(__NL(Max_Vacation_Months_))),COUNT(__d1(__NN(Max_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationPeriodsCount',COUNT(__d1(__NL(Vacation_Periods_Count_))),COUNT(__d1(__NN(Vacation_Periods_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d1(__NL(Company_Address_Type_Raw_))),COUNT(__d1(__NN(Company_Address_Type_Raw_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d1(__NL(Company_Address_Type_Derived_))),COUNT(__d1(__NN(Company_Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d1(__NL(Address_Type_Derived_))),COUNT(__d1(__NN(Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressMethod',COUNT(__d1(__NL(Address_Method_))),COUNT(__d1(__NN(Address_Method_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d1(__NL(Is_Active_))),COUNT(__d1(__NN(Is_Active_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDefunct',COUNT(__d1(__NL(Is_Defunct_))),COUNT(__d1(__NN(Is_Defunct_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Type',COUNT(__d1(__NL(Address___Type_))),COUNT(__d1(__NN(Address___Type_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Desc',COUNT(__d1(__NL(Address___Desc_))),COUNT(__d1(__NN(Address___Desc_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d1(__NL(Header_Hit_Flag_))),COUNT(__d1(__NN(Header_Hit_Flag_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2__Key_BH_Linking_kfetch2_Invalid),COUNT(__d2)},
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
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','msa',COUNT(__d2(__NL(Metropolitan_Statistical_Area_))),COUNT(__d2(__NN(Metropolitan_Statistical_Area_)))},
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
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotMailIndicator',COUNT(__d2(__NL(Do_Not_Mail_Indicator_))),COUNT(__d2(__NN(Do_Not_Mail_Indicator_)))},
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
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_address_type_raw',COUNT(__d2(__NL(Company_Address_Type_Raw_))),COUNT(__d2(__NN(Company_Address_Type_Raw_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','company_address_type_derived',COUNT(__d2(__NL(Company_Address_Type_Derived_))),COUNT(__d2(__NN(Company_Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','address_type_derived',COUNT(__d2(__NL(Address_Type_Derived_))),COUNT(__d2(__NN(Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressMethod',COUNT(__d2(__NL(Address_Method_))),COUNT(__d2(__NN(Address_Method_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d2(__NL(Is_Active_))),COUNT(__d2(__NN(Is_Active_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDefunct',COUNT(__d2(__NL(Is_Defunct_))),COUNT(__d2(__NN(Is_Defunct_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Type',COUNT(__d2(__NL(Address___Type_))),COUNT(__d2(__NN(Address___Type_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Desc',COUNT(__d2(__NL(Address___Desc_))),COUNT(__d2(__NN(Address___Desc_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d2(__NL(Header_Hit_Flag_))),COUNT(__d2(__NN(Header_Hit_Flag_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_ADVO__Key_Addr1_Invalid),COUNT(__d3)},
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
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cart',COUNT(__d3(__NL(Carrier_Route_Number_))),COUNT(__d3(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cr_sort_sz',COUNT(__d3(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d3(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lot',COUNT(__d3(__NL(Line_Of_Travel_))),COUNT(__d3(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lot_order',COUNT(__d3(__NL(Line_Of_Travel_Order_))),COUNT(__d3(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dbpc',COUNT(__d3(__NL(Delivery_Point_Barcode_))),COUNT(__d3(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','chk_digit',COUNT(__d3(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d3(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec_type',COUNT(__d3(__NL(Type_Code_))),COUNT(__d3(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','county',COUNT(__d3(__NL(County_))),COUNT(__d3(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_lat',COUNT(__d3(__NL(Latitude_))),COUNT(__d3(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_long',COUNT(__d3(__NL(Longitude_))),COUNT(__d3(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','msa',COUNT(__d3(__NL(Metropolitan_Statistical_Area_))),COUNT(__d3(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_blk',COUNT(__d3(__NL(Geo_Block_))),COUNT(__d3(__NN(Geo_Block_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_match',COUNT(__d3(__NL(Geo_Match_))),COUNT(__d3(__NN(Geo_Match_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','err_stat',COUNT(__d3(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d3(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_first_seen',COUNT(__d3(__NL(A_D_V_O_Date_First_Seen_))),COUNT(__d3(__NN(A_D_V_O_Date_First_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_last_seen',COUNT(__d3(__NL(A_D_V_O_Date_Last_Seen_))),COUNT(__d3(__NN(A_D_V_O_Date_Last_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_vendor_first_reported',COUNT(__d3(__NL(A_D_V_O_Date_Vendor_First_Reported_))),COUNT(__d3(__NN(A_D_V_O_Date_Vendor_First_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_vendor_last_reported',COUNT(__d3(__NL(A_D_V_O_Date_Vendor_Last_Reported_))),COUNT(__d3(__NN(A_D_V_O_Date_Vendor_Last_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','address_vacancy_indicator',COUNT(__d3(__NL(Vacancy_Indicator_))),COUNT(__d3(__NN(Vacancy_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','throw_back_indicator',COUNT(__d3(__NL(Throw_Back_Indicator_))),COUNT(__d3(__NN(Throw_Back_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seasonal_delivery_indicator',COUNT(__d3(__NL(Seasonal_Delivery_Indicator_))),COUNT(__d3(__NN(Seasonal_Delivery_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seasonal_start_suppression_date',COUNT(__d3(__NL(Seasonal_Start_Suppression_Date_))),COUNT(__d3(__NN(Seasonal_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seasonal_end_suppression_date',COUNT(__d3(__NL(Seasonal_End_Suppression_Date_))),COUNT(__d3(__NN(Seasonal_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dnd_indicator',COUNT(__d3(__NL(Do_Not_Deliver_Indicator_))),COUNT(__d3(__NN(Do_Not_Deliver_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotMailIndicator',COUNT(__d3(__NL(Do_Not_Mail_Indicator_))),COUNT(__d3(__NN(Do_Not_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeadCOIndicator',COUNT(__d3(__NL(Dead_C_O_Indicator_))),COUNT(__d3(__NN(Dead_C_O_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HotListIndicator',COUNT(__d3(__NL(Hot_List_Indicator_))),COUNT(__d3(__NN(Hot_List_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','college_indicator',COUNT(__d3(__NL(College_Indicator_))),COUNT(__d3(__NN(College_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','college_start_suppression_date',COUNT(__d3(__NL(College_Start_Suppression_Date_))),COUNT(__d3(__NN(College_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','college_end_suppression_date',COUNT(__d3(__NL(College_End_Suppression_Date_))),COUNT(__d3(__NN(College_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','address_style_flag',COUNT(__d3(__NL(Style_Code_))),COUNT(__d3(__NN(Style_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','simplify_address_count',COUNT(__d3(__NL(Simplify_Count_))),COUNT(__d3(__NN(Simplify_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','drop_indicator',COUNT(__d3(__NL(Drop_Indicator_))),COUNT(__d3(__NN(Drop_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','residential_or_business_ind',COUNT(__d3(__NL(Residential_Or_Business_Indicator_))),COUNT(__d3(__NN(Residential_Or_Business_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','owgm_indicator',COUNT(__d3(__NL(Only_Way_To_Get_Mail_Indicator_))),COUNT(__d3(__NN(Only_Way_To_Get_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_type_code',COUNT(__d3(__NL(Record_Type_Code_))),COUNT(__d3(__NN(Record_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','address_type',COUNT(__d3(__NL(Address_Type_Code_))),COUNT(__d3(__NN(Address_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mixed_address_usage',COUNT(__d3(__NL(Mixed_Usage_Code_))),COUNT(__d3(__NN(Mixed_Usage_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vac_begdt',COUNT(__d3(__NL(Vacation_Begin_Date_))),COUNT(__d3(__NN(Vacation_Begin_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vac_enddt',COUNT(__d3(__NL(Vacation_End_Date_))),COUNT(__d3(__NN(Vacation_End_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','months_vac_curr',COUNT(__d3(__NL(Number_Of_Current_Vacation_Months_))),COUNT(__d3(__NN(Number_Of_Current_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','months_vac_max',COUNT(__d3(__NL(Max_Vacation_Months_))),COUNT(__d3(__NN(Max_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vac_count',COUNT(__d3(__NL(Vacation_Periods_Count_))),COUNT(__d3(__NN(Vacation_Periods_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d3(__NL(Company_Address_Type_Raw_))),COUNT(__d3(__NN(Company_Address_Type_Raw_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d3(__NL(Company_Address_Type_Derived_))),COUNT(__d3(__NN(Company_Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d3(__NL(Address_Type_Derived_))),COUNT(__d3(__NN(Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressMethod',COUNT(__d3(__NL(Address_Method_))),COUNT(__d3(__NN(Address_Method_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d3(__NL(Is_Active_))),COUNT(__d3(__NN(Is_Active_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDefunct',COUNT(__d3(__NL(Is_Defunct_))),COUNT(__d3(__NN(Is_Defunct_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Type',COUNT(__d3(__NL(Address___Type_))),COUNT(__d3(__NN(Address___Type_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Desc',COUNT(__d3(__NL(Address___Desc_))),COUNT(__d3(__NN(Address___Desc_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d3(__NL(Header_Hit_Flag_))),COUNT(__d3(__NN(Header_Hit_Flag_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_ADVO__Key_Addr1_History_Invalid),COUNT(__d4)},
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
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cart',COUNT(__d4(__NL(Carrier_Route_Number_))),COUNT(__d4(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cr_sort_sz',COUNT(__d4(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d4(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lot',COUNT(__d4(__NL(Line_Of_Travel_))),COUNT(__d4(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lot_order',COUNT(__d4(__NL(Line_Of_Travel_Order_))),COUNT(__d4(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dbpc',COUNT(__d4(__NL(Delivery_Point_Barcode_))),COUNT(__d4(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','chk_digit',COUNT(__d4(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d4(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec_type',COUNT(__d4(__NL(Type_Code_))),COUNT(__d4(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','county',COUNT(__d4(__NL(County_))),COUNT(__d4(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_lat',COUNT(__d4(__NL(Latitude_))),COUNT(__d4(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_long',COUNT(__d4(__NL(Longitude_))),COUNT(__d4(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','msa',COUNT(__d4(__NL(Metropolitan_Statistical_Area_))),COUNT(__d4(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_blk',COUNT(__d4(__NL(Geo_Block_))),COUNT(__d4(__NN(Geo_Block_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_match',COUNT(__d4(__NL(Geo_Match_))),COUNT(__d4(__NN(Geo_Match_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','err_stat',COUNT(__d4(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d4(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_first_seen',COUNT(__d4(__NL(A_D_V_O_Date_First_Seen_))),COUNT(__d4(__NN(A_D_V_O_Date_First_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_last_seen',COUNT(__d4(__NL(A_D_V_O_Date_Last_Seen_))),COUNT(__d4(__NN(A_D_V_O_Date_Last_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_vendor_first_reported',COUNT(__d4(__NL(A_D_V_O_Date_Vendor_First_Reported_))),COUNT(__d4(__NN(A_D_V_O_Date_Vendor_First_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_vendor_last_reported',COUNT(__d4(__NL(A_D_V_O_Date_Vendor_Last_Reported_))),COUNT(__d4(__NN(A_D_V_O_Date_Vendor_Last_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','address_vacancy_indicator',COUNT(__d4(__NL(Vacancy_Indicator_))),COUNT(__d4(__NN(Vacancy_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','throw_back_indicator',COUNT(__d4(__NL(Throw_Back_Indicator_))),COUNT(__d4(__NN(Throw_Back_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seasonal_delivery_indicator',COUNT(__d4(__NL(Seasonal_Delivery_Indicator_))),COUNT(__d4(__NN(Seasonal_Delivery_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seasonal_start_suppression_date',COUNT(__d4(__NL(Seasonal_Start_Suppression_Date_))),COUNT(__d4(__NN(Seasonal_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seasonal_end_suppression_date',COUNT(__d4(__NL(Seasonal_End_Suppression_Date_))),COUNT(__d4(__NN(Seasonal_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dnd_indicator',COUNT(__d4(__NL(Do_Not_Deliver_Indicator_))),COUNT(__d4(__NN(Do_Not_Deliver_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotMailIndicator',COUNT(__d4(__NL(Do_Not_Mail_Indicator_))),COUNT(__d4(__NN(Do_Not_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeadCOIndicator',COUNT(__d4(__NL(Dead_C_O_Indicator_))),COUNT(__d4(__NN(Dead_C_O_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HotListIndicator',COUNT(__d4(__NL(Hot_List_Indicator_))),COUNT(__d4(__NN(Hot_List_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','college_indicator',COUNT(__d4(__NL(College_Indicator_))),COUNT(__d4(__NN(College_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','college_start_suppression_date',COUNT(__d4(__NL(College_Start_Suppression_Date_))),COUNT(__d4(__NN(College_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','college_end_suppression_date',COUNT(__d4(__NL(College_End_Suppression_Date_))),COUNT(__d4(__NN(College_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','address_style_flag',COUNT(__d4(__NL(Style_Code_))),COUNT(__d4(__NN(Style_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','simplify_address_count',COUNT(__d4(__NL(Simplify_Count_))),COUNT(__d4(__NN(Simplify_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','drop_indicator',COUNT(__d4(__NL(Drop_Indicator_))),COUNT(__d4(__NN(Drop_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','residential_or_business_ind',COUNT(__d4(__NL(Residential_Or_Business_Indicator_))),COUNT(__d4(__NN(Residential_Or_Business_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','owgm_indicator',COUNT(__d4(__NL(Only_Way_To_Get_Mail_Indicator_))),COUNT(__d4(__NN(Only_Way_To_Get_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_type_code',COUNT(__d4(__NL(Record_Type_Code_))),COUNT(__d4(__NN(Record_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','address_type',COUNT(__d4(__NL(Address_Type_Code_))),COUNT(__d4(__NN(Address_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mixed_address_usage',COUNT(__d4(__NL(Mixed_Usage_Code_))),COUNT(__d4(__NN(Mixed_Usage_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vac_begdt',COUNT(__d4(__NL(Vacation_Begin_Date_))),COUNT(__d4(__NN(Vacation_Begin_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vac_enddt',COUNT(__d4(__NL(Vacation_End_Date_))),COUNT(__d4(__NN(Vacation_End_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','months_vac_curr',COUNT(__d4(__NL(Number_Of_Current_Vacation_Months_))),COUNT(__d4(__NN(Number_Of_Current_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','months_vac_max',COUNT(__d4(__NL(Max_Vacation_Months_))),COUNT(__d4(__NN(Max_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vac_count',COUNT(__d4(__NL(Vacation_Periods_Count_))),COUNT(__d4(__NN(Vacation_Periods_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d4(__NL(Company_Address_Type_Raw_))),COUNT(__d4(__NN(Company_Address_Type_Raw_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d4(__NL(Company_Address_Type_Derived_))),COUNT(__d4(__NN(Company_Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d4(__NL(Address_Type_Derived_))),COUNT(__d4(__NN(Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressMethod',COUNT(__d4(__NL(Address_Method_))),COUNT(__d4(__NN(Address_Method_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d4(__NL(Is_Active_))),COUNT(__d4(__NN(Is_Active_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDefunct',COUNT(__d4(__NL(Is_Defunct_))),COUNT(__d4(__NN(Is_Defunct_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Type',COUNT(__d4(__NL(Address___Type_))),COUNT(__d4(__NN(Address___Type_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Desc',COUNT(__d4(__NL(Address___Desc_))),COUNT(__d4(__NN(Address___Desc_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d4(__NL(Header_Hit_Flag_))),COUNT(__d4(__NN(Header_Hit_Flag_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DMA__Key_DNM_Name_Address_Invalid),COUNT(__d5)},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d5(__NL(Primary_Range_))),COUNT(__d5(__NN(Primary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d5(__NL(Predirectional_))),COUNT(__d5(__NN(Predirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d5(__NL(Primary_Name_))),COUNT(__d5(__NN(Primary_Name_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d5(__NL(Suffix_))),COUNT(__d5(__NN(Suffix_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d5(__NL(Postdirectional_))),COUNT(__d5(__NN(Postdirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','unit_desig',COUNT(__d5(__NL(Unit_Designation_))),COUNT(__d5(__NN(Unit_Designation_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d5(__NL(Secondary_Range_))),COUNT(__d5(__NN(Secondary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','p_city_name',COUNT(__d5(__NL(Postal_City_))),COUNT(__d5(__NN(Postal_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','v_city_name',COUNT(__d5(__NL(Vanity_City_))),COUNT(__d5(__NN(Vanity_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d5(__NL(State_))),COUNT(__d5(__NN(State_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d5(__NL(Z_I_P5_))),COUNT(__d5(__NN(Z_I_P5_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip4',COUNT(__d5(__NL(Z_I_P4_))),COUNT(__d5(__NN(Z_I_P4_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AppendRawAID',COUNT(__d5(__NL(Append_Raw_A_I_D_))),COUNT(__d5(__NN(Append_Raw_A_I_D_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteNumber',COUNT(__d5(__NL(Carrier_Route_Number_))),COUNT(__d5(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteSortationAtZIP',COUNT(__d5(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d5(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravel',COUNT(__d5(__NL(Line_Of_Travel_))),COUNT(__d5(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravelOrder',COUNT(__d5(__NL(Line_Of_Travel_Order_))),COUNT(__d5(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcode',COUNT(__d5(__NL(Delivery_Point_Barcode_))),COUNT(__d5(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcodeCheckDigit',COUNT(__d5(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d5(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeCode',COUNT(__d5(__NL(Type_Code_))),COUNT(__d5(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','County',COUNT(__d5(__NL(County_))),COUNT(__d5(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Latitude',COUNT(__d5(__NL(Latitude_))),COUNT(__d5(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Longitude',COUNT(__d5(__NL(Longitude_))),COUNT(__d5(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d5(__NL(Metropolitan_Statistical_Area_))),COUNT(__d5(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoBlock',COUNT(__d5(__NL(Geo_Block_))),COUNT(__d5(__NN(Geo_Block_)))},
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
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d5(__NL(Header_Hit_Flag_))),COUNT(__d5(__NN(Header_Hit_Flag_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Fraudpoint3__Key_Address_Invalid),COUNT(__d6)},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d6(__NL(Primary_Range_))),COUNT(__d6(__NN(Primary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d6(__NL(Predirectional_))),COUNT(__d6(__NN(Predirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d6(__NL(Primary_Name_))),COUNT(__d6(__NN(Primary_Name_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d6(__NL(Suffix_))),COUNT(__d6(__NN(Suffix_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d6(__NL(Postdirectional_))),COUNT(__d6(__NN(Postdirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','unit_desig',COUNT(__d6(__NL(Unit_Designation_))),COUNT(__d6(__NN(Unit_Designation_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d6(__NL(Secondary_Range_))),COUNT(__d6(__NN(Secondary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','p_city_name',COUNT(__d6(__NL(Postal_City_))),COUNT(__d6(__NN(Postal_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','v_city_name',COUNT(__d6(__NL(Vanity_City_))),COUNT(__d6(__NN(Vanity_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d6(__NL(State_))),COUNT(__d6(__NN(State_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d6(__NL(Z_I_P5_))),COUNT(__d6(__NN(Z_I_P5_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip4',COUNT(__d6(__NL(Z_I_P4_))),COUNT(__d6(__NN(Z_I_P4_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AppendRawAID',COUNT(__d6(__NL(Append_Raw_A_I_D_))),COUNT(__d6(__NN(Append_Raw_A_I_D_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteNumber',COUNT(__d6(__NL(Carrier_Route_Number_))),COUNT(__d6(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteSortationAtZIP',COUNT(__d6(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d6(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravel',COUNT(__d6(__NL(Line_Of_Travel_))),COUNT(__d6(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravelOrder',COUNT(__d6(__NL(Line_Of_Travel_Order_))),COUNT(__d6(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcode',COUNT(__d6(__NL(Delivery_Point_Barcode_))),COUNT(__d6(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcodeCheckDigit',COUNT(__d6(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d6(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeCode',COUNT(__d6(__NL(Type_Code_))),COUNT(__d6(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','County',COUNT(__d6(__NL(County_))),COUNT(__d6(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_lat',COUNT(__d6(__NL(Latitude_))),COUNT(__d6(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_long',COUNT(__d6(__NL(Longitude_))),COUNT(__d6(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d6(__NL(Metropolitan_Statistical_Area_))),COUNT(__d6(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_blk',COUNT(__d6(__NL(Geo_Block_))),COUNT(__d6(__NN(Geo_Block_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoMatch',COUNT(__d6(__NL(Geo_Match_))),COUNT(__d6(__NN(Geo_Match_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ACECleanerErrorCode',COUNT(__d6(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d6(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateFirstSeen',COUNT(__d6(__NL(A_D_V_O_Date_First_Seen_))),COUNT(__d6(__NN(A_D_V_O_Date_First_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateLastSeen',COUNT(__d6(__NL(A_D_V_O_Date_Last_Seen_))),COUNT(__d6(__NN(A_D_V_O_Date_Last_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorFirstReported',COUNT(__d6(__NL(A_D_V_O_Date_Vendor_First_Reported_))),COUNT(__d6(__NN(A_D_V_O_Date_Vendor_First_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorLastReported',COUNT(__d6(__NL(A_D_V_O_Date_Vendor_Last_Reported_))),COUNT(__d6(__NN(A_D_V_O_Date_Vendor_Last_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacancyIndicator',COUNT(__d6(__NL(Vacancy_Indicator_))),COUNT(__d6(__NN(Vacancy_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThrowBackIndicator',COUNT(__d6(__NL(Throw_Back_Indicator_))),COUNT(__d6(__NN(Throw_Back_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalDeliveryIndicator',COUNT(__d6(__NL(Seasonal_Delivery_Indicator_))),COUNT(__d6(__NN(Seasonal_Delivery_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalStartSuppressionDate',COUNT(__d6(__NL(Seasonal_Start_Suppression_Date_))),COUNT(__d6(__NN(Seasonal_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalEndSuppressionDate',COUNT(__d6(__NL(Seasonal_End_Suppression_Date_))),COUNT(__d6(__NN(Seasonal_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotDeliverIndicator',COUNT(__d6(__NL(Do_Not_Deliver_Indicator_))),COUNT(__d6(__NN(Do_Not_Deliver_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotMailIndicator',COUNT(__d6(__NL(Do_Not_Mail_Indicator_))),COUNT(__d6(__NN(Do_Not_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeadCOIndicator',COUNT(__d6(__NL(Dead_C_O_Indicator_))),COUNT(__d6(__NN(Dead_C_O_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HotListIndicator',COUNT(__d6(__NL(Hot_List_Indicator_))),COUNT(__d6(__NN(Hot_List_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeIndicator',COUNT(__d6(__NL(College_Indicator_))),COUNT(__d6(__NN(College_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeStartSuppressionDate',COUNT(__d6(__NL(College_Start_Suppression_Date_))),COUNT(__d6(__NN(College_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeEndSuppressionDate',COUNT(__d6(__NL(College_End_Suppression_Date_))),COUNT(__d6(__NN(College_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StyleCode',COUNT(__d6(__NL(Style_Code_))),COUNT(__d6(__NN(Style_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SimplifyCount',COUNT(__d6(__NL(Simplify_Count_))),COUNT(__d6(__NN(Simplify_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DropIndicator',COUNT(__d6(__NL(Drop_Indicator_))),COUNT(__d6(__NN(Drop_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ResidentialOrBusinessIndicator',COUNT(__d6(__NL(Residential_Or_Business_Indicator_))),COUNT(__d6(__NN(Residential_Or_Business_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OnlyWayToGetMailIndicator',COUNT(__d6(__NL(Only_Way_To_Get_Mail_Indicator_))),COUNT(__d6(__NN(Only_Way_To_Get_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordTypeCode',COUNT(__d6(__NL(Record_Type_Code_))),COUNT(__d6(__NN(Record_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeCode',COUNT(__d6(__NL(Address_Type_Code_))),COUNT(__d6(__NN(Address_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MixedUsageCode',COUNT(__d6(__NL(Mixed_Usage_Code_))),COUNT(__d6(__NN(Mixed_Usage_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationBeginDate',COUNT(__d6(__NL(Vacation_Begin_Date_))),COUNT(__d6(__NN(Vacation_Begin_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationEndDate',COUNT(__d6(__NL(Vacation_End_Date_))),COUNT(__d6(__NN(Vacation_End_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfCurrentVacationMonths',COUNT(__d6(__NL(Number_Of_Current_Vacation_Months_))),COUNT(__d6(__NN(Number_Of_Current_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaxVacationMonths',COUNT(__d6(__NL(Max_Vacation_Months_))),COUNT(__d6(__NN(Max_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationPeriodsCount',COUNT(__d6(__NL(Vacation_Periods_Count_))),COUNT(__d6(__NN(Vacation_Periods_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d6(__NL(Company_Address_Type_Raw_))),COUNT(__d6(__NN(Company_Address_Type_Raw_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d6(__NL(Company_Address_Type_Derived_))),COUNT(__d6(__NN(Company_Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d6(__NL(Address_Type_Derived_))),COUNT(__d6(__NN(Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressMethod',COUNT(__d6(__NL(Address_Method_))),COUNT(__d6(__NN(Address_Method_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d6(__NL(Is_Active_))),COUNT(__d6(__NN(Is_Active_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDefunct',COUNT(__d6(__NL(Is_Defunct_))),COUNT(__d6(__NN(Is_Defunct_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Type',COUNT(__d6(__NL(Address___Type_))),COUNT(__d6(__NN(Address___Type_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Desc',COUNT(__d6(__NL(Address___Desc_))),COUNT(__d6(__NN(Address___Desc_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d6(__NL(Header_Hit_Flag_))),COUNT(__d6(__NN(Header_Hit_Flag_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d6(__NL(Source_))),COUNT(__d6(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_DID_Invalid),COUNT(__d7)},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_range',COUNT(__d7(__NL(Primary_Range_))),COUNT(__d7(__NN(Primary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.predir',COUNT(__d7(__NL(Predirectional_))),COUNT(__d7(__NN(Predirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.prim_name',COUNT(__d7(__NL(Primary_Name_))),COUNT(__d7(__NN(Primary_Name_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.addr_suffix',COUNT(__d7(__NL(Suffix_))),COUNT(__d7(__NN(Suffix_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.postdir',COUNT(__d7(__NL(Postdirectional_))),COUNT(__d7(__NN(Postdirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.unit_desig',COUNT(__d7(__NL(Unit_Designation_))),COUNT(__d7(__NN(Unit_Designation_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.sec_range',COUNT(__d7(__NL(Secondary_Range_))),COUNT(__d7(__NN(Secondary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PostalCity',COUNT(__d7(__NL(Postal_City_))),COUNT(__d7(__NN(Postal_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.v_city_name',COUNT(__d7(__NL(Vanity_City_))),COUNT(__d7(__NN(Vanity_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.st',COUNT(__d7(__NL(State_))),COUNT(__d7(__NN(State_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.zip5',COUNT(__d7(__NL(Z_I_P5_))),COUNT(__d7(__NN(Z_I_P5_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.zip4',COUNT(__d7(__NL(Z_I_P4_))),COUNT(__d7(__NN(Z_I_P4_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AppendRawAID',COUNT(__d7(__NL(Append_Raw_A_I_D_))),COUNT(__d7(__NN(Append_Raw_A_I_D_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteNumber',COUNT(__d7(__NL(Carrier_Route_Number_))),COUNT(__d7(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteSortationAtZIP',COUNT(__d7(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d7(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravel',COUNT(__d7(__NL(Line_Of_Travel_))),COUNT(__d7(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravelOrder',COUNT(__d7(__NL(Line_Of_Travel_Order_))),COUNT(__d7(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcode',COUNT(__d7(__NL(Delivery_Point_Barcode_))),COUNT(__d7(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcodeCheckDigit',COUNT(__d7(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d7(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.addr_rec_type',COUNT(__d7(__NL(Type_Code_))),COUNT(__d7(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.fips_county',COUNT(__d7(__NL(County_))),COUNT(__d7(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.geo_lat',COUNT(__d7(__NL(Latitude_))),COUNT(__d7(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.geo_long',COUNT(__d7(__NL(Longitude_))),COUNT(__d7(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d7(__NL(Metropolitan_Statistical_Area_))),COUNT(__d7(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.geo_blk',COUNT(__d7(__NL(Geo_Block_))),COUNT(__d7(__NN(Geo_Block_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.geo_match',COUNT(__d7(__NL(Geo_Match_))),COUNT(__d7(__NN(Geo_Match_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.err_stat',COUNT(__d7(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d7(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateFirstSeen',COUNT(__d7(__NL(A_D_V_O_Date_First_Seen_))),COUNT(__d7(__NN(A_D_V_O_Date_First_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateLastSeen',COUNT(__d7(__NL(A_D_V_O_Date_Last_Seen_))),COUNT(__d7(__NN(A_D_V_O_Date_Last_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorFirstReported',COUNT(__d7(__NL(A_D_V_O_Date_Vendor_First_Reported_))),COUNT(__d7(__NN(A_D_V_O_Date_Vendor_First_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorLastReported',COUNT(__d7(__NL(A_D_V_O_Date_Vendor_Last_Reported_))),COUNT(__d7(__NN(A_D_V_O_Date_Vendor_Last_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacancyIndicator',COUNT(__d7(__NL(Vacancy_Indicator_))),COUNT(__d7(__NN(Vacancy_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThrowBackIndicator',COUNT(__d7(__NL(Throw_Back_Indicator_))),COUNT(__d7(__NN(Throw_Back_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalDeliveryIndicator',COUNT(__d7(__NL(Seasonal_Delivery_Indicator_))),COUNT(__d7(__NN(Seasonal_Delivery_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalStartSuppressionDate',COUNT(__d7(__NL(Seasonal_Start_Suppression_Date_))),COUNT(__d7(__NN(Seasonal_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalEndSuppressionDate',COUNT(__d7(__NL(Seasonal_End_Suppression_Date_))),COUNT(__d7(__NN(Seasonal_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotDeliverIndicator',COUNT(__d7(__NL(Do_Not_Deliver_Indicator_))),COUNT(__d7(__NN(Do_Not_Deliver_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotMailIndicator',COUNT(__d7(__NL(Do_Not_Mail_Indicator_))),COUNT(__d7(__NN(Do_Not_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeadCOIndicator',COUNT(__d7(__NL(Dead_C_O_Indicator_))),COUNT(__d7(__NN(Dead_C_O_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HotListIndicator',COUNT(__d7(__NL(Hot_List_Indicator_))),COUNT(__d7(__NN(Hot_List_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeIndicator',COUNT(__d7(__NL(College_Indicator_))),COUNT(__d7(__NN(College_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeStartSuppressionDate',COUNT(__d7(__NL(College_Start_Suppression_Date_))),COUNT(__d7(__NN(College_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeEndSuppressionDate',COUNT(__d7(__NL(College_End_Suppression_Date_))),COUNT(__d7(__NN(College_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StyleCode',COUNT(__d7(__NL(Style_Code_))),COUNT(__d7(__NN(Style_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SimplifyCount',COUNT(__d7(__NL(Simplify_Count_))),COUNT(__d7(__NN(Simplify_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DropIndicator',COUNT(__d7(__NL(Drop_Indicator_))),COUNT(__d7(__NN(Drop_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ResidentialOrBusinessIndicator',COUNT(__d7(__NL(Residential_Or_Business_Indicator_))),COUNT(__d7(__NN(Residential_Or_Business_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OnlyWayToGetMailIndicator',COUNT(__d7(__NL(Only_Way_To_Get_Mail_Indicator_))),COUNT(__d7(__NN(Only_Way_To_Get_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordTypeCode',COUNT(__d7(__NL(Record_Type_Code_))),COUNT(__d7(__NN(Record_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeCode',COUNT(__d7(__NL(Address_Type_Code_))),COUNT(__d7(__NN(Address_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MixedUsageCode',COUNT(__d7(__NL(Mixed_Usage_Code_))),COUNT(__d7(__NN(Mixed_Usage_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationBeginDate',COUNT(__d7(__NL(Vacation_Begin_Date_))),COUNT(__d7(__NN(Vacation_Begin_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationEndDate',COUNT(__d7(__NL(Vacation_End_Date_))),COUNT(__d7(__NN(Vacation_End_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfCurrentVacationMonths',COUNT(__d7(__NL(Number_Of_Current_Vacation_Months_))),COUNT(__d7(__NN(Number_Of_Current_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaxVacationMonths',COUNT(__d7(__NL(Max_Vacation_Months_))),COUNT(__d7(__NN(Max_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationPeriodsCount',COUNT(__d7(__NL(Vacation_Periods_Count_))),COUNT(__d7(__NN(Vacation_Periods_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d7(__NL(Company_Address_Type_Raw_))),COUNT(__d7(__NN(Company_Address_Type_Raw_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d7(__NL(Company_Address_Type_Derived_))),COUNT(__d7(__NN(Company_Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d7(__NL(Address_Type_Derived_))),COUNT(__d7(__NN(Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressMethod',COUNT(__d7(__NL(Address_Method_))),COUNT(__d7(__NN(Address_Method_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d7(__NL(Is_Active_))),COUNT(__d7(__NN(Is_Active_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDefunct',COUNT(__d7(__NL(Is_Defunct_))),COUNT(__d7(__NN(Is_Defunct_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Type',COUNT(__d7(__NL(Address___Type_))),COUNT(__d7(__NN(Address___Type_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Desc',COUNT(__d7(__NL(Address___Desc_))),COUNT(__d7(__NN(Address___Desc_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d7(__NL(Header_Hit_Flag_))),COUNT(__d7(__NN(Header_Hit_Flag_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d7(__NL(Source_))),COUNT(__d7(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d7(Date_First_Seen_=0)),COUNT(__d7(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d7(Date_Last_Seen_=0)),COUNT(__d7(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_USPIS_HotList__key_addr_search_zip_Invalid),COUNT(__d8)},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d8(__NL(Primary_Range_))),COUNT(__d8(__NN(Primary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d8(__NL(Predirectional_))),COUNT(__d8(__NN(Predirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d8(__NL(Primary_Name_))),COUNT(__d8(__NN(Primary_Name_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d8(__NL(Suffix_))),COUNT(__d8(__NN(Suffix_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d8(__NL(Postdirectional_))),COUNT(__d8(__NN(Postdirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','unit_desig',COUNT(__d8(__NL(Unit_Designation_))),COUNT(__d8(__NN(Unit_Designation_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d8(__NL(Secondary_Range_))),COUNT(__d8(__NN(Secondary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','p_city_name',COUNT(__d8(__NL(Postal_City_))),COUNT(__d8(__NN(Postal_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','v_city_name',COUNT(__d8(__NL(Vanity_City_))),COUNT(__d8(__NN(Vanity_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d8(__NL(State_))),COUNT(__d8(__NN(State_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d8(__NL(Z_I_P5_))),COUNT(__d8(__NN(Z_I_P5_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip4',COUNT(__d8(__NL(Z_I_P4_))),COUNT(__d8(__NN(Z_I_P4_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AppendRawAID',COUNT(__d8(__NL(Append_Raw_A_I_D_))),COUNT(__d8(__NN(Append_Raw_A_I_D_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteNumber',COUNT(__d8(__NL(Carrier_Route_Number_))),COUNT(__d8(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteSortationAtZIP',COUNT(__d8(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d8(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravel',COUNT(__d8(__NL(Line_Of_Travel_))),COUNT(__d8(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravelOrder',COUNT(__d8(__NL(Line_Of_Travel_Order_))),COUNT(__d8(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcode',COUNT(__d8(__NL(Delivery_Point_Barcode_))),COUNT(__d8(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcodeCheckDigit',COUNT(__d8(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d8(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeCode',COUNT(__d8(__NL(Type_Code_))),COUNT(__d8(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','County',COUNT(__d8(__NL(County_))),COUNT(__d8(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Latitude',COUNT(__d8(__NL(Latitude_))),COUNT(__d8(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Longitude',COUNT(__d8(__NL(Longitude_))),COUNT(__d8(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d8(__NL(Metropolitan_Statistical_Area_))),COUNT(__d8(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoBlock',COUNT(__d8(__NL(Geo_Block_))),COUNT(__d8(__NN(Geo_Block_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoMatch',COUNT(__d8(__NL(Geo_Match_))),COUNT(__d8(__NN(Geo_Match_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ACECleanerErrorCode',COUNT(__d8(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d8(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateFirstSeen',COUNT(__d8(__NL(A_D_V_O_Date_First_Seen_))),COUNT(__d8(__NN(A_D_V_O_Date_First_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateLastSeen',COUNT(__d8(__NL(A_D_V_O_Date_Last_Seen_))),COUNT(__d8(__NN(A_D_V_O_Date_Last_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorFirstReported',COUNT(__d8(__NL(A_D_V_O_Date_Vendor_First_Reported_))),COUNT(__d8(__NN(A_D_V_O_Date_Vendor_First_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorLastReported',COUNT(__d8(__NL(A_D_V_O_Date_Vendor_Last_Reported_))),COUNT(__d8(__NN(A_D_V_O_Date_Vendor_Last_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacancyIndicator',COUNT(__d8(__NL(Vacancy_Indicator_))),COUNT(__d8(__NN(Vacancy_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThrowBackIndicator',COUNT(__d8(__NL(Throw_Back_Indicator_))),COUNT(__d8(__NN(Throw_Back_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalDeliveryIndicator',COUNT(__d8(__NL(Seasonal_Delivery_Indicator_))),COUNT(__d8(__NN(Seasonal_Delivery_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalStartSuppressionDate',COUNT(__d8(__NL(Seasonal_Start_Suppression_Date_))),COUNT(__d8(__NN(Seasonal_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalEndSuppressionDate',COUNT(__d8(__NL(Seasonal_End_Suppression_Date_))),COUNT(__d8(__NN(Seasonal_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotDeliverIndicator',COUNT(__d8(__NL(Do_Not_Deliver_Indicator_))),COUNT(__d8(__NN(Do_Not_Deliver_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotMailIndicator',COUNT(__d8(__NL(Do_Not_Mail_Indicator_))),COUNT(__d8(__NN(Do_Not_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeadCOIndicator',COUNT(__d8(__NL(Dead_C_O_Indicator_))),COUNT(__d8(__NN(Dead_C_O_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeIndicator',COUNT(__d8(__NL(College_Indicator_))),COUNT(__d8(__NN(College_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeStartSuppressionDate',COUNT(__d8(__NL(College_Start_Suppression_Date_))),COUNT(__d8(__NN(College_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeEndSuppressionDate',COUNT(__d8(__NL(College_End_Suppression_Date_))),COUNT(__d8(__NN(College_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StyleCode',COUNT(__d8(__NL(Style_Code_))),COUNT(__d8(__NN(Style_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SimplifyCount',COUNT(__d8(__NL(Simplify_Count_))),COUNT(__d8(__NN(Simplify_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DropIndicator',COUNT(__d8(__NL(Drop_Indicator_))),COUNT(__d8(__NN(Drop_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ResidentialOrBusinessIndicator',COUNT(__d8(__NL(Residential_Or_Business_Indicator_))),COUNT(__d8(__NN(Residential_Or_Business_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OnlyWayToGetMailIndicator',COUNT(__d8(__NL(Only_Way_To_Get_Mail_Indicator_))),COUNT(__d8(__NN(Only_Way_To_Get_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordTypeCode',COUNT(__d8(__NL(Record_Type_Code_))),COUNT(__d8(__NN(Record_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeCode',COUNT(__d8(__NL(Address_Type_Code_))),COUNT(__d8(__NN(Address_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MixedUsageCode',COUNT(__d8(__NL(Mixed_Usage_Code_))),COUNT(__d8(__NN(Mixed_Usage_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationBeginDate',COUNT(__d8(__NL(Vacation_Begin_Date_))),COUNT(__d8(__NN(Vacation_Begin_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationEndDate',COUNT(__d8(__NL(Vacation_End_Date_))),COUNT(__d8(__NN(Vacation_End_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfCurrentVacationMonths',COUNT(__d8(__NL(Number_Of_Current_Vacation_Months_))),COUNT(__d8(__NN(Number_Of_Current_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaxVacationMonths',COUNT(__d8(__NL(Max_Vacation_Months_))),COUNT(__d8(__NN(Max_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationPeriodsCount',COUNT(__d8(__NL(Vacation_Periods_Count_))),COUNT(__d8(__NN(Vacation_Periods_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d8(__NL(Company_Address_Type_Raw_))),COUNT(__d8(__NN(Company_Address_Type_Raw_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d8(__NL(Company_Address_Type_Derived_))),COUNT(__d8(__NN(Company_Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d8(__NL(Address_Type_Derived_))),COUNT(__d8(__NN(Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressMethod',COUNT(__d8(__NL(Address_Method_))),COUNT(__d8(__NN(Address_Method_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d8(__NL(Is_Active_))),COUNT(__d8(__NN(Is_Active_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDefunct',COUNT(__d8(__NL(Is_Defunct_))),COUNT(__d8(__NN(Is_Defunct_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Type',COUNT(__d8(__NL(Address___Type_))),COUNT(__d8(__NN(Address___Type_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Desc',COUNT(__d8(__NL(Address___Desc_))),COUNT(__d8(__NN(Address___Desc_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d8(__NL(Header_Hit_Flag_))),COUNT(__d8(__NN(Header_Hit_Flag_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d8(__NL(Source_))),COUNT(__d8(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d8(Date_First_Seen_=0)),COUNT(__d8(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d8(Date_Last_Seen_=0)),COUNT(__d8(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Key_Address_Invalid),COUNT(__d9)},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d9(__NL(Primary_Range_))),COUNT(__d9(__NN(Primary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d9(__NL(Predirectional_))),COUNT(__d9(__NN(Predirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d9(__NL(Primary_Name_))),COUNT(__d9(__NN(Primary_Name_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d9(__NL(Suffix_))),COUNT(__d9(__NN(Suffix_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d9(__NL(Postdirectional_))),COUNT(__d9(__NN(Postdirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UnitDesignation',COUNT(__d9(__NL(Unit_Designation_))),COUNT(__d9(__NN(Unit_Designation_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d9(__NL(Secondary_Range_))),COUNT(__d9(__NN(Secondary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','p_city_name',COUNT(__d9(__NL(Postal_City_))),COUNT(__d9(__NN(Postal_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','v_city_name',COUNT(__d9(__NL(Vanity_City_))),COUNT(__d9(__NN(Vanity_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','State',COUNT(__d9(__NL(State_))),COUNT(__d9(__NN(State_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d9(__NL(Z_I_P5_))),COUNT(__d9(__NN(Z_I_P5_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip4',COUNT(__d9(__NL(Z_I_P4_))),COUNT(__d9(__NN(Z_I_P4_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AppendRawAID',COUNT(__d9(__NL(Append_Raw_A_I_D_))),COUNT(__d9(__NN(Append_Raw_A_I_D_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cart',COUNT(__d9(__NL(Carrier_Route_Number_))),COUNT(__d9(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cr_sort_sz',COUNT(__d9(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d9(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lot',COUNT(__d9(__NL(Line_Of_Travel_))),COUNT(__d9(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lot_order',COUNT(__d9(__NL(Line_Of_Travel_Order_))),COUNT(__d9(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dbpc',COUNT(__d9(__NL(Delivery_Point_Barcode_))),COUNT(__d9(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','chk_digit',COUNT(__d9(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d9(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec_type',COUNT(__d9(__NL(Type_Code_))),COUNT(__d9(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','county',COUNT(__d9(__NL(County_))),COUNT(__d9(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_lat',COUNT(__d9(__NL(Latitude_))),COUNT(__d9(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_long',COUNT(__d9(__NL(Longitude_))),COUNT(__d9(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','msa',COUNT(__d9(__NL(Metropolitan_Statistical_Area_))),COUNT(__d9(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_blk',COUNT(__d9(__NL(Geo_Block_))),COUNT(__d9(__NN(Geo_Block_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_match',COUNT(__d9(__NL(Geo_Match_))),COUNT(__d9(__NN(Geo_Match_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','err_stat',COUNT(__d9(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d9(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateFirstSeen',COUNT(__d9(__NL(A_D_V_O_Date_First_Seen_))),COUNT(__d9(__NN(A_D_V_O_Date_First_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateLastSeen',COUNT(__d9(__NL(A_D_V_O_Date_Last_Seen_))),COUNT(__d9(__NN(A_D_V_O_Date_Last_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorFirstReported',COUNT(__d9(__NL(A_D_V_O_Date_Vendor_First_Reported_))),COUNT(__d9(__NN(A_D_V_O_Date_Vendor_First_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorLastReported',COUNT(__d9(__NL(A_D_V_O_Date_Vendor_Last_Reported_))),COUNT(__d9(__NN(A_D_V_O_Date_Vendor_Last_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacancyIndicator',COUNT(__d9(__NL(Vacancy_Indicator_))),COUNT(__d9(__NN(Vacancy_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThrowBackIndicator',COUNT(__d9(__NL(Throw_Back_Indicator_))),COUNT(__d9(__NN(Throw_Back_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalDeliveryIndicator',COUNT(__d9(__NL(Seasonal_Delivery_Indicator_))),COUNT(__d9(__NN(Seasonal_Delivery_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalStartSuppressionDate',COUNT(__d9(__NL(Seasonal_Start_Suppression_Date_))),COUNT(__d9(__NN(Seasonal_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalEndSuppressionDate',COUNT(__d9(__NL(Seasonal_End_Suppression_Date_))),COUNT(__d9(__NN(Seasonal_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotDeliverIndicator',COUNT(__d9(__NL(Do_Not_Deliver_Indicator_))),COUNT(__d9(__NN(Do_Not_Deliver_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotMailIndicator',COUNT(__d9(__NL(Do_Not_Mail_Indicator_))),COUNT(__d9(__NN(Do_Not_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeadCOIndicator',COUNT(__d9(__NL(Dead_C_O_Indicator_))),COUNT(__d9(__NN(Dead_C_O_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HotListIndicator',COUNT(__d9(__NL(Hot_List_Indicator_))),COUNT(__d9(__NN(Hot_List_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeIndicator',COUNT(__d9(__NL(College_Indicator_))),COUNT(__d9(__NN(College_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeStartSuppressionDate',COUNT(__d9(__NL(College_Start_Suppression_Date_))),COUNT(__d9(__NN(College_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeEndSuppressionDate',COUNT(__d9(__NL(College_End_Suppression_Date_))),COUNT(__d9(__NN(College_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StyleCode',COUNT(__d9(__NL(Style_Code_))),COUNT(__d9(__NN(Style_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SimplifyCount',COUNT(__d9(__NL(Simplify_Count_))),COUNT(__d9(__NN(Simplify_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DropIndicator',COUNT(__d9(__NL(Drop_Indicator_))),COUNT(__d9(__NN(Drop_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ResidentialOrBusinessIndicator',COUNT(__d9(__NL(Residential_Or_Business_Indicator_))),COUNT(__d9(__NN(Residential_Or_Business_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OnlyWayToGetMailIndicator',COUNT(__d9(__NL(Only_Way_To_Get_Mail_Indicator_))),COUNT(__d9(__NN(Only_Way_To_Get_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordTypeCode',COUNT(__d9(__NL(Record_Type_Code_))),COUNT(__d9(__NN(Record_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeCode',COUNT(__d9(__NL(Address_Type_Code_))),COUNT(__d9(__NN(Address_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MixedUsageCode',COUNT(__d9(__NL(Mixed_Usage_Code_))),COUNT(__d9(__NN(Mixed_Usage_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationBeginDate',COUNT(__d9(__NL(Vacation_Begin_Date_))),COUNT(__d9(__NN(Vacation_Begin_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationEndDate',COUNT(__d9(__NL(Vacation_End_Date_))),COUNT(__d9(__NN(Vacation_End_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfCurrentVacationMonths',COUNT(__d9(__NL(Number_Of_Current_Vacation_Months_))),COUNT(__d9(__NN(Number_Of_Current_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaxVacationMonths',COUNT(__d9(__NL(Max_Vacation_Months_))),COUNT(__d9(__NN(Max_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationPeriodsCount',COUNT(__d9(__NL(Vacation_Periods_Count_))),COUNT(__d9(__NN(Vacation_Periods_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d9(__NL(Company_Address_Type_Raw_))),COUNT(__d9(__NN(Company_Address_Type_Raw_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d9(__NL(Company_Address_Type_Derived_))),COUNT(__d9(__NN(Company_Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d9(__NL(Address_Type_Derived_))),COUNT(__d9(__NN(Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressMethod',COUNT(__d9(__NL(Address_Method_))),COUNT(__d9(__NN(Address_Method_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d9(__NL(Is_Active_))),COUNT(__d9(__NN(Is_Active_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDefunct',COUNT(__d9(__NL(Is_Defunct_))),COUNT(__d9(__NN(Is_Defunct_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Type',COUNT(__d9(__NL(Address___Type_))),COUNT(__d9(__NN(Address___Type_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Desc',COUNT(__d9(__NL(Address___Desc_))),COUNT(__d9(__NN(Address___Desc_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d9(__NL(Header_Hit_Flag_))),COUNT(__d9(__NN(Header_Hit_Flag_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d9(__NL(Source_))),COUNT(__d9(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d9(Date_First_Seen_=0)),COUNT(__d9(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d9(Date_Last_Seen_=0)),COUNT(__d9(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Key_DID_Invalid),COUNT(__d10)},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d10(__NL(Primary_Range_))),COUNT(__d10(__NN(Primary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d10(__NL(Predirectional_))),COUNT(__d10(__NN(Predirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d10(__NL(Primary_Name_))),COUNT(__d10(__NN(Primary_Name_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d10(__NL(Suffix_))),COUNT(__d10(__NN(Suffix_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d10(__NL(Postdirectional_))),COUNT(__d10(__NN(Postdirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UnitDesignation',COUNT(__d10(__NL(Unit_Designation_))),COUNT(__d10(__NN(Unit_Designation_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d10(__NL(Secondary_Range_))),COUNT(__d10(__NN(Secondary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','p_city_name',COUNT(__d10(__NL(Postal_City_))),COUNT(__d10(__NN(Postal_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','v_city_name',COUNT(__d10(__NL(Vanity_City_))),COUNT(__d10(__NN(Vanity_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','State',COUNT(__d10(__NL(State_))),COUNT(__d10(__NN(State_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d10(__NL(Z_I_P5_))),COUNT(__d10(__NN(Z_I_P5_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip4',COUNT(__d10(__NL(Z_I_P4_))),COUNT(__d10(__NN(Z_I_P4_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AppendRawAID',COUNT(__d10(__NL(Append_Raw_A_I_D_))),COUNT(__d10(__NN(Append_Raw_A_I_D_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cart',COUNT(__d10(__NL(Carrier_Route_Number_))),COUNT(__d10(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cr_sort_sz',COUNT(__d10(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d10(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lot',COUNT(__d10(__NL(Line_Of_Travel_))),COUNT(__d10(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lot_order',COUNT(__d10(__NL(Line_Of_Travel_Order_))),COUNT(__d10(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dbpc',COUNT(__d10(__NL(Delivery_Point_Barcode_))),COUNT(__d10(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','chk_digit',COUNT(__d10(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d10(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec_type',COUNT(__d10(__NL(Type_Code_))),COUNT(__d10(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','county',COUNT(__d10(__NL(County_))),COUNT(__d10(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_lat',COUNT(__d10(__NL(Latitude_))),COUNT(__d10(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_long',COUNT(__d10(__NL(Longitude_))),COUNT(__d10(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','msa',COUNT(__d10(__NL(Metropolitan_Statistical_Area_))),COUNT(__d10(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_blk',COUNT(__d10(__NL(Geo_Block_))),COUNT(__d10(__NN(Geo_Block_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_match',COUNT(__d10(__NL(Geo_Match_))),COUNT(__d10(__NN(Geo_Match_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','err_stat',COUNT(__d10(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d10(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateFirstSeen',COUNT(__d10(__NL(A_D_V_O_Date_First_Seen_))),COUNT(__d10(__NN(A_D_V_O_Date_First_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateLastSeen',COUNT(__d10(__NL(A_D_V_O_Date_Last_Seen_))),COUNT(__d10(__NN(A_D_V_O_Date_Last_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorFirstReported',COUNT(__d10(__NL(A_D_V_O_Date_Vendor_First_Reported_))),COUNT(__d10(__NN(A_D_V_O_Date_Vendor_First_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorLastReported',COUNT(__d10(__NL(A_D_V_O_Date_Vendor_Last_Reported_))),COUNT(__d10(__NN(A_D_V_O_Date_Vendor_Last_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacancyIndicator',COUNT(__d10(__NL(Vacancy_Indicator_))),COUNT(__d10(__NN(Vacancy_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThrowBackIndicator',COUNT(__d10(__NL(Throw_Back_Indicator_))),COUNT(__d10(__NN(Throw_Back_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalDeliveryIndicator',COUNT(__d10(__NL(Seasonal_Delivery_Indicator_))),COUNT(__d10(__NN(Seasonal_Delivery_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalStartSuppressionDate',COUNT(__d10(__NL(Seasonal_Start_Suppression_Date_))),COUNT(__d10(__NN(Seasonal_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalEndSuppressionDate',COUNT(__d10(__NL(Seasonal_End_Suppression_Date_))),COUNT(__d10(__NN(Seasonal_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotDeliverIndicator',COUNT(__d10(__NL(Do_Not_Deliver_Indicator_))),COUNT(__d10(__NN(Do_Not_Deliver_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotMailIndicator',COUNT(__d10(__NL(Do_Not_Mail_Indicator_))),COUNT(__d10(__NN(Do_Not_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeadCOIndicator',COUNT(__d10(__NL(Dead_C_O_Indicator_))),COUNT(__d10(__NN(Dead_C_O_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HotListIndicator',COUNT(__d10(__NL(Hot_List_Indicator_))),COUNT(__d10(__NN(Hot_List_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeIndicator',COUNT(__d10(__NL(College_Indicator_))),COUNT(__d10(__NN(College_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeStartSuppressionDate',COUNT(__d10(__NL(College_Start_Suppression_Date_))),COUNT(__d10(__NN(College_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeEndSuppressionDate',COUNT(__d10(__NL(College_End_Suppression_Date_))),COUNT(__d10(__NN(College_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StyleCode',COUNT(__d10(__NL(Style_Code_))),COUNT(__d10(__NN(Style_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SimplifyCount',COUNT(__d10(__NL(Simplify_Count_))),COUNT(__d10(__NN(Simplify_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DropIndicator',COUNT(__d10(__NL(Drop_Indicator_))),COUNT(__d10(__NN(Drop_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ResidentialOrBusinessIndicator',COUNT(__d10(__NL(Residential_Or_Business_Indicator_))),COUNT(__d10(__NN(Residential_Or_Business_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OnlyWayToGetMailIndicator',COUNT(__d10(__NL(Only_Way_To_Get_Mail_Indicator_))),COUNT(__d10(__NN(Only_Way_To_Get_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordTypeCode',COUNT(__d10(__NL(Record_Type_Code_))),COUNT(__d10(__NN(Record_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeCode',COUNT(__d10(__NL(Address_Type_Code_))),COUNT(__d10(__NN(Address_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MixedUsageCode',COUNT(__d10(__NL(Mixed_Usage_Code_))),COUNT(__d10(__NN(Mixed_Usage_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationBeginDate',COUNT(__d10(__NL(Vacation_Begin_Date_))),COUNT(__d10(__NN(Vacation_Begin_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationEndDate',COUNT(__d10(__NL(Vacation_End_Date_))),COUNT(__d10(__NN(Vacation_End_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfCurrentVacationMonths',COUNT(__d10(__NL(Number_Of_Current_Vacation_Months_))),COUNT(__d10(__NN(Number_Of_Current_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaxVacationMonths',COUNT(__d10(__NL(Max_Vacation_Months_))),COUNT(__d10(__NN(Max_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationPeriodsCount',COUNT(__d10(__NL(Vacation_Periods_Count_))),COUNT(__d10(__NN(Vacation_Periods_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d10(__NL(Company_Address_Type_Raw_))),COUNT(__d10(__NN(Company_Address_Type_Raw_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d10(__NL(Company_Address_Type_Derived_))),COUNT(__d10(__NN(Company_Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d10(__NL(Address_Type_Derived_))),COUNT(__d10(__NN(Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressMethod',COUNT(__d10(__NL(Address_Method_))),COUNT(__d10(__NN(Address_Method_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d10(__NL(Is_Active_))),COUNT(__d10(__NN(Is_Active_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDefunct',COUNT(__d10(__NL(Is_Defunct_))),COUNT(__d10(__NN(Is_Defunct_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Type',COUNT(__d10(__NL(Address___Type_))),COUNT(__d10(__NN(Address___Type_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Desc',COUNT(__d10(__NL(Address___Desc_))),COUNT(__d10(__NN(Address___Desc_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d10(__NL(Header_Hit_Flag_))),COUNT(__d10(__NN(Header_Hit_Flag_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d10(__NL(Source_))),COUNT(__d10(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d10(Date_First_Seen_=0)),COUNT(__d10(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d10(Date_Last_Seen_=0)),COUNT(__d10(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DX_Email__Key_Email_Payload_Invalid),COUNT(__d11)},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.prim_range',COUNT(__d11(__NL(Primary_Range_))),COUNT(__d11(__NN(Primary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.predir',COUNT(__d11(__NL(Predirectional_))),COUNT(__d11(__NN(Predirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.prim_name',COUNT(__d11(__NL(Primary_Name_))),COUNT(__d11(__NN(Primary_Name_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.addr_suffix',COUNT(__d11(__NL(Suffix_))),COUNT(__d11(__NN(Suffix_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.postdir',COUNT(__d11(__NL(Postdirectional_))),COUNT(__d11(__NN(Postdirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.unit_desig',COUNT(__d11(__NL(Unit_Designation_))),COUNT(__d11(__NN(Unit_Designation_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.sec_range',COUNT(__d11(__NL(Secondary_Range_))),COUNT(__d11(__NN(Secondary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.p_city_name',COUNT(__d11(__NL(Postal_City_))),COUNT(__d11(__NN(Postal_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.v_city_name',COUNT(__d11(__NL(Vanity_City_))),COUNT(__d11(__NN(Vanity_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.st',COUNT(__d11(__NL(State_))),COUNT(__d11(__NN(State_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.zip',COUNT(__d11(__NL(Z_I_P5_))),COUNT(__d11(__NN(Z_I_P5_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.zip4',COUNT(__d11(__NL(Z_I_P4_))),COUNT(__d11(__NN(Z_I_P4_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_rawaid',COUNT(__d11(__NL(Append_Raw_A_I_D_))),COUNT(__d11(__NN(Append_Raw_A_I_D_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.cart',COUNT(__d11(__NL(Carrier_Route_Number_))),COUNT(__d11(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.cr_sort_sz',COUNT(__d11(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d11(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.lot',COUNT(__d11(__NL(Line_Of_Travel_))),COUNT(__d11(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.lot_order',COUNT(__d11(__NL(Line_Of_Travel_Order_))),COUNT(__d11(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.dbpc',COUNT(__d11(__NL(Delivery_Point_Barcode_))),COUNT(__d11(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.chk_digit',COUNT(__d11(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d11(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.rec_type',COUNT(__d11(__NL(Type_Code_))),COUNT(__d11(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.county',COUNT(__d11(__NL(County_))),COUNT(__d11(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.geo_lat',COUNT(__d11(__NL(Latitude_))),COUNT(__d11(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.geo_long',COUNT(__d11(__NL(Longitude_))),COUNT(__d11(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.msa',COUNT(__d11(__NL(Metropolitan_Statistical_Area_))),COUNT(__d11(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.geo_blk',COUNT(__d11(__NL(Geo_Block_))),COUNT(__d11(__NN(Geo_Block_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.geo_match',COUNT(__d11(__NL(Geo_Match_))),COUNT(__d11(__NN(Geo_Match_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_address.err_stat',COUNT(__d11(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d11(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateFirstSeen',COUNT(__d11(__NL(A_D_V_O_Date_First_Seen_))),COUNT(__d11(__NN(A_D_V_O_Date_First_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateLastSeen',COUNT(__d11(__NL(A_D_V_O_Date_Last_Seen_))),COUNT(__d11(__NN(A_D_V_O_Date_Last_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorFirstReported',COUNT(__d11(__NL(A_D_V_O_Date_Vendor_First_Reported_))),COUNT(__d11(__NN(A_D_V_O_Date_Vendor_First_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorLastReported',COUNT(__d11(__NL(A_D_V_O_Date_Vendor_Last_Reported_))),COUNT(__d11(__NN(A_D_V_O_Date_Vendor_Last_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacancyIndicator',COUNT(__d11(__NL(Vacancy_Indicator_))),COUNT(__d11(__NN(Vacancy_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThrowBackIndicator',COUNT(__d11(__NL(Throw_Back_Indicator_))),COUNT(__d11(__NN(Throw_Back_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalDeliveryIndicator',COUNT(__d11(__NL(Seasonal_Delivery_Indicator_))),COUNT(__d11(__NN(Seasonal_Delivery_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalStartSuppressionDate',COUNT(__d11(__NL(Seasonal_Start_Suppression_Date_))),COUNT(__d11(__NN(Seasonal_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalEndSuppressionDate',COUNT(__d11(__NL(Seasonal_End_Suppression_Date_))),COUNT(__d11(__NN(Seasonal_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotDeliverIndicator',COUNT(__d11(__NL(Do_Not_Deliver_Indicator_))),COUNT(__d11(__NN(Do_Not_Deliver_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotMailIndicator',COUNT(__d11(__NL(Do_Not_Mail_Indicator_))),COUNT(__d11(__NN(Do_Not_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeadCOIndicator',COUNT(__d11(__NL(Dead_C_O_Indicator_))),COUNT(__d11(__NN(Dead_C_O_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HotListIndicator',COUNT(__d11(__NL(Hot_List_Indicator_))),COUNT(__d11(__NN(Hot_List_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeIndicator',COUNT(__d11(__NL(College_Indicator_))),COUNT(__d11(__NN(College_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeStartSuppressionDate',COUNT(__d11(__NL(College_Start_Suppression_Date_))),COUNT(__d11(__NN(College_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeEndSuppressionDate',COUNT(__d11(__NL(College_End_Suppression_Date_))),COUNT(__d11(__NN(College_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StyleCode',COUNT(__d11(__NL(Style_Code_))),COUNT(__d11(__NN(Style_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SimplifyCount',COUNT(__d11(__NL(Simplify_Count_))),COUNT(__d11(__NN(Simplify_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DropIndicator',COUNT(__d11(__NL(Drop_Indicator_))),COUNT(__d11(__NN(Drop_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ResidentialOrBusinessIndicator',COUNT(__d11(__NL(Residential_Or_Business_Indicator_))),COUNT(__d11(__NN(Residential_Or_Business_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OnlyWayToGetMailIndicator',COUNT(__d11(__NL(Only_Way_To_Get_Mail_Indicator_))),COUNT(__d11(__NN(Only_Way_To_Get_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordTypeCode',COUNT(__d11(__NL(Record_Type_Code_))),COUNT(__d11(__NN(Record_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeCode',COUNT(__d11(__NL(Address_Type_Code_))),COUNT(__d11(__NN(Address_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MixedUsageCode',COUNT(__d11(__NL(Mixed_Usage_Code_))),COUNT(__d11(__NN(Mixed_Usage_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationBeginDate',COUNT(__d11(__NL(Vacation_Begin_Date_))),COUNT(__d11(__NN(Vacation_Begin_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationEndDate',COUNT(__d11(__NL(Vacation_End_Date_))),COUNT(__d11(__NN(Vacation_End_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfCurrentVacationMonths',COUNT(__d11(__NL(Number_Of_Current_Vacation_Months_))),COUNT(__d11(__NN(Number_Of_Current_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaxVacationMonths',COUNT(__d11(__NL(Max_Vacation_Months_))),COUNT(__d11(__NN(Max_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationPeriodsCount',COUNT(__d11(__NL(Vacation_Periods_Count_))),COUNT(__d11(__NN(Vacation_Periods_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d11(__NL(Company_Address_Type_Raw_))),COUNT(__d11(__NN(Company_Address_Type_Raw_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d11(__NL(Company_Address_Type_Derived_))),COUNT(__d11(__NN(Company_Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d11(__NL(Address_Type_Derived_))),COUNT(__d11(__NN(Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressMethod',COUNT(__d11(__NL(Address_Method_))),COUNT(__d11(__NN(Address_Method_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d11(__NL(Is_Active_))),COUNT(__d11(__NN(Is_Active_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDefunct',COUNT(__d11(__NL(Is_Defunct_))),COUNT(__d11(__NN(Is_Defunct_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Type',COUNT(__d11(__NL(Address___Type_))),COUNT(__d11(__NN(Address___Type_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Desc',COUNT(__d11(__NL(Address___Desc_))),COUNT(__d11(__NN(Address___Desc_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d11(__NL(Header_Hit_Flag_))),COUNT(__d11(__NN(Header_Hit_Flag_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','email_src',COUNT(__d11(__NL(Source_))),COUNT(__d11(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d11(Date_First_Seen_=0)),COUNT(__d11(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d11(Date_Last_Seen_=0)),COUNT(__d11(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Corp2__Kfetch_LinkIDs_Corp_1_Invalid),COUNT(__d12)},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_prim_range',COUNT(__d12(__NL(Primary_Range_))),COUNT(__d12(__NN(Primary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_predir',COUNT(__d12(__NL(Predirectional_))),COUNT(__d12(__NN(Predirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_prim_name',COUNT(__d12(__NL(Primary_Name_))),COUNT(__d12(__NN(Primary_Name_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_addr_suffix',COUNT(__d12(__NL(Suffix_))),COUNT(__d12(__NN(Suffix_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_postdir',COUNT(__d12(__NL(Postdirectional_))),COUNT(__d12(__NN(Postdirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_unit_desig',COUNT(__d12(__NL(Unit_Designation_))),COUNT(__d12(__NN(Unit_Designation_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_sec_range',COUNT(__d12(__NL(Secondary_Range_))),COUNT(__d12(__NN(Secondary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_p_city_name',COUNT(__d12(__NL(Postal_City_))),COUNT(__d12(__NN(Postal_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_v_city_name',COUNT(__d12(__NL(Vanity_City_))),COUNT(__d12(__NN(Vanity_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_state',COUNT(__d12(__NL(State_))),COUNT(__d12(__NN(State_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_zip5',COUNT(__d12(__NL(Z_I_P5_))),COUNT(__d12(__NN(Z_I_P5_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_zip4',COUNT(__d12(__NL(Z_I_P4_))),COUNT(__d12(__NN(Z_I_P4_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AppendRawAID',COUNT(__d12(__NL(Append_Raw_A_I_D_))),COUNT(__d12(__NN(Append_Raw_A_I_D_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteNumber',COUNT(__d12(__NL(Carrier_Route_Number_))),COUNT(__d12(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteSortationAtZIP',COUNT(__d12(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d12(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravel',COUNT(__d12(__NL(Line_Of_Travel_))),COUNT(__d12(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravelOrder',COUNT(__d12(__NL(Line_Of_Travel_Order_))),COUNT(__d12(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcode',COUNT(__d12(__NL(Delivery_Point_Barcode_))),COUNT(__d12(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcodeCheckDigit',COUNT(__d12(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d12(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeCode',COUNT(__d12(__NL(Type_Code_))),COUNT(__d12(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','County',COUNT(__d12(__NL(County_))),COUNT(__d12(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_geo_lat',COUNT(__d12(__NL(Latitude_))),COUNT(__d12(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_geo_lat',COUNT(__d12(__NL(Longitude_))),COUNT(__d12(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d12(__NL(Metropolitan_Statistical_Area_))),COUNT(__d12(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr1_geo_blk',COUNT(__d12(__NL(Geo_Block_))),COUNT(__d12(__NN(Geo_Block_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoMatch',COUNT(__d12(__NL(Geo_Match_))),COUNT(__d12(__NN(Geo_Match_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ACECleanerErrorCode',COUNT(__d12(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d12(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateFirstSeen',COUNT(__d12(__NL(A_D_V_O_Date_First_Seen_))),COUNT(__d12(__NN(A_D_V_O_Date_First_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateLastSeen',COUNT(__d12(__NL(A_D_V_O_Date_Last_Seen_))),COUNT(__d12(__NN(A_D_V_O_Date_Last_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorFirstReported',COUNT(__d12(__NL(A_D_V_O_Date_Vendor_First_Reported_))),COUNT(__d12(__NN(A_D_V_O_Date_Vendor_First_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorLastReported',COUNT(__d12(__NL(A_D_V_O_Date_Vendor_Last_Reported_))),COUNT(__d12(__NN(A_D_V_O_Date_Vendor_Last_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacancyIndicator',COUNT(__d12(__NL(Vacancy_Indicator_))),COUNT(__d12(__NN(Vacancy_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThrowBackIndicator',COUNT(__d12(__NL(Throw_Back_Indicator_))),COUNT(__d12(__NN(Throw_Back_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalDeliveryIndicator',COUNT(__d12(__NL(Seasonal_Delivery_Indicator_))),COUNT(__d12(__NN(Seasonal_Delivery_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalStartSuppressionDate',COUNT(__d12(__NL(Seasonal_Start_Suppression_Date_))),COUNT(__d12(__NN(Seasonal_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalEndSuppressionDate',COUNT(__d12(__NL(Seasonal_End_Suppression_Date_))),COUNT(__d12(__NN(Seasonal_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotDeliverIndicator',COUNT(__d12(__NL(Do_Not_Deliver_Indicator_))),COUNT(__d12(__NN(Do_Not_Deliver_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotMailIndicator',COUNT(__d12(__NL(Do_Not_Mail_Indicator_))),COUNT(__d12(__NN(Do_Not_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeadCOIndicator',COUNT(__d12(__NL(Dead_C_O_Indicator_))),COUNT(__d12(__NN(Dead_C_O_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HotListIndicator',COUNT(__d12(__NL(Hot_List_Indicator_))),COUNT(__d12(__NN(Hot_List_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeIndicator',COUNT(__d12(__NL(College_Indicator_))),COUNT(__d12(__NN(College_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeStartSuppressionDate',COUNT(__d12(__NL(College_Start_Suppression_Date_))),COUNT(__d12(__NN(College_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeEndSuppressionDate',COUNT(__d12(__NL(College_End_Suppression_Date_))),COUNT(__d12(__NN(College_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StyleCode',COUNT(__d12(__NL(Style_Code_))),COUNT(__d12(__NN(Style_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SimplifyCount',COUNT(__d12(__NL(Simplify_Count_))),COUNT(__d12(__NN(Simplify_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DropIndicator',COUNT(__d12(__NL(Drop_Indicator_))),COUNT(__d12(__NN(Drop_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ResidentialOrBusinessIndicator',COUNT(__d12(__NL(Residential_Or_Business_Indicator_))),COUNT(__d12(__NN(Residential_Or_Business_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OnlyWayToGetMailIndicator',COUNT(__d12(__NL(Only_Way_To_Get_Mail_Indicator_))),COUNT(__d12(__NN(Only_Way_To_Get_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordTypeCode',COUNT(__d12(__NL(Record_Type_Code_))),COUNT(__d12(__NN(Record_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeCode',COUNT(__d12(__NL(Address_Type_Code_))),COUNT(__d12(__NN(Address_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MixedUsageCode',COUNT(__d12(__NL(Mixed_Usage_Code_))),COUNT(__d12(__NN(Mixed_Usage_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationBeginDate',COUNT(__d12(__NL(Vacation_Begin_Date_))),COUNT(__d12(__NN(Vacation_Begin_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationEndDate',COUNT(__d12(__NL(Vacation_End_Date_))),COUNT(__d12(__NN(Vacation_End_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfCurrentVacationMonths',COUNT(__d12(__NL(Number_Of_Current_Vacation_Months_))),COUNT(__d12(__NN(Number_Of_Current_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaxVacationMonths',COUNT(__d12(__NL(Max_Vacation_Months_))),COUNT(__d12(__NN(Max_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationPeriodsCount',COUNT(__d12(__NL(Vacation_Periods_Count_))),COUNT(__d12(__NN(Vacation_Periods_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d12(__NL(Company_Address_Type_Raw_))),COUNT(__d12(__NN(Company_Address_Type_Raw_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d12(__NL(Company_Address_Type_Derived_))),COUNT(__d12(__NN(Company_Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d12(__NL(Address_Type_Derived_))),COUNT(__d12(__NN(Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressMethod',COUNT(__d12(__NL(Address_Method_))),COUNT(__d12(__NN(Address_Method_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d12(__NL(Is_Active_))),COUNT(__d12(__NN(Is_Active_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDefunct',COUNT(__d12(__NL(Is_Defunct_))),COUNT(__d12(__NN(Is_Defunct_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Corp_Address1_Type_CD',COUNT(__d12(__NL(Address___Type_))),COUNT(__d12(__NN(Address___Type_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Corp_Address1_Type_Desc',COUNT(__d12(__NL(Address___Desc_))),COUNT(__d12(__NN(Address___Desc_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d12(__NL(Header_Hit_Flag_))),COUNT(__d12(__NN(Header_Hit_Flag_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d12(__NL(Source_))),COUNT(__d12(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d12(Date_First_Seen_=0)),COUNT(__d12(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d12(Date_Last_Seen_=0)),COUNT(__d12(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Corp2__Kfetch_LinkIDs_Corp_2_Invalid),COUNT(__d13)},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_prim_range',COUNT(__d13(__NL(Primary_Range_))),COUNT(__d13(__NN(Primary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_predir',COUNT(__d13(__NL(Predirectional_))),COUNT(__d13(__NN(Predirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_prim_name',COUNT(__d13(__NL(Primary_Name_))),COUNT(__d13(__NN(Primary_Name_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_addr_suffix',COUNT(__d13(__NL(Suffix_))),COUNT(__d13(__NN(Suffix_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_postdir',COUNT(__d13(__NL(Postdirectional_))),COUNT(__d13(__NN(Postdirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_unit_desig',COUNT(__d13(__NL(Unit_Designation_))),COUNT(__d13(__NN(Unit_Designation_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_sec_range',COUNT(__d13(__NL(Secondary_Range_))),COUNT(__d13(__NN(Secondary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_p_city_name',COUNT(__d13(__NL(Postal_City_))),COUNT(__d13(__NN(Postal_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_v_city_name',COUNT(__d13(__NL(Vanity_City_))),COUNT(__d13(__NN(Vanity_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_state',COUNT(__d13(__NL(State_))),COUNT(__d13(__NN(State_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_zip5',COUNT(__d13(__NL(Z_I_P5_))),COUNT(__d13(__NN(Z_I_P5_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_zip4',COUNT(__d13(__NL(Z_I_P4_))),COUNT(__d13(__NN(Z_I_P4_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AppendRawAID',COUNT(__d13(__NL(Append_Raw_A_I_D_))),COUNT(__d13(__NN(Append_Raw_A_I_D_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteNumber',COUNT(__d13(__NL(Carrier_Route_Number_))),COUNT(__d13(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteSortationAtZIP',COUNT(__d13(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d13(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravel',COUNT(__d13(__NL(Line_Of_Travel_))),COUNT(__d13(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravelOrder',COUNT(__d13(__NL(Line_Of_Travel_Order_))),COUNT(__d13(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcode',COUNT(__d13(__NL(Delivery_Point_Barcode_))),COUNT(__d13(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcodeCheckDigit',COUNT(__d13(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d13(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeCode',COUNT(__d13(__NL(Type_Code_))),COUNT(__d13(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','County',COUNT(__d13(__NL(County_))),COUNT(__d13(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_geo_lat',COUNT(__d13(__NL(Latitude_))),COUNT(__d13(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_geo_lat',COUNT(__d13(__NL(Longitude_))),COUNT(__d13(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d13(__NL(Metropolitan_Statistical_Area_))),COUNT(__d13(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_addr2_geo_blk',COUNT(__d13(__NL(Geo_Block_))),COUNT(__d13(__NN(Geo_Block_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoMatch',COUNT(__d13(__NL(Geo_Match_))),COUNT(__d13(__NN(Geo_Match_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ACECleanerErrorCode',COUNT(__d13(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d13(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateFirstSeen',COUNT(__d13(__NL(A_D_V_O_Date_First_Seen_))),COUNT(__d13(__NN(A_D_V_O_Date_First_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateLastSeen',COUNT(__d13(__NL(A_D_V_O_Date_Last_Seen_))),COUNT(__d13(__NN(A_D_V_O_Date_Last_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorFirstReported',COUNT(__d13(__NL(A_D_V_O_Date_Vendor_First_Reported_))),COUNT(__d13(__NN(A_D_V_O_Date_Vendor_First_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorLastReported',COUNT(__d13(__NL(A_D_V_O_Date_Vendor_Last_Reported_))),COUNT(__d13(__NN(A_D_V_O_Date_Vendor_Last_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacancyIndicator',COUNT(__d13(__NL(Vacancy_Indicator_))),COUNT(__d13(__NN(Vacancy_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThrowBackIndicator',COUNT(__d13(__NL(Throw_Back_Indicator_))),COUNT(__d13(__NN(Throw_Back_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalDeliveryIndicator',COUNT(__d13(__NL(Seasonal_Delivery_Indicator_))),COUNT(__d13(__NN(Seasonal_Delivery_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalStartSuppressionDate',COUNT(__d13(__NL(Seasonal_Start_Suppression_Date_))),COUNT(__d13(__NN(Seasonal_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalEndSuppressionDate',COUNT(__d13(__NL(Seasonal_End_Suppression_Date_))),COUNT(__d13(__NN(Seasonal_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotDeliverIndicator',COUNT(__d13(__NL(Do_Not_Deliver_Indicator_))),COUNT(__d13(__NN(Do_Not_Deliver_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotMailIndicator',COUNT(__d13(__NL(Do_Not_Mail_Indicator_))),COUNT(__d13(__NN(Do_Not_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeadCOIndicator',COUNT(__d13(__NL(Dead_C_O_Indicator_))),COUNT(__d13(__NN(Dead_C_O_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HotListIndicator',COUNT(__d13(__NL(Hot_List_Indicator_))),COUNT(__d13(__NN(Hot_List_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeIndicator',COUNT(__d13(__NL(College_Indicator_))),COUNT(__d13(__NN(College_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeStartSuppressionDate',COUNT(__d13(__NL(College_Start_Suppression_Date_))),COUNT(__d13(__NN(College_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeEndSuppressionDate',COUNT(__d13(__NL(College_End_Suppression_Date_))),COUNT(__d13(__NN(College_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StyleCode',COUNT(__d13(__NL(Style_Code_))),COUNT(__d13(__NN(Style_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SimplifyCount',COUNT(__d13(__NL(Simplify_Count_))),COUNT(__d13(__NN(Simplify_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DropIndicator',COUNT(__d13(__NL(Drop_Indicator_))),COUNT(__d13(__NN(Drop_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ResidentialOrBusinessIndicator',COUNT(__d13(__NL(Residential_Or_Business_Indicator_))),COUNT(__d13(__NN(Residential_Or_Business_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OnlyWayToGetMailIndicator',COUNT(__d13(__NL(Only_Way_To_Get_Mail_Indicator_))),COUNT(__d13(__NN(Only_Way_To_Get_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordTypeCode',COUNT(__d13(__NL(Record_Type_Code_))),COUNT(__d13(__NN(Record_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeCode',COUNT(__d13(__NL(Address_Type_Code_))),COUNT(__d13(__NN(Address_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MixedUsageCode',COUNT(__d13(__NL(Mixed_Usage_Code_))),COUNT(__d13(__NN(Mixed_Usage_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationBeginDate',COUNT(__d13(__NL(Vacation_Begin_Date_))),COUNT(__d13(__NN(Vacation_Begin_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationEndDate',COUNT(__d13(__NL(Vacation_End_Date_))),COUNT(__d13(__NN(Vacation_End_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfCurrentVacationMonths',COUNT(__d13(__NL(Number_Of_Current_Vacation_Months_))),COUNT(__d13(__NN(Number_Of_Current_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaxVacationMonths',COUNT(__d13(__NL(Max_Vacation_Months_))),COUNT(__d13(__NN(Max_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationPeriodsCount',COUNT(__d13(__NL(Vacation_Periods_Count_))),COUNT(__d13(__NN(Vacation_Periods_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d13(__NL(Company_Address_Type_Raw_))),COUNT(__d13(__NN(Company_Address_Type_Raw_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d13(__NL(Company_Address_Type_Derived_))),COUNT(__d13(__NN(Company_Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d13(__NL(Address_Type_Derived_))),COUNT(__d13(__NN(Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressMethod',COUNT(__d13(__NL(Address_Method_))),COUNT(__d13(__NN(Address_Method_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d13(__NL(Is_Active_))),COUNT(__d13(__NN(Is_Active_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDefunct',COUNT(__d13(__NL(Is_Defunct_))),COUNT(__d13(__NN(Is_Defunct_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Corp_Address2_Type_CD',COUNT(__d13(__NL(Address___Type_))),COUNT(__d13(__NN(Address___Type_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Corp_Address2_Type_Desc',COUNT(__d13(__NL(Address___Desc_))),COUNT(__d13(__NN(Address___Desc_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d13(__NL(Header_Hit_Flag_))),COUNT(__d13(__NN(Header_Hit_Flag_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d13(__NL(Source_))),COUNT(__d13(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d13(Date_First_Seen_=0)),COUNT(__d13(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d13(Date_Last_Seen_=0)),COUNT(__d13(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Corp2__Kfetch_LinkIDs_Corp_3_Invalid),COUNT(__d14)},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_prim_range',COUNT(__d14(__NL(Primary_Range_))),COUNT(__d14(__NN(Primary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_predir',COUNT(__d14(__NL(Predirectional_))),COUNT(__d14(__NN(Predirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_prim_name',COUNT(__d14(__NL(Primary_Name_))),COUNT(__d14(__NN(Primary_Name_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_addr_suffix',COUNT(__d14(__NL(Suffix_))),COUNT(__d14(__NN(Suffix_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_postdir',COUNT(__d14(__NL(Postdirectional_))),COUNT(__d14(__NN(Postdirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_unit_desig',COUNT(__d14(__NL(Unit_Designation_))),COUNT(__d14(__NN(Unit_Designation_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_sec_range',COUNT(__d14(__NL(Secondary_Range_))),COUNT(__d14(__NN(Secondary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_p_city_name',COUNT(__d14(__NL(Postal_City_))),COUNT(__d14(__NN(Postal_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_v_city_name',COUNT(__d14(__NL(Vanity_City_))),COUNT(__d14(__NN(Vanity_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_state',COUNT(__d14(__NL(State_))),COUNT(__d14(__NN(State_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_zip5',COUNT(__d14(__NL(Z_I_P5_))),COUNT(__d14(__NN(Z_I_P5_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_zip4',COUNT(__d14(__NL(Z_I_P4_))),COUNT(__d14(__NN(Z_I_P4_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AppendRawAID',COUNT(__d14(__NL(Append_Raw_A_I_D_))),COUNT(__d14(__NN(Append_Raw_A_I_D_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteNumber',COUNT(__d14(__NL(Carrier_Route_Number_))),COUNT(__d14(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteSortationAtZIP',COUNT(__d14(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d14(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravel',COUNT(__d14(__NL(Line_Of_Travel_))),COUNT(__d14(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravelOrder',COUNT(__d14(__NL(Line_Of_Travel_Order_))),COUNT(__d14(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcode',COUNT(__d14(__NL(Delivery_Point_Barcode_))),COUNT(__d14(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcodeCheckDigit',COUNT(__d14(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d14(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeCode',COUNT(__d14(__NL(Type_Code_))),COUNT(__d14(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','County',COUNT(__d14(__NL(County_))),COUNT(__d14(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_geo_lat',COUNT(__d14(__NL(Latitude_))),COUNT(__d14(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_geo_lat',COUNT(__d14(__NL(Longitude_))),COUNT(__d14(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d14(__NL(Metropolitan_Statistical_Area_))),COUNT(__d14(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_geo_blk',COUNT(__d14(__NL(Geo_Block_))),COUNT(__d14(__NN(Geo_Block_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoMatch',COUNT(__d14(__NL(Geo_Match_))),COUNT(__d14(__NN(Geo_Match_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ACECleanerErrorCode',COUNT(__d14(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d14(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateFirstSeen',COUNT(__d14(__NL(A_D_V_O_Date_First_Seen_))),COUNT(__d14(__NN(A_D_V_O_Date_First_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateLastSeen',COUNT(__d14(__NL(A_D_V_O_Date_Last_Seen_))),COUNT(__d14(__NN(A_D_V_O_Date_Last_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorFirstReported',COUNT(__d14(__NL(A_D_V_O_Date_Vendor_First_Reported_))),COUNT(__d14(__NN(A_D_V_O_Date_Vendor_First_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorLastReported',COUNT(__d14(__NL(A_D_V_O_Date_Vendor_Last_Reported_))),COUNT(__d14(__NN(A_D_V_O_Date_Vendor_Last_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacancyIndicator',COUNT(__d14(__NL(Vacancy_Indicator_))),COUNT(__d14(__NN(Vacancy_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThrowBackIndicator',COUNT(__d14(__NL(Throw_Back_Indicator_))),COUNT(__d14(__NN(Throw_Back_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalDeliveryIndicator',COUNT(__d14(__NL(Seasonal_Delivery_Indicator_))),COUNT(__d14(__NN(Seasonal_Delivery_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalStartSuppressionDate',COUNT(__d14(__NL(Seasonal_Start_Suppression_Date_))),COUNT(__d14(__NN(Seasonal_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalEndSuppressionDate',COUNT(__d14(__NL(Seasonal_End_Suppression_Date_))),COUNT(__d14(__NN(Seasonal_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotDeliverIndicator',COUNT(__d14(__NL(Do_Not_Deliver_Indicator_))),COUNT(__d14(__NN(Do_Not_Deliver_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotMailIndicator',COUNT(__d14(__NL(Do_Not_Mail_Indicator_))),COUNT(__d14(__NN(Do_Not_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeadCOIndicator',COUNT(__d14(__NL(Dead_C_O_Indicator_))),COUNT(__d14(__NN(Dead_C_O_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HotListIndicator',COUNT(__d14(__NL(Hot_List_Indicator_))),COUNT(__d14(__NN(Hot_List_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeIndicator',COUNT(__d14(__NL(College_Indicator_))),COUNT(__d14(__NN(College_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeStartSuppressionDate',COUNT(__d14(__NL(College_Start_Suppression_Date_))),COUNT(__d14(__NN(College_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeEndSuppressionDate',COUNT(__d14(__NL(College_End_Suppression_Date_))),COUNT(__d14(__NN(College_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StyleCode',COUNT(__d14(__NL(Style_Code_))),COUNT(__d14(__NN(Style_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SimplifyCount',COUNT(__d14(__NL(Simplify_Count_))),COUNT(__d14(__NN(Simplify_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DropIndicator',COUNT(__d14(__NL(Drop_Indicator_))),COUNT(__d14(__NN(Drop_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ResidentialOrBusinessIndicator',COUNT(__d14(__NL(Residential_Or_Business_Indicator_))),COUNT(__d14(__NN(Residential_Or_Business_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OnlyWayToGetMailIndicator',COUNT(__d14(__NL(Only_Way_To_Get_Mail_Indicator_))),COUNT(__d14(__NN(Only_Way_To_Get_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordTypeCode',COUNT(__d14(__NL(Record_Type_Code_))),COUNT(__d14(__NN(Record_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeCode',COUNT(__d14(__NL(Address_Type_Code_))),COUNT(__d14(__NN(Address_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MixedUsageCode',COUNT(__d14(__NL(Mixed_Usage_Code_))),COUNT(__d14(__NN(Mixed_Usage_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationBeginDate',COUNT(__d14(__NL(Vacation_Begin_Date_))),COUNT(__d14(__NN(Vacation_Begin_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationEndDate',COUNT(__d14(__NL(Vacation_End_Date_))),COUNT(__d14(__NN(Vacation_End_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfCurrentVacationMonths',COUNT(__d14(__NL(Number_Of_Current_Vacation_Months_))),COUNT(__d14(__NN(Number_Of_Current_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaxVacationMonths',COUNT(__d14(__NL(Max_Vacation_Months_))),COUNT(__d14(__NN(Max_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationPeriodsCount',COUNT(__d14(__NL(Vacation_Periods_Count_))),COUNT(__d14(__NN(Vacation_Periods_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d14(__NL(Company_Address_Type_Raw_))),COUNT(__d14(__NN(Company_Address_Type_Raw_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d14(__NL(Company_Address_Type_Derived_))),COUNT(__d14(__NN(Company_Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d14(__NL(Address_Type_Derived_))),COUNT(__d14(__NN(Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressMethod',COUNT(__d14(__NL(Address_Method_))),COUNT(__d14(__NN(Address_Method_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d14(__NL(Is_Active_))),COUNT(__d14(__NN(Is_Active_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDefunct',COUNT(__d14(__NL(Is_Defunct_))),COUNT(__d14(__NN(Is_Defunct_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_address_Type_CD',COUNT(__d14(__NL(Address___Type_))),COUNT(__d14(__NN(Address___Type_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_ra_address_Type_Desc',COUNT(__d14(__NL(Address___Desc_))),COUNT(__d14(__NN(Address___Desc_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d14(__NL(Header_Hit_Flag_))),COUNT(__d14(__NN(Header_Hit_Flag_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d14(__NL(Source_))),COUNT(__d14(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d14(Date_First_Seen_=0)),COUNT(__d14(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d14(Date_Last_Seen_=0)),COUNT(__d14(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_InfoUSA__Key_DEADCO_LinkIds_Invalid),COUNT(__d15)},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d15(__NL(Primary_Range_))),COUNT(__d15(__NN(Primary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d15(__NL(Predirectional_))),COUNT(__d15(__NN(Predirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d15(__NL(Primary_Name_))),COUNT(__d15(__NN(Primary_Name_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d15(__NL(Suffix_))),COUNT(__d15(__NN(Suffix_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d15(__NL(Postdirectional_))),COUNT(__d15(__NN(Postdirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','unit_desig',COUNT(__d15(__NL(Unit_Designation_))),COUNT(__d15(__NN(Unit_Designation_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d15(__NL(Secondary_Range_))),COUNT(__d15(__NN(Secondary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','p_city_name',COUNT(__d15(__NL(Postal_City_))),COUNT(__d15(__NN(Postal_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','v_city_name',COUNT(__d15(__NL(Vanity_City_))),COUNT(__d15(__NN(Vanity_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d15(__NL(State_))),COUNT(__d15(__NN(State_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip5',COUNT(__d15(__NL(Z_I_P5_))),COUNT(__d15(__NN(Z_I_P5_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip4',COUNT(__d15(__NL(Z_I_P4_))),COUNT(__d15(__NN(Z_I_P4_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AppendRawAID',COUNT(__d15(__NL(Append_Raw_A_I_D_))),COUNT(__d15(__NN(Append_Raw_A_I_D_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteNumber',COUNT(__d15(__NL(Carrier_Route_Number_))),COUNT(__d15(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteSortationAtZIP',COUNT(__d15(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d15(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravel',COUNT(__d15(__NL(Line_Of_Travel_))),COUNT(__d15(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravelOrder',COUNT(__d15(__NL(Line_Of_Travel_Order_))),COUNT(__d15(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcode',COUNT(__d15(__NL(Delivery_Point_Barcode_))),COUNT(__d15(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcodeCheckDigit',COUNT(__d15(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d15(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeCode',COUNT(__d15(__NL(Type_Code_))),COUNT(__d15(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','County',COUNT(__d15(__NL(County_))),COUNT(__d15(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_lat',COUNT(__d15(__NL(Latitude_))),COUNT(__d15(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_long',COUNT(__d15(__NL(Longitude_))),COUNT(__d15(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d15(__NL(Metropolitan_Statistical_Area_))),COUNT(__d15(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_blk',COUNT(__d15(__NL(Geo_Block_))),COUNT(__d15(__NN(Geo_Block_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoMatch',COUNT(__d15(__NL(Geo_Match_))),COUNT(__d15(__NN(Geo_Match_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ACECleanerErrorCode',COUNT(__d15(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d15(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateFirstSeen',COUNT(__d15(__NL(A_D_V_O_Date_First_Seen_))),COUNT(__d15(__NN(A_D_V_O_Date_First_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateLastSeen',COUNT(__d15(__NL(A_D_V_O_Date_Last_Seen_))),COUNT(__d15(__NN(A_D_V_O_Date_Last_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorFirstReported',COUNT(__d15(__NL(A_D_V_O_Date_Vendor_First_Reported_))),COUNT(__d15(__NN(A_D_V_O_Date_Vendor_First_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorLastReported',COUNT(__d15(__NL(A_D_V_O_Date_Vendor_Last_Reported_))),COUNT(__d15(__NN(A_D_V_O_Date_Vendor_Last_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacancyIndicator',COUNT(__d15(__NL(Vacancy_Indicator_))),COUNT(__d15(__NN(Vacancy_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThrowBackIndicator',COUNT(__d15(__NL(Throw_Back_Indicator_))),COUNT(__d15(__NN(Throw_Back_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalDeliveryIndicator',COUNT(__d15(__NL(Seasonal_Delivery_Indicator_))),COUNT(__d15(__NN(Seasonal_Delivery_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalStartSuppressionDate',COUNT(__d15(__NL(Seasonal_Start_Suppression_Date_))),COUNT(__d15(__NN(Seasonal_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalEndSuppressionDate',COUNT(__d15(__NL(Seasonal_End_Suppression_Date_))),COUNT(__d15(__NN(Seasonal_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotDeliverIndicator',COUNT(__d15(__NL(Do_Not_Deliver_Indicator_))),COUNT(__d15(__NN(Do_Not_Deliver_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotMailIndicator',COUNT(__d15(__NL(Do_Not_Mail_Indicator_))),COUNT(__d15(__NN(Do_Not_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HotListIndicator',COUNT(__d15(__NL(Hot_List_Indicator_))),COUNT(__d15(__NN(Hot_List_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeIndicator',COUNT(__d15(__NL(College_Indicator_))),COUNT(__d15(__NN(College_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeStartSuppressionDate',COUNT(__d15(__NL(College_Start_Suppression_Date_))),COUNT(__d15(__NN(College_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeEndSuppressionDate',COUNT(__d15(__NL(College_End_Suppression_Date_))),COUNT(__d15(__NN(College_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StyleCode',COUNT(__d15(__NL(Style_Code_))),COUNT(__d15(__NN(Style_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SimplifyCount',COUNT(__d15(__NL(Simplify_Count_))),COUNT(__d15(__NN(Simplify_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DropIndicator',COUNT(__d15(__NL(Drop_Indicator_))),COUNT(__d15(__NN(Drop_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ResidentialOrBusinessIndicator',COUNT(__d15(__NL(Residential_Or_Business_Indicator_))),COUNT(__d15(__NN(Residential_Or_Business_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OnlyWayToGetMailIndicator',COUNT(__d15(__NL(Only_Way_To_Get_Mail_Indicator_))),COUNT(__d15(__NN(Only_Way_To_Get_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordTypeCode',COUNT(__d15(__NL(Record_Type_Code_))),COUNT(__d15(__NN(Record_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeCode',COUNT(__d15(__NL(Address_Type_Code_))),COUNT(__d15(__NN(Address_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MixedUsageCode',COUNT(__d15(__NL(Mixed_Usage_Code_))),COUNT(__d15(__NN(Mixed_Usage_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationBeginDate',COUNT(__d15(__NL(Vacation_Begin_Date_))),COUNT(__d15(__NN(Vacation_Begin_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationEndDate',COUNT(__d15(__NL(Vacation_End_Date_))),COUNT(__d15(__NN(Vacation_End_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfCurrentVacationMonths',COUNT(__d15(__NL(Number_Of_Current_Vacation_Months_))),COUNT(__d15(__NN(Number_Of_Current_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaxVacationMonths',COUNT(__d15(__NL(Max_Vacation_Months_))),COUNT(__d15(__NN(Max_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationPeriodsCount',COUNT(__d15(__NL(Vacation_Periods_Count_))),COUNT(__d15(__NN(Vacation_Periods_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d15(__NL(Company_Address_Type_Raw_))),COUNT(__d15(__NN(Company_Address_Type_Raw_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d15(__NL(Company_Address_Type_Derived_))),COUNT(__d15(__NN(Company_Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d15(__NL(Address_Type_Derived_))),COUNT(__d15(__NN(Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressMethod',COUNT(__d15(__NL(Address_Method_))),COUNT(__d15(__NN(Address_Method_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d15(__NL(Is_Active_))),COUNT(__d15(__NN(Is_Active_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDefunct',COUNT(__d15(__NL(Is_Defunct_))),COUNT(__d15(__NN(Is_Defunct_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Type',COUNT(__d15(__NL(Address___Type_))),COUNT(__d15(__NN(Address___Type_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Desc',COUNT(__d15(__NL(Address___Desc_))),COUNT(__d15(__NN(Address___Desc_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d15(__NL(Header_Hit_Flag_))),COUNT(__d15(__NN(Header_Hit_Flag_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d15(__NL(Source_))),COUNT(__d15(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d15(Date_First_Seen_=0)),COUNT(__d15(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d15(Date_Last_Seen_=0)),COUNT(__d15(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Kfetch2_LinkIds_Invalid),COUNT(__d16)},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d16(__NL(Primary_Range_))),COUNT(__d16(__NN(Primary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d16(__NL(Predirectional_))),COUNT(__d16(__NN(Predirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d16(__NL(Primary_Name_))),COUNT(__d16(__NN(Primary_Name_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addr_suffix',COUNT(__d16(__NL(Suffix_))),COUNT(__d16(__NN(Suffix_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d16(__NL(Postdirectional_))),COUNT(__d16(__NN(Postdirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UnitDesignation',COUNT(__d16(__NL(Unit_Designation_))),COUNT(__d16(__NN(Unit_Designation_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d16(__NL(Secondary_Range_))),COUNT(__d16(__NN(Secondary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','p_city_name',COUNT(__d16(__NL(Postal_City_))),COUNT(__d16(__NN(Postal_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','v_city_name',COUNT(__d16(__NL(Vanity_City_))),COUNT(__d16(__NN(Vanity_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','State',COUNT(__d16(__NL(State_))),COUNT(__d16(__NN(State_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d16(__NL(Z_I_P5_))),COUNT(__d16(__NN(Z_I_P5_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip4',COUNT(__d16(__NL(Z_I_P4_))),COUNT(__d16(__NN(Z_I_P4_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AppendRawAID',COUNT(__d16(__NL(Append_Raw_A_I_D_))),COUNT(__d16(__NN(Append_Raw_A_I_D_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cart',COUNT(__d16(__NL(Carrier_Route_Number_))),COUNT(__d16(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cr_sort_sz',COUNT(__d16(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d16(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lot',COUNT(__d16(__NL(Line_Of_Travel_))),COUNT(__d16(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lot_order',COUNT(__d16(__NL(Line_Of_Travel_Order_))),COUNT(__d16(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dbpc',COUNT(__d16(__NL(Delivery_Point_Barcode_))),COUNT(__d16(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','chk_digit',COUNT(__d16(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d16(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec_type',COUNT(__d16(__NL(Type_Code_))),COUNT(__d16(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','county',COUNT(__d16(__NL(County_))),COUNT(__d16(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_lat',COUNT(__d16(__NL(Latitude_))),COUNT(__d16(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_long',COUNT(__d16(__NL(Longitude_))),COUNT(__d16(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','msa',COUNT(__d16(__NL(Metropolitan_Statistical_Area_))),COUNT(__d16(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_blk',COUNT(__d16(__NL(Geo_Block_))),COUNT(__d16(__NN(Geo_Block_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_match',COUNT(__d16(__NL(Geo_Match_))),COUNT(__d16(__NN(Geo_Match_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','err_stat',COUNT(__d16(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d16(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateFirstSeen',COUNT(__d16(__NL(A_D_V_O_Date_First_Seen_))),COUNT(__d16(__NN(A_D_V_O_Date_First_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateLastSeen',COUNT(__d16(__NL(A_D_V_O_Date_Last_Seen_))),COUNT(__d16(__NN(A_D_V_O_Date_Last_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorFirstReported',COUNT(__d16(__NL(A_D_V_O_Date_Vendor_First_Reported_))),COUNT(__d16(__NN(A_D_V_O_Date_Vendor_First_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorLastReported',COUNT(__d16(__NL(A_D_V_O_Date_Vendor_Last_Reported_))),COUNT(__d16(__NN(A_D_V_O_Date_Vendor_Last_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacancyIndicator',COUNT(__d16(__NL(Vacancy_Indicator_))),COUNT(__d16(__NN(Vacancy_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThrowBackIndicator',COUNT(__d16(__NL(Throw_Back_Indicator_))),COUNT(__d16(__NN(Throw_Back_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalDeliveryIndicator',COUNT(__d16(__NL(Seasonal_Delivery_Indicator_))),COUNT(__d16(__NN(Seasonal_Delivery_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalStartSuppressionDate',COUNT(__d16(__NL(Seasonal_Start_Suppression_Date_))),COUNT(__d16(__NN(Seasonal_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalEndSuppressionDate',COUNT(__d16(__NL(Seasonal_End_Suppression_Date_))),COUNT(__d16(__NN(Seasonal_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotDeliverIndicator',COUNT(__d16(__NL(Do_Not_Deliver_Indicator_))),COUNT(__d16(__NN(Do_Not_Deliver_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotMailIndicator',COUNT(__d16(__NL(Do_Not_Mail_Indicator_))),COUNT(__d16(__NN(Do_Not_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeadCOIndicator',COUNT(__d16(__NL(Dead_C_O_Indicator_))),COUNT(__d16(__NN(Dead_C_O_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HotListIndicator',COUNT(__d16(__NL(Hot_List_Indicator_))),COUNT(__d16(__NN(Hot_List_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeIndicator',COUNT(__d16(__NL(College_Indicator_))),COUNT(__d16(__NN(College_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeStartSuppressionDate',COUNT(__d16(__NL(College_Start_Suppression_Date_))),COUNT(__d16(__NN(College_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeEndSuppressionDate',COUNT(__d16(__NL(College_End_Suppression_Date_))),COUNT(__d16(__NN(College_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StyleCode',COUNT(__d16(__NL(Style_Code_))),COUNT(__d16(__NN(Style_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SimplifyCount',COUNT(__d16(__NL(Simplify_Count_))),COUNT(__d16(__NN(Simplify_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DropIndicator',COUNT(__d16(__NL(Drop_Indicator_))),COUNT(__d16(__NN(Drop_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ResidentialOrBusinessIndicator',COUNT(__d16(__NL(Residential_Or_Business_Indicator_))),COUNT(__d16(__NN(Residential_Or_Business_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OnlyWayToGetMailIndicator',COUNT(__d16(__NL(Only_Way_To_Get_Mail_Indicator_))),COUNT(__d16(__NN(Only_Way_To_Get_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordTypeCode',COUNT(__d16(__NL(Record_Type_Code_))),COUNT(__d16(__NN(Record_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeCode',COUNT(__d16(__NL(Address_Type_Code_))),COUNT(__d16(__NN(Address_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MixedUsageCode',COUNT(__d16(__NL(Mixed_Usage_Code_))),COUNT(__d16(__NN(Mixed_Usage_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationBeginDate',COUNT(__d16(__NL(Vacation_Begin_Date_))),COUNT(__d16(__NN(Vacation_Begin_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationEndDate',COUNT(__d16(__NL(Vacation_End_Date_))),COUNT(__d16(__NN(Vacation_End_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfCurrentVacationMonths',COUNT(__d16(__NL(Number_Of_Current_Vacation_Months_))),COUNT(__d16(__NN(Number_Of_Current_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaxVacationMonths',COUNT(__d16(__NL(Max_Vacation_Months_))),COUNT(__d16(__NN(Max_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationPeriodsCount',COUNT(__d16(__NL(Vacation_Periods_Count_))),COUNT(__d16(__NN(Vacation_Periods_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d16(__NL(Company_Address_Type_Raw_))),COUNT(__d16(__NN(Company_Address_Type_Raw_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d16(__NL(Company_Address_Type_Derived_))),COUNT(__d16(__NN(Company_Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d16(__NL(Address_Type_Derived_))),COUNT(__d16(__NN(Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressMethod',COUNT(__d16(__NL(Address_Method_))),COUNT(__d16(__NN(Address_Method_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d16(__NL(Is_Active_))),COUNT(__d16(__NN(Is_Active_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDefunct',COUNT(__d16(__NL(Is_Defunct_))),COUNT(__d16(__NN(Is_Defunct_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Type',COUNT(__d16(__NL(Address___Type_))),COUNT(__d16(__NN(Address___Type_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Desc',COUNT(__d16(__NL(Address___Desc_))),COUNT(__d16(__NN(Address___Desc_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d16(__NL(Header_Hit_Flag_))),COUNT(__d16(__NN(Header_Hit_Flag_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d16(__NL(Source_))),COUNT(__d16(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d16(Date_First_Seen_=0)),COUNT(__d16(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d16(Date_Last_Seen_=0)),COUNT(__d16(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Address_Invalid),COUNT(__d17)},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d17(__NL(Primary_Range_))),COUNT(__d17(__NN(Primary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','predir',COUNT(__d17(__NL(Predirectional_))),COUNT(__d17(__NN(Predirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d17(__NL(Primary_Name_))),COUNT(__d17(__NN(Primary_Name_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','suffix',COUNT(__d17(__NL(Suffix_))),COUNT(__d17(__NN(Suffix_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','postdir',COUNT(__d17(__NL(Postdirectional_))),COUNT(__d17(__NN(Postdirectional_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','unit_desig',COUNT(__d17(__NL(Unit_Designation_))),COUNT(__d17(__NN(Unit_Designation_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sec_range',COUNT(__d17(__NL(Secondary_Range_))),COUNT(__d17(__NN(Secondary_Range_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','city_name',COUNT(__d17(__NL(Postal_City_))),COUNT(__d17(__NN(Postal_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VanityCity',COUNT(__d17(__NL(Vanity_City_))),COUNT(__d17(__NN(Vanity_City_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','st',COUNT(__d17(__NL(State_))),COUNT(__d17(__NN(State_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d17(__NL(Z_I_P5_))),COUNT(__d17(__NN(Z_I_P5_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZIP4',COUNT(__d17(__NL(Z_I_P4_))),COUNT(__d17(__NN(Z_I_P4_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AppendRawAID',COUNT(__d17(__NL(Append_Raw_A_I_D_))),COUNT(__d17(__NN(Append_Raw_A_I_D_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteNumber',COUNT(__d17(__NL(Carrier_Route_Number_))),COUNT(__d17(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierRouteSortationAtZIP',COUNT(__d17(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d17(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravel',COUNT(__d17(__NL(Line_Of_Travel_))),COUNT(__d17(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LineOfTravelOrder',COUNT(__d17(__NL(Line_Of_Travel_Order_))),COUNT(__d17(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcode',COUNT(__d17(__NL(Delivery_Point_Barcode_))),COUNT(__d17(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeliveryPointBarcodeCheckDigit',COUNT(__d17(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d17(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeCode',COUNT(__d17(__NL(Type_Code_))),COUNT(__d17(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','county',COUNT(__d17(__NL(County_))),COUNT(__d17(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Latitude',COUNT(__d17(__NL(Latitude_))),COUNT(__d17(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Longitude',COUNT(__d17(__NL(Longitude_))),COUNT(__d17(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MetropolitanStatisticalArea',COUNT(__d17(__NL(Metropolitan_Statistical_Area_))),COUNT(__d17(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_blk',COUNT(__d17(__NL(Geo_Block_))),COUNT(__d17(__NN(Geo_Block_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GeoMatch',COUNT(__d17(__NL(Geo_Match_))),COUNT(__d17(__NN(Geo_Match_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ACECleanerErrorCode',COUNT(__d17(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d17(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateFirstSeen',COUNT(__d17(__NL(A_D_V_O_Date_First_Seen_))),COUNT(__d17(__NN(A_D_V_O_Date_First_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateLastSeen',COUNT(__d17(__NL(A_D_V_O_Date_Last_Seen_))),COUNT(__d17(__NN(A_D_V_O_Date_Last_Seen_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorFirstReported',COUNT(__d17(__NL(A_D_V_O_Date_Vendor_First_Reported_))),COUNT(__d17(__NN(A_D_V_O_Date_Vendor_First_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ADVODateVendorLastReported',COUNT(__d17(__NL(A_D_V_O_Date_Vendor_Last_Reported_))),COUNT(__d17(__NN(A_D_V_O_Date_Vendor_Last_Reported_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacancyIndicator',COUNT(__d17(__NL(Vacancy_Indicator_))),COUNT(__d17(__NN(Vacancy_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThrowBackIndicator',COUNT(__d17(__NL(Throw_Back_Indicator_))),COUNT(__d17(__NN(Throw_Back_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalDeliveryIndicator',COUNT(__d17(__NL(Seasonal_Delivery_Indicator_))),COUNT(__d17(__NN(Seasonal_Delivery_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalStartSuppressionDate',COUNT(__d17(__NL(Seasonal_Start_Suppression_Date_))),COUNT(__d17(__NN(Seasonal_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeasonalEndSuppressionDate',COUNT(__d17(__NL(Seasonal_End_Suppression_Date_))),COUNT(__d17(__NN(Seasonal_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotDeliverIndicator',COUNT(__d17(__NL(Do_Not_Deliver_Indicator_))),COUNT(__d17(__NN(Do_Not_Deliver_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DoNotMailIndicator',COUNT(__d17(__NL(Do_Not_Mail_Indicator_))),COUNT(__d17(__NN(Do_Not_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeadCOIndicator',COUNT(__d17(__NL(Dead_C_O_Indicator_))),COUNT(__d17(__NN(Dead_C_O_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HotListIndicator',COUNT(__d17(__NL(Hot_List_Indicator_))),COUNT(__d17(__NN(Hot_List_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeIndicator',COUNT(__d17(__NL(College_Indicator_))),COUNT(__d17(__NN(College_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeStartSuppressionDate',COUNT(__d17(__NL(College_Start_Suppression_Date_))),COUNT(__d17(__NN(College_Start_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeEndSuppressionDate',COUNT(__d17(__NL(College_End_Suppression_Date_))),COUNT(__d17(__NN(College_End_Suppression_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StyleCode',COUNT(__d17(__NL(Style_Code_))),COUNT(__d17(__NN(Style_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SimplifyCount',COUNT(__d17(__NL(Simplify_Count_))),COUNT(__d17(__NN(Simplify_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DropIndicator',COUNT(__d17(__NL(Drop_Indicator_))),COUNT(__d17(__NN(Drop_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ResidentialOrBusinessIndicator',COUNT(__d17(__NL(Residential_Or_Business_Indicator_))),COUNT(__d17(__NN(Residential_Or_Business_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OnlyWayToGetMailIndicator',COUNT(__d17(__NL(Only_Way_To_Get_Mail_Indicator_))),COUNT(__d17(__NN(Only_Way_To_Get_Mail_Indicator_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordTypeCode',COUNT(__d17(__NL(Record_Type_Code_))),COUNT(__d17(__NN(Record_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeCode',COUNT(__d17(__NL(Address_Type_Code_))),COUNT(__d17(__NN(Address_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MixedUsageCode',COUNT(__d17(__NL(Mixed_Usage_Code_))),COUNT(__d17(__NN(Mixed_Usage_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationBeginDate',COUNT(__d17(__NL(Vacation_Begin_Date_))),COUNT(__d17(__NN(Vacation_Begin_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationEndDate',COUNT(__d17(__NL(Vacation_End_Date_))),COUNT(__d17(__NN(Vacation_End_Date_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NumberOfCurrentVacationMonths',COUNT(__d17(__NL(Number_Of_Current_Vacation_Months_))),COUNT(__d17(__NN(Number_Of_Current_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaxVacationMonths',COUNT(__d17(__NL(Max_Vacation_Months_))),COUNT(__d17(__NN(Max_Vacation_Months_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VacationPeriodsCount',COUNT(__d17(__NL(Vacation_Periods_Count_))),COUNT(__d17(__NN(Vacation_Periods_Count_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeRaw',COUNT(__d17(__NL(Company_Address_Type_Raw_))),COUNT(__d17(__NN(Company_Address_Type_Raw_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompanyAddressTypeDerived',COUNT(__d17(__NL(Company_Address_Type_Derived_))),COUNT(__d17(__NN(Company_Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressTypeDerived',COUNT(__d17(__NL(Address_Type_Derived_))),COUNT(__d17(__NN(Address_Type_Derived_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressMethod',COUNT(__d17(__NL(Address_Method_))),COUNT(__d17(__NN(Address_Method_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d17(__NL(Is_Active_))),COUNT(__d17(__NN(Is_Active_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsDefunct',COUNT(__d17(__NL(Is_Defunct_))),COUNT(__d17(__NN(Is_Defunct_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Type',COUNT(__d17(__NL(Address___Type_))),COUNT(__d17(__NN(Address___Type_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Address_Desc',COUNT(__d17(__NL(Address___Desc_))),COUNT(__d17(__NN(Address___Desc_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d17(__NL(Source_))),COUNT(__d17(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d17(Date_First_Seen_=0)),COUNT(__d17(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d17(Date_Last_Seen_=0)),COUNT(__d17(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
