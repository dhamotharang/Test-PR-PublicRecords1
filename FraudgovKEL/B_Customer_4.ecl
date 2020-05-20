//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_4 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED __EE146412 := __E_Customer;
  EXPORT __NS146462_Layout := RECORD
    KEL.typ.nstr State_;
    KEL.typ.nint State_Count_;
  END;
  EXPORT __ST63724_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    __NS146462_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST63724_Layout __ND146448__Project(E_Customer.Layout __PP146326) := TRANSFORM
    __EE146364 := __PP146326.States_;
    __BS146423 := __T(__EE146364);
    __EE146434 := __BN(TOPN(__BS146423(__NN(__T(__EE146364).State_Count_)),1, -__T(__T(__EE146364).State_Count_),__T(State_)),__NL(__EE146364));
    __EE146435 := __EE146434;
    SELF.Jurisdiction_State_Top_ := (__T(__EE146435))[1];
    SELF := __PP146326;
  END;
  EXPORT __ENH_Customer_4 := PROJECT(__EE146412,__ND146448__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_4',EXPIRE(7));
END;
