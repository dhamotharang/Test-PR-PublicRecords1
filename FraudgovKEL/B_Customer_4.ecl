//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_5,E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_4 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_5.__ENH_Customer_5) __ENH_Customer_5 := B_Customer_5.__ENH_Customer_5;
  SHARED __EE192272 := __ENH_Customer_5;
  EXPORT __ST95420_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nunk _ind__type__description_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_5.__NS142387_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST95420_Layout __ND192288__Project(B_Customer_5.__ST98622_Layout __PP192203) := TRANSFORM
    SELF.Jurisdiction_State_ := __PP192203.Jurisdiction_State_Top_.State_;
    SELF := __PP192203;
  END;
  EXPORT __ENH_Customer_4 := PROJECT(__EE192272,__ND192288__Project(LEFT));
END;
