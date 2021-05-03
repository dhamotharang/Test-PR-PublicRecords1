//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person_Inquiry_7,CFG_Compile,E_Inquiry,E_Person,E_Person_Inquiry FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_Inquiry_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Inquiry_7(__in,__cfg).__ENH_Person_Inquiry_7) __ENH_Person_Inquiry_7 := B_Person_Inquiry_7(__in,__cfg).__ENH_Person_Inquiry_7;
  SHARED __EE1630072 := __ENH_Person_Inquiry_7;
  EXPORT __ST254525_Layout := RECORD
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
    KEL.typ.bool Is_Banking_ := FALSE;
    KEL.typ.bool Is_Communications_ := FALSE;
    KEL.typ.bool Is_High_Risk_ := FALSE;
    KEL.typ.nbool Valid_Inquiries_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST175282_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Inquiry().Typ) Transaction_;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.ndataset(E_Person_Inquiry(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST254525_Layout) Gather_Inquiries_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST175282_Layout __ND1630058__Project(B_Person_Inquiry_7(__in,__cfg).__ST176588_Layout __PP1629855) := TRANSFORM
    __EE1630056 := __PP1629855.Gather_Inquiries_;
    __ST254525_Layout __ND1630020__Project(B_Person_Inquiry_7(__in,__cfg).__ST234540_Layout __PP1629880) := TRANSFORM
      __CC39813 := ['BANKING','CARDS','CREDIT DECISIONING','CREDIT MONITORING','CREDIT UNION','FINANCE COMPANY','FS SERVICES PROVIDER','INVESTMENTS/SECURITIES','COMMERCIAL LENDING'];
      SELF.Is_Banking_ := KEL.Routines.ToUpperCase(TRIM(__PP1629880.Industry_)) IN __CC39813;
      __CC39816 := ['COMMUNICATIONS'];
      SELF.Is_Communications_ := KEL.Routines.ToUpperCase(TRIM(__PP1629880.Industry_)) IN __CC39816;
      SELF.Valid_Inquiries_ := __AND(__AND(__AND(__AND(__PP1629880.Is_Non_Fcra_Ok_,__CN(NOT (__PP1629880.Is_Batch_Monitoring_Method_))),__CN(__PP1629880.Exclude_Function_Description_)),__CN(NOT (__PP1629880.Is_Collection_))),__CN(NOT (__PP1629880.Is_High_Risk_)));
      SELF := __PP1629880;
    END;
    SELF.Gather_Inquiries_ := __PROJECT(__EE1630056,__ND1630020__Project(LEFT));
    SELF := __PP1629855;
  END;
  EXPORT __ENH_Person_Inquiry_6 := PROJECT(__EE1630072,__ND1630058__Project(LEFT));
END;
