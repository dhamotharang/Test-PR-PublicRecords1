﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_2,B_Internet_Protocol_2,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Internet_Protocol_Event,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Internet_Protocol_1 := MODULE
  SHARED VIRTUAL TYPEOF(B_Event_2.__ENH_Event_2) __ENH_Event_2 := B_Event_2.__ENH_Event_2;
  SHARED VIRTUAL TYPEOF(B_Internet_Protocol_2.__ENH_Internet_Protocol_2) __ENH_Internet_Protocol_2 := B_Internet_Protocol_2.__ENH_Internet_Protocol_2;
  SHARED VIRTUAL TYPEOF(E_Internet_Protocol_Event.__Result) __E_Internet_Protocol_Event := E_Internet_Protocol_Event.__Result;
  SHARED __EE420910 := __ENH_Internet_Protocol_2;
  SHARED __EE436597 := __ENH_Event_2;
  SHARED __EE436586 := __E_Internet_Protocol_Event;
  SHARED __EE439970 := __EE436586;
  SHARED __EE439983 := __EE439970(__NN(__EE439970.Ip_) AND __NN(__EE439970.Transaction_));
  SHARED __ST431893_Layout := RECORD
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
    KEL.typ.int Address_Is_Cmra_ := 0;
    KEL.typ.int Address_Out_Of_State_ := 0;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.int Deceased_Prior_To_Event_ := 0;
    KEL.typ.nint Deceased_To_Event_Year_Diff_;
    KEL.typ.nbool Demo_Customer_;
    KEL.typ.nint Event_Age_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Kr_Address_Flag_ := 0;
    KEL.typ.int Kr_Bank_Flag_ := 0;
    KEL.typ.int Kr_Dl_Flag_ := 0;
    KEL.typ.int Kr_Email_Flag_ := 0;
    KEL.typ.int Kr_Event_After_Known_Risk_ := 0;
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
    KEL.typ.int Kr_Ip_Flag_ := 0;
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
    KEL.typ.int Kr_Phone_Flag_ := 0;
    KEL.typ.int Kr_Ssn_Flag_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.int T18___Is_Ip_Meta_Hit_Flag_ := 0;
    KEL.typ.nint T19___Bnk_Acct_Pop_Flag_;
    KEL.typ.nstr T___Inp_Cln_Bnk_Acct_Echo_;
    KEL.typ.nstr T___Inp_Cln_Bnk_Acct_Rtg_Echo_;
    KEL.typ.nstr T___Inp_Cln_Email_Echo_;
    KEL.typ.nstr T___Inp_Cln_Ip_Addr_Echo_;
    KEL.typ.int T___Src_Class_Type_ := 0;
    KEL.typ.nint T___Src_Type_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) Ip_;
    KEL.typ.nkdate Event_Date__1_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC439989(B_Event_2.__ST36136_Layout __EE436597, E_Internet_Protocol_Event.Layout __EE439983) := __EEQP(__EE439983.Transaction_,__EE436597.UID);
  __ST431893_Layout __JT439989(B_Event_2.__ST36136_Layout __l, E_Internet_Protocol_Event.Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF.Event_Date__1_ := __r.Event_Date_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE439990 := JOIN(__EE439983,__EE436597,__JC439989(RIGHT,LEFT),__JT439989(RIGHT,LEFT),INNER,HASH);
  SHARED __ST430291_Layout := RECORD
    KEL.typ.ntyp(E_Internet_Protocol.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) Ip_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.int Kr_Ip_Flag_ := 0;
    KEL.typ.nstr A_C_E_Cleaner_Error_Code_;
    KEL.typ.nstr Abbreviated_Bankname_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.int Address_Is_Cmra_ := 0;
    KEL.typ.int Address_Out_Of_State_ := 0;
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
    KEL.typ.nbool Demo_Customer_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr Email_Last_Domain_;
    KEL.typ.nint Event_Age_;
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
    KEL.typ.int Kr_Address_Flag_ := 0;
    KEL.typ.int Kr_Bank_Flag_ := 0;
    KEL.typ.int Kr_Dl_Flag_ := 0;
    KEL.typ.int Kr_Email_Flag_ := 0;
    KEL.typ.int Kr_Event_After_Known_Risk_ := 0;
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
    KEL.typ.int Kr_Phone_Flag_ := 0;
    KEL.typ.int Kr_Ssn_Flag_ := 0;
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
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Ssn_;
    KEL.typ.nstr Ssn_Formatted_;
    KEL.typ.nstr State_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.nstr Suffix_;
    KEL.typ.int T18___Is_Ip_Meta_Hit_Flag_ := 0;
    KEL.typ.nint T19___Bnk_Acct_Pop_Flag_;
    KEL.typ.nstr T___Inp_Cln_Bnk_Acct_Echo_;
    KEL.typ.nstr T___Inp_Cln_Bnk_Acct_Rtg_Echo_;
    KEL.typ.nstr T___Inp_Cln_Email_Echo_;
    KEL.typ.nstr T___Inp_Cln_Ip_Addr_Echo_;
    KEL.typ.int T___Src_Class_Type_ := 0;
    KEL.typ.nint T___Src_Type_;
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
  SHARED __ST430291_Layout __ND440279__Project(__ST431893_Layout __PP439991) := TRANSFORM
    SELF.UID := __PP439991.Ip_;
    SELF._r_Customer_ := __PP439991._r_Customer__1_;
    SELF.Event_Date_ := __PP439991.Event_Date__1_;
    SELF.U_I_D__1_ := __PP439991.UID;
    SELF.Event_Date__1_ := __PP439991.Event_Date_;
    SELF._r_Customer__1_ := __PP439991._r_Customer_;
    SELF := __PP439991;
  END;
  SHARED __EE441396 := PROJECT(__EE439990,__ND440279__Project(LEFT));
  SHARED __ST430895_Layout := RECORD
    KEL.typ.ntyp(E_Internet_Protocol.Typ) UID;
    KEL.typ.bool Exp1_ := FALSE;
    KEL.typ.nint Record_Id_;
    KEL.typ.nbool Exp2_;
    KEL.typ.nbool Exp3_;
    KEL.typ.nbool Exp4_;
    KEL.typ.nbool Exp5_;
    KEL.typ.nbool Exp6_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST430895_Layout __ND442043__Project(__ST430291_Layout __PP441397) := TRANSFORM
    SELF.Exp1_ := __PP441397.Kr_Ip_Flag_ = 1;
    SELF.Exp2_ := __OP2(__PP441397.Event_Age_,<,__CN(31));
    SELF.Exp3_ := __AND(__OP2(__PP441397.Event_Age_,<,__CN(31)),__CN(__PP441397.In_Customer_Population_ = 1));
    SELF.Exp4_ := __AND(__OP2(__PP441397.Event_Age_,<,__CN(366)),__CN(__PP441397.In_Customer_Population_ = 1));
    SELF.Exp5_ := __OP2(__PP441397.Event_Age_,<,__CN(8));
    SELF.Exp6_ := __AND(__OP2(__PP441397.Event_Age_,<,__CN(8)),__CN(__PP441397.In_Customer_Population_ = 1));
    SELF := __PP441397;
  END;
  SHARED __EE442067 := PROJECT(__EE441396,__ND442043__Project(LEFT));
  SHARED __ST430940_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.nint M_A_X___Record_Id_;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE442118 := PROJECT(__CLEANANDDO(__EE442067,TABLE(__EE442067,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP,__EE442067.Exp1_),KEL.Aggregates.MaxNG(__EE442067.Record_Id_) M_A_X___Record_Id_,KEL.typ.int C_O_U_N_T___Exp1__1_ := COUNT(GROUP,__T(__EE442067.Exp2_)),KEL.typ.int C_O_U_N_T___Exp1__2_ := COUNT(GROUP,__T(__EE442067.Exp3_)),KEL.typ.int C_O_U_N_T___Exp1__3_ := COUNT(GROUP,__T(__EE442067.Exp4_)),KEL.typ.int C_O_U_N_T___Exp1__4_ := COUNT(GROUP,__T(__EE442067.Exp5_)),KEL.typ.int C_O_U_N_T___Exp1__5_ := COUNT(GROUP,__T(__EE442067.Exp6_)),UID},UID,MERGE)),__ST430940_Layout);
  SHARED __ST433311_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Internet_Protocol.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Ip_Address_;
    KEL.typ.nstr Otto_Ip_Address_Id_;
    KEL.typ.nstr _host_;
    KEL.typ.nstr _alias_;
    KEL.typ.nstr _location_;
    KEL.typ.nstr _ip__address_;
    KEL.typ.nstr _ip__address__date_;
    KEL.typ.nstr _version_;
    KEL.typ.nstr _class_;
    KEL.typ.nstr _subnet__mask_;
    KEL.typ.nstr _reserved_;
    KEL.typ.nstr _isp_;
    KEL.typ.nint _v2__validationipproblems_;
    KEL.typ.nstr _v2__ipstate_;
    KEL.typ.nstr _v2__ipcountry_;
    KEL.typ.nstr _v2__ipcontinent_;
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
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Count_ := 0;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.nint M_A_X___Record_Id_;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC442124(B_Internet_Protocol_2.__ST36513_Layout __EE420910, __ST430940_Layout __EE442118) := __EEQP(__EE420910.UID,__EE442118.UID);
  __ST433311_Layout __JT442124(B_Internet_Protocol_2.__ST36513_Layout __l, __ST430940_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE442213 := JOIN(__EE420910,__EE442118,__JC442124(LEFT,RIGHT),__JT442124(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE436593 := __EE436586(__NN(__EE436586.Ip_));
  SHARED __ST421350_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Internet_Protocol_Event_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE436584 := PROJECT(__CLEANANDDO(__EE436593,TABLE(__EE436593,{KEL.typ.int C_O_U_N_T___Internet_Protocol_Event_ := COUNT(GROUP),KEL.typ.ntyp(E_Internet_Protocol.Typ) UID := __EE436593.Ip_},Ip_,MERGE)),__ST421350_Layout);
  SHARED __ST433767_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Internet_Protocol.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Ip_Address_;
    KEL.typ.nstr Otto_Ip_Address_Id_;
    KEL.typ.nstr _host_;
    KEL.typ.nstr _alias_;
    KEL.typ.nstr _location_;
    KEL.typ.nstr _ip__address_;
    KEL.typ.nstr _ip__address__date_;
    KEL.typ.nstr _version_;
    KEL.typ.nstr _class_;
    KEL.typ.nstr _subnet__mask_;
    KEL.typ.nstr _reserved_;
    KEL.typ.nstr _isp_;
    KEL.typ.nint _v2__validationipproblems_;
    KEL.typ.nstr _v2__ipstate_;
    KEL.typ.nstr _v2__ipcountry_;
    KEL.typ.nstr _v2__ipcontinent_;
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
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Count_ := 0;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.nint M_A_X___Record_Id_;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Internet_Protocol_Event_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC442219(__ST433311_Layout __EE442213, __ST421350_Layout __EE436584) := __EEQP(__EE442213.UID,__EE436584.UID);
  __ST433767_Layout __JT442219(__ST433311_Layout __l, __ST421350_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE442310 := JOIN(__EE442213,__EE436584,__JC442219(LEFT,RIGHT),__JT442219(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST33936_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Internet_Protocol.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Ip_Address_;
    KEL.typ.nstr Otto_Ip_Address_Id_;
    KEL.typ.nstr _host_;
    KEL.typ.nstr _alias_;
    KEL.typ.nstr _location_;
    KEL.typ.nstr _ip__address_;
    KEL.typ.nstr _ip__address__date_;
    KEL.typ.nstr _version_;
    KEL.typ.nstr _class_;
    KEL.typ.nstr _subnet__mask_;
    KEL.typ.nstr _reserved_;
    KEL.typ.nstr _isp_;
    KEL.typ.nint _v2__validationipproblems_;
    KEL.typ.nstr _v2__ipstate_;
    KEL.typ.nstr _v2__ipcountry_;
    KEL.typ.nstr _v2__ipcontinent_;
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
    KEL.typ.int Event_Count_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Count_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Flag_ := 0;
    KEL.typ.int Kr_Flag_ := 0;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.nint Last_Record_Id_;
    KEL.typ.int Vl_Event30_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event365_Count_ := 0;
    KEL.typ.int Vl_Event7_All_Count_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST33936_Layout __ND442315__Project(__ST433767_Layout __PP442311) := TRANSFORM
    SELF.Event_Count_ := __PP442311.C_O_U_N_T___Internet_Protocol_Event_;
    SELF.Kr_Event_After_Last_Known_Risk_Flag_ := MAP(__PP442311.Kr_Event_After_Last_Known_Risk_Count_ > 0=>1,0);
    SELF.Kr_Flag_ := MAP(__PP442311.C_O_U_N_T___Exp1_ <> 0=>1,0);
    SELF.Last_Record_Id_ := __PP442311.M_A_X___Record_Id_;
    SELF.Vl_Event30_All_Day_Count_ := __PP442311.C_O_U_N_T___Exp1__1_;
    SELF.Vl_Event30_Count_ := __PP442311.C_O_U_N_T___Exp1__2_;
    SELF.Vl_Event365_Count_ := __PP442311.C_O_U_N_T___Exp1__3_;
    SELF.Vl_Event7_All_Count_ := __PP442311.C_O_U_N_T___Exp1__4_;
    SELF.Vl_Event7_Count_ := __PP442311.C_O_U_N_T___Exp1__5_;
    SELF := __PP442311;
  END;
  EXPORT __ENH_Internet_Protocol_1 := PROJECT(__EE442310,__ND442315__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Internet_Protocol::Annotated_1',EXPIRE(7));
END;
