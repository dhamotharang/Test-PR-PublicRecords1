//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Lien_Judgment,E_Sele_Lien_Judgment FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Sele_Lien_Judgment_11(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Sele_Lien_Judgment(__in,__cfg).__Result) __E_Sele_Lien_Judgment := E_Sele_Lien_Judgment(__in,__cfg).__Result;
  SHARED __EE149812 := __E_Sele_Lien_Judgment;
  EXPORT __ST149129_Layout := RECORD
    KEL.typ.nstr Debtor_Plaintiff_;
    KEL.typ.nstr Debtors_Full_Name_;
    KEL.typ.nbool Is_Debtor_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST149120_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(__ST149129_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST149120_Layout __ND149899__Project(E_Sele_Lien_Judgment(__in,__cfg).Layout __PP149711) := TRANSFORM
    __EE149754 := __PP149711.Details_;
    __ST149129_Layout __ND149894__Project(E_Sele_Lien_Judgment(__in,__cfg).Details_Layout __PP149816) := TRANSFORM
      SELF.Is_Debtor_ := __OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PP149816.Debtor_Plaintiff_)),=,__CN('D'));
      SELF := __PP149816;
    END;
    SELF.Details_ := __PROJECT(__EE149754,__ND149894__Project(LEFT));
    SELF := __PP149711;
  END;
  EXPORT __ENH_Sele_Lien_Judgment_11 := PROJECT(__EE149812,__ND149899__Project(LEFT));
END;
