//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Bank_Account_Event,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank_Account_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Bank_Account.__Result) __E_Bank_Account := E_Bank_Account.__Result;
  SHARED VIRTUAL TYPEOF(E_Bank_Account_Event.__Result) __E_Bank_Account_Event := E_Bank_Account_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE145181 := __E_Bank_Account;
  SHARED __EE145245 := __E_Bank_Account_Event;
  SHARED __EE145860 := __EE145245(__NN(__EE145245.Account_) AND __NN(__EE145245.Transaction_));
  SHARED __EE145247 := __ENH_Event_6;
  SHARED __EE145387 := __EE145247(__EE145247.T19___Bnk_Acct_Is_Kr_Flag_ = 1);
  __JC145878(E_Bank_Account_Event.Layout __EE145860, B_Event_6.__ST106570_Layout __EE145387) := __EEQP(__EE145860.Transaction_,__EE145387.UID);
  SHARED __EE145879 := JOIN(__EE145860,__EE145387,__JC145878(LEFT,RIGHT),TRANSFORM(E_Bank_Account_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST145313_Layout := RECORD
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST145313_Layout __ND145889__Project(E_Bank_Account_Event.Layout __PP145880) := TRANSFORM
    SELF.UID := __PP145880.Account_;
    SELF.U_I_D__1_ := __PP145880.Transaction_;
    SELF := __PP145880;
  END;
  SHARED __EE145914 := PROJECT(__EE145879,__ND145889__Project(LEFT));
  SHARED __ST145339_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE145927 := PROJECT(__CLEANANDDO(__EE145914,TABLE(__EE145914,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST145339_Layout);
  SHARED __ST145577_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Bank_Account.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Bank.Typ) _r_Bank_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nstr Otto_Bank_Account_Id_;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC145933(E_Bank_Account.Layout __EE145181, __ST145339_Layout __EE145927) := __EEQP(__EE145181.UID,__EE145927.UID);
  __ST145577_Layout __JT145933(E_Bank_Account.Layout __l, __ST145339_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE145934 := JOIN(__EE145181,__EE145927,__JC145933(LEFT,RIGHT),__JT145933(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST102011_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Bank_Account.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Bank.Typ) _r_Bank_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nstr Otto_Bank_Account_Id_;
    KEL.typ.int Aot_Bnk_Acct_Kr_Act_Cnt_Ev_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST102011_Layout __ND145952__Project(__ST145577_Layout __PP145935) := TRANSFORM
    SELF.Aot_Bnk_Acct_Kr_Act_Cnt_Ev_ := MIN(__PP145935.C_O_U_N_T___Exp1_,9999);
    SELF := __PP145935;
  END;
  EXPORT __ENH_Bank_Account_5 := PROJECT(__EE145934,__ND145952__Project(LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Bank_Account::Annotated_5',EXPIRE(7));
END;
