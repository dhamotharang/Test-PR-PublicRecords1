﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Bank_Account,E_Bank,E_Bank_Account,E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT Q__show_Customer_Bank_Account_Entities := MODULE
  SHARED TYPEOF(E_Bank.__Result) __E_Bank := E_Bank.__Result;
  SHARED TYPEOF(B_Bank_Account.__ENH_Bank_Account) __ENH_Bank_Account := B_Bank_Account.__ENH_Bank_Account;
  SHARED TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED __EE4749195 := __ENH_Bank_Account;
  SHARED __ST4749838_Layout := RECORD
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
  SHARED __EE4749856 := PROJECT(TABLE(PROJECT(__EE4749195,__ST4749838_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,_r_Bank_,Account_Number_,Abbreviated_Bankname_,Contributor_Safe_Flag_,Dt_First_Seen_,Dt_Last_Seen_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,In_Customer_Population_,Kr_High_Risk_Flag_,Kr_Low_Risk_Flag_,Kr_Medium_Risk_Flag_,Label_,Safe_Flag_},_r_Customer_,_r_Bank_,Account_Number_,Abbreviated_Bankname_,Contributor_Safe_Flag_,Dt_First_Seen_,Dt_Last_Seen_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,In_Customer_Population_,Kr_High_Risk_Flag_,Kr_Low_Risk_Flag_,Kr_Medium_Risk_Flag_,Label_,Safe_Flag_,MERGE),__ST4749838_Layout);
  SHARED __EE4749123 := __E_Customer;
  SHARED __ST4749868_Layout := RECORD
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST4749868_Layout __ND4749859__Project(E_Customer.Layout __PP4749858) := TRANSFORM
    SELF.U_I_D__1_ := __PP4749858.UID;
    SELF.Customer_Id__1_ := __PP4749858.Customer_Id_;
    SELF.Industry_Type__1_ := __PP4749858.Industry_Type_;
    SELF := __PP4749858;
  END;
  SHARED __EE4749878 := PROJECT(__EE4749123,__ND4749859__Project(LEFT));
  SHARED __ST4749914_Layout := RECORD
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
  __JC4749885(__ST4749838_Layout __EE4749856, __ST4749868_Layout __EE4749878) := __EEQP(__EE4749856._r_Customer_,__EE4749878.U_I_D__1_);
  __ST4749914_Layout __JT4749885(__ST4749838_Layout __l, __ST4749868_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4749912 := JOIN(__EE4749856,__EE4749878,__JC4749885(LEFT,RIGHT),__JT4749885(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE4749144 := __E_Bank;
  SHARED __ST4749400_Layout := RECORD
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
  __JC4749944(__ST4749914_Layout __EE4749912, E_Bank.Layout __EE4749144) := __EEQP(__EE4749912._r_Bank_,__EE4749144.UID);
  __ST4749400_Layout __JT4749944(__ST4749914_Layout __l, E_Bank.Layout __r) := TRANSFORM
    SELF._r_Customer__1_ := __r._r_Customer_;
    SELF.Abbreviated_Bankname__1_ := __r.Abbreviated_Bankname_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4749985 := JOIN(__EE4749912,__EE4749144,__JC4749944(LEFT,RIGHT),__JT4749944(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST47748_Layout := RECORD
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
  SHARED __ST47748_Layout __ND4750030__Project(__ST4749400_Layout __PP4749986) := TRANSFORM
    SELF.Source_Customer_ := __PP4749986._r_Customer_;
    SELF.Customer_Id_ := __PP4749986.Customer_Id__1_;
    SELF.Industry_Type_ := __PP4749986.Industry_Type__1_;
    SELF.Person_Count_ := __PP4749986.Identity_Count_;
    SELF := __PP4749986;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(TABLE(PROJECT(__EE4749985,__ND4750030__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_Customer_,Customer_Id_,Industry_Type_,Entity_Context_Uid_,Label_,Entity_Type_,Routing_Number_,Account_Number_,Abbreviated_Bankname_,Person_Count_,In_Customer_Population_,Contributor_Safe_Flag_,Safe_Flag_,Kr_High_Risk_Flag_,Kr_Medium_Risk_Flag_,Kr_Low_Risk_Flag_,Dt_First_Seen_,Dt_Last_Seen_},Source_Customer_,Customer_Id_,Industry_Type_,Entity_Context_Uid_,Label_,Entity_Type_,Routing_Number_,Account_Number_,Abbreviated_Bankname_,Person_Count_,In_Customer_Population_,Contributor_Safe_Flag_,Safe_Flag_,Kr_High_Risk_Flag_,Kr_Medium_Risk_Flag_,Kr_Low_Risk_Flag_,Dt_First_Seen_,Dt_Last_Seen_,MERGE),__ST47748_Layout));
END;
