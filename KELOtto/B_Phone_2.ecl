﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Person_3,E_Customer,E_Person,E_Person_Person,E_Person_Phone,E_Phone FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Phone_2 := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_3.__ENH_Person_3) __ENH_Person_3 := B_Person_3.__ENH_Person_3;
  SHARED VIRTUAL TYPEOF(E_Person_Person.__Result) __E_Person_Person := E_Person_Person.__Result;
  SHARED VIRTUAL TYPEOF(E_Person_Phone.__Result) __E_Person_Phone := E_Person_Phone.__Result;
  SHARED VIRTUAL TYPEOF(E_Phone.__Result) __E_Phone := E_Phone.__Result;
  SHARED __EE177315 := __E_Phone;
  SHARED __EE177401 := __ENH_Person_3;
  SHARED __EE185159 := __EE177401;
  SHARED __EE177383 := __E_Person_Person;
  SHARED __EE184926 := __EE177383(__NN(__EE177383.To_Person_) AND __NN(__EE177383.From_Person_));
  SHARED __EE185177 := __EE184926;
  SHARED __EE177364 := __E_Person_Phone;
  SHARED __EE184989 := __EE177364(__NN(__EE177364.Phone_Number_) AND __NN(__EE177364.Subject_));
  SHARED __ST186102_Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE186106 := DEDUP(PROJECT(__EE184989,__ST186102_Layout),ALL);
  SHARED __ST186149_Layout := RECORD
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
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC187522(E_Person_Person.Layout __EE185177, __ST186102_Layout __EE186106) := __EEQP(__EE186106.Subject_,__EE185177.From_Person_);
  __ST186149_Layout __JT187522(E_Person_Person.Layout __l, __ST186102_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE187523 := JOIN(__EE185177,__EE186106,__JC187522(LEFT,RIGHT),__JT187522(LEFT,RIGHT),INNER,HASH);
  SHARED __ST180527_Layout := RECORD
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
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC187532(B_Person_3.__ST21752_Layout __EE185159, __ST186149_Layout __EE187523) := __EEQP(__EE187523.To_Person_,__EE185159.UID);
  __ST180527_Layout __JT187532(B_Person_3.__ST21752_Layout __l, __ST186149_Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE187533 := JOIN(__EE187523,__EE185159,__JC187532(RIGHT,LEFT),__JT187532(RIGHT,LEFT),INNER,HASH);
  SHARED __ST179838_Layout := RECORD
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.nint Lex_Id_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE187547 := DEDUP(PROJECT(__EE187533,TRANSFORM(__ST179838_Layout,SELF.UID := LEFT.Phone_Number_,SELF := LEFT)),ALL);
  SHARED __ST179856_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE187562 := PROJECT(__CLEANANDDO(__EE187547,TABLE(__EE187547,{KEL.typ.int C_O_U_N_T___Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST179856_Layout);
  SHARED __ST181260_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Phone.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.int C_O_U_N_T___Person_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC187571(E_Phone.Layout __EE177315, __ST179856_Layout __EE187562) := __EEQP(__EE177315.UID,__EE187562.UID);
  __ST181260_Layout __JT187571(E_Phone.Layout __l, __ST179856_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE187572 := JOIN(__EE177315,__EE187562,__JC187571(LEFT,RIGHT),__JT187571(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST179133_Layout := RECORD
    KEL.typ.ntyp(E_Phone.Typ) UID;
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
  SHARED __ST179133_Layout __ND187577__Project(__ST180527_Layout __PP187573) := TRANSFORM
    SELF.UID := __PP187573.Phone_Number_;
    SELF.U_I_D__1_ := __PP187573.UID;
    SELF.To_Person_ := __PP187573.UID;
    SELF := __PP187573;
  END;
  SHARED __EE187950 := DEDUP(PROJECT(__EE187533,__ND187577__Project(LEFT)),ALL);
  SHARED __ST179348_Layout := RECORD
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.int Event_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE187964 := PROJECT(__EE187950,__ST179348_Layout);
  SHARED __ST179363_Layout := RECORD
    KEL.typ.int S_U_M___Event_Count_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE187981 := PROJECT(__CLEANANDDO(__EE187964,TABLE(__EE187964,{KEL.typ.int S_U_M___Event_Count_ := SUM(GROUP,__EE187964.Event_Count_),UID},UID,MERGE)),__ST179363_Layout);
  SHARED __ST181347_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Phone.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.int C_O_U_N_T___Person_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) U_I_D__1_;
    KEL.typ.int S_U_M___Event_Count_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) U_I_D__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC187990(__ST181260_Layout __EE187572, __ST179363_Layout __EE187981) := __EEQP(__EE187572.UID,__EE187981.UID);
  __ST181347_Layout __JT187990(__ST181260_Layout __l, __ST179363_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE187991 := JOIN(__EE187572,__EE187981,__JC187990(LEFT,RIGHT),__JT187990(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE185195 := __EE184926;
  SHARED __EE185156 := __EE177401;
  SHARED __EE185878 := __EE185156(__EE185156.Vl_Event7_Active_Flag_ = 1);
  __JC185886(E_Person_Person.Layout __EE185195, B_Person_3.__ST21752_Layout __EE185878) := __EEQP(__EE185195.To_Person_,__EE185878.UID);
  SHARED __EE185887 := JOIN(__EE185195,__EE185878,__JC185886(LEFT,RIGHT),TRANSFORM(E_Person_Person.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST187206_Layout := RECORD
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
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC188000(E_Person_Person.Layout __EE185887, __ST186102_Layout __EE186106) := __EEQP(__EE186106.Subject_,__EE185887.From_Person_);
  __ST187206_Layout __JT188000(E_Person_Person.Layout __l, __ST186102_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE188001 := JOIN(__EE186106,__EE185887,__JC188000(RIGHT,LEFT),__JT188000(RIGHT,LEFT),INNER,HASH);
  SHARED __ST178661_Layout := RECORD
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE188015 := DEDUP(PROJECT(__EE188001,TRANSFORM(__ST178661_Layout,SELF.UID := LEFT.Phone_Number_,SELF := LEFT)),ALL);
  SHARED __ST178679_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE188030 := PROJECT(__CLEANANDDO(__EE188015,TABLE(__EE188015,{KEL.typ.int C_O_U_N_T___Person_Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST178679_Layout);
  SHARED __ST181433_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Phone.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.int C_O_U_N_T___Person_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) U_I_D__1_;
    KEL.typ.int S_U_M___Event_Count_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) U_I_D__3_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC188039(__ST181347_Layout __EE187991, __ST178679_Layout __EE188030) := __EEQP(__EE187991.UID,__EE188030.UID);
  __ST181433_Layout __JT188039(__ST181347_Layout __l, __ST178679_Layout __r) := TRANSFORM
    SELF.U_I_D__3_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE188040 := JOIN(__EE187991,__EE188030,__JC188039(LEFT,RIGHT),__JT188039(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE178503 := __EE177401(__EE177401.Vl_Event30_Active_Flag_ = 1);
  __JC184938(E_Person_Person.Layout __EE184926, B_Person_3.__ST21752_Layout __EE178503) := __EEQP(__EE184926.To_Person_,__EE178503.UID);
  SHARED __EE184939 := JOIN(__EE184926,__EE178503,__JC184938(LEFT,RIGHT),TRANSFORM(E_Person_Person.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST187358_Layout := RECORD
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
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC188049(E_Person_Person.Layout __EE184939, __ST186102_Layout __EE186106) := __EEQP(__EE186106.Subject_,__EE184939.From_Person_);
  __ST187358_Layout __JT188049(E_Person_Person.Layout __l, __ST186102_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE188050 := JOIN(__EE186106,__EE184939,__JC188049(RIGHT,LEFT),__JT188049(RIGHT,LEFT),INNER,HASH);
  SHARED __ST178435_Layout := RECORD
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE188064 := DEDUP(PROJECT(__EE188050,TRANSFORM(__ST178435_Layout,SELF.UID := LEFT.Phone_Number_,SELF := LEFT)),ALL);
  SHARED __ST178453_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE188079 := PROJECT(__CLEANANDDO(__EE188064,TABLE(__EE188064,{KEL.typ.int C_O_U_N_T___Person_Person_ := COUNT(GROUP),UID},UID,MERGE)),__ST178453_Layout);
  SHARED __ST181518_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Phone.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.int C_O_U_N_T___Person_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) U_I_D__1_;
    KEL.typ.int S_U_M___Event_Count_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) U_I_D__2_;
    KEL.typ.int C_O_U_N_T___Person_Person_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) U_I_D__3_;
    KEL.typ.int C_O_U_N_T___Person_Person__1_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) U_I_D__4_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC188088(__ST181433_Layout __EE188040, __ST178453_Layout __EE188079) := __EEQP(__EE188040.UID,__EE188079.UID);
  __ST181518_Layout __JT188088(__ST181433_Layout __l, __ST178453_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Person_Person__1_ := __r.C_O_U_N_T___Person_Person_;
    SELF.U_I_D__4_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE188089 := JOIN(__EE188040,__EE188079,__JC188088(LEFT,RIGHT),__JT188088(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST21205_Layout := RECORD
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST21205_Layout __ND187468__Project(__ST181518_Layout __PP187443) := TRANSFORM
    SELF.Cl_Active30_Identity_Count_ := __PP187443.C_O_U_N_T___Person_Person__1_;
    SELF.Cl_Active7_Identity_Count_ := __PP187443.C_O_U_N_T___Person_Person_;
    SELF.Cl_Event_Count_ := __PP187443.S_U_M___Event_Count_;
    SELF.Cl_Identity_Count_ := __PP187443.C_O_U_N_T___Person_;
    SELF := __PP187443;
  END;
  EXPORT __ENH_Phone_2 := PROJECT(__EE188089,__ND187468__Project(LEFT));
END;
