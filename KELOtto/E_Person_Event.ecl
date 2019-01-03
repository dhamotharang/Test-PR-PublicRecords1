//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT KELOtto;
IMPORT E_Address,E_Bank,E_Bank_Account,E_Customer,E_Drivers_License,E_Email,E_Event,E_Internet_Protocol,E_Person,E_Phone,E_Social_Security_Number FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT E_Person_Event := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) Social_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) Ip_;
    KEL.typ.ntyp(E_Bank.Typ) Routing_Bank_;
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.ntyp(E_Drivers_License.Typ) Licence_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'associatedcustomerfileinfo(_r_Customer_:0),Subject_(Subject_:0),Social_(Social_:0),Phone_Number_(Phone_Number_:0),Emailof_(Emailof_:0),Location_(Location_:0),Ip_(Ip_:0),Routing_Bank_(Routing_Bank_:0),Account_(Account_:0),Licence_(Licence_:0),eventdate(Event_Date_:DATE),Transaction_(Transaction_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'associatedcustomerfileinfo(_r_Customer_:0),Subject_(Subject_:0),Social_(Social_:0),Phone_Number_(Phone_Number_:0),Emailof_(Emailof_:0),Location_(Location_:0),Ip_(Ip_:0),Routing_Bank_(Routing_Bank_:0),Account_(Account_:0),Licence_(Licence_:0),event_date(Event_Date_:DATE),Transaction_(Transaction_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  EXPORT __d0_KELfiltered := KELOtto.fraudgovshared((UNSIGNED)did <> 0 AND AssociatedCustomerFileInfo > 0 AND (UNSIGNED)record_id > 0);
  SHARED __d0_Subject__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Subject_;
  END;
  SHARED __d0_Subject__Mapped := JOIN(__d0_KELfiltered,E_Person.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d0_Subject__Layout,SELF.Subject_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Social__Layout := RECORD
    RECORDOF(__d0_Subject__Mapped);
    KEL.typ.uid Social_;
  END;
  SHARED __d0_Social__Mapped := JOIN(__d0_Subject__Mapped,E_Social_Security_Number.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.Ssn) = RIGHT.KeyVal,TRANSFORM(__d0_Social__Layout,SELF.Social_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,LOOKUP);
  SHARED __d0_Phone_Number__Layout := RECORD
    RECORDOF(__d0_Social__Mapped);
    KEL.typ.uid Phone_Number_;
  END;
  SHARED __d0_Phone_Number__Mapped := JOIN(__d0_Social__Mapped,E_Phone.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.clean_phones.cell_phone) = RIGHT.KeyVal,TRANSFORM(__d0_Phone_Number__Layout,SELF.Phone_Number_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,LOOKUP);
  SHARED __d0_Emailof__Layout := RECORD
    RECORDOF(__d0_Phone_Number__Mapped);
    KEL.typ.uid Emailof_;
  END;
  SHARED __d0_Emailof__Mapped := JOIN(__d0_Phone_Number__Mapped,E_Email.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.Email_Address) = RIGHT.KeyVal,TRANSFORM(__d0_Emailof__Layout,SELF.Emailof_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,LOOKUP);
  SHARED __d0_Location__Layout := RECORD
    RECORDOF(__d0_Emailof__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d0_Location__Mapped := JOIN(__d0_Emailof__Mapped,E_Address.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.clean_address.prim_range) + '|' + TRIM((STRING)LEFT.clean_address.predir) + '|' + TRIM((STRING)LEFT.clean_address.prim_name) + '|' + TRIM((STRING)LEFT.clean_address.addr_suffix) + '|' + TRIM((STRING)LEFT.clean_address.postdir) + '|' + TRIM((STRING)LEFT.clean_address.zip) + '|' + TRIM((STRING)LEFT.clean_address.sec_range) = RIGHT.KeyVal,TRANSFORM(__d0_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,LOOKUP);
  SHARED __d0_Ip__Layout := RECORD
    RECORDOF(__d0_Location__Mapped);
    KEL.typ.uid Ip_;
  END;
  SHARED __d0_Ip__Mapped := JOIN(__d0_Location__Mapped,E_Internet_Protocol.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.ip_address) = RIGHT.KeyVal,TRANSFORM(__d0_Ip__Layout,SELF.Ip_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,LOOKUP);
  SHARED __d0_Routing_Bank__Layout := RECORD
    RECORDOF(__d0_Ip__Mapped);
    KEL.typ.uid Routing_Bank_;
  END;
  SHARED __d0_Routing_Bank__Mapped := JOIN(__d0_Ip__Mapped,E_Bank.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.bank_routing_number_1) = RIGHT.KeyVal,TRANSFORM(__d0_Routing_Bank__Layout,SELF.Routing_Bank_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,LOOKUP);
  SHARED __d0_Account__Layout := RECORD
    RECORDOF(__d0_Routing_Bank__Mapped);
    KEL.typ.uid Account_;
  END;
  SHARED __d0_Account__Mapped := JOIN(__d0_Routing_Bank__Mapped,E_Bank_Account.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.bank_routing_number_1) + '|' + TRIM((STRING)LEFT.bank_account_number_1) = RIGHT.KeyVal,TRANSFORM(__d0_Account__Layout,SELF.Account_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,LOOKUP);
  SHARED __d0_Licence__Layout := RECORD
    RECORDOF(__d0_Account__Mapped);
    KEL.typ.uid Licence_;
  END;
  SHARED __d0_Licence__Mapped := JOIN(__d0_Account__Mapped,E_Drivers_License.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.drivers_license) = RIGHT.KeyVal,TRANSFORM(__d0_Licence__Layout,SELF.Licence_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,LOOKUP);
  SHARED __d0_Transaction__Layout := RECORD
    RECORDOF(__d0_Licence__Mapped);
    KEL.typ.uid Transaction_;
  END;
  SHARED __d0_Transaction__Mapped := JOIN(__d0_Licence__Mapped,E_Event.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.record_id) = RIGHT.KeyVal,TRANSFORM(__d0_Transaction__Layout,SELF.Transaction_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Transaction__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  SHARED __Mapping1 := 'associatedcustomerfileinfo(_r_Customer_:0),Subject_(Subject_:0),Social_(Social_:0),Phone_Number_(Phone_Number_:0),Emailof_(Emailof_:0),Location_(Location_:0),Ip_(Ip_:0),Routing_Bank_(Routing_Bank_:0),Account_(Account_:0),Licence_(Licence_:0),event_date(Event_Date_:DATE),Transaction_(Transaction_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  EXPORT __d1_KELfiltered := KELOtto.fraudgovshared((UNSIGNED)did <> 0 AND AssociatedCustomerFileInfo > 0 AND (UNSIGNED)record_id > 0);
  SHARED __d1_Subject__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid Subject_;
  END;
  SHARED __d1_Subject__Mapped := JOIN(__d1_KELfiltered,E_Person.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d1_Subject__Layout,SELF.Subject_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d1_Social__Layout := RECORD
    RECORDOF(__d1_Subject__Mapped);
    KEL.typ.uid Social_;
  END;
  SHARED __d1_Social__Mapped := JOIN(__d1_Subject__Mapped,E_Social_Security_Number.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.Ssn) = RIGHT.KeyVal,TRANSFORM(__d1_Social__Layout,SELF.Social_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d1_Phone_Number__Layout := RECORD
    RECORDOF(__d1_Social__Mapped);
    KEL.typ.uid Phone_Number_;
  END;
  SHARED __d1_Phone_Number__Mapped := JOIN(__d1_Social__Mapped,E_Phone.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.clean_phones.phone_number) = RIGHT.KeyVal,TRANSFORM(__d1_Phone_Number__Layout,SELF.Phone_Number_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,LOOKUP);
  SHARED __d1_Emailof__Layout := RECORD
    RECORDOF(__d1_Phone_Number__Mapped);
    KEL.typ.uid Emailof_;
  END;
  SHARED __d1_Emailof__Mapped := JOIN(__d1_Phone_Number__Mapped,E_Email.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.Email_Address) = RIGHT.KeyVal,TRANSFORM(__d1_Emailof__Layout,SELF.Emailof_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,LOOKUP);
  SHARED __d1_Location__Layout := RECORD
    RECORDOF(__d1_Emailof__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d1_Location__Mapped := JOIN(__d1_Emailof__Mapped,E_Address.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.clean_address.prim_range) + '|' + TRIM((STRING)LEFT.clean_address.predir) + '|' + TRIM((STRING)LEFT.clean_address.prim_name) + '|' + TRIM((STRING)LEFT.clean_address.addr_suffix) + '|' + TRIM((STRING)LEFT.clean_address.postdir) + '|' + TRIM((STRING)LEFT.clean_address.zip) + '|' + TRIM((STRING)LEFT.clean_address.sec_range) = RIGHT.KeyVal,TRANSFORM(__d1_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d1_Ip__Layout := RECORD
    RECORDOF(__d1_Location__Mapped);
    KEL.typ.uid Ip_;
  END;
  SHARED __d1_Ip__Mapped := JOIN(__d1_Location__Mapped,E_Internet_Protocol.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.ip_address) = RIGHT.KeyVal,TRANSFORM(__d1_Ip__Layout,SELF.Ip_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,LOOKUP);
  SHARED __d1_Routing_Bank__Layout := RECORD
    RECORDOF(__d1_Ip__Mapped);
    KEL.typ.uid Routing_Bank_;
  END;
  SHARED __d1_Routing_Bank__Mapped := JOIN(__d1_Ip__Mapped,E_Bank.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.bank_routing_number_1) = RIGHT.KeyVal,TRANSFORM(__d1_Routing_Bank__Layout,SELF.Routing_Bank_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,LOOKUP);
  SHARED __d1_Account__Layout := RECORD
    RECORDOF(__d1_Routing_Bank__Mapped);
    KEL.typ.uid Account_;
  END;
  SHARED __d1_Account__Mapped := JOIN(__d1_Routing_Bank__Mapped,E_Bank_Account.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.bank_routing_number_1) + '|' + TRIM((STRING)LEFT.bank_account_number_1) = RIGHT.KeyVal,TRANSFORM(__d1_Account__Layout,SELF.Account_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,LOOKUP);
  SHARED __d1_Licence__Layout := RECORD
    RECORDOF(__d1_Account__Mapped);
    KEL.typ.uid Licence_;
  END;
  SHARED __d1_Licence__Mapped := JOIN(__d1_Account__Mapped,E_Drivers_License.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.drivers_license) = RIGHT.KeyVal,TRANSFORM(__d1_Licence__Layout,SELF.Licence_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,LOOKUP);
  SHARED __d1_Transaction__Layout := RECORD
    RECORDOF(__d1_Licence__Mapped);
    KEL.typ.uid Transaction_;
  END;
  SHARED __d1_Transaction__Mapped := JOIN(__d1_Licence__Mapped,E_Event.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.record_id) = RIGHT.KeyVal,TRANSFORM(__d1_Transaction__Layout,SELF.Transaction_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d1_Prefiltered := __d1_Transaction__Mapped;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1));
  EXPORT InData := __d0 + __d1;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number.Typ) Social_;
    KEL.typ.ntyp(E_Phone.Typ) Phone_Number_;
    KEL.typ.ntyp(E_Email.Typ) Emailof_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.ntyp(E_Internet_Protocol.Typ) Ip_;
    KEL.typ.ntyp(E_Bank.Typ) Routing_Bank_;
    KEL.typ.ntyp(E_Bank_Account.Typ) Account_;
    KEL.typ.ntyp(E_Drivers_License.Typ) Licence_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ntyp(E_Event.Typ) Transaction_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PreResult := PROJECT(TABLE(InData,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,Subject_,Social_,Phone_Number_,Emailof_,Location_,Ip_,Routing_Bank_,Account_,Licence_,Event_Date_,Transaction_},_r_Customer_,Subject_,Social_,Phone_Number_,Emailof_,Location_,Ip_,Routing_Bank_,Account_,Licence_,Event_Date_,Transaction_,MERGE),Layout);
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KELOtto::Person_Event::Result',EXPIRE(30));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT _r_Customer__Orphan := JOIN(InData(__NN(_r_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person.__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Social__Orphan := JOIN(InData(__NN(Social_)),E_Social_Security_Number.__Result,__EEQP(LEFT.Social_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Phone_Number__Orphan := JOIN(InData(__NN(Phone_Number_)),E_Phone.__Result,__EEQP(LEFT.Phone_Number_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Emailof__Orphan := JOIN(InData(__NN(Emailof_)),E_Email.__Result,__EEQP(LEFT.Emailof_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Location__Orphan := JOIN(InData(__NN(Location_)),E_Address.__Result,__EEQP(LEFT.Location_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Ip__Orphan := JOIN(InData(__NN(Ip_)),E_Internet_Protocol.__Result,__EEQP(LEFT.Ip_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Routing_Bank__Orphan := JOIN(InData(__NN(Routing_Bank_)),E_Bank.__Result,__EEQP(LEFT.Routing_Bank_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Account__Orphan := JOIN(InData(__NN(Account_)),E_Bank_Account.__Result,__EEQP(LEFT.Account_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Licence__Orphan := JOIN(InData(__NN(Licence_)),E_Drivers_License.__Result,__EEQP(LEFT.Licence_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Transaction__Orphan := JOIN(InData(__NN(Transaction_)),E_Event.__Result,__EEQP(LEFT.Transaction_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(_r_Customer__Orphan),COUNT(Subject__Orphan),COUNT(Social__Orphan),COUNT(Phone_Number__Orphan),COUNT(Emailof__Orphan),COUNT(Location__Orphan),COUNT(Ip__Orphan),COUNT(Routing_Bank__Orphan),COUNT(Account__Orphan),COUNT(Licence__Orphan),COUNT(Transaction__Orphan)}],{KEL.typ.int _r_Customer__Orphan,KEL.typ.int Subject__Orphan,KEL.typ.int Social__Orphan,KEL.typ.int Phone_Number__Orphan,KEL.typ.int Emailof__Orphan,KEL.typ.int Location__Orphan,KEL.typ.int Ip__Orphan,KEL.typ.int Routing_Bank__Orphan,KEL.typ.int Account__Orphan,KEL.typ.int Licence__Orphan,KEL.typ.int Transaction__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonEvent','KELOtto.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d0(__NL(_r_Customer_))),COUNT(__d0(__NN(_r_Customer_)))},
    {'PersonEvent','KELOtto.fraudgovshared','Subject',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'PersonEvent','KELOtto.fraudgovshared','Social',COUNT(__d0(__NL(Social_))),COUNT(__d0(__NN(Social_)))},
    {'PersonEvent','KELOtto.fraudgovshared','PhoneNumber',COUNT(__d0(__NL(Phone_Number_))),COUNT(__d0(__NN(Phone_Number_)))},
    {'PersonEvent','KELOtto.fraudgovshared','Emailof',COUNT(__d0(__NL(Emailof_))),COUNT(__d0(__NN(Emailof_)))},
    {'PersonEvent','KELOtto.fraudgovshared','Location',COUNT(__d0(__NL(Location_))),COUNT(__d0(__NN(Location_)))},
    {'PersonEvent','KELOtto.fraudgovshared','Ip',COUNT(__d0(__NL(Ip_))),COUNT(__d0(__NN(Ip_)))},
    {'PersonEvent','KELOtto.fraudgovshared','RoutingBank',COUNT(__d0(__NL(Routing_Bank_))),COUNT(__d0(__NN(Routing_Bank_)))},
    {'PersonEvent','KELOtto.fraudgovshared','Account',COUNT(__d0(__NL(Account_))),COUNT(__d0(__NN(Account_)))},
    {'PersonEvent','KELOtto.fraudgovshared','Licence',COUNT(__d0(__NL(Licence_))),COUNT(__d0(__NN(Licence_)))},
    {'PersonEvent','KELOtto.fraudgovshared','event_date',COUNT(__d0(__NL(Event_Date_))),COUNT(__d0(__NN(Event_Date_)))},
    {'PersonEvent','KELOtto.fraudgovshared','Transaction',COUNT(__d0(__NL(Transaction_))),COUNT(__d0(__NN(Transaction_)))},
    {'PersonEvent','KELOtto.fraudgovshared','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonEvent','KELOtto.fraudgovshared','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'PersonEvent','KELOtto.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d1(__NL(_r_Customer_))),COUNT(__d1(__NN(_r_Customer_)))},
    {'PersonEvent','KELOtto.fraudgovshared','Subject',COUNT(__d1(__NL(Subject_))),COUNT(__d1(__NN(Subject_)))},
    {'PersonEvent','KELOtto.fraudgovshared','Social',COUNT(__d1(__NL(Social_))),COUNT(__d1(__NN(Social_)))},
    {'PersonEvent','KELOtto.fraudgovshared','PhoneNumber',COUNT(__d1(__NL(Phone_Number_))),COUNT(__d1(__NN(Phone_Number_)))},
    {'PersonEvent','KELOtto.fraudgovshared','Emailof',COUNT(__d1(__NL(Emailof_))),COUNT(__d1(__NN(Emailof_)))},
    {'PersonEvent','KELOtto.fraudgovshared','Location',COUNT(__d1(__NL(Location_))),COUNT(__d1(__NN(Location_)))},
    {'PersonEvent','KELOtto.fraudgovshared','Ip',COUNT(__d1(__NL(Ip_))),COUNT(__d1(__NN(Ip_)))},
    {'PersonEvent','KELOtto.fraudgovshared','RoutingBank',COUNT(__d1(__NL(Routing_Bank_))),COUNT(__d1(__NN(Routing_Bank_)))},
    {'PersonEvent','KELOtto.fraudgovshared','Account',COUNT(__d1(__NL(Account_))),COUNT(__d1(__NN(Account_)))},
    {'PersonEvent','KELOtto.fraudgovshared','Licence',COUNT(__d1(__NL(Licence_))),COUNT(__d1(__NN(Licence_)))},
    {'PersonEvent','KELOtto.fraudgovshared','event_date',COUNT(__d1(__NL(Event_Date_))),COUNT(__d1(__NN(Event_Date_)))},
    {'PersonEvent','KELOtto.fraudgovshared','Transaction',COUNT(__d1(__NL(Transaction_))),COUNT(__d1(__NN(Transaction_)))},
    {'PersonEvent','KELOtto.fraudgovshared','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'PersonEvent','KELOtto.fraudgovshared','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
