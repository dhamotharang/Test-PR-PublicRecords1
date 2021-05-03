//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Input_P_I_I_5,B_Phone_Summary_5,B_Phone_Summary_6,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Phone_Summary_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5) __ENH_Input_P_I_I_5 := B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5;
  SHARED VIRTUAL TYPEOF(B_Phone_Summary_5(__in,__cfg).__ENH_Phone_Summary_5) __ENH_Phone_Summary_5 := B_Phone_Summary_5(__in,__cfg).__ENH_Phone_Summary_5;
  SHARED __EE1711842 := __ENH_Phone_Summary_5;
  SHARED __EE1711858 := __ENH_Input_P_I_I_5;
  SHARED __EE1711865 := __EE1711858(__NN(__EE1711858.Telephone_Summary_));
  SHARED __ST332650_Layout := RECORD
    KEL.typ.ntyp(E_Phone_Summary().Typ) UID;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST332650_Layout __ND1711847__Project(B_Input_P_I_I_5(__in,__cfg).__ST181353_Layout __PP1711843) := TRANSFORM
    SELF.UID := __PP1711843.Telephone_Summary_;
    SELF.U_I_D__1_ := __PP1711843.UID;
    SELF := __PP1711843;
  END;
  SHARED __EE1711856 := PROJECT(__EE1711865,__ND1711847__Project(LEFT));
  SHARED __ST332678_Layout := RECORD
    KEL.typ.ntyp(E_Phone_Summary().Typ) UID;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE1711880 := PROJECT(__EE1711856,TRANSFORM(__ST332678_Layout,SELF.O_N_L_Y___U_I_D_ := LEFT.U_I_D__1_,SELF := LEFT));
  SHARED __ST333768_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_6(__in,__cfg).__ST175488_Layout) Address_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_6(__in,__cfg).__ST175498_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_6(__in,__cfg).__ST175514_Layout) Last_Name_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST81179_Layout) Translated_Address_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST80668_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST80920_Layout) Translated_Last_Name_Sources_;
    KEL.typ.ntyp(E_Phone_Summary().Typ) U_I_D__1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1711951(B_Phone_Summary_5(__in,__cfg).__ST173477_Layout __EE1711842, __ST332678_Layout __EE1711880) := __EEQP(__EE1711842.UID,__EE1711880.UID);
  __ST333768_Layout __JT1711951(B_Phone_Summary_5(__in,__cfg).__ST173477_Layout __l, __ST332678_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1711952 := JOIN(__EE1711842,__EE1711880,__JC1711951(LEFT,RIGHT),__JT1711951(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  EXPORT __ST331383_Layout := RECORD
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
  EXPORT __ST331392_Layout := RECORD
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
  EXPORT __ST331399_Layout := RECORD
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
  EXPORT __ST170827_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_6(__in,__cfg).__ST175488_Layout) Address_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_6(__in,__cfg).__ST175498_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_6(__in,__cfg).__ST175514_Layout) Last_Name_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.ndataset(__ST331383_Layout) Translated_Address_Sources_;
    KEL.typ.ndataset(__ST331392_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(__ST331399_Layout) Translated_Last_Name_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST170827_Layout __ND1712338__Project(__ST333768_Layout __PP1711355) := TRANSFORM
    SELF.P_I_I_ := __PP1711355.O_N_L_Y___U_I_D_;
    __EE1711674 := __PP1711355.Translated_Address_Sources_;
    __ST331383_Layout __ND1712317__Project(B_Phone_Summary_5(__in,__cfg).__ST81179_Layout __PP1711484) := TRANSFORM
      __CC14268 := '-99997';
      SELF.My_Date_First_Seen__pre_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1711484.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14268)));
      __CC13379 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('RiskTable_build_version'))),__CN(__cfg.CurrentDate));
      SELF.My_Date_Last_Seen__pre_ := IF(__T(__OR(__NT(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1711484.Date_Last_Seen_),__CN('%Y%m%d'))),__OP2(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1711484.Date_Last_Seen_),__CN('%Y%m%d')),=,__CN('')))),__ECAST(KEL.typ.nstr,__CN(__CC14268)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP1711484.Date_Last_Seen_),__CC13379),__CN('%Y%m%d'))));
      SELF := __PP1711484;
    END;
    SELF.Translated_Address_Sources_ := __PROJECT(__EE1711674,__ND1712317__Project(LEFT));
    __EE1711733 := __PP1711355.Translated_D_O_B_Sources_;
    __ST331392_Layout __ND1712343__Project(B_Phone_Summary_5(__in,__cfg).__ST80668_Layout __PP1711677) := TRANSFORM
      __CC14268 := '-99997';
      SELF.My_Date_First_Seen__pre_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1711677.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14268)));
      __CC13379 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('RiskTable_build_version'))),__CN(__cfg.CurrentDate));
      SELF.My_Date_Last_Seen__pre_ := IF(__T(__OR(__NT(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1711677.Date_Last_Seen_),__CN('%Y%m%d'))),__OP2(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1711677.Date_Last_Seen_),__CN('%Y%m%d')),=,__CN('')))),__ECAST(KEL.typ.nstr,__CN(__CC14268)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP1711677.Date_Last_Seen_),__CC13379),__CN('%Y%m%d'))));
      SELF := __PP1711677;
    END;
    SELF.Translated_D_O_B_Sources_ := __PROJECT(__EE1711733,__ND1712343__Project(LEFT));
    __EE1711791 := __PP1711355.Translated_Last_Name_Sources_;
    __ST331399_Layout __ND1712366__Project(B_Phone_Summary_5(__in,__cfg).__ST80920_Layout __PP1711735) := TRANSFORM
      __CC14268 := '-99997';
      SELF.My_Date_First_Seen__pre_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1711735.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14268)));
      __CC13379 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('RiskTable_build_version'))),__CN(__cfg.CurrentDate));
      SELF.My_Date_Last_Seen__pre_ := IF(__T(__OR(__NT(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1711735.Date_Last_Seen_),__CN('%Y%m%d'))),__OP2(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP1711735.Date_Last_Seen_),__CN('%Y%m%d')),=,__CN('')))),__ECAST(KEL.typ.nstr,__CN(__CC14268)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP1711735.Date_Last_Seen_),__CC13379),__CN('%Y%m%d'))));
      SELF := __PP1711735;
    END;
    SELF.Translated_Last_Name_Sources_ := __PROJECT(__EE1711791,__ND1712366__Project(LEFT));
    SELF := __PP1711355;
  END;
  EXPORT __ENH_Phone_Summary_4 := PROJECT(__EE1711952,__ND1712338__Project(LEFT));
END;
