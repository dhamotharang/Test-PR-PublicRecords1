//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Criminal_Punishment(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),offenderkey(Offender_Key_:\'\'),sourcefile(Source_File_:\'\'),punishmenttype(Punishment_Type_:\'\'),sourcestate(Source_State_:\'\'),punishmentpersistentid(Punishment_Persistent_I_D_:\'\'),dateofsentence(Date_Of_Sentence_:DATE),sentencelength(Sentence_Length_:0),sentencelengthdescription(Sentence_Length_Description_:\'\'),sentencedescription(Sentence_Description_:\'\'),sentencetype(Sentence_Type_:\'\'),sentencecounty(Sentence_County_:\'\'),currentknowninmatestatus(Current_Known_Inmate_Status_:\'\'),currentlocationofinmate(Current_Location_Of_Inmate_:\'\'),currentlocationsecurity(Current_Location_Security_:\'\'),incarcerationadmissiondate(Incarceration_Admission_Date_:DATE),minimumterm(Minimum_Term_:0),minimumtermdescription(Minimum_Term_Description_:\'\'),maximumterm(Maximum_Term_:0),maximumtermdescription(Maximum_Term_Description_:\'\'),scheduledreleasedate(Scheduled_Release_Date_:DATE),actualreleasedate(Actual_Release_Date_:DATE),controlreleasedate(Control_Release_Date_:DATE),presumptiveparolereleasedate(Presumptive_Parole_Release_Date_:DATE),parolecurrentstatus(Parole_Current_Status_:0),parolecurrentstatusdescription(Parole_Current_Status_Description_:\'\'),parolestartdate(Parole_Start_Date_:DATE),parolescheduledreleasedate(Parole_Scheduled_Release_Date_:DATE),paroleactualreleasedate(Parole_Actual_Release_Date_:DATE),parolecounty(Parole_County_:\'\'),probationstartdate(Probation_Start_Date_:DATE),probationenddate(Probation_End_Date_:DATE),probationstatus(Probation_Status_:\'\'),probationtimeperiod(Probation_Time_Period_:\'\'),additionalprovision1(Additional_Provision1_:\'\'),additionalprovision2(Additional_Provision2_:\'\'),probationdescription(Probation_Description_:\'\'),additionalsentencedates(Additional_Sentence_Dates_:\'\'),currentstatus(Current_Status_:\'\'),consecutiveandconcurrentinformation(Consecutive_And_Concurrent_Information_:\'\'),instituitonname(Instituiton_Name_:\'\'),restitution(Restitution_:0.0),communityservice(Community_Service_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in.Dataset_Doxie_Files__Key_Punishment,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.offender_key)));
  SHARED __d1_Trim := PROJECT(__in.Dataset_Doxie_Files__Key_Offenses,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.offender_key)));
  SHARED __d2_Trim := PROJECT(__in.Dataset_Doxie_Files__Key_Court_Offenses,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.offender_key)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim + __d2_Trim;
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
  SHARED __Mapping0 := 'UID(UID),offender_key(Offender_Key_:\'\'),source_file(Source_File_:\'\'),punishment_type(Punishment_Type_:\'\'),orig_state(Source_State_:\'\'),punishment_persistent_id(Punishment_Persistent_I_D_:\'\'),sent_date(Date_Of_Sentence_:DATE),sent_length(Sentence_Length_:0),sent_length_desc(Sentence_Length_Description_:\'\'),sentencedescription(Sentence_Description_:\'\'),sentencetype(Sentence_Type_:\'\'),sentencecounty(Sentence_County_:\'\'),cur_stat_inm_desc(Current_Known_Inmate_Status_:\'\'),cur_loc_inm(Current_Location_Of_Inmate_:\'\'),cur_loc_sec(Current_Location_Security_:\'\'),latest_adm_dt(Incarceration_Admission_Date_:DATE),minimumterm(Minimum_Term_:0),minimumtermdescription(Minimum_Term_Description_:\'\'),maximumterm(Maximum_Term_:0),maximumtermdescription(Maximum_Term_Description_:\'\'),sch_rel_dt(Scheduled_Release_Date_:DATE),act_rel_dt(Actual_Release_Date_:DATE),ctl_rel_dt(Control_Release_Date_:DATE),presump_par_rel_dt(Presumptive_Parole_Release_Date_:DATE),par_cur_stat(Parole_Current_Status_:0),par_cur_stat_desc(Parole_Current_Status_Description_:\'\'),par_st_dt(Parole_Start_Date_:DATE),par_sch_end_dt(Parole_Scheduled_Release_Date_:DATE),par_act_end_dt(Parole_Actual_Release_Date_:DATE),par_cty(Parole_County_:\'\'),probationstartdate(Probation_Start_Date_:DATE),probationenddate(Probation_End_Date_:DATE),probationstatus(Probation_Status_:\'\'),probationtimeperiod(Probation_Time_Period_:\'\'),additionalprovision1(Additional_Provision1_:\'\'),additionalprovision2(Additional_Provision2_:\'\'),probationdescription(Probation_Description_:\'\'),additionalsentencedates(Additional_Sentence_Dates_:\'\'),currentstatus(Current_Status_:\'\'),consecutiveandconcurrentinformation(Consecutive_And_Concurrent_Information_:\'\'),instituitonname(Instituiton_Name_:\'\'),restitution(Restitution_:0.0),communityservice(Community_Service_:\'\'),event_dt(Date_First_Seen_:EPOCH),process_date(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Source_ := __CN('DC');
    SELF.__Permits := CFG_Compile.Permit_NonFCRA;
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Punishment,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Punishment),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Doxie_Files__Key_Punishment);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_Norm,Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Punishment_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0),__Mapping0_Transform(LEFT)));
  SHARED __Mapping1 := 'UID(UID),offender_key(Offender_Key_:\'\'),source_file(Source_File_:\'\'),punishmenttype(Punishment_Type_:\'\'),orig_state(Source_State_:\'\'),punishmentpersistentid(Punishment_Persistent_I_D_:\'\'),stc_dt(Date_Of_Sentence_:DATE),stc_lgth(Sentence_Length_:0),stc_lgth_desc(Sentence_Length_Description_:\'\'),stc_desc_2(Sentence_Description_:\'\'),stc_desc_1(Sentence_Type_:\'\'),cty_conv(Sentence_County_:\'\'),currentknowninmatestatus(Current_Known_Inmate_Status_:\'\'),currentlocationofinmate(Current_Location_Of_Inmate_:\'\'),currentlocationsecurity(Current_Location_Security_:\'\'),inc_adm_dt(Incarceration_Admission_Date_:DATE),min_term(Minimum_Term_:0),min_term_desc(Minimum_Term_Description_:\'\'),max_term(Maximum_Term_:0),max_term_desc(Maximum_Term_Description_:\'\'),scheduledreleasedate(Scheduled_Release_Date_:DATE),actualreleasedate(Actual_Release_Date_:DATE),controlreleasedate(Control_Release_Date_:DATE),presumptiveparolereleasedate(Presumptive_Parole_Release_Date_:DATE),parolecurrentstatus(Parole_Current_Status_:0),parole(Parole_Current_Status_Description_:\'\'),parolestartdate(Parole_Start_Date_:DATE),parolescheduledreleasedate(Parole_Scheduled_Release_Date_:DATE),paroleactualreleasedate(Parole_Actual_Release_Date_:DATE),parolecounty(Parole_County_:\'\'),probationstartdate(Probation_Start_Date_:DATE),probationenddate(Probation_End_Date_:DATE),probationstatus(Probation_Status_:\'\'),probation(Probation_Time_Period_:\'\'),additionalprovision1(Additional_Provision1_:\'\'),additionalprovision2(Additional_Provision2_:\'\'),probationdescription(Probation_Description_:\'\'),additionalsentencedates(Additional_Sentence_Dates_:\'\'),stc_desc_4(Current_Status_:\'\'),consecutiveandconcurrentinformation(Consecutive_And_Concurrent_Information_:\'\'),instituitonname(Instituiton_Name_:\'\'),restitution(Restitution_:0.0),stc_desc_3(Community_Service_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.Source_ := __CN('DC');
    SELF.__Permits := CFG_Compile.Permit_FCRA;
    SELF := __r;
  END;
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenses,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenses),SELF:=RIGHT));
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Doxie_Files__Key_Offenses);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_Norm,Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenses_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1),__Mapping1_Transform(LEFT)));
  SHARED __Mapping2 := 'UID(UID),offender_key(Offender_Key_:\'\'),sourcefile(Source_File_:\'\'),punishmenttype(Punishment_Type_:\'\'),sourcestate(Source_State_:\'\'),punishmentpersistentid(Punishment_Persistent_I_D_:\'\'),sent_date(Date_Of_Sentence_:DATE),sentencelength(Sentence_Length_:0),sent_jail(Sentence_Length_Description_:\'\'),sentencedescription(Sentence_Description_:\'\'),sentencetype(Sentence_Type_:\'\'),cty_conv(Sentence_County_:\'\'),currentknowninmatestatus(Current_Known_Inmate_Status_:\'\'),currentlocationofinmate(Current_Location_Of_Inmate_:\'\'),currentlocationsecurity(Current_Location_Security_:\'\'),incarcerationadmissiondate(Incarceration_Admission_Date_:DATE),minimumterm(Minimum_Term_:0),minimumtermdescription(Minimum_Term_Description_:\'\'),maximumterm(Maximum_Term_:0),maximumtermdescription(Maximum_Term_Description_:\'\'),scheduledreleasedate(Scheduled_Release_Date_:DATE),actualreleasedate(Actual_Release_Date_:DATE),controlreleasedate(Control_Release_Date_:DATE),presumptiveparolereleasedate(Presumptive_Parole_Release_Date_:DATE),parolecurrentstatus(Parole_Current_Status_:0),parolecurrentstatusdescription(Parole_Current_Status_Description_:\'\'),parolestartdate(Parole_Start_Date_:DATE),parolescheduledreleasedate(Parole_Scheduled_Release_Date_:DATE),paroleactualreleasedate(Parole_Actual_Release_Date_:DATE),parolecounty(Parole_County_:\'\'),probationstartdate(Probation_Start_Date_:DATE),probationenddate(Probation_End_Date_:DATE),probationstatus(Probation_Status_:\'\'),sent_probation(Probation_Time_Period_:\'\'),sent_addl_prov_desc_1(Additional_Provision1_:\'\'),sent_addl_prov_desc_2(Additional_Provision2_:\'\'),probation_desc2(Probation_Description_:\'\'),addl_sent_dates(Additional_Sentence_Dates_:\'\'),sent_susp_time(Current_Status_:\'\'),sent_consec(Consecutive_And_Concurrent_Information_:\'\'),sent_agency_rec_cust(Instituiton_Name_:\'\'),restitution(Restitution_:0.0),community_service(Community_Service_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping2_Transform(InLayout __r) := TRANSFORM
    SELF.__Permits := CFG_Compile.Permit_FCRA;
    SELF := __r;
  END;
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Court_Offenses,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Court_Offenses),SELF:=RIGHT));
  SHARED __d2_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Doxie_Files__Key_Court_Offenses);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d2_UID_Mapped := JOIN(__d2_Norm,Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d2_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Court_Offenses_Invalid := __d2_UID_Mapped(UID = 0);
  SHARED __d2_Prefiltered := __d2_UID_Mapped(UID <> 0);
  SHARED __d2 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2),__Mapping2_Transform(LEFT)));
  EXPORT InData := __d0 + __d1 + __d2;
  EXPORT Sources_Layout := RECORD
    KEL.typ.nstr Source_File_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Reported_Punishment_Persistent_I_Ds_Layout := RECORD
    KEL.typ.nstr Punishment_Persistent_I_D_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Criminal_Punishment_Group := __PostFilter;
  Layout Criminal_Punishment__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_File_},Source_File_),Sources_Layout)(__NN(Source_File_)));
    SELF.Reported_Punishment_Persistent_I_Ds_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Punishment_Persistent_I_D_},Punishment_Persistent_I_D_),Reported_Punishment_Persistent_I_Ds_Layout)(__NN(Punishment_Persistent_I_D_)));
    SELF.Reported_Punishment_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Sentence_Length_,Sentence_Description_,Sentence_Length_Description_,Sentence_Type_,Date_Of_Sentence_,Incarceration_Admission_Date_,Scheduled_Release_Date_,Actual_Release_Date_,Control_Release_Date_,Presumptive_Parole_Release_Date_,Parole_Current_Status_,Parole_Current_Status_Description_,Parole_Start_Date_,Parole_Scheduled_Release_Date_,Parole_Actual_Release_Date_,Parole_County_,Probation_Start_Date_,Probation_End_Date_,Probation_Status_,Additional_Provision1_,Additional_Provision2_,Additional_Sentence_Dates_,Probation_Description_,Minimum_Term_,Minimum_Term_Description_,Maximum_Term_,Maximum_Term_Description_},Sentence_Length_,Sentence_Description_,Sentence_Length_Description_,Sentence_Type_,Date_Of_Sentence_,Incarceration_Admission_Date_,Scheduled_Release_Date_,Actual_Release_Date_,Control_Release_Date_,Presumptive_Parole_Release_Date_,Parole_Current_Status_,Parole_Current_Status_Description_,Parole_Start_Date_,Parole_Scheduled_Release_Date_,Parole_Actual_Release_Date_,Parole_County_,Probation_Start_Date_,Probation_End_Date_,Probation_Status_,Additional_Provision1_,Additional_Provision2_,Additional_Sentence_Dates_,Probation_Description_,Minimum_Term_,Minimum_Term_Description_,Maximum_Term_,Maximum_Term_Description_),Reported_Punishment_Layout)(__NN(Sentence_Length_) OR __NN(Sentence_Description_) OR __NN(Sentence_Length_Description_) OR __NN(Sentence_Type_) OR __NN(Date_Of_Sentence_) OR __NN(Incarceration_Admission_Date_) OR __NN(Scheduled_Release_Date_) OR __NN(Actual_Release_Date_) OR __NN(Control_Release_Date_) OR __NN(Presumptive_Parole_Release_Date_) OR __NN(Parole_Current_Status_) OR __NN(Parole_Current_Status_Description_) OR __NN(Parole_Start_Date_) OR __NN(Parole_Scheduled_Release_Date_) OR __NN(Parole_Actual_Release_Date_) OR __NN(Parole_County_) OR __NN(Probation_Start_Date_) OR __NN(Probation_End_Date_) OR __NN(Probation_Status_) OR __NN(Additional_Provision1_) OR __NN(Additional_Provision2_) OR __NN(Additional_Sentence_Dates_) OR __NN(Probation_Description_) OR __NN(Minimum_Term_) OR __NN(Minimum_Term_Description_) OR __NN(Maximum_Term_) OR __NN(Maximum_Term_Description_)));
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
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Criminal_Punishment__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_File_)));
    SELF.Reported_Punishment_Persistent_I_Ds_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Reported_Punishment_Persistent_I_Ds_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Punishment_Persistent_I_D_)));
    SELF.Reported_Punishment_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Reported_Punishment_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Sentence_Length_) OR __NN(Sentence_Description_) OR __NN(Sentence_Length_Description_) OR __NN(Sentence_Type_) OR __NN(Date_Of_Sentence_) OR __NN(Incarceration_Admission_Date_) OR __NN(Scheduled_Release_Date_) OR __NN(Actual_Release_Date_) OR __NN(Control_Release_Date_) OR __NN(Presumptive_Parole_Release_Date_) OR __NN(Parole_Current_Status_) OR __NN(Parole_Current_Status_Description_) OR __NN(Parole_Start_Date_) OR __NN(Parole_Scheduled_Release_Date_) OR __NN(Parole_Actual_Release_Date_) OR __NN(Parole_County_) OR __NN(Probation_Start_Date_) OR __NN(Probation_End_Date_) OR __NN(Probation_Status_) OR __NN(Additional_Provision1_) OR __NN(Additional_Provision2_) OR __NN(Additional_Sentence_Dates_) OR __NN(Probation_Description_) OR __NN(Minimum_Term_) OR __NN(Minimum_Term_Description_) OR __NN(Maximum_Term_) OR __NN(Maximum_Term_Description_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Criminal_Punishment_Group,COUNT(ROWS(LEFT))=1),GROUP,Criminal_Punishment__Single_Rollup(LEFT)) + ROLLUP(HAVING(Criminal_Punishment_Group,COUNT(ROWS(LEFT))>1),GROUP,Criminal_Punishment__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Punishment_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Punishment_Type_);
  EXPORT Source_State__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Source_State_);
  EXPORT Current_Known_Inmate_Status__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Current_Known_Inmate_Status_);
  EXPORT Sentence_County__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sentence_County_);
  EXPORT Current_Location_Of_Inmate__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Current_Location_Of_Inmate_);
  EXPORT Current_Location_Security__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Current_Location_Security_);
  EXPORT Offender_Key__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Offender_Key_);
  EXPORT Current_Status__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Current_Status_);
  EXPORT Probation_Time_Period__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Probation_Time_Period_);
  EXPORT Consecutive_And_Concurrent_Information__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Consecutive_And_Concurrent_Information_);
  EXPORT Instituiton_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Instituiton_Name_);
  EXPORT Restitution__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Restitution_);
  EXPORT Community_Service__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Community_Service_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Punishment_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenses_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Court_Offenses_Invalid),COUNT(Punishment_Type__SingleValue_Invalid),COUNT(Source_State__SingleValue_Invalid),COUNT(Current_Known_Inmate_Status__SingleValue_Invalid),COUNT(Sentence_County__SingleValue_Invalid),COUNT(Current_Location_Of_Inmate__SingleValue_Invalid),COUNT(Current_Location_Security__SingleValue_Invalid),COUNT(Offender_Key__SingleValue_Invalid),COUNT(Current_Status__SingleValue_Invalid),COUNT(Probation_Time_Period__SingleValue_Invalid),COUNT(Consecutive_And_Concurrent_Information__SingleValue_Invalid),COUNT(Instituiton_Name__SingleValue_Invalid),COUNT(Restitution__SingleValue_Invalid),COUNT(Community_Service__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Punishment_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenses_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Court_Offenses_Invalid,KEL.typ.int Punishment_Type__SingleValue_Invalid,KEL.typ.int Source_State__SingleValue_Invalid,KEL.typ.int Current_Known_Inmate_Status__SingleValue_Invalid,KEL.typ.int Sentence_County__SingleValue_Invalid,KEL.typ.int Current_Location_Of_Inmate__SingleValue_Invalid,KEL.typ.int Current_Location_Security__SingleValue_Invalid,KEL.typ.int Offender_Key__SingleValue_Invalid,KEL.typ.int Current_Status__SingleValue_Invalid,KEL.typ.int Probation_Time_Period__SingleValue_Invalid,KEL.typ.int Consecutive_And_Concurrent_Information__SingleValue_Invalid,KEL.typ.int Instituiton_Name__SingleValue_Invalid,KEL.typ.int Restitution__SingleValue_Invalid,KEL.typ.int Community_Service__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Punishment_Invalid),COUNT(__d0)},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','offender_key',COUNT(__d0(__NL(Offender_Key_))),COUNT(__d0(__NN(Offender_Key_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source_file',COUNT(__d0(__NL(Source_File_))),COUNT(__d0(__NN(Source_File_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','punishment_type',COUNT(__d0(__NL(Punishment_Type_))),COUNT(__d0(__NN(Punishment_Type_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_state',COUNT(__d0(__NL(Source_State_))),COUNT(__d0(__NN(Source_State_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','punishment_persistent_id',COUNT(__d0(__NL(Punishment_Persistent_I_D_))),COUNT(__d0(__NN(Punishment_Persistent_I_D_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sent_date',COUNT(__d0(__NL(Date_Of_Sentence_))),COUNT(__d0(__NN(Date_Of_Sentence_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sent_length',COUNT(__d0(__NL(Sentence_Length_))),COUNT(__d0(__NN(Sentence_Length_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sent_length_desc',COUNT(__d0(__NL(Sentence_Length_Description_))),COUNT(__d0(__NN(Sentence_Length_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SentenceDescription',COUNT(__d0(__NL(Sentence_Description_))),COUNT(__d0(__NN(Sentence_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SentenceType',COUNT(__d0(__NL(Sentence_Type_))),COUNT(__d0(__NN(Sentence_Type_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SentenceCounty',COUNT(__d0(__NL(Sentence_County_))),COUNT(__d0(__NN(Sentence_County_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cur_stat_inm_desc',COUNT(__d0(__NL(Current_Known_Inmate_Status_))),COUNT(__d0(__NN(Current_Known_Inmate_Status_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cur_loc_inm',COUNT(__d0(__NL(Current_Location_Of_Inmate_))),COUNT(__d0(__NN(Current_Location_Of_Inmate_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cur_loc_sec',COUNT(__d0(__NL(Current_Location_Security_))),COUNT(__d0(__NN(Current_Location_Security_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','latest_adm_dt',COUNT(__d0(__NL(Incarceration_Admission_Date_))),COUNT(__d0(__NN(Incarceration_Admission_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumTerm',COUNT(__d0(__NL(Minimum_Term_))),COUNT(__d0(__NN(Minimum_Term_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumTermDescription',COUNT(__d0(__NL(Minimum_Term_Description_))),COUNT(__d0(__NN(Minimum_Term_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumTerm',COUNT(__d0(__NL(Maximum_Term_))),COUNT(__d0(__NN(Maximum_Term_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumTermDescription',COUNT(__d0(__NL(Maximum_Term_Description_))),COUNT(__d0(__NN(Maximum_Term_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sch_rel_dt',COUNT(__d0(__NL(Scheduled_Release_Date_))),COUNT(__d0(__NN(Scheduled_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','act_rel_dt',COUNT(__d0(__NL(Actual_Release_Date_))),COUNT(__d0(__NN(Actual_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ctl_rel_dt',COUNT(__d0(__NL(Control_Release_Date_))),COUNT(__d0(__NN(Control_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','presump_par_rel_dt',COUNT(__d0(__NL(Presumptive_Parole_Release_Date_))),COUNT(__d0(__NN(Presumptive_Parole_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','par_cur_stat',COUNT(__d0(__NL(Parole_Current_Status_))),COUNT(__d0(__NN(Parole_Current_Status_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','par_cur_stat_desc',COUNT(__d0(__NL(Parole_Current_Status_Description_))),COUNT(__d0(__NN(Parole_Current_Status_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','par_st_dt',COUNT(__d0(__NL(Parole_Start_Date_))),COUNT(__d0(__NN(Parole_Start_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','par_sch_end_dt',COUNT(__d0(__NL(Parole_Scheduled_Release_Date_))),COUNT(__d0(__NN(Parole_Scheduled_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','par_act_end_dt',COUNT(__d0(__NL(Parole_Actual_Release_Date_))),COUNT(__d0(__NN(Parole_Actual_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','par_cty',COUNT(__d0(__NL(Parole_County_))),COUNT(__d0(__NN(Parole_County_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProbationStartDate',COUNT(__d0(__NL(Probation_Start_Date_))),COUNT(__d0(__NN(Probation_Start_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProbationEndDate',COUNT(__d0(__NL(Probation_End_Date_))),COUNT(__d0(__NN(Probation_End_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProbationStatus',COUNT(__d0(__NL(Probation_Status_))),COUNT(__d0(__NN(Probation_Status_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProbationTimePeriod',COUNT(__d0(__NL(Probation_Time_Period_))),COUNT(__d0(__NN(Probation_Time_Period_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdditionalProvision1',COUNT(__d0(__NL(Additional_Provision1_))),COUNT(__d0(__NN(Additional_Provision1_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdditionalProvision2',COUNT(__d0(__NL(Additional_Provision2_))),COUNT(__d0(__NN(Additional_Provision2_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProbationDescription',COUNT(__d0(__NL(Probation_Description_))),COUNT(__d0(__NN(Probation_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdditionalSentenceDates',COUNT(__d0(__NL(Additional_Sentence_Dates_))),COUNT(__d0(__NN(Additional_Sentence_Dates_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentStatus',COUNT(__d0(__NL(Current_Status_))),COUNT(__d0(__NN(Current_Status_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConsecutiveAndConcurrentInformation',COUNT(__d0(__NL(Consecutive_And_Concurrent_Information_))),COUNT(__d0(__NN(Consecutive_And_Concurrent_Information_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InstituitonName',COUNT(__d0(__NL(Instituiton_Name_))),COUNT(__d0(__NN(Instituiton_Name_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Restitution',COUNT(__d0(__NL(Restitution_))),COUNT(__d0(__NN(Restitution_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CommunityService',COUNT(__d0(__NL(Community_Service_))),COUNT(__d0(__NN(Community_Service_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Offenses_Invalid),COUNT(__d1)},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','offender_key',COUNT(__d1(__NL(Offender_Key_))),COUNT(__d1(__NN(Offender_Key_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source_file',COUNT(__d1(__NL(Source_File_))),COUNT(__d1(__NN(Source_File_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PunishmentType',COUNT(__d1(__NL(Punishment_Type_))),COUNT(__d1(__NN(Punishment_Type_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_state',COUNT(__d1(__NL(Source_State_))),COUNT(__d1(__NN(Source_State_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PunishmentPersistentID',COUNT(__d1(__NL(Punishment_Persistent_I_D_))),COUNT(__d1(__NN(Punishment_Persistent_I_D_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','stc_dt',COUNT(__d1(__NL(Date_Of_Sentence_))),COUNT(__d1(__NN(Date_Of_Sentence_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','stc_lgth',COUNT(__d1(__NL(Sentence_Length_))),COUNT(__d1(__NN(Sentence_Length_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','stc_lgth_desc',COUNT(__d1(__NL(Sentence_Length_Description_))),COUNT(__d1(__NN(Sentence_Length_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','stc_desc_2',COUNT(__d1(__NL(Sentence_Description_))),COUNT(__d1(__NN(Sentence_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','stc_desc_1',COUNT(__d1(__NL(Sentence_Type_))),COUNT(__d1(__NN(Sentence_Type_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cty_conv',COUNT(__d1(__NL(Sentence_County_))),COUNT(__d1(__NN(Sentence_County_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentKnownInmateStatus',COUNT(__d1(__NL(Current_Known_Inmate_Status_))),COUNT(__d1(__NN(Current_Known_Inmate_Status_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentLocationOfInmate',COUNT(__d1(__NL(Current_Location_Of_Inmate_))),COUNT(__d1(__NN(Current_Location_Of_Inmate_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentLocationSecurity',COUNT(__d1(__NL(Current_Location_Security_))),COUNT(__d1(__NN(Current_Location_Security_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','inc_adm_dt',COUNT(__d1(__NL(Incarceration_Admission_Date_))),COUNT(__d1(__NN(Incarceration_Admission_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','min_term',COUNT(__d1(__NL(Minimum_Term_))),COUNT(__d1(__NN(Minimum_Term_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','min_term_desc',COUNT(__d1(__NL(Minimum_Term_Description_))),COUNT(__d1(__NN(Minimum_Term_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','max_term',COUNT(__d1(__NL(Maximum_Term_))),COUNT(__d1(__NN(Maximum_Term_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','max_term_desc',COUNT(__d1(__NL(Maximum_Term_Description_))),COUNT(__d1(__NN(Maximum_Term_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ScheduledReleaseDate',COUNT(__d1(__NL(Scheduled_Release_Date_))),COUNT(__d1(__NN(Scheduled_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActualReleaseDate',COUNT(__d1(__NL(Actual_Release_Date_))),COUNT(__d1(__NN(Actual_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ControlReleaseDate',COUNT(__d1(__NL(Control_Release_Date_))),COUNT(__d1(__NN(Control_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PresumptiveParoleReleaseDate',COUNT(__d1(__NL(Presumptive_Parole_Release_Date_))),COUNT(__d1(__NN(Presumptive_Parole_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParoleCurrentStatus',COUNT(__d1(__NL(Parole_Current_Status_))),COUNT(__d1(__NN(Parole_Current_Status_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','parole',COUNT(__d1(__NL(Parole_Current_Status_Description_))),COUNT(__d1(__NN(Parole_Current_Status_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParoleStartDate',COUNT(__d1(__NL(Parole_Start_Date_))),COUNT(__d1(__NN(Parole_Start_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParoleScheduledReleaseDate',COUNT(__d1(__NL(Parole_Scheduled_Release_Date_))),COUNT(__d1(__NN(Parole_Scheduled_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParoleActualReleaseDate',COUNT(__d1(__NL(Parole_Actual_Release_Date_))),COUNT(__d1(__NN(Parole_Actual_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParoleCounty',COUNT(__d1(__NL(Parole_County_))),COUNT(__d1(__NN(Parole_County_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProbationStartDate',COUNT(__d1(__NL(Probation_Start_Date_))),COUNT(__d1(__NN(Probation_Start_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProbationEndDate',COUNT(__d1(__NL(Probation_End_Date_))),COUNT(__d1(__NN(Probation_End_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProbationStatus',COUNT(__d1(__NL(Probation_Status_))),COUNT(__d1(__NN(Probation_Status_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','probation',COUNT(__d1(__NL(Probation_Time_Period_))),COUNT(__d1(__NN(Probation_Time_Period_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdditionalProvision1',COUNT(__d1(__NL(Additional_Provision1_))),COUNT(__d1(__NN(Additional_Provision1_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdditionalProvision2',COUNT(__d1(__NL(Additional_Provision2_))),COUNT(__d1(__NN(Additional_Provision2_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProbationDescription',COUNT(__d1(__NL(Probation_Description_))),COUNT(__d1(__NN(Probation_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AdditionalSentenceDates',COUNT(__d1(__NL(Additional_Sentence_Dates_))),COUNT(__d1(__NN(Additional_Sentence_Dates_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','stc_desc_4',COUNT(__d1(__NL(Current_Status_))),COUNT(__d1(__NN(Current_Status_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConsecutiveAndConcurrentInformation',COUNT(__d1(__NL(Consecutive_And_Concurrent_Information_))),COUNT(__d1(__NN(Consecutive_And_Concurrent_Information_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InstituitonName',COUNT(__d1(__NL(Instituiton_Name_))),COUNT(__d1(__NN(Instituiton_Name_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Restitution',COUNT(__d1(__NL(Restitution_))),COUNT(__d1(__NN(Restitution_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','stc_desc_3',COUNT(__d1(__NL(Community_Service_))),COUNT(__d1(__NN(Community_Service_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie_Files__Key_Court_Offenses_Invalid),COUNT(__d2)},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','offender_key',COUNT(__d2(__NL(Offender_Key_))),COUNT(__d2(__NN(Offender_Key_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceFile',COUNT(__d2(__NL(Source_File_))),COUNT(__d2(__NN(Source_File_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PunishmentType',COUNT(__d2(__NL(Punishment_Type_))),COUNT(__d2(__NN(Punishment_Type_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SourceState',COUNT(__d2(__NL(Source_State_))),COUNT(__d2(__NN(Source_State_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PunishmentPersistentID',COUNT(__d2(__NL(Punishment_Persistent_I_D_))),COUNT(__d2(__NN(Punishment_Persistent_I_D_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sent_date',COUNT(__d2(__NL(Date_Of_Sentence_))),COUNT(__d2(__NN(Date_Of_Sentence_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SentenceLength',COUNT(__d2(__NL(Sentence_Length_))),COUNT(__d2(__NN(Sentence_Length_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sent_jail',COUNT(__d2(__NL(Sentence_Length_Description_))),COUNT(__d2(__NN(Sentence_Length_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SentenceDescription',COUNT(__d2(__NL(Sentence_Description_))),COUNT(__d2(__NN(Sentence_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SentenceType',COUNT(__d2(__NL(Sentence_Type_))),COUNT(__d2(__NN(Sentence_Type_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','cty_conv',COUNT(__d2(__NL(Sentence_County_))),COUNT(__d2(__NN(Sentence_County_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentKnownInmateStatus',COUNT(__d2(__NL(Current_Known_Inmate_Status_))),COUNT(__d2(__NN(Current_Known_Inmate_Status_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentLocationOfInmate',COUNT(__d2(__NL(Current_Location_Of_Inmate_))),COUNT(__d2(__NN(Current_Location_Of_Inmate_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CurrentLocationSecurity',COUNT(__d2(__NL(Current_Location_Security_))),COUNT(__d2(__NN(Current_Location_Security_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IncarcerationAdmissionDate',COUNT(__d2(__NL(Incarceration_Admission_Date_))),COUNT(__d2(__NN(Incarceration_Admission_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumTerm',COUNT(__d2(__NL(Minimum_Term_))),COUNT(__d2(__NN(Minimum_Term_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MinimumTermDescription',COUNT(__d2(__NL(Minimum_Term_Description_))),COUNT(__d2(__NN(Minimum_Term_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumTerm',COUNT(__d2(__NL(Maximum_Term_))),COUNT(__d2(__NN(Maximum_Term_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MaximumTermDescription',COUNT(__d2(__NL(Maximum_Term_Description_))),COUNT(__d2(__NN(Maximum_Term_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ScheduledReleaseDate',COUNT(__d2(__NL(Scheduled_Release_Date_))),COUNT(__d2(__NN(Scheduled_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ActualReleaseDate',COUNT(__d2(__NL(Actual_Release_Date_))),COUNT(__d2(__NN(Actual_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ControlReleaseDate',COUNT(__d2(__NL(Control_Release_Date_))),COUNT(__d2(__NN(Control_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PresumptiveParoleReleaseDate',COUNT(__d2(__NL(Presumptive_Parole_Release_Date_))),COUNT(__d2(__NN(Presumptive_Parole_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParoleCurrentStatus',COUNT(__d2(__NL(Parole_Current_Status_))),COUNT(__d2(__NN(Parole_Current_Status_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParoleCurrentStatusDescription',COUNT(__d2(__NL(Parole_Current_Status_Description_))),COUNT(__d2(__NN(Parole_Current_Status_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParoleStartDate',COUNT(__d2(__NL(Parole_Start_Date_))),COUNT(__d2(__NN(Parole_Start_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParoleScheduledReleaseDate',COUNT(__d2(__NL(Parole_Scheduled_Release_Date_))),COUNT(__d2(__NN(Parole_Scheduled_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParoleActualReleaseDate',COUNT(__d2(__NL(Parole_Actual_Release_Date_))),COUNT(__d2(__NN(Parole_Actual_Release_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ParoleCounty',COUNT(__d2(__NL(Parole_County_))),COUNT(__d2(__NN(Parole_County_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProbationStartDate',COUNT(__d2(__NL(Probation_Start_Date_))),COUNT(__d2(__NN(Probation_Start_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProbationEndDate',COUNT(__d2(__NL(Probation_End_Date_))),COUNT(__d2(__NN(Probation_End_Date_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProbationStatus',COUNT(__d2(__NL(Probation_Status_))),COUNT(__d2(__NN(Probation_Status_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sent_probation',COUNT(__d2(__NL(Probation_Time_Period_))),COUNT(__d2(__NN(Probation_Time_Period_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sent_addl_prov_desc_1',COUNT(__d2(__NL(Additional_Provision1_))),COUNT(__d2(__NN(Additional_Provision1_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sent_addl_prov_desc_2',COUNT(__d2(__NL(Additional_Provision2_))),COUNT(__d2(__NN(Additional_Provision2_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','probation_desc2',COUNT(__d2(__NL(Probation_Description_))),COUNT(__d2(__NN(Probation_Description_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','addl_sent_dates',COUNT(__d2(__NL(Additional_Sentence_Dates_))),COUNT(__d2(__NN(Additional_Sentence_Dates_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sent_susp_time',COUNT(__d2(__NL(Current_Status_))),COUNT(__d2(__NN(Current_Status_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sent_consec',COUNT(__d2(__NL(Consecutive_And_Concurrent_Information_))),COUNT(__d2(__NN(Consecutive_And_Concurrent_Information_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sent_agency_rec_cust',COUNT(__d2(__NL(Instituiton_Name_))),COUNT(__d2(__NN(Instituiton_Name_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','restitution',COUNT(__d2(__NL(Restitution_))),COUNT(__d2(__NN(Restitution_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','community_service',COUNT(__d2(__NL(Community_Service_))),COUNT(__d2(__NN(Community_Service_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'CriminalPunishment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
