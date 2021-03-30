//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Input_P_I_I_4,B_Name_Summary_4,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Name_Summary_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_4(__in,__cfg).__ENH_Input_P_I_I_4) __ENH_Input_P_I_I_4 := B_Input_P_I_I_4(__in,__cfg).__ENH_Input_P_I_I_4;
  SHARED VIRTUAL TYPEOF(B_Name_Summary_4(__in,__cfg).__ENH_Name_Summary_4) __ENH_Name_Summary_4 := B_Name_Summary_4(__in,__cfg).__ENH_Name_Summary_4;
  SHARED __EE6426136 := __ENH_Name_Summary_4;
  SHARED __EE6426139 := __ENH_Input_P_I_I_4;
  SHARED __EE6426146 := __EE6426139(__NN(__EE6426139.Name_Summ_));
  SHARED __ST1049596_Layout := RECORD
    KEL.typ.ntyp(E_Name_Summary().Typ) UID;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST1049596_Layout __ND6426151__Project(B_Input_P_I_I_4(__in,__cfg).__ST285244_Layout __PP6426147) := TRANSFORM
    SELF.UID := __PP6426147.Name_Summ_;
    SELF.U_I_D__1_ := __PP6426147.UID;
    SELF := __PP6426147;
  END;
  SHARED __EE6426160 := PROJECT(__EE6426146,__ND6426151__Project(LEFT));
  SHARED __ST1049624_Layout := RECORD
    KEL.typ.ntyp(E_Name_Summary().Typ) UID;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE6426301 := PROJECT(__EE6426160,TRANSFORM(__ST1049624_Layout,SELF.O_N_L_Y___U_I_D_ := LEFT.U_I_D__1_,SELF := LEFT));
  SHARED __ST1050516_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Date_Of_Birth_Padded_;
    KEL.typ.nint Record_Count_;
    KEL.typ.ndataset(B_Name_Summary_4(__in,__cfg).__ST251272_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Name_Summary_4(__in,__cfg).__ST82873_Layout) Translated_Sources_;
    KEL.typ.ntyp(E_Name_Summary().Typ) U_I_D__1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC6426431(B_Name_Summary_4(__in,__cfg).__ST251264_Layout __EE6426136, __ST1049624_Layout __EE6426301) := __EEQP(__EE6426136.UID,__EE6426301.UID);
  __ST1050516_Layout __JT6426431(B_Name_Summary_4(__in,__cfg).__ST251264_Layout __l, __ST1049624_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE6426432 := JOIN(__EE6426136,__EE6426301,__JC6426431(LEFT,RIGHT),__JT6426431(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  EXPORT __ST238319_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST82922_Layout := RECORD
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
  EXPORT __ST238311_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Date_Of_Birth_Padded_;
    KEL.typ.nint Record_Count_;
    KEL.typ.ndataset(__ST238319_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST82922_Layout) Name_Summary_Source_List_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.ndataset(B_Name_Summary_4(__in,__cfg).__ST82873_Layout) Translated_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST238311_Layout __ND6426635__Project(__ST1050516_Layout __PP6426336) := TRANSFORM
    __EE6426330 := __PP6426336.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE6426330),__ST238319_Layout),__NL(__EE6426330));
    __EE6426334 := __PP6426336.Translated_Sources_;
    __ST82922_Layout __ND6426626__Project(B_Name_Summary_4(__in,__cfg).__ST82873_Layout __PP6426381) := TRANSFORM
      __CC13942 := '-99997';
      SELF.Source_Date_First_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP6426381.Date_First_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP6426381.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13942)));
      __CC13422 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('RiskTable_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Source_Date_Last_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP6426381.Date_Last_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP6426381.Date_Last_Seen_),__CC13422),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13942)));
      SELF := __PP6426381;
    END;
    SELF.Name_Summary_Source_List_ := __PROJECT(__EE6426334,__ND6426626__Project(LEFT));
    SELF.P_I_I_ := __PP6426336.O_N_L_Y___U_I_D_;
    SELF := __PP6426336;
  END;
  EXPORT __ENH_Name_Summary_3 := PROJECT(__EE6426432,__ND6426635__Project(LEFT));
END;
