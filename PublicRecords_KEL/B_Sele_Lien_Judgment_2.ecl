//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT B_Sele_Lien_Judgment_3,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Lien_Judgment,E_Sele_Lien_Judgment FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Sele_Lien_Judgment_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Lien_Judgment_3(__in,__cfg).__ENH_Sele_Lien_Judgment_3) __ENH_Sele_Lien_Judgment_3 := B_Sele_Lien_Judgment_3(__in,__cfg).__ENH_Sele_Lien_Judgment_3;
  SHARED __EE862730 := __ENH_Sele_Lien_Judgment_3;
  EXPORT __ST97342_Layout := RECORD
    KEL.typ.nstr Debtor_Plaintiff_;
    KEL.typ.nstr Debtors_Full_Name_;
    KEL.typ.nbool Is_Debtor_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST97333_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(__ST97342_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST97333_Layout __ND862793__Project(B_Sele_Lien_Judgment_3(__in,__cfg).__ST103573_Layout __PP862632) := TRANSFORM
    __EE862675 := __PP862632.Details_;
    SELF.Details_ := __BN(PROJECT(__T(__EE862675),__ST97342_Layout),__NL(__EE862675));
    SELF := __PP862632;
  END;
  EXPORT __ENH_Sele_Lien_Judgment_2 := PROJECT(__EE862730,__ND862793__Project(LEFT));
END;
