import std, _control;
EXPORT SprayFullRefresh(string version) := FUNCTION

//srcdir := '/hds_3/gongneustar/FullRefresh/';
srcdir := '/data/data_build_5_2/gongneustar/FullRefresh/';

root := '~thor::in::gong::targus::full::';
sfFull := '~thor::in::gong::targus::full::' + version;
//sfFullPrev := '~thor::in::gong::targus::full::20141130';
ip := _control.IPAddress.bctlpedata10;

//target := 'thor50_dev';				//dataland
target := 'thor400_44';				//production


sprayFile(string filename) := 

		std.File.SprayVariable(_control.IPAddress.bctlpedata10,
							srcdir + version + '/' + filename,
							8192,'|',,'\t',						// pipe delimited, no quote character
							target,
							root + version[1..8] + '::' + filename,
							,,,true,false,true
						);
						

						
fAddToSuper(string pSubName) :=
			STD.File.AddSuperFile(sfFull, root + version[1..8] + '::' + pSubName);

		List := STD.File.RemoteDirectory( _control.IPAddress.bctlpedata10, srcdir + version[1..8] , '*.txt');
		List2 := SORT(List, (integer)REGEXFIND('FullRefresh_\\d+_(\\d+)\\.txt', name, 1)) : GLOBAL(FEW);

						
SprayFiles := 
SEQUENTIAL(
			//The vendor sends us either 9 or 10 files on a monthly basis.
			IF(EXISTS(list(size=0)) OR COUNT(list) < 9,
			FAIL('Empty or missing file detected'),
			NOTHOR(APPLY(List2, SprayFile( name)))));
			
AddToSuperFile := 
		SEQUENTIAL
		(
			//NOTHOR(Std.File.PromoteSuperFileList([sfFull, sfFullPrev])),
			NOTHOR(Std.File.ClearSuperFile(sfFull, false)),
			STD.File.StartSuperFileTransaction(),
				NOTHOR(APPLY(List2, fAddToSuper(name))),
			STD.File.FinishSuperFileTransaction()		
		);
						
						
CreateSuperfile := SEQUENTIAL(
		if (NOT STD.File.SuperFileExists(sfFull),
				STD.File.CreateSuperFile(sfFull));
);


doit :=  SEQUENTIAL
(
	OUTPUT(List2, named('files')),
	sprayFiles,
	CreateSuperfile,
	AddToSuperFile
):
			SUCCESS(FileServices.SendEmail(gong_Neustar.SuccessEmail, 'GONG - Full Refresh Spray Complete', WORKUNIT)),
			Failure(FileServices.SendEmail(gong_Neustar.FailureEmail, 'GONG - Full Refresh Spray Failure',WORKUNIT + '\n' + FAILMESSAGE));

return doit;

END;