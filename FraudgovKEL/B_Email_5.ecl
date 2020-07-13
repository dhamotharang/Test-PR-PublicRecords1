//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Email_Event,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Email_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Email.__Result) __E_Email := E_Email.__Result;
  SHARED VIRTUAL TYPEOF(E_Email_Event.__Result) __E_Email_Event := E_Email_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE141897 := __E_Email;
  SHARED __EE141996 := __E_Email_Event;
  SHARED __EE142724 := __EE141996(__NN(__EE141996.Emailof_) AND __NN(__EE141996.Transaction_));
  SHARED __EE141998 := __ENH_Event_6;
  SHARED __EE142149 := __EE141998(__EE141998.T___In_Agency_Flag_ = 1 AND __EE141998.T17___Email_Is_Kr_Flag_ = 1);
  __JC142742(E_Email_Event.Layout __EE142724, B_Event_6.__ST101034_Layout __EE142149) := __EEQP(__EE142724.Transaction_,__EE142149.UID);
  SHARED __EE142743 := JOIN(__EE142724,__EE142149,__JC142742(LEFT,RIGHT),TRANSFORM(E_Email_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST142069_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST142069_Layout __ND142753__Project(E_Email_Event.Layout __PP142744) := TRANSFORM
    SELF.UID := __PP142744.Emailof_;
    SELF.U_I_D__1_ := __PP142744.Transaction_;
    SELF := __PP142744;
  END;
  SHARED __EE142778 := PROJECT(__EE142743,__ND142753__Project(LEFT));
  SHARED __ST142095_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE142791 := PROJECT(__CLEANANDDO(__EE142778,TABLE(__EE142778,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST142095_Layout);
  SHARED __ST142351_Layout := RECORD
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
  __JC142797(E_Email.Layout __EE141897, __ST142095_Layout __EE142791) := __EEQP(__EE141897.UID,__EE142791.UID);
  __ST142351_Layout __JT142797(E_Email.Layout __l, __ST142095_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE142798 := JOIN(__EE141897,__EE142791,__JC142797(LEFT,RIGHT),__JT142797(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST96506_Layout := RECORD
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
  SHARED __ST96506_Layout __ND142822__Project(__ST142351_Layout __PP142799) := TRANSFORM
    SELF.Aot_Email_Kr_Act_Cnt_Ev_ := MIN(__PP142799.C_O_U_N_T___Exp1_,9999);
    SELF := __PP142799;
  END;
  EXPORT __ENH_Email_5 := PROJECT(__EE142798,__ND142822__Project(LEFT)) : PERSIST('~fraudgov::tempKEL::FraudgovKEL::Email::Annotated_5',EXPIRE(7));
END;
