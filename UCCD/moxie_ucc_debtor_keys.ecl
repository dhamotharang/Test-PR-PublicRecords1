import uccd,lib_keylib,lib_stringlib;


h := uccd.File_WithExpDebtor2_Base_Dev;

base_key_Name := '~thor_data400::key::moxie.ucc2_debtor.';

MyFields := record
h.ucc_vendor;
h.ucc_key;
h.event_key;
h.bdid;            
h.did;
h.ssn;
string60 company1 := KeyLib.CompName(h.orig_name);
string28  street_name := h.prim_name;
h.prim_name;
h.prim_range;
h.sec_range;
string13 city := h.p_city_name;
varstring  ZipToCityList := ZipLib.ZipToCities(h.zip);
string5 z5 := h.zip;
string5 zip := h.zip;
STRING50  debtor_orig_st := h.st;
string2 	  st2	     := '';	
//STRING8   filing_date := h.fk_filing_date;
//STRING4   filing_type := h.fk_filing_type;
//STRING18  document_num := h.fk_document_num;
//STRING8   orig_filing_date := h.fk_orig_filing_date;
string40 lfmname := TRIM(h.lname,right) + ' ' + IF(TRIM(h.fname,right) = '', ' ',TRIM(h.fname,right) + ' ') + 
					  TRIM(h.mname,right);	

STRING200 nameasis := KeyLib.CompNameNoSyn(h.orig_name);
//STRING200 nameasis := lib_stringlib.stringlib.stringtouppercase(h.orig_name);
STRING2   st := h.st;
//string6 dph_lname := metaphonelib.DMetaPhone1(h.lname);
STRING11  name_first := h.fname;
STRING11  name_middle := h.mname;
STRING20  name_last := h.lname;
string80 cn_all := keyLib.GongDacName(h.orig_name);
//string40 pcn_all := keyLib.GongDaphcName(h.orig_name);
h.addr_suffix;
h.predir;
h.postdir;
h.orig_filing_num;
string2 file_state := lib_stringlib.stringlib.stringtouppercase(h.file_state);
//h.event_flag;
h.lname;
h.__filepos;
end;
  
t := table(h, MyFields);
//output(t);

k1 := BUILDINDEX( t(ucc_key + event_key <> ''), {ucc_key,event_key,(big_endian unsigned8 )__filepos},
			base_key_Name + 'ucc_key.event_key_' + uccd.version_development, moxie);
k2 := BUILDINDEX( t(bdid <> ''), {bdid,(big_endian unsigned8 )__filepos},
			base_key_Name + 'bdid_' + uccd.version_development,moxie);
k3 := BUILDINDEX( t(did <> ''), {did,(big_endian unsigned8 )__filepos},
			base_key_Name + 'did_'+ uccd.version_development,moxie);
k4 := BUILDINDEX( t(ssn <> ''), {ssn,(big_endian unsigned8 )__filepos},
			base_key_Name + 'ssn_'+ uccd.version_development, moxie);
k5 := BUILDINDEX( t(zip+street_name+addr_suffix+predir+postdir+prim_range+company1 <> ''), {zip,street_name,addr_suffix,predir,postdir,prim_range,company1,(big_endian unsigned8 )__filepos},
			base_key_Name + 'zip.street_name.suffix.predir.postdir.prim_range.company_' + uccd.version_development,moxie);
k6 := BUILDINDEX( t, {zip,street_name,addr_suffix,predir,postdir,prim_range,lfmname,sec_range,(big_endian unsigned8 )__filepos},
			base_key_Name+ 'zip.street_name.suffix.predir.postdir.prim_range.lfmname.sec_range_' + uccd.version_development , moxie);
k7 := BUILDINDEX( t(orig_filing_num + file_state <> ''), {orig_filing_num,file_state,(big_endian unsigned8 )__filepos},
			base_key_Name + 'orig_filing_num.file_state_' + uccd.version_development, moxie);
k8 := BUILDINDEX( t(lfmname <> ''), {lfmname,(big_endian unsigned8 )__filepos},
			base_key_Name + 'lfmname_'+ uccd.version_development, moxie);

			
k9 := BUILDINDEX( t(zip + lfmname <> ''), {zip,lfmname,(big_endian unsigned8 )__filepos},
			base_key_Name + 'zip.lfmname_'+ uccd.version_development, moxie);

//including file_state and state for st.lfmname key

MyFields NormalizeSt(MyFields L,unsigned1 C)
 :=
  transform
	self.st2	:= choose(C, L.st, L.file_state);
	self 	:= L;
end;


pAddress_St_Keys_File	:= normalize(t,2,NormalizeSt(left,counter));
pSt_Keys_lfmname_Dist		:= distribute(pAddress_St_Keys_File,hash(st2,lfmname,__filepos));
pSt_Keys_lfmname_Sort		:= sort(pSt_Keys_lfmname_Dist(st2<>''),st2,lfmname,__filepos,local);	
pSt_Keys_lfmname_Dedup	  := dedup(pSt_Keys_lfmname_Sort,st2,lfmname,__filepos,local);

k10 := BUILDINDEX(pSt_Keys_lfmname_Dedup(st2 + lfmname <> ''), {st2,lfmname,(big_endian unsigned8 )__filepos},
			base_key_Name + 'st.lfmname_'+ uccd.version_development, moxie);
			
			
//THE KEYS NOT NEEDED FOR MOXIE SERVED FROM ROXIE	
		
/*BUILDINDEX( t, {dph_lname,name_first,name_middle,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_debtor2.dph_lname.name_first.name_middle.key', moxie);
BUILDINDEX( t, {st,dph_lname,name_first,name_middle,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_debtor2.st.dph_lname.name_first.name_middle.key', moxie);
BUILDINDEX( t, {st,city,dph_lname,name_first,name_middle,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_debtor2.st.city.dph_lname.name_first.name_middle.key', moxie);
BUILDINDEX( t, {zip,dph_lname,name_first,name_middle,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_debtor2.zip.dph_lname.name_first.name_middle.key', moxie);*/
			
k11 := BUILDINDEX(t(nameasis <> ''), {nameasis,(big_endian unsigned8 )__filepos},
			base_key_Name + 'nameasis_'+ uccd.version_development, moxie);


//including file_state and state for st.nameasis key

pSt_Keys_nameasis_Dist		:= distribute(pAddress_St_Keys_File,hash(st2,nameasis,__filepos));
pSt_Keys_nameasis_Sort		:= sort(pSt_Keys_nameasis_Dist(st2<>''),st2,nameasis,__filepos,local);	
pSt_Keys_nameasis_Dedup	  := dedup(pSt_Keys_nameasis_Sort,st2,nameasis,__filepos,local);


k12 := BUILDINDEX(pSt_Keys_nameasis_Dedup(st2 + nameasis <> ''), {st2,nameasis,(big_endian unsigned8 )__filepos},
			base_key_Name + 'st.nameasis_'+ uccd.version_development, moxie);

k13 := BUILDINDEX( t(zip + nameasis <> ''), {zip,nameasis,(big_endian unsigned8 )__filepos},
			base_key_Name + 'zip.nameasis_'+ uccd.version_development, moxie);
k14 := BUILDINDEX( t(zip + prim_name + addr_suffix + predir+ postdir+prim_range <> ''), {zip,prim_name,addr_suffix,predir,postdir,prim_range,(big_endian unsigned8 )__filepos},
			base_key_Name + 'zip.prim_name.suffix.predir.postdir.prim_range_'+ uccd.version_development, moxie);
k15 := BUILDINDEX( t(z5 + prim_name+prim_range+lname <> ''), {z5,prim_name,prim_range,lname,(big_endian unsigned8 )__filepos},
			base_key_Name + 'z5.prim_name.prim_range.lname_'+ uccd.version_development, moxie);

// zip to city

MyFields NormalizeCities(MyFields L,integer C)
 :=
  transform
	self.city	:= if(C=1,L.City,stringlib.stringextract(L.ZipToCityList,C));
	self 		  := L;
  end
 ;			

City_Keys_File	:= normalize(t,(integer)Stringlib.StringExtract(left.ZipToCityList,1)+1,
									 NormalizeCities(left,counter));
									 
lfmname_City_Keys_Dist	:= distribute(City_Keys_File, hash(St,City,LFMName,__filepos));
lfmname_City_Keys_Sort	:= sort(lfmname_City_Keys_Dist,St,city,LFMName,__filepos, local);
lfmname_City_Keys_Dedup	:= dedup(lfmname_City_Keys_Sort,St,city,LFMName,__filepos,local);

			
k16 := BUILDINDEX(lfmname_City_Keys_Dedup(st+city+lfmname <> ''), {st,city,lfmname,(big_endian unsigned8 )__filepos},
			base_key_Name + 'st.city.lfmname_'+ uccd.version_development, moxie);	



nameasis_City_Keys_Dist	:= distribute(City_Keys_File, hash(St,City,nameasis,__filepos));
nameasis_City_Keys_Sort	:= sort(nameasis_City_Keys_Dist,St,city,nameasis,__filepos, local);
nameasis_City_Keys_Dedup	:= dedup(nameasis_City_Keys_Sort,St,city,nameasis,__filepos,local);


k17 := BUILDINDEX(nameasis_City_Keys_Dedup(st +city+nameasis <> ''), {st,city,nameasis,(big_endian unsigned8 )__filepos},
			base_key_Name + 'st.city.nameasis_'+ uccd.version_development, moxie);
			
address_City_Keys_Dist	:= distribute(City_Keys_File, hash(St,City,prim_name,prim_range,predir,postdir,addr_suffix,__filepos));
address_City_Keys_Sort	:= sort(address_City_Keys_Dist,St,city,prim_name,prim_range,predir,postdir,addr_suffix,__filepos, local);
address_City_Keys_Dedup	:= dedup(address_City_Keys_Sort,St,city,prim_name,prim_range,predir,postdir,addr_suffix,__filepos,local);
			
k18 := BUILDINDEX(address_City_Keys_Dedup(st + city + prim_name + prim_range + predir + postdir+addr_suffix <> ''), {st,city,prim_name,prim_range,predir,postdir,addr_suffix,(big_endian unsigned8 )__filepos},
			base_key_Name + 'st.city.prim_name.prim_range.predir.postdir.suffix_'+ uccd.version_development, moxie);


cn_rec := record
	string10 cn;
    t.st;
	t.st2;
	t.file_state;
	t.city;
	t.zip;
	t.ZipToCityList;
	t.lfmname;
	t.__filepos;
end;

cn_rec Norm_cn(MyFields l, integer C) := transform
	self.cn := choose(C, l.cn_all[1..10], l.cn_all[11..20],l.cn_all[21..30],
						l.cn_all[31..40],l.cn_all[41..50],l.cn_all[51..60],
						l.cn_all[61..70],l.cn_all[71..80]);
	self := l;
end;

cn_records := NORMALIZE(t, 8,Norm_cn(LEFT, COUNTER));

k19 := BUILDINDEX( cn_records(cn <> ''), {cn,(big_endian unsigned8 )__filepos},
			base_key_Name + 'cn_'+ uccd.version_development, moxie);

//including file_state and state for st.cn key

cn_rec NormalizeStcn(cn_rec L,unsigned1 C)
 :=
  transform
	self.st2	:= choose(C, L.st, L.file_state);
	self 	:= L;
end;


pAddress_St_cn_Keys_File	:= normalize(cn_records,2,NormalizeStcn(left,counter));

pSt_Keys_cn_Dist		:= distribute(pAddress_St_cn_Keys_File,hash(st2,cn,__filepos));
pSt_Keys_cn_Sort		:= sort(pSt_Keys_cn_Dist(st2<>''),st2,cn,__filepos,local);	
pSt_Keys_cn_Dedup	    := dedup(pSt_Keys_cn_Sort,st2,cn,__filepos,local);


k20 := BUILDINDEX(pSt_Keys_cn_Dedup(st2 + cn <> '' ), {st2,cn,(big_endian unsigned8 )__filepos},
			base_key_Name + 'st.cn_'+ uccd.version_development, moxie);

k21 := BUILDINDEX(cn_records(zip + cn <> ''), {zip,cn,(big_endian unsigned8 )__filepos},
			base_key_Name + 'zip.cn_'+ uccd.version_development, moxie);
			

cn_rec NormalizeCitiesCn(cn_rec L,integer C)
 :=
  transform
	self.city	:= if(C=1,L.City,stringlib.stringextract(L.ZipToCityList,C));
	self 		  := L;
  end
 ;
 
cn_City_Keys_File	:= normalize(cn_records,
									 (integer)Stringlib.StringExtract(left.ZipToCityList,1)+1,
									 NormalizeCitiesCn(left,counter)
									);	
									
cn_City_Keys_Dedup	:= dedup(cn_City_Keys_File,St,city,cn,zip,__filepos,all);


k22 := BUILDINDEX(cn_City_Keys_Dedup(st + city + cn <> ''), {st,city,cn,(big_endian unsigned8 )__filepos},
			base_key_Name + 'st.city.cn_'+ uccd.version_development, moxie);

//THE KEYS NOT NEEDED FOR MOXIE SERVED FROM ROXIE

/*
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
			'key.moxie_ucc_debtor2.pcn.key', moxie, overwrite);
BUILDINDEX( pcn_records(st <> ''),{st,pcn,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_debtor2.st.pcn.key', moxie, overwrite);
BUILDINDEX( pcn_records(st <> ''),{st,city,pcn,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_debtor2.st.city.pcn.key', moxie);
BUILDINDEX( pcn_records(zip <> ''),{zip,pcn,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_debtor2.zip.pcn.key', moxie);*/


unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(uccd.Layout_withEXpPartyExpanded) + max(h, __filepos): global;
headersize := if (sizeof(uccd.Layout_withEXpPartyExpanded)>215, sizeof(uccd.Layout_withEXpPartyExpanded), error('too bad')) : global;

dfile := INDEX(h,{f:= moxietransform(__filepos, rawsize, headersize)},{h},base_key_Name + 'fpos.data_'+ uccd.version_development);
kFPos				:= BUILDINDEX(dfile,moxie);


export moxie_ucc_debtor_Keys
 := 
  parallel
	(
	 k1
	,k2
	,k3
	,k4
	,k5
	,k6
	,k7
	,k8
	,k9
	,k10
	,k11
	,k12
	,k13
	,k14
	,k15
	,k16
	,k17
	,k18
	,k19
	,k20
	,k21
	,k22
	,kFPos
	)
  ;
  
			
