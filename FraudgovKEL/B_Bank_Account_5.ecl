//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Bank_Account_Event,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank_Account_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Bank_Account.__Result) __E_Bank_Account := E_Bank_Account.__Result;
  SHARED VIRTUAL TYPEOF(E_Bank_Account_Event.__Result) __E_Bank_Account_Event := E_Bank_Account_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE141371 := __E_Bank_Account;
  SHARED __EE141435 := __E_Bank_Account_Event;
  SHARED __EE142050 := __EE141435(__NN(__EE141435.Account_) AND __NN(__EE141435.Transaction_));
  SHARED __EE141437 := __ENH_Event_6;
  SHARED __EE141577 := __EE141437(__EE141437.T19___Bnk_Acct_Is_Kr_Flag_ = 1);
  __JC142068(E_Bank_Account_Event.Layout __EE142050, B_Event_6.__ST102807_Layout __EE141577) := __EEQP(__EE142050.Transaction_,__EE141577.UID);
  SHARED __EE142069 := JOIN(__EE142050,__EE141577,__JC142068(LEFT,RIGHT),TRANSFORM(E_Bank_Account_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST141503_Layout := RECORD
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST141503_Layout __ND142079__Project(E_Bank_Account_Event.Layout __PP142070) := TRANSFORM
    SELF.UID := __PP142070.Account_;
    SELF.U_I_D__1_ := __PP142070.Transaction_;
    SELF := __PP142070;
  END;
  SHARED __EE142104 := PROJECT(__EE142069,__ND142079__Project(LEFT));
  SHARED __ST141529_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE142117 := PROJECT(__CLEANANDDO(__EE142104,TABLE(__EE142104,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST141529_Layout);
  SHARED __ST141767_Layout := RECORD
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
  __JC142123(E_Bank_Account.Layout __EE141371, __ST141529_Layout __EE142117) := __EEQP(__EE141371.UID,__EE142117.UID);
  __ST141767_Layout __JT142123(E_Bank_Account.Layout __l, __ST141529_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE142124 := JOIN(__EE141371,__EE142117,__JC142123(LEFT,RIGHT),__JT142123(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST98597_Layout := RECORD
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
  SHARED __ST98597_Layout __ND142142__Project(__ST141767_Layout __PP142125) := TRANSFORM
    SELF.Aot_Bnk_Acct_Kr_Act_Cnt_Ev_ := MIN(__PP142125.C_O_U_N_T___Exp1_,9999);
    SELF := __PP142125;
  END;
  EXPORT __ENH_Bank_Account_5 := PROJECT(__EE142124,__ND142142__Project(LEFT)) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Bank_Account::Annotated_5',EXPIRE(7));
END;
