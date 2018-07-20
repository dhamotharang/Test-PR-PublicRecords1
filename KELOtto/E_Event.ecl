//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT KELOtto;
IMPORT E_Address,E_Customer,E_Person FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT E_Event := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Source_Customer_;
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.nstr Event_Type_;
    KEL.typ.nstr Hri_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),Subject_(Subject_:0),Location_(Location_:0),eventdate(Event_Date_:DATE),eventtype(Event_Type_:\'\'),hri(Hri_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := KELOtto.fraudgovshared((UNSIGNED)record_id > 0);
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.record_id)));
  SHARED __d1_KELfiltered := KELOtto.PersonEventTypes((UNSIGNED)record_id > 0);
  SHARED __d1_Trim := PROJECT(__d1_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.record_id)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'') + '|' + TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::KELOtto::Event::UidLookup',EXPIRE(30));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::KELOtto::Event');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::KELOtto::Event');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED __Mapping0 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),Subject_(Subject_:0),Location_(Location_:0),event_date(Event_Date_:DATE),eventtype(Event_Type_:\'\'),hri(Hri_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d0_Out := RECORD
    RECORDOF(KELOtto.fraudgovshared);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.record_id) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  SHARED __d0_Subject__Layout := RECORD
    RECORDOF(__d0_UID_Mapped);
    KEL.typ.uid Subject_;
  END;
  SHARED __d0_Subject__Mapped := JOIN(__d0_UID_Mapped,E_Person.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d0_Subject__Layout,SELF.Subject_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Location__Layout := RECORD
    RECORDOF(__d0_Subject__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d0_Location__Mapped := JOIN(__d0_Subject__Mapped,E_Address.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.clean_address.prim_range) + '|' + TRIM((STRING)LEFT.clean_address.predir) + '|' + TRIM((STRING)LEFT.clean_address.prim_name) + '|' + TRIM((STRING)LEFT.clean_address.addr_suffix) + '|' + TRIM((STRING)LEFT.clean_address.postdir) + '|' + TRIM((STRING)LEFT.clean_address.zip) + '|' + TRIM((STRING)LEFT.clean_address.sec_range) = RIGHT.KeyVal,TRANSFORM(__d0_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  EXPORT KELOtto_fraudgovshared_Invalid := __d0_Location__Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_Location__Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  SHARED __Mapping1 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),Subject_(Subject_:0),Location_(Location_:0),eventdate(Event_Date_:DATE),event_type(Event_Type_:\'\'),hri(Hri_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d1_Out := RECORD
    RECORDOF(KELOtto.PersonEventTypes);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_KELfiltered,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.record_id) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  SHARED __d1_Subject__Layout := RECORD
    RECORDOF(__d1_UID_Mapped);
    KEL.typ.uid Subject_;
  END;
  SHARED __d1_Subject__Mapped := JOIN(__d1_UID_Mapped,E_Person.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.LexId) = RIGHT.KeyVal,TRANSFORM(__d1_Subject__Layout,SELF.Subject_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d1_Location__Layout := RECORD
    RECORDOF(__d1_Subject__Mapped);
    KEL.typ.uid Location_;
  END;
  SHARED __d1_Location__Mapped := JOIN(__d1_Subject__Mapped,E_Address.Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.PrimaryRange) + '|' + TRIM((STRING)LEFT.Predirectional) + '|' + TRIM((STRING)LEFT.PrimaryName) + '|' + TRIM((STRING)LEFT.Suffix) + '|' + TRIM((STRING)LEFT.Postdirectional) + '|' + TRIM((STRING)LEFT.Zip) + '|' + TRIM((STRING)LEFT.SecondaryRange) = RIGHT.KeyVal,TRANSFORM(__d1_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  EXPORT KELOtto_PersonEventTypes_Invalid := __d1_Location__Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_Location__Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1));
  EXPORT InData := __d0 + __d1;
  EXPORT Source_Customers_Layout := RECORD
    KEL.typ.ntyp(E_Customer.Typ) _r_Source_Customer_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Event_Types_Layout := RECORD
    KEL.typ.nstr Event_Type_;
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
    KEL.typ.ntyp(E_Person.Typ) Subject_;
    KEL.typ.ntyp(E_Address.Typ) Location_;
    KEL.typ.nkdate Event_Date_;
    KEL.typ.ndataset(Event_Types_Layout) Event_Types_;
    KEL.typ.ndataset(Hri_List_Layout) Hri_List_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Event_Group := __PostFilter;
  Layout Event__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF._r_Customer_ := KEL.Intake.SingleValue(__recs,_r_Customer_);
    SELF.Source_Customers_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Source_Customer_},_r_Source_Customer_),Source_Customers_Layout)(__NN(_r_Source_Customer_)));
    SELF.Subject_ := KEL.Intake.SingleValue(__recs,Subject_);
    SELF.Location_ := KEL.Intake.SingleValue(__recs,Location_);
    SELF.Event_Date_ := KEL.Intake.SingleValue(__recs,Event_Date_);
    SELF.Event_Types_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Event_Type_},Event_Type_),Event_Types_Layout)(__NN(Event_Type_)));
    SELF.Hri_List_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Hri_},Hri_),Hri_List_Layout)(__NN(Hri_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Event__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Source_Customers_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Source_Customers_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(_r_Source_Customer_)));
    SELF.Event_Types_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Event_Types_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Event_Type_)));
    SELF.Hri_List_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Hri_List_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Hri_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Event_Group,COUNT(ROWS(LEFT))=1),GROUP,Event__Single_Rollup(LEFT)) + ROLLUP(HAVING(Event_Group,COUNT(ROWS(LEFT))>1),GROUP,Event__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KELOtto::Event::Result',EXPIRE(30));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT _r_Customer__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_r_Customer_);
  EXPORT Subject__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Subject_);
  EXPORT Location__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Location_);
  EXPORT Event_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Event_Date_);
  EXPORT _r_Customer__Orphan := JOIN(InData(__NN(_r_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT _r_Source_Customer__Orphan := JOIN(InData(__NN(_r_Source_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Source_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person.__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Location__Orphan := JOIN(InData(__NN(Location_)),E_Address.__Result,__EEQP(LEFT.Location_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(_r_Customer__Orphan),COUNT(_r_Source_Customer__Orphan),COUNT(Subject__Orphan),COUNT(Location__Orphan),COUNT(KELOtto_fraudgovshared_Invalid),COUNT(KELOtto_PersonEventTypes_Invalid),COUNT(_r_Customer__SingleValue_Invalid),COUNT(Subject__SingleValue_Invalid),COUNT(Location__SingleValue_Invalid),COUNT(Event_Date__SingleValue_Invalid)}],{KEL.typ.int _r_Customer__Orphan,KEL.typ.int _r_Source_Customer__Orphan,KEL.typ.int Subject__Orphan,KEL.typ.int Location__Orphan,KEL.typ.int KELOtto_fraudgovshared_Invalid,KEL.typ.int KELOtto_PersonEventTypes_Invalid,KEL.typ.int _r_Customer__SingleValue_Invalid,KEL.typ.int Subject__SingleValue_Invalid,KEL.typ.int Location__SingleValue_Invalid,KEL.typ.int Event_Date__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Event','KELOtto.fraudgovshared','UID',COUNT(KELOtto_fraudgovshared_Invalid),COUNT(__d0)},
    {'Event','KELOtto.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d0(__NL(_r_Customer_))),COUNT(__d0(__NN(_r_Customer_)))},
    {'Event','KELOtto.fraudgovshared','SourceCustomerFileInfo',COUNT(__d0(__NL(_r_Source_Customer_))),COUNT(__d0(__NN(_r_Source_Customer_)))},
    {'Event','KELOtto.fraudgovshared','Subject',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'Event','KELOtto.fraudgovshared','Location',COUNT(__d0(__NL(Location_))),COUNT(__d0(__NN(Location_)))},
    {'Event','KELOtto.fraudgovshared','event_date',COUNT(__d0(__NL(Event_Date_))),COUNT(__d0(__NN(Event_Date_)))},
    {'Event','KELOtto.fraudgovshared','EventType',COUNT(__d0(__NL(Event_Type_))),COUNT(__d0(__NN(Event_Type_)))},
    {'Event','KELOtto.fraudgovshared','Hri',COUNT(__d0(__NL(Hri_))),COUNT(__d0(__NN(Hri_)))},
    {'Event','KELOtto.fraudgovshared','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Event','KELOtto.fraudgovshared','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Event','KELOtto.PersonEventTypes','UID',COUNT(KELOtto_PersonEventTypes_Invalid),COUNT(__d1)},
    {'Event','KELOtto.PersonEventTypes','AssociatedCustomerFileInfo',COUNT(__d1(__NL(_r_Customer_))),COUNT(__d1(__NN(_r_Customer_)))},
    {'Event','KELOtto.PersonEventTypes','SourceCustomerFileInfo',COUNT(__d1(__NL(_r_Source_Customer_))),COUNT(__d1(__NN(_r_Source_Customer_)))},
    {'Event','KELOtto.PersonEventTypes','Subject',COUNT(__d1(__NL(Subject_))),COUNT(__d1(__NN(Subject_)))},
    {'Event','KELOtto.PersonEventTypes','Location',COUNT(__d1(__NL(Location_))),COUNT(__d1(__NN(Location_)))},
    {'Event','KELOtto.PersonEventTypes','EventDate',COUNT(__d1(__NL(Event_Date_))),COUNT(__d1(__NN(Event_Date_)))},
    {'Event','KELOtto.PersonEventTypes','event_type',COUNT(__d1(__NL(Event_Type_))),COUNT(__d1(__NN(Event_Type_)))},
    {'Event','KELOtto.PersonEventTypes','Hri',COUNT(__d1(__NL(Hri_))),COUNT(__d1(__NN(Hri_)))},
    {'Event','KELOtto.PersonEventTypes','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Event','KELOtto.PersonEventTypes','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
