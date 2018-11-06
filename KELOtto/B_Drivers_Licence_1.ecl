﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Drivers_Licence_2,B_Event_2,B_Event_5,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_Licence,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Drivers_Licence_1 := MODULE
  SHARED VIRTUAL TYPEOF(B_Drivers_Licence_2.__ENH_Drivers_Licence_2) __ENH_Drivers_Licence_2 := B_Drivers_Licence_2.__ENH_Drivers_Licence_2;
  SHARED VIRTUAL TYPEOF(B_Event_2.__ENH_Event_2) __ENH_Event_2 := B_Event_2.__ENH_Event_2;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE140873 := __ENH_Drivers_Licence_2;
  SHARED __EE144315 := __ENH_Event_2;
  SHARED __EE144313 := __E_Person_Event;
  SHARED __EE144558 := __EE144313(__NN(__EE144313.Licence_) AND __NN(__EE144313.Transaction_));
  SHARED __ST142728_Layout := RECORD
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
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ntyp(E_Person.Typ) Subject__1_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) Social_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.ntyp(E_Address.Typ) Location__1_;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) Ip_;
    KEL.typ.ntyp(E_Bank.Typ) Routing_Bank_;
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.ntyp(E_Drivers_Licence.Typ) Licence_;
    KEL.typ.nkdate Event_Date__1_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC144576(B_Event_5.__ST13228_Layout __EE144315, E_Person_Event.Layout __EE144558) := __EEQP(__EE144558.Transaction_,__EE144315.UID);
  __ST142728_Layout __JT144576(B_Event_5.__ST13228_Layout __l, E_Person_Event.Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF.Subject__1_ := __r.Subject_;
    SELF.Location__1_ := __r.Location_;
    SELF.Event_Date__1_ := __r.Event_Date_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE144577 := JOIN(__EE144315,__EE144558,__JC144576(LEFT,RIGHT),__JT144576(LEFT,RIGHT),INNER,HASH);
  SHARED __ST142363_Layout := RECORD
    KEL.typ.ntyp(E_Drivers_Licence.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) Social_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) Ip_;
    KEL.typ.ntyp(E_Bank.Typ) Routing_Bank_;
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.ntyp(E_Drivers_Licence.Typ) Licence_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Age_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST142363_Layout __ND144679__Project(__ST142728_Layout __PP144578) := TRANSFORM
    SELF.UID := __PP144578.Licence_;
    SELF._r_Customer_ := __PP144578._r_Customer__1_;
    SELF.Subject_ := __PP144578.Subject__1_;
    SELF.Location_ := __PP144578.Location__1_;
    SELF.Event_Date_ := __PP144578.Event_Date__1_;
    SELF.U_I_D__1_ := __PP144578.UID;
    SELF := __PP144578;
  END;
  SHARED __EE144744 := PROJECT(__EE144577,__ND144679__Project(LEFT));
  SHARED __ST142424_Layout := RECORD
    KEL.typ.ntyp(E_Drivers_Licence.Typ) UID;
    KEL.typ.nbool Exp1_;
    KEL.typ.nbool Exp2_;
    KEL.typ.nbool Exp3_;
    KEL.typ.nbool Exp4_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST142424_Layout __ND145401__Project(__ST142363_Layout __PP144745) := TRANSFORM
    SELF.Exp1_ := __OP2(__PP144745.Age_,<,__CN(31));
    SELF.Exp2_ := __AND(__OP2(__PP144745.Age_,<,__CN(31)),__CN(__PP144745.In_Customer_Population_ = 1));
    SELF.Exp3_ := __OP2(__PP144745.Age_,<,__CN(8));
    SELF.Exp4_ := __AND(__OP2(__PP144745.Age_,<,__CN(8)),__CN(__PP144745.In_Customer_Population_ = 1));
    SELF := __PP144745;
  END;
  SHARED __EE145418 := PROJECT(__EE144744,__ND145401__Project(LEFT));
  SHARED __ST142454_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Drivers_Licence.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE145453 := PROJECT(__CLEANANDDO(__EE145418,TABLE(__EE145418,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP,__T(__EE145418.Exp1_)),KEL.typ.int C_O_U_N_T___Exp1__1_ := COUNT(GROUP,__T(__EE145418.Exp2_)),KEL.typ.int C_O_U_N_T___Exp1__2_ := COUNT(GROUP,__T(__EE145418.Exp3_)),KEL.typ.int C_O_U_N_T___Exp1__3_ := COUNT(GROUP,__T(__EE145418.Exp4_)),UID},UID,MERGE)),__ST142454_Layout);
  SHARED __ST142917_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Drivers_Licence.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr State_;
    KEL.typ.nint Otto_Drivers_Licence_Id_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Drivers_Licence.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC145459(B_Drivers_Licence_2.__ST11980_Layout __EE140873, __ST142454_Layout __EE145453) := __EEQP(__EE140873.UID,__EE145453.UID);
  __ST142917_Layout __JT145459(B_Drivers_Licence_2.__ST11980_Layout __l, __ST142454_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE145480 := JOIN(__EE140873,__EE145453,__JC145459(LEFT,RIGHT),__JT145459(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE145061 := __EE140873;
  SHARED __ST142030_Layout := RECORD
    KEL.typ.nint Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE145074 := PROJECT(__EE145061,TRANSFORM(__ST142030_Layout,SELF.Exp1_ := __CN(LEFT.Cl_Identity_Count_),SELF := LEFT));
  SHARED __EE145077 := KEL.Routines.KELbucketTable(__EE145074,'',Exp1_,TRUE,10,D_E_C_I_L_E___Cl_Identity_Count_,0,'',0,'',FALSE);
  SHARED __ST142018_Layout := RECORD
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint D_E_C_I_L_E___Cl_Identity_Count_;
  END;
  SHARED __EE145092 := PROJECT(__EE145077,TRANSFORM(__ST142018_Layout,SELF.Cl_Identity_Count_ := __T(LEFT.Exp1_),SELF := LEFT));
  SHARED __ST143046_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Drivers_Licence.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr State_;
    KEL.typ.nint Otto_Drivers_Licence_Id_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Drivers_Licence.Typ) U_I_D__1_;
    KEL.typ.int Cl_Identity_Count__1_ := 0;
    KEL.typ.nint D_E_C_I_L_E___Cl_Identity_Count_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC145486(__ST142917_Layout __EE145480, __ST142018_Layout __EE145092) := __EE145480.Cl_Identity_Count_ = __EE145092.Cl_Identity_Count_;
  __ST143046_Layout __JT145486(__ST142917_Layout __l, __ST142018_Layout __r) := TRANSFORM
    SELF.Cl_Identity_Count__1_ := __r.Cl_Identity_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE145509 := JOIN(__EE145480,__EE145092,__JC145486(LEFT,RIGHT),__JT145486(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE145058 := __EE140873;
  SHARED __ST141923_Layout := RECORD
    KEL.typ.nint Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE145133 := PROJECT(__EE145058,TRANSFORM(__ST141923_Layout,SELF.Exp1_ := __CN(LEFT.Cl_Event_Count_),SELF := LEFT));
  SHARED __EE145136 := KEL.Routines.KELbucketTable(__EE145133,'',Exp1_,TRUE,100,P_E_R_C_E_N_T_I_L_E___Cl_Event_Count_,0,'',0,'',FALSE);
  SHARED __ST141911_Layout := RECORD
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Event_Count_;
  END;
  SHARED __EE145151 := PROJECT(__EE145136,TRANSFORM(__ST141911_Layout,SELF.Cl_Event_Count_ := __T(LEFT.Exp1_),SELF := LEFT));
  SHARED __ST143174_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Drivers_Licence.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr State_;
    KEL.typ.nint Otto_Drivers_Licence_Id_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Drivers_Licence.Typ) U_I_D__1_;
    KEL.typ.int Cl_Identity_Count__1_ := 0;
    KEL.typ.nint D_E_C_I_L_E___Cl_Identity_Count_;
    KEL.typ.int Cl_Event_Count__1_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Event_Count_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC145515(__ST143046_Layout __EE145509, __ST141911_Layout __EE145151) := __EE145509.Cl_Event_Count_ = __EE145151.Cl_Event_Count_;
  __ST143174_Layout __JT145515(__ST143046_Layout __l, __ST141911_Layout __r) := TRANSFORM
    SELF.Cl_Event_Count__1_ := __r.Cl_Event_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE145540 := JOIN(__EE145509,__EE145151,__JC145515(LEFT,RIGHT),__JT145515(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE145055 := __EE140873;
  SHARED __ST141818_Layout := RECORD
    KEL.typ.nint Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE145196 := PROJECT(__EE145055,TRANSFORM(__ST141818_Layout,SELF.Exp1_ := __CN(LEFT.Cl_Active7_Identity_Count_),SELF := LEFT));
  SHARED __EE145199 := KEL.Routines.KELbucketTable(__EE145196,'',Exp1_,TRUE,100,P_E_R_C_E_N_T_I_L_E___Cl_Active7_Identity_Count_,0,'',0,'',FALSE);
  SHARED __ST141806_Layout := RECORD
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Active7_Identity_Count_;
  END;
  SHARED __EE145214 := PROJECT(__EE145199,TRANSFORM(__ST141806_Layout,SELF.Cl_Active7_Identity_Count_ := __T(LEFT.Exp1_),SELF := LEFT));
  SHARED __ST143301_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Drivers_Licence.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr State_;
    KEL.typ.nint Otto_Drivers_Licence_Id_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Drivers_Licence.Typ) U_I_D__1_;
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
  __JC145546(__ST143174_Layout __EE145540, __ST141806_Layout __EE145214) := __EE145540.Cl_Active7_Identity_Count_ = __EE145214.Cl_Active7_Identity_Count_;
  __ST143301_Layout __JT145546(__ST143174_Layout __l, __ST141806_Layout __r) := TRANSFORM
    SELF.Cl_Active7_Identity_Count__1_ := __r.Cl_Active7_Identity_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE145573 := JOIN(__EE145540,__EE145214,__JC145546(LEFT,RIGHT),__JT145546(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE145052 := __EE140873;
  SHARED __ST141694_Layout := RECORD
    KEL.typ.nint Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE145261 := PROJECT(__EE145052,TRANSFORM(__ST141694_Layout,SELF.Exp1_ := __CN(LEFT.Cl_Active30_Identity_Count_),SELF := LEFT));
  SHARED __EE145264 := KEL.Routines.KELbucketTable(__EE145261,'',Exp1_,TRUE,100,P_E_R_C_E_N_T_I_L_E___Cl_Active30_Identity_Count_,0,'',0,'',FALSE);
  SHARED __ST141682_Layout := RECORD
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Active30_Identity_Count_;
  END;
  SHARED __EE145279 := PROJECT(__EE145264,TRANSFORM(__ST141682_Layout,SELF.Cl_Active30_Identity_Count_ := __T(LEFT.Exp1_),SELF := LEFT));
  SHARED __ST143427_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Drivers_Licence.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr State_;
    KEL.typ.nint Otto_Drivers_Licence_Id_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Drivers_Licence.Typ) U_I_D__1_;
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
  __JC145579(__ST143301_Layout __EE145573, __ST141682_Layout __EE145279) := __EE145573.Cl_Active30_Identity_Count_ = __EE145279.Cl_Active30_Identity_Count_;
  __ST143427_Layout __JT145579(__ST143301_Layout __l, __ST141682_Layout __r) := TRANSFORM
    SELF.Cl_Active30_Identity_Count__1_ := __r.Cl_Active30_Identity_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE145608 := JOIN(__EE145573,__EE145279,__JC145579(LEFT,RIGHT),__JT145579(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST11308_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Drivers_Licence.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr State_;
    KEL.typ.nint Otto_Drivers_Licence_Id_;
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
  SHARED __ST11308_Layout __ND145613__Project(__ST143427_Layout __PP145609) := TRANSFORM
    SELF.Cl_Active30_Identity_Count_Percentile_ := __PP145609.P_E_R_C_E_N_T_I_L_E___Cl_Active30_Identity_Count_;
    SELF.Cl_Active7_Identity_Count_Percentile_ := __PP145609.P_E_R_C_E_N_T_I_L_E___Cl_Active7_Identity_Count_;
    SELF.Cl_Event_Count_Percentile_ := __PP145609.P_E_R_C_E_N_T_I_L_E___Cl_Event_Count_;
    SELF.Cl_Identity_Count_Percentile_ := __PP145609.D_E_C_I_L_E___Cl_Identity_Count_;
    SELF.Vl_Event30_All_Day_Count_ := __PP145609.C_O_U_N_T___Exp1_;
    SELF.Vl_Event30_Count_ := __PP145609.C_O_U_N_T___Exp1__1_;
    SELF.Vl_Event7_All_Count_ := __PP145609.C_O_U_N_T___Exp1__2_;
    SELF.Vl_Event7_Count_ := __PP145609.C_O_U_N_T___Exp1__3_;
    SELF := __PP145609;
  END;
  EXPORT __ENH_Drivers_Licence_1 := PROJECT(__EE145608,__ND145613__Project(LEFT));
END;
