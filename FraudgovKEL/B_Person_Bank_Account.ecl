﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Bank,E_Bank_Account,E_Customer,E_Person,E_Person_Bank_Account FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_Bank_Account := MODULE
  SHARED VIRTUAL TYPEOF(E_Person_Bank_Account.__Result) __E_Person_Bank_Account := E_Person_Bank_Account.__Result;
  SHARED __EE2537219 := __E_Person_Bank_Account;
  EXPORT __ST53103_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.ndataset(E_Person_Bank_Account.Event_Dates_Layout) Event_Dates_;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST53103_Layout __ND2537253__Project(E_Person_Bank_Account.Layout __PP2537114) := TRANSFORM
    __EE2537152 := __PP2537114.Event_Dates_;
    SELF.Dt_First_Seen_ := KEL.Aggregates.MinNN(__EE2537152,__T(__EE2537152).Event_Date_);
    __EE2537181 := __PP2537114.Event_Dates_;
    SELF.Dt_Last_Seen_ := KEL.Aggregates.MaxNN(__EE2537181,__T(__EE2537181).Event_Date_);
    SELF := __PP2537114;
  END;
  EXPORT __ENH_Person_Bank_Account := PROJECT(__EE2537219,__ND2537253__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Person_Bank_Account::Annotated',EXPIRE(7));
  SHARED __EE2805168 := __ENH_Person_Bank_Account;
  SHARED __IDX_Person_Bank_Account_Account__Filtered := __EE2805168(__NN(__EE2805168.Account_));
  SHARED IDX_Person_Bank_Account_Account__Layout := RECORD
    E_Bank_Account.Typ Account_;
    __IDX_Person_Bank_Account_Account__Filtered._r_Customer_;
    __IDX_Person_Bank_Account_Account__Filtered.Subject_;
    __IDX_Person_Bank_Account_Account__Filtered.Event_Dates_;
    __IDX_Person_Bank_Account_Account__Filtered.Dt_First_Seen_;
    __IDX_Person_Bank_Account_Account__Filtered.Dt_Last_Seen_;
    __IDX_Person_Bank_Account_Account__Filtered.Date_First_Seen_;
    __IDX_Person_Bank_Account_Account__Filtered.Date_Last_Seen_;
    __IDX_Person_Bank_Account_Account__Filtered.__RecordCount;
  END;
  SHARED IDX_Person_Bank_Account_Account__Projected := PROJECT(__IDX_Person_Bank_Account_Account__Filtered,TRANSFORM(IDX_Person_Bank_Account_Account__Layout,SELF.Account_:=__T(LEFT.Account_),SELF:=LEFT));
  EXPORT IDX_Person_Bank_Account_Account__Name := '~key::KEL::FraudgovKEL::Person_Bank_Account::Account_';
  EXPORT IDX_Person_Bank_Account_Account_ := INDEX(IDX_Person_Bank_Account_Account__Projected,{Account_},{IDX_Person_Bank_Account_Account__Projected},IDX_Person_Bank_Account_Account__Name);
  EXPORT IDX_Person_Bank_Account_Account__Build := BUILD(IDX_Person_Bank_Account_Account_,OVERWRITE);
  EXPORT __ST2805170_Layout := RECORDOF(IDX_Person_Bank_Account_Account_);
  EXPORT IDX_Person_Bank_Account_Account__Wrapped := PROJECT(IDX_Person_Bank_Account_Account_,TRANSFORM(__ST53103_Layout,SELF.Account_ := __CN(LEFT.Account_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Person_Bank_Account_Account__Build);
END;
