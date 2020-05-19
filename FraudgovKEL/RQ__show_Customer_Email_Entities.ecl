//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer,B_Customer_4,B_Email,E_Customer,E_Email FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT RQ__show_Customer_Email_Entities := MODULE
  SHARED __EE2459127 := B_Email.IDX_Email_UID_Wrapped;
  SHARED __ST2459423_Layout := RECORD
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
  SHARED __EE2459438 := PROJECT(TABLE(PROJECT(__EE2459127,__ST2459423_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,Contributor_Safe_Flag_,Dt_First_Seen_,Dt_Last_Seen_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,In_Customer_Population_,Kr_High_Risk_Flag_,Kr_Low_Risk_Flag_,Kr_Medium_Risk_Flag_,Label_,Safe_Flag_},_r_Customer_,Contributor_Safe_Flag_,Dt_First_Seen_,Dt_Last_Seen_,Entity_Context_Uid_,Entity_Type_,Identity_Count_,In_Customer_Population_,Kr_High_Risk_Flag_,Kr_Low_Risk_Flag_,Kr_Medium_Risk_Flag_,Label_,Safe_Flag_,MERGE),__ST2459423_Layout);
  SHARED __EE2459303 := PROJECT(B_Customer.IDX_Customer_UID_Wrapped,E_Customer.Layout);
  SHARED __ST2459450_Layout := RECORD
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Customer_Id__1_;
    KEL.typ.nint Industry_Type__1_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST2459450_Layout __ND2459441__Project(E_Customer.Layout __PP2459440) := TRANSFORM
    SELF.U_I_D__1_ := __PP2459440.UID;
    SELF.Customer_Id__1_ := __PP2459440.Customer_Id_;
    SELF.Industry_Type__1_ := __PP2459440.Industry_Type_;
    SELF := __PP2459440;
  END;
  SHARED __EE2459460 := PROJECT(__EE2459303,__ND2459441__Project(LEFT));
  SHARED __ST2459493_Layout := RECORD
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
  __JC2459467(__ST2459423_Layout __EE2459438, __ST2459450_Layout __EE2459460) := __EEQP(__EE2459438._r_Customer_,__EE2459460.U_I_D__1_);
  __ST2459493_Layout __JT2459467(__ST2459423_Layout __l, __ST2459450_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE2459491 := JOIN(__EE2459438,__EE2459460,__JC2459467(LEFT,RIGHT),__JT2459467(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST2383526_Layout := RECORD
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
    KEL.typ.int Kr_High_Risk_Flag_ := 0;
    KEL.typ.int Kr_Medium_Risk_Flag_ := 0;
    KEL.typ.int Kr_Low_Risk_Flag_ := 0;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST2383526_Layout __ND2459519__Project(__ST2459493_Layout __PP2459492) := TRANSFORM
    SELF.Source_Customer_ := __PP2459492._r_Customer_;
    SELF.Customer_Id_ := __PP2459492.Customer_Id__1_;
    SELF.Industry_Type_ := __PP2459492.Industry_Type__1_;
    SELF.Person_Count_ := __PP2459492.Identity_Count_;
    SELF := __PP2459492;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE2459491,__ND2459519__Project(LEFT)));
END;
