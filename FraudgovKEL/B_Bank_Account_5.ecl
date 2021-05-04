//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Bank_Account_Event,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank_Account_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Bank_Account.__Result) __E_Bank_Account := E_Bank_Account.__Result;
  SHARED VIRTUAL TYPEOF(E_Bank_Account_Event.__Result) __E_Bank_Account_Event := E_Bank_Account_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE140120 := __E_Bank_Account;
  SHARED __EE140184 := __E_Bank_Account_Event;
  SHARED __EE140795 := __EE140184(__NN(__EE140184.Account_) AND __NN(__EE140184.Transaction_));
  SHARED __EE140186 := __ENH_Event_6;
  SHARED __EE140325 := __EE140186(__EE140186.T19___Bnk_Acct_Is_Kr_Flag_ = 1);
  __JC140813(E_Bank_Account_Event.Layout __EE140795, B_Event_6.__ST101563_Layout __EE140325) := __EEQP(__EE140795.Transaction_,__EE140325.UID);
  SHARED __EE140814 := JOIN(__EE140795,__EE140325,__JC140813(LEFT,RIGHT),TRANSFORM(E_Bank_Account_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST140252_Layout := RECORD
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST140252_Layout __ND140824__Project(E_Bank_Account_Event.Layout __PP140815) := TRANSFORM
    SELF.UID := __PP140815.Account_;
    SELF.U_I_D__1_ := __PP140815.Transaction_;
    SELF := __PP140815;
  END;
  SHARED __EE140849 := PROJECT(__EE140814,__ND140824__Project(LEFT));
  SHARED __ST140278_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE140862 := PROJECT(__CLEANANDDO(__EE140849,TABLE(__EE140849,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST140278_Layout);
  SHARED __ST140514_Layout := RECORD
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
  __JC140868(E_Bank_Account.Layout __EE140120, __ST140278_Layout __EE140862) := __EEQP(__EE140120.UID,__EE140862.UID);
  __ST140514_Layout __JT140868(E_Bank_Account.Layout __l, __ST140278_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE140869 := JOIN(__EE140120,__EE140862,__JC140868(LEFT,RIGHT),__JT140868(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST97379_Layout := RECORD
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
  EXPORT __ENH_Bank_Account_5 := PROJECT(__EE140869,TRANSFORM(__ST97379_Layout,SELF.Aot_Bnk_Acct_Kr_Act_Cnt_Ev_ := LEFT.C_O_U_N_T___Exp1_,SELF := LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Bank_Account::Annotated_5',EXPIRE(7));
END;
