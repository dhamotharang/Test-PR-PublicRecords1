﻿//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Inquiry_8,CFG_Compile,E_Inquiry,E_Person,E_Person_Inquiry,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_Inquiry_7(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Inquiry_8(__in,__cfg).__ENH_Inquiry_8) __ENH_Inquiry_8 := B_Inquiry_8(__in,__cfg).__ENH_Inquiry_8;
  SHARED VIRTUAL TYPEOF(E_Person_Inquiry(__in,__cfg).__Result) __E_Person_Inquiry := E_Person_Inquiry(__in,__cfg).__Result;
  SHARED __EE246676 := __E_Person_Inquiry;
  SHARED __EE1596678 := __ENH_Inquiry_8;
  SHARED __ST1597066_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nint Agein_Days_;
    KEL.typ.str Inquiry_Function_Description_ := '';
    KEL.typ.str Inquiry_Industry_ := '';
    KEL.typ.str Inquiry_Method_ := '';
    KEL.typ.str Inquiry_Sub_Market_ := '';
    KEL.typ.str Inquiry_Vertical_ := '';
    KEL.typ.bool Is_Batch_Monitoring_Method_ := FALSE;
    KEL.typ.bool Is_Collection_ := FALSE;
    KEL.typ.nbool Is_Fcra_Ok_;
    KEL.typ.nbool Is_Non_Fcra_Ok_;
    KEL.typ.nbool Is_Product_Code_Ok_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE1597081 := PROJECT(__EE1596678,__ST1597066_Layout);
  SHARED __ST1597117_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Inquiry().Typ) Transaction_;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.ndataset(E_Person_Inquiry(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST1597066_Layout) Inquiry_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1597114(E_Person_Inquiry(__in,__cfg).Layout __EE246676, __ST1597066_Layout __EE1597081) := __EEQP(__EE246676.Transaction_,__EE1597081.UID);
  __ST1597117_Layout __Join__ST1597117_Layout(E_Person_Inquiry(__in,__cfg).Layout __r, DATASET(__ST1597066_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Inquiry_ := __CN(__recs);
  END;
  SHARED __EE1597115 := DENORMALIZE(DISTRIBUTE(__EE246676,HASH(Transaction_)),DISTRIBUTE(__EE1597081,HASH(UID)),__JC1597114(LEFT,RIGHT),GROUP,__Join__ST1597117_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST100841_Layout := RECORD
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.str Method_ := '';
    KEL.typ.str Function_Description_ := '';
    KEL.typ.str Sub_Market_ := '';
    KEL.typ.str Vertical_ := '';
    KEL.typ.str Industry_ := '';
    KEL.typ.nkdate Inq_Date_;
    KEL.typ.nbool Is_Non_Fcra_Ok_;
    KEL.typ.nbool Is_Fcra_Ok_;
    KEL.typ.bool Is_Collection_ := FALSE;
    KEL.typ.bool Is_Batch_Monitoring_Method_ := FALSE;
    KEL.typ.nbool Is_Product_Code_Ok_;
    KEL.typ.nint Agein_Days_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST186452_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Inquiry().Typ) Transaction_;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.ndataset(E_Person_Inquiry(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST100841_Layout) Gather_Inquiries_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST186452_Layout __ND1597150__Project(__ST1597117_Layout __PP1597146) := TRANSFORM
    __EE1597144 := __PP1597146.Inquiry_;
    __ST100841_Layout __ND1597174__Project(__ST1597066_Layout __PP1597170) := TRANSFORM
      SELF.Method_ := __PP1597170.Inquiry_Method_;
      SELF.Function_Description_ := __PP1597170.Inquiry_Function_Description_;
      SELF.Sub_Market_ := __PP1597170.Inquiry_Sub_Market_;
      SELF.Vertical_ := __PP1597170.Inquiry_Vertical_;
      SELF.Industry_ := __PP1597170.Inquiry_Industry_;
      SELF.Inq_Date_ := FN_Compile(__cfg).FN_Time_Stamp_To_Date(__ECAST(KEL.typ.ntimestamp,KEL.era.EpochToNTimestamp(__PP1597170.Date_First_Seen_)));
      SELF := __PP1597170;
    END;
    SELF.Gather_Inquiries_ := __PROJECT(__EE1597144,__ND1597174__Project(LEFT));
    SELF := __PP1597146;
  END;
  EXPORT __ENH_Person_Inquiry_7 := PROJECT(__EE1597115,__ND1597150__Project(LEFT));
END;
