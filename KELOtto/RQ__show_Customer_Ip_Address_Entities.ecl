﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer,B_Internet_Protocol,E_Customer,E_Internet_Protocol FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Ip_Address_Entities := MODULE
  SHARED __EE553859 := B_Internet_Protocol.IDX_Internet_Protocol_UID_Wrapped;
  SHARED __ST554120_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.int Cl_Element_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.nfloat Cl_Impact_Weight_;
    KEL.typ.int Cluster_Score_ := 0;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.nint Score_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE554135 := PROJECT(TABLE(PROJECT(__EE553859,__ST554120_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,Cl_Element_Count_,Cl_Event_Count_,Cl_Event_Count_Percentile_,Cl_Identity_Count_,Cl_Identity_Count_Percentile_,Cl_Impact_Weight_,Cluster_Score_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,Label_,Score_},_r_Customer_,Cl_Element_Count_,Cl_Event_Count_,Cl_Event_Count_Percentile_,Cl_Identity_Count_,Cl_Identity_Count_Percentile_,Cl_Impact_Weight_,Cluster_Score_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,Label_,Score_,MERGE),__ST554120_Layout);
  SHARED __EE554016 := PROJECT(B_Customer.IDX_Customer_UID_Wrapped,E_Customer.Layout);
  SHARED __ST554145_Layout := RECORD
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST554145_Layout __ND554138__Project(E_Customer.Layout __PP554137) := TRANSFORM
    SELF.U_I_D__1_ := __PP554137.UID;
    SELF.Customer_Id__1_ := __PP554137.Customer_Id_;
    SELF.Industry_Type__1_ := __PP554137.Industry_Type_;
    SELF := __PP554137;
  END;
  SHARED __EE554150 := PROJECT(__EE554016,__ND554138__Project(LEFT));
  SHARED __ST554178_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.int Cl_Element_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.nfloat Cl_Impact_Weight_;
    KEL.typ.int Cluster_Score_ := 0;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.nint Score_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC554157(__ST554120_Layout __EE554135, __ST554145_Layout __EE554150) := __EEQP(__EE554135._r_Customer_,__EE554150.U_I_D__1_);
  __ST554178_Layout __JT554157(__ST554120_Layout __l, __ST554145_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE554176 := JOIN(__EE554135,__EE554150,__JC554157(LEFT,RIGHT),__JT554157(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST490017_Layout := RECORD
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST490017_Layout __ND554199__Project(__ST554178_Layout __PP554177) := TRANSFORM
    SELF.Source_Customer_ := __PP554177._r_Customer_;
    SELF.Customer_Id_ := __PP554177.Customer_Id__1_;
    SELF.Industry_Type_ := __PP554177.Industry_Type__1_;
    SELF.Person_Count_ := __PP554177.Identity_Count_;
    SELF := __PP554177;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE554176,__ND554199__Project(LEFT)));
END;
