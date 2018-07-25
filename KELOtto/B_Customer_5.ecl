//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Customer,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE11769 := __E_Customer;
  SHARED __ST11915_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE12218 := PROJECT(__EE11769,__ST11915_Layout);
  SHARED __EE12193 := __E_Person_Event;
  SHARED __EE12200 := __EE12193(__NN(__EE12193._r_Customer_));
  SHARED __ST11885_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE12075 := PROJECT(__EE12200,TRANSFORM(__ST11885_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST11900_Layout := RECORD
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE12191 := PROJECT(__CLEANANDDO(__EE12075,TABLE(__EE12075,{KEL.Aggregates.MaxNG(__EE12075.Event_Date_) Event_Date_Max_,UID},UID,MERGE)),__ST11900_Layout);
  SHARED __ST11928_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC12227(__ST11915_Layout __EE12218, __ST11900_Layout __EE12191) := __EEQP(__EE12218.UID,__EE12191.UID);
  __ST11928_Layout __JT12227(__ST11915_Layout __l, __ST11900_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE12228 := JOIN(__EE12218,__EE12191,__JC12227(LEFT,RIGHT),__JT12227(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST9443_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Customer_5 := PROJECT(__EE12228,__ST9443_Layout);
END;
