//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_U_C_C_11,CFG_Compile,E_U_C_C,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_U_C_C_10(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_U_C_C_11(__in,__cfg).__ENH_U_C_C_11) __ENH_U_C_C_11 := B_U_C_C_11(__in,__cfg).__ENH_U_C_C_11;
  SHARED __EE1879193 := __ENH_U_C_C_11;
  EXPORT __ST220695_Layout := RECORD
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.nstr Filing_Jurisdiction_;
    KEL.typ.nstr Filing_Number_;
    KEL.typ.nstr Filing_Type_;
    KEL.typ.nkdate Filing_Date_;
    KEL.typ.nkdate Original_Filing_Date_;
    KEL.typ.nstr Filing_Status_;
    KEL.typ.nstr Filing_Time_;
    KEL.typ.nstr Status_Type_;
    KEL.typ.nstr Filing_Agency_;
    KEL.typ.nkdate Expiration_Date_;
    KEL.typ.nstr Contract_Type_;
    KEL.typ.nkdate Vendor_Entry_Date_;
    KEL.typ.nkdate Vendor_Update_Date_;
    KEL.typ.nstr Statements_Filed_;
    KEL.typ.nstr Foreign_Flag_;
    KEL.typ.nkdate Process_Date_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.str Filing_Type_Filtered_ := '';
    KEL.typ.str Inferred_Status_ := '';
    KEL.typ.bool Initial_Filing_ := FALSE;
    KEL.typ.nkdate Max_Filing_Date_;
    KEL.typ.str Status_Type_Filtered_ := '';
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST104412_Layout := RECORD
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.nkdate Max_Filing_Date_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.str Filing_Type_Filtered_ := '';
    KEL.typ.bool Initial_Filing_ := FALSE;
    KEL.typ.str Status_Type_Filtered_ := '';
    KEL.typ.str Inferred_Status_ := '';
    KEL.typ.nint Filing_Date_Non_Null_;
    KEL.typ.nstr Filing_Time_Non_Null_;
    KEL.typ.nint Vendor_Entry_Date_Non_Null_;
    KEL.typ.nstr Filing_Number_Non_Null_;
    KEL.typ.nstr Filing_Type_;
    KEL.typ.nkdate Filing_Date_;
    KEL.typ.nkdate Original_Filing_Date_;
    KEL.typ.nstr Filing_Status_;
    KEL.typ.nstr Status_Type_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST220691_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ndataset(__ST220695_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Collateral_Layout) Collateral_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST104412_Layout) Best_U_C_C_Child_Record_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST220691_Layout __ND1879159__Project(B_U_C_C_11(__in,__cfg).__ST220920_Layout __PP1878518) := TRANSFORM
    __EE1879196 := __PP1878518.Sub_Filing_;
    SELF.Sub_Filing_ := __BN(PROJECT(__T(__EE1879196),__ST220695_Layout),__NL(__EE1879196));
    __EE1879039 := __PP1878518.Sub_Filing_;
    __CC13306 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('ucc_build_version'))),__CN(__cfg.CurrentDate));
    __BS1879040 := __T(__EE1879039);
    __EE1879050 := __BS1879040(__T(__OP2(KEL.Routines.MaxN(__T(__EE1879039).Filing_Date_,__T(__EE1879039).Original_Filing_Date_),<,__CC13306)));
    __ST104412_Layout __ND1879055__Project(B_U_C_C_11(__in,__cfg).__ST220924_Layout __PP1879051) := TRANSFORM
      SELF.Max_Filing_Date_ := KEL.Routines.MaxN(__PP1879051.Filing_Date_,__PP1879051.Original_Filing_Date_);
      SELF.Filing_Date_Non_Null_ := IF(__T(__NT(__PP1879051.Filing_Date_)),__ECAST(KEL.typ.nint,__CN(-99999)),__ECAST(KEL.typ.nint,KEL.Routines.NIntegerFromNDate(__PP1879051.Filing_Date_)));
      SELF.Filing_Time_Non_Null_ := IF(__T(__NT(__PP1879051.Filing_Time_)),__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99999))),__ECAST(KEL.typ.nstr,__PP1879051.Filing_Time_));
      SELF.Vendor_Entry_Date_Non_Null_ := IF(__T(__NT(__PP1879051.Vendor_Entry_Date_)),__ECAST(KEL.typ.nint,__CN(-99999)),__ECAST(KEL.typ.nint,KEL.Routines.NIntegerFromNDate(__PP1879051.Vendor_Entry_Date_)));
      SELF.Filing_Number_Non_Null_ := IF(__T(__NT(__PP1879051.Filing_Number_)),__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(-99999))),__ECAST(KEL.typ.nstr,__PP1879051.Filing_Number_));
      SELF := __PP1879051;
    END;
    __EE1879153 := PROJECT(TABLE(PROJECT(__EE1879050,__ND1879055__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),R_M_S_I_D_,Max_Filing_Date_,Age_In_Days_,Filing_Type_Filtered_,Initial_Filing_,Status_Type_Filtered_,Inferred_Status_,Filing_Date_Non_Null_,Filing_Time_Non_Null_,Vendor_Entry_Date_Non_Null_,Filing_Number_Non_Null_,Filing_Type_,Filing_Date_,Original_Filing_Date_,Filing_Status_,Status_Type_},R_M_S_I_D_,Max_Filing_Date_,Age_In_Days_,Filing_Type_Filtered_,Initial_Filing_,Status_Type_Filtered_,Inferred_Status_,Filing_Date_Non_Null_,Filing_Time_Non_Null_,Vendor_Entry_Date_Non_Null_,Filing_Number_Non_Null_,Filing_Type_,Filing_Date_,Original_Filing_Date_,Filing_Status_,Status_Type_,MERGE),__ST104412_Layout);
    __EE1879157 := TOPN(__EE1879153(__NN(__EE1879153.Filing_Date_Non_Null_) AND __NN(__EE1879153.Filing_Time_Non_Null_) AND __NN(__EE1879153.Vendor_Entry_Date_Non_Null_) AND __NN(__EE1879153.Filing_Number_Non_Null_) AND __NN(__EE1879153.R_M_S_I_D_)),1, -__T(__EE1879153.Filing_Date_Non_Null_), -__T(__EE1879153.Filing_Time_Non_Null_), -__T(__EE1879153.Vendor_Entry_Date_Non_Null_), -__T(__EE1879153.Filing_Number_Non_Null_), -__T(__EE1879153.R_M_S_I_D_),__T(Filing_Type_),__T(Filing_Date_),__T(Original_Filing_Date_),__T(Filing_Status_),__T(Status_Type_),__T(Max_Filing_Date_),__T(Age_In_Days_),Filing_Type_Filtered_,Initial_Filing_,Status_Type_Filtered_,Inferred_Status_);
    SELF.Best_U_C_C_Child_Record_ := __CN(__EE1879157);
    SELF := __PP1878518;
  END;
  EXPORT __ENH_U_C_C_10 := PROJECT(__EE1879193,__ND1879159__Project(LEFT));
END;
