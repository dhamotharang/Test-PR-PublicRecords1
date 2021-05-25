﻿//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_U_C_C_10,B_U_C_C_11,B_U_C_C_3,CFG_Compile,E_U_C_C FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_U_C_C_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_U_C_C_3(__in,__cfg).__ENH_U_C_C_3) __ENH_U_C_C_3 := B_U_C_C_3(__in,__cfg).__ENH_U_C_C_3;
  SHARED __EE2908499 := __ENH_U_C_C_3;
  EXPORT __ST196909_Layout := RECORD
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
    KEL.typ.str Status_Type_Filtered_ := '';
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST196905_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ndataset(__ST196909_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Collateral_Layout) Collateral_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nbool Active_Status_;
    KEL.typ.nstr Best_Inferred_Status_;
    KEL.typ.ndataset(B_U_C_C_10(__in,__cfg).__ST107571_Layout) Best_U_C_C_Child_Record_;
    KEL.typ.nbool Terminated_Filing_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST196905_Layout __ND2908504__Project(B_U_C_C_3(__in,__cfg).__ST206158_Layout __PP2908500) := TRANSFORM
    __EE2908541 := __PP2908500.Sub_Filing_;
    SELF.Sub_Filing_ := __PROJECT(__EE2908541,__ST196909_Layout);
    SELF := __PP2908500;
  END;
  EXPORT __ENH_U_C_C_2 := PROJECT(__EE2908499,__ND2908504__Project(LEFT));
END;
