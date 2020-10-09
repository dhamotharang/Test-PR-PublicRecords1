//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Email_Event,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Email_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Email.__Result) __E_Email := E_Email.__Result;
  SHARED VIRTUAL TYPEOF(E_Email_Event.__Result) __E_Email_Event := E_Email_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE139941 := __E_Email;
  SHARED __EE140011 := __E_Email_Event;
  SHARED __EE140734 := __EE140011(__NN(__EE140011.Emailof_) AND __NN(__EE140011.Transaction_));
  SHARED __EE140013 := __ENH_Event_6;
  SHARED __EE140159 := __EE140013(__EE140013.T17___Email_Is_Kr_Flag_ = 1);
  __JC140752(E_Email_Event.Layout __EE140734, B_Event_6.__ST99302_Layout __EE140159) := __EEQP(__EE140734.Transaction_,__EE140159.UID);
  SHARED __EE140753 := JOIN(__EE140734,__EE140159,__JC140752(LEFT,RIGHT),TRANSFORM(E_Email_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST140079_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST140079_Layout __ND140763__Project(E_Email_Event.Layout __PP140754) := TRANSFORM
    SELF.UID := __PP140754.Emailof_;
    SELF.U_I_D__1_ := __PP140754.Transaction_;
    SELF := __PP140754;
  END;
  SHARED __EE140788 := PROJECT(__EE140753,__ND140763__Project(LEFT));
  SHARED __ST140105_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE140801 := PROJECT(__CLEANANDDO(__EE140788,TABLE(__EE140788,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST140105_Layout);
  SHARED __ST140361_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.nstr Email_Last_Domain_;
    KEL.typ.nint _isdisposableemail_;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Email.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC140807(E_Email.Layout __EE139941, __ST140105_Layout __EE140801) := __EEQP(__EE139941.UID,__EE140801.UID);
  __ST140361_Layout __JT140807(E_Email.Layout __l, __ST140105_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE140808 := JOIN(__EE139941,__EE140801,__JC140807(LEFT,RIGHT),__JT140807(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST95177_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Email.Source_Customers_Layout) Source_Customers_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr Otto_Email_Id_;
    KEL.typ.ndataset(E_Email.Details_Layout) Details_;
    KEL.typ.nstr Email_Last_Domain_;
    KEL.typ.nint _isdisposableemail_;
    KEL.typ.int Aot_Email_Kr_Act_Cnt_Ev_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST95177_Layout __ND140832__Project(__ST140361_Layout __PP140809) := TRANSFORM
    SELF.Aot_Email_Kr_Act_Cnt_Ev_ := MIN(__PP140809.C_O_U_N_T___Exp1_,9999);
    SELF := __PP140809;
  END;
  EXPORT __ENH_Email_5 := PROJECT(__EE140808,__ND140832__Project(LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Email::Annotated_5',EXPIRE(7));
END;
