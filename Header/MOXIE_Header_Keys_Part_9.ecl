import header,Lib_KeyLib;
#workunit ('name', 'Build header key 9');

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
  h.county;
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

county_fields := record
  t.st;
  t.lfmname;
  t.county;
  t.__filepos;
  end;

ph_county := record
  t.st;
  t.county;
  string6 dph_lname;
  t.name_first;
  t.name_middle;
  t.lname;
  t.dob;
  t.__filepos;
end;

county_lfmname_recs := table(t,county_fields);
Key9a	:= BUILDINDEX(county_lfmname_recs,{st,county,lfmname,(big_endian unsigned8 )__filepos},
header.base_key_name + 'st.county.lfmname.key',moxie,overwrite);

ph_county double_ph(MyFields l, unsigned1 cnt) := TRANSFORM
  self.dph_lname := choose(cnt, l.dph_lname1, l.dph_lname2);
  self := l;
end;

n_dist	:= distribute(t,hash(__filepos));
n_norm	:= normalize(n_dist,2,double_ph(left,counter));
n_sort	:= sort(n_norm,st,county,dph_lname,name_first,name_middle,lname,dob,__filepos, local);
n_duped	:= dedup(n_sort,st,county,dph_lname,name_first,name_middle,lname,dob,__filepos,local);



Key9b	:= BUILDINDEX(n_duped,{st,county,dph_lname,name_first,name_middle,lname,dob,(big_endian unsigned8 )__filepos},
header.base_key_name + 'st.county.dph_lname.name_first.name_middle.name_last.dob.key',moxie,overwrite);

export MOXIE_Header_Keys_Part_9
 :=
  parallel(
			   Key9a
			  ,Key9b
		   )
 ;