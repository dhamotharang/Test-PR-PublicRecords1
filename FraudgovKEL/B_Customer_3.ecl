//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_4.__ENH_Customer_4) __ENH_Customer_4 := B_Customer_4.__ENH_Customer_4;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE306341 := __ENH_Customer_4;
  SHARED __EE306385 := __E_Person_Event;
  SHARED __EE306520 := __EE306385(__NN(__EE306385._r_Customer_));
  SHARED __ST306431_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE306568 := PROJECT(__EE306520,TRANSFORM(__ST306431_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST306446_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE306584 := PROJECT(__CLEANANDDO(__EE306568,TABLE(__EE306568,{KEL.Aggregates.MaxNG(__EE306568.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST306446_Layout);
  SHARED __ST306645_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    B_Customer_4.__NS176766_Layout Jurisdiction_State_Top_;
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC306642(B_Customer_4.__ST73648_Layout __EE306341, __ST306446_Layout __EE306584) := __EEQP(__EE306341.UID,__EE306584.UID);
  __ST306645_Layout __JT306642(B_Customer_4.__ST73648_Layout __l, __ST306446_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE306643 := JOIN(__EE306341,__EE306584,__JC306642(LEFT,RIGHT),__JT306642(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST70025_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS176766_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST70025_Layout __ND306737__Project(__ST306645_Layout __PP306720) := TRANSFORM
    SELF.Event_Date_Max_ := __PP306720.M_A_X___Event_Date_;
    SELF.Jurisdiction_State_ := __PP306720.Jurisdiction_State_Top_.State_;
    SELF := __PP306720;
  END;
  EXPORT __ENH_Customer_3 := PROJECT(__EE306643,__ND306737__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_3',EXPIRE(7));
END;
