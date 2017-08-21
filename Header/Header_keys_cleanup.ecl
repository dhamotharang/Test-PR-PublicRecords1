import lib_fileservices;

// Deletes all the Full Header keys 

DeleteHeaderKeys(string KeyFileName)
 :=
  if(lib_fileservices.fileservices.FileExists(KeyFileName),
	 lib_fileservices.FileServices.DeleteLogicalFile(KeyFileName),
	 output(KeyFileName + ' does not exist')
	)
 ;

moxie_key_prefix := '~thor_data400::key::moxie.header.';
qh_key_prefix    := '~thor_data400::key::moxie.eq_header.';

export Header_keys_cleanup := parallel(
//Full Header
DeleteHeaderKeys(moxie_key_prefix+'did.key'),
DeleteHeaderKeys(moxie_key_prefix+'dob.fname.key'),
DeleteHeaderKeys(moxie_key_prefix+'dob.lfmname.key'),
DeleteHeaderKeys(moxie_key_prefix+'dob_year.dob_month.dph_lname.lfmname.key'),
DeleteHeaderKeys(moxie_key_prefix+'dph_lname.name_first.name_middle.name_last.dob.key'),
DeleteHeaderKeys(moxie_key_prefix+'fpos.data.key'),
DeleteHeaderKeys(moxie_key_prefix+'lfmname.key'),
DeleteHeaderKeys(moxie_key_prefix+'phone7.area_code.st.key'),
DeleteHeaderKeys(moxie_key_prefix+'pln.pr.pst.match.key'),
DeleteHeaderKeys(moxie_key_prefix+'pln.z5.match.key'),
DeleteHeaderKeys(moxie_key_prefix+'pr.st.pct.match.key'),
DeleteHeaderKeys(moxie_key_prefix+'pr.z5.match.key'),
DeleteHeaderKeys(moxie_key_prefix+'really_long.key'),
DeleteHeaderKeys(moxie_key_prefix+'ssn.fname.key'),
DeleteHeaderKeys(moxie_key_prefix+'ssn4.lfmname.key'),
DeleteHeaderKeys(moxie_key_prefix+'ssn5.lfmname.key'),
DeleteHeaderKeys(moxie_key_prefix+'st.city.dob.fname.key'),
DeleteHeaderKeys(moxie_key_prefix+'st.city.dph_lname.name_first.name_middle.name_last.dob.key'),
DeleteHeaderKeys(moxie_key_prefix+'st.city.lfmname.dob.key'),
DeleteHeaderKeys(moxie_key_prefix+'st.county.dph_lname.name_first.name_middle.name_last.dob.key'),
DeleteHeaderKeys(moxie_key_prefix+'st.county.lfmname.key'),
DeleteHeaderKeys(moxie_key_prefix+'st.dob.fname.key'),
DeleteHeaderKeys(moxie_key_prefix+'st.dob_year.dob_month.dph_lname.lfmname.key'),
DeleteHeaderKeys(moxie_key_prefix+'st.dph_lname.name_first.name_middle.name_last.dob.key'),
DeleteHeaderKeys(moxie_key_prefix+'st.lfmname.key'),
DeleteHeaderKeys(moxie_key_prefix+'st.pln.match.key'),
DeleteHeaderKeys(moxie_key_prefix+'st.pln.pct.match.key'),
DeleteHeaderKeys(moxie_key_prefix+'uniqueid.rec_type.key'),
DeleteHeaderKeys(moxie_key_prefix+'zip.dob.fname.key'),
DeleteHeaderKeys(moxie_key_prefix+'zip.dph_lname.name_first.name_middle.name_last.dob.key'),
DeleteHeaderKeys(moxie_key_prefix+'zip.lfmname.key'),
DeleteHeaderKeys(moxie_key_prefix+'zip.street_name.prim_range.lfmname.ssn.key'),
//Quick Header
DeleteHeaderKeys(qh_key_prefix+'did.key'),
DeleteHeaderKeys(qh_key_prefix+'dob.fname.key'),
DeleteHeaderKeys(qh_key_prefix+'dob.lfmname.key'),
DeleteHeaderKeys(qh_key_prefix+'dob_year.dob_month.dph_lname.lfmname.key'),
DeleteHeaderKeys(qh_key_prefix+'dph_lname.name_first.name_middle.name_last.dob.key'),
DeleteHeaderKeys(qh_key_prefix+'fpos.data.key'),
DeleteHeaderKeys(qh_key_prefix+'lfmname.key'),
DeleteHeaderKeys(qh_key_prefix+'phone7.area_code.st.key'),
DeleteHeaderKeys(qh_key_prefix+'pln.pr.pst.match.key'),
DeleteHeaderKeys(qh_key_prefix+'pln.z5.match.key'),
DeleteHeaderKeys(qh_key_prefix+'pr.st.pct.match.key'),
DeleteHeaderKeys(qh_key_prefix+'pr.z5.match.key'),
DeleteHeaderKeys(qh_key_prefix+'really_long.key'),
DeleteHeaderKeys(qh_key_prefix+'ssn.fname.key'),
DeleteHeaderKeys(qh_key_prefix+'ssn4.lfmname.key'),
DeleteHeaderKeys(qh_key_prefix+'ssn5.lfmname.key'),
DeleteHeaderKeys(qh_key_prefix+'st.city.dob.fname.key'),
DeleteHeaderKeys(qh_key_prefix+'st.city.dph_lname.name_first.name_middle.name_last.dob.key'),
DeleteHeaderKeys(qh_key_prefix+'st.city.lfmname.dob.key'),
DeleteHeaderKeys(qh_key_prefix+'st.county.dph_lname.name_first.name_middle.name_last.dob.key'),
DeleteHeaderKeys(qh_key_prefix+'st.county.lfmname.key'),
DeleteHeaderKeys(qh_key_prefix+'st.dob.fname.key'),
DeleteHeaderKeys(qh_key_prefix+'st.dob_year.dob_month.dph_lname.lfmname.key'),
DeleteHeaderKeys(qh_key_prefix+'st.dph_lname.name_first.name_middle.name_last.dob.key'),
DeleteHeaderKeys(qh_key_prefix+'st.lfmname.key'),
DeleteHeaderKeys(qh_key_prefix+'st.pln.match.key'),
DeleteHeaderKeys(qh_key_prefix+'st.pln.pct.match.key'),
DeleteHeaderKeys(qh_key_prefix+'uniqueid.rec_type.key'),
DeleteHeaderKeys(qh_key_prefix+'zip.dob.fname.key'),
DeleteHeaderKeys(qh_key_prefix+'zip.dph_lname.name_first.name_middle.name_last.dob.key'),
DeleteHeaderKeys(qh_key_prefix+'zip.lfmname.key'),
DeleteHeaderKeys(qh_key_prefix+'zip.street_name.prim_range.lfmname.ssn.key'),
//This is the only QH key that also isn't created during full Header Moxie Keybuild
DeleteHeaderKeys(qh_key_prefix+'pos.data.key')
);