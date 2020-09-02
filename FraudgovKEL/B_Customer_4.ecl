//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Customer FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_4 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED __EE240670 := __E_Customer;
  EXPORT __NS240720_Layout := RECORD
    KEL.typ.nstr State_;
    KEL.typ.nint State_Count_;
  END;
  EXPORT __ST98438_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    __NS240720_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST98438_Layout __ND240706__Project(E_Customer.Layout __PP240584) := TRANSFORM
    __EE240622 := __PP240584.States_;
    __BS240681 := __T(__EE240622);
    __EE240692 := __BN(TOPN(__BS240681(__NN(__T(__EE240622).State_Count_)),1, -__T(__T(__EE240622).State_Count_),__T(State_)),__NL(__EE240622));
    __EE240693 := __EE240692;
    SELF.Jurisdiction_State_Top_ := (__T(__EE240693))[1];
    SELF := __PP240584;
  END;
  EXPORT __ENH_Customer_4 := PROJECT(__EE240670,__ND240706__Project(LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Customer::Annotated_4',EXPIRE(7));
END;
