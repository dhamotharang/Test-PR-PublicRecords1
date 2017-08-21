import doxie, header, ut;

ssn_match() := macro
	if(u1.ssn = u2.ssn, 'SSN_MATCH', 'ssn_match')
endmacro;
fname_match() := macro
	if(u1.fname = u2.fname, 'FNAME_MATCH', 'fname_match')
endmacro;
lname_match() := macro
	if(u1.lname = u2.lname, 'LNAME_MATCH', 'lname_match')
endmacro;
near_dob1() := macro
	if(header.sig_near_dob(u1.dob,u2.dob), 'NEAR_DOB', 'near_dob')
endmacro;
sig_left_fname() := macro
	if(length(trim(u1.fname)) >= 3, 'SIG_LEFT_FNAME', 'sig_left_fname')
endmacro;
gens_ok1() := macro
	if(header.gens_ok(u1.name_suffix,u1.dob,u2.name_suffix,u2.dob), 'GENS_OK', 'gens_ok')
endmacro;
name_match() := macro
	(string)(ut.NameMatch(u1.fname,u1.mname,u1.lname,u2.fname,u2.mname,u2.lname))
endmacro;
date_value1() := macro
	(string)(header.date_value(u1.dob, u2.dob))
endmacro;
fullname_match() := macro
	if(u1.fname=u2.fname and u1.mname=u2.mname and u1.lname=u2.lname, 'FULLNAME_MATCH', 'fullname_match')
endmacro;
addr_match() := macro
	if(u1.prim_range=u2.prim_range and u1.prim_name=u2.prim_name and u1.st = u2.st and ( u1.zip<>'' and u1.zip=u2.zip or u1.city_name<>'' and u1.city_name=u2.city_name ) and
	ut.NNEQ(u1.sec_range,u2.sec_range), 'ADDR_MATCH', 'addr_match')
endmacro;
ssn_value1() := macro
	(string)(header.ssn_value(u1.ssn,u2.ssn))
endmacro;
suffix_value1() := macro
	(string)(header.suffix_value(u1.name_suffix,u2.name_suffix))
endmacro;
vendor_id_match() := macro
	if(u1.vendor_id=u2.vendor_id, 'VENDOR_ID_MATCH', 'vendor_id_match')
endmacro;
ssn_nneq() := macro
	if(ut.NNEQ(u1.ssn,u2.ssn), 'SSN_NNEQ', 'ssn_nneq')
endmacro;
mname_lead_match() := macro
	if(ut.lead_contains(u1.mname,u2.mname), 'MNAME_LEAD_MATCH', 'mname_lead_match')
endmacro;
suffix_nneq() := macro
	if(ut.NNEQ(u1.name_suffix,u2.name_suffix), 'SUFFIX_NNEQ', 'suffix_nneq')
endmacro;
suffix_match_not_UNK() := macro
	if(u1.name_suffix=u2.name_suffix and ~ut.is_unk(u1.name_suffix) ,'SUFFIX_MATCH_NOT_UNK', 'suffix_match_not_unk')
endmacro;
mob_match() := macro
	if(ut.mob(u1.dob)=ut.mob(u2.dob), 'MOB_MATCH', 'mob_match')
endmacro;
ssn_stringsimilar() := macro
	(string)(ut.StringSimilar(u1.ssn,u2.ssn))
endmacro;

dlhp := record
	Doxie.Key_Header;
	string msa := '';
end;

export getDIDRuleDesc(dlhp u1,dlhp u2, rule1) := 
case(rule1,
1 => ssn_match() + ' and (' + fname_match() + ' and ' + near_dob1() + 
	' and ' + sig_left_fname() + ' or ' + gens_ok1() + 
	' and name_match(' + name_match() + ') - date_value(' + date_value1() + ') <= 0)',
2 => fullname_match() + ' and ' + addr_match() + ' and ' + gens_ok1() + 
	' and ssn_value( ' + ssn_value1() + ') >= 0 and date_value(' + date_value1() + 
	') + suffix_value( ' + suffix_value1() + ') + ssn_value(' + ssn_value1() + ') > 0',
3 => vendor_id_match() + ' and ' + ssn_nneq() + ' and ' + gens_ok1() + 
	' and (ssn_value(' + ssn_value1() + ') + date_value(' + date_value1() + 
	') >= 5 or ssn_value(' + ssn_value1() + ') + date_value(' + date_value1() + 
	') - name_match(' + name_match() + ') >= 0)',
4 => fname_match() + ' and ' + lname_match() + ' and ' + addr_match() + ' and ' + near_dob1() + 
	' and ' + mname_lead_match() + ' and ' + suffix_nneq(),
5 => ssn_match() + ' and ' + addr_match() + ' and ' + suffix_match_not_UNK() + 
	' and name_match(' + name_match() + ') - date_value(' + date_value1() + ') <= 2',
8 => fullname_match() + ' and ' + mob_match() + ' and ' + suffix_nneq() + 
	' and ssn_stringsimilar(' + ssn_stringsimilar() + ') <= 1',
'todo');