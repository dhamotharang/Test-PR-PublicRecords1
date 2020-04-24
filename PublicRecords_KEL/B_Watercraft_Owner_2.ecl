//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT B_Watercraft_Owner_3,CFG_Compile,E_Person,E_Watercraft,E_Watercraft_Owner FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Watercraft_Owner_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Watercraft_Owner_3().__ENH_Watercraft_Owner_3) __ENH_Watercraft_Owner_3 := B_Watercraft_Owner_3(__in,__cfg).__ENH_Watercraft_Owner_3;
  SHARED __EE2093645 := __ENH_Watercraft_Owner_3;
  EXPORT __ST137689_Layout := RECORD
    KEL.typ.ntyp(E_Watercraft().Typ) W_Craft_;
    KEL.typ.ntyp(E_Person().Typ) Owner_;
    KEL.typ.ndataset(E_Watercraft_Owner(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Date_First_Seen_Capped_;
    KEL.typ.nstr Watercraft_Min_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST137689_Layout __ND2093669__Project(B_Watercraft_Owner_3(__in,__cfg).__ST148175_Layout __PP2093594) := TRANSFORM
    __CC9926 := '-99997';
    SELF.Watercraft_Min_Date_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP2093594.Date_First_Seen_Capped_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,__PP2093594.Date_First_Seen_Capped_,__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC9926)));
    SELF := __PP2093594;
  END;
  EXPORT __ENH_Watercraft_Owner_2 := PROJECT(__EE2093645,__ND2093669__Project(LEFT));
END;
