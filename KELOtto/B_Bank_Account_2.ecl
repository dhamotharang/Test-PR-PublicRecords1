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
  SHARED __EE90184 := __E_Bank_Account;
  SHARED __EE90272 := __ENH_Person_3;
  SHARED __EE98332 := __EE90272;
  SHARED __EE90254 := __E_Person_Person;
  SHARED __EE98052 := __EE90254(__NN(__EE90254.To_Person_) AND __NN(__EE90254.From_Person_));
  SHARED __EE98350 := __EE98052;
  SHARED __EE90235 := __E_Person_Bank_Account;
  SHARED __EE98115 := __EE90235(__NN(__EE90235.Account_) AND __NN(__EE90235.Subject_));
  SHARED __ST99325_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE99329 := DEDUP(PROJECT(__EE98115,__ST99325_Layout),ALL);
  SHARED __ST99372_Layout := RECORD
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
  __JC100833(E_Person_Person.Layout __EE98350, __ST99325_Layout __EE99329) := __EEQP(__EE99329.Subject_,__EE98350.From_Person_);
  __ST99372_Layout __JT100833(E_Person_Person.Layout __l, __ST99325_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE100834 := JOIN(__EE98350,__EE99329,__JC100833(LEFT,RIGHT),__JT100833(LEFT,RIGHT),INNER,HASH);
  SHARED __ST93444_Layout := RECORD
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
  __JC100843(B_Person_3.__ST21745_Layout __EE98332, __ST99372_Layout __EE100834) := __EEQP(__EE100834.To_Person_,__EE98332.UID);
  __ST93444_Layout __JT100843(B_Person_3.__ST21745_Layout __l, __ST99372_Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE100844 := JOIN(__EE100834,__EE98332,__JC100843(RIGHT,LEFT),__JT100843(RIGHT,LEFT),INNER,HASH);
  SHARED __ST92748_Layout := RECORD
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.nint Lex_Id_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE100858 := DEDUP(PROJECT(__EE100844,TRANSFORM(__ST92748_Layout,SELF.UID := LEFT.Account_,SELF := LEFT)),ALL);
  SHARED __ST92766_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE100873 := PROJECT(__CLEANANDDO(__EE100858,TABLE(__EE100858,{KEL.typ.int C_O_U_N_T___Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST92766_Layout);
  SHARED __ST94181_Layout := RECORD
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
  __JC100882(E_Bank_Account.Layout __EE90184, __ST92766_Layout __EE100873) := __EEQP(__EE90184.UID,__EE100873.UID);
  __ST94181_Layout __JT100882(E_Bank_Account.Layout __l, __ST92766_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE100883 := JOIN(__EE90184,__EE100873,__JC100882(LEFT,RIGHT),__JT100882(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST92033_Layout := RECORD
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
    KEL.typ.nuid To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST92033_Layout __ND100888__Project(__ST93444_Layout __PP100884) := TRANSFORM
    SELF.UID := __PP100884.Account_;
    SELF.U_I_D__1_ := __PP100884.UID;
    SELF.To_Person_ := __PP100884.UID;
    SELF := __PP100884;
  END;
  SHARED __EE101263 := DEDUP(PROJECT(__EE100844,__ND100888__Project(LEFT)),ALL);
  SHARED __ST92250_Layout := RECORD
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.int Event_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE101277 := PROJECT(__EE101263,__ST92250_Layout);
  SHARED __ST92265_Layout := RECORD
    KEL.typ.int S_U_M___Event_Count_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE101294 := PROJECT(__CLEANANDDO(__EE101277,TABLE(__EE101277,{KEL.typ.int S_U_M___Event_Count_ := SUM(GROUP,__EE101277.Event_Count_),UID},UID,MERGE)),__ST92265_Layout);
  SHARED __ST94275_Layout := RECORD
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
  __JC101303(__ST94181_Layout __EE100883, __ST92265_Layout __EE101294) := __EEQP(__EE100883.UID,__EE101294.UID);
  __ST94275_Layout __JT101303(__ST94181_Layout __l, __ST92265_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE101304 := JOIN(__EE100883,__EE101294,__JC101303(LEFT,RIGHT),__JT101303(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE98368 := __EE98052;
  SHARED __EE98329 := __EE90272;
  SHARED __EE99054 := __EE98329(__EE98329.Vl_Event7_Active_Flag_ = 1);
  __JC99062(E_Person_Person.Layout __EE98368, B_Person_3.__ST21745_Layout __EE99054) := __EEQP(__EE98368.To_Person_,__EE99054.UID);
  SHARED __EE99063 := JOIN(__EE98368,__EE99054,__JC99062(LEFT,RIGHT),TRANSFORM(E_Person_Person.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST100434_Layout := RECORD
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
  __JC101313(E_Person_Person.Layout __EE99063, __ST99325_Layout __EE99329) := __EEQP(__EE99329.Subject_,__EE99063.From_Person_);
  __ST100434_Layout __JT101313(E_Person_Person.Layout __l, __ST99325_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE101314 := JOIN(__EE99329,__EE99063,__JC101313(RIGHT,LEFT),__JT101313(RIGHT,LEFT),INNER,HASH);
  SHARED __ST91555_Layout := RECORD
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE101328 := DEDUP(PROJECT(__EE101314,TRANSFORM(__ST91555_Layout,SELF.UID := LEFT.Account_,SELF := LEFT)),ALL);
  SHARED __ST91573_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE101343 := PROJECT(__CLEANANDDO(__EE101328,TABLE(__EE101328,{KEL.typ.int C_O_U_N_T___Person_Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST91573_Layout);
  SHARED __ST94368_Layout := RECORD
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
  __JC101352(__ST94275_Layout __EE101304, __ST91573_Layout __EE101343) := __EEQP(__EE101304.UID,__EE101343.UID);
  __ST94368_Layout __JT101352(__ST94275_Layout __l, __ST91573_Layout __r) := TRANSFORM
    SELF.U_I_D__3_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE101353 := JOIN(__EE101304,__EE101343,__JC101352(LEFT,RIGHT),__JT101352(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE91408 := __EE90272(__EE90272.Vl_Event30_Active_Flag_ = 1);
  __JC98064(E_Person_Person.Layout __EE98052, B_Person_3.__ST21745_Layout __EE91408) := __EEQP(__EE98052.To_Person_,__EE91408.UID);
  SHARED __EE98065 := JOIN(__EE98052,__EE91408,__JC98064(LEFT,RIGHT),TRANSFORM(E_Person_Person.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST100586_Layout := RECORD
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
  __JC101362(E_Person_Person.Layout __EE98065, __ST99325_Layout __EE99329) := __EEQP(__EE99329.Subject_,__EE98065.From_Person_);
  __ST100586_Layout __JT101362(E_Person_Person.Layout __l, __ST99325_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE101363 := JOIN(__EE99329,__EE98065,__JC101362(RIGHT,LEFT),__JT101362(RIGHT,LEFT),INNER,HASH);
  SHARED __ST91338_Layout := RECORD
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE101377 := DEDUP(PROJECT(__EE101363,TRANSFORM(__ST91338_Layout,SELF.UID := LEFT.Account_,SELF := LEFT)),ALL);
  SHARED __ST91356_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE101392 := PROJECT(__CLEANANDDO(__EE101377,TABLE(__EE101377,{KEL.typ.int C_O_U_N_T___Person_Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST91356_Layout);
  SHARED __ST94460_Layout := RECORD
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
  __JC101401(__ST94368_Layout __EE101353, __ST91356_Layout __EE101392) := __EEQP(__EE101353.UID,__EE101392.UID);
  __ST94460_Layout __JT101401(__ST94368_Layout __l, __ST91356_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Person__1_ := __r.C_O_U_N_T___Person_Person_;
    SELF.U_I_D__4_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE101402 := JOIN(__EE101353,__EE101392,__JC101401(LEFT,RIGHT),__JT101401(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE91242 := __ENH_Bank_3;
  SHARED __ST94553_Layout := RECORD
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
  __JC101411(__ST94460_Layout __EE101402, B_Bank_3.__ST21346_Layout __EE91242) := __EEQP(__EE101402._r_Bank_,__EE91242.UID);
  __ST94553_Layout __JT101411(__ST94460_Layout __l, B_Bank_3.__ST21346_Layout __r) := TRANSFORM
    SELF.U_I_D__5_ := __r.UID;
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF.Source_Customers__1_ := __r.Source_Customers_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE101412 := JOIN(__EE101402,__EE91242,__JC101411(LEFT,RIGHT),__JT101411(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST20463_Layout := RECORD
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
  SHARED __ST20463_Layout __ND100775__Project(__ST94553_Layout __PP100735) := TRANSFORM
    SELF.Cl_Active30_Identity_Count_ := __PP100735.C_O_U_N_T___Person_Person__1_;
    SELF.Cl_Active7_Identity_Count_ := __PP100735.C_O_U_N_T___Person_Person_;
    SELF.Cl_Event_Count_ := __PP100735.S_U_M___Event_Count_;
    SELF.Cl_Identity_Count_ := __PP100735.C_O_U_N_T___Person_;
    SELF := __PP100735;
  END;
  EXPORT __ENH_Bank_Account_2 := PROJECT(__EE101412,__ND100775__Project(LEFT));
END;
