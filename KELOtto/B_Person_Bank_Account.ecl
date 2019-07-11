//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Bank,E_Bank_Account,E_Customer,E_Person,E_Person_Bank_Account FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_Bank_Account := MODULE
  SHARED VIRTUAL TYPEOF(E_Person_Bank_Account.__Result) __E_Person_Bank_Account := E_Person_Bank_Account.__Result;
  SHARED __EE2113838 := __E_Person_Bank_Account;
  EXPORT __ST39866_Layout := RECORD
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
  SHARED __ST39866_Layout __ND2113872__Project(E_Person_Bank_Account.Layout __PP2113733) := TRANSFORM
    __EE2113771 := __PP2113733.Event_Dates_;
    SELF.Dt_First_Seen_ := KEL.Aggregates.MinNN(__EE2113771,__T(__EE2113771).Event_Date_);
    __EE2113800 := __PP2113733.Event_Dates_;
    SELF.Dt_Last_Seen_ := KEL.Aggregates.MaxNN(__EE2113800,__T(__EE2113800).Event_Date_);
    SELF := __PP2113733;
  END;
  EXPORT __ENH_Person_Bank_Account := PROJECT(__EE2113838,__ND2113872__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Person_Bank_Account::Annotated',EXPIRE(7));
  SHARED __EE2630312 := __ENH_Person_Bank_Account;
  SHARED __IDX_Person_Bank_Account_Account__Filtered := __EE2630312(__NN(__EE2630312.Account_));
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
  EXPORT IDX_Person_Bank_Account_Account__Name := '~key::KEL::KELOtto::Person_Bank_Account::Account_';
  EXPORT IDX_Person_Bank_Account_Account_ := INDEX(IDX_Person_Bank_Account_Account__Projected,{Account_},{IDX_Person_Bank_Account_Account__Projected},IDX_Person_Bank_Account_Account__Name);
  EXPORT IDX_Person_Bank_Account_Account__Build := BUILD(IDX_Person_Bank_Account_Account_,OVERWRITE);
  EXPORT __ST2630314_Layout := RECORDOF(IDX_Person_Bank_Account_Account_);
  EXPORT IDX_Person_Bank_Account_Account__Wrapped := PROJECT(IDX_Person_Bank_Account_Account_,TRANSFORM(__ST39866_Layout,SELF.Account_ := __CN(LEFT.Account_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Person_Bank_Account_Account__Build);
END;
