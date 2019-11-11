//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Watercraft_Owner_4,CFG_Compile,E_Person,E_Watercraft,E_Watercraft_Owner FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Watercraft_Owner_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Watercraft_Owner_4(__in,__cfg).__ENH_Watercraft_Owner_4) __ENH_Watercraft_Owner_4 := B_Watercraft_Owner_4(__in,__cfg).__ENH_Watercraft_Owner_4;
  SHARED __EE383518 := __ENH_Watercraft_Owner_4;
  EXPORT __ST89256_Layout := RECORD
    KEL.typ.ntyp(E_Watercraft().Typ) W_Craft_;
    KEL.typ.ntyp(E_Person().Typ) Owner_;
    KEL.typ.ndataset(E_Watercraft_Owner(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nkdate Date_First_Seen_Capped_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST89256_Layout __ND383528__Project(B_Watercraft_Owner_4(__in,__cfg).__ST93583_Layout __PP383462) := TRANSFORM
    SELF.Date_First_Seen_Capped_ := IF(__T(__OP2(KEL.era.ToDate(__PP383462.Date_First_Seen_),>,__PP383462.Current_Date_)),__ECAST(KEL.typ.nkdate,__PP383462.Current_Date_),__ECAST(KEL.typ.nkdate,KEL.era.ToDate(__PP383462.Date_First_Seen_)));
    SELF := __PP383462;
  END;
  EXPORT __ENH_Watercraft_Owner_3 := PROJECT(__EE383518,__ND383528__Project(LEFT));
END;
