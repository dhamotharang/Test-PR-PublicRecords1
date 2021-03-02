//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Address_Summary_5,B_Input_P_I_I_5,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Address_Summary_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_Summary_5(__in,__cfg).__ENH_Address_Summary_5) __ENH_Address_Summary_5 := B_Address_Summary_5(__in,__cfg).__ENH_Address_Summary_5;
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5) __ENH_Input_P_I_I_5 := B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5;
  SHARED __EE5656881 := __ENH_Address_Summary_5;
  SHARED __EE5656884 := __ENH_Input_P_I_I_5;
  SHARED __EE5656891 := __EE5656884(__NN(__EE5656884.Location_Summary_));
  SHARED __ST611799_Layout := RECORD
    KEL.typ.ntyp(E_Address_Summary().Typ) UID;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST611799_Layout __ND5656896__Project(B_Input_P_I_I_5(__in,__cfg).__ST287259_Layout __PP5656892) := TRANSFORM
    SELF.UID := __PP5656892.Location_Summary_;
    SELF.U_I_D__1_ := __PP5656892.UID;
    SELF := __PP5656892;
  END;
  SHARED __EE5656905 := PROJECT(__EE5656891,__ND5656896__Project(LEFT));
  SHARED __ST611827_Layout := RECORD
    KEL.typ.ntyp(E_Address_Summary().Typ) UID;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE5657089 := PROJECT(__EE5656905,TRANSFORM(__ST611827_Layout,SELF.O_N_L_Y___U_I_D_ := LEFT.U_I_D__1_,SELF := LEFT));
  SHARED __ST612674_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Zip_;
    KEL.typ.ndataset(B_Address_Summary_5(__in,__cfg).__ST257580_Layout) Name_Summary_;
    KEL.typ.ndataset(B_Address_Summary_5(__in,__cfg).__ST257588_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ntyp(E_Address_Summary().Typ) U_I_D__1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC5657268(B_Address_Summary_5(__in,__cfg).__ST257574_Layout __EE5656881, __ST611827_Layout __EE5657089) := __EEQP(__EE5656881.UID,__EE5657089.UID);
  __ST612674_Layout __JT5657268(B_Address_Summary_5(__in,__cfg).__ST257574_Layout __l, __ST611827_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE5657269 := JOIN(__EE5656881,__EE5657089,__JC5657268(LEFT,RIGHT),__JT5657268(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  EXPORT __ST246631_Layout := RECORD
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
  EXPORT __ST246639_Layout := RECORD
    KEL.typ.nkdate Dob_Date_Of_Birth_;
    KEL.typ.nstr Dob_Source_;
    KEL.typ.nint Dob_Record_Count_;
    KEL.typ.nstr D_O_B_Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST87152_Layout := RECORD
    KEL.typ.nkdate Dob_Date_Of_Birth_;
    KEL.typ.nstr D_O_B_Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST86954_Layout := RECORD
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
  EXPORT __ST246625_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Zip_;
    KEL.typ.ndataset(__ST246631_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST246639_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST87152_Layout) D_O_B_Translated_Sources_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.ndataset(__ST86954_Layout) Translated_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST246625_Layout __ND5657511__Project(__ST612674_Layout __PP5657136) := TRANSFORM
    __EE5657122 := __PP5657136.Name_Summary_;
    SELF.Name_Summary_ := __BN(PROJECT(__T(__EE5657122),__ST246631_Layout),__NL(__EE5657122));
    __EE5657126 := __PP5657136.Date_Of_Birth_Summary_;
    SELF.Date_Of_Birth_Summary_ := __BN(PROJECT(__T(__EE5657126),__ST246639_Layout),__NL(__EE5657126));
    __EE5657130 := __PP5657136.Date_Of_Birth_Summary_;
    __BS5657209 := __T(__EE5657130);
    __EE5657497 := __BS5657209(__T(__OP2(__T(__EE5657130).D_O_B_Translated_Source_Code_,<>,__CN(''))));
    SELF.D_O_B_Translated_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE5657497,__ST87152_Layout)(__NN(Dob_Date_Of_Birth_) OR __NN(D_O_B_Translated_Source_Code_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Dob_Date_Of_Birth_,D_O_B_Translated_Source_Code_},Dob_Date_Of_Birth_,D_O_B_Translated_Source_Code_,MERGE),__ST87152_Layout));
    SELF.P_I_I_ := __PP5657136.O_N_L_Y___U_I_D_;
    __EE5657134 := __PP5657136.Name_Summary_;
    __BS5657233 := __T(__EE5657134);
    __EE5657515 := __BS5657233(__T(__OP2(__T(__EE5657134).Translated_Source_Code_,<>,__CN(''))));
    SELF.Translated_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE5657515,__ST86954_Layout)(__NN(Name_First_Name_) OR __NN(Name_Last_Name_) OR __NN(Translated_Source_Code_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Name_First_Name_,Name_Last_Name_,Translated_Source_Code_},Name_First_Name_,Name_Last_Name_,Translated_Source_Code_,MERGE),__ST86954_Layout));
    SELF := __PP5657136;
  END;
  EXPORT __ENH_Address_Summary_4 := PROJECT(PROJECT(__EE5657269,__ND5657511__Project(LEFT)),__ST246625_Layout);
END;
