import ut,business_header,doxie,address;
 
export corp_search_cont_records(
	dataset(layout_corpkey) ckeys,
		unsigned6 bdid_value = 0,
	unsigned6 fein_value = 0,
	string25	city_value = '',
	string2	state_value = '',
	set of integer zip_value = [],
	boolean	cur = false,
	string32 	chn = '',
	string20	cfname_val  = '',
	string20	cmname_val = '',
	string20	clname_val = ''
	) := 
function



string62	cname_val := cfname_val + ' ' + cmname_val + ' ' + clname_val;

string73	name_cleaned := if (cname_val = '', '', address.cleanperson73(cname_val));
string20	cfname := if (cname_val = '', '', name_cleaned[6..25]);
string20	cmname := if (cname_val = '', '', name_cleaned[26..45]);
string20  clname := if (cname_val = '', '', name_cleaned[46..65]);

oc := ckeys; 

dkck := corp.key_corp_cont_corpkey;

dkck get_fullrecs(oc L, dkck R) := transform
	self := R;
end;

oc2 := join(oc,dkck, left.corp_key = right.corp_key and
				 (cur = false or right.record_type = 'C'),
				 get_fullrecs(LEFT,RIGHT));


boolean midmatch(string m1, string m2) := map (m1 = m2 => true,
									  length(trim(m1)) = 1 and m1[1] = m2[1] => true,
									  length(trim(m2)) = 1 and m1[1] = m2[1] => true,
									  false);


return oc2(bdid_value = 0  	or bdid = bdid_value,
		 chn = ''		  	or chn = corp_orig_sos_charter_nbr,
		 fein_value = 0  	or (unsigned6)cont_fein = fein_value,
		 city_value = '' 	or city_value = corp_addr1_p_city_name or
							city_value = corp_addr1_v_city_name or
							city_value = cont_v_city_name or
							city_value = cont_p_city_name,
		 state_value = '' 	or state_value = corp_addr1_state or
							state_value = cont_state or
							state_value = corp_state_origin,
		 zip_value = []	or (integer)corp_addr1_zip5 in zip_value or
							(integer)cont_zip5 in zip_value,
		 clname = ''		or 
			cont_lname != '' and ut.NameMatch(cfname,cmname,clname,cont_fname,cont_mname,cont_lname) < 3 and (cmname = '' or midmatch(cmname,cont_mname)));
		 
end;
