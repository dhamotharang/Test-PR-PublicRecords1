IMPORT versioncontrol;

EXPORT Files(STRING pversion = '') := MODULE

   /* Input File Versions */
   versioncontrol.macInputFileVersions(Filenames('certification',pversion).input, layouts_certification.Input, cert_input,'CSV',,'\n','|',1,40000);
	 versioncontrol.macInputFileVersions(Filenames('policy',pversion).input,        layouts_policy.Input,        pol_input ,'CSV',,'\n','|',1,40000);
	 	 
	 /* Base File Versions */
   versioncontrol.macBuildFileVersions(Filenames('Certification',pversion).Base, layouts_certification.Base, base_cert);
	 versioncontrol.macBuildFileVersions(Filenames('Policy',pversion).Base,        layouts_policy.Base,        Base_pol);
	 
	/* Keybuild File */
   versioncontrol.macBuildFileVersions(Filenames('Certification',pversion).keybuild, layouts_certification.keybuild, keybuild_cert); 
	 versioncontrol.macBuildFileVersions(Filenames('Policy',pversion).keybuild,        layouts_policy.keybuild,        keybuild_pol);
	 
END;