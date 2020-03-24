//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_4.__ENH_Customer_4) __ENH_Customer_4 := B_Customer_4.__ENH_Customer_4;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE150773 := __ENH_Customer_4;
  SHARED __EE150817 := __E_Person_Event;
  SHARED __EE150952 := __EE150817(__NN(__EE150817._r_Customer_));
  SHARED __ST150863_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE151000 := PROJECT(__EE150952,TRANSFORM(__ST150863_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST150878_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE151016 := PROJECT(__CLEANANDDO(__EE151000,TABLE(__EE151000,{KEL.Aggregates.MaxNG(__EE151000.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST150878_Layout);
  SHARED __ST151077_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    B_Customer_4.__NS93661_Layout Jurisdiction_State_Top_;
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC151074(B_Customer_4.__ST40395_Layout __EE150773, __ST150878_Layout __EE151016) := __EEQP(__EE150773.UID,__EE151016.UID);
  __ST151077_Layout __JT151074(B_Customer_4.__ST40395_Layout __l, __ST150878_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE151075 := JOIN(__EE150773,__EE151016,__JC151074(LEFT,RIGHT),__JT151074(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST38836_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS93661_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST38836_Layout __ND151169__Project(__ST151077_Layout __PP151152) := TRANSFORM
    SELF.Event_Date_Max_ := __PP151152.M_A_X___Event_Date_;
    SELF.Jurisdiction_State_ := __PP151152.Jurisdiction_State_Top_.State_;
    SELF := __PP151152;
  END;
  EXPORT __ENH_Customer_3 := PROJECT(__EE151075,__ND151169__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_3',EXPIRE(7));
END;
