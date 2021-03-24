//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Input_P_I_I_4,B_Name_Summary_4,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Name_Summary_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_4(__in,__cfg).__ENH_Input_P_I_I_4) __ENH_Input_P_I_I_4 := B_Input_P_I_I_4(__in,__cfg).__ENH_Input_P_I_I_4;
  SHARED VIRTUAL TYPEOF(B_Name_Summary_4(__in,__cfg).__ENH_Name_Summary_4) __ENH_Name_Summary_4 := B_Name_Summary_4(__in,__cfg).__ENH_Name_Summary_4;
  SHARED __EE5413273 := __ENH_Name_Summary_4;
  SHARED __EE5413276 := __ENH_Input_P_I_I_4;
  SHARED __EE5413283 := __EE5413276(__NN(__EE5413276.Name_Summ_));
  SHARED __ST951614_Layout := RECORD
    KEL.typ.ntyp(E_Name_Summary().Typ) UID;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST951614_Layout __ND5413288__Project(B_Input_P_I_I_4(__in,__cfg).__ST236996_Layout __PP5413284) := TRANSFORM
    SELF.UID := __PP5413284.Name_Summ_;
    SELF.U_I_D__1_ := __PP5413284.UID;
    SELF := __PP5413284;
  END;
  SHARED __EE5413297 := PROJECT(__EE5413283,__ND5413288__Project(LEFT));
  SHARED __ST951642_Layout := RECORD
    KEL.typ.ntyp(E_Name_Summary().Typ) UID;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE5413433 := PROJECT(__EE5413297,TRANSFORM(__ST951642_Layout,SELF.O_N_L_Y___U_I_D_ := LEFT.U_I_D__1_,SELF := LEFT));
  SHARED __ST952525_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nint Record_Count_;
    KEL.typ.ndataset(B_Name_Summary_4(__in,__cfg).__ST237441_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Name_Summary_4(__in,__cfg).__ST79448_Layout) Translated_Sources_;
    KEL.typ.ntyp(E_Name_Summary().Typ) U_I_D__1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC5413558(B_Name_Summary_4(__in,__cfg).__ST237434_Layout __EE5413273, __ST951642_Layout __EE5413433) := __EEQP(__EE5413273.UID,__EE5413433.UID);
  __ST952525_Layout __JT5413558(B_Name_Summary_4(__in,__cfg).__ST237434_Layout __l, __ST951642_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE5413559 := JOIN(__EE5413273,__EE5413433,__JC5413558(LEFT,RIGHT),__JT5413558(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  EXPORT __ST225184_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST79497_Layout := RECORD
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.nstr Source_Date_First_Seen_;
    KEL.typ.nstr Source_Date_Last_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST225177_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nint Record_Count_;
    KEL.typ.ndataset(__ST225184_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST79497_Layout) Name_Summary_Source_List_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.ndataset(B_Name_Summary_4(__in,__cfg).__ST79448_Layout) Translated_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST225177_Layout __ND5413756__Project(__ST952525_Layout __PP5413467) := TRANSFORM
    __EE5413461 := __PP5413467.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE5413461),__ST225184_Layout),__NL(__EE5413461));
    __EE5413465 := __PP5413467.Translated_Sources_;
    __ST79497_Layout __ND5413747__Project(B_Name_Summary_4(__in,__cfg).__ST79448_Layout __PP5413509) := TRANSFORM
      __CC13991 := '-99997';
      SELF.Source_Date_First_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP5413509.Date_First_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP5413509.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13991)));
      __CC13474 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('RiskTable_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Source_Date_Last_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP5413509.Date_Last_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP5413509.Date_Last_Seen_),__CC13474),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13991)));
      SELF := __PP5413509;
    END;
    SELF.Name_Summary_Source_List_ := __PROJECT(__EE5413465,__ND5413747__Project(LEFT));
    SELF.P_I_I_ := __PP5413467.O_N_L_Y___U_I_D_;
    SELF := __PP5413467;
  END;
  EXPORT __ENH_Name_Summary_3 := PROJECT(__EE5413559,__ND5413756__Project(LEFT));
END;
