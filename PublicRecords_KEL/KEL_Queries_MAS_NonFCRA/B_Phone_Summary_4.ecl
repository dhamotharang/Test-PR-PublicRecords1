//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Input_P_I_I_5,B_Phone_Summary_5,B_Phone_Summary_6,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Phone_Summary_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5) __ENH_Input_P_I_I_5 := B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5;
  SHARED VIRTUAL TYPEOF(B_Phone_Summary_5(__in,__cfg).__ENH_Phone_Summary_5) __ENH_Phone_Summary_5 := B_Phone_Summary_5(__in,__cfg).__ENH_Phone_Summary_5;
  SHARED __EE1742067 := __ENH_Phone_Summary_5;
  SHARED __EE1742083 := __ENH_Input_P_I_I_5;
  SHARED __EE1742090 := __EE1742083(__NN(__EE1742083.Telephone_Summary_));
  SHARED __ST345062_Layout := RECORD
    KEL.typ.ntyp(E_Phone_Summary().Typ) UID;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST345062_Layout __ND1742072__Project(B_Input_P_I_I_5(__in,__cfg).__ST189766_Layout __PP1742068) := TRANSFORM
    SELF.UID := __PP1742068.Telephone_Summary_;
    SELF.U_I_D__1_ := __PP1742068.UID;
    SELF := __PP1742068;
  END;
  SHARED __EE1742081 := PROJECT(__EE1742090,__ND1742072__Project(LEFT));
  SHARED __ST345090_Layout := RECORD
    KEL.typ.ntyp(E_Phone_Summary().Typ) UID;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE1742105 := PROJECT(__EE1742081,TRANSFORM(__ST345090_Layout,SELF.O_N_L_Y___U_I_D_ := LEFT.U_I_D__1_,SELF := LEFT));
  SHARED __ST346204_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_6(__in,__cfg).__ST182687_Layout) Address_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_6(__in,__cfg).__ST182697_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_6(__in,__cfg).__ST182713_Layout) Last_Name_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST84929_Layout) Translated_Address_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST84418_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST84670_Layout) Translated_Last_Name_Sources_;
    KEL.typ.ntyp(E_Phone_Summary().Typ) U_I_D__1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1742176(B_Phone_Summary_5(__in,__cfg).__ST180668_Layout __EE1742067, __ST345090_Layout __EE1742105) := __EEQP(__EE1742067.UID,__EE1742105.UID);
  __ST346204_Layout __JT1742176(B_Phone_Summary_5(__in,__cfg).__ST180668_Layout __l, __ST345090_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1742177 := JOIN(__EE1742067,__EE1742105,__JC1742176(LEFT,RIGHT),__JT1742176(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  EXPORT __ST343779_Layout := RECORD
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
  EXPORT __ST343788_Layout := RECORD
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
  EXPORT __ST343795_Layout := RECORD
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
  EXPORT __ST177997_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_6(__in,__cfg).__ST182687_Layout) Address_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_6(__in,__cfg).__ST182697_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_6(__in,__cfg).__ST182713_Layout) Last_Name_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.ndataset(__ST343779_Layout) Translated_Address_Sources_;
    KEL.typ.ndataset(__ST343788_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(__ST343795_Layout) Translated_Last_Name_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST177997_Layout __ND1742567__Project(__ST346204_Layout __PP1741580) := TRANSFORM
    SELF.P_I_I_ := __PP1741580.O_N_L_Y___U_I_D_;
    __EE1741899 := __PP1741580.Translated_Address_Sources_;
    __ST343779_Layout __ND1742546__Project(B_Phone_Summary_5(__in,__cfg).__ST84929_Layout __PP1741709) := TRANSFORM
      __CC14145 := '-99997';
      SELF.My_Date_First_Seen__pre_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1741709.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14145)));
      __CC13256 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('RiskTable_build_version'))),__CN(__cfg.CurrentDate));
      SELF.My_Date_Last_Seen__pre_ := IF(__T(__OR(__NT(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1741709.Date_Last_Seen_),__CN('%Y%m%d'))),__OP2(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1741709.Date_Last_Seen_),__CN('%Y%m%d')),=,__CN('')))),__ECAST(KEL.typ.nstr,__CN(__CC14145)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP1741709.Date_Last_Seen_),__CC13256),__CN('%Y%m%d'))));
      SELF := __PP1741709;
    END;
    SELF.Translated_Address_Sources_ := __PROJECT(__EE1741899,__ND1742546__Project(LEFT));
    __EE1741958 := __PP1741580.Translated_D_O_B_Sources_;
    __ST343788_Layout __ND1742572__Project(B_Phone_Summary_5(__in,__cfg).__ST84418_Layout __PP1741902) := TRANSFORM
      __CC14145 := '-99997';
      SELF.My_Date_First_Seen__pre_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1741902.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14145)));
      __CC13256 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('RiskTable_build_version'))),__CN(__cfg.CurrentDate));
      SELF.My_Date_Last_Seen__pre_ := IF(__T(__OR(__NT(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1741902.Date_Last_Seen_),__CN('%Y%m%d'))),__OP2(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1741902.Date_Last_Seen_),__CN('%Y%m%d')),=,__CN('')))),__ECAST(KEL.typ.nstr,__CN(__CC14145)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP1741902.Date_Last_Seen_),__CC13256),__CN('%Y%m%d'))));
      SELF := __PP1741902;
    END;
    SELF.Translated_D_O_B_Sources_ := __PROJECT(__EE1741958,__ND1742572__Project(LEFT));
    __EE1742016 := __PP1741580.Translated_Last_Name_Sources_;
    __ST343795_Layout __ND1742595__Project(B_Phone_Summary_5(__in,__cfg).__ST84670_Layout __PP1741960) := TRANSFORM
      __CC14145 := '-99997';
      SELF.My_Date_First_Seen__pre_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1741960.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14145)));
      __CC13256 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('RiskTable_build_version'))),__CN(__cfg.CurrentDate));
      SELF.My_Date_Last_Seen__pre_ := IF(__T(__OR(__NT(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1741960.Date_Last_Seen_),__CN('%Y%m%d'))),__OP2(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1741960.Date_Last_Seen_),__CN('%Y%m%d')),=,__CN('')))),__ECAST(KEL.typ.nstr,__CN(__CC14145)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP1741960.Date_Last_Seen_),__CC13256),__CN('%Y%m%d'))));
      SELF := __PP1741960;
    END;
    SELF.Translated_Last_Name_Sources_ := __PROJECT(__EE1742016,__ND1742595__Project(LEFT));
    SELF := __PP1741580;
  END;
  EXPORT __ENH_Phone_Summary_4 := PROJECT(__EE1742177,__ND1742567__Project(LEFT));
END;
