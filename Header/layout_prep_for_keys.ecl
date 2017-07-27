IMPORT doxie_build, ut, NID,lib_metaphone, header;

//h := dataset('~thor_data400::Base::HeaderKey_Building',header.Layout_Header,flat);
//  Bug 12065, use blocked data filter on header instead of raw data
h := doxie_build.file_header_building;

export layout_prep_for_keys := record
  h.zip;
  qstring28 prim_name := ut.StripOrdinal(h.prim_name);
  h.prim_range;
  h.city_name;
  h.st;
  h.lname;
  h.mname;
  h.fname;
  typeof(h.fname) pfname := NID.PreferredFirstVersionedStr(h.fname, NID.version);
  h.ssn;
	h.valid_ssn;
  h.phone;
  string6  dph_lname := metaphonelib.DMetaPhone1(h.lname);
  h.did;
  h.rid;
  h.dob;
  unsigned2 yob := h.dob div 10000;
  h.sec_range;
  unsigned8 states := 0;
  unsigned4 lname1 := 0;
  unsigned4 lname2 := 0;
  unsigned4 lname3 := 0;
  unsigned4 fname1 := 0;
  unsigned4 fname2 := 0;
  unsigned4 fname3 := 0;
  unsigned4 city1 := 0;
  unsigned4 city2 := 0;
  unsigned4 city3 := 0;
  unsigned4 rel_fname1 := 0;
  unsigned4 rel_fname2 := 0;
  unsigned4 rel_fname3 := 0; 
  unsigned6 first_seen := header.get_header_first_seen(h);
  unsigned6 last_seen := header.get_header_last_seen(h);
  h.dt_nonglb_last_seen;
  unsigned4 lookups := 0;
  end;