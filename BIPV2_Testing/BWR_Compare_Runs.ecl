import ut,BIPV2,Data_Services;

s3 := Data_Services.foreign_prod + 'thor_data_400::bipv2external.113sfullW20130828-144156';
s4 := Data_Services.foreign_prod + 'thor_data_400::bipv2external.113sfullW20130916-174324';
s5 := Data_Services.foreign_prod + 'thor_data_400::bipv2external.113sfullW20131014-144156';
s6 := Data_Services.foreign_prod + 'thor_data_400::bipv2external.113sfullw20131022-130415';
s7 := Data_Services.foreign_prod + 'thor_data_400::bipv2external.113sfullW20131105-085822';
s7a := Data_Services.foreign_prod + 'thor_data_400::bipv2external.113sfullW20131109-005723';
s8 := Data_Services.foreign_prod + 'thor_data_400::bipv2external.113sfullW20131126-173746';

lnold := s7a;	
lnnew := s8; 



import bizlinkfull,tools;
dsold := dataset(lnold, BIPV2_Testing.layouts.xlink, thor); //BK data should be good now
dsnew := dataset(lnnew, BIPV2_Testing.layouts.xlink, thor);

// output(dsold(rid = 20001), named('dsold'));
// output(dsnew(rid = 20001), named('dsnew'));

thresh := 75;

aboveold := dsold(proxscore >= thresh);
abovenew := dsnew(proxscore >= thresh);

// LOST

lost_old := 
join(
	aboveold,
	abovenew,
	left.rid = right.rid,
	left only
);


output(count(lost_old), named('count_lost'));
// output(lost_old, named('sample_lost_old'));

lost_new := 
join(
	lost_old,
	dsnew,
	left.rid = right.rid and right.proxscore > 0,
	transform(right)
);


// output(count(lost_new), named('count_lost_new'));
// output(lost_new, named('sample_lost_new'));

// GAINED

gained_new := 
join(
	aboveold,
	abovenew,
	left.rid = right.rid,
	right only
);

output(count(gained_new), named('count_gained'));
// output(count(dedup(gained_new, rid, all)), named('count_gained_rids'));
// output(gained_new, named('sample_gained_new'));

gained_old := 
join(
	gained_new,
	dsold,
	left.rid = right.rid and right.proxscore > 0,
	transform(right)
);

// output(count(gained_old), named('count_gained_old'));
// output(gained_old, named('sample_gained_old'));

// CHANGED PROXID

changed_proxid_old := 
join(
	aboveold,
	abovenew,
	left.rid = right.rid and left.proxid <> right.proxid,
	transform(left)
);

output(count(changed_proxid_old), named('count_changed_proxid'));
// output(changed_proxid_old, named('sample_changed_proxid_old'));

changed_proxid_new := 
join(
	aboveold,
	abovenew,
	left.rid = right.rid and left.proxid <> right.proxid,
	transform(right)
);

// output(count(changed_proxid_new), named('count_changed_proxid_new'));
// output(changed_proxid_new, named('sample_changed_proxid_new'));

// JUST CHANGED SCORE

changed_score_old := 
join(
	aboveold,
	abovenew,
	left.rid = right.rid and left.proxid = right.proxid and left.proxscore <> right.proxscore,
	transform(left)
);

output(count(changed_score_old), named('count_changed_score'));
// output(changed_score_old, named('sample_changed_score_old'));

changed_score_new := 
join(
	aboveold,
	abovenew,
	left.rid = right.rid and left.proxid = right.proxid and left.proxscore <> right.proxscore,
	transform(right)
);

// output(count(changed_score_new), named('count_changed_score_new'));
// output(changed_score_new, named('sample_changed_score_new'));

rec := BIPV2_Testing.layouts.xlink;

f(
	integer i, 
	string s, 
	dataset(rec) old = dataset([],rec),
	dataset(rec) new = dataset([],rec)
	
	) :=
function

k := 
// bizlinkfull.Process_Biz_Layouts.key;
BIPV2.Key_BH_Linking_Ids.key;
mykrec := {k, unsigned6 rid/*,unsigned4 ProxScore, unsigned4 ProxWeight*/};
mykold := 
join(
	old, k, 
	keyed(left.ultid = right.ultid and left.orgid = right.orgid and left.seleid = right.seleid and left.proxid = right.proxid), 
	transform(
		mykrec, 
		self.rid := left.rid, 
		self.ProxScore := left.ProxScore, 
		self.proxweight := left.Proxweight, 
		self.fname := if(left.fname = right.fname, left.fname, ''),
		self.lname := if(left.lname = right.lname, left.lname, ''),
		self := right
	),keep(10000)
);
myknew := 
join(
	new, k, 
	keyed(left.ultid = right.ultid and left.orgid = right.orgid and left.seleid = right.seleid and left.proxid = right.proxid), 
	transform(
		mykrec, 
		self.rid := left.rid, 
		self.ProxScore := left.ProxScore, 
		self.proxweight := left.Proxweight, 
		self.fname := if(left.fname = right.fname, left.fname, ''),
		self.lname := if(left.lname = right.lname, left.lname, ''),		
		self := right
	),keep(10000)
);

cr := 
{rec.rid, rec.src, k.proxid, 
unsigned4 ProxScore, unsigned4 ProxWeight,  
// unsigned4 oldProxScore, unsigned4 oldProxWeight, unsigned4 newProxScore, unsigned4 newProxWeight,  

string35 note; k.company_name, k.prim_range, k.prim_name, k.sec_range, k.zip, k.p_city_name, 
	k.st, k.company_phone, k.company_fein,/* k.fname, k.lname,*/k.active_domestic_corp_key, k.active_duns_number, k.active_enterprise_number, k.contact_email, k.fname, k.lname,
	// unsigned8 uniqueid
	string20 uniqueid
};
str_ext_note := '--- external input ---';
mykslim := 
project(
	mykold,
	transform(
		cr,
		self := left,
		self.uniqueid := (string)(left.rid)+'.'+(string)(left.proxid) + '.old',
		self.note := 'matching header data -a- OLD',
		self := []
	)
)+
project(
	myknew,
	transform(
		cr,
		self := left,
		self.uniqueid := (string)(left.rid)+'.'+(string)(left.proxid) + '.new',		
		self.note := 'matching header data -b- NEW',
		self := []
	)
)+
dedup(
	project(
		old,
		transform(
			cr,
			self.uniqueid := (string)(left.rid),
			self.proxid := 0,//left.proxid - 1, //this for sorting only and corrected before output
			self.note := str_ext_note,
			self.prim_range := left.company_prim_range,
			self.prim_name := left.company_prim_name,	
			self.zip := left.company_zip,
			self.sec_range := left.company_sec_range,
			self.p_city_name := left.company_city,
			self.st := left.company_state,
			self.contact_email := left.email_Address,
			//old only
			// self.oldproxscore := left.proxscore,
			// self.oldproxweight := left.proxweight,
			//
			self.proxweight := 0;
			self.proxscore := 0;
			self := left,
			self := []

		)
	)
	+	project(
		new,
		transform(
			cr,
			self.uniqueid := (string)(left.rid),
			self.proxid := 0,//left.proxid - 1, //this for sorting only and corrected before output
			self.note := str_ext_note,
			self.prim_range := left.company_prim_range,
			self.prim_name := left.company_prim_name,	
			self.zip := left.company_zip,
			self.sec_range := left.company_sec_range,
			self.p_city_name := left.company_city,
			self.st := left.company_state,
			self.contact_email := left.email_Address,
			//new only
			// self.newproxscore := left.proxscore,
			// self.newproxweight := left.proxweight,
			//		
			self.proxweight := 0;
			self.proxscore := 0;			
			self := left,
			self := []

		)
	), all
);	
krolled := tools.mac_AggregateFieldsPerID(mykslim, uniqueid,,,,TRUE);

//can we generate proxid pairs to run thru compare service?
forcompare := 
dedup(
	join(
		dedup(mykslim, rid, proxid, note, all),
		dedup(mykslim, rid, proxid, note, all),
		left.rid = right.rid and
		left.note = right.note and
		left.proxscore >= 25 and right.proxscore >= 25 and
		left.proxid < right.proxid,
		transform(
			{unsigned6 proxid1, unsigned6 proxid2},
			self.proxid1 := left.proxid,
			self.proxid2 := right.proxid
		)
	, all)
);


return parallel(
	// output(sort(Ds, proxid), named(s+'_inputs_srtd_proxid')),
	// output(sort(project(krolled, transform({krolled}, self.proxid := if(left.notes[1].note = str_ext_note, left.proxid + 1, left.proxid), self := left)), proxid, notes[1].note), all, named(s+'_header_srtd_proxid'))
	// output(sort(project(krolled, transform({krolled}, self.proxid := if(left.notes[1].note = str_ext_note, left.proxid + 1, left.proxid), self := left)), rids[1].rid, notes[1].note), named(s+'_header_srtd_rid'))
	// output(mykslim, named(s+'_mykslim')),
	// output(choosen(forcompare, 500), named(s+'forcompare'));
	
	output(enth(sort(krolled, rids[1].rid, notes[1].note), 300), all, named(s+'_header_srtd_rid'))
	// output(old, named(s+'_old'))
);

end;

f(0, 'lost', lost_old, lost_new);
f(0, 'gained',gained_old, gained_new);
f(0, 'changed_proxid', changed_proxid_old, changed_proxid_new);
f(0, 'changed_score', changed_score_old, changed_score_new);
