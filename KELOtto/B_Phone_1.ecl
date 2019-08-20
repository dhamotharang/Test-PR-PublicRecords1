﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Event_2,B_Phone_2,E_Address,E_Customer,E_Event,E_Person,E_Phone,E_Phone_Event FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Phone_1 := MODULE
  SHARED VIRTUAL TYPEOF(B_Event_2.__ENH_Event_2) __ENH_Event_2 := B_Event_2.__ENH_Event_2;
  SHARED VIRTUAL TYPEOF(B_Phone_2.__ENH_Phone_2) __ENH_Phone_2 := B_Phone_2.__ENH_Phone_2;
  SHARED VIRTUAL TYPEOF(E_Phone_Event.__Result) __E_Phone_Event := E_Phone_Event.__Result;
  SHARED __EE330200 := __ENH_Phone_2;
  SHARED __EE333458 := __ENH_Event_2;
  SHARED __EE333456 := __E_Phone_Event;
  SHARED __EE333669 := __EE333456(__NN(__EE333456.Phone_Number_) AND __NN(__EE333456.Transaction_));
  SHARED __ST331791_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Event.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nint Record_Id_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ndataset(E_Event.Event_Types_Layout) Event_Types_;
    KEL.typ.nstr Otto_Address_Id_;
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
    KEL.typ.int Id_Nas9_Flag_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Ip_High_Risk_City_ := 0;
    KEL.typ.int Ip_Hosted_ := 0;
    KEL.typ.int Ip_Not_Us_ := 0;
    KEL.typ.int Ip_Tor_ := 0;
    KEL.typ.int Ip_Vpn_ := 0;
    KEL.typ.int Kr_High_Risk_Identity_Flag_ := 0;
    KEL.typ.int Kr_Identity_Risk_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.nkdate Event_Date__1_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC333687(B_Event_2.__ST20683_Layout __EE333458, E_Phone_Event.Layout __EE333669) := __EEQP(__EE333669.Transaction_,__EE333458.UID);
  __ST331791_Layout __JT333687(B_Event_2.__ST20683_Layout __l, E_Phone_Event.Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF.Event_Date__1_ := __r.Event_Date_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE333688 := JOIN(__EE333669,__EE333458,__JC333687(RIGHT,LEFT),__JT333687(RIGHT,LEFT),INNER,HASH);
  SHARED __ST331474_Layout := RECORD
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Age_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST331474_Layout __ND333861__Project(__ST331791_Layout __PP333689) := TRANSFORM
    SELF.UID := __PP333689.Phone_Number_;
    SELF._r_Customer_ := __PP333689._r_Customer__1_;
    SELF.Event_Date_ := __PP333689.Event_Date__1_;
    SELF.U_I_D__1_ := __PP333689.UID;
    SELF := __PP333689;
  END;
  SHARED __EE333894 := PROJECT(__EE333688,__ND333861__Project(LEFT));
  SHARED __ST331519_Layout := RECORD
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.nbool Exp1_;
    KEL.typ.nbool Exp2_;
    KEL.typ.nbool Exp3_;
    KEL.typ.nbool Exp4_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST331519_Layout __ND334551__Project(__ST331474_Layout __PP333895) := TRANSFORM
    SELF.Exp1_ := __OP2(__PP333895.Age_,<,__CN(31));
    SELF.Exp2_ := __AND(__OP2(__PP333895.Age_,<,__CN(31)),__CN(__PP333895.In_Customer_Population_ = 1));
    SELF.Exp3_ := __OP2(__PP333895.Age_,<,__CN(8));
    SELF.Exp4_ := __AND(__OP2(__PP333895.Age_,<,__CN(8)),__CN(__PP333895.In_Customer_Population_ = 1));
    SELF := __PP333895;
  END;
  SHARED __EE334568 := PROJECT(__EE333894,__ND334551__Project(LEFT));
  SHARED __ST331549_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE334603 := PROJECT(__CLEANANDDO(__EE334568,TABLE(__EE334568,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP,__T(__EE334568.Exp1_)),KEL.typ.int C_O_U_N_T___Exp1__1_ := COUNT(GROUP,__T(__EE334568.Exp2_)),KEL.typ.int C_O_U_N_T___Exp1__2_ := COUNT(GROUP,__T(__EE334568.Exp3_)),KEL.typ.int C_O_U_N_T___Exp1__3_ := COUNT(GROUP,__T(__EE334568.Exp4_)),UID},UID,MERGE)),__ST331549_Layout);
  SHARED __ST332019_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Phone.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC334609(B_Phone_2.__ST21196_Layout __EE330200, __ST331549_Layout __EE334603) := __EEQP(__EE330200.UID,__EE334603.UID);
  __ST332019_Layout __JT334609(B_Phone_2.__ST21196_Layout __l, __ST331549_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE334630 := JOIN(__EE330200,__EE334603,__JC334609(LEFT,RIGHT),__JT334609(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE334211 := __EE330200;
  SHARED __ST331197_Layout := RECORD
    KEL.typ.nint Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE334224 := PROJECT(__EE334211,TRANSFORM(__ST331197_Layout,SELF.Exp1_ := __CN(LEFT.Cl_Identity_Count_),SELF := LEFT));
  SHARED __EE334227 := KEL.Routines.KELbucketTable(__EE334224,'',Exp1_,TRUE,10,D_E_C_I_L_E___Cl_Identity_Count_,0,'',0,'',FALSE);
  SHARED __ST331185_Layout := RECORD
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint D_E_C_I_L_E___Cl_Identity_Count_;
  END;
  SHARED __EE334242 := PROJECT(__EE334227,TRANSFORM(__ST331185_Layout,SELF.Cl_Identity_Count_ := __T(LEFT.Exp1_),SELF := LEFT));
  SHARED __ST332148_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Phone.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) U_I_D__1_;
    KEL.typ.int Cl_Identity_Count__1_ := 0;
    KEL.typ.nint D_E_C_I_L_E___Cl_Identity_Count_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC334636(__ST332019_Layout __EE334630, __ST331185_Layout __EE334242) := __EE334630.Cl_Identity_Count_ = __EE334242.Cl_Identity_Count_;
  __ST332148_Layout __JT334636(__ST332019_Layout __l, __ST331185_Layout __r) := TRANSFORM
    SELF.Cl_Identity_Count__1_ := __r.Cl_Identity_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE334659 := JOIN(__EE334630,__EE334242,__JC334636(LEFT,RIGHT),__JT334636(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE334208 := __EE330200;
  SHARED __ST331090_Layout := RECORD
    KEL.typ.nint Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE334283 := PROJECT(__EE334208,TRANSFORM(__ST331090_Layout,SELF.Exp1_ := __CN(LEFT.Cl_Event_Count_),SELF := LEFT));
  SHARED __EE334286 := KEL.Routines.KELbucketTable(__EE334283,'',Exp1_,TRUE,100,P_E_R_C_E_N_T_I_L_E___Cl_Event_Count_,0,'',0,'',FALSE);
  SHARED __ST331078_Layout := RECORD
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Event_Count_;
  END;
  SHARED __EE334301 := PROJECT(__EE334286,TRANSFORM(__ST331078_Layout,SELF.Cl_Event_Count_ := __T(LEFT.Exp1_),SELF := LEFT));
  SHARED __ST332276_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Phone.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) U_I_D__1_;
    KEL.typ.int Cl_Identity_Count__1_ := 0;
    KEL.typ.nint D_E_C_I_L_E___Cl_Identity_Count_;
    KEL.typ.int Cl_Event_Count__1_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Event_Count_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC334665(__ST332148_Layout __EE334659, __ST331078_Layout __EE334301) := __EE334659.Cl_Event_Count_ = __EE334301.Cl_Event_Count_;
  __ST332276_Layout __JT334665(__ST332148_Layout __l, __ST331078_Layout __r) := TRANSFORM
    SELF.Cl_Event_Count__1_ := __r.Cl_Event_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE334690 := JOIN(__EE334659,__EE334301,__JC334665(LEFT,RIGHT),__JT334665(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE334205 := __EE330200;
  SHARED __ST330985_Layout := RECORD
    KEL.typ.nint Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE334346 := PROJECT(__EE334205,TRANSFORM(__ST330985_Layout,SELF.Exp1_ := __CN(LEFT.Cl_Active7_Identity_Count_),SELF := LEFT));
  SHARED __EE334349 := KEL.Routines.KELbucketTable(__EE334346,'',Exp1_,TRUE,100,P_E_R_C_E_N_T_I_L_E___Cl_Active7_Identity_Count_,0,'',0,'',FALSE);
  SHARED __ST330973_Layout := RECORD
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Active7_Identity_Count_;
  END;
  SHARED __EE334364 := PROJECT(__EE334349,TRANSFORM(__ST330973_Layout,SELF.Cl_Active7_Identity_Count_ := __T(LEFT.Exp1_),SELF := LEFT));
  SHARED __ST332403_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Phone.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) U_I_D__1_;
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
  __JC334696(__ST332276_Layout __EE334690, __ST330973_Layout __EE334364) := __EE334690.Cl_Active7_Identity_Count_ = __EE334364.Cl_Active7_Identity_Count_;
  __ST332403_Layout __JT334696(__ST332276_Layout __l, __ST330973_Layout __r) := TRANSFORM
    SELF.Cl_Active7_Identity_Count__1_ := __r.Cl_Active7_Identity_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE334723 := JOIN(__EE334690,__EE334364,__JC334696(LEFT,RIGHT),__JT334696(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE334202 := __EE330200;
  SHARED __ST330861_Layout := RECORD
    KEL.typ.nint Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE334411 := PROJECT(__EE334202,TRANSFORM(__ST330861_Layout,SELF.Exp1_ := __CN(LEFT.Cl_Active30_Identity_Count_),SELF := LEFT));
  SHARED __EE334414 := KEL.Routines.KELbucketTable(__EE334411,'',Exp1_,TRUE,100,P_E_R_C_E_N_T_I_L_E___Cl_Active30_Identity_Count_,0,'',0,'',FALSE);
  SHARED __ST330849_Layout := RECORD
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Active30_Identity_Count_;
  END;
  SHARED __EE334429 := PROJECT(__EE334414,TRANSFORM(__ST330849_Layout,SELF.Cl_Active30_Identity_Count_ := __T(LEFT.Exp1_),SELF := LEFT));
  SHARED __ST332529_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Phone.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) U_I_D__1_;
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
  __JC334729(__ST332403_Layout __EE334723, __ST330849_Layout __EE334429) := __EE334723.Cl_Active30_Identity_Count_ = __EE334429.Cl_Active30_Identity_Count_;
  __ST332529_Layout __JT334729(__ST332403_Layout __l, __ST330849_Layout __r) := TRANSFORM
    SELF.Cl_Active30_Identity_Count__1_ := __r.Cl_Active30_Identity_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE334758 := JOIN(__EE334723,__EE334429,__JC334729(LEFT,RIGHT),__JT334729(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST20264_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Phone.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.int Vl_Event30_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event7_All_Count_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST20264_Layout __ND334763__Project(__ST332529_Layout __PP334759) := TRANSFORM
    SELF.Cl_Active30_Identity_Count_Percentile_ := __PP334759.P_E_R_C_E_N_T_I_L_E___Cl_Active30_Identity_Count_;
    SELF.Cl_Active7_Identity_Count_Percentile_ := __PP334759.P_E_R_C_E_N_T_I_L_E___Cl_Active7_Identity_Count_;
    SELF.Cl_Event_Count_Percentile_ := __PP334759.P_E_R_C_E_N_T_I_L_E___Cl_Event_Count_;
    SELF.Cl_Identity_Count_Percentile_ := __PP334759.D_E_C_I_L_E___Cl_Identity_Count_;
    SELF.Vl_Event30_All_Day_Count_ := __PP334759.C_O_U_N_T___Exp1_;
    SELF.Vl_Event30_Count_ := __PP334759.C_O_U_N_T___Exp1__1_;
    SELF.Vl_Event7_All_Count_ := __PP334759.C_O_U_N_T___Exp1__2_;
    SELF.Vl_Event7_Count_ := __PP334759.C_O_U_N_T___Exp1__3_;
    SELF := __PP334759;
  END;
  EXPORT __ENH_Phone_1 := PROJECT(__EE334758,__ND334763__Project(LEFT));
END;
