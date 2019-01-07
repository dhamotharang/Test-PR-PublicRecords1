//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Social_Security_Number,E_Customer,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Ssn_Entities := MODULE
  SHARED TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED TYPEOF(B_Social_Security_Number.__ENH_Social_Security_Number) __ENH_Social_Security_Number := B_Social_Security_Number.__ENH_Social_Security_Number;
  SHARED __EE442467 := __ENH_Social_Security_Number;
  SHARED __ST442854_Layout := RECORD
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
  SHARED __EE442869 := PROJECT(TABLE(PROJECT(__EE442467,__ST442854_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,Cl_Element_Count_,Cl_Event_Count_,Cl_Event_Count_Percentile_,Cl_Identity_Count_,Cl_Identity_Count_Percentile_,Cl_Impact_Weight_,Cluster_Score_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,Label_,Score_},_r_Customer_,Cl_Element_Count_,Cl_Event_Count_,Cl_Event_Count_Percentile_,Cl_Identity_Count_,Cl_Identity_Count_Percentile_,Cl_Impact_Weight_,Cluster_Score_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,Label_,Score_,MERGE),__ST442854_Layout);
  SHARED __EE442510 := __E_Customer;
  SHARED __ST442879_Layout := RECORD
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST442879_Layout __ND442872__Project(E_Customer.Layout __PP442871) := TRANSFORM
    SELF.U_I_D__1_ := __PP442871.UID;
    SELF.Customer_Id__1_ := __PP442871.Customer_Id_;
    SELF.Industry_Type__1_ := __PP442871.Industry_Type_;
    SELF := __PP442871;
  END;
  SHARED __EE442884 := PROJECT(__EE442510,__ND442872__Project(LEFT));
  SHARED __ST442912_Layout := RECORD
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
  __JC442891(__ST442854_Layout __EE442869, __ST442879_Layout __EE442884) := __EEQP(__EE442869._r_Customer_,__EE442884.U_I_D__1_);
  __ST442912_Layout __JT442891(__ST442854_Layout __l, __ST442879_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE442910 := JOIN(__EE442869,__EE442884,__JC442891(LEFT,RIGHT),__JT442891(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST10233_Layout := RECORD
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
  SHARED __ST10233_Layout __ND442933__Project(__ST442912_Layout __PP442911) := TRANSFORM
    SELF.Source_Customer_ := __PP442911._r_Customer_;
    SELF.Customer_Id_ := __PP442911.Customer_Id__1_;
    SELF.Industry_Type_ := __PP442911.Industry_Type__1_;
    SELF.Person_Count_ := __PP442911.Identity_Count_;
    SELF := __PP442911;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE442910,__ND442933__Project(LEFT)));
END;
