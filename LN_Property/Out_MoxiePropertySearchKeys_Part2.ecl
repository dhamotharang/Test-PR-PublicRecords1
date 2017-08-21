import LN_property,Lib_KeyLib;
#workunit ('name', 'Build Property Search File Keys 2');

string_rec := record
	LN_property.Layout_Moxie_Deed_Mortgage_Property_Search;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

h := DATASET(ln_property.fileNames.outSearch, string_rec, THOR,__compressed__);

//filter out DAYTON data
h_filter := h(ln_fares_id[3] <> 'D');
h_dist := distribute(h_filter, random());

MyFields := record		
  string45 lfmname := TRIM(h.lname,right) + ' ' + IF(TRIM(h.fname,right) = '', ' ',TRIM(h.fname,right) + ' ') + 
					  TRIM(h.mname,right);
  string45 company1 := h.cname[1..45];
  string45 lfm :='';
  h.prim_range;
  h.prim_name;
  h.st;
  h.zip;
  h.__filepos;
end;

t := table(h_dist,MyFields);



MyFields use_lfm(MyFields l, unsigned1 cnt) := TRANSFORM
	self.lfm := choose(cnt, l.lfmname, l.company1);
	self := l;
end;

lfm_records := NORMALIZE(t,2,use_lfm(left,counter));

kLFMName		:= BUILDINDEX(lfm_records(lfm<>''),{lfm,(big_endian unsigned8 )__filepos},
								LN_property.base_key_name + 'property_search.lfmname_'+ LN_Property.version_build, MOXIE, overwrite);
kStLFMName		:= BUILDINDEX(lfm_records(lfm<>''),{st,lfm,(big_endian unsigned8 )__filepos},
								LN_property.base_key_name + 'property_search.st.lfmname_'+ LN_Property.version_build, MOXIE, overwrite);
kZ5LFMName		:= BUILDINDEX(lfm_records(lfm<>''),{zip,lfm,(big_endian unsigned8 )__filepos},
								LN_property.base_key_name + 'property_search.z5.lfmname_'+ LN_Property.version_build, MOXIE, overwrite);
kZ5PrimLFMName	:= BUILDINDEX(lfm_records(lfm<>''),{zip,prim_name,prim_range,lfm,(big_endian unsigned8 )__filepos},
								LN_property.base_key_name + 'property_search.z5.prim_name.prim_range.lfmname_'+ LN_Property.version_build, MOXIE, overwrite);

export Out_MoxiePropertySearchKeys_Part2
 :=
  parallel
	(
	 kLFMName
	,kStLFMName
	,kZ5LFMName
	,kZ5PrimLFMName
	)
  ;