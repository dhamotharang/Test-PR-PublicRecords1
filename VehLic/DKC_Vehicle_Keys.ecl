#workunit('name', 'DKC Vehicle Keys')
import _control;
export DKC_Vehicle_Keys(string version, string moxie_server, string moxie_mount) := function
  new_moxie_server := map(
							moxie_server = 'edata10' => _control.IPAddress.edata10,
							moxie_server = 'edata11' => _control.IPAddress.edata11,
							moxie_server = 'edata11b' => _control.IPAddress.edata11b,
							moxie_server = 'edata14' => _control.IPAddress.edata14,
							moxie_server = 'edata14a' => _control.IPAddress.edata14a,
							moxie_server = 'edata12' => _control.IPAddress.edata12,
							moxie_server
						 );
  
  fileservices.dkc('~thor_data400::key::moxie.mv.fpos.data.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.fpos.data.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.state_origin.vehicle_number.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.state_origin.vehicle_number.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.vehicle_number.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.vehicle_number.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.lic_plate.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.lic_plate.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.state_origin.lic_plate.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.state_origin.lic_plate.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.vin.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.vin.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.reverse_lic_plate.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.reverse_lic_plate.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.state_origin.reverse_lic_plate.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.state_origin.reverse_lic_plate.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.ssn.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.ssn.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.did.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.did.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.dl_number.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.dl_number.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.lfmname.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.lfmname.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.st.lfmname.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.st.lfmname.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.nameasis.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.nameasis.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.st.nameasis.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.st.nameasis.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.z5.street_name.suffix.predir.postdir.prim_range.sec_range.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.z5.street_name.suffix.predir.postdir.prim_range.sec_range.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.z5.prim_name.prim_range.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.z5.prim_name.prim_range.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.zip.dph_lname.fname.mname.lname.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.zip.dph_lname.fname.mname.lname.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.st.dph_lname.fname.mname.lname.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.st.dph_lname.fname.mname.lname.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.dph_lname.fname.mname.lname.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.dph_lname.fname.mname.lname.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.st.city.lfmname.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.st.city.lfmname.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.st.city.nameasis.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.st.city.nameasis.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.st.city.dph_lname.fname.mname.lname.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.st.city.dph_lname.fname.mname.lname.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.cn.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.cn.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.st.cn.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.st.cn.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.st.city.cn.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.st.city.cn.key');
  fileservices.dkc('~thor_data400::key::moxie.mv.bdid.key_'+version, new_moxie_server, moxie_mount+'/both/vehreg.bdid.key');

  return 'DKC of motor vehicle registration keys done';
end;