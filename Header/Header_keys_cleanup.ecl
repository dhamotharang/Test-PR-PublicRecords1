import lib_fileservices;

// Deletes all the Full Header keys 

DeleteHeaderKeys(string KeyFileName)
 :=
  if(lib_fileservices.fileservices.FileExists(KeyFileName),
	 lib_fileservices.FileServices.DeleteLogicalFile(KeyFileName),
	 output(KeyFileName + ' does not exist')
	)
 ;

export Header_keys_cleanup := parallel(

DeleteHeaderKeys('~thor_200::key::moxie.header.did.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.dob.fname.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.dob.lfmname.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.dob_year.dob_month.dph_lname.lfmname.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.dph_lname.name_first.name_middle.name_last.dob.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.fpos.data.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.lfmname.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.phone.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.phone7.area_code.st.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.phone7.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.pln.pr.pst.match.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.pln.z5.match.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.pr.st.pct.match.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.pr.z5.match.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.really_long.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.ssn.fname.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.ssn4.lfmname.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.st.city.dob.fname.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.st.city.dph_lname.name_first.name_middle.name_last.dob.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.st.city.lfmname.dob.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.st.county.dph_lname.name_first.name_middle.name_last.dob.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.st.county.lfmname.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.st.dob.fname.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.st.dob_year.dob_month.dph_lname.lfmname.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.st.dph_lname.name_first.name_middle.name_last.dob.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.st.lfmname.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.st.phone7.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.st.pln.match.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.st.pln.pct.match.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.uniqueid.rec_type.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.zip.dob.fname.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.zip.dph_lname.name_first.name_middle.name_last.dob.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.zip.lfmname.key'),
DeleteHeaderKeys('~thor_200::key::moxie.header.zip.street_name.prim_range.lfmname.ssn.key'));