﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT FraudgovKEL;
IMPORT E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Event := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Source_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) _r_Ssn_;
    KEL.typ.ntyp(E_Phone.Typ) _r_Phone_;
    KEL.typ.ntyp(E_Email.Typ) _r_Email_;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) _r_Internet_Protocol_;
    KEL.typ.ntyp(E_Bank_Account.Typ) _r_Bank_Account_;
    KEL.typ.ntyp(E_Drivers_License.Typ) _r_Drivers_License_;
    KEL.typ.nint _rin__source_;
    KEL.typ.nint Lex_Id_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nstr Otto_Address_Id_;
    KEL.typ.nstr Otto_Email_Id_;
    KEL.typ.nstr Otto_Ip_Address_Id_;
    KEL.typ.nstr Otto_Drivers_License_Id_;
    KEL.typ.nstr Otto_S_S_N_Id_;
    KEL.typ.nstr Case_Id_;
    KEL.typ.nint Record_Id_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.nstr Event_Type_;
    KEL.typ.nstr Title_;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Middle_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nstr Name_Suffix_;
    KEL.typ.nbool _addresspobox_;
    KEL.typ.nbool _addresscmra_;
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
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr License_State_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr Type_;
    KEL.typ.nkdate Created_On_;
    KEL.typ.nstr Host_;
    KEL.typ.nstr Email_Last_Domain_;
    KEL.typ.nint _isdisposableemail_;
    KEL.typ.nstr Ssn_;
    KEL.typ.nstr Ssn_Formatted_;
    KEL.typ.nstr Routing_Number_;
    KEL.typ.nstr Full_Bankname_;
    KEL.typ.nstr Abbreviated_Bankname_;
    KEL.typ.nstr Fractional_Routingnumber_;
    KEL.typ.nstr Headoffice_Routingnumber_;
    KEL.typ.nstr Headoffice_Branchcodes_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nstr Bank_Hit_;
    KEL.typ.nint Confidence__that__activity__was__deceitful__id_;
    KEL.typ.nint _name__risk__code_;
    KEL.typ.nint _dob__risk__code_;
    KEL.typ.nint _ssn__risk__code_;
    KEL.typ.nint _drivers__license__risk__code_;
    KEL.typ.nint _physical__address__risk__code_;
    KEL.typ.nint _phone__risk__code_;
    KEL.typ.nint _cell__phone__risk__code_;
    KEL.typ.nint _work__phone__risk__code_;
    KEL.typ.nint _bank__account__1__risk__code_;
    KEL.typ.nint _bank__account__2__risk__code_;
    KEL.typ.nint _email__address__risk__code_;
    KEL.typ.nint _ip__address__fraud__code_;
    KEL.typ.nint _business__risk__code_;
    KEL.typ.nint _mailing__address__risk__code_;
    KEL.typ.nint _device__risk__code_;
    KEL.typ.nint _identity__risk__code_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nint _nap__summary_;
    KEL.typ.nint _nas__summary_;
    KEL.typ.nint _cvi_;
    KEL.typ.nint _fp3__stolenidentityindex_;
    KEL.typ.nint _syntheticidentityindex__v3_;
    KEL.typ.nint _manipulatedidentityindex__v3_;
    KEL.typ.nint _socsdobflag_;
    KEL.typ.nint _pwsocsdobflag_;
    KEL.typ.nint _dobmatchlevel_;
    KEL.typ.nint _sourcerisklevel_;
    KEL.typ.nstr _reason1_;
    KEL.typ.nstr _reason2_;
    KEL.typ.nstr _reason3_;
    KEL.typ.nstr _reason4_;
    KEL.typ.nstr _reason5_;
    KEL.typ.nstr _reason6_;
    KEL.typ.nint _socsvalflag_;
    KEL.typ.nint _drlcvalflag_;
    KEL.typ.nint _hphonevalflag_;
    KEL.typ.nbool _truedid_;
    KEL.typ.nstr _best__fname_;
    KEL.typ.nstr _best__lname_;
    KEL.typ.nstr _best__ssn_;
    KEL.typ.nstr _input__fname__isbestmatch_;
    KEL.typ.nstr _input__lname__isbestmatch_;
    KEL.typ.nstr _input__ssn__isbestmatch_;
    KEL.typ.nbool _add__curr__pop_;
    KEL.typ.nstr _add__curr__prim__range_;
    KEL.typ.nstr _add__curr__predir_;
    KEL.typ.nstr _add__curr__prim__name_;
    KEL.typ.nstr _add__curr__addr__suffix_;
    KEL.typ.nstr _add__curr__postdir_;
    KEL.typ.nstr _add__curr__unit__desig_;
    KEL.typ.nstr _add__curr__sec__range_;
    KEL.typ.nstr _add__curr__city__name_;
    KEL.typ.nstr _add__curr__st_;
    KEL.typ.nstr _add__curr__zip5_;
    KEL.typ.nstr _add__curr__county_;
    KEL.typ.nstr _add__curr__geo__blk_;
    KEL.typ.nstr _add__curr__lat_;
    KEL.typ.nstr _add__curr__long_;
    KEL.typ.nbool _add__input__isbestmatch_;
    KEL.typ.nkdate Deceased_Date_;
    KEL.typ.nkdate Deceased_Date_Of_Birth_;
    KEL.typ.nstr Deceased_First_;
    KEL.typ.nstr Deceased_Middle_;
    KEL.typ.nstr Deceased_Last_;
    KEL.typ.nstr Deceased_Match_Code_;
    KEL.typ.nbool _isdeepdive_;
    KEL.typ.nstr _county__death_;
    KEL.typ.nstr Deceased_Ssn_;
    KEL.typ.nstr _state__death__flag_;
    KEL.typ.nstr _death__rec__src_;
    KEL.typ.nstr _state__death__id_;
    KEL.typ.nstr _curr__incar__flag_;
    KEL.typ.nstr _off__cat__list_;
    KEL.typ.nint _name__ssn__dob__match_;
    KEL.typ.nstr Ip_Address_;
    KEL.typ.nstr _iprngbeg_;
    KEL.typ.nstr _iprngend_;
    KEL.typ.nstr _edgecountry_;
    KEL.typ.nstr _edgeregion_;
    KEL.typ.nstr _edgecity_;
    KEL.typ.nstr _edgeconnspeed_;
    KEL.typ.nstr _edgemetrocode_;
    KEL.typ.nstr _edgelatitude_;
    KEL.typ.nstr _edgelongitude_;
    KEL.typ.nstr _edgepostalcode_;
    KEL.typ.nstr _edgecountrycode_;
    KEL.typ.nstr _edgeregioncode_;
    KEL.typ.nstr _edgecitycode_;
    KEL.typ.nstr _edgecontinentcode_;
    KEL.typ.nstr _edgetwolettercountry_;
    KEL.typ.nstr _edgeinternalcode_;
    KEL.typ.nstr _edgeareacodes_;
    KEL.typ.nstr _edgecountryconf_;
    KEL.typ.nstr _edgeregionconf_;
    KEL.typ.nstr _edgecitycong_;
    KEL.typ.nstr _edgepostalconf_;
    KEL.typ.nstr _edgegmtoffset_;
    KEL.typ.nstr _edgeindst_;
    KEL.typ.nstr _siccode_;
    KEL.typ.nstr _domainname_;
    KEL.typ.nstr _ispname_;
    KEL.typ.nstr _homebiztype_;
    KEL.typ.nstr _asn_;
    KEL.typ.nstr _asnname_;
    KEL.typ.nstr _primarylang_;
    KEL.typ.nstr _secondarylang_;
    KEL.typ.nstr _proxytype_;
    KEL.typ.nstr _proxydescription_;
    KEL.typ.nstr _isanisp_;
    KEL.typ.nstr _companyname_;
    KEL.typ.nstr _ranks_;
    KEL.typ.nstr _households_;
    KEL.typ.nstr _women_;
    KEL.typ.nstr _women18to34_;
    KEL.typ.nstr _women35to49_;
    KEL.typ.nstr _men_;
    KEL.typ.nstr _men18to34_;
    KEL.typ.nstr _men35to49_;
    KEL.typ.nstr _teens_;
    KEL.typ.nstr _kids_;
    KEL.typ.nstr _naicscode_;
    KEL.typ.nstr _cbsacode_;
    KEL.typ.nstr _cbsatitle_;
    KEL.typ.nstr _cbsatype_;
    KEL.typ.nstr _csacode_;
    KEL.typ.nstr _csatitle_;
    KEL.typ.nstr _mdcode_;
    KEL.typ.nstr _mdtitle_;
    KEL.typ.nstr _organizationname_;
    KEL.typ.nstr _advo__hitflag_;
    KEL.typ.nstr _advo__vacancyindicator_;
    KEL.typ.nstr _advo__addressstyle_;
    KEL.typ.nstr _advo__dropindicator_;
    KEL.typ.nstr _advo__residentialorbusinessindicator_;
    KEL.typ.nstr _advo__addresstype_;
    KEL.typ.nstr _advo__addressusagetype_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),Subject_(Subject_:0),Location_(Location_:0),_r_Ssn_(_r_Ssn_:0),_r_Phone_(_r_Phone_:0),_r_Email_(_r_Email_:0),_r_Internet_Protocol_(_r_Internet_Protocol_:0),_r_Bank_Account_(_r_Bank_Account_:0),_r_Drivers_License_(_r_Drivers_License_:0),rin_source(_rin__source_:0),lexid(Lex_Id_:0),phonenumber(Phone_Number_:\'\'),ottoaddressid(Otto_Address_Id_:\'\'),ottoemailid(Otto_Email_Id_:\'\'),ottoipaddressid(Otto_Ip_Address_Id_:\'\'),ottodriverslicenseid(Otto_Drivers_License_Id_:\'\'),ottossnid(Otto_S_S_N_Id_:\'\'),caseid(Case_Id_:\'\'),record_id(Record_Id_:0),eventdate(Event_Date_:DATE),eventtype(Event_Type_:\'\'),title(Title_),firstname(First_Name_),middlename(Middle_Name_),lastname(Last_Name_),namesuffix(Name_Suffix_),addresspobox(_addresspobox_),addresscmra(_addresscmra_),primaryrange(Primary_Range_),predirectional(Predirectional_),primaryname(Primary_Name_),suffix(Suffix_),postdirectional(Postdirectional_),unitdesignation(Unit_Designation_),secondaryrange(Secondary_Range_),postalcity(Postal_City_),vanitycity(Vanity_City_),state(State_),zip(Zip_),zip4(Zip4_),carrierroutenumber(Carrier_Route_Number_),carrierroutesortationatzip(Carrier_Route_Sortation_At_Z_I_P_),lineoftravel(Line_Of_Travel_),lineoftravelorder(Line_Of_Travel_Order_),deliverypointbarcode(Delivery_Point_Barcode_),deliverypointbarcodecheckdigit(Delivery_Point_Barcode_Check_Digit_),typecode(Type_Code_),county(County_),latitude(Latitude_),longitude(Longitude_),metropolitanstatisticalarea(Metropolitan_Statistical_Area_),geoblock(Geo_Block_),geomatch(Geo_Match_),acecleanererrorcode(A_C_E_Cleaner_Error_Code_),isadditional(_is_Additional_),phoneformatted(Phone_Formatted_:\'\'),licensenumber(License_Number_:\'\'),licensestate(License_State_:\'\'),emailaddress(Email_Address_:\'\'),type(Type_:\'\'),createdon(Created_On_:DATE),host(Host_:\'\'),emaillastdomain(Email_Last_Domain_:\'\'),isdisposableemail(_isdisposableemail_:0),ssn(Ssn_:\'\'),ssnformatted(Ssn_Formatted_:\'\'),routingnumber(Routing_Number_:\'\'),fullbankname(Full_Bankname_:\'\'),abbreviatedbankname(Abbreviated_Bankname_:\'\'),fractionalroutingnumber(Fractional_Routingnumber_:\'\'),headofficeroutingnumber(Headoffice_Routingnumber_:\'\'),headofficebranchcodes(Headoffice_Branchcodes_:\'\'),accountnumber(Account_Number_:\'\'),bankhit(Bank_Hit_:\'\'),confidence_that_activity_was_deceitful_id(Confidence__that__activity__was__deceitful__id_:0),name_risk_code(_name__risk__code_:0),dob_risk_code(_dob__risk__code_:0),ssn_risk_code(_ssn__risk__code_:0),drivers_license_risk_code(_drivers__license__risk__code_:0),physical_address_risk_code(_physical__address__risk__code_:0),phone_risk_code(_phone__risk__code_:0),cell_phone_risk_code(_cell__phone__risk__code_:0),work_phone_risk_code(_work__phone__risk__code_:0),bank_account_1_risk_code(_bank__account__1__risk__code_:0),bank_account_2_risk_code(_bank__account__2__risk__code_:0),email_address_risk_code(_email__address__risk__code_:0),ip_address_fraud_code(_ip__address__fraud__code_:0),business_risk_code(_business__risk__code_:0),mailing_address_risk_code(_mailing__address__risk__code_:0),device_risk_code(_device__risk__code_:0),identity_risk_code(_identity__risk__code_:0),dateofbirth(Date_Of_Birth_:DATE),nap_summary(_nap__summary_:0),nas_summary(_nas__summary_:0),cvi(_cvi_:0),fp3_stolenidentityindex(_fp3__stolenidentityindex_:0),syntheticidentityindex_v3(_syntheticidentityindex__v3_:0),manipulatedidentityindex_v3(_manipulatedidentityindex__v3_:0),socsdobflag(_socsdobflag_:0),pwsocsdobflag(_pwsocsdobflag_:0),dobmatchlevel(_dobmatchlevel_:0),sourcerisklevel(_sourcerisklevel_:0),reason1(_reason1_:\'\'),reason2(_reason2_:\'\'),reason3(_reason3_:\'\'),reason4(_reason4_:\'\'),reason5(_reason5_:\'\'),reason6(_reason6_:\'\'),socsvalflag(_socsvalflag_:0),drlcvalflag(_drlcvalflag_:0),hphonevalflag(_hphonevalflag_:0),truedid(_truedid_),best_flags.fname(_best__fname_:\'\'),best_flags.lname(_best__lname_:\'\'),best_flags.ssn(_best__ssn_:\'\'),input_fname_isbestmatch(_input__fname__isbestmatch_:\'\'),input_lname_isbestmatch(_input__lname__isbestmatch_:\'\'),input_ssn_isbestmatch(_input__ssn__isbestmatch_:\'\'),add_curr_pop(_add__curr__pop_),add_curr_prim_range(_add__curr__prim__range_:\'\'),add_curr_predir(_add__curr__predir_:\'\'),add_curr_prim_name(_add__curr__prim__name_:\'\'),add_curr_addr_suffix(_add__curr__addr__suffix_:\'\'),add_curr_postdir(_add__curr__postdir_:\'\'),add_curr_unit_desig(_add__curr__unit__desig_:\'\'),add_curr_sec_range(_add__curr__sec__range_:\'\'),add_curr_city_name(_add__curr__city__name_:\'\'),add_curr_st(_add__curr__st_:\'\'),add_curr_zip5(_add__curr__zip5_:\'\'),add_curr_county(_add__curr__county_:\'\'),add_curr_geo_blk(_add__curr__geo__blk_:\'\'),add_curr_lat(_add__curr__lat_:\'\'),add_curr_long(_add__curr__long_:\'\'),add_input_isbestmatch(_add__input__isbestmatch_),deceaseddate(Deceased_Date_:DATE),deceaseddateofbirth(Deceased_Date_Of_Birth_:DATE),deceasedfirst(Deceased_First_:\'\'),deceasedmiddle(Deceased_Middle_:\'\'),deceasedlast(Deceased_Last_:\'\'),deceasedmatchcode(Deceased_Match_Code_:\'\'),isdeepdive(_isdeepdive_),county_death(_county__death_:\'\'),deceasedssn(Deceased_Ssn_:\'\'),state_death_flag(_state__death__flag_:\'\'),death_rec_src(_death__rec__src_:\'\'),state_death_id(_state__death__id_:\'\'),curr_incar_flag(_curr__incar__flag_:\'\'),off_cat_list(_off__cat__list_:\'\'),name_ssn_dob_match(_name__ssn__dob__match_:0),ip_address(Ip_Address_:\'\'),iprngbeg(_iprngbeg_:\'\'),iprngend(_iprngend_:\'\'),edgecountry(_edgecountry_:\'\'),edgeregion(_edgeregion_:\'\'),edgecity(_edgecity_:\'\'),edgeconnspeed(_edgeconnspeed_:\'\'),edgemetrocode(_edgemetrocode_:\'\'),edgelatitude(_edgelatitude_:\'\'),edgelongitude(_edgelongitude_:\'\'),edgepostalcode(_edgepostalcode_:\'\'),edgecountrycode(_edgecountrycode_:\'\'),edgeregioncode(_edgeregioncode_:\'\'),edgecitycode(_edgecitycode_:\'\'),edgecontinentcode(_edgecontinentcode_:\'\'),edgetwolettercountry(_edgetwolettercountry_:\'\'),edgeinternalcode(_edgeinternalcode_:\'\'),edgeareacodes(_edgeareacodes_:\'\'),edgecountryconf(_edgecountryconf_:\'\'),edgeregionconf(_edgeregionconf_:\'\'),edgecitycong(_edgecitycong_:\'\'),edgepostalconf(_edgepostalconf_:\'\'),edgegmtoffset(_edgegmtoffset_:\'\'),edgeindst(_edgeindst_:\'\'),siccode(_siccode_:\'\'),domainname(_domainname_:\'\'),ispname(_ispname_:\'\'),homebiztype(_homebiztype_:\'\'),asn(_asn_:\'\'),asnname(_asnname_:\'\'),primarylang(_primarylang_:\'\'),secondarylang(_secondarylang_:\'\'),proxytype(_proxytype_:\'\'),proxydescription(_proxydescription_:\'\'),isanisp(_isanisp_:\'\'),companyname(_companyname_:\'\'),ranks(_ranks_:\'\'),households(_households_:\'\'),women(_women_:\'\'),women18to34(_women18to34_:\'\'),women35to49(_women35to49_:\'\'),men(_men_:\'\'),men18to34(_men18to34_:\'\'),men35to49(_men35to49_:\'\'),teens(_teens_:\'\'),kids(_kids_:\'\'),naicscode(_naicscode_:\'\'),cbsacode(_cbsacode_:\'\'),cbsatitle(_cbsatitle_:\'\'),cbsatype(_cbsatype_:\'\'),csacode(_csacode_:\'\'),csatitle(_csatitle_:\'\'),mdcode(_mdcode_:\'\'),mdtitle(_mdtitle_:\'\'),organizationname(_organizationname_:\'\'),advo_hitflag(_advo__hitflag_:\'\'),advo_vacancyindicator(_advo__vacancyindicator_:\'\'),advo_addressstyle(_advo__addressstyle_:\'\'),advo_dropindicator(_advo__dropindicator_:\'\'),advo_residentialorbusinessindicator(_advo__residentialorbusinessindicator_:\'\'),advo_addresstype(_advo__addresstype_:\'\'),advo_addressusagetype(_advo__addressusagetype_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := FraudgovKEL.fraudgovshared((UNSIGNED)record_id > 0);
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.record_id)));
  SHARED __d1_KELfiltered := FraudgovKEL.PersonEventTypes((UNSIGNED)record_id > 0);
  SHARED __d1_Trim := PROJECT(__d1_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.record_id)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'') + '|' + TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Event::UidLookup',EXPIRE(7));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::FraudgovKEL::Event');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::FraudgovKEL::Event');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED __Mapping0 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),Subject_(Subject_:0),Location_(Location_:0),_r_Ssn_(_r_Ssn_:0),_r_Phone_(_r_Phone_:0),_r_Email_(_r_Email_:0),_r_Internet_Protocol_(_r_Internet_Protocol_:0),_r_Bank_Account_(_r_Bank_Account_:0),_r_Drivers_License_(_r_Drivers_License_:0),rin_source(_rin__source_:0),did(Lex_Id_:0),clean_phones.phone_number(Phone_Number_:\'\'),ottoaddressid(Otto_Address_Id_:\'\'),ottoemailid(Otto_Email_Id_:\'\'),ottoipaddressid(Otto_Ip_Address_Id_:\'\'),ottodriverslicenseid(Otto_Drivers_License_Id_:\'\'),ottossnid(Otto_S_S_N_Id_:\'\'),household_id(Case_Id_:\'\'),record_id(Record_Id_:0),event_date(Event_Date_:DATE),eventtype(Event_Type_:\'\'),cleaned_name.title(Title_),cleaned_name.fname(First_Name_),cleaned_name.mname(Middle_Name_),cleaned_name.lname(Last_Name_),cleaned_name.name_suffix(Name_Suffix_),addresspobox(_addresspobox_),addresscmra(_addresscmra_),clean_address.prim_range(Primary_Range_),clean_address.predir(Predirectional_),clean_address.prim_name(Primary_Name_),clean_address.addr_suffix(Suffix_),clean_address.postdir(Postdirectional_),clean_address.unit_desig(Unit_Designation_),clean_address.sec_range(Secondary_Range_),clean_address.p_city_name(Postal_City_),clean_address.v_city_name(Vanity_City_),clean_address.st(State_),clean_address.zip(Zip_),clean_address.zip4(Zip4_),clean_address.cart(Carrier_Route_Number_),clean_address.cr_sort_sz(Carrier_Route_Sortation_At_Z_I_P_),clean_address.lot(Line_Of_Travel_),clean_address.lot_order(Line_Of_Travel_Order_),clean_address.dbpc(Delivery_Point_Barcode_),clean_address.chk_digit(Delivery_Point_Barcode_Check_Digit_),clean_address.rec_type(Type_Code_),clean_address.fips_county(County_),clean_address.geo_lat(Latitude_),clean_address.geo_long(Longitude_),clean_address.msa(Metropolitan_Statistical_Area_),clean_address.geo_blk(Geo_Block_),clean_address.geo_match(Geo_Match_),clean_address.err_stat(A_C_E_Cleaner_Error_Code_),phoneformatted(Phone_Formatted_:\'\'),drivers_license(License_Number_:\'\'),drivers_license_state(License_State_:\'\'),email_address(Email_Address_:\'\'),email_address_type(Type_:\'\'),email_address_date(Created_On_:DATE),host(Host_:\'\'),emaillastdomain(Email_Last_Domain_:\'\'),isdisposableemail(_isdisposableemail_:0),ssn(Ssn_:\'\'),ssnformatted(Ssn_Formatted_:\'\'),bank_routing_number_1(Routing_Number_:\'\'),bank1fullbankname(Full_Bankname_:\'\'),bank1abbreviatedbankname(Abbreviated_Bankname_:\'\'),bank1fractionalroutingnumber(Fractional_Routingnumber_:\'\'),bank1headofficeroutingnumber(Headoffice_Routingnumber_:\'\'),bank1headofficebranchcodes(Headoffice_Branchcodes_:\'\'),bank_account_number_1(Account_Number_:\'\'),bank1hit(Bank_Hit_:\'\'),confidence_that_activity_was_deceitful_id(Confidence__that__activity__was__deceitful__id_:0),name_risk_code(_name__risk__code_:0),dob_risk_code(_dob__risk__code_:0),ssn_risk_code(_ssn__risk__code_:0),drivers_license_risk_code(_drivers__license__risk__code_:0),physical_address_risk_code(_physical__address__risk__code_:0),phone_risk_code(_phone__risk__code_:0),cell_phone_risk_code(_cell__phone__risk__code_:0),work_phone_risk_code(_work__phone__risk__code_:0),bank_account_1_risk_code(_bank__account__1__risk__code_:0),bank_account_2_risk_code(_bank__account__2__risk__code_:0),email_address_risk_code(_email__address__risk__code_:0),ip_address_fraud_code(_ip__address__fraud__code_:0),business_risk_code(_business__risk__code_:0),mailing_address_risk_code(_mailing__address__risk__code_:0),device_risk_code(_device__risk__code_:0),identity_risk_code(_identity__risk__code_:0),dateofbirth(Date_Of_Birth_:DATE),iid.nap_summary(_nap__summary_:0|_nas__summary_:0),iid.cvi(_cvi_:0),fd_scores.stolenidentityindex_v3(_fp3__stolenidentityindex_:0),fd_scores.syntheticidentityindex_v3(_syntheticidentityindex__v3_:0),fd_scores.manipulatedidentityindex_v3(_manipulatedidentityindex__v3_:0),iid.socsdobflag(_socsdobflag_:0),iid.pwsocsdobflag(_pwsocsdobflag_:0),dobmatchlevel(_dobmatchlevel_:0),fdattributesv2.sourcerisklevel(_sourcerisklevel_:0),iid.reason1(_reason1_:\'\'),iid.reason2(_reason2_:\'\'),iid.reason3(_reason3_:\'\'),iid.reason4(_reason4_:\'\'),iid.reason5(_reason5_:\'\'),iid.reason6(_reason6_:\'\'),iid.socsvalflag(_socsvalflag_:0),iid.drlcvalflag(_drlcvalflag_:0),iid.hphonevalflag(_hphonevalflag_:0),truedid(_truedid_),best_fname(_best__fname_:\'\'),best_lname(_best__lname_:\'\'),best_ssn(_best__ssn_:\'\'),best_pii_flags.input_fname_isbestmatch(_input__fname__isbestmatch_:\'\'),best_pii_flags.input_lname_isbestmatch(_input__lname__isbestmatch_:\'\'),best_pii_flags.input_ssn_isbestmatch(_input__ssn__isbestmatch_:\'\'),address_verification.address_history_1.addrpop(_add__curr__pop_),add_curr_prim_range(_add__curr__prim__range_:\'\'),add_curr_predir(_add__curr__predir_:\'\'),add_curr_prim_name(_add__curr__prim__name_:\'\'),add_curr_addr_suffix(_add__curr__addr__suffix_:\'\'),add_curr_postdir(_add__curr__postdir_:\'\'),add_curr_unit_desig(_add__curr__unit__desig_:\'\'),add_curr_sec_range(_add__curr__sec__range_:\'\'),add_curr_city_name(_add__curr__city__name_:\'\'),add_curr_st(_add__curr__st_:\'\'),add_curr_zip5(_add__curr__zip5_:\'\'),add_curr_county(_add__curr__county_:\'\'),add_curr_geo_blk(_add__curr__geo__blk_:\'\'),add_curr_lat(_add__curr__lat_:\'\'),add_curr_long(_add__curr__long_:\'\'),address_verification.input_address_information.isbestmatch(_add__input__isbestmatch_),deceaseddate(Deceased_Date_:DATE),deceaseddateofbirth(Deceased_Date_Of_Birth_:DATE),deceasedfirst(Deceased_First_:\'\'),deceasedmiddle(Deceased_Middle_:\'\'),deceasedlast(Deceased_Last_:\'\'),deceasedmatchcode(Deceased_Match_Code_:\'\'),isdeepdive(_isdeepdive_),county_death(_county__death_:\'\'),deceasedssn(Deceased_Ssn_:\'\'),state_death_flag(_state__death__flag_:\'\'),death_rec_src(_death__rec__src_:\'\'),state_death_id(_state__death__id_:\'\'),curr_incar_flag(_curr__incar__flag_:\'\'),off_cat_list(_off__cat__list_:\'\'),name_ssn_dob_match(_name__ssn__dob__match_:0),ip_address(Ip_Address_:\'\'),iprngbeg(_iprngbeg_:\'\'),iprngend(_iprngend_:\'\'),edgecountry(_edgecountry_:\'\'),edgeregion(_edgeregion_:\'\'),edgecity(_edgecity_:\'\'),edgeconnspeed(_edgeconnspeed_:\'\'),edgemetrocode(_edgemetrocode_:\'\'),edgelatitude(_edgelatitude_:\'\'),edgelongitude(_edgelongitude_:\'\'),edgepostalcode(_edgepostalcode_:\'\'),edgecountrycode(_edgecountrycode_:\'\'),edgeregioncode(_edgeregioncode_:\'\'),edgecitycode(_edgecitycode_:\'\'),edgecontinentcode(_edgecontinentcode_:\'\'),edgetwolettercountry(_edgetwolettercountry_:\'\'),edgeinternalcode(_edgeinternalcode_:\'\'),edgeareacodes(_edgeareacodes_:\'\'),edgecountryconf(_edgecountryconf_:\'\'),edgeregionconf(_edgeregionconf_:\'\'),edgecitycong(_edgecitycong_:\'\'),edgepostalconf(_edgepostalconf_:\'\'),edgegmtoffset(_edgegmtoffset_:\'\'),edgeindst(_edgeindst_:\'\'),siccode(_siccode_:\'\'),domainname(_domainname_:\'\'),ispname(_ispname_:\'\'),homebiztype(_homebiztype_:\'\'),asn(_asn_:\'\'),asnname(_asnname_:\'\'),primarylang(_primarylang_:\'\'),secondarylang(_secondarylang_:\'\'),proxytype(_proxytype_:\'\'),proxydescription(_proxydescription_:\'\'),isanisp(_isanisp_:\'\'),companyname(_companyname_:\'\'),ranks(_ranks_:\'\'),households(_households_:\'\'),women(_women_:\'\'),women18to34(_women18to34_:\'\'),women35to49(_women35to49_:\'\'),men(_men_:\'\'),men18to34(_men18to34_:\'\'),men35to49(_men35to49_:\'\'),teens(_teens_:\'\'),kids(_kids_:\'\'),naicscode(_naicscode_:\'\'),cbsacode(_cbsacode_:\'\'),cbsatitle(_cbsatitle_:\'\'),cbsatype(_cbsatype_:\'\'),csacode(_csacode_:\'\'),csatitle(_csatitle_:\'\'),mdcode(_mdcode_:\'\'),mdtitle(_mdtitle_:\'\'),organizationname(_organizationname_:\'\'),advo_hitflag(_advo__hitflag_:\'\'),advo_vacancyindicator(_advo__vacancyindicator_:\'\'),advo_addressstyle(_advo__addressstyle_:\'\'),advo_dropindicator(_advo__dropindicator_:\'\'),advo_residentialorbusinessindicator(_advo__residentialorbusinessindicator_:\'\'),advo_addresstype(_advo__addresstype_:\'\'),advo_addressusagetype(_advo__addressusagetype_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF._is_Additional_ := __CN(FALSE);
    SELF := __r;
  END;
  SHARED __d0_Out := RECORD
    RECORDOF(FraudgovKEL.fraudgovshared);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.record_id) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  SHARED __d0_Subject__Layout := RECORD
    RECORDOF(__d0_UID_Mapped);
    KEL.typ.uid Subject_;
  END;
  SHARED __d0_Subject__Mapped := JOIN(__d0_UID_Mapped,E_Person.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d0_Subject__Layout,SELF.Subject_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART);
  SHARED __d0_Location__Layout := RECORD
    RECORDOF(__d0_Subject__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d0_Location__Mapped := JOIN(__d0_Subject__Mapped,E_Address.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.OttoAddressId) = RIGHT.KeyVal,TRANSFORM(__d0_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART);
  SHARED __d0__r_Ssn__Layout := RECORD
    RECORDOF(__d0_Location__Mapped);
    KEL.typ.uid _r_Ssn_;
  END;
  SHARED __d0__r_Ssn__Mapped := JOIN(__d0_Location__Mapped,E_Social_Security_Number.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.OttoSSNId) = RIGHT.KeyVal,TRANSFORM(__d0__r_Ssn__Layout,SELF._r_Ssn_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART);
  SHARED __d0__r_Phone__Layout := RECORD
    RECORDOF(__d0__r_Ssn__Mapped);
    KEL.typ.uid _r_Phone_;
  END;
  SHARED __d0__r_Phone__Mapped := JOIN(__d0__r_Ssn__Mapped,E_Phone.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.clean_phones.phone_number) = RIGHT.KeyVal,TRANSFORM(__d0__r_Phone__Layout,SELF._r_Phone_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART);
  SHARED __d0__r_Email__Layout := RECORD
    RECORDOF(__d0__r_Phone__Mapped);
    KEL.typ.uid _r_Email_;
  END;
  SHARED __d0__r_Email__Mapped := JOIN(__d0__r_Phone__Mapped,E_Email.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.OttoEmailId) = RIGHT.KeyVal,TRANSFORM(__d0__r_Email__Layout,SELF._r_Email_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART);
  SHARED __d0__r_Internet_Protocol__Layout := RECORD
    RECORDOF(__d0__r_Email__Mapped);
    KEL.typ.uid _r_Internet_Protocol_;
  END;
  SHARED __d0__r_Internet_Protocol__Mapped := JOIN(__d0__r_Email__Mapped,E_Internet_Protocol.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.OttoIpAddressId) = RIGHT.KeyVal,TRANSFORM(__d0__r_Internet_Protocol__Layout,SELF._r_Internet_Protocol_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART);
  SHARED __d0__r_Bank_Account__Layout := RECORD
    RECORDOF(__d0__r_Internet_Protocol__Mapped);
    KEL.typ.uid _r_Bank_Account_;
  END;
  SHARED __d0__r_Bank_Account__Mapped := JOIN(__d0__r_Internet_Protocol__Mapped,E_Bank_Account.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.OttoBankAccountId) = RIGHT.KeyVal,TRANSFORM(__d0__r_Bank_Account__Layout,SELF._r_Bank_Account_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART);
  SHARED __d0__r_Drivers_License__Layout := RECORD
    RECORDOF(__d0__r_Bank_Account__Mapped);
    KEL.typ.uid _r_Drivers_License_;
  END;
  SHARED __d0__r_Drivers_License__Mapped := JOIN(__d0__r_Bank_Account__Mapped,E_Drivers_License.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.OttoDriversLicenseId) = RIGHT.KeyVal,TRANSFORM(__d0__r_Drivers_License__Layout,SELF._r_Drivers_License_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART);
  EXPORT FraudgovKEL_fraudgovshared_Invalid := __d0__r_Drivers_License__Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0__r_Drivers_License__Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0),__Mapping0_Transform(LEFT)));
  SHARED __Mapping1 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),Subject_(Subject_:0),Location_(Location_:0),_r_Ssn_(_r_Ssn_:0),_r_Phone_(_r_Phone_:0),_r_Email_(_r_Email_:0),_r_Internet_Protocol_(_r_Internet_Protocol_:0),_r_Bank_Account_(_r_Bank_Account_:0),_r_Drivers_License_(_r_Drivers_License_:0),rin_source(_rin__source_:0),lexid(Lex_Id_:0),phonenumber(Phone_Number_:\'\'),ottoaddressid(Otto_Address_Id_:\'\'),ottoemailid(Otto_Email_Id_:\'\'),ottoipaddressid(Otto_Ip_Address_Id_:\'\'),ottodriverslicenseid(Otto_Drivers_License_Id_:\'\'),ottossnid(Otto_S_S_N_Id_:\'\'),caseid(Case_Id_:\'\'),record_id(Record_Id_:0),eventdate(Event_Date_:DATE),event_type(Event_Type_:\'\'),title(Title_),firstname(First_Name_),middlename(Middle_Name_),lastname(Last_Name_),namesuffix(Name_Suffix_),addresspobox(_addresspobox_),addresscmra(_addresscmra_),primaryrange(Primary_Range_),predirectional(Predirectional_),primaryname(Primary_Name_),suffix(Suffix_),postdirectional(Postdirectional_),unitdesignation(Unit_Designation_),secondaryrange(Secondary_Range_),postalcity(Postal_City_),vanitycity(Vanity_City_),state(State_),zip(Zip_),zip4(Zip4_),carrierroutenumber(Carrier_Route_Number_),carrierroutesortationatzip(Carrier_Route_Sortation_At_Z_I_P_),lineoftravel(Line_Of_Travel_),lineoftravelorder(Line_Of_Travel_Order_),deliverypointbarcode(Delivery_Point_Barcode_),deliverypointbarcodecheckdigit(Delivery_Point_Barcode_Check_Digit_),typecode(Type_Code_),county(County_),latitude(Latitude_),longitude(Longitude_),metropolitanstatisticalarea(Metropolitan_Statistical_Area_),geoblock(Geo_Block_),geomatch(Geo_Match_),acecleanererrorcode(A_C_E_Cleaner_Error_Code_),isadditional(_is_Additional_),phoneformatted(Phone_Formatted_:\'\'),licensenumber(License_Number_:\'\'),licensestate(License_State_:\'\'),emailaddress(Email_Address_:\'\'),type(Type_:\'\'),createdon(Created_On_:DATE),host(Host_:\'\'),emaillastdomain(Email_Last_Domain_:\'\'),isdisposableemail(_isdisposableemail_:0),ssn(Ssn_:\'\'),ssnformatted(Ssn_Formatted_:\'\'),routingnumber(Routing_Number_:\'\'),fullbankname(Full_Bankname_:\'\'),abbreviatedbankname(Abbreviated_Bankname_:\'\'),fractionalroutingnumber(Fractional_Routingnumber_:\'\'),headofficeroutingnumber(Headoffice_Routingnumber_:\'\'),headofficebranchcodes(Headoffice_Branchcodes_:\'\'),accountnumber(Account_Number_:\'\'),bankhit(Bank_Hit_:\'\'),confidence_that_activity_was_deceitful_id(Confidence__that__activity__was__deceitful__id_:0),name_risk_code(_name__risk__code_:0),dob_risk_code(_dob__risk__code_:0),ssn_risk_code(_ssn__risk__code_:0),drivers_license_risk_code(_drivers__license__risk__code_:0),physical_address_risk_code(_physical__address__risk__code_:0),phone_risk_code(_phone__risk__code_:0),cell_phone_risk_code(_cell__phone__risk__code_:0),work_phone_risk_code(_work__phone__risk__code_:0),bank_account_1_risk_code(_bank__account__1__risk__code_:0),bank_account_2_risk_code(_bank__account__2__risk__code_:0),email_address_risk_code(_email__address__risk__code_:0),ip_address_fraud_code(_ip__address__fraud__code_:0),business_risk_code(_business__risk__code_:0),mailing_address_risk_code(_mailing__address__risk__code_:0),device_risk_code(_device__risk__code_:0),identity_risk_code(_identity__risk__code_:0),dateofbirth(Date_Of_Birth_:DATE),nap_summary(_nap__summary_:0),nas_summary(_nas__summary_:0),cvi(_cvi_:0),fp3_stolenidentityindex(_fp3__stolenidentityindex_:0),syntheticidentityindex_v3(_syntheticidentityindex__v3_:0),manipulatedidentityindex_v3(_manipulatedidentityindex__v3_:0),socsdobflag(_socsdobflag_:0),pwsocsdobflag(_pwsocsdobflag_:0),dobmatchlevel(_dobmatchlevel_:0),sourcerisklevel(_sourcerisklevel_:0),reason1(_reason1_:\'\'),reason2(_reason2_:\'\'),reason3(_reason3_:\'\'),reason4(_reason4_:\'\'),reason5(_reason5_:\'\'),reason6(_reason6_:\'\'),socsvalflag(_socsvalflag_:0),drlcvalflag(_drlcvalflag_:0),hphonevalflag(_hphonevalflag_:0),truedid(_truedid_),best_flags.fname(_best__fname_:\'\'),best_flags.lname(_best__lname_:\'\'),best_flags.ssn(_best__ssn_:\'\'),input_fname_isbestmatch(_input__fname__isbestmatch_:\'\'),input_lname_isbestmatch(_input__lname__isbestmatch_:\'\'),input_ssn_isbestmatch(_input__ssn__isbestmatch_:\'\'),add_curr_pop(_add__curr__pop_),add_curr_prim_range(_add__curr__prim__range_:\'\'),add_curr_predir(_add__curr__predir_:\'\'),add_curr_prim_name(_add__curr__prim__name_:\'\'),add_curr_addr_suffix(_add__curr__addr__suffix_:\'\'),add_curr_postdir(_add__curr__postdir_:\'\'),add_curr_unit_desig(_add__curr__unit__desig_:\'\'),add_curr_sec_range(_add__curr__sec__range_:\'\'),add_curr_city_name(_add__curr__city__name_:\'\'),add_curr_st(_add__curr__st_:\'\'),add_curr_zip5(_add__curr__zip5_:\'\'),add_curr_county(_add__curr__county_:\'\'),add_curr_geo_blk(_add__curr__geo__blk_:\'\'),add_curr_lat(_add__curr__lat_:\'\'),add_curr_long(_add__curr__long_:\'\'),add_input_isbestmatch(_add__input__isbestmatch_),deceaseddate(Deceased_Date_:DATE),deceaseddateofbirth(Deceased_Date_Of_Birth_:DATE),deceasedfirst(Deceased_First_:\'\'),deceasedmiddle(Deceased_Middle_:\'\'),deceasedlast(Deceased_Last_:\'\'),deceasedmatchcode(Deceased_Match_Code_:\'\'),isdeepdive(_isdeepdive_),county_death(_county__death_:\'\'),deceasedssn(Deceased_Ssn_:\'\'),state_death_flag(_state__death__flag_:\'\'),death_rec_src(_death__rec__src_:\'\'),state_death_id(_state__death__id_:\'\'),curr_incar_flag(_curr__incar__flag_:\'\'),off_cat_list(_off__cat__list_:\'\'),name_ssn_dob_match(_name__ssn__dob__match_:0),ip_address(Ip_Address_:\'\'),iprngbeg(_iprngbeg_:\'\'),iprngend(_iprngend_:\'\'),edgecountry(_edgecountry_:\'\'),edgeregion(_edgeregion_:\'\'),edgecity(_edgecity_:\'\'),edgeconnspeed(_edgeconnspeed_:\'\'),edgemetrocode(_edgemetrocode_:\'\'),edgelatitude(_edgelatitude_:\'\'),edgelongitude(_edgelongitude_:\'\'),edgepostalcode(_edgepostalcode_:\'\'),edgecountrycode(_edgecountrycode_:\'\'),edgeregioncode(_edgeregioncode_:\'\'),edgecitycode(_edgecitycode_:\'\'),edgecontinentcode(_edgecontinentcode_:\'\'),edgetwolettercountry(_edgetwolettercountry_:\'\'),edgeinternalcode(_edgeinternalcode_:\'\'),edgeareacodes(_edgeareacodes_:\'\'),edgecountryconf(_edgecountryconf_:\'\'),edgeregionconf(_edgeregionconf_:\'\'),edgecitycong(_edgecitycong_:\'\'),edgepostalconf(_edgepostalconf_:\'\'),edgegmtoffset(_edgegmtoffset_:\'\'),edgeindst(_edgeindst_:\'\'),siccode(_siccode_:\'\'),domainname(_domainname_:\'\'),ispname(_ispname_:\'\'),homebiztype(_homebiztype_:\'\'),asn(_asn_:\'\'),asnname(_asnname_:\'\'),primarylang(_primarylang_:\'\'),secondarylang(_secondarylang_:\'\'),proxytype(_proxytype_:\'\'),proxydescription(_proxydescription_:\'\'),isanisp(_isanisp_:\'\'),companyname(_companyname_:\'\'),ranks(_ranks_:\'\'),households(_households_:\'\'),women(_women_:\'\'),women18to34(_women18to34_:\'\'),women35to49(_women35to49_:\'\'),men(_men_:\'\'),men18to34(_men18to34_:\'\'),men35to49(_men35to49_:\'\'),teens(_teens_:\'\'),kids(_kids_:\'\'),naicscode(_naicscode_:\'\'),cbsacode(_cbsacode_:\'\'),cbsatitle(_cbsatitle_:\'\'),cbsatype(_cbsatype_:\'\'),csacode(_csacode_:\'\'),csatitle(_csatitle_:\'\'),mdcode(_mdcode_:\'\'),mdtitle(_mdtitle_:\'\'),organizationname(_organizationname_:\'\'),advo_hitflag(_advo__hitflag_:\'\'),advo_vacancyindicator(_advo__vacancyindicator_:\'\'),advo_addressstyle(_advo__addressstyle_:\'\'),advo_dropindicator(_advo__dropindicator_:\'\'),advo_residentialorbusinessindicator(_advo__residentialorbusinessindicator_:\'\'),advo_addresstype(_advo__addresstype_:\'\'),advo_addressusagetype(_advo__addressusagetype_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d1_Out := RECORD
    RECORDOF(FraudgovKEL.PersonEventTypes);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_KELfiltered,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.record_id) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  SHARED __d1_Subject__Layout := RECORD
    RECORDOF(__d1_UID_Mapped);
    KEL.typ.uid Subject_;
  END;
  SHARED __d1_Subject__Mapped := JOIN(__d1_UID_Mapped,E_Person.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.LexId) = RIGHT.KeyVal,TRANSFORM(__d1_Subject__Layout,SELF.Subject_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART);
  SHARED __d1_Location__Layout := RECORD
    RECORDOF(__d1_Subject__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d1_Location__Mapped := JOIN(__d1_Subject__Mapped,E_Address.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.OttoAddressId) = RIGHT.KeyVal,TRANSFORM(__d1_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART);
  SHARED __d1__r_Ssn__Layout := RECORD
    RECORDOF(__d1_Location__Mapped);
    KEL.typ.uid _r_Ssn_;
  END;
  SHARED __d1__r_Ssn__Mapped := JOIN(__d1_Location__Mapped,E_Social_Security_Number.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.OttoSSNId) = RIGHT.KeyVal,TRANSFORM(__d1__r_Ssn__Layout,SELF._r_Ssn_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART);
  SHARED __d1__r_Phone__Layout := RECORD
    RECORDOF(__d1__r_Ssn__Mapped);
    KEL.typ.uid _r_Phone_;
  END;
  SHARED __d1__r_Phone__Mapped := JOIN(__d1__r_Ssn__Mapped,E_Phone.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.PhoneNumber) = RIGHT.KeyVal,TRANSFORM(__d1__r_Phone__Layout,SELF._r_Phone_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART);
  SHARED __d1__r_Email__Layout := RECORD
    RECORDOF(__d1__r_Phone__Mapped);
    KEL.typ.uid _r_Email_;
  END;
  SHARED __d1__r_Email__Mapped := JOIN(__d1__r_Phone__Mapped,E_Email.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.OttoEmailId) = RIGHT.KeyVal,TRANSFORM(__d1__r_Email__Layout,SELF._r_Email_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART);
  SHARED __d1__r_Internet_Protocol__Layout := RECORD
    RECORDOF(__d1__r_Email__Mapped);
    KEL.typ.uid _r_Internet_Protocol_;
  END;
  SHARED __d1__r_Internet_Protocol__Mapped := JOIN(__d1__r_Email__Mapped,E_Internet_Protocol.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.OttoIpAddressId) = RIGHT.KeyVal,TRANSFORM(__d1__r_Internet_Protocol__Layout,SELF._r_Internet_Protocol_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART);
  SHARED __d1__r_Bank_Account__Layout := RECORD
    RECORDOF(__d1__r_Internet_Protocol__Mapped);
    KEL.typ.uid _r_Bank_Account_;
  END;
  SHARED __d1__r_Bank_Account__Mapped := JOIN(__d1__r_Internet_Protocol__Mapped,E_Bank_Account.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.OttoBankAccountId) = RIGHT.KeyVal,TRANSFORM(__d1__r_Bank_Account__Layout,SELF._r_Bank_Account_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART);
  SHARED __d1__r_Drivers_License__Layout := RECORD
    RECORDOF(__d1__r_Bank_Account__Mapped);
    KEL.typ.uid _r_Drivers_License_;
  END;
  SHARED __d1__r_Drivers_License__Mapped := JOIN(__d1__r_Bank_Account__Mapped,E_Drivers_License.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.OttoDriversLicenseId) = RIGHT.KeyVal,TRANSFORM(__d1__r_Drivers_License__Layout,SELF._r_Drivers_License_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART);
  EXPORT FraudgovKEL_PersonEventTypes_Invalid := __d1__r_Drivers_License__Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1__r_Drivers_License__Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1));
  EXPORT InData := __d0 + __d1;
  EXPORT Event_Types_Layout := RECORD
    KEL.typ.nstr Event_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Source_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nint Record_Id_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ndataset(Event_Types_Layout) Event_Types_;
    KEL.typ.ntyp(E_Phone.Typ) _r_Phone_;
    KEL.typ.ntyp(E_Email.Typ) _r_Email_;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) _r_Internet_Protocol_;
    KEL.typ.ntyp(E_Bank_Account.Typ) _r_Bank_Account_;
    KEL.typ.ntyp(E_Drivers_License.Typ) _r_Drivers_License_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) _r_Ssn_;
    KEL.typ.nstr Title_;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Middle_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nstr Name_Suffix_;
    KEL.typ.nint _rin__source_;
    KEL.typ.nint Lex_Id_;
    KEL.typ.nstr Otto_Address_Id_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nkdate Deceased_Date_;
    KEL.typ.nkdate Deceased_Date_Of_Birth_;
    KEL.typ.nstr Deceased_First_;
    KEL.typ.nstr Deceased_Middle_;
    KEL.typ.nstr Deceased_Last_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nstr Otto_Email_Id_;
    KEL.typ.nstr Otto_Ip_Address_Id_;
    KEL.typ.nstr Otto_S_S_N_Id_;
    KEL.typ.nstr Case_Id_;
    KEL.typ.nstr Otto_Drivers_License_Id_;
    KEL.typ.nstr Deceased_Match_Code_;
    KEL.typ.nbool _isdeepdive_;
    KEL.typ.nint _nap__summary_;
    KEL.typ.nint _nas__summary_;
    KEL.typ.nint _cvi_;
    KEL.typ.nint _fp3__stolenidentityindex_;
    KEL.typ.nint _syntheticidentityindex__v3_;
    KEL.typ.nint _manipulatedidentityindex__v3_;
    KEL.typ.nint _socsdobflag_;
    KEL.typ.nint _pwsocsdobflag_;
    KEL.typ.nint _dobmatchlevel_;
    KEL.typ.nint _sourcerisklevel_;
    KEL.typ.nstr _reason1_;
    KEL.typ.nstr _reason2_;
    KEL.typ.nstr _reason3_;
    KEL.typ.nstr _reason4_;
    KEL.typ.nstr _reason5_;
    KEL.typ.nstr _reason6_;
    KEL.typ.nint _socsvalflag_;
    KEL.typ.nint _drlcvalflag_;
    KEL.typ.nint _hphonevalflag_;
    KEL.typ.nbool _truedid_;
    KEL.typ.nstr _best__fname_;
    KEL.typ.nstr _best__lname_;
    KEL.typ.nstr _best__ssn_;
    KEL.typ.nstr _input__fname__isbestmatch_;
    KEL.typ.nstr _input__lname__isbestmatch_;
    KEL.typ.nstr _input__ssn__isbestmatch_;
    KEL.typ.nbool _add__curr__pop_;
    KEL.typ.nstr _add__curr__prim__range_;
    KEL.typ.nstr _add__curr__predir_;
    KEL.typ.nstr _add__curr__prim__name_;
    KEL.typ.nstr _add__curr__addr__suffix_;
    KEL.typ.nstr _add__curr__postdir_;
    KEL.typ.nstr _add__curr__unit__desig_;
    KEL.typ.nstr _add__curr__sec__range_;
    KEL.typ.nstr _add__curr__city__name_;
    KEL.typ.nstr _add__curr__st_;
    KEL.typ.nstr _add__curr__zip5_;
    KEL.typ.nstr _add__curr__county_;
    KEL.typ.nstr _add__curr__geo__blk_;
    KEL.typ.nstr _add__curr__lat_;
    KEL.typ.nstr _add__curr__long_;
    KEL.typ.nbool _add__input__isbestmatch_;
    KEL.typ.nstr _county__death_;
    KEL.typ.nstr Deceased_Ssn_;
    KEL.typ.nstr _state__death__flag_;
    KEL.typ.nstr _death__rec__src_;
    KEL.typ.nstr _state__death__id_;
    KEL.typ.nbool _addresspobox_;
    KEL.typ.nbool _addresscmra_;
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
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr License_State_;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr Type_;
    KEL.typ.nkdate Created_On_;
    KEL.typ.nstr Host_;
    KEL.typ.nstr Email_Last_Domain_;
    KEL.typ.nint _isdisposableemail_;
    KEL.typ.nstr Ssn_;
    KEL.typ.nstr Ssn_Formatted_;
    KEL.typ.nstr Routing_Number_;
    KEL.typ.nstr Full_Bankname_;
    KEL.typ.nstr Abbreviated_Bankname_;
    KEL.typ.nstr Fractional_Routingnumber_;
    KEL.typ.nstr Headoffice_Routingnumber_;
    KEL.typ.nstr Headoffice_Branchcodes_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nstr Bank_Hit_;
    KEL.typ.nstr _curr__incar__flag_;
    KEL.typ.nstr _off__cat__list_;
    KEL.typ.nint _name__ssn__dob__match_;
    KEL.typ.nstr Ip_Address_;
    KEL.typ.nstr _iprngbeg_;
    KEL.typ.nstr _iprngend_;
    KEL.typ.nstr _edgecountry_;
    KEL.typ.nstr _edgeregion_;
    KEL.typ.nstr _edgecity_;
    KEL.typ.nstr _edgeconnspeed_;
    KEL.typ.nstr _edgemetrocode_;
    KEL.typ.nstr _edgelatitude_;
    KEL.typ.nstr _edgelongitude_;
    KEL.typ.nstr _edgepostalcode_;
    KEL.typ.nstr _edgecountrycode_;
    KEL.typ.nstr _edgeregioncode_;
    KEL.typ.nstr _edgecitycode_;
    KEL.typ.nstr _edgecontinentcode_;
    KEL.typ.nstr _edgetwolettercountry_;
    KEL.typ.nstr _edgeinternalcode_;
    KEL.typ.nstr _edgeareacodes_;
    KEL.typ.nstr _edgecountryconf_;
    KEL.typ.nstr _edgeregionconf_;
    KEL.typ.nstr _edgecitycong_;
    KEL.typ.nstr _edgepostalconf_;
    KEL.typ.nstr _edgegmtoffset_;
    KEL.typ.nstr _edgeindst_;
    KEL.typ.nstr _siccode_;
    KEL.typ.nstr _domainname_;
    KEL.typ.nstr _ispname_;
    KEL.typ.nstr _homebiztype_;
    KEL.typ.nstr _asn_;
    KEL.typ.nstr _asnname_;
    KEL.typ.nstr _primarylang_;
    KEL.typ.nstr _secondarylang_;
    KEL.typ.nstr _proxytype_;
    KEL.typ.nstr _proxydescription_;
    KEL.typ.nstr _isanisp_;
    KEL.typ.nstr _companyname_;
    KEL.typ.nstr _ranks_;
    KEL.typ.nstr _households_;
    KEL.typ.nstr _women_;
    KEL.typ.nstr _women18to34_;
    KEL.typ.nstr _women35to49_;
    KEL.typ.nstr _men_;
    KEL.typ.nstr _men18to34_;
    KEL.typ.nstr _men35to49_;
    KEL.typ.nstr _teens_;
    KEL.typ.nstr _kids_;
    KEL.typ.nstr _naicscode_;
    KEL.typ.nstr _cbsacode_;
    KEL.typ.nstr _cbsatitle_;
    KEL.typ.nstr _cbsatype_;
    KEL.typ.nstr _csacode_;
    KEL.typ.nstr _csatitle_;
    KEL.typ.nstr _mdcode_;
    KEL.typ.nstr _mdtitle_;
    KEL.typ.nstr _organizationname_;
    KEL.typ.nint Confidence__that__activity__was__deceitful__id_;
    KEL.typ.nint _name__risk__code_;
    KEL.typ.nint _dob__risk__code_;
    KEL.typ.nint _ssn__risk__code_;
    KEL.typ.nint _drivers__license__risk__code_;
    KEL.typ.nint _physical__address__risk__code_;
    KEL.typ.nint _phone__risk__code_;
    KEL.typ.nint _cell__phone__risk__code_;
    KEL.typ.nint _work__phone__risk__code_;
    KEL.typ.nint _bank__account__1__risk__code_;
    KEL.typ.nint _bank__account__2__risk__code_;
    KEL.typ.nint _email__address__risk__code_;
    KEL.typ.nint _ip__address__fraud__code_;
    KEL.typ.nint _business__risk__code_;
    KEL.typ.nint _mailing__address__risk__code_;
    KEL.typ.nint _device__risk__code_;
    KEL.typ.nint _identity__risk__code_;
    KEL.typ.nstr _advo__hitflag_;
    KEL.typ.nstr _advo__vacancyindicator_;
    KEL.typ.nstr _advo__addressstyle_;
    KEL.typ.nstr _advo__dropindicator_;
    KEL.typ.nstr _advo__residentialorbusinessindicator_;
    KEL.typ.nstr _advo__addresstype_;
    KEL.typ.nstr _advo__addressusagetype_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Event_Group := __PostFilter;
  Layout Event__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF._r_Customer_ := KEL.Intake.SingleValue(__recs,_r_Customer_);
    SELF._r_Source_Customer_ := KEL.Intake.SingleValue(__recs,_r_Source_Customer_);
    SELF.Subject_ := KEL.Intake.SingleValue(__recs,Subject_);
    SELF.Location_ := KEL.Intake.SingleValue(__recs,Location_);
    SELF.Record_Id_ := KEL.Intake.SingleValue(__recs,Record_Id_);
    SELF.Event_Date_ := KEL.Intake.SingleValue(__recs,Event_Date_);
    SELF.Event_Types_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Event_Type_},Event_Type_),Event_Types_Layout)(__NN(Event_Type_)));
    SELF._r_Phone_ := KEL.Intake.SingleValue(__recs,_r_Phone_);
    SELF._r_Email_ := KEL.Intake.SingleValue(__recs,_r_Email_);
    SELF._r_Internet_Protocol_ := KEL.Intake.SingleValue(__recs,_r_Internet_Protocol_);
    SELF._r_Bank_Account_ := KEL.Intake.SingleValue(__recs,_r_Bank_Account_);
    SELF._r_Drivers_License_ := KEL.Intake.SingleValue(__recs,_r_Drivers_License_);
    SELF._r_Ssn_ := KEL.Intake.SingleValue(__recs,_r_Ssn_);
    SELF.Title_ := KEL.Intake.SingleValue(__recs,Title_);
    SELF.First_Name_ := KEL.Intake.SingleValue(__recs,First_Name_);
    SELF.Middle_Name_ := KEL.Intake.SingleValue(__recs,Middle_Name_);
    SELF.Last_Name_ := KEL.Intake.SingleValue(__recs,Last_Name_);
    SELF.Name_Suffix_ := KEL.Intake.SingleValue(__recs,Name_Suffix_);
    SELF._rin__source_ := KEL.Intake.SingleValue(__recs,_rin__source_);
    SELF.Lex_Id_ := KEL.Intake.SingleValue(__recs,Lex_Id_);
    SELF.Otto_Address_Id_ := KEL.Intake.SingleValue(__recs,Otto_Address_Id_);
    SELF.Date_Of_Birth_ := KEL.Intake.SingleValue(__recs,Date_Of_Birth_);
    SELF.Deceased_Date_ := KEL.Intake.SingleValue(__recs,Deceased_Date_);
    SELF.Deceased_Date_Of_Birth_ := KEL.Intake.SingleValue(__recs,Deceased_Date_Of_Birth_);
    SELF.Deceased_First_ := KEL.Intake.SingleValue(__recs,Deceased_First_);
    SELF.Deceased_Middle_ := KEL.Intake.SingleValue(__recs,Deceased_Middle_);
    SELF.Deceased_Last_ := KEL.Intake.SingleValue(__recs,Deceased_Last_);
    SELF.Phone_Number_ := KEL.Intake.SingleValue(__recs,Phone_Number_);
    SELF.Otto_Email_Id_ := KEL.Intake.SingleValue(__recs,Otto_Email_Id_);
    SELF.Otto_Ip_Address_Id_ := KEL.Intake.SingleValue(__recs,Otto_Ip_Address_Id_);
    SELF.Otto_S_S_N_Id_ := KEL.Intake.SingleValue(__recs,Otto_S_S_N_Id_);
    SELF.Case_Id_ := KEL.Intake.SingleValue(__recs,Case_Id_);
    SELF.Otto_Drivers_License_Id_ := KEL.Intake.SingleValue(__recs,Otto_Drivers_License_Id_);
    SELF.Deceased_Match_Code_ := KEL.Intake.SingleValue(__recs,Deceased_Match_Code_);
    SELF._isdeepdive_ := KEL.Intake.SingleValue(__recs,_isdeepdive_);
    SELF._nap__summary_ := KEL.Intake.SingleValue(__recs,_nap__summary_);
    SELF._nas__summary_ := KEL.Intake.SingleValue(__recs,_nas__summary_);
    SELF._cvi_ := KEL.Intake.SingleValue(__recs,_cvi_);
    SELF._fp3__stolenidentityindex_ := KEL.Intake.SingleValue(__recs,_fp3__stolenidentityindex_);
    SELF._syntheticidentityindex__v3_ := KEL.Intake.SingleValue(__recs,_syntheticidentityindex__v3_);
    SELF._manipulatedidentityindex__v3_ := KEL.Intake.SingleValue(__recs,_manipulatedidentityindex__v3_);
    SELF._socsdobflag_ := KEL.Intake.SingleValue(__recs,_socsdobflag_);
    SELF._pwsocsdobflag_ := KEL.Intake.SingleValue(__recs,_pwsocsdobflag_);
    SELF._dobmatchlevel_ := KEL.Intake.SingleValue(__recs,_dobmatchlevel_);
    SELF._sourcerisklevel_ := KEL.Intake.SingleValue(__recs,_sourcerisklevel_);
    SELF._reason1_ := KEL.Intake.SingleValue(__recs,_reason1_);
    SELF._reason2_ := KEL.Intake.SingleValue(__recs,_reason2_);
    SELF._reason3_ := KEL.Intake.SingleValue(__recs,_reason3_);
    SELF._reason4_ := KEL.Intake.SingleValue(__recs,_reason4_);
    SELF._reason5_ := KEL.Intake.SingleValue(__recs,_reason5_);
    SELF._reason6_ := KEL.Intake.SingleValue(__recs,_reason6_);
    SELF._socsvalflag_ := KEL.Intake.SingleValue(__recs,_socsvalflag_);
    SELF._drlcvalflag_ := KEL.Intake.SingleValue(__recs,_drlcvalflag_);
    SELF._hphonevalflag_ := KEL.Intake.SingleValue(__recs,_hphonevalflag_);
    SELF._truedid_ := KEL.Intake.SingleValue(__recs,_truedid_);
    SELF._best__fname_ := KEL.Intake.SingleValue(__recs,_best__fname_);
    SELF._best__lname_ := KEL.Intake.SingleValue(__recs,_best__lname_);
    SELF._best__ssn_ := KEL.Intake.SingleValue(__recs,_best__ssn_);
    SELF._input__fname__isbestmatch_ := KEL.Intake.SingleValue(__recs,_input__fname__isbestmatch_);
    SELF._input__lname__isbestmatch_ := KEL.Intake.SingleValue(__recs,_input__lname__isbestmatch_);
    SELF._input__ssn__isbestmatch_ := KEL.Intake.SingleValue(__recs,_input__ssn__isbestmatch_);
    SELF._add__curr__pop_ := KEL.Intake.SingleValue(__recs,_add__curr__pop_);
    SELF._add__curr__prim__range_ := KEL.Intake.SingleValue(__recs,_add__curr__prim__range_);
    SELF._add__curr__predir_ := KEL.Intake.SingleValue(__recs,_add__curr__predir_);
    SELF._add__curr__prim__name_ := KEL.Intake.SingleValue(__recs,_add__curr__prim__name_);
    SELF._add__curr__addr__suffix_ := KEL.Intake.SingleValue(__recs,_add__curr__addr__suffix_);
    SELF._add__curr__postdir_ := KEL.Intake.SingleValue(__recs,_add__curr__postdir_);
    SELF._add__curr__unit__desig_ := KEL.Intake.SingleValue(__recs,_add__curr__unit__desig_);
    SELF._add__curr__sec__range_ := KEL.Intake.SingleValue(__recs,_add__curr__sec__range_);
    SELF._add__curr__city__name_ := KEL.Intake.SingleValue(__recs,_add__curr__city__name_);
    SELF._add__curr__st_ := KEL.Intake.SingleValue(__recs,_add__curr__st_);
    SELF._add__curr__zip5_ := KEL.Intake.SingleValue(__recs,_add__curr__zip5_);
    SELF._add__curr__county_ := KEL.Intake.SingleValue(__recs,_add__curr__county_);
    SELF._add__curr__geo__blk_ := KEL.Intake.SingleValue(__recs,_add__curr__geo__blk_);
    SELF._add__curr__lat_ := KEL.Intake.SingleValue(__recs,_add__curr__lat_);
    SELF._add__curr__long_ := KEL.Intake.SingleValue(__recs,_add__curr__long_);
    SELF._add__input__isbestmatch_ := KEL.Intake.SingleValue(__recs,_add__input__isbestmatch_);
    SELF._county__death_ := KEL.Intake.SingleValue(__recs,_county__death_);
    SELF.Deceased_Ssn_ := KEL.Intake.SingleValue(__recs,Deceased_Ssn_);
    SELF._state__death__flag_ := KEL.Intake.SingleValue(__recs,_state__death__flag_);
    SELF._death__rec__src_ := KEL.Intake.SingleValue(__recs,_death__rec__src_);
    SELF._state__death__id_ := KEL.Intake.SingleValue(__recs,_state__death__id_);
    SELF._addresspobox_ := KEL.Intake.SingleValue(__recs,_addresspobox_);
    SELF._addresscmra_ := KEL.Intake.SingleValue(__recs,_addresscmra_);
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
    SELF.License_Number_ := KEL.Intake.SingleValue(__recs,License_Number_);
    SELF.License_State_ := KEL.Intake.SingleValue(__recs,License_State_);
    SELF.Phone_Formatted_ := KEL.Intake.SingleValue(__recs,Phone_Formatted_);
    SELF.Email_Address_ := KEL.Intake.SingleValue(__recs,Email_Address_);
    SELF.Type_ := KEL.Intake.SingleValue(__recs,Type_);
    SELF.Created_On_ := KEL.Intake.SingleValue(__recs,Created_On_);
    SELF.Host_ := KEL.Intake.SingleValue(__recs,Host_);
    SELF.Email_Last_Domain_ := KEL.Intake.SingleValue(__recs,Email_Last_Domain_);
    SELF._isdisposableemail_ := KEL.Intake.SingleValue(__recs,_isdisposableemail_);
    SELF.Ssn_ := KEL.Intake.SingleValue(__recs,Ssn_);
    SELF.Ssn_Formatted_ := KEL.Intake.SingleValue(__recs,Ssn_Formatted_);
    SELF.Routing_Number_ := KEL.Intake.SingleValue(__recs,Routing_Number_);
    SELF.Full_Bankname_ := KEL.Intake.SingleValue(__recs,Full_Bankname_);
    SELF.Abbreviated_Bankname_ := KEL.Intake.SingleValue(__recs,Abbreviated_Bankname_);
    SELF.Fractional_Routingnumber_ := KEL.Intake.SingleValue(__recs,Fractional_Routingnumber_);
    SELF.Headoffice_Routingnumber_ := KEL.Intake.SingleValue(__recs,Headoffice_Routingnumber_);
    SELF.Headoffice_Branchcodes_ := KEL.Intake.SingleValue(__recs,Headoffice_Branchcodes_);
    SELF.Account_Number_ := KEL.Intake.SingleValue(__recs,Account_Number_);
    SELF.Bank_Hit_ := KEL.Intake.SingleValue(__recs,Bank_Hit_);
    SELF._curr__incar__flag_ := KEL.Intake.SingleValue(__recs,_curr__incar__flag_);
    SELF._off__cat__list_ := KEL.Intake.SingleValue(__recs,_off__cat__list_);
    SELF._name__ssn__dob__match_ := KEL.Intake.SingleValue(__recs,_name__ssn__dob__match_);
    SELF.Ip_Address_ := KEL.Intake.SingleValue(__recs,Ip_Address_);
    SELF._iprngbeg_ := KEL.Intake.SingleValue(__recs,_iprngbeg_);
    SELF._iprngend_ := KEL.Intake.SingleValue(__recs,_iprngend_);
    SELF._edgecountry_ := KEL.Intake.SingleValue(__recs,_edgecountry_);
    SELF._edgeregion_ := KEL.Intake.SingleValue(__recs,_edgeregion_);
    SELF._edgecity_ := KEL.Intake.SingleValue(__recs,_edgecity_);
    SELF._edgeconnspeed_ := KEL.Intake.SingleValue(__recs,_edgeconnspeed_);
    SELF._edgemetrocode_ := KEL.Intake.SingleValue(__recs,_edgemetrocode_);
    SELF._edgelatitude_ := KEL.Intake.SingleValue(__recs,_edgelatitude_);
    SELF._edgelongitude_ := KEL.Intake.SingleValue(__recs,_edgelongitude_);
    SELF._edgepostalcode_ := KEL.Intake.SingleValue(__recs,_edgepostalcode_);
    SELF._edgecountrycode_ := KEL.Intake.SingleValue(__recs,_edgecountrycode_);
    SELF._edgeregioncode_ := KEL.Intake.SingleValue(__recs,_edgeregioncode_);
    SELF._edgecitycode_ := KEL.Intake.SingleValue(__recs,_edgecitycode_);
    SELF._edgecontinentcode_ := KEL.Intake.SingleValue(__recs,_edgecontinentcode_);
    SELF._edgetwolettercountry_ := KEL.Intake.SingleValue(__recs,_edgetwolettercountry_);
    SELF._edgeinternalcode_ := KEL.Intake.SingleValue(__recs,_edgeinternalcode_);
    SELF._edgeareacodes_ := KEL.Intake.SingleValue(__recs,_edgeareacodes_);
    SELF._edgecountryconf_ := KEL.Intake.SingleValue(__recs,_edgecountryconf_);
    SELF._edgeregionconf_ := KEL.Intake.SingleValue(__recs,_edgeregionconf_);
    SELF._edgecitycong_ := KEL.Intake.SingleValue(__recs,_edgecitycong_);
    SELF._edgepostalconf_ := KEL.Intake.SingleValue(__recs,_edgepostalconf_);
    SELF._edgegmtoffset_ := KEL.Intake.SingleValue(__recs,_edgegmtoffset_);
    SELF._edgeindst_ := KEL.Intake.SingleValue(__recs,_edgeindst_);
    SELF._siccode_ := KEL.Intake.SingleValue(__recs,_siccode_);
    SELF._domainname_ := KEL.Intake.SingleValue(__recs,_domainname_);
    SELF._ispname_ := KEL.Intake.SingleValue(__recs,_ispname_);
    SELF._homebiztype_ := KEL.Intake.SingleValue(__recs,_homebiztype_);
    SELF._asn_ := KEL.Intake.SingleValue(__recs,_asn_);
    SELF._asnname_ := KEL.Intake.SingleValue(__recs,_asnname_);
    SELF._primarylang_ := KEL.Intake.SingleValue(__recs,_primarylang_);
    SELF._secondarylang_ := KEL.Intake.SingleValue(__recs,_secondarylang_);
    SELF._proxytype_ := KEL.Intake.SingleValue(__recs,_proxytype_);
    SELF._proxydescription_ := KEL.Intake.SingleValue(__recs,_proxydescription_);
    SELF._isanisp_ := KEL.Intake.SingleValue(__recs,_isanisp_);
    SELF._companyname_ := KEL.Intake.SingleValue(__recs,_companyname_);
    SELF._ranks_ := KEL.Intake.SingleValue(__recs,_ranks_);
    SELF._households_ := KEL.Intake.SingleValue(__recs,_households_);
    SELF._women_ := KEL.Intake.SingleValue(__recs,_women_);
    SELF._women18to34_ := KEL.Intake.SingleValue(__recs,_women18to34_);
    SELF._women35to49_ := KEL.Intake.SingleValue(__recs,_women35to49_);
    SELF._men_ := KEL.Intake.SingleValue(__recs,_men_);
    SELF._men18to34_ := KEL.Intake.SingleValue(__recs,_men18to34_);
    SELF._men35to49_ := KEL.Intake.SingleValue(__recs,_men35to49_);
    SELF._teens_ := KEL.Intake.SingleValue(__recs,_teens_);
    SELF._kids_ := KEL.Intake.SingleValue(__recs,_kids_);
    SELF._naicscode_ := KEL.Intake.SingleValue(__recs,_naicscode_);
    SELF._cbsacode_ := KEL.Intake.SingleValue(__recs,_cbsacode_);
    SELF._cbsatitle_ := KEL.Intake.SingleValue(__recs,_cbsatitle_);
    SELF._cbsatype_ := KEL.Intake.SingleValue(__recs,_cbsatype_);
    SELF._csacode_ := KEL.Intake.SingleValue(__recs,_csacode_);
    SELF._csatitle_ := KEL.Intake.SingleValue(__recs,_csatitle_);
    SELF._mdcode_ := KEL.Intake.SingleValue(__recs,_mdcode_);
    SELF._mdtitle_ := KEL.Intake.SingleValue(__recs,_mdtitle_);
    SELF._organizationname_ := KEL.Intake.SingleValue(__recs,_organizationname_);
    SELF.Confidence__that__activity__was__deceitful__id_ := KEL.Intake.SingleValue(__recs,Confidence__that__activity__was__deceitful__id_);
    SELF._name__risk__code_ := KEL.Intake.SingleValue(__recs,_name__risk__code_);
    SELF._dob__risk__code_ := KEL.Intake.SingleValue(__recs,_dob__risk__code_);
    SELF._ssn__risk__code_ := KEL.Intake.SingleValue(__recs,_ssn__risk__code_);
    SELF._drivers__license__risk__code_ := KEL.Intake.SingleValue(__recs,_drivers__license__risk__code_);
    SELF._physical__address__risk__code_ := KEL.Intake.SingleValue(__recs,_physical__address__risk__code_);
    SELF._phone__risk__code_ := KEL.Intake.SingleValue(__recs,_phone__risk__code_);
    SELF._cell__phone__risk__code_ := KEL.Intake.SingleValue(__recs,_cell__phone__risk__code_);
    SELF._work__phone__risk__code_ := KEL.Intake.SingleValue(__recs,_work__phone__risk__code_);
    SELF._bank__account__1__risk__code_ := KEL.Intake.SingleValue(__recs,_bank__account__1__risk__code_);
    SELF._bank__account__2__risk__code_ := KEL.Intake.SingleValue(__recs,_bank__account__2__risk__code_);
    SELF._email__address__risk__code_ := KEL.Intake.SingleValue(__recs,_email__address__risk__code_);
    SELF._ip__address__fraud__code_ := KEL.Intake.SingleValue(__recs,_ip__address__fraud__code_);
    SELF._business__risk__code_ := KEL.Intake.SingleValue(__recs,_business__risk__code_);
    SELF._mailing__address__risk__code_ := KEL.Intake.SingleValue(__recs,_mailing__address__risk__code_);
    SELF._device__risk__code_ := KEL.Intake.SingleValue(__recs,_device__risk__code_);
    SELF._identity__risk__code_ := KEL.Intake.SingleValue(__recs,_identity__risk__code_);
    SELF._advo__hitflag_ := KEL.Intake.SingleValue(__recs,_advo__hitflag_);
    SELF._advo__vacancyindicator_ := KEL.Intake.SingleValue(__recs,_advo__vacancyindicator_);
    SELF._advo__addressstyle_ := KEL.Intake.SingleValue(__recs,_advo__addressstyle_);
    SELF._advo__dropindicator_ := KEL.Intake.SingleValue(__recs,_advo__dropindicator_);
    SELF._advo__residentialorbusinessindicator_ := KEL.Intake.SingleValue(__recs,_advo__residentialorbusinessindicator_);
    SELF._advo__addresstype_ := KEL.Intake.SingleValue(__recs,_advo__addresstype_);
    SELF._advo__addressusagetype_ := KEL.Intake.SingleValue(__recs,_advo__addressusagetype_);
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Event__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Event_Types_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Event_Types_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Event_Type_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Event_Group,COUNT(ROWS(LEFT))=1),GROUP,Event__Single_Rollup(LEFT)) + ROLLUP(HAVING(Event_Group,COUNT(ROWS(LEFT))>1),GROUP,Event__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::FraudgovKEL::Event::Result',EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT _r_Customer__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_r_Customer_);
  EXPORT _r_Source_Customer__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_r_Source_Customer_);
  EXPORT Subject__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Subject_);
  EXPORT Location__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Location_);
  EXPORT Record_Id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Record_Id_);
  EXPORT Event_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Event_Date_);
  EXPORT _r_Phone__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_r_Phone_);
  EXPORT _r_Email__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_r_Email_);
  EXPORT _r_Internet_Protocol__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_r_Internet_Protocol_);
  EXPORT _r_Bank_Account__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_r_Bank_Account_);
  EXPORT _r_Drivers_License__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_r_Drivers_License_);
  EXPORT _r_Ssn__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_r_Ssn_);
  EXPORT Title__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Title_);
  EXPORT First_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,First_Name_);
  EXPORT Middle_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Middle_Name_);
  EXPORT Last_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Last_Name_);
  EXPORT Name_Suffix__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Name_Suffix_);
  EXPORT _rin__source__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_rin__source_);
  EXPORT Lex_Id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Lex_Id_);
  EXPORT Otto_Address_Id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Otto_Address_Id_);
  EXPORT Date_Of_Birth__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Date_Of_Birth_);
  EXPORT Deceased_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Deceased_Date_);
  EXPORT Deceased_Date_Of_Birth__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Deceased_Date_Of_Birth_);
  EXPORT Deceased_First__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Deceased_First_);
  EXPORT Deceased_Middle__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Deceased_Middle_);
  EXPORT Deceased_Last__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Deceased_Last_);
  EXPORT Phone_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Phone_Number_);
  EXPORT Otto_Email_Id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Otto_Email_Id_);
  EXPORT Otto_Ip_Address_Id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Otto_Ip_Address_Id_);
  EXPORT Otto_S_S_N_Id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Otto_S_S_N_Id_);
  EXPORT Case_Id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Case_Id_);
  EXPORT Otto_Drivers_License_Id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Otto_Drivers_License_Id_);
  EXPORT Deceased_Match_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Deceased_Match_Code_);
  EXPORT _isdeepdive__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_isdeepdive_);
  EXPORT _nap__summary__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_nap__summary_);
  EXPORT _nas__summary__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_nas__summary_);
  EXPORT _cvi__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_cvi_);
  EXPORT _fp3__stolenidentityindex__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_fp3__stolenidentityindex_);
  EXPORT _syntheticidentityindex__v3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_syntheticidentityindex__v3_);
  EXPORT _manipulatedidentityindex__v3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_manipulatedidentityindex__v3_);
  EXPORT _socsdobflag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_socsdobflag_);
  EXPORT _pwsocsdobflag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_pwsocsdobflag_);
  EXPORT _dobmatchlevel__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_dobmatchlevel_);
  EXPORT _sourcerisklevel__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_sourcerisklevel_);
  EXPORT _reason1__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_reason1_);
  EXPORT _reason2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_reason2_);
  EXPORT _reason3__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_reason3_);
  EXPORT _reason4__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_reason4_);
  EXPORT _reason5__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_reason5_);
  EXPORT _reason6__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_reason6_);
  EXPORT _socsvalflag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_socsvalflag_);
  EXPORT _drlcvalflag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_drlcvalflag_);
  EXPORT _hphonevalflag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_hphonevalflag_);
  EXPORT _truedid__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_truedid_);
  EXPORT _best__fname__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_best__fname_);
  EXPORT _best__lname__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_best__lname_);
  EXPORT _best__ssn__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_best__ssn_);
  EXPORT _input__fname__isbestmatch__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_input__fname__isbestmatch_);
  EXPORT _input__lname__isbestmatch__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_input__lname__isbestmatch_);
  EXPORT _input__ssn__isbestmatch__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_input__ssn__isbestmatch_);
  EXPORT _add__curr__pop__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_add__curr__pop_);
  EXPORT _add__curr__prim__range__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_add__curr__prim__range_);
  EXPORT _add__curr__predir__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_add__curr__predir_);
  EXPORT _add__curr__prim__name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_add__curr__prim__name_);
  EXPORT _add__curr__addr__suffix__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_add__curr__addr__suffix_);
  EXPORT _add__curr__postdir__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_add__curr__postdir_);
  EXPORT _add__curr__unit__desig__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_add__curr__unit__desig_);
  EXPORT _add__curr__sec__range__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_add__curr__sec__range_);
  EXPORT _add__curr__city__name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_add__curr__city__name_);
  EXPORT _add__curr__st__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_add__curr__st_);
  EXPORT _add__curr__zip5__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_add__curr__zip5_);
  EXPORT _add__curr__county__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_add__curr__county_);
  EXPORT _add__curr__geo__blk__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_add__curr__geo__blk_);
  EXPORT _add__curr__lat__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_add__curr__lat_);
  EXPORT _add__curr__long__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_add__curr__long_);
  EXPORT _add__input__isbestmatch__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_add__input__isbestmatch_);
  EXPORT _county__death__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_county__death_);
  EXPORT Deceased_Ssn__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Deceased_Ssn_);
  EXPORT _state__death__flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_state__death__flag_);
  EXPORT _death__rec__src__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_death__rec__src_);
  EXPORT _state__death__id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_state__death__id_);
  EXPORT _addresspobox__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_addresspobox_);
  EXPORT _addresscmra__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_addresscmra_);
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
  EXPORT License_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,License_Number_);
  EXPORT License_State__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,License_State_);
  EXPORT Phone_Formatted__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Phone_Formatted_);
  EXPORT Email_Address__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Email_Address_);
  EXPORT Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Type_);
  EXPORT Created_On__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Created_On_);
  EXPORT Host__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Host_);
  EXPORT Email_Last_Domain__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Email_Last_Domain_);
  EXPORT _isdisposableemail__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_isdisposableemail_);
  EXPORT Ssn__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ssn_);
  EXPORT Ssn_Formatted__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ssn_Formatted_);
  EXPORT Routing_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Routing_Number_);
  EXPORT Full_Bankname__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Full_Bankname_);
  EXPORT Abbreviated_Bankname__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Abbreviated_Bankname_);
  EXPORT Fractional_Routingnumber__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fractional_Routingnumber_);
  EXPORT Headoffice_Routingnumber__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Headoffice_Routingnumber_);
  EXPORT Headoffice_Branchcodes__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Headoffice_Branchcodes_);
  EXPORT Account_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Account_Number_);
  EXPORT Bank_Hit__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Bank_Hit_);
  EXPORT _curr__incar__flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_curr__incar__flag_);
  EXPORT _off__cat__list__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_off__cat__list_);
  EXPORT _name__ssn__dob__match__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_name__ssn__dob__match_);
  EXPORT Ip_Address__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ip_Address_);
  EXPORT _iprngbeg__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_iprngbeg_);
  EXPORT _iprngend__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_iprngend_);
  EXPORT _edgecountry__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgecountry_);
  EXPORT _edgeregion__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgeregion_);
  EXPORT _edgecity__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgecity_);
  EXPORT _edgeconnspeed__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgeconnspeed_);
  EXPORT _edgemetrocode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgemetrocode_);
  EXPORT _edgelatitude__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgelatitude_);
  EXPORT _edgelongitude__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgelongitude_);
  EXPORT _edgepostalcode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgepostalcode_);
  EXPORT _edgecountrycode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgecountrycode_);
  EXPORT _edgeregioncode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgeregioncode_);
  EXPORT _edgecitycode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgecitycode_);
  EXPORT _edgecontinentcode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgecontinentcode_);
  EXPORT _edgetwolettercountry__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgetwolettercountry_);
  EXPORT _edgeinternalcode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgeinternalcode_);
  EXPORT _edgeareacodes__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgeareacodes_);
  EXPORT _edgecountryconf__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgecountryconf_);
  EXPORT _edgeregionconf__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgeregionconf_);
  EXPORT _edgecitycong__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgecitycong_);
  EXPORT _edgepostalconf__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgepostalconf_);
  EXPORT _edgegmtoffset__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgegmtoffset_);
  EXPORT _edgeindst__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_edgeindst_);
  EXPORT _siccode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_siccode_);
  EXPORT _domainname__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_domainname_);
  EXPORT _ispname__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_ispname_);
  EXPORT _homebiztype__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_homebiztype_);
  EXPORT _asn__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_asn_);
  EXPORT _asnname__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_asnname_);
  EXPORT _primarylang__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_primarylang_);
  EXPORT _secondarylang__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_secondarylang_);
  EXPORT _proxytype__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_proxytype_);
  EXPORT _proxydescription__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_proxydescription_);
  EXPORT _isanisp__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_isanisp_);
  EXPORT _companyname__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_companyname_);
  EXPORT _ranks__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_ranks_);
  EXPORT _households__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_households_);
  EXPORT _women__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_women_);
  EXPORT _women18to34__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_women18to34_);
  EXPORT _women35to49__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_women35to49_);
  EXPORT _men__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_men_);
  EXPORT _men18to34__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_men18to34_);
  EXPORT _men35to49__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_men35to49_);
  EXPORT _teens__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_teens_);
  EXPORT _kids__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_kids_);
  EXPORT _naicscode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_naicscode_);
  EXPORT _cbsacode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_cbsacode_);
  EXPORT _cbsatitle__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_cbsatitle_);
  EXPORT _cbsatype__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_cbsatype_);
  EXPORT _csacode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_csacode_);
  EXPORT _csatitle__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_csatitle_);
  EXPORT _mdcode__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_mdcode_);
  EXPORT _mdtitle__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_mdtitle_);
  EXPORT _organizationname__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_organizationname_);
  EXPORT Confidence__that__activity__was__deceitful__id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Confidence__that__activity__was__deceitful__id_);
  EXPORT _name__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_name__risk__code_);
  EXPORT _dob__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_dob__risk__code_);
  EXPORT _ssn__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_ssn__risk__code_);
  EXPORT _drivers__license__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_drivers__license__risk__code_);
  EXPORT _physical__address__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_physical__address__risk__code_);
  EXPORT _phone__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_phone__risk__code_);
  EXPORT _cell__phone__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_cell__phone__risk__code_);
  EXPORT _work__phone__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_work__phone__risk__code_);
  EXPORT _bank__account__1__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_bank__account__1__risk__code_);
  EXPORT _bank__account__2__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_bank__account__2__risk__code_);
  EXPORT _email__address__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_email__address__risk__code_);
  EXPORT _ip__address__fraud__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_ip__address__fraud__code_);
  EXPORT _business__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_business__risk__code_);
  EXPORT _mailing__address__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_mailing__address__risk__code_);
  EXPORT _device__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_device__risk__code_);
  EXPORT _identity__risk__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_identity__risk__code_);
  EXPORT _advo__hitflag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_advo__hitflag_);
  EXPORT _advo__vacancyindicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_advo__vacancyindicator_);
  EXPORT _advo__addressstyle__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_advo__addressstyle_);
  EXPORT _advo__dropindicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_advo__dropindicator_);
  EXPORT _advo__residentialorbusinessindicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_advo__residentialorbusinessindicator_);
  EXPORT _advo__addresstype__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_advo__addresstype_);
  EXPORT _advo__addressusagetype__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_advo__addressusagetype_);
  EXPORT _r_Customer__Orphan := JOIN(InData(__NN(_r_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT _r_Source_Customer__Orphan := JOIN(InData(__NN(_r_Source_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Source_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person.__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Location__Orphan := JOIN(InData(__NN(Location_)),E_Address.__Result,__EEQP(LEFT.Location_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT _r_Ssn__Orphan := JOIN(InData(__NN(_r_Ssn_)),E_Social_Security_Number.__Result,__EEQP(LEFT._r_Ssn_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT _r_Phone__Orphan := JOIN(InData(__NN(_r_Phone_)),E_Phone.__Result,__EEQP(LEFT._r_Phone_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT _r_Email__Orphan := JOIN(InData(__NN(_r_Email_)),E_Email.__Result,__EEQP(LEFT._r_Email_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT _r_Internet_Protocol__Orphan := JOIN(InData(__NN(_r_Internet_Protocol_)),E_Internet_Protocol.__Result,__EEQP(LEFT._r_Internet_Protocol_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT _r_Bank_Account__Orphan := JOIN(InData(__NN(_r_Bank_Account_)),E_Bank_Account.__Result,__EEQP(LEFT._r_Bank_Account_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT _r_Drivers_License__Orphan := JOIN(InData(__NN(_r_Drivers_License_)),E_Drivers_License.__Result,__EEQP(LEFT._r_Drivers_License_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(_r_Customer__Orphan),COUNT(_r_Source_Customer__Orphan),COUNT(Subject__Orphan),COUNT(Location__Orphan),COUNT(_r_Ssn__Orphan),COUNT(_r_Phone__Orphan),COUNT(_r_Email__Orphan),COUNT(_r_Internet_Protocol__Orphan),COUNT(_r_Bank_Account__Orphan),COUNT(_r_Drivers_License__Orphan),COUNT(FraudgovKEL_fraudgovshared_Invalid),COUNT(FraudgovKEL_PersonEventTypes_Invalid),COUNT(_r_Customer__SingleValue_Invalid),COUNT(_r_Source_Customer__SingleValue_Invalid),COUNT(Subject__SingleValue_Invalid),COUNT(Location__SingleValue_Invalid),COUNT(Record_Id__SingleValue_Invalid),COUNT(Event_Date__SingleValue_Invalid),COUNT(_r_Phone__SingleValue_Invalid),COUNT(_r_Email__SingleValue_Invalid),COUNT(_r_Internet_Protocol__SingleValue_Invalid),COUNT(_r_Bank_Account__SingleValue_Invalid),COUNT(_r_Drivers_License__SingleValue_Invalid),COUNT(_r_Ssn__SingleValue_Invalid),COUNT(Title__SingleValue_Invalid),COUNT(First_Name__SingleValue_Invalid),COUNT(Middle_Name__SingleValue_Invalid),COUNT(Last_Name__SingleValue_Invalid),COUNT(Name_Suffix__SingleValue_Invalid),COUNT(_rin__source__SingleValue_Invalid),COUNT(Lex_Id__SingleValue_Invalid),COUNT(Otto_Address_Id__SingleValue_Invalid),COUNT(Date_Of_Birth__SingleValue_Invalid),COUNT(Deceased_Date__SingleValue_Invalid),COUNT(Deceased_Date_Of_Birth__SingleValue_Invalid),COUNT(Deceased_First__SingleValue_Invalid),COUNT(Deceased_Middle__SingleValue_Invalid),COUNT(Deceased_Last__SingleValue_Invalid),COUNT(Phone_Number__SingleValue_Invalid),COUNT(Otto_Email_Id__SingleValue_Invalid),COUNT(Otto_Ip_Address_Id__SingleValue_Invalid),COUNT(Otto_S_S_N_Id__SingleValue_Invalid),COUNT(Case_Id__SingleValue_Invalid),COUNT(Otto_Drivers_License_Id__SingleValue_Invalid),COUNT(Deceased_Match_Code__SingleValue_Invalid),COUNT(_isdeepdive__SingleValue_Invalid),COUNT(_nap__summary__SingleValue_Invalid),COUNT(_nas__summary__SingleValue_Invalid),COUNT(_cvi__SingleValue_Invalid),COUNT(_fp3__stolenidentityindex__SingleValue_Invalid),COUNT(_syntheticidentityindex__v3__SingleValue_Invalid),COUNT(_manipulatedidentityindex__v3__SingleValue_Invalid),COUNT(_socsdobflag__SingleValue_Invalid),COUNT(_pwsocsdobflag__SingleValue_Invalid),COUNT(_dobmatchlevel__SingleValue_Invalid),COUNT(_sourcerisklevel__SingleValue_Invalid),COUNT(_reason1__SingleValue_Invalid),COUNT(_reason2__SingleValue_Invalid),COUNT(_reason3__SingleValue_Invalid),COUNT(_reason4__SingleValue_Invalid),COUNT(_reason5__SingleValue_Invalid),COUNT(_reason6__SingleValue_Invalid),COUNT(_socsvalflag__SingleValue_Invalid),COUNT(_drlcvalflag__SingleValue_Invalid),COUNT(_hphonevalflag__SingleValue_Invalid),COUNT(_truedid__SingleValue_Invalid),COUNT(_best__fname__SingleValue_Invalid),COUNT(_best__lname__SingleValue_Invalid),COUNT(_best__ssn__SingleValue_Invalid),COUNT(_input__fname__isbestmatch__SingleValue_Invalid),COUNT(_input__lname__isbestmatch__SingleValue_Invalid),COUNT(_input__ssn__isbestmatch__SingleValue_Invalid),COUNT(_add__curr__pop__SingleValue_Invalid),COUNT(_add__curr__prim__range__SingleValue_Invalid),COUNT(_add__curr__predir__SingleValue_Invalid),COUNT(_add__curr__prim__name__SingleValue_Invalid),COUNT(_add__curr__addr__suffix__SingleValue_Invalid),COUNT(_add__curr__postdir__SingleValue_Invalid),COUNT(_add__curr__unit__desig__SingleValue_Invalid),COUNT(_add__curr__sec__range__SingleValue_Invalid),COUNT(_add__curr__city__name__SingleValue_Invalid),COUNT(_add__curr__st__SingleValue_Invalid),COUNT(_add__curr__zip5__SingleValue_Invalid),COUNT(_add__curr__county__SingleValue_Invalid),COUNT(_add__curr__geo__blk__SingleValue_Invalid),COUNT(_add__curr__lat__SingleValue_Invalid),COUNT(_add__curr__long__SingleValue_Invalid),COUNT(_add__input__isbestmatch__SingleValue_Invalid),COUNT(_county__death__SingleValue_Invalid),COUNT(Deceased_Ssn__SingleValue_Invalid),COUNT(_state__death__flag__SingleValue_Invalid),COUNT(_death__rec__src__SingleValue_Invalid),COUNT(_state__death__id__SingleValue_Invalid),COUNT(_addresspobox__SingleValue_Invalid),COUNT(_addresscmra__SingleValue_Invalid),COUNT(Primary_Range__SingleValue_Invalid),COUNT(Predirectional__SingleValue_Invalid),COUNT(Primary_Name__SingleValue_Invalid),COUNT(Suffix__SingleValue_Invalid),COUNT(Postdirectional__SingleValue_Invalid),COUNT(Unit_Designation__SingleValue_Invalid),COUNT(Secondary_Range__SingleValue_Invalid),COUNT(Postal_City__SingleValue_Invalid),COUNT(Vanity_City__SingleValue_Invalid),COUNT(State__SingleValue_Invalid),COUNT(Zip__SingleValue_Invalid),COUNT(Zip4__SingleValue_Invalid),COUNT(Carrier_Route_Number__SingleValue_Invalid),COUNT(Carrier_Route_Sortation_At_Z_I_P__SingleValue_Invalid),COUNT(Line_Of_Travel__SingleValue_Invalid),COUNT(Line_Of_Travel_Order__SingleValue_Invalid),COUNT(Delivery_Point_Barcode__SingleValue_Invalid),COUNT(Delivery_Point_Barcode_Check_Digit__SingleValue_Invalid),COUNT(Type_Code__SingleValue_Invalid),COUNT(County__SingleValue_Invalid),COUNT(Latitude__SingleValue_Invalid),COUNT(Longitude__SingleValue_Invalid),COUNT(Metropolitan_Statistical_Area__SingleValue_Invalid),COUNT(Geo_Block__SingleValue_Invalid),COUNT(Geo_Match__SingleValue_Invalid),COUNT(A_C_E_Cleaner_Error_Code__SingleValue_Invalid),COUNT(_is_Additional__SingleValue_Invalid),COUNT(License_Number__SingleValue_Invalid),COUNT(License_State__SingleValue_Invalid),COUNT(Phone_Formatted__SingleValue_Invalid),COUNT(Email_Address__SingleValue_Invalid),COUNT(Type__SingleValue_Invalid),COUNT(Created_On__SingleValue_Invalid),COUNT(Host__SingleValue_Invalid),COUNT(Email_Last_Domain__SingleValue_Invalid),COUNT(_isdisposableemail__SingleValue_Invalid),COUNT(Ssn__SingleValue_Invalid),COUNT(Ssn_Formatted__SingleValue_Invalid),COUNT(Routing_Number__SingleValue_Invalid),COUNT(Full_Bankname__SingleValue_Invalid),COUNT(Abbreviated_Bankname__SingleValue_Invalid),COUNT(Fractional_Routingnumber__SingleValue_Invalid),COUNT(Headoffice_Routingnumber__SingleValue_Invalid),COUNT(Headoffice_Branchcodes__SingleValue_Invalid),COUNT(Account_Number__SingleValue_Invalid),COUNT(Bank_Hit__SingleValue_Invalid),COUNT(_curr__incar__flag__SingleValue_Invalid),COUNT(_off__cat__list__SingleValue_Invalid),COUNT(_name__ssn__dob__match__SingleValue_Invalid),COUNT(Ip_Address__SingleValue_Invalid),COUNT(_iprngbeg__SingleValue_Invalid),COUNT(_iprngend__SingleValue_Invalid),COUNT(_edgecountry__SingleValue_Invalid),COUNT(_edgeregion__SingleValue_Invalid),COUNT(_edgecity__SingleValue_Invalid),COUNT(_edgeconnspeed__SingleValue_Invalid),COUNT(_edgemetrocode__SingleValue_Invalid),COUNT(_edgelatitude__SingleValue_Invalid),COUNT(_edgelongitude__SingleValue_Invalid),COUNT(_edgepostalcode__SingleValue_Invalid),COUNT(_edgecountrycode__SingleValue_Invalid),COUNT(_edgeregioncode__SingleValue_Invalid),COUNT(_edgecitycode__SingleValue_Invalid),COUNT(_edgecontinentcode__SingleValue_Invalid),COUNT(_edgetwolettercountry__SingleValue_Invalid),COUNT(_edgeinternalcode__SingleValue_Invalid),COUNT(_edgeareacodes__SingleValue_Invalid),COUNT(_edgecountryconf__SingleValue_Invalid),COUNT(_edgeregionconf__SingleValue_Invalid),COUNT(_edgecitycong__SingleValue_Invalid),COUNT(_edgepostalconf__SingleValue_Invalid),COUNT(_edgegmtoffset__SingleValue_Invalid),COUNT(_edgeindst__SingleValue_Invalid),COUNT(_siccode__SingleValue_Invalid),COUNT(_domainname__SingleValue_Invalid),COUNT(_ispname__SingleValue_Invalid),COUNT(_homebiztype__SingleValue_Invalid),COUNT(_asn__SingleValue_Invalid),COUNT(_asnname__SingleValue_Invalid),COUNT(_primarylang__SingleValue_Invalid),COUNT(_secondarylang__SingleValue_Invalid),COUNT(_proxytype__SingleValue_Invalid),COUNT(_proxydescription__SingleValue_Invalid),COUNT(_isanisp__SingleValue_Invalid),COUNT(_companyname__SingleValue_Invalid),COUNT(_ranks__SingleValue_Invalid),COUNT(_households__SingleValue_Invalid),COUNT(_women__SingleValue_Invalid),COUNT(_women18to34__SingleValue_Invalid),COUNT(_women35to49__SingleValue_Invalid),COUNT(_men__SingleValue_Invalid),COUNT(_men18to34__SingleValue_Invalid),COUNT(_men35to49__SingleValue_Invalid),COUNT(_teens__SingleValue_Invalid),COUNT(_kids__SingleValue_Invalid),COUNT(_naicscode__SingleValue_Invalid),COUNT(_cbsacode__SingleValue_Invalid),COUNT(_cbsatitle__SingleValue_Invalid),COUNT(_cbsatype__SingleValue_Invalid),COUNT(_csacode__SingleValue_Invalid),COUNT(_csatitle__SingleValue_Invalid),COUNT(_mdcode__SingleValue_Invalid),COUNT(_mdtitle__SingleValue_Invalid),COUNT(_organizationname__SingleValue_Invalid),COUNT(Confidence__that__activity__was__deceitful__id__SingleValue_Invalid),COUNT(_name__risk__code__SingleValue_Invalid),COUNT(_dob__risk__code__SingleValue_Invalid),COUNT(_ssn__risk__code__SingleValue_Invalid),COUNT(_drivers__license__risk__code__SingleValue_Invalid),COUNT(_physical__address__risk__code__SingleValue_Invalid),COUNT(_phone__risk__code__SingleValue_Invalid),COUNT(_cell__phone__risk__code__SingleValue_Invalid),COUNT(_work__phone__risk__code__SingleValue_Invalid),COUNT(_bank__account__1__risk__code__SingleValue_Invalid),COUNT(_bank__account__2__risk__code__SingleValue_Invalid),COUNT(_email__address__risk__code__SingleValue_Invalid),COUNT(_ip__address__fraud__code__SingleValue_Invalid),COUNT(_business__risk__code__SingleValue_Invalid),COUNT(_mailing__address__risk__code__SingleValue_Invalid),COUNT(_device__risk__code__SingleValue_Invalid),COUNT(_identity__risk__code__SingleValue_Invalid),COUNT(_advo__hitflag__SingleValue_Invalid),COUNT(_advo__vacancyindicator__SingleValue_Invalid),COUNT(_advo__addressstyle__SingleValue_Invalid),COUNT(_advo__dropindicator__SingleValue_Invalid),COUNT(_advo__residentialorbusinessindicator__SingleValue_Invalid),COUNT(_advo__addresstype__SingleValue_Invalid),COUNT(_advo__addressusagetype__SingleValue_Invalid)}],{KEL.typ.int _r_Customer__Orphan,KEL.typ.int _r_Source_Customer__Orphan,KEL.typ.int Subject__Orphan,KEL.typ.int Location__Orphan,KEL.typ.int _r_Ssn__Orphan,KEL.typ.int _r_Phone__Orphan,KEL.typ.int _r_Email__Orphan,KEL.typ.int _r_Internet_Protocol__Orphan,KEL.typ.int _r_Bank_Account__Orphan,KEL.typ.int _r_Drivers_License__Orphan,KEL.typ.int FraudgovKEL_fraudgovshared_Invalid,KEL.typ.int FraudgovKEL_PersonEventTypes_Invalid,KEL.typ.int _r_Customer__SingleValue_Invalid,KEL.typ.int _r_Source_Customer__SingleValue_Invalid,KEL.typ.int Subject__SingleValue_Invalid,KEL.typ.int Location__SingleValue_Invalid,KEL.typ.int Record_Id__SingleValue_Invalid,KEL.typ.int Event_Date__SingleValue_Invalid,KEL.typ.int _r_Phone__SingleValue_Invalid,KEL.typ.int _r_Email__SingleValue_Invalid,KEL.typ.int _r_Internet_Protocol__SingleValue_Invalid,KEL.typ.int _r_Bank_Account__SingleValue_Invalid,KEL.typ.int _r_Drivers_License__SingleValue_Invalid,KEL.typ.int _r_Ssn__SingleValue_Invalid,KEL.typ.int Title__SingleValue_Invalid,KEL.typ.int First_Name__SingleValue_Invalid,KEL.typ.int Middle_Name__SingleValue_Invalid,KEL.typ.int Last_Name__SingleValue_Invalid,KEL.typ.int Name_Suffix__SingleValue_Invalid,KEL.typ.int _rin__source__SingleValue_Invalid,KEL.typ.int Lex_Id__SingleValue_Invalid,KEL.typ.int Otto_Address_Id__SingleValue_Invalid,KEL.typ.int Date_Of_Birth__SingleValue_Invalid,KEL.typ.int Deceased_Date__SingleValue_Invalid,KEL.typ.int Deceased_Date_Of_Birth__SingleValue_Invalid,KEL.typ.int Deceased_First__SingleValue_Invalid,KEL.typ.int Deceased_Middle__SingleValue_Invalid,KEL.typ.int Deceased_Last__SingleValue_Invalid,KEL.typ.int Phone_Number__SingleValue_Invalid,KEL.typ.int Otto_Email_Id__SingleValue_Invalid,KEL.typ.int Otto_Ip_Address_Id__SingleValue_Invalid,KEL.typ.int Otto_S_S_N_Id__SingleValue_Invalid,KEL.typ.int Case_Id__SingleValue_Invalid,KEL.typ.int Otto_Drivers_License_Id__SingleValue_Invalid,KEL.typ.int Deceased_Match_Code__SingleValue_Invalid,KEL.typ.int _isdeepdive__SingleValue_Invalid,KEL.typ.int _nap__summary__SingleValue_Invalid,KEL.typ.int _nas__summary__SingleValue_Invalid,KEL.typ.int _cvi__SingleValue_Invalid,KEL.typ.int _fp3__stolenidentityindex__SingleValue_Invalid,KEL.typ.int _syntheticidentityindex__v3__SingleValue_Invalid,KEL.typ.int _manipulatedidentityindex__v3__SingleValue_Invalid,KEL.typ.int _socsdobflag__SingleValue_Invalid,KEL.typ.int _pwsocsdobflag__SingleValue_Invalid,KEL.typ.int _dobmatchlevel__SingleValue_Invalid,KEL.typ.int _sourcerisklevel__SingleValue_Invalid,KEL.typ.int _reason1__SingleValue_Invalid,KEL.typ.int _reason2__SingleValue_Invalid,KEL.typ.int _reason3__SingleValue_Invalid,KEL.typ.int _reason4__SingleValue_Invalid,KEL.typ.int _reason5__SingleValue_Invalid,KEL.typ.int _reason6__SingleValue_Invalid,KEL.typ.int _socsvalflag__SingleValue_Invalid,KEL.typ.int _drlcvalflag__SingleValue_Invalid,KEL.typ.int _hphonevalflag__SingleValue_Invalid,KEL.typ.int _truedid__SingleValue_Invalid,KEL.typ.int _best__fname__SingleValue_Invalid,KEL.typ.int _best__lname__SingleValue_Invalid,KEL.typ.int _best__ssn__SingleValue_Invalid,KEL.typ.int _input__fname__isbestmatch__SingleValue_Invalid,KEL.typ.int _input__lname__isbestmatch__SingleValue_Invalid,KEL.typ.int _input__ssn__isbestmatch__SingleValue_Invalid,KEL.typ.int _add__curr__pop__SingleValue_Invalid,KEL.typ.int _add__curr__prim__range__SingleValue_Invalid,KEL.typ.int _add__curr__predir__SingleValue_Invalid,KEL.typ.int _add__curr__prim__name__SingleValue_Invalid,KEL.typ.int _add__curr__addr__suffix__SingleValue_Invalid,KEL.typ.int _add__curr__postdir__SingleValue_Invalid,KEL.typ.int _add__curr__unit__desig__SingleValue_Invalid,KEL.typ.int _add__curr__sec__range__SingleValue_Invalid,KEL.typ.int _add__curr__city__name__SingleValue_Invalid,KEL.typ.int _add__curr__st__SingleValue_Invalid,KEL.typ.int _add__curr__zip5__SingleValue_Invalid,KEL.typ.int _add__curr__county__SingleValue_Invalid,KEL.typ.int _add__curr__geo__blk__SingleValue_Invalid,KEL.typ.int _add__curr__lat__SingleValue_Invalid,KEL.typ.int _add__curr__long__SingleValue_Invalid,KEL.typ.int _add__input__isbestmatch__SingleValue_Invalid,KEL.typ.int _county__death__SingleValue_Invalid,KEL.typ.int Deceased_Ssn__SingleValue_Invalid,KEL.typ.int _state__death__flag__SingleValue_Invalid,KEL.typ.int _death__rec__src__SingleValue_Invalid,KEL.typ.int _state__death__id__SingleValue_Invalid,KEL.typ.int _addresspobox__SingleValue_Invalid,KEL.typ.int _addresscmra__SingleValue_Invalid,KEL.typ.int Primary_Range__SingleValue_Invalid,KEL.typ.int Predirectional__SingleValue_Invalid,KEL.typ.int Primary_Name__SingleValue_Invalid,KEL.typ.int Suffix__SingleValue_Invalid,KEL.typ.int Postdirectional__SingleValue_Invalid,KEL.typ.int Unit_Designation__SingleValue_Invalid,KEL.typ.int Secondary_Range__SingleValue_Invalid,KEL.typ.int Postal_City__SingleValue_Invalid,KEL.typ.int Vanity_City__SingleValue_Invalid,KEL.typ.int State__SingleValue_Invalid,KEL.typ.int Zip__SingleValue_Invalid,KEL.typ.int Zip4__SingleValue_Invalid,KEL.typ.int Carrier_Route_Number__SingleValue_Invalid,KEL.typ.int Carrier_Route_Sortation_At_Z_I_P__SingleValue_Invalid,KEL.typ.int Line_Of_Travel__SingleValue_Invalid,KEL.typ.int Line_Of_Travel_Order__SingleValue_Invalid,KEL.typ.int Delivery_Point_Barcode__SingleValue_Invalid,KEL.typ.int Delivery_Point_Barcode_Check_Digit__SingleValue_Invalid,KEL.typ.int Type_Code__SingleValue_Invalid,KEL.typ.int County__SingleValue_Invalid,KEL.typ.int Latitude__SingleValue_Invalid,KEL.typ.int Longitude__SingleValue_Invalid,KEL.typ.int Metropolitan_Statistical_Area__SingleValue_Invalid,KEL.typ.int Geo_Block__SingleValue_Invalid,KEL.typ.int Geo_Match__SingleValue_Invalid,KEL.typ.int A_C_E_Cleaner_Error_Code__SingleValue_Invalid,KEL.typ.int _is_Additional__SingleValue_Invalid,KEL.typ.int License_Number__SingleValue_Invalid,KEL.typ.int License_State__SingleValue_Invalid,KEL.typ.int Phone_Formatted__SingleValue_Invalid,KEL.typ.int Email_Address__SingleValue_Invalid,KEL.typ.int Type__SingleValue_Invalid,KEL.typ.int Created_On__SingleValue_Invalid,KEL.typ.int Host__SingleValue_Invalid,KEL.typ.int Email_Last_Domain__SingleValue_Invalid,KEL.typ.int _isdisposableemail__SingleValue_Invalid,KEL.typ.int Ssn__SingleValue_Invalid,KEL.typ.int Ssn_Formatted__SingleValue_Invalid,KEL.typ.int Routing_Number__SingleValue_Invalid,KEL.typ.int Full_Bankname__SingleValue_Invalid,KEL.typ.int Abbreviated_Bankname__SingleValue_Invalid,KEL.typ.int Fractional_Routingnumber__SingleValue_Invalid,KEL.typ.int Headoffice_Routingnumber__SingleValue_Invalid,KEL.typ.int Headoffice_Branchcodes__SingleValue_Invalid,KEL.typ.int Account_Number__SingleValue_Invalid,KEL.typ.int Bank_Hit__SingleValue_Invalid,KEL.typ.int _curr__incar__flag__SingleValue_Invalid,KEL.typ.int _off__cat__list__SingleValue_Invalid,KEL.typ.int _name__ssn__dob__match__SingleValue_Invalid,KEL.typ.int Ip_Address__SingleValue_Invalid,KEL.typ.int _iprngbeg__SingleValue_Invalid,KEL.typ.int _iprngend__SingleValue_Invalid,KEL.typ.int _edgecountry__SingleValue_Invalid,KEL.typ.int _edgeregion__SingleValue_Invalid,KEL.typ.int _edgecity__SingleValue_Invalid,KEL.typ.int _edgeconnspeed__SingleValue_Invalid,KEL.typ.int _edgemetrocode__SingleValue_Invalid,KEL.typ.int _edgelatitude__SingleValue_Invalid,KEL.typ.int _edgelongitude__SingleValue_Invalid,KEL.typ.int _edgepostalcode__SingleValue_Invalid,KEL.typ.int _edgecountrycode__SingleValue_Invalid,KEL.typ.int _edgeregioncode__SingleValue_Invalid,KEL.typ.int _edgecitycode__SingleValue_Invalid,KEL.typ.int _edgecontinentcode__SingleValue_Invalid,KEL.typ.int _edgetwolettercountry__SingleValue_Invalid,KEL.typ.int _edgeinternalcode__SingleValue_Invalid,KEL.typ.int _edgeareacodes__SingleValue_Invalid,KEL.typ.int _edgecountryconf__SingleValue_Invalid,KEL.typ.int _edgeregionconf__SingleValue_Invalid,KEL.typ.int _edgecitycong__SingleValue_Invalid,KEL.typ.int _edgepostalconf__SingleValue_Invalid,KEL.typ.int _edgegmtoffset__SingleValue_Invalid,KEL.typ.int _edgeindst__SingleValue_Invalid,KEL.typ.int _siccode__SingleValue_Invalid,KEL.typ.int _domainname__SingleValue_Invalid,KEL.typ.int _ispname__SingleValue_Invalid,KEL.typ.int _homebiztype__SingleValue_Invalid,KEL.typ.int _asn__SingleValue_Invalid,KEL.typ.int _asnname__SingleValue_Invalid,KEL.typ.int _primarylang__SingleValue_Invalid,KEL.typ.int _secondarylang__SingleValue_Invalid,KEL.typ.int _proxytype__SingleValue_Invalid,KEL.typ.int _proxydescription__SingleValue_Invalid,KEL.typ.int _isanisp__SingleValue_Invalid,KEL.typ.int _companyname__SingleValue_Invalid,KEL.typ.int _ranks__SingleValue_Invalid,KEL.typ.int _households__SingleValue_Invalid,KEL.typ.int _women__SingleValue_Invalid,KEL.typ.int _women18to34__SingleValue_Invalid,KEL.typ.int _women35to49__SingleValue_Invalid,KEL.typ.int _men__SingleValue_Invalid,KEL.typ.int _men18to34__SingleValue_Invalid,KEL.typ.int _men35to49__SingleValue_Invalid,KEL.typ.int _teens__SingleValue_Invalid,KEL.typ.int _kids__SingleValue_Invalid,KEL.typ.int _naicscode__SingleValue_Invalid,KEL.typ.int _cbsacode__SingleValue_Invalid,KEL.typ.int _cbsatitle__SingleValue_Invalid,KEL.typ.int _cbsatype__SingleValue_Invalid,KEL.typ.int _csacode__SingleValue_Invalid,KEL.typ.int _csatitle__SingleValue_Invalid,KEL.typ.int _mdcode__SingleValue_Invalid,KEL.typ.int _mdtitle__SingleValue_Invalid,KEL.typ.int _organizationname__SingleValue_Invalid,KEL.typ.int Confidence__that__activity__was__deceitful__id__SingleValue_Invalid,KEL.typ.int _name__risk__code__SingleValue_Invalid,KEL.typ.int _dob__risk__code__SingleValue_Invalid,KEL.typ.int _ssn__risk__code__SingleValue_Invalid,KEL.typ.int _drivers__license__risk__code__SingleValue_Invalid,KEL.typ.int _physical__address__risk__code__SingleValue_Invalid,KEL.typ.int _phone__risk__code__SingleValue_Invalid,KEL.typ.int _cell__phone__risk__code__SingleValue_Invalid,KEL.typ.int _work__phone__risk__code__SingleValue_Invalid,KEL.typ.int _bank__account__1__risk__code__SingleValue_Invalid,KEL.typ.int _bank__account__2__risk__code__SingleValue_Invalid,KEL.typ.int _email__address__risk__code__SingleValue_Invalid,KEL.typ.int _ip__address__fraud__code__SingleValue_Invalid,KEL.typ.int _business__risk__code__SingleValue_Invalid,KEL.typ.int _mailing__address__risk__code__SingleValue_Invalid,KEL.typ.int _device__risk__code__SingleValue_Invalid,KEL.typ.int _identity__risk__code__SingleValue_Invalid,KEL.typ.int _advo__hitflag__SingleValue_Invalid,KEL.typ.int _advo__vacancyindicator__SingleValue_Invalid,KEL.typ.int _advo__addressstyle__SingleValue_Invalid,KEL.typ.int _advo__dropindicator__SingleValue_Invalid,KEL.typ.int _advo__residentialorbusinessindicator__SingleValue_Invalid,KEL.typ.int _advo__addresstype__SingleValue_Invalid,KEL.typ.int _advo__addressusagetype__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Event','FraudgovKEL.fraudgovshared','UID',COUNT(FraudgovKEL_fraudgovshared_Invalid),COUNT(__d0)},
    {'Event','FraudgovKEL.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d0(__NL(_r_Customer_))),COUNT(__d0(__NN(_r_Customer_)))},
    {'Event','FraudgovKEL.fraudgovshared','SourceCustomerFileInfo',COUNT(__d0(__NL(_r_Source_Customer_))),COUNT(__d0(__NN(_r_Source_Customer_)))},
    {'Event','FraudgovKEL.fraudgovshared','Subject',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'Event','FraudgovKEL.fraudgovshared','Location',COUNT(__d0(__NL(Location_))),COUNT(__d0(__NN(Location_)))},
    {'Event','FraudgovKEL.fraudgovshared','rSsn',COUNT(__d0(__NL(_r_Ssn_))),COUNT(__d0(__NN(_r_Ssn_)))},
    {'Event','FraudgovKEL.fraudgovshared','rPhone',COUNT(__d0(__NL(_r_Phone_))),COUNT(__d0(__NN(_r_Phone_)))},
    {'Event','FraudgovKEL.fraudgovshared','rEmail',COUNT(__d0(__NL(_r_Email_))),COUNT(__d0(__NN(_r_Email_)))},
    {'Event','FraudgovKEL.fraudgovshared','rInternetProtocol',COUNT(__d0(__NL(_r_Internet_Protocol_))),COUNT(__d0(__NN(_r_Internet_Protocol_)))},
    {'Event','FraudgovKEL.fraudgovshared','rBankAccount',COUNT(__d0(__NL(_r_Bank_Account_))),COUNT(__d0(__NN(_r_Bank_Account_)))},
    {'Event','FraudgovKEL.fraudgovshared','rDriversLicense',COUNT(__d0(__NL(_r_Drivers_License_))),COUNT(__d0(__NN(_r_Drivers_License_)))},
    {'Event','FraudgovKEL.fraudgovshared','rin_source',COUNT(__d0(__NL(_rin__source_))),COUNT(__d0(__NN(_rin__source_)))},
    {'Event','FraudgovKEL.fraudgovshared','did',COUNT(__d0(__NL(Lex_Id_))),COUNT(__d0(__NN(Lex_Id_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_phones.phone_number',COUNT(__d0(__NL(Phone_Number_))),COUNT(__d0(__NN(Phone_Number_)))},
    {'Event','FraudgovKEL.fraudgovshared','OttoAddressId',COUNT(__d0(__NL(Otto_Address_Id_))),COUNT(__d0(__NN(Otto_Address_Id_)))},
    {'Event','FraudgovKEL.fraudgovshared','OttoEmailId',COUNT(__d0(__NL(Otto_Email_Id_))),COUNT(__d0(__NN(Otto_Email_Id_)))},
    {'Event','FraudgovKEL.fraudgovshared','OttoIpAddressId',COUNT(__d0(__NL(Otto_Ip_Address_Id_))),COUNT(__d0(__NN(Otto_Ip_Address_Id_)))},
    {'Event','FraudgovKEL.fraudgovshared','OttoDriversLicenseId',COUNT(__d0(__NL(Otto_Drivers_License_Id_))),COUNT(__d0(__NN(Otto_Drivers_License_Id_)))},
    {'Event','FraudgovKEL.fraudgovshared','OttoSSNId',COUNT(__d0(__NL(Otto_S_S_N_Id_))),COUNT(__d0(__NN(Otto_S_S_N_Id_)))},
    {'Event','FraudgovKEL.fraudgovshared','household_id',COUNT(__d0(__NL(Case_Id_))),COUNT(__d0(__NN(Case_Id_)))},
    {'Event','FraudgovKEL.fraudgovshared','record_id',COUNT(__d0(__NL(Record_Id_))),COUNT(__d0(__NN(Record_Id_)))},
    {'Event','FraudgovKEL.fraudgovshared','event_date',COUNT(__d0(__NL(Event_Date_))),COUNT(__d0(__NN(Event_Date_)))},
    {'Event','FraudgovKEL.fraudgovshared','EventType',COUNT(__d0(__NL(Event_Type_))),COUNT(__d0(__NN(Event_Type_)))},
    {'Event','FraudgovKEL.fraudgovshared','cleaned_name.title',COUNT(__d0(__NL(Title_))),COUNT(__d0(__NN(Title_)))},
    {'Event','FraudgovKEL.fraudgovshared','cleaned_name.fname',COUNT(__d0(__NL(First_Name_))),COUNT(__d0(__NN(First_Name_)))},
    {'Event','FraudgovKEL.fraudgovshared','cleaned_name.mname',COUNT(__d0(__NL(Middle_Name_))),COUNT(__d0(__NN(Middle_Name_)))},
    {'Event','FraudgovKEL.fraudgovshared','cleaned_name.lname',COUNT(__d0(__NL(Last_Name_))),COUNT(__d0(__NN(Last_Name_)))},
    {'Event','FraudgovKEL.fraudgovshared','cleaned_name.name_suffix',COUNT(__d0(__NL(Name_Suffix_))),COUNT(__d0(__NN(Name_Suffix_)))},
    {'Event','FraudgovKEL.fraudgovshared','addresspobox',COUNT(__d0(__NL(_addresspobox_))),COUNT(__d0(__NN(_addresspobox_)))},
    {'Event','FraudgovKEL.fraudgovshared','addresscmra',COUNT(__d0(__NL(_addresscmra_))),COUNT(__d0(__NN(_addresscmra_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.prim_range',COUNT(__d0(__NL(Primary_Range_))),COUNT(__d0(__NN(Primary_Range_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.predir',COUNT(__d0(__NL(Predirectional_))),COUNT(__d0(__NN(Predirectional_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.prim_name',COUNT(__d0(__NL(Primary_Name_))),COUNT(__d0(__NN(Primary_Name_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.addr_suffix',COUNT(__d0(__NL(Suffix_))),COUNT(__d0(__NN(Suffix_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.postdir',COUNT(__d0(__NL(Postdirectional_))),COUNT(__d0(__NN(Postdirectional_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.unit_desig',COUNT(__d0(__NL(Unit_Designation_))),COUNT(__d0(__NN(Unit_Designation_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.sec_range',COUNT(__d0(__NL(Secondary_Range_))),COUNT(__d0(__NN(Secondary_Range_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.p_city_name',COUNT(__d0(__NL(Postal_City_))),COUNT(__d0(__NN(Postal_City_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.v_city_name',COUNT(__d0(__NL(Vanity_City_))),COUNT(__d0(__NN(Vanity_City_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.st',COUNT(__d0(__NL(State_))),COUNT(__d0(__NN(State_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.zip',COUNT(__d0(__NL(Zip_))),COUNT(__d0(__NN(Zip_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.zip4',COUNT(__d0(__NL(Zip4_))),COUNT(__d0(__NN(Zip4_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.cart',COUNT(__d0(__NL(Carrier_Route_Number_))),COUNT(__d0(__NN(Carrier_Route_Number_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.cr_sort_sz',COUNT(__d0(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d0(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.lot',COUNT(__d0(__NL(Line_Of_Travel_))),COUNT(__d0(__NN(Line_Of_Travel_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.lot_order',COUNT(__d0(__NL(Line_Of_Travel_Order_))),COUNT(__d0(__NN(Line_Of_Travel_Order_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.dbpc',COUNT(__d0(__NL(Delivery_Point_Barcode_))),COUNT(__d0(__NN(Delivery_Point_Barcode_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.chk_digit',COUNT(__d0(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d0(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.rec_type',COUNT(__d0(__NL(Type_Code_))),COUNT(__d0(__NN(Type_Code_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.fips_county',COUNT(__d0(__NL(County_))),COUNT(__d0(__NN(County_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.geo_lat',COUNT(__d0(__NL(Latitude_))),COUNT(__d0(__NN(Latitude_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.geo_long',COUNT(__d0(__NL(Longitude_))),COUNT(__d0(__NN(Longitude_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.msa',COUNT(__d0(__NL(Metropolitan_Statistical_Area_))),COUNT(__d0(__NN(Metropolitan_Statistical_Area_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.geo_blk',COUNT(__d0(__NL(Geo_Block_))),COUNT(__d0(__NN(Geo_Block_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.geo_match',COUNT(__d0(__NL(Geo_Match_))),COUNT(__d0(__NN(Geo_Match_)))},
    {'Event','FraudgovKEL.fraudgovshared','clean_address.err_stat',COUNT(__d0(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d0(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Event','FraudgovKEL.fraudgovshared','PhoneFormatted',COUNT(__d0(__NL(Phone_Formatted_))),COUNT(__d0(__NN(Phone_Formatted_)))},
    {'Event','FraudgovKEL.fraudgovshared','drivers_license',COUNT(__d0(__NL(License_Number_))),COUNT(__d0(__NN(License_Number_)))},
    {'Event','FraudgovKEL.fraudgovshared','drivers_license_state',COUNT(__d0(__NL(License_State_))),COUNT(__d0(__NN(License_State_)))},
    {'Event','FraudgovKEL.fraudgovshared','email_address',COUNT(__d0(__NL(Email_Address_))),COUNT(__d0(__NN(Email_Address_)))},
    {'Event','FraudgovKEL.fraudgovshared','email_address_type',COUNT(__d0(__NL(Type_))),COUNT(__d0(__NN(Type_)))},
    {'Event','FraudgovKEL.fraudgovshared','email_address_date',COUNT(__d0(__NL(Created_On_))),COUNT(__d0(__NN(Created_On_)))},
    {'Event','FraudgovKEL.fraudgovshared','Host',COUNT(__d0(__NL(Host_))),COUNT(__d0(__NN(Host_)))},
    {'Event','FraudgovKEL.fraudgovshared','EmailLastDomain',COUNT(__d0(__NL(Email_Last_Domain_))),COUNT(__d0(__NN(Email_Last_Domain_)))},
    {'Event','FraudgovKEL.fraudgovshared','isdisposableemail',COUNT(__d0(__NL(_isdisposableemail_))),COUNT(__d0(__NN(_isdisposableemail_)))},
    {'Event','FraudgovKEL.fraudgovshared','Ssn',COUNT(__d0(__NL(Ssn_))),COUNT(__d0(__NN(Ssn_)))},
    {'Event','FraudgovKEL.fraudgovshared','SsnFormatted',COUNT(__d0(__NL(Ssn_Formatted_))),COUNT(__d0(__NN(Ssn_Formatted_)))},
    {'Event','FraudgovKEL.fraudgovshared','bank_routing_number_1',COUNT(__d0(__NL(Routing_Number_))),COUNT(__d0(__NN(Routing_Number_)))},
    {'Event','FraudgovKEL.fraudgovshared','bank1FullBankname',COUNT(__d0(__NL(Full_Bankname_))),COUNT(__d0(__NN(Full_Bankname_)))},
    {'Event','FraudgovKEL.fraudgovshared','bank1AbbreviatedBankname',COUNT(__d0(__NL(Abbreviated_Bankname_))),COUNT(__d0(__NN(Abbreviated_Bankname_)))},
    {'Event','FraudgovKEL.fraudgovshared','bank1FractionalRoutingnumber',COUNT(__d0(__NL(Fractional_Routingnumber_))),COUNT(__d0(__NN(Fractional_Routingnumber_)))},
    {'Event','FraudgovKEL.fraudgovshared','bank1HeadofficeRoutingnumber',COUNT(__d0(__NL(Headoffice_Routingnumber_))),COUNT(__d0(__NN(Headoffice_Routingnumber_)))},
    {'Event','FraudgovKEL.fraudgovshared','bank1HeadofficeBranchcodes',COUNT(__d0(__NL(Headoffice_Branchcodes_))),COUNT(__d0(__NN(Headoffice_Branchcodes_)))},
    {'Event','FraudgovKEL.fraudgovshared','bank_account_number_1',COUNT(__d0(__NL(Account_Number_))),COUNT(__d0(__NN(Account_Number_)))},
    {'Event','FraudgovKEL.fraudgovshared','bank1hit',COUNT(__d0(__NL(Bank_Hit_))),COUNT(__d0(__NN(Bank_Hit_)))},
    {'Event','FraudgovKEL.fraudgovshared','Confidence_that_activity_was_deceitful_id',COUNT(__d0(__NL(Confidence__that__activity__was__deceitful__id_))),COUNT(__d0(__NN(Confidence__that__activity__was__deceitful__id_)))},
    {'Event','FraudgovKEL.fraudgovshared','name_risk_code',COUNT(__d0(__NL(_name__risk__code_))),COUNT(__d0(__NN(_name__risk__code_)))},
    {'Event','FraudgovKEL.fraudgovshared','dob_risk_code',COUNT(__d0(__NL(_dob__risk__code_))),COUNT(__d0(__NN(_dob__risk__code_)))},
    {'Event','FraudgovKEL.fraudgovshared','ssn_risk_code',COUNT(__d0(__NL(_ssn__risk__code_))),COUNT(__d0(__NN(_ssn__risk__code_)))},
    {'Event','FraudgovKEL.fraudgovshared','drivers_license_risk_code',COUNT(__d0(__NL(_drivers__license__risk__code_))),COUNT(__d0(__NN(_drivers__license__risk__code_)))},
    {'Event','FraudgovKEL.fraudgovshared','physical_address_risk_code',COUNT(__d0(__NL(_physical__address__risk__code_))),COUNT(__d0(__NN(_physical__address__risk__code_)))},
    {'Event','FraudgovKEL.fraudgovshared','phone_risk_code',COUNT(__d0(__NL(_phone__risk__code_))),COUNT(__d0(__NN(_phone__risk__code_)))},
    {'Event','FraudgovKEL.fraudgovshared','cell_phone_risk_code',COUNT(__d0(__NL(_cell__phone__risk__code_))),COUNT(__d0(__NN(_cell__phone__risk__code_)))},
    {'Event','FraudgovKEL.fraudgovshared','work_phone_risk_code',COUNT(__d0(__NL(_work__phone__risk__code_))),COUNT(__d0(__NN(_work__phone__risk__code_)))},
    {'Event','FraudgovKEL.fraudgovshared','bank_account_1_risk_code',COUNT(__d0(__NL(_bank__account__1__risk__code_))),COUNT(__d0(__NN(_bank__account__1__risk__code_)))},
    {'Event','FraudgovKEL.fraudgovshared','bank_account_2_risk_code',COUNT(__d0(__NL(_bank__account__2__risk__code_))),COUNT(__d0(__NN(_bank__account__2__risk__code_)))},
    {'Event','FraudgovKEL.fraudgovshared','email_address_risk_code',COUNT(__d0(__NL(_email__address__risk__code_))),COUNT(__d0(__NN(_email__address__risk__code_)))},
    {'Event','FraudgovKEL.fraudgovshared','ip_address_fraud_code',COUNT(__d0(__NL(_ip__address__fraud__code_))),COUNT(__d0(__NN(_ip__address__fraud__code_)))},
    {'Event','FraudgovKEL.fraudgovshared','business_risk_code',COUNT(__d0(__NL(_business__risk__code_))),COUNT(__d0(__NN(_business__risk__code_)))},
    {'Event','FraudgovKEL.fraudgovshared','mailing_address_risk_code',COUNT(__d0(__NL(_mailing__address__risk__code_))),COUNT(__d0(__NN(_mailing__address__risk__code_)))},
    {'Event','FraudgovKEL.fraudgovshared','device_risk_code',COUNT(__d0(__NL(_device__risk__code_))),COUNT(__d0(__NN(_device__risk__code_)))},
    {'Event','FraudgovKEL.fraudgovshared','identity_risk_code',COUNT(__d0(__NL(_identity__risk__code_))),COUNT(__d0(__NN(_identity__risk__code_)))},
    {'Event','FraudgovKEL.fraudgovshared','DateOfBirth',COUNT(__d0(__NL(Date_Of_Birth_))),COUNT(__d0(__NN(Date_Of_Birth_)))},
    {'Event','FraudgovKEL.fraudgovshared','iid.nap_summary',COUNT(__d0(__NL(_nap__summary_))),COUNT(__d0(__NN(_nap__summary_)))},
    {'Event','FraudgovKEL.fraudgovshared','iid.nap_summary',COUNT(__d0(__NL(_nas__summary_))),COUNT(__d0(__NN(_nas__summary_)))},
    {'Event','FraudgovKEL.fraudgovshared','iid.cvi',COUNT(__d0(__NL(_cvi_))),COUNT(__d0(__NN(_cvi_)))},
    {'Event','FraudgovKEL.fraudgovshared','fd_scores.stolenidentityindex_v3',COUNT(__d0(__NL(_fp3__stolenidentityindex_))),COUNT(__d0(__NN(_fp3__stolenidentityindex_)))},
    {'Event','FraudgovKEL.fraudgovshared','fd_scores.syntheticidentityindex_v3',COUNT(__d0(__NL(_syntheticidentityindex__v3_))),COUNT(__d0(__NN(_syntheticidentityindex__v3_)))},
    {'Event','FraudgovKEL.fraudgovshared','fd_scores.manipulatedidentityindex_v3',COUNT(__d0(__NL(_manipulatedidentityindex__v3_))),COUNT(__d0(__NN(_manipulatedidentityindex__v3_)))},
    {'Event','FraudgovKEL.fraudgovshared','iid.socsdobflag',COUNT(__d0(__NL(_socsdobflag_))),COUNT(__d0(__NN(_socsdobflag_)))},
    {'Event','FraudgovKEL.fraudgovshared','iid.pwsocsdobflag',COUNT(__d0(__NL(_pwsocsdobflag_))),COUNT(__d0(__NN(_pwsocsdobflag_)))},
    {'Event','FraudgovKEL.fraudgovshared','dobmatchlevel',COUNT(__d0(__NL(_dobmatchlevel_))),COUNT(__d0(__NN(_dobmatchlevel_)))},
    {'Event','FraudgovKEL.fraudgovshared','fdattributesv2.sourcerisklevel',COUNT(__d0(__NL(_sourcerisklevel_))),COUNT(__d0(__NN(_sourcerisklevel_)))},
    {'Event','FraudgovKEL.fraudgovshared','iid.reason1',COUNT(__d0(__NL(_reason1_))),COUNT(__d0(__NN(_reason1_)))},
    {'Event','FraudgovKEL.fraudgovshared','iid.reason2',COUNT(__d0(__NL(_reason2_))),COUNT(__d0(__NN(_reason2_)))},
    {'Event','FraudgovKEL.fraudgovshared','iid.reason3',COUNT(__d0(__NL(_reason3_))),COUNT(__d0(__NN(_reason3_)))},
    {'Event','FraudgovKEL.fraudgovshared','iid.reason4',COUNT(__d0(__NL(_reason4_))),COUNT(__d0(__NN(_reason4_)))},
    {'Event','FraudgovKEL.fraudgovshared','iid.reason5',COUNT(__d0(__NL(_reason5_))),COUNT(__d0(__NN(_reason5_)))},
    {'Event','FraudgovKEL.fraudgovshared','iid.reason6',COUNT(__d0(__NL(_reason6_))),COUNT(__d0(__NN(_reason6_)))},
    {'Event','FraudgovKEL.fraudgovshared','iid.socsvalflag',COUNT(__d0(__NL(_socsvalflag_))),COUNT(__d0(__NN(_socsvalflag_)))},
    {'Event','FraudgovKEL.fraudgovshared','iid.drlcvalflag',COUNT(__d0(__NL(_drlcvalflag_))),COUNT(__d0(__NN(_drlcvalflag_)))},
    {'Event','FraudgovKEL.fraudgovshared','iid.hphonevalflag',COUNT(__d0(__NL(_hphonevalflag_))),COUNT(__d0(__NN(_hphonevalflag_)))},
    {'Event','FraudgovKEL.fraudgovshared','truedid',COUNT(__d0(__NL(_truedid_))),COUNT(__d0(__NN(_truedid_)))},
    {'Event','FraudgovKEL.fraudgovshared','best_fname',COUNT(__d0(__NL(_best__fname_))),COUNT(__d0(__NN(_best__fname_)))},
    {'Event','FraudgovKEL.fraudgovshared','best_lname',COUNT(__d0(__NL(_best__lname_))),COUNT(__d0(__NN(_best__lname_)))},
    {'Event','FraudgovKEL.fraudgovshared','best_ssn',COUNT(__d0(__NL(_best__ssn_))),COUNT(__d0(__NN(_best__ssn_)))},
    {'Event','FraudgovKEL.fraudgovshared','best_pii_flags.input_fname_isbestmatch',COUNT(__d0(__NL(_input__fname__isbestmatch_))),COUNT(__d0(__NN(_input__fname__isbestmatch_)))},
    {'Event','FraudgovKEL.fraudgovshared','best_pii_flags.input_lname_isbestmatch',COUNT(__d0(__NL(_input__lname__isbestmatch_))),COUNT(__d0(__NN(_input__lname__isbestmatch_)))},
    {'Event','FraudgovKEL.fraudgovshared','best_pii_flags.input_ssn_isbestmatch',COUNT(__d0(__NL(_input__ssn__isbestmatch_))),COUNT(__d0(__NN(_input__ssn__isbestmatch_)))},
    {'Event','FraudgovKEL.fraudgovshared','address_verification.address_history_1.addrpop',COUNT(__d0(__NL(_add__curr__pop_))),COUNT(__d0(__NN(_add__curr__pop_)))},
    {'Event','FraudgovKEL.fraudgovshared','add_curr_prim_range',COUNT(__d0(__NL(_add__curr__prim__range_))),COUNT(__d0(__NN(_add__curr__prim__range_)))},
    {'Event','FraudgovKEL.fraudgovshared','add_curr_predir',COUNT(__d0(__NL(_add__curr__predir_))),COUNT(__d0(__NN(_add__curr__predir_)))},
    {'Event','FraudgovKEL.fraudgovshared','add_curr_prim_name',COUNT(__d0(__NL(_add__curr__prim__name_))),COUNT(__d0(__NN(_add__curr__prim__name_)))},
    {'Event','FraudgovKEL.fraudgovshared','add_curr_addr_suffix',COUNT(__d0(__NL(_add__curr__addr__suffix_))),COUNT(__d0(__NN(_add__curr__addr__suffix_)))},
    {'Event','FraudgovKEL.fraudgovshared','add_curr_postdir',COUNT(__d0(__NL(_add__curr__postdir_))),COUNT(__d0(__NN(_add__curr__postdir_)))},
    {'Event','FraudgovKEL.fraudgovshared','add_curr_unit_desig',COUNT(__d0(__NL(_add__curr__unit__desig_))),COUNT(__d0(__NN(_add__curr__unit__desig_)))},
    {'Event','FraudgovKEL.fraudgovshared','add_curr_sec_range',COUNT(__d0(__NL(_add__curr__sec__range_))),COUNT(__d0(__NN(_add__curr__sec__range_)))},
    {'Event','FraudgovKEL.fraudgovshared','add_curr_city_name',COUNT(__d0(__NL(_add__curr__city__name_))),COUNT(__d0(__NN(_add__curr__city__name_)))},
    {'Event','FraudgovKEL.fraudgovshared','add_curr_st',COUNT(__d0(__NL(_add__curr__st_))),COUNT(__d0(__NN(_add__curr__st_)))},
    {'Event','FraudgovKEL.fraudgovshared','add_curr_zip5',COUNT(__d0(__NL(_add__curr__zip5_))),COUNT(__d0(__NN(_add__curr__zip5_)))},
    {'Event','FraudgovKEL.fraudgovshared','add_curr_county',COUNT(__d0(__NL(_add__curr__county_))),COUNT(__d0(__NN(_add__curr__county_)))},
    {'Event','FraudgovKEL.fraudgovshared','add_curr_geo_blk',COUNT(__d0(__NL(_add__curr__geo__blk_))),COUNT(__d0(__NN(_add__curr__geo__blk_)))},
    {'Event','FraudgovKEL.fraudgovshared','add_curr_lat',COUNT(__d0(__NL(_add__curr__lat_))),COUNT(__d0(__NN(_add__curr__lat_)))},
    {'Event','FraudgovKEL.fraudgovshared','add_curr_long',COUNT(__d0(__NL(_add__curr__long_))),COUNT(__d0(__NN(_add__curr__long_)))},
    {'Event','FraudgovKEL.fraudgovshared','address_verification.input_address_information.isbestmatch',COUNT(__d0(__NL(_add__input__isbestmatch_))),COUNT(__d0(__NN(_add__input__isbestmatch_)))},
    {'Event','FraudgovKEL.fraudgovshared','DeceasedDate',COUNT(__d0(__NL(Deceased_Date_))),COUNT(__d0(__NN(Deceased_Date_)))},
    {'Event','FraudgovKEL.fraudgovshared','DeceasedDateOfBirth',COUNT(__d0(__NL(Deceased_Date_Of_Birth_))),COUNT(__d0(__NN(Deceased_Date_Of_Birth_)))},
    {'Event','FraudgovKEL.fraudgovshared','DeceasedFirst',COUNT(__d0(__NL(Deceased_First_))),COUNT(__d0(__NN(Deceased_First_)))},
    {'Event','FraudgovKEL.fraudgovshared','DeceasedMiddle',COUNT(__d0(__NL(Deceased_Middle_))),COUNT(__d0(__NN(Deceased_Middle_)))},
    {'Event','FraudgovKEL.fraudgovshared','DeceasedLast',COUNT(__d0(__NL(Deceased_Last_))),COUNT(__d0(__NN(Deceased_Last_)))},
    {'Event','FraudgovKEL.fraudgovshared','DeceasedMatchCode',COUNT(__d0(__NL(Deceased_Match_Code_))),COUNT(__d0(__NN(Deceased_Match_Code_)))},
    {'Event','FraudgovKEL.fraudgovshared','isdeepdive',COUNT(__d0(__NL(_isdeepdive_))),COUNT(__d0(__NN(_isdeepdive_)))},
    {'Event','FraudgovKEL.fraudgovshared','county_death',COUNT(__d0(__NL(_county__death_))),COUNT(__d0(__NN(_county__death_)))},
    {'Event','FraudgovKEL.fraudgovshared','DeceasedSsn',COUNT(__d0(__NL(Deceased_Ssn_))),COUNT(__d0(__NN(Deceased_Ssn_)))},
    {'Event','FraudgovKEL.fraudgovshared','state_death_flag',COUNT(__d0(__NL(_state__death__flag_))),COUNT(__d0(__NN(_state__death__flag_)))},
    {'Event','FraudgovKEL.fraudgovshared','death_rec_src',COUNT(__d0(__NL(_death__rec__src_))),COUNT(__d0(__NN(_death__rec__src_)))},
    {'Event','FraudgovKEL.fraudgovshared','state_death_id',COUNT(__d0(__NL(_state__death__id_))),COUNT(__d0(__NN(_state__death__id_)))},
    {'Event','FraudgovKEL.fraudgovshared','curr_incar_flag',COUNT(__d0(__NL(_curr__incar__flag_))),COUNT(__d0(__NN(_curr__incar__flag_)))},
    {'Event','FraudgovKEL.fraudgovshared','off_cat_list',COUNT(__d0(__NL(_off__cat__list_))),COUNT(__d0(__NN(_off__cat__list_)))},
    {'Event','FraudgovKEL.fraudgovshared','name_ssn_dob_match',COUNT(__d0(__NL(_name__ssn__dob__match_))),COUNT(__d0(__NN(_name__ssn__dob__match_)))},
    {'Event','FraudgovKEL.fraudgovshared','ip_address',COUNT(__d0(__NL(Ip_Address_))),COUNT(__d0(__NN(Ip_Address_)))},
    {'Event','FraudgovKEL.fraudgovshared','iprngbeg',COUNT(__d0(__NL(_iprngbeg_))),COUNT(__d0(__NN(_iprngbeg_)))},
    {'Event','FraudgovKEL.fraudgovshared','iprngend',COUNT(__d0(__NL(_iprngend_))),COUNT(__d0(__NN(_iprngend_)))},
    {'Event','FraudgovKEL.fraudgovshared','edgecountry',COUNT(__d0(__NL(_edgecountry_))),COUNT(__d0(__NN(_edgecountry_)))},
    {'Event','FraudgovKEL.fraudgovshared','edgeregion',COUNT(__d0(__NL(_edgeregion_))),COUNT(__d0(__NN(_edgeregion_)))},
    {'Event','FraudgovKEL.fraudgovshared','edgecity',COUNT(__d0(__NL(_edgecity_))),COUNT(__d0(__NN(_edgecity_)))},
    {'Event','FraudgovKEL.fraudgovshared','edgeconnspeed',COUNT(__d0(__NL(_edgeconnspeed_))),COUNT(__d0(__NN(_edgeconnspeed_)))},
    {'Event','FraudgovKEL.fraudgovshared','edgemetrocode',COUNT(__d0(__NL(_edgemetrocode_))),COUNT(__d0(__NN(_edgemetrocode_)))},
    {'Event','FraudgovKEL.fraudgovshared','edgelatitude',COUNT(__d0(__NL(_edgelatitude_))),COUNT(__d0(__NN(_edgelatitude_)))},
    {'Event','FraudgovKEL.fraudgovshared','edgelongitude',COUNT(__d0(__NL(_edgelongitude_))),COUNT(__d0(__NN(_edgelongitude_)))},
    {'Event','FraudgovKEL.fraudgovshared','edgepostalcode',COUNT(__d0(__NL(_edgepostalcode_))),COUNT(__d0(__NN(_edgepostalcode_)))},
    {'Event','FraudgovKEL.fraudgovshared','edgecountrycode',COUNT(__d0(__NL(_edgecountrycode_))),COUNT(__d0(__NN(_edgecountrycode_)))},
    {'Event','FraudgovKEL.fraudgovshared','edgeregioncode',COUNT(__d0(__NL(_edgeregioncode_))),COUNT(__d0(__NN(_edgeregioncode_)))},
    {'Event','FraudgovKEL.fraudgovshared','edgecitycode',COUNT(__d0(__NL(_edgecitycode_))),COUNT(__d0(__NN(_edgecitycode_)))},
    {'Event','FraudgovKEL.fraudgovshared','edgecontinentcode',COUNT(__d0(__NL(_edgecontinentcode_))),COUNT(__d0(__NN(_edgecontinentcode_)))},
    {'Event','FraudgovKEL.fraudgovshared','edgetwolettercountry',COUNT(__d0(__NL(_edgetwolettercountry_))),COUNT(__d0(__NN(_edgetwolettercountry_)))},
    {'Event','FraudgovKEL.fraudgovshared','edgeinternalcode',COUNT(__d0(__NL(_edgeinternalcode_))),COUNT(__d0(__NN(_edgeinternalcode_)))},
    {'Event','FraudgovKEL.fraudgovshared','edgeareacodes',COUNT(__d0(__NL(_edgeareacodes_))),COUNT(__d0(__NN(_edgeareacodes_)))},
    {'Event','FraudgovKEL.fraudgovshared','edgecountryconf',COUNT(__d0(__NL(_edgecountryconf_))),COUNT(__d0(__NN(_edgecountryconf_)))},
    {'Event','FraudgovKEL.fraudgovshared','edgeregionconf',COUNT(__d0(__NL(_edgeregionconf_))),COUNT(__d0(__NN(_edgeregionconf_)))},
    {'Event','FraudgovKEL.fraudgovshared','edgecitycong',COUNT(__d0(__NL(_edgecitycong_))),COUNT(__d0(__NN(_edgecitycong_)))},
    {'Event','FraudgovKEL.fraudgovshared','edgepostalconf',COUNT(__d0(__NL(_edgepostalconf_))),COUNT(__d0(__NN(_edgepostalconf_)))},
    {'Event','FraudgovKEL.fraudgovshared','edgegmtoffset',COUNT(__d0(__NL(_edgegmtoffset_))),COUNT(__d0(__NN(_edgegmtoffset_)))},
    {'Event','FraudgovKEL.fraudgovshared','edgeindst',COUNT(__d0(__NL(_edgeindst_))),COUNT(__d0(__NN(_edgeindst_)))},
    {'Event','FraudgovKEL.fraudgovshared','siccode',COUNT(__d0(__NL(_siccode_))),COUNT(__d0(__NN(_siccode_)))},
    {'Event','FraudgovKEL.fraudgovshared','domainname',COUNT(__d0(__NL(_domainname_))),COUNT(__d0(__NN(_domainname_)))},
    {'Event','FraudgovKEL.fraudgovshared','ispname',COUNT(__d0(__NL(_ispname_))),COUNT(__d0(__NN(_ispname_)))},
    {'Event','FraudgovKEL.fraudgovshared','homebiztype',COUNT(__d0(__NL(_homebiztype_))),COUNT(__d0(__NN(_homebiztype_)))},
    {'Event','FraudgovKEL.fraudgovshared','asn',COUNT(__d0(__NL(_asn_))),COUNT(__d0(__NN(_asn_)))},
    {'Event','FraudgovKEL.fraudgovshared','asnname',COUNT(__d0(__NL(_asnname_))),COUNT(__d0(__NN(_asnname_)))},
    {'Event','FraudgovKEL.fraudgovshared','primarylang',COUNT(__d0(__NL(_primarylang_))),COUNT(__d0(__NN(_primarylang_)))},
    {'Event','FraudgovKEL.fraudgovshared','secondarylang',COUNT(__d0(__NL(_secondarylang_))),COUNT(__d0(__NN(_secondarylang_)))},
    {'Event','FraudgovKEL.fraudgovshared','proxytype',COUNT(__d0(__NL(_proxytype_))),COUNT(__d0(__NN(_proxytype_)))},
    {'Event','FraudgovKEL.fraudgovshared','proxydescription',COUNT(__d0(__NL(_proxydescription_))),COUNT(__d0(__NN(_proxydescription_)))},
    {'Event','FraudgovKEL.fraudgovshared','isanisp',COUNT(__d0(__NL(_isanisp_))),COUNT(__d0(__NN(_isanisp_)))},
    {'Event','FraudgovKEL.fraudgovshared','companyname',COUNT(__d0(__NL(_companyname_))),COUNT(__d0(__NN(_companyname_)))},
    {'Event','FraudgovKEL.fraudgovshared','ranks',COUNT(__d0(__NL(_ranks_))),COUNT(__d0(__NN(_ranks_)))},
    {'Event','FraudgovKEL.fraudgovshared','households',COUNT(__d0(__NL(_households_))),COUNT(__d0(__NN(_households_)))},
    {'Event','FraudgovKEL.fraudgovshared','women',COUNT(__d0(__NL(_women_))),COUNT(__d0(__NN(_women_)))},
    {'Event','FraudgovKEL.fraudgovshared','women18to34',COUNT(__d0(__NL(_women18to34_))),COUNT(__d0(__NN(_women18to34_)))},
    {'Event','FraudgovKEL.fraudgovshared','women35to49',COUNT(__d0(__NL(_women35to49_))),COUNT(__d0(__NN(_women35to49_)))},
    {'Event','FraudgovKEL.fraudgovshared','men',COUNT(__d0(__NL(_men_))),COUNT(__d0(__NN(_men_)))},
    {'Event','FraudgovKEL.fraudgovshared','men18to34',COUNT(__d0(__NL(_men18to34_))),COUNT(__d0(__NN(_men18to34_)))},
    {'Event','FraudgovKEL.fraudgovshared','men35to49',COUNT(__d0(__NL(_men35to49_))),COUNT(__d0(__NN(_men35to49_)))},
    {'Event','FraudgovKEL.fraudgovshared','teens',COUNT(__d0(__NL(_teens_))),COUNT(__d0(__NN(_teens_)))},
    {'Event','FraudgovKEL.fraudgovshared','kids',COUNT(__d0(__NL(_kids_))),COUNT(__d0(__NN(_kids_)))},
    {'Event','FraudgovKEL.fraudgovshared','naicscode',COUNT(__d0(__NL(_naicscode_))),COUNT(__d0(__NN(_naicscode_)))},
    {'Event','FraudgovKEL.fraudgovshared','cbsacode',COUNT(__d0(__NL(_cbsacode_))),COUNT(__d0(__NN(_cbsacode_)))},
    {'Event','FraudgovKEL.fraudgovshared','cbsatitle',COUNT(__d0(__NL(_cbsatitle_))),COUNT(__d0(__NN(_cbsatitle_)))},
    {'Event','FraudgovKEL.fraudgovshared','cbsatype',COUNT(__d0(__NL(_cbsatype_))),COUNT(__d0(__NN(_cbsatype_)))},
    {'Event','FraudgovKEL.fraudgovshared','csacode',COUNT(__d0(__NL(_csacode_))),COUNT(__d0(__NN(_csacode_)))},
    {'Event','FraudgovKEL.fraudgovshared','csatitle',COUNT(__d0(__NL(_csatitle_))),COUNT(__d0(__NN(_csatitle_)))},
    {'Event','FraudgovKEL.fraudgovshared','mdcode',COUNT(__d0(__NL(_mdcode_))),COUNT(__d0(__NN(_mdcode_)))},
    {'Event','FraudgovKEL.fraudgovshared','mdtitle',COUNT(__d0(__NL(_mdtitle_))),COUNT(__d0(__NN(_mdtitle_)))},
    {'Event','FraudgovKEL.fraudgovshared','organizationname',COUNT(__d0(__NL(_organizationname_))),COUNT(__d0(__NN(_organizationname_)))},
    {'Event','FraudgovKEL.fraudgovshared','advo_hitflag',COUNT(__d0(__NL(_advo__hitflag_))),COUNT(__d0(__NN(_advo__hitflag_)))},
    {'Event','FraudgovKEL.fraudgovshared','advo_vacancyindicator',COUNT(__d0(__NL(_advo__vacancyindicator_))),COUNT(__d0(__NN(_advo__vacancyindicator_)))},
    {'Event','FraudgovKEL.fraudgovshared','advo_addressstyle',COUNT(__d0(__NL(_advo__addressstyle_))),COUNT(__d0(__NN(_advo__addressstyle_)))},
    {'Event','FraudgovKEL.fraudgovshared','advo_dropindicator',COUNT(__d0(__NL(_advo__dropindicator_))),COUNT(__d0(__NN(_advo__dropindicator_)))},
    {'Event','FraudgovKEL.fraudgovshared','advo_residentialorbusinessindicator',COUNT(__d0(__NL(_advo__residentialorbusinessindicator_))),COUNT(__d0(__NN(_advo__residentialorbusinessindicator_)))},
    {'Event','FraudgovKEL.fraudgovshared','advo_addresstype',COUNT(__d0(__NL(_advo__addresstype_))),COUNT(__d0(__NN(_advo__addresstype_)))},
    {'Event','FraudgovKEL.fraudgovshared','advo_addressusagetype',COUNT(__d0(__NL(_advo__addressusagetype_))),COUNT(__d0(__NN(_advo__addressusagetype_)))},
    {'Event','FraudgovKEL.fraudgovshared','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Event','FraudgovKEL.fraudgovshared','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Event','FraudgovKEL.PersonEventTypes','UID',COUNT(FraudgovKEL_PersonEventTypes_Invalid),COUNT(__d1)},
    {'Event','FraudgovKEL.PersonEventTypes','AssociatedCustomerFileInfo',COUNT(__d1(__NL(_r_Customer_))),COUNT(__d1(__NN(_r_Customer_)))},
    {'Event','FraudgovKEL.PersonEventTypes','SourceCustomerFileInfo',COUNT(__d1(__NL(_r_Source_Customer_))),COUNT(__d1(__NN(_r_Source_Customer_)))},
    {'Event','FraudgovKEL.PersonEventTypes','Subject',COUNT(__d1(__NL(Subject_))),COUNT(__d1(__NN(Subject_)))},
    {'Event','FraudgovKEL.PersonEventTypes','Location',COUNT(__d1(__NL(Location_))),COUNT(__d1(__NN(Location_)))},
    {'Event','FraudgovKEL.PersonEventTypes','rSsn',COUNT(__d1(__NL(_r_Ssn_))),COUNT(__d1(__NN(_r_Ssn_)))},
    {'Event','FraudgovKEL.PersonEventTypes','rPhone',COUNT(__d1(__NL(_r_Phone_))),COUNT(__d1(__NN(_r_Phone_)))},
    {'Event','FraudgovKEL.PersonEventTypes','rEmail',COUNT(__d1(__NL(_r_Email_))),COUNT(__d1(__NN(_r_Email_)))},
    {'Event','FraudgovKEL.PersonEventTypes','rInternetProtocol',COUNT(__d1(__NL(_r_Internet_Protocol_))),COUNT(__d1(__NN(_r_Internet_Protocol_)))},
    {'Event','FraudgovKEL.PersonEventTypes','rBankAccount',COUNT(__d1(__NL(_r_Bank_Account_))),COUNT(__d1(__NN(_r_Bank_Account_)))},
    {'Event','FraudgovKEL.PersonEventTypes','rDriversLicense',COUNT(__d1(__NL(_r_Drivers_License_))),COUNT(__d1(__NN(_r_Drivers_License_)))},
    {'Event','FraudgovKEL.PersonEventTypes','rin_source',COUNT(__d1(__NL(_rin__source_))),COUNT(__d1(__NN(_rin__source_)))},
    {'Event','FraudgovKEL.PersonEventTypes','LexId',COUNT(__d1(__NL(Lex_Id_))),COUNT(__d1(__NN(Lex_Id_)))},
    {'Event','FraudgovKEL.PersonEventTypes','PhoneNumber',COUNT(__d1(__NL(Phone_Number_))),COUNT(__d1(__NN(Phone_Number_)))},
    {'Event','FraudgovKEL.PersonEventTypes','OttoAddressId',COUNT(__d1(__NL(Otto_Address_Id_))),COUNT(__d1(__NN(Otto_Address_Id_)))},
    {'Event','FraudgovKEL.PersonEventTypes','OttoEmailId',COUNT(__d1(__NL(Otto_Email_Id_))),COUNT(__d1(__NN(Otto_Email_Id_)))},
    {'Event','FraudgovKEL.PersonEventTypes','OttoIpAddressId',COUNT(__d1(__NL(Otto_Ip_Address_Id_))),COUNT(__d1(__NN(Otto_Ip_Address_Id_)))},
    {'Event','FraudgovKEL.PersonEventTypes','OttoDriversLicenseId',COUNT(__d1(__NL(Otto_Drivers_License_Id_))),COUNT(__d1(__NN(Otto_Drivers_License_Id_)))},
    {'Event','FraudgovKEL.PersonEventTypes','OttoSSNId',COUNT(__d1(__NL(Otto_S_S_N_Id_))),COUNT(__d1(__NN(Otto_S_S_N_Id_)))},
    {'Event','FraudgovKEL.PersonEventTypes','CaseId',COUNT(__d1(__NL(Case_Id_))),COUNT(__d1(__NN(Case_Id_)))},
    {'Event','FraudgovKEL.PersonEventTypes','record_id',COUNT(__d1(__NL(Record_Id_))),COUNT(__d1(__NN(Record_Id_)))},
    {'Event','FraudgovKEL.PersonEventTypes','EventDate',COUNT(__d1(__NL(Event_Date_))),COUNT(__d1(__NN(Event_Date_)))},
    {'Event','FraudgovKEL.PersonEventTypes','event_type',COUNT(__d1(__NL(Event_Type_))),COUNT(__d1(__NN(Event_Type_)))},
    {'Event','FraudgovKEL.PersonEventTypes','Title',COUNT(__d1(__NL(Title_))),COUNT(__d1(__NN(Title_)))},
    {'Event','FraudgovKEL.PersonEventTypes','FirstName',COUNT(__d1(__NL(First_Name_))),COUNT(__d1(__NN(First_Name_)))},
    {'Event','FraudgovKEL.PersonEventTypes','MiddleName',COUNT(__d1(__NL(Middle_Name_))),COUNT(__d1(__NN(Middle_Name_)))},
    {'Event','FraudgovKEL.PersonEventTypes','LastName',COUNT(__d1(__NL(Last_Name_))),COUNT(__d1(__NN(Last_Name_)))},
    {'Event','FraudgovKEL.PersonEventTypes','NameSuffix',COUNT(__d1(__NL(Name_Suffix_))),COUNT(__d1(__NN(Name_Suffix_)))},
    {'Event','FraudgovKEL.PersonEventTypes','addresspobox',COUNT(__d1(__NL(_addresspobox_))),COUNT(__d1(__NN(_addresspobox_)))},
    {'Event','FraudgovKEL.PersonEventTypes','addresscmra',COUNT(__d1(__NL(_addresscmra_))),COUNT(__d1(__NN(_addresscmra_)))},
    {'Event','FraudgovKEL.PersonEventTypes','PrimaryRange',COUNT(__d1(__NL(Primary_Range_))),COUNT(__d1(__NN(Primary_Range_)))},
    {'Event','FraudgovKEL.PersonEventTypes','Predirectional',COUNT(__d1(__NL(Predirectional_))),COUNT(__d1(__NN(Predirectional_)))},
    {'Event','FraudgovKEL.PersonEventTypes','PrimaryName',COUNT(__d1(__NL(Primary_Name_))),COUNT(__d1(__NN(Primary_Name_)))},
    {'Event','FraudgovKEL.PersonEventTypes','Suffix',COUNT(__d1(__NL(Suffix_))),COUNT(__d1(__NN(Suffix_)))},
    {'Event','FraudgovKEL.PersonEventTypes','Postdirectional',COUNT(__d1(__NL(Postdirectional_))),COUNT(__d1(__NN(Postdirectional_)))},
    {'Event','FraudgovKEL.PersonEventTypes','UnitDesignation',COUNT(__d1(__NL(Unit_Designation_))),COUNT(__d1(__NN(Unit_Designation_)))},
    {'Event','FraudgovKEL.PersonEventTypes','SecondaryRange',COUNT(__d1(__NL(Secondary_Range_))),COUNT(__d1(__NN(Secondary_Range_)))},
    {'Event','FraudgovKEL.PersonEventTypes','PostalCity',COUNT(__d1(__NL(Postal_City_))),COUNT(__d1(__NN(Postal_City_)))},
    {'Event','FraudgovKEL.PersonEventTypes','VanityCity',COUNT(__d1(__NL(Vanity_City_))),COUNT(__d1(__NN(Vanity_City_)))},
    {'Event','FraudgovKEL.PersonEventTypes','State',COUNT(__d1(__NL(State_))),COUNT(__d1(__NN(State_)))},
    {'Event','FraudgovKEL.PersonEventTypes','Zip',COUNT(__d1(__NL(Zip_))),COUNT(__d1(__NN(Zip_)))},
    {'Event','FraudgovKEL.PersonEventTypes','Zip4',COUNT(__d1(__NL(Zip4_))),COUNT(__d1(__NN(Zip4_)))},
    {'Event','FraudgovKEL.PersonEventTypes','CarrierRouteNumber',COUNT(__d1(__NL(Carrier_Route_Number_))),COUNT(__d1(__NN(Carrier_Route_Number_)))},
    {'Event','FraudgovKEL.PersonEventTypes','CarrierRouteSortationAtZIP',COUNT(__d1(__NL(Carrier_Route_Sortation_At_Z_I_P_))),COUNT(__d1(__NN(Carrier_Route_Sortation_At_Z_I_P_)))},
    {'Event','FraudgovKEL.PersonEventTypes','LineOfTravel',COUNT(__d1(__NL(Line_Of_Travel_))),COUNT(__d1(__NN(Line_Of_Travel_)))},
    {'Event','FraudgovKEL.PersonEventTypes','LineOfTravelOrder',COUNT(__d1(__NL(Line_Of_Travel_Order_))),COUNT(__d1(__NN(Line_Of_Travel_Order_)))},
    {'Event','FraudgovKEL.PersonEventTypes','DeliveryPointBarcode',COUNT(__d1(__NL(Delivery_Point_Barcode_))),COUNT(__d1(__NN(Delivery_Point_Barcode_)))},
    {'Event','FraudgovKEL.PersonEventTypes','DeliveryPointBarcodeCheckDigit',COUNT(__d1(__NL(Delivery_Point_Barcode_Check_Digit_))),COUNT(__d1(__NN(Delivery_Point_Barcode_Check_Digit_)))},
    {'Event','FraudgovKEL.PersonEventTypes','TypeCode',COUNT(__d1(__NL(Type_Code_))),COUNT(__d1(__NN(Type_Code_)))},
    {'Event','FraudgovKEL.PersonEventTypes','County',COUNT(__d1(__NL(County_))),COUNT(__d1(__NN(County_)))},
    {'Event','FraudgovKEL.PersonEventTypes','Latitude',COUNT(__d1(__NL(Latitude_))),COUNT(__d1(__NN(Latitude_)))},
    {'Event','FraudgovKEL.PersonEventTypes','Longitude',COUNT(__d1(__NL(Longitude_))),COUNT(__d1(__NN(Longitude_)))},
    {'Event','FraudgovKEL.PersonEventTypes','MetropolitanStatisticalArea',COUNT(__d1(__NL(Metropolitan_Statistical_Area_))),COUNT(__d1(__NN(Metropolitan_Statistical_Area_)))},
    {'Event','FraudgovKEL.PersonEventTypes','GeoBlock',COUNT(__d1(__NL(Geo_Block_))),COUNT(__d1(__NN(Geo_Block_)))},
    {'Event','FraudgovKEL.PersonEventTypes','GeoMatch',COUNT(__d1(__NL(Geo_Match_))),COUNT(__d1(__NN(Geo_Match_)))},
    {'Event','FraudgovKEL.PersonEventTypes','ACECleanerErrorCode',COUNT(__d1(__NL(A_C_E_Cleaner_Error_Code_))),COUNT(__d1(__NN(A_C_E_Cleaner_Error_Code_)))},
    {'Event','FraudgovKEL.PersonEventTypes','isAdditional',COUNT(__d1(__NL(_is_Additional_))),COUNT(__d1(__NN(_is_Additional_)))},
    {'Event','FraudgovKEL.PersonEventTypes','PhoneFormatted',COUNT(__d1(__NL(Phone_Formatted_))),COUNT(__d1(__NN(Phone_Formatted_)))},
    {'Event','FraudgovKEL.PersonEventTypes','LicenseNumber',COUNT(__d1(__NL(License_Number_))),COUNT(__d1(__NN(License_Number_)))},
    {'Event','FraudgovKEL.PersonEventTypes','LicenseState',COUNT(__d1(__NL(License_State_))),COUNT(__d1(__NN(License_State_)))},
    {'Event','FraudgovKEL.PersonEventTypes','EmailAddress',COUNT(__d1(__NL(Email_Address_))),COUNT(__d1(__NN(Email_Address_)))},
    {'Event','FraudgovKEL.PersonEventTypes','Type',COUNT(__d1(__NL(Type_))),COUNT(__d1(__NN(Type_)))},
    {'Event','FraudgovKEL.PersonEventTypes','CreatedOn',COUNT(__d1(__NL(Created_On_))),COUNT(__d1(__NN(Created_On_)))},
    {'Event','FraudgovKEL.PersonEventTypes','Host',COUNT(__d1(__NL(Host_))),COUNT(__d1(__NN(Host_)))},
    {'Event','FraudgovKEL.PersonEventTypes','EmailLastDomain',COUNT(__d1(__NL(Email_Last_Domain_))),COUNT(__d1(__NN(Email_Last_Domain_)))},
    {'Event','FraudgovKEL.PersonEventTypes','isdisposableemail',COUNT(__d1(__NL(_isdisposableemail_))),COUNT(__d1(__NN(_isdisposableemail_)))},
    {'Event','FraudgovKEL.PersonEventTypes','Ssn',COUNT(__d1(__NL(Ssn_))),COUNT(__d1(__NN(Ssn_)))},
    {'Event','FraudgovKEL.PersonEventTypes','SsnFormatted',COUNT(__d1(__NL(Ssn_Formatted_))),COUNT(__d1(__NN(Ssn_Formatted_)))},
    {'Event','FraudgovKEL.PersonEventTypes','RoutingNumber',COUNT(__d1(__NL(Routing_Number_))),COUNT(__d1(__NN(Routing_Number_)))},
    {'Event','FraudgovKEL.PersonEventTypes','FullBankname',COUNT(__d1(__NL(Full_Bankname_))),COUNT(__d1(__NN(Full_Bankname_)))},
    {'Event','FraudgovKEL.PersonEventTypes','AbbreviatedBankname',COUNT(__d1(__NL(Abbreviated_Bankname_))),COUNT(__d1(__NN(Abbreviated_Bankname_)))},
    {'Event','FraudgovKEL.PersonEventTypes','FractionalRoutingnumber',COUNT(__d1(__NL(Fractional_Routingnumber_))),COUNT(__d1(__NN(Fractional_Routingnumber_)))},
    {'Event','FraudgovKEL.PersonEventTypes','HeadofficeRoutingnumber',COUNT(__d1(__NL(Headoffice_Routingnumber_))),COUNT(__d1(__NN(Headoffice_Routingnumber_)))},
    {'Event','FraudgovKEL.PersonEventTypes','HeadofficeBranchcodes',COUNT(__d1(__NL(Headoffice_Branchcodes_))),COUNT(__d1(__NN(Headoffice_Branchcodes_)))},
    {'Event','FraudgovKEL.PersonEventTypes','AccountNumber',COUNT(__d1(__NL(Account_Number_))),COUNT(__d1(__NN(Account_Number_)))},
    {'Event','FraudgovKEL.PersonEventTypes','BankHit',COUNT(__d1(__NL(Bank_Hit_))),COUNT(__d1(__NN(Bank_Hit_)))},
    {'Event','FraudgovKEL.PersonEventTypes','Confidence_that_activity_was_deceitful_id',COUNT(__d1(__NL(Confidence__that__activity__was__deceitful__id_))),COUNT(__d1(__NN(Confidence__that__activity__was__deceitful__id_)))},
    {'Event','FraudgovKEL.PersonEventTypes','name_risk_code',COUNT(__d1(__NL(_name__risk__code_))),COUNT(__d1(__NN(_name__risk__code_)))},
    {'Event','FraudgovKEL.PersonEventTypes','dob_risk_code',COUNT(__d1(__NL(_dob__risk__code_))),COUNT(__d1(__NN(_dob__risk__code_)))},
    {'Event','FraudgovKEL.PersonEventTypes','ssn_risk_code',COUNT(__d1(__NL(_ssn__risk__code_))),COUNT(__d1(__NN(_ssn__risk__code_)))},
    {'Event','FraudgovKEL.PersonEventTypes','drivers_license_risk_code',COUNT(__d1(__NL(_drivers__license__risk__code_))),COUNT(__d1(__NN(_drivers__license__risk__code_)))},
    {'Event','FraudgovKEL.PersonEventTypes','physical_address_risk_code',COUNT(__d1(__NL(_physical__address__risk__code_))),COUNT(__d1(__NN(_physical__address__risk__code_)))},
    {'Event','FraudgovKEL.PersonEventTypes','phone_risk_code',COUNT(__d1(__NL(_phone__risk__code_))),COUNT(__d1(__NN(_phone__risk__code_)))},
    {'Event','FraudgovKEL.PersonEventTypes','cell_phone_risk_code',COUNT(__d1(__NL(_cell__phone__risk__code_))),COUNT(__d1(__NN(_cell__phone__risk__code_)))},
    {'Event','FraudgovKEL.PersonEventTypes','work_phone_risk_code',COUNT(__d1(__NL(_work__phone__risk__code_))),COUNT(__d1(__NN(_work__phone__risk__code_)))},
    {'Event','FraudgovKEL.PersonEventTypes','bank_account_1_risk_code',COUNT(__d1(__NL(_bank__account__1__risk__code_))),COUNT(__d1(__NN(_bank__account__1__risk__code_)))},
    {'Event','FraudgovKEL.PersonEventTypes','bank_account_2_risk_code',COUNT(__d1(__NL(_bank__account__2__risk__code_))),COUNT(__d1(__NN(_bank__account__2__risk__code_)))},
    {'Event','FraudgovKEL.PersonEventTypes','email_address_risk_code',COUNT(__d1(__NL(_email__address__risk__code_))),COUNT(__d1(__NN(_email__address__risk__code_)))},
    {'Event','FraudgovKEL.PersonEventTypes','ip_address_fraud_code',COUNT(__d1(__NL(_ip__address__fraud__code_))),COUNT(__d1(__NN(_ip__address__fraud__code_)))},
    {'Event','FraudgovKEL.PersonEventTypes','business_risk_code',COUNT(__d1(__NL(_business__risk__code_))),COUNT(__d1(__NN(_business__risk__code_)))},
    {'Event','FraudgovKEL.PersonEventTypes','mailing_address_risk_code',COUNT(__d1(__NL(_mailing__address__risk__code_))),COUNT(__d1(__NN(_mailing__address__risk__code_)))},
    {'Event','FraudgovKEL.PersonEventTypes','device_risk_code',COUNT(__d1(__NL(_device__risk__code_))),COUNT(__d1(__NN(_device__risk__code_)))},
    {'Event','FraudgovKEL.PersonEventTypes','identity_risk_code',COUNT(__d1(__NL(_identity__risk__code_))),COUNT(__d1(__NN(_identity__risk__code_)))},
    {'Event','FraudgovKEL.PersonEventTypes','DateOfBirth',COUNT(__d1(__NL(Date_Of_Birth_))),COUNT(__d1(__NN(Date_Of_Birth_)))},
    {'Event','FraudgovKEL.PersonEventTypes','nap_summary',COUNT(__d1(__NL(_nap__summary_))),COUNT(__d1(__NN(_nap__summary_)))},
    {'Event','FraudgovKEL.PersonEventTypes','nas_summary',COUNT(__d1(__NL(_nas__summary_))),COUNT(__d1(__NN(_nas__summary_)))},
    {'Event','FraudgovKEL.PersonEventTypes','cvi',COUNT(__d1(__NL(_cvi_))),COUNT(__d1(__NN(_cvi_)))},
    {'Event','FraudgovKEL.PersonEventTypes','fp3_stolenidentityindex',COUNT(__d1(__NL(_fp3__stolenidentityindex_))),COUNT(__d1(__NN(_fp3__stolenidentityindex_)))},
    {'Event','FraudgovKEL.PersonEventTypes','syntheticidentityindex_v3',COUNT(__d1(__NL(_syntheticidentityindex__v3_))),COUNT(__d1(__NN(_syntheticidentityindex__v3_)))},
    {'Event','FraudgovKEL.PersonEventTypes','manipulatedidentityindex_v3',COUNT(__d1(__NL(_manipulatedidentityindex__v3_))),COUNT(__d1(__NN(_manipulatedidentityindex__v3_)))},
    {'Event','FraudgovKEL.PersonEventTypes','socsdobflag',COUNT(__d1(__NL(_socsdobflag_))),COUNT(__d1(__NN(_socsdobflag_)))},
    {'Event','FraudgovKEL.PersonEventTypes','pwsocsdobflag',COUNT(__d1(__NL(_pwsocsdobflag_))),COUNT(__d1(__NN(_pwsocsdobflag_)))},
    {'Event','FraudgovKEL.PersonEventTypes','dobmatchlevel',COUNT(__d1(__NL(_dobmatchlevel_))),COUNT(__d1(__NN(_dobmatchlevel_)))},
    {'Event','FraudgovKEL.PersonEventTypes','sourcerisklevel',COUNT(__d1(__NL(_sourcerisklevel_))),COUNT(__d1(__NN(_sourcerisklevel_)))},
    {'Event','FraudgovKEL.PersonEventTypes','reason1',COUNT(__d1(__NL(_reason1_))),COUNT(__d1(__NN(_reason1_)))},
    {'Event','FraudgovKEL.PersonEventTypes','reason2',COUNT(__d1(__NL(_reason2_))),COUNT(__d1(__NN(_reason2_)))},
    {'Event','FraudgovKEL.PersonEventTypes','reason3',COUNT(__d1(__NL(_reason3_))),COUNT(__d1(__NN(_reason3_)))},
    {'Event','FraudgovKEL.PersonEventTypes','reason4',COUNT(__d1(__NL(_reason4_))),COUNT(__d1(__NN(_reason4_)))},
    {'Event','FraudgovKEL.PersonEventTypes','reason5',COUNT(__d1(__NL(_reason5_))),COUNT(__d1(__NN(_reason5_)))},
    {'Event','FraudgovKEL.PersonEventTypes','reason6',COUNT(__d1(__NL(_reason6_))),COUNT(__d1(__NN(_reason6_)))},
    {'Event','FraudgovKEL.PersonEventTypes','socsvalflag',COUNT(__d1(__NL(_socsvalflag_))),COUNT(__d1(__NN(_socsvalflag_)))},
    {'Event','FraudgovKEL.PersonEventTypes','drlcvalflag',COUNT(__d1(__NL(_drlcvalflag_))),COUNT(__d1(__NN(_drlcvalflag_)))},
    {'Event','FraudgovKEL.PersonEventTypes','hphonevalflag',COUNT(__d1(__NL(_hphonevalflag_))),COUNT(__d1(__NN(_hphonevalflag_)))},
    {'Event','FraudgovKEL.PersonEventTypes','truedid',COUNT(__d1(__NL(_truedid_))),COUNT(__d1(__NN(_truedid_)))},
    {'Event','FraudgovKEL.PersonEventTypes','best_flags.fname',COUNT(__d1(__NL(_best__fname_))),COUNT(__d1(__NN(_best__fname_)))},
    {'Event','FraudgovKEL.PersonEventTypes','best_flags.lname',COUNT(__d1(__NL(_best__lname_))),COUNT(__d1(__NN(_best__lname_)))},
    {'Event','FraudgovKEL.PersonEventTypes','best_flags.ssn',COUNT(__d1(__NL(_best__ssn_))),COUNT(__d1(__NN(_best__ssn_)))},
    {'Event','FraudgovKEL.PersonEventTypes','input_fname_isbestmatch',COUNT(__d1(__NL(_input__fname__isbestmatch_))),COUNT(__d1(__NN(_input__fname__isbestmatch_)))},
    {'Event','FraudgovKEL.PersonEventTypes','input_lname_isbestmatch',COUNT(__d1(__NL(_input__lname__isbestmatch_))),COUNT(__d1(__NN(_input__lname__isbestmatch_)))},
    {'Event','FraudgovKEL.PersonEventTypes','input_ssn_isbestmatch',COUNT(__d1(__NL(_input__ssn__isbestmatch_))),COUNT(__d1(__NN(_input__ssn__isbestmatch_)))},
    {'Event','FraudgovKEL.PersonEventTypes','add_curr_pop',COUNT(__d1(__NL(_add__curr__pop_))),COUNT(__d1(__NN(_add__curr__pop_)))},
    {'Event','FraudgovKEL.PersonEventTypes','add_curr_prim_range',COUNT(__d1(__NL(_add__curr__prim__range_))),COUNT(__d1(__NN(_add__curr__prim__range_)))},
    {'Event','FraudgovKEL.PersonEventTypes','add_curr_predir',COUNT(__d1(__NL(_add__curr__predir_))),COUNT(__d1(__NN(_add__curr__predir_)))},
    {'Event','FraudgovKEL.PersonEventTypes','add_curr_prim_name',COUNT(__d1(__NL(_add__curr__prim__name_))),COUNT(__d1(__NN(_add__curr__prim__name_)))},
    {'Event','FraudgovKEL.PersonEventTypes','add_curr_addr_suffix',COUNT(__d1(__NL(_add__curr__addr__suffix_))),COUNT(__d1(__NN(_add__curr__addr__suffix_)))},
    {'Event','FraudgovKEL.PersonEventTypes','add_curr_postdir',COUNT(__d1(__NL(_add__curr__postdir_))),COUNT(__d1(__NN(_add__curr__postdir_)))},
    {'Event','FraudgovKEL.PersonEventTypes','add_curr_unit_desig',COUNT(__d1(__NL(_add__curr__unit__desig_))),COUNT(__d1(__NN(_add__curr__unit__desig_)))},
    {'Event','FraudgovKEL.PersonEventTypes','add_curr_sec_range',COUNT(__d1(__NL(_add__curr__sec__range_))),COUNT(__d1(__NN(_add__curr__sec__range_)))},
    {'Event','FraudgovKEL.PersonEventTypes','add_curr_city_name',COUNT(__d1(__NL(_add__curr__city__name_))),COUNT(__d1(__NN(_add__curr__city__name_)))},
    {'Event','FraudgovKEL.PersonEventTypes','add_curr_st',COUNT(__d1(__NL(_add__curr__st_))),COUNT(__d1(__NN(_add__curr__st_)))},
    {'Event','FraudgovKEL.PersonEventTypes','add_curr_zip5',COUNT(__d1(__NL(_add__curr__zip5_))),COUNT(__d1(__NN(_add__curr__zip5_)))},
    {'Event','FraudgovKEL.PersonEventTypes','add_curr_county',COUNT(__d1(__NL(_add__curr__county_))),COUNT(__d1(__NN(_add__curr__county_)))},
    {'Event','FraudgovKEL.PersonEventTypes','add_curr_geo_blk',COUNT(__d1(__NL(_add__curr__geo__blk_))),COUNT(__d1(__NN(_add__curr__geo__blk_)))},
    {'Event','FraudgovKEL.PersonEventTypes','add_curr_lat',COUNT(__d1(__NL(_add__curr__lat_))),COUNT(__d1(__NN(_add__curr__lat_)))},
    {'Event','FraudgovKEL.PersonEventTypes','add_curr_long',COUNT(__d1(__NL(_add__curr__long_))),COUNT(__d1(__NN(_add__curr__long_)))},
    {'Event','FraudgovKEL.PersonEventTypes','add_input_isbestmatch',COUNT(__d1(__NL(_add__input__isbestmatch_))),COUNT(__d1(__NN(_add__input__isbestmatch_)))},
    {'Event','FraudgovKEL.PersonEventTypes','DeceasedDate',COUNT(__d1(__NL(Deceased_Date_))),COUNT(__d1(__NN(Deceased_Date_)))},
    {'Event','FraudgovKEL.PersonEventTypes','DeceasedDateOfBirth',COUNT(__d1(__NL(Deceased_Date_Of_Birth_))),COUNT(__d1(__NN(Deceased_Date_Of_Birth_)))},
    {'Event','FraudgovKEL.PersonEventTypes','DeceasedFirst',COUNT(__d1(__NL(Deceased_First_))),COUNT(__d1(__NN(Deceased_First_)))},
    {'Event','FraudgovKEL.PersonEventTypes','DeceasedMiddle',COUNT(__d1(__NL(Deceased_Middle_))),COUNT(__d1(__NN(Deceased_Middle_)))},
    {'Event','FraudgovKEL.PersonEventTypes','DeceasedLast',COUNT(__d1(__NL(Deceased_Last_))),COUNT(__d1(__NN(Deceased_Last_)))},
    {'Event','FraudgovKEL.PersonEventTypes','DeceasedMatchCode',COUNT(__d1(__NL(Deceased_Match_Code_))),COUNT(__d1(__NN(Deceased_Match_Code_)))},
    {'Event','FraudgovKEL.PersonEventTypes','isdeepdive',COUNT(__d1(__NL(_isdeepdive_))),COUNT(__d1(__NN(_isdeepdive_)))},
    {'Event','FraudgovKEL.PersonEventTypes','county_death',COUNT(__d1(__NL(_county__death_))),COUNT(__d1(__NN(_county__death_)))},
    {'Event','FraudgovKEL.PersonEventTypes','DeceasedSsn',COUNT(__d1(__NL(Deceased_Ssn_))),COUNT(__d1(__NN(Deceased_Ssn_)))},
    {'Event','FraudgovKEL.PersonEventTypes','state_death_flag',COUNT(__d1(__NL(_state__death__flag_))),COUNT(__d1(__NN(_state__death__flag_)))},
    {'Event','FraudgovKEL.PersonEventTypes','death_rec_src',COUNT(__d1(__NL(_death__rec__src_))),COUNT(__d1(__NN(_death__rec__src_)))},
    {'Event','FraudgovKEL.PersonEventTypes','state_death_id',COUNT(__d1(__NL(_state__death__id_))),COUNT(__d1(__NN(_state__death__id_)))},
    {'Event','FraudgovKEL.PersonEventTypes','curr_incar_flag',COUNT(__d1(__NL(_curr__incar__flag_))),COUNT(__d1(__NN(_curr__incar__flag_)))},
    {'Event','FraudgovKEL.PersonEventTypes','off_cat_list',COUNT(__d1(__NL(_off__cat__list_))),COUNT(__d1(__NN(_off__cat__list_)))},
    {'Event','FraudgovKEL.PersonEventTypes','name_ssn_dob_match',COUNT(__d1(__NL(_name__ssn__dob__match_))),COUNT(__d1(__NN(_name__ssn__dob__match_)))},
    {'Event','FraudgovKEL.PersonEventTypes','ip_address',COUNT(__d1(__NL(Ip_Address_))),COUNT(__d1(__NN(Ip_Address_)))},
    {'Event','FraudgovKEL.PersonEventTypes','iprngbeg',COUNT(__d1(__NL(_iprngbeg_))),COUNT(__d1(__NN(_iprngbeg_)))},
    {'Event','FraudgovKEL.PersonEventTypes','iprngend',COUNT(__d1(__NL(_iprngend_))),COUNT(__d1(__NN(_iprngend_)))},
    {'Event','FraudgovKEL.PersonEventTypes','edgecountry',COUNT(__d1(__NL(_edgecountry_))),COUNT(__d1(__NN(_edgecountry_)))},
    {'Event','FraudgovKEL.PersonEventTypes','edgeregion',COUNT(__d1(__NL(_edgeregion_))),COUNT(__d1(__NN(_edgeregion_)))},
    {'Event','FraudgovKEL.PersonEventTypes','edgecity',COUNT(__d1(__NL(_edgecity_))),COUNT(__d1(__NN(_edgecity_)))},
    {'Event','FraudgovKEL.PersonEventTypes','edgeconnspeed',COUNT(__d1(__NL(_edgeconnspeed_))),COUNT(__d1(__NN(_edgeconnspeed_)))},
    {'Event','FraudgovKEL.PersonEventTypes','edgemetrocode',COUNT(__d1(__NL(_edgemetrocode_))),COUNT(__d1(__NN(_edgemetrocode_)))},
    {'Event','FraudgovKEL.PersonEventTypes','edgelatitude',COUNT(__d1(__NL(_edgelatitude_))),COUNT(__d1(__NN(_edgelatitude_)))},
    {'Event','FraudgovKEL.PersonEventTypes','edgelongitude',COUNT(__d1(__NL(_edgelongitude_))),COUNT(__d1(__NN(_edgelongitude_)))},
    {'Event','FraudgovKEL.PersonEventTypes','edgepostalcode',COUNT(__d1(__NL(_edgepostalcode_))),COUNT(__d1(__NN(_edgepostalcode_)))},
    {'Event','FraudgovKEL.PersonEventTypes','edgecountrycode',COUNT(__d1(__NL(_edgecountrycode_))),COUNT(__d1(__NN(_edgecountrycode_)))},
    {'Event','FraudgovKEL.PersonEventTypes','edgeregioncode',COUNT(__d1(__NL(_edgeregioncode_))),COUNT(__d1(__NN(_edgeregioncode_)))},
    {'Event','FraudgovKEL.PersonEventTypes','edgecitycode',COUNT(__d1(__NL(_edgecitycode_))),COUNT(__d1(__NN(_edgecitycode_)))},
    {'Event','FraudgovKEL.PersonEventTypes','edgecontinentcode',COUNT(__d1(__NL(_edgecontinentcode_))),COUNT(__d1(__NN(_edgecontinentcode_)))},
    {'Event','FraudgovKEL.PersonEventTypes','edgetwolettercountry',COUNT(__d1(__NL(_edgetwolettercountry_))),COUNT(__d1(__NN(_edgetwolettercountry_)))},
    {'Event','FraudgovKEL.PersonEventTypes','edgeinternalcode',COUNT(__d1(__NL(_edgeinternalcode_))),COUNT(__d1(__NN(_edgeinternalcode_)))},
    {'Event','FraudgovKEL.PersonEventTypes','edgeareacodes',COUNT(__d1(__NL(_edgeareacodes_))),COUNT(__d1(__NN(_edgeareacodes_)))},
    {'Event','FraudgovKEL.PersonEventTypes','edgecountryconf',COUNT(__d1(__NL(_edgecountryconf_))),COUNT(__d1(__NN(_edgecountryconf_)))},
    {'Event','FraudgovKEL.PersonEventTypes','edgeregionconf',COUNT(__d1(__NL(_edgeregionconf_))),COUNT(__d1(__NN(_edgeregionconf_)))},
    {'Event','FraudgovKEL.PersonEventTypes','edgecitycong',COUNT(__d1(__NL(_edgecitycong_))),COUNT(__d1(__NN(_edgecitycong_)))},
    {'Event','FraudgovKEL.PersonEventTypes','edgepostalconf',COUNT(__d1(__NL(_edgepostalconf_))),COUNT(__d1(__NN(_edgepostalconf_)))},
    {'Event','FraudgovKEL.PersonEventTypes','edgegmtoffset',COUNT(__d1(__NL(_edgegmtoffset_))),COUNT(__d1(__NN(_edgegmtoffset_)))},
    {'Event','FraudgovKEL.PersonEventTypes','edgeindst',COUNT(__d1(__NL(_edgeindst_))),COUNT(__d1(__NN(_edgeindst_)))},
    {'Event','FraudgovKEL.PersonEventTypes','siccode',COUNT(__d1(__NL(_siccode_))),COUNT(__d1(__NN(_siccode_)))},
    {'Event','FraudgovKEL.PersonEventTypes','domainname',COUNT(__d1(__NL(_domainname_))),COUNT(__d1(__NN(_domainname_)))},
    {'Event','FraudgovKEL.PersonEventTypes','ispname',COUNT(__d1(__NL(_ispname_))),COUNT(__d1(__NN(_ispname_)))},
    {'Event','FraudgovKEL.PersonEventTypes','homebiztype',COUNT(__d1(__NL(_homebiztype_))),COUNT(__d1(__NN(_homebiztype_)))},
    {'Event','FraudgovKEL.PersonEventTypes','asn',COUNT(__d1(__NL(_asn_))),COUNT(__d1(__NN(_asn_)))},
    {'Event','FraudgovKEL.PersonEventTypes','asnname',COUNT(__d1(__NL(_asnname_))),COUNT(__d1(__NN(_asnname_)))},
    {'Event','FraudgovKEL.PersonEventTypes','primarylang',COUNT(__d1(__NL(_primarylang_))),COUNT(__d1(__NN(_primarylang_)))},
    {'Event','FraudgovKEL.PersonEventTypes','secondarylang',COUNT(__d1(__NL(_secondarylang_))),COUNT(__d1(__NN(_secondarylang_)))},
    {'Event','FraudgovKEL.PersonEventTypes','proxytype',COUNT(__d1(__NL(_proxytype_))),COUNT(__d1(__NN(_proxytype_)))},
    {'Event','FraudgovKEL.PersonEventTypes','proxydescription',COUNT(__d1(__NL(_proxydescription_))),COUNT(__d1(__NN(_proxydescription_)))},
    {'Event','FraudgovKEL.PersonEventTypes','isanisp',COUNT(__d1(__NL(_isanisp_))),COUNT(__d1(__NN(_isanisp_)))},
    {'Event','FraudgovKEL.PersonEventTypes','companyname',COUNT(__d1(__NL(_companyname_))),COUNT(__d1(__NN(_companyname_)))},
    {'Event','FraudgovKEL.PersonEventTypes','ranks',COUNT(__d1(__NL(_ranks_))),COUNT(__d1(__NN(_ranks_)))},
    {'Event','FraudgovKEL.PersonEventTypes','households',COUNT(__d1(__NL(_households_))),COUNT(__d1(__NN(_households_)))},
    {'Event','FraudgovKEL.PersonEventTypes','women',COUNT(__d1(__NL(_women_))),COUNT(__d1(__NN(_women_)))},
    {'Event','FraudgovKEL.PersonEventTypes','women18to34',COUNT(__d1(__NL(_women18to34_))),COUNT(__d1(__NN(_women18to34_)))},
    {'Event','FraudgovKEL.PersonEventTypes','women35to49',COUNT(__d1(__NL(_women35to49_))),COUNT(__d1(__NN(_women35to49_)))},
    {'Event','FraudgovKEL.PersonEventTypes','men',COUNT(__d1(__NL(_men_))),COUNT(__d1(__NN(_men_)))},
    {'Event','FraudgovKEL.PersonEventTypes','men18to34',COUNT(__d1(__NL(_men18to34_))),COUNT(__d1(__NN(_men18to34_)))},
    {'Event','FraudgovKEL.PersonEventTypes','men35to49',COUNT(__d1(__NL(_men35to49_))),COUNT(__d1(__NN(_men35to49_)))},
    {'Event','FraudgovKEL.PersonEventTypes','teens',COUNT(__d1(__NL(_teens_))),COUNT(__d1(__NN(_teens_)))},
    {'Event','FraudgovKEL.PersonEventTypes','kids',COUNT(__d1(__NL(_kids_))),COUNT(__d1(__NN(_kids_)))},
    {'Event','FraudgovKEL.PersonEventTypes','naicscode',COUNT(__d1(__NL(_naicscode_))),COUNT(__d1(__NN(_naicscode_)))},
    {'Event','FraudgovKEL.PersonEventTypes','cbsacode',COUNT(__d1(__NL(_cbsacode_))),COUNT(__d1(__NN(_cbsacode_)))},
    {'Event','FraudgovKEL.PersonEventTypes','cbsatitle',COUNT(__d1(__NL(_cbsatitle_))),COUNT(__d1(__NN(_cbsatitle_)))},
    {'Event','FraudgovKEL.PersonEventTypes','cbsatype',COUNT(__d1(__NL(_cbsatype_))),COUNT(__d1(__NN(_cbsatype_)))},
    {'Event','FraudgovKEL.PersonEventTypes','csacode',COUNT(__d1(__NL(_csacode_))),COUNT(__d1(__NN(_csacode_)))},
    {'Event','FraudgovKEL.PersonEventTypes','csatitle',COUNT(__d1(__NL(_csatitle_))),COUNT(__d1(__NN(_csatitle_)))},
    {'Event','FraudgovKEL.PersonEventTypes','mdcode',COUNT(__d1(__NL(_mdcode_))),COUNT(__d1(__NN(_mdcode_)))},
    {'Event','FraudgovKEL.PersonEventTypes','mdtitle',COUNT(__d1(__NL(_mdtitle_))),COUNT(__d1(__NN(_mdtitle_)))},
    {'Event','FraudgovKEL.PersonEventTypes','organizationname',COUNT(__d1(__NL(_organizationname_))),COUNT(__d1(__NN(_organizationname_)))},
    {'Event','FraudgovKEL.PersonEventTypes','advo_hitflag',COUNT(__d1(__NL(_advo__hitflag_))),COUNT(__d1(__NN(_advo__hitflag_)))},
    {'Event','FraudgovKEL.PersonEventTypes','advo_vacancyindicator',COUNT(__d1(__NL(_advo__vacancyindicator_))),COUNT(__d1(__NN(_advo__vacancyindicator_)))},
    {'Event','FraudgovKEL.PersonEventTypes','advo_addressstyle',COUNT(__d1(__NL(_advo__addressstyle_))),COUNT(__d1(__NN(_advo__addressstyle_)))},
    {'Event','FraudgovKEL.PersonEventTypes','advo_dropindicator',COUNT(__d1(__NL(_advo__dropindicator_))),COUNT(__d1(__NN(_advo__dropindicator_)))},
    {'Event','FraudgovKEL.PersonEventTypes','advo_residentialorbusinessindicator',COUNT(__d1(__NL(_advo__residentialorbusinessindicator_))),COUNT(__d1(__NN(_advo__residentialorbusinessindicator_)))},
    {'Event','FraudgovKEL.PersonEventTypes','advo_addresstype',COUNT(__d1(__NL(_advo__addresstype_))),COUNT(__d1(__NN(_advo__addresstype_)))},
    {'Event','FraudgovKEL.PersonEventTypes','advo_addressusagetype',COUNT(__d1(__NL(_advo__addressusagetype_))),COUNT(__d1(__NN(_advo__addressusagetype_)))},
    {'Event','FraudgovKEL.PersonEventTypes','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Event','FraudgovKEL.PersonEventTypes','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
