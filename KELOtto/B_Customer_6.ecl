//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Event_7,E_Address,E_Customer,E_Event,E_Person,E_Person_Event FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_6 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_7.__ENH_Event_7) __ENH_Event_7 := B_Event_7.__ENH_Event_7;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE28400 := __E_Customer;
  SHARED __ST28577_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE29066 := PROJECT(__EE28400,__ST28577_Layout);
  SHARED __EE28422 := __E_Person_Event;
  SHARED __EE28947 := __EE28422(__NN(__EE28422._r_Customer_) AND __NN(__EE28422.Transaction_));
  SHARED __EE28438 := __ENH_Event_7;
  SHARED __EE29119 := __EE28438(__T(__OP2(__EE28438.Event_Type_Count_,=,__CN(0))));
  __JC29125(E_Person_Event.Layout __EE28947, B_Event_7.__ST23409_Layout __EE29119) := __EEQP(__EE28947.Transaction_,__EE29119.UID);
  SHARED __EE29131 := JOIN(__EE28947,__EE29119,__JC29125(LEFT,RIGHT),TRANSFORM(E_Person_Event.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST28524_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE29157 := PROJECT(__EE29131,TRANSFORM(__ST28524_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST28547_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE29171 := PROJECT(__EE29157,__ST28547_Layout);
  SHARED __ST28562_Layout := RECORD
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE29187 := PROJECT(__CLEANANDDO(__EE29171,TABLE(__EE29171,{KEL.Aggregates.MaxNG(__EE29171.Event_Date_) Event_Date_Max_,UID},UID,MERGE)),__ST28562_Layout);
  SHARED __ST28590_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC29193(__ST28577_Layout __EE29066, __ST28562_Layout __EE29187) := __EEQP(__EE29066.UID,__EE29187.UID);
  __ST28590_Layout __JT29193(__ST28577_Layout __l, __ST28562_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE29202 := JOIN(__EE29066,__EE29187,__JC29193(LEFT,RIGHT),__JT29193(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST22812_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Customer_6 := PROJECT(__EE29202,__ST22812_Layout);
END;
