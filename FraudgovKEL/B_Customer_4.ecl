//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_4 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED __EE233687 := __E_Customer;
  EXPORT __NS233737_Layout := RECORD
    KEL.typ.nstr State_;
    KEL.typ.nint State_Count_;
  END;
  EXPORT __ST92169_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    __NS233737_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST92169_Layout __ND233723__Project(E_Customer.Layout __PP233601) := TRANSFORM
    __EE233639 := __PP233601.States_;
    __BS233698 := __T(__EE233639);
    __EE233709 := __BN(TOPN(__BS233698(__NN(__T(__EE233639).State_Count_)),1, -__T(__T(__EE233639).State_Count_),__T(State_)),__NL(__EE233639));
    __EE233710 := __EE233709;
    SELF.Jurisdiction_State_Top_ := (__T(__EE233710))[1];
    SELF := __PP233601;
  END;
  EXPORT __ENH_Customer_4 := PROJECT(__EE233687,__ND233723__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_4',EXPIRE(7));
END;
