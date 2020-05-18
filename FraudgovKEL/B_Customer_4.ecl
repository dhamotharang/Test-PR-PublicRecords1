//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_4 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED __EE142431 := __E_Customer;
  EXPORT __NS142481_Layout := RECORD
    KEL.typ.nstr State_;
    KEL.typ.nint State_Count_;
  END;
  EXPORT __ST63551_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    __NS142481_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST63551_Layout __ND142467__Project(E_Customer.Layout __PP142345) := TRANSFORM
    __EE142383 := __PP142345.States_;
    __BS142442 := __T(__EE142383);
    __EE142453 := __BN(TOPN(__BS142442(__NN(__T(__EE142383).State_Count_)),1, -__T(__T(__EE142383).State_Count_),__T(State_)),__NL(__EE142383));
    __EE142454 := __EE142453;
    SELF.Jurisdiction_State_Top_ := (__T(__EE142454))[1];
    SELF := __PP142345;
  END;
  EXPORT __ENH_Customer_4 := PROJECT(__EE142431,__ND142467__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_4',EXPIRE(7));
END;
