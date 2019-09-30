//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Phone,E_Professional_License FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_Professional_License_Phone(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Professional_License().Typ) Prof_Lic_;
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'Prof_Lic_(DEFAULT:Prof_Lic_:0),phonenumber(DEFAULT:Phone_Number_:0),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'Prof_Lic_(DEFAULT:Prof_Lic_:0),phone(OVERRIDE:Phone_Number_:0),src(OVERRIDE:Source_:\'\'),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_0Rule),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Prof_LicenseV2__Key_Proflic_Did,TRANSFORM(RECORDOF(__in.Dataset_Prof_LicenseV2__Key_Proflic_Did),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm(TRIM(phone) != '' AND TRIM(cleaned_license_number) != '' AND TRIM(source_st) != '');
  SHARED __d0_Prof_Lic__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Prof_Lic_;
  END;
  SHARED __d0_Prof_Lic__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d0_KELfiltered,'cleaned_license_number,source_st,did','__in'),E_Professional_License(__in,__cfg).Lookup,TRIM((STRING)LEFT.cleaned_license_number) + '|' + TRIM((STRING)LEFT.source_st) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d0_Prof_Lic__Layout,SELF.Prof_Lic_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Prof_Lic__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping1 := 'Prof_Lic_(DEFAULT:Prof_Lic_:0),phn_mari_1(OVERRIDE:Phone_Number_:0),src(OVERRIDE:Source_:\'\'),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Prof_License_Mari__Key_Did,TRANSFORM(RECORDOF(__in.Dataset_Prof_License_Mari__Key_Did),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm(TRIM(cleaned_license_number) != '' AND TRIM(license_state) != '' AND TRIM(phn_mari_1) != '');
  SHARED __d1_Prof_Lic__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid Prof_Lic_;
  END;
  SHARED __d1_Prof_Lic__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d1_KELfiltered,'cleaned_license_number,license_state,did','__in'),E_Professional_License(__in,__cfg).Lookup,TRIM((STRING)LEFT.cleaned_license_number) + '|' + TRIM((STRING)LEFT.license_state) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d1_Prof_Lic__Layout,SELF.Prof_Lic_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d1_Prefiltered := __d1_Prof_Lic__Mapped;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Professional_License().Typ) Prof_Lic_;
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Prof_Lic_,Phone_Number_,ALL));
  Professional_License_Phone_Group := __PostFilter;
  Layout Professional_License_Phone__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Professional_License_Phone__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Professional_License_Phone_Group,COUNT(ROWS(LEFT))=1),GROUP,Professional_License_Phone__Single_Rollup(LEFT)) + ROLLUP(HAVING(Professional_License_Phone_Group,COUNT(ROWS(LEFT))>1),GROUP,Professional_License_Phone__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Prof_Lic__Orphan := JOIN(InData(__NN(Prof_Lic_)),E_Professional_License(__in,__cfg).__Result,__EEQP(LEFT.Prof_Lic_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Phone_Number__Orphan := JOIN(InData(__NN(Phone_Number_)),E_Phone(__in,__cfg).__Result,__EEQP(LEFT.Phone_Number_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Prof_Lic__Orphan),COUNT(Phone_Number__Orphan)}],{KEL.typ.int Prof_Lic__Orphan,KEL.typ.int Phone_Number__Orphan});
  EXPORT NullCounts := DATASET([
    {'ProfessionalLicensePhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProfLic',COUNT(__d0(__NL(Prof_Lic_))),COUNT(__d0(__NN(Prof_Lic_)))},
    {'ProfessionalLicensePhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d0(__NL(Phone_Number_))),COUNT(__d0(__NN(Phone_Number_)))},
    {'ProfessionalLicensePhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'ProfessionalLicensePhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'ProfessionalLicensePhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'ProfessionalLicensePhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProfLic',COUNT(__d1(__NL(Prof_Lic_))),COUNT(__d1(__NN(Prof_Lic_)))},
    {'ProfessionalLicensePhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phn_mari_1',COUNT(__d1(__NL(Phone_Number_))),COUNT(__d1(__NN(Phone_Number_)))},
    {'ProfessionalLicensePhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'ProfessionalLicensePhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'ProfessionalLicensePhone','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
