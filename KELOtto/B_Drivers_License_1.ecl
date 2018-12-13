﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Drivers_License_2,B_Event_2,B_Event_5,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Drivers_License_1 := MODULE
  SHARED VIRTUAL TYPEOF(B_Drivers_License_2.__ENH_Drivers_License_2) __ENH_Drivers_License_2 := B_Drivers_License_2.__ENH_Drivers_License_2;
  SHARED VIRTUAL TYPEOF(B_Event_2.__ENH_Event_2) __ENH_Event_2 := B_Event_2.__ENH_Event_2;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE146412 := __ENH_Drivers_License_2;
  SHARED __EE149858 := __ENH_Event_2;
  SHARED __EE149856 := __E_Person_Event;
  SHARED __EE150101 := __EE149856(__NN(__EE149856.Licence_) AND __NN(__EE149856.Transaction_));
  SHARED __ST148267_Layout := RECORD
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
    KEL.typ.ntyp(E_Drivers_License.Typ) Licence_;
    KEL.typ.nkdate Event_Date__1_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC150119(B_Event_5.__ST13838_Layout __EE149858, E_Person_Event.Layout __EE150101) := __EEQP(__EE150101.Transaction_,__EE149858.UID);
  __ST148267_Layout __JT150119(B_Event_5.__ST13838_Layout __l, E_Person_Event.Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF.Subject__1_ := __r.Subject_;
    SELF.Location__1_ := __r.Location_;
    SELF.Event_Date__1_ := __r.Event_Date_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE150120 := JOIN(__EE150101,__EE149858,__JC150119(RIGHT,LEFT),__JT150119(RIGHT,LEFT),INNER,HASH);
  SHARED __ST147902_Layout := RECORD
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
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
  SHARED __ST147902_Layout __ND150223__Project(__ST148267_Layout __PP150121) := TRANSFORM
    SELF.UID := __PP150121.Licence_;
    SELF._r_Customer_ := __PP150121._r_Customer__1_;
    SELF.Subject_ := __PP150121.Subject__1_;
    SELF.Location_ := __PP150121.Location__1_;
    SELF.Event_Date_ := __PP150121.Event_Date__1_;
    SELF.U_I_D__1_ := __PP150121.UID;
    SELF := __PP150121;
  END;
  SHARED __EE150288 := PROJECT(__EE150120,__ND150223__Project(LEFT));
  SHARED __ST147963_Layout := RECORD
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.nbool Exp1_;
    KEL.typ.nbool Exp2_;
    KEL.typ.nbool Exp3_;
    KEL.typ.nbool Exp4_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST147963_Layout __ND150945__Project(__ST147902_Layout __PP150289) := TRANSFORM
    SELF.Exp1_ := __OP2(__PP150289.Age_,<,__CN(31));
    SELF.Exp2_ := __AND(__OP2(__PP150289.Age_,<,__CN(31)),__CN(__PP150289.In_Customer_Population_ = 1));
    SELF.Exp3_ := __OP2(__PP150289.Age_,<,__CN(8));
    SELF.Exp4_ := __AND(__OP2(__PP150289.Age_,<,__CN(8)),__CN(__PP150289.In_Customer_Population_ = 1));
    SELF := __PP150289;
  END;
  SHARED __EE150962 := PROJECT(__EE150288,__ND150945__Project(LEFT));
  SHARED __ST147993_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE150997 := PROJECT(__CLEANANDDO(__EE150962,TABLE(__EE150962,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP,__T(__EE150962.Exp1_)),KEL.typ.int C_O_U_N_T___Exp1__1_ := COUNT(GROUP,__T(__EE150962.Exp2_)),KEL.typ.int C_O_U_N_T___Exp1__2_ := COUNT(GROUP,__T(__EE150962.Exp3_)),KEL.typ.int C_O_U_N_T___Exp1__3_ := COUNT(GROUP,__T(__EE150962.Exp4_)),UID},UID,MERGE)),__ST147993_Layout);
  SHARED __ST148457_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Drivers_License.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr State_;
    KEL.typ.nint Otto_Drivers_License_Id_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC151003(B_Drivers_License_2.__ST12527_Layout __EE146412, __ST147993_Layout __EE150997) := __EEQP(__EE146412.UID,__EE150997.UID);
  __ST148457_Layout __JT151003(B_Drivers_License_2.__ST12527_Layout __l, __ST147993_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE151024 := JOIN(__EE146412,__EE150997,__JC151003(LEFT,RIGHT),__JT151003(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE150605 := __EE146412;
  SHARED __ST147569_Layout := RECORD
    KEL.typ.nint Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE150618 := PROJECT(__EE150605,TRANSFORM(__ST147569_Layout,SELF.Exp1_ := __CN(LEFT.Cl_Identity_Count_),SELF := LEFT));
  SHARED __EE150621 := KEL.Routines.KELbucketTable(__EE150618,'',Exp1_,TRUE,10,D_E_C_I_L_E___Cl_Identity_Count_,0,'',0,'',FALSE);
  SHARED __ST147557_Layout := RECORD
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint D_E_C_I_L_E___Cl_Identity_Count_;
  END;
  SHARED __EE150636 := PROJECT(__EE150621,TRANSFORM(__ST147557_Layout,SELF.Cl_Identity_Count_ := __T(LEFT.Exp1_),SELF := LEFT));
  SHARED __ST148586_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Drivers_License.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr State_;
    KEL.typ.nint Otto_Drivers_License_Id_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) U_I_D__1_;
    KEL.typ.int Cl_Identity_Count__1_ := 0;
    KEL.typ.nint D_E_C_I_L_E___Cl_Identity_Count_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC151030(__ST148457_Layout __EE151024, __ST147557_Layout __EE150636) := __EE151024.Cl_Identity_Count_ = __EE150636.Cl_Identity_Count_;
  __ST148586_Layout __JT151030(__ST148457_Layout __l, __ST147557_Layout __r) := TRANSFORM
    SELF.Cl_Identity_Count__1_ := __r.Cl_Identity_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE151053 := JOIN(__EE151024,__EE150636,__JC151030(LEFT,RIGHT),__JT151030(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE150602 := __EE146412;
  SHARED __ST147462_Layout := RECORD
    KEL.typ.nint Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE150677 := PROJECT(__EE150602,TRANSFORM(__ST147462_Layout,SELF.Exp1_ := __CN(LEFT.Cl_Event_Count_),SELF := LEFT));
  SHARED __EE150680 := KEL.Routines.KELbucketTable(__EE150677,'',Exp1_,TRUE,100,P_E_R_C_E_N_T_I_L_E___Cl_Event_Count_,0,'',0,'',FALSE);
  SHARED __ST147450_Layout := RECORD
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Event_Count_;
  END;
  SHARED __EE150695 := PROJECT(__EE150680,TRANSFORM(__ST147450_Layout,SELF.Cl_Event_Count_ := __T(LEFT.Exp1_),SELF := LEFT));
  SHARED __ST148714_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Drivers_License.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr State_;
    KEL.typ.nint Otto_Drivers_License_Id_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) U_I_D__1_;
    KEL.typ.int Cl_Identity_Count__1_ := 0;
    KEL.typ.nint D_E_C_I_L_E___Cl_Identity_Count_;
    KEL.typ.int Cl_Event_Count__1_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Event_Count_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC151059(__ST148586_Layout __EE151053, __ST147450_Layout __EE150695) := __EE151053.Cl_Event_Count_ = __EE150695.Cl_Event_Count_;
  __ST148714_Layout __JT151059(__ST148586_Layout __l, __ST147450_Layout __r) := TRANSFORM
    SELF.Cl_Event_Count__1_ := __r.Cl_Event_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE151084 := JOIN(__EE151053,__EE150695,__JC151059(LEFT,RIGHT),__JT151059(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE150599 := __EE146412;
  SHARED __ST147357_Layout := RECORD
    KEL.typ.nint Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE150740 := PROJECT(__EE150599,TRANSFORM(__ST147357_Layout,SELF.Exp1_ := __CN(LEFT.Cl_Active7_Identity_Count_),SELF := LEFT));
  SHARED __EE150743 := KEL.Routines.KELbucketTable(__EE150740,'',Exp1_,TRUE,100,P_E_R_C_E_N_T_I_L_E___Cl_Active7_Identity_Count_,0,'',0,'',FALSE);
  SHARED __ST147345_Layout := RECORD
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Active7_Identity_Count_;
  END;
  SHARED __EE150758 := PROJECT(__EE150743,TRANSFORM(__ST147345_Layout,SELF.Cl_Active7_Identity_Count_ := __T(LEFT.Exp1_),SELF := LEFT));
  SHARED __ST148841_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Drivers_License.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr State_;
    KEL.typ.nint Otto_Drivers_License_Id_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) U_I_D__1_;
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
  __JC151090(__ST148714_Layout __EE151084, __ST147345_Layout __EE150758) := __EE151084.Cl_Active7_Identity_Count_ = __EE150758.Cl_Active7_Identity_Count_;
  __ST148841_Layout __JT151090(__ST148714_Layout __l, __ST147345_Layout __r) := TRANSFORM
    SELF.Cl_Active7_Identity_Count__1_ := __r.Cl_Active7_Identity_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE151117 := JOIN(__EE151084,__EE150758,__JC151090(LEFT,RIGHT),__JT151090(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE150596 := __EE146412;
  SHARED __ST147233_Layout := RECORD
    KEL.typ.nint Exp1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE150805 := PROJECT(__EE150596,TRANSFORM(__ST147233_Layout,SELF.Exp1_ := __CN(LEFT.Cl_Active30_Identity_Count_),SELF := LEFT));
  SHARED __EE150808 := KEL.Routines.KELbucketTable(__EE150805,'',Exp1_,TRUE,100,P_E_R_C_E_N_T_I_L_E___Cl_Active30_Identity_Count_,0,'',0,'',FALSE);
  SHARED __ST147221_Layout := RECORD
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint P_E_R_C_E_N_T_I_L_E___Cl_Active30_Identity_Count_;
  END;
  SHARED __EE150823 := PROJECT(__EE150808,TRANSFORM(__ST147221_Layout,SELF.Cl_Active30_Identity_Count_ := __T(LEFT.Exp1_),SELF := LEFT));
  SHARED __ST148967_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Drivers_License.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr State_;
    KEL.typ.nint Otto_Drivers_License_Id_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) U_I_D__1_;
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
  __JC151123(__ST148841_Layout __EE151117, __ST147221_Layout __EE150823) := __EE151117.Cl_Active30_Identity_Count_ = __EE150823.Cl_Active30_Identity_Count_;
  __ST148967_Layout __JT151123(__ST148841_Layout __l, __ST147221_Layout __r) := TRANSFORM
    SELF.Cl_Active30_Identity_Count__1_ := __r.Cl_Active30_Identity_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE151152 := JOIN(__EE151117,__EE150823,__JC151123(LEFT,RIGHT),__JT151123(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST11833_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Drivers_License.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr State_;
    KEL.typ.nint Otto_Drivers_License_Id_;
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
  SHARED __ST11833_Layout __ND151157__Project(__ST148967_Layout __PP151153) := TRANSFORM
    SELF.Cl_Active30_Identity_Count_Percentile_ := __PP151153.P_E_R_C_E_N_T_I_L_E___Cl_Active30_Identity_Count_;
    SELF.Cl_Active7_Identity_Count_Percentile_ := __PP151153.P_E_R_C_E_N_T_I_L_E___Cl_Active7_Identity_Count_;
    SELF.Cl_Event_Count_Percentile_ := __PP151153.P_E_R_C_E_N_T_I_L_E___Cl_Event_Count_;
    SELF.Cl_Identity_Count_Percentile_ := __PP151153.D_E_C_I_L_E___Cl_Identity_Count_;
    SELF.Vl_Event30_All_Day_Count_ := __PP151153.C_O_U_N_T___Exp1_;
    SELF.Vl_Event30_Count_ := __PP151153.C_O_U_N_T___Exp1__1_;
    SELF.Vl_Event7_All_Count_ := __PP151153.C_O_U_N_T___Exp1__2_;
    SELF.Vl_Event7_Count_ := __PP151153.C_O_U_N_T___Exp1__3_;
    SELF := __PP151153;
  END;
  EXPORT __ENH_Drivers_License_1 := PROJECT(__EE151152,__ND151157__Project(LEFT));
END;
