//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT KELOtto;
IMPORT E_Bank,E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT E_Bank_Account := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Source_Customer_;
    KEL.typ.ntyp(E_Bank.Typ) _r_Bank_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nint Otto_Bank_Account_Id_;
    KEL.typ.nstr Hri_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),_r_Bank_(_r_Bank_:0),accountnumber(Account_Number_:\'\'),ottobankaccountid(Otto_Bank_Account_Id_:0),hri(Hri_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := KELOtto.fraudgovshared((UNSIGNED)did <> 0 AND TRIM(bank_account_number_1) != '');
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.bank_routing_number_1) + '|' + TRIM((STRING)LEFT.bank_account_number_1)));
  SHARED __d1_KELfiltered := KELOtto.fraudgovshared((UNSIGNED)did <> 0 AND TRIM(bank_account_number_2) != '');
  SHARED __d1_Trim := PROJECT(__d1_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.bank_routing_number_2) + '|' + TRIM((STRING)LEFT.bank_account_number_2)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'') + '|' + TRIM((STRING)'') + '|' + TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::KELOtto::Bank_Account::UidLookup',EXPIRE(30));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::KELOtto::Bank_Account');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::KELOtto::Bank_Account');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED __Mapping0 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),_r_Bank_(_r_Bank_:0),bank_account_number_1(Account_Number_:\'\'),ottobankaccountid(Otto_Bank_Account_Id_:0),hri(Hri_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d0_Out := RECORD
    RECORDOF(KELOtto.fraudgovshared);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.bank_routing_number_1) + '|' + TRIM((STRING)LEFT.bank_account_number_1) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  SHARED __d0__r_Bank__Layout := RECORD
    RECORDOF(__d0_UID_Mapped);
    KEL.typ.uid _r_Bank_;
  END;
  SHARED __d0__r_Bank__Mapped := JOIN(__d0_UID_Mapped,E_Bank.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.bank_routing_number_1) = RIGHT.KeyVal,TRANSFORM(__d0__r_Bank__Layout,SELF._r_Bank_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  EXPORT KELOtto_fraudgovshared_1_Invalid := __d0__r_Bank__Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0__r_Bank__Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  SHARED __Mapping1 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),_r_Bank_(_r_Bank_:0),bank_account_number_2(Account_Number_:\'\'),ottobankaccountid2(Otto_Bank_Account_Id_:0),hri(Hri_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d1_Out := RECORD
    RECORDOF(KELOtto.fraudgovshared);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_KELfiltered,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.bank_routing_number_2) + '|' + TRIM((STRING)LEFT.bank_account_number_2) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  SHARED __d1__r_Bank__Layout := RECORD
    RECORDOF(__d1_UID_Mapped);
    KEL.typ.uid _r_Bank_;
  END;
  SHARED __d1__r_Bank__Mapped := JOIN(__d1_UID_Mapped,E_Bank.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.bank_routing_number_2) = RIGHT.KeyVal,TRANSFORM(__d1__r_Bank__Layout,SELF._r_Bank_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  EXPORT KELOtto_fraudgovshared_2_Invalid := __d1__r_Bank__Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1__r_Bank__Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1));
  EXPORT InData := __d0 + __d1;
  EXPORT Source_Customers_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Source_Customer_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Hri_List_Layout := RECORD
    KEL.typ.nstr Hri_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ndataset(Source_Customers_Layout) Source_Customers_;
    KEL.typ.ntyp(E_Bank.Typ) _r_Bank_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nint Otto_Bank_Account_Id_;
    KEL.typ.ndataset(Hri_List_Layout) Hri_List_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Bank_Account_Group := __PostFilter;
  Layout Bank_Account__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF._r_Customer_ := KEL.Intake.SingleValue(__recs,_r_Customer_);
    SELF.Source_Customers_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Source_Customer_},_r_Source_Customer_),Source_Customers_Layout)(__NN(_r_Source_Customer_)));
    SELF._r_Bank_ := KEL.Intake.SingleValue(__recs,_r_Bank_);
    SELF.Account_Number_ := KEL.Intake.SingleValue(__recs,Account_Number_);
    SELF.Otto_Bank_Account_Id_ := KEL.Intake.SingleValue(__recs,Otto_Bank_Account_Id_);
    SELF.Hri_List_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Hri_},Hri_),Hri_List_Layout)(__NN(Hri_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Bank_Account__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Source_Customers_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Source_Customers_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(_r_Source_Customer_)));
    SELF.Hri_List_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Hri_List_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Hri_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Bank_Account_Group,COUNT(ROWS(LEFT))=1),GROUP,Bank_Account__Single_Rollup(LEFT)) + ROLLUP(HAVING(Bank_Account_Group,COUNT(ROWS(LEFT))>1),GROUP,Bank_Account__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KELOtto::Bank_Account::Result',EXPIRE(30));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT _r_Customer__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_r_Customer_);
  EXPORT _r_Bank__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_r_Bank_);
  EXPORT Account_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Account_Number_);
  EXPORT Otto_Bank_Account_Id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Otto_Bank_Account_Id_);
  EXPORT _r_Customer__Orphan := JOIN(InData(__NN(_r_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT _r_Source_Customer__Orphan := JOIN(InData(__NN(_r_Source_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Source_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT _r_Bank__Orphan := JOIN(InData(__NN(_r_Bank_)),E_Bank.__Result,__EEQP(LEFT._r_Bank_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(_r_Customer__Orphan),COUNT(_r_Source_Customer__Orphan),COUNT(_r_Bank__Orphan),COUNT(KELOtto_fraudgovshared_1_Invalid),COUNT(KELOtto_fraudgovshared_2_Invalid),COUNT(_r_Customer__SingleValue_Invalid),COUNT(_r_Bank__SingleValue_Invalid),COUNT(Account_Number__SingleValue_Invalid),COUNT(Otto_Bank_Account_Id__SingleValue_Invalid)}],{KEL.typ.int _r_Customer__Orphan,KEL.typ.int _r_Source_Customer__Orphan,KEL.typ.int _r_Bank__Orphan,KEL.typ.int KELOtto_fraudgovshared_1_Invalid,KEL.typ.int KELOtto_fraudgovshared_2_Invalid,KEL.typ.int _r_Customer__SingleValue_Invalid,KEL.typ.int _r_Bank__SingleValue_Invalid,KEL.typ.int Account_Number__SingleValue_Invalid,KEL.typ.int Otto_Bank_Account_Id__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'BankAccount','KELOtto.fraudgovshared','UID',COUNT(KELOtto_fraudgovshared_1_Invalid),COUNT(__d0)},
    {'BankAccount','KELOtto.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d0(__NL(_r_Customer_))),COUNT(__d0(__NN(_r_Customer_)))},
    {'BankAccount','KELOtto.fraudgovshared','SourceCustomerFileInfo',COUNT(__d0(__NL(_r_Source_Customer_))),COUNT(__d0(__NN(_r_Source_Customer_)))},
    {'BankAccount','KELOtto.fraudgovshared','rBank',COUNT(__d0(__NL(_r_Bank_))),COUNT(__d0(__NN(_r_Bank_)))},
    {'BankAccount','KELOtto.fraudgovshared','bank_account_number_1',COUNT(__d0(__NL(Account_Number_))),COUNT(__d0(__NN(Account_Number_)))},
    {'BankAccount','KELOtto.fraudgovshared','OttoBankAccountId',COUNT(__d0(__NL(Otto_Bank_Account_Id_))),COUNT(__d0(__NN(Otto_Bank_Account_Id_)))},
    {'BankAccount','KELOtto.fraudgovshared','Hri',COUNT(__d0(__NL(Hri_))),COUNT(__d0(__NN(Hri_)))},
    {'BankAccount','KELOtto.fraudgovshared','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'BankAccount','KELOtto.fraudgovshared','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'BankAccount','KELOtto.fraudgovshared','UID',COUNT(KELOtto_fraudgovshared_2_Invalid),COUNT(__d1)},
    {'BankAccount','KELOtto.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d1(__NL(_r_Customer_))),COUNT(__d1(__NN(_r_Customer_)))},
    {'BankAccount','KELOtto.fraudgovshared','SourceCustomerFileInfo',COUNT(__d1(__NL(_r_Source_Customer_))),COUNT(__d1(__NN(_r_Source_Customer_)))},
    {'BankAccount','KELOtto.fraudgovshared','rBank',COUNT(__d1(__NL(_r_Bank_))),COUNT(__d1(__NN(_r_Bank_)))},
    {'BankAccount','KELOtto.fraudgovshared','bank_account_number_2',COUNT(__d1(__NL(Account_Number_))),COUNT(__d1(__NN(Account_Number_)))},
    {'BankAccount','KELOtto.fraudgovshared','OttoBankAccountId2',COUNT(__d1(__NL(Otto_Bank_Account_Id_))),COUNT(__d1(__NN(Otto_Bank_Account_Id_)))},
    {'BankAccount','KELOtto.fraudgovshared','Hri',COUNT(__d1(__NL(Hri_))),COUNT(__d1(__NN(Hri_)))},
    {'BankAccount','KELOtto.fraudgovshared','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'BankAccount','KELOtto.fraudgovshared','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
