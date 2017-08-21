//Raw professional license files from the ALASKA DEPARTMENT OF COMMERCE AND ECONOMIC DEVELOPMENT

export files_AKS0376 := dataset('~thor_data400::in::proflic_mari::aks0376::using::occlic',Prof_License_Mari.layout_AKS0376.OccLic_src,csv(SEPARATOR(','),quote('"'),heading(1)));
// MODULE

	// export BusLic := dataset('~thor_data400::in::prolic::AKS0376::bus.txt',Prof_License_Mari.layout_AKS0376.BusLic,thor);
	// export OccLic := dataset('~thor_data400::in::prolic::AKS0376::occ.txt',Prof_License_Mari.layout_AKS0376.OccLic,thor);

// END;