﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_4,B_Person_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Event_4.__ENH_Event_4) __ENH_Event_4 := B_Event_4.__ENH_Event_4;
  SHARED VIRTUAL TYPEOF(B_Person_4.__ENH_Person_4) __ENH_Person_4 := B_Person_4.__ENH_Person_4;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE323182 := __ENH_Person_4;
  SHARED __EE325237 := __ENH_Event_4;
  SHARED __EE325235 := __E_Person_Event;
  SHARED __EE342904 := __EE325235(__NN(__EE325235.Subject_) AND __NN(__EE325235.Transaction_));
  SHARED __ST337806_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Source_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nint Record_Id_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ndataset(E_Event.Event_Types_Layout) Event_Types_;
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
    KEL.typ.nstr Otto_Bank_Account_Id_;
    KEL.typ.nstr _unique__number_;
    KEL.typ.nstr _mac__address_;
    KEL.typ.nstr _serial__number_;
    KEL.typ.nstr _device__type_;
    KEL.typ.nstr _device__identification__provider_;
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
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.int Deceased_Prior_To_Event_ := 0;
    KEL.typ.nint Deceased_To_Event_Year_Diff_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Kr_High_Risk_Address_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Bank_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Dl_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Email_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Identity_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Ip_Address_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Phone_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Ssn_Flag_ := 0;
    KEL.typ.int Kr_Identity_Flag_ := 0;
    KEL.typ.int Kr_Identity_Risk_ := 0;
    KEL.typ.int Kr_Low_Risk_Address_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Bank_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Dl_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Email_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Identity_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Ip_Address_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Phone_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Ssn_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Address_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Bank_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Dl_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Email_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Identity_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Ip_Address_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Phone_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Ssn_Flag_ := 0;
    KEL.typ.int No_Lex_Id_ := 0;
    KEL.typ.int T15___Ssn_Is_Kr_Flag_ := 0;
    KEL.typ.int T15___Ssn_Pop_Flag_ := 0;
    KEL.typ.int T16___Phn_Is_Kr_Flag_ := 0;
    KEL.typ.int T16___Phn_Is_Safe_Flag_ := 0;
    KEL.typ.int T16___Phn_Pop_Flag_ := 0;
    KEL.typ.int T17___Email_Is_Kr_Flag_ := 0;
    KEL.typ.int T17___Email_Pop_Flag_ := 0;
    KEL.typ.int T18___Ip_Addr_Is_Kr_Flag_ := 0;
    KEL.typ.int T18___Ip_Addr_Is_Safe_Flag_ := 0;
    KEL.typ.int T18___Ip_Addr_Pop_Flag_ := 0;
    KEL.typ.int T19___Bnk_Acct_Is_Kr_Flag_ := 0;
    KEL.typ.int T19___Bnk_Acct_Pop_Flag_ := 0;
    KEL.typ.int T1___Id_Is_Kr_App_Frd_Flag_ := 0;
    KEL.typ.int T1___Id_Is_Kr_Flag_ := 0;
    KEL.typ.int T1___Id_Is_Kr_Gen_Frd_Flag_ := 0;
    KEL.typ.int T1___Id_Is_Kr_Oth_Frd_Flag_ := 0;
    KEL.typ.int T1___Id_Is_Kr_Stol_Id_Flag_ := 0;
    KEL.typ.int T1___Lex_Id_Pop_Flag_ := 0;
    KEL.typ.int T1___Rin_Id_Pop_Flag_ := 0;
    KEL.typ.int T20___Dl_Is_Kr_Flag_ := 0;
    KEL.typ.int T20___Dl_Pop_Flag_ := 0;
    KEL.typ.int T9___Addr_Is_Kr_Flag_ := 0;
    KEL.typ.int T9___Addr_Is_Safe_Flag_ := 0;
    KEL.typ.int T9___Addr_Pop_Flag_ := 0;
    KEL.typ.nint T___Addr_Status_Code_Echo_;
    KEL.typ.nint T___Bnk_Acct_Status_Code_Echo_;
    KEL.typ.nint T___Dl_Status_Code_Echo_;
    KEL.typ.nint T___Email_Status_Code_Echo_;
    KEL.typ.nint T___Evt_Type1_Status_Code_Echo_;
    KEL.typ.nint T___Evt_Type2_Status_Code_Echo_;
    KEL.typ.nint T___Evt_Type3_Status_Code_Echo_;
    KEL.typ.int T___In_Agency_Flag_ := 0;
    KEL.typ.nstr T___Inp_Cln_Addr_City_Echo_;
    KEL.typ.nstr T___Inp_Cln_Addr_Prim_Nm_Echo_;
    KEL.typ.nstr T___Inp_Cln_Addr_St_Echo_;
    KEL.typ.nstr T___Inp_Cln_Addr_Zip5_Echo_;
    KEL.typ.nstr T___Inp_Cln_Bnk_Acct_Echo_;
    KEL.typ.nstr T___Inp_Cln_Bnk_Acct_Rtg_Echo_;
    KEL.typ.nstr T___Inp_Cln_Dl_Echo_;
    KEL.typ.nstr T___Inp_Cln_Dl_St_Echo_;
    KEL.typ.nstr T___Inp_Cln_Email_Echo_;
    KEL.typ.nstr T___Inp_Cln_Ip_Addr_Echo_;
    KEL.typ.nstr T___Inp_Cln_Phn_Echo_;
    KEL.typ.nstr T___Inp_Cln_Ssn_Echo_;
    KEL.typ.nint T___Ip_Addr_Status_Code_Echo_;
    KEL.typ.nint T___Person_Uid_Echo_;
    KEL.typ.nint T___Phn_Status_Code_Echo_;
    KEL.typ.int T___Src_Class_Type_ := 0;
    KEL.typ.nint T___Src_Type_;
    KEL.typ.nint T___Ssn_Status_Code_Echo_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ntyp(E_Person.Typ) Subject__1_;
    KEL.typ.nkdate Event_Date__1_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC342922(B_Event_4.__ST65511_Layout __EE325237, E_Person_Event.Layout __EE342904) := __EEQP(__EE342904.Transaction_,__EE325237.UID);
  __ST337806_Layout __JT342922(B_Event_4.__ST65511_Layout __l, E_Person_Event.Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF.Subject__1_ := __r.Subject_;
    SELF.Event_Date__1_ := __r.Event_Date_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE342923 := JOIN(__EE342904,__EE325237,__JC342922(RIGHT,LEFT),__JT342922(RIGHT,LEFT),INNER,HASH);
  SHARED __ST335880_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.int T___In_Agency_Flag_ := 0;
    KEL.typ.int T1___Id_Is_Kr_Flag_ := 0;
    KEL.typ.int T1___Id_Is_Kr_Gen_Frd_Flag_ := 0;
    KEL.typ.int T1___Id_Is_Kr_Oth_Frd_Flag_ := 0;
    KEL.typ.int T1___Id_Is_Kr_Stol_Id_Flag_ := 0;
    KEL.typ.nstr A_C_E_Cleaner_Error_Code_;
    KEL.typ.nstr Abbreviated_Bankname_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nstr Bank_Hit_;
    KEL.typ.nstr Carrier_Route_Number_;
    KEL.typ.nstr Carrier_Route_Sortation_At_Z_I_P_;
    KEL.typ.nstr Case_Id_;
    KEL.typ.nint Confidence__that__activity__was__deceitful__id_;
    KEL.typ.nint County_;
    KEL.typ.nkdate Created_On_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.nkdate Deceased_Date_;
    KEL.typ.nkdate Deceased_Date_Of_Birth_;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.nstr Deceased_First_;
    KEL.typ.nstr Deceased_Last_;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.nstr Deceased_Match_Code_;
    KEL.typ.nstr Deceased_Middle_;
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.int Deceased_Prior_To_Event_ := 0;
    KEL.typ.nstr Deceased_Ssn_;
    KEL.typ.nint Deceased_To_Event_Year_Diff_;
    KEL.typ.nint Delivery_Point_Barcode_;
    KEL.typ.nint Delivery_Point_Barcode_Check_Digit_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr Email_Last_Domain_;
    KEL.typ.nkdate Event_Date__1_;
    KEL.typ.ndataset(E_Event.Event_Types_Layout) Event_Types_;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Fractional_Routingnumber_;
    KEL.typ.nstr Full_Bankname_;
    KEL.typ.nint Geo_Block_;
    KEL.typ.nstr Geo_Match_;
    KEL.typ.nstr Headoffice_Branchcodes_;
    KEL.typ.nstr Headoffice_Routingnumber_;
    KEL.typ.nstr Host_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nstr Ip_Address_;
    KEL.typ.int Kr_High_Risk_Address_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Bank_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Dl_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Email_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Identity_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Ip_Address_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Phone_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Ssn_Flag_ := 0;
    KEL.typ.int Kr_Identity_Flag_ := 0;
    KEL.typ.int Kr_Identity_Risk_ := 0;
    KEL.typ.int Kr_Low_Risk_Address_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Bank_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Dl_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Email_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Identity_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Ip_Address_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Phone_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Ssn_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Address_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Bank_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Dl_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Email_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Identity_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Ip_Address_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Phone_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Ssn_Flag_ := 0;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nfloat Latitude_;
    KEL.typ.nint Lex_Id_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr License_State_;
    KEL.typ.nint Line_Of_Travel_;
    KEL.typ.nstr Line_Of_Travel_Order_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nfloat Longitude_;
    KEL.typ.nint Metropolitan_Statistical_Area_;
    KEL.typ.nstr Middle_Name_;
    KEL.typ.nstr Name_Suffix_;
    KEL.typ.int No_Lex_Id_ := 0;
    KEL.typ.nstr Otto_Address_Id_;
    KEL.typ.nstr Otto_Bank_Account_Id_;
    KEL.typ.nstr Otto_Drivers_License_Id_;
    KEL.typ.nstr Otto_Email_Id_;
    KEL.typ.nstr Otto_Ip_Address_Id_;
    KEL.typ.nstr Otto_S_S_N_Id_;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nstr Postal_City_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nint Record_Id_;
    KEL.typ.nstr Routing_Number_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Ssn_;
    KEL.typ.nstr Ssn_Formatted_;
    KEL.typ.nstr State_;
    KEL.typ.ntyp(E_Person.Typ) Subject__1_;
    KEL.typ.nstr Suffix_;
    KEL.typ.int T15___Ssn_Is_Kr_Flag_ := 0;
    KEL.typ.int T15___Ssn_Pop_Flag_ := 0;
    KEL.typ.int T16___Phn_Is_Kr_Flag_ := 0;
    KEL.typ.int T16___Phn_Is_Safe_Flag_ := 0;
    KEL.typ.int T16___Phn_Pop_Flag_ := 0;
    KEL.typ.int T17___Email_Is_Kr_Flag_ := 0;
    KEL.typ.int T17___Email_Pop_Flag_ := 0;
    KEL.typ.int T18___Ip_Addr_Is_Kr_Flag_ := 0;
    KEL.typ.int T18___Ip_Addr_Is_Safe_Flag_ := 0;
    KEL.typ.int T18___Ip_Addr_Pop_Flag_ := 0;
    KEL.typ.int T19___Bnk_Acct_Is_Kr_Flag_ := 0;
    KEL.typ.int T19___Bnk_Acct_Pop_Flag_ := 0;
    KEL.typ.int T1___Id_Is_Kr_App_Frd_Flag_ := 0;
    KEL.typ.int T1___Lex_Id_Pop_Flag_ := 0;
    KEL.typ.int T1___Rin_Id_Pop_Flag_ := 0;
    KEL.typ.int T20___Dl_Is_Kr_Flag_ := 0;
    KEL.typ.int T20___Dl_Pop_Flag_ := 0;
    KEL.typ.int T9___Addr_Is_Kr_Flag_ := 0;
    KEL.typ.int T9___Addr_Is_Safe_Flag_ := 0;
    KEL.typ.int T9___Addr_Pop_Flag_ := 0;
    KEL.typ.nint T___Addr_Status_Code_Echo_;
    KEL.typ.nint T___Bnk_Acct_Status_Code_Echo_;
    KEL.typ.nint T___Dl_Status_Code_Echo_;
    KEL.typ.nint T___Email_Status_Code_Echo_;
    KEL.typ.nint T___Evt_Type1_Status_Code_Echo_;
    KEL.typ.nint T___Evt_Type2_Status_Code_Echo_;
    KEL.typ.nint T___Evt_Type3_Status_Code_Echo_;
    KEL.typ.nstr T___Inp_Cln_Addr_City_Echo_;
    KEL.typ.nstr T___Inp_Cln_Addr_Prim_Nm_Echo_;
    KEL.typ.nstr T___Inp_Cln_Addr_St_Echo_;
    KEL.typ.nstr T___Inp_Cln_Addr_Zip5_Echo_;
    KEL.typ.nstr T___Inp_Cln_Bnk_Acct_Echo_;
    KEL.typ.nstr T___Inp_Cln_Bnk_Acct_Rtg_Echo_;
    KEL.typ.nstr T___Inp_Cln_Dl_Echo_;
    KEL.typ.nstr T___Inp_Cln_Dl_St_Echo_;
    KEL.typ.nstr T___Inp_Cln_Email_Echo_;
    KEL.typ.nstr T___Inp_Cln_Ip_Addr_Echo_;
    KEL.typ.nstr T___Inp_Cln_Phn_Echo_;
    KEL.typ.nstr T___Inp_Cln_Ssn_Echo_;
    KEL.typ.nint T___Ip_Addr_Status_Code_Echo_;
    KEL.typ.nint T___Person_Uid_Echo_;
    KEL.typ.nint T___Phn_Status_Code_Echo_;
    KEL.typ.int T___Src_Class_Type_ := 0;
    KEL.typ.nint T___Src_Type_;
    KEL.typ.nint T___Ssn_Status_Code_Echo_;
    KEL.typ.nstr Title_;
    KEL.typ.nstr Type_;
    KEL.typ.nstr Type_Code_;
    KEL.typ.nstr Unit_Designation_;
    KEL.typ.nstr Vanity_City_;
    KEL.typ.nstr Zip_;
    KEL.typ.nstr Zip4_;
    KEL.typ.nstr _add__curr__addr__suffix_;
    KEL.typ.nstr _add__curr__city__name_;
    KEL.typ.nstr _add__curr__county_;
    KEL.typ.nstr _add__curr__geo__blk_;
    KEL.typ.nstr _add__curr__lat_;
    KEL.typ.nstr _add__curr__long_;
    KEL.typ.nbool _add__curr__pop_;
    KEL.typ.nstr _add__curr__postdir_;
    KEL.typ.nstr _add__curr__predir_;
    KEL.typ.nstr _add__curr__prim__name_;
    KEL.typ.nstr _add__curr__prim__range_;
    KEL.typ.nstr _add__curr__sec__range_;
    KEL.typ.nstr _add__curr__st_;
    KEL.typ.nstr _add__curr__unit__desig_;
    KEL.typ.nstr _add__curr__zip5_;
    KEL.typ.nbool _add__input__isbestmatch_;
    KEL.typ.nbool _addresscmra_;
    KEL.typ.nbool _addresspobox_;
    KEL.typ.nstr _advo__addressstyle_;
    KEL.typ.nstr _advo__addresstype_;
    KEL.typ.nstr _advo__addressusagetype_;
    KEL.typ.nstr _advo__dropindicator_;
    KEL.typ.nstr _advo__hitflag_;
    KEL.typ.nstr _advo__residentialorbusinessindicator_;
    KEL.typ.nstr _advo__vacancyindicator_;
    KEL.typ.nstr _asn_;
    KEL.typ.nstr _asnname_;
    KEL.typ.nint _bank__account__1__risk__code_;
    KEL.typ.nint _bank__account__2__risk__code_;
    KEL.typ.nstr _best__fname_;
    KEL.typ.nstr _best__lname_;
    KEL.typ.nstr _best__ssn_;
    KEL.typ.nint _business__risk__code_;
    KEL.typ.nstr _cbsacode_;
    KEL.typ.nstr _cbsatitle_;
    KEL.typ.nstr _cbsatype_;
    KEL.typ.nint _cell__phone__risk__code_;
    KEL.typ.nstr _companyname_;
    KEL.typ.nstr _county__death_;
    KEL.typ.nstr _csacode_;
    KEL.typ.nstr _csatitle_;
    KEL.typ.nstr _curr__incar__flag_;
    KEL.typ.nint _cvi_;
    KEL.typ.nstr _death__rec__src_;
    KEL.typ.nstr _device__identification__provider_;
    KEL.typ.nint _device__risk__code_;
    KEL.typ.nstr _device__type_;
    KEL.typ.nint _dob__risk__code_;
    KEL.typ.nint _dobmatchlevel_;
    KEL.typ.nstr _domainname_;
    KEL.typ.nint _drivers__license__risk__code_;
    KEL.typ.nint _drlcvalflag_;
    KEL.typ.nstr _edgeareacodes_;
    KEL.typ.nstr _edgecity_;
    KEL.typ.nstr _edgecitycode_;
    KEL.typ.nstr _edgecitycong_;
    KEL.typ.nstr _edgeconnspeed_;
    KEL.typ.nstr _edgecontinentcode_;
    KEL.typ.nstr _edgecountry_;
    KEL.typ.nstr _edgecountrycode_;
    KEL.typ.nstr _edgecountryconf_;
    KEL.typ.nstr _edgegmtoffset_;
    KEL.typ.nstr _edgeindst_;
    KEL.typ.nstr _edgeinternalcode_;
    KEL.typ.nstr _edgelatitude_;
    KEL.typ.nstr _edgelongitude_;
    KEL.typ.nstr _edgemetrocode_;
    KEL.typ.nstr _edgepostalcode_;
    KEL.typ.nstr _edgepostalconf_;
    KEL.typ.nstr _edgeregion_;
    KEL.typ.nstr _edgeregioncode_;
    KEL.typ.nstr _edgeregionconf_;
    KEL.typ.nstr _edgetwolettercountry_;
    KEL.typ.nint _email__address__risk__code_;
    KEL.typ.nint _event__type__1_;
    KEL.typ.nint _event__type__2_;
    KEL.typ.nint _event__type__3_;
    KEL.typ.nint _fp3__stolenidentityindex_;
    KEL.typ.nstr _homebiztype_;
    KEL.typ.nstr _households_;
    KEL.typ.nint _hphonevalflag_;
    KEL.typ.nint _identity__risk__code_;
    KEL.typ.nstr _input__fname__isbestmatch_;
    KEL.typ.nstr _input__lname__isbestmatch_;
    KEL.typ.nstr _input__ssn__isbestmatch_;
    KEL.typ.nint _ip__address__fraud__code_;
    KEL.typ.nstr _iprngbeg_;
    KEL.typ.nstr _iprngend_;
    KEL.typ.nbool _is_Additional_;
    KEL.typ.nstr _isanisp_;
    KEL.typ.nbool _isdeepdive_;
    KEL.typ.nint _isdisposableemail_;
    KEL.typ.nstr _ispname_;
    KEL.typ.nstr _kids_;
    KEL.typ.nstr _mac__address_;
    KEL.typ.nint _mailing__address__risk__code_;
    KEL.typ.nint _manipulatedidentityindex__v3_;
    KEL.typ.nstr _mdcode_;
    KEL.typ.nstr _mdtitle_;
    KEL.typ.nstr _men_;
    KEL.typ.nstr _men18to34_;
    KEL.typ.nstr _men35to49_;
    KEL.typ.nstr _naicscode_;
    KEL.typ.nint _name__risk__code_;
    KEL.typ.nint _name__ssn__dob__match_;
    KEL.typ.nint _nap__summary_;
    KEL.typ.nint _nas__summary_;
    KEL.typ.nstr _off__cat__list_;
    KEL.typ.nstr _organizationname_;
    KEL.typ.nint _phone__risk__code_;
    KEL.typ.nint _physical__address__risk__code_;
    KEL.typ.nstr _primarylang_;
    KEL.typ.nstr _proxydescription_;
    KEL.typ.nstr _proxytype_;
    KEL.typ.nint _pwsocsdobflag_;
    KEL.typ.ntyp(E_Bank_Account.Typ) _r_Bank_Account_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ntyp(E_Drivers_License.Typ) _r_Drivers_License_;
    KEL.typ.ntyp(E_Email.Typ) _r_Email_;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) _r_Internet_Protocol_;
    KEL.typ.ntyp(E_Phone.Typ) _r_Phone_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Source_Customer_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) _r_Ssn_;
    KEL.typ.nstr _ranks_;
    KEL.typ.nstr _reason1_;
    KEL.typ.nstr _reason2_;
    KEL.typ.nstr _reason3_;
    KEL.typ.nstr _reason4_;
    KEL.typ.nstr _reason5_;
    KEL.typ.nstr _reason6_;
    KEL.typ.nint _rin__source_;
    KEL.typ.nstr _secondarylang_;
    KEL.typ.nstr _serial__number_;
    KEL.typ.nstr _siccode_;
    KEL.typ.nint _socsdobflag_;
    KEL.typ.nint _socsvalflag_;
    KEL.typ.nint _sourcerisklevel_;
    KEL.typ.nint _ssn__risk__code_;
    KEL.typ.nstr _state__death__flag_;
    KEL.typ.nstr _state__death__id_;
    KEL.typ.nint _syntheticidentityindex__v3_;
    KEL.typ.nstr _teens_;
    KEL.typ.nbool _truedid_;
    KEL.typ.nstr _unique__number_;
    KEL.typ.nstr _women_;
    KEL.typ.nstr _women18to34_;
    KEL.typ.nstr _women35to49_;
    KEL.typ.nint _work__phone__risk__code_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST335880_Layout __ND343247__Project(__ST337806_Layout __PP342924) := TRANSFORM
    SELF.UID := __PP342924.Subject__1_;
    SELF._r_Customer_ := __PP342924._r_Customer__1_;
    SELF.Subject_ := __PP342924.Subject__1_;
    SELF.Event_Date_ := __PP342924.Event_Date__1_;
    SELF.U_I_D__1_ := __PP342924.UID;
    SELF.Event_Date__1_ := __PP342924.Event_Date_;
    SELF.Subject__1_ := __PP342924.Subject_;
    SELF._r_Customer__1_ := __PP342924._r_Customer_;
    SELF := __PP342924;
  END;
  SHARED __EE344496 := PROJECT(__EE342923,__ND343247__Project(LEFT));
  SHARED __ST336582_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) UID;
    KEL.typ.bool Exp1_ := FALSE;
    KEL.typ.bool Exp2_ := FALSE;
    KEL.typ.bool Exp3_ := FALSE;
    KEL.typ.bool Exp4_ := FALSE;
    KEL.typ.bool Exp5_ := FALSE;
    KEL.typ.bool Exp6_ := FALSE;
    KEL.typ.bool Exp7_ := FALSE;
    KEL.typ.bool Exp8_ := FALSE;
    KEL.typ.nkdate Event_Date__1_;
    KEL.typ.nkdate Exp9_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST336582_Layout __ND344501__Project(__ST335880_Layout __PP344497) := TRANSFORM
    SELF.Exp1_ := __PP344497.T___In_Agency_Flag_ = 1 AND __PP344497.T1___Id_Is_Kr_Flag_ = 1;
    SELF.Exp2_ := __PP344497.T___In_Agency_Flag_ = 0 AND __PP344497.T1___Id_Is_Kr_Flag_ = 1;
    SELF.Exp3_ := __PP344497.T___In_Agency_Flag_ = 1 AND __PP344497.T1___Id_Is_Kr_Gen_Frd_Flag_ = 1;
    SELF.Exp4_ := __PP344497.T___In_Agency_Flag_ = 0 AND __PP344497.T1___Id_Is_Kr_Gen_Frd_Flag_ = 1;
    SELF.Exp5_ := __PP344497.T___In_Agency_Flag_ = 1 AND __PP344497.T1___Id_Is_Kr_Oth_Frd_Flag_ = 1;
    SELF.Exp6_ := __PP344497.T___In_Agency_Flag_ = 0 AND __PP344497.T1___Id_Is_Kr_Oth_Frd_Flag_ = 1;
    SELF.Exp7_ := __PP344497.T___In_Agency_Flag_ = 1 AND __PP344497.T1___Id_Is_Kr_Stol_Id_Flag_ = 1;
    SELF.Exp8_ := __PP344497.T___In_Agency_Flag_ = 0 AND __PP344497.T1___Id_Is_Kr_Stol_Id_Flag_ = 1;
    SELF.Exp9_ := IF(__PP344497.Kr_Identity_Flag_ = 1,__ECAST(KEL.typ.nkdate,__PP344497.Event_Date__1_),__ECAST(KEL.typ.nkdate,__N(KEL.typ.kdate)));
    SELF := __PP344497;
  END;
  SHARED __EE344590 := PROJECT(__EE344496,__ND344501__Project(LEFT));
  SHARED __ST336642_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__6_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__7_ := 0;
    KEL.typ.nkdate M_A_X___Event_Date__1_;
    KEL.typ.nkdate M_A_X___Event_Date__2_;
    KEL.typ.ntyp(E_Person.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE344651 := PROJECT(__CLEANANDDO(__EE344590,TABLE(__EE344590,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP,__EE344590.Exp1_),KEL.typ.int C_O_U_N_T___Exp1__1_ := COUNT(GROUP,__EE344590.Exp2_),KEL.typ.int C_O_U_N_T___Exp1__2_ := COUNT(GROUP,__EE344590.Exp3_),KEL.typ.int C_O_U_N_T___Exp1__3_ := COUNT(GROUP,__EE344590.Exp4_),KEL.typ.int C_O_U_N_T___Exp1__4_ := COUNT(GROUP,__EE344590.Exp5_),KEL.typ.int C_O_U_N_T___Exp1__5_ := COUNT(GROUP,__EE344590.Exp6_),KEL.typ.int C_O_U_N_T___Exp1__6_ := COUNT(GROUP,__EE344590.Exp7_),KEL.typ.int C_O_U_N_T___Exp1__7_ := COUNT(GROUP,__EE344590.Exp8_),KEL.Aggregates.MaxNG(__EE344590.Event_Date__1_) M_A_X___Event_Date__1_,KEL.Aggregates.MaxNG(__EE344590.Exp9_) M_A_X___Event_Date__2_,UID},UID,MERGE)),__ST336642_Layout);
  SHARED __ST339391_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.nint Lex_Id_;
    KEL.typ.ndataset(E_Person.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ndataset(E_Person.Reported_Date_Of_Birth_Layout) Reported_Date_Of_Birth_;
    KEL.typ.ndataset(E_Person.Reported_Ssn_Layout) Reported_Ssn_;
    KEL.typ.ndataset(E_Person.Reported_Email_Address_Layout) Reported_Email_Address_;
    KEL.typ.ndataset(E_Person.Full_Name_Layout) Full_Name_;
    KEL.typ.nint _rin__source_;
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
    KEL.typ.nint _name__ssn__dob__match_;
    KEL.typ.ndataset(E_Person.Offenses_Layout) Offenses_;
    KEL.typ.ndataset(E_Person.Address_Layout) Address_;
    KEL.typ.int Death_Prior_To_All_Events_ := 0;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.nfloat Deceased_Event_Percent_;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.nint Max_Deceased_To_Event_Diff_;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__6_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__7_ := 0;
    KEL.typ.nkdate M_A_X___Event_Date__1_;
    KEL.typ.nkdate M_A_X___Event_Date__2_;
    KEL.typ.ntyp(E_Person.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC344657(B_Person_4.__ST66086_Layout __EE323182, __ST336642_Layout __EE344651) := __EEQP(__EE323182.UID,__EE344651.UID);
  __ST339391_Layout __JT344657(B_Person_4.__ST66086_Layout __l, __ST336642_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE344658 := JOIN(__EE323182,__EE344651,__JC344657(LEFT,RIGHT),__JT344657(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST63149_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.nint Lex_Id_;
    KEL.typ.ndataset(E_Person.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ndataset(E_Person.Reported_Date_Of_Birth_Layout) Reported_Date_Of_Birth_;
    KEL.typ.ndataset(E_Person.Reported_Ssn_Layout) Reported_Ssn_;
    KEL.typ.ndataset(E_Person.Reported_Email_Address_Layout) Reported_Email_Address_;
    KEL.typ.ndataset(E_Person.Full_Name_Layout) Full_Name_;
    KEL.typ.nint _rin__source_;
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
    KEL.typ.nint _name__ssn__dob__match_;
    KEL.typ.ndataset(E_Person.Offenses_Layout) Offenses_;
    KEL.typ.ndataset(E_Person.Address_Layout) Address_;
    KEL.typ.int Aot_Id_Kr_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_Kr_Act_Shrd_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_Kr_Gen_Frd_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_Kr_Gen_Frd_Act_Shrd_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_Kr_Oth_Frd_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_Kr_Oth_Frd_Act_Shrd_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_Kr_Stol_Id_Act_Cnt_Ev_ := 0;
    KEL.typ.int Aot_Id_Kr_Stol_Id_Act_Shrd_Cnt_Ev_ := 0;
    KEL.typ.int Death_Prior_To_All_Events_ := 0;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.nfloat Deceased_Event_Percent_;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.nint Max_Deceased_To_Event_Diff_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST63149_Layout __ND345016__Project(__ST339391_Layout __PP344659) := TRANSFORM
    SELF.Aot_Id_Kr_Act_Cnt_Ev_ := MIN(__PP344659.C_O_U_N_T___Exp1_,9999);
    SELF.Aot_Id_Kr_Act_Shrd_Cnt_Ev_ := MIN(__PP344659.C_O_U_N_T___Exp1__1_,9999);
    SELF.Aot_Id_Kr_Gen_Frd_Act_Cnt_Ev_ := MIN(__PP344659.C_O_U_N_T___Exp1__2_,9999);
    SELF.Aot_Id_Kr_Gen_Frd_Act_Shrd_Cnt_Ev_ := MIN(__PP344659.C_O_U_N_T___Exp1__3_,9999);
    SELF.Aot_Id_Kr_Oth_Frd_Act_Cnt_Ev_ := MIN(__PP344659.C_O_U_N_T___Exp1__4_,9999);
    SELF.Aot_Id_Kr_Oth_Frd_Act_Shrd_Cnt_Ev_ := MIN(__PP344659.C_O_U_N_T___Exp1__5_,9999);
    SELF.Aot_Id_Kr_Stol_Id_Act_Cnt_Ev_ := MIN(__PP344659.C_O_U_N_T___Exp1__6_,9999);
    SELF.Aot_Id_Kr_Stol_Id_Act_Shrd_Cnt_Ev_ := MIN(__PP344659.C_O_U_N_T___Exp1__7_,9999);
    SELF.Dt_Last_Seen_ := __PP344659.M_A_X___Event_Date__1_;
    SELF.High_Risk_Death_Prior_To_All_Events_ := MAP(__T(__AND(__CN(__PP344659.Death_Prior_To_All_Events_ = 1),__OP2(__PP344659.Max_Deceased_To_Event_Diff_,<,__CN(-4))))=>1,0);
    __BS344916 := __T(__PP344659.Source_Customers_);
    SELF.In_Customer_Population_ := MAP(EXISTS(__BS344916(__T(__OP2(__T(__PP344659.Source_Customers_)._r_Source_Customer_,=,__PP344659._r_Customer_))))=>1,0);
    SELF.Kr_Last_Event_Date_ := __PP344659.M_A_X___Event_Date__2_;
    SELF := __PP344659;
  END;
  EXPORT __ENH_Person_3 := PROJECT(__EE344658,__ND345016__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Person::Annotated_3',EXPIRE(7));
END;
