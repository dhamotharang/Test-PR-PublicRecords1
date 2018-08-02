import _Control, email_data, riskwise, ut, fcra, mdr;
onThor := _Control.Environment.OnThor;

export Boca_Shell_Email(GROUPED DATASET(layout_bocashell_neutral) clam_pre_email_in, 
	boolean isFCRA, 
	integer bsversion,
	unsigned3 LastSeenThreshold = iid_constants.oneyear,
	unsigned8 BSOptions=0
  ) := FUNCTION



// clean the email address before doing anything else
clam_pre_email := project(clam_pre_email_in, transform(layout_bocashell_neutral, 
	self.shell_input.email_address := stringlib.stringtouppercase(trim(left.shell_input.email_address)), self := left));

SetSources_old := [mdr.sourceTools.src_Acquiredweb,
mdr.sourceTools.src_Entiera, 
mdr.sourceTools.src_Impulse, 
mdr.sourceTools.src_Wired_Assets_Email,
mdr.sourceTools.src_MediaOne, 
mdr.sourceTools.src_SalesChannel,
if(~isFCRA, mdr.sourceTools.src_Datagence, ''),												// this source removed for FCRA April, 2018
if(~isFCRA and bsversion >= 40, mdr.sourceTools.src_Anchor, ''),			// this source added for non FCRA April, 2018	(BS 40 and higher)
if(~isFCRA and bsversion >= 40, mdr.sourceTools.src_RealSource, ''),	// this source added for non FCRA April, 2018 (BS 40 and higher)
mdr.sourcetools.src_InfutorNare


];

SetSources_new := [mdr.sourceTools.src_Acquiredweb,
mdr.sourceTools.src_Entiera,  
mdr.sourceTools.src_Wired_Assets_Email,
mdr.sourceTools.src_MediaOne, 
mdr.sourceTools.src_SalesChannel,
if(~isFCRA, mdr.sourceTools.src_Datagence, ''),		// this source removed for FCRA April, 2018
if(~isFCRA, mdr.sourceTools.src_Anchor, ''),			// this source added for non FCRA April, 2018	(BS 40 and higher)	
if(~isFCRA, mdr.sourceTools.src_RealSource, ''),	// this source added for non FCRA April, 2018 (BS 40 and higher)
mdr.sourcetools.src_InfutorNare



];  // removed Impulse source (IM), per requirement 1.28 in shell 5.0 requirements
setSources := if(bsversion >= 50, SetSources_new, SetSources_old);

// if we need to exclude iBehavior, then use version 2 of the keys
ekey_fcra := email_data.Key_Did_FCRA ;
ekey_nonfcra := email_data.key_did; 
ekey := if(isFCRA, ekey_fcra, ekey_nonfcra);  

emailaddr_key := Email_Data.Key_Email_Address;

layout_reverse_email := record
	string2 verification_level := ''; // -1 through 8
	
	// counts and scores to calculate the Reverse_Email_Verification_Level
	integer adls_per_email := 0;  // number of unique ADLs per email address
	unsigned adl_from_email := 0;  // temp field for calculating adls_per_email
	
	integer emailscore := 0;
	integer fnamescore := 0;
	integer lnamescore := 0;
	integer addrscore := 0;

	integer emailcount := 0;
	integer fnamecount := 0;
	integer lnamecount := 0;
	integer addrcount := 0;

	qstring100 ver_sources := '';
	qstring200 ver_sources_first_seen_date := '';
	qstring200 ver_sources_last_seen_date := '';
	qstring100 ver_sources_recordcount := '';
	qstring100 ver_sources_verification_level := '';
end;

emailrec := record
	unsigned seq;
	// recordof(ekey);	
	ekey.clean_name;
	ekey.clean_address;
	ekey.email_src;
	ekey.clean_email;
	ekey.append_domain_type;
	ekey.date_first_seen;
	ekey.date_last_seen;
	
	integer email_ct := 0;
	integer email_domain_Free_ct := 0;
	integer email_domain_ISP_ct := 0;
	integer email_domain_EDU_ct := 0;
	integer email_domain_Corp_ct := 0;
	
	qstring50 email_source_list := '';
	qstring50 email_source_ct := '';
	qstring100 email_source_first_seen := '';
	qstring100 email_source_last_seen := '';
	
	string2 Identity_Email_Verification_Level := '';

	layout_reverse_email reverse_email;
end;

emailrec add_email_raw(clam_pre_email le, ekey rt) := transform
	self.seq := le.seq;
	
	domain_type := TRIM(rt.append_domain_type);
	self.email_ct := if(TRIM(rt.clean_email)<>'', 1, 0);
	self.email_domain_Free_ct := if(domain_type = 'FREE', 1, 0);
	self.email_domain_ISP_ct := if(domain_type = 'ISP', 1, 0);
	self.email_domain_EDU_ct := if(domain_type = 'EDU', 1, 0);
	self.email_domain_Corp_ct := if(domain_type = 'CORP', 1, 0);
	
	email_src := trim(rt.email_src);
	self.email_source_list := email_src;
	self.email_source_ct := if(email_src <> '', '1', '');
	self.email_source_first_seen := rt.date_first_seen;
	self.email_source_last_seen := rt.date_last_seen;
	
	// new logic for shell 5.0
	ecompare := risk_indicators.EmailCompare(le.shell_input.email_address, rt.clean_email, le.shell_input.fname, le.shell_input.lname);
	emailmatch_score := ecompare.EmailScore; 
	emailmatch := iid_constants.g(emailmatch_score);
	
	Email_First_level := ecompare.Email_First_Level;
	Email_Last_level := ecompare.Email_Last_Level;
	
// -1 Email address not provided on input
// 0-	Email address does not match email addresses on file for the identity
// 1-	Email address does not match email addresses on file for the identity but first name is found in the email address string
// 2-	Email address does not match email addresses on file for the identity but last name is found in the email address string
// 3-	Email address does not match email addresses on file for the identity but first name and last name is found in the email address string
// 4-	Email address matches email addresses on file but it is not the most currently reported email address
// 5-	Email address matches email addresses on file	and is the most currently reported email address
	self.Identity_Email_Verification_Level := map(
		trim(le.shell_input.email_address)='' => '-1',
		// emailmatch => '5',  // won't know till the rollup if we have the most recent or not, so default to a 4 if email_match for now
		emailmatch => '4',  
		email_first_level='1' and email_last_level='1' => '3', 
		email_last_level='1' => '2',
		email_first_level='1' => '1',
		'0'); 				
			
	self := rt;
end;
// only difference is the name of the key to use.  for some reason on roxie at compile time it doesn't work to just toggle the key name prior to the join.																							
email_recs_nonfcra_minus_behavior_roxie := join(clam_pre_email, email_data.key_did2,
						left.did<>0 and 
						keyed(left.did=right.did) 
						and right.email_src IN setsources																		
						and (unsigned)right.date_first_seen[1..6] < left.historydate,
						add_email_raw(left, right),
						left outer,
						atmost(riskwise.max_atmost), keep(1000));

email_recs_nonfcra_minus_behavior_thor := join(distribute(clam_pre_email, hash64(did)), 
						distribute(pull(email_data.key_did2), hash64(did)),
						left.did<>0 and 
						left.did=right.did
						and right.email_src IN setsources																		
						and (unsigned)right.date_first_seen[1..6] < left.historydate,
						add_email_raw(left, right),
						left outer,
						atmost(riskwise.max_atmost), keep(1000), LOCAL);

#IF(onThor)
	email_recs_nonfcra_minus_behavior := email_recs_nonfcra_minus_behavior_thor;
#ELSE
	email_recs_nonfcra_minus_behavior := ungroup(email_recs_nonfcra_minus_behavior_roxie);
#END

email_recs_nonfcra_roxie := join(clam_pre_email, email_data.key_did,
						left.did<>0 and 
						keyed(left.did=right.did) 
						and right.email_src IN setsources																		
						and (unsigned)right.date_first_seen[1..6] < left.historydate,
						add_email_raw(left, right),
						left outer,
						atmost(riskwise.max_atmost), keep(1000));

email_recs_nonfcra_thor := join(distribute(clam_pre_email, hash64(did)), 
						distribute(pull(email_data.key_did), hash64(did)),
						left.did<>0 and 
						left.did=right.did
						and right.email_src IN setsources																		
						and (unsigned)right.date_first_seen[1..6] < left.historydate,
						add_email_raw(left, right),
						left outer,
						atmost(riskwise.max_atmost), keep(1000), LOCAL);
						
#IF(onThor)
	email_recs_non_fcra := email_recs_nonfcra_thor;
#ELSE
	email_recs_non_fcra := ungroup(email_recs_nonfcra_roxie);
#END

emailfile_raw_fcra_roxie := join(clam_pre_email, email_data.Key_Did_FCRA,
						left.did<>0 and 
						keyed(left.did=right.did) and
					  right.email_src IN setsources	
						and (unsigned)right.date_first_seen[1..6] < left.historydate and
						(ut.daysapart(RIGHT.date_last_seen, iid_constants.mygetdate(left.historydate)) < ut.DaysInNYears(7)) and
						(string100)right.email_rec_key not in left.email_data_correct_record_id,  // don't include records in the raw which have been corrected
						add_email_raw(left, right),
						left outer,
						atmost(riskwise.max_atmost), keep(1000));

emailfile_raw_fcra_thor := join(distribute(clam_pre_email, hash64(did)), 
						distribute(pull(email_data.Key_Did_FCRA), hash64(did)),
						left.did<>0 and 
						left.did=right.did and
					  right.email_src IN setsources	
						and (unsigned)right.date_first_seen[1..6] < left.historydate and
						(ut.daysapart(RIGHT.date_last_seen, iid_constants.mygetdate(left.historydate)) < ut.DaysInNYears(7)) and
						(string100)right.email_rec_key not in left.email_data_correct_record_id,  // don't include records in the raw which have been corrected
						add_email_raw(left, right),
						left outer,
						atmost(left.did=right.did, riskwise.max_atmost), keep(1000), LOCAL);

#IF(onThor)
	emailfile_raw_fcra := emailfile_raw_fcra_thor;
#ELSE
	emailfile_raw_fcra := ungroup(emailfile_raw_fcra_roxie);
#END

emailrec add_email_corrections(clam_pre_email le, fcra.Key_Override_Email_Data_ffid rt) := transform
	self.seq := le.seq;
	
	domain_type := TRIM(rt.append_domain_type);
	self.email_ct := if(TRIM(rt.clean_email)<>'', 1, 0);
	self.email_domain_Free_ct := if(domain_type = 'FREE', 1, 0);
	self.email_domain_ISP_ct := if(domain_type = 'ISP', 1, 0);
	self.email_domain_EDU_ct := if(domain_type = 'EDU', 1, 0);
	self.email_domain_Corp_ct := if(domain_type = 'CORP', 1, 0);
	
	email_src := trim(rt.email_src);
	self.email_source_list := email_src;
	self.email_source_ct := if(email_src <> '', '1', '');
	self.email_source_first_seen := rt.date_first_seen;
	self.email_source_last_seen := rt.date_last_seen;
	
	// new logic for shell 5.0
	ecompare := risk_indicators.EmailCompare(le.shell_input.email_address, rt.clean_email, le.shell_input.fname, le.shell_input.lname);
	emailmatch_score := ecompare.EmailScore; 
	emailmatch := iid_constants.g(emailmatch_score);
	
	Email_First_level := ecompare.Email_First_Level;
	Email_Last_level := ecompare.Email_Last_Level;
	
// -1 Email address not provided on input
// 0-	Email address does not match email addresses on file for the identity
// 1-	Email address does not match email addresses on file for the identity but first name is found in the email address string
// 2-	Email address does not match email addresses on file for the identity but last name is found in the email address string
// 3-	Email address does not match email addresses on file for the identity but first name and last name is found in the email address string
// 4-	Email address matches email addresses on file but it is not the most currently reported email address
// 5-	Email address matches email addresses on file	and is the most currently reported email address
	self.Identity_Email_Verification_Level := map(
		trim(le.shell_input.email_address)='' => '-1',
		// emailmatch => '5',  // won't know till the rollup if we have the most recent or not, so default to a 4 if email_match for now
		emailmatch => '4',  
		email_first_level='1' and email_last_level='1' => '3', 
		email_last_level='1' => '2',
		email_first_level='1' => '1',
		'0'); 				
	
	self := rt;
end;

emailfile_corrections_fcra_roxie := join(clam_pre_email, fcra.Key_Override_Email_Data_ffid,
						keyed(right.flag_file_id in left.email_data_correct_ffid) and
				    right.email_src IN setsources	
						and (unsigned)right.date_first_seen[1..6] < left.historydate and
						(ut.daysapart(RIGHT.date_last_seen, iid_constants.mygetdate(left.historydate)) < ut.DaysInNYears(7)) and
						(string100)right.email_rec_key not in left.email_data_correct_record_id,
						add_email_corrections(left, right),
						atmost(riskwise.max_atmost), keep(1000));

emailfile_corrections_fcra_thor := join(clam_pre_email, 
						pull(fcra.Key_Override_Email_Data_ffid),
						right.flag_file_id in left.email_data_correct_ffid and
				    right.email_src IN setsources	
						and (unsigned)right.date_first_seen[1..6] < left.historydate and
						(ut.daysapart(RIGHT.date_last_seen, iid_constants.mygetdate(left.historydate)) < ut.DaysInNYears(7)) and
						(string100)right.email_rec_key not in left.email_data_correct_record_id,
						add_email_corrections(left, right),
						keep(1000), LOCAL, ALL);

#IF(onThor)
	emailfile_corrections_fcra := emailfile_corrections_fcra_thor;
#ELSE
	emailfile_corrections_fcra := emailfile_corrections_fcra_roxie;
#END

email_recs_fcra := 	ungroup(emailfile_raw_fcra + emailfile_corrections_fcra);

emailfile := if(isFCRA, email_recs_fcra, email_recs_non_fcra);		
						
// sort the email results by the email addresses to count unique email addresses
sorted_emails := group(sort(emailfile, seq, clean_email, append_domain_type), seq);

emailrec roll_emails(emailrec le, emailrec rt) := transform
	// upgrade the level to a 5 if it's the latest email in the list
	le_Identity_Email_Verification_Level := if(le.date_last_seen>=rt.date_last_seen and le.Identity_Email_Verification_Level='4', '5', le.Identity_Email_Verification_Level);
	rt_Identity_Email_Verification_Level := if(rt.date_last_seen>=le.date_last_seen and rt.Identity_Email_Verification_Level='4', '5', rt.Identity_Email_Verification_Level);
	self.Identity_Email_Verification_Level := (string)MAX((integer)le_Identity_Email_Verification_Level, (integer)rt_Identity_Email_Verification_Level);
	different_email := le.clean_email<>rt.clean_email;
	self.email_ct := if(different_email, le.email_ct + rt.email_ct, le.email_ct);
	self.email_domain_Free_ct := if(different_email, le.email_domain_Free_ct + rt.email_domain_Free_ct, le.email_domain_Free_ct);
	self.email_domain_ISP_ct := if(different_email, le.email_domain_ISP_ct + rt.email_domain_ISP_ct, le.email_domain_ISP_ct);
	self.email_domain_EDU_ct := if(different_email, le.email_domain_EDU_ct + rt.email_domain_EDU_ct, le.email_domain_EDU_ct);
	self.email_domain_Corp_ct := if(different_email, le.email_domain_Corp_ct + rt.email_domain_Corp_ct, le.email_domain_Corp_ct);
	self := rt;
end;

rolled_emails_counts := rollup(sorted_emails, left.seq=right.seq, roll_emails(left, right));


// now count records per email source, and return lists of sources, dates for each
email_source_table := table(emailfile, 
													{seq, 
													email_src, 
													records_per_source := count(group, email_ct>0),
													first_seen_at_source := min(group, if((unsigned4)date_first_seen=0, 99999999, (unsigned4)date_first_seen)),
													last_seen_at_source := max(group, (unsigned4)date_last_seen)
													}, seq, email_src, few);

emailrec getSourceCounts(rolled_emails_counts le, email_source_table ri) := TRANSFORM
	self.email_source_list := if(ri.records_per_source>0, ri.email_src + ',', '');
	self.email_source_ct := (string)ri.records_per_source + ',';
	self.email_source_first_seen := if(ri.first_seen_at_source=99999999, '0', (string)ri.first_seen_at_source) + ',' ;
	self.email_source_last_seen := (string)ri.last_seen_at_source + ',';
	self := le;
END;

with_source_counts_roxie := join(rolled_emails_counts, email_source_table, left.seq=right.seq,
			getSourceCounts(LEFT,RIGHT));
			
with_source_counts_thor := join(distribute(rolled_emails_counts, hash64(seq)), 
			distribute(email_source_table, hash64(seq)), 
			left.seq=right.seq,
			getSourceCounts(LEFT,RIGHT), LOCAL);

#IF(onThor)
	with_source_counts := with_source_counts_thor;
#ELSE
	with_source_counts := with_source_counts_roxie;
#END

emailrec roll_identity_source_counts(emailrec le, emailrec rt) := transform
		self.email_source_list := trim(le.email_source_list) + rt.email_source_list + ',';
		self.email_source_ct := trim(le.email_source_ct) + if(rt.email_source_list='', '', rt.email_source_ct + ',');
		self.email_source_first_seen := trim(le.email_source_first_seen) + if(rt.email_source_list='', '', rt.email_source_first_seen + ',');
		self.email_source_last_seen := trim(le.email_source_last_seen) + if(rt.email_source_list='', '', rt.email_source_last_seen + ',');
	self := rt;
end;

rolled_Identity_source_counts := rollup(sort(with_source_counts, seq, email_source_first_seen, email_source_list), left.seq=right.seq, roll_identity_source_counts(left, right));


temp := record
	unsigned seq;
	risk_indicators.layouts.layout_email_50 email_summary;
end;

with_identity_email_summary := join(clam_pre_Email, rolled_Identity_source_counts, left.seq=right.seq,
													transform(temp,
													self.email_summary := right,
													self := left));
													

// now add the revers searching logic for shell 5.0 NONFCRA
emailrec add_reverse_email_verification(clam_pre_email le, emailaddr_key rt) := transform
	self.seq := le.seq;
	
	isrecent := iid_constants.myDaysApart(le.historydate, rt.date_last_seen, LastSeenThreshold);
	
	firstmatch_score := Risk_Indicators.FnameScore(le.shell_input.fname,rt.clean_name.fname);
	firstmatch := iid_constants.g(firstmatch_score);
	lastmatch_score := Risk_Indicators.LnameScore(le.shell_input.lname, rt.clean_name.lname);
	lastmatch := iid_constants.g(lastmatch_score);
	
	zip_score := Risk_Indicators.AddrScore.zip_score(le.shell_input.in_zipcode, rt.clean_address.zip);
	addrmatchscore := Risk_Indicators.AddrScore.AddressScore(le.shell_input.prim_range, le.shell_input.prim_name, le.shell_input.sec_range, 
																						rt.clean_address.prim_range, rt.clean_address.prim_name, rt.clean_address.sec_range,
																						zip_score);
	addrmatch := iid_constants.ga(addrmatchscore);
	emailmatch := rt.clean_email<>'';
	self.reverse_email.emailcount := if(emailmatch, 1, 0);
	self.reverse_email.fnamecount := if(firstmatch, 1, 0);
	self.reverse_email.lnamecount := if(lastmatch, 1, 0);
	self.reverse_email.addrcount := if(isRecent and addrmatch, 1, 0);

	self.reverse_email.emailscore := if(emailmatch, 100, 0);
	self.reverse_email.fnamescore := firstmatch_score;
	self.reverse_email.lnamescore := lastmatch_score;
	self.reverse_email.addrscore := addrmatchscore;		

	self.Reverse_Email.Verification_level := map(le.shell_input.email_address='' => '-1', 
																							firstmatch and lastmatch and addrmatch and isRecent and emailmatch => '8',
																							lastmatch and addrmatch and isRecent and emailmatch => '7',
																							firstmatch and addrmatch and isRecent and emailmatch => '6',
																							firstmatch and lastmatch and emailmatch => '5',
																							lastmatch and emailmatch => '4',
																							addrmatch and isRecent and emailmatch => '3',
																							firstmatch and emailmatch => '2',
																							emailmatch => '1',
																							'0');

	self.reverse_email.adl_from_email := rt.did;
	self.reverse_email.adls_per_email := if(rt.did<>0, 1, 0);
	
	self := rt;
	
end;


with_reverse_email_lookup_roxie := join(clam_pre_email, Email_Data.Key_Email_Address,
		left.shell_input.email_address<>'' and 
		keyed(left.shell_input.email_address=right.clean_email)
		and right.email_src IN setsources
		and right.did < 15000000000000  // don't include Fake DIDs
		and (unsigned)right.date_first_seen[1..6] < left.historydate,
	add_reverse_email_verification(left, right), 
		atmost(riskwise.max_atmost), keep(1000), left outer);

with_reverse_email_lookup_thor := join(distribute(clam_pre_email, hash64(shell_input.email_address)), 
		distribute(pull(Email_Data.Key_Email_Address), hash64(clean_email)),
		left.shell_input.email_address<>'' and 
		left.shell_input.email_address=right.clean_email
		and right.email_src IN setsources
		and right.did < 15000000000000  // don't include Fake DIDs
		and (unsigned)right.date_first_seen[1..6] < left.historydate,
	add_reverse_email_verification(left, right), 
		atmost(riskwise.max_atmost), keep(1000), left outer, LOCAL);
		
#IF(onThor)
	with_reverse_email_lookup := group(sort(with_reverse_email_lookup_thor,seq),seq);
#ELSE
	with_reverse_email_lookup := with_reverse_email_lookup_roxie;
#END

reverse_source_stats := table(with_reverse_email_lookup, {seq, email_src,
											ver_level_per_source := max(group, (integer)Reverse_Email.Verification_level),
											records_per_source := count(group),
											first_seen_at_source := min(group, if((unsigned)date_first_seen=0, 99999999, (unsigned)date_first_seen)),
											last_seen_at_source := max(group, (unsigned)date_last_seen),							
											}, seq, email_src);

grp_source_stats := group(sort(reverse_source_stats, seq, first_seen_at_source, email_src), seq);
temp_rec := record
	unsigned seq;
	layout_reverse_email;
end;
	
tf_source_stats := project(grp_source_stats,
						transform(temp_rec,
							vblank := (left.email_src='');
							self.ver_sources := if(vblank,'',left.email_src + ',');
							self.ver_sources_first_seen_date := if(vblank,'',if(left.first_seen_at_source=99999999, '0', (string)left.first_seen_at_source) + ',');
							self.ver_sources_last_seen_date := if(vblank,'',(string)left.last_seen_at_source + ',');
							self.ver_sources_recordcount := if(vblank,'',(string)left.records_per_source + ',');
							self.ver_sources_verification_level := if(vblank,'',(string)left.ver_level_per_source + ',');							
							self := left, 
							self := []));					
		
temp_rec roll_source_stats(temp_rec le, temp_rec rt) := transform
	self.ver_sources := trim(le.ver_sources) + rt.ver_sources +',';
	self.ver_sources_verification_level := trim(le.ver_sources_verification_level) + rt.ver_sources_verification_level +',';
	self.ver_sources_first_seen_date := trim(le.ver_sources_first_seen_date) + rt.ver_sources_first_seen_date + ',';
	self.ver_sources_last_seen_date := trim(le.ver_sources_last_seen_date) + rt.ver_sources_last_seen_date + ',';
	self.ver_sources_recordcount := trim(le.ver_sources_recordcount) + rt.ver_sources_recordcount + ',';

	self := rt;
end;
					
rolled_reverse_source_stats := rollup(tf_source_stats, left.seq=right.seq, roll_source_stats(left,right));
with_reverse_source_stats := join(with_reverse_email_lookup, rolled_reverse_source_stats, left.seq=right.seq, 
												transform(emailrec, 
	self.Reverse_Email.ver_sources := right.ver_sources; 
	self.Reverse_Email.ver_sources_verification_level := right.ver_sources_verification_level;
	self.Reverse_Email.ver_sources_first_seen_date := right.ver_sources_first_seen_date;
	self.Reverse_Email.ver_sources_last_seen_date := right.ver_sources_last_seen_date;
	self.Reverse_Email.ver_sources_recordcount := right.ver_sources_recordcount;
	self := left), left outer, keep(1));  

emailrec rollup_reverse_email_summary(emailrec le, emailrec rt) := transform
	self.reverse_email.verification_level := if((integer)le.reverse_email.verification_level > (integer)rt.reverse_email.verification_level, 
														le.reverse_email.verification_level, rt.reverse_email.verification_level);
	self.reverse_email.adls_per_email := le.reverse_email.adls_per_email + IF(rt.reverse_email.adl_from_email=le.reverse_email.adl_from_email,0,1);
	self := rt;
end;

reverse_email_summary_rolled := rollup(sort(with_reverse_source_stats, seq, -reverse_email.adl_from_email), left.seq=right.seq, rollup_reverse_email_summary(left, right));

// can only do the reverse email lookup in NONFCRA shell and versions greater than 41
reverse_summary := if(~isFCRA and bsversion>=50, reverse_email_summary_rolled, dataset([], emailrec) );

// append the reverse_email data
all_email_data := group(join(with_identity_email_summary, reverse_summary, left.seq=right.seq,
													transform(temp,
													self.email_summary.reverse_email := right.reverse_email,
													self.email_summary := left.email_summary,
													self.seq := left.seq), left outer), seq);
	
// output(emailfile, named('emailfile'));
// output(email_recs_non_fcra, named('email_recs_non_fcra')); 
// output(emailfile_raw_fcra, named('emailfile_raw_fcra'));
// output(sorted_emails, named('sorted_emails'));
// output(rolled_emails_counts, named('rolled_emails_counts'));
// output(email_source_table, named('email_source_table'));
// output(with_source_counts, named('with_source_counts'));
// output(rolled_Identity_source_counts, named('rolled_Identity_source_counts'));	

// output(with_reverse_email_lookup, named('with_reverse_email_lookup'));
// output(reverse_source_stats, named('reverse_source_stats'));
// output(tf_source_stats, named('tf_source_stats'));
// output(rolled_reverse_source_stats, named('rolled_reverse_source_stats'));
// output(with_reverse_source_stats, named('with_reverse_source_stats'));
// output(reverse_email_summary_rolled, named('reverse_email_summary_rolled'));

// output(with_identity_email_summary, named('with_identity_email_summary'));
// output(reverse_summary, named('reverse_summary'));

return all_email_data;


end;

