import doxie,business_header;

export corp_search_supp_records(dataset(layout_corpkey) ckeys) := function

boolean	cur := false 		: stored('CurrentOnly');
string32 	chn := '' 		: stored('CharterNumber');

/*string14	bd_val := '' 		: stored('BDID');
string9 	fein_val := ''   	: stored('FEIN');
string25	city_val := ''		: stored('City');
string2	state_val := ''  	: stored('State');
string5	zip := '' 		: stored('ZipCode');

string25	city  := stringlib.stringtouppercase(city_val);
string2	state := stringlib.stringtouppercase(state_val);

unsigned6	bd := (integer)bd_val;
*/

business_header.doxie_MAC_Field_Declare();

os := ckeys; 

dksk := corp.key_corp_supp_corpkey;

dksk get_fullrecs(os L, dksk R) := transform
	self := R;
end;

os2 := join(os,dksk, left.corp_key = right.corp_key and
				 (cur = false or right.record_type = 'C'),
				 get_fullrecs(LEFT,RIGHT));

return os2(chn = '' 		or chn = corp_sos_charter_nbr,
		 bdid_value = 0 	or bdid = bdid_value,
		 fein_value = 0	or fein_val = supp_cont_fein,
		 city_value = ''	or corp_addr1_v_city_name = city_value or
						   corp_addr1_p_city_name = city_value,
		 state_value = ''	or corp_addr1_state = state_value or corp_state_origin = state_value,
		 zip_value = [] 	or (integer)corp_addr1_zip5 in zip_value);
end;