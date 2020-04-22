//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer,B_Customer_4,B_Internet_Protocol,E_Customer,E_Internet_Protocol FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Ip_Address_Entities := MODULE
  SHARED __EE1352462 := B_Internet_Protocol.IDX_Internet_Protocol_UID_Wrapped;
  SHARED __ST1352892_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
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
  SHARED __EE1352907 := PROJECT(TABLE(PROJECT(__EE1352462,__ST1352892_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,Contributor_Safe_Flag_,Dt_First_Seen_,Dt_Last_Seen_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,In_Customer_Population_,Kr_High_Risk_Flag_,Kr_Low_Risk_Flag_,Kr_Medium_Risk_Flag_,Label_,Safe_Flag_},_r_Customer_,Contributor_Safe_Flag_,Dt_First_Seen_,Dt_Last_Seen_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,In_Customer_Population_,Kr_High_Risk_Flag_,Kr_Low_Risk_Flag_,Kr_Medium_Risk_Flag_,Label_,Safe_Flag_,MERGE),__ST1352892_Layout);
  SHARED __EE1352705 := PROJECT(B_Customer.IDX_Customer_UID_Wrapped,E_Customer.Layout);
  SHARED __ST1352919_Layout := RECORD
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST1352919_Layout __ND1352910__Project(E_Customer.Layout __PP1352909) := TRANSFORM
    SELF.U_I_D__1_ := __PP1352909.UID;
    SELF.Customer_Id__1_ := __PP1352909.Customer_Id_;
    SELF.Industry_Type__1_ := __PP1352909.Industry_Type_;
    SELF := __PP1352909;
  END;
  SHARED __EE1352929 := PROJECT(__EE1352705,__ND1352910__Project(LEFT));
  SHARED __ST1352962_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
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
  __JC1352936(__ST1352892_Layout __EE1352907, __ST1352919_Layout __EE1352929) := __EEQP(__EE1352907._r_Customer_,__EE1352929.U_I_D__1_);
  __ST1352962_Layout __JT1352936(__ST1352892_Layout __l, __ST1352919_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1352960 := JOIN(__EE1352907,__EE1352929,__JC1352936(LEFT,RIGHT),__JT1352936(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST1284370_Layout := RECORD
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
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Flag_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST1284370_Layout __ND1352988__Project(__ST1352962_Layout __PP1352961) := TRANSFORM
    SELF.Source_Customer_ := __PP1352961._r_Customer_;
    SELF.Customer_Id_ := __PP1352961.Customer_Id__1_;
    SELF.Industry_Type_ := __PP1352961.Industry_Type__1_;
    SELF.Person_Count_ := __PP1352961.Identity_Count_;
    SELF := __PP1352961;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE1352960,__ND1352988__Project(LEFT)));
END;
