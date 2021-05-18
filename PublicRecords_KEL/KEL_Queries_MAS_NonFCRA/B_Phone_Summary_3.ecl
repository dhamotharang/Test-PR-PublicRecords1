//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Input_P_I_I_4,B_Phone_Summary_4,B_Phone_Summary_5,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Phone_Summary_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_4(__in,__cfg).__ENH_Input_P_I_I_4) __ENH_Input_P_I_I_4 := B_Input_P_I_I_4(__in,__cfg).__ENH_Input_P_I_I_4;
  SHARED VIRTUAL TYPEOF(B_Phone_Summary_4(__in,__cfg).__ENH_Phone_Summary_4) __ENH_Phone_Summary_4 := B_Phone_Summary_4(__in,__cfg).__ENH_Phone_Summary_4;
  SHARED __EE1914165 := __ENH_Phone_Summary_4;
  SHARED __EE1914181 := __ENH_Input_P_I_I_4;
  SHARED __EE1914188 := __EE1914181(__NN(__EE1914181.Telephone_Summary_));
  SHARED __ST465523_Layout := RECORD
    KEL.typ.ntyp(E_Phone_Summary().Typ) UID;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST465523_Layout __ND1914170__Project(B_Input_P_I_I_4(__in,__cfg).__ST187085_Layout __PP1914166) := TRANSFORM
    SELF.UID := __PP1914166.Telephone_Summary_;
    SELF.U_I_D__1_ := __PP1914166.UID;
    SELF := __PP1914166;
  END;
  SHARED __EE1914179 := PROJECT(__EE1914188,__ND1914170__Project(LEFT));
  SHARED __ST465551_Layout := RECORD
    KEL.typ.ntyp(E_Phone_Summary().Typ) UID;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE1914203 := PROJECT(__EE1914179,TRANSFORM(__ST465551_Layout,SELF.O_N_L_Y___U_I_D_ := LEFT.U_I_D__1_,SELF := LEFT));
  SHARED __ST466707_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST177761_Layout) Address_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST177771_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST177787_Layout) Last_Name_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_4(__in,__cfg).__ST84564_Layout) Translated_Address_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_4(__in,__cfg).__ST84053_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_4(__in,__cfg).__ST84305_Layout) Translated_Last_Name_Sources_;
    KEL.typ.ntyp(E_Phone_Summary().Typ) U_I_D__1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1914274(B_Phone_Summary_4(__in,__cfg).__ST175132_Layout __EE1914165, __ST465551_Layout __EE1914203) := __EEQP(__EE1914165.UID,__EE1914203.UID);
  __ST466707_Layout __JT1914274(B_Phone_Summary_4(__in,__cfg).__ST175132_Layout __l, __ST465551_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1914275 := JOIN(__EE1914165,__EE1914203,__JC1914274(LEFT,RIGHT),__JT1914274(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  EXPORT __ST464212_Layout := RECORD
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Zip_;
    KEL.typ.nstr Source_;
    KEL.typ.nstr My_Date_First_Seen__pre_;
    KEL.typ.nstr My_Date_Last_Seen__pre_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST464221_Layout := RECORD
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Source_;
    KEL.typ.nstr My_Date_First_Seen__pre_;
    KEL.typ.nstr My_Date_Last_Seen__pre_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST464228_Layout := RECORD
    KEL.typ.nstr Last_Name_;
    KEL.typ.nstr Source_;
    KEL.typ.nstr My_Date_First_Seen__pre_;
    KEL.typ.nstr My_Date_Last_Seen__pre_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST171701_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST177761_Layout) Address_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST177771_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST177787_Layout) Last_Name_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.ndataset(__ST464212_Layout) Translated_Address_Sources_;
    KEL.typ.ndataset(__ST464221_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(__ST464228_Layout) Translated_Last_Name_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST171701_Layout __ND1914672__Project(__ST466707_Layout __PP1913678) := TRANSFORM
    SELF.P_I_I_ := __PP1913678.O_N_L_Y___U_I_D_;
    __EE1913997 := __PP1913678.Translated_Address_Sources_;
    __ST464212_Layout __ND1914651__Project(B_Phone_Summary_4(__in,__cfg).__ST84564_Layout __PP1913807) := TRANSFORM
      __CC14067 := '-99997';
      SELF.My_Date_First_Seen__pre_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1913807.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14067)));
      __CC13178 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('RiskTable_build_version'))),__CN(__cfg.CurrentDate));
      SELF.My_Date_Last_Seen__pre_ := IF(__T(__OR(__NT(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1913807.Date_Last_Seen_),__CN('%Y%m%d'))),__OP2(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1913807.Date_Last_Seen_),__CN('%Y%m%d')),=,__CN('')))),__ECAST(KEL.typ.nstr,__CN(__CC14067)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP1913807.Date_Last_Seen_),__CC13178),__CN('%Y%m%d'))));
      SELF := __PP1913807;
    END;
    SELF.Translated_Address_Sources_ := __PROJECT(__EE1913997,__ND1914651__Project(LEFT));
    __EE1914056 := __PP1913678.Translated_D_O_B_Sources_;
    __ST464221_Layout __ND1914677__Project(B_Phone_Summary_4(__in,__cfg).__ST84053_Layout __PP1914000) := TRANSFORM
      __CC14067 := '-99997';
      SELF.My_Date_First_Seen__pre_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1914000.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14067)));
      __CC13178 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('RiskTable_build_version'))),__CN(__cfg.CurrentDate));
      SELF.My_Date_Last_Seen__pre_ := IF(__T(__OR(__NT(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1914000.Date_Last_Seen_),__CN('%Y%m%d'))),__OP2(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1914000.Date_Last_Seen_),__CN('%Y%m%d')),=,__CN('')))),__ECAST(KEL.typ.nstr,__CN(__CC14067)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP1914000.Date_Last_Seen_),__CC13178),__CN('%Y%m%d'))));
      SELF := __PP1914000;
    END;
    SELF.Translated_D_O_B_Sources_ := __PROJECT(__EE1914056,__ND1914677__Project(LEFT));
    __EE1914114 := __PP1913678.Translated_Last_Name_Sources_;
    __ST464228_Layout __ND1914700__Project(B_Phone_Summary_4(__in,__cfg).__ST84305_Layout __PP1914058) := TRANSFORM
      __CC14067 := '-99997';
      SELF.My_Date_First_Seen__pre_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1914058.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14067)));
      __CC13178 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('RiskTable_build_version'))),__CN(__cfg.CurrentDate));
      SELF.My_Date_Last_Seen__pre_ := IF(__T(__OR(__NT(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1914058.Date_Last_Seen_),__CN('%Y%m%d'))),__OP2(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1914058.Date_Last_Seen_),__CN('%Y%m%d')),=,__CN('')))),__ECAST(KEL.typ.nstr,__CN(__CC14067)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP1914058.Date_Last_Seen_),__CC13178),__CN('%Y%m%d'))));
      SELF := __PP1914058;
    END;
    SELF.Translated_Last_Name_Sources_ := __PROJECT(__EE1914114,__ND1914700__Project(LEFT));
    SELF := __PP1913678;
  END;
  EXPORT __ENH_Phone_Summary_3 := PROJECT(__EE1914275,__ND1914672__Project(LEFT));
END;
