//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Event_7,E_Address,E_Customer,E_Event,E_Person,E_Person_Event FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_6 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_7.__ENH_Event_7) __ENH_Event_7 := B_Event_7.__ENH_Event_7;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE26571 := __E_Customer;
  SHARED __ST26748_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE27237 := PROJECT(__EE26571,__ST26748_Layout);
  SHARED __EE26593 := __E_Person_Event;
  SHARED __EE27118 := __EE26593(__NN(__EE26593._r_Customer_) AND __NN(__EE26593.Transaction_));
  SHARED __EE26609 := __ENH_Event_7;
  SHARED __EE27290 := __EE26609(__T(__OP2(__EE26609.Event_Type_Count_,=,__CN(0))));
  __JC27296(E_Person_Event.Layout __EE27118, B_Event_7.__ST23252_Layout __EE27290) := __EEQP(__EE27118.Transaction_,__EE27290.UID);
  SHARED __EE27302 := JOIN(__EE27118,__EE27290,__JC27296(LEFT,RIGHT),TRANSFORM(E_Person_Event.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST26695_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE27328 := PROJECT(__EE27302,TRANSFORM(__ST26695_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST26718_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE27342 := PROJECT(__EE27328,__ST26718_Layout);
  SHARED __ST26733_Layout := RECORD
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE27358 := PROJECT(__CLEANANDDO(__EE27342,TABLE(__EE27342,{KEL.Aggregates.MaxNG(__EE27342.Event_Date_) Event_Date_Max_,UID},UID,MERGE)),__ST26733_Layout);
  SHARED __ST26761_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC27364(__ST26748_Layout __EE27237, __ST26733_Layout __EE27358) := __EEQP(__EE27237.UID,__EE27358.UID);
  __ST26761_Layout __JT27364(__ST26748_Layout __l, __ST26733_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE27373 := JOIN(__EE27237,__EE27358,__JC27364(LEFT,RIGHT),__JT27364(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST22659_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Customer_6 := PROJECT(__EE27373,__ST22659_Layout);
END;
