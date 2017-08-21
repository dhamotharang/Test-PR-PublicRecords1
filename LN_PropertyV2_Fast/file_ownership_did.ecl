import LN_PropertyV2,ut,AID_Build; 

EXPORT file_ownership_did(boolean isFast)	:= FUNCTION

// -------------------------------------------------------------------------
// This is what we're working toward...
// -------------------------------------------------------------------------
l_own		:=	LN_PropertyV2.layout_ownership_did;
l_hist	:=	l_own.hist;

// -------------------------------------------------------------------------
// Base File -- owner records with DIDs,property address only (not mailing)
// -------------------------------------------------------------------------
f_base0	:=  LN_PropertyV2.File_Search_DID(did<>0,source_code[1..2] in ['OP','BP']);

f_base1	:=	LN_PropertyV2_Fast.Files.base.search_prp(did<>0,source_code[1..2] in ['OP','BP']);
f_base	:= if(isFast,f_base0 + f_base1,f_base0);

l_base	:=	record
	f_base.ln_fares_id;
	f_base.vendor_source_flag;
	f_base.append_rawaid;
	l_own	and not	[rawaid,aceaid,hist,current,fips_code,orig_state,orig_county,unformatted_apn,legal_brief_description];
end;

t_base	:=	distribute(project(f_base,l_base),hash32(ln_fares_id));


// -------------------------------------------------------------------------
// Assessment File
// -------------------------------------------------------------------------
f_assess0	:=	LN_PropertyV2.File_Assessment;
f_assess1	:=	LN_PropertyV2_Fast.Files.base.assessment;
f_assess	:=	if(isFast,f_assess0 + f_assess1,f_assess0);

l_assess	:=	record
	f_assess.ln_fares_id;
	f_assess.fips_code;
	f_assess.state_code;
	f_assess.county_name;
	f_assess.fares_unformatted_apn;
	f_assess.legal_brief_description;
end;

t_assess	:=	distribute(project(f_assess,l_assess),hash32(ln_fares_id));


// -------------------------------------------------------------------------
// Deed File
// -------------------------------------------------------------------------
f_deed0	:=	LN_PropertyV2.File_Deed;
f_deed1	:=	LN_PropertyV2_Fast.Files.base.deed_mortg;
f_deed	:=	if(isFast,f_deed0 + f_deed1,f_deed0);

l_deed	:=	record
	f_deed.ln_fares_id;
	f_deed.fips_code;
	f_deed.state;
	f_deed.county_name;
	f_deed.fares_unformatted_apn;
	f_deed.legal_brief_description;
end;

t_deed	:=	distribute(project(f_deed,l_deed),hash32(ln_fares_id));


// -------------------------------------------------------------------------
// Project to ownership layout and split by deed/assessment
// -------------------------------------------------------------------------
l_own	toOwn(t_base	L)	:=	transform
	// Assigned during processing
	self.current									:=	false;
	
	// Retrieved from main deed/assessment files
	self.fips_code								:=	'';
	self.orig_state								:=	'';
	self.orig_county							:=	'';
	self.unformatted_apn					:=	'';
	self.legal_brief_description	:=	'';
	
	// Simple rename/reformat
	self.dt_first_seen						:=	L.dt_first_seen*100;
	self.dt_last_seen							:=	L.dt_last_seen*100;
	self.rawaid										:=	L.append_rawaid;
	self.aceaid										:=	0; // assigned later
	self.hist											:=	dataset([{L.dt_first_seen*100,L.ln_fares_id,L.did}],recordof (l_hist));
	
	self													:=	L;
end;

ds_raw	:=	project(t_base,toOwn(left));
ds_rawA	:=	ds_raw(hist[1].ln_fares_id[2]='A');
ds_rawD	:=	ds_raw(hist[1].ln_fares_id[2]= 'D') + ds_raw(hist[1].ln_fares_id[1..2] ='OM' );


// -------------------------------------------------------------------------
// Append FIPS+APN (and some payload) from the Assessment file
// -------------------------------------------------------------------------
l_own addAssess(l_own L,t_assess R)	:=	transform
	self.fips_code								:=	if(R.fips_code<>'',R.fips_code,skip);
	self.orig_state								:=	R.state_code;
	self.orig_county							:=	R.county_name;
	self.unformatted_apn					:=	LN_PropertyV2.fn_strip_pnum(R.fares_unformatted_apn,true);
	self.legal_brief_description	:=	R.legal_brief_description;
	self													:=	L;
end;

ds_assess	:=	join(	ds_rawA,
										t_assess,
										left.hist[1].ln_fares_id	=	right.ln_fares_id,
										addAssess(left,right),
										local
									);


// -------------------------------------------------------------------------
// Append FIPS+APN (and some payload) from the Deed file
// -------------------------------------------------------------------------
l_own addDeed(l_own L,t_deed R)	:=	transform
	self.fips_code								:=	if(R.fips_code<>'',R.fips_code,skip);
	self.orig_state								:=	R.state;
	self.orig_county							:=	R.county_name;
	self.unformatted_apn					:=	LN_PropertyV2.fn_strip_pnum(R.fares_unformatted_apn,true);
	self.legal_brief_description	:=	R.legal_brief_description;
	self													:=	L;
end;

ds_deed	:=	join(	ds_rawD,
									t_deed,
									left.hist[1].ln_fares_id = right.ln_fares_id,
									addDeed(left,right),
									local
								);


// -------------------------------------------------------------------------
// Add aceaid to deeds/assessments and combine 
// -------------------------------------------------------------------------
k_aid	:=	AID_Build.Key_AID_Base;

l_aid	:=	{k_aid.rawaid;k_aid.aceaid;};

dist_aid	:=	distribute(project(k_aid(rawaid<>0,aceaid<>0),l_aid),hash32(rawaid));

dist_assess	:=	distribute(ds_assess(rawaid<>0),hash32(rawaid));

ds_assess_ace	:=	join(	dist_assess,
												dist_aid,
												left.rawaid	=	right.rawaid,
												transform(l_own,self.aceaid:=right.aceaid,self:=left),
												left outer,
												keep(1),
												local
											);

dist_deed	:=	distribute(ds_deed(rawaid<>0),hash32(rawaid));

ds_deed_ace	:=	join(	dist_deed,
											dist_aid,
											left.rawaid	=	right.rawaid,
											transform(l_own,self.aceaid:=right.aceaid,self:=left),
											left outer,
											keep(1),
											local
										);

ds_combined_aid		:=	distribute(ds_assess_ace	+	ds_deed_ace,hash32(aceaid,rawaid));// : persist('~thor_data400::persist::property_fast::own_combined');
ds_combined_noaid	:=	ds_assess(rawaid=0)	+	ds_deed(rawaid=0);


// -------------------------------------------------------------------------
// Determine "best" APNs by aceaid
// -------------------------------------------------------------------------
l_flat	:=	record
	l_own.aceaid;
	typeof(l_own.unformatted_apn) apn;
	unsigned4 cnt;
end;

l_flat	toFlat(l_own L)	:=	transform
	self.aceaid	:=	if(L.aceaid<>0,L.aceaid,skip);
	self.apn		:=	if(L.unformatted_apn<>'',L.unformatted_apn,skip);
	self.cnt		:=	1;
end;

ds_flat	:=	project(ds_combined_aid,toFlat(left));
// output(count(ds_assess_ace)+count(ds_deed_ace),named('cnt_before')); // DEBUG
// output(count(ds_flat),named('cnt_ds_flat')); // DEBUG

roll_flat	:=	rollup(	sort(ds_flat,aceaid,apn,local),
											transform(l_flat,self.cnt:=left.cnt+right.cnt,self:=left),
											aceaid,apn,
											local
										);
// output(c-hoosen(roll_flat,50),named('roll_flat')); // DEBUG
// output(count(roll_flat),named('cnt_roll_flat')); // DEBUG

l_apn	:=	record
	l_flat.apn;
	l_flat.cnt;
end;

l_roll	:=	record
	l_flat.aceaid;
	typeof(l_flat.apn) best_apn;
	dataset(l_apn) apns {maxcount(2)};
end;

ds_preroll	:=	project(	sort(roll_flat,aceaid,-cnt,local),
													transform(l_roll,self.apns:=dataset([{left.apn,left.cnt}],l_apn),self.best_apn:='',self:=left)
												);
// output(c-hoosen(ds_preroll,50),named('ds_preroll')); // DEBUG
// output(ds_preroll(aceaid=1022294786017),named('ds_preroll_filt')); // DEBUG

ds_rollACE	:=	rollup(	ds_preroll,
												transform(l_roll,self.apns:=choosen(left.apns&right.apns,2),self:=left),
												aceaid,
												local
											);
// output(choosen(ds_rollACE,50),named('ds_rollACE')); // DEBUG
// output(ds_rollACE(aceaid=1022294786017),named('ds_rollACE_filt')); // DEBUG
// output(count(ds_rollACE),named('cnt_ds_rollACE')); // DEBUG

ds_best	:=	project(	ds_rollACE,
											transform(	l_roll,
																	self.best_apn	:=	map(	count(left.apns)	=	1													=>	left.apns[1].apn,
																													left.apns[1].cnt	>=	(left.apns[2].cnt*1.5)	=>	left.apns[1].apn,
																													skip
																												),
																	self:=left
																)
										);

// output(choosen(ds_best,50),named('ds_best')); // DEBUG
// output(ds_best(aceaid=1022294786017),named('ds_best_filt')); // DEBUG
// output(count(ds_best),named('cnt_ds_best')); // DEBUG


// -------------------------------------------------------------------------
// Append best APN to records with no known APN
// -------------------------------------------------------------------------
ds_goodAPN	:=	ds_combined_aid(unformatted_apn<>'') + ds_combined_noaid(unformatted_apn<>'');
ds_badAPN		:=	ds_combined_aid(unformatted_apn='');

ds_tryAPN 	:=	join(	ds_badAPN,
											ds_best,
											left.aceaid=right.aceaid,
											transform(l_own,self.unformatted_apn:=right.best_apn,self:=left),
											keep(1),
											local
										);

ds_foundAPN	:=	ds_tryAPN(unformatted_apn	<>	'');
ds_improved	:=	ds_goodAPN	+	ds_foundAPN;

// output(count(ds_goodAPN),named('cnt_ds_goodAPN'));
// output(count(ds_badAPN),named('cnt_ds_badAPN'));
// output(count(ds_tryAPN),named('cnt_ds_tryAPN'));
// output(count(ds_foundAPN),named('cnt_ds_foundAPN'));
// output(choosen(ds_tryAPN,50),named('ds_tryAPN'));
// output(choosen(ds_foundAPN,50),named('ds_foundAPN'));
// output(choosen(ds_improved,50),named('ds_improved'));



// -------------------------------------------------------------------------
// Identify latest owner records within property groups
// -------------------------------------------------------------------------
ds_prop	:=	group(sort(ds_improved,fips_code,unformatted_apn,-dt_last_seen,hist[1].ln_fares_id),fips_code,unformatted_apn);
ds_curr	:=	ungroup(iterate(ds_prop,transform(l_own,self.current:=((counter=1) or (left.current and (left.hist[1].ln_fares_id=right.hist[1].ln_fares_id)) or (left.current and (left.dt_last_seen <> 0 and right.dt_last_seen <>0 and left.dt_last_seen = right.dt_last_seen)) ),self:=right)));


// -------------------------------------------------------------------------
// Rollup by DID+fips+apn
// -------------------------------------------------------------------------
l_own toRoll(l_own L,l_own R)	:=	transform
	self.current				:=	L.current or R.current;			// if any record is the latest,then we're the current owner
	self.dt_first_seen	:=	ut.min2(L.dt_first_seen,	R.dt_first_seen);
	self.dt_last_seen		:=	MAX(L.dt_last_seen,	R.dt_last_seen);
	self.hist						:=	if((count(L.hist)=LN_PropertyV2.Constants.maxRecsByOwnership),L.hist,L.hist&R.hist);
	self								:=	L;
end;

ds_dist :=	distribute(ds_curr,hash32(did));
ds_sort :=	sort(ds_dist,did,fips_code,unformatted_apn,-hist[1].dt_seen,-hist[1].ln_fares_id,-hist[1].owner_did,local);
ds_roll :=	rollup(ds_sort,toRoll(left,right),did,fips_code,unformatted_apn,local);

// -------------------------------------------------------------------------
//Select APNs-fips-prim_names and aceaid-fips that will not run through the aceaid logic to reassign the current flag
//a single apn-fips-prim_name has multiple aceaid.  prim_name is being used because there are cases where the same apn
//and fips can be assigned to completely different properties
// -------------------------------------------------------------------------
single_apn_multi_aceaid := table(ds_roll(aceaid > 0),{unformatted_apn, fips_code, prim_name, aceaid},unformatted_apn, fips_code, prim_name, aceaid);
single_apn_multi_aceaid_ := table(single_apn_multi_aceaid,{unformatted_apn, fips_code, prim_name, cnt := count(group)},unformatted_apn, fips_code, prim_name);

// -------------------------------------------------------------------------
//Trying to find multiunit properties without a sec_range, so that multiple properties are not reflagged to a single current owner
// -------------------------------------------------------------------------
single_aceaid_multi_apn := table(ds_roll(aceaid > 0),{aceaid, unformatted_apn, fips_code},aceaid,unformatted_apn, fips_code);
single_aceaid_multi_apn_ := table(single_aceaid_multi_apn,{aceaid, fips_code, cnt := count(group)},aceaid, fips_code);
// -------------------------------------------------------------------------
//Flagging records that will not be reflagged using aceaid
//a single apn-fips-prim_name has multiple aceaid
// -------------------------------------------------------------------------
flag_ownership_to_dont_fix := join(distribute(ds_roll, hash(unformatted_apn)),
															distribute(single_apn_multi_aceaid_ (cnt > 1), hash(unformatted_apn)),
															left.unformatted_apn =right.unformatted_apn and
															left.fips_code = right.fips_code and
															left.prim_name = right.prim_name,	
															transform({recordof(ds_roll), boolean dont_fix},
																				 self.dont_fix := if(left.unformatted_apn = right.unformatted_apn and left.fips_code = right.fips_code and left.prim_name = right.prim_name, true, false),
																				 self := left),
															left outer,
															local) :independent;
															
// -------------------------------------------------------------------------
//Flagging records that will not be reflagged using aceaid
//a single aceaid-fips has more than 19 apns. Possibly a multiunit property missing sec_range														
// -------------------------------------------------------------------------
flag_ownership_to_dont_fix2 := join(distribute(flag_ownership_to_dont_fix (aceaid > 0 ), hash(aceaid)),
															distribute(single_aceaid_multi_apn_ (cnt > 19), hash(aceaid)),
															left.aceaid =right.aceaid and 
															left.fips_code = right.fips_code,
															transform({recordof(ds_roll), boolean dont_fix},
																				 self.dont_fix := if((left.aceaid = right.aceaid and left.fips_code = right.fips_code) or left.dont_fix = true, true, false),
																				 self := left),
															left outer, local) + flag_ownership_to_dont_fix (aceaid = 0);
															

// -------------------------------------------------------------------------
//Select current owner based on aceaid-fips excluding records with aceaid = 0, flagged as don't fix and without prim_name or prim_name or zip 4
//Records without prim_name or prim_name or zip 4	have high probability of having an unreliable aceaid													
// -------------------------------------------------------------------------
o_sort := sort(distribute(flag_ownership_to_dont_fix2(aceaid <>0 and dont_fix = false and prim_name <> '' and prim_range <> '' and zip4<> ''),hash(aceaid)), aceaid,fips_code, -dt_last_seen,-hist[1].ln_fares_id,-hist[1].owner_did,local); 

l_own_temp := record
	l_own;
	unsigned4 counter_ := 0;
end;

o_prep := project(o_sort,l_own_temp);

l_own_temp toRoll2(l_own_temp L,l_own_temp R)  :=  transform
  self.counter_ := l.counter_+1;
  self          :=  L;
end;

ds_roll_deduped := rollup(o_prep,toRoll2(left,right) ,aceaid, fips_code,local) ; 

// -------------------------------------------------------------------------
// set flag = true to all the records that matches if no match false 
// -------------------------------------------------------------------------

 j1            := join(distribute(flag_ownership_to_dont_fix2 (aceaid <>0 and dont_fix = false and prim_name <> '' and prim_range <> '' and zip4<> ''),hash(aceaid)), 
											ds_roll_deduped,
                            left.aceaid = right.aceaid and 
						                left.fips_code = right.fips_code and 
						                (left.dt_last_seen = right.dt_last_seen or 
						                 left.hist[1].ln_fares_id = right.hist[1].ln_fares_id ), 
						                 transform({flag_ownership_to_dont_fix2, boolean new_flag }, 
														 self.new_flag := if(left.aceaid = right.aceaid and 
														 left.fips_code = right.fips_code and 
														 (left.dt_last_seen = right.dt_last_seen or 
														 left.hist[1].ln_fares_id = right.hist[1].ln_fares_id), 
														 if(right.counter_>1,true,right.current),false),
														 self := left ),left outer, local) + project(flag_ownership_to_dont_fix2(~(aceaid <>0 and dont_fix = false and prim_name <> '' and prim_range <> '' and zip4<> '')), transform({recordof(flag_ownership_to_dont_fix2), boolean new_flag }, self:=left, self.new_flag := left.current));
	

// -------------------------------------------------------------------------
// if one instance true set all instances true (propagate true) else pass on the flag 
// aceaid is zero and different for some same addresses so give preference to clean address components 
// -------------------------------------------------------------------------

j1_d := distribute(j1,hash(did)) ; 

d_sort := dedup(sort(j1_d(prim_range <> '' and prim_name <>'' and zip <>''), did,  prim_range, prim_name, sec_range ,zip, -new_flag,aceaid, local),did,  prim_range, prim_name, sec_range ,zip,local); 

dsImproved := join(j1_d ,d_sort , 
             left.did = right.did and 
						((left.prim_range = right.prim_range and 
						 left.prim_name = right.prim_name and 
						 left.sec_range = right.sec_range and 
						 left.zip = right.zip) or left.aceaid = right.aceaid)
						 , transform({j1_d}, 
						 self.new_flag := if(  left.did = right.did and 
						((left.prim_range = right.prim_range and 
						 left.prim_name = right.prim_name and 
						 left.sec_range = right.sec_range and 
						 left.zip = right.zip) or left.aceaid = right.aceaid) , right.new_flag , left.new_flag) , 
						 
						 self := left) , left outer , local); 

// -------------------------------------------------------------------------
// Debugging...
// -------------------------------------------------------------------------
// output(choosen(ds_rawA,150),named('ds_rawA'));
// output(choosen(ds_rawD,150),named('ds_rawD'));
// output(choosen(ds_assess,150),named('ds_assess'));
// output(choosen(ds_assess_ace,150),named('ds_assess_ace'));
// output(choosen(ds_deed,150),named('ds_deed'));
// output(choosen(ds_deed_ace,150),named('ds_deed_ace'));
// output(choosen(ds_curr,150),named('ds_curr'));
// output(choosen(ds_curr(current),150),named('ds_curr_X'));
// output(choosen(ds_roll,150),named('ds_roll'));
// output(choosen(ds_roll(current),150),named('ds_roll_X'));


// -------------------------------------------------------------------------
// We're done...
// -------------------------------------------------------------------------
file_ownership_did	:=	project(dsImproved, transform(l_own, self.current := left.new_flag, self:= left));
// -------------------------------------------------------------------------
// Debugging...
// -------------------------------------------------------------------------
// output(choosen(ds_rawA,150),named('ds_rawA'));
// output(choosen(ds_rawD,150),named('ds_rawD'));
// output(choosen(ds_assess,150),named('ds_assess'));
// output(choosen(ds_assess_ace,150),named('ds_assess_ace'));
// output(choosen(ds_deed,150),named('ds_deed'));
// output(choosen(ds_deed_ace,150),named('ds_deed_ace'));
// output(choosen(ds_curr,150),named('ds_curr'));
// output(choosen(ds_curr(current),150),named('ds_curr_X'));
// output(choosen(ds_roll,150),named('ds_roll'));
// output(choosen(ds_roll(current),150),named('ds_roll_X'));


// -------------------------------------------------------------------------
// We're done...
// -------------------------------------------------------------------------
RETURN	file_ownership_did;
END;