//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Event_7,E_Address,E_Customer,E_Event,E_Person,E_Person_Event FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_6 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_7.__ENH_Event_7) __ENH_Event_7 := B_Event_7.__ENH_Event_7;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE28418 := __E_Customer;
  SHARED __ST28595_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE29084 := PROJECT(__EE28418,__ST28595_Layout);
  SHARED __EE28440 := __E_Person_Event;
  SHARED __EE28965 := __EE28440(__NN(__EE28440._r_Customer_) AND __NN(__EE28440.Transaction_));
  SHARED __EE28456 := __ENH_Event_7;
  SHARED __EE29137 := __EE28456(__T(__OP2(__EE28456.Event_Type_Count_,=,__CN(0))));
  __JC29143(E_Person_Event.Layout __EE28965, B_Event_7.__ST23413_Layout __EE29137) := __EEQP(__EE28965.Transaction_,__EE29137.UID);
  SHARED __EE29149 := JOIN(__EE28965,__EE29137,__JC29143(LEFT,RIGHT),TRANSFORM(E_Person_Event.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST28542_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE29175 := PROJECT(__EE29149,TRANSFORM(__ST28542_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST28565_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE29189 := PROJECT(__EE29175,__ST28565_Layout);
  SHARED __ST28580_Layout := RECORD
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE29205 := PROJECT(__CLEANANDDO(__EE29189,TABLE(__EE29189,{KEL.Aggregates.MaxNG(__EE29189.Event_Date_) Event_Date_Max_,UID},UID,MERGE)),__ST28580_Layout);
  SHARED __ST28608_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC29211(__ST28595_Layout __EE29084, __ST28580_Layout __EE29205) := __EEQP(__EE29084.UID,__EE29205.UID);
  __ST28608_Layout __JT29211(__ST28595_Layout __l, __ST28580_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE29220 := JOIN(__EE29084,__EE29205,__JC29211(LEFT,RIGHT),__JT29211(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST22813_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Customer_6 := PROJECT(__EE29220,__ST22813_Layout);
END;
