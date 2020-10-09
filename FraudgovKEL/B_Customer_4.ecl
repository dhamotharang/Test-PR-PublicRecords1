//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_4 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED __EE188593 := __E_Customer;
  EXPORT __NS188643_Layout := RECORD
    KEL.typ.nstr State_;
    KEL.typ.nint State_Count_;
  END;
  EXPORT __ST91942_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    __NS188643_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST91942_Layout __ND188629__Project(E_Customer.Layout __PP188507) := TRANSFORM
    __EE188545 := __PP188507.States_;
    __BS188604 := __T(__EE188545);
    __EE188615 := __BN(TOPN(__BS188604(__NN(__T(__EE188545).State_Count_)),1, -__T(__T(__EE188545).State_Count_),__T(State_)),__NL(__EE188545));
    __EE188616 := __EE188615;
    SELF.Jurisdiction_State_Top_ := (__T(__EE188616))[1];
    SELF := __PP188507;
  END;
  EXPORT __ENH_Customer_4 := PROJECT(__EE188593,__ND188629__Project(LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Customer::Annotated_4',EXPIRE(7));
END;
