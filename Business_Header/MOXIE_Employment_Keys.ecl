import Business_Header,Lib_KeyLib;

h := Business_Header.File_Employment_Keybuild;

MyFields := record
	h.did; 
//	h.preGLB_did;
	h.bdid;
	h.ssn;
    string9 fein := h.company_fein;
	h.fname;
	h.mname;
	h.lname;

	h.prim_range;
	h.predir;
	h.prim_name;
	h.addr_suffix;
	h.postdir;
	h.sec_range;
	h.city;
	h.state;
  	h.zip;
//company stuff
	h.company_prim_range;
	h.company_predir;
	h.company_prim_name;
	h.company_addr_suffix;
	h.company_postdir;
	h.company_sec_range;
	h.company_city;
	h.company_state;
  	h.company_zip;

	string45 lfmname := TRIM(h.lname,right) + ' ' + IF(TRIM(h.fname,right) = '', ' ',TRIM(h.fname,right) + ' ') + TRIM(h.mname,right);
    h.company_phone;
    h.phone;
//	string60 company1 := KeyLib.CompName(h.company_name); // 120 bytes
	string30 nameasis := KeyLib.CompNameNoSyn(h.company_name);
    string3 inverted_score := intformat(500 - (integer)h.score, 3, 1);
	string80 cn_all := keyLib.GongDacName(h.company_name);

	h.__filepos;
end;

t := table(h, MyFields);

key1 := BUILDINDEX( t(lfmname != ''), {lfmname,(big_endian unsigned8 )__filepos},
			Business_Header.base_key_name_employment + 'lfmname.key',moxie, overwrite);
key2 := BUILDINDEX( t(did != ''), {did,(big_endian unsigned8 )__filepos},
			Business_Header.base_key_name_employment + 'did.key', moxie,overwrite);
key3 := BUILDINDEX( t(bdid != ''), {bdid,(big_endian unsigned8 )__filepos},
			Business_Header.base_key_name_employment + 'bdid.key', moxie,overwrite);
key3a := BUILDINDEX( t(did != ''), {did,bdid,(big_endian unsigned8 )__filepos},
			Business_Header.base_key_name_employment + 'did.bdid.key', moxie,overwrite);
key4 := BUILDINDEX( t(ssn != ''), {ssn,(big_endian unsigned8 )__filepos},
			Business_Header.base_key_name_employment + 'ssn.key', moxie,overwrite);
key5 := BUILDINDEX( t(ssn != ''), {ssn,inverted_score,(big_endian unsigned8 )__filepos},
			Business_Header.base_key_name_employment + 'ssn.score.key', moxie,overwrite);
key6 := BUILDINDEX( t(fein != ''), {fein,(big_endian unsigned8 )__filepos},
			Business_Header.base_key_name_employment + 'fein.key', moxie,overwrite);
//BUILDINDEX( t, {company1,(big_endian unsigned8 )__filepos},
//			Business_Header.base_key_name_employment + 'company.key', moxie,overwrite);
key7 := BUILDINDEX( t(nameasis <> ''), {nameasis,(big_endian unsigned8 )__filepos},
			Business_Header.base_key_name_employment + 'nameasis.key', moxie,overwrite);


phone_rec := record
	t.company_phone;
	t.phone;
	string10 phoneno;
	t.__filepos;
end;

phone_rec norm_phone(MyFields l, unsigned1 cnt) := TRANSFORM
	self.phoneno := choose(cnt, l.company_phone, l.phone);
	self := l;
end;

phone_records := NORMALIZE(t,2,norm_phone(left,counter));

key8 := BUILDINDEX( phone_records(phoneno <> ''), {phoneno,(big_endian unsigned8 )__filepos},
			Business_Header.base_key_name_employment + 'phoneno.key', moxie,overwrite);


multi_address_rec := record
string10  all_prim_range;
string2   all_predir;
string28  all_prim_name;
string4   all_addr_suffix;
string2   all_postdir;
string8   all_sec_range;
string25  all_city;
string2   all_state;
string5   all_zip;
	t.prim_range;
	t.predir;
	t.prim_name;
	t.addr_suffix;
	t.postdir;
	t.city;
	t.state;
  	t.zip;
	t.company_prim_range;
	t.company_predir;
	t.company_prim_name;
	t.company_addr_suffix;
	t.company_postdir;
	t.company_city;
	t.company_state;
  	t.company_zip;
	t.lfmname;
	t.nameasis;
	t.cn_all;
	t.__filepos;
end;

multi_address_rec norm_address(MyFields l, unsigned1 cnt) := TRANSFORM
	self.all_prim_range := choose(cnt, l.company_prim_range, l.prim_range);
	self.all_prim_name := choose(cnt, l.company_prim_name, l.prim_name);
	self.all_predir := choose(cnt, l.company_predir, l.predir);
	self.all_postdir := choose(cnt, l.company_postdir, l.postdir);
	self.all_addr_suffix := choose(cnt, l.company_addr_suffix, l.addr_suffix);
	self.all_sec_range := choose(cnt, l.company_sec_range, l.sec_range);
	self.all_city := choose(cnt, l.company_city, l.city);
	self.all_zip := choose(cnt, l.company_zip, l.zip);
	self.all_state := choose(cnt, l.company_state, l.state);
	self := l;
end;

multi_address_records := NORMALIZE(t,1,norm_address(left,counter));
			

key9 := BUILDINDEX(multi_address_records(all_state <> ''), {all_state,lfmname,(big_endian unsigned8 )__filepos},
			Business_Header.base_key_name_employment + 'st.lfmname.key',moxie, overwrite);
key10 := BUILDINDEX(multi_address_records(all_zip <> ''), {all_zip,all_prim_name,all_prim_range,(big_endian unsigned8 )__filepos},
			Business_Header.base_key_name_employment + 'z5.prim_name.prim_range.key',moxie, overwrite);
key11 := BUILDINDEX(multi_address_records(all_zip <> ''), {all_zip,all_prim_name,all_addr_suffix,all_predir,all_postdir,all_prim_range,all_sec_range,(big_endian unsigned8 )__filepos},
			Business_Header.base_key_name_employment + 'z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key', moxie,overwrite);
key12 := BUILDINDEX(multi_address_records(all_state <> ''), {all_state,nameasis,(big_endian unsigned8 )__filepos},
			Business_Header.base_key_name_employment + 'st.nameasis.key', moxie,overwrite);
key13 := BUILDINDEX(multi_address_records(all_zip <> ''),{all_zip,nameasis,(big_endian unsigned8 )__filepos},
			Business_Header.base_key_name_employment + 'z5.nameasis.key', moxie, overwrite);
key13a := BUILDINDEX(multi_address_records(all_zip <> ''),{all_zip,lfmname,(big_endian unsigned8 )__filepos},
			Business_Header.base_key_name_employment + 'z5.lfmname.key', moxie, overwrite);
			
ZipCitiesRec := record
  multi_address_records.all_city;
  multi_address_records.all_state;
  multi_address_records.all_zip;
  multi_address_records.lfmname;
  multi_address_records.nameasis;
  VARSTRING citylist;
  multi_address_records.cn_all;
  multi_address_records.__filepos;
end;

// Project to get city list for each zip
ZipCitiesRec GetCityList(multi_address_records L) := TRANSFORM
	SELF.citylist := ZipLib.ZipToCities(L.all_zip);
	SELF:= L;
END;
 
ZipCitiesSet := PROJECT(multi_address_records, GetCityList(LEFT));

ZipCityRec := RECORD
  ZipCitiesSet.all_city;
  ZipCitiesSet.all_state;
  ZipCitiesSet.all_zip;
  ZipCitiesSet.lfmname;
  ZipCitiesSet.nameasis;
  string13 city_from_zip;
  ZipCitiesSet.cn_all;
  ZipCitiesSet.__filepos;
END;
 
ZipCityRec NormCityList(ZipCitiesRec L, INTEGER C) := TRANSFORM
	SELF.city_from_zip := IF ( C = 1, l.all_city, Stringlib.StringExtract(L.citylist, C ));
	SELF := L;
END;
 
ZipCitySet := NORMALIZE(ZipCitiesSet, (INTEGER)Stringlib.StringExtract(LEFT.citylist, 1)+1, NormCityLIst(LEFT, COUNTER));
zcs_dist := distribute(ZipCitySet, hash(city_from_zip,all_state,lfmname,__filepos));
zcs_srtd := sort(zcs_dist, city_from_zip, all_state, lfmname,__filepos, local);
City_d := DEDUP(zcs_srtd, city_from_zip, all_state, lfmname,__filepos, local);
			
key14 := BUILDINDEX( City_d(all_state <> ''), {all_state,city_from_zip,lfmname,(big_endian unsigned8 )__filepos},
			Business_Header.base_key_name_employment + 'st.city.lfmname.key', moxie,overwrite);
key15 := BUILDINDEX( City_d(all_state <> ''), {all_state,city_from_zip,nameasis,(big_endian unsigned8 )__filepos},
			Business_Header.base_key_name_employment + 'st.city.nameasis.key', moxie,overwrite);

cn_rec := record
	City_d.all_state;
	City_d.city_from_zip;
	City_d.all_zip;
	string10 cn := '';
	t.__filepos;
end;

cn_rec use_cn(City_d l, unsigned1 cnt) := TRANSFORM
	self.cn := choose(cnt, l.cn_all[1..10], l.cn_all[11..20],l.cn_all[21..30],l.cn_all[31..40],
						   l.cn_all[41..50],l.cn_all[51..60],l.cn_all[61..70],l.cn_all[71..80]);
	self := l;
end;

cn_records := NORMALIZE(City_d,8,use_cn(left,counter));
zcs_dist_cn := distribute(cn_records, hash(all_zip,all_state,city_from_zip,cn,__filepos));
zcs_srtd_cn := sort(zcs_dist_cn, all_zip,all_state,city_from_zip,cn,__filepos, local);
cn_dedup := DEDUP(zcs_srtd_cn, all_zip,all_state,city_from_zip,cn,__filepos, local);

key16 := BUILDINDEX( cn_dedup(cn<>''),{cn,(big_endian unsigned8 )__filepos},
			Business_Header.base_key_name_employment + 'cn.key', moxie,overwrite);
key17 := BUILDINDEX( cn_dedup(all_state <> '' and cn<>''),{all_state,cn,(big_endian unsigned8 )__filepos},
			Business_Header.base_key_name_employment + 'st.cn.key', moxie,overwrite);
key18 := BUILDINDEX( cn_dedup(all_state <> '' and city_from_zip <> '' and cn<>''),{all_state,city_from_zip,cn,(big_endian unsigned8 )__filepos},
			Business_Header.base_key_name_employment + 'st.city.cn.key', moxie, overwrite);
key19 := BUILDINDEX( cn_dedup(all_zip <> '' and cn<>''),{all_zip,cn,(big_endian unsigned8 )__filepos},
			Business_Header.base_key_name_employment + 'z5.cn.key', moxie,overwrite);

unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(Business_Header.Layout_Employment_Out) * count(h) : global;
headersize := sizeof(Business_Header.Layout_Employment_Out) : global;

dfile := INDEX(h,{f:= moxietransform(__filepos, rawsize, headersize)},{h},Business_Header.base_key_name_employment + 'fpos.data.key');

key20 := buildindex(dfile,moxie,overwrite);



			
export MOXIE_Employment_Keys := sequential(	parallel(
			   Key1
			  ,Key2
			  ,Key3
			  ,Key3a
			  ,Key4
			  ,Key5
			  ,Key6
			  ,Key7
			  ,Key8),
				parallel(
			   Key9
			  ,Key10
			  ,Key11
			  ,Key12
			  ,Key13
				,Key13a),
				parallel(
			   Key14
			  ,Key15
			  ,Key16
			  ,Key17
			  ,Key18
			  ,Key19
			  ,key20)

		   )
 ;