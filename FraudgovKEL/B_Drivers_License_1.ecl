﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Drivers_License_2,B_Event_2,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Drivers_License_Event,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Drivers_License,E_Person_Event,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Drivers_License_1 := MODULE
  SHARED VIRTUAL TYPEOF(B_Drivers_License_2.__ENH_Drivers_License_2) __ENH_Drivers_License_2 := B_Drivers_License_2.__ENH_Drivers_License_2;
  SHARED VIRTUAL TYPEOF(E_Drivers_License_Event.__Result) __E_Drivers_License_Event := E_Drivers_License_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_2.__ENH_Event_2) __ENH_Event_2 := B_Event_2.__ENH_Event_2;
  SHARED VIRTUAL TYPEOF(E_Person_Drivers_License.__Result) __E_Person_Drivers_License := E_Person_Drivers_License.__Result;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE312931 := __ENH_Drivers_License_2;
  SHARED __EE312973 := __ENH_Event_2;
  SHARED __EE312971 := __E_Drivers_License_Event;
  SHARED __EE313185 := __EE312971(__NN(__EE312971.Licence_) AND __NN(__EE312971.Transaction_));
  SHARED __ST311379_Layout := RECORD
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
    KEL.typ.ntyp(E_Social_Security_Number.Typ) _r_Ssn_;
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
    KEL.typ.nstr A_C_E_Cleaner_Error_Code_;
    KEL.typ.int Address_Is_Cmra_ := 0;
    KEL.typ.int Address_Out_Of_State_ := 0;
    KEL.typ.int Deceased_Prior_To_Event_ := 0;
    KEL.typ.nint Deceased_To_Event_Year_Diff_;
    KEL.typ.nbool Demo_Customer_;
    KEL.typ.nint Event_Age_;
    KEL.typ.int Hri11_Flag_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Invalid_Address_ := 0;
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
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ntyp(E_Drivers_License.Typ) Licence_;
    KEL.typ.nkdate Event_Date__1_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC313203(B_Event_2.__ST38500_Layout __EE312973, E_Drivers_License_Event.Layout __EE313185) := __EEQP(__EE313185.Transaction_,__EE312973.UID);
  __ST311379_Layout __JT313203(B_Event_2.__ST38500_Layout __l, E_Drivers_License_Event.Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF.Event_Date__1_ := __r.Event_Date_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE313204 := JOIN(__EE313185,__EE312973,__JC313203(RIGHT,LEFT),__JT313203(RIGHT,LEFT),INNER,HASH);
  SHARED __ST310743_Layout := RECORD
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Drivers_License.Typ) Licence_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.int Kr_Dl_Flag_ := 0;
    KEL.typ.nint Event_Age_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST310743_Layout __ND313432__Project(__ST311379_Layout __PP313205) := TRANSFORM
    SELF.UID := __PP313205.Licence_;
    SELF._r_Customer_ := __PP313205._r_Customer__1_;
    SELF.Event_Date_ := __PP313205.Event_Date__1_;
    SELF.U_I_D__1_ := __PP313205.UID;
    SELF := __PP313205;
  END;
  SHARED __EE313469 := PROJECT(__EE313204,__ND313432__Project(LEFT));
  SHARED __ST310800_Layout := RECORD
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.bool Exp1_ := FALSE;
    KEL.typ.nbool Exp2_;
    KEL.typ.nbool Exp3_;
    KEL.typ.nbool Exp4_;
    KEL.typ.nbool Exp5_;
    KEL.typ.nbool Exp6_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST310800_Layout __ND314208__Project(__ST310743_Layout __PP313470) := TRANSFORM
    SELF.Exp1_ := __PP313470.Kr_Dl_Flag_ = 1;
    SELF.Exp2_ := __OP2(__PP313470.Event_Age_,<,__CN(31));
    SELF.Exp3_ := __AND(__OP2(__PP313470.Event_Age_,<,__CN(31)),__CN(__PP313470.In_Customer_Population_ = 1));
    SELF.Exp4_ := __AND(__OP2(__PP313470.Event_Age_,<,__CN(366)),__CN(__PP313470.In_Customer_Population_ = 1));
    SELF.Exp5_ := __OP2(__PP313470.Event_Age_,<,__CN(8));
    SELF.Exp6_ := __AND(__OP2(__PP313470.Event_Age_,<,__CN(8)),__CN(__PP313470.In_Customer_Population_ = 1));
    SELF := __PP313470;
  END;
  SHARED __EE314231 := PROJECT(__EE313469,__ND314208__Project(LEFT));
  SHARED __ST310840_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE314277 := PROJECT(__CLEANANDDO(__EE314231,TABLE(__EE314231,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP,__EE314231.Exp1_),KEL.typ.int C_O_U_N_T___Exp1__1_ := COUNT(GROUP,__T(__EE314231.Exp2_)),KEL.typ.int C_O_U_N_T___Exp1__2_ := COUNT(GROUP,__T(__EE314231.Exp3_)),KEL.typ.int C_O_U_N_T___Exp1__3_ := COUNT(GROUP,__T(__EE314231.Exp4_)),KEL.typ.int C_O_U_N_T___Exp1__4_ := COUNT(GROUP,__T(__EE314231.Exp5_)),KEL.typ.int C_O_U_N_T___Exp1__5_ := COUNT(GROUP,__T(__EE314231.Exp6_)),UID},UID,MERGE)),__ST310840_Layout);
  SHARED __ST311660_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Drivers_License.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Otto_Drivers_License_Id_;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Count_ := 0;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC314283(B_Drivers_License_2.__ST37604_Layout __EE312931, __ST310840_Layout __EE314277) := __EEQP(__EE312931.UID,__EE314277.UID);
  __ST311660_Layout __JT314283(B_Drivers_License_2.__ST37604_Layout __l, __ST310840_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE314304 := JOIN(__EE312931,__EE314277,__JC314283(LEFT,RIGHT),__JT314283(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE312948 := __E_Person_Drivers_License;
  SHARED __EE312955 := __EE312948(__NN(__EE312948.License_));
  SHARED __ST309929_Layout := RECORD
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE312969 := PROJECT(TABLE(PROJECT(__EE312955,TRANSFORM(__ST309929_Layout,SELF.UID := LEFT.License_,SELF := LEFT)),{KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),UID,Subject_},UID,Subject_,MERGE),__ST309929_Layout);
  SHARED __ST309947_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Drivers_License_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE312946 := PROJECT(__CLEANANDDO(__EE312969,TABLE(__EE312969,{KEL.typ.int C_O_U_N_T___Person_Drivers_License_ := COUNT(GROUP),UID},UID,MERGE)),__ST309947_Layout);
  SHARED __ST311787_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Drivers_License.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Otto_Drivers_License_Id_;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Count_ := 0;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Drivers_License_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) U_I_D__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC314310(__ST311660_Layout __EE314304, __ST309947_Layout __EE312946) := __EEQP(__EE314304.UID,__EE312946.UID);
  __ST311787_Layout __JT314310(__ST311660_Layout __l, __ST309947_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE314333 := JOIN(__EE314304,__EE312946,__JC314310(LEFT,RIGHT),__JT314310(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST32869_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Drivers_License.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Otto_Drivers_License_Id_;
    KEL.typ.nstr Entity_Context_Uid_;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Count_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Flag_ := 0;
    KEL.typ.int Kr_Flag_ := 0;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.nstr Label_;
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
  SHARED __ST32869_Layout __ND314338__Project(__ST311787_Layout __PP314334) := TRANSFORM
    SELF.Entity_Context_Uid_ := __OP2(__CN('_20'),+,__PP314334.Otto_Drivers_License_Id_);
    SELF.Identity_Count_ := __PP314334.C_O_U_N_T___Person_Drivers_License_;
    SELF.Kr_Event_After_Last_Known_Risk_Flag_ := MAP(__PP314334.Kr_Event_After_Last_Known_Risk_Count_ > 0=>1,0);
    SELF.Kr_Flag_ := MAP(__PP314334.C_O_U_N_T___Exp1_ <> 0=>1,0);
    SELF.Label_ := __PP314334.License_Number_;
    __EE313924 := __EE312973;
    __EE312872 := __E_Person_Event;
    __EE312881 := __EE312872(__NN(__EE312872.Transaction_));
    __JC313958(B_Event_2.__ST38500_Layout __EE313924, E_Person_Event.Layout __EE312881) := __EEQP(__EE312881.Transaction_,__EE313924.UID);
    __EE313959 := JOIN(__EE313924,__EE312881,__JC313958(LEFT,RIGHT),TRANSFORM(B_Event_2.__ST38500_Layout,SELF:=LEFT),HASH,KEEP(1));
    SELF.Last_Record_Id_ := KEL.Aggregates.MaxN(__EE313959,__EE313959.Record_Id_);
    SELF.Vl_Event30_All_Day_Count_ := __PP314334.C_O_U_N_T___Exp1__1_;
    SELF.Vl_Event30_Count_ := __PP314334.C_O_U_N_T___Exp1__2_;
    SELF.Vl_Event365_Count_ := __PP314334.C_O_U_N_T___Exp1__3_;
    SELF.Vl_Event7_All_Count_ := __PP314334.C_O_U_N_T___Exp1__4_;
    SELF.Vl_Event7_Count_ := __PP314334.C_O_U_N_T___Exp1__5_;
    SELF := __PP314334;
  END;
  EXPORT __ENH_Drivers_License_1 := PROJECT(__EE314333,__ND314338__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Drivers_License::Annotated_1',EXPIRE(7));
END;
