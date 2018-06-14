//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT KELOtto;
IMPORT E_Person,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT E_Person_S_S_N := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) Social_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'subject(Subject_:0),social(Social_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'did(Subject_:0),ssn(Social_:0),dt_first_seen(Date_First_Seen_:EPOCH),dt_last_seen(Date_Last_Seen_:EPOCH)';
  EXPORT __d0_KELfiltered := KELOtto.fraudgov((UNSIGNED)did<>0 AND (UNSIGNED)ssn<>0);
  SHARED __d0_Prefiltered := __d0_KELfiltered;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  EXPORT InData := __d0;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) Social_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PreResult := PROJECT(TABLE(InData,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Subject_,Social_},Subject_,Social_,MERGE),Layout);
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KELOtto::Person_S_S_N::Result',EXPIRE(30));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person.__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Social__Orphan := JOIN(InData(__NN(Social_)),E_Social_Security_Number.__Result,__EEQP(LEFT.Social_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Subject__Orphan),COUNT(Social__Orphan)}],{KEL.typ.int Subject__Orphan,KEL.typ.int Social__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonSSN','KELOtto.fraudgov','did',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'PersonSSN','KELOtto.fraudgov','ssn',COUNT(__d0(__NL(Social_))),COUNT(__d0(__NN(Social_)))},
    {'PersonSSN','KELOtto.fraudgov','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonSSN','KELOtto.fraudgov','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
