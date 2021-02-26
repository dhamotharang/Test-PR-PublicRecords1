//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Sele_Person_2,B_Sele_Person_3,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Person,E_Sele_Person,E_Surname FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Sele_Person_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Person_2(__in,__cfg).__ENH_Sele_Person_2) __ENH_Sele_Person_2 := B_Sele_Person_2(__in,__cfg).__ENH_Sele_Person_2;
  SHARED __EE8998790 := __ENH_Sele_Person_2;
  EXPORT __ST204843_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Contact_Info_Layout) Contact_Info_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nstr Assoc_Valid_Date_;
    KEL.typ.nint Datemonths_;
    KEL.typ.bool Is_Executive_Ever_ := FALSE;
    KEL.typ.ndataset(B_Sele_Person_3(__in,__cfg).__ST1267867_Layout) Relatives_;
    KEL.typ.nbool Two_Years_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST204843_Layout __ND8998939__Project(B_Sele_Person_2(__in,__cfg).__ST223776_Layout __PP8998791) := TRANSFORM
    __CC13863 := '-99997';
    SELF.Assoc_Valid_Date_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP8998791.Assoc_Fs_Date_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,__PP8998791.Assoc_Fs_Date_,__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13863)));
    SELF := __PP8998791;
  END;
  EXPORT __ENH_Sele_Person_1 := PROJECT(__EE8998790,__ND8998939__Project(LEFT));
END;
