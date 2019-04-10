//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT KELOtto;
IMPORT E_Address,E_Bank,E_Bank_Account,E_Customer,E_Event,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT E_Bank_Account_Event := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'associatedcustomerfileinfo(_r_Customer_:0),Account_(Account_:0),eventdate(Event_Date_:DATE),Transaction_(Transaction_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'associatedcustomerfileinfo(_r_Customer_:0),Account_(Account_:0),eventdate(Event_Date_:DATE),Transaction_(Transaction_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  EXPORT __d0_KELfiltered := KELOtto.fraudgovshared((UNSIGNED)did <> 0 AND AssociatedCustomerFileInfo > 0 AND (UNSIGNED)record_id > 0 AND bank_account_number_1 != '');
  SHARED __d0_Account__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Account_;
  END;
  SHARED __d0_Account__Mapped := JOIN(__d0_KELfiltered,E_Bank_Account.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.bank_routing_number_1) + '|' + TRIM((STRING)LEFT.bank_account_number_1) = RIGHT.KeyVal,TRANSFORM(__d0_Account__Layout,SELF.Account_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Transaction__Layout := RECORD
    RECORDOF(__d0_Account__Mapped);
    KEL.typ.uid Transaction_;
  END;
  SHARED __d0_Transaction__Mapped := JOIN(__d0_Account__Mapped,E_Event.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.record_id) = RIGHT.KeyVal,TRANSFORM(__d0_Transaction__Layout,SELF.Transaction_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Transaction__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  SHARED __Mapping1 := 'associatedcustomerfileinfo(_r_Customer_:0),Account_(Account_:0),eventdate(Event_Date_:DATE),Transaction_(Transaction_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  EXPORT __d1_KELfiltered := KELOtto.fraudgovshared((UNSIGNED)did <> 0 AND AssociatedCustomerFileInfo > 0 AND (UNSIGNED)record_id > 0 AND bank_account_number_2 != '');
  SHARED __d1_Account__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid Account_;
  END;
  SHARED __d1_Account__Mapped := JOIN(__d1_KELfiltered,E_Bank_Account.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.bank_routing_number_2) + '|' + TRIM((STRING)LEFT.bank_account_number_2) = RIGHT.KeyVal,TRANSFORM(__d1_Account__Layout,SELF.Account_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d1_Transaction__Layout := RECORD
    RECORDOF(__d1_Account__Mapped);
    KEL.typ.uid Transaction_;
  END;
  SHARED __d1_Transaction__Mapped := JOIN(__d1_Account__Mapped,E_Event.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.record_id) = RIGHT.KeyVal,TRANSFORM(__d1_Transaction__Layout,SELF.Transaction_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d1_Prefiltered := __d1_Transaction__Mapped;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1));
  EXPORT InData := __d0 + __d1;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PreResult := PROJECT(TABLE(InData,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,Account_,Event_Date_,Transaction_},_r_Customer_,Account_,Event_Date_,Transaction_,MERGE),Layout);
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KELOtto::Bank_Account_Event::Result',EXPIRE(30));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT _r_Customer__Orphan := JOIN(InData(__NN(_r_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Account__Orphan := JOIN(InData(__NN(Account_)),E_Bank_Account.__Result,__EEQP(LEFT.Account_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Transaction__Orphan := JOIN(InData(__NN(Transaction_)),E_Event.__Result,__EEQP(LEFT.Transaction_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(_r_Customer__Orphan),COUNT(Account__Orphan),COUNT(Transaction__Orphan)}],{KEL.typ.int _r_Customer__Orphan,KEL.typ.int Account__Orphan,KEL.typ.int Transaction__Orphan});
  EXPORT NullCounts := DATASET([
    {'BankAccountEvent','KELOtto.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d0(__NL(_r_Customer_))),COUNT(__d0(__NN(_r_Customer_)))},
    {'BankAccountEvent','KELOtto.fraudgovshared','Account',COUNT(__d0(__NL(Account_))),COUNT(__d0(__NN(Account_)))},
    {'BankAccountEvent','KELOtto.fraudgovshared','EventDate',COUNT(__d0(__NL(Event_Date_))),COUNT(__d0(__NN(Event_Date_)))},
    {'BankAccountEvent','KELOtto.fraudgovshared','Transaction',COUNT(__d0(__NL(Transaction_))),COUNT(__d0(__NN(Transaction_)))},
    {'BankAccountEvent','KELOtto.fraudgovshared','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'BankAccountEvent','KELOtto.fraudgovshared','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'BankAccountEvent','KELOtto.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d1(__NL(_r_Customer_))),COUNT(__d1(__NN(_r_Customer_)))},
    {'BankAccountEvent','KELOtto.fraudgovshared','Account',COUNT(__d1(__NL(Account_))),COUNT(__d1(__NN(Account_)))},
    {'BankAccountEvent','KELOtto.fraudgovshared','EventDate',COUNT(__d1(__NL(Event_Date_))),COUNT(__d1(__NN(Event_Date_)))},
    {'BankAccountEvent','KELOtto.fraudgovshared','Transaction',COUNT(__d1(__NL(Transaction_))),COUNT(__d1(__NN(Transaction_)))},
    {'BankAccountEvent','KELOtto.fraudgovshared','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'BankAccountEvent','KELOtto.fraudgovshared','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
