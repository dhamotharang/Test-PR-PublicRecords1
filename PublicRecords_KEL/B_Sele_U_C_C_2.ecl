//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT B_Sele_U_C_C_3,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Sele_U_C_C,E_U_C_C FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Sele_U_C_C_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_U_C_C_3(__in,__cfg).__ENH_Sele_U_C_C_3) __ENH_Sele_U_C_C_3 := B_Sele_U_C_C_3(__in,__cfg).__ENH_Sele_U_C_C_3;
  SHARED __EE862976 := __ENH_Sele_U_C_C_3;
  EXPORT __ST97411_Layout := RECORD
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.nstr Party_Type_;
    KEL.typ.bool Creditor_ := FALSE;
    KEL.typ.bool Debtor_ := FALSE;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST97403_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(__ST97411_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST97403_Layout __ND863066__Project(B_Sele_U_C_C_3(__in,__cfg).__ST103632_Layout __PP862874) := TRANSFORM
    __EE862913 := __PP862874.Sub_Filing_;
    __ST97411_Layout __ND863060__Project(B_Sele_U_C_C_3(__in,__cfg).__ST103640_Layout __PP862980) := TRANSFORM
      SELF.Creditor_ := IF(__T(__OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PP862980.Party_Type_)),IN,__CN(['S','C','A']))),TRUE,FALSE);
      SELF := __PP862980;
    END;
    SELF.Sub_Filing_ := __PROJECT(__EE862913,__ND863060__Project(LEFT));
    SELF := __PP862874;
  END;
  EXPORT __ENH_Sele_U_C_C_2 := PROJECT(__EE862976,__ND863066__Project(LEFT));
END;
