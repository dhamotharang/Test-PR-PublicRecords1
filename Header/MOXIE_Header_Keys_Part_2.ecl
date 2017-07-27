import header,Lib_KeyLib;
#workunit ('name', 'Build header key 2');

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

// Address keys
//addr_rec := record
//   t.st;
//   t.zip;
//   t.city_name;
//   t.prim_name;
//   t.suffix;
//   t.prim_range;
//   t.predir;
//   t.postdir; 
//   t.lname;
//   t.sec_range;
//   t.__filepos;
//   end;

//addr_records := table(t,addr_rec);

// Key # 6 - Not needed anymore per Mike W. email 3/10/2003
//BUILDINDEX(addr_records,{st,city_name,prim_name,suffix,prim_range,(big_endian unsigned8 )__filepos},
//			header.base_key_name + 'st.city_name.street_name.suffix.prim_range.key',overwrite);
// Key # 9
// Not needed anymore per Mike W. email 7/23/2003
//BUILDINDEX(addr_records,{zip,prim_name,suffix,predir,postdir,prim_range,lname,sec_range,(big_endian unsigned8 )__filepos},
//			header.base_key_name + 'zip.street_name.suffix.predir.postdir.prim_range.lname.sec_range.key',overwrite);

// These ph keys use "punctuation removed" cityname fields - Non standard

ph_name_dob := record
  t.st;
  t.zip;
  string13 city := KeyLib.KeylibStripPunctuation(t.city);
  string6 dph_lname;   
  t.name_first;
  t.name_middle;
  t.lname;
  t.dob;
  t.__filepos;
  end;

ph_name_dob double_ph(MyFields l, unsigned1 cnt) := TRANSFORM
  self.dph_lname := choose(cnt, l.dph_lname1, l.dph_lname2);
  self := l;
end;

n := NORMALIZE(t,2,double_ph(left,counter));
n_duped := DEDUP(n,dph_lname,__filepos,all);
  

// Key #7
Key2a	:= BUILDINDEX(n_duped,{dph_lname,name_first,name_middle,lname,dob,(big_endian unsigned8 )__filepos},
			header.base_key_name + 'dph_lname.name_first.name_middle.name_last.dob.key',moxie,overwrite);

// Key #11
Key2b	:= BUILDINDEX(n_duped,{zip,dph_lname,name_first,name_middle,lname,dob,(big_endian unsigned8 )__filepos},
			header.base_key_name + 'zip.dph_lname.name_first.name_middle.name_last.dob.key',moxie,overwrite);

// Key #12
Key2c	:= BUILDINDEX(n_duped,{st,dph_lname,name_first,name_middle,lname,dob,(big_endian unsigned8 )__filepos},
			header.base_key_name + 'st.dph_lname.name_first.name_middle.name_last.dob.key',moxie,overwrite);

export MOXIE_Header_Keys_Part_2
 :=
  parallel(
			   Key2a
			  ,Key2b
			  ,Key2c
		   )
 ;