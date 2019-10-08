//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Prox,E_Business_Sele,E_Business_Ult,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_Prox_Person(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Business_Prox().Typ) Site_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.nstr Job_Title_;
    KEL.typ.nstr Contact_Status_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool Is_Executive_;
    KEL.typ.nint Executive_Order_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'Site_(DEFAULT:Site_:0),contact(DEFAULT:Contact_:0),jobtitle(DEFAULT:Job_Title_:\'\'),contactstatus(DEFAULT:Contact_Status_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),isexecutive(DEFAULT:Is_Executive_),executiveorder(DEFAULT:Executive_Order_:0),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'Site_(DEFAULT:Site_:0),contact_did(OVERRIDE:Contact_:0),jobtitle(OVERRIDE:Job_Title_:\'\'),status(OVERRIDE:Contact_Status_:\'\'),executive_ind(OVERRIDE:Is_Executive_),executive_ind_order(OVERRIDE:Executive_Order_:0),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:DATE),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:DATE),source(OVERRIDE:Source_:\'\'),dt_first_seen_contact(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen_contact(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2_Build__kfetch_contact_linkids,TRANSFORM(RECORDOF(__in.Dataset_BIPV2_Build__kfetch_contact_linkids),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((UNSIGNED)contact_did > 0 AND (UNSIGNED)proxid<>0);
  SHARED __d0_Site__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d0_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d0_KELfiltered,'ultid,orgid,seleid,proxid','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.proxid) = RIGHT.KeyVal,TRANSFORM(__d0_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Site__Mapped;
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping0_Transform(LEFT)));
  SHARED __d1_Site__Layout := RECORD
    RECORDOF(__in);
    KEL.typ.uid Site_;
  END;
  SHARED __d1_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__in,'UltID,OrgID,SeleID,ProxID','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.UltID) + '|' + TRIM((STRING)LEFT.OrgID) + '|' + TRIM((STRING)LEFT.SeleID) + '|' + TRIM((STRING)LEFT.ProxID) = RIGHT.KeyVal,TRANSFORM(__d1_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d1_Prefiltered := __d1_Site__Mapped;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1;
  EXPORT Contact_Info_Layout := RECORD
    KEL.typ.nstr Job_Title_;
    KEL.typ.nstr Contact_Status_;
    KEL.typ.nbool Is_Executive_;
    KEL.typ.nint Executive_Order_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Business_Prox().Typ) Site_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.ndataset(Contact_Info_Layout) Contact_Info_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Site_,Contact_,ALL));
  Prox_Person_Group := __PostFilter;
  Layout Prox_Person__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Contact_Info_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Job_Title_,Contact_Status_,Is_Executive_,Executive_Order_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_},Job_Title_,Contact_Status_,Is_Executive_,Executive_Order_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_),Contact_Info_Layout)(__NN(Job_Title_) OR __NN(Contact_Status_) OR __NN(Is_Executive_) OR __NN(Executive_Order_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Header_Hit_Flag_},Source_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Header_Hit_Flag_),Data_Sources_Layout)(__NN(Source_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_) OR __NN(Header_Hit_Flag_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Prox_Person__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Contact_Info_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Contact_Info_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Job_Title_) OR __NN(Contact_Status_) OR __NN(Is_Executive_) OR __NN(Executive_Order_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Source_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_) OR __NN(Header_Hit_Flag_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Prox_Person_Group,COUNT(ROWS(LEFT))=1),GROUP,Prox_Person__Single_Rollup(LEFT)) + ROLLUP(HAVING(Prox_Person_Group,COUNT(ROWS(LEFT))>1),GROUP,Prox_Person__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Site__Orphan := JOIN(InData(__NN(Site_)),E_Business_Prox(__in,__cfg).__Result,__EEQP(LEFT.Site_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Contact__Orphan := JOIN(InData(__NN(Contact_)),E_Person(__in,__cfg).__Result,__EEQP(LEFT.Contact_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Site__Orphan),COUNT(Contact__Orphan)}],{KEL.typ.int Site__Orphan,KEL.typ.int Contact__Orphan});
  EXPORT NullCounts := DATASET([
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d0(__NL(Site_))),COUNT(__d0(__NN(Site_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_did',COUNT(__d0(__NL(Contact_))),COUNT(__d0(__NN(Contact_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','JobTitle',COUNT(__d0(__NL(Job_Title_))),COUNT(__d0(__NN(Job_Title_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Status',COUNT(__d0(__NL(Contact_Status_))),COUNT(__d0(__NN(Contact_Status_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','executive_ind',COUNT(__d0(__NL(Is_Executive_))),COUNT(__d0(__NN(Is_Executive_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','executive_ind_order',COUNT(__d0(__NL(Executive_Order_))),COUNT(__d0(__NN(Executive_Order_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_last_reported',COUNT(__d0(__NL(Date_Vendor_Last_Reported_))),COUNT(__d0(__NN(Date_Vendor_Last_Reported_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_first_reported',COUNT(__d0(__NL(Date_Vendor_First_Reported_))),COUNT(__d0(__NN(Date_Vendor_First_Reported_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d1(__NL(Site_))),COUNT(__d1(__NN(Site_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Contact',COUNT(__d1(__NL(Contact_))),COUNT(__d1(__NN(Contact_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','JobTitle',COUNT(__d1(__NL(Job_Title_))),COUNT(__d1(__NN(Job_Title_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactStatus',COUNT(__d1(__NL(Contact_Status_))),COUNT(__d1(__NN(Contact_Status_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HeaderHitFlag',COUNT(__d1(__NL(Header_Hit_Flag_))),COUNT(__d1(__NN(Header_Hit_Flag_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsExecutive',COUNT(__d1(__NL(Is_Executive_))),COUNT(__d1(__NN(Is_Executive_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExecutiveOrder',COUNT(__d1(__NL(Executive_Order_))),COUNT(__d1(__NN(Executive_Order_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d1(__NL(Date_Vendor_Last_Reported_))),COUNT(__d1(__NN(Date_Vendor_Last_Reported_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d1(__NL(Date_Vendor_First_Reported_))),COUNT(__d1(__NN(Date_Vendor_First_Reported_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
