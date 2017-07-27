
IMPORT FraudPoint_Services;

EXPORT Boca_Shell_FDN( GROUPED DATASET(Risk_Indicators.Layout_Input) input_iid ) := MODULE

	// Obtain all FDN records by DID, Address, Phone, and SSN.
	SHARED ds_IFD_recs_byDID   := FraudPoint_Services.Raw.get_IFD_recs_byDID_bocashell( input_iid );
	SHARED ds_IFD_recs_byAddr  := FraudPoint_Services.Raw.get_IFD_recs_byAddress_bocashell( input_iid );
	SHARED ds_IFD_recs_byPhone := FraudPoint_Services.Raw.get_IFD_recs_byPhone_bocashell( input_iid );
	SHARED ds_IFD_recs_bySSN   := FraudPoint_Services.Raw.get_IFD_recs_bySSN_bocashell( input_iid );

	// --------------------[ Calculate Test Fraud Database metrics. ]--------------------
	
	SHARED tf_IFD_recs_byDID   := ds_IFD_recs_byDID(source_identifier = 'TFD');
	SHARED tf_IFD_recs_byAddr  := ds_IFD_recs_byAddr(source_identifier = 'TFD');
	SHARED tf_IFD_recs_byPhone := ds_IFD_recs_byPhone(source_identifier = 'TFD');
	SHARED tf_IFD_recs_bySSN   := ds_IFD_recs_bySSN(source_identifier = 'TFD');
	
	// Count the number of records that match the DID, SSN, Phone, Addr.
	SHARED tbl_tf_IFD_recs_byDID := 
			TABLE( tf_IFD_recs_byDID, {seq, appended_lexid, num_recs_match_lexid := COUNT(GROUP)}, seq, appended_lexid );

	SHARED tbl_tf_IFD_recs_bySSN := 
			TABLE( tf_IFD_recs_bySSN, {seq, ssn, num_recs_match_ssn := COUNT(GROUP)}, seq, ssn );
	
	SHARED tbl_tf_IFD_recs_byPhone := 
			TABLE( tf_IFD_recs_byPhone, {seq, phone_number, num_recs_match_phone := COUNT(GROUP)}, seq, phone_number );
	
	SHARED tbl_tf_IFD_recs_byAddr_pre := // "_pre" because more than one address variant can be returned.
			TABLE( tf_IFD_recs_byAddr, {seq, street_address, zip_code, num_recs_match_addr := COUNT(GROUP)}, seq, TRIM( (street_address + zip_code), ALL ) );
	
	SHARED tbl_tf_IFD_recs_byAddr := 
			ROLLUP( 
				SORT( tbl_tf_IFD_recs_byAddr_pre, seq ), 
				LEFT.seq = RIGHT.seq, 
				TRANSFORM( RECORDOF(tbl_tf_IFD_recs_byAddr_pre),
					SELF.seq                 := LEFT.seq, 
					SELF.street_address      := RIGHT.street_address,
					SELF.zip_code            := RIGHT.zip_code,
					SELF.num_recs_match_addr := LEFT.num_recs_match_addr + RIGHT.num_recs_match_addr
				)
			);
		
	// Count the number of unique billgroups reporting the DID, SSN, Phone, Addr.
	SHARED tbl_tf_billgrps_rpting_lexid_pre := 
			TABLE( tf_IFD_recs_byDID, {seq, customer_id, count_each_customer_id := COUNT(GROUP)}, seq, customer_id );

	SHARED tbl_tf_billgrps_rpting_lexid := 
			TABLE( tbl_tf_billgrps_rpting_lexid_pre, {seq, num_billgrps_rpting_lexid := COUNT(GROUP)}, seq );

	SHARED tbl_tf_billgrps_rpting_ssn_pre := 
			TABLE( tf_IFD_recs_bySSN, {seq, customer_id, count_each_customer_id := COUNT(GROUP)}, seq, customer_id );

	SHARED tbl_tf_billgrps_rpting_ssn := 
			TABLE( tbl_tf_billgrps_rpting_ssn_pre, {seq, num_billgrps_rpting_ssn := COUNT(GROUP)}, seq );

	SHARED tbl_tf_billgrps_rpting_phone_pre := 
			TABLE( tf_IFD_recs_byPhone, {seq, customer_id, count_each_customer_id := COUNT(GROUP)}, seq, customer_id );

	SHARED tbl_tf_billgrps_rpting_phone := 
			TABLE( tbl_tf_billgrps_rpting_phone_pre, {seq, num_billgrps_rpting_phone := COUNT(GROUP)}, seq );

	SHARED tbl_tf_billgrps_rpting_addr_pre := 
			TABLE( tf_IFD_recs_byAddr, {seq, customer_id, count_each_customer_id := COUNT(GROUP)}, seq, customer_id );

	SHARED tbl_tf_billgrps_rpting_addr := 
			TABLE( tbl_tf_billgrps_rpting_addr_pre, {seq, num_billgrps_rpting_addr := COUNT(GROUP)}, seq );

	// Transform into final layout.
	EXPORT layout_test_fraud := RECORD
		UNSIGNED4 seq;
		UNSIGNED3 tf_Lexid_count           := 0; // # of records in test fraud database that match the LexID
		UNSIGNED3 tf_ssn_count             := 0; // # of records in test fraud database that match the SSN
		UNSIGNED3 tf_phone_count           := 0; // # of records in test fraud database that match the phone
		UNSIGNED3 tf_addr_count            := 0; // # of records in test fraud database that match the address
		UNSIGNED3 tf_Lexid_billgroup_count := 0; // # of unique bill groups / customers in test fraud database that report the LexID
		UNSIGNED3 tf_ssn_billgroup_count   := 0; // # of unique bill groups / customers in test fraud database that report the SSN
		UNSIGNED3 tf_phone_billgroup_count := 0; // # of unique bill groups / customers in test fraud database that report the phone
		UNSIGNED3 tf_addr_billgroup_count  := 0; // # of unique bill groups / customers in test fraud database that report the address
	END;
	
	SHARED tf_with_Lexid := 
		JOIN(
			input_iid, tbl_tf_IFD_recs_byDID,
			LEFT.seq = RIGHT.seq,
			TRANSFORM( layout_test_fraud,
				SELF.tf_Lexid_count := RIGHT.num_recs_match_lexid,
				SELF := LEFT,
				SELF := []
			),
			LEFT OUTER
		);

	SHARED tf_with_ssn := 
		JOIN(
			tf_with_Lexid, tbl_tf_IFD_recs_bySSN,
			LEFT.seq = RIGHT.seq,
			TRANSFORM( layout_test_fraud,
				SELF.tf_ssn_count := RIGHT.num_recs_match_ssn,
				SELF := LEFT,
				SELF := []
			),
			LEFT OUTER
		);

	SHARED tf_with_phone := 
		JOIN(
			tf_with_ssn, tbl_tf_IFD_recs_byPhone,
			LEFT.seq = RIGHT.seq,
			TRANSFORM( layout_test_fraud,
				SELF.tf_phone_count := RIGHT.num_recs_match_phone,
				SELF := LEFT,
				SELF := []
			),
			LEFT OUTER
		);

	SHARED tf_with_addr := 
		JOIN(
			tf_with_phone, tbl_tf_IFD_recs_byAddr,
			LEFT.seq = RIGHT.seq,
			TRANSFORM( layout_test_fraud,
				SELF.tf_addr_count := RIGHT.num_recs_match_addr,
				SELF := LEFT,
				SELF := []
			),
			LEFT OUTER
		);

	SHARED tf_with_Lexid_billgroup_count := 
		JOIN(
			tf_with_addr, tbl_tf_billgrps_rpting_lexid,
			LEFT.seq = RIGHT.seq,
			TRANSFORM( layout_test_fraud,
				SELF.tf_Lexid_billgroup_count := RIGHT.num_billgrps_rpting_lexid,
				SELF := LEFT,
				SELF := []
			),
			LEFT OUTER
		);		

	SHARED tf_with_ssn_billgroup_count := 
		JOIN(
			tf_with_Lexid_billgroup_count, tbl_tf_billgrps_rpting_ssn,
			LEFT.seq = RIGHT.seq,
			TRANSFORM( layout_test_fraud,
				SELF.tf_ssn_billgroup_count := RIGHT.num_billgrps_rpting_ssn,
				SELF := LEFT,
				SELF := []
			),
			LEFT OUTER
		);		

	SHARED tf_with_phone_billgroup_count := 
		JOIN(
			tf_with_ssn_billgroup_count, tbl_tf_billgrps_rpting_phone,
			LEFT.seq = RIGHT.seq,
			TRANSFORM( layout_test_fraud,
				SELF.tf_phone_billgroup_count := RIGHT.num_billgrps_rpting_phone,
				SELF := LEFT,
				SELF := []
			),
			LEFT OUTER
		);		
		
	SHARED tf_with_addr_billgroup_count := 
		JOIN(
			tf_with_phone_billgroup_count, tbl_tf_billgrps_rpting_addr,
			LEFT.seq = RIGHT.seq,
			TRANSFORM( layout_test_fraud,
				SELF.tf_addr_billgroup_count := RIGHT.num_billgrps_rpting_addr,
				SELF := LEFT
			),
			LEFT OUTER
		);

	// --------------------[ Calculate Contributory Fraud Database metrics. ]--------------------

	SHARED cf_IFD_recs_byDID   := ds_IFD_recs_byDID(source_identifier = 'CFD');
	SHARED cf_IFD_recs_byAddr  := ds_IFD_recs_byAddr(source_identifier = 'CFD');
	SHARED cf_IFD_recs_byPhone := ds_IFD_recs_byPhone(source_identifier = 'CFD');
	SHARED cf_IFD_recs_bySSN   := ds_IFD_recs_bySSN(source_identifier = 'CFD');

	// Count the number of records that match the DID, SSN, Phone, Addr.
	SHARED tbl_cf_IFD_recs_byDID := 
			TABLE( cf_IFD_recs_byDID, {seq, appended_lexid, num_recs_match_lexid := COUNT(GROUP)}, seq, appended_lexid );
	
	SHARED tbl_cf_IFD_recs_bySSN := 
			TABLE( cf_IFD_recs_bySSN, {seq, ssn, num_recs_match_ssn := COUNT(GROUP)}, seq, ssn );
	
	SHARED tbl_cf_IFD_recs_byPhone := 
			TABLE( cf_IFD_recs_byPhone, {seq, phone_number, num_recs_match_phone := COUNT(GROUP)}, seq, phone_number );
	
	SHARED tbl_cf_IFD_recs_byAddr_pre := // "_pre" because more than one address variant can be returned.
			TABLE( cf_IFD_recs_byAddr, {seq, street_address, zip_code, num_recs_match_addr := COUNT(GROUP)}, seq, TRIM( (street_address + zip_code), ALL ) );

	SHARED tbl_cf_IFD_recs_byAddr := 
			ROLLUP( 
				SORT( tbl_cf_IFD_recs_byAddr_pre, seq ), 
				LEFT.seq = RIGHT.seq, 
				TRANSFORM( RECORDOF(tbl_cf_IFD_recs_byAddr_pre),
					SELF.seq                 := LEFT.seq, 
					SELF.street_address      := RIGHT.street_address,
					SELF.zip_code            := RIGHT.zip_code,
					SELF.num_recs_match_addr := LEFT.num_recs_match_addr + RIGHT.num_recs_match_addr
				)
			);
	
	// Count the number of unique billgroups reporting the DID, SSN, Phone, Addr.
	SHARED tbl_cf_billgrps_rpting_lexid_pre := 
			TABLE( cf_IFD_recs_byDID, {seq, customer_id, count_each_customer_id := COUNT(GROUP)}, seq, customer_id );

	SHARED tbl_cf_billgrps_rpting_lexid := 
			TABLE( tbl_cf_billgrps_rpting_lexid_pre, {seq, num_billgrps_rpting_lexid := COUNT(GROUP)}, seq );

	SHARED tbl_cf_billgrps_rpting_ssn_pre := 
			TABLE( cf_IFD_recs_bySSN, {seq, customer_id, count_each_customer_id := COUNT(GROUP)}, seq, customer_id );

	SHARED tbl_cf_billgrps_rpting_ssn := 
			TABLE( tbl_cf_billgrps_rpting_ssn_pre, {seq, num_billgrps_rpting_ssn := COUNT(GROUP)}, seq );

	SHARED tbl_cf_billgrps_rpting_phone_pre := 
			TABLE( cf_IFD_recs_byPhone, {seq, customer_id, count_each_customer_id := COUNT(GROUP)}, seq, customer_id );

	SHARED tbl_cf_billgrps_rpting_phone := 
			TABLE( tbl_cf_billgrps_rpting_phone_pre, {seq, num_billgrps_rpting_phone := COUNT(GROUP)}, seq );

	SHARED tbl_cf_billgrps_rpting_addr_pre := 
			TABLE( cf_IFD_recs_byAddr, {seq, customer_id, count_each_customer_id := COUNT(GROUP)}, seq, customer_id );

	SHARED tbl_cf_billgrps_rpting_addr := 
			TABLE( tbl_cf_billgrps_rpting_addr_pre, {seq, num_billgrps_rpting_addr := COUNT(GROUP)}, seq );

	// Transform into final layout.
	EXPORT layout_contributory_fraud := RECORD
		UNSIGNED4 seq;
		UNSIGNED3 cf_Lexid_count           := 0; // # of records in contributory fraud database that match the LexID
		UNSIGNED3 cf_ssn_count             := 0; // # of records in contributory fraud database that match the SSN
		UNSIGNED3 cf_phone_count           := 0; // # of records in contributory fraud database that match the phone
		UNSIGNED3 cf_addr_count            := 0; // # of records in contributory fraud database that match the address
		UNSIGNED3 cf_Lexid_billgroup_count := 0; // # of unique bill groups / customers in contributory fraud database that report the LexID
		UNSIGNED3 cf_ssn_billgroup_count   := 0; // # of unique bill groups / customers in contributory fraud database that report the SSN
		UNSIGNED3 cf_phone_billgroup_count := 0; // # of unique bill groups / customers in contributory fraud database that report the phone
		UNSIGNED3 cf_addr_billgroup_count  := 0; // # of unique bill groups / customers in contributory fraud database that report the address
	END;

	SHARED cf_with_Lexid := 
		JOIN(
			input_iid, tbl_cf_IFD_recs_byDID,
			LEFT.seq = RIGHT.seq,
			TRANSFORM( layout_contributory_fraud,
				SELF.cf_Lexid_count := RIGHT.num_recs_match_lexid,
				SELF := LEFT,
				SELF := []
			),
			LEFT OUTER
		);

	SHARED cf_with_ssn := 
		JOIN(
			cf_with_Lexid, tbl_cf_IFD_recs_bySSN,
			LEFT.seq = RIGHT.seq,
			TRANSFORM( layout_contributory_fraud,
				SELF.cf_ssn_count := RIGHT.num_recs_match_ssn,
				SELF := LEFT,
				SELF := []
			),
			LEFT OUTER
		);

	SHARED cf_with_phone := 
		JOIN(
			cf_with_ssn, tbl_cf_IFD_recs_byPhone,
			LEFT.seq = RIGHT.seq,
			TRANSFORM( layout_contributory_fraud,
				SELF.cf_phone_count := RIGHT.num_recs_match_phone,
				SELF := LEFT,
				SELF := []
			),
			LEFT OUTER
		);

	SHARED cf_with_addr := 
		JOIN(
			cf_with_phone, tbl_cf_IFD_recs_byAddr,
			LEFT.seq = RIGHT.seq,
			TRANSFORM( layout_contributory_fraud,
				SELF.cf_addr_count := RIGHT.num_recs_match_addr,
				SELF := LEFT,
				SELF := []
			),
			LEFT OUTER
		);

	SHARED cf_with_Lexid_billgroup_count := 
		JOIN(
			cf_with_addr, tbl_cf_billgrps_rpting_lexid,
			LEFT.seq = RIGHT.seq,
			TRANSFORM( layout_contributory_fraud,
				SELF.cf_Lexid_billgroup_count := RIGHT.num_billgrps_rpting_lexid,
				SELF := LEFT,
				SELF := []
			),
			LEFT OUTER
		);		

	SHARED cf_with_ssn_billgroup_count := 
		JOIN(
			cf_with_Lexid_billgroup_count, tbl_cf_billgrps_rpting_ssn,
			LEFT.seq = RIGHT.seq,
			TRANSFORM( layout_contributory_fraud,
				SELF.cf_ssn_billgroup_count := RIGHT.num_billgrps_rpting_ssn,
				SELF := LEFT,
				SELF := []
			),
			LEFT OUTER
		);		

	SHARED cf_with_phone_billgroup_count := 
		JOIN(
			cf_with_ssn_billgroup_count, tbl_cf_billgrps_rpting_phone,
			LEFT.seq = RIGHT.seq,
			TRANSFORM( layout_contributory_fraud,
				SELF.cf_phone_billgroup_count := RIGHT.num_billgrps_rpting_phone,
				SELF := LEFT,
				SELF := []
			),
			LEFT OUTER
		);		
		
	SHARED cf_with_addr_billgroup_count := 
		JOIN(
			cf_with_phone_billgroup_count, tbl_cf_billgrps_rpting_addr,
			LEFT.seq = RIGHT.seq,
			TRANSFORM( layout_contributory_fraud,
				SELF.cf_addr_billgroup_count := RIGHT.num_billgrps_rpting_addr,
				SELF := LEFT
			),
			LEFT OUTER
		);
	
	// --------------------[ Exportable attributes ]--------------------
	
	EXPORT test_fraud_metrics         := tf_with_addr_billgroup_count;
	EXPORT contributory_fraud_metrics := cf_with_addr_billgroup_count;
	
END;


// Junk:
	// SHARED ds_IFD_recs_byEmail   := FraudPoint_Services.Raw.get_IFD_recs_byEmail_bocashell( input_iid );
	// SHARED ds_IFD_recs_byIP      := FraudPoint_Services.Raw.get_IFD_recs_byIP_bocashell( input_iid );
	// SHARED ds_IFD_recs_byName    := FraudPoint_Services.Raw.get_IFD_recs_byName_bocashell( input_iid );
