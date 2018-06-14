﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Address,E_Address,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Address_Entities := MODULE
  SHARED TYPEOF(B_Address.__ENH_Address) __ENH_Address := B_Address.__ENH_Address;
  SHARED TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED __EE159799 := __ENH_Address;
  SHARED __ST160177_Layout := RECORD
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
  SHARED __EE160192 := PROJECT(TABLE(PROJECT(__EE159799,__ST160177_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,Latitude_,Longitude_,All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_,Cluster_Score_,Deceased_Person_Count_,Entity_Context_Uid_,Entity_Type_,Full_Address_,High_Frequency_Flag_,High_Risk_Death_Prior_To_All_Events_Percent_Flag_,Person_Count_,Score_},_r_Customer_,Latitude_,Longitude_,All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_,Cluster_Score_,Deceased_Person_Count_,Entity_Context_Uid_,Entity_Type_,Full_Address_,High_Frequency_Flag_,High_Risk_Death_Prior_To_All_Events_Percent_Flag_,Person_Count_,Score_,MERGE),__ST160177_Layout);
  SHARED __EE159842 := __E_Customer;
  SHARED __ST160204_Layout := RECORD
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.nint Fdn_File_Info_Id_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST160204_Layout __ND160195__Project(E_Customer.Layout __PP160194) := TRANSFORM
    SELF.U_I_D__1_ := __PP160194.UID;
    SELF.Customer_Id__1_ := __PP160194.Customer_Id_;
    SELF.Industry_Type__1_ := __PP160194.Industry_Type_;
    SELF := __PP160194;
  END;
  SHARED __EE160210 := PROJECT(__EE159842,__ND160195__Project(LEFT));
  SHARED __ST160239_Layout := RECORD
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
  __JC160217(__ST160177_Layout __EE160192, __ST160204_Layout __EE160210) := __EEQP(__EE160192._r_Customer_,__EE160210.U_I_D__1_);
  __ST160239_Layout __JT160217(__ST160177_Layout __l, __ST160204_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE160237 := JOIN(__EE160192,__EE160210,__JC160217(LEFT,RIGHT),__JT160217(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST2203_Layout := RECORD
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
  SHARED __ST2203_Layout __ND160261__Project(__ST160239_Layout __PP160238) := TRANSFORM
    SELF.Source_Customer_ := __PP160238._r_Customer_;
    SELF.Customer_Id_ := __PP160238.Customer_Id__1_;
    SELF.Industry_Type_ := __PP160238.Industry_Type__1_;
    SELF.Label_ := __PP160238.Full_Address_;
    SELF := __PP160238;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE160237,__ND160261__Project(LEFT)));
END;
