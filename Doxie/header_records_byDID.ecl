import doxie, ut, header, infutor, STD, NID;

// Formerly the contents of doxie.header_records;  Allows for the passing of a dataset of DIDs,
// rather than calling doxie\get_dids

export header_records_byDID(
	dataset(doxie.layout_references_hh) dids,
	boolean include_dailies = false, 
	boolean allow_wildcard = false,
	set of STRING1 daily_autokey_skipset=[],
	boolean AllowGongFallBack = true,
	boolean IncludeAllRecords = false,
	boolean suppress_gong_noncurrent = false,
	boolean ApplyBpsFilter = false,
	boolean GongByDidOnly = false,
	unsigned ReturnLimit = Header.constants.ReturnLimit,
	boolean checkRNA = false,
	boolean isrollup = false,
	boolean DoSearch = true
	) :=   // controls whether to search dailies or jsut fetch by DID right away 

FUNCTION

doxie.mac_header_field_declare()
mod_access := $.compliance.GetGlobalDataAccessModule ();

include_fun(unsigned2 penalt, string1 TNT, unsigned3 dt) := 
											// because we have different defaults today
								CASE(if(isrollup AND Dial_RecordMatch_value=0,3,
												 if(~isrollup AND Dial_RecordMatch_value=0, 1, Dial_RecordMatch_value)), 
										1 => penalt<score_threshold_value,
										2 => penalt<score_threshold_value OR tnt_score(TNT)<=tnt_score('C'),
										3 => penalt<score_threshold_value OR tnt_score(TNT)<=tnt_score('C') OR
												 (ut.DaysApart(((STRING6)dt+'31'), (string)STD.Date.Today())<366),
										true);



//***** GET THE DAILIES AND THEIR DIDS
bothMod := doxie.mod_header_records(
	DoSearch,
	include_dailies, 				
	allow_wildcard,	
	true,
	suppress_gong_noncurrent,
	daily_autokey_skipset,
	AllowGongFallBack,
	ApplyBpsFilter,
	GongByDidOnly,
  mod_access);
dailyMod := bothMod.mod_Daily(dids);

justd := dailyMod.AddDIDs; // layout header_references_hh

// "advanced" check is narrowing down subjects by additional names, their relatives' names, etc.
doxie.MAC_Check_Advanced(justd,did,didsChecked_1,Infutor.Key_Header_Infutor_Knowx);
doxie.MAC_Check_Advanced(justd,did,didsChecked_2,doxie.key_header);
didsChecked := IF(isAdvanced,IF(mod_access.isConsumer(),didsChecked_1,didsChecked_2)
                            ,justd);

dailies := dailyMod.Records;

//scoring of key_header records
doxie.layout_header_records take(doxie.layout_header_records ri) := transform
  self.penalt := if(ri.includedByHHID, score_threshold_value-1,MAX(
			  doxie.FN_Tra_Penalty(ri.fname,ri.mname,ri.lname,
                             ri.ssn,(string)ri.dob,(string)ri.did,
                             ri.predir,ri.prim_range,ri.prim_name,ri.suffix,ri.postdir,ri.sec_range,
                             ri.city_name,ri.county_name,ri.st,ri.zip,
                             ri.phone, allow_wildcard)+
			  // give back points if the listed phone matches
			  IF(phone_value<>'' and ri.phone<>phone_value and ri.listed_phone=phone_value, -3, 0), 0));

	self.did := if (IncludeAllRecords or include_fun(SELF.penalt,ri.tnt,ri.dt_last_seen),ri.did,skip );
  self.ssn := if ( do_not_fill_blanks and ri.valid_ssn='M','',ri.ssn );
  self.dob := if ( do_not_fill_blanks and ri.valid_dob='M',0,ri.dob );
	self.num_compares := 0;
  self.includedByHHID := ri.includedByHHID;
  self.prim_range := if(reduced_data_value,'',ri.prim_range);
  self.predir := if(reduced_data_value,'',ri.predir);
  self.prim_name := if(reduced_data_value,'',ri.prim_name);
  self.suffix := if(reduced_data_value,'',ri.suffix);
  self.postdir := if(reduced_data_value,'',ri.postdir);
  self.unit_desig := if(reduced_data_value,'',ri.unit_desig);
  self.sec_range := if(reduced_data_value,'',ri.sec_range);
  self := ri;
  end;


// for the extra records, check that the dids made it through the advanced check
f := IF(isAdvanced,
				JOIN(dailies(did<>0),didsChecked, LEFT.did=RIGHT.did, 
							TRANSFORM(doxie.Layout_presentation, SELF := LEFT)),
				PROJECT(dailies, TRANSFORM(doxie.Layout_presentation, SELF := LEFT)));
headerMod := bothMod.mod_Header(didsChecked);
headerRecords_noscore := headerMod.headerRecords_Unclean;

// if do_not_fill_blanks=true, no manufactured SSNs will be present in the data, so nothing special to do.
// if do_not_fill_blanks=false, manufactured SSNs (valid_ssn=M) formerly could have been 
// displayed in the results.  The valid_ssn=M doesn't convey any real meaning to the user, 
// but we can determine what the real valid_ssn value should be by deriving it from the other 
// header records for each DID.

// there should never be a case where there are only valid_ssn='M' records for any DID,
// as these would have been 'manufactured' (patched) from other records with native SSNs in 
// the header for a given DID.   Just to make sure we don't lose any records though, the 
// join is left outer.
headerRecords_noscore getValidSSN(headerRecords_noscore le, headerRecords_noscore ri) := transform
	self.valid_ssn := if(ri.did <> 0, ri.valid_ssn, le.valid_ssn);
	self := le;
end;

headerRecords_validSSN := join(headerRecords_noscore(valid_ssn='M'), headerRecords_noscore(valid_ssn <> 'M'),
															 left.did = right.did and 
															 left.ssn = right.ssn, 
															 getValidSSN(left,right), 
															 left outer, keep(1));

headerRecords_validSSN_all := headerRecords_validSSN + headerRecords_noscore(valid_ssn <> 'M');

headerRecords_use := if(do_not_fill_blanks, headerRecords_noscore, headerRecords_validSSN_all);

headerPretty := project(headerRecords_use, take(left));	
header.MAC_GlbClean_Header(headerPretty,headerCleaned_1, , , mod_access);

header.MAC_GLB_DPPA_Clean_RNA(headerCleaned_1, headerRNACleaned);
headerCleaned_2 := IF(checkRNA, headerRNACleaned, headerCleaned_1);

HeaderHouseHoldsOnly := headerCleaned_2(includedbyhhid);
header.MAC_GLB_DPPA_Clean_RNA(HeaderHouseHoldsOnly, HeaderHouseHoldsCleaned);
headerCleaned := headerCleaned_2(~includedbyhhid) + HeaderHouseHoldsCleaned;
//The commented out line below is for a future Experian Credit header restrictiuon change
//header.MAC_GlbClean_Header(headerPretty,headerCleaned,,doxie.DataRestriction.ECH);

// ****** get some ssn's for phones 

phones := f(src='PH' AND did<>0); // just phones
phones_dids := PROJECT(DEDUP(phones,did,all),TRANSFORM(doxie.layout_references, SELF.did := (unsigned)LEFT.did));

phones_bests := doxie.best_records(phones_dids,doSuppress:=false, modAccess := mod_access);

phones append_ssn(phones le, phones_bests ri) :=
TRANSFORM
	SELF.ssn := IF(le.ssn='',ri.ssn,le.ssn);
	self.valid_ssn := if(le.ssn='',ri.valid_ssn,'');
	SELF := le;
END;
j := JOIN(phones, phones_bests, (unsigned6)LEFT.did=RIGHT.did, append_ssn(LEFT,RIGHT), LEFT OUTER, LOOKUP);
f2 := if(~isrollup, f(src<>'PH' OR did=0) + j,f);


// do scoring of extra records
doxie.Layout_presentation scoreOutside(f le) :=
TRANSFORM
	SELF.penalt := if(le.includedByHHID, score_threshold_value-1,doxie.FN_Tra_Penalty(le.fname,le.mname,le.lname,
                             le.ssn,(string)le.dob,(string)le.did,
                             le.predir,le.prim_range,le.prim_name,le.suffix,le.postdir,le.sec_range,
                             le.city_name,le.county_name,le.st,le.zip,
                             le.phone, allow_wildcard));
	SELF.did := if (IncludeAllRecords or include_fun(SELF.penalt,le.tnt,le.dt_last_seen),le.did,skip );
	SELF.num_compares := 0;	
  SELF := le;
END;
f3 := JOIN(f2, headerCleaned, LEFT.did=0 AND
											(LEFT.fname=RIGHT.fname) AND
											NID.FirstName_Match(LEFT.mname,RIGHT.mname)>0 AND
											(LEFT.lname=RIGHT.lname) AND
											(LEFT.prim_range=RIGHT.prim_range) AND
											(LEFT.prim_name=RIGHT.prim_name) AND
											(LEFT.zip=RIGHT.zip) AND
											(LEFT.phone=RIGHT.phone OR LEFT.phone=RIGHT.listed_phone), 
						scoreOutside(LEFT),LEFT ONLY, LOOKUP);

// combine everything, including records wiht no DID, if desired
Fetch1 := headerCleaned+IF(include_dailies,f3(includeZeroDids_value OR did<>0));

// We'll prune non-current and historical records here if CurrentResidentsOnly is checked.
Fetch2 := IF( currentResidentsOnly,
              doxie.CurrentResidents.fn_GetCurrentResidentsOnly( PROJECT(Fetch1, doxie.Layout_presentation), 
                                                                 doxie.Header_File_Modules .m_PersonalInfo_Basic, 
                                                                 doxie.Header_File_Modules .m_AddressInfo_Basic ),
              Fetch1
             );
						 
// if the request included household memebers, need to ensure that after penalty and minor suppressions have been 
// applied, that househould members remain only for the corresponding non-filtered subject DIDs
//
// note: this is a bit of a "lesser of two evils" approach.   It requires a second set of accesses against
// the HHID keys to post-filter out the household members that don't belong after subject suppression.
// However, the alternative of having to hit the header keys twice (once for subjects, then for household members)
// wasn't a preferable option.
hh_dids := doxie.Get_Household_DIDs(project(Fetch2(did<>0, ~includedByHHID, penalt<score_threshold_value), doxie.layout_references));

good_hh_recs := join(Fetch2(includedByHHID), hh_dids, LEFT.did = RIGHT.did, 
										 transform(doxie.Layout_presentation, SELF := LEFT));

// preserve all of the subject records, plus all of the checked household records
hh_checked := Fetch2(~includedByHHID) + good_hh_recs;

Fetch3 := if (whole_house, hh_checked, Fetch2);

// rollup dates in standard fashion
doxie.mac_HeaderDates(Fetch3,Fetched_hd)
Fetched_hd2 := IF(mod_access.isConsumer (), Fetch3, Fetched_hd);

// allow for an historical search
fetched := Fetched_hd2(mod_access.date_threshold = 0 OR dt_first_seen <= mod_access.date_threshold);

// check we don't have too many records
// apply a lower limit for bpssearch variants
// wch_limit := if(ApplyBpsFilter, 1000, 10000);

// attempt to rewrite this to bypass an apparent platform issue
// raising the limit to 2K for the bpsFilter path to allow for some rollup factor
l_small := limit(fetched,2000,FAIL(203, doxie.ErrorCodes(203)));
l_large := limit(fetched,ReturnLimit,FAIL(11, doxie.ErrorCodes(11)));

l := if(ApplyBpsFilter, l_small, l_large);

// output(dailies, named('dailies'));
// output(headerRecords_noscore, named('headerRecords_noscore'));
// output(headercleaned, named('headercleaned'));
// output(dids, named('get_dids'));
// output(f, named('f'));
// output(didsChecked, named('didsChecked'));
// output(l, named('l'));

RETURN l;

END;