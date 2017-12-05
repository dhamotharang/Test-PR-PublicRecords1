import std, _control;
// this will spray one file
EXPORT SprayDailyFile(string version) := FUNCTION

 string lfn := 'DailyFeed_' + version + '.txt';

//srcdir := '/hds_3/gongneustar/Daily/';
srcdir := '/data/data_build_5_2/gongneustar/Daily/';

root := '~thor::in::gong::targus::daily::';
sfDaily := '~thor::in::gong::targus::daily::' + version[1..6]; 
ip := _control.IPAddress.bctlpedata10;

//target := 'thor50_dev02';				//dataland
target := 'thor400_44';				//production

sprayFile(string filename) := 
//OUTPUT(srcdir + version[1..6] + '/' + filename);
		std.File.SprayVariable(ip,
							srcdir + version[1..8] + '/' + filename,
							8192,'|',,'\t',						// pipe delimited, no quote character
							target,
							root + version[1..6] + '::' + filename,
							,,,true,false,true
							);
						
List := STD.File.RemoteDirectory( _control.IPAddress.bctlpedata10, srcdir + version[1..8] , '*.txt');

FileCheck := 
SEQUENTIAL(
			IF(EXISTS(list(size=0)),
			FAIL('Zero byte file detected'),
			NOTHOR(sprayFile(lfn)))
			):

SUCCESS(FileServices.SendEmail(gong_Neustar.SuccessEmail, 'GONG - Daily Spray Complete', WORKUNIT)),
Failure(FileServices.SendEmail(gong_Neustar.FailureEmail, 'GONG - Daily Spray Failure',WORKUNIT + '\n' + FAILMESSAGE));
						
					
AddToSuperFile := 
			STD.File.AddSuperFile(sfDaily, root + version[1..6] + '::' + lfn);

					
						
CreateSuperfile := 
		if (NOT STD.File.SuperFileExists(sfDaily),
				STD.File.CreateSuperFile(sfDaily));

return SEQUENTIAL
(	
	CreateSuperFile,
	FileCheck,
	//sprayFile(lfn),
	AddToSuperFile
);

END;