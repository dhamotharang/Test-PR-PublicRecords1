﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Bank_Account_2,B_Event_2,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank_Account_1 := MODULE
  SHARED VIRTUAL TYPEOF(B_Bank_Account_2.__ENH_Bank_Account_2) __ENH_Bank_Account_2 := B_Bank_Account_2.__ENH_Bank_Account_2;
  SHARED VIRTUAL TYPEOF(B_Event_2.__ENH_Event_2) __ENH_Event_2 := B_Event_2.__ENH_Event_2;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE162853 := __ENH_Bank_Account_2;
  SHARED __EE166511 := __ENH_Event_2;
  SHARED __EE166509 := __E_Person_Event;
  SHARED __EE166754 := __EE166509(__NN(__EE166509.Account_) AND __NN(__EE166509.Transaction_));
  SHARED __ST164722_Layout := RECORD
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
    KEL.typ.ntyp(E_Person.Typ) Subject__1_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) Social_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.ntyp(E_Address.Typ) Location__1_;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) Ip_;
    KEL.typ.ntyp(E_Bank.Typ) Routing_Bank_;
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.ntyp(E_Drivers_License.Typ) Licence_;
    KEL.typ.nkdate Event_Date__1_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC166772(B_Event_2.__ST16599_Layout __EE166511, E_Person_Event.Layout __EE166754) := __EEQP(__EE166754.Transaction_,__EE166511.UID);
  __ST164722_Layout __JT166772(B_Event_2.__ST16599_Layout __l, E_Person_Event.Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF.Subject__1_ := __r.Subject_;
    SELF.Location__1_ := __r.Location_;
    SELF.Event_Date__1_ := __r.Event_Date_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE166773 := JOIN(__EE166754,__EE166511,__JC166772(RIGHT,LEFT),__JT166772(RIGHT,LEFT),INNER,HASH);
  SHARED __ST164355_Layout := RECORD
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) Social_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) Ip_;
    KEL.typ.ntyp(E_Bank.Typ) Routing_Bank_;
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.ntyp(E_Drivers_License.Typ) Licence_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Age_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST164355_Layout __ND166957__Project(__ST164722_Layout __PP166774) := TRANSFORM
    SELF.UID := __PP166774.Account_;
    SELF._r_Customer_ := __PP166774._r_Customer__1_;
    SELF.Subject_ := __PP166774.Subject__1_;
    SELF.Location_ := __PP166774.Location__1_;
    SELF.Event_Date_ := __PP166774.Event_Date__1_;
    SELF.U_I_D__1_ := __PP166774.UID;
    SELF := __PP166774;
  END;
  SHARED __EE167022 := PROJECT(__EE166773,__ND166957__Project(LEFT));
  SHARED __ST164416_Layout := RECORD
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.nbool Exp1_;
    KEL.typ.nbool Exp2_;
    KEL.typ.nbool Exp3_;
    KEL.typ.nbool Exp4_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST164416_Layout __ND167696__Project(__ST164355_Layout __PP167023) := TRANSFORM
    SELF.Exp1_ := __OP2(__PP167023.Age_,<,__CN(31));
    SELF.Exp2_ := __AND(__OP2(__PP167023.Age_,<,__CN(31)),__CN(__PP167023.In_Customer_Population_ = 1));
    SELF.Exp3_ := __OP2(__PP167023.Age_,<,__CN(8));
    SELF.Exp4_ := __AND(__OP2(__PP167023.Age_,<,__CN(8)),__CN(__PP167023.In_Customer_Population_ = 1));
    SELF := __PP167023;
  END;
  SHARED __EE167713 := PROJECT(__EE167022,__ND167696__Project(LEFT));
  SHARED __ST164446_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE167748 := PROJECT(__CLEANANDDO(__EE167713,TABLE(__EE167713,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP,__T(__EE167713.Exp1_)),KEL.typ.int C_O_U_N_T___Exp1__1_ := COUNT(GROUP,__T(__EE167713.Exp2_)),KEL.typ.int C_O_U_N_T___Exp1__2_ := COUNT(GROUP,__T(__EE167713.Exp3_)),KEL.typ.int C_O_U_N_T___Exp1__3_ := COUNT(GROUP,__T(__EE167713.Exp4_)),UID},UID,MERGE)),__ST164446_Layout);
  SHARED __ST164993_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Bank_Account.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Bank.Typ) _r_Bank_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nint Otto_Bank_Account_Id_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int High_Risk_Routing_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC167754(B_Bank_Account_2.__ST16380_Layout __EE162853, __ST164446_Layout __EE167748) := __EEQP(__EE162853.UID,__EE167748.UID);
  __ST164993_Layout __JT167754(B_Bank_Account_2.__ST16380_Layout __l, __ST164446_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE167776 := JOIN(__EE162853,__EE167748,__JC167754(LEFT,RIGHT),__JT167754(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE167348 := __EE162853;
  SHARED __ST164021_Layout := RECORD
    KEL.typ.nint Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE167361 := PROJECT(__EE167348,TRANSFORM(__ST164021_Layout,SELF.Exp1_ := __CN(LEFT.Cl_Identity_Count_),SELF := LEFT));
  SHARED __EE167364 := KEL.Routines.KELbucketTable(__EE167361,'',Exp1_,TRUE,10,D_E_C_I_L_E___Cl_Identity_Count_,0,'',0,'',FALSE);
  SHARED __ST164009_Layout := RECORD
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint D_E_C_I_L_E___Cl_Identity_Count_;
  END;
  SHARED __EE167379 := PROJECT(__EE167364,TRANSFORM(__ST164009_Layout,SELF.Cl_Identity_Count_ := __T(LEFT.Exp1_),SELF := LEFT));
  SHARED __ST165127_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Bank_Account.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Bank.Typ) _r_Bank_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nint Otto_Bank_Account_Id_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int High_Risk_Routing_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) U_I_D__1_;
    KEL.typ.int Cl_Identity_Count__1_ := 0;
    KEL.typ.nint D_E_C_I_L_E___Cl_Identity_Count_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC167782(__ST164993_Layout __EE167776, __ST164009_Layout __EE167379) := __EE167776.Cl_Identity_Count_ = __EE167379.Cl_Identity_Count_;
  __ST165127_Layout __JT167782(__ST164993_Layout __l, __ST164009_Layout __r) := TRANSFORM
    SELF.Cl_Identity_Count__1_ := __r.Cl_Identity_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE167806 := JOIN(__EE167776,__EE167379,__JC167782(LEFT,RIGHT),__JT167782(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE167345 := __EE162853;
  SHARED __ST163913_Layout := RECORD
    KEL.typ.nint Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE167421 := PROJECT(__EE167345,TRANSFORM(__ST163913_Layout,SELF.Exp1_ := __CN(LEFT.Cl_Event_Count_),SELF := LEFT));
  SHARED __EE167424 := KEL.Routines.KELbucketTable(__EE167421,'',Exp1_,TRUE,100,P_E_R_C_E_N_T_I_L_E___Cl_Event_Count_,0,'',0,'',FALSE);
  SHARED __ST163901_Layout := RECORD
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Event_Count_;
  END;
  SHARED __EE167439 := PROJECT(__EE167424,TRANSFORM(__ST163901_Layout,SELF.Cl_Event_Count_ := __T(LEFT.Exp1_),SELF := LEFT));
  SHARED __ST165260_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Bank_Account.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Bank.Typ) _r_Bank_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nint Otto_Bank_Account_Id_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int High_Risk_Routing_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) U_I_D__1_;
    KEL.typ.int Cl_Identity_Count__1_ := 0;
    KEL.typ.nint D_E_C_I_L_E___Cl_Identity_Count_;
    KEL.typ.int Cl_Event_Count__1_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Event_Count_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC167812(__ST165127_Layout __EE167806, __ST163901_Layout __EE167439) := __EE167806.Cl_Event_Count_ = __EE167439.Cl_Event_Count_;
  __ST165260_Layout __JT167812(__ST165127_Layout __l, __ST163901_Layout __r) := TRANSFORM
    SELF.Cl_Event_Count__1_ := __r.Cl_Event_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE167838 := JOIN(__EE167806,__EE167439,__JC167812(LEFT,RIGHT),__JT167812(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE167342 := __EE162853;
  SHARED __ST163807_Layout := RECORD
    KEL.typ.nint Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE167485 := PROJECT(__EE167342,TRANSFORM(__ST163807_Layout,SELF.Exp1_ := __CN(LEFT.Cl_Active7_Identity_Count_),SELF := LEFT));
  SHARED __EE167488 := KEL.Routines.KELbucketTable(__EE167485,'',Exp1_,TRUE,100,P_E_R_C_E_N_T_I_L_E___Cl_Active7_Identity_Count_,0,'',0,'',FALSE);
  SHARED __ST163795_Layout := RECORD
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Active7_Identity_Count_;
  END;
  SHARED __EE167503 := PROJECT(__EE167488,TRANSFORM(__ST163795_Layout,SELF.Cl_Active7_Identity_Count_ := __T(LEFT.Exp1_),SELF := LEFT));
  SHARED __ST165392_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Bank_Account.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Bank.Typ) _r_Bank_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nint Otto_Bank_Account_Id_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int High_Risk_Routing_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) U_I_D__1_;
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
  __JC167844(__ST165260_Layout __EE167838, __ST163795_Layout __EE167503) := __EE167838.Cl_Active7_Identity_Count_ = __EE167503.Cl_Active7_Identity_Count_;
  __ST165392_Layout __JT167844(__ST165260_Layout __l, __ST163795_Layout __r) := TRANSFORM
    SELF.Cl_Active7_Identity_Count__1_ := __r.Cl_Active7_Identity_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE167872 := JOIN(__EE167838,__EE167503,__JC167844(LEFT,RIGHT),__JT167844(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE167339 := __EE162853;
  SHARED __ST163681_Layout := RECORD
    KEL.typ.nint Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE167551 := PROJECT(__EE167339,TRANSFORM(__ST163681_Layout,SELF.Exp1_ := __CN(LEFT.Cl_Active30_Identity_Count_),SELF := LEFT));
  SHARED __EE167554 := KEL.Routines.KELbucketTable(__EE167551,'',Exp1_,TRUE,100,P_E_R_C_E_N_T_I_L_E___Cl_Active30_Identity_Count_,0,'',0,'',FALSE);
  SHARED __ST163669_Layout := RECORD
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Active30_Identity_Count_;
  END;
  SHARED __EE167569 := PROJECT(__EE167554,TRANSFORM(__ST163669_Layout,SELF.Cl_Active30_Identity_Count_ := __T(LEFT.Exp1_),SELF := LEFT));
  SHARED __ST165523_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Bank_Account.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Bank.Typ) _r_Bank_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nint Otto_Bank_Account_Id_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int High_Risk_Routing_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) U_I_D__1_;
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
  __JC167878(__ST165392_Layout __EE167872, __ST163669_Layout __EE167569) := __EE167872.Cl_Active30_Identity_Count_ = __EE167569.Cl_Active30_Identity_Count_;
  __ST165523_Layout __JT167878(__ST165392_Layout __l, __ST163669_Layout __r) := TRANSFORM
    SELF.Cl_Active30_Identity_Count__1_ := __r.Cl_Active30_Identity_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE167908 := JOIN(__EE167872,__EE167569,__JC167878(LEFT,RIGHT),__JT167878(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST15322_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Bank_Account.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Bank.Typ) _r_Bank_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nint Otto_Bank_Account_Id_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.int High_Risk_Routing_ := 0;
    KEL.typ.int Vl_Event30_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event7_All_Count_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST15322_Layout __ND167913__Project(__ST165523_Layout __PP167909) := TRANSFORM
    SELF.Cl_Active30_Identity_Count_Percentile_ := __PP167909.P_E_R_C_E_N_T_I_L_E___Cl_Active30_Identity_Count_;
    SELF.Cl_Active7_Identity_Count_Percentile_ := __PP167909.P_E_R_C_E_N_T_I_L_E___Cl_Active7_Identity_Count_;
    SELF.Cl_Event_Count_Percentile_ := __PP167909.P_E_R_C_E_N_T_I_L_E___Cl_Event_Count_;
    SELF.Cl_Identity_Count_Percentile_ := __PP167909.D_E_C_I_L_E___Cl_Identity_Count_;
    SELF.Vl_Event30_All_Day_Count_ := __PP167909.C_O_U_N_T___Exp1_;
    SELF.Vl_Event30_Count_ := __PP167909.C_O_U_N_T___Exp1__1_;
    SELF.Vl_Event7_All_Count_ := __PP167909.C_O_U_N_T___Exp1__2_;
    SELF.Vl_Event7_Count_ := __PP167909.C_O_U_N_T___Exp1__3_;
    SELF := __PP167909;
  END;
  EXPORT __ENH_Bank_Account_1 := PROJECT(__EE167908,__ND167913__Project(LEFT));
END;
