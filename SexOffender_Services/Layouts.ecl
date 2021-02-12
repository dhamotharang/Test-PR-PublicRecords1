IMPORT Address, BatchShare, SexOffender, iesp, FFD;
EXPORT Layouts := MODULE
  SHARED spk_key_rec := RECORDOF(SexOffender.Key_SexOffender_SPK ());  
  EXPORT search := RECORD
    spk_key_rec.seisint_primary_key;
    BOOLEAN isDeepDive := FALSE;
    TYPEOF(BatchShare.Layouts.ShareAcct.AcctNo) acctno := ''; // For FFD batch
  END;

  EXPORT search_did := RECORD
    UNSIGNED6 did;
    BOOLEAN isDeepDive := FALSE;
  END;
 
  EXPORT rec_offense_plus_acctno := RECORD
    TYPEOF(BatchShare.Layouts.ShareAcct.AcctNo) acctno := ''; // For FFD batch
    RECORDOF(SexOffender.key_sexoffender_offenses);
    
  END;
  EXPORT raw_rec := RECORD
    spk_key_rec;
    BOOLEAN isDeepDive := FALSE;
    UNSIGNED2 penalt := 0;
    UNSIGNED2 penalt_osmt := 0; //penalty for offenses, scars, marks AND tattoos.
    iesp.sexualoffender.t_OffenderBestAddress bestaddress;
    iesp.share.t_GeoLocationMatch bestlocation;
    FFD.Layouts.CommonRawRecordElements;
    TYPEOF(BatchShare.Layouts.ShareAcct.AcctNo) acctno := ''; //for FFD batch
  END;
  EXPORT rec_offense_raw := RECORD(rec_offense_plus_acctno)
   FFD.Layouts.CommonRawRecordElements; //FCRA FFD BATCH
  END;
  
  /* Temp layout with additional fields used for hash calculation for alerts */
  EXPORT t_OffenderRecord_plus := RECORD(iesp.sexualoffender_fcra.t_FcraOffenderRecord)
    STRING50 name_orig := '';
    STRING40 offender_category := '';
    STRING8 reg_date_1 := '';
    STRING125 registration_address_1 := '';
    STRING45 registration_address_2 := '';
    STRING35 registration_address_3 := '';
    STRING35 registration_address_4 := '';
    STRING35 registration_address_5 := '';
    STRING35 registration_county := '';
  END;
  
  EXPORT batch_in := RECORD
    BatchShare.Layouts.ShareAcct;
    BatchShare.Layouts.ShareDid;
    BatchShare.Layouts.ShareName;
    BatchShare.Layouts.ShareAddress;
    BatchShare.Layouts.SharePII;
  END;
  
  EXPORT lookup_id_rec := RECORD
    BatchShare.Layouts.ShareAcct;
    SexOffender.Layout_Out_Main.seisint_primary_key;
    BOOLEAN isDeepDive := FALSE;
  END;
  
  EXPORT rec_offender_plus_acctno := RECORD
    BatchShare.Layouts.ShareAcct;
    SexOffender.layout_out_main;
    BOOLEAN isDeepDive := FALSE;
    UNSIGNED3 penalt := 0;
    FFD.Layouts.CommonRawRecordElements; //FCRA FFD BATCH
    FFD.Layouts.ConsumerFlags; //FCRA FFD BATCH
  END;
  

  EXPORT layout_inBatchMaster_for_penalties := RECORD
    BatchShare.Layouts.ShareCommonPenalty;
    STRING12 _ssn := '';
    STRING8 _dob := '';
    STRING10 _homephone := '';
    STRING16 _workphone := '';
  END;

  EXPORT batch_out := RECORD
    BatchShare.Layouts.ShareAcct;
    SexOffender.Layout_Out_Main.seisint_primary_key;
    STRING30 last_name := '';
    STRING30 first_name := '';
    STRING20 middle_name := '';
    STRING20 name_suffix := '';
    STRING125 address_1 := '';
    STRING45 address_2 := '';
    STRING35 address_3 := '';
    STRING8 date_last_seen := '';
    STRING9 ssn := '';
    STRING10 sex := '';
    STRING8 dob := '';
    STRING40 hair_color := '';
    STRING40 eye_color := '';
    STRING200 scars := '';
    STRING3 height := '';
    STRING3 weight := '';
    STRING30 race := '';
    STRING30 offender_id := '';
    STRING2 state_of_origin := '';
        
    STRING340 offense_1 := '';
    STRING110 conviction_place_1 := '';
    STRING8 conviction_date_1 := '';
    STRING1 victim_minor_1 := '';
    STRING80 conviction_jurisdiction_1 := '';
    STRING25 court_case_number_1 := '';
    STRING8 offense_date_1 := '';
    
    STRING340 offense_2 := '';
    STRING110 conviction_place_2 := '';
    STRING8 conviction_date_2 := '';
    STRING1 victim_minor_2 := '';
    STRING80 conviction_jurisdiction_2 := '';
    STRING25 court_case_number_2 := '';
    STRING8 offense_date_2 := '';
    
    STRING340 offense_3 := '';
    STRING110 conviction_place_3 := '';
    STRING8 conviction_date_3 := '';
    STRING1 victim_minor_3 := '';
    STRING80 conviction_jurisdiction_3 := '';
    STRING25 court_case_number_3 := '';
    STRING8 offense_date_3 := '';
    
    STRING340 offense_4 := '';
    STRING110 conviction_place_4 := '';
    STRING8 conviction_date_4 := '';
    STRING1 victim_minor_4 := '';
    STRING80 conviction_jurisdiction_4 := '';
    STRING25 court_case_number_4 := '';
    STRING8 offense_date_4 := '';
    
    STRING340 offense_5 := '';
    STRING110 conviction_place_5 := '';
    STRING8 conviction_date_5 := '';
    STRING1 victim_minor_5 := '';
    STRING80 conviction_jurisdiction_5 := '';
    STRING25 court_case_number_5 := '';
    STRING8 offense_date_5 := '';
    
    STRING340 offense_6 := '';
    STRING110 conviction_place_6 := '';
    STRING8 conviction_date_6 := '';
    STRING1 victim_minor_6 := '';
    STRING80 conviction_jurisdiction_6 := '';
    STRING25 court_case_number_6 := '';
    STRING8 offense_date_6 := '';
    
    STRING340 offense_7 := '';
    STRING110 conviction_place_7 := '';
    STRING8 conviction_date_7 := '';
    STRING1 victim_minor_7 := '';
    STRING80 conviction_jurisdiction_7 := '';
    STRING25 court_case_number_7 := '';
    STRING8 offense_date_7 := '';
    
    STRING340 offense_8 := '';
    STRING110 conviction_place_8 := '';
    STRING8 conviction_date_8 := '';
    STRING1 victim_minor_8 := '';
    STRING80 conviction_jurisdiction_8 := '';
    STRING25 court_case_number_8 := '';
    STRING8 offense_date_8 := '';
    
    STRING340 offense_9 := '';
    STRING110 conviction_place_9 := '';
    STRING8 conviction_date_9 := '';
    STRING1 victim_minor_9 := '';
    STRING80 conviction_jurisdiction_9 := '';
    STRING25 court_case_number_9 := '';
    STRING8 offense_date_9 := '';
    
    STRING340 offense_10 := '';
    STRING110 conviction_place_10 := '';
    STRING8 conviction_date_10 := '';
    STRING1 victim_minor_10 := '';
    STRING80 conviction_jurisdiction_10 := '';
    STRING25 court_case_number_10 := '';
    STRING8 offense_date_10 := '';
    
    STRING1 curr_incar_flag := '';
    STRING1 curr_parole_flag := '';
    STRING1 curr_probation_flag := '';
    STRING30 doc_number := '';
    Address.Layout_Address_Clean_Components.prim_range;
    Address.Layout_Address_Clean_Components.predir;
    Address.Layout_Address_Clean_Components.prim_name;
    Address.Layout_Address_Clean_Components.addr_suffix;
    Address.Layout_Address_Clean_Components.postdir;
    Address.Layout_Address_Clean_Components.unit_desig;
    Address.Layout_Address_Clean_Components.sec_range;
    Address.Layout_Address_Clean_Components.p_city_name;
    Address.Layout_Address_Clean_Components.v_city_name;
    Address.Layout_Address_Clean_Components.st;
    Address.Layout_Address_Clean_Components.zip5;
    Address.Layout_Address_Clean_Components.zip4;
    Address.Layout_Address_Clean_Components.clean_errors;
    STRING35 registration_county := '';
    
    Batchshare.layouts.ShareErrors;
    UNSIGNED SequenceNumber :=0; // FCRA FFD
    FFD.Layouts.ConsumerFlags;
    SexOffender.Layout_Out_Main.did;
    STRING12 inquiry_lexid := '';
  END;
  EXPORT batch_out_pre := RECORD(batch_out) //FCRA FFD
    DATASET (FFD.Layouts.ConsumerStatementBatch) statements;
    FFD.Layouts.CommonRawRecordElements;
  END;
  
END;
