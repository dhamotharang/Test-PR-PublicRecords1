//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_4 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED __EE96476 := __E_Customer;
  EXPORT __NS96526_Layout := RECORD
    KEL.typ.nstr State_;
    KEL.typ.nint State_Count_;
  END;
  EXPORT __ST41158_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    __NS96526_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST41158_Layout __ND96512__Project(E_Customer.Layout __PP96390) := TRANSFORM
    __EE96428 := __PP96390.States_;
    __BS96487 := __T(__EE96428);
    __EE96498 := __BN(TOPN(__BS96487(__NN(__T(__EE96428).State_Count_)),1, -__T(__T(__EE96428).State_Count_),__T(State_)),__NL(__EE96428));
    __EE96499 := __EE96498;
    SELF.Jurisdiction_State_Top_ := (__T(__EE96499))[1];
    SELF := __PP96390;
  END;
  EXPORT __ENH_Customer_4 := PROJECT(__EE96476,__ND96512__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_4',EXPIRE(7));
END;
