//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED __EE142334 := __E_Customer;
  EXPORT __NS142387_Layout := RECORD
    KEL.typ.nstr State_;
    KEL.typ.nint State_Count_;
  END;
  EXPORT __ST98622_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nunk _ind__type__description_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    __NS142387_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST98622_Layout __ND142372__Project(E_Customer.Layout __PP142243) := TRANSFORM
    __EE142285 := __PP142243.States_;
    __BS142346 := __T(__EE142285);
    __EE142357 := __BN(TOPN(__BS142346(__NN(__T(__EE142285).State_Count_)),1, -__T(__T(__EE142285).State_Count_),__T(State_)),__NL(__EE142285));
    __EE142358 := __EE142357;
    SELF.Jurisdiction_State_Top_ := (__T(__EE142358))[1];
    SELF := __PP142243;
  END;
  EXPORT __ENH_Customer_5 := PROJECT(__EE142334,__ND142372__Project(LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Customer::Annotated_5',EXPIRE(7));
END;
