﻿//HPCC Systems KEL Compiler Version 1.5.0
IMPORT KEL15 AS KEL;
IMPORT B_Person_10,B_Person_8,B_Person_Accident_8,CFG_Compile,E_Accident,E_Person,E_Person_Accident FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_7(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_8(__in,__cfg).__ENH_Person_8) __ENH_Person_8 := B_Person_8(__in,__cfg).__ENH_Person_8;
  SHARED VIRTUAL TYPEOF(B_Person_Accident_8(__in,__cfg).__ENH_Person_Accident_8) __ENH_Person_Accident_8 := B_Person_Accident_8(__in,__cfg).__ENH_Person_Accident_8;
  SHARED __EE4826968 := __ENH_Person_8;
  SHARED __EE4826970 := __ENH_Person_Accident_8;
  SHARED __EE4828002 := __EE4826970(__EE4826970.Is_Accident_Record_ AND __NN(__EE4826970.Subject_));
  SHARED __ST377276_Layout := RECORD
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
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86513_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(B_Person_8(__in,__cfg).__ST347370_Layout) All_Lien_Data_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86513_Layout) Curr_Addr_Full_Set_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86513_Layout) Recent_Addr_Full_Set_;
    KEL.typ.ndataset(B_Person_Accident_8(__in,__cfg).__ST252556_Layout) Person_Accident_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC4828019(B_Person_8(__in,__cfg).__ST252392_Layout __EE4826968, B_Person_Accident_8(__in,__cfg).__ST252556_Layout __EE4828002) := __EEQP(__EE4826968.UID,__EE4828002.Subject_);
  __ST377276_Layout __Join__ST377276_Layout(B_Person_8(__in,__cfg).__ST252392_Layout __r, DATASET(B_Person_Accident_8(__in,__cfg).__ST252556_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Person_Accident_ := __CN(__recs);
  END;
  SHARED __EE4828020 := DENORMALIZE(DISTRIBUTE(__EE4826968,HASH(UID)),DISTRIBUTE(__EE4828002,HASH(Subject_)),__JC4828019(LEFT,RIGHT),GROUP,__Join__ST377276_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST372338_Layout := RECORD
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
    KEL.typ.nbool Is_Over_All_Lien_Judgment_;
    KEL.typ.nbool Is_Small_Cliams_Judgment_;
    KEL.typ.nbool Is_State_Tax_Lien_;
    KEL.typ.nbool Is_Total_Tax_Lien_;
    KEL.typ.nbool Seen___In___Seven___Years_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST249838_Layout := RECORD
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
    KEL.typ.ndataset(B_Person_Accident_8(__in,__cfg).__ST252556_Layout) Accident_Recs_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86513_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(__ST372338_Layout) All_Lien_Data_;
    KEL.typ.nstr Curr_Addr_Full_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86513_Layout) Curr_Addr_Full_Set_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86513_Layout) Recent_Addr_Full_Set_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST249838_Layout __ND4828970__Project(__ST377276_Layout __PP4828243) := TRANSFORM
    __EE4828241 := __PP4828243.Person_Accident_;
    SELF.Accident_Recs_ := __EE4828241;
    __EE4828486 := __PP4828243.All_Lien_Data_;
    __ST372338_Layout __ND4828949__Project(B_Person_8(__in,__cfg).__ST347370_Layout __PP4828490) := TRANSFORM
      SELF.Is_Over_All_Lien_Judgment_ := __OR(__PP4828490.Is_Over_All_Judgment_,__PP4828490.Is_Over_All_Lien_);
      __CC29781 := 2556;
      SELF.Seen___In___Seven___Years_ := __OP2(__PP4828490.Age_In_Days_,<=,__CN(__CC29781));
      SELF := __PP4828490;
    END;
    SELF.All_Lien_Data_ := __PROJECT(__EE4828486,__ND4828949__Project(LEFT));
    __EE4828574 := __PP4828243.Curr_Addr_Full_Set_;
    SELF.Curr_Addr_Full_ := (__T(__EE4828574))[1].Addr_Full_;
    __BS4828590 := __T(__PP4828243.Data_Sources_);
    SELF.P___Lex_I_D_Seen_Flag_ := IF(EXISTS(__BS4828590(__T(__T(__PP4828243.Data_Sources_).Header_Hit_Flag_))),'1','0');
    SELF := __PP4828243;
  END;
  EXPORT __ENH_Person_7 := PROJECT(__EE4828020,__ND4828970__Project(LEFT));
END;
