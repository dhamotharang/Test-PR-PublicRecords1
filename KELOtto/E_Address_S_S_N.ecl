//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT KELOtto;
IMPORT E_Address,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT E_Address_S_S_N := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) Social_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'Location_(Location_:0),social(Social_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'Location_(Location_:0),ssn(Social_:0),dt_first_seen(Date_First_Seen_:EPOCH),dt_last_seen(Date_Last_Seen_:EPOCH)';
  EXPORT __d0_KELfiltered := KELOtto.fraudgov((STRING10)clean_address.prim_range <> '' AND (STRING28)clean_address.prim_name <> '' AND (UNSIGNED3)clean_address.zip <> 0 AND (UNSIGNED)ssn <>0);
  SHARED __d0_Location__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d0_Location__Mapped := JOIN(__d0_KELfiltered,E_Address.Lookup,TRIM((STRING)LEFT.clean_address.prim_range) + '|' + TRIM((STRING)LEFT.clean_address.predir) + '|' + TRIM((STRING)LEFT.clean_address.prim_name) + '|' + TRIM((STRING)LEFT.clean_address.addr_suffix) + '|' + TRIM((STRING)LEFT.clean_address.postdir) + '|' + TRIM((STRING)LEFT.clean_address.zip) + '|' + TRIM((STRING)LEFT.clean_address.sec_range) = RIGHT.KeyVal,TRANSFORM(__d0_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Location__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  EXPORT InData := __d0;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) Social_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PreResult := PROJECT(TABLE(InData,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Location_,Social_},Location_,Social_,MERGE),Layout);
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KELOtto::Address_S_S_N::Result',EXPIRE(30));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Location__Orphan := JOIN(InData(__NN(Location_)),E_Address.__Result,__EEQP(LEFT.Location_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Social__Orphan := JOIN(InData(__NN(Social_)),E_Social_Security_Number.__Result,__EEQP(LEFT.Social_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Location__Orphan),COUNT(Social__Orphan)}],{KEL.typ.int Location__Orphan,KEL.typ.int Social__Orphan});
  EXPORT NullCounts := DATASET([
    {'AddressSSN','KELOtto.fraudgov','Location',COUNT(__d0(__NL(Location_))),COUNT(__d0(__NN(Location_)))},
    {'AddressSSN','KELOtto.fraudgov','ssn',COUNT(__d0(__NL(Social_))),COUNT(__d0(__NN(Social_)))},
    {'AddressSSN','KELOtto.fraudgov','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'AddressSSN','KELOtto.fraudgov','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
