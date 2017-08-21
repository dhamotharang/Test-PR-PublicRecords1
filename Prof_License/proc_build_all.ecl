email := fileservices.sendemail('RoxieBuilds@seisint.com','Professional Licenses',
					   'Professional license build complete.\n' +   
					   'Keys thor_data400::key::prolicense_did, ' +
					   'thor_data400::key::proflic_licensenum, and ' +
					   'thor_data400::key::proflic_bdid have been ' +
					   'moved to QA.');

export proc_build_all := sequential(proc_build_base,proc_build_keys, email);