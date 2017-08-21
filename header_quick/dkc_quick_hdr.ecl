#workunit('name','DKC Quick Headers');
import _control;
export dkc_quick_hdr(string moxie_server, string moxie_mount) := function
  new_moxie_server := map(
							moxie_server = 'edata14' => _control.IPAddress.edata14,
							moxie_server = 'edata12' => _control.IPAddress.edata12,
							moxie_server = 'edata10' => _control.IPAddress.edata10,
							moxie_server
						 );
  
  key1 := fileservices.dkc('~thor_data400::key::moxie.eq_header.fpos.data.key', new_moxie_server, moxie_mount+'/eq_header.fpos.data.key',,,,true);
  key2 := fileservices.dkc('~thor_data400::key::moxie.eq_header.really_long.key', new_moxie_server, moxie_mount+'/eq_header.really_long.key',,,,true);
  key3 := fileservices.dkc('~thor_data400::key::moxie.eq_header.did.key', new_moxie_server, moxie_mount+'/eq_header.did.key',,,,true);
  key4 := fileservices.dkc('~thor_data400::key::moxie.eq_header.ssn.fname.key', new_moxie_server, moxie_mount+'/eq_header.ssn.fname.key',,,,true);
  key5 := fileservices.dkc('~thor_data400::key::moxie.eq_header.lfmname.key', new_moxie_server, moxie_mount+'/eq_header.lfmname.key',,,,true);
  key6 := fileservices.dkc('~thor_data400::key::moxie.eq_header.st.lfmname.key', new_moxie_server, moxie_mount+'/eq_header.st.lfmname.key',,,,true);
  key7 := fileservices.dkc('~thor_data400::key::moxie.eq_header.zip.lfmname.key', new_moxie_server, moxie_mount+'/eq_header.zip.lfmname.key',,,,true);
  key8 := fileservices.dkc('~thor_data400::key::moxie.eq_header.phone7.area_code.st.key', new_moxie_server, moxie_mount+'/eq_header.phone7.area_code.st.key',,,,true);
  key9 := fileservices.dkc('~thor_data400::key::moxie.eq_header.ssn5.lfmname.key', new_moxie_server, moxie_mount+'/eq_header.ssn5.lfmname.key',,,,true);
  key10 := fileservices.dkc('~thor_data400::key::moxie.eq_header.zip.street_name.prim_range.lfmname.ssn.key', new_moxie_server, moxie_mount+'/eq_header.zip.street_name.prim_range.lfmname.ssn.key',,,,true);
  key11 := fileservices.dkc('~thor_data400::key::moxie.eq_header.dob_year.dob_month.dph_lname.lfmname.key', new_moxie_server, moxie_mount+'/eq_header.dob_year.dob_month.dph_lname.lfmname.key',,,,true);
  key12 := fileservices.dkc('~thor_data400::key::moxie.eq_header.st.dob_year.dob_month.dph_lname.lfmname.key', new_moxie_server, moxie_mount+'/eq_header.st.dob_year.dob_month.dph_lname.lfmname.key',,,,true);
  key13 := fileservices.dkc('~thor_data400::key::moxie.eq_header.ssn4.lfmname.key', new_moxie_server, moxie_mount+'/eq_header.ssn4.lfmname.key',,,,true);
  key14 := fileservices.dkc('~thor_data400::key::moxie.eq_header.st.city.lfmname.dob.key', new_moxie_server, moxie_mount+'/eq_header.st.city.lfmname.dob.key',,,,true);
  key15 := fileservices.dkc('~thor_data400::key::moxie.eq_header.st.city.dob.fname.key', new_moxie_server, moxie_mount+'/eq_header.st.city.dob.fname.key',,,,true);
  key16 := fileservices.dkc('~thor_data400::key::moxie.eq_header.st.city.dph_lname.name_first.name_middle.name_last.dob.key', new_moxie_server, moxie_mount+'/eq_header.st.city.dph_lname.name_first.name_middle.name_last.dob.key',,,,true);
  key17 := fileservices.dkc('~thor_data400::key::moxie.eq_header.st.county.lfmname.key', new_moxie_server, moxie_mount+'/eq_header.st.county.lfmname.key',,,,true);
  key18 := fileservices.dkc('~thor_data400::key::moxie.eq_header.st.county.dph_lname.name_first.name_middle.name_last.dob.key', new_moxie_server, moxie_mount+'/eq_header.st.county.dph_lname.name_first.name_middle.name_last.dob.key',,,,true);
	
	// Despray MN SSN suppression keys
	
	/*fileservices.despray('~thor_data400::out::ssn_suppression',new_moxie_server, moxie_mount+'/ssn_suppression.d00',,,,true);
	fileservices.dkc('~thor_data400::key::moxie.ssn_suppression.ssn.key', new_moxie_server, moxie_mount+'/ssn_suppression.ssn.key',,,,true);*/
	
  return sequential(key1,key2,key3,key4,key5,key6,key7,key8,key9,key10,key11,key12,key13,key14,key15,key16,key17,key18);
end;