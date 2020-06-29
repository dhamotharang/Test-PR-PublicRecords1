//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Bank_Account_Event,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank_Account_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Bank_Account.__Result) __E_Bank_Account := E_Bank_Account.__Result;
  SHARED VIRTUAL TYPEOF(E_Bank_Account_Event.__Result) __E_Bank_Account_Event := E_Bank_Account_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE137563 := __E_Bank_Account;
  SHARED __EE137650 := __E_Bank_Account_Event;
  SHARED __EE138270 := __EE137650(__NN(__EE137650.Account_) AND __NN(__EE137650.Transaction_));
  SHARED __EE137652 := __ENH_Event_6;
  SHARED __EE137797 := __EE137652(__EE137652.T___In_Agency_Flag_ = 1 AND __EE137652.T19___Bnk_Acct_Is_Kr_Flag_ = 1);
  __JC138288(E_Bank_Account_Event.Layout __EE138270, B_Event_6.__ST98838_Layout __EE137797) := __EEQP(__EE138270.Transaction_,__EE137797.UID);
  SHARED __EE138289 := JOIN(__EE138270,__EE137797,__JC138288(LEFT,RIGHT),TRANSFORM(E_Bank_Account_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST137723_Layout := RECORD
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST137723_Layout __ND138299__Project(E_Bank_Account_Event.Layout __PP138290) := TRANSFORM
    SELF.UID := __PP138290.Account_;
    SELF.U_I_D__1_ := __PP138290.Transaction_;
    SELF := __PP138290;
  END;
  SHARED __EE138324 := PROJECT(__EE138289,__ND138299__Project(LEFT));
  SHARED __ST137749_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE138337 := PROJECT(__CLEANANDDO(__EE138324,TABLE(__EE138324,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST137749_Layout);
  SHARED __ST137987_Layout := RECORD
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
  __JC138343(E_Bank_Account.Layout __EE137563, __ST137749_Layout __EE138337) := __EEQP(__EE137563.UID,__EE138337.UID);
  __ST137987_Layout __JT138343(E_Bank_Account.Layout __l, __ST137749_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE138344 := JOIN(__EE137563,__EE138337,__JC138343(LEFT,RIGHT),__JT138343(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST94462_Layout := RECORD
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
  SHARED __ST94462_Layout __ND138362__Project(__ST137987_Layout __PP138345) := TRANSFORM
    SELF.Aot_Bnk_Acct_Kr_Act_Cnt_Ev_ := MIN(__PP138345.C_O_U_N_T___Exp1_,9999);
    SELF := __PP138345;
  END;
  EXPORT __ENH_Bank_Account_5 := PROJECT(__EE138344,__ND138362__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Bank_Account::Annotated_5',EXPIRE(7));
END;
