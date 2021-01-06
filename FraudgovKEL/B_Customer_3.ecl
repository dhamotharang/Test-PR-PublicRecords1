//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_4,B_Customer_5,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_4.__ENH_Customer_4) __ENH_Customer_4 := B_Customer_4.__ENH_Customer_4;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE398846 := __ENH_Customer_4;
  SHARED __EE398891 := __E_Person_Event;
  SHARED __EE399027 := __EE398891(__NN(__EE398891._r_Customer_));
  SHARED __ST398937_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE399075 := PROJECT(__EE399027,TRANSFORM(__ST398937_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST398952_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE399091 := PROJECT(__CLEANANDDO(__EE399075,TABLE(__EE399075,{KEL.Aggregates.MaxNG(__EE399075.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST398952_Layout);
  SHARED __ST399154_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nunk _ind__type__description_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_5.__NS142387_Layout Jurisdiction_State_Top_;
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC399151(B_Customer_4.__ST95420_Layout __EE398846, __ST398952_Layout __EE399091) := __EEQP(__EE398846.UID,__EE399091.UID);
  __ST399154_Layout __JT399151(B_Customer_4.__ST95420_Layout __l, __ST398952_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE399152 := JOIN(__EE398846,__EE399091,__JC399151(LEFT,RIGHT),__JT399151(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST91149_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nunk _ind__type__description_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_5.__NS142387_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Customer_3 := PROJECT(__EE399152,TRANSFORM(__ST91149_Layout,SELF.Event_Date_Max_ := LEFT.M_A_X___Event_Date_,SELF := LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Customer::Annotated_3',EXPIRE(7));
END;
