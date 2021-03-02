//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_Address_Slim,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Address_Slim_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Address_Slim(__in,__cfg).__Result) __E_Address_Slim := E_Address_Slim(__in,__cfg).__Result;
  SHARED __EE610634 := __E_Address_Slim;
  EXPORT __ST81228_Layout := RECORD
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
  EXPORT __ST81122_Layout := RECORD
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
  EXPORT __ST246555_Layout := RECORD
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
    KEL.typ.ndataset(__ST81228_Layout) Address_N_I_A_C_S_High_Risk_Pre_;
    KEL.typ.ndataset(__ST81122_Layout) Address_S_I_C_High_Risk_Pre_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST246555_Layout __ND610858__Project(E_Address_Slim(__in,__cfg).Layout __PP610469) := TRANSFORM
    __EE610544 := __PP610469.High_Risk_Address_;
    __ST81228_Layout __ND610783__Project(E_Address_Slim(__in,__cfg).High_Risk_Address_Layout __PP610779) := TRANSFORM
      SELF.Date_First_Seen_Min_Address_N_A_I_C_S_ := KEL.era.ToDate(__PP610779.Date_First_Seen_);
      SELF.Date_Last_Seen_Min_Adress_N_A_I_C_S_ := KEL.era.ToDate(__PP610779.Date_Last_Seen_);
      SELF := __PP610779;
    END;
    SELF.Address_N_I_A_C_S_High_Risk_Pre_ := __BN(PROJECT(TABLE(PROJECT(__T(__EE610544),__ND610783__Project(LEFT))(__NN(High_Risk_N_A_I_C_S_) OR __NN(Date_First_Seen_Min_Address_N_A_I_C_S_) OR __NN(Date_Last_Seen_Min_Adress_N_A_I_C_S_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),High_Risk_N_A_I_C_S_,Date_First_Seen_Min_Address_N_A_I_C_S_,Date_Last_Seen_Min_Adress_N_A_I_C_S_},High_Risk_N_A_I_C_S_,Date_First_Seen_Min_Address_N_A_I_C_S_,Date_Last_Seen_Min_Adress_N_A_I_C_S_,MERGE),__ST81228_Layout),__NL(__EE610544));
    __EE610580 := __PP610469.High_Risk_Address_;
    __ST81122_Layout __ND610843__Project(E_Address_Slim(__in,__cfg).High_Risk_Address_Layout __PP610839) := TRANSFORM
      SELF.Date_First_Seen_Min_Address_S_I_C_ := KEL.era.ToDate(__PP610839.Date_First_Seen_);
      SELF.Date_Last_Seen_Min_Address_S_I_C_ := KEL.era.ToDate(__PP610839.Date_Last_Seen_);
      SELF := __PP610839;
    END;
    SELF.Address_S_I_C_High_Risk_Pre_ := __BN(PROJECT(TABLE(PROJECT(__T(__EE610580),__ND610843__Project(LEFT))(__NN(High_Risk_S_I_C_) OR __NN(Date_First_Seen_Min_Address_S_I_C_) OR __NN(Date_Last_Seen_Min_Address_S_I_C_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),High_Risk_S_I_C_,Date_First_Seen_Min_Address_S_I_C_,Date_Last_Seen_Min_Address_S_I_C_},High_Risk_S_I_C_,Date_First_Seen_Min_Address_S_I_C_,Date_Last_Seen_Min_Address_S_I_C_,MERGE),__ST81122_Layout),__NL(__EE610580));
    SELF := __PP610469;
  END;
  EXPORT __ENH_Address_Slim_4 := PROJECT(PROJECT(__EE610634,__ND610858__Project(LEFT)),__ST246555_Layout);
END;
