//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_5,B_Customer_6,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_4 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_5.__ENH_Customer_5) __ENH_Customer_5 := B_Customer_5.__ENH_Customer_5;
  SHARED __EE156132 := __ENH_Customer_5;
  EXPORT __NS156185_Layout := RECORD
    KEL.typ.nstr State_;
    KEL.typ.nint State_Count_;
  END;
  EXPORT __ST60475_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    __NS156185_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST60475_Layout __ND156170__Project(B_Customer_6.__ST63216_Layout __PP156041) := TRANSFORM
    __EE156083 := __PP156041.States_;
    __BS156144 := __T(__EE156083);
    __EE156155 := __BN(TOPN(__BS156144(__NN(__T(__EE156083).State_Count_)),1, -__T(__T(__EE156083).State_Count_),__T(State_)),__NL(__EE156083));
    __EE156156 := __EE156155;
    SELF.Jurisdiction_State_Top_ := (__T(__EE156156))[1];
    SELF := __PP156041;
  END;
  EXPORT __ENH_Customer_4 := PROJECT(__EE156132,__ND156170__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Customer::Annotated_4',EXPIRE(7));
END;
