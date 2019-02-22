//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Aircraft(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr N_Number_;
    KEL.typ.nstr Serial_Number_;
    KEL.typ.nstr Manufacturer_Model_Code_;
    KEL.typ.nstr Engine_Manufacturer_Model_Code_;
    KEL.typ.nint Year_Manufactured_;
    KEL.typ.nkdate Last_Action_Date_;
    KEL.typ.nint Type_;
    KEL.typ.nstr Type_Engine_;
    KEL.typ.nstr Status_Code_;
    KEL.typ.nstr Transponder_Code_;
    KEL.typ.nstr Fractional_Owner_;
    KEL.typ.nstr Manufacturer_Name_;
    KEL.typ.nstr Model_Name_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),nnumber(N_Number_:\'\'),serialnumber(Serial_Number_:\'\'),manufacturermodelcode(Manufacturer_Model_Code_:\'\'),enginemanufacturermodelcode(Engine_Manufacturer_Model_Code_:\'\'),yearmanufactured(Year_Manufactured_:0),lastactiondate(Last_Action_Date_:DATE),type(Type_:0),typeengine(Type_Engine_:\'\'),statuscode(Status_Code_:\'\'),transpondercode(Transponder_Code_:\'\'),fractionalowner(Fractional_Owner_:\'\'),manufacturername(Manufacturer_Name_:\'\'),modelname(Model_Name_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.NNumber)));
  EXPORT __All_Trim := __d0_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::PublicRecords_KEL::Aircraft::UidLookup',EXPIRE(7));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::PublicRecords_KEL::Aircraft');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::PublicRecords_KEL::Aircraft');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__in,Lookup,TRIM((STRING)LEFT.NNumber) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping));
  EXPORT InData := __d0;
  EXPORT Ownership_Status_Layout := RECORD
    KEL.typ.nstr Status_Code_;
    KEL.typ.nstr Fractional_Owner_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Last_Action_Date_Layout := RECORD
    KEL.typ.nkdate Last_Action_Date_;
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
    KEL.typ.nstr N_Number_;
    KEL.typ.nstr Serial_Number_;
    KEL.typ.nstr Manufacturer_Model_Code_;
    KEL.typ.nstr Engine_Manufacturer_Model_Code_;
    KEL.typ.nint Year_Manufactured_;
    KEL.typ.nint Type_;
    KEL.typ.nstr Type_Engine_;
    KEL.typ.nstr Manufacturer_Name_;
    KEL.typ.nstr Model_Name_;
    KEL.typ.nstr Transponder_Code_;
    KEL.typ.ndataset(Ownership_Status_Layout) Ownership_Status_;
    KEL.typ.ndataset(Last_Action_Date_Layout) Last_Action_Date_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Aircraft_Group := __PostFilter;
  Layout Aircraft__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.N_Number_ := KEL.Intake.SingleValue(__recs,N_Number_);
    SELF.Serial_Number_ := KEL.Intake.SingleValue(__recs,Serial_Number_);
    SELF.Manufacturer_Model_Code_ := KEL.Intake.SingleValue(__recs,Manufacturer_Model_Code_);
    SELF.Engine_Manufacturer_Model_Code_ := KEL.Intake.SingleValue(__recs,Engine_Manufacturer_Model_Code_);
    SELF.Year_Manufactured_ := KEL.Intake.SingleValue(__recs,Year_Manufactured_);
    SELF.Type_ := KEL.Intake.SingleValue(__recs,Type_);
    SELF.Type_Engine_ := KEL.Intake.SingleValue(__recs,Type_Engine_);
    SELF.Manufacturer_Name_ := KEL.Intake.SingleValue(__recs,Manufacturer_Name_);
    SELF.Model_Name_ := KEL.Intake.SingleValue(__recs,Model_Name_);
    SELF.Transponder_Code_ := KEL.Intake.SingleValue(__recs,Transponder_Code_);
    SELF.Ownership_Status_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Status_Code_,Fractional_Owner_},Status_Code_,Fractional_Owner_),Ownership_Status_Layout)(__NN(Status_Code_) OR __NN(Fractional_Owner_)));
    SELF.Last_Action_Date_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Last_Action_Date_},Last_Action_Date_),Last_Action_Date_Layout)(__NN(Last_Action_Date_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Aircraft__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Ownership_Status_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Ownership_Status_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Status_Code_) OR __NN(Fractional_Owner_)));
    SELF.Last_Action_Date_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Last_Action_Date_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Last_Action_Date_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Aircraft_Group,COUNT(ROWS(LEFT))=1),GROUP,Aircraft__Single_Rollup(LEFT)) + ROLLUP(HAVING(Aircraft_Group,COUNT(ROWS(LEFT))>1),GROUP,Aircraft__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::PublicRecords_KEL::Aircraft::Result' + IF(__cfg.PersistId <> '','::' + __cfg.PersistId,''),EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT N_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,N_Number_);
  EXPORT Serial_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Serial_Number_);
  EXPORT Manufacturer_Model_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Manufacturer_Model_Code_);
  EXPORT Engine_Manufacturer_Model_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Engine_Manufacturer_Model_Code_);
  EXPORT Year_Manufactured__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Year_Manufactured_);
  EXPORT Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Type_);
  EXPORT Type_Engine__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Type_Engine_);
  EXPORT Manufacturer_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Manufacturer_Name_);
  EXPORT Model_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Model_Name_);
  EXPORT Transponder_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Transponder_Code_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(N_Number__SingleValue_Invalid),COUNT(Serial_Number__SingleValue_Invalid),COUNT(Manufacturer_Model_Code__SingleValue_Invalid),COUNT(Engine_Manufacturer_Model_Code__SingleValue_Invalid),COUNT(Year_Manufactured__SingleValue_Invalid),COUNT(Type__SingleValue_Invalid),COUNT(Type_Engine__SingleValue_Invalid),COUNT(Manufacturer_Name__SingleValue_Invalid),COUNT(Model_Name__SingleValue_Invalid),COUNT(Transponder_Code__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid,KEL.typ.int N_Number__SingleValue_Invalid,KEL.typ.int Serial_Number__SingleValue_Invalid,KEL.typ.int Manufacturer_Model_Code__SingleValue_Invalid,KEL.typ.int Engine_Manufacturer_Model_Code__SingleValue_Invalid,KEL.typ.int Year_Manufactured__SingleValue_Invalid,KEL.typ.int Type__SingleValue_Invalid,KEL.typ.int Type_Engine__SingleValue_Invalid,KEL.typ.int Manufacturer_Name__SingleValue_Invalid,KEL.typ.int Model_Name__SingleValue_Invalid,KEL.typ.int Transponder_Code__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Aircraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(__d0)},
    {'Aircraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NNumber',COUNT(__d0(__NL(N_Number_))),COUNT(__d0(__NN(N_Number_)))},
    {'Aircraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SerialNumber',COUNT(__d0(__NL(Serial_Number_))),COUNT(__d0(__NN(Serial_Number_)))},
    {'Aircraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ManufacturerModelCode',COUNT(__d0(__NL(Manufacturer_Model_Code_))),COUNT(__d0(__NN(Manufacturer_Model_Code_)))},
    {'Aircraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EngineManufacturerModelCode',COUNT(__d0(__NL(Engine_Manufacturer_Model_Code_))),COUNT(__d0(__NN(Engine_Manufacturer_Model_Code_)))},
    {'Aircraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','YearManufactured',COUNT(__d0(__NL(Year_Manufactured_))),COUNT(__d0(__NN(Year_Manufactured_)))},
    {'Aircraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LastActionDate',COUNT(__d0(__NL(Last_Action_Date_))),COUNT(__d0(__NN(Last_Action_Date_)))},
    {'Aircraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Type',COUNT(__d0(__NL(Type_))),COUNT(__d0(__NN(Type_)))},
    {'Aircraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TypeEngine',COUNT(__d0(__NL(Type_Engine_))),COUNT(__d0(__NN(Type_Engine_)))},
    {'Aircraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StatusCode',COUNT(__d0(__NL(Status_Code_))),COUNT(__d0(__NN(Status_Code_)))},
    {'Aircraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TransponderCode',COUNT(__d0(__NL(Transponder_Code_))),COUNT(__d0(__NN(Transponder_Code_)))},
    {'Aircraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FractionalOwner',COUNT(__d0(__NL(Fractional_Owner_))),COUNT(__d0(__NN(Fractional_Owner_)))},
    {'Aircraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ManufacturerName',COUNT(__d0(__NL(Manufacturer_Name_))),COUNT(__d0(__NN(Manufacturer_Name_)))},
    {'Aircraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ModelName',COUNT(__d0(__NL(Model_Name_))),COUNT(__d0(__NN(Model_Name_)))},
    {'Aircraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Aircraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Aircraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
