//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Email_Event,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Email_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Email.__Result) __E_Email := E_Email.__Result;
  SHARED VIRTUAL TYPEOF(E_Email_Event.__Result) __E_Email_Event := E_Email_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE141959 := __E_Email;
  SHARED __EE142058 := __E_Email_Event;
  SHARED __EE142786 := __EE142058(__NN(__EE142058.Emailof_) AND __NN(__EE142058.Transaction_));
  SHARED __EE142060 := __ENH_Event_6;
  SHARED __EE142211 := __EE142060(__EE142060.T___In_Agency_Flag_ = 1 AND __EE142060.T17___Email_Is_Kr_Flag_ = 1);
  __JC142804(E_Email_Event.Layout __EE142786, B_Event_6.__ST101096_Layout __EE142211) := __EEQP(__EE142786.Transaction_,__EE142211.UID);
  SHARED __EE142805 := JOIN(__EE142786,__EE142211,__JC142804(LEFT,RIGHT),TRANSFORM(E_Email_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST142131_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST142131_Layout __ND142815__Project(E_Email_Event.Layout __PP142806) := TRANSFORM
    SELF.UID := __PP142806.Emailof_;
    SELF.U_I_D__1_ := __PP142806.Transaction_;
    SELF := __PP142806;
  END;
  SHARED __EE142840 := PROJECT(__EE142805,__ND142815__Project(LEFT));
  SHARED __ST142157_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE142853 := PROJECT(__CLEANANDDO(__EE142840,TABLE(__EE142840,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST142157_Layout);
  SHARED __ST142413_Layout := RECORD
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
  __JC142859(E_Email.Layout __EE141959, __ST142157_Layout __EE142853) := __EEQP(__EE141959.UID,__EE142853.UID);
  __ST142413_Layout __JT142859(E_Email.Layout __l, __ST142157_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE142860 := JOIN(__EE141959,__EE142853,__JC142859(LEFT,RIGHT),__JT142859(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST96568_Layout := RECORD
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
  SHARED __ST96568_Layout __ND142884__Project(__ST142413_Layout __PP142861) := TRANSFORM
    SELF.Aot_Email_Kr_Act_Cnt_Ev_ := MIN(__PP142861.C_O_U_N_T___Exp1_,9999);
    SELF := __PP142861;
  END;
  EXPORT __ENH_Email_5 := PROJECT(__EE142860,__ND142884__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Email::Annotated_5',EXPIRE(7));
END;
