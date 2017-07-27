
IMPORT Address, Autokey_batch, AutoStandardI, BatchServices, 
       Business_Header_SS, Doxie, doxie_cbrs, EBR, ut;

	// Local record layouts.

	rec_temp_lookups := RECORD
		STRING20 acctno;
		UNSIGNED6 bdid;
		STRING10 file_number;
		BOOLEAN isDeepDive;
	END;
	
	rec_header := RECORD
		STRING20 acctno;
		BOOLEAN isDeepDive := FALSE;
		UNSIGNED2 penalt := 0;
		EBR.Layout_0010_Header_Base.bdid;
		EBR.Layout_0010_Header_Base.file_number;
		EBR.Layout_0010_Header_Base.date_first_seen;
		EBR.Layout_0010_Header_Base.date_last_seen;
		EBR.Layout_0010_Header_Base.record_type;
		EBR.Layout_0010_Header_Base.process_date;
		EBR.Layout_0010_Header_Base.orig_extract_date_mdy;
		EBR.Layout_0010_Header_Base.orig_file_estab_date_mmyy;
		EBR.Layout_0010_Header_Base.file_estab_flag;
		EBR.Layout_0010_Header_Base.company_name;
		EBR.Layout_0010_Header_Base.prim_range;
		EBR.Layout_0010_Header_Base.predir;
		EBR.Layout_0010_Header_Base.prim_name;
		EBR.Layout_0010_Header_Base.addr_suffix;
		EBR.Layout_0010_Header_Base.postdir;
		EBR.Layout_0010_Header_Base.unit_desig;
		EBR.Layout_0010_Header_Base.sec_range;
		EBR.Layout_0010_Header_Base.p_city_name;
		EBR.Layout_0010_Header_Base.v_city_name;
		EBR.Layout_0010_Header_Base.st;
		EBR.Layout_0010_Header_Base.zip;
		EBR.Layout_0010_Header_Base.zip4;
		EBR.Layout_0010_Header_Base.phone_number;
		EBR.Layout_0010_Header_Base.sic_code;
		EBR.Layout_0010_Header_Base.business_desc;
		EBR.Layout_0010_Header_Base.dispute_ind;
		EBR.Layout_0010_Header_Base.extract_date;
		EBR.Layout_0010_Header_Base.file_estab_date;
	END;

	rec_exec_summary := RECORD
		STRING20 acctno;
		EBR.layout_1000_executive_summary_base.bdid;
		EBR.layout_1000_executive_summary_base.file_number;
		EBR.layout_1000_executive_summary_base.date_first_seen;
		EBR.layout_1000_executive_summary_base.date_last_seen;
		EBR.layout_1000_executive_summary_base.record_type;
		EBR.layout_1000_executive_summary_base.process_date;
		EBR.layout_1000_executive_summary_base.current_dbt;
		EBR.layout_1000_executive_summary_base.predicted_dbt;
		string3 max_dbt := '';
		EBR.layout_1000_executive_summary_base.orig_predicted_dbt_date_mmddyy;
		EBR.layout_1000_executive_summary_base.average_industry_dbt;
		EBR.layout_1000_executive_summary_base.average_all_industries_dbt;
		EBR.layout_1000_executive_summary_base.low_balance;
		EBR.layout_1000_executive_summary_base.high_balance;
		EBR.layout_1000_executive_summary_base.current_account_balance;
		EBR.layout_1000_executive_summary_base.high_credit_extended;
		EBR.layout_1000_executive_summary_base.median_credit_extended;
		EBR.layout_1000_executive_summary_base.payment_performance;
		EBR.layout_1000_executive_summary_base.payment_trend;
		EBR.layout_1000_executive_summary_base.predicted_dbt_date;
	END;
		
	// Local functions.

	get_companyname_penalty(Autokey_batch.layouts.rec_inBatchMaster le, rec_header ri) :=
		FUNCTION
			RETURN ut.mod_penalize.company_name(le.comp_name, ri.company_name);
		END;
	
	get_address_penalty(Autokey_batch.layouts.rec_inBatchMaster le, rec_header ri) :=
		FUNCTION

			mod_input_address := MODULE(ut.mod_penalize.IGenericAddress)
				EXPORT prim_range  := le.prim_range;  
				EXPORT predir      := le.predir;      
				EXPORT prim_name   := le.prim_name;  
				EXPORT addr_suffix := le.addr_suffix;
				EXPORT postdir     := le.postdir;     
				EXPORT sec_range   := le.sec_range;   
				EXPORT p_city_name := le.p_city_name; 
				EXPORT st          := le.st;          
				EXPORT z5          := le.z5;          
			END;

			mod_matched_address := MODULE(ut.mod_penalize.IGenericAddress)
				EXPORT prim_range  := ri.prim_range;
				EXPORT predir      := ri.predir;
				EXPORT prim_name   := ri.prim_name;
				EXPORT addr_suffix := ri.addr_suffix;
				EXPORT postdir     := ri.postdir;
				EXPORT sec_range   := ri.sec_range;
				EXPORT p_city_name := ri.p_city_name;
				EXPORT st          := ri.st;
				EXPORT z5          := ri.zip;
			END;
			
			RETURN ut.mod_penalize.address(mod_input_address, mod_matched_address);
		END;


EXPORT EBRBatchService_Records( DATASET(Autokey_batch.layouts.rec_inBatchMaster) ds_batch_in_pre = DATASET([], Autokey_batch.layouts.rec_inBatchMaster) ) :=
	FUNCTION

		CURRENT := 'C';
		
		// Capitalize input records and dedup.
		ds_batch_in      := PROJECT( ds_batch_in_pre, BatchServices.transforms.xfm_capitalize_input(LEFT) );
		ds_batch_in_ddpd := DEDUP(SORT(ds_batch_in, acctno, RECORD), acctno);

		//*****************************************************************************************
		//
		//                   -----[ Fetch EBR records via Autokey lookup ]-----
		// 
		//*****************************************************************************************   
		
		// 0. Used only for penalty value, applied near end.
		ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config) END;

		// 1.  Search the Autokeys.
		ds_batch_in_for_AKs := PROJECT(ds_batch_in_ddpd, Autokey_batch.Layouts.rec_inBatchMaster);

		// 2. Get autokey 'fake' ids (fids) based on batch input. NOTE: this is a hack, as I was not able to 
		//    get the AutokeyI attributes to pass regression test in time. Note the call to a whole lot of 
		//    code that pained me to write. Fix later.
		ds_fids := EBR_Services.EBRBatch_Autokey_Fetch().get_EBR_fids( ds_batch_in_for_AKs );
		
		// 3. Obtain the autokey payload.
		ds_fids_deduped := dedup(sort(ds_fids, id), id);
		
		ds_file_numbers_by_Autokey := 
			JOIN(
				ds_fids_deduped, 
				EBR.Key_EBR_Autokeypayload,
				KEYED(LEFT.id = RIGHT.FakeID), 
				TRANSFORM( rec_temp_lookups,
					SELF.acctno      := LEFT.acctno,
					SELF.bdid        := 0,
					SELF.file_number := RIGHT.file_number,
					SELF.isDeepDive  := FALSE
				),
				INNER,
				LIMIT(ut.limits.default, SKIP)
			);
		

		//*****************************************************************************************
		//
		//                   -----[ Fetch EBR records via Header lookup ]-----
		// 
		//*****************************************************************************************   
				
		// Add a sequence number.
		ds_batch_in_plus_seq := 
			PROJECT(
				ds_batch_in_ddpd,
				TRANSFORM( Autokey_batch.layouts.rec_inBatchMaster,
					SELF.seq := COUNTER;
					SELF     := LEFT
				)
			);
		
		Layout_BDID_InBatch_plus_acctno := RECORD
				STRING20  acctno;
				Business_Header_SS.Layout_BDID_InBatch;
		END;

		Layout_BDID_InBatch_plus_acctno xfm_for_header_lookup(Autokey_batch.layouts.rec_inBatchMaster le) := 
			TRANSFORM
				SELF.company_name := le.comp_name;
				SELF.phone10      := '';
				SELF.z5           := if(le.z5 != '',le.z5,ziplib.CityToZip5(le.st,le.p_city_name));
				SELF              := le;
				SELF              := [];
			END;
    
		// Clean the input, append BDIDs, sort, and dedup results.
		ds_batch_in_for_hdr := PROJECT(ds_batch_in_plus_seq(bdid = 0), xfm_for_header_lookup(LEFT));														 

		Business_Header_SS.MAC_BDID_Append(ds_batch_in_for_hdr,ds_batch_in_for_hdr_plus_Bdid,1)		
		
		ds_bdid_append_results := dedup(sort(ds_batch_in_for_hdr_plus_Bdid,seq,-score,bdid),seq);	
				
		// ..Obtain file numbers, and join back to batch_in:
		ds_with_file_numbers :=
			PROJECT(
				ds_bdid_append_results,
				TRANSFORM( {Layout_BDID_InBatch_plus_acctno, UNSIGNED6 bdid, STRING10 file_number},
					SELF.file_number := 
						EBR_Services.ebr_raw.get_file_number_from_bdids( DATASET([{LEFT.bdid}], doxie_cbrs.layout_references) )[1].file_number,
					SELF := LEFT, 
					SELF := []
				)
			);
		
		// Rejoin results back to batch_in_ddpd on sequence number to obtain the acctno.
		ds_file_numbers_by_header :=
			JOIN(
				ds_batch_in_plus_seq,
				ds_with_file_numbers,
				LEFT.seq = RIGHT.seq,
				TRANSFORM( rec_temp_lookups,
					SELF.acctno      := LEFT.acctno,
					SELF.bdid        := RIGHT.bdid,
					SELF.file_number := RIGHT.file_number,
					SELF.isDeepDive  := TRUE
				),
				INNER,
				LIMIT(ut.limits.default, SKIP)
			);


		//*****************************************************************************************
		//
		//                   -----[ Fetch EBR records via BDID input ]-----
		// 
		//*****************************************************************************************   

		ds_file_numbers_by_BDID := 
			PROJECT(
				ds_batch_in_ddpd(bdid != 0),
				TRANSFORM( rec_temp_lookups,
					SELF.acctno      := LEFT.acctno,
					SELF.bdid        := LEFT.bdid,
					SELF.file_number := 
						EBR_Services.ebr_raw.get_file_number_from_bdids( DATASET([{LEFT.bdid}], doxie_cbrs.layout_references) )[1].file_number,
					SELF.isDeepDive  := FALSE
				)
			);


		//*****************************************************************************************
		//
		//             -----[ Get EBR header and summary records via file_number ]-----
		// 
		//*****************************************************************************************
		
		//  -------------------[ Get Header records ]-------------------
		
		// We could've gotten the file numbers earlier by joining directly to the key 0010 header bdid 
		// file on bdid, but there are many instances of the same file numbers for each bdid. We'd have
		// to dedup entire records to clean out the extra instances. So, getting file_numbers by bdid as
		// as we did above ( using ebr_raw.get_file_number_from_bdids( ) ) seems like wasted motion, but 
		// it's much easier to sort and dedup (as below) to get the EBR records we need.
		ds_file_numbers :=
			DEDUP(
				SORT(
					(ds_file_numbers_by_Autokey + ds_file_numbers_by_header + ds_file_numbers_by_BDID)(file_number != ''),
					acctno, file_number
				),
				acctno, file_number
			);
		
		ds_EBR_header_recs :=
			JOIN(
				ds_file_numbers,
				EBR.Key_0010_Header_FILE_NUMBER,
				LEFT.file_number = RIGHT.FILE_NUMBER AND
				RIGHT.record_type = CURRENT,
				TRANSFORM( rec_header,
					SELF := RIGHT,
					SELF := LEFT
				),
				LEFT OUTER
			);

		// Penalize and filter.
		ds_EBR_header_recs_penalized :=
			JOIN(
				ds_batch_in_ddpd,
				ds_EBR_header_recs,
				LEFT.acctno = RIGHT.acctno,
				TRANSFORM( rec_header,
					SELF.penalt := get_companyname_penalty(LEFT,RIGHT) + get_address_penalty(LEFT,RIGHT),
					SELF        := LEFT, 
					SELF        := RIGHT
				),
				LEFT OUTER
			);
		
		ds_EBR_header_recs_filtered := ds_EBR_header_recs_penalized( penalt <= ak_config_data.PenaltThreshold );
		
		//  --------------------[ Get Exec Summary records ]-------------------
		ds_EBR_exec_summary_recs_pre :=
			JOIN(
				ds_file_numbers,
				EBR.Key_1000_Executive_Summary_FILE_NUMBER,
				KEYED(LEFT.file_number = RIGHT.FILE_NUMBER) AND
				RIGHT.record_type != '',
				LEFT OUTER
			);
		
		ds_EBR_exec_summary_recs_grouped :=
			GROUP( SORT(ds_EBR_exec_summary_recs_pre,	acctno, file_number),	acctno, file_number	);
			
		// From the Summary records, get the most current one...
		ds_EBR_exec_summary_recs_most_current := 
			DEDUP( SORT(ds_EBR_exec_summary_recs_grouped, -(UNSIGNED)process_date), acctno, file_number, KEEP 1	);
		
		// ...and get the record that has the most severe DBT:
		ds_EBR_exec_summary_recs_most_severe := 
			DEDUP( SORT(ds_EBR_exec_summary_recs_grouped, -(UNSIGNED)current_dbt), acctno, file_number, KEEP 1	);	

		// Slim down the most current record.
		ds_EBR_exec_summary_recs := PROJECT(ds_EBR_exec_summary_recs_most_current, rec_exec_summary);
		
		// Join to the record having the most severe DBT to pull that bit of data into the current record.
		ds_EBR_exec_summary_recs_final :=
			JOIN(
				ds_EBR_exec_summary_recs,
				ds_EBR_exec_summary_recs_most_severe,
				LEFT.acctno = RIGHT.acctno AND
				LEFT.file_number = RIGHT.file_number,
				TRANSFORM( rec_exec_summary,
					SELF.max_dbt := RIGHT.current_dbt,
					SELF         := LEFT
				),
				LEFT OUTER
			);
		
		//  --------------------[ Join EBR Header records to Exec Summary records ]-------------------
		/*
				"Usually, there are two important nuggets from DBT (Days Beyond Terms): present DBT and 
        most severe. Also, if they give us an industry average, that is very helpful in putting 
        it into context."
		                                          --Steve Shelnut, 3/26/2012                     */		
		ds_EBR_recs := 
			JOIN(
				ds_EBR_header_recs_filtered, 
				ds_EBR_exec_summary_recs_final,
				LEFT.acctno = RIGHT.acctno AND
				LEFT.file_number = RIGHT.file_number,
				TRANSFORM( EBR_Services.Layout_EBR_Batch,
					SELF.acctno                         := LEFT.acctno,
					SELF.isDeepDive                     := LEFT.isDeepDive,
					SELF.penalt                         := LEFT.penalt,		
					SELF.bdid                           := RIGHT.bdid,  // the LEFT side has no value in the BDID field, must use RIGHT
					SELF.file_number                    := LEFT.file_number,
					SELF.date_first_seen                := LEFT.date_first_seen,
					SELF.date_last_seen                 := LEFT.date_last_seen,
					SELF.record_type                    := LEFT.record_type,
					SELF.process_date                   := LEFT.process_date,
						// Header data
					SELF.orig_extract_date_mdy          := LEFT.orig_extract_date_mdy,
					SELF.orig_file_estab_date_mmyy      := LEFT.orig_file_estab_date_mmyy,
					SELF.file_estab_flag                := LEFT.file_estab_flag,
					SELF.company_name                   := LEFT.company_name,
					SELF.prim_range                     := LEFT.prim_range,
					SELF.predir                         := LEFT.predir,
					SELF.prim_name                      := LEFT.prim_name,
					SELF.addr_suffix                    := LEFT.addr_suffix,
					SELF.postdir                        := LEFT.postdir,
					SELF.unit_desig                     := LEFT.unit_desig,
					SELF.sec_range                      := LEFT.sec_range,
					SELF.p_city_name                    := LEFT.p_city_name,
					SELF.v_city_name                    := LEFT.v_city_name,
					SELF.st                             := LEFT.st,
					SELF.zip                            := LEFT.zip,
					SELF.zip4                           := LEFT.zip4,
					SELF.phone_number                   := LEFT.phone_number,
					SELF.sic_code                       := LEFT.sic_code,
					SELF.business_desc                  := LEFT.business_desc,
					SELF.dispute_ind                    := LEFT.dispute_ind,
					SELF.extract_date                   := LEFT.extract_date,
					SELF.file_estab_date                := LEFT.file_estab_date,
						// Executive Summary data
					SELF.current_dbt                    := RIGHT.current_dbt,
					SELF.predicted_dbt                  := RIGHT.predicted_dbt,
					SELF.dbt_record_type                := RIGHT.record_type,
					SELF.max_dbt                        := RIGHT.max_dbt,     // most severe DBT
					SELF.orig_predicted_dbt_date_mmddyy := RIGHT.orig_predicted_dbt_date_mmddyy,
					SELF.average_industry_dbt           := RIGHT.average_industry_dbt,
					SELF.average_all_industries_dbt     := RIGHT.average_all_industries_dbt,
					SELF.low_balance                    := RIGHT.low_balance,
					SELF.high_balance                   := RIGHT.high_balance,
					SELF.current_account_balance        := RIGHT.current_account_balance,
					SELF.high_credit_extended           := RIGHT.high_credit_extended,
					SELF.median_credit_extended         := RIGHT.median_credit_extended,
					SELF.payment_performance            := RIGHT.payment_performance,
					SELF.payment_trend                  := RIGHT.payment_trend,
					SELF.predicted_dbt_date             := RIGHT.predicted_dbt_date,
				), 
				LEFT OUTER
			);

		// DEBUGs:
		// OUTPUT( ds_EBR_header_recs, NAMED('ds_EBR_header_recs') );
		// OUTPUT( ds_EBR_header_recs_penalized, NAMED('ds_EBR_header_recs_penalized') );
		// OUTPUT( ds_EBR_header_recs_filtered, NAMED('ds_EBR_header_recs_filtered') );
		// OUTPUT( ds_EBR_exec_summary_recs_final, NAMED('ds_EBR_exec_summary_recs_final') );
		
		RETURN ds_EBR_recs;
	END;

