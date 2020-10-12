﻿//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT B_Event_2,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM RiskIntelligenceNetwork_Analytics;
IMPORT * FROM KEL11.Null;
EXPORT B_Event_1 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_2.__ENH_Event_2) __ENH_Event_2 := B_Event_2.__ENH_Event_2;
  SHARED __EE48467 := __ENH_Event_2;
  SHARED __EE47330 := __E_Customer;
  SHARED __ST49122_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Record_Id_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Source_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) _r_Email_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) _r_Ssn_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Phone.Typ) _r_Phone_;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) _r_Internet_Protocol_;
    KEL.typ.ntyp(E_Bank_Account.Typ) _r_Bank_Account_;
    KEL.typ.ntyp(E_Drivers_License.Typ) _r_Drivers_License_;
    KEL.typ.nstr Otto_Email_Id_;
    KEL.typ.nstr Otto_Ip_Address_Id_;
    KEL.typ.nstr Otto_S_S_N_Id_;
    KEL.typ.nstr Case_Id_;
    KEL.typ.nstr Client_Id_;
    KEL.typ.nstr Otto_Drivers_License_Id_;
    KEL.typ.nstr Otto_Bank_Account_Id_;
    KEL.typ.nint _rin__source_;
    KEL.typ.nint Lex_Id_;
    KEL.typ.nstr Otto_Address_Id_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nstr Title_;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Middle_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nstr Name_Suffix_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nkdate Deceased_Date_;
    KEL.typ.nkdate Deceased_Date_Of_Birth_;
    KEL.typ.nstr Deceased_First_;
    KEL.typ.nstr Deceased_Middle_;
    KEL.typ.nstr Deceased_Last_;
    KEL.typ.nstr _unique__number_;
    KEL.typ.nstr _mac__address_;
    KEL.typ.nstr _serial__number_;
    KEL.typ.nstr _device__type_;
    KEL.typ.nstr _device__identification__provider_;
    KEL.typ.nstr Deceased_Match_Code_;
    KEL.typ.nbool _isdeepdive_;
    KEL.typ.nbool Bocashell_Hit_;
    KEL.typ.nint Bocashell_Lex_Id_;
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
    KEL.typ.nstr _historydatetimestamp_;
    KEL.typ.nkdate _reported__dob_;
    KEL.typ.nkdate _bocashell__addr1__dt__first__seen_;
    KEL.typ.nkdate _bocashell__addr1__date__last__seen_;
    KEL.typ.nbool _diddeceased_;
    KEL.typ.nkdate _diddeceaseddate_;
    KEL.typ.nstr _fraudpoint__v3_;
    KEL.typ.nbool Best_Hit_;
    KEL.typ.nstr _best__phone_;
    KEL.typ.nstr _best__drivers__license__state_;
    KEL.typ.nstr _best__drivers__license_;
    KEL.typ.nstr _best__drivers__license__exp_;
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
    KEL.typ.nstr _address__vacancy__indicator_;
    KEL.typ.nstr _addrvalflag_;
    KEL.typ.nstr _drop__indicator_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr License_State_;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nbool Phones_Meta_Hit_;
    KEL.typ.nstr _phone__prepaid_;
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
    KEL.typ.nbool Crim_Hit_;
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
    KEL.typ.nint _event__type__1_;
    KEL.typ.nint _event__type__2_;
    KEL.typ.nint _event__type__3_;
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
    KEL.typ.int No_Lex_Id_ := 0;
    KEL.typ.int T15___Ssn_Is_Kr_Flag_ := 0;
    KEL.typ.int T15___Ssn_Pop_Flag_ := 0;
    KEL.typ.int T16___Phn_Is_Kr_Flag_ := 0;
    KEL.typ.int T16___Phn_Pop_Flag_ := 0;
    KEL.typ.int T17___Email_Is_Kr_Flag_ := 0;
    KEL.typ.int T17___Email_Pop_Flag_ := 0;
    KEL.typ.int T18___Ip_Addr_Is_Kr_Flag_ := 0;
    KEL.typ.int T18___Ip_Addr_Pop_Flag_ := 0;
    KEL.typ.int T18___Is_Ip_Meta_Hit_Flag_ := 0;
    KEL.typ.int T19___Bnk_Acct_Is_Kr_Flag_ := 0;
    KEL.typ.int T19___Bnk_Acct_Pop_Flag_ := 0;
    KEL.typ.int T1_L___Bc_Shll_Lex_Id_Matches_Inp_Flag_ := 0;
    KEL.typ.nstr T1_L___Best_Dl_Echo_;
    KEL.typ.nstr T1_L___Best_Dl_St_Echo_;
    KEL.typ.int T1_L___Id_Crim_Hit_Flag_ := 0;
    KEL.typ.int T1_L___Id_Deceased_Flag_ := 0;
    KEL.typ.nint T1_L___Id_Dt_Of_Death_;
    KEL.typ.int T1_L___Id_Is_Bc_Shll_Hit_Flag_ := 0;
    KEL.typ.int T1_L___Lex_Id_Seen_Flag_ := 0;
    KEL.typ.int T1___Id_Is_Kr_App_Frd_Flag_ := 0;
    KEL.typ.int T1___Id_Is_Kr_Gen_Frd_Flag_ := 0;
    KEL.typ.int T1___Id_Is_Kr_Oth_Frd_Flag_ := 0;
    KEL.typ.int T1___Id_Is_Kr_Stol_Id_Flag_ := 0;
    KEL.typ.int T1___Lex_Id_Pop_Flag_ := 0;
    KEL.typ.int T1___Rin_Id_Pop_Flag_ := 0;
    KEL.typ.int T20___Dl_Is_Kr_Flag_ := 0;
    KEL.typ.int T20___Dl_Pop_Flag_ := 0;
    KEL.typ.int T9___Addr_Is_Kr_Flag_ := 0;
    KEL.typ.int T9___Addr_Pop_Flag_ := 0;
    KEL.typ.nkdate T___Act_Dt_Echo_;
    KEL.typ.int T___Dob_Pop_Flag_ := 0;
    KEL.typ.int T___First_Nm_Pop_Flag_ := 0;
    KEL.typ.int T___In_Agency_Flag_ := 0;
    KEL.typ.nstr T___Inp_Cln_Addr_City_Echo_;
    KEL.typ.nstr T___Inp_Cln_Addr_Prim_Nm_Echo_;
    KEL.typ.nstr T___Inp_Cln_Addr_St_Echo_;
    KEL.typ.nstr T___Inp_Cln_Addr_Zip5_Echo_;
    KEL.typ.nstr T___Inp_Cln_Bnk_Acct_Echo_;
    KEL.typ.nstr T___Inp_Cln_Bnk_Acct_Rtg_Echo_;
    KEL.typ.nstr T___Inp_Cln_Dl_Echo_;
    KEL.typ.nstr T___Inp_Cln_Dl_St_Echo_;
    KEL.typ.nint T___Inp_Cln_Dob_Echo_;
    KEL.typ.nstr T___Inp_Cln_Email_Echo_;
    KEL.typ.nstr T___Inp_Cln_First_Nm_Echo_;
    KEL.typ.nstr T___Inp_Cln_Ip_Addr_Echo_;
    KEL.typ.nstr T___Inp_Cln_Last_Nm_Echo_;
    KEL.typ.nstr T___Inp_Cln_Phn_Echo_;
    KEL.typ.nstr T___Inp_Cln_Ssn_Echo_;
    KEL.typ.int T___Is_Bc_Shll_Hit_Flag_ := 0;
    KEL.typ.int T___Last_Nm_Pop_Flag_ := 0;
    KEL.typ.nint T___Person_Uid_Echo_;
    KEL.typ.int T___Src_Class_Type_ := 0;
    KEL.typ.nint T___Src_Type_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nstr Jurisdiction_State_;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  __JC51692(B_Event_2.__ST16083_Layout __EE48467, E_Customer.Layout __EE47330) := __EEQP(__EE48467._r_Customer_,__EE47330.UID) AND __EE48467.__Part = __EE47330.__Part;
  __ST49122_Layout __JT51692(B_Event_2.__ST16083_Layout __l, E_Customer.Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE51693 := JOIN(__EE48467,__EE47330,__JC51692(LEFT,RIGHT),__JT51692(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST22770_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Record_Id_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Source_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) _r_Email_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) _r_Ssn_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Phone.Typ) _r_Phone_;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) _r_Internet_Protocol_;
    KEL.typ.ntyp(E_Bank_Account.Typ) _r_Bank_Account_;
    KEL.typ.ntyp(E_Drivers_License.Typ) _r_Drivers_License_;
    KEL.typ.nstr Otto_Email_Id_;
    KEL.typ.nstr Otto_Ip_Address_Id_;
    KEL.typ.nstr Otto_S_S_N_Id_;
    KEL.typ.nstr Case_Id_;
    KEL.typ.nstr Client_Id_;
    KEL.typ.nstr Otto_Drivers_License_Id_;
    KEL.typ.nstr Otto_Bank_Account_Id_;
    KEL.typ.nint _rin__source_;
    KEL.typ.nint Lex_Id_;
    KEL.typ.nstr Otto_Address_Id_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nstr Title_;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Middle_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nstr Name_Suffix_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nkdate Deceased_Date_;
    KEL.typ.nkdate Deceased_Date_Of_Birth_;
    KEL.typ.nstr Deceased_First_;
    KEL.typ.nstr Deceased_Middle_;
    KEL.typ.nstr Deceased_Last_;
    KEL.typ.nstr _unique__number_;
    KEL.typ.nstr _mac__address_;
    KEL.typ.nstr _serial__number_;
    KEL.typ.nstr _device__type_;
    KEL.typ.nstr _device__identification__provider_;
    KEL.typ.nstr Deceased_Match_Code_;
    KEL.typ.nbool _isdeepdive_;
    KEL.typ.nbool Bocashell_Hit_;
    KEL.typ.nint Bocashell_Lex_Id_;
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
    KEL.typ.nstr _historydatetimestamp_;
    KEL.typ.nkdate _reported__dob_;
    KEL.typ.nkdate _bocashell__addr1__dt__first__seen_;
    KEL.typ.nkdate _bocashell__addr1__date__last__seen_;
    KEL.typ.nbool _diddeceased_;
    KEL.typ.nkdate _diddeceaseddate_;
    KEL.typ.nstr _fraudpoint__v3_;
    KEL.typ.nbool Best_Hit_;
    KEL.typ.nstr _best__phone_;
    KEL.typ.nstr _best__drivers__license__state_;
    KEL.typ.nstr _best__drivers__license_;
    KEL.typ.nstr _best__drivers__license__exp_;
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
    KEL.typ.nstr _address__vacancy__indicator_;
    KEL.typ.nstr _addrvalflag_;
    KEL.typ.nstr _drop__indicator_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr License_State_;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nbool Phones_Meta_Hit_;
    KEL.typ.nstr _phone__prepaid_;
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
    KEL.typ.nbool Crim_Hit_;
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
    KEL.typ.nint _event__type__1_;
    KEL.typ.nint _event__type__2_;
    KEL.typ.nint _event__type__3_;
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
    KEL.typ.nstr Agency_Prog_Jur_St_;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.nint Id_Age_;
    KEL.typ.int No_Lex_Id_ := 0;
    KEL.typ.int P15___Aot_Ssn_Kr_Act_Cnt_Ev_ := 0;
    KEL.typ.int P16___Aot_Phn_Kr_Act_Cnt_Ev_ := 0;
    KEL.typ.int P17___Aot_Email_Kr_Act_Cnt_Ev_ := 0;
    KEL.typ.int P18___Aot_Ip_Addr_Kr_Act_Cnt_Ev_ := 0;
    KEL.typ.int P19___Aot_Bnk_Acct_Kr_Act_Cnt_Ev_ := 0;
    KEL.typ.int P1___Aot_Id_Kr_App_Frd_Act_Cnt_Ev_ := 0;
    KEL.typ.int P1___Aot_Id_Kr_Gen_Frd_Act_Cnt_Ev_ := 0;
    KEL.typ.int P1___Aot_Id_Kr_Oth_Frd_Act_Cnt_Ev_ := 0;
    KEL.typ.int P1___Aot_Id_Kr_Stol_Id_Act_Cnt_Ev_ := 0;
    KEL.typ.int P20___Aot_Dl_Kr_Act_Cnt_Ev_ := 0;
    KEL.typ.int P9___Aot_Addr_Kr_Act_Cnt_Ev_ := 0;
    KEL.typ.int T15___Ssn_Pop_Flag_ := 0;
    KEL.typ.nstr T15___Ssn_Val_Type_;
    KEL.typ.int T16___Is_Phn_Meta_Hit_Flag_ := 0;
    KEL.typ.int T16___Phn_Pop_Flag_ := 0;
    KEL.typ.nint T16___Phn_Val_Type_;
    KEL.typ.int T17___Email_Pop_Flag_ := 0;
    KEL.typ.nstr T18___Ip_Addr_City_;
    KEL.typ.nstr T18___Ip_Addr_Country_;
    KEL.typ.int T18___Ip_Addr_Pop_Flag_ := 0;
    KEL.typ.nstr T18___Ip_Addr_Proxy_Desc_;
    KEL.typ.nstr T18___Ip_Addr_Proxy_Type_;
    KEL.typ.int T18___Is_Ip_Meta_Hit_Flag_ := 0;
    KEL.typ.int T19___Bnk_Acct_Pop_Flag_ := 0;
    KEL.typ.int T19___Is_Bnk_App_Hit_Flag_ := 0;
    KEL.typ.int T1_L___Best_Dl_Pop_Flag_ := 0;
    KEL.typ.nstr T1_L___Best_Dl_St_Echo_;
    KEL.typ.int T1_L___Curr_Addr_Pop_Flag_ := 0;
    KEL.typ.nstr T1_L___Curr_Addr_St_Echo_;
    KEL.typ.nint T1_L___Dob_Ver_Indx_;
    KEL.typ.nint T1_L___Fp___Source_Risk_Level_;
    KEL.typ.nint T1_L___Id_Crim_Fl_Sd_Match_Flag_;
    KEL.typ.int T1_L___Id_Crim_Hit_Flag_ := 0;
    KEL.typ.int T1_L___Id_Deceased_Flag_ := 0;
    KEL.typ.nint T1_L___Id_Dt_Of_Death_;
    KEL.typ.int T1_L___Id_Dt_Of_Death_Aft_Id_Act_Cnt_Ev_ := 0;
    KEL.typ.int T1_L___Id_Is_Bc_Shll_Hit_Flag_ := 0;
    KEL.typ.nint T1_L___Nas_Summary_;
    KEL.typ.nint T1___Cvi_;
    KEL.typ.nint T1___Fp3___Manip_Identity_Index_;
    KEL.typ.nint T1___Fp3___Stolen_Identity_Index_;
    KEL.typ.nint T1___Fp3___Synthetic_Identity_Index_;
    KEL.typ.nint T1___Id_Age_;
    KEL.typ.int T1___Lex_Id_Pop_Flag_ := 0;
    KEL.typ.nint T1___Nap_Summary_;
    KEL.typ.int T1___Rin_Id_Pop_Flag_ := 0;
    KEL.typ.int T20___Dl_Pop_Flag_ := 0;
    KEL.typ.nstr T20___Dl_Val_Type_;
    KEL.typ.nstr T9___Addr_Mail_Drop_Type_;
    KEL.typ.int T9___Addr_Pop_Flag_ := 0;
    KEL.typ.nstr T9___Addr_Val_Type_;
    KEL.typ.nkdate T___Act_Dt_Echo_;
    KEL.typ.int T___Dob_Pop_Flag_ := 0;
    KEL.typ.int T___First_Nm_Pop_Flag_ := 0;
    KEL.typ.nstr T___Inp_Cln_Addr_City_Echo_;
    KEL.typ.nstr T___Inp_Cln_Addr_Prim_Nm_Echo_;
    KEL.typ.nstr T___Inp_Cln_Addr_St_Echo_;
    KEL.typ.nstr T___Inp_Cln_Addr_Zip5_Echo_;
    KEL.typ.nstr T___Inp_Cln_Bnk_Acct_Echo_;
    KEL.typ.nstr T___Inp_Cln_Bnk_Acct_Rtg_Echo_;
    KEL.typ.nstr T___Inp_Cln_Dl_St_Echo_;
    KEL.typ.nint T___Inp_Cln_Dob_Echo_;
    KEL.typ.nstr T___Inp_Cln_Email_Echo_;
    KEL.typ.nstr T___Inp_Cln_First_Nm_Echo_;
    KEL.typ.nstr T___Inp_Cln_Ip_Addr_Echo_;
    KEL.typ.nstr T___Inp_Cln_Last_Nm_Echo_;
    KEL.typ.nstr T___Inp_Cln_Middle_Nm_Echo_;
    KEL.typ.nstr T___Inp_Cln_Phn_Echo_;
    KEL.typ.nstr T___Inp_Cln_Ssn_Echo_;
    KEL.typ.int T___Is_Bc_Shll_Hit_Flag_ := 0;
    KEL.typ.int T___Last_Nm_Pop_Flag_ := 0;
    KEL.typ.nint T___Person_Uid_Echo_;
    KEL.typ.int T___Src_Class_Type_ := 0;
    KEL.typ.nint T___Src_Type_;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  SHARED __ST22770_Layout __ND52004__Project(__ST49122_Layout __PP51365) := TRANSFORM
    SELF.Agency_Prog_Jur_St_ := __PP51365.Jurisdiction_State_;
    SELF.Deceased_ := MAP(__T(__FN1(KEL.Routines.IsValidDate,__PP51365.Deceased_Date_))=>1,0);
    SELF.Deceased_Dob_Match_ := MAP(__T(__OP2(__PP51365.Deceased_Date_Of_Birth_,=,__PP51365.Date_Of_Birth_))=>1,0);
    SELF.Deceased_Name_Match_ := MAP(__T(__AND(__OP2(__PP51365.First_Name_,=,__PP51365.Deceased_First_),__OP2(__PP51365.Last_Name_,=,__PP51365.Deceased_Last_)))=>1,0);
    SELF.Id_Age_ := __FN2(KEL.Routines.YearsBetween,__PP51365.Date_Of_Birth_,__PP51365.Event_Date_);
    SELF.P15___Aot_Ssn_Kr_Act_Cnt_Ev_ := MAP(__PP51365.T15___Ssn_Pop_Flag_ = 0=> -99999,__PP51365.T___Src_Class_Type_ < 2=> -99998,__PP51365.T15___Ssn_Is_Kr_Flag_ = -99997=> -99997,__PP51365.T15___Ssn_Is_Kr_Flag_ = 1 AND __PP51365.T___In_Agency_Flag_ = 1=>1,0);
    SELF.P16___Aot_Phn_Kr_Act_Cnt_Ev_ := MAP(__PP51365.T16___Phn_Pop_Flag_ = 0=> -99999,__PP51365.T___Src_Class_Type_ < 2=> -99998,__PP51365.T16___Phn_Is_Kr_Flag_ = -99997=> -99997,__PP51365.T16___Phn_Is_Kr_Flag_ = 1 AND __PP51365.T___In_Agency_Flag_ = 1=>1,0);
    SELF.P17___Aot_Email_Kr_Act_Cnt_Ev_ := MAP(__PP51365.T17___Email_Pop_Flag_ = 0=> -99999,__PP51365.T___Src_Class_Type_ < 2=> -99998,__PP51365.T17___Email_Is_Kr_Flag_ = -99997=> -99997,__PP51365.T17___Email_Is_Kr_Flag_ = 1 AND __PP51365.T___In_Agency_Flag_ = 1=>1,0);
    SELF.P18___Aot_Ip_Addr_Kr_Act_Cnt_Ev_ := MAP(__PP51365.T18___Ip_Addr_Pop_Flag_ = 0=> -99999,__PP51365.T___Src_Class_Type_ < 2=> -99998,__PP51365.T18___Ip_Addr_Is_Kr_Flag_ = -99997=> -99997,__PP51365.T18___Ip_Addr_Is_Kr_Flag_ = 1 AND __PP51365.T___In_Agency_Flag_ = 1=>1,0);
    SELF.P19___Aot_Bnk_Acct_Kr_Act_Cnt_Ev_ := MAP(__PP51365.T19___Bnk_Acct_Pop_Flag_ = 0=> -99999,__PP51365.T___Src_Class_Type_ < 2=> -99998,__PP51365.T19___Bnk_Acct_Is_Kr_Flag_ = -99997=> -99997,__PP51365.T19___Bnk_Acct_Is_Kr_Flag_ = 1 AND __PP51365.T___In_Agency_Flag_ = 1=>1,0);
    SELF.P1___Aot_Id_Kr_App_Frd_Act_Cnt_Ev_ := MAP(__PP51365.T1___Lex_Id_Pop_Flag_ = 0 AND __PP51365.T1___Rin_Id_Pop_Flag_ = 0=> -99999,__PP51365.T___Src_Class_Type_ < 2=> -99998,__PP51365.T1___Id_Is_Kr_App_Frd_Flag_ = -99997=> -99997,__PP51365.T1___Id_Is_Kr_App_Frd_Flag_ = 1 AND __PP51365.T___In_Agency_Flag_ = 1=>1,0);
    SELF.P1___Aot_Id_Kr_Gen_Frd_Act_Cnt_Ev_ := MAP(__PP51365.T1___Lex_Id_Pop_Flag_ = 0 AND __PP51365.T1___Rin_Id_Pop_Flag_ = 0=> -99999,__PP51365.T___Src_Class_Type_ < 2=> -99998,__PP51365.T1___Id_Is_Kr_Gen_Frd_Flag_ = -99997=> -99997,__PP51365.T1___Id_Is_Kr_Gen_Frd_Flag_ = 1 AND __PP51365.T___In_Agency_Flag_ = 1=>1,0);
    SELF.P1___Aot_Id_Kr_Oth_Frd_Act_Cnt_Ev_ := MAP(__PP51365.T1___Lex_Id_Pop_Flag_ = 0 AND __PP51365.T1___Rin_Id_Pop_Flag_ = 0=> -99999,__PP51365.T___Src_Class_Type_ < 2=> -99998,__PP51365.T1___Id_Is_Kr_Oth_Frd_Flag_ = -99997=> -99997,__PP51365.T1___Id_Is_Kr_Oth_Frd_Flag_ = 1 AND __PP51365.T___In_Agency_Flag_ = 1=>1,0);
    SELF.P1___Aot_Id_Kr_Stol_Id_Act_Cnt_Ev_ := MAP(__PP51365.T1___Lex_Id_Pop_Flag_ = 0 AND __PP51365.T1___Rin_Id_Pop_Flag_ = 0=> -99999,__PP51365.T___Src_Class_Type_ < 2=> -99998,__PP51365.T1___Id_Is_Kr_Stol_Id_Flag_ = -99997=> -99997,__PP51365.T1___Id_Is_Kr_Stol_Id_Flag_ = 1 AND __PP51365.T___In_Agency_Flag_ = 1=>1,0);
    SELF.P20___Aot_Dl_Kr_Act_Cnt_Ev_ := MAP(__PP51365.T20___Dl_Pop_Flag_ = 0=> -99999,__PP51365.T___Src_Class_Type_ < 2=> -99998,__PP51365.T20___Dl_Is_Kr_Flag_ = -99997=> -99997,__PP51365.T20___Dl_Is_Kr_Flag_ = 1 AND __PP51365.T___In_Agency_Flag_ = 1=>1,0);
    SELF.P9___Aot_Addr_Kr_Act_Cnt_Ev_ := MAP(__PP51365.T9___Addr_Pop_Flag_ = 0=> -99999,__PP51365.T___Src_Class_Type_ < 2=> -99998,__PP51365.T9___Addr_Is_Kr_Flag_ = -99997=> -99997,__PP51365.T9___Addr_Is_Kr_Flag_ = 1 AND __PP51365.T___In_Agency_Flag_ = 1=>1,0);
    SELF.T15___Ssn_Val_Type_ := MAP(__PP51365.T15___Ssn_Pop_Flag_ = 0=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99999))),__PP51365.T___Src_Class_Type_ < 4 OR __PP51365.T___Is_Bc_Shll_Hit_Flag_ < 1=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99998))),__T(__OP2(__ECAST(KEL.typ.nstr,__PP51365._socsvalflag_),=,__CN('')))=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99997))),__ECAST(KEL.typ.nstr,__ECAST(KEL.typ.nstr,__PP51365._socsvalflag_)));
    SELF.T16___Is_Phn_Meta_Hit_Flag_ := MAP(__PP51365.T16___Phn_Pop_Flag_ = 0=> -99999,__T(__OP2(__PP51365.Phones_Meta_Hit_,=,__CN(TRUE)))=>1,0);
    SELF.T16___Phn_Val_Type_ := MAP(__PP51365.T16___Phn_Pop_Flag_ = 0=>__ECAST(KEL.typ.nint,__CN(-99999)),__PP51365.T___Src_Class_Type_ < 4 OR __PP51365.T___Is_Bc_Shll_Hit_Flag_ < 1=>__ECAST(KEL.typ.nint,__CN(-99998)),__T(__OP2(__CAST(KEL.typ.str,__PP51365._hphonevalflag_),=,__CN('')))=>__ECAST(KEL.typ.nint,__CN(-99997)),__ECAST(KEL.typ.nint,__PP51365._hphonevalflag_));
    SELF.T18___Ip_Addr_City_ := MAP(__T(__OP2(__PP51365.T___Inp_Cln_Ip_Addr_Echo_,=,__CAST(KEL.typ.str,__CN(-99999))))=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99999))),__PP51365.T18___Is_Ip_Meta_Hit_Flag_ < 1 OR __PP51365.T___Src_Class_Type_ < 4=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99998))),__T(__OR(__OP2(__PP51365._edgecity_,=,__CN('')),__NT(__PP51365._edgecity_)))=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99997))),__ECAST(KEL.typ.nstr,__PP51365._edgecity_));
    SELF.T18___Ip_Addr_Country_ := MAP(__T(__OP2(__PP51365.T___Inp_Cln_Ip_Addr_Echo_,=,__CAST(KEL.typ.str,__CN(-99999))))=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99999))),__PP51365.T18___Is_Ip_Meta_Hit_Flag_ < 1 OR __PP51365.T___Src_Class_Type_ < 4=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99998))),__T(__OR(__OR(__OP2(__PP51365._edgecountry_,=,__CN('')),__NT(__PP51365._edgecountry_)),__OP2(__PP51365._edgecountry_,=,__CN('0'))))=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99997))),__ECAST(KEL.typ.nstr,__PP51365._edgecountry_));
    SELF.T18___Ip_Addr_Proxy_Desc_ := MAP(__T(__OP2(__PP51365.T___Inp_Cln_Ip_Addr_Echo_,=,__CAST(KEL.typ.str,__CN(-99999))))=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99999))),__PP51365.T18___Is_Ip_Meta_Hit_Flag_ < 1 OR __PP51365.T___Src_Class_Type_ < 4=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99998))),__T(__OR(__OP2(__PP51365._proxydescription_,=,__CN('')),__NT(__PP51365._proxydescription_)))=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99997))),__ECAST(KEL.typ.nstr,__PP51365._proxydescription_));
    SELF.T18___Ip_Addr_Proxy_Type_ := MAP(__T(__OP2(__PP51365.T___Inp_Cln_Ip_Addr_Echo_,=,__CAST(KEL.typ.str,__CN(-99999))))=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99999))),__PP51365.T18___Is_Ip_Meta_Hit_Flag_ < 1 OR __PP51365.T___Src_Class_Type_ < 4=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99998))),__T(__OR(__OP2(__PP51365._proxytype_,=,__CN('')),__NT(__PP51365._proxytype_)))=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99997))),__ECAST(KEL.typ.nstr,__PP51365._proxytype_));
    SELF.T19___Is_Bnk_App_Hit_Flag_ := MAP(__PP51365.T19___Bnk_Acct_Pop_Flag_ = 0=> -99999,__T(__OP2(__PP51365.Bank_Hit_,=,__CAST(KEL.typ.str,__CN(1))))=>1,0);
    SELF.T1_L___Best_Dl_Pop_Flag_ := MAP(__PP51365.T1___Lex_Id_Pop_Flag_ = 0=> -99999,__PP51365.T1_L___Id_Is_Bc_Shll_Hit_Flag_ < 1 OR __PP51365.T___Src_Class_Type_ < 4=> -99998,__T(__OR(__OP2(__PP51365.T1_L___Best_Dl_Echo_,=,__CAST(KEL.typ.str,__CN(-99997))),__OP2(__PP51365.T1_L___Best_Dl_St_Echo_,=,__CAST(KEL.typ.str,__CN(-99997)))))=>0,1);
    SELF.T1_L___Curr_Addr_Pop_Flag_ := MAP(__PP51365.T1___Lex_Id_Pop_Flag_ = 0=> -99999,__PP51365.T1_L___Id_Is_Bc_Shll_Hit_Flag_ < 1 OR __PP51365.T___Src_Class_Type_ < 4=> -99998,__T(__OP2(__PP51365._add__curr__pop_,=,__CN(TRUE)))=>1,0);
    SELF.T1_L___Curr_Addr_St_Echo_ := MAP(__PP51365.T1___Lex_Id_Pop_Flag_ = 0=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99999))),__PP51365.T1_L___Id_Is_Bc_Shll_Hit_Flag_ < 1 OR __PP51365.T___Src_Class_Type_ < 4=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99998))),__T(__OR(__OP2(__PP51365._add__curr__st_,=,__CN('')),__NT(__PP51365._add__curr__st_)))=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99997))),__ECAST(KEL.typ.nstr,__PP51365._add__curr__st_));
    SELF.T1_L___Dob_Ver_Indx_ := MAP(__PP51365.T1___Lex_Id_Pop_Flag_ = 0 OR __PP51365.T___Dob_Pop_Flag_ = 0=>__ECAST(KEL.typ.nint,__CN(-99999)),__PP51365.T1_L___Id_Is_Bc_Shll_Hit_Flag_ < 1 OR __PP51365.T___Src_Class_Type_ < 4=>__ECAST(KEL.typ.nint,__CN(-99998)),__T(__OR(__NT(__PP51365._dobmatchlevel_),__OP2(__PP51365._dobmatchlevel_,=,__CN(0))))=>__ECAST(KEL.typ.nint,__CN(-99997)),__ECAST(KEL.typ.nint,__PP51365._dobmatchlevel_));
    SELF.T1_L___Fp___Source_Risk_Level_ := MAP(__PP51365.T1___Lex_Id_Pop_Flag_ = 0=>__ECAST(KEL.typ.nint,__CN(-99999)),__PP51365.T1_L___Id_Is_Bc_Shll_Hit_Flag_ < 1 OR __PP51365.T___Src_Class_Type_ < 4=>__ECAST(KEL.typ.nint,__CN(-99998)),__T(__OP2(__PP51365._sourcerisklevel_,<,__CN(1)))=>__ECAST(KEL.typ.nint,__CN(-99997)),__ECAST(KEL.typ.nint,__PP51365._sourcerisklevel_));
    SELF.T1_L___Id_Crim_Fl_Sd_Match_Flag_ := MAP(__PP51365.T1___Lex_Id_Pop_Flag_ = 0=>__ECAST(KEL.typ.nint,__CN(-99999)),__PP51365.T1_L___Id_Crim_Hit_Flag_ < 1 OR __PP51365.T___Src_Class_Type_ < 4=>__ECAST(KEL.typ.nint,__CN(-99998)),__PP51365.T___First_Nm_Pop_Flag_ = 0 OR __PP51365.T___Last_Nm_Pop_Flag_ = 0 OR __PP51365.T15___Ssn_Pop_Flag_ = 0 OR __PP51365.T___Dob_Pop_Flag_ = 0=>__ECAST(KEL.typ.nint,__CN(-99997)),__ECAST(KEL.typ.nint,__PP51365._name__ssn__dob__match_));
    SELF.T1_L___Id_Dt_Of_Death_Aft_Id_Act_Cnt_Ev_ := MAP(__PP51365.T1___Lex_Id_Pop_Flag_ = 0=> -99999,__PP51365.T1_L___Id_Deceased_Flag_ < 1 OR __PP51365.T___Src_Class_Type_ < 4=> -99998,__T(__OP2(__PP51365.T1_L___Id_Dt_Of_Death_,=,__CN(-99997)))=> -99997,__T(__OP2(__PP51365.Event_Date_,>,__PP51365._diddeceaseddate_))=>1,0);
    SELF.T1_L___Nas_Summary_ := MAP(__PP51365.T1___Lex_Id_Pop_Flag_ = 0=>__ECAST(KEL.typ.nint,__CN(-99999)),__PP51365.T1_L___Id_Is_Bc_Shll_Hit_Flag_ < 1 OR __PP51365.T___Src_Class_Type_ < 4=>__ECAST(KEL.typ.nint,__CN(-99998)),__ECAST(KEL.typ.nint,__PP51365._nas__summary_));
    SELF.T1___Cvi_ := MAP(__PP51365.T1___Lex_Id_Pop_Flag_ = 0 AND __PP51365.T1___Rin_Id_Pop_Flag_ = 0=>__ECAST(KEL.typ.nint,__CN(-99999)),__PP51365.T___Is_Bc_Shll_Hit_Flag_ < 1 OR __PP51365.T___Src_Class_Type_ < 4=>__ECAST(KEL.typ.nint,__CN(-99998)),__ECAST(KEL.typ.nint,__PP51365._cvi_));
    SELF.T1___Fp3___Manip_Identity_Index_ := MAP(__PP51365.T1___Lex_Id_Pop_Flag_ = 0 AND __PP51365.T1___Rin_Id_Pop_Flag_ = 0=>__ECAST(KEL.typ.nint,__CN(-99999)),__PP51365.T___Is_Bc_Shll_Hit_Flag_ < 1 OR __PP51365.T___Src_Class_Type_ < 4=>__ECAST(KEL.typ.nint,__CN(-99998)),__T(__OR(__OR(__OP2(__CAST(KEL.typ.str,__PP51365._manipulatedidentityindex__v3_),=,__CN('')),__NT(__PP51365._manipulatedidentityindex__v3_)),__OP2(__PP51365._manipulatedidentityindex__v3_,=,__CN(0))))=>__ECAST(KEL.typ.nint,__CN(-99997)),__ECAST(KEL.typ.nint,__PP51365._manipulatedidentityindex__v3_));
    SELF.T1___Fp3___Stolen_Identity_Index_ := MAP(__PP51365.T1___Lex_Id_Pop_Flag_ = 0 AND __PP51365.T1___Rin_Id_Pop_Flag_ = 0=>__ECAST(KEL.typ.nint,__CN(-99999)),__PP51365.T___Is_Bc_Shll_Hit_Flag_ < 1 OR __PP51365.T___Src_Class_Type_ < 4=>__ECAST(KEL.typ.nint,__CN(-99998)),__T(__OR(__OR(__OP2(__CAST(KEL.typ.str,__PP51365._fp3__stolenidentityindex_),=,__CN('')),__NT(__PP51365._fp3__stolenidentityindex_)),__OP2(__PP51365._fp3__stolenidentityindex_,=,__CN(0))))=>__ECAST(KEL.typ.nint,__CN(-99997)),__ECAST(KEL.typ.nint,__PP51365._fp3__stolenidentityindex_));
    SELF.T1___Fp3___Synthetic_Identity_Index_ := MAP(__PP51365.T1___Lex_Id_Pop_Flag_ = 0 AND __PP51365.T1___Rin_Id_Pop_Flag_ = 0=>__ECAST(KEL.typ.nint,__CN(-99999)),__PP51365.T___Is_Bc_Shll_Hit_Flag_ < 1 OR __PP51365.T___Src_Class_Type_ < 4=>__ECAST(KEL.typ.nint,__CN(-99998)),__T(__OR(__OR(__OP2(__CAST(KEL.typ.str,__PP51365._syntheticidentityindex__v3_),=,__CN('')),__NT(__PP51365._syntheticidentityindex__v3_)),__OP2(__PP51365._syntheticidentityindex__v3_,=,__CN(0))))=>__ECAST(KEL.typ.nint,__CN(-99997)),__ECAST(KEL.typ.nint,__PP51365._syntheticidentityindex__v3_));
    SELF.T1___Id_Age_ := MAP(__PP51365.T1___Lex_Id_Pop_Flag_ = 0 AND __PP51365.T1___Rin_Id_Pop_Flag_ = 0 OR __PP51365.T___Dob_Pop_Flag_ = 0=>__ECAST(KEL.typ.nint,__CN(-99999)),__PP51365.T___Src_Class_Type_ < 4=>__ECAST(KEL.typ.nint,__CN(-99998)),__T(__OP2(__ECAST(KEL.typ.nint,__PP51365.T___Inp_Cln_Dob_Echo_),>,__ECAST(KEL.typ.nint,__PP51365.T___Act_Dt_Echo_)))=>__ECAST(KEL.typ.nint,__CN(-99997)),__ECAST(KEL.typ.nint,KEL.Routines.MinN(__FN1(KEL.Routines.Floor,__OP2(__FN2(KEL.Routines.DaysBetween,KEL.Routines.DateFromInteger(__PP51365.T___Inp_Cln_Dob_Echo_),__PP51365.T___Act_Dt_Echo_),/,__CN(365.25))),__CN(200))));
    SELF.T1___Nap_Summary_ := MAP(__PP51365.T1___Lex_Id_Pop_Flag_ = 0 AND __PP51365.T1___Rin_Id_Pop_Flag_ = 0=>__ECAST(KEL.typ.nint,__CN(-99999)),__PP51365.T___Is_Bc_Shll_Hit_Flag_ < 1 OR __PP51365.T___Src_Class_Type_ < 4=>__ECAST(KEL.typ.nint,__CN(-99998)),__ECAST(KEL.typ.nint,__PP51365._nap__summary_));
    SELF.T20___Dl_Val_Type_ := MAP(__PP51365.T20___Dl_Pop_Flag_ = 0=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99999))),__PP51365.T___Src_Class_Type_ < 4 OR __PP51365.T___Is_Bc_Shll_Hit_Flag_ < 1=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99998))),__T(__OP2(__ECAST(KEL.typ.nstr,__PP51365._drlcvalflag_),=,__CN('')))=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99997))),__ECAST(KEL.typ.nstr,__ECAST(KEL.typ.nstr,__PP51365._drlcvalflag_)));
    SELF.T9___Addr_Mail_Drop_Type_ := MAP(__PP51365.T9___Addr_Pop_Flag_ = 0=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99999))),__PP51365.T___Src_Class_Type_ < 4 OR __PP51365.T___Is_Bc_Shll_Hit_Flag_ < 1=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99998))),__T(__OR(__NT(__PP51365._drop__indicator_),__OP2(__PP51365._drop__indicator_,=,__CN(''))))=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99997))),__ECAST(KEL.typ.nstr,__PP51365._drop__indicator_));
    SELF.T9___Addr_Val_Type_ := MAP(__PP51365.T9___Addr_Pop_Flag_ = 0=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99999))),__PP51365.T___Src_Class_Type_ < 4 OR __PP51365.T___Is_Bc_Shll_Hit_Flag_ < 1=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99998))),__T(__OP2(__PP51365._addrvalflag_,=,__CN('')))=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99997))),__ECAST(KEL.typ.nstr,__PP51365._addrvalflag_));
    SELF.T___Inp_Cln_Middle_Nm_Echo_ := MAP(__T(__OR(__OP2(__PP51365.Middle_Name_,=,__CN('')),__NT(__PP51365.Middle_Name_)))=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99999))),__ECAST(KEL.typ.nstr,__PP51365.Middle_Name_));
    SELF := __PP51365;
  END;
  EXPORT __ENH_Event_1 := PROJECT(__EE51693,__ND52004__Project(LEFT));
END;
