import business_header;

export MAC_Match_CompanyName_FEIN
(
	 infile 
	,outfile
	,bdid_field
	,score_field
	,similar_score_field
	,company_name_field
	,fein_field
	,pFileVersion						= '\'prod\''														// default to use prod version of superfiles
	,pUseOtherEnvironment		= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	
) := MACRO
#uniquename(pCnameFeinBase)
%pCnameFeinBase%		:= business_header.files(pFileVersion,pUseOtherEnvironment).Base.CompanyNameFein.logical;

#uniquename(imax)
%imax%(integer2 a, integer2 b) := if(a > b, a, b);

// Assume distributed by FEIN.
#uniquename(slimsort)
%slimsort% :=  %pCnameFeinBase%;

#uniquename(bdidfilter)
%bdidfilter% := (UNSIGNED6) infile.bdid_field = 0 OR infile.score_field != 100 OR infile.similar_score_field != 100;

#uniquename(matchable)
%matchable% := (UNSIGNED4) infile.fein_field != 0 AND (%bdidfilter%);

// Must distribute on the same type as the slimsort.
#uniquename(infile_id_attempt)
%infile_id_attempt% := DISTRIBUTE(infile(%matchable%),
						 HASH((UNSIGNED4) fein_field));

#uniquename(match_them)
TYPEOF(infile) %match_them%(infile l, %slimsort% r) := TRANSFORM
    stat_score := 100 div r.cn_f_bdids;

	SELF.similar_score_field := IF(r.bdid = 0, l.similar_score_field, 
						IF(l.similar_score_field > 100 - ut.CompanySimilar100(l.company_name_field, r.company_name),
							l.similar_score_field, 100 - ut.CompanySimilar100(l.company_name_field, r.company_name)));
						  
	SELF.score_field := Business_Header_SS.compute_score(
			l.bdid_field, r.bdid,
			l.similar_score_field, 100 - ut.CompanySimilar100(l.company_name_field, r.company_name),
//			l.score_field, 100 div r.cn_f_bdids);
            l.score_field, if(l.score_field = 0, %imax%(SELF.similar_score_field, stat_score), stat_score));


// SELF.similar_score_field is either greater than or equal to l.similar_score_field
	SELF.bdid_field := IF(SELF.similar_score_field > l.similar_score_field, r.bdid,
							IF((SELF.score_field > l.score_field) OR l.bdid_field = 0, r.bdid, l.bdid_field));
	SELF := l;
END;

#uniquename(match_result)
%match_result% := JOIN(%slimsort%, %infile_id_attempt%,
	 (UNSIGNED4) RIGHT.fein_field = LEFT.fein AND
	 ut.CompanySimilar100(RIGHT.company_name_field, LEFT.company_name) < 35,
	 %match_them%(RIGHT, LEFT), 
	 LOCAL, RIGHT OUTER);

outfile := %match_result% + infile(~(%matchable%));

ENDMACRO;