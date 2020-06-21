//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_4 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED __EE227799 := __E_Customer;
  EXPORT __NS227849_Layout := RECORD
    KEL.typ.nstr State_;
    KEL.typ.nint State_Count_;
  END;
  EXPORT __ST90982_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    __NS227849_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST90982_Layout __ND227835__Project(E_Customer.Layout __PP227713) := TRANSFORM
    __EE227751 := __PP227713.States_;
    __BS227810 := __T(__EE227751);
    __EE227821 := __BN(TOPN(__BS227810(__NN(__T(__EE227751).State_Count_)),1, -__T(__T(__EE227751).State_Count_),__T(State_)),__NL(__EE227751));
    __EE227822 := __EE227821;
    SELF.Jurisdiction_State_Top_ := (__T(__EE227822))[1];
    SELF := __PP227713;
  END;
  EXPORT __ENH_Customer_4 := PROJECT(__EE227799,__ND227835__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_4',EXPIRE(7));
END;
