IMPORT versioncontrol, _control, ut, tools,HMS_SureScripts;
version := '20151014';
spray_  		 := VersionControl.fSprayInputFiles(HMS_SureScripts.fSpray_Specialty_details(version));
sequential(
spray_
,Create_SpecDetails(version).All
);
