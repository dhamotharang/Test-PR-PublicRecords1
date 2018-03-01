import LN_PropertyV2,ut,AID_Build;

// -------------------------------------------------------------------------
// This is what we're working toward...
// -------------------------------------------------------------------------
l_own		:=	LN_PropertyV2.layout_ownership_did;
l_hist	:=	l_own.hist;

// -------------------------------------------------------------------------
// Base File -- owner records with DIDs,property address only (not mailing)
// -------------------------------------------------------------------------
f_base	:=	LN_PropertyV2.File_Search_DID(did<>0,source_code[1..2] in ['OP','BP']);

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
f_assess	:=	LN_PropertyV2.File_Assessment;

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
f_deed	:=	LN_PropertyV2.File_Deed;

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
	self.hist											:=	dataset([{L.dt_first_seen*100,L.ln_fares_id,L.did}],{l_hist});
	
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

ds_combined_aid		:=	distribute(ds_assess_ace	+	ds_deed_ace,hash32(aceaid)) : persist('~thor_data400::persist::ln_propertyv2::own_combined');
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
// output(choosen(roll_flat,50),named('roll_flat')); // DEBUG
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
// output(choosen(ds_preroll,50),named('ds_preroll')); // DEBUG
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
	self.dt_last_seen		:=	max(L.dt_last_seen,	R.dt_last_seen);
	self.hist						:=	if((count(L.hist)=LN_PropertyV2.Constants.maxRecsByOwnership),L.hist,L.hist&R.hist);
	self								:=	L;
end;

ds_dist :=	distribute(ds_curr,hash32(did));
ds_sort :=	sort(ds_dist,did,fips_code,unformatted_apn,-hist[1].dt_seen,-hist[1].ln_fares_id,-hist[1].owner_did,local);
ds_roll :=	rollup(ds_sort,toRoll(left,right),did,fips_code,unformatted_apn,local);


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
export	file_ownership_did	:=	ds_roll;