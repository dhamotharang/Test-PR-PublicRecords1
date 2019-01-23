﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer_1,B_Event_1,B_Internet_Protocol_1,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Internet_Protocol := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_1.__ENH_Customer_1) __ENH_Customer_1 := B_Customer_1.__ENH_Customer_1;
  SHARED VIRTUAL TYPEOF(B_Event_1.__ENH_Event_1) __ENH_Event_1 := B_Event_1.__ENH_Event_1;
  SHARED VIRTUAL TYPEOF(B_Internet_Protocol_1.__ENH_Internet_Protocol_1) __ENH_Internet_Protocol_1 := B_Internet_Protocol_1.__ENH_Internet_Protocol_1;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE322890 := __ENH_Internet_Protocol_1;
  SHARED __EE328972 := __ENH_Event_1;
  SHARED __EE328924 := __E_Person_Event;
  SHARED __EE330144 := __EE328924;
  SHARED __EE330157 := __EE330144(__NN(__EE330144.Ip_) AND __NN(__EE330144.Transaction_));
  SHARED __ST325852_Layout := RECORD
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
    KEL.typ.int Kr_Bnk800_Flag_ := 0;
    KEL.typ.int Kr_Bnk801_Flag_ := 0;
    KEL.typ.int Kr_Bnk802_Flag_ := 0;
    KEL.typ.int Kr_Bnk890_Flag_ := 0;
    KEL.typ.int Kr_Bnk891_Flag_ := 0;
    KEL.typ.int Kr_Bnk892_Flag_ := 0;
    KEL.typ.int Kr_Bnk893_Flag_ := 0;
    KEL.typ.int Kr_Dl200_Flag_ := 0;
    KEL.typ.int Kr_Dl201_Flag_ := 0;
    KEL.typ.int Kr_Dl202_Flag_ := 0;
    KEL.typ.int Kr_Dl203_Flag_ := 0;
    KEL.typ.int Kr_Dl204_Flag_ := 0;
    KEL.typ.int Kr_Dl290_Flag_ := 0;
    KEL.typ.int Kr_Dl291_Flag_ := 0;
    KEL.typ.int Kr_Dl292_Flag_ := 0;
    KEL.typ.int Kr_Dl293_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Address_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Bank_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Dl_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Identity_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Bank_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Dl_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Address_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Bank_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Dl_Flag_ := 0;
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
  __JC330163(B_Event_1.__ST13205_Layout __EE328972, E_Person_Event.Layout __EE330157) := __EEQP(__EE330157.Transaction_,__EE328972.UID);
  __ST325852_Layout __JT330163(B_Event_1.__ST13205_Layout __l, E_Person_Event.Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF.Subject__1_ := __r.Subject_;
    SELF.Location__1_ := __r.Location_;
    SELF.Event_Date__1_ := __r.Event_Date_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE330164 := JOIN(__EE330157,__EE328972,__JC330163(RIGHT,LEFT),__JT330163(RIGHT,LEFT),INNER,HASH);
  SHARED __ST325325_Layout := RECORD
    KEL.typ.ntyp(E_Internet_Protocol.Typ) UID;
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
  SHARED __ST325325_Layout __ND330296__Project(__ST325852_Layout __PP330165) := TRANSFORM
    SELF.UID := __PP330165.Ip_;
    SELF._r_Customer_ := __PP330165._r_Customer__1_;
    SELF.Subject_ := __PP330165.Subject__1_;
    SELF.Location_ := __PP330165.Location__1_;
    SELF.Event_Date_ := __PP330165.Event_Date__1_;
    SELF.U_I_D__1_ := __PP330165.UID;
    SELF := __PP330165;
  END;
  SHARED __EE330369 := PROJECT(__EE330164,__ND330296__Project(LEFT));
  SHARED __ST325396_Layout := RECORD
    KEL.typ.ntyp(E_Internet_Protocol.Typ) UID;
    KEL.typ.bool Exp1_ := FALSE;
    KEL.typ.bool Exp2_ := FALSE;
    KEL.typ.nbool Exp3_;
    KEL.typ.nbool Exp4_;
    KEL.typ.nbool Exp5_;
    KEL.typ.nbool Exp6_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST325396_Layout __ND331067__Project(__ST325325_Layout __PP330370) := TRANSFORM
    SELF.Exp1_ := __PP330370.Kr_High_Risk_Identity_Flag_ = 1;
    SELF.Exp2_ := __PP330370.Kr_Medium_Risk_Identity_Flag_ = 1;
    SELF.Exp3_ := __OP2(__PP330370.Age_,<,__CN(2));
    SELF.Exp4_ := __AND(__OP2(__PP330370.Age_,<,__CN(2)),__CN(__PP330370.In_Customer_Population_ = 1));
    SELF.Exp5_ := __OP2(__PP330370.Age_,<,__CN(366));
    SELF.Exp6_ := __AND(__OP2(__PP330370.Age_,<,__CN(366)),__CN(__PP330370.In_Customer_Population_ = 1));
    SELF := __PP330370;
  END;
  SHARED __EE331086 := PROJECT(__EE330369,__ND331067__Project(LEFT));
  SHARED __ST325436_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE331131 := PROJECT(__CLEANANDDO(__EE331086,TABLE(__EE331086,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP,__EE331086.Exp1_),KEL.typ.int C_O_U_N_T___Exp1__1_ := COUNT(GROUP,__EE331086.Exp2_),KEL.typ.int C_O_U_N_T___Exp1__2_ := COUNT(GROUP,__T(__EE331086.Exp3_)),KEL.typ.int C_O_U_N_T___Exp1__3_ := COUNT(GROUP,__T(__EE331086.Exp4_)),KEL.typ.int C_O_U_N_T___Exp1__4_ := COUNT(GROUP,__T(__EE331086.Exp5_)),KEL.typ.int C_O_U_N_T___Exp1__5_ := COUNT(GROUP,__T(__EE331086.Exp6_)),UID},UID,MERGE)),__ST325436_Layout);
  SHARED __ST326075_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Internet_Protocol.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Ip_Address_;
    KEL.typ.nint Otto_Ip_Address_Id_;
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
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC331137(B_Internet_Protocol_1.__ST13337_Layout __EE322890, __ST325436_Layout __EE331131) := __EEQP(__EE322890.UID,__EE331131.UID);
  __ST326075_Layout __JT331137(B_Internet_Protocol_1.__ST13337_Layout __l, __ST325436_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE331181 := JOIN(__EE322890,__EE331131,__JC331137(LEFT,RIGHT),__JT331137(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE328931 := __EE328924(__NN(__EE328924.Ip_));
  SHARED __EE330141 := __EE328931;
  SHARED __ST324718_Layout := RECORD
    KEL.typ.ntyp(E_Internet_Protocol.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE330523 := DEDUP(PROJECT(__EE330141,TRANSFORM(__ST324718_Layout,SELF.UID := LEFT.Ip_,SELF := LEFT)),ALL);
  SHARED __ST324736_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE330536 := PROJECT(__CLEANANDDO(__EE330523,TABLE(__EE330523,{KEL.typ.int C_O_U_N_T___Person_Event_ := COUNT(GROUP),UID},UID,MERGE)),__ST324736_Layout);
  SHARED __ST326389_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Internet_Protocol.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Ip_Address_;
    KEL.typ.nint Otto_Ip_Address_Id_;
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
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC331187(__ST326075_Layout __EE331181, __ST324736_Layout __EE330536) := __EEQP(__EE331181.UID,__EE330536.UID);
  __ST326389_Layout __JT331187(__ST326075_Layout __l, __ST324736_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE331233 := JOIN(__EE331181,__EE330536,__JC331187(LEFT,RIGHT),__JT331187(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST324462_Layout := RECORD
    KEL.typ.ntyp(E_Internet_Protocol.Typ) UID;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE328945 := DEDUP(PROJECT(__EE328931,TRANSFORM(__ST324462_Layout,SELF.UID := LEFT.Ip_,SELF := LEFT)),ALL);
  SHARED __ST324480_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE328907 := PROJECT(__CLEANANDDO(__EE328945,TABLE(__EE328945,{KEL.typ.int C_O_U_N_T___Person_Event_ := COUNT(GROUP),UID},UID,MERGE)),__ST324480_Layout);
  SHARED __ST326702_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Internet_Protocol.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Ip_Address_;
    KEL.typ.nint Otto_Ip_Address_Id_;
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
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Event__1_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__3_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC331239(__ST326389_Layout __EE331233, __ST324480_Layout __EE328907) := __EEQP(__EE331233.UID,__EE328907.UID);
  __ST326702_Layout __JT331239(__ST326389_Layout __l, __ST324480_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Event__1_ := __r.C_O_U_N_T___Person_Event_;
    SELF.U_I_D__3_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE331289 := JOIN(__EE331233,__EE328907,__JC331239(LEFT,RIGHT),__JT331239(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE323085 := __ENH_Customer_1;
  SHARED __EE330135 := __EE323085;
  SHARED __ST327016_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Internet_Protocol.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Ip_Address_;
    KEL.typ.nint Otto_Ip_Address_Id_;
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
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Event__1_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__3_;
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
  __JC331295(__ST326702_Layout __EE331289, B_Customer_1.__ST13050_Layout __EE330135) := __EEQP(__EE331289._r_Customer_,__EE330135.UID);
  __ST327016_Layout __JT331295(__ST326702_Layout __l, B_Customer_1.__ST13050_Layout __r) := TRANSFORM
    SELF.U_I_D__4_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE331356 := JOIN(__EE331289,__EE330135,__JC331295(LEFT,RIGHT),__JT331295(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST327338_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Internet_Protocol.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Ip_Address_;
    KEL.typ.nint Otto_Ip_Address_Id_;
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
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Person_Event_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Event__1_ := 0;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) U_I_D__3_;
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
  __JC331362(__ST327016_Layout __EE331356, B_Customer_1.__ST13050_Layout __EE323085) := __EEQP(__EE331356._r_Customer_,__EE323085.UID);
  __ST327338_Layout __JT331362(__ST327016_Layout __l, B_Customer_1.__ST13050_Layout __r) := TRANSFORM
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
  SHARED __EE331460 := JOIN(__EE331356,__EE323085,__JC331362(LEFT,RIGHT),__JT331362(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST12423_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Internet_Protocol.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Ip_Address_;
    KEL.typ.nint Otto_Ip_Address_Id_;
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
  SHARED __ST12423_Layout __ND331465__Project(__ST327338_Layout __PP331461) := TRANSFORM
    SELF.Cl_Element_Count_ := 0;
    SELF.Cl_Impact_Weight_ := __OP2(__OP2(__OP2(__OP2(__PP331461.Cl_Identity_Count_Percentile_,*,__CN(0.3)),+,__OP2(__PP331461.Cl_Event_Count_Percentile_,*,__CN(0.3))),+,__OP2(__PP331461.Cl_Active30_Identity_Count_Percentile_,*,__CN(0.2))),+,__OP2(__PP331461.Cl_Active7_Identity_Count_Percentile_,*,__CN(0.2)));
    SELF.Cluster_Score_ := 0;
    SELF.Customer_Id_ := __PP331461.Customer_Id__1_;
    SELF.Entity_Context_Uid_ := __OP2(__CN('_18'),+,__PP331461.Otto_Ip_Address_Id_);
    SELF.Entity_Type_ := 18;
    SELF.Event_Count_ := __PP331461.C_O_U_N_T___Person_Event__1_;
    SELF.Identity_Count_ := __PP331461.C_O_U_N_T___Person_Event_;
    SELF.Kr_High_Risk_Flag_ := MAP(__PP331461.C_O_U_N_T___Exp1_ <> 0=>1,0);
    SELF.Kr_Medium_Risk_Flag_ := MAP(__PP331461.C_O_U_N_T___Exp1__1_ <> 0=>1,0);
    SELF.Label_ := __PP331461.Ip_Address_;
    SELF.Score_ := __OP2(__PP331461.UID,%,__CN(100));
    SELF.Source_Customer_Count_ := KEL.Aggregates.CountN(__PP331461.Source_Customers_);
    SELF.Vl_Event1_All_Count_ := __PP331461.C_O_U_N_T___Exp1__2_;
    SELF.Vl_Event1_Count_ := __PP331461.C_O_U_N_T___Exp1__3_;
    SELF.Vl_Event30_Active_Flag_ := MAP(__PP331461.Vl_Event30_Count_ > 0=>1,0);
    SELF.Vl_Event30_All_Active_Flag_ := MAP(__PP331461.Vl_Event30_All_Day_Count_ > 0=>1,0);
    SELF.Vl_Event365_All_Day_Count_ := __PP331461.C_O_U_N_T___Exp1__4_;
    SELF.Vl_Event365_Count_ := __PP331461.C_O_U_N_T___Exp1__5_;
    SELF.Vl_Event7_Active_Flag_ := MAP(__PP331461.Vl_Event7_Count_ > 0=>1,0);
    SELF.Vl_Event7_All_Active_Flag_ := MAP(__PP331461.Vl_Event7_All_Count_ > 0=>1,0);
    SELF := __PP331461;
  END;
  EXPORT __ENH_Internet_Protocol := PROJECT(__EE331460,__ND331465__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Internet_Protocol::Annotated',EXPIRE(30));
  SHARED __EE526423 := __ENH_Internet_Protocol;
  SHARED IDX_Internet_Protocol_UID_Layout := RECORD
    KEL.typ.uid UID;
    __EE526423._r_Customer_;
    __EE526423.Source_Customers_;
    __EE526423.Ip_Address_;
    __EE526423.Otto_Ip_Address_Id_;
    __EE526423._host_;
    __EE526423._alias_;
    __EE526423._location_;
    __EE526423._ip__address_;
    __EE526423._ip__address__date_;
    __EE526423._version_;
    __EE526423._class_;
    __EE526423._subnet__mask_;
    __EE526423._reserved_;
    __EE526423._isp_;
    __EE526423._v2__validationipproblems_;
    __EE526423._v2__ipstate_;
    __EE526423._v2__ipcountry_;
    __EE526423._v2__ipcontinent_;
    __EE526423.Customer_Id_;
    __EE526423.Industry_Type_;
    __EE526423.Source_Customer_Count_;
    __EE526423.Entity_Context_Uid_;
    __EE526423.Label_;
    __EE526423.Entity_Type_;
    __EE526423.Identity_Count_;
    __EE526423.Event_Count_;
    __EE526423.Kr_High_Risk_Flag_;
    __EE526423.Kr_Medium_Risk_Flag_;
    __EE526423.Vl_Event1_All_Count_;
    __EE526423.Vl_Event7_All_Count_;
    __EE526423.Vl_Event30_All_Day_Count_;
    __EE526423.Vl_Event365_All_Day_Count_;
    __EE526423.Vl_Event7_All_Active_Flag_;
    __EE526423.Vl_Event30_All_Active_Flag_;
    __EE526423.Vl_Event1_Count_;
    __EE526423.Vl_Event7_Count_;
    __EE526423.Vl_Event30_Count_;
    __EE526423.Vl_Event365_Count_;
    __EE526423.Vl_Event7_Active_Flag_;
    __EE526423.Vl_Event30_Active_Flag_;
    __EE526423.Cl_Active7_Identity_Count_;
    __EE526423.Cl_Active30_Identity_Count_;
    __EE526423.Cl_Event_Count_;
    __EE526423.Cl_Identity_Count_;
    __EE526423.Cl_Element_Count_;
    __EE526423.Cl_Identity_Count_Percentile_;
    __EE526423.Cl_Event_Count_Percentile_;
    __EE526423.Cl_Active30_Identity_Count_Percentile_;
    __EE526423.Cl_Active7_Identity_Count_Percentile_;
    __EE526423.Cl_Impact_Weight_;
    __EE526423.Score_;
    __EE526423.Cluster_Score_;
    __EE526423.Date_First_Seen_;
    __EE526423.Date_Last_Seen_;
    __EE526423.__RecordCount;
  END;
  SHARED IDX_Internet_Protocol_UID_Projected := PROJECT(__EE526423,TRANSFORM(IDX_Internet_Protocol_UID_Layout,SELF.UID:=__T(LEFT.UID),SELF:=LEFT));
  EXPORT IDX_Internet_Protocol_UID := INDEX(IDX_Internet_Protocol_UID_Projected,{UID},{IDX_Internet_Protocol_UID_Projected},'~key::KEL::KELOtto::Internet_Protocol::UID');
  EXPORT IDX_Internet_Protocol_UID_Build := BUILD(IDX_Internet_Protocol_UID,OVERWRITE);
  EXPORT __ST526425_Layout := RECORDOF(IDX_Internet_Protocol_UID);
  EXPORT IDX_Internet_Protocol_UID_Wrapped := PROJECT(IDX_Internet_Protocol_UID,TRANSFORM(__ST12423_Layout,SELF.UID := __CN(LEFT.UID),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Internet_Protocol_UID_Build);
END;
