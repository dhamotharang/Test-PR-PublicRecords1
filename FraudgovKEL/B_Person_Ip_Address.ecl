//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Customer,E_Internet_Protocol,E_Person,E_Person_Ip_Address FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_Ip_Address := MODULE
  SHARED VIRTUAL TYPEOF(E_Person_Ip_Address.__Result) __E_Person_Ip_Address := E_Person_Ip_Address.__Result;
  SHARED __EE2341256 := __E_Person_Ip_Address;
  EXPORT __ST45867_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) Ip_;
    KEL.typ.ndataset(E_Person_Ip_Address.Event_Dates_Layout) Event_Dates_;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST45867_Layout __ND2341290__Project(E_Person_Ip_Address.Layout __PP2341151) := TRANSFORM
    __EE2341189 := __PP2341151.Event_Dates_;
    SELF.Dt_First_Seen_ := KEL.Aggregates.MinNN(__EE2341189,__T(__EE2341189).Event_Date_);
    __EE2341218 := __PP2341151.Event_Dates_;
    SELF.Dt_Last_Seen_ := KEL.Aggregates.MaxNN(__EE2341218,__T(__EE2341218).Event_Date_);
    SELF := __PP2341151;
  END;
  EXPORT __ENH_Person_Ip_Address := PROJECT(__EE2341256,__ND2341290__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Person_Ip_Address::Annotated',EXPIRE(7));
  SHARED __EE2599696 := __ENH_Person_Ip_Address;
  SHARED __IDX_Person_Ip_Address_Ip__Filtered := __EE2599696(__NN(__EE2599696.Ip_));
  SHARED IDX_Person_Ip_Address_Ip__Layout := RECORD
    E_Internet_Protocol.Typ Ip_;
    __IDX_Person_Ip_Address_Ip__Filtered._r_Customer_;
    __IDX_Person_Ip_Address_Ip__Filtered.Subject_;
    __IDX_Person_Ip_Address_Ip__Filtered.Event_Dates_;
    __IDX_Person_Ip_Address_Ip__Filtered.Dt_First_Seen_;
    __IDX_Person_Ip_Address_Ip__Filtered.Dt_Last_Seen_;
    __IDX_Person_Ip_Address_Ip__Filtered.Date_First_Seen_;
    __IDX_Person_Ip_Address_Ip__Filtered.Date_Last_Seen_;
    __IDX_Person_Ip_Address_Ip__Filtered.__RecordCount;
  END;
  SHARED IDX_Person_Ip_Address_Ip__Projected := PROJECT(__IDX_Person_Ip_Address_Ip__Filtered,TRANSFORM(IDX_Person_Ip_Address_Ip__Layout,SELF.Ip_:=__T(LEFT.Ip_),SELF:=LEFT));
  EXPORT IDX_Person_Ip_Address_Ip__Name := '~key::KEL::FraudgovKEL::Person_Ip_Address::Ip_';
  EXPORT IDX_Person_Ip_Address_Ip_ := INDEX(IDX_Person_Ip_Address_Ip__Projected,{Ip_},{IDX_Person_Ip_Address_Ip__Projected},IDX_Person_Ip_Address_Ip__Name);
  EXPORT IDX_Person_Ip_Address_Ip__Build := BUILD(IDX_Person_Ip_Address_Ip_,OVERWRITE);
  EXPORT __ST2599698_Layout := RECORDOF(IDX_Person_Ip_Address_Ip_);
  EXPORT IDX_Person_Ip_Address_Ip__Wrapped := PROJECT(IDX_Person_Ip_Address_Ip_,TRANSFORM(__ST45867_Layout,SELF.Ip_ := __CN(LEFT.Ip_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Person_Ip_Address_Ip__Build);
END;
