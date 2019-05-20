//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Sele_Person(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.nkdate Date_First_Seen_Contact_;
    KEL.typ.nkdate Date_Last_Seen_Contact_;
    KEL.typ.nstr Contact_Type_;
    KEL.typ.nstr Job_Title_;
    KEL.typ.nstr Contact_Status_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'Legal_(Legal_:0),contact(Contact_:0),datefirstseencontact(Date_First_Seen_Contact_:DATE),datelastseencontact(Date_Last_Seen_Contact_:DATE),contacttype(Contact_Type_:\'\'),jobtitle(Job_Title_:\'\'),contactstatus(Contact_Status_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'Legal_(Legal_:0),contact_did(Contact_:0),dt_first_seen_contact(Date_First_Seen_Contact_:DATE),dt_last_seen_contact(Date_Last_Seen_Contact_:DATE),contact_type_derived(Contact_Type_:\'\'),contact_job_title_derived(Job_Title_:\'\'),contact_status_derived(Contact_Status_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH),DPMBitmap(__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2__Key_BH_Linking_Ids,TRANSFORM(RECORDOF(__in.Dataset_BIPV2__Key_BH_Linking_Ids),SELF:=RIGHT));
  SHARED __d0_Legal__Layout := RECORD
    RECORDOF(__d0_Norm);
    KEL.typ.uid Legal_;
  END;
  SHARED __d0_Legal__Mapped := JOIN(__d0_Norm,E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d0_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Legal__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  EXPORT InData := __d0;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.nkdate Date_First_Seen_Contact_;
    KEL.typ.nkdate Date_Last_Seen_Contact_;
    KEL.typ.nstr Contact_Type_;
    KEL.typ.nstr Job_Title_;
    KEL.typ.nstr Contact_Status_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Legal_,Contact_,Date_First_Seen_Contact_,Date_Last_Seen_Contact_,Contact_Type_,Job_Title_,Contact_Status_,ALL));
  Sele_Person_Group := __PostFilter;
  Layout Sele_Person__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Sele_Person__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Sele_Person_Group,COUNT(ROWS(LEFT))=1),GROUP,Sele_Person__Single_Rollup(LEFT)) + ROLLUP(HAVING(Sele_Person_Group,COUNT(ROWS(LEFT))>1),GROUP,Sele_Person__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Legal__Orphan := JOIN(InData(__NN(Legal_)),E_Business_Sele(__in,__cfg).__Result,__EEQP(LEFT.Legal_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Contact__Orphan := JOIN(InData(__NN(Contact_)),E_Person(__in,__cfg).__Result,__EEQP(LEFT.Contact_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Legal__Orphan),COUNT(Contact__Orphan)}],{KEL.typ.int Legal__Orphan,KEL.typ.int Contact__Orphan});
  EXPORT NullCounts := DATASET([
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d0(__NL(Legal_))),COUNT(__d0(__NN(Legal_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_did',COUNT(__d0(__NL(Contact_))),COUNT(__d0(__NN(Contact_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_first_seen_contact',COUNT(__d0(__NL(Date_First_Seen_Contact_))),COUNT(__d0(__NN(Date_First_Seen_Contact_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_last_seen_contact',COUNT(__d0(__NL(Date_Last_Seen_Contact_))),COUNT(__d0(__NN(Date_Last_Seen_Contact_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_type_derived',COUNT(__d0(__NL(Contact_Type_))),COUNT(__d0(__NN(Contact_Type_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_job_title_derived',COUNT(__d0(__NL(Job_Title_))),COUNT(__d0(__NN(Job_Title_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_status_derived',COUNT(__d0(__NL(Contact_Status_))),COUNT(__d0(__NN(Contact_Status_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
