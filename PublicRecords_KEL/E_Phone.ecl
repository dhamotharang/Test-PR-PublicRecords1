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
    KEL.typ.nint Area_Code_;
    KEL.typ.nint Phone7_;
    KEL.typ.nkdate Area_Code_Effective_Date_;
    KEL.typ.nkdate Area_Code_Last_Change_Date_;
    KEL.typ.nint Dialable_Indicator_;
    KEL.typ.nstr Listing_Type_;
    KEL.typ.nstr Type_;
    KEL.typ.nstr Publish_Code_;
    KEL.typ.nint Portability_Indicator_;
    KEL.typ.nint Time_Zone_;
    KEL.typ.nint N_X_X_Type_;
    KEL.typ.nstr C_O_C_Type_;
    KEL.typ.nstr S_C_C_;
    KEL.typ.nint Phone_Number_Company_Type_;
    KEL.typ.nstr Usage_;
    KEL.typ.nkdate Registration_Date_;
    KEL.typ.nstr Registration_Place_;
    KEL.typ.nstr Prior_Area_Code_;
    KEL.typ.nbool Is_Active_;
    KEL.typ.nstr Carrier_Code_;
    KEL.typ.nstr Carrier_Name_;
    KEL.typ.nint Confidence_Score_;
    KEL.typ.nint Maximum_Confidence_Score_;
    KEL.typ.nint Minimum_Confidence_Score_;
    KEL.typ.nint Current_Confidence_Score_;
    KEL.typ.nint Seen_Once_Indicator_;
    KEL.typ.nint Owner_Count_;
    KEL.typ.nstr Omit_Indicator_;
    KEL.typ.nint Note_Counter_;
    KEL.typ.nstr Note_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'phone10(UID|Phone10_:\'\'),areacode(Area_Code_:0),phone7(Phone7_:0),areacodeeffectivedate(Area_Code_Effective_Date_:DATE),areacodelastchangedate(Area_Code_Last_Change_Date_:DATE),dialableindicator(Dialable_Indicator_:0),listingtype(Listing_Type_:\'\'),type(Type_:\'\'),publishcode(Publish_Code_:\'\'),portabilityindicator(Portability_Indicator_:0),timezone(Time_Zone_:0),nxxtype(N_X_X_Type_:0),coctype(C_O_C_Type_:\'\'),scc(S_C_C_:\'\'),phonenumbercompanytype(Phone_Number_Company_Type_:0),usage(Usage_:\'\'),registrationdate(Registration_Date_:DATE),registrationplace(Registration_Place_:\'\'),priorareacode(Prior_Area_Code_:\'\'),isactive(Is_Active_),carriercode(Carrier_Code_:\'\'),carriername(Carrier_Name_:\'\'),confidencescore(Confidence_Score_:0),maximumconfidencescore(Maximum_Confidence_Score_:0),minimumconfidencescore(Minimum_Confidence_Score_:0),currentconfidencescore(Current_Confidence_Score_:0),seenonceindicator(Seen_Once_Indicator_:0),ownercount(Owner_Count_:0),omitindicator(Omit_Indicator_:\'\'),notecounter(Note_Counter_:0),note(Note_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'phone(UID|Phone10_:\'\'),areacode(Area_Code_:0),phone7(Phone7_:0),areacodeeffectivedate(Area_Code_Effective_Date_:DATE),areacodelastchangedate(Area_Code_Last_Change_Date_:DATE),dialableindicator(Dialable_Indicator_:0),listingtype(Listing_Type_:\'\'),type(Type_:\'\'),publishcode(Publish_Code_:\'\'),portabilityindicator(Portability_Indicator_:0),timezone(Time_Zone_:0),nxxtype(N_X_X_Type_:0),coctype(C_O_C_Type_:\'\'),scc(S_C_C_:\'\'),phonenumbercompanytype(Phone_Number_Company_Type_:0),usage(Usage_:\'\'),registrationdate(Registration_Date_:DATE),registrationplace(Registration_Place_:\'\'),priorareacode(Prior_Area_Code_:\'\'),isactive(Is_Active_),carriercode(Carrier_Code_:\'\'),carriername(Carrier_Name_:\'\'),confidencescore(Confidence_Score_:0),maximumconfidencescore(Maximum_Confidence_Score_:0),minimumconfidencescore(Minimum_Confidence_Score_:0),currentconfidencescore(Current_Confidence_Score_:0),seenonceindicator(Seen_Once_Indicator_:0),ownercount(Owner_Count_:0),omitindicator(Omit_Indicator_:\'\'),notecounter(Note_Counter_:0),note(Note_:\'\'),src(Source_:\'\'),dt_first_seen(Date_First_Seen_:EPOCH:Date_First_Seen_0Rule),dt_last_seen(Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Header,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Header),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((UNSIGNED)phone != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid := __d0_KELfiltered((KEL.typ.uid)phone = 0);
  SHARED __d0_Prefiltered := __d0_KELfiltered((KEL.typ.uid)phone <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  SHARED Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'phone(UID|Phone10_:\'\'),areacode(Area_Code_:0),phone7(Phone7_:0),areacodeeffectivedate(Area_Code_Effective_Date_:DATE),areacodelastchangedate(Area_Code_Last_Change_Date_:DATE),dialableindicator(Dialable_Indicator_:0),listingtype(Listing_Type_:\'\'),type(Type_:\'\'),publishcode(Publish_Code_:\'\'),portabilityindicator(Portability_Indicator_:0),timezone(Time_Zone_:0),nxxtype(N_X_X_Type_:0),coctype(C_O_C_Type_:\'\'),scc(S_C_C_:\'\'),phonenumbercompanytype(Phone_Number_Company_Type_:0),usage(Usage_:\'\'),registrationdate(Registration_Date_:DATE),registrationplace(Registration_Place_:\'\'),priorareacode(Prior_Area_Code_:\'\'),isactive(Is_Active_),carriercode(Carrier_Code_:\'\'),carriername(Carrier_Name_:\'\'),confidencescore(Confidence_Score_:0),maximumconfidencescore(Maximum_Confidence_Score_:0),minimumconfidencescore(Minimum_Confidence_Score_:0),currentconfidencescore(Current_Confidence_Score_:0),seenonceindicator(Seen_Once_Indicator_:0),ownercount(Owner_Count_:0),omitindicator(Omit_Indicator_:\'\'),notecounter(Note_Counter_:0),note(Note_:\'\'),src(Source_:\'\'),dt_first_seen(Date_First_Seen_:EPOCH:Date_First_Seen_1Rule),dt_last_seen(Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Header_Quick__Key_Did,TRANSFORM(RECORDOF(__in.Dataset_Header_Quick__Key_Did),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((UNSIGNED)phone != 0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid := __d1_KELfiltered((KEL.typ.uid)phone = 0);
  SHARED __d1_Prefiltered := __d1_KELfiltered((KEL.typ.uid)phone <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1));
  EXPORT InData := __d0 + __d1;
  EXPORT Prior_Area_Codes_Layout := RECORD
    KEL.typ.nstr Prior_Area_Code_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Active_Layout := RECORD
    KEL.typ.nbool Is_Active_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Carrier_Layout := RECORD
    KEL.typ.nstr Carrier_Code_;
    KEL.typ.nstr Carrier_Name_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Notes_Layout := RECORD
    KEL.typ.nint Note_Counter_;
    KEL.typ.nstr Note_;
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
    KEL.typ.nstr Phone10_;
    KEL.typ.nint Area_Code_;
    KEL.typ.nint Phone7_;
    KEL.typ.nkdate Area_Code_Effective_Date_;
    KEL.typ.nkdate Area_Code_Last_Change_Date_;
    KEL.typ.nint Dialable_Indicator_;
    KEL.typ.nint Portability_Indicator_;
    KEL.typ.nint Time_Zone_;
    KEL.typ.nstr Listing_Type_;
    KEL.typ.nstr Type_;
    KEL.typ.nint N_X_X_Type_;
    KEL.typ.nstr Publish_Code_;
    KEL.typ.nstr C_O_C_Type_;
    KEL.typ.nstr S_C_C_;
    KEL.typ.nint Phone_Number_Company_Type_;
    KEL.typ.nstr Usage_;
    KEL.typ.nkdate Registration_Date_;
    KEL.typ.nstr Registration_Place_;
    KEL.typ.nint Confidence_Score_;
    KEL.typ.nint Maximum_Confidence_Score_;
    KEL.typ.nint Minimum_Confidence_Score_;
    KEL.typ.nint Current_Confidence_Score_;
    KEL.typ.nint Seen_Once_Indicator_;
    KEL.typ.nint Owner_Count_;
    KEL.typ.nstr Omit_Indicator_;
    KEL.typ.ndataset(Prior_Area_Codes_Layout) Prior_Area_Codes_;
    KEL.typ.ndataset(Active_Layout) Active_;
    KEL.typ.ndataset(Carrier_Layout) Carrier_;
    KEL.typ.ndataset(Notes_Layout) Notes_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Phone_Group := __PostFilter;
  Layout Phone__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Phone10_ := KEL.Intake.SingleValue(__recs,Phone10_);
    SELF.Area_Code_ := KEL.Intake.SingleValue(__recs,Area_Code_);
    SELF.Phone7_ := KEL.Intake.SingleValue(__recs,Phone7_);
    SELF.Area_Code_Effective_Date_ := KEL.Intake.SingleValue(__recs,Area_Code_Effective_Date_);
    SELF.Area_Code_Last_Change_Date_ := KEL.Intake.SingleValue(__recs,Area_Code_Last_Change_Date_);
    SELF.Dialable_Indicator_ := KEL.Intake.SingleValue(__recs,Dialable_Indicator_);
    SELF.Portability_Indicator_ := KEL.Intake.SingleValue(__recs,Portability_Indicator_);
    SELF.Time_Zone_ := KEL.Intake.SingleValue(__recs,Time_Zone_);
    SELF.Listing_Type_ := KEL.Intake.SingleValue(__recs,Listing_Type_);
    SELF.Type_ := KEL.Intake.SingleValue(__recs,Type_);
    SELF.N_X_X_Type_ := KEL.Intake.SingleValue(__recs,N_X_X_Type_);
    SELF.Publish_Code_ := KEL.Intake.SingleValue(__recs,Publish_Code_);
    SELF.C_O_C_Type_ := KEL.Intake.SingleValue(__recs,C_O_C_Type_);
    SELF.S_C_C_ := KEL.Intake.SingleValue(__recs,S_C_C_);
    SELF.Phone_Number_Company_Type_ := KEL.Intake.SingleValue(__recs,Phone_Number_Company_Type_);
    SELF.Usage_ := KEL.Intake.SingleValue(__recs,Usage_);
    SELF.Registration_Date_ := KEL.Intake.SingleValue(__recs,Registration_Date_);
    SELF.Registration_Place_ := KEL.Intake.SingleValue(__recs,Registration_Place_);
    SELF.Confidence_Score_ := KEL.Intake.SingleValue(__recs,Confidence_Score_);
    SELF.Maximum_Confidence_Score_ := KEL.Intake.SingleValue(__recs,Maximum_Confidence_Score_);
    SELF.Minimum_Confidence_Score_ := KEL.Intake.SingleValue(__recs,Minimum_Confidence_Score_);
    SELF.Current_Confidence_Score_ := KEL.Intake.SingleValue(__recs,Current_Confidence_Score_);
    SELF.Seen_Once_Indicator_ := KEL.Intake.SingleValue(__recs,Seen_Once_Indicator_);
    SELF.Owner_Count_ := KEL.Intake.SingleValue(__recs,Owner_Count_);
    SELF.Omit_Indicator_ := KEL.Intake.SingleValue(__recs,Omit_Indicator_);
    SELF.Prior_Area_Codes_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Prior_Area_Code_},Prior_Area_Code_),Prior_Area_Codes_Layout)(__NN(Prior_Area_Code_)));
    SELF.Active_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Is_Active_},Is_Active_),Active_Layout)(__NN(Is_Active_)));
    SELF.Carrier_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Carrier_Code_,Carrier_Name_},Carrier_Code_,Carrier_Name_),Carrier_Layout)(__NN(Carrier_Code_) OR __NN(Carrier_Name_)));
    SELF.Notes_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Note_Counter_,Note_},Note_Counter_,Note_),Notes_Layout)(__NN(Note_Counter_) OR __NN(Note_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Phone__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Prior_Area_Codes_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Prior_Area_Codes_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Prior_Area_Code_)));
    SELF.Active_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Active_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Is_Active_)));
    SELF.Carrier_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Carrier_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Carrier_Code_) OR __NN(Carrier_Name_)));
    SELF.Notes_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Notes_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Note_Counter_) OR __NN(Note_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Phone_Group,COUNT(ROWS(LEFT))=1),GROUP,Phone__Single_Rollup(LEFT)) + ROLLUP(HAVING(Phone_Group,COUNT(ROWS(LEFT))>1),GROUP,Phone__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::PublicRecords_KEL::Phone::Result' + IF(__cfg.PersistId <> '','::' + __cfg.PersistId,''),EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Phone10__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Phone10_);
  EXPORT Area_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Area_Code_);
  EXPORT Phone7__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Phone7_);
  EXPORT Area_Code_Effective_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Area_Code_Effective_Date_);
  EXPORT Area_Code_Last_Change_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Area_Code_Last_Change_Date_);
  EXPORT Dialable_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Dialable_Indicator_);
  EXPORT Portability_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Portability_Indicator_);
  EXPORT Time_Zone__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Time_Zone_);
  EXPORT Listing_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Listing_Type_);
  EXPORT Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Type_);
  EXPORT N_X_X_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,N_X_X_Type_);
  EXPORT Publish_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Publish_Code_);
  EXPORT C_O_C_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,C_O_C_Type_);
  EXPORT S_C_C__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,S_C_C_);
  EXPORT Phone_Number_Company_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Phone_Number_Company_Type_);
  EXPORT Usage__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Usage_);
  EXPORT Registration_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Registration_Date_);
  EXPORT Registration_Place__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Registration_Place_);
  EXPORT Confidence_Score__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Confidence_Score_);
  EXPORT Maximum_Confidence_Score__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Maximum_Confidence_Score_);
  EXPORT Minimum_Confidence_Score__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Minimum_Confidence_Score_);
  EXPORT Current_Confidence_Score__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Current_Confidence_Score_);
  EXPORT Seen_Once_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Seen_Once_Indicator_);
  EXPORT Owner_Count__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Owner_Count_);
  EXPORT Omit_Indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Omit_Indicator_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid),COUNT(Phone10__SingleValue_Invalid),COUNT(Area_Code__SingleValue_Invalid),COUNT(Phone7__SingleValue_Invalid),COUNT(Area_Code_Effective_Date__SingleValue_Invalid),COUNT(Area_Code_Last_Change_Date__SingleValue_Invalid),COUNT(Dialable_Indicator__SingleValue_Invalid),COUNT(Portability_Indicator__SingleValue_Invalid),COUNT(Time_Zone__SingleValue_Invalid),COUNT(Listing_Type__SingleValue_Invalid),COUNT(Type__SingleValue_Invalid),COUNT(N_X_X_Type__SingleValue_Invalid),COUNT(Publish_Code__SingleValue_Invalid),COUNT(C_O_C_Type__SingleValue_Invalid),COUNT(S_C_C__SingleValue_Invalid),COUNT(Phone_Number_Company_Type__SingleValue_Invalid),COUNT(Usage__SingleValue_Invalid),COUNT(Registration_Date__SingleValue_Invalid),COUNT(Registration_Place__SingleValue_Invalid),COUNT(Confidence_Score__SingleValue_Invalid),COUNT(Maximum_Confidence_Score__SingleValue_Invalid),COUNT(Minimum_Confidence_Score__SingleValue_Invalid),COUNT(Current_Confidence_Score__SingleValue_Invalid),COUNT(Seen_Once_Indicator__SingleValue_Invalid),COUNT(Owner_Count__SingleValue_Invalid),COUNT(Omit_Indicator__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid,KEL.typ.int Phone10__SingleValue_Invalid,KEL.typ.int Area_Code__SingleValue_Invalid,KEL.typ.int Phone7__SingleValue_Invalid,KEL.typ.int Area_Code_Effective_Date__SingleValue_Invalid,KEL.typ.int Area_Code_Last_Change_Date__SingleValue_Invalid,KEL.typ.int Dialable_Indicator__SingleValue_Invalid,KEL.typ.int Portability_Indicator__SingleValue_Invalid,KEL.typ.int Time_Zone__SingleValue_Invalid,KEL.typ.int Listing_Type__SingleValue_Invalid,KEL.typ.int Type__SingleValue_Invalid,KEL.typ.int N_X_X_Type__SingleValue_Invalid,KEL.typ.int Publish_Code__SingleValue_Invalid,KEL.typ.int C_O_C_Type__SingleValue_Invalid,KEL.typ.int S_C_C__SingleValue_Invalid,KEL.typ.int Phone_Number_Company_Type__SingleValue_Invalid,KEL.typ.int Usage__SingleValue_Invalid,KEL.typ.int Registration_Date__SingleValue_Invalid,KEL.typ.int Registration_Place__SingleValue_Invalid,KEL.typ.int Confidence_Score__SingleValue_Invalid,KEL.typ.int Maximum_Confidence_Score__SingleValue_Invalid,KEL.typ.int Minimum_Confidence_Score__SingleValue_Invalid,KEL.typ.int Current_Confidence_Score__SingleValue_Invalid,KEL.typ.int Seen_Once_Indicator__SingleValue_Invalid,KEL.typ.int Owner_Count__SingleValue_Invalid,KEL.typ.int Omit_Indicator__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid),COUNT(__d0)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d0(__NL(Phone10_))),COUNT(__d0(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AreaCode',COUNT(__d0(__NL(Area_Code_))),COUNT(__d0(__NN(Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Phone7',COUNT(__d0(__NL(Phone7_))),COUNT(__d0(__NN(Phone7_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AreaCodeEffectiveDate',COUNT(__d0(__NL(Area_Code_Effective_Date_))),COUNT(__d0(__NN(Area_Code_Effective_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AreaCodeLastChangeDate',COUNT(__d0(__NL(Area_Code_Last_Change_Date_))),COUNT(__d0(__NN(Area_Code_Last_Change_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DialableIndicator',COUNT(__d0(__NL(Dialable_Indicator_))),COUNT(__d0(__NN(Dialable_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d0(__NL(Listing_Type_))),COUNT(__d0(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Type',COUNT(__d0(__NL(Type_))),COUNT(__d0(__NN(Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d0(__NL(Publish_Code_))),COUNT(__d0(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d0(__NL(Portability_Indicator_))),COUNT(__d0(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TimeZone',COUNT(__d0(__NL(Time_Zone_))),COUNT(__d0(__NN(Time_Zone_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d0(__NL(N_X_X_Type_))),COUNT(__d0(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d0(__NL(C_O_C_Type_))),COUNT(__d0(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d0(__NL(S_C_C_))),COUNT(__d0(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d0(__NL(Phone_Number_Company_Type_))),COUNT(__d0(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Usage',COUNT(__d0(__NL(Usage_))),COUNT(__d0(__NN(Usage_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RegistrationDate',COUNT(__d0(__NL(Registration_Date_))),COUNT(__d0(__NN(Registration_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RegistrationPlace',COUNT(__d0(__NL(Registration_Place_))),COUNT(__d0(__NN(Registration_Place_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d0(__NL(Prior_Area_Code_))),COUNT(__d0(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d0(__NL(Is_Active_))),COUNT(__d0(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierCode',COUNT(__d0(__NL(Carrier_Code_))),COUNT(__d0(__NN(Carrier_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d0(__NL(Carrier_Name_))),COUNT(__d0(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d0(__NL(Confidence_Score_))),COUNT(__d0(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d0(__NL(Maximum_Confidence_Score_))),COUNT(__d0(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d0(__NL(Minimum_Confidence_Score_))),COUNT(__d0(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentConfidenceScore',COUNT(__d0(__NL(Current_Confidence_Score_))),COUNT(__d0(__NN(Current_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeenOnceIndicator',COUNT(__d0(__NL(Seen_Once_Indicator_))),COUNT(__d0(__NN(Seen_Once_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerCount',COUNT(__d0(__NL(Owner_Count_))),COUNT(__d0(__NN(Owner_Count_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d0(__NL(Omit_Indicator_))),COUNT(__d0(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoteCounter',COUNT(__d0(__NL(Note_Counter_))),COUNT(__d0(__NN(Note_Counter_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Note',COUNT(__d0(__NL(Note_))),COUNT(__d0(__NN(Note_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Header_Quick__Key_Did_Invalid),COUNT(__d1)},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d1(__NL(Phone10_))),COUNT(__d1(__NN(Phone10_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AreaCode',COUNT(__d1(__NL(Area_Code_))),COUNT(__d1(__NN(Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Phone7',COUNT(__d1(__NL(Phone7_))),COUNT(__d1(__NN(Phone7_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AreaCodeEffectiveDate',COUNT(__d1(__NL(Area_Code_Effective_Date_))),COUNT(__d1(__NN(Area_Code_Effective_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AreaCodeLastChangeDate',COUNT(__d1(__NL(Area_Code_Last_Change_Date_))),COUNT(__d1(__NN(Area_Code_Last_Change_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DialableIndicator',COUNT(__d1(__NL(Dialable_Indicator_))),COUNT(__d1(__NN(Dialable_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ListingType',COUNT(__d1(__NL(Listing_Type_))),COUNT(__d1(__NN(Listing_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Type',COUNT(__d1(__NL(Type_))),COUNT(__d1(__NN(Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PublishCode',COUNT(__d1(__NL(Publish_Code_))),COUNT(__d1(__NN(Publish_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PortabilityIndicator',COUNT(__d1(__NL(Portability_Indicator_))),COUNT(__d1(__NN(Portability_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TimeZone',COUNT(__d1(__NL(Time_Zone_))),COUNT(__d1(__NN(Time_Zone_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NXXType',COUNT(__d1(__NL(N_X_X_Type_))),COUNT(__d1(__NN(N_X_X_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','COCType',COUNT(__d1(__NL(C_O_C_Type_))),COUNT(__d1(__NN(C_O_C_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SCC',COUNT(__d1(__NL(S_C_C_))),COUNT(__d1(__NN(S_C_C_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumberCompanyType',COUNT(__d1(__NL(Phone_Number_Company_Type_))),COUNT(__d1(__NN(Phone_Number_Company_Type_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Usage',COUNT(__d1(__NL(Usage_))),COUNT(__d1(__NN(Usage_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RegistrationDate',COUNT(__d1(__NL(Registration_Date_))),COUNT(__d1(__NN(Registration_Date_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RegistrationPlace',COUNT(__d1(__NL(Registration_Place_))),COUNT(__d1(__NN(Registration_Place_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PriorAreaCode',COUNT(__d1(__NL(Prior_Area_Code_))),COUNT(__d1(__NN(Prior_Area_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsActive',COUNT(__d1(__NL(Is_Active_))),COUNT(__d1(__NN(Is_Active_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierCode',COUNT(__d1(__NL(Carrier_Code_))),COUNT(__d1(__NN(Carrier_Code_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CarrierName',COUNT(__d1(__NL(Carrier_Name_))),COUNT(__d1(__NN(Carrier_Name_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConfidenceScore',COUNT(__d1(__NL(Confidence_Score_))),COUNT(__d1(__NN(Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumConfidenceScore',COUNT(__d1(__NL(Maximum_Confidence_Score_))),COUNT(__d1(__NN(Maximum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumConfidenceScore',COUNT(__d1(__NL(Minimum_Confidence_Score_))),COUNT(__d1(__NN(Minimum_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentConfidenceScore',COUNT(__d1(__NL(Current_Confidence_Score_))),COUNT(__d1(__NN(Current_Confidence_Score_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SeenOnceIndicator',COUNT(__d1(__NL(Seen_Once_Indicator_))),COUNT(__d1(__NN(Seen_Once_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OwnerCount',COUNT(__d1(__NL(Owner_Count_))),COUNT(__d1(__NN(Owner_Count_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OmitIndicator',COUNT(__d1(__NL(Omit_Indicator_))),COUNT(__d1(__NN(Omit_Indicator_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NoteCounter',COUNT(__d1(__NL(Note_Counter_))),COUNT(__d1(__NN(Note_Counter_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Note',COUNT(__d1(__NL(Note_))),COUNT(__d1(__NN(Note_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Phone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
