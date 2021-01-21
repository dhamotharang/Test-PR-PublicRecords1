//HPCC Systems KEL Compiler Version 0.11.6-2
IMPORT KEL011 AS KEL;
IMPORT FraudgovKEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Customer := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nunk _ind__type__description_;
    KEL.typ.nstr State_;
    KEL.typ.nint State_Count_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'targetcustomerhash(UID),customerid(Customer_Id_:0),industrytype(Industry_Type_:0),ind_type_description(_ind__type__description_:\'\'),state(State_:\'\'),statecount(State_Count_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'targetcustomerhash(UID),inclusion_id(Customer_Id_:0),ind_type(Industry_Type_:0),ind_type_description(_ind__type__description_:\'\'),state(State_:\'\'),statecount(State_Count_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  EXPORT __d0_KELfiltered := FraudgovKEL.SharingRules((UNSIGNED)fdn_ind_type_gc_id_inclusion>0);
  EXPORT FraudgovKEL_SharingRules_Invalid := __d0_KELfiltered((KEL.typ.uid)TargetCustomerHash = 0);
  SHARED __d0_Prefiltered := __d0_KELfiltered((KEL.typ.uid)TargetCustomerHash <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  EXPORT InData := __d0;
  EXPORT States_Layout := RECORD
    KEL.typ.nstr State_;
    KEL.typ.nint State_Count_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nunk _ind__type__description_;
    KEL.typ.ndataset(States_Layout) States_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Customer_Group := __PostFilter;
  Layout Customer__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Customer_Id_ := KEL.Intake.SingleValue(__recs,Customer_Id_);
    SELF.Industry_Type_ := KEL.Intake.SingleValue(__recs,Industry_Type_);
    SELF._ind__type__description_ := KEL.Intake.SingleValue(__recs,_ind__type__description_);
    SELF.States_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),State_,State_Count_},State_,State_Count_),States_Layout)(__NN(State_) OR __NN(State_Count_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Customer__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.States_ := __CN(PROJECT(DATASET(__r),TRANSFORM(States_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(State_) OR __NN(State_Count_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Customer_Group,COUNT(ROWS(LEFT))=1),GROUP,Customer__Single_Rollup(LEFT)) + ROLLUP(HAVING(Customer_Group,COUNT(ROWS(LEFT))>1),GROUP,Customer__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~fraudgov::temp::KEL::FraudgovKEL::Customer::Result',EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Customer_Id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Customer_Id_);
  EXPORT Industry_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Industry_Type_);
  EXPORT _ind__type__description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_ind__type__description_);
  EXPORT SanityCheck := DATASET([{COUNT(FraudgovKEL_SharingRules_Invalid),COUNT(Customer_Id__SingleValue_Invalid),COUNT(Industry_Type__SingleValue_Invalid),COUNT(_ind__type__description__SingleValue_Invalid)}],{KEL.typ.int FraudgovKEL_SharingRules_Invalid,KEL.typ.int Customer_Id__SingleValue_Invalid,KEL.typ.int Industry_Type__SingleValue_Invalid,KEL.typ.int _ind__type__description__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Customer','FraudgovKEL.SharingRules','UID',COUNT(FraudgovKEL_SharingRules_Invalid),COUNT(__d0)},
    {'Customer','FraudgovKEL.SharingRules','inclusion_id',COUNT(__d0(__NL(Customer_Id_))),COUNT(__d0(__NN(Customer_Id_)))},
    {'Customer','FraudgovKEL.SharingRules','Ind_type',COUNT(__d0(__NL(Industry_Type_))),COUNT(__d0(__NN(Industry_Type_)))},
    {'Customer','FraudgovKEL.SharingRules','ind_type_description',COUNT(__d0(__NL(_ind__type__description_))),COUNT(__d0(__NN(_ind__type__description_)))},
    {'Customer','FraudgovKEL.SharingRules','State',COUNT(__d0(__NL(State_))),COUNT(__d0(__NN(State_)))},
    {'Customer','FraudgovKEL.SharingRules','StateCount',COUNT(__d0(__NL(State_Count_))),COUNT(__d0(__NN(State_Count_)))},
    {'Customer','FraudgovKEL.SharingRules','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Customer','FraudgovKEL.SharingRules','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
