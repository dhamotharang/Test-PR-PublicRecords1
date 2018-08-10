//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Customer,B_Internet_Protocol,E_Customer,E_Internet_Protocol FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Ip_Address_Entities := MODULE
  SHARED __EE371505 := B_Internet_Protocol.IDX_Internet_Protocol_UID_Wrapped;
  SHARED __ST371762_Layout := RECORD
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
  SHARED __EE371777 := PROJECT(TABLE(PROJECT(__EE371505,__ST371762_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,Cl_Element_Count_,Cl_Event_Count_,Cl_Event_Count_Percentile_,Cl_Identity_Count_,Cl_Identity_Count_Percentile_,Cl_Impact_Weight_,Cluster_Score_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,Label_,Score_},_r_Customer_,Cl_Element_Count_,Cl_Event_Count_,Cl_Event_Count_Percentile_,Cl_Identity_Count_,Cl_Identity_Count_Percentile_,Cl_Impact_Weight_,Cluster_Score_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,Label_,Score_,MERGE),__ST371762_Layout);
  SHARED __EE371660 := PROJECT(B_Customer.IDX_Customer_UID_Wrapped,E_Customer.Layout);
  SHARED __ST371787_Layout := RECORD
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST371787_Layout __ND371780__Project(E_Customer.Layout __PP371779) := TRANSFORM
    SELF.U_I_D__1_ := __PP371779.UID;
    SELF.Customer_Id__1_ := __PP371779.Customer_Id_;
    SELF.Industry_Type__1_ := __PP371779.Industry_Type_;
    SELF := __PP371779;
  END;
  SHARED __EE371792 := PROJECT(__EE371660,__ND371780__Project(LEFT));
  SHARED __ST371820_Layout := RECORD
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
  __JC371799(__ST371762_Layout __EE371777, __ST371787_Layout __EE371792) := __EEQP(__EE371777._r_Customer_,__EE371792.U_I_D__1_);
  __ST371820_Layout __JT371799(__ST371762_Layout __l, __ST371787_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE371818 := JOIN(__EE371777,__EE371792,__JC371799(LEFT,RIGHT),__JT371799(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST334910_Layout := RECORD
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
  SHARED __ST334910_Layout __ND371841__Project(__ST371820_Layout __PP371819) := TRANSFORM
    SELF.Source_Customer_ := __PP371819._r_Customer_;
    SELF.Customer_Id_ := __PP371819.Customer_Id__1_;
    SELF.Industry_Type_ := __PP371819.Industry_Type__1_;
    SELF.Person_Count_ := __PP371819.Identity_Count_;
    SELF := __PP371819;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE371818,__ND371841__Project(LEFT)));
END;
