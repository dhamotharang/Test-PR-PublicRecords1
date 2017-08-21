Import LN_PropertyV2, ut;
EXPORT Ownership_File := Module

	f_search := Files.file_search_building_did_out(did<>0 or bdid<>0, source_code[1..2] in ['OP','BP'], (Constants.st_restrict=[] or st in Constants.st_restrict));
	Layouts.l_owner_thin toOwnerThin(f_search L) := transform
		self.did				:= if(L.cname<>'', L.bdid, L.did);
		self.which_orig	:= (unsigned1)L.which_orig;
		self.isBDID			:= (L.cname<>'');
		self := L;
	end;
	Layouts.l_hist_thin toHistThin(f_search L) := transform
		self.ln_fares_id	:= L.ln_fares_id;
		self.dt_seen			:= L.dt_first_seen*100;
		self.owners				:= project(dataset([{1}], {unsigned a}), toOwnerThin(L));
	end;
	Layouts.l_owner_full toOwnerFull(f_search L) := transform
		self.did				:= if(L.cname<>'', L.bdid, L.did);
		self.which_orig	:= (unsigned1)L.which_orig;
		self.isBDID			:= (L.cname<>'');
		self := L;
	end;
	Layouts.l_work toWork(f_search L) := transform
		self.fips_code								:= '';
		self.orig_state								:= '';
		self.orig_county							:= '';
		self.unformatted_apn					:= '';
		self.legal_brief_description	:= '';
		self.aceaid										:= 0;
		self.current									:= false;
		self.hist											:= project(dataset([{1}], {unsigned a}), toHistThin(L));
		self.cur_owners								:= project(dataset([{1}], {unsigned a}), toOwnerFull(L));
		self.rawaid										:= L.append_rawaid;
		self.addr_suffix							:= L.suffix;
		self.zip5											:= L.zip;
		self													:= L;
	end;
	ds_search_dist		:= project(f_search, toWork(left));
	shared ds_search	:= dedup(ds_search_dist, hist[1].ln_fares_id, record, all);
	shared dataset(Layouts.l_work) fn_roll_owners(dataset(Layouts.l_work) ds_flat) := function
		Layouts.l_hist_thin appendHistOwner(Layouts.l_hist_thin L, Layouts.l_owner_thin R) := transform
			self.owners := L.owners & R;
			self := L;
		end;
		Layouts.l_work rollOwners(Layouts.l_work L, Layouts.l_work R) := transform
			okRoll := count(L.cur_owners)<Constants.max_owners;
			self.hist				:= if(okRoll, project(L.hist, appendHistOwner(left, R.hist[1].owners[1])), L.hist);
			self.cur_owners	:= if(okRoll, L.cur_owners & R.cur_owners, L.cur_owners);
			self := L;
		end;
		return rollup(sort(ds_flat, hist[1].ln_fares_id), rollOwners(left,right), hist[1].ln_fares_id);
	end;
	f_assess := Files.ln_propertyv2_tax(fips_code<>'', (Constants.st_restrict=[] or state_code in Constants.st_restrict));
	t_assess :=  project(f_assess,Layouts.l_assess);
	Layouts.l_work addAssess(Layouts.l_work L, t_assess R) := transform
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
		project(L.hist, transform({Layouts.l_hist_thin}, self.dt_seen:=(unsigned4)dt, self:=left)), L.hist);
		self.fips_code								:=	R.fips_code;
		self.orig_state							:=	R.state_code;
		self.orig_county							:=	R.county_name;
		self.unformatted_apn						:=	LN_PropertyV2.fn_strip_pnum(R.fares_unformatted_apn,true);
		self.legal_brief_description					:=	R.legal_brief_description;
		self										:=	L;
	end;
	ds_assess_flat := join(
		ds_search(hist[1].ln_fares_id[2]='A'), t_assess,
		left.hist[1].ln_fares_id = right.ln_fares_id,
		addAssess(left,right)
	);
	shared ds_assess := fn_roll_owners(ds_assess_flat);
	f_deed := Files.ln_propertyv2_deed(fips_code<>'', (Constants.st_restrict=[] or state in Constants.st_restrict));
	t_deed := project(f_deed,Layouts.l_deed);
	Layouts.l_work addDeed(Layouts.l_work L, t_deed R) := transform
		dt := map(
			R.contract_date<>''		=> R.contract_date,
			R.recording_date<>''	=> R.recording_date,
			''
		);
		self.hist						:= if(dt<>'',
		project(L.hist, transform({Layouts.l_hist_thin}, self.dt_seen:=(unsigned4)dt, self:=left)),
		L.hist);
		self.fips_code								:=	R.fips_code;
		self.orig_state								:=	R.state;
		self.orig_county							:=	R.county_name;
		self.unformatted_apn					:=	LN_PropertyV2.fn_strip_pnum(R.fares_unformatted_apn,true);
		self.legal_brief_description	:=	R.legal_brief_description;
		
		self													:=	L;
	end;
	ds_deed_flat := join(NOFOLD(
		ds_search)(hist[1].ln_fares_id[2]='D'), t_deed,
		left.hist[1].ln_fares_id = right.ln_fares_id,
		addDeed(left,right)
	);
	shared ds_deed := fn_roll_owners(ds_deed_flat);
	shared ds_combined_aid		:= ds_assess + ds_deed	;
	shared ds_combined_noaid	:= ds_assess(rawaid=0) + ds_deed(rawaid=0);

	shared best_min_ratio				:= 1.5; // the best APN must be this much better than the 2nd-best APN
	Layouts.l_work rollHist(Layouts.l_work L, Layouts.l_work R) := transform
		self.hist := if(count(L.hist)<Constants.max_hist, L.hist&R.hist, L.hist);
		self := L;
	end;
	shared ds_roll := rollup(sort( ds_combined_noaid(unformatted_apn<>''),fips_code,unformatted_apn), rollHist(left,right), fips_code, unformatted_apn);
	shared ds_thinAID := project(ds_combined_aid, Layouts.l_rawaid);
	Layouts.l_rawaid rollHist(Layouts.l_rawaid L, Layouts.l_rawaid R) := transform
		self.hist := if(count(L.hist)<Constants.max_hist, L.hist&R.hist, L.hist);
		self := L;
	end;
	export ownership_file_addr 	:= rollup(sort(ds_thinAID,prim_range,predir,prim_name,addr_suffix,postdir,sec_range,zip5), 
						rollHist(left,right), prim_range,predir,prim_name,addr_suffix,postdir,sec_range,zip5);
	Layouts.l_norm1 toNorm1(Layouts.l_work L, Layouts.l_hist_thin R, unsigned C) := transform
		self.current				:= (C=1); 
		self.dt_first_seen			:= R.dt_seen;
		self.dt_last_seen			:= R.dt_seen;
		self.owners				:= R.owners;
		self 					:= L;
	end;

	ds_norm1 := normalize(ds_roll, left.hist, toNorm1(left,right,counter));

	Layouts.l_id toNorm2(Layouts.l_norm1 L, Layouts.l_owner_thin R) := transform
		self.did		:= R.did;
		self.isBDID	:= R.isBDID;
		self 		:= L;
	end;

	ds_norm2 := normalize(ds_norm1, left.owners, toNorm2(left,right));

	Layouts.l_id rollDid(Layouts.l_id L, Layouts.l_id R) := transform
		self.current				:=	L.current or R.current;
		self.dt_first_seen			:=	ut.min2(L.dt_first_seen,	R.dt_first_seen);
		self.dt_last_seen			:=	max(L.dt_last_seen,	R.dt_last_seen);
		self						:=	L;
	end;

	file_id	:= rollup(sort(ds_norm2(did<>0),did, isBDID, fips_code, unformatted_apn ), 
					rollDid(left,right), did, isBDID, fips_code, unformatted_apn);

	export ownership_file_did	:= project(file_id(not isBDID), Layouts.l_did);


End;