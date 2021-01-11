﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Input_P_I_I_5,B_Phone_Summary_5,CFG_Compile,E_Address,E_Email,E_Geo_Link,E_Input_P_I_I,E_Person,E_Phone,E_Phone_Summary,E_Property,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Phone_Summary_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5) __ENH_Input_P_I_I_5 := B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5;
  SHARED VIRTUAL TYPEOF(B_Phone_Summary_5(__in,__cfg).__ENH_Phone_Summary_5) __ENH_Phone_Summary_5 := B_Phone_Summary_5(__in,__cfg).__ENH_Phone_Summary_5;
  SHARED __EE5123354 := __ENH_Phone_Summary_5;
  EXPORT __ST264752_Layout := RECORD
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Zip_;
    KEL.typ.nint Record_Count_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST264762_Layout := RECORD
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nint Record_Count_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST264777_Layout := RECORD
    KEL.typ.nstr Last_Name_;
    KEL.typ.nint Record_Count_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST684680_Layout := RECORD
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
  EXPORT __ST684689_Layout := RECORD
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
  EXPORT __ST684696_Layout := RECORD
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
  EXPORT __ST264739_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(__ST264752_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST264762_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(__ST264777_Layout) Last_Name_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.ndataset(__ST684680_Layout) Translated_Address_Sources_;
    KEL.typ.ndataset(__ST684689_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(__ST684696_Layout) Translated_Last_Name_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST264739_Layout __ND5123122__Project(B_Phone_Summary_5(__in,__cfg).__ST264540_Layout __PP5122571) := TRANSFORM
    __EE5123357 := __PP5122571.Address_Summary_;
    SELF.Address_Summary_ := __BN(PROJECT(__T(__EE5123357),__ST264752_Layout),__NL(__EE5123357));
    __EE5123360 := __PP5122571.Date_Of_Birth_Summary_;
    SELF.Date_Of_Birth_Summary_ := __BN(PROJECT(__T(__EE5123360),__ST264762_Layout),__NL(__EE5123360));
    __EE5123363 := __PP5122571.Last_Name_Summary_;
    SELF.Last_Name_Summary_ := __BN(PROJECT(__T(__EE5123363),__ST264777_Layout),__NL(__EE5123363));
    __EE5123119 := __ENH_Input_P_I_I_5;
    SELF.P_I_I_ := (__EE5123119)[1].UID;
    __EE5123194 := __PP5122571.Translated_Address_Sources_;
    __ST684680_Layout __ND5123127__Project(B_Phone_Summary_5(__in,__cfg).__ST72087_Layout __PP5123123) := TRANSFORM
      __CC13719 := '-99997';
      SELF.My_Date_First_Seen__pre_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP5123123.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13719)));
      __CC13033 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('pii_corr_build_version'))),__CN(__cfg.CurrentDate));
      SELF.My_Date_Last_Seen__pre_ := IF(__T(__OR(__NT(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP5123123.Date_Last_Seen_),__CN('%Y%m%d'))),__OP2(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP5123123.Date_Last_Seen_),__CN('%Y%m%d')),=,__CN('')))),__ECAST(KEL.typ.nstr,__CN(__CC13719)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP5123123.Date_Last_Seen_),__CC13033),__CN('%Y%m%d'))));
      SELF := __PP5123123;
    END;
    SELF.Translated_Address_Sources_ := __PROJECT(__EE5123194,__ND5123127__Project(LEFT));
    __EE5123259 := __PP5122571.Translated_D_O_B_Sources_;
    __ST684689_Layout __ND5123200__Project(B_Phone_Summary_5(__in,__cfg).__ST71576_Layout __PP5123196) := TRANSFORM
      __CC13719 := '-99997';
      SELF.My_Date_First_Seen__pre_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP5123196.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13719)));
      __CC13033 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('pii_corr_build_version'))),__CN(__cfg.CurrentDate));
      SELF.My_Date_Last_Seen__pre_ := IF(__T(__OR(__NT(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP5123196.Date_Last_Seen_),__CN('%Y%m%d'))),__OP2(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP5123196.Date_Last_Seen_),__CN('%Y%m%d')),=,__CN('')))),__ECAST(KEL.typ.nstr,__CN(__CC13719)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP5123196.Date_Last_Seen_),__CC13033),__CN('%Y%m%d'))));
      SELF := __PP5123196;
    END;
    SELF.Translated_D_O_B_Sources_ := __PROJECT(__EE5123259,__ND5123200__Project(LEFT));
    __EE5123324 := __PP5122571.Translated_Last_Name_Sources_;
    __ST684696_Layout __ND5123265__Project(B_Phone_Summary_5(__in,__cfg).__ST71828_Layout __PP5123261) := TRANSFORM
      __CC13719 := '-99997';
      SELF.My_Date_First_Seen__pre_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP5123261.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13719)));
      __CC13033 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('pii_corr_build_version'))),__CN(__cfg.CurrentDate));
      SELF.My_Date_Last_Seen__pre_ := IF(__T(__OR(__NT(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP5123261.Date_Last_Seen_),__CN('%Y%m%d'))),__OP2(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP5123261.Date_Last_Seen_),__CN('%Y%m%d')),=,__CN('')))),__ECAST(KEL.typ.nstr,__CN(__CC13719)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP5123261.Date_Last_Seen_),__CC13033),__CN('%Y%m%d'))));
      SELF := __PP5123261;
    END;
    SELF.Translated_Last_Name_Sources_ := __PROJECT(__EE5123324,__ND5123265__Project(LEFT));
    SELF := __PP5122571;
  END;
  EXPORT __ENH_Phone_Summary_4 := PROJECT(__EE5123354,__ND5123122__Project(LEFT));
END;
