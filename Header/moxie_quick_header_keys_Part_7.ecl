import header, lib_KeyLib, Lib_ZipLib;

h := header.File_EQ_OUT_plus;			// Unix despray version 292 byte layout

MyFields := record					// Fields needed to build all keys	
  h.did;							// This would be "keymaps" section of Unix def file
  h.zip;
  h.prim_name;
  h.prim_range;
  h.city_name;
  h.suffix;
  h.predir;
  h.postdir;
  h.sec_range;
  h.st;
  h.lname;
  h.fname;
  h.mname;
  h.name_suffix;
  h.ssn;
  h.dob;
  h.phone;
  string6  dph_lname1 := metaphonelib.DMetaPhone1(h.lname);
  string6  dph_lname2 := metaphonelib.DMetaPhone2(h.lname);
  string5  dph_city := metaphonelib.DMetaPhone1(h.city_name);
  string5  dph_street := metaphonelib.DMetaPhone1(h.prim_name);
  // ****
  // Can't use the stringlib funtion, since Moxie lfmname function works little differently
  // string45 lfmname := stringlib.stringcleanspaces(h.lname+h.fname+h.mname);
  string45 lfmname := TRIM(h.lname,right) + ' ' + IF(TRIM(h.fname,right) = '', ' ',TRIM(h.fname,right) + ' ') + 
					  TRIM(h.mname,right);
  string12 st_name := h.prim_name[1..12];
  string4  dob_year := h.dob[1..4];
  string2  dob_month := h.dob[5..6];
  string4  ssn4 := h.ssn[6..9];
  string11 name_first := h.fname[1..11];
  string11 name_middle := h.mname[1..11];
  string13 city := h.city_name[1..13];
  h.rec_type;						// These are needed to filter records for "matching" keys
  h.dt_nonglb_last_seen;			// Rec type must be (1 or 2) AND dt_nonglb_last_seen must be non-blank	
  h.dt_first_seen;					// AND dt_first_seen must be < '200107'
  h.__filepos;
  end;

t := table(h,MyFields);

ZipCitiesRec := record
  t.city_name;
  t.st;
  t.lfmname;
  t.zip;
  t.dob;
  t.fname;
  t.lname;
  t.name_first;
  t.name_middle;
  t.dph_lname1;
  t.dph_lname2;
  VARSTRING citylist;
  t.__filepos;
end;

// Project to get city list for each zip
ZipCitiesRec GetCityList(t L) := TRANSFORM
	SELF.citylist := ZipLib.ZipToCities(L.zip);
	SELF:= L;
END;
 
ZipCitiesSet := PROJECT(t, GetCityList(LEFT));

ZipCityRec := RECORD
  t.city_name;
  t.st;
  t.lfmname;
  t.zip;
  t.dob;
  t.fname;
  t.lname;
  t.name_first;
  t.name_middle;
  t.dph_lname1;
  t.dph_lname2;
  string13 city_from_zip;
  t.__filepos;
END;
 
ZipCityRec NormCityList(ZipCitiesRec L, INTEGER C) := TRANSFORM
	SELF.city_from_zip := IF ( C = 1, l.city_name, Stringlib.StringExtract(L.citylist, C ));
	SELF := L;
END;
 
ZipCitySet	:= distribute(ZipCitiesSet,hash(__filepos));
ZCS_Norm	:= normalize(ZipCitySet,(INTEGER)Stringlib.StringExtract(LEFT.citylist, 1)+1, NormCityLIst(LEFT, COUNTER));
zcs_srtd	:= sort(ZCS_Norm, city_from_zip, st, lfmname,__filepos, local);
City_dedup	:= dedup(zcs_srtd, city_from_zip, st, lfmname,__filepos, local);

ph_name_dob := record
  ZipCityRec.city_from_zip;
  ZipCityRec.st;
  string6 dph_lname;   
  ZipCityRec.name_first;
  ZipCityRec.name_middle;
  ZipCityRec.lname;
  ZipCityRec.dob;
  ZipCityRec.__filepos;
  end;

ph_name_dob double_ph(ZipCityRec l, unsigned1 cnt) := TRANSFORM
  self.dph_lname := choose(cnt, l.dph_lname1, l.dph_lname2);
  self := l;
end;

n_norm	:= normalize(City_dedup, 2, double_ph(left,counter));
n_srtd	:= sort(n_norm, st, city_from_zip, dph_lname, name_first, name_middle, lname, dob, __filepos, local);
n_dedup := dedup(n_srtd, st, city_from_zip, dph_lname, name_first, name_middle, lname, dob, __filepos, local);


Key7a	:= BUILDINDEX(City_dedup,{st,city_from_zip,lfmname,dob,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.eq_header.st.city.lfmname.dob.key',moxie,overwrite);
Key7b	:= BUILDINDEX(City_dedup,{st,city_from_zip,dob,fname,(big_endian unsigned8 )__filepos},'~thor_data400::key::moxie.eq_header.st.city.dob.fname.key',moxie,overwrite);
Key7c	:= BUILDINDEX(n_dedup,{st,city_from_zip,dph_lname,name_first,name_middle,lname,dob,(big_endian unsigned8 )__filepos},
			'~thor_data400::key::moxie.eq_header.st.city.dph_lname.name_first.name_middle.name_last.dob.key',moxie,overwrite);

export moxie_quick_header_keys_Part_7 :=parallel(
			   Key7a
			  ,Key7b
			  ,Key7c
		   )
 ;