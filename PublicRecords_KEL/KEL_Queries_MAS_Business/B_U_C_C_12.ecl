//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_U_C_C_13,CFG_Compile,E_U_C_C,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_U_C_C_12(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_U_C_C_13(__in,__cfg).__ENH_U_C_C_13) __ENH_U_C_C_13 := B_U_C_C_13(__in,__cfg).__ENH_U_C_C_13;
  SHARED __EE1870534 := __ENH_U_C_C_13;
  EXPORT __ST216313_Layout := RECORD
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
    KEL.typ.nkdate Max_Filing_Date_;
    KEL.typ.str Status_Type_Filtered_ := '';
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST216309_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ndataset(__ST216313_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Collateral_Layout) Collateral_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST216309_Layout __ND1870539__Project(B_U_C_C_13(__in,__cfg).__ST216374_Layout __PP1870535) := TRANSFORM
    __EE1870555 := __PP1870535.Sub_Filing_;
    __ST216313_Layout __ND1870560__Project(B_U_C_C_13(__in,__cfg).__ST216378_Layout __PP1870556) := TRANSFORM
      __CC13511 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('ucc_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Age_In_Days_ := FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,__PP1870556.Max_Filing_Date_),__ECAST(KEL.typ.nkdate,__CC13511));
      SELF.Filing_Type_Filtered_ := FN_Compile(__cfg).FN__map_Filing_Type(__ECAST(KEL.typ.nstr,__PP1870556.Filing_Type_));
      SELF.Status_Type_Filtered_ := FN_Compile(__cfg).FN__map_Status_Type(__ECAST(KEL.typ.nstr,__PP1870556.Status_Type_));
      SELF := __PP1870556;
    END;
    SELF.Sub_Filing_ := __PROJECT(__EE1870555,__ND1870560__Project(LEFT));
    SELF := __PP1870535;
  END;
  EXPORT __ENH_U_C_C_12 := PROJECT(__EE1870534,__ND1870539__Project(LEFT));
END;
