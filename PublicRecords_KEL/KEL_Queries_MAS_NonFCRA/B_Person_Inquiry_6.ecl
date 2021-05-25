//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person_Inquiry_7,CFG_Compile,E_Inquiry,E_Person,E_Person_Inquiry FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_Inquiry_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Inquiry_7(__in,__cfg).__ENH_Person_Inquiry_7) __ENH_Person_Inquiry_7 := B_Person_Inquiry_7(__in,__cfg).__ENH_Person_Inquiry_7;
  SHARED __EE1611058 := __ENH_Person_Inquiry_7;
  EXPORT __ST260996_Layout := RECORD
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
    KEL.typ.bool Exclude_Function_Description_ := FALSE;
    KEL.typ.bool Is_High_Risk_ := FALSE;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST185237_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Inquiry().Typ) Transaction_;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.ndataset(E_Person_Inquiry(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST260996_Layout) Gather_Inquiries_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST185237_Layout __ND1611063__Project(B_Person_Inquiry_7(__in,__cfg).__ST186452_Layout __PP1611059) := TRANSFORM
    __EE1611083 := __PP1611059.Gather_Inquiries_;
    __ST260996_Layout __ND1611088__Project(B_Person_Inquiry_7(__in,__cfg).__ST100841_Layout __PP1611084) := TRANSFORM
      SELF.Exclude_Function_Description_ := KEL.Routines.ToUpperCase(TRIM(__PP1611084.Function_Description_)) <> 'BANKO BATCH';
      __CC41548 := ['CARDS - SUBPRIME','MSB','REFUND ANTICIPATION LOAN','RENT TO OWN','PAYDAY LOANS','PAY DAY LOANS','TITLE LOANS','PAY DAY','PAYDAY'];
      SELF.Is_High_Risk_ := KEL.Routines.ToUpperCase(TRIM(__PP1611084.Industry_)) IN __CC41548;
      SELF := __PP1611084;
    END;
    SELF.Gather_Inquiries_ := __PROJECT(__EE1611083,__ND1611088__Project(LEFT));
    SELF := __PP1611059;
  END;
  EXPORT __ENH_Person_Inquiry_6 := PROJECT(__EE1611058,__ND1611063__Project(LEFT));
END;
