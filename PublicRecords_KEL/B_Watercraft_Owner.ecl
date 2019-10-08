//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Watercraft_Owner_1,CFG_Compile,E_Person,E_Watercraft,E_Watercraft_Owner FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Watercraft_Owner(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Watercraft_Owner_1(__in,__cfg).__ENH_Watercraft_Owner_1) __ENH_Watercraft_Owner_1 := B_Watercraft_Owner_1(__in,__cfg).__ENH_Watercraft_Owner_1;
  SHARED __EE1421359 := __ENH_Watercraft_Owner_1;
  EXPORT __ST59842_Layout := RECORD
    KEL.typ.ntyp(E_Watercraft().Typ) W_Craft_;
    KEL.typ.ntyp(E_Person().Typ) Owner_;
    KEL.typ.ndataset(E_Watercraft_Owner(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nkdate Date_First_Seen_Capped_;
    KEL.typ.nkdate Date_Last_Seen_Capped_;
    KEL.typ.nstr Watercraft_Max_Date_;
    KEL.typ.nstr Watercraft_Min_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST59842_Layout __ND1421389__Project(B_Watercraft_Owner_1(__in,__cfg).__ST69087_Layout __PP1421293) := TRANSFORM
    __CC8022 := '-99997';
    SELF.Watercraft_Max_Date_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP1421293.Date_Last_Seen_Capped_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,__PP1421293.Date_Last_Seen_Capped_,__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC8022)));
    SELF := __PP1421293;
  END;
  EXPORT __ENH_Watercraft_Owner := PROJECT(__EE1421359,__ND1421389__Project(LEFT));
END;
