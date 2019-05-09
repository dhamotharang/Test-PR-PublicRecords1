﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer_6,B_Event_6,B_Person_6,B_Person_7,E_Address,E_Customer,E_Event,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Event_5 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_6.__ENH_Customer_6) __ENH_Customer_6 := B_Customer_6.__ENH_Customer_6;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED VIRTUAL TYPEOF(B_Person_6.__ENH_Person_6) __ENH_Person_6 := B_Person_6.__ENH_Person_6;
  SHARED __EE34910 := __ENH_Event_6;
  SHARED __EE35540 := __ENH_Person_6;
  SHARED __ST36043_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Event.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nint Record_Id_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ndataset(E_Event.Event_Types_Layout) Event_Types_;
    KEL.typ.nkdate Date_Of_Birth_;
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
    KEL.typ.int Deceased_Prior_To_Event_ := 0;
    KEL.typ.nbool Demo_Customer_;
    KEL.typ.nint Event_Type_Count_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.nint Lex_Id_;
    KEL.typ.ndataset(E_Person.Source_Customers_Layout) Source_Customers__1_;
    KEL.typ.ndataset(E_Person.Reported_Date_Of_Birth_Layout) Reported_Date_Of_Birth_;
    KEL.typ.ndataset(E_Person.Full_Name_Layout) Full_Name_;
    KEL.typ.nkdate Deceased_Date__1_;
    KEL.typ.nkdate Deceased_Date_Of_Birth__1_;
    KEL.typ.nstr Deceased_First__1_;
    KEL.typ.nstr Deceased_Middle__1_;
    KEL.typ.nstr Deceased_Last__1_;
    KEL.typ.nstr Deceased_Match_Code__1_;
    KEL.typ.nbool _isdeepdive__1_;
    KEL.typ.nstr _county__death__1_;
    KEL.typ.nstr Deceased_Ssn__1_;
    KEL.typ.nstr _state__death__flag__1_;
    KEL.typ.nstr _death__rec__src__1_;
    KEL.typ.nstr _state__death__id__1_;
    KEL.typ.nstr _verfirst__1_;
    KEL.typ.nstr _verlast__1_;
    KEL.typ.nstr _veraddr__1_;
    KEL.typ.nstr _vercity__1_;
    KEL.typ.nstr _verstate__1_;
    KEL.typ.nstr _verzip__1_;
    KEL.typ.nstr _verzip4__1_;
    KEL.typ.nstr _verssn__1_;
    KEL.typ.nstr _verdob__1_;
    KEL.typ.nstr _verhphone__1_;
    KEL.typ.nstr _verify__addr__1_;
    KEL.typ.nstr _verify__dob__1_;
    KEL.typ.nstr _valid__ssn__1_;
    KEL.typ.nint _nas__summary__1_;
    KEL.typ.nint _nap__summary__1_;
    KEL.typ.nstr _cvi__1_;
    KEL.typ.nstr _additional__fname__4_;
    KEL.typ.nstr _additional__lname__4_;
    KEL.typ.nstr _additional__lname__date__last__4_;
    KEL.typ.nstr _additional__fname__5_;
    KEL.typ.nstr _additional__lname__5_;
    KEL.typ.nstr _additional__lname__date__last__5_;
    KEL.typ.nstr _additional__fname__6_;
    KEL.typ.nstr _additional__lname__6_;
    KEL.typ.nstr _additional__lname__date__last__6_;
    KEL.typ.nint _subjectssncount__1_;
    KEL.typ.nstr _dobmatchlevel__1_;
    KEL.typ.nbool _ssnfoundforlexid__1_;
    KEL.typ.nstr _cvicustomscore__1_;
    KEL.typ.nint Subject_Ssn_Count__1_;
    KEL.typ.nint Date_Of_Birth_Match_Level__1_;
    KEL.typ.nint Stolen_Identity_Index__1_;
    KEL.typ.nint Synthetic_Identity_Index__1_;
    KEL.typ.nint Manipulated_Identity_Index__1_;
    KEL.typ.nint Vulnerable_Victim_Index__1_;
    KEL.typ.nint Friendlyfraud_Index__1_;
    KEL.typ.nint Suspicious_Activity_Index__1_;
    KEL.typ.nint _v2__sourcerisklevel__1_;
    KEL.typ.nint _v2__assocsuspicousidentitiescount__1_;
    KEL.typ.nint _v2__assoccreditbureauonlycount__1_;
    KEL.typ.nint _v2__validationaddrproblems__1_;
    KEL.typ.nint _v2__inputaddrageoldest__1_;
    KEL.typ.nstr _v2__inputaddrdwelltype__1_;
    KEL.typ.nstr _v2__divssnidentitycountnew__1_;
    KEL.typ.nstr _curr__incar__flag_;
    KEL.typ.nint _name__ssn__dob__match_;
    KEL.typ.ndataset(E_Person.Offenses_Layout) Offenses_;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC36040(B_Event_6.__ST22959_Layout __EE34910, B_Person_7.__ST23627_Layout __EE35540) := __EEQP(__EE34910.Subject_,__EE35540.UID);
  __ST36043_Layout __JT36040(B_Event_6.__ST22959_Layout __l, B_Person_7.__ST23627_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF.Source_Customers__1_ := __r.Source_Customers_;
    SELF.Deceased_Date__1_ := __r.Deceased_Date_;
    SELF.Deceased_Date_Of_Birth__1_ := __r.Deceased_Date_Of_Birth_;
    SELF.Deceased_First__1_ := __r.Deceased_First_;
    SELF.Deceased_Middle__1_ := __r.Deceased_Middle_;
    SELF.Deceased_Last__1_ := __r.Deceased_Last_;
    SELF.Deceased_Match_Code__1_ := __r.Deceased_Match_Code_;
    SELF._isdeepdive__1_ := __r._isdeepdive_;
    SELF._county__death__1_ := __r._county__death_;
    SELF.Deceased_Ssn__1_ := __r.Deceased_Ssn_;
    SELF._state__death__flag__1_ := __r._state__death__flag_;
    SELF._death__rec__src__1_ := __r._death__rec__src_;
    SELF._state__death__id__1_ := __r._state__death__id_;
    SELF._verfirst__1_ := __r._verfirst_;
    SELF._verlast__1_ := __r._verlast_;
    SELF._veraddr__1_ := __r._veraddr_;
    SELF._vercity__1_ := __r._vercity_;
    SELF._verstate__1_ := __r._verstate_;
    SELF._verzip__1_ := __r._verzip_;
    SELF._verzip4__1_ := __r._verzip4_;
    SELF._verssn__1_ := __r._verssn_;
    SELF._verdob__1_ := __r._verdob_;
    SELF._verhphone__1_ := __r._verhphone_;
    SELF._verify__addr__1_ := __r._verify__addr_;
    SELF._verify__dob__1_ := __r._verify__dob_;
    SELF._valid__ssn__1_ := __r._valid__ssn_;
    SELF._nas__summary__1_ := __r._nas__summary_;
    SELF._nap__summary__1_ := __r._nap__summary_;
    SELF._cvi__1_ := __r._cvi_;
    SELF._additional__fname__4_ := __r._additional__fname__1_;
    SELF._additional__lname__4_ := __r._additional__lname__1_;
    SELF._additional__lname__date__last__4_ := __r._additional__lname__date__last__1_;
    SELF._additional__fname__5_ := __r._additional__fname__2_;
    SELF._additional__lname__5_ := __r._additional__lname__2_;
    SELF._additional__lname__date__last__5_ := __r._additional__lname__date__last__2_;
    SELF._additional__fname__6_ := __r._additional__fname__3_;
    SELF._additional__lname__6_ := __r._additional__lname__3_;
    SELF._additional__lname__date__last__6_ := __r._additional__lname__date__last__3_;
    SELF._subjectssncount__1_ := __r._subjectssncount_;
    SELF._dobmatchlevel__1_ := __r._dobmatchlevel_;
    SELF._ssnfoundforlexid__1_ := __r._ssnfoundforlexid_;
    SELF._cvicustomscore__1_ := __r._cvicustomscore_;
    SELF.Subject_Ssn_Count__1_ := __r.Subject_Ssn_Count_;
    SELF.Date_Of_Birth_Match_Level__1_ := __r.Date_Of_Birth_Match_Level_;
    SELF.Stolen_Identity_Index__1_ := __r.Stolen_Identity_Index_;
    SELF.Synthetic_Identity_Index__1_ := __r.Synthetic_Identity_Index_;
    SELF.Manipulated_Identity_Index__1_ := __r.Manipulated_Identity_Index_;
    SELF.Vulnerable_Victim_Index__1_ := __r.Vulnerable_Victim_Index_;
    SELF.Friendlyfraud_Index__1_ := __r.Friendlyfraud_Index_;
    SELF.Suspicious_Activity_Index__1_ := __r.Suspicious_Activity_Index_;
    SELF._v2__sourcerisklevel__1_ := __r._v2__sourcerisklevel_;
    SELF._v2__assocsuspicousidentitiescount__1_ := __r._v2__assocsuspicousidentitiescount_;
    SELF._v2__assoccreditbureauonlycount__1_ := __r._v2__assoccreditbureauonlycount_;
    SELF._v2__validationaddrproblems__1_ := __r._v2__validationaddrproblems_;
    SELF._v2__inputaddrageoldest__1_ := __r._v2__inputaddrageoldest_;
    SELF._v2__inputaddrdwelltype__1_ := __r._v2__inputaddrdwelltype_;
    SELF._v2__divssnidentitycountnew__1_ := __r._v2__divssnidentitycountnew_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE36041 := JOIN(__EE34910,__EE35540,__JC36040(LEFT,RIGHT),__JT36040(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE35527 := __ENH_Customer_6;
  SHARED __ST37063_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Event.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nint Record_Id_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ndataset(E_Event.Event_Types_Layout) Event_Types_;
    KEL.typ.nkdate Date_Of_Birth_;
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
    KEL.typ.int Deceased_Prior_To_Event_ := 0;
    KEL.typ.nbool Demo_Customer_;
    KEL.typ.nint Event_Type_Count_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.nint Lex_Id_;
    KEL.typ.ndataset(E_Person.Source_Customers_Layout) Source_Customers__1_;
    KEL.typ.ndataset(E_Person.Reported_Date_Of_Birth_Layout) Reported_Date_Of_Birth_;
    KEL.typ.ndataset(E_Person.Full_Name_Layout) Full_Name_;
    KEL.typ.nkdate Deceased_Date__1_;
    KEL.typ.nkdate Deceased_Date_Of_Birth__1_;
    KEL.typ.nstr Deceased_First__1_;
    KEL.typ.nstr Deceased_Middle__1_;
    KEL.typ.nstr Deceased_Last__1_;
    KEL.typ.nstr Deceased_Match_Code__1_;
    KEL.typ.nbool _isdeepdive__1_;
    KEL.typ.nstr _county__death__1_;
    KEL.typ.nstr Deceased_Ssn__1_;
    KEL.typ.nstr _state__death__flag__1_;
    KEL.typ.nstr _death__rec__src__1_;
    KEL.typ.nstr _state__death__id__1_;
    KEL.typ.nstr _verfirst__1_;
    KEL.typ.nstr _verlast__1_;
    KEL.typ.nstr _veraddr__1_;
    KEL.typ.nstr _vercity__1_;
    KEL.typ.nstr _verstate__1_;
    KEL.typ.nstr _verzip__1_;
    KEL.typ.nstr _verzip4__1_;
    KEL.typ.nstr _verssn__1_;
    KEL.typ.nstr _verdob__1_;
    KEL.typ.nstr _verhphone__1_;
    KEL.typ.nstr _verify__addr__1_;
    KEL.typ.nstr _verify__dob__1_;
    KEL.typ.nstr _valid__ssn__1_;
    KEL.typ.nint _nas__summary__1_;
    KEL.typ.nint _nap__summary__1_;
    KEL.typ.nstr _cvi__1_;
    KEL.typ.nstr _additional__fname__4_;
    KEL.typ.nstr _additional__lname__4_;
    KEL.typ.nstr _additional__lname__date__last__4_;
    KEL.typ.nstr _additional__fname__5_;
    KEL.typ.nstr _additional__lname__5_;
    KEL.typ.nstr _additional__lname__date__last__5_;
    KEL.typ.nstr _additional__fname__6_;
    KEL.typ.nstr _additional__lname__6_;
    KEL.typ.nstr _additional__lname__date__last__6_;
    KEL.typ.nint _subjectssncount__1_;
    KEL.typ.nstr _dobmatchlevel__1_;
    KEL.typ.nbool _ssnfoundforlexid__1_;
    KEL.typ.nstr _cvicustomscore__1_;
    KEL.typ.nint Subject_Ssn_Count__1_;
    KEL.typ.nint Date_Of_Birth_Match_Level__1_;
    KEL.typ.nint Stolen_Identity_Index__1_;
    KEL.typ.nint Synthetic_Identity_Index__1_;
    KEL.typ.nint Manipulated_Identity_Index__1_;
    KEL.typ.nint Vulnerable_Victim_Index__1_;
    KEL.typ.nint Friendlyfraud_Index__1_;
    KEL.typ.nint Suspicious_Activity_Index__1_;
    KEL.typ.nint _v2__sourcerisklevel__1_;
    KEL.typ.nint _v2__assocsuspicousidentitiescount__1_;
    KEL.typ.nint _v2__assoccreditbureauonlycount__1_;
    KEL.typ.nint _v2__validationaddrproblems__1_;
    KEL.typ.nint _v2__inputaddrageoldest__1_;
    KEL.typ.nstr _v2__inputaddrdwelltype__1_;
    KEL.typ.nstr _v2__divssnidentitycountnew__1_;
    KEL.typ.nstr _curr__incar__flag_;
    KEL.typ.nint _name__ssn__dob__match_;
    KEL.typ.ndataset(E_Person.Offenses_Layout) Offenses_;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.nuid U_I_D__2_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC38585(__ST36043_Layout __EE36041, B_Customer_6.__ST22812_Layout __EE35527) := __EEQP(__EE36041._r_Customer_,__EE35527.UID);
  __ST37063_Layout __JT38585(__ST36043_Layout __l, B_Customer_6.__ST22812_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE38586 := JOIN(__EE36041,__EE35527,__JC38585(LEFT,RIGHT),__JT38585(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST22494_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Event.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nint Record_Id_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ndataset(E_Event.Event_Types_Layout) Event_Types_;
    KEL.typ.nkdate Date_Of_Birth_;
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
    KEL.typ.nint Age_;
    KEL.typ.int Deceased_Prior_To_Event_ := 0;
    KEL.typ.nint Deceased_To_Event_Year_Diff_;
    KEL.typ.nbool Demo_Customer_;
    KEL.typ.nint Event_Type_Count_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Kr_Identity_Risk_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST22494_Layout __ND38829__Project(__ST37063_Layout __PP37964) := TRANSFORM
    SELF.Age_ := IF(__T(__PP37964.Demo_Customer_),__ECAST(KEL.typ.nint,__FN2(KEL.Routines.DaysBetween,__PP37964.Event_Date_,__CN(KEL.Routines.DateFromParts(2018,4,7)))),__ECAST(KEL.typ.nint,__FN2(KEL.Routines.DaysBetween,__PP37964.Event_Date_,__PP37964.Event_Date_Max_)));
    SELF.Deceased_To_Event_Year_Diff_ := MAP(__PP37964.Deceased_Match_ = 1=>__ECAST(KEL.typ.nint,__FN2(KEL.Routines.YearsBetween,__PP37964.Event_Date_,__PP37964.Deceased_Date__1_)),__ECAST(KEL.typ.nint,__CN(0)));
    SELF.Kr_Identity_Risk_ := MAP(__T(__OR(__OR(__OP2(__PP37964._name__risk__code_,<>,__CN(0)),__OP2(__PP37964._dob__risk__code_,<>,__CN(0))),__OP2(__PP37964._identity__risk__code_,<>,__CN(0))))=>1,0);
    SELF := __PP37964;
  END;
  EXPORT __ENH_Event_5 := PROJECT(__EE38586,__ND38829__Project(LEFT));
END;
