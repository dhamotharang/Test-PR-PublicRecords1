//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Inquiry_9,CFG_Compile,E_Inquiry,E_Person,E_Person_Inquiry,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_Inquiry_8(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Inquiry_9(__in,__cfg).__ENH_Inquiry_9) __ENH_Inquiry_9 := B_Inquiry_9(__in,__cfg).__ENH_Inquiry_9;
  SHARED VIRTUAL TYPEOF(E_Person_Inquiry(__in,__cfg).__Result) __E_Person_Inquiry := E_Person_Inquiry(__in,__cfg).__Result;
  SHARED __EE408438 := __E_Person_Inquiry;
  SHARED __EE5423517 := __ENH_Inquiry_9;
  SHARED __ST5423905_Layout := RECORD
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
  SHARED __EE5423920 := PROJECT(__EE5423517,__ST5423905_Layout);
  SHARED __ST5423956_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Inquiry().Typ) Transaction_;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.ndataset(E_Person_Inquiry(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST5423905_Layout) Inquiry_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC5423953(E_Person_Inquiry(__in,__cfg).Layout __EE408438, __ST5423905_Layout __EE5423920) := __EEQP(__EE408438.Transaction_,__EE5423920.UID);
  __ST5423956_Layout __Join__ST5423956_Layout(E_Person_Inquiry(__in,__cfg).Layout __r, DATASET(__ST5423905_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Inquiry_ := __CN(__recs);
  END;
  SHARED __EE5423954 := DENORMALIZE(DISTRIBUTE(__EE408438,HASH(Transaction_)),DISTRIBUTE(__EE5423920,HASH(UID)),__JC5423953(LEFT,RIGHT),GROUP,__Join__ST5423956_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST95717_Layout := RECORD
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
  EXPORT __ST265956_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Inquiry().Typ) Transaction_;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.ndataset(E_Person_Inquiry(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST95717_Layout) Gather_Inquiries_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST265956_Layout __ND5423989__Project(__ST5423956_Layout __PP5423985) := TRANSFORM
    __EE5423983 := __PP5423985.Inquiry_;
    __ST95717_Layout __ND5424013__Project(__ST5423905_Layout __PP5424009) := TRANSFORM
      SELF.Method_ := __PP5424009.Inquiry_Method_;
      SELF.Function_Description_ := __PP5424009.Inquiry_Function_Description_;
      SELF.Sub_Market_ := __PP5424009.Inquiry_Sub_Market_;
      SELF.Vertical_ := __PP5424009.Inquiry_Vertical_;
      SELF.Industry_ := __PP5424009.Inquiry_Industry_;
      SELF.Inq_Date_ := FN_Compile(__cfg).FN_Time_Stamp_To_Date(__ECAST(KEL.typ.ntimestamp,KEL.era.EpochToNTimestamp(__PP5424009.Date_First_Seen_)));
      SELF := __PP5424009;
    END;
    SELF.Gather_Inquiries_ := __PROJECT(__EE5423983,__ND5424013__Project(LEFT));
    SELF := __PP5423985;
  END;
  EXPORT __ENH_Person_Inquiry_8 := PROJECT(__EE5423954,__ND5423989__Project(LEFT));
END;
