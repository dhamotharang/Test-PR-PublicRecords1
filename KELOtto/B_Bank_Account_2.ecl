﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Bank_3,B_Person_3,E_Bank,E_Bank_Account,E_Customer,E_Person,E_Person_Bank_Account,E_Person_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank_Account_2 := MODULE
  SHARED VIRTUAL TYPEOF(B_Bank_3.__ENH_Bank_3) __ENH_Bank_3 := B_Bank_3.__ENH_Bank_3;
  SHARED VIRTUAL TYPEOF(E_Bank_Account.__Result) __E_Bank_Account := E_Bank_Account.__Result;
  SHARED VIRTUAL TYPEOF(B_Person_3.__ENH_Person_3) __ENH_Person_3 := B_Person_3.__ENH_Person_3;
  SHARED VIRTUAL TYPEOF(E_Person_Bank_Account.__Result) __E_Person_Bank_Account := E_Person_Bank_Account.__Result;
  SHARED VIRTUAL TYPEOF(E_Person_Person.__Result) __E_Person_Person := E_Person_Person.__Result;
  SHARED __EE91563 := __E_Bank_Account;
  SHARED __EE91651 := __ENH_Person_3;
  SHARED __EE99649 := __EE91651;
  SHARED __EE91633 := __E_Person_Person;
  SHARED __EE99369 := __EE91633(__NN(__EE91633.To_Person_) AND __NN(__EE91633.From_Person_));
  SHARED __EE99667 := __EE99369;
  SHARED __EE91614 := __E_Person_Bank_Account;
  SHARED __EE99432 := __EE91614(__NN(__EE91614.Account_) AND __NN(__EE91614.Subject_));
  SHARED __ST100634_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE100638 := DEDUP(PROJECT(__EE99432,__ST100634_Layout),ALL);
  SHARED __ST100681_Layout := RECORD
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
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC102130(E_Person_Person.Layout __EE99667, __ST100634_Layout __EE100638) := __EEQP(__EE100638.Subject_,__EE99667.From_Person_);
  __ST100681_Layout __JT102130(E_Person_Person.Layout __l, __ST100634_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE102131 := JOIN(__EE99667,__EE100638,__JC102130(LEFT,RIGHT),__JT102130(LEFT,RIGHT),INNER,HASH);
  SHARED __ST94797_Layout := RECORD
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
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC102140(B_Person_3.__ST21742_Layout __EE99649, __ST100681_Layout __EE102131) := __EEQP(__EE102131.To_Person_,__EE99649.UID);
  __ST94797_Layout __JT102140(B_Person_3.__ST21742_Layout __l, __ST100681_Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE102141 := JOIN(__EE102131,__EE99649,__JC102140(RIGHT,LEFT),__JT102140(RIGHT,LEFT),INNER,HASH);
  SHARED __ST94105_Layout := RECORD
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.nint Lex_Id_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE102155 := DEDUP(PROJECT(__EE102141,TRANSFORM(__ST94105_Layout,SELF.UID := LEFT.Account_,SELF := LEFT)),ALL);
  SHARED __ST94123_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE102170 := PROJECT(__CLEANANDDO(__EE102155,TABLE(__EE102155,{KEL.typ.int C_O_U_N_T___Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST94123_Layout);
  SHARED __ST95524_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Bank_Account.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Bank.Typ) _r_Bank_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nint Otto_Bank_Account_Id_;
    KEL.typ.int C_O_U_N_T___Person_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC102179(E_Bank_Account.Layout __EE91563, __ST94123_Layout __EE102170) := __EEQP(__EE91563.UID,__EE102170.UID);
  __ST95524_Layout __JT102179(E_Bank_Account.Layout __l, __ST94123_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE102180 := JOIN(__EE91563,__EE102170,__JC102179(LEFT,RIGHT),__JT102179(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST93400_Layout := RECORD
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.nuid U_I_D__1_;
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
    KEL.typ.nuid To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST93400_Layout __ND102185__Project(__ST94797_Layout __PP102181) := TRANSFORM
    SELF.UID := __PP102181.Account_;
    SELF.U_I_D__1_ := __PP102181.UID;
    SELF.To_Person_ := __PP102181.UID;
    SELF := __PP102181;
  END;
  SHARED __EE102554 := DEDUP(PROJECT(__EE102141,__ND102185__Project(LEFT)),ALL);
  SHARED __ST93613_Layout := RECORD
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.int Event_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE102568 := PROJECT(__EE102554,__ST93613_Layout);
  SHARED __ST93628_Layout := RECORD
    KEL.typ.int S_U_M___Event_Count_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE102585 := PROJECT(__CLEANANDDO(__EE102568,TABLE(__EE102568,{KEL.typ.int S_U_M___Event_Count_ := SUM(GROUP,__EE102568.Event_Count_),UID},UID,MERGE)),__ST93628_Layout);
  SHARED __ST95618_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Bank_Account.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Bank.Typ) _r_Bank_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nint Otto_Bank_Account_Id_;
    KEL.typ.int C_O_U_N_T___Person_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) U_I_D__1_;
    KEL.typ.int S_U_M___Event_Count_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) U_I_D__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC102594(__ST95524_Layout __EE102180, __ST93628_Layout __EE102585) := __EEQP(__EE102180.UID,__EE102585.UID);
  __ST95618_Layout __JT102594(__ST95524_Layout __l, __ST93628_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE102595 := JOIN(__EE102180,__EE102585,__JC102594(LEFT,RIGHT),__JT102594(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE99685 := __EE99369;
  SHARED __EE99646 := __EE91651;
  SHARED __EE100363 := __EE99646(__EE99646.Vl_Event7_Active_Flag_ = 1);
  __JC100371(E_Person_Person.Layout __EE99685, B_Person_3.__ST21742_Layout __EE100363) := __EEQP(__EE99685.To_Person_,__EE100363.UID);
  SHARED __EE100372 := JOIN(__EE99685,__EE100363,__JC100371(LEFT,RIGHT),TRANSFORM(E_Person_Person.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST101731_Layout := RECORD
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
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC102604(E_Person_Person.Layout __EE100372, __ST100634_Layout __EE100638) := __EEQP(__EE100638.Subject_,__EE100372.From_Person_);
  __ST101731_Layout __JT102604(E_Person_Person.Layout __l, __ST100634_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE102605 := JOIN(__EE100638,__EE100372,__JC102604(RIGHT,LEFT),__JT102604(RIGHT,LEFT),INNER,HASH);
  SHARED __ST92925_Layout := RECORD
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE102619 := DEDUP(PROJECT(__EE102605,TRANSFORM(__ST92925_Layout,SELF.UID := LEFT.Account_,SELF := LEFT)),ALL);
  SHARED __ST92943_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE102634 := PROJECT(__CLEANANDDO(__EE102619,TABLE(__EE102619,{KEL.typ.int C_O_U_N_T___Person_Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST92943_Layout);
  SHARED __ST95711_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Bank_Account.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Bank.Typ) _r_Bank_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nint Otto_Bank_Account_Id_;
    KEL.typ.int C_O_U_N_T___Person_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) U_I_D__1_;
    KEL.typ.int S_U_M___Event_Count_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) U_I_D__3_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC102643(__ST95618_Layout __EE102595, __ST92943_Layout __EE102634) := __EEQP(__EE102595.UID,__EE102634.UID);
  __ST95711_Layout __JT102643(__ST95618_Layout __l, __ST92943_Layout __r) := TRANSFORM
    SELF.U_I_D__3_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE102644 := JOIN(__EE102595,__EE102634,__JC102643(LEFT,RIGHT),__JT102643(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE92778 := __EE91651(__EE91651.Vl_Event30_Active_Flag_ = 1);
  __JC99381(E_Person_Person.Layout __EE99369, B_Person_3.__ST21742_Layout __EE92778) := __EEQP(__EE99369.To_Person_,__EE92778.UID);
  SHARED __EE99382 := JOIN(__EE99369,__EE92778,__JC99381(LEFT,RIGHT),TRANSFORM(E_Person_Person.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST101883_Layout := RECORD
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
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC102653(E_Person_Person.Layout __EE99382, __ST100634_Layout __EE100638) := __EEQP(__EE100638.Subject_,__EE99382.From_Person_);
  __ST101883_Layout __JT102653(E_Person_Person.Layout __l, __ST100634_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE102654 := JOIN(__EE100638,__EE99382,__JC102653(RIGHT,LEFT),__JT102653(RIGHT,LEFT),INNER,HASH);
  SHARED __ST92708_Layout := RECORD
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE102668 := DEDUP(PROJECT(__EE102654,TRANSFORM(__ST92708_Layout,SELF.UID := LEFT.Account_,SELF := LEFT)),ALL);
  SHARED __ST92726_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE102683 := PROJECT(__CLEANANDDO(__EE102668,TABLE(__EE102668,{KEL.typ.int C_O_U_N_T___Person_Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST92726_Layout);
  SHARED __ST95803_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Bank_Account.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Bank.Typ) _r_Bank_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nint Otto_Bank_Account_Id_;
    KEL.typ.int C_O_U_N_T___Person_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) U_I_D__1_;
    KEL.typ.int S_U_M___Event_Count_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) U_I_D__3_;
    KEL.typ.int C_O_U_N_T___Person_Person__1_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) U_I_D__4_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC102692(__ST95711_Layout __EE102644, __ST92726_Layout __EE102683) := __EEQP(__EE102644.UID,__EE102683.UID);
  __ST95803_Layout __JT102692(__ST95711_Layout __l, __ST92726_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Person__1_ := __r.C_O_U_N_T___Person_Person_;
    SELF.U_I_D__4_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE102693 := JOIN(__EE102644,__EE102683,__JC102692(LEFT,RIGHT),__JT102692(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE92612 := __ENH_Bank_3;
  SHARED __ST95896_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Bank_Account.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Bank.Typ) _r_Bank_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nint Otto_Bank_Account_Id_;
    KEL.typ.int C_O_U_N_T___Person_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) U_I_D__1_;
    KEL.typ.int S_U_M___Event_Count_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) U_I_D__3_;
    KEL.typ.int C_O_U_N_T___Person_Person__1_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) U_I_D__4_;
    KEL.typ.nuid U_I_D__5_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ndataset(E_Bank.Source_Customers_Layout) Source_Customers__1_;
    KEL.typ.nstr Routing_Number_;
    KEL.typ.nstr Full_Bankname_;
    KEL.typ.nstr Abbreviated_Bankname_;
    KEL.typ.nstr Fractional_Routingnumber_;
    KEL.typ.nstr Headoffice_Routingnumber_;
    KEL.typ.nstr Headoffice_Branchcodes_;
    KEL.typ.nstr _hit_;
    KEL.typ.int High_Risk_Routing_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC102702(__ST95803_Layout __EE102693, B_Bank_3.__ST21345_Layout __EE92612) := __EEQP(__EE102693._r_Bank_,__EE92612.UID);
  __ST95896_Layout __JT102702(__ST95803_Layout __l, B_Bank_3.__ST21345_Layout __r) := TRANSFORM
    SELF.U_I_D__5_ := __r.UID;
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF.Source_Customers__1_ := __r.Source_Customers_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE102703 := JOIN(__EE102693,__EE92612,__JC102702(LEFT,RIGHT),__JT102702(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST20465_Layout := RECORD
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST20465_Layout __ND102072__Project(__ST95896_Layout __PP102032) := TRANSFORM
    SELF.Cl_Active30_Identity_Count_ := __PP102032.C_O_U_N_T___Person_Person__1_;
    SELF.Cl_Active7_Identity_Count_ := __PP102032.C_O_U_N_T___Person_Person_;
    SELF.Cl_Event_Count_ := __PP102032.S_U_M___Event_Count_;
    SELF.Cl_Identity_Count_ := __PP102032.C_O_U_N_T___Person_;
    SELF := __PP102032;
  END;
  EXPORT __ENH_Bank_Account_2 := PROJECT(__EE102703,__ND102072__Project(LEFT));
END;
