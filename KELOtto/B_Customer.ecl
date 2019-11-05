﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_1,B_Customer_4,B_Person_1,B_Person_2,E_Customer,E_Customer_Person,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_1.__ENH_Customer_1) __ENH_Customer_1 := B_Customer_1.__ENH_Customer_1;
  SHARED VIRTUAL TYPEOF(E_Customer_Person.__Result) __E_Customer_Person := E_Customer_Person.__Result;
  SHARED VIRTUAL TYPEOF(B_Person_1.__ENH_Person_1) __ENH_Person_1 := B_Person_1.__ENH_Person_1;
  SHARED __EE1209608 := __ENH_Customer_1;
  SHARED __EE1210299 := __ENH_Person_1;
  SHARED __EE1210297 := __E_Customer_Person;
  SHARED __EE1220262 := __EE1210297(__NN(__EE1210297._r_Customer_) AND __NN(__EE1210297.Subject_));
  SHARED __ST1214712_Layout := RECORD
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
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.nint Age_;
    KEL.typ.int All_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nfloat All_Deceased_Event_Percent_;
    KEL.typ.nint All_Max_Deceased_To_Event_Diff_;
    B_Person_2.__NS411756_Layout Best_Full_Name_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Address_Safe_Count_ := 0;
    KEL.typ.int Cl_Adjacent_Safe_Element_Count_ := 0;
    KEL.typ.int Cl_Bank_Account_Safe_Count_ := 0;
    KEL.typ.int Cl_Bank_Identity_Count_Gt2_Count_ := 0;
    KEL.typ.int Cl_Drivers_License_Safe_Count_ := 0;
    KEL.typ.int Cl_Email_Safe_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_High_Kr_Identity_Count_ := 0;
    KEL.typ.float Cl_High_Kr_Identity_Percent_ := 0.0;
    KEL.typ.int Cl_High_Risk_Death_Prior_To_All_Events_Identity_Count_ := 0;
    KEL.typ.float Cl_High_Risk_Death_Prior_To_All_Events_Identity_Percent_ := 0.0;
    KEL.typ.int Cl_High_Risk_Email_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.int Cl_Ip_High_Risk_Identity_Count_ := 0;
    KEL.typ.int Cl_Ip_Safe_Count_ := 0;
    KEL.typ.int Cl_Nap3_Identity_Count_ := 0;
    KEL.typ.float Cl_Nas3_Identity_Percent_ := 0.0;
    KEL.typ.int Cl_Nas9_Identity_Count_ := 0;
    KEL.typ.float Cl_Nas9_Identity_Percent_ := 0.0;
    KEL.typ.int Cl_P_R_Identity_Match_Count_ := 0;
    KEL.typ.int Cl_Phone_Safe_Count_ := 0;
    KEL.typ.int Cl_Ssn_Safe_Count_ := 0;
    KEL.typ.int Death_Prior_To_All_Events_ := 0;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.nfloat Deceased_Event_Percent_;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int Event_Count_ := 0;
    KEL.typ.int Fraud_Offense_Count_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Ip_High_Risk_City_ := 0;
    KEL.typ.int Ip_Hosted_ := 0;
    KEL.typ.int Ip_Not_Us_ := 0;
    KEL.typ.int Ip_Tor_ := 0;
    KEL.typ.int Ip_Vpn_ := 0;
    KEL.typ.int Kr_Event_After_Known_Risk_Count_ := 0;
    KEL.typ.int Kr_Event_After_Known_Risk_Flag_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Count_ := 0;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Routing_ := 0;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.int Kr_Not_Known_Risk_Has_Known_Risk_Element_Flag_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.nint Max_Deceased_To_Event_Diff_;
    KEL.typ.int Nap3_Flag_ := 0;
    KEL.typ.int Nas9_Flag_ := 0;
    KEL.typ.int No_Lex_Id_ := 0;
    KEL.typ.int No_Lex_Id_Gt22_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.nint Score_;
    KEL.typ.int Vl_Event30_Active_Flag_ := 0;
    KEL.typ.int Vl_Event30_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event7_Active_Flag_ := 0;
    KEL.typ.int Vl_Event7_All_Count_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1220286(B_Person_1.__ST47256_Layout __EE1210299, E_Customer_Person.Layout __EE1220262) := __EEQP(__EE1220262.Subject_,__EE1210299.UID);
  __ST1214712_Layout __JT1220286(B_Person_1.__ST47256_Layout __l, E_Customer_Person.Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1220287 := JOIN(__EE1220262,__EE1210299,__JC1220286(RIGHT,LEFT),__JT1220286(RIGHT,LEFT),INNER,HASH);
  SHARED __ST1211186_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
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
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.nint Age_;
    KEL.typ.int All_Death_Prior_To_All_Events_ := 0;
    KEL.typ.nfloat All_Deceased_Event_Percent_;
    KEL.typ.nint All_Max_Deceased_To_Event_Diff_;
    B_Person_2.__NS411756_Layout Best_Full_Name_;
    KEL.typ.int Cl_Active30_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active30_Identity_Count_Percentile_;
    KEL.typ.int Cl_Active7_Identity_Count_ := 0;
    KEL.typ.nint Cl_Active7_Identity_Count_Percentile_;
    KEL.typ.int Cl_Address_Safe_Count_ := 0;
    KEL.typ.int Cl_Adjacent_Safe_Element_Count_ := 0;
    KEL.typ.int Cl_Bank_Account_Safe_Count_ := 0;
    KEL.typ.int Cl_Bank_Identity_Count_Gt2_Count_ := 0;
    KEL.typ.int Cl_Drivers_License_Safe_Count_ := 0;
    KEL.typ.int Cl_Email_Safe_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_High_Kr_Identity_Count_ := 0;
    KEL.typ.float Cl_High_Kr_Identity_Percent_ := 0.0;
    KEL.typ.int Cl_High_Risk_Death_Prior_To_All_Events_Identity_Count_ := 0;
    KEL.typ.float Cl_High_Risk_Death_Prior_To_All_Events_Identity_Percent_ := 0.0;
    KEL.typ.int Cl_High_Risk_Email_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.int Cl_Ip_High_Risk_Identity_Count_ := 0;
    KEL.typ.int Cl_Ip_Safe_Count_ := 0;
    KEL.typ.int Cl_Nap3_Identity_Count_ := 0;
    KEL.typ.float Cl_Nas3_Identity_Percent_ := 0.0;
    KEL.typ.int Cl_Nas9_Identity_Count_ := 0;
    KEL.typ.float Cl_Nas9_Identity_Percent_ := 0.0;
    KEL.typ.int Cl_P_R_Identity_Match_Count_ := 0;
    KEL.typ.int Cl_Phone_Safe_Count_ := 0;
    KEL.typ.int Cl_Ssn_Safe_Count_ := 0;
    KEL.typ.int Death_Prior_To_All_Events_ := 0;
    KEL.typ.int Deceased_ := 0;
    KEL.typ.int Deceased_Dob_Match_ := 0;
    KEL.typ.nfloat Deceased_Event_Percent_;
    KEL.typ.int Deceased_Match_ := 0;
    KEL.typ.int Deceased_Name_Match_ := 0;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int Event_Count_ := 0;
    KEL.typ.int Fraud_Offense_Count_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Ip_High_Risk_City_ := 0;
    KEL.typ.int Ip_Hosted_ := 0;
    KEL.typ.int Ip_Not_Us_ := 0;
    KEL.typ.int Ip_Tor_ := 0;
    KEL.typ.int Ip_Vpn_ := 0;
    KEL.typ.int Kr_Event_After_Known_Risk_Count_ := 0;
    KEL.typ.int Kr_Event_After_Known_Risk_Flag_ := 0;
    KEL.typ.int Kr_Event_After_Last_Known_Risk_Count_ := 0;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Routing_ := 0;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.int Kr_Not_Known_Risk_Has_Known_Risk_Element_Flag_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.nint Max_Deceased_To_Event_Diff_;
    KEL.typ.int Nap3_Flag_ := 0;
    KEL.typ.int Nas9_Flag_ := 0;
    KEL.typ.int No_Lex_Id_ := 0;
    KEL.typ.int No_Lex_Id_Gt22_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.nint Score_;
    KEL.typ.int Vl_Event30_Active_Flag_ := 0;
    KEL.typ.int Vl_Event30_All_Day_Count_ := 0;
    KEL.typ.int Vl_Event30_Count_ := 0;
    KEL.typ.int Vl_Event7_Active_Flag_ := 0;
    KEL.typ.int Vl_Event7_All_Count_ := 0;
    KEL.typ.int Vl_Event7_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST1211186_Layout __ND1220454__Project(__ST1214712_Layout __PP1220288) := TRANSFORM
    SELF.UID := __PP1220288._r_Customer__1_;
    SELF._r_Customer_ := __PP1220288._r_Customer__1_;
    SELF.U_I_D__1_ := __PP1220288.UID;
    SELF._r_Customer__1_ := __PP1220288._r_Customer_;
    SELF := __PP1220288;
  END;
  SHARED __EE1221055 := PROJECT(__EE1220287,__ND1220454__Project(LEFT));
  SHARED __ST1211526_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nint Exp1_;
    KEL.typ.nint Exp2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST1211526_Layout __ND1221060__Project(__ST1211186_Layout __PP1221056) := TRANSFORM
    SELF.Exp1_ := __CN(__PP1221056.Address_Count_);
    SELF.Exp2_ := __CN(__PP1221056.Event_Count_);
    SELF := __PP1221056;
  END;
  SHARED __EE1221075 := PROJECT(__EE1221055,__ND1221060__Project(LEFT));
  SHARED __EE1221286 := __EE1221075;
  SHARED __ST1213991_Layout := RECORD
    KEL.typ.nint M_E_D_I_A_N___Address_Count_;
    KEL.typ.nint M_E_D_I_A_N___Event_Count_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  __ST1213991_WeightLayout := {KEL.typ.int M_E_D_I_A_N___Address_Count_,KEL.typ.int M_E_D_I_A_N___Event_Count_};
  __ST1213991_WeightLayout __ST1213991_WeightCalc(KEL.Aggregates.RankedFieldN __r) := TRANSFORM
    SELF.M_E_D_I_A_N___Address_Count_ := IF(__r.number = 1,KEL.Aggregates.NTileWeight(2,1,__r.size,__r.pos),0);
    SELF.M_E_D_I_A_N___Event_Count_ := IF(__r.number = 2,KEL.Aggregates.NTileWeight(2,1,__r.size,__r.pos),0);
  END;
  __ST1213991_Layout __ST1213991_Normalize(__ST1213991_Layout __r) := TRANSFORM
    SELF.M_E_D_I_A_N___Address_Count_ := __OP2(__r.M_E_D_I_A_N___Address_Count_,/,__CN(2));
    SELF.M_E_D_I_A_N___Event_Count_ := __OP2(__r.M_E_D_I_A_N___Event_Count_,/,__CN(2));
    SELF := __r;
  END;
  __RK1221294 := KEL.Aggregates.RankingGroupedSmall2(__EE1221286,'Exp1_,Exp2_','UID',__ST1213991_WeightLayout,__ST1213991_Layout,__ST1213991_WeightCalc,__ST1213991_Normalize,TRUE,FALSE,FALSE);
  SHARED __EE1221309 := __RK1221294;
  SHARED __ST1216279_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.int All_Address_Count_ := 0;
    KEL.typ.int All_Deceased_Matched_Person_Count_ := 0;
    KEL.typ.int All_Deceased_Person_Count_ := 0;
    KEL.typ.int All_High_Frequency_Address_Count_ := 0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.int High_Frequency_Address_Count_ := 0;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS140470_Layout Jurisdiction_State_Top_;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.nint M_E_D_I_A_N___Address_Count_;
    KEL.typ.nint M_E_D_I_A_N___Event_Count_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1221315(B_Customer_1.__ST42981_Layout __EE1209608, __ST1213991_Layout __EE1221309) := __EEQP(__EE1209608.UID,__EE1221309.UID);
  __ST1216279_Layout __JT1221315(B_Customer_1.__ST42981_Layout __l, __ST1213991_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1221316 := JOIN(__EE1209608,__EE1221309,__JC1221315(LEFT,RIGHT),__JT1221315(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST1211546_Layout := RECORD
    KEL.typ.nfloat A_V_E___Address_Count_;
    KEL.typ.nfloat A_V_E___Event_Count_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE1221096 := PROJECT(__CLEANANDDO(__EE1221075,TABLE(__EE1221075,{KEL.Aggregates.AveNG(__EE1221075.Exp1_) A_V_E___Address_Count_,KEL.Aggregates.AveNG(__EE1221075.Exp2_) A_V_E___Event_Count_,UID},UID,MERGE)),__ST1211546_Layout);
  SHARED __ST1216457_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.int All_Address_Count_ := 0;
    KEL.typ.int All_Deceased_Matched_Person_Count_ := 0;
    KEL.typ.int All_Deceased_Person_Count_ := 0;
    KEL.typ.int All_High_Frequency_Address_Count_ := 0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.int High_Frequency_Address_Count_ := 0;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS140470_Layout Jurisdiction_State_Top_;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.nint M_E_D_I_A_N___Address_Count_;
    KEL.typ.nint M_E_D_I_A_N___Event_Count_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.nfloat A_V_E___Address_Count_;
    KEL.typ.nfloat A_V_E___Event_Count_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__2_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1221350(__ST1216279_Layout __EE1221316, __ST1211546_Layout __EE1221096) := __EEQP(__EE1221316.UID,__EE1221096.UID);
  __ST1216457_Layout __JT1221350(__ST1216279_Layout __l, __ST1211546_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1221351 := JOIN(__EE1221316,__EE1221096,__JC1221350(LEFT,RIGHT),__JT1221350(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST31207_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.int Address_Count_ := 0;
    KEL.typ.int All_Address_Count_ := 0;
    KEL.typ.float All_Deceased_Matched_Percent_ := 0.0;
    KEL.typ.int All_Deceased_Matched_Person_Count_ := 0;
    KEL.typ.int All_Deceased_Person_Count_ := 0;
    KEL.typ.float All_Deceased_Person_Percent_ := 0.0;
    KEL.typ.int All_High_Frequency_Address_Count_ := 0;
    KEL.typ.float All_High_Frequency_Address_Percent_ := 0.0;
    KEL.typ.int All_Person_Count_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.float Deceased_Person_Percent_ := 0.0;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.int High_Frequency_Address_Count_ := 0;
    KEL.typ.float High_Frequency_Address_Percent_ := 0.0;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS140470_Layout Jurisdiction_State_Top_;
    KEL.typ.nfloat Person_Address_Count_Average_;
    KEL.typ.nint Person_Address_Count_Median_;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.nfloat Person_Event_Count_Average_;
    KEL.typ.nint Person_Event_Count_Median_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST31207_Layout __ND1221387__Project(__ST1216457_Layout __PP1221352) := TRANSFORM
    SELF.All_Deceased_Matched_Percent_ := __PP1221352.All_Deceased_Matched_Person_Count_ / __PP1221352.All_Person_Count_;
    SELF.All_Deceased_Person_Percent_ := __PP1221352.All_Deceased_Person_Count_ / __PP1221352.All_Person_Count_;
    SELF.All_High_Frequency_Address_Percent_ := __PP1221352.All_High_Frequency_Address_Count_ / __PP1221352.All_Address_Count_;
    SELF.Deceased_Person_Percent_ := __PP1221352.Deceased_Person_Count_ / __PP1221352.Person_Count_;
    SELF.High_Frequency_Address_Percent_ := __PP1221352.High_Frequency_Address_Count_ / __PP1221352.Address_Count_;
    SELF.Person_Address_Count_Average_ := __PP1221352.A_V_E___Address_Count_;
    SELF.Person_Address_Count_Median_ := __PP1221352.M_E_D_I_A_N___Address_Count_;
    SELF.Person_Event_Count_Average_ := __PP1221352.A_V_E___Event_Count_;
    SELF.Person_Event_Count_Median_ := __PP1221352.M_E_D_I_A_N___Event_Count_;
    SELF := __PP1221352;
  END;
  EXPORT __ENH_Customer := PROJECT(__EE1221351,__ND1221387__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Customer::Annotated',EXPIRE(7));
  SHARED __EE2632046 := __ENH_Customer;
  SHARED IDX_Customer_UID_Layout := RECORD
    KEL.typ.uid UID;
    __EE2632046.Customer_Id_;
    __EE2632046.Industry_Type_;
    __EE2632046.States_;
    __EE2632046.Person_Count_;
    __EE2632046.All_Person_Count_;
    __EE2632046.Deceased_Person_Count_;
    __EE2632046.Deceased_Person_Percent_;
    __EE2632046.All_Deceased_Person_Count_;
    __EE2632046.All_Deceased_Person_Percent_;
    __EE2632046.All_Deceased_Matched_Person_Count_;
    __EE2632046.All_Deceased_Matched_Percent_;
    __EE2632046.Address_Count_;
    __EE2632046.All_Address_Count_;
    __EE2632046.High_Frequency_Address_Count_;
    __EE2632046.All_High_Frequency_Address_Count_;
    __EE2632046.High_Frequency_Address_Percent_;
    __EE2632046.All_High_Frequency_Address_Percent_;
    __EE2632046.Person_Event_Count_Average_;
    __EE2632046.Person_Event_Count_Median_;
    __EE2632046.Person_Address_Count_Average_;
    __EE2632046.Person_Address_Count_Median_;
    __EE2632046.Jurisdiction_State_Top_;
    __EE2632046.Jurisdiction_State_;
    __EE2632046.Event_Date_Max_;
    __EE2632046.Date_First_Seen_;
    __EE2632046.Date_Last_Seen_;
    __EE2632046.__RecordCount;
  END;
  SHARED IDX_Customer_UID_Projected := PROJECT(__EE2632046,TRANSFORM(IDX_Customer_UID_Layout,SELF.UID:=__T(LEFT.UID),SELF:=LEFT));
  EXPORT IDX_Customer_UID_Name := '~key::KEL::KELOtto::Customer::UID';
  EXPORT IDX_Customer_UID := INDEX(IDX_Customer_UID_Projected,{UID},{IDX_Customer_UID_Projected},IDX_Customer_UID_Name);
  EXPORT IDX_Customer_UID_Build := BUILD(IDX_Customer_UID,OVERWRITE);
  EXPORT __ST2632048_Layout := RECORDOF(IDX_Customer_UID);
  EXPORT IDX_Customer_UID_Wrapped := PROJECT(IDX_Customer_UID,TRANSFORM(__ST31207_Layout,SELF.UID := __CN(LEFT.UID),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Customer_UID_Build);
END;
