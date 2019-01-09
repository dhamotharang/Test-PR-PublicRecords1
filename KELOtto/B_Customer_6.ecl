//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_6 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE15718 := __E_Customer;
  SHARED __ST15876_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE16197 := PROJECT(__EE15718,__ST15876_Layout);
  SHARED __EE16172 := __E_Person_Event;
  SHARED __EE16179 := __EE16172(__NN(__EE16172._r_Customer_));
  SHARED __ST15846_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE16054 := PROJECT(__EE16179,TRANSFORM(__ST15846_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST15861_Layout := RECORD
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE16170 := PROJECT(__CLEANANDDO(__EE16054,TABLE(__EE16054,{KEL.Aggregates.MaxNG(__EE16054.Event_Date_) Event_Date_Max_,UID},UID,MERGE)),__ST15861_Layout);
  SHARED __ST15889_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC16206(__ST15876_Layout __EE16197, __ST15861_Layout __EE16170) := __EEQP(__EE16197.UID,__EE16170.UID);
  __ST15889_Layout __JT16206(__ST15876_Layout __l, __ST15861_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE16207 := JOIN(__EE16197,__EE16170,__JC16206(LEFT,RIGHT),__JT16206(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST14082_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Customer_6 := PROJECT(__EE16207,__ST14082_Layout);
END;
