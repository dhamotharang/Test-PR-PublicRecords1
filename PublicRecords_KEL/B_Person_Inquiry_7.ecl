//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_Inquiry_8,CFG_Compile,E_Inquiry,E_Person,E_Person_Inquiry FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_Inquiry_7(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Inquiry_8(__in,__cfg).__ENH_Person_Inquiry_8) __ENH_Person_Inquiry_8 := B_Person_Inquiry_8(__in,__cfg).__ENH_Person_Inquiry_8;
  SHARED __EE5474013 := __ENH_Person_Inquiry_8;
  EXPORT __ST442534_Layout := RECORD
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
  EXPORT __ST264706_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Inquiry().Typ) Transaction_;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.ndataset(E_Person_Inquiry(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST442534_Layout) Gather_Inquiries_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST264706_Layout __ND5474018__Project(B_Person_Inquiry_8(__in,__cfg).__ST267518_Layout __PP5474014) := TRANSFORM
    __EE5474038 := __PP5474014.Gather_Inquiries_;
    __ST442534_Layout __ND5474043__Project(B_Person_Inquiry_8(__in,__cfg).__ST97043_Layout __PP5474039) := TRANSFORM
      SELF.Exclude_Function_Description_ := KEL.Routines.ToUpperCase(TRIM(__PP5474039.Function_Description_)) <> 'BANKO BATCH';
      __CC34076 := ['CARDS - SUBPRIME','MSB','REFUND ANTICIPATION LOAN','RENT TO OWN','PAYDAY LOANS','PAY DAY LOANS','TITLE LOANS','PAY DAY','PAYDAY'];
      SELF.Is_High_Risk_ := KEL.Routines.ToUpperCase(TRIM(__PP5474039.Industry_)) IN __CC34076;
      SELF := __PP5474039;
    END;
    SELF.Gather_Inquiries_ := __PROJECT(__EE5474038,__ND5474043__Project(LEFT));
    SELF := __PP5474014;
  END;
  EXPORT __ENH_Person_Inquiry_7 := PROJECT(__EE5474013,__ND5474018__Project(LEFT));
END;
