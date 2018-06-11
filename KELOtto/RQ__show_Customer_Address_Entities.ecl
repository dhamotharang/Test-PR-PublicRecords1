//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Address,B_Customer,E_Address,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Address_Entities := MODULE
  SHARED __EE198626 := B_Address.IDX_Address_UID_Wrapped;
  SHARED __ST198903_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.nfloat Latitude_;
    KEL.typ.nfloat Longitude_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_ := 0;
    KEL.typ.nint Cluster_Score_;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.nstr Full_Address_;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Percent_Flag_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.nint Score_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE198918 := PROJECT(TABLE(PROJECT(__EE198626,__ST198903_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,Latitude_,Longitude_,All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_,Cluster_Score_,Deceased_Person_Count_,Entity_Context_Uid_,Entity_Type_,Full_Address_,High_Frequency_Flag_,High_Risk_Death_Prior_To_All_Events_Percent_Flag_,Person_Count_,Score_},_r_Customer_,Latitude_,Longitude_,All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_,Cluster_Score_,Deceased_Person_Count_,Entity_Context_Uid_,Entity_Type_,Full_Address_,High_Frequency_Flag_,High_Risk_Death_Prior_To_All_Events_Percent_Flag_,Person_Count_,Score_,MERGE),__ST198903_Layout);
  SHARED __EE198792 := PROJECT(B_Customer.IDX_Customer_UID_Wrapped,E_Customer.Layout);
  SHARED __ST198930_Layout := RECORD
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.nint Fdn_File_Info_Id_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST198930_Layout __ND198921__Project(E_Customer.Layout __PP198920) := TRANSFORM
    SELF.U_I_D__1_ := __PP198920.UID;
    SELF.Customer_Id__1_ := __PP198920.Customer_Id_;
    SELF.Industry_Type__1_ := __PP198920.Industry_Type_;
    SELF := __PP198920;
  END;
  SHARED __EE198936 := PROJECT(__EE198792,__ND198921__Project(LEFT));
  SHARED __ST198965_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.nfloat Latitude_;
    KEL.typ.nfloat Longitude_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_ := 0;
    KEL.typ.nint Cluster_Score_;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.nstr Full_Address_;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Percent_Flag_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.nint Score_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.nint Fdn_File_Info_Id_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC198943(__ST198903_Layout __EE198918, __ST198930_Layout __EE198936) := __EEQP(__EE198918._r_Customer_,__EE198936.U_I_D__1_);
  __ST198965_Layout __JT198943(__ST198903_Layout __l, __ST198930_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE198963 := JOIN(__EE198918,__EE198936,__JC198943(LEFT,RIGHT),__JT198943(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST180455_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.nstr Label_;
    KEL.typ.nint Score_;
    KEL.typ.nint Cluster_Score_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.nfloat Latitude_;
    KEL.typ.nfloat Longitude_;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Percent_Flag_ := 0;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST180455_Layout __ND198987__Project(__ST198965_Layout __PP198964) := TRANSFORM
    SELF.Source_Customer_ := __PP198964._r_Customer_;
    SELF.Customer_Id_ := __PP198964.Customer_Id__1_;
    SELF.Industry_Type_ := __PP198964.Industry_Type__1_;
    SELF.Label_ := __PP198964.Full_Address_;
    SELF := __PP198964;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE198963,__ND198987__Project(LEFT)));
END;
