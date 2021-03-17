//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Inquiry_9,CFG_Compile,E_Inquiry,E_Person,E_Person_Inquiry,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_Inquiry_8(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Inquiry_9(__in,__cfg).__ENH_Inquiry_9) __ENH_Inquiry_9 := B_Inquiry_9(__in,__cfg).__ENH_Inquiry_9;
  SHARED VIRTUAL TYPEOF(E_Person_Inquiry(__in,__cfg).__Result) __E_Person_Inquiry := E_Person_Inquiry(__in,__cfg).__Result;
  SHARED __EE408408 := __E_Person_Inquiry;
  SHARED __EE5425103 := __ENH_Inquiry_9;
  SHARED __ST5425491_Layout := RECORD
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
  SHARED __EE5425506 := PROJECT(__EE5425103,__ST5425491_Layout);
  SHARED __ST5425542_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Inquiry().Typ) Transaction_;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.ndataset(E_Person_Inquiry(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST5425491_Layout) Inquiry_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC5425539(E_Person_Inquiry(__in,__cfg).Layout __EE408408, __ST5425491_Layout __EE5425506) := __EEQP(__EE408408.Transaction_,__EE5425506.UID);
  __ST5425542_Layout __Join__ST5425542_Layout(E_Person_Inquiry(__in,__cfg).Layout __r, DATASET(__ST5425491_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Inquiry_ := __CN(__recs);
  END;
  SHARED __EE5425540 := DENORMALIZE(DISTRIBUTE(__EE408408,HASH(Transaction_)),DISTRIBUTE(__EE5425506,HASH(UID)),__JC5425539(LEFT,RIGHT),GROUP,__Join__ST5425542_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST95705_Layout := RECORD
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
  EXPORT __ST265926_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Inquiry().Typ) Transaction_;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.ndataset(E_Person_Inquiry(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST95705_Layout) Gather_Inquiries_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST265926_Layout __ND5425575__Project(__ST5425542_Layout __PP5425571) := TRANSFORM
    __EE5425569 := __PP5425571.Inquiry_;
    __ST95705_Layout __ND5425599__Project(__ST5425491_Layout __PP5425595) := TRANSFORM
      SELF.Method_ := __PP5425595.Inquiry_Method_;
      SELF.Function_Description_ := __PP5425595.Inquiry_Function_Description_;
      SELF.Sub_Market_ := __PP5425595.Inquiry_Sub_Market_;
      SELF.Vertical_ := __PP5425595.Inquiry_Vertical_;
      SELF.Industry_ := __PP5425595.Inquiry_Industry_;
      SELF.Inq_Date_ := FN_Compile(__cfg).FN_Time_Stamp_To_Date(__ECAST(KEL.typ.ntimestamp,KEL.era.EpochToNTimestamp(__PP5425595.Date_First_Seen_)));
      SELF := __PP5425595;
    END;
    SELF.Gather_Inquiries_ := __PROJECT(__EE5425569,__ND5425599__Project(LEFT));
    SELF := __PP5425571;
  END;
  EXPORT __ENH_Person_Inquiry_8 := PROJECT(__EE5425540,__ND5425575__Project(LEFT));
END;
