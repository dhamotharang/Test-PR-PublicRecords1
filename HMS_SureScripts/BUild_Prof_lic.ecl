import versioncontrol, _control, ut, tools,HMS_SureScripts;
pversion := '20151117';
pProd := false;     
#workunit('name', 'HMS SureScript Build Prof_Lic File' + pversion);
	MyFile := HMS_SureScripts.StandardizeProfLicFile(pversion, pprod).base;
	output(MyFile,,'~Thor400_Data::BASE::HMS::SureScripts::Prof_Licenses::' + 'ProfLic_Taxonomy', Compressed, overwrite,THOR);
