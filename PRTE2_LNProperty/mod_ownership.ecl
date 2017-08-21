//* mod_ownership - create Customer Test LNProperty Ownership Keys 
/*
	mod_ownership -- defines the build logic for all the property ownership keys
	
	Records for "a property" are ultimately commoned up by fips+apn, but the raw data
	isn't 100% populated with perfect APNs.  So, we're going to do some work along the
	way to remove extraneous APN formatting and append APNs where none existed (when
	we can determine a "best" APN based on address information).

	The major steps of building the key files are as follows...
	
		distributed by ln_fares_id:
			1. Extract data from "search" file (which has party and parsed address info)
			2. Extract data from assessment file, join with search data, and rollup owners
			3. Extract data from deed file, join with search data, and rollup owners
		
		distributed by rawaid:
			4. Append aceaid to deed+assessment records, and combine
			5. Merge ownership records into datasets with and without aid
		
		distributed by aceaid:
			6. Determine "best" APNs by aceaid
			7. Append "best" APN to records with no known APN, where possible

		distributed in succession by the fields driving each rollup:
			8. Rollup by fips+apn
			9. Rollup by rawaid
			10. Rollup by address
			11. Rollup by did/bdid
*/

import LN_PropertyV2, ut, AID, AID_Build, Standard;

export mod_ownership := module

// ---------------------------------
//	0. Common constants and layouts
// ---------------------------------

// For the production build this should be an empty set, which means a complete
// build of all states.  For debugging/testing, just add a list of the state codes
// you want to build, to greatly reduce the size of the data generated.
shared st_restrict := [];

// We actually have as many as 56 owners/buyers in some records, but they are
// are exceptional enough to not justify the huge increase in memory & space
// necessary to store them all.  A max of 10 covers 99.9997% of the ln_fares_id
// records that we would ideally be interested in.
shared max_owners := 10;

// We actually have some properties (as defined by fips+apn) supported by thousands
// of distinct ln_fares_ids.  It's not practical to keep all of those in the history
// table, though.  Setting a limit of 100 fully covers 99.9911% of the properties,
// and where truncation is necessary we'll just keep the most recent 100 which will
// be suitable for most purposes.
shared max_hist := 100;

shared l_owner_thin := record
	unsigned6	did;
	unsigned1	which_orig;
	boolean		isBDID;
end;

shared l_owner_full := record(l_owner_thin)
	string20	fname;
	string20	lname;
	string50	cname;
end;

shared l_hist_thin := record
	string12							ln_fares_id;
	unsigned4							dt_seen;		// YYYYMMDD
	dataset(l_owner_thin)	owners			{maxcount(max_owners)};
end;

shared l_work := record
	// rolled info
	boolean								current;
	dataset(l_hist_thin)	hist				{maxcount(max_hist)};
	dataset(l_owner_full)	cur_owners	{maxcount(max_owners)};
	
	// tax appraiser info
	string5		fips_code;
	string45	unformatted_apn;
	string2		orig_state;
	string30	orig_county;
	string250	legal_brief_description;
	
	// address info
	AID.Common.xAID	rawaid;
	AID.Common.xAID	aceaid;
	Standard.Addr and not [fips_state, fips_county, cbsa];
end;


// -----------------------------------------------------------------------------
//	1. Extract data from "search" file (which has party and parsed address info)
// -----------------------------------------------------------------------------

// use owner records with DIDs or BDIDs, property address only (no mailing addrs)
f_search := LN_PropertyV2.File_Search_DID(did<>0 or bdid<>0, source_code[1..2] in ['OP','BP'], (st_restrict=[] or st in st_restrict));

l_owner_thin toOwnerThin(f_search L) := transform
	self.did				:= if(L.cname<>'', L.bdid, L.did);
	self.which_orig	:= (unsigned1)L.which_orig;
	self.isBDID			:= (L.cname<>'');
	self := L;
end;

l_hist_thin toHistThin(f_search L) := transform
	self.ln_fares_id	:= L.ln_fares_id;
	self.dt_seen			:= L.dt_first_seen*100;
	self.owners				:= project(ut.ds_oneRecord, toOwnerThin(L));
end;

l_owner_full toOwnerFull(f_search L) := transform
	self.did				:= if(L.cname<>'', L.bdid, L.did);
	self.which_orig	:= (unsigned1)L.which_orig;
	self.isBDID			:= (L.cname<>'');
	self := L;
end;

l_work toWork(f_search L) := transform
	// Retrieved from deed/assessment files
	self.fips_code								:= '';
	self.orig_state								:= '';
	self.orig_county							:= '';
	self.unformatted_apn					:= '';
	self.legal_brief_description	:= '';
	
	// Computed later
	self.aceaid										:= 0;
	self.current									:= false;
	
	// Available in search data
	self.hist											:= project(ut.ds_oneRecord, toHistThin(L));
	self.cur_owners								:= project(ut.ds_oneRecord, toOwnerFull(L));
	self.rawaid										:= L.append_rawaid;
	self.addr_suffix							:= L.suffix;
	self.zip5											:= L.zip;
	self													:= L;
end;

ds_search_dist		:= distribute(project(f_search, toWork(left)), hash32(hist[1].ln_fares_id));
ds_search_srt			:= sort(ds_search_dist, hist[1].ln_fares_id, record, local);
shared ds_search	:= dedup(ds_search_srt, hist[1].ln_fares_id, record, local);



// --------------------------------------------------------------------------------
//	2. Extract data from assessment file, join with search data, and rollup owners
// --------------------------------------------------------------------------------

export dataset(l_work) fn_roll_owners(dataset(l_work) ds_in) := function
	ds_flat := distributed(ds_in, hash32(hist[1].ln_fares_id)); // caller will distribute by ln_fares_id
	
	ds_sort := sort(ds_flat, hist[1].ln_fares_id, hist[1].owners[1].which_orig, hist[1].owners[1].did, local);
	
	l_hist_thin appendHistOwner(l_hist_thin L, l_owner_thin R) := transform
		self.owners := L.owners & R;
		self := L;
	end;
	
	l_work rollOwners(l_work L, l_work R) := transform
		okRoll := count(L.cur_owners)<max_owners;
		self.hist				:= if(okRoll, project(L.hist, appendHistOwner(left, R.hist[1].owners[1])), L.hist);
		self.cur_owners	:= if(okRoll, L.cur_owners & R.cur_owners, L.cur_owners);
		self := L;
	end;
	
	return rollup(ds_sort, rollOwners(left,right), hist[1].ln_fares_id, local);
end;

// only records with a populated fips_code are useful
f_assess := LN_PropertyV2.File_Assessment(fips_code<>'', (st_restrict=[] or state_code in st_restrict));

l_assess := record
	f_assess.ln_fares_id;
	f_assess.fips_code;
	f_assess.state_code;
	f_assess.county_name;
	f_assess.fares_unformatted_apn;
	f_assess.legal_brief_description;
	f_assess.tax_year;
	f_assess.assessed_value_year;
	f_assess.market_value_year;
	f_assess.certification_date;
	f_assess.tape_cut_date;
	f_assess.recording_date;
	f_assess.prior_recording_date;
	f_assess.sale_date;
end;

t_assess := distribute( project(f_assess,l_assess), hash32(ln_fares_id));

l_work addAssess(l_work L, t_assess R) := transform
	// date fields in assessment file are probably better than the search file
	dt := map(
		R.tax_year<>''							=> R.tax_year+'0000',
		R.assessed_value_year<>''		=> R.assessed_value_year+'0000',
		R.market_value_year<>''			=> R.market_value_year+'0000',
		R.certification_date<>''		=> R.certification_date+'00',
		R.tape_cut_date<>''					=> R.tape_cut_date,
		R.recording_date<>''				=> R.recording_date,
		R.prior_recording_date<>''	=> R.prior_recording_date,
		R.sale_date<>''							=> R.sale_date,
		''
	);
	self.hist						:= if(dt<>'',
														project(L.hist, transform({l_hist_thin}, self.dt_seen:=(unsigned4)dt, self:=left)),
														L.hist);
	
	self.fips_code								:=	R.fips_code;
	self.orig_state								:=	R.state_code;
	self.orig_county							:=	R.county_name;
	self.unformatted_apn					:=	LN_PropertyV2.fn_strip_pnum(R.fares_unformatted_apn,true);
	self.legal_brief_description	:=	R.legal_brief_description;
	self													:=	L;
end;

// shared ds_assess := join(
ds_assess_flat := join(
	ds_search(hist[1].ln_fares_id[2]='A'), t_assess,
	left.hist[1].ln_fares_id = right.ln_fares_id,
	addAssess(left,right),
	local
);

shared ds_assess := fn_roll_owners(ds_assess_flat);



// --------------------------------------------------------------------------
//	3. Extract data from deed file, join with search data, and rollup owners
// --------------------------------------------------------------------------
f_deed := LN_PropertyV2.File_Deed(fips_code<>'', (st_restrict=[] or state in st_restrict));

l_deed := record
	f_deed.ln_fares_id;
	f_deed.fips_code;
	f_deed.state;
	f_deed.county_name;
	f_deed.fares_unformatted_apn;
	f_deed.legal_brief_description;
	f_deed.contract_date;
	f_deed.recording_date;
end;

t_deed := distribute( project(f_deed,l_deed), hash32(ln_fares_id));

l_work addDeed(l_work L, t_deed R) := transform
	// date fields in deed file are likely better than the search file
	dt := map(
		R.contract_date<>''		=> R.contract_date,
		R.recording_date<>''	=> R.recording_date,
		''
	);
	self.hist						:= if(dt<>'',
														project(L.hist, transform({l_hist_thin}, self.dt_seen:=(unsigned4)dt, self:=left)),
														L.hist);
	
	self.fips_code								:=	R.fips_code;
	self.orig_state								:=	R.state;
	self.orig_county							:=	R.county_name;
	self.unformatted_apn					:=	LN_PropertyV2.fn_strip_pnum(R.fares_unformatted_apn,true);
	self.legal_brief_description	:=	R.legal_brief_description;
	
	self													:=	L;
end;

// shared ds_deed := join(
ds_deed_flat := join(NOFOLD(
	ds_search)(hist[1].ln_fares_id[2]='D'), t_deed,
	left.hist[1].ln_fares_id = right.ln_fares_id,
	addDeed(left,right),
	local
);

shared ds_deed := fn_roll_owners(ds_deed_flat);



// ----------------------------------------------------------
//	4. Append aceaid to deed+assessment records, and combine
// ----------------------------------------------------------
k_aid	:= AID_Build.Key_AID_Base;
l_aid	:= {k_aid.rawaid; k_aid.aceaid;};

dist_aid := distribute(project(pull(k_aid)(rawaid<>0,aceaid<>0),l_aid), hash32(rawaid));

dist_assess := distribute(ds_assess(rawaid<>0), hash32(rawaid));

ds_assess_ace := join(	dist_assess, dist_aid,
												left.rawaid	=	right.rawaid,
												transform(l_work, self.aceaid:=right.aceaid, self:=left),
												left outer, keep(1), local
											);

dist_deed := distribute(ds_deed(rawaid<>0),hash32(rawaid));

ds_deed_ace := join(	dist_deed, dist_aid,
											left.rawaid	=	right.rawaid,
											transform(l_work, self.aceaid:=right.aceaid, self:=left),
											left outer, keep(1), local
										);



// ---------------------------------------------------------------
//	5. Merge ownership records into datasets with and without aid
// ---------------------------------------------------------------
shared ds_combined_aid		:= ds_assess_ace + ds_deed_ace							: persist('~thor_data400::persist::ln_propertyv2::own_combined_aid');
shared ds_combined_noaid	:= ds_assess(rawaid=0) + ds_deed(rawaid=0)	: persist('~thor_data400::persist::ln_propertyv2::own_combined_noaid');


// ------------------------------------
//	6. Determine "best" APNs by aceaid
// ------------------------------------
shared best_min_ratio				:= 1.5; // the best APN must be this much better than the 2nd-best APN
shared ds_combined_aid_dist	:= distribute(ds_combined_aid, hash32(aceaid));

l_flat := record
	l_work.aceaid;
	typeof(l_work.unformatted_apn) apn;
	unsigned4 cnt;
end;

l_flat toFlat(l_work L) := transform
	self.aceaid	:=	if(L.aceaid<>0,L.aceaid,skip);
	self.apn		:=	if(L.unformatted_apn<>'',L.unformatted_apn,skip);
	self.cnt		:=	1;
end;

ds_flat := project(ds_combined_aid_dist, toFlat(left));

roll_flat := rollup(	sort(ds_flat,aceaid,apn,local),
											transform(l_flat, self.cnt:=left.cnt+right.cnt, self:=left),
											aceaid, apn,
											local
										);

l_apn := record
	l_flat.apn;
	l_flat.cnt;
end;

l_roll := record
	l_flat.aceaid;
	typeof(l_flat.apn) best_apn;
	dataset(l_apn) apns {maxcount(2)};
end;

ds_preroll := project(	sort(roll_flat,aceaid,-cnt,local),
												transform(l_roll, self.apns:=dataset([{left.apn,left.cnt}],l_apn), self.best_apn:='', self:=left)
											);

ds_rollACE := rollup(	ds_preroll,
											transform(l_roll, self.apns:=choosen(left.apns&right.apns,2), self:=left),
											aceaid,
											local
										);

export file_bestapn_aceaid := project(	ds_rollACE,
																				transform(
																					l_roll,
																					self.best_apn	:=	map(
																						count(left.apns) = 1																	=>	left.apns[1].apn,
																						left.apns[1].cnt >= (left.apns[2].cnt*best_min_ratio)	=>	left.apns[1].apn,
																						skip
																					),
																					self:=left
																				)
																			);


// -------------------------------------------------------------------
// 	7. Append "best" APN to records with no known APN, where possible
// -------------------------------------------------------------------
ds_goodAPN	:= ds_combined_aid(unformatted_apn<>'') + ds_combined_noaid(unformatted_apn<>''); // no need for improvement
ds_badAPN		:= ds_combined_aid_dist(unformatted_apn='');

ds_tryAPN 	:= join(	ds_badAPN, file_bestapn_aceaid,
											left.aceaid=right.aceaid,
											transform(l_work, self.unformatted_apn:=right.best_apn, self:=left),
											keep(1), local
										);

ds_foundAPN	:= ds_tryAPN(unformatted_apn<>'');

shared ds_improved := ds_goodAPN + ds_foundAPN;




// ---------------------------------------------------------------------
//	8. Rollup by fips+apn
//
//	This is the gold standard of ownership, since fips+apn is how we've
//	chosen to identify "a property".  This key contains all details.
// ---------------------------------------------------------------------

l_work rollHist(l_work L, l_work R) := transform
	self.hist := if(count(L.hist)<max_hist, L.hist&R.hist, L.hist);
	self := L;
end;

ds_dist := distribute(ds_improved, hash32(fips_code, unformatted_apn));
ds_sort := sort(ds_dist, fips_code, unformatted_apn, -hist[1].dt_seen, -(count(hist[1].owners)), record, local);
shared ds_roll := rollup(ds_sort, rollHist(left,right), fips_code, unformatted_apn, local);

export l_fipsAPN		:= {l_work and not current};
export file_fipsAPN	:= project(ds_roll, l_fipsAPN);


// -----------------------------------------------------------------
//	9. Rollup by rawaid
//
//	This is similar to rolling by fips+apn, except variations among
//	records can lead to multiple address variations per fips+apn.
//	We keep the record fairly narrow, allowing for followup joins
//	via fips+apn or by ln_fares_id to gather additional info.
// -----------------------------------------------------------------
shared l_rawaid := record
	// address info
	l_work.rawaid;
	l_work.aceaid;
	l_work.prim_range;
	l_work.predir;
	l_work.prim_name;
	l_work.addr_suffix;
	l_work.postdir;
	l_work.sec_range;
	l_work.zip5;
	
	// tax appraiser info
	l_work.fips_code;
	l_work.unformatted_apn;
	
	// ownership history
	l_work.hist;
end;

shared ds_thinAID := project(ds_improved(rawaid<>0), l_rawaid);

shared l_rawaid rollHist(l_rawaid L, l_rawaid R) := transform
	self.hist := if(count(L.hist)<max_hist, L.hist&R.hist, L.hist);
	self := L;
end;

ds_dist := distribute(ds_thinAID, hash32(rawaid));
ds_sort := sort(ds_dist, rawaid, -(hist[1].dt_seen), -(count(hist[1].owners)), record, local);
export file_rawaid := rollup(ds_sort, rollHist(left,right), rawaid, local);


// -----------------------------------------------------------------
//	10. Rollup by address
//
//	Exactly the same concept as by rawaid.
//
//	NOTE: The same layout as rawaid is OK, since INDEX() will pull
//	the applicable keyed fields to the front of the layout.
// -----------------------------------------------------------------
ds_dist := distribute(ds_thinAID, hash32(prim_range,predir,prim_name,addr_suffix,postdir,sec_range,zip5));
ds_sort := sort(ds_dist, prim_range,predir,prim_name,addr_suffix,postdir,sec_range,zip5, -(hist[1].dt_seen), -(count(hist[1].owners)), record, local);
export file_addr := rollup(ds_sort, rollHist(left,right), prim_range,predir,prim_name,addr_suffix,postdir,sec_range,zip5, local);


// ---------------------------------------------------------
//	11. Rollup by did/bdid
// ---------------------------------------------------------

shared l_id := record
	// rolled info
	unsigned6				did;
	boolean					isBDID;
	boolean					current;
	unsigned4				dt_first_seen;	// YYYYMMDD
	unsigned4				dt_last_seen;		// YYYYMMDD

	// tax appraiser info
	string5		fips_code;
	string45	unformatted_apn;
	
	// address info
	AID.Common.xAID	rawaid;
	AID.Common.xAID	aceaid;
	
	// ownership history
	l_work.hist;
end;

l_norm1 := record
	l_id and not [did,isBDID];
	dataset(l_owner_thin) owners  {maxcount(max_owners)};
end;
l_norm1 toNorm1(l_work L, l_hist_thin R, unsigned C) := transform
	self.current					:= (C=1); // first row of hist is "current"
	self.dt_first_seen		:= R.dt_seen;
	self.dt_last_seen			:= R.dt_seen;
	self.owners						:= R.owners;
	self := L;
end;
ds_norm1 := normalize(ds_roll, left.hist, toNorm1(left,right,counter));

l_id toNorm2(l_norm1 L, l_owner_thin R) := transform
	self.did		:= R.did;
	self.isBDID	:= R.isBDID;
	self := L;
end;
ds_norm2 := normalize(ds_norm1, left.owners, toNorm2(left,right));

l_id rollDid(l_id L, l_id R) := transform
	self.current				:=	L.current or R.current; // if any record is the latest, then we're the current owner
	self.dt_first_seen	:=	ut.min2(L.dt_first_seen,	R.dt_first_seen);
	self.dt_last_seen		:=	ut.max2(L.dt_last_seen,	R.dt_last_seen);
	self								:=	L;
end;

ds_dist := distribute(ds_norm2(did<>0), hash32(did));
ds_sort := sort(ds_dist, did, isBDID, fips_code, unformatted_apn, -dt_first_seen, record, local);

shared file_id	:= rollup(ds_sort, rollDid(left,right), did, isBDID, fips_code, unformatted_apn, local);

export l_did		:= {l_id and not isBDID};
export file_did	:= project(file_id(not isBDID), l_did);

export l_bdid			:= { unsigned6 bdid, l_id and not [did,isBDID] };
export file_bdid	:= project(file_id(isBDID), transform(l_bdid, self.bdid:=left.did, self:=left));


end;