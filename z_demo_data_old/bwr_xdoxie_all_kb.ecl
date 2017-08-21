//header,slimsort, relative, etc keys are all done here

import ut,doxie,header,header_slimsort,address_file, demo_data_scrambler;

#option ('filteredReadSpillThreshold', 9999);

filedate:= header.version_build;	// set date in header.version_build
wuid:=filedate;

h1:= fileservices.clearsuperfile('~thor_data400::base::header');
h1a:= fileservices.clearsuperfile('~thor_data400::base::header_prod');
h2:= fileservices.clearsuperfile('~thor_data400::base::headerkey_building');
h2a:= fileservices.clearsuperfile('~thor_data400::base::headerkey_built');
h3:= fileservices.clearsuperfile('~thor_data400::base::headerprodkey_building');
h4:= output(demo_data_scrambler.scramble_headers,,'~thor::base::demo_data_file_headers'+wuid+'_scrambled',overwrite);
h5:= fileservices.addsuperfile('~thor_data400::base::header','~thor::base::demo_data_file_headers'+wuid+'_scrambled');
h5a:= fileservices.addsuperfile('~thor_data400::base::header_prod','~thor::base::demo_data_file_headers'+wuid+'_scrambled');

r1:= fileservices.clearsuperfile('~thor_data400::base::relatives');
r1a:= fileservices.clearsuperfile('~thor_data400::base::relatives_prod');
r2:= output(demo_data_scrambler.scramble_relatives,,'~thor::base::demo_data_file_relatives'+wuid+'_scrambled',overwrite);
r3:= fileservices.addsuperfile('~thor_data400::base::relatives','~thor::base::demo_data_file_relatives'+wuid+'_scrambled');
r3a:= fileservices.addsuperfile('~thor_data400::base::relatives_prod','~thor::base::demo_data_file_relatives'+wuid+'_scrambled');

make_name:= header_slimsort.Proc_Make_Name_xxx;

build_address:= address_file.proc_build(filedate);	// this may be redundant but it got an error with empty superfile

hh1:=fileservices.clearsuperfile('~thor_data400::base::hhid_prod');	 // this may be redundant but 
hh2:=output(dataset([], header.Layout_HHID),,'~thor_data400::base::hhid_prodwnull',overwrite); // this may be redundant but 
hh3:=fileservices.addsuperfile('~thor_data400::base::hhid_prod','~thor_data400::base::hhid_prodwnull'); // this may be redundant but 
ut.MAC_SF_BuildProcess(header.HHID_Table_Final,'~thor_data400::BASE::HHID',make_hhid,2);

hss1:= fileservices.clearsuperfile('~thor_data400::base::hss_household_prod'); // this may be redundant but 
hss2:= fileservices.clearsuperfile('~thor_data400::base::hss_household'); // this may be redundant but 
hss2a:= fileservices.clearsuperfile('~thor_data400::base::hss_household_father'); // this may be redundant but 
fn_hss_hh := '~thor_data400::base::hss_household_prodwnull'; // this may be redundant but 
d_hss_hh := dataset([],header_slimsort.Layout_household); // this may be redundant but 
hss3:= output(d_hss_hh,,fn_hss_hh,overwrite); // this may be redundant but 
hss4:= fileservices.addsuperfile('~thor_data400::base::hss_household_prod',fn_hss_hh); // this may be redundant but 
hss5:= fileservices.addsuperfile('~thor_data400::base::hss_household',fn_hss_hh); // this may be redundant but 
//
build_keys:=doxie.proc_doxie_keys_all; 		
//
sequential(h1,h1a,h2,h2a,h3,h4,h5,h5a,r1,r1a,r2,r3,r3a,hh1,hh2,hh3,make_hhid,hss1,hss2,hss2a,hss3,hss4,hss5,make_name,build_address,build_keys);
