//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Input_P_I_I_5,B_S_S_N_Summary_5,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_S_S_N_Summary_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5) __ENH_Input_P_I_I_5 := B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5;
  SHARED VIRTUAL TYPEOF(B_S_S_N_Summary_5(__in,__cfg).__ENH_S_S_N_Summary_5) __ENH_S_S_N_Summary_5 := B_S_S_N_Summary_5(__in,__cfg).__ENH_S_S_N_Summary_5;
  SHARED __EE1709656 := __ENH_S_S_N_Summary_5;
  SHARED __EE1709659 := __ENH_Input_P_I_I_5;
  SHARED __EE1709666 := __EE1709659(__NN(__EE1709659.Social_Summary_));
  SHARED __ST346548_Layout := RECORD
    KEL.typ.ntyp(E_S_S_N_Summary().Typ) UID;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST346548_Layout __ND1709671__Project(B_Input_P_I_I_5(__in,__cfg).__ST186666_Layout __PP1709667) := TRANSFORM
    SELF.UID := __PP1709667.Social_Summary_;
    SELF.U_I_D__1_ := __PP1709667.UID;
    SELF := __PP1709667;
  END;
  SHARED __EE1709680 := PROJECT(__EE1709666,__ND1709671__Project(LEFT));
  SHARED __ST346576_Layout := RECORD
    KEL.typ.ntyp(E_S_S_N_Summary().Typ) UID;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE1709991 := PROJECT(__EE1709680,TRANSFORM(__ST346576_Layout,SELF.O_N_L_Y___U_I_D_ := LEFT.U_I_D__1_,SELF := LEFT));
  SHARED __ST347591_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(B_S_S_N_Summary_5(__in,__cfg).__ST178071_Layout) Address_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_5(__in,__cfg).__ST178080_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_5(__in,__cfg).__ST178088_Layout) Name_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_5(__in,__cfg).__ST178096_Layout) Phone_Summary_;
    KEL.typ.ntyp(E_S_S_N_Summary().Typ) U_I_D__1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1710309(B_S_S_N_Summary_5(__in,__cfg).__ST178067_Layout __EE1709656, __ST346576_Layout __EE1709991) := __EEQP(__EE1709656.UID,__EE1709991.UID);
  __ST347591_Layout __JT1710309(B_S_S_N_Summary_5(__in,__cfg).__ST178067_Layout __l, __ST346576_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1710310 := JOIN(__EE1709656,__EE1709991,__JC1710309(LEFT,RIGHT),__JT1710309(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  EXPORT __ST175589_Layout := RECORD
    KEL.typ.nstr Address_Primary_Name_;
    KEL.typ.nstr Address_Primary_Range_;
    KEL.typ.nstr Address_Zip_;
    KEL.typ.nstr Address_Source_;
    KEL.typ.nint Address_Record_Count_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST175598_Layout := RECORD
    KEL.typ.nkdate Dob_Date_Of_Birth_;
    KEL.typ.nstr Dob_Date_Of_Birth_Padded_;
    KEL.typ.nstr Dob_Source_;
    KEL.typ.nint Dob_Record_Count_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST175606_Layout := RECORD
    KEL.typ.nstr Name_First_Name_;
    KEL.typ.nstr Name_Last_Name_;
    KEL.typ.nstr Name_Source_;
    KEL.typ.nint Name_Record_Count_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST175614_Layout := RECORD
    KEL.typ.nint Phone_Number_;
    KEL.typ.nstr Phone_Source_;
    KEL.typ.nint Phone_Record_Count_;
    KEL.typ.nstr Phone_Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST85292_Layout := RECORD
    KEL.typ.nint Phone_Number_;
    KEL.typ.nstr Phone_Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST85157_Layout := RECORD
    KEL.typ.nkdate Dob_Date_Of_Birth_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST85444_Layout := RECORD
    KEL.typ.nstr Name_First_Name_;
    KEL.typ.nstr Name_Last_Name_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST84940_Layout := RECORD
    KEL.typ.nstr Address_Primary_Name_;
    KEL.typ.nstr Address_Primary_Range_;
    KEL.typ.nstr Address_Zip_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST175585_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST175589_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST175598_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST175606_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST175614_Layout) Phone_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.ndataset(__ST85292_Layout) Phone_Translated_Sources_;
    KEL.typ.ndataset(__ST85157_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(__ST85444_Layout) Translated_Fn_Ln_Sources_;
    KEL.typ.ndataset(__ST84940_Layout) Translated_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST175585_Layout __ND1710660__Project(__ST347591_Layout __PP1710067) := TRANSFORM
    __EE1710037 := __PP1710067.Address_Summary_;
    SELF.Address_Summary_ := __BN(PROJECT(__T(__EE1710037),__ST175589_Layout),__NL(__EE1710037));
    __EE1710041 := __PP1710067.Date_Of_Birth_Summary_;
    SELF.Date_Of_Birth_Summary_ := __BN(PROJECT(__T(__EE1710041),__ST175598_Layout),__NL(__EE1710041));
    __EE1710045 := __PP1710067.Name_Summary_;
    SELF.Name_Summary_ := __BN(PROJECT(__T(__EE1710045),__ST175606_Layout),__NL(__EE1710045));
    __EE1710049 := __PP1710067.Phone_Summary_;
    SELF.Phone_Summary_ := __BN(PROJECT(__T(__EE1710049),__ST175614_Layout),__NL(__EE1710049));
    SELF.P_I_I_ := __PP1710067.O_N_L_Y___U_I_D_;
    __EE1710053 := __PP1710067.Phone_Summary_;
    __BS1710198 := __T(__EE1710053);
    __EE1710646 := __BS1710198(__T(__OP2(__T(__EE1710053).Phone_Translated_Source_Code_,<>,__CN(''))));
    SELF.Phone_Translated_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE1710646,__ST85292_Layout)(__NN(Phone_Number_) OR __NN(Phone_Translated_Source_Code_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Phone_Number_,Phone_Translated_Source_Code_},Phone_Number_,Phone_Translated_Source_Code_,MERGE),__ST85292_Layout));
    __EE1710057 := __PP1710067.Date_Of_Birth_Summary_;
    __BS1710220 := __T(__EE1710057);
    __EE1710664 := __BS1710220(__T(__OP2(__T(__EE1710057).Translated_Source_Code_,<>,__CN(''))));
    SELF.Translated_D_O_B_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE1710664,__ST85157_Layout)(__NN(Dob_Date_Of_Birth_) OR __NN(Translated_Source_Code_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Dob_Date_Of_Birth_,Translated_Source_Code_},Dob_Date_Of_Birth_,Translated_Source_Code_,MERGE),__ST85157_Layout));
    __EE1710061 := __PP1710067.Name_Summary_;
    __BS1710242 := __T(__EE1710061);
    __EE1710681 := __BS1710242(__T(__OP2(__T(__EE1710061).Translated_Source_Code_,<>,__CN(''))));
    SELF.Translated_Fn_Ln_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE1710681,__ST85444_Layout)(__NN(Name_First_Name_) OR __NN(Name_Last_Name_) OR __NN(Translated_Source_Code_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Name_First_Name_,Name_Last_Name_,Translated_Source_Code_},Name_First_Name_,Name_Last_Name_,Translated_Source_Code_,MERGE),__ST85444_Layout));
    __EE1710065 := __PP1710067.Address_Summary_;
    __BS1710268 := __T(__EE1710065);
    __EE1710702 := __BS1710268(__T(__OP2(__T(__EE1710065).Translated_Source_Code_,<>,__CN(''))));
    SELF.Translated_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE1710702,__ST84940_Layout)(__NN(Address_Primary_Name_) OR __NN(Address_Primary_Range_) OR __NN(Address_Zip_) OR __NN(Translated_Source_Code_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Address_Primary_Name_,Address_Primary_Range_,Address_Zip_,Translated_Source_Code_},Address_Primary_Name_,Address_Primary_Range_,Address_Zip_,Translated_Source_Code_,MERGE),__ST84940_Layout));
    SELF := __PP1710067;
  END;
  EXPORT __ENH_S_S_N_Summary_4 := PROJECT(PROJECT(__EE1710310,__ND1710660__Project(LEFT)),__ST175585_Layout);
END;
