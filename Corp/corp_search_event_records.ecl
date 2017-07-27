import business_header,doxie;

export corp_search_event_records(dataset(layout_corpkey) ckeys) := function

boolean	cur := false 	: stored('CurrentOnly');
string32 	chn := '' 	: stored('CharterNumber');

/*
string14	bd_val := '' 		: stored('BDID');
string2	state_val := ''  	: stored('State');

string2	state := stringlib.stringtouppercase(state_val);
unsigned6	bd := (integer)bd_val;
*/

business_header.doxie_MAC_Field_Declare();

oe := ckeys; //corp.corp_search_get_CorpKeys;

dkek := corp.key_corp_event_corpkey;

dkek get_fullrecs(oe L, dkek R) := transform
	self := R;
end;

oe2 := join(oe,dkek, left.corp_key = right.corp_key and
				 (cur = false or right.record_type = 'C'),
				  get_fullrecs(LEFT,RIGHT));


return oe2(chn = '' 		or corp_sos_charter_nbr = chn,
		 bdid_value = 0	or bdid = bdid_value,
		 state_value = ''		or corp_state_origin = state_value);
end;
