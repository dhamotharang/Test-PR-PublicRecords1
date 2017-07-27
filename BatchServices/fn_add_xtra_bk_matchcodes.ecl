import batchservices, autokey_batch, ut, NID;

export fn_add_xtra_bk_matchcodes(dataset(BatchServices.layout_BankruptcyV3_Batch_out) 	ds, 
								 dataset(BatchServices.layout_BankruptcyV3_Batch_in) 	ds_comp) := FUNCTION
	
	BOOLEAN 	enable_extra_name_MC_logic 	:= TRUE : STORED('ExtraNameMCLogic');
	
	/* enable/disable augmented ADL addr append - see Bug 51541 */
	BOOLEAN 	matchcode_adl_append		:= TRUE : STORED('MatchCode_ADL_Append'); 
	
	/* did/bdid score thresholds as defined by interface 		*/
	UNSIGNED3	did_score_threshold			:= Constants.Bankruptcy.DEFAULT_DID_SCORE_THRESHOLD 	: STORED('DID_Score_Threshold');
	UNSIGNED3	bdid_score_threshold		:= Constants.Bankruptcy.DEFAULT_BDID_SCORE_THRESHOLD 	: STORED('BDID_Score_Threshold');
	
	/*	output versus input layouts that are to be compared in computing matc code	*/
	rec_out 	:= BatchServices.layout_BankruptcyV3_Batch_out;
	rec_in		:= BatchServices.layout_BankruptcyV3_Batch_in;
	
	/* remove previous match codes */
	ds_cln := project(ds, transform(rec_out, self.matchcode := '', self := left));
	
	
	/* MACRO to determine whether a fname/lname combination matches another	*/
	NameMatches(fname1, lname1, fname2, lname2) := MACRO
		(LENGTH(TRIM(fname1, LEFT, RIGHT)) > 0 AND LENGTH(TRIM(lname1, LEFT, RIGHT)) > 0
			AND LENGTH(TRIM(fname2, LEFT, RIGHT)) > 0 AND LENGTH(TRIM(lname2, LEFT, RIGHT)) > 0)
		AND
		StringLib.StringCompareIgnoreCase(	NID.PreferredFirstNew(TRIM(REGEXREPLACE('\\W', fname1, ' '), LEFT, RIGHT), true)[1..4],
																				NID.PreferredFirstNew(TRIM(REGEXREPLACE('\\W', fname2, ' '), LEFT, RIGHT), true)[1..4]) = 0
		AND
		(StringLib.StringCompareIgnoreCase(	TRIM(REGEXREPLACE('\\W', lname1, ' '), ALL)[1..10],
																				TRIM(REGEXREPLACE('\\W', lname2, ' '), ALL)[1..10]) = 0
		 OR ut.IsNamePart(trim(lname1,LEFT,RIGHT),trim(lname2,LEFT,RIGHT),false) 
		 OR ut.IsNamePart(trim(lname2,LEFT,RIGHT),trim(lname1,LEFT,RIGHT),false))
	ENDMACRO;
	
	
	/* MACRO to determine whether a cname matches another					*/
	CompanyNameMatches(cname1, cname2) := MACRO
		(LENGTH(TRIM(cname1, LEFT, RIGHT)) > 0 AND LENGTH(TRIM(cname2, LEFT, RIGHT)) > 0)
		AND
		StringLib.StringCompareIgnoreCase(	
				DataLib.CompanyClean(TRIM(cname1, LEFT, RIGHT))[1..41], 
				DataLib.CompanyClean(TRIM(cname2, LEFT, RIGHT))[1..41]
		) = 0
	ENDMACRO;
	
	
	/* name match code 				*/
	NameMatchCond() := MACRO
		(
			NameMatches(left.debtor_1_fname,	left.debtor_1_lname,
						right.name_first, 		right.name_last)
			OR
			NameMatches(left.debtor_2_fname,	left.debtor_2_lname,
						right.name_first, 		right.name_last)
			OR
			NameMatches(left.debtor_3_fname,	left.debtor_3_lname,
						right.name_first, 		right.name_last)
			OR
			NameMatches(left.debtor_4_fname,	left.debtor_4_lname,
						right.name_first, 		right.name_last)
			OR
			NameMatches(left.debtor_5_fname,	left.debtor_5_lname,
						right.name_first, 		right.name_last)   
		)		
		OR
		(
			CompanyNameMatches(left.debtor_1_cname, right.comp_name)
			OR
			CompanyNameMatches(left.debtor_2_cname, right.comp_name)
			OR
			CompanyNameMatches(left.debtor_3_cname, right.comp_name)
			OR
			CompanyNameMatches(left.debtor_4_cname, right.comp_name)
			OR
			CompanyNameMatches(left.debtor_5_cname, right.comp_name)
		)
	ENDMACRO;
	
	ds_name := join(
					ds_cln,
					ds_comp,
					left.acctno = right.acctno,
					transform(
						rec_out,
						self.matchcode 	:= if(NameMatchCond(), 
												trim(left.matchcode, left, right) + MatchCodes.name, 
												trim(left.matchcode));
						self := left),
					left outer);

	
	
	/* full SSN match code 			*/
	
	FullSSNMatchCond() := MACRO
		(right_ssn_trim != '' OR right_taxid_trim != '')
		AND
		(
			((length(right_ssn_trim) = 8 OR length(right_ssn_trim) = 9)
				AND
				(left_ssn_trim = right_ssn_trim OR left_ssnmatch_trim = right_ssn_trim))
			OR
			(left_ssn_trim = '' AND left_taxid_trim = right_taxid_trim)
		)
	ENDMACRO;
	
	ds_ssn_full := JOIN(
					ds_name,
					ds_comp,
					LEFT.acctno = RIGHT.acctno,
					TRANSFORM(rec_out,
						left_ssn_trim 		:= TRIM(LEFT.debtor_ssn, LEFT, RIGHT);
						left_ssnmatch_trim 	:= TRIM(LEFT.debtor_ssnmatch, LEFT, RIGHT);
						left_taxid_trim 	:= TRIM(LEFT.debtor_tax_id, LEFT, RIGHT);
						right_ssn_trim 		:= TRIM(RIGHT.ssn, LEFT, RIGHT);
						right_taxid_trim 	:= TRIM(RIGHT.fein, LEFT, RIGHT);
						SELF.matchcode 		:= IF(FullSSNMatchCond(),
												TRIM(LEFT.matchcode) + MatchCodes.ssn_full,
												TRIM(LEFT.matchcode));
						SELF := LEFT),
					LEFT OUTER);
	
	
	
	/* redacted SSN match code 		*/
	RedactedSSNMatchCond() := MACRO
		right.ssn != ''
		AND
		( 
			(length(left_ssn_trim) = 4 AND length(left_ssnmatch_trim) != 9
			  AND
			  (
			    (length(right_ssn_trim) = 9 AND left_ssn_trim = right_ssn_trim[6..9])
			    OR
			    (length(right_ssn_trim) = 4 AND left_ssn_trim = right_ssn_trim)))
			OR
			(length(right_ssn_trim)= 4 					AND 
				length(left_ssnmatch_trim) = 9 		AND
				left_ssnmatch_trim[6..9] = right_ssn_trim)
			OR
			(length(left_ssn_trim) = 9
				AND
				(
					/* incoming ssn has only four chars */
					(length(right_ssn_trim) = 4 
						AND 
						(left_ssn_trim[6..9] = right_ssn_trim OR left_ssnmatch_trim[6..9] = right_ssn_trim))
					OR
					/* input ssn is redacted, but prefixed with 00000 */
					( (LENGTH(right_ssn_trim) = 9 AND right_ssn_trim[1..5] = '00000')
						AND (right_ssn_trim[6..9] = left_ssn_trim[6..9] OR right_ssn_trim[6..9] = left_ssnmatch_trim[6..9]))
				)
			 )
		)

	ENDMACRO;
	
	ds_ssn_red := join(
					ds_ssn_full, 
					ds_comp, 
					left.acctno = right.acctno,
					transform(rec_out,
						left_ssn_trim := trim(left.debtor_ssn, left, right);
						left_ssnmatch_trim := TRIM(LEFT.debtor_ssnmatch, LEFT, RIGHT);
						right_ssn_trim := trim(right.ssn, left, right);
						self.matchcode := if(RedactedSSNMatchCond(),
											trim(left.matchcode) + MatchCodes.ssn_red,
											trim(left.matchcode));
						self := left),
					left outer);
	
	
	
	/* probable SSN match code 		*/
	
	ProbableSSNMatchCond() := MACRO
		right.ssn != ''
		AND
		(length(right_ssn_trim) = 9)
		AND
		(
			BatchServices.Functions.fn_ssn_accunear(left_ssn_trim, right_ssn_trim)
			OR
			BatchServices.Functions.fn_ssn_accunear(left_ssnmatch_trim, right_ssn_trim)
		)
	ENDMACRO;
	
	ds_ssn_prob := join(
					ds_ssn_red,
					ds_comp,
					left.acctno = right.acctno,
					transform(rec_out,
						left_ssn_trim := trim(left.debtor_ssn);
						left_ssnmatch_trim := trim(left.debtor_ssnmatch);
						right_ssn_trim := trim(right.ssn);
						self.matchcode 	:= if(ProbableSSNMatchCond(),
												trim(left.matchcode) + MatchCodes.ssn_prob,
												trim(left.matchcode));
						self := left),
					left outer);
	
	
	
	/*	address match					*/
	AddrMatchCond() := MACRO
		(left.debtor_prim_range != ''
			OR left.debtor_predir != ''
			OR left.debtor_prim_name != ''
			OR left.debtor_addr_suffix != ''
			OR left.debtor_postdir != ''
			OR left.debtor_unit_desig != ''
			OR left.debtor_sec_range != '')
		AND
		(
			(StringLib.StringToUpperCase(trim(left.debtor_prim_range, left, right)) = StringLib.StringToUpperCase(trim(right.prim_range, left, right)) 
				or right.prim_range = '')
			and 
			(StringLib.StringToUpperCase(trim(left.debtor_predir, left, right))	= StringLib.StringToUpperCase(trim(right.predir, left, right)) 
				or right.predir = '')
			and 
			(StringLib.StringToUpperCase(trim(left.debtor_prim_name, left, right)) = StringLib.StringToUpperCase(trim(right.prim_name, left, right)))
			and 
			(StringLib.StringToUpperCase(trim(left.debtor_addr_suffix, left, right)) = StringLib.StringToUpperCase(trim(right.addr_suffix, left, right)) 
				or right.addr_suffix = '')
			and
			(StringLib.StringToUpperCase(trim(left.debtor_postdir, left, right)) = StringLib.StringToUpperCase(trim(right.postdir, left, right)) 
				or right.postdir = '')
			and 
			(StringLib.StringToUpperCase(trim(left.debtor_unit_desig, left, right)) = StringLib.StringToUpperCase(trim(right.unit_desig, left, right))
				or right.unit_desig = '')
			and 
			(StringLib.StringToUpperCase(trim(left.debtor_sec_range, right, left)) = StringLib.StringToUpperCase(trim(right.sec_range, right, left)) 
				or right.sec_range = ''))
	ENDMACRO;
	
	ds_addr := join(
				ds_ssn_prob,
				ds_comp,
				left.acctno = right.acctno,
				transform(rec_out,
					self.matchcode := if(AddrMatchCond(),
										trim(left.matchcode) + MatchCodes.addr,
										trim(left.matchcode));
					self := left),
				left outer);
				
		
	/*	city/state match				*/
	CityStMatchCond() := MACRO
		left.debtor_p_city_name != ''
		AND
		(
			(StringLib.StringToUpperCase(left_p_city_trim[1..15]) = StringLib.StringToUpperCase(right_city_trim[1..15]) OR StringLib.StringToUpperCase(left_v_city_trim[1..15]) = StringLib.StringToUpperCase(right_city_trim[1..15]))
			AND 
			(StringLib.StringToUpperCase(left_st_trim) = StringLib.StringToUpperCase(right_st_trim))
		)
	ENDMACRO;
	
	ds_city := join(
				ds_addr,
				ds_comp,
				left.acctno = right.acctno,
				transform(rec_out,
					left_p_city_trim := trim(left.debtor_p_city_name, left, right);
					left_v_city_trim := trim(left.debtor_v_city_name, left, right);
					left_st_trim := trim(left.debtor_st, left, right);
					right_city_trim := trim(right.p_city_name, left, right);
					right_st_trim := trim(right.st, left, right);
					
					self.matchcode := if(CityStMatchCond(), 
										trim(left.matchcode) + MatchCodes.city,
										trim(left.matchcode));
					self := left),
				left outer);
				
				
				
	/*	zip match						*/
	ZIPMatchCond() := MACRO
		LEFT.debtor_zip != ''
		AND
		(
		    (TRIM(LEFT.debtor_zip, LEFT, RIGHT) = TRIM(RIGHT.z5, LEFT, RIGHT))
		)
	ENDMACRO;
	
	ds_zip := join(
					ds_city,
					ds_comp,
					left.acctno = right.acctno,
					transform(rec_out,
						self.matchcode := if(ZIPMatchCond(),
											trim(left.matchcode) + MatchCodes.zip,
											trim(left.matchcode));
						self := left),
					left outer);	
	
	/* Phonetic last name				*/

	NameMatchesWithLastNamePhonetic(fname1, lname1, fname2, lname2) := MACRO
		(LENGTH(TRIM(fname1, LEFT, RIGHT)) > 0 AND LENGTH(TRIM(lname1, LEFT, RIGHT)) > 0
			AND LENGTH(TRIM(fname2, LEFT, RIGHT)) > 0 AND LENGTH(TRIM(lname2, LEFT, RIGHT)) > 0)
		AND
		StringLib.StringCompareIgnoreCase(	NID.PreferredFirstNew(TRIM(REGEXREPLACE('\\W', fname1, ' '), LEFT, RIGHT), true)[1..4],
											NID.PreferredFirstNew(TRIM(REGEXREPLACE('\\W', fname2, ' '), LEFT, RIGHT), true)[1..4]) = 0
		AND
		StringLib.StringCompareIgnoreCase(	MetaphoneLib.DMetaphone1(TRIM(REGEXREPLACE('\\W', lname1, ' '), ALL)),
											MetaphoneLib.DMetaphone1(TRIM(REGEXREPLACE('\\W', lname2, ' '), ALL))) = 0
	ENDMACRO;
	
	
	PhoneticLastNameMatchCond() := MACRO	
		NOT StringLib.StringContains(LEFT.matchcode, MatchCodes.name, TRUE)
		AND
		(
			NameMatchesWithLastNamePhonetic(LEFT.debtor_1_fname,	LEFT.debtor_1_lname,
											RIGHT.name_first, 		RIGHT.name_last)
			OR
			NameMatchesWithLastNamePhonetic(LEFT.debtor_2_fname,	LEFT.debtor_2_lname,
											RIGHT.name_first, 		RIGHT.name_last)
			OR
			NameMatchesWithLastNamePhonetic(LEFT.debtor_3_fname,	LEFT.debtor_3_lname,
											RIGHT.name_first, 		RIGHT.name_last)
			OR
			NameMatchesWithLastNamePhonetic(LEFT.debtor_4_fname,	LEFT.debtor_4_lname,
											RIGHT.name_first, 		RIGHT.name_last)
			OR
			NameMatchesWithLastNamePhonetic(LEFT.debtor_5_fname,	LEFT.debtor_5_lname,
											RIGHT.name_first, 		RIGHT.name_last)   
		)
		AND 
		(
			REGEXFIND('S|P', LEFT.matchcode)
			OR
			(REGEXFIND('Z', LEFT.matchcode) AND TRIM(LEFT.debtor_zip4, ALL) = TRIM(RIGHT.zip4, ALL))
		)
	ENDMACRO;

	
	ds_name_phon	:= JOIN(ds_zip, ds_comp,
							LEFT.acctno = RIGHT.acctno,
							TRANSFORM(rec_out,
								SELF.matchcode := IF(PhoneticLastNameMatchCond(),
													TRIM(LEFT.matchcode) + MatchCodes.name,
													TRIM(LEFT.matchcode));
								SELF := LEFT),
							LEFT OUTER);
	
	/*	ADL match						*/
	ADLMatchCond() := MACRO
		LEFT.isdeepdive AND 
			(
				(
					((UNSIGNED6) LEFT.debtor_did)   = RIGHT.did 
					AND 
					((UNSIGNED6) LEFT.debtor_did)  != 0
				)
				OR 
				(
					((UNSIGNED6) LEFT.debtor_bdid)  = RIGHT.bdid
					AND
					((UNSIGNED6) LEFT.debtor_bdid) != 0
				)
			)
	ENDMACRO;
	
	ds_did := JOIN(ds_name_phon, ds_comp,
					LEFT.acctno = RIGHT.acctno,
					TRANSFORM(rec_out,
							SELF.matchcode := if(ADLMatchCond(),
													trim(LEFT.matchcode) + MatchCodes.did,
													trim(LEFT.matchcode));
							SELF := LEFT));
									
	
	/* reorder match codes */
	ds_reorder := project(ds_did, transform(rec_out, 
											self.matchcode := BatchServices.Functions.fn_reorder_matchcode(left.matchcode),
											self := left));					
			
	/* We want to strip the "N" off the match code in this instance to avoid a match
		being represented on a name if the middle names do not match in any instance 
		of the debtor names that are returned in the output data. This only applies to
		some of the 'looser' match codes to avoid false positives.*/
		
	/* ---- mname
	If the fname and lname matches and middle name is not empty but its first char
	doesn't match the 'compare' record mname value, then strip the "N"				
	*/
	stripN_mname() := MACRO
		StringLib.StringFilterOut(TRIM(LEFT.matchcode, LEFT, RIGHT), MatchCodes.did) IN BatchServices.MatchCodes.stripN_list_mname
		AND
		LEFT.debtor_business_flag != MatchCodes.DEBTOR_BUSINESS_FLAG
		AND 
		LENGTH(TRIM(RIGHT.name_middle, LEFT, RIGHT)) > 0
		AND 
		(
			(
				(LENGTH(TRIM(LEFT.debtor_1_mname, LEFT, RIGHT)) > 0 
					AND NameMatches(LEFT.debtor_1_fname, LEFT.debtor_1_lname, RIGHT.name_first, RIGHT.name_last)
					AND TRIM(RIGHT.name_middle, LEFT)[1] != TRIM(LEFT.debtor_1_mname, LEFT)[1])
				OR
				(LENGTH(TRIM(LEFT.debtor_1_fname, LEFT, RIGHT)) = 0 
					AND LENGTH(TRIM(LEFT.debtor_1_lname, LEFT, RIGHT)) = 0)
				OR NOT (NameMatches(LEFT.debtor_1_fname, LEFT.debtor_1_lname, RIGHT.name_first, RIGHT.name_last))
			)
			AND
			(
				(LENGTH(TRIM(LEFT.debtor_2_mname, LEFT, RIGHT)) > 0
					AND NameMatches(LEFT.debtor_2_fname, LEFT.debtor_2_lname, RIGHT.name_first, RIGHT.name_last)
					AND TRIM(RIGHT.name_middle, LEFT)[1] != TRIM(LEFT.debtor_2_mname, LEFT)[1])
				OR
				(LENGTH(TRIM(LEFT.debtor_2_fname, LEFT, RIGHT)) = 0
					AND LENGTH(TRIM(LEFT.debtor_2_lname, LEFT, RIGHT)) = 0)
				OR NOT (NameMatches(LEFT.debtor_2_fname, LEFT.debtor_2_lname, RIGHT.name_first, RIGHT.name_last))
			)
			AND
			(
				(LENGTH(TRIM(LEFT.debtor_3_mname, LEFT, RIGHT)) > 0
					AND NameMatches(LEFT.debtor_3_fname, LEFT.debtor_3_lname, RIGHT.name_first, RIGHT.name_last)
					AND TRIM(RIGHT.name_middle, LEFT)[1] != TRIM(LEFT.debtor_3_mname, LEFT)[1])
				OR
				(LENGTH(TRIM(LEFT.debtor_3_fname, LEFT, RIGHT)) = 0
					AND LENGTH(TRIM(LEFT.debtor_3_lname, LEFT, RIGHT)) = 0)
				OR NOT (NameMatches(LEFT.debtor_3_fname, LEFT.debtor_3_lname, RIGHT.name_first, RIGHT.name_last))
			)
			AND
			(
				(LENGTH(TRIM(LEFT.debtor_4_mname, LEFT, RIGHT)) > 0
					AND NameMatches(LEFT.debtor_4_fname, LEFT.debtor_4_lname, RIGHT.name_first, RIGHT.name_last)
					AND TRIM(RIGHT.name_middle, LEFT)[1] != TRIM(LEFT.debtor_4_mname, LEFT)[1])
				OR
				(LENGTH(TRIM(LEFT.debtor_4_fname, LEFT, RIGHT)) = 0
					AND LENGTH(TRIM(LEFT.debtor_4_lname, LEFT, RIGHT)) = 0)
				OR NOT (NameMatches(LEFT.debtor_4_fname, LEFT.debtor_4_lname, RIGHT.name_first, RIGHT.name_last))
			)
			AND
			(
				(LENGTH(TRIM(LEFT.debtor_5_mname, LEFT, RIGHT)) > 0
					AND NameMatches(LEFT.debtor_5_fname, LEFT.debtor_5_lname, RIGHT.name_first, RIGHT.name_last)
					AND TRIM(RIGHT.name_middle, LEFT)[1] != TRIM(LEFT.debtor_5_mname, LEFT)[1])
				OR
				(LENGTH(TRIM(LEFT.debtor_5_fname, LEFT, RIGHT)) = 0
					AND LENGTH(TRIM(LEFT.debtor_5_lname, LEFT, RIGHT)) = 0)
				OR NOT (NameMatches(LEFT.debtor_5_fname, LEFT.debtor_5_lname, RIGHT.name_first, RIGHT.name_last))
			)
		)
	ENDMACRO;
	
	
	/* suffix	
	The suffix, if it exists, must match between the input record and one in a set of suffix 'classes'. These
	consist of the 'senior' class where S = 1 = I, the 'junior' class where J=2 and the 'fifth' class
	in which the roman numeral of V must match 5. This was included to create tighter name matches, since 
	we strip out the "N" match if the suffix is not appropriate.
	*/
	stripN_sffix() := MACRO
		StringLib.StringFilterOut(TRIM(LEFT.matchcode, LEFT, RIGHT), MatchCodes.did) IN BatchServices.MatchCodes.stripN_list_sffix
		AND
		(LENGTH(TRIM(RIGHT.name_suffix, LEFT, RIGHT)) > 0)
		AND
		/* senior: S = 1 = I */
		(
			TRIM(RIGHT.name_suffix, LEFT, RIGHT) IN Constants.Bankruptcy.SUFFIX_SENIOR
			AND
			(
				(
					(NameMatches(LEFT.debtor_1_fname, LEFT.debtor_1_lname, RIGHT.name_first, RIGHT.name_last)
						AND (TRIM(LEFT.debtor_1_name_suffix, LEFT, RIGHT) NOT IN Constants.Bankruptcy.SUFFIX_SENIOR)
						AND (LENGTH(TRIM(LEFT.debtor_1_name_suffix, LEFT, RIGHT)) > 0))
					OR 
					(LENGTH(TRIM(LEFT.debtor_1_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(LEFT.debtor_1_lname, LEFT, RIGHT)) = 0)
					OR NOT (NameMatches(LEFT.debtor_1_fname, LEFT.debtor_1_lname, RIGHT.name_first, RIGHT.name_last))
				)
				AND
				(
					(NameMatches(LEFT.debtor_2_fname, LEFT.debtor_2_lname, RIGHT.name_first, RIGHT.name_last)
						AND (TRIM(LEFT.debtor_2_name_suffix, LEFT, RIGHT) NOT IN Constants.Bankruptcy.SUFFIX_SENIOR)
						AND (LENGTH(TRIM(LEFT.debtor_2_name_suffix, LEFT, RIGHT)) > 0))
					OR
					(LENGTH(TRIM(LEFT.debtor_2_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(LEFT.debtor_2_lname, LEFT, RIGHT)) = 0)
					OR NOT (NameMatches(LEFT.debtor_2_fname, LEFT.debtor_2_lname, RIGHT.name_first, RIGHT.name_last))
				)
				AND
				(
					(NameMatches(LEFT.debtor_3_fname, LEFT.debtor_3_lname, RIGHT.name_first, RIGHT.name_last)
						AND (TRIM(LEFT.debtor_3_name_suffix, LEFT, RIGHT) NOT IN Constants.Bankruptcy.SUFFIX_SENIOR)
						AND (LENGTH(TRIM(LEFT.debtor_3_name_suffix, LEFT, RIGHT)) > 0))
					OR
					(LENGTH(TRIM(LEFT.debtor_3_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(LEFT.debtor_3_lname, LEFT, RIGHT)) = 0)
					OR NOT (NameMatches(LEFT.debtor_3_fname, LEFT.debtor_3_lname, RIGHT.name_first, RIGHT.name_last))
				)
				AND
				(
					(NameMatches(LEFT.debtor_4_fname, LEFT.debtor_4_lname, RIGHT.name_first, RIGHT.name_last)
						AND (TRIM(LEFT.debtor_4_name_suffix, LEFT, RIGHT) NOT IN Constants.Bankruptcy.SUFFIX_SENIOR)
						AND (LENGTH(TRIM(LEFT.debtor_4_name_suffix, LEFT, RIGHT)) > 0))
					OR
					(LENGTH(TRIM(LEFT.debtor_4_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(LEFT.debtor_4_lname, LEFT, RIGHT)) = 0)
					OR NOT (NameMatches(LEFT.debtor_4_fname, LEFT.debtor_4_lname, RIGHT.name_first, RIGHT.name_last))
				)
				AND
				(
					(NameMatches(LEFT.debtor_5_fname, LEFT.debtor_5_lname, RIGHT.name_first, RIGHT.name_last)
						AND (TRIM(LEFT.debtor_5_name_suffix, LEFT, RIGHT) NOT IN Constants.Bankruptcy.SUFFIX_SENIOR)
						AND (LENGTH(TRIM(LEFT.debtor_5_name_suffix, LEFT, RIGHT)) > 0))
					OR
					(LENGTH(TRIM(LEFT.debtor_5_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(LEFT.debtor_5_lname, LEFT, RIGHT)) = 0)
					OR NOT (NameMatches(LEFT.debtor_5_fname, LEFT.debtor_5_lname, RIGHT.name_first, RIGHT.name_last))
				)
			)
		)
		/* junior: J = 2 */
		OR
		(
			TRIM(RIGHT.name_suffix, LEFT, RIGHT) IN Constants.Bankruptcy.SUFFIX_JUNIOR
			AND
			(
				(
					(NameMatches(LEFT.debtor_1_fname, LEFT.debtor_1_lname, RIGHT.name_first, RIGHT.name_last)
						AND (TRIM(LEFT.debtor_1_name_suffix, LEFT, RIGHT) NOT IN Constants.Bankruptcy.SUFFIX_JUNIOR)
						AND (LENGTH(TRIM(LEFT.debtor_1_name_suffix, LEFT, RIGHT)) > 0))
					OR
					(LENGTH(TRIM(LEFT.debtor_1_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(left.debtor_1_lname, LEFT, RIGHT)) = 0)
					OR NOT (NameMatches(LEFT.debtor_1_fname, LEFT.debtor_1_lname, RIGHT.name_first, RIGHT.name_last))
				)
				AND
				(
					(NameMatches(LEFT.debtor_2_fname, LEFT.debtor_2_lname, RIGHT.name_first, RIGHT.name_last)
						AND (TRIM(LEFT.debtor_2_name_suffix, LEFT, RIGHT) NOT IN Constants.Bankruptcy.SUFFIX_JUNIOR)
						AND (LENGTH(TRIM(LEFT.debtor_2_name_suffix, LEFT, RIGHT)) > 0))
					OR
					(LENGTH(TRIM(LEFT.debtor_2_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(LEFT.debtor_2_lname, LEFT, RIGHT)) = 0)
					OR NOT (NameMatches(LEFT.debtor_2_fname, LEFT.debtor_2_lname, RIGHT.name_first, RIGHT.name_last))
				)
				AND
				(
					(NameMatches(LEFT.debtor_3_fname, LEFT.debtor_3_lname, RIGHT.name_first, RIGHT.name_last)
						AND (TRIM(LEFT.debtor_3_name_suffix, LEFT, RIGHT) NOT IN Constants.Bankruptcy.SUFFIX_JUNIOR)
						AND (LENGTH(TRIM(LEFT.debtor_3_name_suffix, LEFT, RIGHT)) > 0))
					OR
					(LENGTH(TRIM(LEFT.debtor_3_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(LEFT.debtor_3_lname, LEFT, RIGHT)) = 0)
					OR NOT (NameMatches(LEFT.debtor_3_fname, LEFT.debtor_3_lname, RIGHT.name_first, RIGHT.name_last))
				)
				AND
				(
					(NameMatches(LEFT.debtor_4_fname, LEFT.debtor_4_lname, RIGHT.name_first, RIGHT.name_last)
						AND (TRIM(LEFT.debtor_4_name_suffix, LEFT, RIGHT) NOT IN Constants.Bankruptcy.SUFFIX_JUNIOR)
						AND (LENGTH(TRIM(LEFT.debtor_4_name_suffix, LEFT, RIGHT)) > 0))
					OR
					(LENGTH(TRIM(LEFT.debtor_4_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(LEFT.debtor_4_lname, LEFT, RIGHT)) = 0)
					OR NOT (NameMatches(LEFT.debtor_4_fname, LEFT.debtor_4_lname, RIGHT.name_first, RIGHT.name_last))
				)
				AND
				(
					(NameMatches(LEFT.debtor_5_fname, LEFT.debtor_5_lname, RIGHT.name_first, RIGHT.name_last)
						AND (TRIM(LEFT.debtor_5_name_suffix, LEFT, RIGHT) NOT IN Constants.Bankruptcy.SUFFIX_JUNIOR)
						AND (LENGTH(TRIM(LEFT.debtor_5_name_suffix, LEFT, RIGHT)) > 0))
					OR
					(LENGTH(TRIM(LEFT.debtor_5_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(LEFT.debtor_5_lname, LEFT, RIGHT)) = 0)
					OR NOT (NameMatches(LEFT.debtor_5_fname, LEFT.debtor_5_lname, RIGHT.name_first, RIGHT.name_last))
				)
			)
		)
		/* V = 5 */
		OR
		(
			TRIM(RIGHT.name_suffix, LEFT, RIGHT) IN Constants.Bankruptcy.SUFFIX_FIFTH
			AND
			(
				(
					(NameMatches(LEFT.debtor_1_fname, LEFT.debtor_1_lname, RIGHT.name_first, RIGHT.name_last)
						AND (TRIM(LEFT.debtor_1_name_suffix, LEFT, RIGHT) NOT IN Constants.Bankruptcy.SUFFIX_FIFTH)
						AND (LENGTH(TRIM(LEFT.debtor_1_name_suffix, LEFT, RIGHT)) > 0))
					OR
					(LENGTH(TRIM(LEFT.debtor_1_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(LEFT.debtor_1_lname, LEFT, RIGHT)) = 0)
					OR NOT (NameMatches(LEFT.debtor_1_fname, LEFT.debtor_1_lname, RIGHT.name_first, RIGHT.name_last))
				)
				AND
				(
					(NameMatches(LEFT.debtor_2_fname, LEFT.debtor_2_lname, RIGHT.name_first, RIGHT.name_last)
						AND (TRIM(LEFT.debtor_2_name_suffix, LEFT, RIGHT) NOT IN Constants.Bankruptcy.SUFFIX_FIFTH)
						AND (LENGTH(TRIM(LEFT.debtor_2_name_suffix, LEFT, RIGHT)) > 0))
					OR
					(LENGTH(TRIM(LEFT.debtor_2_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(LEFT.debtor_2_lname, LEFT, RIGHT)) = 0)
					OR NOT (NameMatches(LEFT.debtor_2_fname, LEFT.debtor_2_lname, RIGHT.name_first, RIGHT.name_last))
				)
				AND
				(
					(NameMatches(LEFT.debtor_3_fname, LEFT.debtor_3_lname, RIGHT.name_first, RIGHT.name_last)
						AND (TRIM(LEFT.debtor_3_name_suffix, LEFT, RIGHT) NOT IN Constants.Bankruptcy.SUFFIX_FIFTH)
						AND (LENGTH(TRIM(LEFT.debtor_3_name_suffix, LEFT, RIGHT)) > 0))
					OR
					(LENGTH(TRIM(LEFT.debtor_3_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(LEFT.debtor_3_lname, LEFT, RIGHT)) = 0)
					OR NOT (NameMatches(LEFT.debtor_3_fname, LEFT.debtor_3_lname, RIGHT.name_first, RIGHT.name_last))
				)
				AND
				(
					(NameMatches(LEFT.debtor_4_fname, LEFT.debtor_4_lname, RIGHT.name_first, RIGHT.name_last)
						AND (TRIM(LEFT.debtor_4_name_suffix, LEFT, RIGHT) NOT IN Constants.Bankruptcy.SUFFIX_FIFTH)
						AND (LENGTH(TRIM(LEFT.debtor_4_name_suffix, LEFT, RIGHT)) > 0))
					OR
					(LENGTH(TRIM(LEFT.debtor_4_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(LEFT.debtor_4_lname, LEFT, RIGHT)) = 0)
					OR NOT (NameMatches(LEFT.debtor_4_fname, LEFT.debtor_4_lname, RIGHT.name_first, RIGHT.name_last))
				)
				AND
				(
					(NameMatches(LEFT.debtor_5_fname, LEFT.debtor_5_lname, RIGHT.name_first, RIGHT.name_last)
						AND (TRIM(LEFT.debtor_5_name_suffix, LEFT, RIGHT) NOT IN Constants.Bankruptcy.SUFFIX_FIFTH)
						AND (LENGTH(TRIM(LEFT.debtor_5_name_suffix, LEFT, RIGHT)) > 0))
					OR
					(LENGTH(TRIM(LEFT.debtor_5_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(LEFT.debtor_5_lname, LEFT, RIGHT)) = 0)
					OR NOT (NameMatches(LEFT.debtor_5_fname, LEFT.debtor_5_lname, RIGHT.name_first, RIGHT.name_last))
				)
			)
		)
	ENDMACRO;
	
	
	/* initials	*/
	/* 
		if the count of the initials of the smallest set of initials (between the 'comparison' dataset
		and the 'output' dataset) that match the larger set of initials is less than one less than
		the number of characters in the smaller of the two sets of initials, then remove this record.
		
		examples:

		ABC	vs	DEF	:	remove
		ABC	vs	CDE	:	remove
		ABC	vs	BCD	:	don't remove
		ABC	vs	ABC	:	don't remove
		ABC	vs	CBA	:	don't remove
		ABC	vs	BC	:	don't remove
		ABC	vs	CD	:	don't remove
		CD	vs	ABC	:	don't remove
		DC	vs	ABC	:	don't remove
		ABC	vs	DE	:	remove
		AB	vs	BA	:	don't remove
		AB	vs	BC	: 	don't remove
		AB	vs	CD	:	remove
		A	vs	BCD	:	don't remove
		A	vs	BC	:	don't remove
		A	vs	B	:	don't remove
		BCD	vs	A	:	don't remove
		
		This was added to avoid some false positives that come with some of the looser match codes
		which do not contain any other name match check in them
		(these match codes are listed in MatchCodes.filt_list_inits). 
	*/
	
	/* return the initials of a given name */
	Inits(firstname, middlename, lastname) := MACRO
		IF(LENGTH(TRIM(firstname,  LEFT, RIGHT)) > 0, TRIM(firstname,  LEFT, RIGHT)[1], '') + 
		IF(LENGTH(TRIM(middlename, LEFT, RIGHT)) > 0, TRIM(middlename, LEFT, RIGHT)[1], '') + 
		IF(LENGTH(TRIM(lastname,   LEFT, RIGHT)) > 0, TRIM(lastname,   LEFT, RIGHT)[1], '')
	ENDMACRO;
	
	/* return the longest of two sets of initials */
	LongestInits(linitval1, linitval2) := MACRO
		IF(LENGTH(TRIM(linitval1, LEFT, RIGHT)) >= LENGTH(TRIM(linitval2, LEFT, RIGHT)), TRIM(linitval1, LEFT, RIGHT), TRIM(linitval2, LEFT, RIGHT))
	ENDMACRO;

	/* return the shortest of two sets of initials */
	ShortestInits(sinitval1, sinitval2) := MACRO
		IF(LENGTH(TRIM(sinitval1, LEFT, RIGHT)) < LENGTH(TRIM(sinitval2, LEFT, RIGHT)), TRIM(sinitval1, LEFT, RIGHT), TRIM(sinitval2, LEFT, RIGHT))
	ENDMACRO;

	/* return true if the longest of two sets of initials contains the Nth character
		of the shortest of the two sets of initials */
	LongestContainsCharNOfShortest(i1, i2, Nval) := MACRO
		StringLib.StringContains(
			LongestInits(i1,i2),
			StringLib.StringRepad(ShortestInits(i1,i2), Nval)[Nval],
			TRUE)
		AND StringLib.StringRepad(ShortestInits(i1,i2), Nval)[Nval] != ''
	ENDMACRO;

	initsOK(i1, i2) := macro
		/* number of matching characters in smallest initials string */
		(
			IF(LongestContainsCharNOfShortest(i1, i2, 1), 1, 0) +	
			IF(LongestContainsCharNOfShortest(i1, i2, 2), 1, 0) +
			IF(LongestContainsCharNOfShortest(i1, i2, 3), 1, 0)
				>= LENGTH(TRIM(ShortestInits(i1, i2), LEFT, RIGHT)) - 1
		)
		OR
		(LENGTH(TRIM(RIGHT.name_first)) = 0 AND LENGTH(TRIM(RIGHT.name_last)) = 0)
	endmacro;
		
	/* evaluates whether the initials in a given output record are considered 'bad' */	
	badInits() := MACRO
		StringLib.StringFilterOut(TRIM(LEFT.matchcode, LEFT, RIGHT), MatchCodes.did) IN BatchServices.MatchCodes.filt_list_inits
		AND
		LEFT.debtor_business_flag != MatchCodes.DEBTOR_BUSINESS_FLAG
		AND
		(
			(NOT InitsOK(Inits(RIGHT.name_first, RIGHT.name_middle, RIGHT.name_last),
						 Inits(LEFT.debtor_1_fname, LEFT.debtor_1_mname, LEFT.debtor_1_lname)))
			OR
			(LENGTH(TRIM(LEFT.debtor_1_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(LEFT.debtor_1_lname, LEFT, RIGHT)) = 0)
		)				
		AND
		(
			(NOT InitsOK(Inits(RIGHT.name_first, RIGHT.name_middle, RIGHT.name_last),
						 Inits(LEFT.debtor_2_fname, LEFT.debtor_2_mname, LEFT.debtor_2_lname)))
			OR
			(LENGTH(TRIM(LEFT.debtor_2_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(LEFT.debtor_2_lname, LEFT, RIGHT)) = 0)
		)
		AND
		(
			(NOT InitsOK(Inits(RIGHT.name_first, RIGHT.name_middle, RIGHT.name_last),
						 Inits(LEFT.debtor_3_fname, LEFT.debtor_3_mname, LEFT.debtor_3_lname)))
			OR
			(LENGTH(TRIM(LEFT.debtor_3_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(LEFT.debtor_3_lname, LEFT, RIGHT)) = 0)
		)
		AND
		(
			(NOT InitsOK(Inits(RIGHT.name_first, RIGHT.name_middle, RIGHT.name_last),
						 Inits(LEFT.debtor_4_fname, LEFT.debtor_4_mname, LEFT.debtor_4_lname)))
			OR
			(LENGTH(TRIM(LEFT.debtor_4_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(LEFT.debtor_4_lname, LEFT, RIGHT)) = 0)
		)
		AND
		(
			(NOT InitsOK(Inits(RIGHT.name_first, RIGHT.name_middle, RIGHT.name_last),
						 Inits(LEFT.debtor_5_fname, LEFT.debtor_5_mname, LEFT.debtor_5_lname)))
			OR
			(LENGTH(TRIM(LEFT.debtor_5_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(LEFT.debtor_5_lname, LEFT, RIGHT)) = 0)
		)
		/* if all names are empty, we don't want to call the initials "bad" */
		AND NOT
		(
			(LENGTH(TRIM(LEFT.debtor_1_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(LEFT.debtor_1_lname, LEFT, RIGHT)) = 0)
			AND
			(LENGTH(TRIM(LEFT.debtor_2_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(LEFT.debtor_2_lname, LEFT, RIGHT)) = 0)
			AND
			(LENGTH(TRIM(LEFT.debtor_3_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(LEFT.debtor_3_lname, LEFT, RIGHT)) = 0)
			AND
			(LENGTH(TRIM(LEFT.debtor_4_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(LEFT.debtor_4_lname, LEFT, RIGHT)) = 0)
			AND
			(LENGTH(TRIM(LEFT.debtor_5_fname, LEFT, RIGHT)) = 0 AND LENGTH(TRIM(LEFT.debtor_5_lname, LEFT, RIGHT)) = 0)
		)
	ENDMACRO;
	
	
	/* Strip "N" from the match code if either mname or suffix strip conditions are true 
		and remove record if badInits() is true */
		
	ds_xtra_mc_rulz := JOIN(ds_reorder, ds_comp, 
							LEFT.acctno = RIGHT.acctno 
								AND 
								(NOT badInits() OR (NOT enable_extra_name_MC_logic)), 
							TRANSFORM(rec_out,
								SELF.matchcode := IF(	enable_extra_name_MC_logic AND (stripN_mname() OR stripN_sffix()), 
														BatchServices.Functions.fn_reorder_matchcode(StringLib.StringFilterOut(LEFT.matchcode, 'N')),
														LEFT.matchcode);
								SELF := LEFT));

						
	/* *** FOR TESTING ONLY	****/
	/*
	STRING test_matchcode := '' : STORED('TestMC');

	ds_xtra_mc_rulz_test1 := PROJECT(ds_reorder, 
										TRANSFORM(RECORDOF(LEFT),
											SELF.matchcode := test_matchcode,
											SELF := LEFT));
						
	ds_xtra_mc_rulz_test := JOIN(ds_xtra_mc_rulz_test1, ds_comp, 
							LEFT.acctno = RIGHT.acctno 
								AND 
								(NOT badInits() OR (NOT enable_extra_name_MC_logic)), 
							TRANSFORM(BatchServices.layout_BankruptcyV3_Batch_out,
								SELF.matchcode := IF(	enable_extra_name_MC_logic AND (stripN_mname() OR stripN_sffix()), 
														StringLib.StringFilterOut(LEFT.matchcode, 'N'),
														LEFT.matchcode);
								SELF := LEFT));
								
	/* *** END TESTING ****/

	/*	ADL address match code append - see Bug 51541	*/
	ds_adl_append := JOIN(ds_xtra_mc_rulz, ds_comp,
							LEFT.acctno = RIGHT.acctno,
							TRANSFORM(rec_out,
								SELF.matchcode 		:= IF(matchcode_adl_append,
															Functions.fn_augment_addr_matchcode(LEFT.matchcode, 
																								RIGHT.prim_range + 
																									RIGHT.predir + 
																									RIGHT.prim_name + 
																									RIGHT.addr_suffix + 
																									RIGHT.postdir, 
																								RIGHT.p_city_name, 
																								RIGHT.st, 
																								RIGHT.z5,
																								RIGHT.score,
																								RIGHT.score_bdid,
																								did_score_threshold,
																								bdid_score_threshold),
															StringLib.StringFilterOut(LEFT.matchcode, MatchCodes.did));
								SELF := LEFT));

	ds_ddp := DEDUP(SORT(ds_adl_append, acctno, tmsid, -matchcode), acctno, tmsid, matchcode);
	
	
	// DEBUGS
	// OUTPUT(ds, 						NAMED('ds_batch_in'));
	// OUTPUT(ds_comp, 				NAMED('ds_compare'));
	// OUTPUT(ds_name, 				NAMED('ds_name'));
	// OUTPUT(ds_ssn_full, 			NAMED('ds_ssn_full'));
	// OUTPUT(ds_ssn_red, 			NAMED('ds_ssn_red'));
	// OUTPUT(ds_ssn_prob, 			NAMED('ds_ssn_prob'));
	// OUTPUT(ds_addr, 				NAMED('ds_addr'));
	// OUTPUT(ds_city, 				NAMED('ds_city'));
	// OUTPUT(ds_zip, 				NAMED('ds_zip'));
	// OUTPUT(ds_did,					NAMED('ds_did'));
	// OUTPUT(ds_reorder, 			NAMED('ds_reorder'));
	// OUTPUT(ds_xtra_mc_rulz,		NAMED('ds_xtra_mc_rulz'));
	// OUTPUT(ds_xtra_mc_rulz_test, NAMED('ds_xtra_mc_rulz_test'));
	// OUTPUT(ds_adl_append,			NAMED('ds_adl_append'));
	// OUTPUT(ds_ddp,					NAMED('ds_ddp'));
	// OUTPUT(matchcode_adl_append,NAMED('matchcode_adl_append'));
	// OUTPUT(did_score_threshold,		NAMED('did_score_threshold'));
	// OUTPUT(bdid_score_threshold,		NAMED('bdid_score_threshold'));

	return ds_ddp(TRIM(matchcode, LEFT, RIGHT) != '');
end;