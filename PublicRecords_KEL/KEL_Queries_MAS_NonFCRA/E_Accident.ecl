//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
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
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    DATA57 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(DEFAULT:UID),accidentnumber(DEFAULT:Accident_Number_:\'\'),accidentdate(DEFAULT:Accident_Date_:DATE),accidentlocation(DEFAULT:Accident_Location_:\'\'),accidentstreet(DEFAULT:Accident_Street_:\'\'),accidentcrossstreet(DEFAULT:Accident_Cross_Street_:\'\'),nextstreet(DEFAULT:Next_Street_:\'\'),incidentcity(DEFAULT:Incident_City_:\'\'),incidentstate(DEFAULT:Incident_State_:\'\'),jurisdictionstate(DEFAULT:Jurisdiction_State_:\'\'),jurisdiction(DEFAULT:Jurisdiction_:\'\'),jurisdictionnumber(DEFAULT:Jurisdiction_Number_:0),reportcode(DEFAULT:Report_Code_:\'\'),reportcategory(DEFAULT:Report_Category_:\'\'),reporttypeid(DEFAULT:Report_Type_I_D_:\'\'),reportcodedescription(DEFAULT:Report_Code_Description_:\'\'),reporthascoversheet(DEFAULT:Report_Has_Cover_Sheet_),additionalreportnumber(DEFAULT:Additional_Report_Number_:\'\'),reportstatus(DEFAULT:Report_Status_:\'\'),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := __in.Dataset_FLAccidents_Ecrash__Key_ECrash4(l_acc_nbr NOT IN ['','0']);
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.l_acc_nbr)));
  SHARED __d1_KELfiltered := __in.Dataset_FLAccidents_Ecrash__key_EcrashV2_accnbr(l_accnbr NOT IN ['','0']);
  SHARED __d1_Trim := PROJECT(__d1_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.l_accnbr)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim;
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
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping0 := 'UID(DEFAULT:UID),l_acc_nbr(OVERRIDE:Accident_Number_:\'\'),accidentdate(DEFAULT:Accident_Date_:DATE),accidentlocation(DEFAULT:Accident_Location_:\'\'),accidentstreet(DEFAULT:Accident_Street_:\'\'),accidentcrossstreet(DEFAULT:Accident_Cross_Street_:\'\'),nextstreet(DEFAULT:Next_Street_:\'\'),vehicle_incident_city(OVERRIDE:Incident_City_:\'\'),vehicle_incident_st(OVERRIDE:Incident_State_:\'\'),jurisdictionstate(DEFAULT:Jurisdiction_State_:\'\'),jurisdiction(DEFAULT:Jurisdiction_:\'\'),jurisdictionnumber(DEFAULT:Jurisdiction_Number_:0),report_code(OVERRIDE:Report_Code_:\'\'),report_category(OVERRIDE:Report_Category_:\'\'),reporttypeid(DEFAULT:Report_Type_I_D_:\'\'),report_code_desc(OVERRIDE:Report_Code_Description_:\'\'),reporthascoversheet(DEFAULT:Report_Has_Cover_Sheet_),additionalreportnumber(DEFAULT:Additional_Report_Number_:\'\'),reportstatus(DEFAULT:Report_Status_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_FLAccidents_Ecrash__Key_ECrash4,TRANSFORM(RECORDOF(__in.Dataset_FLAccidents_Ecrash__Key_ECrash4),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_FLAccidents_Ecrash__Key_ECrash4);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.l_acc_nbr) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_FLAccidents_Ecrash__Key_ECrash4_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping1 := 'UID(DEFAULT:UID),l_accnbr(OVERRIDE:Accident_Number_:\'\'),accident_date(OVERRIDE:Accident_Date_:DATE),accident_location(OVERRIDE:Accident_Location_:\'\'),accident_street(OVERRIDE:Accident_Street_:\'\'),accident_cross_street(OVERRIDE:Accident_Cross_Street_:\'\'),next_street(OVERRIDE:Next_Street_:\'\'),vehicle_incident_city(OVERRIDE:Incident_City_:\'\'),vehicle_incident_st(OVERRIDE:Incident_State_:\'\'),jurisdiction_state(OVERRIDE:Jurisdiction_State_:\'\'),jurisdiction(OVERRIDE:Jurisdiction_:\'\'),jurisdiction_nbr(OVERRIDE:Jurisdiction_Number_:0),report_code(OVERRIDE:Report_Code_:\'\'),report_category(OVERRIDE:Report_Category_:\'\'),report_type_id(OVERRIDE:Report_Type_I_D_:\'\'),report_code_desc(OVERRIDE:Report_Code_Description_:\'\'),report_has_coversheet(OVERRIDE:Report_Has_Cover_Sheet_),addl_report_number(OVERRIDE:Additional_Report_Number_:\'\'),report_status(OVERRIDE:Report_Status_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_FLAccidents_Ecrash__key_EcrashV2_accnbr,TRANSFORM(RECORDOF(__in.Dataset_FLAccidents_Ecrash__key_EcrashV2_accnbr),SELF:=RIGHT));
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_FLAccidents_Ecrash__key_EcrashV2_accnbr);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_KELfiltered,Lookup,TRIM((STRING)LEFT.l_accnbr) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_FLAccidents_Ecrash__key_EcrashV2_accnbr_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1;
  EXPORT Report_Codes_Layout := RECORD
    KEL.typ.nstr Report_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Report_Statuses_Layout := RECORD
    KEL.typ.nstr Report_Status_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
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
    KEL.typ.nstr Report_Category_;
    KEL.typ.nstr Report_Type_I_D_;
    KEL.typ.nstr Report_Code_Description_;
    KEL.typ.nbool Report_Has_Cover_Sheet_;
    KEL.typ.nstr Additional_Report_Number_;
    KEL.typ.ndataset(Report_Codes_Layout) Report_Codes_;
    KEL.typ.ndataset(Report_Statuses_Layout) Report_Statuses_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
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
    SELF.Report_Category_ := KEL.Intake.SingleValue(__recs,Report_Category_);
    SELF.Report_Type_I_D_ := KEL.Intake.SingleValue(__recs,Report_Type_I_D_);
    SELF.Report_Code_Description_ := KEL.Intake.SingleValue(__recs,Report_Code_Description_);
    SELF.Report_Has_Cover_Sheet_ := KEL.Intake.SingleValue(__recs,Report_Has_Cover_Sheet_);
    SELF.Additional_Report_Number_ := KEL.Intake.SingleValue(__recs,Additional_Report_Number_);
    SELF.Report_Codes_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Report_Code_},Report_Code_),Report_Codes_Layout)(__NN(Report_Code_)));
    SELF.Report_Statuses_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Report_Status_},Report_Status_),Report_Statuses_Layout)(__NN(Report_Status_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Accident__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Report_Codes_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Report_Codes_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Report_Code_)));
    SELF.Report_Statuses_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Report_Statuses_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Report_Status_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Accident_Group,COUNT(ROWS(LEFT))=1),GROUP,Accident__Single_Rollup(LEFT)) + ROLLUP(HAVING(Accident_Group,COUNT(ROWS(LEFT))>1),GROUP,Accident__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Accident_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Accident_Number_);
  EXPORT Accident_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Accident_Date_);
  EXPORT Accident_Location__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Accident_Location_);
  EXPORT Accident_Street__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Accident_Street_);
  EXPORT Accident_Cross_Street__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Accident_Cross_Street_);
  EXPORT Next_Street__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Next_Street_);
  EXPORT Incident_City__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Incident_City_);
  EXPORT Incident_State__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Incident_State_);
  EXPORT Jurisdiction_State__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Jurisdiction_State_);
  EXPORT Jurisdiction__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Jurisdiction_);
  EXPORT Jurisdiction_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Jurisdiction_Number_);
  EXPORT Report_Category__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Report_Category_);
  EXPORT Report_Type_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Report_Type_I_D_);
  EXPORT Report_Code_Description__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Report_Code_Description_);
  EXPORT Report_Has_Cover_Sheet__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Report_Has_Cover_Sheet_);
  EXPORT Additional_Report_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Additional_Report_Number_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_FLAccidents_Ecrash__Key_ECrash4_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_FLAccidents_Ecrash__key_EcrashV2_accnbr_Invalid),COUNT(Accident_Number__SingleValue_Invalid),COUNT(Accident_Date__SingleValue_Invalid),COUNT(Accident_Location__SingleValue_Invalid),COUNT(Accident_Street__SingleValue_Invalid),COUNT(Accident_Cross_Street__SingleValue_Invalid),COUNT(Next_Street__SingleValue_Invalid),COUNT(Incident_City__SingleValue_Invalid),COUNT(Incident_State__SingleValue_Invalid),COUNT(Jurisdiction_State__SingleValue_Invalid),COUNT(Jurisdiction__SingleValue_Invalid),COUNT(Jurisdiction_Number__SingleValue_Invalid),COUNT(Report_Category__SingleValue_Invalid),COUNT(Report_Type_I_D__SingleValue_Invalid),COUNT(Report_Code_Description__SingleValue_Invalid),COUNT(Report_Has_Cover_Sheet__SingleValue_Invalid),COUNT(Additional_Report_Number__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_FLAccidents_Ecrash__Key_ECrash4_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_FLAccidents_Ecrash__key_EcrashV2_accnbr_Invalid,KEL.typ.int Accident_Number__SingleValue_Invalid,KEL.typ.int Accident_Date__SingleValue_Invalid,KEL.typ.int Accident_Location__SingleValue_Invalid,KEL.typ.int Accident_Street__SingleValue_Invalid,KEL.typ.int Accident_Cross_Street__SingleValue_Invalid,KEL.typ.int Next_Street__SingleValue_Invalid,KEL.typ.int Incident_City__SingleValue_Invalid,KEL.typ.int Incident_State__SingleValue_Invalid,KEL.typ.int Jurisdiction_State__SingleValue_Invalid,KEL.typ.int Jurisdiction__SingleValue_Invalid,KEL.typ.int Jurisdiction_Number__SingleValue_Invalid,KEL.typ.int Report_Category__SingleValue_Invalid,KEL.typ.int Report_Type_I_D__SingleValue_Invalid,KEL.typ.int Report_Code_Description__SingleValue_Invalid,KEL.typ.int Report_Has_Cover_Sheet__SingleValue_Invalid,KEL.typ.int Additional_Report_Number__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_FLAccidents_Ecrash__Key_ECrash4_Invalid),COUNT(__d0)},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','l_acc_nbr',COUNT(__d0(__NL(Accident_Number_))),COUNT(__d0(__NN(Accident_Number_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AccidentDate',COUNT(__d0(__NL(Accident_Date_))),COUNT(__d0(__NN(Accident_Date_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AccidentLocation',COUNT(__d0(__NL(Accident_Location_))),COUNT(__d0(__NN(Accident_Location_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AccidentStreet',COUNT(__d0(__NL(Accident_Street_))),COUNT(__d0(__NN(Accident_Street_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AccidentCrossStreet',COUNT(__d0(__NL(Accident_Cross_Street_))),COUNT(__d0(__NN(Accident_Cross_Street_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NextStreet',COUNT(__d0(__NL(Next_Street_))),COUNT(__d0(__NN(Next_Street_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vehicle_incident_city',COUNT(__d0(__NL(Incident_City_))),COUNT(__d0(__NN(Incident_City_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vehicle_incident_st',COUNT(__d0(__NL(Incident_State_))),COUNT(__d0(__NN(Incident_State_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','JurisdictionState',COUNT(__d0(__NL(Jurisdiction_State_))),COUNT(__d0(__NN(Jurisdiction_State_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Jurisdiction',COUNT(__d0(__NL(Jurisdiction_))),COUNT(__d0(__NN(Jurisdiction_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','JurisdictionNumber',COUNT(__d0(__NL(Jurisdiction_Number_))),COUNT(__d0(__NN(Jurisdiction_Number_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','report_code',COUNT(__d0(__NL(Report_Code_))),COUNT(__d0(__NN(Report_Code_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','report_category',COUNT(__d0(__NL(Report_Category_))),COUNT(__d0(__NN(Report_Category_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ReportTypeID',COUNT(__d0(__NL(Report_Type_I_D_))),COUNT(__d0(__NN(Report_Type_I_D_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','report_code_desc',COUNT(__d0(__NL(Report_Code_Description_))),COUNT(__d0(__NN(Report_Code_Description_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ReportHasCoverSheet',COUNT(__d0(__NL(Report_Has_Cover_Sheet_))),COUNT(__d0(__NN(Report_Has_Cover_Sheet_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdditionalReportNumber',COUNT(__d0(__NL(Additional_Report_Number_))),COUNT(__d0(__NN(Additional_Report_Number_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ReportStatus',COUNT(__d0(__NL(Report_Status_))),COUNT(__d0(__NN(Report_Status_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_FLAccidents_Ecrash__key_EcrashV2_accnbr_Invalid),COUNT(__d1)},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','l_accnbr',COUNT(__d1(__NL(Accident_Number_))),COUNT(__d1(__NN(Accident_Number_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','accident_date',COUNT(__d1(__NL(Accident_Date_))),COUNT(__d1(__NN(Accident_Date_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','accident_location',COUNT(__d1(__NL(Accident_Location_))),COUNT(__d1(__NN(Accident_Location_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','accident_street',COUNT(__d1(__NL(Accident_Street_))),COUNT(__d1(__NN(Accident_Street_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','accident_cross_street',COUNT(__d1(__NL(Accident_Cross_Street_))),COUNT(__d1(__NN(Accident_Cross_Street_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','next_street',COUNT(__d1(__NL(Next_Street_))),COUNT(__d1(__NN(Next_Street_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vehicle_incident_city',COUNT(__d1(__NL(Incident_City_))),COUNT(__d1(__NN(Incident_City_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vehicle_incident_st',COUNT(__d1(__NL(Incident_State_))),COUNT(__d1(__NN(Incident_State_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','jurisdiction_state',COUNT(__d1(__NL(Jurisdiction_State_))),COUNT(__d1(__NN(Jurisdiction_State_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','jurisdiction',COUNT(__d1(__NL(Jurisdiction_))),COUNT(__d1(__NN(Jurisdiction_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','jurisdiction_nbr',COUNT(__d1(__NL(Jurisdiction_Number_))),COUNT(__d1(__NN(Jurisdiction_Number_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','report_code',COUNT(__d1(__NL(Report_Code_))),COUNT(__d1(__NN(Report_Code_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','report_category',COUNT(__d1(__NL(Report_Category_))),COUNT(__d1(__NN(Report_Category_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','report_type_id',COUNT(__d1(__NL(Report_Type_I_D_))),COUNT(__d1(__NN(Report_Type_I_D_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','report_code_desc',COUNT(__d1(__NL(Report_Code_Description_))),COUNT(__d1(__NN(Report_Code_Description_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','report_has_coversheet',COUNT(__d1(__NL(Report_Has_Cover_Sheet_))),COUNT(__d1(__NN(Report_Has_Cover_Sheet_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addl_report_number',COUNT(__d1(__NL(Additional_Report_Number_))),COUNT(__d1(__NN(Additional_Report_Number_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','report_status',COUNT(__d1(__NL(Report_Status_))),COUNT(__d1(__NN(Report_Status_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'Accident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
