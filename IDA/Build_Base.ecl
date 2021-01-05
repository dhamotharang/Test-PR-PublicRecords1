//Defines full build process
import _control, versioncontrol,IDA,std;

EXPORT Build_Base(string pversion='',boolean	pUseProd=false, boolean	pDaily=true
	,dataset(IDA.Layouts.Base)	pBaseFile						= IDA.Files().base.qa									
) :=
module

shared version:=IDA._Constants(pUseProd).filesdate:INDEPENDENT;

shared	daily_base        := IDA.Update_Base      (version, pUseProd, true);
// shared	accumulative_base := IDA.Update_Base      (version, pUseProd, false);
	 
// export buildbase    := IF(pDaily,daily_base,accumulative_base);

	VersionControl.macBuildNewLogicalFile( 
																				 IDA.Filenames(version,pUseProd).BaseDaily.new	
																				,daily_base
																				,Build_Daily_Base_File
																			 )

    

    export full_build :=
		sequential(Build_Daily_Base_File
		          ,STD.File.StartSuperFileTransaction()
				  ,STD.File.Addsuperfile('~thor_data400::base::ida::daily::qa','~thor_data400::base::ida::daily::built',,TRUE)
				  ,STD.File.ClearSuperfile('~thor_data400::base::ida::daily::built')
                  ,STD.File.AddSuperFile('~thor_data400::base::ida::daily::built', IDA.Filenames(version,pUseProd).BaseDaily.new)
				  ,STD.File.FinishSuperFileTransaction()

);

// 	VersionControl.macBuildNewLogicalFile( 
// 																				 if(pDaily,IDA.Filenames(version,pUseProd).BaseDaily.new,IDA.Filenames(version,pUseProd).base.new)	
// 																				,buildbase
// 																				,Build_Base_File
// 																			 );
																			 
// export full_build :=
// 		sequential(Build_Base_File
// 							,IDA.Promote(version,pUseProd,pDaily).BuildDailyFiles.New2Built
// 							,IDA.Promote(version,pUseProd,pDaily).BuildDailyFiles.Built2QA
							// ,IDA.Promote(version,pUseProd,pDaily).BuildAccumulativefiles.New2Built
							// ,IDA.Promote(version,pUseProd,pDaily).BuildAccumulativefiles.Built2QA
// );

export All :=
		if(IDA._Constants(pUseProd).IsValidversion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping build')
		);

end;

