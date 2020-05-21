//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_4.__ENH_Customer_4) __ENH_Customer_4 := B_Customer_4.__ENH_Customer_4;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE275930 := __ENH_Customer_4;
  SHARED __EE275974 := __E_Person_Event;
  SHARED __EE276109 := __EE275974(__NN(__EE275974._r_Customer_));
  SHARED __ST276020_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE276157 := PROJECT(__EE276109,TRANSFORM(__ST276020_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST276035_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE276173 := PROJECT(__CLEANANDDO(__EE276157,TABLE(__EE276157,{KEL.Aggregates.MaxNG(__EE276157.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST276035_Layout);
  SHARED __ST276234_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    B_Customer_4.__NS157419_Layout Jurisdiction_State_Top_;
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC276231(B_Customer_4.__ST64377_Layout __EE275930, __ST276035_Layout __EE276173) := __EEQP(__EE275930.UID,__EE276173.UID);
  __ST276234_Layout __JT276231(B_Customer_4.__ST64377_Layout __l, __ST276035_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE276232 := JOIN(__EE275930,__EE276173,__JC276231(LEFT,RIGHT),__JT276231(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST61020_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS157419_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST61020_Layout __ND276326__Project(__ST276234_Layout __PP276309) := TRANSFORM
    SELF.Event_Date_Max_ := __PP276309.M_A_X___Event_Date_;
    SELF.Jurisdiction_State_ := __PP276309.Jurisdiction_State_Top_.State_;
    SELF := __PP276309;
  END;
  EXPORT __ENH_Customer_3 := PROJECT(__EE276232,__ND276326__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_3',EXPIRE(7));
END;
