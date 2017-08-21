import _control;
export SprayAccuityFiles(string versiondate) := FUNCTION


srcdir := '/data/stub_cleaning/accuity/input/' + versiondate + '/';

dest := '~thor_200::in::accuity::' + versiondate +'::gwl::';
sprayfile(string filename, string rowtag) := 

		FileServices.SprayXml(_control.IPAddress.bctlpedata10,
							srcdir + filename,
							150000,
							rowtag,,
							'thor400_44',
							dest + stringlib.stringtolowercase(filename),
							,,,true,true,false
						);
						
sprayfileTxt(string filename) := 

		FileServices.SprayVariable(_control.IPAddress.bctlpedata10,
							srcdir + filename,
							4096,'|',,,
							'thor400_44',
							dest + stringlib.stringtolowercase(filename),
							,,,true,true,false
						);
	
sprayfiles := PARALLEL(
					sprayfile('entity.xml','entity'),
					sprayfile('group.xml','group'),
 					sprayfile('srccode.xml','source-code-map'),
 					sprayfileTxt('extractsummary.txt')
				);

sfEntity := '~thor_data400::in::accuity::gwl::entity'; 
sfGroup := '~thor_data400::in::accuity::gwl::group'; 
sfSrcCode := '~thor_data400::in::accuity::gwl::srccode';
sfExtracts := '~thor_data400::in::accuity::extracts'; 
getFilename(string filename) := dest + stringlib.stringtolowercase(filename);
return SEQUENTIAL(
	sprayfiles,
	FileServices.StartSuperFileTransaction( ),
		FileServices.ClearSuperFile(sfEntity, false),
		FileServices.ClearSuperFile(sfGroup, false),
		FileServices.ClearSuperFile(sfSrcCode, false),
		FileServices.ClearSuperFile(sfExtracts, false),
		FileServices.AddSuperFile(sfEntity, getFilename('entity.xml')),
		FileServices.AddSuperFile(sfGroup, getFilename('group.xml')),
		FileServices.AddSuperFile(sfSrcCode, getFilename('srccode.xml')),
		FileServices.AddSuperFile(sfExtracts, getFilename('extractsummary.txt')),
	FileServices.FinishSuperFileTransaction( )
	);

END;