//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Email_Event,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Email_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Email.__Result) __E_Email := E_Email.__Result;
  SHARED VIRTUAL TYPEOF(E_Email_Event.__Result) __E_Email_Event := E_Email_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE143629 := __E_Email;
  SHARED __EE143699 := __E_Email_Event;
  SHARED __EE144422 := __EE143699(__NN(__EE143699.Emailof_) AND __NN(__EE143699.Transaction_));
  SHARED __EE143701 := __ENH_Event_6;
  SHARED __EE143847 := __EE143701(__EE143701.T17___Email_Is_Kr_Flag_ = 1);
  __JC144440(E_Email_Event.Layout __EE144422, B_Event_6.__ST102807_Layout __EE143847) := __EEQP(__EE144422.Transaction_,__EE143847.UID);
  SHARED __EE144441 := JOIN(__EE144422,__EE143847,__JC144440(LEFT,RIGHT),TRANSFORM(E_Email_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST143767_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST143767_Layout __ND144451__Project(E_Email_Event.Layout __PP144442) := TRANSFORM
    SELF.UID := __PP144442.Emailof_;
    SELF.U_I_D__1_ := __PP144442.Transaction_;
    SELF := __PP144442;
  END;
  SHARED __EE144476 := PROJECT(__EE144441,__ND144451__Project(LEFT));
  SHARED __ST143793_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE144489 := PROJECT(__CLEANANDDO(__EE144476,TABLE(__EE144476,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST143793_Layout);
  SHARED __ST144049_Layout := RECORD
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
  __JC144495(E_Email.Layout __EE143629, __ST143793_Layout __EE144489) := __EEQP(__EE143629.UID,__EE144489.UID);
  __ST144049_Layout __JT144495(E_Email.Layout __l, __ST143793_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE144496 := JOIN(__EE143629,__EE144489,__JC144495(LEFT,RIGHT),__JT144495(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST98682_Layout := RECORD
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
  SHARED __ST98682_Layout __ND144520__Project(__ST144049_Layout __PP144497) := TRANSFORM
    SELF.Aot_Email_Kr_Act_Cnt_Ev_ := MIN(__PP144497.C_O_U_N_T___Exp1_,9999);
    SELF := __PP144497;
  END;
  EXPORT __ENH_Email_5 := PROJECT(__EE144496,__ND144520__Project(LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Email::Annotated_5',EXPIRE(7));
END;
