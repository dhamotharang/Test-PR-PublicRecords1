//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT KELOtto;
IMPORT E_Address,E_Customer,E_Event,E_Person,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT E_Ssn_Event := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) Social_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'associatedcustomerfileinfo(_r_Customer_:0),Social_(Social_:0),eventdate(Event_Date_:DATE),Transaction_(Transaction_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'associatedcustomerfileinfo(_r_Customer_:0),Social_(Social_:0),eventdate(Event_Date_:DATE),Transaction_(Transaction_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  EXPORT __d0_KELfiltered := KELOtto.fraudgovshared((UNSIGNED)SSN <> 0 AND AssociatedCustomerFileInfo > 0 AND (UNSIGNED)record_id > 0);
  SHARED __d0_Social__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Social_;
  END;
  SHARED __d0_Social__Mapped := JOIN(__d0_KELfiltered,E_Social_Security_Number.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.Ssn) = RIGHT.KeyVal,TRANSFORM(__d0_Social__Layout,SELF.Social_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Transaction__Layout := RECORD
    RECORDOF(__d0_Social__Mapped);
    KEL.typ.uid Transaction_;
  END;
  SHARED __d0_Transaction__Mapped := JOIN(__d0_Social__Mapped,E_Event.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.record_id) = RIGHT.KeyVal,TRANSFORM(__d0_Transaction__Layout,SELF.Transaction_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Transaction__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  EXPORT InData := __d0;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) Social_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PreResult := PROJECT(TABLE(InData,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,Social_,Event_Date_,Transaction_},_r_Customer_,Social_,Event_Date_,Transaction_,MERGE),Layout);
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KELOtto::Ssn_Event::Result',EXPIRE(30));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT _r_Customer__Orphan := JOIN(InData(__NN(_r_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Social__Orphan := JOIN(InData(__NN(Social_)),E_Social_Security_Number.__Result,__EEQP(LEFT.Social_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Transaction__Orphan := JOIN(InData(__NN(Transaction_)),E_Event.__Result,__EEQP(LEFT.Transaction_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(_r_Customer__Orphan),COUNT(Social__Orphan),COUNT(Transaction__Orphan)}],{KEL.typ.int _r_Customer__Orphan,KEL.typ.int Social__Orphan,KEL.typ.int Transaction__Orphan});
  EXPORT NullCounts := DATASET([
    {'SsnEvent','KELOtto.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d0(__NL(_r_Customer_))),COUNT(__d0(__NN(_r_Customer_)))},
    {'SsnEvent','KELOtto.fraudgovshared','Social',COUNT(__d0(__NL(Social_))),COUNT(__d0(__NN(Social_)))},
    {'SsnEvent','KELOtto.fraudgovshared','EventDate',COUNT(__d0(__NL(Event_Date_))),COUNT(__d0(__NN(Event_Date_)))},
    {'SsnEvent','KELOtto.fraudgovshared','Transaction',COUNT(__d0(__NL(Transaction_))),COUNT(__d0(__NN(Transaction_)))},
    {'SsnEvent','KELOtto.fraudgovshared','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'SsnEvent','KELOtto.fraudgovshared','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
