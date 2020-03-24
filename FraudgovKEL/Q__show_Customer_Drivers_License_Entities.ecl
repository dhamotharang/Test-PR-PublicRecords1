﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Drivers_License,E_Customer,E_Drivers_License FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Drivers_License_Entities := MODULE
  SHARED TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED TYPEOF(B_Drivers_License.__ENH_Drivers_License) __ENH_Drivers_License := B_Drivers_License.__ENH_Drivers_License;
  SHARED __EE1278018 := __ENH_Drivers_License;
  SHARED __ST1278324_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.nstr State_;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.nstr Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE1278340 := PROJECT(TABLE(PROJECT(__EE1278018,__ST1278324_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,State_,Contributor_Safe_Flag_,Dt_First_Seen_,Dt_Last_Seen_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,In_Customer_Population_,Kr_High_Risk_Flag_,Kr_Low_Risk_Flag_,Kr_Medium_Risk_Flag_,Label_,Safe_Flag_},_r_Customer_,State_,Contributor_Safe_Flag_,Dt_First_Seen_,Dt_Last_Seen_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,In_Customer_Population_,Kr_High_Risk_Flag_,Kr_Low_Risk_Flag_,Kr_Medium_Risk_Flag_,Label_,Safe_Flag_,MERGE),__ST1278324_Layout);
  SHARED __EE1277954 := __E_Customer;
  SHARED __ST1278352_Layout := RECORD
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST1278352_Layout __ND1278343__Project(E_Customer.Layout __PP1278342) := TRANSFORM
    SELF.U_I_D__1_ := __PP1278342.UID;
    SELF.Customer_Id__1_ := __PP1278342.Customer_Id_;
    SELF.Industry_Type__1_ := __PP1278342.Industry_Type_;
    SELF := __PP1278342;
  END;
  SHARED __EE1278362 := PROJECT(__EE1277954,__ND1278343__Project(LEFT));
  SHARED __ST1278396_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.nstr State_;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.nstr Entity_Context_Uid_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.nstr Label_;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1278369(__ST1278324_Layout __EE1278340, __ST1278352_Layout __EE1278362) := __EEQP(__EE1278340._r_Customer_,__EE1278362.U_I_D__1_);
  __ST1278396_Layout __JT1278369(__ST1278324_Layout __l, __ST1278352_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1278394 := JOIN(__EE1278340,__EE1278362,__JC1278369(LEFT,RIGHT),__JT1278369(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST21398_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nstr Entity_Context_Uid_;
    KEL.typ.nstr Label_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.nstr License_State_;
    KEL.typ.int In_Customer_Population__1_ := 0;
    KEL.typ.int Contributor_Safe_Flag__1_ := 0;
    KEL.typ.int Safe_Flag__1_ := 0;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Flag_ := 0;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST21398_Layout __ND1278423__Project(__ST1278396_Layout __PP1278395) := TRANSFORM
    SELF.Source_Customer_ := __PP1278395._r_Customer_;
    SELF.Customer_Id_ := __PP1278395.Customer_Id__1_;
    SELF.Industry_Type_ := __PP1278395.Industry_Type__1_;
    SELF.Person_Count_ := __PP1278395.Identity_Count_;
    SELF.License_State_ := __PP1278395.State_;
    SELF.In_Customer_Population__1_ := __PP1278395.In_Customer_Population_;
    SELF.Contributor_Safe_Flag__1_ := __PP1278395.Contributor_Safe_Flag_;
    SELF.Safe_Flag__1_ := __PP1278395.Safe_Flag_;
    SELF := __PP1278395;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE1278394,__ND1278423__Project(LEFT)));
END;
