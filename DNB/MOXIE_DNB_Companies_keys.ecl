import dnb,Lib_KeyLib,lib_stringlib;

#workunit ('name', 'Build DNB Company Keys ' + dnb.version);

h := dnb.FILE_DNB_Companies_Out_keybuild;

MyFields := record
    h.bdid;            // Seisint Business Identifier
	h.duns_number;
	h.business_name;
    h.prim_range;
    h.predir;
    h.prim_name;
    h.addr_suffix;
    h.postdir;
    h.sec_range;
    h.p_city_name;
    h.st;
    h.zip;
    h.zip4;
    h.mail_prim_range;
    h.mail_predir;
    h.mail_prim_name;
    h.mail_addr_suffix;
    h.mail_postdir;
    h.mail_sec_range;
    h.mail_p_city_name;
    h.mail_st;
    h.mail_zip;
    h.mail_zip4;
    string10 phone := h.telephone_number;
	string30 trade_style := lib_stringlib.stringlib.stringtouppercase(h.trade_style);
    string30 nameasis_bus := KeyLib.CompNameNoSyn(h.business_name);
    string30 nameasis_trad := KeyLib.CompNameNoSyn(h.trade_style);
	string80 cn_all_bus := keyLib.GongDacName(h.business_name);
	string80 cn_all_trad := keyLib.GongDacName(h.trade_style);
	string40 pcn_all_bus := keyLib.GongDaphcName(h.business_name);
	string40 pcn_all_trad := keyLib.GongDaphcName(h.trade_style);
	h.__filepos;
end;
  
t := table(h, MyFields);

// ------------------
// -- KEY #0
// ------------------
cn_rec := record
	string10 cn;
	t.mail_st;
	t.st;
	t.p_city_name;
	t.mail_p_city_name;
	t.zip;
	t.mail_zip;
	t.__filepos;
end;

cn_rec Norm_cn(MyFields l, integer C) := transform
	self.cn := choose(C, l.cn_all_bus[1..10], l.cn_all_bus[11..20],l.cn_all_bus[21..30],
						l.cn_all_bus[31..40],l.cn_all_bus[41..50],l.cn_all_bus[51..60],
						l.cn_all_bus[61..70],l.cn_all_bus[71..80],
						l.cn_all_trad[1..10], l.cn_all_trad[11..20],l.cn_all_trad[21..30],
						l.cn_all_trad[31..40],l.cn_all_trad[41..50],l.cn_all_trad[51..60],
						l.cn_all_trad[61..70],l.cn_all_trad[71..80]);
	self := l;
end;

cn_records := NORMALIZE(t, 16,Norm_cn(LEFT, COUNTER));

BUILDINDEX( cn_records(cn <> ''), {cn,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Company + 'cn.key', moxie,overwrite);

// ------------------
// -- KEY #1
// ------------------

st_cn_rec := record
	string2 st;
	cn_records.cn;
	cn_records.__filepos;
end;


st_cn_rec Norm_st_cn(cn_rec l, integer C) := transform
	self.st := CHOOSE(C, l.mail_st, l.st);
	self := l;
end;
st_cn_records := NORMALIZE(cn_records, 2, Norm_st_cn(LEFT, COUNTER));
BUILDINDEX( st_cn_records(cn <> ''), {st,cn,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Company + 'st.cn.key', moxie,overwrite);

// ------------------
// -- KEY #2
// ------------------
st_city_cn_rec := record
	string2 st;
	string25 city;
	cn_records.cn;
	cn_records.__filepos;
end;

st_city_cn_rec Norm_st_city_cn(cn_rec l, integer C) := transform
	self.st := CHOOSE(C, l.mail_st, l.st);
	self.city := CHOOSE(C,l.mail_p_city_name, l.p_city_name);
	self := l;
end;
st_city_cn_records := NORMALIZE(cn_records, 2, Norm_st_city_cn(LEFT, COUNTER));
BUILDINDEX( st_city_cn_records(cn <> ''), {st,city,cn,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Company + 'st.city.cn.key', moxie,overwrite);

// ------------------
// -- KEY #2
// ------------------
z5_cn_rec := record
	string5 z5;
	cn_records.cn;
	cn_records.__filepos;
end;

z5_cn_rec Norm_z5_cn(cn_rec l, integer C) := transform
	self.z5 := CHOOSE(C, l.mail_zip, l.zip);
	self := l;
end;
z5_cn_records := NORMALIZE(cn_records, 2, Norm_z5_cn(LEFT, COUNTER));
BUILDINDEX( z5_cn_records(cn <> ''), {z5,cn,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Company + 'z5.cn.key', moxie,overwrite);


// ------------------
// -- KEY #3
// ------------------
pcn_rec := record
	string5 pcn;
	t.mail_st;
	t.st;
	t.p_city_name;
	t.mail_p_city_name;
	t.zip;
	t.mail_zip;
	t.__filepos;
end;

pcn_rec Norm_pcn(MyFields l, integer C) := transform
	self.pcn := choose(C, l.pcn_all_bus[1..5], l.pcn_all_bus[6..10],l.pcn_all_bus[11..15],l.pcn_all_bus[16..20],
		l.pcn_all_bus[21..25],l.pcn_all_bus[26..30],l.pcn_all_bus[31..35],l.pcn_all_bus[36..40],
		l.pcn_all_trad[1..5], l.pcn_all_trad[6..10],l.pcn_all_trad[11..15],l.pcn_all_trad[16..20],
		l.pcn_all_trad[21..25],l.pcn_all_trad[26..30],l.pcn_all_trad[31..35],l.pcn_all_trad[36..40]);
	self := l;
						
end;

pcn_records := NORMALIZE(t, 16,Norm_pcn(LEFT, COUNTER));

BUILDINDEX( pcn_records(pcn <> ''), {pcn,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Company + 'pcn.key', moxie,overwrite);

// ------------------
// -- KEY #4
// ------------------
st_pcn_rec := record
	string2 st;
	pcn_records.pcn;
	pcn_records.__filepos;
end;

st_pcn_rec Norm_st_pcn(pcn_rec l, integer C) := transform
	self.st := CHOOSE(C, l.mail_st, l.st);
	self := l;
end;
st_pcn_records := NORMALIZE(pcn_records, 2, Norm_st_pcn(LEFT, COUNTER));
BUILDINDEX( st_pcn_records(pcn <> ''), {st,pcn,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Company + 'st.pcn.key', moxie,overwrite);

// ------------------
// -- KEY #5
// ------------------
st_city_pcn_rec := record
	string2 st;
	string25 city;
	pcn_records.pcn;
	pcn_records.__filepos;
end;

st_city_pcn_rec Norm_st_city_pcn(pcn_rec l, integer C) := transform
	self.st := CHOOSE(C, l.mail_st, l.st);
	self.city := CHOOSE(C,l.mail_p_city_name, l.p_city_name);
	self := l;
end;
st_city_pcn_records := NORMALIZE(pcn_records, 2, Norm_st_city_pcn(LEFT, COUNTER));
BUILDINDEX( st_city_pcn_records(pcn <> ''), {st,city,pcn,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Company + 'st.city.pcn.key', moxie,overwrite);

// ------------------
// -- KEY #6
// ------------------
z5_pcn_rec := record
	string5 z5;
	pcn_records.pcn;
	pcn_records.__filepos;
end;

z5_pcn_rec Norm_z5_pcn(pcn_rec l, integer C) := transform
	self.z5 := CHOOSE(C, l.mail_zip, l.zip);
	self := l;
end;
z5_pcn_records := NORMALIZE(pcn_records, 2, Norm_z5_pcn(LEFT, COUNTER));
BUILDINDEX( z5_pcn_records(pcn <> ''), {z5,pcn,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Company + 'z5.pcn.key', moxie,overwrite);


// ------------------
// -- KEY #7
// ------------------
nameasis_rec := record
	string30 nameasis;
	t.mail_st;
	t.st;
	t.p_city_name;
	t.mail_p_city_name;
	t.zip;
	t.mail_zip;
	t.__filepos;
end;

nameasis_rec Norm_nameasis(MyFields l, integer C) := transform
	self.nameasis := choose(C, l.nameasis_bus, l.nameasis_trad);
	self := l;
end;

nameasis_records := NORMALIZE(t, 2,Norm_nameasis(LEFT, COUNTER));

BUILDINDEX( nameasis_records(nameasis <> ''), {nameasis,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Company + 'nameasis.key', moxie,overwrite);

// ------------------
// -- KEY #8
// ------------------
st_nameasis_rec := record
	string2 st;
	nameasis_records.nameasis;
	nameasis_records.__filepos;
end;

st_nameasis_rec Norm_st_nameasis(nameasis_rec l, integer C) := transform
	self.st := CHOOSE(C, l.mail_st, l.st);
	self := l;
end;
st_nameasis_records := NORMALIZE(nameasis_records, 2, Norm_st_nameasis(LEFT, COUNTER));
BUILDINDEX( st_nameasis_records(nameasis <> ''), {st,nameasis,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Company + 'st.nameasis.key', moxie,overwrite);

// ------------------
// -- KEY #9
// ------------------
st_city_nameasis_rec := record
	string2 st;
	string25 city;
	nameasis_records.nameasis;
	nameasis_records.__filepos;
end;

st_city_nameasis_rec Norm_st_city_nameasis(nameasis_rec l, integer C) := transform
	self.st := CHOOSE(C, l.mail_st, l.st);
	self.city := CHOOSE(C,l.mail_p_city_name, l.p_city_name);
	self := l;
end;
st_city_nameasis_records := NORMALIZE(nameasis_records, 2, Norm_st_city_nameasis(LEFT, COUNTER));
BUILDINDEX( st_city_nameasis_records(nameasis <> ''), {st,city,nameasis,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Company + 'st.city.nameasis.key', moxie,overwrite);

// ------------------
// -- KEY #10
// ------------------
z5_nameasis_rec := record
	string5 z5;
	nameasis_records.nameasis;
	nameasis_records.__filepos;
end;

z5_nameasis_rec Norm_z5_nameasis(nameasis_rec l, integer C) := transform
	self.z5 := CHOOSE(C, l.mail_zip, l.zip);
	self := l;
end;
z5_nameasis_records := NORMALIZE(nameasis_records, 2, Norm_z5_nameasis(LEFT, COUNTER));
BUILDINDEX( z5_nameasis_records(nameasis <> ''), {z5,nameasis,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Company + 'z5.nameasis.key', moxie,overwrite);


// ------------------
// -- KEY #11
// ------------------
z5_address_full_rec := record
string10  prim_range;
string2   predir;
string28  prim_name;
string4   suffix;
string2   postdir;
string8   sec_range;
string5   z5;
t.__filepos;
end;

z5_address_full_rec Norm_z5_address_full(MyFields l, integer C) := transform
	self.prim_range := CHOOSE(C,l.mail_prim_range, l.prim_range);
	self.predir := CHOOSE(C,l.mail_predir, l.predir);
	self.prim_name := CHOOSE(C,l.mail_prim_name, l.prim_name);
	self.suffix := CHOOSE(C,l.mail_addr_suffix, l.addr_suffix);
	self.postdir := CHOOSE(C,l.mail_postdir, l.postdir);
	self.sec_range := CHOOSE(C,l.mail_sec_range, l.sec_range);
	self.z5 := CHOOSE(C, l.mail_zip, l.zip);
	self := l;
end;
z5_address_full_records := NORMALIZE(t, 2, Norm_z5_address_full(LEFT, COUNTER));
BUILDINDEX( z5_address_full_records, {z5,prim_name,suffix,predir,postdir,prim_range,sec_range,
			(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Company + 'z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key', moxie,overwrite);

// ------------------
// -- Key #12
// ------------------
BUILDINDEX( z5_address_full_records, {z5,prim_name,prim_range,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Company + 'z5.prim_name.prim_range.key', moxie,overwrite);

// ------------------
// -- Key #13
// ------------------
simple_rec := record
	t.duns_number;
	t.bdid;
	t.phone;
	t.trade_style;
	t.__filepos;
end;

// No point to build keys if the field is empty
duns_number_records := table(t(t.duns_number <> ''),simple_rec);
bdid_records := table(t(t.bdid <> ''),simple_rec);
phoneno_records := table(t(t.phone <> ''),simple_rec);
trade_style_records := table(t(t.trade_style <> ''),simple_rec);
BUILDINDEX( duns_number_records, {duns_number,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Company + 'duns_number.key', moxie,overwrite);
BUILDINDEX( bdid_records, {bdid,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Company + 'bdid.key', moxie,overwrite);
BUILDINDEX( phoneno_records, {phone,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Company + 'phoneno.key', moxie,overwrite);
BUILDINDEX( trade_style_records, {trade_style,(big_endian unsigned8 )__filepos},
			dnb.Base_Key_Name_Company + 'trade_style.key', moxie,overwrite);