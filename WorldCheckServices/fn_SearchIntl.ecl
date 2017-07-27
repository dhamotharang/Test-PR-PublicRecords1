import doxie, globalwatchlists, worldcheck, ut, WorldCheckServices;

export fn_SearchIntl(DATASET(GlobalWatchlists.Layout_Batch_In) seqd, real threshold, 
				 boolean useDOBFilter, INTEGER2 dobRadius, boolean includeOFAC, 
				 SET OF STRING50 categories, SET OF STRING30 keywords) :=
FUNCTION

n := globalwatchlists.fn_SearchIntl(seqd,worldcheck.File_WorldCheck_Tokens);

ver := CHOOSEN(worldcheck.Key_WorldCheck_Version,1)[1].version : global;

// keyed join to get uids
l_work := globalwatchlists.Layout_Search_Working;
l_work_plus :=
RECORD
	l_work;
	INTEGER4 uid;
END;

	is_embargo(l_work le, worldcheck.Key_WorldCheck_key ri) := ri.category=worldcheck.constants.embargo_country;
	is_person(l_work le, worldcheck.Key_WorldCheck_key ri) := ri.E_I_Ind=worldcheck.constants.individual_code;

	// extra filters
	dob_filter(l_work le, worldcheck.Key_WorldCheck_key ri) := useDOBFilter AND le.dob<>'' AND ri.Date_Of_Birth<>'' AND is_person(le, ri) AND
													WorldCheckServices.DateDifference(le.dob, ri.Date_Of_Birth) > dobRadius * 365;
	cat_filter(l_work le, worldcheck.Key_WorldCheck_key ri) := categories<>[] AND ri.category NOT IN categories;
	kw_filter(l_work le, worldcheck.Key_WorldCheck_key ri) := keywords<>[] AND (~EXISTS(ri.keyword_detail) OR ~EXISTS(ri.keyword_detail(keyword IN keywords)));
	ofac_filter(l_work le, worldcheck.Key_WorldCheck_key ri) := ~includeOFAC AND EXISTS(ri.keyword_detail) AND ~EXISTS(ri.keyword_detail(keyword NOT IN OFAC_keywords));
	ver_filter(l_work le, worldcheck.Key_WorldCheck_key ri) := le.version_number<>0 AND le.version_number > (unsigned)ri.updated;
	tofilter(l_work le, worldcheck.Key_WorldCheck_key ri)  := dob_filter(le, ri) OR 
															  cat_filter(le, ri) OR 
															  kw_filter(le, ri) OR 
															  ofac_filter(le, ri) OR 
															  ver_filter(le, ri);


l_work_plus get_uids(l_work le, worldcheck.Key_WorldCheck_key ri) :=
TRANSFORM
	SELF.uid := ri.uid;

	person_score := bridgerscorelib.personScore(le.name,ri.First_Name,ri.Last_Name);
	company_score := bridgerscorelib.companyScore(le.name,ri.cname);
	country_score := bridgerscorelib.countryScore(le.country,ri.cname);
	
	score := IF(is_embargo(le, ri), country_score,
				IF(is_person(le, ri), person_score,	company_score));
	SELF.score := IF((STRING)score='nan' OR score < threshold, SKIP, score);
	SELF := le;
END;
uids := JOIN(n, worldcheck.Key_WorldCheck_key, KEYED(LEFT.id=RIGHT.key) AND
													~tofilter(LEFT,RIGHT), get_uids(LEFT,RIGHT), LIMIT(1,FAIL(0, doxie.ErrorCodes(0))));

l_work_plus roll_uids(l_work_plus le, l_work_plus ri) :=
TRANSFORM
	SELF.Score := IF(le.score>ri.score,le.score,ri.score);
	SELF := le;
END;
r := ROLLUP(SORT(uids, uid), LEFT.uid=RIGHT.uid, Roll_uids(LEFT,RIGHT));

// TODO: check all posible formats for input age_date_seen (like '/', etc.)
string GetStringDOB (string age, string age_date_seen) := FUNCTION
  string8 current_date := ut.GetDate;
  integer int_age := (integer) age;
  integer diff := ut.GetAge (age_date_seen);
  integer year := (integer) (current_date[1..4]) - (int_age + diff);

  string dob := MAP (age_date_seen = '' OR int_age = 0 => '', 
                     diff < 0 => '', //a little paranoical, but...
                     (string) year + '/00/00');
  return dob;
end;

// keyed join to get data
WorldCheckServices.Layout_Out get_wcheck(l_work_plus le, worldcheck.Key_WorldCheck_In ri) :=
TRANSFORM
	SELF.uid := ri.uid;
	SELF.Score := WorldCheckServices.format_real(le.score,5);
	SELF.version_number := INTFORMAT(ver,8,1);

  // trying to calculate DOB. Most probably better to be done earlier; temporarily patch
  SELF.date_of_birth := IF (ri.date_of_birth != '', ri.date_of_birth, 
                            GetStringDOB (ri.age, ri.age_as_of_date));
	SELF := le;
	SELF := ri;
	SELF := [];
END;
wcheck := JOIN(r, worldcheck.Key_WorldCheck_In, KEYED((STRING10)LEFT.uid=RIGHT.uid), get_wcheck(LEFT,RIGHT), LIMIT(1,FAIL(0, doxie.ErrorCodes(0))));

// join to external sources key to get each external source, then concatenate the string by rolling up
WorldCheckServices.Layout_Out get_ext_sources(WorldCheckServices.Layout_Out le, worldcheck.Key_WorldCheck_ext_sources ri) := TRANSFORM
	SELF.external_sources := ri.external_source;
	SELF := le;
END;
wsources := JOIN(wCheck, worldcheck.Key_WorldCheck_ext_sources, KEYED((integer)LEFT.uid=RIGHT.uid), 
					get_ext_sources(LEFT,RIGHT), LIMIT(500,FAIL(0, doxie.ErrorCodes(0))));

// roll the sources here...
WorldCheckServices.Layout_Out roll_sources(WorldCheckServices.Layout_Out le, WorldCheckServices.Layout_Out ri) := TRANSFORM
	SELF.external_sources := trim(le.external_sources) + ' ' + trim(ri.external_sources);
	SELF := le;
END;

rolled_sources := rollup(sort(wsources, uid), left.uid=right.uid, roll_sources(left,right));

WorldCheckServices.Layout_Out get_further_info(WorldCheckServices.Layout_Out le, worldcheck.Key_WorldCheck_main ri) := TRANSFORM
	SELF.further_information := ri.further_information;
	SELF := le;
END;
// there are many aliases per person usually, but the further information field is the same for each alias.  
// the max number of records per UID so far is 2880, so i'll set the atmost to 4000, but only keep 1
// for testing, that uid is 3219 (TAMIL TIGERS)
wfurther_information := JOIN(rolled_sources, worldcheck.Key_WorldCheck_main, KEYED((integer)LEFT.uid=RIGHT.uid), 
					get_further_info(LEFT,RIGHT), atmost(4000),keep(1));

WorldCheckServices.Layout_Out get_input(WorldCheckServices.Layout_Out le, GlobalWatchlists.Layout_Batch_In ri) :=
TRANSFORM
	SELF := ri;
	SELF := le;
END;
with_input := JOIN(wfurther_information, seqd, LEFT.seq=RIGHT.seq, get_input(LEFT,RIGHT), LOOKUP);

worldcheckservices.Layout_Out iter(worldcheckservices.Layout_Out le, worldcheckservices.Layout_Out ri) :=
TRANSFORM
	SELF.HitNum := IF(le.seq<>ri.seq, INTFORMAT(1,3,1), INTFORMAT((unsigned)le.HitNum+1, 3, 1));
	SELF := ri;	
END;

s := ITERATE(SORT(DEDUP(SORT(UNGROUP(with_input), uid, -score), uid), -score), iter(LEFT,RIGHT));

RETURN s;

END;