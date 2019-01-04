﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer_1,B_Email_1,B_Event_1,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Email := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_1.__ENH_Customer_1) __ENH_Customer_1 := B_Customer_1.__ENH_Customer_1;
  SHARED VIRTUAL TYPEOF(B_Email_1.__ENH_Email_1) __ENH_Email_1 := B_Email_1.__ENH_Email_1;
  SHARED VIRTUAL TYPEOF(B_Event_1.__ENH_Event_1) __ENH_Event_1 := B_Event_1.__ENH_Event_1;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE256451 := __ENH_Email_1;
  SHARED __EE262042 := __ENH_Event_1;
  SHARED __EE261994 := __E_Person_Event;
  SHARED __EE263103 := __EE261994;
  SHARED __EE263116 := __EE263103(__NN(__EE263103.Emailof_) AND __NN(__EE263103.Transaction_));
  SHARED __ST259257_Layout := RECORD
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
  __JC263122(B_Event_1.__ST11960_Layout __EE262042, E_Person_Event.Layout __EE263116) := __EEQP(__EE263116.Transaction_,__EE262042.UID);
  __ST259257_Layout __JT263122(B_Event_1.__ST11960_Layout __l, E_Person_Event.Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF.Subject__1_ := __r.Subject_;
    SELF.Location__1_ := __r.Location_;
    SELF.Event_Date__1_ := __r.Event_Date_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE263123 := JOIN(__EE263116,__EE262042,__JC263122(RIGHT,LEFT),__JT263122(RIGHT,LEFT),INNER,HASH);
  SHARED __ST258748_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
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
  SHARED __ST258748_Layout __ND263233__Project(__ST259257_Layout __PP263124) := TRANSFORM
    SELF.UID := __PP263124.Emailof_;
    SELF._r_Customer_ := __PP263124._r_Customer__1_;
    SELF.Subject_ := __PP263124.Subject__1_;
    SELF.Location_ := __PP263124.Location__1_;
    SELF.Event_Date_ := __PP263124.Event_Date__1_;
    SELF.U_I_D__1_ := __PP263124.UID;
    SELF := __PP263124;
  END;
  SHARED __EE263306 := PROJECT(__EE263123,__ND263233__Project(LEFT));
  SHARED __ST258819_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.bool Exp1_ := FALSE;
    KEL.typ.bool Exp2_ := FALSE;
    KEL.typ.nbool Exp3_;
    KEL.typ.nbool Exp4_;
    KEL.typ.nbool Exp5_;
    KEL.typ.nbool Exp6_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST258819_Layout __ND263915__Project(__ST258748_Layout __PP263307) := TRANSFORM
    SELF.Exp1_ := __PP263307.Kr_High_Risk_Identity_Flag_ = 1;
    SELF.Exp2_ := __PP263307.Kr_Medium_Risk_Identity_Flag_ = 1;
    SELF.Exp3_ := __OP2(__PP263307.Age_,<,__CN(2));
    SELF.Exp4_ := __AND(__OP2(__PP263307.Age_,<,__CN(2)),__CN(__PP263307.In_Customer_Population_ = 1));
    SELF.Exp5_ := __OP2(__PP263307.Age_,<,__CN(366));
    SELF.Exp6_ := __AND(__OP2(__PP263307.Age_,<,__CN(366)),__CN(__PP263307.In_Customer_Population_ = 1));
    SELF := __PP263307;
  END;
  SHARED __EE263934 := PROJECT(__EE263306,__ND263915__Project(LEFT));
  SHARED __ST258859_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE263979 := PROJECT(__CLEANANDDO(__EE263934,TABLE(__EE263934,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP,__EE263934.Exp1_),KEL.typ.int C_O_U_N_T___Exp1__1_ := COUNT(GROUP,__EE263934.Exp2_),KEL.typ.int C_O_U_N_T___Exp1__2_ := COUNT(GROUP,__T(__EE263934.Exp3_)),KEL.typ.int C_O_U_N_T___Exp1__3_ := COUNT(GROUP,__T(__EE263934.Exp4_)),KEL.typ.int C_O_U_N_T___Exp1__4_ := COUNT(GROUP,__T(__EE263934.Exp5_)),KEL.typ.int C_O_U_N_T___Exp1__5_ := COUNT(GROUP,__T(__EE263934.Exp6_)),UID},UID,MERGE)),__ST258859_Layout);
  SHARED __ST259458_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nint Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
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
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC263985(B_Email_1.__ST11864_Layout __EE256451, __ST258859_Layout __EE263979) := __EEQP(__EE256451.UID,__EE263979.UID);
  __ST259458_Layout __JT263985(B_Email_1.__ST11864_Layout __l, __ST258859_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE264020 := JOIN(__EE256451,__EE263979,__JC263985(LEFT,RIGHT),__JT263985(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE262001 := __EE261994(__NN(__EE261994.Emailof_));
  SHARED __EE263100 := __EE262001;
  SHARED __ST258168_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE263451 := DEDUP(PROJECT(__EE263100,TRANSFORM(__ST258168_Layout,SELF.UID := LEFT.Emailof_,SELF := LEFT)),ALL);
  SHARED __ST258186_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE263464 := PROJECT(__CLEANANDDO(__EE263451,TABLE(__EE263451,{KEL.typ.int C_O_U_N_T___Person_Event_ := COUNT(GROUP),UID},UID,MERGE)),__ST258186_Layout);
  SHARED __ST259729_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nint Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
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
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC264026(__ST259458_Layout __EE264020, __ST258186_Layout __EE263464) := __EEQP(__EE264020.UID,__EE263464.UID);
  __ST259729_Layout __JT264026(__ST259458_Layout __l, __ST258186_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE264063 := JOIN(__EE264020,__EE263464,__JC264026(LEFT,RIGHT),__JT264026(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST257930_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE262015 := DEDUP(PROJECT(__EE262001,TRANSFORM(__ST257930_Layout,SELF.UID := LEFT.Emailof_,SELF := LEFT)),ALL);
  SHARED __ST257948_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE261977 := PROJECT(__CLEANANDDO(__EE262015,TABLE(__EE262015,{KEL.typ.int C_O_U_N_T___Person_Event_ := COUNT(GROUP),UID},UID,MERGE)),__ST257948_Layout);
  SHARED __ST259999_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nint Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
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
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Event__1_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__3_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC264069(__ST259729_Layout __EE264063, __ST257948_Layout __EE261977) := __EEQP(__EE264063.UID,__EE261977.UID);
  __ST259999_Layout __JT264069(__ST259729_Layout __l, __ST257948_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Event__1_ := __r.C_O_U_N_T___Person_Event_;
    SELF.U_I_D__3_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE264110 := JOIN(__EE264063,__EE261977,__JC264069(LEFT,RIGHT),__JT264069(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE256607 := __ENH_Customer_1;
  SHARED __EE263094 := __EE256607;
  SHARED __ST260270_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nint Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
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
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Event__1_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__3_;
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
  __JC264116(__ST259999_Layout __EE264110, B_Customer_1.__ST11810_Layout __EE263094) := __EEQP(__EE264110._r_Customer_,__EE263094.UID);
  __ST260270_Layout __JT264116(__ST259999_Layout __l, B_Customer_1.__ST11810_Layout __r) := TRANSFORM
    SELF.U_I_D__4_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE264168 := JOIN(__EE264110,__EE263094,__JC264116(LEFT,RIGHT),__JT264116(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST260549_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nint Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
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
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Event__1_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__3_;
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
  __JC264174(__ST260270_Layout __EE264168, B_Customer_1.__ST11810_Layout __EE256607) := __EEQP(__EE264168._r_Customer_,__EE256607.UID);
  __ST260549_Layout __JT264174(__ST260270_Layout __l, B_Customer_1.__ST11810_Layout __r) := TRANSFORM
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
  SHARED __EE264263 := JOIN(__EE264168,__EE256607,__JC264174(LEFT,RIGHT),__JT264174(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST10885_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nint Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
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
  SHARED __ST10885_Layout __ND264268__Project(__ST260549_Layout __PP264264) := TRANSFORM
    SELF.Cl_Element_Count_ := 0;
    SELF.Cl_Impact_Weight_ := __OP2(__OP2(__OP2(__OP2(__PP264264.Cl_Identity_Count_Percentile_,*,__CN(0.3)),+,__OP2(__PP264264.Cl_Event_Count_Percentile_,*,__CN(0.3))),+,__OP2(__PP264264.Cl_Active30_Identity_Count_Percentile_,*,__CN(0.2))),+,__OP2(__PP264264.Cl_Active7_Identity_Count_Percentile_,*,__CN(0.2)));
    SELF.Cluster_Score_ := 0;
    SELF.Customer_Id_ := __PP264264.Customer_Id__1_;
    SELF.Entity_Context_Uid_ := __OP2(__CN('_17'),+,__PP264264.Otto_Email_Id_);
    SELF.Entity_Type_ := 17;
    SELF.Event_Count_ := __PP264264.C_O_U_N_T___Person_Event__1_;
    SELF.Identity_Count_ := __PP264264.C_O_U_N_T___Person_Event_;
    SELF.Kr_High_Risk_Flag_ := MAP(__PP264264.C_O_U_N_T___Exp1_ <> 0=>1,0);
    SELF.Kr_Medium_Risk_Flag_ := MAP(__PP264264.C_O_U_N_T___Exp1__1_ <> 0=>1,0);
    SELF.Label_ := __PP264264.Email_Address_;
    SELF.Score_ := __OP2(__PP264264.UID,%,__CN(100));
    SELF.Source_Customer_Count_ := KEL.Aggregates.CountN(__PP264264.Source_Customers_);
    SELF.Vl_Event1_All_Count_ := __PP264264.C_O_U_N_T___Exp1__2_;
    SELF.Vl_Event1_Count_ := __PP264264.C_O_U_N_T___Exp1__3_;
    SELF.Vl_Event30_Active_Flag_ := MAP(__PP264264.Vl_Event30_Count_ > 0=>1,0);
    SELF.Vl_Event30_All_Active_Flag_ := MAP(__PP264264.Vl_Event30_All_Day_Count_ > 0=>1,0);
    SELF.Vl_Event365_All_Day_Count_ := __PP264264.C_O_U_N_T___Exp1__4_;
    SELF.Vl_Event365_Count_ := __PP264264.C_O_U_N_T___Exp1__5_;
    SELF.Vl_Event7_Active_Flag_ := MAP(__PP264264.Vl_Event7_Count_ > 0=>1,0);
    SELF.Vl_Event7_All_Active_Flag_ := MAP(__PP264264.Vl_Event7_All_Count_ > 0=>1,0);
    SELF := __PP264264;
  END;
  EXPORT __ENH_Email := PROJECT(__EE264263,__ND264268__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Email::Annotated',EXPIRE(30));
  SHARED __EE504998 := __ENH_Email;
  SHARED IDX_Email_UID_Layout := RECORD
    KEL.typ.uid UID;
    __EE504998._r_Customer_;
    __EE504998.Source_Customers_;
    __EE504998.Email_Address_;
    __EE504998.Otto_Email_Id_;
    __EE504998.Details_;
    __EE504998.Customer_Id_;
    __EE504998.Industry_Type_;
    __EE504998.Source_Customer_Count_;
    __EE504998.Entity_Context_Uid_;
    __EE504998.Entity_Type_;
    __EE504998.Label_;
    __EE504998.Identity_Count_;
    __EE504998.Event_Count_;
    __EE504998.Kr_High_Risk_Flag_;
    __EE504998.Kr_Medium_Risk_Flag_;
    __EE504998.Vl_Event1_All_Count_;
    __EE504998.Vl_Event7_All_Count_;
    __EE504998.Vl_Event30_All_Day_Count_;
    __EE504998.Vl_Event365_All_Day_Count_;
    __EE504998.Vl_Event7_All_Active_Flag_;
    __EE504998.Vl_Event30_All_Active_Flag_;
    __EE504998.Vl_Event1_Count_;
    __EE504998.Vl_Event7_Count_;
    __EE504998.Vl_Event30_Count_;
    __EE504998.Vl_Event365_Count_;
    __EE504998.Vl_Event7_Active_Flag_;
    __EE504998.Vl_Event30_Active_Flag_;
    __EE504998.Cl_Identity_Count_;
    __EE504998.Cl_Active7_Identity_Count_;
    __EE504998.Cl_Active30_Identity_Count_;
    __EE504998.Cl_Event_Count_;
    __EE504998.Cl_Element_Count_;
    __EE504998.Cl_Identity_Count_Percentile_;
    __EE504998.Cl_Event_Count_Percentile_;
    __EE504998.Cl_Active30_Identity_Count_Percentile_;
    __EE504998.Cl_Active7_Identity_Count_Percentile_;
    __EE504998.Cl_Impact_Weight_;
    __EE504998.Score_;
    __EE504998.Cluster_Score_;
    __EE504998.Date_First_Seen_;
    __EE504998.Date_Last_Seen_;
    __EE504998.__RecordCount;
  END;
  SHARED IDX_Email_UID_Projected := PROJECT(__EE504998,TRANSFORM(IDX_Email_UID_Layout,SELF.UID:=__T(LEFT.UID),SELF:=LEFT));
  EXPORT IDX_Email_UID := INDEX(IDX_Email_UID_Projected,{UID},{IDX_Email_UID_Projected},'~key::KEL::KELOtto::Email::UID');
  EXPORT IDX_Email_UID_Build := BUILD(IDX_Email_UID,OVERWRITE);
  EXPORT __ST505000_Layout := RECORDOF(IDX_Email_UID);
  EXPORT IDX_Email_UID_Wrapped := PROJECT(IDX_Email_UID,TRANSFORM(__ST10885_Layout,SELF.UID := __CN(LEFT.UID),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Email_UID_Build);
END;
