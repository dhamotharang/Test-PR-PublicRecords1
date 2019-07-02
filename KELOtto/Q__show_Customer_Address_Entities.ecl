﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Address,E_Address,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Address_Entities := MODULE
  SHARED TYPEOF(B_Address.__ENH_Address) __ENH_Address := B_Address.__ENH_Address;
  SHARED TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED __EE751317 := __ENH_Address;
  SHARED __ST751976_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.nstr Vanity_City_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Zip_;
    KEL.typ.nfloat Latitude_;
    KEL.typ.nfloat Longitude_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_ := 0;
    KEL.typ.int Cl_Element_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.nfloat Cl_Impact_Weight_;
    KEL.typ.nint Cluster_Score_;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Percent_Flag_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.nint Score_;
    KEL.typ.nstr Street_Address_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE752005 := PROJECT(TABLE(PROJECT(__EE751317,__ST751976_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,Vanity_City_,State_,Zip_,Latitude_,Longitude_,All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_,Cl_Element_Count_,Cl_Event_Count_,Cl_Event_Count_Percentile_,Cl_Identity_Count_,Cl_Identity_Count_Percentile_,Cl_Impact_Weight_,Cluster_Score_,Contributor_Safe_Flag_,Deceased_Person_Count_,Entity_Context_Uid_,Entity_Type_,High_Frequency_Flag_,High_Risk_Death_Prior_To_All_Events_Percent_Flag_,Identity_Count_,In_Customer_Population_,Kr_High_Risk_Flag_,Kr_Medium_Risk_Flag_,Safe_Flag_,Score_,Street_Address_},_r_Customer_,Vanity_City_,State_,Zip_,Latitude_,Longitude_,All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_,Cl_Element_Count_,Cl_Event_Count_,Cl_Event_Count_Percentile_,Cl_Identity_Count_,Cl_Identity_Count_Percentile_,Cl_Impact_Weight_,Cluster_Score_,Contributor_Safe_Flag_,Deceased_Person_Count_,Entity_Context_Uid_,Entity_Type_,High_Frequency_Flag_,High_Risk_Death_Prior_To_All_Events_Percent_Flag_,Identity_Count_,In_Customer_Population_,Kr_High_Risk_Flag_,Kr_Medium_Risk_Flag_,Safe_Flag_,Score_,Street_Address_,MERGE),__ST751976_Layout);
  SHARED __EE751390 := __E_Customer;
  SHARED __ST752015_Layout := RECORD
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST752015_Layout __ND752008__Project(E_Customer.Layout __PP752007) := TRANSFORM
    SELF.U_I_D__1_ := __PP752007.UID;
    SELF.Customer_Id__1_ := __PP752007.Customer_Id_;
    SELF.Industry_Type__1_ := __PP752007.Industry_Type_;
    SELF := __PP752007;
  END;
  SHARED __EE752020 := PROJECT(__EE751390,__ND752008__Project(LEFT));
  SHARED __ST752062_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.nstr Vanity_City_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Zip_;
    KEL.typ.nfloat Latitude_;
    KEL.typ.nfloat Longitude_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_ := 0;
    KEL.typ.int Cl_Element_Count_ := 0;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.nfloat Cl_Impact_Weight_;
    KEL.typ.nint Cluster_Score_;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.nunk Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Percent_Flag_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.nint Score_;
    KEL.typ.nstr Street_Address_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC752027(__ST751976_Layout __EE752005, __ST752015_Layout __EE752020) := __EEQP(__EE752005._r_Customer_,__EE752020.U_I_D__1_);
  __ST752062_Layout __JT752027(__ST751976_Layout __l, __ST752015_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE752060 := JOIN(__EE752005,__EE752020,__JC752027(LEFT,RIGHT),__JT752027(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST17082_Layout := RECORD
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
    KEL.typ.nstr Street_Address_;
    KEL.typ.nstr Vanity_City_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Zip_;
    KEL.typ.int Cl_Event_Count_ := 0;
    KEL.typ.int Cl_Identity_Count_ := 0;
    KEL.typ.int Cl_Element_Count_ := 0;
    KEL.typ.nint Cl_Identity_Count_Percentile_;
    KEL.typ.nint Cl_Event_Count_Percentile_;
    KEL.typ.nfloat Cl_Impact_Weight_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Percent_Flag_ := 0;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST17082_Layout __ND752097__Project(__ST752062_Layout __PP752061) := TRANSFORM
    SELF.Source_Customer_ := __PP752061._r_Customer_;
    SELF.Customer_Id_ := __PP752061.Customer_Id__1_;
    SELF.Industry_Type_ := __PP752061.Industry_Type__1_;
    SELF.Label_ := __PP752061.Street_Address_;
    SELF.Person_Count_ := __PP752061.Identity_Count_;
    SELF := __PP752061;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE752060,__ND752097__Project(LEFT)));
END;
