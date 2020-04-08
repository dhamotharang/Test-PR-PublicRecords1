//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Customer,E_Email,E_Person,E_Person_Email FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_Email := MODULE
  SHARED VIRTUAL TYPEOF(E_Person_Email.__Result) __E_Person_Email := E_Person_Email.__Result;
  SHARED __EE1127830 := __E_Person_Email;
  EXPORT __ST31184_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.ndataset(E_Person_Email.Event_Dates_Layout) Event_Dates_;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST31184_Layout __ND1127864__Project(E_Person_Email.Layout __PP1127725) := TRANSFORM
    __EE1127763 := __PP1127725.Event_Dates_;
    SELF.Dt_First_Seen_ := KEL.Aggregates.MinNN(__EE1127763,__T(__EE1127763).Event_Date_);
    __EE1127792 := __PP1127725.Event_Dates_;
    SELF.Dt_Last_Seen_ := KEL.Aggregates.MaxNN(__EE1127792,__T(__EE1127792).Event_Date_);
    SELF := __PP1127725;
  END;
  EXPORT __ENH_Person_Email := PROJECT(__EE1127830,__ND1127864__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Person_Email::Annotated',EXPIRE(7));
  SHARED __EE1387725 := __ENH_Person_Email;
  SHARED __IDX_Person_Email_Emailof__Filtered := __EE1387725(__NN(__EE1387725.Emailof_));
  SHARED IDX_Person_Email_Emailof__Layout := RECORD
    E_Email.Typ Emailof_;
    __IDX_Person_Email_Emailof__Filtered._r_Customer_;
    __IDX_Person_Email_Emailof__Filtered.Subject_;
    __IDX_Person_Email_Emailof__Filtered.Event_Dates_;
    __IDX_Person_Email_Emailof__Filtered.Dt_First_Seen_;
    __IDX_Person_Email_Emailof__Filtered.Dt_Last_Seen_;
    __IDX_Person_Email_Emailof__Filtered.Date_First_Seen_;
    __IDX_Person_Email_Emailof__Filtered.Date_Last_Seen_;
    __IDX_Person_Email_Emailof__Filtered.__RecordCount;
  END;
  SHARED IDX_Person_Email_Emailof__Projected := PROJECT(__IDX_Person_Email_Emailof__Filtered,TRANSFORM(IDX_Person_Email_Emailof__Layout,SELF.Emailof_:=__T(LEFT.Emailof_),SELF:=LEFT));
  EXPORT IDX_Person_Email_Emailof__Name := '~key::KEL::FraudgovKEL::Person_Email::Emailof_';
  EXPORT IDX_Person_Email_Emailof_ := INDEX(IDX_Person_Email_Emailof__Projected,{Emailof_},{IDX_Person_Email_Emailof__Projected},IDX_Person_Email_Emailof__Name);
  EXPORT IDX_Person_Email_Emailof__Build := BUILD(IDX_Person_Email_Emailof_,OVERWRITE);
  EXPORT __ST1387727_Layout := RECORDOF(IDX_Person_Email_Emailof_);
  EXPORT IDX_Person_Email_Emailof__Wrapped := PROJECT(IDX_Person_Email_Emailof_,TRANSFORM(__ST31184_Layout,SELF.Emailof_ := __CN(LEFT.Emailof_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Person_Email_Emailof__Build);
END;
