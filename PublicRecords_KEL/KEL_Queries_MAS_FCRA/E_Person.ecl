﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL15.Null;
EXPORT E_Person(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Title_;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Middle_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nstr Name_Suffix_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Date_Of_Birth_Padded_;
    KEL.typ.nkdate Date_Of_Death_;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool Best_;
    KEL.typ.nbool F_D_N_Indicator_;
    KEL.typ.nbool Death_Master_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.nkdate Purch_Process_Date_;
    KEL.typ.nstr Purch_History_Flag_;
    KEL.typ.nint Purch_New_Amt_;
    KEL.typ.nint Purch_Total_;
    KEL.typ.nint Purch_Count_;
    KEL.typ.nint Purch_New_Age_Months_;
    KEL.typ.nint Purch_Old_Age_Months_;
    KEL.typ.nint Purch_Item_Count_;
    KEL.typ.nint Purch_Amt_Avg_;
    KEL.typ.nbool Is_Hunt_Fish_;
    KEL.typ.nbool Is_C_C_W_;
    KEL.typ.nstr Permit_Number_;
    KEL.typ.nstr Weapon_Permits_Type_;
    KEL.typ.nkdate Weapon_Registration_Date_;
    KEL.typ.nkdate Weapon_Expiration_Date_;
    KEL.typ.nkdate License_Date_;
    KEL.typ.nstr Home_State_;
    KEL.typ.nstr Source_State_;
    KEL.typ.nbool Is_Resident_;
    KEL.typ.nbool Is_Hunting_;
    KEL.typ.nbool Is_Fishing_;
    KEL.typ.nint Statement_I_D_;
    KEL.typ.nstr Statement_Type_;
    KEL.typ.nstr Data_Group_;
    KEL.typ.nstr Content_;
    KEL.typ.nbool Corrected_Flag_;
    KEL.typ.nbool Consumer_Statement_Flag_;
    KEL.typ.nbool Dispute_Flag_;
    KEL.typ.nbool Security_Freeze_;
    KEL.typ.nbool Security_Alert_;
    KEL.typ.nbool Negative_Alert_;
    KEL.typ.nbool I_D_Theft_Flag_;
    KEL.typ.nbool Legal_Hold_Alert_;
    KEL.typ.nkdate Thrive_Date_First_Seen_;
    KEL.typ.nstr Employer_;
    KEL.typ.nstr Pay_Frequency_;
    KEL.typ.nint Income_;
    KEL.typ.nstr Name_Score_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    DATA57 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'lexid(DEFAULT:UID),title(DEFAULT:Title_),firstname(DEFAULT:First_Name_),middlename(DEFAULT:Middle_Name_),lastname(DEFAULT:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),source(DEFAULT:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'did(OVERRIDE:UID),title(OVERRIDE:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),dod(OVERRIDE:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Header,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Header),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((UNSIGNED)did != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid := __d0_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d0_Prefiltered := __d0_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping0_Transform(LEFT)));
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'did(OVERRIDE:UID),title(OVERRIDE:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Header_Quick__Key_Did,TRANSFORM(RECORDOF(__in.Dataset_Header_Quick__Key_Did),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((UNSIGNED)did != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid := __d1_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d1_Prefiltered := __d1_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping1_Transform(LEFT)));
  SHARED __Mapping2 := 'uniqueid(OVERRIDE:UID),title(DEFAULT:Title_),firstname(DEFAULT:First_Name_),middlename(DEFAULT:Middle_Name_),lastname(DEFAULT:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(OVERRIDE:Statement_I_D_:0),statementtype(OVERRIDE:Statement_Type_:\'\'),datagroup(OVERRIDE:Data_Group_:\'\'),content(OVERRIDE:Content_:\'\'),corrected_flag(OVERRIDE:Corrected_Flag_),consumer_statement_flag(OVERRIDE:Consumer_Statement_Flag_),dispute_flag(OVERRIDE:Dispute_Flag_),security_freeze(OVERRIDE:Security_Freeze_),security_alert(OVERRIDE:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),id_theft_flag(OVERRIDE:I_D_Theft_Flag_),legal_hold_alert(OVERRIDE:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_ConsumerStatementFlags,TRANSFORM(RECORDOF(__in.Dataset_ConsumerStatementFlags),SELF:=RIGHT));
  EXPORT __d2_KELfiltered := __d2_Norm((UNSIGNED)UniqueId != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_ConsumerStatementFlags_Invalid := __d2_KELfiltered((KEL.typ.uid)UniqueId = 0);
  SHARED __d2_Prefiltered := __d2_KELfiltered((KEL.typ.uid)UniqueId <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping3 := 'did(OVERRIDE:UID),title(DEFAULT:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(OVERRIDE:Race_:\'\'),race_desc(OVERRIDE:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),fcra_date(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders),SELF:=RIGHT));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_1_Invalid := __d3_Norm((KEL.typ.uid)did = 0);
  SHARED __d3_Prefiltered := __d3_Norm((KEL.typ.uid)did <> 0);
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping4 := 'did(OVERRIDE:UID),title(DEFAULT:Title_),firstname(DEFAULT:First_Name_),middlename(DEFAULT:Middle_Name_),lastname(DEFAULT:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob_alias(OVERRIDE:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),fcra_date(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders),SELF:=RIGHT));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_2_Invalid := __d4_Norm((KEL.typ.uid)did = 0);
  SHARED __d4_Prefiltered := __d4_Norm((KEL.typ.uid)did <> 0);
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_Last_Seen_5Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping5 := 's_did(OVERRIDE:UID),title(DEFAULT:Title_),firstname(DEFAULT:First_Name_),middlename(DEFAULT:Middle_Name_),lastname(DEFAULT:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_5Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d5_Norm := NORMALIZE(__in,LEFT.Dataset_Header__Key_Addr_Hist,TRANSFORM(RECORDOF(__in.Dataset_Header__Key_Addr_Hist),SELF:=RIGHT));
  EXPORT __d5_KELfiltered := __d5_Norm((UNSIGNED)s_did != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header__Key_Addr_Hist_Invalid := __d5_KELfiltered((KEL.typ.uid)s_did = 0);
  SHARED __d5_Prefiltered := __d5_KELfiltered((KEL.typ.uid)s_did <> 0);
  SHARED __d5 := __SourceFilter(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping6 := 'l_did(OVERRIDE:UID),title(DEFAULT:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob8(OVERRIDE:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),dod8(OVERRIDE:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping6_Transform(InLayout __r) := TRANSFORM
    SELF.Death_Master_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d6_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Death_MasterV2_SSA_DID,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Death_MasterV2_SSA_DID),SELF:=RIGHT));
  EXPORT __d6_KELfiltered := __d6_Norm((UNSIGNED)l_did != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Death_MasterV2_SSA_DID_Invalid := __d6_KELfiltered((KEL.typ.uid)l_did = 0);
  SHARED __d6_Prefiltered := __d6_KELfiltered((KEL.typ.uid)l_did <> 0);
  SHARED __d6 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping6_Transform(LEFT)));
  SHARED Date_Last_Seen_7Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping7 := 'did(OVERRIDE:UID),title(OVERRIDE:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),dod(OVERRIDE:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(OVERRIDE:Race_:\'\'),race_name(OVERRIDE:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),source_code(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_7Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d7_Norm := NORMALIZE(__in,LEFT.Dataset_DriversV2__Key_DL_DID,TRANSFORM(RECORDOF(__in.Dataset_DriversV2__Key_DL_DID),SELF:=RIGHT));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_DID_Invalid := __d7_Norm((KEL.typ.uid)did = 0);
  SHARED __d7_Prefiltered := __d7_Norm((KEL.typ.uid)did <> 0);
  SHARED __d7 := __SourceFilter(KEL.FromFlat.Convert(__d7_Prefiltered,InLayout,__Mapping7,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_Last_Seen_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping8 := 'did(OVERRIDE:UID),title(OVERRIDE:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),dod(OVERRIDE:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(OVERRIDE:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),source_code(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_8Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d8_Norm := NORMALIZE(__in,LEFT.Dataset_DriversV2__Key_DL_Number,TRANSFORM(RECORDOF(__in.Dataset_DriversV2__Key_DL_Number),SELF:=RIGHT));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_Number_Invalid := __d8_Norm((KEL.typ.uid)did = 0);
  SHARED __d8_Prefiltered := __d8_Norm((KEL.typ.uid)did <> 0);
  SHARED __d8 := __SourceFilter(KEL.FromFlat.Convert(__d8_Prefiltered,InLayout,__Mapping8,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_9Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Date_Last_Seen_9Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping9 := 'did(OVERRIDE:UID),title(OVERRIDE:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),name_score(OVERRIDE:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_9Rule),datelastseen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_9Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d9_Norm := NORMALIZE(__in,LEFT.Dataset_PhonesPlus_v2__Key_Source_Level_Payload,TRANSFORM(RECORDOF(__in.Dataset_PhonesPlus_v2__Key_Source_Level_Payload),SELF:=RIGHT));
  EXPORT __d9_KELfiltered := __d9_Norm((UNSIGNED)did <> 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PhonesPlus_v2__Key_Source_Level_Payload_Invalid := __d9_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d9_Prefiltered := __d9_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d9 := __SourceFilter(KEL.FromFlat.Convert(__d9_Prefiltered,InLayout,__Mapping9,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping10 := 'rec.did(OVERRIDE:UID),rec.title(OVERRIDE:Title_),rec.fname(OVERRIDE:First_Name_),rec.mname(OVERRIDE:Middle_Name_),rec.lname(OVERRIDE:Last_Name_),rec.name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),rec.dob(OVERRIDE:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),rec.dod(OVERRIDE:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping10_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(FALSE);
    SELF.Best_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d10_Norm := NORMALIZE(__in,LEFT.Dataset_Best_Person__Key_Watchdog,TRANSFORM(RECORDOF(__in.Dataset_Best_Person__Key_Watchdog),SELF:=RIGHT));
  EXPORT __d10_KELfiltered := __d10_Norm((UNSIGNED)rec.did != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Best_Person__Key_Watchdog_Invalid := __d10_KELfiltered((KEL.typ.uid)rec.did = 0);
  SHARED __d10_Prefiltered := __d10_KELfiltered((KEL.typ.uid)rec.did <> 0);
  SHARED __d10 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d10_Prefiltered,InLayout,__Mapping10,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping10_Transform(LEFT)));
  SHARED __Mapping11 := 'did(OVERRIDE:UID),title(OVERRIDE:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),dod(OVERRIDE:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping11_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(FALSE);
    SELF.Best_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d11_Norm := NORMALIZE(__in,LEFT.Dataset_Best_Person__Key_Watchdog_FCRA_nonEN,TRANSFORM(RECORDOF(__in.Dataset_Best_Person__Key_Watchdog_FCRA_nonEN),SELF:=RIGHT));
  EXPORT __d11_KELfiltered := __d11_Norm((UNSIGNED)did != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Best_Person__Key_Watchdog_FCRA_nonEN_Invalid := __d11_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d11_Prefiltered := __d11_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d11 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d11_Prefiltered,InLayout,__Mapping11,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping11_Transform(LEFT)));
  SHARED __Mapping12 := 'did(OVERRIDE:UID),title(OVERRIDE:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),dod(OVERRIDE:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping12_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(FALSE);
    SELF.Best_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d12_Norm := NORMALIZE(__in,LEFT.Dataset_Best_Person__Key_Watchdog_FCRA_nonEQ,TRANSFORM(RECORDOF(__in.Dataset_Best_Person__Key_Watchdog_FCRA_nonEQ),SELF:=RIGHT));
  EXPORT __d12_KELfiltered := __d12_Norm((UNSIGNED)did != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Best_Person__Key_Watchdog_FCRA_nonEQ_Invalid := __d12_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d12_Prefiltered := __d12_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d12 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d12_Prefiltered,InLayout,__Mapping12,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping12_Transform(LEFT)));
  SHARED __Mapping13 := 'appended_lexid(OVERRIDE:UID),title(DEFAULT:Title_),first_name(OVERRIDE:First_Name_),middle_name(OVERRIDE:Middle_Name_),last_name(OVERRIDE:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping13_Transform(InLayout __r) := TRANSFORM
    SELF.F_D_N_Indicator_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d13_Norm := NORMALIZE(__in,LEFT.Dataset_fraudpoint3__Key_DID,TRANSFORM(RECORDOF(__in.Dataset_fraudpoint3__Key_DID),SELF:=RIGHT));
  EXPORT __d13_KELfiltered := __d13_Norm((unsigned)appended_lexid !=0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_fraudpoint3__Key_DID_Invalid := __d13_KELfiltered((KEL.typ.uid)appended_lexid = 0);
  SHARED __d13_Prefiltered := __d13_KELfiltered((KEL.typ.uid)appended_lexid <> 0);
  SHARED __d13 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d13_Prefiltered,InLayout,__Mapping13,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping13_Transform(LEFT)));
  SHARED __Mapping14 := 'did(OVERRIDE:UID),title(DEFAULT:Title_),firstname(DEFAULT:First_Name_),middlename(DEFAULT:Middle_Name_),lastname(DEFAULT:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(OVERRIDE:Home_State_:\'\'),source_state(OVERRIDE:Source_State_:\'\'),isresident(OVERRIDE:Is_Resident_),ishunting(OVERRIDE:Is_Hunting_),isfishing(OVERRIDE:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datelicense(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping14_Transform(InLayout __r) := TRANSFORM
    SELF.Is_Hunt_Fish_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d14_Norm := NORMALIZE(__in,LEFT.Dataset_eMerges__Key_HuntFish_Rid,TRANSFORM(RECORDOF(__in.Dataset_eMerges__Key_HuntFish_Rid),SELF:=RIGHT));
  EXPORT __d14_KELfiltered := __d14_Norm((unsigned)did!=0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_eMerges__Key_HuntFish_Rid_Invalid := __d14_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d14_Prefiltered := __d14_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d14 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d14_Prefiltered,InLayout,__Mapping14,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping14_Transform(LEFT)));
  SHARED __Mapping15 := 'did(OVERRIDE:UID),title(DEFAULT:Title_),firstname(DEFAULT:First_Name_),middlename(DEFAULT:Middle_Name_),lastname(DEFAULT:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),ccwpermnum(OVERRIDE:Permit_Number_:\'\'),ccwpermtype(OVERRIDE:Weapon_Permits_Type_:\'\'),ccwregdate(OVERRIDE:Weapon_Registration_Date_:DATE),ccwexpdate(OVERRIDE:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping15_Transform(InLayout __r) := TRANSFORM
    SELF.Is_C_C_W_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d15_Norm := NORMALIZE(__in,LEFT.Dataset_eMerges__key_ccw_rid,TRANSFORM(RECORDOF(__in.Dataset_eMerges__key_ccw_rid),SELF:=RIGHT));
  EXPORT __d15_KELfiltered := __d15_Norm((unsigned)did!=0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_eMerges__key_ccw_rid_Invalid := __d15_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d15_Prefiltered := __d15_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d15 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d15_Prefiltered,InLayout,__Mapping15,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping15_Transform(LEFT)));
  SHARED Date_Last_Seen_16Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping16 := 'did(OVERRIDE:UID),title(DEFAULT:Title_),firstname(DEFAULT:First_Name_),middlename(DEFAULT:Middle_Name_),lastname(DEFAULT:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),dt_first_seen(OVERRIDE:Thrive_Date_First_Seen_:DATE|OVERRIDE:Date_First_Seen_:EPOCH),employer(OVERRIDE:Employer_:\'\'),pay_frequency(OVERRIDE:Pay_Frequency_:\'\'),income(OVERRIDE:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_16Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d16_Norm := NORMALIZE(__in,LEFT.Dataset_Thrive__Key___Did_QA,TRANSFORM(RECORDOF(__in.Dataset_Thrive__Key___Did_QA),SELF:=RIGHT));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Thrive__Key___Did_QA_Invalid := __d16_Norm((KEL.typ.uid)did = 0);
  SHARED __d16_Prefiltered := __d16_Norm((KEL.typ.uid)did <> 0);
  SHARED __d16 := __SourceFilter(KEL.FromFlat.Convert(__d16_Prefiltered,InLayout,__Mapping16,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping17 := 'did(OVERRIDE:UID),title(DEFAULT:Title_),firstname(DEFAULT:First_Name_),middlename(DEFAULT:Middle_Name_),lastname(DEFAULT:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_reported(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_reported(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d17_Norm := NORMALIZE(__in,LEFT.Dataset_SexOffender__Key_SexOffender_SPK,TRANSFORM(RECORDOF(__in.Dataset_SexOffender__Key_SexOffender_SPK),SELF:=RIGHT));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_SexOffender__Key_SexOffender_SPK_Invalid := __d17_Norm((KEL.typ.uid)did = 0);
  SHARED __d17_Prefiltered := __d17_Norm((KEL.typ.uid)did <> 0);
  SHARED __d17 := __SourceFilter(KEL.FromFlat.Convert(__d17_Prefiltered,InLayout,__Mapping17,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping18 := 'did(OVERRIDE:UID),title(DEFAULT:Title_),firstname(DEFAULT:First_Name_),middlename(DEFAULT:Middle_Name_),lastname(DEFAULT:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),ind1(OVERRIDE:Lex_I_D_Segment_:\'\'),ind2(OVERRIDE:Lex_I_D_Segment2_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d18_Norm := NORMALIZE(__in,LEFT.Dataset_Header__key_ADL_segmentation,TRANSFORM(RECORDOF(__in.Dataset_Header__key_ADL_segmentation),SELF:=RIGHT));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header__key_ADL_segmentation_Invalid := __d18_Norm((KEL.typ.uid)did = 0);
  SHARED __d18_Prefiltered := __d18_Norm((KEL.typ.uid)did <> 0);
  SHARED __d18 := __SourceFilter(KEL.FromFlat.Convert(__d18_Prefiltered,InLayout,__Mapping18,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6 + __d7 + __d8 + __d9 + __d10 + __d11 + __d12 + __d13 + __d14 + __d15 + __d16 + __d17 + __d18;
  EXPORT Full_Name_Layout := RECORD
    KEL.typ.nstr Title_;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Middle_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nstr Name_Suffix_;
    KEL.typ.nstr Name_Score_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool Best_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Reported_Dates_Of_Birth_Layout := RECORD
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Date_Of_Birth_Padded_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool Best_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Reported_Dates_Of_Death_Layout := RECORD
    KEL.typ.nkdate Date_Of_Death_;
    KEL.typ.nbool Death_Master_Flag_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool F_D_N_Indicator_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Dunn_Data_Layout := RECORD
    KEL.typ.nkdate Purch_Process_Date_;
    KEL.typ.nstr Purch_History_Flag_;
    KEL.typ.nint Purch_New_Amt_;
    KEL.typ.nint Purch_Total_;
    KEL.typ.nint Purch_Count_;
    KEL.typ.nint Purch_New_Age_Months_;
    KEL.typ.nint Purch_Old_Age_Months_;
    KEL.typ.nint Purch_Item_Count_;
    KEL.typ.nint Purch_Amt_Avg_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Conceal_Carry_Layout := RECORD
    KEL.typ.nbool Is_C_C_W_;
    KEL.typ.nstr Permit_Number_;
    KEL.typ.nstr Weapon_Permits_Type_;
    KEL.typ.nkdate Weapon_Registration_Date_;
    KEL.typ.nkdate Weapon_Expiration_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Hunt_Fish_Layout := RECORD
    KEL.typ.nbool Is_Hunt_Fish_;
    KEL.typ.nkdate License_Date_;
    KEL.typ.nstr Home_State_;
    KEL.typ.nstr Source_State_;
    KEL.typ.nbool Is_Resident_;
    KEL.typ.nbool Is_Hunting_;
    KEL.typ.nbool Is_Fishing_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Consumer_Statement_Flags_Layout := RECORD
    KEL.typ.nint Statement_I_D_;
    KEL.typ.nstr Statement_Type_;
    KEL.typ.nstr Data_Group_;
    KEL.typ.nstr Content_;
    KEL.typ.nbool Corrected_Flag_;
    KEL.typ.nbool Consumer_Statement_Flag_;
    KEL.typ.nbool Dispute_Flag_;
    KEL.typ.nbool Security_Freeze_;
    KEL.typ.nbool Security_Alert_;
    KEL.typ.nbool Negative_Alert_;
    KEL.typ.nbool I_D_Theft_Flag_;
    KEL.typ.nbool Legal_Hold_Alert_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Thrive_Layout := RECORD
    KEL.typ.nkdate Thrive_Date_First_Seen_;
    KEL.typ.nstr Employer_;
    KEL.typ.nstr Pay_Frequency_;
    KEL.typ.nint Income_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(Dunn_Data_Layout) Dunn_Data_;
    KEL.typ.ndataset(Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(Thrive_Layout) Thrive_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Person_Group := __PostFilter;
  Layout Person__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Gender_ := KEL.Intake.SingleValue(__recs,Gender_);
    SELF.Lex_I_D_Segment_ := KEL.Intake.SingleValue(__recs,Lex_I_D_Segment_);
    SELF.Lex_I_D_Segment2_ := KEL.Intake.SingleValue(__recs,Lex_I_D_Segment2_);
    SELF.Full_Name_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Title_,First_Name_,Middle_Name_,Last_Name_,Name_Suffix_,Name_Score_,Header_Hit_Flag_,Best_,Source_},Title_,First_Name_,Middle_Name_,Last_Name_,Name_Suffix_,Name_Score_,Header_Hit_Flag_,Best_,Source_),Full_Name_Layout)(__NN(Title_) OR __NN(First_Name_) OR __NN(Middle_Name_) OR __NN(Last_Name_) OR __NN(Name_Suffix_) OR __NN(Name_Score_) OR __NN(Header_Hit_Flag_) OR __NN(Best_) OR __NN(Source_)));
    SELF.Reported_Dates_Of_Birth_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Date_Of_Birth_,Date_Of_Birth_Padded_,Header_Hit_Flag_,Best_},Date_Of_Birth_,Date_Of_Birth_Padded_,Header_Hit_Flag_,Best_),Reported_Dates_Of_Birth_Layout)(__NN(Date_Of_Birth_) OR __NN(Date_Of_Birth_Padded_) OR __NN(Header_Hit_Flag_) OR __NN(Best_)));
    SELF.Reported_Dates_Of_Death_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Date_Of_Death_,Death_Master_Flag_},Date_Of_Death_,Death_Master_Flag_),Reported_Dates_Of_Death_Layout)(__NN(Date_Of_Death_) OR __NN(Death_Master_Flag_)));
    SELF.Race_ := KEL.Intake.SingleValue(__recs,Race_);
    SELF.Race_Description_ := KEL.Intake.SingleValue(__recs,Race_Description_);
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_,Header_Hit_Flag_,F_D_N_Indicator_},Source_,Header_Hit_Flag_,F_D_N_Indicator_),Data_Sources_Layout)(__NN(Source_) OR __NN(Header_Hit_Flag_) OR __NN(F_D_N_Indicator_)));
    SELF.Dunn_Data_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Purch_Process_Date_,Purch_History_Flag_,Purch_New_Amt_,Purch_Total_,Purch_Count_,Purch_New_Age_Months_,Purch_Old_Age_Months_,Purch_Item_Count_,Purch_Amt_Avg_},Purch_Process_Date_,Purch_History_Flag_,Purch_New_Amt_,Purch_Total_,Purch_Count_,Purch_New_Age_Months_,Purch_Old_Age_Months_,Purch_Item_Count_,Purch_Amt_Avg_),Dunn_Data_Layout)(__NN(Purch_Process_Date_) OR __NN(Purch_History_Flag_) OR __NN(Purch_New_Amt_) OR __NN(Purch_Total_) OR __NN(Purch_Count_) OR __NN(Purch_New_Age_Months_) OR __NN(Purch_Old_Age_Months_) OR __NN(Purch_Item_Count_) OR __NN(Purch_Amt_Avg_)));
    SELF.Conceal_Carry_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Is_C_C_W_,Permit_Number_,Weapon_Permits_Type_,Weapon_Registration_Date_,Weapon_Expiration_Date_},Is_C_C_W_,Permit_Number_,Weapon_Permits_Type_,Weapon_Registration_Date_,Weapon_Expiration_Date_),Conceal_Carry_Layout)(__NN(Is_C_C_W_) OR __NN(Permit_Number_) OR __NN(Weapon_Permits_Type_) OR __NN(Weapon_Registration_Date_) OR __NN(Weapon_Expiration_Date_)));
    SELF.Hunt_Fish_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Is_Hunt_Fish_,License_Date_,Home_State_,Source_State_,Is_Resident_,Is_Hunting_,Is_Fishing_},Is_Hunt_Fish_,License_Date_,Home_State_,Source_State_,Is_Resident_,Is_Hunting_,Is_Fishing_),Hunt_Fish_Layout)(__NN(Is_Hunt_Fish_) OR __NN(License_Date_) OR __NN(Home_State_) OR __NN(Source_State_) OR __NN(Is_Resident_) OR __NN(Is_Hunting_) OR __NN(Is_Fishing_)));
    SELF.Consumer_Statement_Flags_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Statement_I_D_,Statement_Type_,Data_Group_,Content_,Corrected_Flag_,Consumer_Statement_Flag_,Dispute_Flag_,Security_Freeze_,Security_Alert_,Negative_Alert_,I_D_Theft_Flag_,Legal_Hold_Alert_},Statement_I_D_,Statement_Type_,Data_Group_,Content_,Corrected_Flag_,Consumer_Statement_Flag_,Dispute_Flag_,Security_Freeze_,Security_Alert_,Negative_Alert_,I_D_Theft_Flag_,Legal_Hold_Alert_),Consumer_Statement_Flags_Layout)(__NN(Statement_I_D_) OR __NN(Statement_Type_) OR __NN(Data_Group_) OR __NN(Content_) OR __NN(Corrected_Flag_) OR __NN(Consumer_Statement_Flag_) OR __NN(Dispute_Flag_) OR __NN(Security_Freeze_) OR __NN(Security_Alert_) OR __NN(Negative_Alert_) OR __NN(I_D_Theft_Flag_) OR __NN(Legal_Hold_Alert_)));
    SELF.Thrive_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Thrive_Date_First_Seen_,Employer_,Pay_Frequency_,Income_,Source_},Thrive_Date_First_Seen_,Employer_,Pay_Frequency_,Income_,Source_),Thrive_Layout)(__NN(Thrive_Date_First_Seen_) OR __NN(Employer_) OR __NN(Pay_Frequency_) OR __NN(Income_) OR __NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Person__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Full_Name_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Full_Name_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Title_) OR __NN(First_Name_) OR __NN(Middle_Name_) OR __NN(Last_Name_) OR __NN(Name_Suffix_) OR __NN(Name_Score_) OR __NN(Header_Hit_Flag_) OR __NN(Best_) OR __NN(Source_)));
    SELF.Reported_Dates_Of_Birth_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Reported_Dates_Of_Birth_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Date_Of_Birth_) OR __NN(Date_Of_Birth_Padded_) OR __NN(Header_Hit_Flag_) OR __NN(Best_)));
    SELF.Reported_Dates_Of_Death_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Reported_Dates_Of_Death_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Date_Of_Death_) OR __NN(Death_Master_Flag_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_) OR __NN(Header_Hit_Flag_) OR __NN(F_D_N_Indicator_)));
    SELF.Dunn_Data_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Dunn_Data_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Purch_Process_Date_) OR __NN(Purch_History_Flag_) OR __NN(Purch_New_Amt_) OR __NN(Purch_Total_) OR __NN(Purch_Count_) OR __NN(Purch_New_Age_Months_) OR __NN(Purch_Old_Age_Months_) OR __NN(Purch_Item_Count_) OR __NN(Purch_Amt_Avg_)));
    SELF.Conceal_Carry_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Conceal_Carry_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Is_C_C_W_) OR __NN(Permit_Number_) OR __NN(Weapon_Permits_Type_) OR __NN(Weapon_Registration_Date_) OR __NN(Weapon_Expiration_Date_)));
    SELF.Hunt_Fish_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Hunt_Fish_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Is_Hunt_Fish_) OR __NN(License_Date_) OR __NN(Home_State_) OR __NN(Source_State_) OR __NN(Is_Resident_) OR __NN(Is_Hunting_) OR __NN(Is_Fishing_)));
    SELF.Consumer_Statement_Flags_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Consumer_Statement_Flags_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Statement_I_D_) OR __NN(Statement_Type_) OR __NN(Data_Group_) OR __NN(Content_) OR __NN(Corrected_Flag_) OR __NN(Consumer_Statement_Flag_) OR __NN(Dispute_Flag_) OR __NN(Security_Freeze_) OR __NN(Security_Alert_) OR __NN(Negative_Alert_) OR __NN(I_D_Theft_Flag_) OR __NN(Legal_Hold_Alert_)));
    SELF.Thrive_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Thrive_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Thrive_Date_First_Seen_) OR __NN(Employer_) OR __NN(Pay_Frequency_) OR __NN(Income_) OR __NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_Group,COUNT(ROWS(LEFT))=1),GROUP,Person__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_Group,COUNT(ROWS(LEFT))>1),GROUP,Person__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := TABLE(InData,{KEL.typ.uid UID := MIN(GROUP,__T(UID)),KEL.typ.int Cnt := COUNT(GROUP)},UID);
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Gender__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Gender_);
  EXPORT Lex_I_D_Segment__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Lex_I_D_Segment_);
  EXPORT Lex_I_D_Segment2__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Lex_I_D_Segment2_);
  EXPORT Race__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Race_);
  EXPORT Race_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Race_Description_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_ConsumerStatementFlags_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_1_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_2_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header__Key_Addr_Hist_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Death_MasterV2_SSA_DID_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_DID_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_Number_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PhonesPlus_v2__Key_Source_Level_Payload_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Best_Person__Key_Watchdog_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Best_Person__Key_Watchdog_FCRA_nonEN_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Best_Person__Key_Watchdog_FCRA_nonEQ_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_fraudpoint3__Key_DID_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_eMerges__Key_HuntFish_Rid_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_eMerges__key_ccw_rid_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Thrive__Key___Did_QA_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_SexOffender__Key_SexOffender_SPK_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header__key_ADL_segmentation_Invalid),COUNT(Gender__SingleValue_Invalid),COUNT(Lex_I_D_Segment__SingleValue_Invalid),COUNT(Lex_I_D_Segment2__SingleValue_Invalid),COUNT(Race__SingleValue_Invalid),COUNT(Race_Description__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_ConsumerStatementFlags_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_1_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_2_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header__Key_Addr_Hist_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Death_MasterV2_SSA_DID_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_DID_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_Number_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PhonesPlus_v2__Key_Source_Level_Payload_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Best_Person__Key_Watchdog_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Best_Person__Key_Watchdog_FCRA_nonEN_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Best_Person__Key_Watchdog_FCRA_nonEQ_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_fraudpoint3__Key_DID_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_eMerges__Key_HuntFish_Rid_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_eMerges__key_ccw_rid_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Thrive__Key___Did_QA_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_SexOffender__Key_SexOffender_SPK_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header__key_ADL_segmentation_Invalid,KEL.typ.int Gender__SingleValue_Invalid,KEL.typ.int Lex_I_D_Segment__SingleValue_Invalid,KEL.typ.int Lex_I_D_Segment2__SingleValue_Invalid,KEL.typ.int Race__SingleValue_Invalid,KEL.typ.int Race_Description__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid),COUNT(__d0)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','title',COUNT(__d0(__NL(Title_))),COUNT(__d0(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fname',COUNT(__d0(__NL(First_Name_))),COUNT(__d0(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mname',COUNT(__d0(__NL(Middle_Name_))),COUNT(__d0(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lname',COUNT(__d0(__NL(Last_Name_))),COUNT(__d0(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_suffix',COUNT(__d0(__NL(Name_Suffix_))),COUNT(__d0(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d0(__NL(Lex_I_D_Segment_))),COUNT(__d0(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment2',COUNT(__d0(__NL(Lex_I_D_Segment2_))),COUNT(__d0(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob',COUNT(__d0(__NL(Date_Of_Birth_))),COUNT(__d0(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d0(__NL(Date_Of_Birth_Padded_))),COUNT(__d0(__NN(Date_Of_Birth_Padded_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dod',COUNT(__d0(__NL(Date_Of_Death_))),COUNT(__d0(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d0(__NL(Gender_))),COUNT(__d0(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d0(__NL(Race_))),COUNT(__d0(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d0(__NL(Race_Description_))),COUNT(__d0(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Best',COUNT(__d0(__NL(Best_))),COUNT(__d0(__NN(Best_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FDNIndicator',COUNT(__d0(__NL(F_D_N_Indicator_))),COUNT(__d0(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeathMasterFlag',COUNT(__d0(__NL(Death_Master_Flag_))),COUNT(__d0(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchProcessDate',COUNT(__d0(__NL(Purch_Process_Date_))),COUNT(__d0(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchHistoryFlag',COUNT(__d0(__NL(Purch_History_Flag_))),COUNT(__d0(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAmt',COUNT(__d0(__NL(Purch_New_Amt_))),COUNT(__d0(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchTotal',COUNT(__d0(__NL(Purch_Total_))),COUNT(__d0(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchCount',COUNT(__d0(__NL(Purch_Count_))),COUNT(__d0(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAgeMonths',COUNT(__d0(__NL(Purch_New_Age_Months_))),COUNT(__d0(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchOldAgeMonths',COUNT(__d0(__NL(Purch_Old_Age_Months_))),COUNT(__d0(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchItemCount',COUNT(__d0(__NL(Purch_Item_Count_))),COUNT(__d0(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchAmtAvg',COUNT(__d0(__NL(Purch_Amt_Avg_))),COUNT(__d0(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHuntFish',COUNT(__d0(__NL(Is_Hunt_Fish_))),COUNT(__d0(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCCW',COUNT(__d0(__NL(Is_C_C_W_))),COUNT(__d0(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PermitNumber',COUNT(__d0(__NL(Permit_Number_))),COUNT(__d0(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponPermitsType',COUNT(__d0(__NL(Weapon_Permits_Type_))),COUNT(__d0(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponRegistrationDate',COUNT(__d0(__NL(Weapon_Registration_Date_))),COUNT(__d0(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponExpirationDate',COUNT(__d0(__NL(Weapon_Expiration_Date_))),COUNT(__d0(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseDate',COUNT(__d0(__NL(License_Date_))),COUNT(__d0(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HomeState',COUNT(__d0(__NL(Home_State_))),COUNT(__d0(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceState',COUNT(__d0(__NL(Source_State_))),COUNT(__d0(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsResident',COUNT(__d0(__NL(Is_Resident_))),COUNT(__d0(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHunting',COUNT(__d0(__NL(Is_Hunting_))),COUNT(__d0(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFishing',COUNT(__d0(__NL(Is_Fishing_))),COUNT(__d0(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementID',COUNT(__d0(__NL(Statement_I_D_))),COUNT(__d0(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementType',COUNT(__d0(__NL(Statement_Type_))),COUNT(__d0(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataGroup',COUNT(__d0(__NL(Data_Group_))),COUNT(__d0(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Content',COUNT(__d0(__NL(Content_))),COUNT(__d0(__NN(Content_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorrectedFlag',COUNT(__d0(__NL(Corrected_Flag_))),COUNT(__d0(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConsumerStatementFlag',COUNT(__d0(__NL(Consumer_Statement_Flag_))),COUNT(__d0(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DisputeFlag',COUNT(__d0(__NL(Dispute_Flag_))),COUNT(__d0(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityFreeze',COUNT(__d0(__NL(Security_Freeze_))),COUNT(__d0(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityAlert',COUNT(__d0(__NL(Security_Alert_))),COUNT(__d0(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NegativeAlert',COUNT(__d0(__NL(Negative_Alert_))),COUNT(__d0(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IDTheftFlag',COUNT(__d0(__NL(I_D_Theft_Flag_))),COUNT(__d0(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalHoldAlert',COUNT(__d0(__NL(Legal_Hold_Alert_))),COUNT(__d0(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThriveDateFirstSeen',COUNT(__d0(__NL(Thrive_Date_First_Seen_))),COUNT(__d0(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Employer',COUNT(__d0(__NL(Employer_))),COUNT(__d0(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PayFrequency',COUNT(__d0(__NL(Pay_Frequency_))),COUNT(__d0(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Income',COUNT(__d0(__NL(Income_))),COUNT(__d0(__NN(Income_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameScore',COUNT(__d0(__NL(Name_Score_))),COUNT(__d0(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid),COUNT(__d1)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','title',COUNT(__d1(__NL(Title_))),COUNT(__d1(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fname',COUNT(__d1(__NL(First_Name_))),COUNT(__d1(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mname',COUNT(__d1(__NL(Middle_Name_))),COUNT(__d1(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lname',COUNT(__d1(__NL(Last_Name_))),COUNT(__d1(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_suffix',COUNT(__d1(__NL(Name_Suffix_))),COUNT(__d1(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d1(__NL(Lex_I_D_Segment_))),COUNT(__d1(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment2',COUNT(__d1(__NL(Lex_I_D_Segment2_))),COUNT(__d1(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob',COUNT(__d1(__NL(Date_Of_Birth_))),COUNT(__d1(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d1(__NL(Date_Of_Birth_Padded_))),COUNT(__d1(__NN(Date_Of_Birth_Padded_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDeath',COUNT(__d1(__NL(Date_Of_Death_))),COUNT(__d1(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d1(__NL(Gender_))),COUNT(__d1(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d1(__NL(Race_))),COUNT(__d1(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d1(__NL(Race_Description_))),COUNT(__d1(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Best',COUNT(__d1(__NL(Best_))),COUNT(__d1(__NN(Best_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FDNIndicator',COUNT(__d1(__NL(F_D_N_Indicator_))),COUNT(__d1(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeathMasterFlag',COUNT(__d1(__NL(Death_Master_Flag_))),COUNT(__d1(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchProcessDate',COUNT(__d1(__NL(Purch_Process_Date_))),COUNT(__d1(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchHistoryFlag',COUNT(__d1(__NL(Purch_History_Flag_))),COUNT(__d1(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAmt',COUNT(__d1(__NL(Purch_New_Amt_))),COUNT(__d1(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchTotal',COUNT(__d1(__NL(Purch_Total_))),COUNT(__d1(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchCount',COUNT(__d1(__NL(Purch_Count_))),COUNT(__d1(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAgeMonths',COUNT(__d1(__NL(Purch_New_Age_Months_))),COUNT(__d1(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchOldAgeMonths',COUNT(__d1(__NL(Purch_Old_Age_Months_))),COUNT(__d1(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchItemCount',COUNT(__d1(__NL(Purch_Item_Count_))),COUNT(__d1(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchAmtAvg',COUNT(__d1(__NL(Purch_Amt_Avg_))),COUNT(__d1(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHuntFish',COUNT(__d1(__NL(Is_Hunt_Fish_))),COUNT(__d1(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCCW',COUNT(__d1(__NL(Is_C_C_W_))),COUNT(__d1(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PermitNumber',COUNT(__d1(__NL(Permit_Number_))),COUNT(__d1(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponPermitsType',COUNT(__d1(__NL(Weapon_Permits_Type_))),COUNT(__d1(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponRegistrationDate',COUNT(__d1(__NL(Weapon_Registration_Date_))),COUNT(__d1(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponExpirationDate',COUNT(__d1(__NL(Weapon_Expiration_Date_))),COUNT(__d1(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseDate',COUNT(__d1(__NL(License_Date_))),COUNT(__d1(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HomeState',COUNT(__d1(__NL(Home_State_))),COUNT(__d1(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceState',COUNT(__d1(__NL(Source_State_))),COUNT(__d1(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsResident',COUNT(__d1(__NL(Is_Resident_))),COUNT(__d1(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHunting',COUNT(__d1(__NL(Is_Hunting_))),COUNT(__d1(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFishing',COUNT(__d1(__NL(Is_Fishing_))),COUNT(__d1(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementID',COUNT(__d1(__NL(Statement_I_D_))),COUNT(__d1(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementType',COUNT(__d1(__NL(Statement_Type_))),COUNT(__d1(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataGroup',COUNT(__d1(__NL(Data_Group_))),COUNT(__d1(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Content',COUNT(__d1(__NL(Content_))),COUNT(__d1(__NN(Content_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorrectedFlag',COUNT(__d1(__NL(Corrected_Flag_))),COUNT(__d1(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConsumerStatementFlag',COUNT(__d1(__NL(Consumer_Statement_Flag_))),COUNT(__d1(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DisputeFlag',COUNT(__d1(__NL(Dispute_Flag_))),COUNT(__d1(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityFreeze',COUNT(__d1(__NL(Security_Freeze_))),COUNT(__d1(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityAlert',COUNT(__d1(__NL(Security_Alert_))),COUNT(__d1(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NegativeAlert',COUNT(__d1(__NL(Negative_Alert_))),COUNT(__d1(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IDTheftFlag',COUNT(__d1(__NL(I_D_Theft_Flag_))),COUNT(__d1(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalHoldAlert',COUNT(__d1(__NL(Legal_Hold_Alert_))),COUNT(__d1(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThriveDateFirstSeen',COUNT(__d1(__NL(Thrive_Date_First_Seen_))),COUNT(__d1(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Employer',COUNT(__d1(__NL(Employer_))),COUNT(__d1(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PayFrequency',COUNT(__d1(__NL(Pay_Frequency_))),COUNT(__d1(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Income',COUNT(__d1(__NL(Income_))),COUNT(__d1(__NN(Income_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameScore',COUNT(__d1(__NL(Name_Score_))),COUNT(__d1(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_ConsumerStatementFlags_Invalid),COUNT(__d2)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Title',COUNT(__d2(__NL(Title_))),COUNT(__d2(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FirstName',COUNT(__d2(__NL(First_Name_))),COUNT(__d2(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MiddleName',COUNT(__d2(__NL(Middle_Name_))),COUNT(__d2(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LastName',COUNT(__d2(__NL(Last_Name_))),COUNT(__d2(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameSuffix',COUNT(__d2(__NL(Name_Suffix_))),COUNT(__d2(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d2(__NL(Lex_I_D_Segment_))),COUNT(__d2(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment2',COUNT(__d2(__NL(Lex_I_D_Segment2_))),COUNT(__d2(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirth',COUNT(__d2(__NL(Date_Of_Birth_))),COUNT(__d2(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d2(__NL(Date_Of_Birth_Padded_))),COUNT(__d2(__NN(Date_Of_Birth_Padded_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDeath',COUNT(__d2(__NL(Date_Of_Death_))),COUNT(__d2(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d2(__NL(Gender_))),COUNT(__d2(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d2(__NL(Race_))),COUNT(__d2(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d2(__NL(Race_Description_))),COUNT(__d2(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d2(__NL(Header_Hit_Flag_))),COUNT(__d2(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Best',COUNT(__d2(__NL(Best_))),COUNT(__d2(__NN(Best_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FDNIndicator',COUNT(__d2(__NL(F_D_N_Indicator_))),COUNT(__d2(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeathMasterFlag',COUNT(__d2(__NL(Death_Master_Flag_))),COUNT(__d2(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchProcessDate',COUNT(__d2(__NL(Purch_Process_Date_))),COUNT(__d2(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchHistoryFlag',COUNT(__d2(__NL(Purch_History_Flag_))),COUNT(__d2(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAmt',COUNT(__d2(__NL(Purch_New_Amt_))),COUNT(__d2(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchTotal',COUNT(__d2(__NL(Purch_Total_))),COUNT(__d2(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchCount',COUNT(__d2(__NL(Purch_Count_))),COUNT(__d2(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAgeMonths',COUNT(__d2(__NL(Purch_New_Age_Months_))),COUNT(__d2(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchOldAgeMonths',COUNT(__d2(__NL(Purch_Old_Age_Months_))),COUNT(__d2(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchItemCount',COUNT(__d2(__NL(Purch_Item_Count_))),COUNT(__d2(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchAmtAvg',COUNT(__d2(__NL(Purch_Amt_Avg_))),COUNT(__d2(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHuntFish',COUNT(__d2(__NL(Is_Hunt_Fish_))),COUNT(__d2(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCCW',COUNT(__d2(__NL(Is_C_C_W_))),COUNT(__d2(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PermitNumber',COUNT(__d2(__NL(Permit_Number_))),COUNT(__d2(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponPermitsType',COUNT(__d2(__NL(Weapon_Permits_Type_))),COUNT(__d2(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponRegistrationDate',COUNT(__d2(__NL(Weapon_Registration_Date_))),COUNT(__d2(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponExpirationDate',COUNT(__d2(__NL(Weapon_Expiration_Date_))),COUNT(__d2(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseDate',COUNT(__d2(__NL(License_Date_))),COUNT(__d2(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HomeState',COUNT(__d2(__NL(Home_State_))),COUNT(__d2(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceState',COUNT(__d2(__NL(Source_State_))),COUNT(__d2(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsResident',COUNT(__d2(__NL(Is_Resident_))),COUNT(__d2(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHunting',COUNT(__d2(__NL(Is_Hunting_))),COUNT(__d2(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFishing',COUNT(__d2(__NL(Is_Fishing_))),COUNT(__d2(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementId',COUNT(__d2(__NL(Statement_I_D_))),COUNT(__d2(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementType',COUNT(__d2(__NL(Statement_Type_))),COUNT(__d2(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataGroup',COUNT(__d2(__NL(Data_Group_))),COUNT(__d2(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Content',COUNT(__d2(__NL(Content_))),COUNT(__d2(__NN(Content_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Corrected_Flag',COUNT(__d2(__NL(Corrected_Flag_))),COUNT(__d2(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Consumer_Statement_Flag',COUNT(__d2(__NL(Consumer_Statement_Flag_))),COUNT(__d2(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Dispute_Flag',COUNT(__d2(__NL(Dispute_Flag_))),COUNT(__d2(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Security_Freeze',COUNT(__d2(__NL(Security_Freeze_))),COUNT(__d2(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Security_Alert',COUNT(__d2(__NL(Security_Alert_))),COUNT(__d2(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NegativeAlert',COUNT(__d2(__NL(Negative_Alert_))),COUNT(__d2(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ID_Theft_Flag',COUNT(__d2(__NL(I_D_Theft_Flag_))),COUNT(__d2(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal_Hold_Alert',COUNT(__d2(__NL(Legal_Hold_Alert_))),COUNT(__d2(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThriveDateFirstSeen',COUNT(__d2(__NL(Thrive_Date_First_Seen_))),COUNT(__d2(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Employer',COUNT(__d2(__NL(Employer_))),COUNT(__d2(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PayFrequency',COUNT(__d2(__NL(Pay_Frequency_))),COUNT(__d2(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Income',COUNT(__d2(__NL(Income_))),COUNT(__d2(__NN(Income_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameScore',COUNT(__d2(__NL(Name_Score_))),COUNT(__d2(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_1_Invalid),COUNT(__d3)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Title',COUNT(__d3(__NL(Title_))),COUNT(__d3(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fname',COUNT(__d3(__NL(First_Name_))),COUNT(__d3(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mname',COUNT(__d3(__NL(Middle_Name_))),COUNT(__d3(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lname',COUNT(__d3(__NL(Last_Name_))),COUNT(__d3(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_suffix',COUNT(__d3(__NL(Name_Suffix_))),COUNT(__d3(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d3(__NL(Lex_I_D_Segment_))),COUNT(__d3(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment2',COUNT(__d3(__NL(Lex_I_D_Segment2_))),COUNT(__d3(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob',COUNT(__d3(__NL(Date_Of_Birth_))),COUNT(__d3(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d3(__NL(Date_Of_Birth_Padded_))),COUNT(__d3(__NN(Date_Of_Birth_Padded_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDeath',COUNT(__d3(__NL(Date_Of_Death_))),COUNT(__d3(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d3(__NL(Gender_))),COUNT(__d3(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','race',COUNT(__d3(__NL(Race_))),COUNT(__d3(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','race_desc',COUNT(__d3(__NL(Race_Description_))),COUNT(__d3(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d3(__NL(Header_Hit_Flag_))),COUNT(__d3(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Best',COUNT(__d3(__NL(Best_))),COUNT(__d3(__NN(Best_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FDNIndicator',COUNT(__d3(__NL(F_D_N_Indicator_))),COUNT(__d3(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeathMasterFlag',COUNT(__d3(__NL(Death_Master_Flag_))),COUNT(__d3(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchProcessDate',COUNT(__d3(__NL(Purch_Process_Date_))),COUNT(__d3(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchHistoryFlag',COUNT(__d3(__NL(Purch_History_Flag_))),COUNT(__d3(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAmt',COUNT(__d3(__NL(Purch_New_Amt_))),COUNT(__d3(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchTotal',COUNT(__d3(__NL(Purch_Total_))),COUNT(__d3(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchCount',COUNT(__d3(__NL(Purch_Count_))),COUNT(__d3(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAgeMonths',COUNT(__d3(__NL(Purch_New_Age_Months_))),COUNT(__d3(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchOldAgeMonths',COUNT(__d3(__NL(Purch_Old_Age_Months_))),COUNT(__d3(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchItemCount',COUNT(__d3(__NL(Purch_Item_Count_))),COUNT(__d3(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchAmtAvg',COUNT(__d3(__NL(Purch_Amt_Avg_))),COUNT(__d3(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHuntFish',COUNT(__d3(__NL(Is_Hunt_Fish_))),COUNT(__d3(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCCW',COUNT(__d3(__NL(Is_C_C_W_))),COUNT(__d3(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PermitNumber',COUNT(__d3(__NL(Permit_Number_))),COUNT(__d3(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponPermitsType',COUNT(__d3(__NL(Weapon_Permits_Type_))),COUNT(__d3(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponRegistrationDate',COUNT(__d3(__NL(Weapon_Registration_Date_))),COUNT(__d3(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponExpirationDate',COUNT(__d3(__NL(Weapon_Expiration_Date_))),COUNT(__d3(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseDate',COUNT(__d3(__NL(License_Date_))),COUNT(__d3(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HomeState',COUNT(__d3(__NL(Home_State_))),COUNT(__d3(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceState',COUNT(__d3(__NL(Source_State_))),COUNT(__d3(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsResident',COUNT(__d3(__NL(Is_Resident_))),COUNT(__d3(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHunting',COUNT(__d3(__NL(Is_Hunting_))),COUNT(__d3(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFishing',COUNT(__d3(__NL(Is_Fishing_))),COUNT(__d3(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementID',COUNT(__d3(__NL(Statement_I_D_))),COUNT(__d3(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementType',COUNT(__d3(__NL(Statement_Type_))),COUNT(__d3(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataGroup',COUNT(__d3(__NL(Data_Group_))),COUNT(__d3(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Content',COUNT(__d3(__NL(Content_))),COUNT(__d3(__NN(Content_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorrectedFlag',COUNT(__d3(__NL(Corrected_Flag_))),COUNT(__d3(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConsumerStatementFlag',COUNT(__d3(__NL(Consumer_Statement_Flag_))),COUNT(__d3(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DisputeFlag',COUNT(__d3(__NL(Dispute_Flag_))),COUNT(__d3(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityFreeze',COUNT(__d3(__NL(Security_Freeze_))),COUNT(__d3(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityAlert',COUNT(__d3(__NL(Security_Alert_))),COUNT(__d3(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NegativeAlert',COUNT(__d3(__NL(Negative_Alert_))),COUNT(__d3(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IDTheftFlag',COUNT(__d3(__NL(I_D_Theft_Flag_))),COUNT(__d3(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalHoldAlert',COUNT(__d3(__NL(Legal_Hold_Alert_))),COUNT(__d3(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThriveDateFirstSeen',COUNT(__d3(__NL(Thrive_Date_First_Seen_))),COUNT(__d3(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Employer',COUNT(__d3(__NL(Employer_))),COUNT(__d3(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PayFrequency',COUNT(__d3(__NL(Pay_Frequency_))),COUNT(__d3(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Income',COUNT(__d3(__NL(Income_))),COUNT(__d3(__NN(Income_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameScore',COUNT(__d3(__NL(Name_Score_))),COUNT(__d3(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d3(Hybrid_Archive_Date_=0)),COUNT(__d3(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d3(Vault_Date_Last_Seen_=0)),COUNT(__d3(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_2_Invalid),COUNT(__d4)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Title',COUNT(__d4(__NL(Title_))),COUNT(__d4(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FirstName',COUNT(__d4(__NL(First_Name_))),COUNT(__d4(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MiddleName',COUNT(__d4(__NL(Middle_Name_))),COUNT(__d4(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LastName',COUNT(__d4(__NL(Last_Name_))),COUNT(__d4(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameSuffix',COUNT(__d4(__NL(Name_Suffix_))),COUNT(__d4(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d4(__NL(Lex_I_D_Segment_))),COUNT(__d4(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment2',COUNT(__d4(__NL(Lex_I_D_Segment2_))),COUNT(__d4(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob_alias',COUNT(__d4(__NL(Date_Of_Birth_))),COUNT(__d4(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d4(__NL(Date_Of_Birth_Padded_))),COUNT(__d4(__NN(Date_Of_Birth_Padded_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDeath',COUNT(__d4(__NL(Date_Of_Death_))),COUNT(__d4(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d4(__NL(Gender_))),COUNT(__d4(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d4(__NL(Race_))),COUNT(__d4(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d4(__NL(Race_Description_))),COUNT(__d4(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d4(__NL(Header_Hit_Flag_))),COUNT(__d4(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Best',COUNT(__d4(__NL(Best_))),COUNT(__d4(__NN(Best_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FDNIndicator',COUNT(__d4(__NL(F_D_N_Indicator_))),COUNT(__d4(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeathMasterFlag',COUNT(__d4(__NL(Death_Master_Flag_))),COUNT(__d4(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchProcessDate',COUNT(__d4(__NL(Purch_Process_Date_))),COUNT(__d4(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchHistoryFlag',COUNT(__d4(__NL(Purch_History_Flag_))),COUNT(__d4(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAmt',COUNT(__d4(__NL(Purch_New_Amt_))),COUNT(__d4(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchTotal',COUNT(__d4(__NL(Purch_Total_))),COUNT(__d4(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchCount',COUNT(__d4(__NL(Purch_Count_))),COUNT(__d4(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAgeMonths',COUNT(__d4(__NL(Purch_New_Age_Months_))),COUNT(__d4(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchOldAgeMonths',COUNT(__d4(__NL(Purch_Old_Age_Months_))),COUNT(__d4(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchItemCount',COUNT(__d4(__NL(Purch_Item_Count_))),COUNT(__d4(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchAmtAvg',COUNT(__d4(__NL(Purch_Amt_Avg_))),COUNT(__d4(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHuntFish',COUNT(__d4(__NL(Is_Hunt_Fish_))),COUNT(__d4(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCCW',COUNT(__d4(__NL(Is_C_C_W_))),COUNT(__d4(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PermitNumber',COUNT(__d4(__NL(Permit_Number_))),COUNT(__d4(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponPermitsType',COUNT(__d4(__NL(Weapon_Permits_Type_))),COUNT(__d4(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponRegistrationDate',COUNT(__d4(__NL(Weapon_Registration_Date_))),COUNT(__d4(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponExpirationDate',COUNT(__d4(__NL(Weapon_Expiration_Date_))),COUNT(__d4(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseDate',COUNT(__d4(__NL(License_Date_))),COUNT(__d4(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HomeState',COUNT(__d4(__NL(Home_State_))),COUNT(__d4(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceState',COUNT(__d4(__NL(Source_State_))),COUNT(__d4(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsResident',COUNT(__d4(__NL(Is_Resident_))),COUNT(__d4(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHunting',COUNT(__d4(__NL(Is_Hunting_))),COUNT(__d4(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFishing',COUNT(__d4(__NL(Is_Fishing_))),COUNT(__d4(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementID',COUNT(__d4(__NL(Statement_I_D_))),COUNT(__d4(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementType',COUNT(__d4(__NL(Statement_Type_))),COUNT(__d4(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataGroup',COUNT(__d4(__NL(Data_Group_))),COUNT(__d4(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Content',COUNT(__d4(__NL(Content_))),COUNT(__d4(__NN(Content_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorrectedFlag',COUNT(__d4(__NL(Corrected_Flag_))),COUNT(__d4(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConsumerStatementFlag',COUNT(__d4(__NL(Consumer_Statement_Flag_))),COUNT(__d4(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DisputeFlag',COUNT(__d4(__NL(Dispute_Flag_))),COUNT(__d4(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityFreeze',COUNT(__d4(__NL(Security_Freeze_))),COUNT(__d4(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityAlert',COUNT(__d4(__NL(Security_Alert_))),COUNT(__d4(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NegativeAlert',COUNT(__d4(__NL(Negative_Alert_))),COUNT(__d4(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IDTheftFlag',COUNT(__d4(__NL(I_D_Theft_Flag_))),COUNT(__d4(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalHoldAlert',COUNT(__d4(__NL(Legal_Hold_Alert_))),COUNT(__d4(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThriveDateFirstSeen',COUNT(__d4(__NL(Thrive_Date_First_Seen_))),COUNT(__d4(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Employer',COUNT(__d4(__NL(Employer_))),COUNT(__d4(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PayFrequency',COUNT(__d4(__NL(Pay_Frequency_))),COUNT(__d4(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Income',COUNT(__d4(__NL(Income_))),COUNT(__d4(__NN(Income_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameScore',COUNT(__d4(__NL(Name_Score_))),COUNT(__d4(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d4(Archive___Date_=0)),COUNT(__d4(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d4(Hybrid_Archive_Date_=0)),COUNT(__d4(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d4(Vault_Date_Last_Seen_=0)),COUNT(__d4(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header__Key_Addr_Hist_Invalid),COUNT(__d5)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Title',COUNT(__d5(__NL(Title_))),COUNT(__d5(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FirstName',COUNT(__d5(__NL(First_Name_))),COUNT(__d5(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MiddleName',COUNT(__d5(__NL(Middle_Name_))),COUNT(__d5(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LastName',COUNT(__d5(__NL(Last_Name_))),COUNT(__d5(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameSuffix',COUNT(__d5(__NL(Name_Suffix_))),COUNT(__d5(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d5(__NL(Lex_I_D_Segment_))),COUNT(__d5(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment2',COUNT(__d5(__NL(Lex_I_D_Segment2_))),COUNT(__d5(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirth',COUNT(__d5(__NL(Date_Of_Birth_))),COUNT(__d5(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d5(__NL(Date_Of_Birth_Padded_))),COUNT(__d5(__NN(Date_Of_Birth_Padded_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDeath',COUNT(__d5(__NL(Date_Of_Death_))),COUNT(__d5(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d5(__NL(Gender_))),COUNT(__d5(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d5(__NL(Race_))),COUNT(__d5(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d5(__NL(Race_Description_))),COUNT(__d5(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d5(__NL(Header_Hit_Flag_))),COUNT(__d5(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Best',COUNT(__d5(__NL(Best_))),COUNT(__d5(__NN(Best_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FDNIndicator',COUNT(__d5(__NL(F_D_N_Indicator_))),COUNT(__d5(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeathMasterFlag',COUNT(__d5(__NL(Death_Master_Flag_))),COUNT(__d5(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchProcessDate',COUNT(__d5(__NL(Purch_Process_Date_))),COUNT(__d5(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchHistoryFlag',COUNT(__d5(__NL(Purch_History_Flag_))),COUNT(__d5(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAmt',COUNT(__d5(__NL(Purch_New_Amt_))),COUNT(__d5(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchTotal',COUNT(__d5(__NL(Purch_Total_))),COUNT(__d5(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchCount',COUNT(__d5(__NL(Purch_Count_))),COUNT(__d5(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAgeMonths',COUNT(__d5(__NL(Purch_New_Age_Months_))),COUNT(__d5(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchOldAgeMonths',COUNT(__d5(__NL(Purch_Old_Age_Months_))),COUNT(__d5(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchItemCount',COUNT(__d5(__NL(Purch_Item_Count_))),COUNT(__d5(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchAmtAvg',COUNT(__d5(__NL(Purch_Amt_Avg_))),COUNT(__d5(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHuntFish',COUNT(__d5(__NL(Is_Hunt_Fish_))),COUNT(__d5(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCCW',COUNT(__d5(__NL(Is_C_C_W_))),COUNT(__d5(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PermitNumber',COUNT(__d5(__NL(Permit_Number_))),COUNT(__d5(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponPermitsType',COUNT(__d5(__NL(Weapon_Permits_Type_))),COUNT(__d5(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponRegistrationDate',COUNT(__d5(__NL(Weapon_Registration_Date_))),COUNT(__d5(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponExpirationDate',COUNT(__d5(__NL(Weapon_Expiration_Date_))),COUNT(__d5(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseDate',COUNT(__d5(__NL(License_Date_))),COUNT(__d5(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HomeState',COUNT(__d5(__NL(Home_State_))),COUNT(__d5(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceState',COUNT(__d5(__NL(Source_State_))),COUNT(__d5(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsResident',COUNT(__d5(__NL(Is_Resident_))),COUNT(__d5(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHunting',COUNT(__d5(__NL(Is_Hunting_))),COUNT(__d5(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFishing',COUNT(__d5(__NL(Is_Fishing_))),COUNT(__d5(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementID',COUNT(__d5(__NL(Statement_I_D_))),COUNT(__d5(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementType',COUNT(__d5(__NL(Statement_Type_))),COUNT(__d5(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataGroup',COUNT(__d5(__NL(Data_Group_))),COUNT(__d5(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Content',COUNT(__d5(__NL(Content_))),COUNT(__d5(__NN(Content_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorrectedFlag',COUNT(__d5(__NL(Corrected_Flag_))),COUNT(__d5(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConsumerStatementFlag',COUNT(__d5(__NL(Consumer_Statement_Flag_))),COUNT(__d5(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DisputeFlag',COUNT(__d5(__NL(Dispute_Flag_))),COUNT(__d5(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityFreeze',COUNT(__d5(__NL(Security_Freeze_))),COUNT(__d5(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityAlert',COUNT(__d5(__NL(Security_Alert_))),COUNT(__d5(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NegativeAlert',COUNT(__d5(__NL(Negative_Alert_))),COUNT(__d5(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IDTheftFlag',COUNT(__d5(__NL(I_D_Theft_Flag_))),COUNT(__d5(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalHoldAlert',COUNT(__d5(__NL(Legal_Hold_Alert_))),COUNT(__d5(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThriveDateFirstSeen',COUNT(__d5(__NL(Thrive_Date_First_Seen_))),COUNT(__d5(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Employer',COUNT(__d5(__NL(Employer_))),COUNT(__d5(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PayFrequency',COUNT(__d5(__NL(Pay_Frequency_))),COUNT(__d5(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Income',COUNT(__d5(__NL(Income_))),COUNT(__d5(__NN(Income_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameScore',COUNT(__d5(__NL(Name_Score_))),COUNT(__d5(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d5(Archive___Date_=0)),COUNT(__d5(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d5(Hybrid_Archive_Date_=0)),COUNT(__d5(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d5(Vault_Date_Last_Seen_=0)),COUNT(__d5(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Death_MasterV2_SSA_DID_Invalid),COUNT(__d6)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Title',COUNT(__d6(__NL(Title_))),COUNT(__d6(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fname',COUNT(__d6(__NL(First_Name_))),COUNT(__d6(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mname',COUNT(__d6(__NL(Middle_Name_))),COUNT(__d6(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lname',COUNT(__d6(__NL(Last_Name_))),COUNT(__d6(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_suffix',COUNT(__d6(__NL(Name_Suffix_))),COUNT(__d6(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d6(__NL(Lex_I_D_Segment_))),COUNT(__d6(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment2',COUNT(__d6(__NL(Lex_I_D_Segment2_))),COUNT(__d6(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob8',COUNT(__d6(__NL(Date_Of_Birth_))),COUNT(__d6(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d6(__NL(Date_Of_Birth_Padded_))),COUNT(__d6(__NN(Date_Of_Birth_Padded_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dod8',COUNT(__d6(__NL(Date_Of_Death_))),COUNT(__d6(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d6(__NL(Gender_))),COUNT(__d6(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d6(__NL(Race_))),COUNT(__d6(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d6(__NL(Race_Description_))),COUNT(__d6(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d6(__NL(Header_Hit_Flag_))),COUNT(__d6(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Best',COUNT(__d6(__NL(Best_))),COUNT(__d6(__NN(Best_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FDNIndicator',COUNT(__d6(__NL(F_D_N_Indicator_))),COUNT(__d6(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d6(__NL(Source_))),COUNT(__d6(__NN(Source_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchProcessDate',COUNT(__d6(__NL(Purch_Process_Date_))),COUNT(__d6(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchHistoryFlag',COUNT(__d6(__NL(Purch_History_Flag_))),COUNT(__d6(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAmt',COUNT(__d6(__NL(Purch_New_Amt_))),COUNT(__d6(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchTotal',COUNT(__d6(__NL(Purch_Total_))),COUNT(__d6(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchCount',COUNT(__d6(__NL(Purch_Count_))),COUNT(__d6(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAgeMonths',COUNT(__d6(__NL(Purch_New_Age_Months_))),COUNT(__d6(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchOldAgeMonths',COUNT(__d6(__NL(Purch_Old_Age_Months_))),COUNT(__d6(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchItemCount',COUNT(__d6(__NL(Purch_Item_Count_))),COUNT(__d6(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchAmtAvg',COUNT(__d6(__NL(Purch_Amt_Avg_))),COUNT(__d6(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHuntFish',COUNT(__d6(__NL(Is_Hunt_Fish_))),COUNT(__d6(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCCW',COUNT(__d6(__NL(Is_C_C_W_))),COUNT(__d6(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PermitNumber',COUNT(__d6(__NL(Permit_Number_))),COUNT(__d6(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponPermitsType',COUNT(__d6(__NL(Weapon_Permits_Type_))),COUNT(__d6(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponRegistrationDate',COUNT(__d6(__NL(Weapon_Registration_Date_))),COUNT(__d6(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponExpirationDate',COUNT(__d6(__NL(Weapon_Expiration_Date_))),COUNT(__d6(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseDate',COUNT(__d6(__NL(License_Date_))),COUNT(__d6(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HomeState',COUNT(__d6(__NL(Home_State_))),COUNT(__d6(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceState',COUNT(__d6(__NL(Source_State_))),COUNT(__d6(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsResident',COUNT(__d6(__NL(Is_Resident_))),COUNT(__d6(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHunting',COUNT(__d6(__NL(Is_Hunting_))),COUNT(__d6(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFishing',COUNT(__d6(__NL(Is_Fishing_))),COUNT(__d6(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementID',COUNT(__d6(__NL(Statement_I_D_))),COUNT(__d6(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementType',COUNT(__d6(__NL(Statement_Type_))),COUNT(__d6(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataGroup',COUNT(__d6(__NL(Data_Group_))),COUNT(__d6(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Content',COUNT(__d6(__NL(Content_))),COUNT(__d6(__NN(Content_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorrectedFlag',COUNT(__d6(__NL(Corrected_Flag_))),COUNT(__d6(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConsumerStatementFlag',COUNT(__d6(__NL(Consumer_Statement_Flag_))),COUNT(__d6(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DisputeFlag',COUNT(__d6(__NL(Dispute_Flag_))),COUNT(__d6(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityFreeze',COUNT(__d6(__NL(Security_Freeze_))),COUNT(__d6(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityAlert',COUNT(__d6(__NL(Security_Alert_))),COUNT(__d6(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NegativeAlert',COUNT(__d6(__NL(Negative_Alert_))),COUNT(__d6(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IDTheftFlag',COUNT(__d6(__NL(I_D_Theft_Flag_))),COUNT(__d6(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalHoldAlert',COUNT(__d6(__NL(Legal_Hold_Alert_))),COUNT(__d6(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThriveDateFirstSeen',COUNT(__d6(__NL(Thrive_Date_First_Seen_))),COUNT(__d6(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Employer',COUNT(__d6(__NL(Employer_))),COUNT(__d6(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PayFrequency',COUNT(__d6(__NL(Pay_Frequency_))),COUNT(__d6(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Income',COUNT(__d6(__NL(Income_))),COUNT(__d6(__NN(Income_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameScore',COUNT(__d6(__NL(Name_Score_))),COUNT(__d6(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d6(Archive___Date_=0)),COUNT(__d6(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d6(Hybrid_Archive_Date_=0)),COUNT(__d6(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d6(Vault_Date_Last_Seen_=0)),COUNT(__d6(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_DID_Invalid),COUNT(__d7)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','title',COUNT(__d7(__NL(Title_))),COUNT(__d7(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fname',COUNT(__d7(__NL(First_Name_))),COUNT(__d7(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mname',COUNT(__d7(__NL(Middle_Name_))),COUNT(__d7(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lname',COUNT(__d7(__NL(Last_Name_))),COUNT(__d7(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_suffix',COUNT(__d7(__NL(Name_Suffix_))),COUNT(__d7(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d7(__NL(Lex_I_D_Segment_))),COUNT(__d7(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment2',COUNT(__d7(__NL(Lex_I_D_Segment2_))),COUNT(__d7(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob',COUNT(__d7(__NL(Date_Of_Birth_))),COUNT(__d7(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d7(__NL(Date_Of_Birth_Padded_))),COUNT(__d7(__NN(Date_Of_Birth_Padded_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dod',COUNT(__d7(__NL(Date_Of_Death_))),COUNT(__d7(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d7(__NL(Gender_))),COUNT(__d7(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','race',COUNT(__d7(__NL(Race_))),COUNT(__d7(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','race_name',COUNT(__d7(__NL(Race_Description_))),COUNT(__d7(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d7(__NL(Header_Hit_Flag_))),COUNT(__d7(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Best',COUNT(__d7(__NL(Best_))),COUNT(__d7(__NN(Best_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FDNIndicator',COUNT(__d7(__NL(F_D_N_Indicator_))),COUNT(__d7(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeathMasterFlag',COUNT(__d7(__NL(Death_Master_Flag_))),COUNT(__d7(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source_code',COUNT(__d7(__NL(Source_))),COUNT(__d7(__NN(Source_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchProcessDate',COUNT(__d7(__NL(Purch_Process_Date_))),COUNT(__d7(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchHistoryFlag',COUNT(__d7(__NL(Purch_History_Flag_))),COUNT(__d7(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAmt',COUNT(__d7(__NL(Purch_New_Amt_))),COUNT(__d7(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchTotal',COUNT(__d7(__NL(Purch_Total_))),COUNT(__d7(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchCount',COUNT(__d7(__NL(Purch_Count_))),COUNT(__d7(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAgeMonths',COUNT(__d7(__NL(Purch_New_Age_Months_))),COUNT(__d7(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchOldAgeMonths',COUNT(__d7(__NL(Purch_Old_Age_Months_))),COUNT(__d7(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchItemCount',COUNT(__d7(__NL(Purch_Item_Count_))),COUNT(__d7(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchAmtAvg',COUNT(__d7(__NL(Purch_Amt_Avg_))),COUNT(__d7(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHuntFish',COUNT(__d7(__NL(Is_Hunt_Fish_))),COUNT(__d7(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCCW',COUNT(__d7(__NL(Is_C_C_W_))),COUNT(__d7(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PermitNumber',COUNT(__d7(__NL(Permit_Number_))),COUNT(__d7(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponPermitsType',COUNT(__d7(__NL(Weapon_Permits_Type_))),COUNT(__d7(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponRegistrationDate',COUNT(__d7(__NL(Weapon_Registration_Date_))),COUNT(__d7(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponExpirationDate',COUNT(__d7(__NL(Weapon_Expiration_Date_))),COUNT(__d7(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseDate',COUNT(__d7(__NL(License_Date_))),COUNT(__d7(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HomeState',COUNT(__d7(__NL(Home_State_))),COUNT(__d7(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceState',COUNT(__d7(__NL(Source_State_))),COUNT(__d7(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsResident',COUNT(__d7(__NL(Is_Resident_))),COUNT(__d7(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHunting',COUNT(__d7(__NL(Is_Hunting_))),COUNT(__d7(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFishing',COUNT(__d7(__NL(Is_Fishing_))),COUNT(__d7(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementID',COUNT(__d7(__NL(Statement_I_D_))),COUNT(__d7(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementType',COUNT(__d7(__NL(Statement_Type_))),COUNT(__d7(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataGroup',COUNT(__d7(__NL(Data_Group_))),COUNT(__d7(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Content',COUNT(__d7(__NL(Content_))),COUNT(__d7(__NN(Content_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorrectedFlag',COUNT(__d7(__NL(Corrected_Flag_))),COUNT(__d7(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConsumerStatementFlag',COUNT(__d7(__NL(Consumer_Statement_Flag_))),COUNT(__d7(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DisputeFlag',COUNT(__d7(__NL(Dispute_Flag_))),COUNT(__d7(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityFreeze',COUNT(__d7(__NL(Security_Freeze_))),COUNT(__d7(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityAlert',COUNT(__d7(__NL(Security_Alert_))),COUNT(__d7(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NegativeAlert',COUNT(__d7(__NL(Negative_Alert_))),COUNT(__d7(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IDTheftFlag',COUNT(__d7(__NL(I_D_Theft_Flag_))),COUNT(__d7(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalHoldAlert',COUNT(__d7(__NL(Legal_Hold_Alert_))),COUNT(__d7(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThriveDateFirstSeen',COUNT(__d7(__NL(Thrive_Date_First_Seen_))),COUNT(__d7(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Employer',COUNT(__d7(__NL(Employer_))),COUNT(__d7(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PayFrequency',COUNT(__d7(__NL(Pay_Frequency_))),COUNT(__d7(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Income',COUNT(__d7(__NL(Income_))),COUNT(__d7(__NN(Income_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameScore',COUNT(__d7(__NL(Name_Score_))),COUNT(__d7(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d7(Archive___Date_=0)),COUNT(__d7(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d7(Date_First_Seen_=0)),COUNT(__d7(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d7(Date_Last_Seen_=0)),COUNT(__d7(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d7(Hybrid_Archive_Date_=0)),COUNT(__d7(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d7(Vault_Date_Last_Seen_=0)),COUNT(__d7(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_Number_Invalid),COUNT(__d8)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','title',COUNT(__d8(__NL(Title_))),COUNT(__d8(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fname',COUNT(__d8(__NL(First_Name_))),COUNT(__d8(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mname',COUNT(__d8(__NL(Middle_Name_))),COUNT(__d8(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lname',COUNT(__d8(__NL(Last_Name_))),COUNT(__d8(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_suffix',COUNT(__d8(__NL(Name_Suffix_))),COUNT(__d8(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d8(__NL(Lex_I_D_Segment_))),COUNT(__d8(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment2',COUNT(__d8(__NL(Lex_I_D_Segment2_))),COUNT(__d8(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob',COUNT(__d8(__NL(Date_Of_Birth_))),COUNT(__d8(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d8(__NL(Date_Of_Birth_Padded_))),COUNT(__d8(__NN(Date_Of_Birth_Padded_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dod',COUNT(__d8(__NL(Date_Of_Death_))),COUNT(__d8(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d8(__NL(Gender_))),COUNT(__d8(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','race',COUNT(__d8(__NL(Race_))),COUNT(__d8(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d8(__NL(Race_Description_))),COUNT(__d8(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d8(__NL(Header_Hit_Flag_))),COUNT(__d8(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Best',COUNT(__d8(__NL(Best_))),COUNT(__d8(__NN(Best_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FDNIndicator',COUNT(__d8(__NL(F_D_N_Indicator_))),COUNT(__d8(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeathMasterFlag',COUNT(__d8(__NL(Death_Master_Flag_))),COUNT(__d8(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source_code',COUNT(__d8(__NL(Source_))),COUNT(__d8(__NN(Source_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchProcessDate',COUNT(__d8(__NL(Purch_Process_Date_))),COUNT(__d8(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchHistoryFlag',COUNT(__d8(__NL(Purch_History_Flag_))),COUNT(__d8(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAmt',COUNT(__d8(__NL(Purch_New_Amt_))),COUNT(__d8(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchTotal',COUNT(__d8(__NL(Purch_Total_))),COUNT(__d8(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchCount',COUNT(__d8(__NL(Purch_Count_))),COUNT(__d8(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAgeMonths',COUNT(__d8(__NL(Purch_New_Age_Months_))),COUNT(__d8(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchOldAgeMonths',COUNT(__d8(__NL(Purch_Old_Age_Months_))),COUNT(__d8(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchItemCount',COUNT(__d8(__NL(Purch_Item_Count_))),COUNT(__d8(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchAmtAvg',COUNT(__d8(__NL(Purch_Amt_Avg_))),COUNT(__d8(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHuntFish',COUNT(__d8(__NL(Is_Hunt_Fish_))),COUNT(__d8(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCCW',COUNT(__d8(__NL(Is_C_C_W_))),COUNT(__d8(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PermitNumber',COUNT(__d8(__NL(Permit_Number_))),COUNT(__d8(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponPermitsType',COUNT(__d8(__NL(Weapon_Permits_Type_))),COUNT(__d8(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponRegistrationDate',COUNT(__d8(__NL(Weapon_Registration_Date_))),COUNT(__d8(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponExpirationDate',COUNT(__d8(__NL(Weapon_Expiration_Date_))),COUNT(__d8(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseDate',COUNT(__d8(__NL(License_Date_))),COUNT(__d8(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HomeState',COUNT(__d8(__NL(Home_State_))),COUNT(__d8(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceState',COUNT(__d8(__NL(Source_State_))),COUNT(__d8(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsResident',COUNT(__d8(__NL(Is_Resident_))),COUNT(__d8(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHunting',COUNT(__d8(__NL(Is_Hunting_))),COUNT(__d8(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFishing',COUNT(__d8(__NL(Is_Fishing_))),COUNT(__d8(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementID',COUNT(__d8(__NL(Statement_I_D_))),COUNT(__d8(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementType',COUNT(__d8(__NL(Statement_Type_))),COUNT(__d8(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataGroup',COUNT(__d8(__NL(Data_Group_))),COUNT(__d8(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Content',COUNT(__d8(__NL(Content_))),COUNT(__d8(__NN(Content_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorrectedFlag',COUNT(__d8(__NL(Corrected_Flag_))),COUNT(__d8(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConsumerStatementFlag',COUNT(__d8(__NL(Consumer_Statement_Flag_))),COUNT(__d8(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DisputeFlag',COUNT(__d8(__NL(Dispute_Flag_))),COUNT(__d8(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityFreeze',COUNT(__d8(__NL(Security_Freeze_))),COUNT(__d8(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityAlert',COUNT(__d8(__NL(Security_Alert_))),COUNT(__d8(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NegativeAlert',COUNT(__d8(__NL(Negative_Alert_))),COUNT(__d8(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IDTheftFlag',COUNT(__d8(__NL(I_D_Theft_Flag_))),COUNT(__d8(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalHoldAlert',COUNT(__d8(__NL(Legal_Hold_Alert_))),COUNT(__d8(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThriveDateFirstSeen',COUNT(__d8(__NL(Thrive_Date_First_Seen_))),COUNT(__d8(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Employer',COUNT(__d8(__NL(Employer_))),COUNT(__d8(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PayFrequency',COUNT(__d8(__NL(Pay_Frequency_))),COUNT(__d8(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Income',COUNT(__d8(__NL(Income_))),COUNT(__d8(__NN(Income_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameScore',COUNT(__d8(__NL(Name_Score_))),COUNT(__d8(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d8(Archive___Date_=0)),COUNT(__d8(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d8(Date_First_Seen_=0)),COUNT(__d8(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d8(Date_Last_Seen_=0)),COUNT(__d8(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d8(Hybrid_Archive_Date_=0)),COUNT(__d8(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d8(Vault_Date_Last_Seen_=0)),COUNT(__d8(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_PhonesPlus_v2__Key_Source_Level_Payload_Invalid),COUNT(__d9)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','title',COUNT(__d9(__NL(Title_))),COUNT(__d9(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fname',COUNT(__d9(__NL(First_Name_))),COUNT(__d9(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mname',COUNT(__d9(__NL(Middle_Name_))),COUNT(__d9(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lname',COUNT(__d9(__NL(Last_Name_))),COUNT(__d9(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_suffix',COUNT(__d9(__NL(Name_Suffix_))),COUNT(__d9(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d9(__NL(Lex_I_D_Segment_))),COUNT(__d9(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment2',COUNT(__d9(__NL(Lex_I_D_Segment2_))),COUNT(__d9(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob',COUNT(__d9(__NL(Date_Of_Birth_))),COUNT(__d9(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d9(__NL(Date_Of_Birth_Padded_))),COUNT(__d9(__NN(Date_Of_Birth_Padded_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDeath',COUNT(__d9(__NL(Date_Of_Death_))),COUNT(__d9(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d9(__NL(Gender_))),COUNT(__d9(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d9(__NL(Race_))),COUNT(__d9(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d9(__NL(Race_Description_))),COUNT(__d9(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d9(__NL(Header_Hit_Flag_))),COUNT(__d9(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Best',COUNT(__d9(__NL(Best_))),COUNT(__d9(__NN(Best_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FDNIndicator',COUNT(__d9(__NL(F_D_N_Indicator_))),COUNT(__d9(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeathMasterFlag',COUNT(__d9(__NL(Death_Master_Flag_))),COUNT(__d9(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d9(__NL(Source_))),COUNT(__d9(__NN(Source_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchProcessDate',COUNT(__d9(__NL(Purch_Process_Date_))),COUNT(__d9(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchHistoryFlag',COUNT(__d9(__NL(Purch_History_Flag_))),COUNT(__d9(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAmt',COUNT(__d9(__NL(Purch_New_Amt_))),COUNT(__d9(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchTotal',COUNT(__d9(__NL(Purch_Total_))),COUNT(__d9(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchCount',COUNT(__d9(__NL(Purch_Count_))),COUNT(__d9(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAgeMonths',COUNT(__d9(__NL(Purch_New_Age_Months_))),COUNT(__d9(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchOldAgeMonths',COUNT(__d9(__NL(Purch_Old_Age_Months_))),COUNT(__d9(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchItemCount',COUNT(__d9(__NL(Purch_Item_Count_))),COUNT(__d9(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchAmtAvg',COUNT(__d9(__NL(Purch_Amt_Avg_))),COUNT(__d9(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHuntFish',COUNT(__d9(__NL(Is_Hunt_Fish_))),COUNT(__d9(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCCW',COUNT(__d9(__NL(Is_C_C_W_))),COUNT(__d9(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PermitNumber',COUNT(__d9(__NL(Permit_Number_))),COUNT(__d9(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponPermitsType',COUNT(__d9(__NL(Weapon_Permits_Type_))),COUNT(__d9(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponRegistrationDate',COUNT(__d9(__NL(Weapon_Registration_Date_))),COUNT(__d9(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponExpirationDate',COUNT(__d9(__NL(Weapon_Expiration_Date_))),COUNT(__d9(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseDate',COUNT(__d9(__NL(License_Date_))),COUNT(__d9(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HomeState',COUNT(__d9(__NL(Home_State_))),COUNT(__d9(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceState',COUNT(__d9(__NL(Source_State_))),COUNT(__d9(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsResident',COUNT(__d9(__NL(Is_Resident_))),COUNT(__d9(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHunting',COUNT(__d9(__NL(Is_Hunting_))),COUNT(__d9(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFishing',COUNT(__d9(__NL(Is_Fishing_))),COUNT(__d9(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementID',COUNT(__d9(__NL(Statement_I_D_))),COUNT(__d9(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementType',COUNT(__d9(__NL(Statement_Type_))),COUNT(__d9(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataGroup',COUNT(__d9(__NL(Data_Group_))),COUNT(__d9(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Content',COUNT(__d9(__NL(Content_))),COUNT(__d9(__NN(Content_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorrectedFlag',COUNT(__d9(__NL(Corrected_Flag_))),COUNT(__d9(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConsumerStatementFlag',COUNT(__d9(__NL(Consumer_Statement_Flag_))),COUNT(__d9(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DisputeFlag',COUNT(__d9(__NL(Dispute_Flag_))),COUNT(__d9(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityFreeze',COUNT(__d9(__NL(Security_Freeze_))),COUNT(__d9(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityAlert',COUNT(__d9(__NL(Security_Alert_))),COUNT(__d9(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NegativeAlert',COUNT(__d9(__NL(Negative_Alert_))),COUNT(__d9(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IDTheftFlag',COUNT(__d9(__NL(I_D_Theft_Flag_))),COUNT(__d9(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalHoldAlert',COUNT(__d9(__NL(Legal_Hold_Alert_))),COUNT(__d9(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThriveDateFirstSeen',COUNT(__d9(__NL(Thrive_Date_First_Seen_))),COUNT(__d9(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Employer',COUNT(__d9(__NL(Employer_))),COUNT(__d9(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PayFrequency',COUNT(__d9(__NL(Pay_Frequency_))),COUNT(__d9(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Income',COUNT(__d9(__NL(Income_))),COUNT(__d9(__NN(Income_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_score',COUNT(__d9(__NL(Name_Score_))),COUNT(__d9(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d9(Archive___Date_=0)),COUNT(__d9(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d9(Date_First_Seen_=0)),COUNT(__d9(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d9(Date_Last_Seen_=0)),COUNT(__d9(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d9(Hybrid_Archive_Date_=0)),COUNT(__d9(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d9(Vault_Date_Last_Seen_=0)),COUNT(__d9(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Best_Person__Key_Watchdog_Invalid),COUNT(__d10)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec.title',COUNT(__d10(__NL(Title_))),COUNT(__d10(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec.fname',COUNT(__d10(__NL(First_Name_))),COUNT(__d10(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec.mname',COUNT(__d10(__NL(Middle_Name_))),COUNT(__d10(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec.lname',COUNT(__d10(__NL(Last_Name_))),COUNT(__d10(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec.name_suffix',COUNT(__d10(__NL(Name_Suffix_))),COUNT(__d10(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d10(__NL(Lex_I_D_Segment_))),COUNT(__d10(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment2',COUNT(__d10(__NL(Lex_I_D_Segment2_))),COUNT(__d10(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec.dob',COUNT(__d10(__NL(Date_Of_Birth_))),COUNT(__d10(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d10(__NL(Date_Of_Birth_Padded_))),COUNT(__d10(__NN(Date_Of_Birth_Padded_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rec.dod',COUNT(__d10(__NL(Date_Of_Death_))),COUNT(__d10(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d10(__NL(Gender_))),COUNT(__d10(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d10(__NL(Race_))),COUNT(__d10(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d10(__NL(Race_Description_))),COUNT(__d10(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FDNIndicator',COUNT(__d10(__NL(F_D_N_Indicator_))),COUNT(__d10(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeathMasterFlag',COUNT(__d10(__NL(Death_Master_Flag_))),COUNT(__d10(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d10(__NL(Source_))),COUNT(__d10(__NN(Source_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchProcessDate',COUNT(__d10(__NL(Purch_Process_Date_))),COUNT(__d10(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchHistoryFlag',COUNT(__d10(__NL(Purch_History_Flag_))),COUNT(__d10(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAmt',COUNT(__d10(__NL(Purch_New_Amt_))),COUNT(__d10(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchTotal',COUNT(__d10(__NL(Purch_Total_))),COUNT(__d10(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchCount',COUNT(__d10(__NL(Purch_Count_))),COUNT(__d10(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAgeMonths',COUNT(__d10(__NL(Purch_New_Age_Months_))),COUNT(__d10(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchOldAgeMonths',COUNT(__d10(__NL(Purch_Old_Age_Months_))),COUNT(__d10(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchItemCount',COUNT(__d10(__NL(Purch_Item_Count_))),COUNT(__d10(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchAmtAvg',COUNT(__d10(__NL(Purch_Amt_Avg_))),COUNT(__d10(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHuntFish',COUNT(__d10(__NL(Is_Hunt_Fish_))),COUNT(__d10(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCCW',COUNT(__d10(__NL(Is_C_C_W_))),COUNT(__d10(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PermitNumber',COUNT(__d10(__NL(Permit_Number_))),COUNT(__d10(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponPermitsType',COUNT(__d10(__NL(Weapon_Permits_Type_))),COUNT(__d10(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponRegistrationDate',COUNT(__d10(__NL(Weapon_Registration_Date_))),COUNT(__d10(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponExpirationDate',COUNT(__d10(__NL(Weapon_Expiration_Date_))),COUNT(__d10(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseDate',COUNT(__d10(__NL(License_Date_))),COUNT(__d10(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HomeState',COUNT(__d10(__NL(Home_State_))),COUNT(__d10(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceState',COUNT(__d10(__NL(Source_State_))),COUNT(__d10(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsResident',COUNT(__d10(__NL(Is_Resident_))),COUNT(__d10(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHunting',COUNT(__d10(__NL(Is_Hunting_))),COUNT(__d10(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFishing',COUNT(__d10(__NL(Is_Fishing_))),COUNT(__d10(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementID',COUNT(__d10(__NL(Statement_I_D_))),COUNT(__d10(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementType',COUNT(__d10(__NL(Statement_Type_))),COUNT(__d10(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataGroup',COUNT(__d10(__NL(Data_Group_))),COUNT(__d10(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Content',COUNT(__d10(__NL(Content_))),COUNT(__d10(__NN(Content_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorrectedFlag',COUNT(__d10(__NL(Corrected_Flag_))),COUNT(__d10(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConsumerStatementFlag',COUNT(__d10(__NL(Consumer_Statement_Flag_))),COUNT(__d10(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DisputeFlag',COUNT(__d10(__NL(Dispute_Flag_))),COUNT(__d10(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityFreeze',COUNT(__d10(__NL(Security_Freeze_))),COUNT(__d10(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityAlert',COUNT(__d10(__NL(Security_Alert_))),COUNT(__d10(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NegativeAlert',COUNT(__d10(__NL(Negative_Alert_))),COUNT(__d10(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IDTheftFlag',COUNT(__d10(__NL(I_D_Theft_Flag_))),COUNT(__d10(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalHoldAlert',COUNT(__d10(__NL(Legal_Hold_Alert_))),COUNT(__d10(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThriveDateFirstSeen',COUNT(__d10(__NL(Thrive_Date_First_Seen_))),COUNT(__d10(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Employer',COUNT(__d10(__NL(Employer_))),COUNT(__d10(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PayFrequency',COUNT(__d10(__NL(Pay_Frequency_))),COUNT(__d10(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Income',COUNT(__d10(__NL(Income_))),COUNT(__d10(__NN(Income_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameScore',COUNT(__d10(__NL(Name_Score_))),COUNT(__d10(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d10(Archive___Date_=0)),COUNT(__d10(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d10(Date_First_Seen_=0)),COUNT(__d10(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d10(Date_Last_Seen_=0)),COUNT(__d10(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d10(Hybrid_Archive_Date_=0)),COUNT(__d10(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d10(Vault_Date_Last_Seen_=0)),COUNT(__d10(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Best_Person__Key_Watchdog_FCRA_nonEN_Invalid),COUNT(__d11)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','title',COUNT(__d11(__NL(Title_))),COUNT(__d11(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fname',COUNT(__d11(__NL(First_Name_))),COUNT(__d11(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mname',COUNT(__d11(__NL(Middle_Name_))),COUNT(__d11(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lname',COUNT(__d11(__NL(Last_Name_))),COUNT(__d11(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_suffix',COUNT(__d11(__NL(Name_Suffix_))),COUNT(__d11(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d11(__NL(Lex_I_D_Segment_))),COUNT(__d11(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment2',COUNT(__d11(__NL(Lex_I_D_Segment2_))),COUNT(__d11(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob',COUNT(__d11(__NL(Date_Of_Birth_))),COUNT(__d11(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d11(__NL(Date_Of_Birth_Padded_))),COUNT(__d11(__NN(Date_Of_Birth_Padded_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dod',COUNT(__d11(__NL(Date_Of_Death_))),COUNT(__d11(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d11(__NL(Gender_))),COUNT(__d11(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d11(__NL(Race_))),COUNT(__d11(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d11(__NL(Race_Description_))),COUNT(__d11(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FDNIndicator',COUNT(__d11(__NL(F_D_N_Indicator_))),COUNT(__d11(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeathMasterFlag',COUNT(__d11(__NL(Death_Master_Flag_))),COUNT(__d11(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d11(__NL(Source_))),COUNT(__d11(__NN(Source_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchProcessDate',COUNT(__d11(__NL(Purch_Process_Date_))),COUNT(__d11(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchHistoryFlag',COUNT(__d11(__NL(Purch_History_Flag_))),COUNT(__d11(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAmt',COUNT(__d11(__NL(Purch_New_Amt_))),COUNT(__d11(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchTotal',COUNT(__d11(__NL(Purch_Total_))),COUNT(__d11(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchCount',COUNT(__d11(__NL(Purch_Count_))),COUNT(__d11(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAgeMonths',COUNT(__d11(__NL(Purch_New_Age_Months_))),COUNT(__d11(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchOldAgeMonths',COUNT(__d11(__NL(Purch_Old_Age_Months_))),COUNT(__d11(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchItemCount',COUNT(__d11(__NL(Purch_Item_Count_))),COUNT(__d11(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchAmtAvg',COUNT(__d11(__NL(Purch_Amt_Avg_))),COUNT(__d11(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHuntFish',COUNT(__d11(__NL(Is_Hunt_Fish_))),COUNT(__d11(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCCW',COUNT(__d11(__NL(Is_C_C_W_))),COUNT(__d11(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PermitNumber',COUNT(__d11(__NL(Permit_Number_))),COUNT(__d11(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponPermitsType',COUNT(__d11(__NL(Weapon_Permits_Type_))),COUNT(__d11(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponRegistrationDate',COUNT(__d11(__NL(Weapon_Registration_Date_))),COUNT(__d11(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponExpirationDate',COUNT(__d11(__NL(Weapon_Expiration_Date_))),COUNT(__d11(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseDate',COUNT(__d11(__NL(License_Date_))),COUNT(__d11(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HomeState',COUNT(__d11(__NL(Home_State_))),COUNT(__d11(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceState',COUNT(__d11(__NL(Source_State_))),COUNT(__d11(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsResident',COUNT(__d11(__NL(Is_Resident_))),COUNT(__d11(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHunting',COUNT(__d11(__NL(Is_Hunting_))),COUNT(__d11(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFishing',COUNT(__d11(__NL(Is_Fishing_))),COUNT(__d11(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementID',COUNT(__d11(__NL(Statement_I_D_))),COUNT(__d11(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementType',COUNT(__d11(__NL(Statement_Type_))),COUNT(__d11(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataGroup',COUNT(__d11(__NL(Data_Group_))),COUNT(__d11(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Content',COUNT(__d11(__NL(Content_))),COUNT(__d11(__NN(Content_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorrectedFlag',COUNT(__d11(__NL(Corrected_Flag_))),COUNT(__d11(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConsumerStatementFlag',COUNT(__d11(__NL(Consumer_Statement_Flag_))),COUNT(__d11(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DisputeFlag',COUNT(__d11(__NL(Dispute_Flag_))),COUNT(__d11(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityFreeze',COUNT(__d11(__NL(Security_Freeze_))),COUNT(__d11(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityAlert',COUNT(__d11(__NL(Security_Alert_))),COUNT(__d11(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NegativeAlert',COUNT(__d11(__NL(Negative_Alert_))),COUNT(__d11(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IDTheftFlag',COUNT(__d11(__NL(I_D_Theft_Flag_))),COUNT(__d11(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalHoldAlert',COUNT(__d11(__NL(Legal_Hold_Alert_))),COUNT(__d11(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThriveDateFirstSeen',COUNT(__d11(__NL(Thrive_Date_First_Seen_))),COUNT(__d11(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Employer',COUNT(__d11(__NL(Employer_))),COUNT(__d11(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PayFrequency',COUNT(__d11(__NL(Pay_Frequency_))),COUNT(__d11(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Income',COUNT(__d11(__NL(Income_))),COUNT(__d11(__NN(Income_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameScore',COUNT(__d11(__NL(Name_Score_))),COUNT(__d11(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d11(Archive___Date_=0)),COUNT(__d11(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d11(Date_First_Seen_=0)),COUNT(__d11(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d11(Date_Last_Seen_=0)),COUNT(__d11(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d11(Hybrid_Archive_Date_=0)),COUNT(__d11(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d11(Vault_Date_Last_Seen_=0)),COUNT(__d11(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Best_Person__Key_Watchdog_FCRA_nonEQ_Invalid),COUNT(__d12)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','title',COUNT(__d12(__NL(Title_))),COUNT(__d12(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fname',COUNT(__d12(__NL(First_Name_))),COUNT(__d12(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mname',COUNT(__d12(__NL(Middle_Name_))),COUNT(__d12(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lname',COUNT(__d12(__NL(Last_Name_))),COUNT(__d12(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_suffix',COUNT(__d12(__NL(Name_Suffix_))),COUNT(__d12(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d12(__NL(Lex_I_D_Segment_))),COUNT(__d12(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment2',COUNT(__d12(__NL(Lex_I_D_Segment2_))),COUNT(__d12(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob',COUNT(__d12(__NL(Date_Of_Birth_))),COUNT(__d12(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d12(__NL(Date_Of_Birth_Padded_))),COUNT(__d12(__NN(Date_Of_Birth_Padded_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dod',COUNT(__d12(__NL(Date_Of_Death_))),COUNT(__d12(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d12(__NL(Gender_))),COUNT(__d12(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d12(__NL(Race_))),COUNT(__d12(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d12(__NL(Race_Description_))),COUNT(__d12(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FDNIndicator',COUNT(__d12(__NL(F_D_N_Indicator_))),COUNT(__d12(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeathMasterFlag',COUNT(__d12(__NL(Death_Master_Flag_))),COUNT(__d12(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d12(__NL(Source_))),COUNT(__d12(__NN(Source_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchProcessDate',COUNT(__d12(__NL(Purch_Process_Date_))),COUNT(__d12(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchHistoryFlag',COUNT(__d12(__NL(Purch_History_Flag_))),COUNT(__d12(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAmt',COUNT(__d12(__NL(Purch_New_Amt_))),COUNT(__d12(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchTotal',COUNT(__d12(__NL(Purch_Total_))),COUNT(__d12(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchCount',COUNT(__d12(__NL(Purch_Count_))),COUNT(__d12(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAgeMonths',COUNT(__d12(__NL(Purch_New_Age_Months_))),COUNT(__d12(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchOldAgeMonths',COUNT(__d12(__NL(Purch_Old_Age_Months_))),COUNT(__d12(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchItemCount',COUNT(__d12(__NL(Purch_Item_Count_))),COUNT(__d12(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchAmtAvg',COUNT(__d12(__NL(Purch_Amt_Avg_))),COUNT(__d12(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHuntFish',COUNT(__d12(__NL(Is_Hunt_Fish_))),COUNT(__d12(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCCW',COUNT(__d12(__NL(Is_C_C_W_))),COUNT(__d12(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PermitNumber',COUNT(__d12(__NL(Permit_Number_))),COUNT(__d12(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponPermitsType',COUNT(__d12(__NL(Weapon_Permits_Type_))),COUNT(__d12(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponRegistrationDate',COUNT(__d12(__NL(Weapon_Registration_Date_))),COUNT(__d12(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponExpirationDate',COUNT(__d12(__NL(Weapon_Expiration_Date_))),COUNT(__d12(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseDate',COUNT(__d12(__NL(License_Date_))),COUNT(__d12(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HomeState',COUNT(__d12(__NL(Home_State_))),COUNT(__d12(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceState',COUNT(__d12(__NL(Source_State_))),COUNT(__d12(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsResident',COUNT(__d12(__NL(Is_Resident_))),COUNT(__d12(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHunting',COUNT(__d12(__NL(Is_Hunting_))),COUNT(__d12(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFishing',COUNT(__d12(__NL(Is_Fishing_))),COUNT(__d12(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementID',COUNT(__d12(__NL(Statement_I_D_))),COUNT(__d12(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementType',COUNT(__d12(__NL(Statement_Type_))),COUNT(__d12(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataGroup',COUNT(__d12(__NL(Data_Group_))),COUNT(__d12(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Content',COUNT(__d12(__NL(Content_))),COUNT(__d12(__NN(Content_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorrectedFlag',COUNT(__d12(__NL(Corrected_Flag_))),COUNT(__d12(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConsumerStatementFlag',COUNT(__d12(__NL(Consumer_Statement_Flag_))),COUNT(__d12(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DisputeFlag',COUNT(__d12(__NL(Dispute_Flag_))),COUNT(__d12(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityFreeze',COUNT(__d12(__NL(Security_Freeze_))),COUNT(__d12(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityAlert',COUNT(__d12(__NL(Security_Alert_))),COUNT(__d12(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NegativeAlert',COUNT(__d12(__NL(Negative_Alert_))),COUNT(__d12(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IDTheftFlag',COUNT(__d12(__NL(I_D_Theft_Flag_))),COUNT(__d12(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalHoldAlert',COUNT(__d12(__NL(Legal_Hold_Alert_))),COUNT(__d12(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThriveDateFirstSeen',COUNT(__d12(__NL(Thrive_Date_First_Seen_))),COUNT(__d12(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Employer',COUNT(__d12(__NL(Employer_))),COUNT(__d12(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PayFrequency',COUNT(__d12(__NL(Pay_Frequency_))),COUNT(__d12(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Income',COUNT(__d12(__NL(Income_))),COUNT(__d12(__NN(Income_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameScore',COUNT(__d12(__NL(Name_Score_))),COUNT(__d12(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d12(Archive___Date_=0)),COUNT(__d12(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d12(Date_First_Seen_=0)),COUNT(__d12(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d12(Date_Last_Seen_=0)),COUNT(__d12(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d12(Hybrid_Archive_Date_=0)),COUNT(__d12(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d12(Vault_Date_Last_Seen_=0)),COUNT(__d12(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_fraudpoint3__Key_DID_Invalid),COUNT(__d13)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Title',COUNT(__d13(__NL(Title_))),COUNT(__d13(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','first_name',COUNT(__d13(__NL(First_Name_))),COUNT(__d13(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','middle_name',COUNT(__d13(__NL(Middle_Name_))),COUNT(__d13(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','last_name',COUNT(__d13(__NL(Last_Name_))),COUNT(__d13(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameSuffix',COUNT(__d13(__NL(Name_Suffix_))),COUNT(__d13(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d13(__NL(Lex_I_D_Segment_))),COUNT(__d13(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment2',COUNT(__d13(__NL(Lex_I_D_Segment2_))),COUNT(__d13(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob',COUNT(__d13(__NL(Date_Of_Birth_))),COUNT(__d13(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d13(__NL(Date_Of_Birth_Padded_))),COUNT(__d13(__NN(Date_Of_Birth_Padded_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDeath',COUNT(__d13(__NL(Date_Of_Death_))),COUNT(__d13(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d13(__NL(Gender_))),COUNT(__d13(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d13(__NL(Race_))),COUNT(__d13(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d13(__NL(Race_Description_))),COUNT(__d13(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d13(__NL(Header_Hit_Flag_))),COUNT(__d13(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Best',COUNT(__d13(__NL(Best_))),COUNT(__d13(__NN(Best_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeathMasterFlag',COUNT(__d13(__NL(Death_Master_Flag_))),COUNT(__d13(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d13(__NL(Source_))),COUNT(__d13(__NN(Source_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchProcessDate',COUNT(__d13(__NL(Purch_Process_Date_))),COUNT(__d13(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchHistoryFlag',COUNT(__d13(__NL(Purch_History_Flag_))),COUNT(__d13(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAmt',COUNT(__d13(__NL(Purch_New_Amt_))),COUNT(__d13(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchTotal',COUNT(__d13(__NL(Purch_Total_))),COUNT(__d13(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchCount',COUNT(__d13(__NL(Purch_Count_))),COUNT(__d13(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAgeMonths',COUNT(__d13(__NL(Purch_New_Age_Months_))),COUNT(__d13(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchOldAgeMonths',COUNT(__d13(__NL(Purch_Old_Age_Months_))),COUNT(__d13(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchItemCount',COUNT(__d13(__NL(Purch_Item_Count_))),COUNT(__d13(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchAmtAvg',COUNT(__d13(__NL(Purch_Amt_Avg_))),COUNT(__d13(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHuntFish',COUNT(__d13(__NL(Is_Hunt_Fish_))),COUNT(__d13(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCCW',COUNT(__d13(__NL(Is_C_C_W_))),COUNT(__d13(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PermitNumber',COUNT(__d13(__NL(Permit_Number_))),COUNT(__d13(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponPermitsType',COUNT(__d13(__NL(Weapon_Permits_Type_))),COUNT(__d13(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponRegistrationDate',COUNT(__d13(__NL(Weapon_Registration_Date_))),COUNT(__d13(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponExpirationDate',COUNT(__d13(__NL(Weapon_Expiration_Date_))),COUNT(__d13(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseDate',COUNT(__d13(__NL(License_Date_))),COUNT(__d13(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HomeState',COUNT(__d13(__NL(Home_State_))),COUNT(__d13(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceState',COUNT(__d13(__NL(Source_State_))),COUNT(__d13(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsResident',COUNT(__d13(__NL(Is_Resident_))),COUNT(__d13(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHunting',COUNT(__d13(__NL(Is_Hunting_))),COUNT(__d13(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFishing',COUNT(__d13(__NL(Is_Fishing_))),COUNT(__d13(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementID',COUNT(__d13(__NL(Statement_I_D_))),COUNT(__d13(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementType',COUNT(__d13(__NL(Statement_Type_))),COUNT(__d13(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataGroup',COUNT(__d13(__NL(Data_Group_))),COUNT(__d13(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Content',COUNT(__d13(__NL(Content_))),COUNT(__d13(__NN(Content_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorrectedFlag',COUNT(__d13(__NL(Corrected_Flag_))),COUNT(__d13(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConsumerStatementFlag',COUNT(__d13(__NL(Consumer_Statement_Flag_))),COUNT(__d13(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DisputeFlag',COUNT(__d13(__NL(Dispute_Flag_))),COUNT(__d13(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityFreeze',COUNT(__d13(__NL(Security_Freeze_))),COUNT(__d13(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityAlert',COUNT(__d13(__NL(Security_Alert_))),COUNT(__d13(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NegativeAlert',COUNT(__d13(__NL(Negative_Alert_))),COUNT(__d13(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IDTheftFlag',COUNT(__d13(__NL(I_D_Theft_Flag_))),COUNT(__d13(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalHoldAlert',COUNT(__d13(__NL(Legal_Hold_Alert_))),COUNT(__d13(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThriveDateFirstSeen',COUNT(__d13(__NL(Thrive_Date_First_Seen_))),COUNT(__d13(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Employer',COUNT(__d13(__NL(Employer_))),COUNT(__d13(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PayFrequency',COUNT(__d13(__NL(Pay_Frequency_))),COUNT(__d13(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Income',COUNT(__d13(__NL(Income_))),COUNT(__d13(__NN(Income_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameScore',COUNT(__d13(__NL(Name_Score_))),COUNT(__d13(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d13(Archive___Date_=0)),COUNT(__d13(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d13(Date_First_Seen_=0)),COUNT(__d13(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d13(Date_Last_Seen_=0)),COUNT(__d13(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d13(Hybrid_Archive_Date_=0)),COUNT(__d13(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d13(Vault_Date_Last_Seen_=0)),COUNT(__d13(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_eMerges__Key_HuntFish_Rid_Invalid),COUNT(__d14)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Title',COUNT(__d14(__NL(Title_))),COUNT(__d14(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FirstName',COUNT(__d14(__NL(First_Name_))),COUNT(__d14(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MiddleName',COUNT(__d14(__NL(Middle_Name_))),COUNT(__d14(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LastName',COUNT(__d14(__NL(Last_Name_))),COUNT(__d14(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameSuffix',COUNT(__d14(__NL(Name_Suffix_))),COUNT(__d14(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d14(__NL(Lex_I_D_Segment_))),COUNT(__d14(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment2',COUNT(__d14(__NL(Lex_I_D_Segment2_))),COUNT(__d14(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirth',COUNT(__d14(__NL(Date_Of_Birth_))),COUNT(__d14(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d14(__NL(Date_Of_Birth_Padded_))),COUNT(__d14(__NN(Date_Of_Birth_Padded_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDeath',COUNT(__d14(__NL(Date_Of_Death_))),COUNT(__d14(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d14(__NL(Gender_))),COUNT(__d14(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d14(__NL(Race_))),COUNT(__d14(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d14(__NL(Race_Description_))),COUNT(__d14(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d14(__NL(Header_Hit_Flag_))),COUNT(__d14(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Best',COUNT(__d14(__NL(Best_))),COUNT(__d14(__NN(Best_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FDNIndicator',COUNT(__d14(__NL(F_D_N_Indicator_))),COUNT(__d14(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeathMasterFlag',COUNT(__d14(__NL(Death_Master_Flag_))),COUNT(__d14(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d14(__NL(Source_))),COUNT(__d14(__NN(Source_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchProcessDate',COUNT(__d14(__NL(Purch_Process_Date_))),COUNT(__d14(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchHistoryFlag',COUNT(__d14(__NL(Purch_History_Flag_))),COUNT(__d14(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAmt',COUNT(__d14(__NL(Purch_New_Amt_))),COUNT(__d14(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchTotal',COUNT(__d14(__NL(Purch_Total_))),COUNT(__d14(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchCount',COUNT(__d14(__NL(Purch_Count_))),COUNT(__d14(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAgeMonths',COUNT(__d14(__NL(Purch_New_Age_Months_))),COUNT(__d14(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchOldAgeMonths',COUNT(__d14(__NL(Purch_Old_Age_Months_))),COUNT(__d14(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchItemCount',COUNT(__d14(__NL(Purch_Item_Count_))),COUNT(__d14(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchAmtAvg',COUNT(__d14(__NL(Purch_Amt_Avg_))),COUNT(__d14(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCCW',COUNT(__d14(__NL(Is_C_C_W_))),COUNT(__d14(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PermitNumber',COUNT(__d14(__NL(Permit_Number_))),COUNT(__d14(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponPermitsType',COUNT(__d14(__NL(Weapon_Permits_Type_))),COUNT(__d14(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponRegistrationDate',COUNT(__d14(__NL(Weapon_Registration_Date_))),COUNT(__d14(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponExpirationDate',COUNT(__d14(__NL(Weapon_Expiration_Date_))),COUNT(__d14(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseDate',COUNT(__d14(__NL(License_Date_))),COUNT(__d14(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','homestate',COUNT(__d14(__NL(Home_State_))),COUNT(__d14(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source_state',COUNT(__d14(__NL(Source_State_))),COUNT(__d14(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsResident',COUNT(__d14(__NL(Is_Resident_))),COUNT(__d14(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHunting',COUNT(__d14(__NL(Is_Hunting_))),COUNT(__d14(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFishing',COUNT(__d14(__NL(Is_Fishing_))),COUNT(__d14(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementID',COUNT(__d14(__NL(Statement_I_D_))),COUNT(__d14(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementType',COUNT(__d14(__NL(Statement_Type_))),COUNT(__d14(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataGroup',COUNT(__d14(__NL(Data_Group_))),COUNT(__d14(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Content',COUNT(__d14(__NL(Content_))),COUNT(__d14(__NN(Content_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorrectedFlag',COUNT(__d14(__NL(Corrected_Flag_))),COUNT(__d14(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConsumerStatementFlag',COUNT(__d14(__NL(Consumer_Statement_Flag_))),COUNT(__d14(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DisputeFlag',COUNT(__d14(__NL(Dispute_Flag_))),COUNT(__d14(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityFreeze',COUNT(__d14(__NL(Security_Freeze_))),COUNT(__d14(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityAlert',COUNT(__d14(__NL(Security_Alert_))),COUNT(__d14(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NegativeAlert',COUNT(__d14(__NL(Negative_Alert_))),COUNT(__d14(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IDTheftFlag',COUNT(__d14(__NL(I_D_Theft_Flag_))),COUNT(__d14(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalHoldAlert',COUNT(__d14(__NL(Legal_Hold_Alert_))),COUNT(__d14(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThriveDateFirstSeen',COUNT(__d14(__NL(Thrive_Date_First_Seen_))),COUNT(__d14(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Employer',COUNT(__d14(__NL(Employer_))),COUNT(__d14(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PayFrequency',COUNT(__d14(__NL(Pay_Frequency_))),COUNT(__d14(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Income',COUNT(__d14(__NL(Income_))),COUNT(__d14(__NN(Income_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameScore',COUNT(__d14(__NL(Name_Score_))),COUNT(__d14(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d14(Archive___Date_=0)),COUNT(__d14(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d14(Date_First_Seen_=0)),COUNT(__d14(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d14(Date_Last_Seen_=0)),COUNT(__d14(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d14(Hybrid_Archive_Date_=0)),COUNT(__d14(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d14(Vault_Date_Last_Seen_=0)),COUNT(__d14(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_eMerges__key_ccw_rid_Invalid),COUNT(__d15)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Title',COUNT(__d15(__NL(Title_))),COUNT(__d15(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FirstName',COUNT(__d15(__NL(First_Name_))),COUNT(__d15(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MiddleName',COUNT(__d15(__NL(Middle_Name_))),COUNT(__d15(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LastName',COUNT(__d15(__NL(Last_Name_))),COUNT(__d15(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameSuffix',COUNT(__d15(__NL(Name_Suffix_))),COUNT(__d15(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d15(__NL(Lex_I_D_Segment_))),COUNT(__d15(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment2',COUNT(__d15(__NL(Lex_I_D_Segment2_))),COUNT(__d15(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirth',COUNT(__d15(__NL(Date_Of_Birth_))),COUNT(__d15(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d15(__NL(Date_Of_Birth_Padded_))),COUNT(__d15(__NN(Date_Of_Birth_Padded_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDeath',COUNT(__d15(__NL(Date_Of_Death_))),COUNT(__d15(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d15(__NL(Gender_))),COUNT(__d15(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d15(__NL(Race_))),COUNT(__d15(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d15(__NL(Race_Description_))),COUNT(__d15(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d15(__NL(Header_Hit_Flag_))),COUNT(__d15(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Best',COUNT(__d15(__NL(Best_))),COUNT(__d15(__NN(Best_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FDNIndicator',COUNT(__d15(__NL(F_D_N_Indicator_))),COUNT(__d15(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeathMasterFlag',COUNT(__d15(__NL(Death_Master_Flag_))),COUNT(__d15(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d15(__NL(Source_))),COUNT(__d15(__NN(Source_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchProcessDate',COUNT(__d15(__NL(Purch_Process_Date_))),COUNT(__d15(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchHistoryFlag',COUNT(__d15(__NL(Purch_History_Flag_))),COUNT(__d15(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAmt',COUNT(__d15(__NL(Purch_New_Amt_))),COUNT(__d15(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchTotal',COUNT(__d15(__NL(Purch_Total_))),COUNT(__d15(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchCount',COUNT(__d15(__NL(Purch_Count_))),COUNT(__d15(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAgeMonths',COUNT(__d15(__NL(Purch_New_Age_Months_))),COUNT(__d15(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchOldAgeMonths',COUNT(__d15(__NL(Purch_Old_Age_Months_))),COUNT(__d15(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchItemCount',COUNT(__d15(__NL(Purch_Item_Count_))),COUNT(__d15(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchAmtAvg',COUNT(__d15(__NL(Purch_Amt_Avg_))),COUNT(__d15(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHuntFish',COUNT(__d15(__NL(Is_Hunt_Fish_))),COUNT(__d15(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ccwpermnum',COUNT(__d15(__NL(Permit_Number_))),COUNT(__d15(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ccwpermtype',COUNT(__d15(__NL(Weapon_Permits_Type_))),COUNT(__d15(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ccwregdate',COUNT(__d15(__NL(Weapon_Registration_Date_))),COUNT(__d15(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ccwexpdate',COUNT(__d15(__NL(Weapon_Expiration_Date_))),COUNT(__d15(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseDate',COUNT(__d15(__NL(License_Date_))),COUNT(__d15(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HomeState',COUNT(__d15(__NL(Home_State_))),COUNT(__d15(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceState',COUNT(__d15(__NL(Source_State_))),COUNT(__d15(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsResident',COUNT(__d15(__NL(Is_Resident_))),COUNT(__d15(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHunting',COUNT(__d15(__NL(Is_Hunting_))),COUNT(__d15(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFishing',COUNT(__d15(__NL(Is_Fishing_))),COUNT(__d15(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementID',COUNT(__d15(__NL(Statement_I_D_))),COUNT(__d15(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementType',COUNT(__d15(__NL(Statement_Type_))),COUNT(__d15(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataGroup',COUNT(__d15(__NL(Data_Group_))),COUNT(__d15(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Content',COUNT(__d15(__NL(Content_))),COUNT(__d15(__NN(Content_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorrectedFlag',COUNT(__d15(__NL(Corrected_Flag_))),COUNT(__d15(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConsumerStatementFlag',COUNT(__d15(__NL(Consumer_Statement_Flag_))),COUNT(__d15(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DisputeFlag',COUNT(__d15(__NL(Dispute_Flag_))),COUNT(__d15(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityFreeze',COUNT(__d15(__NL(Security_Freeze_))),COUNT(__d15(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityAlert',COUNT(__d15(__NL(Security_Alert_))),COUNT(__d15(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NegativeAlert',COUNT(__d15(__NL(Negative_Alert_))),COUNT(__d15(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IDTheftFlag',COUNT(__d15(__NL(I_D_Theft_Flag_))),COUNT(__d15(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalHoldAlert',COUNT(__d15(__NL(Legal_Hold_Alert_))),COUNT(__d15(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThriveDateFirstSeen',COUNT(__d15(__NL(Thrive_Date_First_Seen_))),COUNT(__d15(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Employer',COUNT(__d15(__NL(Employer_))),COUNT(__d15(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PayFrequency',COUNT(__d15(__NL(Pay_Frequency_))),COUNT(__d15(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Income',COUNT(__d15(__NL(Income_))),COUNT(__d15(__NN(Income_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameScore',COUNT(__d15(__NL(Name_Score_))),COUNT(__d15(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d15(Archive___Date_=0)),COUNT(__d15(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d15(Date_First_Seen_=0)),COUNT(__d15(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d15(Date_Last_Seen_=0)),COUNT(__d15(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d15(Hybrid_Archive_Date_=0)),COUNT(__d15(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d15(Vault_Date_Last_Seen_=0)),COUNT(__d15(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Thrive__Key___Did_QA_Invalid),COUNT(__d16)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Title',COUNT(__d16(__NL(Title_))),COUNT(__d16(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FirstName',COUNT(__d16(__NL(First_Name_))),COUNT(__d16(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MiddleName',COUNT(__d16(__NL(Middle_Name_))),COUNT(__d16(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LastName',COUNT(__d16(__NL(Last_Name_))),COUNT(__d16(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameSuffix',COUNT(__d16(__NL(Name_Suffix_))),COUNT(__d16(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d16(__NL(Lex_I_D_Segment_))),COUNT(__d16(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment2',COUNT(__d16(__NL(Lex_I_D_Segment2_))),COUNT(__d16(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirth',COUNT(__d16(__NL(Date_Of_Birth_))),COUNT(__d16(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d16(__NL(Date_Of_Birth_Padded_))),COUNT(__d16(__NN(Date_Of_Birth_Padded_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDeath',COUNT(__d16(__NL(Date_Of_Death_))),COUNT(__d16(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d16(__NL(Gender_))),COUNT(__d16(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d16(__NL(Race_))),COUNT(__d16(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d16(__NL(Race_Description_))),COUNT(__d16(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d16(__NL(Header_Hit_Flag_))),COUNT(__d16(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Best',COUNT(__d16(__NL(Best_))),COUNT(__d16(__NN(Best_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FDNIndicator',COUNT(__d16(__NL(F_D_N_Indicator_))),COUNT(__d16(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeathMasterFlag',COUNT(__d16(__NL(Death_Master_Flag_))),COUNT(__d16(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d16(__NL(Source_))),COUNT(__d16(__NN(Source_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchProcessDate',COUNT(__d16(__NL(Purch_Process_Date_))),COUNT(__d16(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchHistoryFlag',COUNT(__d16(__NL(Purch_History_Flag_))),COUNT(__d16(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAmt',COUNT(__d16(__NL(Purch_New_Amt_))),COUNT(__d16(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchTotal',COUNT(__d16(__NL(Purch_Total_))),COUNT(__d16(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchCount',COUNT(__d16(__NL(Purch_Count_))),COUNT(__d16(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAgeMonths',COUNT(__d16(__NL(Purch_New_Age_Months_))),COUNT(__d16(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchOldAgeMonths',COUNT(__d16(__NL(Purch_Old_Age_Months_))),COUNT(__d16(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchItemCount',COUNT(__d16(__NL(Purch_Item_Count_))),COUNT(__d16(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchAmtAvg',COUNT(__d16(__NL(Purch_Amt_Avg_))),COUNT(__d16(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHuntFish',COUNT(__d16(__NL(Is_Hunt_Fish_))),COUNT(__d16(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCCW',COUNT(__d16(__NL(Is_C_C_W_))),COUNT(__d16(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PermitNumber',COUNT(__d16(__NL(Permit_Number_))),COUNT(__d16(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponPermitsType',COUNT(__d16(__NL(Weapon_Permits_Type_))),COUNT(__d16(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponRegistrationDate',COUNT(__d16(__NL(Weapon_Registration_Date_))),COUNT(__d16(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponExpirationDate',COUNT(__d16(__NL(Weapon_Expiration_Date_))),COUNT(__d16(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseDate',COUNT(__d16(__NL(License_Date_))),COUNT(__d16(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HomeState',COUNT(__d16(__NL(Home_State_))),COUNT(__d16(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceState',COUNT(__d16(__NL(Source_State_))),COUNT(__d16(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsResident',COUNT(__d16(__NL(Is_Resident_))),COUNT(__d16(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHunting',COUNT(__d16(__NL(Is_Hunting_))),COUNT(__d16(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFishing',COUNT(__d16(__NL(Is_Fishing_))),COUNT(__d16(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementID',COUNT(__d16(__NL(Statement_I_D_))),COUNT(__d16(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementType',COUNT(__d16(__NL(Statement_Type_))),COUNT(__d16(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataGroup',COUNT(__d16(__NL(Data_Group_))),COUNT(__d16(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Content',COUNT(__d16(__NL(Content_))),COUNT(__d16(__NN(Content_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorrectedFlag',COUNT(__d16(__NL(Corrected_Flag_))),COUNT(__d16(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConsumerStatementFlag',COUNT(__d16(__NL(Consumer_Statement_Flag_))),COUNT(__d16(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DisputeFlag',COUNT(__d16(__NL(Dispute_Flag_))),COUNT(__d16(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityFreeze',COUNT(__d16(__NL(Security_Freeze_))),COUNT(__d16(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityAlert',COUNT(__d16(__NL(Security_Alert_))),COUNT(__d16(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NegativeAlert',COUNT(__d16(__NL(Negative_Alert_))),COUNT(__d16(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IDTheftFlag',COUNT(__d16(__NL(I_D_Theft_Flag_))),COUNT(__d16(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalHoldAlert',COUNT(__d16(__NL(Legal_Hold_Alert_))),COUNT(__d16(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_first_seen',COUNT(__d16(__NL(Thrive_Date_First_Seen_))),COUNT(__d16(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','employer',COUNT(__d16(__NL(Employer_))),COUNT(__d16(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','pay_frequency',COUNT(__d16(__NL(Pay_Frequency_))),COUNT(__d16(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','income',COUNT(__d16(__NL(Income_))),COUNT(__d16(__NN(Income_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameScore',COUNT(__d16(__NL(Name_Score_))),COUNT(__d16(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d16(Archive___Date_=0)),COUNT(__d16(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d16(Date_First_Seen_=0)),COUNT(__d16(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d16(Date_Last_Seen_=0)),COUNT(__d16(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d16(Hybrid_Archive_Date_=0)),COUNT(__d16(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d16(Vault_Date_Last_Seen_=0)),COUNT(__d16(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_SexOffender__Key_SexOffender_SPK_Invalid),COUNT(__d17)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Title',COUNT(__d17(__NL(Title_))),COUNT(__d17(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FirstName',COUNT(__d17(__NL(First_Name_))),COUNT(__d17(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MiddleName',COUNT(__d17(__NL(Middle_Name_))),COUNT(__d17(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LastName',COUNT(__d17(__NL(Last_Name_))),COUNT(__d17(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameSuffix',COUNT(__d17(__NL(Name_Suffix_))),COUNT(__d17(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d17(__NL(Lex_I_D_Segment_))),COUNT(__d17(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment2',COUNT(__d17(__NL(Lex_I_D_Segment2_))),COUNT(__d17(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirth',COUNT(__d17(__NL(Date_Of_Birth_))),COUNT(__d17(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d17(__NL(Date_Of_Birth_Padded_))),COUNT(__d17(__NN(Date_Of_Birth_Padded_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDeath',COUNT(__d17(__NL(Date_Of_Death_))),COUNT(__d17(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d17(__NL(Gender_))),COUNT(__d17(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d17(__NL(Race_))),COUNT(__d17(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d17(__NL(Race_Description_))),COUNT(__d17(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d17(__NL(Header_Hit_Flag_))),COUNT(__d17(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Best',COUNT(__d17(__NL(Best_))),COUNT(__d17(__NN(Best_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FDNIndicator',COUNT(__d17(__NL(F_D_N_Indicator_))),COUNT(__d17(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeathMasterFlag',COUNT(__d17(__NL(Death_Master_Flag_))),COUNT(__d17(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d17(__NL(Source_))),COUNT(__d17(__NN(Source_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchProcessDate',COUNT(__d17(__NL(Purch_Process_Date_))),COUNT(__d17(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchHistoryFlag',COUNT(__d17(__NL(Purch_History_Flag_))),COUNT(__d17(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAmt',COUNT(__d17(__NL(Purch_New_Amt_))),COUNT(__d17(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchTotal',COUNT(__d17(__NL(Purch_Total_))),COUNT(__d17(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchCount',COUNT(__d17(__NL(Purch_Count_))),COUNT(__d17(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAgeMonths',COUNT(__d17(__NL(Purch_New_Age_Months_))),COUNT(__d17(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchOldAgeMonths',COUNT(__d17(__NL(Purch_Old_Age_Months_))),COUNT(__d17(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchItemCount',COUNT(__d17(__NL(Purch_Item_Count_))),COUNT(__d17(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchAmtAvg',COUNT(__d17(__NL(Purch_Amt_Avg_))),COUNT(__d17(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHuntFish',COUNT(__d17(__NL(Is_Hunt_Fish_))),COUNT(__d17(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCCW',COUNT(__d17(__NL(Is_C_C_W_))),COUNT(__d17(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PermitNumber',COUNT(__d17(__NL(Permit_Number_))),COUNT(__d17(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponPermitsType',COUNT(__d17(__NL(Weapon_Permits_Type_))),COUNT(__d17(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponRegistrationDate',COUNT(__d17(__NL(Weapon_Registration_Date_))),COUNT(__d17(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponExpirationDate',COUNT(__d17(__NL(Weapon_Expiration_Date_))),COUNT(__d17(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseDate',COUNT(__d17(__NL(License_Date_))),COUNT(__d17(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HomeState',COUNT(__d17(__NL(Home_State_))),COUNT(__d17(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceState',COUNT(__d17(__NL(Source_State_))),COUNT(__d17(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsResident',COUNT(__d17(__NL(Is_Resident_))),COUNT(__d17(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHunting',COUNT(__d17(__NL(Is_Hunting_))),COUNT(__d17(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFishing',COUNT(__d17(__NL(Is_Fishing_))),COUNT(__d17(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementID',COUNT(__d17(__NL(Statement_I_D_))),COUNT(__d17(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementType',COUNT(__d17(__NL(Statement_Type_))),COUNT(__d17(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataGroup',COUNT(__d17(__NL(Data_Group_))),COUNT(__d17(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Content',COUNT(__d17(__NL(Content_))),COUNT(__d17(__NN(Content_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorrectedFlag',COUNT(__d17(__NL(Corrected_Flag_))),COUNT(__d17(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConsumerStatementFlag',COUNT(__d17(__NL(Consumer_Statement_Flag_))),COUNT(__d17(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DisputeFlag',COUNT(__d17(__NL(Dispute_Flag_))),COUNT(__d17(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityFreeze',COUNT(__d17(__NL(Security_Freeze_))),COUNT(__d17(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityAlert',COUNT(__d17(__NL(Security_Alert_))),COUNT(__d17(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NegativeAlert',COUNT(__d17(__NL(Negative_Alert_))),COUNT(__d17(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IDTheftFlag',COUNT(__d17(__NL(I_D_Theft_Flag_))),COUNT(__d17(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalHoldAlert',COUNT(__d17(__NL(Legal_Hold_Alert_))),COUNT(__d17(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThriveDateFirstSeen',COUNT(__d17(__NL(Thrive_Date_First_Seen_))),COUNT(__d17(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Employer',COUNT(__d17(__NL(Employer_))),COUNT(__d17(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PayFrequency',COUNT(__d17(__NL(Pay_Frequency_))),COUNT(__d17(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Income',COUNT(__d17(__NL(Income_))),COUNT(__d17(__NN(Income_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameScore',COUNT(__d17(__NL(Name_Score_))),COUNT(__d17(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d17(Archive___Date_=0)),COUNT(__d17(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d17(Date_First_Seen_=0)),COUNT(__d17(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d17(Date_Last_Seen_=0)),COUNT(__d17(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d17(Hybrid_Archive_Date_=0)),COUNT(__d17(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d17(Vault_Date_Last_Seen_=0)),COUNT(__d17(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header__key_ADL_segmentation_Invalid),COUNT(__d18)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Title',COUNT(__d18(__NL(Title_))),COUNT(__d18(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FirstName',COUNT(__d18(__NL(First_Name_))),COUNT(__d18(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MiddleName',COUNT(__d18(__NL(Middle_Name_))),COUNT(__d18(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LastName',COUNT(__d18(__NL(Last_Name_))),COUNT(__d18(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameSuffix',COUNT(__d18(__NL(Name_Suffix_))),COUNT(__d18(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ind1',COUNT(__d18(__NL(Lex_I_D_Segment_))),COUNT(__d18(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ind2',COUNT(__d18(__NL(Lex_I_D_Segment2_))),COUNT(__d18(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirth',COUNT(__d18(__NL(Date_Of_Birth_))),COUNT(__d18(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d18(__NL(Date_Of_Birth_Padded_))),COUNT(__d18(__NN(Date_Of_Birth_Padded_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDeath',COUNT(__d18(__NL(Date_Of_Death_))),COUNT(__d18(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d18(__NL(Gender_))),COUNT(__d18(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d18(__NL(Race_))),COUNT(__d18(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d18(__NL(Race_Description_))),COUNT(__d18(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d18(__NL(Header_Hit_Flag_))),COUNT(__d18(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Best',COUNT(__d18(__NL(Best_))),COUNT(__d18(__NN(Best_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FDNIndicator',COUNT(__d18(__NL(F_D_N_Indicator_))),COUNT(__d18(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DeathMasterFlag',COUNT(__d18(__NL(Death_Master_Flag_))),COUNT(__d18(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d18(__NL(Source_))),COUNT(__d18(__NN(Source_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchProcessDate',COUNT(__d18(__NL(Purch_Process_Date_))),COUNT(__d18(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchHistoryFlag',COUNT(__d18(__NL(Purch_History_Flag_))),COUNT(__d18(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAmt',COUNT(__d18(__NL(Purch_New_Amt_))),COUNT(__d18(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchTotal',COUNT(__d18(__NL(Purch_Total_))),COUNT(__d18(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchCount',COUNT(__d18(__NL(Purch_Count_))),COUNT(__d18(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAgeMonths',COUNT(__d18(__NL(Purch_New_Age_Months_))),COUNT(__d18(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchOldAgeMonths',COUNT(__d18(__NL(Purch_Old_Age_Months_))),COUNT(__d18(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchItemCount',COUNT(__d18(__NL(Purch_Item_Count_))),COUNT(__d18(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchAmtAvg',COUNT(__d18(__NL(Purch_Amt_Avg_))),COUNT(__d18(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHuntFish',COUNT(__d18(__NL(Is_Hunt_Fish_))),COUNT(__d18(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsCCW',COUNT(__d18(__NL(Is_C_C_W_))),COUNT(__d18(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PermitNumber',COUNT(__d18(__NL(Permit_Number_))),COUNT(__d18(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponPermitsType',COUNT(__d18(__NL(Weapon_Permits_Type_))),COUNT(__d18(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponRegistrationDate',COUNT(__d18(__NL(Weapon_Registration_Date_))),COUNT(__d18(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','WeaponExpirationDate',COUNT(__d18(__NL(Weapon_Expiration_Date_))),COUNT(__d18(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseDate',COUNT(__d18(__NL(License_Date_))),COUNT(__d18(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HomeState',COUNT(__d18(__NL(Home_State_))),COUNT(__d18(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceState',COUNT(__d18(__NL(Source_State_))),COUNT(__d18(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsResident',COUNT(__d18(__NL(Is_Resident_))),COUNT(__d18(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsHunting',COUNT(__d18(__NL(Is_Hunting_))),COUNT(__d18(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsFishing',COUNT(__d18(__NL(Is_Fishing_))),COUNT(__d18(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementID',COUNT(__d18(__NL(Statement_I_D_))),COUNT(__d18(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatementType',COUNT(__d18(__NL(Statement_Type_))),COUNT(__d18(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DataGroup',COUNT(__d18(__NL(Data_Group_))),COUNT(__d18(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Content',COUNT(__d18(__NL(Content_))),COUNT(__d18(__NN(Content_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CorrectedFlag',COUNT(__d18(__NL(Corrected_Flag_))),COUNT(__d18(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConsumerStatementFlag',COUNT(__d18(__NL(Consumer_Statement_Flag_))),COUNT(__d18(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DisputeFlag',COUNT(__d18(__NL(Dispute_Flag_))),COUNT(__d18(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityFreeze',COUNT(__d18(__NL(Security_Freeze_))),COUNT(__d18(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecurityAlert',COUNT(__d18(__NL(Security_Alert_))),COUNT(__d18(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NegativeAlert',COUNT(__d18(__NL(Negative_Alert_))),COUNT(__d18(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IDTheftFlag',COUNT(__d18(__NL(I_D_Theft_Flag_))),COUNT(__d18(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegalHoldAlert',COUNT(__d18(__NL(Legal_Hold_Alert_))),COUNT(__d18(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThriveDateFirstSeen',COUNT(__d18(__NL(Thrive_Date_First_Seen_))),COUNT(__d18(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Employer',COUNT(__d18(__NL(Employer_))),COUNT(__d18(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PayFrequency',COUNT(__d18(__NL(Pay_Frequency_))),COUNT(__d18(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Income',COUNT(__d18(__NL(Income_))),COUNT(__d18(__NN(Income_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameScore',COUNT(__d18(__NL(Name_Score_))),COUNT(__d18(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d18(Archive___Date_=0)),COUNT(__d18(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d18(Date_First_Seen_=0)),COUNT(__d18(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d18(Date_Last_Seen_=0)),COUNT(__d18(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d18(Hybrid_Archive_Date_=0)),COUNT(__d18(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d18(Vault_Date_Last_Seen_=0)),COUNT(__d18(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
