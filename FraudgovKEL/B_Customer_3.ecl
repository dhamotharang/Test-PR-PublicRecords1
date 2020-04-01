//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_4.__ENH_Customer_4) __ENH_Customer_4 := B_Customer_4.__ENH_Customer_4;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE155661 := __ENH_Customer_4;
  SHARED __EE155705 := __E_Person_Event;
  SHARED __EE155840 := __EE155705(__NN(__EE155705._r_Customer_));
  SHARED __ST155751_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE155888 := PROJECT(__EE155840,TRANSFORM(__ST155751_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST155766_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE155904 := PROJECT(__CLEANANDDO(__EE155888,TABLE(__EE155888,{KEL.Aggregates.MaxNG(__EE155888.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST155766_Layout);
  SHARED __ST155965_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    B_Customer_4.__NS96611_Layout Jurisdiction_State_Top_;
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC155962(B_Customer_4.__ST41243_Layout __EE155661, __ST155766_Layout __EE155904) := __EEQP(__EE155661.UID,__EE155904.UID);
  __ST155965_Layout __JT155962(B_Customer_4.__ST41243_Layout __l, __ST155766_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE155963 := JOIN(__EE155661,__EE155904,__JC155962(LEFT,RIGHT),__JT155962(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST39603_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS96611_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST39603_Layout __ND156057__Project(__ST155965_Layout __PP156040) := TRANSFORM
    SELF.Event_Date_Max_ := __PP156040.M_A_X___Event_Date_;
    SELF.Jurisdiction_State_ := __PP156040.Jurisdiction_State_Top_.State_;
    SELF := __PP156040;
  END;
  EXPORT __ENH_Customer_3 := PROJECT(__EE155963,__ND156057__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_3',EXPIRE(7));
END;
