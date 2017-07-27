import header,Lib_KeyLib;
#workunit ('name', 'Build header key 4');

h := header.File_OUT_plus;			// Unix despray version 292 byte layout

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
  h.unit_desig;
  h.tnt;
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

// These are the very long moxie Matching keys
// These keys also use "punctuation removed" cityname fields - Non standard
matching_rec := record	
  t.zip;
  t.name_first;
  t.name_middle;
  t.lname;
  t.name_suffix;
  t.prim_range;
  t.predir;
  t.sec_range;
  t.st;
  t.st_name;
  t.unit_desig;
  t.tnt;
  string13 city := KeyLib.KeylibStripPunctuation(t.city);
  t.rec_type;
  t.dt_nonglb_last_seen;
  t.dt_first_seen;
  string6 dph_lname := '';
  t.dph_city;
  t.dph_street;
  t.__filepos;
end;

matching_rec matching_ph(MyFields l, unsigned1 cnt) := TRANSFORM
  self.dph_lname := choose(cnt, l.dph_lname1, l.dph_lname2);
  self := l;
end;

m_records := NORMALIZE(t, 2, matching_ph(left, counter));

matching_records := DEDUP(m_records((rec_type = '1' OR rec_type = '2') AND 
							((dt_nonglb_last_seen <> ' ') OR
							(dt_first_seen < '200107'))),__filepos,all);

matching_records_lname := DEDUP(m_records((rec_type = '1' OR rec_type = '2') AND 
							((dt_nonglb_last_seen <> ' ') OR
							(dt_first_seen < '200107'))),dph_lname,__filepos,all);

// KEY #17
Key4a	:= BUILDINDEX(matching_records_lname,{dph_lname,zip,name_first,name_middle,lname,name_suffix,prim_range,predir,st_name,
							 sec_range,city,st,zip2 := zip,rec_type,unit_desig,tnt,(big_endian unsigned8 )__filepos},
			header.base_key_name + 'pln.z5.match.key',moxie,overwrite);

// KEY #18
Key4b	:= BUILDINDEX(matching_records_lname,{st,dph_lname,dph_city,name_first,name_middle,lname,name_suffix,prim_range,predir,st_name,
							 sec_range,city,st2 := st,zip,rec_type,unit_desig,tnt,(big_endian unsigned8 )__filepos},
			header.base_key_name + 'st.pln.pct.match.key',moxie,overwrite);

// KEY #19
Key4c	:= BUILDINDEX(matching_records_lname,{dph_lname,prim_range,dph_street,name_first,name_middle,lname,name_suffix,p2 := prim_range,predir,st_name,
							 sec_range,city,st,zip,rec_type,unit_desig,tnt,(big_endian unsigned8 )__filepos},
			header.base_key_name + 'pln.pr.pst.match.key',moxie,overwrite);

// KEY #20
Key4d	:= BUILDINDEX(matching_records,{prim_range,zip,name_first,name_middle,lname,name_suffix,p2 := prim_range,predir,st_name,
							 sec_range,city,st,zip2 := zip,rec_type,unit_desig,tnt,(big_endian unsigned8 )__filepos},
			header.base_key_name + 'pr.z5.match.key',moxie,overwrite);

// KEY #21
Key4e	:= BUILDINDEX(matching_records,{prim_range,st,dph_city,name_first,name_middle,lname,name_suffix,p2 := prim_range,predir,st_name,
							 sec_range,city,st2 := st,zip,rec_type,unit_desig,tnt,(big_endian unsigned8 )__filepos},
			header.base_key_name + 'pr.st.pct.match.key',moxie,overwrite);

// KEY #22
Key4f	:= BUILDINDEX(matching_records_lname,{st,dph_lname,name_first,name_middle,lname,name_suffix,prim_range,predir,st_name,
							 sec_range,city,st2 := st,zip,rec_type,unit_desig,tnt,(big_endian unsigned8 )__filepos},
			header.base_key_name + 'st.pln.match.key',moxie,overwrite);

export MOXIE_Header_Keys_Part_4
 :=
  parallel(
			   Key4a
			  ,Key4b
			  ,Key4c
			  ,Key4d
			  ,Key4e
			  ,Key4f
		   )
 ;