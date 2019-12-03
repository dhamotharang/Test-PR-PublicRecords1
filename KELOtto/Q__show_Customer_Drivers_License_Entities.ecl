﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Drivers_License,E_Customer,E_Drivers_License FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Drivers_License_Entities := MODULE
  SHARED TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED TYPEOF(B_Drivers_License.__ENH_Drivers_License) __ENH_Drivers_License := B_Drivers_License.__ENH_Drivers_License;
  SHARED __EE3065608 := __ENH_Drivers_License;
  SHARED __ST3066166_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.nstr State_;
    KEL.typ.int Cl_Address_Count_ := 0;
    KEL.typ.int Cl_Element_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_High_Risk_Pattern1_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern2_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern3_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern4_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern5_Flag_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.nfloat Cl_Impact_Weight_;
    KEL.typ.int Cluster_Score_ := 0;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.nstr Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.nint Score_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE3066196 := PROJECT(TABLE(PROJECT(__EE3065608,__ST3066166_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,State_,Cl_Address_Count_,Cl_Element_Count_,Cl_Event_Count_,Cl_Event_Count_Percentile_,Cl_High_Risk_Pattern1_Flag_,Cl_High_Risk_Pattern2_Flag_,Cl_High_Risk_Pattern3_Flag_,Cl_High_Risk_Pattern4_Flag_,Cl_High_Risk_Pattern5_Flag_,Cl_Identity_Count_,Cl_Identity_Count_Percentile_,Cl_Impact_Weight_,Cluster_Score_,Contributor_Safe_Flag_,Dt_First_Seen_,Dt_Last_Seen_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,In_Customer_Population_,Kr_High_Risk_Flag_,Kr_Low_Risk_Flag_,Kr_Medium_Risk_Flag_,Label_,Safe_Flag_,Score_},_r_Customer_,State_,Cl_Address_Count_,Cl_Element_Count_,Cl_Event_Count_,Cl_Event_Count_Percentile_,Cl_High_Risk_Pattern1_Flag_,Cl_High_Risk_Pattern2_Flag_,Cl_High_Risk_Pattern3_Flag_,Cl_High_Risk_Pattern4_Flag_,Cl_High_Risk_Pattern5_Flag_,Cl_Identity_Count_,Cl_Identity_Count_Percentile_,Cl_Impact_Weight_,Cluster_Score_,Contributor_Safe_Flag_,Dt_First_Seen_,Dt_Last_Seen_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,In_Customer_Population_,Kr_High_Risk_Flag_,Kr_Low_Risk_Flag_,Kr_Medium_Risk_Flag_,Label_,Safe_Flag_,Score_,MERGE),__ST3066166_Layout);
  SHARED __EE3065499 := __E_Customer;
  SHARED __ST3066208_Layout := RECORD
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST3066208_Layout __ND3066199__Project(E_Customer.Layout __PP3066198) := TRANSFORM
    SELF.U_I_D__1_ := __PP3066198.UID;
    SELF.Customer_Id__1_ := __PP3066198.Customer_Id_;
    SELF.Industry_Type__1_ := __PP3066198.Industry_Type_;
    SELF := __PP3066198;
  END;
  SHARED __EE3066218 := PROJECT(__EE3065499,__ND3066199__Project(LEFT));
  SHARED __ST3066266_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.nstr State_;
    KEL.typ.int Cl_Address_Count_ := 0;
    KEL.typ.int Cl_Element_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_High_Risk_Pattern1_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern2_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern3_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern4_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern5_Flag_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.nfloat Cl_Impact_Weight_;
    KEL.typ.int Cluster_Score_ := 0;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.nstr Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.nint Score_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC3066225(__ST3066166_Layout __EE3066196, __ST3066208_Layout __EE3066218) := __EEQP(__EE3066196._r_Customer_,__EE3066218.U_I_D__1_);
  __ST3066266_Layout __JT3066225(__ST3066166_Layout __l, __ST3066208_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE3066264 := JOIN(__EE3066196,__EE3066218,__JC3066225(LEFT,RIGHT),__JT3066225(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST30700_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nstr Entity_Context_Uid_;
    KEL.typ.nstr Label_;
    KEL.typ.nint Score_;
    KEL.typ.int Cluster_Score_ := 0;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.int Cluster_Score__1_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int Cl_Element_Count_ := 0;
    KEL.typ.int Cl_Address_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.nfloat Cl_Impact_Weight_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern1_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern2_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern3_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern4_Flag_ := 0;
    KEL.typ.int Cl_High_Risk_Pattern5_Flag_ := 0;
    KEL.typ.nstr License_State_;
    KEL.typ.int In_Customer_Population__1_ := 0;
    KEL.typ.int Contributor_Safe_Flag__1_ := 0;
    KEL.typ.int Safe_Flag__1_ := 0;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Flag_ := 0;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST30700_Layout __ND3066307__Project(__ST3066266_Layout __PP3066265) := TRANSFORM
    SELF.Source_Customer_ := __PP3066265._r_Customer_;
    SELF.Customer_Id_ := __PP3066265.Customer_Id__1_;
    SELF.Industry_Type_ := __PP3066265.Industry_Type__1_;
    SELF.Person_Count_ := __PP3066265.Identity_Count_;
    SELF.Cluster_Score__1_ := __PP3066265.Cluster_Score_;
    SELF.License_State_ := __PP3066265.State_;
    SELF.In_Customer_Population__1_ := __PP3066265.In_Customer_Population_;
    SELF.Contributor_Safe_Flag__1_ := __PP3066265.Contributor_Safe_Flag_;
    SELF.Safe_Flag__1_ := __PP3066265.Safe_Flag_;
    SELF := __PP3066265;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE3066264,__ND3066307__Project(LEFT)));
END;
