//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Person_Vehicle_2,CFG_Compile,E_Person,E_Person_Vehicle,E_Vehicle FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Person_Vehicle_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Vehicle_2(__in,__cfg).__ENH_Person_Vehicle_2) __ENH_Person_Vehicle_2 := B_Person_Vehicle_2(__in,__cfg).__ENH_Person_Vehicle_2;
  SHARED __EE795583 := __ENH_Person_Vehicle_2;
  EXPORT __ST69261_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Vehicle().Typ) Automobile_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Registration_Layout) Registration_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Title_Layout) Title_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Counts_Model_Layout) Counts_Model_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nbool Seen___In___Last___Ten___Years_;
    KEL.typ.nbool Seen___In___Last___Two___Years_;
    KEL.typ.nstr Vehicle_Max_Date_;
    KEL.typ.nstr Vehicle_Min_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST69261_Layout __ND795830__Project(B_Person_Vehicle_2(__in,__cfg).__ST75996_Layout __PP795374) := TRANSFORM
    __CC8101 := 3652;
    SELF.Seen___In___Last___Ten___Years_ := __OP2(__FN2(KEL.Routines.DaysBetween,__PP795374.Date_Last_Seen_Capped_,__PP795374.Current_Date_),<=,__CN(__CC8101));
    __CC8103 := 730;
    SELF.Seen___In___Last___Two___Years_ := __OP2(__FN2(KEL.Routines.DaysBetween,__PP795374.Date_Last_Seen_Capped_,__PP795374.Current_Date_),<=,__CN(__CC8103));
    __CC8099 := '-99997';
    SELF.Vehicle_Max_Date_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP795374.Date_Last_Seen_Capped_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,__PP795374.Date_Last_Seen_Capped_,__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC8099)));
    SELF := __PP795374;
  END;
  EXPORT __ENH_Person_Vehicle_1 := PROJECT(__EE795583,__ND795830__Project(LEFT));
END;
