﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Person_3,E_Customer,E_Drivers_License,E_Person,E_Person_Drivers_License,E_Person_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Drivers_License_2 := MODULE
  SHARED VIRTUAL TYPEOF(E_Drivers_License.__Result) __E_Drivers_License := E_Drivers_License.__Result;
  SHARED VIRTUAL TYPEOF(B_Person_3.__ENH_Person_3) __ENH_Person_3 := B_Person_3.__ENH_Person_3;
  SHARED VIRTUAL TYPEOF(E_Person_Drivers_License.__Result) __E_Person_Drivers_License := E_Person_Drivers_License.__Result;
  SHARED VIRTUAL TYPEOF(E_Person_Person.__Result) __E_Person_Person := E_Person_Person.__Result;
  SHARED __EE102303 := __E_Drivers_License;
  SHARED __EE103345 := __E_Person_Person;
  SHARED __EE106917 := __EE103345(__NN(__EE103345.From_Person_));
  SHARED __EE102352 := __E_Person_Drivers_License;
  SHARED __EE108336 := __EE102352(__NN(__EE102352.License_) AND __NN(__EE102352.Subject_));
  SHARED __ST109303_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Drivers_License.Typ) License_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE109307 := DEDUP(PROJECT(__EE108336,__ST109303_Layout),ALL);
  SHARED __ST109350_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.nint Self_Match_;
    KEL.typ.nint Contributory_Records_;
    KEL.typ.nint Same_Address_Email_Match_;
    KEL.typ.nint Same_Address_Ssn_Match_;
    KEL.typ.nint Same_Address_Phone_Number_Match_;
    KEL.typ.nint Same_Address_Same_Day_Count_;
    KEL.typ.nint High_Frequency_Same_Address_Same_Day_Count_;
    KEL.typ.nint Non_High_Frequency_Address_Count_;
    KEL.typ.nint Non_High_Frequency_Same_Address_Same_Day_Count_;
    KEL.typ.nint Shared_Address_Count_;
    KEL.typ.nstr Verified_P_R_Type_;
    KEL.typ.nstr Verified_P_Rconfidence_;
    KEL.typ.nbool Verified_P_R_Personal_;
    KEL.typ.nbool Verified_P_R_Business_;
    KEL.typ.nbool Verified_P_R_Other_;
    KEL.typ.nbool Verified_P_R_Is_Relative_;
    KEL.typ.nbool Verified_P_R_Is_Associate_;
    KEL.typ.nbool Verified_P_R_Is_Business_;
    KEL.typ.nfloat Verified_P_R_Degree_;
    KEL.typ.nint Verified_P_R_Hit_;
    KEL.typ.nint Verified_P_R_Relationship_Code_;
    KEL.typ.nint Verified_P_R_Relationship_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Drivers_License.Typ) License_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC109318(E_Person_Person.Layout __EE106917, __ST109303_Layout __EE109307) := __EEQP(__EE109307.Subject_,__EE106917.From_Person_);
  __ST109350_Layout __JT109318(E_Person_Person.Layout __l, __ST109303_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE109348 := JOIN(__EE106917,__EE109307,__JC109318(LEFT,RIGHT),__JT109318(LEFT,RIGHT),INNER,HASH);
  SHARED __ST104687_Layout := RECORD
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE109391 := DEDUP(PROJECT(__EE109348,TRANSFORM(__ST104687_Layout,SELF.UID := LEFT.License_,SELF := LEFT)),ALL);
  SHARED __ST104705_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE109404 := PROJECT(__CLEANANDDO(__EE109391,TABLE(__EE109391,{KEL.typ.int C_O_U_N_T___Person_Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST104705_Layout);
  SHARED __ST105546_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Drivers_License.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr State_;
    KEL.typ.nint Otto_Drivers_License_Id_;
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC109410(E_Drivers_License.Layout __EE102303, __ST104705_Layout __EE109404) := __EEQP(__EE102303.UID,__EE109404.UID);
  __ST105546_Layout __JT109410(E_Drivers_License.Layout __l, __ST104705_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE109424 := JOIN(__EE102303,__EE109404,__JC109410(LEFT,RIGHT),__JT109410(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE102368 := __ENH_Person_3;
  SHARED __EE108477 := __EE102368;
  SHARED __EE108486 := __EE108336;
  SHARED __ST104980_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.nint Lex_Id_;
    KEL.typ.ndataset(E_Person.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ndataset(E_Person.Reported_Date_Of_Birth_Layout) Reported_Date_Of_Birth_;
    KEL.typ.ndataset(E_Person.Full_Name_Layout) Full_Name_;
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
    KEL.typ.nstr _curr__incar__flag_;
    KEL.typ.nint _name__ssn__dob__match_;
    KEL.typ.ndataset(E_Person.Offenses_Layout) Offenses_;
    KEL.typ.int Death_Prior_To_All_Events_ := 0;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.nfloat Deceased_Event_Percent_;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.int Event_Count_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Ip_Hosted_ := 0;
    KEL.typ.int Ip_Not_Us_ := 0;
    KEL.typ.int Ip_Tor_ := 0;
    KEL.typ.int Ip_Vpn_ := 0;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.nint Max_Deceased_To_Event_Diff_;
    KEL.typ.int Nas9_Flag_ := 0;
    KEL.typ.int Vl_Event30_Active_Flag_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event7_Active_Flag_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Drivers_License.Typ) License_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC108586(B_Person_3.__ST21750_Layout __EE108477, E_Person_Drivers_License.Layout __EE108486) := __EEQP(__EE108486.Subject_,__EE108477.UID);
  __ST104980_Layout __JT108586(B_Person_3.__ST21750_Layout __l, E_Person_Drivers_License.Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE108587 := JOIN(__EE108486,__EE108477,__JC108586(RIGHT,LEFT),__JT108586(RIGHT,LEFT),INNER,HASH);
  SHARED __ST104101_Layout := RECORD
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Drivers_License.Typ) License_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.nint Lex_Id_;
    KEL.typ.ndataset(E_Person.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ndataset(E_Person.Reported_Date_Of_Birth_Layout) Reported_Date_Of_Birth_;
    KEL.typ.ndataset(E_Person.Full_Name_Layout) Full_Name_;
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
    KEL.typ.nstr _curr__incar__flag_;
    KEL.typ.nint _name__ssn__dob__match_;
    KEL.typ.ndataset(E_Person.Offenses_Layout) Offenses_;
    KEL.typ.int Death_Prior_To_All_Events_ := 0;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.nfloat Deceased_Event_Percent_;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.int Event_Count_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Ip_Hosted_ := 0;
    KEL.typ.int Ip_Not_Us_ := 0;
    KEL.typ.int Ip_Tor_ := 0;
    KEL.typ.int Ip_Vpn_ := 0;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.nint Max_Deceased_To_Event_Diff_;
    KEL.typ.int Nas9_Flag_ := 0;
    KEL.typ.int Vl_Event30_Active_Flag_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event7_Active_Flag_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST104101_Layout __ND108696__Project(__ST104980_Layout __PP108588) := TRANSFORM
    SELF.UID := __PP108588.License_;
    SELF._r_Customer_ := __PP108588._r_Customer__1_;
    SELF.U_I_D__1_ := __PP108588.UID;
    SELF._r_Customer__1_ := __PP108588._r_Customer_;
    SELF := __PP108588;
  END;
  SHARED __EE109079 := PROJECT(__EE108587,__ND108696__Project(LEFT));
  SHARED __ST104322_Layout := RECORD
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.int Event_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE109093 := PROJECT(__EE109079,__ST104322_Layout);
  SHARED __ST104337_Layout := RECORD
    KEL.typ.int S_U_M___Event_Count_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE109109 := PROJECT(__CLEANANDDO(__EE109093,TABLE(__EE109093,{KEL.typ.int S_U_M___Event_Count_ := SUM(GROUP,__EE109093.Event_Count_),UID},UID,MERGE)),__ST104337_Layout);
  SHARED __ST105633_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Drivers_License.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr State_;
    KEL.typ.nint Otto_Drivers_License_Id_;
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) U_I_D__1_;
    KEL.typ.int S_U_M___Event_Count_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) U_I_D__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC109443(__ST105546_Layout __EE109424, __ST104337_Layout __EE109109) := __EEQP(__EE109424.UID,__EE109109.UID);
  __ST105633_Layout __JT109443(__ST105546_Layout __l, __ST104337_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE109459 := JOIN(__EE109424,__EE109109,__JC109443(LEFT,RIGHT),__JT109443(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE108489 := __EE108336;
  SHARED __EE108471 := __EE102368;
  SHARED __EE109142 := __EE108471(__EE108471.Vl_Event7_Active_Flag_ = 1);
  __JC109150(E_Person_Drivers_License.Layout __EE108489, B_Person_3.__ST21750_Layout __EE109142) := __EEQP(__EE108489.Subject_,__EE109142.UID);
  SHARED __EE109151 := JOIN(__EE108489,__EE109142,__JC109150(LEFT,RIGHT),TRANSFORM(E_Person_Drivers_License.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST103656_Layout := RECORD
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE109169 := DEDUP(PROJECT(__EE109151,TRANSFORM(__ST103656_Layout,SELF.UID := LEFT.License_,SELF := LEFT)),ALL);
  SHARED __ST103674_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Drivers_License_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE109182 := PROJECT(__CLEANANDDO(__EE109169,TABLE(__EE109169,{KEL.typ.int C_O_U_N_T___Person_Drivers_License_ := COUNT(GROUP),UID},UID,MERGE)),__ST103674_Layout);
  SHARED __ST105719_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Drivers_License.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr State_;
    KEL.typ.nint Otto_Drivers_License_Id_;
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) U_I_D__1_;
    KEL.typ.int S_U_M___Event_Count_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Drivers_License_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) U_I_D__3_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC109480(__ST105633_Layout __EE109459, __ST103674_Layout __EE109182) := __EEQP(__EE109459.UID,__EE109182.UID);
  __ST105719_Layout __JT109480(__ST105633_Layout __l, __ST103674_Layout __r) := TRANSFORM
    SELF.U_I_D__3_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE109498 := JOIN(__EE109459,__EE109182,__JC109480(LEFT,RIGHT),__JT109480(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE103531 := __EE102368(__EE102368.Vl_Event30_Active_Flag_ = 1);
  __JC108354(E_Person_Drivers_License.Layout __EE108336, B_Person_3.__ST21750_Layout __EE103531) := __EEQP(__EE108336.Subject_,__EE103531.UID);
  SHARED __EE108355 := JOIN(__EE108336,__EE103531,__JC108354(LEFT,RIGHT),TRANSFORM(E_Person_Drivers_License.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST103463_Layout := RECORD
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE108373 := DEDUP(PROJECT(__EE108355,TRANSFORM(__ST103463_Layout,SELF.UID := LEFT.License_,SELF := LEFT)),ALL);
  SHARED __ST103481_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Drivers_License_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE108386 := PROJECT(__CLEANANDDO(__EE108373,TABLE(__EE108373,{KEL.typ.int C_O_U_N_T___Person_Drivers_License_ := COUNT(GROUP),UID},UID,MERGE)),__ST103481_Layout);
  SHARED __ST105804_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Drivers_License.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr State_;
    KEL.typ.nint Otto_Drivers_License_Id_;
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) U_I_D__1_;
    KEL.typ.int S_U_M___Event_Count_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Drivers_License_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) U_I_D__3_;
    KEL.typ.int C_O_U_N_T___Person_Drivers_License__1_ := 0;
    KEL.typ.ntyp(E_Drivers_License.Typ) U_I_D__4_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC109521(__ST105719_Layout __EE109498, __ST103481_Layout __EE108386) := __EEQP(__EE109498.UID,__EE108386.UID);
  __ST105804_Layout __JT109521(__ST105719_Layout __l, __ST103481_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Drivers_License__1_ := __r.C_O_U_N_T___Person_Drivers_License_;
    SELF.U_I_D__4_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE109543 := JOIN(__EE109498,__EE108386,__JC109521(LEFT,RIGHT),__JT109521(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST20503_Layout := RECORD
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST20503_Layout __ND109569__Project(__ST105804_Layout __PP109544) := TRANSFORM
    SELF.Cl_Active30_Identity_Count_ := __PP109544.C_O_U_N_T___Person_Drivers_License__1_;
    SELF.Cl_Active7_Identity_Count_ := __PP109544.C_O_U_N_T___Person_Drivers_License_;
    SELF.Cl_Event_Count_ := __PP109544.S_U_M___Event_Count_;
    SELF.Cl_Identity_Count_ := __PP109544.C_O_U_N_T___Person_Person_;
    SELF := __PP109544;
  END;
  EXPORT __ENH_Drivers_License_2 := PROJECT(__EE109543,__ND109569__Project(LEFT));
END;
