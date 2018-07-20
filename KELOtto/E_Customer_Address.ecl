//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT KELOtto;
IMPORT E_Address,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT E_Customer_Address := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'sourcecustomer(Source_Customer_:0),Location_(Location_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'classification_permissible_use_access.fdn_file_info_id(Source_Customer_:0),Location_(Location_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  EXPORT __d0_KELfiltered := KELOtto.fraudgov((UNSIGNED)classification_permissible_use_access.fdn_file_info_id>0 AND (STRING10)clean_address.prim_range <> '' AND (STRING28)clean_address.prim_name <> '' AND (UNSIGNED3)clean_address.zip <> 0);
  SHARED __d0_Location__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d0_Location__Mapped := JOIN(__d0_KELfiltered,E_Address.Lookup,TRIM((STRING)LEFT.clean_address.prim_range) + '|' + TRIM((STRING)LEFT.clean_address.predir) + '|' + TRIM((STRING)LEFT.clean_address.prim_name) + '|' + TRIM((STRING)LEFT.clean_address.addr_suffix) + '|' + TRIM((STRING)LEFT.clean_address.postdir) + '|' + TRIM((STRING)LEFT.clean_address.zip) + '|' + TRIM((STRING)LEFT.clean_address.sec_range) = RIGHT.KeyVal,TRANSFORM(__d0_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Location__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  EXPORT InData := __d0;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PreResult := PROJECT(TABLE(InData,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_Customer_,Location_},Source_Customer_,Location_,MERGE),Layout);
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KELOtto::Customer_Address::Result',EXPIRE(30));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Source_Customer__Orphan := JOIN(InData(__NN(Source_Customer_)),E_Customer.__Result,__EEQP(LEFT.Source_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Location__Orphan := JOIN(InData(__NN(Location_)),E_Address.__Result,__EEQP(LEFT.Location_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Source_Customer__Orphan),COUNT(Location__Orphan)}],{KEL.typ.int Source_Customer__Orphan,KEL.typ.int Location__Orphan});
  EXPORT NullCounts := DATASET([
    {'CustomerAddress','KELOtto.fraudgov','classification_permissible_use_access.fdn_file_info_id',COUNT(__d0(__NL(Source_Customer_))),COUNT(__d0(__NN(Source_Customer_)))},
    {'CustomerAddress','KELOtto.fraudgov','Location',COUNT(__d0(__NL(Location_))),COUNT(__d0(__NN(Location_)))},
    {'CustomerAddress','KELOtto.fraudgov','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'CustomerAddress','KELOtto.fraudgov','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
