//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Internet_Protocol,E_Customer,E_Internet_Protocol FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Ip_Address_Entities := MODULE
  SHARED TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED TYPEOF(B_Internet_Protocol.__ENH_Internet_Protocol) __ENH_Internet_Protocol := B_Internet_Protocol.__ENH_Internet_Protocol;
  SHARED __EE463089 := __ENH_Internet_Protocol;
  SHARED __ST463455_Layout := RECORD
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
  SHARED __EE463470 := PROJECT(TABLE(PROJECT(__EE463089,__ST463455_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,Cl_Element_Count_,Cl_Event_Count_,Cl_Event_Count_Percentile_,Cl_Identity_Count_,Cl_Identity_Count_Percentile_,Cl_Impact_Weight_,Cluster_Score_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,Label_,Score_},_r_Customer_,Cl_Element_Count_,Cl_Event_Count_,Cl_Event_Count_Percentile_,Cl_Identity_Count_,Cl_Identity_Count_Percentile_,Cl_Impact_Weight_,Cluster_Score_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,Label_,Score_,MERGE),__ST463455_Layout);
  SHARED __EE463132 := __E_Customer;
  SHARED __ST463480_Layout := RECORD
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST463480_Layout __ND463473__Project(E_Customer.Layout __PP463472) := TRANSFORM
    SELF.U_I_D__1_ := __PP463472.UID;
    SELF.Customer_Id__1_ := __PP463472.Customer_Id_;
    SELF.Industry_Type__1_ := __PP463472.Industry_Type_;
    SELF := __PP463472;
  END;
  SHARED __EE463485 := PROJECT(__EE463132,__ND463473__Project(LEFT));
  SHARED __ST463513_Layout := RECORD
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
  __JC463492(__ST463455_Layout __EE463470, __ST463480_Layout __EE463485) := __EEQP(__EE463470._r_Customer_,__EE463485.U_I_D__1_);
  __ST463513_Layout __JT463492(__ST463455_Layout __l, __ST463480_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE463511 := JOIN(__EE463470,__EE463485,__JC463492(LEFT,RIGHT),__JT463492(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST11364_Layout := RECORD
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
  SHARED __ST11364_Layout __ND463534__Project(__ST463513_Layout __PP463512) := TRANSFORM
    SELF.Source_Customer_ := __PP463512._r_Customer_;
    SELF.Customer_Id_ := __PP463512.Customer_Id__1_;
    SELF.Industry_Type_ := __PP463512.Industry_Type__1_;
    SELF.Person_Count_ := __PP463512.Identity_Count_;
    SELF := __PP463512;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE463511,__ND463534__Project(LEFT)));
END;
