//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Input_P_I_I_4,B_Name_Summary_4,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Name_Summary_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_4(__in,__cfg).__ENH_Input_P_I_I_4) __ENH_Input_P_I_I_4 := B_Input_P_I_I_4(__in,__cfg).__ENH_Input_P_I_I_4;
  SHARED VIRTUAL TYPEOF(B_Name_Summary_4(__in,__cfg).__ENH_Name_Summary_4) __ENH_Name_Summary_4 := B_Name_Summary_4(__in,__cfg).__ENH_Name_Summary_4;
  SHARED __EE6462624 := __ENH_Name_Summary_4;
  SHARED __EE6462627 := __ENH_Input_P_I_I_4;
  SHARED __EE6462634 := __EE6462627(__NN(__EE6462627.Name_Summ_));
  SHARED __ST1065131_Layout := RECORD
    KEL.typ.ntyp(E_Name_Summary().Typ) UID;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST1065131_Layout __ND6462639__Project(B_Input_P_I_I_4(__in,__cfg).__ST285346_Layout __PP6462635) := TRANSFORM
    SELF.UID := __PP6462635.Name_Summ_;
    SELF.U_I_D__1_ := __PP6462635.UID;
    SELF := __PP6462635;
  END;
  SHARED __EE6462648 := PROJECT(__EE6462634,__ND6462639__Project(LEFT));
  SHARED __ST1065159_Layout := RECORD
    KEL.typ.ntyp(E_Name_Summary().Typ) UID;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE6462789 := PROJECT(__EE6462648,TRANSFORM(__ST1065159_Layout,SELF.O_N_L_Y___U_I_D_ := LEFT.U_I_D__1_,SELF := LEFT));
  SHARED __ST1066107_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Date_Of_Birth_Padded_;
    KEL.typ.nint Record_Count_;
    KEL.typ.ndataset(B_Name_Summary_4(__in,__cfg).__ST255091_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Name_Summary_4(__in,__cfg).__ST87244_Layout) Translated_Sources_;
    KEL.typ.ntyp(E_Name_Summary().Typ) U_I_D__1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC6462919(B_Name_Summary_4(__in,__cfg).__ST255083_Layout __EE6462624, __ST1065159_Layout __EE6462789) := __EEQP(__EE6462624.UID,__EE6462789.UID);
  __ST1066107_Layout __JT6462919(B_Name_Summary_4(__in,__cfg).__ST255083_Layout __l, __ST1065159_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE6462920 := JOIN(__EE6462624,__EE6462789,__JC6462919(LEFT,RIGHT),__JT6462919(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  EXPORT __ST242214_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST87293_Layout := RECORD
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
  EXPORT __ST242206_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Date_Of_Birth_Padded_;
    KEL.typ.nint Record_Count_;
    KEL.typ.ndataset(__ST242214_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST87293_Layout) Name_Summary_Source_List_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.ndataset(B_Name_Summary_4(__in,__cfg).__ST87244_Layout) Translated_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST242206_Layout __ND6463133__Project(__ST1066107_Layout __PP6462824) := TRANSFORM
    __EE6462818 := __PP6462824.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE6462818),__ST242214_Layout),__NL(__EE6462818));
    __EE6462822 := __PP6462824.Translated_Sources_;
    __ST87293_Layout __ND6463124__Project(B_Name_Summary_4(__in,__cfg).__ST87244_Layout __PP6462869) := TRANSFORM
      __CC14000 := '-99997';
      SELF.Source_Date_First_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP6462869.Date_First_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP6462869.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14000)));
      __CC13480 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('RiskTable_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Source_Date_Last_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP6462869.Date_Last_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP6462869.Date_Last_Seen_),__CC13480),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14000)));
      SELF := __PP6462869;
    END;
    SELF.Name_Summary_Source_List_ := __PROJECT(__EE6462822,__ND6463124__Project(LEFT));
    SELF.P_I_I_ := __PP6462824.O_N_L_Y___U_I_D_;
    SELF := __PP6462824;
  END;
  EXPORT __ENH_Name_Summary_3 := PROJECT(__EE6462920,__ND6463133__Project(LEFT));
END;
