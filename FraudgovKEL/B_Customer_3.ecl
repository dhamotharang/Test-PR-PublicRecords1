//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_4.__ENH_Customer_4) __ENH_Customer_4 := B_Customer_4.__ENH_Customer_4;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE525704 := __ENH_Customer_4;
  SHARED __EE525748 := __E_Person_Event;
  SHARED __EE525883 := __EE525748(__NN(__EE525748._r_Customer_));
  SHARED __ST525794_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE525931 := PROJECT(__EE525883,TRANSFORM(__ST525794_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST525809_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE525947 := PROJECT(__CLEANANDDO(__EE525931,TABLE(__EE525931,{KEL.Aggregates.MaxNG(__EE525931.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST525809_Layout);
  SHARED __ST526008_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    B_Customer_4.__NS240720_Layout Jurisdiction_State_Top_;
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC526005(B_Customer_4.__ST98438_Layout __EE525704, __ST525809_Layout __EE525947) := __EEQP(__EE525704.UID,__EE525947.UID);
  __ST526008_Layout __JT526005(B_Customer_4.__ST98438_Layout __l, __ST525809_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE526006 := JOIN(__EE525704,__EE525947,__JC526005(LEFT,RIGHT),__JT526005(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST94016_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS240720_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST94016_Layout __ND526100__Project(__ST526008_Layout __PP526083) := TRANSFORM
    SELF.Event_Date_Max_ := __PP526083.M_A_X___Event_Date_;
    SELF.Jurisdiction_State_ := __PP526083.Jurisdiction_State_Top_.State_;
    SELF := __PP526083;
  END;
  EXPORT __ENH_Customer_3 := PROJECT(__EE526006,__ND526100__Project(LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Customer::Annotated_3',EXPIRE(7));
END;
