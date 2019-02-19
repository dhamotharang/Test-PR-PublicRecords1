//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT KELOtto;
IMPORT E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT E_Address := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Source_Customer_;
    KEL.typ.nbool _addresspobox_;
    KEL.typ.nbool _addresscmra_;
    KEL.typ.nint Otto_Address_Id_;
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
    KEL.typ.nstr Zip_;
    KEL.typ.nstr Zip4_;
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
    KEL.typ.nbool _is_Additional_;
    KEL.typ.nstr Hri_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),addresspobox(_addresspobox_),addresscmra(_addresscmra_),ottoaddressid(Otto_Address_Id_:0),primaryrange(Primary_Range_),predirectional(Predirectional_),primaryname(Primary_Name_),suffix(Suffix_),postdirectional(Postdirectional_),unitdesignation(Unit_Designation_),secondaryrange(Secondary_Range_),postalcity(Postal_City_),vanitycity(Vanity_City_),state(State_),zip(Zip_),zip4(Zip4_),carrierroutenumber(Carrier_Route_Number_),carrierroutesortationatzip(Carrier_Route_Sortation_At_Z_I_P_),lineoftravel(Line_Of_Travel_),lineoftravelorder(Line_Of_Travel_Order_),deliverypointbarcode(Delivery_Point_Barcode_),deliverypointbarcodecheckdigit(Delivery_Point_Barcode_Check_Digit_),typecode(Type_Code_),county(County_),latitude(Latitude_),longitude(Longitude_),metropolitanstatisticalarea(Metropolitan_Statistical_Area_),geoblock(Geo_Block_),geomatch(Geo_Match_),acecleanererrorcode(A_C_E_Cleaner_Error_Code_),isadditional(_is_Additional_),hri(Hri_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := KELOtto.fraudgovshared((STRING10)clean_address.prim_range <> '' AND (STRING28)clean_address.prim_name <> '' AND (UNSIGNED3)clean_address.zip <> 0);
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.clean_address.prim_range) + '|' + TRIM((STRING)LEFT.clean_address.predir) + '|' + TRIM((STRING)LEFT.clean_address.prim_name) + '|' + TRIM((STRING)LEFT.clean_address.addr_suffix) + '|' + TRIM((STRING)LEFT.clean_address.postdir) + '|' + TRIM((STRING)LEFT.clean_address.zip) + '|' + TRIM((STRING)LEFT.clean_address.sec_range)));
  EXPORT __All_Trim := __d0_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  SHARED __Table := TABLE(__All_Trim,__TabRec,KeyVal,MERGE);
  EXPORT Lookup := PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::KELOtto::Address::UidLookup',EXPIRE(30));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::KELOtto::Address');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::KELOtto::Address');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED __Mapping0 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),addresspobox(_addresspobox_),addresscmra(_addresscmra_),ottoaddressid(Otto_Address_Id_:0),clean_address.prim_range(Primary_Range_),clean_address.predir(Predirectional_),clean_address.prim_name(Primary_Name_),clean_address.addr_suffix(Suffix_),clean_address.postdir(Postdirectional_),clean_address.unit_desig(Unit_Designation_),clean_address.sec_range(Secondary_Range_),clean_address.p_city_name(Postal_City_),clean_address.v_city_name(Vanity_City_),clean_address.st(State_),clean_address.zip(Zip_),clean_address.zip4(Zip4_),clean_address.cart(Carrier_Route_Number_),clean_address.cr_sort_sz(Carrier_Route_Sortation_At_Z_I_P_),clean_address.lot(Line_Of_Travel_),clean_address.lot_order(Line_Of_Travel_Order_),clean_address.dbpc(Delivery_Point_Barcode_),clean_address.chk_digit(Delivery_Point_Barcode_Check_Digit_),clean_address.rec_type(Type_Code_),clean_address.fips_county(County_),clean_address.geo_lat(Latitude_),clean_address.geo_long(Longitude_),clean_address.msa(Metropolitan_Statistical_Area_),clean_address.geo_blk(Geo_Block_),clean_address.geo_match(Geo_Match_),clean_address.err_stat(A_C_E_Cleaner_Error_Code_),hri(Hri_:\'\'),dt_first_seen(Date_First_Seen_:EPOCH),dt_last_seen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF._is_Additional_ := __CN(FALSE);
    SELF := __r;
  END;
  SHARED __d0_Out := RECORD
    RECORDOF(KELOtto.fraudgovshared);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.clean_address.prim_range) + '|' + TRIM((STRING)LEFT.clean_address.predir) + '|' + TRIM((STRING)LEFT.clean_address.prim_name) + '|' + TRIM((STRING)LEFT.clean_address.addr_suffix) + '|' + TRIM((STRING)LEFT.clean_address.postdir) + '|' + TRIM((STRING)LEFT.clean_address.zip) + '|' + TRIM((STRING)LEFT.clean_address.sec_range) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT KELOtto_fraudgovshared_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0),__Mapping0_Transform(LEFT)));
  EXPORT InData := __d0;
  EXPORT Source_Customers_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Source_Customer_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Hri_List_Layout := RECORD
    KEL.typ.nstr Hri_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(Source_Customers_Layout) Source_Customers_;
    KEL.typ.nbool _addresspobox_;
    KEL.typ.nbool _addresscmra_;
    KEL.typ.nint Otto_Address_Id_;
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
    KEL.typ.nstr Zip_;
    KEL.typ.nstr Zip4_;
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
    KEL.typ.nbool _is_Additional_;
    KEL.typ.ndataset(Hri_List_Layout) Hri_List_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Address_Group := __PostFilter;
  Layout Address__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF._r_Customer_ := KEL.Intake.SingleValue(__recs,_r_Customer_);
    SELF.Source_Customers_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Source_Customer_},_r_Source_Customer_),Source_Customers_Layout)(__NN(_r_Source_Customer_)));
    SELF._addresspobox_ := KEL.Intake.SingleValue(__recs,_addresspobox_);
    SELF._addresscmra_ := KEL.Intake.SingleValue(__recs,_addresscmra_);
    SELF.Otto_Address_Id_ := KEL.Intake.SingleValue(__recs,Otto_Address_Id_);
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
    SELF.Zip_ := KEL.Intake.SingleValue(__recs,Zip_);
    SELF.Zip4_ := KEL.Intake.SingleValue(__recs,Zip4_);
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
    SELF._is_Additional_ := KEL.Intake.SingleValue(__recs,_is_Additional_);
    SELF.Hri_List_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Hri_},Hri_),Hri_List_Layout)(__NN(Hri_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Address__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Source_Customers_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Source_Customers_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(_r_Source_Customer_)));
    SELF.Hri_List_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Hri_List_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Hri_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Address_Group,COUNT(ROWS(LEFT))=1),GROUP,Address__Single_Rollup(LEFT)) + ROLLUP(HAVING(Address_Group,COUNT(ROWS(LEFT))>1),GROUP,Address__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KELOtto::Address::Result',EXPIRE(30));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT _r_Customer__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_r_Customer_);
  EXPORT _addresspobox__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_addresspobox_);
  EXPORT _addresscmra__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_addresscmra_);
  EXPORT Otto_Address_Id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Otto_Address_Id_);
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
  EXPORT Zip__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Zip_);
  EXPORT Zip4__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Zip4_);
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
  EXPORT _is_Additional__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_is_Additional_);
  EXPORT _r_Customer__Orphan := JOIN(InData(__NN(_r_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT _r_Source_Customer__Orphan := JOIN(InData(__NN(_r_Source_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Source_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(_r_Customer__Orphan),COUNT(_r_Source_Customer__Orphan),COUNT(KELOtto_fraudgovshared_Invalid),COUNT(_r_Customer__SingleValue_Invalid),COUNT(_addresspobox__SingleValue_Invalid),COUNT(_addresscmra__SingleValue_Invalid),COUNT(Otto_Address_Id__SingleValue_Invalid),COUNT(Primary_Range__SingleValue_Invalid),COUNT(Predirectional__SingleValue_Invalid),COUNT(Primary_Name__SingleValue_Invalid),COUNT(Suffix__SingleValue_Invalid),COUNT(Postdirectional__SingleValue_Invalid),COUNT(Unit_Designation__SingleValue_Invalid),COUNT(Secondary_Range__SingleValue_Invalid),COUNT(Postal_City__SingleValue_Invalid),COUNT(Vanity_City__SingleValue_Invalid),COUNT(State__SingleValue_Invalid),COUNT(Zip__SingleValue_Invalid),COUNT(Zip4__SingleValue_Invalid),COUNT(Carrier_Route_Number__SingleValue_Invalid),COUNT(Carrier_Route_Sortation_At_Z_I_P__SingleValue_Invalid),COUNT(Line_Of_Travel__SingleValue_Invalid),COUNT(Line_Of_Travel_Order__SingleValue_Invalid),COUNT(Delivery_Point_Barcode__SingleValue_Invalid),COUNT(Delivery_Point_Barcode_Check_Digit__SingleValue_Invalid),COUNT(Type_Code__SingleValue_Invalid),COUNT(County__SingleValue_Invalid),COUNT(Latitude__SingleValue_Invalid),COUNT(Longitude__SingleValue_Invalid),COUNT(Metropolitan_Statistical_Area__SingleValue_Invalid),COUNT(Geo_Block__SingleValue_Invalid),COUNT(Geo_Match__SingleValue_Invalid),COUNT(A_C_E_Cleaner_Error_Code__SingleValue_Invalid),COUNT(_is_Additional__SingleValue_Invalid)}],{KEL.typ.int _r_Customer__Orphan,KEL.typ.int _r_Source_Customer__Orphan,KEL.typ.int KELOtto_fraudgovshared_Invalid,KEL.typ.int _r_Customer__SingleValue_Invalid,KEL.typ.int _addresspobox__SingleValue_Invalid,KEL.typ.int _addresscmra__SingleValue_Invalid,KEL.typ.int Otto_Address_Id__SingleValue_Invalid,KEL.typ.int Primary_Range__SingleValue_Invalid,KEL.typ.int Predirectional__SingleValue_Invalid,KEL.typ.int Primary_Name__SingleValue_Invalid,KEL.typ.int Suffix__SingleValue_Invalid,KEL.typ.int Postdirectional__SingleValue_Invalid,KEL.typ.int Unit_Designation__SingleValue_Invalid,KEL.typ.int Secondary_Range__SingleValue_Invalid,KEL.typ.int Postal_City__SingleValue_Invalid,KEL.typ.int Vanity_City__SingleValue_Invalid,KEL.typ.int State__SingleValue_Invalid,KEL.typ.int Zip__SingleValue_Invalid,KEL.typ.int Zip4__SingleValue_Invalid,KEL.typ.int Carrier_Route_Number__SingleValue_Invalid,KEL.typ.int Carrier_Route_Sortation_At_Z_I_P__SingleValue_Invalid,KEL.typ.int Line_Of_Travel__SingleValue_Invalid,KEL.typ.int Line_Of_Travel_Order__SingleValue_Invalid,KEL.typ.int Delivery_Point_Barcode__SingleValue_Invalid,KEL.typ.int Delivery_Point_Barcode_Check_Digit__SingleValue_Invalid,KEL.typ.int Type_Code__SingleValue_Invalid,KEL.typ.int County__SingleValue_Invalid,KEL.typ.int Latitude__SingleValue_Invalid,KEL.typ.int Longitude__SingleValue_Invalid,KEL.typ.int Metropolitan_Statistical_Area__SingleValue_Invalid,KEL.typ.int Geo_Block__SingleValue_Invalid,KEL.typ.int Geo_Match__SingleValue_Invalid,KEL.typ.int A_C_E_Cleaner_Error_Code__SingleValue_Invalid,KEL.typ.int _is_Additional__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Address','KELOtto.fraudgovshared','UID',COUNT(KELOtto_fraudgovshared_Invalid),COUNT(__d0)},
    {'Address','KELOtto.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d0(__NL(_r_Customer_))),COUNT(__d0(__NN(_r_Customer_)))},
    {'Address','KELOtto.fraudgovshared','SourceCustomerFileInfo',COUNT(__d0(__NL(_r_Source_Customer_))),COUNT(__d0(__NN(_r_Source_Customer_)))},
    {'Address','KELOtto.fraudgovshared','addresspobox',COUNT(__d0(__NL(_addresspobox_))),COUNT(__d0(__NN(_addresspobox_)))},
    {'Address','KELOtto.fraudgovshared','addresscmra',COUNT(__d0(__NL(_addresscmra_))),COUNT(__d0(__NN(_addresscmra_)))},
    {'Address','KELOtto.fraudgovshared','OttoAddressId',COUNT(__d0(__NL(Otto_Address_Id_))),COUNT(__d0(__NN(Otto_Address_Id_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.prim_range',COUNT(__d0(__NL(Primary_Range_))),COUNT(__d0(__NN(Primary_Range_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.predir',COUNT(__d0(__NL(Predirectional_))),COUNT(__d0(__NN(Predirectional_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.prim_name',COUNT(__d0(__NL(Primary_Name_))),COUNT(__d0(__NN(Primary_Name_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.addr_suffix',COUNT(__d0(__NL(Suffix_))),COUNT(__d0(__NN(Suffix_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.postdir',COUNT(__d0(__NL(Postdirectional_))),COUNT(__d0(__NN(Postdirectional_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.unit_desig',COUNT(__d0(__NL(Unit_Designation_))),COUNT(__d0(__NN(Unit_Designation_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.sec_range',COUNT(__d0(__NL(Secondary_Range_))),COUNT(__d0(__NN(Secondary_Range_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.p_city_name',COUNT(__d0(__NL(Postal_City_))),COUNT(__d0(__NN(Postal_City_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.v_city_name',COUNT(__d0(__NL(Vanity_City_))),COUNT(__d0(__NN(Vanity_City_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.st',COUNT(__d0(__NL(State_))),COUNT(__d0(__NN(State_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.zip',COUNT(__d0(__NL(Zip_))),COUNT(__d0(__NN(Zip_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.zip4',COUNT(__d0(__NL(Zip4_))),COUNT(__d0(__NN(Zip4_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.cart',COUNT(__d0(__NL(Carrier_Route_Number_))),COUNT(__d0(__NN(Carrier_Route_Number_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.cr_sort_sz',COUNT(__d0(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d0(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.lot',COUNT(__d0(__NL(Line_Of_Travel_))),COUNT(__d0(__NN(Line_Of_Travel_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.lot_order',COUNT(__d0(__NL(Line_Of_Travel_Order_))),COUNT(__d0(__NN(Line_Of_Travel_Order_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.dbpc',COUNT(__d0(__NL(Delivery_Point_Barcode_))),COUNT(__d0(__NN(Delivery_Point_Barcode_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.chk_digit',COUNT(__d0(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d0(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.rec_type',COUNT(__d0(__NL(Type_Code_))),COUNT(__d0(__NN(Type_Code_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.fips_county',COUNT(__d0(__NL(County_))),COUNT(__d0(__NN(County_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.geo_lat',COUNT(__d0(__NL(Latitude_))),COUNT(__d0(__NN(Latitude_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.geo_long',COUNT(__d0(__NL(Longitude_))),COUNT(__d0(__NN(Longitude_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.msa',COUNT(__d0(__NL(Metropolitan_Statistical_Area_))),COUNT(__d0(__NN(Metropolitan_Statistical_Area_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.geo_blk',COUNT(__d0(__NL(Geo_Block_))),COUNT(__d0(__NN(Geo_Block_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.geo_match',COUNT(__d0(__NL(Geo_Match_))),COUNT(__d0(__NN(Geo_Match_)))},
    {'Address','KELOtto.fraudgovshared','clean_address.err_stat',COUNT(__d0(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d0(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Address','KELOtto.fraudgovshared','Hri',COUNT(__d0(__NL(Hri_))),COUNT(__d0(__NN(Hri_)))},
    {'Address','KELOtto.fraudgovshared','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Address','KELOtto.fraudgovshared','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
