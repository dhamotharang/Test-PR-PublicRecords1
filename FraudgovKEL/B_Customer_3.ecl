//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_4.__ENH_Customer_4) __ENH_Customer_4 := B_Customer_4.__ENH_Customer_4;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE155735 := __ENH_Customer_4;
  SHARED __EE155779 := __E_Person_Event;
  SHARED __EE155914 := __EE155779(__NN(__EE155779._r_Customer_));
  SHARED __ST155825_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE155962 := PROJECT(__EE155914,TRANSFORM(__ST155825_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST155840_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE155978 := PROJECT(__CLEANANDDO(__EE155962,TABLE(__EE155962,{KEL.Aggregates.MaxNG(__EE155962.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST155840_Layout);
  SHARED __ST156039_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    B_Customer_4.__NS96685_Layout Jurisdiction_State_Top_;
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC156036(B_Customer_4.__ST41317_Layout __EE155735, __ST155840_Layout __EE155978) := __EEQP(__EE155735.UID,__EE155978.UID);
  __ST156039_Layout __JT156036(B_Customer_4.__ST41317_Layout __l, __ST155840_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE156037 := JOIN(__EE155735,__EE155978,__JC156036(LEFT,RIGHT),__JT156036(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST39677_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS96685_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST39677_Layout __ND156131__Project(__ST156039_Layout __PP156114) := TRANSFORM
    SELF.Event_Date_Max_ := __PP156114.M_A_X___Event_Date_;
    SELF.Jurisdiction_State_ := __PP156114.Jurisdiction_State_Top_.State_;
    SELF := __PP156114;
  END;
  EXPORT __ENH_Customer_3 := PROJECT(__EE156037,__ND156131__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_3',EXPIRE(7));
END;
