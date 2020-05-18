//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_4.__ENH_Customer_4) __ENH_Customer_4 := B_Customer_4.__ENH_Customer_4;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE244076 := __ENH_Customer_4;
  SHARED __EE244120 := __E_Person_Event;
  SHARED __EE244255 := __EE244120(__NN(__EE244120._r_Customer_));
  SHARED __ST244166_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE244303 := PROJECT(__EE244255,TRANSFORM(__ST244166_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST244181_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE244319 := PROJECT(__CLEANANDDO(__EE244303,TABLE(__EE244303,{KEL.Aggregates.MaxNG(__EE244303.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST244181_Layout);
  SHARED __ST244380_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    B_Customer_4.__NS142950_Layout Jurisdiction_State_Top_;
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC244377(B_Customer_4.__ST63572_Layout __EE244076, __ST244181_Layout __EE244319) := __EEQP(__EE244076.UID,__EE244319.UID);
  __ST244380_Layout __JT244377(B_Customer_4.__ST63572_Layout __l, __ST244181_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE244378 := JOIN(__EE244076,__EE244319,__JC244377(LEFT,RIGHT),__JT244377(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST60337_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS142950_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST60337_Layout __ND244472__Project(__ST244380_Layout __PP244455) := TRANSFORM
    SELF.Event_Date_Max_ := __PP244455.M_A_X___Event_Date_;
    SELF.Jurisdiction_State_ := __PP244455.Jurisdiction_State_Top_.State_;
    SELF := __PP244455;
  END;
  EXPORT __ENH_Customer_3 := PROJECT(__EE244378,__ND244472__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_3',EXPIRE(7));
END;
