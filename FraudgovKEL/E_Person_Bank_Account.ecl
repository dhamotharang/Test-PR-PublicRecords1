//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT FraudgovKEL;
IMPORT E_Bank,E_Bank_Account,E_Customer,E_Person FROM FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Person_Bank_Account := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'associatedcustomerfileinfo(_r_Customer_:0),Subject_(Subject_:0),Account_(Account_:0),eventdate(Event_Date_:DATE),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'associatedcustomerfileinfo(_r_Customer_:0),Subject_(Subject_:0),Account_(Account_:0),eventdate(Event_Date_:DATE),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  EXPORT __d0_KELfiltered := FraudgovKEL.fraudgovshared((UNSIGNED)did <> 0 AND TRIM(bank_account_number_1) != '');
  SHARED __d0_Subject__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Subject_;
  END;
  SHARED __d0_Subject__Mapped := JOIN(__d0_KELfiltered,E_Person.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d0_Subject__Layout,SELF.Subject_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART);
  SHARED __d0_Account__Layout := RECORD
    RECORDOF(__d0_Subject__Mapped);
    KEL.typ.uid Account_;
  END;
  SHARED __d0_Account__Mapped := JOIN(__d0_Subject__Mapped,E_Bank_Account.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.OttoBankAccountId) = RIGHT.KeyVal,TRANSFORM(__d0_Account__Layout,SELF.Account_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART);
  SHARED __d0_Prefiltered := __d0_Account__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  SHARED __Mapping1 := 'associatedcustomerfileinfo(_r_Customer_:0),Subject_(Subject_:0),Account_(Account_:0),eventdate(Event_Date_:DATE),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  EXPORT __d1_KELfiltered := FraudgovKEL.fraudgovshared((UNSIGNED)did <> 0 AND TRIM(bank_account_number_2) != '');
  SHARED __d1_Subject__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid Subject_;
  END;
  SHARED __d1_Subject__Mapped := JOIN(__d1_KELfiltered,E_Person.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d1_Subject__Layout,SELF.Subject_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART);
  SHARED __d1_Account__Layout := RECORD
    RECORDOF(__d1_Subject__Mapped);
    KEL.typ.uid Account_;
  END;
  SHARED __d1_Account__Mapped := JOIN(__d1_Subject__Mapped,E_Bank_Account.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.OttoBankAccountId2) = RIGHT.KeyVal,TRANSFORM(__d1_Account__Layout,SELF.Account_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART);
  SHARED __d1_Prefiltered := __d1_Account__Mapped;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1));
  EXPORT InData := __d0 + __d1;
  EXPORT Event_Dates_Layout := RECORD
    KEL.typ.nkdate Event_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.ndataset(Event_Dates_Layout) Event_Dates_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,_r_Customer_,Subject_,Account_,ALL));
  Person_Bank_Account_Group := __PostFilter;
  Layout Person_Bank_Account__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Event_Dates_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Event_Date_},Event_Date_),Event_Dates_Layout)(__NN(Event_Date_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Person_Bank_Account__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Event_Dates_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Event_Dates_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Event_Date_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_Bank_Account_Group,COUNT(ROWS(LEFT))=1),GROUP,Person_Bank_Account__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_Bank_Account_Group,COUNT(ROWS(LEFT))>1),GROUP,Person_Bank_Account__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Person_Bank_Account::Result',EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT _r_Customer__Orphan := JOIN(InData(__NN(_r_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person.__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Account__Orphan := JOIN(InData(__NN(Account_)),E_Bank_Account.__Result,__EEQP(LEFT.Account_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(_r_Customer__Orphan),COUNT(Subject__Orphan),COUNT(Account__Orphan)}],{KEL.typ.int _r_Customer__Orphan,KEL.typ.int Subject__Orphan,KEL.typ.int Account__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonBankAccount','FraudgovKEL.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d0(__NL(_r_Customer_))),COUNT(__d0(__NN(_r_Customer_)))},
    {'PersonBankAccount','FraudgovKEL.fraudgovshared','Subject',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'PersonBankAccount','FraudgovKEL.fraudgovshared','Account',COUNT(__d0(__NL(Account_))),COUNT(__d0(__NN(Account_)))},
    {'PersonBankAccount','FraudgovKEL.fraudgovshared','EventDate',COUNT(__d0(__NL(Event_Date_))),COUNT(__d0(__NN(Event_Date_)))},
    {'PersonBankAccount','FraudgovKEL.fraudgovshared','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonBankAccount','FraudgovKEL.fraudgovshared','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'PersonBankAccount','FraudgovKEL.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d1(__NL(_r_Customer_))),COUNT(__d1(__NN(_r_Customer_)))},
    {'PersonBankAccount','FraudgovKEL.fraudgovshared','Subject',COUNT(__d1(__NL(Subject_))),COUNT(__d1(__NN(Subject_)))},
    {'PersonBankAccount','FraudgovKEL.fraudgovshared','Account',COUNT(__d1(__NL(Account_))),COUNT(__d1(__NN(Account_)))},
    {'PersonBankAccount','FraudgovKEL.fraudgovshared','EventDate',COUNT(__d1(__NL(Event_Date_))),COUNT(__d1(__NN(Event_Date_)))},
    {'PersonBankAccount','FraudgovKEL.fraudgovshared','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'PersonBankAccount','FraudgovKEL.fraudgovshared','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
