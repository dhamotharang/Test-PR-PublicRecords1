import ut,address;

export dnb_contacts_records(dataset(layout_dnum) duns) := function

typeof(dnb.Key_DNB_Contacts_DunsNum) get_contacts(duns L, dnb.key_dnb_contacts_dunsnum R) := transform
	self := R;
end;

conts := join(duns, dnb.key_dnb_contacts_dunsnum, left.duns_number = right.dns,
			get_contacts(LEFT,RIGHT));


string9	dns 		:= ''		: stored('DunsNumber');
string14	bd_val 	:= '' 		: stored('BDID');
string20	fn	  	:= '' 	  	: stored('ContactFirstName');
string20	mn		:= '' 		: stored('ContactMiddleName');
string20	lan		:= ''		: stored('ContactLastName');
string25	city_val 	:= ''		: stored('City');
string2	state_val := ''  		: stored('State');
string5	zip_val 		:= '' 	: stored('ZipCode');
string200	street_addr	:= ''	: stored('Addr');

string62 name			:= fn + ' ' + mn + ' ' + lan;
string73 parsedname 	:= if (name = '', '', address.cleanperson73(name));
string20 fname_value 	:= if (parsedname != '', parsedname[6..25] ,'');
string20 mname_value	:= if (parsedname != '', parsedname[26..45],'');
string20 lname_value 	:= if (parsedname != '', parsedname[46..65],'');
string20 pfname_value 	:= if (fname_value = '', '', datalib.preferredfirst(fname_value));

string182	clean_addr 	:= if (street_addr = '', '', address.cleanaddress182(street_addr,city_val + ' ' + state_val + ' ' + zip_val));
string10	prim_range_val	:= clean_addr[1..10];
string30	prim_name 	:= clean_addr[13..40];
string2	state 		:= stringlib.stringtouppercase(state_val);
string25	city			:= stringlib.stringtouppercase(city_val);

unsigned6	bd 			:= (integer)bd_val;


boolean midmatch(string m1, string m2) := map( m1 = m2 => true,
									length(trim(m1)) = 1 and m1[1] = m2[1] => true,
									length(trim(m2)) = 1 and m1[1] = m2[1] => true,
									false);

return conts(dns = '' or dns = duns_number,
		   bd = 0 or bdid = bd,
		   lname_value = '' or ut.NameMatch(fname_value, mname_value, lname_value,fname,mname,lname) < 3 and midmatch(mname_value,mname),
		   prim_name = '' or ut.StringSimilar(prim_name,company_prim_name) < 4,
		   prim_range_val = '' or prim_range_val = company_prim_range,
		   state = '' or state = company_st,
		   zip_val = '' or (integer)zip_val = (integer)company_zip);

end;
