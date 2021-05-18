//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Bankruptcy_4,B_Bankruptcy_8,B_Criminal_Offense_4,B_Person_4,B_Person_5,CFG_Compile,E_Bankruptcy,E_Criminal_Offense,E_Person,E_Person_Bankruptcy,E_Person_Offenses,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4;
  SHARED VIRTUAL TYPEOF(B_Criminal_Offense_4(__in,__cfg).__ENH_Criminal_Offense_4) __ENH_Criminal_Offense_4 := B_Criminal_Offense_4(__in,__cfg).__ENH_Criminal_Offense_4;
  SHARED VIRTUAL TYPEOF(B_Person_4(__in,__cfg).__ENH_Person_4) __ENH_Person_4 := B_Person_4(__in,__cfg).__ENH_Person_4;
  SHARED VIRTUAL TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Person_Offenses(__in,__cfg).__Result) __E_Person_Offenses := E_Person_Offenses(__in,__cfg).__Result;
  SHARED __EE2492554 := __ENH_Person_4;
  SHARED __EE2492557 := __ENH_Criminal_Offense_4;
  SHARED __EE2492574 := __EE2492557.Offense_Charges_;
  SHARED __CC28077 := 2556;
  __JC2499156(B_Criminal_Offense_4(__in,__cfg).__ST205411_Layout __EE2492574) := __T(__AND(__OP2(__EE2492574.Age_In_Days_,<=,__CN(__CC28077)),__NOT(__NT(__EE2492574.Age_In_Days_))));
  SHARED __EE2499157 := __EE2492557(EXISTS(__CHILDJOINFILTER(__EE2492574,__JC2499156)));
  SHARED __EE789680 := __E_Person_Offenses;
  SHARED __EE2497563 := __EE789680(__NN(__EE789680.Subject_) AND __NN(__EE789680.Offense_));
  SHARED __ST791479_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Offender_Key_;
    KEL.typ.nstr Offense_Type_;
    KEL.typ.nkdate Date_Of_Offence_;
    KEL.typ.nint Offense_Category_;
    KEL.typ.nstr County_Of_Source_;
    KEL.typ.nstr State_Of_Source_;
    KEL.typ.nstr Department_Of_Law_Enforcement_Number_;
    KEL.typ.nstr Federal_Bureau_Of_Investigations_Number_;
    KEL.typ.nstr Inmate_Number_;
    KEL.typ.nstr State_Identification_Number_Assigned_;
    KEL.typ.nkdate Date_Of_Arrest_;
    KEL.typ.nstr Agency_Name_;
    KEL.typ.nstr Agency_Case_Number_;
    KEL.typ.nstr Traffic_Ticket_Number_;
    KEL.typ.nstr Arrest_Offense_Code_;
    KEL.typ.nstr Arrest_Initial_Charge_Description_;
    KEL.typ.nstr Arrest_Amended_Charge_Description_;
    KEL.typ.nstr Arrest_Offense_Level_;
    KEL.typ.nkdate Date_Of_Disposition_For_Initial_Charge_;
    KEL.typ.nstr Arrest_Offence_Type_Description_;
    KEL.typ.nstr Initial_Charge_Disposition_Description_;
    KEL.typ.nstr Additional_Disposition_Description_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Court_Description_;
    KEL.typ.nstr Court_Final_Plea_;
    KEL.typ.nstr Court_Offense_Code_;
    KEL.typ.nstr Court_Offense_Description_;
    KEL.typ.nstr Court_Offense_Additional_Description_;
    KEL.typ.nstr Court_Statute_;
    KEL.typ.nkdate Court_Disposition_Date_;
    KEL.typ.nint Court_Fine_;
    KEL.typ.nstr Suspended_Court_Fine_;
    KEL.typ.nint Court_Cost_;
    KEL.typ.nstr Court_Disposition_Code_;
    KEL.typ.nstr Court_Disposition_Description_;
    KEL.typ.nstr Court_Additional_Disposition_Description_;
    KEL.typ.nkdate Date_Of_Appeal_;
    KEL.typ.nkdate Dateof_Verdict_;
    KEL.typ.nstr Offense_Town_;
    KEL.typ.nstr Persistent_Offense_Key_;
    KEL.typ.nkdate Court_Date_;
    KEL.typ.nstr Court_County_;
    KEL.typ.nstr Arrest_Offense_Level_Mapped_;
    KEL.typ.nstr Court_Offense_Level_Mapped_;
    KEL.typ.ndataset(B_Criminal_Offense_4(__in,__cfg).__ST205411_Layout) Offense_Charges_;
    KEL.typ.ndataset(E_Criminal_Offense(__in,__cfg).Criminal_Data_Sources_Layout) Criminal_Data_Sources_;
    KEL.typ.ndataset(E_Criminal_Offense(__in,__cfg).Court_Offense_Level_Layout) Court_Offense_Level_;
    KEL.typ.ndataset(E_Criminal_Offense(__in,__cfg).Fcra_Data_Layout) Fcra_Data_;
    KEL.typ.ndataset(E_Criminal_Offense(__in,__cfg).Conviction_Overrides_Layout) Conviction_Overrides_;
    KEL.typ.ndataset(E_Criminal_Offense(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Criminal_Offense().Typ) Offense_;
    KEL.typ.ndataset(E_Person_Offenses(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC2499241(B_Criminal_Offense_4(__in,__cfg).__ST205364_Layout __EE2499157, E_Person_Offenses(__in,__cfg).Layout __EE2497563) := __EEQP(__EE2497563.Offense_,__EE2499157.UID);
  __ST791479_Layout __JT2499241(B_Criminal_Offense_4(__in,__cfg).__ST205364_Layout __l, E_Person_Offenses(__in,__cfg).Layout __r) := TRANSFORM
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE2499327 := JOIN(__EE2497563,__EE2499157,__JC2499241(RIGHT,LEFT),__JT2499241(RIGHT,LEFT),INNER,HASH);
  SHARED __ST789982_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Criminal_Offense().Typ) Offense_;
    KEL.typ.ndataset(E_Person_Offenses(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.ndataset(B_Criminal_Offense_4(__in,__cfg).__ST205411_Layout) Offense_Charges_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST789982_Layout __ND2499332__Project(__ST791479_Layout __PP2499328) := TRANSFORM
    SELF.UID := __PP2499328.Subject_;
    SELF.Data_Sources_ := __PP2499328.Data_Sources__1_;
    SELF.U_I_D__1_ := __PP2499328.UID;
    SELF := __PP2499328;
  END;
  SHARED __EE2499387 := PROJECT(__EE2499327,__ND2499332__Project(LEFT));
  SHARED __ST790062_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.bool Exp1_ := FALSE;
    KEL.typ.bool Exp2_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST790062_Layout __ND2499392__Project(__ST789982_Layout __PP2499388) := TRANSFORM
    __CC28077 := 2556;
    __BS2499398 := __T(__PP2499388.Offense_Charges_);
    SELF.Exp1_ := EXISTS(__BS2499398(__T(__AND(__OP2(__T(__PP2499388.Offense_Charges_).Is_Felony_Non_F_C_R_A_,=,__CN(TRUE)),__AND(__OP2(__T(__PP2499388.Offense_Charges_).Age_In_Days_,<=,__CN(__CC28077)),__NOT(__NT(__T(__PP2499388.Offense_Charges_).Age_In_Days_)))))));
    __BS2499421 := __T(__PP2499388.Offense_Charges_);
    SELF.Exp2_ := EXISTS(__BS2499421(__T(__AND(__OP2(__T(__PP2499388.Offense_Charges_).Is_Non_Felony_Records_Non_F_C_R_A_,=,__CN(TRUE)),__AND(__OP2(__T(__PP2499388.Offense_Charges_).Age_In_Days_,<=,__CN(__CC28077)),__NOT(__NT(__T(__PP2499388.Offense_Charges_).Age_In_Days_)))))));
    SELF := __PP2499388;
  END;
  SHARED __EE2499447 := PROJECT(__EE2499387,__ND2499392__Project(LEFT));
  SHARED __ST790082_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE2499468 := PROJECT(__CLEANANDDO(__EE2499447,TABLE(__EE2499447,{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP,__EE2499447.Exp1_),KEL.typ.int C_O_U_N_T___Exp1__1_ := COUNT(GROUP,__EE2499447.Exp2_),UID},UID,MERGE)),__ST790082_Layout);
  SHARED __ST791668_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg).__ST206681_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg).__ST551204_Layout) All_Lien_Data_;
    KEL.typ.ndataset(B_Person_5(__in,__cfg).__ST108227_Layout) Edu_Rec_Ver_Source_List_Sorted_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.nkdate Select_Age_;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC2499474(B_Person_4(__in,__cfg).__ST206664_Layout __EE2492554, __ST790082_Layout __EE2499468) := __EEQP(__EE2492554.UID,__EE2499468.UID);
  __ST791668_Layout __JT2499474(B_Person_4(__in,__cfg).__ST206664_Layout __l, __ST790082_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE2499578 := JOIN(__EE2492554,__EE2499468,__JC2499474(LEFT,RIGHT),__JT2499474(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE2493000 := __ENH_Bankruptcy_4;
  SHARED __EE788395 := __E_Person_Bankruptcy;
  SHARED __EE2498194 := __EE788395(__NN(__EE788395.Subject_) AND __NN(__EE788395.Bankrupt_));
  SHARED __ST790523_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_8(__in,__cfg).__ST217772_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Bankruptcy_4(__in,__cfg).__ST429358_Layout) Best_Child_Record_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Bankruptcy().Typ) Bankrupt_;
    KEL.typ.ndataset(E_Person_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC2498212(B_Bankruptcy_4(__in,__cfg).__ST200563_Layout __EE2493000, E_Person_Bankruptcy(__in,__cfg).Layout __EE2498194) := __EEQP(__EE2498194.Bankrupt_,__EE2493000.UID);
  __ST790523_Layout __JT2498212(B_Bankruptcy_4(__in,__cfg).__ST200563_Layout __l, E_Person_Bankruptcy(__in,__cfg).Layout __r) := TRANSFORM
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE2498213 := JOIN(__EE2498194,__EE2493000,__JC2498212(RIGHT,LEFT),__JT2498212(RIGHT,LEFT),INNER,HASH);
  SHARED __ST790875_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_8(__in,__cfg).__ST217772_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Bankruptcy_4(__in,__cfg).__ST429358_Layout) Best_Child_Record_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Bankruptcy().Typ) Bankrupt_;
    KEL.typ.ndataset(E_Person_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nstr Source_Description_;
    KEL.typ.nstr Original_Chapter_;
    KEL.typ.nstr Filing_Type_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Corporate_Flag_;
    KEL.typ.nkdate Discharged_Date_;
    KEL.typ.nstr Disposition_;
    KEL.typ.nstr Debtor_Type_;
    KEL.typ.nint Debtor_Sequence_;
    KEL.typ.nint Disposition_Type_;
    KEL.typ.nint Disposition_Reason_;
    KEL.typ.nstr Disposition_Type_Description_;
    KEL.typ.nstr Name_Type_;
    KEL.typ.nstr Screen_Description_;
    KEL.typ.nstr Decoded_Description_;
    KEL.typ.nkdate Date_Filed_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nkdate Last_Status_Update_;
    KEL.typ.nbool Banko10_Year_;
    KEL.typ.nbool Banko7_Year_;
    KEL.typ.nkdate Bankruptcy_Date_;
    KEL.typ.nint Filing_Age_In_Days_;
    KEL.typ.nbool Is_Bankruptcy_;
    KEL.typ.nint Status_Update_Age_In_Days_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC2498298(__ST790523_Layout __EE2498213, B_Bankruptcy_4(__in,__cfg).__ST429358_Layout __EE2498284) := __T(__EE2498284.Banko10_Year_);
  __ST790875_Layout __JT2498298(__ST790523_Layout __l, B_Bankruptcy_4(__in,__cfg).__ST429358_Layout __r) := TRANSFORM, SKIP(NOT(__JC2498298(__l,__r)))
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE2498299 := NORMALIZE(__EE2498213,__T(LEFT.Best_Child_Record_),__JT2498298(LEFT,RIGHT));
  SHARED __ST788796_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Bankruptcy().Typ) Bankrupt_;
    KEL.typ.ndataset(E_Person_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(B_Bankruptcy_8(__in,__cfg).__ST217772_Layout) Records_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.ndataset(B_Bankruptcy_4(__in,__cfg).__ST429358_Layout) Best_Child_Record_;
    KEL.typ.nbool Has_Case_Number_;
    KEL.typ.nstr Source_Description_;
    KEL.typ.nstr Original_Chapter_;
    KEL.typ.nstr Filing_Type_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Corporate_Flag_;
    KEL.typ.nkdate Discharged_Date_;
    KEL.typ.nstr Disposition_;
    KEL.typ.nstr Debtor_Type_;
    KEL.typ.nint Debtor_Sequence_;
    KEL.typ.nint Disposition_Type_;
    KEL.typ.nint Disposition_Reason_;
    KEL.typ.nstr Disposition_Type_Description_;
    KEL.typ.nstr Name_Type_;
    KEL.typ.nstr Screen_Description_;
    KEL.typ.nstr Decoded_Description_;
    KEL.typ.nkdate Date_Filed_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nkdate Last_Status_Update_;
    KEL.typ.nbool Banko10_Year_;
    KEL.typ.nbool Banko7_Year_;
    KEL.typ.nkdate Bankruptcy_Date_;
    KEL.typ.nint Filing_Age_In_Days_;
    KEL.typ.nbool Is_Bankruptcy_;
    KEL.typ.nint Status_Update_Age_In_Days_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST788796_Layout __ND2498394__Project(__ST790875_Layout __PP2498300) := TRANSFORM
    SELF.UID := __PP2498300.Subject_;
    SELF.Data_Sources_ := __PP2498300.Data_Sources__1_;
    SELF.U_I_D__1_ := __PP2498300.UID;
    SELF.Data_Sources__1_ := __PP2498300.Data_Sources_;
    SELF := __PP2498300;
  END;
  SHARED __EE2498651 := PROJECT(__EE2498299,__ND2498394__Project(LEFT));
  SHARED __ST788996_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.ntyp(E_Person().Typ) UID;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE2498664 := PROJECT(__CLEANANDDO(__EE2498651,TABLE(__EE2498651,{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP),UID},UID,MERGE)),__ST788996_Layout);
  SHARED __ST792184_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg).__ST206681_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg).__ST551204_Layout) All_Lien_Data_;
    KEL.typ.ndataset(B_Person_5(__in,__cfg).__ST108227_Layout) Edu_Rec_Ver_Source_List_Sorted_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.nkdate Select_Age_;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__1_;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__2_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC2499584(__ST791668_Layout __EE2499578, __ST788996_Layout __EE2498664) := __EEQP(__EE2499578.UID,__EE2498664.UID);
  __ST792184_Layout __JT2499584(__ST791668_Layout __l, __ST788996_Layout __r) := TRANSFORM
    SELF.C_O_U_N_T___Exp1__2_ := __r.C_O_U_N_T___Exp1_;
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE2499692 := JOIN(__EE2499578,__EE2498664,__JC2499584(LEFT,RIGHT),__JT2499584(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST198859_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg).__ST206681_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.nint Age_;
    KEL.typ.ndataset(B_Person_4(__in,__cfg).__ST551204_Layout) All_Lien_Data_;
    KEL.typ.int Drg_Bk_Cnt10_Y_ := 0;
    KEL.typ.int Drg_Crim_Fel_Cnt7_Y_ := 0;
    KEL.typ.int Drg_Crim_Nfel_Cnt7_Y_ := 0;
    KEL.typ.ndataset(B_Person_5(__in,__cfg).__ST108227_Layout) Edu_Coll_Rec_Ver_Source_List_;
    KEL.typ.int P_L___Drg_Judg_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_L_T_D_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Lien_Cnt7_Y_ := 0;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.nkdate Select_Age_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST198859_Layout __ND2499701__Project(__ST792184_Layout __PP2499697) := TRANSFORM
    __CC13154 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('header_build_version'))),__CN(__cfg.CurrentDate));
    SELF.Age_ := __FN2(KEL.Routines.YearsBetween,__PP2499697.Select_Age_,__CC13154);
    SELF.Drg_Bk_Cnt10_Y_ := KEL.Routines.BoundsFold(__PP2499697.C_O_U_N_T___Exp1__2_,0,999);
    SELF.Drg_Crim_Fel_Cnt7_Y_ := __PP2499697.C_O_U_N_T___Exp1_;
    SELF.Drg_Crim_Nfel_Cnt7_Y_ := __PP2499697.C_O_U_N_T___Exp1__1_;
    __EE2499695 := __PP2499697.Edu_Rec_Ver_Source_List_Sorted_;
    __BS2499841 := __T(__EE2499695);
    __EE2499848 := __BS2499841(__T(__OP2(__T(__EE2499695).File_Type_,IN,__CN(['C','H','O']))));
    SELF.Edu_Coll_Rec_Ver_Source_List_ := __CN(__EE2499848);
    __CC13943 := -99999;
    __BS2499855 := __T(__PP2499697.All_Lien_Data_);
    SELF.P_L___Drg_Judg_Cnt7_Y_ := IF(__PP2499697.P___Lex_I_D_Seen_Flag_ = '0',__CC13943,KEL.Routines.BoundsFold(COUNT(__BS2499855(__T(__AND(__T(__PP2499697.All_Lien_Data_).Seen___In___Seven___Years_,__T(__PP2499697.All_Lien_Data_).Is_Over_All_Judgment_)))),0,999));
    __BS2499872 := __T(__PP2499697.All_Lien_Data_);
    SELF.P_L___Drg_L_T_D_Cnt7_Y_ := IF(__PP2499697.P___Lex_I_D_Seen_Flag_ = '0',__CC13943,KEL.Routines.BoundsFold(COUNT(__BS2499872(__T(__AND(__T(__PP2499697.All_Lien_Data_).Seen___In___Seven___Years_,__OP2(__T(__PP2499697.All_Lien_Data_).Is_Landlord_Tenant_Dispute_,=,__CN(TRUE)))))),0,999));
    __BS2499891 := __T(__PP2499697.All_Lien_Data_);
    SELF.P_L___Drg_Lien_Cnt7_Y_ := IF(__PP2499697.P___Lex_I_D_Seen_Flag_ = '0',__CC13943,KEL.Routines.BoundsFold(COUNT(__BS2499891(__T(__AND(__T(__PP2499697.All_Lien_Data_).Seen___In___Seven___Years_,__OP2(__T(__PP2499697.All_Lien_Data_).Is_Over_All_Lien_,=,__CN(TRUE)))))),0,999));
    SELF := __PP2499697;
  END;
  EXPORT __ENH_Person_3 := PROJECT(__EE2499692,__ND2499701__Project(LEFT));
END;
