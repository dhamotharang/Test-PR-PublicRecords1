//HPCC Systems KEL Compiler Version 0.11.0
IMPORT KEL011 AS KEL;
IMPORT KELOtto;
IMPORT * FROM KEL011.Null;
EXPORT E_Customer := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'targetcustomerhash(UID),customerid(Customer_Id_:0),industrytype(Industry_Type_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'targetcustomerhash(UID),inclusion_id(Customer_Id_:0),ind_type(Industry_Type_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  EXPORT __d0_KELfiltered := KELOtto.SharingRules((UNSIGNED)fdn_ind_type_gc_id_inclusion>0);
  EXPORT KELOtto_SharingRules_Invalid := __d0_KELfiltered((KEL.typ.uid)TargetCustomerHash = 0);
  SHARED __d0_Prefiltered := __d0_KELfiltered((KEL.typ.uid)TargetCustomerHash <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  EXPORT InData := __d0;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Customer_Group := __PostFilter;
  Layout Customer__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Customer_Id_ := KEL.Intake.SingleValue(__recs,Customer_Id_);
    SELF.Industry_Type_ := KEL.Intake.SingleValue(__recs,Industry_Type_);
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Customer__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Customer_Group,COUNT(ROWS(LEFT))=1),GROUP,Customer__Single_Rollup(LEFT)) + ROLLUP(HAVING(Customer_Group,COUNT(ROWS(LEFT))>1),GROUP,Customer__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::KELOtto::Customer::Result',EXPIRE(30));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Customer_Id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Customer_Id_);
  EXPORT Industry_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Industry_Type_);
  EXPORT SanityCheck := DATASET([{COUNT(KELOtto_SharingRules_Invalid),COUNT(Customer_Id__SingleValue_Invalid),COUNT(Industry_Type__SingleValue_Invalid)}],{KEL.typ.int KELOtto_SharingRules_Invalid,KEL.typ.int Customer_Id__SingleValue_Invalid,KEL.typ.int Industry_Type__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Customer','KELOtto.SharingRules','UID',COUNT(KELOtto_SharingRules_Invalid),COUNT(__d0)},
    {'Customer','KELOtto.SharingRules','inclusion_id',COUNT(__d0(__NL(Customer_Id_))),COUNT(__d0(__NN(Customer_Id_)))},
    {'Customer','KELOtto.SharingRules','Ind_type',COUNT(__d0(__NL(Industry_Type_))),COUNT(__d0(__NN(Industry_Type_)))},
    {'Customer','KELOtto.SharingRules','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Customer','KELOtto.SharingRules','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
