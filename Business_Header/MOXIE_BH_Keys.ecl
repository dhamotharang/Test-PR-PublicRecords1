import Business_Header,Lib_KeyLib;

h := Business_Header.Layout_Business_Header_Out_Keybuild;

MyFields := record
    h.bdid;            // Seisint Business Identifier
    string30 name_company := h.company_name[1..30];
    h.company_name;
    h.prim_range;
    h.predir;
    h.prim_name;
    h.addr_suffix;
    h.postdir;
    h.sec_range;
    h.city;
    h.state;
    h.zip;
    h.zip4;
    h.phone;
	h.fein;
	h.geo_lat;
	h.geo_long;
	real lat := (real) (h.geo_lat);
	real latradians := (real) (h.geo_lat) / 57.296;
	real long := (real) (h.geo_long);
	integer milesperband := 25;
	string12 street := h.prim_name[1..13];
	string13 pcity := h.city[1..13];
	string16 dph_cname := keyLib.GongCompName(h.company_name);
	string5 dph_city := metaphonelib.DMetaPhone1(h.city);
	string5 dph_street := metaphonelib.DMetaPhone1(h.prim_name);
	string6 exchange := h.phone[1..6];
	string3 zip3 := h.zip[1..3];
    string30 nameasis := KeyLib.CompNameNoSyn(h.company_name);
	string80 cn_all := keyLib.GongDacName(h.company_name);
	string40 pcn_all := keyLib.GongDaphcName(h.company_name);
	VARSTRING citylist := ZipLib.ZipToCities(h.zip);
	h.__filepos;
end;
  
t := table(h, MyFields);

simple_rec := record
	t.phone;
	t.fein;
	t.bdid;
	t.__filepos;
end;

// No point to build keys if the field is empty
fein_records := table(t(t.fein <> ''),simple_rec);
phoneno_records := table(t(t.phone <> ''),simple_rec);
bdid_records := table(t(t.bdid <> ''),simple_rec);
key1 := BUILDINDEX( phoneno_records, {phone,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name + 'phoneno.key', moxie,overwrite);
key2 := BUILDINDEX( fein_records, {fein,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name + 'fein.key', moxie,overwrite);
key3 := BUILDINDEX( bdid_records, {bdid,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name + 'bdid.key', moxie,overwrite);


address_rec := record
	t.zip;
	t.prim_name;
	t.prim_range;
	t.addr_suffix;
	t.predir;
	t.postdir;
	string60 company_clean := keyLib.CompName(t.company_name);
	t.sec_range;
	t.__filepos;
end;

address_records := table(t,address_rec);

key4 := BUILDINDEX( address_records(zip != ''), {zip,prim_name,prim_range,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name + 'z5.prim_name.prim_range.key', moxie,overwrite);
key5 := BUILDINDEX( address_records(zip != ''), {zip,prim_name,addr_suffix,predir,postdir,prim_range,company_clean,sec_range,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name + 'zip.street_name.suffix.predir.postdir.prim_range.company.sec_range.key', moxie,overwrite);

latlong_rec := record
	t.state;
	t.city;
	t.zip;
	t.geo_lat;
	t.geo_long;
	t.lat;
	t.latradians;
	t.long;
	t.milesperband;
	real milesperdegree := 3959.0 * (acos(sin(t.latradians) * sin(t.latradians) + cos(t.latradians) * cos(t.latradians) * cos(1.0 / 57.296)));
	t.cn_all;
	t.__filepos;
end;

latlong_records := table(t,latlong_rec);

cn_rec := record
	latlong_records.state;
	latlong_records.city;
	latlong_records.zip;
	latlong_records.geo_lat;
	latlong_records.geo_long;
	latlong_records.lat;
	latlong_records.latradians;
	latlong_records.long;
	latlong_records.milesperband;
	latlong_records.milesperdegree;
	string10 cn := '';
	string6 lat25 := '';
	string6 long25 := '';
	t.__filepos;
end;

cn_rec use_cn(latlong_rec l, unsigned1 cnt) := TRANSFORM
	self.cn := choose(cnt, l.cn_all[1..10], l.cn_all[11..20],l.cn_all[21..30],l.cn_all[31..40],
						   l.cn_all[41..50],l.cn_all[51..60],l.cn_all[61..70],l.cn_all[71..80]);
	self.lat25 := intformat((integer) ((l.lat) * 69.098 / l.milesperband + .5), 6, 1);
	self.long25 := intformat((integer) ((l.long + 180) * l.milesperdegree / l.milesperband + 0.5), 6, 1);
	self := l;
end;

cn_records := NORMALIZE(latlong_records,8,use_cn(left,counter));
key6 := BUILDINDEX( cn_records(cn<>''),{cn,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name + 'cn.key', moxie,overwrite);
key7 := BUILDINDEX( cn_records(state <> '' and cn<>''),{state,cn,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name + 'st.cn.key', moxie,overwrite);
key9 := BUILDINDEX( cn_records(zip <> '' and cn<>''),{zip,cn,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name + 'z5.cn.key', moxie,overwrite);
key25 := BUILDINDEX( cn_records(lat25 <> '' and long25 <> '' and cn<>''),{lat25,long25,cn,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name + 'lat25.long25.cn.key', moxie,overwrite);

nameasis_rec := record
	t.nameasis;
	t.state;
	t.zip;
	t.city;
	t.__filepos;
end;

nameasis_records := table(t,nameasis_rec);

key10 := BUILDINDEX( nameasis_records(nameasis <> ''),{nameasis,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name + 'nameasis.key', moxie,overwrite);
key11 := BUILDINDEX( nameasis_records(state <> '' and nameasis <> ''),{state,nameasis,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name + 'st.nameasis.key', moxie, overwrite);
key13 := BUILDINDEX( nameasis_records(zip <> '' and nameasis <> ''),{zip,nameasis,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name + 'z5.nameasis.key', moxie, overwrite);

pcn_rec := record
	t.nameasis;
	t.state;
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

key14 := BUILDINDEX( pcn_records(pcn<>''),{pcn,nameasis,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name + 'pcn.nameasis.key', moxie, overwrite);
key15 := BUILDINDEX( pcn_records(state <> '' and pcn<>''),{state,pcn,nameasis,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name + 'st.pcn.nameasis.key', moxie, overwrite);
key17 := BUILDINDEX( pcn_records(zip <> '' and pcn<>''),{zip,pcn,nameasis,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name + 'z5.pcn.nameasis.key', moxie,overwrite);

ph_rec := record
	t.name_company;
	t.prim_range;
	t.predir;
	t.postdir;
	t.street;
	t.sec_range;
	t.pcity;
	t.state;
	t.zip;
	t.zip3;
	t.phone;
	t.exchange;
	string4 dph_cname :='';
	t.dph_city;
	t.dph_street;
	t.__filepos;
end;

ph_rec use_ph(MyFields l, unsigned1 cnt) := TRANSFORM
	self.dph_cname  := choose(cnt, l.dph_cname[1..4], l.dph_cname[5..8], l.dph_cname[9..12],l.dph_cname[13..16]);
	self := l;
end;

ph_records := NORMALIZE(t,4,use_ph(left,counter));
ph_duped := DEDUP(ph_records(ph_records.dph_cname <> ''), dph_cname,__filepos,all);

key18 := BUILDINDEX( ph_duped,{dph_cname,prim_range,dph_street,name_company,pr := prim_range,predir,street,
					  sec_range,pcity,state,zip,phone,(big_endian unsigned8 )__filepos},
					  Business_Header.Base_Key_Name + 
'dph_cname.prim_range.dph_street.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key', moxie,overwrite);
key19 := BUILDINDEX( ph_duped,{dph_cname,zip,name_company,prim_range,predir,street,
					  sec_range,pcity,state,z := zip,phone,(big_endian unsigned8 )__filepos},
					  Business_Header.Base_Key_Name + 
'dph_cname.z5.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key', moxie,overwrite);
key20 := BUILDINDEX( ph_duped,{dph_cname,zip3,name_company,prim_range,predir,street,
					  sec_range,pcity,state,zip,phone,(big_endian unsigned8 )__filepos},
					  Business_Header.Base_Key_Name + 
'dph_cname.z3.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key', moxie,overwrite);
key21 := BUILDINDEX( ph_duped(state <> ''),{state,dph_cname,name_company,prim_range,predir,street,
					  sec_range,pcity,st := state,zip,phone,(big_endian unsigned8 )__filepos},
					  Business_Header.Base_Key_Name + 
'st.dph_cname.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key', moxie,overwrite);

ph2_rec := record
	t.name_company;
	t.prim_range;
	t.predir;
	t.postdir;
	t.street;
	t.sec_range;
	t.pcity;
	t.state;
	t.zip;
	t.zip3;
	t.phone;
	t.exchange;
	t.dph_city;
	t.dph_street;
	t.__filepos;
end;

ph := table(t, ph2_rec);

key22 := BUILDINDEX( ph(exchange <> '' and name_company <> ''), {exchange,name_company,prim_range,predir,street,
					  sec_range,pcity,state,zip,phone,(big_endian unsigned8 )__filepos},
					  Business_Header.Base_Key_Name + 
'exchange.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key', moxie, overwrite);
key23 := BUILDINDEX( ph(prim_range <> '' and state <> ''), {prim_range,state,dph_city,name_company,pr :=prim_range,predir,street,
					  sec_range,pcity,st := state,zip,phone,(big_endian unsigned8 )__filepos},
					  Business_Header.Base_Key_Name + 
'prim_range.st.dph_city.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key', moxie, overwrite);
key24 := BUILDINDEX( ph(prim_range <> '' and zip <> ''), {prim_range,zip,name_company,pr := prim_range,predir,street,
					  sec_range,pcity,state,z := zip,phone,(big_endian unsigned8 )__filepos},
					  Business_Header.Base_Key_Name + 
'prim_range.z5.name_company.prim_range.predir.street.sec_range.pcity.st.z5.phone10.key', moxie, overwrite);


ZipCityRec := RECORD
    t.city;
    t.state;
	string2 st;
    t.nameasis;
	t.cn_all;
	t.pcn_all;
	string25 city_from_zip;
	t.__filepos;
END;
 
ZipCityRec NormCityList(t L, INTEGER C) := TRANSFORM
	SELF.city_from_zip := IF ( C = 1, l.city, Stringlib.StringExtract(L.citylist, C ));
	self.st := l.state;
	SELF := L;
END;
 
ZipCitySet	:= distribute(t,hash(__filepos));
ZCS_Norm	:= normalize(ZipCitySet,(INTEGER)Stringlib.StringExtract(LEFT.citylist, 1)+1, NormCityLIst(LEFT, COUNTER));


key12 := BUILDINDEX( ZCS_Norm(st <> '' and city_from_zip <> ''),{st,city_from_zip,nameasis,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name + 'st.city.nameasis.key', moxie, overwrite);
			
// --------------------
// CN city key
// --------------------
cn2_rec := record
	ZCS_Norm.st;
	ZCS_Norm.city_from_zip;
	string10 cn := '';
	ZCS_Norm.__filepos;
end;

cn2_rec use_cn2(ZCS_Norm l, unsigned1 cnt) := TRANSFORM
	self.cn := choose(cnt, l.cn_all[1..10], l.cn_all[11..20],l.cn_all[21..30],l.cn_all[31..40],
						   l.cn_all[41..50],l.cn_all[51..60],l.cn_all[61..70],l.cn_all[71..80]);
	self := l;
end;

cn2_records := NORMALIZE(ZCS_Norm,8,use_cn2(left,counter));


key8 := BUILDINDEX( cn2_records(st<>'' and city_from_zip <> '' and cn <> ''),{st,city_from_zip,cn,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name + 'st.city.cn.key', moxie, overwrite);
			
// ------------------			
// PCN city key
// ------------------
pcn2_rec := record
	ZCS_Norm.nameasis;
	ZCS_Norm.st;
	ZCS_Norm.city_from_zip;
	string5 pcn :='';
	ZCS_Norm.__filepos;
end;

pcn2_rec use_pcn2(ZCS_Norm l, unsigned1 cnt) := TRANSFORM
	self.pcn := choose(cnt,l.pcn_all[1..5], l.pcn_all[6..10],l.pcn_all[11..15],l.pcn_all[16..20],
						   l.pcn_all[21..25],l.pcn_all[26..30],l.pcn_all[31..35],l.pcn_all[36..40]);
	self := l;
end;

pcn2_records := NORMALIZE(ZCS_Norm,8,use_pcn2(left,counter));

key16 := BUILDINDEX( pcn2_records(st <> '' and city_from_zip <> '' and pcn<>''),{st,city_from_zip,pcn,nameasis,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name + 'st.city.pcn.nameasis.key', moxie,overwrite);

/////////////////////////////////////////////////			
// FPOS DATA KEY	
/////////////////////////////////////////////////			
unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(Business_Header.Layout_Business_Header_Out) * count(h) : global;
headersize := sizeof(Business_Header.Layout_Business_Header_Out) : global;

dfile := INDEX(h,{f:= moxietransform(__filepos, rawsize, headersize)},{h},Business_Header.Base_Key_Name + 'fpos.data.key');

key26 := buildindex(dfile,moxie,overwrite);


export MOXIE_BH_Keys := sequential(   parallel(
			   Key1
			  ,Key2
			  ,Key3
			  ,Key4
			  ,Key5)
			  ,parallel(
			   Key6
			  ,Key7
			  ,Key8
			  ,Key9
			  ,key25)
			  ,parallel(
			   Key10
			  ,Key11
			  ,Key12
			  ,Key13
			  ,Key14
			  ,Key15
			  ,Key16
			  ,Key17)
			  ,parallel(
			   Key18
			  ,Key19
			  ,Key20
			  ,Key21
			  ,Key22
			  ,key23
			  ,key24
			  ,key26)
			  
		   )
 ;