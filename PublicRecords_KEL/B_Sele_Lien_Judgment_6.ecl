//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Lien_Judgment,E_Sele_Lien_Judgment FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Sele_Lien_Judgment_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Sele_Lien_Judgment(__in,__cfg).__Result) __E_Sele_Lien_Judgment := E_Sele_Lien_Judgment(__in,__cfg).__Result;
  SHARED __EE134750 := __E_Sele_Lien_Judgment;
  EXPORT __ST108917_Layout := RECORD
    KEL.typ.nstr Debtor_Plaintiff_;
    KEL.typ.nstr Debtors_Full_Name_;
    KEL.typ.nbool Is_Debtor_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST108908_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Sele_;
    KEL.typ.ntyp(E_Lien_Judgment().Typ) Lien_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(__ST108917_Layout) Details_;
    KEL.typ.ndataset(E_Sele_Lien_Judgment(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST108908_Layout __ND134837__Project(E_Sele_Lien_Judgment(__in,__cfg).Layout __PP134649) := TRANSFORM
    __EE134692 := __PP134649.Details_;
    __ST108917_Layout __ND134832__Project(E_Sele_Lien_Judgment(__in,__cfg).Details_Layout __PP134754) := TRANSFORM
      SELF.Is_Debtor_ := __OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PP134754.Debtor_Plaintiff_)),=,__CN('D'));
      SELF := __PP134754;
    END;
    SELF.Details_ := __PROJECT(__EE134692,__ND134832__Project(LEFT));
    SELF := __PP134649;
  END;
  EXPORT __ENH_Sele_Lien_Judgment_6 := PROJECT(__EE134750,__ND134837__Project(LEFT));
END;
