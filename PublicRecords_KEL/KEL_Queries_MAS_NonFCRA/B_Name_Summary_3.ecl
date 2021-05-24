//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Input_P_I_I_4,B_Name_Summary_4,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Name_Summary_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_4(__in,__cfg).__ENH_Input_P_I_I_4) __ENH_Input_P_I_I_4 := B_Input_P_I_I_4(__in,__cfg).__ENH_Input_P_I_I_4;
  SHARED VIRTUAL TYPEOF(B_Name_Summary_4(__in,__cfg).__ENH_Name_Summary_4) __ENH_Name_Summary_4 := B_Name_Summary_4(__in,__cfg).__ENH_Name_Summary_4;
  SHARED __EE1722268 := __ENH_Name_Summary_4;
  SHARED __EE1722271 := __ENH_Input_P_I_I_4;
  SHARED __EE1722278 := __EE1722271(__NN(__EE1722271.Name_Summ_));
  SHARED __ST352826_Layout := RECORD
    KEL.typ.ntyp(E_Name_Summary().Typ) UID;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST352826_Layout __ND1722283__Project(B_Input_P_I_I_4(__in,__cfg).__ST183070_Layout __PP1722279) := TRANSFORM
    SELF.UID := __PP1722279.Name_Summ_;
    SELF.U_I_D__1_ := __PP1722279.UID;
    SELF := __PP1722279;
  END;
  SHARED __EE1722292 := PROJECT(__EE1722278,__ND1722283__Project(LEFT));
  SHARED __ST352854_Layout := RECORD
    KEL.typ.ntyp(E_Name_Summary().Typ) UID;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE1722433 := PROJECT(__EE1722292,TRANSFORM(__ST352854_Layout,SELF.O_N_L_Y___U_I_D_ := LEFT.U_I_D__1_,SELF := LEFT));
  SHARED __ST353914_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Date_Of_Birth_Padded_;
    KEL.typ.nint Record_Count_;
    KEL.typ.ndataset(B_Name_Summary_4(__in,__cfg).__ST170457_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Name_Summary_4(__in,__cfg).__ST83056_Layout) Translated_Sources_;
    KEL.typ.ntyp(E_Name_Summary().Typ) U_I_D__1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1722563(B_Name_Summary_4(__in,__cfg).__ST170449_Layout __EE1722268, __ST352854_Layout __EE1722433) := __EEQP(__EE1722268.UID,__EE1722433.UID);
  __ST353914_Layout __JT1722563(B_Name_Summary_4(__in,__cfg).__ST170449_Layout __l, __ST352854_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1722564 := JOIN(__EE1722268,__EE1722433,__JC1722563(LEFT,RIGHT),__JT1722563(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  EXPORT __ST166047_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST83105_Layout := RECORD
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
  EXPORT __ST166039_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Date_Of_Birth_Padded_;
    KEL.typ.nint Record_Count_;
    KEL.typ.ndataset(__ST166047_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST83105_Layout) Name_Summary_Source_List_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.ndataset(B_Name_Summary_4(__in,__cfg).__ST83056_Layout) Translated_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST166039_Layout __ND1722795__Project(__ST353914_Layout __PP1722468) := TRANSFORM
    __EE1722462 := __PP1722468.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE1722462),__ST166047_Layout),__NL(__EE1722462));
    __EE1722466 := __PP1722468.Translated_Sources_;
    __ST83105_Layout __ND1722786__Project(B_Name_Summary_4(__in,__cfg).__ST83056_Layout __PP1722513) := TRANSFORM
      __CC14248 := '-99997';
      SELF.Source_Date_First_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP1722513.Date_First_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1722513.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14248)));
      __CC13559 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('RiskTable_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Source_Date_Last_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP1722513.Date_Last_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP1722513.Date_Last_Seen_),__CC13559),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14248)));
      SELF := __PP1722513;
    END;
    SELF.Name_Summary_Source_List_ := __PROJECT(__EE1722466,__ND1722786__Project(LEFT));
    SELF.P_I_I_ := __PP1722468.O_N_L_Y___U_I_D_;
    SELF := __PP1722468;
  END;
  EXPORT __ENH_Name_Summary_3 := PROJECT(__EE1722564,__ND1722795__Project(LEFT));
END;
