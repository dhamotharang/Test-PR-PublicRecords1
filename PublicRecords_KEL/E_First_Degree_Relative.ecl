//HPCC Systems KEL Compiler Version 0.11.4
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_First_Degree_Relative(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Person().Typ) Relative_;
    KEL.typ.nint Title_;
    KEL.typ.nstr Relationship_Type_;
    KEL.typ.nstr Relationship_Confidence_;
    KEL.typ.nint Relationship_Score_;
    KEL.typ.nstr Generation_;
    KEL.typ.nstr Relationship_Date_First_Seen_;
    KEL.typ.nstr Relationship_Date_Last_Seen_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED1 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'lexid(Subject_:0|Relative_:0),title(Title_:0),relationshiptype(Relationship_Type_:\'\'),relationshipconfidence(Relationship_Confidence_:\'\'),relationshipscore(Relationship_Score_:0),generation(Generation_:\'\'),relationshipdatefirstseen(Relationship_Date_First_Seen_:\'\'),relationshipdatelastseen(Relationship_Date_Last_Seen_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d0_Prefiltered := __in;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping));
  EXPORT InData := __d0;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Person().Typ) Relative_;
    KEL.typ.nint Title_;
    KEL.typ.nstr Relationship_Type_;
    KEL.typ.nstr Relationship_Confidence_;
    KEL.typ.nint Relationship_Score_;
    KEL.typ.nstr Generation_;
    KEL.typ.nstr Relationship_Date_First_Seen_;
    KEL.typ.nstr Relationship_Date_Last_Seen_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PreResult := PROJECT(TABLE(InData,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Subject_,Relative_,Title_,Relationship_Type_,Relationship_Confidence_,Relationship_Score_,Generation_,Relationship_Date_First_Seen_,Relationship_Date_Last_Seen_},Subject_,Relative_,Title_,Relationship_Type_,Relationship_Confidence_,Relationship_Score_,Generation_,Relationship_Date_First_Seen_,Relationship_Date_Last_Seen_,MERGE),Layout);
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person(__in,__cfg).__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Relative__Orphan := JOIN(InData(__NN(Relative_)),E_Person(__in,__cfg).__Result,__EEQP(LEFT.Relative_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Subject__Orphan),COUNT(Relative__Orphan)}],{KEL.typ.int Subject__Orphan,KEL.typ.int Relative__Orphan});
  EXPORT NullCounts := DATASET([
    {'FirstDegreeRelative','PublicRecords_KEL.ECL_Functions.Blank_DataSet','LexID',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'FirstDegreeRelative','PublicRecords_KEL.ECL_Functions.Blank_DataSet','LexID',COUNT(__d0(__NL(Relative_))),COUNT(__d0(__NN(Relative_)))},
    {'FirstDegreeRelative','PublicRecords_KEL.ECL_Functions.Blank_DataSet','Title',COUNT(__d0(__NL(Title_))),COUNT(__d0(__NN(Title_)))},
    {'FirstDegreeRelative','PublicRecords_KEL.ECL_Functions.Blank_DataSet','RelationshipType',COUNT(__d0(__NL(Relationship_Type_))),COUNT(__d0(__NN(Relationship_Type_)))},
    {'FirstDegreeRelative','PublicRecords_KEL.ECL_Functions.Blank_DataSet','RelationshipConfidence',COUNT(__d0(__NL(Relationship_Confidence_))),COUNT(__d0(__NN(Relationship_Confidence_)))},
    {'FirstDegreeRelative','PublicRecords_KEL.ECL_Functions.Blank_DataSet','RelationshipScore',COUNT(__d0(__NL(Relationship_Score_))),COUNT(__d0(__NN(Relationship_Score_)))},
    {'FirstDegreeRelative','PublicRecords_KEL.ECL_Functions.Blank_DataSet','Generation',COUNT(__d0(__NL(Generation_))),COUNT(__d0(__NN(Generation_)))},
    {'FirstDegreeRelative','PublicRecords_KEL.ECL_Functions.Blank_DataSet','RelationshipDateFirstSeen',COUNT(__d0(__NL(Relationship_Date_First_Seen_))),COUNT(__d0(__NN(Relationship_Date_First_Seen_)))},
    {'FirstDegreeRelative','PublicRecords_KEL.ECL_Functions.Blank_DataSet','RelationshipDateLastSeen',COUNT(__d0(__NL(Relationship_Date_Last_Seen_))),COUNT(__d0(__NN(Relationship_Date_Last_Seen_)))},
    {'FirstDegreeRelative','PublicRecords_KEL.ECL_Functions.Blank_DataSet','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'FirstDegreeRelative','PublicRecords_KEL.ECL_Functions.Blank_DataSet','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
