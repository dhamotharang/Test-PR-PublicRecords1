﻿//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Customer,E_Person,E_Person_Address FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_Address := MODULE
  SHARED VIRTUAL TYPEOF(E_Person_Address.__Result) __E_Person_Address := E_Person_Address.__Result;
  SHARED __EE2534310 := __E_Person_Address;
  EXPORT __ST43090_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ndataset(E_Person_Address.Event_Dates_Layout) Event_Dates_;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST43090_Layout __ND2534344__Project(E_Person_Address.Layout __PP2534205) := TRANSFORM
    __EE2534243 := __PP2534205.Event_Dates_;
    SELF.Dt_First_Seen_ := KEL.Aggregates.MinNN(__EE2534243,__T(__EE2534243).Event_Date_);
    __EE2534272 := __PP2534205.Event_Dates_;
    SELF.Dt_Last_Seen_ := KEL.Aggregates.MaxNN(__EE2534272,__T(__EE2534272).Event_Date_);
    SELF := __PP2534205;
  END;
  EXPORT __ENH_Person_Address := PROJECT(__EE2534310,__ND2534344__Project(LEFT)) : PERSIST('~temp::KEL::KELOtto::Person_Address::Annotated',EXPIRE(7));
  SHARED __EE3177213 := __ENH_Person_Address;
  SHARED __IDX_Person_Address_Location__Filtered := __EE3177213(__NN(__EE3177213.Location_));
  SHARED IDX_Person_Address_Location__Layout := RECORD
    E_Address.Typ Location_;
    __IDX_Person_Address_Location__Filtered._r_Customer_;
    __IDX_Person_Address_Location__Filtered.Subject_;
    __IDX_Person_Address_Location__Filtered.Event_Dates_;
    __IDX_Person_Address_Location__Filtered.Dt_First_Seen_;
    __IDX_Person_Address_Location__Filtered.Dt_Last_Seen_;
    __IDX_Person_Address_Location__Filtered.Date_First_Seen_;
    __IDX_Person_Address_Location__Filtered.Date_Last_Seen_;
    __IDX_Person_Address_Location__Filtered.__RecordCount;
  END;
  SHARED IDX_Person_Address_Location__Projected := PROJECT(__IDX_Person_Address_Location__Filtered,TRANSFORM(IDX_Person_Address_Location__Layout,SELF.Location_:=__T(LEFT.Location_),SELF:=LEFT));
  EXPORT IDX_Person_Address_Location__Name := '~key::KEL::KELOtto::Person_Address::Location_';
  EXPORT IDX_Person_Address_Location_ := INDEX(IDX_Person_Address_Location__Projected,{Location_},{IDX_Person_Address_Location__Projected},IDX_Person_Address_Location__Name);
  EXPORT IDX_Person_Address_Location__Build := BUILD(IDX_Person_Address_Location_,OVERWRITE);
  EXPORT __ST3177215_Layout := RECORDOF(IDX_Person_Address_Location_);
  EXPORT IDX_Person_Address_Location__Wrapped := PROJECT(IDX_Person_Address_Location_,TRANSFORM(__ST43090_Layout,SELF.Location_ := __CN(LEFT.Location_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Person_Address_Location__Build);
END;
