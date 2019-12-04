//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_6 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE64044 := __E_Customer;
  SHARED __EE64083 := __E_Person_Event;
  SHARED __EE64213 := __EE64083(__NN(__EE64083._r_Customer_));
  SHARED __ST64129_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE64261 := PROJECT(__EE64213,TRANSFORM(__ST64129_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST64144_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE64277 := PROJECT(__CLEANANDDO(__EE64261,TABLE(__EE64261,{KEL.Aggregates.MaxNG(__EE64261.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST64144_Layout);
  SHARED __ST64328_Layout := RECORD
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
  __JC64325(E_Customer.Layout __EE64044, __ST64144_Layout __EE64277) := __EEQP(__EE64044.UID,__EE64277.UID);
  __ST64328_Layout __JT64325(E_Customer.Layout __l, __ST64144_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE64326 := JOIN(__EE64044,__EE64277,__JC64325(LEFT,RIGHT),__JT64325(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST58877_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Customer_6 := PROJECT(__EE64326,TRANSFORM(__ST58877_Layout,SELF.Event_Date_Max_ := LEFT.M_A_X___Event_Date_,SELF := LEFT)) : PERSIST('~temp::KEL::KELOtto::Customer::Annotated_6',EXPIRE(7));
END;
