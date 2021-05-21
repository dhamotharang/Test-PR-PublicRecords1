//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Person,E_Surname FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT E_Sele_Person(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Job_Title_;
    KEL.typ.nstr Contact_Status_;
    KEL.typ.nstr Contact_First_Name_;
    KEL.typ.nstr Contact_Middle_Name_;
    KEL.typ.ntyp(E_Surname().Typ) Last_Name_;
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
  SHARED __Mapping := 'Legal_(DEFAULT:Legal_:0),contact(DEFAULT:Contact_:0),ultid(DEFAULT:Ult_I_D_:0),orgid(DEFAULT:Org_I_D_:0),seleid(DEFAULT:Sele_I_D_:0),jobtitle(DEFAULT:Job_Title_:\'\'),contactstatus(DEFAULT:Contact_Status_:\'\'),contactfirstname(DEFAULT:Contact_First_Name_:\'\'),contactmiddlename(DEFAULT:Contact_Middle_Name_:\'\'),Last_Name_(DEFAULT:Last_Name_:0),contactlastname(DEFAULT:Contact_Last_Name_:\'\'),contactnamesuffix(DEFAULT:Contact_Name_Suffix_:\'\'),contactssn(DEFAULT:Contact_S_S_N_:0),contactphonenumber(DEFAULT:Contact_Phone_Number_:0),contactscore(DEFAULT:Contact_Score_:0),contacttype(DEFAULT:Contact_Type_:\'\'),contactemail(DEFAULT:Contact_Email_:\'\'),contactemailusername(DEFAULT:Contact_Email_Username_:\'\'),contactemaildomain(DEFAULT:Contact_Email_Domain_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),isexecutive(DEFAULT:Is_Executive_),executiveorder(DEFAULT:Executive_Order_:0),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'Legal_(DEFAULT:Legal_:0),contact_did(OVERRIDE:Contact_:0),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),jobtitle(OVERRIDE:Job_Title_:\'\'),status(OVERRIDE:Contact_Status_:\'\'),contact_name.fname(OVERRIDE:Contact_First_Name_:\'\'),contact_name.mname(OVERRIDE:Contact_Middle_Name_:\'\'),Last_Name_(OVERRIDE:Last_Name_:0),contact_name.lname(OVERRIDE:Contact_Last_Name_:\'\'),contact_name.name_suffix(OVERRIDE:Contact_Name_Suffix_:\'\'),contact_ssn(OVERRIDE:Contact_S_S_N_:0),contact_phone(OVERRIDE:Contact_Phone_Number_:0),contact_score(OVERRIDE:Contact_Score_:0),contact_type_derived(OVERRIDE:Contact_Type_:\'\'),contact_email(OVERRIDE:Contact_Email_:\'\'),contact_email_username(OVERRIDE:Contact_Email_Username_:\'\'),contact_email_domain(OVERRIDE:Contact_Email_Domain_:\'\'),executive_ind(OVERRIDE:Is_Executive_),executive_ind_order(OVERRIDE:Executive_Order_:0),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen_contact(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_0Rule),dt_last_seen_contact(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2_Build__kfetch_contact_linkids,TRANSFORM(RECORDOF(__in.Dataset_BIPV2_Build__kfetch_contact_linkids),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((UNSIGNED)contact_did > 0 AND (UNSIGNED)seleid<>0);
  SHARED __d0_Legal__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d0_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d0_Legal__Mapped := IF(__d0_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d0_KELfiltered,TRANSFORM(__d0_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_KELfiltered,__d0_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d0_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Last_Name__Layout := RECORD
    RECORDOF(__d0_Legal__Mapped);
    KEL.typ.uid Last_Name_;
  END;
  SHARED __d0_Missing_Last_Name__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Legal__Mapped,'contact_name.lname','__in');
  SHARED __d0_Last_Name__Mapped := IF(__d0_Missing_Last_Name__UIDComponents = 'contact_name.lname',PROJECT(__d0_Legal__Mapped,TRANSFORM(__d0_Last_Name__Layout,SELF.Last_Name_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Legal__Mapped,__d0_Missing_Last_Name__UIDComponents),E_Surname(__in,__cfg).Lookup,TRIM((STRING)LEFT.contact_name.lname) = RIGHT.KeyVal,TRANSFORM(__d0_Last_Name__Layout,SELF.Last_Name_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Prefiltered := __d0_Last_Name__Mapped;
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping0_Transform(LEFT)));
  SHARED Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'Legal_(DEFAULT:Legal_:0),contact_did(OVERRIDE:Contact_:0),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),jobtitle(DEFAULT:Job_Title_:\'\'),contactstatus(DEFAULT:Contact_Status_:\'\'),contactfirstname(DEFAULT:Contact_First_Name_:\'\'),contactmiddlename(DEFAULT:Contact_Middle_Name_:\'\'),Last_Name_(DEFAULT:Last_Name_:0),contactlastname(DEFAULT:Contact_Last_Name_:\'\'),contactnamesuffix(DEFAULT:Contact_Name_Suffix_:\'\'),contactssn(DEFAULT:Contact_S_S_N_:0),contactphonenumber(DEFAULT:Contact_Phone_Number_:0),contactscore(DEFAULT:Contact_Score_:0),contacttype(DEFAULT:Contact_Type_:\'\'),contactemail(DEFAULT:Contact_Email_:\'\'),contactemailusername(DEFAULT:Contact_Email_Username_:\'\'),contactemaildomain(DEFAULT:Contact_Email_Domain_:\'\'),isexecutive(DEFAULT:Is_Executive_),executiveorder(DEFAULT:Executive_Order_:0),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen_contact(OVERRIDE:Date_First_Seen_:EPOCH:Date_First_Seen_1Rule),dt_last_seen_contact(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_BIPV2_Build__kfetch_contact_linkids_slim,TRANSFORM(RECORDOF(__in.Dataset_BIPV2_Build__kfetch_contact_linkids_slim),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((UNSIGNED)contact_did > 0 AND (UNSIGNED)seleid<>0);
  SHARED __d1_Legal__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid Legal_;
  END;
  SHARED __d1_Missing_Legal__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_KELfiltered,'ultid,orgid,seleid','__in');
  SHARED __d1_Legal__Mapped := IF(__d1_Missing_Legal__UIDComponents = 'ultid,orgid,seleid',PROJECT(__d1_KELfiltered,TRANSFORM(__d1_Legal__Layout,SELF.Legal_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_KELfiltered,__d1_Missing_Legal__UIDComponents),E_Business_Sele(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d1_Legal__Layout,SELF.Legal_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d1_Last_Name__Layout := RECORD
    RECORDOF(__d1_Legal__Mapped);
    KEL.typ.uid Last_Name_;
  END;
  SHARED __d1_Missing_Last_Name__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_Legal__Mapped,'LastName','__in');
  SHARED __d1_Last_Name__Mapped := IF(__d1_Missing_Last_Name__UIDComponents = 'LastName',PROJECT(__d1_Legal__Mapped,TRANSFORM(__d1_Last_Name__Layout,SELF.Last_Name_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_Legal__Mapped,__d1_Missing_Last_Name__UIDComponents),E_Surname(__in,__cfg).Lookup,TRIM((STRING)LEFT.LastName) = RIGHT.KeyVal,TRANSFORM(__d1_Last_Name__Layout,SELF.Last_Name_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d1_Prefiltered := __d1_Last_Name__Mapped;
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping1_Transform(LEFT)));
  EXPORT InData := __d0 + __d1;
  EXPORT Contact_Info_Layout := RECORD
    KEL.typ.nstr Job_Title_;
    KEL.typ.nstr Contact_Status_;
    KEL.typ.nstr Contact_First_Name_;
    KEL.typ.nstr Contact_Middle_Name_;
    KEL.typ.nstr Contact_Last_Name_;
    KEL.typ.ntyp(E_Surname().Typ) Last_Name_;
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
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(Contact_Info_Layout) Contact_Info_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Legal_,Contact_,Ult_I_D_,Org_I_D_,Sele_I_D_,ALL));
  Sele_Person_Group := __PostFilter;
  Layout Sele_Person__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Contact_Info_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Job_Title_,Contact_Status_,Contact_First_Name_,Contact_Middle_Name_,Contact_Last_Name_,Last_Name_,Contact_Name_Suffix_,Contact_S_S_N_,Contact_Phone_Number_,Contact_Score_,Contact_Type_,Is_Executive_,Executive_Order_,Contact_Email_,Contact_Email_Username_,Contact_Email_Domain_,Header_Hit_Flag_,Source_},Job_Title_,Contact_Status_,Contact_First_Name_,Contact_Middle_Name_,Contact_Last_Name_,Last_Name_,Contact_Name_Suffix_,Contact_S_S_N_,Contact_Phone_Number_,Contact_Score_,Contact_Type_,Is_Executive_,Executive_Order_,Contact_Email_,Contact_Email_Username_,Contact_Email_Domain_,Header_Hit_Flag_,Source_),Contact_Info_Layout)(__NN(Job_Title_) OR __NN(Contact_Status_) OR __NN(Contact_First_Name_) OR __NN(Contact_Middle_Name_) OR __NN(Contact_Last_Name_) OR __NN(Last_Name_) OR __NN(Contact_Name_Suffix_) OR __NN(Contact_S_S_N_) OR __NN(Contact_Phone_Number_) OR __NN(Contact_Score_) OR __NN(Contact_Type_) OR __NN(Is_Executive_) OR __NN(Executive_Order_) OR __NN(Contact_Email_) OR __NN(Contact_Email_Username_) OR __NN(Contact_Email_Domain_) OR __NN(Header_Hit_Flag_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Header_Hit_Flag_,Source_},Header_Hit_Flag_,Source_),Data_Sources_Layout)(__NN(Header_Hit_Flag_) OR __NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Sele_Person__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Contact_Info_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Contact_Info_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Job_Title_) OR __NN(Contact_Status_) OR __NN(Contact_First_Name_) OR __NN(Contact_Middle_Name_) OR __NN(Contact_Last_Name_) OR __NN(Last_Name_) OR __NN(Contact_Name_Suffix_) OR __NN(Contact_S_S_N_) OR __NN(Contact_Phone_Number_) OR __NN(Contact_Score_) OR __NN(Contact_Type_) OR __NN(Is_Executive_) OR __NN(Executive_Order_) OR __NN(Contact_Email_) OR __NN(Contact_Email_Username_) OR __NN(Contact_Email_Domain_) OR __NN(Header_Hit_Flag_) OR __NN(Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Header_Hit_Flag_) OR __NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Sele_Person_Group,COUNT(ROWS(LEFT))=1),GROUP,Sele_Person__Single_Rollup(LEFT)) + ROLLUP(HAVING(Sele_Person_Group,COUNT(ROWS(LEFT))>1),GROUP,Sele_Person__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Legal__Orphan := JOIN(InData(__NN(Legal_)),E_Business_Sele(__in,__cfg).__Result,__EEQP(LEFT.Legal_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Contact__Orphan := JOIN(InData(__NN(Contact_)),E_Person(__in,__cfg).__Result,__EEQP(LEFT.Contact_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Last_Name__Orphan := JOIN(InData(__NN(Last_Name_)),E_Surname(__in,__cfg).__Result,__EEQP(LEFT.Last_Name_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Legal__Orphan),COUNT(Contact__Orphan),COUNT(Last_Name__Orphan)}],{KEL.typ.int Legal__Orphan,KEL.typ.int Contact__Orphan,KEL.typ.int Last_Name__Orphan});
  EXPORT NullCounts := DATASET([
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d0(__NL(Legal_))),COUNT(__d0(__NN(Legal_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_did',COUNT(__d0(__NL(Contact_))),COUNT(__d0(__NN(Contact_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d0(__NL(Ult_I_D_))),COUNT(__d0(__NN(Ult_I_D_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d0(__NL(Org_I_D_))),COUNT(__d0(__NN(Org_I_D_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d0(__NL(Sele_I_D_))),COUNT(__d0(__NN(Sele_I_D_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','JobTitle',COUNT(__d0(__NL(Job_Title_))),COUNT(__d0(__NN(Job_Title_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Status',COUNT(__d0(__NL(Contact_Status_))),COUNT(__d0(__NN(Contact_Status_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_name.fname',COUNT(__d0(__NL(Contact_First_Name_))),COUNT(__d0(__NN(Contact_First_Name_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_name.mname',COUNT(__d0(__NL(Contact_Middle_Name_))),COUNT(__d0(__NN(Contact_Middle_Name_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LastName',COUNT(__d0(__NL(Last_Name_))),COUNT(__d0(__NN(Last_Name_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_name.lname',COUNT(__d0(__NL(Contact_Last_Name_))),COUNT(__d0(__NN(Contact_Last_Name_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_name.name_suffix',COUNT(__d0(__NL(Contact_Name_Suffix_))),COUNT(__d0(__NN(Contact_Name_Suffix_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_ssn',COUNT(__d0(__NL(Contact_S_S_N_))),COUNT(__d0(__NN(Contact_S_S_N_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_phone',COUNT(__d0(__NL(Contact_Phone_Number_))),COUNT(__d0(__NN(Contact_Phone_Number_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_score',COUNT(__d0(__NL(Contact_Score_))),COUNT(__d0(__NN(Contact_Score_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_type_derived',COUNT(__d0(__NL(Contact_Type_))),COUNT(__d0(__NN(Contact_Type_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_email',COUNT(__d0(__NL(Contact_Email_))),COUNT(__d0(__NN(Contact_Email_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_email_username',COUNT(__d0(__NL(Contact_Email_Username_))),COUNT(__d0(__NN(Contact_Email_Username_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_email_domain',COUNT(__d0(__NL(Contact_Email_Domain_))),COUNT(__d0(__NN(Contact_Email_Domain_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','executive_ind',COUNT(__d0(__NL(Is_Executive_))),COUNT(__d0(__NN(Is_Executive_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','executive_ind_order',COUNT(__d0(__NL(Executive_Order_))),COUNT(__d0(__NN(Executive_Order_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Legal',COUNT(__d1(__NL(Legal_))),COUNT(__d1(__NN(Legal_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','contact_did',COUNT(__d1(__NL(Contact_))),COUNT(__d1(__NN(Contact_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d1(__NL(Ult_I_D_))),COUNT(__d1(__NN(Ult_I_D_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d1(__NL(Org_I_D_))),COUNT(__d1(__NN(Org_I_D_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d1(__NL(Sele_I_D_))),COUNT(__d1(__NN(Sele_I_D_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','JobTitle',COUNT(__d1(__NL(Job_Title_))),COUNT(__d1(__NN(Job_Title_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactStatus',COUNT(__d1(__NL(Contact_Status_))),COUNT(__d1(__NN(Contact_Status_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactFirstName',COUNT(__d1(__NL(Contact_First_Name_))),COUNT(__d1(__NN(Contact_First_Name_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactMiddleName',COUNT(__d1(__NL(Contact_Middle_Name_))),COUNT(__d1(__NN(Contact_Middle_Name_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LastName',COUNT(__d1(__NL(Last_Name_))),COUNT(__d1(__NN(Last_Name_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactLastName',COUNT(__d1(__NL(Contact_Last_Name_))),COUNT(__d1(__NN(Contact_Last_Name_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactNameSuffix',COUNT(__d1(__NL(Contact_Name_Suffix_))),COUNT(__d1(__NN(Contact_Name_Suffix_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactSSN',COUNT(__d1(__NL(Contact_S_S_N_))),COUNT(__d1(__NN(Contact_S_S_N_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactPhoneNumber',COUNT(__d1(__NL(Contact_Phone_Number_))),COUNT(__d1(__NN(Contact_Phone_Number_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactScore',COUNT(__d1(__NL(Contact_Score_))),COUNT(__d1(__NN(Contact_Score_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactType',COUNT(__d1(__NL(Contact_Type_))),COUNT(__d1(__NN(Contact_Type_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmail',COUNT(__d1(__NL(Contact_Email_))),COUNT(__d1(__NN(Contact_Email_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailUsername',COUNT(__d1(__NL(Contact_Email_Username_))),COUNT(__d1(__NN(Contact_Email_Username_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ContactEmailDomain',COUNT(__d1(__NL(Contact_Email_Domain_))),COUNT(__d1(__NN(Contact_Email_Domain_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IsExecutive',COUNT(__d1(__NL(Is_Executive_))),COUNT(__d1(__NN(Is_Executive_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExecutiveOrder',COUNT(__d1(__NL(Executive_Order_))),COUNT(__d1(__NN(Executive_Order_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'SelePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
