import business_header;

EXPORT MAC_Match_CompanyName_Address_Partial
(
	 infile
	,outfile
	,bdid_field
	,score_field
	,similar_score_field
	,company_name_field
	,prim_range_field
	,prim_name_field
	,sec_range_field
	,state_field
	,zip_field
	,keep_count
	,pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	
) := MACRO
#uniquename(pCnameAddressBase)
%pCnameAddressBase%		:= business_header.files(pFileVersion,pUseOtherEnvironment).Base.CompanyNameAddress.logical;

#uniquename(imax)
%imax%(integer2 a, integer2 b) := if(a > b, a, b);

#uniquename(slimsort)
%slimsort% := %pCnameAddressBase%;

#uniquename(bdidfilter)
%bdidfilter% := (UNSIGNED6) infile.bdid_field = 0 OR infile.score_field != 100 OR infile.similar_score_field != 100;

#uniquename(matchable)
%matchable% := infile.prim_name_field != '' AND
				((UNSIGNED3) infile.zip_field != 0 OR infile.state_field != '') AND 
				(%bdidfilter%);

#uniquename(infile_id_attempt)
%infile_id_attempt% := infile(%matchable%);

#uniquename(min2)
%min2%(UNSIGNED1 l, UNSIGNED1 r) := IF(l < r, l, r);

#uniquename(match_zip_or_state)
TYPEOF(infile) %match_zip_or_state%(%infile_id_attempt% l, %slimsort% r) := TRANSFORM
     stat_score := 100 div (
				%min2%(IF((UNSIGNED3) l.zip_field = r.zip, r.cn_pr_pn_zip_bdids, 255),
					   IF((QSTRING8) l.sec_range_field = r.sec_range AND
						  (STRING2) l.state_field = r.state, r.cn_pr_pn_sr_st_bdids, 255)));

	SELF.similar_score_field := IF(r.bdid = 0, l.similar_score_field, 
									100 - ut.CompanySimilar100(l.company_name_field, r.company_name));
						  
	SELF.score_field := Business_Header_SS.compute_score(
			l.bdid_field, r.bdid,
			l.similar_score_field, 100 - ut.CompanySimilar100(l.company_name_field, r.company_name),
/*
			l.score_field, 100 div (
				%min2%(IF((UNSIGNED3) l.zip_field = r.zip, r.cn_pr_pn_zip_bdids, 255),
					   IF((QSTRING8) l.sec_range_field = r.sec_range AND
						  (STRING2) l.state_field = r.state, r.cn_pr_pn_sr_st_bdids, 255))
			));
*/
               l.score_field, if(l.score_field = 0, %imax%(SELF.similar_score_field, stat_score), stat_score));


// SELF.similar_score_field is either greater than or equal to l.similar_score_field
	SELF.bdid_field := IF(SELF.similar_score_field > l.similar_score_field, r.bdid,
							IF((SELF.score_field > l.score_field) OR l.bdid_field = 0, r.bdid, l.bdid_field));

	SELF := l;
END;

#uniquename(near_exact_name_match)
%near_exact_name_match% := JOIN(
	DISTRIBUTE(%slimsort%(pr_pn_zip_bdids >= 3000 or pr_pn_sr_st_bdids >= 3000), HASH(prim_name, prim_range, ut.CleanCompany((STRING) company_name)[1..2])),
	DISTRIBUTE(%infile_id_attempt%, HASH((QSTRING28) prim_name_field, (QSTRING10) prim_range_field, ut.CleanCompany((STRING) company_name_field)[1..2])),
	(QSTRING28) RIGHT.prim_name_field = LEFT.prim_name AND
    (QSTRING10) RIGHT.prim_range_field = LEFT.prim_range AND
	ut.CleanCompany((STRING) RIGHT.company_name_field)[1..2] = ut.CleanCompany((STRING) LEFT.company_name)[1..2] AND
	(
	 (
	  (UNSIGNED3) RIGHT.zip_field = LEFT.zip
	 ) OR
     (
	  (STRING2) RIGHT.state_field = LEFT.state AND
	  (QSTRING8) RIGHT.sec_range_field = LEFT.sec_range
	 )
	) AND
	ut.CompanySimilar100(RIGHT.company_name_field, LEFT.company_name) < 10,
	%match_zip_or_state%(RIGHT, LEFT), 
	LOCAL, RIGHT OUTER);

#uniquename(layout_temp_id_bdid)
%layout_temp_id_bdid% := RECORD
	UNSIGNED6 temp_id;
	UNSIGNED6 bdid;
	UNSIGNED1 name_score;
	UNSIGNED1 match_score;
END;

#uniquename(match_them)
%layout_temp_id_bdid% %match_them%(%infile_id_attempt% l, %slimsort% r, BOOLEAN isZip) := TRANSFORM
     stat_score := 100 div IF(isZip, r.cn_pr_pn_zip_bdids, r.cn_pr_pn_sr_st_bdids);

	SELF.temp_id := l.temp_id;
	SELF.bdid := r.bdid;
	SELF.name_score := 100 - ut.CompanySimilar100(l.company_name_field, r.company_name);
//	SELF.match_score := 100 div IF(isZip, r.cn_pr_pn_zip_bdids, r.cn_pr_pn_sr_st_bdids);
     SELF.match_score := if(l.score_field = 0, %imax%(SELF.name_score, stat_score), stat_score);
END;

#uniquename(match_result_addr_zip)
%match_result_addr_zip% := JOIN(
		DISTRIBUTE(%slimsort%(zip != 0, pr_pn_zip_bdids < 3000), HASH(zip, prim_name, prim_range)),
		DISTRIBUTE(%infile_id_attempt%, HASH((UNSIGNED3) zip_field, (QSTRING28) prim_name_field, (QSTRING10) prim_range_field)), 
	(UNSIGNED3) RIGHT.zip_field = LEFT.zip AND
	(QSTRING28) RIGHT.prim_name_field = LEFT.prim_name AND
    (QSTRING10) RIGHT.prim_range_field = LEFT.prim_range AND
	ut.CompanySimilar100(RIGHT.company_name_field, LEFT.company_name) < 35,
	%match_them%(RIGHT, LEFT, TRUE), 
	LOCAL);

#uniquename(match_result_addr_st)
%match_result_addr_st% := JOIN(
		DISTRIBUTE(%slimsort%(state != '', pr_pn_sr_st_bdids < 3000), HASH(state, prim_name, prim_range, sec_range)),
		DISTRIBUTE(%infile_id_attempt%, HASH((STRING2) state_field, (QSTRING28) prim_name_field, (QSTRING10) prim_range_field, (QSTRING8) sec_range_field)), 
    (STRING2)   RIGHT.state_field = LEFT.state AND
	(QSTRING28) RIGHT.prim_name_field = LEFT.prim_name AND
    (QSTRING10) RIGHT.prim_range_field = LEFT.prim_range AND
	(QSTRING8)  RIGHT.sec_range_field = LEFT.sec_range AND
	ut.CompanySimilar100(RIGHT.company_name_field, LEFT.company_name) < 35,
	%match_them%(RIGHT, LEFT, FALSE), 
	LOCAL);

#uniquename(match_result_addr_zip_ded)
Business_Header_SS.MAC_Dedup_BDID_TEMPID(
			%match_result_addr_zip%, %match_result_addr_zip_ded%, 
			bdid, match_score, name_score)

#uniquename(match_result_addr_st_ded)
Business_Header_SS.MAC_Dedup_BDID_TEMPID(
			%match_result_addr_st%, %match_result_addr_st_ded%, 
			bdid, match_score, name_score)

#uniquename(zip_state)
%zip_state% := DISTRIBUTE(%match_result_addr_zip_ded% + %match_result_addr_st_ded%, HASH(temp_id));

// Dedup to one bdid per tempid.
#uniquename(match_all_sort1)
%match_all_sort1% := SORT(%zip_state%, 
	temp_id, -match_score, -name_score, bdid, LOCAL);

#uniquename(match_all_dedup1)
%match_all_dedup1% := DEDUP(%match_all_sort1%, temp_id, KEEP(keep_count), LOCAL);

// Combine the deduped bdids.
#uniquename(join_addr)
TYPEOF(infile) %join_addr%(%near_exact_name_match% l, %layout_temp_id_bdid% r) := TRANSFORM
	SELF.similar_score_field := IF(r.bdid = 0, l.similar_score_field, 
									IF(r.name_score > l.similar_score_field,
										r.name_score, l.similar_score_field));
						  
	SELF.score_field := Business_Header_SS.compute_score(
			l.bdid_field, r.bdid,
			l.similar_score_field, r.name_score,
			l.score_field, r.match_score);

// SELF.similar_score_field is either greater than or equal to l.similar_score_field
	SELF.bdid_field := IF(SELF.similar_score_field > l.similar_score_field, r.bdid,
							IF((SELF.score_field > l.score_field) OR l.bdid_field = 0, r.bdid, l.bdid_field));
	SELF := l;
END;

#uniquename(match_result_addr)
%match_result_addr% := JOIN(
	DISTRIBUTE(%near_exact_name_match%, HASH(temp_id)),
	%match_all_dedup1%,
	LEFT.temp_id = RIGHT.temp_id,
	%join_addr%(LEFT, RIGHT),
	LEFT OUTER, LOCAL);
	
outfile := %match_result_addr% + infile(~(%matchable%));

ENDMACRO;