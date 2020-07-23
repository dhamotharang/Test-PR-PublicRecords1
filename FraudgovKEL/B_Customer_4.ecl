//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_4 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED __EE235853 := __E_Customer;
  EXPORT __NS235903_Layout := RECORD
    KEL.typ.nstr State_;
    KEL.typ.nint State_Count_;
  END;
  EXPORT __ST92833_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    __NS235903_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST92833_Layout __ND235889__Project(E_Customer.Layout __PP235767) := TRANSFORM
    __EE235805 := __PP235767.States_;
    __BS235864 := __T(__EE235805);
    __EE235875 := __BN(TOPN(__BS235864(__NN(__T(__EE235805).State_Count_)),1, -__T(__T(__EE235805).State_Count_),__T(State_)),__NL(__EE235805));
    __EE235876 := __EE235875;
    SELF.Jurisdiction_State_Top_ := (__T(__EE235876))[1];
    SELF := __PP235767;
  END;
  EXPORT __ENH_Customer_4 := PROJECT(__EE235853,__ND235889__Project(LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Customer::Annotated_4',EXPIRE(7));
END;
