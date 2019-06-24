import header, ut, doxie, mdr, risk_indicators;


// hf is a dataset of header, filtered by the correct sources before this function is called
export ADL_Risk_Table(dataset(header.layout_header) hf) := function

hdr_slim := RECORD
	hf.Did;
	hf.ssn;
	hf.lname;
	hf.phone;
	hf.dt_first_seen;
	hf.dt_last_seen;
	string40 addr1 := trim(hf.prim_range) + trim(hf.prim_name);
	hf.src;  // hang onto the source in case we need to filter out specific sources for the FCRA version
	hf.zip4;
END;

hf_slim := DISTRIBUTE(table(hf, hdr_slim), HASH(did));


ssn_slim := RECORD
	hf_slim.did;
	hf_slim.ssn;
	dt_first_seen := MIN(GROUP,IF(hf_slim.dt_first_seen=0,999999,hf_slim.dt_first_seen));
	dt_last_seen := MAX(GROUP,hf_slim.dt_last_seen);
END;
d_ssn := TABLE(hf_slim(LENGTH(TRIM(ssn))=9), ssn_slim, did, ssn, LOCAL);

/* HANDLE SSN MASKS */

// First five (six?) masked (000-00-xxxx, 000-00-*xxx)
unmasked5 := d_ssn( ssn[1..5] != '00000' );
  masked5 := d_ssn( ssn[1..5]  = '00000' );

mindate(unsigned3 dt1, unsigned3 dt2) := MIN(IF(dt1=0, 999999, dt1), IF(dt2=0, 999999, dt2) );

fixed5 := join(unmasked5, masked5, left.did=right.did and (left.ssn[6..9]=right.ssn[6..9] or (right.ssn[6]='*' and left.ssn[7..9]=right.ssn[7..9] )),
	transform(ssn_slim,
		self.dt_first_seen := mindate(left.dt_first_seen,right.dt_first_seen),
		self.dt_last_seen  := MAX(left.dt_last_seen,right.dt_last_seen),
		self := if(left.did = 0, right, left )
	),
	full outer,
	local
);

ssn_slim fixedroll( ssn_slim le, ssn_slim ri ) := TRANSFORM 
		 self.dt_first_seen := min( le.dt_first_seen, ri.dt_first_seen); 
		 self.dt_last_seen  := max( le.dt_last_seen,  ri.dt_last_seen ); 
		 self := le; 
END; 
		
fixed5unique := rollup(sort(fixed5,did,ssn,local), fixedroll(left,right), did,ssn,local); // remove dupe socials 


// when only two masked socials exist (eg, 000-00-1234 and 000-00-*234), the above code sees them as two distinct SSNs. rollup to identify them as one
ssn_slim mask_roll(ssn_slim le, ssn_slim ri) := TRANSFORM
	self := if( le.ssn[6]='*', ri, le );
END;
fixed5_rolled := rollup( fixed5unique,
	left.did=right.did and left.ssn[1..5]=right.ssn[1..5] and left.ssn[7..9]=right.ssn[7..9] and '*' in [left.ssn[6],right.ssn[6]],
	mask_roll(left,right), local
);


// Last four masked (xxx-xx-0000)
unmasked4 := fixed5_rolled( ssn[6..9] != '0000' );
  masked4 := fixed5_rolled( ssn[6..9]  = '0000' );

fixed4 := join( unmasked4, masked4, left.did=right.did,
	transform( ssn_slim,
		self.dt_first_seen := mindate(left.dt_first_seen,right.dt_first_seen),
		self.dt_last_seen  := MAX(left.dt_last_seen,right.dt_last_seen),
		self := if(left.did=0, right, left)
	),
	full outer,
	local
);
// fixed4unique := dedup(sort(fixed4,did,ssn,local),did,ssn,local);
 
fixed4unique := rollup( sort(fixed4,did,ssn,local), fixedroll(left,right),did,ssn,local ); 


today1 := ((string) risk_indicators.iid_constants.todaydate)[1..6];
sysdate := today1 + '01';
dk := choosen(doxie.key_max_dt_last_seen, 1);
hdrBuildDate01 := ((string)dk[1].max_date_last_seen)[1..6]+'01';


ssn_stats := record
	did := fixed4unique.did;
	ssn_ct := count(group);
	ssn_ct_c6 := count(group, ut.DaysApart(sysdate, ((string)fixed4unique.dt_first_seen)[1..6]+'31') < 183);
	ssn_ct_s18 := count(group, ut.DaysApart( sysdate, ((string)fixed4unique.dt_last_seen)[1..6]+'31') < risk_indicators.iid_constants.eighteenmonths);
end;
ssn_counts := table(fixed4unique, ssn_stats, did, local);



addr_slim := RECORD
	hf_slim.did;
	hf_slim.addr1;
	dt_first_seen := MIN(GROUP,IF(hf_slim.dt_first_seen=0,999999,hf_slim.dt_first_seen));
	dt_last_seen := MAX(GROUP,hf_slim.dt_last_seen);
END;
d_addr := TABLE(hf_slim(TRIM(addr1)<>''), addr_slim, did, addr1, LOCAL);


// use the build start date as today and adjust the timeframes
addr_stats := record
	did := d_addr.did;
	addr_ct := count(group);
	addr_ct_last30days :=  count(group, ((string)d_addr.dt_first_seen)[1..6]+'31' >= hdrBuildDate01 and d_addr.dt_first_seen<>999999);	// same or greater dt first seen than build date
	addr_ct_last90days :=  count(group, ( ut.DaysApart(hdrBuildDate01, ((string)d_addr.dt_first_seen)[1..6]+'31') < 60 ) or ((string)d_addr.dt_first_seen)[1..6]+'31' >= hdrBuildDate01 and d_addr.dt_first_seen<>999999);
	addr_ct_c6 :=          count(group, ( ut.DaysApart(hdrBuildDate01, ((string)d_addr.dt_first_seen)[1..6]+'31') < risk_indicators.iid_constants.fiveMonths ) or ((string)d_addr.dt_first_seen)[1..6]+'31' >= hdrBuildDate01 and d_addr.dt_first_seen<>999999);
	addr_ct_last1year :=   count(group, ( ut.DaysApart(hdrBuildDate01, ((string)d_addr.dt_first_seen)[1..6]+'31') < risk_indicators.iid_constants.elevenMonths ) or ((string)d_addr.dt_first_seen)[1..6]+'31' >= hdrBuildDate01 and d_addr.dt_first_seen<>999999);
	addr_ct_last2years :=  count(group, ( ut.DaysApart(hdrBuildDate01, ((string)d_addr.dt_first_seen)[1..6]+'31') < risk_indicators.iid_constants.twentythreeMonths ) or ((string)d_addr.dt_first_seen)[1..6]+'31' >= hdrBuildDate01 and d_addr.dt_first_seen<>999999);
	addr_ct_last3years :=  count(group, ( ut.DaysApart(hdrBuildDate01, ((string)d_addr.dt_first_seen)[1..6]+'31') < risk_indicators.iid_constants.thirtyfiveMonths ) or ((string)d_addr.dt_first_seen)[1..6]+'31' >= hdrBuildDate01 and d_addr.dt_first_seen<>999999);	
	addr_ct_last5years :=  count(group, ( ut.DaysApart(hdrBuildDate01, ((string)d_addr.dt_first_seen)[1..6]+'31') < risk_indicators.iid_constants.fiftynineMonths ) or ((string)d_addr.dt_first_seen)[1..6]+'31' >= hdrBuildDate01 and d_addr.dt_first_seen<>999999);
	addr_ct_last10years := count(group, ( (unsigned)sysdate[1..6] - (unsigned)((string)d_addr.dt_first_seen)[1..6] ) < 1000); // within the last 10 years
	addr_ct_last15years := count(group, ( (unsigned)sysdate[1..6] - (unsigned)((string)d_addr.dt_first_seen)[1..6] ) < 1500); // within the last 15 years
end;
addr_counts := table(d_addr, addr_stats, did, local);


// get counts per these sources
addr_slim_src := RECORD
	hf_slim.did;
	hf_slim.addr1;
	hf_slim.src;
END;
d_addr_src := TABLE(hf_slim(TRIM(addr1)<>''), addr_slim_src, did, addr1, src, LOCAL);

addr_src_stats := record
	did := d_addr_src.did;
	dl_addrs_per_adl := count(group, d_addr_src.src[2]='D');
	vo_addrs_per_adl := count(group, d_addr_src.src='VO');
	pl_addrs_per_adl := count(group, d_addr_src.src='PL');
end;
addr_src_counts := table(d_addr_src, addr_src_stats, did, local);


// get invalid addr counts
addr_slim_invalid := RECORD
	hf_slim.did;
	hf_slim.addr1;
	hf_slim.zip4;
	dt_first_seen := MIN(GROUP,IF(hf_slim.dt_first_seen=0,999999,hf_slim.dt_first_seen));
	dt_last_seen := MAX(GROUP,hf_slim.dt_last_seen);
END;
d_addr_invalid := TABLE(hf_slim(TRIM(addr1)<>''), addr_slim_invalid, did, addr1, zip4, LOCAL);


addr_invalid_stats := RECORD
	did := d_addr_invalid.did;
	invalid_addrs_per_adl := count(group, d_addr_invalid.zip4='');
	invalid_addrs_per_adl_created_6months := count(group, ( ut.DaysApart(hdrBuildDate01, ((string)d_addr_invalid.dt_first_seen)[1..6]+'31') < risk_indicators.iid_constants.fiveMonths ) or ((string)d_addr_invalid.dt_first_seen)[1..6]+'31' >= hdrBuildDate01 and 
																												d_addr_invalid.dt_first_seen<>999999 and d_addr_invalid.zip4='');
END;
addr_invalid_counts := table(d_addr_invalid, addr_invalid_stats, did, local);



asl := record
	unsigned6 did;
	unsigned1 addr_ct;
	unsigned1 addr_ct_last30days;
	unsigned1 addr_ct_last90days;
	unsigned1 addr_ct_c6;
	unsigned1 addr_ct_last1year;
	unsigned1 addr_ct_last2years;
	unsigned1 addr_ct_last3years;
	unsigned1 addr_ct_last5years;
	unsigned1 addr_ct_last10years;
	unsigned1 addr_ct_last15years;
	unsigned1 ssn_ct;
	unsigned1 ssn_ct_c6;
	unsigned1 ssn_ct_s18;
	unsigned1 lname_ct;
	unsigned1 lname_ct30;
	unsigned1 lname_ct90;
	unsigned1 lname_ct180;
	unsigned1 lname_ct12;
	unsigned1 lname_ct24;
	unsigned1 lname_ct36;
	unsigned1 lname_ct60;
	string20 newest_lname;
	string20 newest_lname2;
	unsigned3 newest_lname_dt_first_seen;
	unsigned2 dl_addrs_per_adl;
	unsigned2 vo_addrs_per_adl;
	unsigned2 pl_addrs_per_adl;
	unsigned2 invalid_ssns_per_adl;  
	unsigned2 invalid_ssns_per_adl_created_6months;  
	unsigned2 invalid_addrs_per_adl;  
	unsigned2 invalid_addrs_per_adl_created_6months;
end;


// invalid ssn counts
invalid_slim := RECORD
	unsigned6 did;
	unsigned2 invalid_ssns_per_adl;  
	unsigned2 invalid_ssns_per_adl_created_6months; 
END;

// Get info from SSA table
invalid_slim get_ssa(fixed4unique le, header.File_SSN_Map ri) := TRANSFORM
	isSequenceValid := IF(ri.ssn5<>'',true,false);
	
	vssn := Risk_indicators.Validate_SSN(le.ssn,'');
	
	isValidFormat := ~(vssn.invalid OR vssn.begin_invalid OR
											vssn.middle_invalid OR vssn.last_invalid);
											
	validSSN := (isSequenceValid and isValidFormat) or length(trim(le.ssn))=4;								
	self.invalid_ssns_per_adl := if(validSSN, 0, 1);
	self.invalid_ssns_per_adl_created_6months := if(validSSN, 0, if(ut.DaysApart(sysdate, ((string)le.dt_first_seen)[1..6]+'31') < 183, 1, 0));	
	
	SELF := le;
END;
with_ssa := JOIN(fixed4unique(length(trim(ssn))<>4 and (ssn[1..5]<>'00000') and (ssn[6..9]<>'0000')), header.File_SSN_Map,		// don't count masked ssns as invalid
									LEFT.ssn<>'' AND
									LEFT.ssn[1..5]=RIGHT.ssn5 AND
									Left.ssn[6..9] between Right.start_serial and Right.end_serial,
                 get_ssa(LEFT,RIGHT), 
                 LEFT OUTER, LOOKUP);
								


invalid_slim count_invalid_ssns_per_did(invalid_slim le, invalid_slim ri) := transform
	self.invalid_ssns_per_adl := le.invalid_ssns_per_adl + ri.invalid_ssns_per_adl;
	self.invalid_ssns_per_adl_created_6months := le.invalid_ssns_per_adl_created_6months + ri.invalid_ssns_per_adl_created_6months;
	self := ri;
end;
rolled_invalid_ssns := rollup(sort(with_ssa, did, -invalid_ssns_per_adl_created_6months), left.did=right.did, count_invalid_ssns_per_did(left,right), local);	// does this need to be sorted?


// join ssn counts to invalid ssn counts
ssn_counts_final := join(ssn_counts, distribute(rolled_invalid_ssns,hash(did)), left.did=right.did,
															transform(asl, 
																				self.invalid_ssns_per_adl := right.invalid_ssns_per_adl,
																				self.invalid_ssns_per_adl_created_6months := right.invalid_ssns_per_adl_created_6months,
																				self := left, self := []),
															left outer, local);




// join the addr counts and addr src counts together
addr_counts_src := join(addr_counts, addr_src_counts, left.did=right.did,
														transform(asl, 
																			self.dl_addrs_per_adl := right.dl_addrs_per_adl,
																			self.vo_addrs_per_adl := right.vo_addrs_per_adl,
																			self.pl_addrs_per_adl := right.pl_addrs_per_adl,
																			self := left, self := []),
														full outer, local);
														
// join the addr counts and addr src counts and invalid addr counts together
addr_counts_final := join(addr_counts_src, addr_invalid_counts, left.did=right.did,
														transform(asl, 
																			self.invalid_addrs_per_adl := right.invalid_addrs_per_adl, 
																			self.invalid_addrs_per_adl_created_6months := right.invalid_addrs_per_adl_created_6months,
																			self := left, self := []),
														full outer, local);
														
														

// start the ADL table by joining addr_counts and ssn_counts together
addr_ssn := join(ssn_counts_final, addr_counts_final, left.did=right.did, 
				transform(asl, self.did := if(left.did=0, right.did, left.did), 
									self.addr_ct := right.addr_ct,
									self.addr_ct_last30days := right.addr_ct_last30days,
									self.addr_ct_last90days := right.addr_ct_last90days,
									self.addr_ct_c6 := right.addr_ct_c6,
									self.addr_ct_last1year := right.addr_ct_last1year,
									self.addr_ct_last2years := right.addr_ct_last2years,
									self.addr_ct_last3years := right.addr_ct_last3years,
									self.addr_ct_last5years := right.addr_ct_last5years,
									self.addr_ct_last10years := right.addr_ct_last10years,
									self.addr_ct_last15years := right.addr_ct_last15years,
									self.dl_addrs_per_adl := right.dl_addrs_per_adl,
									self.vo_addrs_per_adl := right.vo_addrs_per_adl,
									self.pl_addrs_per_adl := right.pl_addrs_per_adl,
									self.invalid_addrs_per_adl := right.invalid_addrs_per_adl,
									self.invalid_addrs_per_adl_created_6months := right.invalid_addrs_per_adl_created_6months,
									self := left, self := []), 
				full outer, local);
				
				

lname_slim := record
	hf_slim.did;
	hf_slim.lname;
	dt_first_seen := MIN(GROUP,IF(hf_slim.dt_first_seen=0,999999,hf_slim.dt_first_seen));
	dt_last_seen := MAX(GROUP,hf_slim.dt_last_seen);
END;
d_last := TABLE(hf_slim(TRIM(lname)<>''), lname_slim, did, lname, LOCAL);

// use the build start date as today and adjust the timeframes
lname_stats := record
	did := d_last.did;
	lname_ct :=    count(group);
	lname_ct30 :=  count(group, ((string)d_last.dt_first_seen)[1..6]+'31' >= hdrBuildDate01 and d_last.dt_first_seen<>999999);	// same or greater dt first seen than build date
	lname_ct90 :=  count(group, ( ut.DaysApart(hdrBuildDate01, ((string)d_last.dt_first_seen)[1..6]+'31') < 60 ) or ((string)d_last.dt_first_seen)[1..6]+'31' >= hdrBuildDate01 and d_last.dt_first_seen<>999999);
	lname_ct180 := count(group, ( ut.DaysApart(hdrBuildDate01, ((string)d_last.dt_first_seen)[1..6]+'31') < risk_indicators.iid_constants.fiveMonths ) or ((string)d_last.dt_first_seen)[1..6]+'31' >= hdrBuildDate01 and d_last.dt_first_seen<>999999);
	lname_ct12 :=  count(group, ( ut.DaysApart(hdrBuildDate01, ((string)d_last.dt_first_seen)[1..6]+'31') < risk_indicators.iid_constants.elevenMonths ) or ((string)d_last.dt_first_seen)[1..6]+'31' >= hdrBuildDate01 and d_last.dt_first_seen<>999999);
	lname_ct24 :=  count(group, ( ut.DaysApart(hdrBuildDate01, ((string)d_last.dt_first_seen)[1..6]+'31') < risk_indicators.iid_constants.twentythreeMonths ) or ((string)d_last.dt_first_seen)[1..6]+'31' >= hdrBuildDate01 and d_last.dt_first_seen<>999999);
	lname_ct36 :=  count(group, ( ut.DaysApart(hdrBuildDate01, ((string)d_last.dt_first_seen)[1..6]+'31') < risk_indicators.iid_constants.thirtyfiveMonths ) or ((string)d_last.dt_first_seen)[1..6]+'31' >= hdrBuildDate01 and d_last.dt_first_seen<>999999);	
	lname_ct60 :=  count(group, ( ut.DaysApart(hdrBuildDate01, ((string)d_last.dt_first_seen)[1..6]+'31') < risk_indicators.iid_constants.fiftynineMonths ) or ((string)d_last.dt_first_seen)[1..6]+'31' >= hdrBuildDate01 and d_last.dt_first_seen<>999999);
END;
lname_counts := table(d_last, lname_stats, did, local);


d_last_corrected := project(d_last, transform(recordof(d_last), 
																							self.dt_first_seen := if(left.dt_first_seen=999999, 0, left.dt_first_seen), 
																							self := left ) , local);

most_recent_last := sort(d_last_corrected, did, -dt_first_seen, -dt_last_seen, local);


lname_rec := record
	lname_counts;
	string20 newest_lname;
	string20 newest_lname2;
	unsigned3 newest_lname_dt_first_seen;
end;

lname_results := join(lname_counts, most_recent_last, left.did=right.did, 
											transform(lname_rec, self.newest_lname := right.lname,
																self.newest_lname_dt_first_seen := right.dt_first_seen, 
																self := left, self := []), keep(2), local);
																
lname_rec rollIt(lname_rec le, lname_rec ri) := transform
	self.newest_lname2 := ri.newest_lname;
	self := le;
end;
rolled_lnames := rollup(lname_results, left.did=right.did, rollIt(left, right));


// now add in the lname_counts
addr_ssn_dist := distribute(addr_ssn, hash(did));
rolled_lnames_dist := distribute(rolled_lnames, hash(did));

addr_ssn_lname := join(addr_ssn_dist, rolled_lnames_dist, left.did=right.did,
							transform(asl, self.did := if(left.did=0, right.did, left.did), self := right, self := left, self := []),
							full outer, local);


risk_adl := record
	asl;	
	unsigned1 stability;
	unsigned4 reported_dob;
	string2 reported_dob_src;
	integer inferred_age;
	
	unsigned4 reported_dob_no_dppa;
	string2 reported_dob_src_no_dppa;
	integer inferred_age_no_dppa;
end;
	
// now append the stability flag

	// initial header filter
	f  := hf(dt_first_seen != 0, dt_last_seen != 0, prim_name[1..6] != 'PO BOX' );

	mobi := RECORD
		f.did;
		f.dt_first_seen; // use these as first/last current
		f.dt_last_seen;
		f.prim_range;
		f.prim_name;
		f.zip;
		integer3  first_ever        := -1;
		integer3  last_ever         := -1;
		INTEGER2  num_addr_last_5yr := -1;
		INTEGER2  curr_years        := -1;
		INTEGER2  tot_stay_prior    := -1;
		INTEGER2  tot_stay_last2    := -1;
	END;


	stab_hdr := table( f, mobi );

	today := (integer)today1[1..4];

	// rollup into records for a particular did and address
		hdrDist := distribute( stab_hdr, HASH(did) );
		hdr_sorted := sort( hdrDist, did, prim_range, prim_name, zip, LOCAL );
		mobi currRoll( mobi le, mobi ri ) := TRANSFORM
			first_seen := MIN( le.dt_first_seen, ri.dt_first_seen );
			last_seen  := MAX( le.dt_last_seen,  ri.dt_last_seen );
			self.dt_first_seen := first_seen;
			self.dt_last_seen  := last_seen;
			
			thisYears := (INTEGER)(last_seen/100) - (INTEGER)(first_seen/100);
			self.curr_years := MAX(le.curr_years, thisYears);

			self := le;
		END;
		hdr_currRolled := rollup( hdr_sorted, currRoll(LEFT,RIGHT), did, prim_range, prim_name, zip, LOCAL );


		// handle records that aren't duplicates (didn't go through the rollup)
		mobi currProject( mobi le ) := transform
			self.curr_years := (INTEGER)(le.dt_last_seen/100) - (INTEGER)(le.dt_first_seen/100);
			self := le;
		end;
		hdr_currProjected := project( hdr_currRolled( curr_years = -1 ), currProject(LEFT) );
		
		hdr_current := hdr_currRolled( curr_years != -1 ) + hdr_currProjected;
	//

	// rollup into records for a particular did
		hdr_currSorted := sort( hdr_current, did, -dt_first_seen, -dt_last_seen, LOCAL );

		mobi everRoll( mobi le, mobi ri ) := TRANSFORM		

			first_iteration := le.tot_stay_last2 = -1;
			
			self.first_ever     := MIN( if( first_iteration, le.dt_first_seen, le.first_ever ), ri.dt_first_seen );
			self.last_ever      := MAX( if( first_iteration, le.dt_last_seen,  le.last_ever ),  ri.dt_last_seen );
			
			self.tot_stay_last2 := if( first_iteration, le.curr_years + ri.curr_years, le.tot_stay_last2 );
			self.tot_stay_prior := if( first_iteration, ri.curr_years, le.tot_stay_prior );


			newer := le.dt_last_seen > ri.dt_last_seen;
			dt_last_seen  := if( newer, le.dt_last_seen, ri.dt_last_seen );
			dt_first_seen := if( newer, le.dt_first_seen, ri.dt_first_seen );
			

			self.curr_years := le.curr_years;//if( first_iteration, (INTEGER)(dt_last_seen/100) - (INTEGER)(dt_first_seen/100), le.curr_years );
			self.dt_last_seen := dt_last_seen;
			self.dt_first_seen := dt_first_seen;

			num_addr_left  := if( le.num_addr_last_5yr = -1 AND (today - (INTEGER)(le.dt_last_seen/100)) <= 5, 1, 0 );
			num_addr_right := if( ri.num_addr_last_5yr = -1 AND (today - (INTEGER)(ri.dt_last_seen/100)) <= 5, 1, 0 );
			
			self.num_addr_last_5yr := if( le.num_addr_last_5yr = -1, 0, le.num_addr_last_5yr ) + num_addr_left + num_addr_right;
			self := le;
		END;
		
		hdr_everRolled := rollup( hdr_currSorted, everRoll(LEFT,RIGHT), did, LOCAL );

		// handle records that aren't duplicates (didn't go through the rollup)
		mobi everProject( mobi le ) := transform
			self.curr_years := le.curr_years;//le.dt_last_seen/100 - le.dt_first_seen/100;
			self.tot_stay_last2 := le.curr_years;
			self.tot_stay_prior := 0;
			self.num_addr_last_5yr := if( (today - le.dt_last_seen/100) <= 5, 1, 0 );
			self.first_ever := le.dt_first_seen;
			self.last_ever  := le.dt_last_seen;

			self := le;
		end;
		hdr_everProjected := project( hdr_everRolled( first_ever = -1 ), everProject(LEFT) );
		
		hdr_ever := hdr_everRolled( first_ever != -1 ) + hdr_everProjected;


	// main code
		resultrec := RECORD
			unsigned6 did;
			integer stability;
		END;
		
		resultrec calcStability( mobi le ) := TRANSFORM
			last_ever_yr := (INTEGER)le.last_ever[1..4];
			
			length_curr_addr := map(
				le.curr_years >= 7   => 7,
				le.curr_years >= 4   => 4,
				le.curr_years >= 1   => 1,
				0
			);
			length_prior_addr := map(
				le.tot_stay_prior >= 6  => 6,
				le.tot_stay_prior >= 2  => 2,
				0
			);
			grp := if( length_curr_addr=7, 70, length_curr_addr*10 + length_prior_addr );
			stability_indicator_704 := map(
				grp = 70         => 6,
				grp in [6,16,46] => 5,
				grp = 0 AND le.num_addr_last_5yr <= 4 => 2,
				grp = 0 AND le.num_addr_last_5yr >  4 => 1,
				le.tot_stay_last2                >= 5 => 4,
				le.tot_stay_last2                >= 4 => 3,
				le.num_addr_last_5yr             <= 4 => 2,
				le.num_addr_last_5yr             >  4 => 1,
				-9
			);
			
			// self.did       := le.did;
			self.stability := stability_indicator_704;
			self := le;
		END;
	//


	hdr_recent := hdr_ever( (today - ((INTEGER)last_ever/100) <= 1 ) );
	stability_flags := distribute(project( hdr_recent, calcStability(LEFT) ), hash(did));

	
	
stability_phn_addr_ssn := join(addr_ssn_lname, stability_flags, left.did = right.did, 
								transform(risk_adl, self.stability := right.stability, self := left, self := []), left outer, local);// : persist('temp::stability_phn_addr_ssn');
  	

// now append the reported_dob and inferred_age
default_first_seen := 999999;

dob_slim := record
		hf.did;
		hf.ssn;
		hf.dob;
		hf.dt_first_seen;
		hf.dt_last_seen;
		hf.src;
		integer year_source_code_dob;
		integer month_source_code_dob;
		integer day_source_code_dob;
		integer complete_dob;
		integer source_rank;
		// dates used for inferred age calculation
		unsigned socllowissue := default_first_seen;
		unsigned soclhighissue := 0;
		integer age_from_reported_dob := 0;
		integer age_from_src_first_seen := 0;
		integer age_from_ssn_issuance := 0;
		integer inferred_age := 0;
		
		// create a seperate copy of these attributes for users with no permissible purpose
		string2 src_no_dppa := '';
		unsigned4 dob_no_dppa := 0;
		integer age_from_reported_dob_no_DPPA := 0;
		integer age_from_src_first_seen_no_DPPA := 0;
		integer inferred_age_no_DPPA := 0;  // version for ITA which users don't have DPPA permissible purpose and take out voters
end;

p1 := project(hf, 
	transform(dob_slim, 		
				src_temp := if(left.src='LT', 'TU', LEFT.src);
				src := if(mdr.sourcetools.SourceIsDL(src_temp), 'DL', src_temp);
				self.src := src;
				src_no_dppa := if(src in ['DL','VO'], '', src);
				self.src_no_dppa := src_no_dppa;			
				source_rank := map(src='DL' => 1,
													 src='TS' => 2,
													 src='VO' => 3,
													 src='EM' => 4,
													 src='CY' => 5,
													 src='PL' => 6,
													 src='EB' => 7,
													 src='SL' => 8,
													 src='EN' => 9,
													 src='EQ' => 10,
													 src='TU' => 11,						 
					 50);
				self.source_rank := source_rank;
				
				dob_temp := (string)left.dob;
				// clean up some parts of the dob if they're invalid on file
				yy1 := (integer)dob_temp[1..4];
				mm1 := (integer)dob_temp[5..6];
				dd1 := (integer)dob_temp[7..8];
				yy2 := (string4)yy1;
				mm2 := if(mm1>12, '00', intformat(mm1, 2,1) );
				dd2 := if(dd1>31, '00', intformat(dd1, 2, 1) );
				dob := map(yy1 < 1900 => '0',
										mm1>12 or dd1>31 => yy2 + mm2 + dd2,				 
									 (string)left.dob);
									 
				self.dob := (unsigned)dob;
				dob_no_dppa := if(src_no_dppa='', 0, (unsigned)dob);
				self.dob_no_dppa := dob_no_dppa;
				
				year_source_code_dob := (integer)dob[1..4];
				month_source_code_dob := (integer)dob[5..6];
				day_source_code_dob := (integer)dob[7..8];
				
				complete_dob := map(day_source_code_dob > 0 and month_source_code_dob > 0 and year_source_code_dob > 0 => 3,
														month_source_code_dob > 0 and year_source_code_dob > 0 => 2,
														year_source_code_dob > 0 => 1,
														0);
				self.year_source_code_dob := year_source_code_dob;
				self.month_source_code_dob := month_source_code_dob;
				self.day_source_code_dob := day_source_code_dob;
				self.complete_dob := complete_dob;

		
		reported_age := risk_indicators.years_apart((unsigned)sysdate, (unsigned)dob);
		self.age_from_reported_dob := reported_age;
		
		reported_age_no_dppa := risk_indicators.years_apart((unsigned)sysdate, (unsigned)dob_no_dppa);
		self.age_from_reported_dob_no_dppa := reported_age_no_dppa;
		
			
		first_seen_at_source := if(left.dt_first_seen=0, default_first_seen, left.dt_first_seen);
			
		years_since := risk_indicators.years_apart((unsigned)sysdate, left.dt_first_seen);
		
				
		set_18plus_sources := ['EQ','EN','TU','TS',  // bureaus
														'BA','L2',  // bankruptcy and liens
														'FA','FB','FP','LA','LP'];  // property
		set_16plus_sources := ['PL'] + mdr.sourceTools.set_Utility_sources; 
		vo_source := ['VO'];	
		dl_source := ['DL'];
		
		// set_most_useful_sources := ['EQ','EN','TU','UT','VO','DL','BA','L2','PL','FA','FB','FP','LA','LP'];
		set_most_useful_sources := set_18plus_sources + vo_source + dl_source;
				
		all_18plus := set_18plus_sources + vo_source;
				
		self.age_from_src_first_seen := map(src in all_18plus and first_seen_at_source<>default_first_seen => 18 + years_since,
														src in set_16plus_sources and first_seen_at_source<>default_first_seen => 16 + years_since,
														src in dl_source and first_seen_at_source<>default_first_seen => 15 + years_since,
														src not in set_most_useful_sources and first_seen_at_source<>default_first_seen => 15 + years_since,
														0);	

		// doesn't inlude DL and voter
		self.age_from_src_first_seen_no_dppa := map(src in set_18plus_sources => 18 + years_since,
														src in set_16plus_sources and first_seen_at_source<>default_first_seen => 16 + years_since,
														src not in set_most_useful_sources and first_seen_at_source<>default_first_seen => 15 + years_since,
														0);	
														
		self := left));
		

// break the records into 2 buckets to avoid the ssn_issuance lookup if we already have a complete DOB
ssn_issuance_candidates := p1(complete_dob<>3 and ssn<>'');
skipped_ssn_lookup := p1(complete_dob=3 or ssn='');
							
with_ssn_map := join(ssn_issuance_candidates,header.File_SSN_Map, 
                 (LEFT.ssn[1..5]=RIGHT.ssn5) AND
                 (Left.ssn[6..9] between Right.start_serial and Right.end_serial),
                 transform(dob_slim,
									self.socllowissue  := (unsigned)right.start_date;
									self.soclhighissue := (unsigned)right.end_date;
									self := left),
                 LEFT OUTER, LOOKUP);				
									

age_base := ungroup(with_ssn_map + skipped_ssn_lookup);
age_base_distributed := distribute(age_base, hash(did));

dob_slim roll_records(dob_slim le, dob_slim rt) := transform
		highissuedate := max( le.soclhighissue, rt.soclhighissue );
		self.socllowissue := min( le.socllowissue, rt.socllowissue );
		self.soclhighissue := highissuedate;
		age_from_ssn_issuance := risk_indicators.years_apart((unsigned)sysdate, highissuedate);
		self.age_from_ssn_issuance := age_from_ssn_issuance;
		
		age_from_src_first_seen := max( le.age_from_src_first_seen, rt.age_from_src_first_seen );
		self.age_from_src_first_seen := age_from_src_first_seen;
			
		// self.age_from_reported_dob := le.age_from_reported_dob;
		self.age_from_reported_dob_no_dppa := if(le.age_from_reported_dob_no_dppa=0, rt.age_from_reported_dob_no_dppa, le.age_from_reported_dob_no_dppa) ;
		
		// now repeat the code above, but on the no_dppa available data
		self.src_no_dppa := if(le.src_no_dppa in ['DL','VO',''], rt.src_no_dppa, le.src_no_dppa);
		dob_no_dppa := if(le.src_no_dppa in ['DL','VO',''], rt.dob_no_dppa, le.dob_no_dppa);
		self.dob_no_dppa := dob_no_dppa;
		
		age_from_src_first_seen_no_dppa := max( le.age_from_src_first_seen_no_dppa, rt.age_from_src_first_seen_no_dppa);
		self.age_from_src_first_seen_no_dppa := age_from_src_first_seen_no_dppa;		
		
		self := le;
end;

grouped_by_source := group(sort(age_base_distributed, did, src, -complete_dob, -dt_last_seen, -dob, local), did, src, local);
rolled_per_source := ungroup(rollup(grouped_by_source, true, roll_records(left,right)));

grouped_per_did := group(sort(rolled_per_source, did, -complete_dob, source_rank, -dt_last_seen, -dob, src, local), did, local);
one_record_per_did := rollup(grouped_per_did, true, roll_records(left, right));

// calculate the final inferred_age
inferred_age := project(one_record_per_did, transform(dob_slim, 
		self.inferred_age := if(left.age_from_reported_dob > 0, left.age_from_reported_dob, 
																					max(left.age_from_ssn_issuance, left.age_from_src_first_seen) );
		self.inferred_age_no_dppa := if(left.age_from_reported_dob_no_dppa > 0, left.age_from_reported_dob_no_dppa, 
																					max(left.age_from_ssn_issuance, left.age_from_src_first_seen_no_dppa) );

		self := left));

spas_distr := DISTRIBUTE(stability_phn_addr_ssn, HASH(did));
infage_distr := DISTRIBUTE(inferred_age, HASH(did));
				
full_adl_risk := join(spas_distr, infage_distr, left.did=right.did,
						transform(risk_adl, 
											self.inferred_age := right.inferred_age,
											self.inferred_age_no_dppa := right.inferred_age_no_dppa,
											self.reported_dob := right.dob,
											self.reported_dob_no_dppa := right.dob_no_dppa,
											self.reported_dob_src := right.src,
											self.reported_dob_src_no_dppa := right.src_no_dppa,
											
											self := left), left outer, local, keep(1));
													
return full_adl_risk;

end;