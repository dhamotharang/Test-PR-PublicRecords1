import header,Lib_KeyLib;
#workunit ('name', 'Build header key 1');

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
  string7  phone7 := if(length(trim(h.phone)) = 7 ,h.phone[1..7], h.phone[4..10]); 
  string3  area_code := if(length(trim(h.phone)) = 7 ,'', h.phone[1..3]); 

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
  string5  ssn5 := h.ssn[1..5];
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

// Moxie key numbers, so that they are easier to find
// Key #0	
did_rec := record
  t.did;
  t.__filepos;
  end;
did_records := table(t,did_rec);
Key1a	:= BUILDINDEX(did_records,,header.base_key_name + 'did.key',moxie,overwrite);

// Key #2
ssn_rec := record
  t.ssn;
  t.fname;
  t.__filepos;
  end;

ssn_records := table(t((integer)ssn<>0),ssn_rec);	// No blank ssn's
Key1b	:= BUILDINDEX(ssn_records,{ssn,fname,(big_endian unsigned8 )__filepos},header.base_key_name + 'ssn.fname.key',moxie,overwrite);

// Key #1,3,4,5
st_lfmname_fields := record
  t.st;
  t.lfmname;
  t.zip;
  t.phone7;
  t.area_code;
  t.ssn5;
  t.__filepos;
  end;

st_lfmname_recs := table(t,st_lfmname_fields);
Key1c	:= BUILDINDEX(st_lfmname_recs,{lfmname,(big_endian unsigned8 )__filepos},header.base_key_name + 'lfmname.key',moxie,overwrite);
Key1d	:= BUILDINDEX(st_lfmname_recs,{st,lfmname,(big_endian unsigned8 )__filepos},header.base_key_name + 'st.lfmname.key',moxie,overwrite);
Key1e	:= BUILDINDEX(st_lfmname_recs,{zip,lfmname,(big_endian unsigned8 )__filepos},header.base_key_name + 'zip.lfmname.key',moxie,overwrite);
Key1f	:= BUILDINDEX(st_lfmname_recs,{phone7,(big_endian unsigned8 )__filepos},header.base_key_name + 'phone7.key',moxie,overwrite);
Key1g	:= BUILDINDEX(st_lfmname_recs,{st,phone7,(big_endian unsigned8 )__filepos},header.base_key_name + 'st.phone7.key',moxie,overwrite);
Key1h	:= BUILDINDEX(st_lfmname_recs,{phone7,area_code,st,(big_endian unsigned8 )__filepos},header.base_key_name + 'phone7.area_code.st.key',moxie,overwrite);
Key1l	:= BUILDINDEX(st_lfmname_recs,{ssn5,lfmname,(big_endian unsigned8 )__filepos},header.base_key_name + 'ssn5.lfmname.key',moxie,overwrite);

export MOXIE_Header_Keys_Part_1
 :=
  parallel(
			   Key1a
			  ,Key1b
			  ,Key1c
			  ,Key1d
			  ,Key1e
			  ,/*Key1f
			  ,Key1g
			  ,*/Key1h
			  ,Key1l
		   )
 ;