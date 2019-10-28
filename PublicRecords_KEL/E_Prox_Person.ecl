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
    KEL.typ.nstr Contact_First_Name_;
    KEL.typ.nstr Contact_Middle_Name_;
    KEL.typ.nstr Contact_Last_Name_;
    KEL.typ.nstr Contact_Name_Suffix_;
    KEL.typ.nint Contact_S_S_N_;
    KEL.typ.nint Contact_Phone_Number_;
    KEL.typ.nint Contact_Score_;
    KEL.typ.nstr Contact_Type_;
    KEL.typ.nstr Contact_Email_;
    KEL.typ.nstr Contact_Email_Username_;
    KEL.typ.nstr Contact_Email_Domain_;
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
  SHARED __Mapping := 'Site_(DEFAULT:Site_:0),contact(DEFAULT:Contact_:0),jobtitle(DEFAULT:Job_Title_:\'\'),contactstatus(DEFAULT:Contact_Status_:\'\'),contactfirstname(DEFAULT:Contact_First_Name_:\'\'),contactmiddlename(DEFAULT:Contact_Middle_Name_:\'\'),contactlastname(DEFAULT:Contact_Last_Name_:\'\'),contactnamesuffix(DEFAULT:Contact_Name_Suffix_:\'\'),contactssn(DEFAULT:Contact_S_S_N_:0),contactphonenumber(DEFAULT:Contact_Phone_Number_:0),contactscore(DEFAULT:Contact_Score_:0),contacttype(DEFAULT:Contact_Type_:\'\'),contactemail(DEFAULT:Contact_Email_:\'\'),contactemailusername(DEFAULT:Contact_Email_Username_:\'\'),contactemaildomain(DEFAULT:Contact_Email_Domain_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),isexecutive(DEFAULT:Is_Executive_),executiveorder(DEFAULT:Executive_Order_:0),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'Site_(DEFAULT:Site_:0),contact_did(OVERRIDE:Contact_:0),jobtitle(OVERRIDE:Job_Title_:\'\'),status(OVERRIDE:Contact_Status_:\'\'),contact_name.fname(OVERRIDE:Contact_First_Name_:\'\'),contact_name.mname(OVERRIDE:Contact_Middle_Name_:\'\'),contact_name.lname(OVERRIDE:Contact_Last_Name_:\'\'),contact_name.name_suffix(OVERRIDE:Contact_Name_Suffix_:\'\'),contact_ssn(OVERRIDE:Contact_S_S_N_:0),contact_phone(OVERRIDE:Contact_Phone_Number_:0),contact_score(OVERRIDE:Contact_Score_:0),contact_type_derived(OVERRIDE:Contact_Type_:\'\'),contact_email(OVERRIDE:Contact_Email_:\'\'),contact_email_username(OVERRIDE:Contact_Email_Username_:\'\'),contact_email_domain(OVERRIDE:Contact_Email_Domain_:\'\'),executive_ind(OVERRIDE:Is_Executive_),executive_ind_order(OVERRIDE:Executive_Order_:0),dt_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:DATE),dt_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:DATE),source(OVERRIDE:Source_:\'\'),dt_first_seen_contact(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen_contact(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
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
  EXPORT InData := __d0;
  EXPORT Contact_Info_Layout := RECORD
    KEL.typ.nstr Job_Title_;
    KEL.typ.nstr Contact_Status_;
    KEL.typ.nstr Contact_First_Name_;
    KEL.typ.nstr Contact_Middle_Name_;
    KEL.typ.nstr Contact_Last_Name_;
    KEL.typ.nstr Contact_Name_Suffix_;
    KEL.typ.nint Contact_S_S_N_;
    KEL.typ.nint Contact_Phone_Number_;
    KEL.typ.nint Contact_Score_;
    KEL.typ.nstr Contact_Type_;
    KEL.typ.nbool Is_Executive_;
    KEL.typ.nint Executive_Order_;
    KEL.typ.nstr Contact_Email_;
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
    SELF.Contact_Info_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Job_Title_,Contact_Status_,Contact_First_Name_,Contact_Middle_Name_,Contact_Last_Name_,Contact_Name_Suffix_,Contact_S_S_N_,Contact_Phone_Number_,Contact_Score_,Contact_Type_,Is_Executive_,Executive_Order_,Contact_Email_,Contact_Email_Username_,Contact_Email_Domain_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Header_Hit_Flag_,Source_},Job_Title_,Contact_Status_,Contact_First_Name_,Contact_Middle_Name_,Contact_Last_Name_,Contact_Name_Suffix_,Contact_S_S_N_,Contact_Phone_Number_,Contact_Score_,Contact_Type_,Is_Executive_,Executive_Order_,Contact_Email_,Contact_Email_Username_,Contact_Email_Domain_,Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Header_Hit_Flag_,Source_),Contact_Info_Layout)(__NN(Job_Title_) OR __NN(Contact_Status_) OR __NN(Contact_First_Name_) OR __NN(Contact_Middle_Name_) OR __NN(Contact_Last_Name_) OR __NN(Contact_Name_Suffix_) OR __NN(Contact_S_S_N_) OR __NN(Contact_Phone_Number_) OR __NN(Contact_Score_) OR __NN(Contact_Type_) OR __NN(Is_Executive_) OR __NN(Executive_Order_) OR __NN(Contact_Email_) OR __NN(Contact_Email_Username_) OR __NN(Contact_Email_Domain_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_) OR __NN(Header_Hit_Flag_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Header_Hit_Flag_,Source_},Date_Vendor_First_Reported_,Date_Vendor_Last_Reported_,Header_Hit_Flag_,Source_),Data_Sources_Layout)(__NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_) OR __NN(Header_Hit_Flag_) OR __NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Prox_Person__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Contact_Info_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Contact_Info_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Job_Title_) OR __NN(Contact_Status_) OR __NN(Contact_First_Name_) OR __NN(Contact_Middle_Name_) OR __NN(Contact_Last_Name_) OR __NN(Contact_Name_Suffix_) OR __NN(Contact_S_S_N_) OR __NN(Contact_Phone_Number_) OR __NN(Contact_Score_) OR __NN(Contact_Type_) OR __NN(Is_Executive_) OR __NN(Executive_Order_) OR __NN(Contact_Email_) OR __NN(Contact_Email_Username_) OR __NN(Contact_Email_Domain_) OR __NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_) OR __NN(Header_Hit_Flag_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Date_Vendor_First_Reported_) OR __NN(Date_Vendor_Last_Reported_) OR __NN(Header_Hit_Flag_) OR __NN(Source_)));
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
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_name.fname',COUNT(__d0(__NL(Contact_First_Name_))),COUNT(__d0(__NN(Contact_First_Name_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_name.mname',COUNT(__d0(__NL(Contact_Middle_Name_))),COUNT(__d0(__NN(Contact_Middle_Name_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_name.lname',COUNT(__d0(__NL(Contact_Last_Name_))),COUNT(__d0(__NN(Contact_Last_Name_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_name.name_suffix',COUNT(__d0(__NL(Contact_Name_Suffix_))),COUNT(__d0(__NN(Contact_Name_Suffix_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_ssn',COUNT(__d0(__NL(Contact_S_S_N_))),COUNT(__d0(__NN(Contact_S_S_N_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_phone',COUNT(__d0(__NL(Contact_Phone_Number_))),COUNT(__d0(__NN(Contact_Phone_Number_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_score',COUNT(__d0(__NL(Contact_Score_))),COUNT(__d0(__NN(Contact_Score_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_type_derived',COUNT(__d0(__NL(Contact_Type_))),COUNT(__d0(__NN(Contact_Type_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_email',COUNT(__d0(__NL(Contact_Email_))),COUNT(__d0(__NN(Contact_Email_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_email_username',COUNT(__d0(__NL(Contact_Email_Username_))),COUNT(__d0(__NN(Contact_Email_Username_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_email_domain',COUNT(__d0(__NL(Contact_Email_Domain_))),COUNT(__d0(__NN(Contact_Email_Domain_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','executive_ind',COUNT(__d0(__NL(Is_Executive_))),COUNT(__d0(__NN(Is_Executive_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','executive_ind_order',COUNT(__d0(__NL(Executive_Order_))),COUNT(__d0(__NN(Executive_Order_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_last_reported',COUNT(__d0(__NL(Date_Vendor_Last_Reported_))),COUNT(__d0(__NN(Date_Vendor_Last_Reported_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_first_reported',COUNT(__d0(__NL(Date_Vendor_First_Reported_))),COUNT(__d0(__NN(Date_Vendor_First_Reported_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'ProxPerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
