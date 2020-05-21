//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_4.__ENH_Customer_4) __ENH_Customer_4 := B_Customer_4.__ENH_Customer_4;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE275411 := __ENH_Customer_4;
  SHARED __EE275455 := __E_Person_Event;
  SHARED __EE275590 := __EE275455(__NN(__EE275455._r_Customer_));
  SHARED __ST275501_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE275638 := PROJECT(__EE275590,TRANSFORM(__ST275501_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST275516_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE275654 := PROJECT(__CLEANANDDO(__EE275638,TABLE(__EE275638,{KEL.Aggregates.MaxNG(__EE275638.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST275516_Layout);
  SHARED __ST275715_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    B_Customer_4.__NS157185_Layout Jurisdiction_State_Top_;
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC275712(B_Customer_4.__ST64367_Layout __EE275411, __ST275516_Layout __EE275654) := __EEQP(__EE275411.UID,__EE275654.UID);
  __ST275715_Layout __JT275712(B_Customer_4.__ST64367_Layout __l, __ST275516_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE275713 := JOIN(__EE275411,__EE275654,__JC275712(LEFT,RIGHT),__JT275712(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST61012_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS157185_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST61012_Layout __ND275807__Project(__ST275715_Layout __PP275790) := TRANSFORM
    SELF.Event_Date_Max_ := __PP275790.M_A_X___Event_Date_;
    SELF.Jurisdiction_State_ := __PP275790.Jurisdiction_State_Top_.State_;
    SELF := __PP275790;
  END;
  EXPORT __ENH_Customer_3 := PROJECT(__EE275713,__ND275807__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_3',EXPIRE(7));
END;
