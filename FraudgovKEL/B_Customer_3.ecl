//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Customer_4,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Event,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Customer_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Customer_4.__ENH_Customer_4) __ENH_Customer_4 := B_Customer_4.__ENH_Customer_4;
  SHARED VIRTUAL TYPEOF(E_Person_Event.__Result) __E_Person_Event := E_Person_Event.__Result;
  SHARED __EE166809 := __ENH_Customer_4;
  SHARED __EE166853 := __E_Person_Event;
  SHARED __EE166988 := __EE166853(__NN(__EE166853._r_Customer_));
  SHARED __ST166899_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE167036 := PROJECT(__EE166988,TRANSFORM(__ST166899_Layout,SELF.UID := LEFT._r_Customer_,SELF := LEFT));
  SHARED __ST166914_Layout := RECORD
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE167052 := PROJECT(__CLEANANDDO(__EE167036,TABLE(__EE167036,{KEL.Aggregates.MaxNG(__EE167036.Event_Date_) M_A_X___Event_Date_,UID},UID,MERGE)),__ST166914_Layout);
  SHARED __ST167113_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    B_Customer_4.__NS97877_Layout Jurisdiction_State_Top_;
    KEL.typ.nkdate M_A_X___Event_Date_;
    KEL.typ.ntyp(E_Customer.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC167110(B_Customer_4.__ST38780_Layout __EE166809, __ST166914_Layout __EE167052) := __EEQP(__EE166809.UID,__EE167052.UID);
  __ST167113_Layout __JT167110(B_Customer_4.__ST38780_Layout __l, __ST166914_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE167111 := JOIN(__EE166809,__EE167052,__JC167110(LEFT,RIGHT),__JT167110(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST37070_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.ndataset(E_Customer.States_Layout) States_;
    KEL.typ.nkdate Event_Date_Max_;
    KEL.typ.nstr Jurisdiction_State_;
    B_Customer_4.__NS97877_Layout Jurisdiction_State_Top_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST37070_Layout __ND167205__Project(__ST167113_Layout __PP167188) := TRANSFORM
    SELF.Event_Date_Max_ := __PP167188.M_A_X___Event_Date_;
    SELF.Jurisdiction_State_ := __PP167188.Jurisdiction_State_Top_.State_;
    SELF := __PP167188;
  END;
  EXPORT __ENH_Customer_3 := PROJECT(__EE167111,__ND167205__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Customer::Annotated_3',EXPIRE(7));
END;
