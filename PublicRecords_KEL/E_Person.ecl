//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_Person(CFG_Compile __cfg = CFG_Compile) := MODULE
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
  SHARED __Mapping := 'lexid(DEFAULT:UID),title(DEFAULT:Title_),firstname(DEFAULT:First_Name_),middlename(DEFAULT:Middle_Name_),lastname(DEFAULT:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),source(DEFAULT:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'did(OVERRIDE:UID),title(OVERRIDE:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dod(OVERRIDE:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_0Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d0_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault((UNSIGNED)did != 0);
  EXPORT PublicRecords_KEL_Files_NonFCRA_Doxie__Key_Header_Vault_Invalid := __d0_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d0_Prefiltered := __d0_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault'),__Mapping0_Transform(LEFT)));
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'did(OVERRIDE:UID),title(OVERRIDE:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_1Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d1_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault((UNSIGNED)did != 0);
  EXPORT PublicRecords_KEL_Files_NonFCRA_Header_Quick__Key_Did_Vault_Invalid := __d1_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d1_Prefiltered := __d1_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault'),__Mapping1_Transform(LEFT)));
  SHARED __Mapping2 := 'l_did(OVERRIDE:UID),title(DEFAULT:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob8(OVERRIDE:Date_Of_Birth_:DATE),dod8(OVERRIDE:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping2_Transform(InLayout __r) := TRANSFORM
    SELF.Death_Master_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d2_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault((UNSIGNED)l_did != 0);
  EXPORT PublicRecords_KEL_Files_NonFCRA_Doxie__Key_Death_MasterV2_SSA_DID_Vault_Invalid := __d2_KELfiltered((KEL.typ.uid)l_did = 0);
  SHARED __d2_Prefiltered := __d2_KELfiltered((KEL.typ.uid)l_did <> 0);
  SHARED __d2 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault'),__Mapping2_Transform(LEFT)));
  SHARED Date_Last_Seen_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping3 := 'did(OVERRIDE:UID),title(OVERRIDE:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dod(OVERRIDE:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(OVERRIDE:Race_:\'\'),race_name(OVERRIDE:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),source_code(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_3Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_3Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT PublicRecords_KEL_Files_NonFCRA_DriversV2__Key_DL_DID_Vault_Invalid := PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault((KEL.typ.uid)did = 0);
  SHARED __d3_Prefiltered := PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault((KEL.typ.uid)did <> 0);
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault'));
  SHARED Date_First_Seen_4Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Date_Last_Seen_4Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping4 := 'did(OVERRIDE:UID),title(OVERRIDE:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),name_score(OVERRIDE:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_4Rule),datelastseen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_4Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d4_KELfiltered := PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault((UNSIGNED)did <> 0);
  EXPORT PublicRecords_KEL_Files_NonFCRA_PhonesPlus_v2_Keys__Source_Level_Payload_Vault_Invalid := __d4_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d4_Prefiltered := __d4_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault'));
  SHARED Date_Last_Seen_5Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_5Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping5 := 's_did(OVERRIDE:UID),title(DEFAULT:Title_),firstname(DEFAULT:First_Name_),middlename(DEFAULT:Middle_Name_),lastname(DEFAULT:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_5Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_5Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d5_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault((UNSIGNED)s_did != 0);
  EXPORT PublicRecords_KEL_Files_NonFCRA_Header__Key_Addr_Hist_Vault_Invalid := __d5_KELfiltered((KEL.typ.uid)s_did = 0);
  SHARED __d5_Prefiltered := __d5_KELfiltered((KEL.typ.uid)s_did <> 0);
  SHARED __d5 := __SourceFilter(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault'));
  SHARED __Mapping6 := 'appended_lexid(OVERRIDE:UID),title(DEFAULT:Title_),first_name(OVERRIDE:First_Name_),middle_name(OVERRIDE:Middle_Name_),last_name(OVERRIDE:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping6_Transform(InLayout __r) := TRANSFORM
    SELF.F_D_N_Indicator_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d6_KELfiltered := PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault((unsigned)appended_lexid !=0);
  EXPORT PublicRecords_KEL_files_NonFCRA_Fraudpoint3__Key_DID_Vault_Invalid := __d6_KELfiltered((KEL.typ.uid)appended_lexid = 0);
  SHARED __d6_Prefiltered := __d6_KELfiltered((KEL.typ.uid)appended_lexid <> 0);
  SHARED __d6 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6,'PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault'),__Mapping6_Transform(LEFT)));
  SHARED __Mapping7 := 'did(OVERRIDE:UID),title(OVERRIDE:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dod(OVERRIDE:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping7_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(FALSE);
    SELF.Best_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d7_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault((UNSIGNED)did != 0);
  EXPORT PublicRecords_KEL_Files_NonFCRA_Watchdog__Key_Watchdog_Vault_Invalid := __d7_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d7_Prefiltered := __d7_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d7 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d7_Prefiltered,InLayout,__Mapping7,'PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault'),__Mapping7_Transform(LEFT)));
  SHARED Date_First_Seen_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Hybrid_Archive_Date_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping8 := 'did(OVERRIDE:UID),title(DEFAULT:Title_),firstname(DEFAULT:First_Name_),middlename(DEFAULT:Middle_Name_),lastname(DEFAULT:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(OVERRIDE:Home_State_:\'\'),source_state(OVERRIDE:Source_State_:\'\'),isresident(OVERRIDE:Is_Resident_),ishunting(OVERRIDE:Is_Hunting_),isfishing(OVERRIDE:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datelicense(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_8Rule),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_8Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping8_Transform(InLayout __r) := TRANSFORM
    SELF.Is_Hunt_Fish_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d8_KELfiltered := PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault((unsigned)did!=0);
  EXPORT PublicRecords_KEL_files_NonFCRA_EMerges__Key_HuntFish_Rid_vault_Invalid := __d8_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d8_Prefiltered := __d8_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d8 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d8_Prefiltered,InLayout,__Mapping8,'PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault'),__Mapping8_Transform(LEFT)));
  SHARED __Mapping9 := 'did(OVERRIDE:UID),title(DEFAULT:Title_),firstname(DEFAULT:First_Name_),middlename(DEFAULT:Middle_Name_),lastname(DEFAULT:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),ccwpermnum(OVERRIDE:Permit_Number_:\'\'),ccwpermtype(OVERRIDE:Weapon_Permits_Type_:\'\'),ccwregdate(OVERRIDE:Weapon_Registration_Date_:DATE),ccwexpdate(OVERRIDE:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping9_Transform(InLayout __r) := TRANSFORM
    SELF.Is_C_C_W_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d9_KELfiltered := PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault((unsigned)did!=0);
  EXPORT PublicRecords_KEL_files_NonFCRA_EMerges__key_ccw_rid_vault_Invalid := __d9_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d9_Prefiltered := __d9_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d9 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d9_Prefiltered,InLayout,__Mapping9,'PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault'),__Mapping9_Transform(LEFT)));
  SHARED Date_Last_Seen_10Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping10 := 'did(OVERRIDE:UID),title(DEFAULT:Title_),firstname(DEFAULT:First_Name_),middlename(DEFAULT:Middle_Name_),lastname(DEFAULT:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),dt_first_seen(OVERRIDE:Thrive_Date_First_Seen_:DATE|OVERRIDE:Date_First_Seen_:EPOCH),employer(OVERRIDE:Employer_:\'\'),pay_frequency(OVERRIDE:Pay_Frequency_:\'\'),income(OVERRIDE:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_10Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d10_KELfiltered := PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault((UNSIGNED)did != 0);
  EXPORT PublicRecords_KEL_files_NonFCRA_Thrive__Keys__Did__QA_Vault_Invalid := __d10_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d10_Prefiltered := __d10_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d10 := __SourceFilter(KEL.FromFlat.Convert(__d10_Prefiltered,InLayout,__Mapping10,'PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault'));
  SHARED __Mapping11 := 'did(OVERRIDE:UID),title(DEFAULT:Title_),firstname(DEFAULT:First_Name_),middlename(DEFAULT:Middle_Name_),lastname(DEFAULT:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),ind1(OVERRIDE:Lex_I_D_Segment_:\'\'),ind2(OVERRIDE:Lex_I_D_Segment2_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT PublicRecords_KEL_Files_NonFCRA_Header__Key_ADL_Segmentation_Vault_Invalid := PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault((KEL.typ.uid)did = 0);
  SHARED __d11_Prefiltered := PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault((KEL.typ.uid)did <> 0);
  SHARED __d11 := __SourceFilter(KEL.FromFlat.Convert(__d11_Prefiltered,InLayout,__Mapping11,'PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault'));
  SHARED Date_Last_Seen_12Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_12Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping12 := 'did(OVERRIDE:UID),title(OVERRIDE:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dod(OVERRIDE:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_12Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_12Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping12_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d12_KELfiltered := PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault((UNSIGNED)did != 0);
  EXPORT PublicRecords_KEL_Files_FCRA_Doxie__Key_FCRA_Header_Vault_Invalid := __d12_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d12_Prefiltered := __d12_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d12 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d12_Prefiltered,InLayout,__Mapping12,'PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault'),__Mapping12_Transform(LEFT)));
  SHARED Date_Last_Seen_13Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_13Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping13 := 'did(OVERRIDE:UID),title(OVERRIDE:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_13Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_13Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping13_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d13_KELfiltered := PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault((UNSIGNED)did != 0);
  EXPORT PublicRecords_KEL_Files_FCRA_Header_Quick__Key_Did_FCRA_Vault_Invalid := __d13_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d13_Prefiltered := __d13_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d13 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d13_Prefiltered,InLayout,__Mapping13,'PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault'),__Mapping13_Transform(LEFT)));
  SHARED Hybrid_Archive_Date_14Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping14 := 'did(OVERRIDE:UID),title(DEFAULT:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(OVERRIDE:Race_:\'\'),race_desc(OVERRIDE:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),fcra_date(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_14Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT PublicRecords_KEL_Files_FCRA_Doxie_Files__Key_Offenders_FCRA_Vault_1_Invalid := PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault((KEL.typ.uid)did = 0);
  SHARED __d14_Prefiltered := PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault((KEL.typ.uid)did <> 0);
  SHARED __d14 := __SourceFilter(KEL.FromFlat.Convert(__d14_Prefiltered,InLayout,__Mapping14,'PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault'));
  SHARED __Mapping15 := 'did(OVERRIDE:UID),title(DEFAULT:Title_),firstname(DEFAULT:First_Name_),middlename(DEFAULT:Middle_Name_),lastname(DEFAULT:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob_alias(OVERRIDE:Date_Of_Birth_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),fcra_date(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT PublicRecords_KEL_Files_FCRA_Doxie_Files__Key_Offenders_FCRA_Vault_2_Invalid := PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault((KEL.typ.uid)did = 0);
  SHARED __d15_Prefiltered := PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault((KEL.typ.uid)did <> 0);
  SHARED __d15 := __SourceFilter(KEL.FromFlat.Convert(__d15_Prefiltered,InLayout,__Mapping15,'PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault'));
  SHARED Date_Last_Seen_16Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Hybrid_Archive_Date_16Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping16 := 's_did(OVERRIDE:UID),title(DEFAULT:Title_),firstname(DEFAULT:First_Name_),middlename(DEFAULT:Middle_Name_),lastname(DEFAULT:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_16Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_16Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d16_KELfiltered := PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault((UNSIGNED)s_did != 0);
  EXPORT PublicRecords_KEL_Files_FCRA_Header__Key_Addr_Hist_Vault_Invalid := __d16_KELfiltered((KEL.typ.uid)s_did = 0);
  SHARED __d16_Prefiltered := __d16_KELfiltered((KEL.typ.uid)s_did <> 0);
  SHARED __d16 := __SourceFilter(KEL.FromFlat.Convert(__d16_Prefiltered,InLayout,__Mapping16,'PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault'));
  SHARED __Mapping17 := 'did(OVERRIDE:UID),title(OVERRIDE:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dod(OVERRIDE:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping17_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(FALSE);
    SELF.Best_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d17_KELfiltered := PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault((UNSIGNED)did != 0);
  EXPORT PublicRecords_KEL_Files_FCRA_Watchdog__Key_Watchdog_FCRA_nonEN_Vault_Invalid := __d17_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d17_Prefiltered := __d17_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d17 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d17_Prefiltered,InLayout,__Mapping17,'PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault'),__Mapping17_Transform(LEFT)));
  SHARED __Mapping18 := 'did(OVERRIDE:UID),title(OVERRIDE:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dod(OVERRIDE:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping18_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(FALSE);
    SELF.Best_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d18_KELfiltered := PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault((UNSIGNED)did != 0);
  EXPORT PublicRecords_KEL_Files_FCRA_Watchdog__Key_Watchdog_FCRA_nonEQ_Vault_Invalid := __d18_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d18_Prefiltered := __d18_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d18 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d18_Prefiltered,InLayout,__Mapping18,'PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault'),__Mapping18_Transform(LEFT)));
  SHARED __Mapping19 := 'l_did(OVERRIDE:UID),title(DEFAULT:Title_),firstname(DEFAULT:First_Name_),middlename(DEFAULT:Middle_Name_),lastname(DEFAULT:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dob8(OVERRIDE:Date_Of_Birth_:DATE),dod8(OVERRIDE:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),thrivedatefirstseen(DEFAULT:Thrive_Date_First_Seen_:DATE),employer(DEFAULT:Employer_:\'\'),payfrequency(DEFAULT:Pay_Frequency_:\'\'),income(DEFAULT:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping19_Transform(InLayout __r) := TRANSFORM
    SELF.Death_Master_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  EXPORT __d19_KELfiltered := PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault((l_did) != 0);
  EXPORT PublicRecords_KEL_files_FCRA_Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault_Invalid := __d19_KELfiltered((KEL.typ.uid)l_did = 0);
  SHARED __d19_Prefiltered := __d19_KELfiltered((KEL.typ.uid)l_did <> 0);
  SHARED __d19 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d19_Prefiltered,InLayout,__Mapping19,'PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault'),__Mapping19_Transform(LEFT)));
  SHARED Date_Last_Seen_20Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping20 := 'did(OVERRIDE:UID),title(DEFAULT:Title_),firstname(DEFAULT:First_Name_),middlename(DEFAULT:Middle_Name_),lastname(DEFAULT:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),lexidsegment2(DEFAULT:Lex_I_D_Segment2_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),best(DEFAULT:Best_),fdnindicator(DEFAULT:F_D_N_Indicator_),deathmasterflag(DEFAULT:Death_Master_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),ishuntfish(DEFAULT:Is_Hunt_Fish_),isccw(DEFAULT:Is_C_C_W_),permitnumber(DEFAULT:Permit_Number_:\'\'),weaponpermitstype(DEFAULT:Weapon_Permits_Type_:\'\'),weaponregistrationdate(DEFAULT:Weapon_Registration_Date_:DATE),weaponexpirationdate(DEFAULT:Weapon_Expiration_Date_:DATE),licensedate(DEFAULT:License_Date_:DATE),homestate(DEFAULT:Home_State_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),isresident(DEFAULT:Is_Resident_),ishunting(DEFAULT:Is_Hunting_),isfishing(DEFAULT:Is_Fishing_),statementid(DEFAULT:Statement_I_D_:0),statementtype(DEFAULT:Statement_Type_:\'\'),datagroup(DEFAULT:Data_Group_:\'\'),content(DEFAULT:Content_:\'\'),correctedflag(DEFAULT:Corrected_Flag_),consumerstatementflag(DEFAULT:Consumer_Statement_Flag_),disputeflag(DEFAULT:Dispute_Flag_),securityfreeze(DEFAULT:Security_Freeze_),securityalert(DEFAULT:Security_Alert_),negativealert(DEFAULT:Negative_Alert_),idtheftflag(DEFAULT:I_D_Theft_Flag_),legalholdalert(DEFAULT:Legal_Hold_Alert_),dt_first_seen(OVERRIDE:Thrive_Date_First_Seen_:DATE|OVERRIDE:Date_First_Seen_:EPOCH),employer(OVERRIDE:Employer_:\'\'),pay_frequency(OVERRIDE:Pay_Frequency_:\'\'),income(OVERRIDE:Income_:0),namescore(DEFAULT:Name_Score_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_20Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d20_KELfiltered := PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault((UNSIGNED)did != 0);
  EXPORT PublicRecords_KEL_files_FCRA_Thrive__Keys__Did_fcra__QA_Vault_Invalid := __d20_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d20_Prefiltered := __d20_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d20 := __SourceFilter(KEL.FromFlat.Convert(__d20_Prefiltered,InLayout,__Mapping20,'PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6 + __d7 + __d8 + __d9 + __d10 + __d11 + __d12 + __d13 + __d14 + __d15 + __d16 + __d17 + __d18 + __d19 + __d20;
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
    SELF.Reported_Dates_Of_Birth_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Date_Of_Birth_,Header_Hit_Flag_,Best_},Date_Of_Birth_,Header_Hit_Flag_,Best_),Reported_Dates_Of_Birth_Layout)(__NN(Date_Of_Birth_) OR __NN(Header_Hit_Flag_) OR __NN(Best_)));
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
    SELF.Reported_Dates_Of_Birth_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Reported_Dates_Of_Birth_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Date_Of_Birth_) OR __NN(Header_Hit_Flag_) OR __NN(Best_)));
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
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_Files_NonFCRA_Doxie__Key_Header_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_Header_Quick__Key_Did_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_Doxie__Key_Death_MasterV2_SSA_DID_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_DriversV2__Key_DL_DID_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_PhonesPlus_v2_Keys__Source_Level_Payload_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_Header__Key_Addr_Hist_Vault_Invalid),COUNT(PublicRecords_KEL_files_NonFCRA_Fraudpoint3__Key_DID_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_Watchdog__Key_Watchdog_Vault_Invalid),COUNT(PublicRecords_KEL_files_NonFCRA_EMerges__Key_HuntFish_Rid_vault_Invalid),COUNT(PublicRecords_KEL_files_NonFCRA_EMerges__key_ccw_rid_vault_Invalid),COUNT(PublicRecords_KEL_files_NonFCRA_Thrive__Keys__Did__QA_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_Header__Key_ADL_Segmentation_Vault_Invalid),COUNT(PublicRecords_KEL_Files_FCRA_Doxie__Key_FCRA_Header_Vault_Invalid),COUNT(PublicRecords_KEL_Files_FCRA_Header_Quick__Key_Did_FCRA_Vault_Invalid),COUNT(PublicRecords_KEL_Files_FCRA_Doxie_Files__Key_Offenders_FCRA_Vault_1_Invalid),COUNT(PublicRecords_KEL_Files_FCRA_Doxie_Files__Key_Offenders_FCRA_Vault_2_Invalid),COUNT(PublicRecords_KEL_Files_FCRA_Header__Key_Addr_Hist_Vault_Invalid),COUNT(PublicRecords_KEL_Files_FCRA_Watchdog__Key_Watchdog_FCRA_nonEN_Vault_Invalid),COUNT(PublicRecords_KEL_Files_FCRA_Watchdog__Key_Watchdog_FCRA_nonEQ_Vault_Invalid),COUNT(PublicRecords_KEL_files_FCRA_Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault_Invalid),COUNT(PublicRecords_KEL_files_FCRA_Thrive__Keys__Did_fcra__QA_Vault_Invalid),COUNT(Gender__SingleValue_Invalid),COUNT(Lex_I_D_Segment__SingleValue_Invalid),COUNT(Lex_I_D_Segment2__SingleValue_Invalid),COUNT(Race__SingleValue_Invalid),COUNT(Race_Description__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_Files_NonFCRA_Doxie__Key_Header_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_Header_Quick__Key_Did_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_Doxie__Key_Death_MasterV2_SSA_DID_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_DriversV2__Key_DL_DID_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_PhonesPlus_v2_Keys__Source_Level_Payload_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_Header__Key_Addr_Hist_Vault_Invalid,KEL.typ.int PublicRecords_KEL_files_NonFCRA_Fraudpoint3__Key_DID_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_Watchdog__Key_Watchdog_Vault_Invalid,KEL.typ.int PublicRecords_KEL_files_NonFCRA_EMerges__Key_HuntFish_Rid_vault_Invalid,KEL.typ.int PublicRecords_KEL_files_NonFCRA_EMerges__key_ccw_rid_vault_Invalid,KEL.typ.int PublicRecords_KEL_files_NonFCRA_Thrive__Keys__Did__QA_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_Header__Key_ADL_Segmentation_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_FCRA_Doxie__Key_FCRA_Header_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_FCRA_Header_Quick__Key_Did_FCRA_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_FCRA_Doxie_Files__Key_Offenders_FCRA_Vault_1_Invalid,KEL.typ.int PublicRecords_KEL_Files_FCRA_Doxie_Files__Key_Offenders_FCRA_Vault_2_Invalid,KEL.typ.int PublicRecords_KEL_Files_FCRA_Header__Key_Addr_Hist_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_FCRA_Watchdog__Key_Watchdog_FCRA_nonEN_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_FCRA_Watchdog__Key_Watchdog_FCRA_nonEQ_Vault_Invalid,KEL.typ.int PublicRecords_KEL_files_FCRA_Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault_Invalid,KEL.typ.int PublicRecords_KEL_files_FCRA_Thrive__Keys__Did_fcra__QA_Vault_Invalid,KEL.typ.int Gender__SingleValue_Invalid,KEL.typ.int Lex_I_D_Segment__SingleValue_Invalid,KEL.typ.int Lex_I_D_Segment2__SingleValue_Invalid,KEL.typ.int Race__SingleValue_Invalid,KEL.typ.int Race_Description__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_Doxie__Key_Header_Vault_Invalid),COUNT(__d0)},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','title',COUNT(__d0(__NL(Title_))),COUNT(__d0(__NN(Title_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','fname',COUNT(__d0(__NL(First_Name_))),COUNT(__d0(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','mname',COUNT(__d0(__NL(Middle_Name_))),COUNT(__d0(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','lname',COUNT(__d0(__NL(Last_Name_))),COUNT(__d0(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','name_suffix',COUNT(__d0(__NL(Name_Suffix_))),COUNT(__d0(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','LexIDSegment',COUNT(__d0(__NL(Lex_I_D_Segment_))),COUNT(__d0(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','LexIDSegment2',COUNT(__d0(__NL(Lex_I_D_Segment2_))),COUNT(__d0(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','dob',COUNT(__d0(__NL(Date_Of_Birth_))),COUNT(__d0(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','dod',COUNT(__d0(__NL(Date_Of_Death_))),COUNT(__d0(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','Gender',COUNT(__d0(__NL(Gender_))),COUNT(__d0(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','Race',COUNT(__d0(__NL(Race_))),COUNT(__d0(__NN(Race_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','RaceDescription',COUNT(__d0(__NL(Race_Description_))),COUNT(__d0(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','Best',COUNT(__d0(__NL(Best_))),COUNT(__d0(__NN(Best_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','FDNIndicator',COUNT(__d0(__NL(F_D_N_Indicator_))),COUNT(__d0(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','DeathMasterFlag',COUNT(__d0(__NL(Death_Master_Flag_))),COUNT(__d0(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','PurchProcessDate',COUNT(__d0(__NL(Purch_Process_Date_))),COUNT(__d0(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','PurchHistoryFlag',COUNT(__d0(__NL(Purch_History_Flag_))),COUNT(__d0(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','PurchNewAmt',COUNT(__d0(__NL(Purch_New_Amt_))),COUNT(__d0(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','PurchTotal',COUNT(__d0(__NL(Purch_Total_))),COUNT(__d0(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','PurchCount',COUNT(__d0(__NL(Purch_Count_))),COUNT(__d0(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','PurchNewAgeMonths',COUNT(__d0(__NL(Purch_New_Age_Months_))),COUNT(__d0(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','PurchOldAgeMonths',COUNT(__d0(__NL(Purch_Old_Age_Months_))),COUNT(__d0(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','PurchItemCount',COUNT(__d0(__NL(Purch_Item_Count_))),COUNT(__d0(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','PurchAmtAvg',COUNT(__d0(__NL(Purch_Amt_Avg_))),COUNT(__d0(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','IsHuntFish',COUNT(__d0(__NL(Is_Hunt_Fish_))),COUNT(__d0(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','IsCCW',COUNT(__d0(__NL(Is_C_C_W_))),COUNT(__d0(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','PermitNumber',COUNT(__d0(__NL(Permit_Number_))),COUNT(__d0(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','WeaponPermitsType',COUNT(__d0(__NL(Weapon_Permits_Type_))),COUNT(__d0(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','WeaponRegistrationDate',COUNT(__d0(__NL(Weapon_Registration_Date_))),COUNT(__d0(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','WeaponExpirationDate',COUNT(__d0(__NL(Weapon_Expiration_Date_))),COUNT(__d0(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','LicenseDate',COUNT(__d0(__NL(License_Date_))),COUNT(__d0(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','HomeState',COUNT(__d0(__NL(Home_State_))),COUNT(__d0(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','SourceState',COUNT(__d0(__NL(Source_State_))),COUNT(__d0(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','IsResident',COUNT(__d0(__NL(Is_Resident_))),COUNT(__d0(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','IsHunting',COUNT(__d0(__NL(Is_Hunting_))),COUNT(__d0(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','IsFishing',COUNT(__d0(__NL(Is_Fishing_))),COUNT(__d0(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','StatementID',COUNT(__d0(__NL(Statement_I_D_))),COUNT(__d0(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','StatementType',COUNT(__d0(__NL(Statement_Type_))),COUNT(__d0(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','DataGroup',COUNT(__d0(__NL(Data_Group_))),COUNT(__d0(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','Content',COUNT(__d0(__NL(Content_))),COUNT(__d0(__NN(Content_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','CorrectedFlag',COUNT(__d0(__NL(Corrected_Flag_))),COUNT(__d0(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','ConsumerStatementFlag',COUNT(__d0(__NL(Consumer_Statement_Flag_))),COUNT(__d0(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','DisputeFlag',COUNT(__d0(__NL(Dispute_Flag_))),COUNT(__d0(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','SecurityFreeze',COUNT(__d0(__NL(Security_Freeze_))),COUNT(__d0(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','SecurityAlert',COUNT(__d0(__NL(Security_Alert_))),COUNT(__d0(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','NegativeAlert',COUNT(__d0(__NL(Negative_Alert_))),COUNT(__d0(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','IDTheftFlag',COUNT(__d0(__NL(I_D_Theft_Flag_))),COUNT(__d0(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','LegalHoldAlert',COUNT(__d0(__NL(Legal_Hold_Alert_))),COUNT(__d0(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','ThriveDateFirstSeen',COUNT(__d0(__NL(Thrive_Date_First_Seen_))),COUNT(__d0(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','Employer',COUNT(__d0(__NL(Employer_))),COUNT(__d0(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','PayFrequency',COUNT(__d0(__NL(Pay_Frequency_))),COUNT(__d0(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','Income',COUNT(__d0(__NL(Income_))),COUNT(__d0(__NN(Income_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','NameScore',COUNT(__d0(__NL(Name_Score_))),COUNT(__d0(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Header_Vault','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_Header_Quick__Key_Did_Vault_Invalid),COUNT(__d1)},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','title',COUNT(__d1(__NL(Title_))),COUNT(__d1(__NN(Title_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','fname',COUNT(__d1(__NL(First_Name_))),COUNT(__d1(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','mname',COUNT(__d1(__NL(Middle_Name_))),COUNT(__d1(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','lname',COUNT(__d1(__NL(Last_Name_))),COUNT(__d1(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','name_suffix',COUNT(__d1(__NL(Name_Suffix_))),COUNT(__d1(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','LexIDSegment',COUNT(__d1(__NL(Lex_I_D_Segment_))),COUNT(__d1(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','LexIDSegment2',COUNT(__d1(__NL(Lex_I_D_Segment2_))),COUNT(__d1(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','dob',COUNT(__d1(__NL(Date_Of_Birth_))),COUNT(__d1(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','DateOfDeath',COUNT(__d1(__NL(Date_Of_Death_))),COUNT(__d1(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','Gender',COUNT(__d1(__NL(Gender_))),COUNT(__d1(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','Race',COUNT(__d1(__NL(Race_))),COUNT(__d1(__NN(Race_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','RaceDescription',COUNT(__d1(__NL(Race_Description_))),COUNT(__d1(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','Best',COUNT(__d1(__NL(Best_))),COUNT(__d1(__NN(Best_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','FDNIndicator',COUNT(__d1(__NL(F_D_N_Indicator_))),COUNT(__d1(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','DeathMasterFlag',COUNT(__d1(__NL(Death_Master_Flag_))),COUNT(__d1(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','PurchProcessDate',COUNT(__d1(__NL(Purch_Process_Date_))),COUNT(__d1(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','PurchHistoryFlag',COUNT(__d1(__NL(Purch_History_Flag_))),COUNT(__d1(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','PurchNewAmt',COUNT(__d1(__NL(Purch_New_Amt_))),COUNT(__d1(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','PurchTotal',COUNT(__d1(__NL(Purch_Total_))),COUNT(__d1(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','PurchCount',COUNT(__d1(__NL(Purch_Count_))),COUNT(__d1(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','PurchNewAgeMonths',COUNT(__d1(__NL(Purch_New_Age_Months_))),COUNT(__d1(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','PurchOldAgeMonths',COUNT(__d1(__NL(Purch_Old_Age_Months_))),COUNT(__d1(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','PurchItemCount',COUNT(__d1(__NL(Purch_Item_Count_))),COUNT(__d1(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','PurchAmtAvg',COUNT(__d1(__NL(Purch_Amt_Avg_))),COUNT(__d1(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','IsHuntFish',COUNT(__d1(__NL(Is_Hunt_Fish_))),COUNT(__d1(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','IsCCW',COUNT(__d1(__NL(Is_C_C_W_))),COUNT(__d1(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','PermitNumber',COUNT(__d1(__NL(Permit_Number_))),COUNT(__d1(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','WeaponPermitsType',COUNT(__d1(__NL(Weapon_Permits_Type_))),COUNT(__d1(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','WeaponRegistrationDate',COUNT(__d1(__NL(Weapon_Registration_Date_))),COUNT(__d1(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','WeaponExpirationDate',COUNT(__d1(__NL(Weapon_Expiration_Date_))),COUNT(__d1(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','LicenseDate',COUNT(__d1(__NL(License_Date_))),COUNT(__d1(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','HomeState',COUNT(__d1(__NL(Home_State_))),COUNT(__d1(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','SourceState',COUNT(__d1(__NL(Source_State_))),COUNT(__d1(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','IsResident',COUNT(__d1(__NL(Is_Resident_))),COUNT(__d1(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','IsHunting',COUNT(__d1(__NL(Is_Hunting_))),COUNT(__d1(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','IsFishing',COUNT(__d1(__NL(Is_Fishing_))),COUNT(__d1(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','StatementID',COUNT(__d1(__NL(Statement_I_D_))),COUNT(__d1(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','StatementType',COUNT(__d1(__NL(Statement_Type_))),COUNT(__d1(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','DataGroup',COUNT(__d1(__NL(Data_Group_))),COUNT(__d1(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','Content',COUNT(__d1(__NL(Content_))),COUNT(__d1(__NN(Content_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','CorrectedFlag',COUNT(__d1(__NL(Corrected_Flag_))),COUNT(__d1(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','ConsumerStatementFlag',COUNT(__d1(__NL(Consumer_Statement_Flag_))),COUNT(__d1(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','DisputeFlag',COUNT(__d1(__NL(Dispute_Flag_))),COUNT(__d1(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','SecurityFreeze',COUNT(__d1(__NL(Security_Freeze_))),COUNT(__d1(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','SecurityAlert',COUNT(__d1(__NL(Security_Alert_))),COUNT(__d1(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','NegativeAlert',COUNT(__d1(__NL(Negative_Alert_))),COUNT(__d1(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','IDTheftFlag',COUNT(__d1(__NL(I_D_Theft_Flag_))),COUNT(__d1(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','LegalHoldAlert',COUNT(__d1(__NL(Legal_Hold_Alert_))),COUNT(__d1(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','ThriveDateFirstSeen',COUNT(__d1(__NL(Thrive_Date_First_Seen_))),COUNT(__d1(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','Employer',COUNT(__d1(__NL(Employer_))),COUNT(__d1(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','PayFrequency',COUNT(__d1(__NL(Pay_Frequency_))),COUNT(__d1(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','Income',COUNT(__d1(__NL(Income_))),COUNT(__d1(__NN(Income_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','NameScore',COUNT(__d1(__NL(Name_Score_))),COUNT(__d1(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header_Quick__Key_Did_Vault','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_Doxie__Key_Death_MasterV2_SSA_DID_Vault_Invalid),COUNT(__d2)},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','Title',COUNT(__d2(__NL(Title_))),COUNT(__d2(__NN(Title_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','fname',COUNT(__d2(__NL(First_Name_))),COUNT(__d2(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','mname',COUNT(__d2(__NL(Middle_Name_))),COUNT(__d2(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','lname',COUNT(__d2(__NL(Last_Name_))),COUNT(__d2(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','name_suffix',COUNT(__d2(__NL(Name_Suffix_))),COUNT(__d2(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','LexIDSegment',COUNT(__d2(__NL(Lex_I_D_Segment_))),COUNT(__d2(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','LexIDSegment2',COUNT(__d2(__NL(Lex_I_D_Segment2_))),COUNT(__d2(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','dob8',COUNT(__d2(__NL(Date_Of_Birth_))),COUNT(__d2(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','dod8',COUNT(__d2(__NL(Date_Of_Death_))),COUNT(__d2(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','Gender',COUNT(__d2(__NL(Gender_))),COUNT(__d2(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','Race',COUNT(__d2(__NL(Race_))),COUNT(__d2(__NN(Race_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','RaceDescription',COUNT(__d2(__NL(Race_Description_))),COUNT(__d2(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','HeaderHitFlag',COUNT(__d2(__NL(Header_Hit_Flag_))),COUNT(__d2(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','Best',COUNT(__d2(__NL(Best_))),COUNT(__d2(__NN(Best_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','FDNIndicator',COUNT(__d2(__NL(F_D_N_Indicator_))),COUNT(__d2(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','PurchProcessDate',COUNT(__d2(__NL(Purch_Process_Date_))),COUNT(__d2(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','PurchHistoryFlag',COUNT(__d2(__NL(Purch_History_Flag_))),COUNT(__d2(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','PurchNewAmt',COUNT(__d2(__NL(Purch_New_Amt_))),COUNT(__d2(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','PurchTotal',COUNT(__d2(__NL(Purch_Total_))),COUNT(__d2(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','PurchCount',COUNT(__d2(__NL(Purch_Count_))),COUNT(__d2(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','PurchNewAgeMonths',COUNT(__d2(__NL(Purch_New_Age_Months_))),COUNT(__d2(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','PurchOldAgeMonths',COUNT(__d2(__NL(Purch_Old_Age_Months_))),COUNT(__d2(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','PurchItemCount',COUNT(__d2(__NL(Purch_Item_Count_))),COUNT(__d2(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','PurchAmtAvg',COUNT(__d2(__NL(Purch_Amt_Avg_))),COUNT(__d2(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','IsHuntFish',COUNT(__d2(__NL(Is_Hunt_Fish_))),COUNT(__d2(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','IsCCW',COUNT(__d2(__NL(Is_C_C_W_))),COUNT(__d2(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','PermitNumber',COUNT(__d2(__NL(Permit_Number_))),COUNT(__d2(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','WeaponPermitsType',COUNT(__d2(__NL(Weapon_Permits_Type_))),COUNT(__d2(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','WeaponRegistrationDate',COUNT(__d2(__NL(Weapon_Registration_Date_))),COUNT(__d2(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','WeaponExpirationDate',COUNT(__d2(__NL(Weapon_Expiration_Date_))),COUNT(__d2(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','LicenseDate',COUNT(__d2(__NL(License_Date_))),COUNT(__d2(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','HomeState',COUNT(__d2(__NL(Home_State_))),COUNT(__d2(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','SourceState',COUNT(__d2(__NL(Source_State_))),COUNT(__d2(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','IsResident',COUNT(__d2(__NL(Is_Resident_))),COUNT(__d2(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','IsHunting',COUNT(__d2(__NL(Is_Hunting_))),COUNT(__d2(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','IsFishing',COUNT(__d2(__NL(Is_Fishing_))),COUNT(__d2(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','StatementID',COUNT(__d2(__NL(Statement_I_D_))),COUNT(__d2(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','StatementType',COUNT(__d2(__NL(Statement_Type_))),COUNT(__d2(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','DataGroup',COUNT(__d2(__NL(Data_Group_))),COUNT(__d2(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','Content',COUNT(__d2(__NL(Content_))),COUNT(__d2(__NN(Content_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','CorrectedFlag',COUNT(__d2(__NL(Corrected_Flag_))),COUNT(__d2(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','ConsumerStatementFlag',COUNT(__d2(__NL(Consumer_Statement_Flag_))),COUNT(__d2(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','DisputeFlag',COUNT(__d2(__NL(Dispute_Flag_))),COUNT(__d2(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','SecurityFreeze',COUNT(__d2(__NL(Security_Freeze_))),COUNT(__d2(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','SecurityAlert',COUNT(__d2(__NL(Security_Alert_))),COUNT(__d2(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','NegativeAlert',COUNT(__d2(__NL(Negative_Alert_))),COUNT(__d2(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','IDTheftFlag',COUNT(__d2(__NL(I_D_Theft_Flag_))),COUNT(__d2(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','LegalHoldAlert',COUNT(__d2(__NL(Legal_Hold_Alert_))),COUNT(__d2(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','ThriveDateFirstSeen',COUNT(__d2(__NL(Thrive_Date_First_Seen_))),COUNT(__d2(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','Employer',COUNT(__d2(__NL(Employer_))),COUNT(__d2(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','PayFrequency',COUNT(__d2(__NL(Pay_Frequency_))),COUNT(__d2(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','Income',COUNT(__d2(__NL(Income_))),COUNT(__d2(__NN(Income_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','NameScore',COUNT(__d2(__NL(Name_Score_))),COUNT(__d2(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Doxie__Key_Death_MasterV2_SSA_DID_Vault','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_DriversV2__Key_DL_DID_Vault_Invalid),COUNT(__d3)},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','title',COUNT(__d3(__NL(Title_))),COUNT(__d3(__NN(Title_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','fname',COUNT(__d3(__NL(First_Name_))),COUNT(__d3(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','mname',COUNT(__d3(__NL(Middle_Name_))),COUNT(__d3(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','lname',COUNT(__d3(__NL(Last_Name_))),COUNT(__d3(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','name_suffix',COUNT(__d3(__NL(Name_Suffix_))),COUNT(__d3(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','LexIDSegment',COUNT(__d3(__NL(Lex_I_D_Segment_))),COUNT(__d3(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','LexIDSegment2',COUNT(__d3(__NL(Lex_I_D_Segment2_))),COUNT(__d3(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','dob',COUNT(__d3(__NL(Date_Of_Birth_))),COUNT(__d3(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','dod',COUNT(__d3(__NL(Date_Of_Death_))),COUNT(__d3(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','Gender',COUNT(__d3(__NL(Gender_))),COUNT(__d3(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','race',COUNT(__d3(__NL(Race_))),COUNT(__d3(__NN(Race_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','race_name',COUNT(__d3(__NL(Race_Description_))),COUNT(__d3(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','HeaderHitFlag',COUNT(__d3(__NL(Header_Hit_Flag_))),COUNT(__d3(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','Best',COUNT(__d3(__NL(Best_))),COUNT(__d3(__NN(Best_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','FDNIndicator',COUNT(__d3(__NL(F_D_N_Indicator_))),COUNT(__d3(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','DeathMasterFlag',COUNT(__d3(__NL(Death_Master_Flag_))),COUNT(__d3(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','source_code',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','PurchProcessDate',COUNT(__d3(__NL(Purch_Process_Date_))),COUNT(__d3(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','PurchHistoryFlag',COUNT(__d3(__NL(Purch_History_Flag_))),COUNT(__d3(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','PurchNewAmt',COUNT(__d3(__NL(Purch_New_Amt_))),COUNT(__d3(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','PurchTotal',COUNT(__d3(__NL(Purch_Total_))),COUNT(__d3(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','PurchCount',COUNT(__d3(__NL(Purch_Count_))),COUNT(__d3(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','PurchNewAgeMonths',COUNT(__d3(__NL(Purch_New_Age_Months_))),COUNT(__d3(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','PurchOldAgeMonths',COUNT(__d3(__NL(Purch_Old_Age_Months_))),COUNT(__d3(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','PurchItemCount',COUNT(__d3(__NL(Purch_Item_Count_))),COUNT(__d3(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','PurchAmtAvg',COUNT(__d3(__NL(Purch_Amt_Avg_))),COUNT(__d3(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','IsHuntFish',COUNT(__d3(__NL(Is_Hunt_Fish_))),COUNT(__d3(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','IsCCW',COUNT(__d3(__NL(Is_C_C_W_))),COUNT(__d3(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','PermitNumber',COUNT(__d3(__NL(Permit_Number_))),COUNT(__d3(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','WeaponPermitsType',COUNT(__d3(__NL(Weapon_Permits_Type_))),COUNT(__d3(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','WeaponRegistrationDate',COUNT(__d3(__NL(Weapon_Registration_Date_))),COUNT(__d3(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','WeaponExpirationDate',COUNT(__d3(__NL(Weapon_Expiration_Date_))),COUNT(__d3(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','LicenseDate',COUNT(__d3(__NL(License_Date_))),COUNT(__d3(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','HomeState',COUNT(__d3(__NL(Home_State_))),COUNT(__d3(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','SourceState',COUNT(__d3(__NL(Source_State_))),COUNT(__d3(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','IsResident',COUNT(__d3(__NL(Is_Resident_))),COUNT(__d3(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','IsHunting',COUNT(__d3(__NL(Is_Hunting_))),COUNT(__d3(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','IsFishing',COUNT(__d3(__NL(Is_Fishing_))),COUNT(__d3(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','StatementID',COUNT(__d3(__NL(Statement_I_D_))),COUNT(__d3(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','StatementType',COUNT(__d3(__NL(Statement_Type_))),COUNT(__d3(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','DataGroup',COUNT(__d3(__NL(Data_Group_))),COUNT(__d3(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','Content',COUNT(__d3(__NL(Content_))),COUNT(__d3(__NN(Content_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','CorrectedFlag',COUNT(__d3(__NL(Corrected_Flag_))),COUNT(__d3(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','ConsumerStatementFlag',COUNT(__d3(__NL(Consumer_Statement_Flag_))),COUNT(__d3(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','DisputeFlag',COUNT(__d3(__NL(Dispute_Flag_))),COUNT(__d3(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','SecurityFreeze',COUNT(__d3(__NL(Security_Freeze_))),COUNT(__d3(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','SecurityAlert',COUNT(__d3(__NL(Security_Alert_))),COUNT(__d3(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','NegativeAlert',COUNT(__d3(__NL(Negative_Alert_))),COUNT(__d3(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','IDTheftFlag',COUNT(__d3(__NL(I_D_Theft_Flag_))),COUNT(__d3(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','LegalHoldAlert',COUNT(__d3(__NL(Legal_Hold_Alert_))),COUNT(__d3(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','ThriveDateFirstSeen',COUNT(__d3(__NL(Thrive_Date_First_Seen_))),COUNT(__d3(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','Employer',COUNT(__d3(__NL(Employer_))),COUNT(__d3(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','PayFrequency',COUNT(__d3(__NL(Pay_Frequency_))),COUNT(__d3(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','Income',COUNT(__d3(__NL(Income_))),COUNT(__d3(__NN(Income_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','NameScore',COUNT(__d3(__NL(Name_Score_))),COUNT(__d3(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','HybridArchiveDate',COUNT(__d3(Hybrid_Archive_Date_=0)),COUNT(__d3(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.DriversV2__Key_DL_DID_Vault','VaultDateLastSeen',COUNT(__d3(Vault_Date_Last_Seen_=0)),COUNT(__d3(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_PhonesPlus_v2_Keys__Source_Level_Payload_Vault_Invalid),COUNT(__d4)},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','title',COUNT(__d4(__NL(Title_))),COUNT(__d4(__NN(Title_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','fname',COUNT(__d4(__NL(First_Name_))),COUNT(__d4(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','mname',COUNT(__d4(__NL(Middle_Name_))),COUNT(__d4(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','lname',COUNT(__d4(__NL(Last_Name_))),COUNT(__d4(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','name_suffix',COUNT(__d4(__NL(Name_Suffix_))),COUNT(__d4(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','LexIDSegment',COUNT(__d4(__NL(Lex_I_D_Segment_))),COUNT(__d4(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','LexIDSegment2',COUNT(__d4(__NL(Lex_I_D_Segment2_))),COUNT(__d4(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','dob',COUNT(__d4(__NL(Date_Of_Birth_))),COUNT(__d4(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','DateOfDeath',COUNT(__d4(__NL(Date_Of_Death_))),COUNT(__d4(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','Gender',COUNT(__d4(__NL(Gender_))),COUNT(__d4(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','Race',COUNT(__d4(__NL(Race_))),COUNT(__d4(__NN(Race_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','RaceDescription',COUNT(__d4(__NL(Race_Description_))),COUNT(__d4(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','HeaderHitFlag',COUNT(__d4(__NL(Header_Hit_Flag_))),COUNT(__d4(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','Best',COUNT(__d4(__NL(Best_))),COUNT(__d4(__NN(Best_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','FDNIndicator',COUNT(__d4(__NL(F_D_N_Indicator_))),COUNT(__d4(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','DeathMasterFlag',COUNT(__d4(__NL(Death_Master_Flag_))),COUNT(__d4(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','Src',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','PurchProcessDate',COUNT(__d4(__NL(Purch_Process_Date_))),COUNT(__d4(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','PurchHistoryFlag',COUNT(__d4(__NL(Purch_History_Flag_))),COUNT(__d4(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','PurchNewAmt',COUNT(__d4(__NL(Purch_New_Amt_))),COUNT(__d4(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','PurchTotal',COUNT(__d4(__NL(Purch_Total_))),COUNT(__d4(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','PurchCount',COUNT(__d4(__NL(Purch_Count_))),COUNT(__d4(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','PurchNewAgeMonths',COUNT(__d4(__NL(Purch_New_Age_Months_))),COUNT(__d4(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','PurchOldAgeMonths',COUNT(__d4(__NL(Purch_Old_Age_Months_))),COUNT(__d4(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','PurchItemCount',COUNT(__d4(__NL(Purch_Item_Count_))),COUNT(__d4(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','PurchAmtAvg',COUNT(__d4(__NL(Purch_Amt_Avg_))),COUNT(__d4(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','IsHuntFish',COUNT(__d4(__NL(Is_Hunt_Fish_))),COUNT(__d4(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','IsCCW',COUNT(__d4(__NL(Is_C_C_W_))),COUNT(__d4(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','PermitNumber',COUNT(__d4(__NL(Permit_Number_))),COUNT(__d4(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','WeaponPermitsType',COUNT(__d4(__NL(Weapon_Permits_Type_))),COUNT(__d4(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','WeaponRegistrationDate',COUNT(__d4(__NL(Weapon_Registration_Date_))),COUNT(__d4(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','WeaponExpirationDate',COUNT(__d4(__NL(Weapon_Expiration_Date_))),COUNT(__d4(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','LicenseDate',COUNT(__d4(__NL(License_Date_))),COUNT(__d4(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','HomeState',COUNT(__d4(__NL(Home_State_))),COUNT(__d4(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','SourceState',COUNT(__d4(__NL(Source_State_))),COUNT(__d4(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','IsResident',COUNT(__d4(__NL(Is_Resident_))),COUNT(__d4(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','IsHunting',COUNT(__d4(__NL(Is_Hunting_))),COUNT(__d4(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','IsFishing',COUNT(__d4(__NL(Is_Fishing_))),COUNT(__d4(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','StatementID',COUNT(__d4(__NL(Statement_I_D_))),COUNT(__d4(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','StatementType',COUNT(__d4(__NL(Statement_Type_))),COUNT(__d4(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','DataGroup',COUNT(__d4(__NL(Data_Group_))),COUNT(__d4(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','Content',COUNT(__d4(__NL(Content_))),COUNT(__d4(__NN(Content_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','CorrectedFlag',COUNT(__d4(__NL(Corrected_Flag_))),COUNT(__d4(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','ConsumerStatementFlag',COUNT(__d4(__NL(Consumer_Statement_Flag_))),COUNT(__d4(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','DisputeFlag',COUNT(__d4(__NL(Dispute_Flag_))),COUNT(__d4(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','SecurityFreeze',COUNT(__d4(__NL(Security_Freeze_))),COUNT(__d4(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','SecurityAlert',COUNT(__d4(__NL(Security_Alert_))),COUNT(__d4(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','NegativeAlert',COUNT(__d4(__NL(Negative_Alert_))),COUNT(__d4(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','IDTheftFlag',COUNT(__d4(__NL(I_D_Theft_Flag_))),COUNT(__d4(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','LegalHoldAlert',COUNT(__d4(__NL(Legal_Hold_Alert_))),COUNT(__d4(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','ThriveDateFirstSeen',COUNT(__d4(__NL(Thrive_Date_First_Seen_))),COUNT(__d4(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','Employer',COUNT(__d4(__NL(Employer_))),COUNT(__d4(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','PayFrequency',COUNT(__d4(__NL(Pay_Frequency_))),COUNT(__d4(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','Income',COUNT(__d4(__NL(Income_))),COUNT(__d4(__NN(Income_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','name_score',COUNT(__d4(__NL(Name_Score_))),COUNT(__d4(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','Archive_Date',COUNT(__d4(Archive___Date_=0)),COUNT(__d4(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','HybridArchiveDate',COUNT(__d4(Hybrid_Archive_Date_=0)),COUNT(__d4(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.PhonesPlus_v2_Keys__Source_Level_Payload_Vault','VaultDateLastSeen',COUNT(__d4(Vault_Date_Last_Seen_=0)),COUNT(__d4(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_Header__Key_Addr_Hist_Vault_Invalid),COUNT(__d5)},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','Title',COUNT(__d5(__NL(Title_))),COUNT(__d5(__NN(Title_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','FirstName',COUNT(__d5(__NL(First_Name_))),COUNT(__d5(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','MiddleName',COUNT(__d5(__NL(Middle_Name_))),COUNT(__d5(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','LastName',COUNT(__d5(__NL(Last_Name_))),COUNT(__d5(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','NameSuffix',COUNT(__d5(__NL(Name_Suffix_))),COUNT(__d5(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','LexIDSegment',COUNT(__d5(__NL(Lex_I_D_Segment_))),COUNT(__d5(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','LexIDSegment2',COUNT(__d5(__NL(Lex_I_D_Segment2_))),COUNT(__d5(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','DateOfBirth',COUNT(__d5(__NL(Date_Of_Birth_))),COUNT(__d5(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','DateOfDeath',COUNT(__d5(__NL(Date_Of_Death_))),COUNT(__d5(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','Gender',COUNT(__d5(__NL(Gender_))),COUNT(__d5(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','Race',COUNT(__d5(__NL(Race_))),COUNT(__d5(__NN(Race_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','RaceDescription',COUNT(__d5(__NL(Race_Description_))),COUNT(__d5(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','HeaderHitFlag',COUNT(__d5(__NL(Header_Hit_Flag_))),COUNT(__d5(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','Best',COUNT(__d5(__NL(Best_))),COUNT(__d5(__NN(Best_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','FDNIndicator',COUNT(__d5(__NL(F_D_N_Indicator_))),COUNT(__d5(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','DeathMasterFlag',COUNT(__d5(__NL(Death_Master_Flag_))),COUNT(__d5(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','src',COUNT(__d5(__NL(Source_))),COUNT(__d5(__NN(Source_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','PurchProcessDate',COUNT(__d5(__NL(Purch_Process_Date_))),COUNT(__d5(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','PurchHistoryFlag',COUNT(__d5(__NL(Purch_History_Flag_))),COUNT(__d5(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','PurchNewAmt',COUNT(__d5(__NL(Purch_New_Amt_))),COUNT(__d5(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','PurchTotal',COUNT(__d5(__NL(Purch_Total_))),COUNT(__d5(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','PurchCount',COUNT(__d5(__NL(Purch_Count_))),COUNT(__d5(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','PurchNewAgeMonths',COUNT(__d5(__NL(Purch_New_Age_Months_))),COUNT(__d5(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','PurchOldAgeMonths',COUNT(__d5(__NL(Purch_Old_Age_Months_))),COUNT(__d5(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','PurchItemCount',COUNT(__d5(__NL(Purch_Item_Count_))),COUNT(__d5(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','PurchAmtAvg',COUNT(__d5(__NL(Purch_Amt_Avg_))),COUNT(__d5(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','IsHuntFish',COUNT(__d5(__NL(Is_Hunt_Fish_))),COUNT(__d5(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','IsCCW',COUNT(__d5(__NL(Is_C_C_W_))),COUNT(__d5(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','PermitNumber',COUNT(__d5(__NL(Permit_Number_))),COUNT(__d5(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','WeaponPermitsType',COUNT(__d5(__NL(Weapon_Permits_Type_))),COUNT(__d5(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','WeaponRegistrationDate',COUNT(__d5(__NL(Weapon_Registration_Date_))),COUNT(__d5(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','WeaponExpirationDate',COUNT(__d5(__NL(Weapon_Expiration_Date_))),COUNT(__d5(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','LicenseDate',COUNT(__d5(__NL(License_Date_))),COUNT(__d5(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','HomeState',COUNT(__d5(__NL(Home_State_))),COUNT(__d5(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','SourceState',COUNT(__d5(__NL(Source_State_))),COUNT(__d5(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','IsResident',COUNT(__d5(__NL(Is_Resident_))),COUNT(__d5(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','IsHunting',COUNT(__d5(__NL(Is_Hunting_))),COUNT(__d5(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','IsFishing',COUNT(__d5(__NL(Is_Fishing_))),COUNT(__d5(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','StatementID',COUNT(__d5(__NL(Statement_I_D_))),COUNT(__d5(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','StatementType',COUNT(__d5(__NL(Statement_Type_))),COUNT(__d5(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','DataGroup',COUNT(__d5(__NL(Data_Group_))),COUNT(__d5(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','Content',COUNT(__d5(__NL(Content_))),COUNT(__d5(__NN(Content_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','CorrectedFlag',COUNT(__d5(__NL(Corrected_Flag_))),COUNT(__d5(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','ConsumerStatementFlag',COUNT(__d5(__NL(Consumer_Statement_Flag_))),COUNT(__d5(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','DisputeFlag',COUNT(__d5(__NL(Dispute_Flag_))),COUNT(__d5(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','SecurityFreeze',COUNT(__d5(__NL(Security_Freeze_))),COUNT(__d5(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','SecurityAlert',COUNT(__d5(__NL(Security_Alert_))),COUNT(__d5(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','NegativeAlert',COUNT(__d5(__NL(Negative_Alert_))),COUNT(__d5(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','IDTheftFlag',COUNT(__d5(__NL(I_D_Theft_Flag_))),COUNT(__d5(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','LegalHoldAlert',COUNT(__d5(__NL(Legal_Hold_Alert_))),COUNT(__d5(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','ThriveDateFirstSeen',COUNT(__d5(__NL(Thrive_Date_First_Seen_))),COUNT(__d5(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','Employer',COUNT(__d5(__NL(Employer_))),COUNT(__d5(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','PayFrequency',COUNT(__d5(__NL(Pay_Frequency_))),COUNT(__d5(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','Income',COUNT(__d5(__NL(Income_))),COUNT(__d5(__NN(Income_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','NameScore',COUNT(__d5(__NL(Name_Score_))),COUNT(__d5(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','Archive_Date',COUNT(__d5(Archive___Date_=0)),COUNT(__d5(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','HybridArchiveDate',COUNT(__d5(Hybrid_Archive_Date_=0)),COUNT(__d5(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_Addr_Hist_Vault','VaultDateLastSeen',COUNT(__d5(Vault_Date_Last_Seen_=0)),COUNT(__d5(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','UID',COUNT(PublicRecords_KEL_files_NonFCRA_Fraudpoint3__Key_DID_Vault_Invalid),COUNT(__d6)},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','Title',COUNT(__d6(__NL(Title_))),COUNT(__d6(__NN(Title_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','first_name',COUNT(__d6(__NL(First_Name_))),COUNT(__d6(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','middle_name',COUNT(__d6(__NL(Middle_Name_))),COUNT(__d6(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','last_name',COUNT(__d6(__NL(Last_Name_))),COUNT(__d6(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','NameSuffix',COUNT(__d6(__NL(Name_Suffix_))),COUNT(__d6(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','LexIDSegment',COUNT(__d6(__NL(Lex_I_D_Segment_))),COUNT(__d6(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','LexIDSegment2',COUNT(__d6(__NL(Lex_I_D_Segment2_))),COUNT(__d6(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','dob',COUNT(__d6(__NL(Date_Of_Birth_))),COUNT(__d6(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','DateOfDeath',COUNT(__d6(__NL(Date_Of_Death_))),COUNT(__d6(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','Gender',COUNT(__d6(__NL(Gender_))),COUNT(__d6(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','Race',COUNT(__d6(__NL(Race_))),COUNT(__d6(__NN(Race_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','RaceDescription',COUNT(__d6(__NL(Race_Description_))),COUNT(__d6(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','HeaderHitFlag',COUNT(__d6(__NL(Header_Hit_Flag_))),COUNT(__d6(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','Best',COUNT(__d6(__NL(Best_))),COUNT(__d6(__NN(Best_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','DeathMasterFlag',COUNT(__d6(__NL(Death_Master_Flag_))),COUNT(__d6(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','Src',COUNT(__d6(__NL(Source_))),COUNT(__d6(__NN(Source_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','PurchProcessDate',COUNT(__d6(__NL(Purch_Process_Date_))),COUNT(__d6(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','PurchHistoryFlag',COUNT(__d6(__NL(Purch_History_Flag_))),COUNT(__d6(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','PurchNewAmt',COUNT(__d6(__NL(Purch_New_Amt_))),COUNT(__d6(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','PurchTotal',COUNT(__d6(__NL(Purch_Total_))),COUNT(__d6(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','PurchCount',COUNT(__d6(__NL(Purch_Count_))),COUNT(__d6(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','PurchNewAgeMonths',COUNT(__d6(__NL(Purch_New_Age_Months_))),COUNT(__d6(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','PurchOldAgeMonths',COUNT(__d6(__NL(Purch_Old_Age_Months_))),COUNT(__d6(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','PurchItemCount',COUNT(__d6(__NL(Purch_Item_Count_))),COUNT(__d6(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','PurchAmtAvg',COUNT(__d6(__NL(Purch_Amt_Avg_))),COUNT(__d6(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','IsHuntFish',COUNT(__d6(__NL(Is_Hunt_Fish_))),COUNT(__d6(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','IsCCW',COUNT(__d6(__NL(Is_C_C_W_))),COUNT(__d6(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','PermitNumber',COUNT(__d6(__NL(Permit_Number_))),COUNT(__d6(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','WeaponPermitsType',COUNT(__d6(__NL(Weapon_Permits_Type_))),COUNT(__d6(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','WeaponRegistrationDate',COUNT(__d6(__NL(Weapon_Registration_Date_))),COUNT(__d6(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','WeaponExpirationDate',COUNT(__d6(__NL(Weapon_Expiration_Date_))),COUNT(__d6(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','LicenseDate',COUNT(__d6(__NL(License_Date_))),COUNT(__d6(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','HomeState',COUNT(__d6(__NL(Home_State_))),COUNT(__d6(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','SourceState',COUNT(__d6(__NL(Source_State_))),COUNT(__d6(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','IsResident',COUNT(__d6(__NL(Is_Resident_))),COUNT(__d6(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','IsHunting',COUNT(__d6(__NL(Is_Hunting_))),COUNT(__d6(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','IsFishing',COUNT(__d6(__NL(Is_Fishing_))),COUNT(__d6(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','StatementID',COUNT(__d6(__NL(Statement_I_D_))),COUNT(__d6(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','StatementType',COUNT(__d6(__NL(Statement_Type_))),COUNT(__d6(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','DataGroup',COUNT(__d6(__NL(Data_Group_))),COUNT(__d6(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','Content',COUNT(__d6(__NL(Content_))),COUNT(__d6(__NN(Content_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','CorrectedFlag',COUNT(__d6(__NL(Corrected_Flag_))),COUNT(__d6(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','ConsumerStatementFlag',COUNT(__d6(__NL(Consumer_Statement_Flag_))),COUNT(__d6(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','DisputeFlag',COUNT(__d6(__NL(Dispute_Flag_))),COUNT(__d6(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','SecurityFreeze',COUNT(__d6(__NL(Security_Freeze_))),COUNT(__d6(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','SecurityAlert',COUNT(__d6(__NL(Security_Alert_))),COUNT(__d6(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','NegativeAlert',COUNT(__d6(__NL(Negative_Alert_))),COUNT(__d6(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','IDTheftFlag',COUNT(__d6(__NL(I_D_Theft_Flag_))),COUNT(__d6(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','LegalHoldAlert',COUNT(__d6(__NL(Legal_Hold_Alert_))),COUNT(__d6(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','ThriveDateFirstSeen',COUNT(__d6(__NL(Thrive_Date_First_Seen_))),COUNT(__d6(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','Employer',COUNT(__d6(__NL(Employer_))),COUNT(__d6(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','PayFrequency',COUNT(__d6(__NL(Pay_Frequency_))),COUNT(__d6(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','Income',COUNT(__d6(__NL(Income_))),COUNT(__d6(__NN(Income_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','NameScore',COUNT(__d6(__NL(Name_Score_))),COUNT(__d6(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','Archive_Date',COUNT(__d6(Archive___Date_=0)),COUNT(__d6(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','HybridArchiveDate',COUNT(__d6(Hybrid_Archive_Date_=0)),COUNT(__d6(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Fraudpoint3__Key_DID_Vault','VaultDateLastSeen',COUNT(__d6(Vault_Date_Last_Seen_=0)),COUNT(__d6(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_Watchdog__Key_Watchdog_Vault_Invalid),COUNT(__d7)},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','title',COUNT(__d7(__NL(Title_))),COUNT(__d7(__NN(Title_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','fname',COUNT(__d7(__NL(First_Name_))),COUNT(__d7(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','mname',COUNT(__d7(__NL(Middle_Name_))),COUNT(__d7(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','lname',COUNT(__d7(__NL(Last_Name_))),COUNT(__d7(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','name_suffix',COUNT(__d7(__NL(Name_Suffix_))),COUNT(__d7(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','LexIDSegment',COUNT(__d7(__NL(Lex_I_D_Segment_))),COUNT(__d7(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','LexIDSegment2',COUNT(__d7(__NL(Lex_I_D_Segment2_))),COUNT(__d7(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','dob',COUNT(__d7(__NL(Date_Of_Birth_))),COUNT(__d7(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','dod',COUNT(__d7(__NL(Date_Of_Death_))),COUNT(__d7(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','Gender',COUNT(__d7(__NL(Gender_))),COUNT(__d7(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','Race',COUNT(__d7(__NL(Race_))),COUNT(__d7(__NN(Race_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','RaceDescription',COUNT(__d7(__NL(Race_Description_))),COUNT(__d7(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','FDNIndicator',COUNT(__d7(__NL(F_D_N_Indicator_))),COUNT(__d7(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','DeathMasterFlag',COUNT(__d7(__NL(Death_Master_Flag_))),COUNT(__d7(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','src',COUNT(__d7(__NL(Source_))),COUNT(__d7(__NN(Source_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','PurchProcessDate',COUNT(__d7(__NL(Purch_Process_Date_))),COUNT(__d7(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','PurchHistoryFlag',COUNT(__d7(__NL(Purch_History_Flag_))),COUNT(__d7(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','PurchNewAmt',COUNT(__d7(__NL(Purch_New_Amt_))),COUNT(__d7(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','PurchTotal',COUNT(__d7(__NL(Purch_Total_))),COUNT(__d7(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','PurchCount',COUNT(__d7(__NL(Purch_Count_))),COUNT(__d7(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','PurchNewAgeMonths',COUNT(__d7(__NL(Purch_New_Age_Months_))),COUNT(__d7(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','PurchOldAgeMonths',COUNT(__d7(__NL(Purch_Old_Age_Months_))),COUNT(__d7(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','PurchItemCount',COUNT(__d7(__NL(Purch_Item_Count_))),COUNT(__d7(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','PurchAmtAvg',COUNT(__d7(__NL(Purch_Amt_Avg_))),COUNT(__d7(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','IsHuntFish',COUNT(__d7(__NL(Is_Hunt_Fish_))),COUNT(__d7(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','IsCCW',COUNT(__d7(__NL(Is_C_C_W_))),COUNT(__d7(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','PermitNumber',COUNT(__d7(__NL(Permit_Number_))),COUNT(__d7(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','WeaponPermitsType',COUNT(__d7(__NL(Weapon_Permits_Type_))),COUNT(__d7(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','WeaponRegistrationDate',COUNT(__d7(__NL(Weapon_Registration_Date_))),COUNT(__d7(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','WeaponExpirationDate',COUNT(__d7(__NL(Weapon_Expiration_Date_))),COUNT(__d7(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','LicenseDate',COUNT(__d7(__NL(License_Date_))),COUNT(__d7(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','HomeState',COUNT(__d7(__NL(Home_State_))),COUNT(__d7(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','SourceState',COUNT(__d7(__NL(Source_State_))),COUNT(__d7(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','IsResident',COUNT(__d7(__NL(Is_Resident_))),COUNT(__d7(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','IsHunting',COUNT(__d7(__NL(Is_Hunting_))),COUNT(__d7(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','IsFishing',COUNT(__d7(__NL(Is_Fishing_))),COUNT(__d7(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','StatementID',COUNT(__d7(__NL(Statement_I_D_))),COUNT(__d7(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','StatementType',COUNT(__d7(__NL(Statement_Type_))),COUNT(__d7(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','DataGroup',COUNT(__d7(__NL(Data_Group_))),COUNT(__d7(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','Content',COUNT(__d7(__NL(Content_))),COUNT(__d7(__NN(Content_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','CorrectedFlag',COUNT(__d7(__NL(Corrected_Flag_))),COUNT(__d7(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','ConsumerStatementFlag',COUNT(__d7(__NL(Consumer_Statement_Flag_))),COUNT(__d7(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','DisputeFlag',COUNT(__d7(__NL(Dispute_Flag_))),COUNT(__d7(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','SecurityFreeze',COUNT(__d7(__NL(Security_Freeze_))),COUNT(__d7(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','SecurityAlert',COUNT(__d7(__NL(Security_Alert_))),COUNT(__d7(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','NegativeAlert',COUNT(__d7(__NL(Negative_Alert_))),COUNT(__d7(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','IDTheftFlag',COUNT(__d7(__NL(I_D_Theft_Flag_))),COUNT(__d7(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','LegalHoldAlert',COUNT(__d7(__NL(Legal_Hold_Alert_))),COUNT(__d7(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','ThriveDateFirstSeen',COUNT(__d7(__NL(Thrive_Date_First_Seen_))),COUNT(__d7(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','Employer',COUNT(__d7(__NL(Employer_))),COUNT(__d7(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','PayFrequency',COUNT(__d7(__NL(Pay_Frequency_))),COUNT(__d7(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','Income',COUNT(__d7(__NL(Income_))),COUNT(__d7(__NN(Income_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','NameScore',COUNT(__d7(__NL(Name_Score_))),COUNT(__d7(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','Archive_Date',COUNT(__d7(Archive___Date_=0)),COUNT(__d7(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','DateFirstSeen',COUNT(__d7(Date_First_Seen_=0)),COUNT(__d7(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','DateLastSeen',COUNT(__d7(Date_Last_Seen_=0)),COUNT(__d7(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','HybridArchiveDate',COUNT(__d7(Hybrid_Archive_Date_=0)),COUNT(__d7(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Watchdog__Key_Watchdog_Vault','VaultDateLastSeen',COUNT(__d7(Vault_Date_Last_Seen_=0)),COUNT(__d7(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','UID',COUNT(PublicRecords_KEL_files_NonFCRA_EMerges__Key_HuntFish_Rid_vault_Invalid),COUNT(__d8)},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','Title',COUNT(__d8(__NL(Title_))),COUNT(__d8(__NN(Title_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','FirstName',COUNT(__d8(__NL(First_Name_))),COUNT(__d8(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','MiddleName',COUNT(__d8(__NL(Middle_Name_))),COUNT(__d8(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','LastName',COUNT(__d8(__NL(Last_Name_))),COUNT(__d8(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','NameSuffix',COUNT(__d8(__NL(Name_Suffix_))),COUNT(__d8(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','LexIDSegment',COUNT(__d8(__NL(Lex_I_D_Segment_))),COUNT(__d8(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','LexIDSegment2',COUNT(__d8(__NL(Lex_I_D_Segment2_))),COUNT(__d8(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','DateOfBirth',COUNT(__d8(__NL(Date_Of_Birth_))),COUNT(__d8(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','DateOfDeath',COUNT(__d8(__NL(Date_Of_Death_))),COUNT(__d8(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','Gender',COUNT(__d8(__NL(Gender_))),COUNT(__d8(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','Race',COUNT(__d8(__NL(Race_))),COUNT(__d8(__NN(Race_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','RaceDescription',COUNT(__d8(__NL(Race_Description_))),COUNT(__d8(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','HeaderHitFlag',COUNT(__d8(__NL(Header_Hit_Flag_))),COUNT(__d8(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','Best',COUNT(__d8(__NL(Best_))),COUNT(__d8(__NN(Best_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','FDNIndicator',COUNT(__d8(__NL(F_D_N_Indicator_))),COUNT(__d8(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','DeathMasterFlag',COUNT(__d8(__NL(Death_Master_Flag_))),COUNT(__d8(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','src',COUNT(__d8(__NL(Source_))),COUNT(__d8(__NN(Source_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','PurchProcessDate',COUNT(__d8(__NL(Purch_Process_Date_))),COUNT(__d8(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','PurchHistoryFlag',COUNT(__d8(__NL(Purch_History_Flag_))),COUNT(__d8(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','PurchNewAmt',COUNT(__d8(__NL(Purch_New_Amt_))),COUNT(__d8(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','PurchTotal',COUNT(__d8(__NL(Purch_Total_))),COUNT(__d8(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','PurchCount',COUNT(__d8(__NL(Purch_Count_))),COUNT(__d8(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','PurchNewAgeMonths',COUNT(__d8(__NL(Purch_New_Age_Months_))),COUNT(__d8(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','PurchOldAgeMonths',COUNT(__d8(__NL(Purch_Old_Age_Months_))),COUNT(__d8(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','PurchItemCount',COUNT(__d8(__NL(Purch_Item_Count_))),COUNT(__d8(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','PurchAmtAvg',COUNT(__d8(__NL(Purch_Amt_Avg_))),COUNT(__d8(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','IsCCW',COUNT(__d8(__NL(Is_C_C_W_))),COUNT(__d8(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','PermitNumber',COUNT(__d8(__NL(Permit_Number_))),COUNT(__d8(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','WeaponPermitsType',COUNT(__d8(__NL(Weapon_Permits_Type_))),COUNT(__d8(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','WeaponRegistrationDate',COUNT(__d8(__NL(Weapon_Registration_Date_))),COUNT(__d8(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','WeaponExpirationDate',COUNT(__d8(__NL(Weapon_Expiration_Date_))),COUNT(__d8(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','LicenseDate',COUNT(__d8(__NL(License_Date_))),COUNT(__d8(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','homestate',COUNT(__d8(__NL(Home_State_))),COUNT(__d8(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','source_state',COUNT(__d8(__NL(Source_State_))),COUNT(__d8(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','IsResident',COUNT(__d8(__NL(Is_Resident_))),COUNT(__d8(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','IsHunting',COUNT(__d8(__NL(Is_Hunting_))),COUNT(__d8(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','IsFishing',COUNT(__d8(__NL(Is_Fishing_))),COUNT(__d8(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','StatementID',COUNT(__d8(__NL(Statement_I_D_))),COUNT(__d8(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','StatementType',COUNT(__d8(__NL(Statement_Type_))),COUNT(__d8(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','DataGroup',COUNT(__d8(__NL(Data_Group_))),COUNT(__d8(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','Content',COUNT(__d8(__NL(Content_))),COUNT(__d8(__NN(Content_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','CorrectedFlag',COUNT(__d8(__NL(Corrected_Flag_))),COUNT(__d8(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','ConsumerStatementFlag',COUNT(__d8(__NL(Consumer_Statement_Flag_))),COUNT(__d8(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','DisputeFlag',COUNT(__d8(__NL(Dispute_Flag_))),COUNT(__d8(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','SecurityFreeze',COUNT(__d8(__NL(Security_Freeze_))),COUNT(__d8(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','SecurityAlert',COUNT(__d8(__NL(Security_Alert_))),COUNT(__d8(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','NegativeAlert',COUNT(__d8(__NL(Negative_Alert_))),COUNT(__d8(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','IDTheftFlag',COUNT(__d8(__NL(I_D_Theft_Flag_))),COUNT(__d8(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','LegalHoldAlert',COUNT(__d8(__NL(Legal_Hold_Alert_))),COUNT(__d8(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','ThriveDateFirstSeen',COUNT(__d8(__NL(Thrive_Date_First_Seen_))),COUNT(__d8(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','Employer',COUNT(__d8(__NL(Employer_))),COUNT(__d8(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','PayFrequency',COUNT(__d8(__NL(Pay_Frequency_))),COUNT(__d8(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','Income',COUNT(__d8(__NL(Income_))),COUNT(__d8(__NN(Income_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','NameScore',COUNT(__d8(__NL(Name_Score_))),COUNT(__d8(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','Archive_Date',COUNT(__d8(Archive___Date_=0)),COUNT(__d8(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','DateFirstSeen',COUNT(__d8(Date_First_Seen_=0)),COUNT(__d8(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','DateLastSeen',COUNT(__d8(Date_Last_Seen_=0)),COUNT(__d8(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','HybridArchiveDate',COUNT(__d8(Hybrid_Archive_Date_=0)),COUNT(__d8(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__Key_HuntFish_Rid_vault','VaultDateLastSeen',COUNT(__d8(Vault_Date_Last_Seen_=0)),COUNT(__d8(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','UID',COUNT(PublicRecords_KEL_files_NonFCRA_EMerges__key_ccw_rid_vault_Invalid),COUNT(__d9)},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','Title',COUNT(__d9(__NL(Title_))),COUNT(__d9(__NN(Title_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','FirstName',COUNT(__d9(__NL(First_Name_))),COUNT(__d9(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','MiddleName',COUNT(__d9(__NL(Middle_Name_))),COUNT(__d9(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','LastName',COUNT(__d9(__NL(Last_Name_))),COUNT(__d9(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','NameSuffix',COUNT(__d9(__NL(Name_Suffix_))),COUNT(__d9(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','LexIDSegment',COUNT(__d9(__NL(Lex_I_D_Segment_))),COUNT(__d9(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','LexIDSegment2',COUNT(__d9(__NL(Lex_I_D_Segment2_))),COUNT(__d9(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','DateOfBirth',COUNT(__d9(__NL(Date_Of_Birth_))),COUNT(__d9(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','DateOfDeath',COUNT(__d9(__NL(Date_Of_Death_))),COUNT(__d9(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','Gender',COUNT(__d9(__NL(Gender_))),COUNT(__d9(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','Race',COUNT(__d9(__NL(Race_))),COUNT(__d9(__NN(Race_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','RaceDescription',COUNT(__d9(__NL(Race_Description_))),COUNT(__d9(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','HeaderHitFlag',COUNT(__d9(__NL(Header_Hit_Flag_))),COUNT(__d9(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','Best',COUNT(__d9(__NL(Best_))),COUNT(__d9(__NN(Best_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','FDNIndicator',COUNT(__d9(__NL(F_D_N_Indicator_))),COUNT(__d9(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','DeathMasterFlag',COUNT(__d9(__NL(Death_Master_Flag_))),COUNT(__d9(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','src',COUNT(__d9(__NL(Source_))),COUNT(__d9(__NN(Source_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','PurchProcessDate',COUNT(__d9(__NL(Purch_Process_Date_))),COUNT(__d9(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','PurchHistoryFlag',COUNT(__d9(__NL(Purch_History_Flag_))),COUNT(__d9(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','PurchNewAmt',COUNT(__d9(__NL(Purch_New_Amt_))),COUNT(__d9(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','PurchTotal',COUNT(__d9(__NL(Purch_Total_))),COUNT(__d9(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','PurchCount',COUNT(__d9(__NL(Purch_Count_))),COUNT(__d9(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','PurchNewAgeMonths',COUNT(__d9(__NL(Purch_New_Age_Months_))),COUNT(__d9(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','PurchOldAgeMonths',COUNT(__d9(__NL(Purch_Old_Age_Months_))),COUNT(__d9(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','PurchItemCount',COUNT(__d9(__NL(Purch_Item_Count_))),COUNT(__d9(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','PurchAmtAvg',COUNT(__d9(__NL(Purch_Amt_Avg_))),COUNT(__d9(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','IsHuntFish',COUNT(__d9(__NL(Is_Hunt_Fish_))),COUNT(__d9(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','ccwpermnum',COUNT(__d9(__NL(Permit_Number_))),COUNT(__d9(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','ccwpermtype',COUNT(__d9(__NL(Weapon_Permits_Type_))),COUNT(__d9(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','ccwregdate',COUNT(__d9(__NL(Weapon_Registration_Date_))),COUNT(__d9(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','ccwexpdate',COUNT(__d9(__NL(Weapon_Expiration_Date_))),COUNT(__d9(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','LicenseDate',COUNT(__d9(__NL(License_Date_))),COUNT(__d9(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','HomeState',COUNT(__d9(__NL(Home_State_))),COUNT(__d9(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','SourceState',COUNT(__d9(__NL(Source_State_))),COUNT(__d9(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','IsResident',COUNT(__d9(__NL(Is_Resident_))),COUNT(__d9(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','IsHunting',COUNT(__d9(__NL(Is_Hunting_))),COUNT(__d9(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','IsFishing',COUNT(__d9(__NL(Is_Fishing_))),COUNT(__d9(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','StatementID',COUNT(__d9(__NL(Statement_I_D_))),COUNT(__d9(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','StatementType',COUNT(__d9(__NL(Statement_Type_))),COUNT(__d9(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','DataGroup',COUNT(__d9(__NL(Data_Group_))),COUNT(__d9(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','Content',COUNT(__d9(__NL(Content_))),COUNT(__d9(__NN(Content_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','CorrectedFlag',COUNT(__d9(__NL(Corrected_Flag_))),COUNT(__d9(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','ConsumerStatementFlag',COUNT(__d9(__NL(Consumer_Statement_Flag_))),COUNT(__d9(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','DisputeFlag',COUNT(__d9(__NL(Dispute_Flag_))),COUNT(__d9(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','SecurityFreeze',COUNT(__d9(__NL(Security_Freeze_))),COUNT(__d9(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','SecurityAlert',COUNT(__d9(__NL(Security_Alert_))),COUNT(__d9(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','NegativeAlert',COUNT(__d9(__NL(Negative_Alert_))),COUNT(__d9(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','IDTheftFlag',COUNT(__d9(__NL(I_D_Theft_Flag_))),COUNT(__d9(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','LegalHoldAlert',COUNT(__d9(__NL(Legal_Hold_Alert_))),COUNT(__d9(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','ThriveDateFirstSeen',COUNT(__d9(__NL(Thrive_Date_First_Seen_))),COUNT(__d9(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','Employer',COUNT(__d9(__NL(Employer_))),COUNT(__d9(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','PayFrequency',COUNT(__d9(__NL(Pay_Frequency_))),COUNT(__d9(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','Income',COUNT(__d9(__NL(Income_))),COUNT(__d9(__NN(Income_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','NameScore',COUNT(__d9(__NL(Name_Score_))),COUNT(__d9(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','Archive_Date',COUNT(__d9(Archive___Date_=0)),COUNT(__d9(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','DateFirstSeen',COUNT(__d9(Date_First_Seen_=0)),COUNT(__d9(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','DateLastSeen',COUNT(__d9(Date_Last_Seen_=0)),COUNT(__d9(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','HybridArchiveDate',COUNT(__d9(Hybrid_Archive_Date_=0)),COUNT(__d9(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.files.NonFCRA.EMerges__key_ccw_rid_vault','VaultDateLastSeen',COUNT(__d9(Vault_Date_Last_Seen_=0)),COUNT(__d9(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','UID',COUNT(PublicRecords_KEL_files_NonFCRA_Thrive__Keys__Did__QA_Vault_Invalid),COUNT(__d10)},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','Title',COUNT(__d10(__NL(Title_))),COUNT(__d10(__NN(Title_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','FirstName',COUNT(__d10(__NL(First_Name_))),COUNT(__d10(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','MiddleName',COUNT(__d10(__NL(Middle_Name_))),COUNT(__d10(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','LastName',COUNT(__d10(__NL(Last_Name_))),COUNT(__d10(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','NameSuffix',COUNT(__d10(__NL(Name_Suffix_))),COUNT(__d10(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','LexIDSegment',COUNT(__d10(__NL(Lex_I_D_Segment_))),COUNT(__d10(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','LexIDSegment2',COUNT(__d10(__NL(Lex_I_D_Segment2_))),COUNT(__d10(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','DateOfBirth',COUNT(__d10(__NL(Date_Of_Birth_))),COUNT(__d10(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','DateOfDeath',COUNT(__d10(__NL(Date_Of_Death_))),COUNT(__d10(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','Gender',COUNT(__d10(__NL(Gender_))),COUNT(__d10(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','Race',COUNT(__d10(__NL(Race_))),COUNT(__d10(__NN(Race_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','RaceDescription',COUNT(__d10(__NL(Race_Description_))),COUNT(__d10(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','HeaderHitFlag',COUNT(__d10(__NL(Header_Hit_Flag_))),COUNT(__d10(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','Best',COUNT(__d10(__NL(Best_))),COUNT(__d10(__NN(Best_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','FDNIndicator',COUNT(__d10(__NL(F_D_N_Indicator_))),COUNT(__d10(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','DeathMasterFlag',COUNT(__d10(__NL(Death_Master_Flag_))),COUNT(__d10(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','src',COUNT(__d10(__NL(Source_))),COUNT(__d10(__NN(Source_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','PurchProcessDate',COUNT(__d10(__NL(Purch_Process_Date_))),COUNT(__d10(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','PurchHistoryFlag',COUNT(__d10(__NL(Purch_History_Flag_))),COUNT(__d10(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','PurchNewAmt',COUNT(__d10(__NL(Purch_New_Amt_))),COUNT(__d10(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','PurchTotal',COUNT(__d10(__NL(Purch_Total_))),COUNT(__d10(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','PurchCount',COUNT(__d10(__NL(Purch_Count_))),COUNT(__d10(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','PurchNewAgeMonths',COUNT(__d10(__NL(Purch_New_Age_Months_))),COUNT(__d10(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','PurchOldAgeMonths',COUNT(__d10(__NL(Purch_Old_Age_Months_))),COUNT(__d10(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','PurchItemCount',COUNT(__d10(__NL(Purch_Item_Count_))),COUNT(__d10(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','PurchAmtAvg',COUNT(__d10(__NL(Purch_Amt_Avg_))),COUNT(__d10(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','IsHuntFish',COUNT(__d10(__NL(Is_Hunt_Fish_))),COUNT(__d10(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','IsCCW',COUNT(__d10(__NL(Is_C_C_W_))),COUNT(__d10(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','PermitNumber',COUNT(__d10(__NL(Permit_Number_))),COUNT(__d10(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','WeaponPermitsType',COUNT(__d10(__NL(Weapon_Permits_Type_))),COUNT(__d10(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','WeaponRegistrationDate',COUNT(__d10(__NL(Weapon_Registration_Date_))),COUNT(__d10(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','WeaponExpirationDate',COUNT(__d10(__NL(Weapon_Expiration_Date_))),COUNT(__d10(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','LicenseDate',COUNT(__d10(__NL(License_Date_))),COUNT(__d10(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','HomeState',COUNT(__d10(__NL(Home_State_))),COUNT(__d10(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','SourceState',COUNT(__d10(__NL(Source_State_))),COUNT(__d10(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','IsResident',COUNT(__d10(__NL(Is_Resident_))),COUNT(__d10(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','IsHunting',COUNT(__d10(__NL(Is_Hunting_))),COUNT(__d10(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','IsFishing',COUNT(__d10(__NL(Is_Fishing_))),COUNT(__d10(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','StatementID',COUNT(__d10(__NL(Statement_I_D_))),COUNT(__d10(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','StatementType',COUNT(__d10(__NL(Statement_Type_))),COUNT(__d10(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','DataGroup',COUNT(__d10(__NL(Data_Group_))),COUNT(__d10(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','Content',COUNT(__d10(__NL(Content_))),COUNT(__d10(__NN(Content_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','CorrectedFlag',COUNT(__d10(__NL(Corrected_Flag_))),COUNT(__d10(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','ConsumerStatementFlag',COUNT(__d10(__NL(Consumer_Statement_Flag_))),COUNT(__d10(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','DisputeFlag',COUNT(__d10(__NL(Dispute_Flag_))),COUNT(__d10(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','SecurityFreeze',COUNT(__d10(__NL(Security_Freeze_))),COUNT(__d10(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','SecurityAlert',COUNT(__d10(__NL(Security_Alert_))),COUNT(__d10(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','NegativeAlert',COUNT(__d10(__NL(Negative_Alert_))),COUNT(__d10(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','IDTheftFlag',COUNT(__d10(__NL(I_D_Theft_Flag_))),COUNT(__d10(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','LegalHoldAlert',COUNT(__d10(__NL(Legal_Hold_Alert_))),COUNT(__d10(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','dt_first_seen',COUNT(__d10(__NL(Thrive_Date_First_Seen_))),COUNT(__d10(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','employer',COUNT(__d10(__NL(Employer_))),COUNT(__d10(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','pay_frequency',COUNT(__d10(__NL(Pay_Frequency_))),COUNT(__d10(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','income',COUNT(__d10(__NL(Income_))),COUNT(__d10(__NN(Income_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','NameScore',COUNT(__d10(__NL(Name_Score_))),COUNT(__d10(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','Archive_Date',COUNT(__d10(Archive___Date_=0)),COUNT(__d10(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','DateFirstSeen',COUNT(__d10(Date_First_Seen_=0)),COUNT(__d10(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','DateLastSeen',COUNT(__d10(Date_Last_Seen_=0)),COUNT(__d10(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','HybridArchiveDate',COUNT(__d10(Hybrid_Archive_Date_=0)),COUNT(__d10(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.files.NonFCRA.Thrive__Keys__Did__QA_Vault','VaultDateLastSeen',COUNT(__d10(Vault_Date_Last_Seen_=0)),COUNT(__d10(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_Header__Key_ADL_Segmentation_Vault_Invalid),COUNT(__d11)},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','Title',COUNT(__d11(__NL(Title_))),COUNT(__d11(__NN(Title_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','FirstName',COUNT(__d11(__NL(First_Name_))),COUNT(__d11(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','MiddleName',COUNT(__d11(__NL(Middle_Name_))),COUNT(__d11(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','LastName',COUNT(__d11(__NL(Last_Name_))),COUNT(__d11(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','NameSuffix',COUNT(__d11(__NL(Name_Suffix_))),COUNT(__d11(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','ind1',COUNT(__d11(__NL(Lex_I_D_Segment_))),COUNT(__d11(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','ind2',COUNT(__d11(__NL(Lex_I_D_Segment2_))),COUNT(__d11(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','DateOfBirth',COUNT(__d11(__NL(Date_Of_Birth_))),COUNT(__d11(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','DateOfDeath',COUNT(__d11(__NL(Date_Of_Death_))),COUNT(__d11(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','Gender',COUNT(__d11(__NL(Gender_))),COUNT(__d11(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','Race',COUNT(__d11(__NL(Race_))),COUNT(__d11(__NN(Race_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','RaceDescription',COUNT(__d11(__NL(Race_Description_))),COUNT(__d11(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','HeaderHitFlag',COUNT(__d11(__NL(Header_Hit_Flag_))),COUNT(__d11(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','Best',COUNT(__d11(__NL(Best_))),COUNT(__d11(__NN(Best_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','FDNIndicator',COUNT(__d11(__NL(F_D_N_Indicator_))),COUNT(__d11(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','DeathMasterFlag',COUNT(__d11(__NL(Death_Master_Flag_))),COUNT(__d11(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','src',COUNT(__d11(__NL(Source_))),COUNT(__d11(__NN(Source_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','PurchProcessDate',COUNT(__d11(__NL(Purch_Process_Date_))),COUNT(__d11(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','PurchHistoryFlag',COUNT(__d11(__NL(Purch_History_Flag_))),COUNT(__d11(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','PurchNewAmt',COUNT(__d11(__NL(Purch_New_Amt_))),COUNT(__d11(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','PurchTotal',COUNT(__d11(__NL(Purch_Total_))),COUNT(__d11(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','PurchCount',COUNT(__d11(__NL(Purch_Count_))),COUNT(__d11(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','PurchNewAgeMonths',COUNT(__d11(__NL(Purch_New_Age_Months_))),COUNT(__d11(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','PurchOldAgeMonths',COUNT(__d11(__NL(Purch_Old_Age_Months_))),COUNT(__d11(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','PurchItemCount',COUNT(__d11(__NL(Purch_Item_Count_))),COUNT(__d11(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','PurchAmtAvg',COUNT(__d11(__NL(Purch_Amt_Avg_))),COUNT(__d11(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','IsHuntFish',COUNT(__d11(__NL(Is_Hunt_Fish_))),COUNT(__d11(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','IsCCW',COUNT(__d11(__NL(Is_C_C_W_))),COUNT(__d11(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','PermitNumber',COUNT(__d11(__NL(Permit_Number_))),COUNT(__d11(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','WeaponPermitsType',COUNT(__d11(__NL(Weapon_Permits_Type_))),COUNT(__d11(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','WeaponRegistrationDate',COUNT(__d11(__NL(Weapon_Registration_Date_))),COUNT(__d11(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','WeaponExpirationDate',COUNT(__d11(__NL(Weapon_Expiration_Date_))),COUNT(__d11(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','LicenseDate',COUNT(__d11(__NL(License_Date_))),COUNT(__d11(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','HomeState',COUNT(__d11(__NL(Home_State_))),COUNT(__d11(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','SourceState',COUNT(__d11(__NL(Source_State_))),COUNT(__d11(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','IsResident',COUNT(__d11(__NL(Is_Resident_))),COUNT(__d11(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','IsHunting',COUNT(__d11(__NL(Is_Hunting_))),COUNT(__d11(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','IsFishing',COUNT(__d11(__NL(Is_Fishing_))),COUNT(__d11(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','StatementID',COUNT(__d11(__NL(Statement_I_D_))),COUNT(__d11(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','StatementType',COUNT(__d11(__NL(Statement_Type_))),COUNT(__d11(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','DataGroup',COUNT(__d11(__NL(Data_Group_))),COUNT(__d11(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','Content',COUNT(__d11(__NL(Content_))),COUNT(__d11(__NN(Content_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','CorrectedFlag',COUNT(__d11(__NL(Corrected_Flag_))),COUNT(__d11(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','ConsumerStatementFlag',COUNT(__d11(__NL(Consumer_Statement_Flag_))),COUNT(__d11(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','DisputeFlag',COUNT(__d11(__NL(Dispute_Flag_))),COUNT(__d11(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','SecurityFreeze',COUNT(__d11(__NL(Security_Freeze_))),COUNT(__d11(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','SecurityAlert',COUNT(__d11(__NL(Security_Alert_))),COUNT(__d11(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','NegativeAlert',COUNT(__d11(__NL(Negative_Alert_))),COUNT(__d11(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','IDTheftFlag',COUNT(__d11(__NL(I_D_Theft_Flag_))),COUNT(__d11(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','LegalHoldAlert',COUNT(__d11(__NL(Legal_Hold_Alert_))),COUNT(__d11(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','ThriveDateFirstSeen',COUNT(__d11(__NL(Thrive_Date_First_Seen_))),COUNT(__d11(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','Employer',COUNT(__d11(__NL(Employer_))),COUNT(__d11(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','PayFrequency',COUNT(__d11(__NL(Pay_Frequency_))),COUNT(__d11(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','Income',COUNT(__d11(__NL(Income_))),COUNT(__d11(__NN(Income_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','NameScore',COUNT(__d11(__NL(Name_Score_))),COUNT(__d11(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','Archive_Date',COUNT(__d11(Archive___Date_=0)),COUNT(__d11(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','DateFirstSeen',COUNT(__d11(Date_First_Seen_=0)),COUNT(__d11(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','DateLastSeen',COUNT(__d11(Date_Last_Seen_=0)),COUNT(__d11(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','HybridArchiveDate',COUNT(__d11(Hybrid_Archive_Date_=0)),COUNT(__d11(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.Files.NonFCRA.Header__Key_ADL_Segmentation_Vault','VaultDateLastSeen',COUNT(__d11(Vault_Date_Last_Seen_=0)),COUNT(__d11(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','UID',COUNT(PublicRecords_KEL_Files_FCRA_Doxie__Key_FCRA_Header_Vault_Invalid),COUNT(__d12)},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','title',COUNT(__d12(__NL(Title_))),COUNT(__d12(__NN(Title_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','fname',COUNT(__d12(__NL(First_Name_))),COUNT(__d12(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','mname',COUNT(__d12(__NL(Middle_Name_))),COUNT(__d12(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','lname',COUNT(__d12(__NL(Last_Name_))),COUNT(__d12(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','name_suffix',COUNT(__d12(__NL(Name_Suffix_))),COUNT(__d12(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','LexIDSegment',COUNT(__d12(__NL(Lex_I_D_Segment_))),COUNT(__d12(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','LexIDSegment2',COUNT(__d12(__NL(Lex_I_D_Segment2_))),COUNT(__d12(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','dob',COUNT(__d12(__NL(Date_Of_Birth_))),COUNT(__d12(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','dod',COUNT(__d12(__NL(Date_Of_Death_))),COUNT(__d12(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','Gender',COUNT(__d12(__NL(Gender_))),COUNT(__d12(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','Race',COUNT(__d12(__NL(Race_))),COUNT(__d12(__NN(Race_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','RaceDescription',COUNT(__d12(__NL(Race_Description_))),COUNT(__d12(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','Best',COUNT(__d12(__NL(Best_))),COUNT(__d12(__NN(Best_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','FDNIndicator',COUNT(__d12(__NL(F_D_N_Indicator_))),COUNT(__d12(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','DeathMasterFlag',COUNT(__d12(__NL(Death_Master_Flag_))),COUNT(__d12(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','src',COUNT(__d12(__NL(Source_))),COUNT(__d12(__NN(Source_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','PurchProcessDate',COUNT(__d12(__NL(Purch_Process_Date_))),COUNT(__d12(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','PurchHistoryFlag',COUNT(__d12(__NL(Purch_History_Flag_))),COUNT(__d12(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','PurchNewAmt',COUNT(__d12(__NL(Purch_New_Amt_))),COUNT(__d12(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','PurchTotal',COUNT(__d12(__NL(Purch_Total_))),COUNT(__d12(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','PurchCount',COUNT(__d12(__NL(Purch_Count_))),COUNT(__d12(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','PurchNewAgeMonths',COUNT(__d12(__NL(Purch_New_Age_Months_))),COUNT(__d12(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','PurchOldAgeMonths',COUNT(__d12(__NL(Purch_Old_Age_Months_))),COUNT(__d12(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','PurchItemCount',COUNT(__d12(__NL(Purch_Item_Count_))),COUNT(__d12(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','PurchAmtAvg',COUNT(__d12(__NL(Purch_Amt_Avg_))),COUNT(__d12(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','IsHuntFish',COUNT(__d12(__NL(Is_Hunt_Fish_))),COUNT(__d12(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','IsCCW',COUNT(__d12(__NL(Is_C_C_W_))),COUNT(__d12(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','PermitNumber',COUNT(__d12(__NL(Permit_Number_))),COUNT(__d12(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','WeaponPermitsType',COUNT(__d12(__NL(Weapon_Permits_Type_))),COUNT(__d12(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','WeaponRegistrationDate',COUNT(__d12(__NL(Weapon_Registration_Date_))),COUNT(__d12(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','WeaponExpirationDate',COUNT(__d12(__NL(Weapon_Expiration_Date_))),COUNT(__d12(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','LicenseDate',COUNT(__d12(__NL(License_Date_))),COUNT(__d12(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','HomeState',COUNT(__d12(__NL(Home_State_))),COUNT(__d12(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','SourceState',COUNT(__d12(__NL(Source_State_))),COUNT(__d12(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','IsResident',COUNT(__d12(__NL(Is_Resident_))),COUNT(__d12(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','IsHunting',COUNT(__d12(__NL(Is_Hunting_))),COUNT(__d12(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','IsFishing',COUNT(__d12(__NL(Is_Fishing_))),COUNT(__d12(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','StatementID',COUNT(__d12(__NL(Statement_I_D_))),COUNT(__d12(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','StatementType',COUNT(__d12(__NL(Statement_Type_))),COUNT(__d12(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','DataGroup',COUNT(__d12(__NL(Data_Group_))),COUNT(__d12(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','Content',COUNT(__d12(__NL(Content_))),COUNT(__d12(__NN(Content_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','CorrectedFlag',COUNT(__d12(__NL(Corrected_Flag_))),COUNT(__d12(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','ConsumerStatementFlag',COUNT(__d12(__NL(Consumer_Statement_Flag_))),COUNT(__d12(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','DisputeFlag',COUNT(__d12(__NL(Dispute_Flag_))),COUNT(__d12(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','SecurityFreeze',COUNT(__d12(__NL(Security_Freeze_))),COUNT(__d12(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','SecurityAlert',COUNT(__d12(__NL(Security_Alert_))),COUNT(__d12(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','NegativeAlert',COUNT(__d12(__NL(Negative_Alert_))),COUNT(__d12(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','IDTheftFlag',COUNT(__d12(__NL(I_D_Theft_Flag_))),COUNT(__d12(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','LegalHoldAlert',COUNT(__d12(__NL(Legal_Hold_Alert_))),COUNT(__d12(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','ThriveDateFirstSeen',COUNT(__d12(__NL(Thrive_Date_First_Seen_))),COUNT(__d12(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','Employer',COUNT(__d12(__NL(Employer_))),COUNT(__d12(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','PayFrequency',COUNT(__d12(__NL(Pay_Frequency_))),COUNT(__d12(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','Income',COUNT(__d12(__NL(Income_))),COUNT(__d12(__NN(Income_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','NameScore',COUNT(__d12(__NL(Name_Score_))),COUNT(__d12(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','Archive_Date',COUNT(__d12(Archive___Date_=0)),COUNT(__d12(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','DateFirstSeen',COUNT(__d12(Date_First_Seen_=0)),COUNT(__d12(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','DateLastSeen',COUNT(__d12(Date_Last_Seen_=0)),COUNT(__d12(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','HybridArchiveDate',COUNT(__d12(Hybrid_Archive_Date_=0)),COUNT(__d12(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie__Key_FCRA_Header_Vault','VaultDateLastSeen',COUNT(__d12(Vault_Date_Last_Seen_=0)),COUNT(__d12(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','UID',COUNT(PublicRecords_KEL_Files_FCRA_Header_Quick__Key_Did_FCRA_Vault_Invalid),COUNT(__d13)},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','title',COUNT(__d13(__NL(Title_))),COUNT(__d13(__NN(Title_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','fname',COUNT(__d13(__NL(First_Name_))),COUNT(__d13(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','mname',COUNT(__d13(__NL(Middle_Name_))),COUNT(__d13(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','lname',COUNT(__d13(__NL(Last_Name_))),COUNT(__d13(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','name_suffix',COUNT(__d13(__NL(Name_Suffix_))),COUNT(__d13(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','LexIDSegment',COUNT(__d13(__NL(Lex_I_D_Segment_))),COUNT(__d13(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','LexIDSegment2',COUNT(__d13(__NL(Lex_I_D_Segment2_))),COUNT(__d13(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','dob',COUNT(__d13(__NL(Date_Of_Birth_))),COUNT(__d13(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','DateOfDeath',COUNT(__d13(__NL(Date_Of_Death_))),COUNT(__d13(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','Gender',COUNT(__d13(__NL(Gender_))),COUNT(__d13(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','Race',COUNT(__d13(__NL(Race_))),COUNT(__d13(__NN(Race_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','RaceDescription',COUNT(__d13(__NL(Race_Description_))),COUNT(__d13(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','Best',COUNT(__d13(__NL(Best_))),COUNT(__d13(__NN(Best_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','FDNIndicator',COUNT(__d13(__NL(F_D_N_Indicator_))),COUNT(__d13(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','DeathMasterFlag',COUNT(__d13(__NL(Death_Master_Flag_))),COUNT(__d13(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','src',COUNT(__d13(__NL(Source_))),COUNT(__d13(__NN(Source_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','PurchProcessDate',COUNT(__d13(__NL(Purch_Process_Date_))),COUNT(__d13(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','PurchHistoryFlag',COUNT(__d13(__NL(Purch_History_Flag_))),COUNT(__d13(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','PurchNewAmt',COUNT(__d13(__NL(Purch_New_Amt_))),COUNT(__d13(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','PurchTotal',COUNT(__d13(__NL(Purch_Total_))),COUNT(__d13(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','PurchCount',COUNT(__d13(__NL(Purch_Count_))),COUNT(__d13(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','PurchNewAgeMonths',COUNT(__d13(__NL(Purch_New_Age_Months_))),COUNT(__d13(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','PurchOldAgeMonths',COUNT(__d13(__NL(Purch_Old_Age_Months_))),COUNT(__d13(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','PurchItemCount',COUNT(__d13(__NL(Purch_Item_Count_))),COUNT(__d13(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','PurchAmtAvg',COUNT(__d13(__NL(Purch_Amt_Avg_))),COUNT(__d13(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','IsHuntFish',COUNT(__d13(__NL(Is_Hunt_Fish_))),COUNT(__d13(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','IsCCW',COUNT(__d13(__NL(Is_C_C_W_))),COUNT(__d13(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','PermitNumber',COUNT(__d13(__NL(Permit_Number_))),COUNT(__d13(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','WeaponPermitsType',COUNT(__d13(__NL(Weapon_Permits_Type_))),COUNT(__d13(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','WeaponRegistrationDate',COUNT(__d13(__NL(Weapon_Registration_Date_))),COUNT(__d13(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','WeaponExpirationDate',COUNT(__d13(__NL(Weapon_Expiration_Date_))),COUNT(__d13(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','LicenseDate',COUNT(__d13(__NL(License_Date_))),COUNT(__d13(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','HomeState',COUNT(__d13(__NL(Home_State_))),COUNT(__d13(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','SourceState',COUNT(__d13(__NL(Source_State_))),COUNT(__d13(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','IsResident',COUNT(__d13(__NL(Is_Resident_))),COUNT(__d13(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','IsHunting',COUNT(__d13(__NL(Is_Hunting_))),COUNT(__d13(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','IsFishing',COUNT(__d13(__NL(Is_Fishing_))),COUNT(__d13(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','StatementID',COUNT(__d13(__NL(Statement_I_D_))),COUNT(__d13(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','StatementType',COUNT(__d13(__NL(Statement_Type_))),COUNT(__d13(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','DataGroup',COUNT(__d13(__NL(Data_Group_))),COUNT(__d13(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','Content',COUNT(__d13(__NL(Content_))),COUNT(__d13(__NN(Content_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','CorrectedFlag',COUNT(__d13(__NL(Corrected_Flag_))),COUNT(__d13(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','ConsumerStatementFlag',COUNT(__d13(__NL(Consumer_Statement_Flag_))),COUNT(__d13(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','DisputeFlag',COUNT(__d13(__NL(Dispute_Flag_))),COUNT(__d13(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','SecurityFreeze',COUNT(__d13(__NL(Security_Freeze_))),COUNT(__d13(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','SecurityAlert',COUNT(__d13(__NL(Security_Alert_))),COUNT(__d13(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','NegativeAlert',COUNT(__d13(__NL(Negative_Alert_))),COUNT(__d13(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','IDTheftFlag',COUNT(__d13(__NL(I_D_Theft_Flag_))),COUNT(__d13(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','LegalHoldAlert',COUNT(__d13(__NL(Legal_Hold_Alert_))),COUNT(__d13(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','ThriveDateFirstSeen',COUNT(__d13(__NL(Thrive_Date_First_Seen_))),COUNT(__d13(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','Employer',COUNT(__d13(__NL(Employer_))),COUNT(__d13(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','PayFrequency',COUNT(__d13(__NL(Pay_Frequency_))),COUNT(__d13(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','Income',COUNT(__d13(__NL(Income_))),COUNT(__d13(__NN(Income_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','NameScore',COUNT(__d13(__NL(Name_Score_))),COUNT(__d13(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','Archive_Date',COUNT(__d13(Archive___Date_=0)),COUNT(__d13(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','DateFirstSeen',COUNT(__d13(Date_First_Seen_=0)),COUNT(__d13(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','DateLastSeen',COUNT(__d13(Date_Last_Seen_=0)),COUNT(__d13(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','HybridArchiveDate',COUNT(__d13(Hybrid_Archive_Date_=0)),COUNT(__d13(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header_Quick__Key_Did_FCRA_Vault','VaultDateLastSeen',COUNT(__d13(Vault_Date_Last_Seen_=0)),COUNT(__d13(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','UID',COUNT(PublicRecords_KEL_Files_FCRA_Doxie_Files__Key_Offenders_FCRA_Vault_1_Invalid),COUNT(__d14)},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','Title',COUNT(__d14(__NL(Title_))),COUNT(__d14(__NN(Title_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','fname',COUNT(__d14(__NL(First_Name_))),COUNT(__d14(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','mname',COUNT(__d14(__NL(Middle_Name_))),COUNT(__d14(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','lname',COUNT(__d14(__NL(Last_Name_))),COUNT(__d14(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','name_suffix',COUNT(__d14(__NL(Name_Suffix_))),COUNT(__d14(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','LexIDSegment',COUNT(__d14(__NL(Lex_I_D_Segment_))),COUNT(__d14(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','LexIDSegment2',COUNT(__d14(__NL(Lex_I_D_Segment2_))),COUNT(__d14(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','dob',COUNT(__d14(__NL(Date_Of_Birth_))),COUNT(__d14(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','DateOfDeath',COUNT(__d14(__NL(Date_Of_Death_))),COUNT(__d14(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','Gender',COUNT(__d14(__NL(Gender_))),COUNT(__d14(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','race',COUNT(__d14(__NL(Race_))),COUNT(__d14(__NN(Race_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','race_desc',COUNT(__d14(__NL(Race_Description_))),COUNT(__d14(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','HeaderHitFlag',COUNT(__d14(__NL(Header_Hit_Flag_))),COUNT(__d14(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','Best',COUNT(__d14(__NL(Best_))),COUNT(__d14(__NN(Best_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','FDNIndicator',COUNT(__d14(__NL(F_D_N_Indicator_))),COUNT(__d14(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','DeathMasterFlag',COUNT(__d14(__NL(Death_Master_Flag_))),COUNT(__d14(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','src',COUNT(__d14(__NL(Source_))),COUNT(__d14(__NN(Source_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','PurchProcessDate',COUNT(__d14(__NL(Purch_Process_Date_))),COUNT(__d14(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','PurchHistoryFlag',COUNT(__d14(__NL(Purch_History_Flag_))),COUNT(__d14(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','PurchNewAmt',COUNT(__d14(__NL(Purch_New_Amt_))),COUNT(__d14(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','PurchTotal',COUNT(__d14(__NL(Purch_Total_))),COUNT(__d14(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','PurchCount',COUNT(__d14(__NL(Purch_Count_))),COUNT(__d14(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','PurchNewAgeMonths',COUNT(__d14(__NL(Purch_New_Age_Months_))),COUNT(__d14(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','PurchOldAgeMonths',COUNT(__d14(__NL(Purch_Old_Age_Months_))),COUNT(__d14(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','PurchItemCount',COUNT(__d14(__NL(Purch_Item_Count_))),COUNT(__d14(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','PurchAmtAvg',COUNT(__d14(__NL(Purch_Amt_Avg_))),COUNT(__d14(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','IsHuntFish',COUNT(__d14(__NL(Is_Hunt_Fish_))),COUNT(__d14(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','IsCCW',COUNT(__d14(__NL(Is_C_C_W_))),COUNT(__d14(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','PermitNumber',COUNT(__d14(__NL(Permit_Number_))),COUNT(__d14(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','WeaponPermitsType',COUNT(__d14(__NL(Weapon_Permits_Type_))),COUNT(__d14(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','WeaponRegistrationDate',COUNT(__d14(__NL(Weapon_Registration_Date_))),COUNT(__d14(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','WeaponExpirationDate',COUNT(__d14(__NL(Weapon_Expiration_Date_))),COUNT(__d14(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','LicenseDate',COUNT(__d14(__NL(License_Date_))),COUNT(__d14(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','HomeState',COUNT(__d14(__NL(Home_State_))),COUNT(__d14(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','SourceState',COUNT(__d14(__NL(Source_State_))),COUNT(__d14(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','IsResident',COUNT(__d14(__NL(Is_Resident_))),COUNT(__d14(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','IsHunting',COUNT(__d14(__NL(Is_Hunting_))),COUNT(__d14(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','IsFishing',COUNT(__d14(__NL(Is_Fishing_))),COUNT(__d14(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','StatementID',COUNT(__d14(__NL(Statement_I_D_))),COUNT(__d14(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','StatementType',COUNT(__d14(__NL(Statement_Type_))),COUNT(__d14(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','DataGroup',COUNT(__d14(__NL(Data_Group_))),COUNT(__d14(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','Content',COUNT(__d14(__NL(Content_))),COUNT(__d14(__NN(Content_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','CorrectedFlag',COUNT(__d14(__NL(Corrected_Flag_))),COUNT(__d14(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','ConsumerStatementFlag',COUNT(__d14(__NL(Consumer_Statement_Flag_))),COUNT(__d14(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','DisputeFlag',COUNT(__d14(__NL(Dispute_Flag_))),COUNT(__d14(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','SecurityFreeze',COUNT(__d14(__NL(Security_Freeze_))),COUNT(__d14(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','SecurityAlert',COUNT(__d14(__NL(Security_Alert_))),COUNT(__d14(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','NegativeAlert',COUNT(__d14(__NL(Negative_Alert_))),COUNT(__d14(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','IDTheftFlag',COUNT(__d14(__NL(I_D_Theft_Flag_))),COUNT(__d14(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','LegalHoldAlert',COUNT(__d14(__NL(Legal_Hold_Alert_))),COUNT(__d14(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','ThriveDateFirstSeen',COUNT(__d14(__NL(Thrive_Date_First_Seen_))),COUNT(__d14(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','Employer',COUNT(__d14(__NL(Employer_))),COUNT(__d14(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','PayFrequency',COUNT(__d14(__NL(Pay_Frequency_))),COUNT(__d14(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','Income',COUNT(__d14(__NL(Income_))),COUNT(__d14(__NN(Income_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','NameScore',COUNT(__d14(__NL(Name_Score_))),COUNT(__d14(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','Archive_Date',COUNT(__d14(Archive___Date_=0)),COUNT(__d14(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','DateFirstSeen',COUNT(__d14(Date_First_Seen_=0)),COUNT(__d14(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','DateLastSeen',COUNT(__d14(Date_Last_Seen_=0)),COUNT(__d14(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','HybridArchiveDate',COUNT(__d14(Hybrid_Archive_Date_=0)),COUNT(__d14(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','VaultDateLastSeen',COUNT(__d14(Vault_Date_Last_Seen_=0)),COUNT(__d14(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','UID',COUNT(PublicRecords_KEL_Files_FCRA_Doxie_Files__Key_Offenders_FCRA_Vault_2_Invalid),COUNT(__d15)},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','Title',COUNT(__d15(__NL(Title_))),COUNT(__d15(__NN(Title_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','FirstName',COUNT(__d15(__NL(First_Name_))),COUNT(__d15(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','MiddleName',COUNT(__d15(__NL(Middle_Name_))),COUNT(__d15(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','LastName',COUNT(__d15(__NL(Last_Name_))),COUNT(__d15(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','NameSuffix',COUNT(__d15(__NL(Name_Suffix_))),COUNT(__d15(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','LexIDSegment',COUNT(__d15(__NL(Lex_I_D_Segment_))),COUNT(__d15(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','LexIDSegment2',COUNT(__d15(__NL(Lex_I_D_Segment2_))),COUNT(__d15(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','dob_alias',COUNT(__d15(__NL(Date_Of_Birth_))),COUNT(__d15(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','DateOfDeath',COUNT(__d15(__NL(Date_Of_Death_))),COUNT(__d15(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','Gender',COUNT(__d15(__NL(Gender_))),COUNT(__d15(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','Race',COUNT(__d15(__NL(Race_))),COUNT(__d15(__NN(Race_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','RaceDescription',COUNT(__d15(__NL(Race_Description_))),COUNT(__d15(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','HeaderHitFlag',COUNT(__d15(__NL(Header_Hit_Flag_))),COUNT(__d15(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','Best',COUNT(__d15(__NL(Best_))),COUNT(__d15(__NN(Best_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','FDNIndicator',COUNT(__d15(__NL(F_D_N_Indicator_))),COUNT(__d15(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','DeathMasterFlag',COUNT(__d15(__NL(Death_Master_Flag_))),COUNT(__d15(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','src',COUNT(__d15(__NL(Source_))),COUNT(__d15(__NN(Source_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','PurchProcessDate',COUNT(__d15(__NL(Purch_Process_Date_))),COUNT(__d15(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','PurchHistoryFlag',COUNT(__d15(__NL(Purch_History_Flag_))),COUNT(__d15(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','PurchNewAmt',COUNT(__d15(__NL(Purch_New_Amt_))),COUNT(__d15(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','PurchTotal',COUNT(__d15(__NL(Purch_Total_))),COUNT(__d15(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','PurchCount',COUNT(__d15(__NL(Purch_Count_))),COUNT(__d15(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','PurchNewAgeMonths',COUNT(__d15(__NL(Purch_New_Age_Months_))),COUNT(__d15(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','PurchOldAgeMonths',COUNT(__d15(__NL(Purch_Old_Age_Months_))),COUNT(__d15(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','PurchItemCount',COUNT(__d15(__NL(Purch_Item_Count_))),COUNT(__d15(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','PurchAmtAvg',COUNT(__d15(__NL(Purch_Amt_Avg_))),COUNT(__d15(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','IsHuntFish',COUNT(__d15(__NL(Is_Hunt_Fish_))),COUNT(__d15(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','IsCCW',COUNT(__d15(__NL(Is_C_C_W_))),COUNT(__d15(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','PermitNumber',COUNT(__d15(__NL(Permit_Number_))),COUNT(__d15(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','WeaponPermitsType',COUNT(__d15(__NL(Weapon_Permits_Type_))),COUNT(__d15(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','WeaponRegistrationDate',COUNT(__d15(__NL(Weapon_Registration_Date_))),COUNT(__d15(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','WeaponExpirationDate',COUNT(__d15(__NL(Weapon_Expiration_Date_))),COUNT(__d15(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','LicenseDate',COUNT(__d15(__NL(License_Date_))),COUNT(__d15(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','HomeState',COUNT(__d15(__NL(Home_State_))),COUNT(__d15(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','SourceState',COUNT(__d15(__NL(Source_State_))),COUNT(__d15(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','IsResident',COUNT(__d15(__NL(Is_Resident_))),COUNT(__d15(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','IsHunting',COUNT(__d15(__NL(Is_Hunting_))),COUNT(__d15(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','IsFishing',COUNT(__d15(__NL(Is_Fishing_))),COUNT(__d15(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','StatementID',COUNT(__d15(__NL(Statement_I_D_))),COUNT(__d15(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','StatementType',COUNT(__d15(__NL(Statement_Type_))),COUNT(__d15(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','DataGroup',COUNT(__d15(__NL(Data_Group_))),COUNT(__d15(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','Content',COUNT(__d15(__NL(Content_))),COUNT(__d15(__NN(Content_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','CorrectedFlag',COUNT(__d15(__NL(Corrected_Flag_))),COUNT(__d15(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','ConsumerStatementFlag',COUNT(__d15(__NL(Consumer_Statement_Flag_))),COUNT(__d15(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','DisputeFlag',COUNT(__d15(__NL(Dispute_Flag_))),COUNT(__d15(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','SecurityFreeze',COUNT(__d15(__NL(Security_Freeze_))),COUNT(__d15(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','SecurityAlert',COUNT(__d15(__NL(Security_Alert_))),COUNT(__d15(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','NegativeAlert',COUNT(__d15(__NL(Negative_Alert_))),COUNT(__d15(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','IDTheftFlag',COUNT(__d15(__NL(I_D_Theft_Flag_))),COUNT(__d15(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','LegalHoldAlert',COUNT(__d15(__NL(Legal_Hold_Alert_))),COUNT(__d15(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','ThriveDateFirstSeen',COUNT(__d15(__NL(Thrive_Date_First_Seen_))),COUNT(__d15(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','Employer',COUNT(__d15(__NL(Employer_))),COUNT(__d15(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','PayFrequency',COUNT(__d15(__NL(Pay_Frequency_))),COUNT(__d15(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','Income',COUNT(__d15(__NL(Income_))),COUNT(__d15(__NN(Income_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','NameScore',COUNT(__d15(__NL(Name_Score_))),COUNT(__d15(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','Archive_Date',COUNT(__d15(Archive___Date_=0)),COUNT(__d15(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','DateFirstSeen',COUNT(__d15(Date_First_Seen_=0)),COUNT(__d15(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','DateLastSeen',COUNT(__d15(Date_Last_Seen_=0)),COUNT(__d15(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','HybridArchiveDate',COUNT(__d15(Hybrid_Archive_Date_=0)),COUNT(__d15(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Doxie_Files__Key_Offenders_FCRA_Vault','VaultDateLastSeen',COUNT(__d15(Vault_Date_Last_Seen_=0)),COUNT(__d15(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','UID',COUNT(PublicRecords_KEL_Files_FCRA_Header__Key_Addr_Hist_Vault_Invalid),COUNT(__d16)},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','Title',COUNT(__d16(__NL(Title_))),COUNT(__d16(__NN(Title_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','FirstName',COUNT(__d16(__NL(First_Name_))),COUNT(__d16(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','MiddleName',COUNT(__d16(__NL(Middle_Name_))),COUNT(__d16(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','LastName',COUNT(__d16(__NL(Last_Name_))),COUNT(__d16(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','NameSuffix',COUNT(__d16(__NL(Name_Suffix_))),COUNT(__d16(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','LexIDSegment',COUNT(__d16(__NL(Lex_I_D_Segment_))),COUNT(__d16(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','LexIDSegment2',COUNT(__d16(__NL(Lex_I_D_Segment2_))),COUNT(__d16(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','DateOfBirth',COUNT(__d16(__NL(Date_Of_Birth_))),COUNT(__d16(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','DateOfDeath',COUNT(__d16(__NL(Date_Of_Death_))),COUNT(__d16(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','Gender',COUNT(__d16(__NL(Gender_))),COUNT(__d16(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','Race',COUNT(__d16(__NL(Race_))),COUNT(__d16(__NN(Race_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','RaceDescription',COUNT(__d16(__NL(Race_Description_))),COUNT(__d16(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','HeaderHitFlag',COUNT(__d16(__NL(Header_Hit_Flag_))),COUNT(__d16(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','Best',COUNT(__d16(__NL(Best_))),COUNT(__d16(__NN(Best_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','FDNIndicator',COUNT(__d16(__NL(F_D_N_Indicator_))),COUNT(__d16(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','DeathMasterFlag',COUNT(__d16(__NL(Death_Master_Flag_))),COUNT(__d16(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','src',COUNT(__d16(__NL(Source_))),COUNT(__d16(__NN(Source_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','PurchProcessDate',COUNT(__d16(__NL(Purch_Process_Date_))),COUNT(__d16(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','PurchHistoryFlag',COUNT(__d16(__NL(Purch_History_Flag_))),COUNT(__d16(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','PurchNewAmt',COUNT(__d16(__NL(Purch_New_Amt_))),COUNT(__d16(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','PurchTotal',COUNT(__d16(__NL(Purch_Total_))),COUNT(__d16(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','PurchCount',COUNT(__d16(__NL(Purch_Count_))),COUNT(__d16(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','PurchNewAgeMonths',COUNT(__d16(__NL(Purch_New_Age_Months_))),COUNT(__d16(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','PurchOldAgeMonths',COUNT(__d16(__NL(Purch_Old_Age_Months_))),COUNT(__d16(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','PurchItemCount',COUNT(__d16(__NL(Purch_Item_Count_))),COUNT(__d16(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','PurchAmtAvg',COUNT(__d16(__NL(Purch_Amt_Avg_))),COUNT(__d16(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','IsHuntFish',COUNT(__d16(__NL(Is_Hunt_Fish_))),COUNT(__d16(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','IsCCW',COUNT(__d16(__NL(Is_C_C_W_))),COUNT(__d16(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','PermitNumber',COUNT(__d16(__NL(Permit_Number_))),COUNT(__d16(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','WeaponPermitsType',COUNT(__d16(__NL(Weapon_Permits_Type_))),COUNT(__d16(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','WeaponRegistrationDate',COUNT(__d16(__NL(Weapon_Registration_Date_))),COUNT(__d16(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','WeaponExpirationDate',COUNT(__d16(__NL(Weapon_Expiration_Date_))),COUNT(__d16(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','LicenseDate',COUNT(__d16(__NL(License_Date_))),COUNT(__d16(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','HomeState',COUNT(__d16(__NL(Home_State_))),COUNT(__d16(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','SourceState',COUNT(__d16(__NL(Source_State_))),COUNT(__d16(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','IsResident',COUNT(__d16(__NL(Is_Resident_))),COUNT(__d16(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','IsHunting',COUNT(__d16(__NL(Is_Hunting_))),COUNT(__d16(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','IsFishing',COUNT(__d16(__NL(Is_Fishing_))),COUNT(__d16(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','StatementID',COUNT(__d16(__NL(Statement_I_D_))),COUNT(__d16(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','StatementType',COUNT(__d16(__NL(Statement_Type_))),COUNT(__d16(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','DataGroup',COUNT(__d16(__NL(Data_Group_))),COUNT(__d16(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','Content',COUNT(__d16(__NL(Content_))),COUNT(__d16(__NN(Content_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','CorrectedFlag',COUNT(__d16(__NL(Corrected_Flag_))),COUNT(__d16(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','ConsumerStatementFlag',COUNT(__d16(__NL(Consumer_Statement_Flag_))),COUNT(__d16(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','DisputeFlag',COUNT(__d16(__NL(Dispute_Flag_))),COUNT(__d16(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','SecurityFreeze',COUNT(__d16(__NL(Security_Freeze_))),COUNT(__d16(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','SecurityAlert',COUNT(__d16(__NL(Security_Alert_))),COUNT(__d16(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','NegativeAlert',COUNT(__d16(__NL(Negative_Alert_))),COUNT(__d16(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','IDTheftFlag',COUNT(__d16(__NL(I_D_Theft_Flag_))),COUNT(__d16(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','LegalHoldAlert',COUNT(__d16(__NL(Legal_Hold_Alert_))),COUNT(__d16(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','ThriveDateFirstSeen',COUNT(__d16(__NL(Thrive_Date_First_Seen_))),COUNT(__d16(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','Employer',COUNT(__d16(__NL(Employer_))),COUNT(__d16(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','PayFrequency',COUNT(__d16(__NL(Pay_Frequency_))),COUNT(__d16(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','Income',COUNT(__d16(__NL(Income_))),COUNT(__d16(__NN(Income_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','NameScore',COUNT(__d16(__NL(Name_Score_))),COUNT(__d16(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','Archive_Date',COUNT(__d16(Archive___Date_=0)),COUNT(__d16(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','DateFirstSeen',COUNT(__d16(Date_First_Seen_=0)),COUNT(__d16(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','DateLastSeen',COUNT(__d16(Date_Last_Seen_=0)),COUNT(__d16(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','HybridArchiveDate',COUNT(__d16(Hybrid_Archive_Date_=0)),COUNT(__d16(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Header__Key_Addr_Hist_Vault','VaultDateLastSeen',COUNT(__d16(Vault_Date_Last_Seen_=0)),COUNT(__d16(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','UID',COUNT(PublicRecords_KEL_Files_FCRA_Watchdog__Key_Watchdog_FCRA_nonEN_Vault_Invalid),COUNT(__d17)},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','title',COUNT(__d17(__NL(Title_))),COUNT(__d17(__NN(Title_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','fname',COUNT(__d17(__NL(First_Name_))),COUNT(__d17(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','mname',COUNT(__d17(__NL(Middle_Name_))),COUNT(__d17(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','lname',COUNT(__d17(__NL(Last_Name_))),COUNT(__d17(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','name_suffix',COUNT(__d17(__NL(Name_Suffix_))),COUNT(__d17(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','LexIDSegment',COUNT(__d17(__NL(Lex_I_D_Segment_))),COUNT(__d17(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','LexIDSegment2',COUNT(__d17(__NL(Lex_I_D_Segment2_))),COUNT(__d17(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','dob',COUNT(__d17(__NL(Date_Of_Birth_))),COUNT(__d17(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','dod',COUNT(__d17(__NL(Date_Of_Death_))),COUNT(__d17(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','Gender',COUNT(__d17(__NL(Gender_))),COUNT(__d17(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','Race',COUNT(__d17(__NL(Race_))),COUNT(__d17(__NN(Race_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','RaceDescription',COUNT(__d17(__NL(Race_Description_))),COUNT(__d17(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','FDNIndicator',COUNT(__d17(__NL(F_D_N_Indicator_))),COUNT(__d17(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','DeathMasterFlag',COUNT(__d17(__NL(Death_Master_Flag_))),COUNT(__d17(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','src',COUNT(__d17(__NL(Source_))),COUNT(__d17(__NN(Source_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','PurchProcessDate',COUNT(__d17(__NL(Purch_Process_Date_))),COUNT(__d17(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','PurchHistoryFlag',COUNT(__d17(__NL(Purch_History_Flag_))),COUNT(__d17(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','PurchNewAmt',COUNT(__d17(__NL(Purch_New_Amt_))),COUNT(__d17(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','PurchTotal',COUNT(__d17(__NL(Purch_Total_))),COUNT(__d17(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','PurchCount',COUNT(__d17(__NL(Purch_Count_))),COUNT(__d17(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','PurchNewAgeMonths',COUNT(__d17(__NL(Purch_New_Age_Months_))),COUNT(__d17(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','PurchOldAgeMonths',COUNT(__d17(__NL(Purch_Old_Age_Months_))),COUNT(__d17(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','PurchItemCount',COUNT(__d17(__NL(Purch_Item_Count_))),COUNT(__d17(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','PurchAmtAvg',COUNT(__d17(__NL(Purch_Amt_Avg_))),COUNT(__d17(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','IsHuntFish',COUNT(__d17(__NL(Is_Hunt_Fish_))),COUNT(__d17(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','IsCCW',COUNT(__d17(__NL(Is_C_C_W_))),COUNT(__d17(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','PermitNumber',COUNT(__d17(__NL(Permit_Number_))),COUNT(__d17(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','WeaponPermitsType',COUNT(__d17(__NL(Weapon_Permits_Type_))),COUNT(__d17(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','WeaponRegistrationDate',COUNT(__d17(__NL(Weapon_Registration_Date_))),COUNT(__d17(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','WeaponExpirationDate',COUNT(__d17(__NL(Weapon_Expiration_Date_))),COUNT(__d17(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','LicenseDate',COUNT(__d17(__NL(License_Date_))),COUNT(__d17(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','HomeState',COUNT(__d17(__NL(Home_State_))),COUNT(__d17(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','SourceState',COUNT(__d17(__NL(Source_State_))),COUNT(__d17(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','IsResident',COUNT(__d17(__NL(Is_Resident_))),COUNT(__d17(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','IsHunting',COUNT(__d17(__NL(Is_Hunting_))),COUNT(__d17(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','IsFishing',COUNT(__d17(__NL(Is_Fishing_))),COUNT(__d17(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','StatementID',COUNT(__d17(__NL(Statement_I_D_))),COUNT(__d17(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','StatementType',COUNT(__d17(__NL(Statement_Type_))),COUNT(__d17(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','DataGroup',COUNT(__d17(__NL(Data_Group_))),COUNT(__d17(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','Content',COUNT(__d17(__NL(Content_))),COUNT(__d17(__NN(Content_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','CorrectedFlag',COUNT(__d17(__NL(Corrected_Flag_))),COUNT(__d17(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','ConsumerStatementFlag',COUNT(__d17(__NL(Consumer_Statement_Flag_))),COUNT(__d17(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','DisputeFlag',COUNT(__d17(__NL(Dispute_Flag_))),COUNT(__d17(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','SecurityFreeze',COUNT(__d17(__NL(Security_Freeze_))),COUNT(__d17(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','SecurityAlert',COUNT(__d17(__NL(Security_Alert_))),COUNT(__d17(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','NegativeAlert',COUNT(__d17(__NL(Negative_Alert_))),COUNT(__d17(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','IDTheftFlag',COUNT(__d17(__NL(I_D_Theft_Flag_))),COUNT(__d17(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','LegalHoldAlert',COUNT(__d17(__NL(Legal_Hold_Alert_))),COUNT(__d17(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','ThriveDateFirstSeen',COUNT(__d17(__NL(Thrive_Date_First_Seen_))),COUNT(__d17(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','Employer',COUNT(__d17(__NL(Employer_))),COUNT(__d17(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','PayFrequency',COUNT(__d17(__NL(Pay_Frequency_))),COUNT(__d17(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','Income',COUNT(__d17(__NL(Income_))),COUNT(__d17(__NN(Income_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','NameScore',COUNT(__d17(__NL(Name_Score_))),COUNT(__d17(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','Archive_Date',COUNT(__d17(Archive___Date_=0)),COUNT(__d17(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','DateFirstSeen',COUNT(__d17(Date_First_Seen_=0)),COUNT(__d17(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','DateLastSeen',COUNT(__d17(Date_Last_Seen_=0)),COUNT(__d17(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','HybridArchiveDate',COUNT(__d17(Hybrid_Archive_Date_=0)),COUNT(__d17(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEN_Vault','VaultDateLastSeen',COUNT(__d17(Vault_Date_Last_Seen_=0)),COUNT(__d17(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','UID',COUNT(PublicRecords_KEL_Files_FCRA_Watchdog__Key_Watchdog_FCRA_nonEQ_Vault_Invalid),COUNT(__d18)},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','title',COUNT(__d18(__NL(Title_))),COUNT(__d18(__NN(Title_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','fname',COUNT(__d18(__NL(First_Name_))),COUNT(__d18(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','mname',COUNT(__d18(__NL(Middle_Name_))),COUNT(__d18(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','lname',COUNT(__d18(__NL(Last_Name_))),COUNT(__d18(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','name_suffix',COUNT(__d18(__NL(Name_Suffix_))),COUNT(__d18(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','LexIDSegment',COUNT(__d18(__NL(Lex_I_D_Segment_))),COUNT(__d18(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','LexIDSegment2',COUNT(__d18(__NL(Lex_I_D_Segment2_))),COUNT(__d18(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','dob',COUNT(__d18(__NL(Date_Of_Birth_))),COUNT(__d18(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','dod',COUNT(__d18(__NL(Date_Of_Death_))),COUNT(__d18(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','Gender',COUNT(__d18(__NL(Gender_))),COUNT(__d18(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','Race',COUNT(__d18(__NL(Race_))),COUNT(__d18(__NN(Race_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','RaceDescription',COUNT(__d18(__NL(Race_Description_))),COUNT(__d18(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','FDNIndicator',COUNT(__d18(__NL(F_D_N_Indicator_))),COUNT(__d18(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','DeathMasterFlag',COUNT(__d18(__NL(Death_Master_Flag_))),COUNT(__d18(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','src',COUNT(__d18(__NL(Source_))),COUNT(__d18(__NN(Source_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','PurchProcessDate',COUNT(__d18(__NL(Purch_Process_Date_))),COUNT(__d18(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','PurchHistoryFlag',COUNT(__d18(__NL(Purch_History_Flag_))),COUNT(__d18(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','PurchNewAmt',COUNT(__d18(__NL(Purch_New_Amt_))),COUNT(__d18(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','PurchTotal',COUNT(__d18(__NL(Purch_Total_))),COUNT(__d18(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','PurchCount',COUNT(__d18(__NL(Purch_Count_))),COUNT(__d18(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','PurchNewAgeMonths',COUNT(__d18(__NL(Purch_New_Age_Months_))),COUNT(__d18(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','PurchOldAgeMonths',COUNT(__d18(__NL(Purch_Old_Age_Months_))),COUNT(__d18(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','PurchItemCount',COUNT(__d18(__NL(Purch_Item_Count_))),COUNT(__d18(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','PurchAmtAvg',COUNT(__d18(__NL(Purch_Amt_Avg_))),COUNT(__d18(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','IsHuntFish',COUNT(__d18(__NL(Is_Hunt_Fish_))),COUNT(__d18(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','IsCCW',COUNT(__d18(__NL(Is_C_C_W_))),COUNT(__d18(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','PermitNumber',COUNT(__d18(__NL(Permit_Number_))),COUNT(__d18(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','WeaponPermitsType',COUNT(__d18(__NL(Weapon_Permits_Type_))),COUNT(__d18(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','WeaponRegistrationDate',COUNT(__d18(__NL(Weapon_Registration_Date_))),COUNT(__d18(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','WeaponExpirationDate',COUNT(__d18(__NL(Weapon_Expiration_Date_))),COUNT(__d18(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','LicenseDate',COUNT(__d18(__NL(License_Date_))),COUNT(__d18(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','HomeState',COUNT(__d18(__NL(Home_State_))),COUNT(__d18(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','SourceState',COUNT(__d18(__NL(Source_State_))),COUNT(__d18(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','IsResident',COUNT(__d18(__NL(Is_Resident_))),COUNT(__d18(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','IsHunting',COUNT(__d18(__NL(Is_Hunting_))),COUNT(__d18(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','IsFishing',COUNT(__d18(__NL(Is_Fishing_))),COUNT(__d18(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','StatementID',COUNT(__d18(__NL(Statement_I_D_))),COUNT(__d18(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','StatementType',COUNT(__d18(__NL(Statement_Type_))),COUNT(__d18(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','DataGroup',COUNT(__d18(__NL(Data_Group_))),COUNT(__d18(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','Content',COUNT(__d18(__NL(Content_))),COUNT(__d18(__NN(Content_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','CorrectedFlag',COUNT(__d18(__NL(Corrected_Flag_))),COUNT(__d18(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','ConsumerStatementFlag',COUNT(__d18(__NL(Consumer_Statement_Flag_))),COUNT(__d18(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','DisputeFlag',COUNT(__d18(__NL(Dispute_Flag_))),COUNT(__d18(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','SecurityFreeze',COUNT(__d18(__NL(Security_Freeze_))),COUNT(__d18(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','SecurityAlert',COUNT(__d18(__NL(Security_Alert_))),COUNT(__d18(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','NegativeAlert',COUNT(__d18(__NL(Negative_Alert_))),COUNT(__d18(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','IDTheftFlag',COUNT(__d18(__NL(I_D_Theft_Flag_))),COUNT(__d18(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','LegalHoldAlert',COUNT(__d18(__NL(Legal_Hold_Alert_))),COUNT(__d18(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','ThriveDateFirstSeen',COUNT(__d18(__NL(Thrive_Date_First_Seen_))),COUNT(__d18(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','Employer',COUNT(__d18(__NL(Employer_))),COUNT(__d18(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','PayFrequency',COUNT(__d18(__NL(Pay_Frequency_))),COUNT(__d18(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','Income',COUNT(__d18(__NL(Income_))),COUNT(__d18(__NN(Income_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','NameScore',COUNT(__d18(__NL(Name_Score_))),COUNT(__d18(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','Archive_Date',COUNT(__d18(Archive___Date_=0)),COUNT(__d18(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','DateFirstSeen',COUNT(__d18(Date_First_Seen_=0)),COUNT(__d18(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','DateLastSeen',COUNT(__d18(Date_Last_Seen_=0)),COUNT(__d18(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','HybridArchiveDate',COUNT(__d18(Hybrid_Archive_Date_=0)),COUNT(__d18(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.Files.FCRA.Watchdog__Key_Watchdog_FCRA_nonEQ_Vault','VaultDateLastSeen',COUNT(__d18(Vault_Date_Last_Seen_=0)),COUNT(__d18(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','UID',COUNT(PublicRecords_KEL_files_FCRA_Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault_Invalid),COUNT(__d19)},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','Title',COUNT(__d19(__NL(Title_))),COUNT(__d19(__NN(Title_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','FirstName',COUNT(__d19(__NL(First_Name_))),COUNT(__d19(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','MiddleName',COUNT(__d19(__NL(Middle_Name_))),COUNT(__d19(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','LastName',COUNT(__d19(__NL(Last_Name_))),COUNT(__d19(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','NameSuffix',COUNT(__d19(__NL(Name_Suffix_))),COUNT(__d19(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','LexIDSegment',COUNT(__d19(__NL(Lex_I_D_Segment_))),COUNT(__d19(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','LexIDSegment2',COUNT(__d19(__NL(Lex_I_D_Segment2_))),COUNT(__d19(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','dob8',COUNT(__d19(__NL(Date_Of_Birth_))),COUNT(__d19(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','dod8',COUNT(__d19(__NL(Date_Of_Death_))),COUNT(__d19(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','Gender',COUNT(__d19(__NL(Gender_))),COUNT(__d19(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','Race',COUNT(__d19(__NL(Race_))),COUNT(__d19(__NN(Race_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','RaceDescription',COUNT(__d19(__NL(Race_Description_))),COUNT(__d19(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','HeaderHitFlag',COUNT(__d19(__NL(Header_Hit_Flag_))),COUNT(__d19(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','Best',COUNT(__d19(__NL(Best_))),COUNT(__d19(__NN(Best_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','FDNIndicator',COUNT(__d19(__NL(F_D_N_Indicator_))),COUNT(__d19(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','src',COUNT(__d19(__NL(Source_))),COUNT(__d19(__NN(Source_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','PurchProcessDate',COUNT(__d19(__NL(Purch_Process_Date_))),COUNT(__d19(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','PurchHistoryFlag',COUNT(__d19(__NL(Purch_History_Flag_))),COUNT(__d19(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','PurchNewAmt',COUNT(__d19(__NL(Purch_New_Amt_))),COUNT(__d19(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','PurchTotal',COUNT(__d19(__NL(Purch_Total_))),COUNT(__d19(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','PurchCount',COUNT(__d19(__NL(Purch_Count_))),COUNT(__d19(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','PurchNewAgeMonths',COUNT(__d19(__NL(Purch_New_Age_Months_))),COUNT(__d19(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','PurchOldAgeMonths',COUNT(__d19(__NL(Purch_Old_Age_Months_))),COUNT(__d19(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','PurchItemCount',COUNT(__d19(__NL(Purch_Item_Count_))),COUNT(__d19(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','PurchAmtAvg',COUNT(__d19(__NL(Purch_Amt_Avg_))),COUNT(__d19(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','IsHuntFish',COUNT(__d19(__NL(Is_Hunt_Fish_))),COUNT(__d19(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','IsCCW',COUNT(__d19(__NL(Is_C_C_W_))),COUNT(__d19(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','PermitNumber',COUNT(__d19(__NL(Permit_Number_))),COUNT(__d19(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','WeaponPermitsType',COUNT(__d19(__NL(Weapon_Permits_Type_))),COUNT(__d19(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','WeaponRegistrationDate',COUNT(__d19(__NL(Weapon_Registration_Date_))),COUNT(__d19(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','WeaponExpirationDate',COUNT(__d19(__NL(Weapon_Expiration_Date_))),COUNT(__d19(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','LicenseDate',COUNT(__d19(__NL(License_Date_))),COUNT(__d19(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','HomeState',COUNT(__d19(__NL(Home_State_))),COUNT(__d19(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','SourceState',COUNT(__d19(__NL(Source_State_))),COUNT(__d19(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','IsResident',COUNT(__d19(__NL(Is_Resident_))),COUNT(__d19(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','IsHunting',COUNT(__d19(__NL(Is_Hunting_))),COUNT(__d19(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','IsFishing',COUNT(__d19(__NL(Is_Fishing_))),COUNT(__d19(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','StatementID',COUNT(__d19(__NL(Statement_I_D_))),COUNT(__d19(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','StatementType',COUNT(__d19(__NL(Statement_Type_))),COUNT(__d19(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','DataGroup',COUNT(__d19(__NL(Data_Group_))),COUNT(__d19(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','Content',COUNT(__d19(__NL(Content_))),COUNT(__d19(__NN(Content_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','CorrectedFlag',COUNT(__d19(__NL(Corrected_Flag_))),COUNT(__d19(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','ConsumerStatementFlag',COUNT(__d19(__NL(Consumer_Statement_Flag_))),COUNT(__d19(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','DisputeFlag',COUNT(__d19(__NL(Dispute_Flag_))),COUNT(__d19(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','SecurityFreeze',COUNT(__d19(__NL(Security_Freeze_))),COUNT(__d19(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','SecurityAlert',COUNT(__d19(__NL(Security_Alert_))),COUNT(__d19(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','NegativeAlert',COUNT(__d19(__NL(Negative_Alert_))),COUNT(__d19(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','IDTheftFlag',COUNT(__d19(__NL(I_D_Theft_Flag_))),COUNT(__d19(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','LegalHoldAlert',COUNT(__d19(__NL(Legal_Hold_Alert_))),COUNT(__d19(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','ThriveDateFirstSeen',COUNT(__d19(__NL(Thrive_Date_First_Seen_))),COUNT(__d19(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','Employer',COUNT(__d19(__NL(Employer_))),COUNT(__d19(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','PayFrequency',COUNT(__d19(__NL(Pay_Frequency_))),COUNT(__d19(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','Income',COUNT(__d19(__NL(Income_))),COUNT(__d19(__NN(Income_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','NameScore',COUNT(__d19(__NL(Name_Score_))),COUNT(__d19(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','Archive_Date',COUNT(__d19(Archive___Date_=0)),COUNT(__d19(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','DateFirstSeen',COUNT(__d19(Date_First_Seen_=0)),COUNT(__d19(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','DateLastSeen',COUNT(__d19(Date_Last_Seen_=0)),COUNT(__d19(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','HybridArchiveDate',COUNT(__d19(Hybrid_Archive_Date_=0)),COUNT(__d19(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.files.FCRA.Doxie__Key_Death_MasterV2_SSA_DID_FCRA_Vault','VaultDateLastSeen',COUNT(__d19(Vault_Date_Last_Seen_=0)),COUNT(__d19(Vault_Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','UID',COUNT(PublicRecords_KEL_files_FCRA_Thrive__Keys__Did_fcra__QA_Vault_Invalid),COUNT(__d20)},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','Title',COUNT(__d20(__NL(Title_))),COUNT(__d20(__NN(Title_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','FirstName',COUNT(__d20(__NL(First_Name_))),COUNT(__d20(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','MiddleName',COUNT(__d20(__NL(Middle_Name_))),COUNT(__d20(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','LastName',COUNT(__d20(__NL(Last_Name_))),COUNT(__d20(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','NameSuffix',COUNT(__d20(__NL(Name_Suffix_))),COUNT(__d20(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','LexIDSegment',COUNT(__d20(__NL(Lex_I_D_Segment_))),COUNT(__d20(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','LexIDSegment2',COUNT(__d20(__NL(Lex_I_D_Segment2_))),COUNT(__d20(__NN(Lex_I_D_Segment2_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','DateOfBirth',COUNT(__d20(__NL(Date_Of_Birth_))),COUNT(__d20(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','DateOfDeath',COUNT(__d20(__NL(Date_Of_Death_))),COUNT(__d20(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','Gender',COUNT(__d20(__NL(Gender_))),COUNT(__d20(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','Race',COUNT(__d20(__NL(Race_))),COUNT(__d20(__NN(Race_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','RaceDescription',COUNT(__d20(__NL(Race_Description_))),COUNT(__d20(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','HeaderHitFlag',COUNT(__d20(__NL(Header_Hit_Flag_))),COUNT(__d20(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','Best',COUNT(__d20(__NL(Best_))),COUNT(__d20(__NN(Best_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','FDNIndicator',COUNT(__d20(__NL(F_D_N_Indicator_))),COUNT(__d20(__NN(F_D_N_Indicator_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','DeathMasterFlag',COUNT(__d20(__NL(Death_Master_Flag_))),COUNT(__d20(__NN(Death_Master_Flag_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','src',COUNT(__d20(__NL(Source_))),COUNT(__d20(__NN(Source_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','PurchProcessDate',COUNT(__d20(__NL(Purch_Process_Date_))),COUNT(__d20(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','PurchHistoryFlag',COUNT(__d20(__NL(Purch_History_Flag_))),COUNT(__d20(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','PurchNewAmt',COUNT(__d20(__NL(Purch_New_Amt_))),COUNT(__d20(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','PurchTotal',COUNT(__d20(__NL(Purch_Total_))),COUNT(__d20(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','PurchCount',COUNT(__d20(__NL(Purch_Count_))),COUNT(__d20(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','PurchNewAgeMonths',COUNT(__d20(__NL(Purch_New_Age_Months_))),COUNT(__d20(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','PurchOldAgeMonths',COUNT(__d20(__NL(Purch_Old_Age_Months_))),COUNT(__d20(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','PurchItemCount',COUNT(__d20(__NL(Purch_Item_Count_))),COUNT(__d20(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','PurchAmtAvg',COUNT(__d20(__NL(Purch_Amt_Avg_))),COUNT(__d20(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','IsHuntFish',COUNT(__d20(__NL(Is_Hunt_Fish_))),COUNT(__d20(__NN(Is_Hunt_Fish_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','IsCCW',COUNT(__d20(__NL(Is_C_C_W_))),COUNT(__d20(__NN(Is_C_C_W_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','PermitNumber',COUNT(__d20(__NL(Permit_Number_))),COUNT(__d20(__NN(Permit_Number_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','WeaponPermitsType',COUNT(__d20(__NL(Weapon_Permits_Type_))),COUNT(__d20(__NN(Weapon_Permits_Type_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','WeaponRegistrationDate',COUNT(__d20(__NL(Weapon_Registration_Date_))),COUNT(__d20(__NN(Weapon_Registration_Date_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','WeaponExpirationDate',COUNT(__d20(__NL(Weapon_Expiration_Date_))),COUNT(__d20(__NN(Weapon_Expiration_Date_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','LicenseDate',COUNT(__d20(__NL(License_Date_))),COUNT(__d20(__NN(License_Date_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','HomeState',COUNT(__d20(__NL(Home_State_))),COUNT(__d20(__NN(Home_State_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','SourceState',COUNT(__d20(__NL(Source_State_))),COUNT(__d20(__NN(Source_State_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','IsResident',COUNT(__d20(__NL(Is_Resident_))),COUNT(__d20(__NN(Is_Resident_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','IsHunting',COUNT(__d20(__NL(Is_Hunting_))),COUNT(__d20(__NN(Is_Hunting_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','IsFishing',COUNT(__d20(__NL(Is_Fishing_))),COUNT(__d20(__NN(Is_Fishing_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','StatementID',COUNT(__d20(__NL(Statement_I_D_))),COUNT(__d20(__NN(Statement_I_D_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','StatementType',COUNT(__d20(__NL(Statement_Type_))),COUNT(__d20(__NN(Statement_Type_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','DataGroup',COUNT(__d20(__NL(Data_Group_))),COUNT(__d20(__NN(Data_Group_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','Content',COUNT(__d20(__NL(Content_))),COUNT(__d20(__NN(Content_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','CorrectedFlag',COUNT(__d20(__NL(Corrected_Flag_))),COUNT(__d20(__NN(Corrected_Flag_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','ConsumerStatementFlag',COUNT(__d20(__NL(Consumer_Statement_Flag_))),COUNT(__d20(__NN(Consumer_Statement_Flag_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','DisputeFlag',COUNT(__d20(__NL(Dispute_Flag_))),COUNT(__d20(__NN(Dispute_Flag_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','SecurityFreeze',COUNT(__d20(__NL(Security_Freeze_))),COUNT(__d20(__NN(Security_Freeze_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','SecurityAlert',COUNT(__d20(__NL(Security_Alert_))),COUNT(__d20(__NN(Security_Alert_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','NegativeAlert',COUNT(__d20(__NL(Negative_Alert_))),COUNT(__d20(__NN(Negative_Alert_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','IDTheftFlag',COUNT(__d20(__NL(I_D_Theft_Flag_))),COUNT(__d20(__NN(I_D_Theft_Flag_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','LegalHoldAlert',COUNT(__d20(__NL(Legal_Hold_Alert_))),COUNT(__d20(__NN(Legal_Hold_Alert_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','dt_first_seen',COUNT(__d20(__NL(Thrive_Date_First_Seen_))),COUNT(__d20(__NN(Thrive_Date_First_Seen_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','employer',COUNT(__d20(__NL(Employer_))),COUNT(__d20(__NN(Employer_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','pay_frequency',COUNT(__d20(__NL(Pay_Frequency_))),COUNT(__d20(__NN(Pay_Frequency_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','income',COUNT(__d20(__NL(Income_))),COUNT(__d20(__NN(Income_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','NameScore',COUNT(__d20(__NL(Name_Score_))),COUNT(__d20(__NN(Name_Score_)))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','Archive_Date',COUNT(__d20(Archive___Date_=0)),COUNT(__d20(Archive___Date_!=0))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','DateFirstSeen',COUNT(__d20(Date_First_Seen_=0)),COUNT(__d20(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','DateLastSeen',COUNT(__d20(Date_Last_Seen_=0)),COUNT(__d20(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','HybridArchiveDate',COUNT(__d20(Hybrid_Archive_Date_=0)),COUNT(__d20(Hybrid_Archive_Date_!=0))},
    {'Person','PublicRecords_KEL.files.FCRA.Thrive__Keys__Did_fcra__QA_Vault','VaultDateLastSeen',COUNT(__d20(Vault_Date_Last_Seen_=0)),COUNT(__d20(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
