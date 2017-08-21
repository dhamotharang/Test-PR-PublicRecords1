Import HMS_SureScripts,Versioncontrol;
// Builds the SpeicaltyCodes file used by SureScripts base to decode & populate Specialty Raw codes.
// It uses the weekly ss_Specs.tab file with the Spec_to_pt_20151014 file (contains specialty codes & details
// supplied by Jay.
// 
	FILEDATE:= '20151014';	
	pUseProd := false;
	spray_Specialty  := VersionControl.fSprayInputFiles(fSpray_Specialty(FILEDATE,pUseProd));
	
	sequential(
		spray_Specialty
		,Build_SpecialtyCodes(FILEDATE, pUseProd).Built
		);
