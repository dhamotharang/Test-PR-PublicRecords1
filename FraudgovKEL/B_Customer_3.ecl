//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_4.__ENH_Customer_4) __ENH_Customer_4 := B_Customer_4.__ENH_Customer_4;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE243037 := __ENH_Customer_4;
  SHARED __EE243081 := __E_Person_Event;
  SHARED __EE243216 := __EE243081(__NN(__EE243081._r_Customer_));
  SHARED __ST243127_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE243264 := PROJECT(__EE243216,TRANSFORM(__ST243127_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST243142_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE243280 := PROJECT(__CLEANANDDO(__EE243264,TABLE(__EE243264,{KEL.Aggregates.MaxNG(__EE243264.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST243142_Layout);
  SHARED __ST243341_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    B_Customer_4.__NS142481_Layout Jurisdiction_State_Top_;
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC243338(B_Customer_4.__ST63551_Layout __EE243037, __ST243142_Layout __EE243280) := __EEQP(__EE243037.UID,__EE243280.UID);
  __ST243341_Layout __JT243338(B_Customer_4.__ST63551_Layout __l, __ST243142_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE243339 := JOIN(__EE243037,__EE243280,__JC243338(LEFT,RIGHT),__JT243338(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST60320_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS142481_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST60320_Layout __ND243433__Project(__ST243341_Layout __PP243416) := TRANSFORM
    SELF.Event_Date_Max_ := __PP243416.M_A_X___Event_Date_;
    SELF.Jurisdiction_State_ := __PP243416.Jurisdiction_State_Top_.State_;
    SELF := __PP243416;
  END;
  EXPORT __ENH_Customer_3 := PROJECT(__EE243339,__ND243433__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_3',EXPIRE(7));
END;
