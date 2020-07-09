//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_4.__ENH_Customer_4) __ENH_Customer_4 := B_Customer_4.__ENH_Customer_4;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE521312 := __ENH_Customer_4;
  SHARED __EE521356 := __E_Person_Event;
  SHARED __EE521491 := __EE521356(__NN(__EE521356._r_Customer_));
  SHARED __ST521402_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE521539 := PROJECT(__EE521491,TRANSFORM(__ST521402_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST521417_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE521555 := PROJECT(__CLEANANDDO(__EE521539,TABLE(__EE521539,{KEL.Aggregates.MaxNG(__EE521539.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST521417_Layout);
  SHARED __ST521616_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    B_Customer_4.__NS235965_Layout Jurisdiction_State_Top_;
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC521613(B_Customer_4.__ST92895_Layout __EE521312, __ST521417_Layout __EE521555) := __EEQP(__EE521312.UID,__EE521555.UID);
  __ST521616_Layout __JT521613(B_Customer_4.__ST92895_Layout __l, __ST521417_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE521614 := JOIN(__EE521312,__EE521555,__JC521613(LEFT,RIGHT),__JT521613(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST88429_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS235965_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST88429_Layout __ND521708__Project(__ST521616_Layout __PP521691) := TRANSFORM
    SELF.Event_Date_Max_ := __PP521691.M_A_X___Event_Date_;
    SELF.Jurisdiction_State_ := __PP521691.Jurisdiction_State_Top_.State_;
    SELF := __PP521691;
  END;
  EXPORT __ENH_Customer_3 := PROJECT(__EE521614,__ND521708__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_3',EXPIRE(7));
END;
