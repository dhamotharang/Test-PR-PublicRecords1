//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT E_Phone := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'clean_phones.phone_number(UID),iscellphone(_is_Cell_Phone_),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'clean_phones.phone_number(UID),iscellphone(_is_Cell_Phone_),dt_first_seen(Date_First_Seen_:EPOCH),dt_last_seen(Date_Last_Seen_:EPOCH)';
  EXPORT __d0_KELfiltered := KELOtto.fraudgov((UNSIGNED)clean_phones.phone_number <> 0);
  EXPORT KELOtto_fraudgov_1_Invalid := __d0_KELfiltered((KEL.typ.uid)clean_phones.phone_number = 0);
  SHARED __d0_Prefiltered := __d0_KELfiltered((KEL.typ.uid)clean_phones.phone_number <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  SHARED __Mapping1 := 'clean_phones.phone_number(UID),dt_first_seen(Date_First_Seen_:EPOCH),dt_last_seen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF._is_Cell_Phone_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d1_KELfiltered := KELOtto.fraudgov((UNSIGNED)clean_phones.cell_phone <> 0);
  EXPORT KELOtto_fraudgov_2_Invalid := __d1_KELfiltered((KEL.typ.uid)clean_phones.phone_number = 0);
  SHARED __d1_Prefiltered := __d1_KELfiltered((KEL.typ.uid)clean_phones.phone_number <> 0);
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1),__Mapping1_Transform(LEFT)));
  EXPORT InData := __d0 + __d1;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Phone_Group := __PostFilter;
  Layout Phone__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF._is_Cell_Phone_ := KEL.Intake.SingleValue(__recs,_is_Cell_Phone_);
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Phone__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Phone_Group,COUNT(ROWS(LEFT))=1),GROUP,Phone__Single_Rollup(LEFT)) + ROLLUP(HAVING(Phone_Group,COUNT(ROWS(LEFT))>1),GROUP,Phone__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KELOtto::Phone::Result',EXPIRE(30));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT _is_Cell_Phone__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_is_Cell_Phone_);
  EXPORT SanityCheck := DATASET([{COUNT(KELOtto_fraudgov_1_Invalid),COUNT(KELOtto_fraudgov_2_Invalid),COUNT(_is_Cell_Phone__SingleValue_Invalid)}],{KEL.typ.int KELOtto_fraudgov_1_Invalid,KEL.typ.int KELOtto_fraudgov_2_Invalid,KEL.typ.int _is_Cell_Phone__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Phone','KELOtto.fraudgov','UID',COUNT(KELOtto_fraudgov_1_Invalid),COUNT(__d0)},
    {'Phone','KELOtto.fraudgov','isCellPhone',COUNT(__d0(__NL(_is_Cell_Phone_))),COUNT(__d0(__NN(_is_Cell_Phone_)))},
    {'Phone','KELOtto.fraudgov','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Phone','KELOtto.fraudgov','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Phone','KELOtto.fraudgov','UID',COUNT(KELOtto_fraudgov_2_Invalid),COUNT(__d1)},
    {'Phone','KELOtto.fraudgov','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Phone','KELOtto.fraudgov','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
