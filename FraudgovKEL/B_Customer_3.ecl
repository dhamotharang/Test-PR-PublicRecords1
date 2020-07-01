//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_4.__ENH_Customer_4) __ENH_Customer_4 := B_Customer_4.__ENH_Customer_4;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE512124 := __ENH_Customer_4;
  SHARED __EE512168 := __E_Person_Event;
  SHARED __EE512303 := __EE512168(__NN(__EE512168._r_Customer_));
  SHARED __ST512214_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE512351 := PROJECT(__EE512303,TRANSFORM(__ST512214_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST512229_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE512367 := PROJECT(__CLEANANDDO(__EE512351,TABLE(__EE512351,{KEL.Aggregates.MaxNG(__EE512351.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST512229_Layout);
  SHARED __ST512428_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    B_Customer_4.__NS233737_Layout Jurisdiction_State_Top_;
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC512425(B_Customer_4.__ST92169_Layout __EE512124, __ST512229_Layout __EE512367) := __EEQP(__EE512124.UID,__EE512367.UID);
  __ST512428_Layout __JT512425(B_Customer_4.__ST92169_Layout __l, __ST512229_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE512426 := JOIN(__EE512124,__EE512367,__JC512425(LEFT,RIGHT),__JT512425(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST87770_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS233737_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST87770_Layout __ND512520__Project(__ST512428_Layout __PP512503) := TRANSFORM
    SELF.Event_Date_Max_ := __PP512503.M_A_X___Event_Date_;
    SELF.Jurisdiction_State_ := __PP512503.Jurisdiction_State_Top_.State_;
    SELF := __PP512503;
  END;
  EXPORT __ENH_Customer_3 := PROJECT(__EE512426,__ND512520__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_3',EXPIRE(7));
END;
