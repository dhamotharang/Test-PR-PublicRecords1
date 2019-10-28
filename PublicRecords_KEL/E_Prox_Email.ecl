//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Prox,E_Business_Sele,E_Business_Ult,E_Email FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_Prox_Email(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Business_Prox().Typ) Site_;
    KEL.typ.ntyp(E_Email().Typ) _r_Email_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nint Prox_I_D_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr Contact_Email_Username_;
    KEL.typ.nstr Contact_Email_Domain_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'Site_(DEFAULT:Site_:0),_r_Email_(DEFAULT:_r_Email_:0),ultid(DEFAULT:Ult_I_D_:0),orgid(DEFAULT:Org_I_D_:0),seleid(DEFAULT:Sele_I_D_:0),proxid(DEFAULT:Prox_I_D_:0),emailaddress(DEFAULT:Email_Address_:\'\'),contactemailusername(DEFAULT:Contact_Email_Username_:\'\'),contactemaildomain(DEFAULT:Contact_Email_Domain_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'Site_(DEFAULT:Site_:0),_r_Email_(DEFAULT:_r_Email_:0),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),proxid(DEFAULT:Prox_I_D_:0),contact_email(OVERRIDE:Email_Address_:\'\'),contact_email_username(OVERRIDE:Contact_Email_Username_:\'\'),contact_email_domain(OVERRIDE:Contact_Email_Domain_:\'\'),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:DATE),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:DATE),source(OVERRIDE:Source_:\'\'),dt_first_seen_contact(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen_contact(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2_Build__kfetch_contact_linkids,TRANSFORM(RECORDOF(__in.Dataset_BIPV2_Build__kfetch_contact_linkids),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm(contact_email <> '' AND (UNSIGNED)proxid<>0);
  SHARED __d0_Site__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Site_;
  END;
  SHARED __d0_Site__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d0_KELfiltered,'ultid,orgid,seleid,ProxID','__in'),E_Business_Prox(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.ProxID) = RIGHT.KeyVal,TRANSFORM(__d0_Site__Layout,SELF.Site_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0__r_Email__Layout := RECORD
    RECORDOF(__d0_Site__Mapped);
    KEL.typ.uid _r_Email_;
  END;
  SHARED __d0__r_Email__Mapped := JOIN(KEL.Intake.AppendNonExistUidComponents(__d0_Site__Mapped,'contact_email','__in'),E_Email(__in,__cfg).Lookup,TRIM((STRING)LEFT.contact_email) = RIGHT.KeyVal,TRANSFORM(__d0__r_Email__Layout,SELF._r_Email_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0__r_Email__Mapped;
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping0_Transform(LEFT)));
  EXPORT InData := __d0;
  EXPORT Emails_Layout := RECORD
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr Contact_Email_Username_;
    KEL.typ.nstr Contact_Email_Domain_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Business_Prox().Typ) Site_;
    KEL.typ.ntyp(E_Email().Typ) _r_Email_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nint Prox_I_D_;
    KEL.typ.ndataset(Emails_Layout) Emails_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Site_,_r_Email_,Ult_I_D_,Org_I_D_,Sele_I_D_,Prox_I_D_,ALL));
  Prox_Email_Group := __PostFilter;
  Layout Prox_Email__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Emails_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Email_Address_,Contact_Email_Username_,Contact_Email_Domain_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Header_Hit_Flag_,Source_},Email_Address_,Contact_Email_Username_,Contact_Email_Domain_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Header_Hit_Flag_,Source_),Emails_Layout)(__NN(Email_Address_) OR __NN(Contact_Email_Username_) OR __NN(Contact_Email_Domain_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_) OR __NN(Header_Hit_Flag_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Header_Hit_Flag_,Source_},Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Header_Hit_Flag_,Source_),Data_Sources_Layout)(__NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_) OR __NN(Header_Hit_Flag_) OR __NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Prox_Email__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Emails_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Emails_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Email_Address_) OR __NN(Contact_Email_Username_) OR __NN(Contact_Email_Domain_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_) OR __NN(Header_Hit_Flag_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_) OR __NN(Header_Hit_Flag_) OR __NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Prox_Email_Group,COUNT(ROWS(LEFT))=1),GROUP,Prox_Email__Single_Rollup(LEFT)) + ROLLUP(HAVING(Prox_Email_Group,COUNT(ROWS(LEFT))>1),GROUP,Prox_Email__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Site__Orphan := JOIN(InData(__NN(Site_)),E_Business_Prox(__in,__cfg).__Result,__EEQP(LEFT.Site_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT _r_Email__Orphan := JOIN(InData(__NN(_r_Email_)),E_Email(__in,__cfg).__Result,__EEQP(LEFT._r_Email_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Site__Orphan),COUNT(_r_Email__Orphan)}],{KEL.typ.int Site__Orphan,KEL.typ.int _r_Email__Orphan});
  EXPORT NullCounts := DATASET([
    {'ProxEmail','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Site',COUNT(__d0(__NL(Site_))),COUNT(__d0(__NN(Site_)))},
    {'ProxEmail','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rEmail',COUNT(__d0(__NL(_r_Email_))),COUNT(__d0(__NN(_r_Email_)))},
    {'ProxEmail','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d0(__NL(Ult_I_D_))),COUNT(__d0(__NN(Ult_I_D_)))},
    {'ProxEmail','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d0(__NL(Org_I_D_))),COUNT(__d0(__NN(Org_I_D_)))},
    {'ProxEmail','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d0(__NL(Sele_I_D_))),COUNT(__d0(__NN(Sele_I_D_)))},
    {'ProxEmail','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProxID',COUNT(__d0(__NL(Prox_I_D_))),COUNT(__d0(__NN(Prox_I_D_)))},
    {'ProxEmail','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_email',COUNT(__d0(__NL(Email_Address_))),COUNT(__d0(__NN(Email_Address_)))},
    {'ProxEmail','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_email_username',COUNT(__d0(__NL(Contact_Email_Username_))),COUNT(__d0(__NN(Contact_Email_Username_)))},
    {'ProxEmail','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_email_domain',COUNT(__d0(__NL(Contact_Email_Domain_))),COUNT(__d0(__NN(Contact_Email_Domain_)))},
    {'ProxEmail','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_last_reported',COUNT(__d0(__NL(Date_Vendor_Last_Reported_))),COUNT(__d0(__NN(Date_Vendor_Last_Reported_)))},
    {'ProxEmail','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_first_reported',COUNT(__d0(__NL(Date_Vendor_First_Reported_))),COUNT(__d0(__NN(Date_Vendor_First_Reported_)))},
    {'ProxEmail','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'ProxEmail','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'ProxEmail','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
