//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT CFG_Compile,E_First_Degree_Associations,E_First_Degree_Relative,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_First_Degree_Relative(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_First_Degree_Associations(__in,__cfg).__Result) __E_First_Degree_Associations := E_First_Degree_Associations(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_First_Degree_Relative(__in,__cfg).__Result) __E_First_Degree_Relative := E_First_Degree_Relative(__in,__cfg).__Result;
  SHARED __EE230884 := __E_First_Degree_Relative;
  SHARED __EE230932 := __E_First_Degree_Associations;
  SHARED __EE230950 := __EE230932(__T(__AND(__CN(TRUE),__AND(__OP2(__EE230932.Title_,>=,__CN(1)),__OP2(__EE230932.Title_,<=,__CN(45))))));
  SHARED __EE230952 := __EE230884 + PROJECT(__EE230950,TRANSFORM(E_First_Degree_Relative(__in,__cfg).Layout,SELF.Relative_ := LEFT.First_Degree_Association_,SELF := LEFT));
  EXPORT __ENH_First_Degree_Relative := PROJECT(TABLE(PROJECT(__EE230952,E_First_Degree_Relative(__in,__cfg).Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Subject_,Relative_,Title_,Relationship_Type_,Relationship_Confidence_,Relationship_Score_,Generation_,Relationship_Date_First_Seen_,Relationship_Date_Last_Seen_},Subject_,Relative_,Title_,Relationship_Type_,Relationship_Confidence_,Relationship_Score_,Generation_,Relationship_Date_First_Seen_,Relationship_Date_Last_Seen_,MERGE),E_First_Degree_Relative(__in,__cfg).Layout);
END;
