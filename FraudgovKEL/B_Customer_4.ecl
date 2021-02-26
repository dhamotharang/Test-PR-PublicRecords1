//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_5,E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_4 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_5.__ENH_Customer_5) __ENH_Customer_5 := B_Customer_5.__ENH_Customer_5;
  SHARED __EE181591 := __ENH_Customer_5;
  EXPORT __ST94236_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nunk _ind__type__description_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_5.__NS141131_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST94236_Layout __ND181607__Project(B_Customer_5.__ST97404_Layout __PP181522) := TRANSFORM
    SELF.Jurisdiction_State_ := __PP181522.Jurisdiction_State_Top_.State_;
    SELF := __PP181522;
  END;
  EXPORT __ENH_Customer_4 := PROJECT(__EE181591,__ND181607__Project(LEFT));
END;
