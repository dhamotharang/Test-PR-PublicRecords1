//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_4.__ENH_Customer_4) __ENH_Customer_4 := B_Customer_4.__ENH_Customer_4;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE250823 := __ENH_Customer_4;
  SHARED __EE250867 := __E_Person_Event;
  SHARED __EE251002 := __EE250867(__NN(__EE250867._r_Customer_));
  SHARED __ST250913_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE251050 := PROJECT(__EE251002,TRANSFORM(__ST250913_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST250928_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE251066 := PROJECT(__CLEANANDDO(__EE251050,TABLE(__EE251050,{KEL.Aggregates.MaxNG(__EE251050.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST250928_Layout);
  SHARED __ST251127_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    B_Customer_4.__NS145992_Layout Jurisdiction_State_Top_;
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC251124(B_Customer_4.__ST63702_Layout __EE250823, __ST250928_Layout __EE251066) := __EEQP(__EE250823.UID,__EE251066.UID);
  __ST251127_Layout __JT251124(B_Customer_4.__ST63702_Layout __l, __ST250928_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE251125 := JOIN(__EE250823,__EE251066,__JC251124(LEFT,RIGHT),__JT251124(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST60441_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS145992_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST60441_Layout __ND251219__Project(__ST251127_Layout __PP251202) := TRANSFORM
    SELF.Event_Date_Max_ := __PP251202.M_A_X___Event_Date_;
    SELF.Jurisdiction_State_ := __PP251202.Jurisdiction_State_Top_.State_;
    SELF := __PP251202;
  END;
  EXPORT __ENH_Customer_3 := PROJECT(__EE251125,__ND251219__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_3',EXPIRE(7));
END;
