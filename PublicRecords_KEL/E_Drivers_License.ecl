//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Drivers_License(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Drivers_License_Number_;
    KEL.typ.nstr Issuing_State_;
    KEL.typ.nint Drivers_License_Sequence_;
    KEL.typ.nstr License_Class_;
    KEL.typ.nstr License_Type_;
    KEL.typ.nstr Moxie_License_Type_;
    KEL.typ.nstr Attention_;
    KEL.typ.nstr Attention_Code_;
    KEL.typ.nstr Restrictions_;
    KEL.typ.nstr Restrictions_Delimited_;
    KEL.typ.nkdate Original_Expiration_Date_;
    KEL.typ.nkdate Original_Issue_Date_;
    KEL.typ.nkdate Issue_Date_;
    KEL.typ.nkdate Expiration_Date_;
    KEL.typ.nkdate Active_Date_;
    KEL.typ.nkdate Inactive_Date_;
    KEL.typ.nstr Endorsement_;
    KEL.typ.nstr Motorcycle_Code_;
    KEL.typ.nint Driver_Education_Code_;
    KEL.typ.nint Duplicate_Count_;
    KEL.typ.nstr R_C_D_Stat_;
    KEL.typ.nstr O_O_S_Previous_Drivers_License_Number_;
    KEL.typ.nstr Previous_State_;
    KEL.typ.nstr Previous_Drivers_License_Number_;
    KEL.typ.nint Drivers_License_Key_Number_;
    KEL.typ.nstr Issuance_;
    KEL.typ.nstr C_D_L_Status_;
    KEL.typ.nstr County_;
    KEL.typ.nstr Address_Change_;
    KEL.typ.nstr Name_Change_;
    KEL.typ.nstr Date_Of_Birth_Change_;
    KEL.typ.nstr Sex_Change_;
    KEL.typ.nstr Height_;
    KEL.typ.nint Weight_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Code_;
    KEL.typ.nstr Sex_;
    KEL.typ.nstr Sex_Code_;
    KEL.typ.nstr Hair_Color_;
    KEL.typ.nstr Hair_Color_Code_;
    KEL.typ.nstr Eye_Color_;
    KEL.typ.nstr Eye_Color_Code_;
    KEL.typ.nstr State_Name_;
    KEL.typ.nstr History_Name_;
    KEL.typ.nstr History_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED Active_Date_Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Inactive_Date_Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping := 'UID(UID),driverslicensenumber(Drivers_License_Number_:\'\'),issuingstate(Issuing_State_:\'\'),dl_seq(Drivers_License_Sequence_:0),licenseclass(License_Class_:\'\'),licensetype(License_Type_:\'\'),moxielicensetype(Moxie_License_Type_:\'\'),attention(Attention_:\'\'),attentioncode(Attention_Code_:\'\'),restrictions(Restrictions_:\'\'),restrictionsdelimited(Restrictions_Delimited_:\'\'),originalexpirationdate(Original_Expiration_Date_:DATE),originalissuedate(Original_Issue_Date_:DATE),issuedate(Issue_Date_:DATE),expirationdate(Expiration_Date_:DATE),activedate(Active_Date_:DATE:Active_Date_Rule),inactivedate(Inactive_Date_:DATE:Inactive_Date_Rule),endorsement(Endorsement_:\'\'),motorcyclecode(Motorcycle_Code_:\'\'),drivereducationcode(Driver_Education_Code_:0),duplicatecount(Duplicate_Count_:0),rcdstat(R_C_D_Stat_:\'\'),oospreviousdriverslicensenumber(O_O_S_Previous_Drivers_License_Number_:\'\'),previousstate(Previous_State_:\'\'),previousdriverslicensenumber(Previous_Drivers_License_Number_:\'\'),driverslicensekeynumber(Drivers_License_Key_Number_:0),issuance(Issuance_:\'\'),cdlstatus(C_D_L_Status_:\'\'),county(County_:\'\'),addresschange(Address_Change_:\'\'),namechange(Name_Change_:\'\'),dateofbirthchange(Date_Of_Birth_Change_:\'\'),sexchange(Sex_Change_:\'\'),height(Height_:\'\'),weight(Weight_:0),race(Race_:\'\'),racecode(Race_Code_:\'\'),sex(Sex_:\'\'),sexcode(Sex_Code_:\'\'),haircolor(Hair_Color_:\'\'),haircolorcode(Hair_Color_Code_:\'\'),eyecolor(Eye_Color_:\'\'),eyecolorcode(Eye_Color_Code_:\'\'),statename(State_Name_:\'\'),historyname(History_Name_:\'\'),history(History_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := __in.Dataset_Doxie_Files__Key_Offenders_Risk(dl_state != '');
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.dl_num) + '|' + TRIM((STRING)LEFT.dl_state)));
  EXPORT __All_Trim := __d0_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'') + '|' + TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED Active_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Inactive_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'UID(UID),dl_num(Drivers_License_Number_:\'\'),dl_state(Issuing_State_:\'\'),dl_seq(Drivers_License_Sequence_:0),licenseclass(License_Class_:\'\'),licensetype(License_Type_:\'\'),moxielicensetype(Moxie_License_Type_:\'\'),attention(Attention_:\'\'),attentioncode(Attention_Code_:\'\'),restrictions(Restrictions_:\'\'),restrictionsdelimited(Restrictions_Delimited_:\'\'),originalexpirationdate(Original_Expiration_Date_:DATE),originalissuedate(Original_Issue_Date_:DATE),issuedate(Issue_Date_:DATE),expirationdate(Expiration_Date_:DATE),activedate(Active_Date_:DATE:Active_Date_0Rule),inactivedate(Inactive_Date_:DATE:Inactive_Date_0Rule),endorsement(Endorsement_:\'\'),motorcyclecode(Motorcycle_Code_:\'\'),drivereducationcode(Driver_Education_Code_:0),duplicatecount(Duplicate_Count_:0),rcdstat(R_C_D_Stat_:\'\'),oospreviousdriverslicensenumber(O_O_S_Previous_Drivers_License_Number_:\'\'),previousstate(Previous_State_:\'\'),previousdriverslicensenumber(Previous_Drivers_License_Number_:\'\'),driverslicensekeynumber(Drivers_License_Key_Number_:0),issuance(Issuance_:\'\'),cdlstatus(C_D_L_Status_:\'\'),county(County_:\'\'),addresschange(Address_Change_:\'\'),namechange(Name_Change_:\'\'),dateofbirthchange(Date_Of_Birth_Change_:\'\'),sexchange(Sex_Change_:\'\'),height(Height_:\'\'),weight(Weight_:0),race(Race_:\'\'),racecode(Race_Code_:\'\'),sex(Sex_:\'\'),sexcode(Sex_Code_:\'\'),haircolor(Hair_Color_:\'\'),haircolorcode(Hair_Color_Code_:\'\'),eyecolor(Eye_Color_:\'\'),eyecolorcode(Eye_Color_Code_:\'\'),statename(State_Name_:\'\'),historyname(History_Name_:\'\'),history(History_:\'\'),src(Source_:\'\'),earliest_offense_date(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.__Permits := CFG_Compile.Permit_NonFCRA;
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders_Risk,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders_Risk),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Doxie_Files__Key_Offenders_Risk);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.dl_num) + '|' + TRIM((STRING)LEFT.dl_state) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_Risk_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0),__Mapping0_Transform(LEFT)));
  EXPORT InData := __d0;
  EXPORT Previous_Layout := RECORD
    KEL.typ.nstr O_O_S_Previous_Drivers_License_Number_;
    KEL.typ.nstr Previous_State_;
    KEL.typ.nint Drivers_License_Key_Number_;
    KEL.typ.nstr Previous_Drivers_License_Number_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Change_Layout := RECORD
    KEL.typ.nstr Address_Change_;
    KEL.typ.nstr Name_Change_;
    KEL.typ.nstr Date_Of_Birth_Change_;
    KEL.typ.nstr Sex_Change_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Person_Info_Layout := RECORD
    KEL.typ.nstr Height_;
    KEL.typ.nint Weight_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Code_;
    KEL.typ.nstr Sex_;
    KEL.typ.nstr Sex_Code_;
    KEL.typ.nstr Hair_Color_;
    KEL.typ.nstr Hair_Color_Code_;
    KEL.typ.nstr Eye_Color_;
    KEL.typ.nstr Eye_Color_Code_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Drivers_License_Number_;
    KEL.typ.nstr Issuing_State_;
    KEL.typ.nstr State_Name_;
    KEL.typ.nint Drivers_License_Sequence_;
    KEL.typ.nstr License_Class_;
    KEL.typ.nstr License_Type_;
    KEL.typ.nstr Moxie_License_Type_;
    KEL.typ.nstr Attention_;
    KEL.typ.nstr Attention_Code_;
    KEL.typ.nstr Restrictions_;
    KEL.typ.nstr Restrictions_Delimited_;
    KEL.typ.nkdate Original_Expiration_Date_;
    KEL.typ.nkdate Original_Issue_Date_;
    KEL.typ.nkdate Issue_Date_;
    KEL.typ.nkdate Expiration_Date_;
    KEL.typ.nkdate Active_Date_;
    KEL.typ.nkdate Inactive_Date_;
    KEL.typ.nstr Endorsement_;
    KEL.typ.nstr Motorcycle_Code_;
    KEL.typ.nint Driver_Education_Code_;
    KEL.typ.nint Duplicate_Count_;
    KEL.typ.nstr R_C_D_Stat_;
    KEL.typ.nstr Issuance_;
    KEL.typ.nstr C_D_L_Status_;
    KEL.typ.nstr County_;
    KEL.typ.ndataset(Previous_Layout) Previous_;
    KEL.typ.ndataset(Change_Layout) Change_;
    KEL.typ.ndataset(Person_Info_Layout) Person_Info_;
    KEL.typ.nstr History_Name_;
    KEL.typ.nstr History_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Drivers_License_Group := __PostFilter;
  Layout Drivers_License__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Drivers_License_Number_ := KEL.Intake.SingleValue(__recs,Drivers_License_Number_);
    SELF.Issuing_State_ := KEL.Intake.SingleValue(__recs,Issuing_State_);
    SELF.State_Name_ := KEL.Intake.SingleValue(__recs,State_Name_);
    SELF.Drivers_License_Sequence_ := KEL.Intake.SingleValue(__recs,Drivers_License_Sequence_);
    SELF.License_Class_ := KEL.Intake.SingleValue(__recs,License_Class_);
    SELF.License_Type_ := KEL.Intake.SingleValue(__recs,License_Type_);
    SELF.Moxie_License_Type_ := KEL.Intake.SingleValue(__recs,Moxie_License_Type_);
    SELF.Attention_ := KEL.Intake.SingleValue(__recs,Attention_);
    SELF.Attention_Code_ := KEL.Intake.SingleValue(__recs,Attention_Code_);
    SELF.Restrictions_ := KEL.Intake.SingleValue(__recs,Restrictions_);
    SELF.Restrictions_Delimited_ := KEL.Intake.SingleValue(__recs,Restrictions_Delimited_);
    SELF.Original_Expiration_Date_ := KEL.Intake.SingleValue(__recs,Original_Expiration_Date_);
    SELF.Original_Issue_Date_ := KEL.Intake.SingleValue(__recs,Original_Issue_Date_);
    SELF.Issue_Date_ := KEL.Intake.SingleValue(__recs,Issue_Date_);
    SELF.Expiration_Date_ := KEL.Intake.SingleValue(__recs,Expiration_Date_);
    SELF.Active_Date_ := KEL.Intake.SingleValue(__recs,Active_Date_);
    SELF.Inactive_Date_ := KEL.Intake.SingleValue(__recs,Inactive_Date_);
    SELF.Endorsement_ := KEL.Intake.SingleValue(__recs,Endorsement_);
    SELF.Motorcycle_Code_ := KEL.Intake.SingleValue(__recs,Motorcycle_Code_);
    SELF.Driver_Education_Code_ := KEL.Intake.SingleValue(__recs,Driver_Education_Code_);
    SELF.Duplicate_Count_ := KEL.Intake.SingleValue(__recs,Duplicate_Count_);
    SELF.R_C_D_Stat_ := KEL.Intake.SingleValue(__recs,R_C_D_Stat_);
    SELF.Issuance_ := KEL.Intake.SingleValue(__recs,Issuance_);
    SELF.C_D_L_Status_ := KEL.Intake.SingleValue(__recs,C_D_L_Status_);
    SELF.County_ := KEL.Intake.SingleValue(__recs,County_);
    SELF.Previous_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),O_O_S_Previous_Drivers_License_Number_,Previous_State_,Drivers_License_Key_Number_,Previous_Drivers_License_Number_},O_O_S_Previous_Drivers_License_Number_,Previous_State_,Drivers_License_Key_Number_,Previous_Drivers_License_Number_),Previous_Layout)(__NN(O_O_S_Previous_Drivers_License_Number_) OR __NN(Previous_State_) OR __NN(Drivers_License_Key_Number_) OR __NN(Previous_Drivers_License_Number_)));
    SELF.Change_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Address_Change_,Name_Change_,Date_Of_Birth_Change_,Sex_Change_},Address_Change_,Name_Change_,Date_Of_Birth_Change_,Sex_Change_),Change_Layout)(__NN(Address_Change_) OR __NN(Name_Change_) OR __NN(Date_Of_Birth_Change_) OR __NN(Sex_Change_)));
    SELF.Person_Info_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Height_,Weight_,Race_,Race_Code_,Sex_,Sex_Code_,Hair_Color_,Hair_Color_Code_,Eye_Color_,Eye_Color_Code_},Height_,Weight_,Race_,Race_Code_,Sex_,Sex_Code_,Hair_Color_,Hair_Color_Code_,Eye_Color_,Eye_Color_Code_),Person_Info_Layout)(__NN(Height_) OR __NN(Weight_) OR __NN(Race_) OR __NN(Race_Code_) OR __NN(Sex_) OR __NN(Sex_Code_) OR __NN(Hair_Color_) OR __NN(Hair_Color_Code_) OR __NN(Eye_Color_) OR __NN(Eye_Color_Code_)));
    SELF.History_Name_ := KEL.Intake.SingleValue(__recs,History_Name_);
    SELF.History_ := KEL.Intake.SingleValue(__recs,History_);
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Drivers_License__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Previous_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Previous_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(O_O_S_Previous_Drivers_License_Number_) OR __NN(Previous_State_) OR __NN(Drivers_License_Key_Number_) OR __NN(Previous_Drivers_License_Number_)));
    SELF.Change_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Change_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Address_Change_) OR __NN(Name_Change_) OR __NN(Date_Of_Birth_Change_) OR __NN(Sex_Change_)));
    SELF.Person_Info_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Person_Info_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Height_) OR __NN(Weight_) OR __NN(Race_) OR __NN(Race_Code_) OR __NN(Sex_) OR __NN(Sex_Code_) OR __NN(Hair_Color_) OR __NN(Hair_Color_Code_) OR __NN(Eye_Color_) OR __NN(Eye_Color_Code_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Drivers_License_Group,COUNT(ROWS(LEFT))=1),GROUP,Drivers_License__Single_Rollup(LEFT)) + ROLLUP(HAVING(Drivers_License_Group,COUNT(ROWS(LEFT))>1),GROUP,Drivers_License__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Drivers_License_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Drivers_License_Number_);
  EXPORT Issuing_State__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Issuing_State_);
  EXPORT State_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,State_Name_);
  EXPORT Drivers_License_Sequence__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Drivers_License_Sequence_);
  EXPORT License_Class__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,License_Class_);
  EXPORT License_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,License_Type_);
  EXPORT Moxie_License_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Moxie_License_Type_);
  EXPORT Attention__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Attention_);
  EXPORT Attention_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Attention_Code_);
  EXPORT Restrictions__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Restrictions_);
  EXPORT Restrictions_Delimited__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Restrictions_Delimited_);
  EXPORT Original_Expiration_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Expiration_Date_);
  EXPORT Original_Issue_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Original_Issue_Date_);
  EXPORT Issue_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Issue_Date_);
  EXPORT Expiration_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Expiration_Date_);
  EXPORT Active_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Active_Date_);
  EXPORT Inactive_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Inactive_Date_);
  EXPORT Endorsement__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Endorsement_);
  EXPORT Motorcycle_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Motorcycle_Code_);
  EXPORT Driver_Education_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Driver_Education_Code_);
  EXPORT Duplicate_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Duplicate_Count_);
  EXPORT R_C_D_Stat__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,R_C_D_Stat_);
  EXPORT Issuance__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Issuance_);
  EXPORT C_D_L_Status__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,C_D_L_Status_);
  EXPORT County__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,County_);
  EXPORT History_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,History_Name_);
  EXPORT History__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,History_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_Risk_Invalid),COUNT(Drivers_License_Number__SingleValue_Invalid),COUNT(Issuing_State__SingleValue_Invalid),COUNT(State_Name__SingleValue_Invalid),COUNT(Drivers_License_Sequence__SingleValue_Invalid),COUNT(License_Class__SingleValue_Invalid),COUNT(License_Type__SingleValue_Invalid),COUNT(Moxie_License_Type__SingleValue_Invalid),COUNT(Attention__SingleValue_Invalid),COUNT(Attention_Code__SingleValue_Invalid),COUNT(Restrictions__SingleValue_Invalid),COUNT(Restrictions_Delimited__SingleValue_Invalid),COUNT(Original_Expiration_Date__SingleValue_Invalid),COUNT(Original_Issue_Date__SingleValue_Invalid),COUNT(Issue_Date__SingleValue_Invalid),COUNT(Expiration_Date__SingleValue_Invalid),COUNT(Active_Date__SingleValue_Invalid),COUNT(Inactive_Date__SingleValue_Invalid),COUNT(Endorsement__SingleValue_Invalid),COUNT(Motorcycle_Code__SingleValue_Invalid),COUNT(Driver_Education_Code__SingleValue_Invalid),COUNT(Duplicate_Count__SingleValue_Invalid),COUNT(R_C_D_Stat__SingleValue_Invalid),COUNT(Issuance__SingleValue_Invalid),COUNT(C_D_L_Status__SingleValue_Invalid),COUNT(County__SingleValue_Invalid),COUNT(History_Name__SingleValue_Invalid),COUNT(History__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_Risk_Invalid,KEL.typ.int Drivers_License_Number__SingleValue_Invalid,KEL.typ.int Issuing_State__SingleValue_Invalid,KEL.typ.int State_Name__SingleValue_Invalid,KEL.typ.int Drivers_License_Sequence__SingleValue_Invalid,KEL.typ.int License_Class__SingleValue_Invalid,KEL.typ.int License_Type__SingleValue_Invalid,KEL.typ.int Moxie_License_Type__SingleValue_Invalid,KEL.typ.int Attention__SingleValue_Invalid,KEL.typ.int Attention_Code__SingleValue_Invalid,KEL.typ.int Restrictions__SingleValue_Invalid,KEL.typ.int Restrictions_Delimited__SingleValue_Invalid,KEL.typ.int Original_Expiration_Date__SingleValue_Invalid,KEL.typ.int Original_Issue_Date__SingleValue_Invalid,KEL.typ.int Issue_Date__SingleValue_Invalid,KEL.typ.int Expiration_Date__SingleValue_Invalid,KEL.typ.int Active_Date__SingleValue_Invalid,KEL.typ.int Inactive_Date__SingleValue_Invalid,KEL.typ.int Endorsement__SingleValue_Invalid,KEL.typ.int Motorcycle_Code__SingleValue_Invalid,KEL.typ.int Driver_Education_Code__SingleValue_Invalid,KEL.typ.int Duplicate_Count__SingleValue_Invalid,KEL.typ.int R_C_D_Stat__SingleValue_Invalid,KEL.typ.int Issuance__SingleValue_Invalid,KEL.typ.int C_D_L_Status__SingleValue_Invalid,KEL.typ.int County__SingleValue_Invalid,KEL.typ.int History_Name__SingleValue_Invalid,KEL.typ.int History__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenders_Risk_Invalid),COUNT(__d0)},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dl_num',COUNT(__d0(__NL(Drivers_License_Number_))),COUNT(__d0(__NN(Drivers_License_Number_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dl_state',COUNT(__d0(__NL(Issuing_State_))),COUNT(__d0(__NN(Issuing_State_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dl_seq',COUNT(__d0(__NL(Drivers_License_Sequence_))),COUNT(__d0(__NN(Drivers_License_Sequence_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseClass',COUNT(__d0(__NL(License_Class_))),COUNT(__d0(__NN(License_Class_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseType',COUNT(__d0(__NL(License_Type_))),COUNT(__d0(__NN(License_Type_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MoxieLicenseType',COUNT(__d0(__NL(Moxie_License_Type_))),COUNT(__d0(__NN(Moxie_License_Type_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Attention',COUNT(__d0(__NL(Attention_))),COUNT(__d0(__NN(Attention_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AttentionCode',COUNT(__d0(__NL(Attention_Code_))),COUNT(__d0(__NN(Attention_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Restrictions',COUNT(__d0(__NL(Restrictions_))),COUNT(__d0(__NN(Restrictions_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RestrictionsDelimited',COUNT(__d0(__NL(Restrictions_Delimited_))),COUNT(__d0(__NN(Restrictions_Delimited_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalExpirationDate',COUNT(__d0(__NL(Original_Expiration_Date_))),COUNT(__d0(__NN(Original_Expiration_Date_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalIssueDate',COUNT(__d0(__NL(Original_Issue_Date_))),COUNT(__d0(__NN(Original_Issue_Date_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IssueDate',COUNT(__d0(__NL(Issue_Date_))),COUNT(__d0(__NN(Issue_Date_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExpirationDate',COUNT(__d0(__NL(Expiration_Date_))),COUNT(__d0(__NN(Expiration_Date_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActiveDate',COUNT(__d0(__NL(Active_Date_))),COUNT(__d0(__NN(Active_Date_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InactiveDate',COUNT(__d0(__NL(Inactive_Date_))),COUNT(__d0(__NN(Inactive_Date_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Endorsement',COUNT(__d0(__NL(Endorsement_))),COUNT(__d0(__NN(Endorsement_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MotorcycleCode',COUNT(__d0(__NL(Motorcycle_Code_))),COUNT(__d0(__NN(Motorcycle_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DriverEducationCode',COUNT(__d0(__NL(Driver_Education_Code_))),COUNT(__d0(__NN(Driver_Education_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DuplicateCount',COUNT(__d0(__NL(Duplicate_Count_))),COUNT(__d0(__NN(Duplicate_Count_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RCDStat',COUNT(__d0(__NL(R_C_D_Stat_))),COUNT(__d0(__NN(R_C_D_Stat_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OOSPreviousDriversLicenseNumber',COUNT(__d0(__NL(O_O_S_Previous_Drivers_License_Number_))),COUNT(__d0(__NN(O_O_S_Previous_Drivers_License_Number_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PreviousState',COUNT(__d0(__NL(Previous_State_))),COUNT(__d0(__NN(Previous_State_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PreviousDriversLicenseNumber',COUNT(__d0(__NL(Previous_Drivers_License_Number_))),COUNT(__d0(__NN(Previous_Drivers_License_Number_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DriversLicenseKeyNumber',COUNT(__d0(__NL(Drivers_License_Key_Number_))),COUNT(__d0(__NN(Drivers_License_Key_Number_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Issuance',COUNT(__d0(__NL(Issuance_))),COUNT(__d0(__NN(Issuance_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CDLStatus',COUNT(__d0(__NL(C_D_L_Status_))),COUNT(__d0(__NN(C_D_L_Status_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','County',COUNT(__d0(__NL(County_))),COUNT(__d0(__NN(County_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressChange',COUNT(__d0(__NL(Address_Change_))),COUNT(__d0(__NN(Address_Change_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameChange',COUNT(__d0(__NL(Name_Change_))),COUNT(__d0(__NN(Name_Change_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthChange',COUNT(__d0(__NL(Date_Of_Birth_Change_))),COUNT(__d0(__NN(Date_Of_Birth_Change_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SexChange',COUNT(__d0(__NL(Sex_Change_))),COUNT(__d0(__NN(Sex_Change_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Height',COUNT(__d0(__NL(Height_))),COUNT(__d0(__NN(Height_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Weight',COUNT(__d0(__NL(Weight_))),COUNT(__d0(__NN(Weight_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Race',COUNT(__d0(__NL(Race_))),COUNT(__d0(__NN(Race_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RaceCode',COUNT(__d0(__NL(Race_Code_))),COUNT(__d0(__NN(Race_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Sex',COUNT(__d0(__NL(Sex_))),COUNT(__d0(__NN(Sex_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SexCode',COUNT(__d0(__NL(Sex_Code_))),COUNT(__d0(__NN(Sex_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HairColor',COUNT(__d0(__NL(Hair_Color_))),COUNT(__d0(__NN(Hair_Color_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HairColorCode',COUNT(__d0(__NL(Hair_Color_Code_))),COUNT(__d0(__NN(Hair_Color_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EyeColor',COUNT(__d0(__NL(Eye_Color_))),COUNT(__d0(__NN(Eye_Color_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EyeColorCode',COUNT(__d0(__NL(Eye_Color_Code_))),COUNT(__d0(__NN(Eye_Color_Code_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StateName',COUNT(__d0(__NL(State_Name_))),COUNT(__d0(__NN(State_Name_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HistoryName',COUNT(__d0(__NL(History_Name_))),COUNT(__d0(__NN(History_Name_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','History',COUNT(__d0(__NL(History_))),COUNT(__d0(__NN(History_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'DriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
