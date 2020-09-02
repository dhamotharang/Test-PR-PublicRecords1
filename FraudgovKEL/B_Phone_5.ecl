//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Phone_Event,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Phone_5 := MODULE
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED VIRTUAL TYPEOF(E_Phone.__Result) __E_Phone := E_Phone.__Result;
  SHARED VIRTUAL TYPEOF(E_Phone_Event.__Result) __E_Phone_Event := E_Phone_Event.__Result;
  SHARED __EE204154 := __E_Phone;
  SHARED __EE204218 := __E_Phone_Event;
  SHARED __EE204833 := __EE204218(__NN(__EE204218.Phone_Number_) AND __NN(__EE204218.Transaction_));
  SHARED __EE204220 := __ENH_Event_6;
  SHARED __EE204360 := __EE204220(__EE204220.T16___Phn_Is_Kr_Flag_ = 1);
  __JC204851(E_Phone_Event.Layout __EE204833, B_Event_6.__ST106570_Layout __EE204360) := __EEQP(__EE204833.Transaction_,__EE204360.UID);
  SHARED __EE204852 := JOIN(__EE204833,__EE204360,__JC204851(LEFT,RIGHT),TRANSFORM(E_Phone_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST204286_Layout := RECORD
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST204286_Layout __ND204862__Project(E_Phone_Event.Layout __PP204853) := TRANSFORM
    SELF.UID := __PP204853.Phone_Number_;
    SELF.U_I_D__1_ := __PP204853.Transaction_;
    SELF := __PP204853;
  END;
  SHARED __EE204887 := PROJECT(__EE204852,__ND204862__Project(LEFT));
  SHARED __ST204312_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE204900 := PROJECT(__CLEANANDDO(__EE204887,TABLE(__EE204887,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST204312_Layout);
  SHARED __ST204550_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Phone.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC204906(E_Phone.Layout __EE204154, __ST204312_Layout __EE204900) := __EEQP(__EE204154.UID,__EE204900.UID);
  __ST204550_Layout __JT204906(E_Phone.Layout __l, __ST204312_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE204907 := JOIN(__EE204154,__EE204900,__JC204906(LEFT,RIGHT),__JT204906(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST104878_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Phone.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.int Aot_Phn_Kr_Act_Cnt_Ev_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST104878_Layout __ND204925__Project(__ST204550_Layout __PP204908) := TRANSFORM
    SELF.Aot_Phn_Kr_Act_Cnt_Ev_ := MIN(__PP204908.C_O_U_N_T___Exp1_,9999);
    SELF := __PP204908;
  END;
  EXPORT __ENH_Phone_5 := PROJECT(__EE204907,__ND204925__Project(LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Phone::Annotated_5',EXPIRE(7));
END;
