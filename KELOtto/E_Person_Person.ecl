//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT KELOtto;
IMPORT E_Customer,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT E_Person_Person := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.nint Self_Match_;
    KEL.typ.nint Public_Records_;
    KEL.typ.nint Contributory_Records_;
    KEL.typ.nint Same_Address_Email_Match_;
    KEL.typ.nint Same_Address_Ssn_Match_;
    KEL.typ.nint Same_Address_Phone_Number_Match_;
    KEL.typ.nint Same_Address_Same_Day_Count_;
    KEL.typ.nint High_Frequency_Same_Address_Same_Day_Count_;
    KEL.typ.nint Non_High_Frequency_Address_Count_;
    KEL.typ.nint Non_High_Frequency_Same_Address_Same_Day_Count_;
    KEL.typ.nint Shared_Address_Count_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'associatedcustomerfileinfo(_r_Customer_:0),From_Person_(From_Person_:0),To_Person_(To_Person_:0),selfmatch(Self_Match_:0),publicrecords(Public_Records_:0),contributoryrecords(Contributory_Records_:0),sameaddressemailmatch(Same_Address_Email_Match_:0),sameaddressssnmatch(Same_Address_Ssn_Match_:0),sameaddressphonenumbermatch(Same_Address_Phone_Number_Match_:0),sameaddresssamedaycount(Same_Address_Same_Day_Count_:0),highfrequencysameaddresssamedaycount(High_Frequency_Same_Address_Same_Day_Count_:0),nonhighfrequencyaddresscount(Non_High_Frequency_Address_Count_:0),nonhighfrequencysameaddresssamedaycount(Non_High_Frequency_Same_Address_Same_Day_Count_:0),sharedaddresscount(Shared_Address_Count_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d0_From_Person__Layout := RECORD
    RECORDOF(KELOtto.AddressPersonAssociations.PersonAddressMatchStats);
    KEL.typ.uid From_Person_;
  END;
  SHARED __d0_From_Person__Mapped := JOIN(KELOtto.AddressPersonAssociations.PersonAddressMatchStats,E_Person.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.frompersonlexid) = RIGHT.KeyVal,TRANSFORM(__d0_From_Person__Layout,SELF.From_Person_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_To_Person__Layout := RECORD
    RECORDOF(__d0_From_Person__Mapped);
    KEL.typ.uid To_Person_;
  END;
  SHARED __d0_To_Person__Mapped := JOIN(__d0_From_Person__Mapped,E_Person.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.topersonlexid) = RIGHT.KeyVal,TRANSFORM(__d0_To_Person__Layout,SELF.To_Person_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_To_Person__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping));
  EXPORT InData := __d0;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Person.Typ) From_Person_;
    KEL.typ.ntyp(E_Person.Typ) To_Person_;
    KEL.typ.nint Self_Match_;
    KEL.typ.nint Public_Records_;
    KEL.typ.nint Contributory_Records_;
    KEL.typ.nint Same_Address_Email_Match_;
    KEL.typ.nint Same_Address_Ssn_Match_;
    KEL.typ.nint Same_Address_Phone_Number_Match_;
    KEL.typ.nint Same_Address_Same_Day_Count_;
    KEL.typ.nint High_Frequency_Same_Address_Same_Day_Count_;
    KEL.typ.nint Non_High_Frequency_Address_Count_;
    KEL.typ.nint Non_High_Frequency_Same_Address_Same_Day_Count_;
    KEL.typ.nint Shared_Address_Count_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PreResult := PROJECT(TABLE(InData,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Customer_,From_Person_,To_Person_,Self_Match_,Public_Records_,Contributory_Records_,Same_Address_Email_Match_,Same_Address_Ssn_Match_,Same_Address_Phone_Number_Match_,Same_Address_Same_Day_Count_,High_Frequency_Same_Address_Same_Day_Count_,Non_High_Frequency_Address_Count_,Non_High_Frequency_Same_Address_Same_Day_Count_,Shared_Address_Count_},_r_Customer_,From_Person_,To_Person_,Self_Match_,Public_Records_,Contributory_Records_,Same_Address_Email_Match_,Same_Address_Ssn_Match_,Same_Address_Phone_Number_Match_,Same_Address_Same_Day_Count_,High_Frequency_Same_Address_Same_Day_Count_,Non_High_Frequency_Address_Count_,Non_High_Frequency_Same_Address_Same_Day_Count_,Shared_Address_Count_,MERGE),Layout);
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KELOtto::Person_Person::Result',EXPIRE(30));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT _r_Customer__Orphan := JOIN(InData(__NN(_r_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT From_Person__Orphan := JOIN(InData(__NN(From_Person_)),E_Person.__Result,__EEQP(LEFT.From_Person_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT To_Person__Orphan := JOIN(InData(__NN(To_Person_)),E_Person.__Result,__EEQP(LEFT.To_Person_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(_r_Customer__Orphan),COUNT(From_Person__Orphan),COUNT(To_Person__Orphan)}],{KEL.typ.int _r_Customer__Orphan,KEL.typ.int From_Person__Orphan,KEL.typ.int To_Person__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonPerson','KELOtto.AddressPersonAssociations.PersonAddressMatchStats','AssociatedCustomerFileInfo',COUNT(__d0(__NL(_r_Customer_))),COUNT(__d0(__NN(_r_Customer_)))},
    {'PersonPerson','KELOtto.AddressPersonAssociations.PersonAddressMatchStats','FromPerson',COUNT(__d0(__NL(From_Person_))),COUNT(__d0(__NN(From_Person_)))},
    {'PersonPerson','KELOtto.AddressPersonAssociations.PersonAddressMatchStats','ToPerson',COUNT(__d0(__NL(To_Person_))),COUNT(__d0(__NN(To_Person_)))},
    {'PersonPerson','KELOtto.AddressPersonAssociations.PersonAddressMatchStats','SelfMatch',COUNT(__d0(__NL(Self_Match_))),COUNT(__d0(__NN(Self_Match_)))},
    {'PersonPerson','KELOtto.AddressPersonAssociations.PersonAddressMatchStats','PublicRecords',COUNT(__d0(__NL(Public_Records_))),COUNT(__d0(__NN(Public_Records_)))},
    {'PersonPerson','KELOtto.AddressPersonAssociations.PersonAddressMatchStats','ContributoryRecords',COUNT(__d0(__NL(Contributory_Records_))),COUNT(__d0(__NN(Contributory_Records_)))},
    {'PersonPerson','KELOtto.AddressPersonAssociations.PersonAddressMatchStats','SameAddressEmailMatch',COUNT(__d0(__NL(Same_Address_Email_Match_))),COUNT(__d0(__NN(Same_Address_Email_Match_)))},
    {'PersonPerson','KELOtto.AddressPersonAssociations.PersonAddressMatchStats','SameAddressSsnMatch',COUNT(__d0(__NL(Same_Address_Ssn_Match_))),COUNT(__d0(__NN(Same_Address_Ssn_Match_)))},
    {'PersonPerson','KELOtto.AddressPersonAssociations.PersonAddressMatchStats','SameAddressPhoneNumberMatch',COUNT(__d0(__NL(Same_Address_Phone_Number_Match_))),COUNT(__d0(__NN(Same_Address_Phone_Number_Match_)))},
    {'PersonPerson','KELOtto.AddressPersonAssociations.PersonAddressMatchStats','SameAddressSameDayCount',COUNT(__d0(__NL(Same_Address_Same_Day_Count_))),COUNT(__d0(__NN(Same_Address_Same_Day_Count_)))},
    {'PersonPerson','KELOtto.AddressPersonAssociations.PersonAddressMatchStats','HighFrequencySameAddressSameDayCount',COUNT(__d0(__NL(High_Frequency_Same_Address_Same_Day_Count_))),COUNT(__d0(__NN(High_Frequency_Same_Address_Same_Day_Count_)))},
    {'PersonPerson','KELOtto.AddressPersonAssociations.PersonAddressMatchStats','NonHighFrequencyAddressCount',COUNT(__d0(__NL(Non_High_Frequency_Address_Count_))),COUNT(__d0(__NN(Non_High_Frequency_Address_Count_)))},
    {'PersonPerson','KELOtto.AddressPersonAssociations.PersonAddressMatchStats','NonHighFrequencySameAddressSameDayCount',COUNT(__d0(__NL(Non_High_Frequency_Same_Address_Same_Day_Count_))),COUNT(__d0(__NN(Non_High_Frequency_Same_Address_Same_Day_Count_)))},
    {'PersonPerson','KELOtto.AddressPersonAssociations.PersonAddressMatchStats','SharedAddressCount',COUNT(__d0(__NL(Shared_Address_Count_))),COUNT(__d0(__NN(Shared_Address_Count_)))},
    {'PersonPerson','KELOtto.AddressPersonAssociations.PersonAddressMatchStats','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonPerson','KELOtto.AddressPersonAssociations.PersonAddressMatchStats','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
