import _control;

version := '12299';		// UPDATE EACH TIME
basename := 'SAM_Exclusions_Public_Extract_12299.CSV';
srcdir := '/data/hds_3/sam/';

dest := '~thor::in::epls::sam::';
superfile := '~thor::in::epls::sam';
						
sprayfileTxt(string filename) := 

		FileServices.SprayVariable(_control.IPAddress.bctlpedata10,
							srcdir + filename,
							8192,',','"\n','"',
							_control.TargetGroup.ADL_400,
							dest + version,
							,,,true,true,false
						);
						
 SEQUENTIAL(
	FileServices.ClearSuperFile(superfile),
 sprayfileTxt(basename),
 FileServices.AddSuperFile(superfile, dest + version)
 );
