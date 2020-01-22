//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_5,B_Customer_6,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_4 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_5.__ENH_Customer_5) __ENH_Customer_5 := B_Customer_5.__ENH_Customer_5;
  SHARED __EE151055 := __ENH_Customer_5;
  EXPORT __NS151108_Layout := RECORD
    KEL.typ.nstr State_;
    KEL.typ.nint State_Count_;
  END;
  EXPORT __ST60070_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    __NS151108_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST60070_Layout __ND151093__Project(B_Customer_6.__ST62537_Layout __PP150964) := TRANSFORM
    __EE151006 := __PP150964.States_;
    __BS151067 := __T(__EE151006);
    __EE151078 := __BN(TOPN(__BS151067(__NN(__T(__EE151006).State_Count_)),1, -__T(__T(__EE151006).State_Count_),__T(State_)),__NL(__EE151006));
    __EE151079 := __EE151078;
    SELF.Jurisdiction_State_Top_ := (__T(__EE151079))[1];
    SELF := __PP150964;
  END;
  EXPORT __ENH_Customer_4 := PROJECT(__EE151055,__ND151093__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Customer::Annotated_4',EXPIRE(7));
END;
