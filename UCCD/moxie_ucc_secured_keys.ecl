import uccd,lib_keylib,lib_stringlib;


h := uccd.File_WithExpsecured2_Base_Dev;


MyFields := record
h.ucc_vendor;
h.ucc_key;
h.event_key;
/*h.bdid;            
h.did;
h.ssn;
string60 company1 := KeyLib.CompName(h.orig_name);
string28  street_name := h.prim_name;
h.prim_name;
h.prim_range;
h.sec_range;
string13 city := h.p_city_name;
string5 z5 := h.zip;
string5 zip := h.zip;
STRING50  secured_orig_st := h.st;
//STRING8   filing_date := h.fk_filing_date;
//STRING4   filing_type := h.fk_filing_type;
//STRING18  document_num := h.fk_document_num;
//STRING8   orig_filing_date := h.fk_orig_filing_date;
string40 lfmname := TRIM(h.lname,right) + ' ' + IF(TRIM(h.fname,right) = '', ' ',TRIM(h.fname,right) + ' ') + 
					  TRIM(h.mname,right);	
STRING200 asisname := lib_stringlib.stringlib.stringtouppercase(h.orig_name);
STRING2   st := h.st;
string6 dph_lname := metaphonelib.DMetaPhone1(h.lname);
STRING11  name_first := h.fname;
STRING11  name_middle := h.mname;
STRING20  name_last := h.lname;
string80 cn_all := keyLib.GongDacName(h.orig_name);
string40 pcn_all := keyLib.GongDaphcName(h.orig_name);
h.addr_suffix;
h.predir;
h.postdir;
h.orig_filing_num;
string2 file_state := lib_stringlib.stringlib.stringtouppercase(h.file_state);
//h.event_flag;
h.lname;*/
h.__filepos;
end;
  
t := table(h, MyFields);
//output(t);

//THE KEYS NOT NEEDED FOR MOXIE SERVED FROM ROXIE

base_key_Name := '~thor_data400::key::moxie_ucc_secured2.';

k1 := BUILDINDEX( t, {ucc_key,event_key,(big_endian unsigned8 )__filepos},
			base_key_Name + 'ucc_key.event_key_'+ uccd.version_development, moxie);

/*BUILDINDEX( t, {bdid,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.bdid.key', moxie);
BUILDINDEX( t, {did,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.did.key', moxie);
BUILDINDEX( t, {ssn,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.ssn.key', moxie);
BUILDINDEX( t, {zip,street_name,addr_suffix,predir,postdir,prim_range,company1,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.zip.street_name.suffix.predir.postdir.prim_range.company.key', moxie);
BUILDINDEX( t, {zip,street_name,addr_suffix,predir,postdir,prim_range,lfmname,sec_range,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.zip.street_name.suffix.predir.postdir.prim_range.lfmname.sec_range.key', moxie);
BUILDINDEX( t, {orig_filing_num,file_state,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.orig_filing_num.file_state.key', moxie);
BUILDINDEX( t, {lfmname,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.lfmname.key', moxie);
BUILDINDEX( t, {st,lfmname,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.st.lfmname.key', moxie);
BUILDINDEX( t, {st,city,lfmname,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.st.city.lfmname.key', moxie);
BUILDINDEX( t, {zip,lfmname,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.zip.lfmname.key', moxie);
BUILDINDEX( t, {dph_lname,name_first,name_middle,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.dph_lname.name_first.name_middle.key', moxie);
BUILDINDEX( t, {st,dph_lname,name_first,name_middle,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.st.dph_lname.name_first.name_middle.key', moxie);
BUILDINDEX( t, {st,city,dph_lname,name_first,name_middle,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.st.city.dph_lname.name_first.name_middle.key', moxie);
BUILDINDEX( t, {zip,dph_lname,name_first,name_middle,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.zip.dph_lname.name_first.name_middle.key', moxie);
BUILDINDEX( t, {asisname,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.asisname.key', moxie);
BUILDINDEX( t, {st,asisname,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.st.asisname.key', moxie);
BUILDINDEX( t, {st,city,asisname,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.st.city.asisname.key', moxie);
BUILDINDEX( t, {zip,asisname,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.zip.asisname.key', moxie);
BUILDINDEX( t, {zip,prim_name,addr_suffix,predir,postdir,prim_range,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.zip.prim_name.suffix.predir.postdir.prim_range.key', moxie);
BUILDINDEX( t, {z5,prim_name,prim_range,lname,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.z5.prim_name.prim_range.lname.key', moxie);
BUILDINDEX( t, {st,city,prim_name,prim_range,predir,postdir,addr_suffix,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.st.city.prim_name.prim_range.predir.postdir.suffix.key', moxie);

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
			'key.moxie_ucc_secured2.cn.key', moxie);
BUILDINDEX( cn_records(st <> ''), {st,cn,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.st.cn.key', moxie);
BUILDINDEX( cn_records(st <> ''), {st,city,cn,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.st.city.cn.key', moxie);
BUILDINDEX( cn_records(zip <> ''), {zip,cn,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.zip.cn.key', moxie);



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
			'key.moxie_ucc_secured2.pcn.key', moxie, overwrite);
BUILDINDEX( pcn_records(st <> ''),{st,pcn,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.st.pcn.key', moxie, overwrite);
BUILDINDEX( pcn_records(st <> ''),{st,city,pcn,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.st.city.pcn.key', moxie);
BUILDINDEX( pcn_records(zip <> ''),{zip,pcn,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_secured2.zip.pcn.key', moxie);
*/
			

unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(uccd.Layout_withEXpPartyExpanded) + max(h, __filepos): global;
headersize := if (sizeof(uccd.Layout_withEXpPartyExpanded)>215, sizeof(uccd.Layout_withEXpPartyExpanded), error('too bad')) : global;

dfile := INDEX(h,{f:= moxietransform(__filepos, rawsize, headersize)},{h},base_key_Name + 'fpos.data_'+ uccd.version_development);
kFPos				:= BUILDINDEX(dfile,moxie);

export moxie_ucc_secured_Keys
 :=
  parallel
	(
	 k1
	,kFPos
	)
  ;

			