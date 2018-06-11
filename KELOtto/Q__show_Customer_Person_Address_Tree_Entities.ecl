﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Address,B_Person,B_Person_2,E_Address,E_Customer,E_Event,E_Person,E_Person_Event FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Person_Address_Tree_Entities := MODULE
  SHARED TYPEOF(B_Address.__ENH_Address) __ENH_Address := B_Address.__ENH_Address;
  SHARED TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED TYPEOF(B_Person.__ENH_Person) __ENH_Person := B_Person.__ENH_Person;
  SHARED TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE172385 := __E_Person_Event;
  SHARED __ST173767_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE173772 := PROJECT(TABLE(PROJECT(__EE172385,__ST173767_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,Subject_,Location_},_r_Customer_,Subject_,Location_,MERGE),__ST173767_Layout);
  SHARED __EE172422 := __ENH_Person;
  SHARED __ST174078_Layout := RECORD
    KEL.typ.nuid UID;
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
    KEL.typ.nstr _hri__1_;
    KEL.typ.nstr _hri__desc__1_;
    KEL.typ.nstr _hri__2_;
    KEL.typ.nstr _hri__desc__2_;
    KEL.typ.nstr _hri__3_;
    KEL.typ.nstr _hri__desc__3_;
    KEL.typ.nstr _hri__4_;
    KEL.typ.nstr _hri__desc__4_;
    KEL.typ.nstr _hri__5_;
    KEL.typ.nstr _hri__desc__5_;
    KEL.typ.nstr _hri__6_;
    KEL.typ.nstr _hri__desc__6_;
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
    KEL.typ.nstr _hri__7_;
    KEL.typ.nstr _hri__desc__7_;
    KEL.typ.nstr _hri__8_;
    KEL.typ.nstr _hri__desc__8_;
    KEL.typ.nstr _hri__9_;
    KEL.typ.nstr _hri__desc__9_;
    KEL.typ.nstr _hri__10_;
    KEL.typ.nstr _hri__desc__10_;
    KEL.typ.nstr _hri__11_;
    KEL.typ.nstr _hri__desc__11_;
    KEL.typ.nstr _hri__12_;
    KEL.typ.nstr _hri__desc__12_;
    KEL.typ.nstr _hri__13_;
    KEL.typ.nstr _hri__desc__13_;
    KEL.typ.nstr _hri__14_;
    KEL.typ.nstr _hri__desc__14_;
    KEL.typ.nstr _hri__15_;
    KEL.typ.nstr _hri__desc__15_;
    KEL.typ.nstr _hri__16_;
    KEL.typ.nstr _hri__desc__16_;
    KEL.typ.nstr _hri__17_;
    KEL.typ.nstr _hri__desc__17_;
    KEL.typ.nstr _hri__18_;
    KEL.typ.nstr _hri__desc__18_;
    KEL.typ.nstr _hri__19_;
    KEL.typ.nstr _hri__desc__19_;
    KEL.typ.nstr _hri__20_;
    KEL.typ.nstr _hri__desc__20_;
    KEL.typ.nbool _ssnfoundforlexid_;
    KEL.typ.nbool _addresspobox_;
    KEL.typ.nbool _addresscmra_;
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
    KEL.typ.nint _v2__validationipproblems_;
    KEL.typ.nstr _v2__ipstate_;
    KEL.typ.nstr _v2__ipcountry_;
    KEL.typ.nstr _v2__ipcontinent_;
    KEL.typ.nint _v2__inputaddrageoldest_;
    KEL.typ.nstr _v2__inputaddrdwelltype_;
    KEL.typ.nint _v2__divssnidentitycountnew_;
    KEL.typ.int All_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int All_Deceased_Event_Count_ := 0;
    KEL.typ.nfloat All_Deceased_Event_Percent_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nint All_Max_Deceased_To_Event_Diff_;
    B_Person_2.__NS39787_Layout Best_Full_Name_;
    KEL.typ.int Cl_Address_Count_ := 0;
    KEL.typ.int Cl_Death_Prior_To_All_Events_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Full_Identity_Count_ := 0;
    KEL.typ.int Cl_High_Risk_Death_Prior_To_All_Events_Identity_Count_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern1_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern2_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern3_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern4_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern5_Flag_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.float Cl_Identity_Event_Avg_ := 0.0;
    KEL.typ.int Cl_Nap3_Identity_Count_ := 0;
    KEL.typ.int Cl_Nas9_Identity_Count_ := 0;
    KEL.typ.nint Cluster_Score_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.int Death_Prior_To_All_Events_ := 0;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.int Deceased_Event_Count_ := 0;
    KEL.typ.nfloat Deceased_Event_Percent_;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.str Deceased_Match_Description_ := '';
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nstr Label_;
    KEL.typ.nint Max_Deceased_To_Event_Diff_;
    KEL.typ.int Nap3_Flag_ := 0;
    KEL.typ.int Nas9_Flag_ := 0;
    KEL.typ.int No_Lex_Id_ := 0;
    KEL.typ.int Other_Customer_Person_Customer_Count_ := 0;
    KEL.typ.nint Score_;
    KEL.typ.nint Source_Customer_Count_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE174251 := PROJECT(__EE172422,TRANSFORM(__ST174078_Layout,SELF._r_Customer__1_ := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST174437_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nuid UID;
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
    KEL.typ.nstr _hri__1_;
    KEL.typ.nstr _hri__desc__1_;
    KEL.typ.nstr _hri__2_;
    KEL.typ.nstr _hri__desc__2_;
    KEL.typ.nstr _hri__3_;
    KEL.typ.nstr _hri__desc__3_;
    KEL.typ.nstr _hri__4_;
    KEL.typ.nstr _hri__desc__4_;
    KEL.typ.nstr _hri__5_;
    KEL.typ.nstr _hri__desc__5_;
    KEL.typ.nstr _hri__6_;
    KEL.typ.nstr _hri__desc__6_;
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
    KEL.typ.nstr _hri__7_;
    KEL.typ.nstr _hri__desc__7_;
    KEL.typ.nstr _hri__8_;
    KEL.typ.nstr _hri__desc__8_;
    KEL.typ.nstr _hri__9_;
    KEL.typ.nstr _hri__desc__9_;
    KEL.typ.nstr _hri__10_;
    KEL.typ.nstr _hri__desc__10_;
    KEL.typ.nstr _hri__11_;
    KEL.typ.nstr _hri__desc__11_;
    KEL.typ.nstr _hri__12_;
    KEL.typ.nstr _hri__desc__12_;
    KEL.typ.nstr _hri__13_;
    KEL.typ.nstr _hri__desc__13_;
    KEL.typ.nstr _hri__14_;
    KEL.typ.nstr _hri__desc__14_;
    KEL.typ.nstr _hri__15_;
    KEL.typ.nstr _hri__desc__15_;
    KEL.typ.nstr _hri__16_;
    KEL.typ.nstr _hri__desc__16_;
    KEL.typ.nstr _hri__17_;
    KEL.typ.nstr _hri__desc__17_;
    KEL.typ.nstr _hri__18_;
    KEL.typ.nstr _hri__desc__18_;
    KEL.typ.nstr _hri__19_;
    KEL.typ.nstr _hri__desc__19_;
    KEL.typ.nstr _hri__20_;
    KEL.typ.nstr _hri__desc__20_;
    KEL.typ.nbool _ssnfoundforlexid_;
    KEL.typ.nbool _addresspobox_;
    KEL.typ.nbool _addresscmra_;
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
    KEL.typ.nint _v2__validationipproblems_;
    KEL.typ.nstr _v2__ipstate_;
    KEL.typ.nstr _v2__ipcountry_;
    KEL.typ.nstr _v2__ipcontinent_;
    KEL.typ.nint _v2__inputaddrageoldest_;
    KEL.typ.nstr _v2__inputaddrdwelltype_;
    KEL.typ.nint _v2__divssnidentitycountnew_;
    KEL.typ.int All_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int All_Deceased_Event_Count_ := 0;
    KEL.typ.nfloat All_Deceased_Event_Percent_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nint All_Max_Deceased_To_Event_Diff_;
    B_Person_2.__NS39787_Layout Best_Full_Name_;
    KEL.typ.int Cl_Address_Count_ := 0;
    KEL.typ.int Cl_Death_Prior_To_All_Events_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Full_Identity_Count_ := 0;
    KEL.typ.int Cl_High_Risk_Death_Prior_To_All_Events_Identity_Count_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern1_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern2_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern3_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern4_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern5_Flag_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.float Cl_Identity_Event_Avg_ := 0.0;
    KEL.typ.int Cl_Nap3_Identity_Count_ := 0;
    KEL.typ.int Cl_Nas9_Identity_Count_ := 0;
    KEL.typ.nint Cluster_Score_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.int Death_Prior_To_All_Events_ := 0;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.int Deceased_Event_Count_ := 0;
    KEL.typ.nfloat Deceased_Event_Percent_;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.str Deceased_Match_Description_ := '';
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nstr Label_;
    KEL.typ.nint Max_Deceased_To_Event_Diff_;
    KEL.typ.int Nap3_Flag_ := 0;
    KEL.typ.int Nas9_Flag_ := 0;
    KEL.typ.int No_Lex_Id_ := 0;
    KEL.typ.int Other_Customer_Person_Customer_Count_ := 0;
    KEL.typ.nint Score_;
    KEL.typ.nint Source_Customer_Count_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC174258(__ST173767_Layout __EE173772, __ST174078_Layout __EE174251) := __EEQP(__EE173772.Subject_,__EE174251.UID);
  __ST174437_Layout __JT174258(__ST173767_Layout __l, __ST174078_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE174435 := JOIN(__EE173772,__EE174251,__JC174258(LEFT,RIGHT),__JT174258(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE172433 := __ENH_Address;
  SHARED __ST172680_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nuid UID;
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
    KEL.typ.nstr _hri__1_;
    KEL.typ.nstr _hri__desc__1_;
    KEL.typ.nstr _hri__2_;
    KEL.typ.nstr _hri__desc__2_;
    KEL.typ.nstr _hri__3_;
    KEL.typ.nstr _hri__desc__3_;
    KEL.typ.nstr _hri__4_;
    KEL.typ.nstr _hri__desc__4_;
    KEL.typ.nstr _hri__5_;
    KEL.typ.nstr _hri__desc__5_;
    KEL.typ.nstr _hri__6_;
    KEL.typ.nstr _hri__desc__6_;
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
    KEL.typ.nstr _hri__7_;
    KEL.typ.nstr _hri__desc__7_;
    KEL.typ.nstr _hri__8_;
    KEL.typ.nstr _hri__desc__8_;
    KEL.typ.nstr _hri__9_;
    KEL.typ.nstr _hri__desc__9_;
    KEL.typ.nstr _hri__10_;
    KEL.typ.nstr _hri__desc__10_;
    KEL.typ.nstr _hri__11_;
    KEL.typ.nstr _hri__desc__11_;
    KEL.typ.nstr _hri__12_;
    KEL.typ.nstr _hri__desc__12_;
    KEL.typ.nstr _hri__13_;
    KEL.typ.nstr _hri__desc__13_;
    KEL.typ.nstr _hri__14_;
    KEL.typ.nstr _hri__desc__14_;
    KEL.typ.nstr _hri__15_;
    KEL.typ.nstr _hri__desc__15_;
    KEL.typ.nstr _hri__16_;
    KEL.typ.nstr _hri__desc__16_;
    KEL.typ.nstr _hri__17_;
    KEL.typ.nstr _hri__desc__17_;
    KEL.typ.nstr _hri__18_;
    KEL.typ.nstr _hri__desc__18_;
    KEL.typ.nstr _hri__19_;
    KEL.typ.nstr _hri__desc__19_;
    KEL.typ.nstr _hri__20_;
    KEL.typ.nstr _hri__desc__20_;
    KEL.typ.nbool _ssnfoundforlexid_;
    KEL.typ.nbool _addresspobox_;
    KEL.typ.nbool _addresscmra_;
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
    KEL.typ.nint _v2__validationipproblems_;
    KEL.typ.nstr _v2__ipstate_;
    KEL.typ.nstr _v2__ipcountry_;
    KEL.typ.nstr _v2__ipcontinent_;
    KEL.typ.nint _v2__inputaddrageoldest_;
    KEL.typ.nstr _v2__inputaddrdwelltype_;
    KEL.typ.nint _v2__divssnidentitycountnew_;
    KEL.typ.int All_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int All_Deceased_Event_Count_ := 0;
    KEL.typ.nfloat All_Deceased_Event_Percent_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nint All_Max_Deceased_To_Event_Diff_;
    B_Person_2.__NS39787_Layout Best_Full_Name_;
    KEL.typ.int Cl_Address_Count_ := 0;
    KEL.typ.int Cl_Death_Prior_To_All_Events_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Full_Identity_Count_ := 0;
    KEL.typ.int Cl_High_Risk_Death_Prior_To_All_Events_Identity_Count_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern1_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern2_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern3_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern4_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern5_Flag_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.float Cl_Identity_Event_Avg_ := 0.0;
    KEL.typ.int Cl_Nap3_Identity_Count_ := 0;
    KEL.typ.int Cl_Nas9_Identity_Count_ := 0;
    KEL.typ.nint Cluster_Score_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.int Death_Prior_To_All_Events_ := 0;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.int Deceased_Event_Count_ := 0;
    KEL.typ.nfloat Deceased_Event_Percent_;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.str Deceased_Match_Description_ := '';
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nstr Label_;
    KEL.typ.nint Max_Deceased_To_Event_Diff_;
    KEL.typ.int Nap3_Flag_ := 0;
    KEL.typ.int Nas9_Flag_ := 0;
    KEL.typ.int No_Lex_Id_ := 0;
    KEL.typ.int Other_Customer_Person_Customer_Count_ := 0;
    KEL.typ.nint Score_;
    KEL.typ.nint Source_Customer_Count_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__2_;
    KEL.typ.ndataset(E_Address.Source_Customers_Layout) Source_Customers__1_;
    KEL.typ.nint Otto_Address_Id_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Unit_Designation_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Postal_City_;
    KEL.typ.nstr Vanity_City_;
    KEL.typ.nstr State_;
    KEL.typ.nint Z_I_P_;
    KEL.typ.nint Z_I_P4_;
    KEL.typ.nstr Carrier_Route_Number_;
    KEL.typ.nstr Carrier_Route_Sortation_At_Z_I_P_;
    KEL.typ.nint Line_Of_Travel_;
    KEL.typ.nstr Line_Of_Travel_Order_;
    KEL.typ.nint Delivery_Point_Barcode_;
    KEL.typ.nint Delivery_Point_Barcode_Check_Digit_;
    KEL.typ.nstr Type_Code_;
    KEL.typ.nint County_;
    KEL.typ.nfloat Latitude_;
    KEL.typ.nfloat Longitude_;
    KEL.typ.nint Metropolitan_Statistical_Area_;
    KEL.typ.nint Geo_Block_;
    KEL.typ.nstr Geo_Match_;
    KEL.typ.nstr A_C_E_Cleaner_Error_Code_;
    KEL.typ.nbool _is_Additional_;
    KEL.typ.int All_Deceased_Match_Person_Count_ := 0;
    KEL.typ.float All_Deceased_Match_Person_Percent_ := 0.0;
    KEL.typ.int All_Deceased_Person_Count_ := 0;
    KEL.typ.float All_Deceased_Person_Percent_ := 0.0;
    KEL.typ.int All_High_Frequency_Flag_ := 0;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.float All_High_Risk_Death_Prior_To_All_Events_Person_Percent_ := 0.0;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_ := 0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.nint Cluster_Score__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.int Deceased_Match_Person_Count_ := 0;
    KEL.typ.float Deceased_Match_Person_Percent_ := 0.0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.float Deceased_Person_Percent_ := 0.0;
    KEL.typ.nunk Entity_Context_Uid__1_;
    KEL.typ.int Entity_Type__1_ := 0;
    KEL.typ.nstr Full_Address_;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Percent_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.float High_Risk_Death_Prior_To_All_Events_Person_Percent_ := 0.0;
    KEL.typ.int In_Customer_Population__1_ := 0;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.nint Score__1_;
    KEL.typ.nint Source_Customer_Count__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC174617(__ST174437_Layout __EE174435, B_Address.__ST2423_Layout __EE172433) := __EEQP(__EE174435.Location_,__EE172433.UID);
  __ST172680_Layout __JT174617(__ST174437_Layout __l, B_Address.__ST2423_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF._r_Customer__2_ := __r._r_Customer_;
    SELF.Source_Customers__1_ := __r.Source_Customers_;
    SELF.Cluster_Score__1_ := __r.Cluster_Score_;
    SELF.Customer_Id__1_ := __r.Customer_Id_;
    SELF.Entity_Context_Uid__1_ := __r.Entity_Context_Uid_;
    SELF.Entity_Type__1_ := __r.Entity_Type_;
    SELF.In_Customer_Population__1_ := __r.In_Customer_Population_;
    SELF.Industry_Type__1_ := __r.Industry_Type_;
    SELF.Score__1_ := __r.Score_;
    SELF.Source_Customer_Count__1_ := __r.Source_Customer_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE174884 := JOIN(__EE174435,__EE172433,__JC174617(LEFT,RIGHT),__JT174617(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE172408 := __E_Customer;
  SHARED __ST172972_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nuid UID;
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
    KEL.typ.nstr _hri__1_;
    KEL.typ.nstr _hri__desc__1_;
    KEL.typ.nstr _hri__2_;
    KEL.typ.nstr _hri__desc__2_;
    KEL.typ.nstr _hri__3_;
    KEL.typ.nstr _hri__desc__3_;
    KEL.typ.nstr _hri__4_;
    KEL.typ.nstr _hri__desc__4_;
    KEL.typ.nstr _hri__5_;
    KEL.typ.nstr _hri__desc__5_;
    KEL.typ.nstr _hri__6_;
    KEL.typ.nstr _hri__desc__6_;
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
    KEL.typ.nstr _hri__7_;
    KEL.typ.nstr _hri__desc__7_;
    KEL.typ.nstr _hri__8_;
    KEL.typ.nstr _hri__desc__8_;
    KEL.typ.nstr _hri__9_;
    KEL.typ.nstr _hri__desc__9_;
    KEL.typ.nstr _hri__10_;
    KEL.typ.nstr _hri__desc__10_;
    KEL.typ.nstr _hri__11_;
    KEL.typ.nstr _hri__desc__11_;
    KEL.typ.nstr _hri__12_;
    KEL.typ.nstr _hri__desc__12_;
    KEL.typ.nstr _hri__13_;
    KEL.typ.nstr _hri__desc__13_;
    KEL.typ.nstr _hri__14_;
    KEL.typ.nstr _hri__desc__14_;
    KEL.typ.nstr _hri__15_;
    KEL.typ.nstr _hri__desc__15_;
    KEL.typ.nstr _hri__16_;
    KEL.typ.nstr _hri__desc__16_;
    KEL.typ.nstr _hri__17_;
    KEL.typ.nstr _hri__desc__17_;
    KEL.typ.nstr _hri__18_;
    KEL.typ.nstr _hri__desc__18_;
    KEL.typ.nstr _hri__19_;
    KEL.typ.nstr _hri__desc__19_;
    KEL.typ.nstr _hri__20_;
    KEL.typ.nstr _hri__desc__20_;
    KEL.typ.nbool _ssnfoundforlexid_;
    KEL.typ.nbool _addresspobox_;
    KEL.typ.nbool _addresscmra_;
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
    KEL.typ.nint _v2__validationipproblems_;
    KEL.typ.nstr _v2__ipstate_;
    KEL.typ.nstr _v2__ipcountry_;
    KEL.typ.nstr _v2__ipcontinent_;
    KEL.typ.nint _v2__inputaddrageoldest_;
    KEL.typ.nstr _v2__inputaddrdwelltype_;
    KEL.typ.nint _v2__divssnidentitycountnew_;
    KEL.typ.int All_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int All_Deceased_Event_Count_ := 0;
    KEL.typ.nfloat All_Deceased_Event_Percent_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nint All_Max_Deceased_To_Event_Diff_;
    B_Person_2.__NS39787_Layout Best_Full_Name_;
    KEL.typ.int Cl_Address_Count_ := 0;
    KEL.typ.int Cl_Death_Prior_To_All_Events_Identity_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Full_Identity_Count_ := 0;
    KEL.typ.int Cl_High_Risk_Death_Prior_To_All_Events_Identity_Count_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern1_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern2_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern3_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern4_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern5_Flag_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.float Cl_Identity_Event_Avg_ := 0.0;
    KEL.typ.int Cl_Nap3_Identity_Count_ := 0;
    KEL.typ.int Cl_Nas9_Identity_Count_ := 0;
    KEL.typ.nint Cluster_Score_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.int Death_Prior_To_All_Events_ := 0;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.int Deceased_Event_Count_ := 0;
    KEL.typ.nfloat Deceased_Event_Percent_;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.str Deceased_Match_Description_ := '';
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nstr Label_;
    KEL.typ.nint Max_Deceased_To_Event_Diff_;
    KEL.typ.int Nap3_Flag_ := 0;
    KEL.typ.int Nas9_Flag_ := 0;
    KEL.typ.int No_Lex_Id_ := 0;
    KEL.typ.int Other_Customer_Person_Customer_Count_ := 0;
    KEL.typ.nint Score_;
    KEL.typ.nint Source_Customer_Count_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__2_;
    KEL.typ.ndataset(E_Address.Source_Customers_Layout) Source_Customers__1_;
    KEL.typ.nint Otto_Address_Id_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Unit_Designation_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Postal_City_;
    KEL.typ.nstr Vanity_City_;
    KEL.typ.nstr State_;
    KEL.typ.nint Z_I_P_;
    KEL.typ.nint Z_I_P4_;
    KEL.typ.nstr Carrier_Route_Number_;
    KEL.typ.nstr Carrier_Route_Sortation_At_Z_I_P_;
    KEL.typ.nint Line_Of_Travel_;
    KEL.typ.nstr Line_Of_Travel_Order_;
    KEL.typ.nint Delivery_Point_Barcode_;
    KEL.typ.nint Delivery_Point_Barcode_Check_Digit_;
    KEL.typ.nstr Type_Code_;
    KEL.typ.nint County_;
    KEL.typ.nfloat Latitude_;
    KEL.typ.nfloat Longitude_;
    KEL.typ.nint Metropolitan_Statistical_Area_;
    KEL.typ.nint Geo_Block_;
    KEL.typ.nstr Geo_Match_;
    KEL.typ.nstr A_C_E_Cleaner_Error_Code_;
    KEL.typ.nbool _is_Additional_;
    KEL.typ.int All_Deceased_Match_Person_Count_ := 0;
    KEL.typ.float All_Deceased_Match_Person_Percent_ := 0.0;
    KEL.typ.int All_Deceased_Person_Count_ := 0;
    KEL.typ.float All_Deceased_Person_Percent_ := 0.0;
    KEL.typ.int All_High_Frequency_Flag_ := 0;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.float All_High_Risk_Death_Prior_To_All_Events_Person_Percent_ := 0.0;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_ := 0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.nint Cluster_Score__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.int Deceased_Match_Person_Count_ := 0;
    KEL.typ.float Deceased_Match_Person_Percent_ := 0.0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.float Deceased_Person_Percent_ := 0.0;
    KEL.typ.nunk Entity_Context_Uid__1_;
    KEL.typ.int Entity_Type__1_ := 0;
    KEL.typ.nstr Full_Address_;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Percent_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Person_Count_ := 0;
    KEL.typ.float High_Risk_Death_Prior_To_All_Events_Person_Percent_ := 0.0;
    KEL.typ.int In_Customer_Population__1_ := 0;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.nint Score__1_;
    KEL.typ.nint Source_Customer_Count__1_;
    KEL.typ.nuid U_I_D__2_;
    KEL.typ.nint Customer_Id__2_;
    KEL.typ.nint Industry_Type__2_;
    KEL.typ.nint Fdn_File_Info_Id_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC175143(__ST172680_Layout __EE174884, E_Customer.Layout __EE172408) := __EEQP(__EE174884._r_Customer_,__EE172408.UID);
  __ST172972_Layout __JT175143(__ST172680_Layout __l, E_Customer.Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF.Customer_Id__2_ := __r.Customer_Id_;
    SELF.Industry_Type__2_ := __r.Industry_Type_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE175398 := JOIN(__EE174884,__EE172408,__JC175143(LEFT,RIGHT),__JT175143(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST2273_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nunk Tree_Uid_;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST2273_Layout __ND175644__Project(__ST172972_Layout __PP175399) := TRANSFORM
    SELF.Source_Customer_ := __PP175399._r_Customer_;
    SELF.Customer_Id_ := __PP175399.Customer_Id__2_;
    SELF.Industry_Type_ := __PP175399.Industry_Type__2_;
    SELF.Tree_Uid_ := __PP175399.Entity_Context_Uid_;
    SELF.Entity_Context_Uid_ := __PP175399.Entity_Context_Uid__1_;
    SELF := __PP175399;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(TABLE(PROJECT(__EE175398,__ND175644__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_Customer_,Customer_Id_,Industry_Type_,Tree_Uid_,Entity_Context_Uid_},Source_Customer_,Customer_Id_,Industry_Type_,Tree_Uid_,Entity_Context_Uid_,MERGE),__ST2273_Layout));
END;
