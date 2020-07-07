﻿//HPCC Systems KEL Compiler Version 1.3.0beta5
IMPORT KEL13 AS KEL;
IMPORT CFG_Compile,E_First_Degree_Associations,E_Person,E_Second_Degree_Associations FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Second_Degree_Associations(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_First_Degree_Associations(__in,__cfg).__Result) __E_First_Degree_Associations := E_First_Degree_Associations(__in,__cfg).__Result;
  SHARED __EE3435394 := __E_First_Degree_Associations;
  SHARED __EE6437956 := __EE3435394(__NN(__EE3435394.First_Degree_Association_));
  SHARED __EE6438222 := __EE3435394;
  SHARED __EE6438234 := __EE6438222(__NN(__EE6438222.Subject_));
  SHARED __ST3435870_Layout := RECORD
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC6438244(E_First_Degree_Associations(__in,__cfg).Layout __EE6437956, E_First_Degree_Associations(__in,__cfg).Layout __EE6438234) := __NNEQ(__EE6437956.First_Degree_Association_,__EE6438234.Subject_) AND __T(__AND(__OP2(__EE6437956.First_Degree_Association_,=,__EE6438234.Subject_),__OP2(__EE6437956.Subject_,<>,__EE6438234.First_Degree_Association_)));
  __ST3435870_Layout __JT6438244(E_First_Degree_Associations(__in,__cfg).Layout __l, E_First_Degree_Associations(__in,__cfg).Layout __r) := TRANSFORM
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
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE6438245 := JOIN(__EE6437956,__EE6438234,__JC6438244(LEFT,RIGHT),__JT6438244(LEFT,RIGHT),INNER,HASH);
  SHARED __ST3436039_Layout := RECORD
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE6438225 := __EE3435394;
  SHARED __EE6438298 := __EE6438225(__NN(__EE6438225.First_Degree_Association_) AND __NN(__EE6438225.Subject_));
  __JC6438312(__ST3435870_Layout __EE6438245, E_First_Degree_Associations(__in,__cfg).Layout __EE6438298) := __NNEQ(__EE6438245.Subject_,__EE6438298.Subject_) AND __NNEQ(__EE6438245.First_Degree_Association__1_,__EE6438298.First_Degree_Association_) AND __T(__AND(__OP2(__EE6438245.Subject_,=,__EE6438298.Subject_),__OP2(__EE6438245.First_Degree_Association__1_,=,__EE6438298.First_Degree_Association_)));
  __JF6438312(E_First_Degree_Associations(__in,__cfg).Layout __EE6438298) := __NN(__EE6438298.Subject_) OR __NN(__EE6438298.First_Degree_Association_);
  SHARED __EE6438313 := JOIN(__EE6438245,__EE6438298,__JC6438312(LEFT,RIGHT),TRANSFORM(__ST3436039_Layout,SELF:=LEFT,SELF.First_Degree_Associations_:=__JF6438312(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  SHARED __EE6438342 := __EE6438313(NOT (__EE6438313.First_Degree_Associations_));
  SHARED __EE6438476 := PROJECT(__EE6438342,__ST3435870_Layout);
  SHARED E_Second_Degree_Associations(__in,__cfg).Layout __ND6438502__Project(__ST3435870_Layout __PP6438477) := TRANSFORM
    SELF.First_Degree_Association_ := __PP6438477.Subject_;
    SELF.Second_Degree_Association_ := __PP6438477.First_Degree_Association__1_;
    SELF.Title_ := __PP6438477.Title__1_;
    SELF.Relationship_Type_ := __PP6438477.Relationship_Type__1_;
    SELF.Relationship_Confidence_ := __PP6438477.Relationship_Confidence__1_;
    SELF.Relationship_Score_ := __PP6438477.Relationship_Score__1_;
    SELF.Generation_ := __PP6438477.Generation__1_;
    SELF.Relationship_Date_First_Seen_ := __PP6438477.Relationship_Date_First_Seen__1_;
    SELF.Relationship_Date_Last_Seen_ := __PP6438477.Relationship_Date_Last_Seen__1_;
    SELF.Source_ := __PP6438477.Source__1_;
    SELF := __PP6438477;
  END;
  EXPORT __ENH_Second_Degree_Associations := PROJECT(TABLE(PROJECT(__EE6438476,__ND6438502__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,FALSE),First_Degree_Association_,Second_Degree_Association_,Title_,Relationship_Type_,Relationship_Confidence_,Relationship_Score_,Generation_,Relationship_Date_First_Seen_,Relationship_Date_Last_Seen_,Source_},First_Degree_Association_,Second_Degree_Association_,Title_,Relationship_Type_,Relationship_Confidence_,Relationship_Score_,Generation_,Relationship_Date_First_Seen_,Relationship_Date_Last_Seen_,Source_,MERGE),E_Second_Degree_Associations(__in,__cfg).Layout);
END;
