//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_Inquiry_4,CFG_Compile,E_Inquiry,E_Person,E_Person_Inquiry FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_Inquiry_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Inquiry_4(__in,__cfg).__ENH_Person_Inquiry_4) __ENH_Person_Inquiry_4 := B_Person_Inquiry_4(__in,__cfg).__ENH_Person_Inquiry_4;
  SHARED __EE6386900 := __ENH_Person_Inquiry_4;
  EXPORT __ST1172438_Layout := RECORD
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.str Method_ := '';
    KEL.typ.nint Product_Code_;
    KEL.typ.str Function_Description_ := '';
    KEL.typ.str Sub_Market_ := '';
    KEL.typ.str Vertical_ := '';
    KEL.typ.str Industry_ := '';
    KEL.typ.nkdate Inq_Date_;
    KEL.typ.nbool Is_Non_Fcra_Ok_;
    KEL.typ.nbool Is_Fcra_Ok_;
    KEL.typ.bool Is_Collection_ := FALSE;
    KEL.typ.bool Is_Batch_Monitoring_Method_ := FALSE;
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
    KEL.typ.nbool Valid_Auto_Srch_;
    KEL.typ.nbool Valid_Banking_;
    KEL.typ.nbool Valid_Collection_;
    KEL.typ.nbool Valid_Communications_;
    KEL.typ.nbool Valid_High_Risk_;
    KEL.typ.nbool Valid_Inquiries_;
    KEL.typ.nbool Valid_Mortgage_;
    KEL.typ.nbool Valid_Other_;
    KEL.typ.nbool Valid_Prepaid_Card_;
    KEL.typ.nbool Valid_Quiz_Provider_;
    KEL.typ.nbool Valid_Retail_;
    KEL.typ.nbool Valid_Retail_Payment_;
    KEL.typ.nbool Valid_Student_Loan_;
    KEL.typ.nbool Valid_Utility_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST230668_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Inquiry().Typ) Transaction_;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.ndataset(E_Person_Inquiry(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST1172438_Layout) Gather_Inquiries_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST230668_Layout __ND6386886__Project(B_Person_Inquiry_4(__in,__cfg).__ST241846_Layout __PP6386504) := TRANSFORM
    __EE6386884 := __PP6386504.Gather_Inquiries_;
    __ST1172438_Layout __ND6386797__Project(B_Person_Inquiry_4(__in,__cfg).__ST712713_Layout __PP6386529) := TRANSFORM
      SELF.Valid_Auto_Srch_ := __AND(__PP6386529.Valid_Inquiries_,__CN(__PP6386529.Is_Auto_Srch_));
      SELF.Valid_Collection_ := __AND(__AND(__AND(__PP6386529.Is_Non_Fcra_Ok_,__CN(__PP6386529.Is_Batch_Monitoring_Method_)),__CN(__PP6386529.Exclude_Function_Description_)),__CN(__PP6386529.Is_Collection_));
      SELF.Valid_High_Risk_ := __AND(__AND(__AND(__AND(__PP6386529.Is_Non_Fcra_Ok_,__CN(__PP6386529.Is_High_Risk_)),__CN(NOT (__PP6386529.Is_Batch_Monitoring_Method_))),__CN(__PP6386529.Exclude_Function_Description_)),__CN(NOT (__PP6386529.Is_Collection_)));
      SELF.Valid_Mortgage_ := __AND(__PP6386529.Valid_Inquiries_,__CN(__PP6386529.Is_Mortgage_));
      SELF.Valid_Other_ := __AND(__PP6386529.Valid_Inquiries_,__CN(__PP6386529.Is_Other_));
      SELF.Valid_Prepaid_Card_ := __AND(__PP6386529.Valid_Inquiries_,__CN(__PP6386529.Is_Prepaid_Card_));
      SELF.Valid_Quiz_Provider_ := __AND(__PP6386529.Valid_Inquiries_,__CN(__PP6386529.Is_Quiz_Provider_));
      SELF.Valid_Retail_Payment_ := __AND(__PP6386529.Valid_Inquiries_,__CN(__PP6386529.Is_Retail_Payment_));
      SELF.Valid_Student_Loan_ := __AND(__PP6386529.Valid_Inquiries_,__CN(__PP6386529.Is_Student_Loan_));
      SELF.Valid_Utility_ := __AND(__PP6386529.Valid_Inquiries_,__CN(__PP6386529.Is_Utility_));
      SELF := __PP6386529;
    END;
    SELF.Gather_Inquiries_ := __PROJECT(__EE6386884,__ND6386797__Project(LEFT));
    SELF := __PP6386504;
  END;
  EXPORT __ENH_Person_Inquiry_3 := PROJECT(__EE6386900,__ND6386886__Project(LEFT));
END;
