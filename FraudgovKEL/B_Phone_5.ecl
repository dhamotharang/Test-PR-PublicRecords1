//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Phone_Event,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Phone_5 := MODULE
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED VIRTUAL TYPEOF(E_Phone.__Result) __E_Phone := E_Phone.__Result;
  SHARED VIRTUAL TYPEOF(E_Phone_Event.__Result) __E_Phone_Event := E_Phone_Event.__Result;
  SHARED __EE186481 := __E_Phone;
  SHARED __EE186568 := __E_Phone_Event;
  SHARED __EE187188 := __EE186568(__NN(__EE186568.Phone_Number_) AND __NN(__EE186568.Transaction_));
  SHARED __EE186570 := __ENH_Event_6;
  SHARED __EE186715 := __EE186570(__EE186570.T___In_Agency_Flag_ = 1 AND __EE186570.T16___Phn_Is_Kr_Flag_ = 1);
  __JC187206(E_Phone_Event.Layout __EE187188, B_Event_6.__ST95508_Layout __EE186715) := __EEQP(__EE187188.Transaction_,__EE186715.UID);
  SHARED __EE187207 := JOIN(__EE187188,__EE186715,__JC187206(LEFT,RIGHT),TRANSFORM(E_Phone_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST186641_Layout := RECORD
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST186641_Layout __ND187217__Project(E_Phone_Event.Layout __PP187208) := TRANSFORM
    SELF.UID := __PP187208.Phone_Number_;
    SELF.U_I_D__1_ := __PP187208.Transaction_;
    SELF := __PP187208;
  END;
  SHARED __EE187242 := PROJECT(__EE187207,__ND187217__Project(LEFT));
  SHARED __ST186667_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE187255 := PROJECT(__CLEANANDDO(__EE187242,TABLE(__EE187242,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST186667_Layout);
  SHARED __ST186905_Layout := RECORD
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
  __JC187261(E_Phone.Layout __EE186481, __ST186667_Layout __EE187255) := __EEQP(__EE186481.UID,__EE187255.UID);
  __ST186905_Layout __JT187261(E_Phone.Layout __l, __ST186667_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE187262 := JOIN(__EE186481,__EE187255,__JC187261(LEFT,RIGHT),__JT187261(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST93912_Layout := RECORD
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
  SHARED __ST93912_Layout __ND187280__Project(__ST186905_Layout __PP187263) := TRANSFORM
    SELF.Aot_Phn_Kr_Act_Cnt_Ev_ := MIN(__PP187263.C_O_U_N_T___Exp1_,9999);
    SELF := __PP187263;
  END;
  EXPORT __ENH_Phone_5 := PROJECT(__EE187262,__ND187280__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Phone::Annotated_5',EXPIRE(7));
END;
