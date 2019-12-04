//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_5,B_Customer_6,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_4 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_5.__ENH_Customer_5) __ENH_Customer_5 := B_Customer_5.__ENH_Customer_5;
  SHARED __EE147389 := __ENH_Customer_5;
  EXPORT __NS147442_Layout := RECORD
    KEL.typ.nstr State_;
    KEL.typ.nint State_Count_;
  END;
  EXPORT __ST56424_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    __NS147442_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST56424_Layout __ND147427__Project(B_Customer_6.__ST58877_Layout __PP147298) := TRANSFORM
    __EE147340 := __PP147298.States_;
    __BS147401 := __T(__EE147340);
    __EE147412 := __BN(TOPN(__BS147401(__NN(__T(__EE147340).State_Count_)),1, -__T(__T(__EE147340).State_Count_),__T(State_)),__NL(__EE147340));
    __EE147413 := __EE147412;
    SELF.Jurisdiction_State_Top_ := (__T(__EE147413))[1];
    SELF := __PP147298;
  END;
  EXPORT __ENH_Customer_4 := PROJECT(__EE147389,__ND147427__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Customer::Annotated_4',EXPIRE(7));
END;
