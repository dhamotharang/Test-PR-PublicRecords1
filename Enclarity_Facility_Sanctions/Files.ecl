IMPORT ut, Enclarity_Facility_Sanctions, tools;
EXPORT Files(STRING pversion = '', boolean pUseProd = false) := MODULE

   /* Input File Versions */
  export facility_sanctions_input  := dataset(Enclarity_Facility_Sanctions.Filenames(pversion,pUseProd).facility_sanctions_lInputTemplate, Enclarity_Facility_Sanctions.layouts.input.facility_sanctions, csv(separator('|'),quote('')));
	export facility_sanctions_history:= dataset(Enclarity_Facility_Sanctions.Filenames(pversion,pUseProd).facility_sanctions_lInputHistTemplate, Enclarity_Facility_Sanctions.layouts.input.facility_sanctions, csv(separator('|'),quote('')));

	 /* Base File Versions */
   tools.mac_FilesBase(Enclarity_Facility_Sanctions.Filenames(pversion,pUseProd).facility_sanctions_base, Enclarity_Facility_Sanctions.layouts.base.facility_sanctions, facility_sanctions_base);
	 
END;
