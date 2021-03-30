//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_U_C_C_1,B_U_C_C_10,B_U_C_C_11,CFG_Compile,E_U_C_C FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_U_C_C(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_U_C_C_1(__in,__cfg).__ENH_U_C_C_1) __ENH_U_C_C_1 := B_U_C_C_1(__in,__cfg).__ENH_U_C_C_1;
  SHARED __EE11954373 := __ENH_U_C_C_1;
  EXPORT __ST181746_Layout := RECORD
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
  EXPORT __ST181742_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ndataset(__ST181746_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Collateral_Layout) Collateral_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nbool Active_Status_;
    KEL.typ.nstr Best_Child_R_M_S_I_D_;
    KEL.typ.nstr Best_Inferred_Status_;
    KEL.typ.ndataset(B_U_C_C_10(__in,__cfg).__ST120651_Layout) Best_U_C_C_Child_Record_;
    KEL.typ.nbool Terminated_Filing_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST181742_Layout __ND11954378__Project(B_U_C_C_1(__in,__cfg).__ST312820_Layout __PP11954374) := TRANSFORM
    __EE11954416 := __PP11954374.Sub_Filing_;
    SELF.Sub_Filing_ := __BN(PROJECT(__T(__EE11954416),__ST181746_Layout),__NL(__EE11954416));
    SELF := __PP11954374;
  END;
  EXPORT __ENH_U_C_C := PROJECT(__EE11954373,__ND11954378__Project(LEFT));
END;
