//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Sele_U_C_C_7,B_Sele_U_C_C_9,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Sele_U_C_C,E_U_C_C FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Sele_U_C_C_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_U_C_C_7(__in,__cfg).__ENH_Sele_U_C_C_7) __ENH_Sele_U_C_C_7 := B_Sele_U_C_C_7(__in,__cfg).__ENH_Sele_U_C_C_7;
  SHARED __EE1940384 := __ENH_Sele_U_C_C_7;
  EXPORT __ST209097_Layout := RECORD
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.nstr Party_Type_;
    KEL.typ.int Party_Sort_List_ := 0;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST209089_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(__ST209097_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_U_C_C_9(__in,__cfg).__ST213684_Layout) Best_Party_Types_;
    KEL.typ.nstr Filtered_Party_Type_;
    KEL.typ.bool Is_Filing_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST209089_Layout __ND1940489__Project(B_Sele_U_C_C_7(__in,__cfg).__ST211291_Layout __PP1940385) := TRANSFORM
    __EE1940420 := __PP1940385.Sub_Filing_;
    SELF.Sub_Filing_ := __BN(PROJECT(__T(__EE1940420),__ST209097_Layout),__NL(__EE1940420));
    SELF.Is_Filing_ := IF(__T(__OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PP1940385.Filtered_Party_Type_)),IN,__CN(['D','S','C','A']))),TRUE,FALSE);
    SELF := __PP1940385;
  END;
  EXPORT __ENH_Sele_U_C_C_6 := PROJECT(__EE1940384,__ND1940489__Project(LEFT));
END;
