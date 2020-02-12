//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT B_Sele_Lien_Judgment_2,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Lien_Judgment,E_Sele_Lien_Judgment FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Sele_Lien_Judgment_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Lien_Judgment_2(__in,__cfg).__ENH_Sele_Lien_Judgment_2) __ENH_Sele_Lien_Judgment_2 := B_Sele_Lien_Judgment_2(__in,__cfg).__ENH_Sele_Lien_Judgment_2;
  SHARED __EE1221557 := __ENH_Sele_Lien_Judgment_2;
  EXPORT __ST88903_Layout := RECORD
    KEL.typ.nstr Debtor_Plaintiff_;
    KEL.typ.nstr Debtors_Full_Name_;
    KEL.typ.nbool Is_Debtor_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST88894_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(__ST88903_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST88894_Layout __ND1221620__Project(B_Sele_Lien_Judgment_2(__in,__cfg).__ST97333_Layout __PP1221459) := TRANSFORM
    __EE1221502 := __PP1221459.Details_;
    SELF.Details_ := __BN(PROJECT(__T(__EE1221502),__ST88903_Layout),__NL(__EE1221502));
    SELF := __PP1221459;
  END;
  EXPORT __ENH_Sele_Lien_Judgment_1 := PROJECT(__EE1221557,__ND1221620__Project(LEFT));
END;
