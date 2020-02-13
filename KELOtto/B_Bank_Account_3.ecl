//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT B_Bank_Account_4,B_Bank_Account_5,B_Event_4,E_Address,E_Bank,E_Bank_Account,E_Bank_Account_Event,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Person_Bank_Account,E_Phone FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Bank_Account_3 := MODULE
  SHARED VIRTUAL TYPEOF(B_Bank_Account_4.__ENH_Bank_Account_4) __ENH_Bank_Account_4 := B_Bank_Account_4.__ENH_Bank_Account_4;
  SHARED VIRTUAL TYPEOF(E_Bank_Account_Event.__Result) __E_Bank_Account_Event := E_Bank_Account_Event.__Result;
  SHARED VIRTUAL TYPEOF(B_Event_4.__ENH_Event_4) __ENH_Event_4 := B_Event_4.__ENH_Event_4;
  SHARED VIRTUAL TYPEOF(E_Person_Bank_Account.__Result) __E_Person_Bank_Account := E_Person_Bank_Account.__Result;
  SHARED __EE196238 := __ENH_Bank_Account_4;
  SHARED __EE196893 := __E_Person_Bank_Account;
  SHARED __EE196900 := __EE196893(__NN(__EE196893.Account_));
  SHARED __ST196339_Layout := RECORD
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE196914 := PROJECT(TABLE(PROJECT(__EE196900,TRANSFORM(__ST196339_Layout,SELF.UID := LEFT.Account_,SELF := LEFT)),{KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),UID,Subject_},UID,Subject_,MERGE),__ST196339_Layout);
  SHARED __ST196357_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Person_Bank_Account_ := 0;
    KEL.typ.ntyp(E_Bank_Account.Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE196891 := PROJECT(__CLEANANDDO(__EE196914,TABLE(__EE196914,{KEL.typ.int C_O_U_N_T___Person_Bank_Account_ := COUNT(GROUP),UID},UID,MERGE)),__ST196357_Layout);
  SHARED __ST196602_Layout := RECORD
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
  __JC196923(B_Bank_Account_5.__ST61981_Layout __EE196238, __ST196357_Layout __EE196891) := __EEQP(__EE196238.UID,__EE196891.UID);
  __ST196602_Layout __JT196923(B_Bank_Account_5.__ST61981_Layout __l, __ST196357_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE196924 := JOIN(__EE196238,__EE196891,__JC196923(LEFT,RIGHT),__JT196923(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST196712_Layout := RECORD
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
  SHARED __EE196926 := __E_Bank_Account_Event;
  SHARED __EE196993 := __EE196926(__NN(__EE196926.Transaction_) AND __NN(__EE196926.Account_));
  SHARED __EE196928 := __ENH_Event_4;
  SHARED __EE196936 := __EE196928(__EE196928.Safe_Flag_ = 1);
  __JC197005(E_Bank_Account_Event.Layout __EE196993, B_Event_4.__ST61185_Layout __EE196936) := __EEQP(__EE196993.Transaction_,__EE196936.UID);
  SHARED __EE197006 := JOIN(__EE196993,__EE196936,__JC197005(LEFT,RIGHT),TRANSFORM(E_Bank_Account_Event.Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC197023(__ST196602_Layout __EE196924, E_Bank_Account_Event.Layout __EE197006) := __EEQP(__EE196924.UID,__EE197006.Account_);
  __JF197023(E_Bank_Account_Event.Layout __EE197006) := __NN(__EE197006.Account_);
  SHARED __EE197024 := JOIN(__EE196924,__EE197006,__JC197023(LEFT,RIGHT),TRANSFORM(__ST196712_Layout,SELF:=LEFT,SELF.Bank_Account_Event_:=__JF197023(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST58572_Layout := RECORD
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
  SHARED __ST58572_Layout __ND197042__Project(__ST196712_Layout __PP197025) := TRANSFORM
    SELF.Identity_Count_ := __PP197025.C_O_U_N_T___Person_Bank_Account_;
    SELF.Safe_Flag_ := MAP(__PP197025.Bank_Account_Event_=>1,0);
    SELF := __PP197025;
  END;
  EXPORT __ENH_Bank_Account_3 := PROJECT(__EE197024,__ND197042__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Bank_Account::Annotated_3',EXPIRE(7));
END;
