//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT FraudgovKEL;
IMPORT E_Customer,E_Email,E_Person FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Person_Email := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'associatedcustomerfileinfo(_r_Customer_:0),Subject_(Subject_:0),Emailof_(Emailof_:0),eventdate(Event_Date_:DATE),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'associatedcustomerfileinfo(_r_Customer_:0),Subject_(Subject_:0),Emailof_(Emailof_:0),event_date(Event_Date_:DATE),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  EXPORT __d0_KELfiltered := FraudgovKEL.fraudgovshared((UNSIGNED)did <> 0 AND (STRING50)email_address <> '' AND AssociatedCustomerFileInfo > 0);
  SHARED __d0_Subject__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Subject_;
  END;
  SHARED __d0_Subject__Mapped := JOIN(__d0_KELfiltered,E_Person.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d0_Subject__Layout,SELF.Subject_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART);
  SHARED __d0_Emailof__Layout := RECORD
    RECORDOF(__d0_Subject__Mapped);
    KEL.typ.uid Emailof_;
  END;
  SHARED __d0_Emailof__Mapped := JOIN(__d0_Subject__Mapped,E_Email.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.OttoEmailId) = RIGHT.KeyVal,TRANSFORM(__d0_Emailof__Layout,SELF.Emailof_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART);
  SHARED __d0_Prefiltered := __d0_Emailof__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  EXPORT InData := __d0;
  EXPORT Event_Dates_Layout := RECORD
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.ndataset(Event_Dates_Layout) Event_Dates_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,_r_Customer_,Subject_,Emailof_,ALL));
  Person_Email_Group := __PostFilter;
  Layout Person_Email__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Event_Dates_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Event_Date_},Event_Date_),Event_Dates_Layout)(__NN(Event_Date_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Person_Email__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Event_Dates_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Event_Dates_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Event_Date_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_Email_Group,COUNT(ROWS(LEFT))=1),GROUP,Person_Email__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_Email_Group,COUNT(ROWS(LEFT))>1),GROUP,Person_Email__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Person_Email::Result',EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT _r_Customer__Orphan := JOIN(InData(__NN(_r_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person.__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Emailof__Orphan := JOIN(InData(__NN(Emailof_)),E_Email.__Result,__EEQP(LEFT.Emailof_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(_r_Customer__Orphan),COUNT(Subject__Orphan),COUNT(Emailof__Orphan)}],{KEL.typ.int _r_Customer__Orphan,KEL.typ.int Subject__Orphan,KEL.typ.int Emailof__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonEmail','FraudgovKEL.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d0(__NL(_r_Customer_))),COUNT(__d0(__NN(_r_Customer_)))},
    {'PersonEmail','FraudgovKEL.fraudgovshared','Subject',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'PersonEmail','FraudgovKEL.fraudgovshared','Emailof',COUNT(__d0(__NL(Emailof_))),COUNT(__d0(__NN(Emailof_)))},
    {'PersonEmail','FraudgovKEL.fraudgovshared','event_date',COUNT(__d0(__NL(Event_Date_))),COUNT(__d0(__NN(Event_Date_)))},
    {'PersonEmail','FraudgovKEL.fraudgovshared','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonEmail','FraudgovKEL.fraudgovshared','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
