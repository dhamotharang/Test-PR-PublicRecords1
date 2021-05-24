//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Input_P_I_I_5,B_Phone_Summary_5,B_Phone_Summary_6,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Phone_Summary_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5) __ENH_Input_P_I_I_5 := B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5;
  SHARED VIRTUAL TYPEOF(B_Phone_Summary_5(__in,__cfg).__ENH_Phone_Summary_5) __ENH_Phone_Summary_5 := B_Phone_Summary_5(__in,__cfg).__ENH_Phone_Summary_5;
  SHARED __EE1714616 := __ENH_Phone_Summary_5;
  SHARED __EE1714632 := __ENH_Input_P_I_I_5;
  SHARED __EE1714639 := __EE1714632(__NN(__EE1714632.Telephone_Summary_));
  SHARED __ST334246_Layout := RECORD
    KEL.typ.ntyp(E_Phone_Summary().Typ) UID;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST334246_Layout __ND1714621__Project(B_Input_P_I_I_5(__in,__cfg).__ST182651_Layout __PP1714617) := TRANSFORM
    SELF.UID := __PP1714617.Telephone_Summary_;
    SELF.U_I_D__1_ := __PP1714617.UID;
    SELF := __PP1714617;
  END;
  SHARED __EE1714630 := PROJECT(__EE1714639,__ND1714621__Project(LEFT));
  SHARED __ST334274_Layout := RECORD
    KEL.typ.ntyp(E_Phone_Summary().Typ) UID;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE1714654 := PROJECT(__EE1714630,TRANSFORM(__ST334274_Layout,SELF.O_N_L_Y___U_I_D_ := LEFT.U_I_D__1_,SELF := LEFT));
  SHARED __ST335388_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_6(__in,__cfg).__ST176758_Layout) Address_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_6(__in,__cfg).__ST176768_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_6(__in,__cfg).__ST176784_Layout) Last_Name_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST81822_Layout) Translated_Address_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST81311_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST81563_Layout) Translated_Last_Name_Sources_;
    KEL.typ.ntyp(E_Phone_Summary().Typ) U_I_D__1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1714725(B_Phone_Summary_5(__in,__cfg).__ST174739_Layout __EE1714616, __ST334274_Layout __EE1714654) := __EEQP(__EE1714616.UID,__EE1714654.UID);
  __ST335388_Layout __JT1714725(B_Phone_Summary_5(__in,__cfg).__ST174739_Layout __l, __ST334274_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1714726 := JOIN(__EE1714616,__EE1714654,__JC1714725(LEFT,RIGHT),__JT1714725(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  EXPORT __ST332963_Layout := RECORD
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
  EXPORT __ST332972_Layout := RECORD
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
  EXPORT __ST332979_Layout := RECORD
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
  EXPORT __ST172081_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_6(__in,__cfg).__ST176758_Layout) Address_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_6(__in,__cfg).__ST176768_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_6(__in,__cfg).__ST176784_Layout) Last_Name_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.ndataset(__ST332963_Layout) Translated_Address_Sources_;
    KEL.typ.ndataset(__ST332972_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(__ST332979_Layout) Translated_Last_Name_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST172081_Layout __ND1715116__Project(__ST335388_Layout __PP1714129) := TRANSFORM
    SELF.P_I_I_ := __PP1714129.O_N_L_Y___U_I_D_;
    __EE1714448 := __PP1714129.Translated_Address_Sources_;
    __ST332963_Layout __ND1715095__Project(B_Phone_Summary_5(__in,__cfg).__ST81822_Layout __PP1714258) := TRANSFORM
      __CC14272 := '-99997';
      SELF.My_Date_First_Seen__pre_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1714258.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14272)));
      __CC13383 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('RiskTable_build_version'))),__CN(__cfg.CurrentDate));
      SELF.My_Date_Last_Seen__pre_ := IF(__T(__OR(__NT(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1714258.Date_Last_Seen_),__CN('%Y%m%d'))),__OP2(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1714258.Date_Last_Seen_),__CN('%Y%m%d')),=,__CN('')))),__ECAST(KEL.typ.nstr,__CN(__CC14272)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP1714258.Date_Last_Seen_),__CC13383),__CN('%Y%m%d'))));
      SELF := __PP1714258;
    END;
    SELF.Translated_Address_Sources_ := __PROJECT(__EE1714448,__ND1715095__Project(LEFT));
    __EE1714507 := __PP1714129.Translated_D_O_B_Sources_;
    __ST332972_Layout __ND1715121__Project(B_Phone_Summary_5(__in,__cfg).__ST81311_Layout __PP1714451) := TRANSFORM
      __CC14272 := '-99997';
      SELF.My_Date_First_Seen__pre_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1714451.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14272)));
      __CC13383 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('RiskTable_build_version'))),__CN(__cfg.CurrentDate));
      SELF.My_Date_Last_Seen__pre_ := IF(__T(__OR(__NT(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1714451.Date_Last_Seen_),__CN('%Y%m%d'))),__OP2(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1714451.Date_Last_Seen_),__CN('%Y%m%d')),=,__CN('')))),__ECAST(KEL.typ.nstr,__CN(__CC14272)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP1714451.Date_Last_Seen_),__CC13383),__CN('%Y%m%d'))));
      SELF := __PP1714451;
    END;
    SELF.Translated_D_O_B_Sources_ := __PROJECT(__EE1714507,__ND1715121__Project(LEFT));
    __EE1714565 := __PP1714129.Translated_Last_Name_Sources_;
    __ST332979_Layout __ND1715144__Project(B_Phone_Summary_5(__in,__cfg).__ST81563_Layout __PP1714509) := TRANSFORM
      __CC14272 := '-99997';
      SELF.My_Date_First_Seen__pre_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1714509.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14272)));
      __CC13383 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('RiskTable_build_version'))),__CN(__cfg.CurrentDate));
      SELF.My_Date_Last_Seen__pre_ := IF(__T(__OR(__NT(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1714509.Date_Last_Seen_),__CN('%Y%m%d'))),__OP2(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1714509.Date_Last_Seen_),__CN('%Y%m%d')),=,__CN('')))),__ECAST(KEL.typ.nstr,__CN(__CC14272)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP1714509.Date_Last_Seen_),__CC13383),__CN('%Y%m%d'))));
      SELF := __PP1714509;
    END;
    SELF.Translated_Last_Name_Sources_ := __PROJECT(__EE1714565,__ND1715144__Project(LEFT));
    SELF := __PP1714129;
  END;
  EXPORT __ENH_Phone_Summary_4 := PROJECT(__EE1714726,__ND1715116__Project(LEFT));
END;
