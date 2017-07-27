import Business_Header,Lib_KeyLib;

h := Business_Header.Layout_Business_Contact_Out_Keybuild;

MyFields := record
	h.did; 
//	h.preGLB_did;
	h.bdid;
	h.ssn;
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
	h.company_city;
	h.state;
	h.company_state;
	string45 lfmname := TRIM(h.lname,right) + ' ' + IF(TRIM(h.fname,right) = '', ' ',TRIM(h.fname,right) + ' ') + TRIM(h.mname,right);
  	h.zip;
	h.company_zip;
	h.__filepos;
end;

t := table(h, MyFields);

k1 := BUILDINDEX( t(lfmname <> ''), {lfmname,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name_Contacts + 'lfmname.key',moxie, overwrite);
k2 := BUILDINDEX( t(zip <> ''), {zip,prim_name,prim_range,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name_Contacts + 'z5.prim_name.prim_range.key',moxie, overwrite);
k3 := BUILDINDEX( t(did <> ''), {did,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name_Contacts + 'did.key', moxie,overwrite);
k4 := BUILDINDEX( t(bdid <> ''), {bdid,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name_Contacts + 'bdid.key', moxie,overwrite);
//BUILDINDEX( t, {preGLB_did,(big_endian unsigned8 )__filepos},
//			Business_Header.Base_Key_Name_Contacts + 'preglb_did.key', moxie,overwrite);
k5 := BUILDINDEX( t(ssn <> ''), {ssn,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name_Contacts + 'ssn.key', moxie,overwrite);
k6 := BUILDINDEX( t(zip <> ''), {zip,prim_name,addr_suffix,predir,postdir,prim_range,sec_range,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name_Contacts + 'z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key', moxie,overwrite);
			
// made changes to these keys to include the company state and city	
st_rec := record
	t.lfmname;
	t.state;
	t.city;
	t.company_state;
	t.company_city;
	string25 city_all := '';
	string2 state_all := '';
	string5 zip_all := '';
	t.__filepos;
end;

st_rec use_st(MyFields l, unsigned1 cnt) := TRANSFORM
	self.city_all := choose(cnt, l.city[1..13], l.company_city[1..13]);
	self.state_all := choose(cnt, l.state, l.company_state);
	self.zip_all := choose(cnt, l.zip, l.company_zip);
	self := l;
end;

st_records := NORMALIZE(t,2,use_st(left,counter));
k7 := BUILDINDEX( st_records(state_all <> ''), {state_all,lfmname,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name_Contacts + 'st.lfmname.key',moxie, overwrite);
			
			
ZipCitiesRec := record
  st_records.city_all;
  st_records.state_all;
  st_records.lfmname;
  st_records.zip_all;
  VARSTRING citylist;
  st_records.__filepos;
end;

// Project to get city list for each zip
ZipCitiesRec GetCityList(st_records L) := TRANSFORM
	SELF.citylist := ZipLib.ZipToCities(L.zip_all);
	SELF:= L;
END;
 
ZipCitiesSet := PROJECT(st_records, GetCityList(LEFT));

ZipCityRec := RECORD
  ZipCitiesSet.city_all;
  ZipCitiesSet.state_all;
  ZipCitiesSet.lfmname;
  string25 city_from_zip;
  ZipCitiesSet.__filepos;
END;
 
ZipCityRec NormCityList(ZipCitiesRec L, INTEGER C) := TRANSFORM
	SELF.city_from_zip := IF ( C = 1, l.city_all, Stringlib.StringExtract(L.citylist, C ));
	SELF := L;
END;
 
ZipCitySet	:= distribute(ZipCitiesSet,hash(__filepos));
ZCS_Norm	:= normalize(ZipCitySet,(INTEGER)Stringlib.StringExtract(LEFT.citylist, 1)+1, NormCityLIst(LEFT, COUNTER));			
			
			
k8 := BUILDINDEX( ZCS_Norm(state_all <> ''), {state_all,city_from_zip,lfmname,(big_endian unsigned8 )__filepos},
			Business_Header.Base_Key_Name_Contacts + 'st.city.lfmname.key', moxie,overwrite);

/////////////////////////////////////////////////			
// FPOS DATA KEY	
/////////////////////////////////////////////////			
unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(Business_Header.Layout_Business_Contact_Out) * count(h) : global;
headersize := sizeof(Business_Header.Layout_Business_Contact_Out) : global;

dfile := INDEX(h,{f:= moxietransform(__filepos, rawsize, headersize)},{h},Business_Header.Base_Key_Name_Contacts + 'fpos.data.key');

k9 := buildindex(dfile,moxie,overwrite);


export MOXIE_BH_Contacts_Keys := parallel(k1,k2,k3,k4,k5,k6,k7,k8,k9);