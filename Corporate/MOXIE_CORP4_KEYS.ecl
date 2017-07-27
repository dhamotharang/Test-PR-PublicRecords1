import Corporate,Lib_KeyLib,lib_stringlib;
#workunit ('name', 'Build Corporate Company Keys ' + corporate.Corp4_Build_Date);

h := Corporate.File_Corp4_Keybuild;

MyFields := record
h.bdid;            // Seisint Business Identifier
string2   st_orig 			:= lib_stringlib.stringlib.stringtouppercase(h.state_origin);
string2   orig_state		:= lib_stringlib.stringlib.stringtouppercase(h.orig_state);
string2   state_origin 		:= lib_stringlib.stringlib.stringtouppercase(h.state_origin);
string32  fein 				:= h.fed_tax_id_9;
string32  sos_charter_nbr 	:= TRIM(h.sos_ter_nbr,left);

string5   z5_1 				:= h.zip5;
string5   z5_2 				:= h.prior_zip5;
string28  prim_name1 		:= h.prim_name;
string28  prim_name2 		:= h.prior_prim_name;
string10  prim_range1 		:= h.prim_range;
string10  prim_range2 		:= h.prior_prim_range;
string28  street_name1 		:= h.prim_name;
string28  street_name2 		:= h.prior_prim_name;
string2   st_1 				:= h.state;
string2   st_2 				:= h.prior_st;
string25  city1 			:= h.p_city_name;
string25  city2 			:= h.prior_p_city_name;
string2   pre_dir1 			:= h.predir;
string2   pre_dir2 			:= h.prior_predir;
string2   post_dir1 		:= h.postdir;
string2   post_dir2 		:= h.prior_postdir;
string4   suffix1 			:= h.addr_suffix;
string4   suffix2 			:= h.prior_addr_suffix;

string50  corpname1 		:= lib_stringlib.stringlib.stringtouppercase(h.abbrev_legal_name[1..50]);
string50  corpname2 		:= lib_stringlib.stringlib.stringtouppercase(h.prior_name[1..50]);
string60  company1 			:= KeyLib.CompName(h.abbrev_legal_name);
string60  company2 			:= KeyLib.CompName(h.prior_name);
string80  cn_all1 			:= keyLib.GongDacName(h.abbrev_legal_name);
string80  cn_all2 			:= keyLib.GongDacName(h.prior_name);
string30  nameasis1 		:= KeyLib.CompNameNoSyn(h.abbrev_legal_name);
string30  nameasis2 		:= KeyLib.CompNameNoSyn(h.prior_name);
h.__filepos;
end;
  
t := table(h, MyFields);

// ----------------------------------------
// -- BUILD STRAIGHTFORWARD KEYS
// ----------------------------------------
BUILDINDEX( t, {bdid,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Corporate + 'bdid.key', moxie,overwrite);
BUILDINDEX( t, {fein,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Corporate + 'fein.key', moxie,overwrite);
BUILDINDEX( t, {st_orig,sos_charter_nbr,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Corporate + 'st_orig.sos_charter_nbr.key', moxie,overwrite);

// ----------------------------------------
// -- BUILD ADDRESS ONLY KEYS
// ----------------------------------------
address_only_rec := record
string5   z5;
string28  prim_name;
string10  prim_range;
string2   st;
string25  city;
string2   pre_dir;
string2   post_dir;
string4   suffix;
string28  street_name;
t.__filepos;
end;

address_only_rec Norm_address_only(MyFields l, integer C) := transform
	self.z5 			:= choose(C, l.z5_1, l.z5_2);
	self.prim_name 		:= choose(C, l.prim_name1, l.prim_name2);
	self.street_name 	:= choose(C, l.street_name1, l.street_name2);
	self.prim_range 	:= choose(C, l.prim_range1, l.prim_range2);
	self.st 			:= choose(C, l.st_1, l.st_2);
	self.city 			:= choose(C, l.city1, l.city2);
	self.pre_dir 		:= choose(C, l.pre_dir1, l.pre_dir2);
	self.post_dir 		:= choose(C, l.post_dir1, l.post_dir2);
	self.suffix 		:= choose(C, l.suffix1, l.suffix2);
	self 				:= l;
end;
address_only_records := NORMALIZE(t, 2,Norm_address_only(LEFT, COUNTER));

BUILDINDEX( address_only_records(z5 <> ''), {z5,prim_name,prim_range,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Corporate + 'z5.prim_name.prim_range.key', moxie,overwrite);
BUILDINDEX( address_only_records(z5 <> ''), {z5,street_name,prim_range,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Corporate + 'zip.street_name.prim_range.key', moxie,overwrite);
BUILDINDEX( address_only_records(st <> ''), {st,city,prim_name,prim_range,pre_dir,post_dir,suffix,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Corporate + 'st.city.prim_name.prim_range.pre_dir.post_dir.suffix.key', moxie,overwrite);



// ----------------------------------------
// -- BUILD COMPANY NAME ONLY KEYS
// ----------------------------------------
company_rec := record
t.z5_1;
t.z5_2;
t.prim_range1;
t.prim_range2;
t.st_1;
t.st_2;
t.city1;
t.city2;
t.pre_dir1;
t.pre_dir2;
t.post_dir1;
t.post_dir2;
t.suffix1;
t.suffix2;
t.street_name1;
t.street_name2;
t.orig_state;
t.state_origin;
string50  corpname;
string60  company_both;
string30  nameasis;
t.__filepos;
end;

company_rec Norm_company(MyFields l, integer C) := transform
	self.corpname 		:= choose(C, l.corpname1, l.corpname2);
	self.company_both 	:= choose(C, l.company1, l.company2);
	self.nameasis 		:= choose(C, l.nameasis1, l.nameasis2);
	self := l;
end;
company_records := NORMALIZE(t, 2,Norm_company(LEFT, COUNTER));

BUILDINDEX( company_records(corpname <> ''), {corpname,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Corporate + 'corpname.key', moxie,overwrite);
BUILDINDEX( company_records(nameasis <> ''), {nameasis,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Corporate + 'nameasis.key', moxie,overwrite);


// ----------------------------------------
// -- BUILD COMPANY ADDRESS KEYS
// ----------------------------------------
company_address_rec := record
string5   z5;
string10  prim_range;
string2   st;
string25  city;
string2   pre_dir;
string2   post_dir;
string4   suffix;
string28  street_name;
string2   st_only;
company_records.corpname;
company_records.company_both;
company_records.nameasis;
company_records.__filepos;
end;

company_address_rec Norm_company_address(company_rec l, integer C) := transform
	self.z5 			:= choose(C, l.z5_1, l.z5_2);
	self.prim_range 	:= choose(C, l.prim_range1, l.prim_range2);
	self.st 			:= choose(C, l.st_1, l.st_2);
	self.city 			:= choose(C, l.city1, l.city2);
	self.pre_dir 		:= choose(C, l.pre_dir1, l.pre_dir2);
	self.post_dir 		:= choose(C, l.post_dir1, l.post_dir2);
	self.suffix 		:= choose(C, l.suffix1, l.suffix2);
	self.street_name 	:= choose(C, l.street_name1, l.street_name2);
	self.st_only 		:= choose(C, l.orig_state, l.state_origin);
	self 				:= l;
end;
company_address_records := NORMALIZE(company_records, 2,Norm_company_address(LEFT, COUNTER));

BUILDINDEX( company_address_records(st_only <> ''), {st_only,corpname,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Corporate + 'st.corpname.key', moxie,overwrite);
BUILDINDEX( company_address_records(st <> ''), {st,city,corpname,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Corporate + 'st.city.corpname.key', moxie,overwrite);
BUILDINDEX( company_address_records(st_only <> ''), {st_only,nameasis,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Corporate + 'st.nameasis.key', moxie,overwrite);
BUILDINDEX( company_address_records(st <> ''), {st,city,nameasis,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Corporate + 'st.city.nameasis.key', moxie,overwrite);
BUILDINDEX( company_address_records(z5 <> ''), {z5,street_name,suffix,pre_dir,post_dir,prim_range,company_both,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Corporate + 'zip.street_name.suffix.predir.postdir.prim_range.company.key', moxie,overwrite);




// ----------------------------------------
// -- BUILD CN ONLY KEY
// ----------------------------------------
cn_rec := record
	string10 cn;
t.orig_state;
t.state_origin;
t.st_1;
t.st_2;
t.city1;
t.city2;
	t.__filepos;
end;

cn_rec Norm_cn(MyFields l, integer C) := transform
	self.cn := choose(C, l.cn_all1[1..10], l.cn_all1[11..20],l.cn_all1[21..30],
						l.cn_all1[31..40],l.cn_all1[41..50],l.cn_all1[51..60],
						l.cn_all1[61..70],l.cn_all1[71..80],
						l.cn_all2[1..10], l.cn_all2[11..20],l.cn_all2[21..30],
						l.cn_all2[31..40],l.cn_all2[41..50],l.cn_all2[51..60],
						l.cn_all2[61..70],l.cn_all2[71..80]);
	self := l;
end;

cn_records := NORMALIZE(t, 16,Norm_cn(LEFT, COUNTER));

BUILDINDEX( cn_records(cn <> ''), {cn,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Corporate + 'cn.key', moxie,overwrite);


// ----------------------------------------
// -- BUILD CN ADDRESS KEYS
// ----------------------------------------
cn_address_rec := record
cn_records.cn;
string2 st_only;
string2 st;
string25 city;
cn_records.__filepos;
end;

cn_address_rec Norm_cn_address(cn_rec l, integer C) := transform
	self.st 		:= choose(C, l.st_1, l.st_2);
	self.city 		:= choose(C, l.city1, l.city2);
	self.st_only 	:= choose(C, l.orig_state, l.state_origin);
	self := l;
end;

cn_address_records := NORMALIZE(cn_records, 2,Norm_cn_address(LEFT, COUNTER));

BUILDINDEX( cn_address_records(st_only <> ''), {st_only,cn,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Corporate + 'st.cn.key', moxie,overwrite);
BUILDINDEX( cn_address_records(st <> ''), {st,city,cn,(big_endian unsigned8 )__filepos},
			corporate.Base_Key_Name_Corporate + 'st.city.cn.key', moxie,overwrite);