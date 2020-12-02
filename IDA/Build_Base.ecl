//Defines full build process
import _control, versioncontrol,IDA,std;

EXPORT Build_Base(string pversion='',boolean	pUseProd=false, boolean	pDaily=true
	,dataset(IDA.Layouts.Base)	pBaseFile						= IDA.Files().base.qa									
) :=
module

shared version      :=if(pversion='',trim((string8)std.date.today()),pversion):INDEPENDENT;

shared	daily_base        := IDA.Update_Base      (version, pUseProd, true);
shared	accumulative_base := IDA.Update_Base      (version, pUseProd, false);
	 
export buildbase    := IF(pDaily,daily_base,accumulative_base);



	VersionControl.macBuildNewLogicalFile( 
																				 if(pDaily,IDA.Filenames(version,pUseProd).BaseDaily.new,IDA.Filenames(version,pUseProd).base.new)	
																				,buildbase
																				,Build_Base_File
																			 );
																			 
export full_build :=
		sequential(Build_Base_File
							,IDA.Promote(version,pUseProd,pDaily).BuildDailyFiles.New2Built
							,IDA.Promote(version,pUseProd,pDaily).BuildDailyFiles.Built2QA
							,IDA.Promote(version,pUseProd,pDaily).BuildAccumulativefiles.New2Built
							,IDA.Promote(version,pUseProd,pDaily).BuildAccumulativefiles.Built2QA
);

export All :=
		if(VersionControl.IsValidVersion(version)
			,full_build
			,output('No Valid version parameter passed, skipping build')
		);

end;

