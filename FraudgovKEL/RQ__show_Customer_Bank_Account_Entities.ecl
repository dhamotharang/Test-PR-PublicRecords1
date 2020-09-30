﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Bank,B_Bank_2,B_Bank_Account,B_Customer,B_Customer_4,E_Bank,E_Bank_Account,E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Bank_Account_Entities := MODULE
  SHARED __EE4218852 := B_Bank_Account.IDX_Bank_Account_UID_Wrapped;
  SHARED __ST4219305_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Bank.Typ) _r_Bank_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nstr Abbreviated_Bankname_;
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
  SHARED __EE4219323 := PROJECT(TABLE(PROJECT(__EE4218852,__ST4219305_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,_r_Bank_,Account_Number_,Abbreviated_Bankname_,Contributor_Safe_Flag_,Dt_First_Seen_,Dt_Last_Seen_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,In_Customer_Population_,Kr_High_Risk_Flag_,Kr_Low_Risk_Flag_,Kr_Medium_Risk_Flag_,Label_,Safe_Flag_},_r_Customer_,_r_Bank_,Account_Number_,Abbreviated_Bankname_,Contributor_Safe_Flag_,Dt_First_Seen_,Dt_Last_Seen_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,In_Customer_Population_,Kr_High_Risk_Flag_,Kr_Low_Risk_Flag_,Kr_Medium_Risk_Flag_,Label_,Safe_Flag_,MERGE),__ST4219305_Layout);
  SHARED __EE4219179 := PROJECT(B_Customer.IDX_Customer_UID_Wrapped,E_Customer.Layout);
  SHARED __ST4219335_Layout := RECORD
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST4219335_Layout __ND4219326__Project(E_Customer.Layout __PP4219325) := TRANSFORM
    SELF.U_I_D__1_ := __PP4219325.UID;
    SELF.Customer_Id__1_ := __PP4219325.Customer_Id_;
    SELF.Industry_Type__1_ := __PP4219325.Industry_Type_;
    SELF := __PP4219325;
  END;
  SHARED __EE4219345 := PROJECT(__EE4219179,__ND4219326__Project(LEFT));
  SHARED __ST4219381_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Bank.Typ) _r_Bank_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nstr Abbreviated_Bankname_;
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
  __JC4219352(__ST4219305_Layout __EE4219323, __ST4219335_Layout __EE4219345) := __EEQP(__EE4219323._r_Customer_,__EE4219345.U_I_D__1_);
  __ST4219381_Layout __JT4219352(__ST4219305_Layout __l, __ST4219335_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4219379 := JOIN(__EE4219323,__EE4219345,__JC4219352(LEFT,RIGHT),__JT4219352(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE4219408 := PROJECT(B_Bank.IDX_Bank_UID_Wrapped,E_Bank.Layout);
  SHARED __ST4147688_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Bank.Typ) _r_Bank_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nstr Abbreviated_Bankname_;
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
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer__1_;
    KEL.typ.ndataset(E_Bank.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Routing_Number_;
    KEL.typ.nstr Full_Bankname_;
    KEL.typ.nstr Abbreviated_Bankname__1_;
    KEL.typ.nstr Fractional_Routingnumber_;
    KEL.typ.nstr Headoffice_Routingnumber_;
    KEL.typ.nstr Headoffice_Branchcodes_;
    KEL.typ.nstr _hit_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC4219429(__ST4219381_Layout __EE4219379, E_Bank.Layout __EE4219408) := __EEQP(__EE4219379._r_Bank_,__EE4219408.UID);
  __ST4147688_Layout __JT4219429(__ST4219381_Layout __l, E_Bank.Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF.Abbreviated_Bankname__1_ := __r.Abbreviated_Bankname_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4219470 := JOIN(__EE4219379,__EE4219408,__JC4219429(LEFT,RIGHT),__JT4219429(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST4147351_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nstr Entity_Context_Uid_;
    KEL.typ.nstr Label_;
    KEL.typ.int Entity_Type_ := 0;
    KEL.typ.nstr Routing_Number_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nstr Abbreviated_Bankname_;
    KEL.typ.int Person_Count_ := 0;
    KEL.typ.int In_Customer_Population_ := 0;
    KEL.typ.int Contributor_Safe_Flag_ := 0;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Flag_ := 0;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST4147351_Layout __ND4219515__Project(__ST4147688_Layout __PP4219471) := TRANSFORM
    SELF.Source_Customer_ := __PP4219471._r_Customer_;
    SELF.Customer_Id_ := __PP4219471.Customer_Id__1_;
    SELF.Industry_Type_ := __PP4219471.Industry_Type__1_;
    SELF.Person_Count_ := __PP4219471.Identity_Count_;
    SELF := __PP4219471;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(TABLE(PROJECT(__EE4219470,__ND4219515__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_Customer_,Customer_Id_,Industry_Type_,Entity_Context_Uid_,Label_,Entity_Type_,Routing_Number_,Account_Number_,Abbreviated_Bankname_,Person_Count_,In_Customer_Population_,Contributor_Safe_Flag_,Safe_Flag_,Kr_High_Risk_Flag_,Kr_Medium_Risk_Flag_,Kr_Low_Risk_Flag_,Dt_First_Seen_,Dt_Last_Seen_},Source_Customer_,Customer_Id_,Industry_Type_,Entity_Context_Uid_,Label_,Entity_Type_,Routing_Number_,Account_Number_,Abbreviated_Bankname_,Person_Count_,In_Customer_Population_,Contributor_Safe_Flag_,Safe_Flag_,Kr_High_Risk_Flag_,Kr_Medium_Risk_Flag_,Kr_Low_Risk_Flag_,Dt_First_Seen_,Dt_Last_Seen_,MERGE),__ST4147351_Layout));
END;
