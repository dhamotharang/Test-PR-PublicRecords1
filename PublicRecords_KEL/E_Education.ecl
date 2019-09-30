//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_Education(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Sequence_;
    KEL.typ.nstr Key_;
    KEL.typ.nstr Raw_A_I_D_;
    KEL.typ.nkdate Student_Date_Vendor_First_Reported_;
    KEL.typ.nkdate Student_Date_Vendor_Last_Reported_;
    KEL.typ.nstr College_Name_;
    KEL.typ.nstr L_N_College_Name_;
    KEL.typ.nstr College_Code_;
    KEL.typ.nstr College_Type_;
    KEL.typ.nstr File_Type_;
    KEL.typ.nstr School_Size_Code_;
    KEL.typ.nstr Competitive_Code_;
    KEL.typ.nstr Tuition_Code_;
    KEL.typ.nstr Tier_;
    KEL.typ.nstr Tier2_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(DEFAULT:UID),sequence(DEFAULT:Sequence_:\'\'),key(DEFAULT:Key_:\'\'),rawaid(DEFAULT:Raw_A_I_D_:\'\'),studentdatevendorfirstreported(DEFAULT:Student_Date_Vendor_First_Reported_:DATE),studentdatevendorlastreported(DEFAULT:Student_Date_Vendor_Last_Reported_:DATE),collegename(DEFAULT:College_Name_:\'\'),lncollegename(DEFAULT:L_N_College_Name_:\'\'),collegecode(DEFAULT:College_Code_:\'\'),collegetype(DEFAULT:College_Type_:\'\'),filetype(DEFAULT:File_Type_:\'\'),schoolsizecode(DEFAULT:School_Size_Code_:\'\'),competitivecode(DEFAULT:Competitive_Code_:\'\'),tuitioncode(DEFAULT:Tuition_Code_:\'\'),tier(DEFAULT:Tier_:\'\'),tier2(DEFAULT:Tier2_:\'\'),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.Sequence) + '|' + TRIM((STRING)LEFT.Key) + '|' + TRIM((STRING)LEFT.RawAID)));
  EXPORT __All_Trim := __d0_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'') + '|' + TRIM((STRING)'') + '|' + TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__in,Lookup,TRIM((STRING)LEFT.Sequence) + '|' + TRIM((STRING)LEFT.Key) + '|' + TRIM((STRING)LEFT.RawAID) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0;
  EXPORT College_Characteristics_Layout := RECORD
    KEL.typ.nstr College_Code_;
    KEL.typ.nstr College_Type_;
    KEL.typ.nstr File_Type_;
    KEL.typ.nstr School_Size_Code_;
    KEL.typ.nstr Competitive_Code_;
    KEL.typ.nstr Tuition_Code_;
    KEL.typ.nstr Tier_;
    KEL.typ.nstr Tier2_;
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
    KEL.typ.nstr College_Name_;
    KEL.typ.nstr L_N_College_Name_;
    KEL.typ.nstr Sequence_;
    KEL.typ.nstr Key_;
    KEL.typ.nstr Raw_A_I_D_;
    KEL.typ.ndataset(College_Characteristics_Layout) College_Characteristics_;
    KEL.typ.nkdate Student_Date_Vendor_First_Reported_;
    KEL.typ.nkdate Student_Date_Vendor_Last_Reported_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Education_Group := __PostFilter;
  Layout Education__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.College_Name_ := KEL.Intake.SingleValue(__recs,College_Name_);
    SELF.L_N_College_Name_ := KEL.Intake.SingleValue(__recs,L_N_College_Name_);
    SELF.Sequence_ := KEL.Intake.SingleValue(__recs,Sequence_);
    SELF.Key_ := KEL.Intake.SingleValue(__recs,Key_);
    SELF.Raw_A_I_D_ := KEL.Intake.SingleValue(__recs,Raw_A_I_D_);
    SELF.College_Characteristics_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),College_Code_,College_Type_,File_Type_,School_Size_Code_,Competitive_Code_,Tuition_Code_,Tier_,Tier2_},College_Code_,College_Type_,File_Type_,School_Size_Code_,Competitive_Code_,Tuition_Code_,Tier_,Tier2_),College_Characteristics_Layout)(__NN(College_Code_) OR __NN(College_Type_) OR __NN(File_Type_) OR __NN(School_Size_Code_) OR __NN(Competitive_Code_) OR __NN(Tuition_Code_) OR __NN(Tier_) OR __NN(Tier2_)));
    SELF.Student_Date_Vendor_First_Reported_ := KEL.Intake.SingleValue(__recs,Student_Date_Vendor_First_Reported_);
    SELF.Student_Date_Vendor_Last_Reported_ := KEL.Intake.SingleValue(__recs,Student_Date_Vendor_Last_Reported_);
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Education__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.College_Characteristics_ := __CN(PROJECT(DATASET(__r),TRANSFORM(College_Characteristics_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(College_Code_) OR __NN(College_Type_) OR __NN(File_Type_) OR __NN(School_Size_Code_) OR __NN(Competitive_Code_) OR __NN(Tuition_Code_) OR __NN(Tier_) OR __NN(Tier2_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Education_Group,COUNT(ROWS(LEFT))=1),GROUP,Education__Single_Rollup(LEFT)) + ROLLUP(HAVING(Education_Group,COUNT(ROWS(LEFT))>1),GROUP,Education__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT College_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,College_Name_);
  EXPORT L_N_College_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,L_N_College_Name_);
  EXPORT Sequence__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sequence_);
  EXPORT Key__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Key_);
  EXPORT Raw_A_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Raw_A_I_D_);
  EXPORT Student_Date_Vendor_First_Reported__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Student_Date_Vendor_First_Reported_);
  EXPORT Student_Date_Vendor_Last_Reported__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Student_Date_Vendor_Last_Reported_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(College_Name__SingleValue_Invalid),COUNT(L_N_College_Name__SingleValue_Invalid),COUNT(Sequence__SingleValue_Invalid),COUNT(Key__SingleValue_Invalid),COUNT(Raw_A_I_D__SingleValue_Invalid),COUNT(Student_Date_Vendor_First_Reported__SingleValue_Invalid),COUNT(Student_Date_Vendor_Last_Reported__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid,KEL.typ.int College_Name__SingleValue_Invalid,KEL.typ.int L_N_College_Name__SingleValue_Invalid,KEL.typ.int Sequence__SingleValue_Invalid,KEL.typ.int Key__SingleValue_Invalid,KEL.typ.int Raw_A_I_D__SingleValue_Invalid,KEL.typ.int Student_Date_Vendor_First_Reported__SingleValue_Invalid,KEL.typ.int Student_Date_Vendor_Last_Reported__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(__d0)},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Sequence',COUNT(__d0(__NL(Sequence_))),COUNT(__d0(__NN(Sequence_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Key',COUNT(__d0(__NL(Key_))),COUNT(__d0(__NN(Key_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RawAID',COUNT(__d0(__NL(Raw_A_I_D_))),COUNT(__d0(__NN(Raw_A_I_D_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StudentDateVendorFirstReported',COUNT(__d0(__NL(Student_Date_Vendor_First_Reported_))),COUNT(__d0(__NN(Student_Date_Vendor_First_Reported_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','StudentDateVendorLastReported',COUNT(__d0(__NL(Student_Date_Vendor_Last_Reported_))),COUNT(__d0(__NN(Student_Date_Vendor_Last_Reported_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeName',COUNT(__d0(__NL(College_Name_))),COUNT(__d0(__NN(College_Name_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LNCollegeName',COUNT(__d0(__NL(L_N_College_Name_))),COUNT(__d0(__NN(L_N_College_Name_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeCode',COUNT(__d0(__NL(College_Code_))),COUNT(__d0(__NN(College_Code_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeType',COUNT(__d0(__NL(College_Type_))),COUNT(__d0(__NN(College_Type_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FileType',COUNT(__d0(__NL(File_Type_))),COUNT(__d0(__NN(File_Type_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SchoolSizeCode',COUNT(__d0(__NL(School_Size_Code_))),COUNT(__d0(__NN(School_Size_Code_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CompetitiveCode',COUNT(__d0(__NL(Competitive_Code_))),COUNT(__d0(__NN(Competitive_Code_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TuitionCode',COUNT(__d0(__NL(Tuition_Code_))),COUNT(__d0(__NN(Tuition_Code_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Tier',COUNT(__d0(__NL(Tier_))),COUNT(__d0(__NN(Tier_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Tier2',COUNT(__d0(__NL(Tier2_))),COUNT(__d0(__NN(Tier2_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
