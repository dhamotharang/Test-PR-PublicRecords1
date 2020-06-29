//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Bank_Account_Event,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank_Account_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Bank_Account.__Result) __E_Bank_Account := E_Bank_Account.__Result;
  SHARED VIRTUAL TYPEOF(E_Bank_Account_Event.__Result) __E_Bank_Account_Event := E_Bank_Account_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE139054 := __E_Bank_Account;
  SHARED __EE139141 := __E_Bank_Account_Event;
  SHARED __EE139761 := __EE139141(__NN(__EE139141.Account_) AND __NN(__EE139141.Transaction_));
  SHARED __EE139143 := __ENH_Event_6;
  SHARED __EE139288 := __EE139143(__EE139143.T___In_Agency_Flag_ = 1 AND __EE139143.T19___Bnk_Acct_Is_Kr_Flag_ = 1);
  __JC139779(E_Bank_Account_Event.Layout __EE139761, B_Event_6.__ST100342_Layout __EE139288) := __EEQP(__EE139761.Transaction_,__EE139288.UID);
  SHARED __EE139780 := JOIN(__EE139761,__EE139288,__JC139779(LEFT,RIGHT),TRANSFORM(E_Bank_Account_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST139214_Layout := RECORD
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST139214_Layout __ND139790__Project(E_Bank_Account_Event.Layout __PP139781) := TRANSFORM
    SELF.UID := __PP139781.Account_;
    SELF.U_I_D__1_ := __PP139781.Transaction_;
    SELF := __PP139781;
  END;
  SHARED __EE139815 := PROJECT(__EE139780,__ND139790__Project(LEFT));
  SHARED __ST139240_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE139828 := PROJECT(__CLEANANDDO(__EE139815,TABLE(__EE139815,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST139240_Layout);
  SHARED __ST139478_Layout := RECORD
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
  __JC139834(E_Bank_Account.Layout __EE139054, __ST139240_Layout __EE139828) := __EEQP(__EE139054.UID,__EE139828.UID);
  __ST139478_Layout __JT139834(E_Bank_Account.Layout __l, __ST139240_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE139835 := JOIN(__EE139054,__EE139828,__JC139834(LEFT,RIGHT),__JT139834(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST95758_Layout := RECORD
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
  SHARED __ST95758_Layout __ND139853__Project(__ST139478_Layout __PP139836) := TRANSFORM
    SELF.Aot_Bnk_Acct_Kr_Act_Cnt_Ev_ := MIN(__PP139836.C_O_U_N_T___Exp1_,9999);
    SELF := __PP139836;
  END;
  EXPORT __ENH_Bank_Account_5 := PROJECT(__EE139835,__ND139853__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Bank_Account::Annotated_5',EXPIRE(7));
END;
