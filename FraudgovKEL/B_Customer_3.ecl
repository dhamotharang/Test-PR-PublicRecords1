﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_4.__ENH_Customer_4) __ENH_Customer_4 := B_Customer_4.__ENH_Customer_4;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE266064 := __ENH_Customer_4;
  SHARED __EE266108 := __E_Person_Event;
  SHARED __EE266243 := __EE266108(__NN(__EE266108._r_Customer_));
  SHARED __ST266154_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE266291 := PROJECT(__EE266243,TRANSFORM(__ST266154_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST266169_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE266307 := PROJECT(__CLEANANDDO(__EE266291,TABLE(__EE266291,{KEL.Aggregates.MaxNG(__EE266291.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST266169_Layout);
  SHARED __ST266368_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    B_Customer_4.__NS152968_Layout Jurisdiction_State_Top_;
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC266365(B_Customer_4.__ST64182_Layout __EE266064, __ST266169_Layout __EE266307) := __EEQP(__EE266064.UID,__EE266307.UID);
  __ST266368_Layout __JT266365(B_Customer_4.__ST64182_Layout __l, __ST266169_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE266366 := JOIN(__EE266064,__EE266307,__JC266365(LEFT,RIGHT),__JT266365(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST60863_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS152968_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST60863_Layout __ND266460__Project(__ST266368_Layout __PP266443) := TRANSFORM
    SELF.Event_Date_Max_ := __PP266443.M_A_X___Event_Date_;
    SELF.Jurisdiction_State_ := __PP266443.Jurisdiction_State_Top_.State_;
    SELF := __PP266443;
  END;
  EXPORT __ENH_Customer_3 := PROJECT(__EE266366,__ND266460__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_3',EXPIRE(7));
END;
