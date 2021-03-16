//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Address_Slim_3,B_Address_Slim_4,B_Input_P_I_I_3,B_Input_P_I_I_4,B_Inquiry_4,B_Person_10,B_Person_4,B_Person_5,B_Person_6,B_Person_Accident_8,B_Person_Inquiry_5,B_Property_4,CFG_Compile,E_Accident,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Household,E_Input_P_I_I,E_Inquiry,E_Name_Summary,E_Person,E_Person_Accident,E_Person_Inquiry,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Utility,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Address_Slim_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_Slim_3(__in,__cfg).__ENH_Address_Slim_3) __ENH_Address_Slim_3 := B_Address_Slim_3(__in,__cfg).__ENH_Address_Slim_3;
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_3(__in,__cfg).__ENH_Input_P_I_I_3) __ENH_Input_P_I_I_3 := B_Input_P_I_I_3(__in,__cfg).__ENH_Input_P_I_I_3;
  SHARED __EE6975008 := __ENH_Address_Slim_3;
  SHARED __EE6975024 := __ENH_Input_P_I_I_3;
  SHARED __EE6975031 := __EE6975024(__NN(__EE6975024.Slim_Location_));
  SHARED __ST1306340_Layout := RECORD
    KEL.typ.ntyp(E_Address_Slim().Typ) UID;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST1306340_Layout __ND6975013__Project(B_Input_P_I_I_3(__in,__cfg).__ST1048167_Layout __PP6975009) := TRANSFORM
    SELF.UID := __PP6975009.Slim_Location_;
    SELF.U_I_D__1_ := __PP6975009.UID;
    SELF := __PP6975009;
  END;
  SHARED __EE6975022 := PROJECT(__EE6975031,__ND6975013__Project(LEFT));
  SHARED __ST1306368_Layout := RECORD
    KEL.typ.ntyp(E_Address_Slim().Typ) UID;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE6975046 := PROJECT(__EE6975022,TRANSFORM(__ST1306368_Layout,SELF.O_N_L_Y___U_I_D_ := LEFT.U_I_D__1_,SELF := LEFT));
  SHARED __ST1307572_Layout := RECORD
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
    KEL.typ.ndataset(B_Address_Slim_3(__in,__cfg).__ST81832_Layout) Address_N_A_I_C_S_List_;
    KEL.typ.ndataset(B_Address_Slim_4(__in,__cfg).__ST81809_Layout) Address_N_I_A_C_S_High_Risk_Pre_;
    KEL.typ.ndataset(B_Address_Slim_4(__in,__cfg).__ST81703_Layout) Address_S_I_C_High_Risk_Pre_;
    KEL.typ.ndataset(B_Address_Slim_3(__in,__cfg).__ST81739_Layout) Address_S_I_C_List_;
    KEL.typ.ntyp(E_Address_Slim().Typ) U_I_D__1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC6975098(B_Address_Slim_3(__in,__cfg).__ST233336_Layout __EE6975008, __ST1306368_Layout __EE6975046) := __EEQP(__EE6975008.UID,__EE6975046.UID);
  __ST1307572_Layout __JT6975098(B_Address_Slim_3(__in,__cfg).__ST233336_Layout __l, __ST1306368_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE6975099 := JOIN(__EE6975008,__EE6975046,__JC6975098(LEFT,RIGHT),__JT6975098(LEFT,RIGHT),LEFT OUTER,SMART,KEEP(1));
  EXPORT __ST214202_Layout := RECORD
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
    KEL.typ.ndataset(B_Address_Slim_3(__in,__cfg).__ST81832_Layout) Address_N_A_I_C_S_List_;
    KEL.typ.ndataset(B_Address_Slim_3(__in,__cfg).__ST81832_Layout) Address_N_A_I_C_S_Sorted_List_;
    KEL.typ.ndataset(B_Address_Slim_3(__in,__cfg).__ST81739_Layout) Address_S_I_C_List_;
    KEL.typ.ndataset(B_Address_Slim_3(__in,__cfg).__ST81739_Layout) Address_S_I_C_Sorted_List_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST214202_Layout __ND6974940__Project(__ST1307572_Layout __PP6974740) := TRANSFORM
    __EE6974934 := __PP6974740.Address_N_A_I_C_S_List_;
    __BS6974922 := __T(__EE6974934);
    __EE6974938 := __BN(TOPN(__BS6974922(__NN(__T(__EE6974934).Address_N_A_I_C_S_Date_First_Seen_) AND __NN(__T(__EE6974934).Address_N_A_I_C_S_Date_Last_Seen_)),1000,__T(__T(__EE6974934).Address_N_A_I_C_S_Date_First_Seen_),__T(__T(__EE6974934).Address_N_A_I_C_S_Date_Last_Seen_),__T(High_Risk_N_A_I_C_S_)),__NL(__EE6974934));
    SELF.Address_N_A_I_C_S_Sorted_List_ := __EE6974938;
    __EE6974959 := __PP6974740.Address_S_I_C_List_;
    __BS6974947 := __T(__EE6974959);
    __EE6974963 := __BN(TOPN(__BS6974947(__NN(__T(__EE6974959).Address_S_I_C_Date_First_Seen_) AND __NN(__T(__EE6974959).Address_S_I_C_Date_Last_Seen_)),1000,__T(__T(__EE6974959).Address_S_I_C_Date_First_Seen_),__T(__T(__EE6974959).Address_S_I_C_Date_Last_Seen_),__T(High_Risk_S_I_C_)),__NL(__EE6974959));
    SELF.Address_S_I_C_Sorted_List_ := __EE6974963;
    SELF.P_I_I_ := __PP6974740.O_N_L_Y___U_I_D_;
    SELF := __PP6974740;
  END;
  EXPORT __ENH_Address_Slim_2 := PROJECT(__EE6975099,__ND6974940__Project(LEFT));
END;
