//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Bank_Account_4,B_Bank_Account_5,B_Event_4,E_Address,E_Bank,E_Bank_Account,E_Bank_Account_Event,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Bank_Account,E_Phone FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank_Account_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Bank_Account_4.__ENH_Bank_Account_4) __ENH_Bank_Account_4 := B_Bank_Account_4.__ENH_Bank_Account_4;
  SHARED VIRTUAL TYPEOF(E_Bank_Account_Event.__Result) __E_Bank_Account_Event := E_Bank_Account_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_4.__ENH_Event_4) __ENH_Event_4 := B_Event_4.__ENH_Event_4;
  SHARED VIRTUAL TYPEOF(E_Person_Bank_Account.__Result) __E_Person_Bank_Account := E_Person_Bank_Account.__Result;
  SHARED __EE177870 := __ENH_Bank_Account_4;
  SHARED __EE178525 := __E_Person_Bank_Account;
  SHARED __EE178532 := __EE178525(__NN(__EE178525.Account_));
  SHARED __ST177971_Layout := RECORD
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE178546 := PROJECT(TABLE(PROJECT(__EE178532,TRANSFORM(__ST177971_Layout,SELF.UID := LEFT.Account_,SELF := LEFT)),{KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),UID,Subject_},UID,Subject_,MERGE),__ST177971_Layout);
  SHARED __ST177989_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Bank_Account_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE178523 := PROJECT(__CLEANANDDO(__EE178546,TABLE(__EE178546,{KEL.typ.int C_O_U_N_T___Person_Bank_Account_ := COUNT(GROUP),UID},UID,MERGE)),__ST177989_Layout);
  SHARED __ST178234_Layout := RECORD
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
  __JC178555(B_Bank_Account_5.__ST53919_Layout __EE177870, __ST177989_Layout __EE178523) := __EEQP(__EE177870.UID,__EE178523.UID);
  __ST178234_Layout __JT178555(B_Bank_Account_5.__ST53919_Layout __l, __ST177989_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE178556 := JOIN(__EE177870,__EE178523,__JC178555(LEFT,RIGHT),__JT178555(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST178344_Layout := RECORD
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
  SHARED __EE178558 := __E_Bank_Account_Event;
  SHARED __EE178625 := __EE178558(__NN(__EE178558.Transaction_) AND __NN(__EE178558.Account_));
  SHARED __EE178560 := __ENH_Event_4;
  SHARED __EE178568 := __EE178560(__EE178560.Safe_Flag_ = 1);
  __JC178637(E_Bank_Account_Event.Layout __EE178625, B_Event_4.__ST53186_Layout __EE178568) := __EEQP(__EE178625.Transaction_,__EE178568.UID);
  SHARED __EE178638 := JOIN(__EE178625,__EE178568,__JC178637(LEFT,RIGHT),TRANSFORM(E_Bank_Account_Event.Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC178655(__ST178234_Layout __EE178556, E_Bank_Account_Event.Layout __EE178638) := __EEQP(__EE178556.UID,__EE178638.Account_);
  __JF178655(E_Bank_Account_Event.Layout __EE178638) := __NN(__EE178638.Account_);
  SHARED __EE178656 := JOIN(__EE178556,__EE178638,__JC178655(LEFT,RIGHT),TRANSFORM(__ST178344_Layout,SELF:=LEFT,SELF.Bank_Account_Event_:=__JF178655(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST50941_Layout := RECORD
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
  SHARED __ST50941_Layout __ND178674__Project(__ST178344_Layout __PP178657) := TRANSFORM
    SELF.Identity_Count_ := __PP178657.C_O_U_N_T___Person_Bank_Account_;
    SELF.Safe_Flag_ := MAP(__PP178657.Bank_Account_Event_=>1,0);
    SELF := __PP178657;
  END;
  EXPORT __ENH_Bank_Account_3 := PROJECT(__EE178656,__ND178674__Project(LEFT));
END;
