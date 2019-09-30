//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_Email(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nint Email_Rec_Key_;
    KEL.typ.nstr User_Name_;
    KEL.typ.nstr Domain_Name_;
    KEL.typ.nstr Domain_Type_;
    KEL.typ.nstr Domain_Root_;
    KEL.typ.nstr Domain_Extension_;
    KEL.typ.nint Is_Top_Level_Domain_State_;
    KEL.typ.nint Is_Top_Level_Domain_Generic_;
    KEL.typ.nint Is_Top_Level_Domain_Country_;
    KEL.typ.nint Is_Valid_Domain_Extension_;
    KEL.typ.nkdate Orig_Login_Date_;
    KEL.typ.nstr Orig_Site_;
    KEL.typ.nstr E360_I_D_;
    KEL.typ.nstr Teramedia_I_D_;
    KEL.typ.nkdate Process_Date_;
    KEL.typ.nstr Active_Code_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Company_Name_;
    KEL.typ.nstr Company_Title_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(DEFAULT:UID),emailaddress(DEFAULT:Email_Address_:\'\'),emailreckey(DEFAULT:Email_Rec_Key_:0),username(DEFAULT:User_Name_:\'\'),domainname(DEFAULT:Domain_Name_:\'\'),domaintype(DEFAULT:Domain_Type_:\'\'),domainroot(DEFAULT:Domain_Root_:\'\'),domainextension(DEFAULT:Domain_Extension_:\'\'),istopleveldomainstate(DEFAULT:Is_Top_Level_Domain_State_:0),istopleveldomaingeneric(DEFAULT:Is_Top_Level_Domain_Generic_:0),istopleveldomaincountry(DEFAULT:Is_Top_Level_Domain_Country_:0),isvaliddomainextension(DEFAULT:Is_Valid_Domain_Extension_:0),origlogindate(DEFAULT:Orig_Login_Date_:DATE),origsite(DEFAULT:Orig_Site_:\'\'),e360id(DEFAULT:E360_I_D_:\'\'),teramediaid(DEFAULT:Teramedia_I_D_:\'\'),processdate(DEFAULT:Process_Date_:DATE),activecode(DEFAULT:Active_Code_:\'\'),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:DATE),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:DATE),companyname(DEFAULT:Company_Name_:\'\'),companytitle(DEFAULT:Company_Title_:\'\'),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in.Dataset_DX_Email__Key_Email_Payload,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.clean_email)));
  EXPORT __All_Trim := __d0_Trim;
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
  SHARED __Mapping0 := 'UID(DEFAULT:UID),clean_email(OVERRIDE:Email_Address_:\'\'),email_rec_key(OVERRIDE:Email_Rec_Key_:0),append_email_username(OVERRIDE:User_Name_:\'\'),append_domain(OVERRIDE:Domain_Name_:\'\'),append_domain_type(OVERRIDE:Domain_Type_:\'\'),append_domain_root(OVERRIDE:Domain_Root_:\'\'),append_domain_ext(OVERRIDE:Domain_Extension_:\'\'),append_is_tld_state(OVERRIDE:Is_Top_Level_Domain_State_:0),append_is_tld_generic(OVERRIDE:Is_Top_Level_Domain_Generic_:0),append_is_tld_country(OVERRIDE:Is_Top_Level_Domain_Country_:0),append_is_valid_domain_ext(OVERRIDE:Is_Valid_Domain_Extension_:0),orig_login_date(OVERRIDE:Orig_Login_Date_:DATE),orig_site(OVERRIDE:Orig_Site_:\'\'),orig_e360_id(OVERRIDE:E360_I_D_:\'\'),orig_teramedia_id(OVERRIDE:Teramedia_I_D_:\'\'),process_date(OVERRIDE:Process_Date_:DATE),activecode(OVERRIDE:Active_Code_:\'\'),date_vendor_first_reported(OVERRIDE:Date_Vendor_First_Reported_:DATE),date_vendor_last_reported(OVERRIDE:Date_Vendor_Last_Reported_:DATE),cln_companyname(OVERRIDE:Company_Name_:\'\'),companytitle(OVERRIDE:Company_Title_:\'\'),email_src(OVERRIDE:Source_:\'\'),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),DPMBitmap(DEFAULT:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_DX_Email__Key_Email_Payload,TRANSFORM(RECORDOF(__in.Dataset_DX_Email__Key_Email_Payload),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_DX_Email__Key_Email_Payload);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_Norm,Lookup,TRIM((STRING)LEFT.clean_email) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DX_Email__Key_Email_Payload_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nint Email_Rec_Key_;
    KEL.typ.nstr User_Name_;
    KEL.typ.nstr Domain_Name_;
    KEL.typ.nstr Domain_Type_;
    KEL.typ.nstr Domain_Root_;
    KEL.typ.nstr Domain_Extension_;
    KEL.typ.nint Is_Top_Level_Domain_State_;
    KEL.typ.nint Is_Top_Level_Domain_Generic_;
    KEL.typ.nint Is_Top_Level_Domain_Country_;
    KEL.typ.nint Is_Valid_Domain_Extension_;
    KEL.typ.nkdate Orig_Login_Date_;
    KEL.typ.nstr Orig_Site_;
    KEL.typ.nstr E360_I_D_;
    KEL.typ.nstr Teramedia_I_D_;
    KEL.typ.nkdate Process_Date_;
    KEL.typ.nstr Active_Code_;
    KEL.typ.nkdate Date_Vendor_First_Reported_;
    KEL.typ.nkdate Date_Vendor_Last_Reported_;
    KEL.typ.nstr Company_Name_;
    KEL.typ.nstr Company_Title_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Email_Group := __PostFilter;
  Layout Email__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Email_Address_ := KEL.Intake.SingleValue(__recs,Email_Address_);
    SELF.Email_Rec_Key_ := KEL.Intake.SingleValue(__recs,Email_Rec_Key_);
    SELF.User_Name_ := KEL.Intake.SingleValue(__recs,User_Name_);
    SELF.Domain_Name_ := KEL.Intake.SingleValue(__recs,Domain_Name_);
    SELF.Domain_Type_ := KEL.Intake.SingleValue(__recs,Domain_Type_);
    SELF.Domain_Root_ := KEL.Intake.SingleValue(__recs,Domain_Root_);
    SELF.Domain_Extension_ := KEL.Intake.SingleValue(__recs,Domain_Extension_);
    SELF.Is_Top_Level_Domain_State_ := KEL.Intake.SingleValue(__recs,Is_Top_Level_Domain_State_);
    SELF.Is_Top_Level_Domain_Generic_ := KEL.Intake.SingleValue(__recs,Is_Top_Level_Domain_Generic_);
    SELF.Is_Top_Level_Domain_Country_ := KEL.Intake.SingleValue(__recs,Is_Top_Level_Domain_Country_);
    SELF.Is_Valid_Domain_Extension_ := KEL.Intake.SingleValue(__recs,Is_Valid_Domain_Extension_);
    SELF.Orig_Login_Date_ := KEL.Intake.SingleValue(__recs,Orig_Login_Date_);
    SELF.Orig_Site_ := KEL.Intake.SingleValue(__recs,Orig_Site_);
    SELF.E360_I_D_ := KEL.Intake.SingleValue(__recs,E360_I_D_);
    SELF.Teramedia_I_D_ := KEL.Intake.SingleValue(__recs,Teramedia_I_D_);
    SELF.Process_Date_ := KEL.Intake.SingleValue(__recs,Process_Date_);
    SELF.Active_Code_ := KEL.Intake.SingleValue(__recs,Active_Code_);
    SELF.Date_Vendor_First_Reported_ := KEL.Intake.SingleValue(__recs,Date_Vendor_First_Reported_);
    SELF.Date_Vendor_Last_Reported_ := KEL.Intake.SingleValue(__recs,Date_Vendor_Last_Reported_);
    SELF.Company_Name_ := KEL.Intake.SingleValue(__recs,Company_Name_);
    SELF.Company_Title_ := KEL.Intake.SingleValue(__recs,Company_Title_);
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Email__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Email_Group,COUNT(ROWS(LEFT))=1),GROUP,Email__Single_Rollup(LEFT)) + ROLLUP(HAVING(Email_Group,COUNT(ROWS(LEFT))>1),GROUP,Email__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Email_Address__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Email_Address_);
  EXPORT Email_Rec_Key__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Email_Rec_Key_);
  EXPORT User_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,User_Name_);
  EXPORT Domain_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Domain_Name_);
  EXPORT Domain_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Domain_Type_);
  EXPORT Domain_Root__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Domain_Root_);
  EXPORT Domain_Extension__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Domain_Extension_);
  EXPORT Is_Top_Level_Domain_State__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Is_Top_Level_Domain_State_);
  EXPORT Is_Top_Level_Domain_Generic__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Is_Top_Level_Domain_Generic_);
  EXPORT Is_Top_Level_Domain_Country__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Is_Top_Level_Domain_Country_);
  EXPORT Is_Valid_Domain_Extension__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Is_Valid_Domain_Extension_);
  EXPORT Orig_Login_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Orig_Login_Date_);
  EXPORT Orig_Site__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Orig_Site_);
  EXPORT E360_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,E360_I_D_);
  EXPORT Teramedia_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Teramedia_I_D_);
  EXPORT Process_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Process_Date_);
  EXPORT Active_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Active_Code_);
  EXPORT Date_Vendor_First_Reported__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Date_Vendor_First_Reported_);
  EXPORT Date_Vendor_Last_Reported__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Date_Vendor_Last_Reported_);
  EXPORT Company_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Company_Name_);
  EXPORT Company_Title__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Company_Title_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DX_Email__Key_Email_Payload_Invalid),COUNT(Email_Address__SingleValue_Invalid),COUNT(Email_Rec_Key__SingleValue_Invalid),COUNT(User_Name__SingleValue_Invalid),COUNT(Domain_Name__SingleValue_Invalid),COUNT(Domain_Type__SingleValue_Invalid),COUNT(Domain_Root__SingleValue_Invalid),COUNT(Domain_Extension__SingleValue_Invalid),COUNT(Is_Top_Level_Domain_State__SingleValue_Invalid),COUNT(Is_Top_Level_Domain_Generic__SingleValue_Invalid),COUNT(Is_Top_Level_Domain_Country__SingleValue_Invalid),COUNT(Is_Valid_Domain_Extension__SingleValue_Invalid),COUNT(Orig_Login_Date__SingleValue_Invalid),COUNT(Orig_Site__SingleValue_Invalid),COUNT(E360_I_D__SingleValue_Invalid),COUNT(Teramedia_I_D__SingleValue_Invalid),COUNT(Process_Date__SingleValue_Invalid),COUNT(Active_Code__SingleValue_Invalid),COUNT(Date_Vendor_First_Reported__SingleValue_Invalid),COUNT(Date_Vendor_Last_Reported__SingleValue_Invalid),COUNT(Company_Name__SingleValue_Invalid),COUNT(Company_Title__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DX_Email__Key_Email_Payload_Invalid,KEL.typ.int Email_Address__SingleValue_Invalid,KEL.typ.int Email_Rec_Key__SingleValue_Invalid,KEL.typ.int User_Name__SingleValue_Invalid,KEL.typ.int Domain_Name__SingleValue_Invalid,KEL.typ.int Domain_Type__SingleValue_Invalid,KEL.typ.int Domain_Root__SingleValue_Invalid,KEL.typ.int Domain_Extension__SingleValue_Invalid,KEL.typ.int Is_Top_Level_Domain_State__SingleValue_Invalid,KEL.typ.int Is_Top_Level_Domain_Generic__SingleValue_Invalid,KEL.typ.int Is_Top_Level_Domain_Country__SingleValue_Invalid,KEL.typ.int Is_Valid_Domain_Extension__SingleValue_Invalid,KEL.typ.int Orig_Login_Date__SingleValue_Invalid,KEL.typ.int Orig_Site__SingleValue_Invalid,KEL.typ.int E360_I_D__SingleValue_Invalid,KEL.typ.int Teramedia_I_D__SingleValue_Invalid,KEL.typ.int Process_Date__SingleValue_Invalid,KEL.typ.int Active_Code__SingleValue_Invalid,KEL.typ.int Date_Vendor_First_Reported__SingleValue_Invalid,KEL.typ.int Date_Vendor_Last_Reported__SingleValue_Invalid,KEL.typ.int Company_Name__SingleValue_Invalid,KEL.typ.int Company_Title__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_DX_Email__Key_Email_Payload_Invalid),COUNT(__d0)},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_email',COUNT(__d0(__NL(Email_Address_))),COUNT(__d0(__NN(Email_Address_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','email_rec_key',COUNT(__d0(__NL(Email_Rec_Key_))),COUNT(__d0(__NN(Email_Rec_Key_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_email_username',COUNT(__d0(__NL(User_Name_))),COUNT(__d0(__NN(User_Name_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_domain',COUNT(__d0(__NL(Domain_Name_))),COUNT(__d0(__NN(Domain_Name_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_domain_type',COUNT(__d0(__NL(Domain_Type_))),COUNT(__d0(__NN(Domain_Type_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_domain_root',COUNT(__d0(__NL(Domain_Root_))),COUNT(__d0(__NN(Domain_Root_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_domain_ext',COUNT(__d0(__NL(Domain_Extension_))),COUNT(__d0(__NN(Domain_Extension_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_is_tld_state',COUNT(__d0(__NL(Is_Top_Level_Domain_State_))),COUNT(__d0(__NN(Is_Top_Level_Domain_State_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_is_tld_generic',COUNT(__d0(__NL(Is_Top_Level_Domain_Generic_))),COUNT(__d0(__NN(Is_Top_Level_Domain_Generic_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_is_tld_country',COUNT(__d0(__NL(Is_Top_Level_Domain_Country_))),COUNT(__d0(__NN(Is_Top_Level_Domain_Country_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_is_valid_domain_ext',COUNT(__d0(__NL(Is_Valid_Domain_Extension_))),COUNT(__d0(__NN(Is_Valid_Domain_Extension_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_login_date',COUNT(__d0(__NL(Orig_Login_Date_))),COUNT(__d0(__NN(Orig_Login_Date_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_site',COUNT(__d0(__NL(Orig_Site_))),COUNT(__d0(__NN(Orig_Site_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_e360_id',COUNT(__d0(__NL(E360_I_D_))),COUNT(__d0(__NN(E360_I_D_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_teramedia_id',COUNT(__d0(__NL(Teramedia_I_D_))),COUNT(__d0(__NN(Teramedia_I_D_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','process_date',COUNT(__d0(__NL(Process_Date_))),COUNT(__d0(__NN(Process_Date_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','activecode',COUNT(__d0(__NL(Active_Code_))),COUNT(__d0(__NN(Active_Code_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_vendor_first_reported',COUNT(__d0(__NL(Date_Vendor_First_Reported_))),COUNT(__d0(__NN(Date_Vendor_First_Reported_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_vendor_last_reported',COUNT(__d0(__NL(Date_Vendor_Last_Reported_))),COUNT(__d0(__NN(Date_Vendor_Last_Reported_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cln_companyname',COUNT(__d0(__NL(Company_Name_))),COUNT(__d0(__NN(Company_Name_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','companytitle',COUNT(__d0(__NL(Company_Title_))),COUNT(__d0(__NN(Company_Title_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Email_Src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
