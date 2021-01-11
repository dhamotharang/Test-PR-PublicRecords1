﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Education_7,B_Person_10,B_Person_7,B_Person_Accident_8,CFG_Compile,E_Accident,E_Education,E_Person,E_Person_Accident,E_Person_Education,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Accident(__in,__cfg).__Result) __E_Accident := E_Accident(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Education_7(__in,__cfg).__ENH_Education_7) __ENH_Education_7 := B_Education_7(__in,__cfg).__ENH_Education_7;
  SHARED VIRTUAL TYPEOF(B_Person_7(__in,__cfg).__ENH_Person_7) __ENH_Person_7 := B_Person_7(__in,__cfg).__ENH_Person_7;
  SHARED VIRTUAL TYPEOF(E_Person_Education(__in,__cfg).__Result) __E_Person_Education := E_Person_Education(__in,__cfg).__Result;
  SHARED __EE4855243 := __ENH_Person_7;
  SHARED __EE4855250 := __EE4855243;
  SHARED __ST421784_Layout := RECORD
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
    KEL.typ.ndataset(B_Person_Accident_8(__in,__cfg).__ST251881_Layout) Accident_Recs_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86259_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST371663_Layout) All_Lien_Data_;
    KEL.typ.nstr Curr_Addr_Full_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86259_Layout) Curr_Addr_Full_Set_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86259_Layout) Recent_Addr_Full_Set_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Accident().Typ) Acc_;
    KEL.typ.nstr Point_Of_Impact_;
    KEL.typ.nstr Driver_B_A_C_Test_Type_;
    KEL.typ.nint Driver_B_A_C_Test_Results_;
    KEL.typ.nint Driver_Alcohol_Drug_Code_;
    KEL.typ.nint Driver_Physical_Defects_;
    KEL.typ.nint Driver_Residence_;
    KEL.typ.nint Driver_Injury_Severity_;
    KEL.typ.nint First_Driver_Safety_;
    KEL.typ.nint Second_Driver_Safety_;
    KEL.typ.nint Driver_Eject_Code_;
    KEL.typ.nint Recommend_Reexam_;
    KEL.typ.nint First_Contributing_Cause_;
    KEL.typ.nint Second_Contributing_Cause_;
    KEL.typ.nint Third_Contributing_Cause_;
    KEL.typ.nstr Vehicle_Incident_I_D_;
    KEL.typ.nstr Vehicle_Status_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nint Airbags_Deploy_;
    KEL.typ.nint Towed_;
    KEL.typ.nstr Impact_Location_;
    KEL.typ.nint Vehicle_Owner_Driver_Code_;
    KEL.typ.nint Vehicle_Driver_Action_;
    KEL.typ.nstr Vehicle_Travel_On_;
    KEL.typ.nstr Direction_Of_Travel_;
    KEL.typ.nint Estimated_Vehicle_Speed_;
    KEL.typ.nint Posted_Speed_;
    KEL.typ.nint Estimated_Vehicle_Damage_;
    KEL.typ.nint Damage_Type_;
    KEL.typ.nstr Vehicle_Removed_By_;
    KEL.typ.nint How_Removed_Code_;
    KEL.typ.nint Vehicle_Movement_;
    KEL.typ.nint Vehicle_Function_;
    KEL.typ.nint Vehicle_First_Defect_;
    KEL.typ.nint Vehicle_Second_Defect_;
    KEL.typ.nint Vehicle_Roadway_Location_;
    KEL.typ.nint Hazardous_Material_Transport_;
    KEL.typ.nint Total_Occupancy_Vehicle_;
    KEL.typ.nint Total_Occupancy_Safety_Equipment_;
    KEL.typ.nint Moving_Violation_;
    KEL.typ.nint Vehicle_Fault_Code_;
    KEL.typ.nstr Vehicle_Insured_Code_;
    KEL.typ.ndataset(E_Person_Accident(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.bool Is_Accident_Record_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __ST421784_Layout __JT4855258(B_Person_7(__in,__cfg).__ST249163_Layout __l, B_Person_Accident_8(__in,__cfg).__ST251881_Layout __r) := TRANSFORM
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4855530 := NORMALIZE(__EE4855250,__T(LEFT.Accident_Recs_),__JT4855258(LEFT,RIGHT));
  SHARED __EE4855245 := __E_Accident;
  SHARED __ST422110_Layout := RECORD
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
    KEL.typ.ndataset(B_Person_Accident_8(__in,__cfg).__ST251881_Layout) Accident_Recs_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86259_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST371663_Layout) All_Lien_Data_;
    KEL.typ.nstr Curr_Addr_Full_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86259_Layout) Curr_Addr_Full_Set_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86259_Layout) Recent_Addr_Full_Set_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Accident().Typ) Acc_;
    KEL.typ.nstr Point_Of_Impact_;
    KEL.typ.nstr Driver_B_A_C_Test_Type_;
    KEL.typ.nint Driver_B_A_C_Test_Results_;
    KEL.typ.nint Driver_Alcohol_Drug_Code_;
    KEL.typ.nint Driver_Physical_Defects_;
    KEL.typ.nint Driver_Residence_;
    KEL.typ.nint Driver_Injury_Severity_;
    KEL.typ.nint First_Driver_Safety_;
    KEL.typ.nint Second_Driver_Safety_;
    KEL.typ.nint Driver_Eject_Code_;
    KEL.typ.nint Recommend_Reexam_;
    KEL.typ.nint First_Contributing_Cause_;
    KEL.typ.nint Second_Contributing_Cause_;
    KEL.typ.nint Third_Contributing_Cause_;
    KEL.typ.nstr Vehicle_Incident_I_D_;
    KEL.typ.nstr Vehicle_Status_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nint Airbags_Deploy_;
    KEL.typ.nint Towed_;
    KEL.typ.nstr Impact_Location_;
    KEL.typ.nint Vehicle_Owner_Driver_Code_;
    KEL.typ.nint Vehicle_Driver_Action_;
    KEL.typ.nstr Vehicle_Travel_On_;
    KEL.typ.nstr Direction_Of_Travel_;
    KEL.typ.nint Estimated_Vehicle_Speed_;
    KEL.typ.nint Posted_Speed_;
    KEL.typ.nint Estimated_Vehicle_Damage_;
    KEL.typ.nint Damage_Type_;
    KEL.typ.nstr Vehicle_Removed_By_;
    KEL.typ.nint How_Removed_Code_;
    KEL.typ.nint Vehicle_Movement_;
    KEL.typ.nint Vehicle_Function_;
    KEL.typ.nint Vehicle_First_Defect_;
    KEL.typ.nint Vehicle_Second_Defect_;
    KEL.typ.nint Vehicle_Roadway_Location_;
    KEL.typ.nint Hazardous_Material_Transport_;
    KEL.typ.nint Total_Occupancy_Vehicle_;
    KEL.typ.nint Total_Occupancy_Safety_Equipment_;
    KEL.typ.nint Moving_Violation_;
    KEL.typ.nint Vehicle_Fault_Code_;
    KEL.typ.nstr Vehicle_Insured_Code_;
    KEL.typ.ndataset(E_Person_Accident(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.bool Is_Accident_Record_ := FALSE;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nstr Accident_Number_;
    KEL.typ.nkdate Accident_Date_;
    KEL.typ.nstr Accident_Location_;
    KEL.typ.nstr Accident_Street_;
    KEL.typ.nstr Accident_Cross_Street_;
    KEL.typ.nstr Next_Street_;
    KEL.typ.nstr Incident_City_;
    KEL.typ.nstr Incident_State_;
    KEL.typ.nstr Jurisdiction_State_;
    KEL.typ.nstr Jurisdiction_;
    KEL.typ.nint Jurisdiction_Number_;
    KEL.typ.nstr Report_Category_;
    KEL.typ.nstr Report_Type_I_D_;
    KEL.typ.nstr Report_Code_Description_;
    KEL.typ.nbool Report_Has_Cover_Sheet_;
    KEL.typ.nstr Additional_Report_Number_;
    KEL.typ.ndataset(E_Accident(__in,__cfg).Report_Codes_Layout) Report_Codes_;
    KEL.typ.ndataset(E_Accident(__in,__cfg).Report_Statuses_Layout) Report_Statuses_;
    KEL.typ.ndataset(E_Accident(__in,__cfg).Data_Sources_Layout) Data_Sources__2_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC4855539(__ST421784_Layout __EE4855530, E_Accident(__in,__cfg).Layout __EE4855245) := __EEQP(__EE4855530.Acc_,__EE4855245.UID);
  __ST422110_Layout __JT4855539(__ST421784_Layout __l, E_Accident(__in,__cfg).Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF.Data_Sources__2_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4855839 := JOIN(__EE4855530,__EE4855245,__JC4855539(LEFT,RIGHT),__JT4855539(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST4867009_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Estimated_Vehicle_Damage_;
    KEL.typ.nkdate Accident_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE4867014 := PROJECT(TABLE(PROJECT(__EE4855839,__ST4867009_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),UID,Estimated_Vehicle_Damage_,Accident_Date_},UID,Estimated_Vehicle_Damage_,Accident_Date_,MERGE),__ST4867009_Layout);
  SHARED __ST4867030_Layout := RECORD
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
    KEL.typ.ndataset(B_Person_Accident_8(__in,__cfg).__ST251881_Layout) Accident_Recs_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86259_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST371663_Layout) All_Lien_Data_;
    KEL.typ.nstr Curr_Addr_Full_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86259_Layout) Curr_Addr_Full_Set_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86259_Layout) Recent_Addr_Full_Set_;
    KEL.typ.ndataset(__ST4867009_Layout) Person_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC4867027(B_Person_7(__in,__cfg).__ST249163_Layout __EE4855243, __ST4867009_Layout __EE4867014) := __EEQP(__EE4855243.UID,__EE4867014.UID);
  __ST4867030_Layout __Join__ST4867030_Layout(B_Person_7(__in,__cfg).__ST249163_Layout __r, DATASET(__ST4867009_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Person_ := __CN(__recs);
  END;
  SHARED __EE4867028 := DENORMALIZE(DISTRIBUTE(__EE4855243,HASH(UID)),DISTRIBUTE(__EE4867014,HASH(UID)),__JC4867027(LEFT,RIGHT),GROUP,__Join__ST4867030_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  SHARED __EE4856371 := __ENH_Education_7;
  SHARED __EE4856377 := __EE4856371(__EE4856371.Edu_Rec_Flag_);
  SHARED __EE4856369 := __E_Person_Education;
  SHARED __EE4863036 := __EE4856369(__NN(__EE4856369.Subject_) AND __NN(__EE4856369.Edu_));
  SHARED __ST417520_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr College_Name_;
    KEL.typ.nstr L_N_College_Name_;
    KEL.typ.nstr Sequence_;
    KEL.typ.nstr Key_;
    KEL.typ.nstr Raw_A_I_D_;
    KEL.typ.ndataset(E_Education(__in,__cfg).College_Characteristics_Layout) College_Characteristics_;
    KEL.typ.ndataset(E_Education(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.bool Edu_Rec_Flag_ := FALSE;
    KEL.typ.ntyp(E_Education().Typ) Edu_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nstr D_I_D_;
    KEL.typ.nkdate Process_Date_;
    KEL.typ.nstr Historical_Flag_;
    KEL.typ.nstr Class_;
    KEL.typ.nstr College_Class_;
    KEL.typ.nstr College_Major_;
    KEL.typ.nstr New_College_Major_;
    KEL.typ.nstr Head_Of_Household_First_Name_;
    KEL.typ.nstr Head_Of_Household_Gender_Code_;
    KEL.typ.nstr Head_Of_Household_Gender_;
    KEL.typ.nstr Raw_A_I_D__1_;
    KEL.typ.ndataset(E_Person_Education(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC4863054(B_Education_7(__in,__cfg).__ST247935_Layout __EE4856377, E_Person_Education(__in,__cfg).Layout __EE4863036) := __EEQP(__EE4863036.Edu_,__EE4856377.UID);
  __ST417520_Layout __JT4863054(B_Education_7(__in,__cfg).__ST247935_Layout __l, E_Person_Education(__in,__cfg).Layout __r) := TRANSFORM
    SELF.Raw_A_I_D__1_ := __r.Raw_A_I_D_;
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4863055 := JOIN(__EE4863036,__EE4856377,__JC4863054(RIGHT,LEFT),__JT4863054(RIGHT,LEFT),INNER,HASH);
  SHARED __ST417684_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr College_Name_;
    KEL.typ.nstr L_N_College_Name_;
    KEL.typ.nstr Sequence_;
    KEL.typ.nstr Key_;
    KEL.typ.nstr Raw_A_I_D_;
    KEL.typ.ndataset(E_Education(__in,__cfg).College_Characteristics_Layout) College_Characteristics_;
    KEL.typ.ndataset(E_Education(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.bool Edu_Rec_Flag_ := FALSE;
    KEL.typ.ntyp(E_Education().Typ) Edu_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nstr D_I_D_;
    KEL.typ.nkdate Process_Date_;
    KEL.typ.nstr Historical_Flag_;
    KEL.typ.nstr Class_;
    KEL.typ.nstr College_Class_;
    KEL.typ.nstr College_Major_;
    KEL.typ.nstr New_College_Major_;
    KEL.typ.nstr Head_Of_Household_First_Name_;
    KEL.typ.nstr Head_Of_Household_Gender_Code_;
    KEL.typ.nstr Head_Of_Household_Gender_;
    KEL.typ.nstr Raw_A_I_D__1_;
    KEL.typ.ndataset(E_Person_Education(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.nstr College_Code_;
    KEL.typ.nstr College_Type_;
    KEL.typ.nstr File_Type_;
    KEL.typ.nstr School_Size_Code_;
    KEL.typ.nstr Competitive_Code_;
    KEL.typ.nstr Tuition_Code_;
    KEL.typ.nstr Tier_;
    KEL.typ.nstr Tier2_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __ST417684_Layout __JT4863110(__ST417520_Layout __l, E_Education(__in,__cfg).College_Characteristics_Layout __r) := TRANSFORM
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4863111 := NORMALIZE(__EE4863055,__T(LEFT.College_Characteristics_),__JT4863110(LEFT,RIGHT));
  SHARED __ST415825_Layout := RECORD
    KEL.typ.ntyp(E_Education().Typ) Edu_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nstr D_I_D_;
    KEL.typ.nkdate Process_Date_;
    KEL.typ.nstr Historical_Flag_;
    KEL.typ.nstr Class_;
    KEL.typ.nstr College_Class_;
    KEL.typ.nstr College_Major_;
    KEL.typ.nstr New_College_Major_;
    KEL.typ.nstr Head_Of_Household_First_Name_;
    KEL.typ.nstr Head_Of_Household_Gender_Code_;
    KEL.typ.nstr Head_Of_Household_Gender_;
    KEL.typ.nstr Raw_A_I_D_;
    KEL.typ.ndataset(E_Person_Education(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ntyp(E_Education().Typ) UID;
    KEL.typ.nstr College_Code_;
    KEL.typ.nstr College_Type_;
    KEL.typ.nstr File_Type_;
    KEL.typ.nstr School_Size_Code_;
    KEL.typ.nstr Competitive_Code_;
    KEL.typ.nstr Tuition_Code_;
    KEL.typ.nstr Tier_;
    KEL.typ.nstr Tier2_;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST415825_Layout __ND4863161__Project(__ST417684_Layout __PP4863112) := TRANSFORM
    SELF.Raw_A_I_D_ := __PP4863112.Raw_A_I_D__1_;
    SELF.Data_Sources_ := __PP4863112.Data_Sources__1_;
    SELF.UID := __PP4863112.Edu_;
    SELF.U_I_D__1_ := __PP4863112.Subject_;
    SELF := __PP4863112;
  END;
  SHARED __EE4863262 := PROJECT(__EE4863111,__ND4863161__Project(LEFT));
  SHARED __ST416778_Layout := RECORD
    KEL.typ.nstr File_Type_;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__1_;
    KEL.typ.nkdate Exp1_;
    KEL.typ.nkdate Exp2_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST416778_Layout __ND4867274__Project(__ST415825_Layout __PP4863263) := TRANSFORM
    SELF.Exp1_ := KEL.era.ToDate(__PP4863263.Date_First_Seen_);
    SELF.Exp2_ := KEL.era.ToDate(__PP4863263.Date_Last_Seen_);
    SELF := __PP4863263;
  END;
  SHARED __EE4867275 := PROJECT(__EE4863262,__ND4867274__Project(LEFT));
  SHARED __ST416802_Layout := RECORD
    KEL.typ.nkdate M_I_N___Exp1_;
    KEL.typ.nkdate M_A_X___Exp1_;
    KEL.typ.nstr File_Type_;
    KEL.typ.ntyp(E_Person().Typ) U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE4867307 := PROJECT(__CLEANANDDO(__EE4867275,TABLE(__EE4867275,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),KEL.Aggregates.MinNG(__EE4867275.Exp1_) M_I_N___Exp1_,KEL.Aggregates.MaxNG(__EE4867275.Exp2_) M_A_X___Exp1_,File_Type_,U_I_D__1_},File_Type_,U_I_D__1_,MERGE)),__ST416802_Layout);
  SHARED __ST425371_Layout := RECORD
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
    KEL.typ.ndataset(B_Person_Accident_8(__in,__cfg).__ST251881_Layout) Accident_Recs_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86259_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST371663_Layout) All_Lien_Data_;
    KEL.typ.nstr Curr_Addr_Full_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86259_Layout) Curr_Addr_Full_Set_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86259_Layout) Recent_Addr_Full_Set_;
    KEL.typ.ndataset(__ST4867009_Layout) Person_;
    KEL.typ.ndataset(__ST416802_Layout) Exp1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC4867315(__ST4867030_Layout __EE4867028, __ST416802_Layout __EE4867307) := __EEQP(__EE4867028.UID,__EE4867307.U_I_D__1_);
  __ST425371_Layout __Join__ST425371_Layout(__ST4867030_Layout __r, DATASET(__ST416802_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Exp1_ := __CN(__recs);
  END;
  SHARED __EE4867570 := DENORMALIZE(DISTRIBUTE(__EE4867028,HASH(UID)),DISTRIBUTE(__EE4867307,HASH(U_I_D__1_)),__JC4867315(LEFT,RIGHT),GROUP,__Join__ST425371_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  SHARED __ST426936_Layout := RECORD
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
    KEL.typ.ndataset(B_Person_Accident_8(__in,__cfg).__ST251881_Layout) Accident_Recs_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86259_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST371663_Layout) All_Lien_Data_;
    KEL.typ.nstr Curr_Addr_Full_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86259_Layout) Curr_Addr_Full_Set_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86259_Layout) Recent_Addr_Full_Set_;
    KEL.typ.ndataset(__ST4867009_Layout) Person_;
    KEL.typ.ndataset(__ST416802_Layout) Exp1_;
    KEL.typ.bool Person_Education_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE4865621 := __EE4863036;
  SHARED __EE4865618 := __EE4856371;
  SHARED __EE4865636 := __EE4865618.Data_Sources_;
  __JC4869067(E_Education(__in,__cfg).Data_Sources_Layout __EE4865636) := __T(__OP2(__EE4865636.Source_,=,__CN('AY')));
  SHARED __EE4869068 := __EE4865618(EXISTS(__CHILDJOINFILTER(__EE4865636,__JC4869067)));
  __JC4869095(E_Person_Education(__in,__cfg).Layout __EE4865621, B_Education_7(__in,__cfg).__ST247935_Layout __EE4869068) := __EEQP(__EE4865621.Edu_,__EE4869068.UID);
  SHARED __EE4869113 := JOIN(__EE4865621,__EE4869068,__JC4869095(LEFT,RIGHT),TRANSFORM(E_Person_Education(__in,__cfg).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC4869119(__ST425371_Layout __EE4867570, E_Person_Education(__in,__cfg).Layout __EE4869113) := __EEQP(__EE4867570.UID,__EE4869113.Subject_);
  __JF4869119(E_Person_Education(__in,__cfg).Layout __EE4869113) := __NN(__EE4869113.Subject_);
  SHARED __EE4869354 := JOIN(__EE4867570,__EE4869113,__JC4869119(LEFT,RIGHT),TRANSFORM(__ST426936_Layout,SELF:=LEFT,SELF.Person_Education_:=__JF4869119(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST245633_Layout := RECORD
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool Best_;
    KEL.typ.nbool Best_D_O_B_Rec_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST245647_Layout := RECORD
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
  EXPORT __ST95558_Layout := RECORD
    KEL.typ.nstr Estimated_Vehicle_Damage_;
    KEL.typ.nstr Date_Of_Accident_;
    KEL.typ.nint Accident_Age_In_Days_;
    KEL.typ.nstr Formatted_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST413283_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.bool Landlord_Tenant_Dispute_Flag_ := FALSE;
    KEL.typ.nkdate Original_Filing_Date_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.nbool Is_Civil_Court_Judgment_;
    KEL.typ.nbool Is_Federal_Tax_Lien_;
    KEL.typ.nbool Is_Foreclosure_Judgment_;
    KEL.typ.nbool Is_Landlord_Tenant_Dispute_;
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
  EXPORT __ST88852_Layout := RECORD
    KEL.typ.nstr File_Type_;
    KEL.typ.nkdate Date_First_Seen_Min_;
    KEL.typ.nkdate Date_Last_Seen_Max_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST245616_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(__ST245633_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(__ST245647_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Dunn_Data_Layout) Dunn_Data_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.ndataset(B_Person_Accident_8(__in,__cfg).__ST251881_Layout) Accident_Recs_;
    KEL.typ.ndataset(__ST95558_Layout) Accident_Recs_Formatted_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86259_Layout) Address_Hierarchy_Set_;
    KEL.typ.ndataset(__ST413283_Layout) All_Lien_Data_;
    KEL.typ.nkdate B_U_I_L_D___D_A_T_E_;
    KEL.typ.nstr Curr_Addr_Full_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86259_Layout) Curr_Addr_Full_Set_;
    KEL.typ.ndataset(__ST88852_Layout) Edu_Rec_Ver_Source_List_Pre_;
    KEL.typ.nstr Ln_J7_Y_Old_Date_;
    KEL.typ.int P_L___Drg_Ln_J_Cnt7_Y_ := 0;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86259_Layout) Prev_Addr_Full_Set_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST86259_Layout) Recent_Addr_Full_Set_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST245616_Layout __ND4869375__Project(__ST426936_Layout __PP4869371) := TRANSFORM
    __EE4869357 := __PP4869371.Reported_Dates_Of_Birth_;
    __ST245633_Layout __ND4869614__Project(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout __PP4869610) := TRANSFORM
      SELF.Best_D_O_B_Rec_ := __OP2(__PP4869610.Best_,=,__CN(TRUE));
      SELF := __PP4869610;
    END;
    SELF.Reported_Dates_Of_Birth_ := __PROJECT(__EE4869357,__ND4869614__Project(LEFT));
    __EE4869361 := __PP4869371.Data_Sources_;
    __ST245647_Layout __ND4869645__Project(E_Person(__in,__cfg).Data_Sources_Layout __PP4869641) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP4869641.Source_));
      SELF := __PP4869641;
    END;
    SELF.Data_Sources_ := __PROJECT(__EE4869361,__ND4869645__Project(LEFT));
    __EE4869365 := __PP4869371.Person_;
    __ST95558_Layout __ND4869691__Project(__ST4867009_Layout __PP4869677) := TRANSFORM
      __CC13756 := '-99997';
      SELF.Estimated_Vehicle_Damage_ := IF(__T(__OR(__OP2(__CAST(KEL.typ.str,__PP4869677.Estimated_Vehicle_Damage_),=,__CN('')),__NT(__PP4869677.Estimated_Vehicle_Damage_))),__ECAST(KEL.typ.nstr,__CN(__CC13756)),__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__PP4869677.Estimated_Vehicle_Damage_)));
      __CC13257 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('accident_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Date_Of_Accident_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP4869677.Accident_Date_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(__PP4869677.Accident_Date_,__CC13257),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13756)));
      SELF.Accident_Age_In_Days_ := FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,__PP4869677.Accident_Date_),__ECAST(KEL.typ.nkdate,__CC13257));
      __CC64179 := '99999999';
      SELF.Formatted_Date_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP4869677.Accident_Date_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(__PP4869677.Accident_Date_,__CC13257),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC64179)));
      SELF := __PP4869677;
    END;
    SELF.Accident_Recs_Formatted_ := __BN(PROJECT(TABLE(PROJECT(__T(__EE4869365),__ND4869691__Project(LEFT))(__NN(Estimated_Vehicle_Damage_) OR __NN(Date_Of_Accident_) OR __NN(Accident_Age_In_Days_) OR __NN(Formatted_Date_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Estimated_Vehicle_Damage_,Date_Of_Accident_,Accident_Age_In_Days_,Formatted_Date_},Estimated_Vehicle_Damage_,Date_Of_Accident_,Accident_Age_In_Days_,Formatted_Date_,MERGE),__ST95558_Layout),__NL(__EE4869365));
    __EE4869729 := __PP4869371.All_Lien_Data_;
    __ST413283_Layout __ND4869737__Project(B_Person_7(__in,__cfg).__ST371663_Layout __PP4869733) := TRANSFORM
      __CC29632 := ['FORCIBLE ENTRY/DETAINER','LANDLORD TENANT JUDGMENT','FORCIBLE ENTRY/DETAINER RELEAS','FORCIBLE ENTRY/DETAINER RELEASE'];
      __CC29645 := ['CIVIL NEW FILING','CIVIL SUIT','CIVIL SUMMONS','COURT ORDER','FEDERAL COURT NEW FILING','FORECLOSURE NEW FILING','JUDGMENT - Chapter 7','LANDLORD TENANT SUIT','LIS PENDENS','LIS PENDENS NOTICE','LIS PENDENS RELEASE'];
      SELF.Is_Landlord_Tenant_Dispute_ := __AND(__OR(__CN(__PP4869733.Landlord_Tenant_Dispute_Flag_ = TRUE),__OP2(__PP4869733.Filing_Type_Description_,IN,__CN(__CC29632))),__NOT(__OP2(__PP4869733.Filing_Type_Description_,IN,__CN(__CC29645))));
      SELF := __PP4869733;
    END;
    SELF.All_Lien_Data_ := __PROJECT(__EE4869729,__ND4869737__Project(LEFT));
    __CC13197 := KEL.Routines.NDateFromNInteger(__CN(20160129));
    __CC13201 := FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('asl_build_version')));
    SELF.B_U_I_L_D___D_A_T_E_ := KEL.Routines.MinN(IF(__PP4869371.Person_Education_,__ECAST(KEL.typ.nkdate,__CC13197),__ECAST(KEL.typ.nkdate,__CC13201)),__CN(__cfg.CurrentDate));
    __EE4869369 := __PP4869371.Exp1_;
    __ST88852_Layout __ND4869843__Project(__ST416802_Layout __PP4869839) := TRANSFORM
      SELF.Date_First_Seen_Min_ := __PP4869839.M_I_N___Exp1_;
      SELF.Date_Last_Seen_Max_ := __PP4869839.M_A_X___Exp1_;
      SELF := __PP4869839;
    END;
    SELF.Edu_Rec_Ver_Source_List_Pre_ := __PROJECT(__EE4869369,__ND4869843__Project(LEFT));
    __EE4869858 := __PP4869371.All_Lien_Data_;
    __BS4869862 := __T(__EE4869858);
    __EE4869870 := __BS4869862(__T(__AND(__T(__EE4869858).Seen___In___Seven___Years_,__T(__EE4869858).Is_Over_All_Lien_Judgment_)));
    __CC13617 := '-99997';
    SELF.Ln_J7_Y_Old_Date_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__ECAST(KEL.typ.nstr,KEL.Aggregates.MinN(__EE4869870,__EE4869870.Original_Filing_Date_))),__ECAST(KEL.typ.nstr,__CN(__CC13617)));
    __CC13610 := -99999;
    __BS4869886 := __T(__PP4869371.All_Lien_Data_);
    SELF.P_L___Drg_Ln_J_Cnt7_Y_ := IF(__PP4869371.P___Lex_I_D_Seen_Flag_ = '0',__CC13610,KEL.Routines.BoundsFold(COUNT(__BS4869886(__T(__AND(__T(__PP4869371.All_Lien_Data_).Seen___In___Seven___Years_,__T(__PP4869371.All_Lien_Data_).Is_Over_All_Lien_Judgment_)))),0,999));
    __EE4869902 := __PP4869371.Recent_Addr_Full_Set_;
    __BS4869906 := __T(__EE4869902);
    __EE4869914 := __BS4869906(__T(__OP2(__T(__EE4869902).Addr_Full_,<>,__PP4869371.Curr_Addr_Full_)));
    __EE4869923 := TOPN(__EE4869914(__NN(__EE4869914.Sort_Field_)),1, -__T(__EE4869914.Sort_Field_),__T(Address_Rank_),__T(Address_Type_),__T(Address_Status_),__T(State_Code_),__T(County_Code_),__T(Latitude_),__T(Longitude_),__T(Geo_Blk_),__T(Addr_Full_),__T(Primary_Range_),__T(Predirectional_),__T(Primary_Name_),__T(Suffix_),__T(Postdirectional_),__T(Unit_Designation_),__T(Secondary_Range_),__T(Postal_City_),__T(State_),__T(Z_I_P5_),__T(Z_I_P4_),__T(Addr1_From_Components_));
    SELF.Prev_Addr_Full_Set_ := __CN(__EE4869923);
    SELF := __PP4869371;
  END;
  EXPORT __ENH_Person_6 := PROJECT(PROJECT(__EE4869354,__ND4869375__Project(LEFT)),__ST245616_Layout);
END;
