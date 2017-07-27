import LN_property,Lib_KeyLib;
#workunit ('name', 'Build Property Search File Keys 1');

string_rec := record
	LN_property.Layout_DID_Out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

h := DATASET('~thor_data400::base::Property_DID', string_rec, THOR);


MyFields := record
  string45 lfmname := TRIM(h.lname,right) + ' ' + IF(TRIM(h.fname,right) = '', ' ',TRIM(h.fname,right) + ' ') + 
					  TRIM(h.mname,right);
  string45 company1 := h.cname[1..45];
  string45 lfm :='';
  h.did;
//  h.ssn;
  h.ln_fares_id;
  h.source_code;
  string80 cn_all := keyLib.GongDacName(h.cname);
  string10 cn := '';
  h.lname;
  h.nameasis;
  h.prim_range;
  h.predir;
  h.prim_name;
  h.suffix;
  h.postdir;
  h.sec_range;
  h.unit_desig;
  h.p_city_name;
  h.st;
  h.zip;
  h.zip4;
  h.county;
  h.__filepos;
end;

t := table(h,MyFields);

MyFields use_cn(MyFields l, unsigned1 cnt) := TRANSFORM
	self.cn := choose(cnt, l.cn_all[1..10], l.cn_all[11..20],l.cn_all[21..30],l.cn_all[31..40],
						   l.cn_all[41..50],l.cn_all[51..60],l.cn_all[61..70],l.cn_all[71..80]);
	self := l;
end;

cn_records := NORMALIZE(t,8,use_cn(left,counter));

cn_dedup 	:= dedup(cn_records(cn<>''),cn,ln_fares_id, __filepos,all);

cn_st_dedup	:= dedup(cn_records(cn<>''),st,cn,ln_fares_id,__filepos,all);


MyFields use_lfm(MyFields l, unsigned1 cnt) := TRANSFORM
	self.lfm := choose(cnt, l.lfmname, l.company1);
	self := l;
end;

lfm_records     := NORMALIZE(t,2,use_lfm(left,counter));

//lfm_fid_dedup 	:= dedup(lfm_records(lfm <>''),ln_fares_id,source_code,lfm, __filepos,all);

//lfm_zip_street_dedup	:= dedup(lfm_records(lfm <>''),zip,prim_name,predir,postdir,prim_range,suffix,lname,sec_range,ln_fares_id,source_code,lfm,__filepos,all);



kCNFid			:= BUILDINDEX(cn_dedup,{cn,ln_fares_id,(big_endian unsigned8 )__filepos},
								LN_property.base_key_name + 'property_search.cn.fid_'+ LN_Property.version_development, MOXIE);
kStCNFid		:= BUILDINDEX(cn_st_dedup,{st,cn,ln_fares_id,(big_endian unsigned8 )__filepos},
								LN_property.base_key_name + 'property_search.st.cn.fid_'+ LN_Property.version_development, MOXIE);
kFIDSourecode	:= BUILDINDEX(lfm_records(lfm<> ''),{ln_fares_id,source_code,lfm,(big_endian unsigned8 )__filepos},
								LN_property.base_key_name + 'property_search.fid.source_code.lfmname_'+ LN_Property.version_development, MOXIE);								
kZ5Address		:= BUILDINDEX(lfm_records(lfm<> ''),{zip,prim_name,predir,postdir,prim_range,suffix,lname,sec_range,ln_fares_id,source_code,lfm,(big_endian unsigned8 )__filepos},
								LN_property.base_key_name + 'property_search.z5.street_name.predir.postdir.prim_range.suffix.lname.sec_range.ln_fares_id.source_code.lfmname_'+ LN_Property.version_development, MOXIE);
kNameasis		:= BUILDINDEX(t(nameasis <>''),{nameasis,(big_endian unsigned8 )__filepos},
								LN_property.base_key_name + 'property_search.nameasis_'+ LN_Property.version_development, MOXIE);
kStNameasis		:= BUILDINDEX(t(st + nameasis <>''),{st,nameasis,(big_endian unsigned8 )__filepos},
								LN_property.base_key_name + 'property_search.st.nameasis_'+ LN_Property.version_development, MOXIE);
kFID			:= BUILDINDEX(t(ln_fares_id <> ''),{ln_fares_id,(big_endian unsigned8 )__filepos},
								LN_property.base_key_name + 'property_search.fid_'+ LN_Property.version_development, MOXIE);
kDID			:= BUILDINDEX(t(did <> 0),{did,(big_endian unsigned8 )__filepos},
								LN_property.base_key_name + 'property_search.did_'+ LN_Property.version_development, MOXIE);

kStZipAddress   := BUILDINDEX(t(prim_name+predir+postdir+prim_range+suffix+sec_range+unit_desig+p_city_name+st+zip+zip4+county<> ''),{prim_name,predir,postdir,prim_range,suffix,sec_range,unit_desig,p_city_name,st,zip,zip4,county,(big_endian unsigned8 )__filepos},
								LN_property.base_key_name + 'property_search.street_name.predir.postdir.prim_range.suffix.sec_range.unit_desig.p_city_name.st.z5.z4.county_'+ LN_Property.version_development, MOXIE);

//kSSN			:= BUILDINDEX(t(ssn <> ''),{ssn,(big_endian unsigned8 )__filepos},
						//		LN_property.base_key_name + 'property_search.ssn_'+ LN_Property.version_development, MOXIE);


export Out_MoxiePropertySearchKeys_Part1
 :=
  parallel
	(
	 kCNFid
	,kStCNFid
	,kFIDSourecode
	,kZ5Address
	,kNameasis
	,kStNameasis
	,kFID
	,kDID
	,kStZipAddress
//	,kSSN
	)
  ;