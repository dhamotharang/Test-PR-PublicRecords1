﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Email,E_Customer,E_Email FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Email_Entities := MODULE
  SHARED TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED TYPEOF(B_Email.__ENH_Email) __ENH_Email := B_Email.__ENH_Email;
  SHARED __EE2532422 := __ENH_Email;
  SHARED __ST2532937_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
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
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.nint Score_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE2532965 := PROJECT(TABLE(PROJECT(__EE2532422,__ST2532937_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,Cl_Address_Count_,Cl_Element_Count_,Cl_Event_Count_,Cl_Event_Count_Percentile_,Cl_High_Risk_Pattern1_Flag_,Cl_High_Risk_Pattern2_Flag_,Cl_High_Risk_Pattern3_Flag_,Cl_High_Risk_Pattern4_Flag_,Cl_High_Risk_Pattern5_Flag_,Cl_Identity_Count_,Cl_Identity_Count_Percentile_,Cl_Impact_Weight_,Cluster_Score_,Contributor_Safe_Flag_,Dt_First_Seen_,Dt_Last_Seen_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,In_Customer_Population_,Kr_High_Risk_Flag_,Kr_Medium_Risk_Flag_,Label_,Safe_Flag_,Score_},_r_Customer_,Cl_Address_Count_,Cl_Element_Count_,Cl_Event_Count_,Cl_Event_Count_Percentile_,Cl_High_Risk_Pattern1_Flag_,Cl_High_Risk_Pattern2_Flag_,Cl_High_Risk_Pattern3_Flag_,Cl_High_Risk_Pattern4_Flag_,Cl_High_Risk_Pattern5_Flag_,Cl_Identity_Count_,Cl_Identity_Count_Percentile_,Cl_Impact_Weight_,Cluster_Score_,Contributor_Safe_Flag_,Dt_First_Seen_,Dt_Last_Seen_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,In_Customer_Population_,Kr_High_Risk_Flag_,Kr_Medium_Risk_Flag_,Label_,Safe_Flag_,Score_,MERGE),__ST2532937_Layout);
  SHARED __EE2532328 := __E_Customer;
  SHARED __ST2532977_Layout := RECORD
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST2532977_Layout __ND2532968__Project(E_Customer.Layout __PP2532967) := TRANSFORM
    SELF.U_I_D__1_ := __PP2532967.UID;
    SELF.Customer_Id__1_ := __PP2532967.Customer_Id_;
    SELF.Industry_Type__1_ := __PP2532967.Industry_Type_;
    SELF := __PP2532967;
  END;
  SHARED __EE2532987 := PROJECT(__EE2532328,__ND2532968__Project(LEFT));
  SHARED __ST2533033_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
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
  __JC2532994(__ST2532937_Layout __EE2532965, __ST2532977_Layout __EE2532987) := __EEQP(__EE2532965._r_Customer_,__EE2532987.U_I_D__1_);
  __ST2533033_Layout __JT2532994(__ST2532937_Layout __l, __ST2532977_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE2533031 := JOIN(__EE2532965,__EE2532987,__JC2532994(LEFT,RIGHT),__JT2532994(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST28246_Layout := RECORD
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
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST28246_Layout __ND2533072__Project(__ST2533033_Layout __PP2533032) := TRANSFORM
    SELF.Source_Customer_ := __PP2533032._r_Customer_;
    SELF.Customer_Id_ := __PP2533032.Customer_Id__1_;
    SELF.Industry_Type_ := __PP2533032.Industry_Type__1_;
    SELF.Person_Count_ := __PP2533032.Identity_Count_;
    SELF.Cluster_Score__1_ := __PP2533032.Cluster_Score_;
    SELF := __PP2533032;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE2533031,__ND2533072__Project(LEFT)));
END;
