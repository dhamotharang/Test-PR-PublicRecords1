﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Address,E_Address,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Address_Entities := MODULE
  SHARED TYPEOF(B_Address.__ENH_Address) __ENH_Address := B_Address.__ENH_Address;
  SHARED TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED __EE2528015 := __ENH_Address;
  SHARED __ST2528707_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.nstr Vanity_City_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Zip_;
    KEL.typ.nfloat Latitude_;
    KEL.typ.nfloat Longitude_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_ := 0;
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
    KEL.typ.nint Cluster_Score_;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.nstr Entity_Context_Uid_;
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
  SHARED __EE2528744 := PROJECT(TABLE(PROJECT(__EE2528015,__ST2528707_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,Vanity_City_,State_,Zip_,Latitude_,Longitude_,All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_,Cl_Address_Count_,Cl_Element_Count_,Cl_Event_Count_,Cl_Event_Count_Percentile_,Cl_High_Risk_Pattern1_Flag_,Cl_High_Risk_Pattern2_Flag_,Cl_High_Risk_Pattern3_Flag_,Cl_High_Risk_Pattern4_Flag_,Cl_High_Risk_Pattern5_Flag_,Cl_Identity_Count_,Cl_Identity_Count_Percentile_,Cl_Impact_Weight_,Cluster_Score_,Contributor_Safe_Flag_,Deceased_Person_Count_,Dt_First_Seen_,Dt_Last_Seen_,Entity_Context_Uid_,Entity_Type_,High_Frequency_Flag_,High_Risk_Death_Prior_To_All_Events_Percent_Flag_,Identity_Count_,In_Customer_Population_,Kr_High_Risk_Flag_,Kr_Medium_Risk_Flag_,Safe_Flag_,Score_,Street_Address_},_r_Customer_,Vanity_City_,State_,Zip_,Latitude_,Longitude_,All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_,Cl_Address_Count_,Cl_Element_Count_,Cl_Event_Count_,Cl_Event_Count_Percentile_,Cl_High_Risk_Pattern1_Flag_,Cl_High_Risk_Pattern2_Flag_,Cl_High_Risk_Pattern3_Flag_,Cl_High_Risk_Pattern4_Flag_,Cl_High_Risk_Pattern5_Flag_,Cl_Identity_Count_,Cl_Identity_Count_Percentile_,Cl_Impact_Weight_,Cluster_Score_,Contributor_Safe_Flag_,Deceased_Person_Count_,Dt_First_Seen_,Dt_Last_Seen_,Entity_Context_Uid_,Entity_Type_,High_Frequency_Flag_,High_Risk_Death_Prior_To_All_Events_Percent_Flag_,Identity_Count_,In_Customer_Population_,Kr_High_Risk_Flag_,Kr_Medium_Risk_Flag_,Safe_Flag_,Score_,Street_Address_,MERGE),__ST2528707_Layout);
  SHARED __EE2527891 := __E_Customer;
  SHARED __ST2528756_Layout := RECORD
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST2528756_Layout __ND2528747__Project(E_Customer.Layout __PP2528746) := TRANSFORM
    SELF.U_I_D__1_ := __PP2528746.UID;
    SELF.Customer_Id__1_ := __PP2528746.Customer_Id_;
    SELF.Industry_Type__1_ := __PP2528746.Industry_Type_;
    SELF := __PP2528746;
  END;
  SHARED __EE2528766 := PROJECT(__EE2527891,__ND2528747__Project(LEFT));
  SHARED __ST2528821_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.nstr Vanity_City_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Zip_;
    KEL.typ.nfloat Latitude_;
    KEL.typ.nfloat Longitude_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_ := 0;
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
    KEL.typ.nint Cluster_Score_;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.nstr Entity_Context_Uid_;
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
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC2528773(__ST2528707_Layout __EE2528744, __ST2528756_Layout __EE2528766) := __EEQP(__EE2528744._r_Customer_,__EE2528766.U_I_D__1_);
  __ST2528821_Layout __JT2528773(__ST2528707_Layout __l, __ST2528756_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE2528819 := JOIN(__EE2528744,__EE2528766,__JC2528773(LEFT,RIGHT),__JT2528773(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST27984_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nstr Entity_Context_Uid_;
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
    KEL.typ.nint Cluster_Score__1_;
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
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.int High_Frequency_Flag_ := 0;
    KEL.typ.int High_Risk_Death_Prior_To_All_Events_Percent_Flag_ := 0;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_ := 0;
    KEL.typ.int Deceased_Person_Count_ := 0;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST27984_Layout __ND2528869__Project(__ST2528821_Layout __PP2528820) := TRANSFORM
    SELF.Source_Customer_ := __PP2528820._r_Customer_;
    SELF.Customer_Id_ := __PP2528820.Customer_Id__1_;
    SELF.Industry_Type_ := __PP2528820.Industry_Type__1_;
    SELF.Label_ := __PP2528820.Street_Address_;
    SELF.Cluster_Score__1_ := __PP2528820.Cluster_Score_;
    SELF.Person_Count_ := __PP2528820.Identity_Count_;
    SELF := __PP2528820;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE2528819,__ND2528869__Project(LEFT)));
END;
