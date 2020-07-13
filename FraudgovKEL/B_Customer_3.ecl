//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_4.__ENH_Customer_4) __ENH_Customer_4 := B_Customer_4.__ENH_Customer_4;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE521250 := __ENH_Customer_4;
  SHARED __EE521294 := __E_Person_Event;
  SHARED __EE521429 := __EE521294(__NN(__EE521294._r_Customer_));
  SHARED __ST521340_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE521477 := PROJECT(__EE521429,TRANSFORM(__ST521340_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST521355_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE521493 := PROJECT(__CLEANANDDO(__EE521477,TABLE(__EE521477,{KEL.Aggregates.MaxNG(__EE521477.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST521355_Layout);
  SHARED __ST521554_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    B_Customer_4.__NS235903_Layout Jurisdiction_State_Top_;
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC521551(B_Customer_4.__ST92833_Layout __EE521250, __ST521355_Layout __EE521493) := __EEQP(__EE521250.UID,__EE521493.UID);
  __ST521554_Layout __JT521551(B_Customer_4.__ST92833_Layout __l, __ST521355_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE521552 := JOIN(__EE521250,__EE521493,__JC521551(LEFT,RIGHT),__JT521551(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST88367_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS235903_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST88367_Layout __ND521646__Project(__ST521554_Layout __PP521629) := TRANSFORM
    SELF.Event_Date_Max_ := __PP521629.M_A_X___Event_Date_;
    SELF.Jurisdiction_State_ := __PP521629.Jurisdiction_State_Top_.State_;
    SELF := __PP521629;
  END;
  EXPORT __ENH_Customer_3 := PROJECT(__EE521552,__ND521646__Project(LEFT)) : PERSIST('~fraudgov::tempKEL::FraudgovKEL::Customer::Annotated_3',EXPIRE(7));
END;
