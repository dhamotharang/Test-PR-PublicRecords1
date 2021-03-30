//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_Inquiry_5,CFG_Compile,E_Inquiry,E_Person,E_Person_Inquiry FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_Inquiry_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Inquiry_5(__in,__cfg).__ENH_Person_Inquiry_5) __ENH_Person_Inquiry_5 := B_Person_Inquiry_5(__in,__cfg).__ENH_Person_Inquiry_5;
  SHARED __EE5970504 := __ENH_Person_Inquiry_5;
  EXPORT __ST785145_Layout := RECORD
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
    KEL.typ.bool Is_Auto_Srch_ := FALSE;
    KEL.typ.bool Is_Banking_ := FALSE;
    KEL.typ.bool Is_Communications_ := FALSE;
    KEL.typ.bool Is_High_Risk_ := FALSE;
    KEL.typ.bool Is_Mortgage_ := FALSE;
    KEL.typ.bool Is_Other_ := FALSE;
    KEL.typ.bool Is_Prepaid_Card_ := FALSE;
    KEL.typ.bool Is_Quiz_Provider_ := FALSE;
    KEL.typ.bool Is_Retail_ := FALSE;
    KEL.typ.bool Is_Retail_Payment_ := FALSE;
    KEL.typ.bool Is_Student_Loan_ := FALSE;
    KEL.typ.bool Is_Utility_ := FALSE;
    KEL.typ.nbool Seen___In___Five___Years_;
    KEL.typ.nbool Valid_Banking_;
    KEL.typ.nbool Valid_Communications_;
    KEL.typ.nbool Valid_Inquiries_;
    KEL.typ.nbool Valid_Retail_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST253079_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Inquiry().Typ) Transaction_;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.ndataset(E_Person_Inquiry(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST785145_Layout) Gather_Inquiries_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST253079_Layout __ND5970490__Project(B_Person_Inquiry_5(__in,__cfg).__ST259966_Layout __PP5970204) := TRANSFORM
    __EE5970488 := __PP5970204.Gather_Inquiries_;
    __ST785145_Layout __ND5970439__Project(B_Person_Inquiry_5(__in,__cfg).__ST591945_Layout __PP5970229) := TRANSFORM
      SELF.Is_Other_ := NOT (__PP5970229.Is_Banking_ OR __PP5970229.Is_Auto_Srch_ OR __PP5970229.Is_Retail_ OR __PP5970229.Is_Mortgage_ OR __PP5970229.Is_Utility_ OR __PP5970229.Is_Prepaid_Card_ OR __PP5970229.Is_Communications_ OR __PP5970229.Is_Student_Loan_ OR __PP5970229.Is_Retail_Payment_ OR __PP5970229.Is_Quiz_Provider_);
      SELF.Valid_Retail_ := __AND(__PP5970229.Valid_Inquiries_,__CN(__PP5970229.Is_Retail_));
      SELF := __PP5970229;
    END;
    SELF.Gather_Inquiries_ := __PROJECT(__EE5970488,__ND5970439__Project(LEFT));
    SELF := __PP5970204;
  END;
  EXPORT __ENH_Person_Inquiry_4 := PROJECT(__EE5970504,__ND5970490__Project(LEFT));
END;
