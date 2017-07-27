import header,Lib_KeyLib;
#workunit ('name', 'Build header key 5');

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

id_rec := RECORD
  t.did;
  t.rec_type;
  t.__filepos;
end;

id_records := table(t((rec_type = '1' OR rec_type = '2') AND 
							((dt_nonglb_last_seen <> '') OR
							(dt_first_seen < '200107'))), id_rec);
// Key #23
Key5a	:= BUILDINDEX(id_records,,header.base_key_name + 'uniqueid.rec_type.key',moxie,overwrite);

/*glbid_rec := RECORD
   t.__filepos;
end;

glbid_records := table(t, glbid_rec);
Key5b	:= BUILDINDEX(glbid_records,,header.base_key_name + 'pgid.key',moxie,overwrite);
*/
dob_recs := RECORD
  string45 lfmname := Lib_KeyLib.KeyLib.KeylibStripPunctuation(t.lfmname);
  t.fname;
  t.st;
  t.zip;
  t.dob;
  t.__filepos;
end;

dob_records := table(t((dob[7..7] <> ' ' AND dob[8..8] <> ' ') AND (dob[7..7] <> '0' OR dob[8..8] <> '0')), dob_recs);

Key5c	:= BUILDINDEX(dob_records,{dob,lfmname,(big_endian unsigned8 )__filepos},header.base_key_name + 'dob.lfmname.key',moxie,overwrite);
Key5d	:= BUILDINDEX(dob_records,{dob,fname,(big_endian unsigned8 )__filepos},header.base_key_name + 'dob.fname.key',moxie,overwrite);
Key5e	:= BUILDINDEX(dob_records,{st,dob,fname,(big_endian unsigned8 )__filepos},header.base_key_name + 'st.dob.fname.key',moxie,overwrite);
Key5f	:= BUILDINDEX(dob_records,{zip,dob,fname,(big_endian unsigned8 )__filepos},header.base_key_name + 'zip.dob.fname.key',moxie,overwrite);

export MOXIE_Header_Keys_Part_5
 :=
  parallel(
			   Key5a
			//  ,Key5b
			  ,Key5c
			  ,Key5d
			  ,Key5e
			  ,Key5f
		   )
 ;