//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Input_P_I_I_4,B_Phone_Summary_4,B_Phone_Summary_5,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Phone_Summary_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_4(__in,__cfg).__ENH_Input_P_I_I_4) __ENH_Input_P_I_I_4 := B_Input_P_I_I_4(__in,__cfg).__ENH_Input_P_I_I_4;
  SHARED VIRTUAL TYPEOF(B_Phone_Summary_4(__in,__cfg).__ENH_Phone_Summary_4) __ENH_Phone_Summary_4 := B_Phone_Summary_4(__in,__cfg).__ENH_Phone_Summary_4;
  SHARED __EE1904382 := __ENH_Phone_Summary_4;
  SHARED __EE1904398 := __ENH_Input_P_I_I_4;
  SHARED __EE1904405 := __EE1904398(__NN(__EE1904398.Telephone_Summary_));
  SHARED __ST463342_Layout := RECORD
    KEL.typ.ntyp(E_Phone_Summary().Typ) UID;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST463342_Layout __ND1904387__Project(B_Input_P_I_I_4(__in,__cfg).__ST187449_Layout __PP1904383) := TRANSFORM
    SELF.UID := __PP1904383.Telephone_Summary_;
    SELF.U_I_D__1_ := __PP1904383.UID;
    SELF := __PP1904383;
  END;
  SHARED __EE1904396 := PROJECT(__EE1904405,__ND1904387__Project(LEFT));
  SHARED __ST463370_Layout := RECORD
    KEL.typ.ntyp(E_Phone_Summary().Typ) UID;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE1904420 := PROJECT(__EE1904396,TRANSFORM(__ST463370_Layout,SELF.O_N_L_Y___U_I_D_ := LEFT.U_I_D__1_,SELF := LEFT));
  SHARED __ST464526_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST178380_Layout) Address_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST178390_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST178406_Layout) Last_Name_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_4(__in,__cfg).__ST84971_Layout) Translated_Address_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_4(__in,__cfg).__ST84460_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_4(__in,__cfg).__ST84712_Layout) Translated_Last_Name_Sources_;
    KEL.typ.ntyp(E_Phone_Summary().Typ) U_I_D__1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1904491(B_Phone_Summary_4(__in,__cfg).__ST175755_Layout __EE1904382, __ST463370_Layout __EE1904420) := __EEQP(__EE1904382.UID,__EE1904420.UID);
  __ST464526_Layout __JT1904491(B_Phone_Summary_4(__in,__cfg).__ST175755_Layout __l, __ST463370_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1904492 := JOIN(__EE1904382,__EE1904420,__JC1904491(LEFT,RIGHT),__JT1904491(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  EXPORT __ST462031_Layout := RECORD
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
  EXPORT __ST462040_Layout := RECORD
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
  EXPORT __ST462047_Layout := RECORD
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
  EXPORT __ST172330_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST178380_Layout) Address_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST178390_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST178406_Layout) Last_Name_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.ndataset(__ST462031_Layout) Translated_Address_Sources_;
    KEL.typ.ndataset(__ST462040_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(__ST462047_Layout) Translated_Last_Name_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST172330_Layout __ND1904889__Project(__ST464526_Layout __PP1903895) := TRANSFORM
    SELF.P_I_I_ := __PP1903895.O_N_L_Y___U_I_D_;
    __EE1904214 := __PP1903895.Translated_Address_Sources_;
    __ST462031_Layout __ND1904868__Project(B_Phone_Summary_4(__in,__cfg).__ST84971_Layout __PP1904024) := TRANSFORM
      __CC14145 := '-99997';
      SELF.My_Date_First_Seen__pre_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1904024.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14145)));
      __CC13256 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('RiskTable_build_version'))),__CN(__cfg.CurrentDate));
      SELF.My_Date_Last_Seen__pre_ := IF(__T(__OR(__NT(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1904024.Date_Last_Seen_),__CN('%Y%m%d'))),__OP2(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1904024.Date_Last_Seen_),__CN('%Y%m%d')),=,__CN('')))),__ECAST(KEL.typ.nstr,__CN(__CC14145)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP1904024.Date_Last_Seen_),__CC13256),__CN('%Y%m%d'))));
      SELF := __PP1904024;
    END;
    SELF.Translated_Address_Sources_ := __PROJECT(__EE1904214,__ND1904868__Project(LEFT));
    __EE1904273 := __PP1903895.Translated_D_O_B_Sources_;
    __ST462040_Layout __ND1904894__Project(B_Phone_Summary_4(__in,__cfg).__ST84460_Layout __PP1904217) := TRANSFORM
      __CC14145 := '-99997';
      SELF.My_Date_First_Seen__pre_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1904217.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14145)));
      __CC13256 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('RiskTable_build_version'))),__CN(__cfg.CurrentDate));
      SELF.My_Date_Last_Seen__pre_ := IF(__T(__OR(__NT(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1904217.Date_Last_Seen_),__CN('%Y%m%d'))),__OP2(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1904217.Date_Last_Seen_),__CN('%Y%m%d')),=,__CN('')))),__ECAST(KEL.typ.nstr,__CN(__CC14145)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP1904217.Date_Last_Seen_),__CC13256),__CN('%Y%m%d'))));
      SELF := __PP1904217;
    END;
    SELF.Translated_D_O_B_Sources_ := __PROJECT(__EE1904273,__ND1904894__Project(LEFT));
    __EE1904331 := __PP1903895.Translated_Last_Name_Sources_;
    __ST462047_Layout __ND1904917__Project(B_Phone_Summary_4(__in,__cfg).__ST84712_Layout __PP1904275) := TRANSFORM
      __CC14145 := '-99997';
      SELF.My_Date_First_Seen__pre_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1904275.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14145)));
      __CC13256 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('RiskTable_build_version'))),__CN(__cfg.CurrentDate));
      SELF.My_Date_Last_Seen__pre_ := IF(__T(__OR(__NT(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1904275.Date_Last_Seen_),__CN('%Y%m%d'))),__OP2(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1904275.Date_Last_Seen_),__CN('%Y%m%d')),=,__CN('')))),__ECAST(KEL.typ.nstr,__CN(__CC14145)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP1904275.Date_Last_Seen_),__CC13256),__CN('%Y%m%d'))));
      SELF := __PP1904275;
    END;
    SELF.Translated_Last_Name_Sources_ := __PROJECT(__EE1904331,__ND1904917__Project(LEFT));
    SELF := __PP1903895;
  END;
  EXPORT __ENH_Phone_Summary_3 := PROJECT(__EE1904492,__ND1904889__Project(LEFT));
END;
