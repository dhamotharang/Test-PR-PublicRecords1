import versioncontrol, _control, ut, tools,HMS_SureScripts;
pversion := '20151214';
pUseProd := true;     
spray_Taxonomy  := VersionControl.fSprayInputFiles(HMS_SureScripts.fSpray_HMS_SPEC_To_Taxonomy(pversion,pUseProd));
#workunit('name', 'HMS SureScript Build_HMS_Spec_to_Taxonomy' + pversion);
built := sequential(
	spray_Taxonomy
	,HMS_SureScripts.Create_HMS_Spec_to_Taxonomy_File(pversion, pUseProd).all
	);
	output('All Done');
	