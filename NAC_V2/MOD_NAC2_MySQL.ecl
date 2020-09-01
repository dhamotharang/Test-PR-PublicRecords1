 

 /* preps data from ingestion process to be inserted into MySQL tables for HHSC reporting   */
 
IMPORT NAC_V2, std, _Control, ut;




EXPORT MOD_NAC2_MySQL := MODULE 
  



SHARED rl_MSH2_int := RECORD 
  string4 targetnacgroupid;
  string2 sourcestate;
  string30 servicename;
  string1 activitytype;
  string40 activitysource;
  string16 nactransactionid;
  string10 batchrecordnumber;
  string20 requestrecordid;
  string20 nacuserid;
  string15 nacuserip;
  string20 enduserid;
  string15 enduserip;
  string4 querystatus;
  string70 querystatusmessage;
  string20 searchcaseid;
  string20 searchclientid;
  string1 searchprogramcode;
  string1 searchrangetype;
  string8 searcheligibilitystart;
  string8 searcheligibilityend;
  string60 searchfullname;
  string30 searchlastname;
  string25 searchfirstname;
  string25 searchmiddlename;
  string5 searchsuffixname;
  string9 searchssn;
  string8 searchdob;
  string70 searchaddress1streetaddress1;
  string70 searchaddress1streetaddress2;
  string30 searchaddress1city;
  string2 searchaddress1state;
  string9 searchaddress1zip;
  string70 searchaddress2streetaddress1;
  string70 searchaddress2streetaddress2;
  string30 searchaddress2city;
  string2 searchaddress2state;
  string9 searchaddress2zip;
  string1 includeeligibilityhistory;
  string1 includeinterstateallprograms;
  string4 casenacgroupid;
  string2 casestate;
  string1 caseprogramcode;
  string20 caseid;
  string30 caselastname;
  string25 casefirstname;
  string25 casemiddlename;
  string5 casesuffixname;
  string10 casemonthlyallotment;
  string3 caseregioncode;
  string3 casecountyparishcode;
  string25 casecountyparishname;
  string10 casephone1;
  string10 casephone2;
  string256 caseemail;
  string1 physicaladdresscategory;
  string70 physicaladdressstreet1;
  string70 physicaladdressstreet2;
  string30 physicaladdresscity;
  string2 physicaladdressstate;
  string9 physicaladdresszip;
  string1 mailaddresscategory;
  string70 mailaddressstreet1;
  string70 mailaddressstreet2;
  string30 mailaddresscity;
  string2 mailaddressstate;
  string9 mailaddresszip;
  string20 clientid;
  string1 clienthohindicator;
  string1 clientabawdindicator;
  string1 clienthohrelationshipindicator;
  string30 clientlastname;
  string25 clientfirstname;
  string25 clientmiddlename;
  string5 clientsuffixname;
  string1 clientgender;
  string1 clientrace;
  string1 clientethnicity;
  string9 clientssn;
  string1 clientssntype;
  string8 clientdob;
  string1 clientdobtype;
  string20 clientcertificateid;
  string10 clientmonthlyallotment;
  string1 clienteligibilitystatus;
  string8 clienteligibilitydate;
  string1 clienteligibilityperiodtype;
  string5 clienteligibilityperiodcount;
  string8 clienteligibilityperiodstart;
  string8 clienteligibilityperiodend;
  string10 clientphone;
  string256 clientemail;
  string50 statecontactname;
  string10 statecontactphone;
  string10 statecontactphoneextension;
  string256 statecontactemail;
  string3 lexidscore;
  string10 matchcodes;
  string5 totaleligibleperiodsdays;
  string4 totaleligibleperiodsmonths;
  string3 exceptionreasoncode;
  string50 exceptioncomments;
  string200 eligibilityperiodshistory;
  string4 sequencenumber;
 END;

  

SHARED rl_MSX2 := RECORD
  string4 targetnacgroupid;
  string2 sourcestate;
  string30 servicename;
  string1 activitytype;
  string40 activitysource;
  string16 nactransactionid;
  string10 batchrecordnumber;
  string20 requestrecordid;
  string20 nacuserid;
  string15 nacuserip;
  string20 enduserid;
  string15 enduserip;
  string4 querystatus;
  string70 querystatusmessage;
  string20 searchcaseid;
  string20 searchclientid;
  string1 searchprogramcode;
  string1 searchrangetype;
  string8 searcheligibilitystart;
  string8 searcheligibilityend;
  string60 searchfullname;
  string30 searchlastname;
  string25 searchfirstname;
  string25 searchmiddlename;
  string5 searchsuffixname;
  string9 searchssn;
  string8 searchdob;
  string70 searchaddress1streetaddress1;
  string70 searchaddress1streetaddress2;
  string30 searchaddress1city;
  string2 searchaddress1state;
  string9 searchaddress1zip;
  string70 searchaddress2streetaddress1;
  string70 searchaddress2streetaddress2;
  string30 searchaddress2city;
  string2 searchaddress2state;
  string9 searchaddress2zip;
  string1 includeeligibilityhistory;
  string1 includeinterstateallprograms;
 END;



EXPORT fn_MSX2_rowcount(STRING MSX2_file_name_full = '') := FUNCTION
   RETURN COUNT(DATASET(MSX2_file_name_full, rl_MSX2, THOR, OPT) (SearchProgramCode IN['D', 'S']));
END;



EXPORT fn_MSH2_rowcount(STRING MSH2_file_name_full = '') := FUNCTION
   RETURN COUNT(DATASET(MSH2_file_name_full, rl_MSH2_int, THOR, OPT) (SearchProgramCode IN['D', 'S']));
END;
 
 


  EXPORT fn_InsertMSX2ToMySQL(STRING MSX2_file_name_full = '') := FUNCTION

    file_name := std.str.FindReplace(MSX2_file_name_full, '~nac::nac2::for_msh2::','');
    ds_MSX2 := DATASET(MSX2_file_name_full, rl_MSX2, THOR, OPT) (SearchProgramCode IN['D', 'S']);
    file_date := NAC_V2.SQL_Helpers.fValidSQLDate(MSX2_file_name_full[41..48]); 
    //  must apply these fixes because ESP wasnt logging properly until mid January, but these are all LA records
    NAC_V2.SQL_Layouts.MSX2FileNoMatchData ds_MSX(rl_MSX2 ds_in) := TRANSFORM
      SELF.processed_date     := file_date;
      SELF.working_day        := NAC_V2.SQL_Helpers.fIsWorkingDay(std.str.FINDREPLACE(file_date,'-',''));;
      SELF.target_group_id    := IF((LENGTH(TRIM(ds_in.targetnacgroupid)) < 1  AND ds_in.nacuserid = 'ladcfsxmlid'), 'LA01' , ds_in.targetnacgroupid) ; 
      SELF.left_group_id      := IF((LENGTH(TRIM(ds_in.targetnacgroupid)) < 1  AND ds_in.nacuserid = 'ladcfsxmlid'), 'LA01' , ds_in.targetnacgroupid) ; 
      SELF.left_orig_group_id := IF((LENGTH(TRIM(ds_in.targetnacgroupid)) < 1  AND ds_in.nacuserid = 'ladcfsxmlid'), 'LA01' , ds_in.targetnacgroupid) ; 
      SELF.left_state         := IF((LENGTH(TRIM(ds_in.sourcestate)) < 1  AND ds_in.nacuserid = 'ladcfsxmlid'), 'LA' , ds_in.sourcestate) ; 
      SELF.left_activity_type := ds_in.activitytype;
      SELF.is_online          := IF((ds_in.activitytype IN ['1','3']),'1','0');
      SELF.left_program_code  := ds_in.searchprogramcode;
      SELF.query_status_code  := (UNSIGNED8)ds_in.querystatus;
      SELF.instance_cnt       := 0;
    END;
    ds_MSX2_01 := PROJECT(ds_MSX2, ds_MSX(LEFT));

    tbl_summary := TABLE(ds_MSX2_01,
      {processed_date,  working_day, target_group_id, left_group_id, left_orig_group_id,
      left_state, left_activity_type, is_online, left_program_code, query_status_code,  
      instance_count := COUNT(GROUP)}, 
      processed_date,  working_day, target_group_id, left_group_id, left_orig_group_id,
      left_state, left_activity_type, is_online, left_program_code, query_status_code);

    NAC_V2.SQL_Layouts.MSX2FileNoMatchDataSQL ds_MSXSQL(  RECORDOF(tbl_summary) ds_in) := TRANSFORM
      SELF.processed_date      :=   ds_in.processed_date;
      SELF.working_day         :=   ds_in.working_day;
      SELF.target_group_id     :=   ds_in.target_group_id;
      SELF.left_group_id       :=   ds_in.left_group_id;
      SELF.left_orig_group_id  :=   ds_in.left_orig_group_id;
      SELF.left_state          :=   ds_in.left_state;
      SELF.left_activity_type  :=   ds_in.left_activity_type;
      SELF.is_online           :=   ds_in.is_online;
      SELF.left_program_code   :=   ds_in.left_program_code;
      SELF.query_status_code   :=   ds_in.query_status_code;
      SELF.instance_count      :=   ds_in.instance_count;
    END;

    ds_summary := PROJECT(tbl_summary(target_group_id <> ''), ds_MSXSQL(LEFT));



// OUTPUT(ds_MSX2_01, NAMED('ds_MSX2_01'));
// OUTPUT(tbl_summary, NAMED('tbl_summary'));
// OUTPUT(file_date, NAMED('file_date'));
// OUTPUT(ds_summary, NAMED('ds_summary'));

   ORDERED(
     NAC_V2.SQL_Helpers.fn_Prepare_MSX2(file_date),
     NAC_V2.SQL_Helpers.fn_AddMSX2MetadataToTable(ds_summary));

    RETURN ds_summary;
  END;



/////////////////////////////////////////////////////////////////////////////////////////

EXPORT fn_NCD2_rowcount(STRING NCD2_file_name_full = '') := FUNCTION
   RETURN COUNT(DATASET(NCD2_file_name_full, NAC_V2.Layouts2.rNac2Ex, THOR, OPT)  );
END;


  EXPORT fn_InsertNCF2MetadataToMySQL(STRING file_name_full) := FUNCTION
    file_name := std.str.FindReplace(file_name_full, '~nac::uber::in::nac2','ncf2');
    ds_NAC2_Contrib := DATASET(file_name_full, NAC_V2.Layouts2.rNac2Ex, THOR, OPT);
    file_date :=    file_name_full[27..34];   //   file_name_full[27..30] + '-' + file_name_full[31..32] + '-' + file_name_full[33..34];
    ds_extract_cases := PROJECT(ds_NAC2_Contrib(RecordCode = 'CA01'), 
        TRANSFORM(Nac_V2.Layouts2.rCaseEx,
        SELF.RecordCode := LEFT.RecordCode;
        SELF := LEFT.CaseRec;
    ));
    t_accepted_cases := TABLE(ds_extract_cases(errors = 0) ,  {programcode, recordcode,  accepted_records_count := COUNT(GROUP)}, programcode, recordcode);
    t_rejected_cases := TABLE(ds_extract_cases(errors <> 0) , {programcode, recordcode,  rejected_records_count := COUNT(GROUP)}, programcode, recordcode);
    ds_cases_summary := 
      JOIN(t_accepted_cases, t_rejected_cases, 
          LEFT.programcode = RIGHT.programcode 
      AND LEFT.recordcode = RIGHT.recordcode, 
      FULL OUTER);
    ds_cases_prepped := PROJECT(ds_cases_summary,  
      TRANSFORM(NAC_V2.SQL_Layouts.NCF2FileMetadata, 
        SELF.program_code := LEFT.programcode;
        SELF.record_code := LEFT.recordcode;
        SELF.accepted_records_count := LEFT.accepted_records_count;
        SELF.rejected_records_count := LEFT.rejected_records_count;
    ));
    NAC_V2.SQL_Helpers.fAddNCF2MetadataToTable(file_name, file_date, ds_cases_prepped);


    ds_extract_clients := PROJECT(ds_NAC2_Contrib(RecordCode = 'CL01'), TRANSFORM(Nac_V2.Layouts2.rClientEx,
        SELF.RecordCode := LEFT.RecordCode;
        SELF := LEFT.ClientRec;
        ));
    t_accepted_clients := TABLE(ds_extract_clients(errors = 0) , {programcode, recordcode,  accepted_records_count := COUNT(GROUP) },  programcode, recordcode  );
    t_rejected_clients := TABLE(ds_extract_clients(errors <> 0) , {programcode, recordcode,  rejected_records_count := COUNT(GROUP) },  programcode, recordcode  );
    ds_clients_summary := 
      JOIN(t_accepted_clients, t_rejected_clients, 
        LEFT.programcode = RIGHT.programcode 
        AND LEFT.recordcode = RIGHT.recordcode, 
      FULL OUTER);
    ds_clients_prepped := PROJECT(ds_clients_summary,  
      TRANSFORM(NAC_V2.SQL_Layouts.NCF2FileMetadata, 
        SELF.program_code := LEFT.programcode;
        SELF.record_code := LEFT.recordcode;
        SELF.accepted_records_count := LEFT.accepted_records_count;
        SELF.rejected_records_count := LEFT.rejected_records_count;
    ));
    NAC_V2.SQL_Helpers.fAddNCF2MetadataToTable(file_name, file_date, ds_clients_prepped);


    ds_extract_addresses := PROJECT(ds_NAC2_Contrib(RecordCode = 'AD01'), TRANSFORM(Nac_V2.Layouts2.rAddressEx,
          SELF.RecordCode := LEFT.RecordCode;
          SELF := LEFT.AddressRec;
          ));
    t_accepted_addresses := TABLE(ds_extract_addresses(errors = 0) , {programcode, recordcode,  accepted_records_count := COUNT(GROUP) },  programcode, recordcode  );
    t_rejected_addresses := TABLE(ds_extract_addresses(errors <> 0) , {programcode, recordcode,  rejected_records_count := COUNT(GROUP) },  programcode, recordcode  );
    ds_addresses_summary := 
      JOIN(t_accepted_addresses, t_rejected_addresses, 
        LEFT.programcode = RIGHT.programcode 
        AND LEFT.recordcode = RIGHT.recordcode, 
      FULL OUTER);
    ds_addresses_prepped := PROJECT(ds_addresses_summary,  
      TRANSFORM(NAC_V2.SQL_Layouts.NCF2FileMetadata, 
        SELF.program_code := LEFT.programcode;
        SELF.record_code := LEFT.recordcode;
        SELF.accepted_records_count := LEFT.accepted_records_count;
        SELF.rejected_records_count := LEFT.rejected_records_count;
    ));
    NAC_V2.SQL_Helpers.fAddNCF2MetadataToTable(file_name, file_date, ds_addresses_prepped);
    
    
    ds_extract_contacts := PROJECT(ds_NAC2_Contrib(RecordCode = 'SC01'), TRANSFORM(Nac_V2.Layouts2.rStateContactEx,
        SELF.RecordCode := LEFT.RecordCode;
        SELF := LEFT.StateContactRec;
    ));
    t_accepted_contacts := TABLE(ds_extract_contacts(errors = 0) , {programcode, recordcode,  accepted_records_count := COUNT(GROUP) },  programcode, recordcode  ); 
    t_rejected_contacts := TABLE(ds_extract_contacts(errors <> 0) , {programcode, recordcode,  rejected_records_count := COUNT(GROUP) },  programcode, recordcode  );
    ds_contacts_summary := 
      JOIN(t_accepted_contacts, t_rejected_contacts, 
        LEFT.programcode = RIGHT.programcode 
        AND LEFT.recordcode = RIGHT.recordcode, 
      FULL OUTER);
    ds_contacts_prepped := PROJECT(ds_contacts_summary,  
      TRANSFORM(NAC_V2.SQL_Layouts.NCF2FileMetadata, 
        SELF.program_code := LEFT.programcode;
        SELF.record_code := LEFT.recordcode;
        SELF.accepted_records_count := LEFT.accepted_records_count;
        SELF.rejected_records_count := LEFT.rejected_records_count;
    ));
    NAC_V2.SQL_Helpers.fAddNCF2MetadataToTable(file_name, file_date, ds_contacts_prepped);

    ds_all := SORT((ds_cases_prepped + ds_clients_prepped + ds_addresses_prepped + ds_contacts_prepped) , program_code);
    RETURN ds_all;
  END;



  SHARED rl_MSH2_intermediate_extended := RECORD
    rl_MSH2_int;
    STRING10      processed_date;      
    BOOLEAN       is_working_day;
    STRING4       source_groupid;
    STRING1       is_online;
    BOOLEAN       is_lexid_used;
    STRING10      base_match_codes; 
    STRING10      actual_match_codes; 
  END;

  SHARED rl_MSH2_summary_prep := RECORD
    STRING10  processed_date; 
    BOOLEAN   is_working_day; 
    STRING4   targetnacgroupid; 
    STRING4   source_groupid; 
    STRING2   sourcestate; 
    STRING1   searchprogramcode; 
    STRING1   activitytype; 
    STRING1   is_online; 
    STRING4   casenacgroupid; 
    STRING2   casestate; 
    STRING1   caseprogramcode; 
    STRING1   clienteligibilitystatus; 
    BOOLEAN   is_lexid_used; 
    STRING10  base_match_codes; 
    STRING10  actual_match_codes; 
    STRING1   exceptionreasoncode; 
  END;
      

  EXPORT fn_AddMSH2MetadataToMySQL (STRING file_name_full) := FUNCTION
    file_date := file_name_full[41..48];
    processed_date := NAC_V2.SQL_Helpers.fValidSQLDate(file_date);
    //NAC_V2.SQL_Helpers.fn_Prepare_MSH2(processed_date);
    ds_MSH2_intermediate := DATASET(file_name_full, rl_MSH2_int, THOR, OPT);
        
      rl_MSH2_intermediate_extended ds_output (rl_MSH2_int ds_input):= TRANSFORM
      SELF.processed_date := processed_date;
        //IF(  (TRIM(ds_input.activitysource) = '' OR std.str.contains(ds_input.activitysource, '_MRF_', false)), 
        // input_file_date, (IF(ds_input.activitytype IN['1','3'], (STRING10)ds_input.activitysource[6..16], (ds_input.activitysource[1..4] + '-' + ds_input.activitysource[5..6] + '-' + ds_input.activitysource[7..8]))));
      SELF.is_working_day := NAC_V2.SQL_Helpers.fIsWorkingDay(processed_date);
      SELF.source_groupid :=
      IF( (TRIM(ds_input.activitysource) = '' ) , (ds_input.sourcestate + '01'), 
        (IF(ds_input.activitytype IN['1','3'] AND std.str.CONTAINS(ds_input.activitysource, ':', false), (STRING4)ds_input.activitysource[1..4], ds_input.casenacgroupid)));   
      SELF.is_online := IF((ds_input.activitytype IN ['1','3']),'1','0');
      SELF.is_lexid_used := IF((UNSIGNED8)ds_input.lexidscore = 0, FALSE, TRUE);
      SELF.base_match_codes := NAC_V2.fQualified(ds_input.matchcodes);
      SELF.actual_match_codes := ds_input.matchcodes;
      //  BASE match codes is the one supposed to use he function, chg

      SELF := ds_input;
    END;
    ds_output2 :=  PROJECT(ds_MSH2_intermediate, ds_output(LEFT));

    rl_MSH2_summary_prep ds_output3( rl_MSH2_intermediate_extended ds_output2) := TRANSFORM
      SELF.processed_date := ds_output2.processed_date;
      SELF.is_working_day := ds_output2.is_working_day;
      SELF.targetnacgroupid := ds_output2.targetnacgroupid;
      SELF.source_groupid :=  ds_output2.source_groupid;
      SELF.sourcestate :=  ds_output2.sourcestate;
      SELF.searchprogramcode :=  ds_output2.searchprogramcode;
      SELF.activitytype :=  ds_output2.activitytype;
      SELF.is_online :=  ds_output2.is_online;
      SELF.casenacgroupid :=  ds_output2.casenacgroupid;
      SELF.casestate :=  ds_output2.casestate;
      SELF.caseprogramcode :=  ds_output2.caseprogramcode;
      SELF.clienteligibilitystatus :=  ds_output2.clienteligibilitystatus;
      SELF.is_lexid_used :=  ds_output2.is_lexid_used;
      SELF.base_match_codes :=  ds_output2.base_match_codes;
      SELF.actual_match_codes :=  ds_output2.actual_match_codes;
      SELF.exceptionreasoncode :=  ds_output2.exceptionreasoncode;
    END;
    ds_output4 := PROJECT(ds_output2, ds_output3(LEFT));

    tbl_summary := TABLE(ds_output4, {
        processed_date, is_working_day, targetnacgroupid, source_groupid,
        sourcestate,searchprogramcode, activitytype, is_online,
        casenacgroupid, casestate, caseprogramcode, clienteligibilitystatus,
        is_lexid_used, base_match_codes, actual_match_codes,exceptionreasoncode,
        instance_count := COUNT(GROUP)}, 
        processed_date, is_working_day, targetnacgroupid, source_groupid,
        sourcestate,searchprogramcode, activitytype, is_online,
        casenacgroupid, casestate, caseprogramcode, clienteligibilitystatus,
        is_lexid_used, base_match_codes, actual_match_codes,exceptionreasoncode);

      ds_summary := SORT(PROJECT(tbl_summary, TRANSFORM(NAC_V2.SQL_Layouts.MSH2FileMatchDataSQL,
          SELF.processed_date := LEFT.processed_date;
          SELF.working_day := LEFT.is_working_day;
          SELF.target_group_id := (STRING4)LEFT.targetnacgroupid;		
          SELF.left_group_id := (STRING4)LEFT.source_groupid;						
          SELF.left_orig_group_id := (STRING4)LEFT.source_groupid;					
          SELF.left_state := LEFT.sourcestate;
          SELF.left_program_code := LEFT.searchprogramcode;
          SELF.left_activity_type := LEFT.activitytype;      
          SELF.is_online := LEFT.is_online;      
          SELF.right_group_id := LEFT.casenacgroupid;
          SELF.right_orig_group_id := LEFT.casenacgroupid;
          SELF.right_state := LEFT.casestate;
          SELF.right_program_code := LEFT.caseprogramcode;
          SELF.right_eligibility_status := LEFT.clienteligibilitystatus;
          SELF.is_lexid_used := LEFT.is_lexid_used;
          SELF.base_match_codes := LEFT.base_match_codes;
          SELF.actual_match_codes := LEFT.actual_match_codes;
          SELF.exception_reason_code := LEFT.exceptionreasoncode;
          SELF.instance_count := LEFT.instance_count;
      )), instance_count);

    // OUTPUT(ds_MSH2_intermediate, NAMED('ds_MSH2_intermediate'));
    // OUTPUT(ds_output2, NAMED('ds_output2'));
    // OUTPUT(ds_output4, NAMED('ds_output4'));
    // OUTPUT(CHOOSEN(tbl_summary(activitytype='3'),100), NAMED('tbl_summary_3'));
    // OUTPUT(CHOOSEN(tbl_summary(activitytype='1'),100), NAMED('tbl_summary_1'));
    // OUTPUT(CHOOSEN(tbl_summary(activitytype='4'),100), NAMED('tbl_summary_4'));
   //  OUTPUT(CHOOSEN(ds_summary, 5000), NAMED('ds_summary'));
    RETURN NAC_V2.SQL_Helpers.fn_AddMSH2MetadataToTable(ds_summary);
  END;











  EXPORT NCF2_load := FUNCTION


    rl_ncd2_ext := RECORD
        STRING    uber_full_filename;
        STRING    ncf2_filename;
        UNSIGNED8  recordcount;
        BOOLEAN  loaded;        
      END;

      rl_ncd2_ext x (FsLogicalFileNameRecord l) := TRANSFORM
        SELF.uber_full_filename := '~' + l.name;
        SELF.ncf2_filename :=  std.str.FindReplace(l.name, 'nac::uber::in::nac2','ncf2');
        SELF.recordcount := fn_NCD2_rowcount('~' + l.name);
        SELF.loaded :=  IF((COUNT(NAC_V2.SQL_Helpers.fn_GetNCF2FileNameFromTable(std.str.FindReplace(l.name, 'nac::uber::in::nac2','ncf2'))) = 0),
             FALSE, TRUE);
        SELF := l;
      END;


      load_ncf2 := FUNCTION

      uber_in_nac2_before := CHOOSEN(SORT(PROJECT(NOTHOR(STD.File.LogicalFileList('*nac::uber::in::nac2_*.dat')), {LEFT.name}), -name), 5);
   
      ds_file_list_before := PROJECT(uber_in_nac2_before, x(LEFT));

      OUTPUT(ds_file_list_before, NAMED('NCF2_load_report_before'));


      IF((COUNT(NAC_V2.SQL_Helpers.fn_GetNCF2FileNameFromTable(ds_file_list_before[5].ncf2_filename)) = 0), 
        fn_InsertNCF2MetadataToMySQL(ds_file_list_before[5].uber_full_filename));

      IF((COUNT(NAC_V2.SQL_Helpers.fn_GetNCF2FileNameFromTable(ds_file_list_before[4].ncf2_filename)) = 0), 
        fn_InsertNCF2MetadataToMySQL(ds_file_list_before[4].uber_full_filename));

      IF((COUNT(NAC_V2.SQL_Helpers.fn_GetNCF2FileNameFromTable(ds_file_list_before[3].ncf2_filename)) = 0), 
        fn_InsertNCF2MetadataToMySQL(ds_file_list_before[3].uber_full_filename));

      IF((COUNT(NAC_V2.SQL_Helpers.fn_GetNCF2FileNameFromTable(ds_file_list_before[2].ncf2_filename)) = 0), 
        fn_InsertNCF2MetadataToMySQL(ds_file_list_before[2].uber_full_filename));

      IF((COUNT(NAC_V2.SQL_Helpers.fn_GetNCF2FileNameFromTable(ds_file_list_before[1].ncf2_filename)) = 0), 
        fn_InsertNCF2MetadataToMySQL(ds_file_list_before[1].uber_full_filename));

    RETURN 0;
    END;
  


      ncf2_report_after := 
    OUTPUT(PROJECT(CHOOSEN(SORT(NOTHOR(STD.File.LogicalFileList('*nac::uber::in::nac2_*.dat')), -name), 5), x(LEFT)), NAMED('NCF2_load_report_after'));
    

    RETURN SEQUENTIAL(load_ncf2, ncf2_report_after);

  END;





EXPORT MSX2_load := FUNCTION
      

      rl_ext := RECORD
        STRING      MSX2_file_name;       
        STRING      file_date;
        UNSIGNED8   rowcount;  
        BOOLEAN     loaded;        
      END;

      rl_ext x(FsLogicalFileNameRecord l) := TRANSFORM
        SELF.MSX2_file_name := '~' + l.name;       
        SELF.file_date := NAC_V2.SQL_Helpers.fValidSQLDate(l.name[40..47]); 
        SELF.rowcount := fn_MSX2_rowcount('~' + l.name);
        SELF.loaded :=  IF(COUNT(NAC_V2.SQL_Helpers.fn_GetMSX2ProcessedDate(NAC_V2.SQL_Helpers.fValidSQLDate(l.name[40..47])))<1, FALSE, TRUE);         
      END;
      


load_msx2 := FUNCTION
      FsLogicalFileNameRecord for_msh2_before := CHOOSEN(SORT(NOTHOR(STD.File.LogicalFileList('*nac::nac2::for_msh2::msx2_intermediate*')), -name), 5);
 
      ds_file_list_before := PROJECT(for_msh2_before, x(LEFT));


      OUTPUT(ds_file_list_before, NAMED('MSX2_load_report_before'));


      IF(ds_file_list_before[5].loaded = FALSE , 
        fn_InsertMSX2ToMySQL(ds_file_list_before[5].MSX2_file_name));

      IF(ds_file_list_before[4].loaded = FALSE , 
        fn_InsertMSX2ToMySQL(ds_file_list_before[4].MSX2_file_name));

      IF(ds_file_list_before[3].loaded = FALSE ,  
        fn_InsertMSX2ToMySQL(ds_file_list_before[3].MSX2_file_name));

      IF(ds_file_list_before[2].loaded = FALSE , 
        fn_InsertMSX2ToMySQL(ds_file_list_before[2].MSX2_file_name));

      IF(ds_file_list_before[1].loaded = FALSE ,  
        fn_InsertMSX2ToMySQL(ds_file_list_before[1].MSX2_file_name));

  RETURN 0;
END;

    msx2_report_after := 
    OUTPUT(PROJECT(CHOOSEN(SORT(NOTHOR(STD.File.LogicalFileList('*nac::nac2::for_msh2::msx2_intermediate*')), -name), 5), x(LEFT)), NAMED('MSX2_load_report_after'));
    

    RETURN SEQUENTIAL (load_msx2, msx2_report_after);

  END;





EXPORT MSH2_load := FUNCTION
      

      rl_ext := RECORD
        STRING      MSH2_file_name;       
        STRING      file_date;
        UNSIGNED8   rowcount;  
        BOOLEAN     loaded;        
      END;



      rl_ext x(FsLogicalFileNameRecord l) := TRANSFORM
        SELF.MSH2_file_name := '~' + l.name;       
        SELF.file_date := NAC_V2.SQL_Helpers.fValidSQLDate(l.name[40..47]); 
        SELF.rowcount := fn_MSH2_rowcount('~' + l.name);
        SELF.loaded :=  IF(COUNT(NAC_V2.SQL_Helpers.fn_GetMSH2ProcessedDate(NAC_V2.SQL_Helpers.fValidSQLDate(l.name[40..47])))<1, FALSE, TRUE);         
      END;
      


  load_msh2 := FUNCTION
      FsLogicalFileNameRecord for_msh2_before := CHOOSEN(SORT(NOTHOR(STD.File.LogicalFileList('*nac::nac2::for_msh2::msh2_intermediate*')), -name), 5);
 
      ds_file_list_before := PROJECT(for_msh2_before, x(LEFT));

      OUTPUT(ds_file_list_before, NAMED('MSH2_load_report_before'));

      IF(ds_file_list_before[5].loaded = FALSE , 
        fn_AddMSH2MetadataToMySQL(ds_file_list_before[5].MSH2_file_name));

      IF(ds_file_list_before[4].loaded = FALSE , 
        fn_AddMSH2MetadataToMySQL(ds_file_list_before[4].MSH2_file_name));

      IF(ds_file_list_before[3].loaded = FALSE ,  
        fn_AddMSH2MetadataToMySQL(ds_file_list_before[3].MSH2_file_name));

      IF(ds_file_list_before[2].loaded = FALSE , 
        fn_AddMSH2MetadataToMySQL(ds_file_list_before[2].MSH2_file_name));

      IF(ds_file_list_before[1].loaded = FALSE ,  
        fn_AddMSH2MetadataToMySQL(ds_file_list_before[1].MSH2_file_name));


// OUTPUT(ds_file_list_before[1].MSH2_file_name, NAMED('O1'));
// OUTPUT(NAC_V2.SQL_Helpers.fn_GetMSH2ProcessedDate(NAC_V2.SQL_Helpers.fValidSQLDate(ds_file_list_before[1].MSH2_file_name[41..48])), NAMED('D1'));
// OUTPUT(ds_file_list_before[2].MSH2_file_name, NAMED('O2'));
// OUTPUT(NAC_V2.SQL_Helpers.fn_GetMSH2ProcessedDate(NAC_V2.SQL_Helpers.fValidSQLDate(ds_file_list_before[2].MSH2_file_name[41..48])),  NAMED('D2'));
// OUTPUT(ds_file_list_before[3].MSH2_file_name, NAMED('O3'));
// OUTPUT(NAC_V2.SQL_Helpers.fn_GetMSH2ProcessedDate(NAC_V2.SQL_Helpers.fValidSQLDate(ds_file_list_before[3].MSH2_file_name[41..48])),  NAMED('D3'));
// OUTPUT(ds_file_list_before[4].MSH2_file_name, NAMED('O4'));
// OUTPUT(NAC_V2.SQL_Helpers.fn_GetMSH2ProcessedDate(NAC_V2.SQL_Helpers.fValidSQLDate(ds_file_list_before[4].MSH2_file_name[41..48])),  NAMED('D4'));
// OUTPUT(ds_file_list_before[5].MSH2_file_name, NAMED('O5'));
// OUTPUT(NAC_V2.SQL_Helpers.fn_GetMSH2ProcessedDate(NAC_V2.SQL_Helpers.fValidSQLDate(ds_file_list_before[5].MSH2_file_name[41..48])),  NAMED('D5'));




  RETURN 0;
END;

    msh2_report_after := 
    OUTPUT(PROJECT(CHOOSEN(SORT(NOTHOR(STD.File.LogicalFileList('*nac::nac2::for_msh2::msh2_intermediate*')), -name), 5), x(LEFT)), NAMED('MSH2_load_report_after'));
    

    RETURN SEQUENTIAL (load_msh2, msh2_report_after);

  END;


 
END;



