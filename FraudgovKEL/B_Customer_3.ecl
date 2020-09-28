//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_4.__ENH_Customer_4) __ENH_Customer_4 := B_Customer_4.__ENH_Customer_4;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE395173 := __ENH_Customer_4;
  SHARED __EE395217 := __E_Person_Event;
  SHARED __EE395352 := __EE395217(__NN(__EE395217._r_Customer_));
  SHARED __ST395263_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE395400 := PROJECT(__EE395352,TRANSFORM(__ST395263_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST395278_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE395416 := PROJECT(__CLEANANDDO(__EE395400,TABLE(__EE395400,{KEL.Aggregates.MaxNG(__EE395400.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST395278_Layout);
  SHARED __ST395477_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    B_Customer_4.__NS188643_Layout Jurisdiction_State_Top_;
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC395474(B_Customer_4.__ST91942_Layout __EE395173, __ST395278_Layout __EE395416) := __EEQP(__EE395173.UID,__EE395416.UID);
  __ST395477_Layout __JT395474(B_Customer_4.__ST91942_Layout __l, __ST395278_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE395475 := JOIN(__EE395173,__EE395416,__JC395474(LEFT,RIGHT),__JT395474(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST87681_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS188643_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST87681_Layout __ND395569__Project(__ST395477_Layout __PP395552) := TRANSFORM
    SELF.Event_Date_Max_ := __PP395552.M_A_X___Event_Date_;
    SELF.Jurisdiction_State_ := __PP395552.Jurisdiction_State_Top_.State_;
    SELF := __PP395552;
  END;
  EXPORT __ENH_Customer_3 := PROJECT(__EE395475,__ND395569__Project(LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Customer::Annotated_3',EXPIRE(7));
END;
