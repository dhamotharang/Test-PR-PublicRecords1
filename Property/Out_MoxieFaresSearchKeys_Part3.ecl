import property,Lib_KeyLib;
#workunit ('name', 'Build Fares Search File Keys 3');

string_rec := record
	property.Layout_prop_out;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

h := DATASET(property.Filename_Fares_DID_Out, string_rec, THOR);


MyFields := record		
  h.did;
  string12 fid := h.fares_id;
  string45 lfmname := TRIM(h.lname,right) + ' ' + IF(TRIM(h.fname,right) = '', ' ',TRIM(h.fname,right) + ' ') + 
					  TRIM(h.mname,right);
  string45 company1 := h._company[1..45];
  string45 lfm :='';
  string13 city := h.p_city_name[1..13];
  string80 cn_all := keyLib.GongDacName(h._company);
  string13 city_from_zip :='';
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
  VARSTRING citylist := '';
  h.__filepos;
end;

t := table(h,MyFields);

MyFields use_lfm(MyFields l, unsigned1 cnt) := TRANSFORM
	self.lfm := choose(cnt, l.lfmname, l.company1);
	self := l;
end;

lfm_records := NORMALIZE(t,2,use_lfm(left,counter));

// Project to get city list for each zip
MyFields GetCityList1(t L) := TRANSFORM
	SELF.citylist := ZipLib.ZipToCities(L.zip);
	SELF:= L;
END;
 
ZipCitiesSet1 := PROJECT(lfm_records(lfm<>''), GetCityList1(LEFT));

MyFields NormCityList1(MyFields L, INTEGER C) := TRANSFORM
	SELF.city_from_zip := IF ( C = 1, l.city, Stringlib.StringExtract(L.citylist, C ));
	SELF := L;
END;
 
ZipCitySet1 := NORMALIZE(ZipCitiesSet1, (INTEGER)Stringlib.StringExtract(LEFT.citylist, 1)+1, NormCityLIst1(LEFT, COUNTER));
zcs_dist1 := distribute(ZipCitySet1, hash(city_from_zip,st,lfm,__filepos));
zcs_srtd1 := sort(zcs_dist1, city_from_zip, st, lfm, __filepos, local);
City_d1 := DEDUP(zcs_srtd1, city_from_zip, st, lfm, __filepos, local);

kStCityLFMName	:= BUILDINDEX(City_d1,{st,city_from_zip,lfm,(big_endian unsigned8 )__filepos},
								property.base_key_name + 'st.city.lfmname.key', MOXIE, overwrite);


// Project to get city list for each zip
MyFields use_cn(MyFields l, unsigned1 cnt) := TRANSFORM
	self.cn := choose(cnt, l.cn_all[1..10], l.cn_all[11..20],l.cn_all[21..30],l.cn_all[31..40],
						   l.cn_all[41..50],l.cn_all[51..60],l.cn_all[61..70],l.cn_all[71..80]);
	self := l;
end;

cn_records := NORMALIZE(t,8,use_cn(left,counter));

MyFields GetCityList2(t L) := TRANSFORM
	SELF.citylist := ZipLib.ZipToCities(L.zip);
	SELF:= L;
END;
 
ZipCitiesSet2 := PROJECT(cn_records(cn<>''), GetCityList2(LEFT));

MyFields NormCityList2(MyFields L, INTEGER C) := TRANSFORM
	SELF.city_from_zip := IF ( C = 1, l.city, Stringlib.StringExtract(L.citylist, C ));
	SELF := L;
END;
 
ZipCitySet2 := NORMALIZE(ZipCitiesSet2, (INTEGER)Stringlib.StringExtract(LEFT.citylist, 1)+1, NormCityLIst2(LEFT, COUNTER));
zcs_dist2 := distribute(ZipCitySet2, hash(city_from_zip,st,cn,fid,__filepos));
zcs_srtd2 := sort(zcs_dist2, city_from_zip, st, cn, fid, __filepos, local);
City_d2 := DEDUP(zcs_srtd2, city_from_zip, st, cn, fid, __filepos, local);

kStCityCNFID	:= BUILDINDEX(City_d2,{st,city_from_zip,cn,fid,(big_endian unsigned8 )__filepos},
								property.base_key_name + 'st.city.cn.fid.key', MOXIE, overwrite);


MyFields GetCityList3(t L) := TRANSFORM
	SELF.citylist := ZipLib.ZipToCities(L.zip);
	SELF:= L;
END;
 
ZipCitiesSet3 := PROJECT(t, GetCityList3(LEFT));

MyFields NormCityList3(MyFields L, INTEGER C) := TRANSFORM
	SELF.city_from_zip := IF ( C = 1, l.city, Stringlib.StringExtract(L.citylist, C ));
	SELF := L;
END;
 
ZipCitySet3 := NORMALIZE(ZipCitiesSet3, (INTEGER)Stringlib.StringExtract(LEFT.citylist, 1)+1, NormCityLIst3(LEFT, COUNTER));
zcs_dist3 := distribute(ZipCitySet3, hash(city_from_zip,st,nameasis,__filepos));
zcs_srtd3 := sort(zcs_dist3, city_from_zip, st, nameasis, __filepos, local);
City_d3 := DEDUP(zcs_srtd3, city_from_zip, st, nameasis, __filepos, local);

kStCityNameasis	:= BUILDINDEX(City_d3,{st,city_from_zip,nameasis,(big_endian unsigned8 )__filepos},
								property.base_key_name + 'st.city.nameasis.key', MOXIE, overwrite);
								
export Out_MoxieFaresSearchKeys_Part3
 :=
  parallel
	(
	 kStCityLFMName
	,kStCityCNFID
	,kStCityNameAsis
	)
  ;