//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_U_C_C_10,B_U_C_C_11,B_U_C_C_3,CFG_Compile,E_U_C_C FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL16.Null;
EXPORT B_U_C_C_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_U_C_C_3(__in,__cfg).__ENH_U_C_C_3) __ENH_U_C_C_3 := B_U_C_C_3(__in,__cfg).__ENH_U_C_C_3;
  SHARED __EE1257603 := __ENH_U_C_C_3;
  EXPORT __ST153491_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ndataset(B_U_C_C_3(__in,__cfg).__ST157838_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Collateral_Layout) Collateral_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nbool Active_Status_;
    KEL.typ.nstr Best_Inferred_Status_;
    KEL.typ.ndataset(B_U_C_C_10(__in,__cfg).__ST83099_Layout) Best_U_C_C_Child_Record_;
    KEL.typ.nbool Terminated_Filing_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST153491_Layout __ND1257788__Project(B_U_C_C_3(__in,__cfg).__ST157834_Layout __PP1257604) := TRANSFORM
    SELF.Active_Status_ := __OP2(__PP1257604.Best_Inferred_Status_,=,__CN('1'));
    SELF := __PP1257604;
  END;
  EXPORT __ENH_U_C_C_2 := PROJECT(__EE1257603,__ND1257788__Project(LEFT));
END;
