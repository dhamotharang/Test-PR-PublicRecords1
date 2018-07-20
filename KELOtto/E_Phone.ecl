//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT KELOtto;
IMPORT E_Customer FROM KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT E_Phone := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Customer.Typ) _r_Customer_;
    KEL.typ.ntyp(E_Customer.Typ) _r_Source_Customer_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.nstr Hri_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),phonenumber(Phone_Number_:\'\'),iscellphone(_is_Cell_Phone_),hri(Hri_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := KELOtto.fraudgovshared(clean_phones.cell_phone != '');
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.clean_phones.cell_phone)));
  SHARED __d1_KELfiltered := KELOtto.fraudgovshared(clean_phones.phone_number != '');
  SHARED __d1_Trim := PROJECT(__d1_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.clean_phones.phone_number)));
  SHARED __d2_KELfiltered := KELOtto.PersonCIID(phone10 != '');
  SHARED __d2_Trim := PROJECT(__d2_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.phone10)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim + __d2_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'') + '|' + TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::KELOtto::Phone::UidLookup',EXPIRE(30));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::KELOtto::Phone');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::KELOtto::Phone');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED __Mapping0 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),clean_phones.cell_phone(Phone_Number_:\'\'),hri(Hri_:\'\'),dt_first_seen(Date_First_Seen_:EPOCH),dt_last_seen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF._is_Cell_Phone_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d0_Out := RECORD
    RECORDOF(KELOtto.fraudgovshared);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.clean_phones.cell_phone) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT KELOtto_fraudgovshared_1_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0),__Mapping0_Transform(LEFT)));
  SHARED __Mapping1 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),clean_phones.phone_number(Phone_Number_:\'\'),hri(Hri_:\'\'),dt_first_seen(Date_First_Seen_:EPOCH),dt_last_seen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF._is_Cell_Phone_ := __CN(FALSE);
    SELF := __r;
  END;
  SHARED __d1_Out := RECORD
    RECORDOF(KELOtto.fraudgovshared);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_KELfiltered,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.clean_phones.phone_number) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT KELOtto_fraudgovshared_2_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1),__Mapping1_Transform(LEFT)));
  SHARED __Mapping2 := 'UID(UID),associatedcustomerfileinfo(_r_Customer_:0),sourcecustomerfileinfo(_r_Source_Customer_:0),phone10(Phone_Number_:\'\'),iscellphone(_is_Cell_Phone_),hri(Hri_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d2_Out := RECORD
    RECORDOF(KELOtto.PersonCIID);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d2_UID_Mapped := JOIN(__d2_KELfiltered,Lookup,TRIM((STRING)LEFT.AssociatedCustomerFileInfo) + '|' + TRIM((STRING)LEFT.phone10) = RIGHT.KeyVal,TRANSFORM(__d2_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT KELOtto_PersonCIID_Invalid := __d2_UID_Mapped(UID = 0);
  SHARED __d2_Prefiltered := __d2_UID_Mapped(UID <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2));
  EXPORT InData := __d0 + __d1 + __d2;
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
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.ndataset(Hri_List_Layout) Hri_List_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Phone_Group := __PostFilter;
  Layout Phone__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF._r_Customer_ := KEL.Intake.SingleValue(__recs,_r_Customer_);
    SELF.Source_Customers_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),_r_Source_Customer_},_r_Source_Customer_),Source_Customers_Layout)(__NN(_r_Source_Customer_)));
    SELF.Phone_Number_ := KEL.Intake.SingleValue(__recs,Phone_Number_);
    SELF._is_Cell_Phone_ := KEL.Intake.SingleValue(__recs,_is_Cell_Phone_);
    SELF.Hri_List_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Hri_},Hri_),Hri_List_Layout)(__NN(Hri_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Phone__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Source_Customers_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Source_Customers_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(_r_Source_Customer_)));
    SELF.Hri_List_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Hri_List_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Hri_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Phone_Group,COUNT(ROWS(LEFT))=1),GROUP,Phone__Single_Rollup(LEFT)) + ROLLUP(HAVING(Phone_Group,COUNT(ROWS(LEFT))>1),GROUP,Phone__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KELOtto::Phone::Result',EXPIRE(30));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT _r_Customer__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_r_Customer_);
  EXPORT Phone_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Phone_Number_);
  EXPORT _is_Cell_Phone__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_is_Cell_Phone_);
  EXPORT _r_Customer__Orphan := JOIN(InData(__NN(_r_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT _r_Source_Customer__Orphan := JOIN(InData(__NN(_r_Source_Customer_)),E_Customer.__Result,__EEQP(LEFT._r_Source_Customer_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(_r_Customer__Orphan),COUNT(_r_Source_Customer__Orphan),COUNT(KELOtto_fraudgovshared_1_Invalid),COUNT(KELOtto_fraudgovshared_2_Invalid),COUNT(KELOtto_PersonCIID_Invalid),COUNT(_r_Customer__SingleValue_Invalid),COUNT(Phone_Number__SingleValue_Invalid),COUNT(_is_Cell_Phone__SingleValue_Invalid)}],{KEL.typ.int _r_Customer__Orphan,KEL.typ.int _r_Source_Customer__Orphan,KEL.typ.int KELOtto_fraudgovshared_1_Invalid,KEL.typ.int KELOtto_fraudgovshared_2_Invalid,KEL.typ.int KELOtto_PersonCIID_Invalid,KEL.typ.int _r_Customer__SingleValue_Invalid,KEL.typ.int Phone_Number__SingleValue_Invalid,KEL.typ.int _is_Cell_Phone__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Phone','KELOtto.fraudgovshared','UID',COUNT(KELOtto_fraudgovshared_1_Invalid),COUNT(__d0)},
    {'Phone','KELOtto.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d0(__NL(_r_Customer_))),COUNT(__d0(__NN(_r_Customer_)))},
    {'Phone','KELOtto.fraudgovshared','SourceCustomerFileInfo',COUNT(__d0(__NL(_r_Source_Customer_))),COUNT(__d0(__NN(_r_Source_Customer_)))},
    {'Phone','KELOtto.fraudgovshared','clean_phones.cell_phone',COUNT(__d0(__NL(Phone_Number_))),COUNT(__d0(__NN(Phone_Number_)))},
    {'Phone','KELOtto.fraudgovshared','Hri',COUNT(__d0(__NL(Hri_))),COUNT(__d0(__NN(Hri_)))},
    {'Phone','KELOtto.fraudgovshared','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Phone','KELOtto.fraudgovshared','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Phone','KELOtto.fraudgovshared','UID',COUNT(KELOtto_fraudgovshared_2_Invalid),COUNT(__d1)},
    {'Phone','KELOtto.fraudgovshared','AssociatedCustomerFileInfo',COUNT(__d1(__NL(_r_Customer_))),COUNT(__d1(__NN(_r_Customer_)))},
    {'Phone','KELOtto.fraudgovshared','SourceCustomerFileInfo',COUNT(__d1(__NL(_r_Source_Customer_))),COUNT(__d1(__NN(_r_Source_Customer_)))},
    {'Phone','KELOtto.fraudgovshared','clean_phones.phone_number',COUNT(__d1(__NL(Phone_Number_))),COUNT(__d1(__NN(Phone_Number_)))},
    {'Phone','KELOtto.fraudgovshared','Hri',COUNT(__d1(__NL(Hri_))),COUNT(__d1(__NN(Hri_)))},
    {'Phone','KELOtto.fraudgovshared','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Phone','KELOtto.fraudgovshared','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'Phone','KELOtto.PersonCIID','UID',COUNT(KELOtto_PersonCIID_Invalid),COUNT(__d2)},
    {'Phone','KELOtto.PersonCIID','AssociatedCustomerFileInfo',COUNT(__d2(__NL(_r_Customer_))),COUNT(__d2(__NN(_r_Customer_)))},
    {'Phone','KELOtto.PersonCIID','SourceCustomerFileInfo',COUNT(__d2(__NL(_r_Source_Customer_))),COUNT(__d2(__NN(_r_Source_Customer_)))},
    {'Phone','KELOtto.PersonCIID','phone10',COUNT(__d2(__NL(Phone_Number_))),COUNT(__d2(__NN(Phone_Number_)))},
    {'Phone','KELOtto.PersonCIID','isCellPhone',COUNT(__d2(__NL(_is_Cell_Phone_))),COUNT(__d2(__NN(_is_Cell_Phone_)))},
    {'Phone','KELOtto.PersonCIID','Hri',COUNT(__d2(__NL(Hri_))),COUNT(__d2(__NN(Hri_)))},
    {'Phone','KELOtto.PersonCIID','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'Phone','KELOtto.PersonCIID','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
