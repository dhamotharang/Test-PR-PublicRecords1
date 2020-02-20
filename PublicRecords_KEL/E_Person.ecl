﻿//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
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
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nkdate Date_Of_Death_;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.nbool Header_Hit_Flag_;
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'lexid(DEFAULT:UID),title(DEFAULT:Title_),firstname(DEFAULT:First_Name_),middlename(DEFAULT:Middle_Name_),lastname(DEFAULT:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),source(DEFAULT:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH)';
  SHARED Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_First_Reported_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_Last_Reported_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'did(OVERRIDE:UID),title(OVERRIDE:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dod(OVERRIDE:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_0Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:EPOCH:Date_Vendor_First_Reported_0Rule),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:EPOCH:Date_Vendor_Last_Reported_0Rule),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Header,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Header),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((UNSIGNED)did != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid := __d0_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d0_Prefiltered := __d0_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping0_Transform(LEFT)));
  SHARED Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_First_Reported_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_Last_Reported_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'did(OVERRIDE:UID),title(OVERRIDE:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_1Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:EPOCH:Date_Vendor_First_Reported_1Rule),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:EPOCH:Date_Vendor_Last_Reported_1Rule),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Header_Quick__Key_Did,TRANSFORM(RECORDOF(__in.Dataset_Header_Quick__Key_Did),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((UNSIGNED)did != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid := __d1_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d1_Prefiltered := __d1_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping1_Transform(LEFT)));
  SHARED __Mapping2 := 'did(OVERRIDE:UID),title(DEFAULT:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(OVERRIDE:Race_:\'\'),race_desc(OVERRIDE:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),fcra_date(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders),SELF:=RIGHT));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_1_Invalid := __d2_Norm((KEL.typ.uid)did = 0);
  SHARED __d2_Prefiltered := __d2_Norm((KEL.typ.uid)did <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping3 := 'did(OVERRIDE:UID),title(DEFAULT:Title_),firstname(DEFAULT:First_Name_),middlename(DEFAULT:Middle_Name_),lastname(DEFAULT:Last_Name_),namesuffix(DEFAULT:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),dob_alias(OVERRIDE:Date_Of_Birth_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),fcra_date(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders),SELF:=RIGHT));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_2_Invalid := __d3_Norm((KEL.typ.uid)did = 0);
  SHARED __d3_Prefiltered := __d3_Norm((KEL.typ.uid)did <> 0);
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping4 := 'person_q.appended_adl(OVERRIDE:UID),title(DEFAULT:Title_),person_q.fname(OVERRIDE:First_Name_),person_q.mname(OVERRIDE:Middle_Name_),person_q.lname(OVERRIDE:Last_Name_),person_q.name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),person_q.dob(OVERRIDE:Date_Of_Birth_:DATE),dateofdeath(DEFAULT:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),dateofinquiry(OVERRIDE:Date_First_Seen_:EPOCH|OVERRIDE:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_Inquiry_AccLogs__Key_FCRA_DID,TRANSFORM(RECORDOF(__in.Dataset_Inquiry_AccLogs__Key_FCRA_DID),SELF:=RIGHT));
  EXPORT __d4_KELfiltered := __d4_Norm((UNSIGNED)person_q.appended_adl > 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_DID_Invalid := __d4_KELfiltered((KEL.typ.uid)person_q.appended_adl = 0);
  SHARED __d4_Prefiltered := __d4_KELfiltered((KEL.typ.uid)person_q.appended_adl <> 0);
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping5 := 'l_did(OVERRIDE:UID),title(DEFAULT:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),dob8(OVERRIDE:Date_Of_Birth_:DATE),dod8(OVERRIDE:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d5_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Death_MasterV2_SSA_DID,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Death_MasterV2_SSA_DID),SELF:=RIGHT));
  EXPORT __d5_KELfiltered := __d5_Norm((UNSIGNED)l_did != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Death_MasterV2_SSA_DID_Invalid := __d5_KELfiltered((KEL.typ.uid)l_did = 0);
  SHARED __d5_Prefiltered := __d5_KELfiltered((KEL.typ.uid)l_did <> 0);
  SHARED __d5 := __SourceFilter(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_6Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_6Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_First_Reported_6Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_Last_Reported_6Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping6 := 'did(OVERRIDE:UID),title(OVERRIDE:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dod(OVERRIDE:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(OVERRIDE:Race_:\'\'),race_name(OVERRIDE:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),source_code(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_6Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_6Rule),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:EPOCH:Date_Vendor_First_Reported_6Rule),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:EPOCH:Date_Vendor_Last_Reported_6Rule),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d6_Norm := NORMALIZE(__in,LEFT.Dataset_DriversV2__Key_DL_DID,TRANSFORM(RECORDOF(__in.Dataset_DriversV2__Key_DL_DID),SELF:=RIGHT));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_DID_Invalid := __d6_Norm((KEL.typ.uid)did = 0);
  SHARED __d6_Prefiltered := __d6_Norm((KEL.typ.uid)did <> 0);
  SHARED __d6 := __SourceFilter(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_7Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_7Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_First_Reported_7Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Vendor_Last_Reported_7Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping7 := 'did(OVERRIDE:UID),title(OVERRIDE:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dod(OVERRIDE:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(OVERRIDE:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),source_code(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_7Rule),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_7Rule),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:EPOCH:Date_Vendor_First_Reported_7Rule),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:EPOCH:Date_Vendor_Last_Reported_7Rule),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d7_Norm := NORMALIZE(__in,LEFT.Dataset_DriversV2__Key_DL_Number,TRANSFORM(RECORDOF(__in.Dataset_DriversV2__Key_DL_Number),SELF:=RIGHT));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_Number_Invalid := __d7_Norm((KEL.typ.uid)did = 0);
  SHARED __d7_Prefiltered := __d7_Norm((KEL.typ.uid)did <> 0);
  SHARED __d7 := __SourceFilter(KEL.FromFlat.Convert(__d7_Prefiltered,InLayout,__Mapping7,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_First_Seen_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_8Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping8 := 'did(OVERRIDE:UID),title(OVERRIDE:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dod(OVERRIDE:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),addr_dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_8Rule),run_date(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_8Rule),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping8_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d8_Norm := NORMALIZE(__in,LEFT.Dataset_Best_Person__Key_Watchdog,TRANSFORM(RECORDOF(__in.Dataset_Best_Person__Key_Watchdog),SELF:=RIGHT));
  EXPORT __d8_KELfiltered := __d8_Norm((UNSIGNED)did != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Best_Person__Key_Watchdog_Invalid := __d8_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d8_Prefiltered := __d8_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d8 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d8_Prefiltered,InLayout,__Mapping8,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping8_Transform(LEFT)));
  SHARED Date_First_Seen_9Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_9Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping9 := 'did(OVERRIDE:UID),title(OVERRIDE:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dod(OVERRIDE:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),addr_dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_9Rule),run_date(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_9Rule),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping9_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d9_Norm := NORMALIZE(__in,LEFT.Dataset_Best_Person__Key_Watchdog_FCRA_nonEN,TRANSFORM(RECORDOF(__in.Dataset_Best_Person__Key_Watchdog_FCRA_nonEN),SELF:=RIGHT));
  EXPORT __d9_KELfiltered := __d9_Norm((UNSIGNED)did != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Best_Person__Key_Watchdog_FCRA_nonEN_Invalid := __d9_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d9_Prefiltered := __d9_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d9 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d9_Prefiltered,InLayout,__Mapping9,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping9_Transform(LEFT)));
  SHARED Date_First_Seen_10Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_10Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping10 := 'did(OVERRIDE:UID),title(OVERRIDE:Title_),fname(OVERRIDE:First_Name_),mname(OVERRIDE:Middle_Name_),lname(OVERRIDE:Last_Name_),name_suffix(OVERRIDE:Name_Suffix_),lexidsegment(DEFAULT:Lex_I_D_Segment_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dod(OVERRIDE:Date_Of_Death_:DATE),gender(DEFAULT:Gender_:\'\'),race(DEFAULT:Race_:\'\'),racedescription(DEFAULT:Race_Description_:\'\'),src(OVERRIDE:Source_:\'\'),purchprocessdate(DEFAULT:Purch_Process_Date_:DATE),purchhistoryflag(DEFAULT:Purch_History_Flag_:\'\'),purchnewamt(DEFAULT:Purch_New_Amt_:0),purchtotal(DEFAULT:Purch_Total_:0),purchcount(DEFAULT:Purch_Count_:0),purchnewagemonths(DEFAULT:Purch_New_Age_Months_:0),purcholdagemonths(DEFAULT:Purch_Old_Age_Months_:0),purchitemcount(DEFAULT:Purch_Item_Count_:0),purchamtavg(DEFAULT:Purch_Amt_Avg_:0),addr_dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_10Rule),run_date(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_10Rule),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping10_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d10_Norm := NORMALIZE(__in,LEFT.Dataset_Best_Person__Key_Watchdog_FCRA_nonEQ,TRANSFORM(RECORDOF(__in.Dataset_Best_Person__Key_Watchdog_FCRA_nonEQ),SELF:=RIGHT));
  EXPORT __d10_KELfiltered := __d10_Norm((UNSIGNED)did != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Best_Person__Key_Watchdog_FCRA_nonEQ_Invalid := __d10_KELfiltered((KEL.typ.uid)did = 0);
  SHARED __d10_Prefiltered := __d10_KELfiltered((KEL.typ.uid)did <> 0);
  SHARED __d10 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d10_Prefiltered,InLayout,__Mapping10,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping10_Transform(LEFT)));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6 + __d7 + __d8 + __d9 + __d10;
  EXPORT Full_Name_Layout := RECORD
    KEL.typ.nstr Title_;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Middle_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nstr Name_Suffix_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Reported_Dates_Of_Birth_Layout := RECORD
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Reported_Dates_Of_Death_Layout := RECORD
    KEL.typ.nkdate Date_Of_Death_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(Dunn_Data_Layout) Dunn_Data_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Person_Group := __PostFilter;
  Layout Person__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Gender_ := KEL.Intake.SingleValue(__recs,Gender_);
    SELF.Lex_I_D_Segment_ := KEL.Intake.SingleValue(__recs,Lex_I_D_Segment_);
    SELF.Full_Name_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Title_,First_Name_,Middle_Name_,Last_Name_,Name_Suffix_,Header_Hit_Flag_},Title_,First_Name_,Middle_Name_,Last_Name_,Name_Suffix_,Header_Hit_Flag_),Full_Name_Layout)(__NN(Title_) OR __NN(First_Name_) OR __NN(Middle_Name_) OR __NN(Last_Name_) OR __NN(Name_Suffix_) OR __NN(Header_Hit_Flag_)));
    SELF.Reported_Dates_Of_Birth_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Date_Of_Birth_,Header_Hit_Flag_},Date_Of_Birth_,Header_Hit_Flag_),Reported_Dates_Of_Birth_Layout)(__NN(Date_Of_Birth_) OR __NN(Header_Hit_Flag_)));
    SELF.Reported_Dates_Of_Death_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Date_Of_Death_},Date_Of_Death_),Reported_Dates_Of_Death_Layout)(__NN(Date_Of_Death_)));
    SELF.Race_ := KEL.Intake.SingleValue(__recs,Race_);
    SELF.Race_Description_ := KEL.Intake.SingleValue(__recs,Race_Description_);
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Source_,Header_Hit_Flag_},Source_,Header_Hit_Flag_),Data_Sources_Layout)(__NN(Source_) OR __NN(Header_Hit_Flag_)));
    SELF.Dunn_Data_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Purch_Process_Date_,Purch_History_Flag_,Purch_New_Amt_,Purch_Total_,Purch_Count_,Purch_New_Age_Months_,Purch_Old_Age_Months_,Purch_Item_Count_,Purch_Amt_Avg_},Purch_Process_Date_,Purch_History_Flag_,Purch_New_Amt_,Purch_Total_,Purch_Count_,Purch_New_Age_Months_,Purch_Old_Age_Months_,Purch_Item_Count_,Purch_Amt_Avg_),Dunn_Data_Layout)(__NN(Purch_Process_Date_) OR __NN(Purch_History_Flag_) OR __NN(Purch_New_Amt_) OR __NN(Purch_Total_) OR __NN(Purch_Count_) OR __NN(Purch_New_Age_Months_) OR __NN(Purch_Old_Age_Months_) OR __NN(Purch_Item_Count_) OR __NN(Purch_Amt_Avg_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_First_Reported_,MIN,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_Last_Reported_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Person__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Full_Name_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Full_Name_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Title_) OR __NN(First_Name_) OR __NN(Middle_Name_) OR __NN(Last_Name_) OR __NN(Name_Suffix_) OR __NN(Header_Hit_Flag_)));
    SELF.Reported_Dates_Of_Birth_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Reported_Dates_Of_Birth_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Date_Of_Birth_) OR __NN(Header_Hit_Flag_)));
    SELF.Reported_Dates_Of_Death_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Reported_Dates_Of_Death_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Date_Of_Death_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Source_) OR __NN(Header_Hit_Flag_)));
    SELF.Dunn_Data_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Dunn_Data_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Purch_Process_Date_) OR __NN(Purch_History_Flag_) OR __NN(Purch_New_Amt_) OR __NN(Purch_Total_) OR __NN(Purch_Count_) OR __NN(Purch_New_Age_Months_) OR __NN(Purch_Old_Age_Months_) OR __NN(Purch_Item_Count_) OR __NN(Purch_Amt_Avg_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_First_Reported_,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_Last_Reported_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_Group,COUNT(ROWS(LEFT))=1),GROUP,Person__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_Group,COUNT(ROWS(LEFT))>1),GROUP,Person__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := TABLE(InData,{KEL.typ.uid UID := MIN(GROUP,__T(UID)),KEL.typ.int Cnt := COUNT(GROUP)},UID);
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Gender__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Gender_);
  EXPORT Lex_I_D_Segment__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Lex_I_D_Segment_);
  EXPORT Race__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Race_);
  EXPORT Race_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Race_Description_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_1_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_2_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_DID_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Death_MasterV2_SSA_DID_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_DID_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_Number_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Best_Person__Key_Watchdog_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Best_Person__Key_Watchdog_FCRA_nonEN_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Best_Person__Key_Watchdog_FCRA_nonEQ_Invalid),COUNT(Gender__SingleValue_Invalid),COUNT(Lex_I_D_Segment__SingleValue_Invalid),COUNT(Race__SingleValue_Invalid),COUNT(Race_Description__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_1_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_2_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_DID_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Death_MasterV2_SSA_DID_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_DID_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_Number_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Best_Person__Key_Watchdog_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Best_Person__Key_Watchdog_FCRA_nonEN_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Best_Person__Key_Watchdog_FCRA_nonEQ_Invalid,KEL.typ.int Gender__SingleValue_Invalid,KEL.typ.int Lex_I_D_Segment__SingleValue_Invalid,KEL.typ.int Race__SingleValue_Invalid,KEL.typ.int Race_Description__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid),COUNT(__d0)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','title',COUNT(__d0(__NL(Title_))),COUNT(__d0(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fname',COUNT(__d0(__NL(First_Name_))),COUNT(__d0(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mname',COUNT(__d0(__NL(Middle_Name_))),COUNT(__d0(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lname',COUNT(__d0(__NL(Last_Name_))),COUNT(__d0(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_suffix',COUNT(__d0(__NL(Name_Suffix_))),COUNT(__d0(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d0(__NL(Lex_I_D_Segment_))),COUNT(__d0(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob',COUNT(__d0(__NL(Date_Of_Birth_))),COUNT(__d0(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dod',COUNT(__d0(__NL(Date_Of_Death_))),COUNT(__d0(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d0(__NL(Gender_))),COUNT(__d0(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d0(__NL(Race_))),COUNT(__d0(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d0(__NL(Race_Description_))),COUNT(__d0(__NN(Race_Description_)))},
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
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d0(Date_Vendor_First_Reported_=0)),COUNT(__d0(Date_Vendor_First_Reported_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d0(Date_Vendor_Last_Reported_=0)),COUNT(__d0(Date_Vendor_Last_Reported_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid),COUNT(__d1)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','title',COUNT(__d1(__NL(Title_))),COUNT(__d1(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fname',COUNT(__d1(__NL(First_Name_))),COUNT(__d1(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mname',COUNT(__d1(__NL(Middle_Name_))),COUNT(__d1(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lname',COUNT(__d1(__NL(Last_Name_))),COUNT(__d1(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_suffix',COUNT(__d1(__NL(Name_Suffix_))),COUNT(__d1(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d1(__NL(Lex_I_D_Segment_))),COUNT(__d1(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob',COUNT(__d1(__NL(Date_Of_Birth_))),COUNT(__d1(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDeath',COUNT(__d1(__NL(Date_Of_Death_))),COUNT(__d1(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d1(__NL(Gender_))),COUNT(__d1(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d1(__NL(Race_))),COUNT(__d1(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d1(__NL(Race_Description_))),COUNT(__d1(__NN(Race_Description_)))},
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
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d1(Date_Vendor_First_Reported_=0)),COUNT(__d1(Date_Vendor_First_Reported_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d1(Date_Vendor_Last_Reported_=0)),COUNT(__d1(Date_Vendor_Last_Reported_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_1_Invalid),COUNT(__d2)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Title',COUNT(__d2(__NL(Title_))),COUNT(__d2(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fname',COUNT(__d2(__NL(First_Name_))),COUNT(__d2(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mname',COUNT(__d2(__NL(Middle_Name_))),COUNT(__d2(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lname',COUNT(__d2(__NL(Last_Name_))),COUNT(__d2(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_suffix',COUNT(__d2(__NL(Name_Suffix_))),COUNT(__d2(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d2(__NL(Lex_I_D_Segment_))),COUNT(__d2(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob',COUNT(__d2(__NL(Date_Of_Birth_))),COUNT(__d2(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDeath',COUNT(__d2(__NL(Date_Of_Death_))),COUNT(__d2(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d2(__NL(Gender_))),COUNT(__d2(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','race',COUNT(__d2(__NL(Race_))),COUNT(__d2(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','race_desc',COUNT(__d2(__NL(Race_Description_))),COUNT(__d2(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d2(__NL(Header_Hit_Flag_))),COUNT(__d2(__NN(Header_Hit_Flag_)))},
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
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d2(Date_Vendor_First_Reported_=0)),COUNT(__d2(Date_Vendor_First_Reported_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d2(Date_Vendor_Last_Reported_=0)),COUNT(__d2(Date_Vendor_Last_Reported_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_2_Invalid),COUNT(__d3)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Title',COUNT(__d3(__NL(Title_))),COUNT(__d3(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FirstName',COUNT(__d3(__NL(First_Name_))),COUNT(__d3(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MiddleName',COUNT(__d3(__NL(Middle_Name_))),COUNT(__d3(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LastName',COUNT(__d3(__NL(Last_Name_))),COUNT(__d3(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameSuffix',COUNT(__d3(__NL(Name_Suffix_))),COUNT(__d3(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d3(__NL(Lex_I_D_Segment_))),COUNT(__d3(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob_alias',COUNT(__d3(__NL(Date_Of_Birth_))),COUNT(__d3(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDeath',COUNT(__d3(__NL(Date_Of_Death_))),COUNT(__d3(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d3(__NL(Gender_))),COUNT(__d3(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d3(__NL(Race_))),COUNT(__d3(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d3(__NL(Race_Description_))),COUNT(__d3(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d3(__NL(Header_Hit_Flag_))),COUNT(__d3(__NN(Header_Hit_Flag_)))},
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
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d3(Date_Vendor_First_Reported_=0)),COUNT(__d3(Date_Vendor_First_Reported_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d3(Date_Vendor_Last_Reported_=0)),COUNT(__d3(Date_Vendor_Last_Reported_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Inquiry_AccLogs__Key_FCRA_DID_Invalid),COUNT(__d4)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Title',COUNT(__d4(__NL(Title_))),COUNT(__d4(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.fname',COUNT(__d4(__NL(First_Name_))),COUNT(__d4(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.mname',COUNT(__d4(__NL(Middle_Name_))),COUNT(__d4(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.lname',COUNT(__d4(__NL(Last_Name_))),COUNT(__d4(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.name_suffix',COUNT(__d4(__NL(Name_Suffix_))),COUNT(__d4(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d4(__NL(Lex_I_D_Segment_))),COUNT(__d4(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','person_q.dob',COUNT(__d4(__NL(Date_Of_Birth_))),COUNT(__d4(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfDeath',COUNT(__d4(__NL(Date_Of_Death_))),COUNT(__d4(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d4(__NL(Gender_))),COUNT(__d4(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d4(__NL(Race_))),COUNT(__d4(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d4(__NL(Race_Description_))),COUNT(__d4(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d4(__NL(Header_Hit_Flag_))),COUNT(__d4(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchProcessDate',COUNT(__d4(__NL(Purch_Process_Date_))),COUNT(__d4(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchHistoryFlag',COUNT(__d4(__NL(Purch_History_Flag_))),COUNT(__d4(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAmt',COUNT(__d4(__NL(Purch_New_Amt_))),COUNT(__d4(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchTotal',COUNT(__d4(__NL(Purch_Total_))),COUNT(__d4(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchCount',COUNT(__d4(__NL(Purch_Count_))),COUNT(__d4(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAgeMonths',COUNT(__d4(__NL(Purch_New_Age_Months_))),COUNT(__d4(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchOldAgeMonths',COUNT(__d4(__NL(Purch_Old_Age_Months_))),COUNT(__d4(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchItemCount',COUNT(__d4(__NL(Purch_Item_Count_))),COUNT(__d4(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchAmtAvg',COUNT(__d4(__NL(Purch_Amt_Avg_))),COUNT(__d4(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d4(Date_Vendor_First_Reported_=0)),COUNT(__d4(Date_Vendor_First_Reported_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d4(Date_Vendor_Last_Reported_=0)),COUNT(__d4(Date_Vendor_Last_Reported_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Death_MasterV2_SSA_DID_Invalid),COUNT(__d5)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Title',COUNT(__d5(__NL(Title_))),COUNT(__d5(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fname',COUNT(__d5(__NL(First_Name_))),COUNT(__d5(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mname',COUNT(__d5(__NL(Middle_Name_))),COUNT(__d5(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lname',COUNT(__d5(__NL(Last_Name_))),COUNT(__d5(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_suffix',COUNT(__d5(__NL(Name_Suffix_))),COUNT(__d5(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d5(__NL(Lex_I_D_Segment_))),COUNT(__d5(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob8',COUNT(__d5(__NL(Date_Of_Birth_))),COUNT(__d5(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dod8',COUNT(__d5(__NL(Date_Of_Death_))),COUNT(__d5(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d5(__NL(Gender_))),COUNT(__d5(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d5(__NL(Race_))),COUNT(__d5(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d5(__NL(Race_Description_))),COUNT(__d5(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d5(__NL(Header_Hit_Flag_))),COUNT(__d5(__NN(Header_Hit_Flag_)))},
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
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d5(Date_Vendor_First_Reported_=0)),COUNT(__d5(Date_Vendor_First_Reported_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d5(Date_Vendor_Last_Reported_=0)),COUNT(__d5(Date_Vendor_Last_Reported_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_DID_Invalid),COUNT(__d6)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','title',COUNT(__d6(__NL(Title_))),COUNT(__d6(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fname',COUNT(__d6(__NL(First_Name_))),COUNT(__d6(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mname',COUNT(__d6(__NL(Middle_Name_))),COUNT(__d6(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lname',COUNT(__d6(__NL(Last_Name_))),COUNT(__d6(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_suffix',COUNT(__d6(__NL(Name_Suffix_))),COUNT(__d6(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d6(__NL(Lex_I_D_Segment_))),COUNT(__d6(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob',COUNT(__d6(__NL(Date_Of_Birth_))),COUNT(__d6(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dod',COUNT(__d6(__NL(Date_Of_Death_))),COUNT(__d6(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d6(__NL(Gender_))),COUNT(__d6(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','race',COUNT(__d6(__NL(Race_))),COUNT(__d6(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','race_name',COUNT(__d6(__NL(Race_Description_))),COUNT(__d6(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d6(__NL(Header_Hit_Flag_))),COUNT(__d6(__NN(Header_Hit_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source_code',COUNT(__d6(__NL(Source_))),COUNT(__d6(__NN(Source_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchProcessDate',COUNT(__d6(__NL(Purch_Process_Date_))),COUNT(__d6(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchHistoryFlag',COUNT(__d6(__NL(Purch_History_Flag_))),COUNT(__d6(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAmt',COUNT(__d6(__NL(Purch_New_Amt_))),COUNT(__d6(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchTotal',COUNT(__d6(__NL(Purch_Total_))),COUNT(__d6(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchCount',COUNT(__d6(__NL(Purch_Count_))),COUNT(__d6(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAgeMonths',COUNT(__d6(__NL(Purch_New_Age_Months_))),COUNT(__d6(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchOldAgeMonths',COUNT(__d6(__NL(Purch_Old_Age_Months_))),COUNT(__d6(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchItemCount',COUNT(__d6(__NL(Purch_Item_Count_))),COUNT(__d6(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchAmtAvg',COUNT(__d6(__NL(Purch_Amt_Avg_))),COUNT(__d6(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d6(Date_Vendor_First_Reported_=0)),COUNT(__d6(Date_Vendor_First_Reported_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d6(Date_Vendor_Last_Reported_=0)),COUNT(__d6(Date_Vendor_Last_Reported_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DriversV2__Key_DL_Number_Invalid),COUNT(__d7)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','title',COUNT(__d7(__NL(Title_))),COUNT(__d7(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fname',COUNT(__d7(__NL(First_Name_))),COUNT(__d7(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mname',COUNT(__d7(__NL(Middle_Name_))),COUNT(__d7(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lname',COUNT(__d7(__NL(Last_Name_))),COUNT(__d7(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_suffix',COUNT(__d7(__NL(Name_Suffix_))),COUNT(__d7(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d7(__NL(Lex_I_D_Segment_))),COUNT(__d7(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob',COUNT(__d7(__NL(Date_Of_Birth_))),COUNT(__d7(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dod',COUNT(__d7(__NL(Date_Of_Death_))),COUNT(__d7(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d7(__NL(Gender_))),COUNT(__d7(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','race',COUNT(__d7(__NL(Race_))),COUNT(__d7(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d7(__NL(Race_Description_))),COUNT(__d7(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d7(__NL(Header_Hit_Flag_))),COUNT(__d7(__NN(Header_Hit_Flag_)))},
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
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d7(Date_First_Seen_=0)),COUNT(__d7(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d7(Date_Last_Seen_=0)),COUNT(__d7(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d7(Date_Vendor_First_Reported_=0)),COUNT(__d7(Date_Vendor_First_Reported_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d7(Date_Vendor_Last_Reported_=0)),COUNT(__d7(Date_Vendor_Last_Reported_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Best_Person__Key_Watchdog_Invalid),COUNT(__d8)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','title',COUNT(__d8(__NL(Title_))),COUNT(__d8(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fname',COUNT(__d8(__NL(First_Name_))),COUNT(__d8(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mname',COUNT(__d8(__NL(Middle_Name_))),COUNT(__d8(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lname',COUNT(__d8(__NL(Last_Name_))),COUNT(__d8(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_suffix',COUNT(__d8(__NL(Name_Suffix_))),COUNT(__d8(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d8(__NL(Lex_I_D_Segment_))),COUNT(__d8(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob',COUNT(__d8(__NL(Date_Of_Birth_))),COUNT(__d8(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dod',COUNT(__d8(__NL(Date_Of_Death_))),COUNT(__d8(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d8(__NL(Gender_))),COUNT(__d8(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d8(__NL(Race_))),COUNT(__d8(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d8(__NL(Race_Description_))),COUNT(__d8(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d8(__NL(Source_))),COUNT(__d8(__NN(Source_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchProcessDate',COUNT(__d8(__NL(Purch_Process_Date_))),COUNT(__d8(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchHistoryFlag',COUNT(__d8(__NL(Purch_History_Flag_))),COUNT(__d8(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAmt',COUNT(__d8(__NL(Purch_New_Amt_))),COUNT(__d8(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchTotal',COUNT(__d8(__NL(Purch_Total_))),COUNT(__d8(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchCount',COUNT(__d8(__NL(Purch_Count_))),COUNT(__d8(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAgeMonths',COUNT(__d8(__NL(Purch_New_Age_Months_))),COUNT(__d8(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchOldAgeMonths',COUNT(__d8(__NL(Purch_Old_Age_Months_))),COUNT(__d8(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchItemCount',COUNT(__d8(__NL(Purch_Item_Count_))),COUNT(__d8(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchAmtAvg',COUNT(__d8(__NL(Purch_Amt_Avg_))),COUNT(__d8(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d8(Date_First_Seen_=0)),COUNT(__d8(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d8(Date_Last_Seen_=0)),COUNT(__d8(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d8(Date_Vendor_First_Reported_=0)),COUNT(__d8(Date_Vendor_First_Reported_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d8(Date_Vendor_Last_Reported_=0)),COUNT(__d8(Date_Vendor_Last_Reported_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Best_Person__Key_Watchdog_FCRA_nonEN_Invalid),COUNT(__d9)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','title',COUNT(__d9(__NL(Title_))),COUNT(__d9(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fname',COUNT(__d9(__NL(First_Name_))),COUNT(__d9(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mname',COUNT(__d9(__NL(Middle_Name_))),COUNT(__d9(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lname',COUNT(__d9(__NL(Last_Name_))),COUNT(__d9(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_suffix',COUNT(__d9(__NL(Name_Suffix_))),COUNT(__d9(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d9(__NL(Lex_I_D_Segment_))),COUNT(__d9(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob',COUNT(__d9(__NL(Date_Of_Birth_))),COUNT(__d9(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dod',COUNT(__d9(__NL(Date_Of_Death_))),COUNT(__d9(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d9(__NL(Gender_))),COUNT(__d9(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d9(__NL(Race_))),COUNT(__d9(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d9(__NL(Race_Description_))),COUNT(__d9(__NN(Race_Description_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d9(__NL(Source_))),COUNT(__d9(__NN(Source_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchProcessDate',COUNT(__d9(__NL(Purch_Process_Date_))),COUNT(__d9(__NN(Purch_Process_Date_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchHistoryFlag',COUNT(__d9(__NL(Purch_History_Flag_))),COUNT(__d9(__NN(Purch_History_Flag_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAmt',COUNT(__d9(__NL(Purch_New_Amt_))),COUNT(__d9(__NN(Purch_New_Amt_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchTotal',COUNT(__d9(__NL(Purch_Total_))),COUNT(__d9(__NN(Purch_Total_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchCount',COUNT(__d9(__NL(Purch_Count_))),COUNT(__d9(__NN(Purch_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchNewAgeMonths',COUNT(__d9(__NL(Purch_New_Age_Months_))),COUNT(__d9(__NN(Purch_New_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchOldAgeMonths',COUNT(__d9(__NL(Purch_Old_Age_Months_))),COUNT(__d9(__NN(Purch_Old_Age_Months_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchItemCount',COUNT(__d9(__NL(Purch_Item_Count_))),COUNT(__d9(__NN(Purch_Item_Count_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PurchAmtAvg',COUNT(__d9(__NL(Purch_Amt_Avg_))),COUNT(__d9(__NN(Purch_Amt_Avg_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d9(Date_First_Seen_=0)),COUNT(__d9(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d9(Date_Last_Seen_=0)),COUNT(__d9(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d9(Date_Vendor_First_Reported_=0)),COUNT(__d9(Date_Vendor_First_Reported_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d9(Date_Vendor_Last_Reported_=0)),COUNT(__d9(Date_Vendor_Last_Reported_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Best_Person__Key_Watchdog_FCRA_nonEQ_Invalid),COUNT(__d10)},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','title',COUNT(__d10(__NL(Title_))),COUNT(__d10(__NN(Title_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fname',COUNT(__d10(__NL(First_Name_))),COUNT(__d10(__NN(First_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','mname',COUNT(__d10(__NL(Middle_Name_))),COUNT(__d10(__NN(Middle_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lname',COUNT(__d10(__NL(Last_Name_))),COUNT(__d10(__NN(Last_Name_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_suffix',COUNT(__d10(__NL(Name_Suffix_))),COUNT(__d10(__NN(Name_Suffix_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LexIDSegment',COUNT(__d10(__NL(Lex_I_D_Segment_))),COUNT(__d10(__NN(Lex_I_D_Segment_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob',COUNT(__d10(__NL(Date_Of_Birth_))),COUNT(__d10(__NN(Date_Of_Birth_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dod',COUNT(__d10(__NL(Date_Of_Death_))),COUNT(__d10(__NN(Date_Of_Death_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Gender',COUNT(__d10(__NL(Gender_))),COUNT(__d10(__NN(Gender_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d10(__NL(Race_))),COUNT(__d10(__NN(Race_)))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceDescription',COUNT(__d10(__NL(Race_Description_))),COUNT(__d10(__NN(Race_Description_)))},
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
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d10(Date_First_Seen_=0)),COUNT(__d10(Date_First_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d10(Date_Last_Seen_=0)),COUNT(__d10(Date_Last_Seen_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d10(Date_Vendor_First_Reported_=0)),COUNT(__d10(Date_Vendor_First_Reported_!=0))},
    {'Person','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d10(Date_Vendor_Last_Reported_=0)),COUNT(__d10(Date_Vendor_Last_Reported_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
