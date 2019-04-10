//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT KELOtto;
IMPORT E_Address,E_Customer,E_Event,E_Internet_Protocol,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT E_Internet_Protocol_Event := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) Ip_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'associatedcustomerfileinfo(_r_Customer_:0),Ip_(Ip_:0),eventdate(Event_Date_:DATE),Transaction_(Transaction_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'associatedcustomerfileinfo(_r_Customer_:0),Ip_(Ip_:0),eventdate(Event_Date_:DATE),Transaction_(Transaction_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  EXPORT __d0_KELfiltered := KELOtto.fraudgovshared((UNSIGNED)did <> 0 AND AssociatedCustomerFileInfo > 0 AND (UNSIGNED)record_id > 0 AND TRIM(ip_address) != '' AND ip_address NOT IN ['0.0.0.0','10.121.146.247','10.121.146.90','10.121.146.15','10.121.146.159','10.121.146.249','10.121.146.34','10.121.146.231','10.121.146.235','10.121.146.232']);
  SHARED __d0_Ip__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Ip_;
  END;
  SHARED __d0_Ip__Mapped := JOIN(__d0_KELfiltered,E_Internet_Protocol.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.ip_address) = RIGHT.KeyVal,TRANSFORM(__d0_Ip__Layout,SELF.Ip_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Transaction__Layout := RECORD
    RECORDOF(__d0_Ip__Mapped);
    KEL.typ.uid Transaction_;
  END;
  SHARED __d0_Transaction__Mapped := JOIN(__d0_Ip__Mapped,E_Event.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.record_id) = RIGHT.KeyVal,TRANSFORM(__d0_Transaction__Layout,SELF.Transaction_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Transaction__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  EXPORT InData := __d0;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) Ip_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PreResult := PROJECT(TABLE(InData,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,Ip_,Event_Date_,Transaction_},_r_Customer_,Ip_,Event_Date_,Transaction_,MERGE),Layout);
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KELOtto::Internet_Protocol_Event::Result',EXPIRE(30));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT _r_Customer__Orphan := JOIN(InData(__NN(_r_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Ip__Orphan := JOIN(InData(__NN(Ip_)),E_Internet_Protocol.__Result,__EEQP(LEFT.Ip_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Transaction__Orphan := JOIN(InData(__NN(Transaction_)),E_Event.__Result,__EEQP(LEFT.Transaction_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(_r_Customer__Orphan),COUNT(Ip__Orphan),COUNT(Transaction__Orphan)}],{KEL.typ.int _r_Customer__Orphan,KEL.typ.int Ip__Orphan,KEL.typ.int Transaction__Orphan});
  EXPORT NullCounts := DATASET([
    {'InternetProtocolEvent','KELOtto.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d0(__NL(_r_Customer_))),COUNT(__d0(__NN(_r_Customer_)))},
    {'InternetProtocolEvent','KELOtto.fraudgovshared','Ip',COUNT(__d0(__NL(Ip_))),COUNT(__d0(__NN(Ip_)))},
    {'InternetProtocolEvent','KELOtto.fraudgovshared','EventDate',COUNT(__d0(__NL(Event_Date_))),COUNT(__d0(__NN(Event_Date_)))},
    {'InternetProtocolEvent','KELOtto.fraudgovshared','Transaction',COUNT(__d0(__NL(Transaction_))),COUNT(__d0(__NN(Transaction_)))},
    {'InternetProtocolEvent','KELOtto.fraudgovshared','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'InternetProtocolEvent','KELOtto.fraudgovshared','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
