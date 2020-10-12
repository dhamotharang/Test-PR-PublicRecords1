//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Bank_Account_Event,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank_Account_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Bank_Account.__Result) __E_Bank_Account := E_Bank_Account.__Result;
  SHARED VIRTUAL TYPEOF(E_Bank_Account_Event.__Result) __E_Bank_Account_Event := E_Bank_Account_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE137866 := __E_Bank_Account;
  SHARED __EE137930 := __E_Bank_Account_Event;
  SHARED __EE138545 := __EE137930(__NN(__EE137930.Account_) AND __NN(__EE137930.Transaction_));
  SHARED __EE137932 := __ENH_Event_6;
  SHARED __EE138072 := __EE137932(__EE137932.T19___Bnk_Acct_Is_Kr_Flag_ = 1);
  __JC138563(E_Bank_Account_Event.Layout __EE138545, B_Event_6.__ST99302_Layout __EE138072) := __EEQP(__EE138545.Transaction_,__EE138072.UID);
  SHARED __EE138564 := JOIN(__EE138545,__EE138072,__JC138563(LEFT,RIGHT),TRANSFORM(E_Bank_Account_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST137998_Layout := RECORD
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST137998_Layout __ND138574__Project(E_Bank_Account_Event.Layout __PP138565) := TRANSFORM
    SELF.UID := __PP138565.Account_;
    SELF.U_I_D__1_ := __PP138565.Transaction_;
    SELF := __PP138565;
  END;
  SHARED __EE138599 := PROJECT(__EE138564,__ND138574__Project(LEFT));
  SHARED __ST138024_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE138612 := PROJECT(__CLEANANDDO(__EE138599,TABLE(__EE138599,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST138024_Layout);
  SHARED __ST138262_Layout := RECORD
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
  __JC138618(E_Bank_Account.Layout __EE137866, __ST138024_Layout __EE138612) := __EEQP(__EE137866.UID,__EE138612.UID);
  __ST138262_Layout __JT138618(E_Bank_Account.Layout __l, __ST138024_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE138619 := JOIN(__EE137866,__EE138612,__JC138618(LEFT,RIGHT),__JT138618(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST95117_Layout := RECORD
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
  SHARED __ST95117_Layout __ND138637__Project(__ST138262_Layout __PP138620) := TRANSFORM
    SELF.Aot_Bnk_Acct_Kr_Act_Cnt_Ev_ := MIN(__PP138620.C_O_U_N_T___Exp1_,9999);
    SELF := __PP138620;
  END;
  EXPORT __ENH_Bank_Account_5 := PROJECT(__EE138619,__ND138637__Project(LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Bank_Account::Annotated_5',EXPIRE(7));
END;
