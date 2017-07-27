import doxie,doxie_crs,ut;

outrec := LN_PropertyV2_Services.layouts.out_crs;

export dataset(outrec) fn_AddSeqNo(
	dataset(outrec) prop2,
	dataset(doxie.Layout_Comp_Addresses) csa) :=
FUNCTION

//***** Get the most recent property at each addresses
prec := LN_PropertyV2_Services.layouts.parties.pparty;

addr_rec := record
	prec.prim_range;
	prec.prim_name;
	prec.sec_range;
	prec.zip;
	prec.p_city_name;
	prec.v_city_name;
	prec.st;
	typeof(prop2.ln_Fares_id) fid;
	prop2.sortby_date;
	outrec.address_seq_no;
end;

p := 
project(
	prop2, 
	transform(
		addr_rec,
		self.prim_range 		:= left.parties(party_type = 'P')[1].prim_range,
		self.prim_name			:= left.parties(party_type = 'P')[1].prim_name,
		self.sec_range			:= left.parties(party_type = 'P')[1].sec_range,
		self.zip 		    		:= left.parties(party_type = 'P')[1].zip,
		self.p_city_name 		:= left.parties(party_type = 'P')[1].p_city_name,
		self.v_city_name 		:= left.parties(party_type = 'P')[1].v_city_name,
		self.st 						:= left.parties(party_type = 'P')[1].st,
		self.fid						:= left.ln_fares_id,
		self.sortby_date		:= left.sortby_date,
		self.address_seq_no	:= -1
	)
);

d := 
dedup(
	sort(p(prim_name <> '' and zip <> ''), prim_name, prim_range, zip, sec_range, -sortby_date, fid),
	prim_name, prim_range, zip, sec_range
);


//***** Join to pick up the seq_no
j := 
join(
	d,
	csa,
	left.prim_range = right.prim_range and
	left.prim_name = right.prim_name and
	ut.NNEQ(left.sec_range,right.sec_range) and
	(left.zip = right.zip or
	 (left.st = right.st and
	  (left.p_city_name = right.city_name or left.v_city_name = right.city_name)
	 )
	),
	transform(
		{addr_rec, boolean isExactSRMatch},
		self.address_seq_no := if(right.address_seq_no > 0, right.address_seq_no, left.address_seq_no),
		self.isExactSRMatch := left.sec_range = right.sec_range,
		self := left
	)
);

jd := dedup(sort(j(address_seq_no > 0), fid, if(isExactSRMatch, 0, 1), address_seq_no), fid);
//cem:  ascending on seq no would prefer a more recent address, which is good.  ascending adds requirement to filter on > 0  


//***** Join back to add the seq_no to the full record
jf := 
join(
	prop2,
	jd,
	left.ln_fares_id = right.fid,
	transform(
		outrec,
		self.address_seq_no := if(right.address_seq_no > 0, right.address_seq_no, -1),
		self := left
	),
	left outer
);

s := sort(jf, -sortby_date, record);

// output(d, named('d'));
// output(csa, named('csa'));
// output(j, named('j'));
// output(jd, named('jd'));
// output(jf, named('jf'));
// output(s, named('s'));
return s;

END;