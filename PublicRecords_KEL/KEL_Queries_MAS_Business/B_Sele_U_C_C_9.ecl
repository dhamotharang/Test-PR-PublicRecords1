//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Sele_U_C_C,E_U_C_C FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Sele_U_C_C_9(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Sele_U_C_C(__in,__cfg).__Result) __E_Sele_U_C_C := E_Sele_U_C_C(__in,__cfg).__Result;
  SHARED __EE279081 := __E_Sele_U_C_C;
  EXPORT __ST220369_Layout := RECORD
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
  EXPORT __ST220361_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(__ST220369_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST220361_Layout __ND1882910__Project(E_Sele_U_C_C(__in,__cfg).Layout __PP278979) := TRANSFORM
    __EE279018 := __PP278979.Sub_Filing_;
    __ST220369_Layout __ND1882905__Project(E_Sele_U_C_C(__in,__cfg).Sub_Filing_Layout __PP279150) := TRANSFORM
      SELF.Party_Sort_List_ := MAP(__T(__OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PP279150.Party_Type_)),=,__CN('D')))=>1,__T(__OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PP279150.Party_Type_)),IN,__CN(['S','C','A'])))=>2,3);
      SELF := __PP279150;
    END;
    SELF.Sub_Filing_ := __PROJECT(__EE279018,__ND1882905__Project(LEFT));
    SELF := __PP278979;
  END;
  EXPORT __ENH_Sele_U_C_C_9 := PROJECT(__EE279081,__ND1882910__Project(LEFT));
END;
