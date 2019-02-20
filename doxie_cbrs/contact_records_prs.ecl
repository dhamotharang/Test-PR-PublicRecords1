/*2005-05-05T14:02:37Z (Chad Morton)
add reverse phone lookup and deathfile indicator to contacts
*/
import doxie, business_header, ut, NID, DeathV2_Services, AutoStandardI;

export contact_records_prs(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION
deathparams := DeathV2_Services.IParam.GetDeathRestrictions(AutoStandardI.GlobalModule());
glb_ok := deathparams.isValidGlb();

contacts := doxie_cbrs.contact_records(bdids);

//****** APPEND ADDRESS ID
addrs := doxie_cbrs.contact_address_records(bdids);
cr_rec := {contacts, addrs.address_id};
cr_rec add_id(contacts l, addrs r) := transform
	self.address_id := r.address_id;
	self := l;
end;

cr := join(contacts, addrs,
					 left.prim_Range = right.prim_range and
					 left.prim_name = right.prim_name and
					 left.sec_Range = right.sec_range and
					 left.zip = right.zip,
					 add_id(left, right),
					 left outer);



dk := doxie.key_death_masterV2_ssa_DID;

ctr := {string60 company_title, unsigned1 title_rank};

outrec := record
	cr.level;
	cr.bdid;
	cr.did;
	cr.record_type;
	cr.dt_first_seen;
	cr.dt_last_seen;		
	cr.company_title;   // Title of Contact at Company if available
	cr.title;
	cr.fname;
	cr.mname;
	cr.lname;
	cr.name_suffix;
	string9 ssn;
	cr.company_name;
	dataset(ctr) company_title_children;
	unsigned1 lowest_title_rank;
	boolean has_death_record := false;
	cr.address_id;
end;



cleantitle(string src, string title) := map(
	//specific requests
	trim(title,left,right) in ['DOMAIN ADMINISTRATIVE CONTACT', 'DOMAIN TECHNICAL CONTACT'] => '',
	src = 'D' => stringlib.StringFindReplace(title,'PROJECT ',''),
	title);


//** prep for rollups
kct := business_header.Key_Company_Title;
outrec addid(cr l, kct r) := transform	
	mytitle := if(r.decode_company_title <> '', r.decode_company_title, l.company_title);
	mycleantitle := cleantitle(l.source,mytitle);
	myrank := doxie_cbrs.rankTitle(mytitle);
	self.company_title_children := 
		dataset([{mycleantitle, myrank }], ctr);
	self.lowest_title_rank := myrank;
	self := l;
end;

pfr0 := //project(cr, addid(left));
	join(cr, kct, 
			 keyed(trim(left.company_title, left, right) = right.company_title),
			 addid(left, right), left outer, keep(1));

//** see about getting a bester name
dids := dedup(sort(project(pfr0, doxie.layout_references), did), did);
doxie.mac_best_records(dids, did, best_recs, true, glb_ok,, doxie.DataRestriction.fixed_DRM);	

pfr0 get_best_name(pfr0 l, best_recs r) := transform
		isbest := r.fname <> '';
		self.title := if(isbest, r.title, l.title);
		self.fname := if(isbest, r.fname, l.fname);
		self.mname := if(isbest, r.mname, l.mname);
		self.lname := if(isbest, r.lname, l.lname);
		self.name_suffix := if(isbest, r.name_suffix, l.name_suffix);
		self := l;
end;

pfr := join(pfr0, best_recs, 
						left.did > 0 and left.did = right.did and right.fname <> '' and right.lname <> '',
						get_best_name(left, right),
						left outer, keep(1));


//****** ROLLUP TO COMBINE TITLES
outrec rollem(outrec l, outrec r) := transform
	self.company_title_children :=
		dedup(sort(l.company_title_children + r.company_title_children(company_title <> ''),title_rank,company_title));
	self.lowest_title_rank := if(r.lowest_title_rank < l.lowest_title_rank and r.lowest_title_rank > 0, r.lowest_title_rank, l.lowest_title_rank);
	self.dt_last_seen := if(l.dt_last_seen > r.dt_last_seen, l.dt_last_seen, r.dt_last_seen);
	self.dt_first_seen := if(l.dt_first_seen <> 0 and l.dt_first_seen < r.dt_first_seen, l.dt_first_seen, r.dt_first_seen);
	self := l;
end;

//** once by bdid and did

fr1 := sort(pfr, bdid, did, company_title);
							         //bdid, did, company_title);

rlld1 := rollup(fr1, left.bdid = right.bdid and left.did > 0 and left.did = right.did, rollem(left, right));

//** once by bdid and name
string50 myname(string25 fn, string25 lna) := 
	trim(NID.PreferredFirstNew(fn)) +
	metaphonelib.DMetaPhone1(lna);
	
fr2 := sort(rlld1, bdid, myname(fname, lname), company_title);
							           //bdid, myname(fname, lname), company_title);

rlld2 := rollup(fr2, left.bdid = right.bdid and 
										 myname(left.fname, left.lname) = myname(right.fname, right.lname), rollem(left, right));

//** and once by cname and did

string40 ccn(string cn) := ut.CleanCompany(cn)[1..40];
fr3 := sort(rlld2, ccn(company_name), did, company_title);
									       //ccn(company_name), did, company_title);

rlld3 := rollup(fr3,
			 ccn(left.company_name) = ccn(right.company_name) and left.did > 0 and left.did = right.did, rollem(left, right));


//** and once by cname and name
fr4 := sort(rlld3, ccn(company_name), myname(fname, lname), company_title);
							           //ccn(company_name), myname(fname, lname), company_title);

rlld4 := rollup(fr4, ccn(left.company_name) = ccn(right.company_name) and 
										 myname(left.fname, left.lname) = myname(right.fname, right.lname), rollem(left, right));


//get those dups out and sort
outrec nodup(outrec l) := transform
	self.company_title_children := dedup(sort(l.company_title_children(company_title <> ''),title_rank,company_title));
	self := l;
end;

ddpd := project(rlld4, nodup(left));


//** add death indicator

outrec addd(ddpd l, dk r) := transform
	self.has_death_record := r.l_did > 0;
	self.company_title := '';
	self := l;
end;

wdth := join(ddpd, dk, LEFT.did<>0 AND keyed(left.did = right.l_did)
   		and not DeathV2_Services.functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
			addd(left, right), KEEP(1), left outer);


//** add SSN
// well, it seems we actually just need to let it through
/*
doxie.mac_best_records(wdth,did,ssnsd,dppa_ok,glb_ok)
ssns := dedup(sort(ssnsd, did, -ssn), did);

outrec addssn(wdth l, ssns r) := transform
	self.ssn := \if(r.ssn <> '', r.ssn, l.ssn);
	self := l;
end;

wssn := join(wdth, ssns, left.did = right.did, addssn(left, right), left outer);

wout := project(wdth, transform(outrec, self.ssn := '', self := left));
pssn := if(doxie_cbrs.stored_ShowPersonalData_value, wssn, wout);
*/
pssn := project(wdth, transform(outrec, 
								self.ssn := if(doxie_cbrs.stored_ShowPersonalData_value,left.ssn,''), 
								self := left));
//limit
srt := sort(pssn, level,  lowest_title_rank, lname, fname, -did);


return srt; 
END;
