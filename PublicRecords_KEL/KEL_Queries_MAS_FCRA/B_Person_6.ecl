//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person_7,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_7(__in,__cfg).__ENH_Person_7) __ENH_Person_7 := B_Person_7(__in,__cfg).__ENH_Person_7;
  SHARED __EE1097108 := __ENH_Person_7;
  EXPORT __ST183200_Layout := RECORD
    KEL.typ.nstr Title_;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Middle_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nstr Name_Suffix_;
    KEL.typ.nstr Name_Score_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool Best_;
    KEL.typ.nstr Source_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST94269_Layout := RECORD
    KEL.typ.nstr File_Type_;
    KEL.typ.nstr College_Code_;
    KEL.typ.nstr College_Type_;
    KEL.typ.nstr Tier_;
    KEL.typ.nstr Tier2_;
    KEL.typ.nstr College_Code_Convert_;
    KEL.typ.nstr Source_Date_First_Seen_;
    KEL.typ.nstr Source_Date_Last_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST98698_Layout := RECORD
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST98923_Layout := RECORD
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST183195_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(__ST183200_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST223792_Layout) All_Lien_Data_;
    KEL.typ.nkdate B_U_I_L_D___D_A_T_E_;
    KEL.typ.ndataset(__ST94269_Layout) Edu_Rec_Ver_Source_List_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST94229_Layout) Edu_Rec_Ver_Source_List_Pre_;
    KEL.typ.nstr L_T_D7_Y_New_Date_;
    KEL.typ.nstr Ln_J7_Y_New_Date_;
    KEL.typ.nstr Ln_J7_Y_Old_Date_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.int P_L___Drg_L_T_D_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Ln_J_Cnt7_Y_ := 0;
    KEL.typ.nstr P___Inp_Cln_Name_First_Raw_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_Raw_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.ndataset(__ST98698_Layout) Verified_First_Name_Sources_;
    KEL.typ.ndataset(__ST98923_Layout) Verified_Last_Name_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST183195_Layout __ND1096894__Project(B_Person_7(__in,__cfg).__ST178958_Layout __PP1096461) := TRANSFORM
    __EE1097111 := __PP1096461.Full_Name_;
    SELF.Full_Name_ := __PROJECT(__EE1097111,__ST183200_Layout);
    __EE1097114 := __PP1096461.Edu_Rec_Ver_Source_List_Pre_;
    __ST94269_Layout __ND1096696__Project(B_Person_7(__in,__cfg).__ST94229_Layout __PP1096463) := TRANSFORM
      SELF.College_Code_Convert_ := MAP(__T(__OP2(__PP1096463.College_Code_,=,__CN('1')))=>__ECAST(KEL.typ.nstr,__CN('3')),__T(__OP2(__PP1096463.College_Code_,=,__CN('2')))=>__ECAST(KEL.typ.nstr,__CN('1')),__T(__OP2(__PP1096463.College_Code_,=,__CN('4')))=>__ECAST(KEL.typ.nstr,__CN('2')),__N(KEL.typ.str));
      __CC14234 := '-99997';
      SELF.Source_Date_First_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP1096463.Date_First_Seen_Min_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,__PP1096463.Date_First_Seen_Min_,__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14234)));
      SELF.Source_Date_Last_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP1096463.Date_Last_Seen_Max_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(__PP1096463.Date_Last_Seen_Max_,__PP1096461.B_U_I_L_D___D_A_T_E_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14234)));
      SELF := __PP1096463;
    END;
    SELF.Edu_Rec_Ver_Source_List_ := __PROJECT(__EE1097114,__ND1096696__Project(LEFT));
    __EE1096876 := __PP1096461.All_Lien_Data_;
    __BS1096877 := __T(__EE1096876);
    __EE1096885 := __BS1096877(__T(__AND(__T(__EE1096876).Seen___In___Seven___Years_,__T(__EE1096876).Is_Landlord_Tenant_Dispute_)));
    __CC14166 := '-99997';
    SELF.L_T_D7_Y_New_Date_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__ECAST(KEL.typ.nstr,KEL.Aggregates.MaxN(__EE1096885,__EE1096885.Original_Filing_Date_))),__ECAST(KEL.typ.nstr,__CN(__CC14166)));
    __EE1097123 := __PP1096461.All_Lien_Data_;
    __BS1097124 := __T(__EE1097123);
    __EE1097132 := __BS1097124(__T(__AND(__T(__EE1097123).Seen___In___Seven___Years_,__T(__EE1097123).Is_Over_All_Lien_Judgment_)));
    SELF.Ln_J7_Y_New_Date_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__ECAST(KEL.typ.nstr,KEL.Aggregates.MaxN(__EE1097132,__EE1097132.Original_Filing_Date_))),__ECAST(KEL.typ.nstr,__CN(__CC14166)));
    __EE1096920 := __EE1097132;
    SELF.Ln_J7_Y_Old_Date_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__ECAST(KEL.typ.nstr,KEL.Aggregates.MinN(__EE1096920,__EE1096920.Original_Filing_Date_))),__ECAST(KEL.typ.nstr,__CN(__CC14166)));
    __CC14159 := -99999;
    __BS1096938 := __T(__PP1096461.All_Lien_Data_);
    SELF.P_L___Drg_L_T_D_Cnt7_Y_ := IF(__PP1096461.P___Lex_I_D_Seen_Flag_ = '0',__CC14159,KEL.Routines.BoundsFold(COUNT(__BS1096938(__T(__AND(__T(__PP1096461.All_Lien_Data_).Seen___In___Seven___Years_,__OP2(__T(__PP1096461.All_Lien_Data_).Is_Landlord_Tenant_Dispute_,=,__CN(TRUE)))))),0,999));
    __BS1096962 := __T(__PP1096461.All_Lien_Data_);
    SELF.P_L___Drg_Ln_J_Cnt7_Y_ := IF(__PP1096461.P___Lex_I_D_Seen_Flag_ = '0',__CC14159,KEL.Routines.BoundsFold(COUNT(__BS1096962(__T(__AND(__T(__PP1096461.All_Lien_Data_).Seen___In___Seven___Years_,__T(__PP1096461.All_Lien_Data_).Is_Over_All_Lien_Judgment_)))),0,999));
    __EE1097117 := __PP1096461.Full_Name_;
    __BS1097133 := __T(__EE1097117);
    __EE1097148 := __BS1097133(__T(__AND(__AND(__T(__EE1097117).Header_Hit_Flag_,__CN(__T(__EE1097117).Verified_First_Name_)),__OP2(__T(__EE1097117).Translated_Source_Code_,<>,__CN('')))));
    SELF.Verified_First_Name_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE1097148,__ST98698_Layout)(__NN(Translated_Source_Code_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Translated_Source_Code_},Translated_Source_Code_,MERGE),__ST98698_Layout));
    __EE1097120 := __PP1096461.Full_Name_;
    __BS1097149 := __T(__EE1097120);
    __EE1097164 := __BS1097149(__T(__AND(__AND(__T(__EE1097120).Header_Hit_Flag_,__CN(__T(__EE1097120).Verified_Last_Name_)),__OP2(__T(__EE1097120).Translated_Source_Code_,<>,__CN('')))));
    SELF.Verified_Last_Name_Sources_ := __CN(PROJECT(TABLE(PROJECT(__EE1097164,__ST98923_Layout)(__NN(Translated_Source_Code_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Translated_Source_Code_},Translated_Source_Code_,MERGE),__ST98923_Layout));
    SELF := __PP1096461;
  END;
  EXPORT __ENH_Person_6 := PROJECT(PROJECT(__EE1097108,__ND1096894__Project(LEFT)),__ST183195_Layout);
END;
