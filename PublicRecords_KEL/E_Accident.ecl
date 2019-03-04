//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Accident(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Accident_Number_;
    KEL.typ.nkdate Accident_Date_;
    KEL.typ.nstr Accident_Location_;
    KEL.typ.nstr Accident_Street_;
    KEL.typ.nstr Accident_Cross_Street_;
    KEL.typ.nstr Next_Street_;
    KEL.typ.nstr Incident_City_;
    KEL.typ.nstr Incident_State_;
    KEL.typ.nstr Jurisdiction_State_;
    KEL.typ.nstr Jurisdiction_;
    KEL.typ.nint Jurisdiction_Number_;
    KEL.typ.nstr Report_Code_;
    KEL.typ.nstr Report_Category_;
    KEL.typ.nstr Report_Type_I_D_;
    KEL.typ.nstr Report_Code_Description_;
    KEL.typ.nbool Report_Has_Cover_Sheet_;
    KEL.typ.nstr Additional_Report_Number_;
    KEL.typ.nstr Report_Status_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),accidentnumber(Accident_Number_:\'\'),accidentdate(Accident_Date_:DATE),accidentlocation(Accident_Location_:\'\'),accidentstreet(Accident_Street_:\'\'),accidentcrossstreet(Accident_Cross_Street_:\'\'),nextstreet(Next_Street_:\'\'),incidentcity(Incident_City_:\'\'),incidentstate(Incident_State_:\'\'),jurisdictionstate(Jurisdiction_State_:\'\'),jurisdiction(Jurisdiction_:\'\'),jurisdictionnumber(Jurisdiction_Number_:0),reportcode(Report_Code_:\'\'),reportcategory(Report_Category_:\'\'),reporttypeid(Report_Type_I_D_:\'\'),reportcodedescription(Report_Code_Description_:\'\'),reporthascoversheet(Report_Has_Cover_Sheet_),additionalreportnumber(Additional_Report_Number_:\'\'),reportstatus(Report_Status_:\'\'),datevendorlastreported(Date_Vendor_Last_Reported_:DATE),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.AccidentNumber)));
  EXPORT __All_Trim := __d0_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__in,Lookup,TRIM((STRING)LEFT.AccidentNumber) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping));
  EXPORT InData := __d0;
  EXPORT Report_Statuses_Layout := RECORD
    KEL.typ.nstr Report_Status_;
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
    KEL.typ.nstr Accident_Number_;
    KEL.typ.nkdate Accident_Date_;
    KEL.typ.nstr Accident_Location_;
    KEL.typ.nstr Accident_Street_;
    KEL.typ.nstr Accident_Cross_Street_;
    KEL.typ.nstr Next_Street_;
    KEL.typ.nstr Incident_City_;
    KEL.typ.nstr Incident_State_;
    KEL.typ.nstr Jurisdiction_State_;
    KEL.typ.nstr Jurisdiction_;
    KEL.typ.nint Jurisdiction_Number_;
    KEL.typ.nstr Report_Code_;
    KEL.typ.nstr Report_Category_;
    KEL.typ.nstr Report_Type_I_D_;
    KEL.typ.nstr Report_Code_Description_;
    KEL.typ.nbool Report_Has_Cover_Sheet_;
    KEL.typ.nstr Additional_Report_Number_;
    KEL.typ.ndataset(Report_Statuses_Layout) Report_Statuses_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Accident_Group := __PostFilter;
  Layout Accident__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Accident_Number_ := KEL.Intake.SingleValue(__recs,Accident_Number_);
    SELF.Accident_Date_ := KEL.Intake.SingleValue(__recs,Accident_Date_);
    SELF.Accident_Location_ := KEL.Intake.SingleValue(__recs,Accident_Location_);
    SELF.Accident_Street_ := KEL.Intake.SingleValue(__recs,Accident_Street_);
    SELF.Accident_Cross_Street_ := KEL.Intake.SingleValue(__recs,Accident_Cross_Street_);
    SELF.Next_Street_ := KEL.Intake.SingleValue(__recs,Next_Street_);
    SELF.Incident_City_ := KEL.Intake.SingleValue(__recs,Incident_City_);
    SELF.Incident_State_ := KEL.Intake.SingleValue(__recs,Incident_State_);
    SELF.Jurisdiction_State_ := KEL.Intake.SingleValue(__recs,Jurisdiction_State_);
    SELF.Jurisdiction_ := KEL.Intake.SingleValue(__recs,Jurisdiction_);
    SELF.Jurisdiction_Number_ := KEL.Intake.SingleValue(__recs,Jurisdiction_Number_);
    SELF.Report_Code_ := KEL.Intake.SingleValue(__recs,Report_Code_);
    SELF.Report_Category_ := KEL.Intake.SingleValue(__recs,Report_Category_);
    SELF.Report_Type_I_D_ := KEL.Intake.SingleValue(__recs,Report_Type_I_D_);
    SELF.Report_Code_Description_ := KEL.Intake.SingleValue(__recs,Report_Code_Description_);
    SELF.Report_Has_Cover_Sheet_ := KEL.Intake.SingleValue(__recs,Report_Has_Cover_Sheet_);
    SELF.Additional_Report_Number_ := KEL.Intake.SingleValue(__recs,Additional_Report_Number_);
    SELF.Report_Statuses_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Report_Status_},Report_Status_),Report_Statuses_Layout)(__NN(Report_Status_)));
    SELF.Date_Vendor_Last_Reported_ := KEL.Intake.SingleValue(__recs,Date_Vendor_Last_Reported_);
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Accident__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Report_Statuses_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Report_Statuses_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Report_Status_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Accident_Group,COUNT(ROWS(LEFT))=1),GROUP,Accident__Single_Rollup(LEFT)) + ROLLUP(HAVING(Accident_Group,COUNT(ROWS(LEFT))>1),GROUP,Accident__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Accident_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Accident_Number_);
  EXPORT Accident_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Accident_Date_);
  EXPORT Accident_Location__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Accident_Location_);
  EXPORT Accident_Street__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Accident_Street_);
  EXPORT Accident_Cross_Street__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Accident_Cross_Street_);
  EXPORT Next_Street__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Next_Street_);
  EXPORT Incident_City__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Incident_City_);
  EXPORT Incident_State__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Incident_State_);
  EXPORT Jurisdiction_State__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Jurisdiction_State_);
  EXPORT Jurisdiction__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Jurisdiction_);
  EXPORT Jurisdiction_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Jurisdiction_Number_);
  EXPORT Report_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Report_Code_);
  EXPORT Report_Category__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Report_Category_);
  EXPORT Report_Type_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Report_Type_I_D_);
  EXPORT Report_Code_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Report_Code_Description_);
  EXPORT Report_Has_Cover_Sheet__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Report_Has_Cover_Sheet_);
  EXPORT Additional_Report_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Additional_Report_Number_);
  EXPORT Date_Vendor_Last_Reported__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Date_Vendor_Last_Reported_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(Accident_Number__SingleValue_Invalid),COUNT(Accident_Date__SingleValue_Invalid),COUNT(Accident_Location__SingleValue_Invalid),COUNT(Accident_Street__SingleValue_Invalid),COUNT(Accident_Cross_Street__SingleValue_Invalid),COUNT(Next_Street__SingleValue_Invalid),COUNT(Incident_City__SingleValue_Invalid),COUNT(Incident_State__SingleValue_Invalid),COUNT(Jurisdiction_State__SingleValue_Invalid),COUNT(Jurisdiction__SingleValue_Invalid),COUNT(Jurisdiction_Number__SingleValue_Invalid),COUNT(Report_Code__SingleValue_Invalid),COUNT(Report_Category__SingleValue_Invalid),COUNT(Report_Type_I_D__SingleValue_Invalid),COUNT(Report_Code_Description__SingleValue_Invalid),COUNT(Report_Has_Cover_Sheet__SingleValue_Invalid),COUNT(Additional_Report_Number__SingleValue_Invalid),COUNT(Date_Vendor_Last_Reported__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid,KEL.typ.int Accident_Number__SingleValue_Invalid,KEL.typ.int Accident_Date__SingleValue_Invalid,KEL.typ.int Accident_Location__SingleValue_Invalid,KEL.typ.int Accident_Street__SingleValue_Invalid,KEL.typ.int Accident_Cross_Street__SingleValue_Invalid,KEL.typ.int Next_Street__SingleValue_Invalid,KEL.typ.int Incident_City__SingleValue_Invalid,KEL.typ.int Incident_State__SingleValue_Invalid,KEL.typ.int Jurisdiction_State__SingleValue_Invalid,KEL.typ.int Jurisdiction__SingleValue_Invalid,KEL.typ.int Jurisdiction_Number__SingleValue_Invalid,KEL.typ.int Report_Code__SingleValue_Invalid,KEL.typ.int Report_Category__SingleValue_Invalid,KEL.typ.int Report_Type_I_D__SingleValue_Invalid,KEL.typ.int Report_Code_Description__SingleValue_Invalid,KEL.typ.int Report_Has_Cover_Sheet__SingleValue_Invalid,KEL.typ.int Additional_Report_Number__SingleValue_Invalid,KEL.typ.int Date_Vendor_Last_Reported__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(__d0)},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AccidentNumber',COUNT(__d0(__NL(Accident_Number_))),COUNT(__d0(__NN(Accident_Number_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AccidentDate',COUNT(__d0(__NL(Accident_Date_))),COUNT(__d0(__NN(Accident_Date_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AccidentLocation',COUNT(__d0(__NL(Accident_Location_))),COUNT(__d0(__NN(Accident_Location_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AccidentStreet',COUNT(__d0(__NL(Accident_Street_))),COUNT(__d0(__NN(Accident_Street_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AccidentCrossStreet',COUNT(__d0(__NL(Accident_Cross_Street_))),COUNT(__d0(__NN(Accident_Cross_Street_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NextStreet',COUNT(__d0(__NL(Next_Street_))),COUNT(__d0(__NN(Next_Street_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IncidentCity',COUNT(__d0(__NL(Incident_City_))),COUNT(__d0(__NN(Incident_City_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IncidentState',COUNT(__d0(__NL(Incident_State_))),COUNT(__d0(__NN(Incident_State_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','JurisdictionState',COUNT(__d0(__NL(Jurisdiction_State_))),COUNT(__d0(__NN(Jurisdiction_State_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Jurisdiction',COUNT(__d0(__NL(Jurisdiction_))),COUNT(__d0(__NN(Jurisdiction_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','JurisdictionNumber',COUNT(__d0(__NL(Jurisdiction_Number_))),COUNT(__d0(__NN(Jurisdiction_Number_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ReportCode',COUNT(__d0(__NL(Report_Code_))),COUNT(__d0(__NN(Report_Code_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ReportCategory',COUNT(__d0(__NL(Report_Category_))),COUNT(__d0(__NN(Report_Category_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ReportTypeID',COUNT(__d0(__NL(Report_Type_I_D_))),COUNT(__d0(__NN(Report_Type_I_D_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ReportCodeDescription',COUNT(__d0(__NL(Report_Code_Description_))),COUNT(__d0(__NN(Report_Code_Description_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ReportHasCoverSheet',COUNT(__d0(__NL(Report_Has_Cover_Sheet_))),COUNT(__d0(__NN(Report_Has_Cover_Sheet_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdditionalReportNumber',COUNT(__d0(__NL(Additional_Report_Number_))),COUNT(__d0(__NN(Additional_Report_Number_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ReportStatus',COUNT(__d0(__NL(Report_Status_))),COUNT(__d0(__NN(Report_Status_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d0(__NL(Date_Vendor_Last_Reported_))),COUNT(__d0(__NN(Date_Vendor_Last_Reported_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
