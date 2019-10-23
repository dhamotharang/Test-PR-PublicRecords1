//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT KELOtto;
IMPORT E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT E_Customer_Customer := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) Associated_Customer_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'sourcecustomer(Source_Customer_:0),associatedcustomer(Associated_Customer_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'fdn_ind_type_gc_id_inclusion(Source_Customer_:0),fdn_file_info_id(Associated_Customer_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d0_Prefiltered := KELOtto.SharingRules;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  EXPORT InData := __d0;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) Associated_Customer_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PreResult := PROJECT(TABLE(InData,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_Customer_,Associated_Customer_},Source_Customer_,Associated_Customer_,MERGE),Layout);
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KELOtto::Customer_Customer::Result',EXPIRE(30));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Source_Customer__Orphan := JOIN(InData(__NN(Source_Customer_)),E_Customer.__Result,__EEQP(LEFT.Source_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Associated_Customer__Orphan := JOIN(InData(__NN(Associated_Customer_)),E_Customer.__Result,__EEQP(LEFT.Associated_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Source_Customer__Orphan),COUNT(Associated_Customer__Orphan)}],{KEL.typ.int Source_Customer__Orphan,KEL.typ.int Associated_Customer__Orphan});
  EXPORT NullCounts := DATASET([
    {'CustomerCustomer','KELOtto.SharingRules','fdn_ind_type_gc_id_inclusion',COUNT(__d0(__NL(Source_Customer_))),COUNT(__d0(__NN(Source_Customer_)))},
    {'CustomerCustomer','KELOtto.SharingRules','fdn_file_info_id',COUNT(__d0(__NL(Associated_Customer_))),COUNT(__d0(__NN(Associated_Customer_)))},
    {'CustomerCustomer','KELOtto.SharingRules','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'CustomerCustomer','KELOtto.SharingRules','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
