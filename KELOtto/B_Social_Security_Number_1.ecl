﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Event_2,B_Social_Security_Number_2,E_Address,E_Customer,E_Event,E_Person,E_Person_S_S_N,E_Social_Security_Number,E_Ssn_Event FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Social_Security_Number_1 := MODULE
  SHARED VIRTUAL TYPEOF(B_Event_2.__ENH_Event_2) __ENH_Event_2 := B_Event_2.__ENH_Event_2;
  SHARED VIRTUAL TYPEOF(E_Person_S_S_N.__Result) __E_Person_S_S_N := E_Person_S_S_N.__Result;
  SHARED VIRTUAL TYPEOF(B_Social_Security_Number_2.__ENH_Social_Security_Number_2) __ENH_Social_Security_Number_2 := B_Social_Security_Number_2.__ENH_Social_Security_Number_2;
  SHARED VIRTUAL TYPEOF(E_Ssn_Event.__Result) __E_Ssn_Event := E_Ssn_Event.__Result;
  SHARED __EE337015 := __ENH_Social_Security_Number_2;
  SHARED __EE341609 := __ENH_Event_2;
  SHARED __EE341607 := __E_Ssn_Event;
  SHARED __EE341830 := __EE341607(__NN(__EE341607.Social_) AND __NN(__EE341607.Transaction_));
  SHARED __ST339096_Layout := RECORD
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
    KEL.typ.int Ip_High_Risk_City_ := 0;
    KEL.typ.int Ip_Hosted_ := 0;
    KEL.typ.int Ip_Not_Us_ := 0;
    KEL.typ.int Ip_Tor_ := 0;
    KEL.typ.int Ip_Vpn_ := 0;
    KEL.typ.int Kr_High_Risk_Identity_Flag_ := 0;
    KEL.typ.int Kr_Identity_Risk_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) Social_;
    KEL.typ.nkdate Event_Date__1_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC341848(B_Event_2.__ST20684_Layout __EE341609, E_Ssn_Event.Layout __EE341830) := __EEQP(__EE341830.Transaction_,__EE341609.UID);
  __ST339096_Layout __JT341848(B_Event_2.__ST20684_Layout __l, E_Ssn_Event.Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF.Event_Date__1_ := __r.Event_Date_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE341849 := JOIN(__EE341830,__EE341609,__JC341848(RIGHT,LEFT),__JT341848(RIGHT,LEFT),INNER,HASH);
  SHARED __ST338727_Layout := RECORD
    KEL.typ.ntyp(E_Social_Security_Number.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) Social_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Age_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST338727_Layout __ND342021__Project(__ST339096_Layout __PP341850) := TRANSFORM
    SELF.UID := __PP341850.Social_;
    SELF._r_Customer_ := __PP341850._r_Customer__1_;
    SELF.Event_Date_ := __PP341850.Event_Date__1_;
    SELF.U_I_D__1_ := __PP341850.UID;
    SELF := __PP341850;
  END;
  SHARED __EE342054 := PROJECT(__EE341849,__ND342021__Project(LEFT));
  SHARED __ST338772_Layout := RECORD
    KEL.typ.ntyp(E_Social_Security_Number.Typ) UID;
    KEL.typ.nbool Exp1_;
    KEL.typ.nbool Exp2_;
    KEL.typ.nbool Exp3_;
    KEL.typ.nbool Exp4_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST338772_Layout __ND342998__Project(__ST338727_Layout __PP342055) := TRANSFORM
    SELF.Exp1_ := __OP2(__PP342055.Age_,<,__CN(31));
    SELF.Exp2_ := __AND(__OP2(__PP342055.Age_,<,__CN(31)),__CN(__PP342055.In_Customer_Population_ = 1));
    SELF.Exp3_ := __OP2(__PP342055.Age_,<,__CN(8));
    SELF.Exp4_ := __AND(__OP2(__PP342055.Age_,<,__CN(8)),__CN(__PP342055.In_Customer_Population_ = 1));
    SELF := __PP342055;
  END;
  SHARED __EE343015 := PROJECT(__EE342054,__ND342998__Project(LEFT));
  SHARED __ST338802_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE343050 := PROJECT(__CLEANANDDO(__EE343015,TABLE(__EE343015,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP,__T(__EE343015.Exp1_)),KEL.typ.int C_O_U_N_T___Exp1__1_ := COUNT(GROUP,__T(__EE343015.Exp2_)),KEL.typ.int C_O_U_N_T___Exp1__2_ := COUNT(GROUP,__T(__EE343015.Exp3_)),KEL.typ.int C_O_U_N_T___Exp1__3_ := COUNT(GROUP,__T(__EE343015.Exp4_)),UID},UID,MERGE)),__ST338802_Layout);
  SHARED __ST339325_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Social_Security_Number.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nunk Ssn_;
    KEL.typ.nint Otto_S_S_N_Id_;
    KEL.typ.nstr Ssn_Formatted_;
    KEL.typ.nunk _v2__divssnidentitycountnew_;
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
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC343056(B_Social_Security_Number_2.__ST21231_Layout __EE337015, __ST338802_Layout __EE343050) := __EEQP(__EE337015.UID,__EE343050.UID);
  __ST339325_Layout __JT343056(B_Social_Security_Number_2.__ST21231_Layout __l, __ST338802_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE343090 := JOIN(__EE337015,__EE343050,__JC343056(LEFT,RIGHT),__JT343056(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE341584 := __E_Person_S_S_N;
  SHARED __EE341591 := __EE341584(__NN(__EE341584.Social_));
  SHARED __ST338345_Layout := RECORD
    KEL.typ.ntyp(E_Social_Security_Number.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE341605 := DEDUP(PROJECT(__EE341591,TRANSFORM(__ST338345_Layout,SELF.UID := LEFT.Social_,SELF := LEFT)),ALL);
  SHARED __ST338363_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_S_S_N_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE341418 := PROJECT(__CLEANANDDO(__EE341605,TABLE(__EE341605,{KEL.typ.int C_O_U_N_T___Person_S_S_N_ := COUNT(GROUP),UID},UID,MERGE)),__ST338363_Layout);
  SHARED __ST339526_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Social_Security_Number.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nunk Ssn_;
    KEL.typ.nint Otto_S_S_N_Id_;
    KEL.typ.nstr Ssn_Formatted_;
    KEL.typ.nunk _v2__divssnidentitycountnew_;
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
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_S_S_N_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC343096(__ST339325_Layout __EE343090, __ST338363_Layout __EE341418) := __EEQP(__EE343090.UID,__EE341418.UID);
  __ST339526_Layout __JT343096(__ST339325_Layout __l, __ST338363_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE343132 := JOIN(__EE343090,__EE341418,__JC343096(LEFT,RIGHT),__JT343096(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE342542 := __EE337015;
  SHARED __ST338212_Layout := RECORD
    KEL.typ.nint Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE342555 := PROJECT(__EE342542,TRANSFORM(__ST338212_Layout,SELF.Exp1_ := __CN(LEFT.Cl_Identity_Count_),SELF := LEFT));
  SHARED __EE342558 := KEL.Routines.KELbucketTable(__EE342555,'',Exp1_,TRUE,10,D_E_C_I_L_E___Cl_Identity_Count_,0,'',0,'',FALSE);
  SHARED __ST338200_Layout := RECORD
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint D_E_C_I_L_E___Cl_Identity_Count_;
  END;
  SHARED __EE342573 := PROJECT(__EE342558,TRANSFORM(__ST338200_Layout,SELF.Cl_Identity_Count_ := __T(LEFT.Exp1_),SELF := LEFT));
  SHARED __ST339726_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Social_Security_Number.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nunk Ssn_;
    KEL.typ.nint Otto_S_S_N_Id_;
    KEL.typ.nstr Ssn_Formatted_;
    KEL.typ.nunk _v2__divssnidentitycountnew_;
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
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_S_S_N_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__2_;
    KEL.typ.int Cl_Identity_Count__1_ := 0;
    KEL.typ.nint D_E_C_I_L_E___Cl_Identity_Count_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC343138(__ST339526_Layout __EE343132, __ST338200_Layout __EE342573) := __EE343132.Cl_Identity_Count_ = __EE342573.Cl_Identity_Count_;
  __ST339726_Layout __JT343138(__ST339526_Layout __l, __ST338200_Layout __r) := TRANSFORM
    SELF.Cl_Identity_Count__1_ := __r.Cl_Identity_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE343176 := JOIN(__EE343132,__EE342573,__JC343138(LEFT,RIGHT),__JT343138(LEFT,RIGHT),LEFT OUTER,LOOKUP);
  SHARED __EE342539 := __EE337015;
  SHARED __ST338091_Layout := RECORD
    KEL.typ.nint Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE342629 := PROJECT(__EE342539,TRANSFORM(__ST338091_Layout,SELF.Exp1_ := __CN(LEFT.Cl_Event_Count_),SELF := LEFT));
  SHARED __EE342632 := KEL.Routines.KELbucketTable(__EE342629,'',Exp1_,TRUE,100,P_E_R_C_E_N_T_I_L_E___Cl_Event_Count_,0,'',0,'',FALSE);
  SHARED __ST338079_Layout := RECORD
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Event_Count_;
  END;
  SHARED __EE342647 := PROJECT(__EE342632,TRANSFORM(__ST338079_Layout,SELF.Cl_Event_Count_ := __T(LEFT.Exp1_),SELF := LEFT));
  SHARED __ST339925_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Social_Security_Number.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nunk Ssn_;
    KEL.typ.nint Otto_S_S_N_Id_;
    KEL.typ.nstr Ssn_Formatted_;
    KEL.typ.nunk _v2__divssnidentitycountnew_;
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
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_S_S_N_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__2_;
    KEL.typ.int Cl_Identity_Count__1_ := 0;
    KEL.typ.nint D_E_C_I_L_E___Cl_Identity_Count_;
    KEL.typ.int Cl_Event_Count__1_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Event_Count_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC343182(__ST339726_Layout __EE343176, __ST338079_Layout __EE342647) := __EE343176.Cl_Event_Count_ = __EE342647.Cl_Event_Count_;
  __ST339925_Layout __JT343182(__ST339726_Layout __l, __ST338079_Layout __r) := TRANSFORM
    SELF.Cl_Event_Count__1_ := __r.Cl_Event_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE343222 := JOIN(DISTRIBUTE(__EE343176),__EE342647,__JC343182(LEFT,RIGHT),__JT343182(LEFT,RIGHT),LEFT OUTER,LOOKUP);
  SHARED __EE342536 := __EE337015;
  SHARED __ST337972_Layout := RECORD
    KEL.typ.nint Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE342707 := PROJECT(__EE342536,TRANSFORM(__ST337972_Layout,SELF.Exp1_ := __CN(LEFT.Cl_Active7_Identity_Count_),SELF := LEFT));
  SHARED __EE342710 := KEL.Routines.KELbucketTable(__EE342707,'',Exp1_,TRUE,100,P_E_R_C_E_N_T_I_L_E___Cl_Active7_Identity_Count_,0,'',0,'',FALSE);
  SHARED __ST337960_Layout := RECORD
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Active7_Identity_Count_;
  END;
  SHARED __EE342725 := PROJECT(__EE342710,TRANSFORM(__ST337960_Layout,SELF.Cl_Active7_Identity_Count_ := __T(LEFT.Exp1_),SELF := LEFT));
  SHARED __ST340123_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Social_Security_Number.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nunk Ssn_;
    KEL.typ.nint Otto_S_S_N_Id_;
    KEL.typ.nstr Ssn_Formatted_;
    KEL.typ.nunk _v2__divssnidentitycountnew_;
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
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_S_S_N_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__2_;
    KEL.typ.int Cl_Identity_Count__1_ := 0;
    KEL.typ.nint D_E_C_I_L_E___Cl_Identity_Count_;
    KEL.typ.int Cl_Event_Count__1_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Event_Count_;
    KEL.typ.int Cl_Active7_Identity_Count__1_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Active7_Identity_Count_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC343228(__ST339925_Layout __EE343222, __ST337960_Layout __EE342725) := __EE343222.Cl_Active7_Identity_Count_ = __EE342725.Cl_Active7_Identity_Count_;
  __ST340123_Layout __JT343228(__ST339925_Layout __l, __ST337960_Layout __r) := TRANSFORM
    SELF.Cl_Active7_Identity_Count__1_ := __r.Cl_Active7_Identity_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE343270 := JOIN(DISTRIBUTE(__EE343222),__EE342725,__JC343228(LEFT,RIGHT),__JT343228(LEFT,RIGHT),LEFT OUTER,LOOKUP);
  SHARED __EE342533 := __EE337015;
  SHARED __ST337820_Layout := RECORD
    KEL.typ.nint Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE342787 := PROJECT(__EE342533,TRANSFORM(__ST337820_Layout,SELF.Exp1_ := __CN(LEFT.Cl_Active30_Identity_Count_),SELF := LEFT));
  SHARED __EE342790 := KEL.Routines.KELbucketTable(__EE342787,'',Exp1_,TRUE,100,P_E_R_C_E_N_T_I_L_E___Cl_Active30_Identity_Count_,0,'',0,'',FALSE);
  SHARED __ST337808_Layout := RECORD
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Active30_Identity_Count_;
  END;
  SHARED __EE342805 := PROJECT(__EE342790,TRANSFORM(__ST337808_Layout,SELF.Cl_Active30_Identity_Count_ := __T(LEFT.Exp1_),SELF := LEFT));
  SHARED __ST340320_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Social_Security_Number.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nunk Ssn_;
    KEL.typ.nint Otto_S_S_N_Id_;
    KEL.typ.nstr Ssn_Formatted_;
    KEL.typ.nunk _v2__divssnidentitycountnew_;
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
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_S_S_N_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__2_;
    KEL.typ.int Cl_Identity_Count__1_ := 0;
    KEL.typ.nint D_E_C_I_L_E___Cl_Identity_Count_;
    KEL.typ.int Cl_Event_Count__1_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Event_Count_;
    KEL.typ.int Cl_Active7_Identity_Count__1_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Active7_Identity_Count_;
    KEL.typ.int Cl_Active30_Identity_Count__1_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Active30_Identity_Count_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC343276(__ST340123_Layout __EE343270, __ST337808_Layout __EE342805) := __EE343270.Cl_Active30_Identity_Count_ = __EE342805.Cl_Active30_Identity_Count_;
  __ST340320_Layout __JT343276(__ST340123_Layout __l, __ST337808_Layout __r) := TRANSFORM
    SELF.Cl_Active30_Identity_Count__1_ := __r.Cl_Active30_Identity_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE343320 := JOIN(__EE343270,__EE342805,__JC343276(LEFT,RIGHT),__JT343276(LEFT,RIGHT),LEFT OUTER,LOOKUP);
  EXPORT __ST20310_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Social_Security_Number.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nunk Ssn_;
    KEL.typ.nint Otto_S_S_N_Id_;
    KEL.typ.nstr Ssn_Formatted_;
    KEL.typ.nunk _v2__divssnidentitycountnew_;
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
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int Vl_Event30_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event7_All_Count_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST20310_Layout __ND343325__Project(__ST340320_Layout __PP343321) := TRANSFORM
    SELF.Cl_Active30_Identity_Count_Percentile_ := __PP343321.P_E_R_C_E_N_T_I_L_E___Cl_Active30_Identity_Count_;
    SELF.Cl_Active7_Identity_Count_Percentile_ := __PP343321.P_E_R_C_E_N_T_I_L_E___Cl_Active7_Identity_Count_;
    SELF.Cl_Event_Count_Percentile_ := __PP343321.P_E_R_C_E_N_T_I_L_E___Cl_Event_Count_;
    SELF.Cl_Identity_Count_Percentile_ := __PP343321.D_E_C_I_L_E___Cl_Identity_Count_;
    SELF.Identity_Count_ := __PP343321.C_O_U_N_T___Person_S_S_N_;
    SELF.Vl_Event30_All_Day_Count_ := __PP343321.C_O_U_N_T___Exp1_;
    SELF.Vl_Event30_Count_ := __PP343321.C_O_U_N_T___Exp1__1_;
    SELF.Vl_Event7_All_Count_ := __PP343321.C_O_U_N_T___Exp1__2_;
    SELF.Vl_Event7_Count_ := __PP343321.C_O_U_N_T___Exp1__3_;
    SELF := __PP343321;
  END;
  EXPORT __ENH_Social_Security_Number_1 := PROJECT(__EE343320,__ND343325__Project(LEFT));
END;
