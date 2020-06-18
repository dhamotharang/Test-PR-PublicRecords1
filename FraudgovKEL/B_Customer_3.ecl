//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_4.__ENH_Customer_4) __ENH_Customer_4 := B_Customer_4.__ENH_Customer_4;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE486841 := __ENH_Customer_4;
  SHARED __EE486885 := __E_Person_Event;
  SHARED __EE487020 := __EE486885(__NN(__EE486885._r_Customer_));
  SHARED __ST486931_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE487068 := PROJECT(__EE487020,TRANSFORM(__ST486931_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST486946_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE487084 := PROJECT(__CLEANANDDO(__EE487068,TABLE(__EE487068,{KEL.Aggregates.MaxNG(__EE487068.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST486946_Layout);
  SHARED __ST487145_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    B_Customer_4.__NS222552_Layout Jurisdiction_State_Top_;
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC487142(B_Customer_4.__ST87687_Layout __EE486841, __ST486946_Layout __EE487084) := __EEQP(__EE486841.UID,__EE487084.UID);
  __ST487145_Layout __JT487142(B_Customer_4.__ST87687_Layout __l, __ST486946_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE487143 := JOIN(__EE486841,__EE487084,__JC487142(LEFT,RIGHT),__JT487142(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST83456_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS222552_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST83456_Layout __ND487237__Project(__ST487145_Layout __PP487220) := TRANSFORM
    SELF.Event_Date_Max_ := __PP487220.M_A_X___Event_Date_;
    SELF.Jurisdiction_State_ := __PP487220.Jurisdiction_State_Top_.State_;
    SELF := __PP487220;
  END;
  EXPORT __ENH_Customer_3 := PROJECT(__EE487143,__ND487237__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_3',EXPIRE(7));
END;
