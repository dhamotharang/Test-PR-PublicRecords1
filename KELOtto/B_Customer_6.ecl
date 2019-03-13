//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Event_7,E_Address,E_Customer,E_Event,E_Person,E_Person_Event FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_6 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_7.__ENH_Event_7) __ENH_Event_7 := B_Event_7.__ENH_Event_7;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE22610 := __E_Customer;
  SHARED __ST22787_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE23276 := PROJECT(__EE22610,__ST22787_Layout);
  SHARED __EE22632 := __E_Person_Event;
  SHARED __EE23157 := __EE22632(__NN(__EE22632._r_Customer_) AND __NN(__EE22632.Transaction_));
  SHARED __EE22648 := __ENH_Event_7;
  SHARED __EE23329 := __EE22648(__T(__OP2(__EE22648.Event_Type_Count_,=,__CN(0))));
  __JC23335(E_Person_Event.Layout __EE23157, B_Event_7.__ST19291_Layout __EE23329) := __EEQP(__EE23157.Transaction_,__EE23329.UID);
  SHARED __EE23341 := JOIN(__EE23157,__EE23329,__JC23335(LEFT,RIGHT),TRANSFORM(E_Person_Event.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST22734_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE23367 := PROJECT(__EE23341,TRANSFORM(__ST22734_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST22757_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE23381 := PROJECT(__EE23367,__ST22757_Layout);
  SHARED __ST22772_Layout := RECORD
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE23397 := PROJECT(__CLEANANDDO(__EE23381,TABLE(__EE23381,{KEL.Aggregates.MaxNG(__EE23381.Event_Date_) Event_Date_Max_,UID},UID,MERGE)),__ST22772_Layout);
  SHARED __ST22800_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC23403(__ST22787_Layout __EE23276, __ST22772_Layout __EE23397) := __EEQP(__EE23276.UID,__EE23397.UID);
  __ST22800_Layout __JT23403(__ST22787_Layout __l, __ST22772_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE23412 := JOIN(__EE23276,__EE23397,__JC23403(LEFT,RIGHT),__JT23403(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST18698_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Customer_6 := PROJECT(__EE23412,__ST18698_Layout);
END;
