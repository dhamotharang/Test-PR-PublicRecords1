//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_4 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED __EE176716 := __E_Customer;
  EXPORT __NS176766_Layout := RECORD
    KEL.typ.nstr State_;
    KEL.typ.nint State_Count_;
  END;
  EXPORT __ST73648_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    __NS176766_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST73648_Layout __ND176752__Project(E_Customer.Layout __PP176630) := TRANSFORM
    __EE176668 := __PP176630.States_;
    __BS176727 := __T(__EE176668);
    __EE176738 := __BN(TOPN(__BS176727(__NN(__T(__EE176668).State_Count_)),1, -__T(__T(__EE176668).State_Count_),__T(State_)),__NL(__EE176668));
    __EE176739 := __EE176738;
    SELF.Jurisdiction_State_Top_ := (__T(__EE176739))[1];
    SELF := __PP176630;
  END;
  EXPORT __ENH_Customer_4 := PROJECT(__EE176716,__ND176752__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_4',EXPIRE(7));
END;
