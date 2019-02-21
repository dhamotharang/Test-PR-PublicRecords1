//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
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
    KEL.typ.nstr Institution_Type_Code_;
    KEL.typ.nstr Institution_Type_Expanded_;
    KEL.typ.nstr Institution_Name_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),primaryrange(Primary_Range_),predirectional(Predirectional_),primaryname(Primary_Name_),suffix(Suffix_),postdirectional(Postdirectional_),unitdesignation(Unit_Designation_),secondaryrange(Secondary_Range_),postalcity(Postal_City_),vanitycity(Vanity_City_),state(State_),zip5(Z_I_P5_:0),zip4(Z_I_P4_),carrierroutenumber(Carrier_Route_Number_),carrierroutesortationatzip(Carrier_Route_Sortation_At_Z_I_P_),lineoftravel(Line_Of_Travel_),lineoftravelorder(Line_Of_Travel_Order_),deliverypointbarcode(Delivery_Point_Barcode_),deliverypointbarcodecheckdigit(Delivery_Point_Barcode_Check_Digit_),typecode(Type_Code_),county(County_),latitude(Latitude_),longitude(Longitude_),metropolitanstatisticalarea(Metropolitan_Statistical_Area_),geoblock(Geo_Block_),geomatch(Geo_Match_),acecleanererrorcode(A_C_E_Cleaner_Error_Code_),advodatefirstseen(A_D_V_O_Date_First_Seen_:DATE),advodatelastseen(A_D_V_O_Date_Last_Seen_:DATE),advodatevendorfirstreported(A_D_V_O_Date_Vendor_First_Reported_:DATE),advodatevendorlastreported(A_D_V_O_Date_Vendor_Last_Reported_:DATE),vacancyindicator(Vacancy_Indicator_),throwbackindicator(Throw_Back_Indicator_),seasonaldeliveryindicator(Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(Seasonal_End_Suppression_Date_),donotdeliverindicator(Do_Not_Deliver_Indicator_),collegeindicator(College_Indicator_),collegestartsuppressiondate(College_Start_Suppression_Date_),collegeendsuppressiondate(College_End_Suppression_Date_),stylecode(Style_Code_),simplifycount(Simplify_Count_),dropindicator(Drop_Indicator_),residentialorbusinessindicator(Residential_Or_Business_Indicator_),onlywaytogetmailindicator(Only_Way_To_Get_Mail_Indicator_),recordtypecode(Record_Type_Code_),addresstypecode(Address_Type_Code_),mixedusagecode(Mixed_Usage_Code_),vacationbegindate(Vacation_Begin_Date_:DATE),vacationenddate(Vacation_End_Date_:DATE),numberofcurrentvacationmonths(Number_Of_Current_Vacation_Months_),maxvacationmonths(Max_Vacation_Months_),vacationperiodscount(Vacation_Periods_Count_),institutiontypecode(Institution_Type_Code_),institutiontypeexpanded(Institution_Type_Expanded_),institutionname(Institution_Name_),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := __in.Dataset_Doxie__Key_Header((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0);
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  SHARED __d1_KELfiltered := __in.Dataset_Header_Quick__Key_Did((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip != 0);
  SHARED __d1_Trim := PROJECT(__d1_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range)));
  SHARED __d2_KELfiltered := __in.Dataset_Doxie_Files__Key_Offenders((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED3)zip5 != 0);
  SHARED __d2_Trim := PROJECT(__d2_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip5) + '|' + TRIM((STRING)LEFT.sec_range)));
  SHARED __d3_KELfiltered := __in.Dataset_Doxie_Files__Key_Offenders((STRING10)prim_range != '' AND (STRING28)prim_name != '' AND (UNSIGNED)zip5 != 0);
  SHARED __d3_Trim := PROJECT(__d3_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip5) + '|' + TRIM((STRING)LEFT.sec_range)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim + __d2_Trim + __d3_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  SHARED __Table := TABLE(__All_Trim,__TabRec,KeyVal,MERGE);
  EXPORT Lookup := PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::PublicRecords_KEL::Address::UidLookup',EXPIRE(7));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::PublicRecords_KEL::Address');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::PublicRecords_KEL::Address');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED A_D_V_O_Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED A_D_V_O_Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED A_D_V_O_Date_Vendor_First_Reported_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED A_D_V_O_Date_Vendor_Last_Reported_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'UID(UID),prim_range(Primary_Range_),predir(Predirectional_),prim_name(Primary_Name_),suffix(Suffix_),postdir(Postdirectional_),unit_desig(Unit_Designation_),sec_range(Secondary_Range_),postalcity(Postal_City_),vanitycity(Vanity_City_),st(State_),zip(Z_I_P5_:0),zip4(Z_I_P4_),carrierroutenumber(Carrier_Route_Number_),carrierroutesortationatzip(Carrier_Route_Sortation_At_Z_I_P_),lineoftravel(Line_Of_Travel_),lineoftravelorder(Line_Of_Travel_Order_),deliverypointbarcode(Delivery_Point_Barcode_),deliverypointbarcodecheckdigit(Delivery_Point_Barcode_Check_Digit_),typecode(Type_Code_),county(County_),latitude(Latitude_),longitude(Longitude_),metropolitanstatisticalarea(Metropolitan_Statistical_Area_),geo_blk(Geo_Block_),geomatch(Geo_Match_),acecleanererrorcode(A_C_E_Cleaner_Error_Code_),dt_first_seen(A_D_V_O_Date_First_Seen_:DATE:A_D_V_O_Date_First_Seen_0Rule|Date_First_Seen_:EPOCH:Date_First_Seen_0Rule),dt_last_seen(A_D_V_O_Date_Last_Seen_:DATE:A_D_V_O_Date_Last_Seen_0Rule|Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),dt_vendor_first_reported(A_D_V_O_Date_Vendor_First_Reported_:DATE:A_D_V_O_Date_Vendor_First_Reported_0Rule),dt_vendor_last_reported(A_D_V_O_Date_Vendor_Last_Reported_:DATE:A_D_V_O_Date_Vendor_Last_Reported_0Rule),vacancyindicator(Vacancy_Indicator_),throwbackindicator(Throw_Back_Indicator_),seasonaldeliveryindicator(Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(Seasonal_End_Suppression_Date_),donotdeliverindicator(Do_Not_Deliver_Indicator_),collegeindicator(College_Indicator_),collegestartsuppressiondate(College_Start_Suppression_Date_),collegeendsuppressiondate(College_End_Suppression_Date_),stylecode(Style_Code_),simplifycount(Simplify_Count_),dropindicator(Drop_Indicator_),residentialorbusinessindicator(Residential_Or_Business_Indicator_),onlywaytogetmailindicator(Only_Way_To_Get_Mail_Indicator_),rec_type(Record_Type_Code_),addresstypecode(Address_Type_Code_),mixedusagecode(Mixed_Usage_Code_),vacationbegindate(Vacation_Begin_Date_:DATE),vacationenddate(Vacation_End_Date_:DATE),numberofcurrentvacationmonths(Number_Of_Current_Vacation_Months_),maxvacationmonths(Max_Vacation_Months_),vacationperiodscount(Vacation_Periods_Count_),institutiontypecode(Institution_Type_Code_),institutiontypeexpanded(Institution_Type_Expanded_),institutionname(Institution_Name_),src(Source_:\'\')';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Header,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Header),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Doxie__Key_Header);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  SHARED A_D_V_O_Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED A_D_V_O_Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED A_D_V_O_Date_Vendor_First_Reported_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED A_D_V_O_Date_Vendor_Last_Reported_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'UID(UID),prim_range(Primary_Range_),predir(Predirectional_),prim_name(Primary_Name_),suffix(Suffix_),postdir(Postdirectional_),unit_desig(Unit_Designation_),sec_range(Secondary_Range_),postalcity(Postal_City_),vanitycity(Vanity_City_),st(State_),zip(Z_I_P5_:0),zip4(Z_I_P4_),carrierroutenumber(Carrier_Route_Number_),carrierroutesortationatzip(Carrier_Route_Sortation_At_Z_I_P_),lineoftravel(Line_Of_Travel_),lineoftravelorder(Line_Of_Travel_Order_),deliverypointbarcode(Delivery_Point_Barcode_),deliverypointbarcodecheckdigit(Delivery_Point_Barcode_Check_Digit_),typecode(Type_Code_),county(County_),latitude(Latitude_),longitude(Longitude_),metropolitanstatisticalarea(Metropolitan_Statistical_Area_),geo_blk(Geo_Block_),geomatch(Geo_Match_),acecleanererrorcode(A_C_E_Cleaner_Error_Code_),dt_first_seen(A_D_V_O_Date_First_Seen_:DATE:A_D_V_O_Date_First_Seen_1Rule|Date_First_Seen_:EPOCH:Date_First_Seen_1Rule),dt_last_seen(A_D_V_O_Date_Last_Seen_:DATE:A_D_V_O_Date_Last_Seen_1Rule|Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),dt_vendor_first_reported(A_D_V_O_Date_Vendor_First_Reported_:DATE:A_D_V_O_Date_Vendor_First_Reported_1Rule),dt_vendor_last_reported(A_D_V_O_Date_Vendor_Last_Reported_:DATE:A_D_V_O_Date_Vendor_Last_Reported_1Rule),vacancyindicator(Vacancy_Indicator_),throwbackindicator(Throw_Back_Indicator_),seasonaldeliveryindicator(Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(Seasonal_End_Suppression_Date_),donotdeliverindicator(Do_Not_Deliver_Indicator_),collegeindicator(College_Indicator_),collegestartsuppressiondate(College_Start_Suppression_Date_),collegeendsuppressiondate(College_End_Suppression_Date_),stylecode(Style_Code_),simplifycount(Simplify_Count_),dropindicator(Drop_Indicator_),residentialorbusinessindicator(Residential_Or_Business_Indicator_),onlywaytogetmailindicator(Only_Way_To_Get_Mail_Indicator_),rec_type(Record_Type_Code_),addresstypecode(Address_Type_Code_),mixedusagecode(Mixed_Usage_Code_),vacationbegindate(Vacation_Begin_Date_:DATE),vacationenddate(Vacation_End_Date_:DATE),numberofcurrentvacationmonths(Number_Of_Current_Vacation_Months_),maxvacationmonths(Max_Vacation_Months_),vacationperiodscount(Vacation_Periods_Count_),institutiontypecode(Institution_Type_Code_),institutiontypeexpanded(Institution_Type_Expanded_),institutionname(Institution_Name_),src(Source_:\'\')';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Header_Quick__Key_Did,TRANSFORM(RECORDOF(__in.Dataset_Header_Quick__Key_Did),SELF:=RIGHT));
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Header_Quick__Key_Did);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1));
  SHARED __Mapping2 := 'UID(UID),prim_range(Primary_Range_),predir(Predirectional_),prim_name(Primary_Name_),addr_suffix(Suffix_),postdir(Postdirectional_),unit_desig(Unit_Designation_),sec_range(Secondary_Range_),p_city_name(Postal_City_),v_city_name(Vanity_City_),st(State_),zip5(Z_I_P5_:0),zip4(Z_I_P4_),cart(Carrier_Route_Number_),cr_sort_sz(Carrier_Route_Sortation_At_Z_I_P_),lot(Line_Of_Travel_),lot_order(Line_Of_Travel_Order_),dpbc(Delivery_Point_Barcode_),chk_digit(Delivery_Point_Barcode_Check_Digit_),rec_type(Type_Code_),ace_fips_county(County_),geo_lat(Latitude_),geo_long(Longitude_),msa(Metropolitan_Statistical_Area_),geo_blk(Geo_Block_),geo_match(Geo_Match_),err_stat(A_C_E_Cleaner_Error_Code_),advodatefirstseen(A_D_V_O_Date_First_Seen_:DATE),advodatelastseen(A_D_V_O_Date_Last_Seen_:DATE),advodatevendorfirstreported(A_D_V_O_Date_Vendor_First_Reported_:DATE),advodatevendorlastreported(A_D_V_O_Date_Vendor_Last_Reported_:DATE),vacancyindicator(Vacancy_Indicator_),throwbackindicator(Throw_Back_Indicator_),seasonaldeliveryindicator(Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(Seasonal_End_Suppression_Date_),donotdeliverindicator(Do_Not_Deliver_Indicator_),collegeindicator(College_Indicator_),collegestartsuppressiondate(College_Start_Suppression_Date_),collegeendsuppressiondate(College_End_Suppression_Date_),stylecode(Style_Code_),simplifycount(Simplify_Count_),dropindicator(Drop_Indicator_),residentialorbusinessindicator(Residential_Or_Business_Indicator_),onlywaytogetmailindicator(Only_Way_To_Get_Mail_Indicator_),recordtypecode(Record_Type_Code_),addresstypecode(Address_Type_Code_),mixedusagecode(Mixed_Usage_Code_),vacationbegindate(Vacation_Begin_Date_:DATE),vacationenddate(Vacation_End_Date_:DATE),numberofcurrentvacationmonths(Number_Of_Current_Vacation_Months_),maxvacationmonths(Max_Vacation_Months_),vacationperiodscount(Vacation_Periods_Count_),institutiontypecode(Institution_Type_Code_),institutiontypeexpanded(Institution_Type_Expanded_),institutionname(Institution_Name_),src(Source_:\'\'),fcra_date(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping2_Transform(InLayout __r) := TRANSFORM
    SELF.__Permits := CFG_Compile.Permit_FCRA;
    SELF := __r;
  END;
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders),SELF:=RIGHT));
  SHARED __d2_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Doxie_Files__Key_Offenders);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d2_UID_Mapped := JOIN(__d2_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip5) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d2_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_1_Invalid := __d2_UID_Mapped(UID = 0);
  SHARED __d2_Prefiltered := __d2_UID_Mapped(UID <> 0);
  SHARED __d2 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2),__Mapping2_Transform(LEFT)));
  SHARED __Mapping3 := 'UID(UID),prim_range(Primary_Range_),predir(Predirectional_),prim_name(Primary_Name_),addr_suffix(Suffix_),postdir(Postdirectional_),unit_desig(Unit_Designation_),sec_range(Secondary_Range_),p_city_name(Postal_City_),v_city_name(Vanity_City_),st(State_),zip5(Z_I_P5_:0),zip4(Z_I_P4_),cart(Carrier_Route_Number_),cr_sort_sz(Carrier_Route_Sortation_At_Z_I_P_),lot(Line_Of_Travel_),lot_order(Line_Of_Travel_Order_),dpbc(Delivery_Point_Barcode_),chk_digit(Delivery_Point_Barcode_Check_Digit_),rec_type(Type_Code_),ace_fips_county(County_),geo_lat(Latitude_),geo_long(Longitude_),msa(Metropolitan_Statistical_Area_),geo_blk(Geo_Block_),geo_match(Geo_Match_),err_stat(A_C_E_Cleaner_Error_Code_),advodatefirstseen(A_D_V_O_Date_First_Seen_:DATE),advodatelastseen(A_D_V_O_Date_Last_Seen_:DATE),advodatevendorfirstreported(A_D_V_O_Date_Vendor_First_Reported_:DATE),advodatevendorlastreported(A_D_V_O_Date_Vendor_Last_Reported_:DATE),vacancyindicator(Vacancy_Indicator_),throwbackindicator(Throw_Back_Indicator_),seasonaldeliveryindicator(Seasonal_Delivery_Indicator_),seasonalstartsuppressiondate(Seasonal_Start_Suppression_Date_),seasonalendsuppressiondate(Seasonal_End_Suppression_Date_),donotdeliverindicator(Do_Not_Deliver_Indicator_),collegeindicator(College_Indicator_),collegestartsuppressiondate(College_Start_Suppression_Date_),collegeendsuppressiondate(College_End_Suppression_Date_),stylecode(Style_Code_),simplifycount(Simplify_Count_),dropindicator(Drop_Indicator_),residentialorbusinessindicator(Residential_Or_Business_Indicator_),onlywaytogetmailindicator(Only_Way_To_Get_Mail_Indicator_),recordtypecode(Record_Type_Code_),addresstypecode(Address_Type_Code_),mixedusagecode(Mixed_Usage_Code_),vacationbegindate(Vacation_Begin_Date_:DATE),vacationenddate(Vacation_End_Date_:DATE),numberofcurrentvacationmonths(Number_Of_Current_Vacation_Months_),maxvacationmonths(Max_Vacation_Months_),vacationperiodscount(Vacation_Periods_Count_),institutiontypecode(Institution_Type_Code_),institutiontypeexpanded(Institution_Type_Expanded_),institutionname(Institution_Name_),src(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping3_Transform(InLayout __r) := TRANSFORM
    SELF.__Permits := CFG_Compile.Permit_NonFCRA;
    SELF := __r;
  END;
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders),SELF:=RIGHT));
  SHARED __d3_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Doxie_Files__Key_Offenders);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d3_UID_Mapped := JOIN(__d3_KELfiltered,Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip5) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d3_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_2_Invalid := __d3_UID_Mapped(UID = 0);
  SHARED __d3_Prefiltered := __d3_UID_Mapped(UID <> 0);
  SHARED __d3 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3),__Mapping3_Transform(LEFT)));
  EXPORT InData := __d0 + __d1 + __d2 + __d3;
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
  EXPORT Do_Not_Deliver_Layout := RECORD
    KEL.typ.nstr Do_Not_Deliver_Indicator_;
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
  EXPORT A_C_A_Layout := RECORD
    KEL.typ.nstr Institution_Type_Code_;
    KEL.typ.nstr Institution_Type_Expanded_;
    KEL.typ.nstr Institution_Name_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
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
    KEL.typ.ndataset(Do_Not_Deliver_Layout) Do_Not_Deliver_;
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
    KEL.typ.ndataset(A_C_A_Layout) A_C_A_;
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
    SELF.College_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),College_Indicator_,College_Start_Suppression_Date_,College_End_Suppression_Date_},College_Indicator_,College_Start_Suppression_Date_,College_End_Suppression_Date_),College_Layout)(__NN(College_Indicator_) OR __NN(College_Start_Suppression_Date_) OR __NN(College_End_Suppression_Date_)));
    SELF.A_D_V_O_Date_Summary_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),A_D_V_O_Date_First_Seen_,A_D_V_O_Date_Last_Seen_,A_D_V_O_Date_Vendor_First_Reported_,A_D_V_O_Date_Vendor_Last_Reported_},A_D_V_O_Date_First_Seen_,A_D_V_O_Date_Last_Seen_,A_D_V_O_Date_Vendor_First_Reported_,A_D_V_O_Date_Vendor_Last_Reported_),A_D_V_O_Date_Summary_Layout)(__NN(A_D_V_O_Date_First_Seen_) OR __NN(A_D_V_O_Date_Last_Seen_) OR __NN(A_D_V_O_Date_Vendor_First_Reported_) OR __NN(A_D_V_O_Date_Vendor_Last_Reported_)));
    SELF.Do_Not_Deliver_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Do_Not_Deliver_Indicator_},Do_Not_Deliver_Indicator_),Do_Not_Deliver_Layout)(__NN(Do_Not_Deliver_Indicator_)));
    SELF.Mail_Drop_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Drop_Indicator_},Drop_Indicator_),Mail_Drop_Layout)(__NN(Drop_Indicator_)));
    SELF.Mixed_Usage_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Mixed_Usage_Code_},Mixed_Usage_Code_),Mixed_Usage_Layout)(__NN(Mixed_Usage_Code_)));
    SELF.Only_Way_To_Get_Mail_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Only_Way_To_Get_Mail_Indicator_},Only_Way_To_Get_Mail_Indicator_),Only_Way_To_Get_Mail_Layout)(__NN(Only_Way_To_Get_Mail_Indicator_)));
    SELF.Record_Type_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Record_Type_Code_},Record_Type_Code_),Record_Type_Layout)(__NN(Record_Type_Code_)));
    SELF.Address_Type_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Address_Type_Code_},Address_Type_Code_),Address_Type_Layout)(__NN(Address_Type_Code_)));
    SELF.Residential_Or_Business_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Residential_Or_Business_Indicator_},Residential_Or_Business_Indicator_),Residential_Or_Business_Layout)(__NN(Residential_Or_Business_Indicator_)));
    SELF.Seasonal_Delivery_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Seasonal_Delivery_Indicator_,Seasonal_Start_Suppression_Date_,Seasonal_End_Suppression_Date_},Seasonal_Delivery_Indicator_,Seasonal_Start_Suppression_Date_,Seasonal_End_Suppression_Date_),Seasonal_Delivery_Layout)(__NN(Seasonal_Delivery_Indicator_) OR __NN(Seasonal_Start_Suppression_Date_) OR __NN(Seasonal_End_Suppression_Date_)));
    SELF.Simplify_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Simplify_Count_},Simplify_Count_),Simplify_Layout)(__NN(Simplify_Count_)));
    SELF.Style_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Style_Code_},Style_Code_),Style_Layout)(__NN(Style_Code_)));
    SELF.Throw_Back_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Throw_Back_Indicator_},Throw_Back_Indicator_),Throw_Back_Layout)(__NN(Throw_Back_Indicator_)));
    SELF.Vacancy_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Vacancy_Indicator_},Vacancy_Indicator_),Vacancy_Layout)(__NN(Vacancy_Indicator_)));
    SELF.Vacation_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Number_Of_Current_Vacation_Months_,Max_Vacation_Months_,Vacation_Periods_Count_,Vacation_Begin_Date_,Vacation_End_Date_},Number_Of_Current_Vacation_Months_,Max_Vacation_Months_,Vacation_Periods_Count_,Vacation_Begin_Date_,Vacation_End_Date_),Vacation_Layout)(__NN(Number_Of_Current_Vacation_Months_) OR __NN(Max_Vacation_Months_) OR __NN(Vacation_Periods_Count_) OR __NN(Vacation_Begin_Date_) OR __NN(Vacation_End_Date_)));
    SELF.A_C_A_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Institution_Type_Code_,Institution_Type_Expanded_,Institution_Name_},Institution_Type_Code_,Institution_Type_Expanded_,Institution_Name_),A_C_A_Layout)(__NN(Institution_Type_Code_) OR __NN(Institution_Type_Expanded_) OR __NN(Institution_Name_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Address__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.College_ := __CN(PROJECT(DATASET(__r),TRANSFORM(College_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(College_Indicator_) OR __NN(College_Start_Suppression_Date_) OR __NN(College_End_Suppression_Date_)));
    SELF.A_D_V_O_Date_Summary_ := __CN(PROJECT(DATASET(__r),TRANSFORM(A_D_V_O_Date_Summary_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(A_D_V_O_Date_First_Seen_) OR __NN(A_D_V_O_Date_Last_Seen_) OR __NN(A_D_V_O_Date_Vendor_First_Reported_) OR __NN(A_D_V_O_Date_Vendor_Last_Reported_)));
    SELF.Do_Not_Deliver_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Do_Not_Deliver_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Do_Not_Deliver_Indicator_)));
    SELF.Mail_Drop_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Mail_Drop_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Drop_Indicator_)));
    SELF.Mixed_Usage_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Mixed_Usage_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Mixed_Usage_Code_)));
    SELF.Only_Way_To_Get_Mail_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Only_Way_To_Get_Mail_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Only_Way_To_Get_Mail_Indicator_)));
    SELF.Record_Type_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Record_Type_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Record_Type_Code_)));
    SELF.Address_Type_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Address_Type_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Address_Type_Code_)));
    SELF.Residential_Or_Business_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Residential_Or_Business_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Residential_Or_Business_Indicator_)));
    SELF.Seasonal_Delivery_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Seasonal_Delivery_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Seasonal_Delivery_Indicator_) OR __NN(Seasonal_Start_Suppression_Date_) OR __NN(Seasonal_End_Suppression_Date_)));
    SELF.Simplify_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Simplify_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Simplify_Count_)));
    SELF.Style_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Style_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Style_Code_)));
    SELF.Throw_Back_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Throw_Back_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Throw_Back_Indicator_)));
    SELF.Vacancy_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Vacancy_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Vacancy_Indicator_)));
    SELF.Vacation_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Vacation_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Number_Of_Current_Vacation_Months_) OR __NN(Max_Vacation_Months_) OR __NN(Vacation_Periods_Count_) OR __NN(Vacation_Begin_Date_) OR __NN(Vacation_End_Date_)));
    SELF.A_C_A_ := __CN(PROJECT(DATASET(__r),TRANSFORM(A_C_A_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Institution_Type_Code_) OR __NN(Institution_Type_Expanded_) OR __NN(Institution_Name_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Address_Group,COUNT(ROWS(LEFT))=1),GROUP,Address__Single_Rollup(LEFT)) + ROLLUP(HAVING(Address_Group,COUNT(ROWS(LEFT))>1),GROUP,Address__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::PublicRecords_KEL::Address::Result' + IF(__cfg.PersistId <> '','::' + __cfg.PersistId,''),EXPIRE(7));
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
  EXPORT SanityCheck := DATASET([{COUNT(Z_I_P5__Orphan),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_1_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_2_Invalid),COUNT(Primary_Range__SingleValue_Invalid),COUNT(Predirectional__SingleValue_Invalid),COUNT(Primary_Name__SingleValue_Invalid),COUNT(Suffix__SingleValue_Invalid),COUNT(Postdirectional__SingleValue_Invalid),COUNT(Unit_Designation__SingleValue_Invalid),COUNT(Secondary_Range__SingleValue_Invalid),COUNT(Postal_City__SingleValue_Invalid),COUNT(Vanity_City__SingleValue_Invalid),COUNT(State__SingleValue_Invalid),COUNT(Z_I_P5__SingleValue_Invalid),COUNT(Z_I_P4__SingleValue_Invalid),COUNT(Carrier_Route_Number__SingleValue_Invalid),COUNT(Carrier_Route_Sortation_At_Z_I_P__SingleValue_Invalid),COUNT(Line_Of_Travel__SingleValue_Invalid),COUNT(Line_Of_Travel_Order__SingleValue_Invalid),COUNT(Delivery_Point_Barcode__SingleValue_Invalid),COUNT(Delivery_Point_Barcode_Check_Digit__SingleValue_Invalid),COUNT(Type_Code__SingleValue_Invalid),COUNT(County__SingleValue_Invalid),COUNT(Latitude__SingleValue_Invalid),COUNT(Longitude__SingleValue_Invalid),COUNT(Metropolitan_Statistical_Area__SingleValue_Invalid),COUNT(Geo_Block__SingleValue_Invalid),COUNT(Geo_Match__SingleValue_Invalid),COUNT(A_C_E_Cleaner_Error_Code__SingleValue_Invalid)}],{KEL.typ.int Z_I_P5__Orphan,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_1_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_2_Invalid,KEL.typ.int Primary_Range__SingleValue_Invalid,KEL.typ.int Predirectional__SingleValue_Invalid,KEL.typ.int Primary_Name__SingleValue_Invalid,KEL.typ.int Suffix__SingleValue_Invalid,KEL.typ.int Postdirectional__SingleValue_Invalid,KEL.typ.int Unit_Designation__SingleValue_Invalid,KEL.typ.int Secondary_Range__SingleValue_Invalid,KEL.typ.int Postal_City__SingleValue_Invalid,KEL.typ.int Vanity_City__SingleValue_Invalid,KEL.typ.int State__SingleValue_Invalid,KEL.typ.int Z_I_P5__SingleValue_Invalid,KEL.typ.int Z_I_P4__SingleValue_Invalid,KEL.typ.int Carrier_Route_Number__SingleValue_Invalid,KEL.typ.int Carrier_Route_Sortation_At_Z_I_P__SingleValue_Invalid,KEL.typ.int Line_Of_Travel__SingleValue_Invalid,KEL.typ.int Line_Of_Travel_Order__SingleValue_Invalid,KEL.typ.int Delivery_Point_Barcode__SingleValue_Invalid,KEL.typ.int Delivery_Point_Barcode_Check_Digit__SingleValue_Invalid,KEL.typ.int Type_Code__SingleValue_Invalid,KEL.typ.int County__SingleValue_Invalid,KEL.typ.int Latitude__SingleValue_Invalid,KEL.typ.int Longitude__SingleValue_Invalid,KEL.typ.int Metropolitan_Statistical_Area__SingleValue_Invalid,KEL.typ.int Geo_Block__SingleValue_Invalid,KEL.typ.int Geo_Match__SingleValue_Invalid,KEL.typ.int A_C_E_Cleaner_Error_Code__SingleValue_Invalid});
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
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InstitutionTypeCode',COUNT(__d0(__NL(Institution_Type_Code_))),COUNT(__d0(__NN(Institution_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InstitutionTypeExpanded',COUNT(__d0(__NL(Institution_Type_Expanded_))),COUNT(__d0(__NN(Institution_Type_Expanded_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InstitutionName',COUNT(__d0(__NL(Institution_Name_))),COUNT(__d0(__NN(Institution_Name_)))},
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
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InstitutionTypeCode',COUNT(__d1(__NL(Institution_Type_Code_))),COUNT(__d1(__NN(Institution_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InstitutionTypeExpanded',COUNT(__d1(__NL(Institution_Type_Expanded_))),COUNT(__d1(__NN(Institution_Type_Expanded_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InstitutionName',COUNT(__d1(__NL(Institution_Name_))),COUNT(__d1(__NN(Institution_Name_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_1_Invalid),COUNT(__d2)},
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
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip5',COUNT(__d2(__NL(Z_I_P5_))),COUNT(__d2(__NN(Z_I_P5_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip4',COUNT(__d2(__NL(Z_I_P4_))),COUNT(__d2(__NN(Z_I_P4_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cart',COUNT(__d2(__NL(Carrier_Route_Number_))),COUNT(__d2(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cr_sort_sz',COUNT(__d2(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d2(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lot',COUNT(__d2(__NL(Line_Of_Travel_))),COUNT(__d2(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lot_order',COUNT(__d2(__NL(Line_Of_Travel_Order_))),COUNT(__d2(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dpbc',COUNT(__d2(__NL(Delivery_Point_Barcode_))),COUNT(__d2(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','chk_digit',COUNT(__d2(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d2(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec_type',COUNT(__d2(__NL(Type_Code_))),COUNT(__d2(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ace_fips_county',COUNT(__d2(__NL(County_))),COUNT(__d2(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_lat',COUNT(__d2(__NL(Latitude_))),COUNT(__d2(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_long',COUNT(__d2(__NL(Longitude_))),COUNT(__d2(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','msa',COUNT(__d2(__NL(Metropolitan_Statistical_Area_))),COUNT(__d2(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_blk',COUNT(__d2(__NL(Geo_Block_))),COUNT(__d2(__NN(Geo_Block_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_match',COUNT(__d2(__NL(Geo_Match_))),COUNT(__d2(__NN(Geo_Match_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','err_stat',COUNT(__d2(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d2(__NN(A_C_E_Cleaner_Error_Code_)))},
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
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InstitutionTypeCode',COUNT(__d2(__NL(Institution_Type_Code_))),COUNT(__d2(__NN(Institution_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InstitutionTypeExpanded',COUNT(__d2(__NL(Institution_Type_Expanded_))),COUNT(__d2(__NN(Institution_Type_Expanded_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InstitutionName',COUNT(__d2(__NL(Institution_Name_))),COUNT(__d2(__NN(Institution_Name_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_2_Invalid),COUNT(__d3)},
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
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip5',COUNT(__d3(__NL(Z_I_P5_))),COUNT(__d3(__NN(Z_I_P5_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip4',COUNT(__d3(__NL(Z_I_P4_))),COUNT(__d3(__NN(Z_I_P4_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cart',COUNT(__d3(__NL(Carrier_Route_Number_))),COUNT(__d3(__NN(Carrier_Route_Number_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cr_sort_sz',COUNT(__d3(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d3(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lot',COUNT(__d3(__NL(Line_Of_Travel_))),COUNT(__d3(__NN(Line_Of_Travel_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lot_order',COUNT(__d3(__NL(Line_Of_Travel_Order_))),COUNT(__d3(__NN(Line_Of_Travel_Order_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dpbc',COUNT(__d3(__NL(Delivery_Point_Barcode_))),COUNT(__d3(__NN(Delivery_Point_Barcode_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','chk_digit',COUNT(__d3(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d3(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec_type',COUNT(__d3(__NL(Type_Code_))),COUNT(__d3(__NN(Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ace_fips_county',COUNT(__d3(__NL(County_))),COUNT(__d3(__NN(County_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_lat',COUNT(__d3(__NL(Latitude_))),COUNT(__d3(__NN(Latitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_long',COUNT(__d3(__NL(Longitude_))),COUNT(__d3(__NN(Longitude_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','msa',COUNT(__d3(__NL(Metropolitan_Statistical_Area_))),COUNT(__d3(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_blk',COUNT(__d3(__NL(Geo_Block_))),COUNT(__d3(__NN(Geo_Block_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','geo_match',COUNT(__d3(__NL(Geo_Match_))),COUNT(__d3(__NN(Geo_Match_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','err_stat',COUNT(__d3(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d3(__NN(A_C_E_Cleaner_Error_Code_)))},
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
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InstitutionTypeCode',COUNT(__d3(__NL(Institution_Type_Code_))),COUNT(__d3(__NN(Institution_Type_Code_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InstitutionTypeExpanded',COUNT(__d3(__NL(Institution_Type_Expanded_))),COUNT(__d3(__NN(Institution_Type_Expanded_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InstitutionName',COUNT(__d3(__NL(Institution_Name_))),COUNT(__d3(__NN(Institution_Name_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'Address','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
