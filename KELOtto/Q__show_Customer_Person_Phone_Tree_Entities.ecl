﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Person,B_Person_2,B_Phone,E_Customer,E_Person,E_Person_Phone,E_Phone FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Person_Phone_Tree_Entities := MODULE
  SHARED TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED TYPEOF(B_Person.__ENH_Person) __ENH_Person := B_Person.__ENH_Person;
  SHARED TYPEOF(E_Person_Phone.__Result) __E_Person_Phone := E_Person_Phone.__Result;
  SHARED TYPEOF(B_Phone.__ENH_Phone) __ENH_Phone := B_Phone.__ENH_Phone;
  SHARED __EE691078 := __E_Person_Phone;
  SHARED __EE691126 := __ENH_Person;
  SHARED __ST691159_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
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
    KEL.typ.nint Age_;
    KEL.typ.int All_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int All_Deceased_Event_Count_ := 0;
    KEL.typ.nfloat All_Deceased_Event_Percent_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nint All_Max_Deceased_To_Event_Diff_;
    KEL.typ.int Associated_With_Fraud_Offenses_Flag_ := 0;
    KEL.typ.int Associated_With_Incarcerated_Flag_ := 0;
    B_Person_2.__NS155270_Layout Best_Full_Name_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Address_Count_ := 0;
    KEL.typ.int Cl_Death_Prior_To_All_Events_Identity_Count_ := 0;
    KEL.typ.int Cl_Element_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Full_Identity_Count_ := 0;
    KEL.typ.int Cl_High_Kr_Identity_Count_ := 0;
    KEL.typ.int Cl_High_Risk_Death_Prior_To_All_Events_Identity_Count_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern1_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern2_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern3_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern4_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern5_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Routing_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.float Cl_Identity_Event_Avg_ := 0.0;
    KEL.typ.nfloat Cl_Impact_Weight_;
    KEL.typ.int Cl_Ip_High_Risk_City_Event_Count_ := 0;
    KEL.typ.int Cl_Ip_High_Risk_City_Identity_Count_ := 0;
    KEL.typ.int Cl_Ip_High_Risk_Identity_Count_ := 0;
    KEL.typ.int Cl_Ip_Hosted_Event_Count_ := 0;
    KEL.typ.int Cl_Ip_Hosted_Identity_Count_ := 0;
    KEL.typ.int Cl_Ip_Not_Us_Event_Count_ := 0;
    KEL.typ.int Cl_Ip_Not_Us_Identity_Count_ := 0;
    KEL.typ.int Cl_Ip_Tor_Event_Count_ := 0;
    KEL.typ.int Cl_Ip_Tor_Identity_Count_ := 0;
    KEL.typ.int Cl_Ip_Vpn_Event_Count_ := 0;
    KEL.typ.int Cl_Ip_Vpn_Identity_Count_ := 0;
    KEL.typ.int Cl_Nap3_Identity_Count_ := 0;
    KEL.typ.int Cl_Nas9_Identity_Count_ := 0;
    KEL.typ.int Cl_No_Lex_Id_Gt22_Count_ := 0;
    KEL.typ.int Cl_P_R_Identity_Match_Count_ := 0;
    KEL.typ.float Cl_P_R_Identity_Match_Percent_ := 0.0;
    KEL.typ.nint Cluster_Score_;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.int Currently_Incarcerated_Flag_ := 0;
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
    KEL.typ.int Event_Count_ := 0;
    KEL.typ.int Fraud_Offense_Count_ := 0;
    KEL.typ.int Fraud_Offenses_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int Hri03_Flag_ := 0;
    KEL.typ.int Hri06_Flag_ := 0;
    KEL.typ.int Hri07_Flag_ := 0;
    KEL.typ.int Hri08_Flag_ := 0;
    KEL.typ.int Hri11_Flag_ := 0;
    KEL.typ.int Hri12_Flag_ := 0;
    KEL.typ.int Hri14_Flag_ := 0;
    KEL.typ.int Hri15_Flag_ := 0;
    KEL.typ.int Hri19_Flag_ := 0;
    KEL.typ.int Hri25_Flag_ := 0;
    KEL.typ.int Hri26_Flag_ := 0;
    KEL.typ.int Hri27_Flag_ := 0;
    KEL.typ.int Hri28_Flag_ := 0;
    KEL.typ.int Hri29_Flag_ := 0;
    KEL.typ.int Hri30_Flag_ := 0;
    KEL.typ.int Hri31_Flag_ := 0;
    KEL.typ.int Hri37_Flag_ := 0;
    KEL.typ.int Hri38_Flag_ := 0;
    KEL.typ.int Hri41_Flag_ := 0;
    KEL.typ.int Hri48_Flag_ := 0;
    KEL.typ.int Hri50_Flag_ := 0;
    KEL.typ.int Hri51_Flag_ := 0;
    KEL.typ.int Hri52_Flag_ := 0;
    KEL.typ.int Hri71_Flag_ := 0;
    KEL.typ.int Hri83_Flag_ := 0;
    KEL.typ.int Hri90_Flag_ := 0;
    KEL.typ.int Hri_Cl_Flag_ := 0;
    KEL.typ.int Hri_Co_Flag_ := 0;
    KEL.typ.int Hri_Dd_Flag_ := 0;
    KEL.typ.int Hri_Df_Flag_ := 0;
    KEL.typ.int Hri_It_Flag_ := 0;
    KEL.typ.int Hri_Iv_Flag_ := 0;
    KEL.typ.int Hri_Mi_Flag_ := 0;
    KEL.typ.int Hri_Mo_Flag_ := 0;
    KEL.typ.int Hri_Ms_Flag_ := 0;
    KEL.typ.int Hri_Nf_Flag_ := 0;
    KEL.typ.int Hri_Pa_Flag_ := 0;
    KEL.typ.int Hri_Po_Flag_ := 0;
    KEL.typ.int Hri_Va_Flag_ := 0;
    KEL.typ.nint Id_Ssn_Identity_Count_Max_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nint Industry_Type_;
    KEL.typ.int Ip_High_Risk_City_ := 0;
    KEL.typ.int Ip_Hosted_ := 0;
    KEL.typ.int Ip_Not_Us_ := 0;
    KEL.typ.int Ip_Tor_ := 0;
    KEL.typ.int Ip_Vpn_ := 0;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Routing_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.nint Max_Deceased_To_Event_Diff_;
    KEL.typ.int Nap3_Flag_ := 0;
    KEL.typ.int Nas9_Flag_ := 0;
    KEL.typ.int No_Lex_Id_ := 0;
    KEL.typ.int No_Lex_Id_Gt22_ := 0;
    KEL.typ.int Other_Customer_Person_Customer_Count_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
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
  __JC691156(E_Person_Phone.Layout __EE691078, B_Person.__ST14833_Layout __EE691126) := __EEQP(__EE691078.Subject_,__EE691126.UID);
  __ST691159_Layout __JT691156(E_Person_Phone.Layout __l, B_Person.__ST14833_Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE691157 := JOIN(__EE691078,__EE691126,__JC691156(LEFT,RIGHT),__JT691156(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE691115 := __ENH_Phone;
  SHARED __ST691425_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
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
    KEL.typ.nint Age_;
    KEL.typ.int All_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int All_Deceased_Event_Count_ := 0;
    KEL.typ.nfloat All_Deceased_Event_Percent_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nint All_Max_Deceased_To_Event_Diff_;
    KEL.typ.int Associated_With_Fraud_Offenses_Flag_ := 0;
    KEL.typ.int Associated_With_Incarcerated_Flag_ := 0;
    B_Person_2.__NS155270_Layout Best_Full_Name_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Address_Count_ := 0;
    KEL.typ.int Cl_Death_Prior_To_All_Events_Identity_Count_ := 0;
    KEL.typ.int Cl_Element_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Full_Identity_Count_ := 0;
    KEL.typ.int Cl_High_Kr_Identity_Count_ := 0;
    KEL.typ.int Cl_High_Risk_Death_Prior_To_All_Events_Identity_Count_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern1_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern2_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern3_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern4_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern5_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Routing_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.float Cl_Identity_Event_Avg_ := 0.0;
    KEL.typ.nfloat Cl_Impact_Weight_;
    KEL.typ.int Cl_Ip_High_Risk_City_Event_Count_ := 0;
    KEL.typ.int Cl_Ip_High_Risk_City_Identity_Count_ := 0;
    KEL.typ.int Cl_Ip_High_Risk_Identity_Count_ := 0;
    KEL.typ.int Cl_Ip_Hosted_Event_Count_ := 0;
    KEL.typ.int Cl_Ip_Hosted_Identity_Count_ := 0;
    KEL.typ.int Cl_Ip_Not_Us_Event_Count_ := 0;
    KEL.typ.int Cl_Ip_Not_Us_Identity_Count_ := 0;
    KEL.typ.int Cl_Ip_Tor_Event_Count_ := 0;
    KEL.typ.int Cl_Ip_Tor_Identity_Count_ := 0;
    KEL.typ.int Cl_Ip_Vpn_Event_Count_ := 0;
    KEL.typ.int Cl_Ip_Vpn_Identity_Count_ := 0;
    KEL.typ.int Cl_Nap3_Identity_Count_ := 0;
    KEL.typ.int Cl_Nas9_Identity_Count_ := 0;
    KEL.typ.int Cl_No_Lex_Id_Gt22_Count_ := 0;
    KEL.typ.int Cl_P_R_Identity_Match_Count_ := 0;
    KEL.typ.float Cl_P_R_Identity_Match_Percent_ := 0.0;
    KEL.typ.nint Cluster_Score_;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.int Currently_Incarcerated_Flag_ := 0;
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
    KEL.typ.int Event_Count_ := 0;
    KEL.typ.int Fraud_Offense_Count_ := 0;
    KEL.typ.int Fraud_Offenses_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int Hri03_Flag_ := 0;
    KEL.typ.int Hri06_Flag_ := 0;
    KEL.typ.int Hri07_Flag_ := 0;
    KEL.typ.int Hri08_Flag_ := 0;
    KEL.typ.int Hri11_Flag_ := 0;
    KEL.typ.int Hri12_Flag_ := 0;
    KEL.typ.int Hri14_Flag_ := 0;
    KEL.typ.int Hri15_Flag_ := 0;
    KEL.typ.int Hri19_Flag_ := 0;
    KEL.typ.int Hri25_Flag_ := 0;
    KEL.typ.int Hri26_Flag_ := 0;
    KEL.typ.int Hri27_Flag_ := 0;
    KEL.typ.int Hri28_Flag_ := 0;
    KEL.typ.int Hri29_Flag_ := 0;
    KEL.typ.int Hri30_Flag_ := 0;
    KEL.typ.int Hri31_Flag_ := 0;
    KEL.typ.int Hri37_Flag_ := 0;
    KEL.typ.int Hri38_Flag_ := 0;
    KEL.typ.int Hri41_Flag_ := 0;
    KEL.typ.int Hri48_Flag_ := 0;
    KEL.typ.int Hri50_Flag_ := 0;
    KEL.typ.int Hri51_Flag_ := 0;
    KEL.typ.int Hri52_Flag_ := 0;
    KEL.typ.int Hri71_Flag_ := 0;
    KEL.typ.int Hri83_Flag_ := 0;
    KEL.typ.int Hri90_Flag_ := 0;
    KEL.typ.int Hri_Cl_Flag_ := 0;
    KEL.typ.int Hri_Co_Flag_ := 0;
    KEL.typ.int Hri_Dd_Flag_ := 0;
    KEL.typ.int Hri_Df_Flag_ := 0;
    KEL.typ.int Hri_It_Flag_ := 0;
    KEL.typ.int Hri_Iv_Flag_ := 0;
    KEL.typ.int Hri_Mi_Flag_ := 0;
    KEL.typ.int Hri_Mo_Flag_ := 0;
    KEL.typ.int Hri_Ms_Flag_ := 0;
    KEL.typ.int Hri_Nf_Flag_ := 0;
    KEL.typ.int Hri_Pa_Flag_ := 0;
    KEL.typ.int Hri_Po_Flag_ := 0;
    KEL.typ.int Hri_Va_Flag_ := 0;
    KEL.typ.nint Id_Ssn_Identity_Count_Max_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nint Industry_Type_;
    KEL.typ.int Ip_High_Risk_City_ := 0;
    KEL.typ.int Ip_Hosted_ := 0;
    KEL.typ.int Ip_Not_Us_ := 0;
    KEL.typ.int Ip_Tor_ := 0;
    KEL.typ.int Ip_Vpn_ := 0;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Routing_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.nint Max_Deceased_To_Event_Diff_;
    KEL.typ.int Nap3_Flag_ := 0;
    KEL.typ.int Nas9_Flag_ := 0;
    KEL.typ.int No_Lex_Id_ := 0;
    KEL.typ.int No_Lex_Id_Gt22_ := 0;
    KEL.typ.int Other_Customer_Person_Customer_Count_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
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
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__2_;
    KEL.typ.ndataset(E_Phone.Source_Customers_Layout) Source_Customers__1_;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr Phone_Number__1_;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.int Cl_Active30_Identity_Count__1_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile__1_;
    KEL.typ.int Cl_Active7_Identity_Count__1_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile__1_;
    KEL.typ.int Cl_Element_Count__1_ := 0;
    KEL.typ.int Cl_Event_Count__1_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile__1_;
    KEL.typ.int Cl_Identity_Count__1_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile__1_;
    KEL.typ.nfloat Cl_Impact_Weight__1_;
    KEL.typ.int Cluster_Score__1_ := 0;
    KEL.typ.int Contributor_Safe_Flag__1_ := 0;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nstr Entity_Context_Uid__1_;
    KEL.typ.int Entity_Type__1_ := 0;
    KEL.typ.int Event_Count__1_ := 0;
    KEL.typ.int Hri07_Flag__1_ := 0;
    KEL.typ.int Hri08_Flag__1_ := 0;
    KEL.typ.int Hri15_Flag__1_ := 0;
    KEL.typ.int Hri27_Flag__1_ := 0;
    KEL.typ.int Hri31_Flag__1_ := 0;
    KEL.typ.int Hri_Mi_Flag__1_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int In_Customer_Population__1_ := 0;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.int Kr_High_Risk_Flag__1_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag__1_ := 0;
    KEL.typ.nstr Label__1_;
    KEL.typ.int Safe_Flag__1_ := 0;
    KEL.typ.nint Score__1_;
    KEL.typ.nint Source_Customer_Count__1_;
    KEL.typ.int Vl_Event1_All_Count__1_ := 0;
    KEL.typ.int Vl_Event1_Count__1_ := 0;
    KEL.typ.int Vl_Event30_Active_Flag__1_ := 0;
    KEL.typ.int Vl_Event30_All_Active_Flag__1_ := 0;
    KEL.typ.int Vl_Event30_All_Day_Count__1_ := 0;
    KEL.typ.int Vl_Event30_Count__1_ := 0;
    KEL.typ.int Vl_Event365_All_Day_Count__1_ := 0;
    KEL.typ.int Vl_Event365_Count__1_ := 0;
    KEL.typ.int Vl_Event7_Active_Flag__1_ := 0;
    KEL.typ.int Vl_Event7_All_Active_Flag__1_ := 0;
    KEL.typ.int Vl_Event7_All_Count__1_ := 0;
    KEL.typ.int Vl_Event7_Count__1_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC692156(__ST691159_Layout __EE691157, B_Phone.__ST15061_Layout __EE691115) := __EEQP(__EE691157.Phone_Number_,__EE691115.UID);
  __ST691425_Layout __JT692156(__ST691159_Layout __l, B_Phone.__ST15061_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF._r_Customer__2_ := __r._r_Customer_;
    SELF.Source_Customers__1_ := __r.Source_Customers_;
    SELF.Phone_Number__1_ := __r.Phone_Number_;
    SELF.Cl_Active30_Identity_Count__1_ := __r.Cl_Active30_Identity_Count_;
    SELF.Cl_Active30_Identity_Count_Percentile__1_ := __r.Cl_Active30_Identity_Count_Percentile_;
    SELF.Cl_Active7_Identity_Count__1_ := __r.Cl_Active7_Identity_Count_;
    SELF.Cl_Active7_Identity_Count_Percentile__1_ := __r.Cl_Active7_Identity_Count_Percentile_;
    SELF.Cl_Element_Count__1_ := __r.Cl_Element_Count_;
    SELF.Cl_Event_Count__1_ := __r.Cl_Event_Count_;
    SELF.Cl_Event_Count_Percentile__1_ := __r.Cl_Event_Count_Percentile_;
    SELF.Cl_Identity_Count__1_ := __r.Cl_Identity_Count_;
    SELF.Cl_Identity_Count_Percentile__1_ := __r.Cl_Identity_Count_Percentile_;
    SELF.Cl_Impact_Weight__1_ := __r.Cl_Impact_Weight_;
    SELF.Cluster_Score__1_ := __r.Cluster_Score_;
    SELF.Contributor_Safe_Flag__1_ := __r.Contributor_Safe_Flag_;
    SELF.Customer_Id__1_ := __r.Customer_Id_;
    SELF.Entity_Context_Uid__1_ := __r.Entity_Context_Uid_;
    SELF.Entity_Type__1_ := __r.Entity_Type_;
    SELF.Event_Count__1_ := __r.Event_Count_;
    SELF.Hri07_Flag__1_ := __r.Hri07_Flag_;
    SELF.Hri08_Flag__1_ := __r.Hri08_Flag_;
    SELF.Hri15_Flag__1_ := __r.Hri15_Flag_;
    SELF.Hri27_Flag__1_ := __r.Hri27_Flag_;
    SELF.Hri31_Flag__1_ := __r.Hri31_Flag_;
    SELF.Hri_Mi_Flag__1_ := __r.Hri_Mi_Flag_;
    SELF.In_Customer_Population__1_ := __r.In_Customer_Population_;
    SELF.Industry_Type__1_ := __r.Industry_Type_;
    SELF.Kr_High_Risk_Flag__1_ := __r.Kr_High_Risk_Flag_;
    SELF.Kr_Medium_Risk_Flag__1_ := __r.Kr_Medium_Risk_Flag_;
    SELF.Label__1_ := __r.Label_;
    SELF.Safe_Flag__1_ := __r.Safe_Flag_;
    SELF.Score__1_ := __r.Score_;
    SELF.Source_Customer_Count__1_ := __r.Source_Customer_Count_;
    SELF.Vl_Event1_All_Count__1_ := __r.Vl_Event1_All_Count_;
    SELF.Vl_Event1_Count__1_ := __r.Vl_Event1_Count_;
    SELF.Vl_Event30_Active_Flag__1_ := __r.Vl_Event30_Active_Flag_;
    SELF.Vl_Event30_All_Active_Flag__1_ := __r.Vl_Event30_All_Active_Flag_;
    SELF.Vl_Event30_All_Day_Count__1_ := __r.Vl_Event30_All_Day_Count_;
    SELF.Vl_Event30_Count__1_ := __r.Vl_Event30_Count_;
    SELF.Vl_Event365_All_Day_Count__1_ := __r.Vl_Event365_All_Day_Count_;
    SELF.Vl_Event365_Count__1_ := __r.Vl_Event365_Count_;
    SELF.Vl_Event7_Active_Flag__1_ := __r.Vl_Event7_Active_Flag_;
    SELF.Vl_Event7_All_Active_Flag__1_ := __r.Vl_Event7_All_Active_Flag_;
    SELF.Vl_Event7_All_Count__1_ := __r.Vl_Event7_All_Count_;
    SELF.Vl_Event7_Count__1_ := __r.Vl_Event7_Count_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE692157 := JOIN(__EE691157,__EE691115,__JC692156(LEFT,RIGHT),__JT692156(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE691101 := __E_Customer;
  SHARED __ST691830_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
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
    KEL.typ.nint Age_;
    KEL.typ.int All_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int All_Deceased_Event_Count_ := 0;
    KEL.typ.nfloat All_Deceased_Event_Percent_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nint All_Max_Deceased_To_Event_Diff_;
    KEL.typ.int Associated_With_Fraud_Offenses_Flag_ := 0;
    KEL.typ.int Associated_With_Incarcerated_Flag_ := 0;
    B_Person_2.__NS155270_Layout Best_Full_Name_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Address_Count_ := 0;
    KEL.typ.int Cl_Death_Prior_To_All_Events_Identity_Count_ := 0;
    KEL.typ.int Cl_Element_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Full_Identity_Count_ := 0;
    KEL.typ.int Cl_High_Kr_Identity_Count_ := 0;
    KEL.typ.int Cl_High_Risk_Death_Prior_To_All_Events_Identity_Count_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern1_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern2_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern3_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern4_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern5_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Routing_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.float Cl_Identity_Event_Avg_ := 0.0;
    KEL.typ.nfloat Cl_Impact_Weight_;
    KEL.typ.int Cl_Ip_High_Risk_City_Event_Count_ := 0;
    KEL.typ.int Cl_Ip_High_Risk_City_Identity_Count_ := 0;
    KEL.typ.int Cl_Ip_High_Risk_Identity_Count_ := 0;
    KEL.typ.int Cl_Ip_Hosted_Event_Count_ := 0;
    KEL.typ.int Cl_Ip_Hosted_Identity_Count_ := 0;
    KEL.typ.int Cl_Ip_Not_Us_Event_Count_ := 0;
    KEL.typ.int Cl_Ip_Not_Us_Identity_Count_ := 0;
    KEL.typ.int Cl_Ip_Tor_Event_Count_ := 0;
    KEL.typ.int Cl_Ip_Tor_Identity_Count_ := 0;
    KEL.typ.int Cl_Ip_Vpn_Event_Count_ := 0;
    KEL.typ.int Cl_Ip_Vpn_Identity_Count_ := 0;
    KEL.typ.int Cl_Nap3_Identity_Count_ := 0;
    KEL.typ.int Cl_Nas9_Identity_Count_ := 0;
    KEL.typ.int Cl_No_Lex_Id_Gt22_Count_ := 0;
    KEL.typ.int Cl_P_R_Identity_Match_Count_ := 0;
    KEL.typ.float Cl_P_R_Identity_Match_Percent_ := 0.0;
    KEL.typ.nint Cluster_Score_;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.int Currently_Incarcerated_Flag_ := 0;
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
    KEL.typ.int Event_Count_ := 0;
    KEL.typ.int Fraud_Offense_Count_ := 0;
    KEL.typ.int Fraud_Offenses_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int Hri03_Flag_ := 0;
    KEL.typ.int Hri06_Flag_ := 0;
    KEL.typ.int Hri07_Flag_ := 0;
    KEL.typ.int Hri08_Flag_ := 0;
    KEL.typ.int Hri11_Flag_ := 0;
    KEL.typ.int Hri12_Flag_ := 0;
    KEL.typ.int Hri14_Flag_ := 0;
    KEL.typ.int Hri15_Flag_ := 0;
    KEL.typ.int Hri19_Flag_ := 0;
    KEL.typ.int Hri25_Flag_ := 0;
    KEL.typ.int Hri26_Flag_ := 0;
    KEL.typ.int Hri27_Flag_ := 0;
    KEL.typ.int Hri28_Flag_ := 0;
    KEL.typ.int Hri29_Flag_ := 0;
    KEL.typ.int Hri30_Flag_ := 0;
    KEL.typ.int Hri31_Flag_ := 0;
    KEL.typ.int Hri37_Flag_ := 0;
    KEL.typ.int Hri38_Flag_ := 0;
    KEL.typ.int Hri41_Flag_ := 0;
    KEL.typ.int Hri48_Flag_ := 0;
    KEL.typ.int Hri50_Flag_ := 0;
    KEL.typ.int Hri51_Flag_ := 0;
    KEL.typ.int Hri52_Flag_ := 0;
    KEL.typ.int Hri71_Flag_ := 0;
    KEL.typ.int Hri83_Flag_ := 0;
    KEL.typ.int Hri90_Flag_ := 0;
    KEL.typ.int Hri_Cl_Flag_ := 0;
    KEL.typ.int Hri_Co_Flag_ := 0;
    KEL.typ.int Hri_Dd_Flag_ := 0;
    KEL.typ.int Hri_Df_Flag_ := 0;
    KEL.typ.int Hri_It_Flag_ := 0;
    KEL.typ.int Hri_Iv_Flag_ := 0;
    KEL.typ.int Hri_Mi_Flag_ := 0;
    KEL.typ.int Hri_Mo_Flag_ := 0;
    KEL.typ.int Hri_Ms_Flag_ := 0;
    KEL.typ.int Hri_Nf_Flag_ := 0;
    KEL.typ.int Hri_Pa_Flag_ := 0;
    KEL.typ.int Hri_Po_Flag_ := 0;
    KEL.typ.int Hri_Va_Flag_ := 0;
    KEL.typ.nint Id_Ssn_Identity_Count_Max_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nint Industry_Type_;
    KEL.typ.int Ip_High_Risk_City_ := 0;
    KEL.typ.int Ip_Hosted_ := 0;
    KEL.typ.int Ip_Not_Us_ := 0;
    KEL.typ.int Ip_Tor_ := 0;
    KEL.typ.int Ip_Vpn_ := 0;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Routing_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.nint Max_Deceased_To_Event_Diff_;
    KEL.typ.int Nap3_Flag_ := 0;
    KEL.typ.int Nas9_Flag_ := 0;
    KEL.typ.int No_Lex_Id_ := 0;
    KEL.typ.int No_Lex_Id_Gt22_ := 0;
    KEL.typ.int Other_Customer_Person_Customer_Count_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
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
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__2_;
    KEL.typ.ndataset(E_Phone.Source_Customers_Layout) Source_Customers__1_;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr Phone_Number__1_;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.int Cl_Active30_Identity_Count__1_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile__1_;
    KEL.typ.int Cl_Active7_Identity_Count__1_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile__1_;
    KEL.typ.int Cl_Element_Count__1_ := 0;
    KEL.typ.int Cl_Event_Count__1_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile__1_;
    KEL.typ.int Cl_Identity_Count__1_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile__1_;
    KEL.typ.nfloat Cl_Impact_Weight__1_;
    KEL.typ.int Cluster_Score__1_ := 0;
    KEL.typ.int Contributor_Safe_Flag__1_ := 0;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nstr Entity_Context_Uid__1_;
    KEL.typ.int Entity_Type__1_ := 0;
    KEL.typ.int Event_Count__1_ := 0;
    KEL.typ.int Hri07_Flag__1_ := 0;
    KEL.typ.int Hri08_Flag__1_ := 0;
    KEL.typ.int Hri15_Flag__1_ := 0;
    KEL.typ.int Hri27_Flag__1_ := 0;
    KEL.typ.int Hri31_Flag__1_ := 0;
    KEL.typ.int Hri_Mi_Flag__1_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int In_Customer_Population__1_ := 0;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.int Kr_High_Risk_Flag__1_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag__1_ := 0;
    KEL.typ.nstr Label__1_;
    KEL.typ.int Safe_Flag__1_ := 0;
    KEL.typ.nint Score__1_;
    KEL.typ.nint Source_Customer_Count__1_;
    KEL.typ.int Vl_Event1_All_Count__1_ := 0;
    KEL.typ.int Vl_Event1_Count__1_ := 0;
    KEL.typ.int Vl_Event30_Active_Flag__1_ := 0;
    KEL.typ.int Vl_Event30_All_Active_Flag__1_ := 0;
    KEL.typ.int Vl_Event30_All_Day_Count__1_ := 0;
    KEL.typ.int Vl_Event30_Count__1_ := 0;
    KEL.typ.int Vl_Event365_All_Day_Count__1_ := 0;
    KEL.typ.int Vl_Event365_Count__1_ := 0;
    KEL.typ.int Vl_Event7_Active_Flag__1_ := 0;
    KEL.typ.int Vl_Event7_All_Active_Flag__1_ := 0;
    KEL.typ.int Vl_Event7_All_Count__1_ := 0;
    KEL.typ.int Vl_Event7_Count__1_ := 0;
    KEL.typ.nuid U_I_D__2_;
    KEL.typ.nint Customer_Id__2_;
    KEL.typ.nint Industry_Type__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC692158(__ST691425_Layout __EE692157, E_Customer.Layout __EE691101) := __EEQP(__EE692157._r_Customer_,__EE691101.UID);
  __ST691830_Layout __JT692158(__ST691425_Layout __l, E_Customer.Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF.Customer_Id__2_ := __r.Customer_Id_;
    SELF.Industry_Type__2_ := __r.Industry_Type_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE692159 := JOIN(__EE692157,__EE691101,__JC692158(LEFT,RIGHT),__JT692158(LEFT,RIGHT),LEFT OUTER,LOOKUP);
  SHARED __ST13677_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nstr Tree_Uid_;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST13677_Layout __ND692148__Project(__ST691830_Layout __PP692147) := TRANSFORM
    SELF.Source_Customer_ := __PP692147._r_Customer_;
    SELF.Customer_Id_ := __PP692147.Customer_Id__2_;
    SELF.Industry_Type_ := __PP692147.Industry_Type__2_;
    SELF.Tree_Uid_ := __PP692147.Entity_Context_Uid__1_;
    SELF := __PP692147;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(TABLE(PROJECT(__EE692159,__ND692148__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_Customer_,Customer_Id_,Industry_Type_,Tree_Uid_,Entity_Context_Uid_},Source_Customer_,Customer_Id_,Industry_Type_,Tree_Uid_,Entity_Context_Uid_,MERGE),__ST13677_Layout));
END;
