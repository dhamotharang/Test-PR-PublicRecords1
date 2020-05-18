//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_4 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED __EE142900 := __E_Customer;
  EXPORT __NS142950_Layout := RECORD
    KEL.typ.nstr State_;
    KEL.typ.nint State_Count_;
  END;
  EXPORT __ST63572_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    __NS142950_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST63572_Layout __ND142936__Project(E_Customer.Layout __PP142814) := TRANSFORM
    __EE142852 := __PP142814.States_;
    __BS142911 := __T(__EE142852);
    __EE142922 := __BN(TOPN(__BS142911(__NN(__T(__EE142852).State_Count_)),1, -__T(__T(__EE142852).State_Count_),__T(State_)),__NL(__EE142852));
    __EE142923 := __EE142922;
    SELF.Jurisdiction_State_Top_ := (__T(__EE142923))[1];
    SELF := __PP142814;
  END;
  EXPORT __ENH_Customer_4 := PROJECT(__EE142900,__ND142936__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_4',EXPIRE(7));
END;
