import ut,doxie_files,doxie_cbrs;

Prof_License.MAC_SK_BuildProcess_v2(doxie_files.key_proflic_did,'~thor_data400::key::proflic::'+ Prof_License.version +'::did','~thor_Data400::key::prolicense_did',b)
Prof_License.MAC_SK_BuildProcess_v2(doxie_files.key_proflic_did_fcra,'~thor_data400::key::fcra::proflic::'+ Prof_License.version +'::did','~thor_Data400::key::fcra::prolicense_did',h)
Prof_License.MAC_SK_BuildProcess_v2(doxie_files.key_proflic_licensenum,'~thor_data400::key::proflic::'+ Prof_License.version +'::licensenum','~thor_data400::key::proflic_licensenum',c)
Prof_License.MAC_SK_BuildProcess_v2(doxie_files.key_proflic_bdid,'~thor_data400::key::proflic::'+ Prof_License.version +'::bdid','~thor_data400::key::proflic_bdid',d);
Prof_License.MAC_SK_BuildProcess_v2(doxie_cbrs.key_addr_proflic,'~thor_data400::key::proflic::'+ Prof_License.version +'::cbrs.addr','~thor_data400::key::cbrs.addr_proflic',kap)

ut.mac_sk_move_v2('~thor_data400::key::prolicense_did','Q',e,2);
ut.mac_sk_move_v2('~thor_data400::key::fcra::prolicense_did','Q',i,2);
ut.mac_sk_move_v2('~thor_data400::key::proflic_licensenum','Q',f,2);
ut.MAC_SK_Move_v2('~thor_data400::key::proflic_bdid','Q',g,2);
ut.MAC_SK_Move_v2('~thor_data400::key::cbrs.addr_proflic','Q', kap2,2);

/* **ROXIE KEY NOTIFICATION EMAIL********************************************************************************************************** */	
email := fileservices.sendemail('RoxieBuilds@seisint.com ; vniemela@seisint.com ; snarra@seisint.com',
								 
								'PROFESSIONAL LICENSES: BUILD SUCCESS '+ Prof_License.version ,
								'keys: 1) thor_data400::key::proflic_licensenum_qa(thor_data400::key::proflic::'+ Prof_License.version +'::licensenum),\n' +
								'      2) thor_data400::key::proflic_bdid_qa(thor_data400::key::proflic::'+ Prof_License.version +'::bdid),\n' +
								'      3) thor_data400::key::prolicense_did_qa(thor_data400::key::proflic::'+ Prof_License.version +'::did),\n' +
								'      4) thor_data400::key::cbrs.addr_proflic_qa(thor_data400::key::proflic::'+ Prof_License.version +'::cbrs.addr),\n' +
								'      have been built and ready to be deployed to QA.'); 
			

/* ***************************************************************************************************************************************** */

		

export proc_build_roxie_keys :=  if (fileservices.getsuperfilesubname('~thor_data400::base::prof_licenses',1) = fileservices.getsuperfilesubname('~thor_data400::base::prof_licenses_BUILT',1),
		output('BASE = BUILT, Nothing done.'),
		sequential(b,h,c,d,kap,e,i,f,g,kap2,email));