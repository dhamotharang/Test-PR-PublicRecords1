//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Bank_Account_4,B_Bank_Account_5,B_Event_4,E_Address,E_Bank,E_Bank_Account,E_Bank_Account_Event,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Bank_Account,E_Phone FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank_Account_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Bank_Account_4.__ENH_Bank_Account_4) __ENH_Bank_Account_4 := B_Bank_Account_4.__ENH_Bank_Account_4;
  SHARED VIRTUAL TYPEOF(E_Bank_Account_Event.__Result) __E_Bank_Account_Event := E_Bank_Account_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_4.__ENH_Event_4) __ENH_Event_4 := B_Event_4.__ENH_Event_4;
  SHARED VIRTUAL TYPEOF(E_Person_Bank_Account.__Result) __E_Person_Bank_Account := E_Person_Bank_Account.__Result;
  SHARED __EE189739 := __ENH_Bank_Account_4;
  SHARED __EE190394 := __E_Person_Bank_Account;
  SHARED __EE190401 := __EE190394(__NN(__EE190394.Account_));
  SHARED __ST189840_Layout := RECORD
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE190415 := PROJECT(TABLE(PROJECT(__EE190401,TRANSFORM(__ST189840_Layout,SELF.UID := LEFT.Account_,SELF := LEFT)),{KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),UID,Subject_},UID,Subject_,MERGE),__ST189840_Layout);
  SHARED __ST189858_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Bank_Account_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE190392 := PROJECT(__CLEANANDDO(__EE190415,TABLE(__EE190415,{KEL.typ.int C_O_U_N_T___Person_Bank_Account_ := COUNT(GROUP),UID},UID,MERGE)),__ST189858_Layout);
  SHARED __ST190103_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Bank_Account.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Bank.Typ) _r_Bank_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nstr Otto_Bank_Account_Id_;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.int C_O_U_N_T___Person_Bank_Account_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC190424(B_Bank_Account_5.__ST61428_Layout __EE189739, __ST189858_Layout __EE190392) := __EEQP(__EE189739.UID,__EE190392.UID);
  __ST190103_Layout __JT190424(B_Bank_Account_5.__ST61428_Layout __l, __ST189858_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE190425 := JOIN(__EE189739,__EE190392,__JC190424(LEFT,RIGHT),__JT190424(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST190213_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Bank_Account.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Bank.Typ) _r_Bank_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nstr Otto_Bank_Account_Id_;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.int C_O_U_N_T___Person_Bank_Account_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) U_I_D__1_;
    KEL.typ.bool Bank_Account_Event_ := FALSE;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE190427 := __E_Bank_Account_Event;
  SHARED __EE190494 := __EE190427(__NN(__EE190427.Transaction_) AND __NN(__EE190427.Account_));
  SHARED __EE190429 := __ENH_Event_4;
  SHARED __EE190437 := __EE190429(__EE190429.Safe_Flag_ = 1);
  __JC190506(E_Bank_Account_Event.Layout __EE190494, B_Event_4.__ST60665_Layout __EE190437) := __EEQP(__EE190494.Transaction_,__EE190437.UID);
  SHARED __EE190507 := JOIN(__EE190494,__EE190437,__JC190506(LEFT,RIGHT),TRANSFORM(E_Bank_Account_Event.Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC190524(__ST190103_Layout __EE190425, E_Bank_Account_Event.Layout __EE190507) := __EEQP(__EE190425.UID,__EE190507.Account_);
  __JF190524(E_Bank_Account_Event.Layout __EE190507) := __NN(__EE190507.Account_);
  SHARED __EE190525 := JOIN(__EE190425,__EE190507,__JC190524(LEFT,RIGHT),TRANSFORM(__ST190213_Layout,SELF:=LEFT,SELF.Bank_Account_Event_:=__JF190524(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST58341_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(E_Bank_Account.Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Bank.Typ) _r_Bank_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nstr Otto_Bank_Account_Id_;
    KEL.typ.int Identity_Count_ := 0;
    KEL.typ.nkdate Kr_Last_Event_Date_;
    KEL.typ.int Safe_Flag_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST58341_Layout __ND190543__Project(__ST190213_Layout __PP190526) := TRANSFORM
    SELF.Identity_Count_ := __PP190526.C_O_U_N_T___Person_Bank_Account_;
    SELF.Safe_Flag_ := MAP(__PP190526.Bank_Account_Event_=>1,0);
    SELF := __PP190526;
  END;
  EXPORT __ENH_Bank_Account_3 := PROJECT(__EE190525,__ND190543__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Bank_Account::Annotated_3',EXPIRE(7));
END;
