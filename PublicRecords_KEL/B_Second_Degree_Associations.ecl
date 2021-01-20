﻿//HPCC Systems KEL Compiler Version 1.5.0
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_First_Degree_Associations,E_Person,E_Second_Degree_Associations FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Second_Degree_Associations(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_First_Degree_Associations(__in,__cfg).__Result) __E_First_Degree_Associations := E_First_Degree_Associations(__in,__cfg).__Result;
  SHARED __EE4652097 := __E_First_Degree_Associations;
  SHARED __EE11548837 := __EE4652097(__NN(__EE4652097.First_Degree_Association_));
  SHARED __EE11549234 := __EE4652097;
  SHARED __EE11549246 := __EE11549234(__NN(__EE11549234.Subject_));
  SHARED __ST4652573_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Person().Typ) First_Degree_Association_;
    KEL.typ.nint Title_;
    KEL.typ.nstr Relationship_Type_;
    KEL.typ.nstr Relationship_Confidence_;
    KEL.typ.nint Relationship_Score_;
    KEL.typ.nstr Generation_;
    KEL.typ.nstr Relationship_Date_First_Seen_;
    KEL.typ.nstr Relationship_Date_Last_Seen_;
    KEL.typ.nstr Source_;
    KEL.typ.ntyp(E_Person().Typ) Subject__1_;
    KEL.typ.ntyp(E_Person().Typ) First_Degree_Association__1_;
    KEL.typ.nint Title__1_;
    KEL.typ.nstr Relationship_Type__1_;
    KEL.typ.nstr Relationship_Confidence__1_;
    KEL.typ.nint Relationship_Score__1_;
    KEL.typ.nstr Generation__1_;
    KEL.typ.nstr Relationship_Date_First_Seen__1_;
    KEL.typ.nstr Relationship_Date_Last_Seen__1_;
    KEL.typ.nstr Source__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC11549256(E_First_Degree_Associations(__in,__cfg).Layout __EE11548837, E_First_Degree_Associations(__in,__cfg).Layout __EE11549246) := __NNEQ(__EE11548837.First_Degree_Association_,__EE11549246.Subject_) AND __T(__AND(__OP2(__EE11548837.First_Degree_Association_,=,__EE11549246.Subject_),__OP2(__EE11548837.Subject_,<>,__EE11549246.First_Degree_Association_)));
  __ST4652573_Layout __JT11549256(E_First_Degree_Associations(__in,__cfg).Layout __l, E_First_Degree_Associations(__in,__cfg).Layout __r) := TRANSFORM
    SELF.Subject__1_ := __r.Subject_;
    SELF.First_Degree_Association__1_ := __r.First_Degree_Association_;
    SELF.Title__1_ := __r.Title_;
    SELF.Relationship_Type__1_ := __r.Relationship_Type_;
    SELF.Relationship_Confidence__1_ := __r.Relationship_Confidence_;
    SELF.Relationship_Score__1_ := __r.Relationship_Score_;
    SELF.Generation__1_ := __r.Generation_;
    SELF.Relationship_Date_First_Seen__1_ := __r.Relationship_Date_First_Seen_;
    SELF.Relationship_Date_Last_Seen__1_ := __r.Relationship_Date_Last_Seen_;
    SELF.Source__1_ := __r.Source_;
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE11549257 := JOIN(__EE11548837,__EE11549246,__JC11549256(LEFT,RIGHT),__JT11549256(LEFT,RIGHT),INNER,HASH);
  SHARED __ST4652742_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Person().Typ) First_Degree_Association_;
    KEL.typ.nint Title_;
    KEL.typ.nstr Relationship_Type_;
    KEL.typ.nstr Relationship_Confidence_;
    KEL.typ.nint Relationship_Score_;
    KEL.typ.nstr Generation_;
    KEL.typ.nstr Relationship_Date_First_Seen_;
    KEL.typ.nstr Relationship_Date_Last_Seen_;
    KEL.typ.nstr Source_;
    KEL.typ.ntyp(E_Person().Typ) Subject__1_;
    KEL.typ.ntyp(E_Person().Typ) First_Degree_Association__1_;
    KEL.typ.nint Title__1_;
    KEL.typ.nstr Relationship_Type__1_;
    KEL.typ.nstr Relationship_Confidence__1_;
    KEL.typ.nint Relationship_Score__1_;
    KEL.typ.nstr Generation__1_;
    KEL.typ.nstr Relationship_Date_First_Seen__1_;
    KEL.typ.nstr Relationship_Date_Last_Seen__1_;
    KEL.typ.nstr Source__1_;
    KEL.typ.bool First_Degree_Associations_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE11549237 := __EE4652097;
  SHARED __EE11549310 := __EE11549237(__NN(__EE11549237.First_Degree_Association_) AND __NN(__EE11549237.Subject_));
  __JC11549324(__ST4652573_Layout __EE11549257, E_First_Degree_Associations(__in,__cfg).Layout __EE11549310) := __NNEQ(__EE11549257.Subject_,__EE11549310.Subject_) AND __NNEQ(__EE11549257.First_Degree_Association__1_,__EE11549310.First_Degree_Association_) AND __T(__AND(__OP2(__EE11549257.Subject_,=,__EE11549310.Subject_),__OP2(__EE11549257.First_Degree_Association__1_,=,__EE11549310.First_Degree_Association_)));
  __JF11549324(E_First_Degree_Associations(__in,__cfg).Layout __EE11549310) := __NN(__EE11549310.Subject_) OR __NN(__EE11549310.First_Degree_Association_);
  SHARED __EE11549325 := JOIN(__EE11549257,__EE11549310,__JC11549324(LEFT,RIGHT),TRANSFORM(__ST4652742_Layout,SELF:=LEFT,SELF.First_Degree_Associations_:=__JF11549324(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  SHARED __EE11549354 := __EE11549325(NOT (__EE11549325.First_Degree_Associations_));
  SHARED __EE11549488 := PROJECT(__EE11549354,__ST4652573_Layout);
  SHARED E_Second_Degree_Associations(__in,__cfg).Layout __ND11549514__Project(__ST4652573_Layout __PP11549489) := TRANSFORM
    SELF.First_Degree_Association_ := __PP11549489.Subject_;
    SELF.Second_Degree_Association_ := __PP11549489.First_Degree_Association__1_;
    SELF.Title_ := __PP11549489.Title__1_;
    SELF.Relationship_Type_ := __PP11549489.Relationship_Type__1_;
    SELF.Relationship_Confidence_ := __PP11549489.Relationship_Confidence__1_;
    SELF.Relationship_Score_ := __PP11549489.Relationship_Score__1_;
    SELF.Generation_ := __PP11549489.Generation__1_;
    SELF.Relationship_Date_First_Seen_ := __PP11549489.Relationship_Date_First_Seen__1_;
    SELF.Relationship_Date_Last_Seen_ := __PP11549489.Relationship_Date_Last_Seen__1_;
    SELF.Source_ := __PP11549489.Source__1_;
    SELF := __PP11549489;
  END;
  EXPORT __ENH_Second_Degree_Associations := PROJECT(TABLE(PROJECT(__EE11549488,__ND11549514__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),First_Degree_Association_,Second_Degree_Association_,Title_,Relationship_Type_,Relationship_Confidence_,Relationship_Score_,Generation_,Relationship_Date_First_Seen_,Relationship_Date_Last_Seen_,Source_},First_Degree_Association_,Second_Degree_Association_,Title_,Relationship_Type_,Relationship_Confidence_,Relationship_Score_,Generation_,Relationship_Date_First_Seen_,Relationship_Date_Last_Seen_,Source_,MERGE),E_Second_Degree_Associations(__in,__cfg).Layout);
END;
