//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT B_U_C_C_10,B_U_C_C_11,B_U_C_C_2,CFG_Compile,E_U_C_C FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_U_C_C_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_U_C_C_2().__ENH_U_C_C_2) __ENH_U_C_C_2 := B_U_C_C_2(__in,__cfg).__ENH_U_C_C_2;
  SHARED __EE2861215 := __ENH_U_C_C_2;
  EXPORT __ST125443_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ndataset(B_U_C_C_2(__in,__cfg).__ST137811_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Collateral_Layout) Collateral_;
    KEL.typ.ndataset(E_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_U_C_C_10(__in,__cfg).__ST77536_Layout) Best_U_C_C_Child_Record_;
    KEL.typ.nbool Terminated_Filing_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_U_C_C_1 := PROJECT(__EE2861215,__ST125443_Layout);
END;
