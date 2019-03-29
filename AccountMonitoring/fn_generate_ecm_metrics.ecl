
IMPORT _control;

SHARED get_product_name(AccountMonitoring.types.productMask nth_product) := 
	FUNCTION
		product_name := 
			CASE( nth_product,
				 AccountMonitoring.types.productMask.none            => 'NONE',
				 AccountMonitoring.types.productMask.bankruptcy      => 'BANKRUPTCY',
				 AccountMonitoring.types.productMask.deceased        => 'DECEASED',
				 AccountMonitoring.types.productMask.phone           => 'PHONE',
				 AccountMonitoring.types.productMask.address         => 'ADDRESS',
				 AccountMonitoring.types.productMask.paw             => 'PAW',
				 AccountMonitoring.types.productMask.property        => 'PROPERTY',
				 AccountMonitoring.types.productMask.litigiousdebtor => 'LITIGIOUSDEBTOR',
				 AccountMonitoring.types.productMask.liens           => 'LIENS',
				 AccountMonitoring.types.productMask.criminal        => 'CRIMINAL',
				 AccountMonitoring.types.productMask.phonefeedback   => 'PHONEFEEDBACK',
				 AccountMonitoring.types.productMask.foreclosure     => 'FORECLOSURE',
				 AccountMonitoring.types.productMask.workplace       => 'WORKPLACE',
				 AccountMonitoring.types.productMask.reverseaddress  => 'REVERSEADDRESS',
				 AccountMonitoring.types.productMask.didupdate  		 => 'DIDUPDATE',
				 AccountMonitoring.types.productMask.bdidupdate  		 => 'BDIDUPDATE',
				 AccountMonitoring.types.productMask.phoneownership	 => 'PHONEOWNERSHIP',
				 AccountMonitoring.types.productMask.bipbestupdate	 => 'BIPBESTUPDATE',
				 AccountMonitoring.types.productMask.sbfe	 					 => 'SBFE',
				 AccountMonitoring.types.productMask.ucc	 					 => 'UCC',
				 AccountMonitoring.types.productMask.govtdebarred		 => 'GOVTDEBARRED',
				 AccountMonitoring.types.productMask.inquiry				 => 'INQUIRY',
				 AccountMonitoring.types.productMask.corp	 					 => 'CORP',
				 AccountMonitoring.types.productMask.mvr	 					 => 'MVR',
				 AccountMonitoring.types.productMask.aircraft				 => 'AIRCRAFT',
				 AccountMonitoring.types.productMask.watercraft			 => 'WATERCRAFT',
				 AccountMonitoring.types.productMask.personheader			 => 'PERSONHEADER',
				'UNKNOWN'
			);
		RETURN product_name;
	END;

// 2. Run metrics. 
EXPORT fn_generate_ecm_metrics( UNSIGNED1 pseudo_environment,
										  STRING  despray_ip_address = '', 
                                STRING  despray_path = '') :=
	FUNCTION

		STRING timestamp := thorlib.wuid();
		
		// 1. Get ECM update file.

		ECM_file := AccountMonitoring.files(pseudo_environment).ecm.base;
	
		num_products := AccountMonitoring.Utilities.NUM_ACCT_MON_PRODUCTS;

		// Get Portfolio.
		portfolio_raw     := DISTRIBUTED(AccountMonitoring.files(pseudo_environment).portfolio.base, HASH32(pid,rid));
		portfolio_deduped := DEDUP(SORT(portfolio_raw,pid,rid,-timestamp),pid,rid);  // Note to self: Remove this when Portfolio update is compelted 
		portfolio_dist    := DISTRIBUTE(portfolio_deduped(product_mask != 0), RANDOM());

		// Join Portfolio to ECM update file to assign an enterprise_id to each portfolio_id. 
		// rec_portfolio_snapshot := RECORD
	
		rec_portfolio_slim := RECORD
			UNSIGNED6 eid;
			AccountMonitoring.layouts.portfolio.base.product_mask;
			AccountMonitoring.layouts.portfolio.base.pid;
			AccountMonitoring.layouts.portfolio.base.rid;
			UNSIGNED6 entity;
		END;
		
		//  Here we create a slim portfolio that contains all portfolio records. 
		//  For each PID, we add the ECM_ID from the ECM file, then the did/bid, 
		//  pid, rid and product mask from the portfolio file.
		portfolio_slim := 
			JOIN(
				portfolio_dist,
				ECM_file,		
				LEFT.pid = RIGHT.pid,
				TRANSFORM(
					rec_portfolio_slim,
					SELF.eid    := RIGHT.eid,
					SELF.entity := IF( LEFT.did != 0, LEFT.did, LEFT.bdid ),
					SELF        := LEFT
				), 
				MANY LOOKUP
			)(entity != 0);
			
		// Normalize to demultiplex the product bitmask value to discrete product 'nth' values. The 
		// result of this is a dataset whose records each depict a eid, pid, rid, did, bdid, and single 
		// product type value (e.g. deceased or litigious debtor or whatever).
		portfolio_normalized :=
			NORMALIZE(
				portfolio_slim,
				num_products,
				TRANSFORM(
					rec_portfolio_slim,
					SELF.product_mask := left.product_mask & (1 << (COUNTER - 1)),
					SELF := LEFT
				)
			)(product_mask != 0);
			
		// 1.	Count the number of times each portfolio is monitoring each entity for each 
		// monitoring product.
		COUNT_BY_EID_PRODUCT_PID_ENTITY := 
			TABLE(
				portfolio_normalized, 
				{EID, PRODUCT_MASK, PID, ENTITY, UNSIGNED CNT := COUNT(GROUP)}, 
				EID, PRODUCT_MASK, PID, ENTITY
			);

		// 2.	Count the total number of times all portfolios in the enterprise monitor for 
		// each entity for each monitoring product.
		COUNT_BY_EID_PRODUCT_ENTITY := 
			TABLE(
				COUNT_BY_EID_PRODUCT_PID_ENTITY, 
				{EID, PRODUCT_MASK, ENTITY, UNSIGNED CNT := SUM(GROUP, CNT)}, 
				EID, PRODUCT_MASK, ENTITY
			);

		// 3.	Calculate the relative price of each entity for each portfolio for each product
		// by taking the ratio of times that portfolio monitors the entity to the times all 
		// portfolios monitor the entity.
		RATIO_BY_EID_PRODUCT_PID_ENTITY := 
			JOIN(
				COUNT_BY_EID_PRODUCT_PID_ENTITY, 
				COUNT_BY_EID_PRODUCT_ENTITY, 
				LEFT.EID = RIGHT.EID AND 
				LEFT.PRODUCT_MASK = RIGHT.PRODUCT_MASK AND 
				LEFT.ENTITY = RIGHT.ENTITY, 
				TRANSFORM(
					{UNSIGNED EID; UNSIGNED PRODUCT_MASK; UNSIGNED PID; UNSIGNED ENTITY; REAL RATIO;}, 
					SELF.RATIO := (REAL)LEFT.CNT / (REAL)RIGHT.CNT, 
					SELF := LEFT
				)
			);

		// 4.	Apply the relative price for each entity to every record in the portfolios.
		PORTFOLIO_PLUS_RELATIVE_PRICE := 
			JOIN(
				PORTFOLIO_NORMALIZED, 
				RATIO_BY_EID_PRODUCT_PID_ENTITY, 
				LEFT.EID = RIGHT.EID AND 
				LEFT.PRODUCT_MASK = RIGHT.PRODUCT_MASK AND 
				LEFT.PID = RIGHT.PID AND 
				LEFT.ENTITY = RIGHT.ENTITY, 
				TRANSFORM(
					{RECORDOF(PORTFOLIO_NORMALIZED); REAL RATIO;}, 
					SELF.RATIO := RIGHT.RATIO, 
					SELF := LEFT
				)
			);

		// 5.	Calculate the discount factor for each portfolio for each PRODUCT_MASK by 
		// determining the average relative price per record. NOTE that, because of prior skew
		// problems in the implicit sort within an table aggregate function AVE, we must be 
		// a bit heavy-handed in telling the system how to distribute the records (using RANDOM to avoid skew).

		 PORTFOLIO_PLUS_RELATIVE_PRICE_tbl1 := 
			TABLE(
				DISTRIBUTE(PORTFOLIO_PLUS_RELATIVE_PRICE, RANDOM()), 
				{EID, PRODUCT_MASK, PID, REAL RATIO_LOCAL := SUM(GROUP,RATIO), UNSIGNED COUNT_LOCAL := COUNT(GROUP)}, 
				EID, PRODUCT_MASK, PID,
				LOCAL
			);
		
		// Calculate the ratio across the local distribution/sums
		RATIO_BY_EID_PRODUCT_PID :=
			TABLE(
				PORTFOLIO_PLUS_RELATIVE_PRICE_tbl1, 
				{EID, PRODUCT_MASK, PID, REAL RATIO :=  SUM(GROUP,RATIO_LOCAL) / SUM(GROUP,COUNT_LOCAL)}, 
				EID, PRODUCT_MASK, PID
			);
		
		// Put file in output layout
		results := 
			PROJECT(
				RATIO_BY_EID_PRODUCT_PID,
				TRANSFORM(
					layouts.ecm.results_layout,
					SELF.eid          := LEFT.eid,
					SELF.product_mask := LEFT.product_mask,
					SELF.product_name := get_product_name(LEFT.product_mask),
					SELF              := LEFT
				)
			);
			
		// Despray results to file.
		valid_despray_criteria := despray_ip_address != '' AND despray_path != '';
		ALLOW_OVERWRITE        := TRUE;
		superfile_stem_name    := AccountMonitoring.filenames(pseudo_environment).ecm.results;
		logical_file_name      := superfile_stem_name + timestamp;
		
		DELETE_SUBFILE      := TRUE;
		COPY_FILE_CONTENTS  := TRUE;
		update_superfiles := SEQUENTIAL(
						OUTPUT(results,,logical_file_name,CSV(HEADING(1),SEPARATOR('|'),TERMINATOR('\n')),OVERWRITE),
						Utilities.fn_update_superfiles(superfile_stem_name, logical_file_name, DELETE_SUBFILE, COPY_FILE_CONTENTS) );
		
		despray_file  := FileServices.DeSpray(logical_file_name, despray_ip_address, despray_path, -1, , , ALLOW_OVERWRITE);

		// DEBUGs:
		// OUTPUT( ECM_file, NAMED('ECM_file') );
		// OUTPUT( 'num_products: ' + num_products );
		// OUTPUT( CHOOSEN(portfolio_normalized,1000), NAMED('portfolio_normalized') );
		// OUTPUT( CHOOSEN(COUNT_BY_EID_PRODUCT_PID_ENTITY,1000), NAMED('COUNT_BY_EID_PRODUCT_PID_ENTITY') );
		// OUTPUT( CHOOSEN(COUNT_BY_EID_PRODUCT_ENTITY,1000), NAMED('COUNT_BY_EID_PRODUCT_ENTITY') );
		// OUTPUT( CHOOSEN(RATIO_BY_EID_PRODUCT_PID_ENTITY,1000), NAMED('RATIO_BY_EID_PRODUCT_PID_ENTITY') );
		// OUTPUT( CHOOSEN(PORTFOLIO_PLUS_RELATIVE_PRICE,1000), NAMED('PORTFOLIO_PLUS_RELATIVE_PRICE') );
		// OUTPUT( CHOOSEN(PORTFOLIO_PLUS_RELATIVE_PRICE_tbl1,1000), NAMED('PORTFOLIO_PLUS_RELATIVE_PRICE_tbl1') );
		// OUTPUT( RATIO_BY_EID_PRODUCT_PID, NAMED('RATIO_BY_EID_PRODUCT_PID') );
		// OUTPUT( results, NAMED('RESULTS') );
		
		// RETURN 1;
		
		// --- END DEBUGs ---
		
		RETURN SEQUENTIAL(
			IF( NOT valid_despray_criteria, FAIL('Must provide valid spray criteria.') ), 
			IF( NOT EXISTS(ECM_file), FAIL('Must provide an ECM file for Portfolio.') ),
			IF( NOT EXISTS(portfolio_raw), FAIL('Must provide a Portfolio file.') ),
			update_superfiles, 
			NOTHOR(despray_file)
		);

	END;
	