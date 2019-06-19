import risk_indicators;

EXPORT Boca_Shell_data_build_dates(DATASET (risk_indicators.Layout_Boca_Shell) clam, boolean isFCRA) := function

	// string8 aircraft_build_date := Risk_Indicators.get_Build_date('faa_build_version');
	// string8 watercraft_build_date := Risk_Indicators.get_Build_date('watercraft_build_version');
	// string8 proflic_build_date := Risk_Indicators.get_Build_date('proflic_build_version');
	
	string8 crim_build_date := Risk_Indicators.get_Build_date('doc_build_version');
	prop_string := if(isFCRA, 'FCRA_Property_Build_Version', 'Property_Build_Version');
	string8 property_build_date := Risk_Indicators.get_Build_date(prop_string);
	
	clam_with_dates := project(clam, 
	transform(risk_indicators.layout_boca_shell,
		// aircraft, watercraft and profic are already fetched in their respective sections of the shell
		// self.aircraft_build_date := aircraft_build_date;
		// self.watercraft_build_date := watercraft_build_date;
		// self.proflic_build_date := proflic_build_date;
		self.crim_build_date := crim_build_date;
		self.property_build_date := property_build_date;
		self := left));
		
	return clam_with_dates;
end;

