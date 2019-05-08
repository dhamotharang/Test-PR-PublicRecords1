//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Event_7,E_Address,E_Customer,E_Event,E_Person,E_Person_Event FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_6 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_7.__ENH_Event_7) __ENH_Event_7 := B_Event_7.__ENH_Event_7;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE28358 := __E_Customer;
  SHARED __ST28535_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE29024 := PROJECT(__EE28358,__ST28535_Layout);
  SHARED __EE28380 := __E_Person_Event;
  SHARED __EE28905 := __EE28380(__NN(__EE28380._r_Customer_) AND __NN(__EE28380.Transaction_));
  SHARED __EE28396 := __ENH_Event_7;
  SHARED __EE29077 := __EE28396(__T(__OP2(__EE28396.Event_Type_Count_,=,__CN(0))));
  __JC29083(E_Person_Event.Layout __EE28905, B_Event_7.__ST23394_Layout __EE29077) := __EEQP(__EE28905.Transaction_,__EE29077.UID);
  SHARED __EE29089 := JOIN(__EE28905,__EE29077,__JC29083(LEFT,RIGHT),TRANSFORM(E_Person_Event.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST28482_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE29115 := PROJECT(__EE29089,TRANSFORM(__ST28482_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST28505_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE29129 := PROJECT(__EE29115,__ST28505_Layout);
  SHARED __ST28520_Layout := RECORD
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE29145 := PROJECT(__CLEANANDDO(__EE29129,TABLE(__EE29129,{KEL.Aggregates.MaxNG(__EE29129.Event_Date_) Event_Date_Max_,UID},UID,MERGE)),__ST28520_Layout);
  SHARED __ST28548_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC29151(__ST28535_Layout __EE29024, __ST28520_Layout __EE29145) := __EEQP(__EE29024.UID,__EE29145.UID);
  __ST28548_Layout __JT29151(__ST28535_Layout __l, __ST28520_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE29160 := JOIN(__EE29024,__EE29145,__JC29151(LEFT,RIGHT),__JT29151(LEFT,RIGHT),LEFT OUTER,LOOKUP);
  EXPORT __ST22798_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Customer_6 := PROJECT(__EE29160,__ST22798_Layout);
END;
