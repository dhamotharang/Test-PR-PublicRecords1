﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer_1,B_Event_1,B_Social_Security_Number_1,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Social_Security_Number := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_1.__ENH_Customer_1) __ENH_Customer_1 := B_Customer_1.__ENH_Customer_1;
  SHARED VIRTUAL TYPEOF(B_Event_1.__ENH_Event_1) __ENH_Event_1 := B_Event_1.__ENH_Event_1;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Social_Security_Number_1.__ENH_Social_Security_Number_1) __ENH_Social_Security_Number_1 := B_Social_Security_Number_1.__ENH_Social_Security_Number_1;
  SHARED __EE382440 := __ENH_Social_Security_Number_1;
  SHARED __EE390084 := __ENH_Event_1;
  SHARED __EE390023 := __E_Person_Event;
  SHARED __EE391359 := __EE390023;
  SHARED __EE391372 := __EE391359(__NN(__EE391359.Social_) AND __NN(__EE391359.Transaction_));
  SHARED __ST386406_Layout := RECORD
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
    KEL.typ.nint Age_;
    KEL.typ.int Deceased_Prior_To_Event_ := 0;
    KEL.typ.nint Deceased_To_Event_Year_Diff_;
    KEL.typ.nbool Demo_Customer_;
    KEL.typ.nint Event_Type_Count_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Kr_High_Risk_Address_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Identity_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Address_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Identity_Flag_ := 0;
    KEL.typ.nfloat Latitude_;
    KEL.typ.nfloat Longitude_;
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
  __JC391378(B_Event_1.__ST11960_Layout __EE390084, E_Person_Event.Layout __EE391372) := __EEQP(__EE391372.Transaction_,__EE390084.UID);
  __ST386406_Layout __JT391378(B_Event_1.__ST11960_Layout __l, E_Person_Event.Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF.Subject__1_ := __r.Subject_;
    SELF.Location__1_ := __r.Location_;
    SELF.Event_Date__1_ := __r.Event_Date_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE391379 := JOIN(__EE391372,__EE390084,__JC391378(RIGHT,LEFT),__JT391378(RIGHT,LEFT),INNER,HASH);
  SHARED __ST385804_Layout := RECORD
    KEL.typ.ntyp(E_Social_Security_Number.Typ) UID;
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
    KEL.typ.int Kr_High_Risk_Identity_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Identity_Flag_ := 0;
    KEL.typ.nint Age_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST385804_Layout __ND391489__Project(__ST386406_Layout __PP391380) := TRANSFORM
    SELF.UID := __PP391380.Social_;
    SELF._r_Customer_ := __PP391380._r_Customer__1_;
    SELF.Subject_ := __PP391380.Subject__1_;
    SELF.Location_ := __PP391380.Location__1_;
    SELF.Event_Date_ := __PP391380.Event_Date__1_;
    SELF.U_I_D__1_ := __PP391380.UID;
    SELF := __PP391380;
  END;
  SHARED __EE391562 := PROJECT(__EE391379,__ND391489__Project(LEFT));
  SHARED __ST385875_Layout := RECORD
    KEL.typ.ntyp(E_Social_Security_Number.Typ) UID;
    KEL.typ.bool Exp1_ := FALSE;
    KEL.typ.bool Exp2_ := FALSE;
    KEL.typ.nbool Exp3_;
    KEL.typ.nbool Exp4_;
    KEL.typ.nbool Exp5_;
    KEL.typ.nbool Exp6_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST385875_Layout __ND392322__Project(__ST385804_Layout __PP391563) := TRANSFORM
    SELF.Exp1_ := __PP391563.Kr_High_Risk_Identity_Flag_ = 1;
    SELF.Exp2_ := __PP391563.Kr_Medium_Risk_Identity_Flag_ = 1;
    SELF.Exp3_ := __OP2(__PP391563.Age_,<,__CN(2));
    SELF.Exp4_ := __AND(__OP2(__PP391563.Age_,<,__CN(2)),__CN(__PP391563.In_Customer_Population_ = 1));
    SELF.Exp5_ := __OP2(__PP391563.Age_,<,__CN(366));
    SELF.Exp6_ := __AND(__OP2(__PP391563.Age_,<,__CN(366)),__CN(__PP391563.In_Customer_Population_ = 1));
    SELF := __PP391563;
  END;
  SHARED __EE392341 := PROJECT(__EE391562,__ND392322__Project(LEFT));
  SHARED __ST385915_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE392386 := PROJECT(__CLEANANDDO(__EE392341,TABLE(__EE392341,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP,__EE392341.Exp1_),KEL.typ.int C_O_U_N_T___Exp1__1_ := COUNT(GROUP,__EE392341.Exp2_),KEL.typ.int C_O_U_N_T___Exp1__2_ := COUNT(GROUP,__T(__EE392341.Exp3_)),KEL.typ.int C_O_U_N_T___Exp1__3_ := COUNT(GROUP,__T(__EE392341.Exp4_)),KEL.typ.int C_O_U_N_T___Exp1__4_ := COUNT(GROUP,__T(__EE392341.Exp5_)),KEL.typ.int C_O_U_N_T___Exp1__5_ := COUNT(GROUP,__T(__EE392341.Exp6_)),UID},UID,MERGE)),__ST385915_Layout);
  SHARED __ST386607_Layout := RECORD
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
    KEL.typ.ndataset(E_Social_Security_Number.Hri_List_Layout) Hri_List_;
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
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC392392(B_Social_Security_Number_1.__ST12358_Layout __EE382440, __ST385915_Layout __EE392386) := __EEQP(__EE382440.UID,__EE392386.UID);
  __ST386607_Layout __JT392392(B_Social_Security_Number_1.__ST12358_Layout __l, __ST385915_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE392440 := JOIN(__EE382440,__EE392386,__JC392392(LEFT,RIGHT),__JT392392(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE390046 := __EE382440;
  SHARED __ST386335_Layout := RECORD
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
    KEL.typ.ndataset(E_Social_Security_Number.Hri_List_Layout) Hri_List_;
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
    KEL.typ.nstr Hri_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __ST386335_Layout __JT390057(B_Social_Security_Number_1.__ST12358_Layout __l, E_Social_Security_Number.Hri_List_Layout __r) := TRANSFORM
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE390058 := NORMALIZE(__EE390046,__T(LEFT.Hri_List_),__JT390057(LEFT,RIGHT));
  SHARED __ST385045_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Hri_;
    KEL.typ.ndataset(E_Social_Security_Number.Hri_List_Layout) Hri_List_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE390080 := PROJECT(__EE390058,__ST385045_Layout);
  SHARED __ST385086_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nbool Exp1_;
    KEL.typ.nbool Exp2_;
    KEL.typ.nbool Exp3_;
    KEL.typ.nbool Exp4_;
    KEL.typ.nbool Exp5_;
    KEL.typ.nbool Exp6_;
    KEL.typ.nbool Exp7_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST385086_Layout __ND392444__Project(__ST385045_Layout __PP389917) := TRANSFORM
    SELF.Exp1_ := __FN2(KEL.Routines.Contains,__PP389917.Hri_,__CN('06'));
    SELF.Exp2_ := __FN2(KEL.Routines.Contains,__PP389917.Hri_,__CN('26'));
    SELF.Exp3_ := __FN2(KEL.Routines.Contains,__PP389917.Hri_,__CN('29'));
    SELF.Exp4_ := __FN2(KEL.Routines.Contains,__PP389917.Hri_,__CN('38'));
    SELF.Exp5_ := __FN2(KEL.Routines.Contains,__PP389917.Hri_,__CN('71'));
    SELF.Exp6_ := __FN2(KEL.Routines.Contains,__PP389917.Hri_,__CN('It'));
    SELF.Exp7_ := __FN2(KEL.Routines.Contains,__PP389917.Hri_,__CN('Mi'));
    SELF := __PP389917;
  END;
  SHARED __EE392466 := PROJECT(__EE390080,__ND392444__Project(LEFT));
  SHARED __ST385131_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Hri_List_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__1_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__2_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__3_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__4_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__5_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__6_ := 0;
    KEL.typ.nuid UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE392519 := PROJECT(__CLEANANDDO(__EE392466,TABLE(__EE392466,{KEL.typ.int C_O_U_N_T___Hri_List_ := COUNT(GROUP,__T(__EE392466.Exp1_)),KEL.typ.int C_O_U_N_T___Hri_List__1_ := COUNT(GROUP,__T(__EE392466.Exp2_)),KEL.typ.int C_O_U_N_T___Hri_List__2_ := COUNT(GROUP,__T(__EE392466.Exp3_)),KEL.typ.int C_O_U_N_T___Hri_List__3_ := COUNT(GROUP,__T(__EE392466.Exp4_)),KEL.typ.int C_O_U_N_T___Hri_List__4_ := COUNT(GROUP,__T(__EE392466.Exp5_)),KEL.typ.int C_O_U_N_T___Hri_List__5_ := COUNT(GROUP,__T(__EE392466.Exp6_)),KEL.typ.int C_O_U_N_T___Hri_List__6_ := COUNT(GROUP,__T(__EE392466.Exp7_)),UID},UID,MERGE)),__ST385131_Layout);
  SHARED __ST386959_Layout := RECORD
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
    KEL.typ.ndataset(E_Social_Security_Number.Hri_List_Layout) Hri_List_;
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
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Hri_List_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__1_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__2_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__3_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__4_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__5_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__6_ := 0;
    KEL.typ.nuid U_I_D__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC392527(__ST386607_Layout __EE392440, __ST385131_Layout __EE392519) := __EEQP(__EE392440.UID,__EE392519.UID);
  __ST386959_Layout __JT392527(__ST386607_Layout __l, __ST385131_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE392583 := JOIN(__EE392440,__EE392519,__JC392527(LEFT,RIGHT),__JT392527(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE390030 := __EE390023(__NN(__EE390023.Social_));
  SHARED __ST384347_Layout := RECORD
    KEL.typ.ntyp(E_Social_Security_Number.Typ) UID;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE390044 := DEDUP(PROJECT(__EE390030,TRANSFORM(__ST384347_Layout,SELF.UID := LEFT.Social_,SELF := LEFT)),ALL);
  SHARED __ST384365_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE389916 := PROJECT(__CLEANANDDO(__EE390044,TABLE(__EE390044,{KEL.typ.int C_O_U_N_T___Person_Event_ := COUNT(GROUP),UID},UID,MERGE)),__ST384365_Layout);
  SHARED __ST387342_Layout := RECORD
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
    KEL.typ.ndataset(E_Social_Security_Number.Hri_List_Layout) Hri_List_;
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
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Hri_List_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__1_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__2_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__3_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__4_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__5_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__6_ := 0;
    KEL.typ.nuid U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__3_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC392589(__ST386959_Layout __EE392583, __ST384365_Layout __EE389916) := __EEQP(__EE392583.UID,__EE389916.UID);
  __ST387342_Layout __JT392589(__ST386959_Layout __l, __ST384365_Layout __r) := TRANSFORM
    SELF.U_I_D__3_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE392647 := JOIN(__EE392583,__EE389916,__JC392589(LEFT,RIGHT),__JT392589(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE382662 := __ENH_Customer_1;
  SHARED __EE391356 := __EE382662;
  SHARED __ST387724_Layout := RECORD
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
    KEL.typ.ndataset(E_Social_Security_Number.Hri_List_Layout) Hri_List_;
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
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Hri_List_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__1_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__2_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__3_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__4_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__5_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__6_ := 0;
    KEL.typ.nuid U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__3_;
    KEL.typ.nuid U_I_D__4_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.int All_Address_Count_ := 0;
    KEL.typ.int All_Deceased_Matched_Person_Count_ := 0;
    KEL.typ.int All_Deceased_Person_Count_ := 0;
    KEL.typ.int All_High_Frequency_Address_Count_ := 0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.int High_Frequency_Address_Count_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC392653(__ST387342_Layout __EE392647, B_Customer_1.__ST11810_Layout __EE391356) := __EEQP(__EE392647._r_Customer_,__EE391356.UID);
  __ST387724_Layout __JT392653(__ST387342_Layout __l, B_Customer_1.__ST11810_Layout __r) := TRANSFORM
    SELF.U_I_D__4_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE392724 := JOIN(__EE392647,__EE391356,__JC392653(LEFT,RIGHT),__JT392653(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST388116_Layout := RECORD
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
    KEL.typ.ndataset(E_Social_Security_Number.Hri_List_Layout) Hri_List_;
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
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Hri_List_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__1_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__2_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__3_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__4_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__5_ := 0;
    KEL.typ.int C_O_U_N_T___Hri_List__6_ := 0;
    KEL.typ.nuid U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) U_I_D__3_;
    KEL.typ.nuid U_I_D__4_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.int All_Address_Count_ := 0;
    KEL.typ.int All_Deceased_Matched_Person_Count_ := 0;
    KEL.typ.int All_Deceased_Person_Count_ := 0;
    KEL.typ.int All_High_Frequency_Address_Count_ := 0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.int High_Frequency_Address_Count_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.nuid U_I_D__5_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.int Address_Count__1_ := 0;
    KEL.typ.int All_Address_Count__1_ := 0;
    KEL.typ.int All_Deceased_Matched_Person_Count__1_ := 0;
    KEL.typ.int All_Deceased_Person_Count__1_ := 0;
    KEL.typ.int All_High_Frequency_Address_Count__1_ := 0;
    KEL.typ.int All_Person_Count__1_ := 0;
    KEL.typ.int Deceased_Person_Count__1_ := 0;
    KEL.typ.nkdate Event_Date_Max__1_;
    KEL.typ.int High_Frequency_Address_Count__1_ := 0;
    KEL.typ.int Person_Count__1_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC392730(__ST387724_Layout __EE392724, B_Customer_1.__ST11810_Layout __EE382662) := __EEQP(__EE392724._r_Customer_,__EE382662.UID);
  __ST388116_Layout __JT392730(__ST387724_Layout __l, B_Customer_1.__ST11810_Layout __r) := TRANSFORM
    SELF.U_I_D__5_ := __r.UID;
    SELF.Customer_Id__1_ := __r.Customer_Id_;
    SELF.Industry_Type__1_ := __r.Industry_Type_;
    SELF.Address_Count__1_ := __r.Address_Count_;
    SELF.All_Address_Count__1_ := __r.All_Address_Count_;
    SELF.All_Deceased_Matched_Person_Count__1_ := __r.All_Deceased_Matched_Person_Count_;
    SELF.All_Deceased_Person_Count__1_ := __r.All_Deceased_Person_Count_;
    SELF.All_High_Frequency_Address_Count__1_ := __r.All_High_Frequency_Address_Count_;
    SELF.All_Person_Count__1_ := __r.All_Person_Count_;
    SELF.Deceased_Person_Count__1_ := __r.Deceased_Person_Count_;
    SELF.Event_Date_Max__1_ := __r.Event_Date_Max_;
    SELF.High_Frequency_Address_Count__1_ := __r.High_Frequency_Address_Count_;
    SELF.Person_Count__1_ := __r.Person_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE392838 := JOIN(__EE392724,__EE382662,__JC392730(LEFT,RIGHT),__JT392730(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST11601_Layout := RECORD
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
    KEL.typ.ndataset(E_Social_Security_Number.Hri_List_Layout) Hri_List_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Element_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.nfloat Cl_Impact_Weight_;
    KEL.typ.int Cluster_Score_ := 0;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int Event_Count_ := 0;
    KEL.typ.int Hri06_Flag_ := 0;
    KEL.typ.int Hri26_Flag_ := 0;
    KEL.typ.int Hri29_Flag_ := 0;
    KEL.typ.int Hri38_Flag_ := 0;
    KEL.typ.int Hri71_Flag_ := 0;
    KEL.typ.int Hri_It_Flag_ := 0;
    KEL.typ.int Hri_Mi_Flag_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.nint Industry_Type_;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.nint Score_;
    KEL.typ.nint Source_Customer_Count_;
    KEL.typ.int Vl_Event1_All_Count_ := 0;
    KEL.typ.int Vl_Event1_Count_ := 0;
    KEL.typ.int Vl_Event30_Active_Flag_ := 0;
    KEL.typ.int Vl_Event30_All_Active_Flag_ := 0;
    KEL.typ.int Vl_Event30_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event365_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event365_Count_ := 0;
    KEL.typ.int Vl_Event7_Active_Flag_ := 0;
    KEL.typ.int Vl_Event7_All_Active_Flag_ := 0;
    KEL.typ.int Vl_Event7_All_Count_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST11601_Layout __ND392843__Project(__ST388116_Layout __PP392839) := TRANSFORM
    SELF.Cl_Element_Count_ := 0;
    SELF.Cl_Impact_Weight_ := __OP2(__OP2(__OP2(__OP2(__PP392839.Cl_Identity_Count_Percentile_,*,__CN(0.3)),+,__OP2(__PP392839.Cl_Event_Count_Percentile_,*,__CN(0.3))),+,__OP2(__PP392839.Cl_Active30_Identity_Count_Percentile_,*,__CN(0.2))),+,__OP2(__PP392839.Cl_Active7_Identity_Count_Percentile_,*,__CN(0.2)));
    SELF.Cluster_Score_ := 0;
    SELF.Customer_Id_ := __PP392839.Customer_Id__1_;
    SELF.Entity_Context_Uid_ := __OP2(__CN('_15'),+,__PP392839.Ssn_);
    SELF.Entity_Type_ := 15;
    SELF.Event_Count_ := __PP392839.C_O_U_N_T___Person_Event_;
    SELF.Hri06_Flag_ := MAP(__T(__OP2(__CN(__PP392839.C_O_U_N_T___Hri_List_),<>,__CN(0)))=>1,0);
    SELF.Hri26_Flag_ := MAP(__T(__OP2(__CN(__PP392839.C_O_U_N_T___Hri_List__1_),<>,__CN(0)))=>1,0);
    SELF.Hri29_Flag_ := MAP(__T(__OP2(__CN(__PP392839.C_O_U_N_T___Hri_List__2_),<>,__CN(0)))=>1,0);
    SELF.Hri38_Flag_ := MAP(__T(__OP2(__CN(__PP392839.C_O_U_N_T___Hri_List__3_),<>,__CN(0)))=>1,0);
    SELF.Hri71_Flag_ := MAP(__T(__OP2(__CN(__PP392839.C_O_U_N_T___Hri_List__4_),<>,__CN(0)))=>1,0);
    SELF.Hri_It_Flag_ := MAP(__T(__OP2(__CN(__PP392839.C_O_U_N_T___Hri_List__5_),<>,__CN(0)))=>1,0);
    SELF.Hri_Mi_Flag_ := MAP(__T(__OP2(__CN(__PP392839.C_O_U_N_T___Hri_List__6_),<>,__CN(0)))=>1,0);
    SELF.Kr_High_Risk_Flag_ := MAP(__PP392839.C_O_U_N_T___Exp1_ <> 0=>1,0);
    SELF.Kr_Medium_Risk_Flag_ := MAP(__PP392839.C_O_U_N_T___Exp1__1_ <> 0=>1,0);
    SELF.Label_ := __PP392839.Ssn_Formatted_;
    SELF.Score_ := __OP2(__PP392839.UID,%,__CN(100));
    SELF.Source_Customer_Count_ := KEL.Aggregates.CountN(__PP392839.Source_Customers_);
    SELF.Vl_Event1_All_Count_ := __PP392839.C_O_U_N_T___Exp1__2_;
    SELF.Vl_Event1_Count_ := __PP392839.C_O_U_N_T___Exp1__3_;
    SELF.Vl_Event30_Active_Flag_ := MAP(__PP392839.Vl_Event30_Count_ > 0=>1,0);
    SELF.Vl_Event30_All_Active_Flag_ := MAP(__PP392839.Vl_Event30_All_Day_Count_ > 0=>1,0);
    SELF.Vl_Event365_All_Day_Count_ := __PP392839.C_O_U_N_T___Exp1__4_;
    SELF.Vl_Event365_Count_ := __PP392839.C_O_U_N_T___Exp1__5_;
    SELF.Vl_Event7_Active_Flag_ := MAP(__PP392839.Vl_Event7_Count_ > 0=>1,0);
    SELF.Vl_Event7_All_Active_Flag_ := MAP(__PP392839.Vl_Event7_All_Count_ > 0=>1,0);
    SELF := __PP392839;
  END;
  EXPORT __ENH_Social_Security_Number := PROJECT(__EE392838,__ND392843__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Social_Security_Number::Annotated',EXPIRE(30));
  SHARED __EE504784 := __ENH_Social_Security_Number;
  SHARED IDX_Social_Security_Number_UID_Layout := RECORD
    KEL.typ.uid UID;
    __EE504784._r_Customer_;
    __EE504784.Source_Customers_;
    __EE504784.Ssn_;
    __EE504784.Otto_S_S_N_Id_;
    __EE504784.Ssn_Formatted_;
    __EE504784._v2__divssnidentitycountnew_;
    __EE504784.Deceased_Date_;
    __EE504784.Deceased_Date_Of_Birth_;
    __EE504784.Deceased_First_;
    __EE504784.Deceased_Middle_;
    __EE504784.Deceased_Last_;
    __EE504784.Deceased_Match_Code_;
    __EE504784._isdeepdive_;
    __EE504784._county__death_;
    __EE504784.Deceased_Ssn_;
    __EE504784._state__death__flag_;
    __EE504784._death__rec__src_;
    __EE504784._state__death__id_;
    __EE504784.Hri_List_;
    __EE504784.Customer_Id_;
    __EE504784.Industry_Type_;
    __EE504784.Source_Customer_Count_;
    __EE504784.Entity_Context_Uid_;
    __EE504784.Entity_Type_;
    __EE504784.Label_;
    __EE504784.Identity_Count_;
    __EE504784.Event_Count_;
    __EE504784.Hri06_Flag_;
    __EE504784.Hri26_Flag_;
    __EE504784.Hri29_Flag_;
    __EE504784.Hri38_Flag_;
    __EE504784.Hri71_Flag_;
    __EE504784.Hri_It_Flag_;
    __EE504784.Hri_Mi_Flag_;
    __EE504784.Kr_High_Risk_Flag_;
    __EE504784.Kr_Medium_Risk_Flag_;
    __EE504784.Vl_Event1_All_Count_;
    __EE504784.Vl_Event7_All_Count_;
    __EE504784.Vl_Event30_All_Day_Count_;
    __EE504784.Vl_Event365_All_Day_Count_;
    __EE504784.Vl_Event7_All_Active_Flag_;
    __EE504784.Vl_Event30_All_Active_Flag_;
    __EE504784.Vl_Event1_Count_;
    __EE504784.Vl_Event7_Count_;
    __EE504784.Vl_Event30_Count_;
    __EE504784.Vl_Event365_Count_;
    __EE504784.Vl_Event7_Active_Flag_;
    __EE504784.Vl_Event30_Active_Flag_;
    __EE504784.Cl_Identity_Count_;
    __EE504784.Cl_Active7_Identity_Count_;
    __EE504784.Cl_Active30_Identity_Count_;
    __EE504784.Cl_Element_Count_;
    __EE504784.Cl_Event_Count_;
    __EE504784.Cl_Identity_Count_Percentile_;
    __EE504784.Cl_Event_Count_Percentile_;
    __EE504784.Cl_Active30_Identity_Count_Percentile_;
    __EE504784.Cl_Active7_Identity_Count_Percentile_;
    __EE504784.Cl_Impact_Weight_;
    __EE504784.Score_;
    __EE504784.Cluster_Score_;
    __EE504784.Date_First_Seen_;
    __EE504784.Date_Last_Seen_;
    __EE504784.__RecordCount;
  END;
  SHARED IDX_Social_Security_Number_UID_Projected := PROJECT(__EE504784,TRANSFORM(IDX_Social_Security_Number_UID_Layout,SELF.UID:=__T(LEFT.UID),SELF:=LEFT));
  EXPORT IDX_Social_Security_Number_UID := INDEX(IDX_Social_Security_Number_UID_Projected,{UID},{IDX_Social_Security_Number_UID_Projected},'~key::KEL::KELOtto::Social_Security_Number::UID');
  EXPORT IDX_Social_Security_Number_UID_Build := BUILD(IDX_Social_Security_Number_UID,OVERWRITE);
  EXPORT __ST504786_Layout := RECORDOF(IDX_Social_Security_Number_UID);
  EXPORT IDX_Social_Security_Number_UID_Wrapped := PROJECT(IDX_Social_Security_Number_UID,TRANSFORM(__ST11601_Layout,SELF.UID := __CN(LEFT.UID),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Social_Security_Number_UID_Build);
END;
