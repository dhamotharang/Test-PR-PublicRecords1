//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Phone_Event,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Phone_5 := MODULE
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED VIRTUAL TYPEOF(E_Phone.__Result) __E_Phone := E_Phone.__Result;
  SHARED VIRTUAL TYPEOF(E_Phone_Event.__Result) __E_Phone_Event := E_Phone_Event.__Result;
  SHARED __EE186152 := __E_Phone;
  SHARED __EE186216 := __E_Phone_Event;
  SHARED __EE186831 := __EE186216(__NN(__EE186216.Phone_Number_) AND __NN(__EE186216.Transaction_));
  SHARED __EE186218 := __ENH_Event_6;
  SHARED __EE186358 := __EE186218(__EE186218.T16___Phn_Is_Kr_Flag_ = 1);
  __JC186849(E_Phone_Event.Layout __EE186831, B_Event_6.__ST99302_Layout __EE186358) := __EEQP(__EE186831.Transaction_,__EE186358.UID);
  SHARED __EE186850 := JOIN(__EE186831,__EE186358,__JC186849(LEFT,RIGHT),TRANSFORM(E_Phone_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST186284_Layout := RECORD
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST186284_Layout __ND186860__Project(E_Phone_Event.Layout __PP186851) := TRANSFORM
    SELF.UID := __PP186851.Phone_Number_;
    SELF.U_I_D__1_ := __PP186851.Transaction_;
    SELF := __PP186851;
  END;
  SHARED __EE186885 := PROJECT(__EE186850,__ND186860__Project(LEFT));
  SHARED __ST186310_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Phone.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE186898 := PROJECT(__CLEANANDDO(__EE186885,TABLE(__EE186885,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST186310_Layout);
  SHARED __ST186548_Layout := RECORD
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
  __JC186904(E_Phone.Layout __EE186152, __ST186310_Layout __EE186898) := __EEQP(__EE186152.UID,__EE186898.UID);
  __ST186548_Layout __JT186904(E_Phone.Layout __l, __ST186310_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE186905 := JOIN(__EE186152,__EE186898,__JC186904(LEFT,RIGHT),__JT186904(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST97624_Layout := RECORD
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
  SHARED __ST97624_Layout __ND186923__Project(__ST186548_Layout __PP186906) := TRANSFORM
    SELF.Aot_Phn_Kr_Act_Cnt_Ev_ := MIN(__PP186906.C_O_U_N_T___Exp1_,9999);
    SELF := __PP186906;
  END;
  EXPORT __ENH_Phone_5 := PROJECT(__EE186905,__ND186923__Project(LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Phone::Annotated_5',EXPIRE(7));
END;
