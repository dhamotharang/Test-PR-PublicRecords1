
import _control, std;

basename := 'SAM_Exclusions_Public_Extract_';		//12299.CSV';
srcdir := '/hds_3/epls/';

dest := '~thor::in::epls::sam::';
superfile := '~thor::in::epls::sam';
						
SpraySamFile(string version) := 

		FileServices.SprayVariable(_control.IPAddress.edata12,
							srcdir + basename + version + '.CSV',
							8192,',',,'"',
							'thor40_241',		//_control.TargetGroup.ADL_400,
							dest + version,
							,,,true,true,false
						);
						
 
// version is sam extract id
EXPORT SpraySam(string version) := SEQUENTIAL(
		if (NOT STD.File.SuperFileExists(superfile),
				STD.File.CreateSuperFile(superfile));
		SpraySamFile(version);
		STD.File.StartSuperFileTransaction();
			STD.File.ClearSuperFile(superfile);
			STD.File.AddSuperFile(superfile, dest+version);
		STD.File.FinishSuperFileTransaction();
);