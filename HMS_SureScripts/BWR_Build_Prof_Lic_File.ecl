import versioncontrol, _control, ut, tools,HMS_SureScripts;
pversion := '20151117';
pProd := false;     
#workunit('name', 'HMS SureScript Build Prof_Lic File' + pversion);
spray_  		 := VersionControl.fSprayInputFiles(fSpray_profLic(pversion,pProd));

built := sequential(
	spray_
	,Build_prof_Lic
);