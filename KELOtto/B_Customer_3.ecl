//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_4,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_4.__ENH_Customer_4) __ENH_Customer_4 := B_Customer_4.__ENH_Customer_4;
  SHARED __EE197256 := __ENH_Customer_4;
  EXPORT __ST58603_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS156185_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST58603_Layout __ND197272__Project(B_Customer_4.__ST60475_Layout __PP197187) := TRANSFORM
    SELF.Jurisdiction_State_ := __PP197187.Jurisdiction_State_Top_.State_;
    SELF := __PP197187;
  END;
  EXPORT __ENH_Customer_3 := PROJECT(__EE197256,__ND197272__Project(LEFT));
END;
