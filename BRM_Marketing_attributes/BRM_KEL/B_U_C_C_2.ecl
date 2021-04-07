//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_U_C_C_10,B_U_C_C_11,B_U_C_C_3,CFG_Compile,E_U_C_C FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_U_C_C_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_U_C_C_3(__in,__cfg).__ENH_U_C_C_3) __ENH_U_C_C_3 := B_U_C_C_3(__in,__cfg).__ENH_U_C_C_3;
  SHARED __EE1243858 := __ENH_U_C_C_3;
  EXPORT __ST141846_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ndataset(B_U_C_C_3(__in,__cfg).__ST146189_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Collateral_Layout) Collateral_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nbool Active_Status_;
    KEL.typ.nstr Best_Inferred_Status_;
    KEL.typ.ndataset(B_U_C_C_10(__in,__cfg).__ST77169_Layout) Best_U_C_C_Child_Record_;
    KEL.typ.nbool Terminated_Filing_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST141846_Layout __ND1244043__Project(B_U_C_C_3(__in,__cfg).__ST146185_Layout __PP1243859) := TRANSFORM
    SELF.Active_Status_ := __OP2(__PP1243859.Best_Inferred_Status_,=,__CN('1'));
    SELF := __PP1243859;
  END;
  EXPORT __ENH_U_C_C_2 := PROJECT(__EE1243858,__ND1244043__Project(LEFT));
END;
