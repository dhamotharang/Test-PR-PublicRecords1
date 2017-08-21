import _control;

//* Usage: proc_dl_dkc_function('edata12', '/dl_data_16') 

export proc_dl_dkc_function(string moxie_server, string moxie_mount) := function
  new_moxie_server := map(
							moxie_server = 'edata12' => _control.IPAddress.edata12,
							moxie_server
						 );
fileservices.dkc('~thor_200::key::moxie.dl.fpos.data.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.fpos.data.key');  
fileservices.dkc('~thor_200::key::moxie.dl.did.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.did.key');                                                           
fileservices.dkc('~thor_200::key::moxie.dl.dl_number.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.dl_number.key');                                                    
fileservices.dkc('~thor_200::key::moxie.dl.dl_number.old_dl_number.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.dl_number.old_dl_number.key');
fileservices.dkc('~thor_200::key::moxie.dl.dob.fmlname.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.dob.fmlname.key');            
fileservices.dkc('~thor_200::key::moxie.dl.dob.lfmname.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.dob.lfmname.key');                                                 
fileservices.dkc('~thor_200::key::moxie.dl.dob_year.dob_month.dph_lname.lfmname.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.dob_year.dob_month.dph_lname.lfmname.key');
fileservices.dkc('~thor_200::key::moxie.dl.dph_lname.fname.mname.lname.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.dph_lname.fname.mname.lname.key');                                                     
fileservices.dkc('~thor_200::key::moxie.dl.lfmname.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.lfmname.key');
fileservices.dkc('~thor_200::key::moxie.dl.mfname.dob.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.mfname.dob.key');                                                     
fileservices.dkc('~thor_200::key::moxie.dl.old_dl_number.dl_number.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.old_dl_number.dl_number.key');                                        
fileservices.dkc('~thor_200::key::moxie.dl.ssn.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.ssn.key');                                                            
fileservices.dkc('~thor_200::key::moxie.dl.st.city.dph_lname.fname.mname.lname.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.st.city.dph_lname.fname.mname.lname.key');                             
fileservices.dkc('~thor_200::key::moxie.dl.sex_flag.race.age.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.sex_flag.race.age.key');                                              
fileservices.dkc('~thor_200::key::moxie.dl.st.city.lfmname.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.st.city.lfmname.key');                                                
fileservices.dkc('~thor_200::key::moxie.dl.st.dob_year.dob_month.dph_lname.lfmname.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.st.dob_year.dob_month.dph_lname.lfmname.key');                        
fileservices.dkc('~thor_200::key::moxie.dl.st.dph_lname.fname.mname.lname.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.st.dph_lname.fname.mname.lname.key');                                 
fileservices.dkc('~thor_200::key::moxie.dl.st.lfmname.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.st.lfmname.key');                                                     
fileservices.dkc('~thor_200::key::moxie.dl.st.prim_name.prim_range.lfmname.city.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.st.prim_name.prim_range.lfmname.city.key');                           
fileservices.dkc('~thor_200::key::moxie.dl.z5.prim_name.prim_range.lfmname.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.z5.prim_name.prim_range.lfmname.key');                                
fileservices.dkc('~thor_200::key::moxie.dl.z5.street_name.suffix.predir.postdir.prim_range.lname.sec_range.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.z5.street_name.suffix.predir.postdir.prim_range.lname.sec_range.key');
fileservices.dkc('~thor_200::key::moxie.dl.zip.dph_lname.fname.mname.lname.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.zip.dph_lname.fname.mname.lname.key');                                
fileservices.dkc('~thor_200::key::moxie.dl.zip.lfmname.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.zip.lfmname.key');                                                    
fileservices.dkc('~thor_200::key::moxie.dl.st.county.lfmname.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.st.county.lfmname.key');                                              
fileservices.dkc('~thor_200::key::moxie.dl.st.county.dph_lname.fname.mname.lname.dob.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.st.county.dph_lname.fname.mname.lname.dob.key');                      
fileservices.dkc('~thor_200::key::moxie.dl.state_origin.dl_number.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.state_origin.dl_number.key');                                         
fileservices.dkc('~ thor_200::key::moxie.dl.state_origin.lic_issue_date.key', new_moxie_server, moxie_mount+'/drivers_license/both/drivers_license.state_origin.lic_issue_date.key');  
  return 'DKC of DL ' + drivers.Version_Development +' done';
end;