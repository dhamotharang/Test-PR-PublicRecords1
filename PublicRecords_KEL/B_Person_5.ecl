//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_10,B_Person_6,B_Person_Accident_8,B_Person_S_S_N_6,CFG_Compile,E_Accident,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Person_Accident,E_Person_S_S_N,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_6(__in,__cfg).__ENH_Person_6) __ENH_Person_6 := B_Person_6(__in,__cfg).__ENH_Person_6;
  SHARED VIRTUAL TYPEOF(B_Person_S_S_N_6(__in,__cfg).__ENH_Person_S_S_N_6) __ENH_Person_S_S_N_6 := B_Person_S_S_N_6(__in,__cfg).__ENH_Person_S_S_N_6;
  SHARED __EE5589647 := __ENH_Person_6;
  SHARED __EE5589649 := __ENH_Person_S_S_N_6;
  SHARED __EE5593130 := __EE5589649(__T(__AND(__EE5589649.Input_S_S_N_Match_,__CN(__NN(__EE5589649.Subject_)))));
  SHARED __EE5593146 := __EE5593130.Valid_S_S_N_;
  __JC5593149(E_Person_S_S_N(__in,__cfg).Valid_S_S_N_Layout __EE5593146) := __T(__OP2(__EE5593146.Valid_S_S_N_,<>,__CN('M')));
  SHARED __EE5593150 := __EE5593130(EXISTS(__CHILDJOINFILTER(__EE5593146,__JC5593149)));
  SHARED __ST572218_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Valid_S_S_N_Layout) Valid_S_S_N_;
    KEL.typ.ndataset(B_Person_S_S_N_6(__in,__cfg).__ST261104_Layout) Data_Sources_;
    KEL.typ.nbool Input_S_S_N_Match_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool F_D_N_Indicator_;
    KEL.typ.nbool Death_Master_Flag_;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.nkdate My_Date_Last_Seen_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC5593188(B_Person_S_S_N_6(__in,__cfg).__ST261096_Layout __EE5593150, B_Person_S_S_N_6(__in,__cfg).__ST261104_Layout __EE5593169) := __T(__AND(__EE5593169.Header_Hit_Flag_,__OP2(__EE5593169.Translated_Source_,<>,__CN(''))));
  __ST572218_Layout __JT5593188(B_Person_S_S_N_6(__in,__cfg).__ST261096_Layout __l, B_Person_S_S_N_6(__in,__cfg).__ST261104_Layout __r) := TRANSFORM, SKIP(NOT(__JC5593188(__l,__r)))
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE5593189 := NORMALIZE(__EE5593150,__T(LEFT.Data_Sources_),__JT5593188(LEFT,RIGHT));
  SHARED __ST569548_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Valid_S_S_N_Layout) Valid_S_S_N_;
    KEL.typ.ndataset(B_Person_S_S_N_6(__in,__cfg).__ST261104_Layout) Data_Sources_;
    KEL.typ.nbool Input_S_S_N_Match_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool F_D_N_Indicator_;
    KEL.typ.nbool Death_Master_Flag_;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.nkdate My_Date_Last_Seen_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE5593290 := PROJECT(__EE5593189,TRANSFORM(__ST569548_Layout,SELF.UID := LEFT.Subject_,SELF := LEFT));
  SHARED __ST570645_Layout := RECORD
    KEL.typ.nstr Translated_Source_;
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.nkdate My_Date_Last_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE5593312 := PROJECT(__EE5593290,__ST570645_Layout);
  SHARED __ST570669_Layout := RECORD
    KEL.typ.nkdate M_I_N___My_Date_First_Seen_;
    KEL.typ.nkdate M_A_X___My_Date_Last_Seen_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE5593337 := PROJECT(__CLEANANDDO(__EE5593312,TABLE(__EE5593312,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),KEL.Aggregates.MinNG(__EE5593312.My_Date_First_Seen_) M_I_N___My_Date_First_Seen_,KEL.Aggregates.MaxNG(__EE5593312.My_Date_Last_Seen_) M_A_X___My_Date_Last_Seen_,Translated_Source_,UID},Translated_Source_,UID,MERGE)),__ST570669_Layout);
  SHARED __ST582000_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST298130_Layout) Full_Name_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST298145_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST298159_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Dunn_Data_Layout) Dunn_Data_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.ndataset(B_Person_Accident_8(__in,__cfg).__ST267443_Layout) Accident_Recs_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST102042_Layout) Accident_Recs_Formatted_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST80762_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST479926_Layout) All_Lien_Data_;
    KEL.typ.nkdate B_U_I_L_D___D_A_T_E_;
    KEL.typ.nstr Curr_Addr_Full_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST80762_Layout) Curr_Addr_Full_Set_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST95043_Layout) Edu_Rec_Ver_Source_List_Pre_;
    KEL.typ.nstr Ln_J7_Y_Old_Date_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.int P_L___Drg_Ln_J_Cnt7_Y_ := 0;
    KEL.typ.nstr P___Inp_Cln_Name_First_Raw_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_Raw_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST80762_Layout) Prev_Addr_Full_Set_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST80762_Layout) Recent_Addr_Full_Set_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST101590_Layout) Translated_Sources_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST102614_Layout) Verified_First_Name_Sources_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST102776_Layout) Verified_Last_Name_Sources_;
    KEL.typ.ndataset(__ST570669_Layout) Exp1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC5593343(B_Person_6(__in,__cfg).__ST298124_Layout __EE5589647, __ST570669_Layout __EE5593337) := __EEQP(__EE5589647.UID,__EE5593337.UID);
  __ST582000_Layout __Join__ST582000_Layout(B_Person_6(__in,__cfg).__ST298124_Layout __r, DATASET(__ST570669_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Exp1_ := __CN(__recs);
  END;
  SHARED __EE5593638 := DENORMALIZE(DISTRIBUTE(__EE5589647,HASH(UID)),DISTRIBUTE(__EE5593337,HASH(UID)),__JC5593343(LEFT,RIGHT),GROUP,__Join__ST582000_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST323915_Layout := RECORD
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
    KEL.typ.bool Verified_First_Name_ := FALSE;
    KEL.typ.bool Verified_Last_Name_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST323930_Layout := RECORD
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool Best_;
    KEL.typ.nbool Best_D_O_B_Rec_;
    KEL.typ.nbool D_O_B_Best_Not_Null_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST323945_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool F_D_N_Indicator_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST95070_Layout := RECORD
    KEL.typ.nstr File_Type_;
    KEL.typ.nstr Source_Date_First_Seen_;
    KEL.typ.nstr Source_Date_Last_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST102965_Layout := RECORD
    KEL.typ.nstr Translated_Source_;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.nkdate My_Date_Last_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST566046_Layout := RECORD
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST102676_Layout := RECORD
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.nstr Source_Date_First_Seen_;
    KEL.typ.nstr First_Seen_Date_;
    KEL.typ.nstr Source_Date_Last_Seen_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST102838_Layout := RECORD
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.nstr Source_Date_First_Seen_;
    KEL.typ.nstr First_Seen_Date_;
    KEL.typ.nstr Source_Date_Last_Seen_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST323909_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(__ST323915_Layout) Full_Name_;
    KEL.typ.ndataset(__ST323930_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(__ST323945_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Dunn_Data_Layout) Dunn_Data_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.ndataset(B_Person_Accident_8(__in,__cfg).__ST267443_Layout) Accident_Recs_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST102042_Layout) Accident_Recs_Formatted_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST102042_Layout) Accident_Recs_Formatted_Dedup_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST80762_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST479926_Layout) All_Lien_Data_;
    KEL.typ.nkdate B_U_I_L_D___D_A_T_E_;
    KEL.typ.nkdate Best_D_O_B_;
    KEL.typ.nstr Curr_Addr_Full_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST80762_Layout) Curr_Addr_Full_Set_;
    B_Person_10(__in,__cfg).__ST80762_Layout Current_;
    KEL.typ.ndataset(__ST95070_Layout) Edu_Rec_Ver_Source_List_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST95043_Layout) Edu_Rec_Ver_Source_List_Pre_;
    KEL.typ.nstr L_T_D7_Y_New_Date_;
    KEL.typ.nstr L_T_D7_Y_Old_Date_;
    KEL.typ.nstr Ln_J7_Y_New_Date_;
    KEL.typ.nstr Ln_J7_Y_Old_Date_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.int P_L___Drg_L_T_D_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Ln_J_Cnt7_Y_ := 0;
    KEL.typ.nstr P_L___Drg_Ln_J_Old_Dt7_Y_;
    KEL.typ.nstr P___Inp_Cln_Name_First_Raw_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_Raw_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.ndataset(__ST102965_Layout) Person_S_S_N_Match_Sources_Pre_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST80762_Layout) Prev_Addr_Full_Set_;
    B_Person_10(__in,__cfg).__ST80762_Layout Previous_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST80762_Layout) Recent_Addr_Full_Set_;
    KEL.typ.ndataset(__ST566046_Layout) Translated_Sources_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST102614_Layout) Verified_First_Name_Sources_;
    KEL.typ.ndataset(__ST102676_Layout) Verified_First_Name_Sources_With_Dates_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST102776_Layout) Verified_Last_Name_Sources_;
    KEL.typ.ndataset(__ST102838_Layout) Verified_Last_Name_Sources_With_Dates_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST323909_Layout __ND5593675__Project(__ST582000_Layout __PP5593671) := TRANSFORM
    __EE5593641 := __PP5593671.Full_Name_;
    SELF.Full_Name_ := __BN(PROJECT(__T(__EE5593641),__ST323915_Layout),__NL(__EE5593641));
    __EE5593645 := __PP5593671.Reported_Dates_Of_Birth_;
    __ST323930_Layout __ND5594024__Project(B_Person_6(__in,__cfg).__ST298145_Layout __PP5594020) := TRANSFORM
      SELF.D_O_B_Best_Not_Null_ := __AND(__OP2(__PP5594020.Best_,=,__CN(TRUE)),__NOT(__NT(__PP5594020.Date_Of_Birth_)));
      SELF := __PP5594020;
    END;
    SELF.Reported_Dates_Of_Birth_ := __PROJECT(__EE5593645,__ND5594024__Project(LEFT));
    __EE5593649 := __PP5593671.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE5593649),__ST323945_Layout),__NL(__EE5593649));
    __EE5594097 := __PP5593671.Accident_Recs_Formatted_;
    __EE5594111 := __BN(PROJECT(DEDUP(SORT(__T(__EE5594097),__T(__T(__EE5594097).Date_Of_Accident_), -__T(__T(__EE5594097).Estimated_Vehicle_Damage_),__T(Accident_Age_In_Days_),__T(Formatted_Date_)),__T(__OP2(LEFT.Date_Of_Accident_,=,RIGHT.Date_Of_Accident_))),B_Person_6(__in,__cfg).__ST102042_Layout),__NL(__PP5593671.Accident_Recs_Formatted_));
    SELF.Accident_Recs_Formatted_Dedup_ := __EE5594111;
    __EE5594122 := __PP5593671.Reported_Dates_Of_Birth_;
    __BS5594126 := __T(__EE5594122);
    __EE5594131 := __BS5594126(__T(__T(__EE5594122).Best_D_O_B_Rec_));
    SELF.Best_D_O_B_ := (__EE5594131)[1].Date_Of_Birth_;
    __EE5594144 := __PP5593671.Curr_Addr_Full_Set_;
    SELF.Current_ := (__T(__EE5594144))[1];
    __EE5593653 := __PP5593671.Edu_Rec_Ver_Source_List_Pre_;
    __ST95070_Layout __ND5594152__Project(B_Person_6(__in,__cfg).__ST95043_Layout __PP5594148) := TRANSFORM
      __CC13893 := '-99997';
      SELF.Source_Date_First_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP5594148.Date_First_Seen_Min_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,__PP5594148.Date_First_Seen_Min_,__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13893)));
      SELF.Source_Date_Last_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP5594148.Date_Last_Seen_Max_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(__PP5594148.Date_Last_Seen_Max_,__PP5593671.B_U_I_L_D___D_A_T_E_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13893)));
      SELF := __PP5594148;
    END;
    SELF.Edu_Rec_Ver_Source_List_ := __PROJECT(__EE5593653,__ND5594152__Project(LEFT));
    __EE5593669 := __PP5593671.All_Lien_Data_;
    __BS5594186 := __T(__EE5593669);
    __EE5594194 := __BS5594186(__T(__AND(__T(__EE5593669).Seen___In___Seven___Years_,__T(__EE5593669).Is_Landlord_Tenant_Dispute_)));
    __CC13825 := '-99997';
    SELF.L_T_D7_Y_New_Date_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__ECAST(KEL.typ.nstr,KEL.Aggregates.MaxN(__EE5594194,__EE5594194.Original_Filing_Date_))),__ECAST(KEL.typ.nstr,__CN(__CC13825)));
    __EE5594216 := __EE5594194;
    SELF.L_T_D7_Y_Old_Date_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__ECAST(KEL.typ.nstr,KEL.Aggregates.MinN(__EE5594216,__EE5594216.Original_Filing_Date_))),__ECAST(KEL.typ.nstr,__CN(__CC13825)));
    __EE5594229 := __PP5593671.All_Lien_Data_;
    __BS5594233 := __T(__EE5594229);
    __EE5594241 := __BS5594233(__T(__AND(__T(__EE5594229).Seen___In___Seven___Years_,__T(__EE5594229).Is_Over_All_Lien_Judgment_)));
    SELF.Ln_J7_Y_New_Date_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__ECAST(KEL.typ.nstr,KEL.Aggregates.MaxN(__EE5594241,__EE5594241.Original_Filing_Date_))),__ECAST(KEL.typ.nstr,__CN(__CC13825)));
    __CC13818 := -99999;
    __BS5594261 := __T(__PP5593671.All_Lien_Data_);
    SELF.P_L___Drg_L_T_D_Cnt7_Y_ := IF(__PP5593671.P___Lex_I_D_Seen_Flag_ = '0',__CC13818,KEL.Routines.BoundsFold(COUNT(__BS5594261(__T(__AND(__T(__PP5593671.All_Lien_Data_).Seen___In___Seven___Years_,__OP2(__T(__PP5593671.All_Lien_Data_).Is_Landlord_Tenant_Dispute_,=,__CN(TRUE)))))),0,999));
    __CC13815 := '-99999';
    __CC13820 := '-99998';
    __BS5594287 := __T(__PP5593671.All_Lien_Data_);
    SELF.P_L___Drg_Ln_J_Old_Dt7_Y_ := MAP(__PP5593671.P___Lex_I_D_Seen_Flag_ = '0'=>__ECAST(KEL.typ.nstr,__CN(__CC13815)),__PP5593671.P_L___Drg_Ln_J_Cnt7_Y_ < 1=>__ECAST(KEL.typ.nstr,__CN(__CC13820)), NOT EXISTS(__BS5594287(__T(__AND(__NOT(__OP2(__ECAST(KEL.typ.nstr,__T(__PP5593671.All_Lien_Data_).Original_Filing_Date_),=,__CN(__CC13825))),__AND(__T(__PP5593671.All_Lien_Data_).Seen___In___Seven___Years_,__T(__PP5593671.All_Lien_Data_).Is_Over_All_Lien_Judgment_)))))=>__ECAST(KEL.typ.nstr,__CN(__CC13825)),__ECAST(KEL.typ.nstr,__PP5593671.Ln_J7_Y_Old_Date_));
    __EE5593665 := __PP5593671.Exp1_;
    __ST102965_Layout __ND5594325__Project(__ST570669_Layout __PP5594321) := TRANSFORM
      SELF.My_Date_First_Seen_ := __PP5594321.M_I_N___My_Date_First_Seen_;
      SELF.My_Date_Last_Seen_ := __PP5594321.M_A_X___My_Date_Last_Seen_;
      SELF := __PP5594321;
    END;
    SELF.Person_S_S_N_Match_Sources_Pre_ := __PROJECT(__EE5593665,__ND5594325__Project(LEFT));
    __EE5594341 := __PP5593671.Prev_Addr_Full_Set_;
    SELF.Previous_ := (__T(__EE5594341))[1];
    __EE5594347 := __PP5593671.Translated_Sources_;
    __ST566046_Layout __ND5594355__Project(B_Person_6(__in,__cfg).__ST101590_Layout __PP5594351) := TRANSFORM
      __CC13201 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('header_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Age_In_Days_ := FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,KEL.era.ToDate(__PP5594351.Date_Last_Seen_)),__ECAST(KEL.typ.nkdate,__CC13201));
      SELF := __PP5594351;
    END;
    SELF.Translated_Sources_ := __PROJECT(__EE5594347,__ND5594355__Project(LEFT));
    __EE5593657 := __PP5593671.Verified_First_Name_Sources_;
    __ST102676_Layout __ND5594375__Project(B_Person_6(__in,__cfg).__ST102614_Layout __PP5594371) := TRANSFORM
      __CC13201 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('header_build_version'))),__CN(__cfg.CurrentDate));
      __CC13855 := '-99997';
      SELF.Source_Date_First_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP5594371.Date_First_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP5594371.Date_First_Seen_),__CC13201),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13855)));
      __CC67379 := '99999999';
      SELF.First_Seen_Date_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP5594371.Date_First_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP5594371.Date_First_Seen_),__CC13201),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC67379)));
      SELF.Source_Date_Last_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP5594371.Date_Last_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP5594371.Date_Last_Seen_),__CC13201),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13855)));
      SELF.Age_In_Days_ := FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,KEL.era.ToDate(__PP5594371.Date_Last_Seen_)),__ECAST(KEL.typ.nkdate,__CC13201));
      SELF := __PP5594371;
    END;
    SELF.Verified_First_Name_Sources_With_Dates_ := __PROJECT(__EE5593657,__ND5594375__Project(LEFT));
    __EE5593661 := __PP5593671.Verified_Last_Name_Sources_;
    __ST102838_Layout __ND5594436__Project(B_Person_6(__in,__cfg).__ST102776_Layout __PP5594432) := TRANSFORM
      __CC13201 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('header_build_version'))),__CN(__cfg.CurrentDate));
      __CC13855 := '-99997';
      SELF.Source_Date_First_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP5594432.Date_First_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP5594432.Date_First_Seen_),__CC13201),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13855)));
      __CC67379 := '99999999';
      SELF.First_Seen_Date_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP5594432.Date_First_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP5594432.Date_First_Seen_),__CC13201),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC67379)));
      SELF.Source_Date_Last_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP5594432.Date_Last_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP5594432.Date_Last_Seen_),__CC13201),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13855)));
      SELF.Age_In_Days_ := FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,KEL.era.ToDate(__PP5594432.Date_Last_Seen_)),__ECAST(KEL.typ.nkdate,__CC13201));
      SELF := __PP5594432;
    END;
    SELF.Verified_Last_Name_Sources_With_Dates_ := __PROJECT(__EE5593661,__ND5594436__Project(LEFT));
    SELF := __PP5593671;
  END;
  EXPORT __ENH_Person_5 := PROJECT(__EE5593638,__ND5593675__Project(LEFT));
END;
