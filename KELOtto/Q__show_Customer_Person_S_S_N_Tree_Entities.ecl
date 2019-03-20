﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Person,B_Person_2,B_Social_Security_Number,E_Customer,E_Person,E_Person_S_S_N,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Person_S_S_N_Tree_Entities := MODULE
  SHARED TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED TYPEOF(B_Person.__ENH_Person) __ENH_Person := B_Person.__ENH_Person;
  SHARED TYPEOF(E_Person_S_S_N.__Result) __E_Person_S_S_N := E_Person_S_S_N.__Result;
  SHARED TYPEOF(B_Social_Security_Number.__ENH_Social_Security_Number) __ENH_Social_Security_Number := B_Social_Security_Number.__ENH_Social_Security_Number;
  SHARED __EE685124 := __E_Person_S_S_N;
  SHARED __EE685172 := __ENH_Person;
  SHARED __ST685205_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) Social_;
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
  __JC685202(E_Person_S_S_N.Layout __EE685124, B_Person.__ST14833_Layout __EE685172) := __EEQP(__EE685124.Subject_,__EE685172.UID);
  __ST685205_Layout __JT685202(E_Person_S_S_N.Layout __l, B_Person.__ST14833_Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE685203 := JOIN(__EE685124,__EE685172,__JC685202(LEFT,RIGHT),__JT685202(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE685161 := __ENH_Social_Security_Number;
  SHARED __ST685471_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) Social_;
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
    KEL.typ.ndataset(E_Social_Security_Number.Source_Customers_Layout) Source_Customers__1_;
    KEL.typ.nunk Ssn_;
    KEL.typ.nint Otto_S_S_N_Id_;
    KEL.typ.nstr Ssn_Formatted_;
    KEL.typ.nunk _v2__divssnidentitycountnew__1_;
    KEL.typ.nkdate Deceased_Date__1_;
    KEL.typ.nkdate Deceased_Date_Of_Birth__1_;
    KEL.typ.nstr Deceased_First__1_;
    KEL.typ.nstr Deceased_Middle__1_;
    KEL.typ.nstr Deceased_Last__1_;
    KEL.typ.nstr Deceased_Match_Code__1_;
    KEL.typ.nbool _isdeepdive__1_;
    KEL.typ.nstr _county__death__1_;
    KEL.typ.nstr Deceased_Ssn__1_;
    KEL.typ.nstr _state__death__flag__1_;
    KEL.typ.nstr _death__rec__src__1_;
    KEL.typ.nstr _state__death__id__1_;
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
    KEL.typ.nunk Entity_Context_Uid__1_;
    KEL.typ.int Entity_Type__1_ := 0;
    KEL.typ.int Event_Count__1_ := 0;
    KEL.typ.int Hri06_Flag__1_ := 0;
    KEL.typ.int Hri26_Flag__1_ := 0;
    KEL.typ.int Hri29_Flag__1_ := 0;
    KEL.typ.int Hri38_Flag__1_ := 0;
    KEL.typ.int Hri71_Flag__1_ := 0;
    KEL.typ.int Hri_It_Flag__1_ := 0;
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
  __JC686256(__ST685205_Layout __EE685203, B_Social_Security_Number.__ST15136_Layout __EE685161) := __EEQP(__EE685203.Social_,__EE685161.UID);
  __ST685471_Layout __JT686256(__ST685205_Layout __l, B_Social_Security_Number.__ST15136_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF._r_Customer__2_ := __r._r_Customer_;
    SELF.Source_Customers__1_ := __r.Source_Customers_;
    SELF._v2__divssnidentitycountnew__1_ := __r._v2__divssnidentitycountnew_;
    SELF.Deceased_Date__1_ := __r.Deceased_Date_;
    SELF.Deceased_Date_Of_Birth__1_ := __r.Deceased_Date_Of_Birth_;
    SELF.Deceased_First__1_ := __r.Deceased_First_;
    SELF.Deceased_Middle__1_ := __r.Deceased_Middle_;
    SELF.Deceased_Last__1_ := __r.Deceased_Last_;
    SELF.Deceased_Match_Code__1_ := __r.Deceased_Match_Code_;
    SELF._isdeepdive__1_ := __r._isdeepdive_;
    SELF._county__death__1_ := __r._county__death_;
    SELF.Deceased_Ssn__1_ := __r.Deceased_Ssn_;
    SELF._state__death__flag__1_ := __r._state__death__flag_;
    SELF._death__rec__src__1_ := __r._death__rec__src_;
    SELF._state__death__id__1_ := __r._state__death__id_;
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
    SELF.Hri06_Flag__1_ := __r.Hri06_Flag_;
    SELF.Hri26_Flag__1_ := __r.Hri26_Flag_;
    SELF.Hri29_Flag__1_ := __r.Hri29_Flag_;
    SELF.Hri38_Flag__1_ := __r.Hri38_Flag_;
    SELF.Hri71_Flag__1_ := __r.Hri71_Flag_;
    SELF.Hri_It_Flag__1_ := __r.Hri_It_Flag_;
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
  SHARED __EE686257 := JOIN(__EE685203,__EE685161,__JC686256(LEFT,RIGHT),__JT686256(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE685147 := __E_Customer;
  SHARED __ST685916_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) Social_;
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
    KEL.typ.ndataset(E_Social_Security_Number.Source_Customers_Layout) Source_Customers__1_;
    KEL.typ.nunk Ssn_;
    KEL.typ.nint Otto_S_S_N_Id_;
    KEL.typ.nstr Ssn_Formatted_;
    KEL.typ.nunk _v2__divssnidentitycountnew__1_;
    KEL.typ.nkdate Deceased_Date__1_;
    KEL.typ.nkdate Deceased_Date_Of_Birth__1_;
    KEL.typ.nstr Deceased_First__1_;
    KEL.typ.nstr Deceased_Middle__1_;
    KEL.typ.nstr Deceased_Last__1_;
    KEL.typ.nstr Deceased_Match_Code__1_;
    KEL.typ.nbool _isdeepdive__1_;
    KEL.typ.nstr _county__death__1_;
    KEL.typ.nstr Deceased_Ssn__1_;
    KEL.typ.nstr _state__death__flag__1_;
    KEL.typ.nstr _death__rec__src__1_;
    KEL.typ.nstr _state__death__id__1_;
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
    KEL.typ.nunk Entity_Context_Uid__1_;
    KEL.typ.int Entity_Type__1_ := 0;
    KEL.typ.int Event_Count__1_ := 0;
    KEL.typ.int Hri06_Flag__1_ := 0;
    KEL.typ.int Hri26_Flag__1_ := 0;
    KEL.typ.int Hri29_Flag__1_ := 0;
    KEL.typ.int Hri38_Flag__1_ := 0;
    KEL.typ.int Hri71_Flag__1_ := 0;
    KEL.typ.int Hri_It_Flag__1_ := 0;
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
  __JC686258(__ST685471_Layout __EE686257, E_Customer.Layout __EE685147) := __EEQP(__EE686257._r_Customer_,__EE685147.UID);
  __ST685916_Layout __JT686258(__ST685471_Layout __l, E_Customer.Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF.Customer_Id__2_ := __r.Customer_Id_;
    SELF.Industry_Type__2_ := __r.Industry_Type_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE686259 := JOIN(__EE686257,__EE685147,__JC686258(LEFT,RIGHT),__JT686258(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST13637_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nunk Tree_Uid_;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST13637_Layout __ND686248__Project(__ST685916_Layout __PP686247) := TRANSFORM
    SELF.Source_Customer_ := __PP686247._r_Customer_;
    SELF.Customer_Id_ := __PP686247.Customer_Id__2_;
    SELF.Industry_Type_ := __PP686247.Industry_Type__2_;
    SELF.Tree_Uid_ := __PP686247.Entity_Context_Uid__1_;
    SELF := __PP686247;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(TABLE(PROJECT(__EE686259,__ND686248__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_Customer_,Customer_Id_,Industry_Type_,Tree_Uid_,Entity_Context_Uid_},Source_Customer_,Customer_Id_,Industry_Type_,Tree_Uid_,Entity_Context_Uid_,MERGE),__ST13637_Layout));
END;
