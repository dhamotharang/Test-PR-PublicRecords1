﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Email_Event,E_Event,E_Internet_Protocol,E_Person,E_Phone FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Email_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Email.__Result) __E_Email := E_Email.__Result;
  SHARED VIRTUAL TYPEOF(E_Email_Event.__Result) __E_Email_Event := E_Email_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE111701 := __E_Email;
  SHARED __EE112139 := __ENH_Event_6;
  SHARED __EE113928 := __EE112139(__EE112139.Kr_High_Risk_Email_Flag_ = 1 OR __EE112139.Kr_Medium_Risk_Email_Flag_ = 1 OR __EE112139.Kr_Low_Risk_Email_Flag_ = 1);
  SHARED __EE112137 := __E_Email_Event;
  SHARED __EE117209 := __EE112137(__NN(__EE112137.Emailof_) AND __NN(__EE112137.Transaction_));
  SHARED __ST114963_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Event.Source_Customers_Layout) Source_Customers_;
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
    KEL.typ.nstr Otto_Drivers_License_Id_;
    KEL.typ.nstr Deceased_Match_Code_;
    KEL.typ.nbool _isdeepdive_;
    KEL.typ.nstr _county__death_;
    KEL.typ.nstr Deceased_Ssn_;
    KEL.typ.nstr _state__death__flag_;
    KEL.typ.nstr _death__rec__src_;
    KEL.typ.nstr _state__death__id_;
    KEL.typ.nstr _verfirst_;
    KEL.typ.nstr _verlast_;
    KEL.typ.nstr _veraddr_;
    KEL.typ.nstr _vercity_;
    KEL.typ.nstr _verstate_;
    KEL.typ.nstr _verzip_;
    KEL.typ.nstr _verzip4_;
    KEL.typ.nstr _verssn_;
    KEL.typ.nstr _verdob_;
    KEL.typ.nstr _verhphone_;
    KEL.typ.nstr _verify__addr_;
    KEL.typ.nstr _verify__dob_;
    KEL.typ.nstr _valid__ssn_;
    KEL.typ.nint _nas__summary_;
    KEL.typ.nint _nap__summary_;
    KEL.typ.nint _relativeaddressmatch_;
    KEL.typ.nstr _cvi_;
    KEL.typ.nstr _additional__fname__1_;
    KEL.typ.nstr _additional__lname__1_;
    KEL.typ.nstr _additional__lname__date__last__1_;
    KEL.typ.nstr _additional__fname__2_;
    KEL.typ.nstr _additional__lname__2_;
    KEL.typ.nstr _additional__lname__date__last__2_;
    KEL.typ.nstr _additional__fname__3_;
    KEL.typ.nstr _additional__lname__3_;
    KEL.typ.nstr _additional__lname__date__last__3_;
    KEL.typ.nint _subjectssncount_;
    KEL.typ.nstr _dobmatchlevel_;
    KEL.typ.nbool _ssnfoundforlexid_;
    KEL.typ.nstr _cvicustomscore_;
    KEL.typ.nint Subject_Ssn_Count_;
    KEL.typ.nint Date_Of_Birth_Match_Level_;
    KEL.typ.nint Stolen_Identity_Index_;
    KEL.typ.nint Synthetic_Identity_Index_;
    KEL.typ.nint Manipulated_Identity_Index_;
    KEL.typ.nint Vulnerable_Victim_Index_;
    KEL.typ.nint Friendlyfraud_Index_;
    KEL.typ.nint Suspicious_Activity_Index_;
    KEL.typ.nint _v2__sourcerisklevel_;
    KEL.typ.nint _v2__assocsuspicousidentitiescount_;
    KEL.typ.nint _v2__assoccreditbureauonlycount_;
    KEL.typ.nint _v2__validationaddrproblems_;
    KEL.typ.nint _v2__inputaddrageoldest_;
    KEL.typ.nstr _v2__inputaddrdwelltype_;
    KEL.typ.nstr _v2__divssnidentitycountnew_;
    KEL.typ.ndataset(E_Event.Hri_List_Layout) Hri_List_;
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
    KEL.typ.nstr A_C_E_Cleaner_Error_Code_;
    KEL.typ.int Deceased_Prior_To_Event_ := 0;
    KEL.typ.nbool Demo_Customer_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Kr_High_Risk_Address_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Bank_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Dl_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Email_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Ip_Address_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Phone_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Address_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Bank_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Dl_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Email_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Ip_Address_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Phone_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Address_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Bank_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Dl_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Email_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Ip_Address_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Phone_Flag_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.nkdate Event_Date__1_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC117227(B_Event_6.__ST63668_Layout __EE113928, E_Email_Event.Layout __EE117209) := __EEQP(__EE117209.Transaction_,__EE113928.UID);
  __ST114963_Layout __JT117227(B_Event_6.__ST63668_Layout __l, E_Email_Event.Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF.Event_Date__1_ := __r.Event_Date_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE117228 := JOIN(__EE117209,__EE113928,__JC117227(RIGHT,LEFT),__JT117227(RIGHT,LEFT),INNER,HASH);
  SHARED __ST113466_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ndataset(E_Event.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nint Record_Id_;
    KEL.typ.nkdate Event_Date__1_;
    KEL.typ.ndataset(E_Event.Event_Types_Layout) Event_Types_;
    KEL.typ.ntyp(E_Phone.Typ) _r_Phone_;
    KEL.typ.ntyp(E_Email.Typ) _r_Email_;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) _r_Internet_Protocol_;
    KEL.typ.ntyp(E_Bank_Account.Typ) _r_Bank_Account_;
    KEL.typ.ntyp(E_Drivers_License.Typ) _r_Drivers_License_;
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
    KEL.typ.nstr Otto_Drivers_License_Id_;
    KEL.typ.nstr Deceased_Match_Code_;
    KEL.typ.nbool _isdeepdive_;
    KEL.typ.nstr _county__death_;
    KEL.typ.nstr Deceased_Ssn_;
    KEL.typ.nstr _state__death__flag_;
    KEL.typ.nstr _death__rec__src_;
    KEL.typ.nstr _state__death__id_;
    KEL.typ.nstr _verfirst_;
    KEL.typ.nstr _verlast_;
    KEL.typ.nstr _veraddr_;
    KEL.typ.nstr _vercity_;
    KEL.typ.nstr _verstate_;
    KEL.typ.nstr _verzip_;
    KEL.typ.nstr _verzip4_;
    KEL.typ.nstr _verssn_;
    KEL.typ.nstr _verdob_;
    KEL.typ.nstr _verhphone_;
    KEL.typ.nstr _verify__addr_;
    KEL.typ.nstr _verify__dob_;
    KEL.typ.nstr _valid__ssn_;
    KEL.typ.nint _nas__summary_;
    KEL.typ.nint _nap__summary_;
    KEL.typ.nint _relativeaddressmatch_;
    KEL.typ.nstr _cvi_;
    KEL.typ.nstr _additional__fname__1_;
    KEL.typ.nstr _additional__lname__1_;
    KEL.typ.nstr _additional__lname__date__last__1_;
    KEL.typ.nstr _additional__fname__2_;
    KEL.typ.nstr _additional__lname__2_;
    KEL.typ.nstr _additional__lname__date__last__2_;
    KEL.typ.nstr _additional__fname__3_;
    KEL.typ.nstr _additional__lname__3_;
    KEL.typ.nstr _additional__lname__date__last__3_;
    KEL.typ.nint _subjectssncount_;
    KEL.typ.nstr _dobmatchlevel_;
    KEL.typ.nbool _ssnfoundforlexid_;
    KEL.typ.nstr _cvicustomscore_;
    KEL.typ.nint Subject_Ssn_Count_;
    KEL.typ.nint Date_Of_Birth_Match_Level_;
    KEL.typ.nint Stolen_Identity_Index_;
    KEL.typ.nint Synthetic_Identity_Index_;
    KEL.typ.nint Manipulated_Identity_Index_;
    KEL.typ.nint Vulnerable_Victim_Index_;
    KEL.typ.nint Friendlyfraud_Index_;
    KEL.typ.nint Suspicious_Activity_Index_;
    KEL.typ.nint _v2__sourcerisklevel_;
    KEL.typ.nint _v2__assocsuspicousidentitiescount_;
    KEL.typ.nint _v2__assoccreditbureauonlycount_;
    KEL.typ.nint _v2__validationaddrproblems_;
    KEL.typ.nint _v2__inputaddrageoldest_;
    KEL.typ.nstr _v2__inputaddrdwelltype_;
    KEL.typ.nstr _v2__divssnidentitycountnew_;
    KEL.typ.ndataset(E_Event.Hri_List_Layout) Hri_List_;
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
    KEL.typ.nstr A_C_E_Cleaner_Error_Code_;
    KEL.typ.int Deceased_Prior_To_Event_ := 0;
    KEL.typ.nbool Demo_Customer_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Kr_High_Risk_Address_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Bank_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Dl_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Email_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Ip_Address_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Phone_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Address_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Bank_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Dl_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Email_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Ip_Address_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Phone_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Address_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Bank_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Dl_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Email_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Ip_Address_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Phone_Flag_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST113466_Layout __ND117426__Project(__ST114963_Layout __PP117229) := TRANSFORM
    SELF.UID := __PP117229.Emailof_;
    SELF._r_Customer_ := __PP117229._r_Customer__1_;
    SELF.Event_Date_ := __PP117229.Event_Date__1_;
    SELF.U_I_D__1_ := __PP117229.UID;
    SELF._r_Customer__1_ := __PP117229._r_Customer_;
    SELF.Event_Date__1_ := __PP117229.Event_Date_;
    SELF := __PP117229;
  END;
  SHARED __EE118171 := PROJECT(__EE117228,__ND117426__Project(LEFT));
  SHARED __ST113860_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.nkdate Event_Date__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE118185 := PROJECT(__EE118171,__ST113860_Layout);
  SHARED __ST113875_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date__1_;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE118201 := PROJECT(__CLEANANDDO(__EE118185,TABLE(__EE118185,{KEL.Aggregates.MaxNG(__EE118185.Event_Date__1_) M_A_X___Event_Date__1_,UID},UID,MERGE)),__ST113875_Layout);
  SHARED __ST115920_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.nstr Email_Last_Domain_;
    KEL.typ.nint _isdisposableemail_;
    KEL.typ.nkdate M_A_X___Event_Date__1_;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC118207(E_Email.Layout __EE111701, __ST113875_Layout __EE118201) := __EEQP(__EE111701.UID,__EE118201.UID);
  __ST115920_Layout __JT118207(E_Email.Layout __l, __ST113875_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE118208 := JOIN(__EE111701,__EE118201,__JC118207(LEFT,RIGHT),__JT118207(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST62075_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.nstr Email_Last_Domain_;
    KEL.typ.nint _isdisposableemail_;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Email_5 := PROJECT(__EE118208,TRANSFORM(__ST62075_Layout,SELF.Kr_Last_Event_Date_ := LEFT.M_A_X___Event_Date__1_,SELF := LEFT)) : PERSIST('~temp::KEL::KELOtto::Email::Annotated_5',EXPIRE(7));
END;
