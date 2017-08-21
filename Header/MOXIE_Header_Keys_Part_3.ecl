import header,Lib_KeyLib;
#workunit ('name', 'Build header key 3');

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

phone_rec := record
  t.phone;
  t.__filepos;
  end;

// "right justify" the phone field
phone_rec phone_right_justify(MyFields l) := TRANSFORM
  SELF.phone := if(l.phone <> '' AND l.phone[8..10] = '   ','000' + l.phone[1..7], l.phone);
  SELF := l;
  end;

phone_records := PROJECT(t, phone_right_justify(LEFT));

// Key #8
Key3a	:= BUILDINDEX(phone_records,,header.base_key_name + 'phone.key',moxie,overwrite);

// "The Big key"
key_10 := record
  t.zip;
  t.prim_name;
  t.prim_range;
  t.lfmname;
  t.ssn;
  t.__filepos;
  end;

//Key #10
key_10_records := table(t,key_10);			// Build the key, even the ssn is blank
Key3b	:= BUILDINDEX(key_10_records,,header.base_key_name + 'zip.street_name.prim_range.lfmname.ssn.key',moxie,overwrite);


keys_14_15_rec := record
  string45 lfmname := KeyLib.KeylibStripPunctuation(t.lfmname);
  string6 dph_lname;
  t.st;
  t.dob_year;
  t.dob_month;
  t.ssn4;
  t.__filepos;
  end;	

// DOB_Year & DOB_Month Keys
keys_14_15_rec d_ph(MyFields l, unsigned1 cnt) := TRANSFORM
  self.dph_lname := choose(cnt, l.dph_lname1, l.dph_lname2);
  self := l;
end;

dob_year := NORMALIZE(t, 2, d_ph(left, counter));
dob_duped := DEDUP(dob_year,dph_lname,__filepos,all);

//Key #14
Key3c	:= BUILDINDEX(dob_duped,{dob_year,dob_month,dph_lname,lfmname,(big_endian unsigned8 )__filepos},
		   header.base_key_name + 'dob_year.dob_month.dph_lname.lfmname.key',moxie,overwrite);

//Key #15
Key3d	:= BUILDINDEX(dob_duped,{st,dob_year,dob_month,dph_lname,lfmname,(big_endian unsigned8 )__filepos},
		   header.base_key_name + 'st.dob_year.dob_month.dph_lname.lfmname.key',moxie,overwrite);

// Special 4 byte SSN key
short_ssn_rec := record
  t.ssn4;
  t.lfmname;
  t.__filepos;
  end;	

short_ssn_records := table(t((integer)ssn<>0),short_ssn_rec);
//Key #16
Key3e	:= BUILDINDEX(short_ssn_records,,header.base_key_name + 'ssn4.lfmname.key',moxie,overwrite);

export MOXIE_Header_Keys_Part_3
 :=
  parallel(
/*			   Key3a  --NO LONGER NEEDED
			  ,*/Key3b
			  ,Key3c
			  ,Key3d
			  ,Key3e
		   )
 ;