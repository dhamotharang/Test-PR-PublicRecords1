//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Event_6,E_Address,E_Bank,E_Bank_Account,E_Bank_Account_Event,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank_Account_5 := MODULE
  SHARED VIRTUAL TYPEOF(E_Bank_Account.__Result) __E_Bank_Account := E_Bank_Account.__Result;
  SHARED VIRTUAL TYPEOF(E_Bank_Account_Event.__Result) __E_Bank_Account_Event := E_Bank_Account_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_6.__ENH_Event_6) __ENH_Event_6 := B_Event_6.__ENH_Event_6;
  SHARED __EE133575 := __E_Bank_Account;
  SHARED __EE133662 := __E_Bank_Account_Event;
  SHARED __EE134282 := __EE133662(__NN(__EE133662.Account_) AND __NN(__EE133662.Transaction_));
  SHARED __EE133664 := __ENH_Event_6;
  SHARED __EE133809 := __EE133664(__EE133664.T___In_Agency_Flag_ = 1 AND __EE133664.T19___Bnk_Acct_Is_Kr_Flag_ = 1);
  __JC134300(E_Bank_Account_Event.Layout __EE134282, B_Event_6.__ST95508_Layout __EE133809) := __EEQP(__EE134282.Transaction_,__EE133809.UID);
  SHARED __EE134301 := JOIN(__EE134282,__EE133809,__JC134300(LEFT,RIGHT),TRANSFORM(E_Bank_Account_Event.Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST133735_Layout := RECORD
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.ntyp(E_Event.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST133735_Layout __ND134311__Project(E_Bank_Account_Event.Layout __PP134302) := TRANSFORM
    SELF.UID := __PP134302.Account_;
    SELF.U_I_D__1_ := __PP134302.Transaction_;
    SELF := __PP134302;
  END;
  SHARED __EE134336 := PROJECT(__EE134301,__ND134311__Project(LEFT));
  SHARED __ST133761_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE134349 := PROJECT(__CLEANANDDO(__EE134336,TABLE(__EE134336,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST133761_Layout);
  SHARED __ST133999_Layout := RECORD
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
  __JC134355(E_Bank_Account.Layout __EE133575, __ST133761_Layout __EE134349) := __EEQP(__EE133575.UID,__EE134349.UID);
  __ST133999_Layout __JT134355(E_Bank_Account.Layout __l, __ST133761_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE134356 := JOIN(__EE133575,__EE134349,__JC134355(LEFT,RIGHT),__JT134355(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST91153_Layout := RECORD
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
  SHARED __ST91153_Layout __ND134374__Project(__ST133999_Layout __PP134357) := TRANSFORM
    SELF.Aot_Bnk_Acct_Kr_Act_Cnt_Ev_ := MIN(__PP134357.C_O_U_N_T___Exp1_,9999);
    SELF := __PP134357;
  END;
  EXPORT __ENH_Bank_Account_5 := PROJECT(__EE134356,__ND134374__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Bank_Account::Annotated_5',EXPIRE(7));
END;
