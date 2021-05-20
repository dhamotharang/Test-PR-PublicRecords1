//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person_Inquiry_6,CFG_Compile,E_Inquiry,E_Person,E_Person_Inquiry FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_Inquiry_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Inquiry_6(__in,__cfg).__ENH_Person_Inquiry_6) __ENH_Person_Inquiry_6 := B_Person_Inquiry_6(__in,__cfg).__ENH_Person_Inquiry_6;
  SHARED __EE1641051 := __ENH_Person_Inquiry_6;
  EXPORT __ST282334_Layout := RECORD
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
    KEL.typ.nbool Valid_Inquiries_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST178886_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Inquiry().Typ) Transaction_;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.ndataset(E_Person_Inquiry(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST282334_Layout) Gather_Inquiries_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST178886_Layout __ND1641037__Project(B_Person_Inquiry_6(__in,__cfg).__ST180958_Layout __PP1640770) := TRANSFORM
    __EE1641035 := __PP1640770.Gather_Inquiries_;
    __ST282334_Layout __ND1640991__Project(B_Person_Inquiry_6(__in,__cfg).__ST256699_Layout __PP1640795) := TRANSFORM
      __CC40360 := ['AUTO','AUTO - CAPTIVE'];
      SELF.Is_Auto_Srch_ := KEL.Routines.ToUpperCase(TRIM(__PP1640795.Industry_)) IN __CC40360;
      __CC40385 := ['BANKING','CARDS','CREDIT DECISIONING','CREDIT MONITORING','CREDIT UNION','FINANCE COMPANY','FS SERVICES PROVIDER','INVESTMENTS/SECURITIES','COMMERCIAL LENDING'];
      SELF.Is_Banking_ := KEL.Routines.ToUpperCase(TRIM(__PP1640795.Industry_)) IN __CC40385;
      __CC40388 := ['COMMUNICATIONS'];
      SELF.Is_Communications_ := KEL.Routines.ToUpperCase(TRIM(__PP1640795.Industry_)) IN __CC40388;
      __CC40363 := ['MORTGAGE/REAL ESTATE'];
      SELF.Is_Mortgage_ := KEL.Routines.ToUpperCase(TRIM(__PP1640795.Industry_)) IN __CC40363;
      __CC40391 := ['PREPAID CARDS'];
      SELF.Is_Prepaid_Card_ := KEL.Routines.ToUpperCase(TRIM(__PP1640795.Industry_)) IN __CC40391;
      __CC40404 := ['QUIZ PROVIDER'];
      SELF.Is_Quiz_Provider_ := KEL.Routines.ToUpperCase(TRIM(__PP1640795.Industry_)) IN __CC40404;
      __CC40394 := ['RETAIL'];
      SELF.Is_Retail_ := KEL.Routines.ToUpperCase(TRIM(__PP1640795.Industry_)) IN __CC40394;
      __CC40397 := ['RETAIL PAYMENTS'];
      SELF.Is_Retail_Payment_ := KEL.Routines.ToUpperCase(TRIM(__PP1640795.Industry_)) IN __CC40397;
      __CC40407 := ['STUDENT LOANS'];
      SELF.Is_Student_Loan_ := KEL.Routines.ToUpperCase(TRIM(__PP1640795.Industry_)) IN __CC40407;
      __CC40401 := ['UTILITIES','CABLE/SATELLITE/INTERNET'];
      SELF.Is_Utility_ := KEL.Routines.ToUpperCase(TRIM(__PP1640795.Industry_)) IN __CC40401;
      SELF.Valid_Inquiries_ := __AND(__AND(__AND(__AND(__PP1640795.Is_Non_Fcra_Ok_,__CN(NOT (__PP1640795.Is_Batch_Monitoring_Method_))),__CN(__PP1640795.Exclude_Function_Description_)),__CN(NOT (__PP1640795.Is_Collection_))),__CN(NOT (__PP1640795.Is_High_Risk_)));
      SELF := __PP1640795;
    END;
    SELF.Gather_Inquiries_ := __PROJECT(__EE1641035,__ND1640991__Project(LEFT));
    SELF := __PP1640770;
  END;
  EXPORT __ENH_Person_Inquiry_5 := PROJECT(__EE1641051,__ND1641037__Project(LEFT));
END;
