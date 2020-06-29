//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_4.__ENH_Customer_4) __ENH_Customer_4 := B_Customer_4.__ENH_Customer_4;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE496156 := __ENH_Customer_4;
  SHARED __EE496200 := __E_Person_Event;
  SHARED __EE496335 := __EE496200(__NN(__EE496200._r_Customer_));
  SHARED __ST496246_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE496383 := PROJECT(__EE496335,TRANSFORM(__ST496246_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST496261_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE496399 := PROJECT(__CLEANANDDO(__EE496383,TABLE(__EE496383,{KEL.Aggregates.MaxNG(__EE496383.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST496261_Layout);
  SHARED __ST496460_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    B_Customer_4.__NS227849_Layout Jurisdiction_State_Top_;
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC496457(B_Customer_4.__ST90982_Layout __EE496156, __ST496261_Layout __EE496399) := __EEQP(__EE496156.UID,__EE496399.UID);
  __ST496460_Layout __JT496457(B_Customer_4.__ST90982_Layout __l, __ST496261_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE496458 := JOIN(__EE496156,__EE496399,__JC496457(LEFT,RIGHT),__JT496457(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST86728_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS227849_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST86728_Layout __ND496552__Project(__ST496460_Layout __PP496535) := TRANSFORM
    SELF.Event_Date_Max_ := __PP496535.M_A_X___Event_Date_;
    SELF.Jurisdiction_State_ := __PP496535.Jurisdiction_State_Top_.State_;
    SELF := __PP496535;
  END;
  EXPORT __ENH_Customer_3 := PROJECT(__EE496458,__ND496552__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_3',EXPIRE(7));
END;
