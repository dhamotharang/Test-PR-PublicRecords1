//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Customer,E_Event,E_Person,E_Person_Event FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_6 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE26122 := __E_Customer;
  SHARED __ST26248_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE26521 := PROJECT(__EE26122,__ST26248_Layout);
  SHARED __EE26496 := __E_Person_Event;
  SHARED __EE26503 := __EE26496(__NN(__EE26496._r_Customer_));
  SHARED __ST26218_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE26378 := PROJECT(__EE26503,TRANSFORM(__ST26218_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST26233_Layout := RECORD
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE26494 := PROJECT(__CLEANANDDO(__EE26378,TABLE(__EE26378,{KEL.Aggregates.MaxNG(__EE26378.Event_Date_) Event_Date_Max_,UID},UID,MERGE)),__ST26233_Layout);
  SHARED __ST26261_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC26530(__ST26248_Layout __EE26521, __ST26233_Layout __EE26494) := __EEQP(__EE26521.UID,__EE26494.UID);
  __ST26261_Layout __JT26530(__ST26248_Layout __l, __ST26233_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE26531 := JOIN(__EE26521,__EE26494,__JC26530(LEFT,RIGHT),__JT26530(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST22796_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Customer_6 := PROJECT(__EE26531,__ST22796_Layout);
END;
