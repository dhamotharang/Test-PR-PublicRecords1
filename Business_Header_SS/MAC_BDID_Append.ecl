EXPORT MAC_BDID_Append
(
	infile, 		 // in Layout_BDID_In_Batch
	outfile, 		 // in Layout_BDID_Out_Batch
	score_threshold, // only keep bdids with score above
	keep_count = '1', // keep this number of bdid matches for each record
	bool_filter = 'false',
	do_looser_match = 'true'
					 // filter results on all input fields
) := MACRO
IMPORT Business_Header_SS, ut;

#uniquename(temp_id)
#uniquename(layout_midbatch)
%layout_midbatch% := RECORD
	infile,
	UNSIGNED6 temp_id;
	UNSIGNED6 bdid := 0;
	UNSIGNED6 score := 0;
	UNSIGNED1 name_score := 0;
	STRING80  clean_company_name;
	STRING80  DL_clean_company_name;
END;

#uniquename(to_midbatch)
%layout_midbatch% %to_midbatch%(infile l, INTEGER ct) := TRANSFORM
	SELF.clean_company_name := ut.CleanCompany(l.company_name);
	SELF.DL_clean_company_name := datalib.companyclean(l.company_name);
	SELF.temp_id := ct;
	SELF := l;
END;

#uniquename(with_name_score)
%with_name_score% := GROUP(
	PROJECT(infile, %to_midbatch%(LEFT, COUNTER)), 
	temp_id);

#uniquename(PhoneBDID)
%layout_midbatch% %PhoneBDID%(%layout_midbatch% l, Business_Header_SS.Key_BH_Phone r) := TRANSFORM
	SELF.name_score := IF(r.bdid = 0, l.name_score, 
						IF(l.name_score > 100 - ut.CompanySimilar100(l.company_name, r.company_name),
							l.name_score, 100 - ut.CompanySimilar100(l.company_name, r.company_name)));
	
	SELF.score := Business_Header_SS.compute_score(
					l.bdid, r.bdid,
					l.name_score, 100 - ut.CompanySimilar100(l.company_name, r.company_name),
					l.score, 100 div r.cn_p_bdids);

// SELF.name_score is either greater than or equal to l.name_score
	SELF.bdid := IF(SELF.name_score > l.name_score, r.bdid,
					IF((SELF.score > l.score) OR l.bdid = 0, r.bdid, l.bdid));
	SELF := l;
END;

#uniquename(phone_match)
%phone_match% := JOIN(%with_name_score%, Business_Header_SS.Key_BH_Phone,
	(UNSIGNED6) LEFT.phone10 != 0 AND 
	(UNSIGNED6) LEFT.phone10 = RIGHT.phone AND
	ut.CompanySimilar100(LEFT.company_name, RIGHT.company_name) < 35,
	%PhoneBDID%(LEFT, RIGHT),
	LEFT OUTER, ATMOST((UNSIGNED6) LEFT.phone10 = RIGHT.phone, 2000));

#uniquename(FeinBDID)
%layout_midbatch% %FeinBDID%(%layout_midbatch% l, Business_Header_SS.Key_BH_FEIN r) := TRANSFORM
	SELF.name_score := IF(r.bdid = 0, l.name_score, 
						IF(l.name_score > 100 - ut.CompanySimilar100(l.company_name, r.company_name),
							l.name_score, 100 - ut.CompanySimilar100(l.company_name, r.company_name)));
						  
	SELF.score := Business_Header_SS.compute_score(
					l.bdid, r.bdid,
					l.name_score, 100 - ut.CompanySimilar100(l.company_name, r.company_name),
					l.score, 100 div r.cn_f_bdids);

// SELF.name_score is either greater than or equal to l.name_score
	SELF.bdid := IF(SELF.name_score > l.name_score, r.bdid,
					IF((SELF.score > l.score) OR l.bdid = 0, r.bdid, l.bdid));
	SELF := l;
END;

#uniquename(still_needs_match)
boolean %still_needs_match%(unsigned6 id, unsigned1 sc, unsigned1 name_sc) := 
	id = 0 or sc < 100 or name_sc < 100;

#uniquename(fein_match)
%fein_match% := JOIN(%phone_match%, Business_Header_SS.Key_BH_FEIN,
	(UNSIGNED4) LEFT.fein != 0 AND 
	%still_needs_match%(left.bdid, left.score, left.name_score) AND
	(UNSIGNED4) LEFT.fein = RIGHT.fein AND
	ut.CompanySimilar100(LEFT.company_name, RIGHT.company_name) < 35,
	%FeinBDID%(LEFT, RIGHT),
	LEFT OUTER, ATMOST((UNSIGNED4) LEFT.fein = RIGHT.fein, 2000));

#uniquename(ZipBDID)
%layout_midbatch% %ZipBDID%(%layout_midbatch% l, Business_Header_SS.Key_BH_Addr_pr_pn_zip r) := TRANSFORM
	SELF.name_score := IF(r.bdid = 0, l.name_score, 
						IF(l.name_score > 100 - ut.CompanySimilar100_split(L.DL_clean_company_name[1..40],L.DL_clean_company_name[41..80], R.indic, r.sec),
							l.name_score, 100 - ut.CompanySimilar100_split(L.DL_clean_company_name[1..40],L.DL_clean_company_name[41..80], R.indic, r.sec)));
						  
	SELF.score := Business_Header_SS.compute_score(
					l.bdid, r.bdid,
					l.name_score, 100 - ut.CompanySimilar100_split(L.DL_clean_company_name[1..40],L.DL_clean_company_name[41..80], R.indic, r.sec),
					l.score, 100 div r.cn_pr_pn_zip_bdids);

// SELF.name_score is either greater than or equal to l.name_score
	SELF.bdid := IF(SELF.name_score > l.name_score, r.bdid,
					IF((SELF.score > l.score) OR l.bdid = 0, r.bdid, l.bdid));
	
	SELF := l;
END;

#uniquename(ZipBDID_Broad)
%layout_midbatch% %ZipBDID_Broad%(%layout_midbatch% l, Business_Header_SS.Key_BH_Addr_zip r) := TRANSFORM
	SELF.name_score := IF(r.bdid = 0, l.name_score, 
						IF(l.name_score > 100 - ut.CompanySimilar100_split(L.DL_clean_company_name[1..40],L.DL_clean_company_name[41..80], R.indic, r.sec),
							l.name_score, 100 - ut.CompanySimilar100_split(L.DL_clean_company_name[1..40],L.DL_clean_company_name[41..80], R.indic, r.sec)));
						  
	SELF.score := Business_Header_SS.compute_score(
					l.bdid, r.bdid,
					l.name_score, 100 - ut.CompanySimilar100_split(L.DL_clean_company_name[1..40],L.DL_clean_company_name[41..80], R.indic, r.sec),
					l.score, 100 div r.cn_zip_bdids);

// SELF.name_score is either greater than or equal to l.name_score
	SELF.bdid := IF(SELF.name_score > l.name_score, r.bdid,
					IF((SELF.score > l.score) OR l.bdid = 0, r.bdid, l.bdid));
	
	SELF := l;
END;

#uniquename(fein_match_ded)
%fein_match_ded% := DEDUP(
	SORT(%fein_match%, temp_id, bdid, -name_score, -score), temp_id, bdid);
//output(choosen(%fein_match_ded%, 4000));
#uniquename(zip_match)
%zip_match% := JOIN(%fein_match_ded%, Business_Header_SS.Key_BH_Addr_pr_pn_zip,
	(UNSIGNED3) LEFT.z5 != 0 AND
	(QSTRING28) LEFT.prim_name != '' AND  
	%still_needs_match%(left.bdid, left.score, left.name_score) AND
	(UNSIGNED3) LEFT.z5 = RIGHT.zip AND 
	(QSTRING28) LEFT.prim_name = RIGHT.prim_name AND
	((QSTRING10) LEFT.prim_range = '' OR
	(QSTRING10) LEFT.prim_range = RIGHT.prim_range) AND
	(
	 (
	  //RIGHT.pr_pn_zip_bdids < 3000 AND
	  ut.CompanySimilar100_split(LEFT.DL_clean_company_name[1..40],LEFT.DL_clean_company_name[41..80], RIGHT.indic, right.sec) < 35
	 ) /*OR
	 (
	  RIGHT.pr_pn_zip_bdids >= 3000 AND
	  LEFT.company_name[1..2] = RIGHT.cn2 AND
	  ut.CompanySimilar100_split(LEFT.DL_clean_company_name[1..40],LEFT.DL_clean_company_name[41..80], RIGHT.indic, right.sec) < 10
	 )*/
	),
	%ZipBDID%(LEFT, RIGHT),
	LEFT OUTER,LIMIT(100000,SKIP));
	// LEFT OUTER, ATMOST( (UNSIGNED3) LEFT.z5 != 0 AND
						// (UNSIGNED3) LEFT.z5 = RIGHT.zip AND
						// (QSTRING28) LEFT.prim_name = RIGHT.prim_name AND
						// ((QSTRING10) LEFT.prim_range = '' OR
						// (QSTRING10) LEFT.prim_range = RIGHT.prim_range)
						// , 2000));
//output(choosen(%zip_match%, 4000));
#uniquename(zip_match_broad)
%zip_match_broad% := JOIN(%fein_match_ded%, Business_Header_SS.Key_BH_Addr_zip,
	(UNSIGNED3) LEFT.z5 != 0 AND
	(QSTRING28) LEFT.prim_name = '' AND  
	%still_needs_match%(left.bdid, left.score, left.name_score) AND
	(UNSIGNED3) LEFT.z5 = RIGHT.zip AND 
	(
	 (
	  //RIGHT.zip_bdids < 3000 AND
	  ut.CompanySimilar100_split(LEFT.DL_clean_company_name[1..40],LEFT.DL_clean_company_name[41..80], RIGHT.indic, right.sec) < 35
	 ) /*OR
	 (
	  RIGHT.zip_bdids >= 3000 AND
	  LEFT.company_name[1..2] = RIGHT.cn2 AND
	  ut.CompanySimilar100_split(LEFT.DL_clean_company_name[1..40],LEFT.DL_clean_company_name[41..80], RIGHT.indic, right.sec) < 10
	 )*/
	),
	%ZipBDID_Broad%(LEFT, RIGHT),
	LEFT OUTER,LIMIT(100000,SKIP));
	// LEFT OUTER, ATMOST( (UNSIGNED3) LEFT.z5 != 0 AND
						// (UNSIGNED3) LEFT.z5 = RIGHT.zip
						// , 2000));
//output(choosen(%zip_match_broad%, 4000));
#uniquename(StateBDID)
%layout_midbatch% %StateBDID%(%layout_midbatch% l, Business_Header_SS.Key_BH_Addr_pr_pn_sr_st r) := TRANSFORM
	SELF.name_score := IF(r.bdid = 0, l.name_score, 
						IF(l.name_score > 100 - ut.CompanySimilar100_split(L.DL_clean_company_name[1..40],L.DL_clean_company_name[41..80], R.indic, r.sec),
							l.name_score, 100 - ut.CompanySimilar100_split(L.DL_clean_company_name[1..40],L.DL_clean_company_name[41..80], R.indic, r.sec)));
						  
	SELF.score := Business_Header_SS.compute_score(
					l.bdid, r.bdid,
					l.name_score, 100 - ut.CompanySimilar100_split(L.DL_clean_company_name[1..40],L.DL_clean_company_name[41..80], R.indic, r.sec),
					l.score, 100 div r.cn_pr_pn_sr_st_bdids);

// SELF.name_score is either greater than or equal to l.name_score
	SELF.bdid := IF(SELF.name_score > l.name_score, r.bdid,
					IF((SELF.score > l.score) OR l.bdid = 0, r.bdid, l.bdid));
	SELF := l;
END;

#uniquename(StateBDID_Broad)
%layout_midbatch% %StateBDID_Broad%(%layout_midbatch% l, Business_Header_SS.Key_BH_Addr_st r) := TRANSFORM
	SELF.name_score := IF(r.bdid = 0, l.name_score, 
						IF(l.name_score > 100 - ut.CompanySimilar100_split(L.DL_clean_company_name[1..40],L.DL_clean_company_name[41..80], R.indic, r.sec),
							l.name_score, 100 - ut.CompanySimilar100_split(L.DL_clean_company_name[1..40],L.DL_clean_company_name[41..80], R.indic, r.sec)));
						  
	SELF.score := Business_Header_SS.compute_score(
					l.bdid, r.bdid,
					l.name_score, 100 - ut.CompanySimilar100_split(L.DL_clean_company_name[1..40],L.DL_clean_company_name[41..80], R.indic, r.sec),
					l.score, 100 div r.cn_st_bdids);

// SELF.name_score is either greater than or equal to l.name_score
	SELF.bdid := IF(SELF.name_score > l.name_score, r.bdid,
					IF((SELF.score > l.score) OR l.bdid = 0, r.bdid, l.bdid));
	SELF := l;
END;

#uniquename(state_match)
%state_match% := JOIN(%fein_match_ded%, Business_Header_SS.Key_BH_Addr_pr_pn_sr_st,
	(STRING2)   LEFT.st != '' AND
	(QSTRING28) LEFT.prim_name != '' AND  
	%still_needs_match%(left.bdid, left.score, left.name_score) AND
	keyed((STRING2)   LEFT.st = RIGHT.state) AND
	keyed((QSTRING28) LEFT.prim_name = RIGHT.prim_name) AND
	keyed((QSTRING10) LEFT.prim_range = '' OR (QSTRING10) LEFT.prim_range = RIGHT.prim_range) AND
	keyed((QSTRING8)  LEFT.sec_range = RIGHT.sec_range, opt) AND //opt allows this to be unkeyed in the event that LEFT.prim_range = ''
	(
	 (
	  //RIGHT.pr_pn_sr_st_bdids < 3000 AND
		ut.CompanySimilar100_split(LEFT.DL_clean_company_name[1..40],LEFT.DL_clean_company_name[41..80], RIGHT.indic, right.sec) < 35
	 ) /*OR
	 (
	  //RIGHT.pr_pn_sr_st_bdids >= 3000 AND
	  LEFT.company_name[1..2] = RIGHT.cn2 AND
	  ut.CompanySimilar100_split(LEFT.DL_clean_company_name[1..40],LEFT.DL_clean_company_name[41..80], RIGHT.indic, right.sec) < 10
	 )*/
	),
	%StateBDID%(LEFT, RIGHT),
	LEFT OUTER,LIMIT(100000,SKIP));
	// LEFT OUTER, ATMOST( (STRING2)   LEFT.st != '' AND
						// (STRING2)   LEFT.st = RIGHT.state AND
						// (QSTRING28) LEFT.prim_name = RIGHT.prim_name AND
						// ((QSTRING10) LEFT.prim_range = '' OR
						// (QSTRING10) LEFT.prim_range = RIGHT.prim_range) AND
						// (QSTRING8)  LEFT.sec_range = RIGHT.sec_range
						// , 2000));
//output(choosen(%state_match%, 4000));
#uniquename(state_match_broad)
%state_match_broad% := JOIN(%fein_match_ded%, Business_Header_SS.Key_BH_Addr_st,
	(STRING2)   LEFT.st != '' AND
	(QSTRING28) LEFT.prim_name = '' AND  
	%still_needs_match%(left.bdid, left.score, left.name_score) AND
	keyed((STRING2)   LEFT.st = RIGHT.state) AND
	(
	 (
	  //RIGHT.st_bdids < 3000 AND
		ut.CompanySimilar100_split(LEFT.DL_clean_company_name[1..40],LEFT.DL_clean_company_name[41..80], RIGHT.indic, right.sec) < 35
	 ) /*OR
	 (
	  //RIGHT.st_bdids >= 3000 AND
	  LEFT.company_name[1..2] = RIGHT.cn2 AND
	  ut.CompanySimilar100_split(LEFT.DL_clean_company_name[1..40],LEFT.DL_clean_company_name[41..80], RIGHT.indic, right.sec) < 10
	 )*/
	),
	%StateBDID_Broad%(LEFT, RIGHT),
	LEFT OUTER,LIMIT(100000,SKIP));
	// LEFT OUTER, ATMOST( (STRING2)   LEFT.st != '' AND
						// (STRING2)   LEFT.st = RIGHT.state
						// , 2000));
//output(choosen(%state_match_broad%, 4000));
#uniquename(CompanyNameBDID)
%layout_midbatch% %CompanyNameBDID%(%layout_midbatch% l, Business_Header_SS.Key_BH_CompanyName r) := TRANSFORM
	SELF.name_score := IF(r.bdid = 0, l.name_score, 
						IF(l.name_score > 100 - ut.CompanySimilar100(l.clean_company_name, r.clean_company_name20 + r.clean_company_name60),
							l.name_score, 100 - ut.CompanySimilar100(l.clean_company_name, r.clean_company_name20 + r.clean_company_name60)));
						  
	SELF.score := Business_Header_SS.compute_score(
					l.bdid, r.bdid,
					l.name_score, 100 - ut.CompanySimilar100(l.clean_company_name, r.clean_company_name20 + r.clean_company_name60),
					l.score, 100 div r.cn_bdids);

// SELF.name_score is either greater than or equal to l.name_score
	SELF.bdid := IF(SELF.name_score > l.name_score, r.bdid,
					IF((SELF.score > l.score) OR l.bdid = 0, r.bdid, l.bdid));
	SELF := l;
END;


#uniquename(both_match_ded)
// output(%state_match%);
// output(%zip_match%);
// output(%state_match_broad%);
// output(%zip_match_broad%);
%both_match_ded% :=
DEDUP(
	SORT(group(sort(group(%state_match%) + group(%zip_match%) + IF(do_looser_match,group(%state_match_broad%) + group(%zip_match_broad%)), temp_id), temp_id), temp_id, bdid, -name_score, -score), temp_id, bdid);
//output(choosen(%both_match_ded%, 4000));

#uniquename(name_match)
%name_match% := JOIN(%both_match_ded%, Business_Header_SS.Key_BH_CompanyName,
	LEFT.bdid = 0 AND
	LEFT.clean_company_name != '' AND
	%still_needs_match%(left.bdid, left.score, left.name_score) AND
	LEFT.clean_company_name[1..20] = RIGHT.clean_company_name20 AND
	LEFT.clean_company_name[21..80] = RIGHT.clean_company_name60,
	%CompanyNameBDID%(LEFT, RIGHT), 
	LEFT OUTER, ATMOST(2000));
//output(choosen(%name_match%, 4000));
#uniquename(name_match8)
%name_match8% := JOIN(%name_match%, Business_Header_SS.Key_BH_CompanyName,
	LEFT.bdid = 0 AND
	LEFT.clean_company_name != '' AND
	%still_needs_match%(left.bdid, left.score, left.name_score) AND
	LEFT.clean_company_name[1..20] = RIGHT.clean_company_name20 AND
	ut.CompanySimilar100(LEFT.clean_company_name, RIGHT.clean_company_name20 + RIGHT.clean_company_name60) < 10,
	%CompanyNameBDID%(LEFT, RIGHT), 
	LEFT OUTER, ATMOST(	LEFT.bdid = 0 AND
								LEFT.clean_company_name != '' AND
								LEFT.clean_company_name[1..20] = RIGHT.clean_company_name20, 
						2000));
//output(choosen(%name_match8%, 4000));
// If we're filtering, the score becomes the inverse of
// the filter penalty.
// output(%name_match%);
// output(%name_match8%);

#uniquename(name_match8_dep)
%name_match8_dep% := dedup(sort(%name_match8%, record), record);

#uniquename(filtered)
#if(bool_filter)
Business_Header_SS.MAC_Filter_Matches(%name_match8_dep%, %filtered%)
#else
%filtered% := %name_match8_dep%;
#end

// output(%filtered%);

#uniquename(match_pre_ded)
#if(keep_count = 1)
%match_pre_ded% := %filtered%;
#else
%match_pre_ded% := DEDUP(
	SORT(%filtered%, temp_id, bdid, -name_score, -score),
	temp_id, bdid);
#end

#uniquename(match_ded)
%match_ded% := DEDUP(
	SORT(%match_pre_ded%, temp_id, -name_score, -score, bdid),
	temp_id, KEEP(keep_count));

#uniquename(ApplyThreshold)
Business_Header_SS.Layout_BDID_OutBatch %ApplyThreshold%(%layout_midbatch% l) := TRANSFORM
	SELF.bdid := IF(l.score >= score_threshold and l.score > 0, l.bdid, 0);
	SELF := l;
END;

outfile := GROUP(PROJECT(%match_ded%, %ApplyThreshold%(LEFT)));
ENDMACRO;
