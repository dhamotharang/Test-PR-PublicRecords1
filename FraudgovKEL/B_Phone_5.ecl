//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Phone_Event,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Phone_5 := MODULE
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED VIRTUAL TYPEOF(E_Phone.__Result) __E_Phone := E_Phone.__Result;
  SHARED VIRTUAL TYPEOF(E_Phone_Event.__Result) __E_Phone_Event := E_Phone_Event.__Result;
  SHARED __EE189840 := __E_Phone;
  SHARED __EE189904 := __E_Phone_Event;
  SHARED __EE190519 := __EE189904(__NN(__EE189904.Phone_Number_) AND __NN(__EE189904.Transaction_));
  SHARED __EE189906 := __ENH_Event_6;
  SHARED __EE190046 := __EE189906(__EE189906.T16___Phn_Is_Kr_Flag_ = 1);
  __JC190537(E_Phone_Event.Layout __EE190519, B_Event_6.__ST102807_Layout __EE190046) := __EEQP(__EE190519.Transaction_,__EE190046.UID);
  SHARED __EE190538 := JOIN(__EE190519,__EE190046,__JC190537(LEFT,RIGHT),TRANSFORM(E_Phone_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST189972_Layout := RECORD
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST189972_Layout __ND190548__Project(E_Phone_Event.Layout __PP190539) := TRANSFORM
    SELF.UID := __PP190539.Phone_Number_;
    SELF.U_I_D__1_ := __PP190539.Transaction_;
    SELF := __PP190539;
  END;
  SHARED __EE190573 := PROJECT(__EE190538,__ND190548__Project(LEFT));
  SHARED __ST189998_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE190586 := PROJECT(__CLEANANDDO(__EE190573,TABLE(__EE190573,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST189998_Layout);
  SHARED __ST190236_Layout := RECORD
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
  __JC190592(E_Phone.Layout __EE189840, __ST189998_Layout __EE190586) := __EEQP(__EE189840.UID,__EE190586.UID);
  __ST190236_Layout __JT190592(E_Phone.Layout __l, __ST189998_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE190593 := JOIN(__EE189840,__EE190586,__JC190592(LEFT,RIGHT),__JT190592(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST101129_Layout := RECORD
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
  SHARED __ST101129_Layout __ND190611__Project(__ST190236_Layout __PP190594) := TRANSFORM
    SELF.Aot_Phn_Kr_Act_Cnt_Ev_ := MIN(__PP190594.C_O_U_N_T___Exp1_,9999);
    SELF := __PP190594;
  END;
  EXPORT __ENH_Phone_5 := PROJECT(__EE190593,__ND190611__Project(LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Phone::Annotated_5',EXPIRE(7));
END;
