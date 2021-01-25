//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_Inquiry_7,CFG_Compile,E_Inquiry,E_Person,E_Person_Inquiry FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_Inquiry_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Inquiry_7(__in,__cfg).__ENH_Person_Inquiry_7) __ENH_Person_Inquiry_7 := B_Person_Inquiry_7(__in,__cfg).__ENH_Person_Inquiry_7;
  SHARED __EE4874905 := __ENH_Person_Inquiry_7;
  EXPORT __ST429452_Layout := RECORD
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
  EXPORT __ST246611_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Inquiry().Typ) Transaction_;
    KEL.typ.nstr Transaction_I_D_;
    KEL.typ.nstr Sequence_Number_;
    KEL.typ.ndataset(E_Person_Inquiry(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST429452_Layout) Gather_Inquiries_;
    KEL.typ.timestamp Archive___Date_ := 0;
    KEL.typ.timestamp Date_First_Seen_ := 0;
    KEL.typ.timestamp Date_Last_Seen_ := 0;
    KEL.typ.timestamp Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST246611_Layout __ND4874891__Project(B_Person_Inquiry_7(__in,__cfg).__ST250118_Layout __PP4874688) := TRANSFORM
    __EE4874889 := __PP4874688.Gather_Inquiries_;
    __ST429452_Layout __ND4874853__Project(B_Person_Inquiry_7(__in,__cfg).__ST378523_Layout __PP4874713) := TRANSFORM
      __CC31844 := ['BANKING','CARDS','CREDIT DECISIONING','CREDIT MONITORING','CREDIT UNION','FINANCE COMPANY','FS SERVICES PROVIDER','INVESTMENTS/SECURITIES','COMMERCIAL LENDING'];
      SELF.Is_Banking_ := KEL.Routines.ToUpperCase(TRIM(__PP4874713.Industry_)) IN __CC31844;
      __CC31847 := ['COMMUNICATIONS'];
      SELF.Is_Communications_ := KEL.Routines.ToUpperCase(TRIM(__PP4874713.Industry_)) IN __CC31847;
      SELF.Valid_Inquiries_ := __AND(__AND(__AND(__AND(__PP4874713.Is_Non_Fcra_Ok_,__CN(NOT (__PP4874713.Is_Batch_Monitoring_Method_))),__CN(__PP4874713.Exclude_Function_Description_)),__CN(NOT (__PP4874713.Is_Collection_))),__CN(NOT (__PP4874713.Is_High_Risk_)));
      SELF := __PP4874713;
    END;
    SELF.Gather_Inquiries_ := __PROJECT(__EE4874889,__ND4874853__Project(LEFT));
    SELF := __PP4874688;
  END;
  EXPORT __ENH_Person_Inquiry_6 := PROJECT(__EE4874905,__ND4874891__Project(LEFT));
END;
