//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person_9,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_8(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Input_P_I_I(__in,__cfg).__Result) __E_Input_P_I_I := E_Input_P_I_I(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Person_9(__in,__cfg).__ENH_Person_9) __ENH_Person_9 := B_Person_9(__in,__cfg).__ENH_Person_9;
  SHARED __EE1574417 := __ENH_Person_9;
  SHARED __EE1574433 := __E_Input_P_I_I;
  SHARED __EE1574440 := __EE1574433(__NN(__EE1574433.Subject_));
  SHARED __ST228284_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST228284_Layout __ND1574422__Project(E_Input_P_I_I(__in,__cfg).Layout __PP1574418) := TRANSFORM
    SELF.UID := __PP1574418.Subject_;
    SELF.U_I_D__1_ := __PP1574418.UID;
    SELF := __PP1574418;
  END;
  SHARED __EE1574431 := PROJECT(__EE1574440,__ND1574422__Project(LEFT));
  SHARED __ST228312_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE1574455 := PROJECT(__EE1574431,TRANSFORM(__ST228312_Layout,SELF.O_N_L_Y___U_I_D_ := LEFT.U_I_D__1_,SELF := LEFT));
  SHARED __ST229441_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.ndataset(B_Person_9(__in,__cfg).__ST221396_Layout) All_Lien_Data_;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1574554(B_Person_9(__in,__cfg).__ST183863_Layout __EE1574417, __ST228312_Layout __EE1574455) := __EEQP(__EE1574417.UID,__EE1574455.UID);
  __ST229441_Layout __JT1574554(B_Person_9(__in,__cfg).__ST183863_Layout __l, __ST228312_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1574555 := JOIN(__EE1574417,__EE1574455,__JC1574554(LEFT,RIGHT),__JT1574554(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  EXPORT __ST227021_Layout := RECORD
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
  EXPORT __ST183305_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.ndataset(__ST227021_Layout) All_Lien_Data_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST183305_Layout __ND1574340__Project(__ST229441_Layout __PP1573993) := TRANSFORM
    __EE1574338 := __PP1573993.All_Lien_Data_;
    __ST227021_Layout __ND1574185__Project(B_Person_9(__in,__cfg).__ST221396_Layout __PP1574181) := TRANSFORM
      __CC13322 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('liens_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Age_In_Days_ := FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,__PP1574181.Original_Filing_Date_),__ECAST(KEL.typ.nkdate,__CC13322));
      SELF.Is_Over_All_Judgment_ := __OR(__OR(__PP1574181.Is_Civil_Court_Judgment_,__PP1574181.Is_Foreclosure_Judgment_),__PP1574181.Is_Small_Cliams_Judgment_);
      SELF.Is_Over_All_Lien_ := __OR(__PP1574181.Is_Total_Tax_Lien_,__PP1574181.Is_Other_Lien_);
      SELF := __PP1574181;
    END;
    SELF.All_Lien_Data_ := __PROJECT(__EE1574338,__ND1574185__Project(LEFT));
    SELF.P_I_I_ := __PP1573993.O_N_L_Y___U_I_D_;
    SELF := __PP1573993;
  END;
  EXPORT __ENH_Person_8 := PROJECT(__EE1574555,__ND1574340__Project(LEFT));
END;
