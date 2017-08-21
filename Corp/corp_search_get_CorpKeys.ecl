import business_header,doxie,NID,Address;
 
string30 	ck := ''  		: stored('CorpKey');
string32 	chn := '' 		: stored('CharterNumber');
string120	bname_val := ''  	: stored('CompanyName');
string20	fn  	:= '' 	  	: stored('ContactFirstName');
string20  mn   := ''		: stored('ContactMiddleName');
string20  lan	:= ''		: stored('ContactLastName');

/*
string14	bd_val  := ''		: stored('BDID');
unsigned6	did_value := 0		: stored('DID');
string9 	fein_val := ''   	: stored('FEIN');
string25	city_val := ''		: stored('City');
string2	state_val := ''  	: stored('State');
string200	street_addr := ''	: stored('Addr');
string5	zip := '' 		: stored('ZipCode');
boolean	nicknames := false	: stored('Nicknames');
boolean	phonetics := false	: stored('PhoneticMatches');
*/


ckrec := layout_corpkey;

string62 name := fn + ' ' + mn + ' ' + lan;

string73 parsedname 	:= if (name = '', '', address.cleanperson73(name));
string20 cfname_value 	:= if (parsedname != '', parsedname[6..25] ,'');
string20 cmname_value	:= if (parsedname != '', parsedname[26..45],'');
string20 clname_value 	:= if (parsedname != '', parsedname[46..65],'');
string20 pfname_value 	:= if (cfname_value = '', '', NID.PreferredFirstNew(cfname_value));

string50	bname 	 := stringlib.stringtouppercase(bname_val);

/*
string182	clean_addr := if (street_addr = '', '', address.cleanaddress182(street_addr,city_val + ' ' + state_val + ' ' + zip));
string10	prim_range := clean_addr[1..10];
string28	prim_name	 := clean_addr[13..40];
string2	state 	 := stringlib.stringtouppercase(state_val);
string25	city		 := stringlib.stringtouppercase(city_val);

unsigned6	bd := (integer)bd_val;
*/

business_header.doxie_MAC_Field_Declare();


//--------------[ from supplied corp key ]

o1 := if(ck != '', dataset([{ck}],ckrec), dataset([],ckrec));

//--------------[ from state and charter ]

ckrec get_from_st_charter(corp.key_corp_base_st_charter L) := transform
	self := L;
end;

null1 := dataset([],ckrec) : stored('null1');

o2 := if(state_value != '' and chn != '', 
		project(corp.key_corp_base_st_charter(corp_state_origin = state_value, corp_sos_charter_nbr = chn),get_from_st_charter(LEFT)),
		null1);


//-------------[ from corp name and addr ]

/*
ckrec get_from_cname_addr(corp.key_corp_base_name_addr L) := transform
	self := l;
end;

o4 := if (bname != '' and zip != '',
		project(corp.key_corp_base_name_addr(corp_legal_name[1..length(trim(bname))] = bname, corp_addr1_zip5 = zip, prim_range = '' or corp_addr1_prim_range = prim_range, prim_name = '' or corp_addr1_prim_name = prim_name), get_from_cname_addr(LEFT)),
		dataset([],ckrec));
*/

null2 := dataset([],{unsigned6 bdid}) : stored('null2');

bds1 := if (bname = '' and FEIN_val = '', null2, business_header.doxie_get_bdids(true));

//-------------[ from contact name and addr]

null3 := dataset([],business_header.Layout_Business_Contact_full) : stored('null3');

c_fetched := IF(bdid_value <> 0,
              Business_Header.Fetch_BC_BDID(bdid_value),
              if (state_value != '' and clname_value != '',Business_Header.Fetch_BC_State_LFName(state_value, cfname_value, clname_value, nicknames, phonetics),
		    null3));

filter := (
		 clname_value='' 
		 or c_fetched.lname=clname_value
           or metaphonelib.DMetaPhone1(c_fetched.lname)=metaphonelib.DMetaPhone1(clname_value)
		) 
		and
		(
		 cfname_value='' 
		 or c_fetched.fname[1..length(trim(cfname_value))]=cfname_value
		 or fname_value[1..length(trim(c_fetched.fname))]=c_fetched.fname
		 or NID.mod_PFirstTools.SUBPFLeqPFR(c_fetched.fname, cfname_value)
		 or NID.mod_PFirstTools.SUBPFLeqR(cfname_value,c_fetched.fname)
		) 
		and
		(
		 cmname_value='' or c_fetched.mname='' 
		 or c_fetched.mname[1..length(trim(cmname_value))]=cmname_value[1..length(trim(cmname_value))] 
		 or cmname_value[1..length(trim(c_fetched.mname))]=c_fetched.mname[1..length(trim(c_fetched.mname))]
		 or NID.mod_PFirstTools.PFLeqPFR(c_fetched.mname,cmname_value)
		) 
		and
		(city_value = '' or c_fetched.city=city_value) 
		and
		(state_value = '' or c_fetched.state=state_value) 
		and
		(zip_value = [] or c_fetched.zip in zip_value) 
		and
		(
		 prange_value = '' 
		 or (integer)c_fetched.prim_range=(integer)prange_value
		);
contact_match := if (count(c_fetched) != 0, c_fetched(filter), c_fetched);

{unsigned6 bdid} into_bdid(contact_match L) := transform
	self := L;
end;

bds := bds1 + project(contact_match,into_bdid(LEFT));

//-------------[ --> from supplied/retrieved bdids ]

ckrec get_from_bdid(bds L, corp.key_Corp_base_bdid R) := transform
	self := R;
end;

null4 := dataset([],ckrec) : stored('null4');

o3 := if (count(bds) != 0,join(bds, corp.key_corp_base_bdid, left.bdid = right.bdid,get_from_bdid(LEFT,RIGHT)),
			null4);
		

//-----------[ Corp Contacts Specific Search ]-------------

ckrec get_corp_cont(corp.key_corp_cont_name_addr L) := transform
	self := L;
end;

null5 := dataset([],ckrec) : stored('null5');

o4 := if (clname_value != '',project(corp.key_corp_cont_name_addr(cont_lname = clname_value,cfname_value = '' or cont_fname = cfname_value or (nicknames and pfname_value = NID.PreferredFirstNew(cont_fname)),state_value = '' or cont_state = state_value),get_corp_cont(LEFT)),
		null5);
		
		
//-------------[ combine them all ]

outf := dedup(sort(o1 + o2 + o3 + o4,corp_key),corp_key);

export corp_search_get_CorpKeys := outf;