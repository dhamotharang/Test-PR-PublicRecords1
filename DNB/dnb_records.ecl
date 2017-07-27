import ut,address;

export dnb_records(dataset(layout_dnum) dunsnums) := function

typeof(dnb.key_DNB_DunsNum) get_base_recs(dunsnums L, dnb.key_DNB_DunsNum R) := transform
	self := R;
end;


base := join(dunsnums,dnb.key_DNB_DunsNum, left.duns_number = right.duns,
			get_base_recs(LEFT,RIGHT));
			

string9	dns 		:= ''		: stored('DunsNumber');
string14	bd_val 	:= '' 		: stored('BDID');
string25	city_val 	:= ''		: stored('City');
string2	state_val := ''  		: stored('State');
string200	street_addr	:= '' 	: stored('Addr');
string5	zip_val 		:= '' 	: stored('ZipCode');

string182	clean_addr	:= if (street_addr = '', '', address.cleanaddress182(street_addr,city_val + ' ' + state_val + ' ' + zip_val));
string10	prim_range_val	:= clean_addr[1..10];
string28	prim_name_val	:= clean_addr[13..40];


return base(dns = '' or duns_number = dns,
		  (integer)bd_val = 0 or bdid = (integer)bd_val,
		  city_val = '' or stringlib.stringtouppercase(city_val) = p_city_name or stringlib.stringtouppercase(city_val) = v_city_name,
		  state_val = '' or stringlib.stringtouppercase(state_val) = st,
		  prim_range_val = '' or prim_range_val = prim_range,
		  prim_name_val = '' or ut.stringsimilar(stringlib.stringtouppercase(prim_name_val),prim_name) < 4,
		  zip_val = '' or (integer)zip_val = (integer)zip);
end;
