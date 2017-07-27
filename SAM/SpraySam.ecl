
import _control, std;

basename := 'SAM_Exclusions_Public_Extract_';		//12299.CSV';
srcdir := '/hds_3/sam/';

dest := '~thor::in::epls::sam::';
superfile := '~thor::in::epls::sam';
						
SpraySamFile(string version) := 

		FileServices.SprayVariable(_control.IPAddress.edata12,
							srcdir + basename + version + '.CSV',
							12000,',','"\n','"',
							'thor400_30',		//_control.TargetGroup.ADL_400,
							dest + version,
							,,,true,true,false
						);
						
 
// version is sam extract id
EXPORT SpraySam(string version) := SEQUENTIAL(
		if (NOT STD.File.SuperFileExists(superfile),
				STD.File.CreateSuperFile(superfile));
		STD.File.ClearSuperFile(superfile);
		SpraySamFile(version);
		STD.File.StartSuperFileTransaction();
			STD.File.AddSuperFile(superfile, dest+version);
		STD.File.FinishSuperFileTransaction();
);
