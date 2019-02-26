//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT B_Event_7,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_6 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_7.__ENH_Event_7) __ENH_Event_7 := B_Event_7.__ENH_Event_7;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE22590 := __E_Customer;
  SHARED __ST22799_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE23456 := PROJECT(__EE22590,__ST22799_Layout);
  SHARED __EE22612 := __E_Person_Event;
  SHARED __EE23297 := __EE22612(__NN(__EE22612._r_Customer_) AND __NN(__EE22612.Transaction_));
  SHARED __EE22628 := __ENH_Event_7;
  SHARED __EE23509 := __EE22628(__T(__OP2(__EE22628.Event_Type_Count_,=,__CN(0))));
  __JC23515(E_Person_Event.Layout __EE23297, B_Event_7.__ST19271_Layout __EE23509) := __EEQP(__EE23297.Transaction_,__EE23509.UID);
  SHARED __EE23529 := JOIN(__EE23297,__EE23509,__JC23515(LEFT,RIGHT),TRANSFORM(E_Person_Event.Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST22730_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) Social_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) Ip_;
    KEL.typ.ntyp(E_Bank.Typ) Routing_Bank_;
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.ntyp(E_Drivers_License.Typ) Licence_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE23587 := PROJECT(__EE23529,TRANSFORM(__ST22730_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST22769_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE23601 := PROJECT(__EE23587,__ST22769_Layout);
  SHARED __ST22784_Layout := RECORD
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE23617 := PROJECT(__CLEANANDDO(__EE23601,TABLE(__EE23601,{KEL.Aggregates.MaxNG(__EE23601.Event_Date_) Event_Date_Max_,UID},UID,MERGE)),__ST22784_Layout);
  SHARED __ST22812_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC23623(__ST22799_Layout __EE23456, __ST22784_Layout __EE23617) := __EEQP(__EE23456.UID,__EE23617.UID);
  __ST22812_Layout __JT23623(__ST22799_Layout __l, __ST22784_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE23632 := JOIN(__EE23456,__EE23617,__JC23623(LEFT,RIGHT),__JT23623(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST18678_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Customer_6 := PROJECT(__EE23632,__ST18678_Layout);
END;
