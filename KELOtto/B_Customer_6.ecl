//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Customer,E_Event,E_Person,E_Person_Event FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_6 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE26127 := __E_Customer;
  SHARED __ST26253_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE26526 := PROJECT(__EE26127,__ST26253_Layout);
  SHARED __EE26501 := __E_Person_Event;
  SHARED __EE26508 := __EE26501(__NN(__EE26501._r_Customer_));
  SHARED __ST26223_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE26383 := PROJECT(__EE26508,TRANSFORM(__ST26223_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST26238_Layout := RECORD
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE26499 := PROJECT(__CLEANANDDO(__EE26383,TABLE(__EE26383,{KEL.Aggregates.MaxNG(__EE26383.Event_Date_) Event_Date_Max_,UID},UID,MERGE)),__ST26238_Layout);
  SHARED __ST26266_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC26535(__ST26253_Layout __EE26526, __ST26238_Layout __EE26499) := __EEQP(__EE26526.UID,__EE26499.UID);
  __ST26266_Layout __JT26535(__ST26253_Layout __l, __ST26238_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE26536 := JOIN(__EE26526,__EE26499,__JC26535(LEFT,RIGHT),__JT26535(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST22801_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Customer_6 := PROJECT(__EE26536,__ST22801_Layout);
END;
