import versioncontrol;

export fOldBase2NewLayout(

	 dataset(Layout_BusReg_Temp)	pOldBase = File_BusReg_Base
	,string												pversion

) :=
function


	dOldFileInNewFormat := Standardize_Old_File.fall(pOldBase);

	VersionControl.macBuildNewLogicalFile(

		 filenames(pversion).base.full.new				
		,dOldFileInNewFormat				
		,Build_Full_File						

	);
	
	return Build_Full_File;
	
end;