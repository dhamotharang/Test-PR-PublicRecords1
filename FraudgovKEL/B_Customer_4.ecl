//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_4 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED __EE144517 := __E_Customer;
  EXPORT __NS144567_Layout := RECORD
    KEL.typ.nstr State_;
    KEL.typ.nint State_Count_;
  END;
  EXPORT __ST60814_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    __NS144567_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST60814_Layout __ND144553__Project(E_Customer.Layout __PP144431) := TRANSFORM
    __EE144469 := __PP144431.States_;
    __BS144528 := __T(__EE144469);
    __EE144539 := __BN(TOPN(__BS144528(__NN(__T(__EE144469).State_Count_)),1, -__T(__T(__EE144469).State_Count_),__T(State_)),__NL(__EE144469));
    __EE144540 := __EE144539;
    SELF.Jurisdiction_State_Top_ := (__T(__EE144540))[1];
    SELF := __PP144431;
  END;
  EXPORT __ENH_Customer_4 := PROJECT(__EE144517,__ND144553__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_4',EXPIRE(7));
END;
