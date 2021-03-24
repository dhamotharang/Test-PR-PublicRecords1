//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Sele_U_C_C,E_U_C_C FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Sele_U_C_C_9(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Sele_U_C_C(__in,__cfg).__Result) __E_Sele_U_C_C := E_Sele_U_C_C(__in,__cfg).__Result;
  SHARED __EE337757 := __E_Sele_U_C_C;
  EXPORT __ST258482_Layout := RECORD
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
  EXPORT __ST258474_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(__ST258482_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST258474_Layout __ND4641575__Project(E_Sele_U_C_C(__in,__cfg).Layout __PP337655) := TRANSFORM
    __EE337694 := __PP337655.Sub_Filing_;
    __ST258482_Layout __ND4641570__Project(E_Sele_U_C_C(__in,__cfg).Sub_Filing_Layout __PP337826) := TRANSFORM
      SELF.Party_Sort_List_ := MAP(__T(__OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PP337826.Party_Type_)),=,__CN('D')))=>1,__T(__OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PP337826.Party_Type_)),IN,__CN(['S','C','A'])))=>2,3);
      SELF := __PP337826;
    END;
    SELF.Sub_Filing_ := __PROJECT(__EE337694,__ND4641570__Project(LEFT));
    SELF := __PP337655;
  END;
  EXPORT __ENH_Sele_U_C_C_9 := PROJECT(__EE337757,__ND4641575__Project(LEFT));
END;
