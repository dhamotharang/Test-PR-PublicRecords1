//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Address_Slim_4,CFG_Compile,E_Address_Slim,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Address_Slim_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_Slim_4(__in,__cfg).__ENH_Address_Slim_4) __ENH_Address_Slim_4 := B_Address_Slim_4(__in,__cfg).__ENH_Address_Slim_4;
  SHARED __EE5835858 := __ENH_Address_Slim_4;
  EXPORT __ST77916_Layout := RECORD
    KEL.typ.nint High_Risk_N_A_I_C_S_;
    KEL.typ.nstr Address_N_A_I_C_S_Date_First_Seen_;
    KEL.typ.nstr Address_N_A_I_C_S_Date_Last_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST77823_Layout := RECORD
    KEL.typ.nint High_Risk_S_I_C_;
    KEL.typ.nstr Address_S_I_C_Date_First_Seen_;
    KEL.typ.nstr Address_S_I_C_Date_Last_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST226289_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ndataset(E_Address_Slim(__in,__cfg).High_Risk_Address_Layout) High_Risk_Address_;
    KEL.typ.ndataset(E_Address_Slim(__in,__cfg).Address_Type_Layout) Address_Type_;
    KEL.typ.nstr Source_;
    KEL.typ.ndataset(__ST77916_Layout) Address_N_A_I_C_S_List_;
    KEL.typ.ndataset(B_Address_Slim_4(__in,__cfg).__ST77893_Layout) Address_N_I_A_C_S_High_Risk_Pre_;
    KEL.typ.ndataset(B_Address_Slim_4(__in,__cfg).__ST77787_Layout) Address_S_I_C_High_Risk_Pre_;
    KEL.typ.ndataset(__ST77823_Layout) Address_S_I_C_List_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST226289_Layout __ND5836039__Project(B_Address_Slim_4(__in,__cfg).__ST241165_Layout __PP5835859) := TRANSFORM
    __EE5835912 := __PP5835859.Address_N_I_A_C_S_High_Risk_Pre_;
    __ST77916_Layout __ND5836030__Project(B_Address_Slim_4(__in,__cfg).__ST77893_Layout __PP5835913) := TRANSFORM
      __CC13973 := '-99997';
      SELF.Address_N_A_I_C_S_Date_First_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP5835913.Date_First_Seen_Min_Address_N_A_I_C_S_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,__PP5835913.Date_First_Seen_Min_Address_N_A_I_C_S_,__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13973)));
      __CC13531 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bip_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Address_N_A_I_C_S_Date_Last_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP5835913.Date_Last_Seen_Min_Adress_N_A_I_C_S_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(__PP5835913.Date_Last_Seen_Min_Adress_N_A_I_C_S_,__CC13531),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13973)));
      SELF := __PP5835913;
    END;
    SELF.Address_N_A_I_C_S_List_ := __BN(PROJECT(TABLE(PROJECT(__T(__EE5835912),__ND5836030__Project(LEFT))(__NN(High_Risk_N_A_I_C_S_) OR __NN(Address_N_A_I_C_S_Date_First_Seen_) OR __NN(Address_N_A_I_C_S_Date_Last_Seen_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),High_Risk_N_A_I_C_S_,Address_N_A_I_C_S_Date_First_Seen_,Address_N_A_I_C_S_Date_Last_Seen_},High_Risk_N_A_I_C_S_,Address_N_A_I_C_S_Date_First_Seen_,Address_N_A_I_C_S_Date_Last_Seen_,MERGE),__ST77916_Layout),__NL(__EE5835912));
    __EE5835947 := __PP5835859.Address_S_I_C_High_Risk_Pre_;
    __ST77823_Layout __ND5836044__Project(B_Address_Slim_4(__in,__cfg).__ST77787_Layout __PP5835948) := TRANSFORM
      __CC13973 := '-99997';
      SELF.Address_S_I_C_Date_First_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP5835948.Date_First_Seen_Min_Address_S_I_C_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,__PP5835948.Date_First_Seen_Min_Address_S_I_C_,__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13973)));
      __CC13531 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bip_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Address_S_I_C_Date_Last_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP5835948.Date_Last_Seen_Min_Address_S_I_C_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(__PP5835948.Date_Last_Seen_Min_Address_S_I_C_,__CC13531),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13973)));
      SELF := __PP5835948;
    END;
    SELF.Address_S_I_C_List_ := __BN(PROJECT(TABLE(PROJECT(__T(__EE5835947),__ND5836044__Project(LEFT))(__NN(High_Risk_S_I_C_) OR __NN(Address_S_I_C_Date_First_Seen_) OR __NN(Address_S_I_C_Date_Last_Seen_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),High_Risk_S_I_C_,Address_S_I_C_Date_First_Seen_,Address_S_I_C_Date_Last_Seen_},High_Risk_S_I_C_,Address_S_I_C_Date_First_Seen_,Address_S_I_C_Date_Last_Seen_,MERGE),__ST77823_Layout),__NL(__EE5835947));
    SELF := __PP5835859;
  END;
  EXPORT __ENH_Address_Slim_3 := PROJECT(PROJECT(__EE5835858,__ND5836039__Project(LEFT)),__ST226289_Layout);
END;
