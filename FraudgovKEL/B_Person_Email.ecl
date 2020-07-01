//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Customer,E_Email,E_Person,E_Person_Email FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_Email := MODULE
  SHARED VIRTUAL TYPEOF(E_Person_Email.__Result) __E_Person_Email := E_Person_Email.__Result;
  SHARED __EE3960263 := __E_Person_Email;
  EXPORT __ST66763_Layout := RECORD
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
  SHARED __ST66763_Layout __ND3960297__Project(E_Person_Email.Layout __PP3960158) := TRANSFORM
    __EE3960196 := __PP3960158.Event_Dates_;
    SELF.Dt_First_Seen_ := KEL.Aggregates.MinNN(__EE3960196,__T(__EE3960196).Event_Date_);
    __EE3960225 := __PP3960158.Event_Dates_;
    SELF.Dt_Last_Seen_ := KEL.Aggregates.MaxNN(__EE3960225,__T(__EE3960225).Event_Date_);
    SELF := __PP3960158;
  END;
  EXPORT __ENH_Person_Email := PROJECT(__EE3960263,__ND3960297__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Person_Email::Annotated',EXPIRE(7));
  SHARED __EE4267413 := __ENH_Person_Email;
  SHARED __IDX_Person_Email_Emailof__Filtered := __EE4267413(__NN(__EE4267413.Emailof_));
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
  EXPORT __ST4267415_Layout := RECORDOF(IDX_Person_Email_Emailof_);
  EXPORT IDX_Person_Email_Emailof__Wrapped := PROJECT(IDX_Person_Email_Emailof_,TRANSFORM(__ST66763_Layout,SELF.Emailof_ := __CN(LEFT.Emailof_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Person_Email_Emailof__Build);
END;
