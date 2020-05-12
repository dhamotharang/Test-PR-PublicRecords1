﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Customer,E_Drivers_License,E_Person,E_Person_Drivers_License FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_Drivers_License := MODULE
  SHARED VIRTUAL TYPEOF(E_Person_Drivers_License.__Result) __E_Person_Drivers_License := E_Person_Drivers_License.__Result;
  SHARED __EE2032712 := __E_Person_Drivers_License;
  EXPORT __ST43553_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Drivers_License.Typ) License_;
    KEL.typ.ndataset(E_Person_Drivers_License.Event_Dates_Layout) Event_Dates_;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST43553_Layout __ND2032746__Project(E_Person_Drivers_License.Layout __PP2032607) := TRANSFORM
    __EE2032645 := __PP2032607.Event_Dates_;
    SELF.Dt_First_Seen_ := KEL.Aggregates.MinNN(__EE2032645,__T(__EE2032645).Event_Date_);
    __EE2032674 := __PP2032607.Event_Dates_;
    SELF.Dt_Last_Seen_ := KEL.Aggregates.MaxNN(__EE2032674,__T(__EE2032674).Event_Date_);
    SELF := __PP2032607;
  END;
  EXPORT __ENH_Person_Drivers_License := PROJECT(__EE2032712,__ND2032746__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Person_Drivers_License::Annotated',EXPIRE(7));
  SHARED __EE2277910 := __ENH_Person_Drivers_License;
  SHARED __IDX_Person_Drivers_License_License__Filtered := __EE2277910(__NN(__EE2277910.License_));
  SHARED IDX_Person_Drivers_License_License__Layout := RECORD
    E_Drivers_License.Typ License_;
    __IDX_Person_Drivers_License_License__Filtered._r_Customer_;
    __IDX_Person_Drivers_License_License__Filtered.Subject_;
    __IDX_Person_Drivers_License_License__Filtered.Event_Dates_;
    __IDX_Person_Drivers_License_License__Filtered.Dt_First_Seen_;
    __IDX_Person_Drivers_License_License__Filtered.Dt_Last_Seen_;
    __IDX_Person_Drivers_License_License__Filtered.Date_First_Seen_;
    __IDX_Person_Drivers_License_License__Filtered.Date_Last_Seen_;
    __IDX_Person_Drivers_License_License__Filtered.__RecordCount;
  END;
  SHARED IDX_Person_Drivers_License_License__Projected := PROJECT(__IDX_Person_Drivers_License_License__Filtered,TRANSFORM(IDX_Person_Drivers_License_License__Layout,SELF.License_:=__T(LEFT.License_),SELF:=LEFT));
  EXPORT IDX_Person_Drivers_License_License__Name := '~key::KEL::FraudgovKEL::Person_Drivers_License::License_';
  EXPORT IDX_Person_Drivers_License_License_ := INDEX(IDX_Person_Drivers_License_License__Projected,{License_},{IDX_Person_Drivers_License_License__Projected},IDX_Person_Drivers_License_License__Name);
  EXPORT IDX_Person_Drivers_License_License__Build := BUILD(IDX_Person_Drivers_License_License_,OVERWRITE);
  EXPORT __ST2277912_Layout := RECORDOF(IDX_Person_Drivers_License_License_);
  EXPORT IDX_Person_Drivers_License_License__Wrapped := PROJECT(IDX_Person_Drivers_License_License_,TRANSFORM(__ST43553_Layout,SELF.License_ := __CN(LEFT.License_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Person_Drivers_License_License__Build);
END;
