//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Drivers_License,E_Customer,E_Drivers_License FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Drivers_License_Entities := MODULE
  SHARED TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED TYPEOF(B_Drivers_License.__ENH_Drivers_License) __ENH_Drivers_License := B_Drivers_License.__ENH_Drivers_License;
  SHARED __EE431424 := __ENH_Drivers_License;
  SHARED __ST431764_Layout := RECORD
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
  SHARED __EE431779 := PROJECT(TABLE(PROJECT(__EE431424,__ST431764_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,Cl_Element_Count_,Cl_Event_Count_,Cl_Event_Count_Percentile_,Cl_Identity_Count_,Cl_Identity_Count_Percentile_,Cl_Impact_Weight_,Cluster_Score_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,Label_,Score_},_r_Customer_,Cl_Element_Count_,Cl_Event_Count_,Cl_Event_Count_Percentile_,Cl_Identity_Count_,Cl_Identity_Count_Percentile_,Cl_Impact_Weight_,Cluster_Score_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,Label_,Score_,MERGE),__ST431764_Layout);
  SHARED __EE431467 := __E_Customer;
  SHARED __ST431789_Layout := RECORD
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST431789_Layout __ND431782__Project(E_Customer.Layout __PP431781) := TRANSFORM
    SELF.U_I_D__1_ := __PP431781.UID;
    SELF.Customer_Id__1_ := __PP431781.Customer_Id_;
    SELF.Industry_Type__1_ := __PP431781.Industry_Type_;
    SELF := __PP431781;
  END;
  SHARED __EE431794 := PROJECT(__EE431467,__ND431782__Project(LEFT));
  SHARED __ST431822_Layout := RECORD
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
  __JC431801(__ST431764_Layout __EE431779, __ST431789_Layout __EE431794) := __EEQP(__EE431779._r_Customer_,__EE431794.U_I_D__1_);
  __ST431822_Layout __JT431801(__ST431764_Layout __l, __ST431789_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE431820 := JOIN(__EE431779,__EE431794,__JC431801(LEFT,RIGHT),__JT431801(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST10245_Layout := RECORD
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
  SHARED __ST10245_Layout __ND431843__Project(__ST431822_Layout __PP431821) := TRANSFORM
    SELF.Source_Customer_ := __PP431821._r_Customer_;
    SELF.Customer_Id_ := __PP431821.Customer_Id__1_;
    SELF.Industry_Type_ := __PP431821.Industry_Type__1_;
    SELF.Person_Count_ := __PP431821.Identity_Count_;
    SELF := __PP431821;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE431820,__ND431843__Project(LEFT)));
END;
