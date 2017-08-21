outrec := ngadl.Layout_Header;

export outrec fn_deValueOverusedApt(dataset(outrec) h) := 
FUNCTION
	
	/*
	THIS ONLY AFFECTS ADDRS WITH A SEC_RANGE, AS THOSE ARE CURRENTLY BEING OVERVALUED BY THE ADL2 PEICE
	*/

	//****** DEFINE OVERUSED
	
	maxAptCount := 10000;


	//****** COUNT THE USES OF EACH APT
	
	r := record
		h.prim_range;
		h.prim_name;
		h.zip;
		h.sec_range;
		cnt := count(group);
	end;
	
	hd := distribute(h(zip <> '', sec_range <> ''), hash(prim_range, prim_name, zip, sec_range));
	
	t := 
		table(
			sort(
				hd,
				prim_range, prim_name, zip, sec_range, 
				local
			),
			r,
			prim_range, prim_name, zip, sec_range, 
			local
		);


	//****** BLANK THE SEC_RANGE OF THE OVERUSED ONES
	
	overused := t(cnt > maxAptCount);
	
	devalued := 
		join(
			h,
			overused, 
			left.prim_range = right.prim_range and
			left.prim_name = right.prim_name and
			left.zip = right.zip and
			left.sec_range = right.sec_range,
			transform(
				outrec,
				self.sec_range := if(right.zip <> '', '',left.sec_range),	//this is the punishment
				self := left
			),
			left outer,
			lookup
		);
	
	// output(count(overused), named('overused'));
	return devalued;

END;