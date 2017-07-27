import property,Lib_KeyLib;
#workunit ('name', 'Build Fares Search File Keys 1');

string_rec := record
	property.Layout_prop_out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

h := DATASET(property.Filename_Fares_DID_Out, string_rec, THOR);


MyFields := record
  string45 lfmname := TRIM(h.lname,right) + ' ' + IF(TRIM(h.fname,right) = '', ' ',TRIM(h.fname,right) + ' ') + 
					  TRIM(h.mname,right);
  string45 company1 := h._company[1..45];
  string45 lfm :='';
  h.did;
  h.bdid;
  h.fares_id;
  h.source_code;
  string80 cn_all := keyLib.GongDacName(h._company);
  string10 cn := '';
  h.lname;
  h.nameasis;
  h.prim_range;
  h.predir;
  h.prim_name;
  h.suffix;
  h.postdir;
  h.sec_range;
  h.st;
  h.zip;
  h.__filepos;
end;

t := table(h,MyFields);

MyFields use_cn(MyFields l, unsigned1 cnt) := TRANSFORM
	self.cn := choose(cnt, l.cn_all[1..10], l.cn_all[11..20],l.cn_all[21..30],l.cn_all[31..40],
						   l.cn_all[41..50],l.cn_all[51..60],l.cn_all[61..70],l.cn_all[71..80]);
	self := l;
end;

cn_records := NORMALIZE(t,8,use_cn(left,counter));

MyFields use_lfm(MyFields l, unsigned1 cnt) := TRANSFORM
	self.lfm := choose(cnt, l.lfmname, l.company1);
	self := l;
end;

lfm_records := NORMALIZE(t,2,use_lfm(left,counter));

kCNFid			:= BUILDINDEX(cn_records(cn<>''),{cn,fares_id,(big_endian unsigned8 )__filepos},
								property.base_key_name + 'cn.fid.key', MOXIE, overwrite);
kStCNFid		:= BUILDINDEX(cn_records(cn<>''),{st,cn,fares_id,(big_endian unsigned8 )__filepos},
								property.base_key_name + 'st.cn.fid.key', MOXIE, overwrite);
kZ5Address		:= BUILDINDEX(lfm_records,{zip,prim_name,predir,postdir,prim_range,suffix,lname,sec_range,fares_id,source_code,lfm,(big_endian unsigned8 )__filepos},
								property.base_key_name + 'z5.street_name.predir.postdir.prim_range.suffix.lname.sec_range.fares_id.source_code.lfmname.key', MOXIE, overwrite);
kNameasis		:= BUILDINDEX(t,{nameasis,(big_endian unsigned8 )__filepos},
								property.base_key_name + 'nameasis.key', MOXIE, overwrite);
kStNameasis		:= BUILDINDEX(t,{st,nameasis,(big_endian unsigned8 )__filepos},
								property.base_key_name + 'st.nameasis.key', MOXIE, overwrite);
kFID			:= BUILDINDEX(t,{fares_id,(big_endian unsigned8 )__filepos},
								property.base_key_name + 'fid.key', MOXIE, overwrite);
kDID			:= BUILDINDEX(t,{did,(big_endian unsigned8 )__filepos},
								property.base_key_name + 'did.key', MOXIE, overwrite);
kBDID			:= BUILDINDEX(t,{bdid,(big_endian unsigned8 )__filepos},
								property.base_key_name + 'bdid.key', MOXIE, overwrite);

export Out_MoxieFaresSearchKeys_Part1
 :=
  parallel
	(
	 kCNFid
	,kStCNFid
	,kZ5Address
	,kNameasis
	,kStNameasis
	,kFID
	,kDID
	,kBDID
	)
  ;