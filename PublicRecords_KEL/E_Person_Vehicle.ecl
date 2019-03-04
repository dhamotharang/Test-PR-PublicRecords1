//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Person,E_Vehicle FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Person_Vehicle(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Vehicle().Typ) Automobile_;
    KEL.typ.nbool Is_Minor_;
    KEL.typ.nkdate Registration_First_Date_;
    KEL.typ.nkdate Registration_Earliest_Effective_Date_;
    KEL.typ.nkdate Registration_Latest_Effective_Date_;
    KEL.typ.nkdate Registration_Latest_Expiratione_Date_;
    KEL.typ.nint Registration_Record_Count_;
    KEL.typ.nstr Registration_Decal_Number_;
    KEL.typ.nint Registratoin_Decal_Year_;
    KEL.typ.nstr Registration_Status_Code_;
    KEL.typ.nstr Registration_Status_Description_;
    KEL.typ.nstr Registration_True_License_Plate_;
    KEL.typ.nstr Registration_License_Plate_;
    KEL.typ.nstr Registration_License_State_;
    KEL.typ.nstr Registration_License_Plate_Type_Code_;
    KEL.typ.nstr Registration_License_Plate_Type_Description_;
    KEL.typ.nstr Registration_Previous_License_State_;
    KEL.typ.nstr Registration_Previous_License_Plate_;
    KEL.typ.nstr Title_Number_;
    KEL.typ.nkdate Title_Earliest_Issue_Date_;
    KEL.typ.nkdate Title_Latest_Issue_Date_;
    KEL.typ.nkdate Title_Previous_Issue_Date_;
    KEL.typ.nint Title_Record_Count_;
    KEL.typ.nstr Title_Status_Code_;
    KEL.typ.nstr Title_Status_Description_;
    KEL.typ.nint Title_Odometer_Mileage_;
    KEL.typ.nstr Title_Odometer_Status_Code_;
    KEL.typ.nstr Title_Odometer_Status_Description_;
    KEL.typ.nkdate Title_Odometer_Date_;
    KEL.typ.nstr Sequence_Key_;
    KEL.typ.nstr History_;
    KEL.typ.nbool History_Source_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'subject(Subject_:0),Automobile_(Automobile_:0),isminor(Is_Minor_),registrationfirstdate(Registration_First_Date_:DATE),registrationearliesteffectivedate(Registration_Earliest_Effective_Date_:DATE),registrationlatesteffectivedate(Registration_Latest_Effective_Date_:DATE),registrationlatestexpirationedate(Registration_Latest_Expiratione_Date_:DATE),registrationrecordcount(Registration_Record_Count_:0),registrationdecalnumber(Registration_Decal_Number_:\'\'),registratoindecalyear(Registratoin_Decal_Year_:0),registrationstatuscode(Registration_Status_Code_:\'\'),registrationstatusdescription(Registration_Status_Description_:\'\'),registrationtruelicenseplate(Registration_True_License_Plate_:\'\'),registrationlicenseplate(Registration_License_Plate_:\'\'),registrationlicensestate(Registration_License_State_:\'\'),registrationlicenseplatetypecode(Registration_License_Plate_Type_Code_:\'\'),registrationlicenseplatetypedescription(Registration_License_Plate_Type_Description_:\'\'),registrationpreviouslicensestate(Registration_Previous_License_State_:\'\'),registrationpreviouslicenseplate(Registration_Previous_License_Plate_:\'\'),titlenumber(Title_Number_:\'\'),titleearliestissuedate(Title_Earliest_Issue_Date_:DATE),titlelatestissuedate(Title_Latest_Issue_Date_:DATE),titlepreviousissuedate(Title_Previous_Issue_Date_:DATE),titlerecordcount(Title_Record_Count_:0),titlestatuscode(Title_Status_Code_:\'\'),titlestatusdescription(Title_Status_Description_:\'\'),titleodometermileage(Title_Odometer_Mileage_:0),titleodometerstatuscode(Title_Odometer_Status_Code_:\'\'),titleodometerstatusdescription(Title_Odometer_Status_Description_:\'\'),titleodometerdate(Title_Odometer_Date_:DATE),sequencekey(Sequence_Key_:\'\'),history(History_:\'\'),historysource(History_Source_),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d0_Automobile__Layout := RECORD
    RECORDOF(__in);
    KEL.typ.uid Automobile_;
  END;
  SHARED __d0_Automobile__Mapped := JOIN(__in,E_Vehicle(__in,__cfg).Lookup,TRIM((STRING)LEFT.VehicleKey) = RIGHT.KeyVal,TRANSFORM(__d0_Automobile__Layout,SELF.Automobile_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Automobile__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping));
  EXPORT InData := __d0;
  EXPORT Minor_Layout := RECORD
    KEL.typ.nbool Is_Minor_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Registration_Layout := RECORD
    KEL.typ.nkdate Registration_First_Date_;
    KEL.typ.nkdate Registration_Earliest_Effective_Date_;
    KEL.typ.nkdate Registration_Latest_Effective_Date_;
    KEL.typ.nkdate Registration_Latest_Expiratione_Date_;
    KEL.typ.nint Registration_Record_Count_;
    KEL.typ.nstr Registration_Decal_Number_;
    KEL.typ.nint Registratoin_Decal_Year_;
    KEL.typ.nstr Registration_Status_Code_;
    KEL.typ.nstr Registration_Status_Description_;
    KEL.typ.nstr Registration_True_License_Plate_;
    KEL.typ.nstr Registration_License_Plate_;
    KEL.typ.nstr Registration_License_State_;
    KEL.typ.nstr Registration_License_Plate_Type_Code_;
    KEL.typ.nstr Registration_License_Plate_Type_Description_;
    KEL.typ.nstr Registration_Previous_License_State_;
    KEL.typ.nstr Registration_Previous_License_Plate_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Title_Layout := RECORD
    KEL.typ.nstr Title_Number_;
    KEL.typ.nkdate Title_Earliest_Issue_Date_;
    KEL.typ.nkdate Title_Latest_Issue_Date_;
    KEL.typ.nkdate Title_Previous_Issue_Date_;
    KEL.typ.nint Title_Record_Count_;
    KEL.typ.nstr Title_Status_Code_;
    KEL.typ.nstr Title_Status_Description_;
    KEL.typ.nint Title_Odometer_Mileage_;
    KEL.typ.nstr Title_Odometer_Status_Code_;
    KEL.typ.nstr Title_Odometer_Status_Description_;
    KEL.typ.nkdate Title_Odometer_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Counts_Model_Layout := RECORD
    KEL.typ.nstr Sequence_Key_;
    KEL.typ.nstr History_;
    KEL.typ.nbool History_Source_;
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
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Vehicle().Typ) Automobile_;
    KEL.typ.ndataset(Minor_Layout) Minor_;
    KEL.typ.ndataset(Registration_Layout) Registration_;
    KEL.typ.ndataset(Title_Layout) Title_;
    KEL.typ.ndataset(Counts_Model_Layout) Counts_Model_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Subject_,Automobile_,ALL));
  Person_Vehicle_Group := __PostFilter;
  Layout Person_Vehicle__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Minor_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Is_Minor_},Is_Minor_),Minor_Layout)(__NN(Is_Minor_)));
    SELF.Registration_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Registration_First_Date_,Registration_Earliest_Effective_Date_,Registration_Latest_Effective_Date_,Registration_Latest_Expiratione_Date_,Registration_Record_Count_,Registration_Decal_Number_,Registratoin_Decal_Year_,Registration_Status_Code_,Registration_Status_Description_,Registration_True_License_Plate_,Registration_License_Plate_,Registration_License_State_,Registration_License_Plate_Type_Code_,Registration_License_Plate_Type_Description_,Registration_Previous_License_State_,Registration_Previous_License_Plate_},Registration_First_Date_,Registration_Earliest_Effective_Date_,Registration_Latest_Effective_Date_,Registration_Latest_Expiratione_Date_,Registration_Record_Count_,Registration_Decal_Number_,Registratoin_Decal_Year_,Registration_Status_Code_,Registration_Status_Description_,Registration_True_License_Plate_,Registration_License_Plate_,Registration_License_State_,Registration_License_Plate_Type_Code_,Registration_License_Plate_Type_Description_,Registration_Previous_License_State_,Registration_Previous_License_Plate_),Registration_Layout)(__NN(Registration_First_Date_) OR __NN(Registration_Earliest_Effective_Date_) OR __NN(Registration_Latest_Effective_Date_) OR __NN(Registration_Latest_Expiratione_Date_) OR __NN(Registration_Record_Count_) OR __NN(Registration_Decal_Number_) OR __NN(Registratoin_Decal_Year_) OR __NN(Registration_Status_Code_) OR __NN(Registration_Status_Description_) OR __NN(Registration_True_License_Plate_) OR __NN(Registration_License_Plate_) OR __NN(Registration_License_State_) OR __NN(Registration_License_Plate_Type_Code_) OR __NN(Registration_License_Plate_Type_Description_) OR __NN(Registration_Previous_License_State_) OR __NN(Registration_Previous_License_Plate_)));
    SELF.Title_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Title_Number_,Title_Earliest_Issue_Date_,Title_Latest_Issue_Date_,Title_Previous_Issue_Date_,Title_Record_Count_,Title_Status_Code_,Title_Status_Description_,Title_Odometer_Mileage_,Title_Odometer_Status_Code_,Title_Odometer_Status_Description_,Title_Odometer_Date_},Title_Number_,Title_Earliest_Issue_Date_,Title_Latest_Issue_Date_,Title_Previous_Issue_Date_,Title_Record_Count_,Title_Status_Code_,Title_Status_Description_,Title_Odometer_Mileage_,Title_Odometer_Status_Code_,Title_Odometer_Status_Description_,Title_Odometer_Date_),Title_Layout)(__NN(Title_Number_) OR __NN(Title_Earliest_Issue_Date_) OR __NN(Title_Latest_Issue_Date_) OR __NN(Title_Previous_Issue_Date_) OR __NN(Title_Record_Count_) OR __NN(Title_Status_Code_) OR __NN(Title_Status_Description_) OR __NN(Title_Odometer_Mileage_) OR __NN(Title_Odometer_Status_Code_) OR __NN(Title_Odometer_Status_Description_) OR __NN(Title_Odometer_Date_)));
    SELF.Counts_Model_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Sequence_Key_,History_,History_Source_},Sequence_Key_,History_,History_Source_),Counts_Model_Layout)(__NN(Sequence_Key_) OR __NN(History_) OR __NN(History_Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Person_Vehicle__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Minor_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Minor_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Is_Minor_)));
    SELF.Registration_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Registration_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Registration_First_Date_) OR __NN(Registration_Earliest_Effective_Date_) OR __NN(Registration_Latest_Effective_Date_) OR __NN(Registration_Latest_Expiratione_Date_) OR __NN(Registration_Record_Count_) OR __NN(Registration_Decal_Number_) OR __NN(Registratoin_Decal_Year_) OR __NN(Registration_Status_Code_) OR __NN(Registration_Status_Description_) OR __NN(Registration_True_License_Plate_) OR __NN(Registration_License_Plate_) OR __NN(Registration_License_State_) OR __NN(Registration_License_Plate_Type_Code_) OR __NN(Registration_License_Plate_Type_Description_) OR __NN(Registration_Previous_License_State_) OR __NN(Registration_Previous_License_Plate_)));
    SELF.Title_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Title_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Title_Number_) OR __NN(Title_Earliest_Issue_Date_) OR __NN(Title_Latest_Issue_Date_) OR __NN(Title_Previous_Issue_Date_) OR __NN(Title_Record_Count_) OR __NN(Title_Status_Code_) OR __NN(Title_Status_Description_) OR __NN(Title_Odometer_Mileage_) OR __NN(Title_Odometer_Status_Code_) OR __NN(Title_Odometer_Status_Description_) OR __NN(Title_Odometer_Date_)));
    SELF.Counts_Model_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Counts_Model_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Sequence_Key_) OR __NN(History_) OR __NN(History_Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_Vehicle_Group,COUNT(ROWS(LEFT))=1),GROUP,Person_Vehicle__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_Vehicle_Group,COUNT(ROWS(LEFT))>1),GROUP,Person_Vehicle__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person(__in,__cfg).__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Automobile__Orphan := JOIN(InData(__NN(Automobile_)),E_Vehicle(__in,__cfg).__Result,__EEQP(LEFT.Automobile_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Subject__Orphan),COUNT(Automobile__Orphan)}],{KEL.typ.int Subject__Orphan,KEL.typ.int Automobile__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Subject',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Automobile',COUNT(__d0(__NL(Automobile_))),COUNT(__d0(__NN(Automobile_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsMinor',COUNT(__d0(__NL(Is_Minor_))),COUNT(__d0(__NN(Is_Minor_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RegistrationFirstDate',COUNT(__d0(__NL(Registration_First_Date_))),COUNT(__d0(__NN(Registration_First_Date_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RegistrationEarliestEffectiveDate',COUNT(__d0(__NL(Registration_Earliest_Effective_Date_))),COUNT(__d0(__NN(Registration_Earliest_Effective_Date_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RegistrationLatestEffectiveDate',COUNT(__d0(__NL(Registration_Latest_Effective_Date_))),COUNT(__d0(__NN(Registration_Latest_Effective_Date_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RegistrationLatestExpirationeDate',COUNT(__d0(__NL(Registration_Latest_Expiratione_Date_))),COUNT(__d0(__NN(Registration_Latest_Expiratione_Date_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RegistrationRecordCount',COUNT(__d0(__NL(Registration_Record_Count_))),COUNT(__d0(__NN(Registration_Record_Count_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RegistrationDecalNumber',COUNT(__d0(__NL(Registration_Decal_Number_))),COUNT(__d0(__NN(Registration_Decal_Number_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RegistratoinDecalYear',COUNT(__d0(__NL(Registratoin_Decal_Year_))),COUNT(__d0(__NN(Registratoin_Decal_Year_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RegistrationStatusCode',COUNT(__d0(__NL(Registration_Status_Code_))),COUNT(__d0(__NN(Registration_Status_Code_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RegistrationStatusDescription',COUNT(__d0(__NL(Registration_Status_Description_))),COUNT(__d0(__NN(Registration_Status_Description_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RegistrationTrueLicensePlate',COUNT(__d0(__NL(Registration_True_License_Plate_))),COUNT(__d0(__NN(Registration_True_License_Plate_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RegistrationLicensePlate',COUNT(__d0(__NL(Registration_License_Plate_))),COUNT(__d0(__NN(Registration_License_Plate_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RegistrationLicenseState',COUNT(__d0(__NL(Registration_License_State_))),COUNT(__d0(__NN(Registration_License_State_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RegistrationLicensePlateTypeCode',COUNT(__d0(__NL(Registration_License_Plate_Type_Code_))),COUNT(__d0(__NN(Registration_License_Plate_Type_Code_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RegistrationLicensePlateTypeDescription',COUNT(__d0(__NL(Registration_License_Plate_Type_Description_))),COUNT(__d0(__NN(Registration_License_Plate_Type_Description_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RegistrationPreviousLicenseState',COUNT(__d0(__NL(Registration_Previous_License_State_))),COUNT(__d0(__NN(Registration_Previous_License_State_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RegistrationPreviousLicensePlate',COUNT(__d0(__NL(Registration_Previous_License_Plate_))),COUNT(__d0(__NN(Registration_Previous_License_Plate_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TitleNumber',COUNT(__d0(__NL(Title_Number_))),COUNT(__d0(__NN(Title_Number_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TitleEarliestIssueDate',COUNT(__d0(__NL(Title_Earliest_Issue_Date_))),COUNT(__d0(__NN(Title_Earliest_Issue_Date_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TitleLatestIssueDate',COUNT(__d0(__NL(Title_Latest_Issue_Date_))),COUNT(__d0(__NN(Title_Latest_Issue_Date_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TitlePreviousIssueDate',COUNT(__d0(__NL(Title_Previous_Issue_Date_))),COUNT(__d0(__NN(Title_Previous_Issue_Date_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TitleRecordCount',COUNT(__d0(__NL(Title_Record_Count_))),COUNT(__d0(__NN(Title_Record_Count_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TitleStatusCode',COUNT(__d0(__NL(Title_Status_Code_))),COUNT(__d0(__NN(Title_Status_Code_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TitleStatusDescription',COUNT(__d0(__NL(Title_Status_Description_))),COUNT(__d0(__NN(Title_Status_Description_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TitleOdometerMileage',COUNT(__d0(__NL(Title_Odometer_Mileage_))),COUNT(__d0(__NN(Title_Odometer_Mileage_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TitleOdometerStatusCode',COUNT(__d0(__NL(Title_Odometer_Status_Code_))),COUNT(__d0(__NN(Title_Odometer_Status_Code_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TitleOdometerStatusDescription',COUNT(__d0(__NL(Title_Odometer_Status_Description_))),COUNT(__d0(__NN(Title_Odometer_Status_Description_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TitleOdometerDate',COUNT(__d0(__NL(Title_Odometer_Date_))),COUNT(__d0(__NN(Title_Odometer_Date_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SequenceKey',COUNT(__d0(__NL(Sequence_Key_))),COUNT(__d0(__NN(Sequence_Key_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','History',COUNT(__d0(__NL(History_))),COUNT(__d0(__NN(History_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HistorySource',COUNT(__d0(__NL(History_Source_))),COUNT(__d0(__NN(History_Source_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
