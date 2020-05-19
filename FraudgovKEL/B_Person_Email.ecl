//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Customer,E_Email,E_Person,E_Person_Email FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_Email := MODULE
  SHARED VIRTUAL TYPEOF(E_Person_Email.__Result) __E_Person_Email := E_Person_Email.__Result;
  SHARED __EE2095740 := __E_Person_Email;
  EXPORT __ST45409_Layout := RECORD
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
  SHARED __ST45409_Layout __ND2095774__Project(E_Person_Email.Layout __PP2095635) := TRANSFORM
    __EE2095673 := __PP2095635.Event_Dates_;
    SELF.Dt_First_Seen_ := KEL.Aggregates.MinNN(__EE2095673,__T(__EE2095673).Event_Date_);
    __EE2095702 := __PP2095635.Event_Dates_;
    SELF.Dt_Last_Seen_ := KEL.Aggregates.MaxNN(__EE2095702,__T(__EE2095702).Event_Date_);
    SELF := __PP2095635;
  END;
  EXPORT __ENH_Person_Email := PROJECT(__EE2095740,__ND2095774__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Person_Email::Annotated',EXPIRE(7));
  SHARED __EE2342243 := __ENH_Person_Email;
  SHARED __IDX_Person_Email_Emailof__Filtered := __EE2342243(__NN(__EE2342243.Emailof_));
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
  EXPORT __ST2342245_Layout := RECORDOF(IDX_Person_Email_Emailof_);
  EXPORT IDX_Person_Email_Emailof__Wrapped := PROJECT(IDX_Person_Email_Emailof_,TRANSFORM(__ST45409_Layout,SELF.Emailof_ := __CN(LEFT.Emailof_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Person_Email_Emailof__Build);
END;
