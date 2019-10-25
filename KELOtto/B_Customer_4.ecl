//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_5,B_Customer_6,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_4 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_5.__ENH_Customer_5) __ENH_Customer_5 := B_Customer_5.__ENH_Customer_5;
  SHARED __EE140417 := __ENH_Customer_5;
  EXPORT __NS140470_Layout := RECORD
    KEL.typ.nstr State_;
    KEL.typ.nint State_Count_;
  END;
  EXPORT __ST52600_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    __NS140470_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST52600_Layout __ND140455__Project(B_Customer_6.__ST54991_Layout __PP140326) := TRANSFORM
    __EE140368 := __PP140326.States_;
    __BS140429 := __T(__EE140368);
    __EE140440 := __BN(TOPN(__BS140429(__NN(__T(__EE140368).State_Count_)),1, -__T(__T(__EE140368).State_Count_),__T(State_)),__NL(__EE140368));
    __EE140441 := __EE140440;
    SELF.Jurisdiction_State_Top_ := (__T(__EE140441))[1];
    SELF := __PP140326;
  END;
  EXPORT __ENH_Customer_4 := PROJECT(__EE140417,__ND140455__Project(LEFT));
END;
