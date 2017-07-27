import business_header;

EXPORT MAC_Match_CompanyName
(
	 infile
	,outfile
	,bdid_field
	,score_field
	,similar_score_field
	,company_name_field
	,pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
) := MACRO

#uniquename(pCnameBase)
%pCnameBase%	:= Business_Header.Files(pFileVersion,pUseOtherEnvironment).Base.CompanyName.logical;

// Assume distributed by clean_company name.
#uniquename(slimsort)
%slimsort% := %pCnameBase%;

// Add a clean company name field to the infile
#uniquename(clean_name_layout)
%clean_name_layout% := RECORD
	infile;
	STRING80 clean_company_name;
END;

#uniquename(add_clean_name)
%clean_name_layout% %add_clean_name%(infile l) := TRANSFORM
	self.clean_company_name := ut.CleanCompany((STRING) l.company_name_field);
	self := l;
end;

#uniquename(infile_clean_name)
%infile_clean_name% := project(infile, %add_clean_name%(left));

#uniquename(matchable)
%matchable% := %infile_clean_name%.clean_company_name != '' AND %infile_clean_name%.bdid_field = 0;

#uniquename(infile_id_attempt)
%infile_id_attempt% := %infile_clean_name%(%matchable%);

#uniquename(match_them)
%clean_name_layout% %match_them%(%clean_name_layout% l, %slimsort% r) := TRANSFORM
	SELF.similar_score_field := IF(r.bdid = 0, l.similar_score_field, 
						IF(l.similar_score_field > 100 - ut.CompanySimilar100(l.clean_company_name, r.clean_company_name),
							l.similar_score_field, 100 - ut.CompanySimilar100(l.clean_company_name, r.clean_company_name)));

	SELF.score_field := Business_Header_SS.compute_score(
			l.bdid_field, r.bdid,
			l.similar_score_field, 100 - ut.CompanySimilar100(l.clean_company_name, r.clean_company_name),
			l.score_field, 100 div r.cn_bdids);

// SELF.similar_score_field is either greater than or equal to l.similar_score_field
	SELF.bdid_field := IF(SELF.similar_score_field > l.similar_score_field, r.bdid,
							IF((SELF.score_field > l.score_field) OR l.bdid_field = 0, r.bdid, l.bdid_field));
	SELF := l;
END;

#uniquename(match_result)
%match_result% := JOIN(%infile_id_attempt%, %slimsort%,
	LEFT.clean_company_name = RIGHT.clean_company_name,
	%match_them%(LEFT, RIGHT), 
	LEFT OUTER, HASH);

// Attempt a looser match for those that are still 0.
#uniquename(looser_match_attempt)
%looser_match_attempt% := %match_result%(bdid_field = 0);

#uniquename(looser_match_result)
%looser_match_result% := JOIN(%looser_match_attempt%, %slimsort%,
	LEFT.clean_company_name[1..20] = RIGHT.clean_company_name[1..20] AND
	ut.CompanySimilar100(LEFT.clean_company_name, RIGHT.clean_company_name) <= 10,
	%match_them%(LEFT, RIGHT), 
	LEFT OUTER, HASH);

#uniquename(slim_back)
TYPEOF(infile) %slim_back%(%clean_name_layout% l) := TRANSFORM
	SELF := l;
END;

outfile := 	PROJECT(
			%looser_match_result%
			+ %match_result%(bdid_field != 0)
			+ %infile_clean_name%(~(%matchable%))
			, %slim_back%(LEFT));

ENDMACRO;