//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_4.__ENH_Customer_4) __ENH_Customer_4 := B_Customer_4.__ENH_Customer_4;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE155576 := __ENH_Customer_4;
  SHARED __EE155620 := __E_Person_Event;
  SHARED __EE155755 := __EE155620(__NN(__EE155620._r_Customer_));
  SHARED __ST155666_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE155803 := PROJECT(__EE155755,TRANSFORM(__ST155666_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST155681_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE155819 := PROJECT(__CLEANANDDO(__EE155803,TABLE(__EE155803,{KEL.Aggregates.MaxNG(__EE155803.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST155681_Layout);
  SHARED __ST155880_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    B_Customer_4.__NS96526_Layout Jurisdiction_State_Top_;
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC155877(B_Customer_4.__ST41158_Layout __EE155576, __ST155681_Layout __EE155819) := __EEQP(__EE155576.UID,__EE155819.UID);
  __ST155880_Layout __JT155877(B_Customer_4.__ST41158_Layout __l, __ST155681_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE155878 := JOIN(__EE155576,__EE155819,__JC155877(LEFT,RIGHT),__JT155877(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST39518_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS96526_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST39518_Layout __ND155972__Project(__ST155880_Layout __PP155955) := TRANSFORM
    SELF.Event_Date_Max_ := __PP155955.M_A_X___Event_Date_;
    SELF.Jurisdiction_State_ := __PP155955.Jurisdiction_State_Top_.State_;
    SELF := __PP155955;
  END;
  EXPORT __ENH_Customer_3 := PROJECT(__EE155878,__ND155972__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_3',EXPIRE(7));
END;
