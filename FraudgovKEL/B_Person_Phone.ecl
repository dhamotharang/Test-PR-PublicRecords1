﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Customer,E_Person,E_Person_Phone,E_Phone FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_Phone := MODULE
  SHARED VIRTUAL TYPEOF(E_Person_Phone.__Result) __E_Person_Phone := E_Person_Phone.__Result;
  SHARED __EE4004951 := __E_Person_Phone;
  EXPORT __ST67097_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.ndataset(E_Person_Phone.Event_Dates_Layout) Event_Dates_;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST67097_Layout __ND4004985__Project(E_Person_Phone.Layout __PP4004846) := TRANSFORM
    __EE4004884 := __PP4004846.Event_Dates_;
    SELF.Dt_First_Seen_ := KEL.Aggregates.MinNN(__EE4004884,__T(__EE4004884).Event_Date_);
    __EE4004913 := __PP4004846.Event_Dates_;
    SELF.Dt_Last_Seen_ := KEL.Aggregates.MaxNN(__EE4004913,__T(__EE4004913).Event_Date_);
    SELF := __PP4004846;
  END;
  EXPORT __ENH_Person_Phone := PROJECT(__EE4004951,__ND4004985__Project(LEFT)) : PERSIST('~fraudgov::tempKEL::FraudgovKEL::Person_Phone::Annotated',EXPIRE(7));
  SHARED __EE4316277 := __ENH_Person_Phone;
  SHARED __IDX_Person_Phone_Phone_Number__Filtered := __EE4316277(__NN(__EE4316277.Phone_Number_));
  SHARED IDX_Person_Phone_Phone_Number__Layout := RECORD
    E_Phone.Typ Phone_Number_;
    __IDX_Person_Phone_Phone_Number__Filtered._r_Customer_;
    __IDX_Person_Phone_Phone_Number__Filtered.Subject_;
    __IDX_Person_Phone_Phone_Number__Filtered.Event_Dates_;
    __IDX_Person_Phone_Phone_Number__Filtered.Dt_First_Seen_;
    __IDX_Person_Phone_Phone_Number__Filtered.Dt_Last_Seen_;
    __IDX_Person_Phone_Phone_Number__Filtered.Date_First_Seen_;
    __IDX_Person_Phone_Phone_Number__Filtered.Date_Last_Seen_;
    __IDX_Person_Phone_Phone_Number__Filtered.__RecordCount;
  END;
  SHARED IDX_Person_Phone_Phone_Number__Projected := PROJECT(__IDX_Person_Phone_Phone_Number__Filtered,TRANSFORM(IDX_Person_Phone_Phone_Number__Layout,SELF.Phone_Number_:=__T(LEFT.Phone_Number_),SELF:=LEFT));
  EXPORT IDX_Person_Phone_Phone_Number__Name := '~key::KEL::FraudgovKEL::Person_Phone::Phone_Number_';
  EXPORT IDX_Person_Phone_Phone_Number_ := INDEX(IDX_Person_Phone_Phone_Number__Projected,{Phone_Number_},{IDX_Person_Phone_Phone_Number__Projected},IDX_Person_Phone_Phone_Number__Name);
  EXPORT IDX_Person_Phone_Phone_Number__Build := BUILD(IDX_Person_Phone_Phone_Number_,OVERWRITE);
  EXPORT __ST4316279_Layout := RECORDOF(IDX_Person_Phone_Phone_Number_);
  EXPORT IDX_Person_Phone_Phone_Number__Wrapped := PROJECT(IDX_Person_Phone_Phone_Number_,TRANSFORM(__ST67097_Layout,SELF.Phone_Number_ := __CN(LEFT.Phone_Number_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Person_Phone_Phone_Number__Build);
END;
