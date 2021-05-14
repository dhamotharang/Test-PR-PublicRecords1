//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person_2,B_Person_6,B_Person_S_S_N_2,CFG_Compile,E_Address,E_Geo_Link,E_Person,E_Person_Address,E_Person_S_S_N,E_Social_Security_Number,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Shared;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_2(__in,__cfg).__ENH_Person_2) __ENH_Person_2 := B_Person_2(__in,__cfg).__ENH_Person_2;
  SHARED VIRTUAL TYPEOF(B_Person_S_S_N_2(__in,__cfg).__ENH_Person_S_S_N_2) __ENH_Person_S_S_N_2 := B_Person_S_S_N_2(__in,__cfg).__ENH_Person_S_S_N_2;
  SHARED __EE193374 := __ENH_Person_2;
  SHARED __EE193390 := __ENH_Person_S_S_N_2;
  SHARED __EE194194 := __EE193390(__EE193390.Is_Best_S_S_N_ AND __NN(__EE193390.Subject_));
  SHARED __ST171277_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE194219 := PROJECT(__EE194194,TRANSFORM(__ST171277_Layout,SELF.UID := LEFT.Subject_,SELF := LEFT));
  SHARED __ST171306_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) O_N_L_Y___Social_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE194233 := PROJECT(__EE194219,TRANSFORM(__ST171306_Layout,SELF.O_N_L_Y___Social_ := LEFT.Social_,SELF := LEFT));
  SHARED __ST171852_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg).__ST151546_Layout) Full_Name_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg).__ST151559_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST84273_Layout) Curr_Addr_Full_Set_;
    KEL.typ.ndataset(E_Person_Address(__in,__cfg).Address_Hierarchy_Layout) Emerging_Temp_;
    KEL.typ.nstr Prep_Current_Addr_Full_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST84273_Layout) Prev_Addr_Full_Set_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST84273_Layout) Recent_Addr_Full_Set_;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__1_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) O_N_L_Y___Social_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC194239(B_Person_2(__in,__cfg).__ST151541_Layout __EE193374, __ST171306_Layout __EE194233) := __EEQP(__EE193374.UID,__EE194233.UID);
  __ST171852_Layout __JT194239(B_Person_2(__in,__cfg).__ST151541_Layout __l, __ST171306_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE194240 := JOIN(__EE193374,__EE194233,__JC194239(LEFT,RIGHT),__JT194239(LEFT,RIGHT),LEFT OUTER,HASH,KEEP(1));
  EXPORT __ST151725_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool F_D_N_Indicator_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST151695_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg).__ST151546_Layout) Full_Name_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg).__ST151559_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(__ST151725_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.nkdate Best_D_O_B_;
    KEL.typ.nstr Best_First_Name_;
    KEL.typ.nstr Best_Last_Name_;
    KEL.typ.nstr Best_Mid_Name_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Best_S_S_N_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST84273_Layout) Curr_Addr_Full_Set_;
    B_Person_6(__in,__cfg).__ST84273_Layout Current_;
    E_Person_Address(__in,__cfg).Address_Hierarchy_Layout Emerging_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.nstr Prep_Current_Addr_Full_;
    B_Person_6(__in,__cfg).__ST84273_Layout Previous_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST151695_Layout __ND195154__Project(__ST171852_Layout __PP194421) := TRANSFORM
    __EE194419 := __PP194421.Data_Sources_;
    __ST151725_Layout __ND194544__Project(E_Person(__in,__cfg).Data_Sources_Layout __PP194540) := TRANSFORM
      __CC13232 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('header_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Age_In_Days_ := FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,KEL.era.ToDate(__PP194540.Date_Last_Seen_)),__ECAST(KEL.typ.nkdate,__CC13232));
      SELF := __PP194540;
    END;
    SELF.Data_Sources_ := __PROJECT(__EE194419,__ND194544__Project(LEFT));
    __EE194573 := __PP194421.Reported_Dates_Of_Birth_;
    __BS194583 := __T(__EE194573);
    __EE194588 := __BS194583(__T(__T(__EE194573).Best_D_O_B_Rec_));
    SELF.Best_D_O_B_ := (__EE194588)[1].Date_Of_Birth_;
    __EE194597 := __PP194421.Full_Name_;
    __BS194611 := __T(__EE194597);
    __EE194616 := __BS194611(__T(__T(__EE194597).Best_Names_));
    SELF.Best_First_Name_ := (__EE194616)[1].First_Name_;
    __EE194816 := __EE194616;
    SELF.Best_Last_Name_ := (__EE194816)[1].Last_Name_;
    __EE194821 := __EE194616;
    SELF.Best_Mid_Name_ := (__EE194821)[1].Middle_Name_;
    SELF.Best_S_S_N_ := __PP194421.O_N_L_Y___Social_;
    __EE194684 := __PP194421.Curr_Addr_Full_Set_;
    SELF.Current_ := (__T(__EE194684))[1];
    __EE194687 := __PP194421.Emerging_Temp_;
    SELF.Emerging_ := (__T(__EE194687))[1];
    __BS194693 := __T(__PP194421.Data_Sources_);
    SELF.P___Lex_I_D_Seen_Flag_ := IF(EXISTS(__BS194693(__T(__T(__PP194421.Data_Sources_).Header_Hit_Flag_))),'1','0');
    __EE194705 := __PP194421.Prev_Addr_Full_Set_;
    SELF.Previous_ := (__T(__EE194705))[1];
    SELF := __PP194421;
  END;
  EXPORT __ENH_Person_1 := PROJECT(__EE194240,__ND195154__Project(LEFT));
END;
