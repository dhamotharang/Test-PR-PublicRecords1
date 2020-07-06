//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Bank_Account_Event,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank_Account_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Bank_Account.__Result) __E_Bank_Account := E_Bank_Account.__Result;
  SHARED VIRTUAL TYPEOF(E_Bank_Account_Event.__Result) __E_Bank_Account_Event := E_Bank_Account_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE139808 := __E_Bank_Account;
  SHARED __EE139895 := __E_Bank_Account_Event;
  SHARED __EE140515 := __EE139895(__NN(__EE139895.Account_) AND __NN(__EE139895.Transaction_));
  SHARED __EE139897 := __ENH_Event_6;
  SHARED __EE140042 := __EE139897(__EE139897.T___In_Agency_Flag_ = 1 AND __EE139897.T19___Bnk_Acct_Is_Kr_Flag_ = 1);
  __JC140533(E_Bank_Account_Event.Layout __EE140515, B_Event_6.__ST101096_Layout __EE140042) := __EEQP(__EE140515.Transaction_,__EE140042.UID);
  SHARED __EE140534 := JOIN(__EE140515,__EE140042,__JC140533(LEFT,RIGHT),TRANSFORM(E_Bank_Account_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST139968_Layout := RECORD
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST139968_Layout __ND140544__Project(E_Bank_Account_Event.Layout __PP140535) := TRANSFORM
    SELF.UID := __PP140535.Account_;
    SELF.U_I_D__1_ := __PP140535.Transaction_;
    SELF := __PP140535;
  END;
  SHARED __EE140569 := PROJECT(__EE140534,__ND140544__Project(LEFT));
  SHARED __ST139994_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE140582 := PROJECT(__CLEANANDDO(__EE140569,TABLE(__EE140569,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST139994_Layout);
  SHARED __ST140232_Layout := RECORD
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
  __JC140588(E_Bank_Account.Layout __EE139808, __ST139994_Layout __EE140582) := __EEQP(__EE139808.UID,__EE140582.UID);
  __ST140232_Layout __JT140588(E_Bank_Account.Layout __l, __ST139994_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE140589 := JOIN(__EE139808,__EE140582,__JC140588(LEFT,RIGHT),__JT140588(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST96500_Layout := RECORD
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
  SHARED __ST96500_Layout __ND140607__Project(__ST140232_Layout __PP140590) := TRANSFORM
    SELF.Aot_Bnk_Acct_Kr_Act_Cnt_Ev_ := MIN(__PP140590.C_O_U_N_T___Exp1_,9999);
    SELF := __PP140590;
  END;
  EXPORT __ENH_Bank_Account_5 := PROJECT(__EE140589,__ND140607__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Bank_Account::Annotated_5',EXPIRE(7));
END;
