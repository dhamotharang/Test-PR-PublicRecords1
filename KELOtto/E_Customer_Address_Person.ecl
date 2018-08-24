﻿//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT KELOtto;
IMPORT E_Address,E_Customer,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT E_Customer_Address_Person := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) Associated_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nint Event_Count_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'sourcecustomer(Source_Customer_:0),associatedcustomer(Associated_Customer_:0),subject(Subject_:0),Location_(Location_:0),eventcount(Event_Count_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'sourcecustomerfileinfo(Source_Customer_:0),associatedcustomerfileinfo(Associated_Customer_:0),did(Subject_:0),Location_(Location_:0),eventcount(Event_Count_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  EXPORT __d0_KELfiltered := KELOtto.CustomerAddressPerson((UNSIGNED)did > 0 AND (UNSIGNED)SourceCustomerFileInfo>0 AND (STRING10)prim_range <> '' AND (STRING28)prim_name <> '' AND (UNSIGNED3)zip <> 0);
  SHARED __d0_Location__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Location_;
  END;
  SHARED __d0_Location__Mapped := JOIN(__d0_KELfiltered,E_Address.Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d0_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Location__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  EXPORT InData := __d0;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) Source_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) Associated_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nint Event_Count_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PreResult := PROJECT(TABLE(InData,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_Customer_,Associated_Customer_,Subject_,Location_,Event_Count_},Source_Customer_,Associated_Customer_,Subject_,Location_,Event_Count_,MERGE),Layout);
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KELOtto::Customer_Address_Person::Result',EXPIRE(30));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Source_Customer__Orphan := JOIN(InData(__NN(Source_Customer_)),E_Customer.__Result,__EEQP(LEFT.Source_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Associated_Customer__Orphan := JOIN(InData(__NN(Associated_Customer_)),E_Customer.__Result,__EEQP(LEFT.Associated_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person.__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Location__Orphan := JOIN(InData(__NN(Location_)),E_Address.__Result,__EEQP(LEFT.Location_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Source_Customer__Orphan),COUNT(Associated_Customer__Orphan),COUNT(Subject__Orphan),COUNT(Location__Orphan)}],{KEL.typ.int Source_Customer__Orphan,KEL.typ.int Associated_Customer__Orphan,KEL.typ.int Subject__Orphan,KEL.typ.int Location__Orphan});
  EXPORT NullCounts := DATASET([
    {'CustomerAddressPerson','KELOtto.CustomerAddressPerson','SourceCustomerFileInfo',COUNT(__d0(__NL(Source_Customer_))),COUNT(__d0(__NN(Source_Customer_)))},
    {'CustomerAddressPerson','KELOtto.CustomerAddressPerson','AssociatedCustomerFileInfo',COUNT(__d0(__NL(Associated_Customer_))),COUNT(__d0(__NN(Associated_Customer_)))},
    {'CustomerAddressPerson','KELOtto.CustomerAddressPerson','did',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'CustomerAddressPerson','KELOtto.CustomerAddressPerson','Location',COUNT(__d0(__NL(Location_))),COUNT(__d0(__NN(Location_)))},
    {'CustomerAddressPerson','KELOtto.CustomerAddressPerson','EventCount',COUNT(__d0(__NL(Event_Count_))),COUNT(__d0(__NN(Event_Count_)))},
    {'CustomerAddressPerson','KELOtto.CustomerAddressPerson','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'CustomerAddressPerson','KELOtto.CustomerAddressPerson','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
