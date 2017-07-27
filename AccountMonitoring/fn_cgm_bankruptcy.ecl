import AccountMonitoring,BankruptcyV2,BatchServices,ut, NID,BIPV2;

EXPORT DATASET(AccountMonitoring.layouts.history) fn_cgm_bankruptcy(
		DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio_no_preferred_firstname,
		DATASET(AccountMonitoring.layouts.documents.bankruptcy.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.bankruptcy.base),
		AccountMonitoring.i_Job_Config job_config
	) := 
	FUNCTION

		// *****************************
		//      PORTFOLIO DEFINITION
		// *****************************
		
		in_portfolio := 
			PROJECT(
				in_portfolio_no_preferred_firstname,
				TRANSFORM(
					{ AccountMonitoring.layouts.portfolio.base, STRING20 pf_first },
						SELF.pf_first := NID.PreferredFirstNew(LEFT.name_first),
						SELF := LEFT
					)
				);
				
		// *****************************
		//        FILE REFERENCES
		// *****************************
		
		search_file := AccountMonitoring.product_files.bankruptcy.search_file;
		main_file   := AccountMonitoring.product_files.bankruptcy.main_file;

		search_file_daily := AccountMonitoring.product_files.bankruptcy.search_file_daily;
		main_file_daily   := AccountMonitoring.product_files.bankruptcy.main_file_daily;
		
		// *****************************
		//        LOCAL FUNCTIONS
		// *****************************

		is_redacted(STRING ssn) := (UNSIGNED4)ssn <= 9999;
		is_not_redacted(STRING ssn) := (UNSIGNED4)ssn > 9999;

		same_redacted_ssns(STRING pf_ssn_untrimmed, STRING bk_ssn_untrimmed) := 
			FUNCTION
				pf_ssn := TRIM(pf_ssn_untrimmed,LEFT,RIGHT);
				bk_ssn := TRIM(bk_ssn_untrimmed,LEFT,RIGHT);
				
				length_pf_ssn := LENGTH(pf_ssn);
				length_bk_ssn := LENGTH(bk_ssn);
															
				are_the_same := 
					pf_ssn[ (length_pf_ssn - 3)..length_pf_ssn ] = bk_ssn[ (length_bk_ssn - 3)..length_bk_ssn ];
				
				RETURN are_the_same;
			END;

		redacted_ssns_are_the_same(STRING pf_ssn_untrimmed, STRING bk_ssn_untrimmed) := 
			FUNCTION
				pf_ssn := TRIM(pf_ssn_untrimmed,LEFT,RIGHT);
				bk_ssn := TRIM(bk_ssn_untrimmed,LEFT,RIGHT);

				length_pf_ssn := LENGTH(pf_ssn);
				length_bk_ssn := LENGTH(bk_ssn);
				
				is_redacted_and_the_same := 
					is_redacted(bk_ssn) AND
					(pf_ssn[ (length_pf_ssn - 3)..length_pf_ssn ] = bk_ssn[ (length_bk_ssn - 3)..length_bk_ssn ]);
				
				RETURN is_redacted_and_the_same;
			END;
	
		// Temporary Join Layout
		temp_layout := record
			in_documents.pid;
			in_documents.rid;
			in_documents.hid;
			in_documents.tmsid;
			typeof(in_portfolio.did) save_did;
			typeof(in_portfolio.bdid) save_bdid;
		end;
		

		// *****************************
		//            PIVOTS
		// *****************************
		
		// Pivot on SSN
		temp_port_dist_1        := distribute(in_portfolio(ssn != '' AND is_not_redacted(ssn)),hash64(ssn));
		temp_base_dist_1a       := distribute(search_file(ssn != '' AND is_not_redacted(ssn)),hash64(ssn));
		temp_base_dist_1a_daily := distribute(search_file_daily(ssn != '' AND is_not_redacted(ssn)),hash64(ssn));
		
		mac_temp_join_1a( ds_join, join_option, bk_search_file ) := MACRO
			ds_join := 
				join(
					temp_port_dist_1,
					bk_search_file,
					left.ssn = right.ssn,
					transform(temp_layout,
						self.pid := left.pid,
						self.rid := left.rid,
						self.hid := 0,
						self.save_did := left.did,
						self.save_bdid := left.bdid,
						self := right),
					join_option // 'local' or 'all' (which is executed internally as 'many lookup'--see LG p. 167)
				);
		ENDMACRO;
		
		mac_temp_join_1a( temp_join_1a, local, temp_base_dist_1a )
		mac_temp_join_1a( temp_join_1a_daily, all, temp_base_dist_1a_daily )


		// Pivot on SSN_Match
		temp_base_dist_1b       := distribute(search_file(ssnMatch != ''),hash64(ssnMatch));
		temp_base_dist_1b_daily := distribute(search_file_daily(ssnMatch != ''),hash64(ssnMatch));
		
		mac_temp_join_1b( ds_join, join_option, bk_search_file ) := MACRO
			ds_join := 
				join(
					temp_port_dist_1,
					bk_search_file,
					left.ssn = right.ssnMatch,
					transform(temp_layout,
						self.pid := left.pid,
						self.rid := left.rid,
						self.hid := 0,
						self.save_did := left.did,
						self.save_bdid := left.bdid,
						self := right),
					join_option);
		ENDMACRO;

		mac_temp_join_1b( temp_join_1b, local, temp_base_dist_1b )
		mac_temp_join_1b( temp_join_1b_daily, all, temp_base_dist_1b_daily )


		
		// Pivot on Last Name and Preferred First
		
		// ...redistribute Portfolio and filter:
		temp_port_dist_2      := distribute(in_portfolio(name_last != ''),hash64(name_last,pf_first));
		temp_port_dist_2_filt := temp_port_dist_2(ssn != '');

		// ...redistribute Search file and filter:
		mac_temp_base_dist_2( ds_dist, bk_search_file ) := MACRO
			ds_dist := 
				DISTRIBUTE(
					PROJECT( 
						bk_search_file(lname != ''), 
						TRANSFORM(
							{ AccountMonitoring.product_files.bankruptcy.layout_search_file_slim, STRING pf_first },
							SELF.pf_first := NID.PreferredFirstNew(LEFT.fname),
							SELF := LEFT
						)
					),
					hash64(lname,pf_first)
				);
		ENDMACRO;
		
		mac_temp_base_dist_2( temp_base_dist_2, search_file )
		mac_temp_base_dist_2( temp_base_dist_2_daily, search_file_daily )
		
		temp_base_dist_2_filt       := temp_base_dist_2(ssn != '' or ssnMatch != '');
		temp_base_dist_2_filt_daily := temp_base_dist_2_daily(ssn != '' or ssnMatch != '');

		// Plus SSN
		mac_temp_join_2a_1( ds_join, join_option, bk_search_file ) := MACRO
			ds_join := 
				join(
					temp_port_dist_2_filt,
					bk_search_file,
					left.name_last = right.lname and
					LEFT.pf_first = RIGHT.pf_first and
					(
						ut.WithinEditN(left.ssn,right.ssn,1) or
						ut.WithinEditN(left.ssn,right.ssnMatch,1) 
					),
					transform(temp_layout,
						self.pid := left.pid,
						self.rid := left.rid,
						self.hid := 0,
						self.save_did := left.did,
						self.save_bdid := left.bdid,
						self := right),
					join_option);
		ENDMACRO;	
		
		mac_temp_join_2a_1( temp_join_2a_1, local, temp_base_dist_2_filt )
		mac_temp_join_2a_1( temp_join_2a_1_daily, all, temp_base_dist_2_filt_daily )
		

		temp_base_dist_2_filt_is_redacted       := temp_base_dist_2_filt(ssn != '' AND is_redacted(ssn));
		temp_base_dist_2_filt_is_redacted_daily := temp_base_dist_2_filt_daily(ssn != '' AND is_redacted(ssn));
		
		mac_temp_join_2a_2( ds_join, join_option, bk_search_file ) := MACRO
			ds_join := 
				join(
					temp_port_dist_2_filt,
					bk_search_file,
					left.name_last = right.lname and
					LEFT.pf_first = RIGHT.pf_first and
					same_redacted_ssns(left.ssn,right.ssn),
					transform(temp_layout,
						self.pid := left.pid,
						self.rid := left.rid,
						self.hid := 0,
						self.save_did := left.did,
						self.save_bdid := left.bdid,
						self := right),
					join_option);
		ENDMACRO;
		
		mac_temp_join_2a_2( temp_join_2a_2, local, temp_base_dist_2_filt_is_redacted )
		mac_temp_join_2a_2( temp_join_2a_2_daily, all, temp_base_dist_2_filt_is_redacted_daily )
		
		temp_join_2a       := temp_join_2a_1 + temp_join_2a_2;
		temp_join_2a_daily := temp_join_2a_1_daily + temp_join_2a_2_daily;

		
		// Plus PRIM-NAME, PRIM-RANGE and SUFFIX
		mac_temp_join_2b( ds_join, join_option, bk_search_file ) := MACRO
			ds_join := 
				join(
					temp_port_dist_2(prim_name != ''),
					bk_search_file(prim_name != ''),
					left.name_last = right.lname and
					LEFT.pf_first = RIGHT.pf_first and
					left.prim_name = right.prim_name and
					left.prim_range = right.prim_range and
					left.addr_suffix = right.addr_suffix,
					transform(temp_layout,
						self.pid := left.pid,
						self.rid := left.rid,
						self.hid := 0,
						self.save_did := left.did,
						self.save_bdid := left.bdid,
						self := right),
					join_option);
		ENDMACRO;	
		
		mac_temp_join_2b( temp_join_2b, local, temp_base_dist_2 )
		mac_temp_join_2b( temp_join_2b_daily, all, temp_base_dist_2_daily )

		
		// Pivot on Zip9 "PLUS" 
		z9_slim_layout := record
			search_file.tmsid;
			search_file.zip;
			search_file.zip4;
			search_file.tax_id;
			search_file.ssn;
			search_file.ssnMatch;
			search_file.prim_name;
			search_file.prim_range;
			search_file.addr_suffix;
			search_file.lname;
			search_file.fname;
			search_file.cname;
		end;
		
		temp_port_dist_3       := distribute(in_portfolio(z5 != '' and zip4 != ''),hash64(z5,zip4));
		// temp_base_dist_3       := distribute(search_file(zip != '' and zip4 != ''),hash64(zip,zip4));
		temp_base_dist_3       := distribute(project(search_file(zip != '', zip4 != '', zip != '00000', zip4 != '0000'),transform(z9_slim_layout, self := left;)),hash64(zip,zip4));
		temp_base_dist_3_daily := distribute(search_file_daily(zip != '' and zip4 != ''),hash64(zip,zip4));		
		
		temp_base_dist_3_srt := sort(temp_base_dist_3, zip, zip4, local):independent;
		temp_base_dist_3_samp1 := sample(temp_base_dist_3_srt, 2, 1);
		temp_base_dist_3_samp2 := sample(temp_base_dist_3_srt, 2, 2);
		
		mac_temp_join_3( ds_join, join_option, bk_search_file ) := MACRO
			ds_join := 
				join(
					temp_port_dist_3,
					bk_search_file,
					left.z5 = right.zip and
					left.zip4 = right.zip4 and (
						(
							left.fein != '' and right.tax_id != '' and
							ut.WithinEditN(left.fein,right.tax_id,1)
						) or (
							left.ssn != '' and right.tax_id != '' and
							ut.WithinEditN(left.ssn,right.tax_id,1)
						) or (
							left.ssn != '' and right.ssn != '' and
							ut.WithinEditN(left.ssn,right.ssn,1)
						) or (
							left.ssn != '' and right.ssnMatch != '' and
							ut.WithinEditN(left.ssn,right.ssnMatch,1)
						) or (
							left.fein != '' and right.tax_id != '' and
							redacted_ssns_are_the_same(left.fein,right.tax_id) and
							left.prim_name = right.prim_name and
							left.prim_range = right.prim_range and
							left.addr_suffix = right.addr_suffix
						) or (
							left.ssn != '' and right.tax_id != '' and
							redacted_ssns_are_the_same(left.ssn,right.tax_id) and
							left.prim_name = right.prim_name and
							left.prim_range = right.prim_range and
							left.addr_suffix = right.addr_suffix
						) or (
							left.ssn != '' and right.ssn != '' and
							redacted_ssns_are_the_same(left.ssn,right.ssn) and
							left.prim_name = right.prim_name and
							left.prim_range = right.prim_range and
							left.addr_suffix = right.addr_suffix
						) or (
							left.name_last != '' and
							metaphonelib.DMetaPhone1(left.name_last)[1..4] = metaphonelib.DMetaPhone1(right.lname)[1..4] and
							NID.PreferredFirstNew(left.name_first) = NID.PreferredFirstNew(right.fname)) or
						(
							left.comp_name != '' and
							left.comp_name[1..20] = right.cname[1..20])
						),
					transform(temp_layout,
						self.pid := left.pid,
						self.rid := left.rid,
						self.hid := 0,
						self.save_did := left.did,
						self.save_bdid := left.bdid,
						self := right),
					join_option);
		ENDMACRO;
		
		// mac_temp_join_3( temp_join_3, local, temp_base_dist_3 )
		mac_temp_join_3( temp_join_3_s1, local, temp_base_dist_3_samp1 )
		mac_temp_join_3( temp_join_3_s2, local, temp_base_dist_3_samp2 )
		mac_temp_join_3( temp_join_3_daily, all, temp_base_dist_3_daily )

			
		// Pivot on DID
		temp_port_dist_4       := distribute(in_portfolio((unsigned)did != 0),hash64((unsigned)did));
		temp_base_dist_4       := distribute(search_file((unsigned)did != 0),hash64((unsigned)did));
		temp_base_dist_4_daily := distribute(search_file_daily((unsigned)did != 0),hash64((unsigned)did));
		
		mac_temp_join_4( ds_join, join_option, bk_search_file ) := MACRO
			ds_join := 
				join(
					temp_port_dist_4,
					bk_search_file,
					(unsigned)left.did = (unsigned)right.did,
					transform(temp_layout,
						self.pid := left.pid,
						self.rid := left.rid,
						self.hid := 0,
						self.save_did := left.did,
						self.save_bdid := left.bdid,
						self := right),
					join_option);
		ENDMACRO;

		mac_temp_join_4( temp_join_4, local, temp_base_dist_4 )
		mac_temp_join_4( temp_join_4_daily, all, temp_base_dist_4_daily )


		// Pivot on FEIN (TAX_ID)
		temp_port_dist_5a      := distribute(in_portfolio(fein != ''),hash64(fein));
		temp_base_dist_5       := distribute(search_file(tax_id != ''),hash64(tax_id));
		temp_base_dist_5_daily := distribute(search_file_daily(tax_id != ''),hash64(tax_id));
		
		mac_temp_join_5a( ds_join, join_option, bk_search_file ) := MACRO
			ds_join := 
				join(
					temp_port_dist_5a,
					bk_search_file,
					left.fein = right.tax_id,
					transform(temp_layout,
						self.pid := left.pid,
						self.rid := left.rid,
						self.hid := 0,
						self.save_did := left.did,
						self.save_bdid := left.bdid,
						self := right),
					join_option);
		ENDMACRO;

		mac_temp_join_5a( temp_join_5a, local, temp_base_dist_5 )
		mac_temp_join_5a( temp_join_5a_daily, all, temp_base_dist_5_daily )

			
		
		// Pivot on TAX ID, but use portfolio SSN to try and match.
		temp_port_dist_5b := temp_port_dist_1;
		
		mac_temp_join_5b( ds_join, join_option, bk_search_file ) := MACRO
			ds_join := 
				join(
					temp_port_dist_5b,
					bk_search_file,
					left.ssn = right.tax_id,
					transform(temp_layout,
						self.pid := left.pid,
						self.rid := left.rid,
						self.hid := 0,
						self.save_did := left.did,
						self.save_bdid := left.bdid,
						self := right),
					join_option);
		ENDMACRO;
		
		mac_temp_join_5b( temp_join_5b, local, temp_base_dist_5 )
		mac_temp_join_5b( temp_join_5b_daily, all, temp_base_dist_5_daily )
		

		// Pivot on Company Name
		temp_port_dist_6       := distribute(in_portfolio(comp_name != ''),hash64(comp_name[1..20]));
		temp_base_dist_6       := distribute(search_file(cname != ''),hash64(cname[1..20]));
		temp_base_dist_6_daily := distribute(search_file_daily(cname != ''),hash64(cname[1..20]));
		
		mac_temp_join_6( ds_join, join_option, bk_search_file ) := MACRO
			ds_join := 
				join(
					temp_port_dist_6,
					bk_search_file,
					left.comp_name[1..20] = right.cname[1..20] and (
						(
							left.fein != '' and right.tax_id != '' and
							ut.WithinEditN(left.fein,right.tax_id,1)
						) or (
							left.ssn != '' and right.tax_id != '' and
							ut.WithinEditN(left.ssn,right.tax_id,1)
						) or (
							left.p_city_name = right.p_city_name and
							left.st = right.st
						) or (
							left.prim_name = right.prim_name and
							left.prim_range = right.prim_range and
							left.addr_suffix = right.addr_suffix
						) or
						left.z5 = right.zip),
					transform(temp_layout,
						self.pid := left.pid,
						self.rid := left.rid,
						self.hid := 0,
						self.save_did := left.did,
						self.save_bdid := left.bdid,
						self := right),
					join_option);
		ENDMACRO;
		
		mac_temp_join_6( temp_join_6, local, temp_base_dist_6 )
		mac_temp_join_6( temp_join_6_daily, all, temp_base_dist_6_daily )

			
		// Pivot on BDID
		temp_port_dist_7       := distribute(in_portfolio((unsigned)bdid != 0),hash64((unsigned)bdid));
		temp_base_dist_7       := distribute(search_file((unsigned)bdid != 0),hash64((unsigned)bdid));
		temp_base_dist_7_daily := distribute(search_file_daily((unsigned)bdid != 0),hash64((unsigned)bdid));
		
		mac_temp_join_7( ds_join, join_option, bk_search_file ) := MACRO
			ds_join := 
				join(
					temp_port_dist_7,
					bk_search_file,
					(unsigned)left.bdid = (unsigned)right.bdid,
					transform(temp_layout,
						self.pid := left.pid,
						self.rid := left.rid,
						self.hid := 0,
						self.save_did := left.did,
						self.save_bdid := left.bdid,
						self := right),
					join_option);
		ENDMACRO;
		
		mac_temp_join_7( temp_join_7, local, temp_base_dist_7 )
		mac_temp_join_7( temp_join_7_daily, all, temp_base_dist_7_daily )

		// Pivot on Linkids
		temp_port_dist_8  := DISTRIBUTE(in_portfolio(seleid != 0),HASH64(seleid));
		temp_base_dist_8  := DISTRIBUTE(search_file((unsigned)seleid != 0),HASH64((unsigned)seleid));
		temp_base_dist_8_daily := DISTRIBUTE(search_file_daily((unsigned)seleid != 0),HASH64((unsigned)seleid));

		mac_temp_join_8(join_option, bk_search_file ) := FUNCTIONMACRO
			RETURN(
				JOIN(temp_port_dist_8,bk_search_file,
						BIPV2.IDmacros.mac_JoinTop3Linkids(),
						TRANSFORM(temp_layout,
							SELF.pid := LEFT.pid,
							SELF.rid := LEFT.rid,
							SELF.hid := 0,
							SELF.save_did := LEFT.did,
							SELF.save_bdid := LEFT.bdid,
							SELF := RIGHT),
						join_option));
		ENDMACRO;
		
		temp_join_8_daily := JOIN(temp_base_dist_8_daily,temp_port_dist_8,
																BIPV2.IDmacros.mac_JoinTop3Linkids(),
																TRANSFORM(temp_layout,
																	SELF.pid  := RIGHT.pid,
																	SELF.rid  := RIGHT.rid,
																	SELF.hid  := 0,
																	SELF.save_did := (UNSIGNED) left.did,
																	SELF.save_bdid := (UNSIGNED) left.bdid, 
																	SELF      := LEFT),
																LOCAL);			
		
		temp_join_8 := mac_temp_join_8(LOCAL,temp_base_dist_8);
																
		temp_project_documents := project(in_documents,transform(temp_layout,
			self.save_did := 0,
			self.save_bdid := 0,
			self := left));


		// Combine the possibilities from the various pivots
		temp_all_joins_normal :=
			temp_join_1a +
			temp_join_1b +
			temp_join_2a +
			temp_join_2b +
			// temp_join_3 +
			temp_join_3_s1 +
			temp_join_3_s2 +
			temp_join_4 +
			temp_join_5a +
			temp_join_5b +
			temp_join_6 +
			temp_join_7 +
			temp_join_8 +
			temp_project_documents;
		
		temp_all_joins_daily := 
			temp_join_1a_daily +
			temp_join_1b_daily +
			temp_join_2a_daily +
			temp_join_2b_daily +
			temp_join_3_daily  +
			temp_join_4_daily  +
			temp_join_5a_daily +
			temp_join_5b_daily +
			temp_join_6_daily +
			temp_join_7_daily +
			temp_join_8_daily +
			temp_project_documents;
			
		
		// Dedup by TMSID so not to double-count
		temp_joins_deduped := dedup(sort(distribute(temp_all_joins_normal,hash64(pid,rid,hid)),pid,rid,hid,tmsid,local),pid,rid,hid,tmsid,local);
		temp_joins_dist    := distribute(temp_joins_deduped,hash64(tmsid));

		temp_joins_deduped_daily := dedup(sort(distribute(temp_all_joins_daily,hash64(pid,rid,hid)),pid,rid,hid,tmsid,local),pid,rid,hid,tmsid,local);
		temp_joins_dist_daily    := distribute(temp_joins_deduped_daily,hash64(tmsid));


		// *****************************
		//    GET THE BANKRUPTCY DATA
		// *****************************
		
		// Data layout
		temp_data_layout := record
			temp_layout;
			main_file.filing_status;
			main_file.trusteeName;
			main_file.trusteeAddress;
			main_file.trusteeCity;
			main_file.trusteeState;
			main_file.trusteeZip;
			main_file.trusteeZip4;
			main_file.trusteePhone;
			main_file.trusteeID;
			main_file.court_code;
			main_file.court_name;
			main_file.court_location;
			main_file.case_number;
			main_file.orig_case_number;
			main_file.caseID;
			main_file.date_filed;
			main_file.orig_filing_date;
			main_file.meeting_date;
			main_file.meeting_time;
			main_file.claims_deadline;
			main_file.complaint_deadline;
			main_file.reopen_date;
			main_file.case_closing_date;
			main_file.dateReclosed;
			main_file.barDate;
			main_file.assets_no_asset_indicator;
			main_file.assets;
			main_file.liabilities;
			main_file.orig_chapter;
			dataset status := main_file.status;
			search_file.fname;
			search_file.mname;
			search_file.lname;
			search_file.cname;
			search_file.prim_range;
			search_file.predir;
			search_file.prim_name;
			search_file.addr_suffix;
			search_file.postdir;
			search_file.unit_desig;
			search_file.sec_range;
			search_file.p_city_name;
			search_file.st;
			search_file.zip;
			search_file.zip4;
			search_file.dCode;
			search_file.ssn;
			search_file.ssnMatch;
			search_file.tax_id;
			search_file.did;
			search_file.bdid;
			search_file.statusDate;
			search_file.dateVacated;
			search_file.dispType;
			search_file.dispReason;
		end;
		
		// Go get the data to check out
		mac_temp_get_main( ds_join, join_option, temp_joins_distributed, bk_main_file ) := MACRO
			ds_join := 
				join(
					temp_joins_distributed,
					distribute(bk_main_file,hash64(tmsid)),
					left.tmsid = right.tmsid,
					transform(temp_data_layout,
						self.pid                       := left.pid,
						self.rid                       := left.rid,
						self.hid                       := left.hid,
						self.save_did                  := left.save_did,
						self.save_bdid                 := left.save_bdid,
						self.tmsid                     := left.tmsid,
						self.filing_status             := right.filing_status,
						self.trusteeName               := right.trusteeName,
						self.trusteeAddress            := right.trusteeAddress,
						self.trusteeCity               := right.trusteeCity,
						self.trusteeState              := right.trusteeState,
						self.trusteeZip                := right.trusteeZip,
						self.trusteeZip4               := right.trusteeZip4,
						self.trusteePhone              := right.trusteePhone,
						self.trusteeID                 := right.trusteeID,
						self.court_code                := right.court_code,
						self.court_name                := right.court_name,
						self.court_location            := right.court_location,
						self.case_number               := right.case_number,
						self.orig_case_number          := right.orig_case_number,
						self.caseID                    := right.caseID,
						self.date_filed                := right.date_filed,
						self.orig_filing_date          := right.orig_filing_date,
						self.meeting_date              := right.meeting_date,
						self.meeting_time              := right.meeting_time,
						self.claims_deadline           := right.claims_deadline,
						self.complaint_deadline        := right.complaint_deadline,
						self.reopen_date               := right.reopen_date,
						self.case_closing_date         := right.case_closing_date,
						self.dateReclosed              := right.dateReclosed,
						self.barDate                   := right.barDate,
						self.assets_no_asset_indicator := right.assets_no_asset_indicator,
						self.assets                    := right.assets,
						self.liabilities               := right.liabilities,
						self.orig_chapter              := right.orig_chapter,
						self.status                    := right.status,
						self                           := []),
					left outer,
					join_option);
		
		ENDMACRO;
		
		mac_temp_get_main( temp_get_main, local, temp_joins_dist, main_file )
		mac_temp_get_main( temp_get_main_daily, all, temp_joins_dist_daily, main_file_daily )
		
		
		mac_temp_get_parties( ds_join, join_option, bk_main_recs, bk_search_file ) := MACRO
			ds_join := 
				join(
					bk_main_recs,
					distribute( bk_search_file, hash64(tmsid) ),
					left.tmsid = right.tmsid,
					transform(temp_data_layout,
						self.pid         := left.pid,
						self.rid         := left.rid,
						self.fname       := right.fname,
						self.mname       := right.mname,
						self.lname       := right.lname,
						self.cname       := right.cname,
						self.prim_range  := right.prim_range,
						self.predir      := right.predir,
						self.prim_name   := right.prim_name,
						self.addr_suffix := right.addr_suffix,
						self.postdir     := right.postdir,
						self.unit_desig  := right.unit_desig,
						self.sec_range   := right.sec_range,
						self.p_city_name := right.p_city_name,
						self.st          := right.st,
						self.zip         := right.zip,
						self.zip4        := right.zip4,
						self.dCode       := right.dCode,
						self.ssn         := right.ssn,
						self.tax_id      := right.tax_id,
						self.did         := right.did,
						self.bdid        := right.bdid,
						self.statusDate  := right.statusDate,
						self.dateVacated := right.dateVacated,
						self.dispType    := right.dispType,
						self.dispReason  := right.dispReason,
						self             := left),
					left outer,
					join_option);
		
		ENDMACRO;

		mac_temp_get_parties( temp_get_parties, local, temp_get_main, search_file )
		mac_temp_get_parties( temp_get_parties_daily, all, temp_get_main_daily, search_file_daily )
		
		// Now, pick your path depending on whether we're monitoring a daily Bankruptcy file or not.
		temp_parties := IF( job_config.monitor_daily_file, temp_get_parties_daily, temp_get_parties );
		
		
		// *****************************
		//      CALCULATE HASH VALUE
		// *****************************
		
		// Next, create a hash value from only those fields we're interested in (these are the ones in the temporary layout).
		temp_unrolled_hashes := project(temp_parties,
			transform(AccountMonitoring.layouts.history,
				self.pid := left.pid,
				self.rid := left.rid,
				self.hid := left.hid,
				self.did := left.save_did,
				self.bdid := left.save_bdid,
				self.timestamp := '',
				self.product_mask := AccountMonitoring.Constants.pm_bankruptcy,
				self.hash_value := hash64(
					left.fname,              // NAME (INCL ATTORNEY)
					left.mname,              // NAME (INCL ATTORNEY)
					left.lname,              // NAME (INCL ATTORNEY)
					left.prim_range,         // ADDRESS (INCL ATTORNEY)
					left.predir,             // ADDRESS (INCL ATTORNEY)
					left.prim_name,          // ADDRESS (INCL ATTORNEY)
					left.addr_suffix,        // ADDRESS (INCL ATTORNEY)
					left.postdir,            // ADDRESS (INCL ATTORNEY)
					left.unit_Desig,         // ADDRESS (INCL ATTORNEY)
					left.sec_Range,          // ADDRESS (INCL ATTORNEY)
					left.p_city_name,        // CITY (INCL ATTORNEY)
					left.st,                 // STATE (INCL ATTORNEY)
					left.zip,                // ZIP (INCL ATTORNEY)
					left.zip4,               // ZIP (INCL ATTORNEY)
					left.cname,              // BUSINESS NAME (INCL ATTORNEY)
					left.dCode,              //
					left.filing_status,      // DISPOSITION
					left.orig_chapter,       // CHAPTER
					left.assets_no_asset_indicator, // FUNDS
					left.assets,             // FUNDS
					left.liabilities,        // FUNDS
					left.trusteeName,        // TRUSTEE
					left.trusteeAddress,     // TRUSTEE
					left.trusteeCity,        // TRUSTEE
					left.trusteeState,       // TRUSTEE
					left.trusteeZip,         // TRUSTEE
					left.trusteeZip4,        // TRUSTEE
					left.trusteePhone,       // TRUSTEE
					left.trusteeID,          // TRUSTEE
					left.case_number,        // CASE NUMBER
					left.orig_case_number,   // CASE NUMBER
					left.caseID,             // CASE NUMBER
					left.date_filed,         // DATES
					left.orig_filing_date,   // DATES
					left.meeting_date,       // DATES
					left.meeting_time,       // DATES
					left.claims_deadline,    // DATES
					left.complaint_deadline, // DATES
					left.reopen_date,        // DATES
					left.case_closing_date,  // DATES
					left.dateReclosed,       // DATES
					left.dateVacated,        // DATES
					left.barDate,            // DATES
					left.statusDate,         // DATES
					// FLN 01/04/2011 We are removing this redundant data from the hash.
					// Note that release will require a special (hash updating) run of the CGM after the daily run.
					// SUM(left.status,HASH64(status_date,status_type)), // STATUS
					left.dispType,           // STATUS
					left.dispReason,         // STATUS
					left.court_code,         // COURT
					left.court_name,         // COURT
					left.court_location,     // COURT
					left.ssn,                // SSN/TID (INCL ATTORNEY)
					left.ssnMatch,           // SSN/TID (INCL ATTORNEY)
					left.tax_id,             // SSN/TID (INCL ATTORNEY)
					left.did,                // DID/ADL/BDID (INCL ATTORNEY)
					left.bdid                // DID/ADL/BDID (INCL ATTORNEY)
				)));
		
		// Then roll up the hashes for all records for a particular pid/rid.
		temp_rolled_hashes := rollup(sort(distribute(temp_unrolled_hashes,hash64(pid,rid,hid)),pid,rid,hid,record,local),
			transform(layouts.history,
				self.hash_value := left.hash_value + right.hash_value,
				self := left),
			pid,rid,hid,local);
		
		// output(in_portfolio,named('in_portfolio'));
		// output(temp_join_8_daily,named('temp_join_8_daily'));
		// output(temp_join_8,named('temp_join_8'));
		// output(temp_all_joins_daily,named('temp_all_joins_daily'));
		// output(temp_get_main_daily,named('temp_get_main_daily'));
		// output(choosen(temp_get_main,200),named('temp_get_main'));
		// output(temp_get_parties_daily,named('temp_get_parties_daily'));
		// output(choosen(temp_get_parties,200),named('temp_get_parties'));
		// output(choosen(temp_parties,200),named('temp_parties'));
		// output(temp_unrolled_hashes,named('temp_unrolled_hashes'));
	
		return temp_rolled_hashes;
		
	end;