//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Bank_Account_4,B_Bank_Account_5,B_Event_4,E_Address,E_Bank,E_Bank_Account,E_Bank_Account_Event,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Bank_Account,E_Phone FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank_Account_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Bank_Account_4.__ENH_Bank_Account_4) __ENH_Bank_Account_4 := B_Bank_Account_4.__ENH_Bank_Account_4;
  SHARED VIRTUAL TYPEOF(E_Bank_Account_Event.__Result) __E_Bank_Account_Event := E_Bank_Account_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_4.__ENH_Event_4) __ENH_Event_4 := B_Event_4.__ENH_Event_4;
  SHARED VIRTUAL TYPEOF(E_Person_Bank_Account.__Result) __E_Person_Bank_Account := E_Person_Bank_Account.__Result;
  SHARED __EE186073 := __ENH_Bank_Account_4;
  SHARED __EE186728 := __E_Person_Bank_Account;
  SHARED __EE186735 := __EE186728(__NN(__EE186728.Account_));
  SHARED __ST186174_Layout := RECORD
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE186749 := PROJECT(TABLE(PROJECT(__EE186735,TRANSFORM(__ST186174_Layout,SELF.UID := LEFT.Account_,SELF := LEFT)),{KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),UID,Subject_},UID,Subject_,MERGE),__ST186174_Layout);
  SHARED __ST186192_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Bank_Account_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE186726 := PROJECT(__CLEANANDDO(__EE186749,TABLE(__EE186749,{KEL.typ.int C_O_U_N_T___Person_Bank_Account_ := COUNT(GROUP),UID},UID,MERGE)),__ST186192_Layout);
  SHARED __ST186437_Layout := RECORD
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
  __JC186758(B_Bank_Account_5.__ST57774_Layout __EE186073, __ST186192_Layout __EE186726) := __EEQP(__EE186073.UID,__EE186726.UID);
  __ST186437_Layout __JT186758(B_Bank_Account_5.__ST57774_Layout __l, __ST186192_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE186759 := JOIN(__EE186073,__EE186726,__JC186758(LEFT,RIGHT),__JT186758(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST186547_Layout := RECORD
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
  SHARED __EE186761 := __E_Bank_Account_Event;
  SHARED __EE186828 := __EE186761(__NN(__EE186761.Transaction_) AND __NN(__EE186761.Account_));
  SHARED __EE186763 := __ENH_Event_4;
  SHARED __EE186771 := __EE186763(__EE186763.Safe_Flag_ = 1);
  __JC186840(E_Bank_Account_Event.Layout __EE186828, B_Event_4.__ST57011_Layout __EE186771) := __EEQP(__EE186828.Transaction_,__EE186771.UID);
  SHARED __EE186841 := JOIN(__EE186828,__EE186771,__JC186840(LEFT,RIGHT),TRANSFORM(E_Bank_Account_Event.Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC186858(__ST186437_Layout __EE186759, E_Bank_Account_Event.Layout __EE186841) := __EEQP(__EE186759.UID,__EE186841.Account_);
  __JF186858(E_Bank_Account_Event.Layout __EE186841) := __NN(__EE186841.Account_);
  SHARED __EE186859 := JOIN(__EE186759,__EE186841,__JC186858(LEFT,RIGHT),TRANSFORM(__ST186547_Layout,SELF:=LEFT,SELF.Bank_Account_Event_:=__JF186858(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST54703_Layout := RECORD
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
  SHARED __ST54703_Layout __ND186877__Project(__ST186547_Layout __PP186860) := TRANSFORM
    SELF.Identity_Count_ := __PP186860.C_O_U_N_T___Person_Bank_Account_;
    SELF.Safe_Flag_ := MAP(__PP186860.Bank_Account_Event_=>1,0);
    SELF := __PP186860;
  END;
  EXPORT __ENH_Bank_Account_3 := PROJECT(__EE186859,__ND186877__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Bank_Account::Annotated_3',EXPIRE(7));
END;
