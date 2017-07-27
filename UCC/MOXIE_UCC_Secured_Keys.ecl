import UCC, Lib_KeyLib, lib_stringlib;
#workunit('name', 'CREATE UCC Secured Master Keys ' + ucc.UCC_Build_Date);

h := ucc.File_UCC_Secured_Master_Keybuild;

MyFields := record
h.bdid;            // Seisint Business Identifier
h.ssn;
string28  street_name := h.prim_name;
h.prim_name;
h.prim_range;
string13 city := h.p_city_name;
string5 z5 := h.zip5;
string5 zip := h.zip5;
STRING50  debtor_orig_st := h.fk_debtor_orig_st;
STRING8   filing_date := h.fk_filing_date;
STRING4   filing_type := h.fk_filing_type;
STRING18  document_num := h.fk_document_num;
STRING8   orig_filing_date := h.fk_orig_filing_date;
string40 lfmname := TRIM(h.lname,right) + ' ' + IF(TRIM(h.fname,right) = '', ' ',TRIM(h.fname,right) + ' ') + 
					  TRIM(h.mname,right);	
STRING200 asisname := lib_stringlib.stringlib.stringtouppercase(h.orig_name);
STRING2   st := h.state;
string6 dph_lname := metaphonelib.DMetaPhone1(h.lname);
STRING11  name_first := h.fname[1..11];
STRING11  name_middle := h.mname[1..11];
STRING20  name_last := h.lname;
string80 cn_all := keyLib.GongDacName(h.orig_name);
string40 pcn_all := keyLib.GongDaphcName(h.orig_name);
h.suffix;
h.predir;
h.postdir;
h.orig_filing_num;
string2 file_state := lib_stringlib.stringlib.stringtouppercase(h.file_state);
h.event_flag;
h.lname;
h.__filepos;
end;
  
t := table(h, MyFields);

BUILDINDEX( t, {bdid,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'bdid.key', moxie,overwrite);
BUILDINDEX( t, {ssn,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'ssn.key', moxie,overwrite);
BUILDINDEX( t, {orig_filing_num,file_state,filing_date,filing_type,document_num,orig_filing_date,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'orig_filing_num.file_state.filing_date.filing_type.document_num.orig_filing_date.key', moxie,overwrite);
BUILDINDEX( t, {lfmname,event_flag,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'lfmname.event_flag.key', moxie,overwrite);
BUILDINDEX( t, {st,lfmname,event_flag,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'st.lfmname.event_flag.key', moxie,overwrite);
BUILDINDEX( t, {st,city,lfmname,event_flag,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'st.city.lfmname.event_flag.key', moxie,overwrite);
BUILDINDEX( t, {zip,lfmname,event_flag,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'zip.lfmname.event_flag.key', moxie,overwrite);
BUILDINDEX( t, {dph_lname,name_first,name_middle,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'dph_lname.name_first.name_middle.key', moxie,overwrite);
BUILDINDEX( t, {st,dph_lname,name_first,name_middle,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'st.dph_lname.name_first.name_middle.key', moxie,overwrite);
BUILDINDEX( t, {st,city,dph_lname,name_first,name_middle,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'st.city.dph_lname.name_first.name_middle.key', moxie,overwrite);
BUILDINDEX( t, {zip,dph_lname,name_first,name_middle,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'zip.dph_lname.name_first.name_middle.key', moxie,overwrite);
BUILDINDEX( t, {asisname,event_flag,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'asisname.event_flag.key', moxie,overwrite);
BUILDINDEX( t, {st,asisname,event_flag,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'st.asisname.event_flag.key', moxie,overwrite);
BUILDINDEX( t, {st,city,asisname,event_flag,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'st.city.asisname.event_flag.key', moxie,overwrite);
BUILDINDEX( t, {zip,asisname,event_flag,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'zip.asisname.event_flag.key', moxie,overwrite);
BUILDINDEX( t, {zip,prim_name,suffix,predir,postdir,prim_range,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'zip.prim_name.suffix.predir.postdir.prim_range.key', moxie,overwrite);
BUILDINDEX( t, {z5,prim_name,prim_range,lname,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'z5.prim_name.prim_range.lname.key', moxie,overwrite);
BUILDINDEX( t, {st,city,prim_name,prim_range,predir,postdir,suffix,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'st.city.prim_name.prim_range.predir.postdir.suffix.key', moxie,overwrite);



cn_rec := record
	string10 cn;
    t.st;
	t.city;
	t.zip;
	t.__filepos;
end;

cn_rec Norm_cn(MyFields l, integer C) := transform
	self.cn := choose(C, l.cn_all[1..10], l.cn_all[11..20],l.cn_all[21..30],
						l.cn_all[31..40],l.cn_all[41..50],l.cn_all[51..60],
						l.cn_all[61..70],l.cn_all[71..80]);
	self := l;
end;

cn_records := NORMALIZE(t, 8,Norm_cn(LEFT, COUNTER));

BUILDINDEX( cn_records(cn <> ''), {cn,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'cn.key', moxie,overwrite);
BUILDINDEX( cn_records(st <> ''), {st,cn,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'st.cn.key', moxie,overwrite);
BUILDINDEX( cn_records(st <> ''), {st,city,cn,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'st.city.cn.key', moxie,overwrite);
BUILDINDEX( cn_records(zip <> ''), {zip,cn,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'zip.cn.key', moxie,overwrite);



pcn_rec := record
	t.st;
	t.zip;
	t.city;
	string5 pcn :='';
	t.__filepos;
end;

pcn_rec use_pcn(MyFields l, unsigned1 cnt) := TRANSFORM
	self.pcn := choose(cnt,l.pcn_all[1..5], l.pcn_all[6..10],l.pcn_all[11..15],l.pcn_all[16..20],
						   l.pcn_all[21..25],l.pcn_all[26..30],l.pcn_all[31..35],l.pcn_all[36..40]);
	self := l;
end;

pcn_records := NORMALIZE(t,8,use_pcn(left,counter));

BUILDINDEX( pcn_records(pcn<>''),{pcn,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'pcn.key', moxie, overwrite);
BUILDINDEX( pcn_records(st <> ''),{st,pcn,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'st.pcn.key', moxie, overwrite);
BUILDINDEX( pcn_records(st <> ''),{st,city,pcn,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'st.city.pcn.key', moxie,overwrite);
BUILDINDEX( pcn_records(zip <> ''),{zip,pcn,(big_endian unsigned8 )__filepos},
			ucc.Base_Key_Name_Secured + 'zip.pcn.key', moxie,overwrite);