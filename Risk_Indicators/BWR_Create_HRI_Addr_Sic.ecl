import business_header, header, ut;

f_sic_addr_out := HRI_Businesses(false);

f_sic_addr_valid := f_sic_addr_out(prim_name<>'');

f_sic_addr_dist := distribute(f_sic_addr_valid,hash(prim_range,predir,prim_name,
	                                               addr_suffix,postdir,unit_desig,
                                                    sec_range,city,state,zip,zip4,sic_code));
	 
f_sic_addr_sort := sort(f_sic_addr_dist,prim_range,predir,prim_name,
	                                   addr_suffix,postdir,unit_desig,
                                        sec_range,city,state,zip,zip4,sic_code,local);

f_sic_addr_sort roll_date(f_sic_addr_sort le, f_sic_addr_sort ri) :=
TRANSFORM
	SELF.dt_first_seen := ut.Min2(le.dt_first_seen,ri.dt_first_seen);
	SELF := le;
END;

f_sic_addr_dedup := rollup(f_sic_addr_sort,roll_date(LEFT,RIGHT),prim_range,predir,prim_name,
	                                     addr_suffix,postdir,unit_desig,
                                          sec_range,city,state,zip,zip4,sic_code,local) : persist('per_f_sic_addr_dedup');

out_addr_rec := record
	string10 prim_range;
	string2   predir;
	string28 prim_name;
	string4  addr_suffix;
	string2   postdir;
	string5  unit_desig;
	string8  sec_range;
	string25 city;
	string2   state;
	string5  zip;
	string4  zip4;
     string4   sic_code;
     string4   addr_type;
	unsigned3 dt_first_seen;
	string120	company_name;
end;

out_addr_rec slim_addr(f_sic_addr_dedup l) := transform
     self.addr_type := '2240';
	self.zip := intformat(l.zip,5,1);
	self.zip4 := intformat(l.zip4,4,1);
	self := l;
end;

f_addr_slim := project(f_sic_addr_dedup, slim_addr(left));

export BWR_Create_HRI_Addr_Sic := f_addr_slim;