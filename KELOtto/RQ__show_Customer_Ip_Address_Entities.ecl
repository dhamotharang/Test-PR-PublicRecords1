﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer,B_Internet_Protocol,E_Customer,E_Internet_Protocol FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Ip_Address_Entities := MODULE
  SHARED __EE892486 := B_Internet_Protocol.IDX_Internet_Protocol_UID_Wrapped;
  SHARED __ST892925_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.int Cl_Element_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.nfloat Cl_Impact_Weight_;
    KEL.typ.int Cluster_Score_ := 0;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.nint Score_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE892943 := PROJECT(TABLE(PROJECT(__EE892486,__ST892925_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,Cl_Element_Count_,Cl_Event_Count_,Cl_Event_Count_Percentile_,Cl_Identity_Count_,Cl_Identity_Count_Percentile_,Cl_Impact_Weight_,Cluster_Score_,Contributor_Safe_Flag_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,In_Customer_Population_,Label_,Safe_Flag_,Score_},_r_Customer_,Cl_Element_Count_,Cl_Event_Count_,Cl_Event_Count_Percentile_,Cl_Identity_Count_,Cl_Identity_Count_Percentile_,Cl_Impact_Weight_,Cluster_Score_,Contributor_Safe_Flag_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,In_Customer_Population_,Label_,Safe_Flag_,Score_,MERGE),__ST892925_Layout);
  SHARED __EE892735 := PROJECT(B_Customer.IDX_Customer_UID_Wrapped,E_Customer.Layout);
  SHARED __ST892953_Layout := RECORD
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST892953_Layout __ND892946__Project(E_Customer.Layout __PP892945) := TRANSFORM
    SELF.U_I_D__1_ := __PP892945.UID;
    SELF.Customer_Id__1_ := __PP892945.Customer_Id_;
    SELF.Industry_Type__1_ := __PP892945.Industry_Type_;
    SELF := __PP892945;
  END;
  SHARED __EE892958 := PROJECT(__EE892735,__ND892946__Project(LEFT));
  SHARED __ST892989_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.int Cl_Element_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.nfloat Cl_Impact_Weight_;
    KEL.typ.int Cluster_Score_ := 0;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.nint Score_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC892965(__ST892925_Layout __EE892943, __ST892953_Layout __EE892958) := __EEQP(__EE892943._r_Customer_,__EE892958.U_I_D__1_);
  __ST892989_Layout __JT892965(__ST892925_Layout __l, __ST892953_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE892987 := JOIN(__EE892943,__EE892958,__JC892965(LEFT,RIGHT),__JT892965(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST808894_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.nstr Label_;
    KEL.typ.nint Score_;
    KEL.typ.int Cluster_Score_ := 0;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int Cl_Element_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.nfloat Cl_Impact_Weight_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST808894_Layout __ND893013__Project(__ST892989_Layout __PP892988) := TRANSFORM
    SELF.Source_Customer_ := __PP892988._r_Customer_;
    SELF.Customer_Id_ := __PP892988.Customer_Id__1_;
    SELF.Industry_Type_ := __PP892988.Industry_Type__1_;
    SELF.Person_Count_ := __PP892988.Identity_Count_;
    SELF := __PP892988;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE892987,__ND893013__Project(LEFT)));
END;
