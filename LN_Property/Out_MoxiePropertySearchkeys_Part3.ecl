import property,Lib_KeyLib;
#workunit ('name', 'Build Property Search File Keys 3');

string_rec := record
	LN_property.Layout_Moxie_Deed_Mortgage_Property_Search;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

h := DATASET(ln_property.fileNames.outSearch, string_rec, THOR,__compressed__);

//filter out DAYTON data

h_filter := h(ln_fares_id[3] <> 'D');
h_dist := distribute(h_filter, random());

MyFields := record		
  string14 fid := h.ln_fares_id;
  string45 lfmname := TRIM(h.lname,right) + ' ' + IF(TRIM(h.fname,right) = '', ' ',TRIM(h.fname,right) + ' ') + 
					  TRIM(h.mname,right);
  string45 company1 := h.cname[1..45];
  string45 lfm :='';
  string13 city := h.p_city_name[1..13];
  string80 cn_all := keyLib.GongDacName(h.cname);
 // string13 city_from_zip :='';
  string10 cn := '';
  h.nameasis; 
  h.st;
  VARSTRING citylist := ZipLib.ZipToCities(h.zip);
  h.__filepos;
end;

t := table(h_dist,MyFields);

// Project to get city list for each zip

lfm_rec := record

t.lfm;
t.lfmname;
t.st;
t.city;
t.company1;
t.citylist;
t.__filepos;

end;


lfm_rec use_lfm(MyFields l, unsigned1 cnt) := TRANSFORM
	self.lfm := choose(cnt, l.lfmname, l.company1);
	self := l;
end;

lfm_records := NORMALIZE(t,2,use_lfm(left,counter));

lfm_rec NormCityList1(lfm_rec L, INTEGER C) := TRANSFORM
	SELF.city := IF ( C = 1, l.city, Stringlib.StringExtract(L.citylist, C ));
	SELF := L;
END;
 
ZipCitySet1 := NORMALIZE(lfm_records(lfm<>''), (INTEGER)Stringlib.StringExtract(LEFT.citylist, 1)+1, NormCityLIst1(LEFT, COUNTER));
zcs_dist1 := distribute(ZipCitySet1, hash(city,st,lfm,__filepos));
zcs_srtd1 := sort(zcs_dist1, city, st, lfm, __filepos, local);
City_d1 := DEDUP(zcs_srtd1(city + st + lfm <> ''), city, st, lfm, __filepos, local);

kStCityLFMName	:= BUILDINDEX(City_d1,{st,city,lfm,(big_endian unsigned8 )__filepos},
								LN_property.base_key_name + 'property_search.st.city.lfmname_' + LN_Property.version_build, MOXIE, overwrite);


// Project to get city list for each zip

cn_rec := record

t.cn_all;
t.cn;
t.city;
t.st;
t.fid;
t.citylist;
t.__filepos;

end;

cn_rec use_cn(myfields l, unsigned1 cnt) := TRANSFORM
	self.cn := choose(cnt, l.cn_all[1..10], l.cn_all[11..20],l.cn_all[21..30],l.cn_all[31..40],
						   l.cn_all[41..50],l.cn_all[51..60],l.cn_all[61..70],l.cn_all[71..80]);
	self := l;
end;

cn_records := NORMALIZE(t,8,use_cn(left,counter));

cn_rec NormCityList2(cn_rec L, INTEGER C) := TRANSFORM
	SELF.city := IF ( C = 1, l.city, Stringlib.StringExtract(L.citylist, C ));
	SELF := L;
END;
 
ZipCitySet2 := NORMALIZE(cn_records(cn<>''), (INTEGER)Stringlib.StringExtract(LEFT.citylist, 1)+1, NormCityLIst2(LEFT, COUNTER));
zcs_dist2 := distribute(ZipCitySet2, hash(city,st,cn,fid,__filepos));
zcs_srtd2 := sort(zcs_dist2, city, st, cn, fid, __filepos, local);
City_d2 := DEDUP(zcs_srtd2(city + st + cn + fid <> ''), city, st, cn, fid, __filepos, local);

kStCityCNFID	:= BUILDINDEX(City_d2,{st,city,cn,fid,(big_endian unsigned8 )__filepos},
								LN_property.base_key_name + 'property_search.st.city.cn.fid_'+ LN_Property.version_build, MOXIE, overwrite);

// Project to get city list for each zip

nameasis_rec := record

t.city;
t.st;
t.nameasis;
t.__filepos;

end;

nameasis_rec NormCityList3(MyFields L, INTEGER C) := TRANSFORM
	SELF.city := IF ( C = 1, l.city, Stringlib.StringExtract(L.citylist, C ));
	SELF := L;
END;
 
ZipCitySet3 := NORMALIZE(t, (INTEGER)Stringlib.StringExtract(LEFT.citylist, 1)+1, NormCityLIst3(LEFT, COUNTER));
zcs_dist3 := distribute(ZipCitySet3, hash(city,st,nameasis,__filepos));
zcs_srtd3 := sort(zcs_dist3, city, st, nameasis, __filepos, local);
City_d3 := DEDUP(zcs_srtd3(city + st + nameasis <> ''), city, st, nameasis, __filepos, local);

kStCityNameasis	:= BUILDINDEX(City_d3,{st,city,nameasis,(big_endian unsigned8 )__filepos},
								LN_property.base_key_name + 'property_search.st.city.nameasis_'+ LN_Property.version_build, MOXIE, overwrite);
								
export Out_MoxiePropertySearchKeys_Part3
 :=
  parallel
	(
	 kStCityLFMName
	,kStCityCNFID
	,kStCityNameAsis
	)
  ;