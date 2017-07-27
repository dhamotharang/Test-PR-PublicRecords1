import business_header;
EXPORT MAC_Match_CompanyName_Address
(
	 infile 
	,outfile
	,matchset
	,bdid_field
	,score_field
	,similar_score_field
	,company_name_field
	,prim_range_field
	,prim_name_field
	,sec_range_field
	,state_field
	,zip_field
	,phone_field
	,fein_field
	,keep_count
	,pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	
) :=
MACRO

#uniquename(pCnameAddressBase	)
#uniquename(pCnameFeinBase		)
#uniquename(pCnamePhoneBase		)

%pCnameAddressBase%		:= business_header.files(pFileVersion,pUseOtherEnvironment).Base.CompanyNameAddress.logical	;
%pCnameFeinBase%			:= business_header.files(pFileVersion,pUseOtherEnvironment).Base.CompanyNameFein.logical		;
%pCnamePhoneBase%			:= business_header.files(pFileVersion,pUseOtherEnvironment).Base.CompanyNamePhone.logical		;

#uniquename(slimsort)
%slimsort% := %pCnameAddressBase%;

#uniquename(matchable)
%matchable% := infile.prim_name_field != '' AND
				(UNSIGNED3) infile.zip_field != 0;

#uniquename(infile_id_attempt)
%infile_id_attempt% := infile(%matchable%);

#uniquename(min2)
%min2%(UNSIGNED1 l, UNSIGNED1 r) := IF(l < r, l, r);

#uniquename(imax)
%imax%(integer2 a, integer2 b) := if(a > b, a, b);

#uniquename(layout_temp_id_bdid)
%layout_temp_id_bdid% := RECORD
	UNSIGNED6 temp_id;
	UNSIGNED6 bdid;
	UNSIGNED1 name_score;
	UNSIGNED1 match_score;
END;

#uniquename(match_zip_near)
%layout_temp_id_bdid% %match_zip_near%(%slimsort% l, %infile_id_attempt% r) := TRANSFORM
	SELF.temp_id := r.temp_id;
	SELF.bdid := l.bdid;
	SELF.name_score := 100 - ut.CompanySimilar100(r.company_name_field, l.company_name);
	SELF.match_score := %imax%(SELF.name_score, 100 div %min2%(l.cn_pr_pn_zip_bdids, 255));
END;


#uniquename(near_exact_name_match)
%near_exact_name_match% := JOIN(
	DISTRIBUTE(%slimsort%(pr_pn_zip_bdids >= 3000), HASH(zip, prim_name, prim_range, ut.CleanCompany((STRING) company_name)[1..2])),
	DISTRIBUTE(%infile_id_attempt%, HASH((UNSIGNED3) zip_field, (QSTRING28) prim_name_field, (QSTRING10) prim_range_field, ut.CleanCompany((STRING) company_name_field)[1..2])),
	(UNSIGNED3) RIGHT.zip_field = LEFT.zip AND
	(QSTRING28) RIGHT.prim_name_field = LEFT.prim_name AND
    (QSTRING10) RIGHT.prim_range_field = LEFT.prim_range AND
	ut.CleanCompany((STRING) RIGHT.company_name_field)[1..2] = ut.CleanCompany((STRING) LEFT.company_name)[1..2] AND
	ut.CompanySimilar100(RIGHT.company_name_field, LEFT.company_name) <= 10,
	%match_zip_near%(LEFT, RIGHT), 
	LOCAL);

#uniquename(match_zip)
%layout_temp_id_bdid% %match_zip%(%slimsort% l, %infile_id_attempt% r) := TRANSFORM
	SELF.temp_id := r.temp_id;
	SELF.bdid := l.bdid;
	SELF.name_score := 100 - ut.CompanySimilar100(r.company_name_field, l.company_name);
	SELF.match_score := %imax%(SELF.name_score, 100 div l.cn_pr_pn_zip_bdids);
END;

#uniquename(match_result_addr_zip)
%match_result_addr_zip% := JOIN(
		DISTRIBUTE(%slimsort%(pr_pn_zip_bdids < 3000), HASH(zip, prim_name, prim_range)),
		DISTRIBUTE(%infile_id_attempt%, HASH((UNSIGNED3) zip_field, (QSTRING28) prim_name_field, (QSTRING10) prim_range_field)), 
	(UNSIGNED3) RIGHT.zip_field = LEFT.zip AND
	(QSTRING28) RIGHT.prim_name_field = LEFT.prim_name AND
    (QSTRING10) RIGHT.prim_range_field = LEFT.prim_range AND
	ut.CompanySimilar100(RIGHT.company_name_field, LEFT.company_name) <= 35,
	%match_zip%(LEFT, RIGHT), 
	LOCAL);

#uniquename(zip_all)
// Dedup to keep highest match scores for all temp_id, bdids
%zip_all% := DEDUP(SORT(DISTRIBUTE(%near_exact_name_match% + %match_result_addr_zip%, HASH(temp_id)), 
	                  temp_id, bdid, -match_score, -name_score, LOCAL),
	                  temp_id, bdid, LOCAL);

// Combine the deduped bdids and scores with input file
#uniquename(join_addr)
TYPEOF(infile) %join_addr%(%infile_id_attempt% l, %layout_temp_id_bdid% r) := TRANSFORM
	SELF.similar_score_field := r.name_score;
	SELF.score_field := r.match_score;
	SELF.bdid_field := r.bdid;
	SELF := l;
END;

#uniquename(match_result_addr)
%match_result_addr% := JOIN(
	DISTRIBUTE(%infile_id_attempt%, HASH(temp_id)),
	%zip_all%,
	LEFT.temp_id = RIGHT.temp_id,
	%join_addr%(LEFT, RIGHT),
	LEFT OUTER, LOCAL);
	
// Increase bdid match score based on fein and or phone
#uniquename(match_addr)	
%match_addr% := %match_result_addr%;

#uniquename(match_companyname_phone)
#uniquename(match_companyname_fein)

#if('F' in matchset)
// Assume distributed by FEIN.
#uniquename(feinslimsort)
%feinslimsort% := %pCnameFeinBase%;

#uniquename(feinbdidfilter)
%feinbdidfilter% := (UNSIGNED6) %match_addr%.bdid_field <> 0 AND %match_addr%.score_field != 100;

#uniquename(feinmatchable)
%feinmatchable% := (UNSIGNED4) %match_addr%.fein_field != 0 AND (%feinbdidfilter%);

// Must distribute on the same type as the slimsort.
#uniquename(fein_attempt)
%fein_attempt% := DISTRIBUTE(%match_addr%(%feinmatchable%),
						 HASH((UNSIGNED4) fein_field));

#uniquename(fein_match)
TYPEOF(infile) %fein_match%(%feinslimsort% l, %fein_attempt% r) := TRANSFORM
	SELF.score_field := did_add.compute_score(
			r.bdid_field, l.bdid,
			r.score_field, 100 div l.cn_f_bdids);
	SELF := r;
END;

#uniquename(match_result_fein)
%match_result_fein% := JOIN(%feinslimsort%, %fein_attempt%,
	 (UNSIGNED4) RIGHT.fein_field = LEFT.fein AND
	 (UNSIGNED6) RIGHT.bdid_field = LEFT.bdid AND
	 ut.CompanySimilar100(RIGHT.company_name_field, LEFT.company_name) <= 35,
	 %fein_match%(LEFT, RIGHT), 
	 LOCAL, RIGHT OUTER);

// Dedup to keep highest match scores for all temp_id, bdids
%match_companyname_fein% := DEDUP(SORT(DISTRIBUTE(%match_result_fein% + %match_addr%(~(%feinmatchable%)), HASH(temp_id)), 
	                  temp_id, bdid_field, -score_field, -similar_score_field, LOCAL),
	                  temp_id, bdid_field, LOCAL);
	 
#else
%match_companyname_fein% := %match_addr%;
#end

#if('P' in matchset)
// Assume distributed by phone.
#uniquename(phoneslimsort)
%phoneslimsort% := %pCnamePhoneBase%;
									
#uniquename(phonebdidfilter)
%phonebdidfilter% := (UNSIGNED6) %match_companyname_fein%.bdid_field <> 0 AND %match_companyname_fein%.score_field != 100;

#uniquename(phonematchable)
%phonematchable% := (UNSIGNED4) %match_companyname_fein%.phone_field != 0 AND (%phonebdidfilter%);

// Must distribute on the same type as the slimsort.
#uniquename(phone_attempt)
%phone_attempt% := DISTRIBUTE(%match_companyname_fein%(%phonematchable%),
						 HASH((UNSIGNED6) phone_field));

#uniquename(phone_match)
TYPEOF(infile) %phone_match%(%phoneslimsort% l, %phone_attempt% r) := TRANSFORM
	SELF.score_field := did_add.compute_score(
			r.bdid_field, l.bdid,
			r.score_field, 100 div l.cn_p_bdids);
	SELF := r;
END;

#uniquename(match_result_phone)
%match_result_phone% := JOIN(%phoneslimsort%, %phone_attempt%,
	 (UNSIGNED6) RIGHT.phone_field = LEFT.phone AND
	 (UNSIGNED6) RIGHT.bdid_field = LEFT.bdid AND
	 ut.CompanySimilar100(RIGHT.company_name_field, LEFT.company_name) <= 35,
	 %phone_match%(LEFT, RIGHT), 
	 LOCAL, RIGHT OUTER);
	 
// Dedup to keep highest match scores for all temp_id, bdids
%match_companyname_phone% := DEDUP(SORT(DISTRIBUTE(%match_result_phone% + %match_companyname_fein%(~(%phonematchable%)), HASH(temp_id)), 
	                  temp_id, bdid_field, -score_field, -similar_score_field, LOCAL),
	                  temp_id, bdid_field, LOCAL);
	 
#else
%match_companyname_phone% := %match_companyname_fein%;
#end


// keep only highest scoring bdids according to keep count					  
#uniquename(match_all_dedup)
%match_all_dedup% := DEDUP(SORT(%match_companyname_phone%, 
	                  temp_id, -score_field, -similar_score_field, bdid_field, LOCAL),
	                  temp_id, KEEP(keep_count), LOCAL);

// Dedup to keep count bdids per tempid.
outfile := %match_all_dedup%  + infile(~(%matchable%));


ENDMACRO;