//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Email_Event,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Email_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Email.__Result) __E_Email := E_Email.__Result;
  SHARED VIRTUAL TYPEOF(E_Email_Event.__Result) __E_Email_Event := E_Email_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE141205 := __E_Email;
  SHARED __EE141304 := __E_Email_Event;
  SHARED __EE142032 := __EE141304(__NN(__EE141304.Emailof_) AND __NN(__EE141304.Transaction_));
  SHARED __EE141306 := __ENH_Event_6;
  SHARED __EE141457 := __EE141306(__EE141306.T___In_Agency_Flag_ = 1 AND __EE141306.T17___Email_Is_Kr_Flag_ = 1);
  __JC142050(E_Email_Event.Layout __EE142032, B_Event_6.__ST100342_Layout __EE141457) := __EEQP(__EE142032.Transaction_,__EE141457.UID);
  SHARED __EE142051 := JOIN(__EE142032,__EE141457,__JC142050(LEFT,RIGHT),TRANSFORM(E_Email_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST141377_Layout := RECORD
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST141377_Layout __ND142061__Project(E_Email_Event.Layout __PP142052) := TRANSFORM
    SELF.UID := __PP142052.Emailof_;
    SELF.U_I_D__1_ := __PP142052.Transaction_;
    SELF := __PP142052;
  END;
  SHARED __EE142086 := PROJECT(__EE142051,__ND142061__Project(LEFT));
  SHARED __ST141403_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Email.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE142099 := PROJECT(__CLEANANDDO(__EE142086,TABLE(__EE142086,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST141403_Layout);
  SHARED __ST141659_Layout := RECORD
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
  __JC142105(E_Email.Layout __EE141205, __ST141403_Layout __EE142099) := __EEQP(__EE141205.UID,__EE142099.UID);
  __ST141659_Layout __JT142105(E_Email.Layout __l, __ST141403_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE142106 := JOIN(__EE141205,__EE142099,__JC142105(LEFT,RIGHT),__JT142105(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST95826_Layout := RECORD
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
  SHARED __ST95826_Layout __ND142130__Project(__ST141659_Layout __PP142107) := TRANSFORM
    SELF.Aot_Email_Kr_Act_Cnt_Ev_ := MIN(__PP142107.C_O_U_N_T___Exp1_,9999);
    SELF := __PP142107;
  END;
  EXPORT __ENH_Email_5 := PROJECT(__EE142106,__ND142130__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Email::Annotated_5',EXPIRE(7));
END;
