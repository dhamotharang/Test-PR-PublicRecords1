//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT E_Address,E_Customer,E_Person,E_Person_S_S_N,E_Social_Security_Number FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Person_S_S_N := MODULE
  SHARED VIRTUAL TYPEOF(E_Person_S_S_N.__Result) __E_Person_S_S_N := E_Person_S_S_N.__Result;
  SHARED __EE2088956 := __E_Person_S_S_N;
  EXPORT __ST45469_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) Social_;
    KEL.typ.ndataset(E_Person_S_S_N.Event_Dates_Layout) Event_Dates_;
    KEL.typ.nkdate Dt_First_Seen_;
    KEL.typ.nkdate Dt_Last_Seen_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST45469_Layout __ND2088990__Project(E_Person_S_S_N.Layout __PP2088851) := TRANSFORM
    __EE2088889 := __PP2088851.Event_Dates_;
    SELF.Dt_First_Seen_ := KEL.Aggregates.MinNN(__EE2088889,__T(__EE2088889).Event_Date_);
    __EE2088918 := __PP2088851.Event_Dates_;
    SELF.Dt_Last_Seen_ := KEL.Aggregates.MaxNN(__EE2088918,__T(__EE2088918).Event_Date_);
    SELF := __PP2088851;
  END;
  EXPORT __ENH_Person_S_S_N := PROJECT(__EE2088956,__ND2088990__Project(LEFT)) : PERSIST('~temp::KEL::FraudgovKEL::Person_S_S_N::Annotated',EXPIRE(7));
  SHARED __EE2336098 := __ENH_Person_S_S_N;
  SHARED __IDX_Person_S_S_N_Social__Filtered := __EE2336098(__NN(__EE2336098.Social_));
  SHARED IDX_Person_S_S_N_Social__Layout := RECORD
    E_Social_Security_Number.Typ Social_;
    __IDX_Person_S_S_N_Social__Filtered._r_Customer_;
    __IDX_Person_S_S_N_Social__Filtered.Subject_;
    __IDX_Person_S_S_N_Social__Filtered.Event_Dates_;
    __IDX_Person_S_S_N_Social__Filtered.Dt_First_Seen_;
    __IDX_Person_S_S_N_Social__Filtered.Dt_Last_Seen_;
    __IDX_Person_S_S_N_Social__Filtered.Date_First_Seen_;
    __IDX_Person_S_S_N_Social__Filtered.Date_Last_Seen_;
    __IDX_Person_S_S_N_Social__Filtered.__RecordCount;
  END;
  SHARED IDX_Person_S_S_N_Social__Projected := PROJECT(__IDX_Person_S_S_N_Social__Filtered,TRANSFORM(IDX_Person_S_S_N_Social__Layout,SELF.Social_:=__T(LEFT.Social_),SELF:=LEFT));
  EXPORT IDX_Person_S_S_N_Social__Name := '~key::KEL::FraudgovKEL::Person_S_S_N::Social_';
  EXPORT IDX_Person_S_S_N_Social_ := INDEX(IDX_Person_S_S_N_Social__Projected,{Social_},{IDX_Person_S_S_N_Social__Projected},IDX_Person_S_S_N_Social__Name);
  EXPORT IDX_Person_S_S_N_Social__Build := BUILD(IDX_Person_S_S_N_Social_,OVERWRITE);
  EXPORT __ST2336100_Layout := RECORDOF(IDX_Person_S_S_N_Social_);
  EXPORT IDX_Person_S_S_N_Social__Wrapped := PROJECT(IDX_Person_S_S_N_Social_,TRANSFORM(__ST45469_Layout,SELF.Social_ := __CN(LEFT.Social_),SELF:=LEFT));
  EXPORT BuildAll := PARALLEL(IDX_Person_S_S_N_Social__Build);
END;
