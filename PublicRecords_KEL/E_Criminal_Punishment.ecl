//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_Criminal_Punishment(CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Offender_Key_;
    KEL.typ.nstr Source_File_;
    KEL.typ.nstr Punishment_Type_;
    KEL.typ.nstr Source_State_;
    KEL.typ.nstr Punishment_Persistent_I_D_;
    KEL.typ.nkdate Date_Of_Sentence_;
    KEL.typ.nint Sentence_Length_;
    KEL.typ.nstr Sentence_Length_Description_;
    KEL.typ.nstr Sentence_Description_;
    KEL.typ.nstr Sentence_Type_;
    KEL.typ.nstr Sentence_County_;
    KEL.typ.nstr Current_Known_Inmate_Status_;
    KEL.typ.nstr Current_Location_Of_Inmate_;
    KEL.typ.nstr Current_Location_Security_;
    KEL.typ.nkdate Incarceration_Admission_Date_;
    KEL.typ.nint Minimum_Term_;
    KEL.typ.nstr Minimum_Term_Description_;
    KEL.typ.nint Maximum_Term_;
    KEL.typ.nstr Maximum_Term_Description_;
    KEL.typ.nkdate Scheduled_Release_Date_;
    KEL.typ.nkdate Actual_Release_Date_;
    KEL.typ.nkdate Control_Release_Date_;
    KEL.typ.nkdate Presumptive_Parole_Release_Date_;
    KEL.typ.nint Parole_Current_Status_;
    KEL.typ.nstr Parole_Current_Status_Description_;
    KEL.typ.nkdate Parole_Start_Date_;
    KEL.typ.nkdate Parole_Scheduled_Release_Date_;
    KEL.typ.nkdate Parole_Actual_Release_Date_;
    KEL.typ.nstr Parole_County_;
    KEL.typ.nkdate Probation_Start_Date_;
    KEL.typ.nkdate Probation_End_Date_;
    KEL.typ.nstr Probation_Status_;
    KEL.typ.nstr Probation_Time_Period_;
    KEL.typ.nstr Additional_Provision1_;
    KEL.typ.nstr Additional_Provision2_;
    KEL.typ.nstr Probation_Description_;
    KEL.typ.nstr Additional_Sentence_Dates_;
    KEL.typ.nstr Current_Status_;
    KEL.typ.nstr Consecutive_And_Concurrent_Information_;
    KEL.typ.nstr Instituiton_Name_;
    KEL.typ.nfloat Restitution_;
    KEL.typ.nstr Community_Service_;
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
  SHARED __Mapping := 'UID(DEFAULT:UID),offenderkey(DEFAULT:Offender_Key_:\'\'),sourcefile(DEFAULT:Source_File_:\'\'),punishmenttype(DEFAULT:Punishment_Type_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),punishmentpersistentid(DEFAULT:Punishment_Persistent_I_D_:\'\'),dateofsentence(DEFAULT:Date_Of_Sentence_:DATE),sentencelength(DEFAULT:Sentence_Length_:0),sentencelengthdescription(DEFAULT:Sentence_Length_Description_:\'\'),sentencedescription(DEFAULT:Sentence_Description_:\'\'),sentencetype(DEFAULT:Sentence_Type_:\'\'),sentencecounty(DEFAULT:Sentence_County_:\'\'),currentknowninmatestatus(DEFAULT:Current_Known_Inmate_Status_:\'\'),currentlocationofinmate(DEFAULT:Current_Location_Of_Inmate_:\'\'),currentlocationsecurity(DEFAULT:Current_Location_Security_:\'\'),incarcerationadmissiondate(DEFAULT:Incarceration_Admission_Date_:DATE),minimumterm(DEFAULT:Minimum_Term_:0),minimumtermdescription(DEFAULT:Minimum_Term_Description_:\'\'),maximumterm(DEFAULT:Maximum_Term_:0),maximumtermdescription(DEFAULT:Maximum_Term_Description_:\'\'),scheduledreleasedate(DEFAULT:Scheduled_Release_Date_:DATE),actualreleasedate(DEFAULT:Actual_Release_Date_:DATE),controlreleasedate(DEFAULT:Control_Release_Date_:DATE),presumptiveparolereleasedate(DEFAULT:Presumptive_Parole_Release_Date_:DATE),parolecurrentstatus(DEFAULT:Parole_Current_Status_:0),parolecurrentstatusdescription(DEFAULT:Parole_Current_Status_Description_:\'\'),parolestartdate(DEFAULT:Parole_Start_Date_:DATE),parolescheduledreleasedate(DEFAULT:Parole_Scheduled_Release_Date_:DATE),paroleactualreleasedate(DEFAULT:Parole_Actual_Release_Date_:DATE),parolecounty(DEFAULT:Parole_County_:\'\'),probationstartdate(DEFAULT:Probation_Start_Date_:DATE),probationenddate(DEFAULT:Probation_End_Date_:DATE),probationstatus(DEFAULT:Probation_Status_:\'\'),probationtimeperiod(DEFAULT:Probation_Time_Period_:\'\'),additionalprovision1(DEFAULT:Additional_Provision1_:\'\'),additionalprovision2(DEFAULT:Additional_Provision2_:\'\'),probationdescription(DEFAULT:Probation_Description_:\'\'),additionalsentencedates(DEFAULT:Additional_Sentence_Dates_:\'\'),currentstatus(DEFAULT:Current_Status_:\'\'),consecutiveandconcurrentinformation(DEFAULT:Consecutive_And_Concurrent_Information_:\'\'),instituitonname(DEFAULT:Instituiton_Name_:\'\'),restitution(DEFAULT:Restitution_:0.0),communityservice(DEFAULT:Community_Service_:\'\'),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.offender_key)));
  SHARED __d1_Trim := PROJECT(PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.offender_key)));
  SHARED __d2_Trim := PROJECT(PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.offender_key)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim + __d2_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::PublicRecords_KEL::Criminal_Punishment::UidLookup',EXPIRE(7));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::PublicRecords_KEL::Criminal_Punishment');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::PublicRecords_KEL::Criminal_Punishment');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED Hybrid_Archive_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'UID(DEFAULT:UID),offender_key(OVERRIDE:Offender_Key_:\'\'),source_file(OVERRIDE:Source_File_:\'\'),punishment_type(OVERRIDE:Punishment_Type_:\'\'),orig_state(OVERRIDE:Source_State_:\'\'),punishment_persistent_id(OVERRIDE:Punishment_Persistent_I_D_:\'\'),sent_date(OVERRIDE:Date_Of_Sentence_:DATE),sent_length(OVERRIDE:Sentence_Length_:0),sent_length_desc(OVERRIDE:Sentence_Length_Description_:\'\'),sentencedescription(DEFAULT:Sentence_Description_:\'\'),sentencetype(DEFAULT:Sentence_Type_:\'\'),sentencecounty(DEFAULT:Sentence_County_:\'\'),cur_stat_inm_desc(OVERRIDE:Current_Known_Inmate_Status_:\'\'),cur_loc_inm(OVERRIDE:Current_Location_Of_Inmate_:\'\'),cur_loc_sec(OVERRIDE:Current_Location_Security_:\'\'),latest_adm_dt(OVERRIDE:Incarceration_Admission_Date_:DATE),minimumterm(DEFAULT:Minimum_Term_:0),minimumtermdescription(DEFAULT:Minimum_Term_Description_:\'\'),maximumterm(DEFAULT:Maximum_Term_:0),maximumtermdescription(DEFAULT:Maximum_Term_Description_:\'\'),sch_rel_dt(OVERRIDE:Scheduled_Release_Date_:DATE),act_rel_dt(OVERRIDE:Actual_Release_Date_:DATE),ctl_rel_dt(OVERRIDE:Control_Release_Date_:DATE),presump_par_rel_dt(OVERRIDE:Presumptive_Parole_Release_Date_:DATE),par_cur_stat(OVERRIDE:Parole_Current_Status_:0),par_cur_stat_desc(OVERRIDE:Parole_Current_Status_Description_:\'\'),par_st_dt(OVERRIDE:Parole_Start_Date_:DATE),par_sch_end_dt(OVERRIDE:Parole_Scheduled_Release_Date_:DATE),par_act_end_dt(OVERRIDE:Parole_Actual_Release_Date_:DATE),par_cty(OVERRIDE:Parole_County_:\'\'),probationstartdate(DEFAULT:Probation_Start_Date_:DATE),probationenddate(DEFAULT:Probation_End_Date_:DATE),probationstatus(DEFAULT:Probation_Status_:\'\'),probationtimeperiod(DEFAULT:Probation_Time_Period_:\'\'),additionalprovision1(DEFAULT:Additional_Provision1_:\'\'),additionalprovision2(DEFAULT:Additional_Provision2_:\'\'),probationdescription(DEFAULT:Probation_Description_:\'\'),additionalsentencedates(DEFAULT:Additional_Sentence_Dates_:\'\'),currentstatus(DEFAULT:Current_Status_:\'\'),consecutiveandconcurrentinformation(DEFAULT:Consecutive_And_Concurrent_Information_:\'\'),instituitonname(DEFAULT:Instituiton_Name_:\'\'),restitution(DEFAULT:Restitution_:0.0),communityservice(DEFAULT:Community_Service_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),event_dt(OVERRIDE:Date_First_Seen_:EPOCH),process_date(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_0Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault,Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_NonFCRA_Doxie_Files__Key_Punishment_Vault_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault'));
  SHARED __Mapping1 := 'UID(DEFAULT:UID),offender_key(OVERRIDE:Offender_Key_:\'\'),sourcefile(DEFAULT:Source_File_:\'\'),punishmenttype(DEFAULT:Punishment_Type_:\'\'),sourcestate(DEFAULT:Source_State_:\'\'),punishmentpersistentid(DEFAULT:Punishment_Persistent_I_D_:\'\'),sent_date(OVERRIDE:Date_Of_Sentence_:DATE),sentencelength(DEFAULT:Sentence_Length_:0),sent_jail(OVERRIDE:Sentence_Length_Description_:\'\'),sentencedescription(DEFAULT:Sentence_Description_:\'\'),sentencetype(DEFAULT:Sentence_Type_:\'\'),cty_conv(OVERRIDE:Sentence_County_:\'\'),currentknowninmatestatus(DEFAULT:Current_Known_Inmate_Status_:\'\'),currentlocationofinmate(DEFAULT:Current_Location_Of_Inmate_:\'\'),currentlocationsecurity(DEFAULT:Current_Location_Security_:\'\'),incarcerationadmissiondate(DEFAULT:Incarceration_Admission_Date_:DATE),minimumterm(DEFAULT:Minimum_Term_:0),minimumtermdescription(DEFAULT:Minimum_Term_Description_:\'\'),maximumterm(DEFAULT:Maximum_Term_:0),maximumtermdescription(DEFAULT:Maximum_Term_Description_:\'\'),scheduledreleasedate(DEFAULT:Scheduled_Release_Date_:DATE),actualreleasedate(DEFAULT:Actual_Release_Date_:DATE),controlreleasedate(DEFAULT:Control_Release_Date_:DATE),presumptiveparolereleasedate(DEFAULT:Presumptive_Parole_Release_Date_:DATE),parolecurrentstatus(DEFAULT:Parole_Current_Status_:0),parolecurrentstatusdescription(DEFAULT:Parole_Current_Status_Description_:\'\'),parolestartdate(DEFAULT:Parole_Start_Date_:DATE),parolescheduledreleasedate(DEFAULT:Parole_Scheduled_Release_Date_:DATE),paroleactualreleasedate(DEFAULT:Parole_Actual_Release_Date_:DATE),parolecounty(DEFAULT:Parole_County_:\'\'),probationstartdate(DEFAULT:Probation_Start_Date_:DATE),probationenddate(DEFAULT:Probation_End_Date_:DATE),probationstatus(DEFAULT:Probation_Status_:\'\'),sent_probation(OVERRIDE:Probation_Time_Period_:\'\'),sent_addl_prov_desc_1(OVERRIDE:Additional_Provision1_:\'\'),sent_addl_prov_desc_2(OVERRIDE:Additional_Provision2_:\'\'),probation_desc2(OVERRIDE:Probation_Description_:\'\'),addl_sent_dates(OVERRIDE:Additional_Sentence_Dates_:\'\'),sent_susp_time(OVERRIDE:Current_Status_:\'\'),sent_consec(OVERRIDE:Consecutive_And_Concurrent_Information_:\'\'),sent_agency_rec_cust(OVERRIDE:Instituiton_Name_:\'\'),restitution(OVERRIDE:Restitution_:0.0),community_service(OVERRIDE:Community_Service_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault,Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_FCRA_doxie_files__Key_Court_Offenses_Vault_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault'));
  SHARED __Mapping2 := 'UID(DEFAULT:UID),offender_key(OVERRIDE:Offender_Key_:\'\'),source_file(OVERRIDE:Source_File_:\'\'),punishmenttype(DEFAULT:Punishment_Type_:\'\'),orig_state(OVERRIDE:Source_State_:\'\'),punishmentpersistentid(DEFAULT:Punishment_Persistent_I_D_:\'\'),stc_dt(OVERRIDE:Date_Of_Sentence_:DATE),stc_lgth(OVERRIDE:Sentence_Length_:0),stc_lgth_desc(OVERRIDE:Sentence_Length_Description_:\'\'),stc_desc_2(OVERRIDE:Sentence_Description_:\'\'),stc_desc_1(OVERRIDE:Sentence_Type_:\'\'),cty_conv(OVERRIDE:Sentence_County_:\'\'),currentknowninmatestatus(DEFAULT:Current_Known_Inmate_Status_:\'\'),currentlocationofinmate(DEFAULT:Current_Location_Of_Inmate_:\'\'),currentlocationsecurity(DEFAULT:Current_Location_Security_:\'\'),inc_adm_dt(OVERRIDE:Incarceration_Admission_Date_:DATE),min_term(OVERRIDE:Minimum_Term_:0),min_term_desc(OVERRIDE:Minimum_Term_Description_:\'\'),max_term(OVERRIDE:Maximum_Term_:0),max_term_desc(OVERRIDE:Maximum_Term_Description_:\'\'),scheduledreleasedate(DEFAULT:Scheduled_Release_Date_:DATE),actualreleasedate(DEFAULT:Actual_Release_Date_:DATE),controlreleasedate(DEFAULT:Control_Release_Date_:DATE),presumptiveparolereleasedate(DEFAULT:Presumptive_Parole_Release_Date_:DATE),parolecurrentstatus(DEFAULT:Parole_Current_Status_:0),parole(OVERRIDE:Parole_Current_Status_Description_:\'\'),parolestartdate(DEFAULT:Parole_Start_Date_:DATE),parolescheduledreleasedate(DEFAULT:Parole_Scheduled_Release_Date_:DATE),paroleactualreleasedate(DEFAULT:Parole_Actual_Release_Date_:DATE),parolecounty(DEFAULT:Parole_County_:\'\'),probationstartdate(DEFAULT:Probation_Start_Date_:DATE),probationenddate(DEFAULT:Probation_End_Date_:DATE),probationstatus(DEFAULT:Probation_Status_:\'\'),probation(OVERRIDE:Probation_Time_Period_:\'\'),additionalprovision1(DEFAULT:Additional_Provision1_:\'\'),additionalprovision2(DEFAULT:Additional_Provision2_:\'\'),probationdescription(DEFAULT:Probation_Description_:\'\'),additionalsentencedates(DEFAULT:Additional_Sentence_Dates_:\'\'),stc_desc_4(OVERRIDE:Current_Status_:\'\'),consecutiveandconcurrentinformation(DEFAULT:Consecutive_And_Concurrent_Information_:\'\'),instituitonname(DEFAULT:Instituiton_Name_:\'\'),restitution(DEFAULT:Restitution_:0.0),stc_desc_3(OVERRIDE:Community_Service_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d2_UID_Mapped := JOIN(PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault,Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d2_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_FCRA_doxie_files__Key_Offenses_Vault_Invalid := __d2_UID_Mapped(UID = 0);
  SHARED __d2_Prefiltered := __d2_UID_Mapped(UID <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault'));
  EXPORT InData := __d0 + __d1 + __d2;
  EXPORT Sources_Layout := RECORD
    KEL.typ.nstr Source_File_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Reported_Punishment_Persistent_I_Ds_Layout := RECORD
    KEL.typ.nstr Punishment_Persistent_I_D_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Reported_Punishment_Layout := RECORD
    KEL.typ.nint Sentence_Length_;
    KEL.typ.nstr Sentence_Description_;
    KEL.typ.nstr Sentence_Length_Description_;
    KEL.typ.nstr Sentence_Type_;
    KEL.typ.nkdate Date_Of_Sentence_;
    KEL.typ.nkdate Incarceration_Admission_Date_;
    KEL.typ.nkdate Scheduled_Release_Date_;
    KEL.typ.nkdate Actual_Release_Date_;
    KEL.typ.nkdate Control_Release_Date_;
    KEL.typ.nkdate Presumptive_Parole_Release_Date_;
    KEL.typ.nint Parole_Current_Status_;
    KEL.typ.nstr Parole_Current_Status_Description_;
    KEL.typ.nkdate Parole_Start_Date_;
    KEL.typ.nkdate Parole_Scheduled_Release_Date_;
    KEL.typ.nkdate Parole_Actual_Release_Date_;
    KEL.typ.nstr Parole_County_;
    KEL.typ.nkdate Probation_Start_Date_;
    KEL.typ.nkdate Probation_End_Date_;
    KEL.typ.nstr Probation_Status_;
    KEL.typ.nstr Additional_Provision1_;
    KEL.typ.nstr Additional_Provision2_;
    KEL.typ.nstr Additional_Sentence_Dates_;
    KEL.typ.nstr Probation_Description_;
    KEL.typ.nint Minimum_Term_;
    KEL.typ.nstr Minimum_Term_Description_;
    KEL.typ.nint Maximum_Term_;
    KEL.typ.nstr Maximum_Term_Description_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ndataset(Sources_Layout) Sources_;
    KEL.typ.ndataset(Reported_Punishment_Persistent_I_Ds_Layout) Reported_Punishment_Persistent_I_Ds_;
    KEL.typ.ndataset(Reported_Punishment_Layout) Reported_Punishment_;
    KEL.typ.nstr Punishment_Type_;
    KEL.typ.nstr Source_State_;
    KEL.typ.nstr Current_Known_Inmate_Status_;
    KEL.typ.nstr Sentence_County_;
    KEL.typ.nstr Current_Location_Of_Inmate_;
    KEL.typ.nstr Current_Location_Security_;
    KEL.typ.nstr Offender_Key_;
    KEL.typ.nstr Current_Status_;
    KEL.typ.nstr Probation_Time_Period_;
    KEL.typ.nstr Consecutive_And_Concurrent_Information_;
    KEL.typ.nstr Instituiton_Name_;
    KEL.typ.nfloat Restitution_;
    KEL.typ.nstr Community_Service_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Criminal_Punishment_Group := __PostFilter;
  Layout Criminal_Punishment__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_File_},Source_File_),Sources_Layout)(__NN(Source_File_)));
    SELF.Reported_Punishment_Persistent_I_Ds_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Punishment_Persistent_I_D_},Punishment_Persistent_I_D_),Reported_Punishment_Persistent_I_Ds_Layout)(__NN(Punishment_Persistent_I_D_)));
    SELF.Reported_Punishment_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Sentence_Length_,Sentence_Description_,Sentence_Length_Description_,Sentence_Type_,Date_Of_Sentence_,Incarceration_Admission_Date_,Scheduled_Release_Date_,Actual_Release_Date_,Control_Release_Date_,Presumptive_Parole_Release_Date_,Parole_Current_Status_,Parole_Current_Status_Description_,Parole_Start_Date_,Parole_Scheduled_Release_Date_,Parole_Actual_Release_Date_,Parole_County_,Probation_Start_Date_,Probation_End_Date_,Probation_Status_,Additional_Provision1_,Additional_Provision2_,Additional_Sentence_Dates_,Probation_Description_,Minimum_Term_,Minimum_Term_Description_,Maximum_Term_,Maximum_Term_Description_},Sentence_Length_,Sentence_Description_,Sentence_Length_Description_,Sentence_Type_,Date_Of_Sentence_,Incarceration_Admission_Date_,Scheduled_Release_Date_,Actual_Release_Date_,Control_Release_Date_,Presumptive_Parole_Release_Date_,Parole_Current_Status_,Parole_Current_Status_Description_,Parole_Start_Date_,Parole_Scheduled_Release_Date_,Parole_Actual_Release_Date_,Parole_County_,Probation_Start_Date_,Probation_End_Date_,Probation_Status_,Additional_Provision1_,Additional_Provision2_,Additional_Sentence_Dates_,Probation_Description_,Minimum_Term_,Minimum_Term_Description_,Maximum_Term_,Maximum_Term_Description_),Reported_Punishment_Layout)(__NN(Sentence_Length_) OR __NN(Sentence_Description_) OR __NN(Sentence_Length_Description_) OR __NN(Sentence_Type_) OR __NN(Date_Of_Sentence_) OR __NN(Incarceration_Admission_Date_) OR __NN(Scheduled_Release_Date_) OR __NN(Actual_Release_Date_) OR __NN(Control_Release_Date_) OR __NN(Presumptive_Parole_Release_Date_) OR __NN(Parole_Current_Status_) OR __NN(Parole_Current_Status_Description_) OR __NN(Parole_Start_Date_) OR __NN(Parole_Scheduled_Release_Date_) OR __NN(Parole_Actual_Release_Date_) OR __NN(Parole_County_) OR __NN(Probation_Start_Date_) OR __NN(Probation_End_Date_) OR __NN(Probation_Status_) OR __NN(Additional_Provision1_) OR __NN(Additional_Provision2_) OR __NN(Additional_Sentence_Dates_) OR __NN(Probation_Description_) OR __NN(Minimum_Term_) OR __NN(Minimum_Term_Description_) OR __NN(Maximum_Term_) OR __NN(Maximum_Term_Description_)));
    SELF.Punishment_Type_ := KEL.Intake.SingleValue(__recs,Punishment_Type_);
    SELF.Source_State_ := KEL.Intake.SingleValue(__recs,Source_State_);
    SELF.Current_Known_Inmate_Status_ := KEL.Intake.SingleValue(__recs,Current_Known_Inmate_Status_);
    SELF.Sentence_County_ := KEL.Intake.SingleValue(__recs,Sentence_County_);
    SELF.Current_Location_Of_Inmate_ := KEL.Intake.SingleValue(__recs,Current_Location_Of_Inmate_);
    SELF.Current_Location_Security_ := KEL.Intake.SingleValue(__recs,Current_Location_Security_);
    SELF.Offender_Key_ := KEL.Intake.SingleValue(__recs,Offender_Key_);
    SELF.Current_Status_ := KEL.Intake.SingleValue(__recs,Current_Status_);
    SELF.Probation_Time_Period_ := KEL.Intake.SingleValue(__recs,Probation_Time_Period_);
    SELF.Consecutive_And_Concurrent_Information_ := KEL.Intake.SingleValue(__recs,Consecutive_And_Concurrent_Information_);
    SELF.Instituiton_Name_ := KEL.Intake.SingleValue(__recs,Instituiton_Name_);
    SELF.Restitution_ := KEL.Intake.SingleValue(__recs,Restitution_);
    SELF.Community_Service_ := KEL.Intake.SingleValue(__recs,Community_Service_);
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Criminal_Punishment__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_File_)));
    SELF.Reported_Punishment_Persistent_I_Ds_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Reported_Punishment_Persistent_I_Ds_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Punishment_Persistent_I_D_)));
    SELF.Reported_Punishment_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Reported_Punishment_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Sentence_Length_) OR __NN(Sentence_Description_) OR __NN(Sentence_Length_Description_) OR __NN(Sentence_Type_) OR __NN(Date_Of_Sentence_) OR __NN(Incarceration_Admission_Date_) OR __NN(Scheduled_Release_Date_) OR __NN(Actual_Release_Date_) OR __NN(Control_Release_Date_) OR __NN(Presumptive_Parole_Release_Date_) OR __NN(Parole_Current_Status_) OR __NN(Parole_Current_Status_Description_) OR __NN(Parole_Start_Date_) OR __NN(Parole_Scheduled_Release_Date_) OR __NN(Parole_Actual_Release_Date_) OR __NN(Parole_County_) OR __NN(Probation_Start_Date_) OR __NN(Probation_End_Date_) OR __NN(Probation_Status_) OR __NN(Additional_Provision1_) OR __NN(Additional_Provision2_) OR __NN(Additional_Sentence_Dates_) OR __NN(Probation_Description_) OR __NN(Minimum_Term_) OR __NN(Minimum_Term_Description_) OR __NN(Maximum_Term_) OR __NN(Maximum_Term_Description_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Criminal_Punishment_Group,COUNT(ROWS(LEFT))=1),GROUP,Criminal_Punishment__Single_Rollup(LEFT)) + ROLLUP(HAVING(Criminal_Punishment_Group,COUNT(ROWS(LEFT))>1),GROUP,Criminal_Punishment__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Punishment_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Punishment_Type_);
  EXPORT Source_State__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Source_State_);
  EXPORT Current_Known_Inmate_Status__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Current_Known_Inmate_Status_);
  EXPORT Sentence_County__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Sentence_County_);
  EXPORT Current_Location_Of_Inmate__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Current_Location_Of_Inmate_);
  EXPORT Current_Location_Security__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Current_Location_Security_);
  EXPORT Offender_Key__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Offender_Key_);
  EXPORT Current_Status__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Current_Status_);
  EXPORT Probation_Time_Period__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Probation_Time_Period_);
  EXPORT Consecutive_And_Concurrent_Information__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Consecutive_And_Concurrent_Information_);
  EXPORT Instituiton_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Instituiton_Name_);
  EXPORT Restitution__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Restitution_);
  EXPORT Community_Service__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Community_Service_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_Files_NonFCRA_Doxie_Files__Key_Punishment_Vault_Invalid),COUNT(PublicRecords_KEL_Files_FCRA_doxie_files__Key_Court_Offenses_Vault_Invalid),COUNT(PublicRecords_KEL_Files_FCRA_doxie_files__Key_Offenses_Vault_Invalid),COUNT(Punishment_Type__SingleValue_Invalid),COUNT(Source_State__SingleValue_Invalid),COUNT(Current_Known_Inmate_Status__SingleValue_Invalid),COUNT(Sentence_County__SingleValue_Invalid),COUNT(Current_Location_Of_Inmate__SingleValue_Invalid),COUNT(Current_Location_Security__SingleValue_Invalid),COUNT(Offender_Key__SingleValue_Invalid),COUNT(Current_Status__SingleValue_Invalid),COUNT(Probation_Time_Period__SingleValue_Invalid),COUNT(Consecutive_And_Concurrent_Information__SingleValue_Invalid),COUNT(Instituiton_Name__SingleValue_Invalid),COUNT(Restitution__SingleValue_Invalid),COUNT(Community_Service__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_Files_NonFCRA_Doxie_Files__Key_Punishment_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_FCRA_doxie_files__Key_Court_Offenses_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_FCRA_doxie_files__Key_Offenses_Vault_Invalid,KEL.typ.int Punishment_Type__SingleValue_Invalid,KEL.typ.int Source_State__SingleValue_Invalid,KEL.typ.int Current_Known_Inmate_Status__SingleValue_Invalid,KEL.typ.int Sentence_County__SingleValue_Invalid,KEL.typ.int Current_Location_Of_Inmate__SingleValue_Invalid,KEL.typ.int Current_Location_Security__SingleValue_Invalid,KEL.typ.int Offender_Key__SingleValue_Invalid,KEL.typ.int Current_Status__SingleValue_Invalid,KEL.typ.int Probation_Time_Period__SingleValue_Invalid,KEL.typ.int Consecutive_And_Concurrent_Information__SingleValue_Invalid,KEL.typ.int Instituiton_Name__SingleValue_Invalid,KEL.typ.int Restitution__SingleValue_Invalid,KEL.typ.int Community_Service__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_Doxie_Files__Key_Punishment_Vault_Invalid),COUNT(__d0)},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','offender_key',COUNT(__d0(__NL(Offender_Key_))),COUNT(__d0(__NN(Offender_Key_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','source_file',COUNT(__d0(__NL(Source_File_))),COUNT(__d0(__NN(Source_File_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','punishment_type',COUNT(__d0(__NL(Punishment_Type_))),COUNT(__d0(__NN(Punishment_Type_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','orig_state',COUNT(__d0(__NL(Source_State_))),COUNT(__d0(__NN(Source_State_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','punishment_persistent_id',COUNT(__d0(__NL(Punishment_Persistent_I_D_))),COUNT(__d0(__NN(Punishment_Persistent_I_D_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','sent_date',COUNT(__d0(__NL(Date_Of_Sentence_))),COUNT(__d0(__NN(Date_Of_Sentence_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','sent_length',COUNT(__d0(__NL(Sentence_Length_))),COUNT(__d0(__NN(Sentence_Length_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','sent_length_desc',COUNT(__d0(__NL(Sentence_Length_Description_))),COUNT(__d0(__NN(Sentence_Length_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','SentenceDescription',COUNT(__d0(__NL(Sentence_Description_))),COUNT(__d0(__NN(Sentence_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','SentenceType',COUNT(__d0(__NL(Sentence_Type_))),COUNT(__d0(__NN(Sentence_Type_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','SentenceCounty',COUNT(__d0(__NL(Sentence_County_))),COUNT(__d0(__NN(Sentence_County_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','cur_stat_inm_desc',COUNT(__d0(__NL(Current_Known_Inmate_Status_))),COUNT(__d0(__NN(Current_Known_Inmate_Status_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','cur_loc_inm',COUNT(__d0(__NL(Current_Location_Of_Inmate_))),COUNT(__d0(__NN(Current_Location_Of_Inmate_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','cur_loc_sec',COUNT(__d0(__NL(Current_Location_Security_))),COUNT(__d0(__NN(Current_Location_Security_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','latest_adm_dt',COUNT(__d0(__NL(Incarceration_Admission_Date_))),COUNT(__d0(__NN(Incarceration_Admission_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','MinimumTerm',COUNT(__d0(__NL(Minimum_Term_))),COUNT(__d0(__NN(Minimum_Term_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','MinimumTermDescription',COUNT(__d0(__NL(Minimum_Term_Description_))),COUNT(__d0(__NN(Minimum_Term_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','MaximumTerm',COUNT(__d0(__NL(Maximum_Term_))),COUNT(__d0(__NN(Maximum_Term_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','MaximumTermDescription',COUNT(__d0(__NL(Maximum_Term_Description_))),COUNT(__d0(__NN(Maximum_Term_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','sch_rel_dt',COUNT(__d0(__NL(Scheduled_Release_Date_))),COUNT(__d0(__NN(Scheduled_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','act_rel_dt',COUNT(__d0(__NL(Actual_Release_Date_))),COUNT(__d0(__NN(Actual_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','ctl_rel_dt',COUNT(__d0(__NL(Control_Release_Date_))),COUNT(__d0(__NN(Control_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','presump_par_rel_dt',COUNT(__d0(__NL(Presumptive_Parole_Release_Date_))),COUNT(__d0(__NN(Presumptive_Parole_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','par_cur_stat',COUNT(__d0(__NL(Parole_Current_Status_))),COUNT(__d0(__NN(Parole_Current_Status_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','par_cur_stat_desc',COUNT(__d0(__NL(Parole_Current_Status_Description_))),COUNT(__d0(__NN(Parole_Current_Status_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','par_st_dt',COUNT(__d0(__NL(Parole_Start_Date_))),COUNT(__d0(__NN(Parole_Start_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','par_sch_end_dt',COUNT(__d0(__NL(Parole_Scheduled_Release_Date_))),COUNT(__d0(__NN(Parole_Scheduled_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','par_act_end_dt',COUNT(__d0(__NL(Parole_Actual_Release_Date_))),COUNT(__d0(__NN(Parole_Actual_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','par_cty',COUNT(__d0(__NL(Parole_County_))),COUNT(__d0(__NN(Parole_County_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','ProbationStartDate',COUNT(__d0(__NL(Probation_Start_Date_))),COUNT(__d0(__NN(Probation_Start_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','ProbationEndDate',COUNT(__d0(__NL(Probation_End_Date_))),COUNT(__d0(__NN(Probation_End_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','ProbationStatus',COUNT(__d0(__NL(Probation_Status_))),COUNT(__d0(__NN(Probation_Status_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','ProbationTimePeriod',COUNT(__d0(__NL(Probation_Time_Period_))),COUNT(__d0(__NN(Probation_Time_Period_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','AdditionalProvision1',COUNT(__d0(__NL(Additional_Provision1_))),COUNT(__d0(__NN(Additional_Provision1_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','AdditionalProvision2',COUNT(__d0(__NL(Additional_Provision2_))),COUNT(__d0(__NN(Additional_Provision2_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','ProbationDescription',COUNT(__d0(__NL(Probation_Description_))),COUNT(__d0(__NN(Probation_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','AdditionalSentenceDates',COUNT(__d0(__NL(Additional_Sentence_Dates_))),COUNT(__d0(__NN(Additional_Sentence_Dates_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','CurrentStatus',COUNT(__d0(__NL(Current_Status_))),COUNT(__d0(__NN(Current_Status_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','ConsecutiveAndConcurrentInformation',COUNT(__d0(__NL(Consecutive_And_Concurrent_Information_))),COUNT(__d0(__NN(Consecutive_And_Concurrent_Information_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','InstituitonName',COUNT(__d0(__NL(Instituiton_Name_))),COUNT(__d0(__NN(Instituiton_Name_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','Restitution',COUNT(__d0(__NL(Restitution_))),COUNT(__d0(__NN(Restitution_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','CommunityService',COUNT(__d0(__NL(Community_Service_))),COUNT(__d0(__NN(Community_Service_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'CriminalPunishment','PublicRecords_KEL.Files.NonFCRA.Doxie_Files__Key_Punishment_Vault','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','UID',COUNT(PublicRecords_KEL_Files_FCRA_doxie_files__Key_Court_Offenses_Vault_Invalid),COUNT(__d1)},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','offender_key',COUNT(__d1(__NL(Offender_Key_))),COUNT(__d1(__NN(Offender_Key_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','SourceFile',COUNT(__d1(__NL(Source_File_))),COUNT(__d1(__NN(Source_File_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','PunishmentType',COUNT(__d1(__NL(Punishment_Type_))),COUNT(__d1(__NN(Punishment_Type_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','SourceState',COUNT(__d1(__NL(Source_State_))),COUNT(__d1(__NN(Source_State_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','PunishmentPersistentID',COUNT(__d1(__NL(Punishment_Persistent_I_D_))),COUNT(__d1(__NN(Punishment_Persistent_I_D_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','sent_date',COUNT(__d1(__NL(Date_Of_Sentence_))),COUNT(__d1(__NN(Date_Of_Sentence_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','SentenceLength',COUNT(__d1(__NL(Sentence_Length_))),COUNT(__d1(__NN(Sentence_Length_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','sent_jail',COUNT(__d1(__NL(Sentence_Length_Description_))),COUNT(__d1(__NN(Sentence_Length_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','SentenceDescription',COUNT(__d1(__NL(Sentence_Description_))),COUNT(__d1(__NN(Sentence_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','SentenceType',COUNT(__d1(__NL(Sentence_Type_))),COUNT(__d1(__NN(Sentence_Type_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','cty_conv',COUNT(__d1(__NL(Sentence_County_))),COUNT(__d1(__NN(Sentence_County_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','CurrentKnownInmateStatus',COUNT(__d1(__NL(Current_Known_Inmate_Status_))),COUNT(__d1(__NN(Current_Known_Inmate_Status_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','CurrentLocationOfInmate',COUNT(__d1(__NL(Current_Location_Of_Inmate_))),COUNT(__d1(__NN(Current_Location_Of_Inmate_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','CurrentLocationSecurity',COUNT(__d1(__NL(Current_Location_Security_))),COUNT(__d1(__NN(Current_Location_Security_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','IncarcerationAdmissionDate',COUNT(__d1(__NL(Incarceration_Admission_Date_))),COUNT(__d1(__NN(Incarceration_Admission_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','MinimumTerm',COUNT(__d1(__NL(Minimum_Term_))),COUNT(__d1(__NN(Minimum_Term_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','MinimumTermDescription',COUNT(__d1(__NL(Minimum_Term_Description_))),COUNT(__d1(__NN(Minimum_Term_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','MaximumTerm',COUNT(__d1(__NL(Maximum_Term_))),COUNT(__d1(__NN(Maximum_Term_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','MaximumTermDescription',COUNT(__d1(__NL(Maximum_Term_Description_))),COUNT(__d1(__NN(Maximum_Term_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','ScheduledReleaseDate',COUNT(__d1(__NL(Scheduled_Release_Date_))),COUNT(__d1(__NN(Scheduled_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','ActualReleaseDate',COUNT(__d1(__NL(Actual_Release_Date_))),COUNT(__d1(__NN(Actual_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','ControlReleaseDate',COUNT(__d1(__NL(Control_Release_Date_))),COUNT(__d1(__NN(Control_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','PresumptiveParoleReleaseDate',COUNT(__d1(__NL(Presumptive_Parole_Release_Date_))),COUNT(__d1(__NN(Presumptive_Parole_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','ParoleCurrentStatus',COUNT(__d1(__NL(Parole_Current_Status_))),COUNT(__d1(__NN(Parole_Current_Status_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','ParoleCurrentStatusDescription',COUNT(__d1(__NL(Parole_Current_Status_Description_))),COUNT(__d1(__NN(Parole_Current_Status_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','ParoleStartDate',COUNT(__d1(__NL(Parole_Start_Date_))),COUNT(__d1(__NN(Parole_Start_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','ParoleScheduledReleaseDate',COUNT(__d1(__NL(Parole_Scheduled_Release_Date_))),COUNT(__d1(__NN(Parole_Scheduled_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','ParoleActualReleaseDate',COUNT(__d1(__NL(Parole_Actual_Release_Date_))),COUNT(__d1(__NN(Parole_Actual_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','ParoleCounty',COUNT(__d1(__NL(Parole_County_))),COUNT(__d1(__NN(Parole_County_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','ProbationStartDate',COUNT(__d1(__NL(Probation_Start_Date_))),COUNT(__d1(__NN(Probation_Start_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','ProbationEndDate',COUNT(__d1(__NL(Probation_End_Date_))),COUNT(__d1(__NN(Probation_End_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','ProbationStatus',COUNT(__d1(__NL(Probation_Status_))),COUNT(__d1(__NN(Probation_Status_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','sent_probation',COUNT(__d1(__NL(Probation_Time_Period_))),COUNT(__d1(__NN(Probation_Time_Period_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','sent_addl_prov_desc_1',COUNT(__d1(__NL(Additional_Provision1_))),COUNT(__d1(__NN(Additional_Provision1_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','sent_addl_prov_desc_2',COUNT(__d1(__NL(Additional_Provision2_))),COUNT(__d1(__NN(Additional_Provision2_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','probation_desc2',COUNT(__d1(__NL(Probation_Description_))),COUNT(__d1(__NN(Probation_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','addl_sent_dates',COUNT(__d1(__NL(Additional_Sentence_Dates_))),COUNT(__d1(__NN(Additional_Sentence_Dates_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','sent_susp_time',COUNT(__d1(__NL(Current_Status_))),COUNT(__d1(__NN(Current_Status_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','sent_consec',COUNT(__d1(__NL(Consecutive_And_Concurrent_Information_))),COUNT(__d1(__NN(Consecutive_And_Concurrent_Information_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','sent_agency_rec_cust',COUNT(__d1(__NL(Instituiton_Name_))),COUNT(__d1(__NN(Instituiton_Name_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','restitution',COUNT(__d1(__NL(Restitution_))),COUNT(__d1(__NN(Restitution_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','community_service',COUNT(__d1(__NL(Community_Service_))),COUNT(__d1(__NN(Community_Service_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Court_Offenses_Vault','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','UID',COUNT(PublicRecords_KEL_Files_FCRA_doxie_files__Key_Offenses_Vault_Invalid),COUNT(__d2)},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','offender_key',COUNT(__d2(__NL(Offender_Key_))),COUNT(__d2(__NN(Offender_Key_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','source_file',COUNT(__d2(__NL(Source_File_))),COUNT(__d2(__NN(Source_File_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','PunishmentType',COUNT(__d2(__NL(Punishment_Type_))),COUNT(__d2(__NN(Punishment_Type_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','orig_state',COUNT(__d2(__NL(Source_State_))),COUNT(__d2(__NN(Source_State_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','PunishmentPersistentID',COUNT(__d2(__NL(Punishment_Persistent_I_D_))),COUNT(__d2(__NN(Punishment_Persistent_I_D_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','stc_dt',COUNT(__d2(__NL(Date_Of_Sentence_))),COUNT(__d2(__NN(Date_Of_Sentence_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','stc_lgth',COUNT(__d2(__NL(Sentence_Length_))),COUNT(__d2(__NN(Sentence_Length_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','stc_lgth_desc',COUNT(__d2(__NL(Sentence_Length_Description_))),COUNT(__d2(__NN(Sentence_Length_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','stc_desc_2',COUNT(__d2(__NL(Sentence_Description_))),COUNT(__d2(__NN(Sentence_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','stc_desc_1',COUNT(__d2(__NL(Sentence_Type_))),COUNT(__d2(__NN(Sentence_Type_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','cty_conv',COUNT(__d2(__NL(Sentence_County_))),COUNT(__d2(__NN(Sentence_County_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','CurrentKnownInmateStatus',COUNT(__d2(__NL(Current_Known_Inmate_Status_))),COUNT(__d2(__NN(Current_Known_Inmate_Status_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','CurrentLocationOfInmate',COUNT(__d2(__NL(Current_Location_Of_Inmate_))),COUNT(__d2(__NN(Current_Location_Of_Inmate_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','CurrentLocationSecurity',COUNT(__d2(__NL(Current_Location_Security_))),COUNT(__d2(__NN(Current_Location_Security_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','inc_adm_dt',COUNT(__d2(__NL(Incarceration_Admission_Date_))),COUNT(__d2(__NN(Incarceration_Admission_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','min_term',COUNT(__d2(__NL(Minimum_Term_))),COUNT(__d2(__NN(Minimum_Term_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','min_term_desc',COUNT(__d2(__NL(Minimum_Term_Description_))),COUNT(__d2(__NN(Minimum_Term_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','max_term',COUNT(__d2(__NL(Maximum_Term_))),COUNT(__d2(__NN(Maximum_Term_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','max_term_desc',COUNT(__d2(__NL(Maximum_Term_Description_))),COUNT(__d2(__NN(Maximum_Term_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','ScheduledReleaseDate',COUNT(__d2(__NL(Scheduled_Release_Date_))),COUNT(__d2(__NN(Scheduled_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','ActualReleaseDate',COUNT(__d2(__NL(Actual_Release_Date_))),COUNT(__d2(__NN(Actual_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','ControlReleaseDate',COUNT(__d2(__NL(Control_Release_Date_))),COUNT(__d2(__NN(Control_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','PresumptiveParoleReleaseDate',COUNT(__d2(__NL(Presumptive_Parole_Release_Date_))),COUNT(__d2(__NN(Presumptive_Parole_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','ParoleCurrentStatus',COUNT(__d2(__NL(Parole_Current_Status_))),COUNT(__d2(__NN(Parole_Current_Status_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','parole',COUNT(__d2(__NL(Parole_Current_Status_Description_))),COUNT(__d2(__NN(Parole_Current_Status_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','ParoleStartDate',COUNT(__d2(__NL(Parole_Start_Date_))),COUNT(__d2(__NN(Parole_Start_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','ParoleScheduledReleaseDate',COUNT(__d2(__NL(Parole_Scheduled_Release_Date_))),COUNT(__d2(__NN(Parole_Scheduled_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','ParoleActualReleaseDate',COUNT(__d2(__NL(Parole_Actual_Release_Date_))),COUNT(__d2(__NN(Parole_Actual_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','ParoleCounty',COUNT(__d2(__NL(Parole_County_))),COUNT(__d2(__NN(Parole_County_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','ProbationStartDate',COUNT(__d2(__NL(Probation_Start_Date_))),COUNT(__d2(__NN(Probation_Start_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','ProbationEndDate',COUNT(__d2(__NL(Probation_End_Date_))),COUNT(__d2(__NN(Probation_End_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','ProbationStatus',COUNT(__d2(__NL(Probation_Status_))),COUNT(__d2(__NN(Probation_Status_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','probation',COUNT(__d2(__NL(Probation_Time_Period_))),COUNT(__d2(__NN(Probation_Time_Period_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','AdditionalProvision1',COUNT(__d2(__NL(Additional_Provision1_))),COUNT(__d2(__NN(Additional_Provision1_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','AdditionalProvision2',COUNT(__d2(__NL(Additional_Provision2_))),COUNT(__d2(__NN(Additional_Provision2_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','ProbationDescription',COUNT(__d2(__NL(Probation_Description_))),COUNT(__d2(__NN(Probation_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','AdditionalSentenceDates',COUNT(__d2(__NL(Additional_Sentence_Dates_))),COUNT(__d2(__NN(Additional_Sentence_Dates_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','stc_desc_4',COUNT(__d2(__NL(Current_Status_))),COUNT(__d2(__NN(Current_Status_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','ConsecutiveAndConcurrentInformation',COUNT(__d2(__NL(Consecutive_And_Concurrent_Information_))),COUNT(__d2(__NN(Consecutive_And_Concurrent_Information_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','InstituitonName',COUNT(__d2(__NL(Instituiton_Name_))),COUNT(__d2(__NN(Instituiton_Name_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','Restitution',COUNT(__d2(__NL(Restitution_))),COUNT(__d2(__NN(Restitution_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','stc_desc_3',COUNT(__d2(__NL(Community_Service_))),COUNT(__d2(__NN(Community_Service_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'CriminalPunishment','PublicRecords_KEL.Files.FCRA.doxie_files__Key_Offenses_Vault','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
