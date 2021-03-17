//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_Vehicle_2,CFG_Compile,E_Person,E_Person_Vehicle,E_Vehicle,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_Vehicle_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Vehicle_2(__in,__cfg).__ENH_Person_Vehicle_2) __ENH_Person_Vehicle_2 := B_Person_Vehicle_2(__in,__cfg).__ENH_Person_Vehicle_2;
  SHARED __EE9312637 := __ENH_Person_Vehicle_2;
  EXPORT __ST201626_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Vehicle().Typ) Automobile_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Registration_Layout) Registration_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Title_Layout) Title_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Counts_Model_Layout) Counts_Model_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nbool Seen___In___Last___Ten___Years_;
    KEL.typ.nbool Seen___In___Last___Two___Years_;
    KEL.typ.nstr Vehicle_Max_Date_;
    KEL.typ.nstr Vehicle_Min_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST201626_Layout __ND9312805__Project(B_Person_Vehicle_2(__in,__cfg).__ST220750_Layout __PP9312638) := TRANSFORM
    __CC13339 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('vehicle_build_version'))),__CN(__cfg.CurrentDate));
    __CC13671 := 3652;
    SELF.Seen___In___Last___Ten___Years_ := __OP2(__FN2(KEL.Routines.DaysBetween,__PP9312638.Date_Last_Seen_Capped_,__CC13339),<=,__CN(__CC13671));
    __CC13673 := 730;
    SELF.Seen___In___Last___Two___Years_ := __OP2(__FN2(KEL.Routines.DaysBetween,__PP9312638.Date_Last_Seen_Capped_,__CC13339),<=,__CN(__CC13673));
    __CC13669 := '-99997';
    SELF.Vehicle_Max_Date_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP9312638.Date_Last_Seen_Capped_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,__PP9312638.Date_Last_Seen_Capped_,__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13669)));
    SELF := __PP9312638;
  END;
  EXPORT __ENH_Person_Vehicle_1 := PROJECT(__EE9312637,__ND9312805__Project(LEFT));
END;
