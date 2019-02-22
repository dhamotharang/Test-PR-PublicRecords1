//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Professional_License(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nkdate Date_Created_;
    KEL.typ.nstr License_State_;
    KEL.typ.nkdate Date_Processed_;
    KEL.typ.nstr Legacy_Result_Code_;
    KEL.typ.nstr Source_Description_;
    KEL.typ.nstr Source_Code_;
    KEL.typ.nkdate Date_First_Reported_;
    KEL.typ.nkdate Date_Last_Reported_;
    KEL.typ.nkdate Date_Last_Updated_;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr License_Business_Flag_;
    KEL.typ.nstr License_Profession_Code_;
    KEL.typ.nstr License_Profession_Description_;
    KEL.typ.nstr License_Status_;
    KEL.typ.nstr License_Description_;
    KEL.typ.nkdate Date_Of_Issuance_;
    KEL.typ.nkdate Date_Of_Expiration_;
    KEL.typ.nint Nationwide_Mortgage_Licensing_System_;
    KEL.typ.nkdate Date_Of_License_Renewal_;
    KEL.typ.nstr Affiliated_Type_Code_;
    KEL.typ.nint Foreign_Nationwide_Mortgage_Licensing_System_;
    KEL.typ.nstr Location_Type_;
    KEL.typ.nstr Name_Type_;
    KEL.typ.nkdate Start_Date_;
    KEL.typ.nstr Is_Authorized_License_;
    KEL.typ.nstr Is_Authorized_Conduct_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),datecreated(Date_Created_:DATE),licensestate(License_State_:\'\'),dateprocessed(Date_Processed_:DATE),legacyresultcode(Legacy_Result_Code_:\'\'),sourcedescription(Source_Description_:\'\'),sourcecode(Source_Code_:\'\'),datefirstreported(Date_First_Reported_:DATE),datelastreported(Date_Last_Reported_:DATE),datelastupdated(Date_Last_Updated_:DATE),licensenumber(License_Number_:\'\'),licensebusinessflag(License_Business_Flag_:\'\'),licenseprofessioncode(License_Profession_Code_:\'\'),licenseprofessiondescription(License_Profession_Description_:\'\'),licensestatus(License_Status_:\'\'),licensedescription(License_Description_:\'\'),dateofissuance(Date_Of_Issuance_:DATE),dateofexpiration(Date_Of_Expiration_:DATE),nationwidemortgagelicensingsystem(Nationwide_Mortgage_Licensing_System_:0),dateoflicenserenewal(Date_Of_License_Renewal_:DATE),affiliatedtypecode(Affiliated_Type_Code_:\'\'),foreignnationwidemortgagelicensingsystem(Foreign_Nationwide_Mortgage_Licensing_System_:0),locationtype(Location_Type_:\'\'),nametype(Name_Type_:\'\'),startdate(Start_Date_:DATE),isauthorizedlicense(Is_Authorized_License_:\'\'),isauthorizedconduct(Is_Authorized_Conduct_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.LicenseNumber) + '|' + TRIM((STRING)LEFT.LicenseState)));
  EXPORT __All_Trim := __d0_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'') + '|' + TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::PublicRecords_KEL::Professional_License::UidLookup',EXPIRE(7));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::PublicRecords_KEL::Professional_License');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::PublicRecords_KEL::Professional_License');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__in,Lookup,TRIM((STRING)LEFT.LicenseNumber) + '|' + TRIM((STRING)LEFT.LicenseState) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping));
  EXPORT InData := __d0;
  EXPORT License_Dates_Layout := RECORD
    KEL.typ.nkdate Date_Of_Issuance_;
    KEL.typ.nkdate Date_Of_Expiration_;
    KEL.typ.nkdate Date_Of_License_Renewal_;
    KEL.typ.nkdate Date_First_Reported_;
    KEL.typ.nkdate Date_Last_Reported_;
    KEL.typ.nkdate Date_Last_Updated_;
    KEL.typ.nkdate Start_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Status_Layout := RECORD
    KEL.typ.nstr License_Status_;
    KEL.typ.nkdate Date_Processed_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT License_Description_Layout := RECORD
    KEL.typ.nstr License_Profession_Code_;
    KEL.typ.nstr License_Profession_Description_;
    KEL.typ.nstr License_Description_;
    KEL.typ.nstr Affiliated_Type_Code_;
    KEL.typ.nstr License_Business_Flag_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Mortgage_Licensing_System_Layout := RECORD
    KEL.typ.nint Nationwide_Mortgage_Licensing_System_;
    KEL.typ.nint Foreign_Nationwide_Mortgage_Licensing_System_;
    KEL.typ.nstr Name_Type_;
    KEL.typ.nstr Location_Type_;
    KEL.typ.nstr Is_Authorized_License_;
    KEL.typ.nstr Is_Authorized_Conduct_;
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
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr License_State_;
    KEL.typ.nkdate Date_Created_;
    KEL.typ.nstr Legacy_Result_Code_;
    KEL.typ.nstr Source_Description_;
    KEL.typ.nstr Source_Code_;
    KEL.typ.ndataset(License_Dates_Layout) License_Dates_;
    KEL.typ.ndataset(Status_Layout) Status_;
    KEL.typ.ndataset(License_Description_Layout) License_Description_;
    KEL.typ.ndataset(Mortgage_Licensing_System_Layout) Mortgage_Licensing_System_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Professional_License_Group := __PostFilter;
  Layout Professional_License__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.License_Number_ := KEL.Intake.SingleValue(__recs,License_Number_);
    SELF.License_State_ := KEL.Intake.SingleValue(__recs,License_State_);
    SELF.Date_Created_ := KEL.Intake.SingleValue(__recs,Date_Created_);
    SELF.Legacy_Result_Code_ := KEL.Intake.SingleValue(__recs,Legacy_Result_Code_);
    SELF.Source_Description_ := KEL.Intake.SingleValue(__recs,Source_Description_);
    SELF.Source_Code_ := KEL.Intake.SingleValue(__recs,Source_Code_);
    SELF.License_Dates_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Date_Of_Issuance_,Date_Of_Expiration_,Date_Of_License_Renewal_,Date_First_Reported_,Date_Last_Reported_,Date_Last_Updated_,Start_Date_},Date_Of_Issuance_,Date_Of_Expiration_,Date_Of_License_Renewal_,Date_First_Reported_,Date_Last_Reported_,Date_Last_Updated_,Start_Date_),License_Dates_Layout)(__NN(Date_Of_Issuance_) OR __NN(Date_Of_Expiration_) OR __NN(Date_Of_License_Renewal_) OR __NN(Date_First_Reported_) OR __NN(Date_Last_Reported_) OR __NN(Date_Last_Updated_) OR __NN(Start_Date_)));
    SELF.Status_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),License_Status_,Date_Processed_},License_Status_,Date_Processed_),Status_Layout)(__NN(License_Status_) OR __NN(Date_Processed_)));
    SELF.License_Description_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),License_Profession_Code_,License_Profession_Description_,License_Description_,Affiliated_Type_Code_,License_Business_Flag_},License_Profession_Code_,License_Profession_Description_,License_Description_,Affiliated_Type_Code_,License_Business_Flag_),License_Description_Layout)(__NN(License_Profession_Code_) OR __NN(License_Profession_Description_) OR __NN(License_Description_) OR __NN(Affiliated_Type_Code_) OR __NN(License_Business_Flag_)));
    SELF.Mortgage_Licensing_System_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Nationwide_Mortgage_Licensing_System_,Foreign_Nationwide_Mortgage_Licensing_System_,Name_Type_,Location_Type_,Is_Authorized_License_,Is_Authorized_Conduct_},Nationwide_Mortgage_Licensing_System_,Foreign_Nationwide_Mortgage_Licensing_System_,Name_Type_,Location_Type_,Is_Authorized_License_,Is_Authorized_Conduct_),Mortgage_Licensing_System_Layout)(__NN(Nationwide_Mortgage_Licensing_System_) OR __NN(Foreign_Nationwide_Mortgage_Licensing_System_) OR __NN(Name_Type_) OR __NN(Location_Type_) OR __NN(Is_Authorized_License_) OR __NN(Is_Authorized_Conduct_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Professional_License__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.License_Dates_ := __CN(PROJECT(DATASET(__r),TRANSFORM(License_Dates_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Date_Of_Issuance_) OR __NN(Date_Of_Expiration_) OR __NN(Date_Of_License_Renewal_) OR __NN(Date_First_Reported_) OR __NN(Date_Last_Reported_) OR __NN(Date_Last_Updated_) OR __NN(Start_Date_)));
    SELF.Status_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Status_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(License_Status_) OR __NN(Date_Processed_)));
    SELF.License_Description_ := __CN(PROJECT(DATASET(__r),TRANSFORM(License_Description_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(License_Profession_Code_) OR __NN(License_Profession_Description_) OR __NN(License_Description_) OR __NN(Affiliated_Type_Code_) OR __NN(License_Business_Flag_)));
    SELF.Mortgage_Licensing_System_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Mortgage_Licensing_System_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Nationwide_Mortgage_Licensing_System_) OR __NN(Foreign_Nationwide_Mortgage_Licensing_System_) OR __NN(Name_Type_) OR __NN(Location_Type_) OR __NN(Is_Authorized_License_) OR __NN(Is_Authorized_Conduct_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Professional_License_Group,COUNT(ROWS(LEFT))=1),GROUP,Professional_License__Single_Rollup(LEFT)) + ROLLUP(HAVING(Professional_License_Group,COUNT(ROWS(LEFT))>1),GROUP,Professional_License__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::PublicRecords_KEL::Professional_License::Result' + IF(__cfg.PersistId <> '','::' + __cfg.PersistId,''),EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT License_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,License_Number_);
  EXPORT License_State__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,License_State_);
  EXPORT Date_Created__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Date_Created_);
  EXPORT Legacy_Result_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legacy_Result_Code_);
  EXPORT Source_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Source_Description_);
  EXPORT Source_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Source_Code_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(License_Number__SingleValue_Invalid),COUNT(License_State__SingleValue_Invalid),COUNT(Date_Created__SingleValue_Invalid),COUNT(Legacy_Result_Code__SingleValue_Invalid),COUNT(Source_Description__SingleValue_Invalid),COUNT(Source_Code__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid,KEL.typ.int License_Number__SingleValue_Invalid,KEL.typ.int License_State__SingleValue_Invalid,KEL.typ.int Date_Created__SingleValue_Invalid,KEL.typ.int Legacy_Result_Code__SingleValue_Invalid,KEL.typ.int Source_Description__SingleValue_Invalid,KEL.typ.int Source_Code__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(__d0)},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateCreated',COUNT(__d0(__NL(Date_Created_))),COUNT(__d0(__NN(Date_Created_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseState',COUNT(__d0(__NL(License_State_))),COUNT(__d0(__NN(License_State_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateProcessed',COUNT(__d0(__NL(Date_Processed_))),COUNT(__d0(__NN(Date_Processed_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LegacyResultCode',COUNT(__d0(__NL(Legacy_Result_Code_))),COUNT(__d0(__NN(Legacy_Result_Code_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceDescription',COUNT(__d0(__NL(Source_Description_))),COUNT(__d0(__NN(Source_Description_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceCode',COUNT(__d0(__NL(Source_Code_))),COUNT(__d0(__NN(Source_Code_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstReported',COUNT(__d0(__NL(Date_First_Reported_))),COUNT(__d0(__NN(Date_First_Reported_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastReported',COUNT(__d0(__NL(Date_Last_Reported_))),COUNT(__d0(__NN(Date_Last_Reported_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastUpdated',COUNT(__d0(__NL(Date_Last_Updated_))),COUNT(__d0(__NN(Date_Last_Updated_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseNumber',COUNT(__d0(__NL(License_Number_))),COUNT(__d0(__NN(License_Number_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseBusinessFlag',COUNT(__d0(__NL(License_Business_Flag_))),COUNT(__d0(__NN(License_Business_Flag_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseProfessionCode',COUNT(__d0(__NL(License_Profession_Code_))),COUNT(__d0(__NN(License_Profession_Code_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseProfessionDescription',COUNT(__d0(__NL(License_Profession_Description_))),COUNT(__d0(__NN(License_Profession_Description_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseStatus',COUNT(__d0(__NL(License_Status_))),COUNT(__d0(__NN(License_Status_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LicenseDescription',COUNT(__d0(__NL(License_Description_))),COUNT(__d0(__NN(License_Description_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfIssuance',COUNT(__d0(__NL(Date_Of_Issuance_))),COUNT(__d0(__NN(Date_Of_Issuance_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfExpiration',COUNT(__d0(__NL(Date_Of_Expiration_))),COUNT(__d0(__NN(Date_Of_Expiration_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NationwideMortgageLicensingSystem',COUNT(__d0(__NL(Nationwide_Mortgage_Licensing_System_))),COUNT(__d0(__NN(Nationwide_Mortgage_Licensing_System_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfLicenseRenewal',COUNT(__d0(__NL(Date_Of_License_Renewal_))),COUNT(__d0(__NN(Date_Of_License_Renewal_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AffiliatedTypeCode',COUNT(__d0(__NL(Affiliated_Type_Code_))),COUNT(__d0(__NN(Affiliated_Type_Code_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ForeignNationwideMortgageLicensingSystem',COUNT(__d0(__NL(Foreign_Nationwide_Mortgage_Licensing_System_))),COUNT(__d0(__NN(Foreign_Nationwide_Mortgage_Licensing_System_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LocationType',COUNT(__d0(__NL(Location_Type_))),COUNT(__d0(__NN(Location_Type_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameType',COUNT(__d0(__NL(Name_Type_))),COUNT(__d0(__NN(Name_Type_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StartDate',COUNT(__d0(__NL(Start_Date_))),COUNT(__d0(__NN(Start_Date_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsAuthorizedLicense',COUNT(__d0(__NL(Is_Authorized_License_))),COUNT(__d0(__NN(Is_Authorized_License_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsAuthorizedConduct',COUNT(__d0(__NL(Is_Authorized_Conduct_))),COUNT(__d0(__NN(Is_Authorized_Conduct_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'ProfessionalLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
