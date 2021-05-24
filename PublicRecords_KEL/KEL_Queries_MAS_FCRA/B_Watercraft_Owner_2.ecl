//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Watercraft_Owner_3,CFG_Compile,E_Person,E_Watercraft,E_Watercraft_Owner FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Watercraft_Owner_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Watercraft_Owner_3(__in,__cfg).__ENH_Watercraft_Owner_3) __ENH_Watercraft_Owner_3 := B_Watercraft_Owner_3(__in,__cfg).__ENH_Watercraft_Owner_3;
  SHARED __EE1515866 := __ENH_Watercraft_Owner_3;
  EXPORT __ST159084_Layout := RECORD
    KEL.typ.ntyp(E_Watercraft().Typ) W_Craft_;
    KEL.typ.ntyp(E_Person().Typ) Owner_;
    KEL.typ.ndataset(E_Watercraft_Owner(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Date_First_Seen_Capped_;
    KEL.typ.nstr Watercraft_Min_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST159084_Layout __ND1515911__Project(B_Watercraft_Owner_3(__in,__cfg).__ST162422_Layout __PP1515867) := TRANSFORM
    __CC14091 := '-99997';
    SELF.Watercraft_Min_Date_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP1515867.Date_First_Seen_Capped_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,__PP1515867.Date_First_Seen_Capped_,__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14091)));
    SELF := __PP1515867;
  END;
  EXPORT __ENH_Watercraft_Owner_2 := PROJECT(__EE1515866,__ND1515911__Project(LEFT));
END;
