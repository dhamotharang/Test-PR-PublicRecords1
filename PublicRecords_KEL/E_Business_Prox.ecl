//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Business_Prox(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nint Prox_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nint Parent_Prox_I_D_;
    KEL.typ.nint Sele_Prox_I_D_;
    KEL.typ.nint Org_Prox_I_D_;
    KEL.typ.nint Ult_Prox_I_D_;
    KEL.typ.nint Levels_From_Top_;
    KEL.typ.nint Nodes_Below_;
    KEL.typ.nstr Prox_Segment_;
    KEL.typ.nstr Store_Number_;
    KEL.typ.nstr Active_Duns_Number_;
    KEL.typ.nstr Hist_Duns_Number_;
    KEL.typ.nstr Deleted_Key_;
    KEL.typ.nstr Duns_Number_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),ultid(Ult_I_D_:0),orgid(Org_I_D_:0),seleid(Sele_I_D_:0),proxid(Prox_I_D_:0),Legal_(Legal_:0),parentproxid(Parent_Prox_I_D_:0),seleproxid(Sele_Prox_I_D_:0),orgproxid(Org_Prox_I_D_:0),ultproxid(Ult_Prox_I_D_:0),levelsfromtop(Levels_From_Top_:0),nodesbelow(Nodes_Below_:0),proxsegment(Prox_Segment_:\'\'),storenumber(Store_Number_:\'\'),activedunsnumber(Active_Duns_Number_:\'\'),histdunsnumber(Hist_Duns_Number_:\'\'),deletedkey(Deleted_Key_:\'\'),dunsnumber(Duns_Number_:\'\'),datevendorfirstreported(Date_Vendor_First_Reported_:DATE),datevendorlastreported(Date_Vendor_Last_Reported_:DATE),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in.Dataset_BIPV2__Key_BH_Linking_Ids,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid)));
  EXPORT __All_Trim := __d0_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)0) + '|' + TRIM((STRING)0) + '|' + TRIM((STRING)0) + '|' + TRIM((STRING)0);
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED __Mapping0 := 'UID(UID),ultid(Ult_I_D_:0),orgid(Org_I_D_:0),seleid(Sele_I_D_:0),proxid(Prox_I_D_:0),Legal_(Legal_:0),parent_proxid(Parent_Prox_I_D_:0),sele_proxid(Sele_Prox_I_D_:0),org_proxid(Org_Prox_I_D_:0),ultimate_proxid(Ult_Prox_I_D_:0),levels_from_top(Levels_From_Top_:0),nodes_below(Nodes_Below_:0),prox_seg(Prox_Segment_:\'\'),cnp_store_number(Store_Number_:\'\'),active_duns_number(Active_Duns_Number_:\'\'),hist_duns_number(Hist_Duns_Number_:\'\'),deleted_key(Deleted_Key_:\'\'),duns_number(Duns_Number_:\'\'),dt_vendor_first_reported(Date_Vendor_First_Reported_:DATE),dt_vendor_last_reported(Date_Vendor_Last_Reported_:DATE),source(Source_:\'\'),dt_first_seen(Date_First_Seen_:EPOCH),dt_last_seen(Date_Last_Seen_:EPOCH),DPMBitmap(__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_Ids,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_Ids),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_BIPV2__Key_BH_Linking_Ids);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_Norm,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  SHARED __d0_Legal__Layout := RECORD
    RECORDOF(__d0_UID_Mapped);
    KEL.typ.uid Legal_;
  END;
  SHARED __d0_Legal__Mapped := JOIN(__d0_UID_Mapped,E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d0_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2__Key_BH_Linking_Ids_Invalid := __d0_Legal__Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_Legal__Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  EXPORT InData := __d0;
  EXPORT Deleted_I_D_Numbers_Layout := RECORD
    KEL.typ.nstr Deleted_Key_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
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
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nint Prox_I_D_;
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nint Parent_Prox_I_D_;
    KEL.typ.nint Sele_Prox_I_D_;
    KEL.typ.nint Org_Prox_I_D_;
    KEL.typ.nint Ult_Prox_I_D_;
    KEL.typ.nint Levels_From_Top_;
    KEL.typ.nint Nodes_Below_;
    KEL.typ.nstr Prox_Segment_;
    KEL.typ.nstr Store_Number_;
    KEL.typ.nstr Active_Duns_Number_;
    KEL.typ.nstr Hist_Duns_Number_;
    KEL.typ.nstr Duns_Number_;
    KEL.typ.ndataset(Deleted_I_D_Numbers_Layout) Deleted_I_D_Numbers_;
    KEL.typ.ndataset(Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Business_Prox_Group := __PostFilter;
  Layout Business_Prox__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Ult_I_D_ := KEL.Intake.SingleValue(__recs,Ult_I_D_);
    SELF.Org_I_D_ := KEL.Intake.SingleValue(__recs,Org_I_D_);
    SELF.Sele_I_D_ := KEL.Intake.SingleValue(__recs,Sele_I_D_);
    SELF.Prox_I_D_ := KEL.Intake.SingleValue(__recs,Prox_I_D_);
    SELF.Legal_ := KEL.Intake.SingleValue(__recs,Legal_);
    SELF.Parent_Prox_I_D_ := KEL.Intake.SingleValue(__recs,Parent_Prox_I_D_);
    SELF.Sele_Prox_I_D_ := KEL.Intake.SingleValue(__recs,Sele_Prox_I_D_);
    SELF.Org_Prox_I_D_ := KEL.Intake.SingleValue(__recs,Org_Prox_I_D_);
    SELF.Ult_Prox_I_D_ := KEL.Intake.SingleValue(__recs,Ult_Prox_I_D_);
    SELF.Levels_From_Top_ := KEL.Intake.SingleValue(__recs,Levels_From_Top_);
    SELF.Nodes_Below_ := KEL.Intake.SingleValue(__recs,Nodes_Below_);
    SELF.Prox_Segment_ := KEL.Intake.SingleValue(__recs,Prox_Segment_);
    SELF.Store_Number_ := KEL.Intake.SingleValue(__recs,Store_Number_);
    SELF.Active_Duns_Number_ := KEL.Intake.SingleValue(__recs,Active_Duns_Number_);
    SELF.Hist_Duns_Number_ := KEL.Intake.SingleValue(__recs,Hist_Duns_Number_);
    SELF.Duns_Number_ := KEL.Intake.SingleValue(__recs,Duns_Number_);
    SELF.Deleted_I_D_Numbers_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Deleted_Key_},Deleted_Key_),Deleted_I_D_Numbers_Layout)(__NN(Deleted_Key_)));
    SELF.Vendor_Dates_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_},Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_),Vendor_Dates_Layout)(__NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Business_Prox__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Deleted_I_D_Numbers_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Deleted_I_D_Numbers_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Deleted_Key_)));
    SELF.Vendor_Dates_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Vendor_Dates_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Business_Prox_Group,COUNT(ROWS(LEFT))=1),GROUP,Business_Prox__Single_Rollup(LEFT)) + ROLLUP(HAVING(Business_Prox_Group,COUNT(ROWS(LEFT))>1),GROUP,Business_Prox__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Ult_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ult_I_D_);
  EXPORT Org_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Org_I_D_);
  EXPORT Sele_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sele_I_D_);
  EXPORT Prox_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Prox_I_D_);
  EXPORT Legal__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Legal_);
  EXPORT Parent_Prox_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Parent_Prox_I_D_);
  EXPORT Sele_Prox_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sele_Prox_I_D_);
  EXPORT Org_Prox_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Org_Prox_I_D_);
  EXPORT Ult_Prox_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ult_Prox_I_D_);
  EXPORT Levels_From_Top__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Levels_From_Top_);
  EXPORT Nodes_Below__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Nodes_Below_);
  EXPORT Prox_Segment__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Prox_Segment_);
  EXPORT Store_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Store_Number_);
  EXPORT Active_Duns_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Active_Duns_Number_);
  EXPORT Hist_Duns_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Hist_Duns_Number_);
  EXPORT Duns_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Duns_Number_);
  EXPORT Legal__Orphan := JOIN(InData(__NN(Legal_)),E_Business_Sele(__in,__cfg).__Result,__EEQP(LEFT.Legal_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Legal__Orphan),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2__Key_BH_Linking_Ids_Invalid),COUNT(Ult_I_D__SingleValue_Invalid),COUNT(Org_I_D__SingleValue_Invalid),COUNT(Sele_I_D__SingleValue_Invalid),COUNT(Prox_I_D__SingleValue_Invalid),COUNT(Legal__SingleValue_Invalid),COUNT(Parent_Prox_I_D__SingleValue_Invalid),COUNT(Sele_Prox_I_D__SingleValue_Invalid),COUNT(Org_Prox_I_D__SingleValue_Invalid),COUNT(Ult_Prox_I_D__SingleValue_Invalid),COUNT(Levels_From_Top__SingleValue_Invalid),COUNT(Nodes_Below__SingleValue_Invalid),COUNT(Prox_Segment__SingleValue_Invalid),COUNT(Store_Number__SingleValue_Invalid),COUNT(Active_Duns_Number__SingleValue_Invalid),COUNT(Hist_Duns_Number__SingleValue_Invalid),COUNT(Duns_Number__SingleValue_Invalid)}],{KEL.typ.int Legal__Orphan,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2__Key_BH_Linking_Ids_Invalid,KEL.typ.int Ult_I_D__SingleValue_Invalid,KEL.typ.int Org_I_D__SingleValue_Invalid,KEL.typ.int Sele_I_D__SingleValue_Invalid,KEL.typ.int Prox_I_D__SingleValue_Invalid,KEL.typ.int Legal__SingleValue_Invalid,KEL.typ.int Parent_Prox_I_D__SingleValue_Invalid,KEL.typ.int Sele_Prox_I_D__SingleValue_Invalid,KEL.typ.int Org_Prox_I_D__SingleValue_Invalid,KEL.typ.int Ult_Prox_I_D__SingleValue_Invalid,KEL.typ.int Levels_From_Top__SingleValue_Invalid,KEL.typ.int Nodes_Below__SingleValue_Invalid,KEL.typ.int Prox_Segment__SingleValue_Invalid,KEL.typ.int Store_Number__SingleValue_Invalid,KEL.typ.int Active_Duns_Number__SingleValue_Invalid,KEL.typ.int Hist_Duns_Number__SingleValue_Invalid,KEL.typ.int Duns_Number__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_BIPV2__Key_BH_Linking_Ids_Invalid),COUNT(__d0)},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d0(__NL(Ult_I_D_))),COUNT(__d0(__NN(Ult_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d0(__NL(Org_I_D_))),COUNT(__d0(__NN(Org_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d0(__NL(Sele_I_D_))),COUNT(__d0(__NN(Sele_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','proxid',COUNT(__d0(__NL(Prox_I_D_))),COUNT(__d0(__NN(Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d0(__NL(Legal_))),COUNT(__d0(__NN(Legal_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','parent_proxid',COUNT(__d0(__NL(Parent_Prox_I_D_))),COUNT(__d0(__NN(Parent_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sele_proxid',COUNT(__d0(__NL(Sele_Prox_I_D_))),COUNT(__d0(__NN(Sele_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','org_proxid',COUNT(__d0(__NL(Org_Prox_I_D_))),COUNT(__d0(__NN(Org_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultimate_proxid',COUNT(__d0(__NL(Ult_Prox_I_D_))),COUNT(__d0(__NN(Ult_Prox_I_D_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','levels_from_top',COUNT(__d0(__NL(Levels_From_Top_))),COUNT(__d0(__NN(Levels_From_Top_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','nodes_below',COUNT(__d0(__NL(Nodes_Below_))),COUNT(__d0(__NN(Nodes_Below_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prox_seg',COUNT(__d0(__NL(Prox_Segment_))),COUNT(__d0(__NN(Prox_Segment_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cnp_store_number',COUNT(__d0(__NL(Store_Number_))),COUNT(__d0(__NN(Store_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','active_duns_number',COUNT(__d0(__NL(Active_Duns_Number_))),COUNT(__d0(__NN(Active_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','hist_duns_number',COUNT(__d0(__NL(Hist_Duns_Number_))),COUNT(__d0(__NN(Hist_Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','deleted_key',COUNT(__d0(__NL(Deleted_Key_))),COUNT(__d0(__NN(Deleted_Key_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','duns_number',COUNT(__d0(__NL(Duns_Number_))),COUNT(__d0(__NN(Duns_Number_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_first_reported',COUNT(__d0(__NL(Date_Vendor_First_Reported_))),COUNT(__d0(__NN(Date_Vendor_First_Reported_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_last_reported',COUNT(__d0(__NL(Date_Vendor_Last_Reported_))),COUNT(__d0(__NN(Date_Vendor_Last_Reported_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'BusinessProx','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
