//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_4.__ENH_Customer_4) __ENH_Customer_4 := B_Customer_4.__ENH_Customer_4;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE251863 := __ENH_Customer_4;
  SHARED __EE251907 := __E_Person_Event;
  SHARED __EE252042 := __EE251907(__NN(__EE251907._r_Customer_));
  SHARED __ST251953_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE252090 := PROJECT(__EE252042,TRANSFORM(__ST251953_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST251968_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE252106 := PROJECT(__CLEANANDDO(__EE252090,TABLE(__EE252090,{KEL.Aggregates.MaxNG(__EE252090.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST251968_Layout);
  SHARED __ST252167_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    B_Customer_4.__NS146462_Layout Jurisdiction_State_Top_;
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC252164(B_Customer_4.__ST63724_Layout __EE251863, __ST251968_Layout __EE252106) := __EEQP(__EE251863.UID,__EE252106.UID);
  __ST252167_Layout __JT252164(B_Customer_4.__ST63724_Layout __l, __ST251968_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE252165 := JOIN(__EE251863,__EE252106,__JC252164(LEFT,RIGHT),__JT252164(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST60459_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS146462_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST60459_Layout __ND252259__Project(__ST252167_Layout __PP252242) := TRANSFORM
    SELF.Event_Date_Max_ := __PP252242.M_A_X___Event_Date_;
    SELF.Jurisdiction_State_ := __PP252242.Jurisdiction_State_Top_.State_;
    SELF := __PP252242;
  END;
  EXPORT __ENH_Customer_3 := PROJECT(__EE252165,__ND252259__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_3',EXPIRE(7));
END;
