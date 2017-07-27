import business_header,address;

string9	dns 		:= ''		: stored('DunsNumber');
string14	bd_val 	:= '' 		: stored('BDID');
string120	bname_val := ''	  	: stored('CompanyName');
string20	fn	  	:= '' 	  	: stored('ContactFirstName');
string20	mn		:= '' 		: stored('ContactMiddleName');
string20	lan		:= ''		: stored('ContactLastName');
string25	city_val 	:= ''		: stored('City');
string2	state_val := ''  		: stored('State');
string200	street_addr 	:= '' 	: stored('Addr');
string5	zip 		:= '' 		: stored('ZipCode');
boolean	nicknames := false		: stored('Nicknames');
boolean	phonetics := false		: stored('PhoneticMatches');

string62 name := fn + ' ' + mn + ' ' + lan;
string73 parsedname 	:= if (name = '', '', address.cleanperson73(name));
string20 fname_value 	:= if (parsedname != '', parsedname[6..25] ,'');
string20 mname_value	:= if (parsedname != '', parsedname[26..45],'');
string20 lname_value 	:= if (parsedname != '', parsedname[46..65],'');
string20 pfname_value 	:= if (fname_value = '', '', datalib.preferredfirst(fname_value));

string50	bname 	:= stringlib.stringtouppercase(bname_val);

string182	clean_addr := if (street_addr = '', '', address.cleanaddress182(street_addr,city_val + ' ' + state_val + ' ' + zip));
string30	prim_name  := clean_addr[13..40];
string10	prim_range := clean_addr[1..10];
string2	state 	:= stringlib.stringtouppercase(state_val);
string25	city		:= stringlib.stringtouppercase(city_val);

unsigned6	bd 		:= (integer)bd_val;

drec := layout_dnum;

//---------------from supplied duns number

o1 := dataset([{dns}],drec);

//---------------from bdid search

null1 := dataset([{''}],drec) : stored('null1');

bd1 := if (bname = '', dataset([{0}],{unsigned6 bdid}), business_header.doxie_get_bdids(true));

bd2 := (bd1 + dataset([{bd}],{unsigned6 bdid}))(bdid != 0);

drec get_from_bdid(bd2 L,dnb.Key_DNB_BDID R) := transform
	self := R;
end;

o2 := if (count(bd2) = 0, null1, join(bd2,dnb.Key_DNB_BDID, left.bdid = right.bd,get_from_bdid(LEFT,RIGHT)));

//--------------from contactname and state/zip

search_state := if (state = '' and zip != '',ziplib.ZipToState2(zip),state);

drec get_from_contacts(dnb.Key_DnB_ContactName L) := transform
	self := L;
end;

null2 := dataset([{''}],drec) : stored('null2');

o3 := if (lname_value != '',project(dnb.Key_DnB_ContactName(lname = lname_value,
							pfname = pfname_value or pfname_value = '', search_state = '' or company_st = search_State, zip = '' or company_zip = zip,
							mname_value = '' or mname = mname_value),get_from_contacts(LEFT)),null2);
							
//----------------------------------------

export DNB_Search_Get_DunsNum := dedup(sort(((o1 + o2 + o3)(duns_number != '')),duns_number),duns_number);
