﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Address,B_Customer,B_Customer_4,E_Address,E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Address_Entities := MODULE
  SHARED __EE1336795 := B_Address.IDX_Address_UID_Wrapped;
  SHARED __ST1337223_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.nstr Vanity_City_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Zip_;
    KEL.typ.nfloat Latitude_;
    KEL.typ.nfloat Longitude_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_ := 0;
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
    KEL.typ.int Kr_Low_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.nstr Street_Address_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE1337247 := PROJECT(TABLE(PROJECT(__EE1336795,__ST1337223_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,Vanity_City_,State_,Zip_,Latitude_,Longitude_,All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_,Contributor_Safe_Flag_,Deceased_Person_Count_,Dt_First_Seen_,Dt_Last_Seen_,Entity_Context_Uid_,Entity_Type_,High_Frequency_Flag_,High_Risk_Death_Prior_To_All_Events_Percent_Flag_,Identity_Count_,In_Customer_Population_,Kr_High_Risk_Flag_,Kr_Low_Risk_Flag_,Kr_Medium_Risk_Flag_,Safe_Flag_,Street_Address_},_r_Customer_,Vanity_City_,State_,Zip_,Latitude_,Longitude_,All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_,Contributor_Safe_Flag_,Deceased_Person_Count_,Dt_First_Seen_,Dt_Last_Seen_,Entity_Context_Uid_,Entity_Type_,High_Frequency_Flag_,High_Risk_Death_Prior_To_All_Events_Percent_Flag_,Identity_Count_,In_Customer_Population_,Kr_High_Risk_Flag_,Kr_Low_Risk_Flag_,Kr_Medium_Risk_Flag_,Safe_Flag_,Street_Address_,MERGE),__ST1337223_Layout);
  SHARED __EE1337048 := PROJECT(B_Customer.IDX_Customer_UID_Wrapped,E_Customer.Layout);
  SHARED __ST1337259_Layout := RECORD
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST1337259_Layout __ND1337250__Project(E_Customer.Layout __PP1337249) := TRANSFORM
    SELF.U_I_D__1_ := __PP1337249.UID;
    SELF.Customer_Id__1_ := __PP1337249.Customer_Id_;
    SELF.Industry_Type__1_ := __PP1337249.Industry_Type_;
    SELF := __PP1337249;
  END;
  SHARED __EE1337269 := PROJECT(__EE1337048,__ND1337250__Project(LEFT));
  SHARED __ST1337311_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.nstr Vanity_City_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Zip_;
    KEL.typ.nfloat Latitude_;
    KEL.typ.nfloat Longitude_;
    KEL.typ.int All_High_Risk_Death_Prior_To_All_Events_Person_Percent_Flag_ := 0;
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
    KEL.typ.int Kr_Low_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.nstr Street_Address_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1337276(__ST1337223_Layout __EE1337247, __ST1337259_Layout __EE1337269) := __EEQP(__EE1337247._r_Customer_,__EE1337269.U_I_D__1_);
  __ST1337311_Layout __JT1337276(__ST1337223_Layout __l, __ST1337259_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1337309 := JOIN(__EE1337247,__EE1337269,__JC1337276(LEFT,RIGHT),__JT1337276(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST1268991_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nstr Entity_Context_Uid_;
    KEL.typ.nstr Label_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.nfloat Latitude_;
    KEL.typ.nfloat Longitude_;
    KEL.typ.nstr Street_Address_;
    KEL.typ.nstr Vanity_City_;
    KEL.typ.nstr State_;
    KEL.typ.nstr Zip_;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Flag_ := 0;
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
  SHARED __ST1268991_Layout __ND1337346__Project(__ST1337311_Layout __PP1337310) := TRANSFORM
    SELF.Source_Customer_ := __PP1337310._r_Customer_;
    SELF.Customer_Id_ := __PP1337310.Customer_Id__1_;
    SELF.Industry_Type_ := __PP1337310.Industry_Type__1_;
    SELF.Label_ := __PP1337310.Street_Address_;
    SELF.Person_Count_ := __PP1337310.Identity_Count_;
    SELF := __PP1337310;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE1337309,__ND1337346__Project(LEFT)));
END;
