import versioncontrol;

export Files(string pversion = '') := module

   //////////////////////////////////////////////////////////////////
   // -- Input File Versions
   //////////////////////////////////////////////////////////////////
   versioncontrol.macInputFileVersions(Filenames('accident',pversion).input, layouts_accident.input, accident_input,'CSV',,'\n','|',1,40000);
	 versioncontrol.macInputFileVersions(Filenames('contractor',pversion).input, layouts_contractor.input, contractor_input,'CSV',,'\n','|',1,40000);	   
	 versioncontrol.macInputFileVersions(Filenames('contractor_cy_employment',pversion).input, layouts_contractor_cy_employment.input, contractor_cy_employment_input,'CSV',,'\n','|',1,40000);
	 versioncontrol.macInputFileVersions(Filenames('contractor_qt_employment',pversion).input, layouts_contractor_qt_employment.input, contractor_qt_employment_input,'CSV',,'\n','|',1,40000);
	 versioncontrol.macInputFileVersions(Filenames('controller_hist',pversion).input, layouts_controller_hist.input, controller_hist_input,'CSV',,'\n','|',1,40000);
	 versioncontrol.macInputFileVersions(Filenames('inspection',pversion).input, layouts_inspection.input, inspection_input,'CSV',,'\n','|',1,40000);
	 versioncontrol.macInputFileVersions(Filenames('mine',pversion).input, layouts_mine.input, mine_input,'CSV',,'\n','|',1,40000);
	 versioncontrol.macInputFileVersions(Filenames('operator_cy_employment',pversion).input, layouts_operator_cy_employment.input, operator_cy_employment_input,'CSV',,'\n','|',1,40000);
	 versioncontrol.macInputFileVersions(Filenames('operator_hist',pversion).input, layouts_operator_hist.input, operator_hist_input,'CSV',,'\n','|',1,40000);
	 versioncontrol.macInputFileVersions(Filenames('operator_qt_employment',pversion).input, layouts_operator_qt_employment.input, operator_qt_employment_input,'CSV',,'\n','|',1,40000);
	 versioncontrol.macInputFileVersions(Filenames('violation',pversion).input, layouts_violation.input, violation_input,'CSV',,'\n','|',1,40000);
	
   //////////////////////////////////////////////////////////////////
   // -- Base File Versions
   //////////////////////////////////////////////////////////////////
   versioncontrol.macBuildFileVersions(Filenames('Base_Accident',pversion).Base, layouts_base_accident.base, base_accident_base);
	 versioncontrol.macBuildFileVersions(Filenames('Base_Contractor',pversion).Base, layouts_base_contractor.base, base_contractor_base);
	 versioncontrol.macBuildFileVersions(Filenames('Base_Events',pversion).Base, layouts_base_events.base, base_events_base);
	 versioncontrol.macBuildFileVersions(Filenames('Base_Mine',pversion).Base, layouts_base_mine.base, base_mine_base);
	 versioncontrol.macBuildFileVersions(Filenames('Base_Operator',pversion).Base, layouts_base_operator.base, base_operator_base);

end;