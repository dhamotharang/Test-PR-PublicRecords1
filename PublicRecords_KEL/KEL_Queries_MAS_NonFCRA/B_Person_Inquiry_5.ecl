//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_Inquiry_6,CFG_Compile,E_Inquiry,E_Person,E_Person_Inquiry FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_Inquiry_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Inquiry_6(__in,__cfg).__ENH_Person_Inquiry_6) __ENH_Person_Inquiry_6 := B_Person_Inquiry_6(__in,__cfg).__ENH_Person_Inquiry_6;
  SHARED __EE4790489 := __ENH_Person_Inquiry_6;
  EXPORT __ST396845_Layout := RECORD
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
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST204758_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Inquiry().Typ) Transaction_;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.ndataset(E_Person_Inquiry(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST396845_Layout) Gather_Inquiries_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST204758_Layout __ND4790475__Project(B_Person_Inquiry_6(__in,__cfg).__ST207663_Layout __PP4790206) := TRANSFORM
    __EE4790473 := __PP4790206.Gather_Inquiries_;
    __ST396845_Layout __ND4790422__Project(B_Person_Inquiry_6(__in,__cfg).__ST355128_Layout __PP4790231) := TRANSFORM
      __CC39788 := ['AUTO','AUTO - CAPTIVE'];
      SELF.Is_Auto_Srch_ := KEL.Routines.ToUpperCase(TRIM(__PP4790231.Industry_)) IN __CC39788;
      __CC39791 := ['MORTGAGE/REAL ESTATE'];
      SELF.Is_Mortgage_ := KEL.Routines.ToUpperCase(TRIM(__PP4790231.Industry_)) IN __CC39791;
      __CC39819 := ['PREPAID CARDS'];
      SELF.Is_Prepaid_Card_ := KEL.Routines.ToUpperCase(TRIM(__PP4790231.Industry_)) IN __CC39819;
      __CC39832 := ['QUIZ PROVIDER'];
      SELF.Is_Quiz_Provider_ := KEL.Routines.ToUpperCase(TRIM(__PP4790231.Industry_)) IN __CC39832;
      __CC39822 := ['RETAIL'];
      SELF.Is_Retail_ := KEL.Routines.ToUpperCase(TRIM(__PP4790231.Industry_)) IN __CC39822;
      __CC39825 := ['RETAIL PAYMENTS'];
      SELF.Is_Retail_Payment_ := KEL.Routines.ToUpperCase(TRIM(__PP4790231.Industry_)) IN __CC39825;
      __CC39835 := ['STUDENT LOANS'];
      SELF.Is_Student_Loan_ := KEL.Routines.ToUpperCase(TRIM(__PP4790231.Industry_)) IN __CC39835;
      __CC39829 := ['UTILITIES','CABLE/SATELLITE/INTERNET'];
      SELF.Is_Utility_ := KEL.Routines.ToUpperCase(TRIM(__PP4790231.Industry_)) IN __CC39829;
      __CC39764 := 1826;
      SELF.Seen___In___Five___Years_ := __OP2(__PP4790231.Agein_Days_,<=,__CN(__CC39764));
      SELF.Valid_Banking_ := __AND(__PP4790231.Valid_Inquiries_,__CN(__PP4790231.Is_Banking_));
      SELF.Valid_Communications_ := __AND(__PP4790231.Valid_Inquiries_,__CN(__PP4790231.Is_Communications_));
      SELF := __PP4790231;
    END;
    SELF.Gather_Inquiries_ := __PROJECT(__EE4790473,__ND4790422__Project(LEFT));
    SELF := __PP4790206;
  END;
  EXPORT __ENH_Person_Inquiry_5 := PROJECT(__EE4790489,__ND4790475__Project(LEFT));
END;
