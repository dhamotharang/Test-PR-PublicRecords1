//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_Address_Slim,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Address_Slim_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Address_Slim(__in,__cfg).__Result) __E_Address_Slim := E_Address_Slim(__in,__cfg).__Result;
  SHARED __EE611019 := __E_Address_Slim;
  EXPORT __ST78908_Layout := RECORD
    KEL.typ.nint High_Risk_N_A_I_C_S_;
    KEL.typ.nkdate Date_First_Seen_Min_Address_N_A_I_C_S_;
    KEL.typ.nkdate Date_Last_Seen_Min_Adress_N_A_I_C_S_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST78802_Layout := RECORD
    KEL.typ.nint High_Risk_S_I_C_;
    KEL.typ.nkdate Date_First_Seen_Min_Address_S_I_C_;
    KEL.typ.nkdate Date_Last_Seen_Min_Address_S_I_C_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST244353_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ndataset(E_Address_Slim(__in,__cfg).High_Risk_Address_Layout) High_Risk_Address_;
    KEL.typ.ndataset(E_Address_Slim(__in,__cfg).Address_Type_Layout) Address_Type_;
    KEL.typ.nstr Source_;
    KEL.typ.ndataset(__ST78908_Layout) Address_N_I_A_C_S_High_Risk_Pre_;
    KEL.typ.ndataset(__ST78802_Layout) Address_S_I_C_High_Risk_Pre_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST244353_Layout __ND611243__Project(E_Address_Slim(__in,__cfg).Layout __PP610854) := TRANSFORM
    __EE610929 := __PP610854.High_Risk_Address_;
    __ST78908_Layout __ND611168__Project(E_Address_Slim(__in,__cfg).High_Risk_Address_Layout __PP611164) := TRANSFORM
      SELF.Date_First_Seen_Min_Address_N_A_I_C_S_ := KEL.era.ToDate(__PP611164.Date_First_Seen_);
      SELF.Date_Last_Seen_Min_Adress_N_A_I_C_S_ := KEL.era.ToDate(__PP611164.Date_Last_Seen_);
      SELF := __PP611164;
    END;
    SELF.Address_N_I_A_C_S_High_Risk_Pre_ := __BN(PROJECT(TABLE(PROJECT(__T(__EE610929),__ND611168__Project(LEFT))(__NN(High_Risk_N_A_I_C_S_) OR __NN(Date_First_Seen_Min_Address_N_A_I_C_S_) OR __NN(Date_Last_Seen_Min_Adress_N_A_I_C_S_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),High_Risk_N_A_I_C_S_,Date_First_Seen_Min_Address_N_A_I_C_S_,Date_Last_Seen_Min_Adress_N_A_I_C_S_},High_Risk_N_A_I_C_S_,Date_First_Seen_Min_Address_N_A_I_C_S_,Date_Last_Seen_Min_Adress_N_A_I_C_S_,MERGE),__ST78908_Layout),__NL(__EE610929));
    __EE610965 := __PP610854.High_Risk_Address_;
    __ST78802_Layout __ND611228__Project(E_Address_Slim(__in,__cfg).High_Risk_Address_Layout __PP611224) := TRANSFORM
      SELF.Date_First_Seen_Min_Address_S_I_C_ := KEL.era.ToDate(__PP611224.Date_First_Seen_);
      SELF.Date_Last_Seen_Min_Address_S_I_C_ := KEL.era.ToDate(__PP611224.Date_Last_Seen_);
      SELF := __PP611224;
    END;
    SELF.Address_S_I_C_High_Risk_Pre_ := __BN(PROJECT(TABLE(PROJECT(__T(__EE610965),__ND611228__Project(LEFT))(__NN(High_Risk_S_I_C_) OR __NN(Date_First_Seen_Min_Address_S_I_C_) OR __NN(Date_Last_Seen_Min_Address_S_I_C_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),High_Risk_S_I_C_,Date_First_Seen_Min_Address_S_I_C_,Date_Last_Seen_Min_Address_S_I_C_},High_Risk_S_I_C_,Date_First_Seen_Min_Address_S_I_C_,Date_Last_Seen_Min_Address_S_I_C_,MERGE),__ST78802_Layout),__NL(__EE610965));
    SELF := __PP610854;
  END;
  EXPORT __ENH_Address_Slim_4 := PROJECT(PROJECT(__EE611019,__ND611243__Project(LEFT)),__ST244353_Layout);
END;
