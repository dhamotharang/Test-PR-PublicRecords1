//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Business_Ult FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Business_Org(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.ntyp(E_Business_Ult().Typ) Extended_Family_;
    KEL.typ.nint Nodes_Total_;
    KEL.typ.nstr Org_Segment_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Source_Group_I_D_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),ultid(Ult_I_D_:0),orgid(Org_I_D_:0),extendedfamily(Extended_Family_:0),nodestotal(Nodes_Total_:0),orgsegment(Org_Segment_:\'\'),datevendorfirstreported(Date_Vendor_First_Reported_:DATE),datevendorlastreported(Date_Vendor_Last_Reported_:DATE),sourcegroupid(Source_Group_I_D_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in.Dataset_BIPV2__Key_BH_Linking_Ids,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid)));
  EXPORT __All_Trim := __d0_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)0) + '|' + TRIM((STRING)0);
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED __Mapping0 := 'UID(UID),ultid(Ult_I_D_:0),orgid(Org_I_D_:0),extendedfamily(Extended_Family_:0),nodes_total(Nodes_Total_:0),org_seg(Org_Segment_:\'\'),dt_vendor_first_reported(Date_Vendor_First_Reported_:DATE),dt_vendor_last_reported(Date_Vendor_Last_Reported_:DATE),vl_id(Source_Group_I_D_:\'\'),source(Source_:\'\'),dt_first_seen(Date_First_Seen_:EPOCH),dt_last_seen(Date_Last_Seen_:EPOCH),DPMBitmap(__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_Ids,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_Ids),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_BIPV2__Key_BH_Linking_Ids);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_Norm,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2__Key_BH_Linking_Ids_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  EXPORT InData := __d0;
  EXPORT Vendor_Dates_Layout := RECORD
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
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
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.ntyp(E_Business_Ult().Typ) Extended_Family_;
    KEL.typ.nint Nodes_Total_;
    KEL.typ.nstr Source_Group_I_D_;
    KEL.typ.nstr Org_Segment_;
    KEL.typ.ndataset(Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Business_Org_Group := __PostFilter;
  Layout Business_Org__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Ult_I_D_ := KEL.Intake.SingleValue(__recs,Ult_I_D_);
    SELF.Org_I_D_ := KEL.Intake.SingleValue(__recs,Org_I_D_);
    SELF.Extended_Family_ := KEL.Intake.SingleValue(__recs,Extended_Family_);
    SELF.Nodes_Total_ := KEL.Intake.SingleValue(__recs,Nodes_Total_);
    SELF.Source_Group_I_D_ := KEL.Intake.SingleValue(__recs,Source_Group_I_D_);
    SELF.Org_Segment_ := KEL.Intake.SingleValue(__recs,Org_Segment_);
    SELF.Vendor_Dates_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_},Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_),Vendor_Dates_Layout)(__NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Business_Org__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Vendor_Dates_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Vendor_Dates_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Business_Org_Group,COUNT(ROWS(LEFT))=1),GROUP,Business_Org__Single_Rollup(LEFT)) + ROLLUP(HAVING(Business_Org_Group,COUNT(ROWS(LEFT))>1),GROUP,Business_Org__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Ult_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ult_I_D_);
  EXPORT Org_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Org_I_D_);
  EXPORT Extended_Family__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Extended_Family_);
  EXPORT Nodes_Total__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Nodes_Total_);
  EXPORT Source_Group_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Source_Group_I_D_);
  EXPORT Org_Segment__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Org_Segment_);
  EXPORT Extended_Family__Orphan := JOIN(InData(__NN(Extended_Family_)),E_Business_Ult(__in,__cfg).__Result,__EEQP(LEFT.Extended_Family_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Extended_Family__Orphan),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2__Key_BH_Linking_Ids_Invalid),COUNT(Ult_I_D__SingleValue_Invalid),COUNT(Org_I_D__SingleValue_Invalid),COUNT(Extended_Family__SingleValue_Invalid),COUNT(Nodes_Total__SingleValue_Invalid),COUNT(Source_Group_I_D__SingleValue_Invalid),COUNT(Org_Segment__SingleValue_Invalid)}],{KEL.typ.int Extended_Family__Orphan,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2__Key_BH_Linking_Ids_Invalid,KEL.typ.int Ult_I_D__SingleValue_Invalid,KEL.typ.int Org_I_D__SingleValue_Invalid,KEL.typ.int Extended_Family__SingleValue_Invalid,KEL.typ.int Nodes_Total__SingleValue_Invalid,KEL.typ.int Source_Group_I_D__SingleValue_Invalid,KEL.typ.int Org_Segment__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'BusinessOrg','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2__Key_BH_Linking_Ids_Invalid),COUNT(__d0)},
    {'BusinessOrg','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d0(__NL(Ult_I_D_))),COUNT(__d0(__NN(Ult_I_D_)))},
    {'BusinessOrg','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d0(__NL(Org_I_D_))),COUNT(__d0(__NN(Org_I_D_)))},
    {'BusinessOrg','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExtendedFamily',COUNT(__d0(__NL(Extended_Family_))),COUNT(__d0(__NN(Extended_Family_)))},
    {'BusinessOrg','PublicRecords_KEL.ECL_Functions.Dataset_FDC','nodes_total',COUNT(__d0(__NL(Nodes_Total_))),COUNT(__d0(__NN(Nodes_Total_)))},
    {'BusinessOrg','PublicRecords_KEL.ECL_Functions.Dataset_FDC','org_seg',COUNT(__d0(__NL(Org_Segment_))),COUNT(__d0(__NN(Org_Segment_)))},
    {'BusinessOrg','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_first_reported',COUNT(__d0(__NL(Date_Vendor_First_Reported_))),COUNT(__d0(__NN(Date_Vendor_First_Reported_)))},
    {'BusinessOrg','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_last_reported',COUNT(__d0(__NL(Date_Vendor_Last_Reported_))),COUNT(__d0(__NN(Date_Vendor_Last_Reported_)))},
    {'BusinessOrg','PublicRecords_KEL.ECL_Functions.Dataset_FDC','vl_id',COUNT(__d0(__NL(Source_Group_I_D_))),COUNT(__d0(__NN(Source_Group_I_D_)))},
    {'BusinessOrg','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'BusinessOrg','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'BusinessOrg','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
