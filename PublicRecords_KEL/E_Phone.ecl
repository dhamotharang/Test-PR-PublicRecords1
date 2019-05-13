//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Phone(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.nstr Listing_Type_;
    KEL.typ.nstr Publish_Code_;
    KEL.typ.nint Portability_Indicator_;
    KEL.typ.nint N_X_X_Type_;
    KEL.typ.nstr C_O_C_Type_;
    KEL.typ.nstr S_C_C_;
    KEL.typ.nint Ported_Match_;
    KEL.typ.nstr Phone_Use_;
    KEL.typ.nint Phone_Number_Company_Type_;
    KEL.typ.nstr Prior_Area_Code_;
    KEL.typ.nstr Is_Active_;
    KEL.typ.nstr Carrier_Name_;
    KEL.typ.nint Confidence_Score_;
    KEL.typ.nstr No_Solicit_Code_;
    KEL.typ.nint Maximum_Confidence_Score_;
    KEL.typ.nint Minimum_Confidence_Score_;
    KEL.typ.nstr Omit_Indicator_;
    KEL.typ.nstr Current_Flag_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Phone_Quality_;
    KEL.typ.nstr T_N_T_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nint Source_File_;
    KEL.typ.nint Iver_Indicator_;
    KEL.typ.nstr Phone_Type_;
    KEL.typ.nstr Validation_Flag_;
    KEL.typ.nstr Validation_Date_;
    KEL.typ.nstr Source_;
    KEL.typ.nstr Original_Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'phone10(UID|Phone10_:\'\'),listingtype(Listing_Type_:\'\'),publishcode(Publish_Code_:\'\'),portabilityindicator(Portability_Indicator_:0),nxxtype(N_X_X_Type_:0),coctype(C_O_C_Type_:\'\'),scc(S_C_C_:\'\'),portedmatch(Ported_Match_:0),phoneuse(Phone_Use_:\'\'),phonenumbercompanytype(Phone_Number_Company_Type_:0),priorareacode(Prior_Area_Code_:\'\'),isactive(Is_Active_:\'\'),carriername(Carrier_Name_:\'\'),confidencescore(Confidence_Score_:0),nosolicitcode(No_Solicit_Code_:\'\'),maximumconfidencescore(Maximum_Confidence_Score_:0),minimumconfidencescore(Minimum_Confidence_Score_:0),omitindicator(Omit_Indicator_:\'\'),currentflag(Current_Flag_:\'\'),businessflag(Business_Flag_:\'\'),phonequality(Phone_Quality_:\'\'),tnt(T_N_T_:\'\'),recordtype(Record_Type_:\'\'),sourcefile(Source_File_:0),iverindicator(Iver_Indicator_:0),phonetype(Phone_Type_:\'\'),validationflag(Validation_Flag_:\'\'),validationdate(Validation_Date_:\'\'),source(Source_:\'\'),originalsource(Original_Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'phone(UID|Phone10_:\'\'),listingtype(Listing_Type_:\'\'),publishcode(Publish_Code_:\'\'),portabilityindicator(Portability_Indicator_:0),nxxtype(N_X_X_Type_:0),coctype(C_O_C_Type_:\'\'),scc(S_C_C_:\'\'),portedmatch(Ported_Match_:0),phoneuse(Phone_Use_:\'\'),phonenumbercompanytype(Phone_Number_Company_Type_:0),priorareacode(Prior_Area_Code_:\'\'),isactive(Is_Active_:\'\'),carriername(Carrier_Name_:\'\'),confidencescore(Confidence_Score_:0),nosolicitcode(No_Solicit_Code_:\'\'),maximumconfidencescore(Maximum_Confidence_Score_:0),minimumconfidencescore(Minimum_Confidence_Score_:0),omitindicator(Omit_Indicator_:\'\'),currentflag(Current_Flag_:\'\'),businessflag(Business_Flag_:\'\'),phonequality(Phone_Quality_:\'\'),tnt(T_N_T_:\'\'),recordtype(Record_Type_:\'\'),sourcefile(Source_File_:0),iverindicator(Iver_Indicator_:0),phonetype(Phone_Type_:\'\'),validationflag(Validation_Flag_:\'\'),validationdate(Validation_Date_:\'\'),src(Source_:\'\'),originalsource(Original_Source_:\'\'),dt_first_seen(Date_First_Seen_:EPOCH:Date_First_Seen_0Rule),dt_last_seen(Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),DPMBitmap(__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Header,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Header),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((UNSIGNED)phone != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid := __d0_KELfiltered((KEL.typ.uid)phone = 0);
  SHARED __d0_Prefiltered := __d0_KELfiltered((KEL.typ.uid)phone <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  SHARED Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'phone(UID|Phone10_:\'\'),listingtype(Listing_Type_:\'\'),publishcode(Publish_Code_:\'\'),portabilityindicator(Portability_Indicator_:0),nxxtype(N_X_X_Type_:0),coctype(C_O_C_Type_:\'\'),scc(S_C_C_:\'\'),portedmatch(Ported_Match_:0),phoneuse(Phone_Use_:\'\'),phonenumbercompanytype(Phone_Number_Company_Type_:0),priorareacode(Prior_Area_Code_:\'\'),isactive(Is_Active_:\'\'),carriername(Carrier_Name_:\'\'),confidencescore(Confidence_Score_:0),nosolicitcode(No_Solicit_Code_:\'\'),maximumconfidencescore(Maximum_Confidence_Score_:0),minimumconfidencescore(Minimum_Confidence_Score_:0),omitindicator(Omit_Indicator_:\'\'),currentflag(Current_Flag_:\'\'),businessflag(Business_Flag_:\'\'),phonequality(Phone_Quality_:\'\'),tnt(T_N_T_:\'\'),recordtype(Record_Type_:\'\'),sourcefile(Source_File_:0),iverindicator(Iver_Indicator_:0),phonetype(Phone_Type_:\'\'),validationflag(Validation_Flag_:\'\'),validationdate(Validation_Date_:\'\'),src(Source_:\'\'),originalsource(Original_Source_:\'\'),dt_first_seen(Date_First_Seen_:EPOCH:Date_First_Seen_1Rule),dt_last_seen(Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),DPMBitmap(__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Header_Quick__Key_Did,TRANSFORM(RECORDOF(__in.Dataset_Header_Quick__Key_Did),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((UNSIGNED)phone != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid := __d1_KELfiltered((KEL.typ.uid)phone = 0);
  SHARED __d1_Prefiltered := __d1_KELfiltered((KEL.typ.uid)phone <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1));
  EXPORT InData := __d0 + __d1;
  EXPORT Header_Phone_Quality_Layout := RECORD
    KEL.typ.nstr Phone_Quality_;
    KEL.typ.nstr T_N_T_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Prior_Area_Codes_Layout := RECORD
    KEL.typ.nstr Prior_Area_Code_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Active_Layout := RECORD
    KEL.typ.nstr Is_Active_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Confidence_Scores_Layout := RECORD
    KEL.typ.nint Confidence_Score_;
    KEL.typ.nint Maximum_Confidence_Score_;
    KEL.typ.nint Minimum_Confidence_Score_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Listing_Types_Layout := RECORD
    KEL.typ.nstr Listing_Type_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Phone_Types_Layout := RECORD
    KEL.typ.nstr Phone_Type_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Record_Types_Layout := RECORD
    KEL.typ.nstr Record_Type_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nstr Original_Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.nint Portability_Indicator_;
    KEL.typ.nstr Current_Flag_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nint N_X_X_Type_;
    KEL.typ.nstr Publish_Code_;
    KEL.typ.nstr C_O_C_Type_;
    KEL.typ.nstr S_C_C_;
    KEL.typ.nint Phone_Number_Company_Type_;
    KEL.typ.nint Ported_Match_;
    KEL.typ.nstr Phone_Use_;
    KEL.typ.nstr No_Solicit_Code_;
    KEL.typ.nstr Omit_Indicator_;
    KEL.typ.ndataset(Header_Phone_Quality_Layout) Header_Phone_Quality_;
    KEL.typ.nint Source_File_;
    KEL.typ.nint Iver_Indicator_;
    KEL.typ.nstr Validation_Flag_;
    KEL.typ.nstr Validation_Date_;
    KEL.typ.nstr Carrier_Name_;
    KEL.typ.ndataset(Prior_Area_Codes_Layout) Prior_Area_Codes_;
    KEL.typ.ndataset(Active_Layout) Active_;
    KEL.typ.ndataset(Confidence_Scores_Layout) Confidence_Scores_;
    KEL.typ.ndataset(Listing_Types_Layout) Listing_Types_;
    KEL.typ.ndataset(Phone_Types_Layout) Phone_Types_;
    KEL.typ.ndataset(Record_Types_Layout) Record_Types_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Phone_Group := __PostFilter;
  Layout Phone__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Phone10_ := KEL.Intake.SingleValue(__recs,Phone10_);
    SELF.Portability_Indicator_ := KEL.Intake.SingleValue(__recs,Portability_Indicator_);
    SELF.Current_Flag_ := KEL.Intake.SingleValue(__recs,Current_Flag_);
    SELF.Business_Flag_ := KEL.Intake.SingleValue(__recs,Business_Flag_);
    SELF.N_X_X_Type_ := KEL.Intake.SingleValue(__recs,N_X_X_Type_);
    SELF.Publish_Code_ := KEL.Intake.SingleValue(__recs,Publish_Code_);
    SELF.C_O_C_Type_ := KEL.Intake.SingleValue(__recs,C_O_C_Type_);
    SELF.S_C_C_ := KEL.Intake.SingleValue(__recs,S_C_C_);
    SELF.Phone_Number_Company_Type_ := KEL.Intake.SingleValue(__recs,Phone_Number_Company_Type_);
    SELF.Ported_Match_ := KEL.Intake.SingleValue(__recs,Ported_Match_);
    SELF.Phone_Use_ := KEL.Intake.SingleValue(__recs,Phone_Use_);
    SELF.No_Solicit_Code_ := KEL.Intake.SingleValue(__recs,No_Solicit_Code_);
    SELF.Omit_Indicator_ := KEL.Intake.SingleValue(__recs,Omit_Indicator_);
    SELF.Header_Phone_Quality_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Phone_Quality_,T_N_T_},Phone_Quality_,T_N_T_),Header_Phone_Quality_Layout)(__NN(Phone_Quality_) OR __NN(T_N_T_)));
    SELF.Source_File_ := KEL.Intake.SingleValue(__recs,Source_File_);
    SELF.Iver_Indicator_ := KEL.Intake.SingleValue(__recs,Iver_Indicator_);
    SELF.Validation_Flag_ := KEL.Intake.SingleValue(__recs,Validation_Flag_);
    SELF.Validation_Date_ := KEL.Intake.SingleValue(__recs,Validation_Date_);
    SELF.Carrier_Name_ := KEL.Intake.SingleValue(__recs,Carrier_Name_);
    SELF.Prior_Area_Codes_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Prior_Area_Code_},Prior_Area_Code_),Prior_Area_Codes_Layout)(__NN(Prior_Area_Code_)));
    SELF.Active_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Is_Active_,Source_},Is_Active_,Source_),Active_Layout)(__NN(Is_Active_) OR __NN(Source_)));
    SELF.Confidence_Scores_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Confidence_Score_,Maximum_Confidence_Score_,Minimum_Confidence_Score_},Confidence_Score_,Maximum_Confidence_Score_,Minimum_Confidence_Score_),Confidence_Scores_Layout)(__NN(Confidence_Score_) OR __NN(Maximum_Confidence_Score_) OR __NN(Minimum_Confidence_Score_)));
    SELF.Listing_Types_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Listing_Type_,Source_},Listing_Type_,Source_),Listing_Types_Layout)(__NN(Listing_Type_) OR __NN(Source_)));
    SELF.Phone_Types_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Phone_Type_,Source_},Phone_Type_,Source_),Phone_Types_Layout)(__NN(Phone_Type_) OR __NN(Source_)));
    SELF.Record_Types_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Record_Type_,Source_},Record_Type_,Source_),Record_Types_Layout)(__NN(Record_Type_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_,Original_Source_},Source_,Original_Source_),Data_Sources_Layout)(__NN(Source_) OR __NN(Original_Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Phone__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Header_Phone_Quality_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Header_Phone_Quality_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Phone_Quality_) OR __NN(T_N_T_)));
    SELF.Prior_Area_Codes_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Prior_Area_Codes_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Prior_Area_Code_)));
    SELF.Active_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Active_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Is_Active_) OR __NN(Source_)));
    SELF.Confidence_Scores_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Confidence_Scores_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Confidence_Score_) OR __NN(Maximum_Confidence_Score_) OR __NN(Minimum_Confidence_Score_)));
    SELF.Listing_Types_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Listing_Types_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Listing_Type_) OR __NN(Source_)));
    SELF.Phone_Types_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Phone_Types_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Phone_Type_) OR __NN(Source_)));
    SELF.Record_Types_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Record_Types_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Record_Type_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_) OR __NN(Original_Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Phone_Group,COUNT(ROWS(LEFT))=1),GROUP,Phone__Single_Rollup(LEFT)) + ROLLUP(HAVING(Phone_Group,COUNT(ROWS(LEFT))>1),GROUP,Phone__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Phone10__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Phone10_);
  EXPORT Portability_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Portability_Indicator_);
  EXPORT Current_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Current_Flag_);
  EXPORT Business_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Business_Flag_);
  EXPORT N_X_X_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,N_X_X_Type_);
  EXPORT Publish_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Publish_Code_);
  EXPORT C_O_C_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,C_O_C_Type_);
  EXPORT S_C_C__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,S_C_C_);
  EXPORT Phone_Number_Company_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Phone_Number_Company_Type_);
  EXPORT Ported_Match__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ported_Match_);
  EXPORT Phone_Use__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Phone_Use_);
  EXPORT No_Solicit_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,No_Solicit_Code_);
  EXPORT Omit_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Omit_Indicator_);
  EXPORT Source_File__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Source_File_);
  EXPORT Iver_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Iver_Indicator_);
  EXPORT Validation_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Validation_Flag_);
  EXPORT Validation_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Validation_Date_);
  EXPORT Carrier_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Carrier_Name_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid),COUNT(Phone10__SingleValue_Invalid),COUNT(Portability_Indicator__SingleValue_Invalid),COUNT(Current_Flag__SingleValue_Invalid),COUNT(Business_Flag__SingleValue_Invalid),COUNT(N_X_X_Type__SingleValue_Invalid),COUNT(Publish_Code__SingleValue_Invalid),COUNT(C_O_C_Type__SingleValue_Invalid),COUNT(S_C_C__SingleValue_Invalid),COUNT(Phone_Number_Company_Type__SingleValue_Invalid),COUNT(Ported_Match__SingleValue_Invalid),COUNT(Phone_Use__SingleValue_Invalid),COUNT(No_Solicit_Code__SingleValue_Invalid),COUNT(Omit_Indicator__SingleValue_Invalid),COUNT(Source_File__SingleValue_Invalid),COUNT(Iver_Indicator__SingleValue_Invalid),COUNT(Validation_Flag__SingleValue_Invalid),COUNT(Validation_Date__SingleValue_Invalid),COUNT(Carrier_Name__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid,KEL.typ.int Phone10__SingleValue_Invalid,KEL.typ.int Portability_Indicator__SingleValue_Invalid,KEL.typ.int Current_Flag__SingleValue_Invalid,KEL.typ.int Business_Flag__SingleValue_Invalid,KEL.typ.int N_X_X_Type__SingleValue_Invalid,KEL.typ.int Publish_Code__SingleValue_Invalid,KEL.typ.int C_O_C_Type__SingleValue_Invalid,KEL.typ.int S_C_C__SingleValue_Invalid,KEL.typ.int Phone_Number_Company_Type__SingleValue_Invalid,KEL.typ.int Ported_Match__SingleValue_Invalid,KEL.typ.int Phone_Use__SingleValue_Invalid,KEL.typ.int No_Solicit_Code__SingleValue_Invalid,KEL.typ.int Omit_Indicator__SingleValue_Invalid,KEL.typ.int Source_File__SingleValue_Invalid,KEL.typ.int Iver_Indicator__SingleValue_Invalid,KEL.typ.int Validation_Flag__SingleValue_Invalid,KEL.typ.int Validation_Date__SingleValue_Invalid,KEL.typ.int Carrier_Name__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid),COUNT(__d0)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d0(__NL(Phone10_))),COUNT(__d0(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d0(__NL(Listing_Type_))),COUNT(__d0(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d0(__NL(Publish_Code_))),COUNT(__d0(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d0(__NL(Portability_Indicator_))),COUNT(__d0(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d0(__NL(N_X_X_Type_))),COUNT(__d0(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d0(__NL(C_O_C_Type_))),COUNT(__d0(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d0(__NL(S_C_C_))),COUNT(__d0(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d0(__NL(Ported_Match_))),COUNT(__d0(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d0(__NL(Phone_Use_))),COUNT(__d0(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d0(__NL(Phone_Number_Company_Type_))),COUNT(__d0(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d0(__NL(Prior_Area_Code_))),COUNT(__d0(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d0(__NL(Is_Active_))),COUNT(__d0(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d0(__NL(Carrier_Name_))),COUNT(__d0(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d0(__NL(Confidence_Score_))),COUNT(__d0(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d0(__NL(No_Solicit_Code_))),COUNT(__d0(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d0(__NL(Maximum_Confidence_Score_))),COUNT(__d0(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d0(__NL(Minimum_Confidence_Score_))),COUNT(__d0(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d0(__NL(Omit_Indicator_))),COUNT(__d0(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d0(__NL(Current_Flag_))),COUNT(__d0(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d0(__NL(Business_Flag_))),COUNT(__d0(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d0(__NL(Phone_Quality_))),COUNT(__d0(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d0(__NL(T_N_T_))),COUNT(__d0(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d0(__NL(Record_Type_))),COUNT(__d0(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d0(__NL(Source_File_))),COUNT(__d0(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d0(__NL(Iver_Indicator_))),COUNT(__d0(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d0(__NL(Phone_Type_))),COUNT(__d0(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d0(__NL(Validation_Flag_))),COUNT(__d0(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d0(__NL(Validation_Date_))),COUNT(__d0(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d0(__NL(Original_Source_))),COUNT(__d0(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid),COUNT(__d1)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d1(__NL(Phone10_))),COUNT(__d1(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d1(__NL(Listing_Type_))),COUNT(__d1(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d1(__NL(Publish_Code_))),COUNT(__d1(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d1(__NL(Portability_Indicator_))),COUNT(__d1(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d1(__NL(N_X_X_Type_))),COUNT(__d1(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d1(__NL(C_O_C_Type_))),COUNT(__d1(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d1(__NL(S_C_C_))),COUNT(__d1(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortedMatch',COUNT(__d1(__NL(Ported_Match_))),COUNT(__d1(__NN(Ported_Match_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneUse',COUNT(__d1(__NL(Phone_Use_))),COUNT(__d1(__NN(Phone_Use_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d1(__NL(Phone_Number_Company_Type_))),COUNT(__d1(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d1(__NL(Prior_Area_Code_))),COUNT(__d1(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d1(__NL(Is_Active_))),COUNT(__d1(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d1(__NL(Carrier_Name_))),COUNT(__d1(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d1(__NL(Confidence_Score_))),COUNT(__d1(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoSolicitCode',COUNT(__d1(__NL(No_Solicit_Code_))),COUNT(__d1(__NN(No_Solicit_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d1(__NL(Maximum_Confidence_Score_))),COUNT(__d1(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d1(__NL(Minimum_Confidence_Score_))),COUNT(__d1(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d1(__NL(Omit_Indicator_))),COUNT(__d1(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentFlag',COUNT(__d1(__NL(Current_Flag_))),COUNT(__d1(__NN(Current_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','BusinessFlag',COUNT(__d1(__NL(Business_Flag_))),COUNT(__d1(__NN(Business_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneQuality',COUNT(__d1(__NL(Phone_Quality_))),COUNT(__d1(__NN(Phone_Quality_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TNT',COUNT(__d1(__NL(T_N_T_))),COUNT(__d1(__NN(T_N_T_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d1(__NL(Record_Type_))),COUNT(__d1(__NN(Record_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d1(__NL(Source_File_))),COUNT(__d1(__NN(Source_File_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IverIndicator',COUNT(__d1(__NL(Iver_Indicator_))),COUNT(__d1(__NN(Iver_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneType',COUNT(__d1(__NL(Phone_Type_))),COUNT(__d1(__NN(Phone_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationFlag',COUNT(__d1(__NL(Validation_Flag_))),COUNT(__d1(__NN(Validation_Flag_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ValidationDate',COUNT(__d1(__NL(Validation_Date_))),COUNT(__d1(__NN(Validation_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalSource',COUNT(__d1(__NL(Original_Source_))),COUNT(__d1(__NN(Original_Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
