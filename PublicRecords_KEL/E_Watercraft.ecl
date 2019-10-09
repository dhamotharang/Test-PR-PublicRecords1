//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_Watercraft(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Watercraft_Key_;
    KEL.typ.nstr Sequence_Key_;
    KEL.typ.nstr Origin_State_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(DEFAULT:UID),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),watercraftkey(DEFAULT:Watercraft_Key_:\'\'),sequencekey(DEFAULT:Sequence_Key_:\'\'),originstate(DEFAULT:Origin_State_:\'\'),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in.Dataset_Watercraft__Key_Watercraft_SID,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.watercraft_key)));
  SHARED __d1_Trim := PROJECT(__in.Dataset_Watercraft__Watercraft__Key_LinkIds,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.watercraft_key)));
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
  SHARED __Mapping0 := 'UID(DEFAULT:UID),date_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:DATE),date_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:DATE),watercraft_key(OVERRIDE:Watercraft_Key_:\'\'),sequence_key(OVERRIDE:Sequence_Key_:\'\'),state_origin(OVERRIDE:Origin_State_:\'\'),src(OVERRIDE:Source_:\'\'),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Watercraft__Key_Watercraft_SID,TRANSFORM(RECORDOF(__in.Dataset_Watercraft__Key_Watercraft_SID),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Watercraft__Key_Watercraft_SID);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_Norm,Lookup,TRIM((STRING)LEFT.watercraft_key) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Watercraft__Key_Watercraft_SID_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_Vendor_First_Reported_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Date_Vendor_Last_Reported_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping1 := 'UID(DEFAULT:UID),date_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:DATE:Date_Vendor_First_Reported_1Rule),date_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:DATE:Date_Vendor_Last_Reported_1Rule),watercraft_key(OVERRIDE:Watercraft_Key_:\'\'),sequence_key(OVERRIDE:Sequence_Key_:\'\'),state_origin(OVERRIDE:Origin_State_:\'\'),src(OVERRIDE:Source_:\'\'),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_1Rule),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Watercraft__Watercraft__Key_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_Watercraft__Watercraft__Key_LinkIds),SELF:=RIGHT));
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Watercraft__Watercraft__Key_LinkIds);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_Norm,Lookup,TRIM((STRING)LEFT.watercraft_key) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Watercraft__Watercraft__Key_LinkIds_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1;
  EXPORT Date_Information_Layout := RECORD
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Origin_States_Layout := RECORD
    KEL.typ.nstr Origin_State_;
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
    KEL.typ.ndataset(Date_Information_Layout) Date_Information_;
    KEL.typ.nstr Watercraft_Key_;
    KEL.typ.nstr Sequence_Key_;
    KEL.typ.ndataset(Origin_States_Layout) Origin_States_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Watercraft_Group := __PostFilter;
  Layout Watercraft__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Date_Information_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_},Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_),Date_Information_Layout)(__NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Watercraft_Key_ := KEL.Intake.SingleValue(__recs,Watercraft_Key_);
    SELF.Sequence_Key_ := KEL.Intake.SingleValue(__recs,Sequence_Key_);
    SELF.Origin_States_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Origin_State_},Origin_State_),Origin_States_Layout)(__NN(Origin_State_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Watercraft__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Date_Information_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Date_Information_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Origin_States_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Origin_States_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Origin_State_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Watercraft_Group,COUNT(ROWS(LEFT))=1),GROUP,Watercraft__Single_Rollup(LEFT)) + ROLLUP(HAVING(Watercraft_Group,COUNT(ROWS(LEFT))>1),GROUP,Watercraft__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Watercraft_Key__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Watercraft_Key_);
  EXPORT Sequence_Key__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sequence_Key_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Watercraft__Key_Watercraft_SID_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Watercraft__Watercraft__Key_LinkIds_Invalid),COUNT(Watercraft_Key__SingleValue_Invalid),COUNT(Sequence_Key__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Watercraft__Key_Watercraft_SID_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Watercraft__Watercraft__Key_LinkIds_Invalid,KEL.typ.int Watercraft_Key__SingleValue_Invalid,KEL.typ.int Sequence_Key__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Watercraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Watercraft__Key_Watercraft_SID_Invalid),COUNT(__d0)},
    {'Watercraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_vendor_first_reported',COUNT(__d0(__NL(Date_Vendor_First_Reported_))),COUNT(__d0(__NN(Date_Vendor_First_Reported_)))},
    {'Watercraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_vendor_last_reported',COUNT(__d0(__NL(Date_Vendor_Last_Reported_))),COUNT(__d0(__NN(Date_Vendor_Last_Reported_)))},
    {'Watercraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','watercraft_key',COUNT(__d0(__NL(Watercraft_Key_))),COUNT(__d0(__NN(Watercraft_Key_)))},
    {'Watercraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sequence_key',COUNT(__d0(__NL(Sequence_Key_))),COUNT(__d0(__NN(Sequence_Key_)))},
    {'Watercraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','state_origin',COUNT(__d0(__NL(Origin_State_))),COUNT(__d0(__NN(Origin_State_)))},
    {'Watercraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Watercraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Watercraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Watercraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Watercraft__Watercraft__Key_LinkIds_Invalid),COUNT(__d1)},
    {'Watercraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_vendor_first_reported',COUNT(__d1(__NL(Date_Vendor_First_Reported_))),COUNT(__d1(__NN(Date_Vendor_First_Reported_)))},
    {'Watercraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_vendor_last_reported',COUNT(__d1(__NL(Date_Vendor_Last_Reported_))),COUNT(__d1(__NN(Date_Vendor_Last_Reported_)))},
    {'Watercraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','watercraft_key',COUNT(__d1(__NL(Watercraft_Key_))),COUNT(__d1(__NN(Watercraft_Key_)))},
    {'Watercraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sequence_key',COUNT(__d1(__NL(Sequence_Key_))),COUNT(__d1(__NN(Sequence_Key_)))},
    {'Watercraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','state_origin',COUNT(__d1(__NL(Origin_State_))),COUNT(__d1(__NN(Origin_State_)))},
    {'Watercraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'Watercraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Watercraft','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
