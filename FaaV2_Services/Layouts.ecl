IMPORT faa, iesp, BatchShare, doxie, BIPV2, FFD, doxie_crs;
  
EXPORT Layouts := MODULE
  
  EXPORT batch_in := RECORD
    doxie.layout_inBatchMaster;  
    BatchShare.Layouts.ShareAddress.addr; // some common batch procedures require address line 1
    BIPV2.IDlayouts.l_header_ids; // linkids;
  END;
  
  EXPORT batch_raw := RECORD
    string12    best_ssn;
    string12  did_out;  
    String12  bdid_out;
    BIPV2.IDlayouts.l_header_ids; // linkids;
    
    string11   fract_owner;

    //Unparsed owner  Info 
    string15   type_registrant;
    string50   name;
    string33   street;
    string33   street2;
    string18   city;
    string5   state;
    string10   zip_code;
    string20   region;
    string18  county_name;  
    string7   country;  
    
    //Parsed Owner info  
    string5   title;
    string20   fname;
    string20   mname;
    string20   lname;
    string5   name_suffix;
    string50   compname;  
    string10   prim_range;
    string2   predir;
    string28   prim_name;
    string4   addr_suffix;
    string2   postdir;
    string10   unit_desig;
    string8   sec_range;
    string25   p_city_name;
    string25   v_city_name;
    string2   st;
    string5   zip;
    string4   z4;

           //AIRCRAFT info
    string15   current_flag_1;
    string8   n_number_1;
    string30   serial_number_1;
    string12   mfr_mdl_code_1;
    string8   year_mfr_1;
    string16   last_action_date_1;
    string15   cert_issue_date_1;
    string20   certification_1;
    string11   mode_s_code_1;  
    string7   aircraft_mfr_model_code_1;
    string30   aircraft_mfr_name_1;
    string20   ac_model_name_1;
    string2   number_of_engines_1;
    string3   number_of_seats_1;
    string35   aircraft_weight_1;
    string4   aircraft_cruising_speed_1;
    string20  engine_type_mapped_1;
    string40  aircraft_type_mapped_1;
    string20  category_mapped_1;
    string30  amateur_certification_mapped_1;
    
          //ENGINE info
    string5   engine_mfr_model_code_1;
    string10  engine_mfr_name_1;
    string13   eng_model_name_1;
    string5   engine_hp_or_thrust_1;
    string6   fuel_consumed_1;
    

    //AIRCRAFT info
    string15   current_flag_2;
    string8   n_number_2;
    string30   serial_number_2;
    string12   mfr_mdl_code_2;
    string8   year_mfr_2;
    string16   last_action_date_2;
    string15   cert_issue_date_2;
    string20   certification_2;
    string11   mode_s_code_2;  
    string7   aircraft_mfr_model_code_2;
    string30   aircraft_mfr_name_2;
    string20   ac_model_name_2;
    string2   number_of_engines_2;
    string3   number_of_seats_2;
    string35   aircraft_weight_2;
    string4   aircraft_cruising_speed_2;
    string20  engine_type_mapped_2;
    string40  aircraft_type_mapped_2;
    string20  category_mapped_2;
    string30  amateur_certification_mapped_2;
    
          //ENGINE info
    string5   engine_mfr_model_code_2;
    string10  engine_mfr_name_2;
    string13   eng_model_name_2;
    string5   engine_hp_or_thrust_2;
    string6   fuel_consumed_2;

    //AIRCRAFT info
    string15   current_flag_3;
    string8   n_number_3;
    string30   serial_number_3;
    string12   mfr_mdl_code_3;
    string8   year_mfr_3;
    string16   last_action_date_3;
    string15   cert_issue_date_3;
    string20   certification_3;
    string11   mode_s_code_3;  
    string7   aircraft_mfr_model_code_3;
    string30   aircraft_mfr_name_3;
    string20   ac_model_name_3;
    string2   number_of_engines_3;
    string3   number_of_seats_3;
    string35   aircraft_weight_3;
    string4   aircraft_cruising_speed_3;
    string20  engine_type_mapped_3;
    string40  aircraft_type_mapped_3;
    string20  category_mapped_3;
    string30  amateur_certification_mapped_3;
    
    //ENGINE info
    // string8   filedate_3;
    string5   engine_mfr_model_code_3;
    string10  engine_mfr_name_3;
    string13   eng_model_name_3;
    string5   engine_hp_or_thrust_3;
    string6   fuel_consumed_3;  
    
    //AIRCRAFT info
    string15   current_flag_4;
    string8   n_number_4;
    string30   serial_number_4;
    string12   mfr_mdl_code_4;
    string8   year_mfr_4;
    string16   last_action_date_4;
    string15   cert_issue_date_4;
    string20   certification_4;
    string11   mode_s_code_4;  
    string7   aircraft_mfr_model_code_4;
    string30   aircraft_mfr_name_4;
    string20   ac_model_name_4;
    string2   number_of_engines_4;
    string3   number_of_seats_4;
    string35   aircraft_weight_4;
    string4   aircraft_cruising_speed_4;
    string20  engine_type_mapped_4;
    string40  aircraft_type_mapped_4;
    string20  category_mapped_4;
    string30  amateur_certification_mapped_4;
    
    //ENGINE info
    string5   engine_mfr_model_code_4;
    string10  engine_mfr_name_4;
    string13   eng_model_name_4;
    string5   engine_hp_or_thrust_4;
    string6   fuel_consumed_4;    

    //AIRCRAFT info
    string15   current_flag_5;
    string8   n_number_5;
    string30   serial_number_5;
    string12   mfr_mdl_code_5;
    string8   year_mfr_5;
    string16   last_action_date_5;
    string15   cert_issue_date_5;
    string20   certification_5;
    string11   mode_s_code_5;  
    string7   aircraft_mfr_model_code_5;
    string30   aircraft_mfr_name_5;
    string20   ac_model_name_5;
    string2   number_of_engines_5;
    string3   number_of_seats_5;
    string35   aircraft_weight_5;
    string4   aircraft_cruising_speed_5;
    string20  engine_type_mapped_5;
    string40  aircraft_type_mapped_5;
    string20  category_mapped_5;
    string30  amateur_certification_mapped_5;
    
    //ENGINE info
    string5   engine_mfr_model_code_5;
    string10  engine_mfr_name_5;
    string13   eng_model_name_5;
    string5   engine_hp_or_thrust_5;
    string6   fuel_consumed_5;  
  END;
  
  // final batch output
  EXPORT batch_out := RECORD
    doxie.layout_inBatchMaster.acctno;
    batch_raw;
    Batchshare.layouts.ShareErrors;
    unsigned SequenceNumber := 0;
		FFD.Layouts.ConsumerFlags;
    string12 inquiry_lexid := '';
  END;    
  
  EXPORT batch_out_pre := RECORD(batch_out)
    DATASET (FFD.Layouts.ConsumerStatementBatch) statements;
	  string2 source;
  END;
  
  //
  // faav2_services (aircraft) search service records info
  //

  // access to a raw data is by "aircraft_id":
  EXPORT search_id := RECORD
    unsigned6 aircraft_id;
    boolean isDeepDive := false;
  END;
    

  EXPORT aircraftNumberPlus := RECORD
    string8 n_number;
    unsigned6 did;
    unsigned6 bdid;
    search_id;
    unsigned8 persistent_record_id:=0;
    BIPV2.IDlayouts.l_header_ids;
  END;

  EXPORT rawrec := RECORD(FFD.Layouts.CommonRawRecordElements)
    recordof(faa.Key_Aircraft_Reg_NNum); //faa.layout_aircraft_registration_out_slim + aircraft_id
    BIPV2.IDlayouts.l_header_ids;
    boolean isDeepDive := false;
    unsigned2 penalt := 0;
    string18 county_name := '';
  END;
        
  EXPORT t_AircraftRecordWithPenalty := RECORD
    iesp.faaaircraft_Fcra.t_FcraAircraftRecord;
    unsigned6 aircraft_id := 0;
  END;
  
  // TopBusiness_Services.SourceService layout
  EXPORT source_ids := RECORD
   string8 n_number;
   string8 source_date;
  END;
        
  export aircraft_detail := record
		doxie_crs.layout_FAR_aircraft - [engine_type_mapped, aircraft_type_mapped, category_mapped, amateur_certification_mapped, aircraft_weight_mapped];
	end;
	
	export aircraft_engine := record
		doxie_crs.layout_FAR_engine - [engine_type_mapped];
	end;
				
	export aircraft_full := record 
		unsigned6 aircraft_id := 0;
		faa.layout_aircraft_registration_out_slim aircraft;
		BIPV2.IDlayouts.l_header_ids;
		string18  county_name;
		aircraft_detail detail;
		aircraft_engine engine;
		FFD.Layouts.CommonRawRecordElements;
	end;
        
END;