//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Input_P_I_I_4,B_Name_Summary_4,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Name_Summary_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_4(__in,__cfg).__ENH_Input_P_I_I_4) __ENH_Input_P_I_I_4 := B_Input_P_I_I_4(__in,__cfg).__ENH_Input_P_I_I_4;
  SHARED VIRTUAL TYPEOF(B_Name_Summary_4(__in,__cfg).__ENH_Name_Summary_4) __ENH_Name_Summary_4 := B_Name_Summary_4(__in,__cfg).__ENH_Name_Summary_4;
  SHARED __EE6326568 := __ENH_Name_Summary_4;
  SHARED __EE6326571 := __ENH_Input_P_I_I_4;
  SHARED __EE6326578 := __EE6326571(__NN(__EE6326571.Name_Summ_));
  SHARED __ST1052268_Layout := RECORD
    KEL.typ.ntyp(E_Name_Summary().Typ) UID;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST1052268_Layout __ND6326583__Project(B_Input_P_I_I_4(__in,__cfg).__ST277040_Layout __PP6326579) := TRANSFORM
    SELF.UID := __PP6326579.Name_Summ_;
    SELF.U_I_D__1_ := __PP6326579.UID;
    SELF := __PP6326579;
  END;
  SHARED __EE6326592 := PROJECT(__EE6326578,__ND6326583__Project(LEFT));
  SHARED __ST1052296_Layout := RECORD
    KEL.typ.ntyp(E_Name_Summary().Typ) UID;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE6326728 := PROJECT(__EE6326592,TRANSFORM(__ST1052296_Layout,SELF.O_N_L_Y___U_I_D_ := LEFT.U_I_D__1_,SELF := LEFT));
  SHARED __ST1053241_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nint Record_Count_;
    KEL.typ.ndataset(B_Name_Summary_4(__in,__cfg).__ST246898_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Name_Summary_4(__in,__cfg).__ST82607_Layout) Translated_Sources_;
    KEL.typ.ntyp(E_Name_Summary().Typ) U_I_D__1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC6326853(B_Name_Summary_4(__in,__cfg).__ST246891_Layout __EE6326568, __ST1052296_Layout __EE6326728) := __EEQP(__EE6326568.UID,__EE6326728.UID);
  __ST1053241_Layout __JT6326853(B_Name_Summary_4(__in,__cfg).__ST246891_Layout __l, __ST1052296_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE6326854 := JOIN(__EE6326568,__EE6326728,__JC6326853(LEFT,RIGHT),__JT6326853(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  EXPORT __ST234089_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST82656_Layout := RECORD
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
  EXPORT __ST234082_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nint Record_Count_;
    KEL.typ.ndataset(__ST234089_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST82656_Layout) Name_Summary_Source_List_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.ndataset(B_Name_Summary_4(__in,__cfg).__ST82607_Layout) Translated_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST234082_Layout __ND6327062__Project(__ST1053241_Layout __PP6326762) := TRANSFORM
    __EE6326756 := __PP6326762.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE6326756),__ST234089_Layout),__NL(__EE6326756));
    __EE6326760 := __PP6326762.Translated_Sources_;
    __ST82656_Layout __ND6327053__Project(B_Name_Summary_4(__in,__cfg).__ST82607_Layout __PP6326804) := TRANSFORM
      __CC13918 := '-99997';
      SELF.Source_Date_First_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP6326804.Date_First_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP6326804.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13918)));
      __CC13401 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('RiskTable_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Source_Date_Last_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP6326804.Date_Last_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP6326804.Date_Last_Seen_),__CC13401),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13918)));
      SELF := __PP6326804;
    END;
    SELF.Name_Summary_Source_List_ := __PROJECT(__EE6326760,__ND6327053__Project(LEFT));
    SELF.P_I_I_ := __PP6326762.O_N_L_Y___U_I_D_;
    SELF := __PP6326762;
  END;
  EXPORT __ENH_Name_Summary_3 := PROJECT(__EE6326854,__ND6327062__Project(LEFT));
END;
