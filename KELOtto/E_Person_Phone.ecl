//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT KELOtto;
IMPORT E_Customer,E_Person,E_Phone FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT E_Person_Phone := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'associatedcustomerfileinfo(_r_Customer_:0),Subject_(Subject_:0),Phone_Number_(Phone_Number_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'associatedcustomerfileinfo(_r_Customer_:0),Subject_(Subject_:0),Phone_Number_(Phone_Number_:0),dt_first_seen(Date_First_Seen_:EPOCH),dt_last_seen(Date_Last_Seen_:EPOCH)';
  EXPORT __d0_KELfiltered := KELOtto.fraudgovshared((UNSIGNED)did <> 0 AND clean_phones.cell_phone != '' AND (STRING10)clean_address.prim_range <> '' AND (STRING28)clean_address.prim_name <> '' AND (UNSIGNED3)clean_address.zip <> 0);
  SHARED __d0_Subject__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Subject_;
  END;
  SHARED __d0_Subject__Mapped := JOIN(__d0_KELfiltered,E_Person.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d0_Subject__Layout,SELF.Subject_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Phone_Number__Layout := RECORD
    RECORDOF(__d0_Subject__Mapped);
    KEL.typ.uid Phone_Number_;
  END;
  SHARED __d0_Phone_Number__Mapped := JOIN(__d0_Subject__Mapped,E_Phone.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.clean_phones.cell_phone) = RIGHT.KeyVal,TRANSFORM(__d0_Phone_Number__Layout,SELF.Phone_Number_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Phone_Number__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  SHARED __Mapping1 := 'associatedcustomerfileinfo(_r_Customer_:0),Subject_(Subject_:0),Phone_Number_(Phone_Number_:0),dt_first_seen(Date_First_Seen_:EPOCH),dt_last_seen(Date_Last_Seen_:EPOCH)';
  EXPORT __d1_KELfiltered := KELOtto.fraudgovshared((UNSIGNED)did <> 0 AND clean_phones.phone_number != '' AND (STRING10)clean_address.prim_range <> '' AND (STRING28)clean_address.prim_name <> '' AND (UNSIGNED3)clean_address.zip <> 0);
  SHARED __d1_Subject__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid Subject_;
  END;
  SHARED __d1_Subject__Mapped := JOIN(__d1_KELfiltered,E_Person.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d1_Subject__Layout,SELF.Subject_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d1_Phone_Number__Layout := RECORD
    RECORDOF(__d1_Subject__Mapped);
    KEL.typ.uid Phone_Number_;
  END;
  SHARED __d1_Phone_Number__Mapped := JOIN(__d1_Subject__Mapped,E_Phone.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.clean_phones.phone_number) = RIGHT.KeyVal,TRANSFORM(__d1_Phone_Number__Layout,SELF.Phone_Number_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d1_Prefiltered := __d1_Phone_Number__Mapped;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1));
  EXPORT InData := __d0 + __d1;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PreResult := PROJECT(TABLE(InData,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,Subject_,Phone_Number_},_r_Customer_,Subject_,Phone_Number_,MERGE),Layout);
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KELOtto::Person_Phone::Result',EXPIRE(30));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT _r_Customer__Orphan := JOIN(InData(__NN(_r_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person.__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Phone_Number__Orphan := JOIN(InData(__NN(Phone_Number_)),E_Phone.__Result,__EEQP(LEFT.Phone_Number_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(_r_Customer__Orphan),COUNT(Subject__Orphan),COUNT(Phone_Number__Orphan)}],{KEL.typ.int _r_Customer__Orphan,KEL.typ.int Subject__Orphan,KEL.typ.int Phone_Number__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonPhone','KELOtto.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d0(__NL(_r_Customer_))),COUNT(__d0(__NN(_r_Customer_)))},
    {'PersonPhone','KELOtto.fraudgovshared','Subject',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'PersonPhone','KELOtto.fraudgovshared','PhoneNumber',COUNT(__d0(__NL(Phone_Number_))),COUNT(__d0(__NN(Phone_Number_)))},
    {'PersonPhone','KELOtto.fraudgovshared','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonPhone','KELOtto.fraudgovshared','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'PersonPhone','KELOtto.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d1(__NL(_r_Customer_))),COUNT(__d1(__NN(_r_Customer_)))},
    {'PersonPhone','KELOtto.fraudgovshared','Subject',COUNT(__d1(__NL(Subject_))),COUNT(__d1(__NN(Subject_)))},
    {'PersonPhone','KELOtto.fraudgovshared','PhoneNumber',COUNT(__d1(__NL(Phone_Number_))),COUNT(__d1(__NN(Phone_Number_)))},
    {'PersonPhone','KELOtto.fraudgovshared','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'PersonPhone','KELOtto.fraudgovshared','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
