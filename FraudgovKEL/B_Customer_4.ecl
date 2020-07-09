//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_4 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED __EE235915 := __E_Customer;
  EXPORT __NS235965_Layout := RECORD
    KEL.typ.nstr State_;
    KEL.typ.nint State_Count_;
  END;
  EXPORT __ST92895_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    __NS235965_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST92895_Layout __ND235951__Project(E_Customer.Layout __PP235829) := TRANSFORM
    __EE235867 := __PP235829.States_;
    __BS235926 := __T(__EE235867);
    __EE235937 := __BN(TOPN(__BS235926(__NN(__T(__EE235867).State_Count_)),1, -__T(__T(__EE235867).State_Count_),__T(State_)),__NL(__EE235867));
    __EE235938 := __EE235937;
    SELF.Jurisdiction_State_Top_ := (__T(__EE235938))[1];
    SELF := __PP235829;
  END;
  EXPORT __ENH_Customer_4 := PROJECT(__EE235915,__ND235951__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_4',EXPIRE(7));
END;
