﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_6 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE58795 := __E_Customer;
  SHARED __EE58834 := __E_Person_Event;
  SHARED __EE58964 := __EE58834(__NN(__EE58834._r_Customer_));
  SHARED __ST58880_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE59012 := PROJECT(__EE58964,TRANSFORM(__ST58880_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST58895_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE59028 := PROJECT(__CLEANANDDO(__EE59012,TABLE(__EE59012,{KEL.Aggregates.MaxNG(__EE59012.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST58895_Layout);
  SHARED __ST59079_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC59076(E_Customer.Layout __EE58795, __ST58895_Layout __EE59028) := __EEQP(__EE58795.UID,__EE59028.UID);
  __ST59079_Layout __JT59076(E_Customer.Layout __l, __ST58895_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE59077 := JOIN(__EE58795,__EE59028,__JC59076(LEFT,RIGHT),__JT59076(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST54991_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Customer_6 := PROJECT(__EE59077,TRANSFORM(__ST54991_Layout,SELF.Event_Date_Max_ := LEFT.M_A_X___Event_Date_,SELF := LEFT));
END;
