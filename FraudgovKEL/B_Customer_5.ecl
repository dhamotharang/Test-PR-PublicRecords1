//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED __EE141078 := __E_Customer;
  EXPORT __NS141131_Layout := RECORD
    KEL.typ.nstr State_;
    KEL.typ.nint State_Count_;
  END;
  EXPORT __ST97404_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nunk _ind__type__description_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    __NS141131_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST97404_Layout __ND141116__Project(E_Customer.Layout __PP140987) := TRANSFORM
    __EE141029 := __PP140987.States_;
    __BS141090 := __T(__EE141029);
    __EE141101 := __BN(TOPN(__BS141090(__NN(__T(__EE141029).State_Count_)),1, -__T(__T(__EE141029).State_Count_),__T(State_)),__NL(__EE141029));
    __EE141102 := __EE141101;
    SELF.Jurisdiction_State_Top_ := (__T(__EE141102))[1];
    SELF := __PP140987;
  END;
  EXPORT __ENH_Customer_5 := PROJECT(__EE141078,__ND141116__Project(LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Customer::Annotated_5',EXPIRE(7));
END;
