//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_4 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED __EE97526 := __E_Customer;
  EXPORT __NS97576_Layout := RECORD
    KEL.typ.nstr State_;
    KEL.typ.nint State_Count_;
  END;
  EXPORT __ST38669_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    __NS97576_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST38669_Layout __ND97562__Project(E_Customer.Layout __PP97440) := TRANSFORM
    __EE97478 := __PP97440.States_;
    __BS97537 := __T(__EE97478);
    __EE97548 := __BN(TOPN(__BS97537(__NN(__T(__EE97478).State_Count_)),1, -__T(__T(__EE97478).State_Count_),__T(State_)),__NL(__EE97478));
    __EE97549 := __EE97548;
    SELF.Jurisdiction_State_Top_ := (__T(__EE97549))[1];
    SELF := __PP97440;
  END;
  EXPORT __ENH_Customer_4 := PROJECT(__EE97526,__ND97562__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_4',EXPIRE(7));
END;
