//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_6 := MODULE
  SHARED VIRTUAL TYPEOF(E_Customer.__Result) __E_Customer := E_Customer.__Result;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE67710 := __E_Customer;
  SHARED __EE67749 := __E_Person_Event;
  SHARED __EE67879 := __EE67749(__NN(__EE67749._r_Customer_));
  SHARED __ST67795_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE67927 := PROJECT(__EE67879,TRANSFORM(__ST67795_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST67810_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE67943 := PROJECT(__CLEANANDDO(__EE67927,TABLE(__EE67927,{KEL.Aggregates.MaxNG(__EE67927.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST67810_Layout);
  SHARED __ST67994_Layout := RECORD
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
  __JC67991(E_Customer.Layout __EE67710, __ST67810_Layout __EE67943) := __EEQP(__EE67710.UID,__EE67943.UID);
  __ST67994_Layout __JT67991(E_Customer.Layout __l, __ST67810_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE67992 := JOIN(__EE67710,__EE67943,__JC67991(LEFT,RIGHT),__JT67991(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST62537_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Customer_6 := PROJECT(__EE67992,TRANSFORM(__ST62537_Layout,SELF.Event_Date_Max_ := LEFT.M_A_X___Event_Date_,SELF := LEFT)) : PERSIST('~temp::KEL::KELOtto::Customer::Annotated_6',EXPIRE(7));
END;
