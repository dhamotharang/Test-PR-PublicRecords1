//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Input_P_I_I_5,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Consumer;
IMPORT * FROM KEL16.Null;
EXPORT B_Input_P_I_I_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5) __ENH_Input_P_I_I_5 := B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5;
  SHARED VIRTUAL TYPEOF(E_Phone(__in,__cfg).__Result) __E_Phone := E_Phone(__in,__cfg).__Result;
  SHARED __EE295553 := __ENH_Input_P_I_I_5;
  SHARED __EE173554 := __E_Phone;
  SHARED __EE300644 := __EE295553(__NN(__EE295553.Input_Clean_Phone_));
  __JC298900(E_Phone(__in,__cfg).Layout __EE173554, B_Input_P_I_I_5(__in,__cfg).__ST156695_Layout __EE300644) := __EEQP(__EE300644.Input_Clean_Phone_,__EE173554.UID);
  SHARED __EE298901 := JOIN(__EE173554,__EE300644,__JC298900(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST174209_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.nstr Serv_;
    KEL.typ.nstr Line_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Listing_Types_Layout) Listing_Types_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Phone_Type_Information_Layout) Phone_Type_Information_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Targus_Information_Layout) Targus_Information_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).I_Verification_Information_Layout) I_Verification_Information_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Phones_Plus_Information_Layout) Phones_Plus_Information_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Phone_Transaction_Information_Layout) Phone_Transaction_Information_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Gong_Phone_Information_Layout) Gong_Phone_Information_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).High_Risk_Phone_Layout) High_Risk_Phone_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nint High_Risk_S_I_C_;
    KEL.typ.nint High_Risk_N_A_I_C_S_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __ST174209_Layout __JT298984(E_Phone(__in,__cfg).Layout __l, E_Phone(__in,__cfg).High_Risk_Phone_Layout __r) := TRANSFORM
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE298985 := NORMALIZE(__EE298901,__T(LEFT.High_Risk_Phone_),__JT298984(LEFT,RIGHT));
  SHARED __ST305585_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint High_Risk_N_A_I_C_S_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE305589 := PROJECT(TABLE(PROJECT(__EE298985,__ST305585_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),UID,High_Risk_N_A_I_C_S_},UID,High_Risk_N_A_I_C_S_,MERGE),__ST305585_Layout);
  SHARED __ST305603_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nstr P___Inp_Acct_;
    KEL.typ.nint P___Inp_Lex_I_D_;
    KEL.typ.nstr P___Inp_Name_First_;
    KEL.typ.nstr P___Inp_Name_Mid_;
    KEL.typ.nstr P___Inp_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Surname1_;
    KEL.typ.nstr P___Inp_Cln_Surname2_;
    KEL.typ.ntyp(E_Surname().Typ) Last_Name1_;
    KEL.typ.ntyp(E_Surname().Typ) Last_Name2_;
    KEL.typ.nstr Address_Geo_Link_;
    KEL.typ.nstr P___Inp_Addr_Line1_;
    KEL.typ.nstr P___Inp_Addr_Line2_;
    KEL.typ.nstr P___Inp_Addr_City_;
    KEL.typ.nstr P___Inp_Addr_State_;
    KEL.typ.nstr P___Inp_Addr_Zip_;
    KEL.typ.nstr P___Inp_Phone_Home_;
    KEL.typ.nstr P___Inp_S_S_N_;
    KEL.typ.nstr P___Inp_D_O_B_;
    KEL.typ.nstr P___Inp_Phone_Work_;
    KEL.typ.nstr Input_Income_Echo_;
    KEL.typ.nstr P___Inp_D_L_;
    KEL.typ.nstr P___Inp_D_L_State_;
    KEL.typ.nstr Input_Balance_Echo_;
    KEL.typ.nstr Input_Charge_Offd_Echo_;
    KEL.typ.nstr Input_Former_Name_Echo_;
    KEL.typ.nstr P___Inp_Email_;
    KEL.typ.nstr P___Inp_I_P_Addr_;
    KEL.typ.nstr Input_Employment_Echo_;
    KEL.typ.nstr P___Inp_Arch_Dt_;
    KEL.typ.nint P___Lex_I_D_;
    KEL.typ.nint P___Lex_I_D_Score_;
    KEL.typ.nstr P___Inp_Cln_Name_Prfx_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Mid_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Name_Sffx_;
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr P___Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Unit_Desig_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_Post_;
    KEL.typ.nstr P___Inp_Cln_Addr_State_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip4_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lat_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lng_;
    KEL.typ.nstr P___Inp_Cln_Addr_State_Code_;
    KEL.typ.nstr P___Inp_Cln_Addr_Cnty_;
    KEL.typ.nstr P___Inp_Cln_Addr_Geo_;
    KEL.typ.ntyp(E_Geo_Link().Typ) Geo_Link_I_D_;
    KEL.typ.nstr P___Inp_Cln_Addr_Type_;
    KEL.typ.nstr P___Inp_Cln_Addr_Status_;
    KEL.typ.nstr P___Inp_Cln_Email_;
    KEL.typ.ntyp(E_Email().Typ) Input_Clean_Email_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.ntyp(E_Phone().Typ) Input_Clean_Phone_;
    KEL.typ.nstr P___Inp_Cln_Phone_Work_;
    KEL.typ.nstr P___Inp_Cln_D_L_;
    KEL.typ.nstr P___Inp_Cln_D_L_State_;
    KEL.typ.nkdate P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Input_Clean_S_S_N_;
    KEL.typ.nint P___Inp_Cln_Arch_Dt_;
    KEL.typ.nint G___Proc_Bus_U_I_D_;
    KEL.typ.nstr Phone_Verification_Bureau_;
    KEL.typ.nstr Dial_Indicator_;
    KEL.typ.nstr Point_I_D_;
    KEL.typ.nstr N_X_X_Type_;
    KEL.typ.nbool Z_I_P_Match_;
    KEL.typ.nstr C_O_C_Type_;
    KEL.typ.nstr S_S_C_;
    KEL.typ.nstr Wireless_Indicator_;
    KEL.typ.nint Rep_Number_;
    KEL.typ.ntyp(E_Address_Slim().Typ) Slim_Location_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ntyp(E_S_S_N_Summary().Typ) Social_Summary_;
    KEL.typ.ntyp(E_Name_Summary().Typ) Name_Summ_;
    KEL.typ.ntyp(E_Phone_Summary().Typ) Telephone_Summary_;
    KEL.typ.ntyp(E_Address_Summary().Typ) Location_Summary_;
    KEL.typ.nstr Current_Addr_Prim_Rng_;
    KEL.typ.nstr Current_Addr_Pre_Dir_;
    KEL.typ.nstr Current_Addr_Prim_Name_;
    KEL.typ.nstr Current_Addr_Sffx_;
    KEL.typ.nstr Current_Addr_Sec_Rng_;
    KEL.typ.nstr Current_Addr_State_;
    KEL.typ.nstr Current_Addr_Zip5_;
    KEL.typ.nstr Current_Addr_Zip4_;
    KEL.typ.nstr Current_Addr_State_Code_;
    KEL.typ.nstr Current_Addr_Cnty_;
    KEL.typ.nstr Current_Addr_Geo_;
    KEL.typ.nstr Current_Addr_City_;
    KEL.typ.nstr Current_Addr_Post_Dir_;
    KEL.typ.nstr Current_Addr_Lat_;
    KEL.typ.nstr Current_Addr_Lng_;
    KEL.typ.nstr Current_Addr_Unit_Designation_;
    KEL.typ.nstr Current_Addr_Type_;
    KEL.typ.nstr Current_Addr_Status_;
    KEL.typ.nkdate Current_Addr_Date_First_Seen_;
    KEL.typ.nkdate Current_Addr_Date_Last_Seen_;
    KEL.typ.nstr Current_Addr_Full_;
    KEL.typ.ntyp(E_Address().Typ) Current_Address_;
    KEL.typ.nstr Previous_Addr_Prim_Rng_;
    KEL.typ.nstr Previous_Addr_Pre_Dir_;
    KEL.typ.nstr Previous_Addr_Prim_Name_;
    KEL.typ.nstr Previous_Addr_Sffx_;
    KEL.typ.nstr Previous_Addr_Sec_Rng_;
    KEL.typ.nstr Previous_Addr_State_;
    KEL.typ.nstr Previous_Addr_Zip5_;
    KEL.typ.nstr Previous_Addr_Zip4_;
    KEL.typ.nstr Previous_Addr_State_Code_;
    KEL.typ.nstr Previous_Addr_Cnty_;
    KEL.typ.nstr Previous_Addr_Geo_;
    KEL.typ.nstr Previous_Addr_City_;
    KEL.typ.nstr Previous_Addr_Post_Dir_;
    KEL.typ.nstr Previous_Addr_Lat_;
    KEL.typ.nstr Previous_Addr_Lng_;
    KEL.typ.nstr Previous_Addr_Unit_Designation_;
    KEL.typ.nstr Previous_Addr_Type_;
    KEL.typ.nstr Previous_Addr_Status_;
    KEL.typ.nkdate Previous_Addr_Date_First_Seen_;
    KEL.typ.nkdate Previous_Addr_Date_Last_Seen_;
    KEL.typ.nstr Previous_Addr_Full_;
    KEL.typ.ntyp(E_Address().Typ) Previous_Address_;
    KEL.typ.bool Addr_Not_Populated_ := FALSE;
    KEL.typ.nbool City_State_Zip_Not_Populated_;
    KEL.typ.nbool Clean_City_State_Zip_Not_Populated_;
    KEL.typ.nint D_P_P_A_Purpose_;
    KEL.typ.nint G_L_B_Purpose_;
    KEL.typ.nbool Gateway_Is_F_C_R_A_;
    KEL.typ.nstr Input_Address_Suffix_Clean_Value_;
    KEL.typ.nstr Input_City_Clean_Value_;
    KEL.typ.nstr Input_Post_Direction_Clean_Value_;
    KEL.typ.nstr Input_Pre_Direction_Clean_Value_;
    KEL.typ.nstr Input_Primary_Name_Clean_Value_;
    KEL.typ.nstr Input_Primary_Range_Clean_Value_;
    KEL.typ.nstr Input_Secondary_Range_Clean_Value_;
    KEL.typ.nstr Input_State_Clean_Value_;
    KEL.typ.nstr Input_Street_Clean_Value_;
    KEL.typ.nstr Input_Unit_Desig_Clean_Value_;
    KEL.typ.nstr Input_Zip4_Clean_Value_;
    KEL.typ.nstr Input_Zip5_Clean_Value_;
    KEL.typ.nstr P___Inp_Addr_;
    KEL.typ.str P___Inp_Addr_City_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_State_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_Zip_Flag_Value_ := '';
    KEL.typ.nstr P___Inp_Cln_Addr_St_Flag_Value_;
    KEL.typ.nstr Targus_Gateway_I_P_;
    KEL.typ.ndataset(__ST305585_Layout) Input_Clean_Phone__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC305600(B_Input_P_I_I_5(__in,__cfg).__ST156695_Layout __EE295553, __ST305585_Layout __EE305589) := __EEQP(__EE295553.Input_Clean_Phone_,__EE305589.UID);
  __ST305603_Layout __Join__ST305603_Layout(B_Input_P_I_I_5(__in,__cfg).__ST156695_Layout __r, DATASET(__ST305585_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Input_Clean_Phone__1_ := __CN(__recs);
  END;
  SHARED __EE305601 := DENORMALIZE(DISTRIBUTE(__EE295553,HASH(Input_Clean_Phone_)),DISTRIBUTE(__EE305589,HASH(UID)),__JC305600(LEFT,RIGHT),GROUP,__Join__ST305603_Layout(LEFT,ROWS(RIGHT)),LOCAL,SMART);
  SHARED __EE304284 := __EE173554;
  SHARED __ST305769_Layout := RECORD
    KEL.typ.ntyp(E_Phone().Typ) Input_Clean_Phone_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE305772 := PROJECT(TABLE(PROJECT(__EE295553,__ST305769_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Input_Clean_Phone_},Input_Clean_Phone_,MERGE),__ST305769_Layout);
  SHARED __ST305790_Layout := RECORD
    KEL.typ.ntyp(E_Phone().Typ) Input_Clean_Phone_;
    KEL.typ.ndataset(__ST305585_Layout) Input_Clean_Phone__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC305787(__ST305769_Layout __EE305772, __ST305585_Layout __EE305589) := __EEQP(__EE305772.Input_Clean_Phone_,__EE305589.UID);
  __ST305790_Layout __Join__ST305790_Layout(__ST305769_Layout __r, DATASET(__ST305585_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Input_Clean_Phone__1_ := __CN(__recs);
  END;
  SHARED __EE305788 := DENORMALIZE(DISTRIBUTE(__EE305772,HASH(Input_Clean_Phone_)),DISTRIBUTE(__EE305589,HASH(UID)),__JC305787(LEFT,RIGHT),GROUP,__Join__ST305790_Layout(LEFT,ROWS(RIGHT)),LOCAL,SMART);
  SHARED __EE305803 := __EE305788(__NN(__EE305788.Input_Clean_Phone_));
  __JC305809(E_Phone(__in,__cfg).Layout __EE304284, __ST305790_Layout __EE305803) := __EEQP(__EE305803.Input_Clean_Phone_,__EE304284.UID);
  SHARED __EE305879 := JOIN(__EE304284,__EE305803,__JC305809(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST174321_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.nstr Serv_;
    KEL.typ.nstr Line_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Listing_Types_Layout) Listing_Types_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Phone_Type_Information_Layout) Phone_Type_Information_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Targus_Information_Layout) Targus_Information_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).I_Verification_Information_Layout) I_Verification_Information_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Phones_Plus_Information_Layout) Phones_Plus_Information_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Phone_Transaction_Information_Layout) Phone_Transaction_Information_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Gong_Phone_Information_Layout) Gong_Phone_Information_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).High_Risk_Phone_Layout) High_Risk_Phone_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nint High_Risk_S_I_C_;
    KEL.typ.nint High_Risk_N_A_I_C_S_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __ST174321_Layout __JT305962(E_Phone(__in,__cfg).Layout __l, E_Phone(__in,__cfg).High_Risk_Phone_Layout __r) := TRANSFORM
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE306035 := NORMALIZE(__EE305879,__T(LEFT.High_Risk_Phone_),__JT305962(LEFT,RIGHT));
  SHARED __ST306355_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint High_Risk_S_I_C_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE306359 := PROJECT(TABLE(PROJECT(__EE306035,__ST306355_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),UID,High_Risk_S_I_C_},UID,High_Risk_S_I_C_,MERGE),__ST306355_Layout);
  SHARED __ST306373_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nstr P___Inp_Acct_;
    KEL.typ.nint P___Inp_Lex_I_D_;
    KEL.typ.nstr P___Inp_Name_First_;
    KEL.typ.nstr P___Inp_Name_Mid_;
    KEL.typ.nstr P___Inp_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Surname1_;
    KEL.typ.nstr P___Inp_Cln_Surname2_;
    KEL.typ.ntyp(E_Surname().Typ) Last_Name1_;
    KEL.typ.ntyp(E_Surname().Typ) Last_Name2_;
    KEL.typ.nstr Address_Geo_Link_;
    KEL.typ.nstr P___Inp_Addr_Line1_;
    KEL.typ.nstr P___Inp_Addr_Line2_;
    KEL.typ.nstr P___Inp_Addr_City_;
    KEL.typ.nstr P___Inp_Addr_State_;
    KEL.typ.nstr P___Inp_Addr_Zip_;
    KEL.typ.nstr P___Inp_Phone_Home_;
    KEL.typ.nstr P___Inp_S_S_N_;
    KEL.typ.nstr P___Inp_D_O_B_;
    KEL.typ.nstr P___Inp_Phone_Work_;
    KEL.typ.nstr Input_Income_Echo_;
    KEL.typ.nstr P___Inp_D_L_;
    KEL.typ.nstr P___Inp_D_L_State_;
    KEL.typ.nstr Input_Balance_Echo_;
    KEL.typ.nstr Input_Charge_Offd_Echo_;
    KEL.typ.nstr Input_Former_Name_Echo_;
    KEL.typ.nstr P___Inp_Email_;
    KEL.typ.nstr P___Inp_I_P_Addr_;
    KEL.typ.nstr Input_Employment_Echo_;
    KEL.typ.nstr P___Inp_Arch_Dt_;
    KEL.typ.nint P___Lex_I_D_;
    KEL.typ.nint P___Lex_I_D_Score_;
    KEL.typ.nstr P___Inp_Cln_Name_Prfx_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Mid_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Name_Sffx_;
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr P___Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Unit_Desig_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_Post_;
    KEL.typ.nstr P___Inp_Cln_Addr_State_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip4_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lat_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lng_;
    KEL.typ.nstr P___Inp_Cln_Addr_State_Code_;
    KEL.typ.nstr P___Inp_Cln_Addr_Cnty_;
    KEL.typ.nstr P___Inp_Cln_Addr_Geo_;
    KEL.typ.ntyp(E_Geo_Link().Typ) Geo_Link_I_D_;
    KEL.typ.nstr P___Inp_Cln_Addr_Type_;
    KEL.typ.nstr P___Inp_Cln_Addr_Status_;
    KEL.typ.nstr P___Inp_Cln_Email_;
    KEL.typ.ntyp(E_Email().Typ) Input_Clean_Email_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.ntyp(E_Phone().Typ) Input_Clean_Phone_;
    KEL.typ.nstr P___Inp_Cln_Phone_Work_;
    KEL.typ.nstr P___Inp_Cln_D_L_;
    KEL.typ.nstr P___Inp_Cln_D_L_State_;
    KEL.typ.nkdate P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Input_Clean_S_S_N_;
    KEL.typ.nint P___Inp_Cln_Arch_Dt_;
    KEL.typ.nint G___Proc_Bus_U_I_D_;
    KEL.typ.nstr Phone_Verification_Bureau_;
    KEL.typ.nstr Dial_Indicator_;
    KEL.typ.nstr Point_I_D_;
    KEL.typ.nstr N_X_X_Type_;
    KEL.typ.nbool Z_I_P_Match_;
    KEL.typ.nstr C_O_C_Type_;
    KEL.typ.nstr S_S_C_;
    KEL.typ.nstr Wireless_Indicator_;
    KEL.typ.nint Rep_Number_;
    KEL.typ.ntyp(E_Address_Slim().Typ) Slim_Location_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ntyp(E_S_S_N_Summary().Typ) Social_Summary_;
    KEL.typ.ntyp(E_Name_Summary().Typ) Name_Summ_;
    KEL.typ.ntyp(E_Phone_Summary().Typ) Telephone_Summary_;
    KEL.typ.ntyp(E_Address_Summary().Typ) Location_Summary_;
    KEL.typ.nstr Current_Addr_Prim_Rng_;
    KEL.typ.nstr Current_Addr_Pre_Dir_;
    KEL.typ.nstr Current_Addr_Prim_Name_;
    KEL.typ.nstr Current_Addr_Sffx_;
    KEL.typ.nstr Current_Addr_Sec_Rng_;
    KEL.typ.nstr Current_Addr_State_;
    KEL.typ.nstr Current_Addr_Zip5_;
    KEL.typ.nstr Current_Addr_Zip4_;
    KEL.typ.nstr Current_Addr_State_Code_;
    KEL.typ.nstr Current_Addr_Cnty_;
    KEL.typ.nstr Current_Addr_Geo_;
    KEL.typ.nstr Current_Addr_City_;
    KEL.typ.nstr Current_Addr_Post_Dir_;
    KEL.typ.nstr Current_Addr_Lat_;
    KEL.typ.nstr Current_Addr_Lng_;
    KEL.typ.nstr Current_Addr_Unit_Designation_;
    KEL.typ.nstr Current_Addr_Type_;
    KEL.typ.nstr Current_Addr_Status_;
    KEL.typ.nkdate Current_Addr_Date_First_Seen_;
    KEL.typ.nkdate Current_Addr_Date_Last_Seen_;
    KEL.typ.nstr Current_Addr_Full_;
    KEL.typ.ntyp(E_Address().Typ) Current_Address_;
    KEL.typ.nstr Previous_Addr_Prim_Rng_;
    KEL.typ.nstr Previous_Addr_Pre_Dir_;
    KEL.typ.nstr Previous_Addr_Prim_Name_;
    KEL.typ.nstr Previous_Addr_Sffx_;
    KEL.typ.nstr Previous_Addr_Sec_Rng_;
    KEL.typ.nstr Previous_Addr_State_;
    KEL.typ.nstr Previous_Addr_Zip5_;
    KEL.typ.nstr Previous_Addr_Zip4_;
    KEL.typ.nstr Previous_Addr_State_Code_;
    KEL.typ.nstr Previous_Addr_Cnty_;
    KEL.typ.nstr Previous_Addr_Geo_;
    KEL.typ.nstr Previous_Addr_City_;
    KEL.typ.nstr Previous_Addr_Post_Dir_;
    KEL.typ.nstr Previous_Addr_Lat_;
    KEL.typ.nstr Previous_Addr_Lng_;
    KEL.typ.nstr Previous_Addr_Unit_Designation_;
    KEL.typ.nstr Previous_Addr_Type_;
    KEL.typ.nstr Previous_Addr_Status_;
    KEL.typ.nkdate Previous_Addr_Date_First_Seen_;
    KEL.typ.nkdate Previous_Addr_Date_Last_Seen_;
    KEL.typ.nstr Previous_Addr_Full_;
    KEL.typ.ntyp(E_Address().Typ) Previous_Address_;
    KEL.typ.bool Addr_Not_Populated_ := FALSE;
    KEL.typ.nbool City_State_Zip_Not_Populated_;
    KEL.typ.nbool Clean_City_State_Zip_Not_Populated_;
    KEL.typ.nint D_P_P_A_Purpose_;
    KEL.typ.nint G_L_B_Purpose_;
    KEL.typ.nbool Gateway_Is_F_C_R_A_;
    KEL.typ.nstr Input_Address_Suffix_Clean_Value_;
    KEL.typ.nstr Input_City_Clean_Value_;
    KEL.typ.nstr Input_Post_Direction_Clean_Value_;
    KEL.typ.nstr Input_Pre_Direction_Clean_Value_;
    KEL.typ.nstr Input_Primary_Name_Clean_Value_;
    KEL.typ.nstr Input_Primary_Range_Clean_Value_;
    KEL.typ.nstr Input_Secondary_Range_Clean_Value_;
    KEL.typ.nstr Input_State_Clean_Value_;
    KEL.typ.nstr Input_Street_Clean_Value_;
    KEL.typ.nstr Input_Unit_Desig_Clean_Value_;
    KEL.typ.nstr Input_Zip4_Clean_Value_;
    KEL.typ.nstr Input_Zip5_Clean_Value_;
    KEL.typ.nstr P___Inp_Addr_;
    KEL.typ.str P___Inp_Addr_City_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_State_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_Zip_Flag_Value_ := '';
    KEL.typ.nstr P___Inp_Cln_Addr_St_Flag_Value_;
    KEL.typ.nstr Targus_Gateway_I_P_;
    KEL.typ.ndataset(__ST305585_Layout) Input_Clean_Phone__1_;
    KEL.typ.ndataset(__ST306355_Layout) Input_Clean_Phone__2_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC306370(__ST305603_Layout __EE305601, __ST306355_Layout __EE306359) := __EEQP(__EE305601.Input_Clean_Phone_,__EE306359.UID);
  __ST306373_Layout __Join__ST306373_Layout(__ST305603_Layout __r, DATASET(__ST306355_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Input_Clean_Phone__2_ := __CN(__recs);
  END;
  SHARED __EE306371 := DENORMALIZE(DISTRIBUTE(__EE305601,HASH(Input_Clean_Phone_)),DISTRIBUTE(__EE306359,HASH(UID)),__JC306370(LEFT,RIGHT),GROUP,__Join__ST306373_Layout(LEFT,ROWS(RIGHT)),LOCAL,SMART);
  EXPORT __ST85967_Layout := RECORD
    KEL.typ.nint High_Risk_N_A_I_C_S_;
    KEL.typ.nkdate Date_First_Seen_Min_N_A_I_C_S_Phone_;
    KEL.typ.nkdate Date_Last_Seen_Min_N_A_I_C_S_Phone_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST85861_Layout := RECORD
    KEL.typ.nint High_Risk_S_I_C_;
    KEL.typ.nkdate Date_First_Seen_Min_S_I_C_Phone_;
    KEL.typ.nkdate Date_Last_Seen_Min_S_I_C_Phone_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST155873_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nstr P___Inp_Acct_;
    KEL.typ.nint P___Inp_Lex_I_D_;
    KEL.typ.nstr P___Inp_Name_First_;
    KEL.typ.nstr P___Inp_Name_Mid_;
    KEL.typ.nstr P___Inp_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Surname1_;
    KEL.typ.nstr P___Inp_Cln_Surname2_;
    KEL.typ.ntyp(E_Surname().Typ) Last_Name1_;
    KEL.typ.ntyp(E_Surname().Typ) Last_Name2_;
    KEL.typ.nstr Address_Geo_Link_;
    KEL.typ.nstr P___Inp_Addr_Line1_;
    KEL.typ.nstr P___Inp_Addr_Line2_;
    KEL.typ.nstr P___Inp_Addr_City_;
    KEL.typ.nstr P___Inp_Addr_State_;
    KEL.typ.nstr P___Inp_Addr_Zip_;
    KEL.typ.nstr P___Inp_Phone_Home_;
    KEL.typ.nstr P___Inp_S_S_N_;
    KEL.typ.nstr P___Inp_D_O_B_;
    KEL.typ.nstr P___Inp_Phone_Work_;
    KEL.typ.nstr Input_Income_Echo_;
    KEL.typ.nstr P___Inp_D_L_;
    KEL.typ.nstr P___Inp_D_L_State_;
    KEL.typ.nstr Input_Balance_Echo_;
    KEL.typ.nstr Input_Charge_Offd_Echo_;
    KEL.typ.nstr Input_Former_Name_Echo_;
    KEL.typ.nstr P___Inp_Email_;
    KEL.typ.nstr P___Inp_I_P_Addr_;
    KEL.typ.nstr Input_Employment_Echo_;
    KEL.typ.nstr P___Inp_Arch_Dt_;
    KEL.typ.nint P___Lex_I_D_;
    KEL.typ.nint P___Lex_I_D_Score_;
    KEL.typ.nstr P___Inp_Cln_Name_Prfx_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Mid_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Name_Sffx_;
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr P___Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Unit_Desig_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_Post_;
    KEL.typ.nstr P___Inp_Cln_Addr_State_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip4_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lat_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lng_;
    KEL.typ.nstr P___Inp_Cln_Addr_State_Code_;
    KEL.typ.nstr P___Inp_Cln_Addr_Cnty_;
    KEL.typ.nstr P___Inp_Cln_Addr_Geo_;
    KEL.typ.ntyp(E_Geo_Link().Typ) Geo_Link_I_D_;
    KEL.typ.nstr P___Inp_Cln_Addr_Type_;
    KEL.typ.nstr P___Inp_Cln_Addr_Status_;
    KEL.typ.nstr P___Inp_Cln_Email_;
    KEL.typ.ntyp(E_Email().Typ) Input_Clean_Email_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.ntyp(E_Phone().Typ) Input_Clean_Phone_;
    KEL.typ.nstr P___Inp_Cln_Phone_Work_;
    KEL.typ.nstr P___Inp_Cln_D_L_;
    KEL.typ.nstr P___Inp_Cln_D_L_State_;
    KEL.typ.nkdate P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Input_Clean_S_S_N_;
    KEL.typ.nint P___Inp_Cln_Arch_Dt_;
    KEL.typ.nint G___Proc_Bus_U_I_D_;
    KEL.typ.nstr Phone_Verification_Bureau_;
    KEL.typ.nstr Dial_Indicator_;
    KEL.typ.nstr Point_I_D_;
    KEL.typ.nstr N_X_X_Type_;
    KEL.typ.nbool Z_I_P_Match_;
    KEL.typ.nstr C_O_C_Type_;
    KEL.typ.nstr S_S_C_;
    KEL.typ.nstr Wireless_Indicator_;
    KEL.typ.nint Rep_Number_;
    KEL.typ.ntyp(E_Address_Slim().Typ) Slim_Location_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ntyp(E_S_S_N_Summary().Typ) Social_Summary_;
    KEL.typ.ntyp(E_Name_Summary().Typ) Name_Summ_;
    KEL.typ.ntyp(E_Phone_Summary().Typ) Telephone_Summary_;
    KEL.typ.ntyp(E_Address_Summary().Typ) Location_Summary_;
    KEL.typ.nstr Current_Addr_Prim_Rng_;
    KEL.typ.nstr Current_Addr_Pre_Dir_;
    KEL.typ.nstr Current_Addr_Prim_Name_;
    KEL.typ.nstr Current_Addr_Sffx_;
    KEL.typ.nstr Current_Addr_Sec_Rng_;
    KEL.typ.nstr Current_Addr_State_;
    KEL.typ.nstr Current_Addr_Zip5_;
    KEL.typ.nstr Current_Addr_Zip4_;
    KEL.typ.nstr Current_Addr_State_Code_;
    KEL.typ.nstr Current_Addr_Cnty_;
    KEL.typ.nstr Current_Addr_Geo_;
    KEL.typ.nstr Current_Addr_City_;
    KEL.typ.nstr Current_Addr_Post_Dir_;
    KEL.typ.nstr Current_Addr_Lat_;
    KEL.typ.nstr Current_Addr_Lng_;
    KEL.typ.nstr Current_Addr_Unit_Designation_;
    KEL.typ.nstr Current_Addr_Type_;
    KEL.typ.nstr Current_Addr_Status_;
    KEL.typ.nkdate Current_Addr_Date_First_Seen_;
    KEL.typ.nkdate Current_Addr_Date_Last_Seen_;
    KEL.typ.nstr Current_Addr_Full_;
    KEL.typ.ntyp(E_Address().Typ) Current_Address_;
    KEL.typ.nstr Previous_Addr_Prim_Rng_;
    KEL.typ.nstr Previous_Addr_Pre_Dir_;
    KEL.typ.nstr Previous_Addr_Prim_Name_;
    KEL.typ.nstr Previous_Addr_Sffx_;
    KEL.typ.nstr Previous_Addr_Sec_Rng_;
    KEL.typ.nstr Previous_Addr_State_;
    KEL.typ.nstr Previous_Addr_Zip5_;
    KEL.typ.nstr Previous_Addr_Zip4_;
    KEL.typ.nstr Previous_Addr_State_Code_;
    KEL.typ.nstr Previous_Addr_Cnty_;
    KEL.typ.nstr Previous_Addr_Geo_;
    KEL.typ.nstr Previous_Addr_City_;
    KEL.typ.nstr Previous_Addr_Post_Dir_;
    KEL.typ.nstr Previous_Addr_Lat_;
    KEL.typ.nstr Previous_Addr_Lng_;
    KEL.typ.nstr Previous_Addr_Unit_Designation_;
    KEL.typ.nstr Previous_Addr_Type_;
    KEL.typ.nstr Previous_Addr_Status_;
    KEL.typ.nkdate Previous_Addr_Date_First_Seen_;
    KEL.typ.nkdate Previous_Addr_Date_Last_Seen_;
    KEL.typ.nstr Previous_Addr_Full_;
    KEL.typ.ntyp(E_Address().Typ) Previous_Address_;
    KEL.typ.bool Addr_Not_Populated_ := FALSE;
    KEL.typ.nint At_Position_;
    KEL.typ.nbool City_State_Zip_Not_Populated_;
    KEL.typ.nbool Clean_City_State_Zip_Not_Populated_;
    KEL.typ.nint D_P_P_A_Purpose_;
    KEL.typ.nint G_L_B_Purpose_;
    KEL.typ.nbool Gateway_Is_F_C_R_A_;
    KEL.typ.nstr Input_Address_Suffix_Clean_Value_;
    KEL.typ.nstr Input_City_Clean_Value_;
    KEL.typ.nstr Input_First_Name_Value_;
    KEL.typ.nstr Input_Full_Address_Clean_Value_;
    KEL.typ.nstr Input_Last_Name_Value_;
    KEL.typ.nstr Input_Middle_Name_Value_;
    KEL.typ.nstr Input_Post_Direction_Clean_Value_;
    KEL.typ.nstr Input_Pre_Direction_Clean_Value_;
    KEL.typ.nstr Input_Primary_Name_Clean_Value_;
    KEL.typ.nstr Input_Primary_Range_Clean_Value_;
    KEL.typ.nstr Input_Secondary_Range_Clean_Value_;
    KEL.typ.nstr Input_State_Clean_Value_;
    KEL.typ.nstr Input_Street_Clean_Value_;
    KEL.typ.nstr Input_Unit_Desig_Clean_Value_;
    KEL.typ.nstr Input_Zip4_Clean_Value_;
    KEL.typ.nstr Input_Zip5_Clean_Value_;
    KEL.typ.nstr P___Inp_Addr_;
    KEL.typ.str P___Inp_Addr_City_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_State_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_Zip_Flag_Value_ := '';
    KEL.typ.nstr P___Inp_Cln_Addr_St_Flag_Value_;
    KEL.typ.ndataset(__ST85967_Layout) Phone_N_A_I_C_S_High_Risk_Pre_;
    KEL.typ.ndataset(__ST85861_Layout) Phone_S_I_C_High_Risk_Pre_;
    KEL.typ.nstr Targus_Gateway_I_P_;
    SET OF KEL.typ.str Targus_Results_ := [];
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST155873_Layout __ND307370__Project(__ST306373_Layout __PP306547) := TRANSFORM
    SELF.At_Position_ := FN_Compile(__cfg).FN_Find_Last_String_Instance(__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP306547.P___Inp_Email_)),__ECAST(KEL.typ.nstr,__CN('@')));
    __CC13537 := '-99999';
    SELF.Input_First_Name_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP306547.P___Inp_Name_First_),__ECAST(KEL.typ.nstr,__CN(__CC13537)));
    __CC13542 := '-99998';
    SELF.Input_Full_Address_Clean_Value_ := MAP(__T(__OR(__CN(__PP306547.Addr_Not_Populated_),__PP306547.City_State_Zip_Not_Populated_))=>__ECAST(KEL.typ.nstr,__CN(__CC13537)),__T(__OR(__OP2(__PP306547.P___Inp_Cln_Addr_St_Flag_Value_,=,__CN('0')),__PP306547.Clean_City_State_Zip_Not_Populated_))=>__ECAST(KEL.typ.nstr,__CN(__CC13542)),__ECAST(KEL.typ.nstr,__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(IF(__T(__OP2(__PP306547.Input_Primary_Range_Clean_Value_,=,__CN(__CC13542))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP306547.P___Inp_Cln_Addr_Prim_Rng_),+,__CN(' ')))),+,IF(__T(__OP2(__PP306547.Input_Pre_Direction_Clean_Value_,=,__CN(__CC13542))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP306547.P___Inp_Cln_Addr_Pre_Dir_),+,__CN(' '))))),+,IF(__T(__OP2(__PP306547.Input_Primary_Name_Clean_Value_,=,__CN(__CC13542))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP306547.P___Inp_Cln_Addr_Prim_Name_),+,__CN(' '))))),+,IF(__T(__OP2(__PP306547.Input_Address_Suffix_Clean_Value_,=,__CN(__CC13542))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP306547.P___Inp_Cln_Addr_Sffx_),+,__CN(' '))))),+,IF(__T(__OP2(__PP306547.Input_Post_Direction_Clean_Value_,=,__CN(__CC13542))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP306547.P___Inp_Cln_Addr_Post_Dir_),+,__CN(' '))))),+,IF(__T(__OP2(__PP306547.Input_Unit_Desig_Clean_Value_,=,__CN(__CC13542))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP306547.P___Inp_Cln_Addr_Unit_Desig_),+,__CN(' '))))),+,IF(__T(__OP2(__PP306547.Input_Secondary_Range_Clean_Value_,=,__CN(__CC13542))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP306547.P___Inp_Cln_Addr_Sec_Rng_),+,__CN(' '))))),+,IF(__T(__OP2(__PP306547.Input_City_Clean_Value_,=,__CN(__CC13542))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP306547.P___Inp_Cln_Addr_City_),+,__CN(' '))))),+,IF(__T(__OP2(__PP306547.Input_State_Clean_Value_,=,__CN(__CC13542))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP306547.P___Inp_Cln_Addr_State_),+,__CN(' '))))),+,IF(__T(__OP2(__PP306547.Input_Zip5_Clean_Value_,=,__CN(__CC13542))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP306547.P___Inp_Cln_Addr_Zip5_),+,__CN(' '))))),+,IF(__T(__OP2(__PP306547.Input_Zip4_Clean_Value_,=,__CN(__CC13542))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP306547.P___Inp_Cln_Addr_Zip4_))))));
    SELF.Input_Last_Name_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP306547.P___Inp_Name_Last_),__ECAST(KEL.typ.nstr,__CN(__CC13537)));
    SELF.Input_Middle_Name_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP306547.P___Inp_Name_Mid_),__ECAST(KEL.typ.nstr,__CN(__CC13537)));
    __EE306541 := __PP306547.Input_Clean_Phone__1_;
    __ST85967_Layout __ND307150__Project(__ST305585_Layout __PP307146) := TRANSFORM
      SELF.Date_First_Seen_Min_N_A_I_C_S_Phone_ := KEL.era.ToDate(__PP307146.Date_First_Seen_);
      SELF.Date_Last_Seen_Min_N_A_I_C_S_Phone_ := KEL.era.ToDate(__PP307146.Date_Last_Seen_);
      SELF := __PP307146;
    END;
    SELF.Phone_N_A_I_C_S_High_Risk_Pre_ := __PROJECT(__EE306541,__ND307150__Project(LEFT));
    __EE306545 := __PP306547.Input_Clean_Phone__2_;
    __ST85861_Layout __ND307171__Project(__ST306355_Layout __PP307167) := TRANSFORM
      SELF.Date_First_Seen_Min_S_I_C_Phone_ := KEL.era.ToDate(__PP307167.Date_First_Seen_);
      SELF.Date_Last_Seen_Min_S_I_C_Phone_ := KEL.era.ToDate(__PP307167.Date_Last_Seen_);
      SELF := __PP307167;
    END;
    SELF.Phone_S_I_C_High_Risk_Pre_ := __PROJECT(__EE306545,__ND307171__Project(LEFT));
    SELF.Targus_Results_ := FN_Compile(__cfg).FN_G_A_T_E_W_A_Y___T_A_R_G_U_S(__ECAST(KEL.typ.nstr,__PP306547.Targus_Gateway_I_P_),__ECAST(KEL.typ.nstr,__PP306547.P___Inp_Name_First_),__ECAST(KEL.typ.nstr,__PP306547.P___Inp_Name_Last_),__ECAST(KEL.typ.nstr,__PP306547.P___Inp_Phone_Home_),__ECAST(KEL.typ.nint,__PP306547.G_L_B_Purpose_),__ECAST(KEL.typ.nint,__PP306547.D_P_P_A_Purpose_),__ECAST(KEL.typ.nbool,__PP306547.Gateway_Is_F_C_R_A_));
    SELF := __PP306547;
  END;
  EXPORT __ENH_Input_P_I_I_4 := PROJECT(__EE306371,__ND307370__Project(LEFT));
END;
