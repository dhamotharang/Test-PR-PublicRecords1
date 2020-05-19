//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_4 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED __EE145942 := __E_Customer;
  EXPORT __NS145992_Layout := RECORD
    KEL.typ.nstr State_;
    KEL.typ.nint State_Count_;
  END;
  EXPORT __ST63702_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    __NS145992_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST63702_Layout __ND145978__Project(E_Customer.Layout __PP145856) := TRANSFORM
    __EE145894 := __PP145856.States_;
    __BS145953 := __T(__EE145894);
    __EE145964 := __BN(TOPN(__BS145953(__NN(__T(__EE145894).State_Count_)),1, -__T(__T(__EE145894).State_Count_),__T(State_)),__NL(__EE145894));
    __EE145965 := __EE145964;
    SELF.Jurisdiction_State_Top_ := (__T(__EE145965))[1];
    SELF := __PP145856;
  END;
  EXPORT __ENH_Customer_4 := PROJECT(__EE145942,__ND145978__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_4',EXPIRE(7));
END;
