//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_4 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED __EE97827 := __E_Customer;
  EXPORT __NS97877_Layout := RECORD
    KEL.typ.nstr State_;
    KEL.typ.nint State_Count_;
  END;
  EXPORT __ST38780_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    __NS97877_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST38780_Layout __ND97863__Project(E_Customer.Layout __PP97741) := TRANSFORM
    __EE97779 := __PP97741.States_;
    __BS97838 := __T(__EE97779);
    __EE97849 := __BN(TOPN(__BS97838(__NN(__T(__EE97779).State_Count_)),1, -__T(__T(__EE97779).State_Count_),__T(State_)),__NL(__EE97779));
    __EE97850 := __EE97849;
    SELF.Jurisdiction_State_Top_ := (__T(__EE97850))[1];
    SELF := __PP97741;
  END;
  EXPORT __ENH_Customer_4 := PROJECT(__EE97827,__ND97863__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_4',EXPIRE(7));
END;
