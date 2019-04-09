//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Event_7,E_Address,E_Customer,E_Event,E_Person,E_Person_Event FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_6 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_7.__ENH_Event_7) __ENH_Event_7 := B_Event_7.__ENH_Event_7;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE26693 := __E_Customer;
  SHARED __ST26870_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE27359 := PROJECT(__EE26693,__ST26870_Layout);
  SHARED __EE26715 := __E_Person_Event;
  SHARED __EE27240 := __EE26715(__NN(__EE26715._r_Customer_) AND __NN(__EE26715.Transaction_));
  SHARED __EE26731 := __ENH_Event_7;
  SHARED __EE27412 := __EE26731(__T(__OP2(__EE26731.Event_Type_Count_,=,__CN(0))));
  __JC27418(E_Person_Event.Layout __EE27240, B_Event_7.__ST23374_Layout __EE27412) := __EEQP(__EE27240.Transaction_,__EE27412.UID);
  SHARED __EE27424 := JOIN(__EE27240,__EE27412,__JC27418(LEFT,RIGHT),TRANSFORM(E_Person_Event.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST26817_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE27450 := PROJECT(__EE27424,TRANSFORM(__ST26817_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST26840_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE27464 := PROJECT(__EE27450,__ST26840_Layout);
  SHARED __ST26855_Layout := RECORD
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE27480 := PROJECT(__CLEANANDDO(__EE27464,TABLE(__EE27464,{KEL.Aggregates.MaxNG(__EE27464.Event_Date_) Event_Date_Max_,UID},UID,MERGE)),__ST26855_Layout);
  SHARED __ST26883_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC27486(__ST26870_Layout __EE27359, __ST26855_Layout __EE27480) := __EEQP(__EE27359.UID,__EE27480.UID);
  __ST26883_Layout __JT27486(__ST26870_Layout __l, __ST26855_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE27495 := JOIN(__EE27359,__EE27480,__JC27486(LEFT,RIGHT),__JT27486(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST22781_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Customer_6 := PROJECT(__EE27495,__ST22781_Layout);
END;
