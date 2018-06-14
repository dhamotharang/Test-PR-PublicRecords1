//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT E_Email := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr Type_;
    KEL.typ.nkdate Created_On_;
    KEL.typ.nstr Host_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),emailaddress(Email_Address_:\'\'),type(Type_:\'\'),createdon(Created_On_:DATE),host(Host_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := KELOtto.fraudgov((STRING50)email_address <> '');
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.email_address)));
  EXPORT __All_Trim := __d0_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::KELOtto::Email::UidLookup',EXPIRE(30));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::KELOtto::Email');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::KELOtto::Email');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED __Mapping0 := 'UID(UID),email_address(Email_Address_:\'\'),email_address_type(Type_:\'\'),email_address_date(Created_On_:DATE),host(Host_:\'\'),dt_first_seen(Date_First_Seen_:EPOCH),dt_last_seen(Date_Last_Seen_:EPOCH)';
  SHARED __d0_Out := RECORD
    RECORDOF(KELOtto.fraudgov);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.email_address) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT KELOtto_fraudgov_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  EXPORT InData := __d0;
  EXPORT Details_Layout := RECORD
    KEL.typ.nstr Type_;
    KEL.typ.nkdate Created_On_;
    KEL.typ.nstr Host_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Email_Address_;
    KEL.typ.ndataset(Details_Layout) Details_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Email_Group := __PostFilter;
  Layout Email__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Email_Address_ := KEL.Intake.SingleValue(__recs,Email_Address_);
    SELF.Details_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Type_,Created_On_,Host_},Type_,Created_On_,Host_),Details_Layout)(__NN(Type_) OR __NN(Created_On_) OR __NN(Host_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Email__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Details_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Details_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Type_) OR __NN(Created_On_) OR __NN(Host_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Email_Group,COUNT(ROWS(LEFT))=1),GROUP,Email__Single_Rollup(LEFT)) + ROLLUP(HAVING(Email_Group,COUNT(ROWS(LEFT))>1),GROUP,Email__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KELOtto::Email::Result',EXPIRE(30));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Email_Address__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Email_Address_);
  EXPORT SanityCheck := DATASET([{COUNT(KELOtto_fraudgov_Invalid),COUNT(Email_Address__SingleValue_Invalid)}],{KEL.typ.int KELOtto_fraudgov_Invalid,KEL.typ.int Email_Address__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Email','KELOtto.fraudgov','UID',COUNT(KELOtto_fraudgov_Invalid),COUNT(__d0)},
    {'Email','KELOtto.fraudgov','email_address',COUNT(__d0(__NL(Email_Address_))),COUNT(__d0(__NN(Email_Address_)))},
    {'Email','KELOtto.fraudgov','email_address_type',COUNT(__d0(__NL(Type_))),COUNT(__d0(__NN(Type_)))},
    {'Email','KELOtto.fraudgov','email_address_date',COUNT(__d0(__NL(Created_On_))),COUNT(__d0(__NN(Created_On_)))},
    {'Email','KELOtto.fraudgov','Host',COUNT(__d0(__NL(Host_))),COUNT(__d0(__NN(Host_)))},
    {'Email','KELOtto.fraudgov','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Email','KELOtto.fraudgov','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
