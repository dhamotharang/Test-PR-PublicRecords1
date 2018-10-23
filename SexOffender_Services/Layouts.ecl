import Address, BatchShare, SexOffender, iesp, FFD;
	
export Layouts := MODULE
	shared spk_key_rec := recordof(SexOffender.Key_SexOffender_SPK ());
	
	export search := record
	  spk_key_rec.seisint_primary_key;
		boolean isDeepDive := false;
		typeof(BatchShare.Layouts.ShareAcct.AcctNo) acctno := ''; // For FFD batch
	end;

	export search_did := record
		unsigned6 did;
		boolean isDeepDive := false;
	end;
 
  EXPORT rec_offense_plus_acctno := RECORD
		typeof(BatchShare.Layouts.ShareAcct.AcctNo) acctno := ''; // For FFD batch
		recordof(SexOffender.key_sexoffender_offenses);
		
	END;
	
	export raw_rec := record
	  spk_key_rec;
		boolean isDeepDive := false;
		unsigned2 penalt := 0;
		unsigned2 penalt_osmt := 0; //penalty for offenses, scars, marks and tattoos.
		iesp.sexualoffender.t_OffenderBestAddress bestaddress;
		iesp.share.t_GeoLocationMatch bestlocation;
		FFD.Layouts.CommonRawRecordElements;
		typeof(BatchShare.Layouts.ShareAcct.AcctNo) acctno := ''; //for FFD batch
	end;
	
	
	EXPORT rec_offense_raw := RECORD(rec_offense_plus_acctno)
	 FFD.Layouts.CommonRawRecordElements;  //FCRA FFD BATCH

	END;
	
  /* Temp layout with additional fields used for hash calculation for alerts */
	export t_OffenderRecord_plus := record(iesp.sexualoffender_fcra.t_FcraOffenderRecord)
	  string50 	name_orig := '';
    string40 	offender_category := '';
		string8 	reg_date_1 := '';
    string125	registration_address_1 := '';
    string45 	registration_address_2 := '';
    string35 	registration_address_3 := '';
    string35 	registration_address_4 := '';
    string35 	registration_address_5 := '';
    string35 	registration_county := '';
	end;
	
	EXPORT batch_in := record
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDid;
		BatchShare.Layouts.ShareName;
		BatchShare.Layouts.ShareAddress;
		BatchShare.Layouts.SharePII;
	end;
	
	EXPORT lookup_id_rec := record
		BatchShare.Layouts.ShareAcct;
		SexOffender.Layout_Out_Main.seisint_primary_key;
		BOOLEAN isDeepDive           := FALSE;
	end;
	
	EXPORT rec_offender_plus_acctno := RECORD
		BatchShare.Layouts.ShareAcct;
		SexOffender.layout_out_main;
		BOOLEAN isDeepDive := FALSE;
		UNSIGNED3 penalt := 0;
		FFD.Layouts.CommonRawRecordElements; //FCRA FFD BATCH
		FFD.Layouts.ConsumerFlags; //FCRA FFD BATCH
	END;
	

	EXPORT layout_inBatchMaster_for_penalties := record

		BatchShare.Layouts.ShareCommonPenalty;

		STRING12		_ssn         := '';
		STRING8			_dob         := '';
		STRING10  	_homephone   := '';
		STRING16		_workphone   := '';

	END;

	EXPORT batch_out := RECORD
		BatchShare.Layouts.ShareAcct;
		SexOffender.Layout_Out_Main.seisint_primary_key;
		
		STRING30  last_name           := '';
		STRING30  first_name          := '';
		STRING20  middle_name         := '';
		STRING20  name_suffix         := '';
		STRING125 address_1           := '';
		STRING45  address_2           := '';
		STRING35  address_3           := '';
		STRING8   date_last_seen      := '';
		STRING9   ssn                 := '';
		STRING10  sex                 := '';
		STRING8   dob                 := '';
		STRING40  hair_color          := '';
		STRING40  eye_color           := '';
		STRING200 scars               := '';
		STRING3   height              := '';
		STRING3   weight              := '';
		STRING30  race                := '';
		STRING30  offender_id         := '';
		STRING2   state_of_origin     := '';
				
		string340 offense_1           := '';
		string110 conviction_place_1  := '';
		string8   conviction_date_1   := '';
		string1   victim_minor_1      := '';
		string80 	conviction_jurisdiction_1 := '';
		string25 	court_case_number_1 := '';
		string8  	offense_date_1 := '';
		
		string340 offense_2           := '';
		string110 conviction_place_2  := '';
		string8   conviction_date_2   := '';
		string1   victim_minor_2      := '';	
		string80 	conviction_jurisdiction_2 := '';
		string25 	court_case_number_2 := '';
		string8  	offense_date_2 := '';
		
		string340 offense_3           := '';
		string110 conviction_place_3  := '';
		string8   conviction_date_3   := '';
		string1   victim_minor_3      := '';	
		string80 	conviction_jurisdiction_3 := '';
		string25 	court_case_number_3 := '';
		string8  	offense_date_3 := '';
		
		string340 offense_4           := '';
		string110 conviction_place_4  := '';
		string8   conviction_date_4   := '';
		string1   victim_minor_4      := '';	
		string80 	conviction_jurisdiction_4 := '';
		string25 	court_case_number_4 := '';
		string8  	offense_date_4 := '';
		
		string340 offense_5           := '';
		string110 conviction_place_5  := '';
		string8   conviction_date_5   := '';
		string1   victim_minor_5      := '';	
		string80 	conviction_jurisdiction_5 := '';
		string25 	court_case_number_5 := '';
		string8  	offense_date_5 := '';
		
		string340 offense_6           := '';
		string110 conviction_place_6  := '';
		string8   conviction_date_6   := '';
		string1   victim_minor_6      := '';	
		string80 	conviction_jurisdiction_6 := '';
		string25 	court_case_number_6 := '';
		string8  	offense_date_6 := '';
		
		string340 offense_7           := '';
		string110 conviction_place_7  := '';
		string8   conviction_date_7   := '';
		string1   victim_minor_7      := '';	
		string80 	conviction_jurisdiction_7 := '';
		string25 	court_case_number_7 := '';
		string8  	offense_date_7 := '';
		
		string340 offense_8           := '';
		string110 conviction_place_8  := '';
		string8   conviction_date_8   := '';
		string1   victim_minor_8      := '';	
		string80 	conviction_jurisdiction_8 := '';
		string25 	court_case_number_8 := '';
		string8  	offense_date_8 := '';
		
		string340 offense_9           := '';
		string110 conviction_place_9  := '';
		string8   conviction_date_9   := '';
		string1   victim_minor_9      := '';
		string80 	conviction_jurisdiction_9 := '';
		string25 	court_case_number_9 := '';
		string8  	offense_date_9 := '';
		
		string340 offense_10          := '';
		string110 conviction_place_10 := '';
		string8   conviction_date_10  := '';
		string1   victim_minor_10     := '';
		string80 	conviction_jurisdiction_10 := '';
		string25 	court_case_number_10 := '';
		string8  	offense_date_10 := '';
		
		string1   curr_incar_flag := '';
		string1   curr_parole_flag := '';
		string1   curr_probation_flag := '';
		string30 	doc_number := '';
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
		string35 	registration_county := '';
		
		Batchshare.layouts.ShareErrors;
		unsigned SequenceNumber :=0;  // FCRA FFD
		FFD.Layouts.ConsumerFlags;
		SexOffender.Layout_Out_Main.did;
    string12 inquiry_lexid := '';
	END;
  EXPORT batch_out_pre := RECORD(batch_out)            //FCRA FFD
	  DATASET (FFD.Layouts.ConsumerStatementBatch) statements;
    FFD.Layouts.CommonRawRecordElements;
	END;
	
END;
