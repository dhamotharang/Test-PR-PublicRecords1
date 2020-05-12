//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_4.__ENH_Customer_4) __ENH_Customer_4 := B_Customer_4.__ENH_Customer_4;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE244957 := __ENH_Customer_4;
  SHARED __EE245001 := __E_Person_Event;
  SHARED __EE245136 := __EE245001(__NN(__EE245001._r_Customer_));
  SHARED __ST245047_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE245184 := PROJECT(__EE245136,TRANSFORM(__ST245047_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST245062_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE245200 := PROJECT(__CLEANANDDO(__EE245184,TABLE(__EE245184,{KEL.Aggregates.MaxNG(__EE245184.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST245062_Layout);
  SHARED __ST245261_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    B_Customer_4.__NS144567_Layout Jurisdiction_State_Top_;
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC245258(B_Customer_4.__ST60814_Layout __EE244957, __ST245062_Layout __EE245200) := __EEQP(__EE244957.UID,__EE245200.UID);
  __ST245261_Layout __JT245258(B_Customer_4.__ST60814_Layout __l, __ST245062_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE245259 := JOIN(__EE244957,__EE245200,__JC245258(LEFT,RIGHT),__JT245258(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST57758_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS144567_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST57758_Layout __ND245353__Project(__ST245261_Layout __PP245336) := TRANSFORM
    SELF.Event_Date_Max_ := __PP245336.M_A_X___Event_Date_;
    SELF.Jurisdiction_State_ := __PP245336.Jurisdiction_State_Top_.State_;
    SELF := __PP245336;
  END;
  EXPORT __ENH_Customer_3 := PROJECT(__EE245259,__ND245353__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_3',EXPIRE(7));
END;
