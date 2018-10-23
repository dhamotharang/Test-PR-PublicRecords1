import doxie, RiskWiseFCRA, Watercraft, FCRA, LiensV2, riskwise, ut, Risk_Indicators, BankruptcyV2, BankruptcyV3,
				american_student_list, AlloyMedia_student_list, Prof_LicenseV2, paw, impulse_email, ln_propertyv2, 
				header, Inquiry_AccLogs, Gong, advo, Codes, iesp, address, corrections, Consumerstatement, RiskView;

EXPORT RiskViewReport_data := MODULE

	SHARED MAX_OVERRIDE_LIMIT := FCRA.compliance.MAX_OVERRIDE_LIMIT;
	SHARED todaysdate := ut.GetDate;
	SHARED isFCRA := true;

	export historydate(d) := if( d >= 999999, ut.getDate, (string)(d) + '01');

// ------------- Utility functions esdlName esdlAddress provide consistent handling for these ESDL structures -------------
	export iesp.share.t_name esdlName(string62 Fullname, string20 fname, string20 mname, string20 lname, string5 suffix, string3 prefix) := FUNCTION

		parts := lname <> '';
		useFull := Fullname <> '' and not parts;
		
		allname := if( parts, TRIM(fname) + ' ' + TRIM(mname) + ' ' + TRIM(lname) + ' ' + TRIM(Suffix), Fullname);
		parseAll := if( useFull, Address.CleanPersonFML73(allname), '');
		
		p_fname := if( useFull, TRIM(parseAll[6..25]), fname);
		p_mname := if( useFull, TRIM(parseAll[26..45]), mname);
		p_lname := if( useFull, TRIM(parseAll[46..65]), lname);
		p_sname := if( useFull, TRIM(parseAll[66..70]), suffix);
		p_pname := if( useFull, TRIM(parseAll[1..5]), prefix);
		
		res := ROW({allname, p_fname, p_mname, p_lname, p_sname, p_pname}, iesp.share.t_name);	
		return res;
	END;

	export iesp.share.t_address esdlAddress(string10 prim_range, string2 predir, string28 prim_name, string4 addr_suffix, 
																					string2 postdir, string10 unit_desig, string8 sec_range, string60 street1, 
																					string60 street2, string25 city_name, string2 st, string5 zip5, string4 zip4, 
																					string18 county, string9 postalcode, string50 statecityzip) := FUNCTION
		parts := prim_name <> '';
		useFull := street1 <> '' and not parts;
		
		makeFull := TRIM(prim_range) + ' ' + TRIM(predir) + ' ' + TRIM(prim_name) + ' ' + TRIM(addr_suffix) + ' ' + TRIM(postdir) + ' ' + TRIM(unit_desig) + ' ' + TRIM(sec_range);
		
		p_street1 := if( street1='', makeFull, street1);
		p_street2 := if( street1='', '', street2);
		
		resNoClean := ROW( {prim_range, predir, prim_name, addr_suffix, postdir, unit_desig, sec_range, p_street1, p_street2, city_name, st, zip5, zip4, county, postalcode, statecityzip}, iesp.share.t_address);
		clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(street1, city_name, st, zip5, street2);
		resCleaned := ROW( {clean_a2[1..10], clean_a2[11..12], clean_a2[13..40], clean_a2[41..44], clean_a2[45..46], clean_a2[47..56], clean_a2[57..64], street1, street2, clean_a2[90..114], clean_a2[115..116], clean_a2[117..121], clean_a2[122..125], '','',''}, iesp.share.t_address);

		res := if( useFull, resCleaned, resNoClean);

		return res;
	END;

	// -------------  CRIMINAL RECS  -------------
	export criminalrecs(dataset (doxie.layout_references) dids, dataset (fcra.Layout_override_flag) flag_file) := FUNCTION
			
			result_layout := record
				Corrections.layout_offender offender;
				Corrections.Layout_Offense_Common and not offense_category offense;
			end;

			res := RiskWiseFCRA._crim_data(dids, flag_file);
			both := join(res.offenders, res.offenses, left.offender_key = right.offender_key, 
						TRANSFORM( result_layout, self.offender := left, self.offense := right),
						LEFT OUTER, KEEP(1)); // disclosures only show one of the offenses per offender record.
			
			return both;
	END;

	// ------------- Student Records -------------
	export americanstudentrecs(dataset (doxie.layout_references) dids, dataset (fcra.Layout_override_flag) flag_file) := FUNCTION
			Layout_Student := record
				american_student_list.key_DID_FCRA;
				string college_major_exploded := '';
				string type_exploded := '';
				string code_exploded := '';
			end;

			student_ffids := SET(flag_file(file_id = FCRA.FILE_ID.STUDENT), flag_file_id );
			student_keys  := SET(flag_file(file_id = FCRA.FILE_ID.STUDENT), record_id );
			student_corr  := CHOOSEN(FCRA.key_override_student_new_ffid( keyed( flag_file_id in student_ffids ) ), MAX_OVERRIDE_LIMIT );

			Layout_Student amstudent_tx(dids l, american_student_list.key_DID_FCRA r) := TRANSFORM
				self.type_exploded := map( r.college_type = 'R' => 'PRIVATE',
																	 r.college_type = 'P' => 'PRIVATE',
																	 'PUBLIC');
				self.code_exploded := r.college_code_exploded;
				self := r;
			END;

			student_main := join(dids,american_student_list.key_DID_FCRA,
				left.did<>0 and keyed(left.did=right.l_did) and (string)right.key not in student_keys,
				amstudent_tx(left, right),
				KEEP(100), atmost(riskwise.max_atmost) 
			);
			student_deduped := dedup(sort(student_main,record),record);

			all_student_recs  := student_deduped + PROJECT( student_corr,
					transform( Layout_student,
						self.l_did := left.did,
						self := LEFT,
						self := []
					) );

			// this transform taken from risk_indicators.boca_shell_student_fcra. rollup all ASL records to the same record we would use in production
			all_student_recs asl_roll( all_student_recs le, all_student_recs ri ) := TRANSFORM
					self := map(
						// Use any other record over File Type 'M'
						le.file_type='M' and ri.file_type<>'M' => ri,
						ri.file_type='M' and le.file_type<>'M'=> le,
						
						// current ASL over historical -- SRC BECOMES HISTORICAL_FLAG
						le.historical_flag='C' and ri.historical_flag='H' => le,
						le.historical_flag='H' and ri.historical_flag='C' => ri,

						// take the newer record when the DLS are unequal
						le.date_last_seen > ri.date_last_seen => le,
						le.date_last_seen < ri.date_last_seen => ri,

						// take american student over alloy -- NOT APPLICABLE HERE SINCE IT'S ALL ASL
						le.historical_flag in ['C','H'] and ri.historical_flag = 'A' => le,
						ri.historical_flag in ['C','H'] and le.historical_flag = 'A' => ri,
						
						// take the newer record when the DFS are unequal
						le.date_first_seen > ri.date_first_seen => le,
						le.date_first_seen < ri.date_first_seen => ri,

						le
					);
				END;
			student_recs1 := rollup( all_student_recs, true, asl_roll(left,right) );
			student_recs2 := join(student_recs1, Codes.Key_Codes_V3,  
															left.college_major<>'' and 
															keyed(right.file_name='AMERICAN_STUDENT_LIST') and 
															keyed(right.field_name='COLLEGE_MAJOR') and
															keyed(right.field_name2='') and
															keyed(left.college_major = right.code),
															transform(Layout_Student, 
																				self.college_major_exploded := right.long_desc,
																				self := left),
															left outer, keep(1));   
			
			student_recs_filtered := student_recs2(file_type in ['A','H','C'] OR //Rqmt: 1.10.2.c
														(file_type='M' and (college_code <>'' or //Rqmt: 1.10.2.a
														tier2 <>'' or college_major<>'')) OR
														(file_type ='' and (college_code <>'' or //Rqmt: 1.10.2.b
														tier2 <>'' or college_major<>'' or
														class <>'' or income_level_code<>'')));
			student_recs := sort(student_recs_filtered, -date_last_Seen, -date_first_Seen);
			return student_recs;
	END;
					
	export alloystudentrecs(dataset (doxie.layout_references) dids, dataset (fcra.Layout_override_flag) flag_file) := FUNCTION

			Layout_Alloy := record
				AlloyMedia_student_list.Key_DID_FCRA;
				string college_major_exploded := '';
				string type_exploded := '';
				string code_exploded := '';
			end;

			alloy_ffids := SET(flag_file(file_id = FCRA.FILE_ID.STUDENT_ALLOY), flag_file_id );
			alloy_keys  := SET(flag_file(file_id = FCRA.FILE_ID.STUDENT_ALLOY), record_id );
			alloy_corr  := CHOOSEN(FCRA.key_override_alloy_ffid( keyed( flag_file_id in alloy_ffids ) ), MAX_OVERRIDE_LIMIT );


			// from david lenz:
			// The records are normalized since a raw record can contain multiple addresses.  So, a unique identifier would
			// be sequence_number + key_code + rawaid. You will notice that if you look at all of the fields in that record
			// that they are actually the same except for the standardized/clean fields.

			// string7   sequence_number;
			// string15  key_code;
			// unsigned8 rawaid; // string20?

			alloy_main := join(dids, AlloyMedia_student_list.Key_DID_FCRA,
				left.did<>0
					and keyed(left.did=right.did)
					and ( TRIM(right.sequence_number) + TRIM(right.key_code) + (string)right.rawaid ) not in alloy_keys
					,
				transform( Layout_Alloy, self := right ),
				KEEP(100), atmost(riskwise.max_atmost) 
			);
			alloy_deduped := dedup(sort(alloy_main,record),all);

			alloy_recs1  := alloy_deduped + PROJECT( alloy_corr, transform(Layout_alloy, self := left, self := []) );
			
			alloy_recs2 := join(alloy_recs1, Codes.Key_Codes_V3,  
															left.major_code<>'' and 
															keyed(right.file_name='ALLOY_STUDENT_LIST') and 
															keyed(right.field_name='MAJOR_CODE') and
															keyed(right.field_name2='') and
															keyed(left.major_code = right.code),
															transform(Layout_Alloy, 
																				self.college_major_exploded := right.long_desc,
																				self := left),
															left outer, keep(1));   

			Layout_Alloy Code_Type(Layout_Alloy l) := TRANSFORM
				self.type_exploded := map( l.public_private_code = '1' => 'PUBLIC',
																	 l.public_private_code = '2' => 'PRIVATE',
																	 '');
				self.code_exploded := map( l.public_private_code = '1' => 'FOUR YEAR SCHOOL',
																	 l.public_private_code = '2' => 'FOUR YEAR SCHOOL',
																	 l.public_private_code = '3' => 'TWO YEAR SCHOOL',
																	'');
				self := l;
			END;
			alloy_recs3 := project(alloy_recs2, Code_Type(left));
			
			alloy_recs_filtered := alloy_recs3(file_type in ['A','H','C'] OR //Rqmt: 1.10.2.c
														file_type='M' and (public_private_code <>'' or //Rqmt: 1.10.2.a
														tier2 <>'' or major_code <>'') OR
														file_type='' and (public_private_code <>'' or //Rqmt: 1.10.2.b
														tier2 <>'' or major_code <>'' or
														class_rank <>''));
			alloy_recs := sort(alloy_recs_filtered, -date_last_seen, -date_first_seen);
		return alloy_recs;
	END;
	
// ------------- Inquiries -------------
	// need to filter inqiries return with data restriction mask field 16... AutoStandardI.DataRestrictionI
	// we will do this in the calling routine, so as not to disturb the current inquiry code...
	// this returns them all, they should be filtered more by the caller.
	export inquiryrecs(dataset (doxie.layout_references) dids, dataset (fcra.Layout_override_flag) flag_file) := FUNCTION
		inquiry_recs := RiskWiseFCRA._inquiries_data(dids, flag_file);
		return inquiry_recs;
	END;


	// ------------- impulse -------------
	export impulserecs(dataset (doxie.layout_references) dids, dataset (fcra.Layout_override_flag) flag_file,
		boolean isDirectToConsumerPurpose = false) := FUNCTION
		Layout_Impulse := recordof(Impulse_Email.Key_Impulse_DID_FCRA);

		impulse_ffids := SET(flag_file(file_id = FCRA.FILE_ID.IMPULSE), flag_file_id );
		impulse_keys  := SET(flag_file(file_id = FCRA.FILE_ID.IMPULSE), trim(record_id) );
		impulse_corr  := CHOOSEN(FCRA.key_override_impulse_ffid( keyed( flag_file_id in impulse_ffids ) ), MAX_OVERRIDE_LIMIT );

		impulse_main := join(dids,Impulse_Email.Key_Impulse_DID_FCRA,
														left.did<>0 and keyed(left.did=right.did) and trim((string)right.did)+trim(right.created) not in impulse_keys and	// created and last modified should be 8 byte (20100215)
														isDirectToConsumerPurpose = false, //can't return data if this is enabled														
														transform( layout_impulse, self := right ),
														KEEP(100), atmost(riskwise.max_atmost) 
													);
		impulse_deduped := dedup(sort(impulse_main,record),all);

		impulse_recs1 := impulse_deduped + PROJECT( impulse_corr(isDirectToConsumerPurpose = false),
														transform( Layout_Impulse,
															self := LEFT,
															self := []
														) );
														
		impulse_recs := sort(impulse_recs1, -DateVendorLastReported, -DateVendorFirstReported);									

		return impulse_recs;
	END;

	// ------------- thrive -------------
	// after 9/24 _thrive_date only returns 'T$' records, no need to filter later
	export thriverecs(dataset (doxie.layout_references) dids, dataset (fcra.Layout_override_flag) flag_file) := FUNCTION
		thrive_recs := RiskWiseFCRA._thrive_data(dids, flag_file);
		return thrive_recs;
	END;
	
  // ------------- property ------------
	export propertyrecs(dataset (doxie.layout_references) dids, dataset (fcra.Layout_override_flag) flag_file) := FUNCTION

		layout_fares_search := ln_propertyv2.layout_search_building;
		layout_assessments := ln_propertyv2.layout_property_common_model_base;
		layout_deeds := ln_propertyv2.layout_deed_mortgage_common_model_base;


		unsigned2 MAX_PROP_KEEP  := 100;
		unsigned4 MAX_PROP_MATCH := 5000;

		// First, property search records are found, filtered by fares which contained in correction file,
		// then filtered by fares, belonging to "this" person only.
		// Thus we will have "pure" fare search dataset, which later used for fetching assessments and deeds.
		// Note that assess/deeds don't require filtering by "corrections" and "did", as only records with
		// fare_id from clean search file are used.

			// correction records: fares, PUIDs, pointers to flag file
			assessment_fares := SET (flag_file (file_id = FCRA.FILE_ID.ASSESSMENT),record_id);
			assessment_ffid  := SET (flag_file (file_id = FCRA.FILE_ID.ASSESSMENT), flag_file_id);

			deed_fares := SET (flag_file (file_id = FCRA.FILE_ID.DEED),record_id);
			deed_ffid  := SET (flag_file (file_id = FCRA.FILE_ID.DEED), flag_file_id);

			search_puids := SET (flag_file (file_id = FCRA.FILE_ID.SEARCH),record_id);
			search_ffid  := SET (flag_file (file_id = FCRA.FILE_ID.SEARCH), flag_file_id);

			// we need a combined list of fares from D & A:
			search_fares := assessment_fares + deed_fares;

			fares_layout := RECORD
				string8  sortdate;
				string1  source1 := '';
				string1  source2 := '';
				unsigned6 did;
				string12 own_fares_id;
			 
				string10 prim_range;
				string2  predir;
				string28 prim_name;
				string4  suffix;
				string2  postdir;
				string10 unit_desig;
				string8  sec_range;
				string25 city_name;
				string2  st;
				string5  zip;
				string8  purchasedate := '';
				string11 purchaseprice := '';
				string8  saledate := '';
				string11 saleprice := '';
				string8  assessmentdate := '';
				string11 assessmentprice := '';
			END;


			key_prop_did := ln_propertyv2.key_property_did (IsFCRA);
			fares_layout GetPropertyByDid (doxie.layout_references L, key_prop_did R) := TRANSFORM
				SELF.own_fares_id := R.ln_fares_id;
				SELF := L; 
				SELF := [];
			END;

			// Get property by did (filter out those for which corrections exists)
			pre_property_by_did := JOIN (dids, key_prop_did,
																	 Left.did<>0 AND 
																	 keyed (Left.did = Right.s_did) and
																	 keyed (Right.source_code_2 = 'P') AND
																	 right.source_code[1] <> 'C' and // filter out "Care-Of" records
																	 (Right.ln_fares_id NOT IN search_fares), // weed out corrected prop. records
																	 GetPropertyByDid (Left, Right), 
																	 atmost(riskwise.max_atmost), KEEP (MAX_PROP_KEEP));

			key_prop_search_fid := ln_propertyv2.key_search_fid (IsFCRA);

			fares_layout GetAddress (fares_layout L, key_prop_search_fid R) := TRANSFORM
				SELF.prim_range  :=  IF (L.prim_range='',R.prim_range,L.prim_range);
				SELF.prim_name   :=  IF (L.prim_name='',R.prim_name,L.prim_name);
				SELF.st          :=  IF (L.st='',R.st,L.st);
				SELF.city_name   :=  IF (L.city_name='', R.v_city_name, L.city_name);
				SELF.zip         :=  IF (L.zip='',R.zip,L.zip);
				SELF.predir      :=  IF (L.predir='', R.predir, L.predir);
				SELF.postdir     :=  IF (L.postdir='',R.postdir,L.postdir);
				SELF.suffix      :=  IF (L.suffix='', R.suffix, L.suffix);
				SELF.sec_range   :=  IF (L.sec_range='',R.sec_range,L.sec_range);
				SELF := L;
			END;

			// add address and filter out those fares records that don't have no address
			by_did_joined := JOIN (pre_property_by_did, key_prop_search_fid,
											keyed(Left.own_fares_id=Right.ln_fares_id) AND
											wild (Right.which_orig) AND
											keyed(Right.source_code_2='P') AND
											(Left.prim_name='' OR Left.prim_name=Right.prim_name) AND
											(Left.prim_range='' OR Left.prim_range=Right.prim_range) AND
											(Left.zip='' OR Left.zip=Right.zip),
											GetAddress (Left, Right),
											LEFT OUTER, atmost(riskwise.max_atmost)) (prim_name<>'' AND zip<>'');
			by_did := by_did_joined(prim_name != '' and prim_range != '');//fixing bug: 142998
			unique_addr := dedup( sort(by_did, prim_name, prim_range, zip, predir, postdir, suffix, sec_range),
																				 prim_name, prim_range, zip, predir, postdir, suffix, sec_range);
			key_prop_addr_fid := ln_propertyv2.key_addr_fid (IsFCRA);
			fares_layout GetPropertyByAddr (fares_layout L, key_prop_addr_fid R) := TRANSFORM
				SELF.own_fares_id := R.ln_fares_id;
				SELF := L;
			END;

			// get all fares for address so we can find the newest assessed information (required by spec)
			by_address := JOIN (unique_addr, key_prop_addr_fid,          
													(left.did<>0 ) and
													Left.prim_name<>'' AND
													keyed (Left.prim_name=Right.prim_name) AND
													keyed (Left.prim_range=Right.prim_range) AND
													keyed (Left.zip=Right.zip) AND
													keyed (Left.predir=Right.predir) AND
													keyed (Left.postdir=Right.postdir) AND
													keyed (Left.suffix=Right.suffix) AND
													keyed (Left.sec_range=Right.sec_range) and
													keyed (right.source_code_2 = 'P') AND
													(right.source_code_1 <> 'C') and // filter out "Care-Of" records
													(Right.ln_fares_id NOT IN search_fares), // weed out corrected prop. records
													GetPropertyByAddr (Left, Right),
													LEFT OUTER, atmost(riskwise.max_atmost), KEEP(MAX_PROP_KEEP));
			
			property_fid := DEDUP (SORT (by_did + by_address(prim_name != '' and prim_range != ''), RECORD), ALL);
			fares_search_full := JOIN (property_fid, key_prop_search_fid,
														keyed (Left.own_fares_id = Right.ln_fares_id) and
														((string)Right.persistent_record_id NOT IN search_puids), // weed out corrected prop. records
														TRANSFORM (layout_fares_search, SELF := Right),
														ATMOST (MAX_PROP_MATCH));

			good_fares := fares_search_full;
			fares_search1 := PROJECT (
				CHOOSEN (FCRA.key_override_property.search (keyed (flag_file_id IN search_ffid)), MAX_OVERRIDE_LIMIT),
				// temporarily, until override index will have persistent_id in the layout
				transform (layout_fares_search, Self := Left))
			+ fares_search_full; 
			search_fltrd := fares_search1(prim_name != '' and prim_range != '');//fixing bug: 142998	
			search := SORT (search_fltrd, -dt_last_seen, -dt_first_seen);
			// Now have did, own_fares_id, addresses -- all "good" records, which are not subject to corrections;
			// Next we take all search, assessments, deeds records: they will be filtered lately by did


			// format ASSESMENTS    
			layout_assessments ToAssessmentLayout (FCRA.key_override_property.assessment L) := TRANSFORM
				//the same way it is done in doxie_ln.key_assessor_fid_FCRA
				// SELF.proc_date := (unsigned) (IF (L.recording_date [1..6] !='', L.recording_date [1..6], L.sale_date[1..6]));
				SELF := L; // NB: input has a field "process_date"
			END;
			pre_assessments := JOIN (good_fares, ln_propertyv2.key_assessor_fid (true),
													 keyed (Left.ln_fares_id = Right.ln_fares_id),
													 TRANSFORM (layout_assessments, SELF := Right),
													 atmost(riskwise.max_atmost), KEEP (MAX_PROP_KEEP))
			+ PROJECT (CHOOSEN (FCRA.key_override_property.assessment (keyed (flag_file_id IN assessment_ffid)), MAX_OVERRIDE_LIMIT),
								 ToAssessmentLayout (Left));

			deduped_assessments := DEDUP (SORT (pre_assessments, RECORD), ALL);
			assessments := sort(deduped_assessments, -assessed_value_year, ln_fares_id);

			// format DEEDS    
			layout_deeds ToDeedLayout (FCRA.key_override_property.deed L) := TRANSFORM
				//the same way it is done in FCRA key_deed_fid
				// SELF.proc_date := (unsigned) (L.recording_date[1..6]);
				SELF := L; // NB: input has a field "process_date"
			END;
			pre_deeds := JOIN (good_fares, ln_propertyv2.key_deed_fid (true),
												 keyed (Left.ln_fares_id = Right.ln_fares_id) and
												 (Right.ln_fares_id NOT IN deed_fares),
												 TRANSFORM (layout_deeds, SELF := Right),
												 atmost(riskwise.max_atmost), KEEP (MAX_PROP_KEEP))
			+ PROJECT (CHOOSEN (FCRA.key_override_property.deed (keyed (flag_file_id IN deed_ffid)), MAX_OVERRIDE_LIMIT),
								 ToDeedLayout (Left));

			deduped_deeds := DEDUP (SORT (pre_deeds, RECORD), ALL);
			deeds := sort(deduped_deeds, -contract_date, ln_fares_id);

			fares_layout getalldeeds(search l, deeds r) := TRANSFORM
				self.sortdate := r.recording_date;
				self.own_fares_id := l.ln_fares_id;
				self.city_name := l.p_city_name;
				self.source1 := l.source_code[1];
				self.source2 := l.source_code[2];

				boolean isSell := l.source_code[1] = 'S' and l.source_code[2] = 'P';
				boolean isPrch := l.source_code[1] = 'O' and l.source_code[2] = 'P';
				self.purchasedate := if( isPrch, r.recording_date, '');
				self.purchaseprice := if( isPrch, r.sales_price, '');
				self.saledate := if( isSell, r.recording_date, '');
				self.saleprice := if( isSell, r.sales_price, '');
				self := l;
			END;

			fares_layout getallassessments(search l, assessments r) := TRANSFORM
				self.own_fares_id := l.ln_fares_id;
				self.city_name := l.p_city_name;
				self.source1 := l.source_code[1];
				self.source2 := l.source_code[2];

				boolean market := if(r.market_total_value<>'', true, false);
				self.assessmentprice := if(market, r.market_total_value, r.assessed_total_value);
				self.assessmentdate := if( market, r.market_value_year , r.assessed_value_year );
				self.sortdate := self.assessmentdate;

				boolean isSell := l.source_code[1] = 'S' and l.source_code[2] = 'P';
				boolean isPrch := l.source_code[1] = 'O' and l.source_code[2] = 'P';
				self.purchasedate := if( isPrch, r.recording_date, '');
				self.purchaseprice := if( isPrch, r.sales_price, '');
				self.saledate := if( isSell, r.recording_date, '');
				self.saleprice := if( isSell, r.sales_price, '');
				self := l;
			END;
			
			jd := join(search, assessments, left.ln_fares_id = right.ln_fares_id, getallassessments(left, right));
			dd := join(search, deeds,  left.ln_fares_id = right.ln_fares_id, getalldeeds(left, right));
			
		  props := sort( jd + dd, prim_name, prim_range, zip, predir, postdir, suffix, sec_range, -sortdate, -saledate);

			fares_layout doPropRoll(fares_layout l, fares_layout r, integer did) := TRANSFORM
				isRdid := r.did=did;
				self.did := if(isRdid, r.did, l.did);
												
				isAssessment := l.assessmentdate > r.assessmentdate;
				self.assessmentdate := if(isAssessment, l.assessmentdate, r.assessmentdate);
				self.assessmentprice := if(isAssessment, l.assessmentprice, r.assessmentprice);
				

				isPurchase := isRdid and r.purchasedate!='';
				isSale := isRdid and l.saledate='';

				self.purchasedate := if(isPurchase, r.purchasedate, l.purchasedate);
				self.purchaseprice := if(isPurchase, r.purchaseprice, l.purchaseprice);
				
				self.saledate := if(isSale, r.saledate, l.saledate);
				self.saleprice := if(isSale, r.saleprice, l.saleprice);
				self := l;
			END;
			finalown := rollup(props, left.prim_name=right.prim_name and 
																left.prim_range = right.prim_range and  
																left.zip = right.zip and 
																left.predir = right.predir and 
																left.postdir = right.postdir and 
																left.suffix = right.suffix and 
																left.sec_range = right.sec_range, doPropRoll(left, right, dids[1].did));
			return finalown(did=dids[1].did);
		END;

	// ------------- consumer statement -------------
	export consumerstmt(dataset (risk_indicators.Layout_Boca_Shell) dids) := FUNCTION
		
		layout_res := RECORD
				Unsigned8 LexID;
				String9  SSN;
				String20 fname;
				String20 lname;
				String2000 cs_text;
		END;
		
		bydid := join( dids, Consumerstatement.key.fcra.lexid, 
										left.did<>0 and
										KEYED(left.did = right.LexID), 
										TRANSFORM(layout_res, self:=right), 
										atmost(riskwise.max_atmost));
		byssn := join( dids, Consumerstatement.key.fcra.ssn, 
										left.shell_Input.ssn<>'' and
										KEYED(left.shell_Input.ssn = right.ssn) and
										datalib.NameMatch (Left.shell_Input.fname,  '',  Left.shell_Input.lname, 
                                        Right.fname, '', Right.lname) < 3, 
										TRANSFORM(layout_res, self:=right), 
										atmost(riskwise.max_atmost));											

    stmt := if(exists(bydid), bydid, byssn);
		return stmt;
	END;				
		

	shared addrhist_layout := RECORD
		integer seq;
		integer groupid; // assign unique number to each unique address. 
		integer historydate;
		string12 ln_fares_id := '';				
		header.layout_header;
		string8  assessmentdate := '';
		string11 assessmentprice := '';
		string32 AddrCharacteristics := '';
		string5 vendor_source_flag:='';
		string4 standardized_land_use_code := '';
		string120 land_use := '';
	END;		

	export getAddrCharacteristics(dataset(addrhist_layout) in_addr) := FUNCTION

		layout_working := RECORD
			addrhist_layout;
			Risk_Indicators.Layouts.Layout_Addr_Flags Addr_Flags;
			string1 college_indicator;
		END;
			
		// search citystatezip for each address to get the corp/mil flag
		layout_working getZipFlag(addrhist_layout le, riskwise.Key_CityStZip ri) := transform
			self.addr_flags.corpMil := if(ri.zipclass in ['U','M'], '1', '0');
			self := le;
			self := [];	// blank out the rest of the addr flags initially
		end;
		wZipClass := join(in_addr, riskwise.Key_CityStZip,	
																	keyed(right.zip5=left.zip) and left.zip!='',
																	getZipFlag(left, right), left outer, 
																	ATMOST(keyed(right.zip5=left.zip),RiskWise.max_atmost));

		layout_working zipRoll(layout_working le, layout_working ri) := transform
			self.addr_flags.corpMil := if(le.addr_flags.corpMil='1', '1', ri.addr_flags.corpMil);	
			self := le;
		end;
		wZipClassRoll := ROLLUP(SORT(wZipClass, groupId),left.groupId=right.groupId, zipRoll(left,right));


		// search HRI for each record to get prisonAddr and highRisk addr flags
		layout_working getHRIflags(layout_working le, risk_indicators.key_HRI_Address_To_SIC_filtered_fcra ri) := transform
			self.addr_flags.prisonAddr := if(ri.sic_code='2225', '1', '0');
			self.addr_flags.highRisk := if(ri.sic_code<>'', '1', '0');
			self := le;
		end;
		wHRI := join(wZipClassRoll, risk_indicators.key_HRI_Address_To_SIC_filtered_fcra,  
												left.zip!='' and left.prim_name != '' and
												keyed(left.zip=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.suffix=right.suffix) and 
												keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and 
												keyed(left.sec_range=right.sec_range), 
												// check date
												// and right.dt_first_seen < history_Date, // no history date filtering in this function currently, it's used in RiskWiseFCRA.FCRAData_Service only which doesn't support retro testing
												getHRIflags(left,right), left outer,
												ATMOST(keyed(left.zip=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.suffix=right.suffix) and
														keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and
														keyed(left.sec_range=right.sec_range), RiskWise.max_atmost), keep(100));	
								
								
		layout_working hriRoll(layout_working le, layout_working ri) := transform
			self.addr_flags.prisonAddr := if(le.addr_flags.prisonAddr='1', '1', ri.addr_flags.prisonAddr);	
			self.addr_flags.highRisk := if(le.addr_flags.highRisk='1', '1', ri.addr_flags.highRisk); // == 1 transient or institutioinal
			self := le;
		end;
		wHRIRoll := ROLLUP(SORT(wHRI, groupId),left.groupId=right.groupId,hriRoll(left,right));



		// search advo for each record to get the advo flags
		layout_working getAdvoFlags(wHRIRoll le, Advo.Key_Addr1_FCRA ri) := transform
			self.addr_flags.doNotDeliver := ri.dnd_indicator;
			self.addr_flags.deliveryStatus := Map(ri.throw_back_indicator='Y' => 'T',	
																						ri.seasonal_delivery_indicator='E' => 'C', //seasonal
																						ri.seasonal_delivery_indicator='Y' => 'S', // seasonal
																						ri.address_vacancy_indicator='Y' => 'V',
																						'');
			self.addr_flags.addressType := Map(	ri.residential_or_business_ind = 'A' => 'A',
																					ri.residential_or_business_ind = 'B' => 'B',
																					ri.residential_or_business_ind = 'C' => 'C',
																					ri.residential_or_business_ind = 'D' => 'D',
																					'');
			self.addr_flags.dropIndicator := Map(	ri.drop_indicator = 'C' => 'C',	
																						ri.drop_indicator = 'Y' => 'Y',
																						ri.drop_indicator = 'N' => 'N',
																						ri.drop_indicator = '' => 'S',
																						'');
      self.college_indicator := ri.college_indicator;																						
			self := le;
		end;
		wAdvo  := join(wHRIRoll, Advo.Key_Addr1_FCRA,
				left.zip != '' and left.prim_range != '' and
				keyed(left.zip = right.zip) and
				keyed(left.prim_range = right.prim_range) and
				keyed(left.prim_name = right.prim_name) and
				keyed(left.suffix = right.addr_suffix) and
				keyed(left.predir = right.predir) and
				keyed(left.postdir = right.postdir) and
				keyed(left.sec_range = right.sec_range),
				getAdvoFlags(left, right), LEFT OUTER,
				KEEP(1), atmost(riskwise.max_atmost));

		addrhist_layout add_characteristic(layout_working l) := TRANSFORM
			self.AddrCharacteristics := map( 
																			 l.zip4 = '' => 'Invalid',
																			 l.addr_flags.prisonAddr = '1' => 'Correctional Institution',
																			 l.addr_flags.highRisk = '1' => 'Transient or Institutional',
																			 l.addr_flags.deliveryStatus ='C' => 'Seasonal',
																			 l.addr_flags.deliveryStatus ='S' => 'Seasonal',
																			 l.college_indicator = 'Y' => 'Educational Institution',
																			 '');  
      self := l;
		END;
		return project(wAdvo, add_characteristic(left));
	END;

// ------------- address history -------------
	export addrHistory(dataset (risk_indicators.Layout_Boca_Shell) dids, dataset (fcra.Layout_override_flag) flagrecs, integer bsVersion_in, string50 DataRestrictionMask) := FUNCTION

			unsigned2 MAX_PROP_KEEP  := 100;
			unsigned4 MAX_PROP_MATCH := 5000;	
			
			risk_indicators.Layout_Output toLO(risk_indicators.Layout_Boca_Shell l) := TRANSFORM
				
				SELF.header_correct_record_id       := SET(flagrecs(file_id = FCRA.FILE_ID.hdr),record_id);

				self := l;
				self := l.Shell_Input;
				self := [];
			END;
			
			prepped := group(sort(project( dids, toLO(left)), seq, did), seq, did);
						
			hdr1 := risk_indicators.iid_getHeader(prepped, 1, 1, true, false,bsVersion:=bsVersion_in, DataRestriction:=DataRestrictionMask);

			addrhist_layout header_transform(hdr1 l, integer c) := TRANSFORM
				lastdate := if(l.dt_last_seen < 1000000, (integer)((string)l.dt_last_seen + '01'), l.dt_last_seen);
				// 5 year cut off for dt last seen (per requirements).

				inrange := ut.DaysApart(historydate(l.historydate),l.dt_last_seen[1..8]) < ut.DaysInNYears(5);
				self.seq := if( not inrange, skip, l.seq);
				self.groupid := c;
				self.historydate := (integer)historydate(l.historydate);
				self.ssn := if(l.ssn=l.h.ssn, l.ssn, ''); // per dave, only keep ssn if it matches the input ssn.
				self := l.h;				
			END;
			
			allheader := project(ungroup(hdr1), header_transform(left, counter));
		//bug fix: 142995	- changed sort to match the rollup criteria									
			sortedallheader := sort(allheader, -zip, -prim_name, -prim_range, -predir, -suffix, -postdir,
				-city_name, -st, -dt_last_seen, -dt_first_seen);
						
			addrhist_layout unique_header(addrhist_layout l, addrhist_layout r) := TRANSFORM
				self.dt_first_seen := if( (l.dt_first_seen < r.dt_first_seen) and (l.dt_first_seen >99999), l.dt_first_seen, r.dt_first_seen);
				self.dt_last_seen := if( l.dt_last_seen > r.dt_last_seen, l.dt_last_seen, r.dt_last_seen);
				self.ssn := if( l.ssn='', r.ssn, l.ssn);
				self.dob := if( l.dob=0, r.dob, l.dob);
				self := l;
			END;
	
			unique_header_recs := rollup(sortedallheader, 
																		left.zip=right.zip AND left.prim_name=right.prim_name AND
																		left.prim_range= right.prim_range AND left.predir=right.predir
																		AND left.suffix=right.suffix AND
																		left.postdir=right.postdir AND
																		left.city_name=right.city_name AND left.st=right.st,
																		unique_header(left, right));
			
      // unique_header_recs is the address history list in order...no we can get fares to complete the assessment info
			// and deeds if needed.
// 		Get Fares ids for all addresses...needed to get the tax asses and to flag valid eq records.																		

			assessment_fares := SET (flagrecs (file_id = FCRA.FILE_ID.ASSESSMENT),record_id);
			assessment_ffid  := SET (flagrecs (file_id = FCRA.FILE_ID.ASSESSMENT), flag_file_id);

			deed_fares := SET (flagrecs (file_id = FCRA.FILE_ID.DEED),record_id);
			deed_ffid  := SET (flagrecs (file_id = FCRA.FILE_ID.DEED), flag_file_id);

			search_puids := SET (flagrecs (file_id = FCRA.FILE_ID.SEARCH),record_id);
			search_ffid  := SET (flagrecs (file_id = FCRA.FILE_ID.SEARCH), flag_file_id);

			// we need a combined list of fares from D & A:
			layout_fares_search := ln_propertyv2.layout_search_building;
			layout_assessments := ln_propertyv2.layout_property_common_model_base;
			layout_deeds := ln_propertyv2.layout_deed_mortgage_common_model_base;
			search_fares := assessment_fares + deed_fares;

			key_prop_addr_fid := ln_propertyv2.key_addr_fid (IsFCRA);
			header_withfares := JOIN (unique_header_recs, key_prop_addr_fid,          
													Left.prim_name<>'' AND
													keyed (Left.prim_name=Right.prim_name) AND
													keyed (Left.prim_range=Right.prim_range) AND
													keyed (Left.zip=Right.zip) AND
													keyed (Left.predir=Right.predir) AND
													keyed (Left.postdir=Right.postdir) AND
													keyed (Left.suffix=Right.suffix) AND
													keyed (Left.sec_range=Right.sec_range) and
													keyed (right.source_code_2 = 'P') AND
													(right.source_code_1 <> 'C') and // filter out "Care-Of" records
													(Right.ln_fares_id NOT IN search_fares), // weed out corrected prop. records
													TRANSFORM(addrhist_layout, self.ln_fares_id := right.ln_fares_id, self := left),
													LEFT OUTER, atmost(riskwise.max_atmost), KEEP(MAX_PROP_KEEP));

			property_fid_dedup := DEDUP (SORT (header_withfares, RECORD), ALL); // remove dup fids...

			// collect assessment information....needed for all history records.
			pre_assessments := JOIN (property_fid_dedup, ln_propertyv2.key_assessor_fid (true),
													 left.ln_fares_id<>'' AND
													 keyed (Left.ln_fares_id = Right.ln_fares_id),
													 TRANSFORM (layout_assessments, SELF := Right),
													 atmost(riskwise.max_atmost), KEEP (MAX_PROP_KEEP))
													 + PROJECT (CHOOSEN (FCRA.key_override_property.assessment (keyed (flag_file_id IN assessment_ffid)), MAX_OVERRIDE_LIMIT),
														TRANSFORM(layout_assessments, self:=left));
					 
			deduped_assessments := DEDUP (SORT (pre_assessments, RECORD), ALL);
			assessments := sort(deduped_assessments, -assessed_value_year, ln_fares_id);
			
			// trac
			addrhist_layout assessedinfo_tx(addrhist_layout l, layout_assessments r) := TRANSFORM
				boolean market := if(r.market_total_value<>'', true, false);
				self.assessmentprice := if(market, r.market_total_value, r.assessed_total_value);
				self.assessmentdate := if( market, r.market_value_year , r.assessed_value_year );
				self.standardized_land_use_code := r.standardized_land_use_code;
				self.vendor_source_flag := map(r.vendor_source_flag='F' => 'FAR_F',
																				r.vendor_source_flag='S' => 'FAR_S',
																				r.vendor_source_flag='O' => 'OKCTY',
																				r.vendor_source_flag='D' => 'DAYTN',
										'');
				self := l;
			END;
			header_with_assessment := join(property_fid_dedup, assessments, Left.ln_fares_id = Right.ln_fares_id, 
																assessedinfo_tx(left, right), LEFT OUTER);

			addrhist_layout bestassessed(addrhist_layout l, addrhist_layout r) := TRANSFORM
				isleft := l.assessmentdate > r.assessmentdate;
				self.assessmentdate := if(isleft, l.assessmentdate, r.assessmentdate);
				self.assessmentprice := if( isleft, l.assessmentprice, r.assessmentprice);
				BOOLEAN useL := l.standardized_land_use_code <> '';
				self.standardized_land_use_code := if( useL, l.standardized_land_use_code, r.standardized_land_use_code);
				self.vendor_source_flag := if( useL, l.vendor_source_flag, r.vendor_source_flag);
				self := l;
			END;
			
			finalhistory := rollup(sort(header_with_assessment, groupid), left.groupid=right.groupid, bestassessed(left,right));
			
			// get the land use description
      finalhistory1 := join(finalhistory, Codes.Key_Codes_V3,  
															trim(left.standardized_land_use_code)<>'' and 
															keyed(right.file_name='FARES_2580') and 
															keyed(right.field_name='STANDARDIZED_LAND_USE_CODE') and
															keyed(right.field_name2=left.vendor_source_flag) and
															keyed(left.standardized_land_use_code = right.code),
															transform(addrhist_layout, 
																				self.land_use := right.long_desc, // this desc is of format xxx|desc...just return this per dave.
																				self := left),
															left outer, keep(1));   
			// last step, addin address Characteristics
      addrchar := getAddrCharacteristics(finalhistory1);
			return sort(addrchar, -dt_last_seen);
	END;
	
// ------------- best address from addr hist + best phone and best dob -------------
	export summary(dataset(addrhist_layout) addrhist, risk_indicators.Layout_Boca_Shell bs, boolean inqRestrict) := FUNCTION

			// first address in list that is equifax valid (no eq only)
			// OR that matches the input
			bestValid := choosen(addrhist, 1);

			phonejoin_layout := record
				integer groupid;
				boolean didmatch;
				integer namematch;
				string8 dt_last_seen;
				string10 phone;
				//Gong_v2.Layout_GongHistory gong; // only needed for testing...
			END;

			bestValid_plusphone := join(bestValid, Gong.Key_FCRA_History_Address,
												trim(left.prim_name)!='' and trim(left.zip)!='' and
												keyed(right.prim_name=left.prim_name) and keyed(right.st=left.st) and 
												keyed(right.z5=left.zip) and
												keyed(right.prim_range=left.prim_range) and left.sec_range=right.sec_range and
												right.current_flag,
												TRANSFORM( phonejoin_layout,
																		self.groupid := left.groupid;
																		self.didmatch := left.did = right.did;
																		self.namematch := 1;
																		self.dt_last_seen := right.dt_last_seen;
																		// self.gong := right; // only copy out if we need to look at it.
																		self.phone := right.phone10),
												atmost(RiskWise.max_atmost),										
												keep(100), left outer);
												
			phonejoin_layout rollupphones(phonejoin_layout l, phonejoin_layout r) := TRANSFORM
				useleft := l.didmatch or (not r.didmatch); // these are all in descending date order so just take the first didmatch encountered
				self := if( useleft, l, r);
			END;
			
			bestValid_plusphone_rolled := rollup(sort( bestValid_plusphone, groupid, -dt_last_seen), left.groupid = right.groupid, 
																						rollupphones(left, right));
			bestValid_finalphone := join(bestValid, bestValid_plusphone_rolled, left.groupid = right.groupid, 
																			TRANSFORM(addrhist_layout, self.phone := right.phone, self := left),
																			left outer); // right is unique on groupid, so left out is good / will not add records
									
			iesp.riskviewreport.t_RvReportSummaryRecord formatsummaryrec(addrhist_layout l, risk_indicators.Layout_Boca_Shell bs):= TRANSFORM
				self.Name := esdlName('', l.fname, l.mname, l.lname, l.name_suffix, l.title);
				self.Address := esdlAddress(l.prim_range, l.predir, l.prim_name, l.suffix, l.postdir, l.unit_desig, l.sec_range, '','', l.city_name, l.st, l.zip, l.zip4, '','','');
				self.SSN := l.ssn;
				self.Phone := l.phone;
				self.DOB := iesp.ECL2ESP.toDate((integer)bs.reported_dob);
				self.AddressStability := bs.addr_stability;
				self.InquiriesRestricted := inqRestrict;
				self.UniqueId := (string)l.did;
			END;
				
			res := project(bestValid_finalphone, formatsummaryrec(left, bs));
			return res[1];
	END;

END;