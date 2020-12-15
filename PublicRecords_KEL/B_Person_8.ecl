//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_10,B_Person_9,CFG_Compile,E_Person,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_8(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_9(__in,__cfg).__ENH_Person_9) __ENH_Person_9 := B_Person_9(__in,__cfg).__ENH_Person_9;
  SHARED __EE4803871 := __ENH_Person_9;
  EXPORT __ST346900_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.bool Landlord_Tenant_Dispute_Flag_ := FALSE;
    KEL.typ.nkdate Original_Filing_Date_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.nbool Is_Civil_Court_Judgment_;
    KEL.typ.nbool Is_Federal_Tax_Lien_;
    KEL.typ.nbool Is_Foreclosure_Judgment_;
    KEL.typ.nbool Is_Other_Lien_;
    KEL.typ.nbool Is_Other_Tax_Lien_;
    KEL.typ.nbool Is_Over_All_Judgment_;
    KEL.typ.nbool Is_Over_All_Lien_;
    KEL.typ.nbool Is_Small_Cliams_Judgment_;
    KEL.typ.nbool Is_State_Tax_Lien_;
    KEL.typ.nbool Is_Total_Tax_Lien_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST251875_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Dunn_Data_Layout) Dunn_Data_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86226_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(__ST346900_Layout) All_Lien_Data_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86226_Layout) Curr_Addr_Full_Set_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86226_Layout) Recent_Addr_Full_Set_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST251875_Layout __ND4803876__Project(B_Person_9(__in,__cfg).__ST253912_Layout __PP4803872) := TRANSFORM
    __EE4804061 := __PP4803872.All_Lien_Data_;
    __ST346900_Layout __ND4804066__Project(B_Person_9(__in,__cfg).__ST326775_Layout __PP4804062) := TRANSFORM
      __CC13177 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('liens_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Age_In_Days_ := FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,__PP4804062.Original_Filing_Date_),__ECAST(KEL.typ.nkdate,__CC13177));
      SELF.Is_Over_All_Judgment_ := __OR(__OR(__PP4804062.Is_Civil_Court_Judgment_,__PP4804062.Is_Foreclosure_Judgment_),__PP4804062.Is_Small_Cliams_Judgment_);
      SELF.Is_Over_All_Lien_ := __OR(__PP4804062.Is_Total_Tax_Lien_,__PP4804062.Is_Other_Lien_);
      SELF := __PP4804062;
    END;
    SELF.All_Lien_Data_ := __PROJECT(__EE4804061,__ND4804066__Project(LEFT));
    __EE4804145 := __PP4803872.Recent_Addr_Full_Set_;
    __BS4804146 := __T(__EE4804145);
    __EE4804157 := __BN(TOPN(__BS4804146(__NN(__T(__EE4804145).Address_Rank_) AND __NN(__T(__EE4804145).Sort_Field_)),1,__T(__T(__EE4804145).Address_Rank_), -__T(__T(__EE4804145).Sort_Field_),__T(Address_Type_),__T(Address_Status_),__T(State_Code_),__T(County_Code_),__T(Latitude_),__T(Longitude_),__T(Geo_Blk_),__T(Addr_Full_),__T(Primary_Range_),__T(Predirectional_),__T(Primary_Name_),__T(Suffix_),__T(Postdirectional_),__T(Unit_Designation_),__T(Secondary_Range_),__T(Postal_City_),__T(State_),__T(Z_I_P5_),__T(Z_I_P4_),__T(Addr1_From_Components_)),__NL(__EE4804145));
    SELF.Curr_Addr_Full_Set_ := __EE4804157;
    SELF := __PP4803872;
  END;
  EXPORT __ENH_Person_8 := PROJECT(__EE4803871,__ND4803876__Project(LEFT));
END;
