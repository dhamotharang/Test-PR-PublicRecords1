import header, ut, doxie, data_services;

wdog := pull(Watchdog.key_watchdog_nonglb_nonblank_old);

// should only contain alphas and allowable name punctuation, and optionally be tested for non-blank
isValidStr(string str, boolean emptyOK = false) := (emptyOK or length(trim(str)) > 0) 
																								and str = stringlib.stringfilter(str, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ -');

// need to allow for empty state values that come from death records,
// but require populated name fields 
wdog_clean := wdog(isValidStr(st, true) and isValidStr(lname) and isValidStr(fname));

// pull all of the DIDs/SSNs that cannot be returned to the customer
wdog_pull_ssn := join(wdog_clean(ssn<>''), doxie.File_pullSSN,  
											(string60)left.ssn = right.ssn, 
											transform(left), left only, lookup);

wdog_pull_ssn_all := wdog_pull_ssn + wdog_clean(ssn='');

wdog_pull_did := join(wdog_pull_ssn_all, doxie.File_pullSSN,  
											intformat((unsigned6)left.did,12,1) = right.ssn, 
											transform(left), left only, lookup);
												 
wdog_dist := distribute(wdog_pull_did, hash(did));

// need to filter out any ambiguous DIDs that get filtered from the header search keys
hdr := distribute(dataset(data_services.Data_Location.Watchdog_Best +
																'thor400_84::out::watchdog_filtered_header_nonglb',header.layout_header,flat),hash(did));
			
hdr_ambig := hdr(jflag2 in ['A','B','D','E']);

newrec := RECORD
	wdog;
	string20 pfname := '';
END;


newrec xform(wdog_dist l, hdr_ambig r) := TRANSFORM
	// remove minors
	self.did := IF(l.dob = 0 or ut.GetAgeI(l.dob) >= 18, l.did, SKIP);
	self.pfname := datalib.preferredFirstNew(l.fname, true);
	self := l;
END;

wdog_filt := join(wdog_dist, hdr_ambig, left.did = right.did,
									xform(left, right), left only, local);

export key_watchdog_teaser_old := index(wdog_filt, {lname, st, pfname, fname, zip}, {wdog_filt},data_services.foreign_prod+
																		'thor_data400::key::watchdog_nonglb.teaser_' + doxie.Version_SuperKey);
																		
