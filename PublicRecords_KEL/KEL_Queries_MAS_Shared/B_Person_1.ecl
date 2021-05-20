//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person_2,B_Person_6,B_Person_S_S_N_2,CFG_Compile,E_Address,E_Geo_Link,E_Person,E_Person_Address,E_Person_S_S_N,E_Social_Security_Number,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Shared;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_2(__in,__cfg).__ENH_Person_2) __ENH_Person_2 := B_Person_2(__in,__cfg).__ENH_Person_2;
  SHARED VIRTUAL TYPEOF(B_Person_S_S_N_2(__in,__cfg).__ENH_Person_S_S_N_2) __ENH_Person_S_S_N_2 := B_Person_S_S_N_2(__in,__cfg).__ENH_Person_S_S_N_2;
  SHARED __EE220553 := __ENH_Person_2;
  SHARED __EE220569 := __ENH_Person_S_S_N_2;
  SHARED __EE221373 := __EE220569(__EE220569.Is_Best_S_S_N_ AND __NN(__EE220569.Subject_));
  SHARED __ST189231_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE221398 := PROJECT(__EE221373,TRANSFORM(__ST189231_Layout,SELF.UID := LEFT.Subject_,SELF := LEFT));
  SHARED __ST189260_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) O_N_L_Y___Social_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE221412 := PROJECT(__EE221398,TRANSFORM(__ST189260_Layout,SELF.O_N_L_Y___Social_ := LEFT.Social_,SELF := LEFT));
  SHARED __ST189806_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg).__ST156234_Layout) Full_Name_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg).__ST156247_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST86140_Layout) Curr_Addr_Full_Set_;
    KEL.typ.ndataset(E_Person_Address(__in,__cfg).Address_Hierarchy_Layout) Emerging_Temp_;
    KEL.typ.nstr Prep_Current_Addr_Full_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST86140_Layout) Prev_Addr_Full_Set_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST86140_Layout) Recent_Addr_Full_Set_;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__1_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) O_N_L_Y___Social_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC221418(B_Person_2(__in,__cfg).__ST156229_Layout __EE220553, __ST189260_Layout __EE221412) := __EEQP(__EE220553.UID,__EE221412.UID);
  __ST189806_Layout __JT221418(B_Person_2(__in,__cfg).__ST156229_Layout __l, __ST189260_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE221419 := JOIN(__EE220553,__EE221412,__JC221418(LEFT,RIGHT),__JT221418(LEFT,RIGHT),LEFT OUTER,HASH,KEEP(1));
  EXPORT __ST156413_Layout := RECORD
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
  EXPORT __ST156383_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg).__ST156234_Layout) Full_Name_;
    KEL.typ.ndataset(B_Person_2(__in,__cfg).__ST156247_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(__ST156413_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.nkdate Best_D_O_B_;
    KEL.typ.nstr Best_First_Name_;
    KEL.typ.nstr Best_Last_Name_;
    KEL.typ.nstr Best_Mid_Name_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Best_S_S_N_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST86140_Layout) Curr_Addr_Full_Set_;
    B_Person_6(__in,__cfg).__ST86140_Layout Current_;
    E_Person_Address(__in,__cfg).Address_Hierarchy_Layout Emerging_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.nstr Prep_Current_Addr_Full_;
    B_Person_6(__in,__cfg).__ST86140_Layout Previous_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST156383_Layout __ND222333__Project(__ST189806_Layout __PP221600) := TRANSFORM
    __EE221598 := __PP221600.Data_Sources_;
    __ST156413_Layout __ND221723__Project(E_Person(__in,__cfg).Data_Sources_Layout __PP221719) := TRANSFORM
      __CC13154 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('header_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Age_In_Days_ := FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,KEL.era.ToDate(__PP221719.Date_Last_Seen_)),__ECAST(KEL.typ.nkdate,__CC13154));
      SELF := __PP221719;
    END;
    SELF.Data_Sources_ := __PROJECT(__EE221598,__ND221723__Project(LEFT));
    __EE221752 := __PP221600.Reported_Dates_Of_Birth_;
    __BS221762 := __T(__EE221752);
    __EE221767 := __BS221762(__T(__T(__EE221752).Best_D_O_B_Rec_));
    SELF.Best_D_O_B_ := (__EE221767)[1].Date_Of_Birth_;
    __EE221776 := __PP221600.Full_Name_;
    __BS221790 := __T(__EE221776);
    __EE221795 := __BS221790(__T(__T(__EE221776).Best_Names_));
    SELF.Best_First_Name_ := (__EE221795)[1].First_Name_;
    __EE221995 := __EE221795;
    SELF.Best_Last_Name_ := (__EE221995)[1].Last_Name_;
    __EE222000 := __EE221795;
    SELF.Best_Mid_Name_ := (__EE222000)[1].Middle_Name_;
    SELF.Best_S_S_N_ := __PP221600.O_N_L_Y___Social_;
    __EE221863 := __PP221600.Curr_Addr_Full_Set_;
    SELF.Current_ := (__T(__EE221863))[1];
    __EE221866 := __PP221600.Emerging_Temp_;
    SELF.Emerging_ := (__T(__EE221866))[1];
    __BS221872 := __T(__PP221600.Data_Sources_);
    SELF.P___Lex_I_D_Seen_Flag_ := IF(EXISTS(__BS221872(__T(__T(__PP221600.Data_Sources_).Header_Hit_Flag_))),'1','0');
    __EE221884 := __PP221600.Prev_Addr_Full_Set_;
    SELF.Previous_ := (__T(__EE221884))[1];
    SELF := __PP221600;
  END;
  EXPORT __ENH_Person_1 := PROJECT(__EE221419,__ND222333__Project(LEFT));
END;
